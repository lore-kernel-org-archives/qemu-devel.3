Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06FF606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=C+sQApow
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsWO-0006QS-QZ; Sun, 25 Oct 2026 03:20:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsWJ-0006Jl-LR
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:19:55 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsWH-0003k2-T0
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:19:55 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-48dfc0421d9so1734435f8f.1
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792912792; x=1793517592; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CFYlYtvJyXY50pqamj43RhfJI1WrRIuNfTSxLVxNKkg=;
 b=C+sQApowP8OdpGzAT9LZnDGUHbWhopxRULRq1jDw0p0gBP5qIZNmxyS55biL3phmsG
 CklynJd8pkiy0RTthrmIU7Q0kc1cD6emjwAQ2DJoKcbw/icN19zyi+3Om9i8xtXTgsWW
 HI4aOYE4nBDUJ4btm6EyKEaARDH+dsoSu4FwQEJ8z30iCK1StrIJ/AjfxEbOHKY8UtBr
 l6KSaVSjoKzOL3ydx9kz6rMMIHr/lE7P11wisylvwXC0V1HHz7+HfX9+QxbdiMXLlMHs
 OWaRtB2t7Hk+u6EjW3jnayqSGrEJbPSsksu8Q2/DI3VIxBIhsi3YGHD/R4HYWJGgEUIk
 Qnjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792912792; x=1793517592;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CFYlYtvJyXY50pqamj43RhfJI1WrRIuNfTSxLVxNKkg=;
 b=I6DBWpKryvLN9u3OYQQ27WG3Pn+hU7aEk3QqB4GatfLzMlpcmclV6SrzokNvepQ3Mv
 q90uSJi5E+92hbgvWgvXuRpDzxqyyEVi7+EdA+7h5g4/wV5cy94+8HFOT90Dd9HMMzQZ
 V0LFWdm0dIpPiVU0l78ps3uzCrfHy07PD6C5M80KlPHawYKffSmnOnx/Q9zhoHlnvzfN
 5+yq/097h8ZISoiOxm3a869ofCXfLKlDHWR2BpfBoRYeDKW4dUqNu7KQ+am42y5gzeC2
 GMdg8cjL6i3FRTqJsI7QFYpi/a99S0XZqWHgTuoJNQx3430LumZH5IA2YqyYyMVQZgMl
 5MVw==
X-Gm-Message-State: AFq9FYLWfseH5bV1VhZQh4+ilKyaMbf1IZFDe+YR0/lC+dhArjM0YOZI
 QDOKKlzxIComSO0NGDMWnE030/wy/OZxZ2YDE8BoIa7lH4T9lNQHCLjlPwbh7aLEth29PVHDUwc
 qpf+Widc=
X-Gm-Gg: AYBFou0SlUs0jKazBDKQt8TNfBGkV9U7hpmZYU8WtlO/FGQEW5EJ3dQ0QVp8h+y/iEu
 nq1m7sGcy/McOrXZH8xx5ApZq0vTfPTd0LtW1QkGNqKjQi5bhkeqU8I0viljdNC5ezDix9/HRlS
 K6c59sScczg2pBUipMYkhFpM3WjbsmyUilB+q3j1BI36k+Toe9/ecH5h62wNaGwc2MdcOwqP097
 4+Ufd2DFdjO7H0fKMCVcnv7YYmxG6Dqqjyq7jKpK6bba8lmkUECVOQITQ0vL3/1UbpkNzomeuvZ
 OOmiJt4DqQdArV3ZXuS/eoJwJQyaYsXovV485ir/lnzfzWFgQKbGpKIs/L/SxHf0RMUPkAAnQgt
 f48FeAJVtJkB7mQQBWwyasQ3DaHEPjO+CrEr9VPH+dKnAF6SxDYJ46NA5Crunqs3hyM0xCyg1gK
 m82yCJQptyDj+MwcMKQF2WsP9tAWDRumL5hHLx4j0H7UzhxipjMKt13NYIK+2tXWCeIFQSRRq9X
 3v8x880Nd8nVFHfNCKKL8GKw7x1TGgTySGhVMlxATmMYITF8E4g+D7tolw=
X-Received: by 2002:a5d:6802:0:b0:48e:43a:1d84 with SMTP id
 ffacd0b85a97d-48e3eb84b42mr4001063f8f.23.1792912792459; 
 Sun, 25 Oct 2026 00:19:52 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e4806e208sm4006309f8f.40.2026.10.25.00.19.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:19:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PULL 031/100] tcg: Drop division helpers
Date: Sun, 25 Oct 2026 08:18:06 +0100
Message-ID: <20261025071915.1123867-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42d.google.com
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

All current tcg hosts support division, so the helpers
are no longer used.

Reviewed-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-runtime.h | 10 ----------
 accel/tcg/tcg-runtime.c | 44 -----------------------------------------
 tcg/tcg-op.c            | 16 +++++++--------
 3 files changed, 8 insertions(+), 62 deletions(-)

diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
index 0b832176b3..003c963bc7 100644
--- a/accel/tcg/tcg-runtime.h
+++ b/accel/tcg/tcg-runtime.h
@@ -1,13 +1,3 @@
-DEF_HELPER_FLAGS_2(div_i32, TCG_CALL_NO_RWG_SE, s32, s32, s32)
-DEF_HELPER_FLAGS_2(rem_i32, TCG_CALL_NO_RWG_SE, s32, s32, s32)
-DEF_HELPER_FLAGS_2(divu_i32, TCG_CALL_NO_RWG_SE, i32, i32, i32)
-DEF_HELPER_FLAGS_2(remu_i32, TCG_CALL_NO_RWG_SE, i32, i32, i32)
-
-DEF_HELPER_FLAGS_2(div_i64, TCG_CALL_NO_RWG_SE, s64, s64, s64)
-DEF_HELPER_FLAGS_2(rem_i64, TCG_CALL_NO_RWG_SE, s64, s64, s64)
-DEF_HELPER_FLAGS_2(divu_i64, TCG_CALL_NO_RWG_SE, i64, i64, i64)
-DEF_HELPER_FLAGS_2(remu_i64, TCG_CALL_NO_RWG_SE, i64, i64, i64)
-
 DEF_HELPER_FLAGS_2(mulsh_i64, TCG_CALL_NO_RWG_SE, s64, s64, s64)
 DEF_HELPER_FLAGS_2(muluh_i64, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 
diff --git a/accel/tcg/tcg-runtime.c b/accel/tcg/tcg-runtime.c
index 7c0aab98a8..77c4024148 100644
--- a/accel/tcg/tcg-runtime.c
+++ b/accel/tcg/tcg-runtime.c
@@ -32,50 +32,6 @@
 #include "exec/helper-info.c.inc"
 #undef  HELPER_H
 
-/* 32-bit helpers */
-
-int32_t HELPER(div_i32)(int32_t arg1, int32_t arg2)
-{
-    return arg1 / arg2;
-}
-
-int32_t HELPER(rem_i32)(int32_t arg1, int32_t arg2)
-{
-    return arg1 % arg2;
-}
-
-uint32_t HELPER(divu_i32)(uint32_t arg1, uint32_t arg2)
-{
-    return arg1 / arg2;
-}
-
-uint32_t HELPER(remu_i32)(uint32_t arg1, uint32_t arg2)
-{
-    return arg1 % arg2;
-}
-
-/* 64-bit helpers */
-
-int64_t HELPER(div_i64)(int64_t arg1, int64_t arg2)
-{
-    return arg1 / arg2;
-}
-
-int64_t HELPER(rem_i64)(int64_t arg1, int64_t arg2)
-{
-    return arg1 % arg2;
-}
-
-uint64_t HELPER(divu_i64)(uint64_t arg1, uint64_t arg2)
-{
-    return arg1 / arg2;
-}
-
-uint64_t HELPER(remu_i64)(uint64_t arg1, uint64_t arg2)
-{
-    return arg1 % arg2;
-}
-
 uint64_t HELPER(muluh_i64)(uint64_t arg1, uint64_t arg2)
 {
     uint64_t l, h;
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 9b3974fb8a..09e417b760 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -619,7 +619,7 @@ void tcg_gen_div_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
         tcg_gen_op5_i32(INDEX_op_divs2, ret, t0, arg1, t0, arg2);
         tcg_temp_free_i32(t0);
     } else {
-        gen_helper_div_i32(ret, arg1, arg2);
+        g_assert_not_reached();
     }
 }
 
@@ -639,7 +639,7 @@ void tcg_gen_rem_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
         tcg_gen_op5_i32(INDEX_op_divs2, t0, ret, arg1, t0, arg2);
         tcg_temp_free_i32(t0);
     } else {
-        gen_helper_rem_i32(ret, arg1, arg2);
+        g_assert_not_reached();
     }
 }
 
@@ -653,7 +653,7 @@ void tcg_gen_divu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
         tcg_gen_op5_i32(INDEX_op_divu2, ret, t0, arg1, zero, arg2);
         tcg_temp_free_i32(t0);
     } else {
-        gen_helper_divu_i32(ret, arg1, arg2);
+        g_assert_not_reached();
     }
 }
 
@@ -673,7 +673,7 @@ void tcg_gen_remu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
         tcg_gen_op5_i32(INDEX_op_divu2, t0, ret, arg1, zero, arg2);
         tcg_temp_free_i32(t0);
     } else {
-        gen_helper_remu_i32(ret, arg1, arg2);
+        g_assert_not_reached();
     }
 }
 
@@ -1547,7 +1547,7 @@ void tcg_gen_div_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
         tcg_gen_op5_i64(INDEX_op_divs2, ret, t0, arg1, t0, arg2);
         tcg_temp_free_i64(t0);
     } else {
-        gen_helper_div_i64(ret, arg1, arg2);
+        g_assert_not_reached();
     }
 }
 
@@ -1567,7 +1567,7 @@ void tcg_gen_rem_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
         tcg_gen_op5_i64(INDEX_op_divs2, t0, ret, arg1, t0, arg2);
         tcg_temp_free_i64(t0);
     } else {
-        gen_helper_rem_i64(ret, arg1, arg2);
+        g_assert_not_reached();
     }
 }
 
@@ -1581,7 +1581,7 @@ void tcg_gen_divu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
         tcg_gen_op5_i64(INDEX_op_divu2, ret, t0, arg1, zero, arg2);
         tcg_temp_free_i64(t0);
     } else {
-        gen_helper_divu_i64(ret, arg1, arg2);
+        g_assert_not_reached();
     }
 }
 
@@ -1601,7 +1601,7 @@ void tcg_gen_remu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
         tcg_gen_op5_i64(INDEX_op_divu2, t0, ret, arg1, zero, arg2);
         tcg_temp_free_i64(t0);
     } else {
-        gen_helper_remu_i64(ret, arg1, arg2);
+        g_assert_not_reached();
     }
 }
 
-- 
2.53.0


