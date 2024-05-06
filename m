Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFF26C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 01:12:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3mq3-0008Tc-QQ; Sun, 05 May 2024 21:08:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3mpZ-0007bE-Se
 for qemu-devel@nongnu.org; Sun, 05 May 2024 21:07:51 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3mpT-0003LE-CQ
 for qemu-devel@nongnu.org; Sun, 05 May 2024 21:07:49 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6f44dc475f4so777608b3a.2
 for <qemu-devel@nongnu.org>; Sun, 05 May 2024 18:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714957661; x=1715562461; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EAk+AKEhGDCmtMPJ4RMZskfIIvGN7VLr1LadByn/0vE=;
 b=W5Bpd5NXhRgwhpaiyPEP6ZB7O68BufKmWmOYIty4t90YODXegaVZQJJFCSgo7jF3s2
 vmtKyxrY4PPKcRwbbu+B5QKn0aGzZRPJg6YO24+/6GACns4Yow12treVKRianO+/j8w0
 D2SQlIO0YqeSG7/ZGlMN3fOsXpmwmu9Ph/We3fXno8Pdp2NxWlmOXx+PJpUgl4WVPQl7
 c9A2xRzHV23lx3kSGBVbCgW8MfVrwbHN19DXvaR3DUbLWB82MT52VMXcB3QmQjzMxGPa
 aBYgF1TlB1Lm3I1LhIV8sZdvDkIMiIfIiQQJMJ4p3YtltsWjw1zgi75lVLjA6QuHInYK
 e5lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714957661; x=1715562461;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EAk+AKEhGDCmtMPJ4RMZskfIIvGN7VLr1LadByn/0vE=;
 b=BA/fZNj9WMBcFP0Z/+YnJgmyDJlJs09mkB+5YfwLy0g7KLgvNcou5R7c9wtZyOj/Ti
 SZ0qn0g+s9/Xm/k5Bdswvof3Z0t+dbuMVXZj5ejz0AylDrI32x9dA9I3A5rCgxzteovK
 od5EZ9DoxNxKG+MjWegCOOfi72mwcJjeMh4eKzN2j1hZjdWFOJ9TXszj2Cdw/SWbEZz9
 Zbv+cj8o0DDzYtfY8CZCd/6Xd5OsWwTU2RChPhQbWNPmI2abKxJxIub36iAp3WNJRvjG
 13bXVbQN64TcLO2Ez1bu76x2QBiO6YZDN3RWN5tVovGF+6yeb7yIJsS7jXMZ9wu+acKP
 2qCA==
X-Gm-Message-State: AOJu0Yx8W0hOP5D80e5Pmmgw7jrggkHMTr10m4DiDd/EZlh3nFCKqjUw
 IHRyyqpJARI83RbkG7xhfnxJYjWvYoiEf3yk22ja7MqeRPCCzwui4v/XtVrU4ij+CE8F/ZwkF0A
 d
X-Google-Smtp-Source: AGHT+IHWb6vp8sLUkZbloz24c7vLbMNvHvHgpsK97W4xdIsw0buUJK45O81nAUkc0jn52ykJM2mRwQ==
X-Received: by 2002:a05:6a00:8c4:b0:6ed:5f64:2fef with SMTP id
 s4-20020a056a0008c400b006ed5f642fefmr10917813pfu.17.1714957660932; 
 Sun, 05 May 2024 18:07:40 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 kp4-20020a056a00464400b006e580678dfbsm6577287pfb.193.2024.05.05.18.07.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 May 2024 18:07:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 43/57] target/arm: Convert ADD, SUB (vector) to decodetree
Date: Sun,  5 May 2024 18:03:49 -0700
Message-Id: <20240506010403.6204-44-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240506010403.6204-1-richard.henderson@linaro.org>
References: <20240506010403.6204-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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
 target/arm/tcg/a64.decode      |  6 ++++++
 target/arm/tcg/translate-a64.c | 34 +++++++++++-----------------------
 2 files changed, 17 insertions(+), 23 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 86279edc98..97fe1ef927 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -765,6 +765,9 @@ UQSHL_s         0111 1110 ..1 ..... 01001 1 ..... ..... @rrr_e
 SQRSHL_s        0101 1110 ..1 ..... 01011 1 ..... ..... @rrr_e
 UQRSHL_s        0111 1110 ..1 ..... 01011 1 ..... ..... @rrr_e
 
+ADD_s           0101 1110 111 ..... 10000 1 ..... ..... @rrr_d
+SUB_s           0111 1110 111 ..... 10000 1 ..... ..... @rrr_d
+
 ### Advanced SIMD scalar pairwise
 
 FADDP_s         0101 1110 0011 0000 1101 10 ..... ..... @rr_h
@@ -895,6 +898,9 @@ UQSHL_v         0.10 1110 ..1 ..... 01001 1 ..... ..... @qrrr_e
 SQRSHL_v        0.00 1110 ..1 ..... 01011 1 ..... ..... @qrrr_e
 UQRSHL_v        0.10 1110 ..1 ..... 01011 1 ..... ..... @qrrr_e
 
+ADD_v           0.00 1110 ..1 ..... 10000 1 ..... ..... @qrrr_e
+SUB_v           0.10 1110 ..1 ..... 10000 1 ..... ..... @qrrr_e
+
 ### Advanced SIMD scalar x indexed element
 
 FMUL_si         0101 1111 00 .. .... 1001 . 0 ..... .....   @rrx_h
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index db3ba77760..9daa8fe5b0 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5119,6 +5119,8 @@ TRANS(SSHL_s, do_int3_scalar_d, a, gen_sshl_i64)
 TRANS(USHL_s, do_int3_scalar_d, a, gen_ushl_i64)
 TRANS(SRSHL_s, do_int3_scalar_d, a, gen_helper_neon_rshl_s64)
 TRANS(URSHL_s, do_int3_scalar_d, a, gen_helper_neon_rshl_u64)
+TRANS(ADD_s, do_int3_scalar_d, a, tcg_gen_add_i64)
+TRANS(SUB_s, do_int3_scalar_d, a, tcg_gen_sub_i64)
 
 typedef struct ENVScalar2 {
     NeonGenTwoOpEnvFn *gen_bhs[3];
@@ -5433,6 +5435,8 @@ TRANS(UQSHL_v, do_gvec_fn3, a, gen_neon_uqshl)
 TRANS(SQRSHL_v, do_gvec_fn3, a, gen_neon_sqrshl)
 TRANS(UQRSHL_v, do_gvec_fn3, a, gen_neon_uqrshl)
 
+TRANS(ADD_v, do_gvec_fn3, a, tcg_gen_gvec_add)
+TRANS(SUB_v, do_gvec_fn3, a, tcg_gen_gvec_sub)
 
 /*
  * Advanced SIMD scalar/vector x indexed element
@@ -9438,13 +9442,6 @@ static void handle_3same_64(DisasContext *s, int opcode, bool u,
         }
         gen_cmtst_i64(tcg_rd, tcg_rn, tcg_rm);
         break;
-    case 0x10: /* ADD, SUB */
-        if (u) {
-            tcg_gen_sub_i64(tcg_rd, tcg_rn, tcg_rm);
-        } else {
-            tcg_gen_add_i64(tcg_rd, tcg_rn, tcg_rm);
-        }
-        break;
     default:
     case 0x1: /* SQADD / UQADD */
     case 0x5: /* SQSUB / UQSUB */
@@ -9452,6 +9449,7 @@ static void handle_3same_64(DisasContext *s, int opcode, bool u,
     case 0x9: /* SQSHL, UQSHL */
     case 0xa: /* SRSHL, URSHL */
     case 0xb: /* SQRSHL, UQRSHL */
+    case 0x10: /* ADD, SUB */
         g_assert_not_reached();
     }
 }
@@ -9476,7 +9474,6 @@ static void disas_simd_scalar_three_reg_same(DisasContext *s, uint32_t insn)
     case 0x6: /* CMGT, CMHI */
     case 0x7: /* CMGE, CMHS */
     case 0x11: /* CMTST, CMEQ */
-    case 0x10: /* ADD, SUB (vector) */
         if (size != 3) {
             unallocated_encoding(s);
             return;
@@ -9495,6 +9492,7 @@ static void disas_simd_scalar_three_reg_same(DisasContext *s, uint32_t insn)
     case 0x9: /* SQSHL, UQSHL */
     case 0xa: /* SRSHL, URSHL */
     case 0xb: /* SQRSHL, UQRSHL */
+    case 0x10: /* ADD, SUB (vector) */
         unallocated_encoding(s);
         return;
     }
@@ -10952,6 +10950,11 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
 
     case 0x01: /* SQADD, UQADD */
     case 0x05: /* SQSUB, UQSUB */
+    case 0x08: /* SSHL, USHL */
+    case 0x09: /* SQSHL, UQSHL */
+    case 0x0a: /* SRSHL, URSHL */
+    case 0x0b: /* SQRSHL, UQRSHL */
+    case 0x10: /* ADD, SUB */
         unallocated_encoding(s);
         return;
     }
@@ -10989,13 +10992,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
             gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_saba, size);
         }
         return;
-    case 0x10: /* ADD, SUB */
-        if (u) {
-            gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_sub, size);
-        } else {
-            gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_add, size);
-        }
-        return;
     case 0x13: /* MUL, PMUL */
         if (!u) { /* MUL */
             gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_mul, size);
@@ -11038,14 +11034,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
                          vec_full_reg_offset(s, rm),
                          is_q ? 16 : 8, vec_full_reg_size(s));
         return;
-
-    case 0x01: /* SQADD, UQADD */
-    case 0x05: /* SQSUB, UQSUB */
-    case 0x08: /* SSHL, USHL */
-    case 0x09: /* SQSHL, UQSHL */
-    case 0x0a: /* SRSHL, URSHL */
-    case 0x0b: /* SQRSHL, UQRSHL */
-        g_assert_not_reached();
     }
 
     if (size == 3) {
-- 
2.34.1


