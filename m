Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB228C369D1
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 11:10:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7uT9-0001Wt-8p; Thu, 24 Apr 2025 07:10:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1u7uT6-0001WB-ID
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 07:10:12 -0400
Received: from fhigh-a4-smtp.messagingengine.com ([103.168.172.155])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1u7uT3-00030z-ML
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 07:10:12 -0400
Received: from phl-compute-06.internal (phl-compute-06.phl.internal
 [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 8737411402CC;
 Thu, 24 Apr 2025 07:10:06 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
 by phl-compute-06.internal (MEProxy); Thu, 24 Apr 2025 07:10:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1745493006;
 x=1745579406; bh=g5rDVS+7jyN1e95FDisPewqAYrozrdACMW3cvM4+IwI=; b=
 OAWrR1yafQ3Gq463KbOVaNoO1yIV5+9ySEZIM0DwNWX0GxRd98c+HfpzhJKxv9pk
 St4Zia0xCtEGqKGkGlEzf9D26+4zRCG61/PB3GOPv9/DZdmMwiNoakocirjDM8Q4
 ui1ivjJ6OG6lsvXzgJ4qTsFhyNca4XNIkPBkjRQ4PFmXLYQeU0QM17kZg+dIYTcL
 /+Fw7pyZ//B8ecgibktgrABTIWcMlInaoEkABaiAkZxZljjn1r884VigEIMO5A5/
 V6sc6L/wSdimv4FtXKu60oXAyCM0Y5ibGU98SA5Ngn841icwmSEbDZgCYNIiss7Z
 Sfh04ISFktE0LnmIet86zg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1745493006; x=
 1745579406; bh=g5rDVS+7jyN1e95FDisPewqAYrozrdACMW3cvM4+IwI=; b=W
 xPf1/U2nbC0llruwFnpcufz3vzi+Xae/mbLYdLZV3I55QNLh/BmCjxnMIx1OQnQx
 nPp837duPAUJ4WKCFPjvp5VCGjqd5wYE7BWE0oMTs+Rk/rmK0u8IveplmiZCCRuH
 t6MBsiIy93slshkuJRNukGORfrDWw97IV740pFb3XO0UiFRMU/ZU/JDAz9Hp8F0i
 rjKbehBsPtRcBShbnU3ffaI1uiIBwY+6jelIZx4Syy9E44sf8glDg3OVYaOZpoKQ
 yEkfzVYz2pPHwokng3R8yZmqbpk2Tuv6Ym7m/jUxIHiBkcv+pM746UTx1mr7Lx82
 kG0RK/agRMao6TMcR1spA==
X-ME-Sender: <xms:DRwKaAjaIFfN8ki6eM8b7920rmEg2odDUJfm1kWKHEydnQjslj5lOw>
 <xme:DRwKaJAhNtSy2Jq0K0llP4fI1SnrYzSryd51fX9LbVfPCl2DcljJHLTBNlh3OSxqg
 gYSDaGa3_g4_ZRug8c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeelfeduucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
 gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertder
 tdejnecuhfhrohhmpedflfhirgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghngh
 esfhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepjeehfeduvddtgffgvdff
 keethefhlefgvdevvdekuefffeekheehgeevhfevteejnecuvehluhhsthgvrhfuihiivg
 eptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihg
 ohgrthdrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtg
 hpthhtohepqhgvmhhusehhvghvrdgttgdprhgtphhtthhopehphhhilhhmugeslhhinhgr
 rhhordhorhhgpdhrtghpthhtoheprhhitghhrghrugdrhhgvnhguvghrshhonheslhhinh
 grrhhordhorhhgpdhrtghpthhtohepghgrohhsohhngheslhhoohhnghhsohhnrdgtnhdp
 rhgtphhtthhopehmrghosghisghosehlohhonhhgshhonhdrtghnpdhrtghpthhtohepfi
 grnhhgrhhuiheslhhoohhnghhsohhnrdgtnhdprhgtphhtthhopehqvghmuhdquggvvhgv
 lhesnhhonhhgnhhurdhorhhg
X-ME-Proxy: <xmx:DRwKaIECVMXh7s_gfCgkt3u4gC46UxoFnbowNm5g7B45rKG84_6--g>
 <xmx:DRwKaBRj1PB0N98qPiGcs-0nbxi0j-3COGdMr5GXwgQfiW2K0Z-u7A>
 <xmx:DRwKaNzrJUbUaCPQoM8fq9-fgQVYmN6ZgidnICzQON6NYZJY3B0tFA>
 <xmx:DRwKaP6ww6cGQAXnlQHiaHxJvgR6SJbTUbiglIGlCOc1uGybaoVn_w>
 <xmx:DhwKaFR0wBbp5NFCo9TZzVOxizJQIP5kO9_Y1Ci0-J9frs7Fdyh6uR5_>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id B45341C20067; Thu, 24 Apr 2025 07:10:05 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: T892dc7da7e43a30d
Date: Thu, 24 Apr 2025 12:09:45 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "WANG Rui" <wangrui@loongson.cn>, "Bibo Mao" <maobibo@loongson.cn>
Cc: gaosong <gaosong@loongson.cn>, "QEMU devel" <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, qemu@hev.cc,
 "Richard Henderson" <richard.henderson@linaro.org>
Message-Id: <30b01dca-b24f-4317-9c86-985bf0d4d569@app.fastmail.com>
In-Reply-To: <CAHirt9g8JcGhycVcw7-u6iaNPFonZhHY1kQGK+R7G2icFPQabA@mail.gmail.com>
References: <20250418082103.447780-1-wangrui@loongson.cn>
 <20250418082103.447780-4-wangrui@loongson.cn>
 <56cfe883-2de5-43f6-67db-a05d88a010e9@loongson.cn>
 <a395f6aa-c623-ba7d-2952-5b7249144ba8@loongson.cn>
 <CAHirt9gZEoTi4dnf69Pe0ZWAxFfn3La0=tcGESoATn1WaF4etg@mail.gmail.com>
 <446f7813-4d26-91c7-0baa-098b5c5eb2b0@loongson.cn>
 <CAHirt9jbrmTWgRHBYZAN2t_tzF9CJ86Z_=9XxPpkQYbj7WTqzw@mail.gmail.com>
 <806baf17-7d22-0d5e-f4a4-22f5ecd36ac0@loongson.cn>
 <CAHirt9g8JcGhycVcw7-u6iaNPFonZhHY1kQGK+R7G2icFPQabA@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] target/loongarch: Guard 64-bit-only insn
 translation with TRANS64 macro
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=103.168.172.155;
 envelope-from=jiaxun.yang@flygoat.com; helo=fhigh-a4-smtp.messagingengine.com
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



=E5=9C=A82025=E5=B9=B44=E6=9C=8824=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=
=8D=885:28=EF=BC=8CWANG Rui=E5=86=99=E9=81=93=EF=BC=9A
[...]
>>
>> Hardware manual from official public website should be published at
>> first, and SW follows this, rather than informal HW with FPGA version=
 only.
>
> I agree with your point - the ISA specification should come first, and
> software should follow. That=E2=80=99s exactly why I think it's meanin=
gful to
> handle this case properly in QEMU now.
>
> According to the latest version of the LoongArch ISA specification
> that I have access to, LSX and LASX are explicitly allowed to be
> implemented on LA32, with only a few instructions restricted to LA64
> due to 64-bit GPR transfers. So the idea of supporting LSX/LASX on a
> 32-bit target isn't based on any private or unofficial hardware - it=E2=
=80=99s
> aligned with what's permitted by the official spec.
>
> From this perspective, what we're doing in QEMU is not following any
> informal implementation, but rather respecting and staying compatible
> with the ISA as officially defined.

I second this. Anything combination permitted by ISA specification should
be emulated by QEMU, not only the thing implemented by Loongson hardware
currently. That can actually reduce software maintenance burden by catch=
ing
issues beforehand.

Bear in mind that LoongArch is an open specification, which means other
implementer are free to do whatever they want permitted by ISA spec.

Thanks

>
> Anyway, thanks for the discussion - good to hear different perspective=
s on this.
>
> Regards,
> Rui
>


--=20
- Jiaxun

