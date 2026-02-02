Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A49C7E7FDEE
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 21:38:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn1ce-00065D-T7; Mon, 02 Feb 2026 16:38:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn1cd-00064u-N2
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 16:38:15 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn1cc-0002l3-5w
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 16:38:15 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-47ee07570deso41104965e9.1
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 13:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770068292; x=1770673092; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2S81V/4tr5nwqUUmJ1CeXS0wHIUdiHnIFbf5Q+wPrK0=;
 b=KyBG65JcfI1tlkuVenthD+DfYiCd4un7gJSED/+2IFWTu8WS0dpJdtSzmYJ5zrAGWM
 J4rjDuSMwsuIhy3/jSAUCn2V1ZCu/HfjfClnbj1T4+WFhrCYZh4kHff/JoQk+AG2CdN1
 o/yyHEdThzQwW7E7wvgVa/YAEpE+LUQXbqSBcTm4UzRHEVRo8ijCfOX/tKv7LK3MkdaM
 0RtoqmTs7WDtvZRmkBVKUnrwjhys960amhjKBAxuPwzUYmsNBKtffPo1xtZhk9JoqbqY
 CEHwLOJxRwNf3KDS5bIIxkQP1GprVLqyngVmNDtIIXAtoHF/ujPxUiJfn/6Jti8ycmeM
 EgNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770068292; x=1770673092;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2S81V/4tr5nwqUUmJ1CeXS0wHIUdiHnIFbf5Q+wPrK0=;
 b=REM+L79FKsGYu2YO07p7aJWekm6iLdTMzyb5ir9Lz1g2MNBXWk2KJFbxzPzepdtGGs
 mIBUKuoDTa2/KAsVLDYHr5chn97C8IXcFF7t+Qh/N/97WjFxlp0MNvjfysqyp/Ipcggk
 kwmakiJCgQrPFCQatfe2LNnafiimdBqWemUJ0af75SG/oXlYhHpnQQAmS25SOeycvR7+
 P/QwJWwV7V6FbqK1sPTe2m5bwnNcVNnObdpf9fLs1hkPh69PfZlk/p1Iv8xb2xHUfQXT
 e3Bwrk3FbBA2olGpWUHYjj1fmbM93c3VWKYBmwPELw96mhwtaret8JfL+dk/apzCQd1w
 S8AQ==
X-Gm-Message-State: AOJu0YxnoF8l+jhHJ8/RlvCNYSH9IxaMXa06yVbRQDg9uKOe0/1GXvGv
 OeTwGJI3hmhrzaIxph7Su/syBgcN3OLbShOgsn391cmbMSoBw7iCI6+zgBJ1FvA6KimcFt5FZq4
 nKLA0YfE=
X-Gm-Gg: AZuq6aI+42/qepdRcJIdXjfbou97UylYc8DeSEfBfVLRW/zjkysqALiB/vsBX+q8rYU
 8X8EEKgkPHBHIZNMtvRUMz4r9V3tmseuZ5Vdn6Kgr7O2EjJvLAVinLtL7Zf5N2gHZ65o7Ux05Qr
 5r5JhkZqsjjgwMoqSwO0MhfqiuAquBeviOPFT76Dxtild8ZsMOlAfeQjbL+Z4I0poPMzxbdxenR
 lz66ADm6ESAtfT2biNCoHfe/d8i/uCYytlqsVOWaY9j6RYjI9Y6ouSDgr/dXA1rPUbvIo1KbnBd
 KudFVgnz/VwkR21X/69AevxGgVATw/e9xQ02Wrf4qr4BL9dSpsDEwpPykEBcu3Y+cJ1XIJLAWjw
 dpa2tFzUXeZShronWpSUsACFb7CjXWWL9N14IL9Pgr3n5XpsAmpMDqvj+OCIHH+eFORlwBlLFa2
 CRCA28VMQ+FLL4WA5JKwQOjCIHCQofGOcZg82d8uXqD/uoCv2U19026zbxbspsAYK9SfN/2ik=
X-Received: by 2002:a05:600c:4ec7:b0:47d:586e:2fea with SMTP id
 5b1f17b1804b1-482db46b38dmr175629635e9.15.1770068292353; 
 Mon, 02 Feb 2026 13:38:12 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4830511c049sm25780365e9.1.2026.02.02.13.38.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 02 Feb 2026 13:38:11 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] target/riscv: Inline translator_ld[uw,l,q]() calls
Date: Mon,  2 Feb 2026 22:38:10 +0100
Message-ID: <20260202213810.97141-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
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
inline them for the RISC-V targets, using mo_endian(ctx) -- which
we introduced in commit 504f7f304ff -- instead of MO_TE.

Mechanical change using the following Coccinelle 'spatch' script:

    @@
    expression env, db, pc, do_swap;
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
---
 target/riscv/translate.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index f687c75fe43..d8261aeb662 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1253,13 +1253,16 @@ static void decode_opc(CPURISCVState *env, DisasContext *ctx)
          * real one is 2 or 4 bytes. Instruction preload wouldn't trigger
          * additional page fault.
          */
-        opcode = translator_ldl(env, &ctx->base, ctx->base.pc_next);
+        opcode = translator_ldl_end(env, &ctx->base, ctx->base.pc_next,
+                                    mo_endian(ctx));
     } else {
         /*
          * For unaligned pc, instruction preload may trigger additional
          * page fault so we only load 2 bytes here.
          */
-        opcode = (uint32_t) translator_lduw(env, &ctx->base, ctx->base.pc_next);
+        opcode = (uint32_t) translator_lduw_end(env, &ctx->base,
+                                                ctx->base.pc_next,
+                                                mo_endian(ctx));
     }
     ctx->ol = ctx->xl;
 
@@ -1279,8 +1282,9 @@ static void decode_opc(CPURISCVState *env, DisasContext *ctx)
         if (!pc_is_4byte_align) {
             /* Load last 2 bytes of instruction here */
             opcode = deposit32(opcode, 16, 16,
-                               translator_lduw(env, &ctx->base,
-                                               ctx->base.pc_next + 2));
+                               translator_lduw_end(env, &ctx->base,
+                                                   ctx->base.pc_next + 2,
+                                                   mo_endian(ctx)));
         }
         ctx->opcode = opcode;
 
@@ -1395,7 +1399,8 @@ static void riscv_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
 
             if (page_ofs > TARGET_PAGE_SIZE - MAX_INSN_LEN) {
                 uint16_t next_insn =
-                    translator_lduw(env, &ctx->base, ctx->base.pc_next);
+                    translator_lduw_end(env, &ctx->base, ctx->base.pc_next,
+                                        mo_endian(ctx));
                 int len = insn_len(next_insn);
 
                 if (!translator_is_same_page(&ctx->base, ctx->base.pc_next + len - 1)) {
-- 
2.52.0


