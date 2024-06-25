Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E7F7C2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 05:10:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLyPt-00019T-2G; Tue, 25 Jun 2024 01:08:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sLyPo-00014a-FW
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 01:08:24 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sLyPk-0001Wa-0P
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 01:08:23 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-706680d3a25so1875766b3a.0
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 22:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719292097; x=1719896897; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZMOv1zIzE6GspuhwPHSAou1PZaQbe4Ud5p+lD2q/SHc=;
 b=LINO3Bnnn5u8ACllH+r/Ms1H64hcBudwXLON8ap0wQCNa5U4+Aqx4Appc1NQjALf8+
 woOui85FsLIK/DHTnjqM6tEp33q0WCEROXNq/sVnFzwq/sU3RaaPKbDJ2yK4OzmMwzYb
 lgeqzcovOcZBeYdYQUbnaF+9GFcU2E926zz+3DU9geo0H9GHjKiPNGqbABCJU9TvN7WX
 sCz/sE+UiHtgqZQ+zq+FhlnsrqKaWt6boe7aaIQQxtSsp4pm8FZ+4r6kfqiqDK5XMSJ3
 sJSnWry9mDsKUvtmiBv0We6I+rQTJ5lQEHZb2abL76Bb1zF9lMII/CWal+FeOK64KAZR
 X1Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719292097; x=1719896897;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZMOv1zIzE6GspuhwPHSAou1PZaQbe4Ud5p+lD2q/SHc=;
 b=xEhzFFN9ov1G30VJ1zj24ZpK6n/GA5ENtZl0HX70WtJFh5jhKPqWK4eTTcSz5jM8JW
 Pe82gBph9BMV3Jz0nrM/+qiLSM0z66npulnzTIBl0Rdyg5YDKUsAnOsGc9bZDThIJc2E
 H6+HR9WFe2kedo8KHgGvVst+ZZGC05kkM4Y/dZPrOcSi88ek+mPIlYBlT2o1FtMwx70D
 hjaI+dJJz9FkYkSGujVg1/ohka3ZIA+otQmGgFl5DlAgS3CWrHiUfNzrr6JES2lHr0Tc
 KpoB+sI1Hw/2iDC/41SVo8BhlNOwiOKDvsesYf9K+PrBS+/Mt9YBBwKCJ2rbd6pZaFEC
 Wdhw==
X-Gm-Message-State: AOJu0YwBvWRi6rZXhr6MB4z79HzZ1BgeUoYOPINQKBnVg9yCD/908X7N
 K+pNrtO2mSFxtuOwHT/cIdMppXYMPo97dFhptcutTv4wNk1G9EfzFF/xrtTqucWpFbfF3kZ245q
 C
X-Google-Smtp-Source: AGHT+IH2joKZMwdf/1YUzCMjUf9R++cLwe4wJhqRw5t5oyVFapQd4ouqbeYtXq8d/1zizXx42opmAg==
X-Received: by 2002:a05:6a20:3952:b0:1bd:18ee:f141 with SMTP id
 adf61e73a8af0-1bd18eef20cmr1570883637.4.1719292097270; 
 Mon, 24 Jun 2024 22:08:17 -0700 (PDT)
Received: from stoup.. (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f9ebbc72e9sm70843865ad.296.2024.06.24.22.08.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 22:08:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 05/13] target/arm: Convert SDOT, UDOT to decodetree
Date: Mon, 24 Jun 2024 22:08:02 -0700
Message-Id: <20240625050810.1475643-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625050810.1475643-1-richard.henderson@linaro.org>
References: <20240625050810.1475643-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/a64.decode      |  7 +++++
 target/arm/tcg/translate-a64.c | 54 ++++++++++++++++++----------------
 2 files changed, 35 insertions(+), 26 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 613cc9365c..7411d4ba97 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -61,6 +61,7 @@
 
 @qrrr_b         . q:1 ...... ... rm:5 ...... rn:5 rd:5  &qrrr_e esz=0
 @qrrr_h         . q:1 ...... ... rm:5 ...... rn:5 rd:5  &qrrr_e esz=1
+@qrrr_s         . q:1 ...... ... rm:5 ...... rn:5 rd:5  &qrrr_e esz=2
 @qrrr_sd        . q:1 ...... ... rm:5 ...... rn:5 rd:5  &qrrr_e esz=%esz_sd
 @qrrr_e         . q:1 ...... esz:2 . rm:5 ...... rn:5 rd:5  &qrrr_e
 @qr2r_e         . q:1 ...... esz:2 . ..... ...... rm:5 rd:5 &qrrr_e rn=%rd
@@ -946,6 +947,9 @@ SQRDMULH_v      0.10 1110 ..1 ..... 10110 1 ..... ..... @qrrr_e
 SQRDMLAH_v      0.10 1110 ..0 ..... 10000 1 ..... ..... @qrrr_e
 SQRDMLSH_v      0.10 1110 ..0 ..... 10001 1 ..... ..... @qrrr_e
 
+SDOT_v          0.00 1110 100 ..... 10010 1 ..... ..... @qrrr_s
+UDOT_v          0.10 1110 100 ..... 10010 1 ..... ..... @qrrr_s
+
 ### Advanced SIMD scalar x indexed element
 
 FMUL_si         0101 1111 00 .. .... 1001 . 0 ..... .....   @rrx_h
@@ -1020,6 +1024,9 @@ SQRDMLAH_vi     0.10 1111 10 .. .... 1101 . 0 ..... .....   @qrrx_s
 SQRDMLSH_vi     0.10 1111 01 .. .... 1111 . 0 ..... .....   @qrrx_h
 SQRDMLSH_vi     0.10 1111 10 .. .... 1111 . 0 ..... .....   @qrrx_s
 
+SDOT_vi         0.00 1111 10 .. .... 1110 . 0 ..... .....   @qrrx_s
+UDOT_vi         0.10 1111 10 .. .... 1110 . 0 ..... .....   @qrrx_s
+
 # Floating-point conditional select
 
 FCSEL           0001 1110 .. 1 rm:5 cond:4 11 rn:5 rd:5     esz=%esz_hsd
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 32c24c7422..f2e7d8d75c 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5592,6 +5592,18 @@ TRANS(SQRDMULH_v, do_gvec_fn3_no8_no64, a, gen_gvec_sqrdmulh_qc)
 TRANS_FEAT(SQRDMLAH_v, aa64_rdm, do_gvec_fn3_no8_no64, a, gen_gvec_sqrdmlah_qc)
 TRANS_FEAT(SQRDMLSH_v, aa64_rdm, do_gvec_fn3_no8_no64, a, gen_gvec_sqrdmlsh_qc)
 
+static bool do_dot_vector(DisasContext *s, arg_qrrr_e *a,
+                          gen_helper_gvec_4 *fn)
+{
+    if (fp_access_check(s)) {
+        gen_gvec_op4_ool(s, a->q, a->rd, a->rn, a->rm, a->rd, 0, fn);
+    }
+    return true;
+}
+
+TRANS_FEAT(SDOT_v, aa64_dp, do_dot_vector, a, gen_helper_gvec_sdot_b)
+TRANS_FEAT(UDOT_v, aa64_dp, do_dot_vector, a, gen_helper_gvec_udot_b)
+
 /*
  * Advanced SIMD scalar/vector x indexed element
  */
@@ -5914,6 +5926,18 @@ static gen_helper_gvec_4 * const f_vector_idx_sqrdmlsh[2] = {
 TRANS_FEAT(SQRDMLSH_vi, aa64_rdm, do_int3_qc_vector_idx, a,
            f_vector_idx_sqrdmlsh)
 
+static bool do_dot_vector_idx(DisasContext *s, arg_qrrx_e *a,
+                              gen_helper_gvec_4 *fn)
+{
+    if (fp_access_check(s)) {
+        gen_gvec_op4_ool(s, a->q, a->rd, a->rn, a->rm, a->rd, a->idx, fn);
+    }
+    return true;
+}
+
+TRANS_FEAT(SDOT_vi, aa64_dp, do_dot_vector_idx, a, gen_helper_gvec_sdot_idx_b)
+TRANS_FEAT(UDOT_vi, aa64_dp, do_dot_vector_idx, a, gen_helper_gvec_udot_idx_b)
+
 /*
  * Advanced SIMD scalar pairwise
  */
@@ -10890,14 +10914,6 @@ static void disas_simd_three_reg_same_extra(DisasContext *s, uint32_t insn)
     int rot;
 
     switch (u * 16 + opcode) {
-    case 0x02: /* SDOT (vector) */
-    case 0x12: /* UDOT (vector) */
-        if (size != MO_32) {
-            unallocated_encoding(s);
-            return;
-        }
-        feature = dc_isar_feature(aa64_dp, s);
-        break;
     case 0x03: /* USDOT */
         if (size != MO_32) {
             unallocated_encoding(s);
@@ -10947,8 +10963,10 @@ static void disas_simd_three_reg_same_extra(DisasContext *s, uint32_t insn)
         }
         break;
     default:
+    case 0x02: /* SDOT (vector) */
     case 0x10: /* SQRDMLAH (vector) */
     case 0x11: /* SQRDMLSH (vector) */
+    case 0x12: /* UDOT (vector) */
         unallocated_encoding(s);
         return;
     }
@@ -10961,11 +10979,6 @@ static void disas_simd_three_reg_same_extra(DisasContext *s, uint32_t insn)
     }
 
     switch (opcode) {
-    case 0x2: /* SDOT / UDOT */
-        gen_gvec_op4_ool(s, is_q, rd, rn, rm, rd, 0,
-                         u ? gen_helper_gvec_udot_b : gen_helper_gvec_sdot_b);
-        return;
-
     case 0x3: /* USDOT */
         gen_gvec_op4_ool(s, is_q, rd, rn, rm, rd, 0, gen_helper_gvec_usdot_b);
         return;
@@ -12043,13 +12056,6 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
     case 0x0b: /* SQDMULL, SQDMULL2 */
         is_long = true;
         break;
-    case 0x0e: /* SDOT */
-    case 0x1e: /* UDOT */
-        if (is_scalar || size != MO_32 || !dc_isar_feature(aa64_dp, s)) {
-            unallocated_encoding(s);
-            return;
-        }
-        break;
     case 0x0f:
         switch (size) {
         case 0: /* SUDOT */
@@ -12099,12 +12105,14 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
     case 0x09: /* FMUL */
     case 0x0c: /* SQDMULH */
     case 0x0d: /* SQRDMULH */
+    case 0x0e: /* SDOT */
     case 0x10: /* MLA */
     case 0x14: /* MLS */
     case 0x18: /* FMLAL2 */
     case 0x19: /* FMULX */
     case 0x1c: /* FMLSL2 */
     case 0x1d: /* SQRDMLAH */
+    case 0x1e: /* UDOT */
     case 0x1f: /* SQRDMLSH */
         unallocated_encoding(s);
         return;
@@ -12180,12 +12188,6 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
     }
 
     switch (16 * u + opcode) {
-    case 0x0e: /* SDOT */
-    case 0x1e: /* UDOT */
-        gen_gvec_op4_ool(s, is_q, rd, rn, rm, rd, index,
-                         u ? gen_helper_gvec_udot_idx_b
-                         : gen_helper_gvec_sdot_idx_b);
-        return;
     case 0x0f:
         switch (extract32(insn, 22, 2)) {
         case 0: /* SUDOT */
-- 
2.34.1


