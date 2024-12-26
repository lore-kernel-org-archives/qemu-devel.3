Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15446E77188
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 23:01:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQwqz-0001XD-7S; Thu, 26 Dec 2024 18:01:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tQwqx-0001X2-Kt
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 18:01:15 -0500
Received: from fhigh-a5-smtp.messagingengine.com ([103.168.172.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1tQwqw-0006QP-5A
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 18:01:15 -0500
Received: from phl-compute-09.internal (phl-compute-09.phl.internal
 [10.202.2.49])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 92F9A1140101;
 Thu, 26 Dec 2024 18:01:13 -0500 (EST)
Received: from phl-imap-12 ([10.202.2.86])
 by phl-compute-09.internal (MEProxy); Thu, 26 Dec 2024 18:01:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1735254073;
 x=1735340473; bh=fE1bu75dsTu28qP52uJvgXyCjl8XbRzecdvNTqU15SM=; b=
 Iba4xdHeMYNdqp1qz3MbkpiS1eJpaKNsYBIU6/b/5bUoNC/fvPFAfbGvdqMmZ1bE
 1ILAoVY23zivFfz1+5w5XCB6fguPphOoTDTI1hbsRKDDEswuXzYF+PbAkpRVnV/P
 Q+Z8YVptv5vALljtoabNO7sSxhuEoVxp3+hD8ksoY43yU+OPSXDLAnMN8vTPM9E3
 5YpG3xT3KWyN/9VRsClh9Nt3y+stlAGl0FJQbtngQy1shRdXbADQp3Qq0oQ+6Qvw
 P9XyjeDO6n+11jEAEc38HlRinP0JgVpePkzXWqPWt26azvdiCUfs6LZDfe5AalfJ
 CmgjwbKzCWRyFjK26+IK2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735254073; x=
 1735340473; bh=fE1bu75dsTu28qP52uJvgXyCjl8XbRzecdvNTqU15SM=; b=M
 p5lNvKYD5H6i+KCKgGq1C32EwbuzqHfdsSOoY5yuJQ2KIWTYjAlTPg3F7tDAHMVa
 kXAxAHcJOu1+Rt0n89LYyxZ7/9TO6B/e1OPB7qlUZ30BrEV7QVO3+xN1nMQObpgL
 9pPfsCkx/0b86mN5Y3PxOLq935eqbPndD5K5uoYnOzY6sSnSoFI5SbYYrM60JqY2
 qhptEJsViq6jQRXJl0rAABTcsqAfdQkjzAcY2dRppTfZAWkx48viKwjqm15zpKwe
 ZbosV6V1jGU0OCaaVhQ9WpXC6M0RcOI21K58wDDoyUymz/haeSB4DB28sfJ1qWbv
 gSifKMhlYMtgaPhFTqHaQ==
X-ME-Sender: <xms:OeBtZ297Pk53It_xcuSl9ZN1Vy3KJVpEqjpNRRjmEZL3p24LnkTLAg>
 <xme:OeBtZ2tkyscoa354qcNh7lFNxbKI6CKTHHeWldxtfwXkfhsJw5jOJzIx8jB5uADVJ
 hpgPI8rKxVyPEez3pM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudduledgtdehucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
 necuhfhrohhmpedflfhirgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfh
 hlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepjeehfeduvddtgffgvdffkeet
 hefhlefgvdevvdekuefffeekheehgeevhfevteejnecuvehluhhsthgvrhfuihiivgepud
 enucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgr
 thdrtghomhdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtph
 htthhopehmrghrtggvlhdrrghpfhgvlhgsrghumhesghhmrghilhdrtghomhdprhgtphht
 thhopegvughurghrughosehhrggskhhoshhtrdhnvghtpdhrtghpthhtohepfigrnhhghi
 grnhgrnhehheeshhhurgifvghirdgtohhmpdhrtghpthhtohepiihhrghouddrlhhiuhes
 ihhnthgvlhdrtghomhdprhgtphhtthhopehphhhilhhmugeslhhinhgrrhhordhorhhgpd
 hrtghpthhtohepghgrohhsohhngheslhhoohhnghhsohhnrdgtnhdprhgtphhtthhopehm
 rghosghisghosehlohhonhhgshhonhdrtghnpdhrtghpthhtohepqhgvmhhuqdguvghvvg
 hlsehnohhnghhnuhdrohhrghdprhgtphhtthhopegrrhhmsghruhesrhgvughhrghtrdgt
 ohhm
X-ME-Proxy: <xmx:OeBtZ8A7aTu8uwq2T1P6g3lNYigSA-qzMWTheTqrO7OMlJLTaqRHRw>
 <xmx:OeBtZ-dcYLHmkrei0ZFEuVW4TCxEirWj3sV-iC9iPhLGigo4dysuAw>
 <xmx:OeBtZ7PctkxjCD6c8-Dd2tmLEwma4fdjU87k8ISIXFcVCYHYtgjNew>
 <xmx:OeBtZ4lmDyQRRPSQVa9hBmIzUJNZFMfoFfH8ICisEMv3Ym3XbnWDLA>
 <xmx:OeBtZ8EBqpngth_bOdy9ShkcraIPpd9NMLGSVihwPG4ARcqmFDKkUZJd>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id E940B1C20066; Thu, 26 Dec 2024 18:01:12 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Thu, 26 Dec 2024 23:00:52 +0000
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "QEMU devel" <qemu-devel@nongnu.org>
Cc: "Song Gao" <gaosong@loongson.cn>, "Bibo Mao" <maobibo@loongson.cn>,
 "Eric Blake" <eblake@redhat.com>, "Markus Armbruster" <armbru@redhat.com>,
 "Eduardo Habkost" <eduardo@habkost.net>,
 "Marcel Apfelbaum" <marcel.apfelbaum@gmail.com>,
 "Yanan Wang" <wangyanan55@huawei.com>, "Zhao Liu" <zhao1.liu@intel.com>,
 "Paolo Bonzini" <pbonzini@redhat.com>
Message-Id: <5da76fbd-90a4-4f91-b132-56d6ab3d2b4d@app.fastmail.com>
In-Reply-To: <490e3bc8-ef3b-4bec-b9c1-55706c1b3a77@linaro.org>
References: <20241226-la32-fixes1-v2-0-0414594f8cb5@flygoat.com>
 <20241226-la32-fixes1-v2-19-0414594f8cb5@flygoat.com>
 <490e3bc8-ef3b-4bec-b9c1-55706c1b3a77@linaro.org>
Subject: Re: [PATCH v2 19/23] target/loongarch: Introduce max32 CPU type
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=103.168.172.156;
 envelope-from=jiaxun.yang@flygoat.com; helo=fhigh-a5-smtp.messagingengine.com
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



=E5=9C=A82024=E5=B9=B412=E6=9C=8826=E6=97=A5=E5=8D=81=E4=BA=8C=E6=9C=88 =
=E4=B8=8B=E5=8D=8810:55=EF=BC=8CPhilippe Mathieu-Daud=C3=A9=E5=86=99=E9=81=
=93=EF=BC=9A
> On 26/12/24 22:19, Jiaxun Yang wrote:
>> Introduce max32 CPU type as it's necessary to demonstrate all
>> features we have in LA32.
>>=20
>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>> ---
>>   target/loongarch/cpu.c | 92 +++++++++++++++++++++++++++++++++++++++=
+++++++++++
>>   1 file changed, 92 insertions(+)
>
>
>>   #ifdef TARGET_LOONGARCH64
>>   static void loongarch_la464_initfn(Object *obj)
>>   {
>> @@ -923,6 +1014,7 @@ static const TypeInfo loongarch_cpu_type_infos[]=
 =3D {
>>       },
>>   #endif
>>       DEFINE_LOONGARCH_CPU_TYPE(32, "la132", loongarch_la132_initfn),
>> +    DEFINE_LOONGARCH_CPU_TYPE(32, "max32", loongarch_max32_initfn),
>
> What about "la32max"?

I'm actually thinking about "max32" for la32 and "max32r" la32r to keep =
it concise
(and somehow aligned with existing RISC-V naming).

Thanks
>
>>   #ifdef TARGET_LOONGARCH64
>>       DEFINE_LOONGARCH_CPU_TYPE(64, "la464", loongarch_la464_initfn),
>>       DEFINE_LOONGARCH_CPU_TYPE(64, "max", loongarch_max_initfn),
>>

--=20
- Jiaxun

