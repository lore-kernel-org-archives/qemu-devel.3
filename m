Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 786F9C04FFE
	for <qemu-devel@archiver.kernel.org>; Sat, 11 May 2024 10:12:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5jhh-0005Zn-98; Sat, 11 May 2024 06:11:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dario.binacchi@amarulasolutions.com>)
 id 1s5jhf-0005Y3-Kq
 for qemu-devel@nongnu.org; Sat, 11 May 2024 06:11:43 -0400
Received: from mail-yb1-xb2d.google.com ([2607:f8b0:4864:20::b2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dario.binacchi@amarulasolutions.com>)
 id 1s5jhZ-0002CP-Hs
 for qemu-devel@nongnu.org; Sat, 11 May 2024 06:11:43 -0400
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-de610800da0so2546614276.2
 for <qemu-devel@nongnu.org>; Sat, 11 May 2024 03:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1715422294; x=1716027094; darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UyBQoo06HsWvTXRFgcJgiznhcvxeBnn+oXzUfipf4C0=;
 b=mPOGFGYpbs14jdwxyyEa+wB9w+Tqo46ycQG0QAtMonON8dPqDmeWW8UNzMCikEgyUP
 PtM9F+eZYcKEBxRX682SF2GwBvL6oCu+L//oWvcooz9jLcLfnfnSHi98zg4chXO/UgUn
 qc9TxZgIq205Q5wbrGmIrkiEzZ8VqK3f4kGGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715422294; x=1716027094;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UyBQoo06HsWvTXRFgcJgiznhcvxeBnn+oXzUfipf4C0=;
 b=bfRrH6cWtvAySqZNKqJKeUGE4HUdpBmKorhe504x/qRm1/PXGG41X70W9EJW4nKqIn
 cGEvlmkwDyq1Nhk6qXVyElAZseyGof/pUj8LkHSTm/sUTHzkXn9gYGFbEJDETddbFIMX
 20Ko4ued5I8u4T6IP1GSljrhZZ+dcZD5wc99g5ZYTx5LsUYQ4PJs0Eq0hISOCwbgT+jy
 cQalNfDF1lhzo8n2GGjqdRf/1ncpEtMcuHygHf+fdARau4YixneKsGkmsogkU0tvJGed
 LmUh9/kpa4um4WlSW1mV4YgV1ZS1nBbWYRKQlyUgID0g+0fFrybDdk02lrMQdnDXe9YQ
 9sMw==
X-Gm-Message-State: AOJu0YwXy7ccMLJrb+VhEGunyy5y/7vAcyd0Pwgk4NeW1yhYvU+viefd
 P6u3OQBNs5wwy6fHEccce+Jxh4MtPvudZGyXbKnqt0T4citz4YlnDWUMNav0srcoqdj+wncVFO3
 b8TLBdvsBcLFWDjBk17r3BP/ARAyseVszo+c95w==
X-Google-Smtp-Source: AGHT+IF6jJbzrZ04wA9YYPi6L+tJgMoi9yXj94RvVVejE9n0GOXnKtyblQDIwRnJR4gmgp6dwmoVIuTPdGiKOh2JehE=
X-Received: by 2002:a25:ae90:0:b0:dcd:2f89:6aac with SMTP id
 3f1490d57ef6-dee4f1b7b86mr4937243276.10.1715422294274; Sat, 11 May 2024
 03:11:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240430164752.645521-1-dario.binacchi@amarulasolutions.com>
 <63094227-235e-4274-b308-2d7c27e50b81@linaro.org>
 <CABGWkvrCNoWDB=V5f_7qwCd97dAfOC3XT2ukXYt-FsxuUKK-KQ@mail.gmail.com>
 <4ad368ae-74d0-4a38-b4d9-d907c1b8dc7c@linaro.org>
 <CABGWkvo_eaDFC15JQF8+Pu14M75CKWvVr8JWQ7XJuHc8fCc7LA@mail.gmail.com>
In-Reply-To: <CABGWkvo_eaDFC15JQF8+Pu14M75CKWvVr8JWQ7XJuHc8fCc7LA@mail.gmail.com>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Sat, 11 May 2024 12:11:23 +0200
Message-ID: <CABGWkvqXdJtiiO2gWC2VTcLvYD33KHe5Rb49Q=VDrtkEiODxOw@mail.gmail.com>
Subject: Re: [PATCH 1/1] tests/fp/meson: don't build fp-bench test if fenv.h
 is missing
To: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, michael@amarulasolutions.com, 
 linux-amarula@amarulasolutions.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2d;
 envelope-from=dario.binacchi@amarulasolutions.com;
 helo=mail-yb1-xb2d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Gentle ping.

Thanks,
Dario

On Wed, May 1, 2024 at 4:17=E2=80=AFPM Dario Binacchi
<dario.binacchi@amarulasolutions.com> wrote:
>
> Hello Richard,
>
> On Wed, May 1, 2024 at 3:31=E2=80=AFPM Richard Henderson
> <richard.henderson@linaro.org> wrote:
> >
> > On 5/1/24 05:18, Dario Binacchi wrote:
> > > Hello Richard,
> > >
> > > On Tue, Apr 30, 2024 at 8:15=E2=80=AFPM Richard Henderson
> > > <richard.henderson@linaro.org> wrote:
> > >>
> > >> On 4/30/24 09:47, Dario Binacchi wrote:
> > >>> The fp-bench test (i. e. tests/fp/fp-bench.c) use fenv.h that is no=
t
> > >>> always provided by the libc (uClibc). The patch disables its compil=
ation
> > >>> in case the header is not available.
> > >>
> > >> Since uclibc has had fenv.h since 2008, are you sure this isn't simp=
ly a case of a corrupt
> > >> installation?
> > >
> > >>
> > >>
> > >> r~
> > >
> > > It's not an issue of corrupted installation but rather of compilation=
:
> >
> > Installation of your cross-compiler or buildroot, I mean.
> >
> > >
> > > ../tests/fp/fp-bench.c:15:10: fatal error: fenv.h: No such file or di=
rectory
> > >     15 | #include <fenv.h>
> > >        |          ^~~~~~~~
> > > compilation terminated.
> >
> > Yes, yes.  However, <fenv.h> is present in uclibc-ng, and has been sinc=
e 2008.
> > So *why* is fenv.h not present?
>
> I found the fenv.h files here:
> out/emulator/host/opt/ext-toolchain/i686-buildroot-linux-uclibc/include/c=
++/11.3.0/tr1/fenv.h
> out/emulator/host/opt/ext-toolchain/i686-buildroot-linux-uclibc/include/c=
++/11.3.0/fenv.h
>
> But the compiler expects them in:
> out/emulator/host/i686-buildroot-linux-uclibc/sysroot/usr/include/
>
> So, I think that the fenv support has not been enabled in uClibc
> configuration of Buildroot.
>
> Thanks and regards,
> Dario
>
> >
> >
> > r~
>
>
>
> --
>
> Dario Binacchi
>
> Senior Embedded Linux Developer
>
> dario.binacchi@amarulasolutions.com
>
> __________________________________
>
>
> Amarula Solutions SRL
>
> Via Le Canevare 30, 31100 Treviso, Veneto, IT
>
> T. +39 042 243 5310
> info@amarulasolutions.com
>
> www.amarulasolutions.com



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

