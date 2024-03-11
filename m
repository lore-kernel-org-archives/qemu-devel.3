Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7696BC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 19:12:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjl3V-0001mX-Dx; Mon, 11 Mar 2024 15:11:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1rjl3S-0001kb-Vi; Mon, 11 Mar 2024 15:11:23 -0400
Received: from wfhigh7-smtp.messagingengine.com ([64.147.123.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1rjl3R-0000CQ-7t; Mon, 11 Mar 2024 15:11:22 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailfhigh.west.internal (Postfix) with ESMTP id D36E318000CF;
 Mon, 11 Mar 2024 15:11:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute2.internal (MEProxy); Mon, 11 Mar 2024 15:11:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1710184277; x=
 1710270677; bh=l7VA1kmIdj5go01fibCCpJkzwEtHzwcL+nZbGerYsTM=; b=F
 0qgqDc/1dbyTxDraVxmRbM8oB3KXN5U2rXHvLiMsryXFo9HOVAFMwCWx+XmpFii4
 xtEGM2NnQbVA3fHMc07LSlf0ZjMciXJhqMmuL0wkutTBlNL4UOQQozfJgcK39rS0
 gdYilo3HviDSG0F72lPuIxxAwgyKDT0nYtE1337OXu2SjV8VzvgONi0rIcN458FB
 qa33dzDsXDwLQX8Zo2DJk8ZIC6Gcf4robs1zWMBVy0/ebsRi5C2pLPC77hNsoymp
 yTXDi619Pyu1cVoEkNF2sy0jS7/uOkibrUKj/xqpV9gvdeUMJb+POgirb8Ec7rTU
 BY59GAeXOLsIXQnqwtj+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1710184277; x=
 1710270677; bh=l7VA1kmIdj5go01fibCCpJkzwEtHzwcL+nZbGerYsTM=; b=W
 VLYRFQJvlwXk5mdAlhPv3dr0/PCpqYB03s6F8FsW7Opchk5C1rtj7oXEivr1nns1
 MLAT/IGjVUDWwhrsl3/C7+2gbUuupRMpun5ruS/d2AYqli2fDo2eqt2UaYmoOQnM
 b49O/f3EW5Vo3KMX1/NjwIwTqC8Djq9N1pOdYgXSvdlSqxAaK5HSBVkgD1u4cPz9
 dSdhSlSP3V/inbgDfty6WNhliCHqC/U6iZYVdOfVFmZXNdAyIkmk+DnGGfH+YJRK
 3j1VREkPE2iYJEwmwlN7nl5RInLloG8pFAu4R2QmyPhNN93RH8Y7hvWZH6jrs+Dg
 JPM2zkCkCzvU/RnCPWTRw==
X-ME-Sender: <xms:VFfvZVEif5c7C_Mq_Wmh5uoIoFJlG0bEp3mCAkVCEJHFFFtku61Mzw>
 <xme:VFfvZaV-mOKrwpmHX8hbb_m6hY-5z6H4O4xuluuNZjDMcw1vhfomqv1qkG_aQiUSl
 SROZSCaM-rUlyXvmI8>
X-ME-Received: <xmr:VFfvZXKCMkoIN1ZhkZ2qvWutZSIYtE5A6N2MdxGdIcPN3Qg82rdnDFXVh_8IKoJmBc4MX-yXYw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjedugdduvddvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghu
 shculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrth
 htvghrnhepjefgieelgfeiveehkeeuveehheekfeevgeeigfehfefgjeejhefffeegudej
 udegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
 htshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:VFfvZbFir1quLhQGC3fLfO-reDW89QZia-f2QlwucUVTjTFpHglFBg>
 <xmx:VFfvZbXPx-SW6pvg6-7B15h10Dp1M48rGJR_zTlWoYbP3jXJBOa8ZA>
 <xmx:VFfvZWOqct8_MCvxIE-PvgnYPgphUgacF4X5ZO2yjeKlhchrVXXtqg>
 <xmx:VVfvZYUu17mgIdRKDaVH_xtd_dLdM1KVi6GU_NDYuUNFu6rH83EGHyy7tpo>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Mar 2024 15:11:14 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Keith Busch <kbusch@kernel.org>,
 Minwoo Im <minwoo.im@samsung.com>, qemu-stable@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>
Subject: [PULL 1/6] hw/nvme: separate 'serial' property for VFs
Date: Mon, 11 Mar 2024 20:11:07 +0100
Message-ID: <20240311191105.35224-9-its@irrelevant.dk>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240311191105.35224-8-its@irrelevant.dk>
References: <20240311191105.35224-8-its@irrelevant.dk>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1724; i=k.jensen@samsung.com;
 h=from:subject; bh=XddK9fgznLnaxCGQz8aWhKGnoFKoCfbUCAuoljS2hIM=;
 b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGXvV0oZj5olpC72zzipnjwY6NMt1OnU4pj+p
 RI2dDcXbu+bZokBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJl71dKAAoJEE3hrzFt
 Tw3peDkH/jW4o08oZ/CXnRPync5YzdBE4EqeDL7PMB0O/G2U64s+QjhrVx8jaeKyIl6zZAbckgm
 vGjL9Yx6aEy8wQM5z+y9fne/dBUcRE85sAk1WqgWlICnbE27Mk6+67IsMWI21kgcRj0AzbpeQ+M
 orRGNGoNTNePo/Qzqb2g6EcRqOP7E1rCGtrQ3bvo0cYGf1IJaOyMju7C41MZhLSRvNTJ8k0xJI4
 80USYzjOdXp/mO9lLhQ1OVuSzS+FsT6qska6sTorlUG3JHbMRwAMU+pbnGQjf7ciJRO2zbAAHXV
 mo4nD3Wp+UqYFiOr4LS2Z2Zc+qlTMd9ypMzD/qcvNKgHPNTqkm60Pqkf
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


