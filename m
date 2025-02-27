Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AAD3C021BE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 12:37:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnd8O-0001qk-Cg; Thu, 27 Feb 2025 07:37:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tnd82-0001hx-UF
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 07:36:41 -0500
Received: from fout-a8-smtp.messagingengine.com ([103.168.172.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tnd80-0000DN-HF
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 07:36:38 -0500
Received: from phl-compute-03.internal (phl-compute-03.phl.internal
 [10.202.2.43])
 by mailfout.phl.internal (Postfix) with ESMTP id 48DEF1382F4B;
 Thu, 27 Feb 2025 07:36:35 -0500 (EST)
Received: from phl-imap-12 ([10.202.2.86])
 by phl-compute-03.internal (MEProxy); Thu, 27 Feb 2025 07:36:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1740659795;
 x=1740746195; bh=b1ZQjfik2KGx8Hlwa0iN4YPYjkYWDlBbV4rSMQe3Edc=; b=
 T0FCov3x4cJIGL09EvRwg991S/piB4HWXb0SoWB28awX4xsOIT5Erk3gtayfjBNh
 W/qoCnge6UZN4aCT3vOKDj6DpdRM3yntjkXjXkLXXaapJrC4glCWhbtSa6Oe/Zp9
 Gnh8TR7digVBt6Q539l58AcwVpQnfDH6GQfTzSKRT5DJNU/zcP4yAf9btXPRLH4j
 TzwXX1zXs0c9/QLDvUjs8gRyCiFMt1OZvWX7kLjMZx5ST1fK8bXhzyQZLRtWu9/J
 H6CEdY+QV47zOPp+Ef2CePsXUKEn/USijaCrAGvQgyudM7XKHPY9kbzKMeHyoogA
 Qnk9WD70pDUyZyDr1s/bUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740659795; x=
 1740746195; bh=b1ZQjfik2KGx8Hlwa0iN4YPYjkYWDlBbV4rSMQe3Edc=; b=0
 2oCNJQWzC6FmTR1JIKptcI8FRBUVtN042NzNlos3I88Ggc5gyPAvL3Dt2B6B4CHM
 3e1tWZreITThIDaR/M+1VNI4gc1IdnJXfqWZl7D0c9DI873xo2htci0/k+mYXMBm
 CoIRAHBCl0DuXwkT+9X/3xy0oUH7rfpt3m3OL+jurGOwEOR0lIAC3LzquzSLFXoy
 S01gFMcJn1AqXANmb0Mra86ImLyA6TqUgK9oxXmyQa5wn6wmGet4zKeQfOiyv6iz
 Pcyu+UCTzCgFIXJ1qOoXHiH7DHzfhehRhMnDr4fP+rXJDazwsj5XHsOg1BFEvTfC
 Ymne6YoJ0r1yt445NRSqA==
X-ME-Sender: <xms:UlzAZ7f0caF3q8nNeDtVuQg6gQiJiYoaLCH6QBF8BMbPCoqV_Smcdg>
 <xme:UlzAZxO4C7IFv-of8Wea_M-WjU16k6WdChiUdJGsbLyz6VIn3miIp-e3aP-V01Da1
 mYL9NkN-Q3EZmTEB_4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekjeegjecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
 jeenucfhrhhomhepfdflihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgse
 hflhihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpeevueffteefkeehhfdthfel
 feffjedvffekgfeiuedugeekgeejvedtffeiledtueenucffohhmrghinhepghhithhhuh
 gsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
 mhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomhdpnhgspghrtghpthhtoh
 epgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhlmhgusehlihhnrghr
 ohdrohhrghdprhgtphhtthhopehgrghoshhonhhgsehlohhonhhgshhonhdrtghnpdhrtg
 hpthhtohepmhgrohgsihgsoheslhhoohhnghhsohhnrdgtnhdprhgtphhtthhopehqvghm
 uhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
X-ME-Proxy: <xmx:UlzAZ0jKQnl3qK-tVlZXTNldL3yvwnVeu59znXfqyxXuxcoG0gEb1w>
 <xmx:UlzAZ888cNJdqqUMO0Yj119kNJZUz3CzeKwurCz62GD58LiVOU5mAQ>
 <xmx:UlzAZ3uigz3WkRT6Z0SD-kzKg0HioRf5RkhY8lPBrGgUbEKXS1dXzw>
 <xmx:UlzAZ7FMUWmozV8K8PR4l3qDkPk9a3lpHHFRD9GLOkeQJu6H2OQddA>
 <xmx:U1zAZ3I3WvyNd46lRsYccroiKoskyqHKhQEdicxqtHqH90acT5yHj9wJ>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id A5B941C20066; Thu, 27 Feb 2025 07:36:34 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Thu, 27 Feb 2025 12:36:15 +0000
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Bibo Mao" <maobibo@loongson.cn>, "QEMU devel" <qemu-devel@nongnu.org>
Cc: "Song Gao" <gaosong@loongson.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Message-Id: <ac8df425-6aae-4297-ab97-f5d3488b73b0@app.fastmail.com>
In-Reply-To: <9c3dd441-97bc-6884-9863-371fb23441b0@loongson.cn>
References: <20250225-la32-fixes1-v2-0-8ec68ada3dd5@flygoat.com>
 <3fd27fd1-b976-2705-7093-aecc6ffa0438@loongson.cn>
 <23d25d66-07f4-454b-903a-f5704e1e686c@app.fastmail.com>
 <baa9614a-a216-58bb-3bce-d56da0c7f287@loongson.cn>
 <b3aa056b-cde8-4f4f-879a-70b1c10e6824@app.fastmail.com>
 <9c3dd441-97bc-6884-9863-371fb23441b0@loongson.cn>
Subject: Re: [PATCH v2 0/9] target/loongarch: LoongArch32 fixes 1
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=103.168.172.151;
 envelope-from=jiaxun.yang@flygoat.com; helo=fout-a8-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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



=E5=9C=A82025=E5=B9=B42=E6=9C=8827=E6=97=A5=E4=BA=8C=E6=9C=88 =E4=B8=8B=E5=
=8D=8812:21=EF=BC=8Cbibo mao=E5=86=99=E9=81=93=EF=BC=9A
[...]
>>>>                           int pin.
>>> Thanks for the information, Would you like to emulate LoongArch32
>>> chiplap FPGA board in qemu side or other LoongArch32 boards?
>>=20
>> My plan is to use current virt machine (with EXTIOI and so on) for
>> LoongArch32, it is trivial to bring up in kernel and give us a lot mo=
re
>> flexibility rather than emulating an actual board.
> virt machine is mainly for kvm board. If it is used as LoongArch32=20
> board, there is no much benefit to add bunch of code in kernel and qem=
u=20
> to emulate non-exist board, on the contrast it is hard to maintain.

Actually, it's 8 lines of code machine level code in my local tree to br=
ing
up. Adding a new board will increase maintain burden as well. Also to no=
te
that LoongArch32 TCG work is also for qemu user.

riscv32, arm32 are all sharing same virt board as well. QEMU is not only
serving KVM but also other users trying to evaluate and test on the plat=
form.

For kernel drivers are already here, still, just a couple of Kconfig cha=
nges,
you can preview here [1].

>
> In LoongArch community There are many cases posting code in one time,=20
> disappear and lose maintenance :(

Yep, for hobbyists it's hard to sustain our effort :-( we are all trying
our best to contribute. I can potentially spare more time in Q2 to make
everything work.

Thanks

[1]: https://github.com/FlyGoat/linux/tree/b4/la32
--=20
- Jiaxun

