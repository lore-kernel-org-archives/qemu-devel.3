Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E92C6C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 19:12:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjl3a-0001nr-Aq; Mon, 11 Mar 2024 15:11:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1rjl3Y-0001mm-1c; Mon, 11 Mar 2024 15:11:28 -0400
Received: from wfhigh7-smtp.messagingengine.com ([64.147.123.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1rjl3W-0000EV-Es; Mon, 11 Mar 2024 15:11:27 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
 by mailfhigh.west.internal (Postfix) with ESMTP id F1B43180008B;
 Mon, 11 Mar 2024 15:11:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute7.internal (MEProxy); Mon, 11 Mar 2024 15:11:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1710184282; x=
 1710270682; bh=13jK2IFXNV4aTtLcfKWBEUfG4qVN5gepwxltR43I56A=; b=N
 eBw+O9Q0OO+wPdLZyok5rqRDdjGDC24TTdXE2AxTirW78wYXiA1uN0SoLZgug+4r
 oC9xJtSY2doEDFTHiIVejtP3+imPmWarXIHfEJ+lviloS7+nRnTOpqz5omq3OUob
 Tm6WKiHpypw1Mj6yLSFoEhaJAog4wfoV4utVVqcH/RtHbevRNKGFLRlXkgiYAMTE
 bngMOPkFTNWYOom7L+E4aVH46DKVfmIvj42vo0yEYqJAhB8HJazI91CUjM9Tm1o7
 pTaacmwQMiLIHIlMHQgbvblnks6uJc8FeKrc4PjmoXBujgSOPifa0utgbVx7Hnxq
 tHvhfIqkwSkLOjP6yu92Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1710184282; x=
 1710270682; bh=13jK2IFXNV4aTtLcfKWBEUfG4qVN5gepwxltR43I56A=; b=e
 TJ7UKXP0se+Th7OJBMKN6YvkCA4woZ1fQmOtUH6VIb8FX/XiUZe4P5Z6g+IePpa+
 qHcuouuzDYXZPycHdno+/qEj8kZFb3Y32Nqn6Pt+qm0AwSC/jMlx77FDxtSLSiFb
 AarUpcOxYvkfEI3ZPQLsBH/1zgSV025M7tKKuWJjo+6BrZeKvHEkKpWz2xEC15qq
 BuKGkn/US6G3or5LuSCXKJeBOE5KTJMwNux4/kggdpDIV1xJAIa9ngqcIUbOyLGU
 3KfgJwK0sxm2qtuVKa06J3mWjmR/zqlJWzMP88mkWkgDW+rGx7vYL1V2nPxqhCHZ
 OLa2UMrEUuuFM1BGm+80w==
X-ME-Sender: <xms:WlfvZaYHRMj5IupAyviJrt8bL4xcpxA0-fQDiSi_xm7rNrFuJbieYA>
 <xme:WlfvZdaB1KxAU0YtNG5sEH8ovaIf3D1Hiw0QljI0qoHamrcAZiDG8jPWFfzVJc71F
 RZ0CiXCnB76e4i-xwQ>
X-ME-Received: <xmr:WlfvZU_kyb-k1k8ajASAXClVjTx_-uCJpVn44O77Lz65tAL6TvT2bdOt4Y3TIZjVvXJemKvVzw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjedugdduvddvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghu
 shculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrth
 htvghrnhepjefgieelgfeiveehkeeuveehheekfeevgeeigfehfefgjeejhefffeegudej
 udegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
 htshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:WlfvZcqbzEvdxMlzITEIPrvuKepPC7gdWV82ZTXLPhpm3w6rwa7U3g>
 <xmx:WlfvZVqVkSCfSvsf0YXC4IQv3kpyKdkGgoHz5PDhe-NupHXRNgKOFw>
 <xmx:WlfvZaQPCuaJ6cFGnkFjzAUdKuoB8kGT2DyEp_7AvrB4NebIQUJVgw>
 <xmx:WlfvZW78P9oV52G7WGe-RaaoVHPCz_Xh9xgo5TM9dKL-0VNVxvR9EFuQd6w>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Mar 2024 15:11:19 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-stable@nongnu.org,
 Minwoo Im <minwoo.im@samsung.com>
Subject: [PULL 2/6] hw/nvme: fix invalid check on mcl
Date: Mon, 11 Mar 2024 20:11:08 +0100
Message-ID: <20240311191105.35224-10-its@irrelevant.dk>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240311191105.35224-8-its@irrelevant.dk>
References: <20240311191105.35224-8-its@irrelevant.dk>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1006; i=k.jensen@samsung.com;
 h=from:subject; bh=29IW2qUZendh/4uF6O1NNuOeOuNodGl0+hczTMx8y10=;
 b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGXvV0q3MM2YL4haIMM0TcnKl5nI/enGn4KRx
 98LSvMfPETdkYkBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJl71dKAAoJEE3hrzFt
 Tw3plLMH/2niDmHuQ5okyCT6X2puLO9AZqkInlgSowAZUmwSbesqfkl7Ks2wdXBAevYa9ZrgNhZ
 afUIT6rLOHLfeMkFHlob+LREbukx8Upy2l242Nc7uqc3/uVA+EigKlCkhL9Dkh1Q2yHbyO+5BgL
 SsiUCGhVj4BjkdINvEWsku9mon3rvewwqYRrVhLbijEjn2aDDtJh8BxVtm4B45/KqhhjrV/DR5j
 0m9nXWrmTcou/yMjfSLp2LiAgFcbgUEU55ymcCmZpPJg5dE5St4lFynb4TXnmk1Xa2no1TfuJjl
 XD8M5Lcuc2iaCgFRaFfjWd6q9Ir/85hcX0FZk9MfOnPlkiHORZMW5akP
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=64.147.123.158; envelope-from=its@irrelevant.dk;
 helo=wfhigh7-smtp.messagingengine.com
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


