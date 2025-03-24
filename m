Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0B52C36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 13:23:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twhls-0003gK-Ps; Mon, 24 Mar 2025 09:23:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuq825@gmail.com>) id 1twhlh-0003UV-SA
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 09:23:11 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuq825@gmail.com>) id 1twhlf-0007c5-Hb
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 09:23:05 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5dc89df7eccso7547425a12.3
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 06:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742822580; x=1743427380; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6V9b+e5TnZX8SmmSmRm+wweSQvJUQFhirzjsahzPxkA=;
 b=daZuJul0VFnXFcXxhHeqj7qcClqr1ztouttRxIv0eCMTwgLV1E8nvZrUZ2cO82g58b
 nfragaEw6KpPOgdQ/wqExhvSC9/jTXNlYXkQw0LfBR46BZJQr/n9tz94rGN3nx3beny1
 7Yn/xaFYjjxKqB3w0qI6/Sh8zUyvNclEtVz55UGH8LTkHMrKfflyNJp6xAH3VcVGBOnd
 J+UR/n2+G1P1nT9W9wcF/M+fWTwCZp6ens6/07GDzzsKeUNJY2C34d5DWuj//MUcgqqM
 ezpWFEUTx/RZkh0sg1g6qtCiGSvYn2mIQIN5Y6eFmb38cZhY/VcQXI0GC6xYPJ77HaXL
 DRZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742822580; x=1743427380;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6V9b+e5TnZX8SmmSmRm+wweSQvJUQFhirzjsahzPxkA=;
 b=iiAv7g9M9MlF6SQJ6pZSIEi6825/J40YoDICAEsFiFojdvhK7ZQqRJNAP2a3DuK9xg
 Pe2QGBpv5bjjeUKe+7gZh/CAWq3uouhtV1p0us7XqBeKQGM45t4Xh4y7/n5T8zelE6aJ
 0Xt7VsuajT0AzLTOMTgqGs3VNMdv6YWs4/5Ld58UJGMRphvPHBwPeyQd0zUocAUTu0h/
 XAO6zdAY++3K0+vKuo85FyW2cpH+yloJBbhiij9GbvsiGtmeiltlwlEhEEkYIj1M2lzR
 NQdQmhOtFyPxCwBILjaZqdgT8ufG2EVscrqLhq0b+pXyuM+JRYRYaBh0GBIdT5LqdrnU
 NJXA==
X-Gm-Message-State: AOJu0YwF1bJjbWNgST3epInZ02CliQrYIp9lxgcu4YvkXTYgo8EEg0Kg
 WRg0eE98tqVmXIzSnR51rcAgXOe7FfT64fMhI7vCi5xoh1qiQPeAJGhY5YXHUHtqDNWSAPydglF
 q3du1mNiDVo/q1PiRci1Nw5QaCgzISm14umM=
X-Gm-Gg: ASbGnctYl66Wo1qXRrdYnlwd/8tzyGVRaU4GqGyh5qLEZ4Ry2yrfrU7ktdf4sx0807C
 cK+EdF4IATAXS1YGtmmK4AjF+DLvQFr8CZ0fUOgdzMqJBs15BaQPq/kH+kJsbbcyt4B3inyV3as
 VYW356J0JOQFVDVraI8XCJQMFG8i8=
X-Google-Smtp-Source: AGHT+IGiAWjLW7P+bcNH05rv+c2AkKxXrM55aCY7zWBsIaShlbWzjvy+WritBR7lAya8KllCxATqtObk8YulU77SIck=
X-Received: by 2002:a05:6402:849:b0:5e5:3643:c8b5 with SMTP id
 4fb4d7f45d1cf-5ebcd51c823mr11226631a12.30.1742822580177; Mon, 24 Mar 2025
 06:23:00 -0700 (PDT)
MIME-Version: 1.0
References: <20250324081922.359369-1-yuq825@gmail.com>
 <20250324081922.359369-3-yuq825@gmail.com>
 <CAMxuvazW2TEFm-6GMZiNO25JuSKxAupa2N=fPR9n_6ibTadCHg@mail.gmail.com>
In-Reply-To: <CAMxuvazW2TEFm-6GMZiNO25JuSKxAupa2N=fPR9n_6ibTadCHg@mail.gmail.com>
From: Qiang Yu <yuq825@gmail.com>
Date: Mon, 24 Mar 2025 21:22:48 +0800
X-Gm-Features: AQ5f1JqgxAAoR_6GDTywS35K2wV1bF5UU932SAeFZS0lBZI7o7uXAb7g7esmEho
Message-ID: <CAKGbVbstavT+dk=d4WwhTA4obOsvhfvrx8=6_pgXaQs8PH-GoQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] ui/egl: require EGL_EXT_image_dma_buf_import_modifiers
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=yuq825@gmail.com; helo=mail-ed1-x534.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Mon, Mar 24, 2025 at 6:09=E2=80=AFPM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Hi
>
> On Mon, Mar 24, 2025 at 12:19=E2=80=AFPM <yuq825@gmail.com> wrote:
> >
> > From: Qiang Yu <yuq825@gmail.com>
> >
> > It's used already, just check it explicitly.
> >
> > Signed-off-by: Qiang Yu <yuq825@gmail.com>
> > ---
> >  ui/egl-helpers.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
> > index 72a1405782..45b1b0b700 100644
> > --- a/ui/egl-helpers.c
> > +++ b/ui/egl-helpers.c
> > @@ -257,6 +257,11 @@ int egl_rendernode_init(const char *rendernode, Di=
splayGLMode mode)
> >          error_report("egl: EGL_MESA_image_dma_buf_export not supported=
");
> >          goto err;
> >      }
> > +    if (!epoxy_has_egl_extension(qemu_egl_display,
> > +                                 "EGL_EXT_image_dma_buf_import_modifie=
rs")) {
> > +        error_report("egl: EGL_EXT_image_dma_buf_import_modifiers not =
supported");
> > +        goto err;
> > +    }
> >
> >      qemu_egl_rn_ctx =3D qemu_egl_init_ctx();
> >      if (!qemu_egl_rn_ctx) {
> > @@ -308,7 +313,7 @@ void egl_dmabuf_import_texture(QemuDmaBuf *dmabuf)
> >      EGLImageKHR image =3D EGL_NO_IMAGE_KHR;
> >      EGLint attrs[64];
> >      int i =3D 0;
> > -    uint64_t modifier;
> > +    uint64_t modifier =3D qemu_dmabuf_get_modifier(dmabuf);
> >      uint32_t texture =3D qemu_dmabuf_get_texture(dmabuf);
> >
> >      if (texture !=3D 0) {
> > @@ -328,15 +333,12 @@ void egl_dmabuf_import_texture(QemuDmaBuf *dmabuf=
)
> >      attrs[i++] =3D qemu_dmabuf_get_stride(dmabuf)[0];
> >      attrs[i++] =3D EGL_DMA_BUF_PLANE0_OFFSET_EXT;
> >      attrs[i++] =3D 0;
> > -#ifdef EGL_DMA_BUF_PLANE0_MODIFIER_LO_EXT
>
> We should check for that define during meson.build when gbm.found(),
> to avoid potential later build errors.
>
This macro should be in EGL header for many years as this is a 2015 EGL
extension. Check the macro in meson.build is not necessary now like you
won't check all other EGL macros like EGL_DMA_BUF_PLANE0_OFFSET_EXT.

> > -    modifier =3D qemu_dmabuf_get_modifier(dmabuf);
> >      if (modifier) {
> >          attrs[i++] =3D EGL_DMA_BUF_PLANE0_MODIFIER_LO_EXT;
> >          attrs[i++] =3D (modifier >>  0) & 0xffffffff;
> >          attrs[i++] =3D EGL_DMA_BUF_PLANE0_MODIFIER_HI_EXT;
> >          attrs[i++] =3D (modifier >> 32) & 0xffffffff;
> >      }
> > -#endif
> >      attrs[i++] =3D EGL_NONE;
> >
> >      image =3D eglCreateImageKHR(qemu_egl_display,
> > --
> > 2.43.0
> >
>

