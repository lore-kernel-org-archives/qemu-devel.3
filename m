Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94B77C87FD2
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 14:37:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhqnx-0000Id-Og; Fri, 01 Aug 2025 10:32:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uhqhL-0005QD-84
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 10:25:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uhqhE-0002fV-60
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 10:25:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754058317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XAofeyebdsGW/e1tEO4SwMiUgOjkX2ugMkQZdGR+eug=;
 b=cqVG3Hm4smQiVtZMXpvii7w8pUG0zc+Et8PnAeAv9JfNzRIRVGr3TFH2bXM2FNyWzpUr1p
 fr/WjUomVMQbgcg85pWvopCEK4wiyzKob/AVDTIpbt5RvdaZAqgemormUDl/+fMsTqq3Si
 jtaVjQUIENOc4hqLSDePvgVJR3HmF8k=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-7Iin7O9zMvuPNn94cOxXew-1; Fri, 01 Aug 2025 10:25:16 -0400
X-MC-Unique: 7Iin7O9zMvuPNn94cOxXew-1
X-Mimecast-MFC-AGG-ID: 7Iin7O9zMvuPNn94cOxXew_1754058315
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3b7806a620cso1006956f8f.3
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 07:25:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754058315; x=1754663115;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XAofeyebdsGW/e1tEO4SwMiUgOjkX2ugMkQZdGR+eug=;
 b=bjh6trpAKaelMm4Z8p0hi8ftK2Y5BT9ONKWhlV9bHEFXXgEyjRwRshbaUJduAlsm54
 upUKywHqmPEZGQLIti2YcrtQwWZHFaqrjrbSMH4xzZiBSQYvWHvfZ70S9xkbNQJxBhkk
 Ea58p200bL5z4kSTOZ+3YxKufaDxW4Cj3IaPz+Fu6CoQ8o2N93DkSWdohPK88sidn0kt
 SPX5oyoCorYyAsoRQEtFQULF1G0bQ1RqoPPTarZweM2NQ9Ge3C02SuHuP0/OrISmQNtG
 tzIXvhxPAI0Jyqys8yfWo/zjVkR3h8oKGSx5IU7ILEeDuuH/CcLBytGzQNknV1xClOod
 7S6A==
X-Gm-Message-State: AOJu0Yx2vxqlfb58qcE7OpLAOljXmP4q1ZECkcjOtL2rw/XGe+i5UzKw
 m4RGxeGLBI37FqXDZJH4dr68FW39dTTzFc9Hp8KpcYfctZ/BNhEQntBJHL2M1uXu52TB7vhAqL/
 XfYYHa2iXwgznpmfyHFUw6vDIkRiQbmuMMZumF7IDvedT7ozM9I5EeyxXih/Ug0xcmzReRJzoYL
 0x5OOOiKmg6m07U1sD/dNSrgyWBum/XXuh3w==
X-Gm-Gg: ASbGncvAGoj7DWc1JEui51Hjj/CXeytLzyRea6TdN66sSlxqMRstjLezt8HYBz3q/Lp
 syQg5OVwafekBUTWjGcNcjM3K31Hvbgoq3wBlq7eo/dlZu8kAPyr2ZAAsanVvUMOnNVTqnYP7vL
 M7CRIy3a8tNtGuYERycDAdRrXq8PGWyhbtHsP1ylaN3LtBDmgzOWqQ1cGTSGvVa6vAmlG1+0Y81
 BZxVVq+rsVkWuoWvp+ign3zDALZBQnJseiwh7G4NNNEZ3QyRZBYf8muKMKP3Q+b43HDloMbq4uH
 cDR1Rynh/dKQV5qlqDvnygCeva9u+IHs
X-Received: by 2002:a05:6000:400d:b0:3b7:9c79:32ac with SMTP id
 ffacd0b85a97d-3b79c793736mr5710368f8f.52.1754058314637; 
 Fri, 01 Aug 2025 07:25:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEis61ueW+ywVW6Av7emG/HqiyPD+2ig8hLB2lrqvDaVMqbSlRV6oOz625b0IBa4RM3u43c7g==
X-Received: by 2002:a05:6000:400d:b0:3b7:9c79:32ac with SMTP id
 ffacd0b85a97d-3b79c793736mr5710338f8f.52.1754058314096; 
 Fri, 01 Aug 2025 07:25:14 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c453ab0sm6197982f8f.44.2025.08.01.07.25.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 07:25:13 -0700 (PDT)
Date: Fri, 1 Aug 2025 10:25:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-stable@nongnu.org,
 Corentin BAYET <corentin.bayet@reversetactics.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 05/17] pcie_sriov: Fix configuration and state synchronization
Message-ID: <cad9aa6fbdccd95e56e10cfa57c354a20a333717.1754058276.git.mst@redhat.com>
References: <cover.1754058276.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1754058276.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Fix issues in PCIe SR-IOV configuration register handling that caused
inconsistent internal state due to improper write mask handling and
incorrect migration behavior.

Two main problems were identified:

1. VF Enable bit write mask handling:
   pcie_sriov_config_write() incorrectly assumed that its val parameter
   was already masked, causing it to ignore the actual write mask.
   This led to the VF Enable bit being processed even when masked,
   resulting in incorrect VF registration/unregistration. It is
   identified as CVE-2025-54567.

2. Migration state inconsistency:
   pcie_sriov_pf_post_load() unconditionally called register_vfs()
   regardless of the VF Enable bit state, creating inconsistent
   internal state when VFs should not be enabled. Additionally,
   it failed to properly update the NumVFs write mask based on
   the current configuration. It is identified as CVE-2025-54566.

Root cause analysis revealed that both functions relied on incorrect
special-case assumptions instead of properly reading and consuming
the actual configuration values. This change introduces a unified
consume_config() function that reads actual configuration values and
synchronize the internal state without special-case assumptions.

The solution only adds register read overhead in non-hot-path code
while ensuring correct SR-IOV state management across configuration
writes and migration scenarios.

Fixes: 5e7dd17e4348 ("pcie_sriov: Remove num_vfs from PCIESriovPF")
Fixes: f9efcd47110d ("pcie_sriov: Register VFs after migration")
Fixes: CVE-2025-54566
Fixes: CVE-2025-54567
Cc: qemu-stable@nongnu.org
Reported-by: Corentin BAYET <corentin.bayet@reversetactics.com>
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Message-Id: <20250727-wmask-v2-1-394910b1c0b6@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci/pcie_sriov.c | 42 +++++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index 3ad18744f4..8a4bf0d6f7 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -64,6 +64,27 @@ static void unregister_vfs(PCIDevice *dev)
     pci_set_word(dev->wmask + dev->exp.sriov_cap + PCI_SRIOV_NUM_VF, 0xffff);
 }
 
+static void consume_config(PCIDevice *dev)
+{
+    uint8_t *cfg = dev->config + dev->exp.sriov_cap;
+
+    if (pci_get_word(cfg + PCI_SRIOV_CTRL) & PCI_SRIOV_CTRL_VFE) {
+        register_vfs(dev);
+    } else {
+        uint8_t *wmask = dev->wmask + dev->exp.sriov_cap;
+        uint16_t num_vfs = pci_get_word(cfg + PCI_SRIOV_NUM_VF);
+        uint16_t wmask_val = PCI_SRIOV_CTRL_MSE | PCI_SRIOV_CTRL_ARI;
+
+        unregister_vfs(dev);
+
+        if (num_vfs <= pci_get_word(cfg + PCI_SRIOV_TOTAL_VF)) {
+            wmask_val |= PCI_SRIOV_CTRL_VFE;
+        }
+
+        pci_set_word(wmask + PCI_SRIOV_CTRL, wmask_val);
+    }
+}
+
 static bool pcie_sriov_pf_init_common(PCIDevice *dev, uint16_t offset,
                                       uint16_t vf_dev_id, uint16_t init_vfs,
                                       uint16_t total_vfs, uint16_t vf_offset,
@@ -416,30 +437,13 @@ void pcie_sriov_config_write(PCIDevice *dev, uint32_t address,
     trace_sriov_config_write(dev->name, PCI_SLOT(dev->devfn),
                              PCI_FUNC(dev->devfn), off, val, len);
 
-    if (range_covers_byte(off, len, PCI_SRIOV_CTRL)) {
-        if (val & PCI_SRIOV_CTRL_VFE) {
-            register_vfs(dev);
-        } else {
-            unregister_vfs(dev);
-        }
-    } else if (range_covers_byte(off, len, PCI_SRIOV_NUM_VF)) {
-        uint8_t *cfg = dev->config + sriov_cap;
-        uint8_t *wmask = dev->wmask + sriov_cap;
-        uint16_t num_vfs = pci_get_word(cfg + PCI_SRIOV_NUM_VF);
-        uint16_t wmask_val = PCI_SRIOV_CTRL_MSE | PCI_SRIOV_CTRL_ARI;
-
-        if (num_vfs <= pci_get_word(cfg + PCI_SRIOV_TOTAL_VF)) {
-            wmask_val |= PCI_SRIOV_CTRL_VFE;
-        }
-
-        pci_set_word(wmask + PCI_SRIOV_CTRL, wmask_val);
-    }
+    consume_config(dev);
 }
 
 void pcie_sriov_pf_post_load(PCIDevice *dev)
 {
     if (dev->exp.sriov_cap) {
-        register_vfs(dev);
+        consume_config(dev);
     }
 }
 
-- 
MST


