package com.vtxdeo.protocol;

import org.junit.jupiter.api.Test;
import java.io.IOException;

import static org.junit.jupiter.api.Assertions.*;

class VtxProtocolTest {

    @Test
    void testWitContentAccess() throws IOException {
        String content = VtxProtocol.getWitContent();

        assertNotNull(content, "Method returned null, expected string content");
        assertFalse(content.isEmpty(), "Returned content is empty");

        assertTrue(
            content.contains("package vtx:api"),
            "Content does not contain expected 'package vtx:api' signature"
        );
    }

    @Test
    void testResourcePathConstant() {
        assertEquals("/wit/vtx.wit", VtxProtocol.getWitResourcePath());
    }
}