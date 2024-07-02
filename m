Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DEE1C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:27:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOeEN-0006ki-4C; Tue, 02 Jul 2024 10:11:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeE9-0005Tl-Sn
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:11:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeE7-0000Tz-Vh
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:11:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719929482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PtAXW6LVwA3P89VkFVi94GjAlNMJ1XHCqV5FMloDGgI=;
 b=HSIHvboQuSHCe9BOuzye0Z1dXutLFTvTL3HuTRLHhQG54W6Qd0u5Kl36trUa4kApkZ/urV
 /E+bIN+85kHnTHXpecyFbYQ4DnyGMmbREm4aBh0At4Oq+3e4a60C9KlzhNxmihdL2XnYNO
 kskCRz6qiV8CEGV/KW3zl2IrG2hFB4g=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-VMy5Z14dMxuADzGGNAT3ig-1; Tue, 02 Jul 2024 10:11:18 -0400
X-MC-Unique: VMy5Z14dMxuADzGGNAT3ig-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-367879e8395so428490f8f.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 07:11:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719929477; x=1720534277;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PtAXW6LVwA3P89VkFVi94GjAlNMJ1XHCqV5FMloDGgI=;
 b=NHEAseyU8YMGP8QgDIIWSrmDZ1nU1w0OTM7gjYH3VG+s9OApxTwgnQ6xJx2m5sFaLL
 EpZdN+Vh4UCsVBzb1Qgxd9eUJMFDK/1TN5eDkL8ls9k6fQXfMz/Jxg0qnOKIkQKc7uRW
 OXPiX3KZzN3lGoMIUgYYK2+mogE4Zaj1neHP31AQN+K/2TYPCLrM1ReLd1oUNmlb8jQ2
 0FQJkPBJdzHMrlKfw2pRJ7zCxbauhW04BjRIXX0G1Lhjs1zXQeaXZtPfZffPko0qC9G7
 MAbHrYW3EO+96utoBQrutv4wXBDbTVlA2vT5LqbHbOh1dgr0zHN/S69rG0ZZYHlaBZ0I
 X5zg==
X-Gm-Message-State: AOJu0YxqpAiRyI0xQksQwbEMb5eEmHdYF5zXq56XfDeM65zZQMGzlFG5
 Irye6lyckNyky4ZcMYDkZnkfRZ+qDqRyMA4cjneueK2dOuWfbY4znG0/OLfVw/zdNRDfHAUBWhX
 dwx6bI/ljLS/QVhTwjZLFvkWE7y2JXD5199fF7pCDqXjH2WXh4fZqEqN8ylMEpI8NDtXg6AX1xu
 b1cALPUaqf8LcYwywHGXcazQQKzxHeow==
X-Received: by 2002:a5d:6e65:0:b0:366:f41f:8cc7 with SMTP id
 ffacd0b85a97d-367757249e9mr6984223f8f.46.1719929475675; 
 Tue, 02 Jul 2024 07:11:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtbvwUarQo8T83+h7CkvuHaP0Rh47QhEy/C0CW/HAD5LHdyGe4lNp58kWe28JSQo8Q9fZNKw==
X-Received: by 2002:a5d:6e65:0:b0:366:f41f:8cc7 with SMTP id
 ffacd0b85a97d-367757249e9mr6984194f8f.46.1719929474973; 
 Tue, 02 Jul 2024 07:11:14 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a10305fsm13265723f8f.96.2024.07.02.07.11.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 07:11:14 -0700 (PDT)
Date: Tue, 2 Jul 2024 10:11:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 82/91] hw/pci: Rename has_power to enabled
Message-ID: <1aabc8bbf3bf63c1a37af9771a0d4c80cb170ea4.1719929191.git.mst@redhat.com>
References: <cover.1719929191.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719929191.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

The renamed state will not only represent powering state of PFs, but
also represent SR-IOV VF enablement in the future.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20240627-reuse-v10-1-7ca0b8ed3d9f@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/pci/pci.h        |  7 ++++++-
 include/hw/pci/pci_device.h |  2 +-
 hw/pci/pci.c                | 14 +++++++-------
 hw/pci/pci_host.c           |  4 ++--
 4 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index eb26cac810..fe04b4fafd 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -678,6 +678,11 @@ static inline void pci_irq_pulse(PCIDevice *pci_dev)
 }
 
 MSIMessage pci_get_msi_message(PCIDevice *dev, int vector);
-void pci_set_power(PCIDevice *pci_dev, bool state);
+void pci_set_enabled(PCIDevice *pci_dev, bool state);
+
+static inline void pci_set_power(PCIDevice *pci_dev, bool state)
+{
+    pci_set_enabled(pci_dev, state);
+}
 
 #endif
diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
index d3dd0f64b2..d57f9ce838 100644
--- a/include/hw/pci/pci_device.h
+++ b/include/hw/pci/pci_device.h
@@ -56,7 +56,7 @@ typedef struct PCIReqIDCache PCIReqIDCache;
 struct PCIDevice {
     DeviceState qdev;
     bool partially_hotplugged;
-    bool has_power;
+    bool enabled;
 
     /* PCI config space */
     uint8_t *config;
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 50b86d5790..68d30feb86 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1525,7 +1525,7 @@ static void pci_update_mappings(PCIDevice *d)
             continue;
 
         new_addr = pci_bar_address(d, i, r->type, r->size);
-        if (!d->has_power) {
+        if (!d->enabled) {
             new_addr = PCI_BAR_UNMAPPED;
         }
 
@@ -1613,7 +1613,7 @@ void pci_default_write_config(PCIDevice *d, uint32_t addr, uint32_t val_in, int
         pci_update_irq_disabled(d, was_irq_disabled);
         memory_region_set_enabled(&d->bus_master_enable_region,
                                   (pci_get_word(d->config + PCI_COMMAND)
-                                   & PCI_COMMAND_MASTER) && d->has_power);
+                                   & PCI_COMMAND_MASTER) && d->enabled);
     }
 
     msi_write_config(d, addr, val_in, l);
@@ -2884,18 +2884,18 @@ MSIMessage pci_get_msi_message(PCIDevice *dev, int vector)
     return msg;
 }
 
-void pci_set_power(PCIDevice *d, bool state)
+void pci_set_enabled(PCIDevice *d, bool state)
 {
-    if (d->has_power == state) {
+    if (d->enabled == state) {
         return;
     }
 
-    d->has_power = state;
+    d->enabled = state;
     pci_update_mappings(d);
     memory_region_set_enabled(&d->bus_master_enable_region,
                               (pci_get_word(d->config + PCI_COMMAND)
-                               & PCI_COMMAND_MASTER) && d->has_power);
-    if (!d->has_power) {
+                               & PCI_COMMAND_MASTER) && d->enabled);
+    if (!d->enabled) {
         pci_device_reset(d);
     }
 }
diff --git a/hw/pci/pci_host.c b/hw/pci/pci_host.c
index dfe6fe6184..0d82727cc9 100644
--- a/hw/pci/pci_host.c
+++ b/hw/pci/pci_host.c
@@ -86,7 +86,7 @@ void pci_host_config_write_common(PCIDevice *pci_dev, uint32_t addr,
      * allowing direct removal of unexposed functions.
      */
     if ((pci_dev->qdev.hotplugged && !pci_get_function_0(pci_dev)) ||
-        !pci_dev->has_power || is_pci_dev_ejected(pci_dev)) {
+        !pci_dev->enabled || is_pci_dev_ejected(pci_dev)) {
         return;
     }
 
@@ -111,7 +111,7 @@ uint32_t pci_host_config_read_common(PCIDevice *pci_dev, uint32_t addr,
      * allowing direct removal of unexposed functions.
      */
     if ((pci_dev->qdev.hotplugged && !pci_get_function_0(pci_dev)) ||
-        !pci_dev->has_power || is_pci_dev_ejected(pci_dev)) {
+        !pci_dev->enabled || is_pci_dev_ejected(pci_dev)) {
         return ~0x0;
     }
 
-- 
MST


