Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFA9FC2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 19:10:30 +0000 (UTC)
Received: from [::1] (helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMBMZ-0005en-CJ; Tue, 25 Jun 2024 14:58:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sMBAF-0002NP-7E
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 14:46:05 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sMB8m-00071e-Lt
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 14:44:46 -0400
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-6f8ffe1b65dso2633096a34.0
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 11:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719340966; x=1719945766; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8IpGOhTtGrG6tQBTmNEOspGt85++snfZsV2Uj44z4n0=;
 b=dEjvdwSzTrim0bQUVD0xxXE61izuldCChRvcrKpejb2NflqB42P1W8rPbIeOpBqu4c
 yJsmpx9Ee+RI2nFk5zM+xwa5m5MZ/JxjjseN8OBexyiPN7DfnKRIBXOTx/KUIav0mSMG
 C8jsnQEuo6WJOgIvM4yzMi9f7NOE8QAIQqf+8cU3MmKS9nN0iFb1bgGCdWhVmCrc5QKh
 Iw54+mAwXjHQLThbe6gjxTdCfqShzZx/eGu2x4XRcygv0ODFt+yvY2Xf9oFg6NICfuOJ
 aEPfTeAqlLzOUonLf6lFkHAazpjYQh+Bif3SdyZNGq0HWFyOX+28tI/22sHMTFZMGpdF
 fr/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719340966; x=1719945766;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8IpGOhTtGrG6tQBTmNEOspGt85++snfZsV2Uj44z4n0=;
 b=xUOSHSUV0ah3eLT50crBLjptcwZqwealntbYv2w8TAX0eeHiFKGMw4DynAJrLYei00
 FWEe8C6bjO1aLTKJVcthscht2V9VTtxZq1MLQjcLVrxj110aOrN6JojYbEdC2+gOJ2i7
 yPytQvBzPFJTyCMDQbuvdU8pRJf1AqS01IupO+ptZe3qfVI9FQ7aiz/u0R5vrYrCZ8qX
 12MFs6biUyQrcuJ/NTIWG4kKnP0jJqZvz8YZ9PrAGOvFOKrheqZSsb9rFxb5Mb7Q+9Wq
 862lLa6lV3b86VhYUw4xd8n1q+c6x0d4hKiSBCYoqIkQpYWl2c3OQCcpZFcB7kQ8ppUx
 aq/w==
X-Gm-Message-State: AOJu0YwAgs5tNEzpT9jssH6TPifPms45PBZ/Qa+qK50EvnHcmW8v/RZb
 E2Cxp+bwPjkYr0EpqrBqArklY80Zd16/djo6WxMIEQO6rHL8JPRHeAML43AT68TWZyTUnOBrWic
 U
X-Google-Smtp-Source: AGHT+IFMrb6rkZljdK8FG3tuJPWzUKQbnGbr8uapI1I3xYkMl0szAcHbeQbNOHKoFX3r+pE8FjKAxQ==
X-Received: by 2002:a17:902:f548:b0:1f9:d577:f532 with SMTP id
 d9443c01a7336-1fa0fb4980bmr131469875ad.28.1719340546064; 
 Tue, 25 Jun 2024 11:35:46 -0700 (PDT)
Received: from stoup.. (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f9eb3c6027sm84693235ad.133.2024.06.25.11.35.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jun 2024 11:35:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 09/13] target/arm: Convert BFMMLA, SMMLA, UMMLA,
 USMMLA to decodetree
Date: Tue, 25 Jun 2024 11:35:32 -0700
Message-Id: <20240625183536.1672454-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625183536.1672454-1-richard.henderson@linaro.org>
References: <20240625183536.1672454-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
 target/arm/tcg/translate-a64.c | 36 ++++++++--------------------------
 2 files changed, 12 insertions(+), 28 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 15344a73de..b2c7e36969 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -952,6 +952,10 @@ UDOT_v          0.10 1110 100 ..... 10010 1 ..... ..... @qrrr_s
 USDOT_v         0.00 1110 100 ..... 10011 1 ..... ..... @qrrr_s
 BFDOT_v         0.10 1110 010 ..... 11111 1 ..... ..... @qrrr_s
 BFMLAL_v        0.10 1110 110 ..... 11111 1 ..... ..... @qrrr_h
+BFMMLA          0110 1110 010 ..... 11101 1 ..... ..... @rrr_q1e0
+SMMLA           0100 1110 100 ..... 10100 1 ..... ..... @rrr_q1e0
+UMMLA           0110 1110 100 ..... 10100 1 ..... ..... @rrr_q1e0
+USMMLA          0100 1110 100 ..... 10101 1 ..... ..... @rrr_q1e0
 
 ### Advanced SIMD scalar x indexed element
 
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 95be862dde..2697c4b305 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5605,6 +5605,10 @@ TRANS_FEAT(SDOT_v, aa64_dp, do_dot_vector, a, gen_helper_gvec_sdot_b)
 TRANS_FEAT(UDOT_v, aa64_dp, do_dot_vector, a, gen_helper_gvec_udot_b)
 TRANS_FEAT(USDOT_v, aa64_i8mm, do_dot_vector, a, gen_helper_gvec_usdot_b)
 TRANS_FEAT(BFDOT_v, aa64_bf16, do_dot_vector, a, gen_helper_gvec_bfdot)
+TRANS_FEAT(BFMMLA, aa64_bf16, do_dot_vector, a, gen_helper_gvec_bfmmla)
+TRANS_FEAT(SMMLA, aa64_i8mm, do_dot_vector, a, gen_helper_gvec_smmla_b)
+TRANS_FEAT(UMMLA, aa64_i8mm, do_dot_vector, a, gen_helper_gvec_ummla_b)
+TRANS_FEAT(USMMLA, aa64_i8mm, do_dot_vector, a, gen_helper_gvec_usmmla_b)
 
 static bool trans_BFMLAL_v(DisasContext *s, arg_qrrr_e *a)
 {
@@ -10949,15 +10953,6 @@ static void disas_simd_three_reg_same_extra(DisasContext *s, uint32_t insn)
     int rot;
 
     switch (u * 16 + opcode) {
-    case 0x04: /* SMMLA */
-    case 0x14: /* UMMLA */
-    case 0x05: /* USMMLA */
-        if (!is_q || size != MO_32) {
-            unallocated_encoding(s);
-            return;
-        }
-        feature = dc_isar_feature(aa64_i8mm, s);
-        break;
     case 0x18: /* FCMLA, #0 */
     case 0x19: /* FCMLA, #90 */
     case 0x1a: /* FCMLA, #180 */
@@ -10972,19 +10967,16 @@ static void disas_simd_three_reg_same_extra(DisasContext *s, uint32_t insn)
         }
         feature = dc_isar_feature(aa64_fcma, s);
         break;
-    case 0x1d: /* BFMMLA */
-        if (size != MO_16 || !is_q) {
-            unallocated_encoding(s);
-            return;
-        }
-        feature = dc_isar_feature(aa64_bf16, s);
-        break;
     default:
     case 0x02: /* SDOT (vector) */
     case 0x03: /* USDOT */
+    case 0x04: /* SMMLA */
+    case 0x05: /* USMMLA */
     case 0x10: /* SQRDMLAH (vector) */
     case 0x11: /* SQRDMLSH (vector) */
     case 0x12: /* UDOT (vector) */
+    case 0x14: /* UMMLA */
+    case 0x1d: /* BFMMLA */
     case 0x1f: /* BFDOT / BFMLAL */
         unallocated_encoding(s);
         return;
@@ -10998,15 +10990,6 @@ static void disas_simd_three_reg_same_extra(DisasContext *s, uint32_t insn)
     }
 
     switch (opcode) {
-    case 0x04: /* SMMLA, UMMLA */
-        gen_gvec_op4_ool(s, 1, rd, rn, rm, rd, 0,
-                         u ? gen_helper_gvec_ummla_b
-                         : gen_helper_gvec_smmla_b);
-        return;
-    case 0x05: /* USMMLA */
-        gen_gvec_op4_ool(s, 1, rd, rn, rm, rd, 0, gen_helper_gvec_usmmla_b);
-        return;
-
     case 0x8: /* FCMLA, #0 */
     case 0x9: /* FCMLA, #90 */
     case 0xa: /* FCMLA, #180 */
@@ -11051,9 +11034,6 @@ static void disas_simd_three_reg_same_extra(DisasContext *s, uint32_t insn)
         }
         return;
 
-    case 0xd: /* BFMMLA */
-        gen_gvec_op4_ool(s, is_q, rd, rn, rm, rd, 0, gen_helper_gvec_bfmmla);
-        return;
     default:
         g_assert_not_reached();
     }
-- 
2.34.1


