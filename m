Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6958CC3ABC0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 09:49:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCxs8-0000Bz-AU; Thu, 08 May 2025 05:48:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1uCxs6-0000B5-5b
 for qemu-devel@nongnu.org; Thu, 08 May 2025 05:48:54 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1uCxs4-0000YW-EV
 for qemu-devel@nongnu.org; Thu, 08 May 2025 05:48:53 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-30ac5cc0df4so1089166a91.2
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 02:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1746697730; x=1747302530; darn=nongnu.org;
 h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HPZEa3YzDTFrkeSvop+B/Cvd4GOwtfD9tuIAMpr1/ys=;
 b=PbQ3O5Q4UXcTDWQAZ+7u6h3ofvaHbvmKSxN/IUV3FEhoMRtHjiFx0VZScjE7b9NiBT
 VUVRIAHN0Niv9CUlR1GfEN4bAnc+G0JRnvXz5AAUJLQuSuCWr+j60zK/z0/05sN4dWGZ
 RlO5XhWajp6AKz3T/wpWJFRcW3HOfP2+vkR35hpbJ2ejiKGXEB8EUifVRy6rRir85kT7
 W5wJeRNjTs+SCsdyh9i+oywQJOltF+jFAHqdOY2BSUbrz8uBBEAaoNKJsIuw6pglbDbd
 hmv7bN0tvZlwzS4XWuh0Jlk8lDIyw/9AND53SIamgCMU9MSTQTS/lLP6mxfLE7Y2PPsQ
 PYhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746697730; x=1747302530;
 h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HPZEa3YzDTFrkeSvop+B/Cvd4GOwtfD9tuIAMpr1/ys=;
 b=IdjXPk/e0q0a2bs6MAIJMVOSciacjxa1ZU7AjCNopuRuzw5ZUC2aE+f8TEkb2QlmyU
 djj6h2SEaJqOhpioupHfWG/xJIXWlilg/MoE36p40Zw/a8IGzG8kfp//eyc/Eqa+naEu
 4J07IZqH30Q/dBc2y9cG4k/MW/3YxDAl5wdhcWkdWAWW9JABoEm7UVF4oRG+EwkOUnio
 6udfmUfIb6cUrCHlyE1dkklLcyEJkeCdL3ubwQ3oeRhHWb+FEM+fdRoKRGzerM8TjyUv
 oG5e5ievXyu0PZKlk/TBshGzWcBMmrecALn5P7F/eYUFEUwBdCP0W23IuLXTeErs19KB
 ecIg==
X-Gm-Message-State: AOJu0YzTPZSF/TsJpXSmi4CfEskaU8PFWHNLwWHXKzuN6wQIJUQcUzI1
 epegZw+IoD7JYNyD+ZYVWosUUsiSx7zmrCd0X2LGu6W65aQfEInWWZx+SE/p5Sf4G90Jd1JCRRp
 g2WeiQUoYU4lbZw8BApjGzMt2cV1jTxbEoqaLZm9KRFOEfoKmfXhUgFF7SHJwEOYNqWJsyl6LhA
 l5i1chltDuhfJvNjnSBLD6KQAEyjB/F83euw==
X-Gm-Gg: ASbGnctW93qQ3hLBS98h2oG80P48Y4Jnv+qMCkMgQbfJJv30YqzwD2FWljJ+E5nc0za
 Pj9Qsul3eF2/RweZXXYbqWF9zzihFMLhnMo10huosdDdiJb4IMpEEhpBUQwHgaH7rIIVN5ZGu0s
 OXvEVJ4IQMoS4iRFi3P7HlaEG3ZEMnLwpipjh4Gt8pgzT4tLwe/njJiTGkJHQzVv5oUpXMkt4xu
 m0kMrqmYKDBhepcLmrJnkHbdvdBf1klNdC6CQZf1VKNpLNnuAgXxEE+/wqr1PwmI6xQ0ogYi9m6
 ubj3BklCaV4CNJQsPZ61WI0BUprOA2RlGpqinA4S7FlAi1utnupznsHvD9YoZHQ=
X-Google-Smtp-Source: AGHT+IEL5cv2g4mPZjisZ7tTok6cMB4BxU5V9aGj/fIibPpAhPLaHRqmMDDU9Z9Ll/+FOagFPQwHlQ==
X-Received: by 2002:a17:90a:da87:b0:2ff:72f8:3708 with SMTP id
 98e67ed59e1d1-30aac1adc25mr11354915a91.17.1746697730103; 
 Thu, 08 May 2025 02:48:50 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30ad4fe1f47sm1730688a91.38.2025.05.08.02.48.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 May 2025 02:48:49 -0700 (PDT)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Jim Shu <jim.shu@sifive.com>
Subject: [PATCH v2] target/riscv: support atomic instruction fetch (Ziccif)
Date: Thu,  8 May 2025 17:48:38 +0800
Message-Id: <20250508094838.19394-1-jim.shu@sifive.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=jim.shu@sifive.com; helo=mail-pj1-x1036.google.com
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

Support 4-byte atomic instruction fetch when instruction is natural
aligned.

Current implementation is not atomic because it loads instruction twice
for first and last 2 bytes. We load 4 bytes at once to keep the
atomicity. This instruction preload method only applys when instruction
is 4-byte aligned. If instruction is unaligned, it could be across pages
so that preload will trigger additional page fault.

We encounter this issue when doing pressure test of enabling & disabling
Linux kernel ftrace. Ftrace with kernel preemption requires concurrent
modification and execution of instruction, so non-atomic instruction
fetch will cause the race condition. We may fetch the wrong instruction
which is the mixing of 2 instructions.

Also, RISC-V Profile wants to provide this feature by HW. RVA20U64
Ziccif protects the atomicity of instruction fetch when it is
natural aligned.

This commit depends on the atomic read support of translator_ld in
the commit 6a9dfe1984b0c593fb0ddb52d4e70832e6201dd6.

Signed-off-by: Jim Shu <jim.shu@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/translate.c | 46 +++++++++++++++++++++++++++++-----------
 1 file changed, 34 insertions(+), 12 deletions(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 85128f997b..77edf04803 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1222,13 +1222,35 @@ const RISCVDecoder decoder_table[] = {
 
 const size_t decoder_table_size = ARRAY_SIZE(decoder_table);
 
-static void decode_opc(CPURISCVState *env, DisasContext *ctx, uint16_t opcode)
+static void decode_opc(CPURISCVState *env, DisasContext *ctx)
 {
+    uint32_t opcode;
+    bool pc_is_4byte_align = ((ctx->base.pc_next % 4) == 0);
+
     ctx->virt_inst_excp = false;
-    ctx->cur_insn_len = insn_len(opcode);
+    if (pc_is_4byte_align) {
+        /*
+         * Load 4 bytes at once to make instruction fetch atomically.
+         *
+         * Note: When pc is 4-byte aligned, 4-byte instruction wouldn't be
+         * across pages. We could preload 4 bytes instruction no matter
+         * real one is 2 or 4 bytes. Instruction preload wouldn't trigger
+         * additional page fault.
+         */
+        opcode = translator_ldl(env, &ctx->base, ctx->base.pc_next);
+    } else {
+        /*
+         * For unaligned pc, instruction preload may trigger additional
+         * page fault so we only load 2 bytes here.
+         */
+        opcode = (uint32_t) translator_lduw(env, &ctx->base, ctx->base.pc_next);
+    }
+    ctx->ol = ctx->xl;
+
+    ctx->cur_insn_len = insn_len((uint16_t)opcode);
     /* Check for compressed insn */
     if (ctx->cur_insn_len == 2) {
-        ctx->opcode = opcode;
+        ctx->opcode = (uint16_t)opcode;
         /*
          * The Zca extension is added as way to refer to instructions in the C
          * extension that do not include the floating-point loads and stores
@@ -1238,15 +1260,17 @@ static void decode_opc(CPURISCVState *env, DisasContext *ctx, uint16_t opcode)
             return;
         }
     } else {
-        uint32_t opcode32 = opcode;
-        opcode32 = deposit32(opcode32, 16, 16,
-                             translator_lduw(env, &ctx->base,
-                                             ctx->base.pc_next + 2));
-        ctx->opcode = opcode32;
+        if (!pc_is_4byte_align) {
+            /* Load last 2 bytes of instruction here */
+            opcode = deposit32(opcode, 16, 16,
+                               translator_lduw(env, &ctx->base,
+                                               ctx->base.pc_next + 2));
+        }
+        ctx->opcode = opcode;
 
         for (guint i = 0; i < ctx->decoders->len; ++i) {
             riscv_cpu_decode_fn func = g_ptr_array_index(ctx->decoders, i);
-            if (func(ctx, opcode32)) {
+            if (func(ctx, opcode)) {
                 return;
             }
         }
@@ -1324,10 +1348,8 @@ static void riscv_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
     CPURISCVState *env = cpu_env(cpu);
-    uint16_t opcode16 = translator_lduw(env, &ctx->base, ctx->base.pc_next);
 
-    ctx->ol = ctx->xl;
-    decode_opc(env, ctx, opcode16);
+    decode_opc(env, ctx);
     ctx->base.pc_next += ctx->cur_insn_len;
 
     /*
-- 
2.17.1


