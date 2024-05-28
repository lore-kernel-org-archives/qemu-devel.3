Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25337C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 20:32:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sC3UB-0003wk-Op; Tue, 28 May 2024 16:31:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sC3Ti-00036n-2v
 for qemu-devel@nongnu.org; Tue, 28 May 2024 16:31:27 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sC3TT-0003jx-1o
 for qemu-devel@nongnu.org; Tue, 28 May 2024 16:31:25 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6fdfee2734aso1092538b3a.0
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 13:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716928269; x=1717533069; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aKrSvhZ4zfqh/GPb+/cj48yFSdpfp1Adg3jOfP5+KE4=;
 b=t8I/Qa1HcX0z6/GfYpc10Gx89dDziUskchddhECA7rx/gn8iz2Qa7jki1LG2OTdX8V
 8hjfIvAftn9Z3W4l4YuUflKI0MrEIM4Vzz3nTCXhpvWilCCmHG6ekmIXHc+lGVAJIEfa
 aRaiZ5MmBCVZ/8rVcZmjfK372SL0tQYyMCa+WdGRUjAimfa9kR9CmPc5z1ZCCHey+PZB
 ya7ooo6YSNAFPMJapJNF63ZaZqbLMp/zmx4mRdigmiqx1SqtIDLtDG59aJpTzcqBopQe
 PSs9TbTAjPRdqAp+ZrTZlA5E6lrvI9Vv/PzndzCcg31ieYCVSw9ipOzvGy/3E8CZvHNE
 qjeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716928269; x=1717533069;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aKrSvhZ4zfqh/GPb+/cj48yFSdpfp1Adg3jOfP5+KE4=;
 b=UG3b/CJoYVwAtLh6Zo99PTUqYIuLIAHmF0+kiTJNEke46U3ZA7CZyGf8abChU6MAMF
 0KE5hz+0TZ1yHCARAvWKi1aKCVLh8P4Q64kjOyLQqKqfajg1qX6UsGAGGOA8UXqIW/Yr
 uBGMo6Pd4V7nMwodknWEOPozuMfPsC1j6DXKnNY+Op8gAl8hUHr6+UZm3DPjyrvi974h
 hDjlbinLW+QGYPdfJH2WPRLCt95OMzPJOIaOFYrfpF+Xc1oU4eRn/NoEy1SaYQTNdfGa
 1h+jE4tJFscQWXrsnZKO8MG88TAnLnw94v2hAiQP2ip8JZkPVGEudqn4Q2SgghwfeKSm
 xvzg==
X-Gm-Message-State: AOJu0YwRyauPXSK/w/0qsPb8Hn6y/XW90ed0s9orQmGCoirarO2iyTyB
 YjjivbP+31t3Tn1aUgJLhaQ9skf7seaDFSWqlt5jnyin2CmNXYuIFxjo5b1OR4LYMTZbIkByC4s
 E
X-Google-Smtp-Source: AGHT+IEktbfqvP4KC1TBRpQp2imFJCFiRxpwpqEVCHAGy/k0TTHT0cFvYgk9opk7Vn2+FTGcXW60UQ==
X-Received: by 2002:a05:6a00:4088:b0:6f4:4441:a32b with SMTP id
 d2e1a72fcca58-6f8f40962bbmr13754413b3a.26.1716928269595; 
 Tue, 28 May 2024 13:31:09 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fbd3dbe9sm7042036b3a.10.2024.05.28.13.31.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 13:31:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 27/33] target/arm: Convert SABA, SABD, UABA,
 UABD to decodetree
Date: Tue, 28 May 2024 13:30:38 -0700
Message-Id: <20240528203044.612851-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528203044.612851-1-richard.henderson@linaro.org>
References: <20240528203044.612851-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/a64.decode      |  4 ++++
 target/arm/tcg/translate-a64.c | 22 ++++++----------------
 2 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index bc98963bc5..07b604ec30 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -922,6 +922,10 @@ SMAX_v          0.00 1110 ..1 ..... 01100 1 ..... ..... @qrrr_e
 UMAX_v          0.10 1110 ..1 ..... 01100 1 ..... ..... @qrrr_e
 SMIN_v          0.00 1110 ..1 ..... 01101 1 ..... ..... @qrrr_e
 UMIN_v          0.10 1110 ..1 ..... 01101 1 ..... ..... @qrrr_e
+SABD_v          0.00 1110 ..1 ..... 01110 1 ..... ..... @qrrr_e
+UABD_v          0.10 1110 ..1 ..... 01110 1 ..... ..... @qrrr_e
+SABA_v          0.00 1110 ..1 ..... 01111 1 ..... ..... @qrrr_e
+UABA_v          0.10 1110 ..1 ..... 01111 1 ..... ..... @qrrr_e
 
 ### Advanced SIMD scalar x indexed element
 
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index db6f59df17..61afbc434f 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5464,6 +5464,10 @@ TRANS(SMAX_v, do_gvec_fn3_no64, a, tcg_gen_gvec_smax)
 TRANS(UMAX_v, do_gvec_fn3_no64, a, tcg_gen_gvec_umax)
 TRANS(SMIN_v, do_gvec_fn3_no64, a, tcg_gen_gvec_smin)
 TRANS(UMIN_v, do_gvec_fn3_no64, a, tcg_gen_gvec_umin)
+TRANS(SABA_v, do_gvec_fn3_no64, a, gen_gvec_saba)
+TRANS(UABA_v, do_gvec_fn3_no64, a, gen_gvec_uaba)
+TRANS(SABD_v, do_gvec_fn3_no64, a, gen_gvec_sabd)
+TRANS(UABD_v, do_gvec_fn3_no64, a, gen_gvec_uabd)
 
 static bool do_cmop_v(DisasContext *s, arg_qrrr_e *a, TCGCond cond)
 {
@@ -10929,8 +10933,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
             return;
         }
         /* fall through */
-    case 0xe: /* SABD, UABD */
-    case 0xf: /* SABA, UABA */
     case 0x12: /* MLA, MLS */
         if (size == 3) {
             unallocated_encoding(s);
@@ -10963,6 +10965,8 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
     case 0x0b: /* SQRSHL, UQRSHL */
     case 0x0c: /* SMAX, UMAX */
     case 0x0d: /* SMIN, UMIN */
+    case 0x0e: /* SABD, UABD */
+    case 0x0f: /* SABA, UABA */
     case 0x10: /* ADD, SUB */
     case 0x11: /* CMTST, CMEQ */
         unallocated_encoding(s);
@@ -10974,20 +10978,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
     }
 
     switch (opcode) {
-    case 0xe: /* SABD, UABD */
-        if (u) {
-            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_uabd, size);
-        } else {
-            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_sabd, size);
-        }
-        return;
-    case 0xf: /* SABA, UABA */
-        if (u) {
-            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_uaba, size);
-        } else {
-            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_saba, size);
-        }
-        return;
     case 0x13: /* MUL, PMUL */
         if (!u) { /* MUL */
             gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_mul, size);
-- 
2.34.1


