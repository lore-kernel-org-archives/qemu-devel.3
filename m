Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51B25C4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 12:23:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rY3Qy-0003iz-RJ; Thu, 08 Feb 2024 07:23:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1rY3Qw-0003eu-Cn; Thu, 08 Feb 2024 07:23:14 -0500
Received: from fout1-smtp.messagingengine.com ([103.168.172.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1rY3Qt-0006y3-SK; Thu, 08 Feb 2024 07:23:14 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailfout.nyi.internal (Postfix) with ESMTP id E6DE1138009B;
 Thu,  8 Feb 2024 07:23:08 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Thu, 08 Feb 2024 07:23:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:message-id:mime-version
 :reply-to:subject:subject:to:to; s=fm2; t=1707394988; x=
 1707481388; bh=YQPL6G74xFIzEJSOWsuELr83BaeyVpIvYbBZVyEDTJo=; b=J
 XV+RZpPAErnn9mdkLlAPqA0l7XxQgg8yeHhtxq1ybaYcpA35PP/kR4B6Rfw0YmTL
 BbWdJXkMfOp3U0FObiwszutLGFkjWv4rIw2wCC5yUJoGbp0PqZv2X8pdMllqh2OE
 obGCffIyyCNJVgkiCa5/gF4fLlSOU96o8VTbx7zBerWGY6gEDfZGj3C1jKon7ZQv
 7DxsGLwvLQbMTlORwEqwrtP8/nYidafbxgSEv6zn8ASxCON1zPS4ci1RRmJbmHRq
 brgys9CE+4n1gt61i1XVu3grD1iEnpS2gIIW+Cb+1FDDZ1+leEtZOcx4KZJwowek
 QWlALadqFl+A2MMH1NmhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; t=1707394988; x=1707481388; bh=YQPL6G74xFIzE
 JSOWsuELr83BaeyVpIvYbBZVyEDTJo=; b=h1p7wj5taOogoZdAdSt4FWK0iX2Or
 GGnomQJoUUGtA31sSYxHB9htJ+k24pbmyUjHvu0v1ePCb8JX7p7LMtQ3VnROWYym
 0Rny2GB6LQi3nJnw8I032BEclyEXFl/YW02DKwwI+9VenmucMAPHiRBvRB2LFbk7
 brTy7oQigKU75cWKtKamn5qa26QzWSpOmZwuqr206EGWcoRT9YFQ860Rtfoq3EYa
 6metQZgrmtLI1bPYfbete4a0lLSWN3B/Rvf25wuD7P0zlwm+TMGV3/hQE+UhzFBC
 354OpvKNudLyuQm/VHGZf1BVm745TP4lydBOttk9GnZQEBEfMRZ31n2rQ==
X-ME-Sender: <xms:rMfEZbJPgL_tvY1F-Zm6WDmXOIyic3USf2tQ5m390DfxJA1g9SqmFw>
 <xme:rMfEZfL2Se3MqnPGU-vzzDQar3lilJ8KzwYe0rxmv8aHtM0ylhqazw44wqsUU_Hbr
 0RLMirFGn3w4GTsYbQ>
X-ME-Received: <xmr:rMfEZTvp0_a91dMGX-hO3k2eSBFcXJZ8wTW70bsUnktcFIBo1FtW-852WsJhifdik3SZJBIcfkfRZaYIycqcqv5MILB_5Sas5yVyc2xuK339blsLlpJ9ScisTrxwHnzxQTwNDQpkVG10P2gL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtdeggdefjecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhfffugggtgffkvfevofesthejredtredtjeenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnheptdehveejiefhgfegiefhfeehueeigfeugfelhfdtffevheffkefhkeegteetffet
 necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihhtsh
 esihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:rMfEZUa8DO194u2oXDK70G5o-q37wvJ1YofW4uvqSyWzpu_eJuMxdA>
 <xmx:rMfEZSbSXuA2XtKwAmHpNP-260i_8NjGQsFzi5XrfwpuDN9ggIerQw>
 <xmx:rMfEZYA6HOkuGD3wUuobpbyhDUSv9aVXtWP7Hxq1io1tRmPoRIRP7A>
 <xmx:rMfEZZxaUDHjOVk1noMkPRf3F_WMPVRes8LXZDWPuhW02vomFjTYXA>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Feb 2024 07:23:07 -0500 (EST)
From: Klaus Jensen <its@irrelevant.dk>
Date: Thu, 08 Feb 2024 13:22:48 +0100
Subject: [PATCH] hw/nvme: fix invalid check on mcl
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240208-fix-copy-mcl-check-v1-1-6f89df85f9d3@samsung.com>
X-B4-Tracking: v=1; b=H4sIAJfHxGUC/x2MSQqAMAwAvyI5G6itdfuKeCgxanClBVHEv1s8D
 szMA4G9cIAmecDzKUH2LUKWJkCT20ZG6SODVjpXWlU4yIW0HzeutCBNTDMaV/S1NbrMbA4xPDx
 H65+23ft+r7hMrWQAAAA=
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, 
 Klaus Jensen <k.jensen@samsung.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1091; i=k.jensen@samsung.com; 
 h=from:subject:message-id;
 bh=xZut6aF5lBgiX8Du3i/xTmuTF0rrbD74QbTb7C9a/cs=; 
 b=owJ4nAFtAZL+kA0DAAoBTeGvMW1PDekByyZiAGXEx6oMrnb6LxLdsjL2fsLpFv34q/veLLJgZ
 IFdgQXYKgF0dYkBMwQAAQoAHRYhBFIoM6p14tzmokdmwE3hrzFtTw3pBQJlxMeqAAoJEE3hrzFt
 Tw3prqAH/RAja1RAGGGVweugkr63qCwXH6zKsmpa4yMRm5e4uHKXStnfSgg84WyrVeBjSXsfG+R
 Zt6e2MxvTsnVMkLivgAxPwSU3t5w4qHNPcgQiiBFqVHrbFh68iC/9pWUNCYT27Be+CDtS6uQ+ur
 /mZbt+56zn/2PuhZ8z3Qti1DUH20gPypeoLwBKAS3res7sl9vHfT0mSB80rM6NNJR82vX9SL9/7
 vO12y52SKa86gHW2FIesjpk2R3Kdewb+8WJ7tBlpw6Naby88fVj825MD99Y2OVBQW9b67qDIaZH
 6xY8vBrdLpXPoV/gpOBjvehz0fOPUOKhdxR1qXGgZVLMNtN1lqbVuLIb
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Received-SPF: pass client-ip=103.168.172.144; envelope-from=its@irrelevant.dk;
 helo=fout1-smtp.messagingengine.com
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

Fixes: 381ab99d8587 ("hw/nvme: check maximum copy length (MCL) for COPY")
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index f026245d1e9e..05c667158a3a 100644
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

---
base-commit: 39a6e4f87e7b75a45b08d6dc8b8b7c2954c87440
change-id: 20240208-fix-copy-mcl-check-3a6d95327154

Best regards,
-- 
Klaus Jensen <k.jensen@samsung.com>


