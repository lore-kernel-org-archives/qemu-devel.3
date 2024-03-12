Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BA24C54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 12:40:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk1QG-0008Oe-0g; Tue, 12 Mar 2024 08:40:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rk1QE-0008OT-PI
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 08:39:58 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rk1QC-0007j5-Sp
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 08:39:58 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-609fd5fbe50so50803567b3.0
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 05:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710247195; x=1710851995; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kd6b7rkmsERSw6BwiI36hWulnDYIexDsyLOuH1h5qeY=;
 b=gMibUGHDR7EHKB1WmURV1uBYSbHAqXgzcvjzj6OvAW0ifQIqtMT3sJp82usZ23anC/
 uS+T2nRRGKhUJclh9jQy6vLYUIlm88Okcd/9xw0va7o9RfUjb7DsiTbCSzyEvvD8kX0S
 Z0yA70kTYc4KEaE8pO5LDUy+8FFcqAN1SE8D9sxujHPhuNUiHVCrQfjGLMDI+FFbPit/
 y5XeT+3cfflZyIzL5dz1sb/vC/Yw7naemy+6BzPi+pI11+MYtn6m1BfhOc8mDUq7GWIC
 APN2aTvwlr95f4qlywnWKjnAuq1O5HownYI8gPk97w+6TKjlWLvYX89LsirJvIec4HGL
 sMMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710247195; x=1710851995;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kd6b7rkmsERSw6BwiI36hWulnDYIexDsyLOuH1h5qeY=;
 b=RcwTii87ezANv/XW/ZH7B8sQXyF1GivoWswO0b2Z0ib2rlIDmS8PW01KdXhUQajlnC
 VHUPLJN7HPk6NsZOvK/Q2uVUVY/BNIcz7s6TWF7+9lnKj1YgfDES3fAn0nCXwUy5Mcz9
 pUHjOEQ5RFZkLlJK7fY9vJJtjTbqZC6bqcKss/4v/s2O0vAqKdcppanPZgskuGpLmKXV
 54MQjAVILu4E9C3ck9GkyBgU4kYUjsY9RiqgMt1+c2lHv3wSlwD/ikaH2ErddHdRKPlp
 4Menk6crO6R6qVjK8N948Leo/hreKoWQJX3HYN319tH2EAjHUQL+CtgNwemsUfBwfB3h
 R3Vg==
X-Gm-Message-State: AOJu0YyvDg+1/WDB67mqt2d7FPJqdA3omGjLwEgVGhLsg2TCWV10DcI/
 8s4glr4C2oAQ4Tsc2opL+0wnaZwdpBV4PuIj55vy8+jtvbsWz7nbPCJvcnrkJj6hzlNShgnICBh
 hREFpnF+cNTtJ97FXjDEu6R+tsL8=
X-Google-Smtp-Source: AGHT+IFySWIhAiauyyYIHjbBW/DbCbO7CEdgF+qdeNKluJUKQshNeOA1HAT0IvSRGk0oQBLmM6DULPdnR+G1LTAyEvQ=
X-Received: by 2002:a25:2fd1:0:b0:dc7:347e:c6f4 with SMTP id
 v200-20020a252fd1000000b00dc7347ec6f4mr3284896ybv.32.1710247195393; Tue, 12
 Mar 2024 05:39:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240311174026.2177152-1-npiggin@gmail.com>
 <20240311174026.2177152-7-npiggin@gmail.com>
In-Reply-To: <20240311174026.2177152-7-npiggin@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 12 Mar 2024 16:39:43 +0400
Message-ID: <CAJ+F1CKmgTCZfvWAfHOOAx7ne=5NFQC-pmdyvmECX3syXf9-=g@mail.gmail.com>
Subject: Re: [PATCH v4 06/24] chardev: set record/replay on the base device of
 a muxed device
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-yw1-x1134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi

On Mon, Mar 11, 2024 at 9:44=E2=80=AFPM Nicholas Piggin <npiggin@gmail.com>=
 wrote:
>
> chardev events to a muxed device don't get recorded because e.g.,
> qemu_chr_be_write() checks whether the base device has the record flag
> set.
>
> This can be seen when replaying a trace that has characters typed into
> the console, an examination of the log shows they are not recorded.
>
> Setting QEMU_CHAR_FEATURE_REPLAY on the base chardev fixes the problem.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  chardev/char.c | 71 +++++++++++++++++++++++++++++++++++---------------
>  1 file changed, 50 insertions(+), 21 deletions(-)
>
> diff --git a/chardev/char.c b/chardev/char.c
> index 3c43fb1278..ba847b6e9e 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -615,11 +615,24 @@ ChardevBackend *qemu_chr_parse_opts(QemuOpts *opts,=
 Error **errp)
>      return backend;
>  }
>
> -Chardev *qemu_chr_new_from_opts(QemuOpts *opts, GMainContext *context,
> -                                Error **errp)
> +static void qemu_chardev_set_replay(Chardev *chr, Error **errp)
> +{
> +    if (replay_mode !=3D REPLAY_MODE_NONE) {
> +        if (CHARDEV_GET_CLASS(chr)->chr_ioctl) {
> +            error_setg(errp, "Replay: ioctl is not supported "
> +                             "for serial devices yet");
> +            return;

You are changing the behaviour, the previous code was just printing an
error, but let it go. I think you should make this a separate change.

> +        }
> +        qemu_chr_set_feature(chr, QEMU_CHAR_FEATURE_REPLAY);
> +        replay_register_char_driver(chr);
> +    }
> +}
> +
> +static Chardev *__qemu_chr_new_from_opts(QemuOpts *opts, GMainContext *c=
ontext,
> +                                         bool replay, Error **errp)

Having so many chr_new functions is starting to really damage
readability. Also don't use '__' prefix for global symbols, they are
reserved.

>  {>      const ChardevClass *cc;
> -    Chardev *chr =3D NULL;
> +    Chardev *base =3D NULL, *chr =3D NULL;
>      ChardevBackend *backend =3D NULL;
>      const char *name =3D qemu_opt_get(opts, "backend");
>      const char *id =3D qemu_opts_id(opts);
> @@ -657,11 +670,11 @@ Chardev *qemu_chr_new_from_opts(QemuOpts *opts, GMa=
inContext *context,
>      chr =3D qemu_chardev_new(bid ? bid : id,
>                             object_class_get_name(OBJECT_CLASS(cc)),
>                             backend, context, errp);
> -
>      if (chr =3D=3D NULL) {
>          goto out;
>      }
>
> +    base =3D chr;
>      if (bid) {
>          Chardev *mux;
>          qapi_free_ChardevBackend(backend);
> @@ -681,11 +694,25 @@ Chardev *qemu_chr_new_from_opts(QemuOpts *opts, GMa=
inContext *context,
>  out:
>      qapi_free_ChardevBackend(backend);
>      g_free(bid);
> +
> +    if (replay && base) {
> +        /* RR should be set on the base device, not the mux */
> +        qemu_chardev_set_replay(base, errp);
> +    }
> +
>      return chr;
>  }
>
> -Chardev *qemu_chr_new_noreplay(const char *label, const char *filename,
> -                               bool permit_mux_mon, GMainContext *contex=
t)
> +Chardev *qemu_chr_new_from_opts(QemuOpts *opts, GMainContext *context,
> +                                Error **errp)
> +{
> +    /* XXX: should this really not record/replay? */

I don't understand the context here, make it a different commit to explain?

> +    return __qemu_chr_new_from_opts(opts, context, false, errp);
> +}
> +
> +static Chardev *__qemu_chr_new(const char *label, const char *filename,
> +                               bool permit_mux_mon, GMainContext *contex=
t,
> +                               bool replay)
>  {
>      const char *p;
>      Chardev *chr;
> @@ -693,14 +720,22 @@ Chardev *qemu_chr_new_noreplay(const char *label, c=
onst char *filename,
>      Error *err =3D NULL;
>
>      if (strstart(filename, "chardev:", &p)) {
> -        return qemu_chr_find(p);
> +        chr =3D qemu_chr_find(p);
> +        if (replay) {
> +            qemu_chardev_set_replay(chr, &err);
> +            if (err) {
> +                error_report_err(err);
> +                return NULL;
> +            }
> +        }
> +        return chr;
>      }
>
>      opts =3D qemu_chr_parse_compat(label, filename, permit_mux_mon);
>      if (!opts)
>          return NULL;
>
> -    chr =3D qemu_chr_new_from_opts(opts, context, &err);
> +    chr =3D __qemu_chr_new_from_opts(opts, context, replay, &err);
>      if (!chr) {
>          error_report_err(err);
>          goto out;
> @@ -722,24 +757,18 @@ out:
>      return chr;
>  }
>
> +Chardev *qemu_chr_new_noreplay(const char *label, const char *filename,
> +                               bool permit_mux_mon, GMainContext *contex=
t)
> +{
> +    return __qemu_chr_new(label, filename, permit_mux_mon, context, fals=
e);
> +}
> +
>  static Chardev *qemu_chr_new_permit_mux_mon(const char *label,
>                                            const char *filename,
>                                            bool permit_mux_mon,
>                                            GMainContext *context)
>  {
> -    Chardev *chr;
> -    chr =3D qemu_chr_new_noreplay(label, filename, permit_mux_mon, conte=
xt);
> -    if (chr) {
> -        if (replay_mode !=3D REPLAY_MODE_NONE) {
> -            qemu_chr_set_feature(chr, QEMU_CHAR_FEATURE_REPLAY);
> -        }
> -        if (qemu_chr_replay(chr) && CHARDEV_GET_CLASS(chr)->chr_ioctl) {
> -            error_report("Replay: ioctl is not supported "
> -                         "for serial devices yet");
> -        }
> -        replay_register_char_driver(chr);
> -    }
> -    return chr;
> +    return __qemu_chr_new(label, filename, permit_mux_mon, context, true=
);
>  }
>
>  Chardev *qemu_chr_new(const char *label, const char *filename,
> --
> 2.42.0
>
>

It's probably too late for 9.0, splitting the patch and preliminary
cleanup should really help reviewing the change and pointing out the
behaviour differences.

thanks




--=20
Marc-Andr=C3=A9 Lureau

