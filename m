Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D747E87834
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 15:06:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnHz1-0003T5-Pd; Tue, 03 Feb 2026 10:06:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnHyt-00037U-M2
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:06:21 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnHys-0002HZ-1x
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:06:19 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-47ee07570deso48386515e9.1
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 07:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770131176; x=1770735976; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2hF09Gen+VULUnd3BGkuvBLWmpsNvNE9emvDOfPH3pc=;
 b=CWLQh8HtZvwE5AMJte3m8EeVM3DUXIkCDL2vP1RjTzDgLO3WT94uM1hhDvCEgjDJ6u
 kYGs4MZARnvZtVJmIC1gQW1lgCgvgx8z+t9RCstEvEpc/I11YuGleiuF8FUvPFRN4GYX
 arZwbsELPcsuCYxvyBwFuESWFxolzOlffyPf0rELwq+f0YGAmiZND1Oru2dQboHo4ovr
 nRCq3OEFca8Ya3spMeabGk2obvukCI9Ty/0eauE/tdCrcZf5/x8Sj4csx3uZBlEl46b7
 a9tCOEwejxFDkbSltH1G8799fTjGS1PYcEwlyWUTNGjjFiSqsqBAEFF87SBI34oeAFOk
 EwCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770131176; x=1770735976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2hF09Gen+VULUnd3BGkuvBLWmpsNvNE9emvDOfPH3pc=;
 b=J/sHzl3HpPhcOXuse99/umEchuqWiHOn/ACroUHsEyacXb6BhexNwOrV6Vj9j1BDFy
 BF28ztPv+wS2Woh0C2VEbcufwS+T2bw/IEtMzqNFqhNYop8HJIL/vSQhvA221iLygbPn
 oJtiLFXBCFaZ3MCt5L8/v+oUun6W/4h9yqOOSPlnk96WbEIXinZKfdPyiv4eUzrFsW8G
 g1gC0ssgXKSqhDX5/5MukoGiz6Bt2nD7laXtDFBCkLiG5tuLvz0EEwH2W5k1wo2yu02E
 PNKxPsBDsvsHLMDY4LEti5Gjn23U9ObGseK6eD1RkAzRuWtyl/SyAZ9EBHv6IV5CrP7k
 0ACQ==
X-Gm-Message-State: AOJu0Yxj/mej13Hx7F5xky4SXWiEgRyrRDxqOyx+rDiMyIEtORcMwTjC
 MCnUcp1YPHray2M4wbp8gBQZ9NR/mR3DF77rICMS1M5PmtKmdMOf1nIxIzYAx9CBE27z1xaWwgS
 WYN/T/Uo=
X-Gm-Gg: AZuq6aLl9lNq9s4nwLuyB71+SYgRBbgWaRW926PlS1Y2+5S3W4CkM5BuJTFEJjLY+WI
 d1UKizohI1vFruojAQe6LbThCz2XiRUjy/Oke5l47NAD0aSvl709QVb2x3O3QCG/FpA7/7IC1mD
 eGbkT/EPHsuQ1ivaAebvGZuAgf9DfVaT2igRT6NF59jLWFpYwxGmjf3IH0nhNxOKNWB+e32Gmig
 2i37t9hhWYwl1AGucDTL05v2m7qaUZiVZzylsVBAhhvtG1QQKKXxa1CF1WCJ7CvpmaRjxGMfvH6
 OZ94dn3jYHJEffIcQEyCxgYdSXZ/+o1/V6a6uP52S4lxMaGF6KDIF0sXWE0rbFlA03WyKegJtSm
 1NQaovlWAvB+W6yTP+qub7Wo8+iokQnV1CaemBFaog+JFm6kUJBnlLl3tgWOCkZSfbK+5j0VTls
 /bRG2Ymk/dfATDWGCyUnWmonDZxyKlvwjU4JV5h1ZHCDvabw1HANLyFwwcqUe5
X-Received: by 2002:a05:6000:1865:b0:430:ff0c:35fb with SMTP id
 ffacd0b85a97d-435f3aae00fmr24094635f8f.52.1770131176012; 
 Tue, 03 Feb 2026 07:06:16 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10e483asm50966286f8f.3.2026.02.03.07.06.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Feb 2026 07:06:15 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/30] target/riscv: Inline translator_ld[uw,l,q]() calls
Date: Tue,  3 Feb 2026 16:04:19 +0100
Message-ID: <20260203150436.71907-15-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203150436.71907-1-philmd@linaro.org>
References: <20260203150436.71907-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260202213810.97141-1-philmd@linaro.org>
---
 target/riscv/translate.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 4a2c08243d1..cb4f4436018 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1254,13 +1254,16 @@ static void decode_opc(CPURISCVState *env, DisasContext *ctx)
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
 
@@ -1280,8 +1283,9 @@ static void decode_opc(CPURISCVState *env, DisasContext *ctx)
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
 
@@ -1396,7 +1400,8 @@ static void riscv_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
 
             if (page_ofs > TARGET_PAGE_SIZE - MAX_INSN_LEN) {
                 uint16_t next_insn =
-                    translator_lduw(env, &ctx->base, ctx->base.pc_next);
+                    translator_lduw_end(env, &ctx->base, ctx->base.pc_next,
+                                        mo_endian(ctx));
                 int len = insn_len(next_insn);
 
                 if (!translator_is_same_page(&ctx->base, ctx->base.pc_next + len - 1)) {
-- 
2.52.0


