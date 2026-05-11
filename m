Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03C2DCD37B9
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 11:44:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMP3L-00067L-Al; Mon, 11 May 2026 07:44:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>) id 1wMP35-00064f-Bi
 for qemu-devel@nongnu.org; Mon, 11 May 2026 07:43:49 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>) id 1wMP33-0006uk-4B
 for qemu-devel@nongnu.org; Mon, 11 May 2026 07:43:47 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 706A760125;
 Mon, 11 May 2026 11:43:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA488C2BCB0;
 Mon, 11 May 2026 11:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778499813;
 bh=q4sYFUv4z/6QEQIgQSpzNnKSOnwrkW15GUtyfAUtJm0=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=CHuCdQ6yyuFqAFiJwQ1eFfZZvdPsUSZsdEi1TZhaaLub+WT7VnvXmsPUV6kGZ6LLj
 clfHpbl/aeo2ikjB6PcvKSCzUBf1x4784Hfj7DCPKVnQZCaazumktVFcQ3E4g5/2NC
 72pW22sh51+1l/xu0x6VwWElQl8/nZtsRGlFeh/M5TtJSM9Q8v4c8FexBvOpf10FrQ
 aRfMhfe9W9k8YFY8Lq4GFUED3BBwPFNb0NDSC+KhWwG7hUd5Zj7gLMGkKjmNEeUIGs
 MAHqgXKFSfdUx5xm0uL6GJsVlmdxGBJOEtsHKTRaUABGIvwq9RllXznfwy/jDI2bkU
 3XysgK3RM/sFQ==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfauth.phl.internal (Postfix) with ESMTP id DC38FF40083;
 Mon, 11 May 2026 07:43:31 -0400 (EDT)
Received: from phl-imap-14 ([10.202.2.87])
 by phl-compute-01.internal (MEProxy); Mon, 11 May 2026 07:43:31 -0400
X-ME-Sender: <xms:48ABajdpY2pVBjWokIpjkCIA3ZJHANakxh2iXhIPjTCxv-yAXQM0AA>
 <xme:48ABakAKHilgtrssFtmDMNdmHuRjcr8Sew3jVlmUKESy1Wvn4y3v7gGjmjxgjkwFD
 BNjfgNDYcOMAQ4v2teEMRxXzOs4400-4REI_3lpzEg140boMDKSwEk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudekkeegucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvvefkjghfufgtgfesthejre
 dtredttdenucfhrhhomhepfdetrhguuceuihgvshhhvghuvhgvlhdfuceorghruggssehk
 vghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnhepvdeuheeitdevtdelkeduudetgf
 fftdelteefteevjeevjeeiheefhfejieejfedunecuvehluhhsthgvrhfuihiivgeptden
 ucfrrghrrghmpehmrghilhhfrhhomheprghrugdomhgvshhmthhprghuthhhphgvrhhsoh
 hnrghlihhthidqudeijedthedttdejledqfeefvdduieegudehqdgrrhgusgeppehkvghr
 nhgvlhdrohhrghesfihorhhkohhfrghrugdrtghomhdpnhgspghrtghpthhtohepuddtpd
 hmohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghvvghlsegvughkvddrghhrohhu
 phhsrdhiohdprhgtphhtthhopehmrghrtggvlhdrrghpfhgvlhgsrghumhesghhmrghilh
 drtghomhdprhgtphhtthhopehpvghtvghrrdhmrgihuggvlhhlsehlihhnrghrohdrohhr
 ghdprhgtphhtthhopehqvghmuhdqrghrmhesnhhonhhgnhhurdhorhhgpdhrtghpthhtoh
 epqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopegrlhifihhl
 lhhirghmshhonhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepjhhgghesnhhvihguih
 grrdgtohhmpdhrtghpthhtohepshhkohhlohhthhhumhhthhhosehnvhhiughirgdrtgho
 mhdprhgtphhtthhopehtuggrvhgvsehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:48ABau8bAzM9bFZtEDnDLXLnn4XkE0SZ5pd4Q-Hy0xGOZZBQx_LXIA>
 <xmx:48ABahygNLY9hhZGXf6LOCMHHP5ohwCB6Mx3bt5Bcb90MsqNnE1j_g>
 <xmx:48ABauorLxpnLMk0XyMSSegsNdvj7wGax7SeIM7Uy-utFM2aiN3f0Q>
 <xmx:48ABaipmRMgnxMRj96PEAN7IuHI2CaWKfqhNGivaI6-YwHGgzWETVg>
 <xmx:48ABauCkYedtOE-6qsE8_Sxh_2W9d3EICVN3vzYfWCnnBcm7B1IMQtZZ>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id B9015C4006E; Mon, 11 May 2026 07:43:31 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Mon, 11 May 2026 13:43:11 +0200
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "devel@edk2.groups.io" <devel@edk2.groups.io>, tdave@nvidia.com,
 qemu-devel@nongnu.org
Cc: alwilliamson@nvidia.com, jgg@nvidia.com, skolothumtho@nvidia.com,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, mst@redhat.com,
 marcel.apfelbaum@gmail.com
Message-Id: <22cf37c2-b2b1-40db-b8b7-393b6c36a921@app.fastmail.com>
In-Reply-To: <20260508183717.193630-1-tdave@nvidia.com>
References: <20260508183717.193630-1-tdave@nvidia.com>
Subject: Re: [edk2-devel] [RFC PATCH 0/8] hw/arm/virt,
 hw/pci: PCI pre-enumeration and fixed BAR allocation
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=ardb@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello Tushar,

On Fri, 8 May 2026, at 20:37, Tushar Dave via groups.io wrote:
> This RFC introduces a mechanism to specify Guest Physical Addresses
> (GPAs) for PCI BARs, allowing explicit placement of guest MMIO BAR
> addresses to match host physical addresses for assigned devices.
>
> On some platforms, P2P DMA is performed between devices within the same
> IOMMU group. The PCI fabric ACS is configured to permit direct P2P
> without going through the host bridge in order to achieve the required
> performance.
>
> To support this multi-device IOMMU group P2P scenario in virtualization,
> the VM may need to use the same MMIO BAR addresses as the host physical
> address layout.
>

Did you consider implementing this using Enhanced Allocation (EA)? If so,
could you explain why it is not suitable here?

Also, I think I understand what the intent is here, but could you describe
the topology in a bit more detail? These are assigned physical PCIe endpoints
behind an emulated host bridge, right? And the BAR needs to reside at an
a priori fixed address so that another PCIe endpoint behind the same emulated
host bridge can DMA straight into it?

Doing PCIe enumeration at yet another level is not a feasible approach imo,
having UEFI and Linux play nice together is already a bit of a challenge.

Is there any way this could be handled by having special rules for inbound
translation in the host bridge driver/implementation?



