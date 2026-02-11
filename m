Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E418E9E31B
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 15:35:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqCFP-0002Hl-PK; Wed, 11 Feb 2026 10:35:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>) id 1vqCFO-0002Gb-FL
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 10:35:22 -0500
Received: from fhigh-b5-smtp.messagingengine.com ([202.12.124.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>) id 1vqCFM-0000K0-CE
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 10:35:22 -0500
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 5CB5D7A00FF;
 Wed, 11 Feb 2026 10:35:18 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Wed, 11 Feb 2026 10:35:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1770824118;
 x=1770910518; bh=kRaskWVLZ+EMyQS0rHkbu8KMaevc06vYhuviQ5J8e/0=; b=
 WNqQoEcmxb2V912Jr2vf7m4VH/wur6xUG1926Bfz2wsIuGxXXiXzoX8wmicFi/mY
 EQP6L2GDOM1nBVjmPp6M99JlEp0SFVQrSd7BYLK2UGonqUhW2qCsVnD5CGCdqm6i
 eZz7H7F2B7ju2e7CM7SshftiwEknAW4sNMzF+k/aMx4PcccASM7L/y8jWaU4jNpn
 pRuuXSI5B8En7+RAaV6LOXpJqF8nAdhVuyBZa1Afd/9jKlP/571jscpuFDbjnYQ1
 SWaU8rEcjXyCdspBQeIMHl5kSTB9Hk5Rzr5DhTnLfwqM0WBVR63+UdCiIK/M5AIM
 VgFoKPqnN5b+5nb44KONwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770824118; x=
 1770910518; bh=kRaskWVLZ+EMyQS0rHkbu8KMaevc06vYhuviQ5J8e/0=; b=e
 PnqsrB9QdJjCpqYK2PG2025bmQEJJHJSAvQgEwzUKNTsHql6kSi/tPOKgn/s9IW7
 K0ca7SBpbNrGe4XpjD79Pp/TvZOPYR3OGWh2kcAsmWCqjAjhSOOkLqS49qfL9lbs
 2siFP6scrGIw2rR4Mw13KAHvOvVCsxadfl3EeCM3MnXQXedr/wvERqk9xX1SQB/1
 R3gFmqb9sJc+rhyVm8eOyvS0jm3PesigejEfv82MIf6r12fQItTNejgch7nvwTeH
 178H8z6gPLDskhIAjgTnuSDQm0/Z5B6QryoKAWeO+KTSFWG/xYUK6nbATOdXxGcZ
 L+sPpaS4mE2DT3vebZn+g==
X-ME-Sender: <xms:tqGMaf69tyAYkF0u2XnD2a3uh9KB7zNMC7TJ_W-pJlg733DtBwy5Sg>
 <xme:tqGMafUmrzZvRFg3bjkMID2hV9F5I8EU1Zy3bRUWVKUsXxefh7G0mxKpHguIX7af7
 wDQPdE_69XPExDBnTPEEtkenjyQMw2yqzuz-TZDryPPA2Jq7S9a>
X-ME-Received: <xmr:tqGMad8y2le_8HOCfq0RNL5v07c29bgkhR8LHYOb5BUkeu2XyS_DE-DTYYA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtddvledvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfgjfhfogggtgfesthejre
 dtredtvdenucfhrhhomheptehlvgigucghihhllhhirghmshhonhcuoegrlhgvgiesshhh
 rgiisghothdrohhrgheqnecuggftrfgrthhtvghrnhepkeehjeeitefffeeuieetjedtje
 ffvdelledvuedvffdvfeetgefhveekuedvfedvnecuffhomhgrihhnpehkvghrnhgvlhdr
 ohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 grlhgvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohepudefpdhmohguvgep
 shhmthhpohhuthdprhgtphhtthhopegrnhhkihhtrgesnhhvihguihgrrdgtohhmpdhrtg
 hpthhtohepvhhsvghthhhisehnvhhiughirgdrtghomhdprhgtphhtthhopehjghhgsehn
 vhhiughirgdrtghomhdprhgtphhtthhopehskhholhhothhhuhhmthhhohesnhhvihguih
 grrdgtohhmpdhrtghpthhtoheptghlghesrhgvughhrghtrdgtohhmpdhrtghpthhtohep
 rghnihhkvghtrgesnhhvihguihgrrdgtohhmpdhrtghpthhtoheptghjihgrsehnvhhiug
 hirgdrtghomhdprhgtphhtthhopehkfigrnhhkhhgvuggvsehnvhhiughirgdrtghomhdp
 rhgtphhtthhopehtrghrghhuphhtrgesnhhvihguihgrrdgtohhm
X-ME-Proxy: <xmx:tqGMaXokIDaJLXJiuex1wNPjUrFc-3gnXg89zy-Gq04AelpOrgc3sw>
 <xmx:tqGMaYLDWr7QEA5uR6HLPkNb5g4335_0pRQQetrAidM0483p0QMXZg>
 <xmx:tqGMaSMVDimky4FwAZz-zrbSNQU_a_4D2Qg6DgXQR5nqUA294cyQhw>
 <xmx:tqGMadq96gVFBcZv7u3mLfa76ewTSpX7QZEu5NSKC9tVflt-OK3b5Q>
 <xmx:tqGMadE4WOgKN37opgItaL4E28LLEd30Y4dy6d4gooij4b2FzVQzWrSK>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Feb 2026 10:35:16 -0500 (EST)
Date: Wed, 11 Feb 2026 08:35:15 -0700
From: Alex Williamson <alex@shazbot.org>
To: <ankita@nvidia.com>
Cc: <vsethi@nvidia.com>, <jgg@nvidia.com>, <skolothumtho@nvidia.com>,
 <clg@redhat.com>, <aniketa@nvidia.com>, <cjia@nvidia.com>,
 <kwankhede@nvidia.com>, <targupta@nvidia.com>, <zhiw@nvidia.com>,
 <mochs@nvidia.com>, <kjaju@nvidia.com>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 0/2] hw/vfio: Enable hugepfnmap for non-power-of-2
 device memory regions
Message-ID: <20260211083515.724b64c2@shazbot.org>
In-Reply-To: <20260211030615.3202-1-ankita@nvidia.com>
References: <20260211030615.3202-1-ankita@nvidia.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=202.12.124.156; envelope-from=alex@shazbot.org;
 helo=fhigh-b5-smtp.messagingengine.com
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

On Wed, 11 Feb 2026 03:06:13 +0000
<ankita@nvidia.com> wrote:

> From: Ankit Agrawal <ankita@nvidia.com>
> 
> This series enables hugepfnmap support in QEMU for VFIO device memory
> regions that have non-power-of-2 sizes. This specifically addresses the
> needs of Grace-based systems (GB200) where device memory is exposed
> as a BAR.
> 
> ## Problem
> 
> On Grace-based systems, device memory regions can have sizes like
> 0x2F00F00000 (not power-of-2). The current QEMU VFIO mapping code
> aligns each sparse mmap area independently using the trailing zeros
> of its size (ctz64), which results in suboptimal alignment for the
> overall VMA.
> 
> This prevents the kernel from using hugepfnmap that enables huge
> page mappings for device memory. Without proper alignment, the
> mapping falls back to PTE, significantly impacting performance
> due to increased TLB pressure and page table overhead for large
> memory regions.
> 
> ## Solution
> 
> Patch 1: Sort sparse mmap regions by offset during setup and validate
>          that they don't overlap. This ensures predictable mapping
>          order and enables gap detection.
> 
> Patch 2: Change the alignment strategy from per-sparse-region to
>          whole-region alignment using pow2ceil(region->size). Create
>          a single aligned base mapping for the entire region, then
>          overlay sparse areas with MAP_FIXED. Gaps between sparse
>          regions are explicitly unmapped.
> 
> v2:
> * Fixed the code returning early without trace (Shameer, Alex)
> 
> Link: https://lore.kernel.org/all/20260130040649.42485-1-ankita@nvidia.com/ [v1]
> 
> Ankit Agrawal (2):
>   hw/vfio: sort and validate sparse mmap regions by offset
>   hw/vfio: align mmap to power-of-2 of region size for hugepfnmap
> 
>  hw/vfio/region.c | 126 ++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 98 insertions(+), 28 deletions(-)
> 

Reviewed-by: Alex Williamson <alex@shazbot.org>

