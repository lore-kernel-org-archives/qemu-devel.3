Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F183C3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 10:38:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZTAt-0005vj-Uq; Thu, 01 Aug 2024 06:36:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZTAj-00054j-Fu
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 06:36:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZTAh-0001fq-LV
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 06:36:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722508595;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G4QMeU0+8DoiMY9SQEvoe2ryIifTYQOkCLesk2LGT2U=;
 b=REwsM0ZkBNLqFF6vrCbGkBUOEoVKdETTKABkM5lt3MwBZLbNn7fSbp/LB+/I48Brnli9HY
 YGuwD/yhw1rM+Vr0wT7WsJFkC8Z4Yy4JV/IJdDduVCpyxsyxkJ71Z+L/QJm6tDhBKYecM+
 Nk+fyuEZraUMP9Ln7q5a7RP9D0ySFic=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-Np6eLwWZPnijI1cgGKu1tQ-1; Thu, 01 Aug 2024 06:36:34 -0400
X-MC-Unique: Np6eLwWZPnijI1cgGKu1tQ-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5a3fa8b9151so5988073a12.2
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 03:36:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722508592; x=1723113392;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G4QMeU0+8DoiMY9SQEvoe2ryIifTYQOkCLesk2LGT2U=;
 b=hIGAmGV03Ig+TmTsrDqbCrccdGpKKCfJd9TVsHfxdYVpexHhNJ2GGiNFzQXL7HLylf
 DTnkYtQssj4+BOKz7FPN1utidCJSt5Qe2FBwZhjLMizYpGKVEywlpZ892XLJbqEuu5sh
 kZkAGXGRSSSqAnuYuWRbZ8UojsOZJG5zo9KZPPCQmxBTX0MhlhVi88e3zRNrOyPwUUWg
 nupbbbrUpzGrKScajEmA6BDntd8K48cp8JeZ+5WMQ8jIRN44KveM2HwvQJ8fHftczeD3
 MrSH5QOHVs4F5nPZjymskv824qRKpiPCKMP/pvqJ1TF1+Nico+4xgeRkm3BKw2DPzOS0
 Oifg==
X-Gm-Message-State: AOJu0YzdUEgNdr5h7ybzcujpKI/5MTThA1iqFMf1vCWjDFzMNP//jIwo
 KU0nk7JLpESgbvIlqmdpa0H2hTop2i0iorN1n1tHiXnaBoqR94K+vVzi7Ks0qR1VSwrXWkHPboR
 bkLPdvjeSe703a/bhTdURJLf1xjG3jVxFvhkBy0djO6L69HR+1+kA9qZhUkEsWPKIeJ0HoxbTjv
 tk6iNlHSMIt1LpVNGcS0hexvwlQmFnVA==
X-Received: by 2002:aa7:c142:0:b0:5a1:eb48:2b9a with SMTP id
 4fb4d7f45d1cf-5b7003d7926mr1320393a12.25.1722508592515; 
 Thu, 01 Aug 2024 03:36:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0KIqZ+Fu+Sgh15KrbEP6wF8b4nDwpPxLL90QvxVwzoE6lZaUaUjdMowqYjpd/ZjQVUhyM3w==
X-Received: by 2002:aa7:c142:0:b0:5a1:eb48:2b9a with SMTP id
 4fb4d7f45d1cf-5b7003d7926mr1320358a12.25.1722508591757; 
 Thu, 01 Aug 2024 03:36:31 -0700 (PDT)
Received: from redhat.com ([2.55.44.248]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5ac63590d81sm10069517a12.23.2024.08.01.03.36.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 03:36:30 -0700 (PDT)
Date: Thu, 1 Aug 2024 06:36:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 10/19] Revert "pcie_sriov: Remove num_vfs from PCIESriovPF"
Message-ID: <ae9c192de7ab0f56f32d8b60b6568917e0138919.1722508478.git.mst@redhat.com>
References: <cover.1722508478.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1722508478.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
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

This reverts commit cbd9e5120bac3e292eee77b7a2e3692f235a1a26.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/pci/pcie_sriov.h |  1 +
 hw/pci/pcie_sriov.c         | 28 ++++++++--------------------
 hw/pci/trace-events         |  2 +-
 3 files changed, 10 insertions(+), 21 deletions(-)

diff --git a/include/hw/pci/pcie_sriov.h b/include/hw/pci/pcie_sriov.h
index 5148c5b77d..70649236c1 100644
--- a/include/hw/pci/pcie_sriov.h
+++ b/include/hw/pci/pcie_sriov.h
@@ -16,6 +16,7 @@
 #include "hw/pci/pci.h"
 
 typedef struct PCIESriovPF {
+    uint16_t num_vfs;   /* Number of virtual functions created */
     uint8_t vf_bar_type[PCI_NUM_REGIONS];   /* Store type for each VF bar */
     PCIDevice **vf;     /* Pointer to an array of num_vfs VF devices */
 } PCIESriovPF;
diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index fae6acea4a..9bd7f8acc3 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -57,6 +57,7 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
     pcie_add_capability(dev, PCI_EXT_CAP_ID_SRIOV, 1,
                         offset, PCI_EXT_CAP_SRIOV_SIZEOF);
     dev->exp.sriov_cap = offset;
+    dev->exp.sriov_pf.num_vfs = 0;
     dev->exp.sriov_pf.vf = NULL;
 
     pci_set_word(cfg + PCI_SRIOV_VF_OFFSET, vf_offset);
@@ -185,12 +186,6 @@ void pcie_sriov_vf_register_bar(PCIDevice *dev, int region_num,
     }
 }
 
-static void clear_ctrl_vfe(PCIDevice *dev)
-{
-    uint8_t *ctrl = dev->config + dev->exp.sriov_cap + PCI_SRIOV_CTRL;
-    pci_set_word(ctrl, pci_get_word(ctrl) & ~PCI_SRIOV_CTRL_VFE);
-}
-
 static void register_vfs(PCIDevice *dev)
 {
     uint16_t num_vfs;
@@ -200,7 +195,6 @@ static void register_vfs(PCIDevice *dev)
     assert(sriov_cap > 0);
     num_vfs = pci_get_word(dev->config + sriov_cap + PCI_SRIOV_NUM_VF);
     if (num_vfs > pci_get_word(dev->config + sriov_cap + PCI_SRIOV_TOTAL_VF)) {
-        clear_ctrl_vfe(dev);
         return;
     }
 
@@ -209,18 +203,20 @@ static void register_vfs(PCIDevice *dev)
     for (i = 0; i < num_vfs; i++) {
         pci_set_enabled(dev->exp.sriov_pf.vf[i], true);
     }
+    dev->exp.sriov_pf.num_vfs = num_vfs;
 }
 
 static void unregister_vfs(PCIDevice *dev)
 {
+    uint16_t num_vfs = dev->exp.sriov_pf.num_vfs;
     uint16_t i;
-    uint8_t *cfg = dev->config + dev->exp.sriov_cap;
 
     trace_sriov_unregister_vfs(dev->name, PCI_SLOT(dev->devfn),
-                               PCI_FUNC(dev->devfn));
-    for (i = 0; i < pci_get_word(cfg + PCI_SRIOV_TOTAL_VF); i++) {
+                               PCI_FUNC(dev->devfn), num_vfs);
+    for (i = 0; i < num_vfs; i++) {
         pci_set_enabled(dev->exp.sriov_pf.vf[i], false);
     }
+    dev->exp.sriov_pf.num_vfs = 0;
 }
 
 void pcie_sriov_config_write(PCIDevice *dev, uint32_t address,
@@ -246,9 +242,6 @@ void pcie_sriov_config_write(PCIDevice *dev, uint32_t address,
         } else {
             unregister_vfs(dev);
         }
-    } else if (range_covers_byte(off, len, PCI_SRIOV_NUM_VF)) {
-        clear_ctrl_vfe(dev);
-        unregister_vfs(dev);
     }
 }
 
@@ -311,7 +304,7 @@ PCIDevice *pcie_sriov_get_pf(PCIDevice *dev)
 PCIDevice *pcie_sriov_get_vf_at_index(PCIDevice *dev, int n)
 {
     assert(!pci_is_vf(dev));
-    if (n < pcie_sriov_num_vfs(dev)) {
+    if (n < dev->exp.sriov_pf.num_vfs) {
         return dev->exp.sriov_pf.vf[n];
     }
     return NULL;
@@ -319,10 +312,5 @@ PCIDevice *pcie_sriov_get_vf_at_index(PCIDevice *dev, int n)
 
 uint16_t pcie_sriov_num_vfs(PCIDevice *dev)
 {
-    uint16_t sriov_cap = dev->exp.sriov_cap;
-    uint8_t *cfg = dev->config + sriov_cap;
-
-    return sriov_cap &&
-           (pci_get_word(cfg + PCI_SRIOV_CTRL) & PCI_SRIOV_CTRL_VFE) ?
-           pci_get_word(cfg + PCI_SRIOV_NUM_VF) : 0;
+    return dev->exp.sriov_pf.num_vfs;
 }
diff --git a/hw/pci/trace-events b/hw/pci/trace-events
index e98f575a9d..19643aa8c6 100644
--- a/hw/pci/trace-events
+++ b/hw/pci/trace-events
@@ -14,7 +14,7 @@ msix_write_config(char *name, bool enabled, bool masked) "dev %s enabled %d mask
 
 # hw/pci/pcie_sriov.c
 sriov_register_vfs(const char *name, int slot, int function, int num_vfs) "%s %02x:%x: creating %d vf devs"
-sriov_unregister_vfs(const char *name, int slot, int function) "%s %02x:%x: Unregistering vf devs"
+sriov_unregister_vfs(const char *name, int slot, int function, int num_vfs) "%s %02x:%x: Unregistering %d vf devs"
 sriov_config_write(const char *name, int slot, int fun, uint32_t offset, uint32_t val, uint32_t len) "%s %02x:%x: sriov offset 0x%x val 0x%x len %d"
 
 # pcie.c
-- 
MST


