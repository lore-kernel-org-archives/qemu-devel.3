Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B70ACD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 23:59:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMx0G-0004kY-Ag; Tue, 12 May 2026 19:59:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>)
 id 1wMx0E-0004kJ-Ct; Tue, 12 May 2026 19:59:06 -0400
Received: from fhigh-a8-smtp.messagingengine.com ([103.168.172.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>)
 id 1wMx0C-0005N1-Gp; Tue, 12 May 2026 19:59:06 -0400
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 6D5241400228;
 Tue, 12 May 2026 19:59:01 -0400 (EDT)
Received: from phl-imap-18 ([10.202.2.89])
 by phl-compute-02.internal (MEProxy); Tue, 12 May 2026 19:59:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1778630341;
 x=1778716741; bh=dnYLEEi++0I2t0mw8re1OWQHBOYwuuFAt8U1tMu0gGI=; b=
 U1vLvUV4p3/UhAZb0JvrA6Wd7dNGRKgCQMubuKxDpVc/4VvHMIZgfQRBxkmQ4Taq
 9uQNWfgBZhXjdXwFhN/Em2hBZ8X92kQSo9dppfe9dgQtUs1cHc8m3JqoTvkCJNw8
 txhMN2T6++CVJdwWQQttd6nebeqe4RAp3IQUP+Hszpy40rz1nfgXD5vjDSrEn2Wc
 lfPeL7N/76WEZFcBjvhmEpb6Qra/saDZ21KmklQ+yP4XIamJvqbEW6TKah0tTpgf
 XSvcOaY1C6z07TB9cxofJvpIkNYaPdrATwvK1jTfCtS1tbXd4MCYOoudm7csOQz0
 ulX1Dzrso7dIke/GnZMeAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778630341; x=
 1778716741; bh=dnYLEEi++0I2t0mw8re1OWQHBOYwuuFAt8U1tMu0gGI=; b=p
 tVJ0WVPPZh4IJM8NPvErupKJ+c4Yutq0Cj/05OW8RIb7jFghQaCZhQp6zmLYQauK
 ejgCgwAexni8h6KJolXJTN9q+gWW5g/7AG2SGqVW77BUluypLwD1hyzU/5lhR5Wz
 nvtAlHbO/hYxDfLJH3KJGyfYSwd3CFvWNqivwR8vIMhJfkYQo/iPldvevcbjwI1A
 fHFX9D00sy6k4CjZcAI98WM/qcnig+JiXxFpha2N+9ju26yliVrGPH8acIq4DsP/
 wOivQzfqrWNzySnOQqjKYfq6mmSbRF0kaUZkFRALU1WS3Ng+hOihwMJm1c3s6vWe
 GEnk1YGGZax2j10IOOs+A==
X-ME-Sender: <xms:xL4DanzEdfKbf-vV_hVWYyavnl8xlGIyyaWW3Ej_Cu9EpKNRDug1kw>
 <xme:xL4DaqHkipCTtFFlH3m7GQvOypC0l6i7_-m1azp1smUWDl-ZjqGUHA1OvMon1MGNL
 IIjxYNw32zc_WHZk2_omqhNqA8ZwO4k42FJZSCNiG9JHDhV-xiCdVc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdefudejucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehlvgig
 ucghihhllhhirghmshhonhdfuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtf
 frrghtthgvrhhnpefgfeeflefggfffveffteetiedvtedtgfdvieevfeejfeefffevteej
 tedufffgveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpegrlhgvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohepuddvpdhmohgu
 vgepshhmthhpohhuthdprhgtphhtthhopeguvghvvghlsegvughkvddrghhrohhuphhsrd
 hiohdprhgtphhtthhopehmrghrtggvlhdrrghpfhgvlhgsrghumhesghhmrghilhdrtgho
 mhdprhgtphhtthhopegrrhgusgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvth
 gvrhdrmhgrhiguvghllheslhhinhgrrhhordhorhhgpdhrtghpthhtohepqhgvmhhuqdgr
 rhhmsehnohhnghhnuhdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonh
 hgnhhurdhorhhgpdhrtghpthhtoheprghlvgigrdifihhllhhirghmshhonhesnhhvihgu
 ihgrrdgtohhmpdhrtghpthhtohepjhhgghesnhhvihguihgrrdgtohhmpdhrtghpthhtoh
 epshhkohhlohhthhhumhhthhhosehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:xL4DasVkhSO-P1r5tZm_MqpSxsbOC94_av62G6nxzohjw0qdp-L74w>
 <xmx:xL4DaiIjn-Y43XM_UBqavEwDEQR6_VZ2TRQRwrvli3XJnqzoDYrwIg>
 <xmx:xL4DavoXNVGCo_HBpmZcUruSu1KV_zTNGoya8z9FIZj4J3S4l1N_7Q>
 <xmx:xL4DahyjnFhmGCYWqhymsjYS7mbbE1qCnjgYv7JTM-u6x1oN1jo8lA>
 <xmx:xb4DagTxyDnYE-9ojlSj0S2rnYkX-_fJZCT-O_w9AW38nfTY6EZ6i0Iu>
Feedback-ID: i03f14258:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id C174415C008C; Tue, 12 May 2026 19:59:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Tue, 12 May 2026 17:57:19 -0600
From: "Alex Williamson" <alex@shazbot.org>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 "Alex Williamson" <alex.williamson@nvidia.com>
Cc: "Tushar Dave" <tdave@nvidia.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 "Ard Biesheuvel" <ardb@kernel.org>,
 "devel@edk2.groups.io" <devel@edk2.groups.io>, qemu-devel@nongnu.org,
 "Jason Gunthorpe" <jgg@nvidia.com>,
 "Shameer Kolothum" <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 "Peter Maydell" <peter.maydell@linaro.org>, marcel.apfelbaum@gmail.com
Message-Id: <382877be-edad-4eca-a646-a75e1654747f@app.fastmail.com>
In-Reply-To: <20260512191140-mutt-send-email-mst@kernel.org>
References: <20260508183717.193630-1-tdave@nvidia.com>
 <22cf37c2-b2b1-40db-b8b7-393b6c36a921@app.fastmail.com>
 <db604efd-9c1f-44e0-9921-71e4d97a81b3@nvidia.com>
 <20260512170650.4551c9f6@nvidia.com>
 <20260512191140-mutt-send-email-mst@kernel.org>
Subject: Re: [edk2-devel] [RFC PATCH 0/8] hw/arm/virt,
 hw/pci: PCI pre-enumeration and fixed BAR allocation
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=103.168.172.159; envelope-from=alex@shazbot.org;
 helo=fhigh-a8-smtp.messagingengine.com
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

On Tue, May 12, 2026, at 5:12 PM, Michael S. Tsirkin wrote:
> On Tue, May 12, 2026 at 05:06:50PM -0600, Alex Williamson wrote:
>> If we agree that homogeneous hierarchies (no mixing of EA and
>> programmable BARs) is a reasonable constraint, and possibly extend that
>> to homogeneous per host bridge to simplify the CRS mapping, we have the
>> following work items:
>> 
>>  * Extend Linux EA support to program bridge apertures for subordinate
>>    homogeneous EA hierarchies.
>> 
>>  * Develop options to virtualize programmable BARs as EA for vfio-pci
>>    devices, if not generically for the benefit of testing.
>> 
>>  * Implement a way to poke holes in the VM address space and plumb
>>    through to account for addresses used by EA devices.
>> 
>>  * Provide those same ranges to the guest via CRS (but not via DT to
>>    EDK2), or alternatively expose them through additional PXB host
>>    bridges.
>> 
>> Does that shape roughly seem accurate?  Are there additional gaps I've
>> missed?  Thanks,
>
> just one question why not do it in firmware so windows
> is thinkably also handled?

I suppose someone could chime in if they have a similar requirement for Windows guests.  Otherwise, the incremental effort to extend Linux EA support seems smaller, though I also don't know what, if any support Windows has for EA to bother.  Regardless, improving Linux EA support might help elsewhere and doesn't preclude edk2 support in the future.  Thanks,

Alex

