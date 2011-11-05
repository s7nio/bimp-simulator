package ee.ut.math.bimp;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class MainPageController {

	private static Logger log = Logger.getLogger(MainPageController.class);

	/**
	 * Default. 
	 * @return
	 */
	@RequestMapping(value = "", method = RequestMethod.GET)
	public String init(ModelMap model, HttpServletRequest request) {

		log.debug("/ requested, sending message");
		model.addAttribute("msg", "It works!");

		return "index";
	}
	
	@RequestMapping(value = "/upload", method = RequestMethod.GET)
	public String upload(ModelMap model) {

		log.debug("/upload requested, sending page");
		return "upload";
	}
	
	@RequestMapping(value = "/help", method = RequestMethod.GET)
	public String help(ModelMap model) {

		log.debug("/help requested, sending page");
		return "help";
	}

	/**
	 * Handles for the logfile download.
	 * Writes the file to the response.
	 */
	@RequestMapping(value = "/file", method = RequestMethod.POST)
	public void getFile(HttpServletRequest request, String download, HttpServletResponse response) {

		ServletOutputStream stream = null;
		BufferedInputStream buf = null;
		HttpSession session = request.getSession();
		String fileName = (String) session.getAttribute("fileName");
		String extension = "";
		if(download.equals("log")) {
			extension = ".mxml.gz";
		}

		response.setContentType("text/xml");
		response.addHeader("Content-Disposition", "attachment; filename="
				+ fileName + extension);
		String path = request.getSession().getServletContext()
				.getRealPath("/tmp/" + fileName + extension);
		File file = new File(path);
		try {
			stream = response.getOutputStream();
			response.setContentLength((int) file.length());
			FileInputStream input = new FileInputStream(file);
			buf = new BufferedInputStream(input);
			int readBytes = 0;
			while ((readBytes = buf.read()) != -1) {
				stream.write(readBytes);
			}
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (stream != null ) {
				try {
					stream.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			if (buf != null) {
				try {
					buf.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}

	}
	
	@RequestMapping(value = "/csv", method = RequestMethod.POST)
	public void getCSV(HttpServletRequest request, HttpServletResponse response) {
		
	}


}
