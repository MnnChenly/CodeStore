#import <Foundation/Foundation.h>
#import "Bean.h"
#import "COMM.h"

@class Product_Type;
@class Product_Attr_Type;
@class Prod_Attr_Value_Type;

/*
	产品规格类型
*/
@interface Product_Type : JSONObject
@property (nonatomic, readonly) BOOL hasProduct_NAME;
@property (nonatomic, readonly) BOOL hasProd_FUNC_TYPE;
@property (nonatomic, readonly) BOOL hasProduct_ID;
@property (nonatomic, readonly) BOOL hasExt_PROD_ID;
@property (nonatomic, readonly) BOOL hasExp_DATE;
@property (nonatomic, readonly) BOOL hasHas_PARAM;
@property (nonatomic, readonly) BOOL hasEff_DATE;
@property (nonatomic, readonly) BOOL hasProduct_DESC;
@property (nonatomic, copy) NSString *product_NAME;	//产品名称  
@property (nonatomic, copy) NSString *prod_FUNC_TYPE;	//类型  
@property (nonatomic, copy) NSString *product_ID;	//产品规格ID  
@property (nonatomic, copy) NSString *ext_PROD_ID;	//外部编码  
@property (nonatomic, copy) NSString *exp_DATE;	//失效时间  
@property (nonatomic, copy) NSString *has_PARAM;	//是否带参数  
@property (nonatomic, copy) NSString *eff_DATE;	//生效时间  
@property (nonatomic, copy) NSString *product_DESC;	//产品描述  
@end

/*
	产品规格属性类型
*/
@interface Product_Attr_Type : JSONObject
@property (nonatomic, readonly) BOOL hasAttr_CD;
@property (nonatomic, readonly) BOOL hasExt_ATTR_NBR;
@property (nonatomic, readonly) BOOL hasAttr_LENGTH;
@property (nonatomic, readonly) BOOL hasAttr_NAME;
@property (nonatomic, readonly) BOOL hasIs_NULLABLE;
@property (nonatomic, readonly) BOOL hasAttr_FORMAT;
@property (nonatomic, readonly) BOOL hasProduct_ID;
@property (nonatomic, readonly) BOOL hasAttr_ID;
@property (nonatomic, readonly) BOOL hasAttr_DESC;
@property (nonatomic, readonly) BOOL hasAttr_VALUE_TYPE;
@property (nonatomic, readonly) BOOL hasProd_ATTR_VALUE;
@property (nonatomic, readonly) BOOL hasDefault_VALUE;
@property (nonatomic, copy) NSString *attr_CD;	//属性编码  
@property (nonatomic, copy) NSString *ext_ATTR_NBR;	//外部编码  
@property (nonatomic, copy) NSString *attr_LENGTH;	//长度  
@property (nonatomic, copy) NSString *attr_NAME;	//属性名称  
@property (nonatomic, copy) NSString *is_NULLABLE;	//是否非空  
@property (nonatomic, copy) NSString *attr_FORMAT;	//  
@property (nonatomic, copy) NSString *product_ID;	//产品规格ID  
@property (nonatomic, copy) NSString *attr_ID;	//属性规格ID  
@property (nonatomic, copy) NSString *attr_DESC;	//描述  
@property (nonatomic, copy) NSString *attr_VALUE_TYPE;	//  
@property (nonatomic, copy) NSArray *prod_ATTR_VALUE;	//(null)  
@property (nonatomic, copy) NSString *default_VALUE;	//默认值  
- (Prod_Attr_Value_Type *)prod_ATTR_VALUEAtIndex:(NSInteger)index;
@end

/*
	产品属性值类型
*/
@interface Prod_Attr_Value_Type : JSONObject
@property (nonatomic, readonly) BOOL hasAttr_VALUE_ID;
@property (nonatomic, readonly) BOOL hasAttr_VALUE_DESC;
@property (nonatomic, readonly) BOOL hasAttr_VALUE_NAME;
@property (nonatomic, readonly) BOOL hasATTRVALUE;
@property (nonatomic, copy) NSString *attr_VALUE_ID;	//属性值ID  
@property (nonatomic, copy) NSString *attr_VALUE_DESC;	//属性值说明  
@property (nonatomic, copy) NSString *attr_VALUE_NAME;	//属性值名称  
@property (nonatomic, copy) NSString *ATTRVALUE;	//属性值  
@end

