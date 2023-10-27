<script setup>
import { onBeforeMount, ref, watch } from 'vue'

let items = ref([]);
let cart = ref([]);
let selected = ref();
let totalAmount = ref(0);

onBeforeMount(async () => {
  const response = await fetch(`items/json`);
  const results = await response.json();
  items.value = results;
})


watch(selected, (newSelected) => {
    const index = cart.value.findIndex(c => c.id === newSelected.id);

    if (index == -1) {
        const item = {
            id: newSelected.id,
            name: newSelected.name,
            price: newSelected.price,
            quantity: 1,
            total: newSelected.price
        }

        cart.value.push(item)
    } else {
        const item = {
            id: newSelected.id,
            name: newSelected.name,
            price: newSelected.price,
            quantity: cart.value[index].quantity + 1,
            total: (cart.value[index].quantity + 1) * newSelected.price
        }

        cart.value[index] = item
    }
    

    totalAmount.value = cart.value.reduce((acc, obj) =>  acc + obj.total, 0);
})

watch(
  () => cart,
  (newValue) => {
    console.log(cart.value)
    console.log(newValue.value)
    // Note: `newValue` will be equal to `oldValue` here
    // *unless* state.someObject has been replaced
  },
  { deep: true }
)
</script>

<template>
  <div id="app">
    <main class="content">
        <div class="container-fluid p-0">
            <!-- <p>{{ selected }}</p> -->
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
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr v-for="item in cart">
                                        <th scope="row">{{ item.name }}</th>
                                        <th scope="row">{{ item.price }}</th>
                                        <th scope="row"><input type="number" v-model="item.quantity" min="1"></th>
                                        <th scope="row">{{ item.total }}</th>
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
                                    <p class="fs-4">Remaining Amt: 50.00</p>
                                </div>

                                <div class="col-md-12">
                                    <p class="fs-3 mt-4">CASH:</p>
                                    <input class="form-control form-control-lg" type="text">

                                    <p class="fs-3 mt-4">CHANGE: 10</p>
                                    
                                    <div class="d-grid gap-2">
                                        <button class="btn btn-primary btn-lg" type="button">TRANSACT</button>
                                        <button class="btn btn-warning btn-lg" type="button">CLEAR</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>
  </div>
</template>

<style>
    @import "../../node_modules/vue-select/dist/vue-select.css";
</style>
