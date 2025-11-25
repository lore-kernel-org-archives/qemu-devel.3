Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C032CFD364
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 08:49:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNoiC-00086B-4n; Tue, 25 Nov 2025 03:47:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1vNoiA-00085Y-26
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 03:47:46 -0500
Received: from fout-b5-smtp.messagingengine.com ([202.12.124.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1vNoi8-0008Bu-70
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 03:47:45 -0500
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.stl.internal (Postfix) with ESMTP id 41AF81D0022C;
 Tue, 25 Nov 2025 03:47:42 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Tue, 25 Nov 2025 03:47:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:message-id:mime-version
 :reply-to:subject:subject:to:to; s=fm2; t=1764060462; x=
 1764146862; bh=SSCHR0ZtlaTFeMPnVBjB9Ad9P+JwctEgEG+9Gh5IdS4=; b=B
 kwtkdU2gtRK0U3FLqxhyaRSI3fBCdkdt+hxkeUXRONnqSxqbOZphHqp/lGEYkSke
 +Od6YYNraGpbW35OwzJq9xiXpAk9uOStvQ3r+Mh6N/gocsuFPBRr7ycQVIGlz0CG
 8jMIcZVgS9arFlhohKS5bdPoQdvFEMyZKNvvc3nmLFU56RdXF3u2sac+6S1P1W8w
 iVjIFi+QD4Vwxp/c4MzdVqhY6r6WVQQLe9i6rd30Ds5kfLRhxypDMIaOH3eE9F4b
 YTvkFB+AVSmafCUbI7yxDrKHAZUtXTqXD6/za4Xfbo0mtnpgR2c2ftjQ+5CsuYJj
 EruVinG/Zp49bwGmwsiPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1764060462; x=1764146862; bh=SSCHR0ZtlaTFeMPnVBjB9Ad9P+Jw
 ctEgEG+9Gh5IdS4=; b=wxThxGzXS8gGLxx1W4UJO5jJkdpB8HxfgNfZhArya4Ha
 riufinXlewTwyQicSgXHI0ELL6TOJYpHpTiiEmmb17b8pVzQ88LAcGUiDQuaiP5Q
 ekbn/xMVaS2JedL52sSqaLRJJ6j2t/M18vdI1zuJ8W0G/CM3iaSZI3XH+Fhy1Muf
 4HbceYX16NdAxaq5aRzTSkbp4IfVSe1xZUQzQ77734L5j8WOp3N4WIh7muJuOW40
 k34d+tBQHW5oyw78RVZuEx5w4aQWBBAtkTTQnOwumAYYNRXwy+XhXJiyWpqPx1oI
 3WEkCJRbklTBcLxzVdWm7qcUfr6lEPe+Gu6ZSObPig==
X-ME-Sender: <xms:LW0laZpP0oly1K49y9OtNmU48gh_UlWM_u88GDS6DOKakf1UrcB87w>
 <xme:LW0laf8roC31O33aTjTYN5IriShb_y-pVKs7E1ykQFg-q-TGp4BKy1s24pXC0ghFI
 SOr9_oiJqo6OfxzwzSMbCid_o8f5j1eXzNyxoOs1dSW4X8mtnkFVeuk>
X-ME-Received: <xmr:LW0laVWIYuG_w4ucyqk1Fm6tDakuTmjJ92eryxYv6-Zeivr_WWHBoqoEIbupkKN_nEO3x0b1ZIdLh9JEm8wQRP0->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgedutdefucetufdoteggodetrf
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
X-ME-Proxy: <xmx:LW0ladBhnpO96Sl_yb-SR8XnimyCys9FjUf7JGev8L4tOFFnSQEV-Q>
 <xmx:LW0laeyNjuar_kGIDxOTYumq1RSVpViBZlUaA0ZcrPj-KNlgz8Eyfw>
 <xmx:LW0laSD5jqT3hMjVBIDsExpVkZJjSAX2WkLwWxFJ_pgc3MH7ytH0hg>
 <xmx:LW0laTZOlFiVZniO8sAxYWLgINBVVjZRCyvmRh7eD_v9r9z27rEG8g>
 <xmx:Lm0laZM5GrtWqMtIYZ7ExqbS_AMbq57wxRfidJCTGj5RUQfPzi-Cy6lf>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Nov 2025 03:47:40 -0500 (EST)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: [PULL 0/3] nvme fixes
Date: Tue, 25 Nov 2025 09:47:22 +0100
Message-ID: <20251125084725.4632-1-its@irrelevant.dk>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.148; envelope-from=its@irrelevant.dk;
 helo=fout-b5-smtp.messagingengine.com
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

The following changes since commit de074358e99b8eb5076d3efa267e44c292c90e3e:

  Merge tag 'pull-target-arm-20251124' of https://gitlab.com/pm215/qemu into staging (2025-11-24 09:03:12 -0800)

are available in the Git repository at:

  https://gitlab.com/birkelund/qemu.git tags/pull-nvme-20251125

for you to fetch changes up to bd3ba0d342318a61ce22721322c56205d5f3853c:

  hw/nvme: Validate PMR memory size (2025-11-25 09:21:41 +0100)

----------------------------------------------------------------
nvme queue

----------------------------------------------------------------
Keith Busch (1):
      hw/nvme: fix up extended protection information format

Klaus Jensen (1):
      hw/nvme: fix namespace atomic parameter setup

Philippe Mathieu-Daudé (1):
      hw/nvme: Validate PMR memory size

 hw/nvme/ctrl.c          | 128 +++++++++++++++---------------
 hw/nvme/ns.c            | 206 +++++++++++++++++++++++++++++-------------------
 hw/nvme/nvme.h          |  25 +++---
 include/block/nvme.h    |   2 +-
 tests/qtest/nvme-test.c |   2 +-
 5 files changed, 209 insertions(+), 154 deletions(-)

