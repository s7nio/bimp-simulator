package ee.ut.math.bimp;


import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class FileUploadController {

	private static Logger log = Logger.getLogger(FileUploadController.class);
	
	@RequestMapping(value="/uploadfile", method = RequestMethod.POST)
	public String onSubmit(HttpServletRequest request, UploadItem uploadItem, BindingResult result){

	    if (result.hasErrors())
	    {
	      for(ObjectError error : result.getAllErrors())
	      {
	        log.error("Error: " + error.getCode() +  " - " + error.getDefaultMessage());
	      }
	      return "upload/uploadForm";
	    }
        MultipartFile file = uploadItem.getFileData();
        if (file == null) {
        	log.debug("Nothing was uploaded");
        } else {
        	log.debug("File " + file.getName() + " uploaded.");
        	File ff;
        	File f = new File(request.getSession().getServletContext().getRealPath("/WEB-INF/tmp/"));
        	f.mkdirs();
			try {
				ff = File.createTempFile("in_", ".bpmn", f);
				file.transferTo(ff);
				log.info("Uploaded file: " + ff.getAbsolutePath());
			} catch (IOException e) {
				log.error("Could not create file", e);
			} 
        }

			return "upload";
    }
}

