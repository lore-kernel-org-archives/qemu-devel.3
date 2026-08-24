Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D5AC5DF8C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:55:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNc3-0007bt-UK; Mon, 24 Aug 2026 01:52:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNbe-0005qu-BE
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:52:26 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNbc-00037s-F8
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:52:26 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-cbedd5aece4so2907269a12.0
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787550743; x=1788155543; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=82rer5v+mUlWOAXCYhpssgxoxfjq1dcBWXCAHZ6HX8I=;
 b=dhEbmDGTAj+zV9O+13UJ8iWS1Wp8NM+jtWbSspde6AhEN/bBBC13XiIoemyd0uYWPo
 8dvvklFED0Xd3yP6jDvJ6SxhPwe3gYlsrda8tiOuoKrWFUnSpWWsB3yBIaEvmquLjXVT
 Pdipu8Pi0Wg4dSpzI0uqD2ZKVqgkXdbrf/+R+GrXUP5LXnApMkoBPYtrzNDqEdeRyZvc
 I9Jf6+Xytur/zmfa0GcJwUtwV7kdSp99yBa6ytXCs7uUT1mr3ngU0Q37dQqBhib5oJeC
 GP0S4PGYIrHG+CpKyucWdibvUMbUMJHbyw2Z0ym9n89++58Md4c3eLtuFv2oipSQH7OZ
 Xb2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787550743; x=1788155543;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=82rer5v+mUlWOAXCYhpssgxoxfjq1dcBWXCAHZ6HX8I=;
 b=MRA6NxFCRIP2oF6fRdHtXbBCShfNweu3syStAUWXvT6CZs3UH1zdMxkrfoxR9nLygL
 Eayw6lGvLc4L2pfIysSOn/bNmygx83cYqJqRsWF/nul0R4VseeUGjDZYv+GzfM/56z1o
 zIIsDd7cNQ0faQ8N7/x+dKicWjGbGV9Vq3KfYNu5qXBnE3T9E0iRk4klGVVCM5yXKcAK
 ua+nCsBVNCInPSjLH3mQyQee3ajjJep+kJLhPtJiIkdqOkDY2fF9cvqI5jiMgVqtYdWr
 nuaJPjZDW1dziFd23Mwh4urybWUUNn7XfNJNV5s/iOQ0GI6Z02TrFQD3QLQTPAldbtVF
 OOMw==
X-Gm-Message-State: AFuF++kapq0BmjFjolBsXBNFH1Ukv41VzQ9hPsNoZTjof3vy78uZ5+Eb
 oTfcAvrAx2cbMnWt0OjEED9P0DpGWcZwnIYVJPl/3nBf5x/7P0bPXl6LDGnhuQ==
X-Gm-Gg: AR+sD13gmiVEa3KVCa4UoJxpBmTF3cVmLv8GiRP/dv5bruXDh8QODl3lJIHBn4YN3pL
 UR/E6eBsiUK262q7KqDHa4JfjAyYu+aPSviTbL/oHcYDTcIQZwEmKlRz7G5dDQ1kUfZ0tF5Icx9
 c8OGbkVuXfNun2s2dkf4NIZwCuoNPZ/Ji9Fo2iD2W0C7m+AUEylCW9ZMvlNz1u4Z/TKIjJgGlcm
 ZtOkL3JFBIyo6Mv9ta1MFSEaY5I2FI5bIzywStbBQdnt43SGOVsUykyyuRX/+NX/q1NFZj/wrsQ
 eDFkszP/RgDtD0Gfa64o8+O8L9GkOQSs5Mckxg5d4SZ/NocXcQ8UXsWP5PT5JqWovFKYKjVSkS+
 BdbCs9HxHmMPuTCbKR4raJAjrKy81lHLyCdyQiMjMvR2rduSj97t9HwU8tAVPJYHuN8tS8mAk96
 4vfyY3T/0xqMoCkUa7pD7EklkGIXkdfM+oxLs2ZAnFZ6p3xaa3dCm3ai7kdNhPzQHIRPIJXT2AL
 t09+Q==
X-Received: by 2002:a17:90b:3943:b0:38f:657:6823 with SMTP id
 98e67ed59e1d1-395c50b43bamr22985351a91.8.1787550743049; 
 Sun, 23 Aug 2026 22:52:23 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c917d2f2sm4046005a91.3.2026.08.23.22.52.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:52:22 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 81/96] disas/riscv: Merge all c.mop.n to one pattern
Date: Mon, 24 Aug 2026 15:47:51 +1000
Message-ID: <20260824054806.2790041-82-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824054806.2790041-1-alistair.francis@wdc.com>
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52c.google.com
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


