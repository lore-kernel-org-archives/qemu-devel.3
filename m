Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1362EC27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 13:35:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJvSU-0003Ez-7P; Wed, 19 Jun 2024 09:34:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sJvSS-0003ER-V1
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 09:34:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sJvSR-0007qm-AG
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 09:34:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718804078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ckW/bLbhz6NquyaPfBKRNWwm2zNUxxWicrdTgvXv4qk=;
 b=LQvjJ9Fys/6C/FXgRAJ8BVeGBpgoXH0DHMs18kYZ+WNxP8XRkv93w1pEtBX4PSgIrmcdEn
 0Icj3aUS9zkjWv/h7ESMyN4E78p0Xk6yladIcWkBYDbFu1XBH56FgC3/oANlqViUcyy0su
 jNORQiLz2iDXNaDZ/oi53BGgpExdjGA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-oZZCdSSpOPqmBE3aLl2FZg-1; Wed, 19 Jun 2024 09:34:35 -0400
X-MC-Unique: oZZCdSSpOPqmBE3aLl2FZg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4246cf4c87dso17983835e9.2
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 06:34:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718804074; x=1719408874;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ckW/bLbhz6NquyaPfBKRNWwm2zNUxxWicrdTgvXv4qk=;
 b=bPEpuT29tOpiykvL8YKntljOaotDDUpZ3YcZ9lSS+hOVVlB+qVWcSnG/zjxgLwlFDf
 QP6yQ3BjZ5lc+5wm70PnxcCfyaorFiZTv/3yPMCWYADdDCxIZZ3G6PXRyY/PM6v1t6vs
 uWMrButpE26/tVRQ8Scd/A/fG2oNVFYUguo6tbd4iybTek5y7QywAheuD5L9jHrEjEn5
 9zftu4rSkhUudZLf/jpyeAe0qAckHStXKWwSegGpSN4gqbpcksWAohfc2xCfsEBF7slL
 DWGPywR4fTKI8HJH/rIIpU3nk6l2NxR0HyoJ3tPOnJ8EE4IfUqwDlC/z3n4J25twNyJg
 GX0Q==
X-Gm-Message-State: AOJu0YzuH5Ygt8JgLuOwZpn79uLFCRjKoL1AngjvpVbkASde2qPuhfWu
 W6l1Q+Xr8nL0B8xzJrOjJ8EBznIBo5IxoqUbdduMVaR1GBI8pIPNog1MMTEa9PhdIJHu61uBufG
 nVY1o+L9lit2VHk0YgfOwvqAsayqDcJrz0FXT5jA5rtklcbf72U7FAGrIKExJ6R+uwaIYlIQ+wf
 xi3foFYUEKQzN7xMRlKOcnBrLM7hY=
X-Received: by 2002:a5d:6783:0:b0:360:791c:aff2 with SMTP id
 ffacd0b85a97d-363195b234amr1815820f8f.47.1718804074758; 
 Wed, 19 Jun 2024 06:34:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfkXq4McBWH4kOIE3HoV7pAi3VcmKAf4Bb97WPeSkw4L3SSPrGKEBEP9TETEp0isWAGiViaIRvRjvJRHkjExo=
X-Received: by 2002:a5d:6783:0:b0:360:791c:aff2 with SMTP id
 ffacd0b85a97d-363195b234amr1815809f8f.47.1718804074438; Wed, 19 Jun 2024
 06:34:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240619114616.251610-1-pbonzini@redhat.com>
 <0c71a089-47a7-4d07-954a-aa5071cb563f@redhat.com>
In-Reply-To: <0c71a089-47a7-4d07-954a-aa5071cb563f@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 19 Jun 2024 15:34:23 +0200
Message-ID: <CABgObfYn4niv9XN1qr+u2vyCtxepdezZdnLGyuW8ekj0v336ow@mail.gmail.com>
Subject: Re: [PATCH] configure: detect --cpu=mipsisa64r6
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, Jun 19, 2024 at 2:49=E2=80=AFPM Thomas Huth <thuth@redhat.com> wrot=
e:
>
> On 19/06/2024 13.46, Paolo Bonzini wrote:
> > Treat it as a MIPS64 machine.
>
> Where did you encounter it?

It is handled by "config.sub" (the GNU script to canonicalize target
triples). and is also in the list produced by "rustc --print
target-list" on Fedora 40. So it seems like something that could be
passed to --cpu.

The argument to --cpu, plus an autodetected OS, is also as close as we
can get to building the tuple for "cargo --target
CPU-MACHINE-OS-VARIANT".

> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >   configure | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/configure b/configure
> > index d0703ea279d..3669eec86e5 100755
> > --- a/configure
> > +++ b/configure
> > @@ -452,7 +452,7 @@ case "$cpu" in
> >       linux_arch=3Dloongarch
> >       ;;
> >
> > -  mips64*)
> > +  mips64*|mipsisa64*)
>
> Maybe simply switch to mips*64*) ?

Not sure if it's a good idea, since we know the exact prefixes.

Paolo


