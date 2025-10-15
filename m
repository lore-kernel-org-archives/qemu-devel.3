Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC029CCD18E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 14:35:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v92aa-0006SP-JB; Wed, 15 Oct 2025 10:34:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1v92aO-0006QJ-15
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 10:34:43 -0400
Received: from fhigh-a2-smtp.messagingengine.com ([103.168.172.153])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1v92aI-0005Ag-J8
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 10:34:39 -0400
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.phl.internal (Postfix) with ESMTP id AA1A814001C2;
 Wed, 15 Oct 2025 10:34:28 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Wed, 15 Oct 2025 10:34:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm1;
 t=1760538868; x=1760625268; bh=FGvl5cpkCEBcFgwW7RfJrsv6SujYUKtm
 pj3H63Jsbng=; b=EMH3jSgf6cicPglp2UmwmbY2I/HuhJ4wUKUJeR/QLOOcWH4z
 vY2iJx1esJANWp5w3ea5IAwcgVpRZAeJ/7OwMoozGEU44N16C5bhyY0Krn3lrfTs
 W6CBc1gLSQXYMKF9w8HLFT2IPlxjwbEGZgXD/szKK+0hNqfOAO/q+6BTu0U7JjGF
 Qft24vDUVjIgGdUidvo9z3QYnHCQMgME6CYu7cpdRf6OsYEqBr6L0O8hFjsA0Pe0
 RSK42rCsgmCYgLkerAKwaGZpC13OlGlF3+AqaereiFLv5Ara/LOTCkJkoDjw6msL
 9QKQcO8cdwyQAicjzZfUCrMuxXb9JIGGbnMklA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760538868; x=
 1760625268; bh=FGvl5cpkCEBcFgwW7RfJrsv6SujYUKtmpj3H63Jsbng=; b=C
 npKWl62q7i28oTVeoc6d7nmdUhAWzONOOklYnMk5hITxhwKHOX08dDPDgadgKM9u
 OTecwqiHsh8MsLq/g0wN+hnpNwdWJak3RhjJwJxIbZaYsvf+ZVVRTjFd8YKWHNS6
 mAYD528m833aeI2v6ioc3joxJzbct0U+10u6K8spmR7+8DW0GM/0AI8sk+wiZybp
 7q+msw6VZPzO1lCzAUNHXaKlHugZqOAe9eh+vlSdJVuVXWU9lG5gkxzSEy9lWmf4
 0ZFmPWAKagXmGX+/bGPIw3yB9gj7zDFk3KX7ygsNyTDlWwQIFaBNSaYAIFQp5WLT
 hj+wAhqqfEjbp1NyB/QFg==
X-ME-Sender: <xms:9LDvaA69aZ5FIrnRh3RQrg3vrnRi6znaXiClSC5ckvkXanU9GgpmIQ>
 <xme:9LDvaIz59Pq94VHC0tP_kudaKwoABLGgo-sfEdsWRPrfKbTbm4N0OUBbWuZ6Dasy9
 NvWdFukQBWNxCaq93w-ytFSp3PpjGXsU7o9TilapQUP1kDr1hceLg>
X-ME-Received: <xmr:9LDvaHybpAoc5_zfNEGvUDwa-g8sN9IMgF1NlY67HkMG66eruJbTriKfaeHd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdefieeiucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdljedtmdenucfjughrpegggfgtfffkvefuhffvofhfjgesthhqredtredt
 jeenucfhrhhomhepfdevhhgrugculfgrsghlohhnshhkihdfuceotghhrggusehjrggslh
 honhhskhhirdighiiiqeenucggtffrrghtthgvrhhnpefhfeduffekffehudffteelvdek
 tedvjeehtdehkeethfehvdeghfehtefhffekgeenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpegthhgrugesjhgrsghlohhnshhkihdrgiihiidp
 nhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsggrlh
 grthhonhesvghikhdrsghmvgdrhhhupdhrtghpthhtoheptghhrggusehjrggslhhonhhs
 khhirdighiiipdhrtghpthhtohepkhhrrgigvghlsehrvgguhhgrthdrtghomhdprhgtph
 htthhopehmrghrtggrnhgurhgvrdhluhhrvggruhesrhgvughhrghtrdgtohhmpdhrtghp
 thhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
X-ME-Proxy: <xmx:9LDvaAzGuM_s2bykTFfKsnhdlL-gV8FLmlgfdp_zj-PcZLdHqkfIyg>
 <xmx:9LDvaBbYwKOnmqVM0wAoIdrVOxspFrTiGBKyITJso5zbp8TAEraCTw>
 <xmx:9LDvaBUfhEfo-YgS4KflPkhA0DBzcpTf0Ev4sVIN7ONgK08p8Jm-BQ>
 <xmx:9LDvaPhhw1p1AoEise2RXEHfOh5LJ0ukC5NsHxibB3u3_1rsV9S5fA>
 <xmx:9LDvaCMubgVUoXETNdR6xQ-CLdyuuw75Z-abJVtxv_ly-JZEffUMaIw0>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Oct 2025 10:34:27 -0400 (EDT)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 93995993;
 Wed, 15 Oct 2025 14:34:25 +0000 (UTC)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Oct 2025 10:34:25 -0400
Message-Id: <DDIYXXF8C8O3.BGW7D8I6VZTW@jablonski.xyz>
Cc: <qemu-devel@nongnu.org>, "Gerd Hoffmann" <kraxel@redhat.com>,
 <marcandre.lureau@redhat.com>
Subject: Re: [PATCH] ati-vga: Fix framebuffer mapping by using
 hardware-correct aperture sizes
From: "Chad Jablonski" <chad@jablonski.xyz>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, "Chad Jablonski"
 <chad@jablonski.xyz>
X-Mailer: aerc 0.21.0
References: <20251001034616.3017119-1-chad@jablonski.xyz>
 <8ca9a290-39be-7d52-2add-f37a30e05545@eik.bme.hu>
 <DDHA2TJZB67L.8WL7I58CQAZ6@jablonski.xyz>
 <31fa1128-e693-494d-2515-467866d1598b@eik.bme.hu>
 <DDHGPB02664A.3C0GAHH5K41QT@jablonski.xyz>
 <fee6d690-8302-d3bb-fdec-52e59662f97a@eik.bme.hu>
In-Reply-To: <fee6d690-8302-d3bb-fdec-52e59662f97a@eik.bme.hu>
Received-SPF: pass client-ip=103.168.172.153; envelope-from=chad@jablonski.xyz;
 helo=fhigh-a2-smtp.messagingengine.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.498, PDS_OTHER_BAD_TLD=1.997, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

>
> Question is if Radeon has BAR0 matching VRAM size because in that case if=
=20
> Rage128 has fixed 64MB and Radeon has size of VRAM for BAR0 then=20
> CONFIG_APER_SIZE can be half of BAR0 which would work for both. But if=20
> Radeon also has a fixed size BAR0 larger than actual VRAM (mathching max=
=20
> supported VRAM instead then current calculation is needed using VRAM size=
=20
> for radeon according to the FCode ROM I've tested. Changing=20
> CONFIG_APER_SIZE only for Rage128 should not break anything as I did not=
=20
> see anything using that so that would also work if we can't find out what=
=20
> Radeon has.
>

Card                          VRAM    PCI BAR0   CONFIG_MEMSIZE  CONFIG_APE=
R_SIZE  AGP_APER_OFFSET
-----------------------       ----    --------   --------------  ----------=
------  ---------------
Rage 128 Pro Ultra TF         32MB     64MB       0x02000000      0x0200000=
0        0x02000000
Rage 128 RF/SG AGP            16MB     64MB       0x01000000      0x0200000=
0        0x02000000
Radeon R100 QD [Radeon 7200]  64MB    128MB       0x04000000      0x0400000=
0        N/A

Looking at the linux source it appears the R100 doesn't have an
AGP_APER_OFFSET register. The register at that offset according to the
linux driver is something else entirely. This suggests that
the R100 doesn't map AGP memory space into BAR0 in the way that the
Rage 128 does. It makes sense that the R128's BAR0 would be twice the
max memory for the architecture given that it also has to do this AGP
mapping. But if the R100 _doesn't_ then it wouldn't need to make room
for AGP and it may just be that the BAR0 is the size of the max memory.
I don't have documentation for the R100 though so it's tough to know for su=
re.

But to answer your question about the BAR0 matching VRAM on the R100.
At least for this card it does not. The VRAM is half of the BAR0. I have a
32MB Radeon arriving soon so I'll be able to test that to see if it also
follows that pattern or if BAR0 is still 128MB. From what I'm seeing there
may have been some 128MB R100's, it's not entirely clear to me. So it's
possible that the 128MB is the max VRAM.

