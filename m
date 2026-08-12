Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FFF2C5CFEB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 22:38:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuHXt-0001Kp-NI; Wed, 12 Aug 2026 18:35:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuHXr-0001F2-83
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 18:35:35 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuHXk-0001rY-Ab
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 18:35:34 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-38e08baf860so134143a91.2
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 15:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786574127; x=1787178927; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=g4sAx4xWlbpz+Mg16SIgOdXMJml0cnc7XZM+DuBfZGU=;
 b=l5rGSvQRmlRKdTG6FZNIN8wWQEglWBbnguoPjNleT11U0gyx/hFuG4uWbRmMlzPhhX
 zJvhNR4B2dpN5QtCxcmTd6QJoNPkT8SMUM4lkkbI4ScY0vFGTiJY4aLZP7HoYzEdp86/
 IgADlJmwqdxRoVMMsq+4KiAHJso3UX1pvJFp7KM4ONdE7VeVET6UYKsCoc1hBgT9yaZ3
 qzFaI6TODeQ9KOaxQ892S4mvhEXaxYTvoSF4+XrhqcEG968g2qz2fUh7WHYxycg6+zEv
 LMu/CP0BaByXDShdJUrAkbDG1lCaxQszzQ4wiJwiGwaX6Rbi7yeslNdCTWjnJqmHAccz
 QaXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786574127; x=1787178927;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=g4sAx4xWlbpz+Mg16SIgOdXMJml0cnc7XZM+DuBfZGU=;
 b=PRe63g/ScxUI5Wk3l2tfysXnRVFFbQ7/7us7RpsFpgBVmRITveSGUAWr3yKjj5zXfY
 OE1vnW6gr9ZXcZdfOM1/xfs8zmAOeHmWvLRYhcSnmviSwBEwV0aFDxS0yunDULy85Q85
 YwtUbI5M2E4Tu55OkTdbc6Jjl0rTyDYmrEHrvF22HMY8PGw9RJecZwZfIWVEEs/3WvOx
 HnW/04jmaitEcLCdO0l+h10b8lEf9Zznj40YY0zwEO6BvpQtm7iUNDbN/zI3FM0X9mNK
 Tsc57GWIYnudMjkG3987bGBQboz8B/SLtG3BMmvTXeR2Fl486Yly+PgQM/7eifSM/zzz
 slMg==
X-Gm-Message-State: AOJu0YzRf6dYLZYNA/uF4rt5k9V3b3BL6JEvanebo7nidSeAecnZ52uT
 tWH8K6LKGgR+HOW78nYXb/D78tAnp6o+YSJpRqRpCAYaAuab+gtT6IoTSuA+gz6r1Rev1egsuWu
 81LSY
X-Gm-Gg: AR+sD10YuaQcaKB8pM6hCoyTxSjWWfdK6Kij5mnmiY3A8Ttg32MIHxOMSRGz8ITBCBb
 EFpFLpGh79Stbsp4IbpNpTaL1WSAHcREmZcSvhDB4N4NfcTqa4bmTtkRtPIoqlb5WV15SZkc9du
 xmsV2JbmRrBVDiQphiU6tBuUc4Lbnh41eRTje4nHskve1/ixPhIs3so7bnMsM0MVMu4TAquTwi7
 9aJPBl5sLhwZVi2cGoess6MfL9CFMz2OtCH7q6ypZPDLk5kRFbpblPS1zVeU+Dj8cnnDc3gwzA7
 SR6ej13x6X9i9OeWVT5pNcswbGMI33jMCl4cCmpK1ulnJ6uSD6LdNveBIaI3qtq1XhGjrB5uKmz
 xLD+cS0zZ/EOLqd0OuQGGM5gohKMKBEWlEpgF4wSKaERWztuDAfqxJhDs4iecQic1EaCBV+z//T
 ND2QYROApyjTHpxy48u0iT7Dq1cvmGSCtPBMQJtNBdMRy1NdWB5Qq5e8EWfqvflQGPXq/giPxG5
 2IOYB90F2OZhTUdL4mih9uj3ZEibw==
X-Received: by 2002:a17:90b:4c0a:b0:38e:fea2:df53 with SMTP id
 98e67ed59e1d1-3931e0241c2mr1616332a91.4.1786574126212; 
 Wed, 12 Aug 2026 15:35:26 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3931f41cd2fsm464854a91.12.2026.08.12.15.35.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 15:35:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Alistair.Francis@wdc.com,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 46/52] disas/riscv: Merge all mop.r.n to one pattern
Date: Wed, 12 Aug 2026 15:31:36 -0700
Message-ID: <20260812223142.349142-47-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812223142.349142-1-richard.henderson@linaro.org>
References: <20260812223142.349142-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

Avoid performing arithmetic on rv_op_mop_r_0.
Treat the 'n' as an immediate.
Create a codec and format to match.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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
2.43.0


