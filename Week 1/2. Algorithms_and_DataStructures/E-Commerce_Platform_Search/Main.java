package com.ecommerce;

import java.util.Arrays;
import java.util.Comparator;

public class Main {

    // Linear Search by product name
    public static Product linearSearch(Product[] products, String targetName) {
        for (Product product : products) {	
            if (product.productName.equalsIgnoreCase(targetName)) {
                return product;
            }
        	}
        return null;
    }

    // Binary Search by product name
    public static Product binarySearch(Product[] products, String targetName) {
        Arrays.sort(products, Comparator.comparing(p -> p.productName.toLowerCase())); // sort before binary search
        int left = 0, right = products.length - 1;
        while (left <= right) {
            int mid = left + (right - left) / 2;
            int cmp = products[mid].productName.compareToIgnoreCase(targetName);
            if (cmp == 0)
                return products[mid];
            else if (cmp < 0)
                left = mid + 1;
            else
                right = mid - 1;
        }
        return null;
    }

    public static void main(String[] args) {
        Product[] products = {
            new Product(101, "Shoes", "Footwear"),
            new Product(102, "T-shirt", "Clothing"),
            new Product(103, "Laptop", "Electronics"),
            new Product(104, "Phone", "Electronics"),
            new Product(105, "Watch", "Accessories")
        };

        System.out.println("🔍 Linear Search for 'Laptop':");
        Product result1 = linearSearch(products, "Laptop");
        System.out.println(result1 != null ? result1 : "Product not found");

        System.out.println("\n🔍 Binary Search for 'Phone':");
        Product result2 = binarySearch(products, "Phone");
        System.out.println(result2 != null ? result2 : "Product not found");
    }
}

