Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5558CCCFA13
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 17:37:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI8qF-0000H6-08; Wed, 29 Apr 2026 13:36:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1wI8qD-0000Gv-6I
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 13:36:53 -0400
Received: from fout-a2-smtp.messagingengine.com ([103.168.172.145])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1wI8qB-0007AP-Dn
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 13:36:52 -0400
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.phl.internal (Postfix) with ESMTP id EA1D2EC00E7;
 Wed, 29 Apr 2026 13:36:48 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Wed, 29 Apr 2026 13:36:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm1;
 t=1777484208; x=1777570608; bh=Enzqa/P5xUfSI5hVYwGVonA/sIVKpSUy
 SjUyU4wy758=; b=Ua8nJT8iVwUhm2O0TONZAJ4es8hEMz5cKQHZQsciMzWxauni
 /rpZqBTFGfnZpySC/1Ve8xo98WzvtIpXBta6SsBt4JjnggzwJ0ojfF78wcZRWlTa
 HWeXZ0s5+unRGzttjcaTXr+AKsvp1NNAi5HHGUmzeyDy3LsrD0Ov38nxc76AdfIG
 8tSdJIiw9BcFr4ubQcgkpXag/I1cUz/1ixU0kPVBRNZlAWDtcaSqoun57V/pkvV/
 1SuK43tscrt/ML8602q+Z3Przx/hJTCuYeYU8acUO1Rh9y/GgQDkFcrZM+yXL3hb
 PHPAUGcgMTNlYGkful7T2bIEf27XPQMZhnzx6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777484208; x=
 1777570608; bh=Enzqa/P5xUfSI5hVYwGVonA/sIVKpSUySjUyU4wy758=; b=X
 7mcvyNjcBYTribXsGbwguAskRETd1Q+Svc5mTzZfFItvgmlbJ3Fj3b+ooSoKCdOE
 ViZsseRfrFaHJ+/jqAMhl3eWtPHqMgi5uP5hqkf6dfKVdzACfsQ5fhckxqWs4zMb
 1UrxR0xdgPOYkAlGq5t21IDwwBZEvv1B0hxdPXI3n+9Ym8RuOkrQL0ym6XxwzsUt
 ixsPbx9tL5uBmWid4Y/ZnsSJoyw4/BisGavyCTTazPsWirERag+1GBLPioPeANzR
 eWOtBmjJH7mGf9+XhabEWdGr2NS8p73yUBe1mwlmxogPxOZ+BVcIaDQVxpNX8HAS
 P3pzmjTNH325DOTedbNqQ==
X-ME-Sender: <xms:sEHyaeOMUeGg6JeiX5hRAwYJoqyyb5EbAyRI4v6GZ0z-1-NK-s2wvw>
 <xme:sEHyaT3VvQq4UTiw665DjkbGtQ7Oet5r0JyIUv4_Kmj0L2muhrO98Dl3UHS23l4Z4
 7rKzqu8CCXySaIardBuwjMxWQzOUc5nFu7riZ7oc54ikiKmXoN4sRE>
X-ME-Received: <xmr:sEHyadkrtz2aqbrY7CZxLFDI__uNVNpSPim4D_jSbdEoNG2ERsrvrCdtHKzZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekhedtiecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfghrlh
 cuvffnffculdejtddmnecujfgurhepggfgtgffkfevuffhvffofhgjsehtqhertdertdej
 necuhfhrohhmpedfvehhrgguucflrggslhhonhhskhhifdcuoegthhgrugesjhgrsghloh
 hnshhkihdrgiihiieqnecuggftrfgrthhtvghrnhephfefudffkeffheduffetledvkeet
 vdejhedtheektefhhedvgefhheethfffkeegnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomheptghhrggusehjrggslhhonhhskhhirdighiiipdhn
 sggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrghrtg
 grnhgurhgvrdhluhhrvggruhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepkhhrrgig
 vghlsehrvgguhhgrthdrtghomhdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonh
 hgnhhurdhorhhgpdhrtghpthhtohepsggrlhgrthhonhesvghikhdrsghmvgdrhhhupdhr
 tghpthhtoheptghhrggusehjrggslhhonhhskhhirdighiii
X-ME-Proxy: <xmx:sEHyaaXLD_hVtKQXpGCuMCfJNQSB8tStKemk1qpVXVhc9gY21qGv1g>
 <xmx:sEHyaTuw4dad2qjgku6H67Nq9pM5u-XjzZaSdbhZ367Ib7RM1hc1xA>
 <xmx:sEHyadZkzeaIW62uuL6xoH3CznQQRgUEGwwpsCfFp4EwR9quLMTfpQ>
 <xmx:sEHyaSV7ja1GbNHzNPS5Dto7ceEs1YRWXJEcxGWKG4GmDqyW_zKVmw>
 <xmx:sEHyaaR6cYGbPkRDTf26bmIXlu5nknTv-C1FyWt_D2aAOSTYVuGbybfa>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Apr 2026 13:36:47 -0400 (EDT)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 2a4a9bf8;
 Wed, 29 Apr 2026 17:36:46 +0000 (UTC)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Apr 2026 13:36:46 -0400
Message-Id: <DI5TKBSTXIKZ.2BMHPF7BB45LC@jablonski.xyz>
Cc: <qemu-devel@nongnu.org>, "Gerd Hoffmann" <kraxel@redhat.com>,
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Subject: Re: [PATCH] ati-vga: fix ati_set_dirty address calculation
From: "Chad Jablonski" <chad@jablonski.xyz>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, "Chad Jablonski"
 <chad@jablonski.xyz>
X-Mailer: aerc 0.21.0
References: <20260417205752.3932801-1-chad@jablonski.xyz>
 <58180aa1-4e39-4aa8-6d3b-586d4461deba@eik.bme.hu>
 <DHWB25SYYESE.QMQK5VPNXSVK@jablonski.xyz>
 <ef33b737-1f62-032a-5e97-4fc0a371f202@eik.bme.hu>
In-Reply-To: <ef33b737-1f62-032a-5e97-4fc0a371f202@eik.bme.hu>
Received-SPF: pass client-ip=103.168.172.145; envelope-from=chad@jablonski.xyz;
 helo=fout-a2-smtp.messagingengine.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.499, PDS_OTHER_BAD_TLD=1.999, RCVD_IN_DNSWL_LOW=-0.7,
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

>>
>> I think if we want to avoid this the way to do it may be to just take
>> the intersection of the currently visible screen area and the
>> destination area and mark just that as dirty.
>
> That could work but maybe we also have problems with calculating=20
> intersects. The ATI docs say SC values can be negative (Range -8192 to=20
> 8191) but we don't seem to handle that correctly. I don't know if any=20
> drivers use negative values in scissor clipping, I've only noticed it whe=
n=20
> checking with different values so maybe that's not be a problem in common=
=20
> cases.
>

Ah, right, we're not currently handling negative clipping values. We're
also not applying clipping to the dst on the ctx passed into ati_set_dirty
right now. Given that, for v2 I went ahead and did this intersection as-is.
It'll mean overmarking dirty in some cases, but no more than the
previous implementation and I think it's something we can fix separately.

>> Even fixing the unit issue
>> the old bounds check would miss blits that began outside of the visible
>> screen and continued onto the visible screen.
>
> Maybe this is the real reason but I still don't see how a relatively smal=
l=20
> blit of one character in a fully visible xterm not even near the left of=
=20
> screen could be missed this way if the screen is panned so I'm still=20
> suspecting clipping might have something to do with this. Not marking out=
=20
> of screen updates also does not explain that so it's probably just wrong=
=20
> calculation of visible area. Or you meant that's just another way the=20
> current calculation could miss updates. Yes that's possible.
>

Yep, I just meant this is another way the current calculation can miss
updates.

>> Another thought, we could clear dirty bits on full screen updates. But
>> that's a change with a much larger blast radius and I would be nervous t=
o
>> make it.
>
> Can we invalidate dirty rect in ati_vga_set_offset to avoid changing vga?
>

v2 is incoming with the intersection approach. If that doesn't work out
we can investigate this further.

