Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E114C25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 23:28:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAeJD-0003LI-Lw; Fri, 24 May 2024 19:26:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAeI6-0007zn-09
 for qemu-devel@nongnu.org; Fri, 24 May 2024 19:25:38 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAeHt-0006wE-CM
 for qemu-devel@nongnu.org; Fri, 24 May 2024 19:25:37 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6fcbd812b33so242631b3a.3
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 16:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716593115; x=1717197915; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uJ0q4kYSciCCJ5iNnH0cT/11J4ZEDfTPyyL262CCOCQ=;
 b=m/PfeRW9mPt6DQ7OXihTEGWyVk3C/nVlqDJT78WF/JSffTqiW9g6W7ohSlHRzrU5X3
 rDvrDu1doTxB5muO9Vr/e8TwmAmhAhe4PQLByQUrNlBz1C1nKeboUz/pISa2zTNOZJd1
 9qfSMYi666m4txlCQm3omIDb587UKkANCLit1N6X9Qvtp1xBr9GytG2q3/0KXrimkGct
 DP10Wo0f2jjUwy3kNmTcIljSnusRDXchaGGkjsF5VCJh3G61Wro5c/qlELwIpBAomNnF
 TzxeLx/mCwr5OD4r2Qe2Nn+syj0DgBqtt4qLoZTY83aaDYklx20N245CDOMdKqAKUemF
 ECAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716593115; x=1717197915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uJ0q4kYSciCCJ5iNnH0cT/11J4ZEDfTPyyL262CCOCQ=;
 b=ZgpqcCi+ffI+7zKqsz5Kvk6667r4ZSDQ4dDNA0k2cnJXYQw6smW6SZmVrRKdLNOP/2
 R7neBXTIzFW2vmZpc1Pge4gXRFmcWywvUMM3TjYxRzq8SH3QppM8EAG2/KWjJ3GvDdYZ
 1Y9wwSH/1KOZXH8qUZb2eJhYUxyy0rc6BFOgQzJGrI8VWPv6BPJw/2c//rwUrBVkbkIe
 HSMi6lmlkL367WTIJMRZ8tWz+GzHa5Nff5zS+3bOUKVI3JIqcNtT+J6nIEJTMF+JQ5zh
 WA/XpNyy1DGHVeLuIdpb7cLfUQqxT8JOswOQpQNgqiiPzTxkeFAFqD4h9haCpVsntrNp
 PKdg==
X-Gm-Message-State: AOJu0YyeTVwGtQvzExLknOBIp+Ru3qXpmdVI352DTZFlQRs/RJnWHNVa
 pi6p/Qo+/SAXvMmH3z0UHFCR9hpRA4g4el9SKnXRjyv0njJk7GfZFwbMZC7BWh5oVTOTAUtGbD8
 Z
X-Google-Smtp-Source: AGHT+IHLFahYjw3fYU81v2cdjJZyQlZTyUz7GRQhTeoEVUyx6hl63AGokg/huEw2Jar7pjQDDN6cog==
X-Received: by 2002:a05:6a00:418a:b0:6e6:970f:a809 with SMTP id
 d2e1a72fcca58-6f8f392b6a8mr4068086b3a.20.1716593115251; 
 Fri, 24 May 2024 16:25:15 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fbf2cfd1sm1591695b3a.3.2024.05.24.16.25.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 16:25:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 60/67] target/arm: Convert SMAX, SMIN, UMAX,
 UMIN to decodetree
Date: Fri, 24 May 2024 16:21:14 -0700
Message-Id: <20240524232121.284515-61-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240524232121.284515-1-richard.henderson@linaro.org>
References: <20240524232121.284515-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 target/arm/tcg/a64.decode      |  4 ++++
 target/arm/tcg/translate-a64.c | 22 ++++++----------------
 2 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 1c448b4f7c..bc98963bc5 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -918,6 +918,10 @@ SHSUB_v         0.00 1110 ..1 ..... 00100 1 ..... ..... @qrrr_e
 UHSUB_v         0.10 1110 ..1 ..... 00100 1 ..... ..... @qrrr_e
 SRHADD_v        0.00 1110 ..1 ..... 00010 1 ..... ..... @qrrr_e
 URHADD_v        0.10 1110 ..1 ..... 00010 1 ..... ..... @qrrr_e
+SMAX_v          0.00 1110 ..1 ..... 01100 1 ..... ..... @qrrr_e
+UMAX_v          0.10 1110 ..1 ..... 01100 1 ..... ..... @qrrr_e
+SMIN_v          0.00 1110 ..1 ..... 01101 1 ..... ..... @qrrr_e
+UMIN_v          0.10 1110 ..1 ..... 01101 1 ..... ..... @qrrr_e
 
 ### Advanced SIMD scalar x indexed element
 
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 9ef5de6755..db6f59df17 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5460,6 +5460,10 @@ TRANS(SHSUB_v, do_gvec_fn3_no64, a, gen_gvec_shsub)
 TRANS(UHSUB_v, do_gvec_fn3_no64, a, gen_gvec_uhsub)
 TRANS(SRHADD_v, do_gvec_fn3_no64, a, gen_gvec_srhadd)
 TRANS(URHADD_v, do_gvec_fn3_no64, a, gen_gvec_urhadd)
+TRANS(SMAX_v, do_gvec_fn3_no64, a, tcg_gen_gvec_smax)
+TRANS(UMAX_v, do_gvec_fn3_no64, a, tcg_gen_gvec_umax)
+TRANS(SMIN_v, do_gvec_fn3_no64, a, tcg_gen_gvec_smin)
+TRANS(UMIN_v, do_gvec_fn3_no64, a, tcg_gen_gvec_umin)
 
 static bool do_cmop_v(DisasContext *s, arg_qrrr_e *a, TCGCond cond)
 {
@@ -10925,8 +10929,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
             return;
         }
         /* fall through */
-    case 0xc: /* SMAX, UMAX */
-    case 0xd: /* SMIN, UMIN */
     case 0xe: /* SABD, UABD */
     case 0xf: /* SABA, UABA */
     case 0x12: /* MLA, MLS */
@@ -10959,6 +10961,8 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
     case 0x09: /* SQSHL, UQSHL */
     case 0x0a: /* SRSHL, URSHL */
     case 0x0b: /* SQRSHL, UQRSHL */
+    case 0x0c: /* SMAX, UMAX */
+    case 0x0d: /* SMIN, UMIN */
     case 0x10: /* ADD, SUB */
     case 0x11: /* CMTST, CMEQ */
         unallocated_encoding(s);
@@ -10970,20 +10974,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
     }
 
     switch (opcode) {
-    case 0x0c: /* SMAX, UMAX */
-        if (u) {
-            gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_umax, size);
-        } else {
-            gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_smax, size);
-        }
-        return;
-    case 0x0d: /* SMIN, UMIN */
-        if (u) {
-            gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_umin, size);
-        } else {
-            gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_smin, size);
-        }
-        return;
     case 0xe: /* SABD, UABD */
         if (u) {
             gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_uabd, size);
-- 
2.34.1


