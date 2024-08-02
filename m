Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B8F0C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 06:51:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZm7m-0002XJ-Qs; Fri, 02 Aug 2024 02:50:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sZm7m-0002SE-5k
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 02:50:50 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sZm7k-0000yZ-Jh
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 02:50:49 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7093f3a1af9so4710254a34.1
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 23:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1722581447; x=1723186247;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vdR/tAAVHxSpgFFmSFp64O9usJu3eSZIZ8gMew9CW0c=;
 b=0h7dFTTNis2O+lfqEepJpFIsFwEwsTz+tF4Ix2sjJ8Cg5xQFHW2gUZrEDFdbcBmCnE
 BvSwEyuDrgCUHqiOC0AkmLRTQkHNJVxgenE3kgQVUCjABxjzgMTH4QtrvCM25yJCzcjT
 tl8ftvm0+H1/7H/G3uId6TJbVunih9HJR+CmFRSpuwyvH75qXLeM1PmBWeBu4V3rQV4a
 2yxmLFk7HffkOEGFaCpupE2yXpYfCj9oB0f+Y5vr8/7DvoWl0QFnXTvWMQhhr175OkVx
 4j7ujR187Epb9KrZupNAQPhORXP5vGNd2nVRLpFvkPfpP8HrbYxegHrckd0v50Wd+MTH
 HNnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722581447; x=1723186247;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vdR/tAAVHxSpgFFmSFp64O9usJu3eSZIZ8gMew9CW0c=;
 b=FbKmuD3ru2EBlgyzr28oHp5tX+z4IPukMwM0j+3VuOfn+LWCEnejJ+tYu+rSt429M6
 YNtiTeesGhFouEIX+hpMrcWsqAyRPl8Cb9gGlj9ogzgufWRht7Z5nxO1Xt8Ts+Awqyf0
 yxrA16920PlUY6FQtvVhOknFH9qhO4v47qaH989r3JBrlQYG+XcD7bY7OzyGNANQaUZG
 C7gSn0By1xvPEoU9lZA5+1nZvpntoVMVdtUCLCXAIiR4Y9qX0wXpj+snPBd5visu+3wE
 q3m9F22m23T+yYgwi+Z0ESyI0kxmpMBzuLOeeCO7tynPqDZeKWapzNbcvx0/Y77gTHpb
 VVzA==
X-Gm-Message-State: AOJu0YwnirE5WekMW75VU+7XyLYrWsLvquXUWyHWuTTmjtz5YW3skE08
 2+VtDqBaBJ2mtKnySMgcRRi1dEsll7iYqo9T594DbDe9eg8agI0rKl8fUygYonno1XAWR7pmy+u
 dRQ8=
X-Google-Smtp-Source: AGHT+IHWJRIR2S0OGEJAuKHTV4V4yE/ZHczC8RdJi2EhDyDONld+xoKUfr/+8PJgd340dhIa0xKjHA==
X-Received: by 2002:a05:6830:6987:b0:709:3ba1:fc88 with SMTP id
 46e09a7af769-709b9981fd2mr3083580a34.33.1722581447352; 
 Thu, 01 Aug 2024 23:50:47 -0700 (PDT)
Received: from localhost ([157.82.201.15]) by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-7106ed14f38sm775291b3a.184.2024.08.01.23.50.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Aug 2024 23:50:47 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 02 Aug 2024 15:49:50 +0900
Subject: [PATCH for-9.2 v6 6/9] virtio-pci: Implement SR-IOV PF
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240802-sriov-v6-6-0c8ff49c4276@daynix.com>
References: <20240802-sriov-v6-0-0c8ff49c4276@daynix.com>
In-Reply-To: <20240802-sriov-v6-0-0c8ff49c4276@daynix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Yui Washizu <yui.washidu@gmail.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::32e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ot1-x32e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
index 9e67ba38c748..34539f2f6722 100644
--- a/include/hw/virtio/virtio-pci.h
+++ b/include/hw/virtio/virtio-pci.h
@@ -152,6 +152,7 @@ struct VirtIOPCIProxy {
     uint32_t modern_io_bar_idx;
     uint32_t modern_mem_bar_idx;
     int config_cap;
+    uint16_t last_pcie_cap_offset;
     uint32_t flags;
     bool disable_modern;
     bool ignore_backend_features;
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 9534730bba19..0c8fcc5627d5 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1955,6 +1955,7 @@ static void virtio_pci_device_plugged(DeviceState *d, Error **errp)
     uint8_t *config;
     uint32_t size;
     VirtIODevice *vdev = virtio_bus_get_device(bus);
+    int16_t res;
 
     /*
      * Virtio capabilities present without
@@ -2100,6 +2101,14 @@ static void virtio_pci_device_plugged(DeviceState *d, Error **errp)
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
@@ -2187,7 +2196,7 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
 
     if (pcie_port && pci_is_express(pci_dev)) {
         int pos;
-        uint16_t last_pcie_cap_offset = PCI_CONFIG_SPACE_SIZE;
+        proxy->last_pcie_cap_offset = PCI_CONFIG_SPACE_SIZE;
 
         pos = pcie_endpoint_cap_init(pci_dev, 0);
         assert(pos > 0);
@@ -2207,9 +2216,9 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
         pci_set_word(pci_dev->config + pos + PCI_PM_PMC, 0x3);
 
         if (proxy->flags & VIRTIO_PCI_FLAG_AER) {
-            pcie_aer_init(pci_dev, PCI_ERR_VER, last_pcie_cap_offset,
+            pcie_aer_init(pci_dev, PCI_ERR_VER, proxy->last_pcie_cap_offset,
                           PCI_ERR_SIZEOF, NULL);
-            last_pcie_cap_offset += PCI_ERR_SIZEOF;
+            proxy->last_pcie_cap_offset += PCI_ERR_SIZEOF;
         }
 
         if (proxy->flags & VIRTIO_PCI_FLAG_INIT_DEVERR) {
@@ -2234,9 +2243,9 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
         }
 
         if (proxy->flags & VIRTIO_PCI_FLAG_ATS) {
-            pcie_ats_init(pci_dev, last_pcie_cap_offset,
+            pcie_ats_init(pci_dev, proxy->last_pcie_cap_offset,
                           proxy->flags & VIRTIO_PCI_FLAG_ATS_PAGE_ALIGNED);
-            last_pcie_cap_offset += PCI_EXT_CAP_ATS_SIZEOF;
+            proxy->last_pcie_cap_offset += PCI_EXT_CAP_ATS_SIZEOF;
         }
 
         if (proxy->flags & VIRTIO_PCI_FLAG_INIT_FLR) {
@@ -2263,6 +2272,7 @@ static void virtio_pci_exit(PCIDevice *pci_dev)
     bool pcie_port = pci_bus_is_express(pci_get_bus(pci_dev)) &&
                      !pci_bus_is_root(pci_get_bus(pci_dev));
 
+    pcie_sriov_pf_exit(&proxy->pci_dev);
     msix_uninit_exclusive_bar(pci_dev);
     if (proxy->flags & VIRTIO_PCI_FLAG_AER && pcie_port &&
         pci_is_express(pci_dev)) {

-- 
2.45.2


