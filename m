Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B05CCA464
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 19:33:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHRC3-0000hH-9Z; Thu, 15 Oct 2026 15:32:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHRBg-0000B8-QW
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 15:32:24 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHRBe-0000at-E9
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 15:32:24 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69FI3OM9406042
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 19:32:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NjweqQkUC0TPCtjTN/YF5lyNfFiSmUuW3/SAatxLYXA=; b=E2aFZ+SReohSPLWV
 SljqRtB7J1h2oybUAIDOfbFCbJkT4LbbDDt1diH9wQshcCpYzS6d9N8bHNZQSrZ9
 msTSX6n3tatWd8dG6GI+WS5NtXsVScKxbcM9iVM1G/r34xMPcdEd8zq3xwmwE2tP
 AjYj7IpoKMHi/L8fcOTJXsjvFaimJZ4USW3oALvLmgPhdKXVCZDlhrv/Ey0Sol6w
 kWK6WwQEESTniJ/PGh1+ThzdtNf1d+CNzqH+OlfVOq7s+wJMFcqxPnv11X5UM35Q
 19VnG9tVyItrIihRIHDxl6MMiALIYRHxHFXcPfG62Hv1QEQn6/Z7w6wZ0sVH4LZh
 ISsc2g==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb3sa09t7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 19:32:11 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-351788121cfso12605080eec.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 12:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792092730; x=1792697530; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NjweqQkUC0TPCtjTN/YF5lyNfFiSmUuW3/SAatxLYXA=;
 b=TqiuIJUKdflI1so+HZXZbz7zsIxKc1BIPnGfeutSwoDd+j19ROhgq26bhH0Jw72QWT
 HIcUp8oLBGHgNoGIrR4QESHihDllW/+vXR4C5ON4piIXF9R913vFgVcZTXg5dkjF+ueQ
 lOxjY7C0q9LHtjMQodgKACq+yA1ZqC45BFmpF2UGPBNajIqsCN3Eed63W/0+nzOMw7pN
 qmljNbS6Xlr1vBh/b5njZEURzE2xwKyILWmtSZ9ol/e27Fv3m0m5RtL5yuVr8F7bQxaE
 KEW95Xi0yf78zov0vIU+T+ZeLIVGeyl6JZraSULqoA1laboT6imIfw7jFmtPHycaAHOR
 HjoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792092730; x=1792697530;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NjweqQkUC0TPCtjTN/YF5lyNfFiSmUuW3/SAatxLYXA=;
 b=s+AHK/HlaIvp6MjHRxDIK5ccrK5ZL1Krb6ea/C5z9jME1IzydhrdqFziZ23537UAst
 tmSqNmbeyH8a6ZEjETtgxpddz+8ipwpcg697L3LXCqe5UE6QE4nBGbOmL5LzltSuF33W
 e1BQ+QiIuk3kHBv1COP7lz7oT9EF2h3aYh05DspUtflzUnRVFf1Dc/XAsWTgJWk2aSWX
 mOyH5MMBapH2XVlqZprqsZC+jNkLrSh/22AvpiqcPCiJiEUp45QIl1hny+WiN98O6ta6
 qoVXZkqINdxRfviC5gZoYtEp7jVmdTyJI1z8jnGf1JyBVoMGleOPsgRgkI08btlEIl69
 tuHw==
X-Gm-Message-State: AFq9FYIeFlTgHG7paTXWOKS/He/B53yvTcc1pSwzSZiq7PRn2hbXHRTF
 RHxlZ4NUK/ymuo8xWMu/fTXn7PDlwPNDtjF9s2Wrq/Gon8AWIHrvfxvIQHQDP6OSsHdCHfFvBa5
 3BAxBaRUrphHroCxxVUJNzr/HDTB+cMt1Ep10Z6nZApvhkdkNjuAWjn7mSzGB/l8EMw==
X-Gm-Gg: AYBFou0UWnkSY7+q4hisHw46J0bKJQ+OV44mp8RE9t2TudA9cu6r/9Ca998SAK0xbwX
 3THNeRjXHrsF3rU3HUNjaCUabl38LfDSPkffMM+kHjaBHiJ5RFq0/BaeGa7lVK06hdhwPnvo2lH
 1MHJ1DrD48OdoWUrRtB4ZCqraBYdlgQru1NOevVnCmXbMdqV6pRLQag53hHdVxzqp4I7n+msJEv
 3hTDaxcMGbEWndxdQLOzoulZkGl3Q+gcvKesJj0v5Xv24XVADtFLsZaaEwOiiujtJAAX7fRXw5v
 OtaR0a1Q+w1oo+unY4CYOc0MeDc5VaO/g8cEVoRgSK49iI8iFjrp0jFE6KWyVjSSpFGdJOgI8OM
 /Azfn3zqfQWAwohlPHu3KiGJrRvVyOy/G8V/z0MTWpA6b1ZhbVE1dbFQRgJIG
X-Received: by 2002:a05:693c:88d9:20b0:35e:a117:8fd8 with SMTP id
 5a478bee46e88-35ea11794a8mr6085938eec.17.1792092729843; 
 Thu, 15 Oct 2026 12:32:09 -0700 (PDT)
X-Received: by 2002:a05:693c:88d9:20b0:35e:a117:8fd8 with SMTP id
 5a478bee46e88-35ea11794a8mr6085890eec.17.1792092728997; 
 Thu, 15 Oct 2026 12:32:08 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3608308a87csm81355eec.28.2026.10.15.12.32.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 12:32:08 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 20/20] qmp: reimplement qmp_query_cpu_definitions as a
 dispatcher function
Date: Thu, 15 Oct 2026 19:31:12 +0000
Message-ID: <20261015193112.145326-21-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015193112.145326-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261015193112.145326-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA3NyBTYWx0ZWRfXyWEQkKYRk/TW
 bFE5hGiC7qPZMb4fZ64MnFzFyEoy3aBq3Oik02tWo1FJFSRNoWImD8+QHBS+hGzvb9bGANkyQHh
 3HxQXjazf4zkINYwQiSOYJ+yKjrG3q4=
X-Proofpoint-ORIG-GUID: xLc_2n-hTC3PZBJduQzUzJSyGisntsU1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA3NyBTYWx0ZWRfXxwPYSUxgihNs
 VyHizpJVw13T5DzICDf1LUN9nAmtNC2s8CnqGLDSGaufDD+f6e4s0sxwr40XJyO/COTKphkgTp0
 v+LW1rjNsy/IfNg+jIPU3igJDUvWWjsiXFp1eloO5Vmf6mRgiQhphFO2QCWY9ldtvPU03EaeVBx
 7uuZZMJ+PHglJ3dZVVaHQg1iII0R0ruMAMaO8Sg0cbSR5Ij3/Mqskv+4lTm5kXKpsPNCE+36Ups
 Ev7rCniUZ+eIYIeKSH6oTIr0ac6ObSNhSZ7LLorQ9iHNjJFImnVzTgClaviTjChXJAWESUzNvUK
 p6bUkZrCtf3bGFpVI/soRXwj5oaQQIf1/DYENT5X0maNUZdWVXIkPL75HwJ6aUDowfbZwRpYIZ3
 jYTI4qWA+glOth6H8zDjPcDdJsifHqeUqVN6Fkv5Bv2gw8bFW95aeY8ZY3fKroXo3OD72G1VIw+
 VJfDB2mXrkDW/9s9UGw==
X-Proofpoint-GUID: xLc_2n-hTC3PZBJduQzUzJSyGisntsU1
X-Authority-Analysis: v=2.4 cv=AN0XGc5Z c=1 sm=1 tr=0 ts=6ad12a3b cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=fGHl3LoELX8nfqSJHPAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150077
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

We need to define individual stubs for targets function since each
existing binary only has one variant defined. Stub mechanism works per
compilation unit, thus we need one file per symbol.

Acked-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20261015005355.62406-9-pierrick.bouvier@oss.qualcomm.com
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


