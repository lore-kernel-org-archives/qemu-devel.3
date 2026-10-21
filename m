Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF9560A261B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=vIdN7A4N
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXDu-00027q-Lj; Wed, 21 Oct 2026 10:23:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXD1-0001Bo-4u
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:22:28 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXCx-00027C-7x
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:22:26 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-48afcd7ba9bso564314f8f.3
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592541; x=1793197341; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XF1KG1WA666gnjUUgOcF+bX16n0V8kDQ/uPHMfreh+k=;
 b=vIdN7A4N5FMvtjzKFy/xWT2uWYNGLLfpjRnFeBWQU5T5ogmjaXEtV8CPofJ0mACKAS
 IQKSeYMDUJkDQMuZUHZtMztFx6k4bEhm4mgiJGrbGdZ++nmZpojfIY95V87vuKiOxXiY
 ECw8WhS652ABWYapuQcMh2ZWWn3571pidW8qhxi6rZYKY9EorqNrRi4g3NwQm/+EIrNm
 WjQtD9GZ5SdEC6R8dzhEbOw+QNXLxwZwnWHTxAyJ01vJ+hGJLcOy8VrmLjAkPBgKx98S
 e3WHpjAYFDa9XzYGbVOpdbgGbQMDdguR8JVB8NYis4Z5WM0MeJqjcZEN4aGPIrK+9NzM
 p+tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592541; x=1793197341;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XF1KG1WA666gnjUUgOcF+bX16n0V8kDQ/uPHMfreh+k=;
 b=k1Gq1Jqj9J7cgI0VinI5Op/4O5WQXKQT9zBqbMJXEHRSLSmVrXzrOiceyB83g1xzgg
 wvBjqKAvdVGfcUnBlP5MJXjAo2EqMUWkkucI8lPb5au9VSipFaO52wfJ1++Lg4wZyU9W
 Ot2VJk0wVfIuPqGZ/RuSt7PRy3esMewX28hQMIg21XYVGUx3rlrZ03aYujA0ytNjWxD1
 Xr6+iMfLN9qqrDgNHdzqFaiVdB7tIdQdZ5VbK8bCYw/BICzU2wvJDJ/srl6aKuvkxYfY
 MKv8+QRiUuqFQTuz41i/qVXNNQk+jq1OZ+0nmjl7dXRGY9mK1kqD8hV9ssMy5iN7YZbU
 +lqQ==
X-Gm-Message-State: AFq9FYJG6bkKZA8kVyH/aJjp3bUxMgnPX+21XtqQ4Bl8lTEGd/ZAPIka
 I7UFNEtPwKKyHpqrfeqA8LN0Gs8dPJMUL1zVKnUKs3KWHbNRGGSvY6H7JXxkYZXmrTaoI2fq4uu
 rpbTKSDw=
X-Gm-Gg: AYBFou1w+YL3yx4PtsVuOFhNt/bcEiU6U5YXktV2F/PBG42AaXWOnZFLSGXyFlHNaBj
 oLUOYj1ktvam0E1LPWyAjfSUzOI/gD/fsK7CSnZhfiKqCW5AEGRnhP2PYzh8if7AXlhn0x7yVpn
 a/Qeep/UWO84KV3CwzFiZsLHlr9CZ0TqXdIfJLfOnKBquqA+FMqQ0ong2TM2blA6xng0lbIOP8d
 97MFfA5C3HDqWJYOrfERh9jv3bWNM84l7njeVKZ5ebRU2UBTG40/uOsRUv+O75adwvLLiTcW1kg
 ArMDAvAr2i6becoskBFiGcKyCBxFKG2spQOB0h3yxT6xfaLDZnKC6FznEiF72bugaBMBkBfPZfs
 94JRLn/42YUHb11i3aHQGjsvkz/FeW4fcNbm5F5cloMwpYLpcyYoYkecm4GFQLAk+29fATCdDQY
 fA/1lp0+VV7foFCV1RYulrhkq3bPVYnITcIOm6mUDT4c15waAxM/aJXQaRgKcT9afqh+gGHCPY9
 uXVNwKvXbvjhEsbku+KFK/Pu/9jgWw3cW/v0IoW8MTM8IaOSXenDNkTubCEXU8rJXIYB6xq/IER
 XPgWFXubYOku8VFM86tPVK6SQVk=
X-Received: by 2002:a05:6000:1621:b0:488:6ed9:b11d with SMTP id
 ffacd0b85a97d-48e264e64b2mr2943240f8f.52.1792592541212; 
 Wed, 21 Oct 2026 07:22:21 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25828e72sm5393603f8f.26.2026.10.21.07.22.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:22:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 043/100] tcg: Generic expansion of tcg_gen_setcond_*
Date: Wed, 21 Oct 2026 16:15:55 +0200
Message-ID: <20261021141652.363109-44-richard.henderson@linaro.org>
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  4 ----
 tcg/tcg-internal.h           |  6 ++++++
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 36 ++++++++++++------------------------
 4 files changed, 19 insertions(+), 28 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index cad36f76eb..117d66ef59 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -146,8 +146,6 @@ void tcg_gen_sextract_i32(TCGv_i32 ret, TCGv_i32 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i32(TCGv_i32 ret, TCGv_i32 al, TCGv_i32 ah,
                           unsigned int ofs);
-void tcg_gen_setcond_i32(TCGCond cond, TCGv_i32 ret,
-                         TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_setcondi_i32(TCGCond cond, TCGv_i32 ret,
                           TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_negsetcond_i32(TCGCond cond, TCGv_i32 ret,
@@ -217,8 +215,6 @@ void tcg_gen_sextract_i64(TCGv_i64 ret, TCGv_i64 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah,
                           unsigned int ofs);
-void tcg_gen_setcond_i64(TCGCond cond, TCGv_i64 ret,
-                         TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_setcondi_i64(TCGCond cond, TCGv_i64 ret,
                           TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_negsetcond_i64(TCGCond cond, TCGv_i64 ret,
diff --git a/tcg/tcg-internal.h b/tcg/tcg-internal.h
index cd481dfd27..0de8516447 100644
--- a/tcg/tcg-internal.h
+++ b/tcg/tcg-internal.h
@@ -120,6 +120,12 @@ static inline TCGOp *tcg_gen_op_ttii(TCGOpcode opc, TCGType type, TCGTemp *t0,
     return tcg_gen_op4(opc, type, temp_arg(t0), temp_arg(t1), a2, a3);
 }
 
+static inline void tcg_gen_op_ttti(TCGOpcode opc, TCGType type, TCGTemp *t0,
+                                   TCGTemp *t1, TCGTemp *t2, TCGArg a3)
+{
+    tcg_gen_op4(opc, type, temp_arg(t0), temp_arg(t1), temp_arg(t2), a3);
+}
+
 static inline void tcg_gen_op_ttttt(TCGOpcode opc, TCGType type,
                                     TCGTemp *t0, TCGTemp *t1, TCGTemp *t2,
                                     TCGTemp *t3, TCGTemp *t4)
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index a863215ffe..4934f117bb 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -27,6 +27,7 @@ DEF3(rem, TCGV, TCGV, TCGV)
 DEF3(remu, TCGV, TCGV, TCGV)
 DEF3(sar, TCGV, TCGV, TCGV)
 DEF3(sari, TCGV, TCGV, TINT)
+DEF4(setcond, TCGCond, TCGV, TCGV, TCGV)
 DEF3(shl, TCGV, TCGV, TCGV)
 DEF3(shli, TCGV, TCGV, TINT)
 DEF3(shr, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 1039104ca6..a45244e64c 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -621,6 +621,18 @@ void tcg_gen_sari(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     }
 }
 
+void tcg_gen_setcond(TCGType type, TCGCond cond, TCGTemp *dst,
+                     TCGTemp *src1, TCGTemp *src2)
+{
+    if (cond == TCG_COND_ALWAYS) {
+        tcg_gen_movi(type, dst, 1);
+    } else if (cond == TCG_COND_NEVER) {
+        tcg_gen_movi(type, dst, 0);
+    } else {
+        tcg_gen_op_ttti(INDEX_op_setcond, type, dst, src1, src2, cond);
+    }
+}
+
 void tcg_gen_shl(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     tcg_gen_op_ttt(INDEX_op_shl, type, dst, src1, src2);
@@ -689,18 +701,6 @@ void tcg_gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_setcond_i32(TCGCond cond, TCGv_i32 ret,
-                         TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (cond == TCG_COND_ALWAYS) {
-        tcg_gen_movi_i32(ret, 1);
-    } else if (cond == TCG_COND_NEVER) {
-        tcg_gen_movi_i32(ret, 0);
-    } else {
-        tcg_gen_op4i_i32(INDEX_op_setcond, ret, arg1, arg2, cond);
-    }
-}
-
 void tcg_gen_setcondi_i32(TCGCond cond, TCGv_i32 ret,
                           TCGv_i32 arg1, int32_t arg2)
 {
@@ -1479,18 +1479,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_setcond_i64(TCGCond cond, TCGv_i64 ret,
-                         TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (cond == TCG_COND_ALWAYS) {
-        tcg_gen_movi_i64(ret, 1);
-    } else if (cond == TCG_COND_NEVER) {
-        tcg_gen_movi_i64(ret, 0);
-    } else {
-        tcg_gen_op4i_i64(INDEX_op_setcond, ret, arg1, arg2, cond);
-    }
-}
-
 void tcg_gen_setcondi_i64(TCGCond cond, TCGv_i64 ret,
                           TCGv_i64 arg1, int64_t arg2)
 {
-- 
2.53.0


