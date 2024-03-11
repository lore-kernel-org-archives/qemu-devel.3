Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41A22C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 19:13:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjl3e-0001ol-1O; Mon, 11 Mar 2024 15:11:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1rjl3b-0001nx-Ro; Mon, 11 Mar 2024 15:11:31 -0400
Received: from wfhigh7-smtp.messagingengine.com ([64.147.123.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1rjl3a-0000F3-9S; Mon, 11 Mar 2024 15:11:31 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailfhigh.west.internal (Postfix) with ESMTP id 7A45F180009E;
 Mon, 11 Mar 2024 15:11:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute5.internal (MEProxy); Mon, 11 Mar 2024 15:11:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1710184287; x=
 1710270687; bh=yzwycJF1YoesaBUmclU+Ge6urJCZcxStE+/F83YbfiM=; b=k
 KUr6P1D0psBQwHvdkrVfB/MusGaEbsWCSAd9UmADdE8GVh4XAZGDI2C+3CobGpxT
 Dufz7XAmGkvs6i48g+zEt/NdVBYhWrd5ZLVYP5CXWNp6wqMlBLKXT2alJBz+zIRe
 lTkDIu959j7ok4MzgxlxVQe4LFzbZ5kUNb6wjnb8roQMN0ZGJf4zE4Pwvthv2Plu
 MadhrpLfPdOVBFbeMF9EM0UvmqTIieHAm8mOXp79/N1nKG/LaYvoSgxk3UBVAhYe
 rZYZP1TZrcA/Iayt02t6P36s7W+FCV0vOK2nnoZMs2j7OqOh33J5xvu9mbQHQrcL
 qyd2D3qHyjIHbmSaveMxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1710184287; x=
 1710270687; bh=yzwycJF1YoesaBUmclU+Ge6urJCZcxStE+/F83YbfiM=; b=X
 34rP4Qm2pAM5T+o6ZVXS4RJsdZUDyZyZT64rq1XdYm3i0xTV1rKsMo/0z40X8bqM
 kPa/PyuOJjP8OwTjb2YWSBfiqnox8jdtZ2QTWk2H5KOis+tzohRzPlXDOyGQuIuK
 Ziuetp6W0jVa9KVJYjmOFM2E9rLXFaQnLpXdWqFe1aVGgfzToX80pzUVGt35+ApF
 6G7T0896YqWJm2qw4YAdudMWoBQe7Bkdvj5DBaPE7/OejZsQ0ai08D1FhH5TnC9k
 xl4S3j+sLvWLIm4nH30NFAjq6dp7fyciu6/NNVvJ9zxEh/mKbHCKQA0xe45kuyFT
 RpMO5xhcBj6A1g0RBxhlw==
X-ME-Sender: <xms:XlfvZVbdb3VWhlz3IKHTIcnNAKJ-_XT4X8kb0igBnccJkqsHGi18xQ>
 <xme:XlfvZcadumgnvtW9hzFdEjvyG9lSwRFrHVqfMQZbnYSl6WQzgTewFSi1_5v2OYbBE
 4ZXR_1HuezkpW-mOlQ>
X-ME-Received: <xmr:XlfvZX9pHV9iu3O05K5XrHFPmBDRgZWQcol7ewXPbnbr3OPy5kZjYhR_vl6j1ELPIx3GaIWxvg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjedugdduvddvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghu
 shculfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrth
 htvghrnhepjefgieelgfeiveehkeeuveehheekfeevgeeigfehfefgjeejhefffeegudej
 udegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
 htshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:XlfvZTpxRZTm-9GS12IAf3Rq-cezMzQog7g8wlNSN7kKvhdwqJ-RXg>
 <xmx:XlfvZQoWB2_PdpEkZHxnMndtuhvrOpL_jIwe6hWs38L2xhfUBuqnuA>
 <xmx:XlfvZZT67yHOy752YiGlCc4MkAEyY7qlSRtmEqnFkvt7ynOReKGlqg>
 <xmx:X1fvZVTaicdSQrLUT3xsPdATUfIAWR6-V71i2fbNRvzP50NBYLPXVtlp36Q>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Mar 2024 15:11:24 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: [PULL 3/6] MAINTAINERS: add Jesper as reviewer on hw/nvme
Date: Mon, 11 Mar 2024 20:11:09 +0100
Message-ID: <20240311191105.35224-11-its@irrelevant.dk>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240311191105.35224-8-its@irrelevant.dk>
References: <20240311191105.35224-8-its@irrelevant.dk>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=709; i=k.jensen@samsung.com;
 h=from:subject; bh=KwZk2OfOX/c12vcnmuOOH6UBK2IEVxYGtINXXuDLU/s=;
 b=owJ4nJvAy8zAxej7cL1hrj/vS8bTakkMqe/DvZTtuv9uu/VqwrO3shV7fu9TWx6iXbZ/p57HJ
 t05B2qjdV93MhqzMDByMciKKbIEaRivKn1059ki97QDMINYmUCmMHBxCsBEslw4GBoz5P3e6y7e
 Oo+BY/9vbt1N5X+POe11PqP7ttVTR2Ta7p3PfXjrX5t1e1tJh27p6Lk8pyI+20W3IuQkN5Pphss
 zi8LWMHg2WOw5tpPnxAEhlanhkXbvb25+mBQk4pJ0MfhiofR1boPeEy+jxb4vsNON+REnEfEhse
 5Skpjn4bg1R4xU1P9yyq1u+67oXWmSvv2AZviHhudZt0zb6/LKw6ov5sQtf18g/WyFvd++E0bXr
 dapFvhXb1y9fqtpw125Zl6D/TGiChmCvlHW2+el3j5caKo+kTmq9Mj7FcsmnPfotIqb8OT9Oktf
 bnE185r69V4B3fNe1cRZtjouLm3vulrOwWFvMWNT+QRn7R8AR26i4A==
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

My colleague, Jesper, will be assiting with hw/nvme related reviews. Add
him with R: so he gets automatically bugged going forward.

Cc: Jesper Devantier <foss@defmacro.it>
Acked-by: Jesper Devantier <foss@defmacro.it>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4d96f855de5c..e21e18e93c63 100644
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


