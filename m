Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0449EC48260
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 12:55:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rY3vX-0003gH-30; Thu, 08 Feb 2024 07:54:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1rY3vV-0003g8-FA
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 07:54:49 -0500
Received: from fhigh3-smtp.messagingengine.com ([103.168.172.154])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1rY3vT-0003jK-5t
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 07:54:49 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id A6EE3114008A;
 Thu,  8 Feb 2024 07:54:45 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Thu, 08 Feb 2024 07:54:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:message-id:mime-version
 :reply-to:subject:subject:to:to; s=fm2; t=1707396885; x=
 1707483285; bh=WPvg7hzcTmS/cXanTsn7l/D9tQWA93iNr7++aO+PMaA=; b=B
 kmDYc9a7gGxcWeKTGHnUtpCMpwom6VKVurJjdwdXs0imbCdO7A6uIR8YWcBOf7Hx
 R5ngvq8qEZY47fdJpxVqKzXWiVTTZeh8sf0GJ02z9OZMvNF6l0rgfkCDpa+9UJB+
 /uNz76FRPaJ32oA7TT3rq4C3rFIoJZeSqc2xdrVEIFn+YdhFXoMxnLHd35yglD6x
 Dlqcexcnd0+ILLTrj70SnP8ltsYd8iEaxeMY77vBlQtWgY1VeLs2ByMk54ZEPG9v
 1CwrBVY+lkP7x/pMz9edopVWadB/cx0g+8lPY7UyU+gyb7+OJPwVPb6TA+tpAHQT
 SMm3K/UsEx4ANpzoX9kFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; t=1707396885; x=1707483285; bh=WPvg7hzcTmS/c
 XanTsn7l/D9tQWA93iNr7++aO+PMaA=; b=D1GDfCiq93+rwVVOQsMCY8mbcx3ZU
 POvZ6TNiKnBQlA0VuTNZdyQrUvpVbD98GkgxW5Lh2PXS5PluBUNUbw6p0f1L45Zk
 cva8e/lwDdTjSlTp057dotqNjhL61JoZ0oXBAXZEB0m4G+koA0Q5sHNjGynP0ThR
 0Kb4r64m786d/eXeqfZ4O5AuD+tbHS26JJ27QEMJ+CSkYReyIsmtHtdmsk3S+YLZ
 bHf0ztMO/FR3V+q2l8E+5B1Lem40KBaHjOmBt0EH356MuJck8CQkILddluO3iFFk
 kkRe9x9MAsRG5su6bDdYYulTs+5DevxVwe/dsTGhaAmDhFowb97AckwZQ==
X-ME-Sender: <xms:FM_EZRpxVNjMfIPJPaWXGcIkCXBVh-xcLCObZ6khlOWhH21ZqX6sJA>
 <xme:FM_EZTqgfxEA_4CkAnCWG5c1QlKsiHgB_iH2Ylrs3N8i88zr-MGQ9t35VMhexdA4O
 7NpVUzcJNG1DYO9QB0>
X-ME-Received: <xmr:FM_EZeOsIxbgJgsLiJLXIJZrfpwm-FehnHMJtgprb3zNMR9ydXasaH4RoP9t0SxYntRGhVVEWXsAdzanNBDbeFWtvwaeyGCBDm52V0DV0Rq71yxOHrCitbKJLZwLyfklakPDPAEO6Bwzg0sj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtdeggdeggecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkffvvefosehtjeertd
 ertdejnecuhfhrohhmpefmlhgruhhsucflvghnshgvnhcuoehithhssehirhhrvghlvghv
 rghnthdrughkqeenucggtffrrghtthgvrhhnpedtheevjeeihffggeeihfefheeuiefgue
 fglefhtdffveehffekhfekgeetteffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
 rhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:Fc_EZc76q_rdA2dU7MueW8e0iwhiJxOxAoNor5Adh7rc3dQBmc_sYg>
 <xmx:Fc_EZQ6iulRHpGVwLPyZPrdzhAokqJ-JwvENSWB3fTqLH_lsOo0aFA>
 <xmx:Fc_EZUgw3spFp2Njsi0MZJnPGg0Rs2hIOR1cC2BVHRMVnhh86lM50g>
 <xmx:Fc_EZelWsb6Yw_hqHDAtPXWqCNYD45O7cfg7OVky1zclXB3i04pcQg>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Feb 2024 07:54:44 -0500 (EST)
From: Klaus Jensen <its@irrelevant.dk>
Date: Thu, 08 Feb 2024 13:54:20 +0100
Subject: [PATCH] MAINTAINERS: add Jesper as reviewer on hw/nvme
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240208-maintainers-add-jesper-v1-1-1ed7eb9f8291@samsung.com>
X-B4-Tracking: v=1; b=H4sIAPvOxGUC/x2MsQrDMAwFf8VojsAxHUx/JWQw9UujQJ0ghRIw+
 feKDjfccNfJoAKjZ+ik+IrJ3lzGIdBrLe0NlupOKaZHTDHzp0g7HahxqZU32AHlOkbkjMUBeXw
 oFrn+42m+7x8KfvubaAAAAA==
To: qemu-devel@nongnu.org
Cc: Klaus Jensen <k.jensen@samsung.com>, Jesper Devantier <foss@defmacro.it>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=827; i=k.jensen@samsung.com;
 h=from:subject:message-id; bh=xnSF7Qw8KWamEPYYAHMElocvF7SoKcm+v4NpTLA7r7I=;
 b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGXEzxSAPldlr5U5zbDE8vMl9iE++MWb28enb
 6Ojvc6HBXAvgIkBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJlxM8UAAoJEE3hrzFt
 Tw3pbRMIAIMWDszcdf0OKc59aWnHWfVChd/tV40yTHoUnDyEWFNO3w+pEOgIu9iHTC+1eb+wD6i
 VfOABzkROJqHKHPVrdA0cvEziMYFC/nEczi8Zqih/0gSSgjDGim0g6HceJ6uX6xX3PRL8bWMesB
 6eZdTiLm+cc4KMzgG1YBxKWfs2ucaZ9+A4c8dZ3on6UVzUah0+fMLE0J0MLAANI/pendJVM7eJr
 abTIDjEqRXi/x60arZfJiRADOzJoYXXKhXhO8j28f7UmZtxf9B6fDHtQTFYWpaE33X2CiTJ2G/u
 mDJiJxUANtNYeZQoHA0tR2mutqLOwB86VVQv5F4a2cTBdwS+VxaZHadC
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Received-SPF: pass client-ip=103.168.172.154; envelope-from=its@irrelevant.dk;
 helo=fhigh3-smtp.messagingengine.com
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

My colleague, Jesper, will be assiting with hw/nvme related reviews. Add
him with R: so he gets automatically bugged going forward.

Cc: Jesper Devantier <foss@defmacro.it>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2f9741b898e8..ef70cc9f4166 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2378,6 +2378,7 @@ F: docs/system/devices/virtio-snd.rst
 nvme
 M: Keith Busch <kbusch@kernel.org>
 M: Klaus Jensen <its@irrelevant.dk>
+R: Jesper Devantier <foss@defmacro.it>
 L: qemu-block@nongnu.org
 S: Supported
 F: hw/nvme/*

---
base-commit: 39a6e4f87e7b75a45b08d6dc8b8b7c2954c87440
change-id: 20240208-maintainers-add-jesper-d10e88ef88ee

Best regards,
-- 
Klaus Jensen <k.jensen@samsung.com>


