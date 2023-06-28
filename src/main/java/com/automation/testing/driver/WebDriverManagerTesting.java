package com.automation.testing.driver;

import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.edge.EdgeDriver;
import org.openqa.selenium.edge.EdgeOptions;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.firefox.FirefoxOptions;

import io.github.bonigarcia.wdm.WebDriverManager;

public class WebDriverManagerTesting {

	public static void main(String[] args) {
	}

	public void testChromeDriver() {
		try {
			ChromeOptions options = new ChromeOptions();
			options.addArguments("--no-sandbox");
			options.addArguments("--headless");
			options.addArguments("disable-gpu");
			options.addArguments("window-size=1400,2100");
			WebDriverManager.chromedriver().setup();
			WebDriver driver = new ChromeDriver(options);

			driver.get("https://www.google.com/");
			driver.quit();
			System.out.println("CHROME Driver Ran successfully");
			System.out.println("Browser: "+ System.getenv("inputs.browser"));
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException("couldnt create CHROME driver");
		}

	}

	public void testMozillaDriver() {
		try {
			FirefoxOptions options = new FirefoxOptions();
			options.addArguments("--no-sandbox");
			options.addArguments("--headless");
			options.addArguments("disable-gpu");
			options.addArguments("window-size=1400,2100");
			WebDriverManager.firefoxdriver().setup();
			WebDriver driver = new FirefoxDriver(options);

			driver.get("https://www.google.com/");
			driver.quit();
			System.out.println("MOZILLA Driver Ran successfully");
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException("couldnt create MOZILLA driver");
		}

	}

	public void testEdgeDriver() {
		try {
			EdgeOptions options = new EdgeOptions();
			options.addArguments("--no-sandbox");
			options.addArguments("--headless");
			options.addArguments("disable-gpu");
			options.addArguments("window-size=1400,2100");
			options.addArguments("--disable-dev-shm-usage");
			options.addArguments("--ignore-ssl-errors=yes");
			options.addArguments("--ignore-certificate-errors");
			WebDriverManager.edgedriver().setup();
			WebDriver driver = new EdgeDriver(options);

			driver.get("https://www.google.com/");
			driver.quit();
			System.out.println("EDGE Driver Ran successfully");
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException("couldnt create EDGE driver");
		}
	}

}
