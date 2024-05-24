Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24529C25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 23:27:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAeIV-0000Ou-C8; Fri, 24 May 2024 19:26:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAeHu-0007P9-P4
 for qemu-devel@nongnu.org; Fri, 24 May 2024 19:25:28 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAeHj-0006u1-CX
 for qemu-devel@nongnu.org; Fri, 24 May 2024 19:25:25 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6f8e98760fcso1242544b3a.1
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 16:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716593111; x=1717197911; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AtfQDDvhCTAQzr/cA9Eff/uGFAgvLsYs3JLC/5fgqLQ=;
 b=wZil00SEDRebx9oyUjm0ciRTCUZ6A1cmUQ8o8pVWRiGH2XTDNfCUgxFSrurqdarTa1
 uw4/SqP8Iy5pofz1Z6iJ98OwEwPUl0L1dIZ+xOCNBtuHkqUAoLO/tODinOHNEp+m2oZX
 r9mK4OKrZYjLJ6Vm0uMiA5HskLWHqnl5C/UVYVPddBWqVtC5hIGjaA0wrBrOYYeN/Cap
 +tmHehs+He1qLf7SNRTqcJOsL5dP9T/4uYPmprcag2nsQTSOvzVg0AVHRcofa7KXWfNw
 9swO1cQVGwXB9wZglG6nNCHM7P+1Axq3wHIh3MbpJhhMxQ5dy4k5L6UEWzp5VSvjmakL
 yRTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716593111; x=1717197911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AtfQDDvhCTAQzr/cA9Eff/uGFAgvLsYs3JLC/5fgqLQ=;
 b=AIpCgPmia0s7bO2gvcsIt6yDoiYxk1d4jKiknEwMd1J6EmCLeEoN7g5XQtEKWjJTbJ
 XMteaBnJAWu/EzmDILqEM5j6uiVHZ4aFM8hgswJQTlr9hC4So9+bHGbOEcVvAmB9Jc2s
 G/GZw/6EYQLjV745QBIBRJHNtfVjRsGSFwT9TTudEQrRWI0v+OupQ4raqeFD9nE1+6QF
 l45hjzxJwYwoJu1TLaWq8dMh68dbhuF8rWAmcVsObfwzhqZ2VEmap4Fyw6mU1DOfFYVH
 J1KUNlLDOHVasJl4Q0xKIb5eyawYOYi7BvGJMrng8LLLSKyM7uQVi9iIp1p2rq0VBUIX
 dOeg==
X-Gm-Message-State: AOJu0Yyz+0xnrCrMllNikpMUmQVLnSewuBdiujnNyY/zPS6fXu08lgAM
 OEHrXeML2Y1+KGV22KUr+8vFwnJAmOxdWP3Yb4ZX88pdyZwb7gCBexeYGhdSX3NFVx45CDKfKIG
 5
X-Google-Smtp-Source: AGHT+IH+j5nCBT4Ft8G8jKCSdD83MbqwEQNJUmxG43HbAdFhjNV6nRd3mkEv5tASjUVgEAR8Fu/M6g==
X-Received: by 2002:a05:6a21:19c:b0:1a7:2e17:efd3 with SMTP id
 adf61e73a8af0-1b212cbcefamr6073493637.5.1716593111450; 
 Fri, 24 May 2024 16:25:11 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fbf2cfd1sm1591695b3a.3.2024.05.24.16.25.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 16:25:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 55/67] target/arm: Convert SHADD, UHADD to decodetree
Date: Fri, 24 May 2024 16:21:09 -0700
Message-Id: <20240524232121.284515-56-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240524232121.284515-1-richard.henderson@linaro.org>
References: <20240524232121.284515-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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
 target/arm/tcg/a64.decode      |  2 ++
 target/arm/tcg/translate-a64.c | 11 +++--------
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 3061e26242..e33d91fd0a 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -912,6 +912,8 @@ CMGE_v          0.00 1110 ..1 ..... 00111 1 ..... ..... @qrrr_e
 CMHS_v          0.10 1110 ..1 ..... 00111 1 ..... ..... @qrrr_e
 CMTST_v         0.00 1110 ..1 ..... 10001 1 ..... ..... @qrrr_e
 CMEQ_v          0.10 1110 ..1 ..... 10001 1 ..... ..... @qrrr_e
+SHADD_v         0.00 1110 ..1 ..... 00000 1 ..... ..... @qrrr_e
+UHADD_v         0.10 1110 ..1 ..... 00000 1 ..... ..... @qrrr_e
 
 ### Advanced SIMD scalar x indexed element
 
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 5f3423513d..00c04425c1 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5454,6 +5454,8 @@ TRANS(UQRSHL_v, do_gvec_fn3, a, gen_neon_uqrshl)
 
 TRANS(ADD_v, do_gvec_fn3, a, tcg_gen_gvec_add)
 TRANS(SUB_v, do_gvec_fn3, a, tcg_gen_gvec_sub)
+TRANS(SHADD_v, do_gvec_fn3_no64, a, gen_gvec_shadd)
+TRANS(UHADD_v, do_gvec_fn3_no64, a, gen_gvec_uhadd)
 
 static bool do_cmop_v(DisasContext *s, arg_qrrr_e *a, TCGCond cond)
 {
@@ -10920,7 +10922,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
             return;
         }
         /* fall through */
-    case 0x0: /* SHADD, UHADD */
     case 0x2: /* SRHADD, URHADD */
     case 0x4: /* SHSUB, UHSUB */
     case 0xc: /* SMAX, UMAX */
@@ -10946,6 +10947,7 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
         }
         break;
 
+    case 0x0: /* SHADD, UHADD */
     case 0x01: /* SQADD, UQADD */
     case 0x05: /* SQSUB, UQSUB */
     case 0x06: /* CMGT, CMHI */
@@ -10965,13 +10967,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
     }
 
     switch (opcode) {
-    case 0x00: /* SHADD, UHADD */
-        if (u) {
-            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_uhadd, size);
-        } else {
-            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_shadd, size);
-        }
-        return;
     case 0x0c: /* SMAX, UMAX */
         if (u) {
             gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_umax, size);
-- 
2.34.1


