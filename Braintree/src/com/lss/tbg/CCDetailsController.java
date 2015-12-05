/**
 * 
 */
package com.lss.tbg;

import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.braintreegateway.Result;
import com.braintreegateway.Transaction;
import com.lss.tbg.service.BraintreePaymentService;

/**
 * @author ashok.janagam
 *
 */
@Controller
public class CCDetailsController {
	
	@Autowired
	CCDetails ccDetails;
	@Autowired
	BraintreePaymentService brainTreeService;
	Map<String, String> cardTypes = new LinkedHashMap<String, String>();
	Map<String, String> ccMonths = new LinkedHashMap<String, String>();
	Map<String, String> ccYears = new LinkedHashMap<String, String>();
	
	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public ModelAndView renderLoginPage(ModelMap model) {
		cardTypes.put("AmericanExpress", "American Express");
		cardTypes.put("Discover", "Discover");
		cardTypes.put("Mastercard", "Mastercard");
		cardTypes.put("Visa", "Visa");
		cardTypes.put("PayPal", "Pay Pal");
		model.addAttribute("cardTypes", cardTypes);
		ccMonths.put("01","01 - Jan");
		ccMonths.put("02","02 - Feb");
		ccMonths.put("03","03 - Mar");
		ccMonths.put("04","04 - Apr");
		ccMonths.put("05","05 - May");
		ccMonths.put("06","06 - Jun");
		ccMonths.put("07","07 - Jul");
		ccMonths.put("08","08 - Aug");
		ccMonths.put("09","09 - Sep");
		ccMonths.put("10","10 - Oct");
		ccMonths.put("11","11 - Nov");
		ccMonths.put("12","12 - Dec");
		model.addAttribute("ccMonths", ccMonths);
		ccYears.put("01","2015");
		ccYears.put("02","2016");
		ccYears.put("03","2017");
		ccYears.put("04","2018");
		ccYears.put("05","2019");
		ccYears.put("06","2020");
		ccYears.put("07","2021");
		ccYears.put("08","2022");
		ccYears.put("09","2023");
		ccYears.put("10","2024");
		ccYears.put("11","2025");
		ccYears.put("12","2026");
		model.addAttribute("ccYears", ccYears);
		return new ModelAndView("/cc/ccdetails","command",ccDetails);
	}
	
	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public ModelAndView payConfirm(ModelMap model,HttpServletRequest  request) {
		brainTreeService.getClientToken().toString();
		String payment_method_nonce=request.getParameter("payment_method_nonce");
		Result<Transaction> transaction=brainTreeService.getResult(payment_method_nonce);
		System.out.println("Query String "+transaction.isSuccess());
		return new ModelAndView("/cc/payment","command",ccDetails);
	}
	
	@RequestMapping(value = "/braintree", method = RequestMethod.GET)
	public ModelAndView brainTreeForm(ModelMap model) {
		brainTreeService.getClientToken().toString();
		return new ModelAndView("/cc/braintree","command",ccDetails);
	}
	
	@RequestMapping(value = "/payment", method = RequestMethod.GET)
	public ModelAndView payment(ModelMap model) {
		brainTreeService.getClientToken().toString();
		return new ModelAndView("/cc/payment","checkout",ccDetails);
	}
	
	@RequestMapping(value = "/pay", method = RequestMethod.POST)
	public ModelAndView payBrainTree(ModelMap model,HttpServletRequest  request) {
		brainTreeService.getClientToken().toString();
		String payment_method_nonce=request.getParameter("payment_method_nonce");
		Result<Transaction> transaction=brainTreeService.getResult(payment_method_nonce);
		System.out.println("Query String "+transaction.isSuccess());
		return new ModelAndView("/cc/braintree","command",ccDetails);
	}
}