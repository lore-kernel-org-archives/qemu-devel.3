Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 298E1D1AD47
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 11:14:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t11yl-0006um-A7; Wed, 16 Oct 2024 07:14:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1t11yj-0006ue-MF
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 07:14:09 -0400
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1t11yf-0001YR-Bh
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 07:14:09 -0400
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-4603aced3a5so49572931cf.1
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 04:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729077244; x=1729682044; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zaanj4nVgHv+GIE4prQ4/EFRtbv6z/bTWpMn/qhMH8E=;
 b=GJHOQ+qEoZaGQbd4tMlOAEU6shYbLx6YmaUgg2q59s9n3mP1JYnwKDLEzY/T25Nk5d
 +YSfmCbqsw+jG9FQDyWAwFdGbNNUwojrPut0+qstG0KupnAtM8HglJoQEmQjvWsGSeGX
 3yTpKss+vfUTdRVADfMx9zGWlCSe9owjGvnbz5lUnwOsyf6T2/6bM2Y3GtiWCC9+2Oea
 6XCQ4cefxsBANYpzhoHPkOOGcA+XFtFlatRsMXJmvfvaiWTnI1b81lCE1yfau9lgaiuG
 nhPohFbsegqdnuI1fzpZjwE9fL/8z1d6lQ/61DldsXTjE8bEX0mEukwEBkGoVOYFsNGh
 0xoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729077244; x=1729682044;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zaanj4nVgHv+GIE4prQ4/EFRtbv6z/bTWpMn/qhMH8E=;
 b=UJx2Cd6rI23BmxzHIl8X3Ue60aspmwhxywisWe5ywCLFTwi5eGsJY2lZptdh/qsIvr
 AprOnZB36oQZx8sSDlRLpzgpquXf0nmXtbPZeGnTN5dteMayNYhoBDtCNXbFPK4tBQGZ
 ueyEViUQB5AOpW/uoOJaXh+m0YaxYZyB+x0/bVs0EfRmej3vNVDF/cDxqRBtMT/O0CHS
 T6sTrweHhBHOJDLCNHPWC6u5alNd4vt98W609Hqp8Gwdq7bjDTLKRAH+nvwxEAxmkVOy
 053L8U+5XEeieLRHtZaaAv28TRXaH5xpDYiXlMbkBWwQAsNiEHwsnPc4QTMQPsOxh3DG
 DC4Q==
X-Gm-Message-State: AOJu0YwKtWE3tus5e4b7AkDJBfn9M7nBm5NLnN3ox/YRKPOk/KUc/rsH
 5zdUupX0I/7pwe4AbXFC+ViJxpp495aZsT6VijIZk7WyrNm+VbJ/xX7tA6UYrHVqtEdU5QyORSz
 T+pZcXFLiF6lWjkmb6v+kSTVz0id1TSIeMBk=
X-Google-Smtp-Source: AGHT+IGCNfQtrSFx4gi1OenkBd2snqB5u8KWqQ7Hfu6+GIvR+U7ptoOcBRPPF4uNgrwWEFT23UOlcsE8XuxN/383rYY=
X-Received: by 2002:a05:622a:5448:b0:45f:106:590b with SMTP id
 d75a77b69052e-4604bbb8eccmr265099081cf.15.1729077244117; Wed, 16 Oct 2024
 04:14:04 -0700 (PDT)
MIME-Version: 1.0
References: <20241016102605.459395-1-r.peniaev@gmail.com>
 <20241016102605.459395-7-r.peniaev@gmail.com>
In-Reply-To: <20241016102605.459395-7-r.peniaev@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 16 Oct 2024 15:13:52 +0400
Message-ID: <CAJ+F1CLkn2WcmJEmNpJwNcc5VPriDTdSFWcv44QWaYtvHycKcQ@mail.gmail.com>
Subject: Re: [PATCH v4 6/8] chardev/char-mux: implement backend chardev
 multiplexing
To: Roman Penyaev <r.peniaev@gmail.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000eccf0e0624962ae5"
Received-SPF: pass client-ip=2607:f8b0:4864:20::833;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x833.google.com
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

--000000000000eccf0e0624962ae5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Wed, Oct 16, 2024 at 2:29=E2=80=AFPM Roman Penyaev <r.peniaev@gmail.com>=
 wrote:

> This patch implements multiplexing capability of several backend
> devices, which opens up an opportunity to use a single frontend
> device on the guest, which can be manipulated from several
> backend devices.
>
> The idea of the change is trivial: keep list of backend devices
> (up to 4), init them on demand and forward data buffer back and
> forth.
>
> Patch implements another multiplexer type `mux-be`. The following
> is QEMU command line example:
>
>    -chardev mux-be,id=3Dmux0 \
>    -chardev
> socket,path=3D/tmp/sock,server=3Don,wait=3Doff,id=3Dsock0,mux-be-id=3Dmux=
0 \
>    -chardev vc,id=3Dvc0,mux-be-id=3Dmux0 \
>

I am not sure about adding "mux-be-id" to all chardev. It avoids the issue
of expressing a list of ids in mux-be though (while it may have potential
loop!)

Markus, do you have a suggestion to take an array of chardev ids as a CLI
option? It looks like we could require QAPIfy -chardev from Kevin here..

thanks

   -device virtconsole,chardev=3Dmux0 \
>
   -vnc 0.0.0.0:0
>
> Which creates 2 backend devices: text virtual console (`vc0`) and a
> socket (`sock0`) connected to the single virtio hvc console with the
> backend multiplexer (`mux0`) help. `vc0` renders text to an image,
> which can be shared over the VNC protocol.  `sock0` is a socket
> backend which provides biderectional communication to the virtio hvc
> console.
>
> Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
> Cc: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
> Cc: qemu-devel@nongnu.org
> ---
>  chardev/char-fe.c          |   9 ++
>  chardev/char-mux-be.c      | 290 +++++++++++++++++++++++++++++++++++++
>  chardev/char.c             |  56 +++++--
>  chardev/chardev-internal.h |  34 ++++-
>  chardev/meson.build        |   1 +
>  include/chardev/char.h     |   1 +
>  qapi/char.json             |  25 ++++
>  7 files changed, 403 insertions(+), 13 deletions(-)
>  create mode 100644 chardev/char-mux-be.c
>
> diff --git a/chardev/char-fe.c b/chardev/char-fe.c
> index a2b5bff39fd9..2f794674563b 100644
> --- a/chardev/char-fe.c
> +++ b/chardev/char-fe.c
> @@ -200,6 +200,12 @@ bool qemu_chr_fe_init(CharBackend *b, Chardev *s,
> Error **errp)
>              if (!mux_fe_chr_attach_frontend(d, b, &tag, errp)) {
>                  return false;
>              }
> +        } else if (CHARDEV_IS_MUX_BE(s)) {
> +            MuxBeChardev *d =3D MUX_BE_CHARDEV(s);
> +
> +            if (!mux_be_chr_attach_frontend(d, b, errp)) {
> +                return false;
> +            }
>          } else if (s->be) {
>              error_setg(errp, "chardev '%s' is already in use", s->label)=
;
>              return false;
> @@ -226,6 +232,9 @@ void qemu_chr_fe_deinit(CharBackend *b, bool del)
>          if (CHARDEV_IS_MUX_FE(b->chr)) {
>              MuxFeChardev *d =3D MUX_FE_CHARDEV(b->chr);
>              mux_fe_chr_detach_frontend(d, b->tag);
> +        } else if (CHARDEV_IS_MUX_BE(b->chr)) {
> +            MuxBeChardev *d =3D MUX_BE_CHARDEV(b->chr);
> +            mux_be_chr_detach_frontend(d);
>          }
>          if (del) {
>              Object *obj =3D OBJECT(b->chr);
> diff --git a/chardev/char-mux-be.c b/chardev/char-mux-be.c
> new file mode 100644
> index 000000000000..64a4f2c00034
> --- /dev/null
> +++ b/chardev/char-mux-be.c
> @@ -0,0 +1,290 @@
> +/*
> + * QEMU Character Backend Multiplexer
> + *
> + * Author: Roman Penyaev <r.peniaev@gmail.com>
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining
> a copy
> + * of this software and associated documentation files (the "Software"),
> to deal
> + * in the Software without restriction, including without limitation the
> rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or
> sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be
> included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
> OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S
> IN
> + * THE SOFTWARE.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qemu/module.h"
> +#include "qemu/option.h"
> +#include "qemu/cutils.h"
> +#include "chardev/char.h"
> +#include "sysemu/block-backend.h"
> +#include "qapi/qapi-commands-control.h"
> +#include "qapi/clone-visitor.h"
> +#include "qapi/qapi-builtin-visit.h"
> +#include "chardev-internal.h"
> +
> +/*
> + * MUX-BE driver for multiplexing 1 frontend device with N backend devic=
es
> + */
> +
> +/*
> + * Write to all backends. Different backend devices accept data with
> + * various rate, so it is quite possible that one device returns less,
> + * then others. In this case we return minimum to the caller,
> + * expecting caller will repeat operation soon. When repeat happens
> + * send to the devices which consume data faster must be avoided
> + * for obvious reasons not to send data, which was already sent.
> + */
> +static int mux_be_chr_write_to_all(MuxBeChardev *d, const uint8_t *buf,
> int len)
> +{
> +    int r, i, ret =3D len;
> +    unsigned int written;
> +
> +    for (i =3D 0; i < d->be_cnt; i++) {
> +        written =3D d->be_written[i] - d->be_min_written;
> +        if (written) {
> +            /* Written in the previous call so take into account */
> +            ret =3D MIN(written, ret);
> +            continue;
> +        }
> +        r =3D qemu_chr_fe_write(&d->backends[i], buf, len);
> +        if (r < 0 && errno =3D=3D EAGAIN) {
> +            /*
> +             * Fail immediately if write would block. Expect to be calle=
d
> +             * soon on watch wake up.
> +             */
> +            return r;
> +        } else if (r < 0) {
> +            /*
> +             * Ignore all other errors and pretend the entire buffer is
> +             * written to avoid this chardev being watched. This device
> +             * becomes disabled until the following write succeeds, but
> +             * writing continues to others.
> +             */
> +            r =3D len;
> +        }
> +        d->be_written[i] +=3D r;
> +        ret =3D MIN(r, ret);
> +    }
> +    d->be_min_written +=3D ret;
> +
> +    return ret;
> +}
> +
> +/* Called with chr_write_lock held.  */
> +static int mux_be_chr_write(Chardev *chr, const uint8_t *buf, int len)
> +{
> +    MuxBeChardev *d =3D MUX_BE_CHARDEV(chr);
> +    return mux_be_chr_write_to_all(d, buf, len);
> +}
> +
> +static void mux_be_chr_send_event(MuxBeChardev *d, QEMUChrEvent event)
> +{
> +    CharBackend *fe =3D d->frontend;
> +
> +    if (fe && fe->chr_event) {
> +        fe->chr_event(fe->opaque, event);
> +    }
> +}
> +
> +static void mux_be_chr_be_event(Chardev *chr, QEMUChrEvent event)
> +{
> +    MuxBeChardev *d =3D MUX_BE_CHARDEV(chr);
> +
> +    mux_be_chr_send_event(d, event);
> +}
> +
> +static int mux_be_chr_can_read(void *opaque)
> +{
> +    MuxBeChardev *d =3D MUX_BE_CHARDEV(opaque);
> +    CharBackend *fe =3D d->frontend;
> +
> +    if (fe && fe->chr_can_read) {
> +        return fe->chr_can_read(fe->opaque);
> +    }
> +
> +    return 0;
> +}
> +
> +static void mux_be_chr_read(void *opaque, const uint8_t *buf, int size)
> +{
> +    MuxBeChardev *d =3D MUX_BE_CHARDEV(opaque);
> +    CharBackend *fe =3D d->frontend;
> +
> +    if (fe && fe->chr_read) {
> +        fe->chr_read(fe->opaque, buf, size);
> +    }
> +}
> +
> +void mux_be_chr_send_all_event(MuxBeChardev *d, QEMUChrEvent event)
> +{
> +    mux_be_chr_send_event(d, event);
> +}
> +
> +static void mux_be_chr_event(void *opaque, QEMUChrEvent event)
> +{
> +    mux_chr_send_all_event(CHARDEV(opaque), event);
> +}
> +
> +static GSource *mux_be_chr_add_watch(Chardev *s, GIOCondition cond)
> +{
> +    MuxBeChardev *d =3D MUX_BE_CHARDEV(s);
> +    Chardev *chr;
> +    ChardevClass *cc;
> +    unsigned int written;
> +    int i;
> +
> +    for (i =3D 0; i < d->be_cnt; i++) {
> +        written =3D d->be_written[i] - d->be_min_written;
> +        if (written) {
> +            /* We skip the device with already written buffer */
> +            continue;
> +        }
> +
> +        /*
> +         * The first device that has no data written to it must be
> +         * the device that recently returned EAGAIN and should be
> +         * watched.
> +         */
> +
> +        chr =3D qemu_chr_fe_get_driver(&d->backends[i]);
> +        cc =3D CHARDEV_GET_CLASS(chr);
> +
> +        if (!cc->chr_add_watch) {
> +            return NULL;
> +        }
> +
> +        return cc->chr_add_watch(chr, cond);
> +    }
> +
> +    return NULL;
> +}
> +
> +bool mux_be_chr_attach_chardev(MuxBeChardev *d, Chardev *chr, Error
> **errp)
> +{
> +    bool ret;
> +
> +    if (d->be_cnt >=3D MAX_MUX) {
> +        error_setg(errp, "too many uses of multiplexed chardev '%s'"
> +                   " (maximum is " stringify(MAX_MUX) ")",
> +                   d->parent.label);
> +        return false;
> +    }
> +    ret =3D qemu_chr_fe_init(&d->backends[d->be_cnt], chr, errp);
> +    if (ret) {
> +        /* Catch up with what was already written */
> +        d->be_written[d->be_cnt] =3D d->be_min_written;
> +        d->be_cnt +=3D 1;
> +    }
> +
> +    return ret;
> +}
> +
> +static void char_mux_be_finalize(Object *obj)
> +{
> +    MuxBeChardev *d =3D MUX_BE_CHARDEV(obj);
> +    CharBackend *fe =3D d->frontend;
> +    int i;
> +
> +    if (fe) {
> +        fe->chr =3D NULL;
> +    }
> +    for (i =3D 0; i < d->be_cnt; i++) {
> +        qemu_chr_fe_deinit(&d->backends[i], false);
> +    }
> +}
> +
> +static void mux_be_chr_update_read_handlers(Chardev *chr)
> +{
> +    MuxBeChardev *d =3D MUX_BE_CHARDEV(chr);
> +    int i;
> +
> +    for (i =3D 0; i < d->be_cnt; i++) {
> +        /* Fix up the real driver with mux routines */
> +        qemu_chr_fe_set_handlers_full(&d->backends[i],
> +                                      mux_be_chr_can_read,
> +                                      mux_be_chr_read,
> +                                      mux_be_chr_event,
> +                                      NULL,
> +                                      chr,
> +                                      chr->gcontext, true, false);
> +    }
> +}
> +
> +bool mux_be_chr_attach_frontend(MuxBeChardev *d, CharBackend *b, Error
> **errp)
> +{
> +    if (d->frontend) {
> +        error_setg(errp,
> +                   "multiplexed chardev '%s' is already used "
> +                   "for multiplexing", d->parent.label);
> +        return false;
> +    }
> +    d->frontend =3D b;
> +
> +    return true;
> +}
> +
> +void mux_be_chr_detach_frontend(MuxBeChardev *d)
> +{
> +    d->frontend =3D NULL;
> +}
> +
> +static void qemu_chr_open_mux_be(Chardev *chr,
> +                                 ChardevBackend *backend,
> +                                 bool *be_opened,
> +                                 Error **errp)
> +{
> +    /*
> +     * Only default to opened state if we've realized the initial
> +     * set of muxes
> +     */
> +    *be_opened =3D mux_is_opened();
> +}
> +
> +static void qemu_chr_parse_mux_be(QemuOpts *opts, ChardevBackend *backen=
d,
> +                                  Error **errp)
> +{
> +    ChardevMuxBe *mux;
> +
> +    backend->type =3D CHARDEV_BACKEND_KIND_MUX_BE;
> +    mux =3D backend->u.mux_be.data =3D g_new0(ChardevMuxBe, 1);
> +    qemu_chr_parse_common(opts, qapi_ChardevMuxBe_base(mux));
> +}
> +
> +static void char_mux_be_class_init(ObjectClass *oc, void *data)
> +{
> +    ChardevClass *cc =3D CHARDEV_CLASS(oc);
> +
> +    cc->parse =3D qemu_chr_parse_mux_be;
> +    cc->open =3D qemu_chr_open_mux_be;
> +    cc->chr_write =3D mux_be_chr_write;
> +    cc->chr_add_watch =3D mux_be_chr_add_watch;
> +    cc->chr_be_event =3D mux_be_chr_be_event;
> +    cc->chr_update_read_handler =3D mux_be_chr_update_read_handlers;
> +}
> +
> +static const TypeInfo char_mux_be_type_info =3D {
> +    .name =3D TYPE_CHARDEV_MUX_BE,
> +    .parent =3D TYPE_CHARDEV,
> +    .class_init =3D char_mux_be_class_init,
> +    .instance_size =3D sizeof(MuxBeChardev),
> +    .instance_finalize =3D char_mux_be_finalize,
> +};
> +
> +static void register_types(void)
> +{
> +    type_register_static(&char_mux_be_type_info);
> +}
> +
> +type_init(register_types);
> diff --git a/chardev/char.c b/chardev/char.c
> index cffe60860589..58fa8ac70a1e 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -341,6 +341,9 @@ static bool qemu_chr_is_busy(Chardev *s)
>      if (CHARDEV_IS_MUX_FE(s)) {
>          MuxFeChardev *d =3D MUX_FE_CHARDEV(s);
>          return d->mux_bitset !=3D 0;
> +    } else if (CHARDEV_IS_MUX_BE(s)) {
> +        MuxBeChardev *d =3D MUX_BE_CHARDEV(s);
> +        return d->frontend !=3D NULL;
>      } else {
>          return s->be !=3D NULL;
>      }
> @@ -648,7 +651,8 @@ static Chardev *__qemu_chr_new_from_opts(QemuOpts
> *opts, GMainContext *context,
>      ChardevBackend *backend =3D NULL;
>      const char *name =3D qemu_opt_get(opts, "backend");
>      const char *id =3D qemu_opts_id(opts);
> -    char *bid =3D NULL;
> +    const char *mux_be_id =3D NULL;
> +    char *mux_fe_id =3D NULL;
>
>      if (name && is_help_option(name)) {
>          GString *str =3D g_string_new("");
> @@ -676,10 +680,16 @@ static Chardev *__qemu_chr_new_from_opts(QemuOpts
> *opts, GMainContext *context,
>      }
>
>      if (qemu_opt_get_bool(opts, "mux", 0)) {
> -        bid =3D g_strdup_printf("%s-base", id);
> +        mux_fe_id =3D g_strdup_printf("%s-base", id);
> +    }
> +    mux_be_id =3D qemu_opt_get(opts, "mux-be-id");
> +    if (mux_be_id && mux_fe_id) {
> +        error_setg(errp, "chardev: mux and mux-be can't be used for the
> same "
> +                   "device");
> +        goto out;
>      }
>
> -    chr =3D qemu_chardev_new(bid ? bid : id,
> +    chr =3D qemu_chardev_new(mux_fe_id ? mux_fe_id : id,
>                             object_class_get_name(OBJECT_CLASS(cc)),
>                             backend, context, errp);
>      if (chr =3D=3D NULL) {
> @@ -687,25 +697,40 @@ static Chardev *__qemu_chr_new_from_opts(QemuOpts
> *opts, GMainContext *context,
>      }
>
>      base =3D chr;
> -    if (bid) {
> +    if (mux_fe_id) {
>          Chardev *mux;
>          qapi_free_ChardevBackend(backend);
>          backend =3D g_new0(ChardevBackend, 1);
>          backend->type =3D CHARDEV_BACKEND_KIND_MUX;
>          backend->u.mux.data =3D g_new0(ChardevMux, 1);
> -        backend->u.mux.data->chardev =3D g_strdup(bid);
> +        backend->u.mux.data->chardev =3D g_strdup(mux_fe_id);
>          mux =3D qemu_chardev_new(id, TYPE_CHARDEV_MUX_FE, backend, conte=
xt,
> errp);
>          if (mux =3D=3D NULL) {
> -            object_unparent(OBJECT(chr));
> -            chr =3D NULL;
> -            goto out;
> +            goto unparent_and_out;
>          }
>          chr =3D mux;
> +    } else if (mux_be_id) {
> +        Chardev *s;
> +
> +        s =3D qemu_chr_find(mux_be_id);
> +        if (!s) {
> +            error_setg(errp, "chardev: mux-be device can't be found by i=
d
> '%s'",
> +                       mux_be_id);
> +            goto unparent_and_out;
> +        }
> +        if (!CHARDEV_IS_MUX_BE(s)) {
> +            error_setg(errp, "chardev: device '%s' is not a multiplexer
> device"
> +                       " of 'mux-be' type", mux_be_id);
> +            goto unparent_and_out;
> +        }
> +        if (!mux_be_chr_attach_chardev(MUX_BE_CHARDEV(s), chr, errp)) {
> +            goto unparent_and_out;
> +        }
>      }
>
>  out:
>      qapi_free_ChardevBackend(backend);
> -    g_free(bid);
> +    g_free(mux_fe_id);
>
>      if (replay && base) {
>          /* RR should be set on the base device, not the mux */
> @@ -713,6 +738,11 @@ out:
>      }
>
>      return chr;
> +
> +unparent_and_out:
> +    object_unparent(OBJECT(chr));
> +    chr =3D NULL;
> +    goto out;
>  }
>
>  Chardev *qemu_chr_new_from_opts(QemuOpts *opts, GMainContext *context,
> @@ -1114,7 +1144,7 @@ ChardevReturn *qmp_chardev_change(const char *id,
> ChardevBackend *backend,
>          return NULL;
>      }
>
> -    if (CHARDEV_IS_MUX_FE(chr)) {
> +    if (CHARDEV_IS_MUX_FE(chr) || CHARDEV_IS_MUX_BE(chr)) {
>          error_setg(errp, "Mux device hotswap not supported yet");
>          return NULL;
>      }
> @@ -1302,7 +1332,7 @@ static int chardev_options_parsed_cb(Object *child,
> void *opaque)
>  {
>      Chardev *chr =3D (Chardev *)child;
>
> -    if (!chr->be_open && CHARDEV_IS_MUX_FE(chr)) {
> +    if (!chr->be_open && (CHARDEV_IS_MUX_FE(chr) ||
> CHARDEV_IS_MUX_BE(chr))) {
>          open_muxes(chr);
>      }
>
> @@ -1329,8 +1359,10 @@ void mux_chr_send_all_event(Chardev *chr,
> QEMUChrEvent event)
>
>      if (CHARDEV_IS_MUX_FE(chr)) {
>          MuxFeChardev *d =3D MUX_FE_CHARDEV(chr);
> -
>          mux_fe_chr_send_all_event(d, event);
> +    } else if (CHARDEV_IS_MUX_BE(chr)) {
> +        MuxBeChardev *d =3D MUX_BE_CHARDEV(chr);
> +        mux_be_chr_send_all_event(d, event);
>      }
>  }
>
> diff --git a/chardev/chardev-internal.h b/chardev/chardev-internal.h
> index 94c8d07ac235..8ea1258f8ff4 100644
> --- a/chardev/chardev-internal.h
> +++ b/chardev/chardev-internal.h
> @@ -35,7 +35,9 @@
>
>  struct MuxFeChardev {
>      Chardev parent;
> +    /* Linked frontends */
>      CharBackend *backends[MAX_MUX];
> +    /* Linked backend */
>      CharBackend chr;
>

Maybe a patch to rename those fields would help.

>

>      unsigned long mux_bitset;
>      int focus;
> @@ -54,10 +56,36 @@ struct MuxFeChardev {
>  };
>  typedef struct MuxFeChardev MuxFeChardev;
>
> +struct MuxBeChardev {
> +    Chardev parent;
> +    /* Linked frontend */
> +    CharBackend *frontend;
> +    /* Linked backends */
> +    CharBackend backends[MAX_MUX];
> +    /*
> +     * Number of backends attached to this mux. Once attached, a
> +     * backend can't be detached, so the counter is only increasing.
> +     * To safely remove a backend, mux has to be removed first.
> +     */
> +    unsigned int be_cnt;
> +    /*
> +     * Counters of written bytes from a single frontend device
> +     * to multiple backend devices.
> +     */
> +    unsigned int be_written[MAX_MUX];
> +    unsigned int be_min_written;
> +};
> +typedef struct MuxBeChardev MuxBeChardev;
> +
>  DECLARE_INSTANCE_CHECKER(MuxFeChardev, MUX_FE_CHARDEV,
>                           TYPE_CHARDEV_MUX_FE)
> -#define CHARDEV_IS_MUX_FE(chr)                             \
> +DECLARE_INSTANCE_CHECKER(MuxBeChardev, MUX_BE_CHARDEV,
> +                         TYPE_CHARDEV_MUX_BE)
> +
> +#define CHARDEV_IS_MUX_FE(chr)                              \
>      object_dynamic_cast(OBJECT(chr), TYPE_CHARDEV_MUX_FE)
> +#define CHARDEV_IS_MUX_BE(chr)                              \
> +    object_dynamic_cast(OBJECT(chr), TYPE_CHARDEV_MUX_BE)
>
>  void mux_chr_send_all_event(Chardev *chr, QEMUChrEvent event);
>
> @@ -67,6 +95,10 @@ void mux_fe_chr_send_all_event(MuxFeChardev *d,
> QEMUChrEvent event);
>  bool mux_fe_chr_attach_frontend(MuxFeChardev *d, CharBackend *b,
>                                  unsigned int *tag, Error **errp);
>  bool mux_fe_chr_detach_frontend(MuxFeChardev *d, unsigned int tag);
> +void mux_be_chr_send_all_event(MuxBeChardev *d, QEMUChrEvent event);
> +bool mux_be_chr_attach_chardev(MuxBeChardev *d, Chardev *chr, Error
> **errp);
> +bool mux_be_chr_attach_frontend(MuxBeChardev *d, CharBackend *b, Error
> **errp);
> +void mux_be_chr_detach_frontend(MuxBeChardev *d);
>
>  Object *get_chardevs_root(void);
>
> diff --git a/chardev/meson.build b/chardev/meson.build
> index 778444a00ca6..3a9f5565372b 100644
> --- a/chardev/meson.build
> +++ b/chardev/meson.build
> @@ -3,6 +3,7 @@ chardev_ss.add(files(
>    'char-file.c',
>    'char-io.c',
>    'char-mux-fe.c',
> +  'char-mux-be.c',
>    'char-null.c',
>    'char-pipe.c',
>    'char-ringbuf.c',
> diff --git a/include/chardev/char.h b/include/chardev/char.h
> index 0bec974f9d73..c58c11c4eeaf 100644
> --- a/include/chardev/char.h
> +++ b/include/chardev/char.h
> @@ -232,6 +232,7 @@ OBJECT_DECLARE_TYPE(Chardev, ChardevClass, CHARDEV)
>
>  #define TYPE_CHARDEV_NULL "chardev-null"
>  #define TYPE_CHARDEV_MUX_FE "chardev-mux"
> +#define TYPE_CHARDEV_MUX_BE "chardev-mux-be"
>  #define TYPE_CHARDEV_RINGBUF "chardev-ringbuf"
>  #define TYPE_CHARDEV_PTY "chardev-pty"
>  #define TYPE_CHARDEV_CONSOLE "chardev-console"
> diff --git a/qapi/char.json b/qapi/char.json
> index fb0dedb24383..cdec8f9cf4e2 100644
> --- a/qapi/char.json
> +++ b/qapi/char.json
> @@ -336,6 +336,17 @@
>    'data': { 'chardev': 'str' },
>    'base': 'ChardevCommon' }
>
> +##
> +# @ChardevMuxBe:
> +#
> +# Configuration info for mux-be chardevs.
> +#
> +# Since: 9.2
> +##
> +{ 'struct': 'ChardevMuxBe',
> +  'data': { },
> +  'base': 'ChardevCommon' }
> +
>  ##
>  # @ChardevStdio:
>  #
> @@ -483,6 +494,8 @@
>  #
>  # @mux: (since 1.5)
>  #
> +# @mux-be: (since 9.2)
> +#
>  # @msmouse: emulated Microsoft serial mouse (since 1.5)
>  #
>  # @wctablet: emulated Wacom Penpartner serial tablet (since 2.9)
> @@ -525,6 +538,7 @@
>              'pty',
>              'null',
>              'mux',
> +            'mux-be',
>              'msmouse',
>              'wctablet',
>              { 'name': 'braille', 'if': 'CONFIG_BRLAPI' },
> @@ -599,6 +613,16 @@
>  { 'struct': 'ChardevMuxWrapper',
>    'data': { 'data': 'ChardevMux' } }
>
> +##
> +# @ChardevMuxBeWrapper:
> +#
> +# @data: Configuration info for mux-be chardevs
> +#
> +# Since: 9.2
> +##
> +{ 'struct': 'ChardevMuxBeWrapper',
> +  'data': { 'data': 'ChardevMuxBe' } }
> +
>  ##
>  # @ChardevStdioWrapper:
>  #
> @@ -707,6 +731,7 @@
>              'pty': 'ChardevPtyWrapper',
>              'null': 'ChardevCommonWrapper',
>              'mux': 'ChardevMuxWrapper',
> +            'mux-be': 'ChardevMuxBeWrapper',
>              'msmouse': 'ChardevCommonWrapper',
>              'wctablet': 'ChardevCommonWrapper',
>              'braille': { 'type': 'ChardevCommonWrapper',
> --
> 2.34.1
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000eccf0e0624962ae5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr">Hi<br><=
/div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">O=
n Wed, Oct 16, 2024 at 2:29=E2=80=AFPM Roman Penyaev &lt;<a href=3D"mailto:=
r.peniaev@gmail.com" target=3D"_blank">r.peniaev@gmail.com</a>&gt; wrote:<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">This patch implem=
ents multiplexing capability of several backend<br>
devices, which opens up an opportunity to use a single frontend<br>
device on the guest, which can be manipulated from several<br>
backend devices.<br>
<br>
The idea of the change is trivial: keep list of backend devices<br>
(up to 4), init them on demand and forward data buffer back and<br>
forth.<br>
<br>
Patch implements another multiplexer type `mux-be`. The following<br>
is QEMU command line example:<br>
<br>
=C2=A0 =C2=A0-chardev mux-be,id=3Dmux0 \<br>
=C2=A0 =C2=A0-chardev socket,path=3D/tmp/sock,server=3Don,wait=3Doff,id=3Ds=
ock0,mux-be-id=3Dmux0 \<br>
=C2=A0 =C2=A0-chardev vc,id=3Dvc0,mux-be-id=3Dmux0 \<br></blockquote><div><=
br></div><div>I am not sure about adding &quot;mux-be-id&quot; to all chard=
ev. It avoids the issue of expressing a list of ids in mux-be though (while=
 it may have potential loop!)<br></div><div><br></div><div>Markus, do you h=
ave a suggestion to take an array of chardev ids as a CLI option? It looks =
like we could require QAPIfy -<span class=3D"gmail-il">chardev from Kevin h=
ere..</span></div><div><span class=3D"gmail-il"><br></span></div><div><span=
 class=3D"gmail-il">thanks</span></div><div><span class=3D"gmail-il"><br></=
span></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0-device virtconsole,chardev=3Dmux0 \ <br></blockquote><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0-vnc <a href=3D"http://0.0.0.0:0" rel=3D"noreferrer" target=3D=
"_blank">0.0.0.0:0</a><br>
<br>
Which creates 2 backend devices: text virtual console (`vc0`) and a<br>
socket (`sock0`) connected to the single virtio hvc console with the<br>
backend multiplexer (`mux0`) help. `vc0` renders text to an image,<br>
which can be shared over the VNC protocol.=C2=A0 `sock0` is a socket<br>
backend which provides biderectional communication to the virtio hvc<br>
console.<br>
<br>
Signed-off-by: Roman Penyaev &lt;<a href=3D"mailto:r.peniaev@gmail.com" tar=
get=3D"_blank">r.peniaev@gmail.com</a>&gt;<br>
Cc: &quot;Marc-Andr=C3=A9 Lureau&quot; &lt;<a href=3D"mailto:marcandre.lure=
au@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
Cc: <a href=3D"mailto:qemu-devel@nongnu.org" target=3D"_blank">qemu-devel@n=
ongnu.org</a><br>
---<br>
=C2=A0chardev/char-fe.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A09 +=
+<br>
=C2=A0chardev/char-mux-be.c=C2=A0 =C2=A0 =C2=A0 | 290 +++++++++++++++++++++=
++++++++++++++++<br>
=C2=A0chardev/char.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0=
 56 +++++--<br>
=C2=A0chardev/chardev-internal.h |=C2=A0 34 ++++-<br>
=C2=A0chardev/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
=C2=A0include/chardev/char.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
=C2=A0qapi/char.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0=
 25 ++++<br>
=C2=A07 files changed, 403 insertions(+), 13 deletions(-)<br>
=C2=A0create mode 100644 chardev/char-mux-be.c<br>
<br>
diff --git a/chardev/char-fe.c b/chardev/char-fe.c<br>
index a2b5bff39fd9..2f794674563b 100644<br>
--- a/chardev/char-fe.c<br>
+++ b/chardev/char-fe.c<br>
@@ -200,6 +200,12 @@ bool qemu_chr_fe_init(CharBackend *b, Chardev *s, Erro=
r **errp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!mux_fe_chr_attach_fron=
tend(d, b, &amp;tag, errp)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (CHARDEV_IS_MUX_BE(s)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MuxBeChardev *d =3D MUX_BE_CHARD=
EV(s);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!mux_be_chr_attach_frontend(=
d, b, errp)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (s-&gt;be) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp, &quot;char=
dev &#39;%s&#39; is already in use&quot;, s-&gt;label);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;<br>
@@ -226,6 +232,9 @@ void qemu_chr_fe_deinit(CharBackend *b, bool del)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (CHARDEV_IS_MUX_FE(b-&gt;chr)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MuxFeChardev *d =3D MUX_FE_=
CHARDEV(b-&gt;chr);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mux_fe_chr_detach_frontend(=
d, b-&gt;tag);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (CHARDEV_IS_MUX_BE(b-&gt;chr)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MuxBeChardev *d =3D MUX_BE_CHARD=
EV(b-&gt;chr);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mux_be_chr_detach_frontend(d);<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (del) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Object *obj =3D OBJECT(b-&g=
t;chr);<br>
diff --git a/chardev/char-mux-be.c b/chardev/char-mux-be.c<br>
new file mode 100644<br>
index 000000000000..64a4f2c00034<br>
--- /dev/null<br>
+++ b/chardev/char-mux-be.c<br>
@@ -0,0 +1,290 @@<br>
+/*<br>
+ * QEMU Character Backend Multiplexer<br>
+ *<br>
+ * Author: Roman Penyaev &lt;<a href=3D"mailto:r.peniaev@gmail.com" target=
=3D"_blank">r.peniaev@gmail.com</a>&gt;<br>
+ *<br>
+ * Permission is hereby granted, free of charge, to any person obtaining a=
 copy<br>
+ * of this software and associated documentation files (the &quot;Software=
&quot;), to deal<br>
+ * in the Software without restriction, including without limitation the r=
ights<br>
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or se=
ll<br>
+ * copies of the Software, and to permit persons to whom the Software is<b=
r>
+ * furnished to do so, subject to the following conditions:<br>
+ *<br>
+ * The above copyright notice and this permission notice shall be included=
 in<br>
+ * all copies or substantial portions of the Software.<br>
+ *<br>
+ * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIN=
D, EXPRESS OR<br>
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,<br>
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL=
<br>
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OT=
HER<br>
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING=
 FROM,<br>
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS =
IN<br>
+ * THE SOFTWARE.<br>
+ */<br>
+<br>
+#include &quot;qemu/osdep.h&quot;<br>
+#include &quot;qapi/error.h&quot;<br>
+#include &quot;qemu/module.h&quot;<br>
+#include &quot;qemu/option.h&quot;<br>
+#include &quot;qemu/cutils.h&quot;<br>
+#include &quot;chardev/char.h&quot;<br>
+#include &quot;sysemu/block-backend.h&quot;<br>
+#include &quot;qapi/qapi-commands-control.h&quot;<br>
+#include &quot;qapi/clone-visitor.h&quot;<br>
+#include &quot;qapi/qapi-builtin-visit.h&quot;<br>
+#include &quot;chardev-internal.h&quot;<br>
+<br>
+/*<br>
+ * MUX-BE driver for multiplexing 1 frontend device with N backend devices=
<br>
+ */<br>
+<br>
+/*<br>
+ * Write to all backends. Different backend devices accept data with<br>
+ * various rate, so it is quite possible that one device returns less,<br>
+ * then others. In this case we return minimum to the caller,<br>
+ * expecting caller will repeat operation soon. When repeat happens<br>
+ * send to the devices which consume data faster must be avoided<br>
+ * for obvious reasons not to send data, which was already sent.<br>
+ */<br>
+static int mux_be_chr_write_to_all(MuxBeChardev *d, const uint8_t *buf, in=
t len)<br>
+{<br>
+=C2=A0 =C2=A0 int r, i, ret =3D len;<br>
+=C2=A0 =C2=A0 unsigned int written;<br>
+<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; d-&gt;be_cnt; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 written =3D d-&gt;be_written[i] - d-&gt;be_min=
_written;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (written) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Written in the previous call =
so take into account */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D MIN(written, ret);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D qemu_chr_fe_write(&amp;d-&gt;backends[i]=
, buf, len);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (r &lt; 0 &amp;&amp; errno =3D=3D EAGAIN) {=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Fail immediately if writ=
e would block. Expect to be called<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* soon on watch wake up.<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return r;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (r &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Ignore all other errors =
and pretend the entire buffer is<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* written to avoid this ch=
ardev being watched. This device<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* becomes disabled until t=
he following write succeeds, but<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* writing continues to oth=
ers.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D len;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 d-&gt;be_written[i] +=3D r;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D MIN(r, ret);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 d-&gt;be_min_written +=3D ret;<br>
+<br>
+=C2=A0 =C2=A0 return ret;<br>
+}<br>
+<br>
+/* Called with chr_write_lock held.=C2=A0 */<br>
+static int mux_be_chr_write(Chardev *chr, const uint8_t *buf, int len)<br>
+{<br>
+=C2=A0 =C2=A0 MuxBeChardev *d =3D MUX_BE_CHARDEV(chr);<br>
+=C2=A0 =C2=A0 return mux_be_chr_write_to_all(d, buf, len);<br>
+}<br>
+<br>
+static void mux_be_chr_send_event(MuxBeChardev *d, QEMUChrEvent event)<br>
+{<br>
+=C2=A0 =C2=A0 CharBackend *fe =3D d-&gt;frontend;<br>
+<br>
+=C2=A0 =C2=A0 if (fe &amp;&amp; fe-&gt;chr_event) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fe-&gt;chr_event(fe-&gt;opaque, event);<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+static void mux_be_chr_be_event(Chardev *chr, QEMUChrEvent event)<br>
+{<br>
+=C2=A0 =C2=A0 MuxBeChardev *d =3D MUX_BE_CHARDEV(chr);<br>
+<br>
+=C2=A0 =C2=A0 mux_be_chr_send_event(d, event);<br>
+}<br>
+<br>
+static int mux_be_chr_can_read(void *opaque)<br>
+{<br>
+=C2=A0 =C2=A0 MuxBeChardev *d =3D MUX_BE_CHARDEV(opaque);<br>
+=C2=A0 =C2=A0 CharBackend *fe =3D d-&gt;frontend;<br>
+<br>
+=C2=A0 =C2=A0 if (fe &amp;&amp; fe-&gt;chr_can_read) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return fe-&gt;chr_can_read(fe-&gt;opaque);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return 0;<br>
+}<br>
+<br>
+static void mux_be_chr_read(void *opaque, const uint8_t *buf, int size)<br=
>
+{<br>
+=C2=A0 =C2=A0 MuxBeChardev *d =3D MUX_BE_CHARDEV(opaque);<br>
+=C2=A0 =C2=A0 CharBackend *fe =3D d-&gt;frontend;<br>
+<br>
+=C2=A0 =C2=A0 if (fe &amp;&amp; fe-&gt;chr_read) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fe-&gt;chr_read(fe-&gt;opaque, buf, size);<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+void mux_be_chr_send_all_event(MuxBeChardev *d, QEMUChrEvent event)<br>
+{<br>
+=C2=A0 =C2=A0 mux_be_chr_send_event(d, event);<br>
+}<br>
+<br>
+static void mux_be_chr_event(void *opaque, QEMUChrEvent event)<br>
+{<br>
+=C2=A0 =C2=A0 mux_chr_send_all_event(CHARDEV(opaque), event);<br>
+}<br>
+<br>
+static GSource *mux_be_chr_add_watch(Chardev *s, GIOCondition cond)<br>
+{<br>
+=C2=A0 =C2=A0 MuxBeChardev *d =3D MUX_BE_CHARDEV(s);<br>
+=C2=A0 =C2=A0 Chardev *chr;<br>
+=C2=A0 =C2=A0 ChardevClass *cc;<br>
+=C2=A0 =C2=A0 unsigned int written;<br>
+=C2=A0 =C2=A0 int i;<br>
+<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; d-&gt;be_cnt; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 written =3D d-&gt;be_written[i] - d-&gt;be_min=
_written;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (written) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* We skip the device with alrea=
dy written buffer */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* The first device that has no data writ=
ten to it must be<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* the device that recently returned EAGA=
IN and should be<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* watched.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 chr =3D qemu_chr_fe_get_driver(&amp;d-&gt;back=
ends[i]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cc =3D CHARDEV_GET_CLASS(chr);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!cc-&gt;chr_add_watch) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return cc-&gt;chr_add_watch(chr, cond);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return NULL;<br>
+}<br>
+<br>
+bool mux_be_chr_attach_chardev(MuxBeChardev *d, Chardev *chr, Error **errp=
)<br>
+{<br>
+=C2=A0 =C2=A0 bool ret;<br>
+<br>
+=C2=A0 =C2=A0 if (d-&gt;be_cnt &gt;=3D MAX_MUX) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;too many uses of multip=
lexed chardev &#39;%s&#39;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot=
; (maximum is &quot; stringify(MAX_MUX) &quot;)&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0d-&gt=
;parent.label);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 ret =3D qemu_chr_fe_init(&amp;d-&gt;backends[d-&gt;be_cnt], =
chr, errp);<br>
+=C2=A0 =C2=A0 if (ret) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Catch up with what was already written */<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 d-&gt;be_written[d-&gt;be_cnt] =3D d-&gt;be_mi=
n_written;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 d-&gt;be_cnt +=3D 1;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return ret;<br>
+}<br>
+<br>
+static void char_mux_be_finalize(Object *obj)<br>
+{<br>
+=C2=A0 =C2=A0 MuxBeChardev *d =3D MUX_BE_CHARDEV(obj);<br>
+=C2=A0 =C2=A0 CharBackend *fe =3D d-&gt;frontend;<br>
+=C2=A0 =C2=A0 int i;<br>
+<br>
+=C2=A0 =C2=A0 if (fe) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fe-&gt;chr =3D NULL;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; d-&gt;be_cnt; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_chr_fe_deinit(&amp;d-&gt;backends[i], fal=
se);<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+static void mux_be_chr_update_read_handlers(Chardev *chr)<br>
+{<br>
+=C2=A0 =C2=A0 MuxBeChardev *d =3D MUX_BE_CHARDEV(chr);<br>
+=C2=A0 =C2=A0 int i;<br>
+<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; d-&gt;be_cnt; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Fix up the real driver with mux routines */=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_chr_fe_set_handlers_full(&amp;d-&gt;backe=
nds[i],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mux_be_chr_can_=
read,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mux_be_chr_read=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mux_be_chr_even=
t,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 chr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 chr-&gt;gcontex=
t, true, false);<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+bool mux_be_chr_attach_frontend(MuxBeChardev *d, CharBackend *b, Error **e=
rrp)<br>
+{<br>
+=C2=A0 =C2=A0 if (d-&gt;frontend) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot=
;multiplexed chardev &#39;%s&#39; is already used &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot=
;for multiplexing&quot;, d-&gt;parent.label);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 d-&gt;frontend =3D b;<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+void mux_be_chr_detach_frontend(MuxBeChardev *d)<br>
+{<br>
+=C2=A0 =C2=A0 d-&gt;frontend =3D NULL;<br>
+}<br>
+<br>
+static void qemu_chr_open_mux_be(Chardev *chr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ChardevBackend *backend,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool *be_opened,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* Only default to opened state if we&#39;ve realized t=
he initial<br>
+=C2=A0 =C2=A0 =C2=A0* set of muxes<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 *be_opened =3D mux_is_opened();<br>
+}<br>
+<br>
+static void qemu_chr_parse_mux_be(QemuOpts *opts, ChardevBackend *backend,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 ChardevMuxBe *mux;<br>
+<br>
+=C2=A0 =C2=A0 backend-&gt;type =3D CHARDEV_BACKEND_KIND_MUX_BE;<br>
+=C2=A0 =C2=A0 mux =3D backend-&gt;u.mux_be.data =3D g_new0(ChardevMuxBe, 1=
);<br>
+=C2=A0 =C2=A0 qemu_chr_parse_common(opts, qapi_ChardevMuxBe_base(mux));<br=
>
+}<br>
+<br>
+static void char_mux_be_class_init(ObjectClass *oc, void *data)<br>
+{<br>
+=C2=A0 =C2=A0 ChardevClass *cc =3D CHARDEV_CLASS(oc);<br>
+<br>
+=C2=A0 =C2=A0 cc-&gt;parse =3D qemu_chr_parse_mux_be;<br>
+=C2=A0 =C2=A0 cc-&gt;open =3D qemu_chr_open_mux_be;<br>
+=C2=A0 =C2=A0 cc-&gt;chr_write =3D mux_be_chr_write;<br>
+=C2=A0 =C2=A0 cc-&gt;chr_add_watch =3D mux_be_chr_add_watch;<br>
+=C2=A0 =C2=A0 cc-&gt;chr_be_event =3D mux_be_chr_be_event;<br>
+=C2=A0 =C2=A0 cc-&gt;chr_update_read_handler =3D mux_be_chr_update_read_ha=
ndlers;<br>
+}<br>
+<br>
+static const TypeInfo char_mux_be_type_info =3D {<br>
+=C2=A0 =C2=A0 .name =3D TYPE_CHARDEV_MUX_BE,<br>
+=C2=A0 =C2=A0 .parent =3D TYPE_CHARDEV,<br>
+=C2=A0 =C2=A0 .class_init =3D char_mux_be_class_init,<br>
+=C2=A0 =C2=A0 .instance_size =3D sizeof(MuxBeChardev),<br>
+=C2=A0 =C2=A0 .instance_finalize =3D char_mux_be_finalize,<br>
+};<br>
+<br>
+static void register_types(void)<br>
+{<br>
+=C2=A0 =C2=A0 type_register_static(&amp;char_mux_be_type_info);<br>
+}<br>
+<br>
+type_init(register_types);<br>
diff --git a/chardev/char.c b/chardev/char.c<br>
index cffe60860589..58fa8ac70a1e 100644<br>
--- a/chardev/char.c<br>
+++ b/chardev/char.c<br>
@@ -341,6 +341,9 @@ static bool qemu_chr_is_busy(Chardev *s)<br>
=C2=A0 =C2=A0 =C2=A0if (CHARDEV_IS_MUX_FE(s)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MuxFeChardev *d =3D MUX_FE_CHARDEV(s);<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return d-&gt;mux_bitset !=3D 0;<br>
+=C2=A0 =C2=A0 } else if (CHARDEV_IS_MUX_BE(s)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 MuxBeChardev *d =3D MUX_BE_CHARDEV(s);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return d-&gt;frontend !=3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return s-&gt;be !=3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
@@ -648,7 +651,8 @@ static Chardev *__qemu_chr_new_from_opts(QemuOpts *opts=
, GMainContext *context,<br>
=C2=A0 =C2=A0 =C2=A0ChardevBackend *backend =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0const char *name =3D qemu_opt_get(opts, &quot;backend&q=
uot;);<br>
=C2=A0 =C2=A0 =C2=A0const char *id =3D qemu_opts_id(opts);<br>
-=C2=A0 =C2=A0 char *bid =3D NULL;<br>
+=C2=A0 =C2=A0 const char *mux_be_id =3D NULL;<br>
+=C2=A0 =C2=A0 char *mux_fe_id =3D NULL;<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (name &amp;&amp; is_help_option(name)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0GString *str =3D g_string_new(&quot;&quot=
;);<br>
@@ -676,10 +680,16 @@ static Chardev *__qemu_chr_new_from_opts(QemuOpts *op=
ts, GMainContext *context,<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (qemu_opt_get_bool(opts, &quot;mux&quot;, 0)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 bid =3D g_strdup_printf(&quot;%s-base&quot;, i=
d);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 mux_fe_id =3D g_strdup_printf(&quot;%s-base&qu=
ot;, id);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 mux_be_id =3D qemu_opt_get(opts, &quot;mux-be-id&quot;);<br>
+=C2=A0 =C2=A0 if (mux_be_id &amp;&amp; mux_fe_id) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;chardev: mux and mux-be=
 can&#39;t be used for the same &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot=
;device&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 chr =3D qemu_chardev_new(bid ? bid : id,<br>
+=C2=A0 =C2=A0 chr =3D qemu_chardev_new(mux_fe_id ? mux_fe_id : id,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 object_class_get_name(OBJECT_CLASS(cc)),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 backend, context, errp);<br>
=C2=A0 =C2=A0 =C2=A0if (chr =3D=3D NULL) {<br>
@@ -687,25 +697,40 @@ static Chardev *__qemu_chr_new_from_opts(QemuOpts *op=
ts, GMainContext *context,<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0base =3D chr;<br>
-=C2=A0 =C2=A0 if (bid) {<br>
+=C2=A0 =C2=A0 if (mux_fe_id) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Chardev *mux;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qapi_free_ChardevBackend(backend);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0backend =3D g_new0(ChardevBackend, 1);<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0backend-&gt;type =3D CHARDEV_BACKEND_KIND=
_MUX;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0backend-&gt;u.mux.data =3D g_new0(Chardev=
Mux, 1);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 backend-&gt;u.mux.data-&gt;chardev =3D g_strdu=
p(bid);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 backend-&gt;u.mux.data-&gt;chardev =3D g_strdu=
p(mux_fe_id);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mux =3D qemu_chardev_new(id, TYPE_CHARDEV=
_MUX_FE, backend, context, errp);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (mux =3D=3D NULL) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 object_unparent(OBJECT(chr));<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 chr =3D NULL;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto unparent_and_out;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0chr =3D mux;<br>
+=C2=A0 =C2=A0 } else if (mux_be_id) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Chardev *s;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s =3D qemu_chr_find(mux_be_id);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!s) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;chardev: =
mux-be device can&#39;t be found by id &#39;%s&#39;&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0mux_be_id);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto unparent_and_out;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!CHARDEV_IS_MUX_BE(s)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;chardev: =
device &#39;%s&#39; is not a multiplexer device&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot; of &#39;mux-be&#39; type&quot;, mux_be_id);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto unparent_and_out;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!mux_be_chr_attach_chardev(MUX_BE_CHARDEV(=
s), chr, errp)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto unparent_and_out;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0out:<br>
=C2=A0 =C2=A0 =C2=A0qapi_free_ChardevBackend(backend);<br>
-=C2=A0 =C2=A0 g_free(bid);<br>
+=C2=A0 =C2=A0 g_free(mux_fe_id);<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (replay &amp;&amp; base) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* RR should be set on the base device, n=
ot the mux */<br>
@@ -713,6 +738,11 @@ out:<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0return chr;<br>
+<br>
+unparent_and_out:<br>
+=C2=A0 =C2=A0 object_unparent(OBJECT(chr));<br>
+=C2=A0 =C2=A0 chr =3D NULL;<br>
+=C2=A0 =C2=A0 goto out;<br>
=C2=A0}<br>
<br>
=C2=A0Chardev *qemu_chr_new_from_opts(QemuOpts *opts, GMainContext *context=
,<br>
@@ -1114,7 +1144,7 @@ ChardevReturn *qmp_chardev_change(const char *id, Cha=
rdevBackend *backend,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return NULL;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 if (CHARDEV_IS_MUX_FE(chr)) {<br>
+=C2=A0 =C2=A0 if (CHARDEV_IS_MUX_FE(chr) || CHARDEV_IS_MUX_BE(chr)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg(errp, &quot;Mux device hotswap=
 not supported yet&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return NULL;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
@@ -1302,7 +1332,7 @@ static int chardev_options_parsed_cb(Object *child, v=
oid *opaque)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0Chardev *chr =3D (Chardev *)child;<br>
<br>
-=C2=A0 =C2=A0 if (!chr-&gt;be_open &amp;&amp; CHARDEV_IS_MUX_FE(chr)) {<br=
>
+=C2=A0 =C2=A0 if (!chr-&gt;be_open &amp;&amp; (CHARDEV_IS_MUX_FE(chr) || C=
HARDEV_IS_MUX_BE(chr))) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0open_muxes(chr);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -1329,8 +1359,10 @@ void mux_chr_send_all_event(Chardev *chr, QEMUChrEve=
nt event)<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (CHARDEV_IS_MUX_FE(chr)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MuxFeChardev *d =3D MUX_FE_CHARDEV(chr);<=
br>
-<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mux_fe_chr_send_all_event(d, event);<br>
+=C2=A0 =C2=A0 } else if (CHARDEV_IS_MUX_BE(chr)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 MuxBeChardev *d =3D MUX_BE_CHARDEV(chr);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 mux_be_chr_send_all_event(d, event);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
diff --git a/chardev/chardev-internal.h b/chardev/chardev-internal.h<br>
index 94c8d07ac235..8ea1258f8ff4 100644<br>
--- a/chardev/chardev-internal.h<br>
+++ b/chardev/chardev-internal.h<br>
@@ -35,7 +35,9 @@<br>
<br>
=C2=A0struct MuxFeChardev {<br>
=C2=A0 =C2=A0 =C2=A0Chardev parent;<br>
+=C2=A0 =C2=A0 /* Linked frontends */<br>
=C2=A0 =C2=A0 =C2=A0CharBackend *backends[MAX_MUX];<br>
+=C2=A0 =C2=A0 /* Linked backend */<br>
=C2=A0 =C2=A0 =C2=A0CharBackend chr;<br></blockquote><div><br></div><div><d=
iv>Maybe a patch to rename those fields would help.<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">
</blockquote>=C2=A0<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">
=C2=A0 =C2=A0 =C2=A0unsigned long mux_bitset;<br>
=C2=A0 =C2=A0 =C2=A0int focus;<br>
@@ -54,10 +56,36 @@ struct MuxFeChardev {<br>
=C2=A0};<br>
=C2=A0typedef struct MuxFeChardev MuxFeChardev;<br>
<br>
+struct MuxBeChardev {<br>
+=C2=A0 =C2=A0 Chardev parent;<br>
+=C2=A0 =C2=A0 /* Linked frontend */<br>
+=C2=A0 =C2=A0 CharBackend *frontend;<br>
+=C2=A0 =C2=A0 /* Linked backends */<br>
+=C2=A0 =C2=A0 CharBackend backends[MAX_MUX];<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* Number of backends attached to this mux. Once attach=
ed, a<br>
+=C2=A0 =C2=A0 =C2=A0* backend can&#39;t be detached, so the counter is onl=
y increasing.<br>
+=C2=A0 =C2=A0 =C2=A0* To safely remove a backend, mux has to be removed fi=
rst.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 unsigned int be_cnt;<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* Counters of written bytes from a single frontend dev=
ice<br>
+=C2=A0 =C2=A0 =C2=A0* to multiple backend devices.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 unsigned int be_written[MAX_MUX];<br>
+=C2=A0 =C2=A0 unsigned int be_min_written;<br>
+};<br>
+typedef struct MuxBeChardev MuxBeChardev;<br>
+<br>
=C2=A0DECLARE_INSTANCE_CHECKER(MuxFeChardev, MUX_FE_CHARDEV,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 TYPE_CHARDEV_MUX_FE)<br>
-#define CHARDEV_IS_MUX_FE(chr)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
+DECLARE_INSTANCE_CHECKER(MuxBeChardev, MUX_BE_CHARDEV,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0TYPE_CHARDEV_MUX_BE)<br>
+<br>
+#define CHARDEV_IS_MUX_FE(chr)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
=C2=A0 =C2=A0 =C2=A0object_dynamic_cast(OBJECT(chr), TYPE_CHARDEV_MUX_FE)<b=
r>
+#define CHARDEV_IS_MUX_BE(chr)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
+=C2=A0 =C2=A0 object_dynamic_cast(OBJECT(chr), TYPE_CHARDEV_MUX_BE)<br>
<br>
=C2=A0void mux_chr_send_all_event(Chardev *chr, QEMUChrEvent event);<br>
<br>
@@ -67,6 +95,10 @@ void mux_fe_chr_send_all_event(MuxFeChardev *d, QEMUChrE=
vent event);<br>
=C2=A0bool mux_fe_chr_attach_frontend(MuxFeChardev *d, CharBackend *b,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int *tag, Error **err=
p);<br>
=C2=A0bool mux_fe_chr_detach_frontend(MuxFeChardev *d, unsigned int tag);<b=
r>
+void mux_be_chr_send_all_event(MuxBeChardev *d, QEMUChrEvent event);<br>
+bool mux_be_chr_attach_chardev(MuxBeChardev *d, Chardev *chr, Error **errp=
);<br>
+bool mux_be_chr_attach_frontend(MuxBeChardev *d, CharBackend *b, Error **e=
rrp);<br>
+void mux_be_chr_detach_frontend(MuxBeChardev *d);<br>
<br>
=C2=A0Object *get_chardevs_root(void);<br>
<br>
diff --git a/chardev/meson.build b/chardev/meson.build<br>
index 778444a00ca6..3a9f5565372b 100644<br>
--- a/chardev/meson.build<br>
+++ b/chardev/meson.build<br>
@@ -3,6 +3,7 @@ chardev_ss.add(files(<br>
=C2=A0 =C2=A0&#39;char-file.c&#39;,<br>
=C2=A0 =C2=A0&#39;char-io.c&#39;,<br>
=C2=A0 =C2=A0&#39;char-mux-fe.c&#39;,<br>
+=C2=A0 &#39;char-mux-be.c&#39;,<br>
=C2=A0 =C2=A0&#39;char-null.c&#39;,<br>
=C2=A0 =C2=A0&#39;char-pipe.c&#39;,<br>
=C2=A0 =C2=A0&#39;char-ringbuf.c&#39;,<br>
diff --git a/include/chardev/char.h b/include/chardev/char.h<br>
index 0bec974f9d73..c58c11c4eeaf 100644<br>
--- a/include/chardev/char.h<br>
+++ b/include/chardev/char.h<br>
@@ -232,6 +232,7 @@ OBJECT_DECLARE_TYPE(Chardev, ChardevClass, CHARDEV)<br>
<br>
=C2=A0#define TYPE_CHARDEV_NULL &quot;chardev-null&quot;<br>
=C2=A0#define TYPE_CHARDEV_MUX_FE &quot;chardev-mux&quot;<br>
+#define TYPE_CHARDEV_MUX_BE &quot;chardev-mux-be&quot;<br>
=C2=A0#define TYPE_CHARDEV_RINGBUF &quot;chardev-ringbuf&quot;<br>
=C2=A0#define TYPE_CHARDEV_PTY &quot;chardev-pty&quot;<br>
=C2=A0#define TYPE_CHARDEV_CONSOLE &quot;chardev-console&quot;<br>
diff --git a/qapi/char.json b/qapi/char.json<br>
index fb0dedb24383..cdec8f9cf4e2 100644<br>
--- a/qapi/char.json<br>
+++ b/qapi/char.json<br>
@@ -336,6 +336,17 @@<br>
=C2=A0 =C2=A0&#39;data&#39;: { &#39;chardev&#39;: &#39;str&#39; },<br>
=C2=A0 =C2=A0&#39;base&#39;: &#39;ChardevCommon&#39; }<br>
<br>
+##<br>
+# @ChardevMuxBe:<br>
+#<br>
+# Configuration info for mux-be chardevs.<br>
+#<br>
+# Since: 9.2<br>
+##<br>
+{ &#39;struct&#39;: &#39;ChardevMuxBe&#39;,<br>
+=C2=A0 &#39;data&#39;: { },<br>
+=C2=A0 &#39;base&#39;: &#39;ChardevCommon&#39; }<br>
+<br>
=C2=A0##<br>
=C2=A0# @ChardevStdio:<br>
=C2=A0#<br>
@@ -483,6 +494,8 @@<br>
=C2=A0#<br>
=C2=A0# @mux: (since 1.5)<br>
=C2=A0#<br>
+# @mux-be: (since 9.2)<br>
+#<br>
=C2=A0# @msmouse: emulated Microsoft serial mouse (since 1.5)<br>
=C2=A0#<br>
=C2=A0# @wctablet: emulated Wacom Penpartner serial tablet (since 2.9)<br>
@@ -525,6 +538,7 @@<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;pty&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;null&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;mux&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;mux-be&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;msmouse&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;wctablet&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ &#39;name&#39;: &#39;brai=
lle&#39;, &#39;if&#39;: &#39;CONFIG_BRLAPI&#39; },<br>
@@ -599,6 +613,16 @@<br>
=C2=A0{ &#39;struct&#39;: &#39;ChardevMuxWrapper&#39;,<br>
=C2=A0 =C2=A0&#39;data&#39;: { &#39;data&#39;: &#39;ChardevMux&#39; } }<br>
<br>
+##<br>
+# @ChardevMuxBeWrapper:<br>
+#<br>
+# @data: Configuration info for mux-be chardevs<br>
+#<br>
+# Since: 9.2<br>
+##<br>
+{ &#39;struct&#39;: &#39;ChardevMuxBeWrapper&#39;,<br>
+=C2=A0 &#39;data&#39;: { &#39;data&#39;: &#39;ChardevMuxBe&#39; } }<br>
+<br>
=C2=A0##<br>
=C2=A0# @ChardevStdioWrapper:<br>
=C2=A0#<br>
@@ -707,6 +731,7 @@<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;pty&#39;: &#39;Chardev=
PtyWrapper&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;null&#39;: &#39;Charde=
vCommonWrapper&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;mux&#39;: &#39;Chardev=
MuxWrapper&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;mux-be&#39;: &#39;ChardevMu=
xBeWrapper&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;msmouse&#39;: &#39;Cha=
rdevCommonWrapper&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;wctablet&#39;: &#39;Ch=
ardevCommonWrapper&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;braille&#39;: { &#39;t=
ype&#39;: &#39;ChardevCommonWrapper&#39;,<br>
-- <br>
2.34.1<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>
</div>
</div>

--000000000000eccf0e0624962ae5--

