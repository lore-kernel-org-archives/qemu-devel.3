Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F13B7C27C53
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Jun 2024 07:26:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKv7w-0001VY-RC; Sat, 22 Jun 2024 03:25:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hyeongtak.ji@gmail.com>)
 id 1sKv7v-0001Uz-Cs; Sat, 22 Jun 2024 03:25:35 -0400
Received: from mail-qv1-xf2a.google.com ([2607:f8b0:4864:20::f2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hyeongtak.ji@gmail.com>)
 id 1sKv7t-000147-Ke; Sat, 22 Jun 2024 03:25:35 -0400
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6b42574830fso11642616d6.2; 
 Sat, 22 Jun 2024 00:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719041132; x=1719645932; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4O0pn9RI1XCGhhWq/KO2tjBqC+ja5n+u4HYedNdgJdc=;
 b=Xs3BdrfSGjqc/IAc8SD6f6YDTmM1Xe6HnfM8LdMySmTMlISBlWzAK+SpLemtrzxUvT
 IDEJPSwhp6bb5LzxUD/D3wZBl56F83tvs15varUbNIkmrx00bVr1uZT7osNL/peIwTfc
 3e+uBuNAURlEkoKO9A7/ZAT3K9wT/Xrj2+IFSsIDWWOWfUbplFhGByTvdMqzf7Ew8wvU
 lMJCGEbZekp5nHeCald8XWsOLD1Gswrr0dB+GDlp95t35v/z3Cp2TAIYtAE5pw7Dd82U
 2BVTNJXdMufxHRnyVIobF47mO/qIpBlgYFMD1idLi53MPUepc9m8Ifb91NJ58sa7qmi+
 mqlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719041132; x=1719645932;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4O0pn9RI1XCGhhWq/KO2tjBqC+ja5n+u4HYedNdgJdc=;
 b=a+fPrHer95fYtBZnjrm9AleXsRarJGu5b7tr+hrSaX8mCuL3qJRuosSmTdJOwdIumu
 F9HUrnaJxWS+zzNu/agmGb2cpOPaKxbR78060R0NQ74xTcc3nSNC21OqjfRb70kGsFkO
 cvIAouvFxkG15xpZK7R65bI0hWhcY+cOlFGar2YbFuWzVqlTUCcV+iz/ratwscBSr8ov
 /RQ5qJEa/cQJM1WvgNyaNcFKBDcVH9s4vWgH9sM22Wn3NUztyXomgnTukkhuvFuhi/Z5
 vBUyYY1qLY7VDDXP9bjQdDboUJbX6WG2xnxirJlUdcBC8wxI0ylA8qfC6fsxLMK+/JKT
 jPuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVF5kbP4JEKt9/seciBTikfzKgbEdEG42T1qaMBL1WOjQRPBuOWQ0fnMu5KJ1TiJJB95Ybl1O6Er7GEFGxKbidEVJfmgkd6zQ==
X-Gm-Message-State: AOJu0Yz0d+XjgY24PM1LdA8XfZKwZtYcVjCeJBj4AFuvKgCzeOlTCjme
 ErCbyWJc77+RNSQGqDC8ULID0D2qHhywt1IjkbfeqIhkaWnrcsfs/xUvUhS0nHSFVzNsak8cU9+
 ecLe6Tcsv2hBdIb2oVXuYKPlbwetkT1mL
X-Google-Smtp-Source: AGHT+IFVd3J/eGyhaRfCmb7BQ6g/RthJMOUG1OOoza2GXdJL6i2NX3Z/OQpkYYdhnK2Tt6vpb5+D52TRFM2ZHv4f+g0=
X-Received: by 2002:ad4:4f41:0:b0:6b4:ff32:8287 with SMTP id
 6a1803df08f44-6b501e26af7mr104747056d6.22.1719041131656; Sat, 22 Jun 2024
 00:25:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240619045459.305997-1-hyeongtak.ji@gmail.com>
 <20240621171047.000075fc@Huawei.com>
In-Reply-To: <20240621171047.000075fc@Huawei.com>
From: Hyeongtak Ji <hyeongtak.ji@gmail.com>
Date: Sat, 22 Jun 2024 16:25:26 +0900
Message-ID: <CAFY0u4R8V-8rJYidvNCYjpAvF=hGy4N1j0a4PPGbaTNALeLC3A@mail.gmail.com>
Subject: Re: [PATCH] docs/cxl: fix some typos
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2a;
 envelope-from=hyeongtak.ji@gmail.com; helo=mail-qv1-xf2a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hello Jonathan,

Thank you for your response.

On Sat, Jun 22, 2024 at 1:10=E2=80=AFAM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Wed, 19 Jun 2024 13:54:59 +0900
> Hyeongtak Ji <hyeongtak.ji@gmail.com> wrote:
>
> Hi, some description would be good of how you caught these
> (I'm guessing a close read).

Just to confirm, are you suggesting that the patch should include a
commit message?  I apologize for submitting the patch without any
sufficient explanation.  However, I am not entirely sure if "how I
found these typos" needs to be included in the commit message.  For
your information, I discovered these typos because the ASCII art did
not align with the explanations (yes, a close read).

>
> Whilst checking this I did notice there are some errors in
> the example bus numbering but that's a separate issue.
>
> Jonathan
>
>
> > Signed-off-by: Hyeongtak Ji <hyeongtak.ji@gmail.com>
> > ---
> >  docs/system/devices/cxl.rst | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/docs/system/devices/cxl.rst b/docs/system/devices/cxl.rst
> > index 10a0e9bc9ff4..e2497e6a098b 100644
> > --- a/docs/system/devices/cxl.rst
> > +++ b/docs/system/devices/cxl.rst
> > @@ -218,17 +218,17 @@ Notes:
> >      A complex configuration here, might be to use the following HDM
> >      decoders in HB0. HDM0 routes CFMW0 requests to RP0 and hence
> >      part of CXL Type3 0. HDM1 routes CFMW0 requests from a
> > -    different region of the CFMW0 PA range to RP2 and hence part
> > +    different region of the CFMW0 PA range to RP1 and hence part
>
> Good catch.
>
> >      of CXL Type 3 1.  HDM2 routes yet another PA range from within
> >      CFMW0 to be interleaved across RP0 and RP1, providing 2 way
> >      interleave of part of the memory provided by CXL Type3 0 and
> >      CXL Type 3 1. HDM3 routes those interleaved accesses from
> >      CFMW1 that target HB0 to RP 0 and another part of the memory of
> >      CXL Type 3 0 (as part of a 2 way interleave at the system level
> > -    across for example CXL Type3 0 and CXL Type3 2.
> > +    across for example CXL Type3 0 and CXL Type3 1).
> This one is wrong.  CFMW1 interleaves across both host bridges so we need
> a device below HB0 and one below HB1, so CXL type3 2 is a possible choice
> (could be CXL type3 3 as well, but that doesn't matter.)

Oh, I misunderstood the original explanation.  I will correct it just by
adding the missing parenthesis instead.

>
> >      HDM4 is used to enable system wide 4 way interleave across all
> >      the present CXL type3 devices, by interleaving those (interleaved)
> > -    requests that HB0 receives from from CFMW1 across RP 0 and
> > +    requests that HB0 receives from CFMW1 across RP 0 and
> Good.
>
> >      RP 1 and hence to yet more regions of the memory of the
> >      attached Type3 devices.  Note this is a representative subset
> >      of the full range of possible HDM decoder configurations in this
>

I will send V2 with a decent explanation and the corrected typo fix.

Kind regards,
Hyeongtak

On Sat, Jun 22, 2024 at 1:10=E2=80=AFAM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Wed, 19 Jun 2024 13:54:59 +0900
> Hyeongtak Ji <hyeongtak.ji@gmail.com> wrote:
>
> Hi, some description would be good of how you caught these
> (I'm guessing a close read).
>
> Whilst checking this I did notice there are some errors in
> the example bus numbering but that's a separate issue.
>
> Jonathan
>
>
> > Signed-off-by: Hyeongtak Ji <hyeongtak.ji@gmail.com>
> > ---
> >  docs/system/devices/cxl.rst | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/docs/system/devices/cxl.rst b/docs/system/devices/cxl.rst
> > index 10a0e9bc9ff4..e2497e6a098b 100644
> > --- a/docs/system/devices/cxl.rst
> > +++ b/docs/system/devices/cxl.rst
> > @@ -218,17 +218,17 @@ Notes:
> >      A complex configuration here, might be to use the following HDM
> >      decoders in HB0. HDM0 routes CFMW0 requests to RP0 and hence
> >      part of CXL Type3 0. HDM1 routes CFMW0 requests from a
> > -    different region of the CFMW0 PA range to RP2 and hence part
> > +    different region of the CFMW0 PA range to RP1 and hence part
>
> Good catch.
>
> >      of CXL Type 3 1.  HDM2 routes yet another PA range from within
> >      CFMW0 to be interleaved across RP0 and RP1, providing 2 way
> >      interleave of part of the memory provided by CXL Type3 0 and
> >      CXL Type 3 1. HDM3 routes those interleaved accesses from
> >      CFMW1 that target HB0 to RP 0 and another part of the memory of
> >      CXL Type 3 0 (as part of a 2 way interleave at the system level
> > -    across for example CXL Type3 0 and CXL Type3 2.
> > +    across for example CXL Type3 0 and CXL Type3 1).
> This one is wrong.  CFMW1 interleaves across both host bridges so we need
> a device below HB0 and one below HB1, so CXL type3 2 is a possible choice
> (could be CXL type3 3 as well, but that doesn't matter.)
>
> >      HDM4 is used to enable system wide 4 way interleave across all
> >      the present CXL type3 devices, by interleaving those (interleaved)
> > -    requests that HB0 receives from from CFMW1 across RP 0 and
> > +    requests that HB0 receives from CFMW1 across RP 0 and
> Good.
>
> >      RP 1 and hence to yet more regions of the memory of the
> >      attached Type3 devices.  Note this is a representative subset
> >      of the full range of possible HDM decoder configurations in this
>

