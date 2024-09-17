Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8AC3C35FF0
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 08:00:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqT7a-0005e7-Cq; Tue, 17 Sep 2024 03:59:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1sqT7Y-0005ct-67; Tue, 17 Sep 2024 03:59:36 -0400
Received: from fout2-smtp.messagingengine.com ([103.168.172.145])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1sqT7W-0001SK-E9; Tue, 17 Sep 2024 03:59:35 -0400
Received: from phl-compute-05.internal (phl-compute-05.phl.internal
 [10.202.2.45])
 by mailfout.phl.internal (Postfix) with ESMTP id E9C25138048F;
 Tue, 17 Sep 2024 03:59:30 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Tue, 17 Sep 2024 03:59:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1726559970; x=
 1726646370; bh=21moGT/uRZtn5YPs2QO8GpshJTNEE/ERddKUVti6nck=; b=h
 01sCw8/6a5Ay0YUMPVPKzbqbPiAiWLe+nz3kWQk2x3grd5VELXa5HJIPXHKx781b
 eSMr3j8ACXyyuLLZ4jpRhuYpI8EmSgyNzoZXiTJjH5jVBbmyAy/JyYVbPFBLkC49
 bXxF/L1o7PjxvYD5gs1x9AQrreJ500Ug/WoWD/TxF2/N0IDrJ6iwcb6cuPbQNeaL
 jMRPVhAxyu5PTcJwsfRay9b1mQI5yeDavzXyeQm7LcEBBwZCs5W54Yd/dXq4xSgp
 Z6Jv9MgFcb5ZjEBLis0wTvddUu7GM80pEgiWzvsgaPa751Euhtr2vThFrQtQLorJ
 7S0aSbAWpRDNUcdpbijnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; t=1726559970; x=1726646370; bh=21moGT/uRZtn5YPs2QO8GpshJTNE
 E/ERddKUVti6nck=; b=LGw148jEyyWMyZ4pP9hVP0Lrq7NIUPKvqhhhsXQy92kM
 1L6i/S8DoqlKCCK/ukwPY0CTOIzB1cWhcPbL4Jd8s+gNX+OS7b/0xYZMDpqObggc
 HyNlTibg+i9bUmVK5JAycb0EDztVlgZvqcHd8gGfYC32Ffv/C5f0vyXFSgJ6mfLU
 blCP7+H8AdRUWMYpxvAXx1u7EwvMj49RljX6/HMp5oq03AXhoMEF18gfhH6sBSs1
 fT5S1CXHQVehd6OO/6xmdfmzerlhbNykrC0rizIF81BVS0qMLELdOB2HzLj6bgti
 72pxwd2gX4OOPzcUY+jzSX7Yjm+Il/8liUCdQ8UIIg==
X-ME-Sender: <xms:4jbpZkH-YpGdqzMKluUknRCGlWwM6Qz3DXBivuUL9l9VYwen7MyoUA>
 <xme:4jbpZtXDduEzu8PEn5ihOtzsIEhB0WaTQpEToa8gVD7o4SmQK8_MCkbaLo-9Q3_ff
 UNMfrq6L8CUSNMREGU>
X-ME-Received: <xmr:4jbpZuIXP-lr_NTCFmp_BtdzTI5l3EdXA3creFyLJy1tt9wNPLg-XQwJ90iBnQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekiedguddvlecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttdej
 necuhfhrohhmpefmlhgruhhsucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnth
 drughkqeenucggtffrrghtthgvrhhnpeevjedtjeetveefhfffheeivdffvdduledviefg
 keefveeltdeiteffheeggefgudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
 epmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughkpdhnsggprhgtphht
 thhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrlhgrnhdrrggurghmsh
 honhesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhn
 ghhnuhdrohhrghdprhgtphhtthhopehksghushgthheskhgvrhhnvghlrdhorhhgpdhrtg
 hpthhtohepqhgvmhhuqdgslhhotghksehnohhnghhnuhdrohhrghdprhgtphhtthhopehi
 thhssehirhhrvghlvghvrghnthdrughk
X-ME-Proxy: <xmx:4jbpZmGjjUQdlZxrhO4Gs1csTPngkj1Zsp6SV9MiQjmb9N03HgUFUg>
 <xmx:4jbpZqV6x2gJTGIE6otArS1JpKr6uwN9pMxR1K0KawCMvvjVg5F5iA>
 <xmx:4jbpZpMSInzdAg0vFI6TcbaZ277_3wucgITS-ENgH59zeXZF6zZQMw>
 <xmx:4jbpZh2MU4P8E6L-HLHEpr-XchQdPzXz1ZyNzGqMkTViuVh1Co380A>
 <xmx:4jbpZseGqiL4xwZ3_JbuNcD699uWO0X2O4b3_YrRrxlP1L9H-0SkC8VU>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Sep 2024 03:59:29 -0400 (EDT)
Date: Tue, 17 Sep 2024 09:59:28 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Alan Adamson <alan.adamson@oracle.com>
Cc: qemu-devel@nongnu.org, kbusch@kernel.org, qemu-block@nongnu.org
Subject: Re: [PATCH 0/1] hw/nvme: add atomic write support
Message-ID: <Zuk24CCgPIZgmN1e@AALNPWKJENSEN.aal.scsc.local>
References: <20240820161123.316887-1-alan.adamson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240820161123.316887-1-alan.adamson@oracle.com>
Received-SPF: pass client-ip=103.168.172.145; envelope-from=its@irrelevant.dk;
 helo=fout2-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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

On Aug 20 09:11, Alan Adamson wrote:
> Since there is work in the Linux NVMe Driver community to add Atomic Write
> support, it would be desirable to be able to test it with qemu nvme emulation.
>  
> This patch will focus on supporting NVMe controller atomic write parameters (AWUN and
> AWUPF) but can be extended to support Namespace parameters (NAWUN and NAWUPF)
> and Boundaries (NABSN, NABO, and NABSPF).
>  
 
Hi Alan,

I am trying to test this with John's atomic-writes-v6.10-v9 linux
branch, but that does not seem to work for me.

Do I need anything else?

