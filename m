Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EA2606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 18:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=TY002fMw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMrn4-0007eb-Hg; Fri, 30 Oct 2026 14:57:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMrm0-0006uP-UI
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 14:56:21 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMrlw-0004pk-Ra
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 14:56:20 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-8b0d91601bdso18475357b3.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 11:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793386575; x=1793991375; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RB/sKLvvfUB0Wfzn/1ltw/gBKjTDiPFiEr9fRa8ubkg=;
 b=TY002fMwfqlP8ygxjKy2QCXQjTvu6ZymNUGI2NpyggT2lPSt5TqwFziO2/D1PsT4vC
 ClU8tlQGxCVjWPNLsZHAPsxIemxG7vx79KOEGhHsBBrhSVa38SRTgyGBx7XPWr98PObD
 YGhTI0SCvvpCkJBZ/jAcaP9Q8Hbkr9xphmAWWudyG9yUa869ly8KXJ151JSSIYNXzHyG
 tsxI+TPg3RgOS1tB3RQQeeQNqcj8hNAkhOrM3uzcKNIi7DxnSih1aW4Gd4Q3Uc4N7BhX
 ngMwTAaFQiCqnFqs+25hLaZ0sop7/QuT0JhpOGFTDqp+FXb+finXKiZh24b/oqWGLZHp
 AdkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793386575; x=1793991375;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RB/sKLvvfUB0Wfzn/1ltw/gBKjTDiPFiEr9fRa8ubkg=;
 b=O/0jOMVcYxOkQEgiAuAT0+cQvXd7T2OExy2m5CfBe/dFdxfke1Ma0/yWru1CLazVAY
 jea7hq+FUmgHkgeoGLNP+Qt2XQpz1+ePE9pQJkEch3u7+yUtQlwGhoek0vEjpi/8rAOV
 ed5hqZN3Q+ZAvj+HbiJdQpXTMKL3AJK0ZYKl9dc64g22IIBnTfwY4oQJGuPDoMqBDL1o
 eg2TOXtpubv5hLlkhHtC8GEMfsWpOcwGGcAGxAp+s0nJQb+0a/bdGPGHlIUb29U8n03j
 5i5Zyq2b2bgqdLkU6QZrP+nVVGmVWRYFTFZ0A5ZMWPZXisrOCkFYGhWd4A7iwKHmwYC8
 zvYA==
X-Gm-Message-State: AFq9FYJ394g1pzTLpiLVPrvROMsI0ZG9Te58Nr0Fgga+AL9Ba8046qrQ
 l7dUztuDDTazDFD+qDiOjd1dGQ38GrH1JCyCIJxccR/B3MELdAxfALHhCEERXzeM0iimr4dwlFr
 YeRPd
X-Gm-Gg: AYBFou28iQo0W52axBITz3d3L6w5gdLtXNzE3g0dUsYooHNefiSDMlPsVvKvxNEyBi/
 feBHQ01wLudomNnRLhcMrpWVrqrY+9dFA5X8BAu9JinYXGIeONaBKFAJxq4mWmczuOxQK4VjvU9
 ufo6UguYWDViRGRyMXGdzdE7O6ARRAnOlIYp9FDTQz9Cxs1KjEHryUcnSzTqF8qS7p/T4CaaxAP
 0n58J8GhFzJU3zRIVxAUO76KHfYu4Pr/din2qv7VlkkMsQJ4UjIEWjZXxKDtaeNRiczoaE39KUJ
 rHHiS55rB7QCil4SAAV2UX67WEOHSEXd7/yHf3CG0kiqjVM9SRi7KmymiXCF+ZkuNgAz2tQMIst
 BBF9gMB1rV68RdXfsv8tkEtFGbHmb9nqiUf8Jhrgii92ytLDRvMmSfPp1HLOK/A9yxenG+BgInx
 LBB3/FCM9HJhFzps5CJ6hVFmFbQtVr1RVio5XnAjO0wbCoNooGaE5jxt9Tw8aaI1a2LvelZAiU2
 K6y9TiB4JPdVj/v/66K4jMkKCG3YeJnKzVKse7eIDsUNna6qpw0V6kmYO51dgr+vtWGemDyQptN
 sLa9wIqahf78VTbL46Vf+bujuW2/koQ+mEw=
X-Received: by 2002:a05:690c:a906:10b0:8b0:cc88:cbe3 with SMTP id
 00721157ae682-8b1c6691f71mr38533737b3.11.1793386575200; 
 Fri, 30 Oct 2026 11:56:15 -0700 (PDT)
Received: from stoup ([2607:fb90:5e62:412b:1381:b0c1:1339:9c82])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b2b71a13b1sm13209657b3.39.2026.10.30.11.56.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 11:56:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: iii@linux.ibm.com,
	mattst88@gmail.com
Subject: [PATCH v7 14/14] accel/tcg: Move tb_jmp_cache to
 CPUNegativeOffsetState
Date: Fri, 30 Oct 2026 13:55:51 -0500
Message-ID: <20261030185551.193092-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030185551.193092-1-richard.henderson@linaro.org>
References: <20261030185551.193092-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x1131.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/cpu.h     | 4 ++--
 accel/tcg/cpu-exec.c      | 8 ++++----
 accel/tcg/cputlb.c        | 2 +-
 accel/tcg/tb-maint.c      | 2 +-
 accel/tcg/translate-all.c | 2 +-
 tcg/tcg-op.c              | 2 +-
 6 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 5b7c330047..5d1b624e6c 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -369,9 +369,11 @@ typedef union IcountDecr {
  * @plugin_mem_cbs: active plugin memory callbacks
  * @plugin_mem_value_low: 64 lower bits of latest accessed mem value.
  * @plugin_mem_value_high: 64 higher bits of latest accessed mem value.
+ * @tb_jmp_cache: Hash table of recently accessed TranslationBlocks.
  */
 typedef struct CPUNegativeOffsetState {
     CPUTLB tlb;
+    struct CPUJumpCache *tb_jmp_cache;
 #ifdef CONFIG_PLUGIN
     /*
      * The callback pointer are accessed via TCG (see gen_empty_mem_helper).
@@ -528,8 +530,6 @@ struct CPUState {
     AddressSpace *as;
     MemoryRegion *memory;
 
-    struct CPUJumpCache *tb_jmp_cache;
-
     GArray *gdb_regs;
     int gdb_num_regs;
     int gdb_num_g_regs;
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 4c20091ef5..2ed8f7c251 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -237,7 +237,7 @@ static inline TranslationBlock *tb_lookup(CPUState *cpu, TCGTBCPUState s)
     tcg_debug_assert(!(s.cflags & CF_INVALID));
 
     hash = tb_jmp_cache_hash_func(s.pc);
-    jc = cpu->tb_jmp_cache;
+    jc = cpu->neg.tb_jmp_cache;
 
     tb = qatomic_read(&jc->array[hash].tb);
     if (likely(tb &&
@@ -1012,7 +1012,7 @@ cpu_exec_loop(CPUState *cpu, SyncClocks *sc)
                  * for the fast lookup
                  */
                 h = tb_jmp_cache_hash_func(s.pc);
-                jc = cpu->tb_jmp_cache;
+                jc = cpu->neg.tb_jmp_cache;
                 jc->array[h].pc = s.pc;
                 qatomic_set(&jc->array[h].tb, tb);
             }
@@ -1109,7 +1109,7 @@ bool tcg_exec_realizefn(CPUState *cpu, Error **errp)
     /* Pick up one-insn-per-tb and -d nochain from the command line. */
     tcg_update_cflags(cpu);
 
-    cpu->tb_jmp_cache = g_new0(CPUJumpCache, 1);
+    cpu->neg.tb_jmp_cache = g_new0(CPUJumpCache, 1);
     tlb_init(cpu);
 #ifndef CONFIG_USER_ONLY
     tcg_iommu_init_notifier_list(cpu);
@@ -1127,5 +1127,5 @@ void tcg_exec_unrealizefn(CPUState *cpu)
 #endif /* !CONFIG_USER_ONLY */
 
     tlb_destroy(cpu);
-    g_free_rcu(cpu->tb_jmp_cache, rcu);
+    g_free_rcu(cpu->neg.tb_jmp_cache, rcu);
 }
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index dc83f3bad8..c777f5ac3f 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -149,7 +149,7 @@ static void tlb_window_reset(CPUTLBDesc *desc, int64_t ns,
 
 static void tb_jmp_cache_clear_page(CPUState *cpu, vaddr page_addr)
 {
-    CPUJumpCache *jc = cpu->tb_jmp_cache;
+    CPUJumpCache *jc = cpu->neg.tb_jmp_cache;
     int i, i0;
 
     if (unlikely(!jc)) {
diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index 4313864d2c..ca1b0089fc 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -905,7 +905,7 @@ static void tb_jmp_cache_inval_tb(TranslationBlock *tb)
         uint32_t h = tb_jmp_cache_hash_func(tb->pc);
 
         CPU_FOREACH(cpu) {
-            CPUJumpCache *jc = cpu->tb_jmp_cache;
+            CPUJumpCache *jc = cpu->neg.tb_jmp_cache;
 
             if (qatomic_read(&jc->array[h].tb) == tb) {
                 qatomic_set(&jc->array[h].tb, NULL);
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index ea8257935e..3dd1714414 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -624,7 +624,7 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr)
  */
 void tcg_flush_jmp_cache(CPUState *cpu)
 {
-    CPUJumpCache *jc = cpu->tb_jmp_cache;
+    CPUJumpCache *jc = cpu->neg.tb_jmp_cache;
 
     /* During early initialization, the cache may not yet be allocated. */
     if (unlikely(jc == NULL)) {
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 0040d149e0..7969875d20 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1914,7 +1914,7 @@ static void gen_jc_probe(TCGTemp *pc, TCGTemp *cs_base, uint32_t flags)
     /* p = &jc->array[tb_jmp_cache_hash_func(pc)] */
     gen_jc_hash(h, t, pc);
     tcg_gen_ld(TCG_TYPE_I64, t, tcgv_ptr_temp(tcg_env),
-               offsetof(CPUState, tb_jmp_cache) - sizeof(CPUState));
+               offsetof(CPUState, neg.tb_jmp_cache) - sizeof(CPUState));
     tcg_gen_lea(TCG_TYPE_I64, p, t, h, 4, 0);
 
     if (tcg_op_supported(INDEX_op_goto_jc, TCG_TYPE_PTR, 0)) {
-- 
2.53.0


