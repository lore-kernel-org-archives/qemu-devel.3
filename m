Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BA2BD1BDD9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 18:15:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t81au-0001C6-7g; Mon, 04 Nov 2024 13:14:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1t81ae-0001AT-IF; Mon, 04 Nov 2024 13:14:13 -0500
Received: from fhigh-b5-smtp.messagingengine.com ([202.12.124.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1t81ac-0004pC-Q4; Mon, 04 Nov 2024 13:14:12 -0500
Received: from phl-compute-02.internal (phl-compute-02.phl.internal
 [10.202.2.42])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 7601D2540146;
 Mon,  4 Nov 2024 13:14:09 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Mon, 04 Nov 2024 13:14:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1730744049; x=
 1730830449; bh=RJRcNBQJk++EiHlGSytaI/nqJ+tLHzU7H2CpK0Gr7J4=; b=m
 ot7IXVQmD53HITaup8UHK6UH5VgPiOFjjqDDE2WKBsZJ2KEUmxw2AM5bPzIo/0hA
 s3ukjzEQ8zTgVksdJkNA43VmeMxQU1UbqvRuSHceQ6pzhTPEhmCMiU/34yO09XKY
 ww7sdwhxyAy+agg1IDy+WaAJ8qu3l9IonG6WMB2kRr8S+kDAh56uNPtHOQxFoLoJ
 oGkTVqKNrqKlwYKmyIxFGYtOkV5bgIkXs3fSzXxVkSMrENY1NzlZCHDBhs46EGc3
 JHVCjYGX56QfeTUGK9k9lK6havYGPSZYcwfaXR2sdc/mIvDvrN9IMyQDEVpwwSAd
 ikTWysrRxkg8trWahAb+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1730744049; x=1730830449; bh=R
 JRcNBQJk++EiHlGSytaI/nqJ+tLHzU7H2CpK0Gr7J4=; b=hulsniKugekhh9SHx
 0HYB2bz2WoUkWCW2/RCkbibtIJ3c9Jvbr7a0r8QGp7P62x5gRPlD91R9dIBHysBw
 8gcxy/c6Iq2Lbbj/LKpZ9DF2me3x0a4PptxmMwUjm/Hkp0BUlc7MFu6d8XAwyeDU
 Q9u/JgvRhWhYgvsgz5RXd7nHQyJp9RXXTn8z8yhoppXPAgjTzsS/iJB6rxaP+Y35
 cCLPKvEGzgFUkHn8mmg5cu/3IO1TAa5XthCil/GJ9q/JmlF5wpR6T/4C8sZf+qFJ
 oQ6kMu19qDfDWpy245rze1xiND/6uW9VTa2ME4XGJf8JeQvajsIO+JxQB7G9gZhq
 em/tw==
X-ME-Sender: <xms:8Q4pZ1LCNWPtr66z9x_L_Mwch0M3OvJz6owqn0gxMa5B2S97Q2t2ig>
 <xme:8Q4pZxKFBxKfVWPHR_N7XH_v6VrQYPwdTZA4LonfQmfg_U11so_w8kSYIeKn6Numw
 hrnx7ZEsEe5Fs6kVGQ>
X-ME-Received: <xmr:8Q4pZ9ssuq5yUZvwhEPloAe45nFkjR7HkxMfI9w_eKPRgamgGupo3rwZtp07TRVlC6Cg_lMJzm6rj40iEQErmQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeliedguddtkecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
 necuhfhrohhmpefmlhgruhhsucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnth
 drughkqeenucggtffrrghtthgvrhhnpeehfeekgfejjeejjedutdeigeegteefveekudef
 heevjeekieeuffeuleeiheeugeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
 hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihhtshesihhr
 rhgvlhgvvhgrnhhtrdgukhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouh
 htpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphht
 thhopehpvghtvghrrdhmrgihuggvlhhlsehlihhnrghrohdrohhrghdprhgtphhtthhope
 grrhhunhdrkhhkrgesshgrmhhsuhhnghdrtghomhdprhgtphhtthhopehkrdhjvghnshgv
 nhesshgrmhhsuhhnghdrtghomhdprhgtphhtthhopehksghushgthheskhgvrhhnvghlrd
 horhhgpdhrtghpthhtohepihhtshesihhrrhgvlhgvvhgrnhhtrdgukhdprhgtphhtthho
 pehfohhsshesuggvfhhmrggtrhhordhithdprhgtphhtthhopehqvghmuhdqsghlohgtkh
 esnhhonhhgnhhurdhorhhg
X-ME-Proxy: <xmx:8Q4pZ2ZHWTJNFOApf4VuXu1CJq2OMktFa_czVQ7sbpeDeWbDQcJIkQ>
 <xmx:8Q4pZ8bOdCiYeU3i9FvtCcYMt3SLqj00uD-ZWOmmQG7QkSgNgUiEeA>
 <xmx:8Q4pZ6CK8P76ZnJwkfDa2kfbFuXZ6ONRfNaQqWRdZ-pkslxIjrFCCg>
 <xmx:8Q4pZ6ZXFKcugJqyMdlmaXls6KO6UKD_S3HCuyVVgC7HxPKZLTYt1g>
 <xmx:8Q4pZyMCinzxptj__szxb6d_yvT7FIAre3tc-D6udMzd5b6ahdv0z9R2>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Nov 2024 13:14:07 -0500 (EST)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Arun Kumar <arun.kka@samsung.com>, Klaus Jensen <k.jensen@samsung.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org
Subject: [PULL 3/3] hw/nvme: remove dead code
Date: Mon,  4 Nov 2024 19:13:06 +0100
Message-ID: <20241104181306.2329-4-its@irrelevant.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104181306.2329-1-its@irrelevant.dk>
References: <20241104181306.2329-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.156; envelope-from=its@irrelevant.dk;
 helo=fhigh-b5-smtp.messagingengine.com
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

From: Arun Kumar <arun.kka@samsung.com>

Remove dead code which always returns success, since PRCHK will have a
value of zero.

Signed-off-by: Arun Kumar <arun.kka@samsung.com>
Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Link: https://lore.kernel.org/r/20241022222105.3609223-1-arun.kka@samsung.com
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/dif.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/hw/nvme/dif.c b/hw/nvme/dif.c
index 01b19c33734e..28051284984d 100644
--- a/hw/nvme/dif.c
+++ b/hw/nvme/dif.c
@@ -575,11 +575,6 @@ uint16_t nvme_dif_rw(NvmeCtrl *n, NvmeRequest *req)
             uint8_t *mbuf, *end;
             int16_t pil = ns->lbaf.ms - nvme_pi_tuple_size(ns);
 
-            status = nvme_check_prinfo(ns, prinfo, slba, reftag);
-            if (status) {
-                goto err;
-            }
-
             flags = 0;
 
             ctx->mdata.bounce = g_malloc0(mlen);
-- 
2.45.2


