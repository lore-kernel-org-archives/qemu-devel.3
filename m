Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDEF606A31B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=BNYTZyTY
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXFq-0004TE-CG; Wed, 21 Oct 2026 10:25:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXD8-0001VH-0D
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:22:43 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXD5-00028n-Ta
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:22:33 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-48e0d1da913so699912f8f.1
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592550; x=1793197350; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vwV7XGh8PFNAANLk2iE5zsIagWcjXOwp+CMyVQ9hdX0=;
 b=BNYTZyTYIl/bVdzVC2WGnGq7EyLVDF2q00esIg60iB9919OOHK0Jg4OZXEnvigDF3i
 94Roe+BWVQON7AUYwFy+OnYu6zU7aPC/4qBNHg/zX6JrWr/ppB0GuW4pEfy6348TQk/l
 y1YbxBEKi5qIa1Vdbp40YwIiTZoIXxv+0ETUByGpy4YoECTQw4L1sRcP4oHtFdMDzS3L
 T+M/Ncid5kS8iapK8eGqzDdt777oyo7DRJvQDfVp/Miq6zISuigDRK5xf3F2Wg96qQOd
 UbampJNsg2DwLhcMVdnV3JpvgGjNarPdgCfDqG4c2ymIPbwS/Yj2l2kvqlUUaB1Q9BwY
 FnzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592550; x=1793197350;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vwV7XGh8PFNAANLk2iE5zsIagWcjXOwp+CMyVQ9hdX0=;
 b=JwKS1nCDApXPdP5FtkmbMPqyrZaEedZbhVRkucIwuDwQjKbuXMzegCnX40aFLAICZp
 wIjjvgmnYBEH9Vv+miBWXXPB5EuR/MPE0TYTXsrL818DoCGtIWUmk7PGWFGCPO4+C7+h
 zc4EKrQluo9Bh+Wsw1zprUIfrL8d96/3gYEM8vrQ8NQhll/JkIRUXQ/RmfjxzavApJN7
 Crf/aHKhhyD4obN4ie/HwYAOEpcL7S+J9FDvb41QK0yE6OBWSEkAIbKw/GdV2F2pC5RH
 po4GQSpgMxXJ9ayRzTT+nUyx8P7IkfYNk6MEe+FRZDU0+XwKmpVJZIQR+SB7Xl1ejDlM
 n38w==
X-Gm-Message-State: AFq9FYKeGWkek403e6ky5dPZ0ZazdbEo0uXGmiNwoSX2sPEgAaTILvi4
 Iy4jab3hyWc5+nU3NKXVuERSnVe+kpz1yC6mJUZ4VwHWUUq6YQICt6glG/TRFNXRuU3Qneb8MMK
 88CqWxxY=
X-Gm-Gg: AYBFou2sgiTPJQGwXGQ8ciRKuKn4SfYczvULT2wkEUdxqQUpwLl2RaZhok9cunN0RQ9
 IrbImCRt3UI3SCnCvGhnelMe493Rbm/GX82MhFpKIHAXf5/n/LdhTinRPfsOkDd97ywZVAF7sv8
 OIxC991mT8WJ7/lK1XmF4cOPB94t1Dnm5cxJDALbiEkEII4NzYcwLctagNcuo9Xfdd+ttkcSaKf
 7LQN+ALfRFZImzED1Y7aXZPoqVWevjaQOSMPTxg5WcvpHMd6YepwFD+yQsk1P7prdwMwlcic8B/
 ExVxJmID87VwLJlLzmEhMje9baYqJ1W/02Q+T0FZMTyHVslfEWNUZZbqeBfhVjQqrU2RFGCTfbe
 zsYN4ahM07yk0zex3NQrBwyYvMLoM5J2oyWMGJiC1YDNftfTW6hOAkdmdZ0w1eKvBJR9f4BNTue
 4apGPoMv23EXWfX32ktzQZKYBGiDUBcr1jfR8PhIiIGkaZa2Q/FCNIThumdgxKbMVVHepQYtRW8
 FEBBzrrTH1NAabc+76GG+EzvQlAQOH1hJCEAenB+nI8OfwwzKKJrTe/VUiaYrLSNB54rC5cpR2k
 ig47+LWXDObcpAhQUhlG7nfpqEg=
X-Received: by 2002:adf:e009:0:10b0:48d:ed95:3823 with SMTP id
 ffacd0b85a97d-48e264a6ec4mr3404703f8f.11.1792592550235; 
 Wed, 21 Oct 2026 07:22:30 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25828e72sm5393603f8f.26.2026.10.21.07.22.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:22:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 051/100] tcg: Use signed integer for tcg_gen_{clz,
 ctz}i_{i32, i64}
Date: Wed, 21 Oct 2026 16:16:03 +0200
Message-ID: <20261021141652.363109-52-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x436.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

We use signed integers for all other functions, and the
sign of the second source is not meaningful here.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h                | 8 ++++----
 tcg/tcg-op.c                               | 8 ++++----
 target/ppc/translate/fixedpoint-impl.c.inc | 4 ++--
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 8dae7096aa..b5575647d3 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -130,8 +130,8 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 /* 32 bit ops */
 
 void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
-void tcg_gen_clzi_i32(TCGv_i32 ret, TCGv_i32 arg1, uint32_t arg2);
-void tcg_gen_ctzi_i32(TCGv_i32 ret, TCGv_i32 arg1, uint32_t arg2);
+void tcg_gen_clzi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
+void tcg_gen_ctzi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_clrsb_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_ctpop_i32(TCGv_i32 a1, TCGv_i32 a2);
 void tcg_gen_rotl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -190,8 +190,8 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 /* 64 bit ops */
 
 void tcg_gen_ctz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
-void tcg_gen_clzi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2);
-void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2);
+void tcg_gen_clzi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
+void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_clrsb_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ctpop_i64(TCGv_i64 a1, TCGv_i64 a2);
 void tcg_gen_rotl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index ee80ab9323..e623f9bbc7 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -751,7 +751,7 @@ void tcg_gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_clzi_i32(TCGv_i32 ret, TCGv_i32 arg1, uint32_t arg2)
+void tcg_gen_clzi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     tcg_gen_clz_i32(ret, arg1, tcg_constant_i32(arg2));
 }
@@ -796,7 +796,7 @@ void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
     tcg_temp_free_i32(t);
 }
 
-void tcg_gen_ctzi_i32(TCGv_i32 ret, TCGv_i32 arg1, uint32_t arg2)
+void tcg_gen_ctzi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     if (arg2 == 32
         && !tcg_op_supported(INDEX_op_ctz, TCG_TYPE_I32, 0)
@@ -1672,7 +1672,7 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_clzi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2)
+void tcg_gen_clzi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     tcg_gen_clz_i64(ret, arg1, tcg_constant_i64(arg2));
 }
@@ -1706,7 +1706,7 @@ void tcg_gen_ctz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
     tcg_temp_free_i64(t);
 }
 
-void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2)
+void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     if (arg2 == 64
         && !tcg_op_supported(INDEX_op_ctz, TCG_TYPE_I64, 0)
diff --git a/target/ppc/translate/fixedpoint-impl.c.inc b/target/ppc/translate/fixedpoint-impl.c.inc
index c3d8bbf267..5195db4e9a 100644
--- a/target/ppc/translate/fixedpoint-impl.c.inc
+++ b/target/ppc/translate/fixedpoint-impl.c.inc
@@ -1551,7 +1551,7 @@ static bool trans_CMPB(DisasContext *ctx, arg_CMPB *a)
 }
 
 static bool do_cntzw(DisasContext *ctx, arg_X_sa_rc *a,
-                    void (*helper)(TCGv_i32, TCGv_i32, uint32_t))
+                     void (*helper)(TCGv_i32, TCGv_i32, int32_t))
 {
     TCGv_i32 t = tcg_temp_new_i32();
 
@@ -1567,7 +1567,7 @@ static bool do_cntzw(DisasContext *ctx, arg_X_sa_rc *a,
 
 #if defined(TARGET_PPC64)
 static bool do_cntzd(DisasContext *ctx, arg_X_sa_rc *a,
-                    void (*helper)(TCGv_i64, TCGv_i64, uint64_t))
+                     void (*helper)(TCGv_i64, TCGv_i64, int64_t))
 {
     helper(cpu_gpr[a->ra], cpu_gpr[a->rs], 64);
     if (unlikely(a->rc)) {
-- 
2.53.0


