Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86838606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 16:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Mjg2eq9x
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQRx4-0000AI-TU; Mon, 09 Nov 2026 11:10:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xQRwv-00007z-T4
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 11:10:26 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xQRws-0005pT-Hg
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 11:10:25 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-8b2382bf051so562358b3a.3
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 08:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794240621; x=1794845421; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Y5hNN5e5dzg1FCTjhO65YVXMn+heooTu+Udt9f79p3U=;
 b=Mjg2eq9x9C3PjY4EQsljVUb9Ljw9/4fqy8tvRhcmIFjN2k/yCaZ/EDxpBQbWr4Rqvs
 dYo76Wqo6/fKzw3FW/uIR8eyJW5Pan4vb3brcP3tvyOtwt0Sh+yyaKG+U9qK0iTLQUrj
 3lHOpE0UuHnRDcj9aYUs1patmOJvnxZiTw32WULe90/ogl/yObtS+4vlZvjMrgmblQPf
 HLg/DA9G8RQdJf+GbtFydxefK8ragO/X52fxMB73pUqjhje8d9nVo18DDRRr9CDDyuF3
 G86lcV7IMZ1/uYR21N3MCJndaYtNTqs3fGY0WNede7zLb2lnawt7/3uOjU8le0O56WpZ
 J/CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794240621; x=1794845421;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Y5hNN5e5dzg1FCTjhO65YVXMn+heooTu+Udt9f79p3U=;
 b=04XgYwpFJ7OGDlEYF8yz0Nq+7kD41+S34JY0qQXIfrCO9ua6NO8VtuB3fTgtHQ6d0m
 eHCzhcTSObckeJXJmD4qOg+xt5fyptZD2a42zorneCGkr2NCWeZKlP/1oXeq2Jyhq5G/
 4yV1WS/1YxYGMtRPEYi/EUyrBwDQxCAOooHcVzVj/lyV6dAjFZYiHBOnRNMu0G3WQIXY
 r9F9BdQ6cFrKdNpiPtXqBEhAbsld703KaUPkDC1n5EDPopTHozQpWmW5GeD7QvnZYNKc
 NbXpA22yevr5xfDKrUC85dZ8ot3nk6PyvuG7LfazpK+v+ra0pwTY6GelpwzfQ4NbiTCI
 g1uQ==
X-Gm-Message-State: APuU4Z/bmcoitbRUnGvqDClBcHNuQMJiuK/KKybWxWkEiTog0Gv+DH+h
 V0ORU+rGUe2l2H2IUQfCba1PV/+uLqdsCsGY3itw/hxxXfsHsHjJ25QaVAxzZXDFfkBWPfxJkAT
 jWYbD
X-Gm-Gg: AYBFou25I4cMUZhLWZbkT+qz+19mP8RGJfd3Ou/gugPlIQn08BJfOv3dDOkxFma4Z4p
 C9XiHVbzW6y4i0GF4YP9peb4uWKfEet8c+7PWkoL1kshr/erNBDsSCyE5fQZzuI1PWiyXqPlgvP
 niJVi89SUSkS2UIXstiWroiIl3TQf/oGm4GMqzAoDYaVHbmw/jaGXyffD8UHF4fCbaCUvfkTTPZ
 0uAceOEf8E5EfvR5gVgxnze995N2UkqgGGjLFTRgrGyHvsGl/tfLxrFpeJ4zTqIm8SfGatESsk5
 OEqT5VS1Cju4yftGmVbr9RL2Tp2whHH+p4sDNkK/dpq0DzkmQdcUf9ZDJECCl/4hvnHLURSztTy
 1XcwohaWGgJLvMPPtiFtGngb1FN6A91r85evHJHRazTzF8L0DlrAyWzFlMQ4MO8UbhX90eFltvz
 SBteZT5gcOe5zLaOvu2XH4NO0CsDAgkfwSRn8A4f8XfWGY7VDW5oXjZbZGqODFT42ffRovTKdeY
 DwRSkVFekzJrSvcaaP9B7kbNoGFVTAjpJCeXvQKQEdUikv0HLdhtHfy3vuyDL2qMKdpp5SEm5M5
 ES6DjyTzU+I0cnRukAML4Zr91jpIesddiDr2AbLDchmfUG9ORDFDbqiactJu
X-Received: by 2002:a05:6a20:da14:b0:3eb:2f53:bdc6 with SMTP id
 adf61e73a8af0-3eed2022137mr4479377637.23.1794240620819; 
 Mon, 09 Nov 2026 08:10:20 -0800 (PST)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8b648e55e85sm1598946b3a.17.2026.11.09.08.10.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 08:10:20 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH 2/2] accel/tcg: Adjust tlb assertions to allow stopped cpus
Date: Mon,  9 Nov 2026 08:10:16 -0800
Message-ID: <20261109161016.43218-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109161016.43218-1-richard.henderson@linaro.org>
References: <20261109161016.43218-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The intent of the assert has always been to prevent operating
on a foreign running cpu -- we must use run_on for that.
Not created is certainly one condition for not running but
there are others, including case at issue here of reset.

Rename the assert and expand the condition to all stopped cpus.
Enable the assertion with --enable-debug-tcg, not a private
define that is never enabled in practice.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3092
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 36 +++++++++++++++---------------------
 1 file changed, 15 insertions(+), 21 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index efb8fb1f57..3ca484b039 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -55,20 +55,14 @@
 #include "backend-ldst.h"
 
 
-/* DEBUG defines */
-#define DEBUG_TLB
-
-#ifdef DEBUG_TLB
-# define DEBUG_TLB_GATE 1
+#ifdef CONFIG_DEBUG_TCG
+#define assert_cpu_is_self_or_stopped(cpu) \
+    assert(qemu_cpu_is_self(cpu) || cpu_is_stopped(cpu))
 #else
-# define DEBUG_TLB_GATE 0
+#define assert_cpu_is_self_or_stopped(cpu) \
+    do { (void)(cpu); } while (0)
 #endif
 
-#define assert_cpu_is_self(cpu) do {                              \
-        if (DEBUG_TLB_GATE) {                                     \
-            g_assert(!(cpu)->created || qemu_cpu_is_self(cpu));   \
-        }                                                         \
-    } while (0)
 
 /* run_on_cpu_data.target_ptr should always be big enough for a
  * vaddr even on 32 bit builds
@@ -357,7 +351,7 @@ static void tlb_flush_by_mmuidx_async_work(CPUState *cpu, run_on_cpu_data data)
     MMUIdxMap all_dirty, work, to_clean;
     int64_t now = get_clock_realtime();
 
-    assert_cpu_is_self(cpu);
+    assert_cpu_is_self_or_stopped(cpu);
 
     qemu_spin_lock(&cpu->neg.tlb.c.lock);
 
@@ -391,7 +385,7 @@ static void tlb_flush_by_mmuidx_async_work(CPUState *cpu, run_on_cpu_data data)
 
 void tlb_flush_by_mmuidx(CPUState *cpu, MMUIdxMap idxmap)
 {
-    assert_cpu_is_self(cpu);
+    assert_cpu_is_self_or_stopped(cpu);
 
     tlb_flush_by_mmuidx_async_work(cpu, RUN_ON_CPU_HOST_INT(idxmap));
 }
@@ -464,7 +458,7 @@ static void tlb_flush_vtlb_page_mask_locked(CPUState *cpu, int mmu_idx,
     CPUTLBDesc *d = &cpu->neg.tlb.d[mmu_idx];
     int k;
 
-    assert_cpu_is_self(cpu);
+    assert_cpu_is_self_or_stopped(cpu);
     for (k = 0; k < CPU_VTLB_SIZE; k++) {
         if (tlb_flush_entry_mask_locked(&d->vtable[k], page, mask)) {
             tlb_n_used_entries_dec(cpu, mmu_idx);
@@ -509,7 +503,7 @@ static void tlb_flush_page_by_mmuidx_async_0(CPUState *cpu,
 {
     int mmu_idx;
 
-    assert_cpu_is_self(cpu);
+    assert_cpu_is_self_or_stopped(cpu);
 
     qemu_spin_lock(&cpu->neg.tlb.c.lock);
     for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
@@ -573,7 +567,7 @@ static void tlb_flush_page_by_mmuidx_async_2(CPUState *cpu,
 
 void tlb_flush_page_by_mmuidx(CPUState *cpu, vaddr addr, MMUIdxMap idxmap)
 {
-    assert_cpu_is_self(cpu);
+    assert_cpu_is_self_or_stopped(cpu);
 
     /* This should already be page aligned */
     addr &= TARGET_PAGE_MASK;
@@ -686,7 +680,7 @@ static void tlb_flush_range_by_mmuidx_async_0(CPUState *cpu,
 {
     int mmu_idx;
 
-    assert_cpu_is_self(cpu);
+    assert_cpu_is_self_or_stopped(cpu);
 
     qemu_spin_lock(&cpu->neg.tlb.c.lock);
     for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
@@ -730,7 +724,7 @@ void tlb_flush_range_by_mmuidx(CPUState *cpu, vaddr addr,
 {
     TLBFlushRangeData d;
 
-    assert_cpu_is_self(cpu);
+    assert_cpu_is_self_or_stopped(cpu);
 
     /* If no page bits are significant, this devolves to tlb_flush. */
     if (bits < TARGET_PAGE_BITS) {
@@ -915,7 +909,7 @@ static void tlb_set_dirty(CPUState *cpu, vaddr addr)
 {
     int mmu_idx;
 
-    assert_cpu_is_self(cpu);
+    assert_cpu_is_self_or_stopped(cpu);
 
     addr &= TARGET_PAGE_MASK;
     qemu_spin_lock(&cpu->neg.tlb.c.lock);
@@ -996,7 +990,7 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
     int asidx, wp_flags, prot;
     bool is_ram, is_romd;
 
-    assert_cpu_is_self(cpu);
+    assert_cpu_is_self_or_stopped(cpu);
 
     if (full->lg_page_size <= TARGET_PAGE_BITS) {
         sz = TARGET_PAGE_SIZE;
@@ -1265,7 +1259,7 @@ static bool victim_tlb_hit(CPUState *cpu, size_t mmu_idx, size_t index,
 {
     size_t vidx;
 
-    assert_cpu_is_self(cpu);
+    assert_cpu_is_self_or_stopped(cpu);
     for (vidx = 0; vidx < CPU_VTLB_SIZE; ++vidx) {
         CPUTLBEntry *vtlb = &cpu->neg.tlb.d[mmu_idx].vtable[vidx];
         uint64_t cmp = tlb_read_idx(vtlb, access_type);
-- 
2.53.0


