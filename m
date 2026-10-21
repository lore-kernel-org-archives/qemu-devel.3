Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54623606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=MN/T57C4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXGN-0005a3-07; Wed, 21 Oct 2026 10:25:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXDS-0001eV-JA
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:22:56 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXDM-0002Ab-M2
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:22:52 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-48c4649b35bso711175f8f.3
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592563; x=1793197363; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jMIXVH0psZ0GYWpdGyqPZHmAkVNMRXS4n2MAzwFShTY=;
 b=MN/T57C4dQIY+Gs4Gqi3H5RQVKjdH1RPhqNHN4Q8wB89FjEc2mdQ6S/7UTCEUmrIH3
 c9cKyupR9f3GAAdxYkKw+u0W55jWoBMpTGiC6XbHD7LFI9nwJMZD7DQMWeCllTaAsrMj
 wjFYsVRcsEhCUq/UqO7Uj5lcxV2k6pHaSOUzziCugrzUT4+/grnLerChbndYupHSI0Lu
 O7HUS0aikT6I/Uqbxmd+5xKM9QQCQKNCsu445YtHYVgrUQA1yvMhThOVDQ6klqjQHu04
 N3IZ2d9xaqK08ZYXI0R6coVjL+uAUTR4JS4HP+L+PWVVchdLe9xAGQKujY4lhWdZjGMi
 LEXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592563; x=1793197363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jMIXVH0psZ0GYWpdGyqPZHmAkVNMRXS4n2MAzwFShTY=;
 b=IVQwoyN0zwFEataXHDa3cKEES/5MS12dWfILhvdmlfuXPyPjXjjGmvVR45gDCBiJZU
 Qvr+PjUwiw6TVAc/DSJreAfe7y+LNvbr9DFUO5XOkiuy1wV9U+lmCjKT53O/YhL8QpYK
 BZbn1cA0L+ui8Y8szHDm16roUDyj4mSOYfxAoI5P6TQtLWS8P4TCkg5XfPrSkodEx2tm
 eJKJy4oJ9UdM7csuApL9OOaK/0xS5xmXndDwr1bDmIPWTLd1nZgR/0XFaIi58RmVvgOn
 iGRutIUL1AGfLq7p/4uZZ6VbqBypz0xryf/sW9vb59GoxZhcHAW6x+Cs+eDqGXDxkTQn
 Yn1g==
X-Gm-Message-State: AFq9FYJZRWTlmniN29V/HWyOShfWs9+0FioEUkBTSW8CTDc/15WCviSv
 juNwlltAbmv0dramfVp/YufNwhdDcdfbsDv79rOh/JlhqadDgQreoWRX+Dmfl0/P+6/wwbK8V/C
 L83AaBUE=
X-Gm-Gg: AYBFou0PLrrLCzFwLwyss7wHLCFNnp5eOT5yIbrJPKkkMBGE1XRuysp3FYr6vx6utdX
 j1X6tf2TWHZh10r8TKTjnOizIRlhjlotxOsb2HGo5NLSnKt2QjfgDobK1ePXhC1cC0MYi+CrEWH
 T9DC8rgJfUWtbwL2pz3OZU9+t9iepVeQzARCE2FKRn9YcdOgUZQEEgwy09NaiLIdTFvt94teQIO
 Ark3AiT7q0pLToectgIgzhs+EdaqZ8/DnzlgS6XGaJ4a/TjMHOr62ryLMVKQymXoqWDkIrc0DDi
 3OvGcXhQ4h4tLhWOYUZegTb3oucloUNldGFN/R7FubKjB8Q+BjMxA9y3VzZjpQjGjua6tHieVyL
 ml1EEFnn93Pnu+EcxgXwj/vr66bnSycW2e35JKb6KSp2oDmqdmtvMZaTcYeFRrHPizBw1WwOM3E
 cWof+EStfLUFR7ibTjaZLd8sJc4ce34+8OBLUjiIcGh/xPjoI0+OaOZ3JvBzKroai4nzaVFq0iT
 Hyo7Eqmvs7gpXV7PFDXum9ItCrSLTTEw5BGzwcmJLZCtcnoV20gq/WcxQRQ9C3u8F9c0n9szcdl
 wCsA+8Va7XGpnyha/71kOKiNqhLF/1ms/nSn6r4QEqi/IX6g
X-Received: by 2002:a5d:6f0c:0:b0:48e:1fb5:eac2 with SMTP id
 ffacd0b85a97d-48e2647cb86mr4403527f8f.12.1792592562601; 
 Wed, 21 Oct 2026 07:22:42 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25828e72sm5393603f8f.26.2026.10.21.07.22.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:22:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 063/100] tcg: Generic expansion of tcg_gen_sextract_*
Date: Wed, 21 Oct 2026 16:16:15 +0200
Message-ID: <20261021141652.363109-64-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |   4 --
 include/tcg/tcg-op-def.h.inc |   1 +
 tcg/tcg-op.c                 | 121 +++++++++++------------------------
 3 files changed, 38 insertions(+), 88 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 77f9599115..34a79c5818 100644
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
index 69f76f1d23..338ecce6fc 100644
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
index a58978dd02..f2928ae8e7 100644
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
@@ -921,6 +907,43 @@ void tcg_gen_setcondi(TCGType type, TCGCond cond, TCGTemp *dst,
     tcg_gen_setcond(type, cond, dst, src1, tcg_constant_internal(type, src2));
 }
 
+void tcg_gen_sextract(TCGType type, TCGTemp *dst, TCGTemp *src,
+                      unsigned int ofs, unsigned int len)
+{
+    unsigned width = tcg_type_bits(type);
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
@@ -1007,41 +1030,6 @@ void tcg_gen_deposit_z_i32(TCGv_i32 ret, TCGv_i32 arg,
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
@@ -1711,41 +1699,6 @@ void tcg_gen_deposit_z_i64(TCGv_i64 ret, TCGv_i64 arg,
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


