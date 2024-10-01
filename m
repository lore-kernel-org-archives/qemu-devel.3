Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60914CEACCB
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 14:15:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svdbj-0007XW-Dg; Tue, 01 Oct 2024 10:12:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1svdbf-0007TS-IC; Tue, 01 Oct 2024 10:12:03 -0400
Received: from fhigh-a2-smtp.messagingengine.com ([103.168.172.153])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1svdbc-00033t-OG; Tue, 01 Oct 2024 10:12:03 -0400
Received: from phl-compute-10.internal (phl-compute-10.phl.internal
 [10.202.2.50])
 by mailfhigh.phl.internal (Postfix) with ESMTP id D91EF1141A91;
 Tue,  1 Oct 2024 03:04:37 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-10.internal (MEProxy); Tue, 01 Oct 2024 03:04:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1727766277; x=
 1727852677; bh=fg5ajWBIkDI9g+3hZuI8UIo2TtY7qRypApN90qn3Dxc=; b=B
 6CJyEGNCtqzQt73GjA1rDV83tge9oedh+LZJRIK7stEcR3hJDEpoubD2JVYxs/Zd
 eLGajRT7kCg9C2OrE5a4dqFq9lsADpmt8yDRZdAlTDkR80h0pZ3eFX0ua4W/wBNG
 nnMNkyfabzv8e8Ps40v7TIa559mm+Wukcan5cmumpci2r+XflS9sE4tsq2dZn/tk
 zBUYikTypLYVVHv3OGBH4NnZkaeIWIVdfDR2wPNe7SNT0NfwC4kXwduDgeXu8Asa
 947HqeP+3mOMyMyxC8ZgRN0EFvPKbRYvMImzuBXvttganlwa9apgBSSb4G0wvYuk
 Jvg1Nbkue7qryd5gEuIqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727766277; x=
 1727852677; bh=fg5ajWBIkDI9g+3hZuI8UIo2TtY7qRypApN90qn3Dxc=; b=h
 zFLPD2MLds6aaA4rGjK/iNL5s2bLKVDiXomhEb6Gt31P78dPLwBEVuiPuspBwIdt
 IZNxTPdC1MZes/zraCT62n0+lpFmQQAk4V0YU0EobaItZshHSqaEceECbEjT3QxL
 tuI77Xxh2gs65wElPULxtBOfmrc/K/0BoPydg3M9y36EkJQih99V1aDwluaO8Bdf
 AI1icRX/kn6P40p94bdcNPXDnOLcJvly50UHzSb1Otr29V3XEmKRzVcNBgLyT+eQ
 aDPV6/0FjcZgcO2tswAHCn0PuRCazsx9RLADI7H4VxB3qWlpFV4TdlP1o/5MBG4Q
 NR3OIc7xvPj3xc/Pa1Qsw==
X-ME-Sender: <xms:BJ_7ZmBCWp9j5Ij52e_LDr_tfa9MTQy9kw-mPohQNCD8EqkyE9cSFw>
 <xme:BJ_7ZgifhqliWEDKb1YY_R5mqafGVBXIbA5mIiQEV7UoV9WghMVDqHlnjanG8cQ-w
 7E8RyC-xcoyWRZ5nTE>
X-ME-Received: <xmr:BJ_7Zpk-86N1cosaAOCDzweyCF-oeqx1qYrPOeME-Eqix_x26DKAp3WBWV9roeSDgfukDQlTIo0WefJ6cVuxFg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduiedgudduiecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
 necuhfhrohhmpefmlhgruhhsucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnth
 drughkqeenucggtffrrghtthgvrhhnpeejgfeilefgieevheekueevheehkeefveegiefg
 heefgfejjeehffefgedujedugeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
 epmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughkpdhnsggprhgtphht
 thhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehqvghmuhdquggvvhgvlh
 esnhhonhhgnhhurdhorhhgpdhrtghpthhtohepphgvthgvrhdrmhgrhiguvghllheslhhi
 nhgrrhhordhorhhgpdhrtghpthhtohepkhgsuhhstghhsehkvghrnhgvlhdrohhrghdprh
 gtphhtthhopehkrdhjvghnshgvnhesshgrmhhsuhhnghdrtghomhdprhgtphhtthhopehi
 thhssehirhhrvghlvghvrghnthdrughkpdhrtghpthhtohepfhhoshhsseguvghfmhgrtg
 hrohdrihhtpdhrtghpthhtohepqhgvmhhuqdgslhhotghksehnohhnghhnuhdrohhrgh
X-ME-Proxy: <xmx:BJ_7ZkyJvgAK8J4BCV0DYZBThcopq29tjN5j7wHe_I7E5YqcMjOfug>
 <xmx:BJ_7ZrSBzjYNNkyRd0er-oCjFYUd5nsRrHJVoDEgNl_uKGWOTQX3og>
 <xmx:BJ_7ZvaNSwlGW6adop8C9B5czCzCwbTrwN_J8uppqXJu7Ai2A6e50g>
 <xmx:BJ_7ZkQHHHxNSmIjQqmpac1VNSwcqU-c3RK8E_MoyVIK-zt7y0sSVQ>
 <xmx:BZ_7ZkT7dRqlAuV_fIew5wCRzyoaDwcFhQ7eK64pccsyj_NaD8Ai8HUz>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Oct 2024 03:04:35 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <k.jensen@samsung.com>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org
Subject: [PULL 1/5] hw/nvme: report id controller metadata sgl support
Date: Tue,  1 Oct 2024 09:04:13 +0200
Message-ID: <20241001070418.28737-2-its@irrelevant.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241001070418.28737-1-its@irrelevant.dk>
References: <20241001070418.28737-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.153; envelope-from=its@irrelevant.dk;
 helo=fhigh-a2-smtp.messagingengine.com
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

From: Keith Busch <kbusch@kernel.org>

The controller already supports this decoding, so just set the
ID_CTRL.SGLS field accordingly.

Signed-off-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 2589e1968ea6..d5ea9ad653f2 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -8536,7 +8536,8 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
 
     id->ocfs = cpu_to_le16(NVME_OCFS_COPY_FORMAT_0 | NVME_OCFS_COPY_FORMAT_1 |
                             NVME_OCFS_COPY_FORMAT_2 | NVME_OCFS_COPY_FORMAT_3);
-    id->sgls = cpu_to_le32(NVME_CTRL_SGLS_SUPPORT_NO_ALIGN);
+    id->sgls = cpu_to_le32(NVME_CTRL_SGLS_SUPPORT_NO_ALIGN |
+                           NVME_CTRL_SGLS_MPTR_SGL);
 
     nvme_init_subnqn(n);
 
-- 
2.45.2


