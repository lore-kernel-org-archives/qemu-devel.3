Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACDC606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=x2pXCKPl
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXI1-0007N3-3t; Wed, 21 Oct 2026 10:27:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXGY-0006Ha-Oh
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:26:07 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXGW-0002XA-61
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:26:06 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4a0286c981dso8071745e9.2
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592763; x=1793197563; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=64u8m5ETkG9QwpMzgD7k/dGN+dngrg2ySwjvjK1W5gg=;
 b=x2pXCKPl6H5jE6EIII3iLq5u2Szgi8wp+HPCciE9xd9AvV3IetkyDxY3JZ77hc2AoZ
 KCTzRJngMjRrl/kh3LhhwdQH5w5x3LScIcsYuSnAS0qP/wdrmdnYzThi59TGNqbD7xRT
 IKx/Zq2F0B/nNAMqqq/2m7TjPr+eGyl7OOs/gL9mq4E8XWjm/XqKdIcdfKMTRLfWL6H1
 zU7a4YhM6eseRDq8ETaEljeSUma0pQ15AtIj6fs2pRkX7EgdtWVdAigPlG7JRzPhcXlS
 IjrETXQcr7kHWmCLWr0Lx+z9LmZIKvEWuFU17KV/E8zjdpWVWC9BRfwg1awqQqdedtdW
 gKaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592763; x=1793197563;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=64u8m5ETkG9QwpMzgD7k/dGN+dngrg2ySwjvjK1W5gg=;
 b=bt8bGuiq9JJVTUbDoDbVuZ7KJYF6Ib1BR/ExUbF/0E0SwIq8XBRaDK7o4ZGIZZmEO8
 5RT183vFw9cXFl4zyp8kOO8MmoTqit7rCdqXdMMx1GyMATEMCZ5AYwjWRZTYAmuRP1Xr
 RqV09VCrVIJYzLOotShj5LgB21jdEF/eiQug0wtzxyYrZJqNRWUkfJhcCUYEQNpteBnN
 TnHNgMK/DQHMcEhK8+M0uP4D+B9BOyxiQfKpSisf6x3iu1OtMoNdq03zYU6dR6Zv9Wqb
 TZBWJFbXdf2fj0CbeYmm9498nCH9T2ZtsFO9X84aAADFBoxCxx2IbulXfqR4mm8n9YNp
 LMqA==
X-Gm-Message-State: AFq9FYLhZFnTZZvLb0JWxl1yWuIbm07ONfgEIUARd3UE2QFQaJ8C12nm
 9alm908NJizC9sEwk5oV528QYswQwINO2t1+nCCGvnYzUI/mhDjChphXQT9y90+r9TAt/NzgpxP
 VRQMANm8=
X-Gm-Gg: AYBFou3qpZZ3sWIYgcsAJ5sz75t0FOqRTIXtqLvLvZWNBVVjEwMAVkx40arzaBfBCf/
 x3XnQYC+/fz2JLcmHpxnRb70s2dpkf1cyHufk2hjgc8Mu8UGE28Xm/aVnknIyqg26MvXlR6v9ZH
 PShR7d+H3+uGIjuzrXJ0FdCi0uU6NGAZFpPkQfQw2cTXcwTqUBO3y9wZkKECRZlVE7sUydW63Ul
 Mg5+Ygl2Q7EyREORwVcQWtHUGbuAaoeleerGu4Dav5KgdV05WPMYWQD2kdiAP5LESmXj/Lmbvh5
 sQn6FOYLw4iZTC+UUg7vdm1LYOx+NM2LYZBG5MsWicah+OClOnIVXeQhgaUobLjwMT2hCGl2LMj
 Az+ohdz70YF5JxBV4ghxUzHRkXk1nLq4pAAah2kwBUhHvK/4XrSka6lCmSrkhjyjJol+WIclOTy
 w4QxrmIPseB2wXVJDewZE6hKXzrhOJc2JFiOc+K+oA8yqX2lF/vJpGg2ay1nuQbvzIn+gli03k7
 GniW8l2FYINIcNlsE9meeqMrw2uIrGmd/qNtftB7I1ydIFNgdoNKZ35QJORq8d8TTL3LgbiN77K
 eGEC52+PY+26wcNQ43XScSqvYoA=
X-Received: by 2002:a05:600c:8b72:b0:4a1:8efb:c9ae with SMTP id
 5b1f17b1804b1-4a1fdd2b8e4mr42700535e9.23.1792592762516; 
 Wed, 21 Oct 2026 07:26:02 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25828cd1sm5710878f8f.22.2026.10.21.07.26.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:26:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 082/100] tcg: Generic expansion of tcg_gen_muls2_*
Date: Wed, 21 Oct 2026 16:16:34 +0200
Message-ID: <20261021141652.363109-83-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32c.google.com
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
 include/tcg/tcg-op-common.h  |   2 -
 include/tcg/tcg-op-def.h.inc |   1 +
 tcg/tcg-op.c                 | 131 +++++++++++++----------------------
 3 files changed, 51 insertions(+), 83 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index cd30395c70..d3271c5a66 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -132,7 +132,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_muls2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags);
 void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg);
@@ -156,7 +155,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 /* 64 bit ops */
 
 void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b);
-void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext32u_i64(TCGv_i64 ret, TCGv_i64 arg);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index b24122173a..b606aaab12 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -35,6 +35,7 @@ DEF2(movi, TCGV, TINT)
 DEF6(movcond, TCGCond, TCGV, TCGV, TCGV, TCGV, TCGV)
 DEF3(mul, TCGV, TCGV, TCGV)
 DEF3(muli, TCGV, TCGV, TINT)
+DEF4(muls2, TCGV, TCGV, TCGV, TCGV)
 DEF4(mulu2, TCGV, TCGV, TCGV, TCGV)
 DEF3(nand, TCGV, TCGV, TCGV)
 DEF2(neg, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 822ac56c08..94befedb69 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -129,13 +129,6 @@ static void DNI tcg_gen_op2_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2)
     tcg_gen_op2(opc, TCG_TYPE_I64, tcgv_i64_arg(a1), tcgv_i64_arg(a2));
 }
 
-static void DNI tcg_gen_op3_i32(TCGOpcode opc, TCGv_i32 a1,
-                                TCGv_i32 a2, TCGv_i32 a3)
-{
-    tcg_gen_op3(opc, TCG_TYPE_I32, tcgv_i32_arg(a1),
-                tcgv_i32_arg(a2), tcgv_i32_arg(a3));
-}
-
 static void DNI tcg_gen_op3_i64(TCGOpcode opc, TCGv_i64 a1,
                                 TCGv_i64 a2, TCGv_i64 a3)
 {
@@ -169,20 +162,6 @@ static void DNI tcg_gen_ldst_op_i64(TCGOpcode opc, TCGv_i64 val,
                 tcgv_ptr_arg(base), offset);
 }
 
-static void DNI tcg_gen_op4_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
-                                TCGv_i32 a3, TCGv_i32 a4)
-{
-    tcg_gen_op4(opc, TCG_TYPE_I32, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
-                tcgv_i32_arg(a3), tcgv_i32_arg(a4));
-}
-
-static void DNI tcg_gen_op4_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
-                                TCGv_i64 a3, TCGv_i64 a4)
-{
-    tcg_gen_op4(opc, TCG_TYPE_I64, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
-                tcgv_i64_arg(a3), tcgv_i64_arg(a4));
-}
-
 /* Generic ops.  */
 
 void gen_set_label(TCGLabel *l)
@@ -776,6 +755,56 @@ void tcg_gen_muli(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     }
 }
 
+void tcg_gen_muls2(TCGType type, TCGTemp *rl, TCGTemp *rh,
+                   TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_muls2, type, 0)) {
+        tcg_gen_op_tttt(INDEX_op_muls2, type, rl, rh, src1, src2);
+    } else if (tcg_op_supported(INDEX_op_mulsh, type, 0)) {
+        g_autoptr(TCGTemp) t = tcg_temp_new_ebb(type);
+
+        tcg_gen_mul(type, t, src1, src2);
+        tcg_gen_op_ttt(INDEX_op_mulsh, type, rh, src1, src2);
+        tcg_gen_mov(type, rl, t);
+    } else if (type == TCG_TYPE_I32) {
+        g_autoptr(TCGTemp) t0 = tcg_temp_new_ebb(TCG_TYPE_I64);
+        g_autoptr(TCGTemp) t1 = tcg_temp_new_ebb(TCG_TYPE_I64);
+
+        /* Simply extend and use host 64-bit multiply. */
+        tcg_gen_exts(t0, src1);
+        tcg_gen_exts(t1, src2);
+        tcg_gen_mul(TCG_TYPE_I64, t0, t0, t1);
+        tcg_gen_extrl(rl, t0);
+        tcg_gen_extrh(rh, t0);
+    } else if (tcg_op_supported(INDEX_op_mulu2, TCG_TYPE_I64, 0) ||
+               tcg_op_supported(INDEX_op_muluh, TCG_TYPE_I64, 0)) {
+        g_autoptr(TCGTemp) t0 = tcg_temp_new_ebb(type);
+        g_autoptr(TCGTemp) t1 = tcg_temp_new_ebb(type);
+        g_autoptr(TCGTemp) t2 = NULL;
+        g_autoptr(TCGTemp) t3 = NULL;
+
+        tcg_gen_mulu2(TCG_TYPE_I64, t0, t1, src1, src2);
+
+        /* Adjust for negative inputs.  */
+        t2 = tcg_temp_new_ebb(type);
+        t3 = tcg_temp_new_ebb(type);
+        tcg_gen_sari(TCG_TYPE_I64, t2, src1, 63);
+        tcg_gen_sari(TCG_TYPE_I64, t3, src2, 63);
+        tcg_gen_and(TCG_TYPE_I64, t2, t2, src2);
+        tcg_gen_and(TCG_TYPE_I64, t3, t3, src1);
+        tcg_gen_sub(TCG_TYPE_I64, rh, t1, t2);
+        tcg_gen_sub(TCG_TYPE_I64, rh, rh, t3);
+        tcg_gen_mov(TCG_TYPE_I64, rl, t0);
+    } else {
+        g_autoptr(TCGTemp) t = tcg_temp_new_ebb(type);
+
+        tcg_gen_mul(TCG_TYPE_I64, t, src1, src2);
+        gen_helper_mulsh_i64(temp_tcgv_i64(rh), temp_tcgv_i64(src1),
+                             temp_tcgv_i64(src2));
+        tcg_gen_mov(TCG_TYPE_I64, rl, t);
+    }
+}
+
 void tcg_gen_mulu2(TCGType type, TCGTemp *rl, TCGTemp *rh,
                    TCGTemp *src1, TCGTemp *src2)
 {
@@ -1214,28 +1243,6 @@ void tcg_gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_muls2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (tcg_op_supported(INDEX_op_muls2, TCG_TYPE_I32, 0)) {
-        tcg_gen_op4_i32(INDEX_op_muls2, rl, rh, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_mulsh, TCG_TYPE_I32, 0)) {
-        TCGv_i32 t = tcg_temp_ebb_new_i32();
-        tcg_gen_op3_i32(INDEX_op_mul, t, arg1, arg2);
-        tcg_gen_op3_i32(INDEX_op_mulsh, rh, arg1, arg2);
-        tcg_gen_mov_i32(rl, t);
-        tcg_temp_free_i32(t);
-    } else {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        TCGv_i64 t1 = tcg_temp_ebb_new_i64();
-        tcg_gen_ext_i32_i64(t0, arg1);
-        tcg_gen_ext_i32_i64(t1, arg2);
-        tcg_gen_mul_i64(t0, t0, t1);
-        tcg_gen_extr_i64_i32(rl, rh, t0);
-        tcg_temp_free_i64(t0);
-        tcg_temp_free_i64(t1);
-    }
-}
-
 void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     TCGv_i64 t0 = tcg_temp_ebb_new_i64();
@@ -1699,44 +1706,6 @@ void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b)
     }
 }
 
-void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (tcg_op_supported(INDEX_op_muls2, TCG_TYPE_I64, 0)) {
-        tcg_gen_op4_i64(INDEX_op_muls2, rl, rh, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_mulsh, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t = tcg_temp_ebb_new_i64();
-        tcg_gen_op3_i64(INDEX_op_mul, t, arg1, arg2);
-        tcg_gen_op3_i64(INDEX_op_mulsh, rh, arg1, arg2);
-        tcg_gen_mov_i64(rl, t);
-        tcg_temp_free_i64(t);
-    } else if (tcg_op_supported(INDEX_op_mulu2, TCG_TYPE_I64, 0) ||
-               tcg_op_supported(INDEX_op_muluh, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        TCGv_i64 t1 = tcg_temp_ebb_new_i64();
-        TCGv_i64 t2 = tcg_temp_ebb_new_i64();
-        TCGv_i64 t3 = tcg_temp_ebb_new_i64();
-        tcg_gen_mulu2_i64(t0, t1, arg1, arg2);
-        /* Adjust for negative inputs.  */
-        tcg_gen_sari_i64(t2, arg1, 63);
-        tcg_gen_sari_i64(t3, arg2, 63);
-        tcg_gen_and_i64(t2, t2, arg2);
-        tcg_gen_and_i64(t3, t3, arg1);
-        tcg_gen_sub_i64(rh, t1, t2);
-        tcg_gen_sub_i64(rh, rh, t3);
-        tcg_gen_mov_i64(rl, t0);
-        tcg_temp_free_i64(t0);
-        tcg_temp_free_i64(t1);
-        tcg_temp_free_i64(t2);
-        tcg_temp_free_i64(t3);
-    } else {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        tcg_gen_mul_i64(t0, arg1, arg2);
-        gen_helper_mulsh_i64(rh, arg1, arg2);
-        tcg_gen_mov_i64(rl, t0);
-        tcg_temp_free_i64(t0);
-    }
-}
-
 void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-- 
2.53.0


