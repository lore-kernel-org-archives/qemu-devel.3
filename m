Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DDBEC87FDB
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 11:27:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulQfW-0002sc-CW; Mon, 11 Aug 2025 07:26:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1ulQfU-0002sJ-C7
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 07:26:20 -0400
Received: from fout-b3-smtp.messagingengine.com ([202.12.124.146])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1ulQfO-0004bN-7g
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 07:26:20 -0400
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.stl.internal (Postfix) with ESMTP id 73A9A1D000A1;
 Mon, 11 Aug 2025 07:26:06 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Mon, 11 Aug 2025 07:26:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to; s=fm2; t=1754911566; x=1754997966; bh=mko7MRD6Df
 WZ9rdWONVab/l16fr47PYuFsmcFqnQvF0=; b=G3jpIs0iwGDStOh836otsT3Xla
 MmYCo2t2T2JOiVh6dsZKZevfMfkKrM2EgoNdm5maNDVJFiPiUcL8oM2DJtassGfU
 IsjqouZJaajpf/5/3YqWa9Z+rvCMaWzDU0SLHRPk1ynXE257/mKEXXhOMFz8Jd3s
 a538DttqrdmvSVP0PUFZMXcVEPU9CIxH2EQxRYSxXttjJCI8uVlCRkANSu4wCh7j
 bThDXL0AulzERf6leMF5TSdgLzmVUF1xnQZyOvcjuGxXUak8jJ3PBYOs0j4Tm9PI
 KSRdkj/AS/07Nl8rQtnQnV4sGlTiFZiSYlNb34lYPgBrn81vCHNvMZxO7J2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1754911566; x=1754997966; bh=mko7MRD6DfWZ9rdWONVab/l16fr47PYuFsm
 cFqnQvF0=; b=H+BI/DHysS3KPBQPjuyDdVACfmOJsKLAODqqOZ39omaxgf2ILPf
 Qn0lg4r9AFa06fAL5wybyuY1trN17ZPBf3SvZEEx2xuujIRwrcQMqyhMUnmJr6i2
 uvpDEsrjPLcaR/r2baxvJi171PpcfR/S28WIjz8wk4g3dvYHv4usy33GPGnrWAWG
 7TA1HRz4+756ZODXPgnskIdih1VMJEFhf9NhKK1H8f3Tb9dUSwRACyvAyVZttuWG
 q+K7PSvAiWPgF7zZLagVtlPDH2SxmhaAf0wo1oB9OGFQwao3dwIdZNROc4jRn4dR
 ZZw/9yalZ6sHAxKZhmW8PS3KegRDtbfjR0w==
X-ME-Sender: <xms:TdOZaHVnElHnlUfEYCQztwDQXrAiUrHHwt6mw9BSvbceG5aQfdtpUA>
 <xme:TdOZaJPdOb8mIOuZzf4Gs0rRtjrft0p5zEuZTpN_NgjlinwnSLdwzQgdWCf18TwEE
 dWawAVZxHkzOPEwl2c>
X-ME-Received: <xmr:TdOZaDZhC9jWuHBs9Ed_MocjCZxbTZvceu0_Aufz4E3g0PFG381Q2ml_7c6sC8QR4SxnDhC2SrRtgt3s9qymJJ37>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufedvfeefucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepmfhlrghushculfgv
 nhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvghrnh
 eptdevgfejhedtveduhfelleehueejleegteeiueekfeelvdehtdegvefgkeevtddvnecu
 ffhomhgrihhnpehgihhthhhusgdrtghomhdpghhithhlrggsrdgtohhmnecuvehluhhsth
 gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgv
 vhgrnhhtrdgukhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtg
 hpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopehp
 vghtvghrrdhmrgihuggvlhhlsehlihhnrghrohdrohhrghdprhgtphhtthhopehkrdhjvg
 hnshgvnhesshgrmhhsuhhnghdrtghomh
X-ME-Proxy: <xmx:TdOZaFrwdNwbe3brAWUTedQyBlalaCGPT5jPNKTaq43zoWEzYQG59w>
 <xmx:TdOZaPa1fXX_xHHr1iSMwTNnmvQZJJCjQ-C6LCmUdb27Ce9IgA6tXA>
 <xmx:TdOZaFT5KnVjyDsAxGK4dmhWEWuVb11LiF1Vk2GNMTAwDmQO0erYcQ>
 <xmx:TdOZaO4hTzuyOJGgAbz3AskUbeytNK_hMMG4_Cqs5j0vSGJ2rorxpg>
 <xmx:TtOZaFr0B4T0jc4l5gnvFus_Q8VMI6-M43BiH_sSe5ONzE_pQV573hHb>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Aug 2025 07:26:04 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: [PULL 0/3] nvme fixes
Date: Mon, 11 Aug 2025 13:25:54 +0200
Message-ID: <20250811112557.521-1-its@irrelevant.dk>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.146; envelope-from=its@irrelevant.dk;
 helo=fout-b3-smtp.messagingengine.com
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

The following changes since commit a74434580e1051bff12ab5eee5586058295c497f:

  Merge tag 'pull-loongarch-20250808' of https://github.com/gaosong715/qemu into staging (2025-08-08 09:49:06 -0400)

are available in the Git repository at:

  https://gitlab.com/birkelund/qemu.git tags/pull-nvme-20250811

for you to fetch changes up to 53493c1f836f4dda90a6b5f2fb3d9264918c6871:

  hw/nvme: cap MDTS value for internal limitation (2025-08-11 00:17:38 -0700)

----------------------------------------------------------------
nvme queue

----------------------------------------------------------------
Keith Busch (1):
      hw/nvme: cap MDTS value for internal limitation

Klaus Jensen (2):
      hw/nvme: fix namespace attachment
      hw/nvme: revert CMIC behavior

 hw/nvme/ctrl.c | 43 ++++++++++++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 15 deletions(-)

