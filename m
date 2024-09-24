Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F81CF9C71
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 06:06:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssygb-0003jA-UZ; Tue, 24 Sep 2024 02:06:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1ssygZ-0003if-Jd
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 02:06:07 -0400
Received: from fout-a8-smtp.messagingengine.com ([103.168.172.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1ssygV-000485-5z
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 02:06:07 -0400
Received: from phl-compute-06.internal (phl-compute-06.phl.internal
 [10.202.2.46])
 by mailfout.phl.internal (Postfix) with ESMTP id 773A413804A7;
 Tue, 24 Sep 2024 02:05:56 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Tue, 24 Sep 2024 02:05:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1727157956; x=
 1727244356; bh=e04zb5HGL3QVArwBufHOWwYJH0/t/0OnOvxNptv2Imw=; b=S
 4OLgC6212bJq6cUCPlIFbkDyJAy/yFajJULtsM/ywdvPIyz8h4ZsfWL/3lrvMdqH
 qLeA0mmpUl1f153Uff8bQJgqd0gh0dwu8M1Or1A2saWkV598A5j5xCmV1mgO6fVL
 mDAAeDuXRFMCxl+NM7SOD69gk3qy5hJzEn9pHpG/K9KVC1CJ2mhxI4XqlqlmPuD/
 tGTBoU2yaJXhn/yxQl/IhBmcJgmGNdIZabTCt6Cr2Idruio2E12DyKSYAS1hmwal
 P6/JBIZ8rbB2Z5wEIyPvP6oQDllXSmnuHJJgearesMw3goebI2fC2EZ22Dqr0qhr
 zJttcuQXjSAzhEUQ6YB7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1727157956; x=1727244356; bh=e04zb5HGL3QVArwBufHOWwYJH0/t
 /0OnOvxNptv2Imw=; b=RXpOAHmv7/QkhWrr2EzxaWkde3OLNFPN14u8ueVDSzZx
 VBe5pfPoAbCJ201ZcDE17QyAyDQZlHRnLd8P1ZUgq8za7yWwhbvx7wrFIG5egWvE
 /VcplBTNX/NHVJ3jF+AIBG2vXnc0MRq52h+62uoEXRdbNBmUCQactBYtEw+CZbB/
 W4LUa4rAaMrCgOMpE51c/aQaBK9GuwIubfFH6zoX9kBDB/0bXslu6fEFlcChlG9p
 xTXJqdvwCoE6HxGi4wpB3x2tapmZPP9G1QB04Fsb5UFVFj+0OuRsImt6baAQeAiJ
 BNnrv0+VJxfzTtkoWuAfZopP8O649RYuGto95YTxYw==
X-ME-Sender: <xms:xFbyZj-z73_cjEOx7ukSDW5UahyRbeOIB3bPkUrLIX93Qp8seVvblA>
 <xme:xFbyZvsHJPy8iJSTaKd2C8B_l2T5fYNeurtwX8691LYoZuv0hbAm_PEcRS4XlDxLI
 vmYgV66UXZ6QNYonoY>
X-ME-Received: <xmr:xFbyZhBAR7eeLWxKtQViZ220o6k4HeN2InVKIiwRwYKNfOwDluDk5mJEm3uu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtuddgjedvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
 fukfhfgggtuggjsehttdertddttdejnecuhfhrohhmpefmlhgruhhsucflvghnshgvnhcu
 oehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtthgvrhhnpeevjedtje
 etveefhfffheeivdffvdduledviefgkeefveeltdeiteffheeggefgudenucevlhhushht
 vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvg
 hvrghnthdrughkpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgt
 phhtthhopegrrhhunhdrkhhkrgesshgrmhhsuhhnghdrtghomhdprhgtphhtthhopehqvg
 hmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepkhgsuhhstghhsehk
 vghrnhgvlhdrohhrghdprhgtphhtthhopehfohhsshesuggvfhhmrggtrhhordhithdprh
 gtphhtthhopehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:xFbyZvcSiECv7ZqBSqY-PvRKgnXSOuU1Y8RYtVz6latX0uW-jMe2Mg>
 <xmx:xFbyZoPB8aToc1AtWZtzeLI7-Zm0F5l5hNR06wTuOhQIq1lsorGYRQ>
 <xmx:xFbyZhmzde4JbVoyQEb8-CSssxLQFgkTAnU-E-x3sr1xhoj9WM_baw>
 <xmx:xFbyZitJr4I5F5KRt4bBoYW6VYNiz_Vgl_XlNIEA3Lk5tp2pSH85Lw>
 <xmx:xFbyZn3CExFP9k_InvUe8vnqNt2kOoHWCG7sjh6o3fWxq6J8AIzYvT7z>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Sep 2024 02:05:55 -0400 (EDT)
Date: Tue, 24 Sep 2024 08:05:54 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Arun Kumar <arun.kka@samsung.com>
Cc: qemu-devel@nongnu.org, kbusch@kernel.org, foss@defmacro.it
Subject: Re: [PATCH] hw/nvme: MDTS Enhancement
Message-ID: <ZvJWwhJg39K_Oej5@AALNPWKJENSEN.aal.scsc.local>
References: <CGME20240716132257epcas5p2528015d52067d84cedd62fb32bef797a@epcas5p2.samsung.com>
 <20240716075334.2932985-1-arun.kka@samsung.com>
 <ZuKrjDSXEqEZkAvp@AALNPWKJENSEN.aal.scsc.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZuKrjDSXEqEZkAvp@AALNPWKJENSEN.aal.scsc.local>
Received-SPF: pass client-ip=103.168.172.151; envelope-from=its@irrelevant.dk;
 helo=fout-a8-smtp.messagingengine.com
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

On Sep 12 10:51, Klaus Jensen wrote:
> On Jul 16 13:23, Arun Kumar wrote:
> > Updated mdts field to only include interleaved metadata if metadata is
> > interleaved and MEM bit is cleared to 0
> > 
> > Signed-off-by: Arun Kumar <arun.kka@samsung.com>
> 
> Thanks!
> 
> Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
> 

Picked up for nvme-next. Thanks!

