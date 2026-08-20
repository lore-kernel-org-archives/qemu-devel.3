Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C707FC5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 03:58:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwtl6-000631-EV; Wed, 19 Aug 2026 23:48:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtl4-0005sg-Dw
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:48:02 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtl2-0004Ln-FA
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:48:02 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-38e7109321dso1197443a91.3
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 20:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787197679; x=1787802479; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jbYaKFBvGXXY2CnicUYZq7lQqnHJQFU/m+HVMKAtotE=;
 b=MhSRqHLLeYwWT1S+8L6Kwgi7i1D7OHRp5ZoRqRYYAlT2Q96t8CycltJc2Uby+87oZA
 k0f0+uR+6ylIQfDqzNJHL6YR8K2vKo5SdMHCEmxv7qY5gALo+c4cG691nuQghSBzzv18
 oinnI7xMK76AVFJ+P9nbHHfV6RwzVrDaHXMtoz4gCctUy1rF/QNX4GlvknhC8wVV7R2r
 98VgsHlkE8s9FtxKotyIfSeuvrXcqx3Rj4NNmXW+RJAMGAbESAWUeIe4kkQ/2YsJnsB4
 KfxM2qTkimCnL26A+12ignPrCDRqzj1UXr5eK7On0kYIPZiduiVwVytStyo4pES3oKGN
 J2SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787197679; x=1787802479;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jbYaKFBvGXXY2CnicUYZq7lQqnHJQFU/m+HVMKAtotE=;
 b=jJqlUBMI0QAfIdOPEqY5iML0AIWU/7LTwBd5RVj5mSVMUa8xDnjXJ6vK+zxDZvXAi7
 x7byYuSquyhjWb9Tef+PhaGt/pY+hM7ZSaRQI6vu1yBpokhqDxcjdqho9fWDWSTX013f
 +9k8/eWFTW2li4ry9Xm8K+xBW4LmFOnN5LxmvFW//EA24O2l3XyeUG5iwSK2AYmqTg1s
 NMXxMraYKCLj4wRuSWMJwvh6NoLzAHp2vV2Kd7GaSEnu3JrCIN5QCbI3FZ6WdwFm7Ypb
 249M3cFjp/qUrNhe6k3lWmLP5vhnLXBptyZEq8KdGeH1ib657yyInPH4rxsQTZ36mQTE
 hWmQ==
X-Gm-Message-State: AFuF++kA202ZYHiEE1Yg4kpN382/lGE5L0u7kLELwF6krB+BeIUphxmx
 675sAuSwLDnY5VNDgPCEU20ovs+9/m0cZrMRUTm+7gzjUasgvPbpbkuUnL/+lQ==
X-Gm-Gg: AR+sD10rL6VvtWf4j+nzLBdvvSAc0xOKk/8kwCP2E0iio89b1x6gi6J4zK6hAqM8nfB
 OfI7xCB0J22k6iWIEHSSqdDO19TTzqVoL2ltOgqHy12Mqv9TfsL+HYXfbPQEIT/3thRlLJCqxC6
 D92AuzrFKt6ofWe0a41PcB8YYL0Z5FxNAzOgyR1mco7N8prHtjTvhamG3ioQlOTfv1Ej8jSrTkz
 bB2otztlymqtgn4uOtnKznG5GEPJez0i7uE2dpHlhrMctKLHx/F54PSpWqnKVtOsV2FiJcKuQYj
 0p+wG7LaZATTL50V9g/HVT8GDggzjIGwZ+tWtmaJ1QHch6JCYIN3UP46+qvpVnULmPJ6/jdY86t
 vwv5Vkeo3/0nSX2VrMsMgxMVRukZCMa3KXD8OaVYlT0v+5pJx0doLaNeBREC/4fUusrzU7xLpPy
 7T98z8onVF74VwyBtKRqELFUncJIt72sTZGwjdav2eQDx69kQ4mDe16uhKMG8Rdlvl8LB4/IknA
 Cp75Q==
X-Received: by 2002:a17:90b:6c6:b0:37f:b0a9:1a68 with SMTP id
 98e67ed59e1d1-395812a8bd9mr18527812a91.7.1787197679065; 
 Wed, 19 Aug 2026 20:47:59 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad6060asm19506735c88.6.2026.08.19.20.47.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 20:47:58 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 68/93] disas/riscv: Use rv_codec_illegal for pseudos
Date: Thu, 20 Aug 2026 13:44:05 +1000
Message-ID: <20260820034430.1186695-69-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820034430.1186695-1-alistair.francis@wdc.com>
References: <20260820034430.1186695-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1029.google.com
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

The codec is never used, since we arrive into pseudos
from a decoding of another opcode.
Assert that rv_codec_illegal is never decoded.
Use rv_codec_none for rv_op_illegal.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260812223142.349142-33-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.c | 68 +++++++++++++++++++++++++--------------------------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 7fa76b2d15..dedd925077 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -1599,7 +1599,7 @@ static uint32_t operand_lpl(rv_inst inst)
 /* instruction metadata */
 
 static const rv_opcode_data rvi_opcode_data[] = {
-    { "illegal", rv_codec_illegal, rv_fmt_none },
+    { "illegal", rv_codec_none, rv_fmt_none },
     { "lui", rv_codec_u, rv_fmt_rd_uimm },
     { "auipc", rv_codec_u, rv_fmt_rd_uoffset },
     { "jal", rv_codec_uj, rv_fmt_rd_offset, rvcp_jal },
@@ -1872,38 +1872,38 @@ static const rv_opcode_data rvi_opcode_data[] = {
     { "c.sq", rv_codec_cs_sq, NULL, DECOMP(rv_op_sq) },
     { "c.lqsp", rv_codec_ci_lqsp, NULL, DECOMP(rv_op_lq) },
     { "c.sqsp", rv_codec_css_sqsp, NULL, DECOMP(rv_op_sq) },
-    { "nop", rv_codec_i, rv_fmt_none },
-    { "mv", rv_codec_i, rv_fmt_rd_rs1, rvcp_mv },
-    { "not", rv_codec_i, rv_fmt_rd_rs1 },
-    { "neg", rv_codec_r, rv_fmt_rd_rs2 },
-    { "negw", rv_codec_r, rv_fmt_rd_rs2 },
-    { "sext.w", rv_codec_i, rv_fmt_rd_rs1 },
-    { "seqz", rv_codec_i, rv_fmt_rd_rs1 },
-    { "snez", rv_codec_r, rv_fmt_rd_rs2 },
-    { "sltz", rv_codec_r, rv_fmt_rd_rs1 },
-    { "sgtz", rv_codec_r, rv_fmt_rd_rs2 },
-    { "fmv.s", rv_codec_r, rv_fmt_frd_frs1 },
-    { "fabs.s", rv_codec_r, rv_fmt_frd_frs1 },
-    { "fneg.s", rv_codec_r, rv_fmt_frd_frs1 },
-    { "fmv.d", rv_codec_r, rv_fmt_frd_frs1 },
-    { "fabs.d", rv_codec_r, rv_fmt_frd_frs1 },
-    { "fneg.d", rv_codec_r, rv_fmt_frd_frs1 },
-    { "fmv.q", rv_codec_r, rv_fmt_frd_frs1 },
-    { "fabs.q", rv_codec_r, rv_fmt_frd_frs1 },
-    { "fneg.q", rv_codec_r, rv_fmt_frd_frs1 },
-    { "beqz", rv_codec_sb, rv_fmt_rs1_offset },
-    { "bnez", rv_codec_sb, rv_fmt_rs1_offset },
-    { "blez", rv_codec_sb, rv_fmt_rs2_offset },
-    { "bgez", rv_codec_sb, rv_fmt_rs1_offset },
-    { "bltz", rv_codec_sb, rv_fmt_rs1_offset },
-    { "bgtz", rv_codec_sb, rv_fmt_rs2_offset },
-    { "jal", rv_codec_none, rv_fmt_offset }, /* rv_op_jal_ra */
-    { "jalr", rv_codec_none, rv_fmt_rs1 }, /* rv_op_jalr_ra */
+    { "nop", rv_codec_illegal, rv_fmt_none },
+    { "mv", rv_codec_illegal, rv_fmt_rd_rs1, rvcp_mv },
+    { "not", rv_codec_illegal, rv_fmt_rd_rs1 },
+    { "neg", rv_codec_illegal, rv_fmt_rd_rs2 },
+    { "negw", rv_codec_illegal, rv_fmt_rd_rs2 },
+    { "sext.w", rv_codec_illegal, rv_fmt_rd_rs1 },
+    { "seqz", rv_codec_illegal, rv_fmt_rd_rs1 },
+    { "snez", rv_codec_illegal, rv_fmt_rd_rs2 },
+    { "sltz", rv_codec_illegal, rv_fmt_rd_rs1 },
+    { "sgtz", rv_codec_illegal, rv_fmt_rd_rs2 },
+    { "fmv.s", rv_codec_illegal, rv_fmt_frd_frs1 },
+    { "fabs.s", rv_codec_illegal, rv_fmt_frd_frs1 },
+    { "fneg.s", rv_codec_illegal, rv_fmt_frd_frs1 },
+    { "fmv.d", rv_codec_illegal, rv_fmt_frd_frs1 },
+    { "fabs.d", rv_codec_illegal, rv_fmt_frd_frs1 },
+    { "fneg.d", rv_codec_illegal, rv_fmt_frd_frs1 },
+    { "fmv.q", rv_codec_illegal, rv_fmt_frd_frs1 },
+    { "fabs.q", rv_codec_illegal, rv_fmt_frd_frs1 },
+    { "fneg.q", rv_codec_illegal, rv_fmt_frd_frs1 },
+    { "beqz", rv_codec_illegal, rv_fmt_rs1_offset },
+    { "bnez", rv_codec_illegal, rv_fmt_rs1_offset },
+    { "blez", rv_codec_illegal, rv_fmt_rs2_offset },
+    { "bgez", rv_codec_illegal, rv_fmt_rs1_offset },
+    { "bltz", rv_codec_illegal, rv_fmt_rs1_offset },
+    { "bgtz", rv_codec_illegal, rv_fmt_rs2_offset },
+    { "jal", rv_codec_illegal, rv_fmt_offset }, /* rv_op_jal_ra */
+    { "jalr", rv_codec_illegal, rv_fmt_rs1 }, /* rv_op_jalr_ra */
     { },
     { },
-    { "j", rv_codec_uj, rv_fmt_offset },
-    { "ret", rv_codec_i, rv_fmt_none },
-    { "jr", rv_codec_i, rv_fmt_rs1, rvcp_jr },
+    { "j", rv_codec_illegal, rv_fmt_offset },
+    { "ret", rv_codec_illegal, rv_fmt_none },
+    { "jr", rv_codec_illegal, rv_fmt_rs1, rvcp_jr },
     { "rdcycle", rv_codec_i_csr, rv_fmt_rd },
     { "rdtime", rv_codec_i_csr, rv_fmt_rd },
     { "rdinstret", rv_codec_i_csr, rv_fmt_rd },
@@ -4551,8 +4551,6 @@ static void decode_inst_operands(rv_decode *dec, rv_isa isa,
     rv_inst inst = dec->inst;
 
     switch (op->codec) {
-    case rv_codec_illegal:
-        break;
     case rv_codec_none:
         dec->rd = dec->rs1 = dec->rs2 = rv_ireg_zero;
         dec->imm = 0;
@@ -4946,7 +4944,9 @@ static void decode_inst_operands(rv_decode *dec, rv_isa isa,
         dec->rs1 = dec->rs2 = operand_crs1(inst);
         dec->imm = 0;
         break;
-    };
+    default:
+        g_assert_not_reached();
+    }
 }
 
 /* check constraint */
-- 
2.54.0


