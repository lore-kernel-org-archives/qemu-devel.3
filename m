Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04FE4C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 06:58:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOAz3-0002fw-C9; Mon, 01 Jul 2024 02:57:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sOAz0-0002fZ-Rx
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 02:57:50 -0400
Received: from fout6-smtp.messagingengine.com ([103.168.172.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1sOAyz-0002Eu-51
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 02:57:50 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailfout.nyi.internal (Postfix) with ESMTP id 698C213802A4;
 Mon,  1 Jul 2024 02:57:46 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
 by compute3.internal (MEProxy); Mon, 01 Jul 2024 02:57:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1719817066;
 x=1719903466; bh=PCZD+ZCwgI4oZeQPR59nzeQE/yjPZCP6vkk0m0ProPk=; b=
 Sh9fCU1znbHIzWrwX0Kc57lvnVhWPDIlFBkD7aspz3Hj9SrOJNvRycc3TI9Rb1a2
 OtmkCh+lDOBp4bYw3IcVpmWTbxwnWQgQJCoi1h3kLmduEqXvFXTqULY9e1aqqDRS
 TszfUiu9VpzWcLDzwG0kq5djmnO0yTRcbquvm2BFZ/rMKWVU+NDAsiwYtIowm4zc
 4MZTgytVLZEFmGirmZ7KwVQm4NvSHxW946mYntwMYGtGxy9Gxg4AgQDV1Vo94mA3
 BCVxE38xWkFn48CoUFXP6kUtTJljPxmNZJBfoa2lQ+XEY7OAcDe6qzd3l0a6kedM
 YWDn6PJ3WLaxFJDpxvwKqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1719817066; x=
 1719903466; bh=PCZD+ZCwgI4oZeQPR59nzeQE/yjPZCP6vkk0m0ProPk=; b=W
 5jairg9M88ip3JZ28yFQjBlRKIRe/4v8taX+nNPjKEtqUrS8dKzistXtBo7wXtnR
 2uSvQ7zuu/fPCyJr5qXrkjZJV0giDoW1aI0XFMhK5UoBbuBt692Gsj6Oom5oDoaR
 HcMKKt2A138kXmMaAK8mdBsXLueor3nIelamRu87bv7grsb+5Qa4F1Z5C/UEMzyf
 0CYzof0BXTUzOJY8BZRzHsLooDd3ExAq2R6B5zCFARlKkI0EMd7P0dzqOYLe9RfO
 mpzxJdFxC6pVnf/rcz//beSfUNjtagcmb0P0yit+YdWZYhgsTK7BROMN+Vms1Loo
 U2jk+BV3Xq4rH2O7dGQmg==
X-ME-Sender: <xms:alOCZtUCVTNphIxVD1tHb4EtRCboPOiQ70n42vFzAhgl3Rm8P6OBvQ>
 <xme:alOCZtmuD9ZZXk5R-M-BnGx_SdrL0_YAoEg4_aQhEQUp2IUHvuQ7KXdxvi6Wk6bB3
 ConZ6TMLbP4CRHtSGc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvgdduudefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
 ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
 hmqeenucggtffrrghtthgvrhhnpedufeegfeetudeghefftdehfefgveffleefgfehhfej
 ueegveethfduuddvieehgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
 grihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:alOCZpbAMJFxi910kGMcIKsnMLYp3nTks964JvOsaLmBhVp-ihf8Mw>
 <xmx:alOCZgUw9IFGI0pdd475sue-wzX7CEUicAGVD6G-XDhg168NrSm7Qg>
 <xmx:alOCZnm0_I5tVKHQXFvBPsiRrO9ke4prT0ABIzLJW16z0NK84Na89w>
 <xmx:alOCZtcpMLoWRlgke8T9D15EzznJwtm3j8IX5zSmwFJXA92vQWLpUQ>
 <xmx:alOCZlhT7WQJSHc3NvEGwj5qZcuczZQFrqD82yN9JJ4h0la27gwH59rm>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id E83DB36A0074; Mon,  1 Jul 2024 02:57:45 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-566-g3812ddbbc-fm-20240627.001-g3812ddbb
MIME-Version: 1.0
Message-Id: <db19ed93-027c-4e29-aac5-e3a1edcd760b@app.fastmail.com>
In-Reply-To: <20240530064941.1289573-2-maobibo@loongson.cn>
References: <20240530064941.1289573-1-maobibo@loongson.cn>
 <20240530064941.1289573-2-maobibo@loongson.cn>
Date: Mon, 01 Jul 2024 07:57:31 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Bibo Mao" <maobibo@loongson.cn>, "Song Gao" <gaosong@loongson.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: "QEMU devel" <qemu-devel@nongnu.org>
Subject: Re: [RFC v3 1/2] target/loongarch: Add loongson binary translation
 feature
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=103.168.172.149;
 envelope-from=jiaxun.yang@flygoat.com; helo=fout6-smtp.messagingengine.com
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



=E5=9C=A82024=E5=B9=B45=E6=9C=8830=E6=97=A5=E4=BA=94=E6=9C=88 =E4=B8=8A=E5=
=8D=887:49=EF=BC=8CBibo Mao=E5=86=99=E9=81=93=EF=BC=9A
> Loongson Binary Translation (LBT) is used to accelerate binary
> translation, which contains 4 scratch registers (scr0 to scr3), x86/ARM
> eflags (eflags) and x87 fpu stack pointer (ftop).
>
> Now LBT feature is added in kvm mode, not supported in TCG mode since
> it is not emulated. Feature variable lbt is added with OnOffAuto type,
> If lbt feature is not supported with KVM host, it reports error if the=
re
> is lbt=3Don command line.
>
> If there is no any command line about lbt parameter, it checks whether
> KVM host supports lbt feature and set the corresponding value in cpucf=
g.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Hi Bibo,

I was going across recent LoongArch changes and this comes into my atten=
tion:=20

> ---
>  target/loongarch/cpu.c                | 53 +++++++++++++++++++++++++++
>  target/loongarch/cpu.h                |  6 +++
>  target/loongarch/kvm/kvm.c            | 26 +++++++++++++
>  target/loongarch/kvm/kvm_loongarch.h  | 16 ++++++++
>  target/loongarch/loongarch-qmp-cmds.c |  2 +-
>  5 files changed, 102 insertions(+), 1 deletion(-)
>
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index b5c1ec94af..14265b6667 100644
> --- a/target/loongarch/cpu.c
> +++ b/target/loongarch/cpu.c
> @@ -571,6 +571,30 @@ static void loongarch_cpu_disas_set_info(CPUState=20
> *s, disassemble_info *info)
>      info->print_insn =3D print_insn_loongarch;
>  }
>=20
> +static void loongarch_cpu_check_lbt(CPUState *cs, Error **errp)
> +{
> +    CPULoongArchState *env =3D cpu_env(cs);
> +    LoongArchCPU *cpu =3D LOONGARCH_CPU(cs);
> +    bool kvm_supported;
> +
> +    kvm_supported =3D kvm_feature_supported(cs, LOONGARCH_FEATURE_LBT=
);

IMHO if there is no global states that should be saved/restored VM wise,
this should be handled at per CPU level, preferably with CPUCFG flags hi=
nt.

We should minimize non-privilege KVM feature bits to prevent hindering
asymmetry ISA system.

Thanks
- Jiaxun

--=20
- Jiaxun

