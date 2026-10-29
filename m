Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAF6606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=korins.ky header.i=@korins.ky header.a=rsa-sha256 header.s=20240125rsa header.b=nf9hA/Up;
	dkim=fail reason="signature verification failed" header.d=korins.ky header.i=@korins.ky header.a=ed25519-sha256 header.s=20240125ed25519 header.b=KJ+TF/Vn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMU9g-0004jl-Gd; Thu, 29 Oct 2026 13:43:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xMU8Y-0003Yc-82
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:42:02 -0400
Received: from mx2.catap.net ([2a01:4f9:3b:5410::2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xMU8U-0003HN-7z
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:42:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=jX+HKp1
 I9YnSkU7F+AXCd1aWA/g3iW74mdpyZhVc110El0znHvwGzvozlP7V/NoaZd/Oqz65kX+X8
 6BI9oyZuvyRTDTFVpSRzyb4nZWJ/fbjpVCsNLejVqLsjgi8f/3JM3qnmojTd1ht6CY6+9i
 l2E89wHcR3OFkLBli9Djm/SrbCGjNr200KWwO71iYFqixlgAuIoVGVg9jz/UPO9r5IBvmT
 WyX1RbbwkBPRn5fUz48UQo8P4tzv/oJlng9VCEeSac813b6uTt9xIJ1l8zKdFIrlw+Ajnm
 OaSljrpGMoS5D3UwR+GwaSpvT/oSKu3u+mLRjL4Q5a7hCUO9ykJEfOA==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=L
 pftswWG1+Opc0p0/lW+ZAqqQu5+fioewdlNRWbST98=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=ESFhQgwWnFt6j/pAs+ZbK5jCXCVXopSmpWgFCm0fvo2lr42jf473oR2hVEt0yKsTniJf
 relfWqx1llMCmTre/jDMABjrpRhxaIxHImn9xDLyEeeupILQkzyLfsxXMXNNWfpBmQa8lO
 BDSdC+NUTTAQ21WHSgGiyT6i9oanZDInI8L5UXIwgZCwht5nlUF523dZnjqJzxqOO7Mnke
 LH0itQxO4ZgvvxVnNfPs26Jw90xyUPIp9J4yHksVBVCF+Y3dwnXvUrQUvTUl/EfExr4j09
 y5pFtFOl/QlQTeqc7+XO/R/ZI176SO/+A2XQzvagC+je2to0UfNCMY7ydipSHTnw==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=nf9hA/Up; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=KJ+TF/Vn;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=LpftswWG
 1+Opc0p0/lW+ZAqqQu5+fioewdlNRWbST98=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=nf9hA/UpeF1urceQ24hdeduqPftjIfgc/9z
 kKN3oLz/g8njkOe6NU1b6ykbzO08cJOKAh1/Rw79JNj92m5oPjxcp5ZsCDLyEB2hX1OE3l
 SgOBM27aVmOGUrjvzZ5AsxYku9ILMqraFjsPf+a9oV9Vq5auTG/rfxt+mmpIXSy/VYyt6K
 12cM4AcwURQx9Bp8zNOl6VhMx1K+scdttbrsaXBk0lJ7Sh59d5YVSrYKk5ahAVAgbopc15
 iH+LV9kE95+hY5+H4/3nqkvusxuA21N03l0B9t8EuDPMVemh9N05uona2C+uGGGFMO3+LM
 Xwo3i6xppYjrwzHZPW0+8o86j4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=LpftswWG1+Opc0p0/lW+ZAqqQu5+fioewdlNRWbST98=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=KJ+TF/Vn5C02OJb210
 HEibOldZKiQnttHez4tFA/WUN4qKE/tos4mdzT5nEfp0a2Bo4v4UFhqgfaLYyF5IrCDw==
Received: by mx2.catap.net (OpenSMTPD) id a1f61bf6;
 Thu, 29 Oct 2026 18:41:51 +0100 (CET)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id 316f6cd6;
 Thu, 29 Oct 2026 18:41:47 +0100 (CET)
From: "Kirill A. Korinsky" <kirill@korins.ky>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-devel@nongnu.org
Cc: "Kirill A. Korinsky" <kirill@korins.ky>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v5 05/26] target/mips: add Octeon CN73xx CPU model
Date: Thu, 29 Oct 2026 18:36:05 +0100
Message-ID: <20261029174139.44302-6-kirill@korins.ky>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029174139.44302-1-kirill@korins.ky>
References: <20261029174139.44302-1-kirill@korins.ky>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a01:4f9:3b:5410::2;
 envelope-from=kirill@korins.ky; helo=mx2.catap.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Add a CN73xx CPU definition for the Octeon III machine. The PRId, FPU
FIR, and L2 cache geometry come from EdgeRouter Infinity ER-8-XG data;
the remaining CP0 fields come from a Juniper SRX300 CN70xx/CN71xx dump.

Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
Suggested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/mips/cpu-defs.c.inc | 42 ++++++++++++++++++++++++++++++++++++++
 target/mips/cpu.c          |  2 +-
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/target/mips/cpu-defs.c.inc b/target/mips/cpu-defs.c.inc
index b2ddfa1e82..5afc589a20 100644
--- a/target/mips/cpu-defs.c.inc
+++ b/target/mips/cpu-defs.c.inc
@@ -1023,6 +1023,48 @@ const mips_def_t mips_defs[] =
         .insn_flags = CPU_MIPS64R2 | INSN_OCTEON,
         .mmu_type = MMU_TYPE_R4000,
     },
+    {
+        /*
+         * Minimal Octeon CN73xx model for EBB7304 firmware. PRId, FPU FIR,
+         * and L2 cache geometry match a Ubiquiti EdgeRouter Infinity
+         * ER-8-XG; the remaining CP0 values are a placeholder Octeon III
+         * model derived from a Juniper SRX300 CN70xx/CN71xx dump.
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
+        .CP0_Config2 = MIPS_CONFIG2 | (5 << CP0C2_SS) | (6 << CP0C2_SL) |
+                       (15 << CP0C2_SA),
+        .CP0_Config3 = MIPS_CONFIG3 | (1U << CP0C3_M) |
+                       (1 << CP0C3_BP) | (1 << CP0C3_BI) |
+                       (1 << CP0C3_VZ) | (1 << CP0C3_ULRI) |
+                       (1 << CP0C3_RXI) | (1 << CP0C3_LPA),
+        .CP0_Config4 = MIPS_CONFIG4 | (1U << CP0C4_M) |
+                       (0x3c << CP0C4_KScrExist),
+        .CP0_Config7 = 1 << CP0C7_WII,
+        .CP0_LLAddr_rw_bitmask = 0,
+        .CP0_LLAddr_shift = 4,
+        .CP0_PageGrain = (1 << CP0PG_ELPA),
+        .SYNCI_Step = 32,
+        .CCRes = 1,
+        .CP0_Status_rw_bitmask = 0x36F8FFFF,
+        .CP1_fcr0 = (1 << FCR0_F64) | (1 << FCR0_L) | (1 << FCR0_W) |
+                    (1 << FCR0_D) | (1 << FCR0_S) |
+                    (0x97 << FCR0_PRID) | (0x0 << FCR0_REV),
+        .CP1_fcr31 = 0,
+        .CP1_fcr31_rw_bitmask = 0xFF83FFFF,
+        .SEGBITS = 42,
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


