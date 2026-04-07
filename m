Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85A8510F9972
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:43:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYcB-0005HO-Bi; Wed, 08 Apr 2026 15:31:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1wAYA3-0000kl-Tj
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 15:01:59 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1wAEoZ-0000qP-W5
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 18:22:33 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2b24fcc2b5dso36993455ad.1
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 15:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775600550; x=1776205350; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AY01BA6zNQI7RrcMbVd5Tdbx8eCAS1sPQExP/Nzg4AI=;
 b=TP2OMQj9Br10XJQY6u9kEMcM7PUgYaDNQffg2OOfWOYVot4W0Vz66ZtbyWW4RL/BZY
 L2TOImfxeT21GzJoVgP+7N8ZhNoiVWRfBJDgs1GQSTaSZQwvQrd2z5Hb6a5XWZWNeeUd
 IxhTItYLutw3LzByW4wfnsyPXkxYOGCI2mBxsd78Fe0ylTkudo9P5rU5PsxWEcejvtM3
 uccbr4pf71oadv/xbGKzLpDdXHAOSHzalCrc4EGchbjCmJuQOQeawK3Nag9rugroDI/v
 pUD322eT5ZhjBzDviaHKGcyjMxCx3FnAhSHhlT5yEnZS3hywv7jJTCav4cYZIrTWfNwZ
 vbgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775600550; x=1776205350;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AY01BA6zNQI7RrcMbVd5Tdbx8eCAS1sPQExP/Nzg4AI=;
 b=ivzT4QFPDJQmybs5198/phezMCTboJcF8aVJ0AXHW/P75i4y9kvA0eg48MWB3yD3+M
 GVRRPFkEiSBy868Cinc3y4YIv2mk3QSP+FdHSjXU/mjbKBC1UBzOfhu3K8soovYV7/iA
 RNltHps/tAUlXhM37yrjpN4WXgPLnlRA+EVdQ0mg6m3DDvUNeE4iSBiI6jVw2q46aL8j
 fDnbA0/i+ORrwzSPkJnItfXXDXSpzK/qygSLxNzwXYa38nbQZx6RxEOi8hHME+4RZr25
 /5EXB/FDCEz3wLODRc5COagdii8U879TITbrVuG23h8ejWrISAnZyLPdk/HbH1DzA5kz
 VLKg==
X-Gm-Message-State: AOJu0YxCviGg1PvKM9Q7/+SIcba9v7RicqM6tqrOj5zgGJQtkXPihLut
 RoUDOgNmNbvk+Okh2S0TAr/nhAzPMGS+hLU4PaDcaFW2fRPCMNQyLDb+XTUP8icZ9QFutEEjvIO
 z7bFmUUQ=
X-Gm-Gg: AeBDiesjgSocctBQ3Ccsy5kXD7gX8rfDcPcAzKnnDVjqj1Ur34MwqnrEgAr7K6QZZfq
 8TyQDP7Bvhd7Vk2QHwB7gAilSHvckAFCI1r7RcZHugcF/uPpiuywb4/yW6KonLtjHn8Z/kCgX0w
 SbeB+839+YQR8Vomp1Z/GdX34E1a7k5ryXk4Mx34AsXJe6+mqbx6R1H28TzN3S2Fv6gYPyIpNnU
 bdyJYr95NCbD/h5/5NvDZHyTRRz82D2aNeRhvoVGunYG6NyMIpsehoYhPHq/cjNb63cHxcTzGVQ
 fkAc75q6x1D96+28Dd3p4K/k797ZnRH2SfonCD0KMtmWZefolxDqx+GL/78XPRwYeggcx5K7QaU
 vyJg3v6bDUWfgtFAd8Ib4q+4wpAOrGPqqulg12minc01zymGYWNByGsQ3mbwP/1ltgYSsswIEVI
 AkCingQCVHuQ5PLxqfDcZjyL0KQ8qlhDUByI8iAxsB1CXvdvDZR2wKXFXGLYAvGXAoPxOoDLA54
 bsy
X-Received: by 2002:a17:903:3b83:b0:2b2:5a5a:4f2f with SMTP id
 d9443c01a7336-2b28184bfdamr191484885ad.33.1775600550466; 
 Tue, 07 Apr 2026 15:22:30 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b274979d5csm180412065ad.38.2026.04.07.15.22.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 15:22:29 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, jim.macarthur@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v11 14/21] tcg/translator: add parameter to translator_loop
 for current addr type
Date: Tue,  7 Apr 2026 15:22:01 -0700
Message-ID: <20260407222208.271838-15-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260407222208.271838-1-pierrick.bouvier@linaro.org>
References: <20260407222208.271838-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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
index 8d343627bd9..978dee25add 100644
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
index 7533a4d01b6..df2cbd66b38 100644
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
index 9ab926b118e..fa4c7907dcd 100644
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


