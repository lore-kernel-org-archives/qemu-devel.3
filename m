Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACE30FF8875
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 23:46:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHs7r-00036R-3E; Tue, 28 Apr 2026 19:45:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wHs7k-00033v-0E
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 19:45:52 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wHs7g-0000U7-3P
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 19:45:50 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63SHZuBC017610
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 23:45:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=K6b8pw+xSqA
 Xu6NNPPl1U4TktwSes6t0a9lSw1GNMHs=; b=mpiN/IcDBD4hgp53zLOAyeJd+ca
 N93bq8Dm1y83s4mkdYo0hS5zMgWj/GYalbJfZN6k5rFOQEFIrgQfi2XOUKFw8GQ9
 Rse4TE/qt8ltOTaRCaXrQHoEMscDOxUOC/nXSnaXql67QJxxCpoKVp//nHYpbmih
 1LfkMPosf4RpwDlx4wVwQ7sgToDar9/S12uD5vBX9DdajM5obUOd+7l1+f4btf2Q
 Ikahb02PxVDr/gSzQ/pfx252LSqsxsDu3YNrOYtdpyA/lRNaC23NKXY/vrkTEuA4
 vx6zO1xqa2mIk6TSmRjUWt+igmHPPaMqSpBZfnpBdRw2vp4zy/FpuPyzWZg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4du1ee92dr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 23:45:46 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2da19227bc1so882583eec.1
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 16:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777419945; x=1778024745; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K6b8pw+xSqAXu6NNPPl1U4TktwSes6t0a9lSw1GNMHs=;
 b=iLBqhSHokJbeOqMpsrzP6tn6wVZLgnhw1bfQ1/FG9cihvE6P3PN2BWRQbfF3TnUOMG
 1mFKs0gggaqTnasOraYrJa1M3smwj8Mt1rSzO/YS20UId1572d8LR3dSBHKCwbXrVmej
 pbYCfoEPUS4fEZxVCfg7UMU4hRWLeu/um+94EwK5BtKGkAIOS4+ntL3nQyfkXhbIoV8T
 Px8YntyMuvkOB/UzGzmdg1a+u08WPHiAInLMKcF3clUKJybiip+f1I3gtkURoMdvOIXO
 Moi7bqjsfenFJSoZGmeZWtZNv1MEzwgALO4+z6CZpT/VUDO8j9opf2RazrzQNVxA+4pA
 /D0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777419945; x=1778024745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=K6b8pw+xSqAXu6NNPPl1U4TktwSes6t0a9lSw1GNMHs=;
 b=j0ba2/EhQfZptzBQsTvoQA4IJxX7IOLy8g26NCTSkT5wDLHDPK6jetxs/YiLx4Dt+n
 HwCGJSXoEyg70gLCFD27kh0FYJmB7nDsJGxDTMWTpNIfTnBVzxfRouZp6R1ZrSnuXZuA
 6UZIkoVRayNyQajolbAwpcrHf94xQbkuf3f24KC2ENPpPZ6yS36d7YyowlIDiU7OJhP9
 7FOT9+2EszOFFHNZjK+UE1mFuIHEiKvXkyoPJ8HlU+0CFs+blhqh62qP1vw6NzGsbvwB
 kONF+2HVqqO1b4Coqk6xk5K6KlapbkEs4D1lycfYXdXWSoJETZtflL3AOAkSIuhTaeog
 7/7g==
X-Gm-Message-State: AOJu0YzaWQwiv8yKg8qFFXL8frW0IhLb5OGJYfdRNEJ/A7Ss2Q/kjo8N
 lDqCZXmuiARadNpm3Wyxaz1+kLnNnGILsnBXsO+R9uLRhbkt7EUoN8kpH7xsvv2vN+O8ebdozS2
 HtgIz1KFdTAO8m3ZMr6xiScUidD0KjH+kfLogWIMqkFf0ZuncwVhTG0cMmSbFCCwxckqo
X-Gm-Gg: AeBDietDVDBP7VOlth1Hpq4OCaJVjukg91yxzJ+WLxfU9+nnGUOIIkdkaEvB8tNdyO6
 /KXLesuW5sy1sIuvZa2VvhfRSs3inBX4k88/Byz5T5R5ynq12umv1uipt6GCEMZKBI35wxO+WmG
 NkpA7OdgSW10jBJXUlElLz+qcq5N5koz07vwmo251kkIErYWBqzm6yoyx7GTdO1Yv84QFvmzLXF
 F9v9QObnbxAXLQU7OcfqCM0entUNC7eNMYvSbxyf2uzAsAMLnyRlHFZ3o9Vq4sJDbltFdFqposT
 SvsHG7kq9HZCZthMWmQVqaiAzvvLnV0lOL4c9DI8N0tF8T8PR7plvkF8KSE7lOnjlT7+ptLnM5E
 JjVSTJUcymSoLauUq6j+gIBisHcC1WTwSKb/Y208HrUyIrIfVfye6JwewjT0a8xLQlH8ClGSMi2
 NcojDugPg+i4LSTubG
X-Received: by 2002:a05:7300:1908:b0:2b8:5159:eca5 with SMTP id
 5a478bee46e88-2ed0a0f47ebmr2812707eec.14.1777419945425; 
 Tue, 28 Apr 2026 16:45:45 -0700 (PDT)
X-Received: by 2002:a05:7300:1908:b0:2b8:5159:eca5 with SMTP id
 5a478bee46e88-2ed0a0f47ebmr2812686eec.14.1777419944900; 
 Tue, 28 Apr 2026 16:45:44 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ed1bf8ddaasm345300eec.7.2026.04.28.16.45.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 16:45:44 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 2/6] target-info: introduce TargetInfo in QOM
Date: Tue, 28 Apr 2026 16:45:15 -0700
Message-ID: <20260428234519.1812371-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260428234519.1812371-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260428234519.1812371-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=C/7ZDwP+ c=1 sm=1 tr=0 ts=69f146aa cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=957eaOmehK1HrViG9FMA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDIzMiBTYWx0ZWRfXzYMVbxZuwBSR
 xXJH58ZKvmvcCY51z3exURa3Xy7rzJC/ehvJyJWPz5xSj5Cw0ZSsIFnENlVIVcgt2JCz6nk8zAw
 /8OQ4QLRwyEll8DSnm+h2JvVX6mGF74tDbW+dBGNhdy3fH2KtoxabElcPekGFB+b/fPoaWj0C8M
 sh0E0fhEaAV6s7oWBacaoA/dD7922HKV46RViuf3Zx0ehR0+bcdW8Xf5jS5AqfjHg1EKn+Cc8aj
 OFXBx/JxWfeFCI0z49X0QybTaDhMrsj/4X8qEB7YmA1q6JmTmnuTMsMwz5QaGfQt0C7kI98HiNF
 mIWR9r874lvZtgxwGRbVYzsLqfi6ROXs7IRWrTtSPEA1Ps/7t66cpNbht+2FNrUeCgfsj6k2ThX
 Ho1oyM4OF9PiBidvFFJgT/I2fNrgPI8HhYcxGTEt/7HNwpD1ww2NMjFkZz3HUyJQgWO/YesNla3
 lmqwp44Z5qtfela7QKA==
X-Proofpoint-GUID: GGOn6CUyqYiFBk0DI-zUHCHR3KrVV4BI
X-Proofpoint-ORIG-GUID: GGOn6CUyqYiFBk0DI-zUHCHR3KrVV4BI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280232
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/qemu/target-info-init.h | 48 +++++++++++++++++++++++++++++++++
 include/qemu/target-info-qom.h  | 23 ++++++++++++++++
 target-info-qom.c               | 10 +++++++
 3 files changed, 81 insertions(+)
 create mode 100644 include/qemu/target-info-qom.h

diff --git a/include/qemu/target-info-init.h b/include/qemu/target-info-init.h
index 9be06d8523a..f3cea985540 100644
--- a/include/qemu/target-info-init.h
+++ b/include/qemu/target-info-init.h
@@ -11,10 +11,58 @@
 
 #ifndef TARGET_INFO_DEF_H
 
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
+static const TypeInfo target_info_qom_target_type_info[] = {                \
+{                                                                           \
+    .name = TYPE_TARGET_INFO_TARGET,                                        \
+    .parent = TYPE_TARGET_INFO,                                             \
+    .instance_size = sizeof(TargetInfoQomTarget),                           \
+    .class_size = sizeof(TargetInfoQomTargetClass),                         \
+    .class_init = target_info_qom_class_init,                               \
+    .abstract = false,                                                      \
+} };                                                                        \
+DEFINE_TYPES(target_info_qom_target_type_info)
+
+#endif /* CONFIG_USER_ONLY */
+
 #endif /* TARGET_INFO_DEF_H */
diff --git a/include/qemu/target-info-qom.h b/include/qemu/target-info-qom.h
new file mode 100644
index 00000000000..db069db718a
--- /dev/null
+++ b/include/qemu/target-info-qom.h
@@ -0,0 +1,23 @@
+/*
+ * QEMU target info QOM types
+ *
+ * Copyright (c) Qualcomm
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
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
diff --git a/target-info-qom.c b/target-info-qom.c
index 7fd58d24818..5ce29f80301 100644
--- a/target-info-qom.c
+++ b/target-info-qom.c
@@ -7,10 +7,20 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "qom/object.h"
+#include "qemu/target-info-impl.h"
+#include "qemu/target-info-qom.h"
 #include "hw/arm/machines-qom.h"
 
 static const TypeInfo target_info_types[] = {
+    {
+        .name = TYPE_TARGET_INFO,
+        .parent = TYPE_OBJECT,
+        .instance_size = sizeof(TargetInfoQom),
+        .class_size = sizeof(TargetInfoQomClass),
+        .abstract = true,
+    },
     {
         .name           = TYPE_TARGET_ARM_MACHINE,
         .parent         = TYPE_INTERFACE,
-- 
2.43.0


