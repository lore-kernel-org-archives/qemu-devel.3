Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99752E77180
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:34:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM9Xk-0007oX-Jw; Fri, 13 Dec 2024 12:33:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9X2-0006xv-5n
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:32:53 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9Wy-0001UF-6N
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:32:50 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4361d5dcf5bso21146565e9.3
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 09:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734111167; x=1734715967; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GqR7pFZ36L9c+PvgFmJuy5KCLU07AL9j8+oh3b6+uIo=;
 b=gcM+EKdrqcLnWvJKqM5S0LW7bfyLrfCEeyFZY6QsCpnjHAyz52NmxT89Q0GLhL4NmY
 enpDIZi+h+IGuRqoaSMHsz0pbotI/A7PWQjjXLl/iqxganWw+G2wLQd3vC4KQkYUpXh1
 l1tyF6OgQWXRIdfvIeUMGOqqi40tAtDgpZryfI0r620DzbazHrMEKD1QueilDlRXhrea
 /lKdeIOnpz4JINw46rF9b8nnq+6JwbSe4pY9DkxvZt5uNJXJeOzWKkic+kDnrYB66FrA
 HNgTmCc3tWd/7dLWs8u/3qG3Qwl8mD/cpJRzH4VXOwuGkD5AlVpwltgZXChqQ2h3vffn
 QiPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734111167; x=1734715967;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GqR7pFZ36L9c+PvgFmJuy5KCLU07AL9j8+oh3b6+uIo=;
 b=DHzx7oLCKhM/lCi50jlW/g8Isjdn2BTweU3QbUX8WrUvH4Gq8DBMRquuoRJPUc7Z7t
 2X5JldR3vFZYmNv8eQdiwFnh/tvRQk2txUJfVOe+sITv7JunaZAwbLO0UCl+KimZxm1F
 bTvIG8UABQvRVDLh0B07H/p5STJdhjgqEMBPzj1PBjO8bZc13+xGIDuEqgoKfmngob+u
 4k/ac2NjrAmXlzXRCoV/zVobeD3mh8tLA8vmw7STHsfCLdvEx9nWffJGtPt2D4jL2qr8
 05n4D9UK1G6dp3uO2C7aGfVbaCnhip+rloYo3pHNA9osv66P7aUJQrUFKQ+GIK+TfkOt
 LRPw==
X-Gm-Message-State: AOJu0YzqyjccfgHu3HZEX/qq5wnQgr8qDMolr29E4Jq+MfRnINY2SO8X
 eYl3tqLCqAwk/qY4xP+5O+ES9sh5NnA8YU8TECg1R6PuXnAb4/c6Bq01dhA1FoVgc/leg0mHHT4
 e
X-Gm-Gg: ASbGncsy/FfuHDAp/c/2y33bhBN5jQhxPkGW/sKPTIiJzwN1ZR+blwcRUvaK6qki+Yq
 wa8/VWBvdVT1ptt9PYH/yvG/cHt/w7mvseYeeC1Kq9kkl0PwaiJi14wmizJIGwpfzsdDm7sblvH
 oK9GQ/N9GmI+jx1oIePVvI+alZtW93UCxtNJEE2OyfDbAtfPyM7T8H0Nqf9Z+3ZFcIUzxwITok8
 qSIpYM5fKBIsqvIt1ymxUDV9IvDwq8hxAQtR6Csh59iKPYwx49cOcdnvfcA/A==
X-Google-Smtp-Source: AGHT+IGW0wtG6baFpRiGSDwNzhuMuYDGcMLb08Ne2t56NM5uCL5MWNBMeWM60Fiv/cGh1mfF2CRApA==
X-Received: by 2002:a05:600c:35c6:b0:434:a781:f5d5 with SMTP id
 5b1f17b1804b1-4362aa9fd76mr32598675e9.30.1734111166624; 
 Fri, 13 Dec 2024 09:32:46 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80162ddsm87026f8f.37.2024.12.13.09.32.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 09:32:45 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/85] target/arm: Convert disas_data_proc_3src to decodetree
Date: Fri, 13 Dec 2024 17:31:18 +0000
Message-Id: <20241213173229.3308926-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213173229.3308926-1-peter.maydell@linaro.org>
References: <20241213173229.3308926-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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
List-Id: <qemu-devel.nongnu.org>
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

This includes MADD, MSUB, SMADDL, SMSUBL, UMADDL, UMSUBL, SMULH, UMULH.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241211163036.2297116-15-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |  16 +++++
 target/arm/tcg/translate-a64.c | 119 ++++++++++++---------------------
 2 files changed, 59 insertions(+), 76 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 27a3101bc69..b0cc8bd476e 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -753,6 +753,22 @@ SUBS_ext        . 11 01011001 ..... ... ... ..... .....     @addsub_ext
 # Conditional select
 # Data Processing (3-source)
 
+&rrrr           rd rn rm ra
+@rrrr           . .. ........ rm:5 . ra:5 rn:5 rd:5     &rrrr
+
+MADD_w          0 00 11011000 ..... 0 ..... ..... ..... @rrrr
+MSUB_w          0 00 11011000 ..... 1 ..... ..... ..... @rrrr
+MADD_x          1 00 11011000 ..... 0 ..... ..... ..... @rrrr
+MSUB_x          1 00 11011000 ..... 1 ..... ..... ..... @rrrr
+
+SMADDL          1 00 11011001 ..... 0 ..... ..... ..... @rrrr
+SMSUBL          1 00 11011001 ..... 1 ..... ..... ..... @rrrr
+UMADDL          1 00 11011101 ..... 0 ..... ..... ..... @rrrr
+UMSUBL          1 00 11011101 ..... 1 ..... ..... ..... @rrrr
+
+SMULH           1 00 11011010 ..... 0 11111 ..... ..... @rrr
+UMULH           1 00 11011110 ..... 0 11111 ..... ..... @rrr
+
 ### Cryptographic AES
 
 AESE            01001110 00 10100 00100 10 ..... .....  @r2r_q1e0
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index d570bbb6969..99ff787c61f 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -7955,98 +7955,68 @@ TRANS(SUB_r, do_addsub_reg, a, true, false)
 TRANS(ADDS_r, do_addsub_reg, a, false, true)
 TRANS(SUBS_r, do_addsub_reg, a, true, true)
 
-/* Data-processing (3 source)
- *
- *    31 30  29 28       24 23 21  20  16  15  14  10 9    5 4    0
- *  +--+------+-----------+------+------+----+------+------+------+
- *  |sf| op54 | 1 1 0 1 1 | op31 |  Rm  | o0 |  Ra  |  Rn  |  Rd  |
- *  +--+------+-----------+------+------+----+------+------+------+
- */
-static void disas_data_proc_3src(DisasContext *s, uint32_t insn)
+static bool do_mulh(DisasContext *s, arg_rrr *a,
+                    void (*fn)(TCGv_i64, TCGv_i64, TCGv_i64, TCGv_i64))
 {
-    int rd = extract32(insn, 0, 5);
-    int rn = extract32(insn, 5, 5);
-    int ra = extract32(insn, 10, 5);
-    int rm = extract32(insn, 16, 5);
-    int op_id = (extract32(insn, 29, 3) << 4) |
-        (extract32(insn, 21, 3) << 1) |
-        extract32(insn, 15, 1);
-    bool sf = extract32(insn, 31, 1);
-    bool is_sub = extract32(op_id, 0, 1);
-    bool is_high = extract32(op_id, 2, 1);
-    bool is_signed = false;
-    TCGv_i64 tcg_op1;
-    TCGv_i64 tcg_op2;
-    TCGv_i64 tcg_tmp;
+    TCGv_i64 discard = tcg_temp_new_i64();
+    TCGv_i64 tcg_rd = cpu_reg(s, a->rd);
+    TCGv_i64 tcg_rn = cpu_reg(s, a->rn);
+    TCGv_i64 tcg_rm = cpu_reg(s, a->rm);
 
-    /* Note that op_id is sf:op54:op31:o0 so it includes the 32/64 size flag */
-    switch (op_id) {
-    case 0x42: /* SMADDL */
-    case 0x43: /* SMSUBL */
-    case 0x44: /* SMULH */
-        is_signed = true;
-        break;
-    case 0x0: /* MADD (32bit) */
-    case 0x1: /* MSUB (32bit) */
-    case 0x40: /* MADD (64bit) */
-    case 0x41: /* MSUB (64bit) */
-    case 0x4a: /* UMADDL */
-    case 0x4b: /* UMSUBL */
-    case 0x4c: /* UMULH */
-        break;
-    default:
-        unallocated_encoding(s);
-        return;
-    }
+    fn(discard, tcg_rd, tcg_rn, tcg_rm);
+    return true;
+}
 
-    if (is_high) {
-        TCGv_i64 low_bits = tcg_temp_new_i64(); /* low bits discarded */
-        TCGv_i64 tcg_rd = cpu_reg(s, rd);
-        TCGv_i64 tcg_rn = cpu_reg(s, rn);
-        TCGv_i64 tcg_rm = cpu_reg(s, rm);
+TRANS(SMULH, do_mulh, a, tcg_gen_muls2_i64)
+TRANS(UMULH, do_mulh, a, tcg_gen_mulu2_i64)
 
-        if (is_signed) {
-            tcg_gen_muls2_i64(low_bits, tcg_rd, tcg_rn, tcg_rm);
-        } else {
-            tcg_gen_mulu2_i64(low_bits, tcg_rd, tcg_rn, tcg_rm);
-        }
-        return;
-    }
+static bool do_muladd(DisasContext *s, arg_rrrr *a,
+                      bool sf, bool is_sub, MemOp mop)
+{
+    TCGv_i64 tcg_rd = cpu_reg(s, a->rd);
+    TCGv_i64 tcg_op1, tcg_op2;
 
-    tcg_op1 = tcg_temp_new_i64();
-    tcg_op2 = tcg_temp_new_i64();
-    tcg_tmp = tcg_temp_new_i64();
-
-    if (op_id < 0x42) {
-        tcg_gen_mov_i64(tcg_op1, cpu_reg(s, rn));
-        tcg_gen_mov_i64(tcg_op2, cpu_reg(s, rm));
+    if (mop == MO_64) {
+        tcg_op1 = cpu_reg(s, a->rn);
+        tcg_op2 = cpu_reg(s, a->rm);
     } else {
-        if (is_signed) {
-            tcg_gen_ext32s_i64(tcg_op1, cpu_reg(s, rn));
-            tcg_gen_ext32s_i64(tcg_op2, cpu_reg(s, rm));
-        } else {
-            tcg_gen_ext32u_i64(tcg_op1, cpu_reg(s, rn));
-            tcg_gen_ext32u_i64(tcg_op2, cpu_reg(s, rm));
-        }
+        tcg_op1 = tcg_temp_new_i64();
+        tcg_op2 = tcg_temp_new_i64();
+        tcg_gen_ext_i64(tcg_op1, cpu_reg(s, a->rn), mop);
+        tcg_gen_ext_i64(tcg_op2, cpu_reg(s, a->rm), mop);
     }
 
-    if (ra == 31 && !is_sub) {
+    if (a->ra == 31 && !is_sub) {
         /* Special-case MADD with rA == XZR; it is the standard MUL alias */
-        tcg_gen_mul_i64(cpu_reg(s, rd), tcg_op1, tcg_op2);
+        tcg_gen_mul_i64(tcg_rd, tcg_op1, tcg_op2);
     } else {
+        TCGv_i64 tcg_tmp = tcg_temp_new_i64();
+        TCGv_i64 tcg_ra = cpu_reg(s, a->ra);
+
         tcg_gen_mul_i64(tcg_tmp, tcg_op1, tcg_op2);
         if (is_sub) {
-            tcg_gen_sub_i64(cpu_reg(s, rd), cpu_reg(s, ra), tcg_tmp);
+            tcg_gen_sub_i64(tcg_rd, tcg_ra, tcg_tmp);
         } else {
-            tcg_gen_add_i64(cpu_reg(s, rd), cpu_reg(s, ra), tcg_tmp);
+            tcg_gen_add_i64(tcg_rd, tcg_ra, tcg_tmp);
         }
     }
 
     if (!sf) {
-        tcg_gen_ext32u_i64(cpu_reg(s, rd), cpu_reg(s, rd));
+        tcg_gen_ext32u_i64(tcg_rd, tcg_rd);
     }
+    return true;
 }
 
+TRANS(MADD_w, do_muladd, a, false, false, MO_64)
+TRANS(MSUB_w, do_muladd, a, false, true, MO_64)
+TRANS(MADD_x, do_muladd, a, true, false, MO_64)
+TRANS(MSUB_x, do_muladd, a, true, true, MO_64)
+
+TRANS(SMADDL, do_muladd, a, true, false, MO_SL)
+TRANS(SMSUBL, do_muladd, a, true, true, MO_SL)
+TRANS(UMADDL, do_muladd, a, true, false, MO_UL)
+TRANS(UMSUBL, do_muladd, a, true, true, MO_UL)
+
 /* Add/subtract (with carry)
  *  31 30 29 28 27 26 25 24 23 22 21  20  16  15       10  9    5 4   0
  * +--+--+--+------------------------+------+-------------+------+-----+
@@ -8364,13 +8334,10 @@ static void disas_data_proc_reg(DisasContext *s, uint32_t insn)
         disas_cond_select(s, insn);
         break;
 
-    case 0x8 ... 0xf: /* (3 source) */
-        disas_data_proc_3src(s, insn);
-        break;
-
     default:
     do_unallocated:
     case 0x6: /* Data-processing */
+    case 0x8 ... 0xf: /* (3 source) */
         unallocated_encoding(s);
         break;
     }
-- 
2.34.1


