Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6464E606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Nrgt3IBS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsak-00027n-7T; Sun, 25 Oct 2026 03:24:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsZi-0006aR-9u
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:23:29 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsZf-00047L-Fu
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:23:25 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a59100fa83so961375e9.0
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792913002; x=1793517802; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DpIalWxBxAaKZNEE/7y0ivzQcaXOja/Enpk3QnQx0wc=;
 b=Nrgt3IBSZA8avZR8lCWT/FQ/AICRl5UhjEq3GqZAYwGj7p3aHFLJC8RbFr+u//nNU9
 Pe+d/EzX7gp3vvWcFS4AXyp9IncFwtE5NlzYGIO1DffBGOS88MJk6FdPGo/e/qWO0oev
 ipzEOegLvsfjXpgt71xNsKzAVpax2PidtiZv+uuYBZNp1ytrMGfcjpYcUxiDk/56b0YS
 +sariAO6fDbNkJ1ABWSqOfpn9Jest1A+97J6DuwRzi9kN51yYJAHMGtzyLIW7MNm4p2Y
 M+U2zR0CsBajLuccbgGrt+M9Y84mz3WT7dw9bErRk936IjeAslw20KJ7uQUOfkVChhmS
 jR2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792913002; x=1793517802;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DpIalWxBxAaKZNEE/7y0ivzQcaXOja/Enpk3QnQx0wc=;
 b=Z2EIi7N0SRL11dz38Iq+3TGFKp2+L3xsw3PFccGIkRFJXq9Fm694fcE7cTGrMrxqXX
 aTb+2Sqm0BULFsLe3tIAzHtyq3VpTIbblI9PbpiUPomeTijSKaymr9uOT1pkDOcasu05
 n14Uyy4a1c2omg4tx7r3YXhOkmFeIFdnm3wYKbC63ziWencuZZs23lTiUZ4zodKLOMBp
 OBh3jqD54chW6Yt9DoIr7NRYmzF5RwoT9eqJThwRGa8kAkhZCExF+nNjLRQ2BjwPYj+o
 phgR6goO//lOuAIfRFsKTYcKYaqlD00X1vqabstRvSO4/FrU+1V6YQ4OrRmcNMVaGCc0
 7qEQ==
X-Gm-Message-State: AFq9FYIXlo/Cv6/UF8CpDodP/Kwh3nnJGEg9K1IeIO+x4DrInh8vTom0
 /CFf0lOrl27krmRsP7rgQoDTOTMqs+so4odW8p/7Syw/sobQgZYwJJ9d0rMbZH2Q9Q640Pto4/Y
 1Ta5FozM=
X-Gm-Gg: AYBFou1ahCDVuhUP8mUyPaX7IrYEtchjJBkKiSjriaa+A4nG/uYo04pYhHdb1BxbHq1
 XkE8tQcu5eS40ORfOK8gspZqJb+iwCQIlYssyn9SdcgQ/4r4XPDbBNqFVYYKo1zwhYBZfBFLzvb
 2UYsZIs+/8MJByscwbk703l+qKsBlhKE+IT/9pwDhGoejR4CkdvZLCfiVCLItPsLPwFj5loFNDt
 ndgZR0zIXHVieConQMQlwH3e9d9yfQ7HJ0RBj6bnWqpaw8oQZ2HJB7JRwRi85CT45b5S/b6DLU0
 drc7kcOlcWCHHMGowx4imP8FlaHbljEYFAYpbs1lGKYqG/8gc+Omd8nmyoBmWN6VbmGR3w2wNVR
 otKOSuGJB+wPBRX1q1zY+EXvRcYbshH3BHvaShoL2FUf5P4shA18Yp9Tdswv/ZwwY5IXMPzpgm5
 J3h4rVQam2m6z14rpAy4InF+b4jiKo8oYazilgoOQRM6qFecTjsruFymjmg6iO99AYN+Fcrhhrm
 dNgHWi+NOQRPZ34Zm+wLKtkVgwtrBiAv8yK8obOpEQvfXFn+LvcDwFZSx0=
X-Received: by 2002:a05:600c:198c:b0:4a1:e6c8:ff74 with SMTP id
 5b1f17b1804b1-4a35acc0b00mr58985405e9.29.1792913002048; 
 Sun, 25 Oct 2026 00:23:22 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a09434esm103085895e9.0.2026.10.25.00.23.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:23:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PULL 062/100] tcg: Generic expansion of tcg_gen_extract_*
Date: Sun, 25 Oct 2026 08:18:37 +0100
Message-ID: <20261025071915.1123867-63-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x330.google.com
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
 include/tcg/tcg-op-common.h  |   4 --
 include/tcg/tcg-op-def.h.inc |   1 +
 tcg/tcg-op.c                 | 131 ++++++++++++-----------------------
 3 files changed, 46 insertions(+), 90 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 7cb1a4de52..77f9599115 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -134,8 +134,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 void tcg_gen_deposit_z_i32(TCGv_i32 ret, TCGv_i32 arg,
                            unsigned int ofs, unsigned int len);
-void tcg_gen_extract_i32(TCGv_i32 ret, TCGv_i32 arg,
-                         unsigned int ofs, unsigned int len);
 void tcg_gen_sextract_i32(TCGv_i32 ret, TCGv_i32 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i32(TCGv_i32 ret, TCGv_i32 al, TCGv_i32 ah,
@@ -183,8 +181,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 void tcg_gen_deposit_z_i64(TCGv_i64 ret, TCGv_i64 arg,
                            unsigned int ofs, unsigned int len);
-void tcg_gen_extract_i64(TCGv_i64 ret, TCGv_i64 arg,
-                         unsigned int ofs, unsigned int len);
 void tcg_gen_sextract_i64(TCGv_i64 ret, TCGv_i64 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah,
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 95885d28d8..69f76f1d23 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -18,6 +18,7 @@ DEF5(deposit, TCGV, TCGV, TCGV, unsigned, unsigned)
 DEF1(discard, TCGV)
 DEF3(div, TCGV, TCGV, TCGV)
 DEF3(divu, TCGV, TCGV, TCGV)
+DEF4(extract, TCGV, TCGV, unsigned, unsigned)
 DEF3(eqv, TCGV, TCGV, TCGV)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 62c2186d0c..a58978dd02 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -607,6 +607,51 @@ void tcg_gen_eqv(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+void tcg_gen_extract(TCGType type, TCGTemp *dst, TCGTemp *src,
+                     unsigned int ofs, unsigned int len)
+{
+    unsigned width = tcg_type_bits(type);
+    uint64_t mask;
+
+    tcg_debug_assert(ofs < width);
+    tcg_debug_assert(len > 0);
+    tcg_debug_assert(len <= width);
+    tcg_debug_assert(ofs + len <= width);
+
+    /* Canonicalize certain special cases, even if extract is supported.  */
+    if (ofs + len == width) {
+        tcg_gen_shri(type, dst, src, ofs);
+        return;
+    }
+
+    if (TCG_TARGET_extract_valid(type, ofs, len)) {
+        tcg_gen_op_ttii(INDEX_op_extract, type, dst, src, ofs, len);
+        return;
+    }
+
+    /* Assume that zero-extension, if available, is cheaper than a shift.  */
+    if (TCG_TARGET_extract_valid(type, 0, ofs + len)) {
+        tcg_gen_op_ttii(INDEX_op_extract, type, dst, src, 0, ofs + len);
+        tcg_gen_shri(type, dst, dst, ofs);
+        return;
+    }
+    if (TCG_TARGET_extract_valid(type, 0, len)) {
+        tcg_gen_shri(type, dst, src, ofs);
+        tcg_gen_op_ttii(INDEX_op_extract, type, dst, dst, 0, len);
+        return;
+    }
+
+    mask = MAKE_64BIT_MASK(0, len);
+    if (tcg_op_imm_match(INDEX_op_and, type, mask)) {
+        tcg_gen_shri(type, dst, src, ofs);
+        /* Do not recurse with gen_andi. */
+        tcg_gen_and(type, dst, dst, tcg_constant_internal(type, mask));
+    } else {
+        tcg_gen_shli(type, dst, src, width - len - ofs);
+        tcg_gen_shri(type, dst, dst, width - len);
+    }
+}
+
 void tcg_gen_mov(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     if (src != dst) {
@@ -962,49 +1007,6 @@ void tcg_gen_deposit_z_i32(TCGv_i32 ret, TCGv_i32 arg,
     }
 }
 
-void tcg_gen_extract_i32(TCGv_i32 ret, TCGv_i32 arg,
-                         unsigned int ofs, unsigned int len)
-{
-    uint32_t mask;
-
-    tcg_debug_assert(ofs < 32);
-    tcg_debug_assert(len > 0);
-    tcg_debug_assert(len <= 32);
-    tcg_debug_assert(ofs + len <= 32);
-
-    /* Canonicalize certain special cases, even if extract is supported.  */
-    if (ofs + len == 32) {
-        tcg_gen_shri_i32(ret, arg, 32 - len);
-        return;
-    }
-
-    if (TCG_TARGET_extract_valid(TCG_TYPE_I32, ofs, len)) {
-        tcg_gen_op4ii_i32(INDEX_op_extract, ret, arg, ofs, len);
-        return;
-    }
-
-    mask = (1u << len) - 1;
-    if (ofs == 0) {
-        tcg_gen_andi_i32(ret, arg, mask);
-        return;
-    }
-
-    /* Assume that zero-extension, if available, is cheaper than a shift.  */
-    if (TCG_TARGET_extract_valid(TCG_TYPE_I32, 0, ofs + len)) {
-        tcg_gen_op4ii_i32(INDEX_op_extract, ret, arg, 0, ofs + len);
-        tcg_gen_shri_i32(ret, ret, ofs);
-        return;
-    }
-
-    if (tcg_op_imm_match(INDEX_op_and, TCG_TYPE_I32, mask)) {
-        tcg_gen_shri_i32(ret, arg, ofs);
-        tcg_gen_andi_i32(ret, ret, mask);
-    } else {
-        tcg_gen_shli_i32(ret, arg, 32 - len - ofs);
-        tcg_gen_shri_i32(ret, ret, 32 - len);
-    }
-}
-
 void tcg_gen_sextract_i32(TCGv_i32 ret, TCGv_i32 arg,
                           unsigned int ofs, unsigned int len)
 {
@@ -1709,49 +1711,6 @@ void tcg_gen_deposit_z_i64(TCGv_i64 ret, TCGv_i64 arg,
     }
 }
 
-void tcg_gen_extract_i64(TCGv_i64 ret, TCGv_i64 arg,
-                         unsigned int ofs, unsigned int len)
-{
-    uint64_t mask;
-
-    tcg_debug_assert(ofs < 64);
-    tcg_debug_assert(len > 0);
-    tcg_debug_assert(len <= 64);
-    tcg_debug_assert(ofs + len <= 64);
-
-    /* Canonicalize certain special cases, even if extract is supported.  */
-    if (ofs + len == 64) {
-        tcg_gen_shri_i64(ret, arg, 64 - len);
-        return;
-    }
-
-    if (TCG_TARGET_extract_valid(TCG_TYPE_I64, ofs, len)) {
-        tcg_gen_op4ii_i64(INDEX_op_extract, ret, arg, ofs, len);
-        return;
-    }
-
-    mask = (1ull << len) - 1;
-    if (ofs == 0) {
-        tcg_gen_andi_i64(ret, arg, mask);
-        return;
-    }
-
-    /* Assume that zero-extension, if available, is cheaper than a shift.  */
-    if (TCG_TARGET_extract_valid(TCG_TYPE_I64, 0, ofs + len)) {
-        tcg_gen_op4ii_i64(INDEX_op_extract, ret, arg, 0, ofs + len);
-        tcg_gen_shri_i64(ret, ret, ofs);
-        return;
-    }
-
-    if (tcg_op_imm_match(INDEX_op_and, TCG_TYPE_I64, mask)) {
-        tcg_gen_shri_i64(ret, arg, ofs);
-        tcg_gen_andi_i64(ret, ret, mask);
-    } else {
-        tcg_gen_shli_i64(ret, arg, 64 - len - ofs);
-        tcg_gen_shri_i64(ret, ret, 64 - len);
-    }
-}
-
 void tcg_gen_sextract_i64(TCGv_i64 ret, TCGv_i64 arg,
                           unsigned int ofs, unsigned int len)
 {
-- 
2.53.0


