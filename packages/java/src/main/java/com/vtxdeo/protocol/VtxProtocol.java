package com.vtxdeo.protocol;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.util.stream.Collectors;

/**
 * The carrier class for VTX Protocol WIT definitions.
 */
public class VtxProtocol {

    private static final String WIT_RESOURCE_PATH = "/wit/vtx.wit";

    /**
     * Retrieves the raw content of the bundled vtx.wit file.
     *
     * @return The WIT definition string.
     * @throws IOException If the resource cannot be read or found.
     */
    public static String getWitContent() throws IOException {
        try (InputStream inputStream = VtxProtocol.class.getResourceAsStream(WIT_RESOURCE_PATH)) {
            if (inputStream == null) {
                throw new IOException("WIT definition not found in classpath at: " + WIT_RESOURCE_PATH);
            }
            try (BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream, StandardCharsets.UTF_8))) {
                return reader.lines().collect(Collectors.joining("\n"));
            }
        }
    }

    /**
     * Gets the classpath resource path to the wit file.
     * <p>
     * Note: This returns the internal resource path string, not a filesystem path.
     * To use this file in external tools, you should extract the content using {@link #getWitContent()}.
     * </p>
     *
     * @return The resource path string (e.g., "/wit/vtx.wit").
     */
    public static String getWitResourcePath() {
        return WIT_RESOURCE_PATH;
    }
}