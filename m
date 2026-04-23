Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2CF2F99368
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:04:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFquF-0006VY-8T; Thu, 23 Apr 2026 06:03:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqtg-0006Rm-Iz
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:03:00 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqte-000263-65
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:03:00 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-43d77f6092eso4439214f8f.2
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776938577; x=1777543377; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=76o6p9xqzOjDMBJseAhtqwlZMgfgjTWM2ndIhW33wcY=;
 b=nVfe3s1aGD1fWsT8wrrzlUsRMIg85pZgJrulScTlKPMcU+gCOCXIIlDBiJrO7dRjzU
 4mvT0CO3f8m5gH0zy1s7/ZDhMUhO/sdWMadAFtf+Q71fUFEiQMUYNGcDVp6fX3FWvAW5
 1D3vUI2h6c0Pt1Ke7C4aKcofJLyYJ5ClUZVQXyuOpShNaKVkWfNGI+3RxIM/4tAILQQF
 cIOyYwzjThDkJLAodFxUDDkNvJnXbJlNtTakW1OH4ck02he9ooIduldORrJghenUx9HX
 6x+p2tZp6hRRnJE6Ky6QLWW5/2FNEPLiiVUdVGoe5LrtFz4uCAcN0bxKYdB1Oz0S7L5u
 0+GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776938577; x=1777543377;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=76o6p9xqzOjDMBJseAhtqwlZMgfgjTWM2ndIhW33wcY=;
 b=ld0I0sQA5g+ITdz747J0i9Hk2Vb6974mm7K0zLWZm+4HEeiPPaFAwP84Q4Git0FrIJ
 vWnlUkNy5sXMU1Ts4pMLxOANQfGSfRm2h6D/AhwswN5zjHAK7IqFmxlHfWC+x8A28SBW
 7ariSEENANGom1pjaa4UxlG9OTliMnDGSqNbjhT0C6km5oquFZsPQ+KA3ge1I7XyMMd7
 MoRrw6AG4coye3lQM6UnROwKihNellx4vPjQwjtj86GGuT4jP/HGaFEaXgwPJOZ7mZod
 Veo65rcRWKykn5kDcpWIKYe3grYoLPItNZ5vBgDnmlIYo/8v8btSjLi5Et6kqJfjPOwX
 cJMg==
X-Gm-Message-State: AOJu0Yy5UjeD9ra+82yn3rZqGlBxDd6VUhtWySFQ0xNmqnvzLFKXsC2c
 ZTqh+k5SsrWqCdckgm4W1b9GVUbv2IYN6nYfVdcFFqCRcYlu+711JCLwTtmdcZDAucrNG8EgDjU
 i2oq0
X-Gm-Gg: AeBDiesEdpz8Z6kcsz09Ed+dbV4Ggx3w06GmNr45Fvy/0tMdX498DkBKoZs2tOIGEr/
 cYWwsHZa91GITiwtnLkcHXP3WTemmRqFnWTXmG3LgYrYXpV039ctcYlfi6QYSOq3DKoppZ0OezO
 4lK0E3N4PUTZU1kpjZCE9yucwOnExUdDV8qckRGBGc5SIJKlgZXX5e9bUkrAVa9zm2grVH+T2Wf
 TuWjkGfwmuEHjtDFrVeTE9Z1mQG+RKgCDPhjhZMAbH19qIwQufSni5g2gr7Y7x0aCeyA2PlwHXF
 Y/xlJj2/ipsNXEkLiNww9Sl/Infl6m8s6Y58CVe+yPSZ3vvekuY3aJ+Y8kkWHJdsGRK0p4M5VaW
 Sm0MYYrjrJQnEnrMM982J7FcbfI7UagQC+2w30OdY2S3wKxEjvG1c9HojkCdkHVfBE7e5HyddOW
 xhEzhWF/koYGmZvVwUJ/LlUWvqOUKK1ips2Sdq7HbJ4LPvsJRPdTpIO6XQ1LakjhHK4DfpoGngG
 sW6OM11xRIFwCVdCG94NAdMes+NGFPTpfC/aoElrw==
X-Received: by 2002:a5d:64e4:0:b0:43d:7828:1f81 with SMTP id
 ffacd0b85a97d-43fe3e1170fmr41763476f8f.41.1776938576537; 
 Thu, 23 Apr 2026 03:02:56 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4eec9sm49323930f8f.34.2026.04.23.03.02.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:02:55 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/59] tcg/translator: add parameter to translator_loop for
 current addr type
Date: Thu, 23 Apr 2026 11:01:53 +0100
Message-ID: <20260423100229.2941820-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423100229.2941820-1-peter.maydell@linaro.org>
References: <20260423100229.2941820-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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

With TCG_ADDRESS_BITS mechanism, it's now possible to specify which
variant every source file is written for. Compared to before, it means
that addr_type will now vary per tb translation, where it was constant
for a given target previously.

Thus, we add new a parameter to translator_loop().
This will allow us to convert targets one by one.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260407222208.271838-15-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 accel/tcg/translate-all.c        | 1 -
 accel/tcg/translator.c           | 4 +++-
 include/exec/translator.h        | 4 +++-
 target/alpha/translate.c         | 3 ++-
 target/arm/tcg/translate-a64.c   | 3 ++-
 target/arm/tcg/translate.c       | 2 +-
 target/avr/translate.c           | 3 ++-
 target/hexagon/translate.c       | 3 ++-
 target/hppa/translate.c          | 3 ++-
 target/i386/tcg/translate.c      | 3 ++-
 target/loongarch/tcg/translate.c | 3 ++-
 target/m68k/translate.c          | 3 ++-
 target/microblaze/translate.c    | 3 ++-
 target/mips/tcg/translate.c      | 3 ++-
 target/or1k/translate.c          | 3 ++-
 target/ppc/translate.c           | 3 ++-
 target/riscv/translate.c         | 3 ++-
 target/rx/translate.c            | 3 ++-
 target/s390x/tcg/translate.c     | 3 ++-
 target/sh4/translate.c           | 3 ++-
 target/sparc/translate.c         | 3 ++-
 target/tricore/translate.c       | 3 ++-
 target/xtensa/translate.c        | 3 ++-
 23 files changed, 45 insertions(+), 23 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index fba4e9dc21..05d9ce512a 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -316,7 +316,6 @@ TranslationBlock *tb_gen_code(CPUState *cpu, TCGTBCPUState s)
     }
 
     tcg_ctx->gen_tb = tb;
-    tcg_ctx->addr_type = target_long_bits() == 32 ? TCG_TYPE_I32 : TCG_TYPE_I64;
     tcg_ctx->guest_mo = cpu->cc->tcg_ops->guest_default_memory_order;
 
  restart_translate:
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index f3eddcbb2e..cd7d079fe0 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -121,13 +121,15 @@ bool translator_use_goto_tb(DisasContextBase *db, vaddr dest)
 
 void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
                      vaddr pc, void *host_pc, const TranslatorOps *ops,
-                     DisasContextBase *db)
+                     DisasContextBase *db, TCGType addr_type)
 {
     uint32_t cflags = tb_cflags(tb);
     TCGOp *icount_start_insn;
     TCGOp *first_insn_start = NULL;
     bool plugin_enabled;
 
+    tcg_ctx->addr_type = addr_type;
+
     /* Initialize DisasContext */
     db->tb = tb;
     db->pc_first = pc;
diff --git a/include/exec/translator.h b/include/exec/translator.h
index 8d343627bd..978dee25ad 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -20,6 +20,7 @@
 
 #include "exec/memop.h"
 #include "exec/vaddr.h"
+#include "tcg/tcg.h"
 
 /**
  * DisasJumpType:
@@ -132,6 +133,7 @@ typedef struct TranslatorOps {
  * @host_pc: host physical program counter address
  * @ops: Target-specific operations.
  * @db: Disassembly context.
+ * @addr_type: TCG Type for addresses (TCG_TYPE_VA).
  *
  * Generic translator loop.
  *
@@ -147,7 +149,7 @@ typedef struct TranslatorOps {
  */
 void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
                      vaddr pc, void *host_pc, const TranslatorOps *ops,
-                     DisasContextBase *db);
+                     DisasContextBase *db, TCGType addr_type);
 
 /**
  * translator_use_goto_tb
diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 4d22d7d5a4..d2d1467a81 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -2953,5 +2953,6 @@ void alpha_translate_code(CPUState *cpu, TranslationBlock *tb,
                           int *max_insns, vaddr pc, void *host_pc)
 {
     DisasContext dc;
-    translator_loop(cpu, tb, max_insns, pc, host_pc, &alpha_tr_ops, &dc.base);
+    translator_loop(cpu, tb, max_insns, pc, host_pc, &alpha_tr_ops, &dc.base,
+                    TCG_TYPE_VA);
 }
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 7533a4d01b..df2cbd66b3 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -10956,5 +10956,6 @@ void aarch64_translate_code(CPUState *cpu, TranslationBlock *tb,
 {
      DisasContext dc = {};
      translator_loop(cpu, tb, max_insns, pc, host_pc,
-                     &aarch64_translator_ops, &dc.base);
+                     &aarch64_translator_ops, &dc.base,
+                     TCG_TYPE_VA);
 }
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 9ab926b118..fa4c7907dc 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -6889,6 +6889,6 @@ void arm_translate_code(CPUState *cpu, TranslationBlock *tb,
                         (EX_TBFLAG_AM32(tb_flags, THUMB)
                         ? &thumb_translator_ops
                         : &arm_translator_ops),
-                        &dc.base);
+                        &dc.base, TCG_TYPE_VA);
     }
 }
diff --git a/target/avr/translate.c b/target/avr/translate.c
index 649dd4b011..3c57606097 100644
--- a/target/avr/translate.c
+++ b/target/avr/translate.c
@@ -2802,5 +2802,6 @@ void avr_cpu_translate_code(CPUState *cs, TranslationBlock *tb,
                             int *max_insns, vaddr pc, void *host_pc)
 {
     DisasContext dc = { };
-    translator_loop(cs, tb, max_insns, pc, host_pc, &avr_tr_ops, &dc.base);
+    translator_loop(cs, tb, max_insns, pc, host_pc, &avr_tr_ops, &dc.base,
+                    TCG_TYPE_VA);
 }
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 633401451d..6ae2adabc0 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -1077,7 +1077,8 @@ void hexagon_translate_code(CPUState *cs, TranslationBlock *tb,
     DisasContext ctx;
 
     translator_loop(cs, tb, max_insns, pc, host_pc,
-                    &hexagon_tr_ops, &ctx.base);
+                    &hexagon_tr_ops, &ctx.base,
+                    TCG_TYPE_VA);
 }
 
 #define NAME_LEN               64
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 70c20c0037..cf57ec518d 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -4899,5 +4899,6 @@ void hppa_translate_code(CPUState *cs, TranslationBlock *tb,
                          int *max_insns, vaddr pc, void *host_pc)
 {
     DisasContext ctx = { };
-    translator_loop(cs, tb, max_insns, pc, host_pc, &hppa_tr_ops, &ctx.base);
+    translator_loop(cs, tb, max_insns, pc, host_pc, &hppa_tr_ops, &ctx.base,
+                    TCG_TYPE_VA);
 }
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 14210d569f..2115c5cd24 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -3615,5 +3615,6 @@ void x86_translate_code(CPUState *cpu, TranslationBlock *tb,
 {
     DisasContext dc;
 
-    translator_loop(cpu, tb, max_insns, pc, host_pc, &i386_tr_ops, &dc.base);
+    translator_loop(cpu, tb, max_insns, pc, host_pc, &i386_tr_ops, &dc.base,
+                    TCG_TYPE_VA);
 }
diff --git a/target/loongarch/tcg/translate.c b/target/loongarch/tcg/translate.c
index b9ed13d19c..202b80e047 100644
--- a/target/loongarch/tcg/translate.c
+++ b/target/loongarch/tcg/translate.c
@@ -342,7 +342,8 @@ void loongarch_translate_code(CPUState *cs, TranslationBlock *tb,
     DisasContext ctx;
 
     translator_loop(cs, tb, max_insns, pc, host_pc,
-                    &loongarch_tr_ops, &ctx.base);
+                    &loongarch_tr_ops, &ctx.base,
+                    TCG_TYPE_VA);
 }
 
 void loongarch_translate_init(void)
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index abc1c79f3c..138c89d3e5 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -6126,7 +6126,8 @@ void m68k_translate_code(CPUState *cpu, TranslationBlock *tb,
                          int *max_insns, vaddr pc, void *host_pc)
 {
     DisasContext dc;
-    translator_loop(cpu, tb, max_insns, pc, host_pc, &m68k_tr_ops, &dc.base);
+    translator_loop(cpu, tb, max_insns, pc, host_pc, &m68k_tr_ops, &dc.base,
+                    TCG_TYPE_VA);
 }
 
 static double floatx80_to_double(CPUM68KState *env, uint16_t high, uint64_t low)
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 2af67beece..5e8bb4ed77 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1788,7 +1788,8 @@ void mb_translate_code(CPUState *cpu, TranslationBlock *tb,
                        int *max_insns, vaddr pc, void *host_pc)
 {
     DisasContext dc;
-    translator_loop(cpu, tb, max_insns, pc, host_pc, &mb_tr_ops, &dc.base);
+    translator_loop(cpu, tb, max_insns, pc, host_pc, &mb_tr_ops, &dc.base,
+                    TCG_TYPE_VA);
 }
 
 void mb_cpu_dump_state(CPUState *cs, FILE *f, int flags)
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 54849e9ff1..3426acd37b 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -15242,7 +15242,8 @@ void mips_translate_code(CPUState *cs, TranslationBlock *tb,
 {
     DisasContext ctx;
 
-    translator_loop(cs, tb, max_insns, pc, host_pc, &mips_tr_ops, &ctx.base);
+    translator_loop(cs, tb, max_insns, pc, host_pc, &mips_tr_ops, &ctx.base,
+                    TCG_TYPE_VA);
 }
 
 void mips_tcg_init(void)
diff --git a/target/or1k/translate.c b/target/or1k/translate.c
index de81dc6ef8..eb4485312f 100644
--- a/target/or1k/translate.c
+++ b/target/or1k/translate.c
@@ -1647,7 +1647,8 @@ void openrisc_translate_code(CPUState *cs, TranslationBlock *tb,
     DisasContext ctx;
 
     translator_loop(cs, tb, max_insns, pc, host_pc,
-                    &openrisc_tr_ops, &ctx.base);
+                    &openrisc_tr_ops, &ctx.base,
+                    TCG_TYPE_VA);
 }
 
 void openrisc_cpu_dump_state(CPUState *cs, FILE *f, int flags)
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index a09a6df93f..3f6d326cef 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -6719,5 +6719,6 @@ void ppc_translate_code(CPUState *cs, TranslationBlock *tb,
 {
     DisasContext ctx;
 
-    translator_loop(cs, tb, max_insns, pc, host_pc, &ppc_tr_ops, &ctx.base);
+    translator_loop(cs, tb, max_insns, pc, host_pc, &ppc_tr_ops, &ctx.base,
+                    TCG_TYPE_VA);
 }
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index cb4f443601..f42e53df88 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1440,7 +1440,8 @@ void riscv_translate_code(CPUState *cs, TranslationBlock *tb,
 {
     DisasContext ctx;
 
-    translator_loop(cs, tb, max_insns, pc, host_pc, &riscv_tr_ops, &ctx.base);
+    translator_loop(cs, tb, max_insns, pc, host_pc, &riscv_tr_ops, &ctx.base,
+                    TCG_TYPE_VA);
 }
 
 void riscv_translate_init(void)
diff --git a/target/rx/translate.c b/target/rx/translate.c
index a245b9db8f..132d495710 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -2270,7 +2270,8 @@ void rx_translate_code(CPUState *cs, TranslationBlock *tb,
 {
     DisasContext dc;
 
-    translator_loop(cs, tb, max_insns, pc, host_pc, &rx_tr_ops, &dc.base);
+    translator_loop(cs, tb, max_insns, pc, host_pc, &rx_tr_ops, &dc.base,
+                    TCG_TYPE_VA);
 }
 
 #define ALLOC_REGISTER(sym, name) \
diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 9234444187..0f274621e5 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -6509,7 +6509,8 @@ void s390x_translate_code(CPUState *cs, TranslationBlock *tb,
 {
     DisasContext dc;
 
-    translator_loop(cs, tb, max_insns, pc, host_pc, &s390x_tr_ops, &dc.base);
+    translator_loop(cs, tb, max_insns, pc, host_pc, &s390x_tr_ops, &dc.base,
+                    TCG_TYPE_VA);
 }
 
 void s390x_restore_state_to_opc(CPUState *cs,
diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index b1057727c5..5adf650744 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -2316,5 +2316,6 @@ void sh4_translate_code(CPUState *cs, TranslationBlock *tb,
 {
     DisasContext ctx;
 
-    translator_loop(cs, tb, max_insns, pc, host_pc, &sh4_tr_ops, &ctx.base);
+    translator_loop(cs, tb, max_insns, pc, host_pc, &sh4_tr_ops, &ctx.base,
+                    TCG_TYPE_VA);
 }
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 7e8558dbbd..3156be6a94 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -5853,7 +5853,8 @@ void sparc_translate_code(CPUState *cs, TranslationBlock *tb,
 {
     DisasContext dc = {};
 
-    translator_loop(cs, tb, max_insns, pc, host_pc, &sparc_tr_ops, &dc.base);
+    translator_loop(cs, tb, max_insns, pc, host_pc, &sparc_tr_ops, &dc.base,
+                    TCG_TYPE_VA);
 }
 
 void sparc_tcg_init(void)
diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 0eaf7a82f8..8cd6b58f66 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -8500,7 +8500,8 @@ void tricore_translate_code(CPUState *cs, TranslationBlock *tb,
 {
     DisasContext ctx;
     translator_loop(cs, tb, max_insns, pc, host_pc,
-                    &tricore_tr_ops, &ctx.base);
+                    &tricore_tr_ops, &ctx.base,
+                    TCG_TYPE_VA);
 }
 
 /*
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 5e3707d3fd..6f9dd9fb5c 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -1233,7 +1233,8 @@ void xtensa_translate_code(CPUState *cpu, TranslationBlock *tb,
 {
     DisasContext dc = {};
     translator_loop(cpu, tb, max_insns, pc, host_pc,
-                    &xtensa_translator_ops, &dc.base);
+                    &xtensa_translator_ops, &dc.base,
+                    TCG_TYPE_VA);
 }
 
 void xtensa_cpu_dump_state(CPUState *cs, FILE *f, int flags)
-- 
2.43.0


