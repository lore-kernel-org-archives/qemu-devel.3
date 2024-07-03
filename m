Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 741EFC31D97
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 22:51:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP8ns-0003Hc-Ho; Wed, 03 Jul 2024 18:50:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8nr-0003DN-BH
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:50:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8nn-0007Qu-Lg
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:50:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720047012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PtAXW6LVwA3P89VkFVi94GjAlNMJ1XHCqV5FMloDGgI=;
 b=AMolVbH2kguEj4tA7choLGdmHig5QFYcQ5nGT6Duk7sixWILIY0lrCb11yDLSDZLfaNl7z
 CQeUa893mAV6p3SBcAi77/ztXvZBW4wanho8e2cbXufLf2jGZOyQ1WxWci9x+6EBIOee7N
 /lCBwSmNgMl2ZBv4S0MZUyCPX7P8Y78=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-fRc4uKRTMxChNLYPGNeHqg-1; Wed, 03 Jul 2024 18:50:11 -0400
X-MC-Unique: fRc4uKRTMxChNLYPGNeHqg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-425897358f0so5405e9.2
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 15:50:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720047009; x=1720651809;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PtAXW6LVwA3P89VkFVi94GjAlNMJ1XHCqV5FMloDGgI=;
 b=tiR9QcPY62S0RXRjFNk2RajLyaQv7SrESZcgYM/LonWM8V5FWO1SKwGqh7yhrn/pxc
 BGQnY8Xrixgztpeske7+U1vXzfftCAsNwy4HLpvvb+p3W+Y4/fLGO0Cc9DGinh4Sjrpt
 eDX24xt4syYIOhWVd+kb6mQbPK5/yGDZan7uLsbSuiHPAOpaL2lQPS33pH0Mty+ej8Ib
 AIjVkvgQ1NVcY3HDrdVBW0MEbGFRESEE6Ls8oxgqCS184Nl4sbB+pM+bXVN2CvDPhZ3D
 2o9TnfjioSpAxgYX8uID92Eds3AYK5Sqsplwmuvd+7oxROSvi0JLy/yhe30L6dtZfmYd
 xkNg==
X-Gm-Message-State: AOJu0YyIIr3SZfsc26my+qqkJJtxqr0rqGkMj9uI1HpRBV0kAMWoPjlD
 0CluhZxBTrgx0R4uegHD6O2RaxXTlxoBq+1sJsndTpbK+5+sBwkFlLBz0EiLOHH47udC9DgJr1h
 xTCdQL//YmtazgwOFo/5EWZv5m0D7EtrIAf+3BCV4VBt1HdXWmRUYerGCVwC6TYTqpuqRFloVrP
 r0r84+qlZZNokOn4b76PEbooarTnzuTA==
X-Received: by 2002:a05:600c:4b17:b0:424:a578:fc7 with SMTP id
 5b1f17b1804b1-4264a3cc9f5mr415515e9.3.1720047009045; 
 Wed, 03 Jul 2024 15:50:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpa77sy9qcpEziIeS7eh+YqAW5vVfTokYAPRI+PfSjMPs8mQy0gyLw0cLiwbfI2y2KQ/aGaA==
X-Received: by 2002:a05:600c:4b17:b0:424:a578:fc7 with SMTP id
 5b1f17b1804b1-4264a3cc9f5mr415265e9.3.1720047008069; 
 Wed, 03 Jul 2024 15:50:08 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:91a8:a47d:5a9:c02f:92f2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264a1dd902sm1233625e9.12.2024.07.03.15.50.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 15:50:07 -0700 (PDT)
Date: Wed, 3 Jul 2024 18:50:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL v3 76/85] hw/pci: Rename has_power to enabled
Message-ID: <6a31b219a5338564f3978251c79f96f689e037da.1720046570.git.mst@redhat.com>
References: <cover.1720046570.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1720046570.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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


