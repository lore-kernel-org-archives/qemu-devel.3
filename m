Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9040C3DA4B
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 18:05:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRyAF-0007Mt-6n; Thu, 11 Jul 2024 14:05:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1sRyA6-00075l-GC; Thu, 11 Jul 2024 14:05:00 -0400
Received: from fhigh5-smtp.messagingengine.com ([103.168.172.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1sRyA4-0003x1-P8; Thu, 11 Jul 2024 14:04:58 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 8091D1140395;
 Thu, 11 Jul 2024 14:04:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute3.internal (MEProxy); Thu, 11 Jul 2024 14:04:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1720721095; x=
 1720807495; bh=fU0R5yFm01ORA9K//V//NlC8z2SUntdN8U1tV783OlM=; b=I
 3hcItcKwDfVkO8U2XZYnzKK2s/kesvma/BsXzX5IJ2ulfukxaeffvvaneKY8t9KC
 KIUW6aO0zGklWvmgQT2HtNMMxJLycVct7oiVplFH6sVghRFkeH4s0yoIkFhbw6Lc
 b1F22tfzHLvng61koP8Z7Wru1PBLV6zmNPNxkbh7RteopbCAvWWbb7iO7Ff3Ut1d
 hFLSn1qy3NE8nanlZ7BZO0tVDJwFxI95KpehYNA1+2DxTy1whQmaS3hAvoYJ+rK9
 ZnEbdeAnaE9K+LXFKylfzHC5/7VWjMmE3E0FUcv3LDI0hJXSo/OuNZ1gOXpOjV/y
 toC1yAFCrbYkoGwOR74YA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1720721095; x=
 1720807495; bh=fU0R5yFm01ORA9K//V//NlC8z2SUntdN8U1tV783OlM=; b=t
 ddzMYDh9i/oR0o74aSJDdeld9cg4Yztw0VHESVvoGpuU/4bq5lS5blpk2WP+WsPz
 p7eACwl1jLj2+4JLJtPnTieKZvgSzVOfExIktg950j64t2R6J8XE/hs2YVijLikh
 vHpOwwYto2MVBgL/il6CCJnpz9lD1TzB+QTIJS445mk2pof+IWNvuM7mKUDBeLjI
 nNSh3rKofjJkxjjaY4nVxYzB8yoPesDLhi2SKdWaCBc39uJDTkaoiaUz8Lk0rOvW
 f+5btSzthMvIHjlKADyrv3Sv7lXwACjcQq5NhP3VdFSYSaRYhl9sJVp6oVsH6Bzr
 r7VPtlU7WzYfDjak6xUJQ==
X-ME-Sender: <xms:xh6QZsZEDp1_ndn_BWryP5EjJqnQUl-qngsHjtAtxoC-InRSN2aKpA>
 <xme:xh6QZnZIWxO7n1XLdrgvGmUDoPGLMPWRabgA-werByC5PMQw_1oFQdMbjsqwrwg9G
 VNxXWqYGeVX-JGupSE>
X-ME-Received: <xmr:xh6QZm82IFkKUZ9_BJzxCNeyZIwDkkx3lOjXE83EbLuuLiIXnQpoiiyP5oiMUP_klXNm_gewZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrfeeggdduvdduucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghu
 shculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrth
 htvghrnhepjefgieelgfeiveehkeeuveehheekfeevgeeigfehfefgjeejhefffeegudej
 udegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
 htshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:xh6QZmpT1pjfSNklOh_rh9kwT87at2BF2BQPm9dg2JZ_38p7wy2qLA>
 <xmx:xh6QZnqELrBXS47F0RRL_Ne5lMA_nAryG1-YqpD6ozA9JmC8QHx8mA>
 <xmx:xh6QZkSgMjygYYmdu2BDJS9wWbqxdJCjSzqEzhG4Y1Nqm4j_6fMSVQ>
 <xmx:xh6QZnrm2EZrx7cNr40Kph1wK_1K5dwiCy6hFrOmH5EzS8ALJw16lg>
 <xmx:xx6QZg42kSTcaq_n-kIZgab9vk2ETTeIqvdRxIw2RcJhGx3dPdIETMrO>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jul 2024 14:04:52 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, Stefan Hajnoczi <stefanha@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>,
 Minwoo Im <minwoo.im@samsung.com>, Klaus Jensen <k.jensen@samsung.com>
Subject: [PULL 4/7] hw/nvme: add Identify Endurance Group List
Date: Thu, 11 Jul 2024 20:04:41 +0200
Message-ID: <20240711180436.8532-13-its@irrelevant.dk>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240711180436.8532-9-its@irrelevant.dk>
References: <20240711180436.8532-9-its@irrelevant.dk>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2675; i=k.jensen@samsung.com;
 h=from:subject; bh=bLLqYH+xpFPc6bj1dQ4f6vAV7JLMQj/+ItiUpoYuPOA=;
 b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGaQHrU8bZRr6zIgFxItj9xrzxUI9CElqs2CU
 CUAnZF7nVMpwYkBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJmkB61AAoJEE3hrzFt
 Tw3pXEwH/0wPzyvsHQ1QZHI7kShq8cgvnoXGtheuhaxQk370jOv5Ulvna4iaJpYk9W8MovYp3S+
 lF/XGz1goxNsqkO2s0nwdtzk0kBvP8G1+8ZT24Bc8fo4ELx+DEFRWfVhh0OTtNEiFFu+UJRdYVF
 Us0xwhZCN8kWbMLoDDBiWXi2Lqm+sE8FSWapz7nEsD6w/BK/4Nca6z0iLEN1cIUKjkXcqt4jQ9W
 uiIODdwdoB8EQ+vkWK24aiZPYjLcDoLeOiDRwMFBmycW9RsEizvew1FKL0OefPMqMZ08BE83G5M
 QblLBznpIeCjkjfG6KT3Q4jcnyr0qjqZebzZo7BDW3QOIkeafjUMdaLR
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

From: Minwoo Im <minwoo.im@samsung.com>

Commit 73064edfb864 ("hw/nvme: flexible data placement emulation")
intorudced NVMe FDP feature to nvme-subsys and nvme-ctrl with a
single endurance group #1 supported.  This means that controller should
return proper identify data to host with Identify Endurance Group List
(CNS 19h).  But, yes, only just for the endurance group #1.  This patch
allows host applications to ask for which endurance group is available
and utilize FDP through that endurance group.

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Signed-off-by: Minwoo Im <minwoo.im@samsung.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c       | 22 ++++++++++++++++++++++
 include/block/nvme.h |  1 +
 2 files changed, 23 insertions(+)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index f3ae54896f6d..50f8cc90b038 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -5629,6 +5629,26 @@ static uint16_t nvme_identify_nslist_csi(NvmeCtrl *n, NvmeRequest *req,
     return nvme_c2h(n, list, data_len, req);
 }
 
+static uint16_t nvme_endurance_group_list(NvmeCtrl *n, NvmeRequest *req)
+{
+    uint16_t list[NVME_CONTROLLER_LIST_SIZE] = {};
+    uint16_t *nr_ids = &list[0];
+    uint16_t *ids = &list[1];
+    uint16_t endgid = le32_to_cpu(req->cmd.cdw11) & 0xffff;
+
+    /*
+     * The current nvme-subsys only supports Endurance Group #1.
+     */
+    if (!endgid) {
+        *nr_ids = 1;
+        ids[0] = 1;
+    } else {
+        *nr_ids = 0;
+    }
+
+    return nvme_c2h(n, list, sizeof(list), req);
+}
+
 static uint16_t nvme_identify_ns_descr_list(NvmeCtrl *n, NvmeRequest *req)
 {
     NvmeNamespace *ns;
@@ -5744,6 +5764,8 @@ static uint16_t nvme_identify(NvmeCtrl *n, NvmeRequest *req)
         return nvme_identify_nslist(n, req, false);
     case NVME_ID_CNS_CS_NS_ACTIVE_LIST:
         return nvme_identify_nslist_csi(n, req, true);
+    case NVME_ID_CNS_ENDURANCE_GROUP_LIST:
+        return nvme_endurance_group_list(n, req);
     case NVME_ID_CNS_CS_NS_PRESENT_LIST:
         return nvme_identify_nslist_csi(n, req, false);
     case NVME_ID_CNS_NS_DESCR_LIST:
diff --git a/include/block/nvme.h b/include/block/nvme.h
index bb231d0b9ad0..7c77d38174a7 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -1074,6 +1074,7 @@ enum NvmeIdCns {
     NVME_ID_CNS_CTRL_LIST             = 0x13,
     NVME_ID_CNS_PRIMARY_CTRL_CAP      = 0x14,
     NVME_ID_CNS_SECONDARY_CTRL_LIST   = 0x15,
+    NVME_ID_CNS_ENDURANCE_GROUP_LIST  = 0x19,
     NVME_ID_CNS_CS_NS_PRESENT_LIST    = 0x1a,
     NVME_ID_CNS_CS_NS_PRESENT         = 0x1b,
     NVME_ID_CNS_IO_COMMAND_SET        = 0x1c,
-- 
2.44.0


