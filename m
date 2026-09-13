Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 892EEC88E53
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 02:42:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5a82-0000qY-P6; Sat, 12 Sep 2026 22:39:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5a7j-0008UW-Pg
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:39:21 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5a7d-00013u-Qq
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:39:15 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-39b9184fa80so936347a91.2
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 19:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789267151; x=1789871951; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=fLrXh8qOCOhD917kRkmsTzh2FVXg7K478+PLNmyHpZs=;
 b=qRfslSkD12o2r/Q5fzZ4T9MMB6J7rUmR904X8AL64XbY7Wyk0sctDKeRSn7OMMyehP
 lF/I/SWa21Mtzcgguy6pwnucwkXKdaz8UMtICwRE28x5o7XW6Ac525UL/sxwXHsiJHXB
 prX0VZsVRKNMPSE3m3LOi5aH4D67lwK6jesbixm/MR80VqUuFPaTRaP/d13ROerSfEjJ
 wSElgQdq/A6UJo2L8jnWmRqBtAXPJTCX1j05MabZN0XrGQXNzU5h4JtSOtZtp811aV/L
 cmZJCkR5QNKyHcfH2nLzS8ASXgzeKzRAZng8lerCAJ6MwtUjwolVcLEfX01Pac2uz+qQ
 Uc1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789267151; x=1789871951;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=fLrXh8qOCOhD917kRkmsTzh2FVXg7K478+PLNmyHpZs=;
 b=h+incF9Hp7V2myNMpiGaJ0uQrLMtnO7p70FRVu20RKPizjzzCNMNGJMX38KXZJXeVM
 Rjeh+mzou288vZ7L+TiSHdFlYA/GtKZfC/iZ3BUJe+xM1LvrKgZ5jTihcC0rLuqL9WHo
 +GSnT3peOUx9fKfUHDFjuMZmiA4BDggZjWF8q4WQltbMU7FR4Aqe5JwyUpPTL6Ja2+OA
 2xCeMVEghQGWPa56CqEXrLSswxrtXiQten9U9GjqJvYR5RaKXQVaAyK3LgjIscg4v9UE
 0aszM4LryYBgx5ZW4Dt+M4ncswq5fHjLHfinQPyKmfUvDyAkVH/pOap3UVhieRzXUxwO
 0Y2Q==
X-Gm-Message-State: AFuF++k08ZWU5ZSTad6KdKe32sQQRAnt2o5qXcaM2NSLIHqA2NFhYozk
 dENXuKZfEVfus7kj52Uo4IcTnXYEBkYA2ltBVR4pQJwp4s25VfllUZhr33YgSha0v4losUNLe+J
 tRz8/
X-Gm-Gg: AYBFou2hvqMPZvwZyjr82Ivl5uM4V9mxZt+MU4asaDY63htPmVOH35w6oPvgdJ7yDkP
 6pdW5V6oca5juHtoZY1rWfb71mfdUwA2jG+0/I6JokJMnXKXmByWp8Xvprw45fHHaN1PP2r/qdX
 E/bp/Clgv2k4/sE5PC3sNW26aT2b7AAn6ZbMLja1ddeCGz7mSJbvmDvGL2OG6x0Bfs8ZG1WnyrA
 0PF9jXzOttFDpu3sLLkVsg76nCwo3SqiIO+t0CNALTuMvf2wKuiqd27Xx8D2+AvgnHNfiXS6/ZK
 jc8kUhRs/lzcrcNdd+tNx9Z0iZpYpnjmB8XGbkmV232qatv17cpSkL9jHmUxsOyy58vrSpTTued
 NgiEZf46sRTPxV+QAwj1uycPqDB8gGuxmXTvWGcSzrTtrWwzOc9XuoBPOkwvAIlcK9viFCGvuvg
 SGl10qloHbpe+LrqsXBYKY2aD+NAhHMO4kb7AauphDAzJcpRlVct8t4RIW3ZPSW3nnTbtRF63Tx
 p1hnwDFYV8q25uzNg==
X-Received: by 2002:a17:90b:4ad2:b0:398:9be6:f996 with SMTP id
 98e67ed59e1d1-39d9c34a241mr18379508a91.21.1789267150909; 
 Sat, 12 Sep 2026 19:39:10 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8ead8sm16174535c88.10.2026.09.12.19.39.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 19:39:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 27/86] tcg: Drop division helpers
Date: Sat, 12 Sep 2026 16:37:38 -1000
Message-ID: <20260913023837.741866-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913023837.741866-1-richard.henderson@linaro.org>
References: <20260913023837.741866-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

All current tcg hosts support division, so the helpers
are no longer used.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-runtime.h | 10 ----------
 accel/tcg/tcg-runtime.c | 44 -----------------------------------------
 tcg/tcg-op.c            | 16 +++++++--------
 3 files changed, 8 insertions(+), 62 deletions(-)

diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
index 0b832176b33..003c963bc7d 100644
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
index 7c0aab98a80..77c4024148f 100644
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
index 826553e4476..0cc1274543b 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -659,7 +659,7 @@ void tcg_gen_div_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
         tcg_gen_op5_i32(INDEX_op_divs2, ret, t0, arg1, t0, arg2);
         tcg_temp_free_i32(t0);
     } else {
-        gen_helper_div_i32(ret, arg1, arg2);
+        g_assert_not_reached();
     }
 }
 
@@ -679,7 +679,7 @@ void tcg_gen_rem_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
         tcg_gen_op5_i32(INDEX_op_divs2, t0, ret, arg1, t0, arg2);
         tcg_temp_free_i32(t0);
     } else {
-        gen_helper_rem_i32(ret, arg1, arg2);
+        g_assert_not_reached();
     }
 }
 
@@ -693,7 +693,7 @@ void tcg_gen_divu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
         tcg_gen_op5_i32(INDEX_op_divu2, ret, t0, arg1, zero, arg2);
         tcg_temp_free_i32(t0);
     } else {
-        gen_helper_divu_i32(ret, arg1, arg2);
+        g_assert_not_reached();
     }
 }
 
@@ -713,7 +713,7 @@ void tcg_gen_remu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
         tcg_gen_op5_i32(INDEX_op_divu2, t0, ret, arg1, zero, arg2);
         tcg_temp_free_i32(t0);
     } else {
-        gen_helper_remu_i32(ret, arg1, arg2);
+        g_assert_not_reached();
     }
 }
 
@@ -1587,7 +1587,7 @@ void tcg_gen_div_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
         tcg_gen_op5_i64(INDEX_op_divs2, ret, t0, arg1, t0, arg2);
         tcg_temp_free_i64(t0);
     } else {
-        gen_helper_div_i64(ret, arg1, arg2);
+        g_assert_not_reached();
     }
 }
 
@@ -1607,7 +1607,7 @@ void tcg_gen_rem_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
         tcg_gen_op5_i64(INDEX_op_divs2, t0, ret, arg1, t0, arg2);
         tcg_temp_free_i64(t0);
     } else {
-        gen_helper_rem_i64(ret, arg1, arg2);
+        g_assert_not_reached();
     }
 }
 
@@ -1621,7 +1621,7 @@ void tcg_gen_divu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
         tcg_gen_op5_i64(INDEX_op_divu2, ret, t0, arg1, zero, arg2);
         tcg_temp_free_i64(t0);
     } else {
-        gen_helper_divu_i64(ret, arg1, arg2);
+        g_assert_not_reached();
     }
 }
 
@@ -1641,7 +1641,7 @@ void tcg_gen_remu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
         tcg_gen_op5_i64(INDEX_op_divu2, t0, ret, arg1, zero, arg2);
         tcg_temp_free_i64(t0);
     } else {
-        gen_helper_remu_i64(ret, arg1, arg2);
+        g_assert_not_reached();
     }
 }
 
-- 
2.53.0


