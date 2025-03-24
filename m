Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07790C36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 09:30:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twe8g-0005IK-MQ; Mon, 24 Mar 2025 05:30:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1twe8e-0005F3-VW
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 05:30:33 -0400
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1twe8c-0000dq-SZ
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 05:30:32 -0400
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-476805acddaso48028921cf.1
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 02:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742808628; x=1743413428; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GH/hfBW+1DtRhfgFa0lH6ukFMCurbYIWadTLpiL6pfU=;
 b=RW6MDcX9YJiMVwhHMiSnmgFY84S0iATRPlCizWpWQMFp2inJBEez6R77pOgH43E1Ka
 ltAIrU08Xi0fRmyrwZsvOEkaYhKetptqQk9h1Xz7+gwUIUjJVw6EIWAQ9tKZ6Ut4MIDp
 rVWxhcmaaZAQhF4yJqseZMZkV2Dyu8oBnChaI1m0XNNBB61/sgvnTbcgZYnZXx5boH2z
 8okfzOADW6HwW8ODd42Hx905OcIjukfiC8mWeLDKbQJg8OXujd2RaAE1R0MvJRZ2ANPm
 Yq0OeXRpWHkexi5Mtondmft0RcFtJYat0NYKEMgANlD/ZfcMjbULw09cCWS9svKg5wJz
 r0Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742808628; x=1743413428;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GH/hfBW+1DtRhfgFa0lH6ukFMCurbYIWadTLpiL6pfU=;
 b=kpOh4motMS1J95ToKfIEHF0sYENvwReupwo3No0q+/EXdIuRZpErHoJBm9Z6h96zh5
 5l4W1oh6m5a5/d21FB7OCjmnpHtBDhVUEkIq/sWiUdhCUV7f/+IL+qU91HIRGZbc3ElU
 m7lvciE/4WQSv5nYzCLj+p69ffopf6XXnk0XvAL1o3F/RZJQduirhSDbYwKXL1hZ6vDA
 LDEyP98LasO/bOqVw1E6JWEnBMpn3Qw/+R26GgNznSHW70SfkyLP764F7pZ65+dgnj4W
 fKkqk8o/lvUaDNwDrC6lF6E6De9wOM5iqFzmgR5gXseFY07cSJjaVoDcsaekODPq3et4
 CvrA==
X-Gm-Message-State: AOJu0Yzak09krVmpRqGIDrA/gwfs1MkZJq24x4n81ANMO92L2AqaogmI
 Po5HPm5N/QVtK6vLV2L8XkVZnS8tvrGq0nZiwfA4s5DFXEu5FEk4cckgYh7zyXJ/Wet5Kirhzg6
 c5qP8o93ifnAr5KYEtss08pjzrP4=
X-Gm-Gg: ASbGncvegB7SzWJIrBjc/b2jqjuEw0Ply6y6OVAVijP28SyuyzX7wJi46HUUVEAmDbh
 KxMyWTDf2OX6LSM2fXpYXacL1raDajoiPbQzAE7eVNSztYBbf4UA8zOPKKtJJt/HyQrsl3ObsD7
 mrtEsa9x8kTqjuvBFzCydCf/DY859dbwcYKy8S5VKZKGn/ZL1VNV14huhQQCg=
X-Google-Smtp-Source: AGHT+IHe4ztzLDxnsVim2wEAoMIPZ0rC5rFQbWcgzl9OoIZVtG98ZHI42KB+Za6ls4+klh66gcuzFBF3S2d+O9Lt4dU=
X-Received: by 2002:a05:622a:5449:b0:476:923a:f1cb with SMTP id
 d75a77b69052e-4771de13fccmr227152181cf.41.1742808628010; Mon, 24 Mar 2025
 02:30:28 -0700 (PDT)
MIME-Version: 1.0
References: <20250324081922.359369-1-yuq825@gmail.com>
 <20250324081922.359369-7-yuq825@gmail.com>
In-Reply-To: <20250324081922.359369-7-yuq825@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 24 Mar 2025 13:30:16 +0400
X-Gm-Features: AQ5f1JpFTfUNQp0-qKOAYi3QhnCi-tpI6Cqs98alZnFrrHcbIlXiwn8vcwOF8Ic
Message-ID: <CAJ+F1C+NCda4V_1n-zL3GA_e+HabO6sbKBxWQb_S_zzPPjLNQQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] ui/spice: support multi plane dmabuf scanout
To: yuq825@gmail.com
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

On Mon, Mar 24, 2025 at 12:20=E2=80=AFPM <yuq825@gmail.com> wrote:
>
> From: Qiang Yu <yuq825@gmail.com>
>
> Signed-off-by: Qiang Yu <yuq825@gmail.com>
> ---
>  meson.build        |  2 +-
>  ui/spice-display.c | 65 +++++++++++++++++++++++-----------------------
>  2 files changed, 34 insertions(+), 33 deletions(-)
>
> diff --git a/meson.build b/meson.build
> index 9d9c11731f..b87704a83b 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1329,7 +1329,7 @@ if get_option('spice') \
>               .require(pixman.found(),
>                        error_message: 'cannot enable SPICE if pixman is n=
ot available') \
>               .allowed()
> -  spice =3D dependency('spice-server', version: '>=3D0.14.0',
> +  spice =3D dependency('spice-server', version: '>=3D0.14.3',

I am okay with bumping dependency requirements, but the nicer
alternative would be to allow the current version and check the
existence of the new API/function instead.


>                       required: get_option('spice'),
>                       method: 'pkg-config')
>  endif
> diff --git a/ui/spice-display.c b/ui/spice-display.c
> index b7016ece6a..46b6d5dfc9 100644
> --- a/ui/spice-display.c
> +++ b/ui/spice-display.c
> @@ -28,6 +28,8 @@
>
>  #include "ui/spice-display.h"
>
> +#include "standard-headers/drm/drm_fourcc.h"
> +
>  bool spice_opengl;
>
>  int qemu_spice_rect_is_empty(const QXLRect* r)
> @@ -884,16 +886,11 @@ static void spice_gl_switch(DisplayChangeListener *=
dcl,
>      if (ssd->ds) {
>          uint32_t offset[DMABUF_MAX_PLANES], stride[DMABUF_MAX_PLANES];
>          int fd[DMABUF_MAX_PLANES], num_planes, fourcc;
> +        uint64_t modifier;
>
>          surface_gl_create_texture(ssd->gls, ssd->ds);
>          if (!egl_dmabuf_export_texture(ssd->ds->texture, fd, (EGLint *)o=
ffset,
> -                                       (EGLint *)stride, &fourcc, &num_p=
lanes, NULL)) {
> -            surface_gl_destroy_texture(ssd->gls, ssd->ds);
> -            return;
> -        }
> -
> -        if (num_planes > 1) {
> -            fprintf(stderr, "%s: does not support multi-plane texture\n"=
, __func__);
> +                                       (EGLint *)stride, &fourcc, &num_p=
lanes, &modifier)) {
>              surface_gl_destroy_texture(ssd->gls, ssd->ds);
>              return;
>          }
> @@ -904,10 +901,11 @@ static void spice_gl_switch(DisplayChangeListener *=
dcl,
>                                      fourcc);
>
>          /* note: spice server will close the fd */
> -        spice_qxl_gl_scanout(&ssd->qxl, fd[0],
> -                             surface_width(ssd->ds),
> -                             surface_height(ssd->ds),
> -                             stride[0], fourcc, false);
> +        spice_qxl_gl_scanout2(&ssd->qxl, fd,
> +                              surface_width(ssd->ds),
> +                              surface_height(ssd->ds),
> +                              offset, stride, num_planes,
> +                              fourcc, modifier, false);
>          ssd->have_surface =3D true;
>          ssd->have_scanout =3D false;
>
> @@ -930,7 +928,8 @@ static void qemu_spice_gl_scanout_disable(DisplayChan=
geListener *dcl)
>      SimpleSpiceDisplay *ssd =3D container_of(dcl, SimpleSpiceDisplay, dc=
l);
>
>      trace_qemu_spice_gl_scanout_disable(ssd->qxl.id);
> -    spice_qxl_gl_scanout(&ssd->qxl, -1, 0, 0, 0, 0, false);
> +    spice_qxl_gl_scanout2(&ssd->qxl, NULL, 0, 0, NULL, NULL, 0, DRM_FORM=
AT_INVALID,
> +                          DRM_FORMAT_MOD_INVALID, false);
>      qemu_spice_gl_monitor_config(ssd, 0, 0, 0, 0);
>      ssd->have_surface =3D false;
>      ssd->have_scanout =3D false;
> @@ -948,22 +947,21 @@ static void qemu_spice_gl_scanout_texture(DisplayCh=
angeListener *dcl,
>      SimpleSpiceDisplay *ssd =3D container_of(dcl, SimpleSpiceDisplay, dc=
l);
>      EGLint offset[DMABUF_MAX_PLANES], stride[DMABUF_MAX_PLANES], fourcc =
=3D 0;
>      int fd[DMABUF_MAX_PLANES], num_planes;
> +    uint64_t modifier;
>
>      assert(tex_id);
>      if (!egl_dmabuf_export_texture(tex_id, fd, offset, stride, &fourcc,
> -                                   &num_planes, NULL)) {
> +                                   &num_planes, &modifier)) {
>          fprintf(stderr, "%s: failed to export dmabuf for texture\n", __f=
unc__);
>          return;
>      }
> -    if (num_planes > 1) {
> -        fprintf(stderr, "%s: does not support multi-plane dmabuf\n", __f=
unc__);
> -        return;
> -    }
> +
>      trace_qemu_spice_gl_scanout_texture(ssd->qxl.id, w, h, fourcc);
>
>      /* note: spice server will close the fd */
> -    spice_qxl_gl_scanout(&ssd->qxl, fd[0], backing_width, backing_height=
,
> -                         stride[0], fourcc, y_0_top);
> +    spice_qxl_gl_scanout2(&ssd->qxl, fd, backing_width, backing_height,
> +                          (uint32_t *)offset, (uint32_t *)stride, num_pl=
anes,
> +                          fourcc, modifier, y_0_top);
>      qemu_spice_gl_monitor_config(ssd, x, y, w, h);
>      ssd->have_surface =3D false;
>      ssd->have_scanout =3D true;
> @@ -1034,11 +1032,10 @@ static void qemu_spice_gl_update(DisplayChangeLis=
tener *dcl,
>                                   uint32_t x, uint32_t y, uint32_t w, uin=
t32_t h)
>  {
>      SimpleSpiceDisplay *ssd =3D container_of(dcl, SimpleSpiceDisplay, dc=
l);
> -    EGLint stride =3D 0, fourcc =3D 0;
> +    EGLint fourcc =3D 0;
>      bool render_cursor =3D false;
>      bool y_0_top =3D false; /* FIXME */
>      uint64_t cookie;
> -    int fd;
>      uint32_t width, height, texture;
>
>      if (!ssd->have_scanout) {
> @@ -1075,6 +1072,7 @@ static void qemu_spice_gl_update(DisplayChangeListe=
ner *dcl,
>                  ssd->blit_fb.height !=3D height) {
>                  int fds[DMABUF_MAX_PLANES], num_planes;
>                  uint32_t offsets[DMABUF_MAX_PLANES], strides[DMABUF_MAX_=
PLANES];
> +                uint64_t modifier;
>
>                  trace_qemu_spice_gl_render_dmabuf(ssd->qxl.id, width,
>                                                    height);
> @@ -1083,27 +1081,30 @@ static void qemu_spice_gl_update(DisplayChangeLis=
tener *dcl,
>                                       width, height);
>                  if (!egl_dmabuf_export_texture(ssd->blit_fb.texture, fds=
,
>                                                 (EGLint *)offsets, (EGLin=
t *)strides,
> -                                               &fourcc, &num_planes, NUL=
L)) {
> +                                               &fourcc, &num_planes, &mo=
difier)) {
>                      fprintf(stderr, "%s: failed to export dmabuf for tex=
ture\n", __func__);
>                      return;
>                  }
> -                if (num_planes > 1) {
> -                    fprintf(stderr, "%s: does not support multi-plane dm=
abuf\n", __func__);
> -                    return;
> -                }
> -                spice_qxl_gl_scanout(&ssd->qxl, fds[0], width, height,
> -                                     strides[0], fourcc, false);
> +
> +                spice_qxl_gl_scanout2(&ssd->qxl, fds, width, height, off=
sets, strides,
> +                                      num_planes, fourcc, modifier, fals=
e);
>              }
>          } else {
> -            stride =3D qemu_dmabuf_get_stride(dmabuf)[0];
> +            int fds[DMABUF_MAX_PLANES];
> +
>              fourcc =3D qemu_dmabuf_get_fourcc(dmabuf);
>              y_0_top =3D qemu_dmabuf_get_y0_top(dmabuf);
> -            qemu_dmabuf_dup_fd(dmabuf, &fd);
> +            qemu_dmabuf_dup_fd(dmabuf, fds);
>
>              trace_qemu_spice_gl_forward_dmabuf(ssd->qxl.id, width, heigh=
t);
>              /* note: spice server will close the fd, so hand over a dup =
*/
> -            spice_qxl_gl_scanout(&ssd->qxl, fd, width, height,
> -                                 stride, fourcc, y_0_top);
> +            spice_qxl_gl_scanout2(&ssd->qxl, fds, width, height,
> +                                  qemu_dmabuf_get_offset(dmabuf),
> +                                  qemu_dmabuf_get_stride(dmabuf),
> +                                  qemu_dmabuf_get_num_planes(dmabuf),
> +                                  fourcc,
> +                                  qemu_dmabuf_get_modifier(dmabuf),
> +                                  y_0_top);
>          }
>          qemu_spice_gl_monitor_config(ssd, 0, 0, width, height);
>          ssd->guest_dmabuf_refresh =3D false;
> --
> 2.43.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

