Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03592C369C3
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 19:42:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4m39-0005yz-NY; Tue, 15 Apr 2025 15:34:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4lzB-0007wj-Pq
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:30:22 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4ly5-0000nV-Lw
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:30:20 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-3085a41b1f9so792457a91.1
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745348; x=1745350148; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MsRbT8q2vGvbZSmPZB2g9AELNkUgtZB9YL8IhEg4Hx4=;
 b=VTfSRbOpYq5dOc0wrenIpqibsouhAHceewtFiE800AKV+YF2VwGb9P4+cuJ6c0WBsr
 JyLG2wVLCOWIG9SzhPTg04EYjL0hn4nYfZMOTCxVZxTMvLLv9g2LyJC+UI9yOclnJjif
 y+R6akTvHYNACYIbu5RNyG/QgKXc7vM+G1vGWn/LH3lfSBqJlJkGtN8QbOLFygcY7CHh
 VAwaUjV7AV9A927D9s4lhpvU2JvRbg0ge48pBTWhk2cHBt5qG31EPcRLFI5lXQEOObzh
 7QeSJRhbiOR/p020d1SlIL1HlEUP05S5T9HOvfztiSknqkjWx56tpB+vXVCyaIn7yiyw
 T4lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745348; x=1745350148;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MsRbT8q2vGvbZSmPZB2g9AELNkUgtZB9YL8IhEg4Hx4=;
 b=jgl945LezcRDeIMrQ3ILjLrEe1oVrR3qTlwKZt639n0ycF7qNnk1a6bE9WTD+FJBJ8
 MnETK/OnXSTa7Q2X7lUAMyIpb/EBvPOo8Y3V/WKK9hwdSlMT3pXG+vxKTDMUFveTz4JL
 pI9YXoZ3P100VlQTBjsUPKDQ0iD8CxZb47AksHJ2o+Yjypf2CUDIFSJcFbagFSbiiFw4
 IJZGndMxw/xubUjhZHUECTJEy1AGKb0KQj+luWe2HmkPrj1EfKY+0wN8QjMKk1WGYnrr
 KeveqR9VaN08Ot0Cd7TBf6T257Ybc2fWYbVZdIcZ3kJF9m6wmKvfsjPV7m3Em5pNYFCy
 bZew==
X-Gm-Message-State: AOJu0YyykUANF72dCfNNiBEHfRldx4p7+ldUSaCJ6MllGleHlbzFNjEH
 5ttX9HDO8MvalJbdwxqVceapp4g/sH/yWpECXqvq3GApPkp+LE56alaI7diBa/0QoZJH8YSGE8A
 z
X-Gm-Gg: ASbGncuiMEKjKP1G8/7pYN94bLdvDVcSEp8x+S3tporpaUC/IVHcunbW4zEXQn8SDJW
 cCy+78ecd3R1dQ1npe1aDlBfWTrNTOWKDKMqLh4QlPowk4r2yY+8eK+tvg7sfkZHBt0BATtAtGi
 4bacVQMXhqDAXJEF7Uata+8Fa0SyBYWHreyVYDW3kxDo8XpdJvegf5taoVN4GGIHjilzQWXDdyy
 mTiKrg95XG3JBz1sVmn+ztnOx6z+sWX571i1hmX0QDASX+aTm2/PMmmTbsgkg0MY0gUre+66tXX
 DeUs9arUZg4liGp/i+NmWBqmY4HJ1Cl04Tx0Sl8HCX1GASGscpBpdoRvi/bspcZEyvck3GixcoX
 KVNx4/b/uVA==
X-Google-Smtp-Source: AGHT+IEks0oA/5i+9CSnkVqseH56FtQ6tPqBHLxMjj8F3TdpxdVpHRKLatW8Im6JA6ulY5U6fU+o8g==
X-Received: by 2002:a17:90b:544f:b0:2f9:d9fe:e72e with SMTP id
 98e67ed59e1d1-3085ef366c5mr624616a91.16.1744745347850; 
 Tue, 15 Apr 2025 12:29:07 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-306df06a165sm13534812a91.4.2025.04.15.12.29.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:29:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 059/163] tcg: Do not require both rotr and rotl from the
 backend
Date: Tue, 15 Apr 2025 12:23:30 -0700
Message-ID: <20250415192515.232910-60-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Many host architectures do not implement both rotate right
and rotate left and require the compiler to negate the
shift count to rotate the opposite direction.  We have been
requiring the backend to perform this transformation.
Do this during opcode expansion so that the next patch
can drop support where possible in the backend.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op.c | 98 +++++++++++++++++++++++++++++-----------------------
 1 file changed, 54 insertions(+), 44 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 43848ebc4f..8c8b9d179b 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -829,15 +829,18 @@ void tcg_gen_ctpop_i32(TCGv_i32 ret, TCGv_i32 arg1)
 
 void tcg_gen_rotl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    if (TCG_TARGET_HAS_rot_i32) {
+    if (tcg_op_supported(INDEX_op_rotl_i32, TCG_TYPE_I32, 0)) {
         tcg_gen_op3_i32(INDEX_op_rotl_i32, ret, arg1, arg2);
+    } else if (tcg_op_supported(INDEX_op_rotr_i32, TCG_TYPE_I32, 0)) {
+        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
+        tcg_gen_neg_i32(t0, arg2);
+        tcg_gen_op3_i32(INDEX_op_rotr_i32, ret, arg1, t0);
+        tcg_temp_free_i32(t0);
     } else {
-        TCGv_i32 t0, t1;
-
-        t0 = tcg_temp_ebb_new_i32();
-        t1 = tcg_temp_ebb_new_i32();
+        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
+        TCGv_i32 t1 = tcg_temp_ebb_new_i32();
         tcg_gen_shl_i32(t0, arg1, arg2);
-        tcg_gen_subfi_i32(t1, 32, arg2);
+        tcg_gen_neg_i32(t1, arg2);
         tcg_gen_shr_i32(t1, arg1, t1);
         tcg_gen_or_i32(ret, t0, t1);
         tcg_temp_free_i32(t0);
@@ -851,12 +854,15 @@ void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
     /* some cases can be optimized here */
     if (arg2 == 0) {
         tcg_gen_mov_i32(ret, arg1);
-    } else if (TCG_TARGET_HAS_rot_i32) {
-        tcg_gen_rotl_i32(ret, arg1, tcg_constant_i32(arg2));
+    } else if (tcg_op_supported(INDEX_op_rotl_i32, TCG_TYPE_I32, 0)) {
+        TCGv_i32 t0 = tcg_constant_i32(arg2);
+        tcg_gen_op3_i32(INDEX_op_rotl_i32, ret, arg1, t0);
+    } else if (tcg_op_supported(INDEX_op_rotr_i32, TCG_TYPE_I32, 0)) {
+        TCGv_i32 t0 = tcg_constant_i32(32 - arg2);
+        tcg_gen_op3_i32(INDEX_op_rotr_i32, ret, arg1, t0);
     } else {
-        TCGv_i32 t0, t1;
-        t0 = tcg_temp_ebb_new_i32();
-        t1 = tcg_temp_ebb_new_i32();
+        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
+        TCGv_i32 t1 = tcg_temp_ebb_new_i32();
         tcg_gen_shli_i32(t0, arg1, arg2);
         tcg_gen_shri_i32(t1, arg1, 32 - arg2);
         tcg_gen_or_i32(ret, t0, t1);
@@ -867,15 +873,18 @@ void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 
 void tcg_gen_rotr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    if (TCG_TARGET_HAS_rot_i32) {
+    if (tcg_op_supported(INDEX_op_rotr_i32, TCG_TYPE_I32, 0)) {
         tcg_gen_op3_i32(INDEX_op_rotr_i32, ret, arg1, arg2);
+    } else if (tcg_op_supported(INDEX_op_rotl_i32, TCG_TYPE_I32, 0)) {
+        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
+        tcg_gen_neg_i32(t0, arg2);
+        tcg_gen_op3_i32(INDEX_op_rotl_i32, ret, arg1, t0);
+        tcg_temp_free_i32(t0);
     } else {
-        TCGv_i32 t0, t1;
-
-        t0 = tcg_temp_ebb_new_i32();
-        t1 = tcg_temp_ebb_new_i32();
+        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
+        TCGv_i32 t1 = tcg_temp_ebb_new_i32();
         tcg_gen_shr_i32(t0, arg1, arg2);
-        tcg_gen_subfi_i32(t1, 32, arg2);
+        tcg_gen_neg_i32(t1, arg2);
         tcg_gen_shl_i32(t1, arg1, t1);
         tcg_gen_or_i32(ret, t0, t1);
         tcg_temp_free_i32(t0);
@@ -886,12 +895,7 @@ void tcg_gen_rotr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 void tcg_gen_rotri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 32);
-    /* some cases can be optimized here */
-    if (arg2 == 0) {
-        tcg_gen_mov_i32(ret, arg1);
-    } else {
-        tcg_gen_rotli_i32(ret, arg1, 32 - arg2);
-    }
+    tcg_gen_rotli_i32(ret, arg1, -arg2 & 31);
 }
 
 void tcg_gen_deposit_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2,
@@ -2437,14 +2441,18 @@ void tcg_gen_ctpop_i64(TCGv_i64 ret, TCGv_i64 arg1)
 
 void tcg_gen_rotl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
-    if (TCG_TARGET_HAS_rot_i64) {
+    if (tcg_op_supported(INDEX_op_rotl_i64, TCG_TYPE_I64, 0)) {
         tcg_gen_op3_i64(INDEX_op_rotl_i64, ret, arg1, arg2);
+    } else if (tcg_op_supported(INDEX_op_rotl_i64, TCG_TYPE_I64, 0)) {
+        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
+        tcg_gen_neg_i64(t0, arg2);
+        tcg_gen_op3_i64(INDEX_op_rotr_i64, ret, arg1, t0);
+        tcg_temp_free_i64(t0);
     } else {
-        TCGv_i64 t0, t1;
-        t0 = tcg_temp_ebb_new_i64();
-        t1 = tcg_temp_ebb_new_i64();
+        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
+        TCGv_i64 t1 = tcg_temp_ebb_new_i64();
         tcg_gen_shl_i64(t0, arg1, arg2);
-        tcg_gen_subfi_i64(t1, 64, arg2);
+        tcg_gen_neg_i64(t1, arg2);
         tcg_gen_shr_i64(t1, arg1, t1);
         tcg_gen_or_i64(ret, t0, t1);
         tcg_temp_free_i64(t0);
@@ -2458,12 +2466,15 @@ void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
     /* some cases can be optimized here */
     if (arg2 == 0) {
         tcg_gen_mov_i64(ret, arg1);
-    } else if (TCG_TARGET_HAS_rot_i64) {
-        tcg_gen_rotl_i64(ret, arg1, tcg_constant_i64(arg2));
+    } else if (tcg_op_supported(INDEX_op_rotl_i64, TCG_TYPE_I64, 0)) {
+        TCGv_i64 t0 = tcg_constant_i64(arg2);
+        tcg_gen_op3_i64(INDEX_op_rotl_i64, ret, arg1, t0);
+    } else if (tcg_op_supported(INDEX_op_rotr_i64, TCG_TYPE_I64, 0)) {
+        TCGv_i64 t0 = tcg_constant_i64(64 - arg2);
+        tcg_gen_op3_i64(INDEX_op_rotr_i64, ret, arg1, t0);
     } else {
-        TCGv_i64 t0, t1;
-        t0 = tcg_temp_ebb_new_i64();
-        t1 = tcg_temp_ebb_new_i64();
+        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
+        TCGv_i64 t1 = tcg_temp_ebb_new_i64();
         tcg_gen_shli_i64(t0, arg1, arg2);
         tcg_gen_shri_i64(t1, arg1, 64 - arg2);
         tcg_gen_or_i64(ret, t0, t1);
@@ -2474,14 +2485,18 @@ void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 
 void tcg_gen_rotr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
-    if (TCG_TARGET_HAS_rot_i64) {
+    if (tcg_op_supported(INDEX_op_rotr_i64, TCG_TYPE_I64, 0)) {
         tcg_gen_op3_i64(INDEX_op_rotr_i64, ret, arg1, arg2);
+    } else if (tcg_op_supported(INDEX_op_rotl_i64, TCG_TYPE_I64, 0)) {
+        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
+        tcg_gen_neg_i64(t0, arg2);
+        tcg_gen_op3_i64(INDEX_op_rotl_i64, ret, arg1, t0);
+        tcg_temp_free_i64(t0);
     } else {
-        TCGv_i64 t0, t1;
-        t0 = tcg_temp_ebb_new_i64();
-        t1 = tcg_temp_ebb_new_i64();
+        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
+        TCGv_i64 t1 = tcg_temp_ebb_new_i64();
         tcg_gen_shr_i64(t0, arg1, arg2);
-        tcg_gen_subfi_i64(t1, 64, arg2);
+        tcg_gen_neg_i64(t1, arg2);
         tcg_gen_shl_i64(t1, arg1, t1);
         tcg_gen_or_i64(ret, t0, t1);
         tcg_temp_free_i64(t0);
@@ -2492,12 +2507,7 @@ void tcg_gen_rotr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 void tcg_gen_rotri_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 64);
-    /* some cases can be optimized here */
-    if (arg2 == 0) {
-        tcg_gen_mov_i64(ret, arg1);
-    } else {
-        tcg_gen_rotli_i64(ret, arg1, 64 - arg2);
-    }
+    tcg_gen_rotli_i64(ret, arg1, -arg2 & 63);
 }
 
 void tcg_gen_deposit_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2,
-- 
2.43.0


