package org.rda.controller;

import java.util.Arrays;
import java.util.List;

import org.rda.pojo.City;
import org.rda.pojo.District;
import org.rda.pojo.RailwayCity;
import org.rda.service.DataAnalyzeService;
import org.rda.service.RailwayDataService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/cluster")
public class cityClusterController {
	@Autowired
	private DataAnalyzeService dataAnalyzeService;
	@Autowired
	private RailwayDataService railwayDataService;
	/**
	 * 展示聚类站点信息
	 * @return
	 */
	@RequestMapping("/optimizedStation")
	public String getDistrictString(Model model){
		List<City> list=railwayDataService.getOptimizedCitys();
		String[] strings=new String[list.size()];
		for(int i=0;i<list.size();i++){
			strings[i]=list.get(i).toString();
		}
		model.addAttribute("stringList",Arrays.toString(strings));
		
		List<District> districts=dataAnalyzeService.getAllDistrict();
		String[] circleList=new String[districts.size()];
		for(int i=0;i<districts.size();i++){
			circleList[i]=districts.get(i).toString();
		}
		model.addAttribute("circleList",Arrays.toString(circleList));
		
		JSONObject returnValue=new JSONObject();
		JSONArray railwayArray=getRailwayJSONArray(dataAnalyzeService.getAllCenterPairs());
		returnValue.put("railways",railwayArray);
		returnValue.put("railwaynum", railwayArray.size());
		model.addAttribute("lines",returnValue.toString());
		
		return "optimizedStation";
	}
	/**
	 * 将航线列表包装为蛤蟆皮指定格式的JSON数组
	 * @param railways
	 * @return
	 */
	public JSONArray getRailwayJSONArray(List<RailwayCity> railways){
		JSONArray railwayJSONArray=new JSONArray();
		for(int i=0;i<railways.size();i++){
			RailwayCity railwayCity=(RailwayCity) railways.get(i);
			JSONObject jsObject=new JSONObject();
			jsObject.put("name", "线路"+i);
			double[][] position={{railwayCity.getFromLongitude(),railwayCity.getFromLatitude()},
								 {railwayCity.getToLongitude(),railwayCity.getToLatitude()}};
			jsObject.put("path", position);
			jsObject.put("tonnage", railwayCity.getTonnage());
			railwayJSONArray.add(jsObject);
		}
		return railwayJSONArray;
	}
}