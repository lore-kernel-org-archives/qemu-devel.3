Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA704C3DA45
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 18:06:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRyAD-0007Iw-NF; Thu, 11 Jul 2024 14:05:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1sRyA4-0006yj-7B; Thu, 11 Jul 2024 14:04:56 -0400
Received: from fhigh5-smtp.messagingengine.com ([103.168.172.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1sRyA1-0003wj-32; Thu, 11 Jul 2024 14:04:54 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 5222F11406A8;
 Thu, 11 Jul 2024 14:04:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute3.internal (MEProxy); Thu, 11 Jul 2024 14:04:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1720721092; x=
 1720807492; bh=4HASoSfZRxPdg/HZsQNUQDHZWGxP6Kj4aXho5mhlYEo=; b=F
 BI0+5UGkx+eYnP/vmUZIlEd/YZiJBF2gtw4IbL1bO5SG6TMGaQQox0Sd2NJ4wkzY
 1yxKqB8X/FoIdTpXcq+jWs1Xr50zAJ4StIyF0DJy4ZS5XA3Y+cOTCgrB5/F7IUYG
 rJteg8nCBO0CrLC+z6KOL9gLax1yUZ+ss1bS8WP//rvlOOXlm2BmmRPv9XjMgy34
 O/uwRGvizcvk6m9Qt8TM9QsoD+NH/7JXrBHSOzgUvZT1IuYKVloZ9f48arNtmGMn
 9sXNhO0Wrn0oHgxBESD6mI3QCf4Mg984j6dhvXmUoXuc99NXEUo7CGwTtRpWvJQT
 NSQexcP5KCKoYh59giy1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1720721092; x=
 1720807492; bh=4HASoSfZRxPdg/HZsQNUQDHZWGxP6Kj4aXho5mhlYEo=; b=Z
 PXtczCd7qVmNQTiiApBcXjEh+BJzSt9P8n90LoCphJ9NTsl6yfXMtu5D97jImp/s
 M7a/cZYtRWGAHYspcWO0qAPjdAcY0kwEhtCwHJ+HFLlV+VwTYu1EAZI8TGhjTKvD
 26eUCuFgadBdJF0YBvn5X5WfiboUWmNkbPCuljhiqxV8zYjFfeQhl3ncppeKZWq2
 t1HG3dtNMoWQkCtKcHtVNiSmdqBPWuW14Ixksh8mybEZOwYbibGc5+a8Jh96VwM0
 5zNpTOa/xa4QDHZMHbXQOYuSv6FWlO4NkvlUhxesSueXevwJIyOFu9gIi3/LN9ZZ
 otGfPQ0ghoezdl4ZRq12A==
X-ME-Sender: <xms:wx6QZmyo_nGptHZbrj6q_hMnBZ6C0zMLxPchZodWCa9tylrASNZD4g>
 <xme:wx6QZiTaRIhz5LGqnYvGW662DZZIYynVIC22DqIkK8qVxzZ4tC8sfPxUIxwxj1q3T
 IbiWsWcjFpfY3BJcfc>
X-ME-Received: <xmr:wx6QZoWR3SlSSOTiuWuVsX1uPMjvwDz1qpiMwKjPNFN-IawNBAYmhonurAXoWy1EGc_FehgG7Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrfeeggdduvdduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghu
 shculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrth
 htvghrnhepjefgieelgfeiveehkeeuveehheekfeevgeeigfehfefgjeejhefffeegudej
 udegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
 htshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:wx6QZsjfk6XR5_ksOcPBEE1VPZx5UxXPRaXJtOQS7fDIJocMRFAKiQ>
 <xmx:wx6QZoC8p1Ng2nxWNFDKqrt3Sig9fEhoZkDryLas0Mh9t6VLyKwd9Q>
 <xmx:wx6QZtLerJjLuLsfcosIMTtDmnwE1RXIir1ne3Q8vDHqfl7TULgWZQ>
 <xmx:wx6QZvAcAUpj10iERP7_0ZD74H7pClkB4k-4ClN9NQCbWAfraMnq_w>
 <xmx:xB6QZsz1MzIJHdxa5a5K2MuDm_ka6KHPUP0RQSWbgT8LpLB2H7caX8RE>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jul 2024 14:04:49 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, Stefan Hajnoczi <stefanha@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>,
 Minwoo Im <minwoo.im@samsung.com>, Klaus Jensen <k.jensen@samsung.com>
Subject: [PULL 3/7] hw/nvme: fix BAR size mismatch of SR-IOV VF
Date: Thu, 11 Jul 2024 20:04:40 +0200
Message-ID: <20240711180436.8532-12-its@irrelevant.dk>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240711180436.8532-9-its@irrelevant.dk>
References: <20240711180436.8532-9-its@irrelevant.dk>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3605; i=k.jensen@samsung.com;
 h=from:subject; bh=ywvt19DaycrPLQkuZuEEUyxvLK5gVPKhT1LHVJGcO7E=;
 b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGaQHrVsA41B5SgfmIxk0DTZY68fp1c4Y3W9B
 sGFKD/4N86spIkBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJmkB61AAoJEE3hrzFt
 Tw3pOyEH/1zYW5Xl9xW2BWdhcZruugVIjhwj848zZ1vGdF0wItcCE1FIu8wM2WarG0dhGmly0Pp
 loo1nYrQPr3kKYMl8SKLsIEup2V+pntajoV11oeArKUaNA2wv8X4YUdouvjTgXmiXfJronHMi6W
 wH8goCoPdGfX8S61y4AXhJMUJIUOh3RSIOxPMeYDvgyTvzfVvmusbi7sh2fX1LO1MbrMddPbvaJ
 vDg3/R7yQaLVD3c9iYTBJ38NWJX2OLQjdmJhie5aEVgALtI8y7/aiNJMQ3g4VYumUI77/3qRnMw
 ICRHq+0LwljIC8yvJQXQj5vIq1iceFeYuWd1UZolCETkjioP+JsI1qSl
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.156; envelope-from=its@irrelevant.dk;
 helo=fhigh5-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Minwoo Im <minwoo.im@samsung.com>

PF initializes SR-IOV VF BAR0 region in nvme_init_sriov() with bar_size
calcaulted by Primary Controller Capability such as VQFRSM and VIFRSM
rather than `max_ioqpairs` and `msix_qsize` which is for PF only.

In this case, the bar size reported in nvme_init_sriov() by PF and
nvme_init_pci() by VF might differ especially with large number of
sriov_max_vfs (e.g., 127 which is curret maximum number of VFs).  And
this reports invalid BAR0 address of VFs to the host operating system
so that MMIO access will not be caught properly and, of course, NVMe
driver initialization is failed.

For example, if we give the following options, BAR size will be
initialized by PF with 4K, but VF will try to allocate 8K BAR0 size in
nvme_init_pci().

	#!/bin/bash

	nr_vf=$((127))
	nr_vq=$(($nr_vf * 2 + 2))
	nr_vi=$(($nr_vq / 2 + 1))
	nr_ioq=$(($nr_vq + 2))

	...

	-device nvme,serial=foo,id=nvme0,bus=rp2,subsys=subsys0,mdts=9,msix_qsize=$nr_ioq,max_ioqpairs=$nr_ioq,sriov_max_vfs=$nr_vf,sriov_vq_flexible=$nr_vq,sriov_vi_flexible=$nr_vi \

To fix this issue, this patch modifies the calculation of BAR size in
the PF and VF initialization by using different elements:

	PF: `max_ioqpairs + 1` with `msix_qsize`
	VF: VQFRSM with VIFRSM

Signed-off-by: Minwoo Im <minwoo.im@samsung.com>
Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 231e1127cec8..f3ae54896f6d 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -8104,6 +8104,7 @@ static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
     uint8_t *pci_conf = pci_dev->config;
     uint64_t bar_size;
     unsigned msix_table_offset = 0, msix_pba_offset = 0;
+    unsigned nr_vectors;
     int ret;
 
     pci_conf[PCI_INTERRUPT_PIN] = 1;
@@ -8136,9 +8137,19 @@ static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
         assert(n->params.msix_qsize >= 1);
 
         /* add one to max_ioqpairs to account for the admin queue pair */
-        bar_size = nvme_mbar_size(n->params.max_ioqpairs + 1,
-                                  n->params.msix_qsize, &msix_table_offset,
-                                  &msix_pba_offset);
+        if (!pci_is_vf(pci_dev)) {
+            nr_vectors = n->params.msix_qsize;
+            bar_size = nvme_mbar_size(n->params.max_ioqpairs + 1,
+                                      nr_vectors, &msix_table_offset,
+                                      &msix_pba_offset);
+        } else {
+            NvmeCtrl *pn = NVME(pcie_sriov_get_pf(pci_dev));
+            NvmePriCtrlCap *cap = &pn->pri_ctrl_cap;
+
+            nr_vectors = le16_to_cpu(cap->vifrsm);
+            bar_size = nvme_mbar_size(le16_to_cpu(cap->vqfrsm), nr_vectors,
+                                      &msix_table_offset, &msix_pba_offset);
+        }
 
         memory_region_init(&n->bar0, OBJECT(n), "nvme-bar0", bar_size);
         memory_region_init_io(&n->iomem, OBJECT(n), &nvme_mmio_ops, n, "nvme",
@@ -8152,7 +8163,7 @@ static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
                              PCI_BASE_ADDRESS_MEM_TYPE_64, &n->bar0);
         }
 
-        ret = msix_init(pci_dev, n->params.msix_qsize,
+        ret = msix_init(pci_dev, nr_vectors,
                         &n->bar0, 0, msix_table_offset,
                         &n->bar0, 0, msix_pba_offset, 0, errp);
     }
-- 
2.44.0


