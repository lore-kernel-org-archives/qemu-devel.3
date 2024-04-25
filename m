Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC9B1C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 16:47:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s02Fh-0002qw-N9; Thu, 25 Apr 2024 12:47:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1s02Fd-0002kQ-68
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 12:47:14 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1s02Fb-0003bv-Fn
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 12:47:12 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2dd64d6fe94so13756791fa.0
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 09:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714063626; x=1714668426; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LvYoBl//K1mZp4n6gQiTJLEv0WK6YOM1tJ/Mw67+Cpg=;
 b=X75ofx0eO8eI5M2rh4EIu4fhRUdbADLEuiaD/zC14hQ2mjVh4eQc2Fek/CHXBhz2q3
 U3jKBe4CwEj1055rCJiwmQNBxjokVYS9DDQwaZx9gArHsIxLKuHp78F8LqOCtEamoN9b
 /7AA7udHBTe3V5ABonysYG4jh3ahx42zo8ngzxS48PYMnOMidwFyNibYHRIMgjqFaj5p
 V/ybLEweNCw8cO1WIUp5NlNSc+20firYSMXzfpwt4t0dAbZbMjIa9SGYECdOmzbkwOj8
 xNFXFOmWWUvkfFgSpXnZZTbkBhHMOre2NX084qWLKN2UEREFnkEHKdGJd5ldfS5gWFxP
 ZR8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714063626; x=1714668426;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LvYoBl//K1mZp4n6gQiTJLEv0WK6YOM1tJ/Mw67+Cpg=;
 b=V3iFv0JDigPM9+55HpgckbMxexbMfK2d3w89FgXBYISUkn8QP7mTDTtgcirWQv4nyt
 xAgi9AtEvgHEaVhluD/MloDM19f/lgz4oPr3CWr6LsS0H1s97ZsCI5DFcjxN7dFtk3TU
 Q7HremvCHFO0NNl7nkCCHlKACgnfpiGiyK70vW19E7iJZh8gDARZZ9JZ0Yla3O78mxxX
 hRJqa7MOtrFCVnih4sA4jskFc20Hjy5lot2ClSXjjngfBpGPm2xTx3cJ8UTrfVVWzLmZ
 2QliXMJWfB1OIIz7noLf4OQ5ADGG1H0u52spwaYUWtVItn0ZjEsK9OesJdqvcrNIwl41
 HYRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWi++S4ksg9VT34xnut6uzHx+w5vU5uYjECNvC8l0EwPqGsG6tF090AfNBM+XD9R0hToRxk3MnnSb8pjgWK4tT1D6BDWLo=
X-Gm-Message-State: AOJu0YzCH+aFhhqptXiCfCsWxCBbsBL2/VWMuDdhscNnfrB28FSu2mC0
 XDQvwt3vEOQCITEfVkMUl8uWuNaAxuG8ivB0SU4+1JuBxkFOSCKRlovuNDDxHfGlBSeeLEYJCpl
 YdCSxTzgnTyCwccXvXzUI0TEriXE=
X-Google-Smtp-Source: AGHT+IGDLv6Ts76ph9fiH8tUm6ZSHtHJsC+5s6wMmIhNSxgDl97X1NF6ekJUqnU2twYVHsIA/L0hi4B9EUUJKbwEVgw=
X-Received: by 2002:a2e:9819:0:b0:2de:33cd:b46e with SMTP id
 a25-20020a2e9819000000b002de33cdb46emr4458770ljj.48.1714063626255; Thu, 25
 Apr 2024 09:47:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240419183135.12276-1-dorjoychy111@gmail.com>
 <f397f267-06d9-46c1-8acc-1c9ebf9c3773@linaro.org>
 <CAFEAcA8i_wU+RSRk+D1L8YKy72zHz4YFV20r2Z7m+3ARfzb51w@mail.gmail.com>
 <CAFEAcA_kHDGWVic=xRm4xOsi-cQC-fF5Z2FWRCrwe_E35KBmNw@mail.gmail.com>
In-Reply-To: <CAFEAcA_kHDGWVic=xRm4xOsi-cQC-fF5Z2FWRCrwe_E35KBmNw@mail.gmail.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Thu, 25 Apr 2024 22:46:54 +0600
Message-ID: <CAFfO_h7QT=KLODM5Nj0O8ZCXwitKAwBeTc8TVcCM6Px4vRhbVg@mail.gmail.com>
Subject: Re: [PATCH] target/arm: fix MPIDR value for ARM CPUs with SMT
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=dorjoychy111@gmail.com; helo=mail-lj1-x230.google.com
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

On Mon, Apr 22, 2024 at 5:26=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Mon, 22 Apr 2024 at 11:46, Peter Maydell <peter.maydell@linaro.org> wr=
ote:
> >
> > On Sun, 21 Apr 2024 at 06:40, Richard Henderson
> > <richard.henderson@linaro.org> wrote:
> > > > --- a/target/arm/cpu.c
> > > > +++ b/target/arm/cpu.c
> > > > @@ -1314,8 +1314,18 @@ static void arm_cpu_dump_state(CPUState *cs,=
 FILE *f, int flags)
> > > >       }
> > > >   }
> > > >
> > > > -uint64_t arm_build_mp_affinity(int idx, uint8_t clustersz)
> > > > +uint64_t arm_build_mp_affinity(ARMCPU *cpu, int idx, uint8_t clust=
ersz)
> > > >   {
> > > > +    if (cpu->has_smt) {
> > > > +        /*
> > > > +         * Right now, the ARM CPUs with SMT supported by QEMU only=
 have
> > > > +         * one thread per core. So Aff0 is always 0.
> > > > +         */
> > >
> > > Well, this isn't true.
> > >
> > >      -smp [[cpus=3D]n][,maxcpus=3Dmaxcpus][,drawers=3Ddrawers][,books=
=3Dbooks][,sockets=3Dsockets]
> > >                     [,dies=3Ddies][,clusters=3Dclusters][,cores=3Dcor=
es][,threads=3Dthreads]
> > >
> > > I would expect all of Aff[0-3] to be settable with the proper topolog=
y parameters.
> >
> > As I understand it the MPIDR value is more or less independent
> > of the topology information as presented to the guest OS.
> > The options to the -smp command set the firmware topology
> > information, which doesn't/shouldn't affect the reported
> > MPIDR values, and in particular shouldn't change whether
> > the CPU selected has the MT bit set or not.
> >
> > For Arm's CPUs they fall into two categories:
> >  * older ones don't set MT in their MPIDR, and the Aff0
> >    field is effectively the CPU number
> >  * newer ones do set MT in their MPIDR, but don't have
> >    SMT, so their Aff0 is always 0 and their Aff1
> >    is the CPU number
> >
> > Of all the CPUs we model, none of them are the
> > architecturally-permitted "MT is set, CPU implements
> > actual SMT, Aff0 indicates the thread in the CPU" type.
>
> Looking at the TRM, Neoverse-E1 is "MT is set, actual SMT,
> Aff0 is the thread" (Aff0 can be 0 or 1). We just don't
> model that CPU type yet. But we should probably make
> sure we don't block ourselves into a corner where that
> would be awkward -- I'll have a think about this and
> look at what x86 does with the topology info.
>

Thanks. Let me know what should be done as part of this patch to
properly fix the issue if you get a chance to look at it.

Regards,
Dorjoy

