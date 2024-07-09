Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F1F3C3DA45
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 00:07:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQyNJ-00075o-5J; Mon, 08 Jul 2024 20:06:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sQyNB-0006WV-TU
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 20:06:22 -0400
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sQyN9-0001vw-Hy
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 20:06:21 -0400
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-5c66ffadb7aso1005071eaf.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 17:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720483578; x=1721088378; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UrG/qJa87Emtp5mDVy7Ij72pawLQBfOjxl73tyWREWs=;
 b=sZqrVJA34phM4rl7ICiqqizqtMfZLiRgxXtC1X4glDppX5xG10RDAyJo7//aBAg21t
 d7Hpwnl3RcbiPSvS7T1mvv0qXF9jrmcMNe0onP6ZA9g6GJYT4ytF5rIImT9W4x1u37lQ
 STU+K63abEWmrzBnDadf0VNbbOANQx+TDJ7olTgB51qKKAkxQR/zdP2EH9oQDzGgCtBW
 MOuUj0K0IJ2NohMyCBdFVMMgppchp7jaM7BU55fnb8R7Hjwv9/A6xXrpWxAguitZyk+2
 fClrn0HgVH/y24YTgXaqAiCPN5lTeUkXsT5h50FlY1j1GYdw4hsPJdGFY/pO4Er8HUll
 NPGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720483578; x=1721088378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UrG/qJa87Emtp5mDVy7Ij72pawLQBfOjxl73tyWREWs=;
 b=VR7wcOu5gKll8yh9ltvLruQi7XolSdeQ3wwLW6YfCcGVew40QDrIvhwHscPn+bBZPr
 K23ab2Xh4YbON79B7NcJB1SrazwMDGg8+WluU9ydQkNjV0aB4GbmV+Uj/QArTBnCxZz4
 fbzdtn1ZvOaholRkAI7DC4tbnb+/X86WPEfyFwZSrSUEO3yaexV8zxRocD/R/lhxMUZM
 tSX+10IHHhyG/yTOUzJ/CCpDi02dZkRokM+7HYfFcDkrOXEFn2t8rq2vcbbTKGrdbjgl
 rCfzz0AHEBYJMHGF4+eFDRINyUMpT6L9+xsAdBoIa8c3+CjFdzHzG20AhN9oog5AZ1pf
 xvkg==
X-Gm-Message-State: AOJu0YxWRr+S+IljpDUnCJiU4DT19XloDhtTcdweH9EImNxrK4/IJ60f
 yFjhznnfdxo1AUVp6bcZoYS+yR2yXHODvfBLO08bp04gyCDqWhaMjt++wiljW/Ro/MK7gxoZ4GR
 Woc8=
X-Google-Smtp-Source: AGHT+IHW2f/ucV5eZi77VTJZ0Ri+ijERQbkZRecMAmkixTh2SW0+edfrbFwgVuPgIvZ+54RnORpNjw==
X-Received: by 2002:a05:6359:6d05:b0:1aa:d969:b981 with SMTP id
 e5c5f4694b2df-1aade05b1f7mr96099655d.5.1720483578097; 
 Mon, 08 Jul 2024 17:06:18 -0700 (PDT)
Received: from stoup.. (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-77d682b3fefsm316617a12.76.2024.07.08.17.06.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jul 2024 17:06:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 6/6] target/arm: Convert PMULL to decodetree
Date: Mon,  8 Jul 2024 17:06:10 -0700
Message-ID: <20240709000610.382391-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709000610.382391-1-richard.henderson@linaro.org>
References: <20240709000610.382391-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc34.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 94 +++++-----------------------------
 target/arm/tcg/a64.decode      |  3 ++
 2 files changed, 15 insertions(+), 82 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 3e0dacdd63..559a6cd799 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -6003,6 +6003,18 @@ TRANS(SUBHN, do_addsub_highnarrow, a, true, false)
 TRANS(RADDHN, do_addsub_highnarrow, a, false, true)
 TRANS(RSUBHN, do_addsub_highnarrow, a, true, true)
 
+static bool do_pmull(DisasContext *s, arg_qrrr_e *a, gen_helper_gvec_3 *fn)
+{
+    if (fp_access_check(s)) {
+        /* The Q field specifies lo/hi half input for these insns.  */
+        gen_gvec_op3_ool(s, true, a->rd, a->rn, a->rm, a->q, fn);
+    }
+    return true;
+}
+
+TRANS(PMULL_p8, do_pmull, a, gen_helper_neon_pmull_h)
+TRANS_FEAT(PMULL_p64, aa64_pmull, do_pmull, a, gen_helper_gvec_pmull_q)
+
 /*
  * Advanced SIMD scalar/vector x indexed element
  */
@@ -10867,87 +10879,6 @@ static void disas_simd_shift_imm(DisasContext *s, uint32_t insn)
     }
 }
 
-/* AdvSIMD three different
- *   31  30  29 28       24 23  22  21 20  16 15    12 11 10 9    5 4    0
- * +---+---+---+-----------+------+---+------+--------+-----+------+------+
- * | 0 | Q | U | 0 1 1 1 0 | size | 1 |  Rm  | opcode | 0 0 |  Rn  |  Rd  |
- * +---+---+---+-----------+------+---+------+--------+-----+------+------+
- */
-static void disas_simd_three_reg_diff(DisasContext *s, uint32_t insn)
-{
-    /* Instructions in this group fall into three basic classes
-     * (in each case with the operation working on each element in
-     * the input vectors):
-     * (1) widening 64 x 64 -> 128 (with possibly Vd as an extra
-     *     128 bit input)
-     * (2) wide 64 x 128 -> 128
-     * (3) narrowing 128 x 128 -> 64
-     * Here we do initial decode, catch unallocated cases and
-     * dispatch to separate functions for each class.
-     */
-    int is_q = extract32(insn, 30, 1);
-    int is_u = extract32(insn, 29, 1);
-    int size = extract32(insn, 22, 2);
-    int opcode = extract32(insn, 12, 4);
-    int rm = extract32(insn, 16, 5);
-    int rn = extract32(insn, 5, 5);
-    int rd = extract32(insn, 0, 5);
-
-    switch (opcode) {
-    case 14: /* PMULL, PMULL2 */
-        if (is_u) {
-            unallocated_encoding(s);
-            return;
-        }
-        switch (size) {
-        case 0: /* PMULL.P8 */
-            if (!fp_access_check(s)) {
-                return;
-            }
-            /* The Q field specifies lo/hi half input for this insn.  */
-            gen_gvec_op3_ool(s, true, rd, rn, rm, is_q,
-                             gen_helper_neon_pmull_h);
-            break;
-
-        case 3: /* PMULL.P64 */
-            if (!dc_isar_feature(aa64_pmull, s)) {
-                unallocated_encoding(s);
-                return;
-            }
-            if (!fp_access_check(s)) {
-                return;
-            }
-            /* The Q field specifies lo/hi half input for this insn.  */
-            gen_gvec_op3_ool(s, true, rd, rn, rm, is_q,
-                             gen_helper_gvec_pmull_q);
-            break;
-
-        default:
-            unallocated_encoding(s);
-            break;
-        }
-        return;
-    default:
-    case 0: /* SADDL, SADDL2, UADDL, UADDL2 */
-    case 1: /* SADDW, SADDW2, UADDW, UADDW2 */
-    case 2: /* SSUBL, SSUBL2, USUBL, USUBL2 */
-    case 3: /* SSUBW, SSUBW2, USUBW, USUBW2 */
-    case 4: /* ADDHN, ADDHN2, RADDHN, RADDHN2 */
-    case 5: /* SABAL, SABAL2, UABAL, UABAL2 */
-    case 6: /* SUBHN, SUBHN2, RSUBHN, RSUBHN2 */
-    case 7: /* SABDL, SABDL2, UABDL, UABDL2 */
-    case 8: /* SMLAL, SMLAL2, UMLAL, UMLAL2 */
-    case 9: /* SQDMLAL, SQDMLAL2 */
-    case 10: /* SMLSL, SMLSL2, UMLSL, UMLSL2 */
-    case 11: /* SQDMLSL, SQDMLSL2 */
-    case 12: /* SMULL, SMULL2, UMULL, UMULL2 */
-    case 13: /* SQDMULL, SQDMULL2 */
-        /* opcode 15 not allocated */
-        unallocated_encoding(s);
-        break;
-    }
-}
-
 static void handle_2misc_widening(DisasContext *s, int opcode, bool is_q,
                                   int size, int rn, int rd)
 {
@@ -11897,7 +11828,6 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
  */
 static const AArch64DecodeTable data_proc_simd[] = {
     /* pattern  ,  mask     ,  fn                        */
-    { 0x0e200000, 0x9f200c00, disas_simd_three_reg_diff },
     { 0x0e200800, 0x9f3e0c00, disas_simd_two_reg_misc },
     { 0x0e300800, 0x9f3e0c00, disas_simd_across_lanes },
     /* simd_mod_imm decode is a subset of simd_shift_imm, so must precede it */
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index afb34a8fd4..2922de700c 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1003,6 +1003,9 @@ RADDHN          0.10 1110 ..1 ..... 01000 0 ..... ..... @qrrr_e
 SUBHN           0.00 1110 ..1 ..... 01100 0 ..... ..... @qrrr_e
 RSUBHN          0.10 1110 ..1 ..... 01100 0 ..... ..... @qrrr_e
 
+PMULL_p8        0.00 1110 001 ..... 11100 0 ..... ..... @qrrr_b
+PMULL_p64       0.00 1110 111 ..... 11100 0 ..... ..... @qrrr_b
+
 ### Advanced SIMD scalar x indexed element
 
 FMUL_si         0101 1111 00 .. .... 1001 . 0 ..... .....   @rrx_h
-- 
2.43.0


