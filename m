Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEB7ED19511
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 02:09:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkYVy-0004lr-Cv; Mon, 26 Jan 2026 21:09:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vkYVv-0004gu-Se; Mon, 26 Jan 2026 21:09:07 -0500
Received: from fhigh-a8-smtp.messagingengine.com ([103.168.172.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vkYVt-0004uy-O3; Mon, 26 Jan 2026 21:09:07 -0500
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 60B2E140031B;
 Mon, 26 Jan 2026 21:09:04 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Mon, 26 Jan 2026 21:09:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm1;
 t=1769479744; x=1769566144; bh=BG8aq/swcoCPbPu4ge8ckb8QUlmisQ/F
 GkRSkaQlAHM=; b=mcX4RR3OE9Zwr8+YrS/yydx+yJdKxyUfN6FyHPCpa6Scbozq
 XHmkEVU3IeHn97v6hhshN56CgqOMIyJwuEV/I/+DoamBeIaFoF8of/273S/OQuou
 o0KQD/P/R4vZbs1db9vB8MeBFNZ5wMKhgNMT9jOMcRmI1pxGS6uWvF2eF5iDboMy
 kUvYmOlkZmsB9nSIj8QWFLmisOrlyahfUxqe2Ra4ySM8gIGT1h/k3bRxsYobIdHt
 a2V9f9tHABV6CCjq96uPjb4IpdXvKxwxSkoUP3/VyaZkrNpuao34Xlk5WqvFAhQH
 E49IfcRP35Cct3fAiDCrjwqSX3eV4V6YQpptWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1769479744; x=
 1769566144; bh=BG8aq/swcoCPbPu4ge8ckb8QUlmisQ/FGkRSkaQlAHM=; b=r
 PKCCOQ0IRIAKSkEF46+Ipd1TS+kPBlXQA1VyesA/zWYDd3FXWDQ5FeojlCqAVJdF
 JbRarux3st9e2Bq9ZIPJO7Fkc49EAo7VPU45F6O8aWb9P5atLuEIYPMu4B/BgpgJ
 6gVteA/nHsMB6/H+QMlM/hi4rcOg1Nl3d6+c7/ALvP1NFm3VF1ghaH1RyMUI6zut
 o03JofGjL1DzfuU1X8VC0ccPzwwrelfe7VZtJehl0AwdkrP4DBoQwrAuLlH+ZZ9P
 ig4fQwBeNR+06E55TaglLbCG4BZ0JYrYhPmdueBK67S2lcebULsFXl/rDE+5CwPz
 sb3ppE94f7j4M4j0yrMrw==
X-ME-Sender: <xms:Px54adw8kovc0DxtabFTLXBDciYpQ8_DKcbfEPtA6rqSkR5P5gG0hA>
 <xme:Px54aURS8BXHbExcyikdPZ65e1VAmxpU6fvfluAQMRcIncBWqe066Ve7s54SV0Ppn
 ZxIO5aI7e9zNZf7gPUhuBAaRjKFyOakOf6BlvzweHigf743GnrTgRQ>
X-ME-Received: <xmr:Px54acUs1n24QQyTCowU9Nw5CAncPTxP8m_GdzTvI1rUQwHBnsV2pyfrpIib>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheelfeduucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdljedtmdenucfjughrpegggfgtfffkvefuhffvofhfjgesthhqredtredt
 jeenucfhrhhomhepfdevhhgrugculfgrsghlohhnshhkihdfuceotghhrggusehjrggslh
 honhhskhhirdighiiiqeenucggtffrrghtthgvrhhnpefhfeduffekffehudffteelvdek
 tedvjeehtdehkeethfehvdeghfehtefhffekgeenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpegthhgrugesjhgrsghlohhnshhkihdrgiihiidp
 nhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghhrg
 gusehjrggslhhonhhskhhirdighiiipdhrtghpthhtohepsggrlhgrthhonhesvghikhdr
 sghmvgdrhhhupdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
 dprhgtphhtthhopehqvghmuhdquggvvhgvlhdqsghouhhntggvshdotghhrggupehjrggs
 lhhonhhskhhirdighiiisehnohhnghhnuhdrohhrgh
X-ME-Proxy: <xmx:Px54aeYbJvUKzaUtWIKr20p9Flzls9vVr-qT45IqebOHMNnbzeK-Qw>
 <xmx:Px54aa26k3dvCFFm_a92U5iV29tU3l-D_7bkhW7JLCtkYOkN5GpssA>
 <xmx:Px54aYg3sA-lewQU3lZTJ3IHDfTNErUvTNsn1Mgxl_xJY-Go-UKJNw>
 <xmx:Px54aWboNqmVMxdo3vKcuBsJVTDZoLGuZaW01pj8Jdn2Tc5D2akHIA>
 <xmx:QB54aR7rhhD3PndSKMi4WelNO0U6er-VbyFZcJlKsTnCXJa8FSTMyBQF>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Jan 2026 21:09:03 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id b8c37646;
 Tue, 27 Jan 2026 02:09:02 +0000 (UTC)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 26 Jan 2026 21:09:02 -0500
Message-Id: <DFZ07VSHIHN3.DQF2CGTUHQSM@jablonski.xyz>
Cc: <qemu-devel@nongnu.org>, <qemu-devel-bounces+chad=jablonski.xyz@nongnu.org>
Subject: Re: [PATCH v5 06/12] ati-vga: Create setup_2d_blt_dst helper
From: "Chad Jablonski" <chad@jablonski.xyz>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, "Chad Jablonski"
 <chad@jablonski.xyz>
X-Mailer: aerc 0.21.0
References: <20260116024258.1487173-1-chad@jablonski.xyz>
 <20260116024258.1487173-7-chad@jablonski.xyz>
 <e81ba5b9-acbe-5fb7-6fc0-c31e3c3dd601@eik.bme.hu>
 <DFYMJNMCJGVU.1VNVU1PXZZWQR@jablonski.xyz>
 <0b2a14f1-d274-21b4-d5c5-4671ace85b2d@eik.bme.hu>
In-Reply-To: <0b2a14f1-d274-21b4-d5c5-4671ace85b2d@eik.bme.hu>
Received-SPF: pass client-ip=103.168.172.159; envelope-from=chad@jablonski.xyz;
 helo=fhigh-a8-smtp.messagingengine.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.499, PDS_OTHER_BAD_TLD=1.999, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

>
> I don't feel strongly about it but I though it might be simpler to reuse=
=20
> the same type instead of adding a new struct for everything. I wonder if=
=20
> something like
>
> typedef {
>      QemuRect rect;
>      int bpp;
>      int stride;
>      uint8_t *bits;
> } ATIBltRect;
>
> ati_2d_do_blt(ATIBltRect src, ATIBltRect dst, bool top_to_bottom, bool le=
ft_to_right)
>
> or similar could work (even if you don't use src.rect.width/height) and b=
e=20
> simpler or if you still have ATIVGAState as parameter to ati_2d_do_blt=20
> then you don't even need to pass the bools as those could be get from the=
=20
> device state which should not change during host data blits (or if they d=
o=20
> real hardware may also change what it does).
>
> Or maybe ati_2d_do_blt really only needs a copy of the relevant registers=
=20
> (e.g. from dst_offset to dp_write_mask copied to an ATI2DCtx or similar=
=20
> struct) and work from that instead of ATIVGAState directly so the host=20
> data route can pass it's own copy with modified register contents and can=
=20
> update these without affecting the registers.
>
> But if this does not make sense to you and you think having separate=20
> structs are clearer I'm OK with that too, these could be modified later a=
s=20
> well. I think I'll wait for the next version before going into the detail=
s=20
> of the end of the series as I don't expect to need any more major rewrite=
=20
> so it will probably already be close to be good enough and only need mayb=
e=20
> one more revision but this next version may change some these patches so=
=20
> the next version may look a bit different from the current version.
>

I see. That makes a lot of sense. And now that you mention the potential
ATI2DCtx solution I do like that it removes direct dependency on the regist=
ers
inside of the blit function. I wonder if we could go a step even further an=
d
store the actual derived values in the struct instead of a copy of raw regi=
ster
values. Something like:

typedef struct {
  /* src */
  uint8_t *src_bits;
  int src_x, src_y;
  int src_stride;

  /* dst */
  uint8_t *dst_bits;
  QemuRect dst_rect;
  int dst_stride;
  int bpp;

  QemuRect scissor;
  uint32_t rop3;
  bool left_to_right;
  bool top_to_bottom;
  uint32_t frgd_clr;
  uint32_t bkgd_clr;
} ATI2DCtx;

We would still need to pass VGACommonState in to access a few things (vram =
and
the palette) and use_pixman but we wouldn't need the full device at that po=
int.
So the function signature would look like:

static void ati_2d_do_blt(VGACommonState *vga, ATI2DCtx *ctx, bool use_pixm=
an)

A blt ctx setup function could then fill this struct in the most common cas=
e (memory)
and the host_data flush could easily modify it without needing any of the r=
egister access
details.

One downside of course is that if we discover we need to mutate registers
during the blit we will need to rethink this a bit. But so far it isn't loo=
king
like that is necessary.

