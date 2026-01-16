Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B4DCD4A5F6
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 03:48:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgagM-00058M-AU; Thu, 15 Jan 2026 22:39:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgag2-0004zY-Kd
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:39:12 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgag0-0008K6-Dn
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:39:10 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2a0f3f74587so10549335ad.2
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 19:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768534747; x=1769139547; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rE9SCEsfxqLkJO7HvWLWosr5Ikr+Oai+wZCJ1H9Hel0=;
 b=SY3mMigdQheB+1Geup1tkzWggIal8kWoh4kIEsP6G+PgwRwbRRyyqFP57/hEYxT3yQ
 jPR2nZfXywOnIbMGUor7krZYzi16ueapwflFvN0MhFaZy7/JwHWenPcmSL/F0KG0Q62q
 8yooXRgdbEZFse4bXKQeRz6VJ+eT/kwtdjKdzB/No4GJh489FWTzlqckBr02zzev03/y
 iZowz6eDiXVYpf6R8c2//QYfh2sjKWuHjNDjlCe9hfiRn4Y6fRONwe4Yu4e5d144SwZ/
 /yzp82C+3+0qKtBDc5A5hyckHZjHiCLmXqyxWyD4XYKJTGgyyYnTQJ+MCK1HVNV5pcmU
 AC4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768534747; x=1769139547;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rE9SCEsfxqLkJO7HvWLWosr5Ikr+Oai+wZCJ1H9Hel0=;
 b=XU9KqL20I9DKPi0ZXDE7zpCc8ZbnVP5tcmmPt5vejsxHuYBY27E0lImkwuKjLGguxl
 utOwyApVENgDAH21eqfl5WULHsu9K2NvIqNeBLRnogB+6JiY3yBWQxYElUuFjGQIpi4F
 fXto2Vtwj32+49DiilA6eZiZLjZITAttU/XX6YT2IlCfr/GydolNuBpZTdMOyfxiNTHi
 kjEhggaUGXRX0dgla2Y2bHxhn/0ELWa5VM9OL93x1a6Sx2kZNXqIu5YNQXdw/LHkNL61
 KhcR54ugJBOrck6GQArbQUfXiIe4IkgAAbu0RwoOtAt1pH1vKmcC7QqmHaTCEK354NMn
 nRFQ==
X-Gm-Message-State: AOJu0YyHNeNvfzlU0sEk7M5U7xluLG7N81R16WOG+6P4idXlfSNpNKWq
 NIVRcxVbpNX+9uTijRgZUaKN6Ix7Es34LVTADcCuXANXXgosVv2eQFyQBJXfTxd0yNMIA5y9oD7
 XnAUAI1c36g==
X-Gm-Gg: AY/fxX6ppmMfAJyQm3GS+Ar8IGLpu61y2kYZl6qd+dLvcUJ/93WqaxOpPHHC2RWsFYK
 xrLEiwY6MjYJYSQcDpK4t6aHRQneYBIxREn7Kqn5z2rRQdYYKJ8YMOY6mCXao8T6K5hPzIiu46l
 MW/tJ6Qx63rTck4M5tKEiin3MqENVAflykym8LNJeEr3oW648wn0LdR5g4P7cwUDN5WJjh7jcm5
 37jXkwSexbYaQhM96xHTV/EX0sKUrLUzjoBWrdrvpjGR2V4H4yMq8tPZpINig3kQ1uLCVcHInY4
 yz711sckmABOPwTLW60GeCXQxibMBXOzy6R5AvIcwkj20D0n/NaNcRLpuQY1xhKv9GGby8kuD2u
 9q9csMAeKd3U8zWdOx13vS5QjMmf8bEMeKQdbShlcz69X+nNIYod1pnTxUDX9PTYv9C9i/mD12I
 r3MmFCETgVLxZbANl7uA==
X-Received: by 2002:a17:903:40ca:b0:295:290d:4afa with SMTP id
 d9443c01a7336-2a71753755cmr16001485ad.23.1768534746802; 
 Thu, 15 Jan 2026 19:39:06 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7190ca9d5sm6527975ad.25.2026.01.15.19.39.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 19:39:06 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: ktokunaga.mail@gmail.com, berrange@redhat.com, pierrick.bouvier@linaro.org,
 thuth@redhat.com, pbonzini@redhat.com, philmd@linaro.org
Subject: [PATCH v2 44/58] accel/tcg: Drop CONFIG_ATOMIC64 checks from
 ldst_atomicicy.c.inc
Date: Fri, 16 Jan 2026 14:32:50 +1100
Message-ID: <20260116033305.51162-45-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260116033305.51162-1-richard.henderson@linaro.org>
References: <20260116033305.51162-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

This allows removal of functions like load_atomic8_or_exit
and simplification of load_atom_extract_al8_or_exit to
load_atom_extract_al8.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c             |  35 +-------
 accel/tcg/ldst_atomicity.c.inc | 149 +++++----------------------------
 2 files changed, 24 insertions(+), 160 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index a6774083b0..6900a12682 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -2080,25 +2080,6 @@ static uint64_t do_ld_parts_beN(MMULookupPageData *p, uint64_t ret_be)
     return ret_be;
 }
 
-/**
- * do_ld_parts_be4
- * @p: translation parameters
- * @ret_be: accumulated data
- *
- * As do_ld_bytes_beN, but with one atomic load.
- * Four aligned bytes are guaranteed to cover the load.
- */
-static uint64_t do_ld_whole_be4(MMULookupPageData *p, uint64_t ret_be)
-{
-    int o = p->addr & 3;
-    uint32_t x = load_atomic4(p->haddr - o);
-
-    x = cpu_to_be32(x);
-    x <<= o * 8;
-    x >>= (4 - p->size) * 8;
-    return (ret_be << (p->size * 8)) | x;
-}
-
 /**
  * do_ld_parts_be8
  * @p: translation parameters
@@ -2111,7 +2092,7 @@ static uint64_t do_ld_whole_be8(CPUState *cpu, uintptr_t ra,
                                 MMULookupPageData *p, uint64_t ret_be)
 {
     int o = p->addr & 7;
-    uint64_t x = load_atomic8_or_exit(cpu, ra, p->haddr - o);
+    uint64_t x = load_atomic8(p->haddr - o);
 
     x = cpu_to_be64(x);
     x <<= o * 8;
@@ -2176,11 +2157,7 @@ static uint64_t do_ld_beN(CPUState *cpu, MMULookupPageData *p,
         if (atom == MO_ATOM_IFALIGN_PAIR
             ? p->size == half_size
             : p->size >= half_size) {
-            if (!HAVE_al8_fast && p->size < 4) {
-                return do_ld_whole_be4(p, ret_be);
-            } else {
-                return do_ld_whole_be8(cpu, ra, p, ret_be);
-            }
+            return do_ld_whole_be8(cpu, ra, p, ret_be);
         }
         /* fall through */
 
@@ -2586,13 +2563,7 @@ static uint64_t do_st_leN(CPUState *cpu, MMULookupPageData *p,
         if (atom == MO_ATOM_IFALIGN_PAIR
             ? p->size == half_size
             : p->size >= half_size) {
-            if (!HAVE_al8_fast && p->size <= 4) {
-                return store_whole_le4(p->haddr, p->size, val_le);
-            } else if (HAVE_al8) {
-                return store_whole_le8(p->haddr, p->size, val_le);
-            } else {
-                cpu_loop_exit_atomic(cpu, ra);
-            }
+            return store_whole_le8(p->haddr, p->size, val_le);
         }
         /* fall through */
 
diff --git a/accel/tcg/ldst_atomicity.c.inc b/accel/tcg/ldst_atomicity.c.inc
index c735add261..f5b8289009 100644
--- a/accel/tcg/ldst_atomicity.c.inc
+++ b/accel/tcg/ldst_atomicity.c.inc
@@ -12,13 +12,6 @@
 #include "host/load-extract-al16-al8.h.inc"
 #include "host/store-insert-al16.h.inc"
 
-#ifdef CONFIG_ATOMIC64
-# define HAVE_al8          true
-#else
-# define HAVE_al8          false
-#endif
-#define HAVE_al8_fast      (ATOMIC_REG_SIZE >= 8)
-
 /**
  * required_atomicity:
  *
@@ -132,44 +125,7 @@ static inline uint32_t load_atomic4(void *pv)
 static inline uint64_t load_atomic8(void *pv)
 {
     uint64_t *p = __builtin_assume_aligned(pv, 8);
-
-    qemu_build_assert(HAVE_al8);
-    return qatomic_read__nocheck(p);
-}
-
-/**
- * load_atomic8_or_exit:
- * @cpu: generic cpu state
- * @ra: host unwind address
- * @pv: host address
- *
- * Atomically load 8 aligned bytes from @pv.
- * If this is not possible, longjmp out to restart serially.
- */
-static uint64_t load_atomic8_or_exit(CPUState *cpu, uintptr_t ra, void *pv)
-{
-    if (HAVE_al8) {
-        return load_atomic8(pv);
-    }
-
-#ifdef CONFIG_USER_ONLY
-    /*
-     * If the page is not writable, then assume the value is immutable
-     * and requires no locking.  This ignores the case of MAP_SHARED with
-     * another process, because the fallback start_exclusive solution
-     * provides no protection across processes.
-     */
-    WITH_MMAP_LOCK_GUARD() {
-        if (!page_check_range(h2g(pv), 8, PAGE_WRITE_ORG)) {
-            uint64_t *p = __builtin_assume_aligned(pv, 8);
-            return *p;
-        }
-    }
-#endif
-
-    /* Ultimate fallback: re-execute in serial context. */
-    trace_load_atom8_or_exit_fallback(ra);
-    cpu_loop_exit_atomic(cpu, ra);
+    return qatomic_read(p);
 }
 
 /**
@@ -264,9 +220,7 @@ static uint64_t load_atom_extract_al8x2(void *pv)
 }
 
 /**
- * load_atom_extract_al8_or_exit:
- * @cpu: generic cpu state
- * @ra: host unwind address
+ * load_atom_extract_al8
  * @pv: host address
  * @s: object size in bytes, @s <= 4.
  *
@@ -275,15 +229,14 @@ static uint64_t load_atom_extract_al8x2(void *pv)
  * 8-byte load and extract.
  * The value is returned in the low bits of a uint32_t.
  */
-static uint32_t load_atom_extract_al8_or_exit(CPUState *cpu, uintptr_t ra,
-                                              void *pv, int s)
+static uint32_t load_atom_extract_al8(void *pv, int s)
 {
     uintptr_t pi = (uintptr_t)pv;
     int o = pi & 7;
     int shr = (HOST_BIG_ENDIAN ? 8 - s - o : o) * 8;
 
     pv = (void *)(pi & ~7);
-    return load_atomic8_or_exit(cpu, ra, pv) >> shr;
+    return load_atomic8(pv) >> shr;
 }
 
 /**
@@ -297,7 +250,7 @@ static uint32_t load_atom_extract_al8_or_exit(CPUState *cpu, uintptr_t ra,
  * and p % 16 + s > 8.  I.e. does not cross a 16-byte
  * boundary, but *does* cross an 8-byte boundary.
  * This is the slow version, so we must have eliminated
- * any faster load_atom_extract_al8_or_exit case.
+ * any faster load_atom_extract_al8 case.
  *
  * If this is not possible, longjmp out to restart serially.
  */
@@ -374,21 +327,6 @@ static inline uint64_t load_atom_8_by_4(void *pv)
     }
 }
 
-/**
- * load_atom_8_by_8_or_4:
- * @pv: host address
- *
- * Load 8 bytes from aligned @pv, with at least 4-byte atomicity.
- */
-static inline uint64_t load_atom_8_by_8_or_4(void *pv)
-{
-    if (HAVE_al8_fast) {
-        return load_atomic8(pv);
-    } else {
-        return load_atom_8_by_4(pv);
-    }
-}
-
 /**
  * load_atom_2:
  * @p: host address
@@ -418,12 +356,8 @@ static uint16_t load_atom_2(CPUState *cpu, uintptr_t ra,
         return lduw_he_p(pv);
     case MO_16:
         /* The only case remaining is MO_ATOM_WITHIN16. */
-        if (!HAVE_al8_fast && (pi & 3) == 1) {
-            /* Big or little endian, we want the middle two bytes. */
-            return load_atomic4(pv - 1) >> 8;
-        }
         if ((pi & 15) != 7) {
-            return load_atom_extract_al8_or_exit(cpu, ra, pv, 2);
+            return load_atom_extract_al8(pv, 2);
         }
         return load_atom_extract_al16_or_exit(cpu, ra, pv, 2);
     default:
@@ -468,7 +402,7 @@ static uint32_t load_atom_4(CPUState *cpu, uintptr_t ra,
         return load_atom_extract_al4x2(pv);
     case MO_32:
         if (!(pi & 4)) {
-            return load_atom_extract_al8_or_exit(cpu, ra, pv, 4);
+            return load_atom_extract_al8(pv, 4);
         }
         return load_atom_extract_al16_or_exit(cpu, ra, pv, 4);
     default:
@@ -493,7 +427,7 @@ static uint64_t load_atom_8(CPUState *cpu, uintptr_t ra,
      * If the host does not support 8-byte atomics, wait until we have
      * examined the atomicity parameters below.
      */
-    if (HAVE_al8 && likely((pi & 7) == 0)) {
+    if (likely((pi & 7) == 0)) {
         return load_atomic8(pv);
     }
     if (HAVE_ATOMIC128_RO) {
@@ -502,30 +436,9 @@ static uint64_t load_atom_8(CPUState *cpu, uintptr_t ra,
 
     atmax = required_atomicity(cpu, pi, memop);
     if (atmax == MO_64) {
-        if (!HAVE_al8 && (pi & 7) == 0) {
-            load_atomic8_or_exit(cpu, ra, pv);
-        }
         return load_atom_extract_al16_or_exit(cpu, ra, pv, 8);
     }
-    if (HAVE_al8_fast) {
-        return load_atom_extract_al8x2(pv);
-    }
-    switch (atmax) {
-    case MO_8:
-        return ldq_he_p(pv);
-    case MO_16:
-        return load_atom_8_by_2(pv);
-    case MO_32:
-        return load_atom_8_by_4(pv);
-    case -MO_32:
-        if (HAVE_al8) {
-            return load_atom_extract_al8x2(pv);
-        }
-        trace_load_atom8_fallback(memop, ra);
-        cpu_loop_exit_atomic(cpu, ra);
-    default:
-        g_assert_not_reached();
-    }
+    return load_atom_extract_al8x2(pv);
 }
 
 /**
@@ -565,18 +478,10 @@ static Int128 load_atom_16(CPUState *cpu, uintptr_t ra,
         b = load_atom_8_by_4(pv + 8);
         break;
     case MO_64:
-        if (!HAVE_al8) {
-            trace_load_atom16_fallback(memop, ra);
-            cpu_loop_exit_atomic(cpu, ra);
-        }
         a = load_atomic8(pv);
         b = load_atomic8(pv + 8);
         break;
     case -MO_64:
-        if (!HAVE_al8) {
-            trace_load_atom16_fallback(memop, ra);
-            cpu_loop_exit_atomic(cpu, ra);
-        }
         a = load_atom_extract_al8x2(pv);
         b = load_atom_extract_al8x2(pv + 8);
         break;
@@ -624,9 +529,7 @@ static inline void store_atomic4(void *pv, uint32_t val)
 static inline void store_atomic8(void *pv, uint64_t val)
 {
     uint64_t *p = __builtin_assume_aligned(pv, 8);
-
-    qemu_build_assert(HAVE_al8);
-    qatomic_set__nocheck(p, val);
+    qatomic_set(p, val);
 }
 
 /**
@@ -688,9 +591,8 @@ static void store_atom_insert_al8(uint64_t *p, uint64_t val, uint64_t msk)
 {
     uint64_t old, new;
 
-    qemu_build_assert(HAVE_al8);
     p = __builtin_assume_aligned(p, 8);
-    old = qatomic_read__nocheck(p);
+    old = qatomic_read(p);
     do {
         new = (old & ~msk) | val;
     } while (!__atomic_compare_exchange_n(p, &old, new, true,
@@ -802,7 +704,6 @@ static uint64_t store_whole_le8(void *pv, int size, uint64_t val_le)
     uint64_t m = MAKE_64BIT_MASK(0, sz);
     uint64_t v;
 
-    qemu_build_assert(HAVE_al8);
     if (HOST_BIG_ENDIAN) {
         v = bswap64(val_le) >> sh;
         m = bswap64(m) >> sh;
@@ -887,10 +788,8 @@ static void store_atom_2(CPUState *cpu, uintptr_t ra,
         store_atom_insert_al4(pv - 1, (uint32_t)val << 8, MAKE_64BIT_MASK(8, 16));
         return;
     } else if ((pi & 7) == 3) {
-        if (HAVE_al8) {
-            store_atom_insert_al8(pv - 3, (uint64_t)val << 24, MAKE_64BIT_MASK(24, 16));
-            return;
-        }
+        store_atom_insert_al8(pv - 3, (uint64_t)val << 24, MAKE_64BIT_MASK(24, 16));
+        return;
     } else if ((pi & 15) == 7) {
         if (HAVE_CMPXCHG128) {
             Int128 v = int128_lshift(int128_make64(val), 56);
@@ -957,10 +856,8 @@ static void store_atom_4(CPUState *cpu, uintptr_t ra,
         return;
     case MO_32:
         if ((pi & 7) < 4) {
-            if (HAVE_al8) {
-                store_whole_le8(pv, 4, cpu_to_le32(val));
-                return;
-            }
+            store_whole_le8(pv, 4, cpu_to_le32(val));
+            return;
         } else {
             if (HAVE_CMPXCHG128) {
                 store_whole_le16(pv, 4, int128_make64(cpu_to_le32(val)));
@@ -988,7 +885,7 @@ static void store_atom_8(CPUState *cpu, uintptr_t ra,
     uintptr_t pi = (uintptr_t)pv;
     int atmax;
 
-    if (HAVE_al8 && likely((pi & 7) == 0)) {
+    if (likely((pi & 7) == 0)) {
         store_atomic8(pv, val);
         return;
     }
@@ -1005,7 +902,7 @@ static void store_atom_8(CPUState *cpu, uintptr_t ra,
         store_atom_8_by_4(pv, val);
         return;
     case -MO_32:
-        if (HAVE_al8) {
+        {
             uint64_t val_le = cpu_to_le64(val);
             int s2 = pi & 7;
             int s1 = 8 - s2;
@@ -1024,9 +921,8 @@ static void store_atom_8(CPUState *cpu, uintptr_t ra,
             default:
                 g_assert_not_reached();
             }
-            return;
         }
-        break;
+        return;
     case MO_64:
         if (HAVE_CMPXCHG128) {
             store_whole_le16(pv, 8, int128_make64(cpu_to_le64(val)));
@@ -1077,12 +973,9 @@ static void store_atom_16(CPUState *cpu, uintptr_t ra,
         store_atom_8_by_4(pv + 8, b);
         return;
     case MO_64:
-        if (HAVE_al8) {
-            store_atomic8(pv, a);
-            store_atomic8(pv + 8, b);
-            return;
-        }
-        break;
+        store_atomic8(pv, a);
+        store_atomic8(pv + 8, b);
+        return;
     case -MO_64:
         if (HAVE_CMPXCHG128) {
             uint64_t val_le;
-- 
2.43.0


