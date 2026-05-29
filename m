Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC1DACD4F54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 19:53:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT3Gl-0005YP-Cf; Fri, 29 May 2026 15:53:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1wT3Gb-00053X-EJ
 for qemu-devel@nongnu.org; Fri, 29 May 2026 15:53:13 -0400
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1wT3GZ-0005b4-9e
 for qemu-devel@nongnu.org; Fri, 29 May 2026 15:53:13 -0400
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-69de16f5f79so1704453eaf.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 12:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780084389; x=1780689189; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3uOtwdatmeRlBBkbGde0Ch5zJnEnTZkD0jjTjy83AM8=;
 b=fIN6XIFB+MOsvcOQrjhXjrwWOjpenX8NXowkjsTz+IifnJMk7C3Vxv4eg7m4pAVNyr
 R2ipZwi/6iiJIwAEhO9nnFim1d2xRvzSBmU/TZDEsAYGSOeg4PAw0w6/fgLE/X3j07BW
 cOFC6qfl4zKYZmgJU3Oi7YcR4udUJzvkwx5xCXLxoVxu0gEBTSUCJY/Ipdr6IAm5gMmG
 9XjUWx6jJAeTog0wDR2b+V247Dk3AcjvIRM1fup+GVGT26GMY7JCjpZ7NI8cg8HizggR
 LsGNIKS/FnETR3PkUhXM39UKyKuO8ZqmbxzK9OWyJb4VJNi002ovfl6EaaYDBfD49Qlk
 zhbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780084389; x=1780689189;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3uOtwdatmeRlBBkbGde0Ch5zJnEnTZkD0jjTjy83AM8=;
 b=WcWtXyEs7Zl0Fx1CE9OAg4BPw9JMXyAFBAkIIGH9h+AuX0MpK+JmTHf7c+abT/lYJf
 D2Y1s+BW4UKdznXbkPv5NB7YDOyhhDdz0O6D4HDb4LQG5VP0Lycg9M3m1CSeM7M0RU+A
 le0VsCOcf+j6zZ7RXC5m7LSqvde2iW410fsHk+XHrmmDJDkZ9cyBFmU1QF6/WxZYQE2+
 tUvJ9CEi1hGnSO53kvVwcSbB601CLwwheIiywnZDwsH7fMdzpP1bfyU/wBZzZAdSlmMT
 VC1k7/hb9B2OR94M+W8smYwg+S63sVd1Z2RLpbY7x+O2T5k2hqCvoy37asWOAE+cvhro
 tL3w==
X-Gm-Message-State: AOJu0YxFzK4OzzIZ3fblaKuls36CS/Ayb61ueOfAVlfveSVwRPDnLial
 35TKrwdZTmKwp3tk1Jw8R8XGOPcYbaxh0gzYky8Tq7EpCm25jYPg1VMo
X-Gm-Gg: Acq92OG4aHZyih0JOgArNYMzmoCauNXsYIYhSG+7pecPZiF3gVadPmOrWsLfw/hhyS/
 44fPl+VGqQtZi9GX+hRMUq0R4wtxDKR2Fj0w2XeH4HOSbNB46Kcy8TFGNbAhacsynIv4Xt6Ecds
 4ww01gvneFehxveFxQ7wDGDo1TPFeIG/EjAdyNJp8cLg6BN3xzZFZd7JCKD0/zpTuxxxLn+o9oo
 y2TtRA0huMnI7y07Uch/WgYqtpCRCDQifYbSEJAeYu9b3hjNkggd9KmrV6PVWOP+h761UtqjeD8
 f6aFeb7PiZH+iIB8NQoTG337wkixNUXEdO1YqJs/oLvZ0ruq/TJVnWFA4NyyvajyUz7oPnOeObj
 /qiSMOw4E8hK1ktu3qNfRc8r2q8PeUg7o1wCSRfPymlb8sCwp2NBHdulzDWcndfeSIt7e2pz1aC
 +fqU9ofwd0u6V5OZGK/QkPtGGAEowiHqwTSY2DqhYDk1iMXnRAqMfmsw==
X-Received: by 2002:a05:6820:168c:b0:69e:1ef:7eb5 with SMTP id
 006d021491bc7-69e10382c1dmr331535eaf.38.1780084388949; 
 Fri, 29 May 2026 12:53:08 -0700 (PDT)
Received: from [10.21.163.79] ([146.74.94.63])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69e06587eecsm1626692eaf.0.2026.05.29.12.53.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 12:53:08 -0700 (PDT)
From: Gabriel Brookman <brookmangabriel@gmail.com>
Date: Fri, 29 May 2026 12:52:50 -0700
Subject: [PATCH v7 10/15] target/arm: fault on tag store to canonical tag
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-feat-mte4-v7-10-ccbd3c14eb3c@gmail.com>
References: <20260529-feat-mte4-v7-0-ccbd3c14eb3c@gmail.com>
In-Reply-To: <20260529-feat-mte4-v7-0-ccbd3c14eb3c@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, 
 Gabriel Brookman <brookmangabriel@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780084373; l=11322;
 i=brookmangabriel@gmail.com; s=20251009; h=from:subject:message-id;
 bh=bjx4rkGbaThabjT+6UMg0dO1cos2GSV78m3uYkm3+rg=;
 b=73LXh8abHivAiXkTzq+kbT2XpnoQmv+428uw4Y1xzi5pC+ec+T8oqjP7S36O1Jh5Li0VhLy0+
 NWxJLDZCqglCxaaM4aIQwXntCccDcyieTW0dvDl3uZaKMJobzDBoyJD
X-Developer-Key: i=brookmangabriel@gmail.com; a=ed25519;
 pk=m9TtPDal6WzoHNnQiHHKf8dTrv3DUCPUUTujuo8vNrw=
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=brookmangabriel@gmail.com; helo=mail-oo1-xc2a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-a64-defs.h | 12 ++++-----
 target/arm/tcg/mte_helper.c      | 55 +++++++++++++++++++++++++++++++---------
 target/arm/tcg/translate-a64.c   | 26 +++++++++++--------
 3 files changed, 65 insertions(+), 28 deletions(-)

diff --git a/target/arm/tcg/helper-a64-defs.h b/target/arm/tcg/helper-a64-defs.h
index c196c927f4..02ea317444 100644
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
index 852578aae1..c37d9d0623 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -3035,7 +3035,8 @@ static void handle_sys(DisasContext *s, bool isread,
                 /* Extract the tag from the register to match STZGM.  */
                 tag = tcg_temp_new_i64();
                 tcg_gen_shri_i64(tag, tcg_rt, 56);
-                gen_helper_stzgm_tags(tcg_env, clean_addr, tag);
+                gen_helper_stzgm_tags(tcg_env, clean_addr, tag,
+                                      tcg_constant_i32(s->mtx));
             }
         }
         return;
@@ -3052,7 +3053,8 @@ static void handle_sys(DisasContext *s, bool isread,
                 /* Extract the tag from the register to match STZGM.  */
                 tag = tcg_temp_new_i64();
                 tcg_gen_shri_i64(tag, tcg_rt, 56);
-                gen_helper_stzgm_tags(tcg_env, clean_addr, tag);
+                gen_helper_stzgm_tags(tcg_env, clean_addr, tag,
+                                      tcg_constant_i32(s->mtx));
             }
         }
         return;
@@ -3869,9 +3871,11 @@ static bool trans_STGP(DisasContext *s, arg_ldstpair *a)
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
 
@@ -4651,7 +4655,7 @@ static bool trans_STZGM(DisasContext *s, arg_ldst_tag *a)
     tcg_rt = cpu_reg(s, a->rt);
 
     if (s->ata[0]) {
-        gen_helper_stzgm_tags(tcg_env, addr, tcg_rt);
+        gen_helper_stzgm_tags(tcg_env, addr, tcg_rt, tcg_constant_i32(s->mtx));
     }
     /*
      * The non-tags portion of STZGM is mostly like DC_ZVA,
@@ -4683,7 +4687,7 @@ static bool trans_STGM(DisasContext *s, arg_ldst_tag *a)
     tcg_rt = cpu_reg(s, a->rt);
 
     if (s->ata[0]) {
-        gen_helper_stgm(tcg_env, addr, tcg_rt);
+        gen_helper_stgm(tcg_env, addr, tcg_rt, tcg_constant_i32(s->mtx));
     } else {
         MMUAccessType acc = MMU_DATA_STORE;
         int size = 4 << s->gm_blocksize;
@@ -4799,15 +4803,17 @@ static bool do_STG(DisasContext *s, arg_ldst_tag *a, bool is_zero, bool is_pair)
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


