Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1CF1C021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 12:28:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlS3y-00058p-BF; Fri, 21 Feb 2025 07:23:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlS3w-0004yR-Ah
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:23:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlS3u-00074a-KY
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:23:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740140602;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=24rqHDBhYxq+r3JiigQWSM+5Xsth2RmvFt80HgCZtbE=;
 b=gbu2micGNTF+jXyOtibBRe5LdNOJNy2Q+qXa+MJ84/Blt5Hk9MZahEHCBBIC2Scpv18C2B
 vxr4WZaWDNRYRHKXY4ngeBMQrUf6gPHPYPCQZGPN2pVII5GB7O75AERw3f97jhbyhg1GY4
 8Gt2/JbGfc2RhNWVOixfqtdm+82vZYA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-b-nXkWR_NZGqstCkbU_lBw-1; Fri, 21 Feb 2025 07:23:18 -0500
X-MC-Unique: b-nXkWR_NZGqstCkbU_lBw-1
X-Mimecast-MFC-AGG-ID: b-nXkWR_NZGqstCkbU_lBw_1740140597
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4399c5ba9e4so10937205e9.3
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 04:23:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740140597; x=1740745397;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=24rqHDBhYxq+r3JiigQWSM+5Xsth2RmvFt80HgCZtbE=;
 b=I3qm2tKq4lES+e0hdmOxUkRamRF7ZlHt4ZROHO+9aQfid/UgLqoxszqvayIJvQzIz4
 U7CEXYXYl0PoW3/kXhDm0FdmdRmhSokcLiVqjkpaWNDyrUQAnvx/HnT4kEhQlzcTuV2l
 YxCnnYKHJ6DBdxZjKi8N0LpLUnvewDJztzd9TkCjyMy3Jd5666O057fALpvCMuFq85HK
 YrMkxJqx9Bzg2epXhOgy2GOBm+vCZg/ojU/O2pI5IWAh2gTqeAaGD46FQeYpSNgyYRLD
 XVtyeNcrpKkwNABv3lW5VwamQrXE5fOevwaQroHZVGNRXz5AQTulj7p1KSguUYSCYSh/
 2Hug==
X-Gm-Message-State: AOJu0YzpV8Cy41OAjfom/nN5u7QJXobVd2WkCp2WTyXhLdRz+A/87L1J
 uqjm6V7a47UTYYtP6SMRhu4mP6IdbQSmJ+A1U6Xn2t0cK32UKthtS0TqK12t5Zb3J1T7vpOCR3t
 Q0sl6f5eRhzBQHRBkHZcgBatIazqmrq1SDDvhuIRwVV17zBZjMGKrhoWa8gBIF7Dx+KoswPTaaV
 6pMBD9TLe5SFkNHENxqEiMwjr54TkmCw==
X-Gm-Gg: ASbGncv/Fu3ahAYmY9JKEL/U/g85Jb7i1q+DRPvKJj8/KliIPW2RnbV4yyXfo9LcpOF
 kMp7vmp8psjwjOJeqtbaNBsoJt9G9cstkDLovj1SRMvQJNkWijxrSzkZD66aZSSddGqmthSyZ20
 uB61+nlTojbmK6py++qlFq4alDQQ7uxV7B1R/wyuzwQkxONpER0+EZWiq931xmBmNIN3GDYX8Qj
 J+9BiNLijJGx62U0guCJ7kz/3pXRuCS4nAPSK9y6rJ6ro2rUsh0EdmA7L1buaPcCu2pfTkjOQo2
 fFE8cg==
X-Received: by 2002:a05:600c:4f84:b0:439:a5e6:73ff with SMTP id
 5b1f17b1804b1-439ae1f1592mr25822035e9.17.1740140596711; 
 Fri, 21 Feb 2025 04:23:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGo9/AQqo1o07mTu78YKKF3QoTM2iQJnYI73eu657am8xueKpwPzz3H475IpZC1SdFg6W549g==
X-Received: by 2002:a05:600c:4f84:b0:439:a5e6:73ff with SMTP id
 5b1f17b1804b1-439ae1f1592mr25821745e9.17.1740140596297; 
 Fri, 21 Feb 2025 04:23:16 -0800 (PST)
Received: from redhat.com ([31.187.78.163]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259f771dsm23064139f8f.81.2025.02.21.04.23.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 04:23:15 -0800 (PST)
Date: Fri, 21 Feb 2025 07:23:11 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 12/41] pcie_sriov: Remove num_vfs from PCIESriovPF
Message-ID: <5e7dd17e43486f41d4f88dbefd7219f0524f424c.1740140520.git.mst@redhat.com>
References: <cover.1740140520.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1740140520.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.424,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Message-Id: <20250116-reuse-v20-10-7cb370606368@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/pci/pcie_sriov.h |  1 -
 hw/pci/pcie_sriov.c         | 38 ++++++++++++++++++++++++++-----------
 hw/pci/trace-events         |  2 +-
 3 files changed, 28 insertions(+), 13 deletions(-)

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
index db087bb933..69609c112e 100644
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


