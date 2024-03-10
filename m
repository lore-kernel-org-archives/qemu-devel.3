Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05C94C54E58
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Mar 2024 11:09:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjH2K-0006wL-IA; Sun, 10 Mar 2024 07:08:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1rjH2I-0006vf-Ee; Sun, 10 Mar 2024 07:08:10 -0400
Received: from fout4-smtp.messagingengine.com ([103.168.172.147])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1rjH2F-0005jr-Vj; Sun, 10 Mar 2024 07:08:09 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailfout.nyi.internal (Postfix) with ESMTP id 616CF13800DF;
 Sun, 10 Mar 2024 07:08:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Sun, 10 Mar 2024 07:08:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1710068886; x=1710155286; bh=0SFqb9y2VAyLyJuqOKdJLmRbtBuy1NC6
 0h2FRjZ51dU=; b=M+CJDXY/gUViTB3GpIQt3Dsc3kmF+U7dCeg7VkiAUo+tVWPj
 MWhrVVYuX8xYgdnzl7kVbxR8wtSO39PJCo6q2nqV8Bsz0XfGu/YipQ599O55GGfa
 qUkxvyXMLzHHk/d32S28Eu7wFVDp7uDgubfiQpnz2N9R44qFEZRMxoqYPZ+ZDSF4
 1H6sf2ZNDKKVi6J4TE3IqUgqjYfQIq7e/PPe5oIyQTrWikplmxpTIfFXkXhJJ6EL
 JG2xPPqrrUzYGERALZS8rLrCrFsaXrJx77DoyoA/IgRSkh7/cFoSrJ9aKALjDK7g
 gDT+o4lLABVxjrOApcjglQGXDY6hKsazSgGt7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1710068886; x=
 1710155286; bh=0SFqb9y2VAyLyJuqOKdJLmRbtBuy1NC60h2FRjZ51dU=; b=Z
 QLd6klWoJ+EY3KefllnSPcK5ClmgD1a2nQpnFS+o8jfd2jqiZ2PPg3SqciyacUck
 D7Kpa2h9mK6lvPs5T8ze0ly7T6/20qt3NA5ps/pRm5jJK8EckbbwXUg5ze4g4HFn
 BTW2hb4MQihiQ5y3aGY6lQT0JR2S/q1Uxg1UTocLlQRweJW1BU2xiGe2jFmHLl1h
 BILTdYSyVSJguthtyV80FuB7nZBkhwzfDfa9qKN0wG8cwZqxkdC3cglWCLtg8j1Q
 Vb6GzyCXESb6ka20DZl24//JrfPgH2BKQ4XF0BvS3wBh7mJyvuIUZEbs//jVOcRg
 N9eN7za0x5nbOTJjOiy+A==
X-ME-Sender: <xms:lpTtZTqVv2kqSJHsTBTmhBD7uS_jjhGF8S92FIYPktK9hDVidQTiwA>
 <xme:lpTtZdrBEkw9wtDmqN-7ndeEF5n058Iu8wgH5hfSC-Q1_CpDY2niNr2hZALK0PY_H
 hxN1D_fFQ187oqmcgQ>
X-ME-Received: <xmr:lpTtZQO-fvbVAcvXYGVyWnNdxEmRPi95KfZplMDxr6yZFlvT2bW4PbuPV_nuaaS5QE55rjM9qV6iGDPBEQVV_gW1q-Vl_Bcdf5jqZhQOAPz1CFs8YhcdIM89AqYnulR-jszbugnPSdTEmA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrieelgddvgecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepmfhlrghu
 shculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrth
 htvghrnhepkeeivddtueehffefuddtleefkefhiedttdduveeggfffieetveffhfehgfeg
 hfffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
 htshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:lpTtZW4FVdzHkGTwSYta2ffzDb4O-ZKf0E2LOeNjLDxOc_b8grMsnQ>
 <xmx:lpTtZS7ov9QjBJl4x2CD_XPfTWNiWXAKi-Popvld1pTvJe2TlLNDNA>
 <xmx:lpTtZejLnW8o-U65GtiuAazFpMAS4ktATmtj9cTJ4KjTbCKhlCmX3A>
 <xmx:lpTtZfzhyIkiPL2tM2Gke1Qd93thZb0coq3sSl3D8mKjNU0WIjEUhg>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 10 Mar 2024 07:08:04 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
Date: Sun, 10 Mar 2024 12:07:26 +0100
Subject: [PATCH 2/2] hw/nvme: add machine compatibility parameter to enable
 msix exclusive bar
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240310-fix-msix-exclusive-bar-v1-2-4483205ae22e@samsung.com>
References: <20240310-fix-msix-exclusive-bar-v1-0-4483205ae22e@samsung.com>
In-Reply-To: <20240310-fix-msix-exclusive-bar-v1-0-4483205ae22e@samsung.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>
Cc: Julien Grall <julien@xen.org>, qemu-block@nongnu.org, 
 qemu-devel@nongnu.org, Klaus Jensen <k.jensen@samsung.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=5246; i=k.jensen@samsung.com; 
 h=from:subject:message-id;
 bh=9uo3sPb+8wSYBAmUxqXp5Y3ERqXL1eMHFsW6m+6U4ls=; 
 b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGXtlI6+LSVgiNcOCIe/wLYsnsGc/SgbEm7HA
 6DYAyUX3Xm6BIkBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJl7ZSOAAoJEE3hrzFt
 Tw3p7TsIALcs+HRK+UQqCdz+gvH1MfkGyKsZqrLOL9vnnLXxFUR491/bCVujLT6Adualp/WdYFR
 ZHW/JHZu7w9O/GqyDzRIAsMRUAbMDItC+qeoiFQzdLtv9BZEbviXDE8rI+rEyJZDtwL6D8yRPnH
 0miWkmvNObOFMG69IJVznHeGgkD8RL4qbu9A3vpuMiAPQBuQY6GAPFE+W1gKVPQm1XfTSbhg9H6
 nQegA800XsVYQKh7H424A7ycXQLTHDJkTsA0rPLlpeHb9NDmbVmHFSVc1gCj7Kg/bTT7TWw4G+y
 iZufSmITCV2xz3eB/w9h1FYRpfygY0qjDf5AXez+jqqAcWo1v/cocanG
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Received-SPF: pass client-ip=103.168.172.147; envelope-from=its@irrelevant.dk;
 helo=fout4-smtp.messagingengine.com
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

Reported-by: Julien Grall <julien@xen.org>
Tested-by: Julien Grall <julien@xen.org>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/core/machine.c |  1 +
 hw/nvme/ctrl.c    | 51 +++++++++++++++++++++++++++++++++++----------------
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
index 8cca8a762124..649467723e7e 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -7798,6 +7798,11 @@ static bool nvme_check_params(NvmeCtrl *n, Error **errp)
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
@@ -8101,24 +8106,36 @@ static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
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
@@ -8416,6 +8433,8 @@ static Property nvme_props[] = {
                       params.sriov_max_vi_per_vf, 0),
     DEFINE_PROP_UINT8("sriov_max_vq_per_vf", NvmeCtrl,
                       params.sriov_max_vq_per_vf, 0),
+    DEFINE_PROP_BOOL("msix-exclusive-bar", NvmeCtrl, params.msix_exclusive_bar,
+                     false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index 5f2ae7b28b9c..eccf14acc906 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -522,6 +522,7 @@ typedef struct NvmeParams {
     uint16_t sriov_vi_flexible;
     uint8_t  sriov_max_vq_per_vf;
     uint8_t  sriov_max_vi_per_vf;
+    bool     msix_exclusive_bar;
 } NvmeParams;
 
 typedef struct NvmeCtrl {

-- 
2.43.0


