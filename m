Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBB5AC47DDB
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jan 2024 04:44:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTx05-0004gm-Kx; Sat, 27 Jan 2024 23:42:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTx04-0004gX-JX
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 23:42:32 -0500
Received: from mail-qv1-xf32.google.com ([2607:f8b0:4864:20::f32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTx02-0004Hx-C7
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 23:42:32 -0500
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-686b389b5d6so16701316d6.0
 for <qemu-devel@nongnu.org>; Sat, 27 Jan 2024 20:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706416949; x=1707021749; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9+/x34hZ0Savjf5fK/vjCGUP8dkpzXoOGlANXKjp7EA=;
 b=WKz9Ie4mFLhbswDPhE5HzRw9zXcT4RQtK0038S770RxLBSjsVhg3MOb2Bf/3rDZg+f
 wEl7lvW9fss8tqeELwDRSg4I7yzan6TW3NSa6LOb93jUr4rqRpeRphF3cwwsEz0r9oQA
 bUOqBBEmGdOVDJBJa7utWVOEuXc5QthRYFZTUw1bM+NnP4xzljr320Dt/+47y8DlyZIk
 Runu4xmjy+t/6YnGboc0VVVmklfN5kXHML166JvCTKyuvs6TMLnmVBfS36hC1nBhdzL5
 gilANlcddAKCNSM7mefQy/SWEKrLOi7FJaR0NiGCqy8yEIVjuuVvAGv4B+J63RU9Pwig
 6hSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706416949; x=1707021749;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9+/x34hZ0Savjf5fK/vjCGUP8dkpzXoOGlANXKjp7EA=;
 b=b2HaDo4ic6pdIQDmE08H8ovAudvt2F6eA28y/EcTUvKuzrH8+uDGSrwoUHRAJYNj6c
 6BX0MJ4Z6Ix/rJyhJkAPuRKpEUcDJYZT4dN7eQ+E6+UynF+u40xPnCxPq/vPCAVXXkcU
 hebQkEoKfOA0UCYjnJiaEn/fprftnxc8QlAWw74gybLRi+uOPH5NMIg/e1mcFHzd8By5
 MQ/Oy9GT/bB2hZwqOaeYCFTyiR73cu+8f+A9pUGGOaR5qV6duv64EWpa0Y6tfMaEVqbD
 FUAEaiR7NZdyoq7MBE/LF3SCFxrq0hcH99P1Tgl4DUvR7QOxCzqfxOYlaFjMMpAr9DMX
 YxoQ==
X-Gm-Message-State: AOJu0YwERRlovn5E0AqxHqb5iub1meqnoDaYqd2iJS39R6ekTr3IYJYy
 s0GTjadF78zgxYTMZBvh+BLj80V2K0MYzSKh/EdXP3jSg8TKgg7f6xcJWJkm9t00uoZRTcOozQO
 8YYBcOQ==
X-Google-Smtp-Source: AGHT+IEupSSUlk4yg27uHfUYkhPqcWfJ22C93QRHdTPv/xEjJTi3MZj198hh62fO+U7wp6BVh9mMLA==
X-Received: by 2002:a05:6214:5092:b0:68c:4a74:f65 with SMTP id
 kk18-20020a056214509200b0068c4a740f65mr44845qvb.21.1706416948916; 
 Sat, 27 Jan 2024 20:42:28 -0800 (PST)
Received: from stoup..
 (ppp121-45-131-89.bri-pow-que-bras31.tpg.internode.on.net. [121.45.131.89])
 by smtp.gmail.com with ESMTPSA id
 w24-20020a17090aaf9800b002906e09e1d1sm5631873pjq.18.2024.01.27.20.42.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jan 2024 20:42:28 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
Subject: [PATCH 04/33] target: Use vaddr in gen_intermediate_code
Date: Sun, 28 Jan 2024 14:41:44 +1000
Message-Id: <20240128044213.316480-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240128044213.316480-1-richard.henderson@linaro.org>
References: <20240128044213.316480-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f32;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf32.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Anton Johansson <anjo@rev.ng>

Makes gen_intermediate_code() signature target agnostic so the function
can be called from accel/tcg/translate-all.c without target specifics.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20240119144024.14289-9-anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/translator.h        | 2 +-
 target/alpha/translate.c         | 2 +-
 target/arm/tcg/translate.c       | 2 +-
 target/avr/translate.c           | 2 +-
 target/cris/translate.c          | 2 +-
 target/hexagon/translate.c       | 2 +-
 target/hppa/translate.c          | 2 +-
 target/i386/tcg/translate.c      | 2 +-
 target/loongarch/tcg/translate.c | 2 +-
 target/m68k/translate.c          | 2 +-
 target/microblaze/translate.c    | 2 +-
 target/mips/tcg/translate.c      | 2 +-
 target/nios2/translate.c         | 2 +-
 target/openrisc/translate.c      | 2 +-
 target/ppc/translate.c           | 2 +-
 target/riscv/translate.c         | 2 +-
 target/rx/translate.c            | 2 +-
 target/s390x/tcg/translate.c     | 2 +-
 target/sh4/translate.c           | 2 +-
 target/sparc/translate.c         | 2 +-
 target/tricore/translate.c       | 2 +-
 target/xtensa/translate.c        | 2 +-
 22 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/include/exec/translator.h b/include/exec/translator.h
index 6d3f59d095..b0412ea6b6 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -33,7 +33,7 @@
  * the target-specific DisasContext, and then invoke translator_loop.
  */
 void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb, int *max_insns,
-                           target_ulong pc, void *host_pc);
+                           vaddr pc, void *host_pc);
 
 /**
  * DisasJumpType:
diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 32333081d8..134eb7225b 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -2971,7 +2971,7 @@ static const TranslatorOps alpha_tr_ops = {
 };
 
 void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb, int *max_insns,
-                           target_ulong pc, void *host_pc)
+                           vaddr pc, void *host_pc)
 {
     DisasContext dc;
     translator_loop(cpu, tb, max_insns, pc, host_pc, &alpha_tr_ops, &dc.base);
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index b3660173d1..5fa8249723 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -9691,7 +9691,7 @@ static const TranslatorOps thumb_translator_ops = {
 
 /* generate intermediate code for basic block 'tb'.  */
 void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb, int *max_insns,
-                           target_ulong pc, void *host_pc)
+                           vaddr pc, void *host_pc)
 {
     DisasContext dc = { };
     const TranslatorOps *ops = &arm_translator_ops;
diff --git a/target/avr/translate.c b/target/avr/translate.c
index cdffa04519..e5dd057799 100644
--- a/target/avr/translate.c
+++ b/target/avr/translate.c
@@ -2805,7 +2805,7 @@ static const TranslatorOps avr_tr_ops = {
 };
 
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int *max_insns,
-                           target_ulong pc, void *host_pc)
+                           vaddr pc, void *host_pc)
 {
     DisasContext dc = { };
     translator_loop(cs, tb, max_insns, pc, host_pc, &avr_tr_ops, &dc.base);
diff --git a/target/cris/translate.c b/target/cris/translate.c
index b3974ba0bb..ee1402a9a3 100644
--- a/target/cris/translate.c
+++ b/target/cris/translate.c
@@ -3172,7 +3172,7 @@ static const TranslatorOps cris_tr_ops = {
 };
 
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int *max_insns,
-                           target_ulong pc, void *host_pc)
+                           vaddr pc, void *host_pc)
 {
     DisasContext dc;
     translator_loop(cs, tb, max_insns, pc, host_pc, &cris_tr_ops, &dc.base);
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 95579ae243..a14211cf68 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -1154,7 +1154,7 @@ static const TranslatorOps hexagon_tr_ops = {
 };
 
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int *max_insns,
-                           target_ulong pc, void *host_pc)
+                           vaddr pc, void *host_pc)
 {
     DisasContext ctx;
 
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 3ef39b1bd7..08d09d50d7 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -4631,7 +4631,7 @@ static const TranslatorOps hppa_tr_ops = {
 };
 
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int *max_insns,
-                           target_ulong pc, void *host_pc)
+                           vaddr pc, void *host_pc)
 {
     DisasContext ctx;
     translator_loop(cs, tb, max_insns, pc, host_pc, &hppa_tr_ops, &ctx.base);
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index e193c74472..2808903661 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -7088,7 +7088,7 @@ static const TranslatorOps i386_tr_ops = {
 
 /* generate intermediate code for basic block 'tb'.  */
 void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb, int *max_insns,
-                           target_ulong pc, void *host_pc)
+                           vaddr pc, void *host_pc)
 {
     DisasContext dc;
 
diff --git a/target/loongarch/tcg/translate.c b/target/loongarch/tcg/translate.c
index 21f4db6fbd..235515c629 100644
--- a/target/loongarch/tcg/translate.c
+++ b/target/loongarch/tcg/translate.c
@@ -343,7 +343,7 @@ static const TranslatorOps loongarch_tr_ops = {
 };
 
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int *max_insns,
-                           target_ulong pc, void *host_pc)
+                           vaddr pc, void *host_pc)
 {
     DisasContext ctx;
 
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 4a0b0b2703..5ec88c5f0d 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -6088,7 +6088,7 @@ static const TranslatorOps m68k_tr_ops = {
 };
 
 void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb, int *max_insns,
-                           target_ulong pc, void *host_pc)
+                           vaddr pc, void *host_pc)
 {
     DisasContext dc;
     translator_loop(cpu, tb, max_insns, pc, host_pc, &m68k_tr_ops, &dc.base);
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 49bfb4a0ea..2e628647d1 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1792,7 +1792,7 @@ static const TranslatorOps mb_tr_ops = {
 };
 
 void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb, int *max_insns,
-                           target_ulong pc, void *host_pc)
+                           vaddr pc, void *host_pc)
 {
     DisasContext dc;
     translator_loop(cpu, tb, max_insns, pc, host_pc, &mb_tr_ops, &dc.base);
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 13e43fa3b6..e10232738c 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -15554,7 +15554,7 @@ static const TranslatorOps mips_tr_ops = {
 };
 
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int *max_insns,
-                           target_ulong pc, void *host_pc)
+                           vaddr pc, void *host_pc)
 {
     DisasContext ctx;
 
diff --git a/target/nios2/translate.c b/target/nios2/translate.c
index e806623594..3078372b36 100644
--- a/target/nios2/translate.c
+++ b/target/nios2/translate.c
@@ -1036,7 +1036,7 @@ static const TranslatorOps nios2_tr_ops = {
 };
 
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int *max_insns,
-                           target_ulong pc, void *host_pc)
+                           vaddr pc, void *host_pc)
 {
     DisasContext dc;
     translator_loop(cs, tb, max_insns, pc, host_pc, &nios2_tr_ops, &dc.base);
diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index ecff4412b7..d4cbc5eaea 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -1658,7 +1658,7 @@ static const TranslatorOps openrisc_tr_ops = {
 };
 
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int *max_insns,
-                           target_ulong pc, void *host_pc)
+                           vaddr pc, void *host_pc)
 {
     DisasContext ctx;
 
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 329da4d518..049f636927 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -7518,7 +7518,7 @@ static const TranslatorOps ppc_tr_ops = {
 };
 
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int *max_insns,
-                           target_ulong pc, void *host_pc)
+                           vaddr pc, void *host_pc)
 {
     DisasContext ctx;
 
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 071fbad7ef..ab18899122 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1287,7 +1287,7 @@ static const TranslatorOps riscv_tr_ops = {
 };
 
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int *max_insns,
-                           target_ulong pc, void *host_pc)
+                           vaddr pc, void *host_pc)
 {
     DisasContext ctx;
 
diff --git a/target/rx/translate.c b/target/rx/translate.c
index c6ce717a95..2265bd14ac 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -2266,7 +2266,7 @@ static const TranslatorOps rx_tr_ops = {
 };
 
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int *max_insns,
-                           target_ulong pc, void *host_pc)
+                           vaddr pc, void *host_pc)
 {
     DisasContext dc;
 
diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 8df00b7df9..a5fd9cccaa 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -6547,7 +6547,7 @@ static const TranslatorOps s390x_tr_ops = {
 };
 
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int *max_insns,
-                           target_ulong pc, void *host_pc)
+                           vaddr pc, void *host_pc)
 {
     DisasContext dc;
 
diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 81f825f125..6a6d862b10 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -2317,7 +2317,7 @@ static const TranslatorOps sh4_tr_ops = {
 };
 
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int *max_insns,
-                           target_ulong pc, void *host_pc)
+                           vaddr pc, void *host_pc)
 {
     DisasContext ctx;
 
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 9387299559..97184fa403 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -5327,7 +5327,7 @@ static const TranslatorOps sparc_tr_ops = {
 };
 
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int *max_insns,
-                           target_ulong pc, void *host_pc)
+                           vaddr pc, void *host_pc)
 {
     DisasContext dc = {};
 
diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 66553d1be0..f1156c39e7 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -8472,7 +8472,7 @@ static const TranslatorOps tricore_tr_ops = {
 
 
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int *max_insns,
-                           target_ulong pc, void *host_pc)
+                           vaddr pc, void *host_pc)
 {
     DisasContext ctx;
     translator_loop(cs, tb, max_insns, pc, host_pc,
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 87947236ca..e4772462b5 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -1239,7 +1239,7 @@ static const TranslatorOps xtensa_translator_ops = {
 };
 
 void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb, int *max_insns,
-                           target_ulong pc, void *host_pc)
+                           vaddr pc, void *host_pc)
 {
     DisasContext dc = {};
     translator_loop(cpu, tb, max_insns, pc, host_pc,
-- 
2.34.1


