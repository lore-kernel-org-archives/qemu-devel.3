Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5139BC36002
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 03:17:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twump-0000cu-P5; Mon, 24 Mar 2025 23:17:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuq825@gmail.com>) id 1twumW-0000bx-3Y
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 23:16:53 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuq825@gmail.com>) id 1twumU-0001zU-F7
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 23:16:47 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5eb92df4fcbso8056010a12.0
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 20:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742872604; x=1743477404; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SZEwSk9fNZbLYv00fIcAh9p31NNYErWCQTT8OjM5gSk=;
 b=FDn0oU8GB0HfM3ZD1MGC1/apK0gg/wxjg47Mg6cLClXwK6/GD2PFbdXHdGW4Iy/owm
 Su4ZH4wnWhdUT23TI3mZy3ea4RE3uKX7lnILg0njwgTh6Ztuu/XW6ggkIRJiGlO0lFKv
 klWQZhgoqnjYPiRa1wE0Y1AzBbsVp85Iah/MBVxtZYmNsztKAbuF016CeSqYVUYcW6cH
 jvogZhBofvrQuWHA6cUXQClt7k4BAc9lslJLVyahYAAj7//wOW8Pb+TQ9GdTMWycoqXE
 +DWy1vFCSiP/TXOhEZhCmvuNiJBiiy3D5gm93Sr+xrlHORXWhk4yd6rwXWQJSQmJh7Ox
 oWdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742872604; x=1743477404;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SZEwSk9fNZbLYv00fIcAh9p31NNYErWCQTT8OjM5gSk=;
 b=ZqFx8dbd3kTW4gdpUclBrW+E0IDoYB4fXZdsypg9bmjS7+0dy5KLQGAyqt0AdXeEf0
 LdCUChw9gWo3abzEUUiEf27K+Fg4MTsK2GH65emBneSPItxfQm0I8HtDg0mQdafF3P3t
 RdU3C0dYdlrIWaxm9OLSatl0KgH3867XE4tLVTX4nX1TAgHrS99QN2rHMy8A9pWEuhmZ
 tSfPkKw7nQoISkwuToAQxEn64J85mAvnjlO57VzHDS1Y4LPhfmOU29RCgBGiiiGeC+3d
 JwV8YRMwUlH8sb/SOCsAsIJZKqxMeGeDZgBBngJRUtis+ttIrAQWNoN2RxS37caO8p1W
 YYbA==
X-Gm-Message-State: AOJu0YyWNTGg9wUGH6cei9WsmEzU1kl5Y0jmlEOatWety+rOUrAbqJCA
 kacwKhv2nYiMXuieSJpQyRjOcOT/6oncXHarkASoo2lHW8Uq2B6ZEDaGspdfQvYYpt5o0dAgIPR
 0UAQSa97bBj8oFRZR7GQ7428xyB+rnDd97iM=
X-Gm-Gg: ASbGncsFfpVMI7vUwygCKiDqe1RbPc3DVLzdB52luuiUGAdUTUBS5CyM4Sth+ZnXfTO
 uMjvMqNW2JOkW/iM4nL4KDZltpMuLZGZboakDIKRkAlKsJ1jUmnRQyU1EsYQ6M9dA6RD13mAwjS
 auVy9li2D+PHPJy1zbA/MlYpkROGO+uBttLC8N0g==
X-Google-Smtp-Source: AGHT+IG/aWEj1lGpfGQnf6T8sQcJhR3pBAX+x2ii5HxcGSMfdqHeOMYUaWlZFY+tGopbvqAiKlEWLMwNkUVp3y4fMTA=
X-Received: by 2002:a05:6402:3582:b0:5e6:23c:a242 with SMTP id
 4fb4d7f45d1cf-5ebcd45b3e6mr16141626a12.18.1742872603742; Mon, 24 Mar 2025
 20:16:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250324081922.359369-1-yuq825@gmail.com>
 <20250324081922.359369-3-yuq825@gmail.com>
 <CAMxuvazW2TEFm-6GMZiNO25JuSKxAupa2N=fPR9n_6ibTadCHg@mail.gmail.com>
 <CAKGbVbstavT+dk=d4WwhTA4obOsvhfvrx8=6_pgXaQs8PH-GoQ@mail.gmail.com>
 <CAJ+F1C+tKcdFDwaJG+Sk3rmDS0KE92-cJb-bkH8uZk5_8_EqnQ@mail.gmail.com>
In-Reply-To: <CAJ+F1C+tKcdFDwaJG+Sk3rmDS0KE92-cJb-bkH8uZk5_8_EqnQ@mail.gmail.com>
From: Qiang Yu <yuq825@gmail.com>
Date: Tue, 25 Mar 2025 11:16:32 +0800
X-Gm-Features: AQ5f1JoEFFB_PiDvElDLwDF4MvSY5wYjIEVdj5gGI2flBxrlvZ2sR8ylQF_Hyu8
Message-ID: <CAKGbVbt4QKg8UPsY04jkX5XoXTu4AtC-2ZYNnJzVEc0tC4BmDw@mail.gmail.com>
Subject: Re: [PATCH 2/6] ui/egl: require EGL_EXT_image_dma_buf_import_modifiers
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=yuq825@gmail.com; helo=mail-ed1-x529.google.com
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

On Mon, Mar 24, 2025 at 9:45=E2=80=AFPM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
>
> Hi
>
> On Mon, Mar 24, 2025 at 5:27=E2=80=AFPM Qiang Yu <yuq825@gmail.com> wrote=
:
> >
> > On Mon, Mar 24, 2025 at 6:09=E2=80=AFPM Marc-Andr=C3=A9 Lureau
> > <marcandre.lureau@redhat.com> wrote:
> > >
> > > Hi
> > >
> > > On Mon, Mar 24, 2025 at 12:19=E2=80=AFPM <yuq825@gmail.com> wrote:
> > > >
> > > > From: Qiang Yu <yuq825@gmail.com>
> > > >
> > > > It's used already, just check it explicitly.
> > > >
> > > > Signed-off-by: Qiang Yu <yuq825@gmail.com>
> > > > ---
> > > >  ui/egl-helpers.c | 10 ++++++----
> > > >  1 file changed, 6 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
> > > > index 72a1405782..45b1b0b700 100644
> > > > --- a/ui/egl-helpers.c
> > > > +++ b/ui/egl-helpers.c
> > > > @@ -257,6 +257,11 @@ int egl_rendernode_init(const char *rendernode=
, DisplayGLMode mode)
> > > >          error_report("egl: EGL_MESA_image_dma_buf_export not suppo=
rted");
> > > >          goto err;
> > > >      }
> > > > +    if (!epoxy_has_egl_extension(qemu_egl_display,
> > > > +                                 "EGL_EXT_image_dma_buf_import_mod=
ifiers")) {
> > > > +        error_report("egl: EGL_EXT_image_dma_buf_import_modifiers =
not supported");
> > > > +        goto err;
> > > > +    }
> > > >
> > > >      qemu_egl_rn_ctx =3D qemu_egl_init_ctx();
> > > >      if (!qemu_egl_rn_ctx) {
> > > > @@ -308,7 +313,7 @@ void egl_dmabuf_import_texture(QemuDmaBuf *dmab=
uf)
> > > >      EGLImageKHR image =3D EGL_NO_IMAGE_KHR;
> > > >      EGLint attrs[64];
> > > >      int i =3D 0;
> > > > -    uint64_t modifier;
> > > > +    uint64_t modifier =3D qemu_dmabuf_get_modifier(dmabuf);
> > > >      uint32_t texture =3D qemu_dmabuf_get_texture(dmabuf);
> > > >
> > > >      if (texture !=3D 0) {
> > > > @@ -328,15 +333,12 @@ void egl_dmabuf_import_texture(QemuDmaBuf *dm=
abuf)
> > > >      attrs[i++] =3D qemu_dmabuf_get_stride(dmabuf)[0];
> > > >      attrs[i++] =3D EGL_DMA_BUF_PLANE0_OFFSET_EXT;
> > > >      attrs[i++] =3D 0;
> > > > -#ifdef EGL_DMA_BUF_PLANE0_MODIFIER_LO_EXT
> > >
> > > We should check for that define during meson.build when gbm.found(),
> > > to avoid potential later build errors.
> > >
> > This macro should be in EGL header for many years as this is a 2015 EGL
> > extension. Check the macro in meson.build is not necessary now like you
> > won't check all other EGL macros like EGL_DMA_BUF_PLANE0_OFFSET_EXT.
>
> Imho we should still check for those macros, as they are extensions to eg=
l.
>
Macros like EGL_DMA_BUF_PLANE0_OFFSET_EXT are also from EGL extension
but we don't check them. EGL_DMA_BUF_PLANE0_MODIFIER_LO_EXT makes
no difference. And we do need this macro to be always present to make
sure exporter
and importer of the texture to work correctly.

>
> --
> Marc-Andr=C3=A9 Lureau

