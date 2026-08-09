Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1FE3C5AD5A
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2026 22:37:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtC89-0001EU-25; Sun, 09 Aug 2026 18:36:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtC86-00017y-Rv
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 18:36:30 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtC84-0007UU-PM
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 18:36:30 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-8486ac3f347so3692602b3a.1
 for <qemu-devel@nongnu.org>; Sun, 09 Aug 2026 15:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786314987; x=1786919787; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jTnbwB3ZjFBmtG/6Evru0wejD5SNYguS+V+BNTqQ//E=;
 b=DqdpO9YYBQWkTFXR1mXFtsiGA0ABHwgVCMqxoawMsa1E+B9LG/3OdiioeAQVYjPL//
 N775/6pOA0GPOGn1y7az1ftkRrhYuQcvLO2suqn6xosCn1PfoYfgizjOkcy9zfb8ZXHz
 5IYIFbGxdfEPn1cusWcafcULgyT05Lo+oDX7pX3N700S1AbldVKilkJDIF2Bf1J3Tun1
 ThWqTctOfstO4Dxx1DLjac0a+RtBq7B6AQwS6rLKGsctfgdLxsGUiGw6YwRPt8JbFKmX
 +RTS51OsTb8SZvBrbzyVDAqEruqYz/gmTAZgUOZ2Mqo9NlCj6xN1UFTbU5LPLCz0F08j
 v6nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786314987; x=1786919787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jTnbwB3ZjFBmtG/6Evru0wejD5SNYguS+V+BNTqQ//E=;
 b=EJ4JrPNbdAxBZvTGPAYG2zPwjC6nDuINYCZ1bS9XItuBKN95yKRrmod/dKgImixfPm
 3G91Q876JhfefSLktJBv7RIrBD5C9Lm1w7R7mWYsG8BCNdC31yK+1v/bfN82WdWv6Gn2
 EKOhLkQMACqrycLg6gK41VDk8oGZMm9cQSCPZgtw+ZaMrBBvQI8zv1eYukWN+T1gmP85
 L5DCDkS9IsJ6q+7sSOfP58svF/ctKAF3DpQb6wjw9IArbTDbVRA3Q+5pTDY9osEB37aJ
 rl7wk4/qb6s8c5s5pBsNI3MhRSiBr+i5SB+3UQRrCd4gNdG55ROb9qSscTIitu91bovf
 70Cg==
X-Gm-Message-State: AOJu0YyaTdTmMaxhi0d4Iw3p/DCYv+e47fJIYopsvOFAKcp7EyYltth5
 UvKNKLNtmwvnQkrpJMMJ34U8NKc+J5N0/q5tKPCDxh5KTY473+nQYdTCyzOiPc+0Qerwdpr9wCa
 Jlvol
X-Gm-Gg: AR+sD10H49IPtRS+MAYhc71knHAx/2qwzes8M3l+ja84cKEtxBq/AoTFNHmrIAWzs39
 XRmrSVZIY9maD5xV3hWmO8mY+awV4yqi4AT2exNS2wa0b3bKx9Vs/T/RIJ2iDkLaLxWfRXIkBMe
 053AwMPCSB5HiCfC825CiJCeqZkWEQ9O74Wm27POiZbgespvSjfQlr/USLUhmmQdl0c24jRkhWC
 O2oivSIkRX6dQZmzLrFHLeVWlkXzEj4I590fRJIpCl3/gesDMBGMSvt5vt8kG+PwAC+ZdfHoiUZ
 VwrY4C6/CE/tpK3ZDJGbbMAOIB8ReXS5lLacC4EE1UDPHrZM7rdUWn+LU9pVyIgqoGDLNBc6/uO
 i3vqTPbiGPX7/AGfE4Sy1qby5n/xbQorpyEPjicqgCCO65MJBM79BJXOpUBbmGRuM7Vm4freRHo
 Zm2N3/Noj1wlRbdDQvah7kNXLCNtn6JDA8L60N5B2cZeBWFZbc9BJfnvnaCvWftM0hb/NxRzzLY
 bOqrqKXnZGEXZfpccPe
X-Received: by 2002:a05:6a21:a44:b0:3b4:661d:8405 with SMTP id
 adf61e73a8af0-3cbd3738fe8mr17712000637.4.1786314987232; 
 Sun, 09 Aug 2026 15:36:27 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbe8f19ace6sm2998102a12.2.2026.08.09.15.36.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 15:36:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Subject: [PATCH 33/56] disas/riscv: Drop format from DECOMP insns
Date: Sun,  9 Aug 2026 15:35:22 -0700
Message-ID: <20260809223545.730664-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260809223545.730664-1-richard.henderson@linaro.org>
References: <20260809223545.730664-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

The format for these will never be used -- we will use
the format from the decompressed insn.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/riscv.c | 94 +++++++++++++++++++++++++--------------------------
 1 file changed, 47 insertions(+), 47 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 129e545c6e..9904b4db03 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -1819,52 +1819,52 @@ static const rv_opcode_data rvi_opcode_data[] = {
     { "fcvt.q.lu", rv_codec_r_m, rv_fmt_rm_frd_rs1 },
     { "fmv.x.q", rv_codec_r, rv_fmt_rd_frs1 },
     { "fmv.q.x", rv_codec_r, rv_fmt_frd_rs1 },
-    { "c.addi4spn", rv_codec_ciw_4spn, rv_fmt_rd_rs1_imm, DECOMP(rv_op_addi) },
-    { "c.fld", rv_codec_cl_ld, rv_fmt_frd_offset_rs1, DECOMP(rv_op_fld) },
-    { "c.lw", rv_codec_cl_lw, rv_fmt_rd_offset_rs1, DECOMP(rv_op_lw) },
-    { "c.flw", rv_codec_cl_lw, rv_fmt_frd_offset_rs1, DECOMP(rv_op_flw) },
-    { "c.fsd", rv_codec_cs_sd, rv_fmt_frs2_offset_rs1, DECOMP(rv_op_fsd) },
-    { "c.sw", rv_codec_cs_sw, rv_fmt_rs2_offset_rs1, DECOMP(rv_op_sw) },
-    { "c.fsw", rv_codec_cs_sw, rv_fmt_frs2_offset_rs1, DECOMP(rv_op_fsw) },
+    { "c.addi4spn", rv_codec_ciw_4spn, NULL, DECOMP(rv_op_addi) },
+    { "c.fld", rv_codec_cl_ld, NULL, DECOMP(rv_op_fld) },
+    { "c.lw", rv_codec_cl_lw, NULL, DECOMP(rv_op_lw) },
+    { "c.flw", rv_codec_cl_lw, NULL, DECOMP(rv_op_flw) },
+    { "c.fsd", rv_codec_cs_sd, NULL, DECOMP(rv_op_fsd) },
+    { "c.sw", rv_codec_cs_sw, NULL, DECOMP(rv_op_sw) },
+    { "c.fsw", rv_codec_cs_sw, NULL, DECOMP(rv_op_fsw) },
     { },
-    { "c.addi", rv_codec_ci, rv_fmt_rd_rs1_imm, DECOMP(rv_op_addi) },
-    { "c.jal", rv_codec_cj_jal, rv_fmt_rd_offset, DECOMP(rv_op_jal) },
-    { "c.li", rv_codec_ci_li, rv_fmt_rd_rs1_imm, DECOMP(rv_op_addi) },
-    { "c.addi16sp", rv_codec_ci_16sp, rv_fmt_rd_rs1_imm, DECOMP(rv_op_addi) },
-    { "c.lui", rv_codec_ci_lui, rv_fmt_rd_uimm, DECOMP(rv_op_lui) },
-    { "c.srli", rv_codec_cb_sh6, rv_fmt_rd_rs1_imm, DECOMP(rv_op_srli) },
-    { "c.srai", rv_codec_cb_sh6, rv_fmt_rd_rs1_imm, DECOMP(rv_op_srai) },
-    { "c.andi", rv_codec_cb_imm, rv_fmt_rd_rs1_imm, DECOMP(rv_op_andi) },
-    { "c.sub", rv_codec_cs, rv_fmt_rd_rs1_rs2, DECOMP(rv_op_sub) },
-    { "c.xor", rv_codec_cs, rv_fmt_rd_rs1_rs2, DECOMP(rv_op_xor) },
-    { "c.or", rv_codec_cs, rv_fmt_rd_rs1_rs2, DECOMP(rv_op_or) },
-    { "c.and", rv_codec_cs, rv_fmt_rd_rs1_rs2, DECOMP(rv_op_and) },
-    { "c.subw", rv_codec_cs, rv_fmt_rd_rs1_rs2, DECOMP(rv_op_subw) },
-    { "c.addw", rv_codec_cs, rv_fmt_rd_rs1_rs2, DECOMP(rv_op_addw) },
-    { "c.j", rv_codec_cj, rv_fmt_rd_offset, DECOMP(rv_op_jal) },
-    { "c.beqz", rv_codec_cb, rv_fmt_rs1_rs2_offset, DECOMP(rv_op_beq) },
-    { "c.bnez", rv_codec_cb, rv_fmt_rs1_rs2_offset, DECOMP(rv_op_bne) },
-    { "c.slli", rv_codec_ci_sh6, rv_fmt_rd_rs1_imm, DECOMP(rv_op_slli) },
-    { "c.fldsp", rv_codec_ci_ldsp, rv_fmt_frd_offset_rs1, DECOMP(rv_op_fld) },
-    { "c.lwsp", rv_codec_ci_lwsp, rv_fmt_rd_offset_rs1, DECOMP(rv_op_lw) },
-    { "c.flwsp", rv_codec_ci_lwsp, rv_fmt_frd_offset_rs1, DECOMP(rv_op_flw) },
-    { "c.jr", rv_codec_cr_jr, rv_fmt_rd_rs1_offset, DECOMP(rv_op_jalr) },
-    { "c.mv", rv_codec_cr_mv, rv_fmt_rd_rs1_rs2, DECOMP(rv_op_addi) },
-    { "c.ebreak", rv_codec_ci_none, rv_fmt_none, DECOMP(rv_op_ebreak) },
-    { "c.jalr", rv_codec_cr_jalr, rv_fmt_rd_rs1_offset, DECOMP(rv_op_jalr) },
-    { "c.add", rv_codec_cr, rv_fmt_rd_rs1_rs2, DECOMP(rv_op_add) },
-    { "c.fsdsp", rv_codec_css_sdsp, rv_fmt_frs2_offset_rs1, DECOMP(rv_op_fsd) },
-    { "c.swsp", rv_codec_css_swsp, rv_fmt_rs2_offset_rs1, DECOMP(rv_op_sw) },
-    { "c.fswsp", rv_codec_css_swsp, rv_fmt_frs2_offset_rs1, DECOMP(rv_op_fsw) },
-    { "c.ld", rv_codec_cl_ld, rv_fmt_rd_offset_rs1, DECOMP(rv_op_ld) },
-    { "c.sd", rv_codec_cs_sd, rv_fmt_rs2_offset_rs1, DECOMP(rv_op_sd) },
-    { "c.addiw", rv_codec_ci, rv_fmt_rd_rs1_imm, DECOMP(rv_op_addiw) },
-    { "c.ldsp", rv_codec_ci_ldsp, rv_fmt_rd_offset_rs1, DECOMP(rv_op_ld) },
-    { "c.sdsp", rv_codec_css_sdsp, rv_fmt_rs2_offset_rs1, DECOMP(rv_op_sd) },
-    { "c.lq", rv_codec_cl_lq, rv_fmt_rd_offset_rs1, DECOMP(rv_op_lq) },
-    { "c.sq", rv_codec_cs_sq, rv_fmt_rs2_offset_rs1, DECOMP(rv_op_sq) },
-    { "c.lqsp", rv_codec_ci_lqsp, rv_fmt_rd_offset_rs1, DECOMP(rv_op_lq) },
-    { "c.sqsp", rv_codec_css_sqsp, rv_fmt_rs2_offset_rs1, DECOMP(rv_op_sq) },
+    { "c.addi", rv_codec_ci, NULL, DECOMP(rv_op_addi) },
+    { "c.jal", rv_codec_cj_jal, NULL, DECOMP(rv_op_jal) },
+    { "c.li", rv_codec_ci_li, NULL, DECOMP(rv_op_addi) },
+    { "c.addi16sp", rv_codec_ci_16sp, NULL, DECOMP(rv_op_addi) },
+    { "c.lui", rv_codec_ci_lui, NULL, DECOMP(rv_op_lui) },
+    { "c.srli", rv_codec_cb_sh6, NULL, DECOMP(rv_op_srli) },
+    { "c.srai", rv_codec_cb_sh6, NULL, DECOMP(rv_op_srai) },
+    { "c.andi", rv_codec_cb_imm, NULL, DECOMP(rv_op_andi) },
+    { "c.sub", rv_codec_cs, NULL, DECOMP(rv_op_sub) },
+    { "c.xor", rv_codec_cs, NULL, DECOMP(rv_op_xor) },
+    { "c.or", rv_codec_cs, NULL, DECOMP(rv_op_or) },
+    { "c.and", rv_codec_cs, NULL, DECOMP(rv_op_and) },
+    { "c.subw", rv_codec_cs, NULL, DECOMP(rv_op_subw) },
+    { "c.addw", rv_codec_cs, NULL, DECOMP(rv_op_addw) },
+    { "c.j", rv_codec_cj, NULL, DECOMP(rv_op_jal) },
+    { "c.beqz", rv_codec_cb, NULL, DECOMP(rv_op_beq) },
+    { "c.bnez", rv_codec_cb, NULL, DECOMP(rv_op_bne) },
+    { "c.slli", rv_codec_ci_sh6, NULL, DECOMP(rv_op_slli) },
+    { "c.fldsp", rv_codec_ci_ldsp, NULL, DECOMP(rv_op_fld) },
+    { "c.lwsp", rv_codec_ci_lwsp, NULL, DECOMP(rv_op_lw) },
+    { "c.flwsp", rv_codec_ci_lwsp, NULL, DECOMP(rv_op_flw) },
+    { "c.jr", rv_codec_cr_jr, NULL, DECOMP(rv_op_jalr) },
+    { "c.mv", rv_codec_cr_mv, NULL, DECOMP(rv_op_addi) },
+    { "c.ebreak", rv_codec_ci_none, NULL, DECOMP(rv_op_ebreak) },
+    { "c.jalr", rv_codec_cr_jalr, NULL, DECOMP(rv_op_jalr) },
+    { "c.add", rv_codec_cr, NULL, DECOMP(rv_op_add) },
+    { "c.fsdsp", rv_codec_css_sdsp, NULL, DECOMP(rv_op_fsd) },
+    { "c.swsp", rv_codec_css_swsp, NULL, DECOMP(rv_op_sw) },
+    { "c.fswsp", rv_codec_css_swsp, NULL, DECOMP(rv_op_fsw) },
+    { "c.ld", rv_codec_cl_ld, NULL, DECOMP(rv_op_ld) },
+    { "c.sd", rv_codec_cs_sd, NULL, DECOMP(rv_op_sd) },
+    { "c.addiw", rv_codec_ci, NULL, DECOMP(rv_op_addiw) },
+    { "c.ldsp", rv_codec_ci_ldsp, NULL, DECOMP(rv_op_ld) },
+    { "c.sdsp", rv_codec_css_sdsp, NULL, DECOMP(rv_op_sd) },
+    { "c.lq", rv_codec_cl_lq, NULL, DECOMP(rv_op_lq) },
+    { "c.sq", rv_codec_cs_sq, NULL, DECOMP(rv_op_sq) },
+    { "c.lqsp", rv_codec_ci_lqsp, NULL, DECOMP(rv_op_lq) },
+    { "c.sqsp", rv_codec_css_sqsp, NULL, DECOMP(rv_op_sq) },
     { "nop", rv_codec_i, rv_fmt_none },
     { "mv", rv_codec_i, rv_fmt_rd_rs1 },
     { "not", rv_codec_i, rv_fmt_rd_rs1 },
@@ -2546,8 +2546,8 @@ static const rv_opcode_data rvi_opcode_data[] = {
     { "ssrdp", rv_codec_r, rv_fmt_rd },
     { "ssamoswap.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
     { "ssamoswap.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1 },
-    { "c.sspush", rv_codec_cmop_ss, rv_fmt_rs2, DECOMP(rv_op_sspush) },
-    { "c.sspopchk", rv_codec_cmop_ss, rv_fmt_rs1, DECOMP(rv_op_sspopchk) },
+    { "c.sspush", rv_codec_cmop_ss, NULL, DECOMP(rv_op_sspush) },
+    { "c.sspopchk", rv_codec_cmop_ss, NULL, DECOMP(rv_op_sspopchk) },
    { "cbo.inval", rv_codec_r, rv_fmt_rs1 },
    { "cbo.clean", rv_codec_r, rv_fmt_rs1 },
    { "cbo.flush", rv_codec_r, rv_fmt_rs1 },
-- 
2.43.0


