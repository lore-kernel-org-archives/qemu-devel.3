Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B14AC3601A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 14:16:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqYze-0007mS-Q0; Tue, 17 Sep 2024 10:15:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1sqYzO-0007WT-Vo
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 10:15:47 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1sqYzM-0008DG-F0
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 10:15:34 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2f762de00e5so64418831fa.3
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2024 07:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726582530; x=1727187330; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NxegDbsyReSANkjf8vd4OSP79GIazHPWP/0FrSyx+Zo=;
 b=CLy+LoHhqTCvwVfDoWX9EkRm8UB/WGox8zKtf87h2pXYFWz7O1vDiwduMuF+QAZu6L
 UXaGqxLwwq5rke0AqbjLCBr8hrfzW0Z5nOb83FheJo7dqlAQHXi1WCsgplp99Eyzm3wJ
 KjW4yeKWttFTOLFHB0Mv8rAW3r88aDG7OxPOr594nOFKonwt22HWGMNzrgtsEjbeNCYi
 ruK7grpvd7Evo58ZaVo3Z1bW3DN4gwnxJpLMX8a8IqSU4bTjcqBNVa/EO1tfikYBd1Km
 NtKOl6Rnkd4dW3YYfuNwfGeohtaKnbizGWgA7+m0ZlO0WO6vjQUOKjiGPGpWtHGuqYZZ
 wohg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726582530; x=1727187330;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NxegDbsyReSANkjf8vd4OSP79GIazHPWP/0FrSyx+Zo=;
 b=eAvThV2xxPfzj12vfLar7H2uc2981PK4b7ScjT3swnEguWT03FNOK0QN/uahHtTUrP
 Pb0cU8DZxjWe9nf1Ryw4Um8sUP3IGUTvc0Ducafl16CbZV4H1XooG6JMgIktq0F6yXqZ
 eui94ZqeFbJUEpUs35x/XNgQOJI+0edgakfxCFnqpzFsu75Pd3Y8pXv40rcCm5+Nwz1H
 zvo17JjXn+UHMpqnLssZIEqSEdZxWs5WZvGxuLPB8max2+UcCu99fWCcMuzBhu7tQtQM
 06M2ZGQysKxfWqVk1droYmmWuEksnRtvHvQh+iAocL91Tao7Z5FcDe1QNWvzc2RqDHII
 0OOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvoYxfK5fNZHtm4A/V7J54ny2Ao5+wCzgmRTL+x4YGsyt7tCtpn6C3gmqjcLgALD2/FkJZXiz5XgNg@nongnu.org
X-Gm-Message-State: AOJu0Yz3KkkZsQP0sbY6UUdXKmyx00NHPXsrZskvsVSU8T1R4ewLr7Ub
 0SmCjWiY73AscK89x4ZLK+y+K48XXN5HqHkrz/0GnjOHAfFcB0KuFVE+/x+VbHg/LKg3wtPZP0g
 2dLjDjUwJH2z0ez4SaJGAgmkz7gE=
X-Google-Smtp-Source: AGHT+IEzfRiSCNXW4Pmt69dJCbfb8VFtucWj94yv+s+Rh0gPpRwrrvWrBnx4gVrrtX9eN2l51xPsBt2YcW47GVt5Uis=
X-Received: by 2002:a05:651c:1541:b0:2ef:2638:48cd with SMTP id
 38308e7fff4ca-2f787f44d33mr110383741fa.30.1726582529453; Tue, 17 Sep 2024
 07:15:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240913163636.253949-1-r.peniaev@gmail.com>
 <20240913163636.253949-2-r.peniaev@gmail.com>
 <CAMxuvawD8QrsjJ9xiE9KDa=BTj8urRcCcN5YasiE3m-R7xEcuQ@mail.gmail.com>
In-Reply-To: <CAMxuvawD8QrsjJ9xiE9KDa=BTj8urRcCcN5YasiE3m-R7xEcuQ@mail.gmail.com>
From: Roman Penyaev <r.peniaev@gmail.com>
Date: Tue, 17 Sep 2024 16:15:18 +0200
Message-ID: <CACZ9PQU2X0T+FX6QV+6O8MhBLuJkLut41rtjb5Lp5z+3Sjm6Ww@mail.gmail.com>
Subject: Re: [PATCH 1/2] chardev: implement backend chardev multiplexing
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=r.peniaev@gmail.com; helo=mail-lj1-x230.google.com
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

On Tue, Sep 17, 2024 at 2:31=E2=80=AFPM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Hi Roman
>
> On Fri, Sep 13, 2024 at 8:37=E2=80=AFPM Roman Penyaev <r.peniaev@gmail.co=
m> wrote:
> >
> > This patch implements multiplexing capability of several backend
> > devices, which opens up an opportunity to use a single frontend
> > device on the guest, which can be manipulated from several
> > backend devices.
> >
> > The idea of the change is trivial: keep list of backend devices
> > (up to 4), init them on demand and forward data buffer back and
> > forth.
> >
> > The following is QEMU command line example:
> >
> >   -chardev socket,path=3D/tmp/sock,server=3Don,wait=3Doff,id=3Dsock0 \
> >   -chardev vc,id=3Dvc0 \
> >   -chardev mux,id=3Dmux0,chardev=3Dvc0,,sock0 \
> >   -device virtconsole,chardev=3Dmux0 \
> >   -vnc 0.0.0.0:0
> >
> > Which creates 2 backend devices: text virtual console (`vc0`)
> > and a socket (`sock0`) connected to the single virtio hvc
> > console with the multiplexer (`mux0`) help. `vc0` renders
> > text to an image, which can be shared over the VNC protocol.
> > `sock0` is a socket backend which provides biderectional
> > communication to the virtio hvc console.
>
> I think I would rather implement a new mux for this purpose, like
> "mux-be" perhaps?

Do you mean a completely different implementation or just an alias
for the cli needs? Because code of the backend multiplexing nicely fits
current mux and I tried to avoid code duplication.

>
> "mux" has been a bit hidden (behind mux=3Don) for various reasons, and
> is probably not at production quality level.

Well, indeed creating "chardev mux" is not described in the doc, but you
can do this anyway :) Here I just followed the same pattern as we do for
other devices: "chardev NAME". Having a "mux-be" (or any other) alias
won't expose the default "mux", so configurations can be separated.
Is that what you meant?

Also, mux is used implicitly for various of configurations, this is
described in the manual:

   Note that some other command line options may implicitly create
   multiplexed character backends; for instance -serial mon:stdio creates
   a multiplexed stdio backend connected to the serial port and the QEMU
   monitor, and -nographic also multiplexes the console and the
monitor to stdio.

So it seems to me mux is used (tested) quite extensively.

>
> I am not sure how CLI should handle option arrays these days
> (especially with -chardev CLI not being json-friendly).

By CLI do you mean the default QEMU command line interface?
The command line with arrays (double commas ",,") I specified above
works fine. Can you suggest any other tool (or json formatting) you have
in mind so I can verify?

>
> >
> > Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
> > Cc: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: qemu-devel@nongnu.org
> > ---
> >  chardev/char-fe.c          |  14 +++--
> >  chardev/char-mux.c         | 120 +++++++++++++++++++++++++++++--------
> >  chardev/char.c             |   2 +-
> >  chardev/chardev-internal.h |   7 ++-
> >  4 files changed, 111 insertions(+), 32 deletions(-)
> >
> > diff --git a/chardev/char-fe.c b/chardev/char-fe.c
> > index b214ba3802b1..d1f67338084d 100644
> > --- a/chardev/char-fe.c
> > +++ b/chardev/char-fe.c
> > @@ -197,16 +197,22 @@ bool qemu_chr_fe_init(CharBackend *b, Chardev *s,=
 Error **errp)
> >          if (CHARDEV_IS_MUX(s)) {
> >              MuxChardev *d =3D MUX_CHARDEV(s);
> >
> > -            if (d->mux_cnt >=3D MAX_MUX) {
> > +            if (d->fe_cnt >=3D MAX_MUX) {
> >                  error_setg(errp,
> >                             "too many uses of multiplexed chardev '%s'"
> >                             " (maximum is " stringify(MAX_MUX) ")",
> >                             s->label);
> >                  return false;
> >              }
> > -
> > -            d->backends[d->mux_cnt] =3D b;
> > -            tag =3D d->mux_cnt++;
> > +            if (d->fe_cnt > 0 && d->be_cnt > 1) {
> > +                error_setg(errp,
> > +                           "multiplexed chardev '%s' is already used "
> > +                           "for backend multiplexing",
> > +                           s->label);
> > +                return false;
> > +            }
> > +            d->backends[d->fe_cnt] =3D b;
> > +            tag =3D d->fe_cnt++;
> >          } else if (s->be) {
> >              error_setg(errp, "chardev '%s' is already in use", s->labe=
l);
> >              return false;
> > diff --git a/chardev/char-mux.c b/chardev/char-mux.c
> > index ee2d47b20d9b..82f728b5caf8 100644
> > --- a/chardev/char-mux.c
> > +++ b/chardev/char-mux.c
> > @@ -26,6 +26,7 @@
> >  #include "qapi/error.h"
> >  #include "qemu/module.h"
> >  #include "qemu/option.h"
> > +#include "qemu/cutils.h"
> >  #include "chardev/char.h"
> >  #include "sysemu/block-backend.h"
> >  #include "qapi/qapi-commands-control.h"
> > @@ -40,13 +41,39 @@
> >   */
> >  static bool muxes_opened =3D true;
> >
> > +/* Write to all backends  */
> > +static int mux_chr_fe_write(MuxChardev *mux, const uint8_t *buf, int l=
en)
> > +{
> > +        int r, ret =3D -1, i;
> > +
> > +        for (i =3D 0; i < mux->be_cnt; i++) {
> > +                r =3D qemu_chr_fe_write(&mux->chrs[i], buf, len);
> > +                ret =3D ret < 0 ? r : MAX(r, ret);
>
> I think it should be conservative and fail early if one of the backend
> fails. Also if different frontends can write different amounts, there
> needs to be some buffering... or it should always use write_all()
> which has also a shortcoming since it blocks the thread.

Yes, early fail and buffers make sense.

>
> > +        }
> > +
> > +        return ret;
> > +}
> > +
> > +/* Write to all backends  */
> > +static int mux_chr_fe_write_all(MuxChardev *mux, const uint8_t *buf, i=
nt len)
> > +{
> > +        int r, ret =3D -1, i;
> > +
> > +        for (i =3D 0; i < mux->be_cnt; i++) {
> > +                r =3D qemu_chr_fe_write_all(&mux->chrs[i], buf, len);
> > +                ret =3D ret < 0 ? r : MAX(r, ret);
> > +        }
> > +
> > +        return ret;
> > +}
> > +
> >  /* Called with chr_write_lock held.  */
> >  static int mux_chr_write(Chardev *chr, const uint8_t *buf, int len)
> >  {
> >      MuxChardev *d =3D MUX_CHARDEV(chr);
> >      int ret;
> >      if (!d->timestamps) {
> > -        ret =3D qemu_chr_fe_write(&d->chr, buf, len);
> > +        ret =3D mux_chr_fe_write(d, buf, len);
> >      } else {
> >          int i;
> >
> > @@ -71,11 +98,11 @@ static int mux_chr_write(Chardev *chr, const uint8_=
t *buf, int len)
> >                           (int)(ti % 1000));
> >                  /* XXX this blocks entire thread. Rewrite to use
> >                   * qemu_chr_fe_write and background I/O callbacks */
> > -                qemu_chr_fe_write_all(&d->chr,
> > +                mux_chr_fe_write_all(d,
> >                                        (uint8_t *)buf1, strlen(buf1));
> >                  d->linestart =3D 0;
> >              }
> > -            ret +=3D qemu_chr_fe_write(&d->chr, buf + i, 1);
> > +            ret +=3D mux_chr_fe_write(d, buf + i, 1);
> >              if (buf[i] =3D=3D '\n') {
> >                  d->linestart =3D 1;
> >              }
> > @@ -168,9 +195,9 @@ static int mux_proc_byte(Chardev *chr, MuxChardev *=
d, int ch)
> >              qemu_chr_be_event(chr, CHR_EVENT_BREAK);
> >              break;
> >          case 'c':
> > -            assert(d->mux_cnt > 0); /* handler registered with first f=
e */
> > +            assert(d->fe_cnt > 0); /* handler registered with first fe=
 */
> >              /* Switch to the next registered device */
> > -            mux_set_focus(chr, (d->focus + 1) % d->mux_cnt);
> > +            mux_set_focus(chr, (d->focus + 1) % d->fe_cnt);
> >              break;
> >          case 't':
> >              d->timestamps =3D !d->timestamps;
> > @@ -248,8 +275,8 @@ void mux_chr_send_all_event(Chardev *chr, QEMUChrEv=
ent event)
> >          return;
> >      }
> >
> > -    /* Send the event to all registered listeners */
> > -    for (i =3D 0; i < d->mux_cnt; i++) {
> > +    /* Send the event to all registered frontend listeners */
> > +    for (i =3D 0; i < d->fe_cnt; i++) {
> >          mux_chr_send_event(d, i, event);
> >      }
> >  }
> > @@ -262,8 +289,16 @@ static void mux_chr_event(void *opaque, QEMUChrEve=
nt event)
> >  static GSource *mux_chr_add_watch(Chardev *s, GIOCondition cond)
> >  {
> >      MuxChardev *d =3D MUX_CHARDEV(s);
> > -    Chardev *chr =3D qemu_chr_fe_get_driver(&d->chr);
> > -    ChardevClass *cc =3D CHARDEV_GET_CLASS(chr);
> > +    Chardev *chr;
> > +    ChardevClass *cc;
> > +
> > +    if (d->be_cnt > 1) {
> > +            /* TODO: multiple backends have to be combined on a single=
 watch */
>
> I think this must be done, otherwise there is a severe limitation.

Ok.

>
> > +            return NULL;
> > +    }
> > +
> > +    chr =3D qemu_chr_fe_get_driver(&d->chrs[0]);
> > +    cc =3D CHARDEV_GET_CLASS(chr);
> >
> >      if (!cc->chr_add_watch) {
> >          return NULL;
> > @@ -277,27 +312,32 @@ static void char_mux_finalize(Object *obj)
> >      MuxChardev *d =3D MUX_CHARDEV(obj);
> >      int i;
> >
> > -    for (i =3D 0; i < d->mux_cnt; i++) {
> > +    for (i =3D 0; i < d->fe_cnt; i++) {
> >          CharBackend *be =3D d->backends[i];
> >          if (be) {
> >              be->chr =3D NULL;
> >          }
> >      }
> > -    qemu_chr_fe_deinit(&d->chr, false);
> > +    for (i =3D 0; i < d->be_cnt; i++) {
> > +        qemu_chr_fe_deinit(&d->chrs[i], false);
> > +    }
> >  }
> >
> >  static void mux_chr_update_read_handlers(Chardev *chr)
> >  {
> >      MuxChardev *d =3D MUX_CHARDEV(chr);
> > +    int i;
> >
> > -    /* Fix up the real driver with mux routines */
> > -    qemu_chr_fe_set_handlers_full(&d->chr,
> > -                                  mux_chr_can_read,
> > -                                  mux_chr_read,
> > -                                  mux_chr_event,
> > -                                  NULL,
> > -                                  chr,
> > -                                  chr->gcontext, true, false);
> > +    for (i =3D 0; i < d->be_cnt; i++) {
> > +        /* Fix up the real driver with mux routines */
> > +        qemu_chr_fe_set_handlers_full(&d->chrs[i],
> > +                                      mux_chr_can_read,
> > +                                      mux_chr_read,
> > +                                      mux_chr_event,
> > +                                      NULL,
> > +                                      chr,
> > +                                      chr->gcontext, true, false);
> > +    }
> >  }
> >
> >  void mux_set_focus(Chardev *chr, int focus)
> > @@ -305,7 +345,7 @@ void mux_set_focus(Chardev *chr, int focus)
> >      MuxChardev *d =3D MUX_CHARDEV(chr);
> >
> >      assert(focus >=3D 0);
> > -    assert(focus < d->mux_cnt);
> > +    assert(focus < d->fe_cnt);
> >
> >      if (d->focus !=3D -1) {
> >          mux_chr_send_event(d, d->focus, CHR_EVENT_MUX_OUT);
> > @@ -324,19 +364,49 @@ static void qemu_chr_open_mux(Chardev *chr,
> >      ChardevMux *mux =3D backend->u.mux.data;
> >      Chardev *drv;
> >      MuxChardev *d =3D MUX_CHARDEV(chr);
> > -
> > -    drv =3D qemu_chr_find(mux->chardev);
> > -    if (drv =3D=3D NULL) {
> > -        error_setg(errp, "mux: base chardev %s not found", mux->charde=
v);
> > +    const char *offset, *chardevs;
> > +    int length, i;
> > +
> > +    if (d->fe_cnt > 1) {
> > +        error_setg(errp,
> > +                   "multiplexed chardev '%s' is already used "
> > +                   "for frontend multiplexing",
> > +                   chr->label);
> >          return;
> >      }
> >
> > +    chardevs =3D mux->chardev;
> > +    for (i =3D 0; i < MAX_MUX; i++) {
> > +        char *chardev;
> > +
> > +        offset =3D qemu_strchrnul(chardevs, ',');
> > +        length =3D offset - chardevs;
> > +        if (!length) {
> > +            break;
> > +        }
> > +        chardev =3D strndupa(chardevs, length);
> > +        chardevs +=3D length + 1;
> > +        drv =3D qemu_chr_find(chardev);
> > +        if (drv =3D=3D NULL) {
> > +            error_setg(errp, "mux: base chardev %s not found", chardev=
);
> > +            goto deinit_on_error;
> > +        }
> > +        qemu_chr_fe_init(&d->chrs[i], drv, errp);
> > +        d->be_cnt +=3D 1;
> > +    }
> >      d->focus =3D -1;
> >      /* only default to opened state if we've realized the initial
> >       * set of muxes
> >       */
> >      *be_opened =3D muxes_opened;
> > -    qemu_chr_fe_init(&d->chr, drv, errp);
> > +
> > +    return;
> > +
> > +deinit_on_error:
> > +    for (i =3D 0; i < d->be_cnt; i++) {
> > +        qemu_chr_fe_deinit(&d->chrs[i], false);
> > +    }
> > +    d->be_cnt =3D 0;
> >  }
> >
> >  static void qemu_chr_parse_mux(QemuOpts *opts, ChardevBackend *backend=
,
> > diff --git a/chardev/char.c b/chardev/char.c
> > index ba847b6e9eff..2643c79e5749 100644
> > --- a/chardev/char.c
> > +++ b/chardev/char.c
> > @@ -333,7 +333,7 @@ static bool qemu_chr_is_busy(Chardev *s)
> >  {
> >      if (CHARDEV_IS_MUX(s)) {
> >          MuxChardev *d =3D MUX_CHARDEV(s);
> > -        return d->mux_cnt >=3D 0;
> > +        return d->fe_cnt >=3D 0;
> >      } else {
> >          return s->be !=3D NULL;
> >      }
> > diff --git a/chardev/chardev-internal.h b/chardev/chardev-internal.h
> > index 4e03af31476c..72c2e4da7552 100644
> > --- a/chardev/chardev-internal.h
> > +++ b/chardev/chardev-internal.h
> > @@ -35,10 +35,13 @@
> >
> >  struct MuxChardev {
> >      Chardev parent;
> > +    /* Linked frontends */
> >      CharBackend *backends[MAX_MUX];
> > -    CharBackend chr;
> > +    /* Linked backends */
> > +    CharBackend chrs[MAX_MUX];
> >      int focus;
> > -    int mux_cnt;
> > +    int fe_cnt;
> > +    int be_cnt;
> >      int term_got_escape;
> >      int max_size;
> >      /* Intermediate input buffer catches escape sequences even if the
> > --
> > 2.34.1
> >
>
>
> It would also require some tests and QAPI support.

I will take a look at tests and will try to come up with some extension
for backend multiplexing.

Since the mux object API was not changed and the current change heavily
relies on what is already in the code, do you think there should be any
QAPI related change? In my understanding this should work out of the box
(not tested though).

--
Roman

