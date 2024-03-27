Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F91EC54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 03:07:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpJcL-0001uM-TG; Tue, 26 Mar 2024 23:06:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marmarek@invisiblethingslab.com>)
 id 1rpJcK-0001uD-Jv
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 23:06:20 -0400
Received: from fout3-smtp.messagingengine.com ([103.168.172.146])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marmarek@invisiblethingslab.com>)
 id 1rpJcJ-0004V0-2b
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 23:06:20 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
 by mailfout.nyi.internal (Postfix) with ESMTP id E409D1380174;
 Tue, 26 Mar 2024 23:06:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Tue, 26 Mar 2024 23:06:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 invisiblethingslab.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:from:from:in-reply-to
 :message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
 t=1711508777; x=1711595177; bh=n+fL4u4pIY1MP5INUg/5Z6ZGGe3TCZWv
 qrv4TyLguM0=; b=cqsAgg0DYn2BNGcf+Jt3riRiHWi8lHrqd+qFYi7oW9woTz78
 j01vb8gyY9bAeG3GPuxSlnkMHLAs6wTG5iP+duoVZAbOtWm4nMeENRpfF8iG2ByV
 FxAfHJEXpmcN1XnSkRSTH+DXW3V9ban1oEgmSDyFAqJFru5hLrOB9v2O2TFv50kK
 c+TMeC8yUlpowjcdX0H+OedCtlTy6ZxbmP6smSeq4RAUw5XyUndFEuno+WytZUvu
 fTQEGkP4ChsPa4DU2qO/vwSPdwSPd2zWR097QTrdqWyZmEO5ShRfK96v7ZaPC+TU
 Nk1xOMLwaPyJohLDV9yQZNVq6fzeIeFp+DE6sg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm2; t=1711508777; x=1711595177; bh=n+fL4u4pIY1MP
 5INUg/5Z6ZGGe3TCZWvqrv4TyLguM0=; b=PhnCCH4OJbq7+1/iqkae6QWGccVHx
 SRpcphB1WsJHHZklPBaxyOHg5vF2YhsTRz1Om2y6/ISZMU5Yng9skC9ue5zwf6TY
 iVEjblimj5W2AXbkVX79Tdr8RJwd78YOjofkSmr8T7DfUpT9h0TbN6qzj0/7D3cl
 TPDTs6sjLcMg6euCymgE6w+6Cl4qSYuL90uJySpjSBjK1nDuHtzvw269uB61J+Sr
 zF3ZhJWWMsZ3kFUCRbRGoiqrREMWIru4DhZujMWjJPv+4ULXRxp1bZjHMR1rK8/W
 jIxQRWOICIkhE5gaQtLQ1OWiQKK4DiVJDuw+vJGwzucMUXw+bhq+0pqkw==
X-ME-Sender: <xms:KY0DZspt-qo_vei4Lrp0KOOjjVsCQ-mlYFFtf1B_HLkuVKfZeYv03A>
 <xme:KY0DZipXcnWu7W1OD1aSmqtJMq3bxkub25IGIXLOJIMxRksrZmLVhXGKe4WM48T_U
 IoPS1ivgAPzFA>
X-ME-Received: <xmr:KY0DZhMxF3qrbe55n7QdoaJSCD4VIm-LFmPMQjkMiBkv6Ttpi63mF8Az6oPZl3ouYQGUFxxrDCmGMQ0kxx3GhYiNrANpTnJMwF5vEhgPqmDAmJ5RVRs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddugedgheeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffogggtgfesthekre
 dtredtjeenucfhrhhomhepofgrrhgvkhcuofgrrhgtiiihkhhofihskhhiqdfikphrvggt
 khhiuceomhgrrhhmrghrvghksehinhhvihhsihgslhgvthhhihhnghhslhgrsgdrtghomh
 eqnecuggftrfgrthhtvghrnhepleekhfduleetleelleetteevfeefteffkeetteejheel
 gfegkeelgeehhfdthedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
 hilhhfrhhomhepmhgrrhhmrghrvghksehinhhvihhsihgslhgvthhhihhnghhslhgrsgdr
 tghomh
X-ME-Proxy: <xmx:KY0DZj5jXs4Ed4MnNdTJl7eiyCtMdRzfX8zG23aQg3WHTlxarimGGQ>
 <xmx:KY0DZr65xSip9qCAVetI3BgR3QxWxwiHzOMIRXgAbv_ihTqTKvyN_g>
 <xmx:KY0DZjhmH4F2rMNtIjgs0st6gzVN_SUQNhlxGxPi3DWd801n9YlX4w>
 <xmx:KY0DZl5ncm7im6kvgu7aCRl6DvLEoMVfPxU6qiNGwnCCtWNH7P2AnQ>
 <xmx:KY0DZrEAG6cNt2bGbkQsQGIyL_zRHZrP-c4eWWeTJWeHE2w4GKh32Q>
Feedback-ID: i1568416f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Mar 2024 23:06:17 -0400 (EDT)
From: =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>
Subject: [PATCH v3 0/2] Changes necessary to work inside Xen device model
 stubdomain
Date: Wed, 27 Mar 2024 04:05:13 +0100
Message-ID: <cover.527f002866de2be7c275c5000b6e5edfeb7e8368.1711506237.git-series.marmarek@invisiblethingslab.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=103.168.172.146;
 envelope-from=marmarek@invisiblethingslab.com;
 helo=fout3-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

This is minimal set of changes necessary to run Xen device model inside a
stubdomain and still support PCI passthrough.

Marek Marczykowski-Górecki (2):
  hw/xen: detect when running inside stubdomain
  xen: fix stubdom PCI addr

 hw/i386/xen/xen-hvm.c        | 22 +++++++++++-
 hw/xen/xen-host-pci-device.c | 76 ++++++++++++++++++++++++++++++++++++-
 hw/xen/xen-host-pci-device.h |  6 +++-
 include/hw/xen/xen.h         |  1 +-
 system/globals.c             |  1 +-
 5 files changed, 105 insertions(+), 1 deletion(-)

base-commit: 5012e522aca161be5c141596c66e5cc6082538a9
-- 
git-series 0.9.1

