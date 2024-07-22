Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 203AFC3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 16:42:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVw5m-00024b-0P; Mon, 22 Jul 2024 12:40:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1sVw5b-0001lv-3l; Mon, 22 Jul 2024 12:40:44 -0400
Received: from fhigh8-smtp.messagingengine.com ([103.168.172.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1sVw5W-0005uh-7U; Mon, 22 Jul 2024 12:40:42 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id F33B611402A2;
 Mon, 22 Jul 2024 12:40:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute3.internal (MEProxy); Mon, 22 Jul 2024 12:40:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:message-id:mime-version
 :reply-to:subject:subject:to:to; s=fm2; t=1721666434; x=
 1721752834; bh=dor7xVV1uAiOXa+SOLSC6Wu6sdXs2BUGHTmNPc6GmUM=; b=h
 Mqk77Jx1SoQMawfnc8QlduIUntcHA9UCREh6/BBysz2qf/VTefn6GA0rbcqleLoC
 ruIqSXCYLtOgvi9lTTKARgO8J8biZOVdwPx2x8i/VydaAu6BqSUyz9aMShJQ1n2X
 SL1aScaPJpIZ1XrlAA/N9j8ddStBDFnECdg1izgapIyMIUx0TqR+dl3fHX5Z/4Mb
 eq+fXVJvxOE8OKUSlj3BelJR+8rMg3SxM+tM97p4TNaqE/EHX7Anm992bGA1ulsj
 O7hvzZanH4DWHePS0DQGtzuQxkFQHR79bCHo1TOfoKMNlqzQogPOJub2z/Njg8VB
 xWNsOtJEJW41qYjeapkHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; t=1721666434; x=1721752834; bh=dor7xVV1uAiOX
 a+SOLSC6Wu6sdXs2BUGHTmNPc6GmUM=; b=cJwahGYKg2nVkeNUtVLCL2efi4lZE
 tN6soLeA1U6Q5sXI0IeE4rnXE01Y9mLllvBZo5QjTBKOJRdLxl99PQ3BQlR9gy/y
 0fgjNxUaJi/Et15V8LcxK1Ob6zhrQTsK0kEqdXFJI370TB0ZMQD15a/9eA79YRGH
 0idj0+zU+UiyNwfq82ESVjr2ESKFKM0EgAzhcMf2n3bfZookZTjZythDVlBmcSu8
 FaPyWMw45FHus7ms2VCSV9Q/qZ4j2tTC73wsmznBObhAMA2BCBRbdMpZCQqA1rYU
 Ms+5n1+ybnZPsZU+4XduHd3UNFv8N5Fp4LkkAhwagPtxDo8ittzfc7eHQ==
X-ME-Sender: <xms:goueZitNXDWrE8gUTN1nAIThB39LqQcbpauHZrDotTdk1gCOAW6QgA>
 <xme:goueZneZO1tN4-LncrMGPlR-oG63Wh2uQ9vizHZVmD1FR2i7FP1mP2chXTAkKI5rO
 0Z4bFQAFhwt4s-PHaw>
X-ME-Received: <xmr:goueZtyZVQf99I-A9TNKbamoDh7dynIKRqwR2kwEv2SXpTTJ4bOh1BgU-8r2gZIK9wjbFCWipg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrheejgddutdegucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofgtggfgsehtkeertdertdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeehheegffeufeehleeivdduffeivddvjeegudefffethfehgeevgeetffeggffg
 ffenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhgihhtlhgrsgdrtghomhenucevlh
 hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhr
 vghlvghvrghnthdrughk
X-ME-Proxy: <xmx:goueZtOWYetNVHGUSMc64LUbKlKg_Du8nEG5x49k6IxgG2dGYq4IcQ>
 <xmx:goueZi-O1iZf2sUu0AW73Kurcv1bLSG3uvA76I3FjNPGv5YotQV_Xw>
 <xmx:goueZlVgU6MOFI9FfOencGmdOyIah9BqG18PeAZ3PAayVz46x2gRcA>
 <xmx:goueZrfzBWowLP7yGaA64WAIW01QPAU8-5wI8oBhBNQqaJXkIJUq5g>
 <xmx:goueZtVPAq3AkzxLHjmK02FTFGrWjpJQtkZL-FEByBIuifndKedjf_rT>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jul 2024 12:40:30 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>, Keith Busch <kbusch@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jesper Devantier <foss@defmacro.it>, Kevin Wolf <kwolf@redhat.com>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: [PULL 0/4] hw/nvme patches
Date: Mon, 22 Jul 2024 18:40:27 +0200
Message-ID: <20240722164026.61128-6-its@irrelevant.dk>
X-Mailer: git-send-email 2.45.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1524; i=k.jensen@samsung.com;
 h=from:subject; bh=osyUU3JmlwXK6ks/RDKLwDTpJxW+CgAjH8XcEzJzMyg=;
 b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGaei3rMtLpRJ1KQlzUhS1Uh1PrctHhI6cnUT
 SeSot2ktSvXMIkBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJmnot6AAoJEE3hrzFt
 Tw3ptKoIALLA95MAQ4tZ4TEFisieCCSOKuLMWMuAo3GIwplE3xLxsfZxNgG2xGIO9Pqg/GH/7Xt
 5P/YhUiAmyO0/IUuE4obRnOIQGo+M6YM/2cGjTRBbkwnaRNAKw8muvmZGHJJ4JLO6cJi/wSonZm
 XDX6WwUGPuc8p9drQIpLPUayvIkRQ2xbyXlrfR1tDHn8Qa04YHtMilOAGUKq8zMCWZRpXr/jFLK
 +jA3CFB0TVDPZzwaPj1/dCbd8YSqoflHHPAkuskDf59zxMC7JbEIy1+U9GJhX9V1ONjYO69uFys
 Dzew23jXgU7xA6e14sWMpqxcbGrqDwvU9DXjm9pYzSbKcC2HUM9kfbNT
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.159; envelope-from=its@irrelevant.dk;
 helo=fhigh8-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit a7ddb48bd1363c8bcdf42776d320289c42191f01:

  Merge tag 'pull-aspeed-20240721' of https://github.com/legoater/qemu into staging (2024-07-22 07:52:05 +1000)

are available in the Git repository at:

  https://gitlab.com/birkelund/qemu.git tags/nvme-next-pull-request

for you to fetch changes up to 4ea3de93a353b4462d96edd94be08d3be9484947:

  hw/nvme: remove useless type cast (2024-07-22 14:43:17 +0200)

----------------------------------------------------------------
hw/nvme patches
-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmaeiz4ACgkQTeGvMW1P
Dem5DggAkudAwZYUlKLz/FuxmOJsZ/CKL7iIu6wE3P93WTTbi4m2AL5lMFz1bOUH
33LtjHz51bDvOsnhAwLs2TwjfhICiMJCOXEmxF9zJnO4Yo8ih9UbeE7sEukpxsVr
FJlAg5OXhdIHuo48ow7hu7BqMs58jnXhVA6zSvLU5rbKTSdG/369jyQKy5aoFPN0
Rk+S6hqDmVMiN7u6E+QqPyB2tSbmNKkhPICu3O9fbHmaOoMFmrcvyxkd1wJ9JxwF
8MWbuEZlIpLIIL/mCN4wzDw8VKlJ26sBJJC1b+NHmWIWmPkqMeXwcmQtWhUqsrcs
xAGUcjgJuJ3Fu6Xzt+09Y+FXO8v0oQ==
=vCDb
-----END PGP SIGNATURE-----

----------------------------------------------------------------

Arun Kumar (1):
  hw/nvme: add cross namespace copy support

Ayush Mishra (1):
  hw/nvme: actually implement abort

Yao Xingtao (1):
  hw/nvme: remove useless type cast

Zheyu Ma (1):
  hw/nvme: fix memory leak in nvme_dsm

 hw/nvme/ctrl.c       | 404 ++++++++++++++++++++++++++++++++-----------
 include/block/nvme.h |  37 ++--
 2 files changed, 330 insertions(+), 111 deletions(-)

-- 
2.45.2


