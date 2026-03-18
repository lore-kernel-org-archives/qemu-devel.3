Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C72610706E8
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 10:34:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2oDH-0003lX-O2; Wed, 18 Mar 2026 06:33:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2oDF-0003gI-I3
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 06:33:17 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2oDE-0002YW-18
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 06:33:17 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-43b4fd681c2so1250513f8f.3
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 03:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773829994; x=1774434794; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n2Sgkb6N71I15zCHePybcfBnW8R6vfuIZgllQvpx1Uc=;
 b=GkkJ4TDnF9A87W6rNQdnATqlDm3l5jlXP6PMIH2+xqzgEdHtKLQH3S0OyDGfG9qa91
 aPjzfKrxECWCoOXoLluhAT3HhI1qHB4BFYAxSPFbRMS1eqBnX8b8ATwsmnIy2ZPVatyM
 A5zssta5AIw0LLzXco/Jn2Fl0fvyrr3Z7hAIna8jKJB/2BwjJmJy2yRHDJ/mqWSRbUHZ
 we1L3Xd3NbvPHi/ocAtJQO1CiJv2MLzLc8LE5H0djaQRVb0HjCcZB6AH5RYguGFKwt2I
 mAy8GfGvEnQBfKpWQV9u0l8Fz21gngrAjOcOqEeNJVloOJoCYqDrK9k/++5Y/F+3zGgy
 YCfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773829994; x=1774434794;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=n2Sgkb6N71I15zCHePybcfBnW8R6vfuIZgllQvpx1Uc=;
 b=lSmgj+N4tlhKnlX67NwGoEzKgxVlAKjv0bYmJSPMLb7vopQeNDJ9f3PJ8baYjhbX85
 jWPXilEKONJEeDUTv25tv5rgqtSxTp4Zns+n+dTM3fe1Wp1VAIVefZs2uNUDwtZDsbRk
 zl7LGixhZOBAmZUmQ5mo4LmKcGKvVp0mj3kBG+eF/bmVxwAKtE+KxOBLQiV46MTIOUVx
 Lf9v8kP0tqNUmD6/d9NsyYqpoExKgA9OiAC1HBrHFmHRsPsJQAWWanBzr1/Dw8TtajKO
 nXoriSGS215AeMUPvodPK+ajrMWW5SedTeGrPRv1CgbBppN0pL2jsXxr8SmBXBnidFu1
 TBZw==
X-Gm-Message-State: AOJu0YzvkU8J1gzgKNEoMK04ZkNLl0RJEdrsfykPx/m+S2t47YCUxJ7N
 Ismf/OmsvCesdBqC7PVpi6bnGaGL7j/v0iZ+BE04qFtC0YH4XxbPeRH0NJc7El2hr0/Emz7sez+
 UM4ATbVA=
X-Gm-Gg: ATEYQzxy2yo9rfOgoamAhkOAbqL/RCMNsXts2PCh/xiLoWZvqEV9vEOeEQ0EWCnYWTI
 roH8pP1ISMyL0LCr3eBag6Dpi6SrHPeu8V4VGYHC9QTKDuPftYstniSBOAKu4qNrkyCEa+f/2Ar
 u3Bzir3JrI+J81KPh3xrGrbXkeH7OzwFUL8iQUJKk4Vqe6a/w0GpNIrTaOB6RL9rtw5iyxKiSQy
 gP0kEYztWiODq80V4UMXam1boyd2qz4WRvN5ZEbJwyfrC2XQbbfEiZPqd0kGEYjn4RAGQusItUn
 VNZg8ZdXLnLAAXPF/Dxekt5i36HJAUZvaAF/8Oc5vg8pybTQS3IzFZIFYFLjUQPrgl6IiKQW7im
 zBK1Iv12YeNXqNAeImpLFXqLw/kuOKEUU87JsHT8RfwMMZCzFNt/PoYo6J2Ooj4yc3BPxS4g9u4
 Dds4E1324ENab+D5ckrFEgFJ2MKCx7YDT3oGFP5kmNS5nlqyy6AxqQ31Vu25VFhG2sLGJGGRrm
X-Received: by 2002:a05:6000:24c3:b0:439:b55d:b0e5 with SMTP id
 ffacd0b85a97d-43b527c4301mr4406646f8f.28.1773829994167; 
 Wed, 18 Mar 2026 03:33:14 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b5189971asm6778525f8f.30.2026.03.18.03.33.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 18 Mar 2026 03:33:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Weiwei Li <liwei1518@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Warner Losh <imp@bsdimp.com>, =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20P=C3=A9trot?=
 <frederic.petrot@univ-grenoble-alpes.fr>, 
 Vijai Kumar K <vijai@behindbytes.com>, Anton Johansson <anjo@rev.ng>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-riscv@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH-for-11.1 15/16] target/riscv: Use MO_LE for instruction fetch
Date: Wed, 18 Mar 2026 11:31:20 +0100
Message-ID: <20260318103122.97244-16-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318103122.97244-1-philmd@linaro.org>
References: <20260318103122.97244-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>

RISC-V instructions are always little-endian regardless of the data
endianness mode configured via mstatus SBE/MBE/UBE bits.

Currently, instruction fetches in decode_opc() and the page boundary
check use mo_endian(ctx), which returns MO_TE. This happens to work
today because RISC-V targets are little-endian only, but is
semantically incorrect and will break once mo_endian() is updated to
respect runtime data endianness for big-endian support.

Use MO_LE explicitly for all instruction fetch paths. Data memory
operations (AMOs, loads/stores via mxl_memop) continue to use
mo_endian(ctx) as they should respect the configured data endianness.

Not-Signed-off-by: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260311115910.564481-3-djordje.todorovic@htecgroup.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/translate.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 6f8b8e9d19a..5df5b738495 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1255,7 +1255,7 @@ static void decode_opc(CPURISCVState *env, DisasContext *ctx)
          * additional page fault.
          */
         opcode = translator_ldl_end(env, &ctx->base, ctx->base.pc_next,
-                                    mo_endian(ctx));
+                                    MO_LE);
     } else {
         /*
          * For unaligned pc, instruction preload may trigger additional
@@ -1263,7 +1263,7 @@ static void decode_opc(CPURISCVState *env, DisasContext *ctx)
          */
         opcode = (uint32_t) translator_lduw_end(env, &ctx->base,
                                                 ctx->base.pc_next,
-                                                mo_endian(ctx));
+                                                MO_LE);
     }
     ctx->ol = ctx->xl;
 
@@ -1285,7 +1285,7 @@ static void decode_opc(CPURISCVState *env, DisasContext *ctx)
             opcode = deposit32(opcode, 16, 16,
                                translator_lduw_end(env, &ctx->base,
                                                    ctx->base.pc_next + 2,
-                                                   mo_endian(ctx)));
+                                                   MO_LE));
         }
         ctx->opcode = opcode;
 
@@ -1401,7 +1401,7 @@ static void riscv_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
             if (page_ofs > TARGET_PAGE_SIZE - MAX_INSN_LEN) {
                 uint16_t next_insn =
                     translator_lduw_end(env, &ctx->base, ctx->base.pc_next,
-                                        mo_endian(ctx));
+                                        MO_LE);
                 int len = insn_len(next_insn);
 
                 if (!translator_is_same_page(&ctx->base, ctx->base.pc_next + len - 1)) {
-- 
2.53.0


