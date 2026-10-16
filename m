Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80DB5CC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 16:26:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHkkS-0007r3-FM; Fri, 16 Oct 2026 12:25:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHkkN-0007oy-8e
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 12:25:31 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHkkJ-0002iv-L6
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 12:25:30 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GE5jwK3506108
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 16:25:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=6gx+VmiTRzU
 esWuow6fTtQeEy9ntdLs0G1JbSeO9bJo=; b=mDMoouNOJYYl/Ikc5vnYO1UQxhx
 DPuboROYSUhzYlZOA1K6tuqcbD1pWeSBh/Bnp27VbDAYlU/12eZS95iCH1MQ7eZY
 lm0jTH+w9p/7h42ZxikbCdFlGkHMz12ZgR2D5w2PnRNaCN1khwwINkxole++W3kN
 Q/XTlsoIQPszEtEZI3msWkcCGSnerFathn1B03vsXESXJgxHX7nLys4HgsBS8SHG
 kUKdVaQX+P6Ll9uiwFER7GWX5oXMbGmtMUeiEpEtJRgZwSU57cU0jAQuyWk6mach
 gRr00T6L7XdtAbn4t4u5/zyNBotsIi6wryj8AaLELzbPQxlIGqGZJuYW+/Q==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb8r13efw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 16:25:23 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3a8ae5154e7so238503a91.1
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 09:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792167923; x=1792772723; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6gx+VmiTRzUesWuow6fTtQeEy9ntdLs0G1JbSeO9bJo=;
 b=VJD44feYh6luqEgxLyhMcPEdyWrP3Qw8/wVjsM5iLT6x+SmSqTYdO5DpOH1l6XI1zE
 AS3sLr3kQ3E30kJCTD6eLxDEL3vTMjoVFzTcyp7Ra7STL3aJgz9SAedtBvpYGy/ZRbbP
 EQvPWn0fo3qeCSWi2mwakciFpFgsAaObvZHDI2KHzmkJ8KHjDqPuwbtMYN1VWZnuM/GH
 6LcDPzEzpOf6+ZiZ7QqGluhYbUHuXwc1mj/fTXv8++wqt5LVwUlclxDmOg1X1PMgnx6i
 EetvcCJnzChVifGoK7SVquvdILUvXHd4Qgm4Tg7zDkCLxHAtNgT6aAPIt35HLL8AshSX
 pp2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792167923; x=1792772723;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6gx+VmiTRzUesWuow6fTtQeEy9ntdLs0G1JbSeO9bJo=;
 b=12FlddvhMiXs4QhpBHYJ5zVwOxoNVYvryA732RqMZLk130YfGmKOMn9A2+6dXNaK/n
 okHJi+RQ2lwQB1mvsTyqMyVdMtYOUAagsA2Jmt7e6uZ1L/s5Axf23R699J4WX5nsQU5Z
 7kg9tHvqGMcaN32XFAEkUsN7MzQ/0IyXs+/mYKdQ9em8o7KSG6zI6rBaXYei1ORoskaw
 Y3RRiqtMfyKGbPyNyxTWtav0zlRLXzYgZERkYCVhvZIldBi1lcE5doQ4uRGr4wUFCluO
 mE2yNUomBMzLNzN57MJ/cO3OY9M77E+CQfC0UHh0QXsbak20qB0OwvamQr+jTzyBAr/C
 FSyQ==
X-Gm-Message-State: AFq9FYLTJ6EGwwPAglzmfnzNXu2Oxg4kAER0jqIklI3Yvuigq53df2SU
 A4VpyQU4N3R9ZDaaAZo0Cg6oq/F4SEGzS9F7skMfBcjGMgzE66TbNvIimdrYT/fU3u5e0osrp1Z
 Y6Px9jifjL2z0ihnDcHnx768dwcEXUqTPfor3i6dVIwYNrdsAfM7l44mcQXCgY/uMIg==
X-Gm-Gg: AYBFou3h9L/q51xfdGG3w9WYgsvos1fzigatjaBwHhTAD72YWKI48U7Bckf4Wq1nOtt
 leFZiAA5PdzbkV7DT8TmIzrpBxcRNTk7PrD0T4S0bkFw2OJil245ZUfoOAO9VEH1a0zrynf4j7L
 pOldm9lrkac38xJPydGQlks2Z7//Y1d1o2TWYx7Q3XTe7wmMmjm8WlKbt5IPoNxNErtS2bHsjS7
 KHejTsWMOhR0qz9eEBqWO4D0z3C7V/llU6MVTtHEnp3jusU80PcLiqmFkX6cnXRDh0DZwIf2SYU
 du2QLA4KaxwL35ukpzX32e6koa2Fxy0Y5MV/Njxkf+PJcTi0+Zq6U/5Y6P2HcoVNeLjVzLQJWcf
 OnWe36ssr62gBnbPv77FuPBbfSc2QOKb5Hy7Om7uJJ8+2Kb/QWoPwnkwlAthnjJ8=
X-Received: by 2002:a17:90b:1c08:b0:39e:6c69:7777 with SMTP id
 98e67ed59e1d1-3aceee941bemr274526a91.32.1792167922992; 
 Fri, 16 Oct 2026 09:25:22 -0700 (PDT)
X-Received: by 2002:a17:90b:1c08:b0:39e:6c69:7777 with SMTP id
 98e67ed59e1d1-3aceee941bemr274507a91.32.1792167922433; 
 Fri, 16 Oct 2026 09:25:22 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3acc4872861sm5246143a91.7.2026.10.16.09.25.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 09:25:21 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH 6/6] qmp: reimplement qmp_query_cpu_model_expansion as a
 dispatcher function
Date: Fri, 16 Oct 2026 16:25:09 +0000
Message-ID: <20261016162509.24854-7-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016162509.24854-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261016162509.24854-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: -1Xz1f3Z-HU-Ct6R1wVyI2WVTJ12qkUd
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA2NSBTYWx0ZWRfX+W5C2dRIbKVK
 rzMDytYAXrNlxw8n069sSjFl6q3LXQUoENm03xXUed19OHkWBoiayJcd8hldqN5Lk2UwxXjH9/w
 NYt3c72ZmLyw9D00KRXAdGuluDcoyRk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA2NSBTYWx0ZWRfX1i5my8ZoV2hi
 RHu4y4SRGF3FhMfSxO7uMHozCuunw/IgPLV9wW5NAuyLsAsc/8eLWhga3hXjFttAJLC9XocVrRy
 WdSK6/nUuANFP3IDoqvHVOsYT+uKhu1+fJ/8lBKkUJBvZbhaPadH+6CR2SEA4L2B+DYFPeObYWM
 UEaytDNsd57PTyiuyRm/WkYmZWnR0SkUvF1+xxTGa6OofxGh1HEmg2L7Lunttf+B/eRtnPLdZRK
 Yso7mAyty79J1uEGvR7U6852uDtPEvF5RAqyqNtX+YibRmgQyBDTQPM8VIMLUH5Dc7ZuR8r5GZq
 zKBN0Kg5gbX1X4Vh6BSxFw7mH03VCSzZ1cswUtqMzfBoeT0HRnCTcgJl//Xi7jU6OS0T3lM2osU
 Fzyou0IRmJ3RmucTvlieLh2rGCucwBJ9sLASsYL6tKuSRpgLGGBvAfS2vpR1IJbaqTYE6V01Gq/
 PLFVu1mCXBIRse1zGjA==
X-Proofpoint-GUID: -1Xz1f3Z-HU-Ct6R1wVyI2WVTJ12qkUd
X-Authority-Analysis: v=2.4 cv=L/CI0OT8 c=1 sm=1 tr=0 ts=6ad24ff3 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=TwiIraw6Pol9d8dIU6MA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 malwarescore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160065
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

Now that we have per target implementations of this function, we simply
dispatch the call to relevant implementation.
This eliminates duplication of qmp_query_cpu_model_expansion symbol.

mips and ppc implementations were unsupported, so remove them and let
them be handled by default case of the dispatcher.

We need to define individual stubs for targets function since each
existing binary only has one variant defined. Stub mechanism works per
compilation unit, thus we need one file per symbol.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 hw/core/machine-qmp-cmds.c            | 26 ++++++++++++++++++++++++++
 stubs/meson.build                     |  1 -
 stubs/qmp-cpu-arm.c                   |  8 ++++++++
 stubs/qmp-cpu-i386.c                  |  8 ++++++++
 stubs/qmp-cpu-loongarch.c             |  8 ++++++++
 stubs/qmp-cpu-riscv.c                 |  8 ++++++++
 stubs/qmp-cpu-s390x.c                 |  8 ++++++++
 stubs/qmp-cpu.c                       | 14 --------------
 target/arm/arm-qmp-cmds.c             |  8 --------
 target/i386/cpu-system.c              |  8 --------
 target/loongarch/loongarch-qmp-cmds.c |  8 --------
 target/mips/system/mips-qmp-cmds.c    |  9 ---------
 target/ppc/ppc-qmp-cmds.c             |  9 ---------
 target/riscv/riscv-qmp-cmds.c         |  8 --------
 target/s390x/cpu_models_system.c      |  8 --------
 15 files changed, 66 insertions(+), 73 deletions(-)
 delete mode 100644 stubs/qmp-cpu.c

diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index 3fee45d568d..07a048d0a9e 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -125,6 +125,32 @@ CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
     }
 }
 
+CpuModelExpansionInfo *
+qmp_query_cpu_model_expansion(CpuModelExpansionType type,
+                              CpuModelInfo *model,
+                              Error **errp)
+{
+    switch (target_arch()) {
+    case SYS_EMU_TARGET_AARCH64:
+    case SYS_EMU_TARGET_ARM:
+        return qmp_query_arm_cpu_model_expansion(type, model, errp);
+    case SYS_EMU_TARGET_I386:
+    case SYS_EMU_TARGET_X86_64:
+        return qmp_query_i386_cpu_model_expansion(type, model, errp);
+    case SYS_EMU_TARGET_LOONGARCH64:
+        return qmp_query_loongarch_cpu_model_expansion(type, model, errp);
+    case SYS_EMU_TARGET_RISCV32:
+    case SYS_EMU_TARGET_RISCV64:
+        return qmp_query_riscv_cpu_model_expansion(type, model, errp);
+    case SYS_EMU_TARGET_S390X:
+        return qmp_query_s390x_cpu_model_expansion(type, model, errp);
+    default:
+        error_setg(errp,
+                   "CPU model expansion is not supported on this target");
+        return NULL;
+    }
+}
+
 MachineInfoList *qmp_query_machines(bool has_compat_props, bool compat_props,
                                     Error **errp)
 {
diff --git a/stubs/meson.build b/stubs/meson.build
index dcb67ce5295..7ad326f16d6 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -85,7 +85,6 @@ if have_system
   stub_ss.add(files('qmp-i386-sev.c'))
   stub_ss.add(files('qmp-i386-sgx.c'))
   stub_ss.add(files('qmp-i386-xen.c'))
-  stub_ss.add(files('qmp-cpu.c'))
   stub_ss.add(files('qmp-cpu-arm.c'))
   stub_ss.add(files('qmp-cpu-i386.c'))
   stub_ss.add(files('qmp-cpu-loongarch.c'))
diff --git a/stubs/qmp-cpu-arm.c b/stubs/qmp-cpu-arm.c
index 6249d7bde8d..0336508ac9a 100644
--- a/stubs/qmp-cpu-arm.c
+++ b/stubs/qmp-cpu-arm.c
@@ -7,3 +7,11 @@ CpuDefinitionInfoList *qmp_query_arm_cpu_definitions(Error **errp)
 {
     g_assert_not_reached();
 }
+
+CpuModelExpansionInfo *
+qmp_query_arm_cpu_model_expansion(CpuModelExpansionType type,
+                                  CpuModelInfo *model,
+                                  Error **errp)
+{
+    g_assert_not_reached();
+}
diff --git a/stubs/qmp-cpu-i386.c b/stubs/qmp-cpu-i386.c
index 4858951f8c2..f8a485c23ea 100644
--- a/stubs/qmp-cpu-i386.c
+++ b/stubs/qmp-cpu-i386.c
@@ -7,3 +7,11 @@ CpuDefinitionInfoList *qmp_query_i386_cpu_definitions(Error **errp)
 {
     g_assert_not_reached();
 }
+
+CpuModelExpansionInfo *
+qmp_query_i386_cpu_model_expansion(CpuModelExpansionType type,
+                                   CpuModelInfo *model,
+                                   Error **errp)
+{
+    g_assert_not_reached();
+}
diff --git a/stubs/qmp-cpu-loongarch.c b/stubs/qmp-cpu-loongarch.c
index 695b6558d7e..42231e816b0 100644
--- a/stubs/qmp-cpu-loongarch.c
+++ b/stubs/qmp-cpu-loongarch.c
@@ -7,3 +7,11 @@ CpuDefinitionInfoList *qmp_query_loongarch_cpu_definitions(Error **errp)
 {
     g_assert_not_reached();
 }
+
+CpuModelExpansionInfo *
+qmp_query_loongarch_cpu_model_expansion(CpuModelExpansionType type,
+                                        CpuModelInfo *model,
+                                        Error **errp)
+{
+    g_assert_not_reached();
+}
diff --git a/stubs/qmp-cpu-riscv.c b/stubs/qmp-cpu-riscv.c
index ce500ffa3f3..a448f060e22 100644
--- a/stubs/qmp-cpu-riscv.c
+++ b/stubs/qmp-cpu-riscv.c
@@ -7,3 +7,11 @@ CpuDefinitionInfoList *qmp_query_riscv_cpu_definitions(Error **errp)
 {
     g_assert_not_reached();
 }
+
+CpuModelExpansionInfo *
+qmp_query_riscv_cpu_model_expansion(CpuModelExpansionType type,
+                                    CpuModelInfo *model,
+                                    Error **errp)
+{
+    g_assert_not_reached();
+}
diff --git a/stubs/qmp-cpu-s390x.c b/stubs/qmp-cpu-s390x.c
index 4556072a226..e664ddd68dd 100644
--- a/stubs/qmp-cpu-s390x.c
+++ b/stubs/qmp-cpu-s390x.c
@@ -10,6 +10,14 @@ CpuDefinitionInfoList *qmp_query_s390x_cpu_definitions(Error **errp)
     g_assert_not_reached();
 }
 
+CpuModelExpansionInfo *
+qmp_query_s390x_cpu_model_expansion(CpuModelExpansionType type,
+                                    CpuModelInfo *model,
+                                    Error **errp)
+{
+    g_assert_not_reached();
+}
+
 CpuModelCompareInfo *
 qmp_query_cpu_model_comparison(CpuModelInfo *infoa,
                                CpuModelInfo *infob,
diff --git a/stubs/qmp-cpu.c b/stubs/qmp-cpu.c
deleted file mode 100644
index ac185f09f2d..00000000000
--- a/stubs/qmp-cpu.c
+++ /dev/null
@@ -1,14 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-
-#include "qemu/osdep.h"
-#include "qapi/error.h"
-#include "qapi/qapi-commands-machine.h"
-
-CpuModelExpansionInfo *
-qmp_query_cpu_model_expansion(CpuModelExpansionType type,
-                              CpuModelInfo *model,
-                              Error **errp)
-{
-    error_setg(errp, "CPU model expansion is not supported on this target");
-    return NULL;
-}
diff --git a/target/arm/arm-qmp-cmds.c b/target/arm/arm-qmp-cmds.c
index 2614aea258f..9d3a3d9aa47 100644
--- a/target/arm/arm-qmp-cmds.c
+++ b/target/arm/arm-qmp-cmds.c
@@ -203,14 +203,6 @@ qmp_query_arm_cpu_model_expansion(CpuModelExpansionType type,
     return expansion_info;
 }
 
-CpuModelExpansionInfo *
-qmp_query_cpu_model_expansion(CpuModelExpansionType type,
-                              CpuModelInfo *model,
-                              Error **errp)
-{
-    return qmp_query_arm_cpu_model_expansion(type, model, errp);
-}
-
 static void arm_cpu_add_definition(gpointer data, gpointer user_data)
 {
     ObjectClass *oc = data;
diff --git a/target/i386/cpu-system.c b/target/i386/cpu-system.c
index f85dc4a7036..c03cece7bd8 100644
--- a/target/i386/cpu-system.c
+++ b/target/i386/cpu-system.c
@@ -242,14 +242,6 @@ out:
     return ret;
 }
 
-CpuModelExpansionInfo *
-qmp_query_cpu_model_expansion(CpuModelExpansionType type,
-                              CpuModelInfo *model,
-                              Error **errp)
-{
-    return qmp_query_i386_cpu_model_expansion(type, model, errp);
-}
-
 void cpu_clear_apic_feature(CPUX86State *env)
 {
     env->features[FEAT_1_EDX] &= ~CPUID_APIC;
diff --git a/target/loongarch/loongarch-qmp-cmds.c b/target/loongarch/loongarch-qmp-cmds.c
index 59f8069d8f2..99ccd47fce1 100644
--- a/target/loongarch/loongarch-qmp-cmds.c
+++ b/target/loongarch/loongarch-qmp-cmds.c
@@ -135,11 +135,3 @@ qmp_query_loongarch_cpu_model_expansion(CpuModelExpansionType type,
 
     return expansion_info;
 }
-
-CpuModelExpansionInfo *
-qmp_query_cpu_model_expansion(CpuModelExpansionType type,
-                              CpuModelInfo *model,
-                              Error **errp)
-{
-    return qmp_query_loongarch_cpu_model_expansion(type, model, errp);
-}
diff --git a/target/mips/system/mips-qmp-cmds.c b/target/mips/system/mips-qmp-cmds.c
index ccbdbf8877a..66f70ddac68 100644
--- a/target/mips/system/mips-qmp-cmds.c
+++ b/target/mips/system/mips-qmp-cmds.c
@@ -13,15 +13,6 @@
 #include "system/qmp-cpu.h"
 #include "cpu.h"
 
-CpuModelExpansionInfo *
-qmp_query_cpu_model_expansion(CpuModelExpansionType type,
-                              CpuModelInfo *model,
-                              Error **errp)
-{
-    error_setg(errp, "CPU model expansion is not supported on this target");
-    return NULL;
-}
-
 static void mips_cpu_add_definition(gpointer data, gpointer user_data)
 {
     ObjectClass *oc = data;
diff --git a/target/ppc/ppc-qmp-cmds.c b/target/ppc/ppc-qmp-cmds.c
index 1338233ee63..98ea8291cad 100644
--- a/target/ppc/ppc-qmp-cmds.c
+++ b/target/ppc/ppc-qmp-cmds.c
@@ -31,15 +31,6 @@
 #include "cpu-models.h"
 #include "cpu-qom.h"
 
-CpuModelExpansionInfo *
-qmp_query_cpu_model_expansion(CpuModelExpansionType type,
-                              CpuModelInfo *model,
-                              Error **errp)
-{
-    error_setg(errp, "CPU model expansion is not supported on this target");
-    return NULL;
-}
-
 static void ppc_cpu_defs_entry(gpointer data, gpointer user_data)
 {
     ObjectClass *oc = data;
diff --git a/target/riscv/riscv-qmp-cmds.c b/target/riscv/riscv-qmp-cmds.c
index d60c6073bbe..4d94cd9b51f 100644
--- a/target/riscv/riscv-qmp-cmds.c
+++ b/target/riscv/riscv-qmp-cmds.c
@@ -227,11 +227,3 @@ qmp_query_riscv_cpu_model_expansion(CpuModelExpansionType type,
 
     return expansion_info;
 }
-
-CpuModelExpansionInfo *
-qmp_query_cpu_model_expansion(CpuModelExpansionType type,
-                              CpuModelInfo *model,
-                              Error **errp)
-{
-    return qmp_query_riscv_cpu_model_expansion(type, model, errp);
-}
diff --git a/target/s390x/cpu_models_system.c b/target/s390x/cpu_models_system.c
index ccfc918b383..5cf6469f0c2 100644
--- a/target/s390x/cpu_models_system.c
+++ b/target/s390x/cpu_models_system.c
@@ -260,14 +260,6 @@ qmp_query_s390x_cpu_model_expansion(CpuModelExpansionType type,
     return expansion_info;
 }
 
-CpuModelExpansionInfo *
-qmp_query_cpu_model_expansion(CpuModelExpansionType type,
-                              CpuModelInfo *model,
-                              Error **errp)
-{
-    return qmp_query_s390x_cpu_model_expansion(type, model, errp);
-}
-
 static void list_add_feat(const char *name, void *opaque)
 {
     strList **last = (strList **) opaque;
-- 
2.43.0


