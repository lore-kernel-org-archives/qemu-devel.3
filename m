Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACF77C9EC69
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 10:35:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfFGt-0004Gb-E8; Mon, 12 Jan 2026 05:35:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vfFGT-0003kw-LU
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 05:35:15 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vfFGQ-0002MP-1B
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 05:35:11 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60C9jReD012388
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 10:35:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=tfohKgKAdJVEyPe8B
 yJMtNAFb3BdIIenfKOKRMOfNME=; b=Tklm87jEnUf7KeagSBIFO1i1ZHAckLvuC
 5N6lYP/m/FCc4NU9I3JJ9SsltTqMlTWNHs3am6ySOcx7xlN7QTCJLrmz74WMZwYQ
 wHURv4egemyZY16fTk0MpEFMP+p4T31rm00oylomxuvKE1+y08CDaUFpvI/IfYIv
 AC0hhQkiK8sEz/C49UBwLCxzrbXHOLum3dIHp0OtQCWCkHyv17tKAHy23wrj5UC0
 HzhKVYYRrxzsNeTKyRaEmOyuoyvICthAG/zzPrY5Ye+VB9f40BKlxt41TNQ8RuF3
 GtDwF/F2BDTGcBLhI7q450lNxVANwUw4sECaG52ckFIfNh5iO74hA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkedsp9w3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 10:35:08 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60C7GMmP030134
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 10:35:08 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bm3ajd74c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 10:35:08 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60CAZ25n28770706
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Jan 2026 10:35:02 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9D59320043;
 Mon, 12 Jan 2026 10:35:02 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2E6DE20040;
 Mon, 12 Jan 2026 10:35:01 +0000 (GMT)
Received: from Mac.com (unknown [9.43.47.93])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 12 Jan 2026 10:35:00 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Caleb Schlossin <calebs@linux.ibm.com>,
 Angelo Jaramillo <angelo.jaramillo@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>, Aditya Gupta <adityag@linux.ibm.com>,
 Chalapathi V <chalapathi.v@linux.ibm.com>
Subject: [PULL 06/10] hw/ppc: pnv_core.c add vmstate support
Date: Mon, 12 Jan 2026 16:04:29 +0530
Message-ID: <20260112103433.8451-7-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112103433.8451-1-harshpb@linux.ibm.com>
References: <20260112103433.8451-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDA4MSBTYWx0ZWRfX2mHdDl+7kmj/
 6qqTomJKDKqg81ZLYY1x4qwJl/kfMVjEUXiPAacEh9J/CyouG8rc5GeAQOmMkyb/X3BhXTAY10P
 CkmR4PIAHBjPT/51PgRJOU94oG52FOTrQpkc9Q2iTmT1OI55N0O8vrvw6JKSYC8aNMoRTnh0kLd
 0E4GUj36TY4HKOgTqcHnNzrm/z1vOT/EmqsN7Sxr67lmZULNI8L0tecX3qaJ8x2A1WxxIm/+FIn
 btjFbZtuzrIN5IUTgverczM12wSKm1dZjWHVMvGYVwp/FywrqiLnKv+pLtEFxOXHnMqD7pKZbJf
 kdudGfsaxSQiMv0oKMrURN/AmvX4wZBaV1p34CtHjEGRBCVs3yQL+YvG3TXBQo9TyKPdbizmiDw
 AhdhD6IqG6S/niUKHu2fwBF6Ts/ChbP4s7T4L+UjA4y5DYgP8UTg+fGTE/EakOjAinwn5+kKA3w
 aPubFCpW4n9VjZLce3g==
X-Proofpoint-GUID: 3-zIs0PLdUycCB-ZD3x7RGeFDfwrs-UZ
X-Authority-Analysis: v=2.4 cv=WLJyn3sR c=1 sm=1 tr=0 ts=6964ce5d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=vUbySO9Y5rIA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=ijNBCCglf-f1jh5ZZN4A:9
X-Proofpoint-ORIG-GUID: 3-zIs0PLdUycCB-ZD3x7RGeFDfwrs-UZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_03,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 malwarescore=0 phishscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2601120081
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Caleb Schlossin <calebs@linux.ibm.com>

- Add vmstate support PnvCore and PnvQuad capturing scratch
registers and special wakeup registers

Signed-off-by: Angelo Jaramillo <angelo.jaramillo@linux.ibm.com>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>
Reviewed-by: Chalapathi V <chalapathi.v@linux.ibm.com>
Signed-off-by: Caleb Schlossin <calebs@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260105160138.3242709-6-calebs@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 hw/ppc/pnv_core.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 59a9eee597..8939515c2c 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -31,6 +31,7 @@
 #include "hw/ppc/xics.h"
 #include "hw/core/qdev-properties.h"
 #include "helper_regs.h"
+#include "migration/vmstate.h"
 
 static const char *pnv_core_cpu_typename(PnvCore *pc)
 {
@@ -478,6 +479,15 @@ static void pnv_core_power11_class_init(ObjectClass *oc, const void *data)
     pnv_core_power10_class_init(oc, data);
 }
 
+static const VMStateDescription pnv_core_vmstate = {
+    .name = TYPE_PNV_CORE,
+    .version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT64_ARRAY(scratch, PnvCore, 8),
+        VMSTATE_END_OF_LIST(),
+    },
+};
+
 static void pnv_core_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
@@ -486,6 +496,7 @@ static void pnv_core_class_init(ObjectClass *oc, const void *data)
     dc->unrealize = pnv_core_unrealize;
     device_class_set_props(dc, pnv_core_properties);
     dc->user_creatable = false;
+    dc->vmsd = &pnv_core_vmstate;
 }
 
 #define DEFINE_PNV_CORE_TYPE(family, cpu_model) \
@@ -737,12 +748,23 @@ static void pnv_quad_power11_class_init(ObjectClass *oc, const void *data)
     pnv_quad_power10_class_init(oc, data);
 }
 
+static const VMStateDescription pnv_quad_vmstate = {
+    .name = TYPE_PNV_QUAD,
+    .version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_BOOL(special_wakeup_done, PnvQuad),
+        VMSTATE_BOOL_ARRAY(special_wakeup, PnvQuad, 4),
+        VMSTATE_END_OF_LIST(),
+    },
+};
+
 static void pnv_quad_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
     device_class_set_props(dc, pnv_quad_properties);
     dc->user_creatable = false;
+    dc->vmsd = &pnv_quad_vmstate;
 }
 
 static const TypeInfo pnv_quad_infos[] = {
-- 
2.52.0


