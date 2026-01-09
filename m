Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25835D1A63E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 14:46:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veDkM-0004GQ-1L; Fri, 09 Jan 2026 09:45:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1veDkK-0004G9-Ga; Fri, 09 Jan 2026 09:45:48 -0500
Received: from fout-b8-smtp.messagingengine.com ([202.12.124.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1veDkI-0000xq-L8; Fri, 09 Jan 2026 09:45:48 -0500
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.stl.internal (Postfix) with ESMTP id D92251D0016A;
 Fri,  9 Jan 2026 09:45:44 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Fri, 09 Jan 2026 09:45:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm1;
 t=1767969944; x=1768056344; bh=1X4C/+Rj1Jfsc1aNK2pJqBw2X4Nm7RJ0
 PnbchM6of4o=; b=X/O8oXgOhJgEQ9d8oulpBp99HKdZ00NUjYOzxExPWmkGlG5Q
 0DHaOaHxueFUIHgkBGOBj6539x/FK/7nmJSXEmmjPWzNOtuGu6ZjWCkPJ96QFVZD
 5imBsTvoqTc9Tn9d8mvVy/HRUlII79JmVq+vxNtljdbzZQzVADHCeTpfrUc/+7rn
 ZjV08MDLfFc8p2RMKd88L/FYfuhoIpXx2xbLrPRbs+S6miQzeBD1wpxRvQIym61B
 stL4W/HvO0ujr0sDY9+JizzTbuIti80SGzsK8u3gaV84xd0jNgTBc0UiJbGn0wA8
 0Bq/m/NpDFTXQ2O6ZLEZupWJt9nbv/YLqjlOBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767969944; x=
 1768056344; bh=1X4C/+Rj1Jfsc1aNK2pJqBw2X4Nm7RJ0PnbchM6of4o=; b=s
 SwcwQPagpv+cqoMthaD5VzkQx9tilD9cxyQeEP8aCv8VmiFn1qfvVI6+AB3bALwU
 3NkLuyexJdpAgW6r6xene2dRKi6pStQMN/WLz2kRXq9+WG/AEHsJkrnqAcfhjwVE
 YZS+dlZ/08HoXgP6RD7HgIDU1zu3cUAODZ5blGS77SuPs5qjfQ2trGdFOKiOKCQl
 /nnab7YtycgeImJle7q4U6T6Vl410sMHe2SdT6Egj3seaZMYxYRjHIazXLlZW2gb
 mHZIQxULRAj3NLD1wDl1DwSzwY0tMeyo5HJtQT7Qsa8hkzTr05Pi5qfLxX6OpoIC
 U3DoxkNDY4hma3waRGtZw==
X-ME-Sender: <xms:mBRhaac67ovB576iqae0SwFEcn0--hjrWcIrwEAEpGFSa8p33wTtDA>
 <xme:mBRhabPDQ-RMSe9zm7LyWURqXl6-tnDyfRtk2ZYbE1ZRfOHz2Q24gAhtsjtk-uYoM
 RwCCDuPZBjaNQM0Q8atKswusYsUUHo9MWhI7_xJUl0b58d-tWybo834>
X-ME-Received: <xmr:mBRhaQgzmyNwVTpbf3EIVW_NLWJnNnOXIYHZSOdXTpy75-wStY603v34SfW8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdeltdekucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdlfeehmdenucfjughrpegggfgtfffkhffvvefuofhfjgesthhqredtredt
 jeenucfhrhhomhepfdevhhgrugculfgrsghlohhnshhkihdfuceotghhrggusehjrggslh
 honhhskhhirdighiiiqeenucggtffrrghtthgvrhhnpeejhfekgefhveeiheeiheetjeff
 ffdvteeguefhgfdvvedviefhgffgjefgtdegfeenucffohhmrghinhepfihikhhiphgvug
 hirgdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
 ohhmpegthhgrugesjhgrsghlohhnshhkihdrgiihiidpnhgspghrtghpthhtohepgedpmh
 houggvpehsmhhtphhouhhtpdhrtghpthhtoheptghhrggusehjrggslhhonhhskhhirdig
 hiiipdhrtghpthhtohepsggrlhgrthhonhesvghikhdrsghmvgdrhhhupdhrtghpthhtoh
 epqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopehqvghmuhdq
 uggvvhgvlhdqsghouhhntggvshdotghhrggupehjrggslhhonhhskhhirdighiiisehnoh
 hnghhnuhdrohhrgh
X-ME-Proxy: <xmx:mBRhaW34bW0gcObiaHL9bLVLCpR8OCuAAsr3ZN43ora1FU5Zh-5JOA>
 <xmx:mBRhaSjqwZwQJMdSSpoUjYEYsCUXsgQSj9yBrkpEFQ6FbrdOf2KOmg>
 <xmx:mBRhaefwZtI6hciiTSJJYnDPkXhgWupbxP4HlCy7aTAGEfDmiehWgg>
 <xmx:mBRhadkvIwE1SAsSCLEZjGl6NTVPR66CjaWrM8sl3vjkhv3Lj1PQQg>
 <xmx:mBRhackoA2rA3l14hQgsc_fRFCnJqndq7CPzxW_jlMsK6yoXYplrNdPY>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jan 2026 09:45:44 -0500 (EST)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id a7c1a239;
 Fri, 9 Jan 2026 14:45:43 +0000 (UTC)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 09 Jan 2026 09:45:43 -0500
Message-Id: <DFK51FL5XBP1.4FSMIWGTP9Z2@jablonski.xyz>
From: "Chad Jablonski" <chad@jablonski.xyz>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, "Chad Jablonski"
 <chad@jablonski.xyz>
Cc: <qemu-devel@nongnu.org>, <qemu-devel-bounces+chad=jablonski.xyz@nongnu.org>
Subject: Re: [RFC PATCH] ati-vga: Refactor ati_2d_blt to accept src and dst
 parameters
X-Mailer: aerc 0.21.0
References: <20260109045035.2931091-1-chad@jablonski.xyz>
 <3fb14280-960b-d923-dd5d-3748450acc70@eik.bme.hu>
In-Reply-To: <3fb14280-960b-d923-dd5d-3748450acc70@eik.bme.hu>
Received-SPF: pass client-ip=202.12.124.151; envelope-from=chad@jablonski.xyz;
 helo=fout-b8-smtp.messagingengine.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.498, PDS_OTHER_BAD_TLD=1.997, RCVD_IN_DNSWL_LOW=-0.7,
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
> https://en.wikipedia.org/wiki/Eastern_name_order#Hungary
> That's what capitalisation is meant to show but not many seem to know=20
> about that convention. No worries though not many got it at first.
>

Ah, thanks for the explanation, I had no idea! Should I call you Zoltan?

>> +    ATIBlitDst dst =3D {
>> +        .valid =3D false,
>> +        .bpp =3D ati_bpp_from_datatype(s),
>> +        .stride =3D DEFAULT_CNTL ? s->regs.dst_pitch : s->regs.default_=
pitch,
>> +        .left_to_right =3D s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT,
>> +        .top_to_bottom =3D s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM,
>> +        .bits =3D s->vga.vram_ptr + (DEFAULT_CNTL ?
>> +                s->regs.dst_offset : s->regs.default_offset),
>> +    };
>> +    uint8_t *end =3D s->vga.vram_ptr + s->vga.vram_size;
>> +    unsigned dst_x =3D (dst.left_to_right ?
>> +                     s->regs.dst_x : s->regs.dst_x + 1 - s->regs.dst_wi=
dth);
>> +    unsigned dst_y =3D (dst.top_to_bottom ?
>> +                     s->regs.dst_y : s->regs.dst_y + 1 - s->regs.dst_he=
ight);
>> +    qemu_rect_init(&dst.rect, dst_x, dst_y,
>> +                   s->regs.dst_width, s->regs.dst_height);
>> +
>> +    if (!dst.bpp) {
>>         qemu_log_mask(LOG_GUEST_ERROR, "Invalid bpp\n");
>> -        return;
>> +        return dst;
>
> Does this work? I think you can't return a pointer to a local so this=20
> might need to take an ATIBlitDst * and init the struct passed to it by=20
> that then it could return bool and remove the valid field from the struct=
=20
> which seems to be confusing and may be better returned directly.
>

This is returning by value, so it should. But point taken, accepting a
pointer and returning a bool avoids the valid field. I'll go that route.


