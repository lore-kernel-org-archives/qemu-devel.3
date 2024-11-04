Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A3BAD1BDD9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 18:14:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t81aP-00016n-UG; Mon, 04 Nov 2024 13:13:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1t81aM-00016c-Cc
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 13:13:54 -0500
Received: from fout-b2-smtp.messagingengine.com ([202.12.124.145])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1t81aK-0004oA-6G
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 13:13:54 -0500
Received: from phl-compute-12.internal (phl-compute-12.phl.internal
 [10.202.2.52])
 by mailfout.stl.internal (Postfix) with ESMTP id 065AF114018F;
 Mon,  4 Nov 2024 13:13:47 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-12.internal (MEProxy); Mon, 04 Nov 2024 13:13:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to; s=fm2; t=1730744027; x=1730830427; bh=pH6RsUIou8
 rZjnYfvYlfkcwzaJZ24bxSjkvcQBM8E5M=; b=N1jap0y/2CM+eD4PTKup64Tu5Q
 CBxMryCk+DrvJ8DjpO3AbgWLsBqv1o+IzpkUH6zrlvuEKmSjQXAP2NKbtMAUgegN
 q0+2Xc4+FDZEvpcNuHgbSIWLGo9Wf5YHhIK0e6Q6lnZfb1BYJQyw0FfArvezxprF
 eyg3nOQqcZbESBGemjLEMynTf11Aq6HY87eXAhZ7xIK0FsSXdHYcvp5/y8cOgbRx
 0EDKABImoBg8Pj8TuhkVc+shQgc3lOKHKU84oojZ44abS4kA3AJ1PC9N0qKAN1dD
 wXNWQCUndpZwa9/8kpn4C94sZgLV3141P0UU/G7snv5fHlpG5t5DEMRR9sIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1730744027; x=1730830427; bh=pH6RsUIou8rZjnYfvYlfkcwzaJZ24bxSjkv
 cQBM8E5M=; b=DA4yka8Rf3VMmQVlOk1Sq1aOT8rXyVKiNRKM9DacZjGOrv69VmV
 EOe85efkz5IJMBMTjeP0FzAzBjBFaHIy88NCZdjHIVgX04szDxnoGiSsnPavukvL
 YHyCVsZJu/yh3DTczDQpRgnrqslWtKURBXYNKlLa+T+cmtYJNk2BqoDNjHtkrpEJ
 8CHQZTpnedD1bWnsadtbdeDQ4UlLC9S2Xqs6hSePeN7604lEPBNDzGszjoerq4A3
 tokTMvgWPwKoefFPdk0EgO5uWIqTv8n34fBDYggZyysByd12rgZyhXJemxwMXQqH
 dxoNhmHg8LL3ml1lXqUwKxRSY0R9IAnQBlQ==
X-ME-Sender: <xms:2g4pZwJM7_Y0L1R2MsWoyXcUe0EZZjAcEgAAgLR5f68qY2b_c2e-RQ>
 <xme:2g4pZwJF-zcH93GHifyhoBpvLzaxoOGbuj0FLGeXtvYqLuNzPQLrxkc147XtoheqW
 DkD_2tmdivNQNXkFmE>
X-ME-Received: <xmr:2g4pZwuGNOdxoHi2CS9-xx33UDMCzkPUZP3TSwlDSAdecaoRqb_asFiJiOdEmDo0OneQiFuYKGbQ7_lvQyM1RA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeliedguddtkecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecu
 hfhrohhmpefmlhgruhhsucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrug
 hkqeenucggtffrrghtthgvrhhnpedtvefgjeehtdevudfhleelheeujeelgeetieeukeef
 ledvhedtgeevgfekvedtvdenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhgihhtlh
 grsgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
 ohhmpehithhssehirhhrvghlvghvrghnthdrughkpdhnsggprhgtphhtthhopeefpdhmoh
 guvgepshhmthhpohhuthdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhu
 rdhorhhgpdhrtghpthhtohepphgvthgvrhdrmhgrhiguvghllheslhhinhgrrhhordhorh
 hgpdhrtghpthhtohepkhdrjhgvnhhsvghnsehsrghmshhunhhgrdgtohhm
X-ME-Proxy: <xmx:2g4pZ9Zg0gL3ZfjYmD3DjW-qNdvSQo4q1E7uh8wnarrqxr5-ZIWvAw>
 <xmx:2g4pZ3ZDH0xNSw3qXQIytjlm0-2f6v_U_aH7nIY3ZQB5yGvXs3C1lA>
 <xmx:2g4pZ5BZmoUSQxIlDQ-iRC_OiP6hTDZmvDHL2egS1n-hj4FJWuMThQ>
 <xmx:2g4pZ9YTjXL1oTynAPRSCF4S4okktg70fvyOcVf50tuu7kKnqid_Dg>
 <xmx:2w4pZzFh_l2niIxhLlOIBMbOJTsntu9eHHj1I0AoaLC_0xKR-9g9cSVQ>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Nov 2024 13:13:46 -0500 (EST)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: [PULL 0/3] nvme queue
Date: Mon,  4 Nov 2024 19:13:03 +0100
Message-ID: <20241104181306.2329-1-its@irrelevant.dk>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.145; envelope-from=its@irrelevant.dk;
 helo=fout-b2-smtp.messagingengine.com
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

The following changes since commit daaf51001a13da007d7dde72e1ed3b06bc490791:

  Merge tag 'seabios-hppa-v17-pull-request' of https://github.com/hdeller/qemu-hppa into staging (2024-11-04 16:01:23 +0000)

are available in the Git repository at:

  https://gitlab.com/birkelund/qemu.git tags/pull-nvme-20241104

for you to fetch changes up to 8f472a0e7a3c86a890e12e883a69abc65945419e:

  hw/nvme: remove dead code (2024-11-04 19:09:45 +0100)

----------------------------------------------------------------
nvme queue

----------------------------------------------------------------
Arun Kumar (2):
      hw/nvme: i/o cmd set independent namespace data structure
      hw/nvme: remove dead code

Ayush Mishra (1):
      hw/nvme: add NPDAL/NPDGL

 hw/nvme/ctrl.c       | 31 +++++++++++++++++++++++++++++++
 hw/nvme/dif.c        |  5 -----
 hw/nvme/ns.c         | 11 +++++++++--
 hw/nvme/nvme.h       |  1 +
 hw/nvme/trace-events |  1 +
 include/block/nvme.h | 40 +++++++++++++++++++++++++++++++++++++---
 6 files changed, 79 insertions(+), 10 deletions(-)

