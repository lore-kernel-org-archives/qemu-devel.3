Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F243EC27C78
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 01:27:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHClX-0003Vd-Mq; Tue, 11 Jun 2024 21:27:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sHClW-0003VK-Pz; Tue, 11 Jun 2024 21:27:06 -0400
Received: from mail-ua1-x929.google.com ([2607:f8b0:4864:20::929])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sHClV-0004Ip-5Q; Tue, 11 Jun 2024 21:27:06 -0400
Received: by mail-ua1-x929.google.com with SMTP id
 a1e0cc1a2514c-80ba5416266so526155241.2; 
 Tue, 11 Jun 2024 18:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718155623; x=1718760423; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1mUbAhXKAQwS+AKuhuZV3faokafXg9WVg0fPwu5VBGk=;
 b=mq8IhFEdS28zgwX7oeur+RphyVkKV2aMYQLdbT4S4WrsxAUWx2VQCpu1fNCdU94RXn
 Ptpka8WMMqcwTLfwgFGN0ruSdHXl/rniU4J/TPyzSdYh5KtBDhfSquIoecaTua4kJuCU
 sioAfFMfFcKaosV7E1SBeckYPNyzEm+FdBEWViwKbwynwvVsgRiv9/ekw3Gk6kQDdRKF
 Q/5wst7FQjoTtUBBQ1ZJthiNwT/0xsXT80cw/QksW9BfhobOcTsGcvH4R7hcXm2U+8AE
 5mI6U5e+CeUoZFAPSeXXysXFZfHEKlx0KMLGYIzFNqGWIBbyroJ83qMLDxd1h/DBNIXY
 OSUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718155623; x=1718760423;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1mUbAhXKAQwS+AKuhuZV3faokafXg9WVg0fPwu5VBGk=;
 b=q/YrgVKcWSIcz5/xHap73hBa1CHY6YZGngy+l0b2g9wg1KkN9273YASta9l2GNE/k5
 FjCUMTdjZNS9WzO+kRcTUcn6SOPyGsUBcE4kwCThC1qnwURliDxHXdFzoaB0QNGazyZI
 AgfmMMoiI1oLXnY9XvbADNEnt5aJ3Himv1RAcd+qmSpDNrda9tqFObv0yKtYaT8tb4M1
 yuOUCFTZtv15kP1VPItHVuKv20MvaCcb4leoXl+ihndZi+iWwebeM8iJ+puMaV7R9uDx
 U6O7Nx8dec1A/Lz8to4rzv0UE4sEY86mUyfE1UPMr+muN4aVqyD8aLgIYuI5pM9gvI3X
 AKrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWY891hptPP3yBEfA/vax21MBSxDYZEUjC3mXEpeKUfeKA1gUVpDiLmR80sCWhULGeaWgovGLWXJCvOCZn/un6Thvk03Zs=
X-Gm-Message-State: AOJu0Yz9UfoDOAxd5GoN4XBOzoNoFMYyHwLkG7Jq45VJwtVI0CBJONw6
 n/4dVMZbxoGOiS4cdRgKLx0pbMtEYZUqXSj7nyhGOK7MDaoihvGB4wj4np4EnQtQeSDjbJhjwjJ
 unO8tcODzjy5zvz4g99PCapu+i5g=
X-Google-Smtp-Source: AGHT+IGBj6QrRdFUFQwSLPgSSH/2kIlWtOHdIXWURGPEAD1CgdjMU9yTtaBEdPqLcyFkKWHn8jsgOIRrzGybMBoQo10=
X-Received: by 2002:a05:6102:4a57:b0:48c:3442:12b2 with SMTP id
 ada2fe7eead31-48d91db98d7mr599852137.11.1718155623416; Tue, 11 Jun 2024
 18:27:03 -0700 (PDT)
MIME-Version: 1.0
References: <10817413.NyiUUSuA9g@pinacolada> <5239676.BddDVKsqQX@pinacolada>
 <CAKmqyKMRpSis8uaQVs_FTawtC-nwsFj8t7AVjrTNM4DQr-5pYw@mail.gmail.com>
 <4038765.Mh6RI2rZIc@pinacolada>
In-Reply-To: <4038765.Mh6RI2rZIc@pinacolada>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 12 Jun 2024 11:26:37 +1000
Message-ID: <CAKmqyKPEnshV3Q3M14Kon21mazY_L=Dc3jZGOF416K_WfOeZOw@mail.gmail.com>
Subject: Re: qemu-riscv32 usermode still broken?
To: "Andreas K. Huettel" <dilfridge@gentoo.org>
Cc: qemu-devel@nongnu.org, "open list:RISC-V" <qemu-riscv@nongnu.org>, 
 LIU Zhiwei <baxiantai@gmail.com>, Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::929;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x929.google.com
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

On Tue, Jun 11, 2024 at 6:57=E2=80=AFPM Andreas K. Huettel <dilfridge@gento=
o.org> wrote:
>
> Hi Alistair,
>
> >
> > Ok!
> >
> > So on my x86 machine I see this
> >
> > --- SIGCHLD {si_signo=3DSIGCHLD, si_code=3DCLD_EXITED, si_pid=3D285545,
> > si_uid=3D1000, si_status=3D0, si_utime=3D0, si_stime=3D0} ---
> > wait4(-1, [{WIFEXITED(s) && WEXITSTATUS(s) =3D=3D 0}],
> > WNOHANG|WSTOPPED|WCONTINUED, NULL) =3D 285545
> > wait4(-1, 0x7ffe3eeb8210, WNOHANG|WSTOPPED|WCONTINUED, NULL) =3D 0
> > rt_sigreturn({mask=3D[INT]})              =3D 0
> > close(3)                                =3D 0
> >
> > It all looks ok.
>
> This was fixed in the meantime (hooray!), sorry I didn't think anyone
> would still look at the old thread. The commit is given below.
>
> Since then we've been able to build riscv32 stages for Gentoo just fine
> using qemu-user, see
> https://www.gentoo.org/downloads/#riscv

Great!

Alistair

>
> Cheers,
> Andreas
>
> commit f0907ff4cae743f1a4ef3d0a55a047029eed06ff
> Author:     Richard Henderson <richard.henderson@linaro.org>
> AuthorDate: Fri Apr 5 11:58:14 2024 -1000
> Commit:     Richard Henderson <richard.henderson@linaro.org>
> CommitDate: Tue Apr 9 07:43:11 2024 -1000
>
>     linux-user: Fix waitid return of siginfo_t and rusage
>
>     The copy back to siginfo_t should be conditional only on arg3,
>     not the specific values that might have been written.
>     The copy back to rusage was missing entirely.
>
>     Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2262
>     Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>     Tested-by: Alex Fan <alex.fan.q@gmail.com>
>     Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>
>
>
> >
> > Maybe the host_to_target_siginfo() function in QEMU is the issue?
> > Something in here?
> > https://github.com/qemu/qemu/blob/master/linux-user/signal.c#L335
> >
> > Nothing jumps out with a quick look though
> >
> > Alistair
> >
> > >
> > >
> > >
> > > --
> > > Andreas K. H=C3=BCttel
> > > dilfridge@gentoo.org
> > > Gentoo Linux developer
> > > (council, toolchain, base-system, perl, libreoffice)
> >
>
>
> --
> Andreas K. H=C3=BCttel
> dilfridge@gentoo.org
> Gentoo Linux developer
> (council, toolchain, base-system, perl, libreoffice)

