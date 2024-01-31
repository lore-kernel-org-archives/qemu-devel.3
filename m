Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89727C46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 01:27:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUzNG-0006D2-7U; Tue, 30 Jan 2024 20:26:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rUzNB-0006CY-US
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 20:26:42 -0500
Received: from mail-ua1-x932.google.com ([2607:f8b0:4864:20::932])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rUzN9-0000Jv-RW
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 20:26:41 -0500
Received: by mail-ua1-x932.google.com with SMTP id
 a1e0cc1a2514c-7d2e19120b5so2004108241.2
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 17:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706664398; x=1707269198; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h93BkgVFUuRnPb2+mPK0buA3QG1DHMAEwTXxdNF0ziU=;
 b=iTyE2Di7KyVss4o4vLHpIoL5kFgbadoD5FRvdU8iUn4779ISfU7J/1tLlF4I0gbcKI
 BwlwhLzX5Xb5WznCEx7BYIsY46A+VGCYD0dac/KiIlTSqexAqH5iQudp3w8jSdxDs6GQ
 Sgd81x7pa177fNAb3LaVeHQMfxht77F+VNtPPGEy9kdRwXQp1ikx3WdQLSgJt1ixnp68
 DzWjSCPz1TTxoy65nziK3s+fax0MGDjupdLXkHHnwk4K9M2di7CuhdLQmgRaovBHaPIf
 hW23e3kxThTHoOGD8rGR9hJDv7JufUdoaRpX7+zQXiX/D/TQjKUiphSGPdlk0/PJvEtQ
 mhsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706664398; x=1707269198;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h93BkgVFUuRnPb2+mPK0buA3QG1DHMAEwTXxdNF0ziU=;
 b=vmuXcI4NWWhkLmnypF2Ex6kGy1x0H0mHWUjV8TyoV4nanjS2hmCdb7U5OpMSXdkP0/
 5NFbohYWqrGQj+y5TQXRLJm7ErzC9gZ5ozqxcoxejuTVWdBGxx+aNKN8691lqRpewIGV
 W5H6Mw7hyweLpUhIM7g1R18u/tKCK2LYsM7TRNfv1roef7E4Onm7zmNzcxoNo3SYYBW7
 ONV/0zfO73y32f3wcXceXCQvPNpTcjzCXDMYz8FPqc+9hlY+MLUrbAfcFcZ6CeJRR6w4
 5HCo4nnlbdkvYh/sYuYVpaqJaQRa/pGndj+QehAhHYJJcH3VomOT9XUrNjjSfBd8j8Mb
 Go3Q==
X-Gm-Message-State: AOJu0YwOgWFHjc2VzG0ICYsyQR0aTBxRY21BlGzulhnSg59xskJFYRpk
 OIzjJMtLOpd4wUlKJgT/srArjcbgaYjab3VtE7zdWI+8cShIZGVbMLtoit+j58V/M1I17SDu5z5
 khu45br/CSC4AWkKbAvlbiBDrpYI=
X-Google-Smtp-Source: AGHT+IEyWGLO3/jvjHtdjXsT7PNhenjAm0xbQRnRwO0JBpDoipIMfct79gY1WGUaNOu7+iZ+11d5WShu6OqllnLtNJ4=
X-Received: by 2002:a67:f90a:0:b0:46b:3fe2:4ae6 with SMTP id
 t10-20020a67f90a000000b0046b3fe24ae6mr93787vsq.27.1706664398424; Tue, 30 Jan
 2024 17:26:38 -0800 (PST)
MIME-Version: 1.0
References: <CAJSP0QU2M0e56M0S9ztMDO7eyqFB-p1KgwxJhzwkxt=CuS_PqA@mail.gmail.com>
 <mhng-e7014372-2334-430e-b22e-17227af21bd9@palmer-ri-x1c9a>
In-Reply-To: <mhng-e7014372-2334-430e-b22e-17227af21bd9@palmer-ri-x1c9a>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 31 Jan 2024 11:26:11 +1000
Message-ID: <CAKmqyKMAQ1vrf9QnCx17DbKgGTqgDd58y46RLwZvzW4Sk4zyjA@mail.gmail.com>
Subject: Re: Call for GSoC/Outreachy internship project ideas
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: stefanha@gmail.com, Alistair Francis <Alistair.Francis@wdc.com>,
 dbarboza@ventanamicro.com, 
 qemu-devel@nongnu.org, kvm@vger.kernel.org, afaria@redhat.com, 
 alex.bennee@linaro.org, eperezma@redhat.com, gmaglione@redhat.com, 
 marcandre.lureau@redhat.com, rjones@redhat.com, sgarzare@redhat.com, 
 imp@bsdimp.com, philmd@linaro.org, pbonzini@redhat.com, thuth@redhat.com, 
 danielhb413@gmail.com, gaosong@loongson.cn, akihiko.odaki@daynix.com, 
 shentey@gmail.com, npiggin@gmail.com, seanjc@google.com, 
 Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::932;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x932.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Jan 31, 2024 at 10:30=E2=80=AFAM Palmer Dabbelt <palmer@dabbelt.com=
> wrote:
>
> On Tue, 30 Jan 2024 12:28:27 PST (-0800), stefanha@gmail.com wrote:
> > On Tue, 30 Jan 2024 at 14:40, Palmer Dabbelt <palmer@dabbelt.com> wrote=
:
> >>
> >> On Mon, 15 Jan 2024 08:32:59 PST (-0800), stefanha@gmail.com wrote:
> >> > Dear QEMU and KVM communities,
> >> > QEMU will apply for the Google Summer of Code and Outreachy internsh=
ip
> >> > programs again this year. Regular contributors can submit project
> >> > ideas that they'd like to mentor by replying to this email before
> >> > January 30th.
> >>
> >> It's the 30th, sorry if this is late but I just saw it today.  +Alista=
ir
> >> and Daniel, as I didn't sync up with anyone about this so not sure if
> >> someone else is looking already (we're not internally).
> >>
> >> > Internship programs
> >> > ---------------------------
> >> > GSoC (https://summerofcode.withgoogle.com/) and Outreachy
> >> > (https://www.outreachy.org/) offer paid open source remote work
> >> > internships to eligible people wishing to participate in open source
> >> > development. QEMU has been part of these internship programs for man=
y
> >> > years. Our mentors have enjoyed helping talented interns make their
> >> > first open source contributions and some former interns continue to
> >> > participate today.
> >> >
> >> > Who can mentor
> >> > ----------------------
> >> > Regular contributors to QEMU and KVM can participate as mentors.
> >> > Mentorship involves about 5 hours of time commitment per week to
> >> > communicate with the intern, review their patches, etc. Time is also
> >> > required during the intern selection phase to communicate with
> >> > applicants. Being a mentor is an opportunity to help someone get
> >> > started in open source development, will give you experience with
> >> > managing a project in a low-stakes environment, and a chance to
> >> > explore interesting technical ideas that you may not have time to
> >> > develop yourself.
> >> >
> >> > How to propose your idea
> >> > ----------------------------------
> >> > Reply to this email with the following project idea template filled =
in:
> >> >
> >> > =3D=3D=3D TITLE =3D=3D=3D
> >> >
> >> > '''Summary:''' Short description of the project
> >> >
> >> > Detailed description of the project that explains the general idea,
> >> > including a list of high-level tasks that will be completed by the
> >> > project, and provides enough background for someone unfamiliar with
> >> > the codebase to do research. Typically 2 or 3 paragraphs.
> >> >
> >> > '''Links:'''
> >> > * Wiki links to relevant material
> >> > * External links to mailing lists or web sites
> >> >
> >> > '''Details:'''
> >> > * Skill level: beginner or intermediate or advanced
> >> > * Language: C/Python/Rust/etc
> >>
> >> I'm not 100% sure this is a sane GSoC idea, as it's a bit open ended a=
nd
> >> might have some tricky parts.  That said it's tripping some people up
> >> and as far as I know nobody's started looking at it, so I figrued I'd
> >> write something up.
> >>
> >> I can try and dig up some more links if folks thing it's interesting,
> >> IIRC there's been a handful of bug reports related to very small loops
> >> that run ~10x slower when vectorized.  Large benchmarks like SPEC have
> >> also shown slowdowns.
> >
> > Hi Palmer,
> > Performance optimization can be challenging for newcomers. I wouldn't
> > recommend it for a GSoC project unless you have time to seed the
> > project idea with specific optimizations to implement based on your
> > experience and profiling. That way the intern has a solid starting
> > point where they can have a few successes before venturing out to do
> > their own performance analysis.
>
> Ya, I agree.  That's part of the reason why I wasn't sure if it's a
> good idea.  At least for this one I think there should be some easy to
> understand performance issue, as the loops that go very slowly consist
> of a small number of instructions and go a lot slower.
>
> I'm actually more worried about this running into a rabbit hole of
> adding new TCG operations or even just having no well defined mappings
> between RVV and AVX, those might make the project really hard.
>
> > Do you have the time to profile and add specifics to the project idea
> > by Feb 21st? If that sounds good to you, I'll add it to the project
> > ideas list and you can add more detailed tasks in the coming weeks.
>
> I can at least dig up some of the examples I ran into, there's been a
> handful filtering in over the last year or so.
>
> This one
> <https://gist.github.com/compnerd/daa7e68f7b4910cb6b27f856e6c2beba>
> still has a much more than 10x slowdown (73ms -> 13s) with
> vectorization, for example.

It's probably worth creating a Gitlab issue for this and adding all of
the examples there. That way we have a single place to store them all

Alistair

>
> > Thanks,
> > Stefan
>

