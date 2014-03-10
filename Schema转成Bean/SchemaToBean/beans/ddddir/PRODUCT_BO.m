#import "PRODUCT_BO.h"

@implementation Product_Type
- (void)setProduct_NAME:(NSString *)product_NAME
{
	if (product_NAME == nil)
		_hasProduct_NAME = NO;
	else
		_hasProduct_NAME = YES;
	_product_NAME = product_NAME;
}
- (void)setProd_FUNC_TYPE:(NSString *)prod_FUNC_TYPE
{
	if (prod_FUNC_TYPE == nil)
		_hasProd_FUNC_TYPE = NO;
	else
		_hasProd_FUNC_TYPE = YES;
	_prod_FUNC_TYPE = prod_FUNC_TYPE;
}
- (void)setProduct_ID:(NSString *)product_ID
{
	if (product_ID == nil)
		_hasProduct_ID = NO;
	else
		_hasProduct_ID = YES;
	_product_ID = product_ID;
}
- (void)setExt_PROD_ID:(NSString *)ext_PROD_ID
{
	if (ext_PROD_ID == nil)
		_hasExt_PROD_ID = NO;
	else
		_hasExt_PROD_ID = YES;
	_ext_PROD_ID = ext_PROD_ID;
}
- (void)setExp_DATE:(NSString *)exp_DATE
{
	if (exp_DATE == nil)
		_hasExp_DATE = NO;
	else
		_hasExp_DATE = YES;
	_exp_DATE = exp_DATE;
}
- (void)setHas_PARAM:(NSString *)has_PARAM
{
	if (has_PARAM == nil)
		_hasHas_PARAM = NO;
	else
		_hasHas_PARAM = YES;
	_has_PARAM = has_PARAM;
}
- (void)setEff_DATE:(NSString *)eff_DATE
{
	if (eff_DATE == nil)
		_hasEff_DATE = NO;
	else
		_hasEff_DATE = YES;
	_eff_DATE = eff_DATE;
}
- (void)setProduct_DESC:(NSString *)product_DESC
{
	if (product_DESC == nil)
		_hasProduct_DESC = NO;
	else
		_hasProduct_DESC = YES;
	_product_DESC = product_DESC;
}
- (NSString *)returnTypeOfArrayProperty:(NSString *)propertyName
{
	return nil;
}
@end

@implementation Product_Attr_Type
- (void)setAttr_CD:(NSString *)attr_CD
{
	if (attr_CD == nil)
		_hasAttr_CD = NO;
	else
		_hasAttr_CD = YES;
	_attr_CD = attr_CD;
}
- (void)setExt_ATTR_NBR:(NSString *)ext_ATTR_NBR
{
	if (ext_ATTR_NBR == nil)
		_hasExt_ATTR_NBR = NO;
	else
		_hasExt_ATTR_NBR = YES;
	_ext_ATTR_NBR = ext_ATTR_NBR;
}
- (void)setAttr_LENGTH:(NSString *)attr_LENGTH
{
	if (attr_LENGTH == nil)
		_hasAttr_LENGTH = NO;
	else
		_hasAttr_LENGTH = YES;
	_attr_LENGTH = attr_LENGTH;
}
- (void)setAttr_NAME:(NSString *)attr_NAME
{
	if (attr_NAME == nil)
		_hasAttr_NAME = NO;
	else
		_hasAttr_NAME = YES;
	_attr_NAME = attr_NAME;
}
- (void)setIs_NULLABLE:(NSString *)is_NULLABLE
{
	if (is_NULLABLE == nil)
		_hasIs_NULLABLE = NO;
	else
		_hasIs_NULLABLE = YES;
	_is_NULLABLE = is_NULLABLE;
}
- (void)setAttr_FORMAT:(NSString *)attr_FORMAT
{
	if (attr_FORMAT == nil)
		_hasAttr_FORMAT = NO;
	else
		_hasAttr_FORMAT = YES;
	_attr_FORMAT = attr_FORMAT;
}
- (void)setProduct_ID:(NSString *)product_ID
{
	if (product_ID == nil)
		_hasProduct_ID = NO;
	else
		_hasProduct_ID = YES;
	_product_ID = product_ID;
}
- (void)setAttr_ID:(NSString *)attr_ID
{
	if (attr_ID == nil)
		_hasAttr_ID = NO;
	else
		_hasAttr_ID = YES;
	_attr_ID = attr_ID;
}
- (void)setAttr_DESC:(NSString *)attr_DESC
{
	if (attr_DESC == nil)
		_hasAttr_DESC = NO;
	else
		_hasAttr_DESC = YES;
	_attr_DESC = attr_DESC;
}
- (void)setAttr_VALUE_TYPE:(NSString *)attr_VALUE_TYPE
{
	if (attr_VALUE_TYPE == nil)
		_hasAttr_VALUE_TYPE = NO;
	else
		_hasAttr_VALUE_TYPE = YES;
	_attr_VALUE_TYPE = attr_VALUE_TYPE;
}
- (void)setProd_ATTR_VALUE:(NSArray *)prod_ATTR_VALUE
{
	if (prod_ATTR_VALUE == nil)
		_hasProd_ATTR_VALUE = NO;
	else
		_hasProd_ATTR_VALUE = YES;
	_prod_ATTR_VALUE = prod_ATTR_VALUE;
}
- (void)setDefault_VALUE:(NSString *)default_VALUE
{
	if (default_VALUE == nil)
		_hasDefault_VALUE = NO;
	else
		_hasDefault_VALUE = YES;
	_default_VALUE = default_VALUE;
}
- (Prod_Attr_Value_Type *)prod_ATTR_VALUEAtIndex:(NSInteger)index
{
	return _prod_ATTR_VALUE[index];
}
- (NSString *)returnTypeOfArrayProperty:(NSString *)propertyName
{
	if ([propertyName isEqualToString:@"prod_ATTR_VALUE"]) {
		return @"Prod_Attr_Value_Type";
	}
	return nil;
}
@end

@implementation Prod_Attr_Value_Type
- (void)setAttr_VALUE_ID:(NSString *)attr_VALUE_ID
{
	if (attr_VALUE_ID == nil)
		_hasAttr_VALUE_ID = NO;
	else
		_hasAttr_VALUE_ID = YES;
	_attr_VALUE_ID = attr_VALUE_ID;
}
- (void)setAttr_VALUE_DESC:(NSString *)attr_VALUE_DESC
{
	if (attr_VALUE_DESC == nil)
		_hasAttr_VALUE_DESC = NO;
	else
		_hasAttr_VALUE_DESC = YES;
	_attr_VALUE_DESC = attr_VALUE_DESC;
}
- (void)setAttr_VALUE_NAME:(NSString *)attr_VALUE_NAME
{
	if (attr_VALUE_NAME == nil)
		_hasAttr_VALUE_NAME = NO;
	else
		_hasAttr_VALUE_NAME = YES;
	_attr_VALUE_NAME = attr_VALUE_NAME;
}
- (void)setATTRVALUE:(NSString *)ATTRVALUE
{
	if (ATTRVALUE == nil)
		_hasATTRVALUE = NO;
	else
		_hasATTRVALUE = YES;
	_ATTRVALUE = ATTRVALUE;
}
- (NSString *)returnTypeOfArrayProperty:(NSString *)propertyName
{
	return nil;
}
@end

