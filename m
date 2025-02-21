Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B659C021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 15:17:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlUlN-0005vJ-Fu; Fri, 21 Feb 2025 10:16:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tlUlD-0005td-PZ
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 10:16:16 -0500
Received: from mail-yb1-xb32.google.com ([2607:f8b0:4864:20::b32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tlUlC-00046o-0q
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 10:16:15 -0500
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e3983426f80so1755065276.1
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 07:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740150972; x=1740755772; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zavuvDd/2bEJxR4z6OMUwWIZmV5QwwWr92Hk29uHjoI=;
 b=F7gSEPiHxccJXPb2/6UK6orAYIK9JUpr2gze0nrlI7N1UJgc8mSlF6G/bzw4X3xLnF
 VEPu1EzY1d1yYsF5GhVJdk078mQVE+LSqK+XczbzhDn5ET/H6tf7GyfetU/A+bQjuoQC
 TEXJk9tV4diAvaazpyE/fmqPvEa0YZhfVekP2bUKiNCa4zVCZRPgbLCIyPsKk1zYPZMj
 zxxkA8a3MfHoJaVBo9jcVy4TcpkEaSHd39P5ZR0NDg1YznULlLHa9r1gpcsza7WUlCMx
 U/F/vv/JOn2U2n0ecR1HcbqQsoKC0MvRXckFFCXG+MqyXIDQLWnKH63ra/PAmatp3dk2
 9DpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740150972; x=1740755772;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zavuvDd/2bEJxR4z6OMUwWIZmV5QwwWr92Hk29uHjoI=;
 b=OL/4TFA79Z7IbGoQ9h8anfZuMUnqs6QeWnt8Dnz4SGqkPzSGHgU7wW1DTmdq+RjGQF
 0d83T2aPRz9YFjBk26KM3xTVwYJm6mTlUb7Yix/3mRSw14JYVSyXuFpipe6FIgGvKeNX
 i0xyPgbbBwyUili3e/t8cXFLRrSnWrl5efiUCc+L6pDYjexCQzVew1yoEEVD2BSbOW/K
 ZkD9sq7eggoX+nJUWk7NASLBlwHNrUqnbaJoloOAgH8tTEVK9bR1LitEY2nQdXOSKf0L
 Y5T+uUc+gXvtphz9/ftAnyK0NheRIxWXNBM1QrQJvebE7z23V+4UIgV1RrrwEat3o0Cj
 alRA==
X-Gm-Message-State: AOJu0YwbxkyNbsbY+5FFb/xcGwEYlUzjfHZPQ/ga8I7O+kF5sNasO6sd
 eh3Yddrbr+79XBjj8eE3L/gMYdfq4hGa4DID1qZ+b0FXC90xKZEq00qP1xcREXd9P0aacDdvvEP
 dQJwyo7+jqqACc61V6KN4GRG2yH98/L0LKO/Hzg==
X-Gm-Gg: ASbGncvjuUtNKRU643E91aIHnhwFsK9TL/qh7yua6qCCi7nLlSg/UOFTnfUq4E64Gq3
 JWJ0dQF8hTifcipiWV7xzGjMThwu9LBtas/dxiAPEUIQ4uiRsOtHwqJEanGzICKGi6oXjtYXZxy
 5S9eDTksaW
X-Google-Smtp-Source: AGHT+IFHYtwo5vPq9VPmbGTPfTTklyjfkrxI5xWEDZsWHqBha4WSb0lTwmH9lRYY9yaIFJhkaeHb6U4+oEOlUcsXbRE=
X-Received: by 2002:a05:6902:2581:b0:e5d:c97b:78a9 with SMTP id
 3f1490d57ef6-e5e8b04bcb8mr2153576276.32.1740150972517; Fri, 21 Feb 2025
 07:16:12 -0800 (PST)
MIME-Version: 1.0
References: <20250217125055.160887-1-peter.maydell@linaro.org>
 <20250217125055.160887-2-peter.maydell@linaro.org>
 <fa37f960-ff1c-49d5-a0d3-06cd2f0421e5@linaro.org>
In-Reply-To: <fa37f960-ff1c-49d5-a0d3-06cd2f0421e5@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Feb 2025 15:16:01 +0000
X-Gm-Features: AWEUYZnIn32fhWjO6-FlQ_p1G3Udrib3NLjYUrdR7xoEvW4DInGgpbmaQRjmeSA
Message-ID: <CAFEAcA8QPAt1kQnT8pPYJM8HNmX3UXagb3uxhib5MvahULn06A@mail.gmail.com>
Subject: Re: [PATCH 01/10] fpu: Make targets specify floatx80 default Inf at
 runtime
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b32;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb32.google.com
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

On Fri, 21 Feb 2025 at 14:42, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 17/2/25 13:50, Peter Maydell wrote:
> > Currently we hardcode at compile time whether the floatx80 default
> > Infinity value has the explicit integer bit set or not (x86 sets it;
> > m68k does not).  To be able to compile softfloat once for all targets
> > we'd like to move this setting to runtime.
> >
> > Define a new FloatX80Behaviour enum which is a set of flags that
> > define the target's floatx80 handling.  Initially we define just one
> > flag, for whether the default Infinity has the Integer bit set or
> > not, but we will expand this in future commits to cover the other
> > floatx80 target specifics that we currently make compile-time
> > settings.
> >
> > Define a new function floatx80_default_inf() which returns the
> > appropriate default Infinity value of the given sign, and use it in
> > the code that was previously directly using the compile-time constant
> > floatx80_infinity_{low,high} values when packing an infinity into a
> > floatx80.
> >
> > Since floatx80 is highly unlikely to be supported in any new
> > architecture, and the existing code is generally written as "default
> > to like x87, with an ifdef for m68k", we make the default value for
> > the floatx80 behaviour flags be "what x87 does".  This means we only
> > need to change the m68k target to specify the behaviour flags.
> >
> > (Other users of floatx80 are the Arm NWFPE emulation, which is
> > obsolete and probably not actually doing the right thing anyway, and
> > the PPC xsrqpxp insn.  Making the default be "like x87" avoids our
> > needing to review and test for behaviour changes there.)
> >
> > We will clean up the remaining uses of the floatx80_infinity global
> > constant in subsequent commits.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >   include/fpu/softfloat-helpers.h | 12 ++++++++++++
> >   include/fpu/softfloat-types.h   | 13 +++++++++++++
> >   include/fpu/softfloat.h         |  1 +
> >   fpu/softfloat.c                 |  7 +++----
> >   target/m68k/cpu.c               |  6 ++++++
> >   fpu/softfloat-specialize.c.inc  | 10 ++++++++++
> >   6 files changed, 45 insertions(+), 4 deletions(-)
>
>
> > diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> > index f4fed9bfda9..b12ad2b42a9 100644
> > --- a/fpu/softfloat.c
> > +++ b/fpu/softfloat.c
> > @@ -1860,7 +1860,8 @@ static floatx80 floatx80_round_pack_canonical(Flo=
atParts128 *p,
> >
> >       case float_class_inf:
> >           /* x86 and m68k differ in the setting of the integer bit. */
> > -        frac =3D floatx80_infinity_low;
> > +        frac =3D s->floatx80_behaviour & floatx80_default_inf_int_bit_=
is_zero ?
> > +            0 : (1ULL << 63);
>
> Indent off

This is the indent emacs uses here, and it's the usual
"4 spaces in for an expression continued onto the next line"
I think.

-- PMM

