Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F33FC5DF98
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:56:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNc0-0007Df-43; Mon, 24 Aug 2026 01:52:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNbZ-0005XQ-AS
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:52:21 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNbW-00036k-Ph
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:52:20 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-38dcbade417so3537146a91.1
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787550737; x=1788155537; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=72GARMzn2bUyBu7BeKAYGflCgKnwtbN6s6HTDCW9QrE=;
 b=NQgZ9W0NS7TEMycIKGOGLb1xXN2/fSXM1Z63MeP+JMzl7EDr2EBqsWKnOOGIwzHYSE
 9k+jvv0wul4slNEdi9Y4UH9B4s6mBlNiaxysx55DtNmpMI7XwQzX81YVMtCorijVMHSS
 e8B0W/9fyblqBz4Xobb7P3vcONr41HmXt34nl4irEt+53uNEAwwvV/MiixCahSl33911
 Z0ARtZOfHWQ2ADjEVuNJ8vhN2Y677w9Q15M8Oyp+oOxvwGwxv0hzMDXU1f1cu+xON7b6
 5wdozX5QIAKBoobZOTcgjnS1hgWuLR/laxXheFrzytnkfMsIK0d+eBlEVnrxSzZEbsdS
 6eeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787550737; x=1788155537;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=72GARMzn2bUyBu7BeKAYGflCgKnwtbN6s6HTDCW9QrE=;
 b=EPrIat30OMG66jInUaAIZ/K9rLaYxs5InNk5C0u+PynkpNSWL1JIx6ovtggVbKNblx
 akRUzjlJVinKU3Fenv67Uhp5YN0m9lujdNj+ZMebjGcV1rBUXb8maP+aPhwa9Rkyh1Oq
 zTlzZajgZ2FrtZ8DlX1PgNuFL8mUC7EY4NiCthaW6iLJNZIB/bw1Pxl4156/ywSqoUMB
 1v89LWws+Gi9gYTcA5h9XOzQhrfbLRC25RZxOo95ffEHUb4TsgrvzatXVP5A+w4GIzpj
 G+i4DNlAS737Ynmn0G38oPtaQhGkrtOvRWu2GuV6Hw1S+huPJOOGWX7BwMYXK0mz8bgN
 yp8Q==
X-Gm-Message-State: AFuF++mliO3Fl7i7QRMx0yUByk+8GuiSIwG7TCjfCT63sGiprtnf9KLQ
 CmhBew3bjPTpuji1PK7E3pznEcHIVr5yTN+9RVK1yAu8RX80Se6YZ3j1riabgg==
X-Gm-Gg: AR+sD12wv4ZFcVeXzStZU6O1MJ9rkVMW1rmrjSjAY3XzTYXkKxIU/zM+z6fjWmgIcI7
 XTSPse6LneF7Uhiac4YgEFo/YQyVvW68G5k+D9F6G8WyLFSA4J0ZJfIjqFdUHGp8LRfIG5XhYPg
 +NjI2M3lJIJvLtYI1uTXpHGG3cZytFjcHJifCnuC+5mkfRV6wNfXK84X4UB3kPfL4we/71+ktMp
 bkxokkQgfv7imW9WKLzJCoXXUr5GFtiSAu+2sO86ao/8/djlxEqEZWZXY6/dwtRz1S7MTIlq03G
 PSEYbX+Gw9G30m6Sm70lyareutnkqkZLeBygHC3DB8w8zSEH8CyXGchQn8M8qBZc18BYVuOvWJi
 mnd2X5R7xXoatJEStfrpPbU+eiKFL1PRMgFLjrIkhE3z+qd/Ffx+oBaHPeUzKyWrcOejTPvnphs
 ireveYN/SSQIMUxSbpEQi5CwgNI3cBdoIaX6fkRB3rCRcKPAd+cuWk2EIw146OMObLm8toJXoCd
 cM6mq9L0d1LSKM+
X-Received: by 2002:a17:90b:1b04:b0:38d:dfd1:7c1 with SMTP id
 98e67ed59e1d1-395c33406e0mr40090386a91.2.1787550737198; 
 Sun, 23 Aug 2026 22:52:17 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c917d2f2sm4046005a91.3.2026.08.23.22.52.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:52:16 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 79/96] disas/riscv: Merge all mop.r.n to one pattern
Date: Mon, 24 Aug 2026 15:47:49 +1000
Message-ID: <20260824054806.2790041-80-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824054806.2790041-1-alistair.francis@wdc.com>
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
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

Avoid performing arithmetic on rv_op_mop_r_0.
Treat the 'n' as an immediate.
Create a codec and format to match.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260812223142.349142-47-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.h        |  2 ++
 disas/riscv.c        | 15 ++++++++++++++-
 disas/riscv-op.c.inc | 33 +--------------------------------
 3 files changed, 17 insertions(+), 33 deletions(-)

diff --git a/disas/riscv.h b/disas/riscv.h
index 5ac8c41616..b47a7f0150 100644
--- a/disas/riscv.h
+++ b/disas/riscv.h
@@ -160,6 +160,7 @@ typedef enum {
     rv_codec_fli,
     rv_codec_lp,
     rv_codec_cmop_ss,
+    rv_codec_mop_r,
 } rv_codec;
 
 /* structures */
@@ -284,5 +285,6 @@ typedef struct {
 #define rv_fmt_rd_rs1_immh_imml_addr  "O\t0,(1),i,j"
 #define rv_fmt_rd2_imm                "O\t0,2,(1),i"
 #define rv_fmt_fli                    "O\t3,h"
+#define rv_fmt_mop_r                  "O.i\t0,1"
 
 #endif /* DISAS_RISCV_H */
diff --git a/disas/riscv.c b/disas/riscv.c
index 8aaad96bf4..0751f1a841 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -643,6 +643,13 @@ static uint32_t operand_lpl(rv_inst inst)
     return extract32(inst, 12, 20);
 }
 
+static uint32_t operand_mop_r_imm(rv_inst inst)
+{
+    return (extract32(inst, 30, 1) << 4) |
+           (extract32(inst, 26, 2) << 2) |
+           extract32(inst, 20, 2);
+}
+
 /* instruction metadata */
 
 static const rv_opcode_data rvi_opcode_data[] = {
@@ -2546,7 +2553,7 @@ static const rv_opcode_data *decode_inst_opcode(rv_decode *dec, rv_isa isa)
                                                        2, 2,
                                                        extract32(inst, 26, 2)),
                                              4, 1, extract32(inst, 30, 1));
-                        op = rv_op_mop_r_0 + imm_mop5;
+                        op = rv_op_mop_r;
                         /* if zicfiss enabled and mop5 is shadow stack */
                         if (dec->cfg->ext_zicfiss &&
                             ((imm_mop5 & 0b11100) == 0b11100)) {
@@ -3049,6 +3056,11 @@ static void decode_inst_operands(rv_decode *dec, rv_isa isa,
         dec->rs1 = dec->rs2 = operand_crs1(inst);
         dec->imm = 0;
         break;
+    case rv_codec_mop_r:
+        dec->rd = operand_rd(inst);
+        dec->rs1 = operand_rs1(inst);
+        dec->imm = operand_mop_r_imm(inst);
+        break;
     default:
         g_assert_not_reached();
     }
@@ -3134,6 +3146,7 @@ static GString *format_inst(size_t tab, rv_decode *dec,
             g_string_append(buf, op->name);
             break;
         case '(':
+        case '.':
         case ',':
         case ')':
         case '-':
diff --git a/disas/riscv-op.c.inc b/disas/riscv-op.c.inc
index 3fe934688e..222d249a70 100644
--- a/disas/riscv-op.c.inc
+++ b/disas/riscv-op.c.inc
@@ -873,38 +873,7 @@ OP(vwsll_vi, "vwsll.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm)
 OP(amocas_w, "amocas.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
 OP(amocas_d, "amocas.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
 OP(amocas_q, "amocas.q", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
-OP(mop_r_0, "mop.r.0", rv_codec_r, rv_fmt_rd_rs1)
-OP(mop_r_1, "mop.r.1", rv_codec_r, rv_fmt_rd_rs1)
-OP(mop_r_2, "mop.r.2", rv_codec_r, rv_fmt_rd_rs1)
-OP(mop_r_3, "mop.r.3", rv_codec_r, rv_fmt_rd_rs1)
-OP(mop_r_4, "mop.r.4", rv_codec_r, rv_fmt_rd_rs1)
-OP(mop_r_5, "mop.r.5", rv_codec_r, rv_fmt_rd_rs1)
-OP(mop_r_6, "mop.r.6", rv_codec_r, rv_fmt_rd_rs1)
-OP(mop_r_7, "mop.r.7", rv_codec_r, rv_fmt_rd_rs1)
-OP(mop_r_8, "mop.r.8", rv_codec_r, rv_fmt_rd_rs1)
-OP(mop_r_9, "mop.r.9", rv_codec_r, rv_fmt_rd_rs1)
-OP(mop_r_10, "mop.r.10", rv_codec_r, rv_fmt_rd_rs1)
-OP(mop_r_11, "mop.r.11", rv_codec_r, rv_fmt_rd_rs1)
-OP(mop_r_12, "mop.r.12", rv_codec_r, rv_fmt_rd_rs1)
-OP(mop_r_13, "mop.r.13", rv_codec_r, rv_fmt_rd_rs1)
-OP(mop_r_14, "mop.r.14", rv_codec_r, rv_fmt_rd_rs1)
-OP(mop_r_15, "mop.r.15", rv_codec_r, rv_fmt_rd_rs1)
-OP(mop_r_16, "mop.r.16", rv_codec_r, rv_fmt_rd_rs1)
-OP(mop_r_17, "mop.r.17", rv_codec_r, rv_fmt_rd_rs1)
-OP(mop_r_18, "mop.r.18", rv_codec_r, rv_fmt_rd_rs1)
-OP(mop_r_19, "mop.r.19", rv_codec_r, rv_fmt_rd_rs1)
-OP(mop_r_20, "mop.r.20", rv_codec_r, rv_fmt_rd_rs1)
-OP(mop_r_21, "mop.r.21", rv_codec_r, rv_fmt_rd_rs1)
-OP(mop_r_22, "mop.r.22", rv_codec_r, rv_fmt_rd_rs1)
-OP(mop_r_23, "mop.r.23", rv_codec_r, rv_fmt_rd_rs1)
-OP(mop_r_24, "mop.r.24", rv_codec_r, rv_fmt_rd_rs1)
-OP(mop_r_25, "mop.r.25", rv_codec_r, rv_fmt_rd_rs1)
-OP(mop_r_26, "mop.r.26", rv_codec_r, rv_fmt_rd_rs1)
-OP(mop_r_27, "mop.r.27", rv_codec_r, rv_fmt_rd_rs1)
-OP(mop_r_28, "mop.r.28", rv_codec_r, rv_fmt_rd_rs1)
-OP(mop_r_29, "mop.r.29", rv_codec_r, rv_fmt_rd_rs1)
-OP(mop_r_30, "mop.r.30", rv_codec_r, rv_fmt_rd_rs1)
-OP(mop_r_31, "mop.r.31", rv_codec_r, rv_fmt_rd_rs1)
+OP(mop_r, "mop.r", rv_codec_mop_r, rv_fmt_mop_r)
 OP(mop_rr_0, "mop.rr.0", rv_codec_r, rv_fmt_rd_rs1_rs2)
 OP(mop_rr_1, "mop.rr.1", rv_codec_r, rv_fmt_rd_rs1_rs2)
 OP(mop_rr_2, "mop.rr.2", rv_codec_r, rv_fmt_rd_rs1_rs2)
-- 
2.54.0


