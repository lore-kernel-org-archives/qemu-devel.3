Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A47F4EB364A
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 01:23:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxEU5-0001FX-6K; Mon, 02 Mar 2026 20:23:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vxETi-0001CA-SJ
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 20:23:16 -0500
Received: from fout-a8-smtp.messagingengine.com ([103.168.172.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vxETe-0000pm-VY
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 20:23:14 -0500
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
 by mailfout.phl.internal (Postfix) with ESMTP id 66525EC05AD;
 Mon,  2 Mar 2026 20:23:08 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-10.internal (MEProxy); Mon, 02 Mar 2026 20:23:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1772500988; x=1772587388; bh=StJkv9gdpve3agL0vk972hxfZJ8dDyW8
 waTzWSlsdnw=; b=N6VwvEl6P8WFThDmkmOXE8HtSvUFm4/3uypIjerhWa4tDpBV
 rTISc1BD4XqWsRihhEwtajIrHIZZnHCpW/9T3D2BtSEayxv4DG3rs+FEffjpLxfc
 PkevWUmcG1gwzgwY6o7IhzjPXee+X7eZ6d2s4peoXY3vRWs6WNbooy+NFmzb4/f6
 fu2NY0Fs+H6fgjcpwcUa1pqGNoLXG5ZrGSAm6gqnABsJkk4ZZ258i5bgcz5nFO3v
 TYITdbYOjO8O5a1iG4mfrQ5kL3OH5KPXAkLto6VqbuYk29dBLRjQB2XUnNN2RMig
 CYojwM27kL4VCeEZABpO4O3rJcKvTHE24Oz4+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772500988; x=
 1772587388; bh=StJkv9gdpve3agL0vk972hxfZJ8dDyW8waTzWSlsdnw=; b=x
 TPRKS+v/CIwskDibOexpw1Vyunka+VKifqbon04mrIMxRSHTATCqasN0QazyIMgM
 DnfCWuY+sfjSfQJTpCu8OxZWC1xC+lnbIf8P8C2QEUNM4TjV3SVAlQZmmhFUH6Ql
 7gSsj/0UZer0gpTGJ/xnj7rnLgSrUyBaTwWxJnp2jvF4fbYK5PD9sEjvL4nIky4K
 l7Th7D4x/632TGSR9NvKJcDxiUo/w8cYV/g0zmRzVzD7AlQefkVTTh2Oz4oyOIBD
 nKDayxcjmCgN+qZvrwUIZ6anA7TNN/oa4RkgIYeF7LeV3KauFbA8BZXjsjfRXUsz
 Hl+GElCmDVIf8SZH0/kDg==
X-ME-Sender: <xms:_DemaTMq4t1gGLQUI2-ldToujjzpTnKyW8lgCtuCmvprzmbDoeY0OA>
 <xme:_DemaU2wZuduAPIV9yM315qsKEivHXI_-0YIGlUfGbVzEvniW9rwDCACptqQVpxJG
 pc-KcCsvvEkBguecgClrWYYfYYnIQHz7oK5nIV34Kdu6OoLmYCytY4>
X-ME-Received: <xmr:_DemaanRLLlll87zr4ua15rzU2nsQFp1wZTH88maDm-4ZdCy2g-QvjGW-0Oh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheelvdefucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdljedtmdenucfjughrpegggfgtfffkvefuhffvofhfjgesthhqredtredt
 jeenucfhrhhomhepfdevhhgrugculfgrsghlohhnshhkihdfuceotghhrggusehjrggslh
 honhhskhhirdighiiiqeenucggtffrrghtthgvrhhnpefhfeduffekffehudffteelvdek
 tedvjeehtdehkeethfehvdeghfehtefhffekgeenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpegthhgrugesjhgrsghlohhnshhkihdrgiihiidp
 nhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsggrlh
 grthhonhesvghikhdrsghmvgdrhhhupdhrtghpthhtohepmhgrrhgtrghnughrvgdrlhhu
 rhgvrghusehrvgguhhgrthdrtghomhdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnh
 honhhgnhhurdhorhhgpdhrtghpthhtohepkhhrrgigvghlsehrvgguhhgrthdrtghomhdp
 rhgtphhtthhopegthhgrugesjhgrsghlohhnshhkihdrgiihii
X-ME-Proxy: <xmx:_DemaTVF4HehdfhjW7OD7lNTt21tAxeD42CPViNVcO8QbKVFfsRIvg>
 <xmx:_DemaYvSnIDEfsa_jMt45qhYcx7UMuPXKLgHxG2iIllDfij-2Wy3Yg>
 <xmx:_DemaebgDk4uikyyiujHiAcQh1v_EIW6tJMGGtHSC3z4SbTkznl_Bg>
 <xmx:_DemafWtpbjp62pj1WUtSXQkFXQFj5tFT1QongC2AEEMItdfpYJmew>
 <xmx:_DemabRi6xp9EnehFshXyEJT6QlbZ380LLpZF7LrkiOEZk-ae-dmM7Yl>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 20:23:07 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 9d4bdb3b;
 Tue, 3 Mar 2026 01:23:07 +0000 (UTC)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Mar 2026 20:23:07 -0500
Message-Id: <DGSR5S9BZKI3.3AHBP5B0P81R4@jablonski.xyz>
Cc: <qemu-devel@nongnu.org>, "Gerd Hoffmann" <kraxel@redhat.com>,
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v10 17/17] ati-vga: Implement HOST_DATA flush to VRAM
From: "Chad Jablonski" <chad@jablonski.xyz>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, "Chad Jablonski"
 <chad@jablonski.xyz>
X-Mailer: aerc 0.21.0
References: <20260302180447.1078098-1-chad@jablonski.xyz>
 <20260302180447.1078098-18-chad@jablonski.xyz>
 <681a858e-1e35-aa8c-ecf9-b791438aaac5@eik.bme.hu>
In-Reply-To: <681a858e-1e35-aa8c-ecf9-b791438aaac5@eik.bme.hu>
Received-SPF: pass client-ip=103.168.172.151; envelope-from=chad@jablonski.xyz;
 helo=fout-a8-smtp.messagingengine.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FROM_SUSPICIOUS_NTLD=0.5,
 PDS_OTHER_BAD_TLD=1.999, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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

>> +void ati_finish_host_data(ATIVGAState *s)
>> +{
>> +    while (ati_flush_host_data(s)) {
>> +        continue;
>> +    }
>
> Is this while loop still needed? It looks like it will fill the rest of=
=20
> the blit rect with the last accumulator value instead of just finishing=
=20
> the blit in the middle. Is that what the real chip does? Otherwise this=
=20
> could just flush once and deactivate host data, couldn't it?
>

This is how the real chip behaves, but it flushes the entire 256-bit
accumulator wrapping around until the blit is complete. Even though
the chip does behave this way the output will be different here because
we've limited it to 128 bits. That makes this feel like sort of a
half-measure toward reproducing the behavior. So I think you're right
and we should just flush and deactivate host_data.

It may also be worth adding a LOG_GUEST_ERROR here if the blit is ended
early so that it's a bit more visible if it happens in real-world usage.

