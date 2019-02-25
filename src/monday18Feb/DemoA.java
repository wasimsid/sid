package monday18Feb;

import java.net.MalformedURLException;
import java.net.URL;

import org.openqa.selenium.WebDriver;
import org.openqa.selenium.remote.DesiredCapabilities;
import org.openqa.selenium.remote.RemoteWebDriver;
import org.testng.annotations.Parameters;
import org.testng.annotations.Test;

public class DemoA
{
	@Test
	@Parameters({"Node","browser"})
	
	public void testA(String Node,String browser) throws MalformedURLException
	{
		URL ra=new URL(Node);
		DesiredCapabilities c= new DesiredCapabilities();
		c.setBrowserName(browser);
		WebDriver driver=new RemoteWebDriver(ra,c);
		driver.get("http://www.google.com");
		System.out.println(driver.getTitle());
		//driver.quit();
		
		
	}

}
