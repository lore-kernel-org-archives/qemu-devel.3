Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9FA6C44500
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 18:21:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wezYY-00089Q-3E; Wed, 01 Jul 2026 14:21:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1wezYW-00088s-Cq
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 14:21:04 -0400
Received: from mail-pj2-x01.google.com ([2607:f8b0:4864:39::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1wezYU-0007QB-FL
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 14:21:04 -0400
Received: by mail-pj2-x01.google.com with SMTP id
 98e67ed59e1d1-37fb1883fbfso127701a91.0
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 11:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782930061; x=1783534861; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Tfb2whMGpacDTSDAoeZ/x3H7tnheiu8op3PndOS9tgU=;
 b=VymftgxuLnLBaXzX+uT1c/DBp2w3GWtj5kT9TaMs+3fIheQXK3Y0x5NAKabEo67/ay
 gatkAEA3MDotmkdl7Wo6qvPF3sXoZw/QAtqGBuWZC4s1YFVEnFKoNck3J3dwnd1583ED
 2zUdogwpGQQJJDTRkyFW/fZp9jiFradbzon7bLp/ZAex4AaXu33VytxPoSttuUywsnS3
 9AAPhEzadA2TO4XWNjRLQOmba8UMgtcCWxOpOVBcf5RDNsbptOlYX0DAm6oFtinMXcvG
 sBOVU5OMFeDa47wSXBWbDq2RRrENCGPqC5mjyRFA2Ay1+1Z6oXTjhmr1JRSfhXzqclsZ
 RKgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782930061; x=1783534861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Tfb2whMGpacDTSDAoeZ/x3H7tnheiu8op3PndOS9tgU=;
 b=OybfKcJX7PGtT+56p1pVzXs4w/wfjGaFJP7cV4Ruj0NvHP6WktbP+BJK7iFa4T7uMc
 ndZmFmfNF5WFk/pMsqO+lBzH9tYI1UgSs5Yid6D25JAU3iiLDjRAhi/VBundtvjx3uoR
 lO1+Ys56aTcT5dASQ3KNkxO2xECdUVB7Sy58sb/4er883iOLKOrglZO3kr/vECD/EyDx
 MTwXmC0h5EmOcbFZWATdqQ81dmA+HqsQpNL/Fl8ZCIKINC56rSXnwecBTckPsdcoQmzw
 tL/ITRW2IkXpPDMQDX/JaBjuv2fLQTeXV4PWVGd3C7yMT9AC8uN5miFgCvC/bg3LeWGn
 Rn6Q==
X-Gm-Message-State: AOJu0YzrAYfOKiaf2DlTir1xgT6FvbaWZSjzzQlZ2jCvbLpdbOwdB9oh
 AQMr4XjOu2ECQrRbh2AuwaXKht2J6yE4rkt1+NwHFVaf2hRvQ1+2ekIMzld8pxnFUA==
X-Gm-Gg: AfdE7clto5361yJEsBdm5qkVP9kERkU4BdNZaBgZ1r70Q2yscjiYQvVZCpclBxUY6XX
 /70rlVB3SjcDqDrt/vepa6n0lSgGxLP5eb28qliZmpppAj0fvx7111qFgkNBUNOCGrcr8LTJqIB
 A+UK1SpZ8J+2hPEEx1zv7ykg/+LxRk+997654tJoUD069yG0HwJ4OxzCO22B3amcnXnOWRzl8Zs
 9O3oLf/eqjfbJQzCBvDdq8h86IiKmtV0IZQ8RmuCuOKqVOLM5beBYHxqiEdW/Hs2hTMgYLnlhMn
 J0cB35srR0Ymr1aXR7tGubJhGmfCpGgQtagxdVK2SXwNwUlnpwhLoAH6wHMTMa48hHvsygs6zRZ
 nUwOl7BGur8SHVmpYqeHFNPo10qd2XxgKW7HycYZDj9Tb0HGUwh2O/S2xUeLwsbHvuf5ovpoEMh
 P+xjIg6uH+wJiNdHFjIvnva1K0fTAx
X-Received: by 2002:a05:6a20:5493:b0:39b:d5f1:4ff with SMTP id
 adf61e73a8af0-3bff40a53d7mr2516447637.20.1782930061070; 
 Wed, 01 Jul 2026 11:21:01 -0700 (PDT)
Received: from kotori-desktop ([2408:820c:8ffe:590:494:7c85:ae9c:cba8])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f0bc27e0dsm187109eec.27.2026.07.01.11.20.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 11:20:59 -0700 (PDT)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>, K S Maan <kirandeepmaan45@gmail.com>
Subject: [PATCH v4 4/4] vfio/igd: Clear saved BDSM in legacy VBIOS ROM at load
 time
Date: Thu,  2 Jul 2026 02:20:35 +0800
Message-ID: <20260701182035.96010-5-tomitamoeko@gmail.com>
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

[1] 3.5.15, 4th Generation Intel Core Processor Family Datasheet Vol. 2
    https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/4th-gen-core-family-desktop-vol-2-datasheet.pdf

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3093
Reported-by: K S Maan <kirandeepmaan45@gmail.com>
Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd.c | 76 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 6fa8b26201..9a2f2a3c73 100644
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
 
@@ -765,6 +835,12 @@ void vfio_igd_legacy_rom_quirk(PCIDevice *pdev, uint8_t *ptr, uint32_t size)
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
-- 
2.53.0


