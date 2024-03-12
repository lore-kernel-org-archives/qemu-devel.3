Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60A59C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 17:28:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk5tt-00028A-6E; Tue, 12 Mar 2024 13:26:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1rk5tm-000256-7R; Tue, 12 Mar 2024 13:26:46 -0400
Received: from wfhigh5-smtp.messagingengine.com ([64.147.123.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1rk5tk-0005Ob-MJ; Tue, 12 Mar 2024 13:26:45 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailfhigh.west.internal (Postfix) with ESMTP id ED2D818000A1;
 Tue, 12 Mar 2024 13:26:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Tue, 12 Mar 2024 13:26:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1710264401; x=
 1710350801; bh=/PYIyLQQniuFKFxiWnarB/Z18O8/5Ip6/+Dmm2IYPGs=; b=p
 fpjysZKPgsao9icOdLEw3BTbrbSIzCMj3ZaH/FjAYofnudvP1mglKdOp77MwLFKp
 LzRHn6vzPi+TDKk/c8HMk0OBDeABOz7S+iB6tsypEfeiOHpnLRMWUEDeBKZjPP3G
 j6xBEqK9W0PdAgpg1jTl3xxzL6ijp//i1UrvBlBZtrVmwKlovLOf+uprsGXE8LrH
 ImoQD19oFwAbNPNtU1gg/bQeRw6DnbRRM/+l0Rl4WZ7K9LLwS8P8cLSpm7WMzZ3g
 h7IiGreg9ErjcNga2MeMLsKTNNiVnMvIm3s8AmzKvONPNu98pucZoVMv1XDb/h1y
 q+n2yDKxNJYMuyo+zxcFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1710264401; x=
 1710350801; bh=/PYIyLQQniuFKFxiWnarB/Z18O8/5Ip6/+Dmm2IYPGs=; b=k
 SqCt5f7Db4qWucKE38mVO7gjGIS9ifumvCMsFgLtcpN9cl8xoB4FvwRvUy3PtJFu
 LsfKtevN1WnmIeXIu/kNKYqJFmcqskzyjcYa25zZ+OGI7Zwx+Be9ILPazamIkq1V
 6ACWgQ6yd6LKObAvwTvA8AZ5cSBQkycf8rEuo8vSJvJm5DA0wG+UVW/DVR/zFRFM
 rcPGWSr328RQM9wr3M+HmnHrpMSCmdHTJ3QzGz+nQF2w/IYQKeK5vBMM99/zsbHS
 ozj2WqbP0hR0fhrTHm/K8+/4aj4v0q+3jRaiw7vGyj26Crrbz9z3aT6GXSaZNLVD
 mTaB+Cb8GixFC1ydTkkpg==
X-ME-Sender: <xms:UZDwZRZWi_MTQbt-x8KkIyYv9v47sAf3RhmEdPxH4Ufx2cvlFgowlQ>
 <xme:UZDwZYaH6ZnTYVtxNGFPaT-8wvyVwRi8KH7tHGQnBFssi9q3nWJsz4Mdc4Er8bQCt
 ZQWWyRWLzgT_qjVPAk>
X-ME-Received: <xmr:UZDwZT9wGXOvx9kTFEBIeGyYPgwYGWD2W1AGm4eQzqKD0WXFRfIytQn5_cap2Cc9wbnHD_utaA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeefgddutddtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghu
 shculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrth
 htvghrnhepjefgieelgfeiveehkeeuveehheekfeevgeeigfehfefgjeejhefffeegudej
 udegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
 htshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:UZDwZfrQpD2KW-0SyCitBK8tH3Z8OLgYkhZDJZ08-x5mMiYuFiTFlQ>
 <xmx:UZDwZcpaqQHMFOsuz4BzT8G1bk2uw1RFgtGxPuqnIhNlnjLYL27RlQ>
 <xmx:UZDwZVTAyzsPJrlyUqzFkibS3--iPsmjtOZT6Z6uZbuVeDNeeJvXGg>
 <xmx:UZDwZUrtmRzhg9ugGrJ9nVaIuqmqvDJn5FUtc_EoJyXBqXUEy8ChBQ>
 <xmx:UZDwZSjUI2MHdtUxHrDRWid1lGpoCeX6anxXLMFfz21jTgt5Hnx90iEJEhw>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Mar 2024 13:26:39 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, qemu-block@nongnu.org,
 Yanan Wang <wangyanan55@huawei.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jesper Devantier <foss@defmacro.it>, Klaus Jensen <k.jensen@samsung.com>
Subject: [PULL v2 3/6] MAINTAINERS: add Jesper as reviewer on hw/nvme
Date: Tue, 12 Mar 2024 18:26:26 +0100
Message-ID: <20240312172622.58652-11-its@irrelevant.dk>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240312172622.58652-8-its@irrelevant.dk>
References: <20240312172622.58652-8-its@irrelevant.dk>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=709; i=k.jensen@samsung.com;
 h=from:subject; bh=BWg6jMLKfC3h7/J+jZb66LMNRqpEhFJl5OKFCAevhf4=;
 b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGXwkD8rMg67lMLGRmNwOp3cP9oS8HjHTmfB2
 1A74ypi8pLjXIkBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJl8JA/AAoJEE3hrzFt
 Tw3pyq4IAKhF4mQTXHuZ1oO1dihIEY+ubP+58tje6Jfa8ktrWCzRT1nVAUHo9xOKEoxMe/uj+g3
 59KJcVzDIFow8eMZAhB0oqxmX2jSij1ZuIL2zJwCzWkIRJ1osxbdpdCoSFKk5lyp2Swm92gq8gP
 iUMEpm0cWk9GEY4CsvWrsJFeD161RqI4XJkUlSXUNyDyXKc34UYRnrtjI/sAP15W69gUBeh4yvi
 CbXMYcBhNNZy8J8HtbpOEozjIw6zL88hUI8iREcpuqdKs7EZU0SXTHDyx0wH0kD2d9JsoQBeWYq
 ziT12nc/GJRJDfgOgJj04ggY+JBvE7PL4lectzW73kTs4ogMJ4NCWaTP
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=64.147.123.156; envelope-from=its@irrelevant.dk;
 helo=wfhigh5-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

My colleague, Jesper, will be assiting with hw/nvme related reviews. Add
him with R: so he gets automatically bugged going forward.

Cc: Jesper Devantier <foss@defmacro.it>
Acked-by: Jesper Devantier <foss@defmacro.it>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 12f5e47a11f4..7f96ce857486 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2407,6 +2407,7 @@ F: docs/system/devices/virtio-snd.rst
 nvme
 M: Keith Busch <kbusch@kernel.org>
 M: Klaus Jensen <its@irrelevant.dk>
+R: Jesper Devantier <foss@defmacro.it>
 L: qemu-block@nongnu.org
 S: Supported
 F: hw/nvme/*
-- 
2.44.0


