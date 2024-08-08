Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 241FEC52D7B
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 08:25:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbyRk-00018f-5c; Thu, 08 Aug 2024 04:24:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sbyRi-00016Q-Bb; Thu, 08 Aug 2024 04:24:30 -0400
Received: from mail-vk1-xa36.google.com ([2607:f8b0:4864:20::a36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sbyRg-0003wq-Eg; Thu, 08 Aug 2024 04:24:30 -0400
Received: by mail-vk1-xa36.google.com with SMTP id
 71dfb90a1353d-4f8dbdbba98so376979e0c.0; 
 Thu, 08 Aug 2024 01:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723105467; x=1723710267; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d78lM6MXFGiQNR0gct+gwQUbTpGpAOWNLofUeLESlN4=;
 b=Iv/EVVWtGnGxP4/BLemcV2rvVMfFxnuv9tzeCb1/0AfejtD+zWkTqk6bCMmU3ddRVI
 x+TrRzyoNIMBJJVjSSg7lSLRz6jCTN/W83YbDt1X+VYEvHXyYUdQX7isL5F+buqr1nde
 5pCPnF4sqILJL5R/kIEn+pz23ay2BgW8xMm8k7SvGfb+FfzOqg7Pqf5JqNKeDQVSMx1N
 gMrRiPTLA3XcFPCrj3/5dTMP8oVZafzxsH7mrpi/M3vcbTPVjydb8HKyXcMm3nSpGSgP
 Ddp8Q5Si4pd/hCnoTReShQasxyikBvoxCK2tpS3BukWTrIfTgaZ71OqiXPCfl52xQuCc
 zV2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723105467; x=1723710267;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d78lM6MXFGiQNR0gct+gwQUbTpGpAOWNLofUeLESlN4=;
 b=wNW1am4Di2+oTVPIoEaReJ10P+b1XGimTGxZkT4xdF71rL6UqhgH03eF34u6sHvnED
 QzEmToNxFAVns5fLt7Wjv2U+reGwPqTzDclDb+Z20NuLBir7KUWCqWRbp6nxsuoybPrx
 /zAw2taRrAkA0dvv4zsu0Y7NKrnuBaG1xnOxz9+YVO71ZC/U3CSrD53uNrUT4L5vxMkv
 inzybXBwJgLDZlHLJBKtNHmua1pNA9vmbdGIVu5MPrb18yxV9T86Quc9pAbf25pZ5W3h
 6UwpeCF/aVVuuxSNf5rHo9Eai3rhupPRlcWma8a/yE+V+V3oG9Q9W4lS1E9/QkFONo2Q
 Yi/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeUw3BHZJabvh7bvul4JucZXdDXRV4er2JCeQ93lSBDruvabj9M1EAaGykMGfInO5FzBZEkY80g7+C2Mrn1QWux9m7A3pVm9Zeo2SaPQccXvXfus6ca4nSAOo5sA==
X-Gm-Message-State: AOJu0Yz50xzu9ckXQyf5UkKqAtfMgtLJ0x1l7WZwWaU/Yuu28VrDOAMe
 xM0m5EbZW1PqwanZZO1n5i6XzKuy5aD4d/SiJ3+iGGfhqtX0a29BtCSvkQKqQSeVqGfdN4m3YuJ
 FlHE3Lc7p7/VyK4+3QAbzr2mc3Ow=
X-Google-Smtp-Source: AGHT+IFmYFQE3cZRMXQCyfgnyUMkwPlaew4fP+ESU18eMddZY5E9ILUsiTTm4r7ZaDMqF95W6AorUFE59NJ5EoM3At4=
X-Received: by 2002:a05:6122:3693:b0:4f5:197a:d679 with SMTP id
 71dfb90a1353d-4f904208058mr312302e0c.1.1723105466630; Thu, 08 Aug 2024
 01:24:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240723-counter_delegation-v2-0-c4170a5348ca@rivosinc.com>
 <20240723-counter_delegation-v2-13-c4170a5348ca@rivosinc.com>
 <20240806-9fdad33468ec103d83a85e77@orel>
 <3c09bbbe-857b-4566-963a-790497232bbf@ventanamicro.com>
 <CAKmqyKNgJKBFw7OnwbgbqxA65PR4GSjdUEKdKVw-nYv+e0P58w@mail.gmail.com>
 <CAHBxVyFFa7mQaS4jPkT=aK4gTF3AshpQZNeRhBiZOHX7bhQQsg@mail.gmail.com>
 <CAKmqyKOX883p+sgFs6s649pkH0BA9aKcrTr7=XOT=Xy8mNLzng@mail.gmail.com>
 <CAHBxVyHvypXN0PtxtWwZPoB3i3JRRSqn218nnURy+sD8gmqyjQ@mail.gmail.com>
In-Reply-To: <CAHBxVyHvypXN0PtxtWwZPoB3i3JRRSqn218nnURy+sD8gmqyjQ@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 8 Aug 2024 18:24:00 +1000
Message-ID: <CAKmqyKPt68Sb19rvzX-ugieRja+NYz_ZjLT9R9yBA5KX=i_wZQ@mail.gmail.com>
Subject: Re: [PATCH v2 13/13] target/riscv: Enable PMU related extensions to
 preferred rule
To: Atish Kumar Patra <atishp@rivosinc.com>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>, 
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, bin.meng@windriver.com, 
 alistair.francis@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a36;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa36.google.com
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

On Thu, Aug 8, 2024 at 6:12=E2=80=AFPM Atish Kumar Patra <atishp@rivosinc.c=
om> wrote:
>
> On Wed, Aug 7, 2024 at 5:27=E2=80=AFPM Alistair Francis <alistair23@gmail=
.com> wrote:
> >
> > On Wed, Aug 7, 2024 at 5:44=E2=80=AFPM Atish Kumar Patra <atishp@rivosi=
nc.com> wrote:
> > >
> > > On Tue, Aug 6, 2024 at 7:01=E2=80=AFPM Alistair Francis <alistair23@g=
mail.com> wrote:
> > > >
> > > > On Wed, Aug 7, 2024 at 2:06=E2=80=AFAM Daniel Henrique Barboza
> > > > <dbarboza@ventanamicro.com> wrote:
> > > > >
> > > > >
> > > > >
> > > > > On 8/6/24 5:46 AM, Andrew Jones wrote:
> > > > > > On Tue, Jul 23, 2024 at 04:30:10PM GMT, Atish Patra wrote:
> > > > > >> Counter delegation/configuration extension requires the follow=
ing
> > > > > >> extensions to be enabled.
> > > > > >>
> > > > > >> 1. Smcdeleg - To enable counter delegation from M to S
> > > > > >> 2. S[m|s]csrind - To enable indirect access CSRs
> > > > > >> 3. Smstateen - Indirect CSR extensions depend on it.
> > > > > >> 4. Sscofpmf - To enable counter overflow feature
> > > > > >> 5. S[m|s]aia - To enable counter overflow feature in virtualiz=
ation
> > > > > >> 6. Smcntrpmf - To enable privilege mode filtering for cycle/in=
stret
> > > > > >>
> > > > > >> While first 3 are mandatory to enable the counter delegation,
> > > > > >> next 3 set of extension are preferred to enable all the PMU re=
lated
> > > > > >> features.
> > > > > >
> > > > > > Just my 2 cents, but I think for the first three we can apply t=
he concept
> > > > > > of extension bundles, which we need for other extensions as wel=
l. In those
> > > > > > cases we just auto enable all the dependencies. For the three p=
referred
> > > > > > extensions I think we can just leave them off for 'base', but w=
e should
> > > > > > enable them by default for 'max' along with Ssccfg.
> > > >
> > >
> > > Max cpu will have everything enabled by default. The problem with max
> > > cpu is that you
> > > may not want to run all the available ISA extensions while testing pe=
rf.
> > >
> > > > Agreed
> > > >
> > > > >
> > > > > I like this idea. I would throw in all these 6 extensions in a 'p=
mu_advanced_ops'
> > > > > (or any other better fitting name for the bundle) flag and then '=
pmu_advanced_ops=3Dtrue'
> > > > > would enable all of those. 'pmu_advanced_ops=3Dtrue,smcntrpmf=3Df=
alse' enables all but
> > > > > 'smcntrpmf' and so on.
> > > > >
> > >
> > > I thought distinguishing preferred vs implied would be useful because
> > > it would allow the user
> > > to clearly understand which is mandated by ISA vs which would be good=
 to have.
> >
> > It's not really clear though what extensions are good to have. Other
> > people might think differently about the extensions. It also then
> > means we end up with complex combinations of extensions to manage.
> >
> > >
> > > The good to have extensions can be disabled similar to above but not
> > > the mandatory ones.
> > >
> > > > > As long as we document what the flag is enabling I don't see any =
problems with it.
> > > > > This is how profiles are implemented after all.
> > > >
> > > > I only worry that we end up with a huge collection of flags that us=
ers
> > > > need to decipher.
> > > >
> > >
> > > My initial idea was a separate flag as well. But I was not sure if
> > > that was good for the
> > > above reason. This additional custom pmu related option would be lost
> > > in that huge collection.
> >
> > I do feel a separate flag is better than trying to guess what extra
> > extensions the user wants enabled.
> >
>
> Sure. A separate pmu flag that enables all available pmu related
> extensions - Correct ?

That seems like the best option. Although just using the max CPU is
even better :)

> Do you prefer to have those enabled via a separate preferred rule or
> just reuse the implied
> rule ? I can drop the preferred rule patches for the later case.

As this is now a custom flag a separate rule is probably the way to
go. Something similar to the existing `RISCVCPUImpliedExtsRule` is
probably the way to go. Keep an implied rule for what is required by
the spec, but maybe a "helper" rule for the special flag?

>
>
> > I don't love either though, isn't this what profiles is supposed to fix=
!
> >
>
> Yeah. But given the optionality in profiles, I am sure if it will fix
> the ever growing
> extension dependency graph problem ;)
>
> > >
> > > > I guess with some good documentation this wouldn't be too confusing=
 though.
> > > >
> > >
> > > Sure. It won't be confusing but most users may not even know about it
> > > without digging.
> >
> > At that point they can use the max CPU or just manually enable the
> > extensions though.
> >
>
> If everybody thinks max CPU is going to be used more frequently in the
> future, I am okay with
> that as well. Implied rule will only specify mandatory extensions
> defined by ISA.
>
> It's up to the user to figure out the extensions names and enable them
> individually if max CPU
> is not used.

A user can just specify max. It's just as much work as specifying this new =
flag.

Is the issue just the defaults? We can think about max CPU being the defaul=
t.

> FYI: There are at least 6 more PMU related extensions that this series
> did not specify.
> ~4 are being discussed in the RVI TG(precise event sampling, events)
> and 2 are frozen (Smctr/Ssctr)

Urgh!

Alistair

