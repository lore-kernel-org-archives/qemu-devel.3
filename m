Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB186C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 19:14:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjl3z-00021u-81; Mon, 11 Mar 2024 15:11:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1rjl3x-00020y-Gn; Mon, 11 Mar 2024 15:11:53 -0400
Received: from wfout6-smtp.messagingengine.com ([64.147.123.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1rjl3o-0000FZ-SN; Mon, 11 Mar 2024 15:11:53 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailfout.west.internal (Postfix) with ESMTP id C1BE21C000C1;
 Mon, 11 Mar 2024 15:11:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute2.internal (MEProxy); Mon, 11 Mar 2024 15:11:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1710184299; x=
 1710270699; bh=36zri1GcmnYjWuiUbS/DYfGvFGJWspbBOoOk5UfdR7E=; b=s
 e842zXAkQwXLEME93dnaXMiaK8uWYAtr0NlTc8HsN4mASkE7ASqnZrX0pDHWsZKt
 h+f1pQMBPuVKV7szLczdFvj/6cqey9U2grRfq+JlraxyYmmAwTvgVbCEjAoRYIzA
 LDQUyNQhTLYhwta9vQTIpR4ffQS4FQCKOvaN3RslMvPvWNy68TUfDIGwGZE7dgLZ
 Gr81exfaObAIqqW9NCcY2ncM9w1N1W00XVGVACPC/82dHt6uU5ma8q7xUQCQqoPC
 HgOSdZPfeDf8thJU5Ickd2C8Edf5UNbkb7B6tnOHQTuY5w4H8gmx3muYYmDpcyd8
 42q+tU1RA2GtIjLkYWsNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1710184299; x=
 1710270699; bh=36zri1GcmnYjWuiUbS/DYfGvFGJWspbBOoOk5UfdR7E=; b=A
 bNfGGPEMdkWje1tib+Ms5vi4XCejX2Ghv1rqLjB4P2GHSv0PMWLMFepHevf2dS8E
 E6NNGoqlLEjzdc9Oh3RXM/Kul7G6PtIk2t3E5KyLFC7ULqqsAMdW3eYhV+oZje+b
 hEPtuiktgDjMmp1ldzOc2om/29fwEgz5RanznZjOOwO27EtHcPYR4yt+KQNQS5Fv
 b+739RbXcXJ9hrw9pUDuhULd1aAqXAqGnrxa0P52uR+cQzh6DcKp/o1c7KT6P7BO
 CVcelaD+mP8ptFR2QTNnzaRRmaqGDKuWmy4yTZ86OEMAOt2rU+7W2O3xcjSIxCfC
 vhkwjtk+QZHWp5wmowBow==
X-ME-Sender: <xms:a1fvZcx_GT9dlFvjb9QAKR3mNzl1uvf80T03-OheuD-DJfMsJ-jJ9A>
 <xme:a1fvZQTOssZqF6JX7i57ddSjNdKbNglOGCOW_Ya1HWizFZut9u7foxmFDkpP5iJf6
 IAA6gP7JJ-CgkRQqOM>
X-ME-Received: <xmr:a1fvZeWnSZr8cTSKr2n7DyH7FcAXQK9S54pUxBDC3q3Baj23TkpOqaSLERZDSByMfLAs8Q-Jdg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjedugdduvddvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghu
 shculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrth
 htvghrnhepjefgieelgfeiveehkeeuveehheekfeevgeeigfehfefgjeejhefffeegudej
 udegnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepih
 htshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:a1fvZaimM4ATGP_18mjzWmY7ARpAAsMfiiVnAZnYyGKfkAIdHsjIuw>
 <xmx:a1fvZeCp3IyfedGQSD0FKrtarM2RF3tZE7CwZoZ2h3aosUzwbe30mg>
 <xmx:a1fvZbIw-pU1GRItSEs_WBlRKPQZH4JsjPTHSmaD9S6aRwqAqnbUIA>
 <xmx:a1fvZa4taWyx3huJT2SwNCEfo27GrPTE5xokOQquvYlCK5rGWohXMtK2S_g>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Mar 2024 15:11:34 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-stable@nongnu.org
Subject: [PULL 5/6] hw/nvme: generalize the mbar size helper
Date: Mon, 11 Mar 2024 20:11:11 +0100
Message-ID: <20240311191105.35224-13-its@irrelevant.dk>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240311191105.35224-8-its@irrelevant.dk>
References: <20240311191105.35224-8-its@irrelevant.dk>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3040; i=k.jensen@samsung.com;
 h=from:subject; bh=Iu1VY7eu1syRxpCgT+eHNq1QL+mThEly36cgVUNqMKI=;
 b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGXvV0qSCft48nMy3ACHXN/+RxYPNlwhF548q
 DRQl9v8WhXVoYkBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJl71dKAAoJEE3hrzFt
 Tw3pbuoH/3Eydkwv8kCZaQ2el3T6HPvbGawBnQr+DpIMA94jzhd8bN/pBdUExLm1mhjVIOVvuGi
 GyUbDvjv32cmGgSef/UD5tGXs8fK3LH86/gOZwWItVz6R3ocDeX89t3IKePxApi1LFKx1t5vgln
 vl1lGWH6xOCiiLQwzsnNbUChix8xfPXG+DFtcEEDaKYou5KoxdvuXGqqiMrWPRR8UOBH5D3cxHJ
 aGOCg2ff/d6K9C7n4/lrLMMQChO36UTHqelp44SJkz1APUCeJRwjXzrHTYjqWRG7ZMZcm8Nirv8
 Z47njuy87YQjchm0eq0tw0N8ZveJt3okDHa2J2fW6FWB9V0bGgu0iKfW
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=64.147.123.149; envelope-from=its@irrelevant.dk;
 helo=wfout6-smtp.messagingengine.com
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

Generalize the mbar size helper such that it can handle cases where the
MSI-X table and PBA are expected to be in an exclusive bar.

Cc: qemu-stable@nongnu.org
Reviewed-by: Jesper Wendel Devantier <foss@defmacro.it>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 6c5a2b875da8..5ee8deda22a4 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -8015,13 +8015,18 @@ static void nvme_init_pmr(NvmeCtrl *n, PCIDevice *pci_dev)
     memory_region_set_enabled(&n->pmr.dev->mr, false);
 }
 
-static uint64_t nvme_bar_size(unsigned total_queues, unsigned total_irqs,
-                              unsigned *msix_table_offset,
-                              unsigned *msix_pba_offset)
+static uint64_t nvme_mbar_size(unsigned total_queues, unsigned total_irqs,
+                               unsigned *msix_table_offset,
+                               unsigned *msix_pba_offset)
 {
-    uint64_t bar_size, msix_table_size, msix_pba_size;
+    uint64_t bar_size, msix_table_size;
 
     bar_size = sizeof(NvmeBar) + 2 * total_queues * NVME_DB_SIZE;
+
+    if (total_irqs == 0) {
+        goto out;
+    }
+
     bar_size = QEMU_ALIGN_UP(bar_size, 4 * KiB);
 
     if (msix_table_offset) {
@@ -8036,11 +8041,10 @@ static uint64_t nvme_bar_size(unsigned total_queues, unsigned total_irqs,
         *msix_pba_offset = bar_size;
     }
 
-    msix_pba_size = QEMU_ALIGN_UP(total_irqs, 64) / 8;
-    bar_size += msix_pba_size;
+    bar_size += QEMU_ALIGN_UP(total_irqs, 64) / 8;
 
-    bar_size = pow2ceil(bar_size);
-    return bar_size;
+out:
+    return pow2ceil(bar_size);
 }
 
 static void nvme_init_sriov(NvmeCtrl *n, PCIDevice *pci_dev, uint16_t offset)
@@ -8048,7 +8052,7 @@ static void nvme_init_sriov(NvmeCtrl *n, PCIDevice *pci_dev, uint16_t offset)
     uint16_t vf_dev_id = n->params.use_intel_id ?
                          PCI_DEVICE_ID_INTEL_NVME : PCI_DEVICE_ID_REDHAT_NVME;
     NvmePriCtrlCap *cap = &n->pri_ctrl_cap;
-    uint64_t bar_size = nvme_bar_size(le16_to_cpu(cap->vqfrsm),
+    uint64_t bar_size = nvme_mbar_size(le16_to_cpu(cap->vqfrsm),
                                       le16_to_cpu(cap->vifrsm),
                                       NULL, NULL);
 
@@ -8110,8 +8114,8 @@ static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
     }
 
     /* add one to max_ioqpairs to account for the admin queue pair */
-    bar_size = nvme_bar_size(n->params.max_ioqpairs + 1, n->params.msix_qsize,
-                             &msix_table_offset, &msix_pba_offset);
+    bar_size = nvme_mbar_size(n->params.max_ioqpairs + 1, n->params.msix_qsize,
+                              &msix_table_offset, &msix_pba_offset);
 
     memory_region_init(&n->bar0, OBJECT(n), "nvme-bar0", bar_size);
     memory_region_init_io(&n->iomem, OBJECT(n), &nvme_mmio_ops, n, "nvme",
-- 
2.44.0


