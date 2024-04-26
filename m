Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54230C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 19:52:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0RTl-0001dF-VI; Fri, 26 Apr 2024 15:43:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0RTi-0001Rb-2s
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 15:43:26 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0RTT-000345-9g
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 15:43:25 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-571c2055cb1so745622a12.1
 for <qemu-devel@nongnu.org>; Fri, 26 Apr 2024 12:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714160589; x=1714765389; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cKe3cZw/HcttjUJbHfrcy+l3NjV8jZoAyEBmM5OCTLI=;
 b=FudrCxSc87NtPBGFWYxH9Kw4OFHCetA9Iem+kd/KZRu8J+Du+eNPLDSklGR27/QyPn
 vf7M4IxZz+Qf46V/rDFkC9fEJpymkmu8oRFhHhZnZASjlE9Hd/QX4d9+nlMqYSurhV+l
 V9pq5h8wSAy9MRDQNQzQyscQ66u9f5a9CVIkitSqGicBrue/lqd02aEXnhnyuD/pQUQ7
 jKAs20tmhGtWa6j+AyNaWFmCZ8s0OCpxSb0UNT12u70IgvKovnl8quwnAH0VsUCx164T
 aJB796NwWrN27QxYNNMwBiJ95+D/Nf0ERGNHPVBLaUJtygA4PgleKYjMHNkEyWHEFObM
 qK0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714160589; x=1714765389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cKe3cZw/HcttjUJbHfrcy+l3NjV8jZoAyEBmM5OCTLI=;
 b=X3So3JQMLh2FKoLTv5tjN6GpBBLG8F21+GvAwlSnHNZQU3oI+bJ4aM6K6BK8kLkHnE
 PH3tZIWCVwD8RpG18KnhgBu0r3spALYpTGIG31OIrAM8XtXuM12XyJS/O1a9jRQ9h3aK
 HGVx7lGKVgeTktN5iqg+n6pih7sW8tIA2ruUdYL0DSDDdIqYyzzAajF9uFjLDnrQ/w7f
 TaIb+dnGyJDJ8q7rXILUOQh+2zT2AukDNcNnDkKUTP/P849UiYebDlhjPyqGYLSSiogo
 UG24J20OBFjjBnYafHNrJL+XtRHK4wj3CMyxcP9WbCV0w/369LBsviWFmBErcaixlfW8
 JlHA==
X-Gm-Message-State: AOJu0YzwaY8Xyh4KBXx+iwIpDEOWu/aQpY2MVyQTD6v75xkhvM9aRvSF
 K99EDTC96C1CzqGI5VyHAgBWQtm/Qo6WnJFyoBY4cydpoJd9dzl95BFTaiDUnTBQS6gpedXxi0t
 Fy94=
X-Google-Smtp-Source: AGHT+IH/ObdtTWbo8KUAN9Dh32LQQrRjhVEOcVbfZ+7COelwSb6FZcAQt0YN1RPg9TDWe2eHp7rL1g==
X-Received: by 2002:a50:ba88:0:b0:570:3bb:e099 with SMTP id
 x8-20020a50ba88000000b0057003bbe099mr3469020ede.1.1714160589480; 
 Fri, 26 Apr 2024 12:43:09 -0700 (PDT)
Received: from m1x-phil.lan (aul93-h02-176-184-11-147.dsl.sta.abo.bbox.fr.
 [176.184.11.147]) by smtp.gmail.com with ESMTPSA id
 15-20020a0564021f4f00b00571d74c6074sm8792683edz.46.2024.04.26.12.43.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 26 Apr 2024 12:43:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Song Gao <gaosong@loongson.cn>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Stafford Horne <shorne@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PULL 11/38] target: Define TCG_GUEST_DEFAULT_MO in 'cpu-param.h'
Date: Fri, 26 Apr 2024 21:41:31 +0200
Message-ID: <20240426194200.43723-12-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240426194200.43723-1-philmd@linaro.org>
References: <20240426194200.43723-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

accel/tcg/ files requires the following definitions:

  - TARGET_LONG_BITS
  - TARGET_PAGE_BITS
  - TARGET_PHYS_ADDR_SPACE_BITS
  - TCG_GUEST_DEFAULT_MO

The first 3 are defined in "cpu-param.h". The last one
in "cpu.h", with a bunch of definitions irrelevant for
TCG. By moving the TCG_GUEST_DEFAULT_MO definition to
"cpu-param.h", we can simplify various accel/tcg includes.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Nicholas Piggin <npiggin@gmail.com>
Message-Id: <20231211212003.21686-4-philmd@linaro.org>
---
 target/alpha/cpu-param.h      |  3 +++
 target/alpha/cpu.h            |  3 ---
 target/arm/cpu-param.h        |  8 +++++---
 target/arm/cpu.h              |  3 ---
 target/avr/cpu-param.h        |  2 ++
 target/avr/cpu.h              |  2 --
 target/hppa/cpu-param.h       |  8 ++++++++
 target/hppa/cpu.h             |  6 ------
 target/i386/cpu-param.h       |  3 +++
 target/i386/cpu.h             |  3 ---
 target/loongarch/cpu-param.h  |  2 ++
 target/loongarch/cpu.h        |  2 --
 target/microblaze/cpu-param.h |  3 +++
 target/microblaze/cpu.h       |  3 ---
 target/mips/cpu-param.h       |  2 ++
 target/mips/cpu.h             |  2 --
 target/openrisc/cpu-param.h   |  2 ++
 target/openrisc/cpu.h         |  2 --
 target/ppc/cpu-param.h        |  2 ++
 target/ppc/cpu.h              |  2 --
 target/riscv/cpu-param.h      |  2 ++
 target/riscv/cpu.h            |  2 --
 target/s390x/cpu-param.h      |  6 ++++++
 target/s390x/cpu.h            |  3 ---
 target/sparc/cpu-param.h      | 23 +++++++++++++++++++++++
 target/sparc/cpu.h            | 23 -----------------------
 target/xtensa/cpu-param.h     |  3 +++
 target/xtensa/cpu.h           |  3 ---
 28 files changed, 66 insertions(+), 62 deletions(-)

diff --git a/target/alpha/cpu-param.h b/target/alpha/cpu-param.h
index c969cb016b..5ce213a9a1 100644
--- a/target/alpha/cpu-param.h
+++ b/target/alpha/cpu-param.h
@@ -27,4 +27,7 @@
 # define TARGET_VIRT_ADDR_SPACE_BITS  (30 + TARGET_PAGE_BITS)
 #endif
 
+/* Alpha processors have a weak memory model */
+#define TCG_GUEST_DEFAULT_MO      (0)
+
 #endif
diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index 7188a409a0..f9e2ecb90a 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -24,9 +24,6 @@
 #include "exec/cpu-defs.h"
 #include "qemu/cpu-float.h"
 
-/* Alpha processors have a weak memory model */
-#define TCG_GUEST_DEFAULT_MO      (0)
-
 #define ICACHE_LINE_SIZE 32
 #define DCACHE_LINE_SIZE 32
 
diff --git a/target/arm/cpu-param.h b/target/arm/cpu-param.h
index da3243ab21..2d5f3aa312 100644
--- a/target/arm/cpu-param.h
+++ b/target/arm/cpu-param.h
@@ -27,14 +27,16 @@
 # else
 #  define TARGET_PAGE_BITS 12
 # endif
-#else
+#else /* !CONFIG_USER_ONLY */
 /*
  * ARMv7 and later CPUs have 4K pages minimum, but ARMv5 and v6
  * have to support 1K tiny pages.
  */
 # define TARGET_PAGE_BITS_VARY
 # define TARGET_PAGE_BITS_MIN  10
-
-#endif
+#endif /* !CONFIG_USER_ONLY */
+
+/* ARM processors have a weak memory model */
+#define TCG_GUEST_DEFAULT_MO      (0)
 
 #endif
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 97997dbd08..17efc5d565 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -30,9 +30,6 @@
 #include "target/arm/multiprocessing.h"
 #include "target/arm/gtimer.h"
 
-/* ARM processors have a weak memory model */
-#define TCG_GUEST_DEFAULT_MO      (0)
-
 #ifdef TARGET_AARCH64
 #define KVM_HAVE_MCE_INJECTION 1
 #endif
diff --git a/target/avr/cpu-param.h b/target/avr/cpu-param.h
index 9a92bc74fc..93c2f470d0 100644
--- a/target/avr/cpu-param.h
+++ b/target/avr/cpu-param.h
@@ -32,4 +32,6 @@
 #define TARGET_PHYS_ADDR_SPACE_BITS 24
 #define TARGET_VIRT_ADDR_SPACE_BITS 24
 
+#define TCG_GUEST_DEFAULT_MO 0
+
 #endif
diff --git a/target/avr/cpu.h b/target/avr/cpu.h
index d185d20dcb..4725535102 100644
--- a/target/avr/cpu.h
+++ b/target/avr/cpu.h
@@ -30,8 +30,6 @@
 
 #define CPU_RESOLVING_TYPE TYPE_AVR_CPU
 
-#define TCG_GUEST_DEFAULT_MO 0
-
 /*
  * AVR has two memory spaces, data & code.
  * e.g. both have 0 address
diff --git a/target/hppa/cpu-param.h b/target/hppa/cpu-param.h
index bb3d7ef6f7..473d489f01 100644
--- a/target/hppa/cpu-param.h
+++ b/target/hppa/cpu-param.h
@@ -21,4 +21,12 @@
 
 #define TARGET_PAGE_BITS 12
 
+/* PA-RISC 1.x processors have a strong memory model.  */
+/*
+ * ??? While we do not yet implement PA-RISC 2.0, those processors have
+ * a weak memory model, but with TLB bits that force ordering on a per-page
+ * basis.  It's probably easier to fall back to a strong memory model.
+ */
+#define TCG_GUEST_DEFAULT_MO        TCG_MO_ALL
+
 #endif
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index a072d0bb63..fb2e4c4a98 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -25,12 +25,6 @@
 #include "qemu/cpu-float.h"
 #include "qemu/interval-tree.h"
 
-/* PA-RISC 1.x processors have a strong memory model.  */
-/* ??? While we do not yet implement PA-RISC 2.0, those processors have
-   a weak memory model, but with TLB bits that force ordering on a per-page
-   basis.  It's probably easier to fall back to a strong memory model.  */
-#define TCG_GUEST_DEFAULT_MO        TCG_MO_ALL
-
 #define MMU_ABS_W_IDX     6
 #define MMU_ABS_IDX       7
 #define MMU_KERNEL_IDX    8
diff --git a/target/i386/cpu-param.h b/target/i386/cpu-param.h
index 911b4cd51b..5e15335203 100644
--- a/target/i386/cpu-param.h
+++ b/target/i386/cpu-param.h
@@ -24,4 +24,7 @@
 #endif
 #define TARGET_PAGE_BITS 12
 
+/* The x86 has a strong memory model with some store-after-load re-ordering */
+#define TCG_GUEST_DEFAULT_MO      (TCG_MO_ALL & ~TCG_MO_ST_LD)
+
 #endif
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 6112e27bfd..565c7a98c3 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -30,9 +30,6 @@
 
 #define XEN_NR_VIRQS 24
 
-/* The x86 has a strong memory model with some store-after-load re-ordering */
-#define TCG_GUEST_DEFAULT_MO      (TCG_MO_ALL & ~TCG_MO_ST_LD)
-
 #define KVM_HAVE_MCE_INJECTION 1
 
 /* support for self modifying code even if the modified instruction is
diff --git a/target/loongarch/cpu-param.h b/target/loongarch/cpu-param.h
index cfe195db4e..db5ad1c69f 100644
--- a/target/loongarch/cpu-param.h
+++ b/target/loongarch/cpu-param.h
@@ -14,4 +14,6 @@
 
 #define TARGET_PAGE_BITS 12
 
+#define TCG_GUEST_DEFAULT_MO (0)
+
 #endif
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index ec37579fd6..abb01b2cc7 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -39,8 +39,6 @@
 
 #define IOCSR_MEM_SIZE          0x428
 
-#define TCG_GUEST_DEFAULT_MO (0)
-
 #define FCSR0_M1    0x1f         /* FCSR1 mask, Enables */
 #define FCSR0_M2    0x1f1f0000   /* FCSR2 mask, Cause and Flags */
 #define FCSR0_M3    0x300        /* FCSR3 mask, Round Mode */
diff --git a/target/microblaze/cpu-param.h b/target/microblaze/cpu-param.h
index 9770b0eb52..e530fead1c 100644
--- a/target/microblaze/cpu-param.h
+++ b/target/microblaze/cpu-param.h
@@ -29,4 +29,7 @@
 /* FIXME: MB uses variable pages down to 1K but linux only uses 4k.  */
 #define TARGET_PAGE_BITS 12
 
+/* MicroBlaze is always in-order. */
+#define TCG_GUEST_DEFAULT_MO  TCG_MO_ALL
+
 #endif
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index c0c7574dbd..3e5a3e5c60 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -24,9 +24,6 @@
 #include "exec/cpu-defs.h"
 #include "qemu/cpu-float.h"
 
-/* MicroBlaze is always in-order. */
-#define TCG_GUEST_DEFAULT_MO  TCG_MO_ALL
-
 typedef struct CPUArchState CPUMBState;
 #if !defined(CONFIG_USER_ONLY)
 #include "mmu.h"
diff --git a/target/mips/cpu-param.h b/target/mips/cpu-param.h
index 594c91a156..6f6ac1688f 100644
--- a/target/mips/cpu-param.h
+++ b/target/mips/cpu-param.h
@@ -30,4 +30,6 @@
 #define TARGET_PAGE_BITS_MIN 12
 #endif
 
+#define TCG_GUEST_DEFAULT_MO (0)
+
 #endif
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 7329226d39..3e906a175a 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -10,8 +10,6 @@
 #include "hw/clock.h"
 #include "mips-defs.h"
 
-#define TCG_GUEST_DEFAULT_MO (0)
-
 typedef struct CPUMIPSTLBContext CPUMIPSTLBContext;
 
 /* MSA Context */
diff --git a/target/openrisc/cpu-param.h b/target/openrisc/cpu-param.h
index 3f08207485..fbfc0f568b 100644
--- a/target/openrisc/cpu-param.h
+++ b/target/openrisc/cpu-param.h
@@ -13,4 +13,6 @@
 #define TARGET_PHYS_ADDR_SPACE_BITS 32
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 
+#define TCG_GUEST_DEFAULT_MO (0)
+
 #endif
diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index b1b7db5cbd..c9fe9ae12d 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -24,8 +24,6 @@
 #include "exec/cpu-defs.h"
 #include "fpu/softfloat-types.h"
 
-#define TCG_GUEST_DEFAULT_MO (0)
-
 /**
  * OpenRISCCPUClass:
  * @parent_realize: The parent class' realize handler.
diff --git a/target/ppc/cpu-param.h b/target/ppc/cpu-param.h
index b7ad52de03..77c5ed9a67 100644
--- a/target/ppc/cpu-param.h
+++ b/target/ppc/cpu-param.h
@@ -40,4 +40,6 @@
 # define TARGET_PAGE_BITS 12
 #endif
 
+#define TCG_GUEST_DEFAULT_MO 0
+
 #endif
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 67e6b2effd..0ac55d6b25 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -29,8 +29,6 @@
 
 #define CPU_RESOLVING_TYPE TYPE_POWERPC_CPU
 
-#define TCG_GUEST_DEFAULT_MO 0
-
 #define TARGET_PAGE_BITS_64K 16
 #define TARGET_PAGE_BITS_16M 24
 
diff --git a/target/riscv/cpu-param.h b/target/riscv/cpu-param.h
index b2a9396dec..1fbd64939d 100644
--- a/target/riscv/cpu-param.h
+++ b/target/riscv/cpu-param.h
@@ -28,4 +28,6 @@
  *  - M mode HLV/HLVX/HSV 0b111
  */
 
+#define TCG_GUEST_DEFAULT_MO 0
+
 #endif
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 3b1a02b944..2d0c02c35b 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -43,8 +43,6 @@ typedef struct CPUArchState CPURISCVState;
 # define TYPE_RISCV_CPU_BASE            TYPE_RISCV_CPU_BASE64
 #endif
 
-#define TCG_GUEST_DEFAULT_MO 0
-
 /*
  * RISC-V-specific extra insn start words:
  * 1: Original instruction opcode
diff --git a/target/s390x/cpu-param.h b/target/s390x/cpu-param.h
index 84ca08626b..11d23b600d 100644
--- a/target/s390x/cpu-param.h
+++ b/target/s390x/cpu-param.h
@@ -13,4 +13,10 @@
 #define TARGET_PHYS_ADDR_SPACE_BITS 64
 #define TARGET_VIRT_ADDR_SPACE_BITS 64
 
+/*
+ * The z/Architecture has a strong memory model with some
+ * store-after-load re-ordering.
+ */
+#define TCG_GUEST_DEFAULT_MO      (TCG_MO_ALL & ~TCG_MO_ST_LD)
+
 #endif
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 43a46a5a06..414680eed1 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -33,9 +33,6 @@
 
 #define ELF_MACHINE_UNAME "S390X"
 
-/* The z/Architecture has a strong memory model with some store-after-load re-ordering */
-#define TCG_GUEST_DEFAULT_MO      (TCG_MO_ALL & ~TCG_MO_ST_LD)
-
 #define TARGET_HAS_PRECISE_SMC
 
 #define TARGET_INSN_START_EXTRA_WORDS 2
diff --git a/target/sparc/cpu-param.h b/target/sparc/cpu-param.h
index cb11980404..82293fb844 100644
--- a/target/sparc/cpu-param.h
+++ b/target/sparc/cpu-param.h
@@ -23,4 +23,27 @@
 # define TARGET_VIRT_ADDR_SPACE_BITS 32
 #endif
 
+/*
+ * From Oracle SPARC Architecture 2015:
+ *
+ *   Compatibility notes: The PSO memory model described in SPARC V8 and
+ *   SPARC V9 compatibility architecture specifications was never implemented
+ *   in a SPARC V9 implementation and is not included in the Oracle SPARC
+ *   Architecture specification.
+ *
+ *   The RMO memory model described in the SPARC V9 specification was
+ *   implemented in some non-Sun SPARC V9 implementations, but is not
+ *   directly supported in Oracle SPARC Architecture 2015 implementations.
+ *
+ * Therefore always use TSO in QEMU.
+ *
+ * D.5 Specification of Partial Store Order (PSO)
+ *   ... [loads] are followed by an implied MEMBAR #LoadLoad | #LoadStore.
+ *
+ * D.6 Specification of Total Store Order (TSO)
+ *   ... PSO with the additional requirement that all [stores] are followed
+ *   by an implied MEMBAR #StoreStore.
+ */
+#define TCG_GUEST_DEFAULT_MO  (TCG_MO_LD_LD | TCG_MO_LD_ST | TCG_MO_ST_ST)
+
 #endif
diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index f3cdd17c62..dfd9512a21 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -6,29 +6,6 @@
 #include "exec/cpu-defs.h"
 #include "qemu/cpu-float.h"
 
-/*
- * From Oracle SPARC Architecture 2015:
- *
- *   Compatibility notes: The PSO memory model described in SPARC V8 and
- *   SPARC V9 compatibility architecture specifications was never implemented
- *   in a SPARC V9 implementation and is not included in the Oracle SPARC
- *   Architecture specification.
- *
- *   The RMO memory model described in the SPARC V9 specification was
- *   implemented in some non-Sun SPARC V9 implementations, but is not
- *   directly supported in Oracle SPARC Architecture 2015 implementations.
- *
- * Therefore always use TSO in QEMU.
- *
- * D.5 Specification of Partial Store Order (PSO)
- *   ... [loads] are followed by an implied MEMBAR #LoadLoad | #LoadStore.
- *
- * D.6 Specification of Total Store Order (TSO)
- *   ... PSO with the additional requirement that all [stores] are followed
- *   by an implied MEMBAR #StoreStore.
- */
-#define TCG_GUEST_DEFAULT_MO  (TCG_MO_LD_LD | TCG_MO_LD_ST | TCG_MO_ST_ST)
-
 #if !defined(TARGET_SPARC64)
 #define TARGET_DPREGS 16
 #define TARGET_FCCREGS 1
diff --git a/target/xtensa/cpu-param.h b/target/xtensa/cpu-param.h
index b1da0555de..0000725f2f 100644
--- a/target/xtensa/cpu-param.h
+++ b/target/xtensa/cpu-param.h
@@ -17,4 +17,7 @@
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 #endif
 
+/* Xtensa processors have a weak memory model */
+#define TCG_GUEST_DEFAULT_MO      (0)
+
 #endif
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 6b8d0636d2..9f2341d856 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -34,9 +34,6 @@
 #include "hw/clock.h"
 #include "xtensa-isa.h"
 
-/* Xtensa processors have a weak memory model */
-#define TCG_GUEST_DEFAULT_MO      (0)
-
 enum {
     /* Additional instructions */
     XTENSA_OPTION_CODE_DENSITY,
-- 
2.41.0


