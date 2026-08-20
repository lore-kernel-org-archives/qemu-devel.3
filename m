Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A852C5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 03:55:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwtlB-0006WV-Ok; Wed, 19 Aug 2026 23:48:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtl9-0006Rg-K6
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:48:07 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtl7-0004Md-Qc
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:48:07 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-383cb94f742so1956980a91.3
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 20:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787197684; x=1787802484; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mS5lH+O6u6AC0cF1efiMr/IZgg9QvygUsI4yMDEJpC0=;
 b=LxSTVHNhxWaNBsCMOBu16RH7EBi2Uh8U38Vyn3bUg9iXhb3cEWqoZtOARJSXM5IU/L
 0ncQRk7/+zbPSkdvgO5TWPGQNS0lxtiiGAc2vgrTawrkVImY4NiR4JCnOgrxDgEujD5i
 QIGS/DSdBHpg4IaP6xR4g4f8hEEdEezKo2SIrZSMMfD3AzybWrevXOCJczS4tK2HfAbf
 bnZYYRMYhoS4MhQCtZ4CUnc3clkOcasXrHhhxCus4ueFofYbLQ9QS5UgpL2wqH/7baL7
 YmyapMdsxsMDFyxvojj6Y+m6XDa7Zv5saVD8Y9MsAfA2+0X3qSJ1x+7D8wUAc/t+QJIj
 t3UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787197684; x=1787802484;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mS5lH+O6u6AC0cF1efiMr/IZgg9QvygUsI4yMDEJpC0=;
 b=bjPLuu64w6oPNqY1VjagFw9M6q7wL08MeTU3bttg92inYjd8/j1TulaxLRlhRenXwW
 /9gZn63dfOiyJb5acjzlpgQxFF/q9TLKzH76RoDWp+mn8XDTj/qcvL1KYogpWCRQXWuW
 oHVwpnjeJXY6LyZAUtGGg8KGX/ttZjpVstxcrNWncqrvCLGU0mEkxQUNU2au7J6Nqmq+
 PXOkkRC4jIm4KHCWwhHqVwsoJ4tVM42MKmOqhGsj831RVusv9MOpWAgv5rPU/bNrMf0A
 0j5EFANt06Zhm0+z9NPgxNxamZEc6Rw1Dv13k8l92yszI/m0yq+0U/zdfBVDRZdwjQcq
 0B7g==
X-Gm-Message-State: AFuF++mvBPP0y+lDnM5zZDQEDTgIQ96QNX6IQhxSf/I/FW0Hh4jC8gBg
 CGinFFrItjA11O4SmH4KRwZgSrqY3lJPJAO2yDw9jt1fW44DPbFv7p+IET+MCQ==
X-Gm-Gg: AR+sD10lHThwWA3q3F4v1rdjzSanCBO69uIyzguYy1n5H6nzF/GtTNCElgrFPAACj11
 4KPO8BRG8G5aJmtWwlKTaUK+PHxXpzgRsivXtmY9B4DNMWAq4uOp+NWJy5JGXeb7Fpek1gv8Rxk
 Wg204F8ptC7guPDKwLq+DJInwbiVpiSvIa6nz7/p4b+xjOF2FfGbNs1g7zXsYCJWMFT8+L9BTOG
 cPt8YUy86cN3vidQMiWKfwuuWe0Qiw/Q0n50mGlj/+rMnotwSI1nWmNFxdqulIm17pXWy/Yo/l0
 SXseChbgaLjq6pEcO7byNrj/4caWoyakt1cQv3IeK9yrmFR5bXW/G/JVIeKX0KRK/TeKgtI2bCb
 7S5YA9g1aZ4gHmUJ8izzMGgPM/ymn6hrsDAm21nQbCmSQ4/mOeYc/fFE/k0PcAModGE8VFaOY6P
 ElL+9RgpMTxiDNJPVaAZx4U7PyUgQgxYnOT4HVDmMrSIKmMXePhUIicfcFdCTDoZ+oESGGEth9J
 NGEC3/YUJg=
X-Received: by 2002:a17:90a:d604:b0:38e:97f0:aa4b with SMTP id
 98e67ed59e1d1-3958127a5aamr18332526a91.13.1787197684410; 
 Wed, 19 Aug 2026 20:48:04 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad6060asm19506735c88.6.2026.08.19.20.48.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 20:48:03 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 70/93] disas/riscv: Store op pointer in rv_comp_data
Date: Thu, 20 Aug 2026 13:44:07 +1000
Message-ID: <20260820034430.1186695-71-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820034430.1186695-1-alistair.francis@wdc.com>
References: <20260820034430.1186695-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102d.google.com
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

Store a pointer instead of an array index.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260812223142.349142-35-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.h |  8 +++---
 disas/riscv.c | 69 ++++++++++++++++++++++++++-------------------------
 2 files changed, 40 insertions(+), 37 deletions(-)

diff --git a/disas/riscv.h b/disas/riscv.h
index ea7141d3b5..ab62c0db94 100644
--- a/disas/riscv.h
+++ b/disas/riscv.h
@@ -164,17 +164,19 @@ typedef enum {
 
 /* structures */
 
+typedef struct rv_opcode_data rv_opcode_data;
+
 typedef struct {
-    int op;
+    const rv_opcode_data *op;
     const rvc_constraint *constraints;
 } rv_comp_data;
 
-typedef struct {
+struct rv_opcode_data {
     const char *name;
     rv_codec codec;
     const char *format;
     const rv_comp_data *pseudo;
-} rv_opcode_data;
+};
 
 typedef struct {
     const RISCVCPUConfig *cfg;
diff --git a/disas/riscv.c b/disas/riscv.c
index 342e2db3cc..9d05e86c09 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -1068,138 +1068,140 @@ static const rvc_constraint rvcc_true[] = { rvc_end };
 
 /* pseudo-instruction metadata */
 
+static const rv_opcode_data rvi_opcode_data[];
+
 static const rv_comp_data rvcp_jal[] = {
-    { rv_op_j, rvcc_j },
-    { rv_op_jal_ra, rvcc_jal_ra },
+    { &rvi_opcode_data[rv_op_j], rvcc_j },
+    { &rvi_opcode_data[rv_op_jal_ra], rvcc_jal_ra },
     { },
 };
 
 static const rv_comp_data rvcp_jalr[] = {
-    { rv_op_jr, rvcc_jr },
-    { rv_op_jalr_ra, rvcc_jalr_ra },
+    { &rvi_opcode_data[rv_op_jr], rvcc_jr },
+    { &rvi_opcode_data[rv_op_jalr_ra], rvcc_jalr_ra },
     { },
 };
 
 static const rv_comp_data rvcp_jr[] = {
-    { rv_op_ret, rvcc_ret },
+    { &rvi_opcode_data[rv_op_ret], rvcc_ret },
     { },
 };
 
 static const rv_comp_data rvcp_beq[] = {
-    { rv_op_beqz, rvcc_beqz },
+    { &rvi_opcode_data[rv_op_beqz], rvcc_beqz },
     { },
 };
 
 static const rv_comp_data rvcp_bne[] = {
-    { rv_op_bnez, rvcc_bnez },
+    { &rvi_opcode_data[rv_op_bnez], rvcc_bnez },
     { },
 };
 
 static const rv_comp_data rvcp_blt[] = {
-    { rv_op_bltz, rvcc_bltz },
-    { rv_op_bgtz, rvcc_bgtz },
+    { &rvi_opcode_data[rv_op_bltz], rvcc_bltz },
+    { &rvi_opcode_data[rv_op_bgtz], rvcc_bgtz },
     { },
 };
 
 static const rv_comp_data rvcp_bge[] = {
-    { rv_op_blez, rvcc_blez },
-    { rv_op_bgez, rvcc_bgez },
+    { &rvi_opcode_data[rv_op_blez], rvcc_blez },
+    { &rvi_opcode_data[rv_op_bgez], rvcc_bgez },
     { },
 };
 
 static const rv_comp_data rvcp_addi[] = {
-    { rv_op_mv, rvcc_mv },
+    { &rvi_opcode_data[rv_op_mv], rvcc_mv },
     { },
 };
 
 static const rv_comp_data rvcp_mv[] = {
-    { rv_op_nop, rvcc_nop },
+    { &rvi_opcode_data[rv_op_nop], rvcc_nop },
     { },
 };
 
 static const rv_comp_data rvcp_sltiu[] = {
-    { rv_op_seqz, rvcc_seqz },
+    { &rvi_opcode_data[rv_op_seqz], rvcc_seqz },
     { },
 };
 
 static const rv_comp_data rvcp_xori[] = {
-    { rv_op_not, rvcc_not },
+    { &rvi_opcode_data[rv_op_not], rvcc_not },
     { },
 };
 
 static const rv_comp_data rvcp_sub[] = {
-    { rv_op_neg, rvcc_neg },
+    { &rvi_opcode_data[rv_op_neg], rvcc_neg },
     { },
 };
 
 static const rv_comp_data rvcp_slt[] = {
-    { rv_op_sltz, rvcc_sltz },
-    { rv_op_sgtz, rvcc_sgtz },
+    { &rvi_opcode_data[rv_op_sltz], rvcc_sltz },
+    { &rvi_opcode_data[rv_op_sgtz], rvcc_sgtz },
     { },
 };
 
 static const rv_comp_data rvcp_sltu[] = {
-    { rv_op_snez, rvcc_snez },
+    { &rvi_opcode_data[rv_op_snez], rvcc_snez },
     { },
 };
 
 static const rv_comp_data rvcp_addiw[] = {
-    { rv_op_sext_w, rvcc_sext_w },
+    { &rvi_opcode_data[rv_op_sext_w], rvcc_sext_w },
     { },
 };
 
 static const rv_comp_data rvcp_subw[] = {
-    { rv_op_negw, rvcc_negw },
+    { &rvi_opcode_data[rv_op_negw], rvcc_negw },
     { },
 };
 
 static const rv_comp_data rvcp_fsgnj_s[] = {
-    { rv_op_fmv_s, rvcc_fmv_s },
+    { &rvi_opcode_data[rv_op_fmv_s], rvcc_fmv_s },
     { },
 };
 
 static const rv_comp_data rvcp_fsgnjn_s[] = {
-    { rv_op_fneg_s, rvcc_fneg_s },
+    { &rvi_opcode_data[rv_op_fneg_s], rvcc_fneg_s },
     { },
 };
 
 static const rv_comp_data rvcp_fsgnjx_s[] = {
-    { rv_op_fabs_s, rvcc_fabs_s },
+    { &rvi_opcode_data[rv_op_fabs_s], rvcc_fabs_s },
     { },
 };
 
 static const rv_comp_data rvcp_fsgnj_d[] = {
-    { rv_op_fmv_d, rvcc_fmv_d },
+    { &rvi_opcode_data[rv_op_fmv_d], rvcc_fmv_d },
     { },
 };
 
 static const rv_comp_data rvcp_fsgnjn_d[] = {
-    { rv_op_fneg_d, rvcc_fneg_d },
+    { &rvi_opcode_data[rv_op_fneg_d], rvcc_fneg_d },
     { },
 };
 
 static const rv_comp_data rvcp_fsgnjx_d[] = {
-    { rv_op_fabs_d, rvcc_fabs_d },
+    { &rvi_opcode_data[rv_op_fabs_d], rvcc_fabs_d },
     { },
 };
 
 static const rv_comp_data rvcp_fsgnj_q[] = {
-    { rv_op_fmv_q, rvcc_fmv_q },
+    { &rvi_opcode_data[rv_op_fmv_q], rvcc_fmv_q },
     { },
 };
 
 static const rv_comp_data rvcp_fsgnjn_q[] = {
-    { rv_op_fneg_q, rvcc_fneg_q },
+    { &rvi_opcode_data[rv_op_fneg_q], rvcc_fneg_q },
     { },
 };
 
 static const rv_comp_data rvcp_fsgnjx_q[] = {
-    { rv_op_fabs_q, rvcc_fabs_q },
+    { &rvi_opcode_data[rv_op_fabs_q], rvcc_fabs_q },
     { },
 };
 
 /* Convert compressed insns into normal insns via pseudo expansion. */
-#define DECOMP(X)  &(const rv_comp_data){ X, rvcc_true }
+#define DECOMP(X)  &(const rv_comp_data){ &rvi_opcode_data[X], rvcc_true }
 
 /* operand extractors */
 
@@ -5270,9 +5272,8 @@ static const rv_opcode_data *decode_inst_lift_pseudo(rv_decode *dec,
     if (comp_data) {
         while (comp_data->constraints) {
             if (check_constraints(dec, comp_data->constraints)) {
-                const rv_opcode_data *new_op = &dec->opcode_data[comp_data->op];
-                assert(new_op != op);
-                return decode_inst_lift_pseudo(dec, new_op);
+                assert(op != comp_data->op);
+                return decode_inst_lift_pseudo(dec, comp_data->op);
             }
             comp_data++;
         }
-- 
2.54.0


