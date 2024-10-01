Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0B51CEACCD
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 14:14:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svdbh-0007Uo-QW; Tue, 01 Oct 2024 10:12:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1svdbe-0007Sf-Fd
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 10:12:02 -0400
Received: from fout-a4-smtp.messagingengine.com ([103.168.172.147])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1svdbc-00034Q-ED
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 10:12:02 -0400
Received: from phl-compute-11.internal (phl-compute-11.phl.internal
 [10.202.2.51])
 by mailfout.phl.internal (Postfix) with ESMTP id 704D01381F31;
 Tue,  1 Oct 2024 03:04:35 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-11.internal (MEProxy); Tue, 01 Oct 2024 03:04:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to; s=fm1; t=1727766275; x=1727852675; bh=tVDlkG1VIM
 f1BhFI1WXmkrLMhlGmLAqcVKSJOcbyRx8=; b=fNIvkfTt/23Z3SKGrhTXus3XHA
 F3NfFyXmlg8xUmkj3dECDqDzm3LRIsHSZPa8/svPSSm2OpslZCcSOYXlcn+clRmK
 WMT9R3xWaUFHzJHHmrZe3WNBqvWjABB8XZ3TSMn8dttB2uxza5vcYtBiyPwqa9aa
 p8tDr+ddKZxbM5nHM89vXRH6thjm+Vror5acEXlDEe3mKvtLdD6jdW+uunVFRv4Z
 DrlpIs1xKCVQ/0/98ufHkqp8BQ0FKd1RX+BlFIXciiFSo6Tw47fMHWew6ckjIqBI
 0S7mtbQeRe1ZaSk7I0hfw0vNYkYP8n6XiUavrWzJ4BLFYs4g7TCTjv20+46A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1727766275; x=1727852675; bh=tVDlkG1VIMf1BhFI1WXmkrLMhlGm
 LAqcVKSJOcbyRx8=; b=l5//QZrvC0q0wnFqqD75jVlpfIQMyoCbgi4vLucCfrnX
 BBHWmAqQGzT2zDFdpDA8vlkCD0GqZD0WwWWKSGYszDfku8AfGWMz7QWdcfdIwGLO
 wnn+zPx7IgqfANBUmW9QwlNNziJAmdubaHcvfOtvhcebWC+srN0qnFx7f53X0kRU
 yMqnc3GPgGqaEY1gn/rFTCupuuKSn0/b8sUmKFVDJupUQBP3BGQuhp/zt+GBQF+E
 CkD7lW2ikG0UCqitcgNjGGu2a2WLU3chBBMM4N6mr3JqVWGZoH2qLPKMfWcJ18zj
 Ap9hN9Ey+p7EjEFdbnHX7IlGOts9cdIMBSUVYTip3g==
X-ME-Sender: <xms:Ap_7ZgqEcEXOVif6aueidRkcWoFpjgS9qCLqYF50guq75UiQPwFAEw>
 <xme:Ap_7ZmpQt1RIxV34OngjmvAfROwegawzQ1FAZESCeLivlRvgnWAtUeS9L8CzXzLSA
 O6S_jrp0TSQdHMFaKs>
X-ME-Received: <xmr:Ap_7ZlPRZMlO5B-qbH18ArHShaORP-NOyTa2yI4-x2VNlKWa3gAXEdqg0GqGWHbRk5J1LXHpGKh5KaBrxugc6g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduiedgudduiecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:Ap_7Zn4eZYvBr7VMS-IWtEpBBS1IIzY-TQDxrd2aq6KMC_eqwIfitg>
 <xmx:Ap_7Zv7z3s-4cAjQVtpVb1YojqMNCWN4ugkwAypk_9hhDNqgEvQLJw>
 <xmx:Ap_7ZnizMoRKxzAZQoQHQ5s5jlLFKJR103FXaUM42HvXuN37X-KthA>
 <xmx:Ap_7Zp7LEcyNG43VslhDHIwVU5nzCZ78V4SlGBWYf_kKsZBV1FbjKA>
 <xmx:A5_7ZhkQAeYdziyyOoVHFjfMUt0PAp3mPOxY7nHOJ9Q2YX13UdTmVlYR>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Oct 2024 03:04:33 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: [PULL 0/5] nvme queue
Date: Tue,  1 Oct 2024 09:04:12 +0200
Message-ID: <20241001070418.28737-1-its@irrelevant.dk>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.147; envelope-from=its@irrelevant.dk;
 helo=fout-a4-smtp.messagingengine.com
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

The following changes since commit 3b14a767eaca3df5534a162851f04787b363670e:

  Merge tag 'qemu-openbios-20240924' of https://github.com/mcayland/qemu into staging (2024-09-28 12:34:44 +0100)

are available in the Git repository at:

  https://gitlab.com/birkelund/qemu.git tags/pull-nvme-20241001

for you to fetch changes up to ebd1568fc73209bbc1339a449f3df0b6c9a12358:

  hw/nvme: add atomic write support (2024-10-01 09:02:05 +0200)

----------------------------------------------------------------
nvme queue

----------------------------------------------------------------
Alan Adamson (1):
      hw/nvme: add atomic write support

Arun Kumar (2):
      hw/nvme: clear masked events from the aer queue
      hw/nvme: support CTRATT.MEM

Keith Busch (1):
      hw/nvme: report id controller metadata sgl support

Klaus Jensen (1):
      hw/nvme: add knob for CTRATT.MEM

 hw/nvme/ctrl.c       | 194 ++++++++++++++++++++++++++++++++++++++++++++++++---
 hw/nvme/nvme.h       |  16 +++++
 include/block/nvme.h |   3 +
 3 files changed, 205 insertions(+), 8 deletions(-)

