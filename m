Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCA13CD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 18:31:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMrtA-0001Jv-LS; Tue, 12 May 2026 14:31:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMrsa-0001F6-JV
 for qemu-devel@nongnu.org; Tue, 12 May 2026 14:30:54 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMrsU-00017Q-Qq
 for qemu-devel@nongnu.org; Tue, 12 May 2026 14:30:50 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64CE1hab3581955
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 18:30:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 IeFS2Ua8iDempqR2GwraBi/JI/P6JIfPkDjadgcDfak=; b=BHjU8wJCmOfLOcH1
 UFhJtAt4a8nLKKTvwZe3QyWvpvjtMyKqhSYADSFsuh2+XbvcZgT/uXnXN4faou++
 HszJcwd2G/2pvSexjx6169cIXX4Ws1g9JiKPjJ74PVMz0Yxplimv6sPb1PSBhpGw
 8c+8ujT1DtWcQDklo8XYQEuWRO0AcJQ3113uZ9GM/3b8zOZv2gGpyLULnU84bi8Q
 F8QFeH1zM47l1sIApVQ8u3C4vaBi27j/J59CiUaThHuC9Km21QtWVw4NVl3F0Qqk
 R86fd3oPQcj7Hfxl/zCl92evmPxR3MCgD3VO8Iw8D581V0OH+jUuOiNb58OeC8iZ
 EiOrKg==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e43w1sggu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 18:30:45 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1329791f18fso7816327c88.1
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 11:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778610644; x=1779215444; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IeFS2Ua8iDempqR2GwraBi/JI/P6JIfPkDjadgcDfak=;
 b=kwQAQYcvFxmtxvhfEkLh+KcB/d09czmiZQhiwY54mUQ8AI2OHifca33QPLI51rpPYA
 UGA73wlo1L0cJiBYJ721XyHEBMtDM3eZn152ws6dAQOvGFLNf5HpDO41rXygIJ6CNI4I
 eKSlJvxGqZteoDk2GyBXleTs36BsZpbMj6FHEoIvrZQdRTCtNArPwT48rSsRjg/iAtKX
 UXiMQoCbc/dacqcenmcDz81vvqKouqrNGGVocrTYOR+CAw/5Sp4Sj+UVY559ZLM4HHdT
 i7hdUfjeMCGOwpT84fZDxObLBniEiwD0xsomZUxg1+YjlqlmzlAXh3V+7CaPZgP4mxAp
 njow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778610644; x=1779215444;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IeFS2Ua8iDempqR2GwraBi/JI/P6JIfPkDjadgcDfak=;
 b=r4DCINJ6feGTTMJ6F3bj0uO0Ox6PxY/o2YMOibA5D4spNeJOOhPrTHaOYvryHtwWQH
 1YdRlNBiD1W6kEyW0x0ZgPESx2tc8rRQQRoB4gZnkIPLgPIs+Eq6/mOONbr10l6jQ8/b
 zrT0dI5nLYOp44BS6Fp+BkLCzYOR6WsgPOkd0QK20AEYhQrxj+uvweTTgYEWeYxeVIPF
 9hH1mbAmDaJVyPfSV2ZzGs2K/fH2ozQ22qeQbcKJ079R+X1m3wFPDyZb1EIr8z34Yym1
 39btGT/itfw6p9kKH1ClnGR4qdfqGC+Ug31l+O2I0DUo5WRbjqb40yuuf49IfGCuozw5
 EMhg==
X-Gm-Message-State: AOJu0Yy7UDi1/84L/N/FQ51eLg9l+ccaSwNdKT6h3T8M/2MZriOnli0a
 G+Q3NQ7dDPly6zrHUZWaha36rX5Ogv8dmaKACswPaDqdHtH9O0FHO7EvGHXy4d3R4wsVB3Svzry
 uXl7ggT/CMexNHxu9PfT11Buq4NUvNVJI29fip/3Zv7/lnHN9oHpsW2txFuXeLe99XnQ3
X-Gm-Gg: Acq92OF60IH1xb01/FI7Jl2xn7fWDaNiZyYf5wGUGRqAcP31BA+Wpn7POXwwbVYbjtL
 lL4hVkZ9k1TFyC1+RDbiXedeuVx469coc8lWtqDsnmsF4KY8F95qnTjjP+DDshq7hQ8s9RWdVF2
 AIXfhlATALhppks57EyKWQaSX9zbNHmJbnEq9E2OXuWSVahZvTM0nKFmEUJc7CPF5OknxCLFz43
 NJ+84bwj56NayCWHL7ZwJnZ56IS0U6GWw4Es/CEQmCjhkH51UqAfw1qayL82JZrsOAR8b30Cdz4
 UuVSBXwmaFITwEyew4Bv15GbRz7LgQj/oK4h3i8yUz1jm8c3XK3aVqxOxUmrLYMUbQFVLmGhhpg
 pSwxlrppmwbynGeqUmKlQJAIsoLR0CFEkLuhL9tgI1bgVku7DaXhHsOJmxFShG+HfOqlc6d7o2q
 ZM66nqHg==
X-Received: by 2002:a05:7022:51f:b0:128:d450:bc76 with SMTP id
 a92af1059eb24-13436ba5839mr42333c88.26.1778610644136; 
 Tue, 12 May 2026 11:30:44 -0700 (PDT)
X-Received: by 2002:a05:7022:51f:b0:128:d450:bc76 with SMTP id
 a92af1059eb24-13436ba5839mr42312c88.26.1778610643458; 
 Tue, 12 May 2026 11:30:43 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1327865955fsm25221376c88.11.2026.05.12.11.30.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 11:30:42 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 3/5] target-info: introduce TargetInfo in QOM
Date: Tue, 12 May 2026 11:30:28 -0700
Message-ID: <20260512183030.1431103-4-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512183030.1431103-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260512183030.1431103-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: sJJjkaUdqNs3p8jgLRHII2xt6u-7us7l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDE5MiBTYWx0ZWRfX35mgqJvbAt8W
 pqRwey2gD556ivF9qRj16SO/vS0+34o2WiloNOuuATfxtt/xy7BfXBREjk1avZtOwEr8eX1RP1M
 pFpTkdf4nY9L0eQQ9XulWhMHNLOFp0K3/281ZOSfo+4bplyoJG/w0GjnirUxdSijdWvwrvaNsWx
 9VsDhlhJ1rd+Ss8Exlfh2AQH+h07B+z2PtTV6TvtehFOEpUc8NZt4+9wqOxJds3CTfq+S4GaPxZ
 BzHBPTOITgoeaaP71FXM8z6SPTofsH/AmCyp9Vqapk46TWzP0oFRK3fF7l4Fsu9keU1HGKxNJr4
 7GfBiLZeOBOUahemfL/8rzIfsXaPh1UW3Ez4x6GEj0VSafWnS5BSPYIxXnewbaxlgcrwcSgS7SK
 Ly/4VPz3gxnKspzQQZmFeCJNLsru97YZZUvrvErtR8ggNeXD8bVhNMwRaWRZn0U2xugWeGa4sqq
 TSStp47NHRasAoEUdSw==
X-Proofpoint-ORIG-GUID: sJJjkaUdqNs3p8jgLRHII2xt6u-7us7l
X-Authority-Analysis: v=2.4 cv=BoGtB4X5 c=1 sm=1 tr=0 ts=6a0371d5 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=m9jNp3DcQOUD3SP0qqEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015
 impostorscore=0 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120192
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260512150208.1167711-4-pierrick.bouvier@oss.qualcomm.com
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


