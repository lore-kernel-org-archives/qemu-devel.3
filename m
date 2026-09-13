Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BEE9C88E53
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 02:39:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5a7U-0008Pk-Rl; Sat, 12 Sep 2026 22:39:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5a7C-0008Ne-PH
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:38:48 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5a7A-0000wm-Uk
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:38:46 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 41be03b00d2f7-cc4aa0f1766so613607a12.0
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 19:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789267123; x=1789871923; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=47puM7envmbLsBYn4NN2JvYgQw7NFohb4tsZxNlNnyg=;
 b=nOuMM15nTGmAzHhJkZK2PPFC+vqHGgvqoGYJN0p6JVpk/Jfuynz0kz6l5X25inEPa+
 Cf9eBk+nW3E8L64ZU/8yRZneZHTjCWytBvxXMAXvukJg9uET85+ZZltVbMBK5bcOfrKk
 eYHhuahO9wlKm6gIowiIwJbeEApmzE6nM44o1dvtAwHoZOBo7C85OCb23009VcrapEI4
 vy1xO6BQAmyzV+iV13TY7dVTOaotmvFKQQeS2tSFjrbfYKMX29bNVG1GCN2irZTi7/5/
 1kFd90UW+0WBBunvS1oegifjBJqvqhCW+op6E48HiEwUiVCXUaVFcrHe6AAsUi/2X5IM
 u4rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789267123; x=1789871923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=47puM7envmbLsBYn4NN2JvYgQw7NFohb4tsZxNlNnyg=;
 b=nv/Bf3ZhBcW9/Ja17B1seGNFLPsV9mORUlpLXKuKtSJ8jRsSzE7+sV5LZkRgJiPNPA
 j2j7HYTE8837lygaGzNyjhMTXwgvwVtNp9S04THSbfb/l6w++gf9vmgZ3mMvyU1z2d/5
 /DpfNfDe25TjdyXGuShq+nKSGS77yuAAzo2WRFxvmhSttcHQDPocMciiTT1VQ1vtxDHB
 Nj7usctty+c9Q1gK3H2o++iXfNhhKKW6lB+Q26efYo7qFG0kOr5svEUI6ePdG4YS5/UB
 ae0wGpl6SQwTxk9tHt2C/S5RERqxqreLfBOlwlkp0/4VRL7FFW3tFTOpomffRmybeSvC
 SWaA==
X-Gm-Message-State: AFuF++kWQVKScjq97cOwR8OAVfkzOgP6lx5aEcRLjk7DNYfDxvslzx6P
 3vAZ6pFD2q2hzrI1uRQE10qoFKt6bcgujpUngBSSCYWfLjfWsjoZMbOYXwKFAKQqcgN/pIAxAtj
 wdRmEVY0=
X-Gm-Gg: AYBFou2wF2WBy99FPVke0sO5Pv2LPz7QVpvzB//T3S9Syg+WNmUvC2oatqBa9W0HNdO
 uGiwHJGFc2zSlQ2gykQELWJi6ar6s81p0jN1iYIPTCcVu4r7WHFaczCE16S5iliytIB/C5osB6o
 lS+aM2pgit9drCtaf/7X9ZRV0rKFeat2f01RkTjM7T3ypbnzNEVZz2msOq5SMHrVsxacPkIb5dL
 3vt1oJzngEJC9MKTjLGCzqjQ0mq87bWKWYUDRLq7Z3JDojmbcaAQYWxYUWMpRAVmnLdg8sFm2zE
 8DSRCWZ3WFvNj5gUTX8T2VW4MXmZsiPLK5li9haF5H9iD0Rp/6/gpwpomvTM2q6UBwmcmCtMvw9
 tXKFowDbmct67iDDrNXaO9By/KhvSEyeN70edxTy8ptADAnH2inSYlwoXw7ozplJWVyKtuOUxPf
 Ae6wYODr9qgqerRi7JQLSP+wdjRYvE/WefUn0mPASqtaDX+aRC66JlTLhCYaJMlRTHBHIIr2q7r
 GQKcmZCn4f2rdHX+w==
X-Received: by 2002:a05:6a20:c784:b0:3d2:2011:d184 with SMTP id
 adf61e73a8af0-3db0e40c3e9mr10813711637.14.1789267123045; 
 Sat, 12 Sep 2026 19:38:43 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8ead8sm16174535c88.10.2026.09.12.19.38.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 19:38:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 02/86] tcg: Use QEMU_ALIAS to define most tcg_gen_*_ptr
Date: Sat, 12 Sep 2026 16:37:13 -1000
Message-ID: <20260913023837.741866-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913023837.741866-1-richard.henderson@linaro.org>
References: <20260913023837.741866-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x10.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Now that we've dropped 32-bit host support, TCGv_ptr
is always TCGv_i64.  Do not drop the type difference,
as that's still helpful conceptually, but define the
functions as aliases, exactly sharing code.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h | 99 +++++--------------------------------
 tcg/tcg-op.c                | 18 +++++++
 2 files changed, 31 insertions(+), 86 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 9b321f959c0..1e826b62574 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -497,95 +497,22 @@ void tcg_gen_stl_vec(TCGv_vec r, TCGv_ptr base, TCGArg offset, TCGType t);
 
 /* Host pointer ops */
 
-#if UINTPTR_MAX == UINT32_MAX
-# define PTR  i32
-# define NAT  TCGv_i32
-#else
-# define PTR  i64
-# define NAT  TCGv_i64
-#endif
-
 TCGv_ptr tcg_constant_ptr_int(intptr_t x);
 #define tcg_constant_ptr(X)  tcg_constant_ptr_int((intptr_t)(X))
 
-static inline void tcg_gen_ld_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t o)
-{
-    glue(tcg_gen_ld_,PTR)((NAT)r, a, o);
-}
+void tcg_gen_ld_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t o);
+void tcg_gen_st_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t o);
 
-static inline void tcg_gen_st_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t o)
-{
-    glue(tcg_gen_st_, PTR)((NAT)r, a, o);
-}
-
-static inline void tcg_gen_discard_ptr(TCGv_ptr a)
-{
-    glue(tcg_gen_discard_,PTR)((NAT)a);
-}
-
-static inline void tcg_gen_add_ptr(TCGv_ptr r, TCGv_ptr a, TCGv_ptr b)
-{
-    glue(tcg_gen_add_,PTR)((NAT)r, (NAT)a, (NAT)b);
-}
-
-static inline void tcg_gen_addi_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t b)
-{
-    glue(tcg_gen_addi_,PTR)((NAT)r, (NAT)a, b);
-}
-
-static inline void tcg_gen_mov_ptr(TCGv_ptr d, TCGv_ptr s)
-{
-    glue(tcg_gen_mov_,PTR)((NAT)d, (NAT)s);
-}
-
-static inline void tcg_gen_movi_ptr(TCGv_ptr d, intptr_t s)
-{
-    glue(tcg_gen_movi_,PTR)((NAT)d, s);
-}
-
-static inline void tcg_gen_brcondi_ptr(TCGCond cond, TCGv_ptr a,
-                                       intptr_t b, TCGLabel *label)
-{
-    glue(tcg_gen_brcondi_,PTR)(cond, (NAT)a, b, label);
-}
-
-static inline void tcg_gen_ext_i32_ptr(TCGv_ptr r, TCGv_i32 a)
-{
-#if UINTPTR_MAX == UINT32_MAX
-    tcg_gen_mov_i32((NAT)r, a);
-#else
-    tcg_gen_ext_i32_i64((NAT)r, a);
-#endif
-}
-
-static inline void tcg_gen_trunc_i64_ptr(TCGv_ptr r, TCGv_i64 a)
-{
-#if UINTPTR_MAX == UINT32_MAX
-    tcg_gen_extrl_i64_i32((NAT)r, a);
-#else
-    tcg_gen_mov_i64((NAT)r, a);
-#endif
-}
-
-static inline void tcg_gen_extu_ptr_i64(TCGv_i64 r, TCGv_ptr a)
-{
-#if UINTPTR_MAX == UINT32_MAX
-    tcg_gen_extu_i32_i64(r, (NAT)a);
-#else
-    tcg_gen_mov_i64(r, (NAT)a);
-#endif
-}
-
-static inline void tcg_gen_trunc_ptr_i32(TCGv_i32 r, TCGv_ptr a)
-{
-#if UINTPTR_MAX == UINT32_MAX
-    tcg_gen_mov_i32(r, (NAT)a);
-#else
-    tcg_gen_extrl_i64_i32(r, (NAT)a);
-#endif
-}
-
-#undef PTR
-#undef NAT
+void tcg_gen_discard_ptr(TCGv_ptr a);
+void tcg_gen_add_ptr(TCGv_ptr r, TCGv_ptr a, TCGv_ptr b);
+void tcg_gen_addi_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t b);
+void tcg_gen_mov_ptr(TCGv_ptr d, TCGv_ptr s);
+void tcg_gen_movi_ptr(TCGv_ptr d, intptr_t s);
+void tcg_gen_brcondi_ptr(TCGCond cond, TCGv_ptr a,
+                         intptr_t b, TCGLabel *label);
+void tcg_gen_ext_i32_ptr(TCGv_ptr r, TCGv_i32 a);
+void tcg_gen_trunc_i64_ptr(TCGv_ptr r, TCGv_i64 a);
+void tcg_gen_extu_ptr_i64(TCGv_i64 r, TCGv_ptr a);
+void tcg_gen_trunc_ptr_i32(TCGv_i32 r, TCGv_ptr a);
 
 #endif /* TCG_TCG_OP_COMMON_H */
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 2c88f4f7ca9..b738863ea69 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -2730,3 +2730,21 @@ void tcg_gen_lookup_and_goto_ptr(void)
     tcg_gen_op1i(INDEX_op_goto_ptr, TCG_TYPE_PTR, tcgv_ptr_arg(ptr));
     tcg_temp_free_ptr(ptr);
 }
+
+/*
+ * We only support 64-bit hosts, so TCGv_ptr always resolves to TCGv_i64.
+ */
+
+void tcg_gen_discard_ptr(TCGv_ptr a) QEMU_ALIAS(tcg_gen_discard_i64);
+void tcg_gen_add_ptr(TCGv_ptr r, TCGv_ptr a, TCGv_ptr b) QEMU_ALIAS(tcg_gen_add_i64);
+void tcg_gen_addi_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t b) QEMU_ALIAS(tcg_gen_addi_i64);
+void tcg_gen_mov_ptr(TCGv_ptr d, TCGv_ptr s) QEMU_ALIAS(tcg_gen_mov_i64);
+void tcg_gen_movi_ptr(TCGv_ptr d, intptr_t s) QEMU_ALIAS(tcg_gen_movi_i64);
+void tcg_gen_brcondi_ptr(TCGCond cond, TCGv_ptr a, intptr_t b, TCGLabel *label)
+    QEMU_ALIAS(tcg_gen_brcondi_i64);
+void tcg_gen_ext_i32_ptr(TCGv_ptr r, TCGv_i32 a) QEMU_ALIAS(tcg_gen_ext_i32_i64);
+void tcg_gen_trunc_i64_ptr(TCGv_ptr r, TCGv_i64 a) QEMU_ALIAS(tcg_gen_mov_i64);
+void tcg_gen_extu_ptr_i64(TCGv_i64 r, TCGv_ptr a) QEMU_ALIAS(tcg_gen_mov_i64);
+void tcg_gen_trunc_ptr_i32(TCGv_i32 r, TCGv_ptr a) QEMU_ALIAS(tcg_gen_extrl_i64_i32);
+void tcg_gen_ld_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t o) QEMU_ALIAS(tcg_gen_ld_i64);
+void tcg_gen_st_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t o) QEMU_ALIAS(tcg_gen_st_i64);
-- 
2.53.0


