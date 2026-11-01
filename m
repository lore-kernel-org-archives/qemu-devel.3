Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E197606A324
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 14:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=korins.ky header.i=@korins.ky header.a=rsa-sha256 header.s=20240125rsa header.b=CFJt2inU;
	dkim=fail reason="signature verification failed" header.d=korins.ky header.i=@korins.ky header.a=ed25519-sha256 header.s=20240125ed25519 header.b=cLcnHlnt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNWXQ-0006fm-GG; Sun, 01 Nov 2026 09:28:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xNWX9-0006bc-F2
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 09:27:46 -0500
Received: from mx1.catap.net ([2a01:4f8:271:125e::2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xNWX6-00084p-M5
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 09:27:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=DSynwCI
 g+Kum3w9gV0D8p8E/nqVffqfvGDajxprvPkteG7nLQrqDcIghLbiaorPl8e4vaGyp1KeRD
 iEsXieZ0b6aAu5U8PB9987lenfiIacn8q9ABqNh3BNLH+gb+6UYy5hOZHxLad++sPtKpc1
 GMxmRppfkm7ruxCveRuFWjgHLXqKw6Pu6GFS8QwdciIcuVL8eq1S+lVzC8WXbUFEwN4awz
 b2PPfwZFCK9VOymru40wL4zFlRMta5kqb/qP1qdngrTvlbqmO/Ya6HWfnbO0ao9frB3eZA
 1+7FWNprWNJY4nrP+fqiFSaeyo22VdX4RqqNf1TXmaj1zyYFsqsQ6kg==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=D
 EZwaGpvtJ/LDMFPVFd24EzAuzcbDPuZhCVVNjbf2ms=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=nRwVqWo0cNi4TciP9UBCF3ytbP6OxxL6UN8gTHNDXt8cx6VCXJPTlvjexrgwP35hmnqD
 62g50rXhg6CUPSlD2aGepMf4dG+CwqdymUWhURselBaXSJxPr1WFojk0eJ6t+LyJaT6/a7
 C4E0Rp2aY0rsborEn7w59yPrugCh03ucI06PFzRbOeJz514/vj0hv5B0N568ZU/XTBimrB
 HeQrXnmRYP9wERJCQso/HGjrqBYitBQA0FIR4NGI+o0ZuOZO2sRp+5lSVuCqzxmlY6Qj+I
 pTr0PlxZEeJtCU1fKjBXPG97QH2BsJNpr+HwwF3zvkwcN8a6/GLuBVtpuzgiuAOg==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=CFJt2inU; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=cLcnHlnt;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=DEZwaGpv
 tJ/LDMFPVFd24EzAuzcbDPuZhCVVNjbf2ms=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=CFJt2inU3EcXDfUu/zAaEWJrteGgxuE1wRS
 Y3doysJ6qbQcHzbqMCGhOqybCZdAyf97tUwp6BXITb7EgxdBHME4WxPp/MZAhfyTMYjl5z
 drDgl7LQeDAZLNX/m3h6C9e+Bfw1nCWd9ZVlRf7S2JcO53QsS7N+6HPlShESJ8oB4S+NHO
 JCFRSN5w81FNT4Y0sbzYylp6C25c4yOjmYHVau0GTZG01VQlFMoZMqA2TIMYUgjQKYpDLK
 cgdXuqZbuGx+tidrre7I+fQGewop/gp8Bzq09AGSjz6pK5RQWdOvsChl3k8eT1S2kZZkkH
 RIUVrcGMTK6lUPAXA3nsmgBxu5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=DEZwaGpvtJ/LDMFPVFd24EzAuzcbDPuZhCVVNjbf2ms=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=cLcnHlntgNS70GyBTJ
 9XgQTBtq5bbTGQVW6o51sCcB+v/RKQNG8C3nz41EClmoYbJMSK41102T2+k5xY8QOfCw==
Received: by mx1.catap.net (OpenSMTPD) id 18500f76;
 Sun, 1 Nov 2026 15:27:34 +0100 (CET)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id 0a3418f8;
 Sun, 1 Nov 2026 15:27:30 +0100 (CET)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-devel@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v6 05/26] target/mips: add Octeon CN73xx CPU model
Date: Sun,  1 Nov 2026 15:23:21 +0100
Message-ID: <20261101142723.41346-6-kirill@korins.ky>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261101142723.41346-1-kirill@korins.ky>
References: <20261101142723.41346-1-kirill@korins.ky>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a01:4f8:271:125e::2;
 envelope-from=kirill@korins.ky; helo=mx1.catap.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a CN73xx CPU definition for the Octeon III machine.

Based on register reads and write/readback probes on a Ubiquiti USG-XG-8
running OpenBSD which reads as CN72xx/CN73xx.

Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
Suggested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/mips/cpu-defs.c.inc | 47 ++++++++++++++++++++++++++++++++++++++
 target/mips/cpu.c          |  2 +-
 2 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/target/mips/cpu-defs.c.inc b/target/mips/cpu-defs.c.inc
index b2ddfa1e82..e224cb42f0 100644
--- a/target/mips/cpu-defs.c.inc
+++ b/target/mips/cpu-defs.c.inc
@@ -1023,6 +1023,53 @@ const mips_def_t mips_defs[] =
         .insn_flags = CPU_MIPS64R2 | INSN_OCTEON,
         .mmu_type = MMU_TYPE_R4000,
     },
+    {
+        /*
+         * Based on register reads and write/readback probes on a Ubiquiti
+         * USG-XG-8 running OpenBSD which reads as CN72xx/CN73xx.
+         */
+        .name = "OcteonCN73XX",
+        .CP0_PRid = 0x000D9702,
+        .CP0_Config0 = MIPS_CONFIG0 | (0x1 << CP0C0_AR) | (0x2 << CP0C0_AT) |
+                       (MMU_TYPE_R4000 << CP0C0_MT) | (1 << CP0C0_VI),
+        .CP0_Config1 = MIPS_CONFIG1 | (1 << CP0C1_FP) |
+                       (0x3F << CP0C1_MMU) |
+                       (0 << CP0C1_IS) | (6 << CP0C1_IL) | (7 << CP0C1_IA) |
+                       (0 << CP0C1_DS) | (0 << CP0C1_DL) | (7 << CP0C1_DA) |
+                       (1 << CP0C1_C2) | (1 << CP0C1_PC) |
+                       (1 << CP0C1_WR) | (1 << CP0C1_EP),
+        .CP0_Config2 = MIPS_CONFIG2 | (7 << CP0C2_SS) | (6 << CP0C2_SL) |
+                       (7 << CP0C2_SA),
+        .CP0_Config3 = MIPS_CONFIG3 | (1U << CP0C3_M) |
+                       (1 << CP0C3_BP) | (1 << CP0C3_BI) |
+                       (1 << CP0C3_VZ) | (1 << CP0C3_ULRI) |
+                       (1 << CP0C3_RXI) | (1 << CP0C3_LPA),
+        .CP0_Config4 = MIPS_CONFIG4 | (1U << CP0C4_M) |
+                       (0x3c << CP0C4_KScrExist) | (1U << CP0C4_MMUExtDef) |
+                       (3U << CP0C4_MMUSizeExt),
+        .CP0_Config5 = MIPS_CONFIG5,
+	/* Octeon III CVMMEMCTL2 */
+        .CP0_Config6 = 0x0800007C,
+	/* Octeon III CVMVMConfig */
+        .CP0_Config7 = 0x000FF0FF,
+        .CP0_LLAddr_rw_bitmask = 0,
+        .CP0_LLAddr_shift = 4,
+        .CP0_PageGrain = (1 << CP0PG_ELPA),
+        .CP0_PageGrain_rw_bitmask = (1U << CP0PG_RIE) | (1U << CP0PG_XIE) |
+                                   (1U << CP0PG_ELPA) | (1U << CP0PG_IEC),
+        .SYNCI_Step = 4096,
+        .CCRes = 1,
+        .CP0_Status_rw_bitmask = 0x74F8FFFF,
+        .CP1_fcr0 = (1 << FCR0_F64) | (1 << FCR0_L) | (1 << FCR0_W) |
+                    (1 << FCR0_D) | (1 << FCR0_S) |
+                    (0x97 << FCR0_PRID) | (0x0 << FCR0_REV),
+        .CP1_fcr31 = 0,
+        .CP1_fcr31_rw_bitmask = 0xFF83FFFF,
+        .SEGBITS = 49,
+        .PABITS = 49,
+        .insn_flags = CPU_MIPS64R2 | INSN_OCTEON,
+        .mmu_type = MMU_TYPE_R4000,
+    },
 
 #endif
 };
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index c5193dbc8e..fcf8f5a435 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -254,7 +254,7 @@ static void mips_cpu_reset_hold(Object *obj, ResetType type)
                                  CP0C0_BE, 1, cpu->is_big_endian);
     env->CP0_Config1 = env->cpu_model->CP0_Config1;
     env->CP0_Config2 = env->cpu_model->CP0_Config2;
-    env->CP0_Config3 = env->cpu_model->CP0_Config3;
+    env->CP0_Config3 = env->cpu_model->CP0_Config3 & ~(1 << CP0C3_VZ);
     env->CP0_Config4 = env->cpu_model->CP0_Config4;
     env->CP0_Config4_rw_bitmask = env->cpu_model->CP0_Config4_rw_bitmask;
     env->CP0_Config5 = env->cpu_model->CP0_Config5;
-- 
2.56.0


