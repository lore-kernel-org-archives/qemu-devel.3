Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80BA1C3DA4B
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 18:06:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRyA6-000709-34; Thu, 11 Jul 2024 14:04:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1sRyA0-0006ll-SJ; Thu, 11 Jul 2024 14:04:52 -0400
Received: from fhigh5-smtp.messagingengine.com ([103.168.172.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1sRy9y-0003tU-9m; Thu, 11 Jul 2024 14:04:52 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 238CE11400AD;
 Thu, 11 Jul 2024 14:04:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Thu, 11 Jul 2024 14:04:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1720721089; x=
 1720807489; bh=WO+HZ2heOGTaV73IU7dquxv1Kny0hFhzSzZKp3QVADU=; b=B
 MXk5HldYxHtXn41xTTI4P82U39a+TeKLGtpZiT0AhmaiCizrTN5E7KYBMPtZAcJA
 /wz9GbYpzQXOx7AIstQqegz+dE9/O6KfhQ0pRx0HUZDsMJ0u/ZJgy2XVDXWwaK07
 KuzFU+kt2deQ5w5aW5fQv1711V7mhY6gQWmw8NkzpSkm/KZ8RJTWv6glDMPHVgUx
 lV55VO3aAAsoGRJq91MwbxH+y5Bf/nEyiWtCicpRM/Yc7R2KefE73ltx30rPCg1M
 gTjF+gedIioPRPv1PrVxwvstNvm5cVU1Grz36d+1O3InVHniWBpSPljIT/Vn7kKJ
 ymAQQ7w11hWSRRp77Mj7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1720721089; x=
 1720807489; bh=WO+HZ2heOGTaV73IU7dquxv1Kny0hFhzSzZKp3QVADU=; b=B
 VKBCi+6TuPp2arMGOTby29qvYG4TQr5OaThIK1Dp0ACbbVYrDEUxMgxMyvHRQG5H
 n/rCOWHPjnv9seSU0YpHTGr6VXfLFZ4FkCLhsxuK2a/KE4/Cd4aQPPy8EBcT5nZM
 YervkDZXNg1ZJoIM19nupQnUDGfNyIGgzFlIG4QMldPbycID8YmrCwVdpHr1JVcP
 e+ktFsGbJAKY8a+cfpVtKhzMl05T+lFKNJxsuWvStHSrsZlTCdbQHjDM8d/4i2Pu
 0h6zoG7lyG0rlegka+WcuqjXoaES9fTEuDRZFss0UcPB0BAvtYGOHM64BgC2bFAg
 fWN/ALHWLtkop4RA/smuA==
X-ME-Sender: <xms:vx6QZuaNSdAxbycP5jqiSXfdwNSPnLZURArbuOFHcq2eQxx5Kricow>
 <xme:vx6QZhYrzFCiYa86m-QrpsspNHWftVUKWcaDITboCIm4O6oFfaCw9GVWjjEfOEYl_
 kyPcZT_gqS0ksy6BcU>
X-ME-Received: <xmr:vx6QZo90TJmP54W9sWSdENh0lbAOJidPvt2vhsyAxrpHeJ2relFubnZ7yzaFwLBzg74a4lgMGw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrfeeggdduvdduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghu
 shculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrth
 htvghrnhepjefgieelgfeiveehkeeuveehheekfeevgeeigfehfefgjeejhefffeegudej
 udegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
 htshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:wB6QZgqH_bCLGWmU3_l56DVmrjQq2z7ZRMf_steCRxV5nyli7mLIHw>
 <xmx:wB6QZpo_wYgd4IvO1LblQqdzTGUsdkVgjfDni9GlZtLtU-gVh_Plrg>
 <xmx:wB6QZuQMS4geBpivPMk4uY3SBalmhPJKsPXV-AqEv1KM18_46NdQPw>
 <xmx:wB6QZprmVoKpNbWnQfgcKNKG0aGsUISBK-d03PG452I-1X-qjE4jUA>
 <xmx:wR6QZhb7N5I-2GK9DFXETDRnbKdjxI1_J0c5jdr7gdoO4c3YYut-3OMB>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jul 2024 14:04:45 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, Stefan Hajnoczi <stefanha@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>,
 Vincent Fu <vincentfu@gmail.com>, qemu-stable@nongnu.org,
 Vincent Fu <vincent.fu@samsung.com>, Klaus Jensen <k.jensen@samsung.com>
Subject: [PULL 2/7] hw/nvme: fix number of PIDs for FDP RUH update
Date: Thu, 11 Jul 2024 20:04:39 +0200
Message-ID: <20240711180436.8532-11-its@irrelevant.dk>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240711180436.8532-9-its@irrelevant.dk>
References: <20240711180436.8532-9-its@irrelevant.dk>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=985; i=k.jensen@samsung.com;
 h=from:subject; bh=NRnqEByl/824gnk6FtAb/MAqKkQ6e5hG9fzMuAHEpeg=;
 b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGaQHrRfMflBr6HDt+iTBaCrzZJ0Rz141UYsN
 HZhx4guplCI6YkBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJmkB60AAoJEE3hrzFt
 Tw3p/owIAJ5TjvHdhiS1eZlRodUkOd9Rh8l0KiTBUKxVAModT5n4RUvYMo33nBqqFmh4XnmosAO
 RWQrRPwCtW7LYrlKHwp+21wxJDpqA5PANonUXSxTWH9ffkhnDTJTB9e87tX9GBqudfjdUHiG+/M
 dEBTm90aS2UyoXt0jo1MhYLQ3QRsIM7y5lE+gktV+bmmSvKefl2dYIj8olROPEagkYevdiCAgvL
 qsxVlO9c4piNzRt1ncYx5hSwWFo9MW+rSXYGa0+evzRoZKEjLiyP3BgpDY0YBohXFrbSJcz+Zzo
 P/7ARs1mte6Xz1pinS4uyhjZB3VMA4O+6fmWLS3f4T4FAUZqASdQSaYd
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.156; envelope-from=its@irrelevant.dk;
 helo=fhigh5-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Vincent Fu <vincentfu@gmail.com>

The number of PIDs is in the upper 16 bits of cdw10. So we need to
right-shift by 16 bits instead of only a single bit.

Fixes: 73064edfb864 ("hw/nvme: flexible data placement emulation")
Cc: qemu-stable@nongnu.org
Signed-off-by: Vincent Fu <vincent.fu@samsung.com>
Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index fa7ec0e79490..231e1127cec8 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -4352,7 +4352,7 @@ static uint16_t nvme_io_mgmt_send_ruh_update(NvmeCtrl *n, NvmeRequest *req)
     NvmeNamespace *ns = req->ns;
     uint32_t cdw10 = le32_to_cpu(cmd->cdw10);
     uint16_t ret = NVME_SUCCESS;
-    uint32_t npid = (cdw10 >> 1) + 1;
+    uint32_t npid = (cdw10 >> 16) + 1;
     unsigned int i = 0;
     g_autofree uint16_t *pids = NULL;
     uint32_t maxnpid;
-- 
2.44.0


