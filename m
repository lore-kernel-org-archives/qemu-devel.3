Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4AE606A68A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 22:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ONJKh292
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUXSM-0000Y3-DC; Fri, 20 Nov 2026 17:51:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xUXSK-0000Wq-7Z
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 17:51:44 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xUXSI-00051u-8B
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 17:51:43 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2e9ae391a05so9612735ad.1
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 14:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795215100; x=1795819900; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MbGV1GFczD/HE31+J8tctQdQk/jk3XasUesAoyplevQ=;
 b=ONJKh292JvnpZiBUzUJOCPxt5nUbiBPzoLgYInkQGgHcye3oUEczzBtwjlW0wEC4R4
 6S7uReqAsOonSfZkNugXCc3C7bWwcxsJK/v0ExQ7ZqepZQjUDrqWjk/pDlkeE+bsNgu6
 48LWKBcm9JQ9c8zWC33DVfy9C7Ft/1QM4sg+Vn4xY4KhLtvKesORj3485OYt7BAspY3k
 wMILzj4e6pYTnCulrN89zgbpIdJh7eEt2Iw8T3To5PTPPYCzRLQHb0WVXlbpuHT8Wi7g
 dLTAzQk+TgNpdHmT25QOqv1eE7cYBbN4OrMR2FiwbEW25JxzBcrioSa8GrmjRn/GNv/K
 X4Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795215100; x=1795819900;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MbGV1GFczD/HE31+J8tctQdQk/jk3XasUesAoyplevQ=;
 b=P/WOn3kIDsaMjqh/DgZk7XXGRVbqMiqZFVvgiSxr3o8il/nCGrPfMe8gvAEUG8km7x
 Dj9iVmNYwpX4gTobVJQdmUbqJAvfPlDR+ky91lIz+CRInCqKlcE3RFI2Dn6VUhBxp/Sw
 b10p4pJVqu+anfwten3CRDzc9/auP4M99V/S9x0HmGj6NQ/85MPWM3oSubFPLeUhCh3W
 d9JhfvnMi5IXVeNfl46bDitXFdbkJeCqqgnbV9nbFahm1wc54o6DgDQiOZomRDsqqwBd
 0dw8RP1RmIxc5Dcx87yA/w3iYJzDiV84Qs5CHGUD86xAvYqzb7bE7Z7t83ndA66L4Jqf
 pkuQ==
X-Gm-Message-State: APuU4Z9S1yZCliyRFedqfGuv7DpG1K214Of68O+Ox2o6obWcRTsyvLy8
 bxwQxSHIwuieKkqmyJc01fhCbw+V9pAAsmvUIqKVQca7zrPOv+RbQ+7Wns2MLA+P+dLpDI9YreA
 g9rOw
X-Gm-Gg: AZFdTZd6Qcv1dTLE6hcKDz71wPJDDeDd/BmfRP/uZ7XSra6P6wV36xBKOeRx+No5AGu
 RYvhnFXR9O2pu1Qa5AV6BfoYMgPTujau/+OCZXdBhSor1wFO7k2H/dj25gWuv250qwQtPF1gBLS
 Rhliz8Wj311AI8upyhCvBVFFtfONMfRbY1j7i5G8s24zuaNDrQnM/yYy88L2lnB0ErE19J0afm9
 9C6IIrktELmNvgAciWZdSbYkO89mx2WwcUJuIH9veRwu6sHWjQ65ZMUCINFAGIPPWJKmbGXJUEG
 P73rBfGpI2Uy+mVkh30ADLnRCWpNNxW1kcw5LLwb7fIgDw9xnN2ZAGVa4VQ6GYcb4jw+sZGaZbG
 5A98Pu1EHLuL8kXeD7eYPb8EXzgGXLMgPBf3QMP7yePZbMz/lLH883Ik6G+NcYLeE9UEcvbptmY
 Yekb6QJ+eB66b1vDUuqUQqBdRzSF6ggJ/bCnPZHQpINnqgGNZXrzqZxgEXjn82A+HpQO6M/CIYd
 6ZL2RfRCdj5IOdibdYPElh5DclE455z2ZMYxw4wrB3WIV5v3SgVR7yrHPD/X/TLvZRtF5AwUdxV
 8eRXElaze1Xv6H0JHZk+dJEz1V8w52Dk8PPB3n7dW/XDiEaWZLo/A1/eevm3
X-Received: by 2002:a17:903:32ca:b0:2e5:41d6:178c with SMTP id
 d9443c01a7336-2f03f20f8d0mr34365435ad.33.1795215100223; 
 Fri, 20 Nov 2026 14:51:40 -0800 (PST)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2f0433a3a43sm15669055ad.62.2026.11.20.14.51.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 14:51:39 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 2/5] accel/tcg: Adjust tlb assertions to allow stopped cpus
Date: Fri, 20 Nov 2026 14:51:35 -0800
Message-ID: <20261120225138.7198-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261120225138.7198-1-richard.henderson@linaro.org>
References: <20261120225138.7198-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
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


