Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC4A5C27C53
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 10:15:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFWcA-0007S8-I9; Fri, 07 Jun 2024 06:14:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1sFWcA-0007Ro-1U
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 06:14:30 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1sFWc8-0006tz-A6
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 06:14:29 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-702342c60dfso1569850b3a.2
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2024 03:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1717755267; x=1718360067; darn=nongnu.org;
 h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O/hLjwSZYyAijfW076LoQtJn+HsWPgshZbB3DFSpoRc=;
 b=TM4mLDrWC1Pc8QUb47hOXVqLHML6FIDUPY6IirJ5Py7MiR1uFrt0IRoELBFKakpxpv
 hAN8lhNRoV2XGrYukFyCgxrQImgj3z9wbNJr2W+XqLIMHARkmOZ7K/AmwOJMvcP5E6eq
 I9Tw7YoulQfr2EcWx1d6+wRlreqL1Ocw4zx6zmE0gUUrt9vF6Sus4jCetf7/dSQBFR1T
 WrNRTxry+RVYLk5r8ub6AXHvOXsprManzN2qbjuc1ExS2ay8LQVtuTTFkJcnfR5K1Nhj
 wtiD1wWlgrIJQ1ngbSdkh1qGK98YV9136f2+6Mmke4gROSb9PF1uMDQkxDILXsMONu73
 gEnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717755267; x=1718360067;
 h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O/hLjwSZYyAijfW076LoQtJn+HsWPgshZbB3DFSpoRc=;
 b=XGSWAZU7XcfmuJ9BpIVWatLabUk7bJDf/51JeHtsbEkzZm5nD39S6gVVWsd798Ef4p
 O2OgzNULugIQTg/QjJPihjEi8TGcM4QKPAzwRrmDp9bqU/A/o0BGWN5iOHbdNNz1WfQc
 ZWn+S1fWCD/6ungCZfaNzbtJBodupuHjNVR5UJENkZkl2HKVOkWuSWaeEfuo2xuSL6Pw
 DoFsDB9Bpha+3tBsbgKoA4rTVk6XBgOH96sIwnC0D+UcwBGevCfrq++QXZR6VkHv38fI
 nWYmIkLPwf89KB5we11SLdFjNfNr7EJ2O0I9x9EE3yJCaeHAHC99G45KYMXtVzOZZx/u
 aaNg==
X-Gm-Message-State: AOJu0Yx5ZC09h4D0YXH14NEeXKOckvaTIGvFsSb9qcaVjsmaA06uUj/f
 S0Ov503AUYZ7wr4UIYyleWrmZBSfwz3OKYeUrIQZFaI/a7wfsgmy8ukDvdLs6ySWF1XZR6o4Ydz
 PK7nKfK79zAxMUXtMoG3LZws5OnASldjnDhNKRdX7jq0QHYdyaf/DzAB1/riCeb6RY7ZzsyCWJF
 Fke9uzMIPER12/1O2wqWbgpHWlTV3jH5bljQ==
X-Google-Smtp-Source: AGHT+IGSwm7HoXfieqsg4VT/Tu52OL4SUJ8duoESmxIvHLtY6SvrYbsElVuK/Aaj0MlHcpNJAtB2hA==
X-Received: by 2002:a05:6a21:181:b0:1af:ac96:f4bf with SMTP id
 adf61e73a8af0-1b2f96e0bc4mr2160527637.15.1717755266208; 
 Fri, 07 Jun 2024 03:14:26 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6bd76c240sm30975025ad.89.2024.06.07.03.14.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jun 2024 03:14:25 -0700 (PDT)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Jim Shu <jim.shu@sifive.com>
Subject: [PATCH] target/riscv: support atomic instruction fetch (Ziccif)
Date: Fri,  7 Jun 2024 18:14:03 +0800
Message-Id: <20240607101403.1109-1-jim.shu@sifive.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=jim.shu@sifive.com; helo=mail-pf1-x42f.google.com
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

Signed-off-by: Jim Shu <jim.shu@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/translate.c | 45 ++++++++++++++++++++++++++++++----------
 1 file changed, 34 insertions(+), 11 deletions(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 0569224e53..2be8ef63e6 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1133,13 +1133,37 @@ const RISCVDecoder decoder_table[] = {
 
 const size_t decoder_table_size = ARRAY_SIZE(decoder_table);
 
-static void decode_opc(CPURISCVState *env, DisasContext *ctx, uint16_t opcode)
+static void decode_opc(CPURISCVState *env, DisasContext *ctx)
 {
     ctx->virt_inst_excp = false;
+
+    uint32_t opcode;
+    bool is_4byte_align = false;
+
+    if ((ctx->base.pc_next % 4) == 0) {
+        /*
+         * Load 4 bytes at once to make instruction fetch atomically.
+         *
+         * Note: When pc is 4-byte aligned, 4-byte instruction wouldn't be
+         * across pages. We could preload 4 bytes instruction no matter
+         * real one is 2 or 4 bytes. Instruction preload wouldn't trigger
+         * additional page fault.
+         */
+        opcode = translator_ldl(env, &ctx->base, ctx->base.pc_next);
+        is_4byte_align = true;
+    } else {
+        /*
+         * For unaligned pc, instruction preload may trigger additional
+         * page fault so we only load 2 bytes here.
+         */
+        opcode = (uint32_t) translator_lduw(env, &ctx->base, ctx->base.pc_next);
+    }
+    ctx->ol = ctx->xl;
+
     ctx->cur_insn_len = insn_len(opcode);
     /* Check for compressed insn */
     if (ctx->cur_insn_len == 2) {
-        ctx->opcode = opcode;
+        ctx->opcode = (uint16_t)opcode;
         /*
          * The Zca extension is added as way to refer to instructions in the C
          * extension that do not include the floating-point loads and stores
@@ -1149,15 +1173,16 @@ static void decode_opc(CPURISCVState *env, DisasContext *ctx, uint16_t opcode)
             return;
         }
     } else {
-        uint32_t opcode32 = opcode;
-        opcode32 = deposit32(opcode32, 16, 16,
-                             translator_lduw(env, &ctx->base,
-                                             ctx->base.pc_next + 2));
-        ctx->opcode = opcode32;
+        if (!is_4byte_align) {
+            /* Load last 2 bytes of instruction here */
+            opcode = deposit32(opcode, 16, 16,
+                               translator_lduw(env, &ctx->base,
+                                               ctx->base.pc_next + 2));
+        }
 
         for (guint i = 0; i < ctx->decoders->len; ++i) {
             riscv_cpu_decode_fn func = g_ptr_array_index(ctx->decoders, i);
-            if (func(ctx, opcode32)) {
+            if (func(ctx, opcode)) {
                 return;
             }
         }
@@ -1226,10 +1251,8 @@ static void riscv_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
     CPURISCVState *env = cpu_env(cpu);
-    uint16_t opcode16 = translator_lduw(env, &ctx->base, ctx->base.pc_next);
 
-    ctx->ol = ctx->xl;
-    decode_opc(env, ctx, opcode16);
+    decode_opc(env, ctx);
     ctx->base.pc_next += ctx->cur_insn_len;
 
     /* Only the first insn within a TB is allowed to cross a page boundary. */
-- 
2.17.1


