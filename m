Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B49EC2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 12:02:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFXHr-0000eD-K7; Thu, 15 May 2025 08:02:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1uFXHo-0000T5-IQ; Thu, 15 May 2025 08:02:04 -0400
Received: from fhigh-a7-smtp.messagingengine.com ([103.168.172.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1uFXHm-0002vE-SM; Thu, 15 May 2025 08:02:04 -0400
Received: from phl-compute-11.internal (phl-compute-11.phl.internal
 [10.202.2.51])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 16CB911400E9;
 Thu, 15 May 2025 08:02:01 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-11.internal (MEProxy); Thu, 15 May 2025 08:02:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm2;
 t=1747310521; x=1747396921; bh=2fpLrWhSMVV3ZJwVq4I73yta7aLfsNOs
 Z4YR97D2gVE=; b=h2oCZib/YNzrqox3g8MF6tJFcgSt/7QUUFOGOOAdba5jttoW
 XsYZBD3Ic7ocQrTrGriAA5YcKY+w4J9u3WoiHLvPARvCmaQb2VnJbtz6f81jaD30
 Hy5pwVglqS7Dqc39Edus7PFKRNyNRl+0wHVB8Wyw7Tu11XkWOJLciaedOflmvGq1
 hbXRtjekcY/FOmw5vGP8kb8WMnCzSWn9FD5wn/XytBxiKRjE4CMRdhS9htPXDFdM
 R5RA6eR25OWQTLCe9Rj0IN0/5UQaivEP1fm7uLWm92hHEqABj5wD4UkoSWj7rlJI
 OdMqE3rd0I+TwRw6l8hmJGhls7DBMq90GLPwzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747310521; x=
 1747396921; bh=2fpLrWhSMVV3ZJwVq4I73yta7aLfsNOsZ4YR97D2gVE=; b=Z
 4koNgm/zOUPPCqLzuyErAOmNbWzStCelIko0C4SmwV3DO7pCqhR4oU5AjBZViCsd
 7kA3hGoFcd6bR5ofiGXQmmn4Y2PYlFhx24msEjT+1yDHNUH0f7iiAfwLpILOpbCO
 NQYrqjeRa9HDESd5oNKMu/DnK4FaDeeJLdWHITfRuhXujkMF6fVLJK6pAy6T+MS1
 UUzlSkw+TbIm9SyyxnyTnbjpQ1nQReYTK0VhfD+ETuFp8Y3kEi5s7qQMl0sMob4F
 oD1Ww/uGJ1jf604i6SnaPMkpy8+4zVN+c5WFZ7iR00Ba4yJsvoSIE3PqCQdrLZsv
 063TT3qr8mDSxMddW3S4g==
X-ME-Sender: <xms:t9claJzQQbPeBQjjMYm0dicadUUrN4HDn_WQEH3Z6Ylk7zSDogjdEw>
 <xme:t9claJQWOFR_kdPj6ikAtqQCnH-mHWsudbVCMdDoUxwtEdc_Ps6iCg-CCwv0xFfvO
 8YNyKOII853MHg9o48>
X-ME-Received: <xmr:t9claDXt-l-b0vstmqo87ogIcySDaMvp3dlStJRTfJiEInnNd6EFTexJJa0qTMzipj8yOlgrCxadCX7QIMKbAzo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdelkedvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
 gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhggtgfgsehtkeertder
 tdejnecuhfhrohhmpefmlhgruhhsucflvghnshgvnhcuoehithhssehirhhrvghlvghvrg
 hnthdrughkqeenucggtffrrghtthgvrhhnpeevvdegieetieejjeejudeljefhkeevjeeg
 veduueekvddvtdfgveeuteehgeetveenucffohhmrghinhepghhithhlrggsrdgtohhmne
 cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihhtshes
 ihhrrhgvlhgvvhgrnhhtrdgukhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtph
 houhhtpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgt
 phhtthhopehpvghtvghrrdhmrgihuggvlhhlsehlihhnrghrohdrohhrghdprhgtphhtth
 hopehkrdhjvghnshgvnhesshgrmhhsuhhnghdrtghomhdprhgtphhtthhopehqvghmuhdq
 shhtrggslhgvsehnohhnghhnuhdrohhrghdprhgtphhtthhopehsthhgrhgrsggvrhessh
 htghhrrggsvghrrdhorhhgpdhrtghpthhtohepkhgsuhhstghhsehkvghrnhgvlhdrohhr
 ghdprhgtphhtthhopehithhssehirhhrvghlvghvrghnthdrughkpdhrtghpthhtohepfh
 hoshhsseguvghfmhgrtghrohdrihhtpdhrtghpthhtohepqhgvmhhuqdgslhhotghksehn
 ohhnghhnuhdrohhrgh
X-ME-Proxy: <xmx:uNclaLgJtDZOP2_IwYiQwtcS_MdP2H6pUNmz3JOoBYD9Y5eBqEj6_g>
 <xmx:uNclaLA3R82IQd_-3LH_-X4ZioyPCpuEFmRgXI8ccPtKbKK7AEk51w>
 <xmx:uNclaEJygdpiOpxgwDMwQtuWKrfv62wkLndg5Z8NJYbUhc550RJ7YQ>
 <xmx:uNclaKCDOlnVR4-OaFubbi8vFf8LRiMeD4lHfTOYpeXWTbCYMoPvbw>
 <xmx:udclaJnnpM5_FFtogxtkZSfvxkx5q04_Y7SlLebv7EEPlKbODhs1M-Oc>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 May 2025 08:01:58 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-stable@nongnu.org,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org
Subject: [PULL 1/1] hw/nvme: fix nvme hotplugging
Date: Thu, 15 May 2025 14:01:47 +0200
Message-ID: <20250515120148.11804-2-its@irrelevant.dk>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250515120148.11804-1-its@irrelevant.dk>
References: <20250515120148.11804-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.168.172.158; envelope-from=its@irrelevant.dk;
 helo=fhigh-a7-smtp.messagingengine.com
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

From: Klaus Jensen <k.jensen@samsung.com>

Commit cd59f50ab017 caused a regression on nvme hotplugging for devices
with an implicit nvm subsystem.

The nvme-subsys device was incorrectly left with being marked as
non-hotpluggable. Fix this.

Cc: qemu-stable@nongnu.org
Reported-by: Stéphane Graber <stgraber@stgraber.org>
Tested-by: Stéphane Graber <stgraber@stgraber.org>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2950
Fixes: cd59f50ab017 ("hw/nvme: always initialize a subsystem")
Reviewed-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/subsys.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/nvme/subsys.c b/hw/nvme/subsys.c
index 38271d78c8bd..777e1c620fd0 100644
--- a/hw/nvme/subsys.c
+++ b/hw/nvme/subsys.c
@@ -226,7 +226,6 @@ static void nvme_subsys_class_init(ObjectClass *oc, const void *data)
 
     dc->realize = nvme_subsys_realize;
     dc->desc = "Virtual NVMe subsystem";
-    dc->hotpluggable = false;
 
     device_class_set_props(dc, nvme_subsystem_props);
 }
-- 
2.47.2


