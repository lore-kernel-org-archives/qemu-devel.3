Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8F95C35FF3
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 06:16:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsyL2-0004vI-FP; Fri, 14 Mar 2025 02:16:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tsyKd-0004Yd-7w
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 02:15:54 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tsyKX-0005PV-LW
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 02:15:40 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-224100e9a5cso36669075ad.2
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 23:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741932936; x=1742537736;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kCa4397D91ooXWYS7EzfW5bkyX38spZtocr+6eEyKUQ=;
 b=fuMT8CurCZTYDbi+y366WZq/GCUutixTO6Ht9OiStsiKsgiQycJqQznRqJwJ8/vFHC
 MWDpnBtgbq/pqPyirysI7z6EnsJPd0UpFva4WaXzlN0HzZ3q6gud/OY2NOvxMCjGjZ57
 CCySHvWBJnAg+5UQjmK9RdhDdeNnF66cV5qJqHdwwjask2nm9fuc5uqjGDxShWYuLy0p
 WOkySZxHPksMQ3cTAcw2JfXpTYiWdjMG0msxaMshewWQVYM0QvRzcIDGk7iZXnKXa6yr
 opsaahiSyN2QW2ozkAEilWcqLUY13B8rNMOPDNvhXECKxSINjg5fgv25g2ry/CT+ceBz
 XJIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741932936; x=1742537736;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kCa4397D91ooXWYS7EzfW5bkyX38spZtocr+6eEyKUQ=;
 b=INiAKGHiEdejnzrh9+0oD/itgeeQFskbOVx1sLNnPKtGbtj8RapIYArhliaebaMlMq
 711VwLLVuSqYlrAZb8VUvQ8vcSQaIx0CrAiK1PQ3Y56vI+JmV423HWd6nkyHQxX+mUzT
 +UiGJCJ6P9efPq/+LuW4aJdFbquVgj10PvxKGtq8hH1SkRuuMNCmvbmKGxzYYMwTkGCe
 uBngyFkZG2PlzavjeuN9hQxTvYigO1JdmRJCvQPgb0og52WA+lj9zFyII+0NQELaLPQo
 +56UOSqFZVAFFQEgY7HEHAU0ynonoBAOvqhmS56VPz0invpsrfnVe4aykechkGkE/WAq
 2GYA==
X-Gm-Message-State: AOJu0YxmyM8PqOxeih3X+iy80Md63Qx5ZdG3/Fyu8jGFUP4C0R3phUIS
 V2cEsCRlTsHzgj7FhXUKPlKUzkHV7wLhKkNyFQqM4H0UocL5NGYW50jOiPV6vcE=
X-Gm-Gg: ASbGncvEwQaImIgCi+qXKEC/8NVH+F5FVpg91aQIsQi/XDFo7wCjllXtMGO01K8Dxrx
 WmANayRz+8yaggVTPfbdWwTAsoafzS+NaZR9IRp0up39FrweRpdK73laT3fEgED0oSc3jNexZ2n
 kdL6SoeDwRh5ME6//UR8CCGOWvr6RfTJF0ZCcQ5xcnxfJY4cdHhPLp6YocqXKu6dw3Tt7grHplu
 Br9OTYs/eKCnuWicgoUKb+FZx55ZGSZ1rZxR0972F4RGUze8kLg6YCD4w1eUMTIIxhoce/p09xA
 rmRqNdnnKiesSmZ4i60bC+96/FR51GWJU2dGsy7eG4Wimdq+
X-Google-Smtp-Source: AGHT+IFtghY7dbxgnsmREGjRdQmqMgcyRtaRbwWoCXlSKYcY/7IgnO+H3j95lacEHZc/Zvhm77QttQ==
X-Received: by 2002:a17:903:13c6:b0:220:df73:b639 with SMTP id
 d9443c01a7336-225e0af5c1fmr20410405ad.36.1741932936138; 
 Thu, 13 Mar 2025 23:15:36 -0700 (PDT)
Received: from localhost ([157.82.205.237])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-225c6bd4dabsm23176465ad.233.2025.03.13.23.15.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 23:15:35 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 14 Mar 2025 15:14:55 +0900
Subject: [PATCH for-10.1 v9 6/9] virtio-pci: Implement SR-IOV PF
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-sriov-v9-6-57dae8ae3ab5@daynix.com>
References: <20250314-sriov-v9-0-57dae8ae3ab5@daynix.com>
In-Reply-To: <20250314-sriov-v9-0-57dae8ae3ab5@daynix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, devel@daynix.com, 
 Yui Washizu <yui.washidu@gmail.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Allow user to attach SR-IOV VF to a virtio-pci PF.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/hw/virtio/virtio-pci.h |  1 +
 hw/virtio/virtio-pci.c         | 20 +++++++++++++++-----
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-pci.h
index 971c5fabd444..b473274834e9 100644
--- a/include/hw/virtio/virtio-pci.h
+++ b/include/hw/virtio/virtio-pci.h
@@ -155,6 +155,7 @@ struct VirtIOPCIProxy {
     uint32_t modern_io_bar_idx;
     uint32_t modern_mem_bar_idx;
     int config_cap;
+    uint16_t last_pcie_cap_offset;
     uint32_t flags;
     bool disable_modern;
     bool ignore_backend_features;
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 3ca3f849d391..2463bff2ea5b 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1962,6 +1962,7 @@ static void virtio_pci_device_plugged(DeviceState *d, Error **errp)
     uint8_t *config;
     uint32_t size;
     VirtIODevice *vdev = virtio_bus_get_device(bus);
+    int16_t res;
 
     /*
      * Virtio capabilities present without
@@ -2109,6 +2110,14 @@ static void virtio_pci_device_plugged(DeviceState *d, Error **errp)
         pci_register_bar(&proxy->pci_dev, proxy->legacy_io_bar_idx,
                          PCI_BASE_ADDRESS_SPACE_IO, &proxy->bar);
     }
+
+    res = pcie_sriov_pf_init_from_user_created_vfs(&proxy->pci_dev,
+                                                   proxy->last_pcie_cap_offset,
+                                                   errp);
+    if (res > 0) {
+        proxy->last_pcie_cap_offset += res;
+        virtio_add_feature(&vdev->host_features, VIRTIO_F_SR_IOV);
+    }
 }
 
 static void virtio_pci_device_unplugged(DeviceState *d)
@@ -2199,7 +2208,7 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
 
     if (pcie_port && pci_is_express(pci_dev)) {
         int pos;
-        uint16_t last_pcie_cap_offset = PCI_CONFIG_SPACE_SIZE;
+        proxy->last_pcie_cap_offset = PCI_CONFIG_SPACE_SIZE;
 
         pos = pcie_endpoint_cap_init(pci_dev, 0);
         assert(pos > 0);
@@ -2216,9 +2225,9 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
         pci_set_word(pci_dev->config + pos + PCI_PM_PMC, 0x3);
 
         if (proxy->flags & VIRTIO_PCI_FLAG_AER) {
-            pcie_aer_init(pci_dev, PCI_ERR_VER, last_pcie_cap_offset,
+            pcie_aer_init(pci_dev, PCI_ERR_VER, proxy->last_pcie_cap_offset,
                           PCI_ERR_SIZEOF, NULL);
-            last_pcie_cap_offset += PCI_ERR_SIZEOF;
+            proxy->last_pcie_cap_offset += PCI_ERR_SIZEOF;
         }
 
         if (proxy->flags & VIRTIO_PCI_FLAG_INIT_DEVERR) {
@@ -2243,9 +2252,9 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
         }
 
         if (proxy->flags & VIRTIO_PCI_FLAG_ATS) {
-            pcie_ats_init(pci_dev, last_pcie_cap_offset,
+            pcie_ats_init(pci_dev, proxy->last_pcie_cap_offset,
                           proxy->flags & VIRTIO_PCI_FLAG_ATS_PAGE_ALIGNED);
-            last_pcie_cap_offset += PCI_EXT_CAP_ATS_SIZEOF;
+            proxy->last_pcie_cap_offset += PCI_EXT_CAP_ATS_SIZEOF;
         }
 
         if (proxy->flags & VIRTIO_PCI_FLAG_INIT_FLR) {
@@ -2273,6 +2282,7 @@ static void virtio_pci_exit(PCIDevice *pci_dev)
                      !pci_bus_is_root(pci_get_bus(pci_dev));
     bool modern_pio = proxy->flags & VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY;
 
+    pcie_sriov_pf_exit(&proxy->pci_dev);
     msix_uninit_exclusive_bar(pci_dev);
     if (proxy->flags & VIRTIO_PCI_FLAG_AER && pcie_port &&
         pci_is_express(pci_dev)) {

-- 
2.48.1


