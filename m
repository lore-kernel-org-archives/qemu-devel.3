Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63949C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 19:19:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjl3v-0001ym-8E; Mon, 11 Mar 2024 15:11:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1rjl3u-0001xC-93; Mon, 11 Mar 2024 15:11:50 -0400
Received: from wfhigh7-smtp.messagingengine.com ([64.147.123.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1rjl3s-0000HJ-Cg; Mon, 11 Mar 2024 15:11:49 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailfhigh.west.internal (Postfix) with ESMTP id 8483418000C7;
 Mon, 11 Mar 2024 15:11:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Mon, 11 Mar 2024 15:11:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1710184305; x=
 1710270705; bh=xeaA3B6nNY/auJAWVa8Kj/VA+ZcJ5c0DXgBvsxcQDFI=; b=C
 vjEt6JBG/iXmr/j6d7WgoSOJqo0qfJZJo2u+c3ReJI52cE8q7xKKQ/DtjZ+Hoh3d
 oL9DCQSJ+pP0TB01WkipVhjRHfBkXVDyGTo7v2J49My/xQ+bB3Y90ugVN9IjBG9Q
 jM4rBd2z50iuC7wau80DItFwjkLta00CerDGwFb4qtQ5nd3HyyrymzC2JvQ2/MV7
 IXkaMGRKuq4r68ewZC83qa9CQBuijSZ2g/YlTAwMgy0catsMjjGvYivyprGIyq+C
 IvZpRH4EFUVNbEi90EBTP3mQioZQDdK9Umac9Tc84oA9/VGaViWcb24B0gW1PG47
 6wkdoqqmpDJKqZsaUPYYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1710184305; x=
 1710270705; bh=xeaA3B6nNY/auJAWVa8Kj/VA+ZcJ5c0DXgBvsxcQDFI=; b=N
 uPp4nFgAuFjAaiUx6MDiDeiXFlyoVBltkZryDS0magcgPxfeU/+ddpYvc8scpFe5
 2azn93tzr5Yv5MyRyLChbsENAu2w+IBiYc99qMbHG9GHKFr1W9EEaN3tLXiEdfqj
 DcNOQKZ3TKPEcugk63YU1p5nGlGR2lQTg64sVbo45dPjomnhf9dlmOlhEh/SZVZ8
 uOS0NpSH27jSyz5uu5P3oDqC4jlbDnk/X4fONaJqIfRT3GeV4qlZELMTeahYmQD9
 IzbNWGENMYJZiaig24uXBkeDllhB59aWu3gZsxbupS45Y/1YjKHCwCWYtjlpyV5i
 Hzp5qEhdfD3qb/4Oqom4A==
X-ME-Sender: <xms:cFfvZdPqYEYIAXkNWrkeKlvBWYYsXrnpOhb2mfiDkaIGePT2wCdHyw>
 <xme:cFfvZf-pt8aGhDcmXVTqKEWLyVGkA0yrN07ztj8CNVsaaa7TdY1mbn-OHV-XTmxbh
 r5XNDFoNGHe5Jgts90>
X-ME-Received: <xmr:cFfvZcTTYm8MB0ATcdQiE5EPgZDKcqpmhZ-lElC8r4NAqw7nsv74n6hiHcndLdcIqNqAxiOaDg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjedugdduvddvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghu
 shculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrth
 htvghrnhepfeehteeghefffeegkefghfegieejkeevfffhjeevfeekudeiieevheetledu
 jedunecuffhomhgrihhnpehgihhtlhgrsgdrtghomhenucevlhhushhtvghrufhiiigvpe
 dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:cFfvZZuu6awXmyYPoMVRnSRaE1MaNAC4wyn3fhWBQDkalRoCFS671A>
 <xmx:cFfvZVdehi9o50YkCb5L6kDlVybnCts8J9lUVDs_VyHyG26eZpFbDw>
 <xmx:cFfvZV3xEuBXR7EgS0MlyYne20KeEuL3cHKaZHGEMOHErVrXxxzzoQ>
 <xmx:cVfvZT0qvQSoxcVO5BXeRP4U7JiUwIzHF0yjr2_NoYLf1QxJ1nhJsded0FI>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Mar 2024 15:11:41 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-stable@nongnu.org
Subject: [PULL 6/6] hw/nvme: add machine compatibility parameter to enable
 msix exclusive bar
Date: Mon, 11 Mar 2024 20:11:12 +0100
Message-ID: <20240311191105.35224-14-its@irrelevant.dk>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240311191105.35224-8-its@irrelevant.dk>
References: <20240311191105.35224-8-its@irrelevant.dk>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5456; i=k.jensen@samsung.com;
 h=from:subject; bh=VqY3EtATqGmHEXsM4cSzQzUsetHUMxEPWtYmWwRlFv0=;
 b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGXvV0t6sqi1p7GZ31HnHJuxtH6FO3kVtfuEN
 hG0K8k+0rBV64kBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJl71dLAAoJEE3hrzFt
 Tw3p2joIAKMI14iaH11KGkUQsYXpXugMbyq/IjUbm6DH15yDLkQfpOKEKC+pl+VI/uP2poUawiT
 qz6l+ZLQq6HWmwQzTC5wqCUGQemCQl+kFl6aV56GETKw4EiEEiWq0/XADPVb/XkC0ekneK80opL
 XAlS71gE9HgGxAZGCwOa+23hvnwxAPE+l0d8JjM1fDpGq+F8FF+CqcFbBGCM75qfefMykxKlqIq
 cZnNhLwkD4XZbSyjL9HGW+tEGot+qI7PwmlISmeyDxElZEtS6VMypzoy3DqXYyttLYt+nykgGQa
 FifLb6updP5Rwixyk8El1PwhTRVRx8KDe/fO0hqAU0pUFYrIwtgNjagz
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=64.147.123.158; envelope-from=its@irrelevant.dk;
 helo=wfhigh7-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Klaus Jensen <k.jensen@samsung.com>

Commit 1901b4967c3f ("hw/block/nvme: move msix table and pba to BAR 0")
moved the MSI-X table and PBA to BAR 0 to make room for enabling CMR and
PMR at the same time. As reported by Julien Grall in #2184, this breaks
migration through system hibernation.

Add a machine compatibility parameter and set it on machines pre 6.0 to
enable the old behavior automatically, restoring the hibernation
migration support.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2184
Fixes: 1901b4967c3f ("hw/block/nvme: move msix table and pba to BAR 0")
Reported-by: Julien Grall julien@xen.org
Tested-by: Julien Grall julien@xen.org
Reviewed-by: Jesper Wendel Devantier <foss@defmacro.it>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/core/machine.c |  1 +
 hw/nvme/ctrl.c    | 51 ++++++++++++++++++++++++++++++++---------------
 hw/nvme/nvme.h    |  1 +
 3 files changed, 37 insertions(+), 16 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 9ac5d5389a6c..f3012bca1370 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -100,6 +100,7 @@ GlobalProperty hw_compat_5_2[] = {
     { "PIIX4_PM", "smm-compat", "on"},
     { "virtio-blk-device", "report-discard-granularity", "off" },
     { "virtio-net-pci-base", "vectors", "3"},
+    { "nvme", "msix-exclusive-bar", "on"},
 };
 const size_t hw_compat_5_2_len = G_N_ELEMENTS(hw_compat_5_2);
 
diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 5ee8deda22a4..6210b7098845 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -7810,6 +7810,11 @@ static bool nvme_check_params(NvmeCtrl *n, Error **errp)
     }
 
     if (n->pmr.dev) {
+        if (params->msix_exclusive_bar) {
+            error_setg(errp, "not enough BARs available to enable PMR");
+            return false;
+        }
+
         if (host_memory_backend_is_mapped(n->pmr.dev)) {
             error_setg(errp, "can't use already busy memdev: %s",
                        object_get_canonical_path_component(OBJECT(n->pmr.dev)));
@@ -8113,24 +8118,36 @@ static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
         pcie_ari_init(pci_dev, 0x100);
     }
 
-    /* add one to max_ioqpairs to account for the admin queue pair */
-    bar_size = nvme_mbar_size(n->params.max_ioqpairs + 1, n->params.msix_qsize,
-                              &msix_table_offset, &msix_pba_offset);
-
-    memory_region_init(&n->bar0, OBJECT(n), "nvme-bar0", bar_size);
-    memory_region_init_io(&n->iomem, OBJECT(n), &nvme_mmio_ops, n, "nvme",
-                          msix_table_offset);
-    memory_region_add_subregion(&n->bar0, 0, &n->iomem);
-
-    if (pci_is_vf(pci_dev)) {
-        pcie_sriov_vf_register_bar(pci_dev, 0, &n->bar0);
-    } else {
+    if (n->params.msix_exclusive_bar && !pci_is_vf(pci_dev)) {
+        bar_size = nvme_mbar_size(n->params.max_ioqpairs + 1, 0, NULL, NULL);
+        memory_region_init_io(&n->iomem, OBJECT(n), &nvme_mmio_ops, n, "nvme",
+                              bar_size);
         pci_register_bar(pci_dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY |
-                         PCI_BASE_ADDRESS_MEM_TYPE_64, &n->bar0);
+                         PCI_BASE_ADDRESS_MEM_TYPE_64, &n->iomem);
+        ret = msix_init_exclusive_bar(pci_dev, n->params.msix_qsize, 4, errp);
+    } else {
+        /* add one to max_ioqpairs to account for the admin queue pair */
+        bar_size = nvme_mbar_size(n->params.max_ioqpairs + 1,
+                                  n->params.msix_qsize, &msix_table_offset,
+                                  &msix_pba_offset);
+
+        memory_region_init(&n->bar0, OBJECT(n), "nvme-bar0", bar_size);
+        memory_region_init_io(&n->iomem, OBJECT(n), &nvme_mmio_ops, n, "nvme",
+                              msix_table_offset);
+        memory_region_add_subregion(&n->bar0, 0, &n->iomem);
+
+        if (pci_is_vf(pci_dev)) {
+            pcie_sriov_vf_register_bar(pci_dev, 0, &n->bar0);
+        } else {
+            pci_register_bar(pci_dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY |
+                             PCI_BASE_ADDRESS_MEM_TYPE_64, &n->bar0);
+        }
+
+        ret = msix_init(pci_dev, n->params.msix_qsize,
+                        &n->bar0, 0, msix_table_offset,
+                        &n->bar0, 0, msix_pba_offset, 0, errp);
     }
-    ret = msix_init(pci_dev, n->params.msix_qsize,
-                    &n->bar0, 0, msix_table_offset,
-                    &n->bar0, 0, msix_pba_offset, 0, errp);
+
     if (ret == -ENOTSUP) {
         /* report that msix is not supported, but do not error out */
         warn_report_err(*errp);
@@ -8434,6 +8451,8 @@ static Property nvme_props[] = {
                       params.sriov_max_vi_per_vf, 0),
     DEFINE_PROP_UINT8("sriov_max_vq_per_vf", NvmeCtrl,
                       params.sriov_max_vq_per_vf, 0),
+    DEFINE_PROP_BOOL("msix-exclusive-bar", NvmeCtrl, params.msix_exclusive_bar,
+                     false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index 392c02942682..bed8191bd5fd 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -536,6 +536,7 @@ typedef struct NvmeParams {
     uint16_t sriov_vi_flexible;
     uint8_t  sriov_max_vq_per_vf;
     uint8_t  sriov_max_vi_per_vf;
+    bool     msix_exclusive_bar;
 } NvmeParams;
 
 typedef struct NvmeCtrl {
-- 
2.44.0


