Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A2D9CCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 13:57:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9kwv-0006fh-KQ; Fri, 17 Oct 2025 09:56:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1v9kwp-0006dW-FY
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:56:48 -0400
Received: from fhigh-b4-smtp.messagingengine.com ([202.12.124.155])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1v9kwh-0003aj-EC
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:56:46 -0400
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfhigh.stl.internal (Postfix) with ESMTP id D6CBA7A0140;
 Fri, 17 Oct 2025 09:56:34 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-10.internal (MEProxy); Fri, 17 Oct 2025 09:56:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm1;
 t=1760709394; x=1760795794; bh=PwnvCyxkNcmSv52XvEwqMw/l7CroBf0O
 45Ye4J5wIM0=; b=pjZXATlASf1LgpA0Soi9GrWAJq6MVY8sJnAtSNOx1axLKj9X
 2aJJklW9hZwJv36wSaLPmShYN8zXUqmatesIrryAF1W7u40mkH74YomvrwfCmqIr
 qzSaRZgiGm7Jq1gA0Aw2XVif8Q08eRhLvdxc5J/f5TTGRXzbcEdMme7A2t+5wO4T
 cDc4uZkfC/CGTKZUD7RyxbdXdfpZYpm8hY6QYjbZgqhG4qEvyOroi1sJ5Xyl48yi
 TxR/XrB5cHd5mo1i7LTe1ZZS0Mw+pWydKT/pirPBMuv9cxWjoviW3Iz2MHfxpeXb
 O53wlk6DHT0w0YUIbCITHI5CQdek7YnDza/nXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760709394; x=
 1760795794; bh=PwnvCyxkNcmSv52XvEwqMw/l7CroBf0O45Ye4J5wIM0=; b=U
 FSVdHuFDp+YM6WDcOHEgx7ewX96n54dAJtzkqz0RZRd5waPcUvIB8VxuxvwC2Q+U
 XJdZObAoI/2aRuPLTIfp1ezWLzlcXiEoqjXjMGzj1Ll+x3rCYEIcTnIrnOGD4jg/
 JUmmScUynTHSNTmE/e41iVEJvvVWKhj5LxAc+hC1Q1+6REKdLCS/oWJM3Vtz/zv4
 sEPSTcNYx9LEatfm++WLm394B18z2LePKKX3zF6hf1eh9/wpaTo8puE/NgvYFOpZ
 AN+ir2yglEySRr+hwiH1NSiF59GMJmT6gt1KHy6QRvwKxomZVUmzL6GbR9Q5lS+W
 xqI5oMigcDbJ17icexsDg==
X-ME-Sender: <xms:EUvyaPNzwi11zQNKHtDzxs88Hv90FR2OP_GABCSmyaHlcx6JPMsbdQ>
 <xme:EUvyaA2XKOlHnQC3UOkJMNwA_a3mkDYDzGqGjPsT_xlexELIRqch00NNqwr0doL-u
 i3TLEEP08kDGBHmkAJaK6Flq7WtbhpnNWJFiYsPoMJoIfSrsNzMfxzx>
X-ME-Received: <xmr:EUvyaGmRDOevGzBIbzijopPsBOPTOkLMiHx8kEgaqTJWbDB99QaRQjAm6_dW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdelfeehucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdljedtmdenucfjughrpegggfgtfffkvefuhffvofhfjgesthhqredtredt
 jeenucfhrhhomhepfdevhhgrugculfgrsghlohhnshhkihdfuceotghhrggusehjrggslh
 honhhskhhirdighiiiqeenucggtffrrghtthgvrhhnpefhfeduffekffehudffteelvdek
 tedvjeehtdehkeethfehvdeghfehtefhffekgeenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpegthhgrugesjhgrsghlohhnshhkihdrgiihiidp
 nhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepqhgvmh
 huqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopegsrghlrghtohhnsegv
 ihhkrdgsmhgvrdhhuhdprhgtphhtthhopehmrghrtggrnhgurhgvrdhluhhrvggruhesrh
 gvughhrghtrdgtohhmpdhrtghpthhtohepkhhrrgigvghlsehrvgguhhgrthdrtghomhdp
 rhgtphhtthhopegthhgrugesjhgrsghlohhnshhkihdrgiihii
X-ME-Proxy: <xmx:EkvyaPVpa0uhT7ZsIPMtnWr5WFj3Yo0av_iLyFGttUL9tIfldIcoIA>
 <xmx:EkvyaEv43_ai9_-_f-Av7DQwac53WA95GCO0fImgNBhYY7dvFCpUEw>
 <xmx:EkvyaKZzkEk2pVMen8jF1NfCBy44Qfr81YgLrc4-flXQ-rD70nJjGw>
 <xmx:EkvyaLWpqQEU510K46ROYXA6KfMj1uOi-w9LlBuBlXSv-x-OYRa4GA>
 <xmx:EkvyaHSFzzX2Tir7hGu2ApbtdvqBWnUwfjtQqsLZjra4WIUBjnuWfKxH>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Oct 2025 09:56:33 -0400 (EDT)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 8e783301;
 Fri, 17 Oct 2025 13:56:30 +0000 (UTC)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Oct 2025 09:56:30 -0400
Message-Id: <DDKNDZRDU96I.22RLY22ASJ5TL@jablonski.xyz>
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
 <DDIYXXF8C8O3.BGW7D8I6VZTW@jablonski.xyz>
 <93a93652-0203-47f0-6179-edfa543990fa@eik.bme.hu>
In-Reply-To: <93a93652-0203-47f0-6179-edfa543990fa@eik.bme.hu>
Received-SPF: pass client-ip=202.12.124.155; envelope-from=chad@jablonski.xyz;
 helo=fhigh-b4-smtp.messagingengine.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.499, PDS_OTHER_BAD_TLD=1.999, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
> For this R100 card APER_SIZE matches MEMSIZE but the BAR length is twice=
=20
> that. Maybe the other card you get will shed some light on what's going o=
n=20
> with Radeon. I've looked up what the FCode ROM I've tested was doing. Thi=
s=20
> is from a Card#109-85500-00 Rom#113-85501-226 according to the IDs it set=
s=20
> in the device tree, probably from a PowerMac but I don't have the card=20
> just found this ROM. The detokenized part of this Radeon 7000/RV100 ROM=
=20
> that accesses CONFIG_APER_SIZE looks like this:
>
>    7321: const_REG_CONFIG_APER_SIZE
>    7323: ati-reg-l@
>    7325: dup
>    7326: b(to) var_aper_size
>    7329: 2*
>    7330: b(to) var_ram_size
>    7333: const_REG_CONFIG_REG_APER_SIZE
>    7335: ati-reg-l@
>    7337: 2*
>    7338: b(to) var_mmio_size
>
> The variable names were invented by me so it's possible that it actually=
=20
> means vram and mmio BAR size but it does 2* for both the VRAM and REG=20
> APERS and this is the size it then uses for map-in and map-out calls so=
=20
> this suggests these registers are half of the BAR size at least for this=
=20
> card.
>

I got the card! It looks like it was exactly as you suspected and I
think this matches with what you're seeing in the FCode. The
CONFIG_APER_SIZE is half of BAR0 for both Rage 128 and R100:

Card                              VRAM    PCI BAR0   CONFIG_MEMSIZE  CONFIG=
_APER_SIZE  AGP_APER_OFFSET
-----------------------           ----    --------   --------------  ------=
----------  ---------------
Rage 128 Pro Ultra TF             32MB     64MB       0x02000000      0x020=
00000        0x02000000
Rage 128 RF/SG AGP                16MB     64MB       0x01000000      0x020=
00000        0x02000000
Radeon R100 QD [Radeon 7200]      64MB    128MB       0x04000000      0x040=
00000        N/A
Radeon RV100 QY [Radeon 7000/VE]  32MB    128MB       0x02000000      0x040=
00000        N/A

>
> I only have a Rage Mobility M6 Design Guide (M6 is another name for RV100=
)=20
> that talks about memory size and it says that it's minimum 8MB maximum=20
> 64MB but could be R100 supported more. It's still possible that the BAR=
=20
> size is twice the VRAM size for some reason but we don't have enough=20
> evidence for that.
>

Oh! I didn't realize that! That's good to know, I'll dig that up.

I'll include what I learned from the new card and send along a v3 shortly.

- Chad

