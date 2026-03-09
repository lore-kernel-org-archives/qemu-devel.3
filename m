Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA7BAFCA199
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 22:02:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzier-00038R-UJ; Mon, 09 Mar 2026 18:01:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1vzien-000346-9D
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 18:00:57 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1vziej-0004YR-QB
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 18:00:56 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-798578e2918so111752897b3.2
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 15:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773093651; x=1773698451; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MO2Djzr1JLwBmOPoyAzlXv33IlnjPVuTeb4Lvd1vOdk=;
 b=N9L6xZOwnbZWmEOD/F6txeuHyRM0YxHIL0HGcAVvFJMOSnPGzSm7cafn+PTCWwa3Z2
 ahzqCvSgn1cpUmcYwnzlrsfspmAjXBtaSGlFLRcwNz/CMAp/4cFgwvXbnx0lsZGnQMdl
 n1AA0Ye+lhjDkbyZ7mNdF9fDP8r42VZwnK0U3YGf9dSsJ7d6oVG+gxRzsGyBdLKCZCHm
 mLqLLgKlIzCFoDx/VyeSSAmatiC3mUaPbbiNF+a8K42/EfbyYUU2X//xsh/yTCxrP+5P
 l0QQ5hr5VsewrpX0DfqusSuH3pLnZ49cNDm4L2lgve0GGhbWb75yLlzpl/DNHbIP+u2j
 g1Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773093651; x=1773698451;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=MO2Djzr1JLwBmOPoyAzlXv33IlnjPVuTeb4Lvd1vOdk=;
 b=KuhepqPQm/6+gmL9y6wgn6YWd3bDzhXxK3+xgtDAiwC5KI5tKHQInKFDpWpGNynOHS
 AY5GS9PrzdLDGJa31iZKVdRBo0PF1YTGYj9GlWM5XhpBY8SMhI+tjVIYSIlCNj+v1mgQ
 j3aKHgbyi8L/I0kRqnxJ4ajxgdFdTNdjWflLFC76JrlGbClCAYYDMShMsvvkAL5RJxRD
 mVmbMmSEt0UTtkGD7TGUgjqmkbGT4dIvtTc8M4XMeoYNIUl1Tp7XR7yXr98+hScqZ7ZC
 r1TpBe2jPLhG4rbmnuHj8whP7guIvsaIvYKoBit2nACup1rYvM267Wgb/rCPNwcijGOQ
 sPqA==
X-Gm-Message-State: AOJu0YwabCeVlv6uI/RQwFII71GgChMmVQbP0QNqNM3tqegbu+vnBfjx
 xWbu5I5eahxF1r+mgHrmH7z+jd+tFq89WiIM45O1ljoR8G2GOaUz0Ppx
X-Gm-Gg: ATEYQzw6oSvXahH4cIbNn6nD8gS+gzv3zGasba/YsKpo5yrB5yT5CTOxLXFGVHXantV
 Ne+RNOTJEUNfULLg21Nr6uOhicDRKe/kCeFpdJdG5mOpBMC5bIe2Bpz9Air/OA9BzVrr9Kbjp6Q
 xusNyHTh2FeeKsUiSQ4vZ+n5J7kot3GLhJHjiqppvBYbkK692riuY7MnpmDQ+Nu/YkoAUtIjeap
 GCw54YQQt4hSnDkFDdx+TTqNUQ2dKV/5/WI3OpP2zcm3dvnAIQhXAKvvJU/M+6Vl7dvB3/i0Bvx
 5m8VOUtjHCOfMYpot8AY7fEZimTUsnXJhqV9Fk1apyrJX7ycrg2EVsfeUxMe5TGXFkwxjmV7iaM
 nvShRgYcSHZzXl5/kXJttK4z7JsEttFyFwQeC8FayQcg5Vah1rRTXIicFRw3NatHKddrHiFhj4S
 k85UTf/rs6Yudsgpl0rfasmmqXEt8kjeHw23TagGaSk9HIjA==
X-Received: by 2002:a05:690c:6891:b0:798:3051:2f25 with SMTP id
 00721157ae682-798dd7bee25mr138310997b3.59.1773093650909; 
 Mon, 09 Mar 2026 15:00:50 -0700 (PDT)
Received: from [172.26.74.149] ([185.213.193.97])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-7990a54ba7csm5218437b3.19.2026.03.09.15.00.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 15:00:50 -0700 (PDT)
From: Gabriel Brookman <brookmangabriel@gmail.com>
Date: Mon, 09 Mar 2026 17:59:40 -0400
Subject: [PATCH v4 08/13] target/arm: storing to canonical tag faults
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260309-feat-mte4-v4-8-daaf0375620d@gmail.com>
References: <20260309-feat-mte4-v4-0-daaf0375620d@gmail.com>
In-Reply-To: <20260309-feat-mte4-v4-0-daaf0375620d@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Gabriel Brookman <brookmangabriel@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773093641; l=6244;
 i=brookmangabriel@gmail.com; s=20251009; h=from:subject:message-id;
 bh=r+Jq2DBcuUbHGiYmeILo/OAcI8m4Vy793dYTMR+04ds=;
 b=/qRj40FXZ2y/Atn39esRgXnraH+Rb5n8gvZCHDN8BIZ9XUpWaTGBUkbqWcIpxQ8yDZ0P8Ns9a
 xE8nbQjsmHZBCiC4UfUZzcJPkaFggbEReyFF/RvdcImwMQmpuU+Cjxk
X-Developer-Key: i=brookmangabriel@gmail.com; a=ed25519;
 pk=m9TtPDal6WzoHNnQiHHKf8dTrv3DUCPUUTujuo8vNrw=
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=brookmangabriel@gmail.com; helo=mail-yw1-x1135.google.com
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
 target/arm/tcg/mte_helper.c | 69 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index 07797aecf9..ddf4ffc51b 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -227,6 +227,20 @@ uint8_t *allocation_tag_mem_probe(CPUARMState *env, int ptr_mmu_idx,
 #endif
 }
 
+static void canonical_tag_write_fail(CPUARMState *env,
+                                uint64_t dirty_ptr, uintptr_t ra)
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
@@ -372,7 +386,11 @@ static inline void do_stg(CPUARMState *env, uint64_t ptr, uint64_t xt,
     /* Store if page supports tags. */
     if (mem) {
         store1(ptr, mem, allocation_tag_from_addr(xt));
+    } else if (canonical_tagging_enabled(env, 1 & (ptr >> 55))) {
+        canonical_tag_write_fail(env, ptr, ra);
+        return;
     }
+
 }
 
 void HELPER(stg)(CPUARMState *env, uint64_t ptr, uint64_t xt)
@@ -389,9 +407,19 @@ void HELPER(stg_stub)(CPUARMState *env, uint64_t ptr)
 {
     int mmu_idx = arm_env_mmu_index(env);
     uintptr_t ra = GETPC();
+    uint8_t *mem;
 
     check_tag_aligned(env, ptr, ra);
     probe_write(env, ptr, TAG_GRANULE, mmu_idx, ra);
+
+    /* If we are storing to a canonically tagged memory region, fault. */
+    if (canonical_tagging_enabled(env, 1 & (ptr >> 55))) {
+        mem = allocation_tag_mem_probe(env, mmu_idx, ptr, MMU_DATA_STORE,
+                                       TAG_GRANULE, MMU_DATA_STORE, true, ra);
+        if (!mem) {
+            canonical_tag_write_fail(env, ptr, ra);
+        }
+    }
 }
 
 static inline void do_st2g(CPUARMState *env, uint64_t ptr, uint64_t xt,
@@ -415,6 +443,11 @@ static inline void do_st2g(CPUARMState *env, uint64_t ptr, uint64_t xt,
                                   MMU_DATA_STORE, TAG_GRANULE,
                                   MMU_DATA_STORE, ra);
 
+        if (!(mem1 && mem2) && canonical_tagging_enabled(env, 1 & (ptr >> 55))) {
+            canonical_tag_write_fail(env, ptr, ra);
+            return;
+        }
+
         /* Store if page(s) support tags. */
         if (mem1) {
             store1(TAG_GRANULE, mem1, tag);
@@ -426,9 +459,14 @@ static inline void do_st2g(CPUARMState *env, uint64_t ptr, uint64_t xt,
         /* Two stores aligned mod TAG_GRANULE*2 -- modify one byte. */
         mem1 = allocation_tag_mem(env, mmu_idx, ptr, MMU_DATA_STORE,
                                   2 * TAG_GRANULE, MMU_DATA_STORE, ra);
+
         if (mem1) {
             tag |= tag << 4;
             qatomic_set(mem1, tag);
+        } else if (canonical_tagging_enabled(env, 1 & (ptr >> 55))) {
+            /* Writing tags to canonically tagged memory region: faults */
+            canonical_tag_write_fail(env, ptr, ra);
+            return;
         }
     }
 }
@@ -448,6 +486,7 @@ void HELPER(st2g_stub)(CPUARMState *env, uint64_t ptr)
     int mmu_idx = arm_env_mmu_index(env);
     uintptr_t ra = GETPC();
     int in_page = -(ptr | TARGET_PAGE_MASK);
+    uint8_t *mem1, *mem2;
 
     check_tag_aligned(env, ptr, ra);
 
@@ -457,6 +496,29 @@ void HELPER(st2g_stub)(CPUARMState *env, uint64_t ptr)
         probe_write(env, ptr, TAG_GRANULE, mmu_idx, ra);
         probe_write(env, ptr + TAG_GRANULE, TAG_GRANULE, mmu_idx, ra);
     }
+
+    /* If we are storing to a canonically tagged memory region, fault. */
+    if (canonical_tagging_enabled(env, 1 & (ptr >> 55))) {
+        if (likely(in_page >= 2 * TAG_GRANULE)) {
+            mem1 = allocation_tag_mem_probe(env, mmu_idx, ptr, MMU_DATA_STORE,
+                                           2 * TAG_GRANULE, MMU_DATA_STORE,
+                                           true, ra);
+            if (!mem1) {
+                canonical_tag_write_fail(env, ptr, ra);
+            }
+        } else {
+            mem1 = allocation_tag_mem_probe(env, mmu_idx, ptr, MMU_DATA_STORE,
+                                           TAG_GRANULE, MMU_DATA_STORE,
+                                           true, ra);
+            mem2 = allocation_tag_mem_probe(env, mmu_idx,
+                                                  ptr + TAG_GRANULE,
+                                                  MMU_DATA_STORE, TAG_GRANULE,
+                                                  MMU_DATA_STORE, true, ra);
+            if (!mem1 || !mem2) {
+                canonical_tag_write_fail(env, ptr, ra);
+            }
+        }
+    }
 }
 
 uint64_t HELPER(ldgm)(CPUARMState *env, uint64_t ptr)
@@ -569,6 +631,10 @@ void HELPER(stgm)(CPUARMState *env, uint64_t ptr, uint64_t val)
      * and if the OS has enabled access to the tags.
      */
     if (!tag_mem) {
+        /* Storing tags to canonically tagged region: fault. */
+        if (canonical_tagging_enabled(env, 1 & (ptr >> 55))) {
+            canonical_tag_write_fail(env, ptr, ra);
+        }
         return;
     }
 
@@ -619,9 +685,12 @@ void HELPER(stzgm_tags)(CPUARMState *env, uint64_t ptr, uint64_t val)
 
     mem = allocation_tag_mem(env, mmu_idx, ptr, MMU_DATA_STORE, dcz_bytes,
                              MMU_DATA_STORE, ra);
+
     if (mem) {
         int tag_pair = (val & 0xf) * 0x11;
         memset(mem, tag_pair, tag_bytes);
+    } else if (canonical_tagging_enabled(env, 1 & (ptr >> 55))) {
+        canonical_tag_write_fail(env, ptr, ra);
     }
 }
 

-- 
2.52.0


