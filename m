Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B939CD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 10:08:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZnB0-0003uQ-Jv; Wed, 17 Jun 2026 06:07:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1wZnAy-0003t5-E9
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 06:07:16 -0400
Received: from mail-dy1-x1341.google.com ([2607:f8b0:4864:20::1341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1wZnAw-0008RR-VJ
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 06:07:16 -0400
Received: by mail-dy1-x1341.google.com with SMTP id
 5a478bee46e88-304d8362a58so586175eec.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 03:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781690833; x=1782295633; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9k1bsJjY8Pm3QqNdtzXNMjSxvoCU22dmmB0G8fCK1/U=;
 b=Wf2R47mlFjyY8/HqUbzXav6HEf6TffkpXA95vCyK0BmbIFJqVZBb4hpBzoCZyuT3QY
 H7i8Ou2mE9chg1f6Y9LKFP6rDiXzWKcBe7qDl5G1f3GxM8AI1aK06gR44l+mhDLIjsRw
 T1Y8aP+/ZZGVPcFn+zezLXcB1YEt5KL/mK39aWa6oHqfJcNsFdb0sSM/T7toLya0pZJ8
 OKSokj1b7P3Nmv8gnG9DmUzQnHiC+XZIPuqReCVZRDIX6DrQn8i9A1bnjkiCiylbtYJt
 sj37jpdScXDQ8YaGdrLtbJnuWO8rHZXDO6++VoMB/2n4fnYPhmx41p6hNDwytA9CLMLR
 4QKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781690833; x=1782295633;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9k1bsJjY8Pm3QqNdtzXNMjSxvoCU22dmmB0G8fCK1/U=;
 b=UPFj9gfrtZfS+D4VgKvdS0eck8Eu7GarJsoFP24IEzA5fkWD03aTjNVphUjVdIH1jH
 WXrTXKxbFKpD6rE+lWG9Wx+qQCbhjt3T7WXK7IZynk539eD8i1A5j6o6U8QA8kA84X8u
 muXbSZ52+ErGFRSBaVSLKGFhDGMJmC2YZ9ciZC3VQPQSUwYmPxAv7KFPwr6+MgNQWZ2G
 2eJPwJnawfuURS6jRICdo/P2EK7WzWhhNQZyCk82ZB4qj80QYU/7rKBqed7gApDP/9I0
 eef6QYbOB4St5Ynhds2SJm1Up3A05JYAJCHgDajguzxtVMBQeF+hy0MHKjiE8SnErhw8
 G1zQ==
X-Gm-Message-State: AOJu0YyoG/4DoZnff43hd0RoWDnV0ogiiv+15+kXO/EeRyHNu7q1Q6//
 06romDQqNmGL8/yAjYY2MGfhaXbBoSM0YL5hgRpfbVaD84Ihp5tIXOcLRruMemY7gw==
X-Gm-Gg: AfdE7clLiYyxS7jF7P01bq0KqGEbJkdvuwTzFRoB+ECD+Xcnl8MRGXPz7Jvrjda5Q3t
 nKufe+SDwpnsTowJqUUdJV5UNQqnLobXC6rf/LjfU6XRLBUpBMWzUBhI9nzM69KUbkyTKMzvsZM
 VanTOw+2mCQeTFXqvQChuZfYGll9ZpJoywsJ7VvutMPjb4/9HaWTD0QudP6UpWjtWiqmw4tEwwt
 d80XJQnYpNqJSKCpfnatQo4I+CECbMv0zp6jGF3y16R6VO++4832BwkzVIgCRIP3c/Sy9pSDZxe
 bCm2R5StNtBB5XKFL57hGcVsENLYmAJ+a/ckOBQPQEXBgAcZ8U2aHEnBr1WwExGvR6HbEmLDzPt
 fMs6tnXbzBDEHr3ao8KtU5ytsRlmIl31wPFGIfjFa548bgGsGcyDDMHXomoHkSvrQAAadFpetZg
 1tWLgTUXDDCMjLfr1gqr5U
X-Received: by 2002:a05:7300:ea06:b0:30b:7bc2:c70b with SMTP id
 5a478bee46e88-30bcf0900aemr894783eec.9.1781690833225; 
 Wed, 17 Jun 2026 03:07:13 -0700 (PDT)
Received: from kotori-desktop ([2408:820c:8ffd:b5b0:12ba:d5b5:2236:f1f1])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081e5d3f20sm21858490eec.9.2026.06.17.03.07.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 03:07:12 -0700 (PDT)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>, K S Maan <kirandeepmaan45@gmail.com>
Subject: [PATCH v3 6/7] vfio/pci: Use pci_rom_patch_ids() for IGD ROM ID
 patching
Date: Wed, 17 Jun 2026 18:06:43 +0800
Message-ID: <20260617100646.28326-7-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260617100646.28326-1-tomitamoeko@gmail.com>
References: <20260617100646.28326-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1341;
 envelope-from=tomitamoeko@gmail.com; helo=mail-dy1-x1341.google.com
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


