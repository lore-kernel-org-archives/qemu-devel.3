Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94C43C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 17:28:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk5u3-0002Ez-UH; Tue, 12 Mar 2024 13:27:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1rk5tz-0002EX-Fz; Tue, 12 Mar 2024 13:26:59 -0400
Received: from wfout4-smtp.messagingengine.com ([64.147.123.147])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1rk5tx-0005Tf-I3; Tue, 12 Mar 2024 13:26:59 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailfout.west.internal (Postfix) with ESMTP id 8EA2C1C000B1;
 Tue, 12 Mar 2024 13:26:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Tue, 12 Mar 2024 13:26:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1710264414; x=
 1710350814; bh=JKnGlfO0W7+PIXDSveDO2EZeh/9I2JiRCj4XnWkBROk=; b=I
 m81mzWgHNoCNANvyZmvyVHGvhf+Rcg1Yqp6xCwUVcsoPrNeU+5LVdwAvvKinuWn0
 D2VECzmAx5mRPjbt7CzZtEfvAAsx+k4ZxJsjcXxRvVYPpExJADcjt8kxoF6xOFnS
 sugkg8QLk8Fw2SmFrbQUBwx6A4qZoI99GAsWZeA5w7Pq8ehCqMfIQvTDvmE3SSjW
 3mEEwM6E6hmGfURJ2D5RX5OLv5ryzMtDxS1MyGvFkN03hr3CMVecL21Vle5z3pJ7
 BXFaPy9ZA1vdvxB5/W+YI743APb02uSReIk7NnwDl64UGwl/0+66G/lFwX1NgXO4
 crqms0+cwuFUdUxuZconw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1710264414; x=
 1710350814; bh=JKnGlfO0W7+PIXDSveDO2EZeh/9I2JiRCj4XnWkBROk=; b=J
 4oObXhZyML6rx3yhG9OVq2o0CXzRtGw/sK+mPulM8Xkh49QB/cJnqfsh6gos1KzY
 KuAD3rBXCy/7RQznwQz0w3/4HoceuZb8XNrqdWZMW7KH4IVuu6YauVckaqD36yLY
 EVAbEETYlHYxq8JOKrVg9CUZ8SI289IcbKYPoyoIVYQa0jfs3VwhKpk83Vc9urgN
 ojpiASQZ8IjJlk9TEBZ+piM3HtWW6OJWlpv7ZGL2o9slyKIsRi7xlmPrIzHRsShA
 bDhKPApPo16IH7/1LYEsLBUfI8a0WyrBtyNOQmrWl7J+qC/8yi2C/enOoX6tUOjb
 vvkwrRnTFsiOSF15eghFA==
X-ME-Sender: <xms:XZDwZRMUYEBkBKO5yRruIiR7Nx7njornBIpUSYgVh6ANIdai5Jpkhw>
 <xme:XZDwZT-6a_7y8ekdZqVdC9xOid_SxLfKorpLIqsDL50Bebjxt26ROZnHRvpal4UoN
 daozDHDAjW4QzaYZ28>
X-ME-Received: <xmr:XZDwZQQ_p2gHKNfEONGqCawGWphQoMZ0WVR0_j_jtJ4eecLKD022Sx6R26gF-gRKTrDNPAotEw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeefgddutddtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghu
 shculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrth
 htvghrnhepfeehteeghefffeegkefghfegieejkeevfffhjeevfeekudeiieevheetledu
 jedunecuffhomhgrihhnpehgihhtlhgrsgdrtghomhenucevlhhushhtvghrufhiiigvpe
 dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:XZDwZdvYZqYh0NaO6o94-aj3gVWgiYPvGMI3avEntBwyet8OknpjyQ>
 <xmx:XZDwZZfbxlD0qQf5o_brRvQ9AuKlRrAxp45MOK03je9GCIfft95scw>
 <xmx:XZDwZZ3FD_B2yi0Mfp7ETfdwQ2zbQ0Wg_LMn2RK5ZlBunHR5SMZOcA>
 <xmx:XZDwZV_DmydbJZEsQDkIY33RwLKpS9SL9xxDqZUaXECmmn-RdeUB3Q>
 <xmx:XpDwZc_jmG_I5qFnVk6kIFQ7XkG4l5iM_DiEwHBb46GD9x5FlCd1miJ66-M>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Mar 2024 13:26:51 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, qemu-block@nongnu.org,
 Yanan Wang <wangyanan55@huawei.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jesper Devantier <foss@defmacro.it>, Klaus Jensen <k.jensen@samsung.com>,
 qemu-stable@nongnu.org
Subject: [PULL v2 6/6] hw/nvme: add machine compatibility parameter to enable
 msix exclusive bar
Date: Tue, 12 Mar 2024 18:26:29 +0100
Message-ID: <20240312172622.58652-14-its@irrelevant.dk>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240312172622.58652-8-its@irrelevant.dk>
References: <20240312172622.58652-8-its@irrelevant.dk>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5504; i=k.jensen@samsung.com;
 h=from:subject; bh=9U433+XAOj8OOfgXrbOWFIMp7VQJFrBKGigW0tpjK0U=;
 b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGXwkD9vpQchn3rz4O1XZWmjXX07vy2yxb+Q5
 /OkSKbyWV6rDYkBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJl8JA/AAoJEE3hrzFt
 Tw3pPCIIAMTaM2k0OnU5sQ0uriYlBy2U8V/C6bLEA2/TChnho6Qt7+kH24vCJLuBqnVN3lBQw/K
 as8K6P9dcwxnZKJNbhPA4OujCBSzRWIlchvUrrNThlapDDv4Nbm+nSYWDYdvCQ9d8PcmMxy4dio
 iPzVuQ72ZHLhM6zY5XTrrIOWl3vXDE9Bhddr+C73WPrVNA4Pv4BRA0cO70kQzs9Ne1xnSHfGNzb
 USkaO+GRBFp0h8dbWaH9rPEHmNxYxq76FWguGQHSFNkgCX8HP3YViLOeCZoomP8DY2rf/ltZfFe
 ByZQ0HsbnY1Ao4XzCKOwD3B08pl5Gh+uKmeRr4If1D67Ir/vUEvZfKu2
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=64.147.123.147; envelope-from=its@irrelevant.dk;
 helo=wfout4-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
 hw/nvme/ctrl.c    | 53 +++++++++++++++++++++++++++++++++--------------
 hw/nvme/nvme.h    |  1 +
 3 files changed, 39 insertions(+), 16 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 0e9d646b61e1..37e5d4c8dfd5 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -102,6 +102,7 @@ GlobalProperty hw_compat_5_2[] = {
     { "PIIX4_PM", "smm-compat", "on"},
     { "virtio-blk-device", "report-discard-granularity", "off" },
     { "virtio-net-pci-base", "vectors", "3"},
+    { "nvme", "msix-exclusive-bar", "on"},
 };
 const size_t hw_compat_5_2_len = G_N_ELEMENTS(hw_compat_5_2);
 
diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index efcfd7171066..036b15403a02 100644
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
@@ -8113,24 +8118,38 @@ static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
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
+        assert(n->params.msix_qsize >= 1);
+
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
@@ -8434,6 +8453,8 @@ static Property nvme_props[] = {
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


