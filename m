Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93D5AFF8875
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 23:46:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHs7p-00035O-60; Tue, 28 Apr 2026 19:45:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wHs7k-00033x-1C
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 19:45:52 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wHs7f-0000TH-VW
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 19:45:50 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63SFscBK2890764
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 23:45:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ohxIldnHtar
 YccrkSr85kEdxo/eY6/u9XDs5GDljwOw=; b=RCd4byhmUS0CKWrpkpASF+l5YxY
 /ksambpPPybdHr7XmT+OLaBq2o5CZ4PWKmD3pn4u+lDmNaUt/c+Z3qbEGP6tkt/I
 x2f8iFPlB2T2Xf6BUujrzjU0smvgtSTcPmffZOoG1+EWU5mzczdzKNwsfMryRvoA
 UnW8Do9WPmZj5gKKJSi8PGGGJz6BwmBopSVpGdw9JQ7oKw0lcO73ncNp8CXUVogx
 /3uCuG9U5RguSKbnnhwmkFPhUwiWY+bvuDBc4S2Ujaa+lyOlE/yfzzab3V83Sb7T
 ytZJEeJFpc+tVpoo8puRTmB/81uIDD+fqXQzUzSCDHw946DWd49zcmG9c7w==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dttgyu0us-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 23:45:45 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2eaf70f3b5fso4246764eec.0
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 16:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777419945; x=1778024745; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ohxIldnHtarYccrkSr85kEdxo/eY6/u9XDs5GDljwOw=;
 b=Fp+lkPlRDdd6Rl2DiPlHcmHlRSi+8lAoAc+gAfgvsyUNw+mIQ9PbuqiweuKXbnApET
 G/ZG635E0rGVaGAs6CTrEe/Rp2B4y8ElNY2roQ3YF7IV7YYSLYwJxqImHbQ60EE0AfeN
 mm6F41esJukodoyVmdZeBtd1nM05PtURCLxzUfxjU0TMKnlFsa6B5hw4HOwuhaLfBy0R
 D7EgGY/KlxKj2IUt6fJ/gHfxgL/RiPZpHlQQHeAFUIBi4RZKeG1rjkrxnBrUy98Mvlxp
 buB7hkFFXpAx7Uuu7IUOnRExoW1b+dcQB07IFIf1VcU2sd5mB2XibriPuVWe6OMqOeKv
 ITfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777419945; x=1778024745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ohxIldnHtarYccrkSr85kEdxo/eY6/u9XDs5GDljwOw=;
 b=s/BOnI7HFZtw1MrY8tASJysX9YwxMT1HxOpqfZtOTie9J+iJp08X5G4bRxH8wY/oHA
 CV4BwVeNX5Xd9nXmdByoNNgduD+8fmZ8pRLxeCTo4mT+0dP1YkXge4NhWRzYK/BYqo1j
 RWQu52a8mliX9vYBDxV/CwGWbpSawNvTDUb2tO2CYxQmyApTpIWJTabecIkodE4hxHtk
 R6C6xhwVKtP0DSdqL06/VctxaBaUUzp/1AuoyCjEnBBVX2qSatzM1T6uagr07gF9Gog4
 BXMpxNNFgsuk2HewNiPRmnO4Jl/yyob26EJs47dy7ro5krEeKHhw7Q7j0twnwcLJB+MJ
 RzqQ==
X-Gm-Message-State: AOJu0YxKfppetz34pSIYC5AZ5PfD+XPdiPtJBqS0hsLlLryg8HY6HJJO
 QDgOxeOjnJkDm7jNI5nYqFVQ05nO/hXAWYiMcLheqUX3tCaV5pox49Mk2d3XwQB/AAMfMeJwlSe
 xW4aNRUrLRjm63DPUPYxaDbCOJb3AWdntz3NOcAXJEvjA1BPuX+80SJHQL/sidSCblj7Z
X-Gm-Gg: AeBDiet2cWpQrJ9FPje+quhBqan5CP7WmuBG1/JHy0kkuw0hJ+/8NjC/wOpxORPKIId
 reoQlO0ygXEnTtomVy4av+wORx769pw00qYmAd5WpBnlnfeUOt1+phqWijzdSDk14p5aW+t/hwJ
 mmBN/zdF0NRLqOAS2Kz8G72lf+f15KRjK+nqDG5+69gVdfYxcVX3EYrywlg+cU7WAZubRm32cZl
 n2cNGDIpE16YpPlxkJ1GzbqCoQQEpluRrxPvCIU6Yp119HRQsBnyVgoRFOYEDgpsiDFu3G6QWVO
 4xIhglmUgnutqPkZs4zeVCI9uzObYfyoIzwjJ8ozjrG1VPL7cT6ZXSMAMOiE5+6KkGbEtbnMrys
 eklyI341sWePyAt/tcws/knXiMnOaehrcHw2kGxFYw1sLyNktjKf2J3zPKujtWb0F8y4RTO08Ib
 PGdc2yHA82Gbsk07tP
X-Received: by 2002:a05:7300:6c22:b0:2ea:7901:8d72 with SMTP id
 5a478bee46e88-2ed0a083f68mr2689930eec.17.1777419944913; 
 Tue, 28 Apr 2026 16:45:44 -0700 (PDT)
X-Received: by 2002:a05:7300:6c22:b0:2ea:7901:8d72 with SMTP id
 5a478bee46e88-2ed0a083f68mr2689890eec.17.1777419943812; 
 Tue, 28 Apr 2026 16:45:43 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ed1bf8ddaasm345300eec.7.2026.04.28.16.45.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 16:45:43 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 1/6] target-info: extract target_info() definition in
 target-info-init.h
Date: Tue, 28 Apr 2026 16:45:14 -0700
Message-ID: <20260428234519.1812371-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260428234519.1812371-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260428234519.1812371-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: MZkr4Rb3rVElu1HAJsfcz64yYfevU5kO
X-Proofpoint-GUID: MZkr4Rb3rVElu1HAJsfcz64yYfevU5kO
X-Authority-Analysis: v=2.4 cv=cb7iaHDM c=1 sm=1 tr=0 ts=69f146aa cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=3m8A-TV8Jbz7CCrNb4oA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDIzNCBTYWx0ZWRfXxPZXXIY2Ir4J
 NlR4NKQBy6uYjtSuAxTFvQ5W75/9O8b5nnxqesotzAi5BRFbkyYIljpg/j18n4BEe7oKvVEHf4c
 fnru/F6vTpYb5NPjCRR1oUZIyYhOIm0CllP70/AUOvu99oKiSkWbGqkzTr7YKTqrEo80JhPP2VP
 7QaMZtw0BfUZwPeeG9k6p8cX1I5AucNqBiRnz+sThakQY0jlaPgZvZ0aksu8O6lzX8jrzsTWSgt
 JYpC3YbgDqom2yXwQzdxl2O1eBHbAQTOdtYu9JzAFU1j2MO3K/yseUJGExXeiiwGwhNzCgwh5Sd
 7yjSPGojCr1bQdRPggiRiXnilLnJVccfpu/cKTdPWlhsluCQip7VCGhKEzNQmzMlu6Y7RVqFAyV
 abIdRmKBU1cn+lseFqmq4Rk8LrOHlFKa77zFFsqmzlIENklvuYyAPGGeRl4Z2zMcJouP9haYBMZ
 N5b8TqVDAj5WYvCFPTw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280234
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 configs/targets/aarch64-softmmu.c |  6 ++----
 configs/targets/arm-softmmu.c     |  6 ++----
 include/qemu/target-info-init.h   | 20 ++++++++++++++++++++
 target-info-stub.c                |  6 ++----
 4 files changed, 26 insertions(+), 12 deletions(-)
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
index 00000000000..9be06d8523a
--- /dev/null
+++ b/include/qemu/target-info-init.h
@@ -0,0 +1,20 @@
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


