Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A25A8CCD19B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 10:53:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqsIY-00055h-D9; Wed, 18 Sep 2024 06:52:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sqsIW-00055D-VY
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 06:52:36 -0400
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sqsIT-0005No-FD
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 06:52:36 -0400
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-45aeef3ce92so21613211cf.2
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 03:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726656752; x=1727261552; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6qT1ud3TiHqBPgiPpzJigS/bw3pqiUrsaAc+qaS+quE=;
 b=UL5yys4DBujQKHmq8WksHFaX+UuU62kRH2lxDUBUiFW4UM73XNHHMcvO5+tL2AybJy
 YdnmvCw/sSt85a9Xj5llfzK/bOEnTwXpg513h0xV5rOOWvaUVI4lUO3RW5TEPYIuKhaX
 0eGqVoiODg6MBuciDD+FZPL54YSKZgIKl/iY7zJPoT2Znh9qj5z7OhuINUzmCKV1eW3V
 UlgFBg/8Z1hBGb0atHx5VkZzwXvj4POZdjRYHBYuFbJ99jyPY0jVxJPALBCNcH9Hj8Lv
 4Dk172S3zyleHoqnzk7mgSioRbkZQxb5574RD7ofEDnJYbpShiwuMhdoPw3zdH+Bze0K
 InpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726656752; x=1727261552;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6qT1ud3TiHqBPgiPpzJigS/bw3pqiUrsaAc+qaS+quE=;
 b=qZZamnhtzxLiCxronagHfJ/1ERFNlyb3Lkzwy+z9PCohRscqhyXsoumjgwOY2pto07
 CHoWvvJkBXv5fnABwzzLRHOtjkBifvYCjp4AyCTgJQDoUlBtBUGkZDLPLAL8wdT1JfiC
 bEEdA2Y/sHX9GvKJhEkZnB2QZk2LmvSAspGG/s74JFZsUno9T1h1CrL5Lq6jeGOvqJMW
 ihceOGsyFStZ+ZNrtYW4Dre+/zE4wTM6zEfEba2zJQq+ciQXP0h2mnhcIMgkFRnG5llm
 2mr6usNMwdiR86BnNP5Z440GdIJdogrKXGOIlTZQt1H4RFLpnlnFiSpIXpYMDi/31zTf
 Ajeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWISKG1gODCtWGCu3rGy9K9H/6CFArQlfh2QP1f5UHwNJgzPgMMmQ5BxwKH0e2nYAfQd3HXP18oqgO2@nongnu.org
X-Gm-Message-State: AOJu0YwU/T5yO6mbBRqiSYAbCYYNZbtcqmYmg1Ta1MG8jTEI9Ud0olWC
 OSMHl2dNs2PobTa1F05QSD0wg+7nSIcmra0BTdf40ozrM1gvOHxbYkkNh8iV0Tf/pj4/xp0bTAS
 AQTNDhDPkD/5kisAq7Fn9c6+6qnI=
X-Google-Smtp-Source: AGHT+IFcolOsTDSrNJJjqXr8dWZQEOK4tw+KE39YFdmb99l4ruHBNsj3ndT+UMHa8IrXXtjCJcy17WPcPJoLtRdvDPs=
X-Received: by 2002:a05:622a:4d1:b0:458:5fd0:964c with SMTP id
 d75a77b69052e-45860420b84mr352637131cf.50.1726656751837; Wed, 18 Sep 2024
 03:52:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240913163636.253949-1-r.peniaev@gmail.com>
 <20240913163636.253949-2-r.peniaev@gmail.com>
 <CAMxuvawD8QrsjJ9xiE9KDa=BTj8urRcCcN5YasiE3m-R7xEcuQ@mail.gmail.com>
 <CACZ9PQU2X0T+FX6QV+6O8MhBLuJkLut41rtjb5Lp5z+3Sjm6Ww@mail.gmail.com>
In-Reply-To: <CACZ9PQU2X0T+FX6QV+6O8MhBLuJkLut41rtjb5Lp5z+3Sjm6Ww@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 18 Sep 2024 14:52:20 +0400
Message-ID: <CAJ+F1CL1fg=hWYiprQ8BubpPSAgS1JMj6dY9Av-rKitw9ZhWzg@mail.gmail.com>
Subject: Re: [PATCH 1/2] chardev: implement backend chardev multiplexing
To: Roman Penyaev <r.peniaev@gmail.com>, Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000057aa220622629aa2"
Received-SPF: pass client-ip=2607:f8b0:4864:20::82e;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82e.google.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, NORMAL_HTTP_TO_IP=0.001, NUMERIC_HTTP_ADDR=1.242,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_PORT=0.001 autolearn=ham autolearn_force=no
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

--00000000000057aa220622629aa2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Tue, Sep 17, 2024 at 6:17=E2=80=AFPM Roman Penyaev <r.peniaev@gmail.com>=
 wrote:

> Hi Marc-Andr=C3=A9,
>
> On Tue, Sep 17, 2024 at 2:31=E2=80=AFPM Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@redhat.com> wrote:
> >
> > Hi Roman
> >
> > On Fri, Sep 13, 2024 at 8:37=E2=80=AFPM Roman Penyaev <r.peniaev@gmail.=
com>
> wrote:
> > >
> > > This patch implements multiplexing capability of several backend
> > > devices, which opens up an opportunity to use a single frontend
> > > device on the guest, which can be manipulated from several
> > > backend devices.
> > >
> > > The idea of the change is trivial: keep list of backend devices
> > > (up to 4), init them on demand and forward data buffer back and
> > > forth.
> > >
> > > The following is QEMU command line example:
> > >
> > >   -chardev socket,path=3D/tmp/sock,server=3Don,wait=3Doff,id=3Dsock0 =
\
> > >   -chardev vc,id=3Dvc0 \
> > >   -chardev mux,id=3Dmux0,chardev=3Dvc0,,sock0 \
> > >   -device virtconsole,chardev=3Dmux0 \
> > >   -vnc 0.0.0.0:0
> > >
> > > Which creates 2 backend devices: text virtual console (`vc0`)
> > > and a socket (`sock0`) connected to the single virtio hvc
> > > console with the multiplexer (`mux0`) help. `vc0` renders
> > > text to an image, which can be shared over the VNC protocol.
> > > `sock0` is a socket backend which provides biderectional
> > > communication to the virtio hvc console.
> >
> > I think I would rather implement a new mux for this purpose, like
> > "mux-be" perhaps?
>
> Do you mean a completely different implementation or just an alias
> for the cli needs? Because code of the backend multiplexing nicely fits
> current mux and I tried to avoid code duplication.
>

It's not the same behaviour though, and discoverability/compatibility would
be easier to handle. There is also various code in mux that isn't needed.

You can still factorize common code, or have a common base class.
Eventually, the two chardev can be from the same file. I don't know if that
makes sense.


> >
> > "mux" has been a bit hidden (behind mux=3Don) for various reasons, and
> > is probably not at production quality level.
>
> Well, indeed creating "chardev mux" is not described in the doc, but you
> can do this anyway :) Here I just followed the same pattern as we do for
> other devices: "chardev NAME". Having a "mux-be" (or any other) alias
> won't expose the default "mux", so configurations can be separated.
> Is that what you meant?
>

yes, this would help in general misconfiguration (although -chardev option
handling has a lot to be desired)


>
> Also, mux is used implicitly for various of configurations, this is
> described in the manual:
>
>    Note that some other command line options may implicitly create
>    multiplexed character backends; for instance -serial mon:stdio creates
>    a multiplexed stdio backend connected to the serial port and the QEMU
>    monitor, and -nographic also multiplexes the console and the
> monitor to stdio.
>
> So it seems to me mux is used (tested) quite extensively.
>

kinda, it's used by end-users who run qemu from the CLI. Probably less in
production systems.


>
> >
> > I am not sure how CLI should handle option arrays these days
> > (especially with -chardev CLI not being json-friendly).
>
> By CLI do you mean the default QEMU command line interface?
>

yes


> The command line with arrays (double commas ",,") I specified above
> works fine. Can you suggest any other tool (or json formatting) you have
> in mind so I can verify?
>

Indeed, this double commas stuff is weird, I don't know that "trick". Is it
used elsewhere and documented? I don't see a test in test-qemu-opts.c
either.

There is another ongoing discussion about json support for -chardev:
"-chardev with a JSON argument".


> >
> > >
> > > Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
> > > Cc: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
> > > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > > Cc: qemu-devel@nongnu.org
> > > ---
> > >  chardev/char-fe.c          |  14 +++--
> > >  chardev/char-mux.c         | 120 +++++++++++++++++++++++++++++------=
--
> > >  chardev/char.c             |   2 +-
> > >  chardev/chardev-internal.h |   7 ++-
> > >  4 files changed, 111 insertions(+), 32 deletions(-)
> > >
> > > diff --git a/chardev/char-fe.c b/chardev/char-fe.c
> > > index b214ba3802b1..d1f67338084d 100644
> > > --- a/chardev/char-fe.c
> > > +++ b/chardev/char-fe.c
> > > @@ -197,16 +197,22 @@ bool qemu_chr_fe_init(CharBackend *b, Chardev
> *s, Error **errp)
> > >          if (CHARDEV_IS_MUX(s)) {
> > >              MuxChardev *d =3D MUX_CHARDEV(s);
> > >
> > > -            if (d->mux_cnt >=3D MAX_MUX) {
> > > +            if (d->fe_cnt >=3D MAX_MUX) {
> > >                  error_setg(errp,
> > >                             "too many uses of multiplexed chardev '%s=
'"
> > >                             " (maximum is " stringify(MAX_MUX) ")",
> > >                             s->label);
> > >                  return false;
> > >              }
> > > -
> > > -            d->backends[d->mux_cnt] =3D b;
> > > -            tag =3D d->mux_cnt++;
> > > +            if (d->fe_cnt > 0 && d->be_cnt > 1) {
> > > +                error_setg(errp,
> > > +                           "multiplexed chardev '%s' is already used=
 "
> > > +                           "for backend multiplexing",
> > > +                           s->label);
> > > +                return false;
> > > +            }
> > > +            d->backends[d->fe_cnt] =3D b;
> > > +            tag =3D d->fe_cnt++;
> > >          } else if (s->be) {
> > >              error_setg(errp, "chardev '%s' is already in use",
> s->label);
> > >              return false;
> > > diff --git a/chardev/char-mux.c b/chardev/char-mux.c
> > > index ee2d47b20d9b..82f728b5caf8 100644
> > > --- a/chardev/char-mux.c
> > > +++ b/chardev/char-mux.c
> > > @@ -26,6 +26,7 @@
> > >  #include "qapi/error.h"
> > >  #include "qemu/module.h"
> > >  #include "qemu/option.h"
> > > +#include "qemu/cutils.h"
> > >  #include "chardev/char.h"
> > >  #include "sysemu/block-backend.h"
> > >  #include "qapi/qapi-commands-control.h"
> > > @@ -40,13 +41,39 @@
> > >   */
> > >  static bool muxes_opened =3D true;
> > >
> > > +/* Write to all backends  */
> > > +static int mux_chr_fe_write(MuxChardev *mux, const uint8_t *buf, int
> len)
> > > +{
> > > +        int r, ret =3D -1, i;
> > > +
> > > +        for (i =3D 0; i < mux->be_cnt; i++) {
> > > +                r =3D qemu_chr_fe_write(&mux->chrs[i], buf, len);
> > > +                ret =3D ret < 0 ? r : MAX(r, ret);
> >
> > I think it should be conservative and fail early if one of the backend
> > fails. Also if different frontends can write different amounts, there
> > needs to be some buffering... or it should always use write_all()
> > which has also a shortcoming since it blocks the thread.
>
> Yes, early fail and buffers make sense.
>
> >
> > > +        }
> > > +
> > > +        return ret;
> > > +}
> > > +
> > > +/* Write to all backends  */
> > > +static int mux_chr_fe_write_all(MuxChardev *mux, const uint8_t *buf,
> int len)
> > > +{
> > > +        int r, ret =3D -1, i;
> > > +
> > > +        for (i =3D 0; i < mux->be_cnt; i++) {
> > > +                r =3D qemu_chr_fe_write_all(&mux->chrs[i], buf, len)=
;
> > > +                ret =3D ret < 0 ? r : MAX(r, ret);
> > > +        }
> > > +
> > > +        return ret;
> > > +}
> > > +
> > >  /* Called with chr_write_lock held.  */
> > >  static int mux_chr_write(Chardev *chr, const uint8_t *buf, int len)
> > >  {
> > >      MuxChardev *d =3D MUX_CHARDEV(chr);
> > >      int ret;
> > >      if (!d->timestamps) {
> > > -        ret =3D qemu_chr_fe_write(&d->chr, buf, len);
> > > +        ret =3D mux_chr_fe_write(d, buf, len);
> > >      } else {
> > >          int i;
> > >
> > > @@ -71,11 +98,11 @@ static int mux_chr_write(Chardev *chr, const
> uint8_t *buf, int len)
> > >                           (int)(ti % 1000));
> > >                  /* XXX this blocks entire thread. Rewrite to use
> > >                   * qemu_chr_fe_write and background I/O callbacks */
> > > -                qemu_chr_fe_write_all(&d->chr,
> > > +                mux_chr_fe_write_all(d,
> > >                                        (uint8_t *)buf1, strlen(buf1))=
;
> > >                  d->linestart =3D 0;
> > >              }
> > > -            ret +=3D qemu_chr_fe_write(&d->chr, buf + i, 1);
> > > +            ret +=3D mux_chr_fe_write(d, buf + i, 1);
> > >              if (buf[i] =3D=3D '\n') {
> > >                  d->linestart =3D 1;
> > >              }
> > > @@ -168,9 +195,9 @@ static int mux_proc_byte(Chardev *chr, MuxChardev
> *d, int ch)
> > >              qemu_chr_be_event(chr, CHR_EVENT_BREAK);
> > >              break;
> > >          case 'c':
> > > -            assert(d->mux_cnt > 0); /* handler registered with first
> fe */
> > > +            assert(d->fe_cnt > 0); /* handler registered with first
> fe */
> > >              /* Switch to the next registered device */
> > > -            mux_set_focus(chr, (d->focus + 1) % d->mux_cnt);
> > > +            mux_set_focus(chr, (d->focus + 1) % d->fe_cnt);
> > >              break;
> > >          case 't':
> > >              d->timestamps =3D !d->timestamps;
> > > @@ -248,8 +275,8 @@ void mux_chr_send_all_event(Chardev *chr,
> QEMUChrEvent event)
> > >          return;
> > >      }
> > >
> > > -    /* Send the event to all registered listeners */
> > > -    for (i =3D 0; i < d->mux_cnt; i++) {
> > > +    /* Send the event to all registered frontend listeners */
> > > +    for (i =3D 0; i < d->fe_cnt; i++) {
> > >          mux_chr_send_event(d, i, event);
> > >      }
> > >  }
> > > @@ -262,8 +289,16 @@ static void mux_chr_event(void *opaque,
> QEMUChrEvent event)
> > >  static GSource *mux_chr_add_watch(Chardev *s, GIOCondition cond)
> > >  {
> > >      MuxChardev *d =3D MUX_CHARDEV(s);
> > > -    Chardev *chr =3D qemu_chr_fe_get_driver(&d->chr);
> > > -    ChardevClass *cc =3D CHARDEV_GET_CLASS(chr);
> > > +    Chardev *chr;
> > > +    ChardevClass *cc;
> > > +
> > > +    if (d->be_cnt > 1) {
> > > +            /* TODO: multiple backends have to be combined on a
> single watch */
> >
> > I think this must be done, otherwise there is a severe limitation.
>
> Ok.
>
> >
> > > +            return NULL;
> > > +    }
> > > +
> > > +    chr =3D qemu_chr_fe_get_driver(&d->chrs[0]);
> > > +    cc =3D CHARDEV_GET_CLASS(chr);
> > >
> > >      if (!cc->chr_add_watch) {
> > >          return NULL;
> > > @@ -277,27 +312,32 @@ static void char_mux_finalize(Object *obj)
> > >      MuxChardev *d =3D MUX_CHARDEV(obj);
> > >      int i;
> > >
> > > -    for (i =3D 0; i < d->mux_cnt; i++) {
> > > +    for (i =3D 0; i < d->fe_cnt; i++) {
> > >          CharBackend *be =3D d->backends[i];
> > >          if (be) {
> > >              be->chr =3D NULL;
> > >          }
> > >      }
> > > -    qemu_chr_fe_deinit(&d->chr, false);
> > > +    for (i =3D 0; i < d->be_cnt; i++) {
> > > +        qemu_chr_fe_deinit(&d->chrs[i], false);
> > > +    }
> > >  }
> > >
> > >  static void mux_chr_update_read_handlers(Chardev *chr)
> > >  {
> > >      MuxChardev *d =3D MUX_CHARDEV(chr);
> > > +    int i;
> > >
> > > -    /* Fix up the real driver with mux routines */
> > > -    qemu_chr_fe_set_handlers_full(&d->chr,
> > > -                                  mux_chr_can_read,
> > > -                                  mux_chr_read,
> > > -                                  mux_chr_event,
> > > -                                  NULL,
> > > -                                  chr,
> > > -                                  chr->gcontext, true, false);
> > > +    for (i =3D 0; i < d->be_cnt; i++) {
> > > +        /* Fix up the real driver with mux routines */
> > > +        qemu_chr_fe_set_handlers_full(&d->chrs[i],
> > > +                                      mux_chr_can_read,
> > > +                                      mux_chr_read,
> > > +                                      mux_chr_event,
> > > +                                      NULL,
> > > +                                      chr,
> > > +                                      chr->gcontext, true, false);
> > > +    }
> > >  }
> > >
> > >  void mux_set_focus(Chardev *chr, int focus)
> > > @@ -305,7 +345,7 @@ void mux_set_focus(Chardev *chr, int focus)
> > >      MuxChardev *d =3D MUX_CHARDEV(chr);
> > >
> > >      assert(focus >=3D 0);
> > > -    assert(focus < d->mux_cnt);
> > > +    assert(focus < d->fe_cnt);
> > >
> > >      if (d->focus !=3D -1) {
> > >          mux_chr_send_event(d, d->focus, CHR_EVENT_MUX_OUT);
> > > @@ -324,19 +364,49 @@ static void qemu_chr_open_mux(Chardev *chr,
> > >      ChardevMux *mux =3D backend->u.mux.data;
> > >      Chardev *drv;
> > >      MuxChardev *d =3D MUX_CHARDEV(chr);
> > > -
> > > -    drv =3D qemu_chr_find(mux->chardev);
> > > -    if (drv =3D=3D NULL) {
> > > -        error_setg(errp, "mux: base chardev %s not found",
> mux->chardev);
> > > +    const char *offset, *chardevs;
> > > +    int length, i;
> > > +
> > > +    if (d->fe_cnt > 1) {
> > > +        error_setg(errp,
> > > +                   "multiplexed chardev '%s' is already used "
> > > +                   "for frontend multiplexing",
> > > +                   chr->label);
> > >          return;
> > >      }
> > >
> > > +    chardevs =3D mux->chardev;
> > > +    for (i =3D 0; i < MAX_MUX; i++) {
> > > +        char *chardev;
> > > +
> > > +        offset =3D qemu_strchrnul(chardevs, ',');
> > > +        length =3D offset - chardevs;
> > > +        if (!length) {
> > > +            break;
> > > +        }
> > > +        chardev =3D strndupa(chardevs, length);
> > > +        chardevs +=3D length + 1;
> > > +        drv =3D qemu_chr_find(chardev);
> > > +        if (drv =3D=3D NULL) {
> > > +            error_setg(errp, "mux: base chardev %s not found",
> chardev);
> > > +            goto deinit_on_error;
> > > +        }
> > > +        qemu_chr_fe_init(&d->chrs[i], drv, errp);
> > > +        d->be_cnt +=3D 1;
> > > +    }
> > >      d->focus =3D -1;
> > >      /* only default to opened state if we've realized the initial
> > >       * set of muxes
> > >       */
> > >      *be_opened =3D muxes_opened;
> > > -    qemu_chr_fe_init(&d->chr, drv, errp);
> > > +
> > > +    return;
> > > +
> > > +deinit_on_error:
> > > +    for (i =3D 0; i < d->be_cnt; i++) {
> > > +        qemu_chr_fe_deinit(&d->chrs[i], false);
> > > +    }
> > > +    d->be_cnt =3D 0;
> > >  }
> > >
> > >  static void qemu_chr_parse_mux(QemuOpts *opts, ChardevBackend
> *backend,
> > > diff --git a/chardev/char.c b/chardev/char.c
> > > index ba847b6e9eff..2643c79e5749 100644
> > > --- a/chardev/char.c
> > > +++ b/chardev/char.c
> > > @@ -333,7 +333,7 @@ static bool qemu_chr_is_busy(Chardev *s)
> > >  {
> > >      if (CHARDEV_IS_MUX(s)) {
> > >          MuxChardev *d =3D MUX_CHARDEV(s);
> > > -        return d->mux_cnt >=3D 0;
> > > +        return d->fe_cnt >=3D 0;
> > >      } else {
> > >          return s->be !=3D NULL;
> > >      }
> > > diff --git a/chardev/chardev-internal.h b/chardev/chardev-internal.h
> > > index 4e03af31476c..72c2e4da7552 100644
> > > --- a/chardev/chardev-internal.h
> > > +++ b/chardev/chardev-internal.h
> > > @@ -35,10 +35,13 @@
> > >
> > >  struct MuxChardev {
> > >      Chardev parent;
> > > +    /* Linked frontends */
> > >      CharBackend *backends[MAX_MUX];
> > > -    CharBackend chr;
> > > +    /* Linked backends */
> > > +    CharBackend chrs[MAX_MUX];
> > >      int focus;
> > > -    int mux_cnt;
> > > +    int fe_cnt;
> > > +    int be_cnt;
> > >      int term_got_escape;
> > >      int max_size;
> > >      /* Intermediate input buffer catches escape sequences even if th=
e
> > > --
> > > 2.34.1
> > >
> >
> >
> > It would also require some tests and QAPI support.
>
> I will take a look at tests and will try to come up with some extension
> for backend multiplexing.
>
> Since the mux object API was not changed and the current change heavily
> relies on what is already in the code, do you think there should be any
> QAPI related change? In my understanding this should work out of the box
> (not tested though).
>
> --
> Roman
>
>

--=20
Marc-Andr=C3=A9 Lureau

--00000000000057aa220622629aa2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 17, 2024 at 6:17=E2=80=
=AFPM Roman Penyaev &lt;<a href=3D"mailto:r.peniaev@gmail.com">r.peniaev@gm=
ail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">Hi Marc-Andr=C3=A9,<br>
<br>
On Tue, Sep 17, 2024 at 2:31=E2=80=AFPM Marc-Andr=C3=A9 Lureau<br>
&lt;<a href=3D"mailto:marcandre.lureau@redhat.com" target=3D"_blank">marcan=
dre.lureau@redhat.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Hi Roman<br>
&gt;<br>
&gt; On Fri, Sep 13, 2024 at 8:37=E2=80=AFPM Roman Penyaev &lt;<a href=3D"m=
ailto:r.peniaev@gmail.com" target=3D"_blank">r.peniaev@gmail.com</a>&gt; wr=
ote:<br>
&gt; &gt;<br>
&gt; &gt; This patch implements multiplexing capability of several backend<=
br>
&gt; &gt; devices, which opens up an opportunity to use a single frontend<b=
r>
&gt; &gt; device on the guest, which can be manipulated from several<br>
&gt; &gt; backend devices.<br>
&gt; &gt;<br>
&gt; &gt; The idea of the change is trivial: keep list of backend devices<b=
r>
&gt; &gt; (up to 4), init them on demand and forward data buffer back and<b=
r>
&gt; &gt; forth.<br>
&gt; &gt;<br>
&gt; &gt; The following is QEMU command line example:<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0-chardev socket,path=3D/tmp/sock,server=3Don,wait=3Do=
ff,id=3Dsock0 \<br>
&gt; &gt;=C2=A0 =C2=A0-chardev vc,id=3Dvc0 \<br>
&gt; &gt;=C2=A0 =C2=A0-chardev mux,id=3Dmux0,chardev=3Dvc0,,sock0 \<br>
&gt; &gt;=C2=A0 =C2=A0-device virtconsole,chardev=3Dmux0 \<br>
&gt; &gt;=C2=A0 =C2=A0-vnc <a href=3D"http://0.0.0.0:0" rel=3D"noreferrer" =
target=3D"_blank">0.0.0.0:0</a><br>
&gt; &gt;<br>
&gt; &gt; Which creates 2 backend devices: text virtual console (`vc0`)<br>
&gt; &gt; and a socket (`sock0`) connected to the single virtio hvc<br>
&gt; &gt; console with the multiplexer (`mux0`) help. `vc0` renders<br>
&gt; &gt; text to an image, which can be shared over the VNC protocol.<br>
&gt; &gt; `sock0` is a socket backend which provides biderectional<br>
&gt; &gt; communication to the virtio hvc console.<br>
&gt;<br>
&gt; I think I would rather implement a new mux for this purpose, like<br>
&gt; &quot;mux-be&quot; perhaps?<br>
<br>
Do you mean a completely different implementation or just an alias<br>
for the cli needs? Because code of the backend multiplexing nicely fits<br>
current mux and I tried to avoid code duplication.<br></blockquote><div><br=
></div><div>It&#39;s not the same behaviour though, and discoverability/com=
patibility would be easier to handle. There is also various code in mux tha=
t isn&#39;t needed.</div><div><br></div><div>You can still factorize common=
 code, or have a common base class. Eventually, the two chardev can be from=
 the same file. I don&#39;t know if that makes sense. <br></div><div><br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt;<br>
&gt; &quot;mux&quot; has been a bit hidden (behind mux=3Don) for various re=
asons, and<br>
&gt; is probably not at production quality level.<br>
<br>
Well, indeed creating &quot;chardev mux&quot; is not described in the doc, =
but you<br>
can do this anyway :) Here I just followed the same pattern as we do for<br=
>
other devices: &quot;chardev NAME&quot;. Having a &quot;mux-be&quot; (or an=
y other) alias<br>
won&#39;t expose the default &quot;mux&quot;, so configurations can be sepa=
rated.<br>
Is that what you meant?<br></blockquote><div><br></div><div>yes, this would=
 help in general misconfiguration (although -chardev option handling has a =
lot to be desired)<br></div><div>=C2=A0<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">
<br>
Also, mux is used implicitly for various of configurations, this is<br>
described in the manual:<br>
<br>
=C2=A0 =C2=A0Note that some other command line options may implicitly creat=
e<br>
=C2=A0 =C2=A0multiplexed character backends; for instance -serial mon:stdio=
 creates<br>
=C2=A0 =C2=A0a multiplexed stdio backend connected to the serial port and t=
he QEMU<br>
=C2=A0 =C2=A0monitor, and -nographic also multiplexes the console and the<b=
r>
monitor to stdio.<br>
<br>
So it seems to me mux is used (tested) quite extensively.<br></blockquote><=
div><br></div><div>kinda, it&#39;s used by end-users who run qemu from the =
CLI. Probably less in production systems.<br></div><div>=C2=A0<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt;<br>
&gt; I am not sure how CLI should handle option arrays these days<br>
&gt; (especially with -chardev CLI not being json-friendly).<br>
<br>
By CLI do you mean the default QEMU command line interface?<br></blockquote=
><div><br></div><div>yes</div><div>=C2=A0<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">
The command line with arrays (double commas &quot;,,&quot;) I specified abo=
ve<br>
works fine. Can you suggest any other tool (or json formatting) you have<br=
>
in mind so I can verify?<br></blockquote><div><br></div><div>Indeed, this d=
ouble commas stuff is weird, I don&#39;t know that &quot;trick&quot;. Is it=
 used elsewhere and documented? I don&#39;t see a test in test-qemu-opts.c =
either.<br></div><div><br></div><div>There is another ongoing discussion ab=
out json support for -chardev: &quot;-chardev with a JSON argument&quot;.</=
div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt;<br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Roman Penyaev &lt;<a href=3D"mailto:r.peniaev@gmai=
l.com" target=3D"_blank">r.peniaev@gmail.com</a>&gt;<br>
&gt; &gt; Cc: &quot;Marc-Andr=C3=A9 Lureau&quot; &lt;<a href=3D"mailto:marc=
andre.lureau@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&=
gt;<br>
&gt; &gt; Cc: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" targ=
et=3D"_blank">pbonzini@redhat.com</a>&gt;<br>
&gt; &gt; Cc: <a href=3D"mailto:qemu-devel@nongnu.org" target=3D"_blank">qe=
mu-devel@nongnu.org</a><br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 chardev/char-fe.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0=
 14 +++--<br>
&gt; &gt;=C2=A0 chardev/char-mux.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 120 +=
++++++++++++++++++++++++++++--------<br>
&gt; &gt;=C2=A0 chardev/char.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A02 +-<br>
&gt; &gt;=C2=A0 chardev/chardev-internal.h |=C2=A0 =C2=A07 ++-<br>
&gt; &gt;=C2=A0 4 files changed, 111 insertions(+), 32 deletions(-)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/chardev/char-fe.c b/chardev/char-fe.c<br>
&gt; &gt; index b214ba3802b1..d1f67338084d 100644<br>
&gt; &gt; --- a/chardev/char-fe.c<br>
&gt; &gt; +++ b/chardev/char-fe.c<br>
&gt; &gt; @@ -197,16 +197,22 @@ bool qemu_chr_fe_init(CharBackend *b, Chard=
ev *s, Error **errp)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (CHARDEV_IS_MUX(s)) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MuxChardev *d =3D=
 MUX_CHARDEV(s);<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (d-&gt;mux_cnt &gt;=
=3D MAX_MUX) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (d-&gt;fe_cnt &gt;=
=3D MAX_MUX) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err=
or_setg(errp,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;too many uses of multiplexed ch=
ardev &#39;%s&#39;&quot;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot; (maximum is &quot; stringify(M=
AX_MUX) &quot;)&quot;,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;label);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret=
urn false;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; -<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 d-&gt;backends[d-&gt;m=
ux_cnt] =3D b;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tag =3D d-&gt;mux_cnt+=
+;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (d-&gt;fe_cnt &gt; =
0 &amp;&amp; d-&gt;be_cnt &gt; 1) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_se=
tg(errp,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;multiplexed chardev &#39;%s&#39; is=
 already used &quot;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;for backend multiplexing&quot;,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;label);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return f=
alse;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 d-&gt;backends[d-&gt;f=
e_cnt] =3D b;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tag =3D d-&gt;fe_cnt++=
;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (s-&gt;be) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, =
&quot;chardev &#39;%s&#39; is already in use&quot;, s-&gt;label);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt; &gt; diff --git a/chardev/char-mux.c b/chardev/char-mux.c<br>
&gt; &gt; index ee2d47b20d9b..82f728b5caf8 100644<br>
&gt; &gt; --- a/chardev/char-mux.c<br>
&gt; &gt; +++ b/chardev/char-mux.c<br>
&gt; &gt; @@ -26,6 +26,7 @@<br>
&gt; &gt;=C2=A0 #include &quot;qapi/error.h&quot;<br>
&gt; &gt;=C2=A0 #include &quot;qemu/module.h&quot;<br>
&gt; &gt;=C2=A0 #include &quot;qemu/option.h&quot;<br>
&gt; &gt; +#include &quot;qemu/cutils.h&quot;<br>
&gt; &gt;=C2=A0 #include &quot;chardev/char.h&quot;<br>
&gt; &gt;=C2=A0 #include &quot;sysemu/block-backend.h&quot;<br>
&gt; &gt;=C2=A0 #include &quot;qapi/qapi-commands-control.h&quot;<br>
&gt; &gt; @@ -40,13 +41,39 @@<br>
&gt; &gt;=C2=A0 =C2=A0*/<br>
&gt; &gt;=C2=A0 static bool muxes_opened =3D true;<br>
&gt; &gt;<br>
&gt; &gt; +/* Write to all backends=C2=A0 */<br>
&gt; &gt; +static int mux_chr_fe_write(MuxChardev *mux, const uint8_t *buf,=
 int len)<br>
&gt; &gt; +{<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int r, ret =3D -1, i;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; mux-&gt;be_cnt;=
 i++) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D qe=
mu_chr_fe_write(&amp;mux-&gt;chrs[i], buf, len);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D =
ret &lt; 0 ? r : MAX(r, ret);<br>
&gt;<br>
&gt; I think it should be conservative and fail early if one of the backend=
<br>
&gt; fails. Also if different frontends can write different amounts, there<=
br>
&gt; needs to be some buffering... or it should always use write_all()<br>
&gt; which has also a shortcoming since it blocks the thread.<br>
<br>
Yes, early fail and buffers make sense.<br>
<br>
&gt;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
&gt; &gt; +}<br>
&gt; &gt; +<br>
&gt; &gt; +/* Write to all backends=C2=A0 */<br>
&gt; &gt; +static int mux_chr_fe_write_all(MuxChardev *mux, const uint8_t *=
buf, int len)<br>
&gt; &gt; +{<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int r, ret =3D -1, i;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; mux-&gt;be_cnt;=
 i++) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D qe=
mu_chr_fe_write_all(&amp;mux-&gt;chrs[i], buf, len);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D =
ret &lt; 0 ? r : MAX(r, ret);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
&gt; &gt; +}<br>
&gt; &gt; +<br>
&gt; &gt;=C2=A0 /* Called with chr_write_lock held.=C2=A0 */<br>
&gt; &gt;=C2=A0 static int mux_chr_write(Chardev *chr, const uint8_t *buf, =
int len)<br>
&gt; &gt;=C2=A0 {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 MuxChardev *d =3D MUX_CHARDEV(chr);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 int ret;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 if (!d-&gt;timestamps) {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D qemu_chr_fe_write(&amp;d-&gt=
;chr, buf, len);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D mux_chr_fe_write(d, buf, len=
);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int i;<br>
&gt; &gt;<br>
&gt; &gt; @@ -71,11 +98,11 @@ static int mux_chr_write(Chardev *chr, const =
uint8_t *buf, int len)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(int)(ti % 1000));<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* =
XXX this blocks entire thread. Rewrite to use<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0* qemu_chr_fe_write and background I/O callbacks */<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_chr=
_fe_write_all(&amp;d-&gt;chr,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mux_chr_=
fe_write_all(d,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (=
uint8_t *)buf1, strlen(buf1));<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 d-&=
gt;linestart =3D 0;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret +=3D qemu_chr_fe_w=
rite(&amp;d-&gt;chr, buf + i, 1);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret +=3D mux_chr_fe_wr=
ite(d, buf + i, 1);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (buf[i] =3D=3D=
 &#39;\n&#39;) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 d-&=
gt;linestart =3D 1;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; @@ -168,9 +195,9 @@ static int mux_proc_byte(Chardev *chr, MuxCha=
rdev *d, int ch)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_chr_be_event=
(chr, CHR_EVENT_BREAK);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case &#39;c&#39;:<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(d-&gt;mux_cnt &=
gt; 0); /* handler registered with first fe */<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 assert(d-&gt;fe_cnt &g=
t; 0); /* handler registered with first fe */<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Switch to the =
next registered device */<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mux_set_focus(chr, (d-=
&gt;focus + 1) % d-&gt;mux_cnt);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mux_set_focus(chr, (d-=
&gt;focus + 1) % d-&gt;fe_cnt);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case &#39;t&#39;:<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 d-&gt;timestamps =
=3D !d-&gt;timestamps;<br>
&gt; &gt; @@ -248,8 +275,8 @@ void mux_chr_send_all_event(Chardev *chr, QEM=
UChrEvent event)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 /* Send the event to all registered listeners */<b=
r>
&gt; &gt; -=C2=A0 =C2=A0 for (i =3D 0; i &lt; d-&gt;mux_cnt; i++) {<br>
&gt; &gt; +=C2=A0 =C2=A0 /* Send the event to all registered frontend liste=
ners */<br>
&gt; &gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; d-&gt;fe_cnt; i++) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mux_chr_send_event(d, i, event)=
;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;=C2=A0 }<br>
&gt; &gt; @@ -262,8 +289,16 @@ static void mux_chr_event(void *opaque, QEMU=
ChrEvent event)<br>
&gt; &gt;=C2=A0 static GSource *mux_chr_add_watch(Chardev *s, GIOCondition =
cond)<br>
&gt; &gt;=C2=A0 {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 MuxChardev *d =3D MUX_CHARDEV(s);<br>
&gt; &gt; -=C2=A0 =C2=A0 Chardev *chr =3D qemu_chr_fe_get_driver(&amp;d-&gt=
;chr);<br>
&gt; &gt; -=C2=A0 =C2=A0 ChardevClass *cc =3D CHARDEV_GET_CLASS(chr);<br>
&gt; &gt; +=C2=A0 =C2=A0 Chardev *chr;<br>
&gt; &gt; +=C2=A0 =C2=A0 ChardevClass *cc;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 if (d-&gt;be_cnt &gt; 1) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* TODO: multiple back=
ends have to be combined on a single watch */<br>
&gt;<br>
&gt; I think this must be done, otherwise there is a severe limitation.<br>
<br>
Ok.<br>
<br>
&gt;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
&gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 chr =3D qemu_chr_fe_get_driver(&amp;d-&gt;chrs[0])=
;<br>
&gt; &gt; +=C2=A0 =C2=A0 cc =3D CHARDEV_GET_CLASS(chr);<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 if (!cc-&gt;chr_add_watch) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
&gt; &gt; @@ -277,27 +312,32 @@ static void char_mux_finalize(Object *obj)<=
br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 MuxChardev *d =3D MUX_CHARDEV(obj);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 int i;<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 for (i =3D 0; i &lt; d-&gt;mux_cnt; i++) {<br>
&gt; &gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; d-&gt;fe_cnt; i++) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CharBackend *be =3D d-&gt;backe=
nds[i];<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (be) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 be-&gt;chr =3D NU=
LL;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; -=C2=A0 =C2=A0 qemu_chr_fe_deinit(&amp;d-&gt;chr, false);<br>
&gt; &gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; d-&gt;be_cnt; i++) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_chr_fe_deinit(&amp;d-&gt;chrs[i=
], false);<br>
&gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt;=C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 static void mux_chr_update_read_handlers(Chardev *chr)<br>
&gt; &gt;=C2=A0 {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 MuxChardev *d =3D MUX_CHARDEV(chr);<br>
&gt; &gt; +=C2=A0 =C2=A0 int i;<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 /* Fix up the real driver with mux routines */<br>
&gt; &gt; -=C2=A0 =C2=A0 qemu_chr_fe_set_handlers_full(&amp;d-&gt;chr,<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mux_chr_can_read,<b=
r>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mux_chr_read,<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mux_chr_event,<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL,<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 chr,<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 chr-&gt;gcontext, t=
rue, false);<br>
&gt; &gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; d-&gt;be_cnt; i++) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Fix up the real driver with mux r=
outines */<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_chr_fe_set_handlers_full(&amp;d=
-&gt;chrs[i],<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mux_c=
hr_can_read,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mux_c=
hr_read,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mux_c=
hr_event,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL,=
<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 chr,<=
br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 chr-&=
gt;gcontext, true, false);<br>
&gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt;=C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 void mux_set_focus(Chardev *chr, int focus)<br>
&gt; &gt; @@ -305,7 +345,7 @@ void mux_set_focus(Chardev *chr, int focus)<b=
r>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 MuxChardev *d =3D MUX_CHARDEV(chr);<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 assert(focus &gt;=3D 0);<br>
&gt; &gt; -=C2=A0 =C2=A0 assert(focus &lt; d-&gt;mux_cnt);<br>
&gt; &gt; +=C2=A0 =C2=A0 assert(focus &lt; d-&gt;fe_cnt);<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 if (d-&gt;focus !=3D -1) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mux_chr_send_event(d, d-&gt;foc=
us, CHR_EVENT_MUX_OUT);<br>
&gt; &gt; @@ -324,19 +364,49 @@ static void qemu_chr_open_mux(Chardev *chr,=
<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 ChardevMux *mux =3D backend-&gt;u.mux.data;<b=
r>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 Chardev *drv;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 MuxChardev *d =3D MUX_CHARDEV(chr);<br>
&gt; &gt; -<br>
&gt; &gt; -=C2=A0 =C2=A0 drv =3D qemu_chr_find(mux-&gt;chardev);<br>
&gt; &gt; -=C2=A0 =C2=A0 if (drv =3D=3D NULL) {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;mux: base cha=
rdev %s not found&quot;, mux-&gt;chardev);<br>
&gt; &gt; +=C2=A0 =C2=A0 const char *offset, *chardevs;<br>
&gt; &gt; +=C2=A0 =C2=A0 int length, i;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 if (d-&gt;fe_cnt &gt; 1) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0&quot;multiplexed chardev &#39;%s&#39; is already used &quot;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0&quot;for frontend multiplexing&quot;,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0chr-&gt;label);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt; +=C2=A0 =C2=A0 chardevs =3D mux-&gt;chardev;<br>
&gt; &gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; MAX_MUX; i++) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 char *chardev;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 offset =3D qemu_strchrnul(chardevs, =
&#39;,&#39;);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 length =3D offset - chardevs;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!length) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 chardev =3D strndupa(chardevs, lengt=
h);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 chardevs +=3D length + 1;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 drv =3D qemu_chr_find(chardev);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (drv =3D=3D NULL) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot=
;mux: base chardev %s not found&quot;, chardev);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto deinit_on_error;<=
br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_chr_fe_init(&amp;d-&gt;chrs[i],=
 drv, errp);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 d-&gt;be_cnt +=3D 1;<br>
&gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 d-&gt;focus =3D -1;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 /* only default to opened state if we&#39;ve =
realized the initial<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* set of muxes<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 *be_opened =3D muxes_opened;<br>
&gt; &gt; -=C2=A0 =C2=A0 qemu_chr_fe_init(&amp;d-&gt;chr, drv, errp);<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 return;<br>
&gt; &gt; +<br>
&gt; &gt; +deinit_on_error:<br>
&gt; &gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; d-&gt;be_cnt; i++) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_chr_fe_deinit(&amp;d-&gt;chrs[i=
], false);<br>
&gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt; +=C2=A0 =C2=A0 d-&gt;be_cnt =3D 0;<br>
&gt; &gt;=C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 static void qemu_chr_parse_mux(QemuOpts *opts, ChardevBacke=
nd *backend,<br>
&gt; &gt; diff --git a/chardev/char.c b/chardev/char.c<br>
&gt; &gt; index ba847b6e9eff..2643c79e5749 100644<br>
&gt; &gt; --- a/chardev/char.c<br>
&gt; &gt; +++ b/chardev/char.c<br>
&gt; &gt; @@ -333,7 +333,7 @@ static bool qemu_chr_is_busy(Chardev *s)<br>
&gt; &gt;=C2=A0 {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 if (CHARDEV_IS_MUX(s)) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MuxChardev *d =3D MUX_CHARDEV(s=
);<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return d-&gt;mux_cnt &gt;=3D 0;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return d-&gt;fe_cnt &gt;=3D 0;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return s-&gt;be !=3D NULL;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; diff --git a/chardev/chardev-internal.h b/chardev/chardev-interna=
l.h<br>
&gt; &gt; index 4e03af31476c..72c2e4da7552 100644<br>
&gt; &gt; --- a/chardev/chardev-internal.h<br>
&gt; &gt; +++ b/chardev/chardev-internal.h<br>
&gt; &gt; @@ -35,10 +35,13 @@<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 struct MuxChardev {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 Chardev parent;<br>
&gt; &gt; +=C2=A0 =C2=A0 /* Linked frontends */<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 CharBackend *backends[MAX_MUX];<br>
&gt; &gt; -=C2=A0 =C2=A0 CharBackend chr;<br>
&gt; &gt; +=C2=A0 =C2=A0 /* Linked backends */<br>
&gt; &gt; +=C2=A0 =C2=A0 CharBackend chrs[MAX_MUX];<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 int focus;<br>
&gt; &gt; -=C2=A0 =C2=A0 int mux_cnt;<br>
&gt; &gt; +=C2=A0 =C2=A0 int fe_cnt;<br>
&gt; &gt; +=C2=A0 =C2=A0 int be_cnt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 int term_got_escape;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 int max_size;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 /* Intermediate input buffer catches escape s=
equences even if the<br>
&gt; &gt; --<br>
&gt; &gt; 2.34.1<br>
&gt; &gt;<br>
&gt;<br>
&gt;<br>
&gt; It would also require some tests and QAPI support.<br>
<br>
I will take a look at tests and will try to come up with some extension<br>
for backend multiplexing.<br>
<br>
Since the mux object API was not changed and the current change heavily<br>
relies on what is already in the code, do you think there should be any<br>
QAPI related change? In my understanding this should work out of the box<br=
>
(not tested though).<br>
<br>
--<br>
Roman<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--00000000000057aa220622629aa2--

