package com.example.jnuitdemo;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import static org.junit.Assert.*;
public class CalculatorTestAAA {
    private Calculator calc;
    @Before
    public void setUp() {
        calc = new Calculator();
        System.out.println("Setup done.");
    }
    @After
    public void tearDown() {
        System.out.println("Test completed.");
    }
    // Test using Arrange-Act-Assert pattern
    @Test
    public void testAddition() {
        // Arrange
        int a = 2;
        int b = 3;
        // Act
        int result = calc.add(a, b);
        // Assert
        assertEquals(5, result);
    }
    @Test
    public void testSubtraction() {
        // Arrange
        int a = 5;
        int b = 3;
        // Act
        int result = calc.subtract(a, b);
        // Assert
        assertEquals(2, result);
    }
}
