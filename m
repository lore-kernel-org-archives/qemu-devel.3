Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00836E8B39C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 05:26:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnVOA-0000aw-D1; Wed, 04 Feb 2026 00:25:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnVO5-0000WM-Vw
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 00:25:15 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnVO3-0003Hb-NJ
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 00:25:13 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2a7bceb6cd0so44539695ad.1
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 21:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770182710; x=1770787510; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dVPzdCnFdmlrffK3fWEylRJxEnVHNoCcDL2ufRITdLk=;
 b=mAGwcJVV3AZyBnUopcmnMWZgHWWOVsDfim1V0/hGmM56h6RSpd1KeatcGa2le4uPKr
 heLYme1cxbj3I+XR8ZcX++ZwSnF15qCSUGeabMt6tp4ChHitVW/RqzEubVM0n3AXgRzA
 Q+3iPapHbbG+qlT7Vo5XJpgSjKkiPE9bVUQpFmxvuh6sk3ao07ACtTeEMjuFJPlkhMwM
 EAVWT6lMgAjQOGCgtfIS/tAcN2T7g5e541Ch0mKY+XGV1DHLBMYXcsO6LijyQvoynO6F
 VveuJthYVIpRQH2c8i0GaP09xUS94uiARpXiY+X6wv1a34nFOGBNRCUopK4uHGc+kJPc
 Ov4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770182710; x=1770787510;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dVPzdCnFdmlrffK3fWEylRJxEnVHNoCcDL2ufRITdLk=;
 b=TEQFgpgAoTKr3t3QQxFWFM6ZVdFtCQmK81zidI52P3eyqcvbrYw5VmGDqh22esbDY+
 H6PFyiq63XmrH34/nFqSf2LxJMCGk2P9V/GaykOfD4bRjbYdiXdGkxJQbbfnVFlzrQuK
 YNSaCT4XT7XrcbeICreIz0J3H7EdxqBYhcwQIKE8KGXoPHE54rLVIqDU8xyUkB9hPNgK
 8mln3AxC4FOnvuaRAyowNpGLPK9cC3CK64j2o5r5yPfC6VreOPQZ2B/J1amEzRE3tWYJ
 QJEEoEXxYjf8zwFXRD6eBZhIob+c2vVGfjAdr06onYPACxZ4uKOHjsluHxOxs+uNUSQB
 6yEg==
X-Gm-Message-State: AOJu0YyzVOrdOhFLM0VfPOlHz53ElIqdIQKZpp5JMceFFpq0cJ8UUy15
 6OtQPqHABX/HYiKF1vraeVMD0qGnoZuY+TordM4v84uWh881tD40dtfGXafjb1FEr+8TbNIvuVH
 nqZXkgAo=
X-Gm-Gg: AZuq6aJX3tgUG2Eenv5M6D3xXBu209kWOzDFoeyQYqH8ZKjNnKXfpdcE3SsMXMR57+R
 fqEQG7pQg7hl4IfVh/HlF+Wv0grfCOmTcJfiA9jHo+NrLuoWJor5q+e+3KaOZe5mTipkMmAEeL/
 lSQ7cFi1+dvaJy6r/G657SUqvamxYCTNQ6Hm88+fI31YgBYRCwrCMoeGBlfFsfLGpvBCrj40sx0
 MdZvpK9lO559ueyXRN+7+jOOVI+tOvWj5jZagHlhOjUe1y7cdCeUC/l0ThtctnLeWnl19zgy0pZ
 hxUKhbQZRcUnkw4ExMSUYP12a990mq4riq/b+8yTkCw2ii3OsMTsfO06vn/vhM9IRjbyVSQkr5/
 axFT0DmtqJGLbedvKMzobyDWIFCo7uaVCdbvojKPJEWZE6HfChDbS2+chy5JMz2JHQOeo3bE3QJ
 M+eKNjzORwpVSeCIfMjYHpeqCt+Cqzj7lBN6MUtUuyJ59CXb1IXeN7Chxzl6omCx52nZyIag==
X-Received: by 2002:a17:902:d4d2:b0:2a9:328a:d6a with SMTP id
 d9443c01a7336-2a934124589mr18071295ad.59.1770182710202; 
 Tue, 03 Feb 2026 21:25:10 -0800 (PST)
Received: from stoup.. (bg30dhzlx7lnyrq74wrz.ip6.superloop.au.
 [2401:d002:dc0f:2100:1bc:fe1e:491:928e])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a933965c3esm10062015ad.67.2026.02.03.21.25.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 21:25:09 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH v2 3/6] tcg: Expand missing rotri with extract2
Date: Wed,  4 Feb 2026 15:24:53 +1000
Message-ID: <20260204052456.970605-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260204052456.970605-1-richard.henderson@linaro.org>
References: <20260204052456.970605-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

Use extract2 to implement rotri.  To make this easier,
redefine rotli in terms of rotri, rather than the reverse.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op.c | 52 ++++++++++++++++++++++++----------------------------
 1 file changed, 24 insertions(+), 28 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 8a4fd14ad5..078adce610 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -826,23 +826,12 @@ void tcg_gen_rotl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 32);
-    /* some cases can be optimized here */
     if (arg2 == 0) {
         tcg_gen_mov_i32(ret, arg1);
     } else if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I32, 0)) {
-        TCGv_i32 t0 = tcg_constant_i32(arg2);
-        tcg_gen_op3_i32(INDEX_op_rotl, ret, arg1, t0);
-    } else if (tcg_op_supported(INDEX_op_rotr, TCG_TYPE_I32, 0)) {
-        TCGv_i32 t0 = tcg_constant_i32(32 - arg2);
-        tcg_gen_op3_i32(INDEX_op_rotr, ret, arg1, t0);
+        tcg_gen_op3_i32(INDEX_op_rotl, ret, arg1, tcg_constant_i32(arg2));
     } else {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        TCGv_i32 t1 = tcg_temp_ebb_new_i32();
-        tcg_gen_shli_i32(t0, arg1, arg2);
-        tcg_gen_shri_i32(t1, arg1, 32 - arg2);
-        tcg_gen_or_i32(ret, t0, t1);
-        tcg_temp_free_i32(t0);
-        tcg_temp_free_i32(t1);
+        tcg_gen_rotri_i32(ret, arg1, -arg2 & 31);
     }
 }
 
@@ -870,7 +859,16 @@ void tcg_gen_rotr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 void tcg_gen_rotri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 32);
-    tcg_gen_rotli_i32(ret, arg1, -arg2 & 31);
+    if (arg2 == 0) {
+        tcg_gen_mov_i32(ret, arg1);
+    } else if (tcg_op_supported(INDEX_op_rotr, TCG_TYPE_I32, 0)) {
+        tcg_gen_op3_i32(INDEX_op_rotr, ret, arg1, tcg_constant_i32(arg2));
+    } else if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I32, 0)) {
+        tcg_gen_op3_i32(INDEX_op_rotl, ret, arg1, tcg_constant_i32(32 - arg2));
+    } else {
+        /* Do not recurse with the rotri simplification. */
+        tcg_gen_op4i_i32(INDEX_op_extract2, ret, arg1, arg1, arg2);
+    }
 }
 
 void tcg_gen_deposit_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2,
@@ -2042,23 +2040,12 @@ void tcg_gen_rotl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 64);
-    /* some cases can be optimized here */
     if (arg2 == 0) {
         tcg_gen_mov_i64(ret, arg1);
     } else if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t0 = tcg_constant_i64(arg2);
-        tcg_gen_op3_i64(INDEX_op_rotl, ret, arg1, t0);
-    } else if (tcg_op_supported(INDEX_op_rotr, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t0 = tcg_constant_i64(64 - arg2);
-        tcg_gen_op3_i64(INDEX_op_rotr, ret, arg1, t0);
+        tcg_gen_op3_i64(INDEX_op_rotl, ret, arg1, tcg_constant_i64(arg2));
     } else {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        TCGv_i64 t1 = tcg_temp_ebb_new_i64();
-        tcg_gen_shli_i64(t0, arg1, arg2);
-        tcg_gen_shri_i64(t1, arg1, 64 - arg2);
-        tcg_gen_or_i64(ret, t0, t1);
-        tcg_temp_free_i64(t0);
-        tcg_temp_free_i64(t1);
+        tcg_gen_rotri_i64(ret, arg1, -arg2 & 63);
     }
 }
 
@@ -2086,7 +2073,16 @@ void tcg_gen_rotr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 void tcg_gen_rotri_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 64);
-    tcg_gen_rotli_i64(ret, arg1, -arg2 & 63);
+    if (arg2 == 0) {
+        tcg_gen_mov_i64(ret, arg1);
+    } else if (tcg_op_supported(INDEX_op_rotr, TCG_TYPE_I64, 0)) {
+        tcg_gen_op3_i64(INDEX_op_rotr, ret, arg1, tcg_constant_i64(arg2));
+    } else if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I64, 0)) {
+        tcg_gen_op3_i64(INDEX_op_rotl, ret, arg1, tcg_constant_i64(64 - arg2));
+    } else {
+        /* Do not recurse with the rotri simplification. */
+        tcg_gen_op4i_i64(INDEX_op_extract2, ret, arg1, arg1, arg2);
+    }
 }
 
 void tcg_gen_deposit_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2,
-- 
2.43.0


