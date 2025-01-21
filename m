Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AECFC02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 15:50:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taGVV-0000A7-RP; Tue, 21 Jan 2025 10:49:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1taGVP-00008d-RW
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 10:49:33 -0500
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1taGVN-0000jb-Ni
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 10:49:31 -0500
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-54287a3ba3cso6258376e87.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 07:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737474567; x=1738079367; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pg0sM0O21avLkPHNR1ym4ACdRrEJebVY8MaNVlggDfk=;
 b=nRswL6rVs3YKsI4YrZ2RhdjJ8YTKE7S+ZSxIrkuZImsMjYA4mvdlaHFyFSd9qZ/Ttw
 76Q0NWYY8dAIR+WGNpC8jKdEfWBKgWc8i1OvdGEXWsT9NN4MqTOYR+5vMuPIYsnRv9V7
 f46QObM4Yj9rZ8mFBf5a5e4P1lCXgSCvg/hRkqmX100S5ZO71s7gtn+a0TSr9KCFyG/m
 ataDS6kPGwVh4E8Ch/p7njmTdcYM874RDlRdp/jp2J1iSiNXsWgZZNiyaKpRmyzlFotE
 FSAm5FcKRlvzWV1+R3kR0GTGZOOYUzAzoAt32nAyk+LlLgbnh/eoXseJm0nGrCIvXAm2
 Chlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737474567; x=1738079367;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pg0sM0O21avLkPHNR1ym4ACdRrEJebVY8MaNVlggDfk=;
 b=W74nAlgOGAbvHxfJmhUJoc4kYioQPMudG1vEpp0WxlvCKQAa/c8/YfZg2d0fqBsjz+
 vqmLD7/K8pFqsKlYPrr46j0qyidKC8GBvg+5gaKacyQ11f8Qmyoa5bgmaZaia35+1cdI
 8evYMl0rBOacWCweMtqXQ4bn8/9D5CgnDTKExJh7FR3GCMWLlW7Mctmw08mCy0kpEuF7
 hW5KG5l2OHvWCcQVZn24UfAYSd/W9i6eJaZ4RhPiASqOjYESL3q9LkcVmWNeLzA2kQoB
 u5KTsxb7dkWazyHgXoe/7byH0sRcBkYIDWnEV5TWL5OeNcMh42yM2BKmYO+YhPQE1H9O
 uuzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxx8B9XAyjLSXLGvVcT8pf930XlEluaD59iviLtVr8vgq3ZNmpVKNijevQGOoCZZJcxcFg3xwjs7RC@nongnu.org
X-Gm-Message-State: AOJu0Yy3L9kGWDJszRdCx2Qyxngq4sAo2PD7tLI7KySxAzKanJA+HiRw
 2FoWCkmpBQPasKoR2QTYmKHfqlz2ydwyrbeuK4n6tmb9pdoUwoywM++e7rD276ZbDl+C5aLyvON
 jWbD8hdejyIYhe6Fcv//jnxSv3ao=
X-Gm-Gg: ASbGncuIQV5S5150qL/OIELUqtli2uCOJIlJzXqL25sTFRG4PZbc2L4VQ4tiv12Epk2
 jeZ4wThDzKHOVE+RA4d2jqSPcC78+WDn42IQ5QRdUo6OthdDPLUQ=
X-Google-Smtp-Source: AGHT+IEVOeTTM7qPAfoQvUnhV6ryFesRj0ElvhDELhnbH7CU40yH23eyTqu1js5wg8IZ7rv/I3X6ka3k8s3syoMnaNc=
X-Received: by 2002:a05:6512:3e0e:b0:542:23b2:8010 with SMTP id
 2adb3069b0e04-542abfbdcc3mr8176217e87.23.1737474566395; Tue, 21 Jan 2025
 07:49:26 -0800 (PST)
MIME-Version: 1.0
References: <20250118164056.830721-1-r.peniaev@gmail.com>
 <20250118164056.830721-5-r.peniaev@gmail.com>
 <87wmeonrar.fsf@draig.linaro.org>
 <CACZ9PQU1GH2XEH7HX7YXX7UmtGhJbyZR5-F63339F+7yu3M1GA@mail.gmail.com>
In-Reply-To: <CACZ9PQU1GH2XEH7HX7YXX7UmtGhJbyZR5-F63339F+7yu3M1GA@mail.gmail.com>
From: Roman Penyaev <r.peniaev@gmail.com>
Date: Tue, 21 Jan 2025 16:49:15 +0100
X-Gm-Features: AbW1kvb5Qd78Aw125kB6TNdhpogH5pVkGvbiMwvSc9e521z-ZIbHFB-G0-Xy91k
Message-ID: <CACZ9PQWPhOHXg_+kwCGKkGtWWLpE1Wz5sX7wwh81AY9R8=BDPA@mail.gmail.com>
Subject: Re: [PATCH v7 4/4] qemu-options.hx: describe hub chardev and
 aggregation of several backends
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=r.peniaev@gmail.com; helo=mail-lf1-x12c.google.com
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

On Tue, Jan 21, 2025 at 4:23=E2=80=AFPM Roman Penyaev <r.peniaev@gmail.com>=
 wrote:
>
> On Tue, Jan 21, 2025 at 4:02=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@lin=
aro.org> wrote:
> >
> > Roman Penyaev <r.peniaev@gmail.com> writes:
> >
> > > This adds a few lines describing `hub` aggregator configuration
> > > for aggregation of several backend devices with a single frontend
> > > device.
> > >
> > > Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
> > > Cc: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
> > > Cc: qemu-devel@nongnu.org
> > > ---
> > >  qemu-options.hx | 48 ++++++++++++++++++++++++++++++++++++++++++++---=
-
> > >  1 file changed, 44 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/qemu-options.hx b/qemu-options.hx
> > > index 7090d59f6f10..fdc46f7e68b3 100644
> > > --- a/qemu-options.hx
> > > +++ b/qemu-options.hx
> > > @@ -3720,7 +3720,7 @@ SRST
> > >  The general form of a character device option is:
> > >
> > >  ``-chardev backend,id=3Did[,mux=3Don|off][,options]``
> > > -    Backend is one of: ``null``, ``socket``, ``udp``, ``msmouse``,
> > > +    Backend is one of: ``null``, ``socket``, ``udp``, ``msmouse``, `=
`hub``,
> > >      ``vc``, ``ringbuf``, ``file``, ``pipe``, ``console``, ``serial``=
,
> > >      ``pty``, ``stdio``, ``braille``, ``parallel``,
> > >      ``spicevmc``, ``spiceport``. The specific backend will determine=
 the
> > > @@ -3777,9 +3777,10 @@ The general form of a character device option =
is:
> > >      the QEMU monitor, and ``-nographic`` also multiplexes the consol=
e
> > >      and the monitor to stdio.
> > >
> > > -    There is currently no support for multiplexing in the other
> > > -    direction (where a single QEMU front end takes input and output =
from
> > > -    multiple chardevs).
> > > +    If you need to aggregate data in the opposite direction (where o=
ne
> > > +    QEMU frontend interface receives input and output from multiple
> > > +    backend chardev devices), please refer to the paragraph below
> > > +    regarding chardev ``hub`` aggregator device configuration.
> > >
> > >      Every backend supports the ``logfile`` option, which supplies th=
e
> > >      path to a file to record all data transmitted via the backend. T=
he
> > > @@ -3879,6 +3880,45 @@ The available backends are:
> > >      Forward QEMU's emulated msmouse events to the guest. ``msmouse``
> > >      does not take any options.
> > >
> > > +``-chardev hub,id=3Did,chardevs.0=3Did[,chardevs.N=3Did]`` Explicitl=
y create
> > > +    chardev backend hub device with the possibility to aggregate inp=
ut
> > > +    from multiple backend devices and forward it to a single fronten=
d
> > > +    device. Additionally, `hub` device takes the output from the
> > > +    frontend device and sends it back to all the connected backend
> > > +    devices. This allows for seamless interaction between different
> > > +    backend devices and a single frontend interface. Aggregation
> > > +    supported for up to 4 chardev devices. (Since 10.0)
> > > +
> > > +    For example, the following is a use case of 2 backend devices:
> > > +    virtual console ``vc0`` and a pseudo TTY ``pty0`` connected to
> > > +    a single virtio hvc console frontend device with a hub ``hub0``
> > > +    help. Virtual console renders text to an image, which can be
> > > +    shared over the VNC protocol. In turn, pty backend provides
> > > +    bidirectional communication to the virtio hvc console over the
> > > +    pseudo TTY file. The example configuration can be as follows:
> > > +
> > > +    ::
> > > +
> > > +       -chardev pty,path=3D/tmp/pty,id=3Dpty0 \
> > > +       -chardev vc,id=3Dvc0 \
> > > +       -chardev hub,id=3Dhub0,chardevs.0=3Dpty0,chardevs.1=3Dvc0 \
> > > +       -device virtconsole,chardev=3Dhub0 \
> > > +       -vnc 0.0.0.0:0
> > > +
> > > +    Once QEMU starts VNC client and any TTY emulator can be used to
> > > +    control a single hvc console:
> > > +
> > > +    ::
> > > +
> > > +       # Start TTY emulator
> > > +       tio /tmp/pty
> > > +
> > > +       # Start VNC client and switch to virtual console Ctrl-Alt-2
> > > +       vncviewer :0
> > > +
> > > +    Several frontend devices is not supported. Stacking of multiplex=
ers
> > > +    and hub devices is not supported as well.
> > > +
> >
> > Not sure why this breaks but I'm seeing:
> >
> >   FAILED: docs/docs.stamp
> >   /usr/bin/env CONFDIR=3Detc/qemu /home/alex/lsrc/qemu.git/builds/all/p=
yvenv/bin/sphinx-build -q -W -Dkerneldoc_werror=3D1 -j auto -Dversion=3D9.2=
.50 -Drelease=3D -Ddepfile=3Ddocs/docs.d -Ddepfile_stamp=3Ddocs/docs.stamp =
-b html -d /home/alex/lsrc/qemu.git/builds/all/docs/manual.p /home/alex/lsr=
c/qemu.git/docs /home/alex/lsrc/qemu.git/builds/all/docs/manual
> >
> >   Warning, treated as error:
> >   /home/alex/lsrc/qemu.git/qemu-options.hx:3884:'any' reference target =
not found: hub
>
> This is odd, my make is silent. Can you please check this?

Docs generation was disabled on my side. My bad. The problem is in the
`hub`, which should be ``hub``. Thanks for noticing that.

--
Roman

