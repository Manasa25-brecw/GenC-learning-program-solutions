package singletonPatternExample;

public class Logger {

    // Step 2.1: Create a private static variable for single instance
    private static Logger singleInstance;

    // Step 2.2: Private constructor prevents instantiation from other classes
    private Logger() {
        System.out.println("Logger Initialized");
    }

    // Step 2.3: Public method to provide access to the instance
    public static Logger getInstance() {
        if (singleInstance == null) {
            singleInstance = new Logger();  // create the instance only once
        }
        return singleInstance;
    }

    // Step 2.4: A method to log messages
    public void log(String message) {
        System.out.println("Log message: " + message);
    }
}

