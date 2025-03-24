Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FD1DC36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 13:36:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twhxq-0000he-3D; Mon, 24 Mar 2025 09:35:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuq825@gmail.com>) id 1twhxX-0000gF-MB
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 09:35:21 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuq825@gmail.com>) id 1twhxV-000102-Fj
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 09:35:19 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5dccaaca646so8186129a12.0
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 06:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742823315; x=1743428115; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LNGbDlUlTBKLsuy5Cwy7DhlTOlFrxmxSO4QKsh5jaIE=;
 b=OkFVoI+bVVoeut6kTMWKCbWjcXXD2mHMie0aSjkvwxblqohsOd+y1XtbEwI1tHMlCj
 jLNwJwtYil+BZOGehSuuaES8uk8w1S1A+4Aj9Bp2D+fFNvns2WrAGyNcBkXIhTzhDpmO
 DDoSzFPGX3lePcbA0/wvU/ha5qxEqLL5JzeJDvnamgRVomFVm+ReNHaNh7qXAzjGyyx0
 qtgtlcgoNOvdGa79SV8Nf+pIDwj6IrUa0CczNx8XOyqt3vFtnsSH968tkxVw9nZhAf5L
 gMLTcF0m06ZzcUhkWcL62KRMLsiv3KX1UqrvK6YMngscYy1gz2nzH98ly2nRYIJzoPX5
 lNKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742823315; x=1743428115;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LNGbDlUlTBKLsuy5Cwy7DhlTOlFrxmxSO4QKsh5jaIE=;
 b=nEMzTDSw/76+H5BYghnRSlv8enl+/fFLbD4OlH0FMHZkeiIpoQZIp7AnKQltOPzVIP
 YFbRJVAr6r3wdpb74BtROrLb2Mc97Wz9upuc/0ERLfFphh9k/6Ru999Rn6tl4SA0Zf9Q
 pmHTgU1oyeziWk74o2lP0znQQMyNXzU9VlJZEhLNkGeVfRlopIRlfws4j+hFMer3KuEm
 EaIX5G/ELeBvnqbNaphAMCHxpdhNU1ofslaqd4F7hksN88y37PxEDrFDvZ2qzpt1lRSW
 Ic6JlCrB6wBLB4goPlHnQabfhi7/3WvrbJCnm6/FaNFQ2VxuKMkVUGuWu81KbFAtMD6E
 JuWg==
X-Gm-Message-State: AOJu0Yz++LOkMjmbE/6Jzw1XUwo365qHnY8T+/9qZ5i3KVv+T8IsKI5F
 GA+LEiF3HWbNx149CW1dKQICvl2CYksVl4vaXUsFrU4Yz5wu0uIoL6YVr6V4TNnODjKIsy67STj
 km88WV4EQQzBLDnFgsJCvCLhYOP9FB6kx
X-Gm-Gg: ASbGncvxzD7XMdcUNffEOHQm/jSV5XyB+IKO4+107H2Xfoqu/gbpyodQ856svoTDw24
 4pBW2mWmvTdBB2ciPhNRicph6T5BPznwyd2YoztcJ73lPq9Vw8hAO4OQU4znrYg1aM7BQ110hyJ
 k4b7K15DXMRzPG0XdMAWcra+/pdkM=
X-Google-Smtp-Source: AGHT+IGvbMnLWPYuA/qs/maxPreTJMkbsing1J1V8mnKwLGz7U9sPSKd3F8EyMZkJGfAX2wo8VDLp2Unav/CRHEUw00=
X-Received: by 2002:a05:6402:278c:b0:5ec:c7da:1170 with SMTP id
 4fb4d7f45d1cf-5ecc7da2534mr3199496a12.13.1742823314737; Mon, 24 Mar 2025
 06:35:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250324081922.359369-1-yuq825@gmail.com>
 <20250324081922.359369-7-yuq825@gmail.com>
 <CAJ+F1C+NCda4V_1n-zL3GA_e+HabO6sbKBxWQb_S_zzPPjLNQQ@mail.gmail.com>
In-Reply-To: <CAJ+F1C+NCda4V_1n-zL3GA_e+HabO6sbKBxWQb_S_zzPPjLNQQ@mail.gmail.com>
From: Qiang Yu <yuq825@gmail.com>
Date: Mon, 24 Mar 2025 21:35:03 +0800
X-Gm-Features: AQ5f1JriwcC43w5VJdeP33J02w98tSiZPXnY7GuS7HO_x53YpOae3apHhZmPgBU
Message-ID: <CAKGbVbtcih4g1sbeDa3XChNFY6tX1tA6Jg4sj+pCvc7V_xoOJA@mail.gmail.com>
Subject: Re: [PATCH 6/6] ui/spice: support multi plane dmabuf scanout
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=yuq825@gmail.com; helo=mail-ed1-x535.google.com
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

On Mon, Mar 24, 2025 at 5:30=E2=80=AFPM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
>
> Hi
>
> On Mon, Mar 24, 2025 at 12:20=E2=80=AFPM <yuq825@gmail.com> wrote:
> >
> > From: Qiang Yu <yuq825@gmail.com>
> >
> > Signed-off-by: Qiang Yu <yuq825@gmail.com>
> > ---
> >  meson.build        |  2 +-
> >  ui/spice-display.c | 65 +++++++++++++++++++++++-----------------------
> >  2 files changed, 34 insertions(+), 33 deletions(-)
> >
> > diff --git a/meson.build b/meson.build
> > index 9d9c11731f..b87704a83b 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -1329,7 +1329,7 @@ if get_option('spice') \
> >               .require(pixman.found(),
> >                        error_message: 'cannot enable SPICE if pixman is=
 not available') \
> >               .allowed()
> > -  spice =3D dependency('spice-server', version: '>=3D0.14.0',
> > +  spice =3D dependency('spice-server', version: '>=3D0.14.3',
>
> I am okay with bumping dependency requirements, but the nicer
> alternative would be to allow the current version and check the
> existence of the new API/function instead.
>
I'm not familiar with how qemu handle new API dependency, but isn't it much
convenient to just bump lib version instead of a macro all around? And I ca=
n't
see similar macro in meson.build

>
> >                       required: get_option('spice'),
> >                       method: 'pkg-config')
> >  endif
> > diff --git a/ui/spice-display.c b/ui/spice-display.c
> > index b7016ece6a..46b6d5dfc9 100644
> > --- a/ui/spice-display.c
> > +++ b/ui/spice-display.c
> > @@ -28,6 +28,8 @@
> >
> >  #include "ui/spice-display.h"
> >
> > +#include "standard-headers/drm/drm_fourcc.h"
> > +
> >  bool spice_opengl;
> >
> >  int qemu_spice_rect_is_empty(const QXLRect* r)
> > @@ -884,16 +886,11 @@ static void spice_gl_switch(DisplayChangeListener=
 *dcl,
> >      if (ssd->ds) {
> >          uint32_t offset[DMABUF_MAX_PLANES], stride[DMABUF_MAX_PLANES];
> >          int fd[DMABUF_MAX_PLANES], num_planes, fourcc;
> > +        uint64_t modifier;
> >
> >          surface_gl_create_texture(ssd->gls, ssd->ds);
> >          if (!egl_dmabuf_export_texture(ssd->ds->texture, fd, (EGLint *=
)offset,
> > -                                       (EGLint *)stride, &fourcc, &num=
_planes, NULL)) {
> > -            surface_gl_destroy_texture(ssd->gls, ssd->ds);
> > -            return;
> > -        }
> > -
> > -        if (num_planes > 1) {
> > -            fprintf(stderr, "%s: does not support multi-plane texture\=
n", __func__);
> > +                                       (EGLint *)stride, &fourcc, &num=
_planes, &modifier)) {
> >              surface_gl_destroy_texture(ssd->gls, ssd->ds);
> >              return;
> >          }
> > @@ -904,10 +901,11 @@ static void spice_gl_switch(DisplayChangeListener=
 *dcl,
> >                                      fourcc);
> >
> >          /* note: spice server will close the fd */
> > -        spice_qxl_gl_scanout(&ssd->qxl, fd[0],
> > -                             surface_width(ssd->ds),
> > -                             surface_height(ssd->ds),
> > -                             stride[0], fourcc, false);
> > +        spice_qxl_gl_scanout2(&ssd->qxl, fd,
> > +                              surface_width(ssd->ds),
> > +                              surface_height(ssd->ds),
> > +                              offset, stride, num_planes,
> > +                              fourcc, modifier, false);
> >          ssd->have_surface =3D true;
> >          ssd->have_scanout =3D false;
> >
> > @@ -930,7 +928,8 @@ static void qemu_spice_gl_scanout_disable(DisplayCh=
angeListener *dcl)
> >      SimpleSpiceDisplay *ssd =3D container_of(dcl, SimpleSpiceDisplay, =
dcl);
> >
> >      trace_qemu_spice_gl_scanout_disable(ssd->qxl.id);
> > -    spice_qxl_gl_scanout(&ssd->qxl, -1, 0, 0, 0, 0, false);
> > +    spice_qxl_gl_scanout2(&ssd->qxl, NULL, 0, 0, NULL, NULL, 0, DRM_FO=
RMAT_INVALID,
> > +                          DRM_FORMAT_MOD_INVALID, false);
> >      qemu_spice_gl_monitor_config(ssd, 0, 0, 0, 0);
> >      ssd->have_surface =3D false;
> >      ssd->have_scanout =3D false;
> > @@ -948,22 +947,21 @@ static void qemu_spice_gl_scanout_texture(Display=
ChangeListener *dcl,
> >      SimpleSpiceDisplay *ssd =3D container_of(dcl, SimpleSpiceDisplay, =
dcl);
> >      EGLint offset[DMABUF_MAX_PLANES], stride[DMABUF_MAX_PLANES], fourc=
c =3D 0;
> >      int fd[DMABUF_MAX_PLANES], num_planes;
> > +    uint64_t modifier;
> >
> >      assert(tex_id);
> >      if (!egl_dmabuf_export_texture(tex_id, fd, offset, stride, &fourcc=
,
> > -                                   &num_planes, NULL)) {
> > +                                   &num_planes, &modifier)) {
> >          fprintf(stderr, "%s: failed to export dmabuf for texture\n", _=
_func__);
> >          return;
> >      }
> > -    if (num_planes > 1) {
> > -        fprintf(stderr, "%s: does not support multi-plane dmabuf\n", _=
_func__);
> > -        return;
> > -    }
> > +
> >      trace_qemu_spice_gl_scanout_texture(ssd->qxl.id, w, h, fourcc);
> >
> >      /* note: spice server will close the fd */
> > -    spice_qxl_gl_scanout(&ssd->qxl, fd[0], backing_width, backing_heig=
ht,
> > -                         stride[0], fourcc, y_0_top);
> > +    spice_qxl_gl_scanout2(&ssd->qxl, fd, backing_width, backing_height=
,
> > +                          (uint32_t *)offset, (uint32_t *)stride, num_=
planes,
> > +                          fourcc, modifier, y_0_top);
> >      qemu_spice_gl_monitor_config(ssd, x, y, w, h);
> >      ssd->have_surface =3D false;
> >      ssd->have_scanout =3D true;
> > @@ -1034,11 +1032,10 @@ static void qemu_spice_gl_update(DisplayChangeL=
istener *dcl,
> >                                   uint32_t x, uint32_t y, uint32_t w, u=
int32_t h)
> >  {
> >      SimpleSpiceDisplay *ssd =3D container_of(dcl, SimpleSpiceDisplay, =
dcl);
> > -    EGLint stride =3D 0, fourcc =3D 0;
> > +    EGLint fourcc =3D 0;
> >      bool render_cursor =3D false;
> >      bool y_0_top =3D false; /* FIXME */
> >      uint64_t cookie;
> > -    int fd;
> >      uint32_t width, height, texture;
> >
> >      if (!ssd->have_scanout) {
> > @@ -1075,6 +1072,7 @@ static void qemu_spice_gl_update(DisplayChangeLis=
tener *dcl,
> >                  ssd->blit_fb.height !=3D height) {
> >                  int fds[DMABUF_MAX_PLANES], num_planes;
> >                  uint32_t offsets[DMABUF_MAX_PLANES], strides[DMABUF_MA=
X_PLANES];
> > +                uint64_t modifier;
> >
> >                  trace_qemu_spice_gl_render_dmabuf(ssd->qxl.id, width,
> >                                                    height);
> > @@ -1083,27 +1081,30 @@ static void qemu_spice_gl_update(DisplayChangeL=
istener *dcl,
> >                                       width, height);
> >                  if (!egl_dmabuf_export_texture(ssd->blit_fb.texture, f=
ds,
> >                                                 (EGLint *)offsets, (EGL=
int *)strides,
> > -                                               &fourcc, &num_planes, N=
ULL)) {
> > +                                               &fourcc, &num_planes, &=
modifier)) {
> >                      fprintf(stderr, "%s: failed to export dmabuf for t=
exture\n", __func__);
> >                      return;
> >                  }
> > -                if (num_planes > 1) {
> > -                    fprintf(stderr, "%s: does not support multi-plane =
dmabuf\n", __func__);
> > -                    return;
> > -                }
> > -                spice_qxl_gl_scanout(&ssd->qxl, fds[0], width, height,
> > -                                     strides[0], fourcc, false);
> > +
> > +                spice_qxl_gl_scanout2(&ssd->qxl, fds, width, height, o=
ffsets, strides,
> > +                                      num_planes, fourcc, modifier, fa=
lse);
> >              }
> >          } else {
> > -            stride =3D qemu_dmabuf_get_stride(dmabuf)[0];
> > +            int fds[DMABUF_MAX_PLANES];
> > +
> >              fourcc =3D qemu_dmabuf_get_fourcc(dmabuf);
> >              y_0_top =3D qemu_dmabuf_get_y0_top(dmabuf);
> > -            qemu_dmabuf_dup_fd(dmabuf, &fd);
> > +            qemu_dmabuf_dup_fd(dmabuf, fds);
> >
> >              trace_qemu_spice_gl_forward_dmabuf(ssd->qxl.id, width, hei=
ght);
> >              /* note: spice server will close the fd, so hand over a du=
p */
> > -            spice_qxl_gl_scanout(&ssd->qxl, fd, width, height,
> > -                                 stride, fourcc, y_0_top);
> > +            spice_qxl_gl_scanout2(&ssd->qxl, fds, width, height,
> > +                                  qemu_dmabuf_get_offset(dmabuf),
> > +                                  qemu_dmabuf_get_stride(dmabuf),
> > +                                  qemu_dmabuf_get_num_planes(dmabuf),
> > +                                  fourcc,
> > +                                  qemu_dmabuf_get_modifier(dmabuf),
> > +                                  y_0_top);
> >          }
> >          qemu_spice_gl_monitor_config(ssd, 0, 0, width, height);
> >          ssd->guest_dmabuf_refresh =3D false;
> > --
> > 2.43.0
> >
> >
>
>
> --
> Marc-Andr=C3=A9 Lureau

