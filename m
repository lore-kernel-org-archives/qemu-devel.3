Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE79EC5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 03:59:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwtlr-0007FT-46; Wed, 19 Aug 2026 23:48:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtlo-0007EM-1N
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:48:49 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtlm-0004RW-Bm
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:48:47 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-cbedda4c154so820518a12.1
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 20:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787197725; x=1787802525; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=82rer5v+mUlWOAXCYhpssgxoxfjq1dcBWXCAHZ6HX8I=;
 b=S0OkqLl+dorr3DX+IpDQ96y3kqvEOeLPZa+9n7gJRodtQ8eDwMmiZ9q29nigNDm+s6
 7W6wCqEyqIM5je3xm4w9COPTLJqWfoddv25GzHI0qRy0L0FUUR78vExgOZMFNz8f/rd6
 7laaXiHYyAJA29qax16FYbOwzptG8e9BQi8sWeL7rMq3f/McgUVzSxMOgV5I1h8uX9ZS
 TWPYQ3NyFCsvo26gLg1lU0aFiBGXFKjt74b7uW3I5Aa7e6BQaRsNJbfvp/iQdVJ8DZbM
 D4/ZvxL4zaIlFIZiR+5hj7oFP1OoWJch/BNnjTBZsMdL3o+zdEW4rV282/TPC/TLcOzK
 tAdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787197725; x=1787802525;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=82rer5v+mUlWOAXCYhpssgxoxfjq1dcBWXCAHZ6HX8I=;
 b=nNty/m7Emkq25Qx2i1KWe/cNFJ0nxmppbjpN0U6MeVfI48V2+BcV5ClAyLFItIb97d
 EoeMa0KU4S1pB/j0x4eQ7wUQV20wMt7LDOldGNUWaXuIWfWGvTP0bJmQuZEqZeZ1RCPL
 rO1Q3EpEKa2FWflPZymn7aNCqI/r/mDyfWNx+wrIIjIdxG3ilmB+gnL9kaZ1XUCzyLJ2
 JlWz1uq2r4Zr9b7ZQtM/RMky+FapkIyCcdlU9KI2iU4R8/06zOM7psjy4Eqk4nq8Zycu
 OkwlSWw+M3S2SsWSU3QhbuYXIb9+HM7YdqJttm1tdocYxlwCj1/jTjBMtT/E/T/phfL1
 Y02w==
X-Gm-Message-State: AOJu0YwDcdX+rBSlBgHH7DqkCx9WecSwa9Uv66l0Y/gGVwndHnzMH5Xd
 snA6NMmHS8Vt5mlw0Gtn21W8AjfAA/RuX1D9ybikkT8ztSjXacsqyTCVh6bvEg==
X-Gm-Gg: AR+sD10uH4cFA3UxYB2KawZOppW9b0EhdT0e3BgonfztptiUQQ7yIMDbrSsW9pwhts7
 DCiW5iEyR+5ZqSbQ9wEjOrMQ+z5cERU4KI4YDbUNpvFYkke/6i7KqByuyikrzjduf8wey6xLort
 ySD/32J5PDCveyqLrxRuqGsP1Yt06xBnkaQSf5FvSHGbIplbM0p8JHC4/tZV22ZXOuIlXVMMkQZ
 cMCc3WXXLrUAUs2oVV1ke6uvadkQtRp2Gi2TJBl36uhzl+lRkwcAzUlxFqnyj/SBk9PdeUaX91v
 INb6Ctd9cXy2PY4klf7B1MybEE8eLxcB11+Tqw1qVkDn90lO+GgC8K0KlChVl137Yhahk/wTt8E
 g5eWPTeOVZ4l7+Njgt+rrMZwcRdO/RZAOscaRpZ6q0J6A569dwiTX6iwPfnhZPVV6jc8N4FFEsO
 f8Lurlx+BX+XVDHVRN6Phgf+TvEJqEe9h2ZxkaUNYufu8ZKGVyNtwifNQpz5dOLcOSVqPdxpBma
 13AiiTxfnVgZOvn
X-Received: by 2002:a05:6a20:3ca1:b0:3c3:66c5:68d6 with SMTP id
 adf61e73a8af0-3cd00f77410mr17385415637.9.1787197724920; 
 Wed, 19 Aug 2026 20:48:44 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad6060asm19506735c88.6.2026.08.19.20.48.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 20:48:44 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 84/93] disas/riscv: Merge all c.mop.n to one pattern
Date: Thu, 20 Aug 2026 13:44:21 +1000
Message-ID: <20260820034430.1186695-85-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820034430.1186695-1-alistair.francis@wdc.com>
References: <20260820034430.1186695-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Richard Henderson <richard.henderson@linaro.org>

Avoid performing arithmetic on rv_op_c_mop_1.
Treat the 'n' as an immediate.
Create a codec and format to match.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260812223142.349142-49-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.h        |  2 ++
 disas/riscv.c        | 10 +++++++++-
 disas/riscv-op.c.inc |  9 +--------
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/disas/riscv.h b/disas/riscv.h
index 47647f750f..b0269bb709 100644
--- a/disas/riscv.h
+++ b/disas/riscv.h
@@ -159,6 +159,7 @@ typedef enum {
     rv_codec_r2_imm2_imm5,
     rv_codec_fli,
     rv_codec_lp,
+    rv_codec_cmop,
     rv_codec_cmop_ss,
     rv_codec_mop_r,
     rv_codec_mop_rr,
@@ -286,6 +287,7 @@ typedef struct {
 #define rv_fmt_rd_rs1_immh_imml_addr  "O\t0,(1),i,j"
 #define rv_fmt_rd2_imm                "O\t0,2,(1),i"
 #define rv_fmt_fli                    "O\t3,h"
+#define rv_fmt_cmop                   "O.i"
 #define rv_fmt_mop_r                  "O.i\t0,1"
 #define rv_fmt_mop_rr                 "O.i\t0,1,2"
 
diff --git a/disas/riscv.c b/disas/riscv.c
index 22104638e1..39235e5bc7 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -643,6 +643,11 @@ static uint32_t operand_lpl(rv_inst inst)
     return extract32(inst, 12, 20);
 }
 
+static uint32_t operand_cmop_imm(rv_inst inst)
+{
+    return extract32(inst, 8, 3) * 2 + 1;
+}
+
 static uint32_t operand_mop_r_imm(rv_inst inst)
 {
     return (extract32(inst, 30, 1) << 4) |
@@ -1027,7 +1032,7 @@ static const rv_opcode_data *decode_inst_opcode(rv_decode *dec, rv_isa isa)
                     (((inst >> 11) & 0b11) == 0b0)) {
                     unsigned int cmop_code = 0;
                     cmop_code = ((inst >> 8) & 0b111);
-                    op = rv_op_c_mop_1 + cmop_code;
+                    op = rv_op_c_mop;
                     if (dec->cfg->ext_zicfiss) {
                         op = (cmop_code == 0) ? rv_op_c_sspush : op;
                         op = (cmop_code == 2) ? rv_op_c_sspopchk : op;
@@ -3056,6 +3061,9 @@ static void decode_inst_operands(rv_decode *dec, rv_isa isa,
     case rv_codec_lp:
         dec->imm = operand_lpl(inst);
         break;
+    case rv_codec_cmop:
+        dec->imm = operand_cmop_imm(inst);
+        break;
     case rv_codec_cmop_ss:
         dec->rd = rv_ireg_zero;
         dec->rs1 = dec->rs2 = operand_crs1(inst);
diff --git a/disas/riscv-op.c.inc b/disas/riscv-op.c.inc
index 2100e54475..802a521bca 100644
--- a/disas/riscv-op.c.inc
+++ b/disas/riscv-op.c.inc
@@ -875,14 +875,7 @@ OP(amocas_d, "amocas.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
 OP(amocas_q, "amocas.q", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
 OP(mop_r, "mop.r", rv_codec_mop_r, rv_fmt_mop_r)
 OP(mop_rr, "mop.rr", rv_codec_mop_rr, rv_fmt_mop_rr)
-OP(c_mop_1, "c.mop.1", rv_codec_ci_none, rv_fmt_none)
-OP(c_mop_3, "c.mop.3", rv_codec_ci_none, rv_fmt_none)
-OP(c_mop_5, "c.mop.5", rv_codec_ci_none, rv_fmt_none)
-OP(c_mop_7, "c.mop.7", rv_codec_ci_none, rv_fmt_none)
-OP(c_mop_9, "c.mop.9", rv_codec_ci_none, rv_fmt_none)
-OP(c_mop_11, "c.mop.11", rv_codec_ci_none, rv_fmt_none)
-OP(c_mop_13, "c.mop.13", rv_codec_ci_none, rv_fmt_none)
-OP(c_mop_15, "c.mop.15", rv_codec_ci_none, rv_fmt_none)
+OP(c_mop, "c.mop", rv_codec_cmop, rv_fmt_cmop)
 OP(amoswap_b, "amoswap.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
 OP(amoadd_b, "amoadd.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
 OP(amoxor_b, "amoxor.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
-- 
2.54.0


