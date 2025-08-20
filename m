Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 131E3CA0EDC
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 12:38:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoi4E-0006MI-OD; Wed, 20 Aug 2025 08:37:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uoi42-0006L5-Sl
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 08:37:16 -0400
Received: from mail-yb1-xb34.google.com ([2607:f8b0:4864:20::b34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uoi40-00046y-Lr
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 08:37:14 -0400
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e94f573e4f5so697008276.2
 for <qemu-devel@nongnu.org>; Wed, 20 Aug 2025 05:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755693430; x=1756298230; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F/Fers6di0nW6XLxWJQIYQleDWYoyRV2JDMTBvPqPHo=;
 b=cObSUMYSC4ouKp274PWeRGeWkzPhfIfrzas92rt4yJ0jLpo4+V40SdodzwgYIBDgBd
 xZPCGjluqWU0n60gS3eaIjgYDmWDQBHszU4pf0Fm3hkqoXDvWumkxezD+52QjWqklzVZ
 ZL+eqfhtyipn1RKlxfKZQsMK1LRgo9AySrDB0TsFm4btFdocz28XZvg5k/WVq8TOGqin
 QKhUYJR/Z+/IQ5XTPeBiIDwtG9+O/sXWXRiFoNtBbKIvfWksE2r/wuOi+iJWbDUKcdEt
 P8ddT5KUF89SB4KPF+HVugiGciHotEiIbrxV7QhAKzl5oVLZqUg0stWphZ81J1loFhtF
 Lvpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755693430; x=1756298230;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F/Fers6di0nW6XLxWJQIYQleDWYoyRV2JDMTBvPqPHo=;
 b=GXgh/gNX5NLGsnVyNQ3W+A8hrLpBxDahP00U6Q4koheeHIPb41g2IedvtElwYhiri2
 ASH155GY7Sw0402eq7WZK3o843bNQHIwzEYa1t92SQ+l9WKlrep0T+SUQFQR9cKtgHLe
 9OkCDufSdntcS/IHrmL/uhCW6w6mwtjPsqUmdPmHaFr2JxAk6jhxqI2CbM0ainEt+7s7
 2+XVJGN+octgm3emA5SLIJcEOU1+jso96r03xtOvvdT7NSNCImkM1CUaIIxWM2GL97AV
 0Zm3v7omfqMttzw63SfNDewONvysMNxe1jXqKiua54bQt9pSeSqycYSW7DBaNp2E2xz2
 NreA==
X-Gm-Message-State: AOJu0YxbhiJ6U+8pTIfd9U1IQIAAsStRwQmOt/zWm/2D+r1B0g1YNZSW
 6hm+CdZby4gFIXcC9CHbXMQR1o3CCMpzYXq7LZ41hDqjkzzpB+1b62KgSUcosxh1mKScOi4xcoJ
 SiD27akgXmxzUb0VWROle/uQXeLAbxAM+PhlgD3rUGw==
X-Gm-Gg: ASbGnctvLP6ZpJL3abCwBjufwLye78zoqW095xVCHvX3rVbgsYA0foMAvfVF8d3Cd3v
 +muigNIGRbiYLDoBq5Y/fsaquVlkhUwHXE+vd3iKTAt/m19GHkuY04VKqGzVldUaYGaeqn18/Cu
 JFSWdG2j39yVJNxXPXMl8j8MHKtmfQ0jptiIAPSewkAD9yOjVahxQmG7Nw+AEtSCnCJXjeg5hXA
 FYeCXCnqfyedcAkJ68=
X-Google-Smtp-Source: AGHT+IFfF25Ptbj1bW+SYo1Z/oKaJxjNQ+X9ENQ7esVvTU+/1X9bhDk7kT0cKYvCLBBNhRoUlMIHSUzLRN04lvmwpx0=
X-Received: by 2002:a05:6902:70a:b0:e8b:520f:62b0 with SMTP id
 3f1490d57ef6-e94f660e80fmr3747431276.44.1755693429210; Wed, 20 Aug 2025
 05:37:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250819154237.793315-1-pbonzini@redhat.com>
 <CAFEAcA-JDHPZaayuQQE-rcASP78E5UPL4UP-mHbrJAB+Um3L3g@mail.gmail.com>
 <CABgObfa8TPcZNVkq2S1aRWLVjAt1-VeLT14CK=xc2jkqxfAktg@mail.gmail.com>
In-Reply-To: <CABgObfa8TPcZNVkq2S1aRWLVjAt1-VeLT14CK=xc2jkqxfAktg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 Aug 2025 13:36:57 +0100
X-Gm-Features: Ac12FXwgJcukX1YEZA3lsDtOCer7c7PzrqQDx55sjuZNhmAl2wER8A6LFK8Qkr8
Message-ID: <CAFEAcA8+s+f2EmeMCpWci=WMWrTG4peOQHXtN-5n-szfcSbGoA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add a few more files to "Top Level Makefile
 and configure"
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, alex.bennee@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b34;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb34.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, 20 Aug 2025 at 10:46, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On Tue, Aug 19, 2025 at 6:08=E2=80=AFPM Peter Maydell <peter.maydell@lina=
ro.org> wrote:
> >
> > On Tue, 19 Aug 2025 at 16:43, Paolo Bonzini <pbonzini@redhat.com> wrote=
:
> > >
> > > A few files in scripts, and the list of packages in pythondeps.toml, =
are
> > > strictly related to the toplevel build scripts.  Add them to the
> > > MAINTAINERS file stanza.
> > >
> > > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > > ---
> > >  MAINTAINERS | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index a07086ed762..3979cffb042 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -4403,6 +4403,9 @@ R: Thomas Huth <thuth@redhat.com>
> > >  S: Maintained
> > >  F: Makefile
> > >  F: configure
> > > +F: pythondeps.toml
> > > +F: scripts/git-submodule.sh
> > > +F: scripts/meson-buildoptions.py
> >
> > This is already covered by the line in the "Meson" section:
> > F: scripts/meson-buildoptions.*
>
> Yes, that's intentional. I can change that one from py to sh, but the
> Python script that generates the option parser has more to do with
> configure/Makefile than Meson.

If you want to move the files from one category to the other
that's fine, but I think both files should be in the same
category, because one is the output of the other, so I think
it would be better to move the existing F: line from Meson to
Top Level Makefile.

thanks
-- PMM

