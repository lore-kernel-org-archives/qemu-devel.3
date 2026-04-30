Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80D32FF886F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 04:20:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIItS-0006Tn-Dr; Thu, 30 Apr 2026 00:20:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIItN-0006ON-Te
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 00:20:51 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIItM-0001ry-7T
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 00:20:49 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63TKbLdD2855826
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 03:56:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +xrv2vsliFNoIqj07DnW57E7l3t4q1oodc/gcjFqRpA=; b=FaNY2e6vL5zzUKL5
 kjGBwz7IU10Xu5i7Wnu/a5FlD/+BwK+MCOtNMAHDHuTtCPTqedrHyhhcjIEEbkbL
 2V9YjfyWoMRNI/K18C1EsDpE+dJP8I8oW/dxa9xfovh93GjK+ZlQjZgTc1BcK16A
 muIfhlhrw4E9cCyv1INqj59dV7zKY7/pUAHt2S8MyiWpetI7xqnvgMQw8jQBWcTU
 auAq4HTX/HrlnmZzt3jTTMtLL1+YX8jZLUzRZyr7lGJ70ewNsLZHzHs6qUAuaxuz
 CykA2PPmXCT+PSp1Y/1j/M19sLiMKQWPQjzpYMWC2MEBdHHlNwl94Ik94C49ai6+
 MueE9g==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dukrp2kqj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 03:56:34 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-12c21dbc9c1so1841568c88.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 20:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777521393; x=1778126193; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+xrv2vsliFNoIqj07DnW57E7l3t4q1oodc/gcjFqRpA=;
 b=SIWmsolEg1JwEB0TOU9PHL44j5wqLYXPaLd8jxN8y5xHgk46HUUXXU5a+PhecYSnSQ
 WR9ZOWSOGZfhmHo9Wq3xvX2KtkmLFJOLmMdw5Ea5PrPA6mPKQZV72h6wqFEVgQ8ELuj+
 LNlO4eRpWqRkRBbSCC322GDEHrAEYouvxxjPiS/dxjabrvRcx8h8R0BXfI4UgVTVZN6V
 3jRlJO2v1MxUUQsI+TUjn/XtCOVesZWHLuXjG6JO5HIrO/yahd7wGsudbkF88ZmvdhwU
 +600D5C3iljD1SMQOzNgZG43vIaSlrl8NtSg/C3iP0LFvuGwNYf8PgCdpgKSVrPVbBMs
 JUjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777521393; x=1778126193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+xrv2vsliFNoIqj07DnW57E7l3t4q1oodc/gcjFqRpA=;
 b=ruOWkBloWyyYz0cjS1jC2nUVuroTOdK+Z6RNh2hn3DqBe5AcBSTzeGJLQ9zr2A7/0/
 K7qjU+WCVhJ4afB46O0tDsBzf2sP2dLUaMiwgo1nfvvMbb7fZEe87m/MilMNE6pb5SKj
 m6lOfm+UXzq/jmS3xS63Mkh4E84mcXovinoL5BjE3HUpb/O2y2vGJEcGWPqJmAMlnkh2
 6EzOR3Ei6pokuCswq4sAyVFqca1/v5Zpzdxovn/JstnbL0LLsE1B/bNU2sxUoRDnFe5J
 /D8vdZj4voFQqM4hiiJkT85kHWErIf3EcbrojPVagX12ASnfKwsp4FdNX88GXQOgcX9N
 gtUg==
X-Gm-Message-State: AOJu0YyW6GnPYkx5mOca0KjpOozYGZ7HT/KvPcXMALcierLg00gu4QAl
 7MUOPtGOSOnrH+0L+S2WvIHx8WmEfoWpErErBb01A/Y03IafU28PqItJvlw7h/x40iBeXnAtWhP
 PK28sfrtN8+32qY/nb/xF9/w/Fvyxlehr/cWABBXzFnvOTGi0TeHx3eqKVlkb/AMQ2nL+
X-Gm-Gg: AeBDietBln1OlWsJ8dEeZKt9UTjJbxIzzDAsiLulQI6UAYBdFI+Iq2fnPdOb2PGgfpm
 yhAzVkPMktZ/cON7fy1lgYGdsO0Fcxv+jPe2ukLtjgBKqOaZSLO15uAbXzt6oapu/dsz7aofEbU
 Z4PU9g7B4k3QUj+MXStAKFsUvExhhEF7KCztsEI++amyupKvMBc12O3p6ajuk+VUdilrYh67yOw
 A6ypmOuxmOqRzg3ZdZjxGIgXC6wLSp4xLtq+fRMRe6zocbhyo7P3r20a2qMsBx4P3GZ2ckxkfVA
 gDs478p4lVTi5RUo81GxxSNAvvpeBe5FrbRqr0J33ztCBL7GhyVGvA/9PcoD0w2/8pqssyqdqy7
 HpFOo7siQeP4t4bk32eVSBFctSC6BYA7eHSQUvT/ueYjn55HMFkbroQcZPxihy2o49cWMz0asIp
 JNa/8kxcNtkwDsmxcC
X-Received: by 2002:a05:7022:318:b0:128:bc19:813d with SMTP id
 a92af1059eb24-12deacadc37mr591915c88.27.1777521393508; 
 Wed, 29 Apr 2026 20:56:33 -0700 (PDT)
X-Received: by 2002:a05:7022:318:b0:128:bc19:813d with SMTP id
 a92af1059eb24-12deacadc37mr591907c88.27.1777521393004; 
 Wed, 29 Apr 2026 20:56:33 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12de32173acsm7159443c88.5.2026.04.29.20.56.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 20:56:32 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Anton Johansson <anjo@rev.ng>,
 marcandre.lureau@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 1/7] target-info: extract target_info() definition in
 target-info-init.h
Date: Wed, 29 Apr 2026 20:56:20 -0700
Message-ID: <20260430035626.3511676-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430035626.3511676-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260430035626.3511676-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: xqZf_5xw4_FjJzOw1qou22WR-7SJGCqE
X-Proofpoint-GUID: xqZf_5xw4_FjJzOw1qou22WR-7SJGCqE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDAzNiBTYWx0ZWRfX65woEPAXW8yw
 2Z/tWGu342DqoMkwkPf/nGOKcdhv75m+Y9ZGtO9mNsgVa7xajfiGn/pYWjCVzae2qekMcGBom+W
 j/jcffvjU5rZdOcpPk243aJnlhcp/JubSFdJ7rl96ENqgfwInzr7AVR790kXnhZ6xzrIIWjmeH/
 GARdiwB1Uo8UC0a6a4tfMX+dBlV82xDOJ8ujwnEzrpuclDcMhjkCO4zcTvxhDK6TOBNAeIuEVRK
 qip6MtDoz0hvCyRT/9X2QCYBWO25wvgsdhw3VfK4QzelCqaXK8YYUAuN2al4KWRm7vybh+rwtpT
 iKj3IFNP0WReueJLWlG2tp/YFNzAcB0mOWFHtcbpGJc9W9/V0st9YWTLQRk1QgNdAIfBiUS/9EA
 58GT23iAd+oNEoKpCpuXp3hjw1BC9EMLuw6tDMe91oIF64qAcMQetgAC1wRZavROZ+xrUDBtceQ
 VCL82zEWt+mFfc1+Dkw==
X-Authority-Analysis: v=2.4 cv=WoQb99fv c=1 sm=1 tr=0 ts=69f2d2f2 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=090slgBn3MrHMI8nANcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300036
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

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
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


