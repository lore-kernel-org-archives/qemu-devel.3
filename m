Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BE43C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 17:29:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk5tr-00027Q-U1; Tue, 12 Mar 2024 13:26:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1rk5te-00023y-VD; Tue, 12 Mar 2024 13:26:39 -0400
Received: from wfhigh5-smtp.messagingengine.com ([64.147.123.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1rk5td-0005No-3C; Tue, 12 Mar 2024 13:26:38 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
 by mailfhigh.west.internal (Postfix) with ESMTP id C544E1800082;
 Tue, 12 Mar 2024 13:26:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute7.internal (MEProxy); Tue, 12 Mar 2024 13:26:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1710264393; x=
 1710350793; bh=l7VA1kmIdj5go01fibCCpJkzwEtHzwcL+nZbGerYsTM=; b=U
 DXQBjP7uwKHDAMpLUHr2zI6IxglSZamC59bz3tvU15Z4dBjrYtqg/8VMK6Vj8Ciq
 MRsTkWuX1KHTzw2c75878Y8h333ccbqVDtmDb8a60oLCAJ2ynJ+idoJM4Ld7W9kM
 RsQ6UX1fkdYT/RONRhGKAZ6nhDuuh4P3fxA9IKPmkMP9hAiH0Cs3o3y/vfYawrFt
 YXz4/2cpo1pC/T5PjHtcAPVtKoFWr5ryYETFCxhne/f0wjmafLaYbMpMf6p43zue
 cngM9PUv4E4PGkxd+1DVqZPBLjm3h+W5k7LgocSjnpWzDW/BWLSaHfembbVBA590
 t4IxZZPMId3N0mfJAgSpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1710264393; x=
 1710350793; bh=l7VA1kmIdj5go01fibCCpJkzwEtHzwcL+nZbGerYsTM=; b=k
 RuNqlDrQ3AeSvm3hBFgk742HrZMCTuiBW9ik8lInjBuUeBDf9nbd9gYoSJhJPIi4
 JQzdwKmBsqLhaawoDE0clrp575AputN7xumMJJ28FSDLDxZzTP6o1ne5FjQj0cBB
 m2khCEiJJO3FFFY0Bj5KtzPmCTKNum5BJ55Q1hGObM9cQiznDWITXgHDCm9cEXE8
 9c/Lpjj/drEkh/8o8in9H0MSbm7FsI/SQGW/08h2jGdbB5WTmaSgTh3WD8yLT+2q
 l5LUCYG/vo71i1fSpQWzS4HNv5qg7U6nNVdDXeKTXMTFOF0kx6VoI479tskzWZvl
 kk/6PvoippOT14KcZwYYQ==
X-ME-Sender: <xms:SJDwZXvcwt9Z-EcbjvXDrqTAGAE3XY18iwzzgoMgj1Vu9oaxdjV9ww>
 <xme:SJDwZYd-aIthe_X2KTh3Tc921LQkKiun7F3h3Dbsgd-JtT_1kYSSL5J771CzJx7ro
 qtKJsf8pzb2mfdGJbY>
X-ME-Received: <xmr:SJDwZayB_-pFRIfMxTUvlwEIWabZUzZ-6crKRJz0Hn9RIFkBkY0GQcz2I3xGRVYMWNYItBeVSQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeefgddutddtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghu
 shculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrth
 htvghrnhepjefgieelgfeiveehkeeuveehheekfeevgeeigfehfefgjeejhefffeegudej
 udegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
 htshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:SZDwZWMqvpTuw3CKQFTaUxGM3NYh8WbqwbnZluWTGUuG5tdEHkYv9Q>
 <xmx:SZDwZX_ClFheBnQxbAQ4ifqGxnu1nDI9W7BtydhYPBbduNgzA4gKrg>
 <xmx:SZDwZWWGD07jMY-OZo2sZGmVAD8jZIvsU1e4bBvM9PeYb4lGtUnUJw>
 <xmx:SZDwZYeIFB2Cb6oIvjtXJ8h9iTBiUXDi9G270Um6Basqym-aTDbs3g>
 <xmx:SZDwZbURfUCHNufeiv6DbUYuOQMzHqpGIHmfkHMaaiuMHYqQV_9wuiwRUm4>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Mar 2024 13:26:30 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, qemu-block@nongnu.org,
 Yanan Wang <wangyanan55@huawei.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jesper Devantier <foss@defmacro.it>, Minwoo Im <minwoo.im@samsung.com>,
 qemu-stable@nongnu.org, Klaus Jensen <k.jensen@samsung.com>
Subject: [PULL v2 1/6] hw/nvme: separate 'serial' property for VFs
Date: Tue, 12 Mar 2024 18:26:24 +0100
Message-ID: <20240312172622.58652-9-its@irrelevant.dk>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240312172622.58652-8-its@irrelevant.dk>
References: <20240312172622.58652-8-its@irrelevant.dk>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1724; i=k.jensen@samsung.com;
 h=from:subject; bh=XddK9fgznLnaxCGQz8aWhKGnoFKoCfbUCAuoljS2hIM=;
 b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGXwkD4Zj5olpC72zzipnjwY6NMt1OnU4pj+p
 RI2dDcXbu+bZokBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJl8JA+AAoJEE3hrzFt
 Tw3pWqMH/AwJRSDnSKEMrUuOcvBzROTcNBhOLXH+Tkjue3pa3YtejzAVChAI8jyr9BfWYit4/Ug
 2zCzLfOZPAWGcZrSdbdlSzx/7dziCAehdiH5Ay+14Hjm0CyKijq32XJnSDbMiiCR+GNS3Ga+Zss
 qA5iNnGlDbO3zUQLl6eEiXbnX+GQPxyOr6/ygVWFYuaDioaieT9wp7SK4lPBfq/05smnUo8zS5C
 ZUmSaVyGowyk8iAXyZjTyKXKH4nA7cQl6E95VVpqV/rZ+uWdOoPs9cywdaQTDUVwZZGLtgA1DQb
 fPn/STtEFe+XL23NkfEpgnjdnp/wip6ydiT7B64mFDv2CqyyDT1D96RE
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

From: Minwoo Im <minwoo.im@samsung.com>

Currently, when a VF is created, it uses the 'params' object of the PF
as it is. In other words, the 'params.serial' string memory area is also
shared. In this situation, if the VF is removed from the system, the
PF's 'params.serial' object is released with object_finalize() followed
by object_property_del_all() which release the memory for 'serial'
property. If that happens, the next VF created will inherit a serial
from a corrupted memory area.

If this happens, an error will occur when comparing subsys->serial and
n->params.serial in the nvme_subsys_register_ctrl() function.

Cc: qemu-stable@nongnu.org
Fixes: 44c2c09488db ("hw/nvme: Add support for SR-IOV")
Signed-off-by: Minwoo Im <minwoo.im@samsung.com>
Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 76fe0397045b..94ef63945725 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -8309,9 +8309,15 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
     if (pci_is_vf(pci_dev)) {
         /*
          * VFs derive settings from the parent. PF's lifespan exceeds
-         * that of VF's, so it's safe to share params.serial.
+         * that of VF's.
          */
         memcpy(&n->params, &pn->params, sizeof(NvmeParams));
+
+        /*
+         * Set PF's serial value to a new string memory to prevent 'serial'
+         * property object release of PF when a VF is removed from the system.
+         */
+        n->params.serial = g_strdup(pn->params.serial);
         n->subsys = pn->subsys;
     }
 
-- 
2.44.0


