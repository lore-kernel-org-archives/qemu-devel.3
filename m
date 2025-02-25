Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 138F4C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 10:00:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmrj0-0001yb-GS; Tue, 25 Feb 2025 04:59:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1tmriz-0001yM-1d
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 04:59:37 -0500
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1tmriw-0007LS-PA
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 04:59:36 -0500
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-307325f2436so52654141fa.0
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 01:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740477572; x=1741082372; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Po7Lz/sghGD2x5lGd0wRJfCRK0yA4yZVJJ5pnvF0Uo4=;
 b=m7hTwsD5uOpRYPvph0y3qFsZdr29VrFEspNPZxkkwhKp/ZwTyc9Y7BZrtW9YLxwn/D
 brSA++/lN4+V8/5lPFgBz66i0+2xczoigajYbD+mM0xicBkaXQ5G82B9KTUfx8Bwr17P
 EzekGP4aucDGnac5Yw8t4IydSOSGH2mOunGO9VRomZmTafYKS8NQXQY9AO6WZYkH2NEY
 ILN5KAj99V4mjoOjEdp/LHe7XdTxagsnFUPhzEtdVW/DKsaluchxvOsZqJ6nDU/ZCsGs
 GOLOws402f7vh2ZWjUtaB31Lt2zSaf7RWIus4GGkZmCI2jLSSlom/SG9HTAabB1mu0x1
 ZI1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740477572; x=1741082372;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Po7Lz/sghGD2x5lGd0wRJfCRK0yA4yZVJJ5pnvF0Uo4=;
 b=lyHxE9TN3skTurCSIaUqox5rPTbEfXV/12JHhKZaOyEtmH/CcBsE93JJbqHPS/lo0J
 2NhPbDx+9CKRqYq2DA9rkkDyfosEMVys1zBNH1UyJiFYicoOgYRdcHUmvOZHW99KjgOD
 6IbWCUILEqsttHsmvsbbWUonbv2Q2m6yxpjW3y30OjAjd9Li7KMa0rY/muazN9aBL7Z7
 7VAoUD2RbDH/Za8Ss7tXW5TJLfCYl7+0KIkuiBBZHtyOQWWJS639CS8iWw3xAhnSqfTj
 T/NIfC2QY/xC5ZKRwOuUN8qgdWwmE7dVZpa9Ww4JFxnVONiymdm5pvFd34LQG43uu3V3
 mbfw==
X-Gm-Message-State: AOJu0Ywdp6J9WNvk7M7DEaFElAVU1Y3M73umDZ9Q1DISQlJ1QBQcP4Dd
 jNr+7B45D2CjS73yOyXnyKxBySl5z9pAAQW+/NhzjXoDZk4kmTPk7D0FFAbWpBIw/neDcTCVbNc
 YJtlX9meUsTrCwJxBAOk7+STTixs=
X-Gm-Gg: ASbGncuECPn42IVk9Ms6tQ9a/yOTb22G7upPk6GXRKwzRINZ+BZ3ylPlL1s5KeePsiu
 tLQN6kOn6gPc6Z/tKR9tb1Tng5ViObX/F+nEzz1soC9/MnyEcxPg6EjdGfJO1VMiqbBVmKgVSGO
 dd52NxByw=
X-Google-Smtp-Source: AGHT+IGe0ogXYP/Tqp411r5bWg5/hwpbu0KjziGwzsvAKl4xWLMHEqEuRL+j2mWQOwZteZP3TJ6UJUo6GUBvMfGnIbs=
X-Received: by 2002:a2e:964f:0:b0:308:ec9d:d9d3 with SMTP id
 38308e7fff4ca-30a598f41cemr55956921fa.17.1740477571688; Tue, 25 Feb 2025
 01:59:31 -0800 (PST)
MIME-Version: 1.0
References: <20250223145407.259924-1-r.peniaev@gmail.com>
 <20250223145407.259924-6-r.peniaev@gmail.com>
 <CAJ+F1CKMor3asfyOnNj6bVWFmzi10wtJxNuHzhcy4PqWysZU9A@mail.gmail.com>
In-Reply-To: <CAJ+F1CKMor3asfyOnNj6bVWFmzi10wtJxNuHzhcy4PqWysZU9A@mail.gmail.com>
From: Roman Penyaev <r.peniaev@gmail.com>
Date: Tue, 25 Feb 2025 10:59:20 +0100
X-Gm-Features: AWEUYZmpZc51ulEVB-2vn7on0X9xIN0rA8mzV-w7Cmcpoqs3E8R8hlwjlPZ8YdY
Message-ID: <CACZ9PQWc7hDb9ochnT5mtUDAhqV2sRArgEZ2up77AGpoZBeT9w@mail.gmail.com>
Subject: Re: [PATCH 5/5] ui/console-vc: implement DCH (delete) and ICH
 (insert) commands
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=r.peniaev@gmail.com; helo=mail-lj1-x233.google.com
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

On Mon, Feb 24, 2025 at 8:25=E2=80=AFAM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
>
> Hi
>
> On Sun, Feb 23, 2025 at 6:56=E2=80=AFPM Roman Penyaev <r.peniaev@gmail.co=
m> wrote:
> >
> > This patch implements DCH (delete character) and ICH (insert
> > character) commands.
> >
> > DCH - Delete Character:
> >    "As characters are deleted, the remaining characters between the
> >     cursor and right margin move to the left. Character attributes move
> >     with the characters. The terminal adds blank spaces with no visual
> >     character attributes at the right margin. DCH has no effect outside
> >     the scrolling margins" [1].
> >
> > ICH - Insert Character:
> >    "The ICH sequence inserts Pn blank characters with the normal
> >     character attribute. The cursor remains at the beginning of the
> >     blank characters. Text between the cursor and right margin moves to
> >     the right. Characters scrolled past the right margin are lost. ICH
> >     has no effect outside the scrolling margins" [2].
> >
> > Without these commands console is barely usable.
> >
> > [1] https://vt100.net/docs/vt510-rm/DCH.html
> > [1] https://vt100.net/docs/vt510-rm/ICH.html
> >
> > Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
> > Cc: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
> > Cc: qemu-devel@nongnu.org
> > ---
> >  ui/console-vc.c | 108 +++++++++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 102 insertions(+), 6 deletions(-)
> >
> > diff --git a/ui/console-vc.c b/ui/console-vc.c
> > index 522adc2806c8..bc667897d1bc 100644
> > --- a/ui/console-vc.c
> > +++ b/ui/console-vc.c
> > @@ -598,21 +598,29 @@ static void vc_clear_xy(VCChardev *vc, int x, int=
 y)
> >      vc_update_xy(vc, x, y);
> >  }
> >
> > -static void vc_put_one(VCChardev *vc, int ch)
> > +static void vc_insert_xy(VCChardev *vc, int ch, int x, int y)
> >  {
> >      QemuTextConsole *s =3D vc->console;
> >      TextCell *c;
> >      int y1;
> > +
> > +    y1 =3D (s->y_base + y) % s->total_height;
> > +    c =3D &s->cells[y1 * s->width + x];
> > +    c->ch =3D ch;
> > +    c->t_attrib =3D vc->t_attrib;
> > +    vc_update_xy(vc, x, y);
> > +}
> > +
> > +static void vc_put_one(VCChardev *vc, int ch)
> > +{
> > +    QemuTextConsole *s =3D vc->console;
> > +
> >      if (s->x >=3D s->width) {
> >          /* line wrap */
> >          s->x =3D 0;
> >          vc_put_lf(vc);
> >      }
> > -    y1 =3D (s->y_base + s->y) % s->total_height;
> > -    c =3D &s->cells[y1 * s->width + s->x];
> > -    c->ch =3D ch;
> > -    c->t_attrib =3D vc->t_attrib;
> > -    vc_update_xy(vc, s->x, s->y);
> > +    vc_insert_xy(vc, ch, s->x, s->y);
> >      s->x++;
> >  }
> >
> > @@ -645,6 +653,88 @@ static void vc_set_cursor(VCChardev *vc, int x, in=
t y)
> >      s->y =3D y;
> >  }
> >
> > +/**
> > + * vc_csi_P() - (DCH) deletes one or more characters from the cursor
> > + * position to the right. As characters are deleted, the remaining
> > + * characters between the cursor and right margin move to the
> > + * left. Character attributes move with the characters.
> > + */
> > +static void vc_csi_P(struct VCChardev *vc, unsigned int nr)
> > +{
> > +    QemuTextConsole *s =3D vc->console;
> > +    TextCell *c1, *c2;
> > +    unsigned int x1, x2, y;
> > +    unsigned int end, len;
> > +
> > +    if (!nr) {
> > +        nr =3D 1;
> > +    }
> > +    if (nr > s->width - s->x) {
> > +        nr =3D s->width - s->x;
> > +        if (!nr) {
> > +            return;
> > +        }
> > +    }
> > +
> > +    x1 =3D s->x;
> > +    x2 =3D s->x + nr;
> > +    len =3D s->width - x2;
> > +    if (len) {
> > +        y =3D (s->y_base + s->y) % s->total_height;
> > +        c1 =3D &s->cells[y * s->width + x1];
> > +        c2 =3D &s->cells[y * s->width + x2];
> > +        memmove(c1, c2, len * sizeof(*c1));
> > +        for (end =3D x1 + len; x1 < end; x1++) {
> > +            vc_update_xy(vc, x1, s->y);
> > +        }
> > +    }
> > +    /* Clear the rest */
> > +    for (; x1 < s->width; x1++) {
> > +        vc_clear_xy(vc, x1, s->y);
> > +    }
> > +}
> > +
> > +/**
> > + * vc_csi_at() - (ICH) inserts `nr` blank characters with the normal
> > + * character attribute. The cursor remains at the beginning of the
>
> What is "normal character attribute"?
>
> Should you set it to  TEXT_ATTRIBUTES_DEFAULT while inserting blank chars=
?

Hi,

The wording "default attributes" is more precise, I like it. The
original VT spec
and ECMA-48 are rather vague about exactly what attributes should be set
for "erased state", but various terminal implementations (including vt.c fr=
om
the Linux kernel) simply reset the character to the default state. From the
perspective of the existing console-vc.c API, a more correct call is
vt_clear_xt(),
which clears attributes to default rather than inserting a "space"
with vt_put_xy().
I'll fix that. Thanks.

--
Roman

