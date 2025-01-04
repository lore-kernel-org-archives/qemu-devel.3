Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38FEFE7719A
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jan 2025 07:55:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTyyn-0002ie-68; Sat, 04 Jan 2025 02:53:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tTyyj-0002LQ-U2
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 02:53:49 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tTyyh-00039d-UM
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 02:53:49 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2161eb95317so186651205ad.1
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2025 23:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1735977223; x=1736582023;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vBTA/eSFpNVagoYgK/YYl9vBkpIAy0UvZyUMa/rjIxs=;
 b=yuqvUwlT2RR/sPIWnbNjWpw4ayo89Q/VjY8q0tl+wRuFxP4FHUFSHz7vinZSMU10f9
 jjv6GozIUEsbNVpJ6ikV76qW0yGAQnlR0VJ/CZwmOEAxmw0frUs8AG7lDOiWOwpTUIGp
 wfm4G0nWN+JroIrMNXSHDWhjQkdeWAt3gHY1N43LQgcv7vLnd79Acg9owTdyU64ORZvg
 jrp4voDNZrVVeu+3w7VxU8EzgwWgU4bIFFGzCjzv+pmTcxWJ5ab1fG1Mj4k6imLr2yVH
 GL6YjznyNLqKdScCC3yeu67DmQm/WOBhe40RLbtxP2LYr1gQGij8G8c/nZIwmV56Op0Z
 09PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735977223; x=1736582023;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vBTA/eSFpNVagoYgK/YYl9vBkpIAy0UvZyUMa/rjIxs=;
 b=piW5yectmakHxSVFt+K0UIxowWQxK73qrNmPmYUkicYS6cmSRQhK+kkX5WlH+2INrb
 HxZo0rOA8Z4TVlWvZ0NcPsGIWFfrqMxqJB7Wuni/9qoR19rQDS73Lz1Q9MweBswhn/2w
 ESnzNlWh09C92KGXExSV+099wbwUHgIyfz+zPf2DGHc/W2wysol2snzWErVNmPYD+Q8o
 GbFkajESxPkJRky5YjIoYuFsHBHfMZUyo40cqn9Yvw5qYPu9AHL45YLCUl42NDLVxF2a
 hJWwY7+6fRXz8mBhhpLB7AyHvYBD1/umVX0inDJ/X7Dd+MRk2lDQjFGuKHEUKbh0vNMu
 m07Q==
X-Gm-Message-State: AOJu0Yznjrs0xcywe1G87W3AxS+up88zSjeU7BZn+HCzRUqLMX9ILR0R
 ozfy+TRpqlGYpTF5jEiZuLUN8e6zNGmTGpja8DtOWfO+GP61uHLZ9XRUT8KFnJY=
X-Gm-Gg: ASbGncs5IlF/tymD6p/DMjKVWwE6FPy+y8pySAAu6Et/CHlR1lKkvMQcYuaiwibknfV
 3xL2W/TsHOxw99ekFToUu8o6JBJsG8FAd9vMVcjAftUNeey+cphIe0w4RYW0VYSidg+owSR12bs
 TvVBfcu1iYPdh0c3YiTDYceZcWqyN8IqdBuYg811k6T7zc8hLE6Ej0dQGNp6IYNc5yYuT8fww1y
 yEphsBhNVCegev9+Ff7IZT2o1yne2zngdGUeTWqpSKwPOyec3g9LCj04W88
X-Google-Smtp-Source: AGHT+IFpNOixQtoeyLgFhdqJpsGqXvcJfy/spJhHRUxHqdjmb5pWG0ItnpSdBCMOG0e5ZNtw4jaRKQ==
X-Received: by 2002:a05:6a20:12c5:b0:1e0:c3bf:7909 with SMTP id
 adf61e73a8af0-1e5e081c9damr85227358637.41.1735977223163; 
 Fri, 03 Jan 2025 23:53:43 -0800 (PST)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-72aad8370d5sm27448859b3a.71.2025.01.03.23.53.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jan 2025 23:53:42 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 04 Jan 2025 16:52:31 +0900
Subject: [PATCH v18 11/14] pcie_sriov: Remove num_vfs from PCIESriovPF
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250104-reuse-v18-11-c349eafd8673@daynix.com>
References: <20250104-reuse-v18-0-c349eafd8673@daynix.com>
In-Reply-To: <20250104-reuse-v18-0-c349eafd8673@daynix.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Shivaprasad G Bhat <sbhat@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62f.google.com
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

num_vfs is not migrated so use PCI_SRIOV_CTRL_VFE and PCI_SRIOV_NUM_VF
instead.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/hw/pci/pcie_sriov.h |  1 -
 hw/pci/pcie_sriov.c         | 38 +++++++++++++++++++++++++++-----------
 hw/pci/trace-events         |  2 +-
 3 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/include/hw/pci/pcie_sriov.h b/include/hw/pci/pcie_sriov.h
index 70649236c18a..5148c5b77dd1 100644
--- a/include/hw/pci/pcie_sriov.h
+++ b/include/hw/pci/pcie_sriov.h
@@ -16,7 +16,6 @@
 #include "hw/pci/pci.h"
 
 typedef struct PCIESriovPF {
-    uint16_t num_vfs;   /* Number of virtual functions created */
     uint8_t vf_bar_type[PCI_NUM_REGIONS];   /* Store type for each VF bar */
     PCIDevice **vf;     /* Pointer to an array of num_vfs VF devices */
 } PCIESriovPF;
diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index db087bb9330c..69609c112e31 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -51,7 +51,6 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
     pcie_add_capability(dev, PCI_EXT_CAP_ID_SRIOV, 1,
                         offset, PCI_EXT_CAP_SRIOV_SIZEOF);
     dev->exp.sriov_cap = offset;
-    dev->exp.sriov_pf.num_vfs = 0;
     dev->exp.sriov_pf.vf = NULL;
 
     pci_set_word(cfg + PCI_SRIOV_VF_OFFSET, vf_offset);
@@ -188,29 +187,28 @@ static void register_vfs(PCIDevice *dev)
 
     assert(sriov_cap > 0);
     num_vfs = pci_get_word(dev->config + sriov_cap + PCI_SRIOV_NUM_VF);
-    if (num_vfs > pci_get_word(dev->config + sriov_cap + PCI_SRIOV_TOTAL_VF)) {
-        return;
-    }
 
     trace_sriov_register_vfs(dev->name, PCI_SLOT(dev->devfn),
                              PCI_FUNC(dev->devfn), num_vfs);
     for (i = 0; i < num_vfs; i++) {
         pci_set_enabled(dev->exp.sriov_pf.vf[i], true);
     }
-    dev->exp.sriov_pf.num_vfs = num_vfs;
+
+    pci_set_word(dev->wmask + sriov_cap + PCI_SRIOV_NUM_VF, 0);
 }
 
 static void unregister_vfs(PCIDevice *dev)
 {
-    uint16_t num_vfs = dev->exp.sriov_pf.num_vfs;
+    uint8_t *cfg = dev->config + dev->exp.sriov_cap;
     uint16_t i;
 
     trace_sriov_unregister_vfs(dev->name, PCI_SLOT(dev->devfn),
-                               PCI_FUNC(dev->devfn), num_vfs);
-    for (i = 0; i < num_vfs; i++) {
+                               PCI_FUNC(dev->devfn));
+    for (i = 0; i < pci_get_word(cfg + PCI_SRIOV_TOTAL_VF); i++) {
         pci_set_enabled(dev->exp.sriov_pf.vf[i], false);
     }
-    dev->exp.sriov_pf.num_vfs = 0;
+
+    pci_set_word(dev->wmask + dev->exp.sriov_cap + PCI_SRIOV_NUM_VF, 0xffff);
 }
 
 void pcie_sriov_config_write(PCIDevice *dev, uint32_t address,
@@ -236,6 +234,17 @@ void pcie_sriov_config_write(PCIDevice *dev, uint32_t address,
         } else {
             unregister_vfs(dev);
         }
+    } else if (range_covers_byte(off, len, PCI_SRIOV_NUM_VF)) {
+        uint8_t *cfg = dev->config + sriov_cap;
+        uint8_t *wmask = dev->wmask + sriov_cap;
+        uint16_t num_vfs = pci_get_word(cfg + PCI_SRIOV_NUM_VF);
+        uint16_t wmask_val = PCI_SRIOV_CTRL_MSE | PCI_SRIOV_CTRL_ARI;
+
+        if (num_vfs <= pci_get_word(cfg + PCI_SRIOV_TOTAL_VF)) {
+            wmask_val |= PCI_SRIOV_CTRL_VFE;
+        }
+
+        pci_set_word(wmask + PCI_SRIOV_CTRL, wmask_val);
     }
 }
 
@@ -252,6 +261,8 @@ void pcie_sriov_pf_reset(PCIDevice *dev)
     unregister_vfs(dev);
 
     pci_set_word(dev->config + sriov_cap + PCI_SRIOV_NUM_VF, 0);
+    pci_set_word(dev->wmask + sriov_cap + PCI_SRIOV_CTRL,
+                 PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE | PCI_SRIOV_CTRL_ARI);
 
     /*
      * Default is to use 4K pages, software can modify it
@@ -298,7 +309,7 @@ PCIDevice *pcie_sriov_get_pf(PCIDevice *dev)
 PCIDevice *pcie_sriov_get_vf_at_index(PCIDevice *dev, int n)
 {
     assert(!pci_is_vf(dev));
-    if (n < dev->exp.sriov_pf.num_vfs) {
+    if (n < pcie_sriov_num_vfs(dev)) {
         return dev->exp.sriov_pf.vf[n];
     }
     return NULL;
@@ -306,5 +317,10 @@ PCIDevice *pcie_sriov_get_vf_at_index(PCIDevice *dev, int n)
 
 uint16_t pcie_sriov_num_vfs(PCIDevice *dev)
 {
-    return dev->exp.sriov_pf.num_vfs;
+    uint16_t sriov_cap = dev->exp.sriov_cap;
+    uint8_t *cfg = dev->config + sriov_cap;
+
+    return sriov_cap &&
+           (pci_get_word(cfg + PCI_SRIOV_CTRL) & PCI_SRIOV_CTRL_VFE) ?
+           pci_get_word(cfg + PCI_SRIOV_NUM_VF) : 0;
 }
diff --git a/hw/pci/trace-events b/hw/pci/trace-events
index 19643aa8c6b0..e98f575a9d19 100644
--- a/hw/pci/trace-events
+++ b/hw/pci/trace-events
@@ -14,7 +14,7 @@ msix_write_config(char *name, bool enabled, bool masked) "dev %s enabled %d mask
 
 # hw/pci/pcie_sriov.c
 sriov_register_vfs(const char *name, int slot, int function, int num_vfs) "%s %02x:%x: creating %d vf devs"
-sriov_unregister_vfs(const char *name, int slot, int function, int num_vfs) "%s %02x:%x: Unregistering %d vf devs"
+sriov_unregister_vfs(const char *name, int slot, int function) "%s %02x:%x: Unregistering vf devs"
 sriov_config_write(const char *name, int slot, int fun, uint32_t offset, uint32_t val, uint32_t len) "%s %02x:%x: sriov offset 0x%x val 0x%x len %d"
 
 # pcie.c

-- 
2.47.1


