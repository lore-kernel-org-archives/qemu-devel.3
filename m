Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 816E9CD3440
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 22:49:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKOZC-0006Pd-KL; Tue, 05 May 2026 18:48:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wKOZB-0006P0-FC
 for qemu-devel@nongnu.org; Tue, 05 May 2026 18:48:37 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wKOZ9-0006A9-N6
 for qemu-devel@nongnu.org; Tue, 05 May 2026 18:48:37 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 645LxGnR3502578
 for <qemu-devel@nongnu.org>; Tue, 5 May 2026 22:48:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=AhTTTeOqFwk
 W4Zdn/+Bo3rQ7uW49WhpNkEu1S14lZqM=; b=g4FXS12SE9m4pId1ae2+f5UsSNg
 B4uTcGifBFxUPV8BBb09y6yjJfxSRMxH9F19UEePof39QH0OD+fRVe6lhmIVREnj
 awegfQ+BCa6gobQqq1UEQWhFimkII44jT6Su6nu8X9bTQpgoWNeV2qcFlBlUogXw
 GexBch8Y38TyO0PwbGiCktyv1c4lWC5ZbuBoYkw4yqES5gax4EFHgwguGBYSOsKp
 d7i8nQFmK0ILKZ/0ezVaIBrQfcxlCK+c+JhZRdUvRoSf5DcVtF5H0iAHudonTXrn
 FuRjCnXbREonQjrOPuSbgpno/31V8qKZfwT2WWIpyuhqca8nFrE1iq+QjOA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dyhqfa28n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 22:48:34 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2f2d983d109so1920444eec.0
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 15:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778021314; x=1778626114; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AhTTTeOqFwkW4Zdn/+Bo3rQ7uW49WhpNkEu1S14lZqM=;
 b=izTk8+N7DjH2ni/I6ru4Hb7Btzt8Lc6QTYwFXQpF35CXY2Z5Sd4tEW9cs7gK2eh+4O
 EtYK8ji4OdzcyDhllwpdR8rEmdyifGtlNhcosaTfE3lXMA3+7etJBkWA1vUcLY5PLxKk
 YowD/9eCoXhot0Hs19WlbOGmV53vjiJ7Y5Dc4Jlb+DO597vrNsNSvbdMQ8tyUkAF87XX
 ux28qihaIVgi42J54QA3IAPDABrm/NY/p++aoyyuZInSol0oWg/5LxCgaVWcGmSbZRq/
 WyXkHAd8I7Qexg52RZW+yRQIHanOJZzZnkqzHo5sx2fpjGAfdBWIAdbCEkLzCg86lQ4G
 a9FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778021314; x=1778626114;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AhTTTeOqFwkW4Zdn/+Bo3rQ7uW49WhpNkEu1S14lZqM=;
 b=PywRAFfQGCfLKVjonnBR1KLlbdIk0kEqA89+OG4cJ4sMTl2GqLPQ34etb0mjjhEdWr
 E593kTJGouY+jXw+rNQWLDMYBKWM4D70v3qZ+Zqp6aokLKI6KXLln2hDA65p8DNgey0p
 /N4wZxi8hTBtzgdoS2ck2JG8mCTSXL2DleRYabq8RUwFIfpZ+bPDJmt8Yk3RnnWprMCc
 XxWWcsHFKzmzyGkmY8acT74n5hhbtuKJPWdKT4HA8rsYKo/8HCy9mRN+NwlfYimZ8OeP
 eUbXIx/ZNxJq0nymQgewsA6lYnXniuMq+V/BY9jfKZZPSYsNZc6XMqDQ4Kcpqjr/Q/Fc
 awlA==
X-Gm-Message-State: AOJu0Yw5kRaczRDCXX4ID9rwVNaCIMI+oEjrJSrgmOE9rZFXzn4WQNUw
 1kEm4sbWNIy7o7NKdgBSfZBHNvSngKw+R1+LxhpP8JCExaAwxYxN6EjpsgdeKT4qeCc/c8/KjDN
 ugOLGdUwTrSKUZM3JE8bcdcpjGMHPP1mNYj9z/DjX61V+fq+mVH0yTzQODC3MxJwqehYb
X-Gm-Gg: AeBDievrA0ZdWEz2t2L9AlAEQHB5QIGk+zvHCHRVUfJx4SJHVm/QzhjtoligcZQdjiZ
 dNlQDcCQL3snqSATCFu6p46+EX70x9SusGv6TMgiBbvOFQN65GBSgHS6O6G5r95Nks1ocEsM/0/
 qZDSKTYDkCdkUrwsPkZ2tWZRMOf3DKCQ/U7XQFBF8RlUR5iooB+s+SpymRpXrbWPoMITW4jPPCx
 QkGHCiYe8jZlMc4HbMz8HHjJhu0cWGsvUOm2eyKpcNnXgbyuqgGbr/nXyK188HoufF+jDnx1PW6
 tKHxd9+lr1cfjiYgrarED9RyMqrc4P5awPSM15nEcEVQgFG6BnpFIQ7Z6HBmdSY4GF0/cZeNxM1
 TbXjsVS7MKOPsvWYpCLlJSKHh1d4XOxTtQwar9RZZ91oAtpnSR1v1X6kW18H71FcYcRO8c/7NWg
 Jm3fJB1bViZAyorDKE
X-Received: by 2002:a05:693c:3013:b0:2e7:af57:3b72 with SMTP id
 5a478bee46e88-2f54b89a18bmr639800eec.29.1778021313543; 
 Tue, 05 May 2026 15:48:33 -0700 (PDT)
X-Received: by 2002:a05:693c:3013:b0:2e7:af57:3b72 with SMTP id
 5a478bee46e88-2f54b89a18bmr639781eec.29.1778021312890; 
 Tue, 05 May 2026 15:48:32 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f56d4cf2fdsm898953eec.8.2026.05.05.15.48.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 15:48:32 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, marcandre.lureau@redhat.com,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v4 4/6] target-info: introduce TargetInfo in QOM
Date: Tue,  5 May 2026 15:48:24 -0700
Message-ID: <20260505224826.2698753-5-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260505224826.2698753-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260505224826.2698753-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDIyMiBTYWx0ZWRfX6Vv1fgSu6DkO
 BdXI44o/iWx4Y9jYGsgIRWkyPvHMjUjVq3DMQ0tbk2gnN78PmsxM8p7u2yCe3XfW1N/B/Xrrt8B
 ceWyI/b7qVkUxC1zJLiZW4ujArvSI8De1Bugm5+ynEZnnznw/EZKCJlsWtD0MbBOvh/O/EguOza
 SfUirxEupA0XMxy08Khg17bXIDt4vcGfax8znG70Zn4VxnuComxMdeN1NTQFcWJbUL6O+Jh0dUN
 qvDYdEXes5JAL1sHprieYmlx74JSMXqMB92Oq4+ia//Ms+auWeMJl6bVlbmW6TAV1DBDm4Ab6Ny
 ILk9QdpRYCWr77YDRxOjz8zEpXxEeUaFBa2uhsmKvwB7Tli0QX2AtQYu/hZI5qSi1a5ZVEtZXlo
 /cZ9XKcf0DdeWvm1UUAp5aA/lRERffuOXyQqXoXcc1mcHo8iH3SGyaLtIlKa7AH+vWfqCTGOE3Q
 UND9g+WJs0OgZM/nGbw==
X-Proofpoint-ORIG-GUID: iSTjazkW4zrmfIqkbHYR7DMtAbHZ6uXq
X-Proofpoint-GUID: iSTjazkW4zrmfIqkbHYR7DMtAbHZ6uXq
X-Authority-Analysis: v=2.4 cv=NPvlPU6g c=1 sm=1 tr=0 ts=69fa73c2 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=ifg725Mek7oY8M_gCSsA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605050222
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
 include/qemu/module.h           |  1 +
 include/qemu/target-info-init.h | 57 +++++++++++++++++++++++++++++++++
 include/qemu/target-info-qom.h  | 28 ++++++++++++++++
 system/vl.c                     |  2 ++
 target-info-qom.c               | 14 ++++++++
 5 files changed, 102 insertions(+)
 create mode 100644 include/qemu/target-info-qom.h

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
index c781cfc0590..859451c672e 100644
--- a/include/qemu/target-info-init.h
+++ b/include/qemu/target-info-init.h
@@ -12,10 +12,67 @@
 #ifndef TARGET_INFO_DEF_H
 #define TARGET_INFO_DEF_H
 
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
 #define target_info_init(ti_var)        \
 const TargetInfo *target_info(void)     \
 {                                       \
     return &ti_var;                     \
 }
 
+#else /* CONFIG_USER_ONLY */
+
+#include "qemu/target-info-qom.h"
+#include "qom/object.h"
+
+#define TYPE_TARGET_INFO_TARGET TYPE_TARGET_INFO"-"TARGET_NAME
+
+typedef struct TargetInfoQomTarget {
+    TargetInfoQom parent;
+} TargetInfoQomTarget;
+
+typedef struct TargetInfoQomTargetClass {
+    TargetInfoQomClass parent_class;
+} TargetInfoQomTargetClass;
+
+OBJECT_DECLARE_TYPE(TargetInfoQomTarget, TargetInfoQomTargetClass, TARGET_INFO_TARGET)
+
+#define target_info_init(ti_var)                                            \
+const TargetInfo *target_info(void)                                         \
+{                                                                           \
+    return &ti_var;                                                         \
+}                                                                           \
+                                                                            \
+static void target_info_qom_class_init(ObjectClass *oc, const void * data)  \
+{                                                                           \
+    TargetInfoQomTargetClass *klass = TARGET_INFO_TARGET_CLASS(oc);         \
+    klass->parent_class.target_info = &ti_var;                              \
+}                                                                           \
+                                                                            \
+static const TypeInfo target_info_qom_target_type_info = {                  \
+    .name = TYPE_TARGET_INFO_TARGET,                                        \
+    .parent = TYPE_TARGET_INFO,                                             \
+    .instance_size = sizeof(TargetInfoQomTarget),                           \
+    .class_size = sizeof(TargetInfoQomTargetClass),                         \
+    .class_init = target_info_qom_class_init,                               \
+    .abstract = false,                                                      \
+};                                                                          \
+                                                                            \
+DEFINE_TARGET_INFO_TYPE(target_info_qom_target_type_info)
+
+#endif /* CONFIG_USER_ONLY */
+#endif /* COMPILING_PER_TARGET */
+
 #endif /* TARGET_INFO_DEF_H */
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
index 516ed7890b4..2b6739271ba 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2890,6 +2890,8 @@ void qemu_init(int argc, char **argv)
 
     os_setup_limits();
 
+    module_call_init(MODULE_INIT_TARGET_INFO);
+
     module_init_info(qemu_modinfo);
     module_allow_arch(target_name());
 
diff --git a/target-info-qom.c b/target-info-qom.c
index 7fd58d24818..ba2c7923760 100644
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
@@ -22,3 +26,13 @@ static const TypeInfo target_info_types[] = {
 };
 
 DEFINE_TYPES(target_info_types)
+
+static const TypeInfo target_info_parent_type = {
+    .name = TYPE_TARGET_INFO,
+    .parent = TYPE_OBJECT,
+    .instance_size = sizeof(TargetInfoQom),
+    .class_size = sizeof(TargetInfoQomClass),
+    .abstract = true,
+};
+
+DEFINE_TARGET_INFO_TYPE(target_info_parent_type)
-- 
2.43.0


