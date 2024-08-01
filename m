Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 353B3C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 10:38:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZTBP-00024O-9f; Thu, 01 Aug 2024 06:37:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZTBN-0001n7-QL
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 06:37:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZTBM-0001pS-0G
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 06:37:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722508635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oq1o9SvpX+0hrvIlhCMEJnYTzkg9hgopt6NINCt9TXs=;
 b=UwJSKwtADfAHSNjNj+LbXe9wBfTYymAcBTjkRYZvrSE6dc55H6U2ZqdQZZhoAcKVCQwVB3
 2o2roAsnDPHaIHmKVa0KDuZob+3aiCqcKmXYxLnj8ndWItFAocrWgkQsqbamMFwDkp6Vbg
 F4mh3S4PPHI13xufzWE0SD2Or9cTdXg=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-EXenFmNCNnaI4tE3D15uDA-1; Thu, 01 Aug 2024 06:37:14 -0400
X-MC-Unique: EXenFmNCNnaI4tE3D15uDA-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5a429a572daso5611354a12.1
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 03:37:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722508632; x=1723113432;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oq1o9SvpX+0hrvIlhCMEJnYTzkg9hgopt6NINCt9TXs=;
 b=U3u+Izy5u90iP7/zpJ/b8mkEbAOgvIrlNeyAaU1/fQVcw0vqFgVtqfqjctO0YsfdEt
 x7Mk5nqDYNTVW9UOsmRPjwgizFucBFO0tECogoxpR8dKH2Gm0A8Ry1q1Zmgls0+pwRoS
 jlrIXoVxRvKFav8qB2vyRidtJ6vQ1i8/nRksA4fZxT8e7uQDI7lqEKM2iN/P3f/FADpo
 Yq3PM+mFMMmXEjPfc6+vB3tQOG7N1odNq3v1NvEIXf7DNmsAHOH5fKHYTUPJYCt1B1Au
 3b965cZepxjacG0mdf/8aL6y/r55ep9PuOJq2AOXeqNE9Ex6v1E9IgEDvjqAMJAs2kpm
 khhw==
X-Gm-Message-State: AOJu0Yy4ZPvcJAuwgnlfV9APDkgOSSzTT8Ss7U438SjeVRm+bXzHpgwr
 r9q7CVP+AFvVET+ikmrgtnRPcA2b0ve1dZnozs11HmFeRHRvNOCOFRF1uGFzR1CdV/4HrJdJdYt
 a/3TTyWiZgU0opI/vJOns9NpMJoQ+7k44KmaOpKdtnffWMN2/KYICufQ7rlOV5sOeBfvv6NioPK
 avtBVnc0v2S+uwvubqbfO3eSRH6OiQfQ==
X-Received: by 2002:a17:907:d93:b0:a77:e1fb:7dec with SMTP id
 a640c23a62f3a-a7daf4c373bmr143244266b.17.1722508632300; 
 Thu, 01 Aug 2024 03:37:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHid+7aVanMVJcJKYW83ebd5losGd1kZ1LNm+BUBdm1h6AzczAuS6u+FMLvZ+R+hbBePm9yRQ==
X-Received: by 2002:a17:907:d93:b0:a77:e1fb:7dec with SMTP id
 a640c23a62f3a-a7daf4c373bmr143241166b.17.1722508631535; 
 Thu, 01 Aug 2024 03:37:11 -0700 (PDT)
Received: from redhat.com ([2.55.44.248]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acad90251sm897244466b.143.2024.08.01.03.37.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 03:37:09 -0700 (PDT)
Date: Thu, 1 Aug 2024 06:37:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 17/19] Revert "hw/pci: Rename has_power to enabled"
Message-ID: <93829009a685687e2fb48158cb5df18c4eb49d07.1722508478.git.mst@redhat.com>
References: <cover.1722508478.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1722508478.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This reverts commit 6a31b219a5338564f3978251c79f96f689e037da.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/pci/pci.h        |  7 +------
 include/hw/pci/pci_device.h |  2 +-
 hw/pci/pci.c                | 14 +++++++-------
 hw/pci/pci_host.c           |  4 ++--
 4 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index fe04b4fafd..eb26cac810 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -678,11 +678,6 @@ static inline void pci_irq_pulse(PCIDevice *pci_dev)
 }
 
 MSIMessage pci_get_msi_message(PCIDevice *dev, int vector);
-void pci_set_enabled(PCIDevice *pci_dev, bool state);
-
-static inline void pci_set_power(PCIDevice *pci_dev, bool state)
-{
-    pci_set_enabled(pci_dev, state);
-}
+void pci_set_power(PCIDevice *pci_dev, bool state);
 
 #endif
diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
index f38fb31119..15694f2489 100644
--- a/include/hw/pci/pci_device.h
+++ b/include/hw/pci/pci_device.h
@@ -57,7 +57,7 @@ typedef struct PCIReqIDCache PCIReqIDCache;
 struct PCIDevice {
     DeviceState qdev;
     bool partially_hotplugged;
-    bool enabled;
+    bool has_power;
 
     /* PCI config space */
     uint8_t *config;
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index b532888e8f..fab86d0567 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1525,7 +1525,7 @@ static void pci_update_mappings(PCIDevice *d)
             continue;
 
         new_addr = pci_bar_address(d, i, r->type, r->size);
-        if (!d->enabled) {
+        if (!d->has_power) {
             new_addr = PCI_BAR_UNMAPPED;
         }
 
@@ -1613,7 +1613,7 @@ void pci_default_write_config(PCIDevice *d, uint32_t addr, uint32_t val_in, int
         pci_update_irq_disabled(d, was_irq_disabled);
         memory_region_set_enabled(&d->bus_master_enable_region,
                                   (pci_get_word(d->config + PCI_COMMAND)
-                                   & PCI_COMMAND_MASTER) && d->enabled);
+                                   & PCI_COMMAND_MASTER) && d->has_power);
     }
 
     msi_write_config(d, addr, val_in, l);
@@ -2884,18 +2884,18 @@ MSIMessage pci_get_msi_message(PCIDevice *dev, int vector)
     return msg;
 }
 
-void pci_set_enabled(PCIDevice *d, bool state)
+void pci_set_power(PCIDevice *d, bool state)
 {
-    if (d->enabled == state) {
+    if (d->has_power == state) {
         return;
     }
 
-    d->enabled = state;
+    d->has_power = state;
     pci_update_mappings(d);
     memory_region_set_enabled(&d->bus_master_enable_region,
                               (pci_get_word(d->config + PCI_COMMAND)
-                               & PCI_COMMAND_MASTER) && d->enabled);
-    if (!d->enabled) {
+                               & PCI_COMMAND_MASTER) && d->has_power);
+    if (!d->has_power) {
         pci_device_reset(d);
     }
 }
diff --git a/hw/pci/pci_host.c b/hw/pci/pci_host.c
index 0d82727cc9..dfe6fe6184 100644
--- a/hw/pci/pci_host.c
+++ b/hw/pci/pci_host.c
@@ -86,7 +86,7 @@ void pci_host_config_write_common(PCIDevice *pci_dev, uint32_t addr,
      * allowing direct removal of unexposed functions.
      */
     if ((pci_dev->qdev.hotplugged && !pci_get_function_0(pci_dev)) ||
-        !pci_dev->enabled || is_pci_dev_ejected(pci_dev)) {
+        !pci_dev->has_power || is_pci_dev_ejected(pci_dev)) {
         return;
     }
 
@@ -111,7 +111,7 @@ uint32_t pci_host_config_read_common(PCIDevice *pci_dev, uint32_t addr,
      * allowing direct removal of unexposed functions.
      */
     if ((pci_dev->qdev.hotplugged && !pci_get_function_0(pci_dev)) ||
-        !pci_dev->enabled || is_pci_dev_ejected(pci_dev)) {
+        !pci_dev->has_power || is_pci_dev_ejected(pci_dev)) {
         return ~0x0;
     }
 
-- 
MST


