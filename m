Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49BBEC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 08:36:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh1Hx-0005zM-5H; Tue, 07 Jul 2026 04:36:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1wh1Hr-0005ai-Gl
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 04:36:15 -0400
Received: from mail-pz2-x00.google.com ([2607:f8b0:4864:3b::])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1wh1Hp-00029y-BI
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 04:36:15 -0400
Received: by mail-pz2-x00.google.com with SMTP id
 41be03b00d2f7-c9a20e73d7cso1170657a12.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 01:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783413372; x=1784018172; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HslTUaRU9OgQSB6SuuY8D6TfTQmigTbw5XgMXVLte18=;
 b=NXGV1d0znLKXPox0ZiN0rs3/HOc9KaSelv/l2bOBkHSEJDqqUgXQXXEb12AhhOyWm3
 TuD6b0nUEGhv7J4VP0sKyOdpHnL19eW8XhUWzYuGiLYnba6JL6KKTsc1onpC6MSVVZ88
 v0iH7GIwuRB976amHBcDvq1LhuGrelnd6FizKIlePcB9Ll1SdW6hkU33dZFeSP/bOGlH
 YcnjJiDxBLFrgh45j5O8R6XyWtMvl/b+SqonIisRzeU0w5zY6NJtrjf5xl9Wrxfmkwlj
 ObHYUspovjWUUI5ZrsV8Q/hFj3B3BUVS+3IiwASbijqS+IIqR2ucqLwCMjwOa+QwTwPR
 bo6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783413372; x=1784018172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HslTUaRU9OgQSB6SuuY8D6TfTQmigTbw5XgMXVLte18=;
 b=fp5CBZSM89ipmhkDaRvT4BA1znt/V/zhv0+dJ4WBofcwvqoiPpeh4Omzx5ieom7UNG
 gFB/M58BZqw+X/ahV3gfAITDdo5iufQ+6gKIzyi+2z6H6aEas8BSFYUF8ZT/9hgC76tq
 CTcmJiD0G9uYNs5al0Yldw8syMODd0y6l2RaIpVePpB6O0gFoKY9HJQVSsAmF4TBi7Qy
 JaEcMqiDeGEJ4WwGgN11YQEVeDG9wvS6fQEBZrI7IHuAtiwaXX5RlsnnyJYe5TTHEAWk
 Hvis3hZKjtUgemWDvNNUnpDtGyS5q3s3h2Lwae6nn9FCaBwnGnu9ZPkcpIU4tiWwiblj
 ykHg==
X-Gm-Message-State: AOJu0YyE7NVe2/5oQwtKimnimRXSAnTZtDps0opiOrOJGWBqQERgDsu9
 RlPlN0+L+Jzcy1jPOALSjX3k6RvKqZJB6B9MV2npADVVoZeX1+6v6ojTxaAGzy8=
X-Gm-Gg: AfdE7clRoVpirFTKuTgXxqynOUJC7UHcrBLknGuLMjAyIrHrIx1NvdUk4QYYiOIqfgR
 210VS3a2gNIdEPJBWZS9ur+y6b3QvuE4C4p9JpLpYEHLd2do8/pMRf3jt2TZAuYg16qEC5jsPQU
 lC6dxDWVUF+gJdbZjbcRFXrpDLZtqIgbW9sp5v9O37dimx2yMmSHd8oVAC1WnXB9EbVUZ6d+7mD
 IhgRi+8gsWPYwlUUZ4WW+ZxLaxj/JpaF6Rm7bDTl19PZiB9eKJO0TuBSq3vo+fps59S2f08sC+p
 zOjnrmiBPWpoIqg3CJMKI9FL83eN/nB2/ci39R3MmNkLeDNkFx3A8xUkfcpST2EEbvPXEAAtXQv
 oMJsaSvs8lj2pUWBfNG1eJsAmvgqPCYBZQZ++wOmmagxW+mcd+7CWzGRHQ+71fUz2xMY0XteT3o
 Y=
X-Received: by 2002:a05:6a20:7491:b0:3bf:ba2a:6a8e with SMTP id
 adf61e73a8af0-3c08edbe498mr5340709637.21.1783413371786; 
 Tue, 07 Jul 2026 01:36:11 -0700 (PDT)
Received: from kotori-desktop ([2408:820c:8ffe:590::9a0])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3117483e0a2sm5435221eec.12.2026.07.07.01.36.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 01:36:11 -0700 (PDT)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>, K S Maan <kirandeepmaan45@gmail.com>
Subject: [PATCH v5 3/3] vfio/igd: Clear saved BDSM in legacy VBIOS ROM at load
 time
Date: Tue,  7 Jul 2026 16:35:50 +0800
Message-ID: <20260707083550.25765-4-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707083550.25765-1-tomitamoeko@gmail.com>
References: <20260707083550.25765-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pz2-x00.google.com
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

The quirk is now also invoked from vfio_pci_load_rom(), so the fix
applies to the VBIOS whether it is read from the kernel ROM BAR or
supplied through romfile.

[1] 3.5.15, 4th Generation Intel Core Processor Family Datasheet Vol. 2
    https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/4th-gen-core-family-desktop-vol-2-datasheet.pdf

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3093
Reported-by: K S Maan <kirandeepmaan45@gmail.com>
Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd.c        | 76 ++++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/pci-quirks.c |  5 +++
 hw/vfio/pci.c        |  2 ++
 hw/vfio/pci.h        |  1 +
 4 files changed, 84 insertions(+)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index a5c1b57ce4..d26744a6c6 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -729,11 +729,81 @@ bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
     return vfio_pci_igd_config_quirk(vdev, errp);
 }
 
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
 void vfio_igd_legacy_rom_quirk(PCIDevice *pdev, uint8_t *ptr, uint32_t size)
 {
     VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(pdev);
     int gen;
     uint16_t pcir_offset;
+    int ret;
+    uint16_t bdsm_offset = 0;
     uint8_t checksum = 0;
     uint32_t i;
 
@@ -766,6 +836,12 @@ void vfio_igd_legacy_rom_quirk(PCIDevice *pdev, uint8_t *ptr, uint32_t size)
      */
     pci_set_word(ptr + pcir_offset + 6, vdev->device_id);
 
+    /* Search and clear the saved BDSM value */
+    ret = igd_vbios_find_saved_bdsm(ptr, size, &bdsm_offset);
+    if (ret == 0) {
+        memset(ptr + bdsm_offset, 0, sizeof(uint32_t));
+    }
+
     /*
      * IGD roms are known to have bogus checksums. No matter we changed the
      * device ID or not, we need to recalculate the checksum and patch it.
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
index 4d822b96b5..c40a6f7ca6 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1114,6 +1114,8 @@ static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
             data[6] = -csum;
         }
     }
+
+    vfio_rom_quirk_setup(vdev);
 }
 
 /* "Raw" read of underlying config space. */
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 65a1385ce3..fb70113e3a 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -251,6 +251,7 @@ void vfio_bar_quirk_exit(VFIOPCIDevice *vdev, int nr);
 void vfio_bar_quirk_finalize(VFIOPCIDevice *vdev, int nr);
 void vfio_setup_resetfn_quirk(VFIOPCIDevice *vdev);
 bool vfio_add_virt_caps(VFIOPCIDevice *vdev, Error **errp);
+void vfio_rom_quirk_setup(VFIOPCIDevice *vdev);
 void vfio_quirk_reset(VFIOPCIDevice *vdev);
 VFIOQuirk *vfio_quirk_alloc(int nr_mem);
 
-- 
2.53.0


