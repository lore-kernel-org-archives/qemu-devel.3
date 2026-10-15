Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68614CC6B30
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 00:55:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH9ju-0005wS-C1; Wed, 14 Oct 2026 20:54:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH9js-0005vf-BD
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 20:54:32 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH9jq-0002t0-4T
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 20:54:31 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EHQrDA841678
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 00:54:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=vtTxg80m8Zs
 6+DHGCSqpF03MTMyBM+ILg10MlzZsI4g=; b=HePUfCUdrw2TQilVhM1i9EiT3kR
 GlNEQ+X0VTUiVyZGa7Az/zsJQ86/r84XbGImOAeZUltENj+JEA+3cgN10qKo+qG8
 ksOm7U7+DxIPVZnUgjVa8c4uLLGCo410F65kcSSoEbf7gw+aZbq5t7BwGutA0NS3
 E6bNsUydb/yq77Iq0WflKqIbSElvo8hFqA2jeC2ifd9HINHuTHZoZdTwlEf6F0BO
 h+5fB91Xl0ZtorQFe2BfapGH8NF0DzzLOEU4JOH29dhRj9Z+SbJcPZwImCuLAEai
 KdIHYk9XGA8P61b/zoXKwePnR3N88yN2eWM4PrK3TsJ+jYQmi+YD4E0DDdQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hae4wsd0c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 00:54:29 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-3515266f6eeso2823698eec.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 17:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792025668; x=1792630468; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vtTxg80m8Zs6+DHGCSqpF03MTMyBM+ILg10MlzZsI4g=;
 b=jStyO57ErtgGwNaVu5v/3Jl3KqquQ3zssCDiMCJbNS7Uqa+8sb5XhMA6/AOur2vMgU
 qO5+HoZYBgH+BK0L/ZkMWDFB/cyt4o2BUaUBoUOoBDXyPKEEpnyryL10EgQxM48Ks044
 Qg6NgJEMc/L018YL6vFxhtSXKYgViWXXCW8td5XG6MgdeImBW/O+ECSfk+XUivIeYve3
 jpIlwWtYA0ryyXXBV4CcoPTnY2jU/l1u1tXjvrN0p4p8hoRn60ck4tf1cdGvkGOH3v9u
 5u91ASN6aTA/pMS4Zhq4s1QeuV4RTP9VXoYUua0bNk9h7hJ5QAyJZoELEmSnrgABFOwL
 N7Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792025668; x=1792630468;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vtTxg80m8Zs6+DHGCSqpF03MTMyBM+ILg10MlzZsI4g=;
 b=l/bVMKPhI4+j3xgGePW9Po05o3wPTJp2TUYqsH9wtrUkx40BKrxXOoWD2S2MfE4vg9
 YH3wBmM6Ylk/YHZy8E+HPA1IBaS5nccFEPWOWrOctskioCsun78S2/W/PSYYtZmZK2RR
 bn1bcLh4x+NzxSFnbgtQ6IX7YylVYLMx1O9oKAmDkc/GXWfMSyn3DC0OYLoLhWuDu2oj
 RgSlocnI7+3n/9ZEWp95tJtpDeV1SRSJYcyozzLtYqLGRDTZjr3J3p3ItjAldon9tZhR
 Ek+Vd6D8YOukMYDnBzdjBi/zuN3kfE8Rd5Fj9InhlajbNUG2DvBkb7EMv/d5y4oyIEKR
 wwtg==
X-Gm-Message-State: AFq9FYLnHp/XGOQmcECCkXIEj42MrHAPiqbkODRXWj6zZJiyf5ivpu+E
 W6Guxf58NvBw+C9ARu4POHNgIjghhQhQj1IdPh0asgEhwOI9fTqdpb5z/dISW1yNIPbsIK1WsJD
 UjWvu0dIi7k3VepVQR5nQ2UxIUjYVlGjjMkKnqXJ8lxY49wPzlZ3R1qGL3oDqgQTPtw==
X-Gm-Gg: AYBFou1aEzkPYYcE09OScF8IvmtUDgeRb1mSyUKhuyPQPHaQO675xPF/BX6zqllfKKw
 4XCfnrL03dp+ItME2H1u4P62TYWtkAtNuwx5ZbsOAPDPdjYTCc7uPVWErvPjhnZq6xFlw5ujQUh
 6moQkFt5FqgS0+XldbF8jPkE7Y+88C2W6U2ur7kpg2FWDeDFMUL0wbZ3YJUMde+pyWDZ/YwnNOh
 /rODflVEdx4Jth+2xODzZw694BmsOUaeklcGTKxQRSdT0zYJ+n2hCsPadD1n78dXyDrJFTbK8X4
 hgUtgH7JA5jmOZT4ejAXYdDeB5G5g4s9IdTYLhlGeMpkzfnFW0dJ8BK7PhAG4VXELB++J8k5jto
 B/2+jZXpWTZvjY84hEHXohGBDZzd1hBCWoFAYBTc4nZKpOkhzvT/ovbG5JEQd
X-Received: by 2002:a05:7301:f8c:b0:35c:ea0d:a9a6 with SMTP id
 5a478bee46e88-35cea0daeb8mr6278965eec.32.1792025667432; 
 Wed, 14 Oct 2026 17:54:27 -0700 (PDT)
X-Received: by 2002:a05:7301:f8c:b0:35c:ea0d:a9a6 with SMTP id
 5a478bee46e88-35cea0daeb8mr6278931eec.32.1792025666619; 
 Wed, 14 Oct 2026 17:54:26 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537cacb61asm60487033eec.21.2026.10.14.17.54.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 17:54:26 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 8/8] qmp: reimplement qmp_query_cpu_definitions as a
 dispatcher function
Date: Thu, 15 Oct 2026 00:53:55 +0000
Message-ID: <20261015005355.62406-9-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015005355.62406-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261015005355.62406-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAwMyBTYWx0ZWRfXy/6lBGQlT2S/
 QgMiZ4+AxNl5ySdvFOny50Gve/4SW9XZoaCkyq2fXOir3fOutmkeREnwX1JUPfnEpSKbDuzS1RK
 3aVjpmW+LjYVCtYwWxjRRObZA/DZgr4=
X-Proofpoint-ORIG-GUID: hmfW-PvijwuJo-xvfPmNYURTtXIm-kRq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAwMyBTYWx0ZWRfX4alJ6j2XG61U
 XrImB0JPmhmZdvE4PEZOgTbBFnKHKMjn/03ruHlf+ICCKKSYm4dnTNWIhgNrVlmCuEYHZR3iENZ
 7gUnc83lUj2+hSmZFO6lVcU1qEjtLbKwGCs81P2PWkaoiG/Ljo9R6koKnkoL2i1a52jyaSs63zj
 tuAKZGOepcb4wdU5mnT2+vYi9EJ9eQ1+D8dly1jwHpzJc6e4S6Yg6+EyUyvYymWtrwP0y8vrazm
 bljvnyx4JRSnTb0+F47JnGzP2RXbWyDzwHri6LKFDmxE6crCe3zYYUyDA9QQI86/siqR/HZqO6/
 BHLi9jrR4s5M7RUynXZW/kf7huoSWRZTrLxtFgWf28I4t4+tW4F7GIR0BYVlr4fMNeEV0hpF0Y4
 QSYFnSlSmjEZN9QE3cCyzRDaIyXEMATqsvGAQyvCALcKKbQeBVIB8ex8oFZiF9dGxSTsX6Pmntt
 4d8Pjj21I0CICCIfknA==
X-Authority-Analysis: v=2.4 cv=E8BYNqdl c=1 sm=1 tr=0 ts=6ad02445 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=fGHl3LoELX8nfqSJHPAA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: hmfW-PvijwuJo-xvfPmNYURTtXIm-kRq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150003
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

Now that we have per target implementations of this function, we simply
dispatch the call to relevant implementation.
This eliminates duplication of qmp_query_cpu_definitions symbol.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 hw/core/machine-qmp-cmds.c            | 32 +++++++++++++++++++++++++++
 stubs/meson.build                     |  6 +++++
 stubs/qmp-cpu-arm.c                   |  9 ++++++++
 stubs/qmp-cpu-i386.c                  |  9 ++++++++
 stubs/qmp-cpu-loongarch.c             |  9 ++++++++
 stubs/qmp-cpu-mips.c                  |  9 ++++++++
 stubs/qmp-cpu-ppc.c                   |  9 ++++++++
 stubs/qmp-cpu-riscv.c                 |  9 ++++++++
 stubs/qmp-cpu-s390x.c                 |  6 +++++
 stubs/qmp-cpu.c                       |  7 ------
 target/arm/arm-qmp-cmds.c             |  5 -----
 target/i386/cpu.c                     |  5 -----
 target/loongarch/loongarch-qmp-cmds.c |  5 -----
 target/mips/system/mips-qmp-cmds.c    |  5 -----
 target/ppc/ppc-qmp-cmds.c             |  5 -----
 target/riscv/riscv-qmp-cmds.c         |  5 -----
 target/s390x/cpu_models_system.c      |  5 -----
 17 files changed, 98 insertions(+), 42 deletions(-)
 create mode 100644 stubs/qmp-cpu-arm.c
 create mode 100644 stubs/qmp-cpu-i386.c
 create mode 100644 stubs/qmp-cpu-loongarch.c
 create mode 100644 stubs/qmp-cpu-mips.c
 create mode 100644 stubs/qmp-cpu-ppc.c
 create mode 100644 stubs/qmp-cpu-riscv.c

diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index 9c08b17510a..3fee45d568d 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -27,6 +27,7 @@
 #include "system/hostmem.h"
 #include "system/hw_accel.h"
 #include "system/numa.h"
+#include "system/qmp-cpu.h"
 #include "system/ramlist.h"
 #include "system/runstate.h"
 #include "system/system.h"
@@ -93,6 +94,37 @@ CpuInfoFastList *qmp_query_cpus_fast(Error **errp)
     return head;
 }
 
+CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
+{
+    switch (target_arch()) {
+    case SYS_EMU_TARGET_AARCH64:
+    case SYS_EMU_TARGET_ARM:
+        return qmp_query_arm_cpu_definitions(errp);
+    case SYS_EMU_TARGET_I386:
+    case SYS_EMU_TARGET_X86_64:
+        return qmp_query_i386_cpu_definitions(errp);
+    case SYS_EMU_TARGET_LOONGARCH64:
+        return qmp_query_loongarch_cpu_definitions(errp);
+    case SYS_EMU_TARGET_MIPS:
+    case SYS_EMU_TARGET_MIPS64:
+    case SYS_EMU_TARGET_MIPS64EL:
+    case SYS_EMU_TARGET_MIPSEL:
+        return qmp_query_mips_cpu_definitions(errp);
+    case SYS_EMU_TARGET_PPC:
+    case SYS_EMU_TARGET_PPC64:
+        return qmp_query_ppc_cpu_definitions(errp);
+    case SYS_EMU_TARGET_RISCV32:
+    case SYS_EMU_TARGET_RISCV64:
+        return qmp_query_riscv_cpu_definitions(errp);
+    case SYS_EMU_TARGET_S390X:
+        return qmp_query_s390x_cpu_definitions(errp);
+    default:
+        error_setg(errp,
+                   "CPU model definitions are not supported on this target");
+        return NULL;
+    }
+}
+
 MachineInfoList *qmp_query_machines(bool has_compat_props, bool compat_props,
                                     Error **errp)
 {
diff --git a/stubs/meson.build b/stubs/meson.build
index 29b6644b254..dcb67ce5295 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -86,6 +86,12 @@ if have_system
   stub_ss.add(files('qmp-i386-sgx.c'))
   stub_ss.add(files('qmp-i386-xen.c'))
   stub_ss.add(files('qmp-cpu.c'))
+  stub_ss.add(files('qmp-cpu-arm.c'))
+  stub_ss.add(files('qmp-cpu-i386.c'))
+  stub_ss.add(files('qmp-cpu-loongarch.c'))
+  stub_ss.add(files('qmp-cpu-mips.c'))
+  stub_ss.add(files('qmp-cpu-ppc.c'))
+  stub_ss.add(files('qmp-cpu-riscv.c'))
   stub_ss.add(files('qmp-cpu-s390x.c'))
   stub_ss.add(files('qmp-cpu-s390x-kvm.c'))
   if have_hmp
diff --git a/stubs/qmp-cpu-arm.c b/stubs/qmp-cpu-arm.c
new file mode 100644
index 00000000000..6249d7bde8d
--- /dev/null
+++ b/stubs/qmp-cpu-arm.c
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "system/qmp-cpu.h"
+
+CpuDefinitionInfoList *qmp_query_arm_cpu_definitions(Error **errp)
+{
+    g_assert_not_reached();
+}
diff --git a/stubs/qmp-cpu-i386.c b/stubs/qmp-cpu-i386.c
new file mode 100644
index 00000000000..4858951f8c2
--- /dev/null
+++ b/stubs/qmp-cpu-i386.c
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "system/qmp-cpu.h"
+
+CpuDefinitionInfoList *qmp_query_i386_cpu_definitions(Error **errp)
+{
+    g_assert_not_reached();
+}
diff --git a/stubs/qmp-cpu-loongarch.c b/stubs/qmp-cpu-loongarch.c
new file mode 100644
index 00000000000..695b6558d7e
--- /dev/null
+++ b/stubs/qmp-cpu-loongarch.c
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "system/qmp-cpu.h"
+
+CpuDefinitionInfoList *qmp_query_loongarch_cpu_definitions(Error **errp)
+{
+    g_assert_not_reached();
+}
diff --git a/stubs/qmp-cpu-mips.c b/stubs/qmp-cpu-mips.c
new file mode 100644
index 00000000000..4d251d5f078
--- /dev/null
+++ b/stubs/qmp-cpu-mips.c
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "system/qmp-cpu.h"
+
+CpuDefinitionInfoList *qmp_query_mips_cpu_definitions(Error **errp)
+{
+    g_assert_not_reached();
+}
diff --git a/stubs/qmp-cpu-ppc.c b/stubs/qmp-cpu-ppc.c
new file mode 100644
index 00000000000..315461c7db7
--- /dev/null
+++ b/stubs/qmp-cpu-ppc.c
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "system/qmp-cpu.h"
+
+CpuDefinitionInfoList *qmp_query_ppc_cpu_definitions(Error **errp)
+{
+    g_assert_not_reached();
+}
diff --git a/stubs/qmp-cpu-riscv.c b/stubs/qmp-cpu-riscv.c
new file mode 100644
index 00000000000..ce500ffa3f3
--- /dev/null
+++ b/stubs/qmp-cpu-riscv.c
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "system/qmp-cpu.h"
+
+CpuDefinitionInfoList *qmp_query_riscv_cpu_definitions(Error **errp)
+{
+    g_assert_not_reached();
+}
diff --git a/stubs/qmp-cpu-s390x.c b/stubs/qmp-cpu-s390x.c
index 71e794482b5..4556072a226 100644
--- a/stubs/qmp-cpu-s390x.c
+++ b/stubs/qmp-cpu-s390x.c
@@ -3,6 +3,12 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-machine.h"
+#include "system/qmp-cpu.h"
+
+CpuDefinitionInfoList *qmp_query_s390x_cpu_definitions(Error **errp)
+{
+    g_assert_not_reached();
+}
 
 CpuModelCompareInfo *
 qmp_query_cpu_model_comparison(CpuModelInfo *infoa,
diff --git a/stubs/qmp-cpu.c b/stubs/qmp-cpu.c
index a8c7ee89b9d..ac185f09f2d 100644
--- a/stubs/qmp-cpu.c
+++ b/stubs/qmp-cpu.c
@@ -12,10 +12,3 @@ qmp_query_cpu_model_expansion(CpuModelExpansionType type,
     error_setg(errp, "CPU model expansion is not supported on this target");
     return NULL;
 }
-
-CpuDefinitionInfoList *
-qmp_query_cpu_definitions(Error **errp)
-{
-    error_setg(errp, "CPU model definitions are not supported on this target");
-    return NULL;
-}
diff --git a/target/arm/arm-qmp-cmds.c b/target/arm/arm-qmp-cmds.c
index d227a06e2c6..cef0c27db65 100644
--- a/target/arm/arm-qmp-cmds.c
+++ b/target/arm/arm-qmp-cmds.c
@@ -228,8 +228,3 @@ CpuDefinitionInfoList *qmp_query_arm_cpu_definitions(Error **errp)
 
     return cpu_list;
 }
-
-CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
-{
-    return qmp_query_arm_cpu_definitions(errp);
-}
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index dc762b802e1..5da80ade70e 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8201,11 +8201,6 @@ CpuDefinitionInfoList *qmp_query_i386_cpu_definitions(Error **errp)
     return cpu_list;
 }
 
-CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
-{
-    return qmp_query_i386_cpu_definitions(errp);
-}
-
 #endif /* !CONFIG_USER_ONLY */
 
 static uint8_t x86_cpu_get_host_avx10_version(void)
diff --git a/target/loongarch/loongarch-qmp-cmds.c b/target/loongarch/loongarch-qmp-cmds.c
index dadf5de889d..351b6aed7c8 100644
--- a/target/loongarch/loongarch-qmp-cmds.c
+++ b/target/loongarch/loongarch-qmp-cmds.c
@@ -41,11 +41,6 @@ CpuDefinitionInfoList *qmp_query_loongarch_cpu_definitions(Error **errp)
     return cpu_list;
 }
 
-CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
-{
-    return qmp_query_loongarch_cpu_definitions(errp);
-}
-
 static const char *cpu_model_advertised_features[] = {
     "lsx", "lasx", "lbt", "pmu", "kvm-pv-ipi", "kvm-steal-time", "msgint",
     "ptw", NULL
diff --git a/target/mips/system/mips-qmp-cmds.c b/target/mips/system/mips-qmp-cmds.c
index 560c7915365..ccbdbf8877a 100644
--- a/target/mips/system/mips-qmp-cmds.c
+++ b/target/mips/system/mips-qmp-cmds.c
@@ -48,8 +48,3 @@ CpuDefinitionInfoList *qmp_query_mips_cpu_definitions(Error **errp)
 
     return cpu_list;
 }
-
-CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
-{
-    return qmp_query_mips_cpu_definitions(errp);
-}
diff --git a/target/ppc/ppc-qmp-cmds.c b/target/ppc/ppc-qmp-cmds.c
index fe35ae1ac04..1338233ee63 100644
--- a/target/ppc/ppc-qmp-cmds.c
+++ b/target/ppc/ppc-qmp-cmds.c
@@ -83,8 +83,3 @@ CpuDefinitionInfoList *qmp_query_ppc_cpu_definitions(Error **errp)
 
     return cpu_list;
 }
-
-CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
-{
-    return qmp_query_ppc_cpu_definitions(errp);
-}
diff --git a/target/riscv/riscv-qmp-cmds.c b/target/riscv/riscv-qmp-cmds.c
index ccd6ae1d5cf..b70975affed 100644
--- a/target/riscv/riscv-qmp-cmds.c
+++ b/target/riscv/riscv-qmp-cmds.c
@@ -66,11 +66,6 @@ CpuDefinitionInfoList *qmp_query_riscv_cpu_definitions(Error **errp)
     return cpu_list;
 }
 
-CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
-{
-    return qmp_query_riscv_cpu_definitions(errp);
-}
-
 static void riscv_check_if_cpu_available(RISCVCPU *cpu, Error **errp)
 {
     if (!riscv_cpu_accelerator_compatible(cpu)) {
diff --git a/target/s390x/cpu_models_system.c b/target/s390x/cpu_models_system.c
index f963ca5248a..f82b693b0cd 100644
--- a/target/s390x/cpu_models_system.c
+++ b/target/s390x/cpu_models_system.c
@@ -97,11 +97,6 @@ CpuDefinitionInfoList *qmp_query_s390x_cpu_definitions(Error **errp)
     return list_data.list;
 }
 
-CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
-{
-    return qmp_query_s390x_cpu_definitions(errp);
-}
-
 static void cpu_model_from_info(S390CPUModel *model, const CpuModelInfo *info,
                                 const char *info_arg_name, Error **errp)
 {
-- 
2.43.0


