Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD62EC25B7D
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 23:27:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAeEe-0006t6-TS; Fri, 24 May 2024 19:22:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAeEd-0006qr-Ng
 for qemu-devel@nongnu.org; Fri, 24 May 2024 19:22:03 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAeEV-0005uR-T2
 for qemu-devel@nongnu.org; Fri, 24 May 2024 19:22:03 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1f32448e8fbso26445425ad.1
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 16:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716592914; x=1717197714; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=usPxXxgkBRoUUd22MEqXzle6GxZ0MJTfoUCJ8+mguX4=;
 b=qeVlB3OhBMHXaXo74mmiuMYMNNGWHCIe4NOwOH+0M9Bq1IJOkVro3CVWCGJ+TlBUSc
 x2iGGC9PqqYBrujEDq3+rOjgOTH9OJodEWCpeITZ3bkDWmFxsXWkvCLLK5SL0Vl95oIY
 A/J1Baq1ruGE4Af4TLROhduKoA+w0iCvZX6pVfyW/f6Qkn+r5PpQYEmfcXF9nVLVZmK7
 VG2ABvR+L3jdtxb1TI9nIU64X3gCCzCQbzJu8ZsMzIIAXk27uu4WTzjorUr5+lI3Si5o
 iVNjee8RMw7GkafqbH9Hu1NL+o499ejtul3lYQEIdKVxOLjhT3E5aL6Fb9B4sh8vgd+T
 PuYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716592914; x=1717197714;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=usPxXxgkBRoUUd22MEqXzle6GxZ0MJTfoUCJ8+mguX4=;
 b=rgUR6qcGtn7LbngXXVE9PSmFt4GJZz4eaGgDYB+05xt71LMvOqKF27WG+Lg6zilx/n
 Lo08U5QPB/L1WDnJi0F7VXWpTKFEBUthPHevg6CLW5uxm4vUOZmaz7hl99mfPncsxsas
 g21YV7SR1K4i6Pa32qSAqWBDA0FnnEQdGj5Uff1WCAQsV4OAmCeIHkrliLyJLD2B8khL
 K8e4ZqHsyyUyOoBDzk58mJbNCkJDRiggPMbHG51icLWxwCRWWeWovxnhl81c5mUfyNyq
 /hqp6hBKDzn5qHlaRix6vnwvPEYMrxpKr4IcJyk3abywJZmHzg2e4+xsM67rE8FmWc2t
 oLOw==
X-Gm-Message-State: AOJu0YzbpugTQGNgEgRhYjnx4Y861FF4ODnvWGd6NrCEotftIBjJxz0T
 9Yp3DwG0dmVtMlB8olChGHqbtg2YM0Xduqxj8psjApmni1hJ6/ABkPOW4TZQrwzk2gVP9ffVfn1
 j
X-Google-Smtp-Source: AGHT+IGeQHBA9DUm7xu9ueo+EV6IN3HtXSRwED8+T+Sh+/X0tDSHRWmlmWC0KWgwyEh+rjOx7r1LWQ==
X-Received: by 2002:a17:902:d483:b0:1f3:6b1:a1bf with SMTP id
 d9443c01a7336-1f4486b9a9amr41558545ad.14.1716592914464; 
 Fri, 24 May 2024 16:21:54 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c759ceesm19178305ad.10.2024.05.24.16.21.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 16:21:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 36/67] target/arm: Convert disas_simd_3same_logic to
 decodetree
Date: Fri, 24 May 2024 16:20:50 -0700
Message-Id: <20240524232121.284515-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240524232121.284515-1-richard.henderson@linaro.org>
References: <20240524232121.284515-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

This includes AND, ORR, EOR, BIC, ORN, BSF, BIT, BIF.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/a64.decode      | 10 +++++
 target/arm/tcg/translate-a64.c | 68 ++++++++++------------------------
 2 files changed, 29 insertions(+), 49 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 7e993ed345..f48adef5bb 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -55,6 +55,7 @@
 @rrr_q1e3       ........ ... rm:5 ...... rn:5 rd:5      &qrrr_e q=1 esz=3
 @rrrr_q1e3      ........ ... rm:5 . ra:5 rn:5 rd:5      &qrrrr_e q=1 esz=3
 
+@qrrr_b         . q:1 ...... ... rm:5 ...... rn:5 rd:5  &qrrr_e esz=0
 @qrrr_h         . q:1 ...... ... rm:5 ...... rn:5 rd:5  &qrrr_e esz=1
 @qrrr_sd        . q:1 ...... ... rm:5 ...... rn:5 rd:5  &qrrr_e esz=%esz_sd
 @qrrr_e         . q:1 ...... esz:2 . rm:5 ...... rn:5 rd:5  &qrrr_e
@@ -847,6 +848,15 @@ SMINP_v         0.00 1110 ..1 ..... 10101 1 ..... ..... @qrrr_e
 UMAXP_v         0.10 1110 ..1 ..... 10100 1 ..... ..... @qrrr_e
 UMINP_v         0.10 1110 ..1 ..... 10101 1 ..... ..... @qrrr_e
 
+AND_v           0.00 1110 001 ..... 00011 1 ..... ..... @qrrr_b
+BIC_v           0.00 1110 011 ..... 00011 1 ..... ..... @qrrr_b
+ORR_v           0.00 1110 101 ..... 00011 1 ..... ..... @qrrr_b
+ORN_v           0.00 1110 111 ..... 00011 1 ..... ..... @qrrr_b
+EOR_v           0.10 1110 001 ..... 00011 1 ..... ..... @qrrr_b
+BSL_v           0.10 1110 011 ..... 00011 1 ..... ..... @qrrr_b
+BIT_v           0.10 1110 101 ..... 00011 1 ..... ..... @qrrr_b
+BIF_v           0.10 1110 111 ..... 00011 1 ..... ..... @qrrr_b
+
 ### Advanced SIMD scalar x indexed element
 
 FMUL_si         0101 1111 00 .. .... 1001 . 0 ..... .....   @rrx_h
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index a4ff1fd202..9167e4d0bd 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5280,6 +5280,24 @@ TRANS(SMINP_v, do_gvec_fn3_no64, a, gen_gvec_sminp)
 TRANS(UMAXP_v, do_gvec_fn3_no64, a, gen_gvec_umaxp)
 TRANS(UMINP_v, do_gvec_fn3_no64, a, gen_gvec_uminp)
 
+TRANS(AND_v, do_gvec_fn3, a, tcg_gen_gvec_and)
+TRANS(BIC_v, do_gvec_fn3, a, tcg_gen_gvec_andc)
+TRANS(ORR_v, do_gvec_fn3, a, tcg_gen_gvec_or)
+TRANS(ORN_v, do_gvec_fn3, a, tcg_gen_gvec_orc)
+TRANS(EOR_v, do_gvec_fn3, a, tcg_gen_gvec_xor)
+
+static bool do_bitsel(DisasContext *s, bool is_q, int d, int a, int b, int c)
+{
+    if (fp_access_check(s)) {
+        gen_gvec_fn4(s, is_q, d, a, b, c, tcg_gen_gvec_bitsel, 0);
+    }
+    return true;
+}
+
+TRANS(BSL_v, do_bitsel, a->q, a->rd, a->rd, a->rn, a->rm)
+TRANS(BIT_v, do_bitsel, a->q, a->rd, a->rm, a->rn, a->rd)
+TRANS(BIF_v, do_bitsel, a->q, a->rd, a->rm, a->rd, a->rn)
+
 /*
  * Advanced SIMD scalar/vector x indexed element
  */
@@ -10901,52 +10919,6 @@ static void disas_simd_three_reg_diff(DisasContext *s, uint32_t insn)
     }
 }
 
-/* Logic op (opcode == 3) subgroup of C3.6.16. */
-static void disas_simd_3same_logic(DisasContext *s, uint32_t insn)
-{
-    int rd = extract32(insn, 0, 5);
-    int rn = extract32(insn, 5, 5);
-    int rm = extract32(insn, 16, 5);
-    int size = extract32(insn, 22, 2);
-    bool is_u = extract32(insn, 29, 1);
-    bool is_q = extract32(insn, 30, 1);
-
-    if (!fp_access_check(s)) {
-        return;
-    }
-
-    switch (size + 4 * is_u) {
-    case 0: /* AND */
-        gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_and, 0);
-        return;
-    case 1: /* BIC */
-        gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_andc, 0);
-        return;
-    case 2: /* ORR */
-        gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_or, 0);
-        return;
-    case 3: /* ORN */
-        gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_orc, 0);
-        return;
-    case 4: /* EOR */
-        gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_xor, 0);
-        return;
-
-    case 5: /* BSL bitwise select */
-        gen_gvec_fn4(s, is_q, rd, rd, rn, rm, tcg_gen_gvec_bitsel, 0);
-        return;
-    case 6: /* BIT, bitwise insert if true */
-        gen_gvec_fn4(s, is_q, rd, rm, rn, rd, tcg_gen_gvec_bitsel, 0);
-        return;
-    case 7: /* BIF, bitwise insert if false */
-        gen_gvec_fn4(s, is_q, rd, rm, rd, rn, tcg_gen_gvec_bitsel, 0);
-        return;
-
-    default:
-        g_assert_not_reached();
-    }
-}
-
 /* Integer op subgroup of C3.6.16. */
 static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
 {
@@ -11212,12 +11184,10 @@ static void disas_simd_three_reg_same(DisasContext *s, uint32_t insn)
     int opcode = extract32(insn, 11, 5);
 
     switch (opcode) {
-    case 0x3: /* logic ops */
-        disas_simd_3same_logic(s, insn);
-        break;
     default:
         disas_simd_3same_int(s, insn);
         break;
+    case 0x3: /* logic ops */
     case 0x14: /* SMAXP, UMAXP */
     case 0x15: /* SMINP, UMINP */
     case 0x17: /* ADDP */
-- 
2.34.1


