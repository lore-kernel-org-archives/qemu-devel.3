Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E554CD13D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 20:40:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIYA7-0002tA-B0; Thu, 30 Apr 2026 16:39:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIYA1-0002nC-Fr
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 16:39:02 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIY9x-0000th-Dj
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 16:39:00 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63UITrSQ563955
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 20:38:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 54T5hcINubNCcwaMGkVx4ajHGLNd1sHSAIGwNUp8J0A=; b=g3s8C3diLIOaWa3i
 sjbEI/FZzvsmK1i5LulMoxiGP+qOWJwqYK+3ZzyvGGWYckJb10q3qEO7dDIAdRE2
 AlNVFCuJ49TTqmxpUHizIvg4+VYDyWnbYLtht/X+NRocYgCooVusGgoP18MDUUJ1
 Q9JS8EeAPY66sZL05pctO72LYh5ATjrqC+HGvVmSCZxxaRLzhQIMRUeCk4K+ZZh6
 W4akyI7bVXn2/H47s6tMci+F5o1MbM1saKs1yot360gvJrGGKB7GwM6hiopAv/UU
 sLg2rjYUt/E3W1rlieNmd4jEVVYmw1vbi1fQq9FlnFj5W0ZlW3Toog9CCiMdcvdK
 Jjcp8Q==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dv7wut3s1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 20:38:55 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2bdf6fe90a9so2869506eec.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 13:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777581534; x=1778186334; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=54T5hcINubNCcwaMGkVx4ajHGLNd1sHSAIGwNUp8J0A=;
 b=d25h2+MAf7TUaF4+0rQ9wFMwHTatGC7qzqYH4OOlXwrWCUX9c4w7Aci2p5Epgjib8f
 vNKqYFuAV1JmfhnNqVjwFyUCJ1RzfUnUFb2J4Q+USTK+Wo4YHSkcm36QMrc6bkb5Toa9
 SWl3014ClbxtnnmhMs9qwLXaCAYtEWt7NCVyveLeUlEGWDYBppxVRjBa63hygfh56sCV
 hC7RbmE5eiu1hNOvSWLONi25LA1CkmJtSP5B+EEyk/LuIDqIJ75+OnSmIKbKJpu/rvm3
 gHgrDiqkoU7ykRhufTfNHinpYVkt/hWyjhqIJNnAVGIkqCoDhe68dELPBtlAKdkPkFQa
 HLpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777581534; x=1778186334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=54T5hcINubNCcwaMGkVx4ajHGLNd1sHSAIGwNUp8J0A=;
 b=Y7HAHGyu4o3uMJgDUjE15+wQoaD00sbV3mbFjh9CzofXwsy/rf3bYtYJ7gHhnXkV68
 Oup93zPZVVVMeq1opZiihw0gTYH3zdsca3zDSfg29WBhUg4gdSec4lF8Ao8H5Yr2u3QZ
 3/GBkTF+XT8uZmkziSM2wAJ8hLF4kb6OlRyb2b7/QD14H1ahYyTOFNXUC7sWBCwkFQSR
 OZ0Pk0Ee415Va1U1ePLaADfwmOLVvIg2rivbQK+QH4zVH0LccDXQr8iZFD3h0DzdYodZ
 7D1XSGFTkgOl3soCoqJ6g6eV+jo3eg4qZhINGvy7/Q2V3lKnu5cy1X1Tpqsaz7iJloZG
 DNBw==
X-Gm-Message-State: AOJu0YxkpcPlBfynjYROcTWmKkPJARgXjGWz89sLXfTn3v2Wm/cFRPnS
 sMM++3lR1J34fDLk4GE0m/R24+ovrmFJ8PMkxGHRNHFptF27XIYEOPXKLIDU6HYVzG7fWOFyRqa
 kUku5luKPjXnAPU/fwj2PZCsjPbHOvDsD4OOy3K01cB1OVlv4DMG9upuO2obwAlgiI2nX
X-Gm-Gg: AeBDietzegLF/NcI2JyDvRn8KX2jIlcvGIxJIxbqD2sc0+R0WK+Ekd15Qi/Ul5GLxGl
 A4x3b6lhhRPB/9TP/oGjKnxoLGNctyabbeAcgRUrGVYPGVb4zXNaQan7337DcVCDrhuf6BHM5Bx
 GaJekrdEFQQgvN38J/AOAvvgupuku/r1k/2G/02OHxOW0nbEG7GX8vlYhf3wPBA8ooW5GPIML6E
 5jnyv2ApHsqU+5OIUgJTbB9wZd+s5yBDieRyma7N1y0RjV0xiUinWwn7wCI9XFcTtNjX3QTl0ta
 FuOC+BC3pxPGh7xnEgKcqZV+Dl7w3rPT2lO/GBNgi018h4vghjc7jKzj/ViNr5hrrHdpBSJ0CwR
 88W7E0XCpGSP1eRfUVmF3pvoeLOqyRX8kv6mgdPwWu47n0frPLwsWY8bKp4Rzxn86p40I9GjNmh
 L1M6cBOs+l/PnkgGNR
X-Received: by 2002:a05:7300:5411:b0:2d1:e92c:f7ff with SMTP id
 5a478bee46e88-2ed3c5c9e16mr2196138eec.1.1777581533626; 
 Thu, 30 Apr 2026 13:38:53 -0700 (PDT)
X-Received: by 2002:a05:7300:5411:b0:2d1:e92c:f7ff with SMTP id
 5a478bee46e88-2ed3c5c9e16mr2196122eec.1.1777581533119; 
 Thu, 30 Apr 2026 13:38:53 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ee3889d628sm2202341eec.6.2026.04.30.13.38.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 13:38:52 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 marcandre.lureau@redhat.com, Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 4/8] target-info: extract target_info() definition in
 target-info-init.h
Date: Thu, 30 Apr 2026 13:38:38 -0700
Message-ID: <20260430203842.29156-5-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430203842.29156-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260430203842.29156-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDIxMyBTYWx0ZWRfX4S8a3OkR5SI2
 JOMs2YPnPvjjxkLHLPcYaTzhXFoPlPz67kWvHd17o+5SAyD61mpQ6XURUNcafQkJUiynR0rQdte
 dXPMFga10M1D/ebaQpM4Pa3Lkz9IY4F1yw4QnG/MasU48tvvoqfPswm2EjZ2ncYH54n9hshx9qy
 JM9p3by05hGShVLZJ9oyDyytIAs1JB0KdkFoVkc+5TcWp+VE8BIvVu5G9R+usBQYzbt95cqXSxV
 1xN+xBpnEj8qF9nRzAMgjaclffWNlJSC7GotmXjgO4FYi6JU/u8bhl1ISLvPQhEHe2Ywub68/eM
 cDCZPfRNFiPUzzVET7U6E5cNa5NjJmYxU2uYk3QkQq7CpTWsq+hVu+oWSt4NxDz1fqryjax0O0h
 jYr8cjmU967ScwSj1jURlb3/ydf7My7+e9QMcZiwL14r0bjuKEuA8oM/OV42i8TdoZPuZOVwVJ5
 fwX2sDXfnS5EbEUk6/w==
X-Proofpoint-ORIG-GUID: tcp0dW_brYjFam10FaHr1rGJHOvwztjC
X-Proofpoint-GUID: tcp0dW_brYjFam10FaHr1rGJHOvwztjC
X-Authority-Analysis: v=2.4 cv=GMk41ONK c=1 sm=1 tr=0 ts=69f3bddf cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=090slgBn3MrHMI8nANcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_06,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604300213
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This allows us to prepare next commits, which will introduce qom
registration for system mode.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 configs/targets/aarch64-softmmu.c |  6 ++----
 configs/targets/arm-softmmu.c     |  6 ++----
 include/qemu/target-info-init.h   | 21 +++++++++++++++++++++
 target-info-stub.c                |  6 ++----
 4 files changed, 27 insertions(+), 12 deletions(-)
 create mode 100644 include/qemu/target-info-init.h

diff --git a/configs/targets/aarch64-softmmu.c b/configs/targets/aarch64-softmmu.c
index 82ccb575759..75d95b0e743 100644
--- a/configs/targets/aarch64-softmmu.c
+++ b/configs/targets/aarch64-softmmu.c
@@ -8,6 +8,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/target-info-impl.h"
+#include "qemu/target-info-init.h"
 #include "hw/arm/machines-qom.h"
 #include "target/arm/cpu-qom.h"
 #include "target/arm/cpu-param.h"
@@ -23,7 +24,4 @@ static const TargetInfo target_info_aarch64_system = {
     .page_bits_init = TARGET_PAGE_BITS_LEGACY,
 };
 
-const TargetInfo *target_info(void)
-{
-    return &target_info_aarch64_system;
-}
+target_info_init(target_info_aarch64_system)
diff --git a/configs/targets/arm-softmmu.c b/configs/targets/arm-softmmu.c
index 18940e51e55..73546fa5737 100644
--- a/configs/targets/arm-softmmu.c
+++ b/configs/targets/arm-softmmu.c
@@ -8,6 +8,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/target-info-impl.h"
+#include "qemu/target-info-init.h"
 #include "hw/arm/machines-qom.h"
 #include "target/arm/cpu-qom.h"
 #include "target/arm/cpu-param.h"
@@ -23,7 +24,4 @@ static const TargetInfo target_info_arm_system = {
     .page_bits_init = TARGET_PAGE_BITS_LEGACY,
 };
 
-const TargetInfo *target_info(void)
-{
-    return &target_info_arm_system;
-}
+target_info_init(target_info_arm_system)
diff --git a/include/qemu/target-info-init.h b/include/qemu/target-info-init.h
new file mode 100644
index 00000000000..c781cfc0590
--- /dev/null
+++ b/include/qemu/target-info-init.h
@@ -0,0 +1,21 @@
+/*
+ * QEMU target info initialization
+ *
+ * Copyright (c) Qualcomm
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This file is included by each file defining a TargetInfo structure and is
+ * responsible for registering it.
+ */
+
+#ifndef TARGET_INFO_DEF_H
+#define TARGET_INFO_DEF_H
+
+#define target_info_init(ti_var)        \
+const TargetInfo *target_info(void)     \
+{                                       \
+    return &ti_var;                     \
+}
+
+#endif /* TARGET_INFO_DEF_H */
diff --git a/target-info-stub.c b/target-info-stub.c
index f5896a72621..af7cdc5e67a 100644
--- a/target-info-stub.c
+++ b/target-info-stub.c
@@ -9,6 +9,7 @@
 #include "qemu/osdep.h"
 #include "qemu/target-info.h"
 #include "qemu/target-info-impl.h"
+#include "qemu/target-info-init.h"
 #include "hw/core/boards.h"
 #include "cpu.h"
 #include "exec/page-vary.h"
@@ -40,7 +41,4 @@ static const TargetInfo target_info_stub = {
 #endif
 };
 
-const TargetInfo *target_info(void)
-{
-    return &target_info_stub;
-}
+target_info_init(target_info_stub)
-- 
2.43.0


