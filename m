Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92E5CC36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 06:40:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txKPm-0000gj-Dk; Wed, 26 Mar 2025 02:39:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1txKPj-0000gA-Mv
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 02:38:59 -0400
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1txKPh-00050Z-KK
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 02:38:59 -0400
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-476f4e9cf92so44916951cf.3
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 23:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742971136; x=1743575936; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RMFS3jEXAlYxgXIomJmqNvybO96K3F5To5SdT7QWfok=;
 b=aUbVO+U5vNUUrGjEfD5kYmN+Tf/KCUAnkzCnn3Jh2PHZMbeOYqBdZx0BoyrzvOcQxJ
 3gmRJa1y6t4uDfBox+F4pdi2Lo3YJkriglJQrdk1WHdTveCaz8deASB0ByUjlticGtkH
 4Gv1rIjfjvZM9hrKrAsi7k7kmlTOvIecUKZsLnZGVvrz2ibuPAacu6BRa5uL1I/2HL5k
 xN5WM1C3lClNXja0T6yFXPzSjCSZHm5QHpeM/GY7hXuXiK4pNrIn4DfUPlN/374kTyca
 jyFva8/FyiIKUmnwA8BibI4ofaYJGSpbYCgDiS4cNj5zLbcEF2/FeJ5/oaEozQc/OIaJ
 Ed8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742971136; x=1743575936;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RMFS3jEXAlYxgXIomJmqNvybO96K3F5To5SdT7QWfok=;
 b=s+aqwl/jYNfVFNtPVjs+E4fdic8pIPJRHZwkZavUIgKMRJqy2puLjH4zIxbaYcWFah
 QGYBoKavh7ugUydp4k/G6Hnd9l8/zk0qi37y9bNzb3hl7feZIyt0zi0hahPnF+so8Tc8
 Wglc7FeAuNE4sqip80kQ6Om12NEVACe2iUT42r6Yy6IyCFR5hiwOLL79FYzLtJWfy1lw
 K1XGwNlio0bPIdkQ+Z5PjxUflwX+l1Y6QdGtvwAqlGPUSDivmwqI/VjoP+u8Vish9WTL
 ns5OcWZRZdzn97+BA/tWtRomKnjVhPTIf6OilN937OCyiNcKa/89jwg6GhNb0MAUL2lJ
 pTLg==
X-Gm-Message-State: AOJu0YzrZ1qb+I8sq3gV0gOXYZsOZo+i9NuU3uX7Bt08x3ZHAkDTp7Gv
 DDuyVFSEvRubBRmTu83BdZ+NavTHAIcP95/ofA/0Id2HE70SXbJKCjwTD8kSZ8hMBh49gpHRxVG
 CzVRPEJg0RFA6XiXlqRSCETHtxi4+P2ox
X-Gm-Gg: ASbGncsWZij9wHyzgjK3YtaqiOKZEkbmuT+d6MPBpp+ebIrsW6yMAdLudPD036xpuw8
 VPQLD+gHCt0/q6vCJtr0BXYcx7g6fqLQ0tRv7R3hjzhsyFkqXhjeyFn2bihGam+1nJ6T4f8wXO0
 dK+g4bTBW67bdED71F7Tb+ntjrERmHKwfofH3UtrMbFeuGcpn9lE/+VwoUbGE=
X-Google-Smtp-Source: AGHT+IGOAGhzMAICCeKmxxwFGYvcALDn2otMX5inWBe5nrSrZ6WpPsrc/wcz1Zh/U1V3einSui/T1MCprNq3L/AB2rs=
X-Received: by 2002:a05:622a:4a19:b0:476:76bc:cfb8 with SMTP id
 d75a77b69052e-4771dddea0bmr354551711cf.31.1742971135860; Tue, 25 Mar 2025
 23:38:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250324081922.359369-1-yuq825@gmail.com>
 <20250324081922.359369-7-yuq825@gmail.com>
 <CAJ+F1C+NCda4V_1n-zL3GA_e+HabO6sbKBxWQb_S_zzPPjLNQQ@mail.gmail.com>
 <CAKGbVbtcih4g1sbeDa3XChNFY6tX1tA6Jg4sj+pCvc7V_xoOJA@mail.gmail.com>
 <CAJ+F1CJvkS2iQpd=wxqO+_n9SBvDSC55cLPbzLHqLG06ZjGu4g@mail.gmail.com>
 <CAKGbVbvmg1-ZRZsX6L6FwnwS6++xWsvuC-r-CSQSiUW7r1U7cA@mail.gmail.com>
In-Reply-To: <CAKGbVbvmg1-ZRZsX6L6FwnwS6++xWsvuC-r-CSQSiUW7r1U7cA@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 26 Mar 2025 10:38:43 +0400
X-Gm-Features: AQ5f1JpLIGib_8Y1SQE_Ly40rIHS9jdBOMKEqoWfPqo3Py8V25icXK-x5kH_yuo
Message-ID: <CAJ+F1C+3AKEmRyfAQ+tnL9Cb1YLscOPwr_7ZOogmVXTRD2tXNg@mail.gmail.com>
Subject: Re: [PATCH 6/6] ui/spice: support multi plane dmabuf scanout
To: Qiang Yu <yuq825@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82e;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82e.google.com
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

On Wed, Mar 26, 2025 at 5:46=E2=80=AFAM Qiang Yu <yuq825@gmail.com> wrote:
>
> On Mon, Mar 24, 2025 at 10:02=E2=80=AFPM Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@gmail.com> wrote:
> >
> > On Mon, Mar 24, 2025 at 5:35=E2=80=AFPM Qiang Yu <yuq825@gmail.com> wro=
te:
> > >
> > > On Mon, Mar 24, 2025 at 5:30=E2=80=AFPM Marc-Andr=C3=A9 Lureau
> > > <marcandre.lureau@gmail.com> wrote:
> > > >
> > > > Hi
> > > >
> > > > On Mon, Mar 24, 2025 at 12:20=E2=80=AFPM <yuq825@gmail.com> wrote:
> > > > >
> > > > > From: Qiang Yu <yuq825@gmail.com>
> > > > >
> > > > > Signed-off-by: Qiang Yu <yuq825@gmail.com>
> > > > > ---
> > > > >  meson.build        |  2 +-
> > > > >  ui/spice-display.c | 65 +++++++++++++++++++++++-----------------=
------
> > > > >  2 files changed, 34 insertions(+), 33 deletions(-)
> > > > >
> > > > > diff --git a/meson.build b/meson.build
> > > > > index 9d9c11731f..b87704a83b 100644
> > > > > --- a/meson.build
> > > > > +++ b/meson.build
> > > > > @@ -1329,7 +1329,7 @@ if get_option('spice') \
> > > > >               .require(pixman.found(),
> > > > >                        error_message: 'cannot enable SPICE if pix=
man is not available') \
> > > > >               .allowed()
> > > > > -  spice =3D dependency('spice-server', version: '>=3D0.14.0',
> > > > > +  spice =3D dependency('spice-server', version: '>=3D0.14.3',
> > > >
> > > > I am okay with bumping dependency requirements, but the nicer
> > > > alternative would be to allow the current version and check the
> > > > existence of the new API/function instead.
> > > >
> > > I'm not familiar with how qemu handle new API dependency, but isn't i=
t much
> > > convenient to just bump lib version instead of a macro all around? An=
d I can't
> > > see similar macro in meson.build
> >
> > Yes it is generally simpler to bump requirements, but as Daniel
> > hinted, we have policies about supporting older environments.
> >
> > For your series, I think we could simply have:
> > if spice.found()
> >   config_host_data.set('HAVE_SPICE_QXL_GL_SCANOUT2',
> >     cc.has_function('spice_qxl_gl_scanout2', dependencies: spice))
> > endif
> >
> This serial is more like a bug fix instead of feature adding. Because wit=
hout
> new spice-server, qemu spice gl scanout support is completely broken when
> run on multi plane GPU driver. If not bumping spice version, user may sti=
ll
> suffer this problem when using new qemu and old spice. Is this OK?

Yes, the new QEMU should print a warning or error out on startup in
such situation.

> >
> > >
> > > >
> > > > >                       required: get_option('spice'),
> > > > >                       method: 'pkg-config')
> > > > >  endif
> > > > > diff --git a/ui/spice-display.c b/ui/spice-display.c
> > > > > index b7016ece6a..46b6d5dfc9 100644
> > > > > --- a/ui/spice-display.c
> > > > > +++ b/ui/spice-display.c
> > > > > @@ -28,6 +28,8 @@
> > > > >
> > > > >  #include "ui/spice-display.h"
> > > > >
> > > > > +#include "standard-headers/drm/drm_fourcc.h"
> > > > > +
> > > > >  bool spice_opengl;
> > > > >
> > > > >  int qemu_spice_rect_is_empty(const QXLRect* r)
> > > > > @@ -884,16 +886,11 @@ static void spice_gl_switch(DisplayChangeLi=
stener *dcl,
> > > > >      if (ssd->ds) {
> > > > >          uint32_t offset[DMABUF_MAX_PLANES], stride[DMABUF_MAX_PL=
ANES];
> > > > >          int fd[DMABUF_MAX_PLANES], num_planes, fourcc;
> > > > > +        uint64_t modifier;
> > > > >
> > > > >          surface_gl_create_texture(ssd->gls, ssd->ds);
> > > > >          if (!egl_dmabuf_export_texture(ssd->ds->texture, fd, (EG=
Lint *)offset,
> > > > > -                                       (EGLint *)stride, &fourcc=
, &num_planes, NULL)) {
> > > > > -            surface_gl_destroy_texture(ssd->gls, ssd->ds);
> > > > > -            return;
> > > > > -        }
> > > > > -
> > > > > -        if (num_planes > 1) {
> > > > > -            fprintf(stderr, "%s: does not support multi-plane te=
xture\n", __func__);
> > > > > +                                       (EGLint *)stride, &fourcc=
, &num_planes, &modifier)) {
> > > > >              surface_gl_destroy_texture(ssd->gls, ssd->ds);
> > > > >              return;
> > > > >          }
> > > > > @@ -904,10 +901,11 @@ static void spice_gl_switch(DisplayChangeLi=
stener *dcl,
> > > > >                                      fourcc);
> > > > >
> > > > >          /* note: spice server will close the fd */
> > > > > -        spice_qxl_gl_scanout(&ssd->qxl, fd[0],
> > > > > -                             surface_width(ssd->ds),
> > > > > -                             surface_height(ssd->ds),
> > > > > -                             stride[0], fourcc, false);
> > > > > +        spice_qxl_gl_scanout2(&ssd->qxl, fd,
> > > > > +                              surface_width(ssd->ds),
> > > > > +                              surface_height(ssd->ds),
> > > > > +                              offset, stride, num_planes,
> > > > > +                              fourcc, modifier, false);
> > > > >          ssd->have_surface =3D true;
> > > > >          ssd->have_scanout =3D false;
> > > > >
> > > > > @@ -930,7 +928,8 @@ static void qemu_spice_gl_scanout_disable(Dis=
playChangeListener *dcl)
> > > > >      SimpleSpiceDisplay *ssd =3D container_of(dcl, SimpleSpiceDis=
play, dcl);
> > > > >
> > > > >      trace_qemu_spice_gl_scanout_disable(ssd->qxl.id);
> > > > > -    spice_qxl_gl_scanout(&ssd->qxl, -1, 0, 0, 0, 0, false);
> > > > > +    spice_qxl_gl_scanout2(&ssd->qxl, NULL, 0, 0, NULL, NULL, 0, =
DRM_FORMAT_INVALID,
> > > > > +                          DRM_FORMAT_MOD_INVALID, false);
> > > > >      qemu_spice_gl_monitor_config(ssd, 0, 0, 0, 0);
> > > > >      ssd->have_surface =3D false;
> > > > >      ssd->have_scanout =3D false;
> > > > > @@ -948,22 +947,21 @@ static void qemu_spice_gl_scanout_texture(D=
isplayChangeListener *dcl,
> > > > >      SimpleSpiceDisplay *ssd =3D container_of(dcl, SimpleSpiceDis=
play, dcl);
> > > > >      EGLint offset[DMABUF_MAX_PLANES], stride[DMABUF_MAX_PLANES],=
 fourcc =3D 0;
> > > > >      int fd[DMABUF_MAX_PLANES], num_planes;
> > > > > +    uint64_t modifier;
> > > > >
> > > > >      assert(tex_id);
> > > > >      if (!egl_dmabuf_export_texture(tex_id, fd, offset, stride, &=
fourcc,
> > > > > -                                   &num_planes, NULL)) {
> > > > > +                                   &num_planes, &modifier)) {
> > > > >          fprintf(stderr, "%s: failed to export dmabuf for texture=
\n", __func__);
> > > > >          return;
> > > > >      }
> > > > > -    if (num_planes > 1) {
> > > > > -        fprintf(stderr, "%s: does not support multi-plane dmabuf=
\n", __func__);
> > > > > -        return;
> > > > > -    }
> > > > > +
> > > > >      trace_qemu_spice_gl_scanout_texture(ssd->qxl.id, w, h, fourc=
c);
> > > > >
> > > > >      /* note: spice server will close the fd */
> > > > > -    spice_qxl_gl_scanout(&ssd->qxl, fd[0], backing_width, backin=
g_height,
> > > > > -                         stride[0], fourcc, y_0_top);
> > > > > +    spice_qxl_gl_scanout2(&ssd->qxl, fd, backing_width, backing_=
height,
> > > > > +                          (uint32_t *)offset, (uint32_t *)stride=
, num_planes,
> > > > > +                          fourcc, modifier, y_0_top);
> > > > >      qemu_spice_gl_monitor_config(ssd, x, y, w, h);
> > > > >      ssd->have_surface =3D false;
> > > > >      ssd->have_scanout =3D true;
> > > > > @@ -1034,11 +1032,10 @@ static void qemu_spice_gl_update(DisplayC=
hangeListener *dcl,
> > > > >                                   uint32_t x, uint32_t y, uint32_=
t w, uint32_t h)
> > > > >  {
> > > > >      SimpleSpiceDisplay *ssd =3D container_of(dcl, SimpleSpiceDis=
play, dcl);
> > > > > -    EGLint stride =3D 0, fourcc =3D 0;
> > > > > +    EGLint fourcc =3D 0;
> > > > >      bool render_cursor =3D false;
> > > > >      bool y_0_top =3D false; /* FIXME */
> > > > >      uint64_t cookie;
> > > > > -    int fd;
> > > > >      uint32_t width, height, texture;
> > > > >
> > > > >      if (!ssd->have_scanout) {
> > > > > @@ -1075,6 +1072,7 @@ static void qemu_spice_gl_update(DisplayCha=
ngeListener *dcl,
> > > > >                  ssd->blit_fb.height !=3D height) {
> > > > >                  int fds[DMABUF_MAX_PLANES], num_planes;
> > > > >                  uint32_t offsets[DMABUF_MAX_PLANES], strides[DMA=
BUF_MAX_PLANES];
> > > > > +                uint64_t modifier;
> > > > >
> > > > >                  trace_qemu_spice_gl_render_dmabuf(ssd->qxl.id, w=
idth,
> > > > >                                                    height);
> > > > > @@ -1083,27 +1081,30 @@ static void qemu_spice_gl_update(DisplayC=
hangeListener *dcl,
> > > > >                                       width, height);
> > > > >                  if (!egl_dmabuf_export_texture(ssd->blit_fb.text=
ure, fds,
> > > > >                                                 (EGLint *)offsets=
, (EGLint *)strides,
> > > > > -                                               &fourcc, &num_pla=
nes, NULL)) {
> > > > > +                                               &fourcc, &num_pla=
nes, &modifier)) {
> > > > >                      fprintf(stderr, "%s: failed to export dmabuf=
 for texture\n", __func__);
> > > > >                      return;
> > > > >                  }
> > > > > -                if (num_planes > 1) {
> > > > > -                    fprintf(stderr, "%s: does not support multi-=
plane dmabuf\n", __func__);
> > > > > -                    return;
> > > > > -                }
> > > > > -                spice_qxl_gl_scanout(&ssd->qxl, fds[0], width, h=
eight,
> > > > > -                                     strides[0], fourcc, false);
> > > > > +
> > > > > +                spice_qxl_gl_scanout2(&ssd->qxl, fds, width, hei=
ght, offsets, strides,
> > > > > +                                      num_planes, fourcc, modifi=
er, false);
> > > > >              }
> > > > >          } else {
> > > > > -            stride =3D qemu_dmabuf_get_stride(dmabuf)[0];
> > > > > +            int fds[DMABUF_MAX_PLANES];
> > > > > +
> > > > >              fourcc =3D qemu_dmabuf_get_fourcc(dmabuf);
> > > > >              y_0_top =3D qemu_dmabuf_get_y0_top(dmabuf);
> > > > > -            qemu_dmabuf_dup_fd(dmabuf, &fd);
> > > > > +            qemu_dmabuf_dup_fd(dmabuf, fds);
> > > > >
> > > > >              trace_qemu_spice_gl_forward_dmabuf(ssd->qxl.id, widt=
h, height);
> > > > >              /* note: spice server will close the fd, so hand ove=
r a dup */
> > > > > -            spice_qxl_gl_scanout(&ssd->qxl, fd, width, height,
> > > > > -                                 stride, fourcc, y_0_top);
> > > > > +            spice_qxl_gl_scanout2(&ssd->qxl, fds, width, height,
> > > > > +                                  qemu_dmabuf_get_offset(dmabuf)=
,
> > > > > +                                  qemu_dmabuf_get_stride(dmabuf)=
,
> > > > > +                                  qemu_dmabuf_get_num_planes(dma=
buf),
> > > > > +                                  fourcc,
> > > > > +                                  qemu_dmabuf_get_modifier(dmabu=
f),
> > > > > +                                  y_0_top);
> > > > >          }
> > > > >          qemu_spice_gl_monitor_config(ssd, 0, 0, width, height);
> > > > >          ssd->guest_dmabuf_refresh =3D false;
> > > > > --
> > > > > 2.43.0
> > > > >
> > > > >
> > > >
> > > >
> > > > --
> > > > Marc-Andr=C3=A9 Lureau
> >
> >
> >
> > --
> > Marc-Andr=C3=A9 Lureau



--=20
Marc-Andr=C3=A9 Lureau

