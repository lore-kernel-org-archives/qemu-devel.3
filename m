Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CA94C41513
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 18:06:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRy9z-0006fS-AU; Thu, 11 Jul 2024 14:04:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1sRy9x-0006bV-7p; Thu, 11 Jul 2024 14:04:49 -0400
Received: from fout1-smtp.messagingengine.com ([103.168.172.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1sRy9u-0003sl-LQ; Thu, 11 Jul 2024 14:04:48 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailfout.nyi.internal (Postfix) with ESMTP id 930D8138815B;
 Thu, 11 Jul 2024 14:04:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute5.internal (MEProxy); Thu, 11 Jul 2024 14:04:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:message-id:mime-version
 :reply-to:subject:subject:to:to; s=fm1; t=1720721082; x=
 1720807482; bh=8g4xWCh/FOgHmzLkf2Khlt/sEF0pA2YQobBDEGZwuPs=; b=O
 lFXu7awNerb6CAKN0ZgOQ2X/fNNwEGMENmgFKEc0FaG+lC0bkRgT/aVtngPvhGPd
 71RB6lSrF2I1509AEXRVmAaNCIQLq2n81Rd2RLkE+PTdMAzjn17daXPZuhackAa7
 PtaBK1YGBbSV8WVdVMePG74oTVzrE2+B75uxfNcbO+scFhw0Hu9xv/BeVXlN09RD
 tJrBIxqVuamMNuv5cEQy20xSRh/OXmQYU0n53yHSn3JDo2i3OC+KCwgBEg9ibRvQ
 vLRpacJDwthEHqLTxH1Lh82kTheJ79RU8KxMwZmjmyaB33AfQrDg11aioS5cYoTz
 1UHnK5+qB1nocM8bLSbVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm2; t=1720721082; x=1720807482; bh=8g4xWCh/FOgHm
 zLkf2Khlt/sEF0pA2YQobBDEGZwuPs=; b=F5zSJaWtlTMe9B+0UrNwQbvD76qz6
 W6Iss7yDF4ru164OmDXa2wQXwTpDDWRPTegF8GQ5+MMRT4YCHeR1HHpjuVnPV9pV
 88Er8txLe7taFo8VcgSs2Txxs7v0J8TEu++KTxaH6+wSxbY6GpZle5k1YYBk0uNH
 Cj019qIm2k5F3clGQFlJJpesoiBYV4O126BuorijUi6vS4myl9yj15IC4r5BSwhX
 JyUvk2fuhXlX5ww0wBqzxOOreYj2BsPfVo4ckS/ndJcWb6ucD/ErEGdJE4qfQKmH
 1LW+YkqM41PMk+xdA9UHUfwLwWJssn5CBblzW3Wy7e5I7qAEdD9B+JfGw==
X-ME-Sender: <xms:uB6QZuHrhkTYqCP_5vd4egACRPb9evx07a36-o_bylQAAcgB2aKehQ>
 <xme:uB6QZvWwwD5Ax5B9vle7NxqXnZNPKVocrQFL2hu_w_TBYax0UbwE-co4OPc9uGmCp
 NIzszq75GYt7g9hcyg>
X-ME-Received: <xmr:uB6QZoLOQ2a8h9M9HljDsWGGaGKwAarsPy6XjrpNs3Xkvepm6gakq3lHvv9sICqFs0OUAwSPsA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrfeeggdduvdduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofgtggfgsehtkeertdertdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeehheegffeufeehleeivdduffeivddvjeegudefffethfehgeevgeetffeggffg
 ffenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhgihhtlhgrsgdrtghomhenucevlh
 hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhr
 vghlvghvrghnthdrughk
X-ME-Proxy: <xmx:uB6QZoElI9cs2RSwwxa4bWr9aD-ZhH6gmt8x68d-3J0W3dzfjFovYA>
 <xmx:uB6QZkWi2Npm5t4S-gIYesKlrDoMPBRS7Z09nv_OeB3FcHQEUzimKQ>
 <xmx:uB6QZrOxib4LQEu8eFCEdzy92BkqXbLgetZuRHsVBuLieY0TO-Ah_Q>
 <xmx:uB6QZr0M6VNkTzpivhSZ4gnrUHx6IpMMJ_kf977IIUv-UA-Vkmrvbg>
 <xmx:uh6QZlu2lWy_xLIQ5BpE7RIZJV4DmDMow3AA0nNFB2eUjRh1-KEfguU->
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jul 2024 14:04:38 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, Stefan Hajnoczi <stefanha@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: [PULL 0/7] hw/nvme patches
Date: Thu, 11 Jul 2024 20:04:37 +0200
Message-ID: <20240711180436.8532-9-its@irrelevant.dk>
X-Mailer: git-send-email 2.44.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1780; i=k.jensen@samsung.com;
 h=from:subject; bh=xAz9lvzyfZEUTbQVAYhXm4PvShbKTlZ1dKixzgHtpic=;
 b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGaQHrSMPupKm+dhmmXGsCytGTpiOniSYWS4I
 +gxeGZH4W8UP4kBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJmkB60AAoJEE3hrzFt
 Tw3pY7MIAJ/q+L4Csy8mXzujeW6ogSNrMBtD3xyMyxV8Ly/NrE2AQyUKm0Z78OGhPd39F7bBzjI
 EsemBzztNU/kqogVHfkUy4bf0xJOprHUbAoHWNfnGy49MLFlRMgPC0SLQx/pTUcOOWgueaImHcx
 f/MfqlfrZQE/nd9Z6vbbHgd3W8aqPTnJMJvDqAlaRoy4ufjtozg76F1ldQKQi5fY2TKJOzp4xKE
 EadfT/IePcdwLc4Asuicl8ypakL8KGeKrRLJkhGMCqv37m3yIdIHJxKdPqKNxdxFv4Ic1/iy8bF
 S4xL7YQH1trXwj5sIUedf94foT/NZVEO2MKC2fSImmlPVvkWEbIBraiw
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.144; envelope-from=its@irrelevant.dk;
 helo=fout1-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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

Hi,

The following changes since commit 59084feb256c617063e0dbe7e64821ae8852d7cf:

  Merge tag 'pull-aspeed-20240709' of https://github.com/legoater/qemu into staging (2024-07-09 07:13:55 -0700)

are available in the Git repository at:

  https://gitlab.com/birkelund/qemu.git tags/nvme-next-pull-request

for you to fetch changes up to 15ef124c93a4d4ba6b98b55492e3a1b3297248b0:

  hw/nvme: Expand VI/VQ resource to uint32 (2024-07-11 17:05:37 +0200)

----------------------------------------------------------------
hw/nvme patches
-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmaQHpQACgkQTeGvMW1P
DemukQf+Pqcq75cflBqIyVN84/0eThJxmpoTP0ynGNMKJp+K+oecb5pdgTeDI3Kh
esDOjL8m849r5LFjrjmySrTX8znHPFXdBdqCaOp/MZlgz3NML1guB5EYsizZJ+L6
K4IRLE/8gzfZHY4yWGmUBuL1VBs8XZV0bXYYlA0xKlO638O0KgVQ/2YpC/44l93J
rEnefSeXIi+/tCYEaX7t2dA+Qfm/qUrcEZBgvhCREi8t8hTzKGHsl2LVKrsFdA5I
QZtTFcqeoJThtzWmxGKqbfFb/qeirBlCfhvTEmUWXlS1z9VNzy0ZuqA2l0Sy05ls
eARbl+JnvV6ic6PikZd8dMSrILjNkQ==
=dLKH
-----END PGP SIGNATURE-----

----------------------------------------------------------------

John Berg (1):
  hw/nvme: Add support for setting the MQES for the NVMe emulation

Minwoo Im (5):
  hw/nvme: fix BAR size mismatch of SR-IOV VF
  hw/nvme: add Identify Endurance Group List
  hw/nvme: separate identify data for sec. ctrl list
  hw/nvme: Allocate sec-ctrl-list as a dynamic array
  hw/nvme: Expand VI/VQ resource to uint32

Vincent Fu (1):
  hw/nvme: fix number of PIDs for FDP RUH update

 hw/nvme/ctrl.c       | 88 ++++++++++++++++++++++++++++++--------------
 hw/nvme/nvme.h       | 20 +++++-----
 hw/nvme/subsys.c     | 10 +++--
 include/block/nvme.h |  1 +
 4 files changed, 78 insertions(+), 41 deletions(-)

-- 
2.44.0


