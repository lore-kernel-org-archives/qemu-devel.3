Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EC88C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 17:28:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk5tt-00028n-PK; Tue, 12 Mar 2024 13:26:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1rk5tk-00024n-LH; Tue, 12 Mar 2024 13:26:45 -0400
Received: from wfout4-smtp.messagingengine.com ([64.147.123.147])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1rk5tg-0005OJ-RS; Tue, 12 Mar 2024 13:26:44 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailfout.west.internal (Postfix) with ESMTP id DD9081C000ED;
 Tue, 12 Mar 2024 13:26:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute5.internal (MEProxy); Tue, 12 Mar 2024 13:26:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1710264397; x=
 1710350797; bh=13jK2IFXNV4aTtLcfKWBEUfG4qVN5gepwxltR43I56A=; b=Z
 QqN30J2F30OBspg40v8ru6qKpoWsIqI0brGv/XtTcyZYN4rueZJc/5EUGnDniQod
 pbYUvGK+kUyv9kOzlQNhYrm6c8XzP/SPGtOgAtxgWz7RQzlaYbnjMhYEcPgXc9wb
 MpK4lNEVCE2krBydFZhtT/SwtwOtneDvsvuMrxwPaCYuWa2AernTxFJBlgil404g
 SfyMoOVdQZsmpzgT1Ms+wuEv1Aq4b5ySmck6XyHSDfBcggEjshq1THVMFbZn3M57
 sCU4T46f4stEYCQifCKuOzfo3nNtNHQ6Iacmo0RHHHazX1YwXYMqv5o7PbMuL3BK
 CTBPiFWY0g8nxmhx8g2Jg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1710264397; x=
 1710350797; bh=13jK2IFXNV4aTtLcfKWBEUfG4qVN5gepwxltR43I56A=; b=e
 Zuv9pziKW2fe0yT0WuMjyVAzNchkPHqAGDUXnlb7eBgoUwaLw9PGM7HYT/fofGLw
 A9Rr6Z4HDAeHi6c8h8wT/or+BeLMo1JwqS7PnVjuT+WRulQFhn8Qq9bWqm5p7nR0
 5HJrVFWGQTbsZyl/P4i8jTIo9/lI0ji9iQaxkzMXuht6AvCmf7wSGY5w6DMUERDY
 fLdNs9KN6MQbRju/S6CJ4irf0FcNMAVEIgTnCR6D+DFBL4edRv8te6bZZg+T5uDg
 EwxxNV1VGn1KlzKv911JSKllK68RSPmRqZ6GkeiTBeR0VIsC9NpOjBQ8/ZUd9zht
 QUxNdVkOEkWYRcJXTJ1YQ==
X-ME-Sender: <xms:TZDwZUQMqFABzfeLrAD-zA8wayYZyN6pkf2kjy3xfN-_5k1vvE4amg>
 <xme:TZDwZRxtOOFUTeDHjX5HkZsl6h4AEGksaIAtPWwwk5d1d4s8uD5jvKDxrzuZn-sdc
 TZGS0HqRMCUJhnN76M>
X-ME-Received: <xmr:TZDwZR31PWz89NNbohk_I7XYiDHN-dS5CZ-0k8ic9tnWOkdClZfm9PS48OWlyOFTUeog7V6awQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeefgddutddtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghu
 shculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrth
 htvghrnhepjefgieelgfeiveehkeeuveehheekfeevgeeigfehfefgjeejhefffeegudej
 udegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
 htshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:TZDwZYDXOCISt73gj-pomw6qRDEcZy6JkvFla_TSapdSx6EbDLk2bw>
 <xmx:TZDwZdiFFIqtSWyxcBpV0S5S6HPzdA1AP_XPN2SIjbb_DVN3x5jU7A>
 <xmx:TZDwZUqpA297VEiJxg8A-KssJnoYXsBwgLcvpFUbldF-Nwpl5nWMAg>
 <xmx:TZDwZQgifT39YzNOzIahNKsNtpJt1AH2U3KiArRMF-9HKE52M4Dsbw>
 <xmx:TZDwZd7d1hiS3orf_4nmVpxDCqZQyY0W5d4vX2obHI3IXxVHCxYjm9JXmno>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Mar 2024 13:26:35 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, qemu-block@nongnu.org,
 Yanan Wang <wangyanan55@huawei.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jesper Devantier <foss@defmacro.it>, Klaus Jensen <k.jensen@samsung.com>,
 qemu-stable@nongnu.org, Minwoo Im <minwoo.im@samsung.com>
Subject: [PULL v2 2/6] hw/nvme: fix invalid check on mcl
Date: Tue, 12 Mar 2024 18:26:25 +0100
Message-ID: <20240312172622.58652-10-its@irrelevant.dk>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240312172622.58652-8-its@irrelevant.dk>
References: <20240312172622.58652-8-its@irrelevant.dk>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1006; i=k.jensen@samsung.com;
 h=from:subject; bh=29IW2qUZendh/4uF6O1NNuOeOuNodGl0+hczTMx8y10=;
 b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGXwkD63MM2YL4haIMM0TcnKl5nI/enGn4KRx
 98LSvMfPETdkYkBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJl8JA+AAoJEE3hrzFt
 Tw3pdSoIAKxnRQFqJt0TRRsWMK5MLkkGpPp4frlTjU4MsFRglprwM9qP3gEAlhVMvmdf8aRtAp2
 G/IZvpl/YDY8zHOJvWoHr1qESKAef22YeAKMcllZyzQnNHuNsVcg7JIU9d4M/JIsBgzdPtABFMw
 8U1QRSDQDnljoj6ExXD6XGuak9ug58E3l4y02ERll9zwjfCyJKHi+RtuS7f8D92KMR4+fIew6sG
 55YjJXUqUF/yX5lt9+cKLCVmM5XEiyrQi2qm47PAfPwWUIvImE0H1mpzFkjAUqgSWGq8jbC/Syt
 JkDR59RdYt/rJ9cVAV+wTNrC7BOVjfT9SLMN+t+K6yQik+2IWRKAZqF5
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=64.147.123.147; envelope-from=its@irrelevant.dk;
 helo=wfout4-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The number of logical blocks within a source range is converted into a
1s based number at the time of parsing. However, when verifying the copy
length we add one again, causing the check against MCL to fail in error.

Cc: qemu-stable@nongnu.org
Fixes: 381ab99d8587 ("hw/nvme: check maximum copy length (MCL) for COPY")
Reviewed-by: Minwoo Im <minwoo.im@samsung.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 94ef63945725..abc0387f2ca8 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -2855,7 +2855,7 @@ static inline uint16_t nvme_check_copy_mcl(NvmeNamespace *ns,
         uint32_t nlb;
         nvme_copy_source_range_parse(iocb->ranges, idx, iocb->format, NULL,
                                      &nlb, NULL, NULL, NULL);
-        copy_len += nlb + 1;
+        copy_len += nlb;
     }
 
     if (copy_len > ns->id_ns.mcl) {
-- 
2.44.0


