Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DB24E7718B
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2024 00:12:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tS3OJ-0001zq-KV; Sun, 29 Dec 2024 19:12:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tS3OH-0001zd-MQ; Sun, 29 Dec 2024 19:12:13 -0500
Received: from fhigh-a3-smtp.messagingengine.com ([103.168.172.154])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tS3OC-0004aj-7F; Sun, 29 Dec 2024 19:12:13 -0500
Received: from phl-compute-09.internal (phl-compute-09.phl.internal
 [10.202.2.49])
 by mailfhigh.phl.internal (Postfix) with ESMTP id C8D0E11400E2;
 Sun, 29 Dec 2024 19:12:05 -0500 (EST)
Received: from phl-imap-12 ([10.202.2.86])
 by phl-compute-09.internal (MEProxy); Sun, 29 Dec 2024 19:12:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1735517525;
 x=1735603925; bh=1wVXhwvI7lPRZ0mV79/62Z70AUfkc2QcLHuKiOezp2E=; b=
 DlygMASJ0WQvwzaqzEAgK426eBd1clHcr9QKj8c/UlI8mptb6Cp0cQaP7zUYg8pX
 ohYc/O7Gd6tM2sC+heyl+uu2P8+AqMiTnL0hWVnzu1mFkI36VnokgAECADNTKMRW
 TPXFxlhSQKa7DJ0JouiUnbq38o68SzshlREaJ+ltXUKQGgZGz9pErXwxqWM+v7xz
 MLxMMSsngp70Lb/Vw2i7hGXsQu/768s434iqWXfq6CUCT64UwHYOd3AVivOMQ7Fi
 S5PlyxohOVOZ4SxJe+xwi5qsfc9U9N3e2FQX0ZvWgJVxEtmEbPOt6fwgaimkOwdH
 Ac+w9PG2+VW60nn989oWqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735517525; x=
 1735603925; bh=1wVXhwvI7lPRZ0mV79/62Z70AUfkc2QcLHuKiOezp2E=; b=q
 8aeN+eEIG3M6arFePzkoljB1w7LKzRR6x68MAHo9Kg0jLnKTrKAakdtHZKvTdKm5
 zy0AbZI1R1wQp451DPqBSXB3comW1/VONcx/qFizEbHAsNTz+xKUVjqXJBMiLaTR
 l/EbB/e9sDu5pm5TPYWe+4Dwa4Ep0zTulh5jLhaOu/Nq9wYpgP7ThJqoOijOBByG
 oWKHAqghLGXj9eXm+oN1h0XyGS4iAHcvkAHrw4IQs0POGW5V4DWAC4sfW37B7iJ9
 VwrVwnenLxd2hhRXjuwWBHSaqmdF2Lt9Q7+ZPwqRKbRSi13Jq/z51kYmHdbqHhlY
 D/B3GigRIpF5OmLtGxeEQ==
X-ME-Sender: <xms:VeVxZ4yiUBSCvtBxn6SbLQFm-wN_W-PG4hj0ekIgJF6NQci2Fl6jlA>
 <xme:VeVxZ8QZZaEPoSRPGRQKp8naHl7O7lMrp1BLeoB8r-jIwIW5dl5TLHbYYjy0KKIhu
 BcS3lSs-PTNtpzqI8Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvhedgvddtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
 necuhfhrohhmpedflfhirgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfh
 hlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepffekveettdeuveefhfekhfdu
 gfegteejffejudeuheeujefgleduveekuddtueehnecuffhomhgrihhnpehkvghrnhgvlh
 drohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
 pehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmpdhnsggprhgtphhtthhope
 eipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsrghlrghtohhnsegvihhkrdgs
 mhgvrdhhuhdprhgtphhtthhopegrlhgvgidrsggvnhhnvggvsehlihhnrghrohdrohhrgh
 dprhgtphhtthhopehrihgthhgrrhgurdhhvghnuggvrhhsohhnsehlihhnrghrohdrohhr
 ghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpth
 htohepqhgvmhhuqdhsthgrsghlvgesnhhonhhgnhhurdhorhhgpdhrtghpthhtoheplhgr
 uhhrvghnthesvhhivhhivghrrdgvuh
X-ME-Proxy: <xmx:VeVxZ6VoQj3p26Js_t-YQ82IhhY9_WW0MEdXCUoNRfC0LzkpdRzuEA>
 <xmx:VeVxZ2g4SpKQKoG7xq26_EQLe2Ty_o9vfRme0KEn6TmpKtPIQPx7HA>
 <xmx:VeVxZ6A4a2QFPZw7JkUOZa5MMH4WR_s1YppMY_bMXtGpD81bxaVjEw>
 <xmx:VeVxZ3J47Yq32IzRlLzoCv2bM2NK3jS_LNYpfG6q9SmYcwyKTXrVzg>
 <xmx:VeVxZx69YF5QM-HHAKCHqGd5ZDoDodGl8nZ9w_HgmAv-TSZdrOg2iZtG>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id EB9B61C20066; Sun, 29 Dec 2024 19:12:04 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Mon, 30 Dec 2024 00:10:55 +0000
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: "QEMU devel" <qemu-devel@nongnu.org>, "Laurent Vivier" <laurent@vivier.eu>,
 "Richard Henderson" <richard.henderson@linaro.org>, qemu-stable@nongnu.org
Message-Id: <d3dceda8-9e91-43c3-94cd-0f8a7abc8189@app.fastmail.com>
In-Reply-To: <07223b0a-0140-a074-e2b2-b9fbcbfd4de0@eik.bme.hu>
References: <20241229-m68k-semihosting-v2-1-8a08b2d199a5@flygoat.com>
 <4e51180d-9f2a-c778-13b7-5130ad4d660c@eik.bme.hu>
 <87pllav3d1.fsf@draig.linaro.org>
 <07223b0a-0140-a074-e2b2-b9fbcbfd4de0@eik.bme.hu>
Subject: Re: [PATCH v2] target/m68k: Handle EXCP_SEMIHOSTING for m68k class CPU
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=103.168.172.154;
 envelope-from=jiaxun.yang@flygoat.com; helo=fhigh-a3-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



=E5=9C=A82024=E5=B9=B412=E6=9C=8829=E6=97=A5=E5=8D=81=E4=BA=8C=E6=9C=88 =
=E4=B8=8B=E5=8D=8810:30=EF=BC=8CBALATON Zoltan=E5=86=99=E9=81=93=EF=BC=9A
> On Sun, 29 Dec 2024, Alex Benn=C3=A9e wrote:
>> BALATON Zoltan <balaton@eik.bme.hu> writes:
>>
>>> On Sun, 29 Dec 2024, Jiaxun Yang wrote:
>>>> EXCP_SEMIHOSTING can be generated by m68k class CPU with
>>>> HALT instruction, but it is never handled properly and cause
>>>> guest fall into deadlock.
>>>>
>>>> Moving EXCE_SEMIHOSTING handling code to common do_interrupt_all
>>>> routine to ensure it's handled for both CPU classes.
>>>>
>>>> Fixes: f161e723fdfd ("target/m68k: Perform the semihosting test dur=
ing translate")
>>>> Cc: qemu-stable@nongnu.org
>>>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>>>> ---
>>>> Changes in v2:
>>>> - hoist both calls to do_interrupt_all (Richard)
>>>> - Link to v1: https://lore.kernel.org/r/20241229-m68k-semihosting-v=
1-1-db131e2b5212@flygoat.com
>>>> ---
[...]
>>
>>  12 candidates:
>>  ./op_helper.c:200:        switch (cs->exception_index) {
>>  ./op_helper.c:211:    vector =3D cs->exception_index << 2;
>>  ./op_helper.c:217:                 ++count, m68k_exception_name(cs->=
exception_index),
>>  ./op_helper.c:266:        cpu_stw_mmuidx_ra(env, *sp, (format << 12)=
 + (cs->exception_index << 2),
>>  ./op_helper.c:283:        switch (cs->exception_index) {
>>  ./op_helper.c:291:    vector =3D cs->exception_index << 2;
>>  ./op_helper.c:297:                 ++count, m68k_exception_name(cs->=
exception_index),
>>  ./op_helper.c:322:    switch (cs->exception_index) {
>>
>> So I'm not sure splitting a case makes it easier to follow. Exceptions
>> are under the control of the translator - is it possible to re-factor
>> the code to keep the switch of all cs->exception_index cases in one
>> place and assert if the translator has generated one it shouldn't hav=
e?

I'm not really deep in this port but I think it's pretty hard to determi=
ne
a proper way to do assertion, we have some exceptions that should only be
handled when !is_hw, some should be handled both case, and the switch at
end of handling function have a default clause which makes it even harder
to determine a valid range.

>
> Looks like there are two versions of *_interrupt_all, one for ColdFire=
 and=20
> one for older m68k. The SEMIHOSTING and RTE exceptions are handled at =
the=20
> beginning but m86k only handled RTE so far. Both of the versions are=20
> called from do_interrupt_all so moving this switch there with both cas=
es=20
> would add SEMIHOSTING to m68k as well which is I think what this patch=20
> tries to do. So you'd need to move the whole switch with both cases no=
t=20
> just the SEMIHOSTING one to do_interrupt_all. At least if I understand=
 it=20
> correctly but maybe I also got lost and did not follow this closely so=
 I=20
> could be wrong.

Yes, in PATCH v1 I attempted to just add semihosting to m68k case and Ri=
chard
suggested that I can move whole semihosting block to do_interrupt_all.

You can't move rte to do_interrupt_all as the handling function is diffe=
rent
for coldfire and m68k.

IMO PATCH v1 is the best to move forward without doing anything awkward.

This is breaking picolibc's CI and I think a quick fix that can be easily
backported to stable would be helpful.

Thanks

>
> Regards,
> BALATON Zoltan
>
>>>> +        }
>>>> +    }
>>>>     if (m68k_feature(env, M68K_FEATURE_M68K)) {
>>>>         m68k_interrupt_all(env, is_hw);
>>>>         return;
>>>>
>>>> ---
>>>> base-commit: 2b7a80e07a29074530a0ebc8005a418ee07b1faf
>>>> change-id: 20241229-m68k-semihosting-2c49c86d3e3c
>>>>
>>>> Best regards,
>>>>
>>
>>

--=20
- Jiaxun

