Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43093C77B7F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 12:29:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU2ll-0003vX-Qs; Tue, 24 Jun 2025 08:28:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>) id 1uU2li-0003vA-OV
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 08:28:54 -0400
Received: from fout-b7-smtp.messagingengine.com ([202.12.124.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>) id 1uU2lg-0002oZ-00
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 08:28:54 -0400
Received: from phl-compute-10.internal (phl-compute-10.phl.internal
 [10.202.2.50])
 by mailfout.stl.internal (Postfix) with ESMTP id 826B41D000ED;
 Tue, 24 Jun 2025 08:28:48 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-10.internal (MEProxy); Tue, 24 Jun 2025 08:28:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defmacro.it; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm1; t=1750768128; x=1750854528; bh=Q/
 soykeU1GwV3mOOTfI7Fg/tWtyEZ4gTbsjFAqhtW/c=; b=Sp09n5k7RIQonkEHJM
 wMP/4kZiHA14+zxvAsu1hHkDThuEiqLnCUNverxYDaeU0OKN/YRb7koyBuZNsTng
 VYkvBNGnXond8C1ywODAJjXHU2DtRrdweejYbJnZtVeT5iWWEXYUxEuCaUwc0HdX
 TdyuwlxJKO4Fw8BzeTXjpA0EnnW9+GdPzJDEiu5yiDAWHujRh+ErFxU1WzCU4A1i
 yGVUbR9XEUEckdoFHm3Y4SfKEa4vSke1W1xCA3fQX0van/HWS1znTSHN+E54LNzl
 QyZv5pQ0O37IXTOOzlZCN9O+KVkceIdRNPc8/66FIGAXTlJvTdArjg6K901ajM3Y
 Hd4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; t=1750768128; x=1750854528; bh=Q/soykeU1GwV3mOOTfI7Fg/tWtyE
 Z4gTbsjFAqhtW/c=; b=aXrEqYs0dt6QV9ibmAkJvjiRorOFglpuZDwYzducTJzU
 2/n5GAsNZEurslVIMClZb+rTPzrZX5L1dBmlhXYvKWVwT5/pS9FJThDG9CmbK43i
 97zk+Ts9PW78H4KJNCdLb+mzUvnT6H1cfekOQhwdJX7BgRGNm2zjt9KZ9L8cQgL6
 5U906vDoKpuB8W7J9dgsBLlV38uIpckWB2EyobOzOwuZbkgmULbNzyOXiJ5WLlPq
 reUVRlwqBGoRfJwFXz5rT3iB+sCBq6JmygR9LMC3DV+MC8hQ94zaViHrKZWbnJvI
 NXUCOsL+lwz1WsC7leWpTUpwfp45iW3QssvmZoDzGA==
X-ME-Sender: <xms:_5laaNJy-QrVH7-2EVWs_WAmlhfbx8xYUqYVMbYsip0A0cxUmvmNPQ>
 <xme:_5laaJKr7AYqVdWmkFDQaNaws1apt-CtWk2RgU8svzK-0i0ZcIx4P6FiUdTTNpkVo
 vqy2jlExV4cdRDUEJI>
X-ME-Received: <xmr:_5laaFuR4lIJDiUzfZS5AXK9F1w9HK7z46m5TUO9d2al-M6ZA0cmfu62eUWJ_6J8py4bFcLXDCeIT7wKtCFrdoS277rB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdduleeklecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhfffugggtgffkvfevofesthejredtredtjeenucfhrhhomheplfgvshhpvghrucff
 vghvrghnthhivghruceofhhoshhsseguvghfmhgrtghrohdrihhtqeenucggtffrrghtth
 gvrhhnpeevfeevheehffefleeugfduleelteduveehiefhledtkeetfeegleeuhffgtedv
 teenucffohhmrghinhepihhnfhhrrgguvggrugdrohhrghdpghhithhlrggsrdgtohhmne
 cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfhhoshhs
 seguvghfmhgrtghrohdrihhtpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpoh
 huthdprhgtphhtthhopehjrdguvghvrghnthhivghrsehsrghmshhunhhgrdgtohhmpdhr
 tghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhope
 hksghushgthheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepihhtshesihhrrhgvlhgv
 vhgrnhhtrdgukhdprhgtphhtthhopehfohhsshesuggvfhhmrggtrhhordhith
X-ME-Proxy: <xmx:_5laaOYR1we60_nhDQnZ5mmiAq-BxK-MsUHwyNqO-xJbUtg38SaT_w>
 <xmx:_5laaEYH88Du-m9kU9Jg5FmYCL5Ujpx2sV5tg9AmqMeTjkoTsaBevg>
 <xmx:_5laaCCZcWn0ibHHRIWw6_bdxtOF5o-OE-sAYb_Z4V8Mtc4WexKcLg>
 <xmx:_5laaCaEDlHlddt-RB3rqj88NDCW_PZrdVrhyjfk_E7zveL1kX1uPQ>
 <xmx:AJpaaJj6-CW-9OOCNKjIaHLItzkumISPfnADTG6iIjrbNsMA1FA0Xzt3>
Feedback-ID: ic0014905:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Jun 2025 08:28:46 -0400 (EDT)
From: Jesper Devantier <foss@defmacro.it>
Date: Tue, 24 Jun 2025 14:28:43 +0200
Subject: [PATCH] MAINTAINERS: update nvme tree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250624-qemu-maintainers-2-v1-1-f24f503bfdde@samsung.com>
X-B4-Tracking: v=1; b=H4sIAPqZWmgC/x2MQQ5AMBAAvyJ7toluS1JfEYeGxR5atIhE/F3jM
 Ic5zDyQOAonaIsHIl+SZA1ZVFnAsLgwM8qYHaiiumrI4M7+RO8kHBmOCQmddlaxsVYrghxukSe
 5/2nXv+8Hcr5BA2QAAAA=
X-Change-ID: 20250624-qemu-maintainers-2-a3a91e499312
To: qemu-devel@nongnu.org
Cc: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, 
 Jesper Wendel Devantier <j.devantier@samsung.com>, 
 Jesper Wendel Devantier <foss@defmacro.it>
X-Mailer: b4 0.14.2
Received-SPF: pass client-ip=202.12.124.150; envelope-from=foss@defmacro.it;
 helo=fout-b7-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

From: Jesper Wendel Devantier <j.devantier@samsung.com>

Klaus Jensen does day-to-day maintainership work and works on the
tree referenced in this patch.

Signed-off-by: Jesper Wendel Devantier <foss@defmacro.it>
---
Signed-off-by: Jesper Wendel Devantier <j.devantier@samsung.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 94c40761278208abae1a93d6b6c8ffcde6bfe817..0c2dd9b73d2b75e89eb7204c4c163396aacf2b8d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2502,7 +2502,7 @@ F: hw/nvme/*
 F: include/block/nvme.h
 F: tests/qtest/nvme-test.c
 F: docs/system/devices/nvme.rst
-T: git git://git.infradead.org/qemu-nvme.git nvme-next
+T: git https://gitlab.com/birkelund/qemu nvme.next
 
 ufs
 M: Jeuk Kim <jeuk20.kim@samsung.com>

---
base-commit: 43ba160cb4bbb193560eb0d2d7decc4b5fc599fe
change-id: 20250624-qemu-maintainers-2-a3a91e499312

Best regards,
-- 
Jesper Wendel Devantier <j.devantier@samsung.com>


