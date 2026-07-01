Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52B24C43602
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 18:21:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wezYQ-00086K-ET; Wed, 01 Jul 2026 14:20:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1wezYO-00084z-FZ
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 14:20:56 -0400
Received: from mail-pj2-x01.google.com ([2607:f8b0:4864:39::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1wezYM-0007JQ-GV
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 14:20:56 -0400
Received: by mail-pj2-x01.google.com with SMTP id
 98e67ed59e1d1-37fc07868a1so418460a91.0
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 11:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782930053; x=1783534853; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bjpoGeyM7MVcEFSvfgEvbhz1WXidDgeVcdX+K/7OsJw=;
 b=gLzmombHoin+TRSGnhbuEf1Y4JXF1hli9NgV9BivThgWyP8BtmUDf06Z9AGVWyObYi
 SK8d8kiPbyzP0D7V+J07topwr768YO5a0RgrQyW3rgJNKtC/PFWwoju74hpQTVLFpxSB
 Pn6aC2W7OwOOlEVfk4symR0ncyDFZ9X0lLWAIHV4lQtDB8s07Yg7iN7obM6DvVD9Nosd
 aVyQWlw6Owu/jinRgcYhBEfTkvsB0UTTK5b/1w3Ev/kN028GcK7bPgiheWcLedFF14UP
 Kntta8pEL9GjMzUJVsyNV2JLkQjhHvgJCCIWKWvZiEZ76XHPQ+TtJJ/IaTbjFye9JtuQ
 uM1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782930053; x=1783534853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bjpoGeyM7MVcEFSvfgEvbhz1WXidDgeVcdX+K/7OsJw=;
 b=fjTVSW5Al4oaddqe4A6XFBaJAmeJET4s8Xe4HyQIL1BfZOamhT4Q+HkfZu08zRs/2P
 yO/4Upiaojf1TbZKdqKm+0UBgQ9D9FzoNLh4RVbCHwOObaGRgIgwqqI6TBMTcJbI45iT
 ZzerENfsrh8GA1d2betXRZlLakylQDqz+P+mg55X5HKXS+TUefy3pjw6MFZkCp8/09cT
 BNW1Aeybp0Ld5NQfhAD0kLRQmY5w9NQYVa5BhtKzaH/MKpUc3QmfAfgMVi5EXraheapk
 r8SXjn13yOPHsdCrmysqy6YWDaE5eFiTuOaZO0NXpH0EIU3hNtajHZ7ZaBswf8pM6e63
 0+vw==
X-Gm-Message-State: AOJu0YxjXoXf1cAnDVHbPWJkSfhr+SR1f1WRHJ7KbLpEQdRzt/SMcE8M
 xvZoQKaMu9ywas9FfiUeRh6x6FLpwXC8wq4FXVCDFYegOGeiHaT855AC+A5cbfeGaA==
X-Gm-Gg: AfdE7ckfn8jhiMz7crSDGMAknXBjJa1OiDwsV7pUlzIiba22OGXtAftSOVYKWfGfA86
 oG1R3Y4mT+s7ec08Xmsuh/akdmK8/4Dx8C6koxvLFLvADiZvg1hUEpYO6Q5+u9m83Ju0fAqX/Ke
 +MUaopUaojOinOab+aRWqi979Y5XoWQlYdlNtAdKn5e6oM20ri4wHDjNNioWSmQ9tPFvrk8+/a3
 4Pes3pWWScCvsFRLIzIOfGTgO2yRJFZFXzQSTOVU9CMdM/zRjvBoax0X/nt6L6IHkp3kHKzl9Kd
 tlvWcrdu0AOzxk+ScEcxJ/svZX7npgIrGvG76oSuCfx8evfv82ITK17rm0dEE53IplhozagtMGS
 F6dc+zBTWWTtmY77OzIYKbW+z/pKctFoP47ensfmXPDCFlVaihyDPpzWJmHgGXJGqDZavc+jZWy
 sIbB7dQDsQNscATIGpuw==
X-Received: by 2002:a17:90b:3cce:b0:380:9ef6:e8cc with SMTP id
 98e67ed59e1d1-380aa07e1f3mr2583704a91.5.1782930052893; 
 Wed, 01 Jul 2026 11:20:52 -0700 (PDT)
Received: from kotori-desktop ([2408:820c:8ffe:590:494:7c85:ae9c:cba8])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f0bc27e0dsm187109eec.27.2026.07.01.11.20.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 11:20:52 -0700 (PDT)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>, K S Maan <kirandeepmaan45@gmail.com>
Subject: [PATCH v4 2/4] vfio/igd: Refactor option ROM patching
Date: Thu,  2 Jul 2026 02:20:33 +0800
Message-ID: <20260701182035.96010-3-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260701182035.96010-1-tomitamoeko@gmail.com>
References: <20260701182035.96010-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::1;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pj2-x01.google.com
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

Currently the IGD-specific option ROM patching logic is embedded in
vfio_pci_load_rom() rather than igd.c where IGD-specific code lives.
Move this logic into a dedicated vfio_igd_legacy_rom_quirk() in igd.c.
The refactored quirk patches the device ID and checksum on Gen 6~9
devices with legacy VBIOS as option ROM. A new trace event
vfio_pci_igd_vbios_patched is also introduced.

Arguments of vfio_igd_legacy_rom_quirk() are aligned with romfile_fixup
of PCIDevice so that same logic can be reused on romfile later.

Reported-by: K S Maan <kirandeepmaan45@gmail.com>
Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd-stubs.c  |  5 +++++
 hw/vfio/igd.c        | 48 ++++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/pci-quirks.c |  5 +++++
 hw/vfio/pci.c        | 30 +--------------------------
 hw/vfio/pci.h        |  3 +++
 hw/vfio/trace-events |  1 +
 6 files changed, 63 insertions(+), 29 deletions(-)

diff --git a/hw/vfio/igd-stubs.c b/hw/vfio/igd-stubs.c
index f7687d9091..29110f7568 100644
--- a/hw/vfio/igd-stubs.c
+++ b/hw/vfio/igd-stubs.c
@@ -18,3 +18,8 @@ bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
 {
     return true;
 }
+
+void vfio_igd_legacy_rom_quirk(PCIDevice *pdev, uint8_t *ptr, uint32_t size)
+{
+    return;
+}
diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index e091f21b6a..f597218164 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -724,3 +724,51 @@ bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
 
     return vfio_pci_igd_config_quirk(vdev, errp);
 }
+
+void vfio_igd_legacy_rom_quirk(PCIDevice *pdev, uint8_t *ptr, uint32_t size)
+{
+    VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(pdev);
+    int gen;
+    uint16_t pcir_offset;
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
+    if (pci_get_word(ptr) != 0xaa55) {
+        return;
+    }
+
+    /* Must be a legacy ROM */
+    pcir_offset = pci_get_word(ptr + 0x18);
+    if (pcir_offset + 0x14 >= size || memcmp(ptr + pcir_offset, "PCIR", 4) ||
+        pci_get_byte(ptr + pcir_offset + 0x14) != 0x00) {
+        return;
+    }
+
+    /*
+     * Patch device ID as multiple IGD devices share the same rom with possible
+     * non-matching IDs.
+     */
+    pci_set_word(ptr + pcir_offset + 6, vdev->device_id);
+
+    /*
+     * IGD roms are known to have bogus checksums. No matter we changed the
+     * device ID or not, we need to recalculate the checksum and patch it.
+     */
+    for (i = 0; i < size; i++) {
+        checksum += ptr[i];
+    }
+    ((uint8_t *)ptr)[6] -= checksum;
+
+    trace_vfio_pci_igd_vbios_patched(vdev->vbasedev.name);
+}
diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index bccf31751f..496a79a3ca 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -1592,3 +1592,8 @@ bool vfio_add_virt_caps(VFIOPCIDevice *vdev, Error **errp)
 
     return true;
 }
+
+void vfio_rom_quirk_setup(VFIOPCIDevice *vdev)
+{
+    vfio_igd_legacy_rom_quirk(PCI_DEVICE(vdev), vdev->rom, vdev->rom_size);
+}
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 9c06b25e63..d321e6160a 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1084,35 +1084,7 @@ static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
         }
     }
 
-    /*
-     * Test the ROM signature against our device, if the vendor is correct
-     * but the device ID doesn't match, store the correct device ID and
-     * recompute the checksum.  Intel IGD devices need this and are known
-     * to have bogus checksums so we can't simply adjust the checksum.
-     */
-    if (pci_get_word(vdev->rom) == 0xaa55 &&
-        pci_get_word(vdev->rom + 0x18) + 8 < vdev->rom_size &&
-        !memcmp(vdev->rom + pci_get_word(vdev->rom + 0x18), "PCIR", 4)) {
-        uint16_t vid, did;
-
-        vid = pci_get_word(vdev->rom + pci_get_word(vdev->rom + 0x18) + 4);
-        did = pci_get_word(vdev->rom + pci_get_word(vdev->rom + 0x18) + 6);
-
-        if (vid == vdev->vendor_id && did != vdev->device_id) {
-            int i;
-            uint8_t csum, *data = vdev->rom;
-
-            pci_set_word(vdev->rom + pci_get_word(vdev->rom + 0x18) + 6,
-                         vdev->device_id);
-            data[6] = 0;
-
-            for (csum = 0, i = 0; i < vdev->rom_size; i++) {
-                csum += data[i];
-            }
-
-            data[6] = -csum;
-        }
-    }
+    vfio_rom_quirk_setup(vdev);
 }
 
 /* "Raw" read of underlying config space. */
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index c3a1f53d35..620baddda2 100644
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
+void vfio_igd_legacy_rom_quirk(PCIDevice *pdev, uint8_t *ptr, uint32_t size);
 
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


