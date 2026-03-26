Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6238106F2FE
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 08:25:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5g1K-00036P-BS; Thu, 26 Mar 2026 04:24:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1w5g1H-000352-0y; Thu, 26 Mar 2026 04:24:47 -0400
Received: from fhigh-b7-smtp.messagingengine.com ([202.12.124.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1w5g1D-0006lA-G5; Thu, 26 Mar 2026 04:24:46 -0400
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.stl.internal (Postfix) with ESMTP id DFED07A0287;
 Thu, 26 Mar 2026 04:24:40 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Thu, 26 Mar 2026 04:24:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1774513480; x=
 1774599880; bh=gQH1ApkEVGpG7hoRi0wrrA6c5eVpDnsCS8lGdKrEb8s=; b=i
 irc5U0H6IRyYgOITuzRJmPTwpZUkasUCpQQuLkIuWcU/jX/YVoOmoRwWzedQLz35
 cq8jZwtoOBa9G/hU/vc+9ax1CPj9QBZqI8Orfra7KSIopysYTueOpSbGUe2A9qRV
 6jWGTHDBRBl23hrBzzALz+QRbzolhXbPplqOy24SJWXvbB6u2p3q62IvgZNN/RL7
 ZHRdqKDbeMkkft+He+okZBwhDvwKqvfwwP1NCqnv1c9xnT/HbvU4NbZgWHqI9DBs
 vjazRrdbDt1OD10HC5XzOBpl6wiQ29MSVlU7bfETwaxxK4VbXNlm1yhahx/RQaEL
 Nripe63sM4vMRD44jNm6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1774513480; x=1774599880; bh=g
 QH1ApkEVGpG7hoRi0wrrA6c5eVpDnsCS8lGdKrEb8s=; b=BU3Ej55G7b9E2Hwhv
 aH/6gHkXubFJWz3jRj/hy8hpezIcITnR0M80tAF5JPWJk+Jc5NjyCq6x/dBFBxLK
 xWJzLlHJe8UB2fHIfxLpW0/2rDtGPGVCSkc8+Gm+F0KZIRnCiXm/fxV8PTGn7gRW
 eIuXj2allczJ7jQ32SVM1OX21VK54EgYjxsBaZj7SuRaI6FQbBBKZsDMYnMR5Vml
 MEMJ5NReJDh9bta8ZGrEcjnCDMg9hUSF+6a3xCScQ3qNgngLgxGB8Z1eUDG72r70
 XihxxpTOee7usCn3CQW4iV7ppSAdVpYxASvgNARrwddjhHYWzb8PjbkWSlHCy3bb
 2o8hg==
X-ME-Sender: <xms:R-3EaWR_AVucZBa6CAOTr1pPMKzrmCXw_p-dtzwCq4rac98Eyat9Kg>
 <xme:R-3EaV11lJKTDNxkmkLlAArgGRKkpa1M1Y76JZAY6PGmLet_WmA60mqiU1LmqKzSB
 rghV58_Fh9CaXknSHwJ-bRIV9cDDk-c8DMg_mVONFJtfG8ZBTtvWxs>
X-ME-Received: <xmr:R-3EaTviPRajmFTq3o0JDWMqVGVKb-R-x6bklLA03C5a5Q80tVMqJ3vw7ePsH0HqVenYJ48gi3qPl-BMZOdJzsSS_HCE_r6i2ODAvdKKlKYdDb2rHVgJ95VSJA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdeikeekucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhlrghushcu
 lfgvnhhsvghnuceoihhtshesihhrrhgvlhgvvhgrnhhtrdgukheqnecuggftrfgrthhtvg
 hrnhepheefkefgjeejjeejuddtieeggeetfeevkedufeehveejkeeiueffueelieehueeg
 necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughkpdhn
 sggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehqvghmuh
 dquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepphgvthgvrhdrmhgrhigu
 vghllheslhhinhgrrhhordhorhhgpdhrtghpthhtohepphdrrhgrghhhrghvsehsrghmsh
 hunhhgrdgtohhmpdhrtghpthhtohepkhdrjhgvnhhsvghnsehsrghmshhunhhgrdgtohhm
 pdhrtghpthhtohepkhgsuhhstghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehith
 hssehirhhrvghlvghvrghnthdrughkpdhrtghpthhtohepfhhoshhsseguvghfmhgrtghr
 ohdrihhtpdhrtghpthhtohepqhgvmhhuqdgslhhotghksehnohhnghhnuhdrohhrgh
X-ME-Proxy: <xmx:R-3EaThQZ1jq2gHQPnuOc1MC1kW_2yi3XKv7BF0SdVt7wtiSBrPTFw>
 <xmx:R-3Eac81PI3vwYs2GFYHRJwaq2JIVZVJi-hDFZpC01vucSt3f1kKpg>
 <xmx:R-3EaesAuMwvEyxJ80wfcQlUglsQAkDWuoCWW9dyp96LDH1VoKtgGA>
 <xmx:R-3EaYoUDkaAINoDQmHmx-bGTW6Bim5qKCWempjo1V3S4HrLu7naqA>
 <xmx:SO3EabYuVkgaaFcPy0xDM_OSFSy1uuin0tf4_-yPJrLcZqwqdsZ_v3EL>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Mar 2026 04:24:38 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Pankaj Raghav <p.raghav@samsung.com>, Klaus Jensen <k.jensen@samsung.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org
Subject: [PULL 1/2] hw/nvme: re-enable wzds bit in namespace dlfeat
Date: Thu, 26 Mar 2026 09:23:48 +0100
Message-ID: <20260326082350.17374-2-its@irrelevant.dk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326082350.17374-1-its@irrelevant.dk>
References: <20260326082350.17374-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.158; envelope-from=its@irrelevant.dk;
 helo=fhigh-b7-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Pankaj Raghav <p.raghav@samsung.com>

dlfeat was changed from 0x9 to 0x1 when PI support was added.
It was removed because we can't rely on unmap and have to physically
clear it to get the checksums right but that doesnt mean that we do not
support the bit.

The spec says that if wzds is enabled, then the controller supports
deallocate (DEAC) on write zeroes. But DEAC bit in write zeroes command
is only a hint, the controller might choose to physically write zeroes in
those areas.

As we are sending write zeroes command with BDRV_REQ_MAY_UNMAP to the
underlying block device anyway (if the unmap operation is supported),
change the dlfeat value back to 0x9.

A new flag FALLOC_FL_WRITE_ZEROES has been introduced in linux for
fallocate which will use the wzds bit in dlfeat to quickly zeroout extents
using unmap operation whenever possible[1].

[1] https://lore.kernel.org/linux-fsdevel/20250619111806.3546162-1-yi.zhang@huaweicloud.com/

Fixes: 146f720c55 ("hw/block/nvme: end-to-end data protection")
Suggested-by: Klaus Jensen <k.jensen@samsung.com>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ns.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
index 38f86a17268f..b0106eaa5c8f 100644
--- a/hw/nvme/ns.c
+++ b/hw/nvme/ns.c
@@ -75,7 +75,7 @@ static int nvme_ns_init(NvmeNamespace *ns, Error **errp)
     ns->csi = NVME_CSI_NVM;
     ns->status = 0x0;
 
-    ns->id_ns.dlfeat = 0x1;
+    ns->id_ns.dlfeat = 0x9;
 
     /* support DULBE and I/O optimization fields */
     id_ns->nsfeat |= (NVME_ID_NS_NSFEAT_DAE | NVME_ID_NS_NSFEAT_OPTPERF_ALL);
-- 
2.53.0


