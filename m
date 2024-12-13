Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B20CEE77183
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:34:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM9Xk-0007pR-Si; Fri, 13 Dec 2024 12:33:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9XX-0007Kd-Re
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:33:23 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9XW-0001cQ-0T
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:33:23 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-385df53e559so1604073f8f.3
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 09:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734111198; x=1734715998; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ia/Pwyy3pQUlvdfiW40J5tPZza+afz7n1+/d2AeByV0=;
 b=KU0jO4+zhKWVEd/ohJUM8pdtiZ+5bwwVytbHMzDkBnF98EE5U7Vysu8/XjtvhkfJOK
 eG/Co/o3OKAS7j+LOPA/4y7+R4UUPBdakH0trapHrL3+zn4wQwBe5AdwQr6/DZd5a4WM
 IgOBPeb0PRUlvaImJtuceBH/yLv+v2EWQ33chK1rgi1f9r/yNi0I+8ZOulbz5VUG30Sk
 1Y/kNMQzSyp6zk+nFu30M3KDLJ82BgoSxU3bozf+76oyCTn1w4cyGRIkWZBlPtDeHqoe
 89EY4/fHLgX0HTJrjS+9Vgm8kzpKNR+dbVDl9XfX88WC9haEtLOGnehf94zd5r80dXOL
 48vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734111198; x=1734715998;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ia/Pwyy3pQUlvdfiW40J5tPZza+afz7n1+/d2AeByV0=;
 b=SZT0wMf5f5/FEaRHFIbUu7IANEntVRFyj2KOW4XbozvT2V6tFBnLyL+UTJENOvoWu8
 TazHbZ0HMUcLWPf2WwPIfX0ygLM7nnhPCaWS3I+kYLWDZEHvLXn+yDsxQN7+RLBbmKU7
 HQWmlCYqofA4EVePPrWNUcHyGl+DObHZwZFPFRcQOdfqcPPVUnPPNmANfpWoeX2QMDLv
 OeSqjmhajSSPvBGHT0EfBKpapg60M5bBbhUCCkE2uDZl81Vdj9+XE82VYzsiYMz/RhUV
 Vb9YWXet762xoeoSCvg5p1KrN7VNFg/MtbJccw+1oNt7XtSw5abU8gQbzPF9FAsBfUpV
 EBRw==
X-Gm-Message-State: AOJu0YwPad237Ch6yICPT2+oxsObIVd8C7qq3rsHTVIZJXt+lCXvY1Bv
 XorltC9xIatmY2wvO8hV7GwhKRh+1Khj7x29aK/JDTyUjCJquR0pc9rKCriOx2ygOhqkjl2txbL
 4
X-Gm-Gg: ASbGncsEQyd8ePLoLgmj0C+3TZNWGDfnJrQsP+Sg5vJj2OFM34TVrDjDGTKsBWy6lp2
 hKeL5HjfCckD0yLLSgswoP2eYR2VDbrO6tRpxGx8Z5ShGE4N56+4aQGua814Vbbn+67n2nxl43J
 piAqzCwQIL6KKABrtCzbvd6Bm7wwWIW3Nmz+F1bvnFuzfZpWsz0V9808b+DMZBgRXnLkGUqr/vI
 Hlo/ImIdFwAvWyxxhtrER8KWdqe2fDj2MWJDWsK1J69wqPB2embIFrmZmJJ8w==
X-Google-Smtp-Source: AGHT+IEIrTww9f24WwDXOYG+qYDyk05y5ip9uWUW91AplMnviqyNZoTXGMTQ5MkzGiLha7bMsicjWg==
X-Received: by 2002:a5d:6c66:0:b0:385:f44a:a53 with SMTP id
 ffacd0b85a97d-38880af133amr3037422f8f.4.1734111197763; 
 Fri, 13 Dec 2024 09:33:17 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80162ddsm87026f8f.37.2024.12.13.09.33.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 09:33:17 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 43/85] target/arm: Convert handle_rev to decodetree
Date: Fri, 13 Dec 2024 17:31:47 +0000
Message-Id: <20241213173229.3308926-44-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213173229.3308926-1-peter.maydell@linaro.org>
References: <20241213173229.3308926-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

This includes REV16, REV32, REV64.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241211163036.2297116-44-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |  5 +++
 target/arm/tcg/translate-a64.c | 79 +++-------------------------------
 2 files changed, 10 insertions(+), 74 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 247d3a7bda4..05f1bc99b52 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -73,6 +73,7 @@
 
 @qrr_b          . q:1 ...... .. ...... ...... rn:5 rd:5  &qrr_e esz=0
 @qrr_h          . q:1 ...... .. ...... ...... rn:5 rd:5  &qrr_e esz=1
+@qrr_bh         . q:1 ...... . esz:1 ...... ...... rn:5 rd:5  &qrr_e
 @qrr_e          . q:1 ...... esz:2 ...... ...... rn:5 rd:5  &qrr_e
 
 @qrrr_b         . q:1 ...... ... rm:5 ...... rn:5 rd:5  &qrrr_e esz=0
@@ -1657,3 +1658,7 @@ CMGE0_v         0.10 1110 ..1 00000 10001 0 ..... .....     @qrr_e
 CMEQ0_v         0.00 1110 ..1 00000 10011 0 ..... .....     @qrr_e
 CMLE0_v         0.10 1110 ..1 00000 10011 0 ..... .....     @qrr_e
 CMLT0_v         0.00 1110 ..1 00000 10101 0 ..... .....     @qrr_e
+
+REV16_v         0.00 1110 001 00000 00011 0 ..... .....     @qrr_b
+REV32_v         0.10 1110 0.1 00000 00001 0 ..... .....     @qrr_bh
+REV64_v         0.00 1110 ..1 00000 00001 0 ..... .....     @qrr_e
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 547c6dc5cc0..f57b5e28556 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8939,6 +8939,8 @@ TRANS(CMGE0_v, do_gvec_fn2, a, gen_gvec_cge0)
 TRANS(CMLT0_v, do_gvec_fn2, a, gen_gvec_clt0)
 TRANS(CMLE0_v, do_gvec_fn2, a, gen_gvec_cle0)
 TRANS(CMEQ0_v, do_gvec_fn2, a, gen_gvec_ceq0)
+TRANS(REV16_v, do_gvec_fn2, a, gen_gvec_rev16)
+TRANS(REV32_v, do_gvec_fn2, a, gen_gvec_rev32)
 
 static bool do_gvec_fn2_bhs(DisasContext *s, arg_qrr_e *a, GVecGen2Fn *fn)
 {
@@ -8953,6 +8955,7 @@ static bool do_gvec_fn2_bhs(DisasContext *s, arg_qrr_e *a, GVecGen2Fn *fn)
 
 TRANS(CLS_v, do_gvec_fn2_bhs, a, gen_gvec_cls)
 TRANS(CLZ_v, do_gvec_fn2_bhs, a, gen_gvec_clz)
+TRANS(REV64_v, do_gvec_fn2_bhs, a, gen_gvec_rev64)
 
 /* Common vector code for handling integer to FP conversion */
 static void handle_simd_intfp_conv(DisasContext *s, int rd, int rn,
@@ -9882,76 +9885,6 @@ static void handle_2misc_widening(DisasContext *s, int opcode, bool is_q,
     }
 }
 
-static void handle_rev(DisasContext *s, int opcode, bool u,
-                       bool is_q, int size, int rn, int rd)
-{
-    int op = (opcode << 1) | u;
-    int opsz = op + size;
-    int grp_size = 3 - opsz;
-    int dsize = is_q ? 128 : 64;
-    int i;
-
-    if (opsz >= 3) {
-        unallocated_encoding(s);
-        return;
-    }
-
-    if (!fp_access_check(s)) {
-        return;
-    }
-
-    if (size == 0) {
-        /* Special case bytes, use bswap op on each group of elements */
-        int groups = dsize / (8 << grp_size);
-
-        for (i = 0; i < groups; i++) {
-            TCGv_i64 tcg_tmp = tcg_temp_new_i64();
-
-            read_vec_element(s, tcg_tmp, rn, i, grp_size);
-            switch (grp_size) {
-            case MO_16:
-                tcg_gen_bswap16_i64(tcg_tmp, tcg_tmp, TCG_BSWAP_IZ);
-                break;
-            case MO_32:
-                tcg_gen_bswap32_i64(tcg_tmp, tcg_tmp, TCG_BSWAP_IZ);
-                break;
-            case MO_64:
-                tcg_gen_bswap64_i64(tcg_tmp, tcg_tmp);
-                break;
-            default:
-                g_assert_not_reached();
-            }
-            write_vec_element(s, tcg_tmp, rd, i, grp_size);
-        }
-        clear_vec_high(s, is_q, rd);
-    } else {
-        int revmask = (1 << grp_size) - 1;
-        int esize = 8 << size;
-        int elements = dsize / esize;
-        TCGv_i64 tcg_rn = tcg_temp_new_i64();
-        TCGv_i64 tcg_rd[2];
-
-        for (i = 0; i < 2; i++) {
-            tcg_rd[i] = tcg_temp_new_i64();
-            tcg_gen_movi_i64(tcg_rd[i], 0);
-        }
-
-        for (i = 0; i < elements; i++) {
-            int e_rev = (i & 0xf) ^ revmask;
-            int w = (e_rev * esize) / 64;
-            int o = (e_rev * esize) % 64;
-
-            read_vec_element(s, tcg_rn, rn, i, size);
-            tcg_gen_deposit_i64(tcg_rd[w], tcg_rd[w], tcg_rn, o, esize);
-        }
-
-        for (i = 0; i < 2; i++) {
-            write_vec_element(s, tcg_rd[i], rd, i, MO_64);
-        }
-        clear_vec_high(s, true, rd);
-    }
-}
-
 static void handle_2misc_pairwise(DisasContext *s, int opcode, bool u,
                                   bool is_q, int size, int rn, int rd)
 {
@@ -10066,10 +9999,6 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
     TCGv_ptr tcg_fpstatus;
 
     switch (opcode) {
-    case 0x0: /* REV64, REV32 */
-    case 0x1: /* REV16 */
-        handle_rev(s, opcode, u, is_q, size, rn, rd);
-        return;
     case 0x12: /* XTN, XTN2, SQXTUN, SQXTUN2 */
     case 0x14: /* SQXTN, SQXTN2, UQXTN, UQXTN2 */
         if (size == 3) {
@@ -10272,6 +10201,8 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
         break;
     }
     default:
+    case 0x0: /* REV64, REV32 */
+    case 0x1: /* REV16 */
     case 0x3: /* SUQADD, USQADD */
     case 0x4: /* CLS, CLZ */
     case 0x5: /* CNT, NOT, RBIT */
-- 
2.34.1


