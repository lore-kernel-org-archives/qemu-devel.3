Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43BF2FCA174
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 18:36:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzfSS-0007Hy-7Z; Mon, 09 Mar 2026 14:36:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzfSP-0007Fr-Kg
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 14:35:57 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzfSN-0003Vw-AJ
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 14:35:57 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-439b73f4ab4so8569116f8f.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 11:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773081353; x=1773686153; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UNqLEUifsz1cpFVFbx5viMkbYuuKYfbDoeHlGj5zHNY=;
 b=nEvfLWKzgJkvdBMX+CRYWuyQBM6kLYFsxT3bWIvimpTykpiB0Mc3qKmxYI+U2gOT4k
 80kP/kmc62jSmQNPiglMNfxczXO0L0lYGH6ESH7mVgFoh8E9VQlfLalDqBepPiPwRTHj
 2JY3q3Neb+HsqaSYm3XnoutPCJpXIlx5paXJvCCm4EFkHB3oDeLzvpthQa5mmD8kBPPo
 eeyzQIU2Cmd0rANmgMcc4GQoGU6AGbxvC5wGprvFvQWfPlMu7PjptBWZDsiAOuTTkBkz
 gJ/+rZ8CxRdDq7lSGqdzMOuYNISA8wrm+QaGOztfuIZndAsL6ZSOM3rZKUpAdPXhcV2Y
 AhXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773081353; x=1773686153;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UNqLEUifsz1cpFVFbx5viMkbYuuKYfbDoeHlGj5zHNY=;
 b=u4NVd5bw6CbEXTOY4JntbmUYcvMmNvHMbgrXDEwz2XzX3JABAAdfNQHrZ57UT54w7J
 xOPY0GuMiknAXpKQoAsBsMAOLynaMbIiuxEVAvYo2ZmMWtj7yA7d7KhBxXzgP9XGAYG0
 j5LY5MpFW38v2dYRG16GcuOhVUm9EoicCb+8Tq48ahWpced3Yp+zDtGxV8gri9nYKTr3
 sKE5LIPHZ4QUIeb+9Ka7VtJR+IgTCSn9mY+RmyRZoW/qrND1KWukmv8Sag7jrMWdkPZX
 cyX0BXBXZ6qV02walZqB2PBhlgNvlx3ynpfosfC5jzxY60mASVoPxNpigs2RyfmCLePx
 Kyig==
X-Gm-Message-State: AOJu0Yz9QYGEICfRx1ac/Au39DJlowL+iZrG6R5nD1vLLcimFyK3o7Fu
 se6FZCKhAFtCszWUb2BaTLMohzXVz2iMD6LvR8NwvlKUAiV0JJLIjguxWcjm2O3g39rG+lAcZsz
 VJpFx97s=
X-Gm-Gg: ATEYQzyfxjJ8LX8l51m/fzr2zM89SucPhu3HNjqUVueCjhEK62K4AbalzvC1JfeEcom
 x7Dg9FSZ6uJ7NFhENPTpn/Kwe75A+HG1RMGfUmZigm7Ad5vPGsCs+pi/Yhbf/Xt/etFQddPPeh9
 FAD7CqAM4uSpzEeypd+8/fvAD3j51XcCgoHUGY5FGG9zabQ+E36kI1PNTFpito0UhTMQ4emQGGU
 3gwvq96dywSguqSK/2ZlF9x2LK8KYUfP1E//fVwemFm7Jm/+ZbBw0LXOulKwtB07D1S2kDe7z7t
 LHUmkcuJ8Y/5St7w76OoxjXM1KUo2fKKoavKmZfxgqfx4QMv1unBYLcO+Pv/zPCRAVahHQ04r78
 MNqzzCilUHbTBzPj067UV89E6MdvoXw+T50soQ6kJg5Sv6cctT62CzyBqkHF8On9uKFWaQ3aMIu
 4wP3ZaAgtHdJ/e/Wz/zxoPr87UWA/XlnUvmJQJSaZqmwzeYQJi2fSa0+FQjcjc314ufFbnQbAR
X-Received: by 2002:a05:6000:704:b0:439:df5f:4220 with SMTP id
 ffacd0b85a97d-439df5f42f8mr17289075f8f.18.1773081353315; 
 Mon, 09 Mar 2026 11:35:53 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae3a20fsm28028805f8f.28.2026.03.09.11.35.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Mar 2026 11:35:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Anthony PERARD <anthony@xenproject.org>, xen-devel@lists.xenproject.org,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH v2 2/4] system/memory: Constify various MemoryRegion arguments
Date: Mon,  9 Mar 2026 19:35:33 +0100
Message-ID: <20260309183536.88976-3-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309183536.88976-1-philmd@linaro.org>
References: <20260309183536.88976-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 include/system/memory.h | 38 +++++++++++++++++++-------------------
 system/memory.c         | 38 ++++++++++++++++++++------------------
 system/physmem.c        |  2 +-
 3 files changed, 40 insertions(+), 38 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index 0562af31361..6a04c46db37 100644
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
@@ -2071,7 +2071,7 @@ MemoryRegion *memory_region_from_host(void *ptr, ram_addr_t *offset);
  *
  * @mr: the memory region being queried.
  */
-void *memory_region_get_ram_ptr(MemoryRegion *mr);
+void *memory_region_get_ram_ptr(const MemoryRegion *mr);
 
 /* memory_region_ram_resize: Resize a RAM region.
  *
@@ -2421,7 +2421,7 @@ void memory_region_add_subregion_overlap(MemoryRegion *mr,
  *
  * @mr: the region to be queried
  */
-ram_addr_t memory_region_get_ram_addr(MemoryRegion *mr);
+ram_addr_t memory_region_get_ram_addr(const MemoryRegion *mr);
 
 uint64_t memory_region_get_alignment(const MemoryRegion *mr);
 /**
@@ -2521,7 +2521,7 @@ bool memory_region_present(MemoryRegion *container, hwaddr addr);
  *
  * @mr: a #MemoryRegion which should be checked if it's mapped
  */
-bool memory_region_is_mapped(MemoryRegion *mr);
+bool memory_region_is_mapped(const MemoryRegion *mr);
 
 /**
  * memory_region_get_ram_discard_manager: get the #RamDiscardManager for a
@@ -2967,7 +2967,7 @@ void *qemu_map_ram_ptr(RAMBlock *ram_block, ram_addr_t addr);
 int memory_access_size(MemoryRegion *mr, unsigned l, hwaddr addr);
 bool prepare_mmio_access(MemoryRegion *mr);
 
-static inline bool memory_region_supports_direct_access(MemoryRegion *mr)
+static inline bool memory_region_supports_direct_access(const MemoryRegion *mr)
 {
     /* ROM DEVICE regions only allow direct access if in ROMD mode. */
     if (memory_region_is_romd(mr)) {
@@ -2984,8 +2984,8 @@ static inline bool memory_region_supports_direct_access(MemoryRegion *mr)
     return !memory_region_is_ram_device(mr);
 }
 
-static inline bool memory_access_is_direct(MemoryRegion *mr, bool is_write,
-                                           MemTxAttrs attrs)
+static inline bool memory_access_is_direct(const MemoryRegion *mr,
+                                           bool is_write, MemTxAttrs attrs)
 {
     if (!memory_region_supports_direct_access(mr)) {
         return false;
diff --git a/system/memory.c b/system/memory.c
index c51d0798a84..b130d956d4e 100644
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
@@ -2415,7 +2415,7 @@ int memory_region_get_fd(MemoryRegion *mr)
     return mr->ram_block->fd;
 }
 
-void *memory_region_get_ram_ptr(MemoryRegion *mr)
+void *memory_region_get_ram_ptr(const MemoryRegion *mr)
 {
     uint64_t offset = 0;
 
@@ -2440,7 +2440,7 @@ MemoryRegion *memory_region_from_host(void *ptr, ram_addr_t *offset)
     return block->mr;
 }
 
-ram_addr_t memory_region_get_ram_addr(MemoryRegion *mr)
+ram_addr_t memory_region_get_ram_addr(const MemoryRegion *mr)
 {
     return mr->ram_block ? mr->ram_block->offset : RAM_ADDR_INVALID;
 }
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
 
diff --git a/system/physmem.c b/system/physmem.c
index e5390d09bef..4a9e0760045 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -1975,7 +1975,7 @@ void qemu_ram_unset_idstr(RAMBlock *block)
     }
 }
 
-static char *cpr_name(MemoryRegion *mr)
+static char *cpr_name(const MemoryRegion *mr)
 {
     const char *mr_name = memory_region_name(mr);
     g_autofree char *id = mr->dev ? qdev_get_dev_path(mr->dev) : NULL;
-- 
2.53.0


