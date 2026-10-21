Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0277060A262D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=XulylS95
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXAF-0005v6-MN; Wed, 21 Oct 2026 10:19:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJX9A-0004lB-NJ
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:18:34 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJX97-0001aQ-OK
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:18:28 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a1dfd49525so6334205e9.0
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592302; x=1793197102; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RMW1HonEUUecj+LVyU+nJX9D5lBJEJFb/y2V5o3ZDN4=;
 b=XulylS956aSuhFp0v+k4wS9SX+P5xIcGdkOI0QBgLEPd1AIxmAB++JVs5tZtPYBFRe
 Xm7oW66kw00+IQ5aJomAMRTGjlegvIqej3VsR5uwuJrVSrwhcV2RZC63XCMn2Bv8y5dK
 8rHgfwOvAIynG+6lyBuTtVWiwf//k6y4tTusjg9WfzAf/UU1r505rA1ek0akGD8BKm+C
 yvDYRsffsXKb4rwDqgADj7QGVxj57av7Z5Kh0wtqJPRC1ZPm76E1bTU0XoXrUhRAw9XZ
 Uhug4PhmgEWmsSco33acOULEZnIj3swymBRgRm9I45tBTz9fv8ncM+bBURF/fh4cWuLu
 mUvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592302; x=1793197102;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RMW1HonEUUecj+LVyU+nJX9D5lBJEJFb/y2V5o3ZDN4=;
 b=J1lIEfzUaGPT48vu8W7x+05x55JxxNzAmodsi8T39aOOhjOgUlxgdGlT5Xz/2NpDra
 5DSz/NMobw6gu3174mFw588uRnIAZQDV5nD+C4vQo2lKsxw29l8XE1tj5jKSFLbB1DcG
 /X8+B10GQ6Ql3y9r+X2nW++Pv5y7csz0+CVVmM23uTzaUqdacsRXtO85rq0fxEfDhIsO
 izURZc7/8a393vSk+ntrWN+R6QMvrQLnP8CBAz6diBehLMVS0Xea1YSUsM45u2fugD3X
 mheUzQ3n0zt2neHVew0VXRkYxu9It/W74dK9YBUKI4WqzgK0WNuuj/kz4UDDB8+kdZj4
 W3FQ==
X-Gm-Message-State: AFq9FYIbjW6Ri7PmMaGQA2XnUVRZ3ptl5sr+/8U4eozyW01ImPQRHjcx
 jUoFhOZBiasBnSTUH70kt9rbh4c6dzPDZgQkfy3vXR4pQXuK0rjAleVR4B9bbLvFTxX5qFgywUM
 gFSyrDFQ=
X-Gm-Gg: AYBFou1tjP/L7Jb6ds1INUtVSt7YlG+0kET+DK8quLdFkANeNhak7b+G8sjgsXm64A9
 jTODanItqc+GGlw+ASQUaKFVGaRH+JpVxC8UWyDUFpTZSBJlxQgOhGOVt9AXL7WvH//kdAMV/+1
 3F7b9+9QD3YEmt28oC5FE9+XmvaLU7NCLFAl3z13tFybePEnRL3gsPReLBQ5/vrdGBkavROFq5R
 JXs/apW8MQQgv6do3g8lPiq1Wjk0G9YF1WvEu195InTSJ3VOnSbDtSqpRoHsIQTYr+ZEm95KBpv
 M7TV+xD72PpGs5ZY5T10IL7qJEnFLNd+IqHVrfo9yJLy9RDznu5raxpRCbt0qSr2/iSnd7DyWqB
 YK//VO1bWntXSVbSDWDXKTQX2z83lGdXVkEhRhzwphZna/gotFh2A0eMahXzPXwfKjJAAhoiQvW
 EMIVGvGN0MjWSQ0Z1vMkw+Z4t9NArzophvUBLzAxgBJWi19M7J2OG3YcjWsye8SNpbMKIzof5fA
 UzAZ44aFkLxQK9p/+b0lPerXdnV1BpMqHQs8kd5XKMWSZbcfXyxB1HtMFCdgbHtgtHa6hRSzBCL
 WZTu4luqHQuZsQgR9cplLpUiD4Y=
X-Received: by 2002:a05:600c:b86:b0:4a1:90d7:88a8 with SMTP id
 5b1f17b1804b1-4a1fdd32c79mr48239785e9.25.1792592301990; 
 Wed, 21 Oct 2026 07:18:21 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2c242dcsm147113845e9.0.2026.10.21.07.18.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:18:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 024/100] tcg: Generic expansion of tcg_gen_shri_*
Date: Wed, 21 Oct 2026 16:15:36 +0200
Message-ID: <20261021141652.363109-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32a.google.com
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
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 30 ++++++++++--------------------
 3 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index dec1bb522c..e0a93144cb 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -126,7 +126,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
-void tcg_gen_shri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_sari_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_muli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_div_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -216,7 +215,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_ori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
-void tcg_gen_shri_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_sari_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_muli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_div_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index c47de1a3a4..ea641158ae 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -14,6 +14,7 @@ DEF3(sar, TCGV, TCGV, TCGV)
 DEF3(shl, TCGV, TCGV, TCGV)
 DEF3(shli, TCGV, TCGV, TINT)
 DEF3(shr, TCGV, TCGV, TCGV)
+DEF3(shri, TCGV, TCGV, TINT)
 DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
 DEF3(subfi, TCGV, TINT, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 8fcbbef694..b3f688228d 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -439,6 +439,16 @@ void tcg_gen_shr(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     tcg_gen_op_ttt(INDEX_op_shr, type, dst, src1, src2);
 }
 
+void tcg_gen_shri(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
+{
+    tcg_debug_assert(src2 >= 0 && src2 < tcg_type_bits(type));
+    if (src2 == 0) {
+        tcg_gen_mov(type, dst, src1);
+    } else {
+        tcg_gen_shr(type, dst, src1, tcg_constant_internal(type, src2));
+    }
+}
+
 void tcg_gen_sub(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     tcg_gen_op_ttt(INDEX_op_sub, type, dst, src1, src2);
@@ -530,16 +540,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg)
     }
 }
 
-void tcg_gen_shri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
-{
-    tcg_debug_assert(arg2 >= 0 && arg2 < 32);
-    if (arg2 == 0) {
-        tcg_gen_mov_i32(ret, arg1);
-    } else {
-        tcg_gen_shr_i32(ret, arg1, tcg_constant_i32(arg2));
-    }
-}
-
 void tcg_gen_sari_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 32);
@@ -1549,16 +1549,6 @@ void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
     }
 }
 
-void tcg_gen_shri_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
-{
-    tcg_debug_assert(arg2 >= 0 && arg2 < 64);
-    if (arg2 == 0) {
-        tcg_gen_mov_i64(ret, arg1);
-    } else {
-        tcg_gen_shr_i64(ret, arg1, tcg_constant_i64(arg2));
-    }
-}
-
 void tcg_gen_sari_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 64);
-- 
2.53.0


