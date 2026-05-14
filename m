Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF158CD4F42
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 19:55:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNc8t-00018d-TY; Thu, 14 May 2026 15:54:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNc8s-00018I-35
 for qemu-devel@nongnu.org; Thu, 14 May 2026 15:54:46 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNc8q-00026q-0x
 for qemu-devel@nongnu.org; Thu, 14 May 2026 15:54:45 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64EIpIU33197820
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 19:54:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OdIZ82EZJrL9w7TCShXjKdtdqXWnlNMzUNig8p60ELA=; b=dgyUojKSBebCQeva
 ehAt+7h3ZO9M4ILMIkwcb72wsm1+0qVxIRF8K/mqtF6x08zeXc1bokOdXgle3Fdm
 VOzKAu3lOteAdS6buzLuIdQQlW5soC+1RyuWyAbR3wSxBUnAjkrR7AWaTxaB4dlQ
 9c6pkx4cypf6318BchxD+IzNvx8FC8Map/Qdksxv/SlgSOMfuso85KHo8zFMgo0n
 ysh+f50hnAqIHfEAZUPAHNqiD9yiQM3w0BAs8FFskhxAEP4MOsp65PYJA/H7M3yq
 Kl4T5xEx0ESTsaw8gt2pAHO+Qz350mGcjTkZawzMLo0cILPUIDCblE4T2dP7XWjr
 ZP/Wag==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1q867x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 19:54:43 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2ba9a744f7dso8901179eec.0
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 12:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778788481; x=1779393281; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OdIZ82EZJrL9w7TCShXjKdtdqXWnlNMzUNig8p60ELA=;
 b=L8L+E3gLNhweqDA237hVgF8oogp4ezCAH39Aj8b0mRp6z3CLjMrw4sQfQ98StsdSkl
 Rx4VkJKy0bntK3NVraakPH2fb4j0kXkZCl2up+kUWTIWjWqQaL8m0nvSK8zznfoQNgWC
 5HRRwp5j3LkhLI7+QKVJ54RHhzWd5cx0xM5a/QM7iYm8dBlpbdoMJBg2Tlkg/LJnwGq7
 0NnG2rvcbDRVJppDa5A2sGB11scVtvmKZsHXVhXkCCx6TNsVAZzn4TMf/W0XaRKEO+ad
 ps3q3OaH2EoSkMgW0/hdd/TwbTzEUskLBOPzAqNnKIYfksx6y8lJiJfpdwgRBgk65wtV
 zgYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778788481; x=1779393281;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OdIZ82EZJrL9w7TCShXjKdtdqXWnlNMzUNig8p60ELA=;
 b=jas6lluXfBBOxkf91rMjdIYlniXdxZynRCmzkptINSGJrOh3cEpQ/W0bjm2m5j1o4U
 QHVuOKqiD3mTfe0b7RlTGIr1HSkjWwnZ0TEkNSHTaPO0lKyegNLJUOA2hQmkkOB0lY/i
 cx1fUqKLuNO9qQFSsa1hXRp9UMqCeh8gwAMTB8Mu6/IoufXphuICn2/sNy/MqGsGCjEW
 NIQsCShZMPq4I6ZntJkXf4ijaiIKfM4k0NvWcYo/ABDVAczCXfHyDJGjnVMxuAX8qH/n
 C8ULLNBP1vRWeo8p7X8Q3UA+LKffkHfNh28bHEyC0hgsplTpC4/bsR55yInX2Sbgrnx/
 mSRA==
X-Gm-Message-State: AOJu0Ywyqyj4RP4n4iMZRMhwNssEt4qFPuKAUbg6fzhbY+jrtULf9u4A
 t3mYofiPTZPMtaNxfGnXKQKlhp1gijFKsso4Ma3TXlB8L8c7SrU3ddngJbdPa4yfi+pC7LV4Ffp
 IzycV5t/AQBRkCOVlAoLNxt4z8Bio0RluYwS+CNNkg72nf3Z0eMJNiFASVW2dd4HYHGOm
X-Gm-Gg: Acq92OEsUYwr26XpEZGtgGGe7p5mJiTa5V5+RHljOwmCbTNr7J6MNa3mcNsA40EhnjR
 bWwH/qKuRkB2baPJu+RJJOoifOvfDGtu586TXeGHMJI9sbxH3Pw0QwfxE8TKzQ7/gF9wb4S58Q+
 4lsEjat+BO0oxG6lMJIhS0QZRweJ4BEDJJs6TUQW8FweOWQNNBjQEd30hPkdiYcjAcjqyqE49Xu
 xN/QWhoCo6uhMiatWhFJkBUAlkgTv4jH7xk4wS7w9+U2Or9SIFv7y0kYYTt/9alESXn/BkH+Jdr
 MMe7xlX8f2fVzpEck/79zWgJpbQPiZLEFPxFqbNOMrA1pYmYvZSdZg/OCDyH7SJgz8Ts1ly5UPC
 DxP5cGgp9OPZOep7f+1VxQyVAMW24TxkM8AqxyQPUl6Fajv1JYCtRkc2M1qFWzLoqboHuPw0x1S
 9pcBPny7StWTakVxzz
X-Received: by 2002:a05:7300:e7a2:b0:2ea:b85c:153d with SMTP id
 5a478bee46e88-303986948camr478995eec.27.1778788480351; 
 Thu, 14 May 2026 12:54:40 -0700 (PDT)
X-Received: by 2002:a05:7300:e7a2:b0:2ea:b85c:153d with SMTP id
 5a478bee46e88-303986948camr478973eec.27.1778788479811; 
 Thu, 14 May 2026 12:54:39 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-302973bcc5asm4180636eec.22.2026.05.14.12.54.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 12:54:36 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 3/5] target-info: introduce TargetInfo in QOM
Date: Thu, 14 May 2026 12:54:25 -0700
Message-ID: <20260514195427.1706609-4-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260514195427.1706609-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260514195427.1706609-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: orPG1rKcNQvQIWxg0x3aA1-pbARoH6iV
X-Authority-Analysis: v=2.4 cv=GulyPE1C c=1 sm=1 tr=0 ts=6a062883 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=1sXc0-TY3SvF7pvsHhYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDE5NyBTYWx0ZWRfX2zMcZ+xdHFxE
 tHmNM4VHujycx6bPOMeiTfE+rbTdI1cyOx/xOHa81jBLlJ+ju8/DwvV8IV7raD8HXZX9TUHC1fV
 ss85pY4VlGWKUSe1SgtAYi0NDzvUcrrDtiUraeO/9PEaWuGkSDU1FAx59VPeDMMdtsadpND9W/c
 22itIsbsI4F+vmhxD1JqDlKut/2GnC7w/eVkN3QkI4nxeweeew1lN9PO20jyZVLdIQgOfIzG2uK
 X8pTJWSgSkrgy60GqW1PTDm8C4Pl71UVEQ/RGXhBj3k0V6ee5NqxwWTIykXB8kAb2VG3wHffT/d
 c7kKLX4SKxvodrshrvdiOdueviFWgD5unsWIHzlWwuqnCLEA8w9Z4r6p+WJ+bvIlZ0hqh08wO0L
 3cDYVLIuUfAhqBH1mNh15cx8ajisUEQIrb0ITtA895iR5clBvWQnfkM2S4RR7DU8w5PD9FNvTrI
 SQN+NBEvTvAQlGsQbuw==
X-Proofpoint-ORIG-GUID: orPG1rKcNQvQIWxg0x3aA1-pbARoH6iV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_05,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 clxscore=1015 impostorscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605140197
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260514172303.1484273-4-pierrick.bouvier@oss.qualcomm.com
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
 tests/qtest/fuzz/fuzz.c           |  1 +
 9 files changed, 120 insertions(+), 12 deletions(-)
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
diff --git a/tests/qtest/fuzz/fuzz.c b/tests/qtest/fuzz/fuzz.c
index d2355989616..de230d20e0f 100644
--- a/tests/qtest/fuzz/fuzz.c
+++ b/tests/qtest/fuzz/fuzz.c
@@ -172,6 +172,7 @@ int LLVMFuzzerInitialize(int *argc, char ***argv, char ***envp)
 
     /* Initialize qgraph and modules */
     qos_graph_init();
+    module_call_init(MODULE_INIT_TARGET_INFO);
     module_call_init(MODULE_INIT_FUZZ_TARGET);
     module_call_init(MODULE_INIT_QOM);
     module_call_init(MODULE_INIT_LIBQOS);
-- 
2.43.0


