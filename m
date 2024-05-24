Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05F89C25B7D
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 23:27:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAeEe-0006sW-Hs; Fri, 24 May 2024 19:22:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAeEa-0006n0-Vd
 for qemu-devel@nongnu.org; Fri, 24 May 2024 19:22:01 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAeES-0005tA-Ix
 for qemu-devel@nongnu.org; Fri, 24 May 2024 19:22:00 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1f44b51b367so8858925ad.1
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 16:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716592911; x=1717197711; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KJ19wgsVZPJfoFhDASr+UuLwteG8CXuQPId+c/bWmuc=;
 b=cakvcSx+yEJUG/A1/JcBI1gGsVUzR1bEA0+8nERjaevA5QUOaVK71aYpIDFmByt+xO
 pcrN4bY7CXFk1VAA6m6FK/ALvaIccipwfssMR9TTNK16S3mnHmj1m3zWLnRc3LKSgCsz
 f0V8EnYD/nJ+mJl2M89dkReSLENNlHqtztI4PjXo9bXZm+9YKM+xbougViJuF0nc65LR
 xnfwNv5VbprAF/7iJaWfDg2qLtWp9Pi7txZZjkyyMfNimb4KG8mxsCSdAGqygmo0dvRy
 AZA7JcVANK3nVMT72DfxVVWQC9Y8yvY7kICS3agCKPe3q+ekCzbGQw3xdQxWSKkASjhm
 5BbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716592911; x=1717197711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KJ19wgsVZPJfoFhDASr+UuLwteG8CXuQPId+c/bWmuc=;
 b=w0/lGe0yzLhFNIlTB79G00J90IwIFAT6WkzIQaThPSKA2OUv9KyZ+/yIFctjnFLPSo
 XnGIF50uaaeYBeJJ+PjYrGdMzuNIWnkj8HlMfzuMi91MxcfjftWjX0L8NEwdF/8FTZUr
 O/PgivhPaeM8gXqweIO43hVIAJkVMXQY0Qhi01aF/MFn5/c/3xClcZ3b68od3eQTP7EA
 Iwfs5HZ3MHBMpRCvcvLy/kNjkwH/xZl0iWEWfqN11SpsYGcM0rha2ksJd5KvccGpEQSf
 wONwDpD5SLQrnLmjuvzQl3O0fMQ9doTx+xMj5TxPsjvKrC8P93c58LcPaRTaaSW0NDfA
 IHIA==
X-Gm-Message-State: AOJu0YwvZB5qKJ/ZNE6Wu3GlHqrmYJPpdZnwFENjpp7wDqI0cd/MgqH2
 DxtpXB8wCtILSijNBvPuUQ1c9G2XyBkEPWmbw+DZoQz4XjwkUXkS2x8jTNDhzdDIWt1UqX0UdgG
 y
X-Google-Smtp-Source: AGHT+IGlXo6pysxgpYC1UCw6UylExMcU5JIywmPMOniiyFGdLb7wjTooAiKOybIiwSJmw3U3TeZP0A==
X-Received: by 2002:a17:902:e88a:b0:1f3:244:c619 with SMTP id
 d9443c01a7336-1f4486fd2admr46428565ad.7.1716592911273; 
 Fri, 24 May 2024 16:21:51 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c759ceesm19178305ad.10.2024.05.24.16.21.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 16:21:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 32/67] target/arm: Use gvec for neon padd
Date: Fri, 24 May 2024 16:20:46 -0700
Message-Id: <20240524232121.284515-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240524232121.284515-1-richard.henderson@linaro.org>
References: <20240524232121.284515-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h             | 2 --
 target/arm/tcg/neon_helper.c    | 5 -----
 target/arm/tcg/translate-neon.c | 3 +--
 3 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index d3579a101f..51ed49aa50 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -354,8 +354,6 @@ DEF_HELPER_3(neon_qrshl_s64, i64, env, i64, i64)
 
 DEF_HELPER_2(neon_add_u8, i32, i32, i32)
 DEF_HELPER_2(neon_add_u16, i32, i32, i32)
-DEF_HELPER_2(neon_padd_u8, i32, i32, i32)
-DEF_HELPER_2(neon_padd_u16, i32, i32, i32)
 DEF_HELPER_2(neon_sub_u8, i32, i32, i32)
 DEF_HELPER_2(neon_sub_u16, i32, i32, i32)
 DEF_HELPER_2(neon_mul_u8, i32, i32, i32)
diff --git a/target/arm/tcg/neon_helper.c b/target/arm/tcg/neon_helper.c
index bc6c4a54e9..a0b51c8809 100644
--- a/target/arm/tcg/neon_helper.c
+++ b/target/arm/tcg/neon_helper.c
@@ -745,11 +745,6 @@ uint32_t HELPER(neon_add_u16)(uint32_t a, uint32_t b)
     return (a + b) ^ mask;
 }
 
-#define NEON_FN(dest, src1, src2) dest = src1 + src2
-NEON_POP(padd_u8, neon_u8, 4)
-NEON_POP(padd_u16, neon_u16, 2)
-#undef NEON_FN
-
 #define NEON_FN(dest, src1, src2) dest = src1 - src2
 NEON_VOP(sub_u8, neon_u8, 4)
 NEON_VOP(sub_u16, neon_u16, 2)
diff --git a/target/arm/tcg/translate-neon.c b/target/arm/tcg/translate-neon.c
index 2326a05a0a..6c5a7a98e1 100644
--- a/target/arm/tcg/translate-neon.c
+++ b/target/arm/tcg/translate-neon.c
@@ -830,6 +830,7 @@ DO_3SAME_NO_SZ_3(VABD_S, gen_gvec_sabd)
 DO_3SAME_NO_SZ_3(VABA_S, gen_gvec_saba)
 DO_3SAME_NO_SZ_3(VABD_U, gen_gvec_uabd)
 DO_3SAME_NO_SZ_3(VABA_U, gen_gvec_uaba)
+DO_3SAME_NO_SZ_3(VPADD, gen_gvec_addp)
 
 #define DO_3SAME_CMP(INSN, COND)                                        \
     static void gen_##INSN##_3s(unsigned vece, uint32_t rd_ofs,         \
@@ -1070,13 +1071,11 @@ static bool do_3same_pair(DisasContext *s, arg_3same *a, NeonGenTwoOpFn *fn)
 #define gen_helper_neon_pmax_u32  tcg_gen_umax_i32
 #define gen_helper_neon_pmin_s32  tcg_gen_smin_i32
 #define gen_helper_neon_pmin_u32  tcg_gen_umin_i32
-#define gen_helper_neon_padd_u32  tcg_gen_add_i32
 
 DO_3SAME_PAIR(VPMAX_S, pmax_s)
 DO_3SAME_PAIR(VPMIN_S, pmin_s)
 DO_3SAME_PAIR(VPMAX_U, pmax_u)
 DO_3SAME_PAIR(VPMIN_U, pmin_u)
-DO_3SAME_PAIR(VPADD, padd_u)
 
 #define DO_3SAME_VQDMULH(INSN, FUNC)                                    \
     WRAP_ENV_FN(gen_##INSN##_tramp16, gen_helper_neon_##FUNC##_s16);    \
-- 
2.34.1


