Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04F71C83F34
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 17:44:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucp6I-0006jG-0c; Fri, 18 Jul 2025 13:42:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ucouy-00051U-Lt
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 13:30:44 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ucouw-0000qa-Ia
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 13:30:44 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4561a4a8bf2so25174595e9.1
 for <qemu-devel@nongnu.org>; Fri, 18 Jul 2025 10:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752859839; x=1753464639; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jgkKA7jFLUhvg4OYYIjmQGp+3jhrWVpDQ9M3g3VK3l8=;
 b=lpoefUY8l/3UXGevDvBZZcBVreyO2Xa8kB5KHscI0J8PkIyn71+YfbRe/EffPGKnpj
 ZP5Wta9JstARHJE8V3GcdBXq8tU58QlvpRptRanbexZ7ox/Uigso4cWuVlqM2F8RRy1p
 enzGWtz1Y/tfU+VhlsRzjfhtAuuszKCC3oM2IYs9JPg5SGcTxL0rHrA310fht/sQ6eEr
 YBv5LCmyhwD4Gcsm+ElprOc5fDDhlj4NsHV1Vi3+EMl4D5qeB9AFHpkFJira4YWHGlmK
 wCMtyLAXKXbnwK7u1aXnI3WsBQNeq5edheUhetx+NHAw+kGAd6Fg+lAAvLWqRfp7szpl
 +N6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752859839; x=1753464639;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jgkKA7jFLUhvg4OYYIjmQGp+3jhrWVpDQ9M3g3VK3l8=;
 b=c5IkAYUEs81dTBan2M6J1p3NHukqzxsxAMD1YjTyOqFHQ0yf2m/3L3eFayMuyzdT8i
 s1/VQ9leDciDZA+YEDNRhKZcojySyWRWRh7qEns4gFmLSSSX3rlMHEVNVrWolHVyRW0e
 mLJaDK+00QKSMLv2Uo55uiVlFz72/q9Q4Zsbr7TCgNnfiFnZP/YkrUFkD7pyVG5ACWS5
 2yTS1P8iUNNyS1JF3hdfXqgWa5m2g4q65FNVf7JrufMEsTG+jx/hNidKPDtn9HkQEBz2
 YqtsSURHc3UAyM3jwjCokV8cARbmX6jyZlwVYifNqozICv21Ky7AKZdrxGJIAH68diZh
 ybKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKYvKMkS/VPYIoGq09/okKwOtNqzqXfBrQojR9arwVegSBki4/SNqMzfzdcNzMWpsjb4cAPOJTayLk@nongnu.org
X-Gm-Message-State: AOJu0Yx0nSEfqAlAjhcq3aNevfn7mh9WoQfGCXYvXPTg2qnGieNkR2NG
 QyCiYosApxixIHoEBAVP8rpNY96lpH0/EjkUAyezUh/RmReNDntEncPy3RpHYYSRMko=
X-Gm-Gg: ASbGncsjlf8bywZVifSX7jQXVgTFMkn+SUPlFm97D50+FoJhx90qbaRDyaUMJbjMYW/
 //mkba4fpqsE688XkdRAnY1AVlYck95SARwiWQYasWpJb1cDtNpwHzPtdDKfD6UCDTYl4stWyOY
 71UZkRO8ul4t24Pcn+a37rBItkgUdPBI95q6m4xBptoxbj+Tos7aUfOY7zfdUJMVF2FSn6lEXpd
 h5EpnvS7+jBVS1EZ3rCLZ+L2pSF14I0/PEq4RKOseQRL2PT+yR3FPPUA3MdIv3yqF37X8y1OfCO
 f7A26UeLH4zMc6fQ5YlmU1sk7Fo6I3DZx1SgJ307MwLW5pkUU8PPqPoulhd4TBOdli29F42U2tO
 NMRdnXzOixemCTfy3zez4BSxKXBCIriSAZYnN6gg=
X-Google-Smtp-Source: AGHT+IGvFxZwDESpi2qQ5RZMrpAbqn3QdxdXvxFK56bUHp4YKFG1zl1qCN9hsUp6DRRCVyNXtCxGzg==
X-Received: by 2002:a05:6000:3cf:b0:3a6:d95c:5db with SMTP id
 ffacd0b85a97d-3b60e4cb61emr9126609f8f.26.1752859839407; 
 Fri, 18 Jul 2025 10:30:39 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca25443sm2454655f8f.9.2025.07.18.10.30.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jul 2025 10:30:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH for-10.1 04/10] target/arm: Add BFMUL (indexed)
Date: Fri, 18 Jul 2025 18:30:26 +0100
Message-ID: <20250718173032.2498900-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250718173032.2498900-1-peter.maydell@linaro.org>
References: <20250718173032.2498900-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

FEAT_SVE_B16B16 adds a bfloat16 version of the FMUL insn in the
floating-point multiply (indexed) instruction group. The encoding
is slightly bespoke; in our implementation we use MO_8 to indicate
bfloat16, as with the other B16B16 insns.

Fixes: 7b1613a1020d2942 ("target/arm: Enable FEAT_SME2p1 on -cpu max")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper.h        | 2 ++
 target/arm/tcg/sve.decode      | 1 +
 target/arm/tcg/translate-sve.c | 2 +-
 target/arm/tcg/vec_helper.c    | 1 +
 4 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/helper.h b/target/arm/tcg/helper.h
index d9ca5b7c56e..4da32db9021 100644
--- a/target/arm/tcg/helper.h
+++ b/target/arm/tcg/helper.h
@@ -823,6 +823,8 @@ DEF_HELPER_FLAGS_5(gvec_ftsmul_s, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_5(gvec_ftsmul_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, fpst, i32)
 
+DEF_HELPER_FLAGS_5(gvec_fmul_idx_b16, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_fmul_idx_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_fmul_idx_s, TCG_CALL_NO_RWG,
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 2efd5f57e45..a76f2236f43 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1062,6 +1062,7 @@ FMLS_zzxz       01100100 11 1 ..... 000001 ..... .....  @rrxr_1 esz=3
 ### SVE FP Multiply Indexed Group
 
 # SVE floating-point multiply (indexed)
+FMUL_zzx        01100100 0. 1 ..... 001010 ..... .....   @rrx_3 esz=0
 FMUL_zzx        01100100 0. 1 ..... 001000 ..... .....   @rrx_3 esz=1
 FMUL_zzx        01100100 10 1 ..... 001000 ..... .....   @rrx_2 esz=2
 FMUL_zzx        01100100 11 1 ..... 001000 ..... .....   @rrx_1 esz=3
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 27af3df9a4b..918cf6e1bd4 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -3907,7 +3907,7 @@ TRANS_FEAT(FMLS_zzxz, aa64_sve, gen_gvec_fpst_zzzz,
  */
 
 static gen_helper_gvec_3_ptr * const fmul_idx_fns[4] = {
-    NULL,                       gen_helper_gvec_fmul_idx_h,
+    gen_helper_gvec_fmul_idx_b16, gen_helper_gvec_fmul_idx_h,
     gen_helper_gvec_fmul_idx_s, gen_helper_gvec_fmul_idx_d,
 };
 TRANS_FEAT(FMUL_zzx, aa64_sve, gen_gvec_fpst_zzz,
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 76a9ab0da39..33a136b90a6 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -1785,6 +1785,7 @@ void HELPER(NAME)(void *vd, void *vn, void *vm,                            \
 
 #define nop(N, M, S) (M)
 
+DO_FMUL_IDX(gvec_fmul_idx_b16, nop, bfloat16_mul, float16, H2)
 DO_FMUL_IDX(gvec_fmul_idx_h, nop, float16_mul, float16, H2)
 DO_FMUL_IDX(gvec_fmul_idx_s, nop, float32_mul, float32, H4)
 DO_FMUL_IDX(gvec_fmul_idx_d, nop, float64_mul, float64, H8)
-- 
2.43.0


