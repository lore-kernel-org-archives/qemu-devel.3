Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E743C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 12:02:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFXHk-0000At-3s; Thu, 15 May 2025 08:02:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1uFXHi-000056-3T
 for qemu-devel@nongnu.org; Thu, 15 May 2025 08:01:58 -0400
Received: from fout-a5-smtp.messagingengine.com ([103.168.172.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1uFXHf-0002u3-HT
 for qemu-devel@nongnu.org; Thu, 15 May 2025 08:01:57 -0400
Received: from phl-compute-06.internal (phl-compute-06.phl.internal
 [10.202.2.46])
 by mailfout.phl.internal (Postfix) with ESMTP id 447621380235;
 Thu, 15 May 2025 08:01:52 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Thu, 15 May 2025 08:01:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:message-id:mime-version
 :reply-to:subject:subject:to:to; s=fm2; t=1747310512; x=
 1747396912; bh=ocs5ik+EPqJn6REb+q/SsVBWYLMpmEYrvWW+MaCpq/U=; b=H
 +EjnHRT8pCZYUL27kLckmjUb+miaqtYQXS2u7ro0FTqGo8mh+tH0Fduprt+DBoio
 3Ozgfgc6u1rbGP7zTc0w+EWl+qRIUO4iBr8N7YnhRHx63KSacujAUDwrTs4qW16F
 xUoMxmY07TYIU1+nz6obmfANPopOlwJF5B1Sgs0N23DV34uVueMNApqn4jeS/zkH
 QpYI9VYnmb82aU6ZpnNGgkDXCnXbnAKdKsTORz/da4xXaOrBdMs76/d+Cx+G7JpS
 Mbn0OnOOQ0RoW+7HS+3tzMOXNa8CTCZMnhpPXSy91Mdf3qiUju+UXHo/HSSPlpsd
 Qdn7J2jX27QVA0WiS3IRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1747310512; x=1747396912; bh=ocs5ik+EPqJn6REb+q/SsVBWYLMp
 mEYrvWW+MaCpq/U=; b=PwGB+YDCaiUhYDi4o53Wu/tN6Wo/+J3+69HoF4hQD9+n
 4MJ/lSWRf+bgjba4CaASG+K3XTyoE0ZDkUym59tQ3m8v7LCHoyGRmE/5oDZfn70i
 5dc7oB0nREW1AW/d9dpQ8IdjNoBq/LEeZlw5hDPHEYyrg2sQQb674D+yLzAwIdOu
 0cfQJkMIiqEr0qJuYAZgM+NcSJYheqIrAuwUjliglG1mg7mZHqL6EPQj0YdBNoO4
 iJWCQrBUvzVA+EyE9ahA+yeg/jt6Zn+I4rWOR+KneRPYOPpTC9wpijfhq7kkMlia
 VPDFgJRwwSNRTA8MkKfWhsE6Tl3kNzmRt/tmvXcW3A==
X-ME-Sender: <xms:r9claEx-hSzbNz4JAOK-40cgfRoBsG30GvI2xk8Qxo0UmS2ClIRafg>
 <xme:r9claIQqVYIgzK4oKif14dIhHoHM8055G9Kopvq5uRdwP4fCajCdZN9AKgx41w393
 p2pVtrMytUMr96bKr8>
X-ME-Received: <xmr:r9claGUKhqMFJIkw5PScGiDy4E-q-Rgn8UpmmdKmUeelZRoyuZ3OTV6plqlmtWEak5PiN4tR_JQN_Q3WoZI7eak>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdelkeduucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
 gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofggtgfgsehtkeertdertdej
 necuhfhrohhmpefmlhgruhhsucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnth
 drughkqeenucggtffrrghtthgvrhhnpeffkeelkedtudeujeehjefghfeivdehteevtdei
 keejkedvheeigeefleetfeehieenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhgih
 htlhgrsgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
 fhhrohhmpehithhssehirhhrvghlvghvrghnthdrughkpdhnsggprhgtphhtthhopeefpd
 hmohguvgepshhmthhpohhuthdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhg
 nhhurdhorhhgpdhrtghpthhtohepphgvthgvrhdrmhgrhiguvghllheslhhinhgrrhhord
 horhhgpdhrtghpthhtohepkhdrjhgvnhhsvghnsehsrghmshhunhhgrdgtohhm
X-ME-Proxy: <xmx:r9claCiXaH3WLlJt9nu6XJqaJcfFE7UjgQhTXkvnsRr8ftzwbvO3wQ>
 <xmx:r9claGAQeqKH7Dtc7lBC_KCVVZl6tIDcIsu3t4l9hOEQtnKEgvm_3w>
 <xmx:r9claDLVFbKhIqUfPevxaLgoWX4C7tzU94Skr6sEsgas99g7sxrmCA>
 <xmx:r9claNBDjMl9pW89wNqoLjeOU5Ymk1ho5G7ANVjbZv8tHEe1FobZwg>
 <xmx:sNclaJmFuEgTo2zlkbr2d-0jatwAIR-7q2Y_ObUlI4ZqQS8jSS3LPi1x>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 May 2025 08:01:50 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: [PULL 0/1] nvme queue
Date: Thu, 15 May 2025 14:01:46 +0200
Message-ID: <20250515120148.11804-1-its@irrelevant.dk>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.148; envelope-from=its@irrelevant.dk;
 helo=fout-a5-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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

The following changes since commit 864813878951b44e964eb4c012d832fd21f8cc0c:

  Merge tag 'pull-loongarch-20250514' of https://github.com/gaosong715/qemu into staging (2025-05-14 07:16:57 -0400)

are available in the Git repository at:

  https://gitlab.com/birkelund/qemu.git tags/pull-nvme-20250515

for you to fetch changes up to 0b1c23a582f7bc721a9b858c289a8d165152a6a0:

  hw/nvme: fix nvme hotplugging (2025-05-15 12:18:06 +0200)

----------------------------------------------------------------
nvme queue
* fix nvme hotplugging

----------------------------------------------------------------
Klaus Jensen (1):
      hw/nvme: fix nvme hotplugging

 hw/nvme/subsys.c | 1 -
 1 file changed, 1 deletion(-)

