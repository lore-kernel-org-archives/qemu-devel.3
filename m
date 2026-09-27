Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF1A8C9830E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:08:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAkpJ-0007oa-0t; Sun, 27 Sep 2026 05:05:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkoA-0005Bg-Nl
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:04:31 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAko3-0007fu-7c
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:04:25 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-39dacf053eeso1067848a91.2
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790499862; x=1791104662; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UQ/JoYuf2jf+GFX53wrIVtRYog2opFC5Hus4CPvsRIs=;
 b=T9hyCQ1xo43bv71VMb2aPVIo7ku5EyQul5j8AIFqIPovPvBiiLUbJqYUrsXp5oyoKO
 ZlWaOalISJUeaRLIwlbkYWJ6eJYFFAtjs90yiirTl10QrPezaeU83ao/AbAe1j18Q2q9
 j/w4L0L+GLxQ+/09DKxrQ891kg8mRwLlnzeml8ur3WWIqwKL/lglapO7d6Q9vqj4CaCr
 t6XFBcgK+uDH3s3EmBZr1JNNNKeWT0B5tEfqcb7vaatmPpJ0nh8UyIr5qcdIoAQGw/kY
 6/et3YI6b/DE2a3SYECJrtZZKtEjIkbzLwy0BvMfYQ0SUzVwHB25CYS7h14Z3ZLrNFhI
 AVzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790499862; x=1791104662;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=UQ/JoYuf2jf+GFX53wrIVtRYog2opFC5Hus4CPvsRIs=;
 b=JHRFle4ZtMdXSgUvTowuJ4DZYRTe7gahbOpSiT2tz3wjk+j/cvLq+zTwEg0F+xNpPa
 n/VMdUHsMsgcWy9tWhVA1fJImROhrteEP/pP5ga43dzptEwHMhnTvBULL+B30ojMB17A
 JVSWH7pruxWZtBsvbRWpbYzwdXCmTtfHr2mXog8c/hNv27PIpW93pRN39lzPPbOHXxl2
 06rnudwjFQEbZdEkc2n/Jo/CjgZn3Rt+wr1tmKtt4iT6yZwxMpsi3WpFD7OTprJQV0zk
 DQNGU7jfjwadtmi3aImEWM8iIyrANvdaFlt/lI8oI3PVqncNAOmYVgnzaMIrhJF5I0FC
 XuUw==
X-Gm-Message-State: AFq9FYKzPFkLhrEXnFhcq/ryzpz0EZBxkaHFD7OfwgL/zcKSYqjSxxXB
 qX858uVXBIKffzYY/uQBS7/SrH3PO9ldZDprh6eXFZA3jFjp5lS/z+/iyR6IDELxoYXHkiUNVo8
 t5Xfk
X-Gm-Gg: AYBFou1uf9fLunD6i3mfBQxf+Vdp3uJ2K2N5FX6XHOBLuBOeKazOXGTAgxMlcQU+++1
 t03GhYrPHfvZ6CdWyETAenoTAwAY4cnYZzlUcGqYnIkdP3JMJPZM8iaPpcApl3gjYOXA6+zskIY
 MIrC87NlMl3hBRBIq7UAeYrqNBVuR5auDAQwTOESlCC9QGDyn+sJkDChJLHi12ntnfKrHc01lfs
 R7D+ZPYetZs91GbbTMgKdcSZ0HdBC7enUpZDByER52zPmx7GA9G9lMuwqcfcgxLy4WJomJxuBsz
 8AYfmVGT07/RSyUNGfRKm5d+ekFhzF+PRdIuebFcjBM5rmq6Ce8us7R3i+X87IMegH4W+ervAFU
 xvavly5VqrjNkxqLpn1ZS4/iUEF78CnL0oMtKi7NX/8n6DnocVa/pqMgvqioLDD9InG+30Xb378
 +goRQsoVUEqU8Vu3PTDUiQmy0xHSGZ67+SyPQ2NWrvXBkH7Nsa6timcd6TWCNdjIHKaac4lDqAz
 3yDWX1lXj+McNXLTxlK+N1DIdZQkA==
X-Received: by 2002:a17:90a:ec8e:b0:3a0:345a:3620 with SMTP id
 98e67ed59e1d1-3a098df852amr7936062a91.45.1790499861725; 
 Sun, 27 Sep 2026 02:04:21 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0e0ec367csm2916932a91.4.2026.09.27.02.04.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:04:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 064/101] tcg: Generic expansion of tcg_gen_sextract_*
Date: Sun, 27 Sep 2026 01:59:34 -0700
Message-ID: <20260927090011.10724-65-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x11.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |   4 --
 include/tcg/tcg-op-def.h.inc |   1 +
 tcg/tcg-op.c                 | 121 +++++++++++------------------------
 3 files changed, 38 insertions(+), 88 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index ec4cf775b38..ef47b704bc9 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -134,8 +134,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 void tcg_gen_deposit_z_i32(TCGv_i32 ret, TCGv_i32 arg,
                            unsigned int ofs, unsigned int len);
-void tcg_gen_sextract_i32(TCGv_i32 ret, TCGv_i32 arg,
-                          unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i32(TCGv_i32 ret, TCGv_i32 al, TCGv_i32 ah,
                           unsigned int ofs);
 void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
@@ -181,8 +179,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 void tcg_gen_deposit_z_i64(TCGv_i64 ret, TCGv_i64 arg,
                            unsigned int ofs, unsigned int len);
-void tcg_gen_sextract_i64(TCGv_i64 ret, TCGv_i64 arg,
-                          unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah,
                           unsigned int ofs);
 void tcg_gen_add2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 69f76f1d232..338ecce6fce 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -44,6 +44,7 @@ DEF3(sar, TCGV, TCGV, TCGV)
 DEF3(sari, TCGV, TCGV, TINT)
 DEF4(setcond, TCGCond, TCGV, TCGV, TCGV)
 DEF4(setcondi, TCGCond, TCGV, TCGV, TINT)
+DEF4(sextract, TCGV, TCGV, unsigned, unsigned)
 DEF3(shl, TCGV, TCGV, TCGV)
 DEF3(shli, TCGV, TCGV, TINT)
 DEF3(shr, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index a7d815b9e16..8fbf07d045e 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -197,20 +197,6 @@ static void DNI tcg_gen_op4i_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
                 tcgv_i64_arg(a3), a4);
 }
 
-static TCGOp * DNI tcg_gen_op4ii_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
-                                     TCGArg a3, TCGArg a4)
-{
-    return tcg_gen_op4(opc, TCG_TYPE_I32,
-                       tcgv_i32_arg(a1), tcgv_i32_arg(a2), a3, a4);
-}
-
-static TCGOp * DNI tcg_gen_op4ii_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
-                                     TCGArg a3, TCGArg a4)
-{
-    return tcg_gen_op4(opc, TCG_TYPE_I64,
-                       tcgv_i64_arg(a1), tcgv_i64_arg(a2), a3, a4);
-}
-
 static void DNI tcg_gen_op5ii_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
                                   TCGv_i32 a3, TCGArg a4, TCGArg a5)
 {
@@ -923,6 +909,43 @@ void tcg_gen_setcondi(TCGType type, TCGCond cond, TCGTemp *dst,
     tcg_gen_setcond(type, cond, dst, src1, tcg_constant_internal(type, src2));
 }
 
+void tcg_gen_sextract(TCGType type, TCGTemp *dst, TCGTemp *src,
+                      unsigned int ofs, unsigned int len)
+{
+    unsigned width = tcg_type_size(type) * 8;
+
+    tcg_debug_assert(ofs < width);
+    tcg_debug_assert(len > 0);
+    tcg_debug_assert(len <= width);
+    tcg_debug_assert(ofs + len <= width);
+
+    /* Canonicalize certain special cases, even if extract is supported.  */
+    if (ofs + len == width) {
+        tcg_gen_sari(type, dst, src, width - len);
+        return;
+    }
+
+    if (TCG_TARGET_sextract_valid(type, ofs, len)) {
+        tcg_gen_op_ttii(INDEX_op_sextract, type, dst, src, ofs, len);
+        return;
+    }
+
+    /* Assume that sign-extension, if available, is cheaper than a shift.  */
+    if (TCG_TARGET_sextract_valid(type, 0, ofs + len)) {
+        tcg_gen_op_ttii(INDEX_op_sextract, type, dst, src, 0, ofs + len);
+        tcg_gen_sari(type, dst, dst, ofs);
+        return;
+    }
+    if (TCG_TARGET_sextract_valid(type, 0, len)) {
+        tcg_gen_shri(type, dst, src, ofs);
+        tcg_gen_op_ttii(INDEX_op_sextract, type, dst, dst, 0, len);
+        return;
+    }
+
+    tcg_gen_shli(type, dst, src, width - len - ofs);
+    tcg_gen_sari(type, dst, dst, width - len);
+}
+
 void tcg_gen_shl(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     tcg_gen_op_ttt(INDEX_op_shl, type, dst, src1, src2);
@@ -1009,41 +1032,6 @@ void tcg_gen_deposit_z_i32(TCGv_i32 ret, TCGv_i32 arg,
     }
 }
 
-void tcg_gen_sextract_i32(TCGv_i32 ret, TCGv_i32 arg,
-                          unsigned int ofs, unsigned int len)
-{
-    tcg_debug_assert(ofs < 32);
-    tcg_debug_assert(len > 0);
-    tcg_debug_assert(len <= 32);
-    tcg_debug_assert(ofs + len <= 32);
-
-    /* Canonicalize certain special cases, even if extract is supported.  */
-    if (ofs + len == 32) {
-        tcg_gen_sari_i32(ret, arg, 32 - len);
-        return;
-    }
-
-    if (TCG_TARGET_sextract_valid(TCG_TYPE_I32, ofs, len)) {
-        tcg_gen_op4ii_i32(INDEX_op_sextract, ret, arg, ofs, len);
-        return;
-    }
-
-    /* Assume that sign-extension, if available, is cheaper than a shift.  */
-    if (TCG_TARGET_sextract_valid(TCG_TYPE_I32, 0, ofs + len)) {
-        tcg_gen_op4ii_i32(INDEX_op_sextract, ret, arg, 0, ofs + len);
-        tcg_gen_sari_i32(ret, ret, ofs);
-        return;
-    }
-    if (TCG_TARGET_sextract_valid(TCG_TYPE_I32, 0, len)) {
-        tcg_gen_shri_i32(ret, arg, ofs);
-        tcg_gen_op4ii_i32(INDEX_op_sextract, ret, ret, 0, len);
-        return;
-    }
-
-    tcg_gen_shli_i32(ret, arg, 32 - len - ofs);
-    tcg_gen_sari_i32(ret, ret, 32 - len);
-}
-
 /*
  * Extract 32-bits from a 64-bit input, ah:al, starting from ofs.
  * Unlike tcg_gen_extract_i32 above, len is fixed at 32.
@@ -1713,41 +1701,6 @@ void tcg_gen_deposit_z_i64(TCGv_i64 ret, TCGv_i64 arg,
     }
 }
 
-void tcg_gen_sextract_i64(TCGv_i64 ret, TCGv_i64 arg,
-                          unsigned int ofs, unsigned int len)
-{
-    tcg_debug_assert(ofs < 64);
-    tcg_debug_assert(len > 0);
-    tcg_debug_assert(len <= 64);
-    tcg_debug_assert(ofs + len <= 64);
-
-    /* Canonicalize certain special cases, even if sextract is supported.  */
-    if (ofs + len == 64) {
-        tcg_gen_sari_i64(ret, arg, 64 - len);
-        return;
-    }
-
-    if (TCG_TARGET_sextract_valid(TCG_TYPE_I64, ofs, len)) {
-        tcg_gen_op4ii_i64(INDEX_op_sextract, ret, arg, ofs, len);
-        return;
-    }
-
-    /* Assume that sign-extension, if available, is cheaper than a shift.  */
-    if (TCG_TARGET_sextract_valid(TCG_TYPE_I64, 0, ofs + len)) {
-        tcg_gen_op4ii_i64(INDEX_op_sextract, ret, arg, 0, ofs + len);
-        tcg_gen_sari_i64(ret, ret, ofs);
-        return;
-    }
-    if (TCG_TARGET_sextract_valid(TCG_TYPE_I64, 0, len)) {
-        tcg_gen_shri_i64(ret, arg, ofs);
-        tcg_gen_op4ii_i64(INDEX_op_sextract, ret, ret, 0, len);
-        return;
-    }
-
-    tcg_gen_shli_i64(ret, arg, 64 - len - ofs);
-    tcg_gen_sari_i64(ret, ret, 64 - len);
-}
-
 /*
  * Extract 64 bits from a 128-bit input, ah:al, starting from ofs.
  * Unlike tcg_gen_extract_i64 above, len is fixed at 64.
-- 
2.53.0


