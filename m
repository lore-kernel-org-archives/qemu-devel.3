Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 194F3C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 11:26:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9j65-0006gu-09; Tue, 29 Apr 2025 07:25:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1u9j62-0006gW-AX
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 07:25:54 -0400
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1u9j5x-0007DQ-FN
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 07:25:53 -0400
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-4775ce8a4b0so119615231cf.1
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 04:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745925945; x=1746530745; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BNPHmuZgcN/dyMKVj+0+CKONAq23vftsFyrogpoR3XQ=;
 b=XyBmU5EkqH1xWrAzpWBbzt5qHFGlS6OijQxMk9qn0dns03KVEne/MubxR8cLlD6qm5
 1W7/QC+jgAZrNjqa79as3Jqytk1CW0QYy93MI6nKx/FX632o1UWdqO6AzGVJOP75ro3T
 UI6yVQ5l0+TAp33xKqUPEJPwP1HaWTB9FnZ7LAxGww4ShFiPJSoMYlEBDHU+RLIKbce3
 N3AQcQFE4XbT8pUny1tKsGTJNFz4wKHkIdW5ltt8Rir12PSQrP6E56xpLexKNALHBdmB
 FRyK0uq+H4glGxIPAemXm9UF4p2w3jy0L1roYUvelj8XWz6jY9tm0dYWUljE/K9rWvYZ
 QwZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745925945; x=1746530745;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BNPHmuZgcN/dyMKVj+0+CKONAq23vftsFyrogpoR3XQ=;
 b=NhU6yiQ60pP8YcRhMRx6tEEJA0NIB8m7TMTJtAL9e3q1/7jj00DbyeVDIAx/UdjpW7
 kfKB22F08wwSPSJKJ3ZKRNiR+urCW+klrbfQRlsVev5qNKTAfdQrMWrZRRUCWamVJwSW
 jZRgKAVwrs+J0b4XUgmkGlcJVFc5oSiVjRQUvzgTiOws4CUUXnrbkaB2yjPrY8t3f57z
 d07JnFakHZyQXH/I6JjzghpLFIMX1CGduCdjASYqDSfDr6TPaw3lW8lDcRYRz10qANnq
 JhF2CDQ76HrLWHPvEiMSIswL7GvxMiAPgBCpukPyamGvQXi5bVWs3708J20AI8SMJYWq
 eeeA==
X-Gm-Message-State: AOJu0YyWWb9qDY8OSslFLOg2eySL4pciCkoNjkO0WfR7mAJKQSPMqNtq
 IaoUoVOZqpnQWvdzJS3+mc1zijrS2tQkFWWxfblkPNfZkfvS6Sic7PwCHrJ/t4+vNBVRtIiNTqn
 EWJsPJ4Bz8DBwfqubXbHI9bNoUSBRUNEjBPdJEg==
X-Gm-Gg: ASbGncsmztRVGT7cZWi69Jw4WsDC+l2BtsJARcH77kw0+x/mToI2mWYgjWO+uTyeUX4
 oH+rQRmp27sh28PB0XSL81MqPEt1BXWOtm5hF9F1KVjoweiD4bsxbz+twujHfXjYpwyMTD6J4XY
 S2T3HqEQr01M0XdOL1Z1Z7mop1M+hFb/h0qjofL/meHndOUv5Sn6JkP5U=
X-Google-Smtp-Source: AGHT+IHMeKn8mszYEL8UTBT21Fy4EdCSx/0LpRDkkPSwp72z2RjsFD0WY2JFqPVRDLXdx7XXmsT0WUE83Eh10l9p3n0=
X-Received: by 2002:ac8:5e14:0:b0:477:e17:6b01 with SMTP id
 d75a77b69052e-48133751cb7mr185562961cf.43.1745925944718; Tue, 29 Apr 2025
 04:25:44 -0700 (PDT)
MIME-Version: 1.0
References: <20250327025848.46962-1-yuq825@gmail.com>
 <20250327025848.46962-7-yuq825@gmail.com>
In-Reply-To: <20250327025848.46962-7-yuq825@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 29 Apr 2025 15:25:32 +0400
X-Gm-Features: ATxdqUHBqGKVEACQiJs-W8tKCj2qy_bEQhzv4-WscUY_fnt5hzmmPzsFITVWtw4
Message-ID: <CAJ+F1CJDCRZaFUyzV81EtjHEefoLV3k7xwg4Ygiq0NSENdd8Dg@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] ui/spice: support multi plane dmabuf scanout
To: yuq825@gmail.com
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::833;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x833.google.com
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

On Thu, Mar 27, 2025 at 6:59=E2=80=AFAM <yuq825@gmail.com> wrote:
>
> From: Qiang Yu <yuq825@gmail.com>
>
> We need spice version >=3D 0.15.3 which has spice_qxl_gl_scanout2
> API for multi plane scanout support.
>
> v2:
>   * use new dmabuf API and check length
>   * check spice_qxl_gl_scanout2 present instead of
>     bump spice version dependency
>
> Signed-off-by: Qiang Yu <yuq825@gmail.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
(for a single-plane case:)
Tested-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Spice didn't release yet with the new API. It should be okay, but I
will wait for the Spice release plan before sending a MR.

> ---
>  meson.build        |  5 +++
>  ui/spice-display.c | 90 +++++++++++++++++++++++++++++-----------------
>  2 files changed, 63 insertions(+), 32 deletions(-)
>
> diff --git a/meson.build b/meson.build
> index 9d9c11731f..7c4c81aa78 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -3173,6 +3173,11 @@ if host_os =3D=3D 'windows'
>      }''', name: '_lock_file and _unlock_file'))
>  endif
>
> +if spice.found()
> +  config_host_data.set('HAVE_SPICE_QXL_GL_SCANOUT2',
> +    cc.has_function('spice_qxl_gl_scanout2', dependencies: spice))
> +endif
> +
>  if host_os =3D=3D 'windows'
>    mingw_has_setjmp_longjmp =3D cc.links('''
>      #include <setjmp.h>
> diff --git a/ui/spice-display.c b/ui/spice-display.c
> index d7ebb3682d..38ee47e4c1 100644
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
> @@ -872,6 +874,26 @@ static void spice_gl_update(DisplayChangeListener *d=
cl,
>      ssd->gl_updates++;
>  }
>
> +static void spice_server_gl_scanout(QXLInstance *qxl,
> +                                    const int *fd,
> +                                    uint32_t width, uint32_t height,
> +                                    const uint32_t *offset,
> +                                    const uint32_t *stride,
> +                                    uint32_t num_planes, uint32_t format=
,
> +                                    uint64_t modifier, int y_0_top)
> +{
> +#ifdef HAVE_SPICE_QXL_GL_SCANOUT2
> +    spice_qxl_gl_scanout2(qxl, fd, width, height, offset, stride,
> +                          num_planes, format, modifier, y_0_top);
> +#else
> +    if (num_planes <=3D 1) {
> +        spice_qxl_gl_scanout(qxl, fd[0], width, height, stride[0], forma=
t, y_0_top);
> +    } else {
> +        error_report("SPICE server does not support multi plane GL scano=
ut");
> +    }
> +#endif
> +}
> +
>  static void spice_gl_switch(DisplayChangeListener *dcl,
>                              struct DisplaySurface *new_surface)
>  {
> @@ -884,16 +906,11 @@ static void spice_gl_switch(DisplayChangeListener *=
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
> @@ -904,10 +921,11 @@ static void spice_gl_switch(DisplayChangeListener *=
dcl,
>                                      fourcc);
>
>          /* note: spice server will close the fd */
> -        spice_qxl_gl_scanout(&ssd->qxl, fd[0],
> -                             surface_width(ssd->ds),
> -                             surface_height(ssd->ds),
> -                             stride[0], fourcc, false);
> +        spice_server_gl_scanout(&ssd->qxl, fd,
> +                                surface_width(ssd->ds),
> +                                surface_height(ssd->ds),
> +                                offset, stride, num_planes,
> +                                fourcc, modifier, false);
>          ssd->have_surface =3D true;
>          ssd->have_scanout =3D false;
>
> @@ -930,7 +948,8 @@ static void qemu_spice_gl_scanout_disable(DisplayChan=
geListener *dcl)
>      SimpleSpiceDisplay *ssd =3D container_of(dcl, SimpleSpiceDisplay, dc=
l);
>
>      trace_qemu_spice_gl_scanout_disable(ssd->qxl.id);
> -    spice_qxl_gl_scanout(&ssd->qxl, -1, 0, 0, 0, 0, false);
> +    spice_server_gl_scanout(&ssd->qxl, NULL, 0, 0, NULL, NULL, 0, DRM_FO=
RMAT_INVALID,
> +                            DRM_FORMAT_MOD_INVALID, false);
>      qemu_spice_gl_monitor_config(ssd, 0, 0, 0, 0);
>      ssd->have_surface =3D false;
>      ssd->have_scanout =3D false;
> @@ -948,22 +967,21 @@ static void qemu_spice_gl_scanout_texture(DisplayCh=
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
> +    spice_server_gl_scanout(&ssd->qxl, fd, backing_width, backing_height=
,
> +                            (uint32_t *)offset, (uint32_t *)stride, num_=
planes,
> +                            fourcc, modifier, y_0_top);
>      qemu_spice_gl_monitor_config(ssd, x, y, w, h);
>      ssd->have_surface =3D false;
>      ssd->have_scanout =3D true;
> @@ -1034,11 +1052,10 @@ static void qemu_spice_gl_update(DisplayChangeLis=
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
> @@ -1075,6 +1092,7 @@ static void qemu_spice_gl_update(DisplayChangeListe=
ner *dcl,
>                  ssd->blit_fb.height !=3D height) {
>                  int fds[DMABUF_MAX_PLANES], num_planes;
>                  uint32_t offsets[DMABUF_MAX_PLANES], strides[DMABUF_MAX_=
PLANES];
> +                uint64_t modifier;
>
>                  trace_qemu_spice_gl_render_dmabuf(ssd->qxl.id, width,
>                                                    height);
> @@ -1083,27 +1101,35 @@ static void qemu_spice_gl_update(DisplayChangeLis=
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
> +                spice_server_gl_scanout(&ssd->qxl, fds, width, height, o=
ffsets, strides,
> +                                        num_planes, fourcc, modifier, fa=
lse);
>              }
>          } else {
> -            stride =3D qemu_dmabuf_get_strides(dmabuf, NULL)[0];
> +            int fds[DMABUF_MAX_PLANES];
> +            int noffsets, nstrides;
> +            const uint32_t *offsets =3D qemu_dmabuf_get_offsets(dmabuf, =
&noffsets);
> +            const uint32_t *strides =3D qemu_dmabuf_get_strides(dmabuf, =
&nstrides);
> +            uint32_t num_planes =3D qemu_dmabuf_get_num_planes(dmabuf);
> +
> +            assert(noffsets >=3D num_planes);
> +            assert(nstrides >=3D num_planes);
> +
>              fourcc =3D qemu_dmabuf_get_fourcc(dmabuf);
>              y_0_top =3D qemu_dmabuf_get_y0_top(dmabuf);
> -            qemu_dmabuf_dup_fds(dmabuf, &fd, 1);
> +            qemu_dmabuf_dup_fds(dmabuf, fds, DMABUF_MAX_PLANES);
>
>              trace_qemu_spice_gl_forward_dmabuf(ssd->qxl.id, width, heigh=
t);
>              /* note: spice server will close the fd, so hand over a dup =
*/
> -            spice_qxl_gl_scanout(&ssd->qxl, fd, width, height,
> -                                 stride, fourcc, y_0_top);
> +            spice_server_gl_scanout(&ssd->qxl, fds, width, height,
> +                                    offsets, strides, num_planes,
> +                                    fourcc,
> +                                    qemu_dmabuf_get_modifier(dmabuf),
> +                                    y_0_top);
>          }
>          qemu_spice_gl_monitor_config(ssd, 0, 0, width, height);
>          ssd->guest_dmabuf_refresh =3D false;
> --
> 2.43.0
>


--=20
Marc-Andr=C3=A9 Lureau

