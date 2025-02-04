Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B56D3C02193
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 21:54:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfQsE-0001e7-5u; Tue, 04 Feb 2025 16:54:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tfQs2-0001a9-Jg
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 16:54:17 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tfQs0-0008VW-A0
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 16:54:14 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2efe25558ddso7882697a91.2
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 13:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738706050; x=1739310850; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0D+qkdUAnGyLEvzj5WsailDQ6IwrMLobTEZGdeMA0tw=;
 b=Kx+Myume+Z9x4owB8XJTh86mI0kYGsgqKoDhAWm7r2/oOPkPTh6rqSQKbUo4nRqgyZ
 eTEJeNet5ko8I4PzpiAnSjRh85CowHMYXx9eW3omt3UcLnFlyV7XyyawaFQuVoQNpDmm
 GTsjQf353StGX4EoBAMaT+xmydB/xeh1bEkR6YdHMqj5emwHuv/icwH/ksumVdMU5FS3
 ZkyrCQzvcckWDUfPmjBe4n2w/SUb3cH/sKV9RbygQKZvHT71D2YYOmxbIR/Wcybiw3uj
 7jLuRLskrOVunFUFJf6cZdqQB0Pe6i0l3nf08XmDxkjU4uAdRPqDtv+Pore7mJLZdRdJ
 xAew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738706050; x=1739310850;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0D+qkdUAnGyLEvzj5WsailDQ6IwrMLobTEZGdeMA0tw=;
 b=BnVRdA9YYXTgCAw6UrS+Ff+Ej2SbJVZbSxiVAi8gV4IohxZqlCWbwsREybKwVmelw+
 7iD2vVWYws0MMfrzJ8NG4wT7Q1L0A1SIImR66d9djOscbOHexcJ3T0o7K/en3t/YTIzJ
 H7UgNgZxcqYfV5VU/JX5y3w426tKrKKfsCu7ng7GJLApxmQiZJjXUcyT3u1ykYAQZLpE
 KO4x6dD3wOQP1ie7zmjrxLUCpe9+DYr5mjCIAEVPb5tUas1P77YyYfa8x1e01XPGNSOl
 XU8e5SYQYYMl3XdPF+V6TEFUzwbtzxfq+UjRlHp4rtOsj26MEuEsBWj0OGcPTr7xowLM
 YwrA==
X-Gm-Message-State: AOJu0Ywu4tzPuQRZetOEiG4gZQbAfXSPTJc7Tdus0un4a6RB6Z5Lvc/W
 GOjZuDu/EOiK64XXQDF4F3SJCMEU88zIP9CpsnrRapibkxXYcItEwVK6h8U5twVGs55GotLp8Vq
 2
X-Gm-Gg: ASbGncse0wxdjPsBx3Esa9x4gUSzFuhkinvz6m/ur1cZJoeP++IrLpQrU10t4zo2rsI
 sAucKDCrrzP9pGBYTYDR9JcRQbV0WxnbxOmAV+5jnjnmscur4/zjNL/xp9v6AsEV+7qyWLAcCiH
 BieD6PCGhR80tgwhWE/pmLOD3Ue+RPSiO0+Snm7R1UVwF3dT5NKD7qImlXvCNU+zwnlzTAmEUB/
 Np5PyvdDPMsrca1lR+U578jlnYiOMYt0K6IzyDfnBYcwKSdgyEr5tPcqFCfGq3oDBihMA2y0541
 duYN1M3OxhEueKRa+CIu07olOmtojUn2attTpZOv7u5EKjA=
X-Google-Smtp-Source: AGHT+IHoZJ2T4cOaLZISIKpryVq8ff/yB8RGAkJdwwBOqMxuJuAO3atNH51oF5d+3ho4BpzfggOKpQ==
X-Received: by 2002:a17:90b:3a88:b0:2ee:dd9b:e402 with SMTP id
 98e67ed59e1d1-2f9e07610b3mr733787a91.12.1738706050428; 
 Tue, 04 Feb 2025 13:54:10 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f9e1d60b57sm33888a91.9.2025.02.04.13.54.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 13:54:10 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mark.cave-ayland@ilande.co.uk, berrange@redhat.com,
 philmd@linaro.org, thuth@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 12/12] tcg: Remove TCG_OVERSIZED_GUEST
Date: Tue,  4 Feb 2025 13:53:59 -0800
Message-ID: <20250204215359.1238808-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250204215359.1238808-1-richard.henderson@linaro.org>
References: <20250204215359.1238808-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

This is now prohibited in configuration.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/atomic.h           | 18 +++--------------
 include/tcg/oversized-guest.h   | 23 ----------------------
 accel/tcg/cputlb.c              |  7 -------
 accel/tcg/tcg-all.c             |  9 ++++-----
 target/arm/ptw.c                | 34 ---------------------------------
 target/riscv/cpu_helper.c       | 13 +------------
 docs/devel/multi-thread-tcg.rst |  1 -
 7 files changed, 8 insertions(+), 97 deletions(-)
 delete mode 100644 include/tcg/oversized-guest.h

diff --git a/include/qemu/atomic.h b/include/qemu/atomic.h
index 7a3f2e6576..f80cba24cf 100644
--- a/include/qemu/atomic.h
+++ b/include/qemu/atomic.h
@@ -56,25 +56,13 @@
  */
 #define signal_barrier()    __atomic_signal_fence(__ATOMIC_SEQ_CST)
 
-/* Sanity check that the size of an atomic operation isn't "overly large".
+/*
+ * Sanity check that the size of an atomic operation isn't "overly large".
  * Despite the fact that e.g. i686 has 64-bit atomic operations, we do not
  * want to use them because we ought not need them, and this lets us do a
  * bit of sanity checking that other 32-bit hosts might build.
- *
- * That said, we have a problem on 64-bit ILP32 hosts in that in order to
- * sync with TCG_OVERSIZED_GUEST, this must match TCG_TARGET_REG_BITS.
- * We'd prefer not want to pull in everything else TCG related, so handle
- * those few cases by hand.
- *
- * Note that x32 is fully detected with __x86_64__ + _ILP32, and that for
- * Sparc we always force the use of sparcv9 in configure. MIPS n32 (ILP32) &
- * n64 (LP64) ABIs are both detected using __mips64.
  */
-#if defined(__x86_64__) || defined(__sparc__) || defined(__mips64)
-# define ATOMIC_REG_SIZE  8
-#else
-# define ATOMIC_REG_SIZE  sizeof(void *)
-#endif
+#define ATOMIC_REG_SIZE  sizeof(void *)
 
 /* Weak atomic operations prevent the compiler moving other
  * loads/stores past the atomic operation load/store. However there is
diff --git a/include/tcg/oversized-guest.h b/include/tcg/oversized-guest.h
deleted file mode 100644
index 641b9749ff..0000000000
--- a/include/tcg/oversized-guest.h
+++ /dev/null
@@ -1,23 +0,0 @@
-/* SPDX-License-Identifier: MIT */
-/*
- * Define TCG_OVERSIZED_GUEST
- * Copyright (c) 2008 Fabrice Bellard
- */
-
-#ifndef EXEC_TCG_OVERSIZED_GUEST_H
-#define EXEC_TCG_OVERSIZED_GUEST_H
-
-#include "tcg-target-reg-bits.h"
-#include "cpu-param.h"
-
-/*
- * Oversized TCG guests make things like MTTCG hard
- * as we can't use atomics for cputlb updates.
- */
-#if TARGET_LONG_BITS > TCG_TARGET_REG_BITS
-#define TCG_OVERSIZED_GUEST 1
-#else
-#define TCG_OVERSIZED_GUEST 0
-#endif
-
-#endif
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index b4ccf0cdcb..17e2251695 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -47,7 +47,6 @@
 #include "qemu/plugin-memory.h"
 #endif
 #include "tcg/tcg-ldst.h"
-#include "tcg/oversized-guest.h"
 
 /* DEBUG defines, enable DEBUG_TLB_LOG to log to the CPU_LOG_MMU target */
 /* #define DEBUG_TLB */
@@ -118,12 +117,8 @@ static inline uint64_t tlb_read_idx(const CPUTLBEntry *entry,
     return qatomic_read(ptr);
 #else
     const uint64_t *ptr = &entry->addr_idx[access_type];
-# if TCG_OVERSIZED_GUEST
-    return *ptr;
-# else
     /* ofs might correspond to .addr_write, so use qatomic_read */
     return qatomic_read(ptr);
-# endif
 #endif
 }
 
@@ -908,8 +903,6 @@ static void tlb_reset_dirty_range_locked(CPUTLBEntry *tlb_entry,
             uint32_t *ptr_write = (uint32_t *)&tlb_entry->addr_write;
             ptr_write += HOST_BIG_ENDIAN;
             qatomic_set(ptr_write, *ptr_write | TLB_NOTDIRTY);
-#elif TCG_OVERSIZED_GUEST
-            tlb_entry->addr_write |= TLB_NOTDIRTY;
 #else
             qatomic_set(&tlb_entry->addr_write,
                         tlb_entry->addr_write | TLB_NOTDIRTY);
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index 95adaacee8..c1a30b0121 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -28,7 +28,6 @@
 #include "exec/replay-core.h"
 #include "system/cpu-timers.h"
 #include "tcg/startup.h"
-#include "tcg/oversized-guest.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/accel.h"
@@ -41,6 +40,8 @@
 #include "hw/boards.h"
 #endif
 #include "internal-common.h"
+#include "cpu-param.h"
+
 
 struct TCGState {
     AccelState parent_obj;
@@ -72,7 +73,7 @@ DECLARE_INSTANCE_CHECKER(TCGState, TCG_STATE,
 
 static bool default_mttcg_enabled(void)
 {
-    if (icount_enabled() || TCG_OVERSIZED_GUEST) {
+    if (icount_enabled()) {
         return false;
     }
 #ifdef TARGET_SUPPORTS_MTTCG
@@ -145,9 +146,7 @@ static void tcg_set_thread(Object *obj, const char *value, Error **errp)
     TCGState *s = TCG_STATE(obj);
 
     if (strcmp(value, "multi") == 0) {
-        if (TCG_OVERSIZED_GUEST) {
-            error_setg(errp, "No MTTCG when guest word size > hosts");
-        } else if (icount_enabled()) {
+        if (icount_enabled()) {
             error_setg(errp, "No MTTCG when icount is enabled");
         } else {
 #ifndef TARGET_SUPPORTS_MTTCG
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 64bb6878a4..4330900348 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -16,9 +16,6 @@
 #include "internals.h"
 #include "cpu-features.h"
 #include "idau.h"
-#ifdef CONFIG_TCG
-# include "tcg/oversized-guest.h"
-#endif
 
 typedef struct S1Translate {
     /*
@@ -840,7 +837,6 @@ static uint64_t arm_casq_ptw(CPUARMState *env, uint64_t old_val,
         ptw->out_rw = true;
     }
 
-#ifdef CONFIG_ATOMIC64
     if (ptw->out_be) {
         old_val = cpu_to_be64(old_val);
         new_val = cpu_to_be64(new_val);
@@ -852,36 +848,6 @@ static uint64_t arm_casq_ptw(CPUARMState *env, uint64_t old_val,
         cur_val = qatomic_cmpxchg__nocheck((uint64_t *)host, old_val, new_val);
         cur_val = le64_to_cpu(cur_val);
     }
-#else
-    /*
-     * We can't support the full 64-bit atomic cmpxchg on the host.
-     * Because this is only used for FEAT_HAFDBS, which is only for AA64,
-     * we know that TCG_OVERSIZED_GUEST is set, which means that we are
-     * running in round-robin mode and could only race with dma i/o.
-     */
-#if !TCG_OVERSIZED_GUEST
-# error "Unexpected configuration"
-#endif
-    bool locked = bql_locked();
-    if (!locked) {
-        bql_lock();
-    }
-    if (ptw->out_be) {
-        cur_val = ldq_be_p(host);
-        if (cur_val == old_val) {
-            stq_be_p(host, new_val);
-        }
-    } else {
-        cur_val = ldq_le_p(host);
-        if (cur_val == old_val) {
-            stq_le_p(host, new_val);
-        }
-    }
-    if (!locked) {
-        bql_unlock();
-    }
-#endif
-
     return cur_val;
 #else
     /* AArch32 does not have FEAT_HADFS; non-TCG guests only use debug-mode. */
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index e1dfc4ecbf..8ff6d900f2 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -32,7 +32,6 @@
 #include "system/cpu-timers.h"
 #include "cpu_bits.h"
 #include "debug.h"
-#include "tcg/oversized-guest.h"
 #include "pmp.h"
 
 int riscv_env_mmu_index(CPURISCVState *env, bool ifetch)
@@ -1167,9 +1166,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
     hwaddr pte_addr;
     int i;
 
-#if !TCG_OVERSIZED_GUEST
-restart:
-#endif
+ restart:
     for (i = 0; i < levels; i++, ptshift -= ptidxbits) {
         target_ulong idx;
         if (i == 0) {
@@ -1388,13 +1385,6 @@ restart:
                                      false, MEMTXATTRS_UNSPECIFIED);
         if (memory_region_is_ram(mr)) {
             target_ulong *pte_pa = qemu_map_ram_ptr(mr->ram_block, addr1);
-#if TCG_OVERSIZED_GUEST
-            /*
-             * MTTCG is not enabled on oversized TCG guests so
-             * page table updates do not need to be atomic
-             */
-            *pte_pa = pte = updated_pte;
-#else
             target_ulong old_pte;
             if (riscv_cpu_sxl(env) == MXL_RV32) {
                 old_pte = qatomic_cmpxchg((uint32_t *)pte_pa, pte, updated_pte);
@@ -1405,7 +1395,6 @@ restart:
                 goto restart;
             }
             pte = updated_pte;
-#endif
         } else {
             /*
              * Misconfigured PTE in ROM (AD bits are not preset) or
diff --git a/docs/devel/multi-thread-tcg.rst b/docs/devel/multi-thread-tcg.rst
index 7fd0a07633..b0f473961d 100644
--- a/docs/devel/multi-thread-tcg.rst
+++ b/docs/devel/multi-thread-tcg.rst
@@ -37,7 +37,6 @@ if:
 
 * forced by --accel tcg,thread=single
 * enabling --icount mode
-* 64 bit guests on 32 bit hosts (TCG_OVERSIZED_GUEST)
 
 In the general case of running translated code there should be no
 inter-vCPU dependencies and all vCPUs should be able to run at full
-- 
2.43.0


