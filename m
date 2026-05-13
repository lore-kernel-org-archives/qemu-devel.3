Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F40E5CD4851
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 14:26:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNAX6-0003vm-Mn; Wed, 13 May 2026 10:25:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>) id 1wNAWx-0003v7-IO
 for qemu-devel@nongnu.org; Wed, 13 May 2026 10:25:49 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>) id 1wNAWv-0007MX-Bm
 for qemu-devel@nongnu.org; Wed, 13 May 2026 10:25:46 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id D8F51600CB;
 Wed, 13 May 2026 14:25:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55A25C2BCB3;
 Wed, 13 May 2026 14:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778682340;
 bh=OBmUeu+JTmeLVp+hLNb3VMMtuET3zSq0zHFW5yCb31s=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=nk8zLEQHAZM9nyc3wLM0N3fyLuBaFrE9V3pj0xou8HpnYodelXGhi2wtf8KVmIz/f
 90COB1euRofSnF21e3w3WhqL2UXpLelias8uySFtoNDHDG1D2DFqEhUlZ++4BnoD2g
 /U7XYnMO7PcFyLHqPU4UJGVgzCOJj8bDDPNUj1MGMIFymllrAqLZ27Z7RfLT5p2cZ9
 7nCVQCdBIQVaNvTMcujZugSzQk/dKyI1J0wvveHwFHSkaFboPRkvdHiVlXPvAI/oQ1
 2YzoKv323xcJpFFhaKEVD+Tk2d6PDtZ9jAqoRwTQYnu8wJXr6cVaNyqJegNb9b5gjY
 D7Sm1sn4VROoQ==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfauth.phl.internal (Postfix) with ESMTP id 6CB46F4006F;
 Wed, 13 May 2026 10:25:39 -0400 (EDT)
Received: from phl-imap-14 ([10.202.2.87])
 by phl-compute-01.internal (MEProxy); Wed, 13 May 2026 10:25:39 -0400
X-ME-Sender: <xms:44kEalm-PIZUu7p8nN-UqeJv3WCgq-Fd_5M2tw6VdgpV9hjpWhoONA>
 <xme:44kEarrVez7I8QyjC4MhIq4DSKsR4NJ6-rCHLOtmynkwE9bjG3eIwMaCZALWxa9S7
 OI66crjyKNaV7vb8cW5DNTkkd6eOVtofy9XgBP_SNSkdI0zV1Ra8Kc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdegkeelucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrugcu
 uehivghshhgvuhhvvghlfdcuoegrrhgusgeskhgvrhhnvghlrdhorhhgqeenucggtffrrg
 htthgvrhhnpedvueehiedtvedtleekuddutefgffdtleetfeetveejveejieehfefhjeei
 jeefudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 grrhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieejtdehtddtjeel
 qdeffedvudeigeduhedqrghruggspeepkhgvrhhnvghlrdhorhhgseifohhrkhhofhgrrh
 gurdgtohhmpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghp
 thhtohepuggvvhgvlhesvggukhdvrdhgrhhouhhpshdrihhopdhrtghpthhtohepmhgrrh
 gtvghlrdgrphhfvghlsggruhhmsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvthgv
 rhdrmhgrhiguvghllheslhhinhgrrhhordhorhhgpdhrtghpthhtohepqhgvmhhuqdgrrh
 hmsehnohhnghhnuhdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhg
 nhhurdhorhhgpdhrtghpthhtoheprghlvgigrdifihhllhhirghmshhonhesnhhvihguih
 grrdgtohhmpdhrtghpthhtohepjhhgghesnhhvihguihgrrdgtohhmpdhrtghpthhtohep
 shhkohhlohhthhhumhhthhhosehnvhhiughirgdrtghomhdprhgtphhtthhopehtuggrvh
 gvsehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:44kEahJdl5WEOtnUB5l9-C8TMfS-TuAA2OfyIS70R7yQkA-7OA56fg>
 <xmx:44kEausJV0qiminuFDuMcXhUW3-oH0v_i-etnh30Ov8UGYJAH2pG5A>
 <xmx:44kEao_xJg_roGVQP3ZnKAWh3Ent8xdOhusoPq5j-wAdmUrmVEftJQ>
 <xmx:44kEao0lbk0-UvSi44VKSI1Isp_k_dyqTfhR2YqPaZVO8bT5rBR1IA>
 <xmx:44kEati4N5tY8kHTtEJz4UUroqcfHtfdaLbWVmV_H-59M8foVq6KO_bv>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 4D81EC4006E; Wed, 13 May 2026 10:25:39 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Wed, 13 May 2026 16:25:10 +0200
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Alex Williamson" <alex@shazbot.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Alex Williamson" <alex.williamson@nvidia.com>
Cc: "Tushar Dave" <tdave@nvidia.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 "devel@edk2.groups.io" <devel@edk2.groups.io>, qemu-devel@nongnu.org,
 "Jason Gunthorpe" <jgg@nvidia.com>,
 "Shameer Kolothum" <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 "Peter Maydell" <peter.maydell@linaro.org>, marcel.apfelbaum@gmail.com
Message-Id: <bd3000d0-add9-4245-bc83-cb7f4886377b@app.fastmail.com>
In-Reply-To: <382877be-edad-4eca-a646-a75e1654747f@app.fastmail.com>
References: <20260508183717.193630-1-tdave@nvidia.com>
 <22cf37c2-b2b1-40db-b8b7-393b6c36a921@app.fastmail.com>
 <db604efd-9c1f-44e0-9921-71e4d97a81b3@nvidia.com>
 <20260512170650.4551c9f6@nvidia.com>
 <20260512191140-mutt-send-email-mst@kernel.org>
 <382877be-edad-4eca-a646-a75e1654747f@app.fastmail.com>
Subject: Re: [edk2-devel] [RFC PATCH 0/8] hw/arm/virt,
 hw/pci: PCI pre-enumeration and fixed BAR allocation
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=ardb@kernel.org; helo=tor.source.kernel.org
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


On Wed, 13 May 2026, at 01:57, Alex Williamson wrote:
> On Tue, May 12, 2026, at 5:12 PM, Michael S. Tsirkin wrote:
>> On Tue, May 12, 2026 at 05:06:50PM -0600, Alex Williamson wrote:
>>> If we agree that homogeneous hierarchies (no mixing of EA and
>>> programmable BARs) is a reasonable constraint, and possibly extend
>>> that to homogeneous per host bridge to simplify the CRS mapping, we
>>> have the following work items:
>>>
>>>  * Extend Linux EA support to program bridge apertures for
>>>    subordinate homogeneous EA hierarchies.
>>>
>>>  * Develop options to virtualize programmable BARs as EA for vfio-
>>>    pci devices, if not generically for the benefit of testing.
>>>
>>>  * Implement a way to poke holes in the VM address space and plumb
>>>    through to account for addresses used by EA devices.
>>>
>>>  * Provide those same ranges to the guest via CRS (but not via DT to
>>>    EDK2), or alternatively expose them through additional PXB host
>>>    bridges.
>>>
>>> Does that shape roughly seem accurate?  Are there additional gaps
>>> I've missed?  Thanks,
>>
>> just one question why not do it in firmware so windows is thinkably
>> also handled?
>
> I suppose someone could chime in if they have a similar requirement
> for Windows guests.  Otherwise, the incremental effort to extend Linux
> EA support seems smaller, though I also don't know what, if any
> support Windows has for EA to bother.  Regardless, improving Linux EA
> support might help elsewhere and doesn't preclude edk2 support in the
> future. Thanks,
>

If EA is too much of a hassle to implement, another avenue that you
might explore is EFI_INCOMPATIBLE_PCI_DEVICE_SUPPORT_PROTOCOL in edk2,
which can be implemented by the platform to inform the PCI core about
non-PCI compliant devices that have special requirements.

While it is supposed to support this use case too, the PCI resource
allocation code in EDK2 currently does not correctly support fixed
resources that are reported by this protocol, but getting that fixed
(and implementing the protocol in your firmware) might be a shorter
path to getting this hardware supported under any OS (assuming EFI
boot) than EA.

