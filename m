Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 807A8FB5183
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 02:29:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9wBK-0007t3-Qa; Mon, 06 Apr 2026 22:28:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9wAp-0007dD-Ee
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 22:28:17 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9wAk-00070I-Ke
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 22:28:13 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2b25cf1b5f0so28889635ad.3
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 19:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775528888; x=1776133688; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VP4Ynmg4JOyugp2CSmYH+xCOAS+dpvjwcVBd48EIrx8=;
 b=UKQ8h2NzmHugRcAm7E7V9EesNqGF8HRnuWd/6A4r8iRsxYnzMfyyUIYpFFJo9X7uFf
 xxY67X5zbTi1I+WFS7rG5QwPC2X3A2brkRjcE7YQ6myhcEsWP6ZZNlwd1PIt7yExM09f
 SShgW/D58Ffm7HLIQnUQuDsoejcdyLRNlkht2Tv29o62aINbD864rdGLut+f/KwKUD2l
 fv6iypm8BvUcE5efSDymcSCXklog9P7hSdB4tKHrt9zR+mDqreeP86g47kBRYNQVAcMf
 sWe6X7i/OQ7IYqp6m18Jf5eGgJj07tEUmP5oYAFytvpshcQDz2LZegECqgAsv58t02f1
 PNmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775528888; x=1776133688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VP4Ynmg4JOyugp2CSmYH+xCOAS+dpvjwcVBd48EIrx8=;
 b=cG8C2w3fZhr51t6etjrcHOCq7N6rai1H3iIqDMdKtwvMDtv//ofGDAz1r7d9IITzqS
 ZpQMCymQa09MBzOwwt0U4euW0HoQxPzOC1t56Y0cAe087ZkruMFCQwKvQo74TJqXmeja
 yilpilQZAkZU8X//gh/r46nNnjhHtpnyWE9kn7CmqBWpNqrBARe2EEsrNU9QARzh/g5Z
 LMO+qfahp78aip4+pMN+ezFZvwxYWDz0Cev55+QpjzEwAZQEqzasYu3GDECe58m1FffC
 8y9aAs/FOVkmUUa+JeNjyMqU5BbxJNSTNTtRrf2suwk1UOSnrHIV4B18WbvDVAkuUUkK
 zAAA==
X-Gm-Message-State: AOJu0YwU7VrVqV7i8twmL4Xh9ud8myaxzX55aY8w0i2z0sQInvNq2XWp
 h5gb9+B0zIX5jXJe3TU/Cf4UTIMuw8iqzMxwpzSj4LPWkUUQpprS6gVdN/ySpXFEe3l712Kk5V7
 LVtCJ+YZH1w==
X-Gm-Gg: AeBDieuyW/NyHvk1iucMiNdFcKDzhoi+I41zq3bKGDsFOsRVPI56UZsjRT7VpwpuxBR
 5rX9p3gqFMVzJ12OCz7oNp39xY9hA022mnCS5KJJS9FW8hAp8mEQ1HskqxVWkIVXdoQDOqfIJOk
 FtEP/oUjL57JLuFpopxgOWhmhWmVrE8bLimQuSzGnZQl2HS+ogi1PA0FdXnOewxS1slUuB80vkA
 kATMsK9sgHr9EB7NZ0ODVyQaW+jdOaO6Sx2MwYR4OYar61DdZuvK8OT8xBtSFjKCeLwvQBAfnFB
 gOqeGXMXCwo9cDv43nHQUOugnbeo12JzvjFVM2KyLpAu3yfAQKdRotu72OE5i05ugYx5wMPpNVq
 SJ83EhOZ0y5ZcjgcugVPaFz5jLlxJFVvrc5lDvgjQ5cjJO71wrXMsoY9sCIocyS7HIzAjk20z/J
 8VcNsIcnT+S8STizmvcrDfTMJXa3flGdkSd5FysJFuSlidXwdapNwiNfWRuomQsj1CmDohwdG0F
 gJU
X-Received: by 2002:a17:903:120b:b0:2b2:596d:594 with SMTP id
 d9443c01a7336-2b2816a5ba1mr170038395ad.13.1775528888262; 
 Mon, 06 Apr 2026 19:28:08 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2749794e8sm161423685ad.53.2026.04.06.19.28.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 19:28:07 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, jim.macarthur@linaro.org,
 qemu-arm@nongnu.org
Subject: [PATCH v9 14/20] tcg/translator: add parameter to translator_loop for
 current addr type
Date: Mon,  6 Apr 2026 19:27:42 -0700
Message-ID: <20260407022748.57629-15-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260407022748.57629-1-pierrick.bouvier@linaro.org>
References: <20260407022748.57629-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
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

With TCG_ADDRESS_BITS mechanism, it's now possible to specify which
variant every source file is written for. Compared to before, it means
that addr_type will now vary per tb translation, where it was constant
for a given target previously.

Thus, we add new a parameter to translator_loop().
This will allow us to convert targets one by one.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/exec/translator.h        | 4 +++-
 accel/tcg/translate-all.c        | 1 -
 accel/tcg/translator.c           | 4 +++-
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

diff --git a/include/exec/translator.h b/include/exec/translator.h
index 8d343627bd9..c1d31e06b53 100644
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
+ * @addr_type: TCG Type for addresses (TCGv_va).
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
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index fba4e9dc21c..05d9ce512a4 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -316,7 +316,6 @@ TranslationBlock *tb_gen_code(CPUState *cpu, TCGTBCPUState s)
     }
 
     tcg_ctx->gen_tb = tb;
-    tcg_ctx->addr_type = target_long_bits() == 32 ? TCG_TYPE_I32 : TCG_TYPE_I64;
     tcg_ctx->guest_mo = cpu->cc->tcg_ops->guest_default_memory_order;
 
  restart_translate:
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index f3eddcbb2e8..cd7d079fe05 100644
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
diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 4d22d7d5a45..d2d1467a812 100644
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
index c5af26e2b7e..f446c269dfc 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -10955,5 +10955,6 @@ void aarch64_translate_code(CPUState *cpu, TranslationBlock *tb,
 {
      DisasContext dc = {};
      translator_loop(cpu, tb, max_insns, pc, host_pc,
-                     &aarch64_translator_ops, &dc.base);
+                     &aarch64_translator_ops, &dc.base,
+                     TCG_TYPE_VA);
 }
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 0597c9d4bed..7bdf46dd899 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -6888,6 +6888,6 @@ void arm_translate_code(CPUState *cpu, TranslationBlock *tb,
                         (EX_TBFLAG_AM32(tb_flags, THUMB)
                         ? &thumb_translator_ops
                         : &arm_translator_ops),
-                        &dc.base);
+                        &dc.base, TCG_TYPE_VA);
     }
 }
diff --git a/target/avr/translate.c b/target/avr/translate.c
index 649dd4b0112..3c576060970 100644
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
index 633401451d8..6ae2adabc0f 100644
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
index 70c20c00377..cf57ec518d4 100644
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
index 14210d569f7..2115c5cd24b 100644
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
index b9ed13d19c6..202b80e0475 100644
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
index abc1c79f3cd..138c89d3e53 100644
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
index 2af67beecec..5e8bb4ed77b 100644
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
index 54849e9ff1a..3426acd37b4 100644
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
index de81dc6ef8d..eb4485312f2 100644
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
index a09a6df93fd..3f6d326cef3 100644
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
index cb4f4436018..f42e53df888 100644
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
index a245b9db8fe..132d495710c 100644
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
index 92344441878..0f274621e5a 100644
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
index b1057727c55..5adf650744c 100644
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
index 7e8558dbbd8..3156be6a94c 100644
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
index 0eaf7a82f87..8cd6b58f66b 100644
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
index 5e3707d3fdf..6f9dd9fb5cf 100644
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
2.47.3


