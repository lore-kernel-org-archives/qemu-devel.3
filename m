Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26E57D1CDAA
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 23:31:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQwIY-0005Kg-6V; Wed, 03 Dec 2025 18:30:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>) id 1vQwIR-0005K5-0n
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 18:30:08 -0500
Received: from fhigh-b5-smtp.messagingengine.com ([202.12.124.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>) id 1vQwIO-0004y6-Ax
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 18:30:06 -0500
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 59BC67A0259;
 Wed,  3 Dec 2025 18:30:00 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-07.internal (MEProxy); Wed, 03 Dec 2025 18:30:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1764804600;
 x=1764891000; bh=wowr+y+4fyLBSj7rd+z8uDMsrzsoD2cIbJd6v7RdGTc=; b=
 hDK7UC3mFoWhaHCqB/cC+gXjrm0QDoyfXkXj46JKuhgjsolx7dZqI1beHS2V2vDI
 aZseWrzTAOeLFH3MSbt89xWkYCrzTLDeYz+8uOUKH0CUeK33baYMS9oV+GrByoue
 IYghOpuf6Cz+064d3N9KtAj6fcgMA78pGZJCIzgTWZZihxoZ6nSkuWCFhlCSEzoj
 cYjfVw8WJQJesSOXkVlMfb5sdnXjcYwuweO+pssalu20z/Djksa7OJhicsw45coc
 22Wg9a8g1IZnMfCnXn7Ra23Fvh5M7nLkGreatgR1O0icSB2mEzRRUiQZHa+KbJU9
 VyFmEWJaXrnNRMf6HQ/XtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764804600; x=
 1764891000; bh=wowr+y+4fyLBSj7rd+z8uDMsrzsoD2cIbJd6v7RdGTc=; b=I
 JAcGLtfrG54gFi/LUh6oBBKi0bA3DsSBzKwickgxLkHinNNJoBcpqudYzESLmsiT
 KjgkEfR4+ihDoDQsvr+1HpaPUpy4iTBZtqpPS+AMp/clTEGX9G5U8Kqv24a3O6Yh
 AaIupq9MOZcarXhHi9qef44vLSxpqn91irjvT4iIc1/eQxlAqCdboLuoAXpEw3pK
 bVMgJCHXGbwA+gXQqToM0SGW/iTXmCeBLNNxUr7WmGT/Q1XOdmBrwqfC3EyT44Td
 m6esUDTEPkTHGqenFFbCiZoFyy+IwffPBKRcGYI6k28caqoGZMgr8Uf4FMOMSM6l
 T1lZkco6JtHCpOkdBeFOg==
X-ME-Sender: <xms:98cwacTzB74wl2zWISZmCdV7raTFZSfIEAJa-14o34JVLSd9v0osWg>
 <xme:98cwaVzgzJ-vyNr6vbBxjcN2F1O0sun5N1GwQxGJl3IY0-CnE7CFK_FASFboWs1bq
 F0E9xh7I-E4pM0O-29JcfqmKK-rWfXD0ugVQP-1FVhkctJeYGUd>
X-ME-Received: <xmr:98cwacB_YTvHB-XK2i7JhX8vxLvoDxnQZS9jjOkzIQEsI49-7F2GRHLE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegtdegucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
 lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
 epfffhvfevuffkjghfgggtgfesthejredttddtvdenucfhrhhomheptehlvgigucghihhl
 lhhirghmshhonhcuoegrlhgvgiesshhhrgiisghothdrohhrgheqnecuggftrfgrthhtvg
 hrnhepteetudelgeekieegudegleeuvdffgeehleeivddtfeektdekkeehffehudethffh
 necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlvg
 igsehshhgriigsohhtrdhorhhgpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhp
 ohhuthdprhgtphhtthhopehssggrthgvshesrhgrihhthhhlihhnrdgtohhmpdhrtghpth
 htohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopehmshht
 sehrvgguhhgrthdrtghomhdprhgtphhtthhopehmrghrtggvlhdrrghpfhgvlhgsrghumh
 esghhmrghilhdrtghomhdprhgtphhtthhopehfrghrohhsrghssehsuhhsvgdruggvpdhr
 tghpthhtoheplhhvihhvihgvrhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepphgsoh
 hniihinhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehshhgrihesshhhrghirdhp
 uhgspdhrtghpthhtohepkhdrjhgvnhhsvghnsehsrghmshhunhhgrdgtohhm
X-ME-Proxy: <xmx:98cwaRHF_ViyrMsL-XKY8ucLI1ByKd4FFFH3MQ81yX9LevmiuNP8jg>
 <xmx:98cwaTMD5NNi9WbiRj31czO7FiKBIiqxuhk5tB7oMdAXlCr7_kqXMg>
 <xmx:98cwaS7khU0oKS-20RlIyTGOD-7VREkPwnG9uUXxzafp8ZW2W4ni0g>
 <xmx:98cwaWir6wzG5EgaP1o3iC9CeJmm-iZmw7JjgS8Ovg_yK-EtR6ES8A>
 <xmx:-McwaRFNweMCYWHfJl5MvMaqtJccvbcyuix5ciuZyG-i6o1rQCMTDRgD>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Dec 2025 18:29:58 -0500 (EST)
Date: Wed, 3 Dec 2025 16:29:56 -0700
From: Alex Williamson <alex@shazbot.org>
To: Stephen Bates <sbates@raithlin.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, marcel.apfelbaum@gmail.com,
 farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com, shai@shai.pub,
 k.jensen@samsung.com
Subject: Re: [PATCH v1] hw/pci: Add PCI MMIO Bridge for device-to-device MMIO
Message-ID: <20251203162956.52d07f7b.alex@shazbot.org>
In-Reply-To: <aTCpGWb7V8R2HVl8@snoc-thinkstation>
References: <aTCpGWb7V8R2HVl8@snoc-thinkstation>
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

On Wed, 3 Dec 2025 14:18:17 -0700
Stephen Bates <sbates@raithlin.com> wrote:

> This patch introduces a PCI MMIO Bridge device that enables PCI devices
> to perform MMIO operations on other PCI devices via command packets. This
> provides software-defined PCIe peer-to-peer (P2P) communication without
> requiring specific hardware topology.

Who is supposed to use this and why wouldn't they just use bounce
buffering through a guest kernel driver?  Is rudimentary data movement
something we really want/need to push to the VMM?  The device seems
inherently insecure.

> Configuration:
>   qemu-system-x86_64 -machine q35 \
>       -device pci-mmio-bridge,shadow-gpa=0x80000000,shadow-size=4096
> 
> - shadow-gpa: Guest physical address (default: 0x80000000, 0=auto)
> - shadow-size: Buffer size in bytes (default: 4096, min: 4096)
> - poll-interval-ns: Polling interval (default: 1000000 = 1ms)
> - enabled: Enable/disable bridge (default: true)

Wouldn't it make more sense if the buffer were allocated by the guest
driver and programmed at runtime?  Polling just adds yet more
questionable VMM overhead, why not ioeventfds?

> The bridge exposes shadow buffer information via a vendor-specific PCI config
> space:
> 
>   Offset 0x40: GPA bits [31:0]
>   Offset 0x44: GPA bits [63:32]
>   Offset 0x48: Buffer size
>   Offset 0x4C: Queue depth

Arbitrary registers like this should be exposed via BARs or at least in
a vendor specific capability within config space.

...
> +
> +VFIO can only map guest RAM not emulated PCI MMIO space. And, at the present

only guest RAM: False, not emulated PCI MMIO: True

> +time, VFIO cannot map MMIO space into an IOVA mapping. Therefore the PCI MMIO

Other assigned device MMIO, it absolutely can.  The legacy type1 support
has always had this and IOMMUFD based vfio is about to gain this via
dma-buf sharing as well.  Thanks,

Alex

