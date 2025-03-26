Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54B7EC36005
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 01:47:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txFqR-0002u0-AB; Tue, 25 Mar 2025 21:46:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuq825@gmail.com>) id 1txFqO-0002tK-AK
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 21:46:12 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuq825@gmail.com>) id 1txFqL-0002XM-NW
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 21:46:12 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5e5dce099f4so8480186a12.1
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 18:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742953567; x=1743558367; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SW7Jqb3tAP0eW4e00rR7fLZMBiLk2atO0VRy14Fygpw=;
 b=WjctEyvdDYL/pOKhfOQEaO5qE6LGVZAxVRqDMy8GZ9OkoEuNaqsu70E3Ox36lmPzxs
 Zb/K/yBp6qKPuI18r9lTeywKd+m7ghN3aP13aUhqcRTXQI7vzges8LkCA3oh/6AI0Rzd
 MoPRtHy8PR+0tf5kzZg37NtgNACLGr0AhElamdqwhOThUUC5NsARMojLa45BwNybbHx0
 v/L+vnGuFvZdZDhHFVVilTUC16dzGhD5au0stvZ+9hf1v4ZTXeXJM7w8jogjTomKkwiX
 tA7UH1UrWCutc9cw50G3T6vb1QfCcb6DOZmveMlfdSGW3KG3luf9ywSCr5T1x56UcvZ/
 8wRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742953567; x=1743558367;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SW7Jqb3tAP0eW4e00rR7fLZMBiLk2atO0VRy14Fygpw=;
 b=QqTzk9G2uoK39BM7YOhVRqp23ZCkDcletbP32UbRXsWdDVzdDKiocVhfOkXWVYjVBh
 85adtJrqwe8IfzWpu4MS4WAzOQP59b3+4EHZX1FSOAa+V+hmXRTvCGXnF1/hJJRpkO9b
 wsHdD56sK2h8BLDFACio55g1anPJw0q0HFb/JxCKYbI8YDPmRRSVICQJA7UQ9m4WDe6G
 koFUaotLhrogyMAvwWD1hf7iLlyZH9K5NQRJEkkBVQ8uLoPIEWXNl1edKGxgs9OIV1lN
 VNiguTwCfmuJp/bbkAosq1htvLfruJpzrBFl8+jrMrMUB9sqnnkyZpVfcUwNMqOQ72Q6
 /WBw==
X-Gm-Message-State: AOJu0Ywe170cobDmWcNgqISWWWhEWgQWtruolXY0whwX2tJJI/mocJZT
 8l47ehSPPOLwTm7F22kV+UQ2CjoA9SEgpQ456WPULUbhVv8Y1hjhxt3TSmXVK6eyvAOrVk649wO
 LiOIHG2Zwe69xxPZ44E1v1ogwaKE=
X-Gm-Gg: ASbGncvVNEBiR0AlL14UGSyWaC+fo6nhTNyCttxok1vLVMIbTsuGPGtFEg7v2iSGsjb
 nBDCZz2+aFv9GtEGpGUsxXo5reg2tplgrpPvz0+IqafqE5V+JYeznMvYa8z1G6aq/bMalCRWzX1
 NlPRxQei6RsQqqPW+xFDBiCFyjPlmRlEWWjDpNBg==
X-Google-Smtp-Source: AGHT+IGtRaDK7xW3GqcK4KQLMbJbrKhDMo8874bJEcxW2YhIUVrKFBEffaZE1ONNuc4Cf56ax7lYlopZZhwrBD5wKos=
X-Received: by 2002:a05:6402:2805:b0:5e8:bf18:587 with SMTP id
 4fb4d7f45d1cf-5ebcd45c1ebmr17823769a12.16.1742953566972; Tue, 25 Mar 2025
 18:46:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250324081922.359369-1-yuq825@gmail.com>
 <20250324081922.359369-7-yuq825@gmail.com>
 <CAJ+F1C+NCda4V_1n-zL3GA_e+HabO6sbKBxWQb_S_zzPPjLNQQ@mail.gmail.com>
 <CAKGbVbtcih4g1sbeDa3XChNFY6tX1tA6Jg4sj+pCvc7V_xoOJA@mail.gmail.com>
 <CAJ+F1CJvkS2iQpd=wxqO+_n9SBvDSC55cLPbzLHqLG06ZjGu4g@mail.gmail.com>
In-Reply-To: <CAJ+F1CJvkS2iQpd=wxqO+_n9SBvDSC55cLPbzLHqLG06ZjGu4g@mail.gmail.com>
From: Qiang Yu <yuq825@gmail.com>
Date: Wed, 26 Mar 2025 09:45:55 +0800
X-Gm-Features: AQ5f1JqyR-Yanysl8W4OQx2manZ1A7iNRLoBvBjvOCRLftOh_b6vKjwtaeMFndE
Message-ID: <CAKGbVbvmg1-ZRZsX6L6FwnwS6++xWsvuC-r-CSQSiUW7r1U7cA@mail.gmail.com>
Subject: Re: [PATCH 6/6] ui/spice: support multi plane dmabuf scanout
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=yuq825@gmail.com; helo=mail-ed1-x532.google.com
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

On Mon, Mar 24, 2025 at 10:02=E2=80=AFPM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
>
> On Mon, Mar 24, 2025 at 5:35=E2=80=AFPM Qiang Yu <yuq825@gmail.com> wrote=
:
> >
> > On Mon, Mar 24, 2025 at 5:30=E2=80=AFPM Marc-Andr=C3=A9 Lureau
> > <marcandre.lureau@gmail.com> wrote:
> > >
> > > Hi
> > >
> > > On Mon, Mar 24, 2025 at 12:20=E2=80=AFPM <yuq825@gmail.com> wrote:
> > > >
> > > > From: Qiang Yu <yuq825@gmail.com>
> > > >
> > > > Signed-off-by: Qiang Yu <yuq825@gmail.com>
> > > > ---
> > > >  meson.build        |  2 +-
> > > >  ui/spice-display.c | 65 +++++++++++++++++++++++-------------------=
----
> > > >  2 files changed, 34 insertions(+), 33 deletions(-)
> > > >
> > > > diff --git a/meson.build b/meson.build
> > > > index 9d9c11731f..b87704a83b 100644
> > > > --- a/meson.build
> > > > +++ b/meson.build
> > > > @@ -1329,7 +1329,7 @@ if get_option('spice') \
> > > >               .require(pixman.found(),
> > > >                        error_message: 'cannot enable SPICE if pixma=
n is not available') \
> > > >               .allowed()
> > > > -  spice =3D dependency('spice-server', version: '>=3D0.14.0',
> > > > +  spice =3D dependency('spice-server', version: '>=3D0.14.3',
> > >
> > > I am okay with bumping dependency requirements, but the nicer
> > > alternative would be to allow the current version and check the
> > > existence of the new API/function instead.
> > >
> > I'm not familiar with how qemu handle new API dependency, but isn't it =
much
> > convenient to just bump lib version instead of a macro all around? And =
I can't
> > see similar macro in meson.build
>
> Yes it is generally simpler to bump requirements, but as Daniel
> hinted, we have policies about supporting older environments.
>
> For your series, I think we could simply have:
> if spice.found()
>   config_host_data.set('HAVE_SPICE_QXL_GL_SCANOUT2',
>     cc.has_function('spice_qxl_gl_scanout2', dependencies: spice))
> endif
>
This serial is more like a bug fix instead of feature adding. Because witho=
ut
new spice-server, qemu spice gl scanout support is completely broken when
run on multi plane GPU driver. If not bumping spice version, user may still
suffer this problem when using new qemu and old spice. Is this OK?

>
> >
> > >
> > > >                       required: get_option('spice'),
> > > >                       method: 'pkg-config')
> > > >  endif
> > > > diff --git a/ui/spice-display.c b/ui/spice-display.c
> > > > index b7016ece6a..46b6d5dfc9 100644
> > > > --- a/ui/spice-display.c
> > > > +++ b/ui/spice-display.c
> > > > @@ -28,6 +28,8 @@
> > > >
> > > >  #include "ui/spice-display.h"
> > > >
> > > > +#include "standard-headers/drm/drm_fourcc.h"
> > > > +
> > > >  bool spice_opengl;
> > > >
> > > >  int qemu_spice_rect_is_empty(const QXLRect* r)
> > > > @@ -884,16 +886,11 @@ static void spice_gl_switch(DisplayChangeList=
ener *dcl,
> > > >      if (ssd->ds) {
> > > >          uint32_t offset[DMABUF_MAX_PLANES], stride[DMABUF_MAX_PLAN=
ES];
> > > >          int fd[DMABUF_MAX_PLANES], num_planes, fourcc;
> > > > +        uint64_t modifier;
> > > >
> > > >          surface_gl_create_texture(ssd->gls, ssd->ds);
> > > >          if (!egl_dmabuf_export_texture(ssd->ds->texture, fd, (EGLi=
nt *)offset,
> > > > -                                       (EGLint *)stride, &fourcc, =
&num_planes, NULL)) {
> > > > -            surface_gl_destroy_texture(ssd->gls, ssd->ds);
> > > > -            return;
> > > > -        }
> > > > -
> > > > -        if (num_planes > 1) {
> > > > -            fprintf(stderr, "%s: does not support multi-plane text=
ure\n", __func__);
> > > > +                                       (EGLint *)stride, &fourcc, =
&num_planes, &modifier)) {
> > > >              surface_gl_destroy_texture(ssd->gls, ssd->ds);
> > > >              return;
> > > >          }
> > > > @@ -904,10 +901,11 @@ static void spice_gl_switch(DisplayChangeList=
ener *dcl,
> > > >                                      fourcc);
> > > >
> > > >          /* note: spice server will close the fd */
> > > > -        spice_qxl_gl_scanout(&ssd->qxl, fd[0],
> > > > -                             surface_width(ssd->ds),
> > > > -                             surface_height(ssd->ds),
> > > > -                             stride[0], fourcc, false);
> > > > +        spice_qxl_gl_scanout2(&ssd->qxl, fd,
> > > > +                              surface_width(ssd->ds),
> > > > +                              surface_height(ssd->ds),
> > > > +                              offset, stride, num_planes,
> > > > +                              fourcc, modifier, false);
> > > >          ssd->have_surface =3D true;
> > > >          ssd->have_scanout =3D false;
> > > >
> > > > @@ -930,7 +928,8 @@ static void qemu_spice_gl_scanout_disable(Displ=
ayChangeListener *dcl)
> > > >      SimpleSpiceDisplay *ssd =3D container_of(dcl, SimpleSpiceDispl=
ay, dcl);
> > > >
> > > >      trace_qemu_spice_gl_scanout_disable(ssd->qxl.id);
> > > > -    spice_qxl_gl_scanout(&ssd->qxl, -1, 0, 0, 0, 0, false);
> > > > +    spice_qxl_gl_scanout2(&ssd->qxl, NULL, 0, 0, NULL, NULL, 0, DR=
M_FORMAT_INVALID,
> > > > +                          DRM_FORMAT_MOD_INVALID, false);
> > > >      qemu_spice_gl_monitor_config(ssd, 0, 0, 0, 0);
> > > >      ssd->have_surface =3D false;
> > > >      ssd->have_scanout =3D false;
> > > > @@ -948,22 +947,21 @@ static void qemu_spice_gl_scanout_texture(Dis=
playChangeListener *dcl,
> > > >      SimpleSpiceDisplay *ssd =3D container_of(dcl, SimpleSpiceDispl=
ay, dcl);
> > > >      EGLint offset[DMABUF_MAX_PLANES], stride[DMABUF_MAX_PLANES], f=
ourcc =3D 0;
> > > >      int fd[DMABUF_MAX_PLANES], num_planes;
> > > > +    uint64_t modifier;
> > > >
> > > >      assert(tex_id);
> > > >      if (!egl_dmabuf_export_texture(tex_id, fd, offset, stride, &fo=
urcc,
> > > > -                                   &num_planes, NULL)) {
> > > > +                                   &num_planes, &modifier)) {
> > > >          fprintf(stderr, "%s: failed to export dmabuf for texture\n=
", __func__);
> > > >          return;
> > > >      }
> > > > -    if (num_planes > 1) {
> > > > -        fprintf(stderr, "%s: does not support multi-plane dmabuf\n=
", __func__);
> > > > -        return;
> > > > -    }
> > > > +
> > > >      trace_qemu_spice_gl_scanout_texture(ssd->qxl.id, w, h, fourcc)=
;
> > > >
> > > >      /* note: spice server will close the fd */
> > > > -    spice_qxl_gl_scanout(&ssd->qxl, fd[0], backing_width, backing_=
height,
> > > > -                         stride[0], fourcc, y_0_top);
> > > > +    spice_qxl_gl_scanout2(&ssd->qxl, fd, backing_width, backing_he=
ight,
> > > > +                          (uint32_t *)offset, (uint32_t *)stride, =
num_planes,
> > > > +                          fourcc, modifier, y_0_top);
> > > >      qemu_spice_gl_monitor_config(ssd, x, y, w, h);
> > > >      ssd->have_surface =3D false;
> > > >      ssd->have_scanout =3D true;
> > > > @@ -1034,11 +1032,10 @@ static void qemu_spice_gl_update(DisplayCha=
ngeListener *dcl,
> > > >                                   uint32_t x, uint32_t y, uint32_t =
w, uint32_t h)
> > > >  {
> > > >      SimpleSpiceDisplay *ssd =3D container_of(dcl, SimpleSpiceDispl=
ay, dcl);
> > > > -    EGLint stride =3D 0, fourcc =3D 0;
> > > > +    EGLint fourcc =3D 0;
> > > >      bool render_cursor =3D false;
> > > >      bool y_0_top =3D false; /* FIXME */
> > > >      uint64_t cookie;
> > > > -    int fd;
> > > >      uint32_t width, height, texture;
> > > >
> > > >      if (!ssd->have_scanout) {
> > > > @@ -1075,6 +1072,7 @@ static void qemu_spice_gl_update(DisplayChang=
eListener *dcl,
> > > >                  ssd->blit_fb.height !=3D height) {
> > > >                  int fds[DMABUF_MAX_PLANES], num_planes;
> > > >                  uint32_t offsets[DMABUF_MAX_PLANES], strides[DMABU=
F_MAX_PLANES];
> > > > +                uint64_t modifier;
> > > >
> > > >                  trace_qemu_spice_gl_render_dmabuf(ssd->qxl.id, wid=
th,
> > > >                                                    height);
> > > > @@ -1083,27 +1081,30 @@ static void qemu_spice_gl_update(DisplayCha=
ngeListener *dcl,
> > > >                                       width, height);
> > > >                  if (!egl_dmabuf_export_texture(ssd->blit_fb.textur=
e, fds,
> > > >                                                 (EGLint *)offsets, =
(EGLint *)strides,
> > > > -                                               &fourcc, &num_plane=
s, NULL)) {
> > > > +                                               &fourcc, &num_plane=
s, &modifier)) {
> > > >                      fprintf(stderr, "%s: failed to export dmabuf f=
or texture\n", __func__);
> > > >                      return;
> > > >                  }
> > > > -                if (num_planes > 1) {
> > > > -                    fprintf(stderr, "%s: does not support multi-pl=
ane dmabuf\n", __func__);
> > > > -                    return;
> > > > -                }
> > > > -                spice_qxl_gl_scanout(&ssd->qxl, fds[0], width, hei=
ght,
> > > > -                                     strides[0], fourcc, false);
> > > > +
> > > > +                spice_qxl_gl_scanout2(&ssd->qxl, fds, width, heigh=
t, offsets, strides,
> > > > +                                      num_planes, fourcc, modifier=
, false);
> > > >              }
> > > >          } else {
> > > > -            stride =3D qemu_dmabuf_get_stride(dmabuf)[0];
> > > > +            int fds[DMABUF_MAX_PLANES];
> > > > +
> > > >              fourcc =3D qemu_dmabuf_get_fourcc(dmabuf);
> > > >              y_0_top =3D qemu_dmabuf_get_y0_top(dmabuf);
> > > > -            qemu_dmabuf_dup_fd(dmabuf, &fd);
> > > > +            qemu_dmabuf_dup_fd(dmabuf, fds);
> > > >
> > > >              trace_qemu_spice_gl_forward_dmabuf(ssd->qxl.id, width,=
 height);
> > > >              /* note: spice server will close the fd, so hand over =
a dup */
> > > > -            spice_qxl_gl_scanout(&ssd->qxl, fd, width, height,
> > > > -                                 stride, fourcc, y_0_top);
> > > > +            spice_qxl_gl_scanout2(&ssd->qxl, fds, width, height,
> > > > +                                  qemu_dmabuf_get_offset(dmabuf),
> > > > +                                  qemu_dmabuf_get_stride(dmabuf),
> > > > +                                  qemu_dmabuf_get_num_planes(dmabu=
f),
> > > > +                                  fourcc,
> > > > +                                  qemu_dmabuf_get_modifier(dmabuf)=
,
> > > > +                                  y_0_top);
> > > >          }
> > > >          qemu_spice_gl_monitor_config(ssd, 0, 0, width, height);
> > > >          ssd->guest_dmabuf_refresh =3D false;
> > > > --
> > > > 2.43.0
> > > >
> > > >
> > >
> > >
> > > --
> > > Marc-Andr=C3=A9 Lureau
>
>
>
> --
> Marc-Andr=C3=A9 Lureau

