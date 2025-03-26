Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FF9BC36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 11:05:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txOYK-0008Cf-R5; Wed, 26 Mar 2025 07:04:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1txOXu-000856-JJ
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 07:03:42 -0400
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1txOXr-0001YJ-KK
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 07:03:41 -0400
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-477296dce76so40356071cf.3
 for <qemu-devel@nongnu.org>; Wed, 26 Mar 2025 04:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742987018; x=1743591818; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4YxsTWgtAz93C25tbko7byv9rzXfbIXWcnm3e2MKIGc=;
 b=bztarESTO/gd1/Lyfr/3Iz4S5m6Ld71QULZOdCsP73zQiWd/7aXLwfocXSzZolVXJN
 TWJYNqWCXIbTgH++rXlHH7e5y9C8af9Bh2db72WcOQgHzAsmgv6g9seuo1dOB3R6HGH7
 mkrcU0OI2/8mlKpayha4X1PGsamkNsqiibBTrzIEMqlhVo+IcrXq2US6vlMEXVe6XIvl
 kUKoF8h9qHGCd23c3Jeij1kqPELQ6a/0lBqd8DyM7IirCG3xhFTewtBG20ShErxwo5Yv
 zKvEShb2m4xcwiOqzw/mv9rdwHQPaZvSF6IGjlfnAaD0W0MsWTUa2N61qKwFuO6TVo7J
 9byA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742987018; x=1743591818;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4YxsTWgtAz93C25tbko7byv9rzXfbIXWcnm3e2MKIGc=;
 b=RO1H7xZ0gv04+S1263X+dAMCsbYmvyk1IGsBpNIVNBjnm79va43gTM2WhScx5n/RLh
 m2J8c8/w01q5GcpKnPgL3a//imDYExEE3YSxJvYyEObkbWqPHxsK+kWlvIlhtmdtqkMB
 zS/L5ZEdx/me0FJaL0ke+gcwETYDfCxySZ1NSE73aOBtz1uWe3xrtLw1k5EJUxbLMoe5
 SLwSNtiHaKekuF4+GTDkcA0sIGStV9V8tybfyD4oTihXrM6r8Q7wMHYB3+pmx7TtqXvc
 8u0Jx2Z1WKN/Wz/XwxPdmBTKDKKkDdXoVB5cxMenAUBN+XMvOgL2yXJosJhpvNYnhrYu
 b/mg==
X-Gm-Message-State: AOJu0YxrIriVCiCySIFh6/NUFYMdPmg16236Fn/hT0kfYaU/+1maWlTb
 j1ZSgL6Wo2hqYJ1We+SrB97bNNLaO5Mo004fscPg/lRb4LAqZ7dk4EIdYAhp5EJHg9RSuDAvsr+
 QQKj0DEpioncvtYcqGQVepaOFPzX0tdRZHLs=
X-Gm-Gg: ASbGnctkazBgq6MJBfeRw+VBdNuXIVoGBYsyz3nEucOAE/zjB04bo748sttcxfWovif
 0eO5RQ9KoYR+b1hkiwZki2RK4PVyxp6acF6lEnDdzxzEKP2pFG/GnkCEMtIpI0lj4HbMfP1cn8+
 JMRNEaah1nqTNvsUmzYcTqHmHvwbc1UX8swivVLdf6J8OJ1AoI/CN9w8MBlbcJcjg+pyypuw==
X-Google-Smtp-Source: AGHT+IGuw8xxq2YpHrzO7Xs4I+gRPbKQcJFmyvyo1cLIt9T5qO9V1SWol44jKcRFXHOov3Z+Le/Gz6mp7uLgCwpZEVQ=
X-Received: by 2002:a05:622a:259b:b0:476:8a27:6b01 with SMTP id
 d75a77b69052e-4771de4f520mr402681871cf.47.1742987018475; Wed, 26 Mar 2025
 04:03:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250326093418.397269-1-yuq825@gmail.com>
 <20250326093418.397269-5-yuq825@gmail.com>
In-Reply-To: <20250326093418.397269-5-yuq825@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 26 Mar 2025 15:03:23 +0400
X-Gm-Features: AQ5f1JpI5rDx2foX_5PnjQILVGgC8f1A43s5w8eEoTJ9Olav5flR_PXR0tj0RAA
Message-ID: <CAJ+F1CKH_7HktXeMRX3Dv3i-foRorHVHpk4bxch1YFD22YR_Wg@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] ui/egl: support multi-plane dmabuf when egl
 export/import
To: yuq825@gmail.com
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::829;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x829.google.com
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

On Wed, Mar 26, 2025 at 1:34=E2=80=AFPM <yuq825@gmail.com> wrote:
>
> From: Qiang Yu <yuq825@gmail.com>
>
> v2:
>   * use new dmabuf API and check length
>
> Signed-off-by: Qiang Yu <yuq825@gmail.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  include/ui/egl-helpers.h |  5 ++-
>  ui/dbus-listener.c       | 19 +++++----
>  ui/egl-helpers.c         | 91 ++++++++++++++++++++++++++++++----------
>  ui/spice-display.c       | 58 ++++++++++++++++---------
>  4 files changed, 121 insertions(+), 52 deletions(-)
>
> diff --git a/include/ui/egl-helpers.h b/include/ui/egl-helpers.h
> index 4b8c0d2281..fb80e15142 100644
> --- a/include/ui/egl-helpers.h
> +++ b/include/ui/egl-helpers.h
> @@ -46,8 +46,9 @@ extern int qemu_egl_rn_fd;
>  extern struct gbm_device *qemu_egl_rn_gbm_dev;
>
>  int egl_rendernode_init(const char *rendernode, DisplayGLMode mode);
> -int egl_get_fd_for_texture(uint32_t tex_id, EGLint *stride, EGLint *four=
cc,
> -                           EGLuint64KHR *modifier);
> +bool egl_dmabuf_export_texture(uint32_t tex_id, int *fd, EGLint *offset,
> +                               EGLint *stride, EGLint *fourcc, int *num_=
planes,
> +                               EGLuint64KHR *modifier);
>
>  void egl_dmabuf_import_texture(QemuDmaBuf *dmabuf);
>  void egl_dmabuf_release_texture(QemuDmaBuf *dmabuf);
> diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
> index 65373d519c..90147972cd 100644
> --- a/ui/dbus-listener.c
> +++ b/ui/dbus-listener.c
> @@ -504,19 +504,22 @@ static void dbus_scanout_texture(DisplayChangeListe=
ner *dcl,
>                                 backing_width, backing_height, x, y, w, h=
);
>  #ifdef CONFIG_GBM
>      g_autoptr(QemuDmaBuf) dmabuf =3D NULL;
> -    int fd;
> -    uint32_t offset =3D 0, stride, fourcc;
> +    int fd[DMABUF_MAX_PLANES], num_planes;
> +    uint32_t offset[DMABUF_MAX_PLANES], stride[DMABUF_MAX_PLANES], fourc=
c;
>      uint64_t modifier;
>
>      assert(tex_id);
> -    fd =3D egl_get_fd_for_texture(tex_id, (EGLint *)&stride, (EGLint *)&=
fourcc,
> -                                &modifier);
> -    if (fd < 0) {
> -        error_report("%s: failed to get fd for texture", __func__);
> +    if (!egl_dmabuf_export_texture(tex_id, fd, (EGLint *)offset, (EGLint=
 *)stride,
> +                                   (EGLint *)&fourcc, &num_planes, &modi=
fier)) {
> +        error_report("%s: failed to export dmabuf for texture", __func__=
);
> +        return;
> +    }
> +    if (num_planes > 1) {
> +        error_report("%s: does not support multi-plane dmabuf", __func__=
);
>          return;
>      }
> -    dmabuf =3D qemu_dmabuf_new(w, h, &offset, &stride, x, y, backing_wid=
th,
> -                             backing_height, fourcc, modifier, &fd, 1,
> +    dmabuf =3D qemu_dmabuf_new(w, h, offset, stride, x, y, backing_width=
,
> +                             backing_height, fourcc, modifier, fd, num_p=
lanes,
>                               false, backing_y_0_top);
>
>      dbus_scanout_dmabuf(dcl, dmabuf);
> diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
> index 8c0e394d2b..f76d0c04a2 100644
> --- a/ui/egl-helpers.c
> +++ b/ui/egl-helpers.c
> @@ -283,44 +283,85 @@ err:
>      return -1;
>  }
>
> -int egl_get_fd_for_texture(uint32_t tex_id, EGLint *stride, EGLint *four=
cc,
> -                           EGLuint64KHR *modifier)
> +bool egl_dmabuf_export_texture(uint32_t tex_id, int *fd, EGLint *offset,
> +                               EGLint *stride, EGLint *fourcc, int *num_=
planes,
> +                               EGLuint64KHR *modifier)
>  {
>      EGLImageKHR image;
> -    EGLint num_planes, fd;
> +    EGLuint64KHR modifiers[DMABUF_MAX_PLANES];
>
>      image =3D eglCreateImageKHR(qemu_egl_display, eglGetCurrentContext()=
,
>                                EGL_GL_TEXTURE_2D_KHR,
>                                (EGLClientBuffer)(unsigned long)tex_id,
>                                NULL);
>      if (!image) {
> -        return -1;
> +        return false;
>      }
>
>      eglExportDMABUFImageQueryMESA(qemu_egl_display, image, fourcc,
> -                                  &num_planes, modifier);
> -    if (num_planes !=3D 1) {
> -        eglDestroyImageKHR(qemu_egl_display, image);
> -        return -1;
> -    }
> -    eglExportDMABUFImageMESA(qemu_egl_display, image, &fd, stride, NULL)=
;
> +                                  num_planes, modifiers);
> +    eglExportDMABUFImageMESA(qemu_egl_display, image, fd, stride, offset=
);
>      eglDestroyImageKHR(qemu_egl_display, image);
>
> -    return fd;
> +    /* Only first modifier matters. */
> +    if (modifier)
> +        *modifier =3D modifiers[0];
> +
> +    return true;
>  }
>
>  void egl_dmabuf_import_texture(QemuDmaBuf *dmabuf)
>  {
>      EGLImageKHR image =3D EGL_NO_IMAGE_KHR;
>      EGLint attrs[64];
> -    int i =3D 0;
> +    int i =3D 0, j;
>      uint64_t modifier =3D qemu_dmabuf_get_modifier(dmabuf);
>      uint32_t texture =3D qemu_dmabuf_get_texture(dmabuf);
> +    int nfds, noffsets, nstrides;
> +    const int *fds =3D qemu_dmabuf_get_fds(dmabuf, &nfds);
> +    const uint32_t *offsets =3D qemu_dmabuf_get_offsets(dmabuf, &noffset=
s);
> +    const uint32_t *strides =3D qemu_dmabuf_get_strides(dmabuf, &nstride=
s);
> +    uint32_t num_planes =3D qemu_dmabuf_get_num_planes(dmabuf);
> +
> +    EGLint fd_attrs[] =3D {
> +        EGL_DMA_BUF_PLANE0_FD_EXT,
> +        EGL_DMA_BUF_PLANE1_FD_EXT,
> +        EGL_DMA_BUF_PLANE2_FD_EXT,
> +        EGL_DMA_BUF_PLANE3_FD_EXT,
> +    };
> +    EGLint offset_attrs[] =3D {
> +        EGL_DMA_BUF_PLANE0_OFFSET_EXT,
> +        EGL_DMA_BUF_PLANE1_OFFSET_EXT,
> +        EGL_DMA_BUF_PLANE2_OFFSET_EXT,
> +        EGL_DMA_BUF_PLANE3_OFFSET_EXT,
> +    };
> +    EGLint stride_attrs[] =3D {
> +        EGL_DMA_BUF_PLANE0_PITCH_EXT,
> +        EGL_DMA_BUF_PLANE1_PITCH_EXT,
> +        EGL_DMA_BUF_PLANE2_PITCH_EXT,
> +        EGL_DMA_BUF_PLANE3_PITCH_EXT,
> +    };
> +    EGLint modifier_lo_attrs[] =3D {
> +        EGL_DMA_BUF_PLANE0_MODIFIER_LO_EXT,
> +        EGL_DMA_BUF_PLANE1_MODIFIER_LO_EXT,
> +        EGL_DMA_BUF_PLANE2_MODIFIER_LO_EXT,
> +        EGL_DMA_BUF_PLANE3_MODIFIER_LO_EXT,
> +    };
> +    EGLint modifier_hi_attrs[] =3D {
> +        EGL_DMA_BUF_PLANE0_MODIFIER_HI_EXT,
> +        EGL_DMA_BUF_PLANE1_MODIFIER_HI_EXT,
> +        EGL_DMA_BUF_PLANE2_MODIFIER_HI_EXT,
> +        EGL_DMA_BUF_PLANE3_MODIFIER_HI_EXT,
> +    };
>
>      if (texture !=3D 0) {
>          return;
>      }
>
> +    assert(nfds >=3D num_planes);
> +    assert(noffsets >=3D num_planes);
> +    assert(nstrides >=3D num_planes);
> +
>      attrs[i++] =3D EGL_WIDTH;
>      attrs[i++] =3D qemu_dmabuf_get_backing_width(dmabuf);
>      attrs[i++] =3D EGL_HEIGHT;
> @@ -328,18 +369,22 @@ void egl_dmabuf_import_texture(QemuDmaBuf *dmabuf)
>      attrs[i++] =3D EGL_LINUX_DRM_FOURCC_EXT;
>      attrs[i++] =3D qemu_dmabuf_get_fourcc(dmabuf);
>
> -    attrs[i++] =3D EGL_DMA_BUF_PLANE0_FD_EXT;
> -    attrs[i++] =3D qemu_dmabuf_get_fds(dmabuf, NULL)[0];
> -    attrs[i++] =3D EGL_DMA_BUF_PLANE0_PITCH_EXT;
> -    attrs[i++] =3D qemu_dmabuf_get_strides(dmabuf, NULL)[0];
> -    attrs[i++] =3D EGL_DMA_BUF_PLANE0_OFFSET_EXT;
> -    attrs[i++] =3D 0;
> -    if (modifier !=3D DRM_FORMAT_MOD_INVALID) {
> -        attrs[i++] =3D EGL_DMA_BUF_PLANE0_MODIFIER_LO_EXT;
> -        attrs[i++] =3D (modifier >>  0) & 0xffffffff;
> -        attrs[i++] =3D EGL_DMA_BUF_PLANE0_MODIFIER_HI_EXT;
> -        attrs[i++] =3D (modifier >> 32) & 0xffffffff;
> +    for (j =3D 0; j < num_planes; j++) {
> +        attrs[i++] =3D fd_attrs[j];
> +        /* fd[1-3] may be -1 if using a joint buffer for all planes */
> +        attrs[i++] =3D fds[j] >=3D 0 ? fds[j] : fds[0];
> +        attrs[i++] =3D stride_attrs[j];
> +        attrs[i++] =3D strides[j];
> +        attrs[i++] =3D offset_attrs[j];
> +        attrs[i++] =3D offsets[j];
> +        if (modifier !=3D DRM_FORMAT_MOD_INVALID) {
> +            attrs[i++] =3D modifier_lo_attrs[j];
> +            attrs[i++] =3D (modifier >>  0) & 0xffffffff;
> +            attrs[i++] =3D modifier_hi_attrs[j];
> +            attrs[i++] =3D (modifier >> 32) & 0xffffffff;
> +        }
>      }
> +
>      attrs[i++] =3D EGL_NONE;
>
>      image =3D eglCreateImageKHR(qemu_egl_display,
> diff --git a/ui/spice-display.c b/ui/spice-display.c
> index 40547edb5e..d7ebb3682d 100644
> --- a/ui/spice-display.c
> +++ b/ui/spice-display.c
> @@ -876,19 +876,24 @@ static void spice_gl_switch(DisplayChangeListener *=
dcl,
>                              struct DisplaySurface *new_surface)
>  {
>      SimpleSpiceDisplay *ssd =3D container_of(dcl, SimpleSpiceDisplay, dc=
l);
> -    EGLint stride, fourcc;
> -    int fd;
>
>      if (ssd->ds) {
>          surface_gl_destroy_texture(ssd->gls, ssd->ds);
>      }
>      ssd->ds =3D new_surface;
>      if (ssd->ds) {
> +        uint32_t offset[DMABUF_MAX_PLANES], stride[DMABUF_MAX_PLANES];
> +        int fd[DMABUF_MAX_PLANES], num_planes, fourcc;
> +
>          surface_gl_create_texture(ssd->gls, ssd->ds);
> -        fd =3D egl_get_fd_for_texture(ssd->ds->texture,
> -                                    &stride, &fourcc,
> -                                    NULL);
> -        if (fd < 0) {
> +        if (!egl_dmabuf_export_texture(ssd->ds->texture, fd, (EGLint *)o=
ffset,
> +                                       (EGLint *)stride, &fourcc, &num_p=
lanes, NULL)) {
> +            surface_gl_destroy_texture(ssd->gls, ssd->ds);
> +            return;
> +        }
> +
> +        if (num_planes > 1) {
> +            fprintf(stderr, "%s: does not support multi-plane texture\n"=
, __func__);
>              surface_gl_destroy_texture(ssd->gls, ssd->ds);
>              return;
>          }
> @@ -899,10 +904,10 @@ static void spice_gl_switch(DisplayChangeListener *=
dcl,
>                                      fourcc);
>
>          /* note: spice server will close the fd */
> -        spice_qxl_gl_scanout(&ssd->qxl, fd,
> +        spice_qxl_gl_scanout(&ssd->qxl, fd[0],
>                               surface_width(ssd->ds),
>                               surface_height(ssd->ds),
> -                             stride, fourcc, false);
> +                             stride[0], fourcc, false);
>          ssd->have_surface =3D true;
>          ssd->have_scanout =3D false;
>
> @@ -941,20 +946,24 @@ static void qemu_spice_gl_scanout_texture(DisplayCh=
angeListener *dcl,
>                                            void *d3d_tex2d)
>  {
>      SimpleSpiceDisplay *ssd =3D container_of(dcl, SimpleSpiceDisplay, dc=
l);
> -    EGLint stride =3D 0, fourcc =3D 0;
> -    int fd =3D -1;
> +    EGLint offset[DMABUF_MAX_PLANES], stride[DMABUF_MAX_PLANES], fourcc =
=3D 0;
> +    int fd[DMABUF_MAX_PLANES], num_planes;
>
>      assert(tex_id);
> -    fd =3D egl_get_fd_for_texture(tex_id, &stride, &fourcc, NULL);
> -    if (fd < 0) {
> -        fprintf(stderr, "%s: failed to get fd for texture\n", __func__);
> +    if (!egl_dmabuf_export_texture(tex_id, fd, offset, stride, &fourcc,
> +                                   &num_planes, NULL)) {
> +        fprintf(stderr, "%s: failed to export dmabuf for texture\n", __f=
unc__);
> +        return;
> +    }
> +    if (num_planes > 1) {
> +        fprintf(stderr, "%s: does not support multi-plane dmabuf\n", __f=
unc__);
>          return;
>      }
>      trace_qemu_spice_gl_scanout_texture(ssd->qxl.id, w, h, fourcc);
>
>      /* note: spice server will close the fd */
> -    spice_qxl_gl_scanout(&ssd->qxl, fd, backing_width, backing_height,
> -                         stride, fourcc, y_0_top);
> +    spice_qxl_gl_scanout(&ssd->qxl, fd[0], backing_width, backing_height=
,
> +                         stride[0], fourcc, y_0_top);
>      qemu_spice_gl_monitor_config(ssd, x, y, w, h);
>      ssd->have_surface =3D false;
>      ssd->have_scanout =3D true;
> @@ -1064,15 +1073,26 @@ static void qemu_spice_gl_update(DisplayChangeLis=
tener *dcl,
>              /* dest framebuffer */
>              if (ssd->blit_fb.width  !=3D width ||
>                  ssd->blit_fb.height !=3D height) {
> +                int fds[DMABUF_MAX_PLANES], num_planes;
> +                uint32_t offsets[DMABUF_MAX_PLANES], strides[DMABUF_MAX_=
PLANES];
> +
>                  trace_qemu_spice_gl_render_dmabuf(ssd->qxl.id, width,
>                                                    height);
>                  egl_fb_destroy(&ssd->blit_fb);
>                  egl_fb_setup_new_tex(&ssd->blit_fb,
>                                       width, height);
> -                fd =3D egl_get_fd_for_texture(ssd->blit_fb.texture,
> -                                            &stride, &fourcc, NULL);
> -                spice_qxl_gl_scanout(&ssd->qxl, fd, width, height,
> -                                     stride, fourcc, false);
> +                if (!egl_dmabuf_export_texture(ssd->blit_fb.texture, fds=
,
> +                                               (EGLint *)offsets, (EGLin=
t *)strides,
> +                                               &fourcc, &num_planes, NUL=
L)) {
> +                    fprintf(stderr, "%s: failed to export dmabuf for tex=
ture\n", __func__);
> +                    return;
> +                }
> +                if (num_planes > 1) {
> +                    fprintf(stderr, "%s: does not support multi-plane dm=
abuf\n", __func__);
> +                    return;
> +                }
> +                spice_qxl_gl_scanout(&ssd->qxl, fds[0], width, height,
> +                                     strides[0], fourcc, false);
>              }
>          } else {
>              stride =3D qemu_dmabuf_get_strides(dmabuf, NULL)[0];
> --
> 2.43.0
>


--=20
Marc-Andr=C3=A9 Lureau

