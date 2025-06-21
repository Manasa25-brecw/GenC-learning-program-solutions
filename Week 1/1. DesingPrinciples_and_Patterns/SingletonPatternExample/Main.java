package singletonPatternExample;

public class Main {
    public static void main(String[] args) {

        // Get the instance and log messages
        Logger logger1 = Logger.getInstance();
        logger1.log("First log message.");

        // Get the instance again and log more messages
        Logger logger2 = Logger.getInstance();
        logger2.log("Second log message.");

        // Verify both references point to the same object
        if (logger1 == logger2) {
            System.out.println("Both loggers are the same instance.");
        } else {
            System.out.println("Different instances exist!");
        }
    }
}
