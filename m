Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0968DC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 17:28:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk5ty-0002D2-RP; Tue, 12 Mar 2024 13:26:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1rk5tx-0002Be-2v; Tue, 12 Mar 2024 13:26:57 -0400
Received: from wfhigh5-smtp.messagingengine.com ([64.147.123.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1rk5tv-0005RA-HE; Tue, 12 Mar 2024 13:26:56 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailfhigh.west.internal (Postfix) with ESMTP id 9504D18000A1;
 Tue, 12 Mar 2024 13:26:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Tue, 12 Mar 2024 13:26:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1710264410; x=
 1710350810; bh=l9nOFDTS8LcbBpigNVpgDoOy5FiXsRfRuBjWwLRQY0I=; b=S
 7N1C5kdalO4O0XoT+CxkSWzlmUOMgFIPOstYSwUnVhsYsDKw5ssA/Gdp88iXm8Fw
 lB2y9R9ZfmWQYS1mrq+WjexOMTlgUcH/9E/4/0+TdySpUNDRluT1q7RfQMtMhjEM
 +0aIU10mD36wvxjNQ9V9zgdq6Wc9IWP89DaB9i89Cz7cEPfOaOnLXRZgqhOU6bKH
 mzl4FPdtLTcdXi6yaSXAIiFGS9eZcJ2A/F0nbJ8va5/i24FZCdLtaovx77BeSVHQ
 +PHR/d6dAtEZVv57+Ji9k9Q1bzTaD9V8P7yjZAEQGZcUk09dv+FBFMIOGLAwMpUh
 QXOupVz2MqJu7FJl3N2zA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1710264410; x=
 1710350810; bh=l9nOFDTS8LcbBpigNVpgDoOy5FiXsRfRuBjWwLRQY0I=; b=d
 KsVpAIBvxIw0IKfi1CMPoR157JcIdE0oGv/oWWnPboOj56AkABI1s2wJSGECqkwX
 T4tAhyP4+rZGronTSw+d5kdcVFiMp76qrXgHC5i+MyeZ1DrXbHVxlrj5y7Yo3nhe
 5vf4tiERxQMwTle7Y05KBvdRLZXbuGRJTHvpsWlN90bti5iWp4tdBzIlP80TnYjf
 h5DWdGPve8bbaqe7ns6/CF1gW1ePKvA+LETw5hpAHPwtPuns6z6Owl2wJTewrKrX
 WYvFcjyVjIAldpRD3pOK9lKeazioQTEhz5Io2DGTodinp6aXlADWsLiVDV4KzF14
 TEiomIgHY9sQykOnX5bvQ==
X-ME-Sender: <xms:WZDwZVMWSNxWCGC12UNZ7l3McY2osmMcLclUZ2GKFwInd3cGDjDEpw>
 <xme:WZDwZX8vOmUKBDwNZo3VdzeS8BuElC4H05JYPQ-jDNet_Eo1aKW0Gev5j3HcE1cxf
 BF15CiapR7_RrPSjKU>
X-ME-Received: <xmr:WZDwZUSr5kJD-zsDUAXF_QHWqifpxd-x058nN5FxTwq4oZjtOA-TF1yRn7JjT-jWFRFx5FAXBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeefgddutddtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghu
 shculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrth
 htvghrnhepjefgieelgfeiveehkeeuveehheekfeevgeeigfehfefgjeejhefffeegudej
 udegnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepih
 htshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:WZDwZRtwqdlw1sDSrJyRR5QtmDG0P_gDCF07uMi3zFbhm5oUpJa2tA>
 <xmx:WpDwZdfBBOdi-YFCccrDKmbs_sfQjX6PyxTOgCsyFQ-5Tdf2bPS77Q>
 <xmx:WpDwZd1OSEhDdy0O9TnadIumLaPNKhE0PJ351R8yV-iRo-ejWWW8YA>
 <xmx:WpDwZZ-z_Yk0rn5uaxEc40q7Y5-G8_fqdWHmhxGKSYeDctHziq9BOw>
 <xmx:WpDwZQ__7qFiRku3hTVcFDh7F2sESsW7bX-IXeus9mnaLOVQA1DKu3XCQz4>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Mar 2024 13:26:47 -0400 (EDT)
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
Subject: [PULL v2 5/6] hw/nvme: generalize the mbar size helper
Date: Tue, 12 Mar 2024 18:26:28 +0100
Message-ID: <20240312172622.58652-13-its@irrelevant.dk>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240312172622.58652-8-its@irrelevant.dk>
References: <20240312172622.58652-8-its@irrelevant.dk>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3393; i=k.jensen@samsung.com;
 h=from:subject; bh=0TYYe10yD0zFBG8lqqj25rVmuAAL5nlGUG9iJVrtEgQ=;
 b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGXwkD/fsWU05nSaixiusoIMgpY/o3B3kgsE8
 KK9R52un8IQXIkBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJl8JA/AAoJEE3hrzFt
 Tw3pPGcIALpyZbVg0KpU/83tO3MxBKN8mKUjCS+td9eODhAE5Gdj/4FdC5g1V9R3kCK22vsekQ1
 AnbxTy1Dm7XOypCcCl9UmeF6+3Ou3dm9TkJlIqK+0btulzKWYhzZCzPeR0PaxyFFYvRof2mTtxJ
 9Un+JEctAXPHWQNulz9dwpYTMM2dxeyncLZHZDueqquti5/4eO9CfrFMebQWZJh7NkkaN4rYobw
 Un+X6olrHbq60d4moBtcEALrJuWGQFKbgkeOW1ZvbX516n6bLM5wB7iqMdq7y+LAum7Bym6XZwF
 wqLDWBwZlYv+PaNbkJcLC4COH9zVfL7rQqdYkTRIfQf485ppjJsPIq57
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=64.147.123.156; envelope-from=its@irrelevant.dk;
 helo=wfhigh5-smtp.messagingengine.com
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
 hw/nvme/ctrl.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 6c5a2b875da8..efcfd7171066 100644
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
 
@@ -8087,7 +8091,7 @@ static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
     ERRP_GUARD();
     uint8_t *pci_conf = pci_dev->config;
     uint64_t bar_size;
-    unsigned msix_table_offset, msix_pba_offset;
+    unsigned msix_table_offset = 0, msix_pba_offset = 0;
     int ret;
 
     pci_conf[PCI_INTERRUPT_PIN] = 1;
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


