Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16625CCD183
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 14:54:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8Juy-000811-5S; Mon, 13 Oct 2025 10:52:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1v8Juw-00080n-6d
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 10:52:54 -0400
Received: from fhigh-b2-smtp.messagingengine.com ([202.12.124.153])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1v8Jus-0000MO-Vb
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 10:52:53 -0400
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 856A97A03E7;
 Mon, 13 Oct 2025 10:52:44 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-12.internal (MEProxy); Mon, 13 Oct 2025 10:52:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm1;
 t=1760367164; x=1760453564; bh=KmDGbL9RHjHDbEn7ZPMO3YSkYbv8AvmX
 Dor7lfk8XNI=; b=AbS2peWGH5WmQ/DOaV3Xds/Iw+ZLIQmF2oMlOtJVeQER2Hx4
 weTVmjqulb/p4716AmwVCgfu4AKeMDGWTkyZj7Vxu1J+Q3SYva3JmbeD0EqQxefG
 vIIkD8wrBaAM9Alnc4AOKWfg96n4y+mXg+9vIg31m9pMGhocDI0nz83/fwaPwGym
 MYCfky5WmPJUR/aOEpZjPvL5BBHEd15lR2j+BEPFiVQE5rrHogSk3vUsXKZnluh3
 EEKxyDAtpx9GIVvxZXnAkEiqjU1lunYOH4l6+XB7ovE0CdFbDKo0CXOz+NjC6KrB
 rLBR/+1Pcfb4g/w4/BjxM+C8SEpoGnPAUQNFIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760367164; x=
 1760453564; bh=KmDGbL9RHjHDbEn7ZPMO3YSkYbv8AvmXDor7lfk8XNI=; b=t
 UHcgrn8rh1xvlvtmICbDwQJVK34ggz+1+eRw/YTcEHiW3pi5bDN9wsHTJsQRNzmI
 HMSu4vq6Bwo/CR2IrncfiPEavc7/kQ4R2oZW+nL8v8uCumoYpYpRW+kro+QgT3kE
 tCYJPl2nYA1qclvGqgjnFpnwVccKvyyoNWLAiCjA/hyvux2oQK4CKTRXqudbEh7n
 hDAPCfI4o3G+GO/XMP6LExzpWxqNj/w2r+pDMeFWcoxusS1MATOHw2XYduuQvr+o
 k19HVFizmvSsykQZ5tkdhq3GrezzpgdOjPS1XDNMopJtMBx5koQ9gOvMtuHWLqJf
 xx0j8VGL15kSlvly8fWHQ==
X-ME-Sender: <xms:OxLtaGXPaCItqSI268u7UbfKdhCPDngdwnWXRUNnMstXL83lsl4A9w>
 <xme:OxLtaJfyPbPCzzTnF5nAHKlkUW_oT9Iq_ZuZzBF4pBBIgt0GM1WBvlkNI8aS1Qajj
 KRjRA4pV51Sb6wqhQ2mrF6qJNKNoLG23vaupnf0N8LLFL-lYfptWKY>
X-ME-Received: <xmr:OxLtaCuHmjEX0HDg_IdKIpbjdr7T2OSwxHSCkXK1C-mZOVz0bDtyD9tcqwkO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudejleegucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdlfeehmdenucfjughrpegggfgtfffkvfevuffhofhfjgesthhqredtredt
 jeenucfhrhhomhepfdevhhgrugculfgrsghlohhnshhkihdfuceotghhrggusehjrggslh
 honhhskhhirdighiiiqeenucggtffrrghtthgvrhhnpefhfffhleekhfevtdekffejtefg
 hfffhfettdefkeekvdejieevleehjeeggeejteenucffohhmrghinhepfhhrvggvuggvsh
 hkthhophdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
 fhhrohhmpegthhgrugesjhgrsghlohhnshhkihdrgiihiidpnhgspghrtghpthhtohephe
 dpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsggrlhgrthhonhesvghikhdrsghm
 vgdrhhhupdhrtghpthhtohepmhgrrhgtrghnughrvgdrlhhurhgvrghusehrvgguhhgrth
 drtghomhdprhgtphhtthhopegthhgrugesjhgrsghlohhnshhkihdrgiihiidprhgtphht
 thhopehkrhgrgigvlhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepqhgvmhhuqdguvg
 hvvghlsehnohhnghhnuhdrohhrgh
X-ME-Proxy: <xmx:OxLtaI9ZgV8eNd9wG9QbkJQVX6nDXHQReKPjlZgJ2VkDvbTqNWHa_g>
 <xmx:OxLtaN1Yc6edZCti6F1iKuaOf5QjMNIMOddATmL7lP-hKrM4kEym_g>
 <xmx:OxLtaNC9q4N7suO40FUZ6qx0Hzc2IqILo76uUU-IyLsm7K9D6kEYJA>
 <xmx:OxLtaJf5oQ7DQKIHj2B69dNTnhdEfVo2ulCB65-HRPedrNvEqRehPA>
 <xmx:PBLtaB5L_WFummvC2w8fPt-o3TYb5qpJIl4h962E_2bXVJXEuc8geNYn>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Oct 2025 10:52:43 -0400 (EDT)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 9877a157;
 Mon, 13 Oct 2025 14:52:41 +0000 (UTC)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 13 Oct 2025 10:52:41 -0400
Message-Id: <DDHA2TJZB67L.8WL7I58CQAZ6@jablonski.xyz>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, "Chad Jablonski"
 <chad@jablonski.xyz>
Cc: <qemu-devel@nongnu.org>, "Gerd Hoffmann" <kraxel@redhat.com>,
 <marcandre.lureau@redhat.com>
Subject: Re: [PATCH] ati-vga: Fix framebuffer mapping by using
 hardware-correct aperture sizes
From: "Chad Jablonski" <chad@jablonski.xyz>
X-Mailer: aerc 0.21.0
References: <20251001034616.3017119-1-chad@jablonski.xyz>
 <8ca9a290-39be-7d52-2add-f37a30e05545@eik.bme.hu>
In-Reply-To: <8ca9a290-39be-7d52-2add-f37a30e05545@eik.bme.hu>
Received-SPF: pass client-ip=202.12.124.153; envelope-from=chad@jablonski.xyz;
 helo=fhigh-b2-smtp.messagingengine.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.499, PDS_OTHER_BAD_TLD=2, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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

Hi Balaton,

Thanks for taking a look! I'll address all of these and send a v2.

> The documentation does not mention 64MB alignment. It says apertures must=
=20
> be on a 32MB boundary and src and dst offsets are 128 bit aligned but=20
> maybe I don't have the right documentation for these chips or don't get=
=20
> what it means.
>

Agreed, yeah the register docs do say there is a max of 32MB of framebuffer
memory and a max of 32MB of AGP memory (register reference pg. 2-6)
which implies 32MB alignment. And the software guide does explicitly say
that apertures must be located on a 32MB boundary (software guide 2-19).
It then goes on to describe how the aperture is split into 32MB for frame
buffer space and 32MB for AGP/PCI space. Which implies that 64MB is needed
for the full aperture. And from what I understand requesting 64MB will
naturally lead to a 64MB alignment from PCI.

Outside of what I observed on the real hardware another thing that lead me
to believe that the 64MB alignment is correct was this line in the XOrg
r128 driver: https://gitlab.freedesktop.org/xorg/driver/xf86-video-r128/-/b=
lob/XORG-RELEASE-1/src/r128_driver.c#L855
The driver is assuming a 64MB alignment by masking addresses with
0xfc000000 (2^26 =3D 64MB). When qemu requests 16MB or 32MB it breaks that =
assumption
and the driver looks in the wrong memory area for the framebuffer.

>
> Can you check what the CONFIG_APER_SIZE register contains on these cards?=
=20
> Do all Rage 128 (and Pro) cards have 64MB and Radeon 7xxx/M6 have 128MB?=
=20
> The documentation is again not clear on this because it lists default=20
> value of 0x2000000 for CONFIG_APER_SIZE on Rage 128 Pro and nothing for=
=20
> Radeon but in a figure it shows this should contain both VRAM and AGP=20
> areas that suggests 64MB but it's possible that the documentation is=20
> wrong.
>

I will take a look at this!

>
> This was changed in commit f7ecde051dd73 to be half the memory size=20
> because at least a Radeon FCocde ROM seemed to detect VRAM size that way.=
=20
> I should test that again but it needed OpenBIOS patches that were not=20
> merged so I had to find those again as I don't have that setup any more.=
=20
> Checking on real card may be the best source of what this should be but I=
=20
> think this might break that FCode ROM which is from a PowerMac card. This=
=20
> suggests it should be half the aper size.
>

Ah, great, this is important context. I'll look at this more
closely and check the real hardware.

>
> Coding style says variables should be defined at the beginning of blocks=
=20
> so in this case at the beginning of the funcion.
>

I'll also address all of the style comments.

Thanks again,
Chad

