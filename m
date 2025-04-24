Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B20FC369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:21:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7lFm-0003Cs-Ve; Wed, 23 Apr 2025 21:19:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7lFR-0002i2-BU
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:19:30 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7lFN-00079L-Nb
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:19:28 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-736ab1c43c4so379265b3a.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 18:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745457564; x=1746062364; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eZtOoGV0Bg9Le+zLQ/C2D+0pnwsAfg8z9TKrAU/gNUw=;
 b=Oa2IOWcDTGy5ZmvwZj71+q18dbQF+VkKDLfAy6huNYI7DKjQzCfAC44fyiUSxCVNII
 hujQiZyDDTOQU+y8+zPIKL+ndd8VFmW9vMUF4I8hKh9scm5twFwbJib3wvRIWK8QTdXl
 O6woEXCRa0S2awqMvWIa1ZxX3crs3SkMWrBi5BBEBturnRw/GuBzRhl8lDM9Sqm9RIeY
 HeOZIhgvzW5iuozBh64fjvvI8y9z0zTnAnyDIEKxuUPt0/Wk3n8Kt4s2ES1Le36CB5Ek
 qWIlv0DU17vejsy2MJ7c6MUI9Gmm7Wg2+yzu99h3HPjM5F73ekkYqI/8mAYhRqlxzaJC
 8D8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745457564; x=1746062364;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eZtOoGV0Bg9Le+zLQ/C2D+0pnwsAfg8z9TKrAU/gNUw=;
 b=Iu6EiulOS6rVNncO5L/Hko2mcnpNlSUpqKin+S/AHLowA8HmTbc/AGReC0pxlMTzOd
 GJZmC36VUyug8Os7nUlY+1h9q/jRJ2po5VBoGEwG7a4iYT74Hi/WQ4tfexWgiYSw4Jcj
 qMoQO31m2iaRyxzIStHLxY5RwSK5KReAdFAh+Mp5Skpf48OoaHRXsE6tgNJtsLUmGUVA
 8AhYuF5UBL/KEMA4M5U0x4TfUHkhJawE7KBvoR6GiR24s5vUjjfMwNKloRIzXrANOiQY
 1bLCN7A4eSye+QCrTg8A3/Ev1cjHRfSc3DY8bhYG1jDcXI/fubOs4SW22v2LEHaOqCK2
 gdfA==
X-Gm-Message-State: AOJu0YwNRQzkYCCgmsiN0yQTlBch44TsuVBmbK2P5Jf3GwzhuWIEippn
 LFE1ysHIIxu4JPInZPU2mpxVP9Zy0kGUXt8gZ/Aw+k9hIHjsakGDVsRs7Z7/X0M0U2XeiF2jgt2
 F
X-Gm-Gg: ASbGncskl5f/D1lTNjD/KWaOkfSEStzGrbXIWwKfTy/H+fsIY7p7ZanqhWS9Cy1TLBa
 ZkJYNRJcbXbPMmxecJja0eJFR/z2v3db+aAFdEklMZ2EAo4Afq0RArmHIW68zZ8SW5U/yi4gc9p
 jM5pVE2rpYMUWiIpmxAlKrCUA4O9g11gSCFbLGcxxgGk8+c74nMgx6AIsyCKGiDnocdvBy/rNSa
 AslcEiZlIayRyHb1zjUPMFIQIINlQaT/d3WEOyfHB/aGBcuKhiSpKvWHvc0WLqf+3Y8lIaiCNvZ
 CJksMLLDClol+Wnt2xs74+EEPXAEFUJBZKFbk5YlKlkSPHqvjwTS9PU8LYCi+SbI+M6MLXwzXcZ
 zmNJwppRsnQ==
X-Google-Smtp-Source: AGHT+IFqhq+fqTmhvPHuuhokaa9IT8RywlLv27t8VQ5rZtPZOS5kYePX/6E366qrk9vVhIdTDH696A==
X-Received: by 2002:a05:6a20:9d8e:b0:1f5:58b9:6d9b with SMTP id
 adf61e73a8af0-20444f003bbmr936975637.12.1745457564046; 
 Wed, 23 Apr 2025 18:19:24 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25912ef0sm244079b3a.10.2025.04.23.18.19.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 18:19:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/15] accel/tcg: Convert TARGET_HAS_PRECISE_SMC to
 TCGCPUOps.precise_smc
Date: Wed, 23 Apr 2025 18:19:10 -0700
Message-ID: <20250424011918.599958-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424011918.599958-1-richard.henderson@linaro.org>
References: <20250424011918.599958-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

Instead of having a compile-time TARGET_HAS_PRECISE_SMC definition,
have each target set the 'precise_smc' field in the TCGCPUOps
structure.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/accel/tcg/cpu-ops.h |  7 +++++++
 include/exec/poison.h       |  1 -
 target/i386/cpu.h           |  4 ----
 target/s390x/cpu.h          |  2 --
 accel/tcg/tb-maint.c        | 32 +++++++++++++-------------------
 accel/tcg/user-exec.c       | 10 +++++-----
 target/i386/tcg/tcg-cpu.c   |  1 +
 target/s390x/cpu.c          |  1 +
 8 files changed, 27 insertions(+), 31 deletions(-)

diff --git a/include/accel/tcg/cpu-ops.h b/include/accel/tcg/cpu-ops.h
index 0e4352513d..60b5e97205 100644
--- a/include/accel/tcg/cpu-ops.h
+++ b/include/accel/tcg/cpu-ops.h
@@ -28,6 +28,13 @@ struct TCGCPUOps {
      */
     bool mttcg_supported;
 
+    /**
+     * @precise_smc: Stores which modify code within the current TB force
+     *               the TB to exit; the next executed instruction will see
+     *               the result of the store.
+     */
+    bool precise_smc;
+
     /**
      * @guest_default_memory_order: default barrier that is required
      *                              for the guest memory ordering.
diff --git a/include/exec/poison.h b/include/exec/poison.h
index bc422719d8..a779adbb7a 100644
--- a/include/exec/poison.h
+++ b/include/exec/poison.h
@@ -37,7 +37,6 @@
 #pragma GCC poison TARGET_NAME
 #pragma GCC poison TARGET_BIG_ENDIAN
 #pragma GCC poison TCG_GUEST_DEFAULT_MO
-#pragma GCC poison TARGET_HAS_PRECISE_SMC
 
 #pragma GCC poison TARGET_LONG_BITS
 #pragma GCC poison TARGET_FMT_lx
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 9866595cd0..877df7de1f 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -35,10 +35,6 @@
 
 #define XEN_NR_VIRQS 24
 
-/* support for self modifying code even if the modified instruction is
-   close to the modifying instruction */
-#define TARGET_HAS_PRECISE_SMC
-
 #ifdef TARGET_X86_64
 #define I386_ELF_MACHINE  EM_X86_64
 #define ELF_MACHINE_UNAME "x86_64"
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 90f64ee20c..ee59039879 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -35,8 +35,6 @@
 
 #define ELF_MACHINE_UNAME "S390X"
 
-#define TARGET_HAS_PRECISE_SMC
-
 #define MMU_USER_IDX 0
 
 #define S390_MAX_CPUS 248
diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index 345a7a473a..581d06ebf3 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -28,6 +28,7 @@
 #include "exec/mmap-lock.h"
 #include "exec/tb-flush.h"
 #include "exec/target_page.h"
+#include "accel/tcg/cpu-ops.h"
 #include "tb-internal.h"
 #include "system/tcg.h"
 #include "tcg/tcg.h"
@@ -1042,9 +1043,7 @@ static void tb_invalidate_phys_page(tb_page_addr_t addr)
 /*
  * Called with mmap_lock held. If pc is not 0 then it indicates the
  * host PC of the faulting store instruction that caused this invalidate.
- * Returns true if the caller needs to abort execution of the current
- * TB (because it was modified by this store and the guest CPU has
- * precise-SMC semantics).
+ * Returns true if the caller needs to abort execution of the current TB.
  */
 bool tb_invalidate_phys_page_unwind(CPUState *cpu, tb_page_addr_t addr,
                                     uintptr_t pc)
@@ -1059,10 +1058,7 @@ bool tb_invalidate_phys_page_unwind(CPUState *cpu, tb_page_addr_t addr,
      * Without precise smc semantics, or when outside of a TB,
      * we can skip to invalidate.
      */
-#ifndef TARGET_HAS_PRECISE_SMC
-    pc = 0;
-#endif
-    if (!pc) {
+    if (!pc || !cpu || !cpu->cc->tcg_ops->precise_smc) {
         tb_invalidate_phys_page(addr);
         return false;
     }
@@ -1113,14 +1109,16 @@ tb_invalidate_phys_page_range__locked(CPUState *cpu,
 {
     TranslationBlock *tb;
     PageForEachNext n;
-#ifdef TARGET_HAS_PRECISE_SMC
     bool current_tb_modified = false;
-    TranslationBlock *current_tb = retaddr ? tcg_tb_lookup(retaddr) : NULL;
-#endif /* TARGET_HAS_PRECISE_SMC */
+    TranslationBlock *current_tb = NULL;
 
     /* Range may not cross a page. */
     tcg_debug_assert(((start ^ last) & TARGET_PAGE_MASK) == 0);
 
+    if (retaddr && cpu && cpu->cc->tcg_ops->precise_smc) {
+        current_tb = tcg_tb_lookup(retaddr);
+    }
+
     /*
      * We remove all the TBs in the range [start, last].
      * XXX: see if in some cases it could be faster to invalidate all the code
@@ -1138,8 +1136,7 @@ tb_invalidate_phys_page_range__locked(CPUState *cpu,
             tb_last = tb_start + (tb_last & ~TARGET_PAGE_MASK);
         }
         if (!(tb_last < start || tb_start > last)) {
-#ifdef TARGET_HAS_PRECISE_SMC
-            if (current_tb == tb &&
+            if (unlikely(current_tb == tb) &&
                 (tb_cflags(current_tb) & CF_COUNT_MASK) != 1) {
                 /*
                  * If we are modifying the current TB, we must stop
@@ -1149,9 +1146,8 @@ tb_invalidate_phys_page_range__locked(CPUState *cpu,
                  * restore the CPU state.
                  */
                 current_tb_modified = true;
-                cpu_restore_state_from_tb(current_cpu, current_tb, retaddr);
+                cpu_restore_state_from_tb(cpu, current_tb, retaddr);
             }
-#endif /* TARGET_HAS_PRECISE_SMC */
             tb_phys_invalidate__locked(tb);
         }
     }
@@ -1161,15 +1157,13 @@ tb_invalidate_phys_page_range__locked(CPUState *cpu,
         tlb_unprotect_code(start);
     }
 
-#ifdef TARGET_HAS_PRECISE_SMC
-    if (current_tb_modified) {
+    if (unlikely(current_tb_modified)) {
         page_collection_unlock(pages);
         /* Force execution of one insn next time.  */
-        current_cpu->cflags_next_tb = 1 | CF_NOIRQ | curr_cflags(current_cpu);
+        cpu->cflags_next_tb = 1 | CF_NOIRQ | curr_cflags(cpu);
         mmap_unlock();
-        cpu_loop_exit_noexc(current_cpu);
+        cpu_loop_exit_noexc(cpu);
     }
-#endif
 }
 
 /*
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 2b12c077e9..112292b729 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -733,12 +733,12 @@ int page_unprotect(CPUState *cpu, tb_page_addr_t address, uintptr_t pc)
          * this thread raced with another one which got here first and
          * set the page to PAGE_WRITE and did the TB invalidate for us.
          */
-#ifdef TARGET_HAS_PRECISE_SMC
-        TranslationBlock *current_tb = tcg_tb_lookup(pc);
-        if (current_tb) {
-            current_tb_invalidated = tb_cflags(current_tb) & CF_INVALID;
+        if (pc && cpu->cc->tcg_ops->precise_smc) {
+            TranslationBlock *current_tb = tcg_tb_lookup(pc);
+            if (current_tb) {
+                current_tb_invalidated = tb_cflags(current_tb) & CF_INVALID;
+            }
         }
-#endif
     } else {
         int host_page_size = qemu_real_host_page_size();
         target_ulong start, len, i;
diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
index 621502c984..d441c0752e 100644
--- a/target/i386/tcg/tcg-cpu.c
+++ b/target/i386/tcg/tcg-cpu.c
@@ -126,6 +126,7 @@ static bool x86_debug_check_breakpoint(CPUState *cs)
 
 const TCGCPUOps x86_tcg_ops = {
     .mttcg_supported = true,
+    .precise_smc = true,
     /*
      * The x86 has a strong memory model with some store-after-load re-ordering
      */
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 41cccc1e69..e3623ad32a 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -346,6 +346,7 @@ void cpu_get_tb_cpu_state(CPUS390XState *env, vaddr *pc,
 
 static const TCGCPUOps s390_tcg_ops = {
     .mttcg_supported = true,
+    .precise_smc = true,
     /*
      * The z/Architecture has a strong memory model with some
      * store-after-load re-ordering.
-- 
2.43.0


