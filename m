Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA76DD49205
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 10:16:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCymt-0005MQ-Oo; Mon, 18 Nov 2024 05:15:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1tCyml-0005KH-0c; Mon, 18 Nov 2024 05:15:11 -0500
Received: from fout-b4-smtp.messagingengine.com ([202.12.124.147])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1tCymj-0008JJ-0E; Mon, 18 Nov 2024 05:15:10 -0500
Received: from phl-compute-06.internal (phl-compute-06.phl.internal
 [10.202.2.46])
 by mailfout.stl.internal (Postfix) with ESMTP id D84AE114019B;
 Mon, 18 Nov 2024 05:15:06 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Mon, 18 Nov 2024 05:15:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm2;
 t=1731924906; x=1732011306; bh=eoIJIsnvFSmFZxfkto+eSSz3zEqn6zFD
 3WOe+enxcsk=; b=AbI5Eh5gsxlXDeeJxVLVe8MqoKTBLKSlM2F347mvpNLAtDMS
 g0aBQjUOYn2IdGXY6vj9bmun2xzoDnqqiMNPWfSG1twKdPa2Hz1PEG8M+twbQ8NB
 L9KgvhmWnsUThvEV8yE1dtbPoTthnSbCbCOh2AA65Ewi2Txwu0sdXlCXp9fVsUCd
 N87r8dF0Yx0bkNdOqfV6CvRHwLzWd373E+LeBiiTIWoc3aYqnbMZxghLWie+6NV2
 U/MZAQy9YrCvUy0C1/9GFChuu8S2yAjnOoNDug0pKOwC5yjja5wTWlCqkjisBVBN
 5LixriF+Yxhc4tK51d/4fmESEzSY4n1Z+Qj4MA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731924906; x=
 1732011306; bh=eoIJIsnvFSmFZxfkto+eSSz3zEqn6zFD3WOe+enxcsk=; b=N
 vTVA9TvHGCI7Il99oiyx1jQC9Yzt4u6Kdp+PQp8dTbWwEmvDDmgR6Sqa+FlxbEfx
 yutUu2ZofJBEhbGrR031JLsGmjzWeaS2opAPdnfvr4kHtJPVYFrNR2SG/8ps4EV+
 r7AeVwCa9rHluWOelfSM5ooZ5ZoxWf0Alg5fIwY4mwvKhgVgiiq7XTD4rLObRNjl
 wXDXmpzPke2ugbHqQCT3Mq18wg7qrl/Z1tgGv96H3h/wtnMsmAPlRMu2Vl6naV7k
 YoX6aVoTseJ7Hem7Oymzmy+zgs27QgGwZTLaJr3S8YLZauCRKqDqUAzeGozY5HOH
 XTq3rtk0oqT5mNwBzsagA==
X-ME-Sender: <xms:qhM7Z4iy5SJy01N4_TntCmNlzRFZBarokUdr2DxEsWIUBirX9fxFuQ>
 <xme:qhM7ZxBQiQfDKwiAe9ybggo6YRSd2Gi1SwfVqEp4OOeXsEbC8WPkBBgFjGnR9M2eT
 8OOaDMV_3wVyM-4RFA>
X-ME-Received: <xmr:qhM7ZwHPhTlLaemNA-jLPc1LqYmYboPdKNsHGt5c5Ik3kBiGPmeeroFRPfFUxUWp8qms1WryZ7AznWP0TmOuZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfedtgdduvdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
 tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
 hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
 ucfhrhhomhepmfhlrghushculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrd
 gukheqnecuggftrfgrthhtvghrnhepkeeivddtueehffefuddtleefkefhiedttdduveeg
 gfffieetveffhfehgfeghfffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
 hmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukhdpnhgspghrtghpthht
 ohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepfhhoshhsseguvghfmhgrtg
 hrohdrihhtpdhrtghpthhtohepihhtshesihhrrhgvlhgvvhgrnhhtrdgukhdprhgtphht
 thhopehqvghmuhdqshhtrggslhgvsehnohhnghhnuhdrohhrghdprhgtphhtthhopehqvg
 hmuhdqsghlohgtkhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepkhgsuhhstghhsehk
 vghrnhgvlhdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurd
 horhhgpdhrtghpthhtohepkhdrjhgvnhhsvghnsehsrghmshhunhhgrdgtohhm
X-ME-Proxy: <xmx:qhM7Z5R1w62M2tgJNQ7hOYJJ8EZy0GoyauBK6NyPa7mYTfUzvM8QwQ>
 <xmx:qhM7Z1zMj5DnGT-W5EKqNXiTEtMzB3KXEsgKpVrPlK2YZbXaJACdWQ>
 <xmx:qhM7Z35Hi2zoHq0FhSL5nD9psmhZaw8f81RB5eCoiDvyWf8a7qXQew>
 <xmx:qhM7Zyw2TvhH4Wiqgv03U-cJ2fpb7hwN7lopTzrKfPvFG-CbsaO4Yw>
 <xmx:qhM7Z0z-JjatHYWclbAjEUqcX9aJAMYkosOB7Pi-Y9wrAPC7TVHhPeM9>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Nov 2024 05:15:05 -0500 (EST)
From: Klaus Jensen <its@irrelevant.dk>
Date: Mon, 18 Nov 2024 11:14:17 +0100
Subject: [PATCH for-9.2 1/4] hw/nvme: fix msix_uninit with exclusive bar
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241118-nvme-fixes-v1-1-02d107dbdcc0@samsung.com>
References: <20241118-nvme-fixes-v1-0-02d107dbdcc0@samsung.com>
In-Reply-To: <20241118-nvme-fixes-v1-0-02d107dbdcc0@samsung.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, 
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org, 
 qemu-devel@nongnu.org
Cc: Klaus Jensen <k.jensen@samsung.com>, qemu-stable@nongnu.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1120; i=k.jensen@samsung.com; 
 h=from:subject:message-id;
 bh=luAZmVRl988Fk2UCy4nTP3G7adYdvITDIx52Hx/vg+M=; 
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFaTCtrQTBEQUFvQlRlR3ZNV
 zFQRGVrQnl5WmlBR2M3RTZUaHFKYzZRcnRWV1BDWnNlby9sQVVDCjFtdjllS3gxNTUwd3JkNFVG
 UlIrZzRrQk13UUFBUW9BSFJZaEJGSW9NNnAxNHR6bW9rZG13RTNocnpGdFR3M3AKQlFKbk94T2t
 BQW9KRUUzaHJ6RnRUdzNwTEtzSUFMSUs4QWZ0ME9pTGh4bzhRazI3RWxhWXVqK2JLdnpNaE14bw
 pNZnhIRjV6TFJjRXNNVTB0cHZTYUpaMnF5UktmQ2FzdGtETFB0OUtPb2MvNWdjK1lmZk9TSlhuN
 0tFQW9qVC9jClY3Rlg0ZCtxZVR1Uk1saUQ1bGY1V1B3QWk5OW15M01pVzV6MzB5dGEzRjdWQWtN
 WkswYVBBNkU1S0dkTy9aNTcKcHVzV1FLazNOUG9CUzlPRGM3eGpkZjkvM2xwNVpscnRKNGxJSit
 KZTd5OGFDUmgwTlJyUWt4S2pUZGVmUDNnVAoxd0QyNldlVE9lZGhvbVVFQzlXT2NGN3JlQVNocW
 F2OWF3Z0pMVGIwdmJCODFoOVhZaVpsWHV1d3ZMcmVOWkFsCkxNMVlQVDZkZGpsSWp6U1Q0MTF0d
 FpKNy8vZlRGbDlXV3JNU2wwUzQ3TlZ6Z2hacFRLZW9wS1pVCj04cGgzCi0tLS0tRU5EIFBHUCBN
 RVNTQUdFLS0tLS0K
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Received-SPF: pass client-ip=202.12.124.147; envelope-from=its@irrelevant.dk;
 helo=fout-b4-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Commit fa905f65c554 introduced a machine compatibility parameter to
enable an exclusive bar for msix. It failed to account for this when
cleaning up. Make sure that if an exclusive bar is enabled, we use the
proper cleanup routine.

Cc: qemu-stable@nongnu.org
Fixes: fa905f65c554 ("hw/nvme: add machine compatibility parameter to enable msix exclusive bar")
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 69bce20f6692b48ae162ad948b1a3eef31d69ebd..13898d58278ed2155d45a9120fc07ea60bc64a32 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -8904,7 +8904,12 @@ static void nvme_exit(PCIDevice *pci_dev)
         pcie_sriov_pf_exit(pci_dev);
     }
 
-    msix_uninit(pci_dev, &n->bar0, &n->bar0);
+    if (n->params.msix_exclusive_bar && !pci_is_vf(pci_dev)) {
+        msix_uninit_exclusive_bar(pci_dev);
+    } else {
+        msix_uninit(pci_dev, &n->bar0, &n->bar0);
+    }
+
     memory_region_del_subregion(&n->bar0, &n->iomem);
 }
 

-- 
2.45.2


