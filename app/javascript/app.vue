<script setup>
import { onBeforeMount, ref, watch } from 'vue'
import { csrfToken } from 'utils/csrf'

const items = ref([])
const cart = ref([])
const selected = ref()
const totalAmount = ref(0)
const cash = ref(0)
const change = ref(0)
const cantTransact = ref(true)

onBeforeMount(async () => {
    const response = await fetch(`items/json`)
    const results = await response.json()
    items.value = results
})

const updateRowTotal = (index) => {
    const currentRow = cart.value[index]

    cart.value[index].total = currentRow.price * currentRow.quantity

    totalAmount.value = cart.value.reduce((acc, c) =>  acc + c.total, 0)
}

const clearAll = () => {
    if (cart.value.length > 0) {
        cart.value = []
        selected.value = null
        totalAmount.value = 0
        cash.value = 0
        cantTransact.value = true
    }
}

const removeFromCart = (index) => {
    cart.value.splice(index, 1)

    totalAmount.value = cart.value.reduce((acc, c) =>  acc + c.total, 0)
}

const onSubmit = async() => {
    try {
        const response = await fetch("pos/transact", {
            method: "POST",
            body: JSON.stringify({
                transaction: {
                    total_amount: totalAmount.value,
                    cash: cash.value,
                    change: change.value,
                    is_void: false
                },
                transaction_details: cart.value
            }),
            headers: {
                "Content-type": "application/json; charset=UTF-8",
                "X-CSRF-Token": csrfToken(),
            }
        })

        const result = await response.json()
        console.log("Success: ", result)
        clearAll()
    } catch (error) {
        console.log("Error Sending data ",error);
    }
}

watch(selected, (newSelected) => {
    const index = cart.value.findIndex(c => c.item_id === newSelected.id)

    if (newSelected) {
        if (index == -1) {
            const item = {
                item_id: newSelected.id,
                name: newSelected.name,
                price: newSelected.price,
                quantity: 1,
                total: newSelected.price
            }

            cart.value.push(item)
        } else {
            const item = {
                item_id: newSelected.id,
                name: newSelected.name,
                price: newSelected.price,
                quantity: cart.value[index].quantity + 1,
                total: (cart.value[index].quantity + 1) * newSelected.price
            }

            cart.value[index] = item
        }
        
        totalAmount.value = cart.value.reduce((acc, c) =>  acc + c.total, 0)
    }
})

watch(cash, (newCash) => {
    if (Number(newCash) > 0 && cart.value.length) {
        cantTransact.value = totalAmount.value > newCash
    } else {
        cantTransact.value = true
    }

    change.value = (newCash - totalAmount.value) > 0 ? (newCash - totalAmount.value) : 0
})
</script>

<template>
  <div id="app">
    <main class="content">
        <div class="container-fluid p-0">
            <form @submit.prevent="onSubmit">
                <div class="row">
                    <div class="col-8">
                        <div class="card">
                            <div class="card-body">
                                <v-select label="name" :options="items" v-model="selected" />
                            </div>
                        </div>
                        <div class="card">
                            <div class="card-body">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th scope="col">Item</th>
                                            <th scope="col">Price</th>
                                            <th scope="col">Qty</th>
                                            <th scope="col">Total</th>
                                            <th></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr v-for="(item, index) in cart">
                                            <th scope="row">{{ item.name }}</th>
                                            <th scope="row">{{ item.price }}</th>
                                            <th scope="row">
                                                <input type="number" class="form-control" v-model="item.quantity" v-bind="item.quantity" @keyup="updateRowTotal(index)" min="1">
                                            </th>
                                            <th scope="row">{{ item.total }}</th>
                                            <th scope="row"><vue-feather type="x" @click="removeFromCart(index)"></vue-feather></th>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>

                    <div class="col-4">
                        <div class="card">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-6">
                                        <p class="fs-4">Total Amt: {{ totalAmount }}</p>
                                    </div>

                                    <div class="col-md-6">
                                        <p class="fs-4">Remaining Amt: {{ (totalAmount - cash) > 0 ? (totalAmount - cash) : 0}}</p>
                                    </div>

                                    <div class="col-md-12">
                                        <p class="fs-3 mt-4">CASH:</p>
                                        <input class="form-control form-control-lg" type="text" v-model="cash">

                                        <p class="fs-3 mt-4">CHANGE: {{ change }}</p>
                                        
                                        <div class="d-grid gap-2">
                                            <button class="btn btn-primary btn-lg" type="submit" :disabled="cantTransact" >TRANSACT</button>
                                            <button class="btn btn-warning btn-lg" type="button" @click="clearAll">CLEAR</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </main>
  </div>
</template>

<style>
    @import "../../node_modules/vue-select/dist/vue-select.css";
</style>
