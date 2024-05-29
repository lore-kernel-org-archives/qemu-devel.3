Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CAE8C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 08:25:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCEc4-0008I6-6o; Wed, 29 May 2024 04:24:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vilhelmgyda@gmail.com>)
 id 1sCEc2-0008Gn-2x; Wed, 29 May 2024 04:24:46 -0400
Received: from mail-il1-x134.google.com ([2607:f8b0:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vilhelmgyda@gmail.com>)
 id 1sCEc0-0005bm-HP; Wed, 29 May 2024 04:24:45 -0400
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-3737b47c0acso7944685ab.3; 
 Wed, 29 May 2024 01:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716971083; x=1717575883; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0okrfew+nLZRIuP3q6SeUlZm+tSKJscXSlAspKZCnY4=;
 b=LNhNMpW5dQNtdebPsrT4rXnVi2u3xDH2xIs+qdDu21Lohac3XsiKzr7Rrkurb4XrLZ
 jmjYwXC5uNLK1l3aKciNtsLDsPODf+433CS2wRlFyNn6gU78hnkqKFFDDeQnFbpRlvkC
 24/xHOzslXYnMgop+3iscrzPyJ6VvRb/kOAJq3qHEZoEmAtQA3rsf0UQbsWpWyA58iPE
 W7jT+A2tJE+oihOgTQLIK0w0dvCNO4qCbTKZ5Yx/ePwXgYM9QK8weqHQnu7YYBdSC8wT
 SCCTsxAhxsieGeZO5YjPfZCTBWAL+WVy0kmSeDR2MIb8uzv7Ge7bwFpmnL0sCs2d3UvT
 k5ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716971083; x=1717575883;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0okrfew+nLZRIuP3q6SeUlZm+tSKJscXSlAspKZCnY4=;
 b=c5ZCJExUp4YePFdqJiRBJdqTX5ysE/8Vx1tqTZw7sJXngHoGkZwX0SM6O7z/ntmvuU
 2UwybUmrK8/H0l1BuXNlHzVCukivZGN5RlcbgpKxCNAxk0ebDKnfANjk53/o/QW4ClsH
 FOAaOE2U0EPwwNIqiq1dEuhXzHvSOdW1Yds34QfMh8bB0qvKfBFHsz+nAz8PisDRI+/l
 cdU3kn+TCI++NtHh8V1lHhp5DNvUNT0Id+u49SrXiVj+bIZTqcowx8HS973UP+doH9CB
 7l3TrnGqdoQmCSckgLNelOClqo1KpyRfE2aj18lVVq3mM5YW8b5PUo0bolr9cLcPwpUM
 Gb2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQC/KJcjHQJofN/HbGPqowDE7REGNdFpQ1C+WO0btowqrjvRov2xq8xJyoSC3A2V9tFh3N68ojea5Tj0gMGggpAJpuhaFOfw==
X-Gm-Message-State: AOJu0YyGHEpHkWsjdU7aJKiFkXmcZC6CcqoLaajxOvM6k0TAXtFNFNLn
 srcXRZH0wcIUgKYujHKlazyf3vsEP2Ca96abthHjqRLaSalm0/Yphrq8dt+Yexp7czKbi+qSSSB
 llYs6X0IZoGwbOLfvhpsV7RQt4lQ=
X-Google-Smtp-Source: AGHT+IFjwDDnhOSGWw7wu7VjhcAME7pNGItSd2iitJliFRx59ukTBScuK4Z6wsNXCZAUtWBzA3D5w58tcqeBpA5kwkE=
X-Received: by 2002:a92:8711:0:b0:373:8075:6e16 with SMTP id
 e9e14a558f8ab-373807574bbmr127454935ab.7.1716971082588; Wed, 29 May 2024
 01:24:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240528102339.106257-1-vilhelmgyda@gmail.com>
 <c5e14ee6-1ea7-4deb-be37-8d6b4de9f388@redhat.com>
In-Reply-To: <c5e14ee6-1ea7-4deb-be37-8d6b4de9f388@redhat.com>
From: Vilhelm Gyda <vilhelmgyda@gmail.com>
Date: Wed, 29 May 2024 13:54:31 +0530
Message-ID: <CADe4k3J9W-STUL5VvYM--7O+1WGnowqn3wUOy2QJo5nvZjLBuQ@mail.gmail.com>
Subject: Re: [PATCH] Issue #2294 | Machine microvm doesn't run under Xen accel
 for x86_64
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, philmd@linaro.org, 
 richard.henderson@linaro.org, eduardo@habkost.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::134;
 envelope-from=vilhelmgyda@gmail.com; helo=mail-il1-x134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

@philmd commented on gitlab: Discussed with @epilys on IRC, only Xen
machines (xenpv/xenfv) configure Xen so can run under it.

But if we want to make it work under Xen. Any ideas how to move in
that direction?

On Wed, May 29, 2024 at 12:37=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com=
> wrote:
>
> On 5/28/24 12:23, Will Gyda wrote:
> > Issue #2294: Machine microvm doesn't run under Xen accel for qemu-syste=
m-x86_64.
> > Solution: microvm is now not build if only Xen is available.
>
> This does not fix the issue that microvm does not start with a Xen
> accelerator.  I think it would be better to try and make it work instead.
>
> Paolo
>
> > Signed-off-by: Will Gyda <vilhelmgyda@gmail.com>
> >
> > ---
> >   configs/devices/i386-softmmu/default.mak | 2 +-
> >   hw/i386/Kconfig                          | 2 ++
> >   2 files changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/configs/devices/i386-softmmu/default.mak b/configs/devices=
/i386-softmmu/default.mak
> > index 598c6646df..6a73aee7dd 100644
> > --- a/configs/devices/i386-softmmu/default.mak
> > +++ b/configs/devices/i386-softmmu/default.mak
> > @@ -29,4 +29,4 @@
> >   CONFIG_ISAPC=3Dy
> >   CONFIG_I440FX=3Dy
> >   CONFIG_Q35=3Dy
> > -CONFIG_MICROVM=3Dy
> > +#CONFIG_MICROVM=3Dn
> > diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
> > index a6ee052f9a..f8ec8ebd7a 100644
> > --- a/hw/i386/Kconfig
> > +++ b/hw/i386/Kconfig
> > @@ -108,6 +108,8 @@ config Q35
> >
> >   config MICROVM
> >       bool
> > +    default y
> > +    depends on KVM || WHPX || NVMM || HVF
> >       select SERIAL_ISA # for serial_hds_isa_init()
> >       select ISA_BUS
> >       select APIC
>

