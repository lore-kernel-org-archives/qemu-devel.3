Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BA65F3381B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 08:58:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2QFH-0001Wj-DM; Tue, 17 Mar 2026 04:57:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1w2QCE-0001UC-Pr; Tue, 17 Mar 2026 04:54:39 -0400
Received: from fhigh-a2-smtp.messagingengine.com ([103.168.172.153])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1w2QCA-0006mU-SR; Tue, 17 Mar 2026 04:54:37 -0400
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.phl.internal (Postfix) with ESMTP id DAA9B14001B4;
 Tue, 17 Mar 2026 04:54:31 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Tue, 17 Mar 2026 04:54:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:message-id:mime-version
 :reply-to:subject:subject:to:to; s=fm3; t=1773737671; x=
 1773824071; bh=VsonbPCUmPMX4YdI5QxB8sbKyIsqHAI6PJ3cY5GKOig=; b=O
 794Zi/GO/P4WVe/Sj0ctCecjcdLg1ARRScFda0rRfibVmZobvUZeV73jGL0fNxhh
 jNy0W7v3U7K62Es7v9yjE6EdlvkEW5vyoRA+QzHv8ktIE8NQkyYVv0IMmiBxCBGe
 2wt9B1jPaqmOt2q3FRVrHaQ52eaIXXmBAa5TfSHvy/B5oCCNTRAa1WVB2oSFAsWZ
 /P5Qa2fheOII1dtfS1pLl4NuhOk3KsOqYKY4MGWl+mbigp20GxBEBobSMBeoMpFP
 LMifjDfCln+DpWOOx5Sg7vr50WSD1nImRAsaFGzR8LopbQOF++ziBXnzu895uyUY
 VKFOAoHWyf58kvc00+L2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; t=1773737671; x=1773824071; bh=VsonbPCUmPMX4YdI5QxB8sbKyIsq
 HAI6PJ3cY5GKOig=; b=hy4pQHy2vX8UILEC4//pXeBX20inu3UrbsYzo9y2Wgz3
 TunU7zq86hQHlqmdcuo3CCtEGdDa+Z4V/1aXaUSxUDJclHAmXzRxQSpa6c6h19ZT
 R/Z1setZPHul4pFGoPDPuyonTbRbU/c2ID/pmMZ5ttau+mJMsT8bPW36kHUbllZZ
 nxxqbGsBFKEo/uhi1ASilUDSU0z9cgxaZR27WCHFzkezJslmIWmGyiwq3ZABCI4v
 HhqyKYdyvxZa3f/2ttNfQcMh+q5r4FeNHvluZyp+CqwOiRst7NHdjStQUA2GR5qa
 p+vBZcRwgPtK9GKSC/SfT2ElDqp76Rqhv4MtmiddQQ==
X-ME-Sender: <xms:xha5aaonm1Epx3thX1xpz5QwGD1fcvWVpC9Rz0Il-ivW9lRMq1ueVw>
 <xme:xha5aUqdIgL3WTxJz5YCuZoaC1dZnLLn9YpTvetDsP_gIp0Roy_hvTeWXIMyrMyUG
 niuJ0dDCoNlGS9X_pi4TKj1rACKyUduZNAaNGQdTHvWiMTk7JcC8JI>
X-ME-Received: <xmr:xha5aRbFCLGsVHuNWXILKaBfV6y3n5ZrvKuWN5QuZH2_QjewpNASisZ6wmJcatcvNQHcXS2aAQuA2gZlNOdS3FWkCCS9Smg1iRQqRq_TfcfZwFfn1Ze4LDyD31d1fuQA8zhnEuE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftddtkedvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpefmlhgruhhsucfl
 vghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtthgvrh
 hnpedvfffhheeffeeugfehheduleelieejueduffdtudevtdfghefhtdffgfevkeeufeen
 ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehithhsse
 hirhhrvghlvghvrghnthdrughkpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhp
 ohhuthdprhgtphhtthhopehksghushgthheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
 epphgvthgvrhigsehrvgguhhgrthdrtghomhdprhgtphhtthhopehqvghmuhdquggvvhgv
 lhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepfhhoshhsseguvghfmhgrtghrohdrih
 htpdhrtghpthhtohepphhhihhlmhgusehlihhnrghrohdrohhrghdprhgtphhtthhopehi
 thhssehirhhrvghlvghvrghnthdrughkpdhrtghpthhtohepqhgvmhhuqdgslhhotghkse
 hnohhnghhnuhdrohhrghdprhgtphhtthhopehkrdhjvghnshgvnhesshgrmhhsuhhnghdr
 tghomhdprhgtphhtthhopehpsghonhiiihhnihesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:xha5aa-OyTiVmJBBQijAXdraZueIEsS5IvAGIcAvqMxXRe1CGtjRzA>
 <xmx:xha5aXnPdBY4Wj46fjVqm34xUwbDbMJK1_gTOOMbmiisiNyFAUN4MQ>
 <xmx:xha5afzBO8HmlWOaKBXtRCW9xUEsoGQ0OwV5QSMZcb_pXtSsO0KTRQ>
 <xmx:xha5aR4witSyx6DJ2BpLVp3pCp_0pQqCErljgTWNO2g31SzeoZqYDA>
 <xmx:xxa5acjJbIk5137PTPfRDFmm8MBuvXwVtml8kbb5pD7nKqnTqdgAiyQ2>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Mar 2026 04:54:29 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
Subject: [PATCH RFC 0/2] hw/nvme: support mdts above 9
Date: Tue, 17 Mar 2026 09:48:56 +0100
Message-Id: <20260317-lift-iovmax-dma-limit-v1-0-38729170683f@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHgVuWkC/x3MQQqAIBBA0avErBswI4u2QQdoGy0kxxrICo0Ip
 LsnLd/i/wiBPFOANovg6ebAx55Q5BnMq94XQjbJIIVUoixq3NheyMft9IPG6WTHF1ZSKdOURjR
 SQGpPT5af/zvC0Hcwve8HiAfBtGwAAAA=
X-Change-ID: 20260317-lift-iovmax-dma-limit-5266d83d0820
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Xu <peterx@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, 
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org
Cc: Klaus Jensen <k.jensen@samsung.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=799; i=k.jensen@samsung.com;
 h=from:subject:message-id; bh=shDRF/TUWKq3aNLiE8zAQ9iYzgYBD44SykUhMPEX04A=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFaTCtrQTBEQUFvQlRlR3ZNV
 zFQRGVrQnl5WmlBR201RnNUSkFsdkFMMUdXMmJNWEJGQWJNUXJrCnhBam9ocHdFT1puci9ISmFo
 Y25HNjRrQk13UUFBUW9BSFJZaEJGSW9NNnAxNHR6bW9rZG13RTNocnpGdFR3M3AKQlFKcHVSYkV
 BQW9KRUUzaHJ6RnRUdzNwaXFNSC9Ba3kvM1FOODkrOWo4OGFQN3hYOVBIR1hXR056K3pFQVVHdQ
 ppOEhvNG1BV05xb083bFptSkh3TEloa1VjeUk0WXg2eWNrNFJUaEJRK21Waklkc1luTUsxNVR5V
 UZrOFdVaFlKCjJYUURqV2U1L3ltaFFzUHZOQWdNOFRSV3EzYmpXbG5mcDlwcTVDTDIyTnVIR2p6
 dS9VSnQzcmlwR0lMYTdBaDMKaU9peDQxdklHbWhSWmNLWm5rQWNkSVNnTzM4K2M5UFJybTZmZmx
 FckJzTVQzM3F0K0JPVzcxUS95TUVQS0lxVwpCTXQwby9jTFR6aWFSOU4wZDlTc3poc0liZTNtMk
 VENTB4dTVURDNtcXhuRFBpQjcyQ3FEei80NktVRXhyOFBECmhyS2czTzNHeHE5OU1hMFI1d0RLQ
 UdzT2V3WWlOWG5aNlhRcUIyUUhaVk0zRWZ1WnRLYzBZYWU5Cj1pWnhyCi0tLS0tRU5EIFBHUCBN
 RVNTQUdFLS0tLS0K
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Received-SPF: pass client-ip=103.168.172.153; envelope-from=its@irrelevant.dk;
 helo=fhigh-a2-smtp.messagingengine.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

In commit 53493c1f836f ("hw/nvme: cap MDTS value for internal
limitation"), the max value of MDTS was restricted to ensure that the
device will not report internal device errors when hitting the internal
IOV_MAX limit of the block layer.

This series attempts to lift the IOV_MAX restrictions, by splitting I/O
in the dma helpers.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
Klaus Jensen (2):
      dma-helpers: lift IOV_MAX limit
      hw/nvme: allow MDTS above 9

 hw/nvme/ctrl.c       | 17 ++---------------
 system/dma-helpers.c |  5 ++++-
 2 files changed, 6 insertions(+), 16 deletions(-)
---
base-commit: 559919ce54927d59b215a4665eda7ab6118a48aa
change-id: 20260317-lift-iovmax-dma-limit-5266d83d0820

Best regards,
-- 
Klaus Jensen <k.jensen@samsung.com>


