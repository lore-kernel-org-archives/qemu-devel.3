Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 270AAC36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 13:46:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twi7I-0002hN-VJ; Mon, 24 Mar 2025 09:45:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1twi7G-0002gd-9j
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 09:45:22 -0400
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1twi7B-0002QV-R2
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 09:45:20 -0400
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-477282401b3so26317151cf.1
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 06:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742823916; x=1743428716; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zeYaLsvBO05QzINoDuxc2VpCJLhNa0PZPHCOzM/54Hs=;
 b=FZ/CMuA3YfJQ5Kci4U0LW+K+zCdnufTS6l0kMqxC4WDvUI2iGKvHiDb7SucaBnboCA
 +Oxv8kTJz9YCm7+k6NZC0plPCU6vUYBwpWhFpXuocHMtQumZVWKXQgBvLDvMRcNdi6KZ
 hUgGijZy5MLUozKFDCwCWSJ5NTwvRJEhfC65YwiFsgxqKKy6HXYI6lmF/AGrFDNb6YCM
 eFfqETTepDCeLa3Ox8EWJO/LiEDMIj4EY2ksoiV7WevFTcUE7a9rG2vKMPVXzG7ENmy/
 SvF/8wbJree4O4CB5gTS5puSXY25k4ZMyYdrpZo0SDYwnicLyUfYz3g149wX1lL8mwol
 su/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742823916; x=1743428716;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zeYaLsvBO05QzINoDuxc2VpCJLhNa0PZPHCOzM/54Hs=;
 b=gpDaZibCP9v0vg+iXSTDANKxZnD1EEnMW4iLdZpb+zbsDRyFJJ8axcAfXjUMkjYQm9
 OhYHLABdcTd2mm7YhWYh32krYHX2a+eSiloESD9NjsRbCWSIXKRIlVjsLa2rJycyFkrJ
 Eu+zdh5KXjTx6mX/Chj0eqS9eT0Me+ixX/PMYIRRI1JxxiHjen4Puv3ulFFXWhE975C3
 gteiNva2rUqlOHLcwyuX+4i8yG6sm+fHwkrgBGSVmIxHDbqTtNyEK8xEeIRu4gsZVCoq
 Wsg6YHTz86EFZkTOk4vIAx31MhlE/8dU4q5XTQdetgWR0spPwJmZfh5NTYeChEPJMjC/
 5G5A==
X-Gm-Message-State: AOJu0Yz0vLMzTATaKJEQ9d/1SXSeQrVRDo7JchOXWf61adU7JX31hpha
 rYsEsTLbbNn/PbfBY3vffLdbxO8WKBUvhI618P0YYjbwcXjnN7VdamrP6Pv0XzMV2FCfonybo9+
 5NRO4LVBUi8ujuwTs1DOq75D3YM8=
X-Gm-Gg: ASbGncuXnNV08U5WkvQWkI+g56uPWVkNJo/Spq2CIQx0DK5UyBBb/PrgjtSCnTUNUZ1
 JKkvooUNucb8TnoYZc4xf5Q3M+IRNiPNFK5iU/vNDLAxViv26RWKizb+09pKbKd3FDfuJlaIobP
 roxGmI/JBO2g95K963Mt0HxtujSQiMZCm5V9AQT8l57t9wnJx8W35iLrDs+i4=
X-Google-Smtp-Source: AGHT+IGsZ2Jvr4v85mqpyvLR4pQKFIaUHXe+lD7j3ef0VrvC1Ffro6LW3A+ACal08EnDun9Txl57NOOWoX0p4RC7sxQ=
X-Received: by 2002:a05:622a:22aa:b0:476:7f5c:e304 with SMTP id
 d75a77b69052e-4771dd7038dmr199975581cf.19.1742823915890; Mon, 24 Mar 2025
 06:45:15 -0700 (PDT)
MIME-Version: 1.0
References: <20250324081922.359369-1-yuq825@gmail.com>
 <20250324081922.359369-3-yuq825@gmail.com>
 <CAMxuvazW2TEFm-6GMZiNO25JuSKxAupa2N=fPR9n_6ibTadCHg@mail.gmail.com>
 <CAKGbVbstavT+dk=d4WwhTA4obOsvhfvrx8=6_pgXaQs8PH-GoQ@mail.gmail.com>
In-Reply-To: <CAKGbVbstavT+dk=d4WwhTA4obOsvhfvrx8=6_pgXaQs8PH-GoQ@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 24 Mar 2025 17:45:03 +0400
X-Gm-Features: AQ5f1JqFJmFneq_QUQeMQIglLflj-X5SqzY5mHEkJRfsvX0fVBYcxlpt6psOvHY
Message-ID: <CAJ+F1C+tKcdFDwaJG+Sk3rmDS0KE92-cJb-bkH8uZk5_8_EqnQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] ui/egl: require EGL_EXT_image_dma_buf_import_modifiers
To: Qiang Yu <yuq825@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::831;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x831.google.com
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

Hi

On Mon, Mar 24, 2025 at 5:27=E2=80=AFPM Qiang Yu <yuq825@gmail.com> wrote:
>
> On Mon, Mar 24, 2025 at 6:09=E2=80=AFPM Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@redhat.com> wrote:
> >
> > Hi
> >
> > On Mon, Mar 24, 2025 at 12:19=E2=80=AFPM <yuq825@gmail.com> wrote:
> > >
> > > From: Qiang Yu <yuq825@gmail.com>
> > >
> > > It's used already, just check it explicitly.
> > >
> > > Signed-off-by: Qiang Yu <yuq825@gmail.com>
> > > ---
> > >  ui/egl-helpers.c | 10 ++++++----
> > >  1 file changed, 6 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
> > > index 72a1405782..45b1b0b700 100644
> > > --- a/ui/egl-helpers.c
> > > +++ b/ui/egl-helpers.c
> > > @@ -257,6 +257,11 @@ int egl_rendernode_init(const char *rendernode, =
DisplayGLMode mode)
> > >          error_report("egl: EGL_MESA_image_dma_buf_export not support=
ed");
> > >          goto err;
> > >      }
> > > +    if (!epoxy_has_egl_extension(qemu_egl_display,
> > > +                                 "EGL_EXT_image_dma_buf_import_modif=
iers")) {
> > > +        error_report("egl: EGL_EXT_image_dma_buf_import_modifiers no=
t supported");
> > > +        goto err;
> > > +    }
> > >
> > >      qemu_egl_rn_ctx =3D qemu_egl_init_ctx();
> > >      if (!qemu_egl_rn_ctx) {
> > > @@ -308,7 +313,7 @@ void egl_dmabuf_import_texture(QemuDmaBuf *dmabuf=
)
> > >      EGLImageKHR image =3D EGL_NO_IMAGE_KHR;
> > >      EGLint attrs[64];
> > >      int i =3D 0;
> > > -    uint64_t modifier;
> > > +    uint64_t modifier =3D qemu_dmabuf_get_modifier(dmabuf);
> > >      uint32_t texture =3D qemu_dmabuf_get_texture(dmabuf);
> > >
> > >      if (texture !=3D 0) {
> > > @@ -328,15 +333,12 @@ void egl_dmabuf_import_texture(QemuDmaBuf *dmab=
uf)
> > >      attrs[i++] =3D qemu_dmabuf_get_stride(dmabuf)[0];
> > >      attrs[i++] =3D EGL_DMA_BUF_PLANE0_OFFSET_EXT;
> > >      attrs[i++] =3D 0;
> > > -#ifdef EGL_DMA_BUF_PLANE0_MODIFIER_LO_EXT
> >
> > We should check for that define during meson.build when gbm.found(),
> > to avoid potential later build errors.
> >
> This macro should be in EGL header for many years as this is a 2015 EGL
> extension. Check the macro in meson.build is not necessary now like you
> won't check all other EGL macros like EGL_DMA_BUF_PLANE0_OFFSET_EXT.

Imho we should still check for those macros, as they are extensions to egl.


--=20
Marc-Andr=C3=A9 Lureau

