Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B989CD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 12:09:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOwly-0003NK-Lc; Mon, 18 May 2026 08:08:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1wOwlk-0003Hn-7I
 for qemu-devel@nongnu.org; Mon, 18 May 2026 08:08:24 -0400
Received: from fhigh-b6-smtp.messagingengine.com ([202.12.124.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1wOwlh-0006uC-UQ
 for qemu-devel@nongnu.org; Mon, 18 May 2026 08:08:23 -0400
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 74BC57A0019;
 Mon, 18 May 2026 08:08:18 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Mon, 18 May 2026 08:08:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:message-id:mime-version
 :reply-to:subject:subject:to:to; s=fm2; t=1779106098; x=
 1779192498; bh=Rvs+enNlr/7LBMtALTT+KhFEm+4LqKrYI0P3+rPn0Pc=; b=h
 ONWzH9SV5Hx5zuBCpXeh6lNLg+JCRJMmE86cJOEwaeufBWIow7Cw3zK7MF8All2y
 qkwcP+mchg0V9lXg8Cbcu+GuOprZ2HXnKmA6eGP9vCy9i/8XfsIe84Qy+ErXQxbz
 warMHdAjxWt0VIdSDbmFnyoHBUPLoMFMXUlYnTDQleP3j52bFFmXhr/PfUxxSxMC
 oYFq/ErYYnwvuCmi3BmTl86FWca8GEq2RFy/uZpm0u/1m+Lae3Ez06JXbaRHQpn1
 Z/OGl4pqIgX/bvpX1q1H3Ah+Pl3u/5c/isWK1x0D1iM7nGVUMdpD/27QV9xsD65X
 e1+mVtx5Kn4O7nytBrILg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1779106098; x=1779192498; bh=Rvs+enNlr/7LBMtALTT+KhFEm+4L
 qKrYI0P3+rPn0Pc=; b=R8nIlENS7JlFj2EkslL29KMiMmhwR98cPL3nZAMcLMqC
 FR2XDYlhiFO7gzi77XeDFuOsZ4OGwefpDf4IOqvTqDBSdfmQuSIkSHSpSTEUvCCJ
 aOEtxiM+cwXnF8pPADsNvoRol3hujn+oWEmdilhjH/bcaE7y+MVAVAo8FufrXFSe
 7Dv3HPIwr0mlVhesNPAm0Vh7KSVej711iy/zosUIPT7CS5cUE9YhNr0wOXUGxVHs
 B+4zjsMbNSI6izxrcJc+3oiGe33zlY6cPr6aknYZh7ypRXUgP27+KFzIOE3gPpYD
 J3q8WH/aNlZldV5BJt2JJDjTjaNTNMmCMrzMA8jQlA==
X-ME-Sender: <xms:MQELakgG3Y1vM2MDEQ5LT9_--zgYigvkUpRBRLpRDDYHQ6K6G_gc2g>
 <xme:MQELahVIuNLQYQCJSlF8t-sKTpF2JqsOIxn0UQwu2qw_iv9_bTiDMxIEZCGs7o50C
 4eHfexhf1iirIGA567tn6_LsZGzSRR98tK1rgP9O7FNSO6dse8N>
X-ME-Received: <xmr:MQELarNBKs6RNr1LDLBnR9Lish2u59LXmR1R_vmbZHRgQBWxzVhQNtTeJWOtBU4QTOdUlSHV9kCZbcKxIMk9Ayyt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufeekkeefucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpefmlhgruhhsucfl
 vghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtthgvrh
 hnpeekvddtvdetiedvjeehjeeujedvkeefvedvkeeftefffffhfeeihfeijeelueefgeen
 ucffohhmrghinhepghhithhlrggsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomhepihhtshesihhrrhgvlhgvvhgrnhhtrdgukhdpnhgs
 pghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepqhgvmhhuqd
 guvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopehpvghtvghrrdhmrgihuggv
 lhhlsehlihhnrghrohdrohhrghdprhgtphhtthhopehkrdhjvghnshgvnhesshgrmhhsuh
 hnghdrtghomh
X-ME-Proxy: <xmx:MQELatbC2jvxSw5E73DtIYEpqOIIYf-wGwBQPSAKDhmqQZrP9bmZCw>
 <xmx:MQELanpB92zu7VZiSuaV7OPLu2JbaSusDScm8a6-hki3X2DjMkUOOA>
 <xmx:MQELapYAXZt8YyX2ANyAIYAkMTSDH1gD2Sgayyv1n8RUOZzebPlxWw>
 <xmx:MQELanR_yb3tqwM_c94alZBr6_W0ZKFtsbrSf7ok1skGO2QjCYWI2Q>
 <xmx:MgELano-bAqKZ9ILDp_vo4GmspcDHJd59BEiJ1lSKviu8A-gnJMgI5qE>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 May 2026 08:08:16 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: [PULL 0/5] hw/nvme queue
Date: Mon, 18 May 2026 14:07:43 +0200
Message-ID: <20260518120748.14831-1-its@irrelevant.dk>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.157; envelope-from=its@irrelevant.dk;
 helo=fhigh-b6-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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

The following changes since commit ac6721b88df944ade0048822b2b74210f543d656:

  Merge tag 'vhost-user-rtc-pr-1' of https://gitlab.com/epilys/qemu into staging (2026-05-16 17:37:33 -0400)

are available in the Git repository at:

  https://gitlab.com/birkelund/qemu.git tags/pull-nvme-20260518

for you to fetch changes up to 2293d8b4bd88d3f29730cfd608935f77247919b6:

  hw/nvme: fix admin cq msix setup (2026-05-18 13:47:25 +0200)

----------------------------------------------------------------
nvme queue

----------------------------------------------------------------
Daniel P. Berrangé (4):
      include/block: define constants for NVME string fields
      hw/nvme: report error for oversized 'serial' parameter
      hw/nvme: add user controlled 'model' property
      hw/nvme: add user controlled 'firmware-version' property

Klaus Jensen (1):
      hw/nvme: fix admin cq msix setup

 docs/system/devices/nvme.rst | 10 ++++++++++
 hw/nvme/ctrl.c               | 35 ++++++++++++++++++++++++++++++-----
 hw/nvme/nvme.h               |  2 ++
 include/block/nvme.h         | 10 +++++++---
 4 files changed, 49 insertions(+), 8 deletions(-)

