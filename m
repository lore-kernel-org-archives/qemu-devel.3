Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55DFEC531DC
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 04:46:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgGkS-0007lN-Qs; Tue, 20 Aug 2024 00:45:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1sgGk8-0007gI-Pp; Tue, 20 Aug 2024 00:45:31 -0400
Received: from fhigh2-smtp.messagingengine.com ([103.168.172.153])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1sgGk4-0004Re-Uc; Tue, 20 Aug 2024 00:45:14 -0400
Received: from phl-compute-06.internal (phl-compute-06.nyi.internal
 [10.202.2.46])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 769971151BB5;
 Tue, 20 Aug 2024 00:45:10 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Tue, 20 Aug 2024 00:45:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:message-id:mime-version
 :reply-to:subject:subject:to:to; s=fm3; t=1724129110; x=
 1724215510; bh=M8ZT15jnaJb2mMJvkrZSy/kRcoxy4wAAvpwrwVOZgjM=; b=M
 A/LlJPPX46wE0gFbVAkfL81KOugYLQb5nH/UCbtDtKidhFDhv3aH1ndzGNx9Zypg
 uWQox8YUCojrZ3ATPpXe1eZwffAvt7JeZrVJcTinii9YCXFx1OWRzwdQ6baLd7NE
 eFbx2Bes1ROXd7lL3SGYX8b/lbGJ6qda/bnLJfrVFJ7IcNaE2dzDcKnP4IZg7sEU
 qf3SzoE9Fxqjt2U26N/PvPXzVDcItP+JvrDJSN2/CT0oknNax77ZHsL11rcl2CJd
 7uiXJfttFW+HeIeNiaGgMpaiHuhPiB+MbuD7cVp9seZgPDLf6cufFNM5KqUAarNQ
 OJSwxrxvdwxVknvCerCxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; t=1724129110; x=1724215510; bh=M8ZT15jnaJb2m
 MJvkrZSy/kRcoxy4wAAvpwrwVOZgjM=; b=YaGHDjlgAqcCA4+MgFBqJOuEplVPy
 NHYpcSdRTt+0v+9WTVvzsgc6j77b32pfD8IOF3nFpOzo7YtDaNeiuDFz0SdXoQn9
 XShP36fS/G+7v734/RdA7pH4eLOAPKLERU1l8I9Ns8LiUFv0oRZU6jdLY8qghTlw
 TPS093z5ypLQgSJptyPczcyGer6kSVzd0tr+KeikZYTx4dc17qVoPSsvjFkvdbo4
 v8VEJ1KwRM7B7z4NNBnWYuS7t0dXK3/R+q3FFQg5w8MmiA+KhBuoxCGO0FFkUa2x
 gxEvwSznSAXjAH2JzEDTcXeoE5YCKDXexGU82nZTdGYV6iyWbTfDN4LNg==
X-ME-Sender: <xms:VR_EZsC2gPQgwaRAW9WIvsa06GQgtsY4MjYm95TjcjBvwFZHdTdrqA>
 <xme:VR_EZuhr9P_uIcHu_NnS0bH6lhVqKBGKztBDEMt-cnpHf81iSKWYIL76G6BD93-aD
 qy2zW40d2vjYIPA7Co>
X-ME-Received: <xmr:VR_EZvm5RDUP97YCeIlcRBvBZ3Arn-uysNPjcgyyqZUGj8rlqK3u5kKe7wKu6Mhzje2fqFA2dX1OVsmiPbrVq6Ab9w2pdrkqPnJRPA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudduhedgkeekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhephffvvefufffkofgtggfgsehtkeertdertdejnecu
 hfhrohhmpefmlhgruhhsucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrug
 hkqeenucggtffrrghtthgvrhhnpeehheegffeufeehleeivdduffeivddvjeegudefffet
 hfehgeevgeetffeggffgffenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhgihhtlh
 grsgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
 ohhmpehithhssehirhhrvghlvghvrghnthdrughkpdhnsggprhgtphhtthhopeekpdhmoh
 guvgepshhmthhpohhuthdprhgtphhtthhopehpvghtvghrrdhmrgihuggvlhhlsehlihhn
 rghrohdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorh
 hgpdhrtghpthhtohepkhgsuhhstghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehq
 vghmuhdqshgvtghurhhithihsehnohhnghhnuhdrohhrghdprhgtphhtthhopehqvghmuh
 dqsghlohgtkhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepfhhoshhsseguvghfmhgr
 tghrohdrihhtpdhrtghpthhtohepihhtshesihhrrhgvlhgvvhgrnhhtrdgukhdprhgtph
 htthhopehkrdhjvghnshgvnhesshgrmhhsuhhnghdrtghomh
X-ME-Proxy: <xmx:VR_EZixRyBG7-bV3RmIMEC8D3G0f9E9YXK4syEp3l0fP8nMZ4-n0CA>
 <xmx:VR_EZhTcC8QrUTa4vETPmT-DQBM6DS906mHpbM1fhkD_3vYcW2hj5A>
 <xmx:VR_EZtZIHdyqxrTY9z7GVN5EpI3mMxzN0QMioNyXTVoC60fn3rFlWA>
 <xmx:VR_EZqTYzTPjXR9cowlk6roYdOp4rs6s3ySw9kl_QFd_18skTbhfMQ>
 <xmx:Vh_EZsESauyo4L6wuwLLDkLqCRCg8uqTa2M-dWXomOFkC6Nd4GFJEWnL>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Aug 2024 00:45:08 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Keith Busch <kbusch@kernel.org>, qemu-security@nongnu.org,
 qemu-block@nongnu.org, Jesper Devantier <foss@defmacro.it>,
 Klaus Jensen <its@irrelevant.dk>, Klaus Jensen <k.jensen@samsung.com>
Subject: [PULL for-9.1 0/1] hw/nvme late fix
Date: Tue, 20 Aug 2024 06:45:06 +0200
Message-ID: <20240820044505.84005-3-its@irrelevant.dk>
X-Mailer: git-send-email 2.45.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1317; i=k.jensen@samsung.com;
 h=from:subject; bh=2D9T15+Iji6quYzx3R6hi4MU2SbpM9zAS0Mb0saOdYE=;
 b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGbEH1G34B2kUfJ0OYUcDyPzChm0wUy+yLcA2
 cC1jMIJxjEGqYkBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJmxB9RAAoJEE3hrzFt
 Tw3pVycH/Au56J9BYxIATtmq9bwxx6auo3vBFyslwB3iC8UqFbd4z2QqmcaPQMk2whKdf5/yDsw
 gVuQHRiKE98xD8gtggNYSCPmo36djsIhhlT99gjbxgU2ndbV36gttshlE9L954MSlKYaSqLSUjJ
 fuXPUKAeW+Iay7gjGqw1BHFPYqg4CdbbhOfXplGn+bVSqr9cZcbV7L1YW6W+lsBvpo20Alb7XsK
 LrbeQ+7viwa6n6sV9GDw1pWQsE7sQImOV49GsPS/VW937UDAZUasH4eQDPqvG0bWxQkEzU6qaAo
 TokYFUYCc78yteB94DckxWb/XVSnj3laztQjJ7ylAecOVMIfyIy/YaVc
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.153; envelope-from=its@irrelevant.dk;
 helo=fhigh2-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

The following changes since commit 48e4ba59a3756aad743982da16bf9b5120d91a0c:

  Merge tag 'pull-riscv-to-apply-20240819-1' of https://github.com/alistair23/qemu into staging (2024-08-19 14:55:23 +1000)

are available in the Git repository at:

  https://gitlab.com/birkelund/qemu.git tags/nvme-next-pull-request

for you to fetch changes up to 6a22121c4f25b181e99479f65958ecde65da1c92:

  hw/nvme: fix leak of uninitialized memory in io_mgmt_recv (2024-08-20 06:16:48 +0200)

----------------------------------------------------------------
hw/nvme late fix
-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmbEHsUACgkQTeGvMW1P
DenlQgf/dzz4B5pzdD0HsjNVNulxygAJEnYitiF/50LRj564hQDoisNYPvHeKMA7
wfk8jSSimTM6YkETksiR2DvnXlZ3wXn/HAhqE15GSW8vtRK2/RO9vNn51gyoFvl3
z/Wm8ahoFaNpygQQkQMIJ9QHVD3GheZH4OxMhqI1523+s7dGcUNetoZiyoBAdJ6m
7KOa/zUTPBmvpKMOEa25Ss+nZIPp9eFuCwQxhToV0gEuJFHolRZYv7GA4UjnodvJ
HrBrbsB8W4vh65FmC7WLAG9XFvNMgC0h8qtzWyKhNcxf478E7FckLvnAzSZExitj
fJzrSJV0bJHlQEM2q0yHYpL0urh5XA==
=ZeRF
-----END PGP SIGNATURE-----

----------------------------------------------------------------

Klaus Jensen (1):
  hw/nvme: fix leak of uninitialized memory in io_mgmt_recv

 hw/nvme/ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.45.2


