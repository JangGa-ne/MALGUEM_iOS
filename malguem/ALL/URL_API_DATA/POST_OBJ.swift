//
//  POST_OBJ.swift
//  malguem
//
//  Created by 장 제현 on 2021/04/20.
//

import Foundation

///var <#name#>: String = ""
///func SET_<#name#>(<#name#>: Any) { self.<#name#> = <#name#> as? String ?? "" }

//MARK: 회원정보, 발전소정보
class PLANT_DATA {
    
    var LGT: String = ""
    var PTY: String = ""
    var REH: String = ""
    var RN1: String = ""
    var SKY: String = ""
    var T1H: String = ""
    var UUU: String = ""
    var VEC: String = ""
    var VVV: String = ""
    var WSD: String = ""
    var AIR_TEM: String = ""
    var AS_CALL: String = ""
    var AS_NAME: String = ""
    var BG_NAME: String = ""
    var BG_NO: String = ""
    var C_CODE: String = ""
    var C_HOME: String = ""
    var C_NAME: String = ""
    var CHECKED_STRATION: String = ""
    var DISPLAY: String = ""
    var DUE_DATE: String = ""
    var GCM_ID: String = ""
    var HORI_SUN: String = ""
    var IDX: String = ""
    var INIT_AMOUNT: String = ""
    var INS_CAP: String = ""
    var INS_DATE: String = ""
    var INV_CNT: String = ""
    var INV_COMPANY: String = ""
    var INV_MODEL: String = ""
    var LAST_LOGIN: String = ""
    var LAT: String = ""
    var LNG: String = ""
    var MAC: String = ""
    var MB_ADDRESS: String = ""
    var MB_ID: String = ""
    var MB_LEVEL: String = ""
    var MB_NAME: String = ""
    var MB_PW: String = ""
    var MB_PLATFORM: String = ""
    var MEMO: String = ""
    var MODUL_TEM: String = ""
    var PAY_AMOUNT: String = ""
    var PAY_UPDATED: String = ""
    var P_ADDRESS: String = ""
    var P_CODE: String = ""
    var P_NAME: String = ""
    var P_ORDER: String = ""
    var PM10: String = ""
    var PM25: String = ""
    var REG_DATE: String = ""
    var SAFE_CALL: String = ""
    var SAFE_NAME: String = ""
    var SEND_STEP: String = ""
    var SUNRISE: String = ""
    var SUNSET: String = ""
    var TILT_SUN: String = ""
    var UPDATE_TIME: String = ""
    var WEATHER_STATION: String = ""
    var OBJ_GEN_DAILY: [GEN_DAILY] = []
    
    func SET_LGT(LGT: Any) { self.LGT = LGT as? String ?? "" }
    func SET_PTY(PTY: Any) { self.PTY = PTY as? String ?? "" }
    func SET_REH(REH: Any) { self.REH = REH as? String ?? "" }
    func SET_RN1(RN1: Any) { self.RN1 = RN1 as? String ?? "" }
    func SET_SKY(SKY: Any) { self.SKY = SKY as? String ?? "" }
    func SET_T1H(T1H: Any) { self.T1H = T1H as? String ?? "" }
    func SET_UUU(UUU: Any) { self.UUU = UUU as? String ?? "" }
    func SET_VEC(VEC: Any) { self.VEC = VEC as? String ?? "" }
    func SET_VVV(VVV: Any) { self.VVV = VVV as? String ?? "" }
    func SET_WSD(WSD: Any) { self.WSD = WSD as? String ?? "" }
    func SET_AIR_TEM(AIR_TEM: Any) { self.AIR_TEM = AIR_TEM as? String ?? "" }
    func SET_AS_CALL(AS_CALL: Any) { self.AS_CALL = AS_CALL as? String ?? "" }
    func SET_AS_NAME(AS_NAME: Any) { self.AS_NAME = AS_NAME as? String ?? "" }
    func SET_BG_NAME(BG_NAME: Any) { self.BG_NAME = BG_NAME as? String ?? "" }
    func SET_BG_NO(BG_NO: Any) { self.BG_NO = BG_NO as? String ?? "" }
    func SET_C_CODE(C_CODE: Any) { self.C_CODE = C_CODE as? String ?? "" }
    func SET_C_HOME(C_HOME: Any) { self.C_HOME = C_HOME as? String ?? "" }
    func SET_C_NAME(C_NAME: Any) { self.C_NAME = C_NAME as? String ?? "" }
    func SET_CHECKED_STRATION(CHECKED_STRATION: Any) { self.CHECKED_STRATION = CHECKED_STRATION as? String ?? "" }
    func SET_DISPLAY(DISPLAY: Any) { self.DISPLAY = DISPLAY as? String ?? "" }
    func SET_DUE_DATE(DUE_DATE: Any) { self.DUE_DATE = DUE_DATE as? String ?? "" }
    func SET_GCM_ID(GCM_ID: Any) { self.GCM_ID = GCM_ID as? String ?? "" }
    func SET_HORI_SUN(HORI_SUN: Any) { self.HORI_SUN = HORI_SUN as? String ?? "" }
    func SET_IDX(IDX: Any) { self.IDX = IDX as? String ?? "" }
    func SET_INIT_AMOUNT(INIT_AMOUNT: Any) { self.INIT_AMOUNT = INIT_AMOUNT as? String ?? "" }
    func SET_INS_CAP(INS_CAP: Any) { self.INS_CAP = INS_CAP as? String ?? "" }
    func SET_INS_DATE(INS_DATE: Any) { self.INS_DATE = INS_DATE as? String ?? "" }
    func SET_INV_CNT(INV_CNT: Any) { self.INV_CNT = INV_CNT as? String ?? "" }
    func SET_INV_COMPANY(INV_COMPANY: Any) { self.INV_COMPANY = INV_COMPANY as? String ?? "" }
    func SET_INV_MODEL(INV_MODEL: Any) { self.INV_MODEL = INV_MODEL as? String ?? "" }
    func SET_LAST_LOGIN(LAST_LOGIN: Any) { self.LAST_LOGIN = LAST_LOGIN as? String ?? "" }
    func SET_LAT(LAT: Any) { self.LAT = LAT as? String ?? "" }
    func SET_LNG(LNG: Any) { self.LNG = LNG as? String ?? "" }
    func SET_MAC(MAC: Any) { self.MAC = MAC as? String ?? "" }
    func SET_MB_ADDRESS(MB_ADDRESS: Any) { self.MB_ADDRESS = MB_ADDRESS as? String ?? "" }
    func SET_MB_ID(MB_ID: Any) { self.MB_ID = MB_ID as? String ?? "" }
    func SET_MB_LEVEL(MB_LEVEL: Any) { self.MB_LEVEL = MB_LEVEL as? String ?? "" }
    func SET_MB_NAME(MB_NAME: Any) { self.MB_NAME = MB_NAME as? String ?? "" }
    func SET_MB_PW(MB_PW: Any) { self.MB_PW = MB_PW as? String ?? "" }
    func SET_MB_PLATFORM(MB_PLATFORM: Any) { self.MB_PLATFORM = MB_PLATFORM as? String ?? "" }
    func SET_MEMO(MEMO: Any) { self.MEMO = MEMO as? String ?? "" }
    func SET_MODUL_TEM(MODUL_TEM: Any) { self.MODUL_TEM = MODUL_TEM as? String ?? "" }
    func SET_PAY_AMOUNT(PAY_AMOUNT: Any) { self.PAY_AMOUNT = PAY_AMOUNT as? String ?? "" }
    func SET_PAY_UPDATED(PAY_UPDATED: Any) { self.PAY_UPDATED = PAY_UPDATED as? String ?? "" }
    func SET_P_ADDRESS(P_ADDRESS: Any) { self.P_ADDRESS = P_ADDRESS as? String ?? "" }
    func SET_P_CODE(P_CODE: Any) { self.P_CODE = P_CODE as? String ?? "" }
    func SET_P_NAME(P_NAME: Any) { self.P_NAME = P_NAME as? String ?? "" }
    func SET_P_ORDER(P_ORDER: Any) { self.P_ORDER = P_ORDER as? String ?? "" }
    func SET_PM10(PM10: Any) { self.PM10 = PM10 as? String ?? "" }
    func SET_PM25(PM25: Any) { self.PM25 = PM25 as? String ?? "" }
    func SET_REG_DATE(REG_DATE: Any) { self.REG_DATE = REG_DATE as? String ?? "" }
    func SET_SAFE_CALL(SAFE_CALL: Any) { self.SAFE_CALL = SAFE_CALL as? String ?? "" }
    func SET_SAFE_NAME(SAFE_NAME: Any) { self.SAFE_NAME = SAFE_NAME as? String ?? "" }
    func SET_SEND_STEP(SEND_STEP: Any) { self.SEND_STEP = SEND_STEP as? String ?? "" }
    func SET_SUNRISE(SUNRISE: Any) { self.SUNRISE = SUNRISE as? String ?? "" }
    func SET_SUNSET(SUNSET: Any) { self.SUNSET = SUNSET as? String ?? "" }
    func SET_TILT_SUN(TILT_SUN: Any) { self.TILT_SUN = TILT_SUN as? String ?? "" }
    func SET_UPDATE_TIME(UPDATE_TIME: Any) { self.UPDATE_TIME = UPDATE_TIME as? String ?? "" }
    func SET_WEATHER_STATION(WEATHER_STATION: Any) { self.WEATHER_STATION = WEATHER_STATION as? String ?? "" }
    func SET_OBJ_GEN_DAILY(OBJ_GEN_DAILY: [GEN_DAILY]) { self.OBJ_GEN_DAILY = OBJ_GEN_DAILY }
}


class GEN_DAILY {
    
    var LGT: String = ""
    var PTY: String = ""
    var REH: String = ""
    var RN1: String = ""
    var SKY: String = ""
    var T1H: String = ""
    var UUU: String = ""
    var VEC: String = ""
    var VVV: String = ""
    var WSD: String = ""
    var DATE_TODAY: String = ""
    var GEN_AMOUNT: String = ""
    var GEN_CHECK: String = ""
    var GEN_NOW: String = ""
    var OUT_CHECK: String = ""
    var PM10: String = ""
    var PM25: String = ""
    var PROT_CHECK: String = ""
    
    func SET_LGT(LGT: Any) { self.LGT = LGT as? String ?? "" }
    func SET_PTY(PTY: Any) { self.PTY = PTY as? String ?? "" }
    func SET_REH(REH: Any) { self.REH = REH as? String ?? "" }
    func SET_RN1(RN1: Any) { self.RN1 = RN1 as? String ?? "" }
    func SET_SKY(SKY: Any) { self.SKY = SKY as? String ?? "" }
    func SET_T1H(T1H: Any) { self.T1H = T1H as? String ?? "" }
    func SET_UUU(UUU: Any) { self.UUU = UUU as? String ?? "" }
    func SET_VEC(VEC: Any) { self.VEC = VEC as? String ?? "" }
    func SET_VVV(VVV: Any) { self.VVV = VVV as? String ?? "" }
    func SET_WSD(WSD: Any) { self.WSD = WSD as? String ?? "" }
    func SET_DATE_TODAY(DATE_TODAY: Any) { self.DATE_TODAY = DATE_TODAY as? String ?? "" }
    func SET_GEN_AMOUNT(GEN_AMOUNT: Any) { self.GEN_AMOUNT = GEN_AMOUNT as? String ?? "" }
    func SET_GEN_CHECK(GEN_CHECK: Any) { self.GEN_CHECK = GEN_CHECK as? String ?? "" }
    func SET_GEN_NOW(GEN_NOW: Any) { self.GEN_NOW = GEN_NOW as? String ?? "" }
    func SET_OUT_CHECK(OUT_CHECK: Any) { self.OUT_CHECK = OUT_CHECK as? String ?? "" }
    func SET_PM10(PM10: Any) { self.PM10 = PM10 as? String ?? "" }
    func SET_PM25(PM25: Any) { self.PM25 = PM25 as? String ?? "" }
    func SET_PROT_CHECK(PROT_CHECK: Any) { self.PROT_CHECK = PROT_CHECK as? String ?? "" }
}


class INVERTER_DATA {
    
    var ALITVE: String = ""
    var BG_NAME: String = ""
    var BG_NO: String = ""
    var C_CODE: String = ""
    var C_NAME: String = ""
    var DISPLAY: String = ""
    var GEN_CHECK: String = ""
    var GEN_NOW: String = ""
    var GEN_POWER: String = ""
    var IDX: String = ""
    var IMG_SET: String = ""
    var INPUT_ID: String = ""
    var INV_CAPACITY: String = ""
    var INV_NUM: String = ""
    var INV_TYPE: String = ""
    var IP: String = ""
    var LAST_UPDATE: String = ""
    var MAC: String = ""
    var MB_ID: String = ""
    var OUT_CHECK: String = ""
    var OWNER: String = ""
    var P_ADDRESS: String = ""
    var P_CODE: String = ""
    var P_NAME: String = ""
    var P_ORDER: String = ""
    var PROT_CHECK: String = ""
    var PV_A: String = ""
    var PV_V: String = ""
    var R_A: String = ""
    var RS_V: String = ""
    var S_A: String = ""
    var SET_VOLT: String = ""
    var ST_V: String = ""
    var T_A: String = ""
    var THREE_GEN: String = ""
    var TOTAL_GEN: String = ""
    var TR_V: String = ""
    var YESTER_GEN: String = ""
    
    func SET_ALITVE(ALITVE: Any) { self.ALITVE = ALITVE as? String ?? "" }
    func SET_BG_NAME(BG_NAME: Any) { self.BG_NAME = BG_NAME as? String ?? "" }
    func SET_BG_NO(BG_NO: Any) { self.BG_NO = BG_NO as? String ?? "" }
    func SET_C_CODE(C_CODE: Any) { self.C_CODE = C_CODE as? String ?? "" }
    func SET_C_NAME(C_NAME: Any) { self.C_NAME = C_NAME as? String ?? "" }
    func SET_DISPLAY(DISPLAY: Any) { self.DISPLAY = DISPLAY as? String ?? "" }
    func SET_GEN_CHECK(GEN_CHECK: Any) { self.GEN_CHECK = GEN_CHECK as? String ?? "" }
    func SET_GEN_NOW(GEN_NOW: Any) { self.GEN_NOW = GEN_NOW as? String ?? "" }
    func SET_GEN_POWER(GEN_POWER: Any) { self.GEN_POWER = GEN_POWER as? String ?? "" }
    func SET_IDX(IDX: Any) { self.IDX = IDX as? String ?? "" }
    func SET_IMG_SET(IMG_SET: Any) { self.IMG_SET = IMG_SET as? String ?? "" }
    func SET_INPUT_ID(INPUT_ID: Any) { self.INPUT_ID = INPUT_ID as? String ?? "" }
    func SET_INV_CAPACITY(INV_CAPACITY: Any) { self.INV_CAPACITY = INV_CAPACITY as? String ?? "" }
    func SET_INV_NUM(INV_NUM: Any) { self.INV_NUM = INV_NUM as? String ?? "" }
    func SET_INV_TYPE(INV_TYPE: Any) { self.INV_TYPE = INV_TYPE as? String ?? "" }
    func SET_IP(IP: Any) { self.IP = IP as? String ?? "" }
    func SET_LAST_UPDATE(LAST_UPDATE: Any) { self.LAST_UPDATE = LAST_UPDATE as? String ?? "" }
    func SET_MAC(MAC: Any) { self.MAC = MAC as? String ?? "" }
    func SET_MB_ID(MB_ID: Any) { self.MB_ID = MB_ID as? String ?? "" }
    func SET_OUT_CHECK(OUT_CHECK: Any) { self.OUT_CHECK = OUT_CHECK as? String ?? "" }
    func SET_OWNER(OWNER: Any) { self.OWNER = OWNER as? String ?? "" }
    func SET_P_ADDRESS(P_ADDRESS: Any) { self.P_ADDRESS = P_ADDRESS as? String ?? "" }
    func SET_P_CODE(P_CODE: Any) { self.P_CODE = P_CODE as? String ?? "" }
    func SET_P_NAME(P_NAME: Any) { self.P_NAME = P_NAME as? String ?? "" }
    func SET_P_ORDER(P_ORDER: Any) { self.P_ORDER = P_ORDER as? String ?? "" }
    func SET_PROT_CHECK(PROT_CHECK: Any) { self.PROT_CHECK = PROT_CHECK as? String ?? "" }
    func SET_PV_A(PV_A: Any) { self.PV_A = PV_A as? String ?? "" }
    func SET_PV_V(PV_V: Any) { self.PV_V = PV_V as? String ?? "" }
    func SET_R_A(R_A: Any) { self.R_A = R_A as? String ?? "" }
    func SET_RS_V(RS_V: Any) { self.RS_V = RS_V as? String ?? "" }
    func SET_S_A(S_A: Any) { self.S_A = S_A as? String ?? "" }
    func SET_SET_VOLT(SET_VOLT: Any) { self.SET_VOLT = SET_VOLT as? String ?? "" }
    func SET_ST_V(ST_V: Any) { self.ST_V = ST_V as? String ?? "" }
    func SET_T_A(T_A: Any) { self.T_A = T_A as? String ?? "" }
    func SET_THREE_GEN(THREE_GEN: Any) { self.THREE_GEN = THREE_GEN as? String ?? "" }
    func SET_TOTAL_GEN(TOTAL_GEN: Any) { self.TOTAL_GEN = TOTAL_GEN as? String ?? "" }
    func SET_TR_V(TR_V: Any) { self.TR_V = TR_V as? String ?? "" }
    func SET_YESTER_GEN(YESTER_GEN: Any) { self.YESTER_GEN = YESTER_GEN as? String ?? "" }
}

class CHART_DATA {
    
    var DATE_TODAY: String = ""             // 날짜
    var GEN_AMOUNT: String = ""             // 발전량
    var GEN_HOUR: String = ""               // 시간별
    var GEN_DAY: String = ""                // 일별
    var GEN_MONTH: String = ""              // 월별
    var GEN_YEAR: String = ""               // 연도별
    
    
    func SET_DATE_TODAY(DATE_TODAY: Any) { self.DATE_TODAY = DATE_TODAY as? String ?? "" }
    func SET_GEN_AMOUNT(GEN_AMOUNT: Any) { self.GEN_AMOUNT = GEN_AMOUNT as? String ?? "" }
    func SET_GEN_HOUR(GEN_HOUR: Any) { self.GEN_HOUR = GEN_HOUR as? String ?? "" }
    func SET_GEN_DAY(GEN_DAY: Any) { self.GEN_DAY = GEN_DAY as? String ?? "" }
    func SET_GEN_MONTH(GEN_MONTH: Any) { self.GEN_MONTH = GEN_MONTH as? String ?? "" }
    func SET_GEN_YEAR(GEN_YEAR: Any) { self.GEN_YEAR = GEN_YEAR as? String ?? "" }
}

class AS_DATA {
    
    var AS_CALL: String = ""
    var AS_NAME: String = ""
    var C_CODE: String = ""
    var C_NAME: String = ""
    var DATETIME: String = ""
    var DISPLAY: String = ""
    var EX_CONTENT: String = ""
    var EX_DATE: String = ""
    var FIN_CONTENT: String = ""
    var FIN_DATE: String = ""
    var IDX: String = ""
    var MB_ID: String = ""
    var P_CODE: String = ""
    var P_NAME: String = ""
    var REG_CONTENT: String = ""
    var REG_DATE: String = ""
    var REG_STEP: String = ""
    var SET_CONTENT: String = ""
    var SET_DATE: String = ""
    
    func SET_AS_CALL(AS_CALL: Any) { self.AS_CALL = AS_CALL as? String ?? "" }
    func SET_AS_NAME(AS_NAME: Any) { self.AS_NAME = AS_NAME as? String ?? "" }
    func SET_C_CODE(C_CODE: Any) { self.C_CODE = C_CODE as? String ?? "" }
    func SET_C_NAME(C_NAME: Any) { self.C_NAME = C_NAME as? String ?? "" }
    func SET_DATETIME(DATETIME: Any) { self.DATETIME = DATETIME as? String ?? "" }
    func SET_DISPLAY(DISPLAY: Any) { self.DISPLAY = DISPLAY as? String ?? "" }
    func SET_EX_CONTENT(EX_CONTENT: Any) { self.EX_CONTENT = EX_CONTENT as? String ?? "" }
    func SET_EX_DATE(EX_DATE: Any) { self.EX_DATE = EX_DATE as? String ?? "" }
    func SET_FIN_CONTENT(FIN_CONTENT: Any) { self.FIN_CONTENT = FIN_CONTENT as? String ?? "" }
    func SET_FIN_DATE(FIN_DATE: Any) { self.FIN_DATE = FIN_DATE as? String ?? "" }
    func SET_IDX(IDX: Any) { self.IDX = IDX as? String ?? "" }
    func SET_MB_ID(MB_ID: Any) { self.MB_ID = MB_ID as? String ?? "" }
    func SET_P_CODE(P_CODE: Any) { self.P_CODE = P_CODE as? String ?? "" }
    func SET_P_NAME(P_NAME: Any) { self.P_NAME = P_NAME as? String ?? "" }
    func SET_REG_CONTENT(REG_CONTENT: Any) { self.REG_CONTENT = REG_CONTENT as? String ?? "" }
    func SET_REG_DATE(REG_DATE: Any) { self.REG_DATE = REG_DATE as? String ?? "" }
    func SET_REG_STEP(REG_STEP: Any) { self.REG_STEP = REG_STEP as? String ?? "" }
    func SET_SET_CONTENT(SET_CONTENT: Any) { self.SET_CONTENT = SET_CONTENT as? String ?? "" }
    func SET_SET_DATE(SET_DATE: Any) { self.SET_DATE = SET_DATE as? String ?? "" }
}

class NOTICE_DATA {
    
    var C_CODE: String = ""
    var C_NAME: String = ""
    var DST: String = ""
    var DST_NAME: String = ""
    var DST_PLANT: String = ""
    var FRM: String = ""
    var GCM_KEY: String = ""
    var HTML_CONTENT: String = ""
    var K_NAME: String = ""
    var K_TYPE: String = ""
    var K_URL: String = ""
    var K_URL2: String = ""
    var K_NEXT: String = ""
    var LOGO: String = ""
    var M_GROUP: String = ""
    var ME_LENGTH: String = ""
    var ME_SORT: String = ""
    var MES_ID: String = ""
    var MMS_FILE_1: String = ""
    var MMS_FILE_2: String = ""
    var MMS_FILE_3: String = ""
    var MMS_FILE_4: String = ""
    var MMS_FILE_CNT: String = ""
    var PAR_IMG: String = ""
    var P_CODE: String = ""
    var READ_CHECK: String = ""
    var READ_MES: String = ""
    var RESULT: String = ""
    var SEND_TIME: String = ""
    var SEND_TYPE: String = ""
    var SENDER_ID: String = ""
    var SENDER_IP: String = ""
    var SENDER_KEY: String = ""
    var SUB: String = ""
    var TEXT: String = ""
    var TEXT2: String = ""
    var WR_SCRAP: String = ""
    var WR_SHARE: String = ""
    
    func SET_C_CODE(C_CODE: Any) { self.C_CODE = C_CODE as? String ?? "" }
    func SET_C_NAME(C_NAME: Any) { self.C_NAME = C_NAME as? String ?? "" }
    func SET_DST(DST: Any) { self.DST = DST as? String ?? "" }
    func SET_DST_NAME(DST_NAME: Any) { self.DST_NAME = DST_NAME as? String ?? "" }
    func SET_DST_PLANT(DST_PLANT: Any) { self.DST_PLANT = DST_PLANT as? String ?? "" }
    func SET_FRM(FRM: Any) { self.FRM = FRM as? String ?? "" }
    func SET_GCM_KEY(GCM_KEY: Any) { self.GCM_KEY = GCM_KEY as? String ?? "" }
    func SET_HTML_CONTENT(HTML_CONTENT: Any) { self.HTML_CONTENT = HTML_CONTENT as? String ?? "" }
    func SET_K_NAME(K_NAME: Any) { self.K_NAME = K_NAME as? String ?? "" }
    func SET_K_TYPE(K_TYPE: Any) { self.K_TYPE = K_TYPE as? String ?? "" }
    func SET_K_URL(K_URL: Any) { self.K_URL = K_URL as? String ?? "" }
    func SET_K_URL2(K_URL2: Any) { self.K_URL2 = K_URL2 as? String ?? "" }
    func SET_K_NEXT(K_NEXT: Any) { self.K_NEXT = K_NEXT as? String ?? "" }
    func SET_LOGO(LOGO: Any) { self.LOGO = LOGO as? String ?? "" }
    func SET_M_GROUP(M_GROUP: Any) { self.M_GROUP = M_GROUP as? String ?? "" }
    func SET_ME_LENGTH(ME_LENGTH: Any) { self.ME_LENGTH = ME_LENGTH as? String ?? "" }
    func SET_ME_SORT(ME_SORT: Any) { self.ME_SORT = ME_SORT as? String ?? "" }
    func SET_MES_ID(MES_ID: Any) { self.MES_ID = MES_ID as? String ?? "" }
    func SET_MMS_FILE_1(MMS_FILE_1: Any) { self.MMS_FILE_1 = MMS_FILE_1 as? String ?? "" }
    func SET_MMS_FILE_2(MMS_FILE_2: Any) { self.MMS_FILE_2 = MMS_FILE_2 as? String ?? "" }
    func SET_MMS_FILE_3(MMS_FILE_3: Any) { self.MMS_FILE_3 = MMS_FILE_3 as? String ?? "" }
    func SET_MMS_FILE_4(MMS_FILE_4: Any) { self.MMS_FILE_4 = MMS_FILE_4 as? String ?? "" }
    func SET_MMS_FILE_CNT(MMS_FILE_CNT: Any) { self.MMS_FILE_CNT = MMS_FILE_CNT as? String ?? "" }
    func SET_PAR_IMG(PAR_IMG: Any) { self.PAR_IMG = PAR_IMG as? String ?? "" }
    func SET_P_CODE(P_CODE: Any) { self.P_CODE = P_CODE as? String ?? "" }
    func SET_READ_CHECK(READ_CHECK: Any) { self.READ_CHECK = READ_CHECK as? String ?? "" }
    func SET_READ_MES(READ_MES: Any) { self.READ_MES = READ_MES as? String ?? "" }
    func SET_RESULT(RESULT: Any) { self.RESULT = RESULT as? String ?? "" }
    func SET_SEND_TIME(SEND_TIME: Any) { self.SEND_TIME = SEND_TIME as? String ?? "" }
    func SET_SEND_TYPE(SEND_TYPE: Any) { self.SEND_TYPE = SEND_TYPE as? String ?? "" }
    func SET_SENDER_ID(SENDER_ID: Any) { self.SENDER_ID = SENDER_ID as? String ?? "" }
    func SET_SENDER_IP(SENDER_IP: Any) { self.SENDER_IP = SENDER_IP as? String ?? "" }
    func SET_SENDER_KEY(SENDER_KEY: Any) { self.SENDER_KEY = SENDER_KEY as? String ?? "" }
    func SET_SUB(SUB: Any) { self.SUB = SUB as? String ?? "" }
    func SET_TEXT(TEXT: Any) { self.TEXT = TEXT as? String ?? "" }
    func SET_TEXT2(TEXT2: Any) { self.TEXT2 = TEXT2 as? String ?? "" }
    func SET_WR_SCRAP(WR_SCRAP: Any) { self.WR_SCRAP = WR_SCRAP as? String ?? "" }
    func SET_WR_SHARE(WR_SHARE: Any) { self.WR_SHARE = WR_SHARE as? String ?? "" }
}
