Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6FF4FF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 04:23:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIIw1-0007K7-0u; Thu, 30 Apr 2026 00:23:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIIw0-0007Jw-16
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 00:23:32 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIIvy-0002F3-74
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 00:23:31 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63TKbLCw1809063
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 03:56:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=xfLeX6nDP2/
 hjLdoKs0SPJ5/YVK0jgrqpGAQdDj4cIQ=; b=G9wuj7rjzq+U71GY7nH2E3TasjZ
 TgHw5brOlW2RRKz28a+lwuPGhfN4DeM5ZOsMfMSQg5EQjjDU2uHC0Kr12KZsthaY
 72nhvLCWivFIc4DMCEL5wicyAZooQprp7CARDqzXUGahevd3RYG1nc//s6p7xQhm
 mAwg5rLAPlrga79oYujzzZ7iL1VvVUIw5y1bwuq9kJxyk8nsIpmuc8RxJl09S0Zn
 npSq0i6rtFn7qlvD8YUF+VItbXCHQ3yFo2rjrF7ca36WBgWvXdcvAg3A/hy7gBat
 6uVL9GQBJkHJYtFmTnJ0L6oCxXxklXJdJLtncRPhemk8e9NK5w4LIJVSc3Q==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4duj6tb04y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 03:56:35 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-12dbf4f678eso2193358c88.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 20:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777521394; x=1778126194; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xfLeX6nDP2/hjLdoKs0SPJ5/YVK0jgrqpGAQdDj4cIQ=;
 b=YLJP1vOvqXZ80vV5sMi9JjwXzyz3gLWCTFiMjgofjm2XxVsudNWZcTCJMBPnVJVMLY
 ZEAyGuDmsVGPPVX3U9reTeQXPQ2VowqTufzEmMyxN+Zy8iPCBSCKfuuiqfg7C5j5B/+4
 AHgyhaHn03vWE2t/mo21ScEn5QDWRsCHua/I98gKhKj4T/R8e2Xsby8b0+w/SnjdxY4v
 ZCzqkmT8a4HO366WY2ksOXi3zRKQdkU75w/wi24cMSvGmtUWNghcZnikQ1MDA63cFTjU
 rKKfvzNqfNp214NaMLUfyTHBJoi0TAbjRsrpzZD/suSdigMRrr/LSDYfHGZmutt0u/ww
 8koQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777521394; x=1778126194;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xfLeX6nDP2/hjLdoKs0SPJ5/YVK0jgrqpGAQdDj4cIQ=;
 b=a0rmmFe68T25w3f0Fdx24ygl+gnHsiUawogaZh0KWbp5/61pi1t5qq9B1e2Jh20Jpe
 7hbW2WkHo2S3XZZve4ifqQqJjFsYWQiRGW/N5GXP8ZqZOlz+hCj9zEAm/3InQvk+OdD2
 ErmH8IFAyg1Bnge5ZR9ao3y7dHZVPsIRpvSvu/4deIPz1nq3HSY28N5LmfaNWpGdpDoF
 u/Zo00aAY899FcLel3Oko1N694hrlaVrK2a9qvGrUONvQg8o+9FXC/yxzZMB/nXS+/sJ
 zhnFztL8pQFOPZEC99+Ol1QWrkYw3LZs+IRcZmpDD7BTOUzu2vgWt/fipNnpuMRbxjFk
 Fgqg==
X-Gm-Message-State: AOJu0YyMplZMI6Gv1CasXgpbHA+PCBT4ApAt2mYz1WxXM1q4JWru95Lz
 XNjSteZAZJwFSK4spbeKFXlRn1+uiesPra0OjCYH13Q4iJvL3e2YzZiEwNwUsmvgz4GfGFUCK7x
 HwtK+UkfphezShzPkv1I2RYRyqTSfXSapWJV+ILQZY9x9KbS7V4en33bpKfa47n9bU6NW
X-Gm-Gg: AeBDiev6c7F0HYOncpT1gv+ZRL+A/vit+9qqOSNEmcCbiRuWTt8ZXX0bC2ZNCxkUMGS
 PAp8GSUEYFVJiMiOVu643jSZOYIhb2J1YXvzvgDJRTnztkxT+U3Jir2LujmaIBA3j1HXo66V4Fe
 EaKt8j6Byd+dY27z2BbpJSZtdc7+N1pgP30ARHs/3UjA645xOqsKptzErrLwpfKPSLl9XByBRsb
 XJtqKi5DU9jSxLcHdsgbzhGZSJuVhpUdjX+nmDLXnEIDiMIDHU+Gwa3WK8XxiZQ4Zl2QrLhc+9p
 S5jBzBTf+P1kpEWxmDbY9NaT0sglrDIa3f3jGcm+SZa1wmYJepDyrlOhZe06hrEmOfYXMUYwGGa
 LQk24LrnSi2Cq6iY91Oy6r6yf77ZfBpWa1HzX97c940+banTyhzheLBBL6+uZJgFkGZcMrt8mPR
 9SdixH1p0RG2KRK8E2
X-Received: by 2002:a05:7022:986:b0:11b:ec5f:1c37 with SMTP id
 a92af1059eb24-12deb01bca8mr649428c88.18.1777521394422; 
 Wed, 29 Apr 2026 20:56:34 -0700 (PDT)
X-Received: by 2002:a05:7022:986:b0:11b:ec5f:1c37 with SMTP id
 a92af1059eb24-12deb01bca8mr649416c88.18.1777521393912; 
 Wed, 29 Apr 2026 20:56:33 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12de32173acsm7159443c88.5.2026.04.29.20.56.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 20:56:33 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Anton Johansson <anjo@rev.ng>,
 marcandre.lureau@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 2/7] target-info: introduce TargetInfo in QOM
Date: Wed, 29 Apr 2026 20:56:21 -0700
Message-ID: <20260430035626.3511676-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430035626.3511676-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260430035626.3511676-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 7UOZkDwVkLN8nBxHmm9GvHK_VMpf_CnX
X-Authority-Analysis: v=2.4 cv=KcHidwYD c=1 sm=1 tr=0 ts=69f2d2f3 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=957eaOmehK1HrViG9FMA:9 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-ORIG-GUID: 7UOZkDwVkLN8nBxHmm9GvHK_VMpf_CnX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDAzNiBTYWx0ZWRfX8mc6aC9z15tw
 wxKWo+/zzRbWMNEnaK7AujnpNcZquuc0XXSdC0kQa38tmRxUYHvqmNmf/XvQ81vSe72XVc7Pgay
 3S28u7KrWT17b9W5ddrzkswoldkzL74JTlGsBHeIxVBv6MDKAVUoh15mg72CL55z4VC2xjMgVK2
 AQYDHrYA5Sg8d+WXjROU0cIUXxblp00ppMRolvYbXbPl+CgI8AwRMbAvzOpV6QcjEwBPaBEtlsi
 +N2WJGkkQzT41av/drybz0csHZeqcetuQThaLFEFscSt7UKIyA5sYdQW4KZPWcPiSV1O3YGy4gh
 RiZfjh5nKJsxbfdJh40Mj2Grw/u/TCKRyhbwwA77JIsiIZRWlpmr//dP1WpzVBSebGFNw2Kj/EK
 FOetOW6l7SrmVG1YDcgKpjVSOZAYGCj9HRcvZdiXoTlPncjxSLJWxghlYaxUl0AkafVwX+UaJlT
 TV+/hp542a4fRj5qd0A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604300036
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
 include/qemu/target-info-init.h | 49 +++++++++++++++++++++++++++++++++
 include/qemu/target-info-qom.h  | 28 +++++++++++++++++++
 target-info-qom.c               | 10 +++++++
 3 files changed, 87 insertions(+)
 create mode 100644 include/qemu/target-info-qom.h

diff --git a/include/qemu/target-info-init.h b/include/qemu/target-info-init.h
index 9be06d8523a..1e52ad62820 100644
--- a/include/qemu/target-info-init.h
+++ b/include/qemu/target-info-init.h
@@ -10,11 +10,60 @@
  */
 
 #ifndef TARGET_INFO_DEF_H
+#define TARGET_INFO_DEF_H
 
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


