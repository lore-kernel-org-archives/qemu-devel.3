Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62C24C31D97
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 11:25:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPKal-0007kZ-DF; Thu, 04 Jul 2024 07:25:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1sPKaj-0007fo-D7
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 07:25:33 -0400
Received: from mx1.zhaoxin.com ([210.0.225.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1sPKab-0002tU-Cm
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 07:25:33 -0400
X-ASG-Debug-ID: 1720092313-086e2311071449f0001-jgbH7p
Received: from ZXSHMBX2.zhaoxin.com (ZXSHMBX2.zhaoxin.com [10.28.252.164]) by
 mx1.zhaoxin.com with ESMTP id bFA1V6DiYIwSYgRK (version=TLSv1.2
 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Thu, 04 Jul 2024 19:25:13 +0800 (CST)
X-Barracuda-Envelope-From: EwanHai-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHMBX2.zhaoxin.com
 (10.28.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 4 Jul
 2024 19:25:13 +0800
Received: from ewan-server.zhaoxin.com (10.28.66.62) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 4 Jul
 2024 19:25:12 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
From: EwanHai <ewanhai-oc@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.163
To: <pbonzini@redhat.com>, <zhao1.liu@intel.com>, <xiaoyao.li@intel.com>
CC: <qemu-devel@nongnu.org>, <ewanhai@zhaoxin.com>, <cobechen@zhaoxin.com>,
 <rockcui@zhaoxin.com>, <louisqi@zhaoxin.com>, <liamni@zhaoxin.com>,
 <frankzhu@zhaoxin.com>
Subject: [PATCH v2 1/4] target/i386: Add support for Zhaoxin CPU vendor
 identification
Date: Thu, 4 Jul 2024 07:25:08 -0400
X-ASG-Orig-Subj: [PATCH v2 1/4] target/i386: Add support for Zhaoxin CPU
 vendor identification
Message-ID: <20240704112511.184257-2-ewanhai-oc@zhaoxin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240704112511.184257-1-ewanhai-oc@zhaoxin.com>
References: <20240704112511.184257-1-ewanhai-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.28.66.62]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Barracuda-Connect: ZXSHMBX2.zhaoxin.com[10.28.252.164]
X-Barracuda-Start-Time: 1720092313
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 2415
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No,
 SCORE=-2.02 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.127153
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------------------------
Received-SPF: pass client-ip=210.0.225.12; envelope-from=EwanHai-oc@zhaoxin.com;
 helo=mx1.zhaoxin.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Zhaoxin currently uses two vendors: "Shanghai" and "Centaurhauls".
It is important to note that the latter now belongs to Zhaoxin. Therefore,
this patch replaces CPUID_VENDOR_VIA with CPUID_VENDOR_ZHAOXIN1.

The previous CPUID_VENDOR_VIA macro was only defined but never used in
QEMU, making this change straightforward.

Additionally, the IS_ZHAOXIN_CPU macro has been added to simplify the
checks for Zhaoxin CPUs.

Signed-off-by: EwanHai <ewanhai-oc@zhaoxin.com>
---
 target/i386/cpu.h | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index c64ef0c1a2..07e8353f36 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1001,7 +1001,16 @@ uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
 #define CPUID_VENDOR_AMD_3   0x444d4163 /* "cAMD" */
 #define CPUID_VENDOR_AMD   "AuthenticAMD"
 
-#define CPUID_VENDOR_VIA   "CentaurHauls"
+#define CPUID_VENDOR_ZHAOXIN1_1 0x746E6543 /* "Cent" */
+#define CPUID_VENDOR_ZHAOXIN1_2 0x48727561 /* "aurH" */
+#define CPUID_VENDOR_ZHAOXIN1_3 0x736C7561 /* "auls" */
+
+#define CPUID_VENDOR_ZHAOXIN2_1 0x68532020 /* "  Sh" */
+#define CPUID_VENDOR_ZHAOXIN2_2 0x68676E61 /* "angh" */
+#define CPUID_VENDOR_ZHAOXIN2_3 0x20206961 /* "ai  " */
+
+#define CPUID_VENDOR_ZHAOXIN1   "CentaurHauls"
+#define CPUID_VENDOR_ZHAOXIN2   "  Shanghai  "
 
 #define CPUID_VENDOR_HYGON    "HygonGenuine"
 
@@ -1011,6 +1020,15 @@ uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
 #define IS_AMD_CPU(env) ((env)->cpuid_vendor1 == CPUID_VENDOR_AMD_1 && \
                          (env)->cpuid_vendor2 == CPUID_VENDOR_AMD_2 && \
                          (env)->cpuid_vendor3 == CPUID_VENDOR_AMD_3)
+#define IS_ZHAOXIN1_CPU(env) \
+    ((env)->cpuid_vendor1 == CPUID_VENDOR_ZHAOXIN1_1 && \
+     (env)->cpuid_vendor2 == CPUID_VENDOR_ZHAOXIN1_2 && \
+     (env)->cpuid_vendor3 == CPUID_VENDOR_ZHAOXIN1_3)
+#define IS_ZHAOXIN2_CPU(env) \
+    ((env)->cpuid_vendor1 == CPUID_VENDOR_ZHAOXIN2_1 && \
+     (env)->cpuid_vendor2 == CPUID_VENDOR_ZHAOXIN2_2 && \
+     (env)->cpuid_vendor3 == CPUID_VENDOR_ZHAOXIN2_3)
+#define IS_ZHAOXIN_CPU(env) (IS_ZHAOXIN1_CPU(env) || IS_ZHAOXIN2_CPU(env))
 
 #define CPUID_MWAIT_IBE     (1U << 1) /* Interrupts can exit capability */
 #define CPUID_MWAIT_EMX     (1U << 0) /* enumeration supported */
-- 
2.34.1


