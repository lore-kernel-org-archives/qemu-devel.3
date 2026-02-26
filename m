Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F1EFD9E1A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 22:03:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvjRp-0002XK-FA; Thu, 26 Feb 2026 17:03:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvjRf-0002WH-02
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 17:03:02 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvjRc-0001td-VH
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 17:02:54 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4836f4cbe0bso12382415e9.3
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 14:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772143371; x=1772748171; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WCZUc1LA8R4v0JRjwSW69cVOsM9EcduzH6g7RYX1cUA=;
 b=urH1xcI6Ebn5pm8kgeV9/rDHPjvQeSCUDSTkPw3HzdmACA2YrUqJWX0Gpf18Sh8OLQ
 rlrEi9tE8QBq+MSYXpKaUvL7qGWWV8yyCSQpGvTcBhhz5oCHhvvnAHuLaJpzp1xJbSOx
 aAM048gdU8kKOVTG/RQo2krYkb6zpN+2rYweFsRR1xeMoWZIrbC44+SRtGdrkDjlmUTi
 //c9WQoR8AHwT7g/9GxI5HSsSA58hs0P1436qTTDMyM0vK6wnF1uimrfG3Yk5nOpKIFM
 sbp2A82zI/m69FmRAUs/wvw0QNK9HfFe0uVLH9FOTBkm86SgWKLCLbHjcJ4c50sf6fcg
 eNxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772143371; x=1772748171;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WCZUc1LA8R4v0JRjwSW69cVOsM9EcduzH6g7RYX1cUA=;
 b=Aa4I5MIk0dVBasgDUlEOlWU0zcapdG0iN5cYN5NflkXoaHgyb6JALyylDMRrt+aNEH
 0jLK0fnL27oq1fg6Q0X1apidARssmOiLLaQBijZjJdCEDGVydslN2s1pDGuiLxlAsb7e
 m9O3S/z+C1DbK8Yfcf45CUPFsUFDCQNscnbA7DsqtwPLKUcepIT5e6eVUolBaUK6xsZm
 tiVT+tGlKjVi5n50sn9jqbkQq04It+qJPP9XAGFZnFM6mWVAKPEUfen4tEb478n9SiiJ
 PNpnuM1GzxpjGcpI4Ph/I7pSgxeFZya8nExnREEbWyG1MNZFGPMrzTsAicCjFIlxuIvV
 SMfA==
X-Gm-Message-State: AOJu0YwK9oWFM5V0JPTOcaO+Z6sRoKhxPOfL8O+MlzCVCgG8Z6sHNQzZ
 Vzpz6LDipbPpEuPt/wLAvczVvSHhiTCh07xgT5+DvqeC2RaPokvbB1QB1Ay5PT7tqS8wmauLHqY
 e1mZlsRk=
X-Gm-Gg: ATEYQzzsIqc6TxuYHXcgfvwJ0F4nZ+XR+7YlNcmO0nIw005GoUikRmZclIUA3czGugR
 Z5TECh+LZWmhBat2IFg9hx2f+t1qScGkeN+xcdPkUJqpzSvcqZ5Sj42vAwE4/waPqi+f+iAW1Qh
 zDWNgbt/xFhCs5us1QLnErHnGVmkhmXaDix9kiE21w8n3C2uEhz1kxsimkHkva5Z1BxOsW+CyXc
 iIEOBt10XKfRjBshpp6uyniTXfm5XxNl/DI7TIV2vHvQs5sHYWEQ1gyUqQe8Fm1x7L5OwIS2ZoO
 iQiOd3J6scFpd/J4p3fY28su3rVUjrRKVwln2AR52KiAnt3gv+SBUpgXexzTkXB9BxgyebwHUGA
 31hK0WFsN0aJPvuGmLHC/VokrjrXKhdurAoKle8nIPgKyH2SqOMPazjU0NrfoUp0TpiBhhN4AMs
 Ue7aQ6qbjEjnkplsO/Y6u3LdxVJNLibAFPzY+gcb+WvK9r3mmlg4iQyHFNz5dTsPWtLgrI0TpT
X-Received: by 2002:a05:600c:4f11:b0:477:7925:f7fb with SMTP id
 5b1f17b1804b1-483c9babeaamr6690795e9.10.1772143371096; 
 Thu, 26 Feb 2026 14:02:51 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483c3b84023sm68696045e9.12.2026.02.26.14.02.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 26 Feb 2026 14:02:50 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH 3/7] system/memory: Constify various MemoryRegion arguments
Date: Thu, 26 Feb 2026 23:02:21 +0100
Message-ID: <20260226220226.20164-4-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260226220226.20164-1-philmd@linaro.org>
References: <20260226220226.20164-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Mark the MemoryRegion structure const when is only accessed read-only.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/memory.h | 28 ++++++++++++++--------------
 system/memory.c         | 34 ++++++++++++++++++----------------
 2 files changed, 32 insertions(+), 30 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index 0562af31361..baa6a840375 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -1749,14 +1749,14 @@ bool memory_region_init_rom_device(MemoryRegion *mr,
  *
  * @mr: the memory region being queried.
  */
-Object *memory_region_owner(MemoryRegion *mr);
+Object *memory_region_owner(const MemoryRegion *mr);
 
 /**
  * memory_region_size: get a memory region's size.
  *
  * @mr: the memory region being queried.
  */
-uint64_t memory_region_size(MemoryRegion *mr);
+uint64_t memory_region_size(const MemoryRegion *mr);
 
 /**
  * memory_region_is_ram: check whether a memory region is random access
@@ -1765,7 +1765,7 @@ uint64_t memory_region_size(MemoryRegion *mr);
  *
  * @mr: the memory region being queried
  */
-static inline bool memory_region_is_ram(MemoryRegion *mr)
+static inline bool memory_region_is_ram(const MemoryRegion *mr)
 {
     return mr->ram;
 }
@@ -1777,7 +1777,7 @@ static inline bool memory_region_is_ram(MemoryRegion *mr)
  *
  * @mr: the memory region being queried
  */
-bool memory_region_is_ram_device(MemoryRegion *mr);
+bool memory_region_is_ram_device(const MemoryRegion *mr);
 
 /**
  * memory_region_is_romd: check whether a memory region is in ROMD mode
@@ -1787,7 +1787,7 @@ bool memory_region_is_ram_device(MemoryRegion *mr);
  *
  * @mr: the memory region being queried
  */
-static inline bool memory_region_is_romd(MemoryRegion *mr)
+static inline bool memory_region_is_romd(const MemoryRegion *mr)
 {
     return mr->rom_device && mr->romd_mode;
 }
@@ -1800,7 +1800,7 @@ static inline bool memory_region_is_romd(MemoryRegion *mr)
  *
  * @mr: the memory region being queried
  */
-bool memory_region_is_protected(MemoryRegion *mr);
+bool memory_region_is_protected(const MemoryRegion *mr);
 
 /**
  * memory_region_has_guest_memfd: check whether a memory region has guest_memfd
@@ -1810,7 +1810,7 @@ bool memory_region_is_protected(MemoryRegion *mr);
  *
  * @mr: the memory region being queried
  */
-bool memory_region_has_guest_memfd(MemoryRegion *mr);
+bool memory_region_has_guest_memfd(const MemoryRegion *mr);
 
 /**
  * memory_region_get_iommu: check whether a memory region is an iommu
@@ -1820,7 +1820,7 @@ bool memory_region_has_guest_memfd(MemoryRegion *mr);
  *
  * @mr: the memory region being queried
  */
-static inline IOMMUMemoryRegion *memory_region_get_iommu(MemoryRegion *mr)
+static inline IOMMUMemoryRegion *memory_region_get_iommu(const MemoryRegion *mr)
 {
     if (mr->alias) {
         return memory_region_get_iommu(mr->alias);
@@ -1991,7 +1991,7 @@ const char *memory_region_name(const MemoryRegion *mr);
  * @mr: the memory region being queried
  * @client: the client being queried
  */
-bool memory_region_is_logging(MemoryRegion *mr, uint8_t client);
+bool memory_region_is_logging(const MemoryRegion *mr, uint8_t client);
 
 /**
  * memory_region_get_dirty_log_mask: return the clients for which a
@@ -2002,7 +2002,7 @@ bool memory_region_is_logging(MemoryRegion *mr, uint8_t client);
  *
  * @mr: the memory region being queried
  */
-uint8_t memory_region_get_dirty_log_mask(MemoryRegion *mr);
+uint8_t memory_region_get_dirty_log_mask(const MemoryRegion *mr);
 
 /**
  * memory_region_is_rom: check whether a memory region is ROM
@@ -2011,7 +2011,7 @@ uint8_t memory_region_get_dirty_log_mask(MemoryRegion *mr);
  *
  * @mr: the memory region being queried
  */
-static inline bool memory_region_is_rom(MemoryRegion *mr)
+static inline bool memory_region_is_rom(const MemoryRegion *mr)
 {
     return mr->ram && mr->readonly;
 }
@@ -2023,7 +2023,7 @@ static inline bool memory_region_is_rom(MemoryRegion *mr)
  *
  * @mr: the memory region being queried
  */
-static inline bool memory_region_is_nonvolatile(MemoryRegion *mr)
+static inline bool memory_region_is_nonvolatile(const MemoryRegion *mr)
 {
     return mr->nonvolatile;
 }
@@ -2036,7 +2036,7 @@ static inline bool memory_region_is_nonvolatile(MemoryRegion *mr)
  *
  * @mr: the RAM or alias memory region being queried.
  */
-int memory_region_get_fd(MemoryRegion *mr);
+int memory_region_get_fd(const MemoryRegion *mr);
 
 /**
  * memory_region_from_host: Convert a pointer into a RAM memory region
@@ -2521,7 +2521,7 @@ bool memory_region_present(MemoryRegion *container, hwaddr addr);
  *
  * @mr: a #MemoryRegion which should be checked if it's mapped
  */
-bool memory_region_is_mapped(MemoryRegion *mr);
+bool memory_region_is_mapped(const MemoryRegion *mr);
 
 /**
  * memory_region_get_ram_discard_manager: get the #RamDiscardManager for a
diff --git a/system/memory.c b/system/memory.c
index c51d0798a84..eeb0d19484f 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1819,9 +1819,9 @@ static void memory_region_finalize(Object *obj)
     g_free(mr->ioeventfds);
 }
 
-Object *memory_region_owner(MemoryRegion *mr)
+Object *memory_region_owner(const MemoryRegion *mr)
 {
-    Object *obj = OBJECT(mr);
+    const Object *obj = OBJECT(mr);
     return obj->parent;
 }
 
@@ -1849,7 +1849,7 @@ void memory_region_unref(MemoryRegion *mr)
     }
 }
 
-uint64_t memory_region_size(MemoryRegion *mr)
+uint64_t memory_region_size(const MemoryRegion *mr)
 {
     if (int128_eq(mr->size, int128_2_64())) {
         return UINT64_MAX;
@@ -1866,25 +1866,25 @@ const char *memory_region_name(const MemoryRegion *mr)
     return mr->name;
 }
 
-bool memory_region_is_ram_device(MemoryRegion *mr)
+bool memory_region_is_ram_device(const MemoryRegion *mr)
 {
     return mr->ram_device;
 }
 
-bool memory_region_is_protected(MemoryRegion *mr)
+bool memory_region_is_protected(const MemoryRegion *mr)
 {
     return mr->ram && (mr->ram_block->flags & RAM_PROTECTED);
 }
 
-bool memory_region_has_guest_memfd(MemoryRegion *mr)
+bool memory_region_has_guest_memfd(const MemoryRegion *mr)
 {
     return mr->ram_block && mr->ram_block->guest_memfd >= 0;
 }
 
-uint8_t memory_region_get_dirty_log_mask(MemoryRegion *mr)
+uint8_t memory_region_get_dirty_log_mask(const MemoryRegion *mr)
 {
     uint8_t mask = mr->dirty_log_mask;
-    RAMBlock *rb = mr->ram_block;
+    const RAMBlock *rb = mr->ram_block;
 
     if (global_dirty_tracking && ((rb && qemu_ram_is_migratable(rb)) ||
                              memory_region_is_iommu(mr))) {
@@ -1898,7 +1898,7 @@ uint8_t memory_region_get_dirty_log_mask(MemoryRegion *mr)
     return mask;
 }
 
-bool memory_region_is_logging(MemoryRegion *mr, uint8_t client)
+bool memory_region_is_logging(const MemoryRegion *mr, uint8_t client)
 {
     return memory_region_get_dirty_log_mask(mr) & (1 << client);
 }
@@ -2406,7 +2406,7 @@ void memory_region_reset_dirty(MemoryRegion *mr, hwaddr addr,
         memory_region_get_ram_addr(mr) + addr, size, client, NULL);
 }
 
-int memory_region_get_fd(MemoryRegion *mr)
+int memory_region_get_fd(const MemoryRegion *mr)
 {
     RCU_READ_LOCK_GUARD();
     while (mr->alias) {
@@ -2806,7 +2806,7 @@ static FlatRange *flatview_lookup(FlatView *view, AddrRange addr)
                    sizeof(FlatRange), cmp_flatrange_addr);
 }
 
-bool memory_region_is_mapped(MemoryRegion *mr)
+bool memory_region_is_mapped(const MemoryRegion *mr)
 {
     return !!mr->container || mr->mapped_via_alias;
 }
@@ -3290,7 +3290,7 @@ void address_space_destroy_free(AddressSpace *as)
     call_rcu(as, do_address_space_destroy_free, rcu);
 }
 
-static const char *memory_region_type(MemoryRegion *mr)
+static const char *memory_region_type(const MemoryRegion *mr)
 {
     if (mr->alias) {
         return memory_region_type(mr->alias);
@@ -3483,7 +3483,6 @@ static void mtree_print_flatview(gpointer key, gpointer value,
     GArray *fv_address_spaces = value;
     struct FlatViewInfo *fvi = user_data;
     FlatRange *range = &view->ranges[0];
-    MemoryRegion *mr;
     int n = view->nr;
     int i;
     AddressSpace *as;
@@ -3510,7 +3509,8 @@ static void mtree_print_flatview(gpointer key, gpointer value,
     }
 
     while (n--) {
-        mr = range->mr;
+        const MemoryRegion *mr = range->mr;
+
         if (range->offset_in_region) {
             qemu_printf(MTREE_INDENT HWADDR_FMT_plx "-" HWADDR_FMT_plx
                         " (prio %d, %s%s): %s @" HWADDR_FMT_plx,
@@ -3683,8 +3683,10 @@ static void mtree_info_as(bool dispatch_tree, bool owner, bool disabled)
 
     /* print aliased regions */
     QTAILQ_FOREACH(ml, &ml_head, mrqueue) {
-        qemu_printf("memory-region: %s\n", memory_region_name(ml->mr));
-        mtree_print_mr(ml->mr, 1, 0, &ml_head, owner, disabled);
+        const MemoryRegion *mr = ml->mr;
+
+        qemu_printf("memory-region: %s\n", memory_region_name(mr));
+        mtree_print_mr(mr, 1, 0, &ml_head, owner, disabled);
         qemu_printf("\n");
     }
 
-- 
2.52.0


