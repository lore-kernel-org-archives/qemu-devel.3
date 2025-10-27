Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02D00CCF9F0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 10:39:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDKdB-0005hd-Ty; Mon, 27 Oct 2025 06:39:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1vDKd2-0005fA-CD
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 06:39:09 -0400
Received: from mx2.zhaoxin.com ([61.152.208.219])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1vDKcs-0000nA-Tn
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 06:39:07 -0400
X-ASG-Debug-ID: 1761561530-1eb14e3d8a60d80001-jgbH7p
Received: from ZXSHMBX1.zhaoxin.com (ZXSHMBX1.zhaoxin.com [10.28.252.163]) by
 mx2.zhaoxin.com with ESMTP id UJIAZjO3kI0O3A1M (version=TLSv1.2
 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Mon, 27 Oct 2025 18:38:50 +0800 (CST)
X-Barracuda-Envelope-From: EwanHai-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from ZXSHMBX1.zhaoxin.com (10.28.252.163) by ZXSHMBX1.zhaoxin.com
 (10.28.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Mon, 27 Oct
 2025 18:38:50 +0800
Received: from ZXSHMBX1.zhaoxin.com ([fe80::936:f2f9:9efa:3c85]) by
 ZXSHMBX1.zhaoxin.com ([fe80::936:f2f9:9efa:3c85%7]) with mapi id
 15.01.2507.059; Mon, 27 Oct 2025 18:38:50 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from ewan-server.lan (10.28.24.130) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Mon, 27 Oct
 2025 18:21:39 +0800
From: Ewan Hai <ewanhai-oc@zhaoxin.com>
To: <pbonzini@redhat.com>, <zhao1.liu@intel.com>
CC: <qemu-devel@nongnu.org>, <ewanhai@zhaoxin.com>, <cobechen@zhaoxin.com>,
 Xudong Hao <xudong.hao@intel.com>
Subject: [PATCH v2 1/4] target/i386: Add an option in X86CPUDefinition to
 control CPUID 0x1f
Date: Mon, 27 Oct 2025 06:21:36 -0400
X-ASG-Orig-Subj: [PATCH v2 1/4] target/i386: Add an option in X86CPUDefinition
 to control CPUID 0x1f
Message-ID: <20251027102139.270662-2-ewanhai-oc@zhaoxin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251027102139.270662-1-ewanhai-oc@zhaoxin.com>
References: <20251027102139.270662-1-ewanhai-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [10.28.24.130]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Moderation-Data: 10/27/2025 6:38:49 PM
X-Barracuda-Connect: ZXSHMBX1.zhaoxin.com[10.28.252.163]
X-Barracuda-Start-Time: 1761561530
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 1659
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -1.82
X-Barracuda-Spam-Status: No,
 SCORE=-1.82 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=PR0N_SUBJECT
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.149253
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------------------------
 0.20 PR0N_SUBJECT Subject has letters around special characters (pr0n)
Received-SPF: pass client-ip=61.152.208.219;
 envelope-from=EwanHai-oc@zhaoxin.com; helo=mx2.zhaoxin.com
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

From: Zhao Liu <zhao1.liu@intel.com>

Many Intel and Zhaoxin CPUs enable CPUID 0x1f by default to encode CPU
topology information.

Add the "cpuid_0x1f" option to X86CPUDefinition to allow named CPU
models to configure CPUID 0x1f from the start, thereby forcing 0x1f
to be present for guest.

With this option, there's no need to explicitly add v1 model to an
unversioned CPU model for explicitly enabling the x-force-cpuid-0x1f
property.

Tested-by: Xudong Hao <xudong.hao@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 0a66e1fec9..c5853216dc 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2212,6 +2212,12 @@ typedef struct X86CPUDefinition {
     int model;
     int stepping;
     uint8_t avx10_version;
+    /*
+     * Whether to present CPUID 0x1f by default.
+     * If true, encode CPU topology in 0x1f leaf even if there's no
+     * extended topology levels.
+     */
+    bool cpuid_0x1f;
     FeatureWordArray features;
     const char *model_id;
     const CPUCaches *const cache_info;
@@ -7759,6 +7765,10 @@ static void x86_cpu_load_model(X86CPU *cpu, const X8=
6CPUModel *model)
     object_property_set_uint(OBJECT(cpu), "avx10-version", def->avx10_vers=
ion,
                              &error_abort);
=20
+    if (def->cpuid_0x1f) {
+        object_property_set_bool(OBJECT(cpu), "x-force-cpuid-0x1f",
+                                 def->cpuid_0x1f, &error_abort);
+    }
     x86_cpu_apply_version_props(cpu, model);
=20
     /*
--=20
2.34.1


