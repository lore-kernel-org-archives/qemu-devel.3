Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23A74C0218B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 15:24:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taG6o-0006gY-AP; Tue, 21 Jan 2025 10:24:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1taG6n-0006gP-6I
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 10:24:05 -0500
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1taG6l-0004mp-A1
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 10:24:04 -0500
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-53ff1f7caaeso6239388e87.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 07:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737473041; x=1738077841; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vIMNwWHiRa04o8fQ38FDLsrhPzPqKTG1pxw1WoZbg+s=;
 b=EPTaRSiIdhFCssjFgEK1k92vVX2iCxpPmxJzXIV5zjOggpTCmONTr5rZma+5bSLANA
 +ww5dVySBsekHvTRFvDwnwlY00XoJURw/RS2ANJaLMfaWpHY3nyB41y0HOFwgAja4iYE
 54zFo+C5kNWI88LrPfnClW8GfLTJETYogTdebxfcOoBkhDbUwJT+q+nLaM5gZYITjsV3
 PLomVZYmkq+0w8lp7KRcsAKupM294O+VBcIZmupgHCbjZtAXY/vWKnhScoqLdzx9XkBJ
 8h5i8IqAs/lozsHUlrXfDLiAvssFcfu5ebZR2HxPdEvtiw4oF02ETIBpZpGqLb66eq2t
 YU8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737473041; x=1738077841;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vIMNwWHiRa04o8fQ38FDLsrhPzPqKTG1pxw1WoZbg+s=;
 b=hcR2T6tZgxA4jb22IynpOnhjUjedGOI4wuizgCJkOKvrt3bn8n9riwGyWuYTPWDQ4f
 uk1LZHJqymeZpHmee2UwDakyEU6hx5QWJzljRYr5VVC9MmI0V5PtIe1e+RmYG2tDILBe
 Ij8LIfdDKsYC6ECq526w70cKyQ27E6FrgUWR1P/GQWcjOqd5TogkIzEcuBSfSsFmeDTD
 Un+OYzddDx3Wr7Pc9SIxxHZfdz3mVmVPyMtK5hVOmj/ztYk5CKywJwoISu5zCV/A/lcr
 hHXNRV/f9UnikAL1UkCtMTwxmwRuz9XVJUMGZHFnrdaUyr0K8NgoXyODKxFo+sfE+Ccm
 gXFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSmJ6ZOoSFl9dLcfQmLEdyOkC7tF6U1RqbB/ky5nA8lD5PnuyzYjRpVK/92D2FKH93q/jqkgKbyxcK@nongnu.org
X-Gm-Message-State: AOJu0YylvcEkRe+pqaxhHlDJa8I17KsOtw4bxXROoR3SOwz7UxJzHlLY
 WI+/dE90mE/vlIiDTx+8M8oMvFFUut5c/QZaPnw0JCkqaZjx8TJepemmbcsoNJ3/8Vu52nh1XdE
 KrL/8QfSzRfYjtn/LvkszboLsWQo=
X-Gm-Gg: ASbGnctyOonajnSZc0U417m6fY38bQD4csbZ/Rw0EQyHvkTR63vpQXtOxWWwCw4+cPt
 7FlFJ0fHNASwCtMVTG6J8xadc2mXWmy+WMK6Mo7Snn32gmv5cCIE=
X-Google-Smtp-Source: AGHT+IFsEQr2uOZbBvMhrCMUbI0TDHD2q6/61i5C860Snn050/eqainQsz73uaZH3W4q+F4Jorjjz7cyCzSDYs3t0FM=
X-Received: by 2002:a05:6512:1081:b0:543:9a61:a2e5 with SMTP id
 2adb3069b0e04-5439c2480eamr6951664e87.23.1737473040299; Tue, 21 Jan 2025
 07:24:00 -0800 (PST)
MIME-Version: 1.0
References: <20250118164056.830721-1-r.peniaev@gmail.com>
 <20250118164056.830721-5-r.peniaev@gmail.com>
 <87wmeonrar.fsf@draig.linaro.org>
In-Reply-To: <87wmeonrar.fsf@draig.linaro.org>
From: Roman Penyaev <r.peniaev@gmail.com>
Date: Tue, 21 Jan 2025 16:23:49 +0100
X-Gm-Features: AbW1kvY8oz8Y1rijRTomDUqAj-ac3VVzJFmlQXIHpCnSrlQovLCjBba3XHlLasI
Message-ID: <CACZ9PQU1GH2XEH7HX7YXX7UmtGhJbyZR5-F63339F+7yu3M1GA@mail.gmail.com>
Subject: Re: [PATCH v7 4/4] qemu-options.hx: describe hub chardev and
 aggregation of several backends
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=r.peniaev@gmail.com; helo=mail-lf1-x129.google.com
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

On Tue, Jan 21, 2025 at 4:02=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:
>
> Roman Penyaev <r.peniaev@gmail.com> writes:
>
> > This adds a few lines describing `hub` aggregator configuration
> > for aggregation of several backend devices with a single frontend
> > device.
> >
> > Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
> > Cc: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
> > Cc: qemu-devel@nongnu.org
> > ---
> >  qemu-options.hx | 48 ++++++++++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 44 insertions(+), 4 deletions(-)
> >
> > diff --git a/qemu-options.hx b/qemu-options.hx
> > index 7090d59f6f10..fdc46f7e68b3 100644
> > --- a/qemu-options.hx
> > +++ b/qemu-options.hx
> > @@ -3720,7 +3720,7 @@ SRST
> >  The general form of a character device option is:
> >
> >  ``-chardev backend,id=3Did[,mux=3Don|off][,options]``
> > -    Backend is one of: ``null``, ``socket``, ``udp``, ``msmouse``,
> > +    Backend is one of: ``null``, ``socket``, ``udp``, ``msmouse``, ``h=
ub``,
> >      ``vc``, ``ringbuf``, ``file``, ``pipe``, ``console``, ``serial``,
> >      ``pty``, ``stdio``, ``braille``, ``parallel``,
> >      ``spicevmc``, ``spiceport``. The specific backend will determine t=
he
> > @@ -3777,9 +3777,10 @@ The general form of a character device option is=
:
> >      the QEMU monitor, and ``-nographic`` also multiplexes the console
> >      and the monitor to stdio.
> >
> > -    There is currently no support for multiplexing in the other
> > -    direction (where a single QEMU front end takes input and output fr=
om
> > -    multiple chardevs).
> > +    If you need to aggregate data in the opposite direction (where one
> > +    QEMU frontend interface receives input and output from multiple
> > +    backend chardev devices), please refer to the paragraph below
> > +    regarding chardev ``hub`` aggregator device configuration.
> >
> >      Every backend supports the ``logfile`` option, which supplies the
> >      path to a file to record all data transmitted via the backend. The
> > @@ -3879,6 +3880,45 @@ The available backends are:
> >      Forward QEMU's emulated msmouse events to the guest. ``msmouse``
> >      does not take any options.
> >
> > +``-chardev hub,id=3Did,chardevs.0=3Did[,chardevs.N=3Did]`` Explicitly =
create
> > +    chardev backend hub device with the possibility to aggregate input
> > +    from multiple backend devices and forward it to a single frontend
> > +    device. Additionally, `hub` device takes the output from the
> > +    frontend device and sends it back to all the connected backend
> > +    devices. This allows for seamless interaction between different
> > +    backend devices and a single frontend interface. Aggregation
> > +    supported for up to 4 chardev devices. (Since 10.0)
> > +
> > +    For example, the following is a use case of 2 backend devices:
> > +    virtual console ``vc0`` and a pseudo TTY ``pty0`` connected to
> > +    a single virtio hvc console frontend device with a hub ``hub0``
> > +    help. Virtual console renders text to an image, which can be
> > +    shared over the VNC protocol. In turn, pty backend provides
> > +    bidirectional communication to the virtio hvc console over the
> > +    pseudo TTY file. The example configuration can be as follows:
> > +
> > +    ::
> > +
> > +       -chardev pty,path=3D/tmp/pty,id=3Dpty0 \
> > +       -chardev vc,id=3Dvc0 \
> > +       -chardev hub,id=3Dhub0,chardevs.0=3Dpty0,chardevs.1=3Dvc0 \
> > +       -device virtconsole,chardev=3Dhub0 \
> > +       -vnc 0.0.0.0:0
> > +
> > +    Once QEMU starts VNC client and any TTY emulator can be used to
> > +    control a single hvc console:
> > +
> > +    ::
> > +
> > +       # Start TTY emulator
> > +       tio /tmp/pty
> > +
> > +       # Start VNC client and switch to virtual console Ctrl-Alt-2
> > +       vncviewer :0
> > +
> > +    Several frontend devices is not supported. Stacking of multiplexer=
s
> > +    and hub devices is not supported as well.
> > +
>
> Not sure why this breaks but I'm seeing:
>
>   FAILED: docs/docs.stamp
>   /usr/bin/env CONFDIR=3Detc/qemu /home/alex/lsrc/qemu.git/builds/all/pyv=
env/bin/sphinx-build -q -W -Dkerneldoc_werror=3D1 -j auto -Dversion=3D9.2.5=
0 -Drelease=3D -Ddepfile=3Ddocs/docs.d -Ddepfile_stamp=3Ddocs/docs.stamp -b=
 html -d /home/alex/lsrc/qemu.git/builds/all/docs/manual.p /home/alex/lsrc/=
qemu.git/docs /home/alex/lsrc/qemu.git/builds/all/docs/manual
>
>   Warning, treated as error:
>   /home/alex/lsrc/qemu.git/qemu-options.hx:3884:'any' reference target no=
t found: hub

This is odd, my make is silent. Can you please check this?

diff --git a/qemu-options.hx b/qemu-options.hx
index fdc46f7e68b3..e6d9de142aaf 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3880,7 +3880,8 @@ The available backends are:
     Forward QEMU's emulated msmouse events to the guest. ``msmouse``
     does not take any options.

-``-chardev hub,id=3Did,chardevs.0=3Did[,chardevs.N=3Did]`` Explicitly crea=
te
+``-chardev hub,id=3Did,chardevs.0=3Did[,chardevs.N=3Did]``
+    Explicitly create


--
Roman

