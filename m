Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0B44C52D73
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 08:13:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbyGG-0005TF-DI; Thu, 08 Aug 2024 04:12:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1sbyGF-0005Lr-5M
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 04:12:39 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1sbyGC-00021Y-5Z
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 04:12:38 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2f040733086so6607831fa.1
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2024 01:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1723104753; x=1723709553;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bt4nxGBb55vV904sNvNT6wthx+qvXCFcjwq9x/M1oB0=;
 b=Ld9t8PlZfmXrs3/2T1nsjj7MGQXIUR5nJgx4baBokZ22dy2n3UA2EIV3butTX+L7iV
 hn8Z4b8tBbPuY0PrC0nfqENFgvL2xO44JXti2gZDWXJWh9VflDn0Mj9Siy/LRnsZZOrG
 OWc2A1dinCVczDj2EumG1N7PAh4qTBm5CPPkpteMb5s97FapUTBFqn3ucgVn0VMZfuf7
 qP6tBzim5+/GejgTZTt2WKWHv9suk2woT8Eg8br32RaA/UFBiisYZptkgfYdHhUOLg/o
 AAhTMvmejmCtjjQgm15X05czOwJzErGBMhlkzbpJ/TvrKBg9Rmpwkt/QnawojmNGi4Hn
 uirA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723104753; x=1723709553;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bt4nxGBb55vV904sNvNT6wthx+qvXCFcjwq9x/M1oB0=;
 b=wGQNKHkp37z9Fe1W6dMIy3965lbMEW+uEpwHK6g/xof51wzuMiS204bU59L2hjqOjE
 PImDKmthu1hkNoAEGF1PZCQ16dIqvMUDw3i8KZaqCJBt3QHDOZ0HcBAkyqqqzZQiwJ6r
 7Z6idNLrIGoWN9LUCA35IEPAIWK07sMgHz08vFWy5vcwG/4lbF8P6a/MN9pJMkZymqBS
 vHuSB8SJc8m9rsYQ489hO33BCtT1vmqzyoj+X6qaFyDjpA/EhFj+tIn8dmQLDFqvhbfb
 QRV4zzy4/P1AqXDVTM4XJxJrdR9OqaN2z/3w+sARJa+QWr/h+6xp/l1TLMODRoanoQ7C
 pIvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWDCYpyXjbN4xKdmvgKAbzzpijAdbgQ/BhWiDKByHarx1WCLrCBaB3iY/aydnFoXc9dAbiIm0e6T0+c/od4yQXS6sq/Zo=
X-Gm-Message-State: AOJu0YxZUnQvAE/uPOVEf93ouBSj2rP2O7Ca6PXSnVklSnK73IIe4V1+
 9+TWTGUcTkYfhWP2wrUK7vuCjyx113uBap6JbvEucmJIVdtWbTtE1taQGIxPrW9MUj4oKLSevBZ
 kV4qYdWkW/DTInZvLf4D+sDGTro2uI8PyIDmlsg==
X-Google-Smtp-Source: AGHT+IEuFFUB2eZl7L6E8WGYsRYU8wgfbvZzj9tuNS2eCTyPTkdHErw8OvX+9gWRiosFpoMKLb4mHwHPrPve2iM63Zk=
X-Received: by 2002:a05:6512:1289:b0:52e:fa5f:b6b1 with SMTP id
 2adb3069b0e04-530e58a33f9mr564746e87.60.1723104753241; Thu, 08 Aug 2024
 01:12:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240723-counter_delegation-v2-0-c4170a5348ca@rivosinc.com>
 <20240723-counter_delegation-v2-13-c4170a5348ca@rivosinc.com>
 <20240806-9fdad33468ec103d83a85e77@orel>
 <3c09bbbe-857b-4566-963a-790497232bbf@ventanamicro.com>
 <CAKmqyKNgJKBFw7OnwbgbqxA65PR4GSjdUEKdKVw-nYv+e0P58w@mail.gmail.com>
 <CAHBxVyFFa7mQaS4jPkT=aK4gTF3AshpQZNeRhBiZOHX7bhQQsg@mail.gmail.com>
 <CAKmqyKOX883p+sgFs6s649pkH0BA9aKcrTr7=XOT=Xy8mNLzng@mail.gmail.com>
In-Reply-To: <CAKmqyKOX883p+sgFs6s649pkH0BA9aKcrTr7=XOT=Xy8mNLzng@mail.gmail.com>
From: Atish Kumar Patra <atishp@rivosinc.com>
Date: Thu, 8 Aug 2024 01:12:22 -0700
Message-ID: <CAHBxVyHvypXN0PtxtWwZPoB3i3JRRSqn218nnURy+sD8gmqyjQ@mail.gmail.com>
Subject: Re: [PATCH v2 13/13] target/riscv: Enable PMU related extensions to
 preferred rule
To: Alistair Francis <alistair23@gmail.com>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>, 
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, bin.meng@windriver.com, 
 alistair.francis@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=atishp@rivosinc.com; helo=mail-lj1-x22a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Wed, Aug 7, 2024 at 5:27=E2=80=AFPM Alistair Francis <alistair23@gmail.c=
om> wrote:
>
> On Wed, Aug 7, 2024 at 5:44=E2=80=AFPM Atish Kumar Patra <atishp@rivosinc=
.com> wrote:
> >
> > On Tue, Aug 6, 2024 at 7:01=E2=80=AFPM Alistair Francis <alistair23@gma=
il.com> wrote:
> > >
> > > On Wed, Aug 7, 2024 at 2:06=E2=80=AFAM Daniel Henrique Barboza
> > > <dbarboza@ventanamicro.com> wrote:
> > > >
> > > >
> > > >
> > > > On 8/6/24 5:46 AM, Andrew Jones wrote:
> > > > > On Tue, Jul 23, 2024 at 04:30:10PM GMT, Atish Patra wrote:
> > > > >> Counter delegation/configuration extension requires the followin=
g
> > > > >> extensions to be enabled.
> > > > >>
> > > > >> 1. Smcdeleg - To enable counter delegation from M to S
> > > > >> 2. S[m|s]csrind - To enable indirect access CSRs
> > > > >> 3. Smstateen - Indirect CSR extensions depend on it.
> > > > >> 4. Sscofpmf - To enable counter overflow feature
> > > > >> 5. S[m|s]aia - To enable counter overflow feature in virtualizat=
ion
> > > > >> 6. Smcntrpmf - To enable privilege mode filtering for cycle/inst=
ret
> > > > >>
> > > > >> While first 3 are mandatory to enable the counter delegation,
> > > > >> next 3 set of extension are preferred to enable all the PMU rela=
ted
> > > > >> features.
> > > > >
> > > > > Just my 2 cents, but I think for the first three we can apply the=
 concept
> > > > > of extension bundles, which we need for other extensions as well.=
 In those
> > > > > cases we just auto enable all the dependencies. For the three pre=
ferred
> > > > > extensions I think we can just leave them off for 'base', but we =
should
> > > > > enable them by default for 'max' along with Ssccfg.
> > >
> >
> > Max cpu will have everything enabled by default. The problem with max
> > cpu is that you
> > may not want to run all the available ISA extensions while testing perf=
.
> >
> > > Agreed
> > >
> > > >
> > > > I like this idea. I would throw in all these 6 extensions in a 'pmu=
_advanced_ops'
> > > > (or any other better fitting name for the bundle) flag and then 'pm=
u_advanced_ops=3Dtrue'
> > > > would enable all of those. 'pmu_advanced_ops=3Dtrue,smcntrpmf=3Dfal=
se' enables all but
> > > > 'smcntrpmf' and so on.
> > > >
> >
> > I thought distinguishing preferred vs implied would be useful because
> > it would allow the user
> > to clearly understand which is mandated by ISA vs which would be good t=
o have.
>
> It's not really clear though what extensions are good to have. Other
> people might think differently about the extensions. It also then
> means we end up with complex combinations of extensions to manage.
>
> >
> > The good to have extensions can be disabled similar to above but not
> > the mandatory ones.
> >
> > > > As long as we document what the flag is enabling I don't see any pr=
oblems with it.
> > > > This is how profiles are implemented after all.
> > >
> > > I only worry that we end up with a huge collection of flags that user=
s
> > > need to decipher.
> > >
> >
> > My initial idea was a separate flag as well. But I was not sure if
> > that was good for the
> > above reason. This additional custom pmu related option would be lost
> > in that huge collection.
>
> I do feel a separate flag is better than trying to guess what extra
> extensions the user wants enabled.
>

Sure. A separate pmu flag that enables all available pmu related
extensions - Correct ?
Do you prefer to have those enabled via a separate preferred rule or
just reuse the implied
rule ? I can drop the preferred rule patches for the later case.


> I don't love either though, isn't this what profiles is supposed to fix!
>

Yeah. But given the optionality in profiles, I am sure if it will fix
the ever growing
extension dependency graph problem ;)

> >
> > > I guess with some good documentation this wouldn't be too confusing t=
hough.
> > >
> >
> > Sure. It won't be confusing but most users may not even know about it
> > without digging.
>
> At that point they can use the max CPU or just manually enable the
> extensions though.
>

If everybody thinks max CPU is going to be used more frequently in the
future, I am okay with
that as well. Implied rule will only specify mandatory extensions
defined by ISA.

It's up to the user to figure out the extensions names and enable them
individually if max CPU
is not used.
FYI: There are at least 6 more PMU related extensions that this series
did not specify.
~4 are being discussed in the RVI TG(precise event sampling, events)
and 2 are frozen (Smctr/Ssctr)

> Alistair
>
> > That's why I chose to use a standard extension which covers the basic
> > PMU access directly in S-mode.
> >
> > The future extensions such as CTR or Sampling events would also
> > benefit by just adding the Ssccfg in the preferred rule
> > which in turn will enable other preferred/mandatory extensions.
> >
> > > Alistair
> > >
> > > >
> > > > With this bundle we can also use implied rule only if an extension =
really needs
> > > > (i.e. it breaks without) a dependency being enabled, instead of ove=
rloading it
> > > > with extensions that 'would be nice to have together' like it seems=
 to be the
> > > > case for the last 3 extensions in that list.
> > > >
> > > > I believe users would benefit more from a single flag to enable eve=
rything and
> > > > be done with it.
> > > >
> > > >
> > > > Thanks,
> > > >
> > > > Daniel

