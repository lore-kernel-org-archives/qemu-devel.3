Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E001EDEBFD
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 01:53:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxbPi-000637-C5; Tue, 03 Mar 2026 20:52:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1vxbPh-00062y-4i
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 20:52:37 -0500
Received: from mail-vs1-xe2a.google.com ([2607:f8b0:4864:20::e2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1vxbPf-0004UM-MV
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 20:52:36 -0500
Received: by mail-vs1-xe2a.google.com with SMTP id
 ada2fe7eead31-5ffa0b23a1aso250650137.3
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 17:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772589154; x=1773193954; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fdxVAJZzyfNVW1udrhdUFVJfrw+pt2l9y2/jEQPXbUc=;
 b=RbZQvrbyB5hHHP7v7rZRbPB16EcAfe6KYvixmS5vIsFpD8J5FCyrV2cVlzES5hJvzH
 EGgKZ7pOFSLtNU3SeI48L/02DeOpXTTk14pGku6j4dLWB+ZdXaAMpkYSUoC8r+9Adk8d
 1fTzpseJ8KXrCZUAO4dPZl2rvdgVbX+5m3Xx/yIlI2FXxQKzRP3SjZGlue26tRI7KTCX
 yNJEw/+RbW5LL2HtfkIt1sjMwNNrOA4g34ewOvWaAXSeAge7OTwOyjh2TukRN65ADwE8
 lthWrhcs5s84DXKtwVIiBFlwP/kp9RO0MuhEkHGc/Iklrffy/kEtL+zkW26TwKhsHMW2
 9xkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772589154; x=1773193954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fdxVAJZzyfNVW1udrhdUFVJfrw+pt2l9y2/jEQPXbUc=;
 b=tETsVvR8VF7eBbcUblZw6ZVMMd1ZAEhwXiA1NOPlt0kbLB1eiqTVdRKk90XfspNfQo
 IO7ZtoNJIg3cDe6d02QgV0vvgcUevQXptMgq1syfP6hTIBImpXlQqOVLyJBYBoQKzNo7
 Vx/RBTEumnSv+gS7dzk68HgxZcPsEaixcXzFuUKKbaYw+WSHGimwkDQEx6Qw1OwCg2ge
 b/ICaswi6JHRHCGXAGqO7LXpbmu8fWp6QPpoDKlcATX+q5H7Dgtl9KbldcTKQ3QP7cpw
 T0LQ4X0epVsgD92XlLrtz4w1ncTOJcI9xAGydnS1WMNfg824JXyuS2McbEWxViPagcrY
 HJ7Q==
X-Gm-Message-State: AOJu0YweLcr8w9G6qn9/WgM2SJChpRf5hEqCndVgvGKhXX4LMAiEcWvh
 RV7UCUR0J6HpxyJ9RM1NdQVSghzBfRaD3S4VdPT/3LZmif2+0g1xn69xfLPGeX2O
X-Gm-Gg: ATEYQzwoyEWiwWq95s0U140Z9voLBnlAek2lNUTTWe6e7B2Jbwapyw3UB5YBfHHLL1+
 1S9V77FXA1OYQdWnmzyXWEs5K7GuRJZhO76Injrxugpn+LWVBiu8ZpDxgt1VuXbj+Y1ZBhIi7Zh
 QHksFXzLxnSboRcjM+FUXELInS7ZvncnfiRRW+nc6Qa7W7le6CM52GxP2tsz1aufEaPuSRrUyLH
 CrKJRfYk7LEzPX9bFpGboVnfmSR9HNwpSaVa7p3IWmyIcoperIrPjApjiIcM2vgBWTWkpPrKH26
 x9m9HOV+fMvuGaIgDBgA20WtFCvVNIEBieiPNvKCA8gFQ5B86soWWJC0g1Cgjpdo05VhLUbdgjb
 FYBD84KkeXiyShcZjqOXI16NoCX0mH8mybj81vgPdI5NrZ4pcOHdZEEb1Dsx4nt/G45koDIcKSx
 R1M11WEtw1yoJT/AuIW0Umlivvlx66g81u+IUUVd9zo8BvqV2yBUG/E77EsQ==
X-Received: by 2002:a05:6102:2922:b0:5fc:2b19:f7de with SMTP id
 ada2fe7eead31-5ffaae9984fmr215631137.25.1772589153980; 
 Tue, 03 Mar 2026 17:52:33 -0800 (PST)
Received: from gmail.com (ip190-5-140-138.intercom.com.sv. [190.5.140.138])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-94df641e133sm16763221241.5.2026.03.03.17.52.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 17:52:33 -0800 (PST)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: sstabellini@kernel.org, anthony@xenproject.org, edgar.iglesias@amd.com,
 xen-devel@lists.xenproject.org
Subject: [PATCH v1 3/5] physmem: xen: Conditionalize use of the mapcache
Date: Wed,  4 Mar 2026 02:52:19 +0100
Message-ID: <20260304015222.979224-4-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260304015222.979224-1-edgar.iglesias@gmail.com>
References: <20260304015222.979224-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2a;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-vs1-xe2a.google.com
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

Conditionalize use of the mapcache. This is in preparation
to optionally disable the mapcache at runtime.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 system/physmem.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index e5ff26acec..64e6d50f8f 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -578,7 +578,8 @@ MemoryRegion *flatview_translate(FlatView *fv, hwaddr addr, hwaddr *xlat,
                                     is_write, true, &as, attrs);
     mr = section.mr;
 
-    if (xen_enabled() && memory_access_is_direct(mr, is_write, attrs)) {
+    if (xen_map_cache_enabled() &&
+        memory_access_is_direct(mr, is_write, attrs)) {
         hwaddr page = ((addr & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE) - addr;
         *plen = MIN(page, *plen);
     }
@@ -2577,7 +2578,7 @@ static void reclaim_ramblock(RAMBlock *block)
 {
     if (block->flags & RAM_PREALLOC) {
         ;
-    } else if (xen_enabled()) {
+    } else if (xen_map_cache_enabled()) {
         xen_invalidate_map_cache_entry(block->host);
 #if !defined(_WIN32) && !defined(EMSCRIPTEN)
     } else if (block->fd >= 0) {
@@ -2736,7 +2737,7 @@ static void *qemu_ram_ptr_length(RAMBlock *block, ram_addr_t addr,
         len = *size;
     }
 
-    if (xen_enabled() && block->host == NULL) {
+    if (xen_map_cache_enabled() && block->host == NULL) {
         /* We need to check if the requested address is in the RAM
          * because we don't want to map the entire memory in QEMU.
          * In that case just map the requested area.
@@ -2785,7 +2786,7 @@ RAMBlock *qemu_ram_block_from_host(void *ptr, bool round_offset,
     RAMBlock *block;
     uint8_t *host = ptr;
 
-    if (xen_enabled()) {
+    if (xen_map_cache_enabled()) {
         ram_addr_t ram_addr;
         RCU_READ_LOCK_GUARD();
         ram_addr = xen_ram_addr_from_mapcache(ptr);
@@ -3787,7 +3788,7 @@ void address_space_unmap(AddressSpace *as, void *buffer, hwaddr len,
         if (is_write) {
             invalidate_and_set_dirty(mr, addr1, access_len);
         }
-        if (xen_enabled()) {
+        if (xen_map_cache_enabled()) {
             xen_invalidate_map_cache_entry(buffer);
         }
         memory_region_unref(mr);
@@ -3898,7 +3899,7 @@ void address_space_cache_destroy(MemoryRegionCache *cache)
         return;
     }
 
-    if (xen_enabled()) {
+    if (xen_map_cache_enabled()) {
         xen_invalidate_map_cache_entry(cache->ptr);
     }
     memory_region_unref(cache->mrs.mr);
-- 
2.43.0


