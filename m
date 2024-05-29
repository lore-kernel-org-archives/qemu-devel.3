Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4CFAC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 10:11:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCGFd-0007RH-IR; Wed, 29 May 2024 06:09:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sCGFa-0007Qk-7K
 for qemu-devel@nongnu.org; Wed, 29 May 2024 06:09:42 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sCGFY-0003tN-47
 for qemu-devel@nongnu.org; Wed, 29 May 2024 06:09:41 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-578517c7ae9so2254286a12.3
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 03:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716977377; x=1717582177; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XV3prPJYsg9INgPiJMwsNdqvgeHqmLfHaBWgp9S+Bi4=;
 b=VWDrajXu+YGW7tdXtGaEMYXnCl8bEuzMk+JIlWWCetUyywHdmgTwrwt6t/jL3PDpWP
 +hm/njwWQ3oiKTbO7fuf6OxbruzG/aOES0PsbsdLHGLt7RNXUAPW7c6u0lrHcYMwZMnB
 DyfmSCggBPy4z20yRpXt/w5p2PqhWMS7VuJjNhq/Ygu/eM8Q7d2bX37FM9DhNoi1tukv
 q6gfuhYhXd/hk+PsCGCUHOsYKS8o8U3eg5VtuIdumvDRiykL0j0ehWBSwLrQHpd5U/nU
 aulw7LiuhSOYcj1Fafz3XvaagdrAMM5E9acge1v09YobIy1kACgruaG+RpUMijxZVDwq
 87mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716977377; x=1717582177;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XV3prPJYsg9INgPiJMwsNdqvgeHqmLfHaBWgp9S+Bi4=;
 b=LoLGui74sD6juXEKKv3qdaawPm6mwvE8YGCdt0NeozKwmO+kYS9bsvTLq9RMcfsN7W
 ip5fTamsK05ukNkCbD3itam0w93pOZUnt+FAo1vfjGY9v4vexCkRNqHwlXdCkqBjNw9+
 r7Na+MsElmcd0QSytCcFVYU+0UgAXprBn62RRHQ8ZVHQdY1VqGNlTxkaWRPGPnuut2B1
 p65lpMp60yNM09HhH2qM5jChz08UeZMygFaUIU0ZvfCUiW38LxUA3meqM87yNGE/e4zP
 kzxpJ4kAit2ce0yhisudWof+Sek+TOIQVbOAJLwZ1TidsKfKvhPA4ypZ8+NZmCY2YQfD
 ARlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX69evN1fMrne6twEP4icXpkZ3OGOyYJ8+pqjpuRTC3CJ8YYh2SnXiifR9tHNzkh8ykmMaQNralsst4HvGvB8gzOA/lYlQ=
X-Gm-Message-State: AOJu0YxXIUYA0MzrgShyXOePChPwQYuRAvhBlJEt2lNIk/+ovPhxL7Wk
 2aIMJO7xJSirz7QnrAFQikc5DIjgBIFWOIfxOFZHYJdyhcGFlHeL/G53330hi7A1PalvJq5hfq1
 7Uxo7YIk0+9MHZx25FcKHVKhh8zfOJLn1Vv4WUg==
X-Google-Smtp-Source: AGHT+IEOt5g5vURQtO1bLs0ybOgeJAHvJtapuIAUN8M0uIr4wv2am2UsM4nkEYa4DHISOnzJkfofhs7Nl+ZGoPKGHdw=
X-Received: by 2002:a17:906:f581:b0:a62:9068:3f3 with SMTP id
 a640c23a62f3a-a629068056emr1028705166b.41.1716977376711; Wed, 29 May 2024
 03:09:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240528102339.106257-1-vilhelmgyda@gmail.com>
 <c5e14ee6-1ea7-4deb-be37-8d6b4de9f388@redhat.com>
 <CADe4k3J9W-STUL5VvYM--7O+1WGnowqn3wUOy2QJo5nvZjLBuQ@mail.gmail.com>
In-Reply-To: <CADe4k3J9W-STUL5VvYM--7O+1WGnowqn3wUOy2QJo5nvZjLBuQ@mail.gmail.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Wed, 29 May 2024 13:09:20 +0300
Message-ID: <CAAjaMXafs8fg9uPoksn_Nui7pvBfXDfvRAwuEGJr1RUC07taLw@mail.gmail.com>
Subject: Re: [PATCH] Issue #2294 | Machine microvm doesn't run under Xen accel
 for x86_64
To: Vilhelm Gyda <vilhelmgyda@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org, 
 philmd@linaro.org, richard.henderson@linaro.org, eduardo@habkost.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, 29 May 2024 at 11:25, Vilhelm Gyda <vilhelmgyda@gmail.com> wrote:
>
> @philmd commented on gitlab: Discussed with @epilys on IRC, only Xen
> machines (xenpv/xenfv) configure Xen so can run under it.
>
> But if we want to make it work under Xen. Any ideas how to move in
> that direction?

We'd have to specify what "works under Xen" means; xen as a type 1
hypervisor? I am trying to think if it makes sense, Xen machines in
qemu already provide PV devices analogously to what microvm promises
to support. What would be the use case for a  "hypervisor agnostic"
microvm machine?

>
> On Wed, May 29, 2024 at 12:37=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.c=
om> wrote:
> >
> > On 5/28/24 12:23, Will Gyda wrote:
> > > Issue #2294: Machine microvm doesn't run under Xen accel for qemu-sys=
tem-x86_64.
> > > Solution: microvm is now not build if only Xen is available.
> >
> > This does not fix the issue that microvm does not start with a Xen
> > accelerator.  I think it would be better to try and make it work instea=
d.
> >
> > Paolo
> >
> > > Signed-off-by: Will Gyda <vilhelmgyda@gmail.com>
> > >
> > > ---
> > >   configs/devices/i386-softmmu/default.mak | 2 +-
> > >   hw/i386/Kconfig                          | 2 ++
> > >   2 files changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/configs/devices/i386-softmmu/default.mak b/configs/devic=
es/i386-softmmu/default.mak
> > > index 598c6646df..6a73aee7dd 100644
> > > --- a/configs/devices/i386-softmmu/default.mak
> > > +++ b/configs/devices/i386-softmmu/default.mak
> > > @@ -29,4 +29,4 @@
> > >   CONFIG_ISAPC=3Dy
> > >   CONFIG_I440FX=3Dy
> > >   CONFIG_Q35=3Dy
> > > -CONFIG_MICROVM=3Dy
> > > +#CONFIG_MICROVM=3Dn
> > > diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
> > > index a6ee052f9a..f8ec8ebd7a 100644
> > > --- a/hw/i386/Kconfig
> > > +++ b/hw/i386/Kconfig
> > > @@ -108,6 +108,8 @@ config Q35
> > >
> > >   config MICROVM
> > >       bool
> > > +    default y
> > > +    depends on KVM || WHPX || NVMM || HVF
> > >       select SERIAL_ISA # for serial_hds_isa_init()
> > >       select ISA_BUS
> > >       select APIC
> >
>



--=20
Manos Pitsidianakis
Emulation and Virtualization Engineer at Linaro Ltd

