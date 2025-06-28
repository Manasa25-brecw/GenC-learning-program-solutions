package com.example.jnuitdemo;

import org.junit.Test;
import static org.junit.Assert.*;

public class AssertionsTest {

    @Test
    public void testAssertions() {
        // assertEquals
        assertEquals(5, 2 + 3);

        // assertTrue
        assertTrue(5 > 3);

        // assertFalse
        assertFalse(5 < 3);

        // assertNull
        Object obj1 = null;
        assertNull(obj1);

        // assertNotNull
        Object obj2 = new Object();
        assertNotNull(obj2);
    }
}
