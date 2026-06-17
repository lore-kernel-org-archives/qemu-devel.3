Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89487CD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 10:07:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZnAp-0003pr-O5; Wed, 17 Jun 2026 06:07:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1wZnAk-0003p0-WB
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 06:07:03 -0400
Received: from mail-dy1-x1342.google.com ([2607:f8b0:4864:20::1342])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1wZnAi-0008On-9V
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 06:07:01 -0400
Received: by mail-dy1-x1342.google.com with SMTP id
 5a478bee46e88-30bb7d20ad9so2297921eec.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 03:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781690819; x=1782295619; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g805oiewD32KvK8soPofSnFfwWVGGy5xaH5rPwxt+n0=;
 b=bNn9SKj7DMwDxePGPm6fbX8d9BJrgLq53PfkGsdr8HNSIQl0BVEL/kM3rE6eRi5dH1
 8h3NlD/RD9/CyUglg+RVppirJe+gUvsF04iOXWZ8GKh3Y5RUHYeN5WTJOo8AYtbf11cE
 aUnjB9fUB85WRehMH8kqkFUQdqEBoFgjCLBCzP8drIOJm/DL7c19/7WWeFG6utwRWQaI
 bbsncRNOQZbMbswgN2/GD0Lu8Smyim9W7V+OttsWz8Hxot9GsK4jeJLfmDrLbXNNUkyC
 GA8FTGf9DDcfemUO7F1YVmXxeCriiOw8yaRtRn3TNe2zPLhdUetvX+qjQDWsNFYsweOP
 QCFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781690819; x=1782295619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=g805oiewD32KvK8soPofSnFfwWVGGy5xaH5rPwxt+n0=;
 b=tOLWzV09i2QBj/I/1Wuog/57GgWEZZQN4K5GS1LuGwAMLvUgDhx3EbwOWzNHMEap9K
 XYz5C9Aqj3h15JkvfmA6F49QXWcgmVtcnu+0GakGkasm48LnqKBTNLn0O5dqFknZTOIX
 dbaTZxcpe7+OYI8vI10UVdCFfFK5v/gDcFO95OXFevkqVqEuWwRS1Cjh5p6I9DBor89D
 rOPLfElYo3kZoXpoiggfW06nYJZkhmxvWNnVqzmQcF3oaBMVhwp0igHE0ma9HUzA0Xho
 PsRf0YN78EFv5phHxzuHOg9+oioKXTdTlRAh8+UMSQfKHNFU5Urd5lbJb+jHyjkK4Nuq
 7CmA==
X-Gm-Message-State: AOJu0Yy+w5xNXtBShU+GSilYYVg1YhjSLnMkZnuW0EcqyFjHebEn9Rfy
 YF1DRu3onQ9u+RUN9A6HBBOpeu8K2kD9wFuOzKb/lUzaOr028fbi3CVzbY73vOD0Aw==
X-Gm-Gg: AfdE7ckbPne3uJjMwUodMfrwnAwLkXjAt4CCsesFDeViTtUdQ8y+6Z3dTHo92ln3nAF
 4wiXVI8eOo4jhaQ7if1InEu+FscDKJIiPcGRTV5p+7iI+Bqadn1n5HCEwqjn8Zt1E5WtO778qjQ
 78wdKAFIa9ywOkgd5xApTCXQCekrcG4hxSc6dQiXzQpO8z+IA78191M8PKVIBlFYozngi5A9C95
 CaFVsMoDMnQIdUlgOczaq3i7nvz4jjif5L1qFYeI4/Ob54rvBPaNK6flCzyPCoj5tE/+1Rwr5Io
 iuAuTBm24dGddApRW8DRvQGePTYltOclTY1FZXW4vMb1+YPxYKMLtfBPyGqNp/zSDenGB3yu7/G
 rw/FS01gWjW4uGxx2O25l/8hVTgwUcymgL9x4ElGeCJhRFVF56RwZDamCfSIHdad4eXwtzBgsRm
 pCJ5JRjUhb/Dt3oe+hXNYC
X-Received: by 2002:a05:7300:6902:b0:2f3:5266:fdfc with SMTP id
 5a478bee46e88-30bca0aa2dcmr1790607eec.33.1781690818619; 
 Wed, 17 Jun 2026 03:06:58 -0700 (PDT)
Received: from kotori-desktop ([2408:820c:8ffd:b5b0:12ba:d5b5:2236:f1f1])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081e5d3f20sm21858490eec.9.2026.06.17.03.06.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 03:06:58 -0700 (PDT)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>, K S Maan <kirandeepmaan45@gmail.com>
Subject: [PATCH v3 1/7] hw/pci: Recalculate option ROM checksum before
 patching ID
Date: Wed, 17 Jun 2026 18:06:38 +0800
Message-ID: <20260617100646.28326-2-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260617100646.28326-1-tomitamoeko@gmail.com>
References: <20260617100646.28326-1-tomitamoeko@gmail.com>
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

pci_patch_ids() only adjusts checksum based on the new IDs. For an
option ROM with invalid checksum, the patched one will still have
an invalid checksum. Always calculate the checksum and patch it if
necessary to ensure the option ROM is valid.

This is intended for fixing the romfile used in IGD passthrough as
multiple IGD devices share the same rom with possible non-matching
device ID, and its checksum is known to be bogus [1].

A helper function pci_rom_calculate_checksum() is added and exported
for reusing in IGD-specific quirk later.

[1] hw/vfio/pci.c:1090

Reported-by: K S Maan <kirandeepmaan45@gmail.com>
Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/pci/pci.c         | 32 +++++++++++++++++++++++---------
 include/hw/pci/pci.h |  2 ++
 2 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index cec065d108..601d65aef3 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2479,6 +2479,18 @@ static uint8_t pci_find_capability_at_offset(PCIDevice *pdev, uint8_t offset)
     return found;
 }
 
+uint8_t pci_rom_calculate_checksum(const uint8_t *ptr, uint32_t size)
+{
+    uint8_t checksum = 0;
+    uint32_t i;
+
+    for (i = 0; i < size; i++) {
+        checksum += ptr[i];
+    }
+
+    return checksum;
+}
+
 /* Patch the PCI vendor and device ids in a PCI rom image if necessary.
    This is needed for an option rom which is used for more than one device. */
 static void pci_patch_ids(PCIDevice *pdev, uint8_t *ptr, uint32_t size)
@@ -2514,25 +2526,27 @@ static void pci_patch_ids(PCIDevice *pdev, uint8_t *ptr, uint32_t size)
     trace_pci_rom_and_pci_ids(pdev->romfile, vendor_id, device_id,
                               rom_vendor_id, rom_device_id);
 
-    checksum = ptr[6];
+    /* In case the checksum is bogus */
+    checksum = pci_rom_calculate_checksum(ptr, size);
 
     if (vendor_id != rom_vendor_id) {
         /* Patch vendor id and checksum (at offset 6 for etherboot roms). */
-        checksum += (uint8_t)rom_vendor_id + (uint8_t)(rom_vendor_id >> 8);
-        checksum -= (uint8_t)vendor_id + (uint8_t)(vendor_id >> 8);
-        trace_pci_rom_checksum_change(ptr[6], checksum);
-        ptr[6] = checksum;
+        checksum += (uint8_t)vendor_id + (uint8_t)(vendor_id >> 8);
+        checksum -= (uint8_t)rom_vendor_id + (uint8_t)(rom_vendor_id >> 8);
         pci_set_word(ptr + pcir_offset + 4, vendor_id);
     }
 
     if (device_id != rom_device_id) {
         /* Patch device id and checksum (at offset 6 for etherboot roms). */
-        checksum += (uint8_t)rom_device_id + (uint8_t)(rom_device_id >> 8);
-        checksum -= (uint8_t)device_id + (uint8_t)(device_id >> 8);
-        trace_pci_rom_checksum_change(ptr[6], checksum);
-        ptr[6] = checksum;
+        checksum += (uint8_t)device_id + (uint8_t)(device_id >> 8);
+        checksum -= (uint8_t)rom_device_id + (uint8_t)(rom_device_id >> 8);
         pci_set_word(ptr + pcir_offset + 6, device_id);
     }
+
+    if (checksum) {
+        trace_pci_rom_checksum_change(ptr[6], ptr[6] - checksum);
+        ptr[6] -= checksum;
+    }
 }
 
 /* Add an option rom for the device */
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 5b179091de..2d8a4ad0eb 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -1103,4 +1103,6 @@ void pci_set_enabled(PCIDevice *pci_dev, bool state);
 void pci_set_power(PCIDevice *pci_dev, bool state);
 int pci_pm_init(PCIDevice *pci_dev, uint8_t offset, Error **errp);
 
+uint8_t pci_rom_calculate_checksum(const uint8_t *ptr, uint32_t size);
+
 #endif
-- 
2.53.0


