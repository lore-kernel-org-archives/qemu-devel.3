Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2077A606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=SLXDF5do
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsa4-0007nB-L0; Sun, 25 Oct 2026 03:23:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsZY-0006OO-6O
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:23:16 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsZV-00045L-Gn
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:23:15 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4a1df4c0966so12538955e9.1
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792912992; x=1793517792; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+OTBEMdPFfTJ+7sC7EWEBEsdRmis51UhzswO6a1uJmU=;
 b=SLXDF5doip/VHphcT0m6UaKnytTg/AvA0mKCrdFFuOLvx1otg/6StK3ganJT4Yv051
 tL+QLl/BJYtMtgYWX8464wt7kGp7pcwKGiKC3/wJFbxHnI5eC7jEvFB4OGnAUl402GoH
 5F5ZKSuJ/eT6nHrha2hsfJJMO9SLM74i0iQ+A235a1Xwyg7vcXwSjVP7z3e5GWZubjnQ
 RV+r7uRNLcIz7pfsxsJd7J6Jj9dbJ32KYjF0GdcnHXPZQZbaDpuGYUhvz8psiLX4KhPj
 Hmcxj9H0yCVGAFN9ZNBcYoOjhXjRyqBF9BFijyF8F+ZfKHSxonKh6UtxgvP1DUt4JMGG
 mbAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792912992; x=1793517792;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+OTBEMdPFfTJ+7sC7EWEBEsdRmis51UhzswO6a1uJmU=;
 b=SwNY8Lyl0w41wzrefJKman6p7O0LvC2Ir+dJqgu/IdFtsFrFE5m3gY0X30vl3Iw/Ms
 CnaWNHq2f4wRIuc4pE90A7sWxpapD3wU0/ymh+jSoPlzstJJYLHJzmENxpVwbcXPup72
 hvGqG+D02HiZoeRRdi0xvATNvVnz/0kiIPB9cWTsJWMoEjT+EjOkuVyS1AQpIdFeUTrr
 NS0HSwdyckQqBGU4203VDMmFnZGFaRWstz+A8yD6xiRtOqlBOwICSrZmosmXBzOnHH7N
 PLyKqfLpdrrz2Kgqew5QvHSGjfCpZvfbdYL6kYv2mc/XohzCXvK31xHYEWoGi6jHr77v
 sC9Q==
X-Gm-Message-State: AFq9FYLLJcwT4KRwAe/PJt/0+2sKskzUc4iSwTInNKbXjaLmJw864yue
 v3LxqhAMu6DHn39GX96MrkBcLcR5m7zTdC8osnE9f2sf0hLyK3tJlhZ1gxfm6Cqf8GB5jyWiUpY
 PZB54QOg=
X-Gm-Gg: AYBFou1frn4J57ARRYkt+argZVLDn5dOpRno4koyPXNK2iQI1TdrokLY+0SiuTr2+LF
 KMCgZO8RcI8ktAs2eZWgdBq1wspudxTy9DVwnBwbO/XhKjNO4aOAEptsSEaFqbY0AsRpodL3sYn
 sdLzo9UiuX0JE1MmcNm92f9AjTOPrXgn9peM09Hv5O1Xyi1Xas/alXKW2NBgV2AXVPoC+GfKwfV
 J13xR6uFR+BKcgsrR/Eu9HydD76RNfy7/lf05D85pxnw1K1uT0+zAnnz3ULlDqUQQF3zNKmqVZ6
 itKX4i8bmmD21TEWzv67y+G+r+1JmoKuwwQmTrpJo3uMW+4agWAUiOqvvhxKejspFc32CKHSCk0
 jf9TDBcVYYvWGlrqh4FrBYkmpKuvmesBESVJ+9zpaTPEXzVY9NBtPuQGjL/U+owaTagMMMe+8j3
 qNMG8SbMn4d4kMPiBIk4yZmFnrn0Y7kahaBK+PdXNFXkE+RcuZKToOnMBOJ0vS0eAufcXP2lFtd
 hy4IVXd262hzU3RF+CS6eHPU2nsb0wlco4LU7OH6csN4FI2qYBY3iNS/Y8=
X-Received: by 2002:a05:600c:3e14:b0:49f:c5aa:9ef4 with SMTP id
 5b1f17b1804b1-4a35ae8806amr63101495e9.8.1792912991979; 
 Sun, 25 Oct 2026 00:23:11 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a09434esm103085895e9.0.2026.10.25.00.23.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:23:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PULL 051/100] tcg: Use signed integer for tcg_gen_{clz, ctz}i_{i32,
 i64}
Date: Sun, 25 Oct 2026 08:18:26 +0100
Message-ID: <20261025071915.1123867-52-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x333.google.com
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

Reviewed-by: Matt Turner <mattst88@gmail.com>
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


