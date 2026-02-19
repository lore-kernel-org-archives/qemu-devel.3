Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49C5EE9A048
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 10:36:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt1O5-0000kz-9Y; Thu, 19 Feb 2026 05:36:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt1Ml-0007NC-SL
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:34:39 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt1Mi-0006A3-V7
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:34:39 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-480706554beso8865765e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 02:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771497275; x=1772102075; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DcpZ76ZwhBhm9PG+qYecXvTyPzyIf3xHlLWtAkqeRJc=;
 b=Om2ADzFFfyW6YYDXu8M4rMooRRKCu0Fflr76dSrv3OVZC2kco0F/Z7yYhFVCv0zzL/
 di4X/V8s83lTuBuKXRt6Kl6dLW7G03K21mcM4C2Gw0mgjmMWdyZVLenO00oiQ7lhGKmj
 Mqzinm+KQQoqfAdcch6FLQVm9s05jxrKT2PwhvIpAYUlVqqUp3DLqe8aP0ZHJ1HAr9Pt
 KkDwHHm8mLzH605nbCVcsNBjpvkM9pnK6yWvhyXELKgdesSmZDTq8SWuRcNUOkc9T98G
 wJHkAtZb+Ue2JIkq3YlPXVKuC5l5Yx/7MuN59qKwD1vM2TyQ/pciEKrbMSX6SakviT6x
 9S0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771497275; x=1772102075;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DcpZ76ZwhBhm9PG+qYecXvTyPzyIf3xHlLWtAkqeRJc=;
 b=LPYjP8C1IKxMAerO+oDkI5RXaXWhENpQAJeW4PKXFjkDnS0NEOUk9VqmLDLNZtN6db
 gmE90QJWfAs5+SmdiB3uNve1dcw1VSp5K0reljruSYKUtg1Is4YzsOp+Kh4612RK5d36
 og4yLd3dF6sLeyAb2AJuUTxoHpqQdPkF/STIKnnOoFA+ELX3pE1aCtD4YeDJuaQyVLU4
 UqNWYNjiO8uYlUzoUvIdHz+Gt7sNmL2JPZaClRk2sqoYb4P0ECwbVz02KmoXj29z/qkr
 JfAI9RpA82P8GTQmDoQUY2mY1gA5jQbTBLxp1D2RvVFuE5KcWapjBKpHGyui01XA9ivi
 N7zQ==
X-Gm-Message-State: AOJu0YyUpohvaS0ANTGm5ehO4P58A8WBzont/inqAx1w5Df5GvadaA+1
 CIVou09McEw2Nfod99SRbbIjY9R92NEn51KWKutHuEopvuR+yo78NRYKqTiBlyRktceXkfN3XwG
 MCq1E
X-Gm-Gg: AZuq6aJNW8KMnd7qUmnZcxSx0k6hqGp/84AsXVvipmnUM1ZitiLM5wuhuv+Ly6e2TBS
 dAPYsxR3iDlmlp5kz1Pr6z0ZCk1TlqFTl4BZ9GfCw2yB1KtA0clOTnqTZlsw1dCMOIIaHfPFIjN
 o46gm87a0d3/Aq4Wuo/5euKvz9w5SttQ0n1A6+dcaPnEqEW/N5uDdwP+qJv0uJvaE648UU6zGKp
 Cl8PvreLkPQU039F0D2EsLQ01UXdAIUwXwK1JP1Q8kpvQPnLlOS22kC96KZIt4A+MzXEzjqE9Dg
 BqeTmGiltN0/aVg7i5G9vbtqegxFlUEmQpzKTpLkur+RMhlOH2rVw2HyfYN45UjEiqWAMwfPSAM
 cml359BA0dTVv/WoaZKwXLx7uB0cx2ex2MvhLF3p3RNyhhTDIcVyhOuBR9VnD19M/GI+8+fIYoP
 l9n1uA7iCQNs8ncTyn7HS7rrk5ShpoYvvgUUk7S7cHa+xcrinbuKYf7Z5yVjbB1HkkgX2DnA5XU
 K8fBzQmXftZlx5XPwDwBQaukjhRtWE=
X-Received: by 2002:a05:600c:470b:b0:46e:4b79:551 with SMTP id
 5b1f17b1804b1-48379c01465mr330890515e9.31.1771497275240; 
 Thu, 19 Feb 2026 02:34:35 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5ebd34sm697630795e9.7.2026.02.19.02.34.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 02:34:34 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 32/32] include/tcg/tcg-op.h: eradicate
 TARGET_INSN_START_EXTRA_WORDS
Date: Thu, 19 Feb 2026 10:34:05 +0000
Message-ID: <20260219103405.3793357-33-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219103405.3793357-1-peter.maydell@linaro.org>
References: <20260219103405.3793357-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

This commit removes TARGET_INSN_START_EXTRA_WORDS and force all arch to
call the same version of tcg_gen_insn_start, with additional 0 arguments
if needed. Since all arch have a single call site (in translate.c), this
is as good documentation as having a single define.

The notable exception is target/arm, which has two different translate
files for 32/64 bits. Since it's the only one, we accept to have two
call sites for this.

As well, we update parameter type to use uint64_t instead of
target_ulong, so it can be called from common code.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20260219040150.2098396-15-pierrick.bouvier@linaro.org
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/tcg/tcg-op-common.h      |  8 ++++++++
 include/tcg/tcg-op.h             | 29 -----------------------------
 target/alpha/cpu-param.h         |  2 --
 target/alpha/translate.c         |  4 ++--
 target/arm/cpu-param.h           |  7 -------
 target/avr/cpu-param.h           |  2 --
 target/avr/translate.c           |  2 +-
 target/hexagon/cpu-param.h       |  2 --
 target/hexagon/translate.c       |  2 +-
 target/hppa/cpu-param.h          |  2 --
 target/i386/cpu-param.h          |  2 --
 target/i386/tcg/translate.c      |  2 +-
 target/loongarch/cpu-param.h     |  2 --
 target/loongarch/tcg/translate.c |  2 +-
 target/m68k/cpu-param.h          |  2 --
 target/m68k/translate.c          |  2 +-
 target/microblaze/cpu-param.h    |  2 --
 target/microblaze/translate.c    |  2 +-
 target/mips/cpu-param.h          |  2 --
 target/or1k/cpu-param.h          |  2 --
 target/or1k/translate.c          |  2 +-
 target/ppc/cpu-param.h           |  2 --
 target/ppc/translate.c           |  2 +-
 target/riscv/cpu-param.h         |  7 -------
 target/rx/cpu-param.h            |  2 --
 target/rx/translate.c            |  2 +-
 target/s390x/cpu-param.h         |  2 --
 target/sh4/cpu-param.h           |  2 --
 target/sh4/translate.c           |  4 ++--
 target/sparc/cpu-param.h         |  2 --
 target/sparc/translate.c         |  2 +-
 target/tricore/cpu-param.h       |  2 --
 target/tricore/translate.c       |  2 +-
 target/xtensa/cpu-param.h        |  2 --
 target/xtensa/translate.c        |  2 +-
 35 files changed, 24 insertions(+), 93 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index f752ef440b..e02f209c09 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -30,6 +30,14 @@ TCGv_i64 tcg_global_mem_new_i64(TCGv_ptr reg, intptr_t off, const char *name);
 TCGv_ptr tcg_global_mem_new_ptr(TCGv_ptr reg, intptr_t off, const char *name);
 
 /* Generic ops.  */
+static inline void tcg_gen_insn_start(uint64_t pc, uint64_t a1,
+                                      uint64_t a2)
+{
+    TCGOp *op = tcg_emit_op(INDEX_op_insn_start, INSN_START_WORDS);
+    tcg_set_insn_start_param(op, 0, pc);
+    tcg_set_insn_start_param(op, 1, a1);
+    tcg_set_insn_start_param(op, 2, a2);
+}
 
 void gen_set_label(TCGLabel *l);
 void tcg_gen_br(TCGLabel *l);
diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
index ee379994e7..7024be938e 100644
--- a/include/tcg/tcg-op.h
+++ b/include/tcg/tcg-op.h
@@ -28,35 +28,6 @@
 # error Mismatch with insn-start-words.h
 #endif
 
-#if TARGET_INSN_START_EXTRA_WORDS == 0
-static inline void tcg_gen_insn_start(target_ulong pc)
-{
-    TCGOp *op = tcg_emit_op(INDEX_op_insn_start, INSN_START_WORDS);
-    tcg_set_insn_start_param(op, 0, pc);
-    tcg_set_insn_start_param(op, 1, 0);
-    tcg_set_insn_start_param(op, 2, 0);
-}
-#elif TARGET_INSN_START_EXTRA_WORDS == 1
-static inline void tcg_gen_insn_start(target_ulong pc, target_ulong a1)
-{
-    TCGOp *op = tcg_emit_op(INDEX_op_insn_start, INSN_START_WORDS);
-    tcg_set_insn_start_param(op, 0, pc);
-    tcg_set_insn_start_param(op, 1, a1);
-    tcg_set_insn_start_param(op, 2, 0);
-}
-#elif TARGET_INSN_START_EXTRA_WORDS == 2
-static inline void tcg_gen_insn_start(target_ulong pc, target_ulong a1,
-                                      target_ulong a2)
-{
-    TCGOp *op = tcg_emit_op(INDEX_op_insn_start, INSN_START_WORDS);
-    tcg_set_insn_start_param(op, 0, pc);
-    tcg_set_insn_start_param(op, 1, a1);
-    tcg_set_insn_start_param(op, 2, a2);
-}
-#else
-#error Unhandled TARGET_INSN_START_EXTRA_WORDS value
-#endif
-
 #if TARGET_LONG_BITS == 32
 typedef TCGv_i32 TCGv;
 #define tcg_temp_new() tcg_temp_new_i32()
diff --git a/target/alpha/cpu-param.h b/target/alpha/cpu-param.h
index a799f42db3..c9da620ab3 100644
--- a/target/alpha/cpu-param.h
+++ b/target/alpha/cpu-param.h
@@ -24,6 +24,4 @@
 # define TARGET_VIRT_ADDR_SPACE_BITS  (30 + TARGET_PAGE_BITS)
 #endif
 
-#define TARGET_INSN_START_EXTRA_WORDS 0
-
 #endif
diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 4442462891..4d22d7d5a4 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -2899,9 +2899,9 @@ static void alpha_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
 
     if (ctx->pcrel) {
-        tcg_gen_insn_start(dcbase->pc_next & ~TARGET_PAGE_MASK);
+        tcg_gen_insn_start(dcbase->pc_next & ~TARGET_PAGE_MASK, 0, 0);
     } else {
-        tcg_gen_insn_start(dcbase->pc_next);
+        tcg_gen_insn_start(dcbase->pc_next, 0, 0);
     }
 }
 
diff --git a/target/arm/cpu-param.h b/target/arm/cpu-param.h
index 8b46c7c570..7de0099cbf 100644
--- a/target/arm/cpu-param.h
+++ b/target/arm/cpu-param.h
@@ -32,11 +32,4 @@
 # define TARGET_PAGE_BITS_LEGACY 10
 #endif /* !CONFIG_USER_ONLY */
 
-/*
- * ARM-specific extra insn start words:
- * 1: Conditional execution bits
- * 2: Partial exception syndrome for data aborts
- */
-#define TARGET_INSN_START_EXTRA_WORDS 2
-
 #endif
diff --git a/target/avr/cpu-param.h b/target/avr/cpu-param.h
index f74bfc2580..ea7887919a 100644
--- a/target/avr/cpu-param.h
+++ b/target/avr/cpu-param.h
@@ -25,6 +25,4 @@
 #define TARGET_PHYS_ADDR_SPACE_BITS 24
 #define TARGET_VIRT_ADDR_SPACE_BITS 24
 
-#define TARGET_INSN_START_EXTRA_WORDS 0
-
 #endif
diff --git a/target/avr/translate.c b/target/avr/translate.c
index 78ae83df21..649dd4b011 100644
--- a/target/avr/translate.c
+++ b/target/avr/translate.c
@@ -2689,7 +2689,7 @@ static void avr_tr_insn_start(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
 
-    tcg_gen_insn_start(ctx->npc);
+    tcg_gen_insn_start(ctx->npc, 0, 0);
 }
 
 static void avr_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
diff --git a/target/hexagon/cpu-param.h b/target/hexagon/cpu-param.h
index 635d509e74..45ee7b4640 100644
--- a/target/hexagon/cpu-param.h
+++ b/target/hexagon/cpu-param.h
@@ -23,6 +23,4 @@
 #define TARGET_PHYS_ADDR_SPACE_BITS 36
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 
-#define TARGET_INSN_START_EXTRA_WORDS 0
-
 #endif
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 2fdc956bf9..8a223f6e13 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -998,7 +998,7 @@ static void hexagon_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
 
-    tcg_gen_insn_start(ctx->base.pc_next);
+    tcg_gen_insn_start(ctx->base.pc_next, 0, 0);
 }
 
 static bool pkt_crosses_page(CPUHexagonState *env, DisasContext *ctx)
diff --git a/target/hppa/cpu-param.h b/target/hppa/cpu-param.h
index 9bf7ac76d0..e0b2c7c915 100644
--- a/target/hppa/cpu-param.h
+++ b/target/hppa/cpu-param.h
@@ -19,6 +19,4 @@
 
 #define TARGET_PAGE_BITS 12
 
-#define TARGET_INSN_START_EXTRA_WORDS 2
-
 #endif
diff --git a/target/i386/cpu-param.h b/target/i386/cpu-param.h
index ebb844bcc8..909bc02792 100644
--- a/target/i386/cpu-param.h
+++ b/target/i386/cpu-param.h
@@ -22,6 +22,4 @@
 #endif
 #define TARGET_PAGE_BITS 12
 
-#define TARGET_INSN_START_EXTRA_WORDS 1
-
 #endif
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 7186517239..14210d569f 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -3501,7 +3501,7 @@ static void i386_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
     if (tb_cflags(dcbase->tb) & CF_PCREL) {
         pc_arg &= ~TARGET_PAGE_MASK;
     }
-    tcg_gen_insn_start(pc_arg, dc->cc_op);
+    tcg_gen_insn_start(pc_arg, dc->cc_op, 0);
 }
 
 static void i386_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
diff --git a/target/loongarch/cpu-param.h b/target/loongarch/cpu-param.h
index 58cc45a377..071567712b 100644
--- a/target/loongarch/cpu-param.h
+++ b/target/loongarch/cpu-param.h
@@ -13,6 +13,4 @@
 
 #define TARGET_PAGE_BITS 12
 
-#define TARGET_INSN_START_EXTRA_WORDS 0
-
 #endif
diff --git a/target/loongarch/tcg/translate.c b/target/loongarch/tcg/translate.c
index 30f375b33f..b9ed13d19c 100644
--- a/target/loongarch/tcg/translate.c
+++ b/target/loongarch/tcg/translate.c
@@ -159,7 +159,7 @@ static void loongarch_tr_insn_start(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
 
-    tcg_gen_insn_start(ctx->base.pc_next);
+    tcg_gen_insn_start(ctx->base.pc_next, 0, 0);
 }
 
 /*
diff --git a/target/m68k/cpu-param.h b/target/m68k/cpu-param.h
index 256a2b5f8b..7afbf6d302 100644
--- a/target/m68k/cpu-param.h
+++ b/target/m68k/cpu-param.h
@@ -17,6 +17,4 @@
 #define TARGET_PHYS_ADDR_SPACE_BITS 32
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 
-#define TARGET_INSN_START_EXTRA_WORDS 1
-
 #endif
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index a030993901..abc1c79f3c 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -6041,7 +6041,7 @@ static void m68k_tr_tb_start(DisasContextBase *dcbase, CPUState *cpu)
 static void m68k_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
-    tcg_gen_insn_start(dc->base.pc_next, dc->cc_op);
+    tcg_gen_insn_start(dc->base.pc_next, dc->cc_op, 0);
 }
 
 static void m68k_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
diff --git a/target/microblaze/cpu-param.h b/target/microblaze/cpu-param.h
index e0a3794513..6a0714bb3d 100644
--- a/target/microblaze/cpu-param.h
+++ b/target/microblaze/cpu-param.h
@@ -27,6 +27,4 @@
 /* FIXME: MB uses variable pages down to 1K but linux only uses 4k.  */
 #define TARGET_PAGE_BITS 12
 
-#define TARGET_INSN_START_EXTRA_WORDS 1
-
 #endif
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 0be3c98dc1..2af67beece 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1630,7 +1630,7 @@ static void mb_tr_insn_start(DisasContextBase *dcb, CPUState *cs)
 {
     DisasContext *dc = container_of(dcb, DisasContext, base);
 
-    tcg_gen_insn_start(dc->base.pc_next, dc->tb_flags & ~MSR_TB_MASK);
+    tcg_gen_insn_start(dc->base.pc_next, dc->tb_flags & ~MSR_TB_MASK, 0);
 }
 
 static void mb_tr_translate_insn(DisasContextBase *dcb, CPUState *cs)
diff --git a/target/mips/cpu-param.h b/target/mips/cpu-param.h
index 58f450827f..a71e7383d2 100644
--- a/target/mips/cpu-param.h
+++ b/target/mips/cpu-param.h
@@ -20,6 +20,4 @@
 #endif
 #define TARGET_PAGE_BITS 12
 
-#define TARGET_INSN_START_EXTRA_WORDS 2
-
 #endif
diff --git a/target/or1k/cpu-param.h b/target/or1k/cpu-param.h
index b4f57bbe69..3011bf5fcc 100644
--- a/target/or1k/cpu-param.h
+++ b/target/or1k/cpu-param.h
@@ -12,6 +12,4 @@
 #define TARGET_PHYS_ADDR_SPACE_BITS 32
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 
-#define TARGET_INSN_START_EXTRA_WORDS 1
-
 #endif
diff --git a/target/or1k/translate.c b/target/or1k/translate.c
index ce2dc466dc..de81dc6ef8 100644
--- a/target/or1k/translate.c
+++ b/target/or1k/translate.c
@@ -1552,7 +1552,7 @@ static void openrisc_tr_insn_start(DisasContextBase *dcbase, CPUState *cs)
     DisasContext *dc = container_of(dcbase, DisasContext, base);
 
     tcg_gen_insn_start(dc->base.pc_next, (dc->delayed_branch ? 1 : 0)
-                       | (dc->base.num_insns > 1 ? 2 : 0));
+                       | (dc->base.num_insns > 1 ? 2 : 0), 0);
 }
 
 static void openrisc_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
diff --git a/target/ppc/cpu-param.h b/target/ppc/cpu-param.h
index e4ed9080ee..ca7602d898 100644
--- a/target/ppc/cpu-param.h
+++ b/target/ppc/cpu-param.h
@@ -37,6 +37,4 @@
 # define TARGET_PAGE_BITS 12
 #endif
 
-#define TARGET_INSN_START_EXTRA_WORDS 0
-
 #endif
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index e9acfa239e..a09a6df93f 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -6575,7 +6575,7 @@ static void ppc_tr_tb_start(DisasContextBase *db, CPUState *cs)
 
 static void ppc_tr_insn_start(DisasContextBase *dcbase, CPUState *cs)
 {
-    tcg_gen_insn_start(dcbase->pc_next);
+    tcg_gen_insn_start(dcbase->pc_next, 0, 0);
 }
 
 static bool is_prefix_insn(DisasContext *ctx, uint32_t insn)
diff --git a/target/riscv/cpu-param.h b/target/riscv/cpu-param.h
index cfdc67c258..039e877891 100644
--- a/target/riscv/cpu-param.h
+++ b/target/riscv/cpu-param.h
@@ -17,13 +17,6 @@
 #endif
 #define TARGET_PAGE_BITS 12 /* 4 KiB Pages */
 
-/*
- * RISC-V-specific extra insn start words:
- * 1: Original instruction opcode
- * 2: more information about instruction
- */
-#define TARGET_INSN_START_EXTRA_WORDS 2
-
 /*
  * The current MMU Modes are:
  *  - U mode 0b000
diff --git a/target/rx/cpu-param.h b/target/rx/cpu-param.h
index 84934f3bca..ef1970a09e 100644
--- a/target/rx/cpu-param.h
+++ b/target/rx/cpu-param.h
@@ -24,6 +24,4 @@
 #define TARGET_PHYS_ADDR_SPACE_BITS 32
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 
-#define TARGET_INSN_START_EXTRA_WORDS 0
-
 #endif
diff --git a/target/rx/translate.c b/target/rx/translate.c
index 26d4154829..a245b9db8f 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -2217,7 +2217,7 @@ static void rx_tr_insn_start(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
 
-    tcg_gen_insn_start(ctx->base.pc_next);
+    tcg_gen_insn_start(ctx->base.pc_next, 0, 0);
 }
 
 static void rx_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
diff --git a/target/s390x/cpu-param.h b/target/s390x/cpu-param.h
index abfae3bedf..a5f798eeae 100644
--- a/target/s390x/cpu-param.h
+++ b/target/s390x/cpu-param.h
@@ -12,6 +12,4 @@
 #define TARGET_PHYS_ADDR_SPACE_BITS 64
 #define TARGET_VIRT_ADDR_SPACE_BITS 64
 
-#define TARGET_INSN_START_EXTRA_WORDS 2
-
 #endif
diff --git a/target/sh4/cpu-param.h b/target/sh4/cpu-param.h
index f328715ee8..2b6e11dd0a 100644
--- a/target/sh4/cpu-param.h
+++ b/target/sh4/cpu-param.h
@@ -16,6 +16,4 @@
 # define TARGET_VIRT_ADDR_SPACE_BITS 32
 #endif
 
-#define TARGET_INSN_START_EXTRA_WORDS 1
-
 #endif
diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index b3ae0a3814..b1057727c5 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -2181,7 +2181,7 @@ static void decode_gusa(DisasContext *ctx, CPUSH4State *env)
      * tb->icount * insn_start.
      */
     for (i = 1; i < max_insns; ++i) {
-        tcg_gen_insn_start(pc + i * 2, ctx->envflags);
+        tcg_gen_insn_start(pc + i * 2, ctx->envflags, 0);
         ctx->base.insn_start = tcg_last_op();
     }
 }
@@ -2241,7 +2241,7 @@ static void sh4_tr_insn_start(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
 
-    tcg_gen_insn_start(ctx->base.pc_next, ctx->envflags);
+    tcg_gen_insn_start(ctx->base.pc_next, ctx->envflags, 0);
 }
 
 static void sh4_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
diff --git a/target/sparc/cpu-param.h b/target/sparc/cpu-param.h
index 45eea9d6ba..6e8e2a5146 100644
--- a/target/sparc/cpu-param.h
+++ b/target/sparc/cpu-param.h
@@ -21,6 +21,4 @@
 # define TARGET_VIRT_ADDR_SPACE_BITS 32
 #endif
 
-#define TARGET_INSN_START_EXTRA_WORDS 1
-
 #endif
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 57b50ff8b9..7e8558dbbd 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -5735,7 +5735,7 @@ static void sparc_tr_insn_start(DisasContextBase *dcbase, CPUState *cs)
             g_assert_not_reached();
         }
     }
-    tcg_gen_insn_start(dc->pc, npc);
+    tcg_gen_insn_start(dc->pc, npc, 0);
 }
 
 static void sparc_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
diff --git a/target/tricore/cpu-param.h b/target/tricore/cpu-param.h
index eb33a67c41..790242ef3d 100644
--- a/target/tricore/cpu-param.h
+++ b/target/tricore/cpu-param.h
@@ -12,6 +12,4 @@
 #define TARGET_PHYS_ADDR_SPACE_BITS 32
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 
-#define TARGET_INSN_START_EXTRA_WORDS 0
-
 #endif
diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 18d8726af6..0eaf7a82f8 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -8410,7 +8410,7 @@ static void tricore_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
 
-    tcg_gen_insn_start(ctx->base.pc_next);
+    tcg_gen_insn_start(ctx->base.pc_next, 0, 0);
 }
 
 static bool insn_crosses_page(DisasContext *ctx, CPUTriCoreState *env)
diff --git a/target/xtensa/cpu-param.h b/target/xtensa/cpu-param.h
index 7a0c22c900..06d85218b8 100644
--- a/target/xtensa/cpu-param.h
+++ b/target/xtensa/cpu-param.h
@@ -16,6 +16,4 @@
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
 #endif
 
-#define TARGET_INSN_START_EXTRA_WORDS 0
-
 #endif
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index bb8d2ed86c..5e3707d3fd 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -1159,7 +1159,7 @@ static void xtensa_tr_tb_start(DisasContextBase *dcbase, CPUState *cpu)
 
 static void xtensa_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
 {
-    tcg_gen_insn_start(dcbase->pc_next);
+    tcg_gen_insn_start(dcbase->pc_next, 0, 0);
 }
 
 static void xtensa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
-- 
2.43.0


