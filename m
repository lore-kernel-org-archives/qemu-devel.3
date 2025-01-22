Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BCF8C02182
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 15:19:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tacUN-0004dS-SZ; Wed, 22 Jan 2025 10:17:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1tacUH-0004c4-Ak
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 10:17:49 -0500
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1tacUF-0004YS-AP
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 10:17:49 -0500
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-540215984f0so7557116e87.1
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2025 07:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737559065; x=1738163865; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pqRa8FFc9ZnkHdjIHp11NgOuWfTjv/uu7r5K+YDgjn8=;
 b=ker4+gDXTB4O5HB/bMsVJ7YeRXrSDMWrX8Cq3Uh2uXC/wipUFYXK/Gj9BpDgSto2jG
 n9smUmXigAqwyrl1HO9CFEVYGFGgRKTfFpZ2aWbMPFIn5JJuirSj4ePpy4pbTvJ2OG91
 wYN1WsEiICWrA1J9Rn2xj9OoZsIYoewZT7T2R2UtbZztg1dbr3ZjYEX3xcVW5GKGMoxH
 Y5IhOJmFATvlqRYv0E5E4XBUpUVEOLNKdswcfibDqI3ngU6ZlrRfl6MUTkuR589+LHBx
 w70Z9ke8bZ9+UqbTLl48z2Lo5iVGYKrez1YJPjJe75WjvbOB8idmP+okT6kMCkEHRWCh
 HVng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737559065; x=1738163865;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pqRa8FFc9ZnkHdjIHp11NgOuWfTjv/uu7r5K+YDgjn8=;
 b=c7aC5FMparBVfhE8TI5yYNhcle/cBVPDEVgVmwnn04tJOED2tODkOUJzhG7QwP8yxD
 FYYpuzq2sTVGKm9w0/kUPQ+ROKyy/vUzIxBZATok8ST0s+mL76fOQo1Bwyn6zdKpj8fT
 I2zGNZyrM/iPiImQnBaZ2LsUdSnp6FKzNHuiNaSQvBRN079F4cJEyEgMKv2R80GRBfRC
 FPCRlJ/x8hGyVsgqF7rBdlOIloKhr43kE+fbM6GuJ+eBGNmW9HwVI9GCoTneRJgzWeMi
 D/P17txVqhUrcdX3CsabxDEHx5QgeADHOLeE5g/DzOY90XbKo8tpmgS41naAdGSo3wPg
 xHKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTq/GaGBPIlXH+lRR20aPQTykc1o3wG7zAvHjcb7bA3clxob7D2jJcWYMpxJkw0sVFEUSWVX/Bu47Z@nongnu.org
X-Gm-Message-State: AOJu0Yz0AfZUHY+m6yMlB300TklRkth6IpQYpqDRtdcwYw0MWLUD2gee
 8zlSkdzzcTDK/liaCt5Ha+sshMuLWraTYZf+rHa/EhA65vV0ctaGcoKQJE074q5+mxXH7fCufjy
 JGt7yh0bFOX1e/E7Q14favdLfqm8=
X-Gm-Gg: ASbGncsQvBn9H2MH94mMa79LG0cNGS8HOoW/du8Qr+pyKm3mWf3ovFOxwAbZdOKpdqg
 NbX+H4LGbPM8Y1qcogYfCMw5smCGYh8D0S09eG4ZmJDSXhFoS+68=
X-Google-Smtp-Source: AGHT+IHhlv8QkwpUReV1C2Oq1czJrprEe65ts5tuo5zH6JnxBkT98fOKpR61HtqJpvknn+cRJwAx+QUTEnjpMLA1EuI=
X-Received: by 2002:ac2:4851:0:b0:540:1b41:c75f with SMTP id
 2adb3069b0e04-5439c247804mr7785082e87.16.1737559064578; Wed, 22 Jan 2025
 07:17:44 -0800 (PST)
MIME-Version: 1.0
References: <20250118164056.830721-1-r.peniaev@gmail.com>
 <20250118164056.830721-3-r.peniaev@gmail.com>
 <871pwuoqm9.fsf@draig.linaro.org>
In-Reply-To: <871pwuoqm9.fsf@draig.linaro.org>
From: Roman Penyaev <r.peniaev@gmail.com>
Date: Wed, 22 Jan 2025 16:17:33 +0100
X-Gm-Features: AbW1kvYrg3Lfr3b3jSTrPDCrssxjcfBDoo1OG6p7h7xtzocVf1S4vMmS5sMeqIg
Message-ID: <CACZ9PQVCS+XWrchNnCWzRqcO_vKo_bOinDgSJV4q8F1aBd5Z4g@mail.gmail.com>
Subject: Re: [PATCH v7 2/4] chardev/char-hub: implement backend chardev
 aggregator
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

On Wed, Jan 22, 2025 at 3:44=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:
>
> Roman Penyaev <r.peniaev@gmail.com> writes:
>
> > This patch implements a new chardev backend `hub` device, which
> > aggregates input from multiple backend devices and forwards it to a
> > single frontend device. Additionally, `hub` device takes the output
> > from the frontend device and sends it back to all the connected
> > backend devices. This allows for seamless interaction between
> > different backend devices and a single frontend interface.
> >
> > The idea of the change is trivial: keep list of backend devices
> > (up to 4), init them on demand and forward data buffer back and
> > forth.
> >
> > The following is QEMU command line example:
> >
> >    -chardev pty,path=3D/tmp/pty,id=3Dpty0 \
> >    -chardev vc,id=3Dvc0 \
> >    -chardev hub,id=3Dhub0,chardevs.0=3Dpty0,chardevs.1=3Dvc0 \
> >    -device virtconsole,chardev=3Dhub0 \
> >    -vnc 0.0.0.0:0
> >
> > Which creates 2 backend devices: text virtual console (`vc0`) and a
> > pseudo TTY (`pty0`) connected to the single virtio hvc console with
> > the backend aggregator (`hub0`) help. `vc0` renders text to an image,
> > which can be shared over the VNC protocol.  `pty0` is a pseudo TTY
> > backend which provides biderectional communication to the virtio hvc
> > console.
> >
> <snip>
> > +static void qemu_chr_open_hub(Chardev *chr,
> > +                                 ChardevBackend *backend,
> > +                                 bool *be_opened,
> > +                                 Error **errp)
> > +{
> > +    ChardevHub *hub =3D backend->u.hub.data;
> > +    HubChardev *d =3D HUB_CHARDEV(chr);
> > +    strList *list =3D hub->chardevs;
> > +
> > +    d->be_eagain_ind =3D -1;
> > +
> > +    if (list =3D=3D NULL) {
> > +        error_setg(errp, "hub: 'chardevs' list is not defined");
> > +        return;
> > +    }
> > +
> > +    while (list) {
> > +        Chardev *s;
> > +
> > +        s =3D qemu_chr_find(list->value);
> > +        if (s =3D=3D NULL) {
> > +            error_setg(errp, "hub: chardev can't be found by id '%s'",
> > +                       list->value);
> > +            return;
> > +        }
> > +        if (CHARDEV_IS_HUB(s) || CHARDEV_IS_MUX(s)) {
> > +            error_setg(errp, "hub: multiplexers and hub devices can't =
be "
> > +                       "stacked, check chardev '%s', chardev should no=
t "
> > +                       "be a hub device or have 'mux=3Don' enabled",
> > +                       list->value);
> > +            return;
>
> So I was looking at this to see if I could implement what I wanted which
> was a tee-like copy of a serial port output while maintaining the C-a
> support of the mux.
>
> Normally I just use the shortcut -serial mon:stdio
>
> However that form is a special case so I tried the following and ran
> into the above:
>
>           -chardev stdio,mux=3Don,id=3Dchar0 \
>           -chardev file,path=3Dconsole.log,id=3Dclog  \
>           -mon chardev=3Dchar0,mode=3Dreadline \
>           -chardev hub,id=3Dhub0,chardevs.0=3Dchar0,chardevs.1=3Dclog
>
> Giving:
>   qemu-system-aarch64: -chardev -hub,id=3Dhub0,chardevs.0=3Dchar0,chardev=
s.1=3Dclog: hub: -multiplexers and hub devices can't be stacked, check char=
dev
>             -'char0', chardev should not be a hub device or have 'mux=3Do=
n' -enabled
>
> So what stops this sort of chain?

Hi Alex,

You define 'char0' as a mux device (the "mux=3Don" option). That is not sup=
ported
simply to avoid circle dependencies. To be frank I never considered
this use-case,
although chains might be useful. If you need this use-case we can
think of a more
proper (or advance) check.

--
Roman

