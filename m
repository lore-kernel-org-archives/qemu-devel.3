Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 986C8EDF17E
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 17:25:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqwuS-0001nG-Oy; Fri, 13 Feb 2026 12:24:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vqwuR-0001n7-Hk
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 12:24:51 -0500
Received: from fhigh-b3-smtp.messagingengine.com ([202.12.124.154])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vqwuP-0000wI-Fj
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 12:24:51 -0500
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 77AE37A0087;
 Fri, 13 Feb 2026 12:24:45 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Fri, 13 Feb 2026 12:24:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm2;
 t=1771003485; x=1771089885; bh=p9ONHb3Trg5m3iUXdaKsBDhOlwiVwGtt
 l2r0NTQ52Uw=; b=IbEYq/HbD9anmyIMw4UbM97GLafzLv7e2Qq618Ls3RkcA8+t
 KpWSG+aGa2jj1vDy54bpN/BoIMW5QAPOtezjCl/paKLZJuwH68I/4BX4iKbR9dPG
 YzPalAnj7YxlgrMKEgO0KQ3iOkqOWczKgpxmghfdri6Iu8Vs9znPj7inf2II3RFs
 cIrrk/WB5BqYmQL+uqzsVQ6ESurmKxSqGsveOjCEBIARoWvC8NgC1ZD+roN46Vpa
 tWS5UDytJsfr2G/4mZNQsUKHChqwRj5+6LqClDBVhMX6JyLafAoy6yOx8s6Wn8+Z
 wOJJhLBf1RAqBv96EREfSeZuMylf8wt59wtMhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771003485; x=
 1771089885; bh=p9ONHb3Trg5m3iUXdaKsBDhOlwiVwGttl2r0NTQ52Uw=; b=K
 ZBQrbm6JV2zYlfBBMj4fM3bLHVK2lq7EZqg6v2RDD39KhK7ubzLtihG47yOqA6HW
 pHn3LtH24OFQ1fTWf7vm/Zxpb+zFoUJJUBIi23/ZY2G4TstYB+MPcXHt35maR8Tr
 Edk8QglOwuRPX8P/tIGa+nzINt7yw2aYu9vuczGykLKLmtgC+fpPushIlLMV5JZf
 NzjynOSxYgUdCYFvhzTdEbGlfd9ZeQavUtRkPtMFcI9vCortnVCCN50B1H66e2Z4
 zkay/kXNsDaXI2OgZLUB9jO1xwknQylbGwX6gpKIv3PHHEJqYsDh0s/bxkG762xu
 8rwk0Ks5GX3+Gikmgj3Zw==
X-ME-Sender: <xms:XF6PadC924I_uCLu-USM4ThGp8ujprM8CZOBg2jRyY3Y6RUetMWdaQ>
 <xme:XF6PaS-pqjGEto1Hv1rfvUsZmTQFhY6LfCLCv4Ar4ax1EKtHlliTCiCzBAlgWYdy_
 uSfXhfKopbdglg8ulV2lRaMV_dnYy8Z8OiYZXbYS_PKglPagHqINBo>
X-ME-Received: <xmr:XF6PaV9LfGdM-kqY3KzQYn5rcGjv1OE7ynfSjpUIHXQFsuedcuF4sWSrh9hN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdekkeegucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdljedtmdenucfjughrpegggfgtfffkvefuhffvofhfjgesthhqredtredt
 jeenucfhrhhomhepfdevhhgrugculfgrsghlohhnshhkihdfuceotghhrggusehjrggslh
 honhhskhhirdighiiiqeenucggtffrrghtthgvrhhnpefhfeduffekffehudffteelvdek
 tedvjeehtdehkeethfehvdeghfehtefhffekgeenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpegthhgrugesjhgrsghlohhnshhkihdrgiihiidp
 nhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghhrg
 gusehjrggslhhonhhskhhirdighiiipdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehn
 ohhnghhnuhdrohhrghdprhgtphhtthhopegsrghlrghtohhnsegvihhkrdgsmhgvrdhhuh
X-ME-Proxy: <xmx:XF6PaRf1AYL7oO4B2LPKAUd4_m-3pItxEie4s_aJa5WSRdEYrYPaqA>
 <xmx:XF6PaWGAnWqNh62aV0KVLYw7eJMqn0ALcpNCFhWRCts10w2b2KBNWQ>
 <xmx:XF6PaXdQZGjdbpeAJRYzT7pyNehtIvapFILNbINfyOAs8EecTvANxA>
 <xmx:XF6PaYE2iGAhenXE0PCi6y8uChR2Habc0lLAvz5m2iNbJyhp30EnNw>
 <xmx:XV6PafKu2BZ9mQ1TqyVUCz26WIjamUL0qruXKSFAWPd_wUDVZcqZr-81>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Feb 2026 12:24:44 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id 3e43c814;
 Fri, 13 Feb 2026 17:24:43 +0000 (UTC)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 13 Feb 2026 12:24:43 -0500
Message-Id: <DGE0C8NL49YI.6X4RHY1DXKLB@jablonski.xyz>
Cc: <qemu-devel@nongnu.org>
Subject: Re: [PATCH v8 16/18] ati-vga: Implement scissor rectangle clipping
 for 2D operations
From: "Chad Jablonski" <chad@jablonski.xyz>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, "Chad Jablonski"
 <chad@jablonski.xyz>
X-Mailer: aerc 0.21.0
References: <20260204164606.3425246-1-chad@jablonski.xyz>
 <20260204164606.3425246-17-chad@jablonski.xyz>
 <00aade99-9ce2-3679-5171-8899d8fbb524@eik.bme.hu>
In-Reply-To: <00aade99-9ce2-3679-5171-8899d8fbb524@eik.bme.hu>
Received-SPF: pass client-ip=202.12.124.154; envelope-from=chad@jablonski.xyz;
 helo=fhigh-b3-smtp.messagingengine.com
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

>> The src also needs to be offset if clipped on the top and/or
>> left sides to ensure that src data is read correctly and appears
>> clipped when drawn rather than shifted.
>
> This is true for top to bottom left to right but what happens for other=
=20
> direction blits?
>

>> +    /*
>> +     * The src must be offset if clipping is applied to the dst.
>> +     * This is so that when the source is blit to a dst clipped
>> +     * on the top or left the src image is not shifted into the
>> +     * clipped region but actually clipped.
>> +     */
>> +    vis_src.x =3D ctx->src.x + (vis_dst.x - ctx->dst.x);
>> +    vis_src.y =3D ctx->src.y + (vis_dst.y - ctx->dst.y);
>> +    vis_src.width =3D vis_dst.width;
>> +    vis_src.height =3D vis_dst.height;
>
> These may also need to be calculated differently.
>

ctx->dst.x and ctx->dst.y are normalized to the top left corner of the
blit in setup_2d_blt_ctx (lines 102-105). So this is able to
do the calculations uniformly for all blit direction combinations.

>> +    ctx->scissor.width =3D s->regs.sc_right - s->regs.sc_left + 1;
>> +    ctx->scissor.height =3D s->regs.sc_bottom - s->regs.sc_top + 1;
>> +    ctx->scissor.x =3D s->regs.sc_left;
>> +    ctx->scissor.y =3D s->regs.sc_top;
>
> Does this need to be computed as src and dst coordinates when not top to=
=20
> bottom left to right?
>

The scissor rectangle is always in screen coordinates. It isn't affected
by blit direction at all.

Both good questions though. I was a little bit nervous I had missed
something here. So I went ahead and wrote tests that cover clipping
on all sides (including combinations) for both memory and host_data blits.
All tests pass (match framebuffer dumps from r128 hardware). I'll clean
them up and attach an updated test link to v9.

>>         DPRINTF("pixman_blt(%p, %p, %d, %d, %d, %d, %d, %d, %d, %d, %d, =
%d)\n",
>>                 ctx->src_bits, ctx->dst_bits, src_stride_words,
>> -                dst_stride_words, ctx->bpp, ctx->bpp, ctx->src.x, ctx->=
src.y,
>> -                ctx->dst.x, ctx->dst.y, ctx->dst.width, ctx->dst.height=
);
>> +                dst_stride_words, ctx->bpp, ctx->bpp, vis_src.x, vis_sr=
c.y,
>> +                vis_dst.x, vis_dst.y, vis_dst.width, vis_dst.height);
>
> Maybe log visible rect in addition of src and dst not replacing it here s=
o=20
> we can debug if clipping was correctly done.
>
> If you don't want to consider different directions than top to bottom lef=
t=20
> to right that's OK but then we probably need a check and a LOG_UNIMP in=
=20
> that case and keep using unclipped  dst and src (just copying to vis rect=
s=20
> I guess) in that case.
>

As written right now this logs exactly what is being passed into
pixman_blt(). Definitely agree it might be useful to see the raw src and
dst though too. Do you see it as a second log line before/after this
one?

