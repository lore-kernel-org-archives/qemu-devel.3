Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A31B3CD3445
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2026 00:56:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLVyd-0000dU-7G; Fri, 08 May 2026 20:55:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wLVyO-0000Th-VN
 for qemu-devel@nongnu.org; Fri, 08 May 2026 20:55:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wLVyL-0005xw-Qv
 for qemu-devel@nongnu.org; Fri, 08 May 2026 20:55:16 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6490JhC81767965
 for <qemu-devel@nongnu.org>; Sat, 9 May 2026 00:55:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ccJY+iG0pd89Vp/075sBmYMQIkXmTwvv+melW/PueCk=; b=YFPNUj7ZGzSKhn0O
 7mX2eiROdvzOakNGpjCnijDvJKwrZPKIvs3+bE/6uBcdJG4q1PhYWX2GFYDz41Yu
 2SeaQAkQUHu47KXlmHmvgJoR/I9gUcEEvRcSKI7Y1Myz+Gl+qZYf0oVdTEQQEU1W
 MWZ4knGRbYfmaxERAvGTc8PNceNX04iK55UKJ+h6r7KCmAYrsI961Po/lBx2h5Mr
 JenJRL5uI6lNNo0FIBPVxfnW5kfArmGsol9cFUtX8cYiK/c41WkANiLYs7HMrD0d
 a7p8D/9buvcO0DDbc6gTbsA9E/dqlLqBtwp4owdq6mawRQz+fDa2GKxVqSEW4Mwq
 GGKuVg==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1t9q01sw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 09 May 2026 00:55:12 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-12dece274b1so2702810c88.1
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 17:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778288111; x=1778892911; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ccJY+iG0pd89Vp/075sBmYMQIkXmTwvv+melW/PueCk=;
 b=A0n6OmERbQsg+03sIV6/k8Y0RMJNMkULsxVIR6gnOsTTwP+F8vw1TfPjG9v12VO/G4
 tRVvfjV7cVm4r8L4Ump6ndByGp+Yfp4U0bGKe3Nc59dae6Q7Ug1EaZAhyexQzoQmJd8b
 Vroy0ESsdGyqqsG5b6kETsZwsPqltRNp48n75uJTCAr4NT5tMuEYJn+ZMof/ARjH5kVz
 1im1q0FPsEQjs9L3wQ0UIm/I+tsw7piAcNB4u8DadKDmVsDM235S6HOzjv0XNSIouvX9
 T0xwYcOjIdC7GfJXkWHzuLGBMgewHjY7+8TbrrZ+kpB1/0hiQeTBGCKcrwZ/4kBuf2Ni
 Ocpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778288111; x=1778892911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ccJY+iG0pd89Vp/075sBmYMQIkXmTwvv+melW/PueCk=;
 b=jh79VhPx1oWviOYDtP0MCYwGIH5ZD+WkF1x6UyOSFg4EMARXIOhBpDe+deZWWSucyC
 +KVDuu11SVun9f7koUf7b7q/lKzqPi8pAT+K+qOqW078ZOV93D5knnKw3RKdHlxNHaWq
 ZGAtsKGJRMeBGZ5ADIVXoIIjONhuieaBvJFc12YDOcvq4dhT0ScY6CTRq+Gc8ruZ7aKh
 b26V3p/evs2k1xmwZd+wsdAVXecxQxrtSdm4XK8iYfANT/Xt+yjV/bfvhcvt/XgVhw5U
 Xnh0uhoGmtmMaJ0Oy3S3OfmSOP1s63H8a1XK81+7P9xyKesDaY9kVyqGlcqm6OAOktwS
 aNkw==
X-Gm-Message-State: AOJu0YxF2cM4KuLiB+eXOsu/9IulI/FkBGQZXPxtX1bSLM8FFRe0UEuP
 yAUBLw250UTKGrtihbWuSpN35Qh8jJpXVTzV+trh9h5zyHkNLN8E3vHzpOEqBDo80NMLEXvJ4ia
 ddIQ8APSC0dgIm3XN5OHuA+xD4HSbcaMmERGfntKlr65hPLnG09ED3dg+/kfHqvwTyc6q
X-Gm-Gg: AeBDiesgKJKzUd9a6qDAKluIDmlnZuUn1LH1XjpJo6cEJLIuMJOvEucHV3XzvTjiPdf
 WXxVxHABRUHPek9czIxgCVHny4SQ8zOMusdr4z9xX0Brfph8PBQg/jUoINlBJd1iXuTqgdcvRqg
 /+J4XJ+ikUpVpjU8tU0gJqZFYpqWnzkGgVKO9hNEmPIlrEQkLHWQe+Tgwwpgmxi3gvlcQdhOd0i
 NtHiFApfzCb63/jlVybpReYQLBksH/Bbj7Bf5VF/wav9URnxPv7148t9Hj5TOubROpimzxXBR27
 /4fKqvMc0z76Nf5wdSTo2YMaPd8zulcMsuY7/htNJyZh9JS+Vi4foWtWvkyDjfSWXbw9HrNqrRm
 5DPvUvQeKZOVNY9ysW0PUfmGT78mEhP3Rm7/S+dG1u11rk+fnmLKBahBCNDoKy1qPpdiV5MKIym
 Ul+TtYCg==
X-Received: by 2002:a05:7022:625:b0:128:d715:b717 with SMTP id
 a92af1059eb24-131852d534fmr7296470c88.13.1778288111107; 
 Fri, 08 May 2026 17:55:11 -0700 (PDT)
X-Received: by 2002:a05:7022:625:b0:128:d715:b717 with SMTP id
 a92af1059eb24-131852d534fmr7296453c88.13.1778288110512; 
 Fri, 08 May 2026 17:55:10 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f888c3b301sm5352610eec.23.2026.05.08.17.55.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 17:55:09 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH v5 3/6] target-info: extract target_info() definition in
 target-info-init.h
Date: Fri,  8 May 2026 17:54:50 -0700
Message-ID: <20260509005453.3984184-4-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260509005453.3984184-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260509005453.3984184-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: nn1Awcif12AurF78UJb6K7OddsBjBcGv
X-Proofpoint-ORIG-GUID: nn1Awcif12AurF78UJb6K7OddsBjBcGv
X-Authority-Analysis: v=2.4 cv=J7yaKgnS c=1 sm=1 tr=0 ts=69fe85f0 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=l1QZgXgEFyKk2KBU3EsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA5MDAwNiBTYWx0ZWRfX+GP9gaInVIaw
 FNxzKmJeJSX+5K5IQczXYfIIckT7obEczufdvTzSTz+SswF6y2gk2h1JFK0UrZqI18hrYsx7Ev6
 +IUzsnmyb0BH3BNl9GMyXx2U3Amo8aWkKEkrjynBwfkjfal5R/P8sFNRYVl6pBYWuI1l+Mr6tMp
 RN13t6vFXFzMSRW/BYf4CGZBvMIEtU5eweUYCO24No4V3IB65AMlLKGA21L6Okv6QHiKZiygOfp
 FZziuVqyt4+NL5mjsKxypRp5joS54Na95cTDPgVKtVX+neNpdD3VXo3wp91EQ/I4NXY62IqDsnH
 GK+2bwNu1zIIkAjB+8zhFIdLVEG/qdbeV0pat4wfPmxaH1dEaQNybzvEB9WoQrqD2xiBpLaeVbb
 Oe/j8Qrd6qHS85USuNGgE8NSU0SThtZlSru8Q1jlj1ydM1zAwxdFjTXfYakPGEXDEDT4D4qhL8d
 jtW8vTJNOgOC31hjNEQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-09_01,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605090006
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
 configs/targets/aarch64-softmmu.c |  6 +--
 configs/targets/arm-softmmu.c     |  6 +--
 include/qemu/module.h             |  1 +
 include/qemu/target-info-init.h   | 78 +++++++++++++++++++++++++++++++
 include/qemu/target-info-qom.h    | 28 +++++++++++
 system/vl.c                       |  2 +
 target-info-qom.c                 | 14 ++++++
 target-info-stub.c                |  6 +--
 8 files changed, 129 insertions(+), 12 deletions(-)
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
index 00000000000..3f4eda19083
--- /dev/null
+++ b/include/qemu/target-info-init.h
@@ -0,0 +1,78 @@
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


