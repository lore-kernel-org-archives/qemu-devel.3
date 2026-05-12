Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85737CD4F24
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 15:03:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMocw-00085E-46; Tue, 12 May 2026 11:02:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMocu-00084z-GM
 for qemu-devel@nongnu.org; Tue, 12 May 2026 11:02:28 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMocs-0000X1-Go
 for qemu-devel@nongnu.org; Tue, 12 May 2026 11:02:28 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64CDgIJP680110
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 15:02:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=xMn+1LOdsxy
 IbyRBN9t2jq0R9LvLPuckBvIpCMzPrMY=; b=hzM2GH0lg+FbJfWm+TZbtieS3Yf
 vDZQd88GtD8wyRrE4AfCI4gkYcXVEh6OqRB/zsBBMXrbjGwdpSliam9ifuTgxaQl
 JiLHkbzcoqJwEpT9PJO4nblUpg8E5r9BpAH1qvtj/FP5qquaccCD3ca1S5tHClXH
 oG5RzkJt9wrmAW4+EtzCNqDBpgulTg9dEvm3R7VRT6KVbXuRLk04Cu37FZQJFfO6
 9J8iVWKnsaw2RbxXP/z9suw0wNR68R4IwkaY3z0qkSpRGEPwHhH0yCeLm3EkIejg
 HraLdZtFTn/xWD/Q1z70BElM+veOuDqXrAJFgu6FfFlW6mTK+7gE2AzA0lg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e45avgb2r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 15:02:25 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2bda35eab74so4538219eec.0
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 08:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778598144; x=1779202944; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xMn+1LOdsxyIbyRBN9t2jq0R9LvLPuckBvIpCMzPrMY=;
 b=g7CjzIORKhu2fX0BBZRQIVE6mRzYGwilQSvMR7ExsMosF9k/Z2xs3dzb4P0z1YI1BS
 2/NZVXzC2DiwA40PLWVVlv3YWUIY0kcac7DBn+KSKT+aE/6Z0xhz5Tq3eY8afi7o1d0s
 yyRny10Y4229w8E72DCoVMwzjHVPPAXgtjBMNcrCfAyu+u6A6suAJ4gV+sfuzN6fE8uW
 Rvf3TQEjclqR1S03HnejuV09MfzTOlTFz5nVrGaoEhPDupR1Z6t5qEpU1SUHrlNaAczA
 Cal1GRueLb/SXPDdwdRfTCFjNLmACsQd8HWsIHRG1rrpN6hYsVAKnER5JoQXobWYZAai
 EUTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778598144; x=1779202944;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xMn+1LOdsxyIbyRBN9t2jq0R9LvLPuckBvIpCMzPrMY=;
 b=PrSuDoHNhj5Pr0ucxz28FrXTK7TqibtuIrE5zIlv0GZqCSkpEP+5Lwem3KeMyYaf65
 S0UkBFK0aU/ruIC9kYjg+ryIgUWlFDu2nSoTQTgkOXQ9JpgrbpEWUbTeB1wZarDyKIXi
 ZMiXhQBy+OqtsoKuTyHp7L6WUXtOGZp35GQYApFQqSGxmKPC9VA7G3DCa6sZs3H+9qPq
 82u8vOPBsUZ+qPm4wK0JSDaSpaGoG+5KL6KfMwWFm/zFET44KcSNPYMsGIV1b3ICogbf
 UTrRGBObzhoQhXeV+LuFZRE25103B+XPIs7cITN9U5OF+njjh4poj85JmeakCvC1D2z4
 l7kQ==
X-Gm-Message-State: AOJu0YwU2F+AcFDOODQkKBVq1KT6KLFnZezOG2G3nafzEV5oo5tyIFe9
 x6VKqzCLii6CVIDvmr/cnalCkaXuwTGi4uOrk/wXHUDzoexP+8T72/nnrRW2iWJStnCnYHYOCTt
 N8aDzhdweP4a7MfSARu0ziN4UmUuVL8LkXjr/noY9M5jexeHh95yM3Abe2Q==
X-Gm-Gg: Acq92OGdE17TahhBZMWB4s9AI/+Zi/02TEXn9Cm1t1PGkXsOGWg73haV6CdfDthqYvh
 eAR6FimWY+dOkDCLaFkj/tK7O951QvkZsiSHoP+zGwPS6ektxDqMQKAYb1KIBgQOKtYjyXAR0mG
 4s3wF9twnCaUWf88+aOa88gIbaox9/F11w+gUBDdN8wcR7mOIWJ8TW/31DV4US5CMCU5F8scTvq
 WPG/7Madsc8jrGlkCw93vxDBzCg7GdXBXGuWa2u21YXF6QrQAZS920/nbgPqauXR71fcata6R06
 ewSnEFhA13sBNQCVj/SWPxjbGyMuwfOT1w/MbLX2VuFSrUMlTzDLxdjlpnS2livyv+X4svI9SBE
 3o4zh5VmNoswZg+ErOTRAs1VZeF11gyyyZhAPmF3vXxk5Ny4v1g==
X-Received: by 2002:a05:7300:5353:b0:2be:9c19:b34b with SMTP id
 5a478bee46e88-2ff9352aa93mr2615403eec.4.1778598143907; 
 Tue, 12 May 2026 08:02:23 -0700 (PDT)
X-Received: by 2002:a05:7300:5353:b0:2be:9c19:b34b with SMTP id
 5a478bee46e88-2ff9352aa93mr2615305eec.4.1778598142736; 
 Tue, 12 May 2026 08:02:22 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f8862d429asm18270335eec.12.2026.05.12.08.02.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 08:02:21 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 marcandre.lureau@redhat.com, Markus Armbruster <armbru@redhat.com>,
 Anton Johansson <anjo@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v6 3/5] target-info: introduce TargetInfo in QOM
Date: Tue, 12 May 2026 08:02:06 -0700
Message-ID: <20260512150208.1167711-4-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512150208.1167711-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260512150208.1167711-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 0S9DQQ9dOKaOj1T9YaFqAhIHLkKN2WdL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDE1NyBTYWx0ZWRfX+Hlz5L4qBR64
 H2c+XVGJypkDoqwSAMtDPEpA9Q4Gi2p26APWHtJUY6ceHlbVmkAME5SzGJABr0jHA4otBs8IqKN
 eG5qE2xzRKM7xPZs/LaVax3DPh/gdJynqCiwTU8VmniSKz3fU8czYMn8chHEyO17e9CA2jZotpV
 44DfetuP0AFFpeIuFnTLzL1xYJAO5fwrOM1h18NHxRZuTPe9LSUDdoT7ZfF7M1F3zMpNNRzjLy8
 /uCNR44OP9KG3Rdi7gyQBwBtfyjiaPsMimMbtJG/5yDWgUpJ9s7ZdBHT8Vch0kUvaXUJY7+Fk2o
 9p/8cAFXDp390PRqCkR4mON6/u9YpErBG6eZI3xF17wv2JK9wAPcklrELpk3J0eZwkQPGnYL5+h
 dWDV0JoyVwDGZ4BiOUKIAQazRqJlnSk7OktQBveFyQzUDsD/BlhHLK3ZAaaZ7tuVuYX3DGcYNKT
 N1oYrVRgtx8VhTd3rFg==
X-Authority-Analysis: v=2.4 cv=bOwm5v+Z c=1 sm=1 tr=0 ts=6a034101 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=m9jNp3DcQOUD3SP0qqEA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: 0S9DQQ9dOKaOj1T9YaFqAhIHLkKN2WdL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0
 malwarescore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120157
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

For the single-binary, we want to be able to retrieve at runtime the
current target among the different ones available.
A consequence is that we can't rely on existing target_info() definition
since it will create a conflict once more than one target is available.

To solve this, we add TargetInfo in QOM, with this hierarchy.
We define one class "target-info-X" per target, that inherits from
abstract class "target-info". Using concrete vs abstract class ensure we
can easily filter "target-info-X" from all QOM types.
Associated TargetInfo is directly set through class initialization,
without relying on any instance.

For user mode, we simply define target_info() like it was done
previously. In this patch, we keep the same definition for system-mode
also, and it will be replaced in next commits.

We will introduce detection of target from QOM, so we need to make sure
those types are registered early.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 configs/targets/aarch64-softmmu.c |  6 ++--
 configs/targets/arm-softmmu.c     |  6 ++--
 include/qemu/module.h             |  1 +
 include/qemu/target-info-init.h   | 58 +++++++++++++++++++++++++++++++
 include/qemu/target-info-qom.h    | 28 +++++++++++++++
 system/vl.c                       |  2 ++
 target-info-qom.c                 | 24 +++++++++++++
 target-info-stub.c                |  6 ++--
 8 files changed, 119 insertions(+), 12 deletions(-)
 create mode 100644 include/qemu/target-info-init.h
 create mode 100644 include/qemu/target-info-qom.h

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
diff --git a/include/qemu/module.h b/include/qemu/module.h
index 9885ac9afb3..fccf017bf9e 100644
--- a/include/qemu/module.h
+++ b/include/qemu/module.h
@@ -43,6 +43,7 @@ typedef enum {
     MODULE_INIT_MIGRATION,
     MODULE_INIT_BLOCK,
     MODULE_INIT_OPTS,
+    MODULE_INIT_TARGET_INFO,
     MODULE_INIT_QOM,
     MODULE_INIT_TRACE,
     MODULE_INIT_XEN_BACKEND,
diff --git a/include/qemu/target-info-init.h b/include/qemu/target-info-init.h
new file mode 100644
index 00000000000..32c323a7ef9
--- /dev/null
+++ b/include/qemu/target-info-init.h
@@ -0,0 +1,58 @@
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
+#ifndef QEMU_TARGET_INFO_INIT_H
+#define QEMU_TARGET_INFO_INIT_H
+
+#define DEFINE_TARGET_INFO_TYPE(info)                                       \
+static void do_qemu_init_target_info(void)                                  \
+{                                                                           \
+    type_register_static(&info);                                            \
+}                                                                           \
+module_init(do_qemu_init_target_info, MODULE_INIT_TARGET_INFO)
+
+#ifdef COMPILING_PER_TARGET
+#ifdef CONFIG_USER_ONLY
+
+/*
+ * User mode does not support multiple targets in the same binary, so just
+ * define target_info().
+ */
+#define target_info_init(ti_var)        \
+const TargetInfo *target_info(void)     \
+{                                       \
+    return &ti_var;                     \
+}
+
+#else /* CONFIG_USER_ONLY */
+
+#include "qemu/target-info-qom.h"
+#include "qom/object.h"
+
+#define target_info_init(ti_var)                                            \
+const TargetInfo *target_info(void)                                         \
+{                                                                           \
+    return &ti_var;                                                         \
+}                                                                           \
+                                                                            \
+static const TypeInfo target_info_qom_target_type_info = {                  \
+    .name =  TYPE_TARGET_INFO"-"TARGET_NAME,                                \
+    .parent = TYPE_TARGET_INFO,                                             \
+    .instance_size = sizeof(TargetInfoQom),                                 \
+    .class_size = sizeof(TargetInfoQomClass),                               \
+    .class_data = &ti_var,                                                  \
+};                                                                          \
+DEFINE_TARGET_INFO_TYPE(target_info_qom_target_type_info)
+
+#endif /* CONFIG_USER_ONLY */
+#endif /* COMPILING_PER_TARGET */
+
+#endif /* QEMU_TARGET_INFO_INIT_H */
diff --git a/include/qemu/target-info-qom.h b/include/qemu/target-info-qom.h
new file mode 100644
index 00000000000..585995c7ad0
--- /dev/null
+++ b/include/qemu/target-info-qom.h
@@ -0,0 +1,28 @@
+/*
+ * QEMU target info QOM types
+ *
+ * Copyright (c) Qualcomm
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef QEMU_TARGET_INFO_QOM_H
+#define QEMU_TARGET_INFO_QOM_H
+
+#include "qemu/target-info-impl.h"
+#include "qom/object.h"
+
+#define TYPE_TARGET_INFO "target-info"
+
+typedef struct TargetInfoQom {
+    Object parent_obj;
+} TargetInfoQom;
+
+typedef struct TargetInfoQomClass {
+    ObjectClass parent_class;
+    const TargetInfo *target_info;
+} TargetInfoQomClass;
+
+OBJECT_DECLARE_TYPE(TargetInfoQom, TargetInfoQomClass, TARGET_INFO)
+
+#endif /* QEMU_TARGET_INFO_QOM_H */
diff --git a/system/vl.c b/system/vl.c
index d2f4044e5d8..e44da0941d4 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2889,6 +2889,8 @@ void qemu_init(int argc, char **argv)
 
     os_setup_limits();
 
+    module_call_init(MODULE_INIT_TARGET_INFO);
+
     module_init_info(qemu_modinfo);
     module_allow_arch(target_name());
 
diff --git a/target-info-qom.c b/target-info-qom.c
index 7fd58d24818..79752366b61 100644
--- a/target-info-qom.c
+++ b/target-info-qom.c
@@ -7,7 +7,11 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "qom/object.h"
+#include "qemu/target-info-impl.h"
+#include "qemu/target-info-init.h"
+#include "qemu/target-info-qom.h"
 #include "hw/arm/machines-qom.h"
 
 static const TypeInfo target_info_types[] = {
@@ -22,3 +26,23 @@ static const TypeInfo target_info_types[] = {
 };
 
 DEFINE_TYPES(target_info_types)
+
+static void target_info_qom_class_init(ObjectClass *oc, const void * data)
+{
+    TargetInfoQomClass *klass = TARGET_INFO_CLASS(oc);
+    klass->target_info = data;
+}
+
+static const TypeInfo target_info_parent_type = {
+    .name = TYPE_TARGET_INFO,
+    .parent = TYPE_OBJECT,
+    .instance_size = sizeof(TargetInfoQom),
+    .class_size = sizeof(TargetInfoQomClass),
+    /* use class_base_init so children classes can set class_data accordingly */
+    .class_base_init = target_info_qom_class_init,
+    /* children classes will be concrete, which allows to easily query them
+     * without listing this parent class also */
+    .abstract = true,
+};
+
+DEFINE_TARGET_INFO_TYPE(target_info_parent_type)
diff --git a/target-info-stub.c b/target-info-stub.c
index 07d8647ed8e..22b7911201c 100644
--- a/target-info-stub.c
+++ b/target-info-stub.c
@@ -9,6 +9,7 @@
 #include "qemu/osdep.h"
 #include "qemu/target-info.h"
 #include "qemu/target-info-impl.h"
+#include "qemu/target-info-init.h"
 #include "hw/core/boards.h"
 #include "cpu.h"
 #include "exec/cpu-defs.h"
@@ -41,7 +42,4 @@ static const TargetInfo target_info_stub = {
 #endif
 };
 
-const TargetInfo *target_info(void)
-{
-    return &target_info_stub;
-}
+target_info_init(target_info_stub)
-- 
2.43.0


