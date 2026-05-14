Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D9C3CD4F25
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 17:24:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNZmR-0003cz-Uh; Thu, 14 May 2026 13:23:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNZmL-0003bk-KV
 for qemu-devel@nongnu.org; Thu, 14 May 2026 13:23:22 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNZmJ-0005j2-G1
 for qemu-devel@nongnu.org; Thu, 14 May 2026 13:23:21 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64EBeTU61717872
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 17:23:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 56zJbIUISuyRpp3I63HPlBU6dDH2i8snj2xv/ehIZ0o=; b=kK+ir73FCENJPWov
 UNW9HLCLN+YVoCmGic49XEMliUWeRQLOWxf2eloEsr2AE2Y+0KjafL4NLyUQD4l+
 8e9IJhED0gzSF1fASvfOooU+TlLqRawFGQzSuAPNUOfH/N2TlZ90nwcl84mP+LHK
 2kwbkGwGGhc9G0CqMaOmSmW1cNW3FjTVLAIKbiv4gZ9ovaKm7MY9W53v9Uj7O04R
 l7wIaLjxmGTve/JETcwk3lcv9E99BS3aNZkot20H18PeIRoxSB4qZHSZhhW3dMA2
 NGXphEMzCMojrjPQiT8kyltomtT/IRJ0RNlVkakimbSuO6wtTE4xLMrN1QGb6Qen
 zCqnGw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e57y7jn45-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 17:23:17 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2f3ec2e8d07so5951006eec.1
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 10:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778779394; x=1779384194; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=56zJbIUISuyRpp3I63HPlBU6dDH2i8snj2xv/ehIZ0o=;
 b=gj55NyGbaF/Of9zNUw1WT30fnOuMinBl/3kqRVpuVKxq7lZLlw8JUPK47cWXYJMrWQ
 TBQAVVOLgZ/omy/j7K9n8Gp3N7xZssPOGiX7U3JYzc8i+ZcpiGx2lLL7LT5uYJlS57P2
 uvKgfmQUDeMEQqzkRx+aV3oKHl1n/3uiZp3l+J+LYO66k695b653P70eewZXW1a+3OyA
 X10dfW7tppdO6ecrJpGhLL+Ir4cQIlMbYXn/oYgpLWPqTocVn75uHxUJLwadYdEBe80R
 Ml9Bl4THWLCU0C19Zemu6pA/9o2lCasdO3CR+n38ZyUD+liJFtBVjFE9wtiKqAeaVgqt
 D/jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778779394; x=1779384194;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=56zJbIUISuyRpp3I63HPlBU6dDH2i8snj2xv/ehIZ0o=;
 b=oCwKg65FKC6c+KTSXSIe4KreZIOEVTWu3/lIT/4Sb5dBvlpiWzDBMBc3KA7jzFcLN+
 zLVOWAGeMzFLDZ+WnZXkWqpnUrMbNJJMZv5yaimN3OWEOhU3dvfHz+hX9jdp8GodeXGZ
 Brb7YLtxkMsCu5G4MEoZW2KcMnVQmx5vp9XpzKs+FdsY9khPkG3w7hXfes4vtqVkLsrh
 BBSfn+w4HpqcqK0cuQvPZZu07JWeCeyaTgO7F8De2Pbz+tf3zGQ2syB/xizrCWLHKtSQ
 2OTKm2bVeAuGQ341KMHgfZzPrQ17xZxqMUnF2Vf9nXGt+bP2ZIOU/5D+kJcQldzsaee6
 q+nA==
X-Gm-Message-State: AOJu0Yyk2x52vx6wgvN0L59wT0zHupV675TyjNK7OHSVAkqkBEopKmQS
 4oysp8LhvblZTHBEWNAM6rmRFrhWD0kOpSXq4E5tv28GNXOULjVytBw+BvNBYAW3Hki4MsG56tT
 L1fNjA8TiRr9W7OEDO+//0nvoPZXURQaagbwiizFfSIvUUhZB1LzfYcIE4BbdNJSC2mgd
X-Gm-Gg: Acq92OEsl/NoS8+MKVzg810STXrybk3Dx1fiS6Oefzo5faUa1K7Nst/sw7fJ02CYdTW
 kD+vXhQ+GGivnXhVekpxev9a/OV9iOE+Wi/yL/ms0HuOnbqeCHFpmGs89NwItTtP4LaoXP2+YfN
 oiS5mZ63cu3GG/b20TGYnlBdVAKoN5/PJX9UpE3i/FK3XbAb/O2IIi0s0mEp8YmVEPJc2DNBCH0
 qO2ZAaGndewE+obuTeklH6Bgp1/gdtPXU6V3cklRQS0h3ho/dYVFP3H6L2C1kBPRwb3S7g+/Ed+
 aeAelnyNLHSJcPtM9lcorlKM82zy9iX33ZJNJ1JMayjdbZQVs/Hv5NjKr9kGY52Yw9uFxkjlUoQ
 c2/rp3BqN5lvSh+yplvVoPc8u3V6izfRDwYCzoCnyL82eL/p4+pMfR7GJ9CVjX86IRtYPCMOFB6
 OZFLTbhw==
X-Received: by 2002:a05:7300:6429:b0:2f5:3641:f10f with SMTP id
 5a478bee46e88-30398695003mr236244eec.31.1778779394146; 
 Thu, 14 May 2026 10:23:14 -0700 (PDT)
X-Received: by 2002:a05:7300:6429:b0:2f5:3641:f10f with SMTP id
 5a478bee46e88-30398695003mr236200eec.31.1778779393409; 
 Thu, 14 May 2026 10:23:13 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-302944ffdf0sm3828677eec.8.2026.05.14.10.23.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 10:23:12 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Anton Johansson <anjo@rev.ng>, Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Darren Kenny <darren.kenny@oracle.com>,
 Alexander Bulekov <alxndr@bu.edu>
Subject: [PATCH v7 3/5] target-info: introduce TargetInfo in QOM
Date: Thu, 14 May 2026 10:23:01 -0700
Message-ID: <20260514172303.1484273-4-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260514172303.1484273-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260514172303.1484273-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: r1oT845bYPiHuG222XQBP_Dw2aLG2JcA
X-Authority-Analysis: v=2.4 cv=UY9hjqSN c=1 sm=1 tr=0 ts=6a060505 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1sXc0-TY3SvF7pvsHhYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: r1oT845bYPiHuG222XQBP_Dw2aLG2JcA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDE3NCBTYWx0ZWRfX3ragOK26RD10
 BJYm0ky9u1bePg/0jA8muGYHRm0tBTShhpnoYUDleRv2mlapyc5dVAechHIjnDX9RXEvdSiE6t/
 gFks+NLh3YbqfhLOD1muY4M/y6O//P6J0mhlq456P0dqBTaItmzAUIndK2KmfEpE0LgvfPPoRjL
 0yz7zBydM1b7AuKrCYEf9olh1u3yF+Gsx8hUy9Ba105RhBAAkhipnOnI1R5q7riPXs4aynwE1I8
 2uIUNaLUgQrL+UPAwVygzREDvOg7YWBGMnQ4OHa8WlCCQH32CCh+ZEADYwybdgVMUWjrFMCdBYP
 HHn6Qjc1DLqPP5sUIK0VlnqMJQw34HnfzzhJiufGxIjVJQpvHKwbHodD0i1wnLum0LlO9ygal03
 zdMDc3xg8faRKSTrqXuyha2kOKp+8R5fdL7mYIPQgznhyPBTPt38gQLQdg8r4O0Y0xkvKmQee9p
 yj8MRkRYVcZtt7O4H6g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_04,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605140174
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


