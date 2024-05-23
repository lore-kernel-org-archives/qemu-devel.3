Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1F22C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 07:48:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA3Ab-0001A5-7Y; Thu, 23 May 2024 03:47:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sA3AZ-00019e-FR
 for qemu-devel@nongnu.org; Thu, 23 May 2024 03:47:23 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sA3AW-0004MM-O1
 for qemu-devel@nongnu.org; Thu, 23 May 2024 03:47:23 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-420160f8f52so16935035e9.0
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 00:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716450439; x=1717055239; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=aH6mnjfZkzeYOjZvZ/7yNuU7flVChupqdi/iX01ZoMA=;
 b=v/8KC7PdKfqZVqxtDMdXuUZmDcWVxxrSXzWerKzV7nrJTpyfa3lsf5MDQ0O4A8Yrip
 kc8t7qjDCWHabEYNEuFXSKjOoHEYZabHBhEwgSGitceDYNVmkqNiu4qrCNFexs931FbK
 B+Jlh/BGxK+Om6mc6lc2+KC7FSI7zBXj4BZCqQ1DJm3tuDECSVx8H1h7mUtSPKn5YMKy
 dcoAJLq5ZyfwyI98VEbkz6sI3dvlG+5YOaMwHYF6ksLXoIZ6JiP68MYNKMykq8cLy/4U
 WFd8e7oGXBkcmR9grgrcsPSUcJj5nrlptvwTJ0ESju6mHt2+yudAp+ccEc6LVEaggrJm
 S4gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716450439; x=1717055239;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aH6mnjfZkzeYOjZvZ/7yNuU7flVChupqdi/iX01ZoMA=;
 b=UfcV0d2OHpNrXGibHgJMM2exAx3DAeKSHpgKidwFTBlCQfnLRWyEKUh7MnqhzehLnS
 6E8qkAmRyYc6xlzxTjTIdVsJKD2XD31XJVgj7/pgR6Oy2HAFjhd7VUF6HgZF0EZ3wKR7
 zv9VkP+DKjYIgBwLGD1BBL5uVy0q0yD+KHmi3rTTfflj4nuLl69PCswsXIhtaXH7zaa6
 yCTk8I9bSc/+DWkFNExpliCyOH+fbWRgCAcFL9CyoSuyQKBo9lEfHZ/pzoh+naV3kK4l
 kuVWJkAzXsOLixtPFBYser/W84W4Xt7sZNN4fh2WGxIvtJ7y7rClED0AcjGO38wucyKQ
 MPbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUI9DPO83PJH6d0Gjno0luUaJers7+T74MBG/5n1sprXdI0WVaPNrRwypc8Yqi1MdgFGJXIjnapTSjP7VO7Wn5zx5HZNqg=
X-Gm-Message-State: AOJu0Yzrh9VYQMrTZ5+a5oDIgDif9StoD02LOl1ZaLaTXR4sOPFW596p
 nvMPX2skzvgAO+gWjZkk3+FJeP4DOPJ8YOPKYDUSyNg0u5WiGFskOPhVZzS0Sug=
X-Google-Smtp-Source: AGHT+IGQeMd5yBkAmawll57ZNdrxkOB8lTV5IsVrDnByQEuUMkNFKEANvw8CndcTxVK9s5YYxaoABQ==
X-Received: by 2002:a5d:4ecd:0:b0:34c:f320:247 with SMTP id
 ffacd0b85a97d-354d8d83640mr3198074f8f.49.1716450438824; 
 Thu, 23 May 2024 00:47:18 -0700 (PDT)
Received: from meli-email.org (adsl-49.37.6.163.tellas.gr. [37.6.163.49])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-354cc7738dasm7480210f8f.18.2024.05.23.00.47.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 00:47:18 -0700 (PDT)
Date: Thu, 23 May 2024 10:35:04 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: xen-devel@lists.xenproject.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com, sstabellini@kernel.org, jgross@suse.com,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 xen-devel@lists.xenproject.org
Subject: Re: [PATCH v6 7/8] xen: mapcache: Add support for grant mappings
User-Agent: meli 0.8.5
References: <20240516154804.1114245-1-edgar.iglesias@gmail.com>
 <20240516154804.1114245-8-edgar.iglesias@gmail.com>
In-Reply-To: <20240516154804.1114245-8-edgar.iglesias@gmail.com>
Message-ID: <dxhms.qrh0wkni3yz@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x336.google.com
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

On Thu, 16 May 2024 18:48, "Edgar E. Iglesias" <edgar.iglesias@gmail.com> wrote:
>From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
>
>Add a second mapcache for grant mappings. The mapcache for
>grants needs to work with XC_PAGE_SIZE granularity since
>we can't map larger ranges than what has been granted to us.
>
>Like with foreign mappings (xen_memory), machines using grants
>are expected to initialize the xen_grants MR and map it
>into their address-map accordingly.
>
>Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
>Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
>---
> hw/xen/xen-hvm-common.c         |  12 ++-
> hw/xen/xen-mapcache.c           | 163 ++++++++++++++++++++++++++------
> include/hw/xen/xen-hvm-common.h |   3 +
> include/sysemu/xen.h            |   7 ++
> 4 files changed, 152 insertions(+), 33 deletions(-)
>
>diff --git a/hw/xen/xen-hvm-common.c b/hw/xen/xen-hvm-common.c
>index a0a0252da0..b8ace1c368 100644
>--- a/hw/xen/xen-hvm-common.c
>+++ b/hw/xen/xen-hvm-common.c
>@@ -10,12 +10,18 @@
> #include "hw/boards.h"
> #include "hw/xen/arch_hvm.h"
> 
>-MemoryRegion xen_memory;
>+MemoryRegion xen_memory, xen_grants;
> 
>-/* Check for xen memory.  */
>+/* Check for any kind of xen memory, foreign mappings or grants.  */
> bool xen_mr_is_memory(MemoryRegion *mr)
> {
>-    return mr == &xen_memory;
>+    return mr == &xen_memory || mr == &xen_grants;
>+}
>+
>+/* Check specifically for grants.  */
>+bool xen_mr_is_grants(MemoryRegion *mr)
>+{
>+    return mr == &xen_grants;
> }
> 
> void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size, MemoryRegion *mr,
>diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
>index a07c47b0b1..1cbc2aeaa9 100644
>--- a/hw/xen/xen-mapcache.c
>+++ b/hw/xen/xen-mapcache.c
>@@ -14,6 +14,7 @@
> 
> #include <sys/resource.h>
> 
>+#include "hw/xen/xen-hvm-common.h"
> #include "hw/xen/xen_native.h"
> #include "qemu/bitmap.h"
> 
>@@ -21,6 +22,8 @@
> #include "sysemu/xen-mapcache.h"
> #include "trace.h"
> 
>+#include <xenevtchn.h>
>+#include <xengnttab.h>
> 
> #if HOST_LONG_BITS == 32
> #  define MCACHE_MAX_SIZE     (1UL<<31) /* 2GB Cap */
>@@ -41,6 +44,7 @@ typedef struct MapCacheEntry {
>     unsigned long *valid_mapping;
>     uint32_t lock;
> #define XEN_MAPCACHE_ENTRY_DUMMY (1 << 0)
>+#define XEN_MAPCACHE_ENTRY_GRANT (1 << 1)

Might we get more entry kinds in the future? (for example foreign maps). 
Maybe this could be an enum.

>     uint8_t flags;
>     hwaddr size;
>     struct MapCacheEntry *next;
>@@ -71,6 +75,8 @@ typedef struct MapCache {
> } MapCache;
> 
> static MapCache *mapcache;
>+static MapCache *mapcache_grants;
>+static xengnttab_handle *xen_region_gnttabdev;
> 
> static inline void mapcache_lock(MapCache *mc)
> {
>@@ -131,6 +137,12 @@ void xen_map_cache_init(phys_offset_to_gaddr_t f, void *opaque)
>     unsigned long max_mcache_size;
>     unsigned int bucket_shift;
> 
>+    xen_region_gnttabdev = xengnttab_open(NULL, 0);
>+    if (xen_region_gnttabdev == NULL) {
>+        error_report("mapcache: Failed to open gnttab device");
>+        exit(EXIT_FAILURE);
>+    }
>+
>     if (HOST_LONG_BITS == 32) {
>         bucket_shift = 16;
>     } else {
>@@ -159,6 +171,15 @@ void xen_map_cache_init(phys_offset_to_gaddr_t f, void *opaque)
>     mapcache = xen_map_cache_init_single(f, opaque,
>                                          bucket_shift,
>                                          max_mcache_size);
>+
>+    /*
>+     * Grant mappings must use XC_PAGE_SIZE granularity since we can't
>+     * map anything beyond the number of pages granted to us.
>+     */
>+    mapcache_grants = xen_map_cache_init_single(f, opaque,
>+                                                XC_PAGE_SHIFT,
>+                                                max_mcache_size);
>+
>     setrlimit(RLIMIT_AS, &rlimit_as);
> }
> 
>@@ -168,17 +189,24 @@ static void xen_remap_bucket(MapCache *mc,
>                              hwaddr size,
>                              hwaddr address_index,
>                              bool dummy,
>+                             bool grant,
>+                             bool is_write,
>                              ram_addr_t ram_offset)
> {
>     uint8_t *vaddr_base;
>-    xen_pfn_t *pfns;
>+    uint32_t *refs = NULL;
>+    xen_pfn_t *pfns = NULL;
>     int *err;

You should use g_autofree to perform automatic cleanup on function exit 
instead of manually freeing, since the allocations should only live 
within the function call.

>     unsigned int i;
>     hwaddr nb_pfn = size >> XC_PAGE_SHIFT;
> 
>     trace_xen_remap_bucket(address_index);
> 
>-    pfns = g_new0(xen_pfn_t, nb_pfn);
>+    if (grant) {
>+        refs = g_new0(uint32_t, nb_pfn);
>+    } else {
>+        pfns = g_new0(xen_pfn_t, nb_pfn);
>+    }
>     err = g_new0(int, nb_pfn);
> 
>     if (entry->vaddr_base != NULL) {
>@@ -207,21 +235,51 @@ static void xen_remap_bucket(MapCache *mc,
>     g_free(entry->valid_mapping);
>     entry->valid_mapping = NULL;
> 
>-    for (i = 0; i < nb_pfn; i++) {
>-        pfns[i] = (address_index << (mc->bucket_shift - XC_PAGE_SHIFT)) + i;
>+    if (grant) {
>+        hwaddr grant_base = address_index - (ram_offset >> XC_PAGE_SHIFT);
>+
>+        for (i = 0; i < nb_pfn; i++) {
>+            refs[i] = grant_base + i;
>+        }
>+    } else {
>+        for (i = 0; i < nb_pfn; i++) {
>+            pfns[i] = (address_index << (mc->bucket_shift - XC_PAGE_SHIFT)) + i;
>+        }
>     }
> 
>-    /*
>-     * If the caller has requested the mapping at a specific address use
>-     * MAP_FIXED to make sure it's honored.
>-     */
>+    entry->flags &= ~XEN_MAPCACHE_ENTRY_GRANT;
>+
>     if (!dummy) {
>-        vaddr_base = xenforeignmemory_map2(xen_fmem, xen_domid, vaddr,
>-                                           PROT_READ | PROT_WRITE,
>-                                           vaddr ? MAP_FIXED : 0,
>-                                           nb_pfn, pfns, err);

Since err is not NULL here, the function might return a valid pointer 
but individual frames might have failed.


>+        if (grant) {
>+            int prot = PROT_READ;
>+
>+            if (is_write) {
>+                prot |= PROT_WRITE;
>+            }
>+
>+            entry->flags |= XEN_MAPCACHE_ENTRY_GRANT;
>+            assert(vaddr == NULL);
>+            vaddr_base = xengnttab_map_domain_grant_refs(xen_region_gnttabdev,
>+                                                         nb_pfn,
>+                                                         xen_domid, refs,
>+                                                         prot);
>+        } else {
>+            /*
>+             * If the caller has requested the mapping at a specific address use
>+             * MAP_FIXED to make sure it's honored.
>+             *
>+             * We don't yet support upgrading mappings from RO to RW, to handle
>+             * models using ordinary address_space_rw(), foreign mappings ignore
>+             * is_write and are always mapped RW.
>+             */
>+            vaddr_base = xenforeignmemory_map2(xen_fmem, xen_domid, vaddr,
>+                                               PROT_READ | PROT_WRITE,
>+                                               vaddr ? MAP_FIXED : 0,
>+                                               nb_pfn, pfns, err);
>+        }
>         if (vaddr_base == NULL) {
>-            perror("xenforeignmemory_map2");
>+            perror(grant ? "xengnttab_map_domain_grant_refs"
>+                           : "xenforeignmemory_map2");
>             exit(-1);
>         }
>     } else {
>@@ -261,6 +319,7 @@ static void xen_remap_bucket(MapCache *mc,
>         }
>     }
> 
>+    g_free(refs);
>     g_free(pfns);
>     g_free(err);
> }
>@@ -268,7 +327,8 @@ static void xen_remap_bucket(MapCache *mc,
> static uint8_t *xen_map_cache_unlocked(MapCache *mc,
>                                        hwaddr phys_addr, hwaddr size,
>                                        ram_addr_t ram_offset,
>-                                       uint8_t lock, bool dma, bool is_write)
>+                                       uint8_t lock, bool dma,
>+                                       bool grant, bool is_write)
> {
>     MapCacheEntry *entry, *pentry = NULL,
>                   *free_entry = NULL, *free_pentry = NULL;
>@@ -340,7 +400,7 @@ tryagain:
>         entry = g_new0(MapCacheEntry, 1);
>         pentry->next = entry;
>         xen_remap_bucket(mc, entry, NULL, cache_size, address_index, dummy,
>-                         ram_offset);
>+                         grant, is_write, ram_offset);
>     } else if (!entry->lock) {
>         if (!entry->vaddr_base || entry->paddr_index != address_index ||
>                 entry->size != cache_size ||
>@@ -348,7 +408,7 @@ tryagain:
>                     test_bit_size >> XC_PAGE_SHIFT,
>                     entry->valid_mapping)) {
>             xen_remap_bucket(mc, entry, NULL, cache_size, address_index, dummy,
>-                             ram_offset);
>+                             grant, is_write, ram_offset);
>         }
>     }
> 
>@@ -399,12 +459,28 @@ uint8_t *xen_map_cache(MemoryRegion *mr,
>                        uint8_t lock, bool dma,
>                        bool is_write)
> {
>+    bool grant = xen_mr_is_grants(mr);
>+    MapCache *mc = grant ? mapcache_grants : mapcache;
>     uint8_t *p;
> 
>-    mapcache_lock(mapcache);
>-    p = xen_map_cache_unlocked(mapcache, phys_addr, size, ram_addr_offset,
>-                               lock, dma, is_write);
>-    mapcache_unlock(mapcache);
>+    if (grant) {
>+        /*
>+         * Grants are only supported via address_space_map(). Anything
>+         * else is considered a user/guest error.
>+         *
>+         * QEMU generally doesn't expect these mappings to ever fail, so
>+         * if this happens we report an error message and abort().
>+         */
>+        if (!lock) {

Nested if conditions that can be flattened, i.e. this could be 

if (grant && !lock)

>+            error_report("Trying access a grant reference without mapping it.");

s/Trying access a grant/Tried to access a grant/

>+            abort();
>+        }
>+    }
>+
>+    mapcache_lock(mc);
>+    p = xen_map_cache_unlocked(mc, phys_addr, size, ram_addr_offset,
>+                               lock, dma, grant, is_write);
>+    mapcache_unlock(mc);
>     return p;
> }
> 
>@@ -449,7 +525,14 @@ static ram_addr_t xen_ram_addr_from_mapcache_single(MapCache *mc, void *ptr)
> 
> ram_addr_t xen_ram_addr_from_mapcache(void *ptr)
> {
>-    return xen_ram_addr_from_mapcache_single(mapcache, ptr);
>+    ram_addr_t addr;
>+
>+    addr = xen_ram_addr_from_mapcache_single(mapcache, ptr);
>+    if (addr == RAM_ADDR_INVALID) {
>+        addr = xen_ram_addr_from_mapcache_single(mapcache_grants, ptr);
>+    }
>+
>+    return addr;
> }
> 
> static void xen_invalidate_map_cache_entry_unlocked(MapCache *mc,
>@@ -460,6 +543,7 @@ static void xen_invalidate_map_cache_entry_unlocked(MapCache *mc,
>     hwaddr paddr_index;
>     hwaddr size;
>     int found = 0;
>+    int rc;
> 
>     QTAILQ_FOREACH(reventry, &mc->locked_entries, next) {
>         if (reventry->vaddr_req == buffer) {
>@@ -502,7 +586,14 @@ static void xen_invalidate_map_cache_entry_unlocked(MapCache *mc,
>     }
> 
>     ram_block_notify_remove(entry->vaddr_base, entry->size, entry->size);
>-    if (munmap(entry->vaddr_base, entry->size) != 0) {
>+    if (entry->flags & XEN_MAPCACHE_ENTRY_GRANT) {
>+        rc = xengnttab_unmap(xen_region_gnttabdev, entry->vaddr_base,
>+                             entry->size >> mc->bucket_shift);
>+    } else {
>+        rc = munmap(entry->vaddr_base, entry->size);
>+    }
>+
>+    if (rc) {
>         perror("unmap fails");
>         exit(-1);
>     }
>@@ -521,14 +612,24 @@ typedef struct XenMapCacheData {
>     uint8_t *buffer;
> } XenMapCacheData;
> 
>+static void xen_invalidate_map_cache_entry_single(MapCache *mc, uint8_t *buffer)
>+{
>+    mapcache_lock(mc);
>+    xen_invalidate_map_cache_entry_unlocked(mc, buffer);
>+    mapcache_unlock(mc);
>+}
>+
>+static void xen_invalidate_map_cache_entry_all(uint8_t *buffer)
>+{
>+    xen_invalidate_map_cache_entry_single(mapcache, buffer);
>+    xen_invalidate_map_cache_entry_single(mapcache_grants, buffer);
>+}
>+
> static void xen_invalidate_map_cache_entry_bh(void *opaque)
> {
>     XenMapCacheData *data = opaque;
> 
>-    mapcache_lock(mapcache);
>-    xen_invalidate_map_cache_entry_unlocked(mapcache, data->buffer);
>-    mapcache_unlock(mapcache);
>-
>+    xen_invalidate_map_cache_entry_all(data->buffer);
>     aio_co_wake(data->co);
> }
> 
>@@ -543,9 +644,7 @@ void coroutine_mixed_fn xen_invalidate_map_cache_entry(uint8_t *buffer)
>                                 xen_invalidate_map_cache_entry_bh, &data);
>         qemu_coroutine_yield();
>     } else {
>-        mapcache_lock(mapcache);
>-        xen_invalidate_map_cache_entry_unlocked(mapcache, buffer);
>-        mapcache_unlock(mapcache);
>+        xen_invalidate_map_cache_entry_all(buffer);
>     }
> }
> 
>@@ -597,6 +696,7 @@ void xen_invalidate_map_cache(void)
>     bdrv_drain_all();
> 
>     xen_invalidate_map_cache_single(mapcache);
>+    xen_invalidate_map_cache_single(mapcache_grants);
> }
> 
> static uint8_t *xen_replace_cache_entry_unlocked(MapCache *mc,
>@@ -632,13 +732,16 @@ static uint8_t *xen_replace_cache_entry_unlocked(MapCache *mc,
>         return NULL;
>     }
> 
>+    assert((entry->flags & XEN_MAPCACHE_ENTRY_GRANT) == 0);
>+
>     address_index  = new_phys_addr >> mc->bucket_shift;
>     address_offset = new_phys_addr & (mc->bucket_size - 1);
> 
>     trace_xen_replace_cache_entry_dummy(old_phys_addr, new_phys_addr);
> 
>     xen_remap_bucket(mc, entry, entry->vaddr_base,
>-                     cache_size, address_index, false, old_phys_addr);
>+                     cache_size, address_index, false,
>+                     false, false, old_phys_addr);
>     if (!test_bits(address_offset >> XC_PAGE_SHIFT,
>                 test_bit_size >> XC_PAGE_SHIFT,
>                 entry->valid_mapping)) {
>diff --git a/include/hw/xen/xen-hvm-common.h b/include/hw/xen/xen-hvm-common.h
>index 65a51aac2e..3d796235dc 100644
>--- a/include/hw/xen/xen-hvm-common.h
>+++ b/include/hw/xen/xen-hvm-common.h
>@@ -16,6 +16,7 @@
> #include <xen/hvm/ioreq.h>
> 
> extern MemoryRegion xen_memory;
>+extern MemoryRegion xen_grants;
> extern MemoryListener xen_io_listener;
> extern DeviceListener xen_device_listener;
> 
>@@ -29,6 +30,8 @@ extern DeviceListener xen_device_listener;
>     do { } while (0)
> #endif
> 
>+#define XEN_GRANT_ADDR_OFF (1ULL << 63)
>+
> static inline uint32_t xen_vcpu_eport(shared_iopage_t *shared_page, int i)
> {
>     return shared_page->vcpu_ioreq[i].vp_eport;
>diff --git a/include/sysemu/xen.h b/include/sysemu/xen.h
>index dc72f83bcb..19dccf4d71 100644
>--- a/include/sysemu/xen.h
>+++ b/include/sysemu/xen.h
>@@ -35,6 +35,7 @@ void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size,
>                    struct MemoryRegion *mr, Error **errp);
> 
> bool xen_mr_is_memory(MemoryRegion *mr);
>+bool xen_mr_is_grants(MemoryRegion *mr);
> 
> #else /* !CONFIG_XEN_IS_POSSIBLE */
> 
>@@ -55,6 +56,12 @@ static inline bool xen_mr_is_memory(MemoryRegion *mr)
>     return false;
> }
> 
>+static inline bool xen_mr_is_grants(MemoryRegion *mr)
>+{
>+    g_assert_not_reached();
>+    return false;
>+}
>+
> #endif /* CONFIG_XEN_IS_POSSIBLE */
> 
> #endif
>-- 
>2.40.1
>
>

