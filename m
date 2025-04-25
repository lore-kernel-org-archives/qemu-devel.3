Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E11EC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:04:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8R5U-0005XG-Em; Fri, 25 Apr 2025 18:00:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R4C-0001C2-Sc
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:58:41 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R4A-0000p2-3O
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:58:40 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-b0b2d1f2845so2027842a12.3
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 14:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618316; x=1746223116; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kXWaP7yKjFhwxgifl5kxzmtRx81BRudhYZSSaYp8c78=;
 b=BKRBWrJNJda8tCMeYsihfqbTJTzKylo7aWbyy4ETgRrj7zKzJc3UDlZYJ3yjqrV9lb
 Gq34c2zQb44B/Oelpb+G5pHOYzEi30lcgjJyFVwdNQ3rodlMo5KEsBXHnb4vQkJZ9DsL
 FYhETDelQGALXiKeChROXEzRj/67QUmGx80bcEAqg1cYLlMKEEPpvhtkv0CiAPCYcK24
 J5vXsdqoQRfTWSV9O+Oyq156/WpOLmfIPjtnTyM1bBgmktvEe5RPGQ0/JX5sa3O1PLEw
 P2lLbkrHDGWtF00AQtxsKVTnwhZTzm+BaoxGqFBVXsrby1JzxzEnXC6TOPz+Ejz0+7GV
 0odg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618316; x=1746223116;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kXWaP7yKjFhwxgifl5kxzmtRx81BRudhYZSSaYp8c78=;
 b=B4A4uMet74AE9OA/2OaqESnB/9/W3r3/NnHJodpCohAot4H37xeQuhysVy9//YMZGy
 87ZVBZqdG1DOT8xhCfaND0K0zexzlJfPxfPJ9LzjxOKL8NN7WkpvF/ehNxQ63hJ6MKCd
 nqGnFeCFzJygu9MsHKz21lC1DuE7La53qOARhQT7OzRVlczb1ZXby8gRUHh7b3EyDp27
 GgDUXDmMEkfRiqW+w4PzzciVLtmmvNcTkjZYHXqGBY9mAC5AAGT3yYQPCPLEQbXoTIZc
 l0mzmfSFtjG+VhJAkLtCFfzXnO2EhKxkiU6lWqyyz0ptyLax8qjh3AL2TA9GV7nXG3RI
 Yt/g==
X-Gm-Message-State: AOJu0YzSE2gkhHIpjK7tIcg8i0ycd+iQQ+GlBEObyQJ7vSVDkpJCEv1f
 T6rlSKxa0LD9hPNss8Ulj2bbwnEvYPMPp2WeKNz7hbEyTUuVaFqiG901o6lCRopzyirT0qoseYU
 +
X-Gm-Gg: ASbGncv9hol4B1IkujOE6tnXzjS9vwjBcf0kdfIFZuVH4cXRfEWR6zIz5K9GlVXPMJh
 TRcQ/deUPoSSGKZsLWSaTSbDrspkZK+xp9eI20hg7aUvOhpm4wEyBB4Sk860/AT0+xLcRo1h9QD
 hPEHYeBDcr/vADbpWLQj8mhk2fIw3LclpHjwjPIHKDr8bjeVi29qRDPs0fHxFj08GEu3n5zL0X2
 Qnyyp/CYRAna1UHXHaX3LFXP1x0oqVTbKh+4dkz03tvk3OAimK9iFJQFOlR5izanDuQ77KyC86M
 cqiuE4V7JiTqFmxOaXukw5xLld0Lf4TUwXNxtPNDmxvlvdNV8DDPCnJm/FA4qvN2/0sv5IzM35w
 =
X-Google-Smtp-Source: AGHT+IESlPxhETrylcAp26HMaqiwDfPjmXQwJd0wTyo208d88YK21MDOhvmlXmJ1cn8EcLvw8x277A==
X-Received: by 2002:a17:903:2f90:b0:224:255b:c934 with SMTP id
 d9443c01a7336-22dbf74357cmr53843155ad.51.1745618316338; 
 Fri, 25 Apr 2025 14:58:36 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4d770d6sm37749595ad.17.2025.04.25.14.58.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 14:58:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 052/159] tcg: Merge INDEX_op_divu2_{i32,i64}
Date: Fri, 25 Apr 2025 14:53:06 -0700
Message-ID: <20250425215454.886111-53-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h  |  3 +--
 tcg/tcg-op.c           | 16 ++++++++--------
 tcg/tcg.c              |  6 ++----
 docs/devel/tcg-ops.rst | 10 ++++++++++
 4 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 36dfbf80ad..61e5e185cc 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -45,6 +45,7 @@ DEF(andc, 1, 2, 0, TCG_OPF_INT)
 DEF(divs, 1, 2, 0, TCG_OPF_INT)
 DEF(divs2, 2, 3, 0, TCG_OPF_INT)
 DEF(divu, 1, 2, 0, TCG_OPF_INT)
+DEF(divu2, 2, 3, 0, TCG_OPF_INT)
 DEF(eqv, 1, 2, 0, TCG_OPF_INT)
 DEF(mul, 1, 2, 0, TCG_OPF_INT)
 DEF(mulsh, 1, 2, 0, TCG_OPF_INT)
@@ -73,7 +74,6 @@ DEF(st_i32, 0, 2, 1, 0)
 /* arith */
 DEF(rem_i32, 1, 2, 0, 0)
 DEF(remu_i32, 1, 2, 0, 0)
-DEF(divu2_i32, 2, 3, 0, 0)
 /* shifts/rotates */
 DEF(shl_i32, 1, 2, 0, 0)
 DEF(shr_i32, 1, 2, 0, 0)
@@ -118,7 +118,6 @@ DEF(st_i64, 0, 2, 1, 0)
 /* arith */
 DEF(rem_i64, 1, 2, 0, 0)
 DEF(remu_i64, 1, 2, 0, 0)
-DEF(divu2_i64, 2, 3, 0, 0)
 /* shifts/rotates */
 DEF(shl_i64, 1, 2, 0, 0)
 DEF(shr_i64, 1, 2, 0, 0)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 5511106554..7ed92157de 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -637,10 +637,10 @@ void tcg_gen_divu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_divu, TCG_TYPE_I32, 0)) {
         tcg_gen_op3_i32(INDEX_op_divu, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_divu2_i32, TCG_TYPE_I32, 0)) {
+    } else if (tcg_op_supported(INDEX_op_divu2, TCG_TYPE_I32, 0)) {
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
         TCGv_i32 zero = tcg_constant_i32(0);
-        tcg_gen_op5_i32(INDEX_op_divu2_i32, ret, t0, arg1, zero, arg2);
+        tcg_gen_op5_i32(INDEX_op_divu2, ret, t0, arg1, zero, arg2);
         tcg_temp_free_i32(t0);
     } else {
         gen_helper_divu_i32(ret, arg1, arg2);
@@ -657,10 +657,10 @@ void tcg_gen_remu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
         tcg_gen_mul_i32(t0, t0, arg2);
         tcg_gen_sub_i32(ret, arg1, t0);
         tcg_temp_free_i32(t0);
-    } else if (tcg_op_supported(INDEX_op_divu2_i32, TCG_TYPE_I32, 0)) {
+    } else if (tcg_op_supported(INDEX_op_divu2, TCG_TYPE_I32, 0)) {
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
         TCGv_i32 zero = tcg_constant_i32(0);
-        tcg_gen_op5_i32(INDEX_op_divu2_i32, t0, ret, arg1, zero, arg2);
+        tcg_gen_op5_i32(INDEX_op_divu2, t0, ret, arg1, zero, arg2);
         tcg_temp_free_i32(t0);
     } else {
         gen_helper_remu_i32(ret, arg1, arg2);
@@ -2005,10 +2005,10 @@ void tcg_gen_divu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_divu, TCG_TYPE_I64, 0)) {
         tcg_gen_op3_i64(INDEX_op_divu, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_divu2_i64, TCG_TYPE_I64, 0)) {
+    } else if (tcg_op_supported(INDEX_op_divu2, TCG_TYPE_I64, 0)) {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
         TCGv_i64 zero = tcg_constant_i64(0);
-        tcg_gen_op5_i64(INDEX_op_divu2_i64, ret, t0, arg1, zero, arg2);
+        tcg_gen_op5_i64(INDEX_op_divu2, ret, t0, arg1, zero, arg2);
         tcg_temp_free_i64(t0);
     } else {
         gen_helper_divu_i64(ret, arg1, arg2);
@@ -2025,10 +2025,10 @@ void tcg_gen_remu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
         tcg_gen_mul_i64(t0, t0, arg2);
         tcg_gen_sub_i64(ret, arg1, t0);
         tcg_temp_free_i64(t0);
-    } else if (tcg_op_supported(INDEX_op_divu2_i64, TCG_TYPE_I64, 0)) {
+    } else if (tcg_op_supported(INDEX_op_divu2, TCG_TYPE_I64, 0)) {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
         TCGv_i64 zero = tcg_constant_i64(0);
-        tcg_gen_op5_i64(INDEX_op_divu2_i64, t0, ret, arg1, zero, arg2);
+        tcg_gen_op5_i64(INDEX_op_divu2, t0, ret, arg1, zero, arg2);
         tcg_temp_free_i64(t0);
     } else {
         gen_helper_remu_i64(ret, arg1, arg2);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 1029cba3f0..2c1307e3fc 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1029,8 +1029,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_divs, TCGOutOpBinary, outop_divs),
     OUTOP(INDEX_op_divu, TCGOutOpBinary, outop_divu),
     OUTOP(INDEX_op_divs2, TCGOutOpDivRem, outop_divs2),
-    OUTOP(INDEX_op_divu2_i32, TCGOutOpDivRem, outop_divu2),
-    OUTOP(INDEX_op_divu2_i64, TCGOutOpDivRem, outop_divu2),
+    OUTOP(INDEX_op_divu2, TCGOutOpDivRem, outop_divu2),
     OUTOP(INDEX_op_eqv, TCGOutOpBinary, outop_eqv),
     OUTOP(INDEX_op_mul, TCGOutOpBinary, outop_mul),
     OUTOP(INDEX_op_mulsh, TCGOutOpBinary, outop_mulsh),
@@ -5471,8 +5470,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         break;
 
     case INDEX_op_divs2:
-    case INDEX_op_divu2_i32:
-    case INDEX_op_divu2_i64:
+    case INDEX_op_divu2:
         {
             const TCGOutOpDivRem *out =
                 container_of(all_outop[op->opc], TCGOutOpDivRem, base);
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index 62af390854..8f3b5e91b2 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -307,6 +307,16 @@ Arithmetic
          pass *nh* as a simple sign-extension of *nl*, so the only
          overflow should be *INT_MIN* / -1.
 
+   * - divu2 *q*, *r*, *nl*, *nh*, *d*
+
+     - | *q* = *nh:nl* / *d* (unsigned)
+       | *r* = *nh:nl* % *d*
+       | Undefined behaviour if division by zero, or the double-word
+         numerator divided by the single-word divisor does not fit
+         within the single-word quotient.  The code generator will
+         pass 0 to *nh* to make a simple zero-extension of *nl*,
+         so overflow should never occur.
+
 Logical
 -------
 
-- 
2.43.0


