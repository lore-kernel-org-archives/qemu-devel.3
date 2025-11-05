Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A970CCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 19:29:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGjC1-0002ZG-7G; Wed, 05 Nov 2025 14:29:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vGjBx-0002XL-Fw
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 14:29:13 -0500
Received: from fout-b5-smtp.messagingengine.com ([202.12.124.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1vGjBv-0005vt-40
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 14:29:12 -0500
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id 89E731D001B8;
 Wed,  5 Nov 2025 14:29:08 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Wed, 05 Nov 2025 14:29:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm2;
 t=1762370948; x=1762457348; bh=CY0+7zZc0GGMEX1V0iNzCtpwakx28HTK
 c+bIpG9anmY=; b=EdYZHDAX6VNSOJaeY8ADCs27A4qGnVeX1NwFWyKmrlKOA9q+
 RUM65s6IiY5XFSHaCIqlAXaVCVH0nJ64apL3bZfLBlDS/IOJggH/HUXVItJWi121
 B8ONL1sIiN4Vhrm8m8BC+sIHpNwdiXogeoNiNsB8jg+lVBwCcyTtcW99GxRXdPY6
 Ls616GOGXYagLDkZd4NyPCOjLOh5Km+Ua4mRfSamO1tKp/A9BAIbPCreH0QWR++j
 6POtM9PWiI5oTVURWNLBI2aimCypNsIKdz3WZ8HFb59r8d/vTRZVn9JyDBZTQ2Sk
 57lPqn0ac3sWBPytC3mqvY50BEcy3+RTcLQ3NA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762370948; x=
 1762457348; bh=CY0+7zZc0GGMEX1V0iNzCtpwakx28HTKc+bIpG9anmY=; b=K
 g+WXjwO0Fo8gtHcZOjOJopKSEqzsLE2WaJ6d6M0qyOQTuG8+xXUyWKwSBNi2VynB
 NBojVOZKivzElc+Gs2T9jIItLez/Qm88iL/9028TYLGVLmYy8w1qks1OxBYD+96f
 hw5z8IA14DccA4sc3FecJcPoRiWC2H+do6pMTg4uOnkqtCCgMKB3joZscHJqnKSN
 mEyuLd4ra2g5ekLHjWp89YybB4LFFqkNTmAGLaiZRidn8sIFIRUbUOWmHpIJohRN
 VqhnQnhRNxer4HMqdElpQQ0ch3u9jHLWTYl+xeJK7VwTNNXAarnGhiK0nQfHuzWa
 dprK2MTwGadBbw8uvNhuA==
X-ME-Sender: <xms:g6ULaZYrGe214OFyHov2Xu-y8BMKHH5HkA2C4OZ-_vgpYrqNajUfmg>
 <xme:g6ULaX1K-oQp5u6lrza_DrIUUBcn6EItSaCGbBjelhzMGhfyoeiy12bn-BRD_vISd
 XjrNWD5_HDUqzDAV9xglhIIfGbu5RKDsFZWpASuwhoec_RSeyVZxUjx>
X-ME-Received: <xmr:g6ULaZUNOMNfmjL_eXZKTamU-fmrjJQbKuCjAIo5xs5Ph66yK5jDksIp23X0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeegjeegucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdljedtmdenucfjughrpegggfgtfffkvefuhffvofhfjgesthhqredtredt
 jeenucfhrhhomhepfdevhhgrugculfgrsghlohhnshhkihdfuceotghhrggusehjrggslh
 honhhskhhirdighiiiqeenucggtffrrghtthgvrhhnpefhfeduffekffehudffteelvdek
 tedvjeehtdehkeethfehvdeghfehtefhffekgeenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpegthhgrugesjhgrsghlohhnshhkihdrgiihiidp
 nhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepqhgvmh
 huqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopegthhgrugesjhgrsghl
 ohhnshhkihdrgiihiidprhgtphhtthhopegsrghlrghtohhnsegvihhkrdgsmhgvrdhhuh
X-ME-Proxy: <xmx:g6ULaRUqOB_69tUFS6MwziT65E-LnjzsNfnlaWsrLjF9XIYfgzIcZQ>
 <xmx:g6ULaYdEdiyNlxHUBvwISwlBh0I9IcPC_RIQWkzyZvIXEpMe6eTMAA>
 <xmx:g6ULaaX48Xi89VUfrmdfTNBFYGSY9nNWICdAK-IBiwX6V3q2WIxdxQ>
 <xmx:g6ULaRcmWqDe2DIIZTDeq1cqDrugHKpTpp8ZuRByRoIIJQtOHt_kIQ>
 <xmx:hKULadA8t3ua0F_IG1K15zR23HFEn3_0_ZP2oA42zJMapz9plES86j7A>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Nov 2025 14:29:06 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id a3e48ac8;
 Wed, 5 Nov 2025 19:29:05 +0000 (UTC)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 05 Nov 2025 14:29:05 -0500
Message-Id: <DE10CZ7I52GT.32EF03GV1QTNB@jablonski.xyz>
Cc: <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 2/7] ati-vga: Implement scissor rectangle clipping
 for 2D operations
From: "Chad Jablonski" <chad@jablonski.xyz>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, "Chad Jablonski"
 <chad@jablonski.xyz>
X-Mailer: aerc 0.21.0
References: <20251103033608.120908-1-chad@jablonski.xyz>
 <20251103033608.120908-3-chad@jablonski.xyz>
 <c083bd27-f105-1837-2dfe-0ea60a0f49de@eik.bme.hu>
In-Reply-To: <c083bd27-f105-1837-2dfe-0ea60a0f49de@eik.bme.hu>
Received-SPF: pass client-ip=202.12.124.148; envelope-from=chad@jablonski.xyz;
 helo=fout-b5-smtp.messagingengine.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.499, PDS_OTHER_BAD_TLD=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

>> +
>> +    QemuRect dst;
>> +    {
>> +        unsigned dst_width =3D s->regs.dst_width;
>> +        unsigned dst_height =3D s->regs.dst_height;
>> +        unsigned dst_x =3D (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ?
>> +                          s->regs.dst_x : s->regs.dst_x + 1 - dst_width=
);
>> +        unsigned dst_y =3D (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
>> +                          s->regs.dst_y : s->regs.dst_y + 1 - dst_heigh=
t);
>> +        qemu_rect_init(&dst, dst_x, dst_y, dst_width, dst_height);
>> +    }
>
> This is a bit unusual style putting variable init in a block. I'm not sur=
e=20
> it's acceptable for QEMU, maybe you could put it in a static helper=20
> function which is more usual style.
>

Not a problem, I'll break these out into a helper in v3.

>> +
>> +    QemuRect scissor;
>> +    {
>> +        uint16_t sc_left =3D s->regs.sc_top_left & 0x3fff;
>> +        uint16_t sc_top =3D (s->regs.sc_top_left >> 16) & 0x3fff;
>> +        uint16_t sc_right =3D s->regs.sc_bottom_right & 0x3fff;
>> +        uint16_t sc_bottom =3D (s->regs.sc_bottom_right >> 16) & 0x3fff=
;
>> +        qemu_rect_init(&scissor, sc_left, sc_top,
>> +                       sc_right - sc_left + 1, sc_bottom - sc_top + 1);
>> +    }
>
> This could be checked on real hardware too what happens if you store=20
> something in reserved bits (the docs may suggest that e.g. SC_BOTTOM,=20
> SC_RIGHT and SC_BOTTOM_RIGHT might be the same register so writing=20
> reserved bits may overwrite others or masked out by hardware but it's not=
=20
> clear from docs; the rage128pro docs aren't even clear on what the limits=
=20
> are as the summary text in the section 3.28 gives different limits than=
=20
> individual register descriptions right after that). To simplify using=20
> these values I generally tried to apply reserved bits mask on write so no=
=20
> need to do that at read and using the values. Maybe these should do the=
=20
> same?
>

It looks like the scissor registers are masked at write! Bits 13:0 are set
on write and writing to reserved bits are just ignored. So you're absolutel=
y
right we shouldn't be bothering with this on read. I'll update this in v3.

# Tested On: ATI Technologies Inc Rage 128 Pro Ultra TF

reserved scissor bits
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

** Initializing SC_BOTTOM to 0x0 **
** Initializing SC_RIGHT to 0x0 **
** Initializing SC_TOP to 0x0 **
** Initializing SC_LEFT to 0x0 **

Initial State
------------------------------------
SC_BOTTOM:               0x00000000
SC_RIGHT:                0x00000000
SC_TOP:                  0x00000000
SC_LEFT:                 0x00000000

** Setting SC_BOTTOM to 0xffffffff **
** Setting SC_TOP to 0xffffffff **

After State
------------------------------------
SC_BOTTOM:               0x00003fff  <=3D=3D=3D=3D=3D=3D Masked at write (1=
4-bit)
SC_RIGHT:                0x00000000
SC_TOP:                  0x00003fff  <=3D=3D=3D=3D=3D=3D Masked at write (1=
4-bit)
SC_LEFT:                 0x00000000

** Setting SC_RIGHT to 0xffffffff **
** Setting SC_LEFT to 0xffffffff **

After State
------------------------------------
SC_BOTTOM:               0x00003fff
SC_RIGHT:                0x00003fff  <=3D=3D=3D=3D=3D=3D Masked at write (1=
4-bit)
SC_TOP:                  0x00003fff
SC_LEFT:                 0x00003fff  <=3D=3D=3D=3D=3D=3D Masked at write (1=
4-bit)

** Setting SC_BOTTOM_RIGHT to 0xfeeefeee **
** Setting SC_TOP_LEFT to 0xfeeefeee **

After State
------------------------------------
SC_BOTTOM:               0x00003eee  <=3D=3D=3D=3D=3D=3D Masked at write (1=
4-bit)
SC_RIGHT:                0x00003eee  <=3D=3D=3D=3D=3D=3D Masked at write (1=
4-bit)
SC_TOP:                  0x00003eee  <=3D=3D=3D=3D=3D=3D Masked at write (1=
4-bit)
SC_LEFT:                 0x00003eee  <=3D=3D=3D=3D=3D=3D Masked at write (1=
4-bit)

