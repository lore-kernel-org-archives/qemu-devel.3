Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BC07C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 11:55:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riCKZ-0007Cp-S9; Thu, 07 Mar 2024 06:54:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1riCKX-0007CQ-Jo
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 06:54:33 -0500
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1riCKV-0001gc-KE
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 06:54:33 -0500
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2d2fad80eacso8361421fa.2
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 03:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709812469; x=1710417269; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=D4wGmyvUQ61mLBJ031BInsy1nVuxKAhaid0zefzzgGc=;
 b=bxg+js1v/HEhOH7CXnrFm6K30JihP+0nJ3AyX5GALjiDyIIVPrXyVEnNMoFvIeed4Z
 7aDmfcziyld1ztZmiu1/8dJ8CS61TGfcu2/ciTCTEgjkj/F6JqVngBGTvDCIkaSqXLX7
 IgC5lD9CU8iCpnvDfTE9qUOUnRgx40OkNlUwwdCv+cubAvzR2nVHSuHoMZdP5Uuq7ut2
 adjbufmXTsMguEBGz1BKWWZTgHsCBU9/iV2IIMQLoP7khPt8ouZ9IL39y2LXr54jW9Ll
 asA0GxwEPbrSn+Jt4QSnRL8Wuyp2H7c33AEz5aw64wMDttybRhpn+5s+Tt0qdBP9bWNp
 3Uag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709812469; x=1710417269;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D4wGmyvUQ61mLBJ031BInsy1nVuxKAhaid0zefzzgGc=;
 b=ZTjI466vJfzN3paSH9EnoGEj108cUxR6qgoK2hwBFerJUz7+ro0NCIgYAF9BgWvPyw
 /NW4LCvY3FBd7Fm9CUYSSV/Ja1YFlerdm5uUvoFvUPbrz0yTsiKpiDYgKpxnlPdqJaia
 GnsvA3qKv7RCj4PIvxDcXJ7qXmBgjauqe2jmqs+zFpIWZjfLyTRwzFMUW6hU0OLttWTr
 o9M2EKhPgoRlfjlCsEUCmEZoGUnbe5NkGObBQ1wT5+pJZ8XAZdAo06lZstLro3DL07sn
 +0nGGxzEPeIS8MnJnR9Kjx7IcXzGPUtcX/vwcxq0mxiLFsmfydo8+O7bdY8cgPh17zOk
 o8bQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXO10kHjKhxrvXjx2r23RZCrfxl+FyqtQM2PR70FID9aQTTaFNoVls3QAxdj6fU4M4L0z847gpct31NBEIYih6stXlEOrI=
X-Gm-Message-State: AOJu0YwZ6T5m9m0P3aA2Q62E2ccu7NqAV9jjFo7cUOTyqp3nDjihGA8S
 qtPkQN0sYz42cvPyxBz7AB2x1cicfpMncg4cIHmi5DU8+KTv2wedR1cvEQlX3A4=
X-Google-Smtp-Source: AGHT+IHz5Cvig/z02xR0HuA2J9PkQo8Dyofphkh0RFYr8J9DsKohKy9DtwP9NgjeqhuAqzXFKS1QlQ==
X-Received: by 2002:a2e:9ad6:0:b0:2d3:e236:ddc2 with SMTP id
 p22-20020a2e9ad6000000b002d3e236ddc2mr1155474ljj.30.1709812469290; 
 Thu, 07 Mar 2024 03:54:29 -0800 (PST)
Received: from meli.delivery (adsl-101.109.242.224.tellas.gr.
 [109.242.224.101]) by smtp.gmail.com with ESMTPSA id
 i9-20020a5d6309000000b0033e122a9a91sm19368088wru.105.2024.03.07.03.54.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Mar 2024 03:54:29 -0800 (PST)
Date: Thu, 07 Mar 2024 13:49:11 +0200
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-arm@nongnu.org,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 David Woodhouse <dwmw@amazon.co.uk>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Benn=?UTF-8?B?w6k=?= e <alex.bennee@linaro.org>,
 xen-devel@lists.xenproject.org,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH-for-9.0 3/9] hw/xen/hvm: Get target page size at runtime
User-Agent: meli 0.8.5-rc.3
References: <20231114163123.74888-1-philmd@linaro.org>
 <20231114163123.74888-4-philmd@linaro.org>
In-Reply-To: <20231114163123.74888-4-philmd@linaro.org>
Message-ID: <9z7qq.40e122bkrid@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lj1-x231.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, 14 Nov 2023 18:31, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>In order to build this file once for all targets, replace:
>
>  TARGET_PAGE_BITS -> qemu_target_page_bits()
>  TARGET_PAGE_SIZE -> qemu_target_page_size()
>  TARGET_PAGE_MASK -> -qemu_target_page_size()
>
>Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>---
> hw/i386/xen/xen-hvm.c | 62 +++++++++++++++++++++++++++----------------
> 1 file changed, 39 insertions(+), 23 deletions(-)
>
>diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
>index 3b10425986..b64204ea94 100644
>--- a/hw/i386/xen/xen-hvm.c
>+++ b/hw/i386/xen/xen-hvm.c
>@@ -22,6 +22,7 @@
> 
> #include "hw/xen/xen-hvm-common.h"
> #include <xen/hvm/e820.h>
>+#include "exec/target_page.h"
> #include "cpu.h"
> 
> static MemoryRegion ram_640k, ram_lo, ram_hi;
>@@ -247,6 +248,9 @@ static int xen_add_to_physmap(XenIOState *state,
>                               MemoryRegion *mr,
>                               hwaddr offset_within_region)
> {
>+    unsigned target_page_bits = qemu_target_page_bits();
>+    int page_size = qemu_target_page_size();
>+    int page_mask = -page_size;
>     unsigned long nr_pages;
>     int rc = 0;
>     XenPhysmap *physmap = NULL;
>@@ -254,7 +258,7 @@ static int xen_add_to_physmap(XenIOState *state,
>     hwaddr phys_offset = memory_region_get_ram_addr(mr);
>     const char *mr_name;
> 
>-    if (get_physmapping(start_addr, size, TARGET_PAGE_MASK)) {
>+    if (get_physmapping(start_addr, size, page_mask)) {
>         return 0;
>     }
>     if (size <= 0) {
>@@ -294,9 +298,9 @@ go_physmap:
>         return 0;
>     }
> 
>-    pfn = phys_offset >> TARGET_PAGE_BITS;
>-    start_gpfn = start_addr >> TARGET_PAGE_BITS;
>-    nr_pages = size >> TARGET_PAGE_BITS;
>+    pfn = phys_offset >> target_page_bits;
>+    start_gpfn = start_addr >> target_page_bits;
>+    nr_pages = size >> target_page_bits;
>     rc = xendevicemodel_relocate_memory(xen_dmod, xen_domid, nr_pages, pfn,
>                                         start_gpfn);
>     if (rc) {
>@@ -310,8 +314,8 @@ go_physmap:
>     }
> 
>     rc = xendevicemodel_pin_memory_cacheattr(xen_dmod, xen_domid,
>-                                   start_addr >> TARGET_PAGE_BITS,
>-                                   (start_addr + size - 1) >> TARGET_PAGE_BITS,
>+                                   start_addr >> target_page_bits,
>+                                   (start_addr + size - 1) >> target_page_bits,
>                                    XEN_DOMCTL_MEM_CACHEATTR_WB);
>     if (rc) {
>         error_report("pin_memory_cacheattr failed: %s", strerror(errno));
>@@ -323,11 +327,14 @@ static int xen_remove_from_physmap(XenIOState *state,
>                                    hwaddr start_addr,
>                                    ram_addr_t size)
> {
>+    unsigned target_page_bits = qemu_target_page_bits();
>+    int page_size = qemu_target_page_size();
>+    int page_mask = -page_size;
>     int rc = 0;
>     XenPhysmap *physmap = NULL;
>     hwaddr phys_offset = 0;
> 
>-    physmap = get_physmapping(start_addr, size, TARGET_PAGE_MASK);
>+    physmap = get_physmapping(start_addr, size, page_mask);
>     if (physmap == NULL) {
>         return -1;
>     }
>@@ -338,9 +345,9 @@ static int xen_remove_from_physmap(XenIOState *state,
>     DPRINTF("unmapping vram to %"HWADDR_PRIx" - %"HWADDR_PRIx", at "
>             "%"HWADDR_PRIx"\n", start_addr, start_addr + size, phys_offset);
> 
>-    size >>= TARGET_PAGE_BITS;
>-    start_addr >>= TARGET_PAGE_BITS;
>-    phys_offset >>= TARGET_PAGE_BITS;
>+    size >>= target_page_bits;
>+    start_addr >>= target_page_bits;
>+    phys_offset >>= target_page_bits;
>     rc = xendevicemodel_relocate_memory(xen_dmod, xen_domid, size, start_addr,
>                                         phys_offset);
>     if (rc) {
>@@ -369,13 +376,16 @@ static void xen_sync_dirty_bitmap(XenIOState *state,
>                                   hwaddr start_addr,
>                                   ram_addr_t size)
> {
>-    hwaddr npages = size >> TARGET_PAGE_BITS;
>+    unsigned target_page_bits = qemu_target_page_bits();
>+    int page_size = qemu_target_page_size();
>+    int page_mask = -page_size;
>+    hwaddr npages = size >> target_page_bits;
>     const int width = sizeof(unsigned long) * 8;
>     size_t bitmap_size = DIV_ROUND_UP(npages, width);
>     int rc, i, j;
>     const XenPhysmap *physmap = NULL;
> 
>-    physmap = get_physmapping(start_addr, size, TARGET_PAGE_MASK);
>+    physmap = get_physmapping(start_addr, size, page_mask);
>     if (physmap == NULL) {
>         /* not handled */
>         return;
>@@ -389,7 +399,7 @@ static void xen_sync_dirty_bitmap(XenIOState *state,
>         return;
>     }
> 
>-    rc = xen_track_dirty_vram(xen_domid, start_addr >> TARGET_PAGE_BITS,
>+    rc = xen_track_dirty_vram(xen_domid, start_addr >> target_page_bits,
>                               npages, dirty_bitmap);
>     if (rc < 0) {
> #ifndef ENODATA
>@@ -410,8 +420,7 @@ static void xen_sync_dirty_bitmap(XenIOState *state,
>             j = ctzl(map);
>             map &= ~(1ul << j);
>             memory_region_set_dirty(framebuffer,
>-                                    (i * width + j) * TARGET_PAGE_SIZE,
>-                                    TARGET_PAGE_SIZE);
>+                                    (i * width + j) * page_size, page_size);
>         };
>     }
> }
>@@ -631,17 +640,21 @@ void xen_register_framebuffer(MemoryRegion *mr)
> 
> void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length)
> {
>+    unsigned target_page_bits = qemu_target_page_bits();
>+    int page_size = qemu_target_page_size();
>+    int page_mask = -page_size;
>+
>     if (unlikely(xen_in_migration)) {
>         int rc;
>         ram_addr_t start_pfn, nb_pages;
> 
>-        start = xen_phys_offset_to_gaddr(start, length, TARGET_PAGE_MASK);
>+        start = xen_phys_offset_to_gaddr(start, length, page_mask);
> 
>         if (length == 0) {
>-            length = TARGET_PAGE_SIZE;
>+            length = page_size;
>         }
>-        start_pfn = start >> TARGET_PAGE_BITS;
>-        nb_pages = ((start + length + TARGET_PAGE_SIZE - 1) >> TARGET_PAGE_BITS)
>+        start_pfn = start >> target_page_bits;
>+        nb_pages = ((start + length + page_size - 1) >> target_page_bits)
>             - start_pfn;
>         rc = xen_modified_memory(xen_domid, start_pfn, nb_pages);
>         if (rc) {
>@@ -664,6 +677,9 @@ void qmp_xen_set_global_dirty_log(bool enable, Error **errp)
> void xen_arch_set_memory(XenIOState *state, MemoryRegionSection *section,
>                          bool add)
> {
>+    unsigned target_page_bits = qemu_target_page_bits();
>+    int page_size = qemu_target_page_size();
>+    int page_mask = -page_size;
>     hwaddr start_addr = section->offset_within_address_space;
>     ram_addr_t size = int128_get64(section->size);
>     bool log_dirty = memory_region_is_logging(section->mr, DIRTY_MEMORY_VGA);
>@@ -679,8 +695,8 @@ void xen_arch_set_memory(XenIOState *state, MemoryRegionSection *section,
> 
>     trace_xen_client_set_memory(start_addr, size, log_dirty);
> 
>-    start_addr &= TARGET_PAGE_MASK;
>-    size = ROUND_UP(size, TARGET_PAGE_SIZE);
>+    start_addr &= page_mask;
>+    size = ROUND_UP(size, page_size);
> 
>     if (add) {
>         if (!memory_region_is_rom(section->mr)) {
>@@ -689,8 +705,8 @@ void xen_arch_set_memory(XenIOState *state, MemoryRegionSection *section,
>         } else {
>             mem_type = HVMMEM_ram_ro;
>             if (xen_set_mem_type(xen_domid, mem_type,
>-                                 start_addr >> TARGET_PAGE_BITS,
>-                                 size >> TARGET_PAGE_BITS)) {
>+                                 start_addr >> target_page_bits,
>+                                 size >> target_page_bits)) {
>                 DPRINTF("xen_set_mem_type error, addr: "HWADDR_FMT_plx"\n",
>                         start_addr);
>             }
>-- 
>2.41.0
>
>


Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

