Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE8B6C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 16:41:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVw5n-0002Bg-Rf; Mon, 22 Jul 2024 12:40:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1sVw5m-00025r-87; Mon, 22 Jul 2024 12:40:54 -0400
Received: from fhigh8-smtp.messagingengine.com ([103.168.172.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1sVw5k-0005yp-8Y; Mon, 22 Jul 2024 12:40:53 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id F0BC8114018E;
 Mon, 22 Jul 2024 12:40:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Mon, 22 Jul 2024 12:40:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1721666448; x=
 1721752848; bh=gQ5fq+U7rvmGtIc7RTIkvxc11+PWUny77+A9bwdyj88=; b=M
 /pZ0ZE0jUaj0NJ7hK6LM/CxFbz0BdwA4UhE2BGctvhAbye431P17VkHN3LrdOdLT
 sxK2VuyNYrBRlekvRWt8XzG4n4x64aGzp3hF/mnP10G6MCPiLzWBmI5invZsdGRF
 aSHpu1aq45nQ7tY2Btt7jqdVFGeHt9ceG5JoCEi1EbINP0IDYbpe6plCqyDFo1j2
 l/FV3R37Jkx8wdfInsbxgKjOmcAtQuQnHfS9cdRrpYf3E3HxfraapfQcYrTYvN/f
 BlpuKYIDrACV+nawLvPAA9XtGZrrz3ULjyPSWakLqHjuefk0RHko8SqqJVmafpZN
 JlMYxmkwjRW56h3Y5IQ+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1721666448; x=
 1721752848; bh=gQ5fq+U7rvmGtIc7RTIkvxc11+PWUny77+A9bwdyj88=; b=i
 f0WuUTqqwMGmerJOvdzhWEfebvfqgqV1NdVEgdu2mjpWAL4+ozsJsKcOyQm/qTEO
 MXhRBI2ha8vIAvKiehB4wDNAmziqkCwGywkplZ3mdxdKs910AdFJA6nVu7o0xXDI
 8CuRw/xM38iEv8uzPbP5eUyxtlZ1KdcnRR6gwYnHhApJG2UQW74vqglPMQFS9FAm
 5n9whcJychT0RkX6BS6fM6M+JT9nJ+IHGNSpi//JcQ9Ywhu085NQF9Yg2c2GcX/P
 A9AEEnJLfDxI9s2uu7yof8Tl3GKcC0sIzQCDttOadO8EaMn9FIJU1KsrMh9Pz7fQ
 wS2+y6Z7sQvy4NisahNfQ==
X-ME-Sender: <xms:kIueZvYzcs8JmoS7Nt5tIfWItSQSWgFKF9Q7l_et4WPUTSe6h7MYOg>
 <xme:kIueZuY_DXFGfoLweRADH9nNRKof_dJ4oK6w2KFnqItxjbwEfB1wCiy5rnkf4Rm7y
 utDPSzvnTUxYFYw1mc>
X-ME-Received: <xmr:kIueZh8xdV0amcP3Ad3pqaT-IXCbSsElopmT371pwFBjW2fVQ6Qvfcoz4d8dUubiOzdODOmg9w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrheejgddutdehucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghu
 shculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrth
 htvghrnhepjefgieelgfeiveehkeeuveehheekfeevgeeigfehfefgjeejhefffeegudej
 udegnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepih
 htshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:kIueZlowf4QVp9b_ObfcMfOjhyfttXH2ln1QK9iH3IIGCfQqpiK9Ng>
 <xmx:kIueZqo21IrqykypAM2J4r1q4cN3PP8O2mDcxXCB-dQ7pjEVhTDQDA>
 <xmx:kIueZrSeFhd53qNXphSXHoUXhlk0-bU2CVc3gs9lrCfIzLpZD--35w>
 <xmx:kIueZircxP-i_ikI1JW4GrFaXmVWxYTeu7HBONzhXVNMITrhhLilKg>
 <xmx:kIueZv7NK2vyz7fA3qLMZeCcNa_zhQvFg-fUPdlycQQVmD9nM4EJl17a>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jul 2024 12:40:44 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>, Keith Busch <kbusch@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jesper Devantier <foss@defmacro.it>, Kevin Wolf <kwolf@redhat.com>,
 Yao Xingtao <yaoxt.fnst@fujitsu.com>, Klaus Jensen <k.jensen@samsung.com>
Subject: [PULL 4/4] hw/nvme: remove useless type cast
Date: Mon, 22 Jul 2024 18:40:31 +0200
Message-ID: <20240722164026.61128-10-its@irrelevant.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240722164026.61128-6-its@irrelevant.dk>
References: <20240722164026.61128-6-its@irrelevant.dk>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=884; i=k.jensen@samsung.com;
 h=from:subject; bh=I7wOSlNznRhp9BIFFrOZe+eMeEqUddKkVg4XkqRvW6w=;
 b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGaei3suGOTaapKPdoenfYVZFyOHPoRkVJR/v
 ID3Mp8U218sJYkBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJmnot7AAoJEE3hrzFt
 Tw3pyEQH/RWb1OLc9TZ7VE2pw9QGjthzm9A33oozH5Heay/1TLni2yUgoB3U7rZDIrQu9A5X3RO
 rMmxMVFlXGjj2MKc6fvw043JkHLZjbppH31KuLsujeYwcA3KSlPVBetxPts77sEBKM5vsnix77t
 MS+9d3lDMhE7fbh9gQ+1sX9bxAhI0dH5y9v8uRVMgmhsltpXRigfl6ZMKfoAJxmbPQIipEo7Oel
 HW3RQ4apctIN2I06vvUPUtizUvsm7hHzeyFFvLLsXxCfFOZDfLzzO9HvDlrwMh9cJWYWa6MMlnC
 zaOnQBU2xYhIhFQAiQonaFXzEwQSSHPGvLdiVxzUlBM8Xby4mVBX56rO
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.159; envelope-from=its@irrelevant.dk;
 helo=fhigh8-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Yao Xingtao <yaoxt.fnst@fujitsu.com>

The type of req->cmd is NvmeCmd, cast the pointer of this type to
NvmeCmd* is useless.

Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 39782ddb2e76..8d25174d257b 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -4340,7 +4340,7 @@ static bool nvme_zone_matches_filter(uint32_t zafs, NvmeZone *zl)
 
 static uint16_t nvme_zone_mgmt_recv(NvmeCtrl *n, NvmeRequest *req)
 {
-    NvmeCmd *cmd = (NvmeCmd *)&req->cmd;
+    NvmeCmd *cmd = &req->cmd;
     NvmeNamespace *ns = req->ns;
     /* cdw12 is zero-based number of dwords to return. Convert to bytes */
     uint32_t data_size = (le32_to_cpu(cmd->cdw12) + 1) << 2;
-- 
2.45.2


