Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2BA9C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 21:41:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scXLq-0002jd-RO; Fri, 09 Aug 2024 17:40:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1scXLo-0002g0-DM
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 17:40:44 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1scXLl-0000Go-Vu
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 17:40:44 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2ef2fbf1d14so34618881fa.1
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2024 14:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1723239639; x=1723844439;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BISKw5vPA7++YI3+ds/HjOiUZyN7fPOPFYE3F8POIzA=;
 b=TsK326hiO6l7D31RTRdoR31i6YqTCUl89VB+fVy6A3YHZy10Zj3JCq5HzkU1c4WUAl
 OnAApJzI0VofrWbnDhX8sjg2WDIx+LqK9tUOksRUwcctDquvCmdiAn3KsPAwHhU8aCTS
 e/ooRxVrokgsJpm1pbmdvpYZq4LC4UXo0luCn5A2J9DWxbKVHR+XnHelaeM5G05JTxzw
 RqTFacXzXQrKboxbZHOMp1yywqfV0Ch6AqGaZaQsb3gADHCE5mL0lNC9BM+duT1mbvP6
 8cm/KzgBXw3JdeMvxIkuZgTmMM6WuOpjVBEWKEUDtvRS0MExvEOzFrYRc4DortRPd+ZU
 rOqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723239639; x=1723844439;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BISKw5vPA7++YI3+ds/HjOiUZyN7fPOPFYE3F8POIzA=;
 b=Ht+LncGmfvydQdCu8ylPCtV9kpq7L/9LaNj/pNpj3UGlal2OZAuGBviNe/eM4Fb9NI
 D4Mek7i3TuI3gCOYR3Gb6pqtw1X/JwxyT9RNuzi65vzXwCY49YDvhIcCY+h2iP/9pEXt
 4qW8oT3eNJzsCHawDJgfi0Dl0Gn70oMjqqlJryZXLLHxZwGdlcde01m5iz97e5qeR/0z
 zqPoE0VUu1u0d8WHrxRbYxd8zeu9G/Nme6z5WjSNFnVjFrIZiY7ZiJbJPCfbSfNNG+UH
 6C5bYcKUIRcf9o+61Bo+P/HMfVAFr4jakkH89qQVULWsMh+HchavdUbmZaCOa/j2HvMr
 5tyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPT9muSx1tntZKVAjujRWw45G6CX5dJfrsXlAr+b5CligrzE6vltomXHGjXBYjTdz3UTYbQfGJH3/oY7Dxt0Rgh//Nx2g=
X-Gm-Message-State: AOJu0YwS19YTkprTRIj0xMWW+Z/LT9UTF2Ila8X07K4UWaYak3ChHafT
 um0sYEolzowrWbdXGYE0ghNGyTLt6eYWp/nJGZ+HBH8rxFiR96Pf/pzla1cyblePNv5bh4UxFTK
 HbOFc1O72IkrGJ5xbtiXLjDXcO/kzMoO7eq7o8w==
X-Google-Smtp-Source: AGHT+IFGCRWNlUOMfvVQUPUkxSmp4XpCemNxf0jyQMHcxsmPrBkQQp9RBGQPfVBaBI68pXBnOFUTHwVjFN7ZHHmgFeI=
X-Received: by 2002:a05:651c:154a:b0:2f0:2026:3f71 with SMTP id
 38308e7fff4ca-2f19e362cf3mr20218321fa.8.1723239639018; Fri, 09 Aug 2024
 14:40:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240723-counter_delegation-v2-0-c4170a5348ca@rivosinc.com>
 <20240723-counter_delegation-v2-13-c4170a5348ca@rivosinc.com>
 <20240806-9fdad33468ec103d83a85e77@orel>
 <3c09bbbe-857b-4566-963a-790497232bbf@ventanamicro.com>
 <CAKmqyKNgJKBFw7OnwbgbqxA65PR4GSjdUEKdKVw-nYv+e0P58w@mail.gmail.com>
 <CAHBxVyFFa7mQaS4jPkT=aK4gTF3AshpQZNeRhBiZOHX7bhQQsg@mail.gmail.com>
 <CAKmqyKOX883p+sgFs6s649pkH0BA9aKcrTr7=XOT=Xy8mNLzng@mail.gmail.com>
 <CAHBxVyHvypXN0PtxtWwZPoB3i3JRRSqn218nnURy+sD8gmqyjQ@mail.gmail.com>
 <CAKmqyKPt68Sb19rvzX-ugieRja+NYz_ZjLT9R9yBA5KX=i_wZQ@mail.gmail.com>
In-Reply-To: <CAKmqyKPt68Sb19rvzX-ugieRja+NYz_ZjLT9R9yBA5KX=i_wZQ@mail.gmail.com>
From: Atish Kumar Patra <atishp@rivosinc.com>
Date: Fri, 9 Aug 2024 14:40:27 -0700
Message-ID: <CAHBxVyF6V0Na5zPTcJ24_yvjYjQPrbXR8hspLOr1rM16XbQs2Q@mail.gmail.com>
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
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=atishp@rivosinc.com; helo=mail-lj1-x22b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Aug 8, 2024 at 1:24=E2=80=AFAM Alistair Francis <alistair23@gmail.c=
om> wrote:
>
> On Thu, Aug 8, 2024 at 6:12=E2=80=AFPM Atish Kumar Patra <atishp@rivosinc=
.com> wrote:
> >
> > On Wed, Aug 7, 2024 at 5:27=E2=80=AFPM Alistair Francis <alistair23@gma=
il.com> wrote:
> > >
> > > On Wed, Aug 7, 2024 at 5:44=E2=80=AFPM Atish Kumar Patra <atishp@rivo=
sinc.com> wrote:
> > > >
> > > > On Tue, Aug 6, 2024 at 7:01=E2=80=AFPM Alistair Francis <alistair23=
@gmail.com> wrote:
> > > > >
> > > > > On Wed, Aug 7, 2024 at 2:06=E2=80=AFAM Daniel Henrique Barboza
> > > > > <dbarboza@ventanamicro.com> wrote:
> > > > > >
> > > > > >
> > > > > >
> > > > > > On 8/6/24 5:46 AM, Andrew Jones wrote:
> > > > > > > On Tue, Jul 23, 2024 at 04:30:10PM GMT, Atish Patra wrote:
> > > > > > >> Counter delegation/configuration extension requires the foll=
owing
> > > > > > >> extensions to be enabled.
> > > > > > >>
> > > > > > >> 1. Smcdeleg - To enable counter delegation from M to S
> > > > > > >> 2. S[m|s]csrind - To enable indirect access CSRs
> > > > > > >> 3. Smstateen - Indirect CSR extensions depend on it.
> > > > > > >> 4. Sscofpmf - To enable counter overflow feature
> > > > > > >> 5. S[m|s]aia - To enable counter overflow feature in virtual=
ization
> > > > > > >> 6. Smcntrpmf - To enable privilege mode filtering for cycle/=
instret
> > > > > > >>
> > > > > > >> While first 3 are mandatory to enable the counter delegation=
,
> > > > > > >> next 3 set of extension are preferred to enable all the PMU =
related
> > > > > > >> features.
> > > > > > >
> > > > > > > Just my 2 cents, but I think for the first three we can apply=
 the concept
> > > > > > > of extension bundles, which we need for other extensions as w=
ell. In those
> > > > > > > cases we just auto enable all the dependencies. For the three=
 preferred
> > > > > > > extensions I think we can just leave them off for 'base', but=
 we should
> > > > > > > enable them by default for 'max' along with Ssccfg.
> > > > >
> > > >
> > > > Max cpu will have everything enabled by default. The problem with m=
ax
> > > > cpu is that you
> > > > may not want to run all the available ISA extensions while testing =
perf.
> > > >
> > > > > Agreed
> > > > >
> > > > > >
> > > > > > I like this idea. I would throw in all these 6 extensions in a =
'pmu_advanced_ops'
> > > > > > (or any other better fitting name for the bundle) flag and then=
 'pmu_advanced_ops=3Dtrue'
> > > > > > would enable all of those. 'pmu_advanced_ops=3Dtrue,smcntrpmf=
=3Dfalse' enables all but
> > > > > > 'smcntrpmf' and so on.
> > > > > >
> > > >
> > > > I thought distinguishing preferred vs implied would be useful becau=
se
> > > > it would allow the user
> > > > to clearly understand which is mandated by ISA vs which would be go=
od to have.
> > >
> > > It's not really clear though what extensions are good to have. Other
> > > people might think differently about the extensions. It also then
> > > means we end up with complex combinations of extensions to manage.
> > >
> > > >
> > > > The good to have extensions can be disabled similar to above but no=
t
> > > > the mandatory ones.
> > > >
> > > > > > As long as we document what the flag is enabling I don't see an=
y problems with it.
> > > > > > This is how profiles are implemented after all.
> > > > >
> > > > > I only worry that we end up with a huge collection of flags that =
users
> > > > > need to decipher.
> > > > >
> > > >
> > > > My initial idea was a separate flag as well. But I was not sure if
> > > > that was good for the
> > > > above reason. This additional custom pmu related option would be lo=
st
> > > > in that huge collection.
> > >
> > > I do feel a separate flag is better than trying to guess what extra
> > > extensions the user wants enabled.
> > >
> >
> > Sure. A separate pmu flag that enables all available pmu related
> > extensions - Correct ?
>
> That seems like the best option. Although just using the max CPU is
> even better :)
>
> > Do you prefer to have those enabled via a separate preferred rule or
> > just reuse the implied
> > rule ? I can drop the preferred rule patches for the later case.
>
> As this is now a custom flag a separate rule is probably the way to
> go. Something similar to the existing `RISCVCPUImpliedExtsRule` is
> probably the way to go. Keep an implied rule for what is required by
> the spec, but maybe a "helper" rule for the special flag?
>
> >
> >
> > > I don't love either though, isn't this what profiles is supposed to f=
ix!
> > >
> >
> > Yeah. But given the optionality in profiles, I am sure if it will fix
> > the ever growing
> > extension dependency graph problem ;)
> >
> > > >
> > > > > I guess with some good documentation this wouldn't be too confusi=
ng though.
> > > > >
> > > >
> > > > Sure. It won't be confusing but most users may not even know about =
it
> > > > without digging.
> > >
> > > At that point they can use the max CPU or just manually enable the
> > > extensions though.
> > >
> >
> > If everybody thinks max CPU is going to be used more frequently in the
> > future, I am okay with
> > that as well. Implied rule will only specify mandatory extensions
> > defined by ISA.
> >
> > It's up to the user to figure out the extensions names and enable them
> > individually if max CPU
> > is not used.
>
> A user can just specify max. It's just as much work as specifying this ne=
w flag.
>
> Is the issue just the defaults? We can think about max CPU being the defa=
ult.
>

Yes. That would be great. I will drop the Preferred rule and use the implie=
d
rule for the extensions mandated by the ISA for now in v3.

> > FYI: There are at least 6 more PMU related extensions that this series
> > did not specify.
> > ~4 are being discussed in the RVI TG(precise event sampling, events)
> > and 2 are frozen (Smctr/Ssctr)
>
> Urgh!
>
> Alistair

