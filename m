Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 785F0C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 12:47:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scP0z-00057f-97; Fri, 09 Aug 2024 08:46:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1scP0y-00053q-8M
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 08:46:40 -0400
Received: from mx2.zhaoxin.com ([203.110.167.99])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1scP0w-0003p0-J7
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 08:46:40 -0400
X-ASG-Debug-ID: 1723207547-1eb14e31a727fa0001-jgbH7p
Received: from ZXSHMBX1.zhaoxin.com (ZXSHMBX1.zhaoxin.com [10.28.252.163]) by
 mx2.zhaoxin.com with ESMTP id UQEC2XwxCEZjK8uG (version=TLSv1.2
 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Fri, 09 Aug 2024 20:45:47 +0800 (CST)
X-Barracuda-Envelope-From: EwanHai-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from ZXSHMBX1.zhaoxin.com (10.28.252.163) by ZXSHMBX1.zhaoxin.com
 (10.28.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 9 Aug
 2024 20:45:47 +0800
Received: from ZXSHMBX1.zhaoxin.com ([fe80::dcd1:d46d:263:77e]) by
 ZXSHMBX1.zhaoxin.com ([fe80::dcd1:d46d:263:77e%7]) with mapi id
 15.01.2507.039; Fri, 9 Aug 2024 20:45:47 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from ewan-server.zhaoxin.com (10.28.66.62) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 9 Aug
 2024 17:43:01 +0800
From: EwanHai <ewanhai-oc@zhaoxin.com>
To: <pbonzini@redhat.com>, <zhao1.liu@intel.com>, <xiaoyao.li@intel.com>
CC: <qemu-devel@nongnu.org>, <ewanhai@zhaoxin.com>, <cobechen@zhaoxin.com>,
 <rockcui@zhaoxin.com>, <louisqi@zhaoxin.com>, <liamni@zhaoxin.com>,
 <frankzhu@zhaoxin.com>
Subject: [PATCH v3 2/4] target/i386: Add CPUID leaf 0xC000_0001 EDX definitions
Date: Fri, 9 Aug 2024 05:42:57 -0400
X-ASG-Orig-Subj: [PATCH v3 2/4] target/i386: Add CPUID leaf 0xC000_0001 EDX
 definitions
Message-ID: <20240809094259.119221-3-ewanhai-oc@zhaoxin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240809094259.119221-1-ewanhai-oc@zhaoxin.com>
References: <20240809094259.119221-1-ewanhai-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [10.28.66.62]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Moderation-Data: 8/9/2024 8:45:46 PM
X-Barracuda-Connect: ZXSHMBX1.zhaoxin.com[10.28.252.163]
X-Barracuda-Start-Time: 1723207547
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 1642
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No,
 SCORE=-2.02 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.128793
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------------------------
Received-SPF: pass client-ip=203.110.167.99;
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

Add new CPUID feature flags for various Zhaoxin PadLock extensions.
These definitions will be used for Zhaoxin CPU models.

Signed-off-by: EwanHai <ewanhai-oc@zhaoxin.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 29d554766f..ff5551297d 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1032,6 +1032,27 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *=
cpu, FeatureWord w);
 /* CPUID[0x80000007].EDX flags: */
 #define CPUID_APM_INVTSC       (1U << 8)
=20
+/* "rng" RNG present (xstore) */
+#define CPUID_C000_0001_EDX_XSTORE             (1U << 2)
+/* "rng_en" RNG enabled */
+#define CPUID_C000_0001_EDX_XSTORE_EN          (1U << 3)
+/* "ace" on-CPU crypto (xcrypt) */
+#define CPUID_C000_0001_EDX_XCRYPT             (1U << 6)
+/* "ace_en" on-CPU crypto enabled */
+#define CPUID_C000_0001_EDX_XCRYPT_EN          (1U << 7)
+/* Advanced Cryptography Engine v2 */
+#define CPUID_C000_0001_EDX_ACE2               (1U << 8)
+/* ACE v2 enabled */
+#define CPUID_C000_0001_EDX_ACE2_EN            (1U << 9)
+/* PadLock Hash Engine */
+#define CPUID_C000_0001_EDX_PHE                (1U << 10)
+/* PHE enabled */
+#define CPUID_C000_0001_EDX_PHE_EN             (1U << 11)
+/* PadLock Montgomery Multiplier */
+#define CPUID_C000_0001_EDX_PMM                (1U << 12)
+/* PMM enabled */
+#define CPUID_C000_0001_EDX_PMM_EN             (1U << 13)
+
 #define CPUID_VENDOR_SZ      12
=20
 #define CPUID_VENDOR_INTEL_1 0x756e6547 /* "Genu" */
--=20
2.34.1


