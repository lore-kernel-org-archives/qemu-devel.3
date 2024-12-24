Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E689E7718B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 01:17:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPtY4-0007bW-4K; Mon, 23 Dec 2024 20:17:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tPtY2-0007bJ-VV
 for qemu-devel@nongnu.org; Mon, 23 Dec 2024 20:17:22 -0500
Received: from fout-a7-smtp.messagingengine.com ([103.168.172.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tPtY1-0000nz-HI
 for qemu-devel@nongnu.org; Mon, 23 Dec 2024 20:17:22 -0500
Received: from phl-compute-09.internal (phl-compute-09.phl.internal
 [10.202.2.49])
 by mailfout.phl.internal (Postfix) with ESMTP id 179A31380139;
 Mon, 23 Dec 2024 20:17:21 -0500 (EST)
Received: from phl-imap-12 ([10.202.2.86])
 by phl-compute-09.internal (MEProxy); Mon, 23 Dec 2024 20:17:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:date
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1735003041;
 x=1735089441; bh=kf+LqcirkkBnikMqxeMiXVfFCZL7F7huiFItp9ALTAM=; b=
 cej92+8mpGuhGidxm9LE19mOFKTJrqQU3Z4ssb/yxzsaY9hrS8IvLmP3SSm4p4dO
 +HsbDh6HeBFGWruc6vjNDcAhuaTgVjP8SpGX59tw+rPgPh8FRv5qDhan6oUHnxN5
 eXILN7KxGA9fv2fDHVRbgU06qQajF+f7uoHcSIl1XVcHJ2TeLq6Ff+u431LjnOeL
 7h0y/2fCSH9wPeDHMGgN6NpyYJOcXYUZDClvM/uV8Ktu2O5Yu/C3Kft4YaVIAxH1
 NR3AsNpsXqpyD2g3fXIFzSbJYrRozE7daSz9bHDUjB+IEjafqmGfmM1/z6o8tcSZ
 tpdlOLLmXLpv/l6UL4+CZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1735003041; x=1735089441; bh=k
 f+LqcirkkBnikMqxeMiXVfFCZL7F7huiFItp9ALTAM=; b=ddcM/maGYszOPMhte
 6tm8FcAtfU7I1fFl1l6F9l3qbMrYpWa7KwYpzifc6m23Ru4ozDOVxVqbfjqY91/I
 c8Nv2PV8fg2twk8DB/Hz7sYCg1zAI8L3facr7nh4+4ys5iBA+FDgzReZVJRVVDr4
 5HWHW3/WhVyrXGz7BrzVGfBZ5BRrlgsGVMptfzlBqda7utyVdVniuN2SbiC7IPOO
 jxPKwQk9Jctltnpbhwo1RZR5eAzz1Xj8voarcQgTYfHhiU+yEuSlSQCAh4Yl0Cdw
 A90gKFGw3J7rXwJRNWOe4g2jct0kXREze4B+Ll76f3BecvhYH/dow/l1VVeepnLa
 FHlBw==
X-ME-Sender: <xms:oAtqZ2_N0TXWRSA29Nbpbw94Kbm651xVsYm1uo8EVSUQ7kPZigOc1Q>
 <xme:oAtqZ2tOMFWwdMhg0l2ffDb2DvqtP7rXblyg4G0gg4XJe3YVSirviaEadBwBCb9Jh
 QhWjAErZI0t7pAIraA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddufedgfedvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhepofggfffhvffkjghfufgtgfesthhqredtredtjeen
 ucfhrhhomhepfdflihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflh
 ihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpeejvdfgteevhfffhfduffehleei
 ieevledvieelfffggefhfeekuefhudegfeelffenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorght
 rdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtth
 hopehphhhilhhmugeslhhinhgrrhhordhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghv
 vghlsehnohhnghhnuhdrohhrgh
X-ME-Proxy: <xmx:oAtqZ8DdCbgkKBvy50OaYkxvwyj_N4cUqrvT6jkRiEmqpexXLHiyxQ>
 <xmx:oAtqZ-dWUWuZm8SNGurzws8xRrJESsv7k9KKc69XPFQI7ejiLWdubw>
 <xmx:oAtqZ7NO7XAgG4fn8TChQWBhFnLJESuvv4jpv8wm1M3o_n89_3rwAw>
 <xmx:oAtqZ4nwqZGfkLO6cq2hlYVMS-c4snR1cdF3dPOPgInD-dc4C9ArzQ>
 <xmx:oQtqZx24L37UDZlU7BvxcGfd0H2j6SqabS8emioX3jYeDSqDy1f6KsuQ>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id D0AED1C20066; Mon, 23 Dec 2024 20:17:20 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Tue, 24 Dec 2024 01:17:00 +0000
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "QEMU devel" <qemu-devel@nongnu.org>
Message-Id: <5c4cfcef-ed76-4841-9ba2-b7ddbe69ae98@app.fastmail.com>
In-Reply-To: <0a550dea-68b1-41a5-9616-5046d4577c44@linaro.org>
References: <20241222-la32-fixes1-v1-0-8c62b7e594db@flygoat.com>
 <20241222-la32-fixes1-v1-2-8c62b7e594db@flygoat.com>
 <a86f364c-58ee-4e73-8c0a-110fefc1f985@linaro.org>
 <6564d4a5-9299-4de3-99ca-ec4094b9e642@app.fastmail.com>
 <0a550dea-68b1-41a5-9616-5046d4577c44@linaro.org>
Subject: Re: [PATCH 2/3] target/loongarch: Fix LLSC for LoongArch32
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=103.168.172.150;
 envelope-from=jiaxun.yang@flygoat.com; helo=fout-a7-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



=E5=9C=A82024=E5=B9=B412=E6=9C=8823=E6=97=A5=E5=8D=81=E4=BA=8C=E6=9C=88 =
=E4=B8=8B=E5=8D=8811:18=EF=BC=8CPhilippe Mathieu-Daud=C3=A9=E5=86=99=E9=81=
=93=EF=BC=9A
> On 23/12/24 22:01, Jiaxun Yang wrote:
>>=20
>>=20
>> =E5=9C=A82024=E5=B9=B412=E6=9C=8823=E6=97=A5=E5=8D=81=E4=BA=8C=E6=9C=88=
 =E4=B8=8B=E5=8D=883:15=EF=BC=8CRichard Henderson=E5=86=99=E9=81=93=EF=BC=9A
>>> On 12/22/24 15:40, Jiaxun Yang wrote:
>>>> @@ -9,7 +9,7 @@ static bool gen_ll(DisasContext *ctx, arg_rr_i *a, =
MemOp mop)
>>>>        TCGv src1 =3D gpr_src(ctx, a->rj, EXT_NONE);
>>>>        TCGv t0 =3D make_address_i(ctx, src1, a->imm);
>>> ...
>>>> @@ -28,7 +28,8 @@ static bool gen_sc(DisasContext *ctx, arg_rr_i *a=
, MemOp mop)
>>>>        TCGLabel *l1 =3D gen_new_label();
>>>>        TCGLabel *done =3D gen_new_label();
>>>>   =20
>>>> -    tcg_gen_addi_tl(t0, src1, a->imm);
>>>> +    tcg_gen_mov_tl(t0, src1);
>>>> +    t0 =3D make_address_i(ctx, t0, a->imm);
>>>
>>> The move before make_address_i is not required.
>>> See the similar code just above in gen_ll.
>>=20
>> I think it=E2=80=99s necessary, I thought the same and end up spendin=
g hours to track down the problem.
>>=20
>> make_address_i won=E2=80=99t make a new temp_reg if imm is zero.
>
> Only if va32 =3D 0, IOW if HW_FLAGS_VA32 is not set. Per is_va32,
> VA32 =3D=3D !LA64 or VA32L[1-3]
>
> Indeed make_address_x() returns the same TCGv if !VA32 and imm=3D0.

You are right, thanks for the insight!

>
>> So when imm is 0 src1 and src2 is the same tcg reg the value will be =
clobbered by cmpxchg,
>> causing a couple of tcg tests to fail.
>
> Missing constraint or mis-designed make_address_x()?
> To KISS I'd use a temp in make_address_x() regardless of addend=3D0.

Makes sense, will incorporate in next version.

Thanks
>
>>=20
>> I think only way to ensure t0 is a new temp reg is to perform a move =
here.
>>=20
>> Thanks
>>>
>>>
>>> r~
>>

--=20
- Jiaxun

