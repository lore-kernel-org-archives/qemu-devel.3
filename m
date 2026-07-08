Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29024C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 10:31:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whPYr-0007Hh-Ug; Wed, 08 Jul 2026 06:31:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1whPYq-0007HI-D1
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 06:31:24 -0400
Received: from mail-pj2-x02.google.com ([2607:f8b0:4864:39::2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1whPYn-00011X-RA
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 06:31:24 -0400
Received: by mail-pj2-x02.google.com with SMTP id
 d9443c01a7336-2ccbff2e6a7so3668805ad.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 03:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783506680; x=1784111480; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=FR5sfLV7YlaTbD23N+YM6TPHrTsL2yfa9NHGWki4kHI=;
 b=Ex/Xd9Nx9EzdUzyB0UdG38zXdpekaKSM53D6Ro0nCrqwkd04Y2r3v/YawMhihnHViQ
 /AsfEaWUaiSKFjaYJc0y65f/mrDcBU4p+H5REayMmx4WmaJy+xhYOXXIX+TEkWLfkzDf
 iY6DZ1fp88BcyOmuBhUI6DoWQWPwl45D3VBuybXW5c1pgk1EltlD9pqlcwIJPKC/MKzY
 15vof6zO31HLTVKbozFy/1qbG4GJnOtUrIfMukzIu0znMSddgWKz15I7JzNu53hTBJQI
 TwnSgSxQ0316MBuGLJ+27zkdpRiVFuFVVLlOaXtNWP5MPP3WZNE7H4DBSlE8i9Lnew8U
 46Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783506680; x=1784111480;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FR5sfLV7YlaTbD23N+YM6TPHrTsL2yfa9NHGWki4kHI=;
 b=JUpwH4UCw6ma1bI/QJKvXhUdfMxESSmScb3ASd7aREP9lVD6jisR+zNipRgw6qyNPT
 sAI2qZJnzH7g24WJLuoYhLrYpwU18kDYjEVCVSxOibw+2yeUM9X1OCK78yWKFy8K/GCl
 JN39NCYF+7ZvBznhgXOvr/kGq8jyaiAhgNLYPNVd/BP3vCcFiWp4tGjZmg7Q/8IxAfU3
 PUUK2ymRwECCmAbFX+Fwl9uHUaEdj6HOisq+pbeqBabDfqiO5lQj+TI5SNZjB/D8R6Cx
 s1Z25ahrC+YHO4dJIf8jGwQPT6csXn0yCwSMPUXe+iedLUGy5t/i0yaTY7mFTlqMHjMO
 MMCg==
X-Gm-Message-State: AOJu0YwMZDT/rK1NQh8zyEzcUTsCXrkMRcdGe9JKXMZrHq8gLuxsnHpx
 RcllfPTYfhzXjCa2Ry01UrfKXdNmyR+r3gbLx5X3gbjVkOM0Mork99CSuch1SAJSAg==
X-Gm-Gg: AfdE7clLzpSxkzY5lxZTtNKWeKO/j3R2hEp/QYoNw3PfiAelTV2t/xg/iimXkbNAVvd
 dWwK0OwHFnViFgmN6jbbbTkN3ekxWU+4JpLJMwyCNzSmiYNpbNXhUXUK1nxTviGgFcEbIag3GCA
 lhcknbbxACsmnaoLmnhMzd9sxJlltgNQ52akFnpMW+IDDuIOxGULsG/0L0a1EDym9PgiFsTUzvT
 gtgvH0T5ZjF78NGO5seEeG0AkLe0HUvL4n2Mkis0Bz+pFnEQt6/UPHNw8uqtTQ2CraYzboSmRlH
 yn8uc8Yth8V7Mi7GtaLT7LIkHdJkBPI3E1RhKNuF/3bB8npCZv22BaImdS9rLyS+NzzhpeyN9e9
 rlVelL97LXOA5SPG8DdYcoW7YfaYmIH7YhQtOmN4VGjyQ4BRfDvUJJUzhKaATpMDkNJyL8JOBuz
 w=
X-Received: by 2002:a05:6a21:339f:b0:3c0:9c19:6583 with SMTP id
 adf61e73a8af0-3c0bcf97af7mr2812515637.61.1783506679751; 
 Wed, 08 Jul 2026 03:31:19 -0700 (PDT)
Received: from kotori-desktop ([2408:820c:8ffe:590::9a0])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31174a8f521sm18351768eec.22.2026.07.08.03.31.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 03:31:19 -0700 (PDT)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>, K S Maan <kirandeepmaan45@gmail.com>,
 qemu-stable@nongnu.org
Subject: [PATCH v6] vfio/igd: Clear saved BDSM in legacy VBIOS ROM at load time
Date: Wed,  8 Jul 2026 18:31:00 +0800
Message-ID: <20260708103100.23127-1-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::2;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pj2-x02.google.com
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

IGD does not come with a ROM BAR [1], the ROM BAR read by default from
kernel is actually the host VBIOS shadow RAM region that contains host
modifications on boot. With AI-assisted reverse engineering on VBIOS
binaries, it is observed that VBIOS saves BDSM register value on first
access and uses saved value if present.

When the image is executed in guest, since there is already a saved HPA
in VBIOS, it keeps using that value instead of the GPA programmed by
SeaBIOS in BDSM register in PCI config space, causing VBIOS to program
GTT entries with wrong address, resulting in garbled output in BIOS
POST and the error below detected by i915 driver.

i915 0000:00:02.0: [drm] *ERROR* Initial plane programming using invalid range, dma_addr=0x00000000db200000 ((null) [0x00000000baf00000-0x00000000beefffff])

The previous solution, c4c45e943e51 ("vfio/pci: Intel graphics legacy
mode assignment"), adjusts GTT entry addresses to (addr - host BDSM +
guest BDSM) to workaround that. But it is removed in 5aed8b0f0be2
("vfio/igd: Remove GTT write quirk in IO BAR 4") due to inconsistent
values in MMIO BAR0 and IO BAR4.

Since it was a value latched into the VBIOS that breaks virtualization
(QEMU does not map the GTT at the same address in the VM), a ROM quirk
clearing the saved value in VBIOS image is introduced. It searches the
BDSM accessor routine by matching a 19-byte signature anchored on the
unique `mov $0x105e,%ax` instruction, then locates the offset of saved
BDSM and clears it. This makes the routine fall through to the PCI
config read on the first call inside the guest.

[1] 3.5.15, 4th Generation Intel Core Processor Family Datasheet Vol. 2
    https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/4th-gen-core-family-desktop-vol-2-datasheet.pdf

Fixes: 5aed8b0f0be2 ("vfio/igd: Remove GTT write quirk in IO BAR 4")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3093
Reported-by: K S Maan <kirandeepmaan45@gmail.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
Changelog:
v6:
* Make it a self-contained regression fix for the ROM read through vfio
  path only reported in the gitlab issue, per v5 comment from Alex.
* Reword the commit message.
* Cc stable as this is now a regression fix for QEMU 10.0+.
Link: https://lore.kernel.org/all/20260707083550.25765-1-tomitamoeko@gmail.com/t

v5:
* Keep the current ID and checksum patching logic in vfio_pci_load_rom()
  since it is not IGD-specific, as pointed out by Alex. The IGD-specific
  quirk is now invoked after the generic patching. The ID and checksum
  patching is duplicated in vfio_igd_legacy_rom_quirk() to handle the
  romfile path, since the generic patching is not invoked on romfile.
* Picked up the Michael's Acked-by on patch 1.
* Reduced from 4 to 3 patches.
Link: https://lore.kernel.org/all/20260701182035.96010-1-tomitamoeko@gmail.com/t

v4:
* Reworked per review feedback to keep IGD-specific workarounds out of
  the generic PCI code. Instead of recalculating the checksum in
  hw/pci/pci.c, a single generic romfile_fixup hook is added for device-
  specific ROM patching. Now both kernel ROM BAR and romfile paths share
  the same quirk, so the saved BDSM in user-provided romfile will also
  get cleared.
* Reduced from 7 to 4 patches.
Link: https://lore.kernel.org/all/20260617100646.28326-1-tomitamoeko@gmail.com/t

v3:
* Refactor ROM checksum calculation and patching logic as Alex's comment
* Fix boundary checks as comments in v2.
Link: https://lore.kernel.org/all/20260608134559.23971-1-tomitamoeko@gmail.com/t

v2:
* New patch 2/7 to fix regression with EFI option ROMs
* Refine logic in ROM ID and checksum patching
* Reorder patch 4 and 5 for cleaner bisection
* Address comments from v1
Link: https://lore.kernel.org/all/20260603173355.36121-1-tomitamoeko@gmail.com/t

 hw/vfio/igd-stubs.c  |   5 ++
 hw/vfio/igd.c        | 115 +++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/pci-quirks.c |   5 ++
 hw/vfio/pci.c        |   2 +
 hw/vfio/pci.h        |   3 ++
 hw/vfio/trace-events |   1 +
 6 files changed, 131 insertions(+)

diff --git a/hw/vfio/igd-stubs.c b/hw/vfio/igd-stubs.c
index f7687d9091..5f60b24c8b 100644
--- a/hw/vfio/igd-stubs.c
+++ b/hw/vfio/igd-stubs.c
@@ -18,3 +18,8 @@ bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
 {
     return true;
 }
+
+void vfio_igd_legacy_rom_quirk(VFIOPCIDevice *vdev)
+{
+    return;
+}
diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index e091f21b6a..413a49aae9 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -724,3 +724,118 @@ bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
 
     return vfio_pci_igd_config_quirk(vdev, errp);
 }
+
+/*
+ * IGD ROM BAR read from kernel is actually the host VBIOS shadow RAM region,
+ * which contains host modifications. In Gen 6-9 VBIOS, the routine below is
+ * used to get BDSM value when programming the initial GTT.
+ *   xx xx xx xx           v: .long ?                  # saved value
+ *   66 53                    push  %ebx
+ *   66 2e 83 3e xx xx 00     cmpl  $0x0,%cs:v         # is saved value empty?
+ *   74 07                    je    1f                 # if zero, go compute
+ *   66 2e a1 xx xx           mov   %cs:v,%eax         # else return saved value
+ *   eb 0f                    jmp   2f
+ *   b8 5e 10              1: mov   $0x105e,%ax        # dev 00:02.0, offset 5E
+ *   e8 xx xx                 call  pci_read_cfg_word
+ *   66 c1 e0 10              shl   $0x10,%eax         # left shift 16 bits
+ *   66 2e a3 xx xx           mov   %eax,%cs:v         # save the result
+ *   66 5b                 2: pop   %ebx
+ *   c3                       ret
+ * When running the VBIOS in guest, saved value still reflects the host stolen
+ * memory base address, which is not correct in guest. So we need to patch the
+ * VBIOS to clear the saved value.
+ *
+ * The unique 19-byte starts at `cmpl $0,%cs:v` and ends at `mov $0x105e,%ax`
+ * anchors the match to the routine. Both `cs:` displacements must reference
+ * the same offset.
+ */
+static int igd_vbios_find_saved_bdsm(const uint8_t *rom, size_t rom_size,
+                                     uint16_t *bdsm_offset)
+{
+    static const uint8_t start[] = { 0x66, 0x2e, 0x83, 0x3e };
+    static const uint8_t middle[] = { 0x00, 0x74, 0x07, 0x66, 0x2e, 0xa1 };
+    static const uint8_t end[] = { 0xeb, 0x0f, 0xb8, 0x5e, 0x10 };
+    uint16_t val;
+    size_t i;
+    bool found = false;
+
+    if (rom_size < 19) {
+        return -ENOENT;
+    }
+
+    for (i = 0; i + 19 <= rom_size; i++) {
+        if (memcmp(rom + i, start, sizeof(start)) != 0 ||
+            memcmp(rom + i + 6, middle, sizeof(middle)) != 0 ||
+            memcmp(rom + i + 14, end, sizeof(end)) != 0) {
+            continue;
+        }
+
+        /* same saved value address? */
+        if (rom[i + 4] != rom[i + 12] || rom[i + 5] != rom[i + 13]) {
+            continue;
+        }
+
+        if (found) {
+            return -EEXIST;
+        }
+
+        val = rom[i + 4] | ((uint16_t)rom[i + 5] << 8);
+        if (val + sizeof(uint32_t) <= rom_size) {
+            *bdsm_offset = val;
+            found = true;
+        }
+    }
+
+    if (!found) {
+        return -ENOENT;
+    }
+
+    return 0;
+}
+
+void vfio_igd_legacy_rom_quirk(VFIOPCIDevice *vdev)
+{
+    uint8_t *rom = vdev->rom;
+    int gen;
+    uint16_t pcir_offset;
+    uint16_t bdsm_offset = 0;
+    uint8_t checksum = 0;
+    uint32_t i;
+
+    if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
+        !vfio_is_vga(vdev) || !vdev->vga) {
+        return;
+    }
+
+    /* Only Gen 6~9 devices have legacy VBIOS as Option ROM */
+    gen = igd_gen(vdev);
+    if (gen < 6 || gen > 9) {
+        return;
+    }
+
+    if (pci_get_word(rom) != 0xaa55) {
+        return;
+    }
+
+    /* Must be a legacy ROM */
+    pcir_offset = pci_get_word(rom + 0x18);
+    if (pcir_offset + 0x14 >= vdev->rom_size ||
+        memcmp(rom + pcir_offset, "PCIR", 4) ||
+        pci_get_byte(rom + pcir_offset + 0x14) != 0x00) {
+        return;
+    }
+
+    /* Search and clear the saved BDSM value */
+    if (igd_vbios_find_saved_bdsm(rom, vdev->rom_size, &bdsm_offset)) {
+        return;
+    }
+    memset(rom + bdsm_offset, 0, sizeof(uint32_t));
+
+    /* Recalculate checksum and patch it. */
+    for (i = 0; i < vdev->rom_size; i++) {
+        checksum += rom[i];
+    }
+    rom[6] -= checksum;
+
+    trace_vfio_pci_igd_vbios_patched(vdev->vbasedev.name);
+}
diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index bccf31751f..c5b4f9091d 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -1592,3 +1592,8 @@ bool vfio_add_virt_caps(VFIOPCIDevice *vdev, Error **errp)
 
     return true;
 }
+
+void vfio_rom_quirk_setup(VFIOPCIDevice *vdev)
+{
+    vfio_igd_legacy_rom_quirk(vdev);
+}
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index c204706e63..dcfc92aae1 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1119,6 +1119,8 @@ static bool vfio_pci_load_rom(VFIOPCIDevice *vdev, Error **errp)
         }
     }
 
+    vfio_rom_quirk_setup(vdev);
+
     return true;
 }
 
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index fe52e9df6e..c9ab949870 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -252,10 +252,13 @@ void vfio_bar_quirk_exit(VFIOPCIDevice *vdev, int nr);
 void vfio_bar_quirk_finalize(VFIOPCIDevice *vdev, int nr);
 void vfio_setup_resetfn_quirk(VFIOPCIDevice *vdev);
 bool vfio_add_virt_caps(VFIOPCIDevice *vdev, Error **errp);
+void vfio_rom_quirk_setup(VFIOPCIDevice *vdev);
 void vfio_quirk_reset(VFIOPCIDevice *vdev);
 VFIOQuirk *vfio_quirk_alloc(int nr_mem);
+
 void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr);
 bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp);
+void vfio_igd_legacy_rom_quirk(VFIOPCIDevice *vdev);
 
 extern const PropertyInfo qdev_prop_nv_gpudirect_clique;
 
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index f71d0bbc0a..bfdaf229e4 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -90,6 +90,7 @@ vfio_pci_igd_bar4_write(const char *name, uint32_t index, uint32_t data, uint32_
 vfio_pci_igd_bdsm_enabled(const char *name, int size) "%s %dMB"
 vfio_pci_igd_host_bridge_enabled(const char *name) "%s"
 vfio_pci_igd_lpc_bridge_enabled(const char *name) "%s"
+vfio_pci_igd_vbios_patched(const char *name) "%s"
 
 # listener.c
 vfio_iommu_map_notify(const char *op, uint64_t iova_start, uint64_t iova_end) "iommu %s @ 0x%"PRIx64" - 0x%"PRIx64
-- 
2.53.0


