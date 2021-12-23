package examples.users;



import java.util.logging.Level; 

import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.logging.LogEntries;
import org.openqa.selenium.logging.LogEntry;
import org.openqa.selenium.logging.LogType;
import org.openqa.selenium.logging.LoggingPreferences;
import org.openqa.selenium.remote.CapabilityType;


public class Gettoken {

	public static String  get_github_access_token() throws InterruptedException{ 


		String USERNAME_GITHUB ="";
			String PASSWORD_GITHUB="";
			String token=null;
			
			LoggingPreferences preferences = new LoggingPreferences();
			preferences.enable(LogType.PERFORMANCE, Level.ALL);
			ChromeOptions option = new ChromeOptions();
			option.setCapability(CapabilityType.LOGGING_PREFS, preferences);
			option.setCapability("goog:loggingPrefs", preferences);
			option.addArguments();

			System.setProperty("webdriver.chrome.driver", "C:\\Users\\Dell\\Desktop\\Tutorials\\Drivers\\chromedriver.exe");

			ChromeDriver driver = new ChromeDriver(option);
			driver.manage().window().maximize();
			
			 driver.get("https://github.com/login/oauth/authorize?client_id=16d8b43c98c1b2365302");
	       
	       driver.findElement(By.name("login")).sendKeys(USERNAME_GITHUB);
	       driver.findElement(By.name("password")).sendKeys(PASSWORD_GITHUB);
	       driver.findElement(By.name("commit")).click();
	       System.out.println("START");
	       
	       Thread.sleep(3000);
	       
	       driver.navigate().refresh();
	       
	       Thread.sleep(3000);
	       
	       WebElement e =driver.findElement(By.xpath("//*[text()='Red Shirt']"));
	       
	       if(e.isDisplayed()){
	    	   
	       
	     
			LogEntries logs = driver.manage().logs().get(LogType.PERFORMANCE);
			
			String api_network=null;
			
			for (LogEntry entry : logs) {
				
				if(entry.toString().contains("authorization")){
					api_network=entry.toString();
					break;
				}
				
			}	
		
			System.out.println(api_network); //authorization
			
			token = api_network.split("authorization")[1].split("\",")[0].replace("\":\"", "").trim();
			
			
			System.out.println("FINAL ACCESS TOKEN "+token);
			
			
			//DONE WITH GETTING THE ACESS_TOKEN
			
			driver.close();
			driver.quit();
		
	}
       return token;
}    

	
}
