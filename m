Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23D49C30653
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 09:44:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOwWH-0002VB-S3; Wed, 03 Jul 2024 05:43:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenhuacai@kernel.org>)
 id 1sOwWF-0002Uh-Ht
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 05:43:19 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenhuacai@kernel.org>)
 id 1sOwWD-0002qI-P5
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 05:43:19 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 00CC96217E
 for <qemu-devel@nongnu.org>; Wed,  3 Jul 2024 09:43:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA3F7C2BD10
 for <qemu-devel@nongnu.org>; Wed,  3 Jul 2024 09:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1719999794;
 bh=qenc0dsP8KCDKFLK65aWg7lGsgYAgKKvK+Jgz12/h88=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=FUya/1V2T2ZxpoQ91+1hu7zVklaumQDIOVUhcjaTXdMDM36/R4keHp4PLlA5yO12k
 1fSM15Y4sjLkIczX2Eqrvn0eq6DD2ClBr3XbQD6LTqJhHLsBaz0R2CS/oLC1mjqD1C
 /PKaWjVYwbYqpEbmgcV1CP+ADWPRgDkpG9BTd7FacVsqFYQooyGInzIolNyc/dQBed
 VkBMHoRf0jsJgTNRpZKt7badw9lFlLSJcsMZCRLPAl8xb4ttGpj+6n3WwXxVvtq47B
 lLslfLhBvAmuzuuTRjJbYKqOYWt7laenWAoAAeLaVANN5oqNTadh7UMkmQOiT49s82
 kyWend8AyFwmw==
Received: by mail-lf1-f52.google.com with SMTP id
 2adb3069b0e04-52e9380add2so2048283e87.3
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 02:43:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCUIGOQ5elecMuIgIbXFnBPvHcjp0EHWtlB7hvz53ovsAwVVAuv2oVUg17YBIUAajpC6Vz9etDL30e7gbqsT/VhmgEBh1KQ=
X-Gm-Message-State: AOJu0YwV1BZLb2rMIVUvwbP4YNcIWu4AQu9t1jYgpgxE6Zi09I0Y49ut
 qqC2xjywQ5WUyjB9KNFaOa2jQKXaT0vQfliRNAzNFe3l2fywmXPtbFW/2dbIpnIaFZXKJ22lnWC
 0TJZsI1CfYWCnQPLba9CU/hFbA4M=
X-Google-Smtp-Source: AGHT+IGoOTIuIfsxB5C9W6bvnkaexg0uS0xZHItCHVslgDwpIcqmvxiSqrB4liK+nHQAg7Vdyuo/W+XvSzwgLhUb4bA=
X-Received: by 2002:a05:6512:3b84:b0:52b:c33a:aa7c with SMTP id
 2adb3069b0e04-52e82747dcamr8969654e87.65.1719999793051; Wed, 03 Jul 2024
 02:43:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240530064941.1289573-1-maobibo@loongson.cn>
 <20240530064941.1289573-2-maobibo@loongson.cn>
 <db19ed93-027c-4e29-aac5-e3a1edcd760b@app.fastmail.com>
 <60da2f5e-009d-4362-bf62-32a088b2848c@app.fastmail.com>
In-Reply-To: <60da2f5e-009d-4362-bf62-32a088b2848c@app.fastmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 3 Jul 2024 17:43:00 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4YqauX+dDFGK1oHrRjROSykkp-j0AfRD4a43Yea4qMxQ@mail.gmail.com>
Message-ID: <CAAhV-H4YqauX+dDFGK1oHrRjROSykkp-j0AfRD4a43Yea4qMxQ@mail.gmail.com>
Subject: Re: [RFC v3 1/2] target/loongarch: Add loongson binary translation
 feature
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 QEMU devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=139.178.84.217;
 envelope-from=chenhuacai@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
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

On Wed, Jul 3, 2024 at 3:51=E2=80=AFPM Jiaxun Yang <jiaxun.yang@flygoat.com=
> wrote:
>
>
>
> =E5=9C=A82024=E5=B9=B47=E6=9C=881=E6=97=A5=E4=B8=83=E6=9C=88 =E4=B8=8B=E5=
=8D=882:57=EF=BC=8CJiaxun Yang=E5=86=99=E9=81=93=EF=BC=9A
> > =E5=9C=A82024=E5=B9=B45=E6=9C=8830=E6=97=A5=E4=BA=94=E6=9C=88 =E4=B8=8A=
=E5=8D=887:49=EF=BC=8CBibo Mao=E5=86=99=E9=81=93=EF=BC=9A
> >> Loongson Binary Translation (LBT) is used to accelerate binary
> >> translation, which contains 4 scratch registers (scr0 to scr3), x86/AR=
M
> >> eflags (eflags) and x87 fpu stack pointer (ftop).
> >>
> >> Now LBT feature is added in kvm mode, not supported in TCG mode since
> >> it is not emulated. Feature variable lbt is added with OnOffAuto type,
> >> If lbt feature is not supported with KVM host, it reports error if the=
re
> >> is lbt=3Don command line.
> >>
> >> If there is no any command line about lbt parameter, it checks whether
> >> KVM host supports lbt feature and set the corresponding value in cpucf=
g.
> >>
> >> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> > Hi Bibo,
> >
> > I was going across recent LoongArch changes and this comes into my atte=
ntion:
> >
> >> ---
> >>  target/loongarch/cpu.c                | 53 ++++++++++++++++++++++++++=
+
> >>  target/loongarch/cpu.h                |  6 +++
> >>  target/loongarch/kvm/kvm.c            | 26 +++++++++++++
> >>  target/loongarch/kvm/kvm_loongarch.h  | 16 ++++++++
> >>  target/loongarch/loongarch-qmp-cmds.c |  2 +-
> >>  5 files changed, 102 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> >> index b5c1ec94af..14265b6667 100644
> >> --- a/target/loongarch/cpu.c
> >> +++ b/target/loongarch/cpu.c
> >> @@ -571,6 +571,30 @@ static void loongarch_cpu_disas_set_info(CPUState
> >> *s, disassemble_info *info)
> >>      info->print_insn =3D print_insn_loongarch;
> >>  }
> >>
> >> +static void loongarch_cpu_check_lbt(CPUState *cs, Error **errp)
> >> +{
> >> +    CPULoongArchState *env =3D cpu_env(cs);
> >> +    LoongArchCPU *cpu =3D LOONGARCH_CPU(cs);
> >> +    bool kvm_supported;
> >> +
> >> +    kvm_supported =3D kvm_feature_supported(cs, LOONGARCH_FEATURE_LBT=
);
> >
> > IMHO if there is no global states that should be saved/restored VM wise=
,
> > this should be handled at per CPU level, preferably with CPUCFG flags h=
int.
> >
> > We should minimize non-privilege KVM feature bits to prevent hindering
> > asymmetry ISA system.
>
> + Huacai for further discussion
>
> Hi Bibo, Huacai,
>
> I investigated the topic further and went through the thread on kernel si=
de.
>
> I think Huacai and me are all on the same page that we should unify the i=
nterface for per-CPU
> level feature probing and setting interface. Huacai purposed converting a=
ll features to VM feature
> but I still believe CPUCFG is the best interface.
>
> To probe LBT before actual vcpu creation, we can borrow the approach used=
 by other architectures
> (kvm_arm_create_scratch_host_vcpu() & kvm_riscv_create_scratch_vcpu()).
>
> Kernel will reject setting unknown CPUCFG bits with -EINVAL, so to probe =
LBT we just need to perform
> KVM_SET_REGS to scratch vcpu with LBT set to see if it's valid for kernel=
. There is no need for any other
> probing interface.
>
> I do think scratch CPU interface is also necessary if we are going to imp=
lement cpu =3D host.
>
> Huacai, would you agree with me?
For me the important thing is consistency, all vm-features or all
vcpu-features are both accepted.

Huacai

>
> Thanks
> - Jiaxun
>
> >
> > Thanks
> > - Jiaxun
> >
> > --
> > - Jiaxun
>
> --
> - Jiaxun

