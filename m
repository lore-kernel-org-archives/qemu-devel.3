Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5255ACD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:06:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcss-0004oj-5N; Wed, 06 May 2026 10:05:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcsL-0004CV-Cq
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:05:27 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcsJ-0001eX-3R
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:05:21 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4891e5b9c1fso62734285e9.2
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 07:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778076317; x=1778681117; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nPoouT4hN+v1hCR0z87gIclFS+UQS3pcQ1N1wJ6ZGJ8=;
 b=WtGWF5vlOEQqvSI+s6woOee1vFX0q9hKNIz/IKynC3h1VS7kxVZT0CFozj93MS0kJK
 Q5N35oW782l2uPvgelaEmyq2EQ9gfqk76MvVaMmKnTpye+YqskierC95rzjKP+vW/0VK
 xO0dmLuYlVIHUnsrKDh0nFYn0p+fWLuKbYJfWeocaMyPSxMQ3C57hnY+mXq/JgbBawwY
 gzZSWSVFP2I/rJSd+Y7w3BPa+P6j6uqueWSDSHU3MnijcLerSlWq4P3zEtJ1BwjVDEf8
 utwCiu5eIlYZ6ib+IqmacQJL9XeFNLmMSd6aDsG7rJy399qF97rwaTqWF4XC4KiignPP
 adNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778076317; x=1778681117;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nPoouT4hN+v1hCR0z87gIclFS+UQS3pcQ1N1wJ6ZGJ8=;
 b=HZR5HPccCw/kMu3S0Bqt9hnHB1OD8Vo7Yz+mt4UEAdzCSs8R7N8W/NwjMhv1uVBda0
 4lOMIJt+4hTKby1e74W1e2J5ocoMoO2K6sTNGrRFL47v2Qn8owRZKz/++2+hSvmBJzMH
 FAX/G7e2URcngoRSbgW1YcGv73/qtEax71EMYRNlvVm3CMBhTDqLy1hx0xu4NXI+BgmM
 VLo4TyOIYBiL/90WsBUv+LXcc5nAsBZX+a+eTfozNm+YiHqaSbqegvPDoHi3wPKctuOb
 7NJnVLsNf+W1m+TE2BZWDILjl/x0wYouoBuIe434GLqovqxFIphA90LP+NC0DEodmB3T
 /a7g==
X-Gm-Message-State: AOJu0YwY1kHmmGhCIqXvIPxl3IQ8UXhSCrx9QXjpB40CpYHgPuJigS26
 VL92QFCGjJ7hyG63BBOTG+6oOM9cjlJ/9Zb309YmGZwZXyyp41Fuqt0v5+46MhMLb7PkZsDRrzS
 OCxC0xGk=
X-Gm-Gg: AeBDietN7I2vtgW2sA/xzdCUYuZc/0nmwJiMnx2Cb+rN4GrWlkRRuEPkIG4BVWQJZIb
 knxeK3fxXwYbtrngVDc+pYOpdU8dqvXGe1atq/0qU+lu1xGGUkhwDLJuj+F9eI+0zvbxcVSdqW2
 3Jbha2NVKaFVAmwXu1gzN0M0uH5GKJVtZ+EEkOQbDBLBagAMBq0JVK1+IFF3u7QTT/6COt6Y6Ya
 U7P7LQSiIGboAv+aKcOETHZVKinQsXnqHW6UkgJl+2oSAtsDAVz22SPmj/Rm6oMPO4kXOUIuPTN
 KxTo2fB2A48YQVmv6Sq6wVjodLeS3n8+UxpiYWHreBQK3MfSHxVmblh5Kc1FYW0tEadhfwQAdgb
 GzoWAf9z398fjwzjmcmxuXRYym5zK2d+c+o9WKI52hdISRGi9EIWU8hCTzrz2sM+FoTA9tYV2GZ
 gotKC9SStRNXft72hZssGjVqppFrs391EgsyxyGnZMQQ9kussB6c+qluZmKxOOaACbUxxew4+Iv
 Ygs+TKaCoA=
X-Received: by 2002:a05:600c:c082:b0:488:c40b:c8bf with SMTP id
 5b1f17b1804b1-48e51e0971dmr47302655e9.2.1778076315997; 
 Wed, 06 May 2026 07:05:15 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e538a5486sm52602525e9.6.2026.05.06.07.05.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 07:05:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 075/110] target/mips: Inline translator_ld[uw,l,q]() calls
Date: Wed,  6 May 2026 15:54:47 +0200
Message-ID: <20260506135524.20617-76-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

In preparation of removing the translator_ld[uw,l,q]() methods,
inline them for the MIPS target, expanding MO_TE by a runtime
check on mo_endian(ctx).

Mechanical change using the following Coccinelle 'spatch' script:

  @@
  expression env, db, pc;
  @@
  (
  - translator_lduw(env, db, pc)
  + translator_lduw_end(env, db, pc, mo_endian(ctx))
  |
  - translator_ldl(env, db, pc)
  + translator_ldl_end(env, db, pc, mo_endian(ctx))
  |
  - translator_ldq(env, db, pc)
  + translator_ldq_end(env, db, pc, mo_endian(ctx))
  )

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260417042620.35329-4-philmd@linaro.org>
---
 target/mips/tcg/translate.c               | 12 ++++++++----
 target/mips/tcg/micromips_translate.c.inc |  2 +-
 target/mips/tcg/mips16e_translate.c.inc   |  6 ++++--
 target/mips/tcg/nanomips_translate.c.inc  |  5 +++--
 4 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index fff6390f5d4..54ed253a7d0 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -15149,17 +15149,21 @@ static void mips_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
 
     is_slot = ctx->hflags & MIPS_HFLAG_BMASK;
     if (ctx->insn_flags & ISA_NANOMIPS32) {
-        ctx->opcode = translator_lduw(env, &ctx->base, ctx->base.pc_next);
+        ctx->opcode = translator_lduw_end(env, &ctx->base, ctx->base.pc_next,
+                                          mo_endian(ctx));
         insn_bytes = decode_isa_nanomips(env, ctx);
     } else if (!(ctx->hflags & MIPS_HFLAG_M16)) {
-        ctx->opcode = translator_ldl(env, &ctx->base, ctx->base.pc_next);
+        ctx->opcode = translator_ldl_end(env, &ctx->base, ctx->base.pc_next,
+                                         mo_endian(ctx));
         insn_bytes = 4;
         decode_opc(env, ctx);
     } else if (ctx->insn_flags & ASE_MICROMIPS) {
-        ctx->opcode = translator_lduw(env, &ctx->base, ctx->base.pc_next);
+        ctx->opcode = translator_lduw_end(env, &ctx->base, ctx->base.pc_next,
+                                          mo_endian(ctx));
         insn_bytes = decode_isa_micromips(env, ctx);
     } else if (ctx->insn_flags & ASE_MIPS16) {
-        ctx->opcode = translator_lduw(env, &ctx->base, ctx->base.pc_next);
+        ctx->opcode = translator_lduw_end(env, &ctx->base, ctx->base.pc_next,
+                                          mo_endian(ctx));
         insn_bytes = decode_ase_mips16e(env, ctx);
     } else {
         gen_reserved_instruction(ctx);
diff --git a/target/mips/tcg/micromips_translate.c.inc b/target/mips/tcg/micromips_translate.c.inc
index da2419792eb..07172a6c7fe 100644
--- a/target/mips/tcg/micromips_translate.c.inc
+++ b/target/mips/tcg/micromips_translate.c.inc
@@ -1629,7 +1629,7 @@ static void decode_micromips32_opc(CPUMIPSState *env, DisasContext *ctx)
     uint32_t op, minor, minor2, mips32_op;
     uint32_t cond, fmt, cc;
 
-    insn = translator_lduw(env, &ctx->base, ctx->base.pc_next + 2);
+    insn = translator_lduw_end(env, &ctx->base, ctx->base.pc_next + 2, mo_endian(ctx));
     ctx->opcode = (ctx->opcode << 16) | insn;
 
     rt = (ctx->opcode >> 21) & 0x1f;
diff --git a/target/mips/tcg/mips16e_translate.c.inc b/target/mips/tcg/mips16e_translate.c.inc
index 97da3456ea5..beb5b04ea29 100644
--- a/target/mips/tcg/mips16e_translate.c.inc
+++ b/target/mips/tcg/mips16e_translate.c.inc
@@ -453,7 +453,8 @@ static void decode_i64_mips16(DisasContext *ctx,
 
 static int decode_extended_mips16_opc(CPUMIPSState *env, DisasContext *ctx)
 {
-    int extend = translator_lduw(env, &ctx->base, ctx->base.pc_next + 2);
+    int extend = translator_lduw_end(env, &ctx->base, ctx->base.pc_next + 2,
+                                     mo_endian(ctx));
     int op, rx, ry, funct, sa;
     int16_t imm, offset;
 
@@ -686,7 +687,8 @@ static int decode_ase_mips16e(CPUMIPSState *env, DisasContext *ctx)
         /* No delay slot, so just process as a normal instruction */
         break;
     case M16_OPC_JAL:
-        offset = translator_lduw(env, &ctx->base, ctx->base.pc_next + 2);
+        offset = translator_lduw_end(env, &ctx->base, ctx->base.pc_next + 2,
+                                     mo_endian(ctx));
         offset = (((ctx->opcode & 0x1f) << 21)
                   | ((ctx->opcode >> 5) & 0x1f) << 16
                   | offset) << 2;
diff --git a/target/mips/tcg/nanomips_translate.c.inc b/target/mips/tcg/nanomips_translate.c.inc
index 9d4e0bee81f..4b0b01ba37a 100644
--- a/target/mips/tcg/nanomips_translate.c.inc
+++ b/target/mips/tcg/nanomips_translate.c.inc
@@ -3551,7 +3551,7 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
     int offset;
     int imm;
 
-    insn = translator_lduw(env, &ctx->base, ctx->base.pc_next + 2);
+    insn = translator_lduw_end(env, &ctx->base, ctx->base.pc_next + 2, mo_endian(ctx));
     ctx->opcode = (ctx->opcode << 16) | insn;
 
     rt = extract32(ctx->opcode, 21, 5);
@@ -3665,7 +3665,8 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
         break;
     case NM_P48I:
         {
-            insn = translator_lduw(env, &ctx->base, ctx->base.pc_next + 4);
+            insn = translator_lduw_end(env, &ctx->base, ctx->base.pc_next + 4,
+                                       mo_endian(ctx));
             target_long addr_off = extract32(ctx->opcode, 0, 16) | insn << 16;
             switch (extract32(ctx->opcode, 16, 5)) {
             case NM_LI48:
-- 
2.53.0


