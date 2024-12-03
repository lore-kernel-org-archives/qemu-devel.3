Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76F70E6C60B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 06:32:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIMRS-00007u-Qe; Tue, 03 Dec 2024 01:31:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1tIMRP-00007E-V5
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 01:31:23 -0500
Received: from fhigh-b1-smtp.messagingengine.com ([202.12.124.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1tIMRN-0008CK-JH
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 01:31:23 -0500
Received: from phl-compute-06.internal (phl-compute-06.phl.internal
 [10.202.2.46])
 by mailfhigh.stl.internal (Postfix) with ESMTP id BF02025400C8;
 Tue,  3 Dec 2024 01:31:18 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Tue, 03 Dec 2024 01:31:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to; s=fm3; t=1733207478; x=1733293878; bh=0VuvnZV8/K
 httzv+ynGdwiLaf0vRTVc05qsW7jncOOE=; b=NrL/exz4vAhGObBaH6OcyJzgEE
 aw9EoqyQK9jDRaEDJjo/c56r0tKPvu0INLpp56lI9+z14ixF4T6g8pyDnWY71ACk
 09JxVUqeqSJAjHUDvNbOH0iETublIGSYKYNXEcGsxUnbJMjQvkx6j4jcGzp4tUdA
 F/PxYLcgowotxWS27mUvA2upGVtdSoMZkwL6aw5TugkKk9G42WEQqXiBqJLa14WU
 1Pm7m9J+hMJGJvGakO/9HZnf2d4p2hrqy+oTP1tJ6yrv/XgTzHp91pIbuRgnTHJy
 ebdCcmRkx6VieQm06jocsxukVMld2dr6y5aDgZ8CPuynJ+dEF+tzltxEirZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1733207478; x=1733293878; bh=0VuvnZV8/Khttzv+ynGdwiLaf0vRTVc05qs
 W7jncOOE=; b=wzxXAHzM3xhbYmFiXPfqL1SMwuHuWsQbRE26xCAJCaNT4KJKhNw
 XYbA/l1rzLtQeRTg7aQGSrcaVTS4IlOoT0ScNUkWdaOUBWPlLDk6oHOj9N4Q86or
 tDrje8wdW22Nok9nItgnN3SMoi2NaPh5UZ7HSqqJl2FNyUn3EjwLTJJ++ByBeyzq
 oRdBTLxs+IFfB/Uu9oKgYGhA5Kf3lblWDpcHpPU0WKnugWFi87evFJaXzmDDqPWd
 nvzTJk/b2mvTo/XQRjgr1Xpfomvk7YXnNx+s0r+K3b4ygVixDRWbQJA30PN66zSh
 bEt/slMBUgkj9zHs4r7i27Ql6p03WBk1/lQ==
X-ME-Sender: <xms:taVOZ6huXB3z3DCXaiVUWlO0lRHdVe43pyE_hAt5sr3L0_NS1fUdWg>
 <xme:taVOZ7ApnIZYJIRVWHxTNRVZkVAFl1inopBRIhl9uRmfTiEfzq3hMXLiMvhDwih9y
 DKtVNR140lnGBJUchs>
X-ME-Received: <xmr:taVOZyE4kqP5JaHyxfJ9ZAJ-A-9sl-JalbOksmQVPAmXiHeRHyBMWu2DQnIARXOx7u5S3SOQZqBGU06bTxtI9Tw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddriedugddujecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
 tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
 hsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhr
 ohhmpefmlhgruhhsucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqe
 enucggtffrrghtthgvrhhnpeejveehvefhhfdvgeevteejvefgveegueeuheffueevvdej
 jeejudehieeuffekhfenucffohhmrghinhepghhithhlrggsrdgtohhmnecuvehluhhsth
 gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgv
 vhgrnhhtrdgukhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtg
 hpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopehp
 vghtvghrrdhmrgihuggvlhhlsehlihhnrghrohdrohhrghdprhgtphhtthhopehkrdhjvg
 hnshgvnhesshgrmhhsuhhnghdrtghomh
X-ME-Proxy: <xmx:tqVOZzT4_qSQ65_-61xPZ1FAeCdKOaz3BDVIlkDCAq8FWB06hX5eHA>
 <xmx:tqVOZ3wqwnd9BMNMqmuwoDFvQkqcHh2sPYs0yjk0a-qFTeXiy0pStg>
 <xmx:tqVOZx4bDqPfss5JhXXgZaWrl1ly2l_goiFriq1__wZecpSHazHkdw>
 <xmx:tqVOZ0wRpI8Pp5FPzWVmTJs0pgcHIyjr7DlOLUv9cBzP4fVw8lb9KQ>
 <xmx:tqVOZ3-GpzrCYjN79bG7adsz1_fRW0N7DgIuUVX14q4w6kaCOIQxchAW>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Dec 2024 01:31:17 -0500 (EST)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: [PULL 0/4] nvme queue
Date: Tue,  3 Dec 2024 07:31:07 +0100
Message-ID: <20241203063112.9135-1-its@irrelevant.dk>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.152; envelope-from=its@irrelevant.dk;
 helo=fhigh-b1-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Klaus Jensen <k.jensen@samsung.com>

Hi,

The following changes since commit eb22a064455aeebc105cc89bf77f48aa18b52938:

  Merge tag 'pull-request-2024-12-02' of https://gitlab.com/thuth/qemu into staging (2024-12-02 16:16:15 +0000)

are available in the Git repository at:

  https://gitlab.com/birkelund/qemu.git tags/pull-nvme-20241203

for you to fetch changes up to 6651f8f2e5051f6750c2534ab3151339b3c476a2:

  hw/nvme: take a reference on the subsystem on vf realization (2024-12-03 07:28:27 +0100)

----------------------------------------------------------------
nvme queue

----------------------------------------------------------------
Klaus Jensen (4):
      hw/nvme: fix msix_uninit with exclusive bar
      hw/nvme: fix use/unuse of msix vectors
      hw/nvme: SR-IOV VFs must hardwire pci interrupt pin register to zero
      hw/nvme: take a reference on the subsystem on vf realization

 hw/nvme/ctrl.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

