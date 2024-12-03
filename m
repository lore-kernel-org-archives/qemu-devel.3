Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2785E6C60B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 06:32:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIMRU-000098-8z; Tue, 03 Dec 2024 01:31:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1tIMRS-00007v-Ik; Tue, 03 Dec 2024 01:31:26 -0500
Received: from fout-b7-smtp.messagingengine.com ([202.12.124.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1tIMRQ-0008Ck-SI; Tue, 03 Dec 2024 01:31:26 -0500
Received: from phl-compute-11.internal (phl-compute-11.phl.internal
 [10.202.2.51])
 by mailfout.stl.internal (Postfix) with ESMTP id AA5CA1140114;
 Tue,  3 Dec 2024 01:31:22 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-11.internal (MEProxy); Tue, 03 Dec 2024 01:31:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1733207482; x=
 1733293882; bh=hHah4oq2cP49nUb7gn6Y3tToILMu0YicReswh8YBkac=; b=K
 2uMi5NTZQLEfwC9HZuH1MVdBHjbU/rUvvGi0hVvMBvHHQsf8wtDrf8/HAnDPdaw7
 XfJhpxn19VZgDkUQsMz+j5VURUKsiyd1dvWA705p0wJXn+O2aB6myR7nejbvm+mn
 C6e6auTYDWIUHplijAYLMwtXstWMznS4+KJL9B/amglZiZ/GL8trqHluPJ/2xEcb
 wVbcr6H+uVnWTFCfWzKAG/xMzCwYX9+fhpkHcOQf5cl+5z53cgp1hdUMdpS7sZIp
 G0BdEZFNG+Z985BY19mA/zHaRVB9IQTTQp9FWZm/GvmTT/twzyJS2rL0Zc0mUQX+
 Fib1wJniT+oPVMcdWdTpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1733207482; x=1733293882; bh=h
 Hah4oq2cP49nUb7gn6Y3tToILMu0YicReswh8YBkac=; b=Or2uJTat/VCi6k0YL
 s6Ra96N0Q28+Gk2cAEXfQtzm5hrvp2v+YlVyXTWgCnvYTzrd3ntIkYsFGbY3UwiH
 jnfyGGgMx+5sGhqABKvQX7m3rDwGanUNQ9BF/HtDSU6ZSQxqnUay5Rj79hhOMfbn
 v1d0kxTUpoFbF6ax1IBC8TicnQz0ujr76twP44UDvnebninAvu06bksDgGNW6cp5
 0vWSGbxpGtHJ4yy5snWkabHkHWrZA3kJuuUtRuoRCmltfqcZK9W4wcge31TU7NXs
 MCbOFMT3K7vf+d951Up4SKNBkn16ooY70re0d/p2ARjsZuZBE0bGD6AsU31XYSmo
 DdCLQ==
X-ME-Sender: <xms:uKVOZ1NK44AaMsKXJ1KEqrJrw1jciooMOEmjfhco_2qKWTq_ioKvew>
 <xme:uKVOZ39TB9zPeYcqNmGF2nE_4zRyveTb9ELVqquQrOlbB5kCIkpXauuo8EoLrBYuU
 cjRbPHlbkXZkIBOYPc>
X-ME-Received: <xmr:uKVOZ0T_llZXk7wbDg5PdK229Sh_PRdNHMRk95pSHRwtejJ1K2-lmbipw5uS5MPEkyR47_uXpW7t0yo2lllSE7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddriedugdduiecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
 tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
 hsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecu
 hfhrohhmpefmlhgruhhsucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrug
 hkqeenucggtffrrghtthgvrhhnpeejgfeilefgieevheekueevheehkeefveegiefgheef
 gfejjeehffefgedujedugeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
 grihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughkpdhnsggprhgtphhtthho
 peekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnh
 honhhgnhhurdhorhhgpdhrtghpthhtohepphgvthgvrhdrmhgrhiguvghllheslhhinhgr
 rhhordhorhhgpdhrtghpthhtohepkhdrjhgvnhhsvghnsehsrghmshhunhhgrdgtohhmpd
 hrtghpthhtohepqhgvmhhuqdhsthgrsghlvgesnhhonhhgnhhurdhorhhgpdhrtghpthht
 ohepfhhoshhsseguvghfmhgrtghrohdrihhtpdhrtghpthhtohepkhgsuhhstghhsehkvg
 hrnhgvlhdrohhrghdprhgtphhtthhopehithhssehirhhrvghlvghvrghnthdrughkpdhr
 tghpthhtohepqhgvmhhuqdgslhhotghksehnohhnghhnuhdrohhrgh
X-ME-Proxy: <xmx:uKVOZxs0NRdmCxoA68uDel5RIMRKFkFB0U-elgQmDKfjMVhtkQyvhg>
 <xmx:uKVOZ9c1n11YRkIo1ZaBAF5Jsf9kwz5RFeRsk9fQpCXvDAw6G6j9pw>
 <xmx:uKVOZ92yQ3yyJ2pID_gXZPAPVhWyj13VPX6hhRKmjn7JnSps0ZcaBg>
 <xmx:uKVOZ59H37fMNCaEIkDk3969ep7lWnNOKs11sDEW-6WrFuWQJmXTGA>
 <xmx:uqVOZ8xA1Iwnd9wB4wVAw0Q6EXELevu9BhCCKtHVJotSz3tHvuJ7B6_X>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Dec 2024 01:31:19 -0500 (EST)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-stable@nongnu.org,
 Jesper Wendel Devantier <foss@defmacro.it>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 qemu-block@nongnu.org
Subject: [PULL 1/4] hw/nvme: fix msix_uninit with exclusive bar
Date: Tue,  3 Dec 2024 07:31:08 +0100
Message-ID: <20241203063112.9135-2-its@irrelevant.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241203063112.9135-1-its@irrelevant.dk>
References: <20241203063112.9135-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.150; envelope-from=its@irrelevant.dk;
 helo=fout-b7-smtp.messagingengine.com
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
Reviewed-by: Jesper Wendel Devantier <foss@defmacro.it>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 69bce20f6692..13898d58278e 100644
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


