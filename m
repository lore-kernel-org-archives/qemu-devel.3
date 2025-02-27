Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0E5DC19F2E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 09:31:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnaDv-0007cx-5T; Thu, 27 Feb 2025 04:30:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1tnaDt-0007bf-2j
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 04:30:29 -0500
Received: from fhigh-a1-smtp.messagingengine.com ([103.168.172.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1tnaDq-0008DL-Nt
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 04:30:28 -0500
Received: from phl-compute-09.internal (phl-compute-09.phl.internal
 [10.202.2.49])
 by mailfhigh.phl.internal (Postfix) with ESMTP id A0ECC1140BC5;
 Thu, 27 Feb 2025 04:30:22 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-09.internal (MEProxy); Thu, 27 Feb 2025 04:30:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to; s=fm3; t=1740648622; x=1740735022; bh=7vtb381evc
 DOFyVQn3AGe148GfjDnLjFE5QqPYCvPk8=; b=dLHZYm+0g60UFpSfDqkSdyUHhN
 3fEnxIarHBCVq5/7wpjjq5Dy5nwBLGD+1Z6sWb2ZXRTekv8b0XfGCHdE4no9pn3r
 gsoo34krFDXnYz/iktXPTqnB5KvO885L/5M2yzjLRcdMTBwhgducUVVjujW7piw0
 6gcHqPw7MHzfA50072v3H2uyOF4j0IeDMMJhRFSUwfeammnNnNnkAUhdHK0WcyRz
 SGCCoXNBQ1jHiD2Q8X9PuHKcRUhwz5/eol86R5iY9UiR0AsAI0npAb7qnRmbHnCp
 x0qFmPYgUGksN++6DH2p4CJ/uSuLo4oOi/PA/yDsynhRVH1IzM4NR4y0ywfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1740648622; x=1740735022; bh=7vtb381evcDOFyVQn3AGe148GfjDnLjFE5Q
 qPYCvPk8=; b=lVBKflysRS3DpBJafvtJFBLCx98Fb87GFSooYi/onyBw0/6dOzU
 qoBVOcHGpchDNR8dmDqzZOuZ8r1MoJ2ZT4TT9XFUFAdHUPP7UHKnWFHjU5QnfXlU
 YAmZfnMBjwR3WIpb2MN+zmmow7fLIiQEeh+JTPUEtxHlQm5B1dNdD6pdMf7CAA8z
 BJzVwkxPAVEv5y5vwNwF5q2TO9Nhio9/GWIerzwBZRWN9VnRpS0EtYRl89Z2iXX3
 xeRGTASNHvSTggd/E7T8+R2RRSNN5Q050JYeRxuyIiX+SMhZAl7i/viJ7lAGvxt0
 VIEfI3KaIzovj3ZHz3Z4gE06LWwPfTmJDew==
X-ME-Sender: <xms:rjDAZ-KCfK7vetobV-HTQoDMcsXTbOlupvlzGM3JW_JpdYAmfIi4zg>
 <xme:rjDAZ2Li6BRZHyYAKXroZyJIs9hdUPCJaW5CByGs0F_8zIuMZ1COSIg22fTTHRe0A
 2RpIOq2tVDi9sskBco>
X-ME-Received: <xmr:rjDAZ-vHRMhjkTdQ0-0WhM18xqQxvKi8z4FtV3PC8X-07PQE8WAedpsNo35p2pgnLBco5LIcZLKRBCxGYtQwBaH7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekjeduudcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecu
 hfhrohhmpefmlhgruhhsucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrug
 hkqeenucggtffrrghtthgvrhhnpeetudfhkeetjeeuleeihfdtudejteelhfdtkeeggefh
 teduueegvdefgfehjedvhfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhtlh
 grsgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
 ohhmpehithhssehirhhrvghlvghvrghnthdrughkpdhnsggprhgtphhtthhopeefpdhmoh
 guvgepshhmthhpohhuthdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhu
 rdhorhhgpdhrtghpthhtohepphgvthgvrhdrmhgrhiguvghllheslhhinhgrrhhordhorh
 hgpdhrtghpthhtohepkhdrjhgvnhhsvghnsehsrghmshhunhhgrdgtohhm
X-ME-Proxy: <xmx:rjDAZzatbWzXMnJaoTMsDzE-gzOqre5u8RFNA8yvACrm6elaC-_GOw>
 <xmx:rjDAZ1YIXXK8eX47Iv4b7E-THT4owFm_bTv41jLN1KcMgHdrJA_gaw>
 <xmx:rjDAZ_BsSAud0j7boURL_2GbHKinFvBYICwOIKDU7GvIQrKBuI6JcA>
 <xmx:rjDAZ7aTk9-9bRGpOR4038-2vkPE1sG7VbwnGbLM2LRCUYD6w6Axbg>
 <xmx:rjDAZ5GAVyRToWEhwp1w7OTQ7HB4ePfYdUXuix1VdwONccN4sheEuVIa>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Feb 2025 04:30:21 -0500 (EST)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: [PULL 00/10] nvme queue
Date: Thu, 27 Feb 2025 10:30:07 +0100
Message-ID: <20250227093018.11262-1-its@irrelevant.dk>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.152; envelope-from=its@irrelevant.dk;
 helo=fhigh-a1-smtp.messagingengine.com
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

Hi,

The following changes since commit b69801dd6b1eb4d107f7c2f643adf0a4e3ec9124:

  Merge tag 'for_upstream' of https://git.kernel.org/pub/scm/virt/kvm/mst/qemu into staging (2025-02-22 05:06:39 +0800)

are available in the Git repository at:

  https://gitlab.com/birkelund/qemu.git tags/pull-nvme-20250227

for you to fetch changes up to cad58ada8f104bf342097a7a683ef594ac949c8d:

  hw/nvme: remove nvme_aio_err() (2025-02-26 12:40:35 +0100)

----------------------------------------------------------------
nvme queue

----------------------------------------------------------------
Klaus Jensen (9):
      hw/nvme: always initialize a subsystem
      hw/nvme: make oacs dynamic
      hw/nvme: add knob for doorbell buffer config support
      nvme: fix iocs status code values
      hw/nvme: be compliant wrt. dsm processing limits
      hw/nvme: rework csi handling
      hw/nvme: only set command abort requested when cancelled due to Abort
      hw/nvme: set error status code explicitly for misc commands
      hw/nvme: remove nvme_aio_err()

Stephen Bates (1):
      hw/nvme: Add OCP SMART / Health Information Extended Log Page

 docs/system/devices/nvme.rst |   7 +
 hw/nvme/ctrl.c               | 460 +++++++++++++++++++++++++++----------------
 hw/nvme/ns.c                 |  62 ++----
 hw/nvme/nvme.h               |  11 +-
 include/block/nvme.h         |  63 +++++-
 5 files changed, 373 insertions(+), 230 deletions(-)

