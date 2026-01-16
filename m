Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8768D4A5F7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 03:47:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgagK-00056S-4w; Thu, 15 Jan 2026 22:39:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgafy-0004xx-Cm
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:39:08 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgafw-0008Im-J3
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:39:06 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-29f2676bb21so15492445ad.0
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 19:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768534743; x=1769139543; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0laMDFdu0GCNRz+fuF/L/mWxDMERFitEw5PSc+47rq0=;
 b=slbiI6NaU5XeWOWBkXlbLHC+Z8Ru3d6M98ajsYXF4EL8c9bvp0pWepg1k2XIFIh4om
 V+9WZDDbnQV/uActgqwLtNOz1SPv25jg1/C/4TFasfe+5gqL0QKbx/6/AZNJnzPbtpJ2
 SB3deC2ZWXTlH1yyk02iuZhhHvCwW+QgcY1vIxuGShIfabXajLERH7/tn6c7cvjExg8P
 D63SI/uU4H++O6m0R+Eat8GLir6/6xjZcPRd1iu0zya6x63lsKsLiuk9fvLNmOwNULqi
 rS/LeR2WQi71lGm7SgOHt4umY2TjUDLQogWTHBRxwDAKQugstEv0MXGoRoRqMHwomwFk
 X+Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768534743; x=1769139543;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0laMDFdu0GCNRz+fuF/L/mWxDMERFitEw5PSc+47rq0=;
 b=O4k+sn3tXB8ZLEhaju+Iz8IwweE3JL+tT2Nja8bIHKTZOtBAY1gCRrqantYzWWxJBo
 QLGzDKMCwZ/fpKZkxDfW4BTIJD4kdsfhswYXweLri5mm2lCMLwikNQ2UEDdOSpbgHHh0
 Ba35zJOCpto306GgUCoRQ+39MRisGBLqSw4DFkzL0BRNHPNV/bbtXyyLRyX6u/v8RU3q
 WvQr2bETsVCtcEBa9mu/2b/Lkux2scQWRxAZmsjCHz1us4Ea2VG2zHnNsjPrJ0ENNhkL
 XCeGSEgqNjn0CjvMb7LuXqq9NaUZdSyOcbHPlbx5w+nIw0Up91q2szwJcSyi1JofxXIk
 ON3A==
X-Gm-Message-State: AOJu0YyR7XS1o3MPQ+/Wdb65o0DAgezi34EUzcQOF/E0/zEY4u6W7MJQ
 DpB5IZKHgcfbGAkQ2VS1anIWtGj04R+Fs2Fq4HhRB9rDdNjbF23vHaikhfCeRcZTeyPexi8tQ8U
 IwBJ6vgt6Qw==
X-Gm-Gg: AY/fxX5PO0ZtFFXwuskfJ+KAtQBn/mTcXBELSfAHbJbwqwM2mqnIP2YnILMhUwDQFq1
 sStPp80AFNeVyd/qWZobZYYx87MHqLYE3h3+bE194JPTDXIovQAqCItPtFyfcFEyd5Q16HhW7Lc
 c597Y7MXkCAVDr8P5DrPE0VtZ+9W2Q38xMHmu/uRfmVv+DjJ2bda5izwhyuO2JqVQtWs33NHDjH
 sp4F4CvVu6Znv/+f2ecS6mXBIxVlgsQwvTgHU+/+PVpAhAABrsE4E0e+jRKTnoJZnnJskbzf94v
 y/U6X7jLX05UNV9aQEJayj4J2KUARqTKflMwd7Es/fDBgT2MQBES+59Kf5Xqif5zkbuVYs2A56F
 loUNDX4udeHnUPHj1ay36hI6pMIN16hwrKpb78N+Z3swq3YLeNX2OjNem5TeOY61zu61vgXo2Mn
 VrUAoBTbRMM3+p/QsgVe+LUnDiZxu5
X-Received: by 2002:a17:902:d549:b0:297:e69d:86ac with SMTP id
 d9443c01a7336-2a718914867mr13940765ad.39.1768534743201; 
 Thu, 15 Jan 2026 19:39:03 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7190ca9d5sm6527975ad.25.2026.01.15.19.38.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 19:39:02 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: ktokunaga.mail@gmail.com, berrange@redhat.com, pierrick.bouvier@linaro.org,
 thuth@redhat.com, pbonzini@redhat.com, philmd@linaro.org
Subject: [PATCH v2 43/58] tcg: Unconditionally define atomic64 helpers
Date: Fri, 16 Jan 2026 14:32:49 +1100
Message-ID: <20260116033305.51162-44-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260116033305.51162-1-richard.henderson@linaro.org>
References: <20260116033305.51162-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

CONFIG_ATOMIC64 is a configuration knob for 32-bit hosts.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-runtime.h             | 16 ----------------
 include/accel/tcg/cpu-ldst-common.h |  9 ---------
 accel/tcg/cputlb.c                  |  2 --
 accel/tcg/user-exec.c               |  2 --
 tcg/tcg-op-ldst.c                   | 17 ++++++-----------
 accel/tcg/atomic_common.c.inc       | 12 ------------
 6 files changed, 6 insertions(+), 52 deletions(-)

diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
index dc89155c0f..0b832176b3 100644
--- a/accel/tcg/tcg-runtime.h
+++ b/accel/tcg/tcg-runtime.h
@@ -48,12 +48,10 @@ DEF_HELPER_FLAGS_5(atomic_cmpxchgl_be, TCG_CALL_NO_WG,
                    i32, env, i64, i32, i32, i32)
 DEF_HELPER_FLAGS_5(atomic_cmpxchgl_le, TCG_CALL_NO_WG,
                    i32, env, i64, i32, i32, i32)
-#ifdef CONFIG_ATOMIC64
 DEF_HELPER_FLAGS_5(atomic_cmpxchgq_be, TCG_CALL_NO_WG,
                    i64, env, i64, i64, i64, i32)
 DEF_HELPER_FLAGS_5(atomic_cmpxchgq_le, TCG_CALL_NO_WG,
                    i64, env, i64, i64, i64, i32)
-#endif
 #if HAVE_CMPXCHG128
 DEF_HELPER_FLAGS_5(atomic_cmpxchgo_be, TCG_CALL_NO_WG,
                    i128, env, i64, i128, i128, i32)
@@ -73,7 +71,6 @@ DEF_HELPER_FLAGS_4(atomic_fetch_oro_le, TCG_CALL_NO_WG,
                    i128, env, i64, i128, i32)
 #endif
 
-#ifdef CONFIG_ATOMIC64
 #define GEN_ATOMIC_HELPERS(NAME)                                  \
     DEF_HELPER_FLAGS_4(glue(glue(atomic_, NAME), b),              \
                        TCG_CALL_NO_WG, i32, env, i64, i32, i32)   \
@@ -89,19 +86,6 @@ DEF_HELPER_FLAGS_4(atomic_fetch_oro_le, TCG_CALL_NO_WG,
                        TCG_CALL_NO_WG, i64, env, i64, i64, i32)   \
     DEF_HELPER_FLAGS_4(glue(glue(atomic_, NAME), q_be),           \
                        TCG_CALL_NO_WG, i64, env, i64, i64, i32)
-#else
-#define GEN_ATOMIC_HELPERS(NAME)                                  \
-    DEF_HELPER_FLAGS_4(glue(glue(atomic_, NAME), b),              \
-                       TCG_CALL_NO_WG, i32, env, i64, i32, i32)   \
-    DEF_HELPER_FLAGS_4(glue(glue(atomic_, NAME), w_le),           \
-                       TCG_CALL_NO_WG, i32, env, i64, i32, i32)   \
-    DEF_HELPER_FLAGS_4(glue(glue(atomic_, NAME), w_be),           \
-                       TCG_CALL_NO_WG, i32, env, i64, i32, i32)   \
-    DEF_HELPER_FLAGS_4(glue(glue(atomic_, NAME), l_le),           \
-                       TCG_CALL_NO_WG, i32, env, i64, i32, i32)   \
-    DEF_HELPER_FLAGS_4(glue(glue(atomic_, NAME), l_be),           \
-                       TCG_CALL_NO_WG, i32, env, i64, i32, i32)
-#endif /* CONFIG_ATOMIC64 */
 
 GEN_ATOMIC_HELPERS(fetch_add)
 GEN_ATOMIC_HELPERS(fetch_and)
diff --git a/include/accel/tcg/cpu-ldst-common.h b/include/accel/tcg/cpu-ldst-common.h
index 17a3250ded..f12be8cfb7 100644
--- a/include/accel/tcg/cpu-ldst-common.h
+++ b/include/accel/tcg/cpu-ldst-common.h
@@ -60,7 +60,6 @@ TYPE cpu_atomic_ ## NAME ## SUFFIX ## _mmu      \
     (CPUArchState *env, vaddr addr, TYPE val,   \
      MemOpIdx oi, uintptr_t retaddr);
 
-#ifdef CONFIG_ATOMIC64
 #define GEN_ATOMIC_HELPER_ALL(NAME)          \
     GEN_ATOMIC_HELPER(NAME, uint32_t, b)     \
     GEN_ATOMIC_HELPER(NAME, uint32_t, w_le)  \
@@ -69,14 +68,6 @@ TYPE cpu_atomic_ ## NAME ## SUFFIX ## _mmu      \
     GEN_ATOMIC_HELPER(NAME, uint32_t, l_be)  \
     GEN_ATOMIC_HELPER(NAME, uint64_t, q_le)  \
     GEN_ATOMIC_HELPER(NAME, uint64_t, q_be)
-#else
-#define GEN_ATOMIC_HELPER_ALL(NAME)          \
-    GEN_ATOMIC_HELPER(NAME, uint32_t, b)     \
-    GEN_ATOMIC_HELPER(NAME, uint32_t, w_le)  \
-    GEN_ATOMIC_HELPER(NAME, uint32_t, w_be)  \
-    GEN_ATOMIC_HELPER(NAME, uint32_t, l_le)  \
-    GEN_ATOMIC_HELPER(NAME, uint32_t, l_be)
-#endif
 
 GEN_ATOMIC_HELPER_ALL(fetch_add)
 GEN_ATOMIC_HELPER_ALL(fetch_sub)
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index c30073326a..a6774083b0 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -2886,10 +2886,8 @@ static void do_st16_mmu(CPUState *cpu, vaddr addr, Int128 val,
 #define DATA_SIZE 4
 #include "atomic_template.h"
 
-#ifdef CONFIG_ATOMIC64
 #define DATA_SIZE 8
 #include "atomic_template.h"
-#endif
 
 #if defined(CONFIG_ATOMIC128) || HAVE_CMPXCHG128
 #define DATA_SIZE 16
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 1800dffa63..ddbdc0432d 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -1258,10 +1258,8 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
 #define DATA_SIZE 4
 #include "atomic_template.h"
 
-#ifdef CONFIG_ATOMIC64
 #define DATA_SIZE 8
 #include "atomic_template.h"
-#endif
 
 #if defined(CONFIG_ATOMIC128) || HAVE_CMPXCHG128
 #define DATA_SIZE 16
diff --git a/tcg/tcg-op-ldst.c b/tcg/tcg-op-ldst.c
index 55bfbf3a20..354d9968f9 100644
--- a/tcg/tcg-op-ldst.c
+++ b/tcg/tcg-op-ldst.c
@@ -825,11 +825,6 @@ typedef void (*gen_atomic_op_i64)(TCGv_i64, TCGv_env, TCGv_i64,
 typedef void (*gen_atomic_op_i128)(TCGv_i128, TCGv_env, TCGv_i64,
                                    TCGv_i128, TCGv_i32);
 
-#ifdef CONFIG_ATOMIC64
-# define WITH_ATOMIC64(X) X,
-#else
-# define WITH_ATOMIC64(X)
-#endif
 #if HAVE_CMPXCHG128
 # define WITH_ATOMIC128(X) X,
 #else
@@ -842,8 +837,8 @@ static void * const table_cmpxchg[(MO_SIZE | MO_BSWAP) + 1] = {
     [MO_16 | MO_BE] = gen_helper_atomic_cmpxchgw_be,
     [MO_32 | MO_LE] = gen_helper_atomic_cmpxchgl_le,
     [MO_32 | MO_BE] = gen_helper_atomic_cmpxchgl_be,
-    WITH_ATOMIC64([MO_64 | MO_LE] = gen_helper_atomic_cmpxchgq_le)
-    WITH_ATOMIC64([MO_64 | MO_BE] = gen_helper_atomic_cmpxchgq_be)
+    [MO_64 | MO_LE] = gen_helper_atomic_cmpxchgq_le,
+    [MO_64 | MO_BE] = gen_helper_atomic_cmpxchgq_be,
     WITH_ATOMIC128([MO_128 | MO_LE] = gen_helper_atomic_cmpxchgo_le)
     WITH_ATOMIC128([MO_128 | MO_BE] = gen_helper_atomic_cmpxchgo_be)
 };
@@ -1235,8 +1230,8 @@ static void * const table_##NAME[(MO_SIZE | MO_BSWAP) + 1] = {          \
     [MO_16 | MO_BE] = gen_helper_atomic_##NAME##w_be,                   \
     [MO_32 | MO_LE] = gen_helper_atomic_##NAME##l_le,                   \
     [MO_32 | MO_BE] = gen_helper_atomic_##NAME##l_be,                   \
-    WITH_ATOMIC64([MO_64 | MO_LE] = gen_helper_atomic_##NAME##q_le)     \
-    WITH_ATOMIC64([MO_64 | MO_BE] = gen_helper_atomic_##NAME##q_be)     \
+    [MO_64 | MO_LE] = gen_helper_atomic_##NAME##q_le,                   \
+    [MO_64 | MO_BE] = gen_helper_atomic_##NAME##q_be,                   \
     WITH_ATOMIC128([MO_128 | MO_LE] = gen_helper_atomic_##NAME##o_le)   \
     WITH_ATOMIC128([MO_128 | MO_BE] = gen_helper_atomic_##NAME##o_be)   \
 };                                                                      \
@@ -1287,8 +1282,8 @@ static void * const table_##NAME[(MO_SIZE | MO_BSWAP) + 1] = {          \
     [MO_16 | MO_BE] = gen_helper_atomic_##NAME##w_be,                   \
     [MO_32 | MO_LE] = gen_helper_atomic_##NAME##l_le,                   \
     [MO_32 | MO_BE] = gen_helper_atomic_##NAME##l_be,                   \
-    WITH_ATOMIC64([MO_64 | MO_LE] = gen_helper_atomic_##NAME##q_le)     \
-    WITH_ATOMIC64([MO_64 | MO_BE] = gen_helper_atomic_##NAME##q_be)     \
+    [MO_64 | MO_LE] = gen_helper_atomic_##NAME##q_le,                   \
+    [MO_64 | MO_BE] = gen_helper_atomic_##NAME##q_be,                   \
 };                                                                      \
 void tcg_gen_atomic_##NAME##_i32_chk(TCGv_i32 ret, TCGTemp *addr,       \
                                      TCGv_i32 val, TCGArg idx,          \
diff --git a/accel/tcg/atomic_common.c.inc b/accel/tcg/atomic_common.c.inc
index 1ff80d19fe..7d779dd51d 100644
--- a/accel/tcg/atomic_common.c.inc
+++ b/accel/tcg/atomic_common.c.inc
@@ -46,11 +46,8 @@ CMPXCHG_HELPER(cmpxchgw_be, uint32_t)
 CMPXCHG_HELPER(cmpxchgw_le, uint32_t)
 CMPXCHG_HELPER(cmpxchgl_be, uint32_t)
 CMPXCHG_HELPER(cmpxchgl_le, uint32_t)
-
-#ifdef CONFIG_ATOMIC64
 CMPXCHG_HELPER(cmpxchgq_be, uint64_t)
 CMPXCHG_HELPER(cmpxchgq_le, uint64_t)
-#endif
 
 #if HAVE_CMPXCHG128
 CMPXCHG_HELPER(cmpxchgo_be, Int128)
@@ -64,7 +61,6 @@ CMPXCHG_HELPER(cmpxchgo_le, Int128)
                                   TYPE val, uint32_t oi)                 \
     { return glue(glue(cpu_atomic_,OP),_mmu)(env, addr, val, oi, GETPC()); }
 
-#ifdef CONFIG_ATOMIC64
 #define GEN_ATOMIC_HELPERS(OP)              \
     ATOMIC_HELPER(glue(OP,b), uint32_t)     \
     ATOMIC_HELPER(glue(OP,w_be), uint32_t)  \
@@ -73,14 +69,6 @@ CMPXCHG_HELPER(cmpxchgo_le, Int128)
     ATOMIC_HELPER(glue(OP,l_le), uint32_t)  \
     ATOMIC_HELPER(glue(OP,q_be), uint64_t)  \
     ATOMIC_HELPER(glue(OP,q_le), uint64_t)
-#else
-#define GEN_ATOMIC_HELPERS(OP)              \
-    ATOMIC_HELPER(glue(OP,b), uint32_t)     \
-    ATOMIC_HELPER(glue(OP,w_be), uint32_t)  \
-    ATOMIC_HELPER(glue(OP,w_le), uint32_t)  \
-    ATOMIC_HELPER(glue(OP,l_be), uint32_t)  \
-    ATOMIC_HELPER(glue(OP,l_le), uint32_t)
-#endif
 
 GEN_ATOMIC_HELPERS(fetch_add)
 GEN_ATOMIC_HELPERS(fetch_and)
-- 
2.43.0


