Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B52AEEEB565
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 08:51:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sofYA-0000mk-9n; Thu, 12 Sep 2024 04:51:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1sofY1-0000Lk-I0
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 04:51:30 -0400
Received: from fout1-smtp.messagingengine.com ([103.168.172.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1sofXz-0000kX-Hc
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 04:51:29 -0400
Received: from phl-compute-08.internal (phl-compute-08.phl.internal
 [10.202.2.48])
 by mailfout.phl.internal (Postfix) with ESMTP id 4042F13801E1;
 Thu, 12 Sep 2024 04:51:26 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-08.internal (MEProxy); Thu, 12 Sep 2024 04:51:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1726131086; x=
 1726217486; bh=uT/Q7V3blH4B35gEc+1Kewo99yALHnwF8zABDAf6L9I=; b=n
 jjkw4boFq0uWFkO8SkuZ9Q5+GO/8Wxk96UxVi2A81trgd3PqSiPQYdA55o1p29R7
 Gp+e69Nx1L6LCEa+n/oG6TRAPNaFEqDp7ouDvbhR0k+BYwgiO7b1TAP1tkQW7ZHy
 q/93dcsJrEtvyfPd7xBwjB11SN8yyo5XP4dJRaQwhbrRZVyelZ/wNhr7YRmU7jWj
 mx5FsAq/KcCch/C+G3UsbsK14Q+7VF5/pdCyWxEx8FkyvvNqCGg8T5uK5UPp50VE
 Uej5F8zLimLmTDgqm3vpNS4fmCHDBQw511zxETWeC+M9/20G3PduNlLzlmr13z2W
 nLw0+aTRUkC5n9Gjx+zRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; t=1726131086; x=1726217486; bh=uT/Q7V3blH4B35gEc+1Kewo99yAL
 HnwF8zABDAf6L9I=; b=J7xDnx7v5mY1f/CX5hb3wZooeZdZtL1XbuXzmQpB1wOa
 gzKyBH3hMWJEOn6IAyWoVh+P77ELJuEBXW3bapOhV+9tQ6fCLWE5ACGnu4TKusLS
 4m9pgBgqJGtfwN/g+4FlY+RQf/SmgIzEfOSQI9CHGssDWIpa3OOYDgTwfRi/s/4m
 QclG6BZQeB9T8/U4mmJlE4O7b7CVM+180t3rWRJ5Y2dqTWGLy8hNE46lz773BwOp
 iUBbUkW7kXgcXPNceVZtlDgJEeHIi0nlUIHz+NirsBGe7BDYbqhJkiNs59ULfc7+
 B1V84iV488Yj4rjlBmDtXPl7OBfvp5l1E/jfBPwtLg==
X-ME-Sender: <xms:javiZt8WYJ6blclJxK0tsQqUTKFo6M3u0n1SZhg5TspZx43Hi4YkYA>
 <xme:javiZhszAIPB7lpWWQnePIh0oUQlupK1NamPwoShL-15_gW24wjnQUNdL_zciwz0B
 KRFQD2txGouXEmnDwc>
X-ME-Received: <xmr:javiZrBcRHPlG59kuBDZAn9SgTdL-1v-S67BEcobWxLMzhiJEu0oLH09ejoWIg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejfedgtdelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
 fukfhfgggtuggjsehttdortddttdejnecuhfhrohhmpefmlhgruhhsucflvghnshgvnhcu
 oehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtthgvrhhnpeelheejtd
 dtjeefueegleelvdegfefhveeuffegffeiheetfeelgeegtdfgueetteenucevlhhushht
 vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehithhssehirhhrvghlvg
 hvrghnthdrughkpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgt
 phhtthhopegrrhhunhdrkhhkrgesshgrmhhsuhhnghdrtghomhdprhgtphhtthhopehqvg
 hmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepkhgsuhhstghhsehk
 vghrnhgvlhdrohhrghdprhgtphhtthhopehfohhsshesuggvfhhmrggtrhhordhithdprh
 gtphhtthhopehithhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:javiZhcDhdZhtSUJ0hFWqD-Von-bZj2UOaUtwp4AIvmyGQjbNb78gg>
 <xmx:javiZiO_4N7sDe084muSuKzhcdg5KYIcPTmlutYj2wjD3Z4ZsCenqg>
 <xmx:javiZjlwleBKu4_F3hnhHIXvMDffLSJGO-8Wi3gU_vdqy79fI2Fwmw>
 <xmx:javiZsuPnTc4WKKYwu3sFvtp8p8XvZmyybCwrosbywBYqSfnii14gQ>
 <xmx:jqviZp24l9BwCCRtNIljzwkZma71RwZqsFJ3r5abjg9pRjxWHsZ9D_Gk>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Sep 2024 04:51:25 -0400 (EDT)
Date: Thu, 12 Sep 2024 10:51:24 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Arun Kumar <arun.kka@samsung.com>
Cc: qemu-devel@nongnu.org, kbusch@kernel.org, foss@defmacro.it
Subject: Re: [PATCH] hw/nvme: MDTS Enhancement
Message-ID: <ZuKrjDSXEqEZkAvp@AALNPWKJENSEN.aal.scsc.local>
References: <CGME20240716132257epcas5p2528015d52067d84cedd62fb32bef797a@epcas5p2.samsung.com>
 <20240716075334.2932985-1-arun.kka@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240716075334.2932985-1-arun.kka@samsung.com>
Received-SPF: pass client-ip=103.168.172.144; envelope-from=its@irrelevant.dk;
 helo=fout1-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Jul 16 13:23, Arun Kumar wrote:
> Updated mdts field to only include interleaved metadata if metadata is
> interleaved and MEM bit is cleared to 0
> 
> Signed-off-by: Arun Kumar <arun.kka@samsung.com>

Thanks!

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>

