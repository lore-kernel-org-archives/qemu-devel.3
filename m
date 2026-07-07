Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 534E5C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 08:36:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh1Hw-0005tJ-Kj; Tue, 07 Jul 2026 04:36:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1wh1Hn-0005Rp-Fi
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 04:36:13 -0400
Received: from mail-pz2-x01.google.com ([2607:f8b0:4864:3b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1wh1Hl-00022I-J0
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 04:36:11 -0400
Received: by mail-pz2-x01.google.com with SMTP id
 41be03b00d2f7-c9fe62e0da3so573770a12.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 01:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783413368; x=1784018168; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=klsyONO/Cg3smq3LoYkvbuo2acmHos3YgPohgAu92xU=;
 b=Ktl7kSoNuDbypqyP5s+uXYjYdOFfg7hFxG3y+0oOXAO+6yr9knCrINkAjzaFJwcJge
 rCn3rhtCFDpMzBPTgMj63MmkpbvhNYELbnX1c/4lJDMlsU0q/1344Vl/AsYIxM6OEo2V
 Fsd3NINwM5O4Mfz+P8Gcfgeim6soOrTB/LDusBiTfjqgirnfCjJAORS4HpUH8HR8RZkT
 5zU09A/N3iZYAV5Bx0WPHPDbvVrUKdiEG8gR1BOtZ+oy84haCrZYeNfuCbXFfKnyGF5t
 3aTjGhG9qu3hOx/PDwow62sVz2kfvujtqQUe9CoE0f+y1QOOo6Paaf4W6Ah8xOlUxbWP
 7V/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783413368; x=1784018168;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=klsyONO/Cg3smq3LoYkvbuo2acmHos3YgPohgAu92xU=;
 b=mbxQmLn0mI/3nhgly4kwv3gJ3BJWvILCNNltvvjbnhujLmtujbI5RzaUGtPi9aTzsz
 M+8xGsfxzvg1qjaMTjVdDEVOdKAbKLibvUdic9aMH/1SJBnY1LDG8Yvod1oEnzxQWhQM
 9EAW9m00YSEKSL/I5jLQyfEl0ymPmkrfiXQtcv5XxdA4ZHQR7Qb/kk0rG62jbKfky1lO
 vODcw4bup1LE7BFoqov1PGI56gRtydflDx5EZlqNhzmbfZKSAYUnNHHLd9GfkzJh1z0x
 tA0MP4sxY8aiNZ0L+Yxh8Oo7QdOwDGqtfQnyu9DKDESNKlIzztbYdijbBd+Nyu4juTIS
 QlfA==
X-Gm-Message-State: AOJu0YwJTlugzzVgvralAIjzzM2MZ0DuCtThrHs3W8UTn7fAMGlDk+Dv
 SvlRou0spoNeDMdDj5Uw/TfNU4fgopR9U8NZH5Nv1SzljEQau3l5qK5BFZ8pGKc=
X-Gm-Gg: AfdE7cnl03FZ9LQxzyKr0t/iL3odJ3li3ye8I+RP4Y6CtEHja+FVsd/KXk8np7dI8+y
 kzeO0aFWida4iVc5N/BbRfZ/M9S+R0c836yGUEDufOPQLFXh76hZKb0LGAnzSrKXyuEVdQQ6omA
 8Wy6mi2SFzYPJm4i0/HAJ1AArdpVCRk6me8ajU04BLDHNtvvUflfiHNoX80h2hPjEAvlx1jwacF
 eg4I3DQ4VuaJvTTE9UIAzEcEnN8E0f2+gNvkMX+hNPupOlWdFLMg+Av2KHFKltUmwhCo1Rd5G2N
 iTSUX8bA6Tio5pg6AM7E0eAhfl+/pMVJXD1Uf+DdiE0G8zfMI/HrAB8twT44cOMhNJ5nzOuNZc0
 Y/o5C+B6zdGp5cCZtvryOqw0NLeV0NzUgmmBzjJqybA+khZuIMwO04bGtKcecf5Dszc2NHeGodP
 4=
X-Received: by 2002:a05:6300:67c7:b0:3bf:b68f:4685 with SMTP id
 adf61e73a8af0-3c08ed41d5emr5007695637.23.1783413368210; 
 Tue, 07 Jul 2026 01:36:08 -0700 (PDT)
Received: from kotori-desktop ([2408:820c:8ffe:590::9a0])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3117483e0a2sm5435221eec.12.2026.07.07.01.36.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 01:36:07 -0700 (PDT)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>, K S Maan <kirandeepmaan45@gmail.com>
Subject: [PATCH v5 2/3] vfio/igd: Patch device ID for romfile-provided VBIOS
Date: Tue,  7 Jul 2026 16:35:49 +0800
Message-ID: <20260707083550.25765-3-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707083550.25765-1-tomitamoeko@gmail.com>
References: <20260707083550.25765-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::1;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pz2-x01.google.com
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

Multiple IGD devices of the same generation share the same rom,
the device ID in its PCIR structure may not match. As SeaBIOS checks
the device ID strictly and refuses to run the VBIOS on a mismatch,
the ID has to be patched.

For a ROM read from the kernel ROM BAR, vfio_pci_load_rom() already
patches the device ID and recomputes the checksum. A VBIOS provided by
the user via romfile, however, is loaded by the generic PCI core and
does not receive this IGD-specific fixup.

Introduce vfio_igd_legacy_rom_quirk() in igd.c, which patches the
device ID and recomputes the (known bogus) checksum of a Gen 6-9 IGD
legacy VBIOS. This is registered as romfile_fixup hook when a romfile
is configured so that the romfile-provided VBIOS then receives the
same fixup as one read from the kernel ROM BAR.

Reported-by: K S Maan <kirandeepmaan45@gmail.com>
Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd-stubs.c  |  5 +++++
 hw/vfio/igd.c        | 53 ++++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/pci.h        |  2 ++
 hw/vfio/trace-events |  1 +
 4 files changed, 61 insertions(+)

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
index e091f21b6a..a5c1b57ce4 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -610,6 +610,10 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
         goto error;
     }
 
+    if (pdev->romfile) {
+        pdev->romfile_fixup = vfio_igd_legacy_rom_quirk;
+    }
+
     /*
      * ASLS (OpRegion address) is read-only, emulated
      * It contains HPA, guest firmware need to reprogram it with GPA.
@@ -724,3 +728,52 @@ bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
 
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
+     * non-matching IDs. This duplicates with vfio_pci_load_rom(), but required
+     * for romfile.
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
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index cf56711587..65a1385ce3 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -253,8 +253,10 @@ void vfio_setup_resetfn_quirk(VFIOPCIDevice *vdev);
 bool vfio_add_virt_caps(VFIOPCIDevice *vdev, Error **errp);
 void vfio_quirk_reset(VFIOPCIDevice *vdev);
 VFIOQuirk *vfio_quirk_alloc(int nr_mem);
+
 void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr);
 bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp);
+void vfio_igd_legacy_rom_quirk(PCIDevice *pdev, uint8_t *ptr, uint32_t size);
 
 extern const PropertyInfo qdev_prop_nv_gpudirect_clique;
 
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 4c28b3291c..e472a65a44 100644
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


