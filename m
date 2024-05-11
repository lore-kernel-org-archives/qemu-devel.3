Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D605FC04FFE
	for <qemu-devel@archiver.kernel.org>; Sat, 11 May 2024 11:10:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5kc3-0007Ez-51; Sat, 11 May 2024 07:09:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dario.binacchi@amarulasolutions.com>)
 id 1s5kc1-0007Eg-Nr
 for qemu-devel@nongnu.org; Sat, 11 May 2024 07:09:57 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dario.binacchi@amarulasolutions.com>)
 id 1s5kbz-00065a-Rp
 for qemu-devel@nongnu.org; Sat, 11 May 2024 07:09:57 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-61e04fcf813so31907397b3.3
 for <qemu-devel@nongnu.org>; Sat, 11 May 2024 04:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1715425773; x=1716030573; darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Awvu+8Xl7Z7R9R6vOoF6vDVr7B9+NsQt5jgs/ERdLXY=;
 b=jDTcukYuwdweSYYLEd7Mfx5BIgbEzQDjozprc6Vwc3YNQN1LyNcyLdmCUC6oK7p3na
 DfwLItJUX1uUlu9+AjuFRO25QDpnO/PV9F2duc1b3NVlZXCUeeD0LSin8pdAqOufTTGM
 mUDTOfBXeSNZY522Ch9qY+MsPTmPiIMzNtEPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715425773; x=1716030573;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Awvu+8Xl7Z7R9R6vOoF6vDVr7B9+NsQt5jgs/ERdLXY=;
 b=CVJAFxpIEtMQStgqF2BcFIEheyDLBK8tGwKNkhu1MKsGNfro6lxvdFv8nDs0pVRDZ/
 QVaDEfLh7IaLtmkOpiaBSK2azb/ZWYlrzbLqe/L2u8wj+VTlTaI24qaS9gl8cPGn85wg
 4aXz+n3R8/+ODXlr5zovQV71Z7Tm4v1ZkR4YUlftguPfaWkK2xUTuDfFL9bhS3ENg8IP
 B46r6hvMsGouNqye6nbOb0T/ZhMkQ4Oj8tn7BB+xYtklXKY+PxZvdrFAjrvG+Xvha4cg
 f+Rp2hDH4RHRAtSVp0H3V8e/d5d+1nWwHLLZrFAloTkNTcMF6RJ4wXcqpGb7TBVvBvhv
 gPlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNHciY1nuwCOBybqnPE+aKipR1pvY3Mnx9SPQOlbMjempU7s9ux7REC3coVDBQ0z5rkksHbZaXkV3oU1kDEJOyefRJUSw=
X-Gm-Message-State: AOJu0Yy/IhbPLDhv7JAA1mao1F4w4V/utM0Ac9idR+PNeRZ7CcusjyEI
 VcJUNeO+WrnmwukAQXR99Tq1wwvOmSdkMyfZAkOMr3juKCXIEqZ/ZfIv38tGIj8pm3GZ7u0BvgT
 0SZi9znoAbOnJkeFXWO9G1AxuQi2ohwZmYLxDGg==
X-Google-Smtp-Source: AGHT+IFigKfNE7KdzHp0uSBGn3HBoXHevuYcuWUJjv2p00baNd86lrt5pIR1qK1UWwcHtiNpZMJZ89BvHoYkbv5KDw4=
X-Received: by 2002:a25:870e:0:b0:dcc:6d85:586a with SMTP id
 3f1490d57ef6-dee4f4dad16mr4777040276.49.1715425773159; Sat, 11 May 2024
 04:09:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240430164752.645521-1-dario.binacchi@amarulasolutions.com>
 <63094227-235e-4274-b308-2d7c27e50b81@linaro.org>
 <CABGWkvrCNoWDB=V5f_7qwCd97dAfOC3XT2ukXYt-FsxuUKK-KQ@mail.gmail.com>
 <4ad368ae-74d0-4a38-b4d9-d907c1b8dc7c@linaro.org>
 <CABGWkvo_eaDFC15JQF8+Pu14M75CKWvVr8JWQ7XJuHc8fCc7LA@mail.gmail.com>
 <CABGWkvqXdJtiiO2gWC2VTcLvYD33KHe5Rb49Q=VDrtkEiODxOw@mail.gmail.com>
 <8b84b9ae-fda6-49c2-90dd-40d8660561c5@linaro.org>
In-Reply-To: <8b84b9ae-fda6-49c2-90dd-40d8660561c5@linaro.org>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Sat, 11 May 2024 13:09:21 +0200
Message-ID: <CABGWkvom8s3KEV=9wKxp1=UK+r1jaOns9MqK9OhuMUyxVskznA@mail.gmail.com>
Subject: Re: [PATCH 1/1] tests/fp/meson: don't build fp-bench test if fenv.h
 is missing
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, michael@amarulasolutions.com, 
 linux-amarula@amarulasolutions.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=dario.binacchi@amarulasolutions.com;
 helo=mail-yw1-x1134.google.com
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

On Sat, May 11, 2024 at 12:25=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 5/11/24 12:11, Dario Binacchi wrote:
> > Gentle ping.
>
> Gentle reminder that I strongly suspect that your buildroot is corrupt.
> There *should* be a <fenv.h> present.

I don't think so. In fact, the patch has already been merged into Buildroot=
:
https://patchwork.ozlabs.org/project/buildroot/patch/20240502072327.741463-=
1-dario.binacchi@amarulasolutions.com/

As mentioned earlier:
"The fenv support is not enabled in our default uClibc configurations"
https://lists.buildroot.org/pipermail/buildroot/2013-May/072440.html

Thanks and regards,
Dario


>
>
> r~
>
> >
> > Thanks,
> > Dario
> >
> > On Wed, May 1, 2024 at 4:17=E2=80=AFPM Dario Binacchi
> > <dario.binacchi@amarulasolutions.com> wrote:
> >>
> >> Hello Richard,
> >>
> >> On Wed, May 1, 2024 at 3:31=E2=80=AFPM Richard Henderson
> >> <richard.henderson@linaro.org> wrote:
> >>>
> >>> On 5/1/24 05:18, Dario Binacchi wrote:
> >>>> Hello Richard,
> >>>>
> >>>> On Tue, Apr 30, 2024 at 8:15=E2=80=AFPM Richard Henderson
> >>>> <richard.henderson@linaro.org> wrote:
> >>>>>
> >>>>> On 4/30/24 09:47, Dario Binacchi wrote:
> >>>>>> The fp-bench test (i. e. tests/fp/fp-bench.c) use fenv.h that is n=
ot
> >>>>>> always provided by the libc (uClibc). The patch disables its compi=
lation
> >>>>>> in case the header is not available.
> >>>>>
> >>>>> Since uclibc has had fenv.h since 2008, are you sure this isn't sim=
ply a case of a corrupt
> >>>>> installation?
> >>>>
> >>>>>
> >>>>>
> >>>>> r~
> >>>>
> >>>> It's not an issue of corrupted installation but rather of compilatio=
n:
> >>>
> >>> Installation of your cross-compiler or buildroot, I mean.
> >>>
> >>>>
> >>>> ../tests/fp/fp-bench.c:15:10: fatal error: fenv.h: No such file or d=
irectory
> >>>>      15 | #include <fenv.h>
> >>>>         |          ^~~~~~~~
> >>>> compilation terminated.
> >>>
> >>> Yes, yes.  However, <fenv.h> is present in uclibc-ng, and has been si=
nce 2008.
> >>> So *why* is fenv.h not present?
> >>
> >> I found the fenv.h files here:
> >> out/emulator/host/opt/ext-toolchain/i686-buildroot-linux-uclibc/includ=
e/c++/11.3.0/tr1/fenv.h
> >> out/emulator/host/opt/ext-toolchain/i686-buildroot-linux-uclibc/includ=
e/c++/11.3.0/fenv.h
> >>
> >> But the compiler expects them in:
> >> out/emulator/host/i686-buildroot-linux-uclibc/sysroot/usr/include/
> >>
> >> So, I think that the fenv support has not been enabled in uClibc
> >> configuration of Buildroot.
> >>
> >> Thanks and regards,
> >> Dario
> >>
> >>>
> >>>
> >>> r~
> >>
> >>
> >>
> >> --
> >>
> >> Dario Binacchi
> >>
> >> Senior Embedded Linux Developer
> >>
> >> dario.binacchi@amarulasolutions.com
> >>
> >> __________________________________
> >>
> >>
> >> Amarula Solutions SRL
> >>
> >> Via Le Canevare 30, 31100 Treviso, Veneto, IT
> >>
> >> T. +39 042 243 5310
> >> info@amarulasolutions.com
> >>
> >> www.amarulasolutions.com
> >
> >
> >
>


--=20

Dario Binacchi

Senior Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com

