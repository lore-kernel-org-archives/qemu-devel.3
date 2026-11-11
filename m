Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84C6606A324
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 14:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=korins.ky header.i=@korins.ky header.a=rsa-sha256 header.s=20240125rsa header.b=r0KkK1h9;
	dkim=fail reason="signature verification failed" header.d=korins.ky header.i=@korins.ky header.a=ed25519-sha256 header.s=20240125ed25519 header.b=5E/ztCsC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR9R8-00010a-US; Wed, 11 Nov 2026 09:36:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xR9Qu-0000se-ND
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 09:36:17 -0500
Received: from mx1.catap.net ([2a01:4f8:271:125e::2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xR9Qs-0002Oi-9t
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 09:36:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=ykDlluy
 HwxH8sqPT6vzUt+9YRTgIs9kzXjZ+KC4Joa74TLysoZLHHQWP+/u5ob1ftgz6e8mR4miS3
 rix5TJFZrLQS7aPP65gARI7Ep9ReeDSxRuAqHqLf1KwCGPxBdUxs6r/Jb/VJz//f16g0lL
 DYYzD+fNC74cfQ+VOkO90C/o/a4Y4+xBmMMeNz/QzuZYKEWFrKWb03YejbbqV0q77F+K/f
 KGfSL98cDmrDRMl+Y51QL5dIgaZU2KobYuehc5rWAsNDK6TMSa0mqDCGIcpWKm0o9jwGEd
 vc293drPTy7Jt+dgbW72KjUZDxUFJUQKvVj95V4bMUp0ft9GdoHMPRA==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=B
 e7GAcGECUpZ7xvx5yG0MTVf2k8GT7bEwYXa4ctnNBM=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=Vmi791S4Ntbv4lHvTxDe8I3iDdn1LZZ5jLF9n8Rzpxf/JQ94hhIUa0szIUlNP3+zA8tN
 ohVOGod4xSsymWeLF6t5xsRcwTUxfe7ePCmELdyFExFXUv3NCTt8Or1o079qtFlCa2Dvs4
 QGK65Pb38RE2qt7xYKdzywmKfJIyG9EMKpNsOLKwKr4MPM1XTmOpW59Q68BM9e8nsCu5n0
 nnMa2PI6sNNclraeN+k1lVp3IL4fN3vOqirF9ZvVUgctJlO0PrbA6QL758+DY5yCfK4niZ
 WpwutRpIINWyzEkCIH3RlhUmKNnvWmFe3C6YsHLren1nUF1vMsMs9u04RSJva0nw==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=r0KkK1h9; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=5E/ztCsC;
 arc=none; iprev=fail; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=Be7GAcGE
 CUpZ7xvx5yG0MTVf2k8GT7bEwYXa4ctnNBM=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=r0KkK1h9U48KtLDNESacUtpL3B2w27lEx9r
 AR/+i/4eYneNltdo0clmnU/Li01nFFEe/qb/l3TqR39erJ7EDmRIhROeCy2b0rblYAXPc5
 CCeTG0USJguNlWw3pp5dCWTZz8kwNTcd3t280RCnAZIm+dVzfVwS5vnA3faKi6MXok0xa8
 /yPZ3RLkTEDRSx0CM1MqadQWj+YNct1ShZaYYqK78TZ9EjEbcWaTU1V39mcjdSmmqGOD+N
 gUr5tmvsW0P5Tveel38yPHkiq7LrQzCEHN/qCTKjPEDQ8ztI/ARaGMTvsk7wTcrou8o0U+
 Zbn0FrW3Wpm0UHbC1BgQT65KSFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=Be7GAcGECUpZ7xvx5yG0MTVf2k8GT7bEwYXa4ctnNBM=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=5E/ztCsCwo5Ns+FKKQ
 UinZ99WI4YqfvLQaC7ipH4UG7pav45JYI6NkvpIn+vxb97PB7k/ckLbuXG9KE4pVK5AQ==
Received: by mx1.catap.net (OpenSMTPD) id 7c768501;
 Wed, 11 Nov 2026 15:36:04 +0100 (CET)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id 2df6d685;
 Wed, 11 Nov 2026 15:35:54 +0100 (CET)
From: Kirill A. Korinsky <kirill@korins.ky>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: "Kirill A . Korinsky" <kirill@korins.ky>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v7 05/26] target/mips: add Octeon CN73xx CPU model
Date: Wed, 11 Nov 2026 15:32:05 +0100
Message-ID: <20261111143533.1775-6-kirill@korins.ky>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261111143533.1775-1-kirill@korins.ky>
References: <20261111143533.1775-1-kirill@korins.ky>
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

From: "Kirill A. Korinsky" <kirill@korins.ky>

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
index 5f6fa2900f..7f7a33c5e5 100644
--- a/target/mips/cpu-defs.c.inc
+++ b/target/mips/cpu-defs.c.inc
@@ -1068,6 +1068,53 @@ const mips_def_t mips_defs[] =
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
index 8ad5e49ade..4ba4d50daa 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -255,7 +255,7 @@ static void mips_cpu_reset_hold(Object *obj, ResetType type)
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


