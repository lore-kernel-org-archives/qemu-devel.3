Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42646C25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 23:30:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAeI4-0007od-3l; Fri, 24 May 2024 19:25:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAeHj-0007Jc-SS
 for qemu-devel@nongnu.org; Fri, 24 May 2024 19:25:20 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAeHY-0006lr-Lz
 for qemu-devel@nongnu.org; Fri, 24 May 2024 19:25:15 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6f5053dc057so4955256b3a.2
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 16:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716593103; x=1717197903; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2++z+BnsdD5ea3L5ZWynOcCaqUXBNf2jM4oVZP41cHM=;
 b=I6Vf2+Nr+8k9E7DCDZjB6vniEtkw6hH0i8Uf96MCPSdkYiWgpkJsBI8VMaCddI6rGZ
 E+CO+KncLTl0t1EvnZJx+fgApkDxP0lADsJbMa/WGWjHDne54NlQ5p5T96aS9jkzfdsw
 k7ctx9ty1pobxd3DFB+GhCHG+hhlC1NYjbKRuP2LbhD97JVQ9o0u6qr5a2UCdN5Jj84F
 GJ9nob4EfMalUXGL5edKBuLlMFOCjp8GiG9nuBPKlF21C6kMTV3SCBdD6YC02bzLRvbI
 ZubV/H4avzGAb02UjevkfsDuuhIwhKP0YgjiWeQL81NqNq1jwjiIy1v1axLYj3zdTNQs
 O+rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716593103; x=1717197903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2++z+BnsdD5ea3L5ZWynOcCaqUXBNf2jM4oVZP41cHM=;
 b=DrNKWQlNzzLa1rZlqtlTrQ2ySdqD2hARkd9fbQkpfFZnS5CbHqB19oz/N2+mzRQInm
 3QoT0y68aJUZ7gOWvFB/K+AGDc8/wMRWbqvrPpA+DtbtZAHGTrAAdyS+4Aa/FfCRNBoY
 H71HaIZQFcjafE+km3Duomh6FAXYBaw7kf/uAx+6s3hPuQcOSQSduZjBWZ8y5b0hZc9E
 oe3ycGex8FD7Hw2OjbV6j+pB8tSEU08uOAT+D+iCkwxGBhbmyf2SDwR8YKL3/oGG1XkO
 JJ6Nrv3Kw7bUA7ORP25FIK145e6f1HhouQE9xcc57Ga8mdyMKj/GFMcNiKz6MBVN21zB
 IQfw==
X-Gm-Message-State: AOJu0YwUusOfXMHedzdgHgVb0tvajP5ADuKahHarFFC1RBprHnsMAuBB
 3sy13kBA4iEhVGutlhM1M68bLbNFc/hio2PizU+1Vtd5hBAKun5ln0sDiB4WgJHTcs1jbjyXDME
 6
X-Google-Smtp-Source: AGHT+IHnDQZudjwbc9M4Ay1fxHnHECLME8eSovBytvUZtiFxLlNEUevafc++RV9iRhl9RKLpwp8oMg==
X-Received: by 2002:a05:6a20:9188:b0:1af:b1c0:c9eb with SMTP id
 adf61e73a8af0-1b212e02f4bmr5064211637.45.1716593103153; 
 Fri, 24 May 2024 16:25:03 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fbf2cfd1sm1591695b3a.3.2024.05.24.16.25.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 16:25:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 45/67] target/arm: Convert SRSHL, URSHL to decodetree
Date: Fri, 24 May 2024 16:20:59 -0700
Message-Id: <20240524232121.284515-46-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240524232121.284515-1-richard.henderson@linaro.org>
References: <20240524232121.284515-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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
 target/arm/tcg/a64.decode      |  4 ++++
 target/arm/tcg/translate-a64.c | 22 +++++++---------------
 2 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index ea897d6732..9e02776036 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -758,6 +758,8 @@ USQADD_s        0111 1110 ..1 00000 00111 0 ..... ..... @r2r_e
 
 SSHL_s          0101 1110 111 ..... 01000 1 ..... ..... @rrr_d
 USHL_s          0111 1110 111 ..... 01000 1 ..... ..... @rrr_d
+SRSHL_s         0101 1110 111 ..... 01010 1 ..... ..... @rrr_d
+URSHL_s         0111 1110 111 ..... 01010 1 ..... ..... @rrr_d
 
 ### Advanced SIMD scalar pairwise
 
@@ -882,6 +884,8 @@ USQADD_v        0.10 1110 ..1 00000 00111 0 ..... ..... @qr2r_e
 
 SSHL_v          0.00 1110 ..1 ..... 01000 1 ..... ..... @qrrr_e
 USHL_v          0.10 1110 ..1 ..... 01000 1 ..... ..... @qrrr_e
+SRSHL_v         0.00 1110 ..1 ..... 01010 1 ..... ..... @qrrr_e
+URSHL_v         0.10 1110 ..1 ..... 01010 1 ..... ..... @qrrr_e
 
 ### Advanced SIMD scalar x indexed element
 
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 2dffda36a8..24f2025997 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5116,6 +5116,8 @@ static bool do_int3_scalar_d(DisasContext *s, arg_rrr_e *a,
 
 TRANS(SSHL_s, do_int3_scalar_d, a, gen_sshl_i64)
 TRANS(USHL_s, do_int3_scalar_d, a, gen_ushl_i64)
+TRANS(SRSHL_s, do_int3_scalar_d, a, gen_helper_neon_rshl_s64)
+TRANS(URSHL_s, do_int3_scalar_d, a, gen_helper_neon_rshl_u64)
 
 static bool do_fp3_vector(DisasContext *s, arg_qrrr_e *a,
                           gen_helper_gvec_3_ptr * const fns[3])
@@ -5364,6 +5366,8 @@ TRANS(USQADD_v, do_gvec_fn3, a, gen_gvec_usqadd_qc)
 
 TRANS(SSHL_v, do_gvec_fn3, a, gen_gvec_sshl)
 TRANS(USHL_v, do_gvec_fn3, a, gen_gvec_ushl)
+TRANS(SRSHL_v, do_gvec_fn3, a, gen_gvec_srshl)
+TRANS(URSHL_v, do_gvec_fn3, a, gen_gvec_urshl)
 
 
 /*
@@ -9384,13 +9388,6 @@ static void handle_3same_64(DisasContext *s, int opcode, bool u,
             gen_helper_neon_qshl_s64(tcg_rd, tcg_env, tcg_rn, tcg_rm);
         }
         break;
-    case 0xa: /* SRSHL, URSHL */
-        if (u) {
-            gen_helper_neon_rshl_u64(tcg_rd, tcg_rn, tcg_rm);
-        } else {
-            gen_helper_neon_rshl_s64(tcg_rd, tcg_rn, tcg_rm);
-        }
-        break;
     case 0xb: /* SQRSHL, UQRSHL */
         if (u) {
             gen_helper_neon_qrshl_u64(tcg_rd, tcg_env, tcg_rn, tcg_rm);
@@ -9409,6 +9406,7 @@ static void handle_3same_64(DisasContext *s, int opcode, bool u,
     case 0x1: /* SQADD / UQADD */
     case 0x5: /* SQSUB / UQSUB */
     case 0x8: /* SSHL, USHL */
+    case 0xa: /* SRSHL, URSHL */
         g_assert_not_reached();
     }
 }
@@ -9433,7 +9431,6 @@ static void disas_simd_scalar_three_reg_same(DisasContext *s, uint32_t insn)
     case 0x9: /* SQSHL, UQSHL */
     case 0xb: /* SQRSHL, UQRSHL */
         break;
-    case 0xa: /* SRSHL, URSHL */
     case 0x6: /* CMGT, CMHI */
     case 0x7: /* CMGE, CMHS */
     case 0x11: /* CMTST, CMEQ */
@@ -9453,6 +9450,7 @@ static void disas_simd_scalar_three_reg_same(DisasContext *s, uint32_t insn)
     case 0x1: /* SQADD, UQADD */
     case 0x5: /* SQSUB, UQSUB */
     case 0x8: /* SSHL, USHL */
+    case 0xa: /* SRSHL, URSHL */
         unallocated_encoding(s);
         return;
     }
@@ -10937,13 +10935,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
     }
 
     switch (opcode) {
-    case 0x0a: /* SRSHL, URSHL */
-        if (u) {
-            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_urshl, size);
-        } else {
-            gen_gvec_fn3(s, is_q, rd, rn, rm, gen_gvec_srshl, size);
-        }
-        return;
     case 0x0c: /* SMAX, UMAX */
         if (u) {
             gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_umax, size);
@@ -11025,6 +11016,7 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
     case 0x01: /* SQADD, UQADD */
     case 0x05: /* SQSUB, UQSUB */
     case 0x08: /* SSHL, USHL */
+    case 0x0a: /* SRSHL, URSHL */
         g_assert_not_reached();
     }
 
-- 
2.34.1


