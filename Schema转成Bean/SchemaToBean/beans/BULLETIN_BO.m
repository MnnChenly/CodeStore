#import "BULLETIN_BO.h"

@implementation Bulletin_Read_Type
- (void)setBulletin_CONTENT:(Comm_Obj_Doc_Rel_Type *)bulletin_CONTENT
{
	if (bulletin_CONTENT == nil)
		_hasBulletin_CONTENT = NO;
	else
		_hasBulletin_CONTENT = YES;
	_bulletin_CONTENT = bulletin_CONTENT;
}
- (void)setBulletin_ID:(BOOL)bulletin_ID
{
	_hasBulletin_ID = YES;
	_bulletin_ID = bulletin_ID;
}
- (void)setStaff_NAME:(Product_Type *)staff_NAME
{
	if (staff_NAME == nil)
		_hasStaff_NAME = NO;
	else
		_hasStaff_NAME = YES;
	_staff_NAME = staff_NAME;
}
- (void)setBulletin_TITLE:(NSInteger)bulletin_TITLE
{
	_hasBulletin_TITLE = YES;
	_bulletin_TITLE = bulletin_TITLE;
}
- (void)setStatus_CD:(NSArray *)status_CD
{
	if (status_CD == nil)
		_hasStatus_CD = NO;
	else
		_hasStatus_CD = YES;
	_status_CD = status_CD;
}
- (void)setCreate_DATE:(double)create_DATE
{
	_hasCreate_DATE = YES;
	_create_DATE = create_DATE;
}
- (void)setComm_OBJ_DOC_REL:(NSArray *)comm_OBJ_DOC_REL
{
	if (comm_OBJ_DOC_REL == nil)
		_hasComm_OBJ_DOC_REL = NO;
	else
		_hasComm_OBJ_DOC_REL = YES;
	_comm_OBJ_DOC_REL = comm_OBJ_DOC_REL;
}
- (void)setBulletin_READ_ID:(NSString *)bulletin_READ_ID
{
	if (bulletin_READ_ID == nil)
		_hasBulletin_READ_ID = NO;
	else
		_hasBulletin_READ_ID = YES;
	_bulletin_READ_ID = bulletin_READ_ID;
}
- (NSString *)status_CDAtIndex:(NSInteger)index
{
	return _status_CD[index];
}
- (Comm_Obj_Doc_Rel_Type *)comm_OBJ_DOC_RELAtIndex:(NSInteger)index
{
	return _comm_OBJ_DOC_REL[index];
}
- (NSString *)returnTypeOfArrayProperty:(NSString *)propertyName
{
	if ([propertyName isEqualToString:@"status_CD"]) {
		return @"NSString";
	}
	if ([propertyName isEqualToString:@"comm_OBJ_DOC_REL"]) {
		return @"Comm_Obj_Doc_Rel_Type";
	}
	return nil;
}
@end

@implementation Comm_Obj_Doc_Rel_Type
- (void)setDoc_ID:(NSString *)doc_ID
{
	if (doc_ID == nil)
		_hasDoc_ID = NO;
	else
		_hasDoc_ID = YES;
	_doc_ID = doc_ID;
}
- (void)setDoc_NAME:(NSString *)doc_NAME
{
	if (doc_NAME == nil)
		_hasDoc_NAME = NO;
	else
		_hasDoc_NAME = YES;
	_doc_NAME = doc_NAME;
}
- (NSString *)returnTypeOfArrayProperty:(NSString *)propertyName
{
	return nil;
}
@end

