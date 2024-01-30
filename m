Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98767C47DA9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 08:52:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUjqt-0002hY-R9; Tue, 30 Jan 2024 03:52:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rUjqr-0002hI-EH
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 03:52:17 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rUjqp-0007ZU-GR
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 03:52:17 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-55a5e7fa471so3642656a12.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 00:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706604734; x=1707209534; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=psxmMxP5aczRvXep2GISJomOfJfWeweBcWXx6LbddK8=;
 b=yBxq9cj6pSJCGKAt/QvL5nNy1EOvA7Z9y4gGcTsJZ1GYGX69MoXjA2dXyfAZnQtveo
 TKieYn+YCPNtbyR7YT/xIQWip5saIMfFJAFFy+ReO/L6fmh9PIWPHjr124uxvgkEvjC3
 05+/X3BCgjpahL/vGSPp4gW1QoLu94S9FBru8FNkBHpWzk0W07p2X/057dV60+Z6Dfbh
 QbhY2XL4ayLjWwYCgVHUDH554bQTEIuy4npEg5e7x/bOlHKCORZELNFPTSqKELPzpxM2
 HOflVv+KbJDU7txXVDfW9zXrdPbLjl0dTxJOZPgDcLW7KL56wgzS/H7oV8GGOzIIzYwp
 g+rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706604734; x=1707209534;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=psxmMxP5aczRvXep2GISJomOfJfWeweBcWXx6LbddK8=;
 b=wyaMo9RH5aADpBBLTHuNEVtDGMviAnBEFmCPot1s++IFNdZMqMYdCKf99XdI97M4hh
 6GpE1Ppq4pWymnC1ZS375mgCUA6++LqKrHBq4wqG7QW42f1kpS6b6iPV9b4pzKdGcelY
 /8/fAWg4djWKDpY7s6v1416f9UWt9+j43nHlevvSGBQADJT+uAo9s3IwYjGaOthJNE3K
 zRJ5bThdSv7IWQ0kG02JOavnveWYiFQ/ROvKYOCbLsLIXHwb29e1pMCngQ7RvBipS7U8
 n7I7qfhFYKq1vW8DZISZbRejrmZ67LWvdkURJvV8ZgZLJpuBKkdyrNDZ0cD1ZbKgRseX
 E0pQ==
X-Gm-Message-State: AOJu0Ywn6YGb0vMJpQ2HIIEpolVnf9y1C4OtyhHSc+F9NO8ifquCZ4nb
 KzEmjSeDU1aujNE20x11q9eyxKM8LqDJ1qsy5jdT1UkNvjC1nSit2fp3ti4OXYWXVDNSQHIGLhW
 eTYH/nYbsWX8aJf+3Cbg5mtqWwhIGGE/1oYr4LQ==
X-Google-Smtp-Source: AGHT+IGbjmJpTDPSqeZunTX3d4PRUxFdFkFIniRd0g4tAyYs02Ob1/kCVEfheUh9qmYUF/EIpowC1OPjDcfoYXbUYBY=
X-Received: by 2002:aa7:d80a:0:b0:55e:bc29:6fcb with SMTP id
 v10-20020aa7d80a000000b0055ebc296fcbmr4984746edq.10.1706604734053; Tue, 30
 Jan 2024 00:52:14 -0800 (PST)
MIME-Version: 1.0
References: <20240130075615.181040-1-manos.pitsidianakis@linaro.org>
 <ZbivaYQ1rC6AgHbU@redhat.com>
In-Reply-To: <ZbivaYQ1rC6AgHbU@redhat.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 30 Jan 2024 10:51:58 +0200
Message-ID: <CAAjaMXaxqEGDY3RwSPns-Rr67-RV-9CL35XkKMyEhrryYAqsfQ@mail.gmail.com>
Subject: Re: [PATCH v1] scripts/checkpatch.pl: check for placeholders in cover
 letter patches
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>
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

On Tue, 30 Jan 2024 at 10:12, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Tue, Jan 30, 2024 at 09:56:15AM +0200, Manos Pitsidianakis wrote:
> > Check if a file argument is a cover letter patch produced by
> > git-format-patch --cover-letter; It is initialized with subject suffix =
"
> > *** SUBJECT HERE ***" and body prefix " *** BLURB HERE ***". If they
> > exist, warn the user.
> >
> > Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> > ---
> >  scripts/checkpatch.pl | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > index 7026895074..34f12c9848 100755
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -1650,6 +1650,20 @@ sub process {
> >                       $non_utf8_charset =3D 1;
> >               }
> >
> > +# Check if this is a cover letter patch produced by git-format-patch
> > +# --cover-letter; It is initialized with subject suffix
> > +# " *** SUBJECT HERE ***" and body prefix " *** BLURB HERE ***"
> > +             if ($in_header_lines &&
> > +                 $rawline =3D~ /^Subject:.+[*]{3} SUBJECT HERE [*]{3}\=
s*$/) {
> > +        WARN("Patch appears to be a cover letter with uninitialized su=
bject" .
> > +             " '*** SUBJECT HERE ***'\n$hereline\n");
> > +             }
> > +
> > +             if ($rawline =3D~ /^[*]{3} BLURB HERE [*]{3}\s*$/) {
> > +        WARN("Patch appears to be a cover letter with leftover placeho=
lder " .
> > +             "text '*** BLURB HERE ***'\n$hereline\n");
> > +             }
>
> Indentation here is totally off

It only seems that way because the pre-existing lines use tabs, while
I used spaces, according to the QEMU Coding style:

> QEMU indents are four spaces. Tabs are never used, except in Makefiles wh=
ere they have been irreversibly coded into the syntax.

> > +
> >               if ($in_commit_log && $non_utf8_charset && $realfile =3D~=
 /^$/ &&
> >                   $rawline =3D~ /$NON_ASCII_UTF8/) {
> >                       WARN("8-bit UTF-8 used in possible commit log\n" =
. $herecurr);
> >
> > base-commit: 11be70677c70fdccd452a3233653949b79e97908
> > --
> > =CE=B3=CE=B1=E1=BF=96=CE=B1 =CF=80=CF=85=CF=81=CE=AF =CE=BC=CE=B9=CF=87=
=CE=B8=CE=AE=CF=84=CF=89
> >
>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>

