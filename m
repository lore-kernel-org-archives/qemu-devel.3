Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7183FD45FA
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 23:15:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvO5z-00050x-OS; Wed, 25 Feb 2026 18:15:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvO5x-00050T-Sq
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:15:05 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvO5v-0002at-Fr
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:15:05 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-43767807cf3so146201f8f.1
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 15:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772061301; x=1772666101; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AOnr4qaJdaK1kJiZweSuzTjxuUU2NRSI0QvsVn5psy8=;
 b=FEoGVmZQ8SyEbjevNkWj3Mqxem2W7kWVfTvanuguTALqIPgP047eFPyJdEKcNEqbd8
 C7K+Wjm4/afVRlYRPWFZVFpLht0YYut1hsudS9B2SNRtLl93aVGm8wtqK4Mxwq+O3T75
 FtRXQSsp/EQFYAOR27Y6LmYnJMxwKIb1NzFVrjXrKw8nDmgbPIx/uWJCRPTlbxf34/LU
 VmVA8MtnWSkxPTEnb34nmvVZlXOn5P+r9lfyBpaydIIZM0TByXcGLVu19tbe5wB3EWUD
 SqtSjW+vJqdawgLNdww1HEslCfO1R0nCraYol9DiNvwD+hwKKZNdLnRaKBbNNuE+AIDI
 ZaVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772061301; x=1772666101;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=AOnr4qaJdaK1kJiZweSuzTjxuUU2NRSI0QvsVn5psy8=;
 b=sfPDUKlawRIBMTfszRu8ytWtyMXT5ru7dQQuJNTsC87/CovA2ekL1ozPk1NYlH+6Mu
 jS1HptO83/RQS+NpiiaSM5EkSisRw3tmpJO3fzbP2Qm/M6+mTS8DghwDqzpJ9flXagks
 Ffpwml+ISVGjbbATjWXYstkH7+CQvKcYWyQ7rsa7Y7svjCjge6lcPQo/ASeWhXTeYIRK
 Gy6gD8nC+AiQC+j5ZuM/cIHnsQwOSj6ZzxBVdDppZcZ+Z7uhpmlziknsAqhx9R9vl1w4
 jf1panr2nlsTGAuCO20afWK7/dw8BURHZmTO407jsRLLsw2lczGFxu4RV2I58D8I62lM
 eRzA==
X-Gm-Message-State: AOJu0YzXI8/4GS73RJVHbubk0XZCjS4DL0k4WQxWo/CSlwN2bzE3tPQ6
 jRfUhU7W9s0COTm/uPjjVDGKBIZPXhzgkb4hqhohbcLmixn7yEekuysFrZJVoTCujXE/rrANIqh
 2Li5xq6U=
X-Gm-Gg: ATEYQzzh3ZgE+7w3pbCOmlfHG8oif4fKRzrVU/Ls83LFxqgUwmHM6umphpMdbJI3Dz+
 uI/tDYhnonlVL6glrioMvqW2cyG4oPWS50ZwG/zBJO4kZimIoFzBK6MPBgTtEwvZIKQ6IxNg9g7
 0Qmmq+MiI4vmX+5r9MBY9OkZXa5ZcL/B82w9UbnnLFcmTmuxtMl6WPd5HtUaXq9qIORmkKyTRPt
 UGHNxuwKRzMC+8Ta5g97KnkwY2c+XXzmwCOfmYYdhGNJq7DLmDdldytYHM1rlVbugf8O93EhhvH
 mk/yGwLXfgC9S/yrkI3r+gFXwMRl3XJwEyD+5tnsxF0sJTmGCn5ujlRYAHNsbF75ftUzjLdfi0c
 oFJVQozdRRB6IrZ1pY0NQWubIZF9E7jQWd+SBtHwLUvNQ/02F0WswCtMTE8iIsclpsFUF+McOMq
 zIoRwmtRWhk0bJJkqY0ISwy1cOl3GHt5t79hOz3lWsnpKLZJjwVom5YOTUjIXzjzAr4hOsCJo8
X-Received: by 2002:a5d:5d85:0:b0:430:f742:fbc7 with SMTP id
 ffacd0b85a97d-439942aa2bcmr4199223f8f.14.1772061301333; 
 Wed, 25 Feb 2026 15:15:01 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4398a292babsm13296868f8f.37.2026.02.25.15.14.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Feb 2026 15:15:00 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/70] exec: Drop TARGET_PHYS_ADDR_SPACE_BITS
Date: Thu, 26 Feb 2026 00:13:07 +0100
Message-ID: <20260225231411.96482-8-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225231411.96482-1-philmd@linaro.org>
References: <20260225231411.96482-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Anton Johansson <anjo@rev.ng>

The macro is no longer in use and can safely be dropped.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
Signed-off-by: Anton Johansson <anjo@rev.ng>
Message-ID: <20260218-phys_addr-v6-7-a603bf363218@rev.ng>
[PMD: Keep TARGET_PHYS_ADDR_SPACE_BITS poisoned]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/cpu-defs.h       | 3 ---
 target/alpha/cpu-param.h      | 3 ---
 target/arm/cpu-param.h        | 2 --
 target/avr/cpu-param.h        | 1 -
 target/hexagon/cpu-param.h    | 1 -
 target/hppa/cpu-param.h       | 3 ---
 target/i386/cpu-param.h       | 2 --
 target/loongarch/cpu-param.h  | 1 -
 target/m68k/cpu-param.h       | 1 -
 target/microblaze/cpu-param.h | 2 --
 target/mips/cpu-param.h       | 2 --
 target/or1k/cpu-param.h       | 1 -
 target/ppc/cpu-param.h        | 7 -------
 target/riscv/cpu-param.h      | 2 --
 target/rx/cpu-param.h         | 1 -
 target/s390x/cpu-param.h      | 1 -
 target/sh4/cpu-param.h        | 1 -
 target/sparc/cpu-param.h      | 2 --
 target/tricore/cpu-param.h    | 1 -
 target/xtensa/cpu-param.h     | 1 -
 20 files changed, 38 deletions(-)

diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
index e01acb7c906..141b5a99292 100644
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
diff --git a/target/alpha/cpu-param.h b/target/alpha/cpu-param.h
index c9da620ab3e..f87b36fe873 100644
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
index 7de0099cbfa..f67e7b34606 100644
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
index ea7887919a7..130768db51f 100644
--- a/target/avr/cpu-param.h
+++ b/target/avr/cpu-param.h
@@ -22,7 +22,6 @@
 #define AVR_CPU_PARAM_H
 
 #define TARGET_PAGE_BITS 10
-#define TARGET_PHYS_ADDR_SPACE_BITS 24
 #define TARGET_VIRT_ADDR_SPACE_BITS 24
 
 #endif
diff --git a/target/hexagon/cpu-param.h b/target/hexagon/cpu-param.h
index 45ee7b46409..1f0f22a7968 100644
--- a/target/hexagon/cpu-param.h
+++ b/target/hexagon/cpu-param.h
@@ -20,7 +20,6 @@
 
 #define TARGET_PAGE_BITS 16     /* 64K pages */
 
-#define TARGET_PHYS_ADDR_SPACE_BITS 36
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 
 #endif
diff --git a/target/hppa/cpu-param.h b/target/hppa/cpu-param.h
index e0b2c7c9157..3763bca1252 100644
--- a/target/hppa/cpu-param.h
+++ b/target/hppa/cpu-param.h
@@ -9,11 +9,8 @@
 #define HPPA_CPU_PARAM_H
 
 #if defined(CONFIG_USER_ONLY) && defined(TARGET_ABI32)
-# define TARGET_PHYS_ADDR_SPACE_BITS  32
 # define TARGET_VIRT_ADDR_SPACE_BITS  32
 #else
-/* ??? PA-8000 through 8600 have 40 bits; PA-8700 and 8900 have 44 bits. */
-# define TARGET_PHYS_ADDR_SPACE_BITS  40
 # define TARGET_VIRT_ADDR_SPACE_BITS  64
 #endif
 
diff --git a/target/i386/cpu-param.h b/target/i386/cpu-param.h
index 909bc027923..5915ef6266c 100644
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
index 071567712b3..3bcf77b3755 100644
--- a/target/loongarch/cpu-param.h
+++ b/target/loongarch/cpu-param.h
@@ -8,7 +8,6 @@
 #ifndef LOONGARCH_CPU_PARAM_H
 #define LOONGARCH_CPU_PARAM_H
 
-#define TARGET_PHYS_ADDR_SPACE_BITS 48
 #define TARGET_VIRT_ADDR_SPACE_BITS 48
 
 #define TARGET_PAGE_BITS 12
diff --git a/target/m68k/cpu-param.h b/target/m68k/cpu-param.h
index 7afbf6d302d..59e04d85ff9 100644
--- a/target/m68k/cpu-param.h
+++ b/target/m68k/cpu-param.h
@@ -14,7 +14,6 @@
  * use the smallest one
  */
 #define TARGET_PAGE_BITS 12
-#define TARGET_PHYS_ADDR_SPACE_BITS 32
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 
 #endif
diff --git a/target/microblaze/cpu-param.h b/target/microblaze/cpu-param.h
index 6a0714bb3d7..0b13f219c2a 100644
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
index a71e7383d24..122193b0db3 100644
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
diff --git a/target/or1k/cpu-param.h b/target/or1k/cpu-param.h
index 3011bf5fcca..1ff89d523f1 100644
--- a/target/or1k/cpu-param.h
+++ b/target/or1k/cpu-param.h
@@ -9,7 +9,6 @@
 #define OPENRISC_CPU_PARAM_H
 
 #define TARGET_PAGE_BITS 13
-#define TARGET_PHYS_ADDR_SPACE_BITS 32
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 
 #endif
diff --git a/target/ppc/cpu-param.h b/target/ppc/cpu-param.h
index ca7602d8983..5e211d10b0b 100644
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
index 039e877891a..ddb76a5300f 100644
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
index ef1970a09e9..3806f41b2fe 100644
--- a/target/rx/cpu-param.h
+++ b/target/rx/cpu-param.h
@@ -21,7 +21,6 @@
 
 #define TARGET_PAGE_BITS 12
 
-#define TARGET_PHYS_ADDR_SPACE_BITS 32
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 
 #endif
diff --git a/target/s390x/cpu-param.h b/target/s390x/cpu-param.h
index a5f798eeae7..caef5a0e5c8 100644
--- a/target/s390x/cpu-param.h
+++ b/target/s390x/cpu-param.h
@@ -9,7 +9,6 @@
 #define S390_CPU_PARAM_H
 
 #define TARGET_PAGE_BITS 12
-#define TARGET_PHYS_ADDR_SPACE_BITS 64
 #define TARGET_VIRT_ADDR_SPACE_BITS 64
 
 #endif
diff --git a/target/sh4/cpu-param.h b/target/sh4/cpu-param.h
index 2b6e11dd0ac..c3b8114e538 100644
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
index 6e8e2a51469..7ec4ac84dbb 100644
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
index 790242ef3d2..7a5f67fe15e 100644
--- a/target/tricore/cpu-param.h
+++ b/target/tricore/cpu-param.h
@@ -9,7 +9,6 @@
 #define TRICORE_CPU_PARAM_H
 
 #define TARGET_PAGE_BITS 14
-#define TARGET_PHYS_ADDR_SPACE_BITS 32
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 
 #endif
diff --git a/target/xtensa/cpu-param.h b/target/xtensa/cpu-param.h
index 06d85218b84..1a9cdcefb49 100644
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
2.52.0


