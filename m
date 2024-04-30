Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34340C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 12:30:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1mcJ-0007iv-Ey; Tue, 30 Apr 2024 08:29:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1mbv-0007Ev-Sa
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 08:29:28 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1mbt-0001pw-MT
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 08:29:27 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-56e1bbdb362so6036272a12.1
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 05:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714480164; x=1715084964; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PBJVq2+6UkUPok0cTSz4FPYy6QLevZUsxobHr1lZ+c8=;
 b=J/6FuXeF/lztwLPYB9gqZbZ5f6HSv8/s2r06wg+32TKHzH5qmbBZ8RimyG/eO32y3g
 X/dGJu2+bnSyEvrWAlZokDqqVKPWqlJaVpXtGHf6WxjWmzu1UDA6YcJXQUMhqybXzZV5
 OoDmoeDqaMRW4ZA60wMm1MzoKzB7HOwF+mENdc/Em5LJNgZBgHeqGE7o4fKXg/rl2kgv
 cBwMeOhS//ckQZIgBXKt2nTiXqlA+zY58bhQwx/7YjYrQXYx6ZrLQO5F0omogPftS7Gb
 4E89bp/6kNgBPkC2tBuyC/Gj2Xs3LsGXcEAIAI0LcaXrbDMTwsMOv7S1+Gn4pSVqBxpi
 Lt+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714480164; x=1715084964;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PBJVq2+6UkUPok0cTSz4FPYy6QLevZUsxobHr1lZ+c8=;
 b=w7oCxj+TX2DeLM+j3l+m+LTDlkkGG5iZWZnWfUOjBD+xkS4wTehCXll7I85RP4vnn+
 5W4n1BGYOsl4k3DYi5QOsWI0LkSXrX93Sp9hW+rOm/ZdwGHITee2w6EV48ekRdUWMUT7
 L9epPkA+XtC9P7rtRDf3+OMdRG2aoTaosS2iQtnZRsEEPyelfgt0GMEbL8oYfNWnwCQq
 d+UjiBa+xImwwX1xZ8vNByiMQ7ymlGlsXmEwMUXItWionWV9KrxlxLPYOxXI2EKc0p1Y
 H4tVEw4wDm+oynXra/Gt5DoipJJlZwHKO267+ibpcPani3TjuTLH/BSAatiUHLXI6lnO
 ccNg==
X-Gm-Message-State: AOJu0Yxp8oi76Jr5MFv2R32g76gE5CtlHJ3F0uvqQmDlXvSqHowvXcNJ
 Dkt0WRDQrj+Ev1qP4byz5LHe2jsvr0k+QrGD2vMrjLo5wpcMTNLjOBPSC9sm393D6wQaAy7P68n
 G
X-Google-Smtp-Source: AGHT+IEovet6ktpAa9UgFPwNuPUakXTaWuaEZNKog6fZ0miX7/bp7ju29aVS5NEnCImtvwIRAuCdCA==
X-Received: by 2002:a17:907:94c3:b0:a58:eba0:b358 with SMTP id
 dn3-20020a17090794c300b00a58eba0b358mr9681285ejc.53.1714480163739; 
 Tue, 30 Apr 2024 05:29:23 -0700 (PDT)
Received: from m1x-phil.lan (mab78-h01-176-184-55-179.dsl.sta.abo.bbox.fr.
 [176.184.55.179]) by smtp.gmail.com with ESMTPSA id
 g10-20020a17090613ca00b00a58ee5b1d18sm3639943ejc.160.2024.04.30.05.29.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Apr 2024 05:29:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 13/13] accel/tcg: Move @tb_jmp_cache from CPUState to TCG
 AccelCPUState
Date: Tue, 30 Apr 2024 14:28:07 +0200
Message-ID: <20240430122808.72025-14-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240430122808.72025-1-philmd@linaro.org>
References: <20240430122808.72025-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x534.google.com
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

@tb_jmp_cache is specific to TCG accelerator, move it to its
AccelCPUState. Remove the NULL check in tcg_flush_jmp_cache().

Cc: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240428221450.26460-21-philmd@linaro.org>
---
 accel/tcg/tb-jmp-cache.h  | 4 ++--
 accel/tcg/vcpu-state.h    | 2 ++
 include/hw/core/cpu.h     | 2 --
 include/qemu/typedefs.h   | 1 -
 accel/tcg/cpu-exec.c      | 7 +++----
 accel/tcg/cputlb.c        | 2 +-
 accel/tcg/tb-maint.c      | 2 +-
 accel/tcg/translate-all.c | 7 +------
 8 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/accel/tcg/tb-jmp-cache.h b/accel/tcg/tb-jmp-cache.h
index 184bb3e3e2..c3a505e394 100644
--- a/accel/tcg/tb-jmp-cache.h
+++ b/accel/tcg/tb-jmp-cache.h
@@ -22,12 +22,12 @@
  * non-NULL value of 'tb'.  Strictly speaking pc is only needed for
  * CF_PCREL, but it's used always for simplicity.
  */
-struct CPUJumpCache {
+typedef struct CPUJumpCache {
     struct rcu_head rcu;
     struct {
         TranslationBlock *tb;
         vaddr pc;
     } array[TB_JMP_CACHE_SIZE];
-};
+} CPUJumpCache;
 
 #endif /* ACCEL_TCG_TB_JMP_CACHE_H */
diff --git a/accel/tcg/vcpu-state.h b/accel/tcg/vcpu-state.h
index 716a0119c4..7fff5413e9 100644
--- a/accel/tcg/vcpu-state.h
+++ b/accel/tcg/vcpu-state.h
@@ -7,6 +7,7 @@
 #define ACCEL_TCG_VCPU_STATE_H
 
 #include "hw/core/cpu.h"
+#include "tb-jmp-cache.h"
 
 /**
  * AccelCPUState: vCPU fields specific to TCG accelerator
@@ -19,6 +20,7 @@ struct AccelCPUState {
     uint32_t cflags_next_tb;
 
     sigjmp_buf jmp_env;
+    CPUJumpCache tb_jmp_cache;
 
 #ifdef CONFIG_USER_ONLY
     TaskState *ts;
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index f06bb1e93a..c0c28befd3 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -479,8 +479,6 @@ struct CPUState {
     AddressSpace *as;
     MemoryRegion *memory;
 
-    CPUJumpCache *tb_jmp_cache;
-
     GArray *gdb_regs;
     int gdb_num_regs;
     int gdb_num_g_regs;
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 36f2825725..daf9009332 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -44,7 +44,6 @@ typedef struct CPUAddressSpace CPUAddressSpace;
 typedef struct CPUArchState CPUArchState;
 typedef struct CPUPluginState CPUPluginState;
 typedef struct CpuInfoFast CpuInfoFast;
-typedef struct CPUJumpCache CPUJumpCache;
 typedef struct CPUState CPUState;
 typedef struct CPUTLBEntryFull CPUTLBEntryFull;
 typedef struct DeviceListener DeviceListener;
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index a491278082..f813c68d1e 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -262,7 +262,7 @@ static inline TranslationBlock *tb_lookup(CPUState *cpu, vaddr pc,
     tcg_debug_assert(!(cflags & CF_INVALID));
 
     hash = tb_jmp_cache_hash_func(pc);
-    jc = cpu->tb_jmp_cache;
+    jc = &cpu->accel->tb_jmp_cache;
 
     tb = qatomic_read(&jc->array[hash].tb);
     if (likely(tb &&
@@ -1011,7 +1011,7 @@ cpu_exec_loop(CPUState *cpu, SyncClocks *sc)
                  * for the fast lookup
                  */
                 h = tb_jmp_cache_hash_func(pc);
-                jc = cpu->tb_jmp_cache;
+                jc = &cpu->accel->tb_jmp_cache;
                 jc->array[h].pc = pc;
                 qatomic_set(&jc->array[h].tb, tb);
             }
@@ -1090,7 +1090,6 @@ bool tcg_exec_realizefn(CPUState *cpu, Error **errp)
         tcg_target_initialized = true;
     }
 
-    cpu->tb_jmp_cache = g_new0(CPUJumpCache, 1);
     tlb_init(cpu);
 #ifndef CONFIG_USER_ONLY
     tcg_iommu_init_notifier_list(cpu);
@@ -1108,5 +1107,5 @@ void tcg_exec_unrealizefn(CPUState *cpu)
 #endif /* !CONFIG_USER_ONLY */
 
     tlb_destroy(cpu);
-    g_free_rcu(cpu->tb_jmp_cache, rcu);
+    g_free_rcu(&cpu->accel->tb_jmp_cache, rcu);
 }
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index cdb3e12dfb..eaa60d1da2 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -156,7 +156,7 @@ static void tlb_window_reset(CPUTLBDesc *desc, int64_t ns,
 
 static void tb_jmp_cache_clear_page(CPUState *cpu, vaddr page_addr)
 {
-    CPUJumpCache *jc = cpu->tb_jmp_cache;
+    CPUJumpCache *jc = &cpu->accel->tb_jmp_cache;
     int i, i0;
 
     if (unlikely(!jc)) {
diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index 2d5faca9fd..83758648f2 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -888,7 +888,7 @@ static void tb_jmp_cache_inval_tb(TranslationBlock *tb)
         uint32_t h = tb_jmp_cache_hash_func(tb->pc);
 
         CPU_FOREACH(cpu) {
-            CPUJumpCache *jc = cpu->tb_jmp_cache;
+            CPUJumpCache *jc = &cpu->accel->tb_jmp_cache;
 
             if (qatomic_read(&jc->array[h].tb) == tb) {
                 qatomic_set(&jc->array[h].tb, NULL);
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 3a8199a761..9b02f21b23 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -652,12 +652,7 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr)
  */
 void tcg_flush_jmp_cache(CPUState *cpu)
 {
-    CPUJumpCache *jc = cpu->tb_jmp_cache;
-
-    /* During early initialization, the cache may not yet be allocated. */
-    if (unlikely(jc == NULL)) {
-        return;
-    }
+    CPUJumpCache *jc = &cpu->accel->tb_jmp_cache;
 
     for (int i = 0; i < TB_JMP_CACHE_SIZE; i++) {
         qatomic_set(&jc->array[i].tb, NULL);
-- 
2.41.0


