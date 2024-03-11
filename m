Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BB0BC5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 19:12:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjl3T-0001l4-Vz; Mon, 11 Mar 2024 15:11:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1rjl3R-0001kG-Jv; Mon, 11 Mar 2024 15:11:21 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1rjl3O-0000AC-KJ; Mon, 11 Mar 2024 15:11:21 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailout.west.internal (Postfix) with ESMTP id 2285C3200A01;
 Mon, 11 Mar 2024 15:11:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Mon, 11 Mar 2024 15:11:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:message-id:mime-version
 :reply-to:subject:subject:to:to; s=fm3; t=1710184272; x=
 1710270672; bh=V0fDufD91kX59kpXGc/SCyuUMP/Gf1Jc8S7tKovE/Xw=; b=G
 Dq1hv9Pd9TGEmuaJfW+1AIgeTjRgtAaquK1Iv4BerqdQGqXU/IhRBvuSENw51c5g
 MNBlrDAIkmSPu+FS4Qtlaw0cT4uVZdkzvFz6BdDzDfTQd/bIbIy8+M7HrlMulSCA
 AWfC3+CPrvV8P3pM29Tn5ymzrzJO4pgh/HYK80ARLjgtkciJGIrsl3PVMzUDxHA8
 yMn3yTbf3VQDw+erFp0w1G+iQRBniAfSspHpzWl5mFniDc/mMXtvAmKaLkd2wSo8
 BunBjkwq+U9NLU9bwSIn8Vg6bGt+JgEujxQg7Y0eBM6DXGk8fYPARhWBy3envZH8
 5GEm2it6OSM0UyrJYhLog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; t=1710184272; x=1710270672; bh=V0fDufD91kX59
 kpXGc/SCyuUMP/Gf1Jc8S7tKovE/Xw=; b=UOTuNpL2uXv4/+OFhrZkNBL/venfJ
 D5KJp8aXQqZu3WWuigNhV8um38UJX8y1BzXuyvje25ljSnmoG3Wd2RW2MgEKz50a
 7qvrFiJ4Qrjv+v1jFAOHD3OEn37fm7Rq725KGaCrp95VX8YQSF8rbAJJ4xjFNlKY
 H1ehQhQVGJicDaSktiAYvCQNSdvOiUj5eG1E0VMinu1g91F42q/JpuOprzGeNWzm
 dYiikrQlQfQqkTXw5j0m/WJ/BcoCONBNeup9cqqnaTBzZ+bHJMe5wqEyXD4DpPZN
 RgS9gmm5u3F4mBTBk86THdOQhwUSsei8ROn1UfDrsSqz357aZyuatBoNg==
X-ME-Sender: <xms:T1fvZUcqIH5qrhG7G2aOvj1b7GBGg6LF-w9cxX8zGVjTdBHnAAFInw>
 <xme:T1fvZWPmF21frmmqrsk8WO-kwMcL91jHiK_G5-xnOzy-OQmioQdbAwrKvzhtCyrEz
 oBVLU4jWopY6GCyDZY>
X-ME-Received: <xmr:T1fvZVhiziC_WG2KmJiaxEH4S-ilLkoG3XYx8Cn4LojTzvIAEKzLNZy-s5iyKKodwerDJqQ-Gw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjedugdduvddvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofgtggfgsehtkeertdertdejnecuhfhrohhmpefmlhgruhhs
 ucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtth
 gvrhhnpeehheegffeufeehleeivdduffeivddvjeegudefffethfehgeevgeetffeggffg
 ffenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhgihhtlhgrsgdrtghomhenucevlh
 hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhr
 vghlvghvrghnthdrughk
X-ME-Proxy: <xmx:T1fvZZ9bPqJ7zQOAVEIrOx1y_kS4Y_HRtSol1pe1VzDJ474xe-bYFQ>
 <xmx:T1fvZQuhta8BeR3VqtfgjDryWIXVsGP_1dpMEsbvSFel_X6_XYwSKA>
 <xmx:T1fvZQEQEIBE5MpbL41SGGyOK074QeG3GWNp_H1jDCq0USE_YfSlpg>
 <xmx:UFfvZRmMwrHthCmIU_AV7eNt4k5XBq_7CUPN-zswxDAeJUtqU9fxHg>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Mar 2024 15:11:09 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: [PULL 0/6] hw/nvme updates
Date: Mon, 11 Mar 2024 20:11:06 +0100
Message-ID: <20240311191105.35224-8-its@irrelevant.dk>
X-Mailer: git-send-email 2.44.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1987; i=k.jensen@samsung.com;
 h=from:subject; bh=o/yjWBw1aT1uEroTLKekNVT9i8AeBYzW9UjWfZXDHVQ=;
 b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGXvV0kqPxotP8fuU2gF0sJEU8xBaCEcvyAs7
 ePvntttK7fgeokBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJl71dJAAoJEE3hrzFt
 Tw3pKrsH/2psE7O+WohQ6s+cfwq7LKB7AMnHPtdjkmUVzX0Q6XolR6dYjUTQFkqneZ/mqYbIlaM
 BZjTKzWQ48yU0Sv72fUupBj9ECkqyFdJ7qBcex9qXxMyI/14qJx5UnbX0zlXTmtv6MGI7CoIjSu
 pf3ZlPJxeP8y/yvGugWXobnx2NfF00jjT2RXls/deANS2WqCTQUIwpq4QaUET+u7UVtoUCH8dRT
 4WZcmtdpfK/ohdxj8a0lJiBkwcx6ZKO4CCnjBe4HAjYVNDXzlx4DsHaGaHZO6B7pVI92j5KXBz2
 wbS/8x2UDycHWb8FW8J37wWo7CMMi0DmjFLrQ9uKi7I28fW5J2h0pqfB
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=64.147.123.20; envelope-from=its@irrelevant.dk;
 helo=wout4-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

Hi,

The following changes since commit 7489f7f3f81dcb776df8c1b9a9db281fc21bf05f:

  Merge tag 'hw-misc-20240309' of https://github.com/philmd/qemu into staging (2024-03-09 20:12:21 +0000)

are available in the Git repository at:

  https://gitlab.com/birkelund/qemu.git tags/nvme-next-pull-request

for you to fetch changes up to a1505d799232939bf90c1b3e1fc20e81cd398404:

  hw/nvme: add machine compatibility parameter to enable msix exclusive bar (2024-03-11 20:07:41 +0100)

----------------------------------------------------------------
hw/nvme updates
-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmXvVsYACgkQTeGvMW1P
DemWtwf9HU3cjtvCp8AeHGoPFTwp8/Vx3cQlQ6ilADKSDm44up2+M504xE/Mdviv
6y3PTPe1yiEpg/MbjWTX/df5lo+VdNoCuCyjph9mea0s1QAjCfVpl+KLMUVF/Oj5
y1Iz9PQqOVDJ3O4xlgmPTfd8NXE/frNJaiXAjFuBxF2+4lilD5kMxpyu7DXbLiy2
Szd1I3DhFAEOLEbrSSRDI3Fpy0KBdRzdKuUfmRdrHzbmhzHJefW7wnZ3aAiDboaD
Ny7y/aovmjGymMp9GrBKWhUFPfSUtJ8l8j4Z7acQs+VDxg8lcAHCJKOyqCBTspUL
PSnDe6E/CRyjrG2fUVXTLb6YW1eibQ==
=Ld7a
-----END PGP SIGNATURE-----

----------------------------------------------------------------

Klaus Jensen (4):
  hw/nvme: fix invalid check on mcl
  MAINTAINERS: add Jesper as reviewer on hw/nvme
  hw/nvme: generalize the mbar size helper
  hw/nvme: add machine compatibility parameter to enable msix exclusive
    bar

Minwoo Im (1):
  hw/nvme: separate 'serial' property for VFs

Roque Arcudia Hernandez (1):
  hw/nvme: Add NVMe NGUID property

 MAINTAINERS                  |   1 +
 docs/system/devices/nvme.rst |   7 ++
 hw/core/machine.c            |   1 +
 hw/nvme/ctrl.c               |  95 +++++++++++++-----
 hw/nvme/meson.build          |   2 +-
 hw/nvme/nguid.c              | 187 +++++++++++++++++++++++++++++++++++
 hw/nvme/ns.c                 |   2 +
 hw/nvme/nvme.h               |  27 +++--
 8 files changed, 288 insertions(+), 34 deletions(-)
 create mode 100644 hw/nvme/nguid.c

-- 
2.44.0


