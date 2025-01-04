Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40B4BE77188
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jan 2025 08:03:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTz7N-0004fk-1W; Sat, 04 Jan 2025 03:02:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tTz6W-0003gn-8G
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 03:01:53 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tTz6U-0006hf-Jf
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 03:01:51 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2164b1f05caso178250265ad.3
 for <qemu-devel@nongnu.org>; Sat, 04 Jan 2025 00:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1735977709; x=1736582509;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ssDQc8psUCNDRLn18K6TEiijD4IORPJi7OPvf7+BFzQ=;
 b=FSoXsES2QDl1BpdQPc70+LzQ+9nt96zmcxlXY0cLrVtjHy+GhgsBWMvPQJi2ARRjM9
 JmI41nZJUUbSKT+oMS1wEJ65/2lN7E5bR4E2rOOanpc0fJSUbCv0/tIDGi+qKGZfs0o6
 Fs5UOzKG+IH2HKfwEqn6x79dD8+iEQvu8zA9Z+ub6PgMKYH57rqR7dISLIXdQKVFZjdb
 9MUxsxhbwiCNOuBIri1AEViGgCm2KzGGOlos3kj5WWK+ZhdfZJmQU9hoeIy9bHPxNXwQ
 jyEErAokaQvEUcVQq8/erW6n5deCEqyI7X6wr02Wvp9AJbJ2T/y281ZTw1zf1boPFk9+
 v+zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735977709; x=1736582509;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ssDQc8psUCNDRLn18K6TEiijD4IORPJi7OPvf7+BFzQ=;
 b=ihUFoDXLE3YKpqP30LsHXgU4eZHMEnq4qNi/2VK7W3Y8xLYoTunMMFGSG6jWlEc9Ow
 2+htpO/UUACjnMcAGf8xwg2EKgs6EhsLKHQbQNNZeLv8b1S2MMsa0haOVwFXrcVAwa8n
 gfHD4Ea9PM4ANufC6tIWrcRm2KqIsyby3k/UIXSzRTuBCvTMrme/S+sL3L4lt7FHpsIk
 j8bh6AffVx+iRLgFQsWMcPJya4qkh9SM4OUDXNfY05TnMjXxqG4BoVykDyIA3Sy07VJW
 exhCWLLgunbfHqkE+H4o+rVhLbYF1hRG8KVBeP3uvidIsQtSFMdbw9EgNYmfO05QxmM3
 BAWw==
X-Gm-Message-State: AOJu0Yx88zGGF7198sxfuQKfFUuKO5YpJLCOh9ElrwwW/1kqp2mFEtaY
 buqUUzmAjFJS0qE6UrpfPUKr/i19ucoeuZbUoZeC9eS4fdGoA1jf4PCV02L0LnM=
X-Gm-Gg: ASbGnctvd3eIEeKq4eMU4N/PTRm9kYmYhaW2WxpO96R5lSTn7qPdCmUzo/wPul6vBlC
 3CiQKhBhyW3AIPsUFfe/i/8O3xKDjWjtPsPzMJSNMiEYhG5uH2jQadMNweCjgb6E4Q9MX5LLFDA
 CENzPMGHpz4+iEYS186pPI54bAUeCS1KcJdCMydRAbqDGNIP5RpQD0dH3V0wo0goYTXYWA8qaZb
 JWX5omtNucSsmgZPJOEsqYAAMqQGOwd8oXqX+vzEBHJbeW4AZPw3as3gkH8
X-Google-Smtp-Source: AGHT+IGrkshHhjCc4F9VOMMdoGuPFumzPj9vIMx+ZtCuNkrhjFoXjtm0za9AtzVF9UDd9IZwKXG6bQ==
X-Received: by 2002:a05:6a00:1947:b0:725:456e:76e with SMTP id
 d2e1a72fcca58-72abdd8caf2mr75773205b3a.6.1735977709444; 
 Sat, 04 Jan 2025 00:01:49 -0800 (PST)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-72aad8fb7dbsm27356326b3a.133.2025.01.04.00.01.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Jan 2025 00:01:49 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 04 Jan 2025 17:00:59 +0900
Subject: [PATCH v8 6/9] virtio-pci: Implement SR-IOV PF
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250104-sriov-v8-6-56144cfdc7d9@daynix.com>
References: <20250104-sriov-v8-0-56144cfdc7d9@daynix.com>
In-Reply-To: <20250104-sriov-v8-0-56144cfdc7d9@daynix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, devel@daynix.com, 
 Yui Washizu <yui.washidu@gmail.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62d.google.com
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
index c773a9130c7e..5ea8e7f6d0a8 100644
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
@@ -2219,9 +2228,9 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
         pci_set_word(pci_dev->config + pos + PCI_PM_PMC, 0x3);
 
         if (proxy->flags & VIRTIO_PCI_FLAG_AER) {
-            pcie_aer_init(pci_dev, PCI_ERR_VER, last_pcie_cap_offset,
+            pcie_aer_init(pci_dev, PCI_ERR_VER, proxy->last_pcie_cap_offset,
                           PCI_ERR_SIZEOF, NULL);
-            last_pcie_cap_offset += PCI_ERR_SIZEOF;
+            proxy->last_pcie_cap_offset += PCI_ERR_SIZEOF;
         }
 
         if (proxy->flags & VIRTIO_PCI_FLAG_INIT_DEVERR) {
@@ -2246,9 +2255,9 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
         }
 
         if (proxy->flags & VIRTIO_PCI_FLAG_ATS) {
-            pcie_ats_init(pci_dev, last_pcie_cap_offset,
+            pcie_ats_init(pci_dev, proxy->last_pcie_cap_offset,
                           proxy->flags & VIRTIO_PCI_FLAG_ATS_PAGE_ALIGNED);
-            last_pcie_cap_offset += PCI_EXT_CAP_ATS_SIZEOF;
+            proxy->last_pcie_cap_offset += PCI_EXT_CAP_ATS_SIZEOF;
         }
 
         if (proxy->flags & VIRTIO_PCI_FLAG_INIT_FLR) {
@@ -2276,6 +2285,7 @@ static void virtio_pci_exit(PCIDevice *pci_dev)
                      !pci_bus_is_root(pci_get_bus(pci_dev));
     bool modern_pio = proxy->flags & VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY;
 
+    pcie_sriov_pf_exit(&proxy->pci_dev);
     msix_uninit_exclusive_bar(pci_dev);
     if (proxy->flags & VIRTIO_PCI_FLAG_AER && pcie_port &&
         pci_is_express(pci_dev)) {

-- 
2.47.1


