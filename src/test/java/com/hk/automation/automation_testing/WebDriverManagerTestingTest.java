package com.hk.automation.automation_testing;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.junit.jupiter.MockitoExtension;

import com.automation.testing.driver.WebDriverManagerTesting;

@ExtendWith(MockitoExtension.class)
public class WebDriverManagerTestingTest {
	
	@Test
	public void test() {
		WebDriverManagerTesting test = new WebDriverManagerTesting();
		test.testChromeDriver();
		test.testEdgeDriver();
		test.testMozillaDriver();
	}
}
