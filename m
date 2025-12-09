Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2E09D3B7F8
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 13:54:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSyA2-0000I1-VH; Tue, 09 Dec 2025 08:53:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vSy9a-000098-Lp
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 08:53:30 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vSy9X-0002cq-5q
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 08:53:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=ozIP+Zyr73eXqKEdDKRbFDIOn/xjjd2dTLdjAvu4u80=; b=wEt31SD5GdCt7i2
 RRnMOyPRdoH+obcMoCl5J17UihtJff/nlw/9fwqL2nWhtO1aittqeUuSfBd4Rp/EFDU+Cg/qfbXFX
 jPaGX8gKXC5LIIG/1D9jqV4coCIfU/j0K04RZ2vrordgHZnpe8/70nrkfKwF3pBLYxrzBbqWoCQfm
 Qc=;
Date: Tue, 09 Dec 2025 14:56:08 +0100
Subject: [PATCH 7/7] Drop TARGET_PHYS_ADDR_SPACE_BITS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251209-phys_addr-v1-7-c387f3e72d77@rev.ng>
References: <20251209-phys_addr-v1-0-c387f3e72d77@rev.ng>
In-Reply-To: <20251209-phys_addr-v1-0-c387f3e72d77@rev.ng>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The macro is no longer in use and can safely be dropped.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 include/exec/cpu-defs.h       | 3 ---
 include/exec/poison.h         | 2 --
 target/alpha/cpu-param.h      | 3 ---
 target/arm/cpu-param.h        | 2 --
 target/avr/cpu-param.h        | 1 -
 target/hexagon/cpu-param.h    | 1 -
 target/hppa/cpu-param.h       | 2 --
 target/i386/cpu-param.h       | 2 --
 target/loongarch/cpu-param.h  | 1 -
 target/m68k/cpu-param.h       | 1 -
 target/microblaze/cpu-param.h | 2 --
 target/mips/cpu-param.h       | 2 --
 target/openrisc/cpu-param.h   | 1 -
 target/ppc/cpu-param.h        | 7 -------
 target/riscv/cpu-param.h      | 2 --
 target/rx/cpu-param.h         | 1 -
 target/s390x/cpu-param.h      | 1 -
 target/sh4/cpu-param.h        | 1 -
 target/sparc/cpu-param.h      | 2 --
 target/tricore/cpu-param.h    | 1 -
 target/xtensa/cpu-param.h     | 1 -
 21 files changed, 39 deletions(-)

diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
index e01acb7c90..141b5a9929 100644
--- a/include/exec/cpu-defs.h
+++ b/include/exec/cpu-defs.h
@@ -28,9 +28,6 @@
 #ifndef TARGET_LONG_BITS
 # error TARGET_LONG_BITS must be defined in cpu-param.h
 #endif
-#ifndef TARGET_PHYS_ADDR_SPACE_BITS
-# error TARGET_PHYS_ADDR_SPACE_BITS must be defined in cpu-param.h
-#endif
 #ifndef TARGET_VIRT_ADDR_SPACE_BITS
 # error TARGET_VIRT_ADDR_SPACE_BITS must be defined in cpu-param.h
 #endif
diff --git a/include/exec/poison.h b/include/exec/poison.h
index a779adbb7a..2caf2d92f1 100644
--- a/include/exec/poison.h
+++ b/include/exec/poison.h
@@ -43,8 +43,6 @@
 #pragma GCC poison TARGET_FMT_ld
 #pragma GCC poison TARGET_FMT_lu
 
-#pragma GCC poison TARGET_PHYS_ADDR_SPACE_BITS
-
 #pragma GCC poison CONFIG_ALPHA_DIS
 #pragma GCC poison CONFIG_HPPA_DIS
 #pragma GCC poison CONFIG_I386_DIS
diff --git a/target/alpha/cpu-param.h b/target/alpha/cpu-param.h
index a799f42db3..e04bfeee12 100644
--- a/target/alpha/cpu-param.h
+++ b/target/alpha/cpu-param.h
@@ -8,9 +8,6 @@
 #ifndef ALPHA_CPU_PARAM_H
 #define ALPHA_CPU_PARAM_H
 
-/* ??? EV4 has 34 phys addr bits, EV5 has 40, EV6 has 44.  */
-#define TARGET_PHYS_ADDR_SPACE_BITS  44
-
 #ifdef CONFIG_USER_ONLY
 /*
  * Allow user-only to vary page size.  Real hardware allows only 8k and 64k,
diff --git a/target/arm/cpu-param.h b/target/arm/cpu-param.h
index 8b46c7c570..08785125ad 100644
--- a/target/arm/cpu-param.h
+++ b/target/arm/cpu-param.h
@@ -9,10 +9,8 @@
 #define ARM_CPU_PARAM_H
 
 #ifdef TARGET_AARCH64
-# define TARGET_PHYS_ADDR_SPACE_BITS  52
 # define TARGET_VIRT_ADDR_SPACE_BITS  52
 #else
-# define TARGET_PHYS_ADDR_SPACE_BITS  40
 # define TARGET_VIRT_ADDR_SPACE_BITS  32
 #endif
 
diff --git a/target/avr/cpu-param.h b/target/avr/cpu-param.h
index f74bfc2580..066ada1e9c 100644
--- a/target/avr/cpu-param.h
+++ b/target/avr/cpu-param.h
@@ -22,7 +22,6 @@
 #define AVR_CPU_PARAM_H
 
 #define TARGET_PAGE_BITS 10
-#define TARGET_PHYS_ADDR_SPACE_BITS 24
 #define TARGET_VIRT_ADDR_SPACE_BITS 24
 
 #define TARGET_INSN_START_EXTRA_WORDS 0
diff --git a/target/hexagon/cpu-param.h b/target/hexagon/cpu-param.h
index 635d509e74..31da1a239f 100644
--- a/target/hexagon/cpu-param.h
+++ b/target/hexagon/cpu-param.h
@@ -20,7 +20,6 @@
 
 #define TARGET_PAGE_BITS 16     /* 64K pages */
 
-#define TARGET_PHYS_ADDR_SPACE_BITS 36
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 
 #define TARGET_INSN_START_EXTRA_WORDS 0
diff --git a/target/hppa/cpu-param.h b/target/hppa/cpu-param.h
index 9bf7ac76d0..8e33d1ac36 100644
--- a/target/hppa/cpu-param.h
+++ b/target/hppa/cpu-param.h
@@ -9,11 +9,9 @@
 #define HPPA_CPU_PARAM_H
 
 #if defined(CONFIG_USER_ONLY) && defined(TARGET_ABI32)
-# define TARGET_PHYS_ADDR_SPACE_BITS  32
 # define TARGET_VIRT_ADDR_SPACE_BITS  32
 #else
 /* ??? PA-8000 through 8600 have 40 bits; PA-8700 and 8900 have 44 bits. */
-# define TARGET_PHYS_ADDR_SPACE_BITS  40
 # define TARGET_VIRT_ADDR_SPACE_BITS  64
 #endif
 
diff --git a/target/i386/cpu-param.h b/target/i386/cpu-param.h
index ebb844bcc8..9e4cb74e04 100644
--- a/target/i386/cpu-param.h
+++ b/target/i386/cpu-param.h
@@ -9,7 +9,6 @@
 #define I386_CPU_PARAM_H
 
 #ifdef TARGET_X86_64
-# define TARGET_PHYS_ADDR_SPACE_BITS  52
 /*
  * ??? This is really 48 bits, sign-extended, but the only thing
  * accessible to userland with bit 48 set is the VSYSCALL, and that
@@ -17,7 +16,6 @@
  */
 # define TARGET_VIRT_ADDR_SPACE_BITS  47
 #else
-# define TARGET_PHYS_ADDR_SPACE_BITS  36
 # define TARGET_VIRT_ADDR_SPACE_BITS  32
 #endif
 #define TARGET_PAGE_BITS 12
diff --git a/target/loongarch/cpu-param.h b/target/loongarch/cpu-param.h
index 58cc45a377..7779461054 100644
--- a/target/loongarch/cpu-param.h
+++ b/target/loongarch/cpu-param.h
@@ -8,7 +8,6 @@
 #ifndef LOONGARCH_CPU_PARAM_H
 #define LOONGARCH_CPU_PARAM_H
 
-#define TARGET_PHYS_ADDR_SPACE_BITS 48
 #define TARGET_VIRT_ADDR_SPACE_BITS 48
 
 #define TARGET_PAGE_BITS 12
diff --git a/target/m68k/cpu-param.h b/target/m68k/cpu-param.h
index 256a2b5f8b..802d8fc674 100644
--- a/target/m68k/cpu-param.h
+++ b/target/m68k/cpu-param.h
@@ -14,7 +14,6 @@
  * use the smallest one
  */
 #define TARGET_PAGE_BITS 12
-#define TARGET_PHYS_ADDR_SPACE_BITS 32
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 
 #define TARGET_INSN_START_EXTRA_WORDS 1
diff --git a/target/microblaze/cpu-param.h b/target/microblaze/cpu-param.h
index e0a3794513..90a0cf2435 100644
--- a/target/microblaze/cpu-param.h
+++ b/target/microblaze/cpu-param.h
@@ -17,10 +17,8 @@
  * of address space.
  */
 #ifdef CONFIG_USER_ONLY
-#define TARGET_PHYS_ADDR_SPACE_BITS 32
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 #else
-#define TARGET_PHYS_ADDR_SPACE_BITS 64
 #define TARGET_VIRT_ADDR_SPACE_BITS 64
 #endif
 
diff --git a/target/mips/cpu-param.h b/target/mips/cpu-param.h
index 58f450827f..d62110e732 100644
--- a/target/mips/cpu-param.h
+++ b/target/mips/cpu-param.h
@@ -8,10 +8,8 @@
 #define MIPS_CPU_PARAM_H
 
 #ifdef TARGET_ABI_MIPSN64
-#define TARGET_PHYS_ADDR_SPACE_BITS 48
 #define TARGET_VIRT_ADDR_SPACE_BITS 48
 #else
-#define TARGET_PHYS_ADDR_SPACE_BITS 40
 # ifdef CONFIG_USER_ONLY
 #  define TARGET_VIRT_ADDR_SPACE_BITS 31
 # else
diff --git a/target/openrisc/cpu-param.h b/target/openrisc/cpu-param.h
index b4f57bbe69..740cf76ddd 100644
--- a/target/openrisc/cpu-param.h
+++ b/target/openrisc/cpu-param.h
@@ -9,7 +9,6 @@
 #define OPENRISC_CPU_PARAM_H
 
 #define TARGET_PAGE_BITS 13
-#define TARGET_PHYS_ADDR_SPACE_BITS 32
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 
 #define TARGET_INSN_START_EXTRA_WORDS 1
diff --git a/target/ppc/cpu-param.h b/target/ppc/cpu-param.h
index e4ed9080ee..2065915dc5 100644
--- a/target/ppc/cpu-param.h
+++ b/target/ppc/cpu-param.h
@@ -9,12 +9,6 @@
 #define PPC_CPU_PARAM_H
 
 #ifdef TARGET_PPC64
-/*
- * Note that the official physical address space bits is 62-M where M
- * is implementation dependent.  I've not looked up M for the set of
- * cpus we emulate at the system level.
- */
-#define TARGET_PHYS_ADDR_SPACE_BITS 62
 /*
  * Note that the PPC environment architecture talks about 80 bit virtual
  * addresses, with segmentation.  Obviously that's not all visible to a
@@ -26,7 +20,6 @@
 #  define TARGET_VIRT_ADDR_SPACE_BITS 64
 # endif
 #else
-# define TARGET_PHYS_ADDR_SPACE_BITS 36
 # define TARGET_VIRT_ADDR_SPACE_BITS 32
 #endif
 
diff --git a/target/riscv/cpu-param.h b/target/riscv/cpu-param.h
index cfdc67c258..b96e1ce12e 100644
--- a/target/riscv/cpu-param.h
+++ b/target/riscv/cpu-param.h
@@ -9,10 +9,8 @@
 #define RISCV_CPU_PARAM_H
 
 #if defined(TARGET_RISCV64)
-# define TARGET_PHYS_ADDR_SPACE_BITS 56 /* 44-bit PPN */
 # define TARGET_VIRT_ADDR_SPACE_BITS 48 /* sv48 */
 #elif defined(TARGET_RISCV32)
-# define TARGET_PHYS_ADDR_SPACE_BITS 34 /* 22-bit PPN */
 # define TARGET_VIRT_ADDR_SPACE_BITS 32 /* sv32 */
 #endif
 #define TARGET_PAGE_BITS 12 /* 4 KiB Pages */
diff --git a/target/rx/cpu-param.h b/target/rx/cpu-param.h
index 84934f3bca..4cf6183aa0 100644
--- a/target/rx/cpu-param.h
+++ b/target/rx/cpu-param.h
@@ -21,7 +21,6 @@
 
 #define TARGET_PAGE_BITS 12
 
-#define TARGET_PHYS_ADDR_SPACE_BITS 32
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 
 #define TARGET_INSN_START_EXTRA_WORDS 0
diff --git a/target/s390x/cpu-param.h b/target/s390x/cpu-param.h
index abfae3bedf..e46e0757c6 100644
--- a/target/s390x/cpu-param.h
+++ b/target/s390x/cpu-param.h
@@ -9,7 +9,6 @@
 #define S390_CPU_PARAM_H
 
 #define TARGET_PAGE_BITS 12
-#define TARGET_PHYS_ADDR_SPACE_BITS 64
 #define TARGET_VIRT_ADDR_SPACE_BITS 64
 
 #define TARGET_INSN_START_EXTRA_WORDS 2
diff --git a/target/sh4/cpu-param.h b/target/sh4/cpu-param.h
index f328715ee8..e2632bb20f 100644
--- a/target/sh4/cpu-param.h
+++ b/target/sh4/cpu-param.h
@@ -9,7 +9,6 @@
 #define SH4_CPU_PARAM_H
 
 #define TARGET_PAGE_BITS 12  /* 4k */
-#define TARGET_PHYS_ADDR_SPACE_BITS  32
 #ifdef CONFIG_USER_ONLY
 # define TARGET_VIRT_ADDR_SPACE_BITS 31
 #else
diff --git a/target/sparc/cpu-param.h b/target/sparc/cpu-param.h
index 45eea9d6ba..4c92862ea3 100644
--- a/target/sparc/cpu-param.h
+++ b/target/sparc/cpu-param.h
@@ -9,7 +9,6 @@
 
 #ifdef TARGET_SPARC64
 # define TARGET_PAGE_BITS 13 /* 8k */
-# define TARGET_PHYS_ADDR_SPACE_BITS  41
 # ifdef TARGET_ABI32
 #  define TARGET_VIRT_ADDR_SPACE_BITS 32
 # else
@@ -17,7 +16,6 @@
 # endif
 #else
 # define TARGET_PAGE_BITS 12 /* 4k */
-# define TARGET_PHYS_ADDR_SPACE_BITS 36
 # define TARGET_VIRT_ADDR_SPACE_BITS 32
 #endif
 
diff --git a/target/tricore/cpu-param.h b/target/tricore/cpu-param.h
index eb33a67c41..f260a888c2 100644
--- a/target/tricore/cpu-param.h
+++ b/target/tricore/cpu-param.h
@@ -9,7 +9,6 @@
 #define TRICORE_CPU_PARAM_H
 
 #define TARGET_PAGE_BITS 14
-#define TARGET_PHYS_ADDR_SPACE_BITS 32
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 
 #define TARGET_INSN_START_EXTRA_WORDS 0
diff --git a/target/xtensa/cpu-param.h b/target/xtensa/cpu-param.h
index 7a0c22c900..328176281e 100644
--- a/target/xtensa/cpu-param.h
+++ b/target/xtensa/cpu-param.h
@@ -9,7 +9,6 @@
 #define XTENSA_CPU_PARAM_H
 
 #define TARGET_PAGE_BITS 12
-#define TARGET_PHYS_ADDR_SPACE_BITS 32
 #ifdef CONFIG_USER_ONLY
 #define TARGET_VIRT_ADDR_SPACE_BITS 30
 #else

-- 
2.51.0


