Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B6C9C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 10:57:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taBvn-0006df-P7; Tue, 21 Jan 2025 05:56:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1taBvj-0006dL-DU
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 05:56:23 -0500
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1taBvg-00054q-1N
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 05:56:23 -0500
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-5401bd6cdb7so5320866e87.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 02:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737456976; x=1738061776; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X1niuG8Afbr7oKroL3hvM58cgLWosRxJd/D7teTHbkE=;
 b=ZBc6Znn4+8SH04ZSRpVcpIRWVoZ4La4g1qX1wQOixQxH0LPMwUBcc691X0FqHN1GVh
 Xt2QUFJ/sEnykLUuHgW1UUHBHmzx4opqmrnqitKtbUTboPlUmjnFvHnCbSXQ8SNHrEp8
 yShoYy6ui9FNEhVGwo1Mz+6m1pFqQXty7EmmZUebTSV0M/S0ZxtIP4OUaz7ZDiu2yFtW
 S6IG3KqapJzb1lMjOmAocL/C/CG1xAoQEe7RgBrphb8UdW1VCZbHCkVpqY5dORclM8cH
 jn6Z/I5ZEt/FIZ1XJUSQee3z4ntNOsAgE6sm8Ar8nC7jYgJ19uSbc4DCHWrY1+DruvAC
 1tBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737456976; x=1738061776;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X1niuG8Afbr7oKroL3hvM58cgLWosRxJd/D7teTHbkE=;
 b=k6mBC5XeJ0uGCrFwyECrRcM16ENLPI5hWdwv1PKMdWhvaTPXegpdAzExM7lsS0Uxeb
 6DKRB8xGAHtulF4aPd4WMd30nZ17gKkQvKvhDoVdfO+QOxeP/FUPEVa6k+Fo0OW6UjmF
 Zf0CQtoIwcVU1jFd10CSWXqUS5/L4taYplBJEGCGV6rIR4tmwoaOr4Vcj9mJZ1X1zFGX
 5PJp8Ub5cQdI+mamFH+et38BedRf0vsP58+G7MdhQgoHoMYjYL5K0TeorJjl8NDz4lAC
 x89L8nL6qcgZDBAuAxYTXfPO/0aLtclXwaxekSRL14iRp1XL7TxW1fboq+xpXblKejIv
 fizQ==
X-Gm-Message-State: AOJu0Yysp2/GHTiFDgBSq9mOjMVVM7dHrAyiAEt3UBDGkS8BtKItOXUL
 iQgGydpUqTVk8zNyH7vQ1Htg0ZaGUHijKIRU2Q8WfPGevoX8CpGT0R+ssTu0FoaoTE7pet1UfA+
 SOT+is7O/mnV2QcRJCVu69M2JI1Y=
X-Gm-Gg: ASbGncs2fKu0s8zgqMm+phb7g1XUwcG7Psmo2+l8XaMhhSQubyu3WqQliKtszkiChiz
 7Dto+/SluG4oDfGIPsXIKXD7+AYK/3KRWxl52JxM4XFKToMxTQXA=
X-Google-Smtp-Source: AGHT+IHr3Ng4Nr25yeWaj1KQfxbKQkvZZXY6XfvXsC5apAYPFL689y9nGONp5fQpa3gffOThNTHcaISU2CZMmOqawuQ=
X-Received: by 2002:a05:6512:1383:b0:542:7053:ef1b with SMTP id
 2adb3069b0e04-5439c245c41mr5253748e87.29.1737456975068; Tue, 21 Jan 2025
 02:56:15 -0800 (PST)
MIME-Version: 1.0
References: <20250118164056.830721-1-r.peniaev@gmail.com>
 <20250118164056.830721-3-r.peniaev@gmail.com>
 <CAMxuvaxUDzGN1H-zUccQrEz0KvG+a_9t1iKVz4YJQrsdwr=WKA@mail.gmail.com>
In-Reply-To: <CAMxuvaxUDzGN1H-zUccQrEz0KvG+a_9t1iKVz4YJQrsdwr=WKA@mail.gmail.com>
From: Roman Penyaev <r.peniaev@gmail.com>
Date: Tue, 21 Jan 2025 11:56:04 +0100
X-Gm-Features: AbW1kvYITicjW3ijWZk27C6nc4Ry8iS7kYtEaVPzOnwp19C6Z-NBURXXQkHzJiU
Message-ID: <CACZ9PQVZjbF4Nvocoa04J7F6DXyBcWd+5DHp+EvJ7pf=HCa0Jg@mail.gmail.com>
Subject: Re: [PATCH v7 2/4] chardev/char-hub: implement backend chardev
 aggregator
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=r.peniaev@gmail.com; helo=mail-lf1-x134.google.com
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

Hi Marc-Andr=C3=A9,

On Mon, Jan 20, 2025 at 12:21=E2=80=AFPM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Hi
>
> On Sat, Jan 18, 2025 at 8:41=E2=80=AFPM Roman Penyaev <r.peniaev@gmail.co=
m> wrote:
> >
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
> > 'chardevs.N' list syntax is used for the sake of compatibility with
> > the representation of JSON lists in 'key=3Dval' pairs format of the
> > util/keyval.c, despite the fact that modern QAPI way of parsing,
> > namely qobject_input_visitor_new_str(), is not used. Choice of keeping
> > QAPI list sytax may help to smoothly switch to modern parsing in the
>
> syntax

Will fix. Thanks.

>
> > future.
> >
> > Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
> > Cc: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
> > Cc: qemu-devel@nongnu.org
> > ---
> >  chardev/char-fe.c          |   9 +
> >  chardev/char-hub.c         | 334 +++++++++++++++++++++++++++++++++++++
> >  chardev/char.c             |  26 ++-
> >  chardev/chardev-internal.h |  56 ++++++-
> >  chardev/meson.build        |   1 +
> >  include/chardev/char.h     |   1 +
> >  qapi/char.json             |  27 +++
> >  7 files changed, 451 insertions(+), 3 deletions(-)
> >  create mode 100644 chardev/char-hub.c
> >
> > diff --git a/chardev/char-fe.c b/chardev/char-fe.c
> > index 158a5f4f551e..cfd0577c3f46 100644
> > --- a/chardev/char-fe.c
> > +++ b/chardev/char-fe.c
> > @@ -200,6 +200,12 @@ bool qemu_chr_fe_init(CharBackend *b, Chardev *s, =
Error **errp)
> >              if (!mux_chr_attach_frontend(d, b, &tag, errp)) {
> >                  return false;
> >              }
> > +        } else if (CHARDEV_IS_HUB(s)) {
> > +            HubChardev *d =3D HUB_CHARDEV(s);
> > +
> > +            if (!hub_chr_attach_frontend(d, b, errp)) {
> > +                return false;
> > +            }
> >          } else if (s->be) {
> >              error_setg(errp, "chardev '%s' is already in use", s->labe=
l);
> >              return false;
> > @@ -226,6 +232,9 @@ void qemu_chr_fe_deinit(CharBackend *b, bool del)
> >          if (CHARDEV_IS_MUX(b->chr)) {
> >              MuxChardev *d =3D MUX_CHARDEV(b->chr);
> >              mux_chr_detach_frontend(d, b->tag);
> > +        } else if (CHARDEV_IS_HUB(b->chr)) {
> > +            HubChardev *d =3D HUB_CHARDEV(b->chr);
> > +            hub_chr_detach_frontend(d);
> >          }
>
> you don't need this extra attach/detach logic, you can rely on parent
> implementation. See attached patch

Ah, correct. What a service, thank you :) I was focused on the attach
logic that I completely forgot the hub is a char device itself.

Will squash your changes.

>
>
> >          if (del) {
> >              Object *obj =3D OBJECT(b->chr);
> > diff --git a/chardev/char-hub.c b/chardev/char-hub.c
> > new file mode 100644
> > index 000000000000..9b53df51de44
> > --- /dev/null
> > +++ b/chardev/char-hub.c
> > @@ -0,0 +1,336 @@
> > +/*
> > + * QEMU Character Hub Device
> > + *
> > + * Author: Roman Penyaev <r.peniaev@gmail.com>
> > + *
> > + * Permission is hereby granted, free of charge, to any person obtaini=
ng a copy
> > + * of this software and associated documentation files (the "Software"=
), to deal
> > + * in the Software without restriction, including without limitation t=
he rights
> > + * to use, copy, modify, merge, publish, distribute, sublicense, and/o=
r sell
> > + * copies of the Software, and to permit persons to whom the Software =
is
> > + * furnished to do so, subject to the following conditions:
> > + *
> > + * The above copyright notice and this permission notice shall be incl=
uded in
> > + * all copies or substantial portions of the Software.
> > + *
> > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXP=
RESS OR
> > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABI=
LITY,
> > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT S=
HALL
> > + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES O=
R OTHER
> > + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARI=
SING FROM,
> > + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALI=
NGS IN
> > + * THE SOFTWARE.
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "qapi/error.h"
> > +#include "qemu/option.h"
> > +#include "chardev/char.h"
> > +#include "chardev-internal.h"
> > +
> > +/*
> > + * Character hub device aggregates input from multiple backend devices
> > + * and forwards it to a single frontend device. Additionally, hub
> > + * device takes the output from the frontend device and sends it back
> > + * to all the connected backend devices.
> > + */
> > +
> > +/*
> > + * Write to all backends. Different backend devices accept data with
> > + * various rate, so it is quite possible that one device returns less,
> > + * then others. In this case we return minimum to the caller,
> > + * expecting caller will repeat operation soon. When repeat happens
> > + * send to the devices which consume data faster must be avoided
> > + * for obvious reasons not to send data, which was already sent.
> > + */
> > +static int hub_chr_write_to_all(HubChardev *d, const uint8_t *buf, int=
 len)
> > +{
> > +    int r, i, ret =3D len;
> > +    unsigned int written;
> > +
> > +    /* Invalidate index on every write */
> > +    d->be_eagain_ind =3D -1;
> > +
> > +    for (i =3D 0; i < d->be_cnt; i++) {
> > +        if (!d->backends[i].be.chr->be_open) {
> > +            /* Skip closed backend */
> > +            continue;
> > +        }
> > +        written =3D d->be_written[i] - d->be_min_written;
> > +        if (written) {
> > +            /* Written in the previous call so take into account */
> > +            ret =3D MIN(written, ret);
> > +            continue;
> > +        }
> > +        r =3D qemu_chr_fe_write(&d->backends[i].be, buf, len);
> > +        if (r < 0 && errno =3D=3D EAGAIN) {
> > +            /*
> > +             * Fail immediately if write would block. Expect to be cal=
led
> > +             * soon on watch wake up.
> > +             */
> > +            d->be_eagain_ind =3D i;
> > +            return r;
> > +        } else if (r < 0) {
> > +            /*
> > +             * Ignore all other errors and pretend the entire buffer i=
s
> > +             * written to avoid this chardev being watched. This devic=
e
> > +             * becomes disabled until the following write succeeds, bu=
t
> > +             * writing continues to others.
> > +             */
>
> I wonder if this behaviour is desirable. Why silence the error? What
> if all backends fail?

The intention was to cover the case, when one of the backend devices is
closed, but I need to continue serving writes for the other devices. Later =
I
discovered the OPENED/CLOSED events and `->be_open` flag. So you
are absolutely correct, this "else if" branch is not needed any more and
can be removed. Thanks.

>
> > +            r =3D len;
> > +        }
> > +        d->be_written[i] +=3D r;
> > +        ret =3D MIN(r, ret);
> > +    }
> > +    d->be_min_written +=3D ret;
> > +
> > +    return ret;
> > +}
> > +
> > +/* Called with chr_write_lock held.  */
> > +static int hub_chr_write(Chardev *chr, const uint8_t *buf, int len)
> > +{
> > +    HubChardev *d =3D HUB_CHARDEV(chr);
> > +    return hub_chr_write_to_all(d, buf, len);
>
> no need for an extra function, you can just inline here

Will do, not a big deal.

>
> > +}
> > +
> > +static int hub_chr_can_read(void *opaque)
> > +{
> > +    HubCharBackend *backend =3D opaque;
> > +    CharBackend *fe =3D backend->hub->frontend;
> > +
> > +    if (fe && fe->chr_can_read) {
> > +        return fe->chr_can_read(fe->opaque);
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> > +static void hub_chr_read(void *opaque, const uint8_t *buf, int size)
> > +{
> > +    HubCharBackend *backend =3D opaque;
> > +    CharBackend *fe =3D backend->hub->frontend;
> > +
> > +
> > +    if (fe && fe->chr_read) {
> > +        fe->chr_read(fe->opaque, buf, size);
> > +    }
> > +}
> > +
> > +static void hub_chr_event(void *opaque, QEMUChrEvent event)
> > +{
> > +    HubCharBackend *backend =3D opaque;
> > +    HubChardev *d =3D backend->hub;
> > +    CharBackend *fe =3D d->frontend;
> > +
> > +    if (event =3D=3D CHR_EVENT_OPENED) {
> > +        /*
> > +         * Catch up with what was already written while this backend
> > +         * was closed
> > +         */
> > +        d->be_written[backend->be_ind] =3D d->be_min_written;
> > +
> > +        if (d->be_event_opened_cnt++) {
> > +            /* Ignore subsequent open events from other backends */
> > +            return;
> > +        }
> > +    } else if (event =3D=3D CHR_EVENT_CLOSED) {
> > +        if (!d->be_event_opened_cnt) {
> > +            /* Don't go below zero. Probably assert is better */
> > +            return;
> > +        }
> > +        if (--d->be_event_opened_cnt) {
> > +            /* Serve only the last one close event */
> > +            return;
> > +        }
>
> I wonder if it really makes sense to open when the first chardev opens
> and close with the last one.
>
> I would rather have a default "safe" behaviour that opens when all are
> open, and close when the first one is closed.
>
> Or a loosy behaviour that would just stay open, regardless of backend sta=
tus.
>
> Or a "selected" behaviour where one backend dictates the hub state.

The concept is similar to an fd handle: a file is considered opened if ther=
e
is a valid reference (fd handle) on it. Backend devices can appear and
disappear at any time, there are no main or selected backend devices, all
are equal.

Closing the frontend when the first backend is closed definitely breaks the
user scenario, since there is no way to predict when the user will open or =
close
the backend device (attach/detach to a pty device or a connection to a sock=
et
can happen at any time).

Keeping the frontend device open seems to do no harm, but it seemed wrong
to me resource wise on the guest and also makes it impossible to implement
logic on the guest that would determine when the opposite side is open/clos=
ed
(this can be relevant for virtualserialport scenario). So I wanted to
do it "correctly".

Do you foresee any issues? I noticed that OPEN/CLOSED events can often
be repeated or not sent at all (the first patch solves this problem
for char-pty).
Although, tests/unit/test-char.c tries to verify the correctness by
counting these
events.

I tested the reference logic using pty/socket/vc backends paired with
virtconsole/virtserialport frontends.

>
>
> > +    }
> > +
> > +    if (fe && fe->chr_event) {
> > +        fe->chr_event(fe->opaque, event);
> > +    }
> > +}
> > +
> > +static GSource *hub_chr_add_watch(Chardev *s, GIOCondition cond)
> > +{
> > +    HubChardev *d =3D HUB_CHARDEV(s);
> > +    Chardev *chr;
> > +    ChardevClass *cc;
> > +
> > +    if (d->be_eagain_ind =3D=3D -1) {
> > +        return NULL;
> > +    }
> > +
> > +    assert(d->be_eagain_ind < d->be_cnt);
> > +    chr =3D qemu_chr_fe_get_driver(&d->backends[d->be_eagain_ind].be);
> > +    cc =3D CHARDEV_GET_CLASS(chr);
> > +    if (!cc->chr_add_watch) {
> > +        return NULL;
> > +    }
> > +
> > +    return cc->chr_add_watch(chr, cond);
> > +}
> > +
> > +static bool hub_chr_attach_chardev(HubChardev *d, Chardev *chr,
> > +                                   Error **errp)
> > +{
> > +    bool ret;
> > +
> > +    if (d->be_cnt >=3D MAX_HUB) {
> > +        error_setg(errp, "hub: too many uses of chardevs '%s'"
> > +                   " (maximum is " stringify(MAX_HUB) ")",
> > +                   d->parent.label);
> > +        return false;
> > +    }
> > +    ret =3D qemu_chr_fe_init(&d->backends[d->be_cnt].be, chr, errp);
> > +    if (ret) {
> > +        d->backends[d->be_cnt].hub =3D d;
> > +        d->backends[d->be_cnt].be_ind =3D d->be_cnt;
> > +        d->be_cnt +=3D 1;
> > +    }
> > +
> > +    return ret;
> > +}
> > +
> > +static void char_hub_finalize(Object *obj)
> > +{
> > +    HubChardev *d =3D HUB_CHARDEV(obj);
> > +    CharBackend *fe =3D d->frontend;
> > +    int i;
> > +
> > +    if (fe) {
> > +        fe->chr =3D NULL;
> > +    }
> > +    for (i =3D 0; i < d->be_cnt; i++) {
> > +        qemu_chr_fe_deinit(&d->backends[i].be, false);
> > +    }
> > +}
> > +
> > +static void hub_chr_update_read_handlers(Chardev *chr)
> > +{
> > +    HubChardev *d =3D HUB_CHARDEV(chr);
> > +    int i;
> > +
> > +    for (i =3D 0; i < d->be_cnt; i++) {
> > +        qemu_chr_fe_set_handlers_full(&d->backends[i].be,
> > +                                      hub_chr_can_read,
> > +                                      hub_chr_read,
> > +                                      hub_chr_event,
> > +                                      NULL,
> > +                                      &d->backends[i],
> > +                                      chr->gcontext, true, false);
> > +    }
> > +}
> > +
> > +bool hub_chr_attach_frontend(HubChardev *d, CharBackend *b, Error **er=
rp)
> > +{
> > +    if (d->frontend) {
> > +        error_setg(errp, "hub: multiplexed chardev '%s' is already use=
d "
> > +                   "for multiplexing", d->parent.label);
> > +        return false;
> > +    }
> > +    d->frontend =3D b;
> > +
> > +    return true;
> > +}
> > +
> > +void hub_chr_detach_frontend(HubChardev *d)
> > +{
> > +    d->frontend =3D NULL;
> > +}
> > +
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
> > +        }
> > +        if (!hub_chr_attach_chardev(d, s, errp)) {
> > +            return;
> > +        }
> > +        list =3D list->next;
> > +    }
> > +
> > +    /* Closed until an explicit event from backend */
> > +    *be_opened =3D false;
> > +}
> > +
> > +static void qemu_chr_parse_hub(QemuOpts *opts, ChardevBackend *backend=
,
> > +                                  Error **errp)
> > +{
> > +    ChardevHub *hub;
> > +    strList **tail;
> > +    int i;
> > +
> > +    backend->type =3D CHARDEV_BACKEND_KIND_HUB;
> > +    hub =3D backend->u.hub.data =3D g_new0(ChardevHub, 1);
> > +    qemu_chr_parse_common(opts, qapi_ChardevHub_base(hub));
> > +
> > +    tail =3D &hub->chardevs;
> > +
> > +    for (i =3D 0; i < MAX_HUB; i++) {
> > +        char optbuf[16];
> > +        const char *dev;
> > +
> > +        snprintf(optbuf, sizeof(optbuf), "chardevs.%u", i);
> > +        dev =3D qemu_opt_get(opts, optbuf);
> > +        if (!dev) {
> > +            break;
> > +        }
> > +
> > +        QAPI_LIST_APPEND(tail, g_strdup(dev));
> > +    }
> > +}
> > +
> > +static void char_hub_class_init(ObjectClass *oc, void *data)
> > +{
> > +    ChardevClass *cc =3D CHARDEV_CLASS(oc);
> > +
> > +    cc->parse =3D qemu_chr_parse_hub;
> > +    cc->open =3D qemu_chr_open_hub;
> > +    cc->chr_write =3D hub_chr_write;
> > +    cc->chr_add_watch =3D hub_chr_add_watch;
> > +    /* We handle events from backends only */
> > +    cc->chr_be_event =3D NULL;
> > +    cc->chr_update_read_handler =3D hub_chr_update_read_handlers;
> > +}
> > +
> > +static const TypeInfo char_hub_type_info =3D {
> > +    .name =3D TYPE_CHARDEV_HUB,
> > +    .parent =3D TYPE_CHARDEV,
> > +    .class_init =3D char_hub_class_init,
> > +    .instance_size =3D sizeof(HubChardev),
> > +    .instance_finalize =3D char_hub_finalize,
> > +};
> > +
> > +static void register_types(void)
> > +{
> > +    type_register_static(&char_hub_type_info);
> > +}
> > +
> > +type_init(register_types);
> > diff --git a/chardev/char.c b/chardev/char.c
> > index 7705da5ad02b..31536f4b7356 100644
> > --- a/chardev/char.c
> > +++ b/chardev/char.c
> > @@ -334,6 +334,9 @@ static bool qemu_chr_is_busy(Chardev *s)
> >      if (CHARDEV_IS_MUX(s)) {
> >          MuxChardev *d =3D MUX_CHARDEV(s);
> >          return d->mux_bitset !=3D 0;
> > +    } else if (CHARDEV_IS_HUB(s)) {
> > +        HubChardev *d =3D HUB_CHARDEV(s);
> > +        return d->frontend !=3D NULL;
> >      } else {
> >          return s->be !=3D NULL;
> >      }
> > @@ -943,7 +946,26 @@ QemuOptsList qemu_chardev_opts =3D {
> >          },{
> >              .name =3D "chardev",
> >              .type =3D QEMU_OPT_STRING,
> > +        },
> > +        /*
> > +         * Multiplexer options. Follows QAPI array syntax.
> > +         * See MAX_HUB macro to obtain array capacity.
> > +         */
> > +        {
> > +            .name =3D "chardevs.0",
> > +            .type =3D QEMU_OPT_STRING,
> > +        },{
> > +            .name =3D "chardevs.1",
> > +            .type =3D QEMU_OPT_STRING,
> >          },{
> > +            .name =3D "chardevs.2",
> > +            .type =3D QEMU_OPT_STRING,
> > +        },{
> > +            .name =3D "chardevs.3",
> > +            .type =3D QEMU_OPT_STRING,
> > +        },
> > +
> > +        {
> >              .name =3D "append",
> >              .type =3D QEMU_OPT_BOOL,
> >          },{
> > @@ -1106,8 +1128,8 @@ ChardevReturn *qmp_chardev_change(const char *id,=
 ChardevBackend *backend,
> >          return NULL;
> >      }
> >
> > -    if (CHARDEV_IS_MUX(chr)) {
> > -        error_setg(errp, "Mux device hotswap not supported yet");
> > +    if (CHARDEV_IS_MUX(chr) || CHARDEV_IS_HUB(chr)) {
> > +        error_setg(errp, "For mux or hub device hotswap is not support=
ed yet");
> >          return NULL;
> >      }
> >
> > diff --git a/chardev/chardev-internal.h b/chardev/chardev-internal.h
> > index 853807f3cb88..ff5432008aad 100644
> > --- a/chardev/chardev-internal.h
> > +++ b/chardev/chardev-internal.h
> > @@ -29,13 +29,16 @@
> >  #include "chardev/char-fe.h"
> >  #include "qom/object.h"
> >
> > +#define MAX_HUB 4
> >  #define MAX_MUX 4
> >  #define MUX_BUFFER_SIZE 32 /* Must be a power of 2.  */
> >  #define MUX_BUFFER_MASK (MUX_BUFFER_SIZE - 1)
> >
> >  struct MuxChardev {
> >      Chardev parent;
> > +    /* Linked frontends */
> >      CharBackend *backends[MAX_MUX];
> > +    /* Linked backend */
> >      CharBackend chr;
> >      unsigned long mux_bitset;
> >      int focus;
> > @@ -53,11 +56,59 @@ struct MuxChardev {
> >      int64_t timestamps_start;
> >  };
> >  typedef struct MuxChardev MuxChardev;
> > +typedef struct HubChardev HubChardev;
> > +typedef struct HubCharBackend HubCharBackend;
> > +
> > +/*
> > + * Back-pointer on a hub, actual backend and its index in
> > + * `hub->backends` array
> > + */
> > +struct HubCharBackend {
> > +    HubChardev   *hub;
> > +    CharBackend  be;
> > +    unsigned int be_ind;
> > +};
> > +
> > +struct HubChardev {
> > +    Chardev parent;
> > +    /* Linked frontend */
> > +    CharBackend *frontend;
> > +    /* Linked backends */
> > +    HubCharBackend backends[MAX_HUB];
> > +    /*
> > +     * Number of backends attached to this hub. Once attached, a
> > +     * backend can't be detached, so the counter is only increasing.
> > +     * To safely remove a backend, hub has to be removed first.
> > +     */
> > +    unsigned int be_cnt;
> > +    /*
> > +     * Number of CHR_EVEN_OPENED events from all backends. Needed to
> > +     * send CHR_EVEN_CLOSED only when counter goes to zero.
> > +     */
> > +    unsigned int be_event_opened_cnt;
> > +    /*
> > +     * Counters of written bytes from a single frontend device
> > +     * to multiple backend devices.
> > +     */
> > +    unsigned int be_written[MAX_HUB];
> > +    unsigned int be_min_written;
> > +    /*
> > +     * Index of a backend device which got EAGAIN on last write,
> > +     * -1 is invalid index.
> > +     */
> > +    int be_eagain_ind;
> > +};
> > +typedef struct HubChardev HubChardev;
> >
> >  DECLARE_INSTANCE_CHECKER(MuxChardev, MUX_CHARDEV,
> >                           TYPE_CHARDEV_MUX)
> > -#define CHARDEV_IS_MUX(chr)                             \
> > +DECLARE_INSTANCE_CHECKER(HubChardev, HUB_CHARDEV,
> > +                         TYPE_CHARDEV_HUB)
> > +
> > +#define CHARDEV_IS_MUX(chr)                                \
> >      object_dynamic_cast(OBJECT(chr), TYPE_CHARDEV_MUX)
> > +#define CHARDEV_IS_HUB(chr)                                \
> > +    object_dynamic_cast(OBJECT(chr), TYPE_CHARDEV_HUB)
> >
> >  bool mux_chr_attach_frontend(MuxChardev *d, CharBackend *b,
> >                               unsigned int *tag, Error **errp);
> > @@ -65,6 +116,9 @@ bool mux_chr_detach_frontend(MuxChardev *d, unsigned=
 int tag);
> >  void mux_set_focus(Chardev *chr, unsigned int focus);
> >  void mux_chr_send_all_event(Chardev *chr, QEMUChrEvent event);
> >
> > +bool hub_chr_attach_frontend(HubChardev *d, CharBackend *b, Error **er=
rp);
> > +void hub_chr_detach_frontend(HubChardev *d);
> > +
> >  Object *get_chardevs_root(void);
> >
> >  #endif /* CHARDEV_INTERNAL_H */
> > diff --git a/chardev/meson.build b/chardev/meson.build
> > index 70070a8279a9..56ee39ac0b01 100644
> > --- a/chardev/meson.build
> > +++ b/chardev/meson.build
> > @@ -3,6 +3,7 @@ chardev_ss.add(files(
> >    'char-file.c',
> >    'char-io.c',
> >    'char-mux.c',
> > +  'char-hub.c',
> >    'char-null.c',
> >    'char-pipe.c',
> >    'char-ringbuf.c',
> > diff --git a/include/chardev/char.h b/include/chardev/char.h
> > index 01df55f9e8c8..429852f8d9d3 100644
> > --- a/include/chardev/char.h
> > +++ b/include/chardev/char.h
> > @@ -232,6 +232,7 @@ OBJECT_DECLARE_TYPE(Chardev, ChardevClass, CHARDEV)
> >
> >  #define TYPE_CHARDEV_NULL "chardev-null"
> >  #define TYPE_CHARDEV_MUX "chardev-mux"
> > +#define TYPE_CHARDEV_HUB "chardev-hub"
> >  #define TYPE_CHARDEV_RINGBUF "chardev-ringbuf"
> >  #define TYPE_CHARDEV_PTY "chardev-pty"
> >  #define TYPE_CHARDEV_CONSOLE "chardev-console"
> > diff --git a/qapi/char.json b/qapi/char.json
> > index e04535435034..f02b66c06b3e 100644
> > --- a/qapi/char.json
> > +++ b/qapi/char.json
> > @@ -332,6 +332,19 @@
> >    'data': { 'chardev': 'str' },
> >    'base': 'ChardevCommon' }
> >
> > +##
> > +# @ChardevHub:
> > +#
> > +# Configuration info for hub chardevs.
> > +#
> > +# @chardevs: List of chardev IDs, which should be added to this hub
> > +#
> > +# Since: 10.0
> > +##
> > +{ 'struct': 'ChardevHub',
> > +  'data': { 'chardevs': ['str'] },
> > +  'base': 'ChardevCommon' }
> > +
> >  ##
> >  # @ChardevStdio:
> >  #
> > @@ -479,6 +492,8 @@
> >  #
> >  # @mux: (since 1.5)
> >  #
> > +# @hub: (since 10.0)
> > +#
> >  # @msmouse: emulated Microsoft serial mouse (since 1.5)
> >  #
> >  # @wctablet: emulated Wacom Penpartner serial tablet (since 2.9)
> > @@ -521,6 +536,7 @@
> >              'pty',
> >              'null',
> >              'mux',
> > +            'hub',
> >              'msmouse',
> >              'wctablet',
> >              { 'name': 'braille', 'if': 'CONFIG_BRLAPI' },
> > @@ -595,6 +611,16 @@
> >  { 'struct': 'ChardevMuxWrapper',
> >    'data': { 'data': 'ChardevMux' } }
> >
> > +##
> > +# @ChardevHubWrapper:
> > +#
> > +# @data: Configuration info for hub chardevs
> > +#
> > +# Since: 10.0
> > +##
> > +{ 'struct': 'ChardevHubWrapper',
> > +  'data': { 'data': 'ChardevHub' } }
> > +
> >  ##
> >  # @ChardevStdioWrapper:
> >  #
> > @@ -703,6 +729,7 @@
> >              'pty': 'ChardevPtyWrapper',
> >              'null': 'ChardevCommonWrapper',
> >              'mux': 'ChardevMuxWrapper',
> > +            'hub': 'ChardevHubWrapper',
> >              'msmouse': 'ChardevCommonWrapper',
> >              'wctablet': 'ChardevCommonWrapper',
> >              'braille': { 'type': 'ChardevCommonWrapper',
> > --
> > 2.43.0
> >
>
> looks ok to me otherwise

I'll resend the series, thanks.

--
Roman

