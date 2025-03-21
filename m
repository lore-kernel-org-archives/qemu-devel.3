Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92BBEC36000
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 12:58:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvbww-0007mx-6h; Fri, 21 Mar 2025 08:58:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvbwp-0007lz-Nr
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 08:58:04 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvbwm-00031h-R6
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 08:58:03 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3997205e43eso1549352f8f.0
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 05:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742561879; x=1743166679; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WasTNRPB8s2qD7li7JaGZOSGNzq59uPVovl8lwAiCyo=;
 b=s7/JsxmAIIFBYs8XpsM45soOSz2IFmifrI8N5zqDqwFUQu4FLNyBt+5CBCzJWq/tj4
 mcZpgY91lR5gUeeL3tLZuKtO/JiS3F1qndaZ52hhXVfiqANT3Teos/CAY0irHwq2raTJ
 xZAI/0cz8fs/wDZH+XQ8TKSoZPPwpR7dM+lrLxWwqIyU/5q6Uai9ABqYAtX0/t6yOGF9
 gB64Dk8dBWdqzWUZoyLapyInQiyA+3wG/jOpRykLtAfhU4mD9g4jtLMX3LwuCo0qPsdY
 FdKQsGTQDVIVqpd7WvE3EpY0JiYKd14/tdvcLV96R1GKNT2EXiozlnDIN4yxfVgfLjyf
 B8xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742561879; x=1743166679;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WasTNRPB8s2qD7li7JaGZOSGNzq59uPVovl8lwAiCyo=;
 b=vAUQCagFGbrYRFFNMWcgQCtlcVHNMa8Loxy+rvGokD5lZq2G5OccFJGktSDd44inDl
 eNecZeGK30NOFe5R9d+ZPLM+ut6LFfkBBgq2t1azjMd8/UjcjVVKo26NOygq+n0j10FP
 KnzTI5KOLKbm+hZH/1qNsZcjqF/jKiG7SpguaVuIcIdzlnmrKCDY0Q5twUTp2lchZnXr
 RT09sEq63LsBSmr96Mzg+KSmQeD6/M/nDtuQQTtXplxrVxpi608IyMNW2iLRxOR4Td/Y
 RbPStpf+VNuBX13DtelPuHaeRm9Q4FFbjYLnPG9gxv+By1xumDb/8jZxgW2aZk6jh6Qy
 Fl+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwKFkTUQ0D22mD/eP/YkENnSFhxMbJZtmAQUZlGEVpBvbIu6xFUpoH4ioSu61rylxv7yP7/IDsWkwo@nongnu.org
X-Gm-Message-State: AOJu0Yy4kTPQobYYaEmotpJMnwaFrO4zLYAQoqCS6uVErzJlbAizBYQL
 dc1/1V8Gt8EHP8/xF3XLDlCmIKolRKjXR7MqKc5HBH1ou5X/2aHEPQZZeee4Wbs=
X-Gm-Gg: ASbGnctlC/xdbo09xmWyFRzDC7QOYxPdzvjiYwaGnl+EG0TgYOGQE7wsP7DYK+owr04
 bDfb24/nb3chfipdCEe1RV9yQQFXKIPqGJYvGt0ODFnjTX5hDh2vLc3M5ViUbaAgvyUfIpOSwxg
 fRJw8MA92Ru0D1FKLN9zSWqoDFFNIZvNN11GaGaEb783DuNSaIXbe2aoRjyAS/uZjIJxZi+Tve/
 Zg9tkdXhFfRdx7UqkSoNDL+akrcCJz0XQWpEkJ27JvFdBBE0VTEdlZNvKKhEoj16cVrZQcNDzPq
 Xg9KBcQaUQqclzMfhYuoK7gOGWSWwmVUH+FS7l8QefEnUEyDmImaN/wmgd2ttvR7zJtbwogIODx
 pIC3Sf9Ogd7GeBGZSpWw=
X-Google-Smtp-Source: AGHT+IHuEbyRjg9OFf6i8wvFanBt26hg/uH1YBqiqm+vuuROm3KF+C+6QwHBkmXeBFD9DOXJ4jG7Zg==
X-Received: by 2002:a5d:64a7:0:b0:391:13d6:c9e5 with SMTP id
 ffacd0b85a97d-3997f902a67mr3109302f8f.19.1742561879106; 
 Fri, 21 Mar 2025 05:57:59 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9956b4sm2298150f8f.7.2025.03.21.05.57.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 21 Mar 2025 05:57:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH-for-10.1 4/4] tcg: Define guest_default_memory_order in
 TCGCPUOps
Date: Fri, 21 Mar 2025 13:57:37 +0100
Message-ID: <20250321125737.72839-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250321125737.72839-1-philmd@linaro.org>
References: <20250321125737.72839-1-philmd@linaro.org>
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

Add the TCGCPUOps::guest_default_memory_order field and have
each target initialize it.

Use it to set TCGContext::guest_mo in tb_gen_code(), removing
the need for the TCG_GUEST_DEFAULT_MO definition.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/accel/tcg/cpu-ops.h   |  8 ++++++++
 target/alpha/cpu-param.h      |  3 ---
 target/arm/cpu-param.h        |  3 ---
 target/avr/cpu-param.h        |  2 --
 target/hexagon/cpu-param.h    |  3 ---
 target/hppa/cpu-param.h       |  8 --------
 target/i386/cpu-param.h       |  3 ---
 target/loongarch/cpu-param.h  |  2 --
 target/m68k/cpu-param.h       |  3 ---
 target/microblaze/cpu-param.h |  3 ---
 target/mips/cpu-param.h       |  2 --
 target/openrisc/cpu-param.h   |  2 --
 target/ppc/cpu-param.h        |  2 --
 target/riscv/cpu-param.h      |  2 --
 target/rx/cpu-param.h         |  3 ---
 target/s390x/cpu-param.h      |  6 ------
 target/sh4/cpu-param.h        |  3 ---
 target/sparc/cpu-param.h      | 23 -----------------------
 target/tricore/cpu-param.h    |  3 ---
 target/xtensa/cpu-param.h     |  3 ---
 accel/tcg/translate-all.c     |  2 +-
 target/alpha/cpu.c            |  3 +++
 target/arm/cpu.c              |  3 +++
 target/arm/tcg/cpu-v7m.c      |  3 +++
 target/avr/cpu.c              |  1 +
 target/hexagon/cpu.c          |  2 ++
 target/hppa/cpu.c             |  8 ++++++++
 target/i386/tcg/tcg-cpu.c     |  5 +++++
 target/loongarch/cpu.c        |  2 ++
 target/m68k/cpu.c             |  3 +++
 target/microblaze/cpu.c       |  3 +++
 target/mips/cpu.c             |  2 ++
 target/openrisc/cpu.c         |  2 ++
 target/ppc/cpu_init.c         |  2 ++
 target/riscv/tcg/tcg-cpu.c    |  2 ++
 target/rx/cpu.c               |  3 +++
 target/s390x/cpu.c            |  6 ++++++
 target/sh4/cpu.c              |  3 +++
 target/sparc/cpu.c            | 23 +++++++++++++++++++++++
 target/tricore/cpu.c          |  2 ++
 target/xtensa/cpu.c           |  3 +++
 41 files changed, 90 insertions(+), 80 deletions(-)

diff --git a/include/accel/tcg/cpu-ops.h b/include/accel/tcg/cpu-ops.h
index f60e5303f21..5fd299cefb6 100644
--- a/include/accel/tcg/cpu-ops.h
+++ b/include/accel/tcg/cpu-ops.h
@@ -16,8 +16,16 @@
 #include "exec/memop.h"
 #include "exec/mmu-access-type.h"
 #include "exec/vaddr.h"
+#include "tcg/tcg-mo.h"
 
 struct TCGCPUOps {
+
+    /**
+     * @guest_default_memory_order: default barrier that is required
+     *                              for the guest memory ordering.
+     */
+    TCGBar guest_default_memory_order;
+
     /**
      * @initialize: Initialize TCG state
      *
diff --git a/target/alpha/cpu-param.h b/target/alpha/cpu-param.h
index ff06e41497a..c74556d2667 100644
--- a/target/alpha/cpu-param.h
+++ b/target/alpha/cpu-param.h
@@ -25,7 +25,4 @@
 # define TARGET_VIRT_ADDR_SPACE_BITS  (30 + TARGET_PAGE_BITS)
 #endif
 
-/* Alpha processors have a weak memory model */
-#define TCG_GUEST_DEFAULT_MO      (0)
-
 #endif
diff --git a/target/arm/cpu-param.h b/target/arm/cpu-param.h
index 896b35bd6d5..55de4d54544 100644
--- a/target/arm/cpu-param.h
+++ b/target/arm/cpu-param.h
@@ -38,7 +38,4 @@
 # define TARGET_PAGE_BITS_MIN  10
 #endif /* !CONFIG_USER_ONLY */
 
-/* ARM processors have a weak memory model */
-#define TCG_GUEST_DEFAULT_MO      (0)
-
 #endif
diff --git a/target/avr/cpu-param.h b/target/avr/cpu-param.h
index 81f3f49ee1f..11e827109c0 100644
--- a/target/avr/cpu-param.h
+++ b/target/avr/cpu-param.h
@@ -31,6 +31,4 @@
 #define TARGET_PHYS_ADDR_SPACE_BITS 24
 #define TARGET_VIRT_ADDR_SPACE_BITS 24
 
-#define TCG_GUEST_DEFAULT_MO 0
-
 #endif
diff --git a/target/hexagon/cpu-param.h b/target/hexagon/cpu-param.h
index 2d57ea6caf9..45ee7b46409 100644
--- a/target/hexagon/cpu-param.h
+++ b/target/hexagon/cpu-param.h
@@ -23,7 +23,4 @@
 #define TARGET_PHYS_ADDR_SPACE_BITS 36
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 
-/* MTTCG not yet supported: require strict ordering */
-#define TCG_GUEST_DEFAULT_MO        TCG_MO_ALL
-
 #endif
diff --git a/target/hppa/cpu-param.h b/target/hppa/cpu-param.h
index 7ed6b5741e7..e0b2c7c9157 100644
--- a/target/hppa/cpu-param.h
+++ b/target/hppa/cpu-param.h
@@ -19,12 +19,4 @@
 
 #define TARGET_PAGE_BITS 12
 
-/* PA-RISC 1.x processors have a strong memory model.  */
-/*
- * ??? While we do not yet implement PA-RISC 2.0, those processors have
- * a weak memory model, but with TLB bits that force ordering on a per-page
- * basis.  It's probably easier to fall back to a strong memory model.
- */
-#define TCG_GUEST_DEFAULT_MO        TCG_MO_ALL
-
 #endif
diff --git a/target/i386/cpu-param.h b/target/i386/cpu-param.h
index b0e884c5d70..909bc027923 100644
--- a/target/i386/cpu-param.h
+++ b/target/i386/cpu-param.h
@@ -22,7 +22,4 @@
 #endif
 #define TARGET_PAGE_BITS 12
 
-/* The x86 has a strong memory model with some store-after-load re-ordering */
-#define TCG_GUEST_DEFAULT_MO      (TCG_MO_ALL & ~TCG_MO_ST_LD)
-
 #endif
diff --git a/target/loongarch/cpu-param.h b/target/loongarch/cpu-param.h
index 52437946e56..071567712b3 100644
--- a/target/loongarch/cpu-param.h
+++ b/target/loongarch/cpu-param.h
@@ -13,6 +13,4 @@
 
 #define TARGET_PAGE_BITS 12
 
-#define TCG_GUEST_DEFAULT_MO (0)
-
 #endif
diff --git a/target/m68k/cpu-param.h b/target/m68k/cpu-param.h
index 1a909eaa13e..7afbf6d302d 100644
--- a/target/m68k/cpu-param.h
+++ b/target/m68k/cpu-param.h
@@ -17,7 +17,4 @@
 #define TARGET_PHYS_ADDR_SPACE_BITS 32
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 
-/* MTTCG not yet supported: require strict ordering */
-#define TCG_GUEST_DEFAULT_MO        TCG_MO_ALL
-
 #endif
diff --git a/target/microblaze/cpu-param.h b/target/microblaze/cpu-param.h
index c866ec6c149..6a0714bb3d7 100644
--- a/target/microblaze/cpu-param.h
+++ b/target/microblaze/cpu-param.h
@@ -27,7 +27,4 @@
 /* FIXME: MB uses variable pages down to 1K but linux only uses 4k.  */
 #define TARGET_PAGE_BITS 12
 
-/* MicroBlaze is always in-order. */
-#define TCG_GUEST_DEFAULT_MO  TCG_MO_ALL
-
 #endif
diff --git a/target/mips/cpu-param.h b/target/mips/cpu-param.h
index 11b3ac0ac63..35fb6ea7243 100644
--- a/target/mips/cpu-param.h
+++ b/target/mips/cpu-param.h
@@ -25,6 +25,4 @@
 #define TARGET_PAGE_BITS_MIN 12
 #endif
 
-#define TCG_GUEST_DEFAULT_MO (0)
-
 #endif
diff --git a/target/openrisc/cpu-param.h b/target/openrisc/cpu-param.h
index 37627f2c394..3011bf5fcca 100644
--- a/target/openrisc/cpu-param.h
+++ b/target/openrisc/cpu-param.h
@@ -12,6 +12,4 @@
 #define TARGET_PHYS_ADDR_SPACE_BITS 32
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 
-#define TCG_GUEST_DEFAULT_MO (0)
-
 #endif
diff --git a/target/ppc/cpu-param.h b/target/ppc/cpu-param.h
index 6c4525fdf3c..2cee113ddd3 100644
--- a/target/ppc/cpu-param.h
+++ b/target/ppc/cpu-param.h
@@ -38,6 +38,4 @@
 # define TARGET_PAGE_BITS 12
 #endif
 
-#define TCG_GUEST_DEFAULT_MO 0
-
 #endif
diff --git a/target/riscv/cpu-param.h b/target/riscv/cpu-param.h
index fba30e966a8..a80310ef2c5 100644
--- a/target/riscv/cpu-param.h
+++ b/target/riscv/cpu-param.h
@@ -26,6 +26,4 @@
  *  - M mode HLV/HLVX/HSV 0b111
  */
 
-#define TCG_GUEST_DEFAULT_MO 0
-
 #endif
diff --git a/target/rx/cpu-param.h b/target/rx/cpu-param.h
index 2ce199164d7..ef1970a09e9 100644
--- a/target/rx/cpu-param.h
+++ b/target/rx/cpu-param.h
@@ -24,7 +24,4 @@
 #define TARGET_PHYS_ADDR_SPACE_BITS 32
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 
-/* MTTCG not yet supported: require strict ordering */
-#define TCG_GUEST_DEFAULT_MO        TCG_MO_ALL
-
 #endif
diff --git a/target/s390x/cpu-param.h b/target/s390x/cpu-param.h
index 5c331ec424c..a5f798eeae7 100644
--- a/target/s390x/cpu-param.h
+++ b/target/s390x/cpu-param.h
@@ -12,10 +12,4 @@
 #define TARGET_PHYS_ADDR_SPACE_BITS 64
 #define TARGET_VIRT_ADDR_SPACE_BITS 64
 
-/*
- * The z/Architecture has a strong memory model with some
- * store-after-load re-ordering.
- */
-#define TCG_GUEST_DEFAULT_MO      (TCG_MO_ALL & ~TCG_MO_ST_LD)
-
 #endif
diff --git a/target/sh4/cpu-param.h b/target/sh4/cpu-param.h
index 1bc90d4695e..2b6e11dd0ac 100644
--- a/target/sh4/cpu-param.h
+++ b/target/sh4/cpu-param.h
@@ -16,7 +16,4 @@
 # define TARGET_VIRT_ADDR_SPACE_BITS 32
 #endif
 
-/* MTTCG not yet supported: require strict ordering */
-#define TCG_GUEST_DEFAULT_MO        TCG_MO_ALL
-
 #endif
diff --git a/target/sparc/cpu-param.h b/target/sparc/cpu-param.h
index 6952ee2b826..6e8e2a51469 100644
--- a/target/sparc/cpu-param.h
+++ b/target/sparc/cpu-param.h
@@ -21,27 +21,4 @@
 # define TARGET_VIRT_ADDR_SPACE_BITS 32
 #endif
 
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
 #endif
diff --git a/target/tricore/cpu-param.h b/target/tricore/cpu-param.h
index 923459370cc..790242ef3d2 100644
--- a/target/tricore/cpu-param.h
+++ b/target/tricore/cpu-param.h
@@ -12,7 +12,4 @@
 #define TARGET_PHYS_ADDR_SPACE_BITS 32
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 
-/* MTTCG not yet supported: require strict ordering */
-#define TCG_GUEST_DEFAULT_MO        TCG_MO_ALL
-
 #endif
diff --git a/target/xtensa/cpu-param.h b/target/xtensa/cpu-param.h
index 5e4848ad059..06d85218b84 100644
--- a/target/xtensa/cpu-param.h
+++ b/target/xtensa/cpu-param.h
@@ -16,7 +16,4 @@
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 #endif
 
-/* Xtensa processors have a weak memory model */
-#define TCG_GUEST_DEFAULT_MO      (0)
-
 #endif
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index fb9f83dbba3..26442e83776 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -349,7 +349,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     tcg_ctx->tlb_dyn_max_bits = CPU_TLB_DYN_MAX_BITS;
 #endif
     tcg_ctx->insn_start_words = TARGET_INSN_START_WORDS;
-    tcg_ctx->guest_mo = TCG_GUEST_DEFAULT_MO;
+    tcg_ctx->guest_mo = cpu->cc->tcg_ops->guest_default_memory_order;
 
  restart_translate:
     trace_translate_block(tb, pc, tb->tc.ptr);
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index 584c2aa76bd..e5e14976f51 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -239,6 +239,9 @@ static const TCGCPUOps alpha_tcg_ops = {
     .synchronize_from_tb = alpha_cpu_synchronize_from_tb,
     .restore_state_to_opc = alpha_restore_state_to_opc,
 
+    /* Alpha processors have a weak memory model */
+    .guest_default_memory_order = 0,
+
 #ifdef CONFIG_USER_ONLY
     .record_sigsegv = alpha_cpu_record_sigsegv,
     .record_sigbus = alpha_cpu_record_sigbus,
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 01786ac7879..8b9f2acf82b 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2675,6 +2675,9 @@ static const TCGCPUOps arm_tcg_ops = {
     .debug_excp_handler = arm_debug_excp_handler,
     .restore_state_to_opc = arm_restore_state_to_opc,
 
+    /* ARM processors have a weak memory model */
+    .guest_default_memory_order = 0,
+
 #ifdef CONFIG_USER_ONLY
     .record_sigsegv = arm_cpu_record_sigsegv,
     .record_sigbus = arm_cpu_record_sigbus,
diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c
index c4dd3092726..df6b7198944 100644
--- a/target/arm/tcg/cpu-v7m.c
+++ b/target/arm/tcg/cpu-v7m.c
@@ -238,6 +238,9 @@ static const TCGCPUOps arm_v7m_tcg_ops = {
     .debug_excp_handler = arm_debug_excp_handler,
     .restore_state_to_opc = arm_restore_state_to_opc,
 
+    /* ARM processors have a weak memory model */
+    .guest_default_memory_order = 0,
+
 #ifdef CONFIG_USER_ONLY
     .record_sigsegv = arm_cpu_record_sigsegv,
     .record_sigbus = arm_cpu_record_sigbus,
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index 834c7082aa7..24e52e28f44 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -216,6 +216,7 @@ static const TCGCPUOps avr_tcg_ops = {
     .cpu_exec_halt = avr_cpu_has_work,
     .tlb_fill = avr_cpu_tlb_fill,
     .do_interrupt = avr_cpu_do_interrupt,
+    .guest_default_memory_order = 0,
 };
 
 static void avr_cpu_class_init(ObjectClass *oc, void *data)
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 766b6786511..34734b0edb0 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -324,6 +324,8 @@ static const TCGCPUOps hexagon_tcg_ops = {
     .translate_code = hexagon_translate_code,
     .synchronize_from_tb = hexagon_cpu_synchronize_from_tb,
     .restore_state_to_opc = hexagon_restore_state_to_opc,
+    /* MTTCG not yet supported: require strict ordering */
+    .guest_default_memory_order = TCG_MO_ALL,
 };
 
 static void hexagon_cpu_class_init(ObjectClass *c, void *data)
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 2a85495d02f..997bd69db19 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -257,6 +257,14 @@ static const TCGCPUOps hppa_tcg_ops = {
     .synchronize_from_tb = hppa_cpu_synchronize_from_tb,
     .restore_state_to_opc = hppa_restore_state_to_opc,
 
+    /* PA-RISC 1.x processors have a strong memory model.  */
+    /*
+     * ??? While we do not yet implement PA-RISC 2.0, those processors have
+     * a weak memory model, but with TLB bits that force ordering on a per-page
+     * basis.  It's probably easier to fall back to a strong memory model.
+     */
+    .guest_default_memory_order = TCG_MO_ALL,
+
 #ifndef CONFIG_USER_ONLY
     .tlb_fill_align = hppa_cpu_tlb_fill_align,
     .cpu_exec_interrupt = hppa_cpu_exec_interrupt,
diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
index b8aff825eec..4a76c475971 100644
--- a/target/i386/tcg/tcg-cpu.c
+++ b/target/i386/tcg/tcg-cpu.c
@@ -128,6 +128,11 @@ static const TCGCPUOps x86_tcg_ops = {
     .debug_check_breakpoint = x86_debug_check_breakpoint,
     .need_replay_interrupt = x86_need_replay_interrupt,
 #endif /* !CONFIG_USER_ONLY */
+
+    /*
+     * The x86 has a strong memory model with some store-after-load re-ordering
+     */
+    .guest_default_memory_order = TCG_MO_ALL & ~TCG_MO_ST_LD,
 };
 
 static void x86_tcg_cpu_init_ops(AccelCPUClass *accel_cpu, CPUClass *cc)
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index ea1665e2705..c39ff056157 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -869,6 +869,8 @@ static const TCGCPUOps loongarch_tcg_ops = {
     .synchronize_from_tb = loongarch_cpu_synchronize_from_tb,
     .restore_state_to_opc = loongarch_restore_state_to_opc,
 
+    .guest_default_memory_order = 0,
+
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = loongarch_cpu_tlb_fill,
     .cpu_exec_interrupt = loongarch_cpu_exec_interrupt,
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 0065e1c1ca5..e96b379e266 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -593,6 +593,9 @@ static const TCGCPUOps m68k_tcg_ops = {
     .translate_code = m68k_translate_code,
     .restore_state_to_opc = m68k_restore_state_to_opc,
 
+    /* MTTCG not yet supported: require strict ordering */
+    .guest_default_memory_order = TCG_MO_ALL,
+
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = m68k_cpu_tlb_fill,
     .cpu_exec_interrupt = m68k_cpu_exec_interrupt,
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index f3bebea856e..4b9ef6e52c4 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -432,6 +432,9 @@ static const TCGCPUOps mb_tcg_ops = {
     .synchronize_from_tb = mb_cpu_synchronize_from_tb,
     .restore_state_to_opc = mb_restore_state_to_opc,
 
+    /* MicroBlaze is always in-order. */
+    .guest_default_memory_order = TCG_MO_ALL,
+
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = mb_cpu_tlb_fill,
     .cpu_exec_interrupt = mb_cpu_exec_interrupt,
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index b207106dd79..5ddc9bbb829 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -554,6 +554,8 @@ static const TCGCPUOps mips_tcg_ops = {
     .synchronize_from_tb = mips_cpu_synchronize_from_tb,
     .restore_state_to_opc = mips_restore_state_to_opc,
 
+    .guest_default_memory_order = 0,
+
 #if !defined(CONFIG_USER_ONLY)
     .tlb_fill = mips_cpu_tlb_fill,
     .cpu_exec_interrupt = mips_cpu_exec_interrupt,
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index e8abf1f8b5c..6a878aaadd8 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -248,6 +248,8 @@ static const TCGCPUOps openrisc_tcg_ops = {
     .synchronize_from_tb = openrisc_cpu_synchronize_from_tb,
     .restore_state_to_opc = openrisc_restore_state_to_opc,
 
+    .guest_default_memory_order = 0,
+
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = openrisc_cpu_tlb_fill,
     .cpu_exec_interrupt = openrisc_cpu_exec_interrupt,
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 8b590e7f17c..28fbbb8d3c1 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7490,6 +7490,8 @@ static const TCGCPUOps ppc_tcg_ops = {
   .translate_code = ppc_translate_code,
   .restore_state_to_opc = ppc_restore_state_to_opc,
 
+  .guest_default_memory_order = 0,
+
 #ifdef CONFIG_USER_ONLY
   .record_sigsegv = ppc_cpu_record_sigsegv,
 #else
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 5aef9eef366..fb903992faa 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -139,6 +139,8 @@ static const TCGCPUOps riscv_tcg_ops = {
     .synchronize_from_tb = riscv_cpu_synchronize_from_tb,
     .restore_state_to_opc = riscv_restore_state_to_opc,
 
+    .guest_default_memory_order = 0,
+
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = riscv_cpu_tlb_fill,
     .cpu_exec_interrupt = riscv_cpu_exec_interrupt,
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index 0ba0d55ab5b..6a24e7e9136 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -212,6 +212,9 @@ static const TCGCPUOps rx_tcg_ops = {
     .cpu_exec_interrupt = rx_cpu_exec_interrupt,
     .cpu_exec_halt = rx_cpu_has_work,
     .do_interrupt = rx_cpu_do_interrupt,
+
+    /* MTTCG not yet supported: require strict ordering */
+    .guest_default_memory_order = TCG_MO_ALL,
 };
 
 static void rx_cpu_class_init(ObjectClass *klass, void *data)
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index d73142600bf..12fd853c00a 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -360,6 +360,12 @@ static const TCGCPUOps s390_tcg_ops = {
     .debug_excp_handler = s390x_cpu_debug_excp_handler,
     .do_unaligned_access = s390x_cpu_do_unaligned_access,
 #endif /* !CONFIG_USER_ONLY */
+
+    /*
+     * The z/Architecture has a strong memory model with some
+     * store-after-load re-ordering.
+     */
+    .guest_default_memory_order = TCG_MO_ALL & ~TCG_MO_ST_LD,
 };
 #endif /* CONFIG_TCG */
 
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index ce84bdf539a..ce9ed75107a 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -267,6 +267,9 @@ static const TCGCPUOps superh_tcg_ops = {
     .synchronize_from_tb = superh_cpu_synchronize_from_tb,
     .restore_state_to_opc = superh_restore_state_to_opc,
 
+    /* MTTCG not yet supported: require strict ordering */
+    .guest_default_memory_order = TCG_MO_ALL,
+
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = superh_cpu_tlb_fill,
     .cpu_exec_interrupt = superh_cpu_exec_interrupt,
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 57161201173..39bd0c42855 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -1005,6 +1005,29 @@ static const TCGCPUOps sparc_tcg_ops = {
     .synchronize_from_tb = sparc_cpu_synchronize_from_tb,
     .restore_state_to_opc = sparc_restore_state_to_opc,
 
+    /*
+     * From Oracle SPARC Architecture 2015:
+     *
+     *   Compatibility notes: The PSO memory model described in SPARC V8 and
+     *   SPARC V9 compatibility architecture specifications was never
+     *   implemented in a SPARC V9 implementation and is not included in the
+     *   Oracle SPARC Architecture specification.
+     *
+     *   The RMO memory model described in the SPARC V9 specification was
+     *   implemented in some non-Sun SPARC V9 implementations, but is not
+     *   directly supported in Oracle SPARC Architecture 2015 implementations.
+     *
+     * Therefore always use TSO in QEMU.
+     *
+     * D.5 Specification of Partial Store Order (PSO)
+     *   ... [loads] are followed by an implied MEMBAR #LoadLoad | #LoadStore.
+     *
+     * D.6 Specification of Total Store Order (TSO)
+     *   ... PSO with the additional requirement that all [stores] are followed
+     *   by an implied MEMBAR #StoreStore.
+     */
+    .guest_default_memory_order = TCG_MO_LD_LD | TCG_MO_LD_ST | TCG_MO_ST_ST,
+
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = sparc_cpu_tlb_fill,
     .cpu_exec_interrupt = sparc_cpu_exec_interrupt,
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index 16acc4ecb92..e0a48065948 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -179,6 +179,8 @@ static const TCGCPUOps tricore_tcg_ops = {
     .tlb_fill = tricore_cpu_tlb_fill,
     .cpu_exec_interrupt = tricore_cpu_exec_interrupt,
     .cpu_exec_halt = tricore_cpu_has_work,
+    /* MTTCG not yet supported: require strict ordering */
+    .guest_default_memory_order = TCG_MO_ALL,
 };
 
 static void tricore_cpu_class_init(ObjectClass *c, void *data)
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 7663b62d01e..dd9061ba469 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -237,6 +237,9 @@ static const TCGCPUOps xtensa_tcg_ops = {
     .debug_excp_handler = xtensa_breakpoint_handler,
     .restore_state_to_opc = xtensa_restore_state_to_opc,
 
+    /* Xtensa processors have a weak memory model */
+    .guest_default_memory_order = 0,
+
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = xtensa_cpu_tlb_fill,
     .cpu_exec_interrupt = xtensa_cpu_exec_interrupt,
-- 
2.47.1


