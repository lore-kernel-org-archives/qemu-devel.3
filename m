Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5E76CD343B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:13:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcwB-0005Gr-RS; Wed, 06 May 2026 10:09:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcw4-0004rz-Bq
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:09:12 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcw2-0002Cu-0P
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:09:11 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-488ba840146so57476445e9.1
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 07:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778076547; x=1778681347; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=K3nrp9HgpNvnB5JSb3ITv/y/XMExaEyF4f08sVkOvWk=;
 b=Vs6+kY89B6Ta5V90XKBPrGkHTyHpxuDHYuGYyL4PENEmZvbdq+wJj7qoo5NMtdaLai
 6o9AoHWq9T/TSZWh92b2Gq30Jq5YTdIkBMJ8tS9DgzYKyxBNiTd8glCKUENZhZCu/9zZ
 d9iHuEZ3lSLGi9B1BrGAFfqMoVaR3H9C05W2qlg4DVvc955vYZilbrkMlF3Kyvp8RmOg
 gKJw6ZbBeBW5WymWoZ8bjathuOCcxKr+ICPaFzr2CYG7rjfHlA+PlCgcWu8wL1sYPrsg
 SIC6kN93hlsAF2q/WxCihUjAaes0GxStW8mRjZ5+w+hJykr4GYjmCdQJ7WgJyDPeaRcF
 1LoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778076547; x=1778681347;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=K3nrp9HgpNvnB5JSb3ITv/y/XMExaEyF4f08sVkOvWk=;
 b=jBE6T9YIKaiZE918En8p7gBCRkIGBQF0w+t6hDvgbGeiCKAl7NGpOvg7ZCVnfCKH0L
 aL3HkIrnxa/UWDb43inQ3fEwyKvHcP5ZsbLjR7a1T/Ipwgzvi58FMIGP57P7eAu81CuE
 zJ3XXo6dPxW9+P/hp20Zct2zHXtqDH7WW6zfGK3uZoQC4RRbw2ruaq2ytr/2XAZFL4So
 UCLbyPhILuY9unsvbngS0XVpzrTewUiWl5mDsKF4iD28RKRV7HddAWqP+8d7jA+KTqia
 2ggOxVfXzbgbO5dg3ajD1J8f6LJlCs5XqY0LUG1TAkCc8VSjElEu4Njl9PThtvsHmIMx
 Q3UA==
X-Gm-Message-State: AOJu0YxVcSr0NtWduq6qvLBTvqG3irNqegMTgz29tbu4di/D6AfQaRk1
 4inCUUXWg5ysbInb3kidPwe7nbjYtyhOIq06nWfzkHP5Zpq3/KyZrq3nWV6sw7JgsGjcbGJ3/3c
 vZVv+TgA=
X-Gm-Gg: AeBDies3I1TRYRy+X2Pwdgt0fneGkAgtdaYRJNoLk75YQAiZf3pZoC17HzndsZJ06iT
 Z6HQHJ5cnii/ENtedX/T6nZZlbAGM+u+erOylYlGzYaku3R7iRG3TaB+XwU48shDp9V2TP01OeX
 bDoYh5LP4CGy5hzMB2Jjgs7UsqxKp0WEBT/70Z+Z+FgWTVkkyzTVnOKGDnEkJ+yXxOyLkh/W3bG
 Yz4azVJqCNZzbfvWB+AmZlBWwgbe1cv/tpBHTGb/ZAu10FeUSB5V2Hirp8t+96DiI/5ag+2tdZY
 PgedLNMgB9N1JZcwY6C2tctvI2lzDqSsUJCgdmP6ey39UJYnv/UoR2NyjcPc0dE9wIMCQbFRAYO
 EUz9OB0UmUguqZF/Y23yqIKXBOZPdVonv/MPDvmKbPLwq56rgfZI5hV7YoZLOG6IcUuhctsqPgw
 +6Kypzpn3w9GCwRLjmgyVhRJMX8EWSI2tPMKM4UEM4acwAbM56twWU7hku0ioJd60bxNQqnVcXh
 dG7tJbBEvU=
X-Received: by 2002:a05:600c:a111:b0:488:79a3:f04c with SMTP id
 5b1f17b1804b1-48e51f46d1bmr48492415e9.27.1778076547323; 
 Wed, 06 May 2026 07:09:07 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e538acbfcsm46637325e9.8.2026.05.06.07.09.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 07:09:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 104/110] cocci: Do not initialize variable used by
 QLIST_FOREACH macro
Date: Wed,  6 May 2026 15:55:16 +0200
Message-ID: <20260506135524.20617-105-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

The QLIST_FOREACH() macro, defined in "qemu/queue.h",
always assigns its iterator variable when entering the
loop. Remove the pointless and possibly misleading
assignment.

Mechanical patch using the following coccinelle spatch:

  @@
  type T;
  identifier e;
  iterator FOREACH_MACRO =~ ".*_FOREACH.*";
  statement S;
  @@
  -    T *e = ...;
  +    T *e;
       ... when != e
       FOREACH_MACRO(e, ...) S

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-Id: <20260415215539.92629-2-philmd@linaro.org>
---
 block/blkio.c               | 2 +-
 block/gluster.c             | 4 ++--
 hw/arm/virt-acpi-build.c    | 2 +-
 hw/i386/xen/xen-hvm.c       | 4 ++--
 hw/riscv/riscv-iommu.c      | 2 +-
 hw/vfio/cpr-legacy.c        | 2 +-
 hw/vfio/listener.c          | 4 ++--
 hw/xen/xen_pt_config_init.c | 4 ++--
 8 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/block/blkio.c b/block/blkio.c
index 20f138a38c5..fb8bec27d71 100644
--- a/block/blkio.c
+++ b/block/blkio.c
@@ -124,7 +124,7 @@ blkio_do_alloc_bounce_buffer(BDRVBlkioState *s, BlkioBounceBuf *bounce,
                              int64_t bytes)
 {
     void *addr = s->bounce_pool.addr;
-    BlkioBounceBuf *cur = NULL;
+    BlkioBounceBuf *cur;
     BlkioBounceBuf *prev = NULL;
     ptrdiff_t space;
 
diff --git a/block/gluster.c b/block/gluster.c
index 4fb25b2c6d8..279f650241c 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -251,7 +251,7 @@ static void glfs_set_preopened(const char *volume, glfs_t *fs)
 
 static glfs_t *glfs_find_preopened(const char *volume)
 {
-    ListElement *entry = NULL;
+    ListElement *entry;
 
      QLIST_FOREACH(entry, &glfs_list, list) {
         if (strcmp(entry->saved.volume, volume) == 0) {
@@ -265,7 +265,7 @@ static glfs_t *glfs_find_preopened(const char *volume)
 
 static void glfs_clear_preopened(glfs_t *fs)
 {
-    ListElement *entry = NULL;
+    ListElement *entry;
     ListElement *next;
 
     if (fs == NULL) {
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 6817a72e2eb..3f285ff6c78 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -146,7 +146,7 @@ static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
 {
     int ecam_id = VIRT_ECAM_ID(vms->highmem_ecam);
     bool cxl_present = false;
-    PCIBus *bus = vms->bus;
+    PCIBus *bus;
     bool acpi_pcihp = false;
 
     if (vms->acpi_dev) {
diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index 67d3e836eb1..d3ce082e07a 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -184,7 +184,7 @@ static void xen_ram_init(PCMachineState *pcms,
 static XenPhysmap *get_physmapping(hwaddr start_addr, ram_addr_t size,
                                    int page_mask)
 {
-    XenPhysmap *physmap = NULL;
+    XenPhysmap *physmap;
 
     start_addr &= page_mask;
 
@@ -200,7 +200,7 @@ static hwaddr xen_phys_offset_to_gaddr(hwaddr phys_offset, ram_addr_t size,
                                        int page_mask)
 {
     hwaddr addr = phys_offset & page_mask;
-    XenPhysmap *physmap = NULL;
+    XenPhysmap *physmap;
 
     QLIST_FOREACH(physmap, &xen_physmap, list) {
         if (range_covers_byte(physmap->phys_offset, physmap->size, addr)) {
diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 7ba32405522..5fac1ec3449 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -1678,7 +1678,7 @@ static void riscv_iommu_ats(RISCVIOMMUState *s,
     IOMMUAccessFlags perm,
     void (*trace_fn)(const char *id))
 {
-    RISCVIOMMUSpace *as = NULL;
+    RISCVIOMMUSpace *as;
     IOMMUNotifier *n;
     IOMMUTLBEvent event;
     uint32_t pid;
diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
index 033a546c301..c431d899731 100644
--- a/hw/vfio/cpr-legacy.c
+++ b/hw/vfio/cpr-legacy.c
@@ -212,7 +212,7 @@ void vfio_legacy_cpr_unregister_container(VFIOLegacyContainer *container)
 void vfio_cpr_giommu_remap(VFIOContainer *bcontainer,
                            MemoryRegionSection *section)
 {
-    VFIOGuestIOMMU *giommu = NULL;
+    VFIOGuestIOMMU *giommu;
     hwaddr as_offset = section->offset_within_address_space;
     hwaddr iommu_offset = as_offset - section->offset_within_region;
 
diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index 31c3113f8fb..0b72a2cf5e5 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -333,7 +333,7 @@ static void vfio_ram_discard_unregister_listener(VFIOContainer *bcontainer,
                                                  MemoryRegionSection *section)
 {
     RamDiscardManager *rdm = memory_region_get_ram_discard_manager(section->mr);
-    VFIORamDiscardListener *vrdl = NULL;
+    VFIORamDiscardListener *vrdl;
 
     QLIST_FOREACH(vrdl, &bcontainer->vrdl_list, next) {
         if (vrdl->mr == section->mr &&
@@ -463,7 +463,7 @@ static void vfio_device_error_append(VFIODevice *vbasedev, Error **errp)
 VFIORamDiscardListener *vfio_find_ram_discard_listener(
     VFIOContainer *bcontainer, MemoryRegionSection *section)
 {
-    VFIORamDiscardListener *vrdl = NULL;
+    VFIORamDiscardListener *vrdl;
 
     QLIST_FOREACH(vrdl, &bcontainer->vrdl_list, next) {
         if (vrdl->mr == section->mr &&
diff --git a/hw/xen/xen_pt_config_init.c b/hw/xen/xen_pt_config_init.c
index 3edaeab1e34..bbc82a2bcfa 100644
--- a/hw/xen/xen_pt_config_init.c
+++ b/hw/xen/xen_pt_config_init.c
@@ -62,7 +62,7 @@ static int xen_pt_hide_dev_cap(const XenHostPCIDevice *d, uint8_t grp_id)
 /*   find emulate register group entry */
 XenPTRegGroup *xen_pt_find_reg_grp(XenPCIPassthroughState *s, uint32_t address)
 {
-    XenPTRegGroup *entry = NULL;
+    XenPTRegGroup *entry;
 
     /* find register group entry */
     QLIST_FOREACH(entry, &s->reg_grps, entries) {
@@ -80,7 +80,7 @@ XenPTRegGroup *xen_pt_find_reg_grp(XenPCIPassthroughState *s, uint32_t address)
 /* find emulate register entry */
 XenPTReg *xen_pt_find_reg(XenPTRegGroup *reg_grp, uint32_t address)
 {
-    XenPTReg *reg_entry = NULL;
+    XenPTReg *reg_entry;
     XenPTRegInfo *reg = NULL;
     uint32_t real_offset = 0;
 
-- 
2.53.0


