Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A291C04FFE
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 01:17:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3mnH-0000Dn-VY; Sun, 05 May 2024 21:05:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3mmp-0008HL-HX
 for qemu-devel@nongnu.org; Sun, 05 May 2024 21:04:59 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3mmO-0002Wj-5l
 for qemu-devel@nongnu.org; Sun, 05 May 2024 21:04:59 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6ee13f19e7eso1119061b3a.1
 for <qemu-devel@nongnu.org>; Sun, 05 May 2024 18:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714957469; x=1715562269; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CVH4TAIDRWme3yMtSBgUZ8IafS4+dEzCRM1PJD/VZRo=;
 b=i1rXVI9jcTVMQDliC0SBuOBhgsUxBHRqNynDV/vcRn3id8X6Vk8LeVWkLkYN6iP8ez
 yq7+R3hA0tdRRt18EILCtRsSVKtGSttCnJEmVS/d5FocxafS0kavoqZhuZNnJSP5Ge9b
 zlwCJ2aN6zJpgH4TdBKyA7P6OWXsUSYgXH5dWprN78g/OsiDvQZCmWT5S3W0/dK720UT
 9bevJWXPVUfdyPzIdFLAM2CtjPJeYzSCyPagMpoQ0MKnghw1ZAhVsyX3KDMh1ibd0idn
 ufABVboDLQKDAWgUPibz/c46O8GHFdU3T3XG5u8EEpWPtk5H59GqJ2y3L1gb+ShV3kst
 aBsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714957469; x=1715562269;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CVH4TAIDRWme3yMtSBgUZ8IafS4+dEzCRM1PJD/VZRo=;
 b=HI72xMOL5T8+Kx45Nf3W84Sn7/+ysJM8ZrR5pSb+wKBZdjhNmXhqwajdivIFgqwnEN
 1L8d9bnVT7FtyGcWlY+rJda+TNw0yjMwNte4tjAhLolmcdMSdaXOZqTEU7VeEy5rY56d
 lPWpsYW2vWnNI7zVH3/FjzpFlaPgs7rcD1VM6Z3WjrAWhqcimGA334c7jepM1VVSJGBU
 qe5emtbiuFDCK/Gby48NWdbGTMw06KmUKo8uNLzR/ZxSxoCz4fE0mAIasRl+ODjw8uFb
 WqQ77XiGh3eo3LY6KskcVxt24b32ckepkPnIEtTx5XXwxk6E5HgWPZRxM3Lb4A/vslR2
 VwXg==
X-Gm-Message-State: AOJu0Ywjn6iYPwn/P3nu5CKYmUa4FjCW4cMIoxdNnGOyTNq3JlOfBBGZ
 fiY+ormql0kCUhdtu+Wbg50pDE8FyssWFUkdrMGZIlasF66+4UWqRw+ejrWNy3+t4bgT7g8u+Cb
 1
X-Google-Smtp-Source: AGHT+IHdqpl+aAlSCRLpAaTNoRKnJRtXDaso6CTfGxjHoWdJncNXoXwcYERLD9hp/rruW+OWzL8CHg==
X-Received: by 2002:a05:6a21:339d:b0:1a7:a3ee:5e4a with SMTP id
 yy29-20020a056a21339d00b001a7a3ee5e4amr9378719pzb.33.1714957469129; 
 Sun, 05 May 2024 18:04:29 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 pv7-20020a17090b3c8700b002a5f44353d2sm8958232pjb.7.2024.05.05.18.04.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 May 2024 18:04:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 29/57] target/arm: Convert disas_simd_3same_logic to decodetree
Date: Sun,  5 May 2024 18:03:35 -0700
Message-Id: <20240506010403.6204-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240506010403.6204-1-richard.henderson@linaro.org>
References: <20240506010403.6204-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/a64.decode      | 10 +++++
 target/arm/tcg/translate-a64.c | 68 ++++++++++------------------------
 2 files changed, 29 insertions(+), 49 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 9aa4fb9bd0..d0618ca794 100644
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
index a082ce8441..cbb63c9d30 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5281,6 +5281,24 @@ TRANS(SMINP_v, do_gvec_fn3_no64, a, gen_gvec_sminp)
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
@@ -10895,52 +10913,6 @@ static void disas_simd_three_reg_diff(DisasContext *s, uint32_t insn)
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
@@ -11206,12 +11178,10 @@ static void disas_simd_three_reg_same(DisasContext *s, uint32_t insn)
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


