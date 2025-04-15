Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09EABC369B2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 03:06:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4WcF-00058q-GR; Mon, 14 Apr 2025 23:05:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1u4WcB-00058c-Ae
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 23:05:35 -0400
Received: from mx1.zhaoxin.com ([210.0.225.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1u4Wc8-00075H-By
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 23:05:35 -0400
X-ASG-Debug-ID: 1744686323-086e2365b8c1770001-jgbH7p
Received: from ZXSHMBX3.zhaoxin.com (ZXSHMBX3.zhaoxin.com [10.28.252.165]) by
 mx1.zhaoxin.com with ESMTP id DEoidJMRwD2TmTsw (version=TLSv1.2
 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Tue, 15 Apr 2025 11:05:23 +0800 (CST)
X-Barracuda-Envelope-From: EwanHai-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from ZXSHMBX3.zhaoxin.com (10.28.252.165) by ZXSHMBX3.zhaoxin.com
 (10.28.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.44; Tue, 15 Apr
 2025 11:05:22 +0800
Received: from ZXSHMBX3.zhaoxin.com ([fe80::8cc5:5bc6:24ec:65f2]) by
 ZXSHMBX3.zhaoxin.com ([fe80::8cc5:5bc6:24ec:65f2%6]) with mapi id
 15.01.2507.044; Tue, 15 Apr 2025 11:05:22 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from ewan-server.zhaoxin.com (10.28.66.62) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.44; Tue, 15 Apr
 2025 10:45:45 +0800
From: Ewan Hai <ewanhai-oc@zhaoxin.com>
To: <pbonzini@redhat.com>, <zhao1.liu@intel.com>, <xiaoyao.li@intel.com>
CC: <ewanhai@zhaoxin.com>, <cobechen@zhaoxin.com>, <qemu-devel@nongnu.org>
Subject: [PATCH v4] target/i386: Fix model number of Zhaoxin YongFeng vCPU
 template
Date: Mon, 14 Apr 2025 22:45:44 -0400
X-ASG-Orig-Subj: [PATCH v4] target/i386: Fix model number of Zhaoxin YongFeng
 vCPU template
Message-ID: <20250415024545.517897-1-ewanhai-oc@zhaoxin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [10.28.66.62]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Moderation-Data: 4/15/2025 11:05:21 AM
X-Barracuda-Connect: ZXSHMBX3.zhaoxin.com[10.28.252.165]
X-Barracuda-Start-Time: 1744686323
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 2956
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No,
 SCORE=-2.02 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.139979
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------------------------
Received-SPF: pass client-ip=210.0.225.12; envelope-from=EwanHai-oc@zhaoxin.com;
 helo=mx1.zhaoxin.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The model number was mistakenly set to 0x0b (11) in commit ff04bc1ac4.
The correct value is 0x5b. This mistake occurred because the extended
model bits in cpuid[eax=3D0x1].eax were overlooked, and only the base
model was used.

Using the wrong model number can affect guest behavior. One known issue
is that vPMU (which relies on the model number) may fail to operate
correctly.

This patch corrects the model field by introducing a new vCPU version.

Additionally, it adds a "Preferred CPU models for Zhaoxin x86 hosts"
section in docs/system/cpu-models-x86.rst.inc to recommend the
appropriate Zhaoxin CPU model(s).

Fixes: ff04bc1ac4 ("target/i386: Introduce Zhaoxin Yongfeng CPU model")
Signed-off-by: Ewan Hai <ewanhai-oc@zhaoxin.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 docs/system/cpu-models-x86.rst.inc | 17 +++++++++++++++++
 target/i386/cpu.c                  | 12 ++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/docs/system/cpu-models-x86.rst.inc b/docs/system/cpu-models-x8=
6.rst.inc
index 6a770ca835..ba001422e2 100644
--- a/docs/system/cpu-models-x86.rst.inc
+++ b/docs/system/cpu-models-x86.rst.inc
@@ -369,6 +369,23 @@ features are included if using "Host passthrough" or "=
Host model".
   Note that not all CPU hardware will support this feature.
=20
=20
+Preferred CPU models for Zhaoxin x86 hosts
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+The following CPU models are preferred for use on Zhaoxin hosts.
+Administrators / applications are recommended to use the CPU model that
+matches the generation of the host CPUs in use. In a deployment with a
+mixture of host CPU models between machines, if live migration
+compatibility is required, use the newest CPU model that is compatible
+across all desired hosts.
+
+Currently, Zhaoxin provides a single CPU model (with potential for more in
+the near future), which has two versions. Among them, version 2 is recomme=
nded
+as it resolves several guest runtime issues related to the model field (FM=
S).
+
+``YongFeng-v2``
+    Zhaoxin KH-40000 Processor (2022)
+
+
 Default x86 CPU models
 ^^^^^^^^^^^^^^^^^^^^^^
=20
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 1b64ceaaba..3fb1ec62da 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5621,6 +5621,18 @@ static const X86CPUDefinition builtin_x86_defs[] =3D=
 {
         .features[FEAT_VMX_VMFUNC] =3D MSR_VMX_VMFUNC_EPT_SWITCHING,
         .xlevel =3D 0x80000008,
         .model_id =3D "Zhaoxin YongFeng Processor",
+        .versions =3D (X86CPUVersionDefinition[]) {
+            { .version =3D 1 },
+            {
+                .version =3D 2,
+                .note =3D "with the correct model number",
+                .props =3D (PropValue[]) {
+                    { "model", "0x5b" },
+                    { /* end of list */ }
+                }
+            },
+            { /* end of list */ }
+        }
     },
 };
=20
--=20
2.34.1


