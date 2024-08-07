Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CCE5C52D6F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 02:02:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbW00-0003c0-A4; Tue, 06 Aug 2024 22:02:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sbVzy-0003at-R7; Tue, 06 Aug 2024 22:01:58 -0400
Received: from mail-ua1-x935.google.com ([2607:f8b0:4864:20::935])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sbVzv-0007Vi-Ux; Tue, 06 Aug 2024 22:01:58 -0400
Received: by mail-ua1-x935.google.com with SMTP id
 a1e0cc1a2514c-81ff6a80cb2so352336241.3; 
 Tue, 06 Aug 2024 19:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722996113; x=1723600913; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MM2LwEVYRiLI6ZCq7jaARyWp3LJXZYJ+MMrF19hkggU=;
 b=K+23A445eTAllgon7QuLVWL6d1mhxCT35fhjhjv/NNV8g9RTsD5B0MZAj/YiJccXqX
 /0QbMsnvW5N9MD1KSw2TD37e/h4n5PH1ak/er5w8iz/nHFZckAxcfdGDMdjcghXoSk6e
 tcZgbDEEXeM+Vwh4wh67q9hMBfJUIMhlDpPS/oKQBVyYIEwPswG2yFVAo89x9hQf+2om
 LHTy6HMAu/SC6j+YyeIfKYFFcB0hDx13MD0MvO4BQyIXqyK/8llt423F3TNwBoz7RmdE
 o0yprSNrk6KmJnWasIcLUuhzCsk8UfIiOCq09ILqjPnYeuKvXLsXHWrMPwW972WAOOkg
 /YCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722996113; x=1723600913;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MM2LwEVYRiLI6ZCq7jaARyWp3LJXZYJ+MMrF19hkggU=;
 b=dzp3R0yry3qwjSF+W+RW6Nq0QlbK6X+GB6LOb7zeJGA+LWG9qqOh+JJOigoQ3p7wGz
 iHhjqSH/6dMM2jzqxbadT4m6Q9XGghJ9G+6j+VitjOkpB9mFKsmhbnyZZY60T7R07CeG
 ZEztuIxegPJX4KjoHdvBr/ly0FsEq6cIoxcDOg7+D3YSVCXBayrvZgYKEe6V1Wyq3ljt
 0nRmxfOdmz8b+BA8ph34qpdJr5R/5d2SqA7tpz7Fmfn6zROg3U/7y3mpFaIDoYtPdeCt
 CAR+iRR5Tv+S2r1C7M09qWD3nHKW4k1l4AOYeGbufUNvShB/Dzdjrt2N7Uy5rMOwXVy7
 Vr9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRGnvfMmvl4Agl/sypcjTrKHNslkdhw9zVO/i99t6QcsLKnHRsLitWLGjM/b1GlRcU0iMEXo45tP/EoolrYYCssYzoQSG2VA4Z5QcjwW6k/e1NW8peGuUfFheC8w==
X-Gm-Message-State: AOJu0YzR2H/bRo6gjX3ivDsYwjRmynSZC0/XBCbWnZpDC2/9JT63v/6K
 rhS1MkjofMCCFJeVTBLpyDrUqifChzBcpznjnlsDJh+dso/2rDwg2U02hjTWqgTtGUGOAIfd0fa
 I/6jvmWsOQGvcDGCC5UI/F2MztFw=
X-Google-Smtp-Source: AGHT+IEcxkQ9ciaeK/H5nNOswwjQf/pNy0/ibGx6tuKd3RRsPuU0ql6skvbrRdJ7dZvNKrPVqLE5w0SuvQK+8flND0Y=
X-Received: by 2002:a05:6102:41ab:b0:494:560b:6bfe with SMTP id
 ada2fe7eead31-4945bde2da4mr16844404137.9.1722996113426; Tue, 06 Aug 2024
 19:01:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240723-counter_delegation-v2-0-c4170a5348ca@rivosinc.com>
 <20240723-counter_delegation-v2-13-c4170a5348ca@rivosinc.com>
 <20240806-9fdad33468ec103d83a85e77@orel>
 <3c09bbbe-857b-4566-963a-790497232bbf@ventanamicro.com>
In-Reply-To: <3c09bbbe-857b-4566-963a-790497232bbf@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 7 Aug 2024 12:01:27 +1000
Message-ID: <CAKmqyKNgJKBFw7OnwbgbqxA65PR4GSjdUEKdKVw-nYv+e0P58w@mail.gmail.com>
Subject: Re: [PATCH v2 13/13] target/riscv: Enable PMU related extensions to
 preferred rule
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: Andrew Jones <ajones@ventanamicro.com>, Atish Patra <atishp@rivosinc.com>,
 qemu-riscv@nongnu.org, 
 qemu-devel@nongnu.org, palmer@dabbelt.com, liwei1518@gmail.com, 
 zhiwei_liu@linux.alibaba.com, bin.meng@windriver.com, 
 alistair.francis@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::935;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x935.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Wed, Aug 7, 2024 at 2:06=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
>
>
> On 8/6/24 5:46 AM, Andrew Jones wrote:
> > On Tue, Jul 23, 2024 at 04:30:10PM GMT, Atish Patra wrote:
> >> Counter delegation/configuration extension requires the following
> >> extensions to be enabled.
> >>
> >> 1. Smcdeleg - To enable counter delegation from M to S
> >> 2. S[m|s]csrind - To enable indirect access CSRs
> >> 3. Smstateen - Indirect CSR extensions depend on it.
> >> 4. Sscofpmf - To enable counter overflow feature
> >> 5. S[m|s]aia - To enable counter overflow feature in virtualization
> >> 6. Smcntrpmf - To enable privilege mode filtering for cycle/instret
> >>
> >> While first 3 are mandatory to enable the counter delegation,
> >> next 3 set of extension are preferred to enable all the PMU related
> >> features.
> >
> > Just my 2 cents, but I think for the first three we can apply the conce=
pt
> > of extension bundles, which we need for other extensions as well. In th=
ose
> > cases we just auto enable all the dependencies. For the three preferred
> > extensions I think we can just leave them off for 'base', but we should
> > enable them by default for 'max' along with Ssccfg.

Agreed

>
> I like this idea. I would throw in all these 6 extensions in a 'pmu_advan=
ced_ops'
> (or any other better fitting name for the bundle) flag and then 'pmu_adva=
nced_ops=3Dtrue'
> would enable all of those. 'pmu_advanced_ops=3Dtrue,smcntrpmf=3Dfalse' en=
ables all but
> 'smcntrpmf' and so on.
>
> As long as we document what the flag is enabling I don't see any problems=
 with it.
> This is how profiles are implemented after all.

I only worry that we end up with a huge collection of flags that users
need to decipher.

I guess with some good documentation this wouldn't be too confusing though.

Alistair

>
> With this bundle we can also use implied rule only if an extension really=
 needs
> (i.e. it breaks without) a dependency being enabled, instead of overloadi=
ng it
> with extensions that 'would be nice to have together' like it seems to be=
 the
> case for the last 3 extensions in that list.
>
> I believe users would benefit more from a single flag to enable everythin=
g and
> be done with it.
>
>
> Thanks,
>
> Daniel
>
>
>
> >
> > Thanks,
> > drew
> >
> >> That's why, enable all of these if Ssccfg extension is
> >> enabled from the commandline.
> >>
> >> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> >> ---
> >>   target/riscv/cpu.c | 14 +++++++++++++-
> >>   1 file changed, 13 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> >> index 22ba43c7ff2a..abebfcc46dea 100644
> >> --- a/target/riscv/cpu.c
> >> +++ b/target/riscv/cpu.c
> >> @@ -2665,8 +2665,20 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implie=
d_rules[] =3D {
> >>       NULL
> >>   };
> >>
> >> +static RISCVCPUPreferredExtsRule SSCCFG_PREFERRED =3D {
> >> +    .ext =3D CPU_CFG_OFFSET(ext_ssccfg),
> >> +    .preferred_multi_exts =3D {
> >> +        CPU_CFG_OFFSET(ext_smcsrind), CPU_CFG_OFFSET(ext_sscsrind),
> >> +        CPU_CFG_OFFSET(ext_ssaia), CPU_CFG_OFFSET(ext_smaia),
> >> +        CPU_CFG_OFFSET(ext_smstateen), CPU_CFG_OFFSET(ext_sscofpmf),
> >> +        CPU_CFG_OFFSET(ext_smcntrpmf), CPU_CFG_OFFSET(ext_smcdeleg),
> >> +
> >> +        RISCV_PREFRRED_EXTS_RULE_END
> >> +    },
> >> +};
> >> +
> >>   RISCVCPUPreferredExtsRule *riscv_multi_ext_preferred_rules[] =3D {
> >> -    NULL
> >> +    &SSCCFG_PREFERRED, NULL
> >>   };
> >>
> >>   static Property riscv_cpu_properties[] =3D {
> >>
> >> --
> >> 2.34.1
> >>
> >>
>

