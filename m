Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6621FCCF9FA
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 07:31:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEN7F-0002oR-W1; Thu, 30 Oct 2025 03:30:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1vEN7A-0002jV-EX
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 03:30:32 -0400
Received: from fout-a6-smtp.messagingengine.com ([103.168.172.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1vEN70-00052y-V9
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 03:30:31 -0400
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailfout.phl.internal (Postfix) with ESMTP id F3392EC01BC;
 Thu, 30 Oct 2025 03:30:16 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-11.internal (MEProxy); Thu, 30 Oct 2025 03:30:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to; s=fm2; t=1761809416; x=1761895816; bh=c+AVQO0qIt
 TooVBeHKPFxs72DRI/QQ9Y+06Y7ZD4F50=; b=BfH5tecUbwPlWwVlaw1W0X4utl
 OaY0XPqU0tZK9yTnR9+kgeMZzeOKf36BmraYVf+hhIdAxNJ1XGfiIbOCW6nAP4Qd
 ruLdUC5Jv+micVu1gfQ8/ZykQRabRcxJNHIGkUjYpSKI0Bkf7N9R178QjVe9ESPb
 8fXq6RexP/tzmS+njy823xNZ7U2yXL1P89tWeEwjfmv+M5HadYRwzxdHmyJCojeL
 OPedUS71JoIrSTyHhXmC9C4ZU/dh7+nWl0f6QPu5fcPpxXgHL9A8AoXtqXegMr9Z
 CuXVr5tGibsPygyT8QKg+FtsN0bFKCfU7IEbClv9QzVCoczewj9zhdT1W5cA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1761809416; x=1761895816; bh=c+AVQO0qItTooVBeHKPFxs72DRI/QQ9Y+06
 Y7ZD4F50=; b=eKo5mTISs/EmJgkgrNLZehCfiTx/yyVdjsrbHg+Bw8NpSddGj8F
 /vMi6cXpx0ZhkiGx8LxxCZd4nKCrvBwHFg+aosFzUbBKf9wIQeEyusEjmHUkxjz6
 hJMJwniuB2fFrC43qJ0o0mzD4++Q6tYLFXajhCdDhKAUqxKEqT7frcz/dhLYZqOL
 0LT422zDxcmxiyXK3CjwyFAL4XdSzzAoScqFn9xlfNlbwrpfAhsUCsPtie9/FNjP
 5+tLPiLqam/5x48lVkmL+wA1eV6MsjB4JNIQDDqixJpm+HhmvKTu/XHuf7siiPOt
 1OUOLYaGuO8bWDZSqSyz0n1yFXrUIDsDUNg==
X-ME-Sender: <xms:CBQDaTqR8qVNy2xNcB1Y8uhBfh0GzYqRQWWa5pRL8QKWsU51DHPY3w>
 <xme:CBQDaR_d0WEodjdHmzOw_JmIerALXUnPETA0vKT0amnDu5eF3EIx4PyYhzhhLregr
 A0fzr0UU0bZZ_UmKeCEms_ggrJkksfSPpJosbJzRFqwN1lsySP-ovRw>
X-ME-Received: <xmr:CBQDafWyLcnkL1OojPW2DmOMBJOUBXaDR4Bawc8oebmU8MlQ730rmTIQUg3EsP96XF8pmSrU0J5N7QLleYwsVmg9sUS2DOjQww_5Aqj4_61vZCsYXBtmNjWVlRogiXM2gvbcGrY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieeitdduucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepmfhlrghushculfgv
 nhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvghrnh
 epjeevheevhffhvdegveetjeevgfevgeeuueehffeuvedvjeejjeduheeiueffkefhnecu
 ffhomhgrihhnpehgihhtlhgrsgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurf
 grrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughkpdhnsggp
 rhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehqvghmuhdqug
 gvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepphgvthgvrhdrmhgrhiguvghl
 lheslhhinhgrrhhordhorhhgpdhrtghpthhtohepkhdrjhgvnhhsvghnsehsrghmshhunh
 hgrdgtohhm
X-ME-Proxy: <xmx:CBQDafBH69jb5uvHGQUdHy7AT5Jj-0KObqcFMCURU1swse0rs82byw>
 <xmx:CBQDaYxJjWRG1WhexrlCdKhdtmUt5BgDPpVMgwqWywEowrwwKIOlcA>
 <xmx:CBQDaUCcFt4-FXgtad4Klpumb7164OkE2XQaCwrVqvd5HrsKIxYMUQ>
 <xmx:CBQDadaCY9WLxuj8ZQry96yk71lshHa-_ukqF7903SHk_rtMdzaBUA>
 <xmx:CBQDabNAE8TwnajBAAN5YKLHDC8VTzfBgZbvgRUqFfSnDRHNGJlyfEnr>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Oct 2025 03:30:15 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: [PULL 0/7] nvme queue
Date: Thu, 30 Oct 2025 08:29:48 +0100
Message-ID: <20251030072956.1194-1-its@irrelevant.dk>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.149; envelope-from=its@irrelevant.dk;
 helo=fout-a6-smtp.messagingengine.com
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

From: Klaus Jensen <k.jensen@samsung.com>

Hi,

The following changes since commit e090e0312dc9030d94e38e3d98a88718d3561e4e:

  Merge tag 'pull-trivial-patches' of https://gitlab.com/mjt0k/qemu into staging (2025-10-29 10:44:15 +0100)

are available in the Git repository at:

  https://gitlab.com/birkelund/qemu.git tags/pull-nvme-20251030

for you to fetch changes up to bce51b83709b548fbecbe64acd65225587c5b803:

  hw/nvme: add atomic boundary support (2025-10-30 07:07:14 +0100)

----------------------------------------------------------------
nvme queue

----------------------------------------------------------------
Alan Adamson (2):
      hw/nvme: enable ns atomic writes
      hw/nvme: add atomic boundary support

Wilfred Mallawa (5):
      spdm-socket: add seperate send/recv functions
      spdm: add spdm storage transport virtual header
      hw/nvme: add NVMe Admin Security SPDM support
      spdm: define SPDM transport enum types
      hw/nvme: connect SPDM over NVMe Security Send/Recv

 backends/spdm-socket.c       |  81 +++++++++--
 docs/specs/spdm.rst          |  10 +-
 hw/nvme/ctrl.c               | 335 +++++++++++++++++++++++++++++++++++++++++--
 hw/nvme/ns.c                 |  74 ++++++++++
 hw/nvme/nvme.h               |  19 +++
 include/block/nvme.h         |  15 ++
 include/hw/pci/pci_device.h  |   2 +
 include/system/spdm-socket.h |  65 ++++++++-
 8 files changed, 571 insertions(+), 30 deletions(-)

