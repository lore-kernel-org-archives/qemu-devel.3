Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B1B9CD6E57
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 17:34:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUpU0-0003pJ-9W; Wed, 03 Jun 2026 13:34:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1wUpTt-0003oE-TW
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 13:34:18 -0400
Received: from mail-dy1-x1342.google.com ([2607:f8b0:4864:20::1342])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1wUpTs-0003Ip-DT
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 13:34:17 -0400
Received: by mail-dy1-x1342.google.com with SMTP id
 5a478bee46e88-304d0ac5e3cso709217eec.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 10:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780508055; x=1781112855; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KLWHhIjCClZhHeW5t05J2Skz379RjeVMn7jCEsP+p0c=;
 b=dkyftZv0P9MEZg/VbP++wvwHyv69II6qg1z85eREn8zT6vICL0RIAojMV2G/ZIzjiJ
 9w6RV8DVXyLsttO+B+DwboCZ/j08etPgooNjE1XsX4JikmuTWjY/4FSqBmlVsLdpXjZK
 Yi5RTxyPLe2SvD3ne1e+hoXtNYvmkc5R7d2rZB4MN9puYiedT8puqyqfE6wrtr2CoAd/
 uxCQWCVBIrYbbvCWjsv57m+Xe1fGcOc8tGR8QolNT4CzRXeFjLKdbL3FTcgnTS6FnuV9
 X3dpYHoRLdnte6ELFQQY80kQMoQLvaIVQ9sYgOPHANn/aloo8jQdnRRd6Ocedzvhf/FZ
 yeIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780508055; x=1781112855;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KLWHhIjCClZhHeW5t05J2Skz379RjeVMn7jCEsP+p0c=;
 b=sm7VGVRe8rk8x0fKZVNCR6qQIvkOPio7Yyb0gtPPufUUvCoYG6FG+AhFZq8vkiq5NQ
 htHWlCT46w2gpttEulI/1bktXiex6LVTf2QYMqBmOUgDsLow4vXtFOnsSoGcTw3gNTsO
 tIZtdL0Epdkxr1MDXbQ9Q0Gj7XPDy7jiV6+IuMy4SznIkYy9rDKzPpeVh4Ren4rO2omQ
 lPL7LMYjgTnapTZn+Rbqf+a6k0Glz62J/4ISzlXrOz2kwaEeHcJnKQKr2fEHDQahO4aK
 UTbeQCWnu8jSAkiql71bnno6PpxSjrQcz0+3J8eVBaOYZ3mqlC7fr+ziepOual/ahIXz
 kUog==
X-Gm-Message-State: AOJu0Yx3fM9P8iHezWfvCYhtRgBXS1aJI8nmHbaWx8/nRthXOpKHKUHP
 +/ecX0WZ9iNWSvaL2DBvmbbbL0YmH4K/UEb0L//OekI7IfcuQHRPlvdF7zQEkBKl5Q==
X-Gm-Gg: Acq92OG473T9tHFQR4UMbOVOEWrchHrii1oZYxAXbG8Hwbz/orikVYmZk0cM+oNlX+4
 jlQxcnOg+LYo6ENUKHak6SdaCxRrV6je/sQ2WMBymNYdj9oXCjqFYOdYjVOUmFh6aUio971xI0S
 YD1Tf2tmHDvhpWaccEO7zwhg6Vs1gQrxQWldZ404ora3ATSh44DDRAg7lisczwL32Bmb99D2ZfD
 x++i3Ytjgg6UZ8Ui48cnuVHGlNE7h9YruW+cMJu3vVfF9hfw6KXA061qwZmMKmcWVLxMT+6kGWn
 jxgauS+5qjmgrI8/U0qt7JMaqICdBFjRjkCoCK+hN9fdnFMPO2nhXF7QRQca1/98iUW4nOFOb3L
 afti+1If6KirwIg3zNb0yx9HHTgftZuP73e+GqCHzD15fWnRU0dXYiIH8Q5d4R/CwX7/kROahdZ
 24p3DXXw0e3KAqHlYL0VjTCoJRYKl8oKh7GqTBAyG57w==
X-Received: by 2002:a05:7300:3c21:b0:304:d32e:65f9 with SMTP id
 5a478bee46e88-3074fa65a72mr2317158eec.6.1780508054769; 
 Wed, 03 Jun 2026 10:34:14 -0700 (PDT)
Received: from kotori-desktop ([2408:820c:8ffa:7da0:c45e:b5c8:d6e8:bd7e])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074d9fde90sm4354810eec.0.2026.06.03.10.34.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 10:34:14 -0700 (PDT)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>, K S Maan <kirandeepmaan45@gmail.com>
Subject: [PATCH 4/6] vfio/pci: Use pci_rom_patch_ids() for IGD ROM ID patching
Date: Thu,  4 Jun 2026 01:33:52 +0800
Message-ID: <20260603173355.36121-5-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260603173355.36121-1-tomitamoeko@gmail.com>
References: <20260603173355.36121-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
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

Remove the duplicate inline logic in vfio_pci_load_rom() that patched
the device ID in an IGD option ROM and replace it with a call to
pci_rom_patch_ids(), conditioned on the rom_need_patch_id flag.

Reported-by: K S Maan <kirandeepmaan45@gmail.com>
Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
Tested-by: K S Maan <kirandeepmaan45@gmail.com>
---
 hw/vfio/pci.c | 31 +++----------------------------
 1 file changed, 3 insertions(+), 28 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 9c06b25e63..6cbd65126e 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1029,6 +1029,7 @@ static void vfio_update_msi(VFIOPCIDevice *vdev)
 
 static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
 {
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     VFIODevice *vbasedev = &vdev->vbasedev;
     struct vfio_region_info *reg_info = NULL;
     uint64_t size;
@@ -1084,34 +1085,8 @@ static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
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
+    if (pdev->rom_need_patch_id) {
+        pci_rom_patch_ids(pdev, vdev->rom, vdev->rom_size);
     }
 }
 
-- 
2.53.0


