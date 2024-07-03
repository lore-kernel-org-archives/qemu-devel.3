Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29ACDC2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 07:52:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOum7-0006x8-IZ; Wed, 03 Jul 2024 03:51:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sOum5-0006wn-QO
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 03:51:33 -0400
Received: from flow6-smtp.messagingengine.com ([103.168.172.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sOum2-0003uB-Jt
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 03:51:32 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailflow.nyi.internal (Postfix) with ESMTP id 3A63C200542;
 Wed,  3 Jul 2024 03:51:27 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
 by compute3.internal (MEProxy); Wed, 03 Jul 2024 03:51:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1719993087;
 x=1720000287; bh=wDV+NbeuLCyDIwBnJzuJqfYqO95IObbl6wqyJ9lCWII=; b=
 F5lw5qp7UvpUuoMd38PQ5OXC8O7nHD1hHsv35JGjTUFM4iGIrZ/xwQ/XXkgoXPEp
 ZvNvTacLAnZZJv/RniOST0F3UgRSf/SovAqkI3t2z5/GAKRvmHj/CbSNWbLjVafH
 P5tYad/kDJOD3P2KAAvycB1juni/STvjDhl6Cp9GgKHjk1s35EdblxHqjhTE/YPS
 e3XHm54JYacOblPOhx1FkNLxzXJZVEOHByCP3E3kfbyNY7DH4edAUnzUaeICguRm
 d8+EJPFUtxg7RHMyBIDHDBrpKD88x+lpx4wTEgZu5TQVjJv6E+DNRekHUwufZSxg
 //Iohrs7xgd9k8/bKiDrsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=ifd894703.fm2; t=
 1719993087; x=1720000287; bh=wDV+NbeuLCyDIwBnJzuJqfYqO95IObbl6wq
 yJ9lCWII=; b=Nzvy7DsSEoQpQtObG/yJHbCfBZLkpcHxQ77m8wq2kMhtINuoMUT
 /4xjFBWQBxocCUTKsZQArV0ri4C72YlJ5WJp33YVHTdVs3qMRKQEHU7mCkfyg3kr
 VSBJD8hXNpx4aBXnX00TADXINQaLCHtIKj8thHZ7UcL4KmReBsVsLXDSc9rT+bNu
 LzPEIqZ7IefruDL25YFs5weC8DEoE+NYPu1EHgL349AQUz1wbPU+vuhHZX4x2OvA
 LOrokUFc/G535vrw7nt+UW4bEJGDF8qJ5RJrI4fucjKLQFlNm/EPyAmU8Ntwngpa
 F6ULZtsE13v61pI8PnR1oiRfJqcBUOdH7og==
X-ME-Sender: <xms:_wKFZuvBpaqijHa1JP2NT6oKAZE8TFLxMb8fy_9oPIlHGJI7jXMxWw>
 <xme:_wKFZjfPZmv44F7VGNvHdI1uloYj0qrpOKnEdEbnXjWM9oUxreZQ8ce1Y2o3-i16V
 AEKAMsEX0BIUUsW-hs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeigdduvdefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
 ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
 hmqeenucggtffrrghtthgvrhhnpedufeegfeetudeghefftdehfefgveffleefgfehhfej
 ueegveethfduuddvieehgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
 grihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:_wKFZpz8BcnGTcCxzU4AhkXxTddfqGicOgHOwfVrgHOOfepQrUS5Yg>
 <xmx:_wKFZpMiNGUj0EVwgovWKgjIKM97Aj6HCPmNjyrp3Q2PefaaW90bvQ>
 <xmx:_wKFZu-OCoQFw0EkdCAiibtQsHQ1AED0bTe2N_BAefnfDNQWx2eyvQ>
 <xmx:_wKFZhUyJDyQa_ggm4rCpLBIN0yXPoJ5QXLqXvoY-CfKrCSdgbWrgg>
 <xmx:_wKFZnfCYfQNQkIRusjpiSQ7LiqScnsnjsVSJTGKmMk7zr9T6y3vpLU8>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id EEBA136A0074; Wed,  3 Jul 2024 03:51:26 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-566-g3812ddbbc-fm-20240627.001-g3812ddbb
MIME-Version: 1.0
Message-Id: <60da2f5e-009d-4362-bf62-32a088b2848c@app.fastmail.com>
In-Reply-To: <db19ed93-027c-4e29-aac5-e3a1edcd760b@app.fastmail.com>
References: <20240530064941.1289573-1-maobibo@loongson.cn>
 <20240530064941.1289573-2-maobibo@loongson.cn>
 <db19ed93-027c-4e29-aac5-e3a1edcd760b@app.fastmail.com>
Date: Wed, 03 Jul 2024 15:50:50 +0800
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Bibo Mao" <maobibo@loongson.cn>, "Song Gao" <gaosong@loongson.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: "QEMU devel" <qemu-devel@nongnu.org>, chenhuacai@kernel.org
Subject: Re: [RFC v3 1/2] target/loongarch: Add loongson binary translation
 feature
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=103.168.172.141;
 envelope-from=jiaxun.yang@flygoat.com; helo=flow6-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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



=E5=9C=A82024=E5=B9=B47=E6=9C=881=E6=97=A5=E4=B8=83=E6=9C=88 =E4=B8=8B=E5=
=8D=882:57=EF=BC=8CJiaxun Yang=E5=86=99=E9=81=93=EF=BC=9A
> =E5=9C=A82024=E5=B9=B45=E6=9C=8830=E6=97=A5=E4=BA=94=E6=9C=88 =E4=B8=8A=
=E5=8D=887:49=EF=BC=8CBibo Mao=E5=86=99=E9=81=93=EF=BC=9A
>> Loongson Binary Translation (LBT) is used to accelerate binary
>> translation, which contains 4 scratch registers (scr0 to scr3), x86/A=
RM
>> eflags (eflags) and x87 fpu stack pointer (ftop).
>>
>> Now LBT feature is added in kvm mode, not supported in TCG mode since
>> it is not emulated. Feature variable lbt is added with OnOffAuto type,
>> If lbt feature is not supported with KVM host, it reports error if th=
ere
>> is lbt=3Don command line.
>>
>> If there is no any command line about lbt parameter, it checks whether
>> KVM host supports lbt feature and set the corresponding value in cpuc=
fg.
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> Hi Bibo,
>
> I was going across recent LoongArch changes and this comes into my att=
ention:=20
>
>> ---
>>  target/loongarch/cpu.c                | 53 +++++++++++++++++++++++++=
++
>>  target/loongarch/cpu.h                |  6 +++
>>  target/loongarch/kvm/kvm.c            | 26 +++++++++++++
>>  target/loongarch/kvm/kvm_loongarch.h  | 16 ++++++++
>>  target/loongarch/loongarch-qmp-cmds.c |  2 +-
>>  5 files changed, 102 insertions(+), 1 deletion(-)
>>
>> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
>> index b5c1ec94af..14265b6667 100644
>> --- a/target/loongarch/cpu.c
>> +++ b/target/loongarch/cpu.c
>> @@ -571,6 +571,30 @@ static void loongarch_cpu_disas_set_info(CPUStat=
e=20
>> *s, disassemble_info *info)
>>      info->print_insn =3D print_insn_loongarch;
>>  }
>>=20
>> +static void loongarch_cpu_check_lbt(CPUState *cs, Error **errp)
>> +{
>> +    CPULoongArchState *env =3D cpu_env(cs);
>> +    LoongArchCPU *cpu =3D LOONGARCH_CPU(cs);
>> +    bool kvm_supported;
>> +
>> +    kvm_supported =3D kvm_feature_supported(cs, LOONGARCH_FEATURE_LB=
T);
>
> IMHO if there is no global states that should be saved/restored VM wis=
e,
> this should be handled at per CPU level, preferably with CPUCFG flags =
hint.
>
> We should minimize non-privilege KVM feature bits to prevent hindering
> asymmetry ISA system.

+ Huacai for further discussion

Hi Bibo, Huacai,

I investigated the topic further and went through the thread on kernel s=
ide.

I think Huacai and me are all on the same page that we should unify the =
interface for per-CPU
level feature probing and setting interface. Huacai purposed converting =
all features to VM feature
but I still believe CPUCFG is the best interface.

To probe LBT before actual vcpu creation, we can borrow the approach use=
d by other architectures
(kvm_arm_create_scratch_host_vcpu() & kvm_riscv_create_scratch_vcpu()).

Kernel will reject setting unknown CPUCFG bits with -EINVAL, so to probe=
 LBT we just need to perform
KVM_SET_REGS to scratch vcpu with LBT set to see if it's valid for kerne=
l. There is no need for any other
probing interface.

I do think scratch CPU interface is also necessary if we are going to im=
plement cpu =3D host.

Huacai, would you agree with me?

Thanks
- Jiaxun

>
> Thanks
> - Jiaxun
>
> --=20
> - Jiaxun

--=20
- Jiaxun

