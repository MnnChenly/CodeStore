#import <Foundation/Foundation.h>
#import "Bean.h"
#import "PRODUCT_BO.h"

@class Bulletin_Read_Type;
@class Comm_Obj_Doc_Rel_Type;

/*
	公共阅办类型
*/
@interface Bulletin_Read_Type : JSONObject
@property (nonatomic, readonly) BOOL hasBulletin_CONTENT;
@property (nonatomic, readonly) BOOL hasBulletin_ID;
@property (nonatomic, readonly) BOOL hasStaff_NAME;
@property (nonatomic, readonly) BOOL hasBulletin_TITLE;
@property (nonatomic, readonly) BOOL hasStatus_CD;
@property (nonatomic, readonly) BOOL hasCreate_DATE;
@property (nonatomic, readonly) BOOL hasComm_OBJ_DOC_REL;
@property (nonatomic, readonly) BOOL hasBulletin_READ_ID;
@property (nonatomic, strong) Comm_Obj_Doc_Rel_Type *bulletin_CONTENT;	//公告内容  
@property (nonatomic, assign) BOOL bulletin_ID;	//公告ID  
@property (nonatomic, strong) Product_Type *staff_NAME;	//发布人  
@property (nonatomic, assign) NSInteger bulletin_TITLE;	//公告标题  
@property (nonatomic, copy) NSArray *status_CD;	//状态  
@property (nonatomic, assign) double create_DATE;	//发布时间  
@property (nonatomic, copy) NSArray *comm_OBJ_DOC_REL;	//公告附件关联  
@property (nonatomic, copy) NSString *bulletin_READ_ID;	//公告阅读ID  
- (NSString *)status_CDAtIndex:(NSInteger)index;
- (Comm_Obj_Doc_Rel_Type *)comm_OBJ_DOC_RELAtIndex:(NSInteger)index;
@end

/*
	公告附件关联类型
*/
@interface Comm_Obj_Doc_Rel_Type : JSONObject
@property (nonatomic, readonly) BOOL hasDoc_ID;
@property (nonatomic, readonly) BOOL hasDoc_NAME;
@property (nonatomic, copy) NSString *doc_ID;	//附件ID  
@property (nonatomic, copy) NSString *doc_NAME;	//附件名称  
@end

