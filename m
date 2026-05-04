Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0184CFF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 15:52:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJva1-00012T-61; Mon, 04 May 2026 11:51:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1wJvZv-0000zQ-0U
 for qemu-devel@nongnu.org; Mon, 04 May 2026 11:51:27 -0400
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1wJvZs-0006EL-JL
 for qemu-devel@nongnu.org; Mon, 04 May 2026 11:51:26 -0400
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-50e5c5033f6so33802431cf.0
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 08:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777909883; x=1778514683; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TiVrbOZjjCigVoL27lZtXMqa7artce6mU8ZEiumQQSg=;
 b=I2iE0NItZpU+Mr7L9ibWWwmGRmRiY27juwbh0hMzZaA/Em5bby2Crh6RJApb0t2a9C
 To/Paj/tW3iISoBS8LYRVDhNR8y6mzoWi2euR+iBNJV5Y3Lqpfu8pli+i2E7UIryDc+c
 zlB+6l2A/Psqpu+QuyzapbKuKT2L1yrNSiIuCy2u0SWmuhjGQW2x6ObRzRO52sk6Rmct
 7nEV4H5ELmkudbuUn6hIxCRwmvwT2bwEFGPPYiM4/nsV6miuCtepG+q6r9zN7iVWAV/Z
 sMEtX5fg0CFxJEIeLoz2iiDiAC7lXfCtJXGGWaXdHXaVWSGmLdZMbrfPVoJUu29b4QxE
 Ac0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777909883; x=1778514683;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=TiVrbOZjjCigVoL27lZtXMqa7artce6mU8ZEiumQQSg=;
 b=HG58pI+b8jk4AYfazaR8M5uZH1DHHIeUQFaJJk0lMRvSeKMR8K83NGc8E0xJXgssGQ
 Ypfs2gNt637K4BkcHD8oSa2dDOWxPaIQbnd8eGA0WIDLsxAJsyxmegJYN/jomybz8+Bm
 0x/Ya0tDTxy/5XleXCgiooSTcQhc3rgffUZ2PUHn+zk4k+LJ5zTgEZ75y7d4sSEt2nN8
 rEuAH/8dtvctNId8E0BloAxekNH9k0BGlSQB+GUwyPH7H6HdlL6gfA+4EGVhf3PgiT38
 Ohdjaaa26eNtEz1wInof6Hd5ekS2aHwTOFyXC+uk56eFNza52PAWtXEf7LFzSzDw/Ph9
 p6kA==
X-Gm-Message-State: AOJu0YzUcyWIUxuvVBJvVxdeJntHG/4u5buncqn4zIM1ETGRe4bC2YyP
 ky7emQCCEwfN7UvB+V+sjV3uzA2UgciKUC50DkeAXQB0yzp+EVz1HBLb
X-Gm-Gg: AeBDievo6QmmP9uYxEX9qll+c2906BXSSQbDviILob7MnlgxzEI2k3FHTC90vRsaZ2Z
 fsbCfkCMhKE/BhELWeP9IbzMIoGa5fDTx4kMyabjQ5edQpwp6PT04OeJpRRYeON/lugktkWrkP7
 uMMEJUHLRXw5C9cxg6IY6uV3blaDdP+UTM3HbF1R4AcN9xnBCGXkIjcSp5Vr3FwzoF7keTgun2O
 Xd345qK9dzU1WZjOPVHGUhWPShcZwKNhzD8qmMBgORVNgKuVj6o29EsDuB9yVsvP1yb1qZ0AwQA
 5eo+zYYBJgv7okxsdukkQlTemusW8UrmCN9jlBcKGU+zaeEESlsI4BzzKbinDYPv8i9xC1sw4pS
 uS4Ru4GCbT3y3HGJUu2CHg/AWSJmAmIbfCuVC3aCxhfr+orPTIyg5Px4b+M1oiFP8zBF4D1ZS6z
 Y2tYxMu8l6PpghMWwhbkWXA4XNsojK3BkzRHY5Q7jclhEV3KaZoBg=
X-Received: by 2002:a05:622a:201:b0:50d:84a7:72d0 with SMTP id
 d75a77b69052e-5104bf7adbemr152565081cf.36.1777909883302; 
 Mon, 04 May 2026 08:51:23 -0700 (PDT)
Received: from [192.168.1.164] ([2600:1009:a021:c665:5296:905f:3e4a:eb90])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51040931552sm99599011cf.12.2026.05.04.08.51.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 08:51:22 -0700 (PDT)
From: Gabriel Brookman <brookmangabriel@gmail.com>
Date: Mon, 04 May 2026 11:50:43 -0400
Subject: [PATCH v5 10/15] target/arm: fault on tag store to canonical tag
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-feat-mte4-v5-10-232a648e63c6@gmail.com>
References: <20260504-feat-mte4-v5-0-232a648e63c6@gmail.com>
In-Reply-To: <20260504-feat-mte4-v5-0-232a648e63c6@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, 
 Gabriel Brookman <brookmangabriel@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777909867; l=11299;
 i=brookmangabriel@gmail.com; s=20251009; h=from:subject:message-id;
 bh=aYIMM7VEzYa/cnI4zU8L0nd+u7JcOWA7N9KPcn8AdK4=;
 b=lLShDTqRAufOQmsE/EniKdWTjbF9bkdym1vepOMsiqR0sLekNNJfHQcrm8MtEI7tRMhgPN4T7
 Rwxx24qISGfDkBvfZ6O+qg+Zn5oJXQYSk7w0gABM//wKLMJvv56zxk9
X-Developer-Key: i=brookmangabriel@gmail.com; a=ed25519;
 pk=m9TtPDal6WzoHNnQiHHKf8dTrv3DUCPUUTujuo8vNrw=
Received-SPF: pass client-ip=2607:f8b0:4864:20::82b;
 envelope-from=brookmangabriel@gmail.com; helo=mail-qt1-x82b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

According to ARM ARM, section "Memory region tagging types", tag-store
instructions targeting canonically tagged regions cause a stage 1
permission fault with MTX enabled.

Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
---
 target/arm/tcg/helper-a64-defs.h | 12 ++++-----
 target/arm/tcg/mte_helper.c      | 57 +++++++++++++++++++++++++++++++---------
 target/arm/tcg/translate-a64.c   | 26 +++++++++++-------
 3 files changed, 67 insertions(+), 28 deletions(-)

diff --git a/target/arm/tcg/helper-a64-defs.h b/target/arm/tcg/helper-a64-defs.h
index c08c8c3991..136d246a68 100644
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
 
 DEF_HELPER_FLAGS_4(unaligned_access, TCG_CALL_NO_WG,
                    noreturn, env, i64, i32, i32)
diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index 8ed31ca2d8..ad5cdd558e 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -231,6 +231,20 @@ uint8_t *allocation_tag_mem_probe(CPUARMState *env, int ptr_mmu_idx,
 #endif
 }
 
+static void canonical_tag_write_fail(CPUARMState *env,
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
+    g_assert_not_reached();
+}
+
 static uint8_t *allocation_tag_mem(CPUARMState *env, int ptr_mmu_idx,
                                    uint64_t ptr, MMUAccessType ptr_access,
                                    int ptr_size, MMUAccessType tag_access,
@@ -362,7 +376,7 @@ static void store_tag1_parallel(uint64_t ptr, uint8_t *mem, int tag)
 typedef void stg_store1(uint64_t, uint8_t *, int);
 
 static inline void do_stg(CPUARMState *env, uint64_t ptr, uint64_t xt,
-                          uintptr_t ra, stg_store1 store1)
+                          uint32_t mtx, uintptr_t ra, stg_store1 store1)
 {
     int mmu_idx = arm_env_mmu_index(env);
     uint8_t *mem;
@@ -376,17 +390,20 @@ static inline void do_stg(CPUARMState *env, uint64_t ptr, uint64_t xt,
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
@@ -399,7 +416,7 @@ void HELPER(stg_stub)(CPUARMState *env, uint64_t ptr)
 }
 
 static inline void do_st2g(CPUARMState *env, uint64_t ptr, uint64_t xt,
-                           uintptr_t ra, stg_store1 store1)
+                           uint32_t mtx, uintptr_t ra, stg_store1 store1)
 {
     int mmu_idx = arm_env_mmu_index(env);
     int tag = allocation_tag_from_addr(xt);
@@ -422,9 +439,13 @@ static inline void do_st2g(CPUARMState *env, uint64_t ptr, uint64_t xt,
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
@@ -433,18 +454,23 @@ static inline void do_st2g(CPUARMState *env, uint64_t ptr, uint64_t xt,
         if (mem1) {
             tag |= tag << 4;
             qatomic_set(mem1, tag);
+        } else if (mtx) {
+            /* Writing tags to canonically tagged memory region: faults */
+            canonical_tag_write_fail(env, ptr, ra);
+            return;
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
@@ -554,7 +580,7 @@ uint64_t HELPER(ldgm)(CPUARMState *env, uint64_t ptr, uint32_t mtx)
     return ret << shift;
 }
 
-void HELPER(stgm)(CPUARMState *env, uint64_t ptr, uint64_t val)
+void HELPER(stgm)(CPUARMState *env, uint64_t ptr, uint64_t val, uint32_t mtx)
 {
     int mmu_idx = arm_env_mmu_index(env);
     uintptr_t ra = GETPC();
@@ -574,6 +600,10 @@ void HELPER(stgm)(CPUARMState *env, uint64_t ptr, uint64_t val)
      * and if the OS has enabled access to the tags.
      */
     if (!tag_mem) {
+        /* Storing tags to canonically tagged region: fault. */
+        if (mtx) {
+            canonical_tag_write_fail(env, ptr, ra);
+        }
         return;
     }
 
@@ -603,7 +633,8 @@ void HELPER(stgm)(CPUARMState *env, uint64_t ptr, uint64_t val)
     }
 }
 
-void HELPER(stzgm_tags)(CPUARMState *env, uint64_t ptr, uint64_t val)
+void HELPER(stzgm_tags)(CPUARMState *env, uint64_t ptr, uint64_t val,
+                        uint32_t mtx)
 {
     uintptr_t ra = GETPC();
     int mmu_idx = arm_env_mmu_index(env);
@@ -627,6 +658,8 @@ void HELPER(stzgm_tags)(CPUARMState *env, uint64_t ptr, uint64_t val)
     if (mem) {
         int tag_pair = (val & 0xf) * 0x11;
         memset(mem, tag_pair, tag_bytes);
+    } else if (mtx) {
+        canonical_tag_write_fail(env, ptr, ra);
     }
 }
 
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 5fbc54de4b..68f476621a 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -3031,7 +3031,8 @@ static void handle_sys(DisasContext *s, bool isread,
                 /* Extract the tag from the register to match STZGM.  */
                 tag = tcg_temp_new_i64();
                 tcg_gen_shri_i64(tag, tcg_rt, 56);
-                gen_helper_stzgm_tags(tcg_env, clean_addr, tag);
+                gen_helper_stzgm_tags(tcg_env, clean_addr, tag,
+                                      tcg_constant_i32(s->mtx));
             }
         }
         return;
@@ -3048,7 +3049,8 @@ static void handle_sys(DisasContext *s, bool isread,
                 /* Extract the tag from the register to match STZGM.  */
                 tag = tcg_temp_new_i64();
                 tcg_gen_shri_i64(tag, tcg_rt, 56);
-                gen_helper_stzgm_tags(tcg_env, clean_addr, tag);
+                gen_helper_stzgm_tags(tcg_env, clean_addr, tag,
+                                      tcg_constant_i32(s->mtx));
             }
         }
         return;
@@ -3865,9 +3867,11 @@ static bool trans_STGP(DisasContext *s, arg_ldstpair *a)
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
 
@@ -4647,7 +4651,7 @@ static bool trans_STZGM(DisasContext *s, arg_ldst_tag *a)
     tcg_rt = cpu_reg(s, a->rt);
 
     if (s->ata[0]) {
-        gen_helper_stzgm_tags(tcg_env, addr, tcg_rt);
+        gen_helper_stzgm_tags(tcg_env, addr, tcg_rt, tcg_constant_i32(s->mtx));
     }
     /*
      * The non-tags portion of STZGM is mostly like DC_ZVA,
@@ -4679,7 +4683,7 @@ static bool trans_STGM(DisasContext *s, arg_ldst_tag *a)
     tcg_rt = cpu_reg(s, a->rt);
 
     if (s->ata[0]) {
-        gen_helper_stgm(tcg_env, addr, tcg_rt);
+        gen_helper_stgm(tcg_env, addr, tcg_rt, tcg_constant_i32(s->mtx));
     } else {
         MMUAccessType acc = MMU_DATA_STORE;
         int size = 4 << s->gm_blocksize;
@@ -4795,15 +4799,17 @@ static bool do_STG(DisasContext *s, arg_ldst_tag *a, bool is_zero, bool is_pair)
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
2.54.0


