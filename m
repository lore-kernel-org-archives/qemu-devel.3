Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC08ECD6E57
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 17:34:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUpU1-0003qA-Ke; Wed, 03 Jun 2026 13:34:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1wUpU0-0003pV-A0
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 13:34:24 -0400
Received: from mail-dy1-x1342.google.com ([2607:f8b0:4864:20::1342])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1wUpTx-0003Kn-Td
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 13:34:23 -0400
Received: by mail-dy1-x1342.google.com with SMTP id
 5a478bee46e88-304e83724bfso7874721eec.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 10:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780508060; x=1781112860; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KCCp7hJjaFWhdypw9Vuzd37+kDa4/M5qst0FJOmaG18=;
 b=ZO0TcwUffMaSQZAaQUdizhqsdBHWA3gYuJyw87mm+iZtE5NEEIjYg3xHF8/C4lCXG7
 DgXNLbuIIdjfPrsbIaIRiby/2j30XKnHYzOvx5V/09qCzZWaFnjonoiAC5iROh8+sgnT
 D2fZXCRpRkdtritxm8xV12ipf8OweOnjTHAkkkp9Ka8+zX7BOkmieBvLHrPKhMESYEMd
 75KZ8Ylpq+ylfGblM6Bfc4UR0N9dGLcwJufOTZzYyNiashHG7ndF3gcXN3ooWSFXtdk0
 r63+mLNTV4WBwKlIq9uHQgHbqMyxEYD7YpBzNaBoDuq7IiOFgs03KwlSOMFgwYXarOfw
 Tk5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780508060; x=1781112860;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KCCp7hJjaFWhdypw9Vuzd37+kDa4/M5qst0FJOmaG18=;
 b=i3MOzJ40+oInFI+k6LfbVd/uA24b5K4EX1ixrg8IDxJ+tKbDX8RB0VbHZWudX/5GV5
 aNQXc1xe0OXFrB4aKTR1KjAYC60Gbe67i2KaCaMZ+3rLPlOflkQbcYgBcoaIBPuBZi/I
 WogAYPe1isL5Nj1ZjdCRrVdjFKRpZlPWJWrvQKr789PiedMD2XQv1gok+cJDd0+xLxVB
 V1Lnxiptyn31FUFv7Goz3pDNs5ZkJedqvF2QrdlPxFn7izKC3j9WoMJY1oHVHq2p1/Ie
 UjueZBxg2oagMz2mgSqcLvwyuvP/rLcjqw0Noqb1fNXWIyHG8uLvBDnWeU92WqYImJnS
 BiQg==
X-Gm-Message-State: AOJu0YyhULeATElkwGo7T9uB9dGr6pPN7xA0M/EvtrhYGaOQveVB7GwD
 9/Wc21e8bU56qdgh0/Wkm3tGvhwBMC982j2mLpEK0t/6xovJPFTCG+V4W2ogw17Hew==
X-Gm-Gg: Acq92OF2PiXeRVuBlXMzXZViKFva8nKnXO4LMthiOQ0ba2yObXua4TasFTLiWt9gckI
 MzUHOTGZ/5qadsRINkAWh/5xXhqFv4OkHs31mRgK801/fX/n1ZFDyQUjSdT9dhNiBWYkTYevu9D
 TktQ+0TawZ5UVAklw1biRuEYXkHE0OC85qMZ0eK6UZtezv4d+z5G4S9oU7Lfgpaz85T96ic52Ny
 AXffIjSfMP9wM1e+twuWxvXztW/0bFEaZsJIGDF9nlhg9B/wdCcTmIbn8saALA4A/Szp6cxIa/7
 uhVXMfD3he0CWHo8zcEftyoHPMiq8Calz7RVaImI2FXfChKBtkLhH1ofShVhPP/L7VerPW4O06O
 xBu+l0gmKHl0D36v6XhSNfAK2NSWkg0348PUj3mWTKsQ+8lmlpwMC40wtPoImb/IUuFDKF2JF3i
 rQVCoId+E84e8W0OWNWYqynSYWkhrfgnW3CyxCjSq3lidjmmmYeA96
X-Received: by 2002:a05:7301:4592:b0:304:d788:ac5 with SMTP id
 5a478bee46e88-3074fcb2470mr2236559eec.35.1780508060280; 
 Wed, 03 Jun 2026 10:34:20 -0700 (PDT)
Received: from kotori-desktop ([2408:820c:8ffa:7da0:c45e:b5c8:d6e8:bd7e])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074d9fde90sm4354810eec.0.2026.06.03.10.34.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 10:34:20 -0700 (PDT)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>, K S Maan <kirandeepmaan45@gmail.com>
Subject: [PATCH 6/6] vfio/igd: Clear saved BDSM in legacy VBIOS ROM at load
 time
Date: Thu,  4 Jun 2026 01:33:54 +0800
Message-ID: <20260603173355.36121-7-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260603173355.36121-1-tomitamoeko@gmail.com>
References: <20260603173355.36121-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1342;
 envelope-from=tomitamoeko@gmail.com; helo=mail-dy1-x1342.google.com
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

Considering it's unsafe to expose HPA to guest, a ROM quirk clearing
the saved value in VBIOS image is introduced. It searches the BDSM
accessor routine by matching a 19-byte signature anchored on the unique
`mov $0x105e,%ax` instruction, then locate the offset of saved BDSM and
clears it. This makes the routine fall through to the PCI config read
on the first call inside the guest.

The quirk is invoked in vfio_pci_load_rom(), and is gated on Gen 6-9
IGD devices with VGA access enabled and legacy (non-UEFI) PCIR code
type in the ROM header. A new trace event vfio_pci_igd_vbios_patched
is also introduced.

[1] 3.5.15, 4th Generation Intel Core Processor Family Datasheet Vol. 2
    https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/4th-gen-core-family-desktop-vol-2-datasheet.pdf

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3093
Reported-by: K S Maan <kirandeepmaan45@gmail.com>
Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
Tested-by: K S Maan <kirandeepmaan45@gmail.com>
---
 hw/vfio/igd-stubs.c  |   5 ++
 hw/vfio/igd.c        | 106 +++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/pci-quirks.c |   5 ++
 hw/vfio/pci.c        |   2 +
 hw/vfio/pci.h        |   3 ++
 hw/vfio/trace-events |   1 +
 6 files changed, 122 insertions(+)

diff --git a/hw/vfio/igd-stubs.c b/hw/vfio/igd-stubs.c
index f7687d9091..879a8aff56 100644
--- a/hw/vfio/igd-stubs.c
+++ b/hw/vfio/igd-stubs.c
@@ -18,3 +18,8 @@ bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
 {
     return true;
 }
+
+void vfio_probe_igd_legacy_rom_quirk(VFIOPCIDevice *vdev)
+{
+    return;
+}
diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 17437ae18d..e00f6f8315 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -739,3 +739,109 @@ bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
 
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
+ *   66 5b                 2：pop   %ebx
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
+        *bdsm_offset = rom[i + 4] | ((uint16_t)rom[i + 5] << 8);
+        found = true;
+    }
+
+    if (!found) {
+        return -ENOENT;
+    }
+
+    return 0;
+}
+
+void vfio_probe_igd_legacy_rom_quirk(VFIOPCIDevice *vdev)
+{
+    int ret, gen;
+    uint16_t pcir_offset, bdsm_offset = 0;
+    uint8_t checksum;
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
+    if (pci_get_word(vdev->rom) != 0xaa55) {
+        return;
+    }
+
+    /* Must be a legacy ROM */
+    pcir_offset = pci_get_word(vdev->rom + 0x18);
+    if (pcir_offset >= vdev->rom_size ||
+        memcmp(vdev->rom + pcir_offset, "PCIR", 4) ||
+        pci_get_byte(vdev->rom + pcir_offset + 0x14) != 0x00) {
+        return;
+    }
+
+    ret = igd_vbios_find_saved_bdsm(vdev->rom, vdev->rom_size, &bdsm_offset);
+    if (ret < 0) {
+        return;
+    }
+
+    memset(vdev->rom + bdsm_offset, 0, sizeof(uint32_t));
+
+    checksum = pci_rom_calculate_checksum(vdev->rom, vdev->rom_size);
+    ((uint8_t *)vdev->rom)[6] = checksum;
+
+    trace_vfio_pci_igd_vbios_patched(vdev->vbasedev.name);
+}
diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index bccf31751f..45db968681 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -1592,3 +1592,8 @@ bool vfio_add_virt_caps(VFIOPCIDevice *vdev, Error **errp)
 
     return true;
 }
+
+void vfio_rom_quirk_setup(VFIOPCIDevice *vdev)
+{
+    vfio_probe_igd_legacy_rom_quirk(vdev);
+}
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 6cbd65126e..66d6315e6f 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1088,6 +1088,8 @@ static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
     if (pdev->rom_need_patch_id) {
         pci_rom_patch_ids(pdev, vdev->rom, vdev->rom_size);
     }
+
+    vfio_rom_quirk_setup(vdev);
 }
 
 /* "Raw" read of underlying config space. */
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index c3a1f53d35..d8d6c09632 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -251,10 +251,13 @@ void vfio_bar_quirk_exit(VFIOPCIDevice *vdev, int nr);
 void vfio_bar_quirk_finalize(VFIOPCIDevice *vdev, int nr);
 void vfio_setup_resetfn_quirk(VFIOPCIDevice *vdev);
 bool vfio_add_virt_caps(VFIOPCIDevice *vdev, Error **errp);
+void vfio_rom_quirk_setup(VFIOPCIDevice *vdev);
 void vfio_quirk_reset(VFIOPCIDevice *vdev);
 VFIOQuirk *vfio_quirk_alloc(int nr_mem);
+
 void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr);
 bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp);
+void vfio_probe_igd_legacy_rom_quirk(VFIOPCIDevice *vdev);
 
 extern const PropertyInfo qdev_prop_nv_gpudirect_clique;
 
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 2049159015..7dc334ccb3 100644
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


