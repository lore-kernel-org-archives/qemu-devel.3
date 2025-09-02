Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 030CDCA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 03:57:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI0X-0007Ln-CF; Mon, 01 Sep 2025 23:48:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI0E-00073C-R1
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:48:15 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI09-0004VQ-8D
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:48:14 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822S6b9030132
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:47:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 IUKjVy/F0OL1P6eje5HVSseC8Dc39hL9ggfvsFUB85E=; b=QTm7iOwmYqE58xMd
 Qoj0vDSL1STfxg1Py0F/z6IWPPbX1lBwH0HPi84RkXYxEPrEzmwVJQBt5yPTRWMe
 +B7n/x6Q07xE/5o9pGxAK+Zj7bRAevFHnKuiTiCOUyvRy6wQb/FDdChsgWnzSdBS
 DL+l8biRzinWJv26eWxDJSoH8tiDd3d2H5bRf5ogQQFiPTuJKXAQyxcmfuRe9eE8
 jr6p6gdjdaJpyOzD00zVkdVwhOPmOyfQ6zdMp1hgQvWmpS2Rhu/JW6VtGpOxQatA
 Jma1xV5hLV8hzqJP6lA8CAzdTEzdKKR8aQ4Pi9/NwtwM/APWThgt4X6aKgaTwbbL
 baExiA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48w8wy26pr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:47:55 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3276af4de80so7143637a91.1
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:47:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756784873; x=1757389673;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IUKjVy/F0OL1P6eje5HVSseC8Dc39hL9ggfvsFUB85E=;
 b=k3qtn+1oxcuqlbNEaV+1dkfTEoWWERdh3DDvQUM5c+B4cYqxYaIBnVkDhRqCexpD4U
 fQjmhoGYuBrNSrfpw6Eaet98anYSHyMwWA7+4+3IiuREqPy/EINu9qZqkENKPmTD0UCH
 kFcrBsRbysj0LTehT6hOviP80Xm1MX32Qcy67TUnsWTBlCtHdGzqWwePEXFjzId85850
 wmpO9kuKgzfBuirZhHvVa7MzT58eVx6OCR1m9s9ukAbqVSbtJcY0YnZcsgzCrHMOA0lD
 cYC+AebQzTYxoQdsTGVhehRwp6sBBxcRzixDbb6qH48SlZ/D13RqDnpI4R590k+YHkZf
 KCCw==
X-Gm-Message-State: AOJu0Yw9AwJB/nPrqTrpPLql/WWLjs2EiDj2vTeyVbSmsKONBUqCifgN
 tvuOCKaD8ynPdoX9LQdVxr8R84XQvOaU3Pb7kLqV0zHCZQOuLJ3vOGxJU6uwgiGJQbVJjy/YFjV
 1uJR0oupa52kxupj6XTiRIFJrvgvb1in6nB93xyRRkdY0vFNMFTLRsVVX1WtSuIEtENeJ
X-Gm-Gg: ASbGnctdZMVbxz60/Ufc6x84Mj56HXcoZEt2C5F94ebU2KXeonf0I2aSitMR+6+Vi2t
 L23pZ7jFpptUILowWqnNbFhdvuYuiuNGTqzmgjZD+i2CoXSASdsK7cs8ts/qMI1TBq2owJ841Z1
 4Gcz8rfMVVseCpVuMFink4iMQ/5RpfqHk0cuK5A5MpFmKGjq7kavKYC0DRkW2Ym//Af/Quaey2I
 kv/UxsUU6jXqgw/MVWmKcpNMMK3skheKf40RG7txqsXZHxPGEuIAIAjQm0Y8pc7zstTdDejuZJj
 Utfs/IDlcRpjPR3qfuPlsy+2/QOmfQMJkPmImyGuvtPEyAhlGO6PkRye4z9VwMMmZZVMzQlVDJE
 DI+9iCgt29Wja
X-Received: by 2002:a17:90b:4b8d:b0:327:b66e:a865 with SMTP id
 98e67ed59e1d1-328156baeb7mr16007918a91.17.1756784872743; 
 Mon, 01 Sep 2025 20:47:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiExc67IfumXTRh2kAqd4FUOvSi9jWvoPAg9zl9eiBiLsU2hgIIVEt4gJfGlH+8z5vhOgQZg==
X-Received: by 2002:a17:90b:4b8d:b0:327:b66e:a865 with SMTP id
 98e67ed59e1d1-328156baeb7mr16007847a91.17.1756784871735; 
 Mon, 01 Sep 2025 20:47:51 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4cd006e2c6sm10633584a12.2.2025.09.01.20.47.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:47:51 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v2 25/40] target/hexagon: Add system reg insns
Date: Mon,  1 Sep 2025 20:47:00 -0700
Message-Id: <20250902034715.1947718-26-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034715.1947718-1-brian.cain@oss.qualcomm.com>
References: <20250902034715.1947718-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Ycq95xRf c=1 sm=1 tr=0 ts=68b668eb cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=xO_In5SO0CKeGArpF-QA:9 a=nJrV9obGcL2yI_u-:21 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 4mXS5Mxu67pcOUxMf-M5OSEqBRBAM-xu
X-Proofpoint-ORIG-GUID: 4mXS5Mxu67pcOUxMf-M5OSEqBRBAM-xu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAxMDEwMSBTYWx0ZWRfX3+KRi0MmxOPu
 6ns2C5j3JsUb7edElYS9ezphVw7P3ipiuvOv4uLTvpWbCgMkO+FuTGi6vNIb0clHIFKadp0DJXq
 egy/5qhcdZJNNJQR3vWzgNveZx5IVq0SEzjJIPcS6nMHwKa/p+K8Z+D+M+GBbv7ZFlCIos+apP9
 GdsM+hlDNuUkVRKNfSFOusv1rio0+ClcaQbGbdt0wJjjqtrxf3FSKt8bSH/xqRfHJ8aM2LE6PZB
 /5CbPrcFdayNEBgBXDZJ/4LFXqqnRtgpP3WLRXdCb2KQ9DMc8iFI2N3GjpVO2dCFWVmgHD8Imlj
 1lEVO92z/+qiscuviP739Kq5HHD1gBxSMGYNmolNTvb/Z7WRbHPoh1dsUrQWJKJEBi3iCtK+Sge
 9DcaOP/B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509010101
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Brian Cain <bcain@quicinc.com>

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/hex_common.py          |  15 +-
 target/hexagon/imported/encode_pp.def | 213 +++++++++++++++------
 target/hexagon/imported/system.idef   | 262 +++++++++++++++++++++++---
 3 files changed, 408 insertions(+), 82 deletions(-)

diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
index fe5263e13f..24139cbe67 100755
--- a/target/hexagon/hex_common.py
+++ b/target/hexagon/hex_common.py
@@ -1237,11 +1237,18 @@ def init_registers():
     for reg in new_regs:
         new_registers[f"{reg.regtype}{reg.regid}"] = reg
 
+def is_new_reg(tag, regid):
+    if regid[0] in "NO":
+        return True
+    return regid[0] == "P" and \
+           f"{regid}N" in semdict[tag] and \
+           f"{regid}V" not in semdict[tag]
+
 def get_register(tag, regtype, regid):
-    if f"{regtype}{regid}V" in semdict[tag]:
-        return registers[f"{regtype}{regid}"]
-    else:
-        return new_registers[f"{regtype}{regid}"]
+    regid = f"{regtype}{regid}"
+    is_new = is_new_reg(tag, regid)
+    reg = new_registers[regid] if is_new else registers[regid]
+    return reg
 
 def helper_ret_type(tag, regs):
     ## If there is a scalar result, it is the return type
diff --git a/target/hexagon/imported/encode_pp.def b/target/hexagon/imported/encode_pp.def
index 0cd30a5e85..37faf62b1b 100644
--- a/target/hexagon/imported/encode_pp.def
+++ b/target/hexagon/imported/encode_pp.def
@@ -1,5 +1,5 @@
 /*
- *  Copyright(c) 2019-2023 Qualcomm Innovation Center, Inc. All Rights Reserved.
+ *  Copyright(c) 2019-2020 Qualcomm Innovation Center, Inc. All Rights Reserved.
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -16,6 +16,7 @@
  */
 
 /*
+ * encode32.def
  * Encodings for 32 bit instructions
  *
  */
@@ -341,6 +342,8 @@ DEF_ENC32(L4_pload##TAG##tnew_abs,ICLASS_LD" 1 11 "OPC"  iiiii  PP110tti  1--ddd
 DEF_ENC32(L4_pload##TAG##fnew_abs,ICLASS_LD" 1 11 "OPC"  iiiii  PP111tti  1--ddddd")
 
 
+
+
 /*               0 000  misc: dealloc,loadw_locked,dcfetch      */
 STD_LD_ENC(bzw4,"0 101")
 STD_LD_ENC(bzw2,"0 011")
@@ -375,6 +378,7 @@ DEF_ANTICLASS32(ICLASS_LD" 1110 000----- PP------ --------",LD_ADDR_POST_REG)
 
 DEF_ENC32(L2_deallocframe,    ICLASS_LD" 000 0 000 sssss PP0----- ---ddddd")
 DEF_ENC32(L4_return,          ICLASS_LD" 011 0 000 sssss PP0000-- ---ddddd")
+
 DEF_ENC32(L4_return_t,        ICLASS_LD" 011 0 000 sssss PP0100vv ---ddddd")
 DEF_ENC32(L4_return_f,        ICLASS_LD" 011 0 000 sssss PP1100vv ---ddddd")
 DEF_ENC32(L4_return_tnew_pt,  ICLASS_LD" 011 0 000 sssss PP0110vv ---ddddd")
@@ -382,15 +386,18 @@ DEF_ENC32(L4_return_fnew_pt,  ICLASS_LD" 011 0 000 sssss PP1110vv ---ddddd")
 DEF_ENC32(L4_return_tnew_pnt, ICLASS_LD" 011 0 000 sssss PP0010vv ---ddddd")
 DEF_ENC32(L4_return_fnew_pnt, ICLASS_LD" 011 0 000 sssss PP1010vv ---ddddd")
 
-DEF_ENC32(L2_loadw_locked,ICLASS_LD" 001 0 000 sssss PP000--- 000ddddd")
-
+/** Load Acquire Store Release Encoding **/
 
+DEF_ENC32(L2_loadw_locked,    ICLASS_LD" 001 0 000 sssss PP000--- 000ddddd")
+DEF_ENC32(L4_loadd_locked,    ICLASS_LD" 001 0 000 sssss PP010--- 000ddddd")
 
 DEF_ENC32(L2_loadw_aq,        ICLASS_LD" 001 0 000 sssss PP001--- 000ddddd")
 DEF_ENC32(L4_loadd_aq,        ICLASS_LD" 001 0 000 sssss PP011--- 000ddddd")
 
-DEF_ENC32(R6_release_at_vi,    ICLASS_ST" 000 01 11sssss PP0ttttt --0011dd")
-DEF_ENC32(R6_release_st_vi,   ICLASS_ST" 000 01 11sssss PP0ttttt --1011dd")
+
+DEF_ENC32(S2_storew_locked,   ICLASS_ST" 000 01 01sssss PP-ttttt ----00dd")
+DEF_ENC32(S4_stored_locked,   ICLASS_ST" 000 01 11sssss PP0ttttt ----00dd")
+
 
 DEF_ENC32(S2_storew_rl_at_vi,  ICLASS_ST" 000 01 01sssss PP-ttttt --0010dd")
 DEF_ENC32(S2_storew_rl_st_vi, ICLASS_ST" 000 01 01sssss PP-ttttt --1010dd")
@@ -398,17 +405,15 @@ DEF_ENC32(S2_storew_rl_st_vi, ICLASS_ST" 000 01 01sssss PP-ttttt --1010dd")
 DEF_ENC32(S4_stored_rl_at_vi,  ICLASS_ST" 000 01 11sssss PP0ttttt --0010dd")
 DEF_ENC32(S4_stored_rl_st_vi, ICLASS_ST" 000 01 11sssss PP0ttttt --1010dd")
 
-DEF_ENC32(L4_loadd_locked,ICLASS_LD" 001 0 000 sssss PP010--- 000ddddd")
-DEF_EXT_SPACE(EXTRACTW,   ICLASS_LD" 001 0 000 iiiii PP0iiiii -01iiiii")
+DEF_ENC32(R6_release_at_vi,    ICLASS_ST" 000 01 11sssss PP0ttttt --0011dd")
+DEF_ENC32(R6_release_st_vi,   ICLASS_ST" 000 01 11sssss PP0ttttt --1011dd")
+
+DEF_EXT_SPACE(EXTRACTW,   ICLASS_LD" 001 0 000 iiiii PP0iiiii 001iiiii")
 DEF_ENC32(Y2_dcfetchbo,   ICLASS_LD" 010 0 000 sssss PP0--iii iiiiiiii")
 
 
 
 
-
-
-
-
 /*******************************/
 /*                             */
 /*                             */
@@ -488,13 +493,17 @@ STD_PST_ENC(rinew, "1 101","10ttt")
 /*                               x bus/cache     */
 /*                                    x store/cache     */
 DEF_ENC32(S2_allocframe,   ICLASS_ST" 000 01 00xxxxx PP000iii iiiiiiii")
-DEF_ENC32(S2_storew_locked,ICLASS_ST" 000 01 01sssss PP-ttttt ----00dd")
-DEF_ENC32(S4_stored_locked,ICLASS_ST" 000 01 11sssss PP0ttttt ----00dd")
+DEF_ENC32(Y5_l2locka,      ICLASS_ST" 000 01 11sssss PP1----- ------dd")
 DEF_ENC32(Y2_dczeroa,      ICLASS_ST" 000 01 10sssss PP0----- --------")
 
 
-DEF_ENC32(Y2_barrier,      ICLASS_ST" 100 00 00----- PP------ 000-----")
+DEF_ENC32(Y2_barrier,          ICLASS_ST" 100 00 00----- PP------ 000-----")
 DEF_ENC32(Y2_syncht,       ICLASS_ST" 100 00 10----- PP------ --------")
+DEF_ENC32(Y2_l2kill,       ICLASS_ST" 100 00 01----- PP-000-- --------")
+DEF_ENC32(Y5_l2gunlock,    ICLASS_ST" 100 00 01----- PP-010-- --------")
+DEF_ENC32(Y5_l2gclean,     ICLASS_ST" 100 00 01----- PP-100-- --------")
+DEF_ENC32(Y5_l2gcleaninv,  ICLASS_ST" 100 00 01----- PP-110-- --------")
+DEF_ENC32(Y2_l2cleaninvidx,ICLASS_ST" 100 00 11sssss PP------ --------")
 
 
 
@@ -502,9 +511,34 @@ DEF_ENC32(Y2_dccleana,     ICLASS_ST" 000 00 00sssss PP------ --------")
 DEF_ENC32(Y2_dcinva,       ICLASS_ST" 000 00 01sssss PP------ --------")
 DEF_ENC32(Y2_dccleaninva,  ICLASS_ST" 000 00 10sssss PP------ --------")
 
-DEF_ENC32(Y4_l2fetch,      ICLASS_ST" 011 00 00sssss PP-ttttt 000-----")
+/* Super */
+DEF_ENC32(Y2_dckill,       ICLASS_ST" 001 00 00----- PP------ --------")
+DEF_ENC32(Y2_dccleanidx,   ICLASS_ST" 001 00 01sssss PP------ --------")
+DEF_ENC32(Y2_dcinvidx,     ICLASS_ST" 001 00 10sssss PP------ --------")
+DEF_ENC32(Y2_dccleaninvidx,ICLASS_ST" 001 00 11sssss PP------ --------")
+
+DEF_ENC32(Y2_dctagw       ,ICLASS_ST" 010 00 00sssss PP-ttttt --------")
+DEF_ENC32(Y2_dctagr       ,ICLASS_ST" 010 00 01sssss PP------ ---ddddd")
+
+DEF_ENC32(Y4_l2tagw       ,ICLASS_ST" 010 00 10sssss PP0ttttt --------")
+DEF_ENC32(Y4_l2tagr       ,ICLASS_ST" 010 00 11sssss PP------ ---ddddd")
+
+DEF_ENC32(Y4_l2fetch,          ICLASS_ST" 011 00 00sssss PP-ttttt 000-----")
+DEF_ENC32(Y5_l2cleanidx,   ICLASS_ST" 011 00 01sssss PP------ --------")
+DEF_ENC32(Y5_l2invidx,     ICLASS_ST" 011 00 10sssss PP------ --------")
+DEF_ENC32(Y5_l2unlocka,    ICLASS_ST" 011 00 11sssss PP------ --------")
 DEF_ENC32(Y5_l2fetch,      ICLASS_ST" 011 01 00sssss PP-ttttt --------")
 
+DEF_ENC32(Y6_l2gcleanpa,   ICLASS_ST" 011 01 01----- PP-ttttt --------")
+DEF_ENC32(Y6_l2gcleaninvpa,ICLASS_ST" 011 01 10----- PP-ttttt --------")
+
+
+
+
+
+
+
+
 /*******************************/
 /*                             */
 /*                             */
@@ -547,13 +581,23 @@ DEF_ENC32(J2_jumprfnewpt, ICLASS_J" 0011  011sssss  PP-11-uu  --------")
 
 DEF_FIELDROW_DESC32(ICLASS_J" 0100 -------- PP------ --------","[#4] (#u8) ")
 DEF_ENC32(J2_trap0,     ICLASS_J" 0100  00------  PP-iiiii  ---iii--")
-DEF_ENC32(J2_pause,     ICLASS_J" 0100  01------  PP-iiiii  ---iii--")
+DEF_ENC32(J2_trap1,     ICLASS_J" 0100  10-xxxxx  PP-iiiii  ---iii--")
+DEF_ENC32(J2_pause,     ICLASS_J" 0100  01----ii  PP-iiiii  ---iii--")
+
+DEF_FIELDROW_DESC32(ICLASS_J" 0101 -------- PP------ --------","[#5] Rd=(Rs) ")
+DEF_ENC32(Y2_icdatar,   ICLASS_J" 0101  101sssss  PP------  ---ddddd")
+DEF_ENC32(Y2_ictagr,    ICLASS_J" 0101  111sssss  PP------  ---ddddd")
+DEF_ENC32(Y2_ictagw,    ICLASS_J" 0101  110sssss  PP0ttttt  --------")
+DEF_ENC32(Y2_icdataw,   ICLASS_J" 0101  110sssss  PP1ttttt  --------")
 
 DEF_FIELDROW_DESC32(ICLASS_J" 0110 -------- PP------ --------","[#6] icop(Rs) ")
 DEF_ENC32(Y2_icinva,    ICLASS_J" 0110  110sssss  PP000---  --------")
+DEF_ENC32(Y2_icinvidx,  ICLASS_J" 0110  110sssss  PP001---  --------")
+DEF_ENC32(Y2_ickill,    ICLASS_J" 0110  110-----  PP010---  --------")
 
 DEF_FIELDROW_DESC32(ICLASS_J" 0111 -------- PP------ --------","[#7] () ")
 DEF_ENC32(Y2_isync,     ICLASS_J" 0111  11000000  PP0---00  00000010")
+DEF_ENC32(J2_rte,       ICLASS_J" 0111  111-----  PP00----  000-----")
 
 /* JUMP */
 DEF_FIELDROW_DESC32(ICLASS_J" 100- -------- PP------ --------","[#8,9] PC=(#r22)")
@@ -591,7 +635,6 @@ DEF_ENC32(J2_callf,     ICLASS_J" 1101  ii1iiiii  PPi-0-uu  iiiiiii-")
 /*******************************/
 
 
-/* EJP: this has to match what we have in htmldocs.py... so I will call it CJ, we can change it */
 DEF_CLASS32(ICLASS_CJ" 0--- -------- PP------ --------",CJ)
 
 DEF_FIELDROW_DESC32(ICLASS_CJ" 00-- -------- -------- --------","[#0-3]  pd=cmp.xx(R,#u5) ; if ([!]p0.new) jump:[h] #s9:2 ")
@@ -738,12 +781,19 @@ DEF_ENC32(J2_jumprltezpt,ICLASS_CR" 0001  11isssss  PPi1iiii  iiiiiii-")
 
 DEF_FIELDROW_DESC32(    ICLASS_CR" 0010  --------  PP------  --------","[#2] Cd=Rs ")
 DEF_ENC32(A2_tfrrcr,    ICLASS_CR" 0010  001sssss  PP------  ---ddddd")
+DEF_ENC32(G4_tfrgrcr,   ICLASS_CR" 0010  000sssss  PP------  ---ddddd")
+DEF_ENC32(Y4_trace,     ICLASS_CR" 0010  010sssss  PP------  000-----")
+DEF_ENC32(Y6_diag,      ICLASS_CR" 0010  010sssss  PP------  001-----")
+DEF_ENC32(Y6_diag0,     ICLASS_CR" 0010  010sssss  PP-ttttt  010-----")
+DEF_ENC32(Y6_diag1,     ICLASS_CR" 0010  010sssss  PP-ttttt  011-----")
 
 DEF_FIELDROW_DESC32(    ICLASS_CR" 0011  --------  PP------  --------","[#3] Cdd=Rss ")
 DEF_ENC32(A4_tfrpcp,    ICLASS_CR" 0011  001sssss  PP------  ---ddddd")
+DEF_ENC32(G4_tfrgpcp,   ICLASS_CR" 0011  000sssss  PP------  ---ddddd")
 
 DEF_FIELDROW_DESC32(    ICLASS_CR" 1000  --------  PP------  --------","[#8] Rdd=Css ")
 DEF_ENC32(A4_tfrcpp,    ICLASS_CR" 1000  000sssss  PP------  ---ddddd")
+DEF_ENC32(G4_tfrgcpp,   ICLASS_CR" 1000  001sssss  PP------  ---ddddd")
 
 DEF_FIELDROW_DESC32(    ICLASS_CR" 1001  --------  PP------  --------","[#9] (#r8,#U10)")
 DEF_ENC32(J2_ploop1si,  ICLASS_CR" 1001  101IIIII  PP-iiiii  IIIii-II")
@@ -754,6 +804,7 @@ DEF_ENC32(J2_loop1i,    ICLASS_CR" 1001  001IIIII  PP-iiiii  IIIii-II")
 
 DEF_FIELDROW_DESC32(    ICLASS_CR" 1010  --------  PP------  --------","[#10] Rd=Cs ")
 DEF_ENC32(A2_tfrcrr,    ICLASS_CR" 1010  000sssss  PP------  ---ddddd")
+DEF_ENC32(G4_tfrgcrr,   ICLASS_CR" 1010  001sssss  PP------  ---ddddd")
 DEF_ENC32(C4_addipc,    ICLASS_CR" 1010  01001001  PP-iiiii  i--ddddd")
 
 
@@ -776,8 +827,66 @@ DEF_ENC32(C4_and_orn,   ICLASS_CR" 1011  1011--ss  PP0---tt  uu----dd")
 DEF_ENC32(C4_or_andn,   ICLASS_CR" 1011  1101--ss  PP0---tt  uu----dd")
 DEF_ENC32(C4_or_orn,    ICLASS_CR" 1011  1111--ss  PP0---tt  uu----dd")
 
-DEF_ENC32(C4_fastcorner9,       ICLASS_CR"1011 0000--ss  PP1---tt 1--1--dd")
-DEF_ENC32(C4_fastcorner9_not,   ICLASS_CR"1011 0001--ss  PP1---tt 1--1--dd")
+DEF_ENC32(C4_fastcorner9,	ICLASS_CR"1011 0000--ss  PP1---tt 1--1--dd")
+DEF_ENC32(C4_fastcorner9_not,	ICLASS_CR"1011 0001--ss  PP1---tt 1--1--dd")
+
+
+
+/* Supervisor CR ops */
+/* Interrupts */
+DEF_FIELDROW_DESC32(   ICLASS_CR" 0100 -------- PP------  --------","[#4] (Rs,Pt)")
+DEF_ENC32(Y2_swi,      ICLASS_CR" 0100 000sssss PP------ 000-----")
+DEF_ENC32(Y2_cswi,     ICLASS_CR" 0100 000sssss PP------ 001-----")
+DEF_ENC32(Y2_iassignw, ICLASS_CR" 0100 000sssss PP------ 010-----")
+DEF_ENC32(Y2_ciad,     ICLASS_CR" 0100 000sssss PP------ 011-----")
+DEF_ENC32(Y2_setimask, ICLASS_CR" 0100 100sssss PP----tt 000-----")
+DEF_ENC32(Y2_setprio,  ICLASS_CR" 0100 100sssss PP----tt 001-----")
+DEF_ENC32(Y4_siad,     ICLASS_CR" 0100 100sssss PP------ 011-----")
+
+DEF_ENC32(Y2_wait,     ICLASS_CR" 0100 010sssss PP------ 000-----")
+DEF_ENC32(Y2_resume,   ICLASS_CR" 0100 010sssss PP------ 001-----")
+DEF_ENC32(Y2_stop,     ICLASS_CR" 0100 011sssss PP------ 000-----")
+DEF_ENC32(Y2_start,    ICLASS_CR" 0100 011sssss PP------ 001-----")
+DEF_ENC32(Y4_nmi,      ICLASS_CR" 0100 011sssss PP------ 010-----")
+
+DEF_FIELDROW_DESC32(   ICLASS_CR" 0101 -------- PP------  --------","[#5] Rx ")
+DEF_ENC32(Y2_crswap0,  ICLASS_CR" 0101 000xxxxx PP------ --------")
+DEF_ENC32(Y4_crswap1,  ICLASS_CR" 0101 001xxxxx PP------ --------")
+
+DEF_FIELDROW_DESC32(   ICLASS_CR" 0110 -------- PP------  --------","[#6] Rd=(Rs)")
+DEF_ENC32(Y2_getimask, ICLASS_CR" 0110 000sssss PP------ ---ddddd")
+DEF_ENC32(Y2_iassignr, ICLASS_CR" 0110 011sssss PP------ ---ddddd")
+
+DEF_FIELDROW_DESC32(   ICLASS_CR" 0111 -------- PP------  --------","[#7] cr=Rs ")
+DEF_ENC32(Y2_tfrsrcr,  ICLASS_CR" 0111 00-sssss PP------ -ddddddd")
+
+DEF_FIELDROW_DESC32(   ICLASS_CR" 1100 -------- PP------  --------","[#12] ")
+DEF_ENC32(Y2_break,    ICLASS_CR" 1100 001----- PP------ 000-----")
+DEF_ENC32(Y2_tlblock,  ICLASS_CR" 1100 001----- PP------ 001-----")
+DEF_ENC32(Y2_tlbunlock,ICLASS_CR" 1100 001----- PP------ 010-----")
+DEF_ENC32(Y2_k0lock,   ICLASS_CR" 1100 001----- PP------ 011-----")
+DEF_ENC32(Y2_k0unlock, ICLASS_CR" 1100 001----- PP------ 100-----")
+DEF_ENC32(Y2_tlbp,     ICLASS_CR" 1100 100sssss PP------ ---ddddd")
+DEF_ENC32(Y5_tlboc,    ICLASS_CR" 1100 111sssss PP------ ---ddddd")
+DEF_ENC32(Y5_tlbasidi, ICLASS_CR" 1100 101sssss PP------ --------")
+DEF_ENC32(Y2_tlbr,     ICLASS_CR" 1100 010sssss PP------ ---ddddd")
+DEF_ENC32(Y2_tlbw,     ICLASS_CR" 1100 000sssss PP0ttttt --------")
+DEF_ENC32(Y5_ctlbw,    ICLASS_CR" 1100 110sssss PP0ttttt ---ddddd")
+
+DEF_FIELDROW_DESC32(   ICLASS_CR" 1101 -------- PP------  --------","[#13] Rxx ")
+DEF_ENC32(Y4_crswap10, ICLASS_CR" 1101 10-xxxxx PP------ ---00000")
+DEF_ENC32(Y4_tfrspcp,  ICLASS_CR" 1101 00-sssss PP------ -ddddddd")
+
+DEF_FIELDROW_DESC32(   ICLASS_CR" 1110 -------- PP------  --------","[#14] Rd=cr ")
+DEF_ENC32(Y2_tfrscrr,  ICLASS_CR" 1110 1sssssss PP------ ---ddddd")
+
+DEF_FIELDROW_DESC32(   ICLASS_CR" 1111 -------- PP------  --------","[#15] Rdd=Sss ")
+DEF_ENC32(Y4_tfrscpp,  ICLASS_CR" 1111 0sssssss PP------ ---ddddd")
+
+
+
+
+
 
 
 
@@ -956,9 +1065,9 @@ MPY_ENC(F2_dfmin,            "1000","ddddd","0","0","1","1","11")
 MPY_ENC(F2_dfmax,            "1000","ddddd","0","1","0","0","11")
 MPY_ENC(F2_dfmpyll,          "1000","ddddd","0","1","0","1","11")
 
-MPY_ENC(M7_dcmpyrw,          "1000","ddddd","0","0","0","1","10")
+MPY_ENC(M7_dcmpyrw,       	"1000","ddddd","0","0","0","1","10")
 MPY_ENC(M7_dcmpyrwc,         "1000","ddddd","0","0","1","1","10")
-MPY_ENC(M7_dcmpyiw,          "1000","ddddd","0","1","1","0","10")
+MPY_ENC(M7_dcmpyiw,       	"1000","ddddd","0","1","1","0","10")
 MPY_ENC(M7_dcmpyiwc,         "1000","ddddd","0","1","1","1","10")
 
 
@@ -967,14 +1076,14 @@ DEF_FIELDROW_DESC32(ICLASS_M" 1001 -------- PP------ --------","[#9] Rd=(Rss,Rtt
 MPY_ENC(M2_vdmpyrs_s0,       "1001","ddddd","0","0","0","0","00")
 MPY_ENC(M2_vdmpyrs_s1,       "1001","ddddd","0","0","0","1","00")
 
-MPY_ENC(M7_wcmpyrw,          "1001","ddddd","0","0","1","0","00")
+MPY_ENC(M7_wcmpyrw,      	 "1001","ddddd","0","0","1","0","00")
 MPY_ENC(M7_wcmpyrw_rnd,      "1001","ddddd","0","0","1","1","00")
-MPY_ENC(M7_wcmpyiw,          "1001","ddddd","0","1","0","0","00")
+MPY_ENC(M7_wcmpyiw,       	 "1001","ddddd","0","1","0","0","00")
 MPY_ENC(M7_wcmpyiw_rnd,      "1001","ddddd","0","1","0","1","00")
 
-MPY_ENC(M7_wcmpyrwc,         "1001","ddddd","0","1","1","0","00")
+MPY_ENC(M7_wcmpyrwc,      	 "1001","ddddd","0","1","1","0","00")
 MPY_ENC(M7_wcmpyrwc_rnd,     "1001","ddddd","0","1","1","1","00")
-MPY_ENC(M7_wcmpyiwc,         "1001","ddddd","1","0","0","0","00")
+MPY_ENC(M7_wcmpyiwc,       	 "1001","ddddd","1","0","0","0","00")
 MPY_ENC(M7_wcmpyiwc_rnd,     "1001","ddddd","1","0","0","1","00")
 
 
@@ -1030,10 +1139,10 @@ MPY_ENC(F2_dfmpylh,          "1010","xxxxx","0","0","0","0","11")
 MPY_ENC(F2_dfmpyhh,          "1010","xxxxx","0","0","0","1","11")
 
 
-MPY_ENC(M7_dcmpyrw_acc,      "1010","xxxxx","0","0","0","1","10")
-MPY_ENC(M7_dcmpyrwc_acc,     "1010","xxxxx","0","0","1","1","10")
-MPY_ENC(M7_dcmpyiw_acc,      "1010","xxxxx","0","1","1","0","10")
-MPY_ENC(M7_dcmpyiwc_acc,     "1010","xxxxx","1","0","1","0","10")
+MPY_ENC(M7_dcmpyrw_acc,       	"1010","xxxxx","0","0","0","1","10")
+MPY_ENC(M7_dcmpyrwc_acc,         "1010","xxxxx","0","0","1","1","10")
+MPY_ENC(M7_dcmpyiw_acc,       	"1010","xxxxx","0","1","1","0","10")
+MPY_ENC(M7_dcmpyiwc_acc,         "1010","xxxxx","1","0","1","0","10")
 
 
 
@@ -1063,7 +1172,6 @@ SP_MPY(M2_mpy_sat_rnd,       "1100","ddddd","1","1","0")
 SP_MPY(M2_mpyu,              "1100","ddddd","0","0","1")
 
 DEF_FIELDROW_DESC32(ICLASS_M" 1101 -------- PP------ --------","[#13] Rd=(Rs,Rt)")
-/* EJP: same as mpyi MPY_ENC(M2_mpyui,            "1101","ddddd","0","0","1","0","00") */
 MPY_ENC(M2_mpyi,             "1101","ddddd","0","0","0","0","00")
 MPY_ENC(M2_mpy_up,           "1101","ddddd","0","0","0","0","01")
 MPY_ENC(M2_mpyu_up,          "1101","ddddd","0","0","1","0","01")
@@ -1266,7 +1374,6 @@ DEF_ENC32(C2_cmovenewif,ICLASS_ALU2op" 1110 1uu0iiii PP1iiiii iiiddddd")
 DEF_ENC32(C2_cmoveit,   ICLASS_ALU2op" 1110 0uu0iiii PP0iiiii iiiddddd")
 DEF_ENC32(C2_cmoveif,   ICLASS_ALU2op" 1110 1uu0iiii PP0iiiii iiiddddd")
 
-
 DEF_FIELDROW_DESC32(    ICLASS_ALU2op" 1111 -------- PP------ --------","[#15] nop")
 DEF_ENC32(A2_nop,       ICLASS_ALU2op" 1111 -------- PP------ --------")
 
@@ -1408,9 +1515,6 @@ DEF_FIELDROW_DESC32(ICLASS_ALU3op"  1110 -------- PP------ --------","[#14] Rese
 
 
 
-
-
-
 /*******************************/
 /*                             */
 /*                             */
@@ -1508,7 +1612,6 @@ SH_RRI6_ENC(S6_rol_i_##TAGEND,MAJ4,MIN3,SMOD1 "11",DSTCHARS)
 
 
 DEF_FIELDROW_DESC32(ICLASS_S2op" 0000 -------- PP------ --------","[#0] Rdd=(Rss,#u6)")
-/* EJP: there is actually quite a bit of space here, look at the reserved bits */
 I6SHIFTTYPES(p,                 "0000","000","0","ddddd")
 I5SHIFTTYPES_NOROL(vw,          "0000","010","0","ddddd")
 I4SHIFTTYPES(vh,                "0000","100","0","ddddd")
@@ -1620,8 +1723,8 @@ SH2_RR_ENC(A2_roundsat,           "1000","110","-","001","ddddd")
 SH_RRI5_ENC(S2_asr_i_svw_trun,    "1000","110",    "010","ddddd")
 SH_RRI5_ENC(A4_bitspliti,         "1000","110",    "100","ddddd")
 
-SH_RRI5_ENC(A7_clip,              "1000","110",    "101","ddddd")
-SH_RRI5_ENC(A7_vclip,             "1000","110",    "110","ddddd")
+SH_RRI5_ENC(A7_clip,         	  "1000","110",    "101","ddddd")
+SH_RRI5_ENC(A7_vclip,         	  "1000","110",    "110","ddddd")
 
 
 SH2_RR_ENC(S4_clbpnorm,           "1000","011","-","000","ddddd")
@@ -1743,10 +1846,11 @@ SH_RRR_ENC(S2_shuffob,          "0001","00-","-","10-","ddddd")
 SH_RRR_ENC(S2_shuffeh,          "0001","00-","-","11-","ddddd")
 
 SH_RRR_ENC(S2_shuffoh,          "0001","10-","-","000","ddddd")
+// 001
 SH_RRR_ENC(S2_vtrunewh,         "0001","10-","-","010","ddddd")
-SH_RRR_ENC(S6_vtrunehb_ppp,     "0001","10-","-","011","ddddd")
+SH_RRR_ENC(S6_vtrunehb_ppp,		"0001","10-","-","011","ddddd")
 SH_RRR_ENC(S2_vtrunowh,         "0001","10-","-","100","ddddd")
-SH_RRR_ENC(S6_vtrunohb_ppp,     "0001","10-","-","101","ddddd")
+SH_RRR_ENC(S6_vtrunohb_ppp,		"0001","10-","-","101","ddddd")
 SH_RRR_ENC(S2_lfsp,             "0001","10-","-","110","ddddd")
 
 SH_RRR_ENC(S4_vxaddsubw,        "0001","01-","-","000","ddddd")
@@ -1780,8 +1884,6 @@ SH_RRR_ENC(S4_vrcrotate,        "0011","11-","i","11i","ddddd")
 DEF_FIELDROW_DESC32(ICLASS_S3op" 0100 -------- PP------ --------","[#4] Rd=(Rs,Rt,#u3)")
 DEF_ENC32(S2_addasl_rrri, ICLASS_S3op" 0100   000 sssss PP0ttttt iiiddddd")
 
-
-
 DEF_FIELDROW_DESC32(ICLASS_S3op" 0101 -------- PP------ --------","[#5] Rd=(Rss,Rt)")
 SH_RRR_ENC(S2_asr_r_svw_trun,   "0101","---","-","010","ddddd")
 SH_RRR_ENC(M4_cmpyi_wh,         "0101","---","-","100","ddddd")
@@ -1841,6 +1943,7 @@ DEF_FIELDROW_DESC32(ICLASS_S3op" 1010 -------- PP------ --------","[#10] Rxx=(Rs
 SH_RRR_ENC(S2_insertp_rp,       "1010","0--","0","---","xxxxx")
 SH_RRR_ENC(M4_xor_xacc,         "1010","10-","0","000","xxxxx")
 
+
 DEF_FIELDROW_DESC32(ICLASS_S3op" 1011 -------- PP------ --------","[#11] Rxx=(Rss,Rt)")
 RSHIFTTYPES(p_or,               "1011","000","-","-","xxxxx")
 RSHIFTTYPES(p_and,              "1011","010","-","-","xxxxx")
@@ -1848,19 +1951,19 @@ RSHIFTTYPES(p_nac,              "1011","100","-","-","xxxxx")
 RSHIFTTYPES(p_acc,              "1011","110","-","-","xxxxx")
 RSHIFTTYPES(p_xor,              "1011","011","-","-","xxxxx")
 
-SH_RRR_ENCX(A4_vrmaxh,          "1011","001","0","001","uuuuu")
-SH_RRR_ENCX(A4_vrmaxuh,         "1011","001","1","001","uuuuu")
-SH_RRR_ENCX(A4_vrmaxw,          "1011","001","0","010","uuuuu")
-SH_RRR_ENCX(A4_vrmaxuw,         "1011","001","1","010","uuuuu")
+SH_RRR_ENCX(A4_vrmaxh,		"1011","001","0","001","uuuuu")
+SH_RRR_ENCX(A4_vrmaxuh,		"1011","001","1","001","uuuuu")
+SH_RRR_ENCX(A4_vrmaxw,		"1011","001","0","010","uuuuu")
+SH_RRR_ENCX(A4_vrmaxuw,		"1011","001","1","010","uuuuu")
 
-SH_RRR_ENCX(A4_vrminh,          "1011","001","0","101","uuuuu")
-SH_RRR_ENCX(A4_vrminuh,         "1011","001","1","101","uuuuu")
-SH_RRR_ENCX(A4_vrminw,          "1011","001","0","110","uuuuu")
-SH_RRR_ENCX(A4_vrminuw,         "1011","001","1","110","uuuuu")
+SH_RRR_ENCX(A4_vrminh,		"1011","001","0","101","uuuuu")
+SH_RRR_ENCX(A4_vrminuh,		"1011","001","1","101","uuuuu")
+SH_RRR_ENCX(A4_vrminw,		"1011","001","0","110","uuuuu")
+SH_RRR_ENCX(A4_vrminuw,		"1011","001","1","110","uuuuu")
 
-SH_RRR_ENC(S2_vrcnegh,          "1011","001","1","111","xxxxx")
+SH_RRR_ENC(S2_vrcnegh,		"1011","001","1","111","xxxxx")
 
-SH_RRR_ENC(S4_vrcrotate_acc,    "1011","101","i","--i","xxxxx")
+SH_RRR_ENC(S4_vrcrotate_acc,	"1011","101","i","--i","xxxxx")
 
 
 DEF_FIELDROW_DESC32(ICLASS_S3op" 1100 -------- PP------ --------","[#12] Rx=(Rs,Rt)")
@@ -1874,11 +1977,6 @@ DEF_FIELDROW_DESC32(ICLASS_S3op" 1101 -------- PP------ --------","[#13] Reserve
 DEF_FIELDROW_DESC32(ICLASS_S3op" 1110 -------- PP------ --------","[#14] Reserved")
 
 
-DEF_FIELDROW_DESC32(ICLASS_S3op" 1111 -------- PP------ --------","[#14] User Instruction")
-
-
-
-
 
 
 
@@ -2129,3 +2227,6 @@ OP_OPI_RI(lsr,"1")
 DEF_FIELDROW_DESC32(ICLASS_ALU64" 1111 -------- PP------ --------","[#15] Rd=(Rs,Ru,#u6:2)")
 DEF_ENC32(M4_mpyri_addr_u2, ICLASS_ALU64" 1111   0ii sssss PPiddddd iiiuuuuu")
 DEF_ENC32(M4_mpyri_addr,    ICLASS_ALU64" 1111   1ii sssss PPiddddd iiiuuuuu")
+
+
+
diff --git a/target/hexagon/imported/system.idef b/target/hexagon/imported/system.idef
index 7c6568e75e..fd7ef18b3e 100644
--- a/target/hexagon/imported/system.idef
+++ b/target/hexagon/imported/system.idef
@@ -25,44 +25,262 @@
 /* User->OS interface                       */
 /********************************************/
 
-Q6INSN(J2_trap0,"trap0(#u8)",ATTRIBS(A_COF),
+Q6INSN(J2_trap0,"trap0(#u8)",ATTRIBS(A_COF,A_NOTE_NOPACKET,A_RESTRICT_NOPACKET),
 "Trap to Operating System",
-    fTRAP(0,uiV);
+	fTRAP(0,uiV);
 )
 
-Q6INSN(J2_pause,"pause(#u8)",ATTRIBS(A_COF),
+Q6INSN(J2_trap1,"trap1(Rx32,#u8)",ATTRIBS(A_COF,A_NOTE_NOPACKET,A_RESTRICT_NOPACKET),
+"Trap to Operating System",
+	/*
+	 * Note: if RxV is not written, we get the same as the input.
+	 * Since trap1 is SOLO, this means the register will effectively not be updated
+	 */
+	if (!fTRAP1_VIRTINSN(uiV)) {
+		fTRAP(1,uiV);
+	} else if (uiV == 1) {
+		fVIRTINSN_RTE(uiV,RxV);
+	} else if (uiV == 3) {
+		fVIRTINSN_SETIE(uiV,RxV);
+	} else if (uiV == 4) {
+		fVIRTINSN_GETIE(uiV,RxV);
+	} else if (uiV == 6) {
+		fVIRTINSN_SPSWAP(uiV,RxV);
+	})
+
+Q6INSN(J2_pause,"pause(#u8)",ATTRIBS(A_COF,A_NOTE_NOPACKET,A_RESTRICT_NOPACKET),
 "Enter low-power state for #u8 cycles",{fPAUSE(uiV);})
 
-Q6INSN(Y2_icinva,"icinva(Rs32)",ATTRIBS(A_ICOP,A_ICFLUSHOP),"Instruction Cache Invalidate Address",{fEA_REG(RsV); fICINVA(EA);})
+Q6INSN(J2_rte,  "rte", ATTRIBS(A_PRIV,A_NOTE_PRIV,A_NO_TIMING_LOG),
+"Return from Exception",
+{
+fHIDE(if((thread->timing_on) && (thread->status & EXEC_STATUS_REPLAY)) { return; })
+fHIDE(CALLBACK(thread->processor_ptr->options->rte_callback,
+      thread->system_ptr,thread->processor_ptr,
+      thread->threadId,0);)
+fCLEAR_RTE_EX();
+fBRANCH(fREAD_ELR(),COF_TYPE_RTE);})
 
-Q6INSN(Y2_isync,"isync",ATTRIBS(),"Memory Synchronization",{fISYNC();})
-Q6INSN(Y2_barrier,"barrier",ATTRIBS(A_RESTRICT_SLOT0ONLY),"Memory Barrier",{fBARRIER();})
-Q6INSN(Y2_syncht,"syncht",ATTRIBS(A_RESTRICT_SLOT0ONLY),"Memory Synchronization",{fSYNCH();})
 
+/********************************************/
+/* Interrupt Management                     */
+/********************************************/
 
-Q6INSN(Y2_dcfetchbo,"dcfetch(Rs32+#u11:3)",ATTRIBS(A_RESTRICT_PREFERSLOT0,A_DCFETCH),"Data Cache Prefetch",{fEA_RI(RsV,uiV); fDCFETCH(EA);})
+Q6INSN(Y2_swi,"swi(Rs32)",ATTRIBS(A_PRIV,A_NOTE_PRIV,A_NOTE_AXOK,A_RESTRICT_PACKET_AXOK),"Software Interrupt",{DO_SWI(RsV);})
+Q6INSN(Y2_cswi,"cswi(Rs32)",ATTRIBS(A_PRIV,A_NOTE_PRIV,A_NOTE_AXOK,A_RESTRICT_PACKET_AXOK),"Cancel Software Interrupt",{DO_CSWI(RsV);})
+Q6INSN(Y2_ciad,"ciad(Rs32)",ATTRIBS(A_PRIV,A_NOTE_PRIV,A_NOTE_AXOK,A_RESTRICT_PACKET_AXOK),"Re-enable interrupt in IAD",{DO_CIAD(RsV);})
+Q6INSN(Y4_siad,"siad(Rs32)",ATTRIBS(A_PRIV,A_NOTE_PRIV,A_NOTE_AXOK,A_RESTRICT_PACKET_AXOK),"Disable interrupt in IAD",{DO_SIAD(RsV);})
+Q6INSN(Y2_iassignr,"Rd32=iassignr(Rs32)",ATTRIBS(A_PRIV,A_NOTE_PRIV,A_NOTE_AXOK,A_RESTRICT_PACKET_AXOK),"Read interrupt to thread assignments",{DO_IASSIGNR(RsV,RdV);})
+Q6INSN(Y2_iassignw,"iassignw(Rs32)",ATTRIBS(A_PRIV,A_NOTE_PRIV,A_NOTE_AXOK,A_RESTRICT_PACKET_AXOK),"Write interrupt to thread assignments",{DO_IASSIGNW(RsV);})
 
 
-Q6INSN(Y2_dczeroa,"dczeroa(Rs32)",ATTRIBS(A_STORE,A_RESTRICT_SLOT0ONLY,A_DCZEROA),"Zero an aligned 32-byte cacheline",{fEA_REG(RsV); fDCZEROA(EA);})
-Q6INSN(Y2_dccleana,"dccleana(Rs32)",ATTRIBS(A_RESTRICT_SLOT0ONLY,A_DCFLUSHOP),"Data Cache Clean Address",{fEA_REG(RsV); fDCCLEANA(EA);})
-Q6INSN(Y2_dccleaninva,"dccleaninva(Rs32)",ATTRIBS(A_RESTRICT_SLOT0ONLY,A_DCFLUSHOP),"Data Cache Clean and Invalidate Address",{fEA_REG(RsV); fDCCLEANINVA(EA);})
-Q6INSN(Y2_dcinva,"dcinva(Rs32)",ATTRIBS(A_RESTRICT_SLOT0ONLY,A_DCFLUSHOP),"Data Cache Invalidate Address",{fEA_REG(RsV); fDCCLEANINVA(EA);})
+Q6INSN(Y2_getimask,"Rd32=getimask(Rs32)",ATTRIBS(A_PRIV,A_NOTE_PRIV,A_NOTE_AXOK,A_RESTRICT_PACKET_AXOK),"Read imask register of another thread",
+{RdV = READ_IMASK(RsV & thread->processor_ptr->thread_system_mask); })
 
+Q6INSN(Y2_setimask,"setimask(Pt4,Rs32)",ATTRIBS(A_PRIV,A_NOTE_PRIV,A_NOTE_AXOK,A_RESTRICT_PACKET_AXOK),"Change imask register of another thread",
+{fPREDUSE_TIMING();WRITE_IMASK(PtV & thread->processor_ptr->thread_system_mask,RsV); })
 
-Q6INSN(Y4_l2fetch,"l2fetch(Rs32,Rt32)",ATTRIBS(A_RESTRICT_SLOT0ONLY),"L2 Cache Prefetch",
+
+
+/********************************************/
+/* TLB management                           */
+/********************************************/
+
+Q6INSN(Y2_tlbw,"tlbw(Rss32,Rt32)", ATTRIBS(A_PRIV,A_NOTE_PRIV,A_NOTE_NOPACKET,A_RESTRICT_NOPACKET),
+"Write TLB entry", {fTLBW(RtV,RssV);})
+
+Q6INSN(Y5_ctlbw,"Rd32=ctlbw(Rss32,Rt32)", ATTRIBS(A_PRIV,A_NOTE_PRIV,A_NOTE_NOPACKET,A_RESTRICT_NOPACKET),
+"Conditional Write TLB entry",
+{
+  if (fTLB_ENTRY_OVERLAP( (1LL<<63) | RssV )) {
+        RdV=fTLB_ENTRY_OVERLAP_IDX( (1LL<<63) | RssV);
+     } else {
+        fTLBW(RtV,RssV);
+        RdV=0x80000000;
+     }
+})
+
+Q6INSN(Y5_tlboc,"Rd32=tlboc(Rss32)", ATTRIBS(A_PRIV,A_NOTE_PRIV,A_NOTE_NOPACKET,A_RESTRICT_NOPACKET),
+"TLB overlap check",
+{
+  if (fTLB_ENTRY_OVERLAP( (1LL<<63) | RssV )) {
+        RdV=fTLB_ENTRY_OVERLAP_IDX( (1LL<<63) | RssV);
+     } else {
+        RdV=0x80000000;
+     }
+})
+
+Q6INSN(Y2_tlbr,"Rdd32=tlbr(Rs32)", ATTRIBS(A_PRIV,A_NOTE_PRIV,A_NOTE_NOPACKET,A_RESTRICT_NOPACKET), "Read TLB entry",
+{RddV = fTLBR(RsV);})
+
+Q6INSN(Y2_tlbp,"Rd32=tlbp(Rs32)", ATTRIBS(A_PRIV,A_NOTE_PRIV,A_NOTE_NOPACKET,A_RESTRICT_NOPACKET), "Probe TLB", {RdV=fTLBP(RsV);})
+
+Q6INSN(Y5_tlbasidi,"tlbinvasid(Rs32)",ATTRIBS(A_PRIV,A_NOTE_PRIV,A_NOTE_NOPACKET,A_RESTRICT_NOPACKET), "Invalidate ASID",
+{
+	fHIDE(int i;)
+    fHIDE(unsigned int NUM_TLB_ENTRIES = NUM_TLB_REGS(thread->processor_ptr);)
+	for (i = 0; i < NUM_TLB_ENTRIES; i++) {
+		if ((fGET_FIELD(fTLBR(i),PTE_G) == 0) &&
+			(fGET_FIELD(fTLBR(i),PTE_ASID) == fEXTRACTU_RANGE(RsV,26,20))) {
+			fTLBW(i,fTLBR(i) & ~(1ULL << 63));
+		}
+	}
+})
+
+Q6INSN(Y2_tlblock,"tlblock", ATTRIBS(A_PRIV,A_NOTE_PRIV,A_NOTE_NOPACKET,A_RESTRICT_NOPACKET,A_NO_TIMING_LOG), "Lock TLB",
+{fSET_TLB_LOCK();})
+
+Q6INSN(Y2_tlbunlock,"tlbunlock", ATTRIBS(A_PRIV,A_NOTE_PRIV,A_NOTE_NOPACKET,A_RESTRICT_NOPACKET), "Unlock TLB",
+{fCLEAR_TLB_LOCK();})
+
+Q6INSN(Y2_k0lock,"k0lock", ATTRIBS(A_PRIV,A_NOTE_PRIV,A_NOTE_NOPACKET,A_RESTRICT_NOPACKET,A_NO_TIMING_LOG), "Lock K0",
+{fSET_K0_LOCK();})
+
+Q6INSN(Y2_k0unlock,"k0unlock", ATTRIBS(A_PRIV,A_NOTE_PRIV,A_NOTE_NOPACKET,A_RESTRICT_NOPACKET), "Unlock K0",
+{fCLEAR_K0_LOCK();})
+
+/********************************************/
+/* Supervisor Reg Management                */
+/********************************************/
+
+Q6INSN(Y2_crswap0,"crswap(Rx32,sgp0)",ATTRIBS(A_PRIV,A_NOTE_PRIV), "Swap system general pointer 0 with GPR",
+{fHIDE(size4s_t tmp;) tmp = RxV; RxV = READ_SGP0(); WRITE_SGP0(tmp);})
+Q6INSN(Y4_crswap1,"crswap(Rx32,sgp1)",ATTRIBS(A_PRIV,A_NOTE_PRIV), "Swap system general pointer 1 with GPR",
+{fHIDE(size4s_t tmp;) tmp = RxV; RxV = READ_SGP1(); WRITE_SGP1(tmp);})
+
+Q6INSN(Y4_crswap10,"crswap(Rxx32,sgp1:0)",ATTRIBS(A_PRIV,A_NOTE_PRIV), "Swap system general purpose 0/1 with GPR Pair",
+{fHIDE(size8s_t tmp;) tmp = RxxV; RxxV=READ_SGP10(); WRITE_SGP10(tmp);})
+
+Q6INSN(Y2_tfrscrr,"Rd32=Ss128",ATTRIBS(A_PRIV,A_NOTE_PRIV),"Transfer Supervisor Reg to GPR", {RdV=SsV;})
+Q6INSN(Y2_tfrsrcr,"Sd128=Rs32",ATTRIBS(A_PRIV,A_NOTE_PRIV),"Transfer GPR to Supervisor Reg", {SdV=RsV;})
+Q6INSN(Y4_tfrscpp,"Rdd32=Sss128",ATTRIBS(A_PRIV,A_NOTE_PRIV),"Transfer Supervisor Reg to GPR", {RddV=SssV;})
+Q6INSN(Y4_tfrspcp,"Sdd128=Rss32",ATTRIBS(A_PRIV,A_NOTE_PRIV),"Transfer GPR to Supervisor Reg", {SddV=RssV;})
+
+Q6INSN(G4_tfrgcrr,"Rd32=Gs32",ATTRIBS(A_GUEST,A_NOTE_GUEST),"Transfer Guest Reg to GPR", {RdV=GsV;})
+Q6INSN(G4_tfrgrcr,"Gd32=Rs32",ATTRIBS(A_GUEST,A_NOTE_GUEST),"Transfer GPR to Guest Reg", {GdV=RsV;})
+Q6INSN(G4_tfrgcpp,"Rdd32=Gss32",ATTRIBS(A_GUEST,A_NOTE_GUEST),"Transfer Guest Reg to GPR", {RddV=GssV;})
+Q6INSN(G4_tfrgpcp,"Gdd32=Rss32",ATTRIBS(A_GUEST,A_NOTE_GUEST),"Transfer GPR to Guest Reg", {GddV=RssV;})
+
+
+
+Q6INSN(Y2_setprio,"setprio(Pt4,Rs32)",ATTRIBS(A_PRIV,A_NOTE_PRIV),"Change TID Prio of another thread",
+{fPREDUSE_TIMING();WRITE_PRIO(PtV & thread->processor_ptr->thread_system_mask,RsV); })
+
+
+
+
+/********************************************/
+/* Power Management / Thread on/off         */
+/********************************************/
+Q6INSN(Y6_diag,"diag(Rs32)",ATTRIBS(),"Send value to Diag trace module",{
+})
+Q6INSN(Y6_diag0,"diag0(Rss32,Rtt32)",ATTRIBS(),"Send values of two register to DIAG Trace. Set X=0",{
+})
+Q6INSN(Y6_diag1,"diag1(Rss32,Rtt32)",ATTRIBS(),"Send values of two register to DIAG Trace.  Set X=1",{
+})
+
+
+Q6INSN(Y4_trace,"trace(Rs32)",ATTRIBS(A_NOTE_AXOK,A_RESTRICT_PACKET_AXOK),"Send value to ETM trace",{
+    fDO_TRACE(RsV);
+})
+
+Q6INSN(Y2_stop,"stop(Rs32)",ATTRIBS(A_PRIV,A_NOTE_PRIV,A_NOTE_NOPACKET,A_RESTRICT_NOPACKET),"Stop thread(s)",{
+    fHIDE(RsV=RsV;)
+    if (!fIN_DEBUG_MODE_NO_ISDB(fGET_TNUM())) fCLEAR_RUN_MODE(fGET_TNUM());
+})
+
+Q6INSN(Y4_nmi,"nmi(Rs32)",ATTRIBS(A_PRIV,A_NOTE_PRIV,A_NOTE_NOPACKET,A_RESTRICT_NOPACKET,A_NO_TIMING_LOG),"Raise NMI on thread(s)",{
+    fDO_NMI(RsV);
+})
+
+Q6INSN(Y2_start,"start(Rs32)",ATTRIBS(A_PRIV,A_NOTE_PRIV,A_NOTE_NOPACKET,A_RESTRICT_NOPACKET),"Start thread(s)",fSTART(RsV);)
+
+Q6INSN(Y2_wait,"wait(Rs32)",ATTRIBS(A_PRIV,A_NOTE_PRIV,A_NOTE_NOPACKET,A_RESTRICT_NOPACKET,A_NO_TIMING_LOG),"Make thread(s) wait",{
+    fHIDE(RsV=RsV;)
+    if (!fIN_DEBUG_MODE(fGET_TNUM())) fSET_WAIT_MODE(fGET_TNUM());
+	fIN_DEBUG_MODE_WARN(fGET_TNUM());
+})
+
+Q6INSN(Y2_resume,"resume(Rs32)",ATTRIBS(A_PRIV,A_NOTE_PRIV,A_NOTE_NOPACKET,A_RESTRICT_NOPACKET),"Make thread(s) stop waiting",fRESUME(RsV);)
+
+Q6INSN(Y2_break,"brkpt",ATTRIBS(A_NOTE_NOPACKET,A_RESTRICT_NOPACKET),"Breakpoint",{fBREAK();})
+
+
+/********************************************/
+/* Cache Management                         */
+/********************************************/
+
+Q6INSN(Y2_ictagr,"Rd32=ictagr(Rs32)",ATTRIBS(A_ICOP,A_PRIV,A_NOTE_PRIV,A_NOTE_NOPACKET,A_RESTRICT_NOPACKET,A_CACHEOP,A_COPBYIDX,A_ICTAGOP),"Instruction Cache Tag Read",{fICTAGR(RsV,RdV,RdN);})
+Q6INSN(Y2_ictagw,"ictagw(Rs32,Rt32)",ATTRIBS(A_ICOP,A_PRIV,A_NOTE_PRIV,A_NOTE_NOPACKET,A_RESTRICT_NOPACKET,A_CACHEOP,A_COPBYIDX,A_ICTAGOP),"Instruction Cache Tag Write",{fICTAGW(RsV,RtV);})
+Q6INSN(Y2_icdataw,"icdataw(Rs32,Rt32)",ATTRIBS(A_ICOP,A_PRIV,A_NOTE_PRIV,A_NOTE_NOPACKET,A_RESTRICT_NOPACKET,A_CACHEOP,A_COPBYIDX,A_ICTAGOP),"Instruction Cache Data Write",{fICDATAW(RsV,RtV);})
+Q6INSN(Y2_icdatar,"Rd32=icdatar(Rs32)",ATTRIBS(A_ICOP,A_PRIV,A_NOTE_PRIV,A_NOTE_NOPACKET,A_RESTRICT_NOPACKET,A_CACHEOP,A_COPBYIDX,A_ICTAGOP),"Instruction Cache Data Read",{fICDATAR(RsV, RdV);})
+Q6INSN(Y2_icinva,"icinva(Rs32)",ATTRIBS(A_ICOP,A_NOTE_NOPACKET,A_RESTRICT_NOPACKET,A_CACHEOP,A_COPBYADDRESS,A_ICFLUSHOP),"Instruction Cache Invalidate Address",{fEA_REG(RsV); fICINVA(EA);})
+Q6INSN(Y2_icinvidx,"icinvidx(Rs32)",ATTRIBS(A_ICOP,A_PRIV,A_NOTE_PRIV,A_NOTE_NOPACKET,A_RESTRICT_NOPACKET,A_CACHEOP,A_COPBYIDX,A_ICFLUSHOP),"Instruction Cache Invalidate Index",{fICINVIDX(RsV);})
+Q6INSN(Y2_ickill,"ickill",ATTRIBS(A_ICOP,A_PRIV,A_NOTE_PRIV,A_NOTE_NOPACKET,A_RESTRICT_NOPACKET,A_CACHEOP,A_ICFLUSHOP),"Instruction Cache Invalidate",{fICKILL();})
+
+Q6INSN(Y2_isync,"isync",ATTRIBS(A_NOTE_NOPACKET,A_RESTRICT_NOPACKET),"Memory Synchronization",{fISYNC();})
+Q6INSN(Y2_barrier,"barrier",ATTRIBS(A_NOTE_NOPACKET,A_RESTRICT_SLOT0ONLY,A_RESTRICT_PACKET_AXOK),"Memory Barrier",{fBARRIER();})
+Q6INSN(Y2_syncht,"syncht",ATTRIBS(A_NOTE_NOPACKET,A_RESTRICT_SLOT0ONLY,A_RESTRICT_NOPACKET),"Memory Synchronization",{fSYNCH();})
+
+
+Q6INSN(Y2_dcfetchbo,"dcfetch(Rs32+#u11:3)",ATTRIBS(A_RESTRICT_PREFERSLOT0,A_DCFETCH,A_RESTRICT_NOSLOT1_STORE),"Data Cache Prefetch",{fEA_RI(RsV,uiV); fDCFETCH(EA);})
+Q6INSN(Y2_dckill,"dckill",ATTRIBS(A_PRIV,A_NOTE_PRIV,A_NOTE_NOPACKET,A_RESTRICT_SLOT0ONLY,A_RESTRICT_NOPACKET,A_CACHEOP,A_DCFLUSHOP),"Data Cache Invalidate",{fDCKILL();})
+
+
+Q6INSN(Y2_dczeroa,"dczeroa(Rs32)",ATTRIBS(A_STORE,A_RESTRICT_SLOT1_AOK,A_NOTE_SLOT1_AOK,A_RESTRICT_SLOT0ONLY,A_CACHEOP,A_COPBYADDRESS,A_DCZEROA),"Zero an aligned 32-byte cacheline",{fEA_REG(RsV); fDCZEROA(EA);})
+Q6INSN(Y2_dccleana,"dccleana(Rs32)",ATTRIBS(A_RESTRICT_SLOT1_AOK,A_NOTE_SLOT1_AOK,A_RESTRICT_SLOT0ONLY,A_CACHEOP,A_COPBYADDRESS,A_DCFLUSHOP),"Data Cache Clean Address",{fEA_REG(RsV); fDCCLEANA(EA);})
+Q6INSN(Y2_dccleanidx,"dccleanidx(Rs32)",ATTRIBS(A_PRIV,A_NOTE_PRIV,A_RESTRICT_PACKET_AXOK,A_NOTE_AXOK,A_RESTRICT_SLOT0ONLY,A_CACHEOP,A_COPBYIDX,A_DCFLUSHOP),"Data Cache Clean Index",{fDCCLEANIDX(RsV);})
+Q6INSN(Y2_dccleaninva,"dccleaninva(Rs32)",ATTRIBS(A_RESTRICT_SLOT1_AOK,A_NOTE_SLOT1_AOK,A_RESTRICT_SLOT0ONLY,A_CACHEOP,A_COPBYADDRESS,A_DCFLUSHOP),"Data Cache Clean and Invalidate Address",{fEA_REG(RsV); fDCCLEANINVA(EA);})
+Q6INSN(Y2_dccleaninvidx,"dccleaninvidx(Rs32)",ATTRIBS(A_PRIV,A_NOTE_PRIV,A_RESTRICT_PACKET_AXOK,A_NOTE_AXOK,A_RESTRICT_SLOT0ONLY,A_CACHEOP,A_COPBYIDX,A_DCFLUSHOP),"Data Cache Clean and Invalidate Index",{fDCCLEANINVIDX(RsV);})
+Q6INSN(Y2_dcinva,"dcinva(Rs32)",ATTRIBS(A_RESTRICT_SLOT1_AOK,A_NOTE_SLOT1_AOK,A_RESTRICT_SLOT0ONLY,A_CACHEOP,A_COPBYADDRESS,A_DCFLUSHOP),"Data Cache Invalidate Address",{fEA_REG(RsV); fDCCLEANINVA(EA);})
+Q6INSN(Y2_dcinvidx,"dcinvidx(Rs32)",ATTRIBS(A_PRIV,A_NOTE_PRIV,A_RESTRICT_PACKET_AXOK,A_NOTE_AXOK,A_RESTRICT_SLOT0ONLY,A_CACHEOP,A_COPBYIDX,A_DCFLUSHOP),"Data Cache Invalidate Index",{fDCINVIDX(RsV);})
+Q6INSN(Y2_dctagr,"Rd32=dctagr(Rs32)",ATTRIBS(A_PRIV,A_NOTE_PRIV,A_RESTRICT_PACKET_AXOK,A_NOTE_AXOK,A_RESTRICT_SLOT0ONLY,A_CACHEOP,A_COPBYIDX,A_DCTAGOP),"Data Cache Tag Read",{fDCTAGR(RsV,RdV,RdN);})
+Q6INSN(Y2_dctagw,"dctagw(Rs32,Rt32)",ATTRIBS(A_PRIV,A_NOTE_PRIV,A_RESTRICT_SLOT0ONLY,A_NOTE_NOPACKET,A_RESTRICT_NOPACKET,A_CACHEOP,A_COPBYIDX,A_DCTAGOP),"Data Cache Tag Write",{fDCTAGW(RsV,RtV);})
+
+
+Q6INSN(Y2_l2kill,"l2kill",ATTRIBS(A_PRIV,A_NOTE_PRIV,A_NOTE_NOPACKET,A_RESTRICT_SLOT0ONLY,A_RESTRICT_NOPACKET,A_CACHEOP,A_L2FLUSHOP),"L2 Cache Invalidate",{fL2KILL();})
+Q6INSN(Y4_l2tagw,"l2tagw(Rs32,Rt32)",ATTRIBS(A_PRIV,A_NOTE_BADTAG_UNDEF,A_NOTE_PRIV,A_RESTRICT_SLOT0ONLY,A_NOTE_NOPACKET,A_RESTRICT_NOPACKET,A_CACHEOP,A_COPBYIDX,A_L2TAGOP),"L2 Cache Tag Write",{fL2TAGW(RsV,RtV);})
+Q6INSN(Y4_l2tagr,"Rd32=l2tagr(Rs32)",ATTRIBS(A_PRIV,A_NOTE_BADTAG_UNDEF,A_NOTE_PRIV,A_NOTE_AXOK,A_RESTRICT_PACKET_AXOK,A_RESTRICT_SLOT0ONLY,A_CACHEOP,A_COPBYIDX,A_L2TAGOP),"L2 Cache Tag Read",{fL2TAGR(RsV,RdV,RdN);})
+
+Q6INSN(Y2_l2cleaninvidx,"l2cleaninvidx(Rs32)",ATTRIBS(A_PRIV,A_NOTE_PRIV,A_NOTE_AXOK,A_RESTRICT_PACKET_AXOK,A_RESTRICT_SLOT0ONLY,A_CACHEOP,A_COPBYIDX,A_L2FLUSHOP),"L2 Cache Clean and Invalidate Index",{fL2CLEANINVIDX(RsV); })
+Q6INSN(Y5_l2cleanidx,"l2cleanidx(Rs32)",ATTRIBS(A_PRIV,A_NOTE_PRIV,A_NOTE_AXOK,A_RESTRICT_PACKET_AXOK,A_RESTRICT_SLOT0ONLY,A_CACHEOP,A_COPBYIDX,A_L2FLUSHOP),"L2 Cache Clean by Index",{fL2CLEANIDX(RsV); })
+Q6INSN(Y5_l2invidx,"l2invidx(Rs32)",ATTRIBS(A_PRIV,A_NOTE_PRIV,A_NOTE_AXOK,A_RESTRICT_PACKET_AXOK,A_RESTRICT_SLOT0ONLY,A_CACHEOP,A_COPBYIDX,A_L2FLUSHOP),"L2 Cache Invalidate by Index",{fL2INVIDX(RsV); })
+
+
+
+Q6INSN(Y4_l2fetch,"l2fetch(Rs32,Rt32)",ATTRIBS(A_RESTRICT_SLOT0ONLY,A_RESTRICT_PACKET_AXOK,A_NOTE_AXOK),"L2 Cache Prefetch",
 { fL2FETCH(RsV,
-           (RtV&0xff), /*height*/
-           ((RtV>>8)&0xff), /*width*/
-           ((RtV>>16)&0xffff), /*stride*/
-           0); /*extra attrib flags*/
+	(RtV&0xff), /*height*/
+	((RtV>>8)&0xff), /*width*/
+	((RtV>>16)&0xffff), /*stride*/
+	0); /*extra attrib flags*/
 })
 
 
 
-Q6INSN(Y5_l2fetch,"l2fetch(Rs32,Rtt32)",ATTRIBS(A_RESTRICT_SLOT0ONLY),"L2 Cache Prefetch",
+Q6INSN(Y5_l2fetch,"l2fetch(Rs32,Rtt32)",ATTRIBS(A_RESTRICT_SLOT0ONLY,A_RESTRICT_PACKET_AXOK,A_NOTE_AXOK),"L2 Cache Prefetch",
 { fL2FETCH(RsV,
-           fGETUHALF(0,RttV), /*height*/
-           fGETUHALF(1,RttV), /*width*/
-           fGETUHALF(2,RttV), /*stride*/
-           fGETUHALF(3,RttV)); /*flags*/
+	fGETUHALF(0,RttV), /*height*/
+	fGETUHALF(1,RttV), /*width*/
+	fGETUHALF(2,RttV), /*stride*/
+	fGETUHALF(3,RttV)); /*flags*/
 })
+
+Q6INSN(Y5_l2locka,"Pd4=l2locka(Rs32)", ATTRIBS(A_PRIV,A_NOTE_PRIV,A_CACHEOP,A_COPBYADDRESS,A_RESTRICT_SLOT0ONLY,A_RESTRICT_PACKET_AXOK,A_NOTE_AXOK,A_RESTRICT_LATEPRED,A_NOTE_LATEPRED),
+"Lock L2 cache line by address", { fEA_REG(RsV); fL2LOCKA(EA,PdV,PdN); fHIDE(MARK_LATE_PRED_WRITE(PdN)) })
+
+
+Q6INSN(Y5_l2unlocka,"l2unlocka(Rs32)", ATTRIBS(A_PRIV,A_NOTE_PRIV,A_CACHEOP,A_COPBYADDRESS,A_RESTRICT_SLOT0ONLY,A_RESTRICT_PACKET_AXOK,A_NOTE_AXOK), "UnLock L2 cache line by address", { fEA_REG(RsV); fL2UNLOCKA(EA); })
+
+
+
+Q6INSN(Y5_l2gunlock,"l2gunlock",ATTRIBS(A_PRIV,A_NOTE_PRIV,A_NOTE_NOPACKET,A_RESTRICT_SLOT0ONLY,A_RESTRICT_NOPACKET,A_CACHEOP,A_L2FLUSHOP),"L2 Global Unlock",{fL2UNLOCK();})
+
+Q6INSN(Y5_l2gclean,"l2gclean",ATTRIBS(A_PRIV,A_NOTE_PRIV,A_NOTE_NOPACKET,A_RESTRICT_SLOT0ONLY,A_RESTRICT_NOPACKET,A_CACHEOP,A_L2FLUSHOP),"L2 Global Clean",{fL2CLEAN();})
+
+Q6INSN(Y5_l2gcleaninv,"l2gcleaninv",ATTRIBS(A_PRIV,A_NOTE_PRIV,A_NOTE_NOPACKET,A_RESTRICT_SLOT0ONLY,A_RESTRICT_NOPACKET,A_CACHEOP,A_L2FLUSHOP),"L2 Global Clean and Invalidate",{fL2CLEANINV();})
+
+Q6INSN(Y6_l2gcleanpa,"l2gclean(Rtt32)",ATTRIBS(A_PRIV,A_NOTE_PRIV,A_NOTE_NOPACKET,A_RESTRICT_SLOT0ONLY,A_RESTRICT_NOPACKET,A_CACHEOP,A_L2FLUSHOP),"L2 Global Clean by PA Range",{fL2CLEANPA(RttV);})
+
+Q6INSN(Y6_l2gcleaninvpa,"l2gcleaninv(Rtt32)",ATTRIBS(A_PRIV,A_NOTE_PRIV,A_NOTE_NOPACKET,A_RESTRICT_SLOT0ONLY,A_RESTRICT_NOPACKET,A_CACHEOP,A_L2FLUSHOP),"L2 Global Clean and Invalidate by PA Range",{fL2CLEANINVPA(RttV);})
+
-- 
2.34.1


