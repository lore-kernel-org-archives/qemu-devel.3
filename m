Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE69DC369D8
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:49:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JTG-0006vi-Mu; Tue, 22 Apr 2025 15:39:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JSN-0004JI-31
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:39:02 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JSJ-0007NH-9t
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:38:57 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-22409077c06so78139085ad.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350734; x=1745955534; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7dzx5TGrM0CiSq77kWcMK2agZzO7Wx5pZTOsmWaPtYI=;
 b=PkOaG5mRrJEDvn1sNZAllGG38vIxaNCNb4PwmtFP3ylKtkXCmiP1g4waz8zx+NLJ8u
 IR7g/xg1YwAMvIUy8Bv58TqUCMSqiITQpmNmw4ZE/LxcfjbTFK+PbrTvG9151IORE5RC
 xXfatadu6JTbfjggSBh7dT3hDery+JbSrOWbl6NblUj4jt6wYa0E55ZjS8p2m5OFtFd4
 KS206Rp0g7N44Dq9gA6X8o3Jg4YPXQx7c4sC8pT1I8m48iMTathwbkUlNzC2za4WPLzl
 M4MvwvWpj5iBIebeLMS1gwtiFeF/1nboYn8ZAtdM6fpVdiYPO+cgd7nD2uekl1zUn7d+
 jcuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350734; x=1745955534;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7dzx5TGrM0CiSq77kWcMK2agZzO7Wx5pZTOsmWaPtYI=;
 b=mn5CJWV4OrKH8xyvme5I8SEOsP1OPxgfBm/DiSHh3mICELOi6v4EtoUd3RNyXHNtd1
 /dfrWOy0bnyHI176qL2Aezs7px9Z+2BQTnrpi+xkRdv+hk+Jh9p6WIwwC+GZxN3eQWaX
 BO1kwPc3+I3FnEjWujRQDgS6CgCvLUDrrYVjXZ5xL3fijPzbs2+4bwEYkENMu0iQHz0O
 +zL8St55jzLmFDyRU62VI20j5q/45+TFzA3WzT1svXTmbOqMbCkTXDi9S987Qx2HSQ6s
 GCnUq/lKu/Ow4KF+9WLZWK9sjU+bP+B0+72AbCGw/gyUBx/ph5hEkqfhOUSYJ1vJzuOg
 7v9g==
X-Gm-Message-State: AOJu0YxdpTa78WxAjHTNIUASU0fwXEorSM//H9YkRRi4saSNYRaXOmS4
 WLFTFoAVlGKhjdC6Z0iLt1A/SCCxjf+GyqePpwP8xuo68S6sBllpA2MEoX1rRp8Y0tQ448FG6nk
 V
X-Gm-Gg: ASbGncs+DmdRUXjnXZSDe5HaLVOzgF5TDJIfTeLqN5coE6Kcauxqj0hJ17gb+FqaOFq
 U8oRZMLLUq+eMCxfslzrE9sJ0BmczNjnfAweRn7rJo30n17XKyv35nBFYy8ynRNM14Y2QKkEi/z
 Y3ic6LrF7YFJKU3Afj9zBhjoJfWodx+q/Lp+1IRSO7L0Ou8v/AE+Q6V9GxbWmocWa6HlEi0Z2mF
 5TchPI52nhhFN2wgu5rIzN+8eZX5u/wVj1nPffaFu317+FWPiam5GJNbgiLCL94ZMAsAMzhVVqU
 wYIAHuL7R08MYRLyaKwTiV4cVMFbWltoeRX0tZSQTR6anaUy+qOD93S31EUn8m2Rqdte+d0tb64
 =
X-Google-Smtp-Source: AGHT+IHkcj9qzsjO/OFW8PJAQ6o4JOtrPJjPd1i0doqVjQYmsjWlaGK7s9n5V7UgBHslHs1N6WF15Q==
X-Received: by 2002:a17:903:32d1:b0:224:fa0:36da with SMTP id
 d9443c01a7336-22c5358321dmr212298325ad.18.1745350733525; 
 Tue, 22 Apr 2025 12:38:53 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50eb484dsm88951765ad.148.2025.04.22.12.38.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:38:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 140/147] tcg: Pass max_threads not max_cpus to tcg_init
Date: Tue, 22 Apr 2025 12:28:09 -0700
Message-ID: <20250422192819.302784-141-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

In effect, hoist the check for mttcg from tcg_n_regions()
to tcg_init_machine().

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/startup.h |  6 +++---
 tcg/tcg-internal.h    |  2 +-
 accel/tcg/tcg-all.c   | 14 ++++++++------
 tcg/region.c          | 27 ++++++++++++---------------
 tcg/tcg.c             | 14 +++++++-------
 5 files changed, 31 insertions(+), 32 deletions(-)

diff --git a/include/tcg/startup.h b/include/tcg/startup.h
index f71305765c..95f574af2b 100644
--- a/include/tcg/startup.h
+++ b/include/tcg/startup.h
@@ -29,12 +29,12 @@
  * tcg_init: Initialize the TCG runtime
  * @tb_size: translation buffer size
  * @splitwx: use separate rw and rx mappings
- * @max_cpus: number of vcpus in system mode
+ * @max_threads: number of vcpu threads in system mode
  *
  * Allocate and initialize TCG resources, especially the JIT buffer.
- * In user-only mode, @max_cpus is unused.
+ * In user-only mode, @max_threads is unused.
  */
-void tcg_init(size_t tb_size, int splitwx, unsigned max_cpus);
+void tcg_init(size_t tb_size, int splitwx, unsigned max_threads);
 
 /**
  * tcg_register_thread: Register this thread with the TCG runtime
diff --git a/tcg/tcg-internal.h b/tcg/tcg-internal.h
index a648ee7a0e..ff85fb23fa 100644
--- a/tcg/tcg-internal.h
+++ b/tcg/tcg-internal.h
@@ -34,7 +34,7 @@ extern TCGContext **tcg_ctxs;
 extern unsigned int tcg_cur_ctxs;
 extern unsigned int tcg_max_ctxs;
 
-void tcg_region_init(size_t tb_size, int splitwx, unsigned max_cpus);
+void tcg_region_init(size_t tb_size, int splitwx, unsigned max_threads);
 bool tcg_region_alloc(TCGContext *s);
 void tcg_region_initial_alloc(TCGContext *s);
 void tcg_region_prologue_set(TCGContext *s);
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index a5a1fd6a11..3efc7350eb 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -103,18 +103,20 @@ bool one_insn_per_tb;
 static int tcg_init_machine(MachineState *ms)
 {
     TCGState *s = TCG_STATE(current_accel());
-#ifdef CONFIG_USER_ONLY
-    unsigned max_cpus = 1;
-#else
-    unsigned max_cpus = ms->smp.max_cpus;
-#endif
+    unsigned max_threads = 1;
 
     tcg_allowed = true;
     mttcg_enabled = s->mttcg_enabled;
 
     page_init();
     tb_htable_init();
-    tcg_init(s->tb_size * MiB, s->splitwx_enabled, max_cpus);
+
+#ifndef CONFIG_USER_ONLY
+    if (mttcg_enabled) {
+        max_threads = ms->smp.max_cpus;
+    }
+#endif
+    tcg_init(s->tb_size * MiB, s->splitwx_enabled, max_threads);
 
 #if defined(CONFIG_SOFTMMU)
     /*
diff --git a/tcg/region.c b/tcg/region.c
index 478ec051c4..7ea0b37a84 100644
--- a/tcg/region.c
+++ b/tcg/region.c
@@ -422,7 +422,7 @@ void tcg_region_reset_all(void)
     tcg_region_tree_reset_all();
 }
 
-static size_t tcg_n_regions(size_t tb_size, unsigned max_cpus)
+static size_t tcg_n_regions(size_t tb_size, unsigned max_threads)
 {
 #ifdef CONFIG_USER_ONLY
     return 1;
@@ -431,24 +431,25 @@ static size_t tcg_n_regions(size_t tb_size, unsigned max_cpus)
 
     /*
      * It is likely that some vCPUs will translate more code than others,
-     * so we first try to set more regions than max_cpus, with those regions
+     * so we first try to set more regions than threads, with those regions
      * being of reasonable size. If that's not possible we make do by evenly
      * dividing the code_gen_buffer among the vCPUs.
+     *
+     * Use a single region if all we have is one vCPU thread.
      */
-    /* Use a single region if all we have is one vCPU thread */
-    if (max_cpus == 1 || !qemu_tcg_mttcg_enabled()) {
+    if (max_threads == 1) {
         return 1;
     }
 
     /*
-     * Try to have more regions than max_cpus, with each region being >= 2 MB.
+     * Try to have more regions than threads, with each region being >= 2 MB.
      * If we can't, then just allocate one region per vCPU thread.
      */
     n_regions = tb_size / (2 * MiB);
-    if (n_regions <= max_cpus) {
-        return max_cpus;
+    if (n_regions <= max_threads) {
+        return max_threads;
     }
-    return MIN(n_regions, max_cpus * 8);
+    return MIN(n_regions, max_threads * 8);
 #endif
 }
 
@@ -731,11 +732,7 @@ static int alloc_code_gen_buffer(size_t size, int splitwx, Error **errp)
  * and then assigning regions to TCG threads so that the threads can translate
  * code in parallel without synchronization.
  *
- * In system-mode the number of TCG threads is bounded by max_cpus, so we use at
- * least max_cpus regions in MTTCG. In !MTTCG we use a single region.
- * Note that the TCG options from the command-line (i.e. -accel accel=tcg,[...])
- * must have been parsed before calling this function, since it calls
- * qemu_tcg_mttcg_enabled().
+ * In system-mode the number of TCG threads is bounded by max_threads,
  *
  * In user-mode we use a single region.  Having multiple regions in user-mode
  * is not supported, because the number of vCPU threads (recall that each thread
@@ -749,7 +746,7 @@ static int alloc_code_gen_buffer(size_t size, int splitwx, Error **errp)
  * in practice. Multi-threaded guests share most if not all of their translated
  * code, which makes parallel code generation less appealing than in system-mode
  */
-void tcg_region_init(size_t tb_size, int splitwx, unsigned max_cpus)
+void tcg_region_init(size_t tb_size, int splitwx, unsigned max_threads)
 {
     const size_t page_size = qemu_real_host_page_size();
     size_t region_size;
@@ -787,7 +784,7 @@ void tcg_region_init(size_t tb_size, int splitwx, unsigned max_cpus)
      * As a result of this we might end up with a few extra pages at the end of
      * the buffer; we will assign those to the last region.
      */
-    region.n = tcg_n_regions(tb_size, max_cpus);
+    region.n = tcg_n_regions(tb_size, max_threads);
     region_size = tb_size / region.n;
     region_size = QEMU_ALIGN_DOWN(region_size, page_size);
 
diff --git a/tcg/tcg.c b/tcg/tcg.c
index dfd48b8264..ec7f6743d7 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1499,7 +1499,7 @@ static void process_constraint_sets(void);
 static TCGTemp *tcg_global_reg_new_internal(TCGContext *s, TCGType type,
                                             TCGReg reg, const char *name);
 
-static void tcg_context_init(unsigned max_cpus)
+static void tcg_context_init(unsigned max_threads)
 {
     TCGContext *s = &tcg_init_ctx;
     int n, i;
@@ -1538,15 +1538,15 @@ static void tcg_context_init(unsigned max_cpus)
      * In user-mode we simply share the init context among threads, since we
      * use a single region. See the documentation tcg_region_init() for the
      * reasoning behind this.
-     * In system-mode we will have at most max_cpus TCG threads.
+     * In system-mode we will have at most max_threads TCG threads.
      */
 #ifdef CONFIG_USER_ONLY
     tcg_ctxs = &tcg_ctx;
     tcg_cur_ctxs = 1;
     tcg_max_ctxs = 1;
 #else
-    tcg_max_ctxs = max_cpus;
-    tcg_ctxs = g_new0(TCGContext *, max_cpus);
+    tcg_max_ctxs = max_threads;
+    tcg_ctxs = g_new0(TCGContext *, max_threads);
 #endif
 
     tcg_debug_assert(!tcg_regset_test_reg(s->reserved_regs, TCG_AREG0));
@@ -1554,10 +1554,10 @@ static void tcg_context_init(unsigned max_cpus)
     tcg_env = temp_tcgv_ptr(ts);
 }
 
-void tcg_init(size_t tb_size, int splitwx, unsigned max_cpus)
+void tcg_init(size_t tb_size, int splitwx, unsigned max_threads)
 {
-    tcg_context_init(max_cpus);
-    tcg_region_init(tb_size, splitwx, max_cpus);
+    tcg_context_init(max_threads);
+    tcg_region_init(tb_size, splitwx, max_threads);
 }
 
 /*
-- 
2.43.0


