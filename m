Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E90AFE7718B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2024 21:02:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPpYp-00072L-7k; Mon, 23 Dec 2024 16:01:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tPpYn-000727-Bz
 for qemu-devel@nongnu.org; Mon, 23 Dec 2024 16:01:53 -0500
Received: from fout-a4-smtp.messagingengine.com ([103.168.172.147])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tPpYl-0006A0-4x
 for qemu-devel@nongnu.org; Mon, 23 Dec 2024 16:01:53 -0500
Received: from phl-compute-09.internal (phl-compute-09.phl.internal
 [10.202.2.49])
 by mailfout.phl.internal (Postfix) with ESMTP id 574B5138012D
 for <qemu-devel@nongnu.org>; Mon, 23 Dec 2024 16:01:46 -0500 (EST)
Received: from phl-imap-12 ([10.202.2.86])
 by phl-compute-09.internal (MEProxy); Mon, 23 Dec 2024 16:01:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:date
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1734987706;
 x=1735074106; bh=sVW+n1yVfEO6yQdZHW029iSFYs5nchi2RfwEJwuPeRg=; b=
 ld28YMP9vHwaeonTYdyd4RmZo3tCDSLQvb3eVEJNYIJ9PpRA0+Txpw9+GqZ9acv3
 X10cfucz8X654TVZdr0+5cDCSNP6iPBOZ7S9QbNVR0mK7RcVkrBzQfQe/pyyU9VZ
 dprDaWF29jtcrOqI3epaM26Sr3ATKhOxi3ZHPjFLaGkPXxa1Jz+7GQMzMd1MrYit
 kwnvHvqaRGwOjrruERpnBO261glvyiYxki8e4ale7XUV6gS7rtWejgG0vzZK8+qn
 LPuXIgmELRuEk0WHdl/4Am7XbnrZVPPlZRCgoDLfKGoe5v9/zLtXmBB4+Ffps32+
 nmCsKiI2UHnzcyzj88PEZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1734987706; x=1735074106; bh=s
 VW+n1yVfEO6yQdZHW029iSFYs5nchi2RfwEJwuPeRg=; b=BQ2sitdRGQuxgrxMn
 Yx4l3a/8IdsLT0mziCvAETKwKCy9eXQkGxuxYtwjwnl9SB3eZ7gPW4n/UwJYY11F
 UGnHdlQ2+hzaPiOj8gHeD3HqOBHjCshwMcPwt73SA2LHTIcJ6EFkR913c863rHaW
 s4tykgioKwt3uCWsZmNzfW+oyX6OmwiC/j3RLIarAAP1lzQn5jZxfGn19F1ZOq44
 rPuPyvR3TxMM1dHFedqqBKzCjSAAh49qUC6271AH7tkR6+IsgQPTzEdJqfxYnXRT
 x04zMB8yLb7qK0pE2V7iw2xHshuo6X35nHwSor9xfW1RYgeqd91GzanoX72/Nw0t
 CnOGw==
X-ME-Sender: <xms:uc9pZzXww8Xtww9LvHvUFqPqhiJoL6sw6kyaY5Dg-BgC9d2VaCGAdw>
 <xme:uc9pZ7kAD-0yzJScZiY4CkKV9hfSkEzKseX6v4cJoUKE9DiJod6hFBUa6bMRvpa6K
 0VZLz4xQk9_QjSUjzo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudduvddgkedtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhepofggfffhvffkjghfufgtgfesthhqredtredtjeen
 ucfhrhhomhepfdflihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflh
 ihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpeejvdfgteevhfffhfduffehleei
 ieevledvieelfffggefhfeekuefhudegfeelffenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorght
 rdgtohhmpdhnsggprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtth
 hopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
X-ME-Proxy: <xmx:us9pZ_bc9XlAAiiadPOHJLw4UtRv6M1-c2nxGIsrYsiUqBL0XCVijA>
 <xmx:us9pZ-WE3x1KSws3XUwcwBMl6p_HMAkiMQJZvvJrT7aCDnmYILThKg>
 <xmx:us9pZ9kX8d4P6Jq-xV36RasxcNl_-LO2t9NbQ_gLZoN0VyP0WQD7_Q>
 <xmx:us9pZ7e5BjMZg3tkUZcXQoze_YvlyiqY8MT6fSrXk6ESJzD4CXgNBg>
 <xmx:us9pZ8tiyU6aM1rD2V5qWY5tBUnXKnectfDmEAQL3vgIdxwg-NSYzg5H>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id DEE4E1C20066; Mon, 23 Dec 2024 16:01:45 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Mon, 23 Dec 2024 21:01:24 +0000
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "QEMU devel" <qemu-devel@nongnu.org>
Message-Id: <6564d4a5-9299-4de3-99ca-ec4094b9e642@app.fastmail.com>
In-Reply-To: <a86f364c-58ee-4e73-8c0a-110fefc1f985@linaro.org>
References: <20241222-la32-fixes1-v1-0-8c62b7e594db@flygoat.com>
 <20241222-la32-fixes1-v1-2-8c62b7e594db@flygoat.com>
 <a86f364c-58ee-4e73-8c0a-110fefc1f985@linaro.org>
Subject: Re: [PATCH 2/3] target/loongarch: Fix LLSC for LoongArch32
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=103.168.172.147;
 envelope-from=jiaxun.yang@flygoat.com; helo=fout-a4-smtp.messagingengine.com
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
=E4=B8=8B=E5=8D=883:15=EF=BC=8CRichard Henderson=E5=86=99=E9=81=93=EF=BC=9A
> On 12/22/24 15:40, Jiaxun Yang wrote:
>> @@ -9,7 +9,7 @@ static bool gen_ll(DisasContext *ctx, arg_rr_i *a, Me=
mOp mop)
>>       TCGv src1 =3D gpr_src(ctx, a->rj, EXT_NONE);
>>       TCGv t0 =3D make_address_i(ctx, src1, a->imm);
> ...
>> @@ -28,7 +28,8 @@ static bool gen_sc(DisasContext *ctx, arg_rr_i *a, =
MemOp mop)
>>       TCGLabel *l1 =3D gen_new_label();
>>       TCGLabel *done =3D gen_new_label();
>>  =20
>> -    tcg_gen_addi_tl(t0, src1, a->imm);
>> +    tcg_gen_mov_tl(t0, src1);
>> +    t0 =3D make_address_i(ctx, t0, a->imm);
>
> The move before make_address_i is not required.
> See the similar code just above in gen_ll.

I think it=E2=80=99s necessary, I thought the same and end up spending h=
ours to track down the problem.

make_address_i won=E2=80=99t make a new temp_reg if imm is zero.=20

So when imm is 0 src1 and src2 is the same tcg reg the value will be clo=
bbered by cmpxchg,=20
causing a couple of tcg tests to fail.

I think only way to ensure t0 is a new temp reg is to perform a move her=
e.

Thanks
>
>
> r~

--=20
- Jiaxun

