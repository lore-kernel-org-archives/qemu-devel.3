Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89B87CD3427
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 22:49:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKOZB-0006PO-VM; Tue, 05 May 2026 18:48:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wKOZA-0006Oe-Kk
 for qemu-devel@nongnu.org; Tue, 05 May 2026 18:48:36 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wKOZ8-00069v-RA
 for qemu-devel@nongnu.org; Tue, 05 May 2026 18:48:36 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 645LYYxS3475707
 for <qemu-devel@nongnu.org>; Tue, 5 May 2026 22:48:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 54T5hcINubNCcwaMGkVx4ajHGLNd1sHSAIGwNUp8J0A=; b=YIeMZ/sRCuMkfO8T
 TRcmh2KWCJZE3qOQBniMKFMSmPcmiA/MSCFO0CX3rokgxIYES1cSnZsBLR2EWlM4
 hZiy4cmSZziYanl7FE2nJKfDUxCjA9qFIHsszZbq1ttisjtv5MK6Z4cc7SZcy37g
 ju7APdETSc7HLO37gkLQFM0OazA4N7+1GTbOdP213CB/xdrxOag3vWyAy1+qMhHZ
 NptTvklM2UILmSrJH7xB0qiXttkFX7c+JLt3uCLfVytv4UG32C/sKNmRLnTE5pkx
 pKfo2AeKdrLsUidcDstVhnKxEFdrU2OdOv+MjXxowndQaU7fiXIWx+iq3nL+BhUm
 EzxNIA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dyhsgt33p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 22:48:33 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2c0f6593ef5so8233357eec.1
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 15:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778021312; x=1778626112; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=54T5hcINubNCcwaMGkVx4ajHGLNd1sHSAIGwNUp8J0A=;
 b=TZSQG19xgnH4r3tTCX9EYvQMsluSEkjdwircKR9pC2NqQhrRjHN58gljnb8Ol4PI8P
 wfKRDPvl5ulNQ/RB1wxN6Wtd9bB4pAg+sg52hOQ1SSsZuyP/R7FthdFd3aIiDXUJsMEP
 T4YzqyaYOW/A63Zr5P9R/9M809cLHqO5YErxwtIuhHj7ZEGTbf83MkYdl1THTy0+RRlG
 tbrmvh9rhu6O8vq0gYaqhEpbmyUYiXWXiDz6FJLPNBoMorwVrw7JPqYYrkbVhVmJbD1a
 T41Gkg1e6nTFODewLfMo0T/z/ACDmyVV1qr812IKhSWVcm5nkEQ00f5cWOWFSuIwg3vb
 RsFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778021312; x=1778626112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=54T5hcINubNCcwaMGkVx4ajHGLNd1sHSAIGwNUp8J0A=;
 b=NpGKzqJXnCWp6UCWcfQobpAF8MwSVFauaxqgxWM7/Ulj4D43+z9fEFkWpvotInG5Vc
 mKm/w6r8tNlvrl7x4wWmU/DaTWQTc3DFjTyzgWVIFx8SHDsT+j86lpJrTkmfRSmTQTRd
 KEXV6P4AaVntFQoiKG1LXfjLLLPtyzwIPJyUI1Cc1b4BGWHfD6U86BWzf/PnPr7U8Yom
 CcXXwxgaY4X9hUuUXAT7dUnioXsR0j3eCUMq2VgfdFUMyb85ecCYscTUCLGhMV0xD3XG
 +u+oogAiYz22XXzN/YXJaRS5DuxUw9yi69FBtHqpPlMSqneVGsvphri5g6FiF10Ej6N9
 5omA==
X-Gm-Message-State: AOJu0YyNkUZXEBhvQg5E5M5WgwyuuFqgHYy0qq72olzIoUXaedk7nKFU
 AqI+9nNvcPTtmXEHBeDq5oIOt/Ur9ihwNbhOaNBcTvHiyXJBH8NG+GeBbuj/aq6tBdEFYdddeji
 9VrHaaJF03V99iRFiJ/qevuyl6i5wqFf1DOOe5IjPP1a2X4jGTWI82KiwpOyuQZ+6DN2n
X-Gm-Gg: AeBDiev1DGMHlnK7f8SeeULZOWAp45M9wwDDzUxJvgXiTbHfjIq+/904uDrtcmVjma8
 +uOgaYiU1nHLQTvU2UD1Rkwtt3LnMAbLBasR76WJ4ukj5cefHHfekghW0l/yIuTvtXv7yAplr9u
 UdoSvcApYQE5IQ3xmYOLbUuoc6TnAO3N9ltGUo2yGamjg5b89zMGwYnZ8CqILtjXuZ+84thBedc
 PSa/1BvH/kec6SuPU20uac/n9sNdGoZAEy7afjjuLGwtqHIXGTX5aJbXQxXrsr90oXuhdMDJjNr
 pxlM3WnTcD58OQKak6Q/fHj9WKBuN/22y0r0g2PGZfvVAsEzndFUCCFnX6iMC8dlBXZjXBh3wZX
 q10jlVsi6gyEi1XELdCT6BKtL3AZOw7seGYXgkFExfaHUbutKgAfxk8cUKXZYCT1SdQWVBT54gx
 gVPqp85aR65OR5tb9b
X-Received: by 2002:a05:7300:72d1:b0:2ed:2942:34ab with SMTP id
 5a478bee46e88-2f548897087mr652867eec.3.1778021312404; 
 Tue, 05 May 2026 15:48:32 -0700 (PDT)
X-Received: by 2002:a05:7300:72d1:b0:2ed:2942:34ab with SMTP id
 5a478bee46e88-2f548897087mr652853eec.3.1778021311868; 
 Tue, 05 May 2026 15:48:31 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f56d4cf2fdsm898953eec.8.2026.05.05.15.48.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 15:48:31 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, marcandre.lureau@redhat.com,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v4 3/6] target-info: extract target_info() definition in
 target-info-init.h
Date: Tue,  5 May 2026 15:48:23 -0700
Message-ID: <20260505224826.2698753-4-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260505224826.2698753-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260505224826.2698753-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: yciioyWDmJHi5Wmu-6ygbYOOlv37Pg0Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDIyMiBTYWx0ZWRfX2DyOlFMUQwrL
 x4O6fM7NCJrCKzN3ecD4yKoV8wDOd3kgIVGi0pWARptruiB7hRf2FZtuaEJeWPpPB7rWbqbMi+n
 LHRm7X5sgF940piJ0uf3ZvEXe6FecIWuDKewqhlBcNPCbsaMeZ80jmknXI9MTfdLoY7XMWgLYDn
 WJus41+QvjlMYgU22lHmO933g+R1CNEY6nf5B/uw9Y9zz5Q8egLu8YhfsPQDdvg56tq8KRqaOEu
 EPpKnQb2XWXe6NCkV4OU5BJSxhkFJqWu0th1uuAOKxSXMSOFvt46k3UKq+a6ZuAQHwpy+eZxA8D
 diOvbgK7tXU4GyhHMItjIPoVQMv4e8QHTOMNTakvUz4/k1ju2OZ1z2j6GlL5rAbhn4+4GZEJof2
 G0SemFNFv+wquKXbIbfGab2wtUXE7Nr4dWgkQMMakZRxj9dH7192KKC/aFpo1FZFrCQtP4L8OTK
 cAk/6LEbaujq1ncD9GQ==
X-Authority-Analysis: v=2.4 cv=EPU2FVZC c=1 sm=1 tr=0 ts=69fa73c1 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=090slgBn3MrHMI8nANcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: yciioyWDmJHi5Wmu-6ygbYOOlv37Pg0Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 impostorscore=0 clxscore=1015 bulkscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050222
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


