Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38728C88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:06:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pJK-0000zl-7R; Wed, 16 Sep 2026 09:04:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pJI-0000zM-4o
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:04:24 -0400
Received: from mail-oo2-x0c.google.com ([2607:f8b0:4864:31::c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pJG-0000Gw-Bj
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:04:23 -0400
Received: by mail-oo2-x0c.google.com with SMTP id
 46e09a7af769-80a7469f5e9so604790a34.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789563861; x=1790168661; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=47puM7envmbLsBYn4NN2JvYgQw7NFohb4tsZxNlNnyg=;
 b=M6i0UP+BVdrnBjpR+Bd0FjR7WdYhROI2JIEjgq+sXdAceryMkI00aL1LAyhZsesjxO
 Vz78FNNNSZIBkHR3KOGVr4NTGCcruFyDQFLyEFQY7VVn7+UiKkH7E2Y12ENnXgZYw23r
 DyZGVHUiKq1Vc0IBWnItLaaqPjSLWbpod1zlnsxHWnLW5EC+pecbe0A3NKuO7qNXg6yH
 vmWCFoiXUPvZ1egbivtKGCJvGqwsa6SchSo090qUWmei73f1urXJEnksinERfZS+HEGQ
 g5rvUZI4U4ZCGv2Dx1n8HVKyw8M5NrAK/hlSBxnp6y22j05jTAim0pwb09eSWazlLNyg
 iRxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789563861; x=1790168661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=47puM7envmbLsBYn4NN2JvYgQw7NFohb4tsZxNlNnyg=;
 b=QEc78ReWCTyVkSDPvMtHCfWiKprQikCE9/mrqXUIM1tHbiQx6fhdKB++FtFlpAdKQ5
 GMtXRI6P2T22U0TFC/eQGGMEPZxyAd9o1YTSQClXK4ebhsWtp2ggX4dAOdbU7MFEqGC1
 nSDK+PVjn2dFDVQg3ie6yOGcZi0cYuosX9QtUJ+Cui56R3xarnzUomhw0OeuCdAWkyPx
 8tXIE8G4PF6D+o/ABXvqDnE7i3Ui2wbwfCGKzm3cHcJKKX7pJawzfWEvAvFd8Q/DzXAS
 gWB3lbIiRvYCtB7kTLq7JMQcCMw+E/g9jhK8jo9JKhWvSpiB8B57MfU40Pz/B3+wmJKR
 kk3Q==
X-Gm-Message-State: AFuF++lxNT71r9R0HRJwr7i/g5mN8FnDYfPR10Oo8tE8vhR8ief8fon4
 bTeW5wUIZSRycjzbYMdMHpCjYkz4XHF+I8mqGM1f8LzTkl1t0wGO40vQ6+8o0XRgnnJsKBTzuZ2
 BXCE2lvI=
X-Gm-Gg: AYBFou30GPmdVr8+qtqek/ACiJd3DqilAHIV8mAJPtqeuKUaX+ZrsKm6M2yFbFFL6fV
 33HL+inBifsXnPt5K0i+isQ+ct/YuNsvZkiZOQjOP8qyuXgN2mKnwCltuiwyARQWqak9kDzhgpG
 IHGwWF79LDUU6HZBUrQfU3/qKZsWdczAVYeoQpoMZakXTv2Q4jyAMzc0Ts7VIHLTP6Zg5hZdByS
 ObEjGUhKJlo5cisLfY9In7Xx9gRLKuvNKH2PMks47aM6UhQrILXBIQAjkm6J3EKcG3FNw/ih1un
 oIHMP0lKZAJd18+IyL2pfG44Q0i46IrK72UUFeEUlqzLzIb85YjtWqVT57DUjD4g2jIWRC8llY/
 UjeoOFImm347nYhibSJAmag8ZImdF7IwtfLLaleQou3OuWH+AnIdvdELMm2KJyBaPWoSMapeh9p
 kHu+T+E+aD/ZYZMrxB1n5U5Ijd3rG0h7U4GX8tp9+aqETMUsPm2o9QI4AosGnl/0bRlyZTPntXe
 +/DLIw=
X-Received: by 2002:a05:6820:8108:b0:6c2:4f65:3e87 with SMTP id
 006d021491bc7-6c7d3defad5mr2539496eaf.34.1789563860638; 
 Wed, 16 Sep 2026 06:04:20 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395caccf1sm6337196c88.2.2026.09.16.06.04.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:04:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 04/92] tcg: Use QEMU_ALIAS to define most tcg_gen_*_ptr
Date: Wed, 16 Sep 2026 03:02:39 -1000
Message-ID: <20260916130409.3382710-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916130409.3382710-1-richard.henderson@linaro.org>
References: <20260916130409.3382710-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:31::c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo2-x0c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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


