Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51E4D106F2EA
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 08:25:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5g1G-00034z-G6; Thu, 26 Mar 2026 04:24:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1w5g1D-00033m-JE
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 04:24:43 -0400
Received: from fhigh-b7-smtp.messagingengine.com ([202.12.124.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1w5g1B-0006ki-EC
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 04:24:43 -0400
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.stl.internal (Postfix) with ESMTP id C97227A0203;
 Thu, 26 Mar 2026 04:24:37 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Thu, 26 Mar 2026 04:24:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to; s=fm3; t=1774513477; x=1774599877; bh=0ojE2zDt02
 q+VyX4VkO8harfxDa4mKGLDDUf6MTHftk=; b=X7Y6k3PJ07eClyZ3B1TQl1yOpD
 oTZYC4Rhcn2B6ILJvg62uI7nBfVeJf6VJcKdWrNNXRKDTS/sH443lC/UY4EsR9LG
 W0dOCw6ySBRGXTgNq1oWgXOxBY2L68Dt79d5cdTilZZZ8xaSzQEVR0Jlm6zVDgXM
 Hy8cdEt9Q649REAOdBUcKKnkKj8G7iU6gjT05RSrJHFVis0iKxOL+zyAPzDWS7WN
 ++e+SrZvkxNNpICh/DpfljGRO/W2Mg8AaqT79IubY7mttcwROiHuAfASU+cP+9ys
 zRRknro7R5PyFGKWLzjKRIfC81R0R71RAyiNAvJLRSYPBG53jsdldJsJ74mA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1774513477; x=1774599877; bh=0ojE2zDt02q+VyX4VkO8harfxDa4mKGLDDU
 f6MTHftk=; b=lz+BBgmtrBObyWT0PRiAcliHfrji3el8ENpnt55tC6qA26Knt+Z
 en2VMS4JZbEAUJiZfjdu8il7WjvDM0nLghoh9sQnaGq8JwEuiNwHqPZZ4wrDx2RF
 2yiv4oiU57WdMNh8KacKaSGuAxdNypHz3X7dNuIOeStpc+BOtsuahB4d4pPJHATC
 5VXAfqHLhg9nnRmhxBD7rXxRFfoldPElQC2c8ITmqBYAHimF4eMnmW4s9ffGwFYr
 K9DvYmpChKvEul7prWkHpMBoMHlWL/i8AUDGByC46tOSmw+KV27cem+7SBBwn2Iu
 BISn/3sGWx5PfaNtl6AyLQ0aWV5eSkDeOgA==
X-ME-Sender: <xms:RO3EaS5pQ1OLO6LloZblSxrgoMyeFTalSnhh4DD_0DbKMn80XMepnQ>
 <xme:RO3EaQMIM3yov5j0yOEjlaAFkYLTUCTndAEsP5sQNjQ7fPlwR_sQdWnU2lHPHOKP4
 cEW9kHWpYO3uGRTaBbeAH7E4W-JbpvfIK5RnnQ7wFFojE-jBG_-bY4>
X-ME-Received: <xmr:RO3EaQnORZOrQRTf9nRrmsIRuwL13Wf6XjTkW0uX09Ti8gf6s6tr9TIRiMA1ahl0cs2OubX1h2FKy76DvlmzSCBJ-UNELMyZ4YPlAwlmuQ-9Utja6OMnWCvAUA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdeikeekucetufdoteggodetrf
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
X-ME-Proxy: <xmx:RO3EaXTH8tt7BdgIaVxz-tmTgc7yvJE00uAKqPzyqbaV7VKMlPKxYQ>
 <xmx:RO3EacAs_3ALwJsNVbNFA4LLtTFWZBbkgJRY4hyQAiN2K3JV50SWeA>
 <xmx:RO3EaWQRpQjLDUCEg4kTIdkoSIJzMCYECbsnO0Rv_-LjJuazPAIgvA>
 <xmx:RO3EaSq7eSa1TnpOA2gpw7m4Ukk8liG_yXg5mkKYTX7h_I4wjLh5tw>
 <xmx:Re3EaVf6XW4tUYrpiOZTqMUosrAkK4RDwN2NxIUzq4A_dfpU9TEmI_0k>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Mar 2026 04:24:36 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: [PULL 0/2] hw/nvme fixes
Date: Thu, 26 Mar 2026 09:23:47 +0100
Message-ID: <20260326082350.17374-1-its@irrelevant.dk>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.158; envelope-from=its@irrelevant.dk;
 helo=fhigh-b7-smtp.messagingengine.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
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

The following changes since commit 007b29752ed06e467d3c830bc2c17a8851f8bcd3:

  Merge tag 'for-upstream' of https://gitlab.com/kmwolf/qemu into staging (2026-03-25 09:16:13 +0000)

are available in the Git repository at:

  https://gitlab.com/birkelund/qemu.git tags/pull-nvme-20260326

for you to fetch changes up to eb5cc99aff17cbfdad16b18d3503c6f22233eeb5:

  hw/nvme: fix heap-buffer-overflow in nvme_abort (2026-03-26 09:14:35 +0100)

----------------------------------------------------------------
nvme queue

----------------------------------------------------------------
Kaixuan Li (1):
      hw/nvme: fix heap-buffer-overflow in nvme_abort

Pankaj Raghav (1):
      hw/nvme: re-enable wzds bit in namespace dlfeat

 hw/nvme/ctrl.c | 4 +++-
 hw/nvme/ns.c   | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

