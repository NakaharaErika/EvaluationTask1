package dto;

import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Set;

import javax.validation.ConstraintViolation;
import javax.validation.Validation;
import javax.validation.Validator;
import javax.validation.ValidatorFactory;

import jakarta.servlet.http.HttpServletRequest;

public class BeanValidation {
	//伊藤くんのメソッドを拝借しました。
	public static <T, I> Boolean validate (HttpServletRequest request, String key, T bean) {

		// Validator を取得
		ValidatorFactory factory = Validation.buildDefaultValidatorFactory();
        Validator validator = factory.getValidator();

        // バリデーションを実行
        Set<ConstraintViolation<T>> ConstraintViolationResult = validator.validate(bean);

        //バリデーションメッセージを保持するmapをnew
        Map<String, String> violationMap = new LinkedHashMap<String, String>();

         //beanのフィールドをキー、エラーメッセージをバリューとしてMapに追加
        for(ConstraintViolation<T> cv : ConstraintViolationResult){
        	violationMap.put(cv.getPropertyPath().toString(), cv.getMessage());
        }

        //mapの長さが０より大きい場合（validateのアノテーションでいずれかが引っかかった場合）
        if(violationMap.size() > 0) {

        	//beanのフィールドをキー、エラーメッセージをバリューとしてsetAttributeする
        	for(Map.Entry<String, String> violation : violationMap.entrySet()) {
        		request.setAttribute(violation.getKey(), violation.getValue());
        	}

        	//入力された値を保持したbeanを任意のキーでsetAttribute
        	request.setAttribute(key, bean);

        	//入力内容にエラーあり
            return true;
        }

        //入力内容にエラーなし
        return false;

	}
}
