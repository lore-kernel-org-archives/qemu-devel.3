Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713E0606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=HosYL5cz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsef-0003EF-8g; Sun, 25 Oct 2026 03:28:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsdD-00004z-Bo
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:27:11 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsdB-0004cn-4W
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:27:03 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-48441a2ba1bso1204362f8f.1
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792913220; x=1793518020; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VMF+2JCcMeqV3m+cxukBKf/f2sE4AAgXqUECfmjFosQ=;
 b=HosYL5czLynfQcJBfE2Toz0E68s6spdc0rVi+1dUtRXgUeL8oDWNd8+cGGBIyW0CG2
 UfNeYMlQycHmf4EYFbSXpcDw911AQE4iFwQ3rmyuZpszLlmFLSXtb8M0Nd8clEc39uRH
 K6HvfQL15MYQwSfYgk2aWKWufIZ8uhCUJq08SZpzTIsC3e5dxOuXTP8TKjh6xxvbppvL
 bVNfECeMyahHvK5G3BzcMFgTvIb4tDFzkJNPqmRCyIlDAM8WrtMxN0zSpoHwmqRJUYZ7
 VYSuHUzi46csLxzTqbCUWD7Ee5QAdPWEY9MXKMGIpVfKLJuDum6aDwuU3YurndrnBcGP
 PthQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792913220; x=1793518020;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VMF+2JCcMeqV3m+cxukBKf/f2sE4AAgXqUECfmjFosQ=;
 b=WWyZgNIB34ZAnwn19ss9RM8q8KaHW63qoaBC0ohH+YmGgGndoq7T4k4qKGxqNF6TKE
 Df36rxw2CoIksorlzjnQMiAhMg+w62b3RPbrCMi5ZS1HuX/NIADlAjQ7gO14DqCk2Rth
 AoiJP6IrIHXDVJpoj23Rd8i0pG3sjAH1ubHqKL04NHglZzXszBN+wbtj2S8OkBlNuCoj
 lk1/oTi2jWhSfk82hDBqCG9LYQpkkiiw6Ao+OhqwwtwAKAHWh1cVsujSMwT987LTrjXP
 7uV2GhCcntptGS2TaOVqtguIZLw1qEs3D3K7nlbCSmdkqxYFIHwDyBf6x/mykJIIiJjc
 ODrw==
X-Gm-Message-State: AFq9FYKgxvsnyPiYVqvLbJBdnxDvC3ig+dWc0q9NpN+pI6YhA8WmNS6q
 RppigiyvMl8/sopY22pXAsFdtk1vp80tdmRX6CElb0NCE72nmq70apCfwqp2Z29Z2JJGa4eSdaH
 PkoGzYCg=
X-Gm-Gg: AYBFou3y3avggdLwrrQh+l2C7hEU5WfgCAV0gSrXWcRIcLgsgqRZ2ofO0ucjr3Mt1/Y
 jOzrQ5s6dp8dnJt9mayZF+5zSUYXe8L7yGq4aJ0WDT+D7jrz0UiEEPQ8gXorKxAh6etqJ0oV+yt
 V7+KpMQwdfVolvDutQaTo8UfiJ5PVu+WqjPGBfFEC+HgRuXaU7ebpzycJ9WIEGXfACHWt0nfR68
 bitgDDRyMYkzY8e40bhotHz5bs4dNZdQdPuG38DoG9eBRkAF+4UPcT3K+OKAJvYAYUs8FE1hyVR
 sm65A1RCansbjY8/laewPl89jAVhcQJ4LZQq+KNEnY4suhS0YCZz5hNjVW8Ms6DGFmgijOvm8Tj
 kNjIiSqKWJRbPyJJiRa6XGpgCtOLWvTSl/uUEadxmtkv/GYtFJxmcasURryb6QFLgjxdIGKHL40
 NFQ2vdXRcEcZrH4ZYngWuSmKHm8j8RpKlwt50Qlj64ny9fsHm9gFwyMwaRPxyTjFzX9Dmb1zZ5e
 uSo0yTIfFAFvc34EY5bikjeNvknIWMuatBREilGoAUXLUODAPwDnog4bqyFDE1mZTKIdY1uvN0g
 YtRP
X-Received: by 2002:a05:600c:4e0e:b0:4a2:397:73f6 with SMTP id
 5b1f17b1804b1-4a35ac9d227mr60702755e9.8.1792913219653; 
 Sun, 25 Oct 2026 00:26:59 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a359fc1207sm82923745e9.1.2026.10.25.00.26.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:26:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PULL 097/100] tcg: Generic expansion of tcg_gen_qemu_st_chk
Date: Sun, 25 Oct 2026 08:19:12 +0100
Message-ID: <20261025071915.1123867-98-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x435.google.com
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
 include/tcg/tcg-op-common.h  |   6 +-
 include/tcg/tcg-op-mem.h     |   6 +-
 include/tcg/tcg-op-def.h.inc |   1 +
 tcg/tcg-op-ldst.c            | 114 ++++++-----------------------------
 4 files changed, 25 insertions(+), 102 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index ce47bebb2b..711eb96a86 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -175,12 +175,8 @@ void tcg_gen_mov_i128(TCGv_i128 dst, TCGv_i128 src);
 void tcg_gen_ld_i128(TCGv_i128 ret, TCGv_ptr base, tcg_target_long offset);
 void tcg_gen_st_i128(TCGv_i128 val, TCGv_ptr base, tcg_target_long offset);
 
-/* Local load/store bit ops */
-
 void tcg_gen_qemu_ld_chk_i128(TCGv_i128, TCGTemp *, TCGArg, MemOp, TCGType);
-void tcg_gen_qemu_st_i32_chk(TCGv_i32, TCGTemp *, TCGArg, MemOp, TCGType);
-void tcg_gen_qemu_st_i64_chk(TCGv_i64, TCGTemp *, TCGArg, MemOp, TCGType);
-void tcg_gen_qemu_st_i128_chk(TCGv_i128, TCGTemp *, TCGArg, MemOp, TCGType);
+void tcg_gen_qemu_st_chk_i128(TCGv_i128, TCGTemp *, TCGArg, MemOp, TCGType);
 
 /* Atomic ops */
 
diff --git a/include/tcg/tcg-op-mem.h b/include/tcg/tcg-op-mem.h
index 76955d27c1..e8425e1059 100644
--- a/include/tcg/tcg-op-mem.h
+++ b/include/tcg/tcg-op-mem.h
@@ -37,7 +37,7 @@ tcg_gen_qemu_ld_i32(TCGv_i32 v, TCGv_va a, TCGArg i, MemOp m)
 QEMU_ARG_NONNULL static inline void
 tcg_gen_qemu_st_i32(TCGv_i32 v, TCGv_va a, TCGArg i, MemOp m)
 {
-    tcg_gen_qemu_st_i32_chk(v, tcgv_va_temp(a), i, m, TCG_TYPE_VA);
+    tcg_gen_qemu_st_chk_i32(v, tcgv_va_temp(a), i, m, TCG_TYPE_VA);
 }
 
 QEMU_ARG_NONNULL static inline void
@@ -49,7 +49,7 @@ tcg_gen_qemu_ld_i64(TCGv_i64 v, TCGv_va a, TCGArg i, MemOp m)
 QEMU_ARG_NONNULL static inline void
 tcg_gen_qemu_st_i64(TCGv_i64 v, TCGv_va a, TCGArg i, MemOp m)
 {
-    tcg_gen_qemu_st_i64_chk(v, tcgv_va_temp(a), i, m, TCG_TYPE_VA);
+    tcg_gen_qemu_st_chk_i64(v, tcgv_va_temp(a), i, m, TCG_TYPE_VA);
 }
 
 QEMU_ARG_NONNULL static inline void
@@ -61,7 +61,7 @@ tcg_gen_qemu_ld_i128(TCGv_i128 v, TCGv_va a, TCGArg i, MemOp m)
 QEMU_ARG_NONNULL static inline void
 tcg_gen_qemu_st_i128(TCGv_i128 v, TCGv_va a, TCGArg i, MemOp m)
 {
-    tcg_gen_qemu_st_i128_chk(v, tcgv_va_temp(a), i, m, TCG_TYPE_VA);
+    tcg_gen_qemu_st_chk_i128(v, tcgv_va_temp(a), i, m, TCG_TYPE_VA);
 }
 
 #define DEF_ATOMIC2(N, S)                                               \
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index e2da3ddef6..552f62b7f4 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -54,6 +54,7 @@ DEF3(or, TCGV, TCGV, TCGV)
 DEF3(ori, TCGV, TCGV, TINT)
 DEF3(orc, TCGV, TCGV, TCGV)
 DEF5(qemu_ld_chk, TCGV, TCGTempPtr, unsigned, MemOp, TCGType)
+DEF5(qemu_st_chk, TCGV, TCGTempPtr, unsigned, MemOp, TCGType)
 DEF3(rem, TCGV, TCGV, TCGV)
 DEF3(remu, TCGV, TCGV, TCGV)
 DEF2(revbit8, TCGV, TCGV)
diff --git a/tcg/tcg-op-ldst.c b/tcg/tcg-op-ldst.c
index e67beb7586..9f8813658f 100644
--- a/tcg/tcg-op-ldst.c
+++ b/tcg/tcg-op-ldst.c
@@ -206,24 +206,6 @@ plugin_gen_mem_callbacks_tmp(TCGType type, TCGTemp *val,
 #endif
 }
 
-static void
-plugin_gen_mem_callbacks_i32(TCGv_i32 val,
-                             TCGv_i64 copy_addr, TCGTemp *orig_addr,
-                             MemOpIdx oi, enum qemu_plugin_mem_rw rw)
-{
-    plugin_gen_mem_callbacks_tmp(TCG_TYPE_I32, tcgv_i32_temp(val), copy_addr,
-                                 orig_addr, oi, rw);
-}
-
-static void
-plugin_gen_mem_callbacks_i64(TCGv_i64 val,
-                             TCGv_i64 copy_addr, TCGTemp *orig_addr,
-                             MemOpIdx oi, enum qemu_plugin_mem_rw rw)
-{
-    plugin_gen_mem_callbacks_tmp(TCG_TYPE_I64, tcgv_i64_temp(val), copy_addr,
-                                 orig_addr, oi, rw);
-}
-
 static void
 plugin_gen_mem_callbacks_i128(TCGv_i128 val,
                              TCGv_i64 copy_addr, TCGTemp *orig_addr,
@@ -310,99 +292,43 @@ void tcg_gen_qemu_ld_chk(TCGType val_type, TCGTemp *val, TCGTemp *addr,
     tcg_gen_qemu_ld_int(val_type, val, addr, idx, memop);
 }
 
-static void tcg_gen_qemu_st_i32_int(TCGv_i32 orig_val, TCGTemp *addr,
-                                    TCGArg idx, MemOp memop)
+static void tcg_gen_qemu_st_int(TCGType type, TCGTemp *orig_val,
+                                TCGTemp *addr, unsigned idx, MemOp memop)
 {
-    TCGv_i32 val = orig_val;
+    TCGTemp *val = orig_val;
     MemOpIdx orig_oi, oi;
     TCGTemp *addr_new;
 
     tcg_gen_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
-    memop = tcg_canonicalize_memop(memop, 0, 1);
+    memop = tcg_canonicalize_memop(memop, type != TCG_TYPE_I32, 1);
     orig_oi = oi = make_memop_idx(memop, idx);
 
     if ((memop & MO_BSWAP) && !tcg_target_has_memory_bswap(memop)) {
-        val = tcg_temp_ebb_new_i32();
-        switch (memop & MO_SIZE) {
-        case MO_16:
-            tcg_gen_bswap16_i32(val, orig_val, 0);
-            break;
-        case MO_32:
-            tcg_gen_bswap32_i32(val, orig_val);
-            break;
-        default:
-            g_assert_not_reached();
-        }
+        val = tcg_temp_new_ebb(type);
+        tcg_gen_bswap(type, val, orig_val, 0, memop);
         memop &= ~MO_BSWAP;
         oi = make_memop_idx(memop, idx);
     }
 
     addr_new = tci_extend_addr(addr);
-    gen_ldst1(INDEX_op_qemu_st, TCG_TYPE_I32, tcgv_i32_temp(val), addr_new, oi);
-    plugin_gen_mem_callbacks_i32(orig_val, NULL, addr, orig_oi,
-                                 QEMU_PLUGIN_MEM_W);
+    tcg_gen_op_tti(INDEX_op_qemu_st, type, val, addr_new, oi);
+    plugin_gen_mem_callbacks_tmp(type, orig_val, NULL, addr,
+                                 orig_oi, QEMU_PLUGIN_MEM_W);
     maybe_free_addr(addr, addr_new);
 
     if (val != orig_val) {
-        tcg_temp_free_i32(val);
+        tcg_temp_free_internal(val);
     }
 }
 
-void tcg_gen_qemu_st_i32_chk(TCGv_i32 val, TCGTemp *addr, TCGArg idx,
-                             MemOp memop, TCGType addr_type)
+void tcg_gen_qemu_st_chk(TCGType val_type, TCGTemp *val, TCGTemp *addr,
+                         unsigned idx, MemOp memop, TCGType addr_type)
 {
     tcg_debug_assert(addr_type == tcg_ctx->addr_type);
-    tcg_debug_assert((memop & MO_SIZE) <= MO_32);
-    tcg_gen_qemu_st_i32_int(val, addr, idx, memop);
-}
+    tcg_debug_assert(memop_size(memop) <= tcg_type_size(val_type));
+    tcg_debug_assert(idx < NB_MMU_MODES);
 
-static void tcg_gen_qemu_st_i64_int(TCGv_i64 orig_val, TCGTemp *addr,
-                                    TCGArg idx, MemOp memop)
-{
-    TCGv_i64 val = orig_val;
-    MemOpIdx orig_oi, oi;
-    TCGTemp *addr_new;
-
-    tcg_gen_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
-    memop = tcg_canonicalize_memop(memop, 1, 1);
-    orig_oi = oi = make_memop_idx(memop, idx);
-
-    if ((memop & MO_BSWAP) && !tcg_target_has_memory_bswap(memop)) {
-        val = tcg_temp_ebb_new_i64();
-        switch (memop & MO_SIZE) {
-        case MO_16:
-            tcg_gen_bswap16_i64(val, orig_val, 0);
-            break;
-        case MO_32:
-            tcg_gen_bswap32_i64(val, orig_val, 0);
-            break;
-        case MO_64:
-            tcg_gen_bswap64_i64(val, orig_val);
-            break;
-        default:
-            g_assert_not_reached();
-        }
-        memop &= ~MO_BSWAP;
-        oi = make_memop_idx(memop, idx);
-    }
-
-    addr_new = tci_extend_addr(addr);
-    gen_st_i64(val, addr_new, oi);
-    plugin_gen_mem_callbacks_i64(orig_val, NULL, addr, orig_oi,
-                                 QEMU_PLUGIN_MEM_W);
-    maybe_free_addr(addr, addr_new);
-
-    if (val != orig_val) {
-        tcg_temp_free_i64(val);
-    }
-}
-
-void tcg_gen_qemu_st_i64_chk(TCGv_i64 val, TCGTemp *addr, TCGArg idx,
-                             MemOp memop, TCGType addr_type)
-{
-    tcg_debug_assert(addr_type == tcg_ctx->addr_type);
-    tcg_debug_assert((memop & MO_SIZE) <= MO_64);
-    tcg_gen_qemu_st_i64_int(val, addr, idx, memop);
+    tcg_gen_qemu_st_int(val_type, val, addr, idx, memop);
 }
 
 /*
@@ -713,7 +639,7 @@ static void tcg_gen_qemu_st_i128_int(TCGv_i128 val, TCGTemp *addr,
                                   QEMU_PLUGIN_MEM_W);
 }
 
-void tcg_gen_qemu_st_i128_chk(TCGv_i128 val, TCGTemp *addr, TCGArg idx,
+void tcg_gen_qemu_st_chk_i128(TCGv_i128 val, TCGTemp *addr, TCGArg idx,
                               MemOp memop, TCGType addr_type)
 {
     tcg_debug_assert(addr_type == tcg_ctx->addr_type);
@@ -765,7 +691,7 @@ static void tcg_gen_nonatomic_cmpxchg_i32_int(TCGv_i32 retv, TCGTemp *addr,
     tcg_gen_qemu_ld_int(TCG_TYPE_I32, tcgv_i32_temp(t1),
                         addr, idx, memop & ~MO_SIGN);
     tcg_gen_movcond_i32(TCG_COND_EQ, t2, t1, t2, newv, t1);
-    tcg_gen_qemu_st_i32_int(t2, addr, idx, memop);
+    tcg_gen_qemu_st_int(TCG_TYPE_I32, tcgv_i32_temp(t2), addr, idx, memop);
     tcg_temp_free_i32(t2);
 
     if (memop & MO_SIGN) {
@@ -837,7 +763,7 @@ static void tcg_gen_nonatomic_cmpxchg_i64_int(TCGv_i64 retv, TCGTemp *addr,
     tcg_gen_qemu_ld_int(TCG_TYPE_I64, tcgv_i64_temp(t1),
                         addr, idx, memop & ~MO_SIGN);
     tcg_gen_movcond_i64(TCG_COND_EQ, t2, t1, t2, newv, t1);
-    tcg_gen_qemu_st_i64_int(t2, addr, idx, memop);
+    tcg_gen_qemu_st_int(TCG_TYPE_I64, tcgv_i64_temp(t2), addr, idx, memop);
     tcg_temp_free_i64(t2);
 
     if (memop & MO_SIGN) {
@@ -1014,7 +940,7 @@ static void do_nonatomic_op_i32(TCGv_i32 ret, TCGTemp *addr, TCGv_i32 val,
     tcg_gen_qemu_ld_int(TCG_TYPE_I32, tcgv_i32_temp(t1), addr, idx, memop);
     tcg_gen_ext_i32(t2, val, memop);
     gen(t2, t1, t2);
-    tcg_gen_qemu_st_i32_int(t2, addr, idx, memop);
+    tcg_gen_qemu_st_int(TCG_TYPE_I32, tcgv_i32_temp(t2), addr, idx, memop);
 
     tcg_gen_ext_i32(ret, (new_val ? t2 : t1), memop);
     tcg_temp_free_i32(t1);
@@ -1055,7 +981,7 @@ static void do_nonatomic_op_i64(TCGv_i64 ret, TCGTemp *addr, TCGv_i64 val,
     tcg_gen_qemu_ld_int(TCG_TYPE_I64, tcgv_i64_temp(t1), addr, idx, memop);
     tcg_gen_ext_i64(t2, val, memop);
     gen(t2, t1, t2);
-    tcg_gen_qemu_st_i64_int(t2, addr, idx, memop);
+    tcg_gen_qemu_st_int(TCG_TYPE_I64, tcgv_i64_temp(t2), addr, idx, memop);
 
     tcg_gen_ext_i64(ret, (new_val ? t2 : t1), memop);
     tcg_temp_free_i64(t1);
-- 
2.53.0


