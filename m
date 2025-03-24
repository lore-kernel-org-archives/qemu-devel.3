Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84A0CC36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 14:05:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twiPi-00014z-2o; Mon, 24 Mar 2025 10:04:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1twiNg-00089r-8V
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 10:02:27 -0400
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1twiNd-0004bG-1b
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 10:02:19 -0400
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-477296dce76so21367051cf.3
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 07:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742824935; x=1743429735; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jxvEqDtXSyIom+n49ofVG7hajT/L7+gwohexakoSBZo=;
 b=gk260NDPX0ObUhbZg0nsv+JLtrWIazBvmyAMkfbeT1pnNxY8LLtXE/6h2Jq0ZZm+05
 kceyD0bwAK5qCon2J1WcedfqATmT+EWSYrknjFF/JlNEAtlPBgbOtmayTZQ7MUfI6JSG
 g5vZzX4xrqqzYN4Kantm+uRsnVdgoPPNssJuZgYjXuaACWNVDHwi3DWTuwTjGazvMRNd
 WxO/xrFbeF53RIMqxynrlqKIl6dPVX7ceTWwHsVFCTLhuqynQWyzkk6OjwKT/zO/bAwQ
 yVbXDtISF39hO25BQigq3CAbm8Ej3v2veEEkhJRI63iMQSJiDUCCmEtHqmrOr8RLQ8Zk
 FttQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742824935; x=1743429735;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jxvEqDtXSyIom+n49ofVG7hajT/L7+gwohexakoSBZo=;
 b=Ne5PF8PsFqTNEHHLSESFtyg9V5tWCNiwQp8bCeVsnxMvTB+Xgc4wPOgroAL/PDrPxz
 Wh7J6A5U7Z0cWwYukgf+Tvv2IAfuHftss4hOzvHXEBA+1EoKioH7DGPhgF+ygwbYZCGc
 dTZqsLNaUVjDXhFHFtSIUgZUJq3Vv6QAflz9VexkL61AnwxSmzIAYuYsmoIRZ5iBLjXx
 SRWRly+WFeAa+PniTn0LvRitZtntcWfR95IwaKDOIfWrBRTSEfBYbMsgpl7lIdudDq9f
 MraAouT5N/w891Gx6QhUBC/kvvEz8H/8W2by64ZQDaG+Cn4VPJ9wekMdF9EtVLOmSsFb
 IRGQ==
X-Gm-Message-State: AOJu0Yyxgm1rrZ6QwZ+rGguQuXTNte79SAl41KiJsIFT8vlmR5QXrn+J
 E/WxYW0vrI6GwbMrRNYNk5Dymvz53EbATAoGO2pggmpLPeutz9wNAZaebHnIDmlFZDF8uZAvHLf
 OGMZiYxCWfb4GLPWSG0iQ7CseGBM=
X-Gm-Gg: ASbGncvG22q99vl1BBBS/eFX6Crc2gVFCVkL8OXZechDrtIDzMUYE6LHSTs71UasSeB
 J2gzk1fg3x9UVTX9AjcznSCLQtBsl2rfDOM67rZqwGTWEYyPqVZso9PmGCYWB2d154wikdCPUtM
 b1eMCwe9NmpVUiSutb8qnBj5YBkVD/mCMDNzlj1ebVuIsgsh4nHtPcDoOtN5E=
X-Google-Smtp-Source: AGHT+IHL44ZpiPF4XHpdfKvMxzELtdtXzM+hE6Os9JeDX6a3WsHWuzBjB6OfcPKBIFtgeUuv5NlIkquDiDIiy9INmKo=
X-Received: by 2002:a05:622a:5c9a:b0:476:fd53:287 with SMTP id
 d75a77b69052e-4771de4d690mr228977511cf.44.1742824934711; Mon, 24 Mar 2025
 07:02:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250324081922.359369-1-yuq825@gmail.com>
 <20250324081922.359369-7-yuq825@gmail.com>
 <CAJ+F1C+NCda4V_1n-zL3GA_e+HabO6sbKBxWQb_S_zzPPjLNQQ@mail.gmail.com>
 <CAKGbVbtcih4g1sbeDa3XChNFY6tX1tA6Jg4sj+pCvc7V_xoOJA@mail.gmail.com>
In-Reply-To: <CAKGbVbtcih4g1sbeDa3XChNFY6tX1tA6Jg4sj+pCvc7V_xoOJA@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 24 Mar 2025 18:02:02 +0400
X-Gm-Features: AQ5f1JpvRtTWFa6jIe1pErne5JdAtPF0eJFUgY54SSjqA-7XAw_VHuk4H5JpHS4
Message-ID: <CAJ+F1CJvkS2iQpd=wxqO+_n9SBvDSC55cLPbzLHqLG06ZjGu4g@mail.gmail.com>
Subject: Re: [PATCH 6/6] ui/spice: support multi plane dmabuf scanout
To: Qiang Yu <yuq825@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82c;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82c.google.com
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

On Mon, Mar 24, 2025 at 5:35=E2=80=AFPM Qiang Yu <yuq825@gmail.com> wrote:
>
> On Mon, Mar 24, 2025 at 5:30=E2=80=AFPM Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@gmail.com> wrote:
> >
> > Hi
> >
> > On Mon, Mar 24, 2025 at 12:20=E2=80=AFPM <yuq825@gmail.com> wrote:
> > >
> > > From: Qiang Yu <yuq825@gmail.com>
> > >
> > > Signed-off-by: Qiang Yu <yuq825@gmail.com>
> > > ---
> > >  meson.build        |  2 +-
> > >  ui/spice-display.c | 65 +++++++++++++++++++++++---------------------=
--
> > >  2 files changed, 34 insertions(+), 33 deletions(-)
> > >
> > > diff --git a/meson.build b/meson.build
> > > index 9d9c11731f..b87704a83b 100644
> > > --- a/meson.build
> > > +++ b/meson.build
> > > @@ -1329,7 +1329,7 @@ if get_option('spice') \
> > >               .require(pixman.found(),
> > >                        error_message: 'cannot enable SPICE if pixman =
is not available') \
> > >               .allowed()
> > > -  spice =3D dependency('spice-server', version: '>=3D0.14.0',
> > > +  spice =3D dependency('spice-server', version: '>=3D0.14.3',
> >
> > I am okay with bumping dependency requirements, but the nicer
> > alternative would be to allow the current version and check the
> > existence of the new API/function instead.
> >
> I'm not familiar with how qemu handle new API dependency, but isn't it mu=
ch
> convenient to just bump lib version instead of a macro all around? And I =
can't
> see similar macro in meson.build

Yes it is generally simpler to bump requirements, but as Daniel
hinted, we have policies about supporting older environments.

For your series, I think we could simply have:
if spice.found()
  config_host_data.set('HAVE_SPICE_QXL_GL_SCANOUT2',
    cc.has_function('spice_qxl_gl_scanout2', dependencies: spice))
endif


>
> >
> > >                       required: get_option('spice'),
> > >                       method: 'pkg-config')
> > >  endif
> > > diff --git a/ui/spice-display.c b/ui/spice-display.c
> > > index b7016ece6a..46b6d5dfc9 100644
> > > --- a/ui/spice-display.c
> > > +++ b/ui/spice-display.c
> > > @@ -28,6 +28,8 @@
> > >
> > >  #include "ui/spice-display.h"
> > >
> > > +#include "standard-headers/drm/drm_fourcc.h"
> > > +
> > >  bool spice_opengl;
> > >
> > >  int qemu_spice_rect_is_empty(const QXLRect* r)
> > > @@ -884,16 +886,11 @@ static void spice_gl_switch(DisplayChangeListen=
er *dcl,
> > >      if (ssd->ds) {
> > >          uint32_t offset[DMABUF_MAX_PLANES], stride[DMABUF_MAX_PLANES=
];
> > >          int fd[DMABUF_MAX_PLANES], num_planes, fourcc;
> > > +        uint64_t modifier;
> > >
> > >          surface_gl_create_texture(ssd->gls, ssd->ds);
> > >          if (!egl_dmabuf_export_texture(ssd->ds->texture, fd, (EGLint=
 *)offset,
> > > -                                       (EGLint *)stride, &fourcc, &n=
um_planes, NULL)) {
> > > -            surface_gl_destroy_texture(ssd->gls, ssd->ds);
> > > -            return;
> > > -        }
> > > -
> > > -        if (num_planes > 1) {
> > > -            fprintf(stderr, "%s: does not support multi-plane textur=
e\n", __func__);
> > > +                                       (EGLint *)stride, &fourcc, &n=
um_planes, &modifier)) {
> > >              surface_gl_destroy_texture(ssd->gls, ssd->ds);
> > >              return;
> > >          }
> > > @@ -904,10 +901,11 @@ static void spice_gl_switch(DisplayChangeListen=
er *dcl,
> > >                                      fourcc);
> > >
> > >          /* note: spice server will close the fd */
> > > -        spice_qxl_gl_scanout(&ssd->qxl, fd[0],
> > > -                             surface_width(ssd->ds),
> > > -                             surface_height(ssd->ds),
> > > -                             stride[0], fourcc, false);
> > > +        spice_qxl_gl_scanout2(&ssd->qxl, fd,
> > > +                              surface_width(ssd->ds),
> > > +                              surface_height(ssd->ds),
> > > +                              offset, stride, num_planes,
> > > +                              fourcc, modifier, false);
> > >          ssd->have_surface =3D true;
> > >          ssd->have_scanout =3D false;
> > >
> > > @@ -930,7 +928,8 @@ static void qemu_spice_gl_scanout_disable(Display=
ChangeListener *dcl)
> > >      SimpleSpiceDisplay *ssd =3D container_of(dcl, SimpleSpiceDisplay=
, dcl);
> > >
> > >      trace_qemu_spice_gl_scanout_disable(ssd->qxl.id);
> > > -    spice_qxl_gl_scanout(&ssd->qxl, -1, 0, 0, 0, 0, false);
> > > +    spice_qxl_gl_scanout2(&ssd->qxl, NULL, 0, 0, NULL, NULL, 0, DRM_=
FORMAT_INVALID,
> > > +                          DRM_FORMAT_MOD_INVALID, false);
> > >      qemu_spice_gl_monitor_config(ssd, 0, 0, 0, 0);
> > >      ssd->have_surface =3D false;
> > >      ssd->have_scanout =3D false;
> > > @@ -948,22 +947,21 @@ static void qemu_spice_gl_scanout_texture(Displ=
ayChangeListener *dcl,
> > >      SimpleSpiceDisplay *ssd =3D container_of(dcl, SimpleSpiceDisplay=
, dcl);
> > >      EGLint offset[DMABUF_MAX_PLANES], stride[DMABUF_MAX_PLANES], fou=
rcc =3D 0;
> > >      int fd[DMABUF_MAX_PLANES], num_planes;
> > > +    uint64_t modifier;
> > >
> > >      assert(tex_id);
> > >      if (!egl_dmabuf_export_texture(tex_id, fd, offset, stride, &four=
cc,
> > > -                                   &num_planes, NULL)) {
> > > +                                   &num_planes, &modifier)) {
> > >          fprintf(stderr, "%s: failed to export dmabuf for texture\n",=
 __func__);
> > >          return;
> > >      }
> > > -    if (num_planes > 1) {
> > > -        fprintf(stderr, "%s: does not support multi-plane dmabuf\n",=
 __func__);
> > > -        return;
> > > -    }
> > > +
> > >      trace_qemu_spice_gl_scanout_texture(ssd->qxl.id, w, h, fourcc);
> > >
> > >      /* note: spice server will close the fd */
> > > -    spice_qxl_gl_scanout(&ssd->qxl, fd[0], backing_width, backing_he=
ight,
> > > -                         stride[0], fourcc, y_0_top);
> > > +    spice_qxl_gl_scanout2(&ssd->qxl, fd, backing_width, backing_heig=
ht,
> > > +                          (uint32_t *)offset, (uint32_t *)stride, nu=
m_planes,
> > > +                          fourcc, modifier, y_0_top);
> > >      qemu_spice_gl_monitor_config(ssd, x, y, w, h);
> > >      ssd->have_surface =3D false;
> > >      ssd->have_scanout =3D true;
> > > @@ -1034,11 +1032,10 @@ static void qemu_spice_gl_update(DisplayChang=
eListener *dcl,
> > >                                   uint32_t x, uint32_t y, uint32_t w,=
 uint32_t h)
> > >  {
> > >      SimpleSpiceDisplay *ssd =3D container_of(dcl, SimpleSpiceDisplay=
, dcl);
> > > -    EGLint stride =3D 0, fourcc =3D 0;
> > > +    EGLint fourcc =3D 0;
> > >      bool render_cursor =3D false;
> > >      bool y_0_top =3D false; /* FIXME */
> > >      uint64_t cookie;
> > > -    int fd;
> > >      uint32_t width, height, texture;
> > >
> > >      if (!ssd->have_scanout) {
> > > @@ -1075,6 +1072,7 @@ static void qemu_spice_gl_update(DisplayChangeL=
istener *dcl,
> > >                  ssd->blit_fb.height !=3D height) {
> > >                  int fds[DMABUF_MAX_PLANES], num_planes;
> > >                  uint32_t offsets[DMABUF_MAX_PLANES], strides[DMABUF_=
MAX_PLANES];
> > > +                uint64_t modifier;
> > >
> > >                  trace_qemu_spice_gl_render_dmabuf(ssd->qxl.id, width=
,
> > >                                                    height);
> > > @@ -1083,27 +1081,30 @@ static void qemu_spice_gl_update(DisplayChang=
eListener *dcl,
> > >                                       width, height);
> > >                  if (!egl_dmabuf_export_texture(ssd->blit_fb.texture,=
 fds,
> > >                                                 (EGLint *)offsets, (E=
GLint *)strides,
> > > -                                               &fourcc, &num_planes,=
 NULL)) {
> > > +                                               &fourcc, &num_planes,=
 &modifier)) {
> > >                      fprintf(stderr, "%s: failed to export dmabuf for=
 texture\n", __func__);
> > >                      return;
> > >                  }
> > > -                if (num_planes > 1) {
> > > -                    fprintf(stderr, "%s: does not support multi-plan=
e dmabuf\n", __func__);
> > > -                    return;
> > > -                }
> > > -                spice_qxl_gl_scanout(&ssd->qxl, fds[0], width, heigh=
t,
> > > -                                     strides[0], fourcc, false);
> > > +
> > > +                spice_qxl_gl_scanout2(&ssd->qxl, fds, width, height,=
 offsets, strides,
> > > +                                      num_planes, fourcc, modifier, =
false);
> > >              }
> > >          } else {
> > > -            stride =3D qemu_dmabuf_get_stride(dmabuf)[0];
> > > +            int fds[DMABUF_MAX_PLANES];
> > > +
> > >              fourcc =3D qemu_dmabuf_get_fourcc(dmabuf);
> > >              y_0_top =3D qemu_dmabuf_get_y0_top(dmabuf);
> > > -            qemu_dmabuf_dup_fd(dmabuf, &fd);
> > > +            qemu_dmabuf_dup_fd(dmabuf, fds);
> > >
> > >              trace_qemu_spice_gl_forward_dmabuf(ssd->qxl.id, width, h=
eight);
> > >              /* note: spice server will close the fd, so hand over a =
dup */
> > > -            spice_qxl_gl_scanout(&ssd->qxl, fd, width, height,
> > > -                                 stride, fourcc, y_0_top);
> > > +            spice_qxl_gl_scanout2(&ssd->qxl, fds, width, height,
> > > +                                  qemu_dmabuf_get_offset(dmabuf),
> > > +                                  qemu_dmabuf_get_stride(dmabuf),
> > > +                                  qemu_dmabuf_get_num_planes(dmabuf)=
,
> > > +                                  fourcc,
> > > +                                  qemu_dmabuf_get_modifier(dmabuf),
> > > +                                  y_0_top);
> > >          }
> > >          qemu_spice_gl_monitor_config(ssd, 0, 0, width, height);
> > >          ssd->guest_dmabuf_refresh =3D false;
> > > --
> > > 2.43.0
> > >
> > >
> >
> >
> > --
> > Marc-Andr=C3=A9 Lureau



--=20
Marc-Andr=C3=A9 Lureau

