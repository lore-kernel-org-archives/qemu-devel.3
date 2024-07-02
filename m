Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E33E8C3065C
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:19:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOeEl-0001BO-2G; Tue, 02 Jul 2024 10:12:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeEi-0000vc-5h
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:12:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeES-000161-Js
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:11:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719929503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7pMoBjPNl8oUEg5zlwInizxqA4Nbo5A/7NGMCDnRaVI=;
 b=IGfhsfr7DbegstpGF+4AazIPZmWfB2FjcRedkONW2c4BWfvVlD20/JwrlawzAoA12EaEQU
 vmxvOSpS2Fh9aojXohbI4ekOyCrOUFIplVfrFDtqrGtCnyLZkN4JYWs4OWs9NqLQgopDhp
 2GO9eKS4WyOxSA8Wq/YU65QJNW17jn8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-RfHDw3LzOXivKUezinyriw-1; Tue, 02 Jul 2024 10:11:39 -0400
X-MC-Unique: RfHDw3LzOXivKUezinyriw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4257db9d71fso16896985e9.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 07:11:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719929497; x=1720534297;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7pMoBjPNl8oUEg5zlwInizxqA4Nbo5A/7NGMCDnRaVI=;
 b=mjXE2eB775RCvKYdGTAROxnpP5nkAgcj+ovMS3XGyjI7cyE9cX5bIwmfNAMZRt3u4H
 pk9iSak5/eP+Ibpmku4EehH3WIO4xR0Sq5oLfpiA6EJX5UZbqKTrClUQCwUXEdpdcul3
 j3vosJfutWIxKa6BFi5QhFmcHXPIDijhzxv37KzurjCdUipE8PmTe07gtdMP7stf7cc7
 JH8e70W8P2OX6mpRQAIm2GSdhutuXjG4Gl8jd8NktVJHOaKnN8jpZC3qXrSCbGle2uez
 k+AjkJiAjy/rrT8y6UcmvAqwY0imL90f7imBWpZOfJLP7FTMjuvm1YlPiPJQDBCUTezm
 gEUw==
X-Gm-Message-State: AOJu0YyBOb9CI7jIqxdSimUi+5mhXUH2kfGbGgaslnqYeMyfeNjScv7q
 KDHOFayKKpxnnzztFQT0Ache+3SzUgnM8B/1rSYDyfxPf/o0q0/3bHds5dRdw3ozQzhMucloiPj
 7UjcHdPtwbWAP+xgD7a5Huh+43Wgzdx8tifzJolXhjDPRzJclrm5BL62aWH0OgSr/aIq+zqcnVb
 t6yHFaqxQT6fvm3HJ3517oBdmUG81dig==
X-Received: by 2002:a05:600c:4fc5:b0:425:73a8:2fa3 with SMTP id
 5b1f17b1804b1-4257a04fe4emr52593235e9.30.1719929497638; 
 Tue, 02 Jul 2024 07:11:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbppqAY4yFRHz3xxAanAETUBxCuOyKH406RquA2nRbW4xIm506aXVMuxJMxO5n6hXq/PS8jg==
X-Received: by 2002:a05:600c:4fc5:b0:425:73a8:2fa3 with SMTP id
 5b1f17b1804b1-4257a04fe4emr52592985e9.30.1719929497082; 
 Tue, 02 Jul 2024 07:11:37 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0cd66fsm13543766f8f.8.2024.07.02.07.11.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 07:11:36 -0700 (PDT)
Date: Tue, 2 Jul 2024 10:11:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 89/91] pcie_sriov: Remove num_vfs from PCIESriovPF
Message-ID: <09379acf8955487df1e48a1ab37ae774d9e791c5.1719929191.git.mst@redhat.com>
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

num_vfs is not migrated so use PCI_SRIOV_CTRL_VFE and PCI_SRIOV_NUM_VF
instead.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20240627-reuse-v10-8-7ca0b8ed3d9f@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/pci/pcie_sriov.h |  1 -
 hw/pci/pcie_sriov.c         | 28 ++++++++++++++++++++--------
 hw/pci/trace-events         |  2 +-
 3 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/include/hw/pci/pcie_sriov.h b/include/hw/pci/pcie_sriov.h
index 70649236c1..5148c5b77d 100644
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
index 9bd7f8acc3..fae6acea4a 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -57,7 +57,6 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
     pcie_add_capability(dev, PCI_EXT_CAP_ID_SRIOV, 1,
                         offset, PCI_EXT_CAP_SRIOV_SIZEOF);
     dev->exp.sriov_cap = offset;
-    dev->exp.sriov_pf.num_vfs = 0;
     dev->exp.sriov_pf.vf = NULL;
 
     pci_set_word(cfg + PCI_SRIOV_VF_OFFSET, vf_offset);
@@ -186,6 +185,12 @@ void pcie_sriov_vf_register_bar(PCIDevice *dev, int region_num,
     }
 }
 
+static void clear_ctrl_vfe(PCIDevice *dev)
+{
+    uint8_t *ctrl = dev->config + dev->exp.sriov_cap + PCI_SRIOV_CTRL;
+    pci_set_word(ctrl, pci_get_word(ctrl) & ~PCI_SRIOV_CTRL_VFE);
+}
+
 static void register_vfs(PCIDevice *dev)
 {
     uint16_t num_vfs;
@@ -195,6 +200,7 @@ static void register_vfs(PCIDevice *dev)
     assert(sriov_cap > 0);
     num_vfs = pci_get_word(dev->config + sriov_cap + PCI_SRIOV_NUM_VF);
     if (num_vfs > pci_get_word(dev->config + sriov_cap + PCI_SRIOV_TOTAL_VF)) {
+        clear_ctrl_vfe(dev);
         return;
     }
 
@@ -203,20 +209,18 @@ static void register_vfs(PCIDevice *dev)
     for (i = 0; i < num_vfs; i++) {
         pci_set_enabled(dev->exp.sriov_pf.vf[i], true);
     }
-    dev->exp.sriov_pf.num_vfs = num_vfs;
 }
 
 static void unregister_vfs(PCIDevice *dev)
 {
-    uint16_t num_vfs = dev->exp.sriov_pf.num_vfs;
     uint16_t i;
+    uint8_t *cfg = dev->config + dev->exp.sriov_cap;
 
     trace_sriov_unregister_vfs(dev->name, PCI_SLOT(dev->devfn),
-                               PCI_FUNC(dev->devfn), num_vfs);
-    for (i = 0; i < num_vfs; i++) {
+                               PCI_FUNC(dev->devfn));
+    for (i = 0; i < pci_get_word(cfg + PCI_SRIOV_TOTAL_VF); i++) {
         pci_set_enabled(dev->exp.sriov_pf.vf[i], false);
     }
-    dev->exp.sriov_pf.num_vfs = 0;
 }
 
 void pcie_sriov_config_write(PCIDevice *dev, uint32_t address,
@@ -242,6 +246,9 @@ void pcie_sriov_config_write(PCIDevice *dev, uint32_t address,
         } else {
             unregister_vfs(dev);
         }
+    } else if (range_covers_byte(off, len, PCI_SRIOV_NUM_VF)) {
+        clear_ctrl_vfe(dev);
+        unregister_vfs(dev);
     }
 }
 
@@ -304,7 +311,7 @@ PCIDevice *pcie_sriov_get_pf(PCIDevice *dev)
 PCIDevice *pcie_sriov_get_vf_at_index(PCIDevice *dev, int n)
 {
     assert(!pci_is_vf(dev));
-    if (n < dev->exp.sriov_pf.num_vfs) {
+    if (n < pcie_sriov_num_vfs(dev)) {
         return dev->exp.sriov_pf.vf[n];
     }
     return NULL;
@@ -312,5 +319,10 @@ PCIDevice *pcie_sriov_get_vf_at_index(PCIDevice *dev, int n)
 
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
index 19643aa8c6..e98f575a9d 100644
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
MST


