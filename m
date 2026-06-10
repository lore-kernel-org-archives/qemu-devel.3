Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B033ACD8CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:13:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXLXw-0008Qr-D7; Wed, 10 Jun 2026 12:12:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLXT-0007fn-Bf
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:12:25 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLXQ-0005UT-Vf
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:12:23 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-490b8ac62baso291405e9.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 09:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781107939; x=1781712739; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nkrgzvMtXthZQ5i83VCq0e/OsBHmqevvgm5pAGmepkg=;
 b=L0EjylFXbdOJ7d9jXQbKjqeDnvt039j5ixJnnK5FMXeGFm76v7WFFIU1mXvsx0TSGH
 /G+Ib1u03fHVg8PUceWKpUV0XrSh0iqlhd6nelxa5ljfaqbi2LH9lx3TUFhkW5GTO8DX
 hYem9EI7LNo4xOoY4aRpkyFZSttbTV/wEMHFeHcQOUZVI23O4Q/wq7/OFGKEYEwLesjy
 09FycsyIspVc/5MGh+iy+ZEmerBtmVWx7PXQ84atORegCaEBTj/O++QG+Wj9cawa6g0e
 Om0OyAwNWAch6r8NDry9c5NPzgP8Hu3MTx1mVpsobdA1gHSlqaM+l/ixUpO30Vanzvdl
 OfzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781107939; x=1781712739;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nkrgzvMtXthZQ5i83VCq0e/OsBHmqevvgm5pAGmepkg=;
 b=X+LGfKMOEpiE0qPZBhuWKLBiMXrJnqprA+d+mDwNBh8Lk0koJu+1RqwnuiH+0q8EcE
 H9+5kk0LFh3nqnJNTBJ9+o/tIs1GcIj0V+ZsAWqgFnR8Pnt6I2WUDNVpSX0hBBYcJO/C
 9ueMwMOoJQ2jh0nlVwZ81RWXMeFgw949M2IJ02GXpGY4Qr0WbzEGgODzb3JOcDZKtg/E
 WHY41iJqxGtQOKdg7GrNZETSRGfLNDcNZAV6rtU1bhBxt2yqF+R1taXJOka515O+5e05
 diDHp7R8UeQQEfnDa2GvO53a3TOddP49FOeLqbjXvQoMMt9HsDt8X+7R35KxgiUdpsFB
 yO6A==
X-Gm-Message-State: AOJu0YyMxtdOvoSujbR1DxWKWKngaT2c5Wxfk6SzWwlFmSgblMby/H3y
 k9qkKrQ5UB/FDqwVHcJzylauRsd7XLSbr7SuADjBmLNGznLVndoQfI2tV70btjdEFhoccs47y/n
 Nn7Kj
X-Gm-Gg: Acq92OGC5KteSADrN51wkZmMzv6EpbPOqRLZNLmBeFD2GX5tZNZ9g2M5q+v/cysgvx9
 xipTkmKZBg2Y228u8sdr8XNc9YtJ6DnTl86Y/GSW2VrWD2fOcJaVg5b76qWoNiwQInlYR47L1IJ
 8uacNl+Y8wyKZXI2k4gsd2FhLuOWLzrKXK1DleqKRPrdPJvtKXrr+hewC9HyDcAVYaNTkwgjGah
 3G0+CIQ1gp7Xg2aVvu5jr8Wx6X/O7ajQ/sfVAunEpL5pfjDhcDX3se+uKhDcNBgY7kcivbPr2GW
 Un9BaHY4jiZqLNbAqhSMmb7rxC5Zy4ZWScsMiT5LPsX+p+uqRk/tq9tBWvBXCOhE57YntP+WTrk
 79W9Sb3ZP6nuM1Q6BFZEQrA4TOaYsiN8zSXN21c83dc22Skt4doetHXSQ5dro+cyHPjYJkhlN6s
 ZP95aHxSQd8tzsBiY/EJNEQrM/xO3Tf8eDeUxxsQduUeqpSN4Yg1a1MZfa2VJn5K6UHRR5rndtu
 cXcSlnAZrsh9mpVgWlV0cHAxrYFj7ex8WjvRcdjfoo=
X-Received: by 2002:a05:6000:420e:b0:460:58ee:d634 with SMTP id
 ffacd0b85a97d-46058eed666mr8346320f8f.4.1781107939339; 
 Wed, 10 Jun 2026 09:12:19 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcbe3sm67911360f8f.8.2026.06.10.09.12.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 09:12:18 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/71] target/arm: fault on tag store to canonical tag
Date: Wed, 10 Jun 2026 17:11:02 +0100
Message-ID: <20260610161202.2235298-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610161202.2235298-1-peter.maydell@linaro.org>
References: <20260610161202.2235298-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

From: Gabriel Brookman <brookmangabriel@gmail.com>

According to ARM ARM, section "Memory region tagging types", tag-store
instructions targeting canonically tagged regions cause a stage 1
permission fault with MTX enabled.

Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260529-feat-mte4-v7-10-ccbd3c14eb3c@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper-a64-defs.h | 12 +++----
 target/arm/tcg/mte_helper.c      | 55 +++++++++++++++++++++++++-------
 target/arm/tcg/translate-a64.c   | 26 +++++++++------
 3 files changed, 65 insertions(+), 28 deletions(-)

diff --git a/target/arm/tcg/helper-a64-defs.h b/target/arm/tcg/helper-a64-defs.h
index c268b8c3cc..0e56e00f45 100644
--- a/target/arm/tcg/helper-a64-defs.h
+++ b/target/arm/tcg/helper-a64-defs.h
@@ -103,15 +103,15 @@ DEF_HELPER_FLAGS_3(mte_check_zva, TCG_CALL_NO_WG, i64, env, i32, i64)
 DEF_HELPER_FLAGS_3(irg, TCG_CALL_NO_RWG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_4(addsubg, TCG_CALL_NO_RWG_SE, i64, env, i64, s32, i32)
 DEF_HELPER_FLAGS_4(ldg, TCG_CALL_NO_WG, i64, env, i64, i64, i32)
-DEF_HELPER_FLAGS_3(stg, TCG_CALL_NO_WG, void, env, i64, i64)
-DEF_HELPER_FLAGS_3(stg_parallel, TCG_CALL_NO_WG, void, env, i64, i64)
+DEF_HELPER_FLAGS_4(stg, TCG_CALL_NO_WG, void, env, i64, i64, i32)
+DEF_HELPER_FLAGS_4(stg_parallel, TCG_CALL_NO_WG, void, env, i64, i64, i32)
 DEF_HELPER_FLAGS_2(stg_stub, TCG_CALL_NO_WG, void, env, i64)
-DEF_HELPER_FLAGS_3(st2g, TCG_CALL_NO_WG, void, env, i64, i64)
-DEF_HELPER_FLAGS_3(st2g_parallel, TCG_CALL_NO_WG, void, env, i64, i64)
+DEF_HELPER_FLAGS_4(st2g, TCG_CALL_NO_WG, void, env, i64, i64, i32)
+DEF_HELPER_FLAGS_4(st2g_parallel, TCG_CALL_NO_WG, void, env, i64, i64, i32)
 DEF_HELPER_FLAGS_2(st2g_stub, TCG_CALL_NO_WG, void, env, i64)
 DEF_HELPER_FLAGS_3(ldgm, TCG_CALL_NO_WG, i64, env, i64, i32)
-DEF_HELPER_FLAGS_3(stgm, TCG_CALL_NO_WG, void, env, i64, i64)
-DEF_HELPER_FLAGS_3(stzgm_tags, TCG_CALL_NO_WG, void, env, i64, i64)
+DEF_HELPER_FLAGS_4(stgm, TCG_CALL_NO_WG, void, env, i64, i64, i32)
+DEF_HELPER_FLAGS_4(stzgm_tags, TCG_CALL_NO_WG, void, env, i64, i64, i32)
 
 DEF_HELPER_FLAGS_4(arm_unaligned_access, TCG_CALL_NO_WG,
                    noreturn, env, i64, i32, i32)
diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index c382f0149f..dca4ef5a94 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -231,6 +231,19 @@ uint8_t *allocation_tag_mem_probe(CPUARMState *env, int ptr_mmu_idx,
 #endif
 }
 
+static G_NORETURN void canonical_tag_write_fail(CPUARMState *env,
+                                     uint64_t dirty_ptr, uintptr_t ra)
+{
+    uint64_t syn;
+
+    env->exception.vaddress = dirty_ptr;
+
+    syn = syn_data_abort_no_iss(arm_current_el(env) != 0, 0, 0, 0, 0, 1, 0);
+    syn |= BIT_ULL(42); /* TnD is bit 42 */
+
+    raise_exception_ra(env, EXCP_DATA_ABORT, syn, exception_target_el(env), ra);
+}
+
 static uint8_t *allocation_tag_mem(CPUARMState *env, int ptr_mmu_idx,
                                    uint64_t ptr, MMUAccessType ptr_access,
                                    int ptr_size, MMUAccessType tag_access,
@@ -360,7 +373,7 @@ static void store_tag1_parallel(uint64_t ptr, uint8_t *mem, int tag)
 typedef void stg_store1(uint64_t, uint8_t *, int);
 
 static inline void do_stg(CPUARMState *env, uint64_t ptr, uint64_t xt,
-                          uintptr_t ra, stg_store1 store1)
+                          uint32_t mtx, uintptr_t ra, stg_store1 store1)
 {
     int mmu_idx = arm_env_mmu_index(env);
     uint8_t *mem;
@@ -374,17 +387,20 @@ static inline void do_stg(CPUARMState *env, uint64_t ptr, uint64_t xt,
     /* Store if page supports tags. */
     if (mem) {
         store1(ptr, mem, allocation_tag_from_addr(xt));
+    } else if (mtx) {
+        canonical_tag_write_fail(env, ptr, ra);
     }
 }
 
-void HELPER(stg)(CPUARMState *env, uint64_t ptr, uint64_t xt)
+void HELPER(stg)(CPUARMState *env, uint64_t ptr, uint64_t xt, uint32_t mtx)
 {
-    do_stg(env, ptr, xt, GETPC(), store_tag1);
+    do_stg(env, ptr, xt, mtx, GETPC(), store_tag1);
 }
 
-void HELPER(stg_parallel)(CPUARMState *env, uint64_t ptr, uint64_t xt)
+void HELPER(stg_parallel)(CPUARMState *env, uint64_t ptr, uint64_t xt,
+                          uint32_t mtx)
 {
-    do_stg(env, ptr, xt, GETPC(), store_tag1_parallel);
+    do_stg(env, ptr, xt, mtx, GETPC(), store_tag1_parallel);
 }
 
 void HELPER(stg_stub)(CPUARMState *env, uint64_t ptr)
@@ -397,7 +413,7 @@ void HELPER(stg_stub)(CPUARMState *env, uint64_t ptr)
 }
 
 static inline void do_st2g(CPUARMState *env, uint64_t ptr, uint64_t xt,
-                           uintptr_t ra, stg_store1 store1)
+                           uint32_t mtx, uintptr_t ra, stg_store1 store1)
 {
     int mmu_idx = arm_env_mmu_index(env);
     int tag = allocation_tag_from_addr(xt);
@@ -420,9 +436,13 @@ static inline void do_st2g(CPUARMState *env, uint64_t ptr, uint64_t xt,
         /* Store if page(s) support tags. */
         if (mem1) {
             store1(TAG_GRANULE, mem1, tag);
+        } else if (mtx) {
+            canonical_tag_write_fail(env, ptr, ra);
         }
         if (mem2) {
             store1(0, mem2, tag);
+        } else if (mtx) {
+            canonical_tag_write_fail(env, ptr + TAG_GRANULE, ra);
         }
     } else {
         /* Two stores aligned mod TAG_GRANULE*2 -- modify one byte. */
@@ -431,18 +451,22 @@ static inline void do_st2g(CPUARMState *env, uint64_t ptr, uint64_t xt,
         if (mem1) {
             tag |= tag << 4;
             qatomic_set(mem1, tag);
+        } else if (mtx) {
+            /* Writing tags to canonically tagged memory region: faults */
+            canonical_tag_write_fail(env, ptr, ra);
         }
     }
 }
 
-void HELPER(st2g)(CPUARMState *env, uint64_t ptr, uint64_t xt)
+void HELPER(st2g)(CPUARMState *env, uint64_t ptr, uint64_t xt, uint32_t mtx)
 {
-    do_st2g(env, ptr, xt, GETPC(), store_tag1);
+    do_st2g(env, ptr, xt, mtx, GETPC(), store_tag1);
 }
 
-void HELPER(st2g_parallel)(CPUARMState *env, uint64_t ptr, uint64_t xt)
+void HELPER(st2g_parallel)(CPUARMState *env, uint64_t ptr, uint64_t xt,
+                           uint32_t mtx)
 {
-    do_st2g(env, ptr, xt, GETPC(), store_tag1_parallel);
+    do_st2g(env, ptr, xt, mtx, GETPC(), store_tag1_parallel);
 }
 
 void HELPER(st2g_stub)(CPUARMState *env, uint64_t ptr)
@@ -528,7 +552,7 @@ uint64_t HELPER(ldgm)(CPUARMState *env, uint64_t ptr, uint32_t mtx)
     return ret << shift;
 }
 
-void HELPER(stgm)(CPUARMState *env, uint64_t ptr, uint64_t val)
+void HELPER(stgm)(CPUARMState *env, uint64_t ptr, uint64_t val, uint32_t mtx)
 {
     int mmu_idx = arm_env_mmu_index(env);
     uintptr_t ra = GETPC();
@@ -548,6 +572,10 @@ void HELPER(stgm)(CPUARMState *env, uint64_t ptr, uint64_t val)
      * and if the OS has enabled access to the tags.
      */
     if (!tag_mem) {
+        /* Storing tags to canonically tagged region: fault. */
+        if (mtx) {
+            canonical_tag_write_fail(env, ptr, ra);
+        }
         return;
     }
 
@@ -577,7 +605,8 @@ void HELPER(stgm)(CPUARMState *env, uint64_t ptr, uint64_t val)
     }
 }
 
-void HELPER(stzgm_tags)(CPUARMState *env, uint64_t ptr, uint64_t val)
+void HELPER(stzgm_tags)(CPUARMState *env, uint64_t ptr, uint64_t val,
+                        uint32_t mtx)
 {
     uintptr_t ra = GETPC();
     int mmu_idx = arm_env_mmu_index(env);
@@ -601,6 +630,8 @@ void HELPER(stzgm_tags)(CPUARMState *env, uint64_t ptr, uint64_t val)
     if (mem) {
         int tag_pair = (val & 0xf) * 0x11;
         memset(mem, tag_pair, tag_bytes);
+    } else if (mtx) {
+        canonical_tag_write_fail(env, ptr, ra);
     }
 }
 
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index c472917f05..092a979198 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -3121,7 +3121,8 @@ static void handle_sys(DisasContext *s, bool isread,
                 /* Extract the tag from the register to match STZGM.  */
                 tag = tcg_temp_new_i64();
                 tcg_gen_shri_i64(tag, tcg_rt, 56);
-                gen_helper_stzgm_tags(tcg_env, clean_addr, tag);
+                gen_helper_stzgm_tags(tcg_env, clean_addr, tag,
+                                      tcg_constant_i32(s->mtx));
             }
         }
         return;
@@ -3138,7 +3139,8 @@ static void handle_sys(DisasContext *s, bool isread,
                 /* Extract the tag from the register to match STZGM.  */
                 tag = tcg_temp_new_i64();
                 tcg_gen_shri_i64(tag, tcg_rt, 56);
-                gen_helper_stzgm_tags(tcg_env, clean_addr, tag);
+                gen_helper_stzgm_tags(tcg_env, clean_addr, tag,
+                                      tcg_constant_i32(s->mtx));
             }
         }
         return;
@@ -3955,9 +3957,11 @@ static bool trans_STGP(DisasContext *s, arg_ldstpair *a)
     /* Perform the tag store, if tag access enabled. */
     if (s->ata[0]) {
         if (tb_cflags(s->base.tb) & CF_PARALLEL) {
-            gen_helper_stg_parallel(tcg_env, dirty_addr, dirty_addr);
+            gen_helper_stg_parallel(tcg_env, dirty_addr, dirty_addr,
+                                    tcg_constant_i32(s->mtx));
         } else {
-            gen_helper_stg(tcg_env, dirty_addr, dirty_addr);
+            gen_helper_stg(tcg_env, dirty_addr, dirty_addr,
+                           tcg_constant_i32(s->mtx));
         }
     }
 
@@ -4737,7 +4741,7 @@ static bool trans_STZGM(DisasContext *s, arg_ldst_tag *a)
     tcg_rt = cpu_reg(s, a->rt);
 
     if (s->ata[0]) {
-        gen_helper_stzgm_tags(tcg_env, addr, tcg_rt);
+        gen_helper_stzgm_tags(tcg_env, addr, tcg_rt, tcg_constant_i32(s->mtx));
     }
     /*
      * The non-tags portion of STZGM is mostly like DC_ZVA,
@@ -4769,7 +4773,7 @@ static bool trans_STGM(DisasContext *s, arg_ldst_tag *a)
     tcg_rt = cpu_reg(s, a->rt);
 
     if (s->ata[0]) {
-        gen_helper_stgm(tcg_env, addr, tcg_rt);
+        gen_helper_stgm(tcg_env, addr, tcg_rt, tcg_constant_i32(s->mtx));
     } else {
         MMUAccessType acc = MMU_DATA_STORE;
         int size = 4 << s->gm_blocksize;
@@ -4885,15 +4889,17 @@ static bool do_STG(DisasContext *s, arg_ldst_tag *a, bool is_zero, bool is_pair)
         }
     } else if (tb_cflags(s->base.tb) & CF_PARALLEL) {
         if (is_pair) {
-            gen_helper_st2g_parallel(tcg_env, addr, tcg_rt);
+            gen_helper_st2g_parallel(tcg_env, addr, tcg_rt,
+                                     tcg_constant_i32(s->mtx));
         } else {
-            gen_helper_stg_parallel(tcg_env, addr, tcg_rt);
+            gen_helper_stg_parallel(tcg_env, addr, tcg_rt,
+                                    tcg_constant_i32(s->mtx));
         }
     } else {
         if (is_pair) {
-            gen_helper_st2g(tcg_env, addr, tcg_rt);
+            gen_helper_st2g(tcg_env, addr, tcg_rt, tcg_constant_i32(s->mtx));
         } else {
-            gen_helper_stg(tcg_env, addr, tcg_rt);
+            gen_helper_stg(tcg_env, addr, tcg_rt, tcg_constant_i32(s->mtx));
         }
     }
 
-- 
2.43.0


