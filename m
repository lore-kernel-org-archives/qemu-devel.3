Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B609D5E145
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 08:17:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9KAV-0008Fh-6D; Fri, 08 Nov 2024 03:16:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1t9KAS-0008FR-P7
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 03:16:32 -0500
Received: from fout-a2-smtp.messagingengine.com ([103.168.172.145])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1t9KAQ-0005cv-Fi
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 03:16:32 -0500
Received: from phl-compute-11.internal (phl-compute-11.phl.internal
 [10.202.2.51])
 by mailfout.phl.internal (Postfix) with ESMTP id B6A9F13800F9;
 Fri,  8 Nov 2024 03:16:26 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-11.internal (MEProxy); Fri, 08 Nov 2024 03:16:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to; s=fm2; t=1731053786; x=1731140186; bh=KXr3MAb2xt
 9JmmK4NAPwu0HlL9GS9DxscOgaijQ7IQY=; b=THR+2nmc9ReBcCRolIsfN8Uqgm
 QXZNa5J6yQqqpeeS0ywgbQQQ3JuFcVYHUznM/nHZVf05cCF8h0v8L//MXYUPW4sU
 YvM7WY0pRaQJM3P4Mzu2xq/yWUCIDrUoVRBJKAcZwfrBpxMNiMUedvdjVMM9mWcJ
 psGnq1iKNWtzYezT1NyUegfuny66YOqBBbxz9BYkQTZcVvgyITBWT75fhzRutt0o
 4Cqb7Zx3HDdGIOKUkJtNr0RxjGJ3fyTRhEOC+uQQumSXmRYqDjsn4y/WmcxhYaan
 perhr9h7tf1UM9vU/PvLUZFP3T2PeBTRJmX2FBVPryM1IOvipfveO+C0WeEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1731053786; x=1731140186; bh=KXr3MAb2xt9JmmK4NAPwu0HlL9GS9DxscOg
 aijQ7IQY=; b=cAmwUxtYdkZvzjazR3VtohtslRuGD/R3r3gvQF+vfCI0NjuUy/P
 qJqHt0/1zKt3bG4ISNS2JnxAEEyX+zDBrmpBVmxcdy5qfyJNXei/cgry4rofOHPT
 g2aVJLHTyqRlGhCGMvcO2CvMHcXtAfaZF1OcJEYr098w4Axj8b/w64hRV6hsyf2U
 sQwa0Y/GF1dSPPv9N0rUO1dbX0YpwfAl3ow9jzDUuLB+mni2k5AA3mJNloHuP2PX
 nMb+MQafoI7gNlU+/Z/xStgbhzrRTqSrVpyiFcEaOTFxaT3QJ6TjkVxexpda7q4m
 rYkpfCxi/cRyNRGQFpiUtORiTu9Z/OnrVIQ==
X-ME-Sender: <xms:2cgtZx_7stpjUsQWB-W6AfAi7aq_u14kOiweepIEyfe95X8NbvWMnQ>
 <xme:2cgtZ1viXJY3erjhM09ZyXkBXnJ_hqtB4ykoKIwHLljlAd8bogF4yskIIqjHBMiUi
 EFZVEn6Fq7ozy0DCSE>
X-ME-Received: <xmr:2cgtZ_B6LgYSfiQfIIpVrl7wuYRBrNFMbKmuBziH6AxbdJ2vzIS0VrgxthV7Sf2lLmQwygduTkwWRCgpNCRKvU0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdehgdduudejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfh
 rhhomhepmfhlrghushculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
 eqnecuggftrfgrthhtvghrnheptdevgfejhedtveduhfelleehueejleegteeiueekfeel
 vdehtdegvefgkeevtddvnecuffhomhgrihhnpehgihhthhhusgdrtghomhdpghhithhlrg
 gsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
 mhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukhdpnhgspghrtghpthhtohepfedpmhhoug
 gvpehsmhhtphhouhhtpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdr
 ohhrghdprhgtphhtthhopehpvghtvghrrdhmrgihuggvlhhlsehlihhnrghrohdrohhrgh
 dprhgtphhtthhopehkrdhjvghnshgvnhesshgrmhhsuhhnghdrtghomh
X-ME-Proxy: <xmx:2cgtZ1dkYR6U0o2TSslt5hRmLsvYN5B6c3Pu6HSajjSxtFAsIJ87PA>
 <xmx:2cgtZ2OnFZ5bqH0neH41RrLGfdD4yoO4YO9jBYgW2Z1Pdr_uON19Ew>
 <xmx:2cgtZ3nTxW2IiRneNP2GTaczEHVVrrxWL6mUI7q3etFKfUetiv88lg>
 <xmx:2cgtZwtSY83UKfTSmlkbGDAUj_Sf0ro7_offMMNC92w_PRicrkDGyA>
 <xmx:2sgtZzrP_aEmcpRo3DoY2h47pstH7SIdNI34zAOrUx53dCmd-5xUfBza>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Nov 2024 03:16:24 -0500 (EST)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: [PULL 0/1] nvme queue
Date: Fri,  8 Nov 2024 09:16:18 +0100
Message-ID: <20241108081620.3663-1-its@irrelevant.dk>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.145; envelope-from=its@irrelevant.dk;
 helo=fout-a2-smtp.messagingengine.com
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

The following changes since commit feef1866d1366d651e6a3cb8c9cf1a9aabb81395:

  Merge tag 'pull-riscv-to-apply-20241107' of https://github.com/alistair23/qemu into staging (2024-11-07 15:08:05 +0000)

are available in the Git repository at:

  https://gitlab.com/birkelund/qemu.git tags/pull-nvme-20241108

for you to fetch changes up to 9529aa6bb4d18763f5b4704cb4198bd25cbbee31:

  hw/nvme: fix handling of over-committed queues (2024-11-08 09:14:30 +0100)

----------------------------------------------------------------
nvme queue

----------------------------------------------------------------
Klaus Jensen (1):
      hw/nvme: fix handling of over-committed queues

 hw/nvme/ctrl.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

