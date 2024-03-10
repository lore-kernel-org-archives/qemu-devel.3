Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 088BEC54E66
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Mar 2024 11:09:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjH2M-0006x8-5M; Sun, 10 Mar 2024 07:08:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1rjH2G-0006vH-LQ; Sun, 10 Mar 2024 07:08:08 -0400
Received: from fout4-smtp.messagingengine.com ([103.168.172.147])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1rjH2E-0005jg-2j; Sun, 10 Mar 2024 07:08:07 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailfout.nyi.internal (Postfix) with ESMTP id CD4CB13800DD;
 Sun, 10 Mar 2024 07:08:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute2.internal (MEProxy); Sun, 10 Mar 2024 07:08:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1710068883; x=1710155283; bh=Upf8CpzFUI+WdRdUtvXFwuCPSUcfE0L1
 ECwtVPfZpzQ=; b=X0cl4P+/YwSBLtx320+dVsQQ+JopR4sOSjdAB9GFbRaHuJU5
 p24apv04BWpFxOFWULzbetucz+ot0Jd+BxVOv+PYWSgXIiyhnUqn1QJ2kFHguG62
 dbAQnHojjl/53EkEneUq/PhhvPtfdKi1GAXMLNQKaGboAb8SUn+3PtJgvbGKlTPV
 JMHNZOp/W/OrcMc0ehNoZE22xo0KGR4smsNmgxxKzG5J50UR357p1Rqj66IZqrs1
 dYmpa9jKlKix1hFHj5sL7WLbaEjgF/UcPOMc7uHA44oV3oIwMMvlOICKb/gz2VI7
 BrozXqcXC0I0buSQX+l1y29L38mOG0Lx7jtFNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1710068883; x=
 1710155283; bh=Upf8CpzFUI+WdRdUtvXFwuCPSUcfE0L1ECwtVPfZpzQ=; b=i
 oXWbc8xXIV/NZ+JtLy6BiWAPQacQeOME/kefw8FZA8GUJvooTmKDzFhnhc6Xouxc
 rnu5FiZ+jIKxmzP9SpWF+nM18WLzve+x5GwCKMn6EYeybgfEkXuoiPgE8q8g40J6
 4eHvsPEyE6BoCnHCCkl7Maw0U32M4dWLZjaWpJHf/0Da/8YegrzBwIXaXAYGmf6z
 ARG3ZknO3c+CrcJFrPsOvtk1jNirOCEMTtjjrG+oJ+fGikE97nvmX3tvEjiAvSPA
 bhd3Cac1nmlqw7M62Wb89hEcJY5ICszpXqlJeVTnRpviMJff010rLHO0Nx0ymHJJ
 LzAIUxDAmYjTiWgHM7kbg==
X-ME-Sender: <xms:k5TtZU7FfbJ41A-WZ9w78vQZfISHgtcdsvz79zzO8-1rLBAgt2xbxw>
 <xme:k5TtZV4yr86KwR120E1abTRKu7sYX-A7mg9H0ZLGm35hpzxBjcRvF7S_xcChAAFXe
 58jz0Bhy_XcPemOX_Q>
X-ME-Received: <xmr:k5TtZTc-4VEjGJ_lqVSBEtt9dJD1vL6bkiiHa4z_E1PpJ35n-Ps0GrNLhIKkONk99auzq3CVS83PKsxbv6rsStH8QS2H8zZ7KS_MToobnIixhT1BKs_qYrxzGZHUmXdAhda_iqTGryzbyQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrieelgddvgecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepmfhlrghu
 shculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrth
 htvghrnhepkeeivddtueehffefuddtleefkefhiedttdduveeggfffieetveffhfehgfeg
 hfffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
 htshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:k5TtZZJTZIxHzF2nd7wuaBBm7PgPitv4xi3LSmXqFZdC8abZltuv2w>
 <xmx:k5TtZYKFqMwxiL89z28AGNYFlZnYWYgRDXPhbVXk-GiNv0ngBLjEqg>
 <xmx:k5TtZaxActx3LMIiPvbJ4slMPiC7On0aBGU0mr2sSvzQRLeViUbTuA>
 <xmx:k5TtZVB8IxfSSAws_Ri4Z34Wo6NUMzIQ-M2TWsH07tDQ6Uax6EWReA>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 10 Mar 2024 07:08:01 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
Date: Sun, 10 Mar 2024 12:07:25 +0100
Subject: [PATCH 1/2] hw/nvme: generalize the mbar size helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240310-fix-msix-exclusive-bar-v1-1-4483205ae22e@samsung.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2957; i=k.jensen@samsung.com; 
 h=from:subject:message-id;
 bh=UGT4RVyPNLmpbaSL/taqu08nT6+aLVpxbZ18bAMsmAY=; 
 b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGXtlI6KD4Aw+G5N9OMGGuBJvAAA84NmDZcQj
 CA2IfcePVFvOokBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJl7ZSOAAoJEE3hrzFt
 Tw3pzVwIAMGUCwpBbM8uBgWist6XPmUkXivbXBiNCo8LQc5srEiy24XE43MHOfZC3SJxmnjUjiY
 uhJBFf1LeF8J/C0ufb3KzVXIvsXH7Nb1fTPVIHC8xRpLxJvzivyc15gcKcJp+3RQuxlPMoF6/ee
 KT2MI/txgwPXEK4xhiCJHA/wt6e9Ey5jBWBsVwVYYWeZgVsc0IM4S61ZoxpwCh3s2TDG+DbzaVY
 MU1JMS1A8UNB1k7ODlajRBvI7KpbmWnLnvnWFI44BHJvKHF0fi/iSSQOrdtiND6jJfWLLR7G75S
 +P6oQ9Kgh2Zugc2W7SSK96bwwyNJtO3lXcz8fKq30nr25dpCArCF8aWB
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

Generalize the mbar size helper such that it can handle cases where the
MSI-X table and PBA are expected to be in an exclusive bar.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 76fe0397045b..8cca8a762124 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -8003,13 +8003,18 @@ static void nvme_init_pmr(NvmeCtrl *n, PCIDevice *pci_dev)
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
@@ -8024,11 +8029,10 @@ static uint64_t nvme_bar_size(unsigned total_queues, unsigned total_irqs,
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
@@ -8036,7 +8040,7 @@ static void nvme_init_sriov(NvmeCtrl *n, PCIDevice *pci_dev, uint16_t offset)
     uint16_t vf_dev_id = n->params.use_intel_id ?
                          PCI_DEVICE_ID_INTEL_NVME : PCI_DEVICE_ID_REDHAT_NVME;
     NvmePriCtrlCap *cap = &n->pri_ctrl_cap;
-    uint64_t bar_size = nvme_bar_size(le16_to_cpu(cap->vqfrsm),
+    uint64_t bar_size = nvme_mbar_size(le16_to_cpu(cap->vqfrsm),
                                       le16_to_cpu(cap->vifrsm),
                                       NULL, NULL);
 
@@ -8098,8 +8102,8 @@ static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
     }
 
     /* add one to max_ioqpairs to account for the admin queue pair */
-    bar_size = nvme_bar_size(n->params.max_ioqpairs + 1, n->params.msix_qsize,
-                             &msix_table_offset, &msix_pba_offset);
+    bar_size = nvme_mbar_size(n->params.max_ioqpairs + 1, n->params.msix_qsize,
+                              &msix_table_offset, &msix_pba_offset);
 
     memory_region_init(&n->bar0, OBJECT(n), "nvme-bar0", bar_size);
     memory_region_init_io(&n->iomem, OBJECT(n), &nvme_mmio_ops, n, "nvme",

-- 
2.43.0


