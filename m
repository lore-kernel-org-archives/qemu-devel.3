Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36575606A31B
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=e9aNsRlB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsc0-0007Sn-Jl; Sun, 25 Oct 2026 03:25:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsZw-0006tb-8K
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:23:40 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsZu-0004AG-De
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:23:39 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-48df8fe8513so1911625f8f.0
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792913017; x=1793517817; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yIFu0Lt1M9KBVDwwVbfDFI4QapjeM+Xeec4878CB1bw=;
 b=e9aNsRlBwYYNGp8SmKSZWm46VeOqiVzri4OGUr9wguJgj4pdmWHKy9jumbV8wFMSZX
 zXm+JrAcdwnWbbm0pSn4uTJ1TBsqi4ls5fM5IZXO1mky39inMIZ0YSjNsM+UALhZKRyD
 O/z8D63t8dN8+XKI9aWpjzL4Fu73ObWyfEizHt+p1DASpDRa4WMFxPkOkgZoZGrfVoVo
 PIyE0P2rBvVWiGbN1Yf7NXhJxNxmgQvm9V6GXAxtwgWguQrNPIdV4zxzJyFR0aA2tdiL
 qnjei+xGYhr/yAi33X/6wOn5o8k+qsfNcTlFadZPW4wEbjoVAE1WmS9kN07SyU+6SVpI
 mzEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792913017; x=1793517817;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yIFu0Lt1M9KBVDwwVbfDFI4QapjeM+Xeec4878CB1bw=;
 b=QTJXkvbIHZtDY3l/rBgneaYKfpCKdeCDNAssEr9/RLmY6z7cXM31Ygz8v+LRZu78fn
 UY9UCof4A3d5WyLZ42pjCfhtZLqhGll2aMGSgZ/o1WHk4HdHBDXTdXK0gIcT2P8zxZMg
 GvHx50mspxp5nEEJy4j8lqbXY3Q0lbAbW+IoUz9PU5nP2uIfyxXQue6h6JP57WrKthi8
 YezbmsU8TbSVpV2Ni0JYd8f5iFGFEN5NOzVSdTwvETa5AURvMEAT+zBt5QQce788xlCE
 pb4UiJkke6HCZz2x6vuWa1VB2GZ7mJZ+pHLzh9/TsVFY/4v41DN2zWiqwYwP77ZNiKoQ
 0qpQ==
X-Gm-Message-State: AFq9FYK6Q9wmtncbgefPSHuY07GIHq+Z07esrJfWIx7yGsafpvR93/he
 HFG5q47WRHtWDshHlTVUz+gmOhS0oI7gyGe+ZtzrV5QXq+tdWAeH+PYg4d+amI1XMERPlFUPZaE
 pp1qVJbI=
X-Gm-Gg: AYBFou2arnFOurFAFpnwICz8ugyNdbEA13a081Nt/v0J3mGpC9QQkLSuj1B3YvgK/Gm
 G28refj1c1bhMjgXeFTxy/j8xlpx8oEWXFIdVJeR6JvLR9bQ0p4rXoGTqLvr5yE61p+kO1/M2/r
 VIT78NuE82KyreVGAh6I+XOoTetAuEuoVBmrLQk4HxUPB2siPi88UkXbQzJ2oJOnQq/eKHXZBCv
 uSrDq1LZehe9fP408/5IFOacZ6BJuAQg2ZYtgwRqxf4QJwaBI/vRJqo3IIurgcu9xuFiCOvCdSV
 2YW0bJWgFr3AtSDwzorX6QpciA/7C2kh+ZjOsI8lp/XZGRBL7DlMupX6BfoHOg3gcs165E8t7is
 w8LSzE1w31IZ+AEqnx0s45JGQ1qa0K+XgaPAiwhAVt9o0717Ze4LAaBavBbG1I9x4+cnq44H9S/
 /rQ+b35tUV7oJb9k//TXJevF6mTIhHJ5Fo2YAQHQ7Zo8PNSAFx12H8QDLSdF4e0ca8x9Es3scZk
 YRprQbObP8HTwCT++sByogyvXHRCWyvGGwDonXEIPEMgYVmVnaOFJ7ZTUY=
X-Received: by 2002:a05:600c:6749:b0:4a2:e0c:2b10 with SMTP id
 5b1f17b1804b1-4a35aca32e1mr54660845e9.19.1792913017023; 
 Sun, 25 Oct 2026 00:23:37 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a09434esm103085895e9.0.2026.10.25.00.23.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:23:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PULL 077/100] tcg: Generic expansion of tcg_gen_extract2_*
Date: Sun, 25 Oct 2026 08:18:52 +0100
Message-ID: <20261025071915.1123867-78-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x432.google.com
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  4 ---
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 70 ++++++++++--------------------------
 3 files changed, 19 insertions(+), 56 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 6942012787..c1c41a03f3 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -132,8 +132,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_extract2_i32(TCGv_i32 ret, TCGv_i32 al, TCGv_i32 ah,
-                          unsigned int ofs);
 void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
                       TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh);
 void tcg_gen_sub2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
@@ -164,8 +162,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_extract2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah,
-                          unsigned int ofs);
 void tcg_gen_add2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
                       TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh);
 void tcg_gen_sub2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 82dfc90009..a237ccd0c5 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -26,6 +26,7 @@ DEF2(ext8u, TCGV, TCGV)
 DEF2(ext16s, TCGV, TCGV)
 DEF2(ext16u, TCGV, TCGV)
 DEF4(extract, TCGV, TCGV, unsigned, unsigned)
+DEF4(extract2, TCGV, TCGV, TCGV, unsigned)
 DEF3(eqv, TCGV, TCGV, TCGV)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index f6cc56661d..ecb6abb0ac 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -183,20 +183,6 @@ static void DNI tcg_gen_op4_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
                 tcgv_i64_arg(a3), tcgv_i64_arg(a4));
 }
 
-static void DNI tcg_gen_op4i_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
-                                 TCGv_i32 a3, TCGArg a4)
-{
-    tcg_gen_op4(opc, TCG_TYPE_I32, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
-                tcgv_i32_arg(a3), a4);
-}
-
-static void DNI tcg_gen_op4i_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
-                                 TCGv_i64 a3, TCGArg a4)
-{
-    tcg_gen_op4(opc, TCG_TYPE_I64, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
-                tcgv_i64_arg(a3), a4);
-}
-
 /* Generic ops.  */
 
 void gen_set_label(TCGLabel *l)
@@ -691,6 +677,24 @@ void tcg_gen_extract(TCGType type, TCGTemp *dst, TCGTemp *src,
     }
 }
 
+/* Extract one word from a pair, hi:lo, starting from ofs.  */
+void tcg_gen_extract2(TCGType type, TCGTemp *dst, TCGTemp *lo, TCGTemp *hi,
+                      unsigned int ofs)
+{
+    unsigned width = tcg_type_bits(type);
+
+    tcg_debug_assert(ofs <= width);
+    if (ofs == 0) {
+        tcg_gen_mov(type, dst, lo);
+    } else if (ofs == width) {
+        tcg_gen_mov(type, dst, hi);
+    } else if (lo == hi) {
+        tcg_gen_rotri(type, dst, lo, ofs);
+    } else {
+        tcg_gen_op_ttti(INDEX_op_extract2, type, dst, lo, hi, ofs);
+    }
+}
+
 void tcg_gen_mov(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     if (src != dst) {
@@ -1119,25 +1123,6 @@ void tcg_gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-/*
- * Extract 32-bits from a 64-bit input, ah:al, starting from ofs.
- * Unlike tcg_gen_extract_i32 above, len is fixed at 32.
- */
-void tcg_gen_extract2_i32(TCGv_i32 ret, TCGv_i32 al, TCGv_i32 ah,
-                          unsigned int ofs)
-{
-    tcg_debug_assert(ofs <= 32);
-    if (ofs == 0) {
-        tcg_gen_mov_i32(ret, al);
-    } else if (ofs == 32) {
-        tcg_gen_mov_i32(ret, ah);
-    } else if (al == ah) {
-        tcg_gen_rotri_i32(ret, al, ofs);
-    } else {
-        tcg_gen_op4i_i32(INDEX_op_extract2, ret, al, ah, ofs);
-    }
-}
-
 void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
                       TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh)
 {
@@ -1674,25 +1659,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-/*
- * Extract 64 bits from a 128-bit input, ah:al, starting from ofs.
- * Unlike tcg_gen_extract_i64 above, len is fixed at 64.
- */
-void tcg_gen_extract2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah,
-                          unsigned int ofs)
-{
-    tcg_debug_assert(ofs <= 64);
-    if (ofs == 0) {
-        tcg_gen_mov_i64(ret, al);
-    } else if (ofs == 64) {
-        tcg_gen_mov_i64(ret, ah);
-    } else if (al == ah) {
-        tcg_gen_rotri_i64(ret, al, ofs);
-    } else {
-        tcg_gen_op4i_i64(INDEX_op_extract2, ret, al, ah, ofs);
-    }
-}
-
 void tcg_gen_add2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
                       TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh)
 {
-- 
2.53.0


