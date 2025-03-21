Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E9F4C36000
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 12:43:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvbiG-000857-Da; Fri, 21 Mar 2025 08:43:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aik@ozlabs.ru>)
 id 1tvV9l-0004vC-2r; Fri, 21 Mar 2025 01:42:57 -0400
Received: from fout-b1-smtp.messagingengine.com ([202.12.124.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aik@ozlabs.ru>)
 id 1tvV9i-0003LM-IH; Fri, 21 Mar 2025 01:42:56 -0400
Received: from phl-compute-13.internal (phl-compute-13.phl.internal
 [10.202.2.53])
 by mailfout.stl.internal (Postfix) with ESMTP id 22D4D11401A8;
 Fri, 21 Mar 2025 01:42:49 -0400 (EDT)
Received: from phl-imap-13 ([10.202.2.103])
 by phl-compute-13.internal (MEProxy); Fri, 21 Mar 2025 01:42:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.ru; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1742535768;
 x=1742622168; bh=rWqBSUjJtMAZyEKPI64Qtxx17ankYzsGjvFxn3DLFvw=; b=
 uZ05dBGgreIOOIFRw0b7s2MY5VJR7z21UIZuc0MmfMBjfWAvQtp1zkR1uBemWKRO
 aVeWCliMUBmBVbDoCYPNkD+Zg4QiiGtvhKVyalt/1Qep02gelrQTWVbI0bPlFNZ4
 Wq2EptWzp0hNSunzeUiSip+d1+pw0LrkmIx8Tl46KSjZ9CxVIANTVdlRaTBFu3lU
 GQxJNSAPYhmb5EIW5dVTR4pZ5VFRfKv8olWUV6WRuRyzP/AaG2ysBB/koen597e7
 sqVT8KnrSSXSmjOZ8FOmVLQqbITYKmNMD5GCVf2y7cNDo3p3TyuP6+lqu8vUHqbg
 nbJMY44n1/DvJzaIhaM6GA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742535768; x=
 1742622168; bh=rWqBSUjJtMAZyEKPI64Qtxx17ankYzsGjvFxn3DLFvw=; b=g
 mOtgJR0Fp+tClWgNHjVQ7ytYjUHAm4ZZpwigSTQLOCV71OuG56DqYSYBBPn/ZooE
 T115lf5e67hUfjCHLfJMV9hsSx7LPar1FprnX0kXdYNPUKwBYjmN1lrxpAZqZVq+
 /anjiGQ3qBVbH3uIj9rRdrpoAPnCn6lln4e1PWIji4mJb3Tlis5hNUoznp1pOHBf
 3Gwzt7Sc/jM7mAoTSuK9CE8m4WvYBa3lkgzC4paNBok7ib649gYptVf9N+GMhpjY
 4ryCUGTf/KcgmT8T8VPARz9+iDTa3X8SGiL4R6UMdrWOwiK99THzZqaCmCN9MHdp
 Br4QS2TnLuHXPPLUXz9UA==
X-ME-Sender: <xms:VvzcZ6w7nkwP-V88qpniMjm9zzStMXhzguCVuewJNe1j5Otdm5W8Mg>
 <xme:VvzcZ2QMgjsf0KIWrJV_X5Gu0YGchSGIo0nztV7GNWZBEwNRGN3nBpVuXzRiv-E4V
 e56-i2Uo9F7lqxXY54>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduhedtvdekucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
 gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
 tddtnecuhfhrohhmpedftehlvgigvgihucfmrghruggrshhhvghvshhkihihfdcuoegrih
 hksehoiihlrggsshdrrhhuqeenucggtffrrghtthgvrhhnpeehveelteevieehfeejkeeg
 udetlefgvdffveelgffhjeeigfetgeegtdetheejvdenucffohhmrghinheprhgrphhtoh
 hrtghsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
 rhhomheprghikhesohiilhgrsghsrdhruhdpnhgspghrtghpthhtohepgedpmhhouggvpe
 hsmhhtphhouhhtpdhrtghpthhtohepsggrlhgrthhonhesvghikhdrsghmvgdrhhhupdhr
 tghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhope
 hqvghmuhdqphhptgesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepmhhjthesthhlshdr
 mhhskhdrrhhu
X-ME-Proxy: <xmx:VvzcZ8V2EUl3u6Xf72rgsFxpu3LRxSWy8AkmCEQN2Q49n7UFaWMsFw>
 <xmx:VvzcZwj8o2X0iaJ3ckRR4c3kU8QsOZrUU21RNiaZ7B_V9YSqokY7GQ>
 <xmx:VvzcZ8BD5R7eqXH6mSWxWn1A9t_i0nOmxZNsVsTFenfmvQPQhL-JHg>
 <xmx:VvzcZxL1YpgaWjXL_LTA6Wi1QKSRvp_8bXTVwdskl2i4P2TDC-9ENA>
 <xmx:WPzcZ74ugYwhOhpcwI3z36GFTnyubCuoDtfH-ityXe8-Xtes1j5lI7ap>
Feedback-ID: i6e394913:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 360A41F00072; Fri, 21 Mar 2025 01:42:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: T87c25bd1b5a51359
Date: Fri, 21 Mar 2025 16:42:24 +1100
From: "Alexey Kardashevskiy" <aik@ozlabs.ru>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, "Michael Tokarev" <mjt@tls.msk.ru>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-PowerPC <qemu-ppc@nongnu.org>
Message-Id: <60d4416c-6a56-462f-8b98-1ff8800c0e5f@app.fastmail.com>
In-Reply-To: <6f29bd39-5855-c2c4-80b3-0873c7387897@eik.bme.hu>
References: <2176cec3-8957-425f-8b50-e48b1f6ff4dc@tls.msk.ru>
 <6f29bd39-5855-c2c4-80b3-0873c7387897@eik.bme.hu>
Subject: Re: vof-nvram.bin: what it is and how it is used?
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=202.12.124.144; envelope-from=aik@ozlabs.ru;
 helo=fout-b1-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 21 Mar 2025 08:42:53 -0400
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



On Thu, 20 Mar 2025, at 00:14, BALATON Zoltan wrote:
> On Wed, 19 Mar 2025, Michael Tokarev wrote:
> > Hi!
> >
> > Commit fc8c745d50150a63f6c "spapr: Implement Open Firmware client interface"
> > in Jun-2021 added a new file, pc-bios/vof-nvram.bin, to qemu sources.
> >
> > But there's nothing in the sources which refers to this file, and there's
> > no mentions about its contents and how it has been generated.
> >
> > What's the procedure to create this image?  It would be great if such
> > procedure can be run during package build time to generate this image anew.
> >
> > How it is supposed to be used?
> 
> See hw/ppc/spapr.c::spapr_create_nvram(). Looks like it would add a drive 
> give with -drive if=pflash,index=0 as the nvram backing file. I don't know 
> if it generates the default if an empty file is passed or maybe SLOF would 
> do that which then could be used for VOF too and that's how it was made? 
> So you could try running -machine spapr with an empty nvram with slof then 
> compare that to the default for VOF.

I booted with SLOF and -drive if=pflash,index=0 and let SLOF initialize it, and then use the result with VOF.

> > Should it be shipped in a downstream distribution?
> 
> If is't not auto-created with the default values and not easy to create 
> then maybe more convenient for users to get an example.

At the time I wanted to keep hw/ppc/spapr_vof.c and pc-bios/vof.bin as small as possible so avoided formatting. And a VM would still work even without this pc-bios/vof-nvram.bin (but it would annoyingly complain), hence the image. 

http://wiki.raptorcs.com/w/images/c/c5/LoPAPR_DRAFT_v11_24March2016_cmt1.pdf  chapter 8 "Non-Volatile Memory" has the format if anyone feels bored :)

Thanks,


> 
> Regards,
> BALATON Zoltan
> 

