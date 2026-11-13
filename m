Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668BD606A327
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 21:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=korins.ky header.i=@korins.ky header.a=rsa-sha256 header.s=20240125rsa header.b=Q2VA8HOY;
	dkim=fail reason="signature verification failed" header.d=korins.ky header.i=@korins.ky header.a=ed25519-sha256 header.s=20240125ed25519 header.b=7CzN43D1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRzAl-0002hd-RK; Fri, 13 Nov 2026 16:51:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xRz9e-0008BB-IF
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 16:49:56 -0500
Received: from mx2.catap.net ([65.21.79.163])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xRz9c-0005Q1-Of
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 16:49:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=fZa143V
 dBYTo7hUNxXEvW8zIF4WhnB6reYpM1CdgGah2Jo5X4gM1ralDXiNLVY9bSBzbj2SVkPFIR
 ANLbI2ixwHOAasq7lDjv3aI0XTR5Ff4ow0Vf7xiBv/bHAjRoJKcal5AELed+iNtXLdzMEs
 21YHdtuWiJiRs0o/kzx8T4ETo8WmIXztnUmreaSjI7HeY4KKa1CRNM7oPK9rD3KJ7uQb2y
 TaexWEqK5c/tPaA3QJVFXkOquq8tByO7avixYjs3MAh/9x7lUVyaPaeAABPnVqzmQwj7s5
 T//nV/L4rWoz6wBpAVihuskK0ea/lRLDfPpJhbQwjX9Z6JpqWD9xwCw==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=B
 e7GAcGECUpZ7xvx5yG0MTVf2k8GT7bEwYXa4ctnNBM=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=X6+zbkCGbtq6as8JPImEx/hlGbeA3lnAJR1WbgQRxCm1FW1Chq8dcgm9HL96E3Mf34kw
 y9tUVFUjjzWNQK8eQeuceAITQc82SLA24lElD22fdUwhcS7YGZRKqbSq7g0qKjZ7m1xX/r
 Pc7iP2JF2cmJpBabp1xuVK5BkX0kZjnkcLnqx+Jqg5OWCvt4m8sfJOD3UESG8MqoLug6O9
 tLIj6djwq7Gql7hfxZR0rjH8VdjNBx14a06wTSRK7uYam48EuAHCEK4oKApBn6YZOAyLAP
 VGPrRHjQwZ2kq7YpqFOUYeaGE5X5qYNn6ZCOQZ1TsSyQY2i1DmYiClRfRcm1bXOw==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=Q2VA8HOY; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=7CzN43D1;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=Be7GAcGE
 CUpZ7xvx5yG0MTVf2k8GT7bEwYXa4ctnNBM=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=Q2VA8HOYCKBkrGaIosUuGvqhVQP6LyrCJk4
 Yu4+UAs21cadnJp2ZrEzrOgRuos1Hg5/FgfkXLccw+oehbeVvtzeLJhE6OoEKchxf9rNpS
 4sCCpiD+04R4xKGesJnO+8rc4fkqn4pnKgvaXg6H0a3tq3ETSt1DIHmqjCUUMUaCqni3JY
 5f4co3Dn3VgPzE4lV4EIcgHvFTbOVMUJ/3Xu/Q3EsJXbBwIGJRzhbFSGf1bcUa3+95NRsh
 FmyMiyPQmW83LMtsM7XmQ7KqqzJ6USlAyXuRUWF5QDAGh1xHEZIc6Yb0+q2CmgV5KzxdBc
 eRDXSUO3znf2liGfgePsrIQw1ww==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=Be7GAcGECUpZ7xvx5yG0MTVf2k8GT7bEwYXa4ctnNBM=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=7CzN43D12ylyE81f69
 Ctdu3jiIaQnBnlHDRvKHvv7pQY78DDsGwSW/ddG/cR7kPYxc20+ezZeAEjIb2UYY8MBg==
Received: by mx2.catap.net (OpenSMTPD) id 7da2d95c;
 Fri, 13 Nov 2026 22:49:49 +0100 (CET)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id eec31422;
 Fri, 13 Nov 2026 22:49:32 +0100 (CET)
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
Subject: [PATCH v8 05/26] target/mips: add Octeon CN73xx CPU model
Date: Fri, 13 Nov 2026 22:45:19 +0100
Message-ID: <20261113214926.98536-6-kirill@korins.ky>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261113214926.98536-1-kirill@korins.ky>
References: <20261113214926.98536-1-kirill@korins.ky>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=65.21.79.163; envelope-from=kirill@korins.ky;
 helo=mx2.catap.net
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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


