Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B0DBC25B4F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 07:22:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4bcr-0006Rp-RE; Wed, 08 May 2024 03:22:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1s4bcp-0006Px-Ah
 for qemu-devel@nongnu.org; Wed, 08 May 2024 03:22:03 -0400
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1s4bcn-0000of-1F
 for qemu-devel@nongnu.org; Wed, 08 May 2024 03:22:02 -0400
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-43b0b09d012so21510961cf.3
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 00:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715152920; x=1715757720; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eSwYY2tk1eQzVv9jPwUE2u+MZYCvSMAtC6ADbEq8kQc=;
 b=FA5TVZI0QL9ZMCQ4toZM5AQ2CzYopjCthzlorp1dafXP+GyOuzrKT/VGtjUzPrtfMv
 gVLkAgMkMJ4FZV/Ck2060y4xiWJKRK411ZVPIa9qIbaVnN4ED4ZeQ3lqQSRclLgGgVfE
 3chuIxMxRLddSn1cuj4cPvMjl4pU3WqSY2tuTTioxbkGvgTfDlA44Kzx+6nX3B8vkXC1
 8GLrzXdYirRLYILYlkpxx6QRNFgMaiIqiayI+jym8VvvKB2IBpBMDMJzaMXUaUypWnWL
 BOOu+6m8dNuBA4dDsU84TX3qhMMgztwoRj7A2487hUpjSiKT2ZG/XHbBzZc3fb+BIgeu
 qL5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715152920; x=1715757720;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eSwYY2tk1eQzVv9jPwUE2u+MZYCvSMAtC6ADbEq8kQc=;
 b=hcovvbPfmAkCFqtHeE+esW5YtYAaEu4YUnf867CBcRED0MT9w4sMEaQyWPLj/dwgWI
 UNu7Fjfaig0XPSO6JJcISq9A1BQvD82hAuNbWS6iPODAq9YRuH8XPicdXb9aDCXlypoE
 B+VC2ebPM2b9OJoV6gYO4eOL8gRgFj8XNblmXM7S32tgNoI/6inw6eTPJiXJ+sLlRRTt
 VdVIGbgoay3yCLtcCQn3nbX3WZgsxTjraLgD3AnwNA3WlIgPhw+z/1+gaz5U6bMya9uf
 tq5Zy64kokmzaU7WzEISKn4kA842ha2Bvyf/QtLl1B5HWnUCMb5nP1G8HxuK2gNTaDqG
 fPig==
X-Gm-Message-State: AOJu0YyyKt6+9U14PxnwWQ2oiD1YtrJMBMfpMWMdq5tuxXIfq6Y12IEe
 ZaA0fTOF6p1nd7o6relpRxFmSTGTM5X6M8Q4HAR0MnSDcyG2K6prnwLPpK0TuABB8LBS6lr6dYi
 iRNkgG4KALb7y40HnvRXclXQ3Ugs=
X-Google-Smtp-Source: AGHT+IEIBCcPfooKUCqw9FmCjOia2ctFjijcrsIDsl9laf8NNy7zHW1dWTT+prWNymVcMO0w6rG3soQDGTtSY0W/S9M=
X-Received: by 2002:ac8:7f08:0:b0:43a:dede:73b8 with SMTP id
 d75a77b69052e-43dbf860a3emr23022701cf.57.1715152919860; Wed, 08 May 2024
 00:21:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240507183757.3383641-1-dongwon.kim@intel.com>
 <20240507183757.3383641-6-dongwon.kim@intel.com>
In-Reply-To: <20240507183757.3383641-6-dongwon.kim@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 8 May 2024 11:21:47 +0400
Message-ID: <CAJ+F1CKcH==Vx1TfwEmn8a+J8NtDvfBpxjQMDMjSf_NHAbKS-g@mail.gmail.com>
Subject: Re: [PATCH v13 5/6] ui/console: Use qemu_dmabuf_new() and free()
 helpers instead
To: dongwon.kim@intel.com
Cc: qemu-devel@nongnu.org, philmd@linaro.org, berrange@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82b;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82b.google.com
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

On Tue, May 7, 2024 at 10:44=E2=80=AFPM <dongwon.kim@intel.com> wrote:
>
> From: Dongwon Kim <dongwon.kim@intel.com>
>
> This commit introduces utility functions for the creation and deallocatio=
n
> of QemuDmaBuf instances. Additionally, it updates all relevant sections
> of the codebase to utilize these new utility functions.
>
> v7: remove prefix, "dpy_gl_" from all helpers
>     qemu_dmabuf_free() returns without doing anything if input is null
>     (Daniel P. Berrang=C3=A9 <berrange@redhat.com>)
>     call G_DEFINE_AUTOPTR_CLEANUP_FUNC for qemu_dmabuf_free()
>     (Daniel P. Berrang=C3=A9 <berrange@redhat.com>)
>
> v8: Introduction of helpers was removed as those were already added
>     by the previous commit
>
> v9: set dmabuf->allow_fences to 'true' when dmabuf is created in
>     virtio_gpu_create_dmabuf()/virtio-gpu-udmabuf.c
>
>     removed unnecessary spaces were accidently added in the patch,
>     'ui/console: Use qemu_dmabuf_new() a...'
>
> v11: Calling qemu_dmabuf_close was removed as closing dmabuf->fd will be
>      done in qemu_dmabuf_free anyway.
>      (Daniel P. Berrang=C3=A9 <berrange@redhat.com>)
>
> v12: --- Calling qemu_dmabuf_close separately as qemu_dmabuf_free doesn't
>          do it.
>
>      --- 'dmabuf' is now allocated space so it should be freed at the end=
 of
>          dbus_scanout_texture
>
> v13: --- Immediately free dmabuf after it is released to prevent possible
>          leaking of the ptr
>          (Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>)
>
>      --- Use g_autoptr macro to define *dmabuf for auto clean up instead =
of
>          calling qemu_dmabuf_free
>          (Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>)
>
> Suggested-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
> Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
> ---
>  include/hw/vfio/vfio-common.h   |  2 +-
>  include/hw/virtio/virtio-gpu.h  |  4 ++--
>  hw/display/vhost-user-gpu.c     | 21 +++++++++++----------
>  hw/display/virtio-gpu-udmabuf.c | 24 +++++++++---------------
>  hw/vfio/display.c               | 26 ++++++++++++--------------
>  ui/dbus-listener.c              | 28 ++++++++++++----------------
>  6 files changed, 47 insertions(+), 58 deletions(-)
>
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.=
h
> index b9da6c08ef..d66e27db02 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -148,7 +148,7 @@ typedef struct VFIOGroup {
>  } VFIOGroup;
>
>  typedef struct VFIODMABuf {
> -    QemuDmaBuf buf;
> +    QemuDmaBuf *buf;
>      uint32_t pos_x, pos_y, pos_updates;
>      uint32_t hot_x, hot_y, hot_updates;
>      int dmabuf_id;
> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gp=
u.h
> index ed44cdad6b..56d6e821bf 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -169,7 +169,7 @@ struct VirtIOGPUBaseClass {
>      DEFINE_PROP_UINT32("yres", _state, _conf.yres, 800)
>
>  typedef struct VGPUDMABuf {
> -    QemuDmaBuf buf;
> +    QemuDmaBuf *buf;
>      uint32_t scanout_id;
>      QTAILQ_ENTRY(VGPUDMABuf) next;
>  } VGPUDMABuf;
> @@ -238,7 +238,7 @@ struct VhostUserGPU {
>      VhostUserBackend *vhost;
>      int vhost_gpu_fd; /* closed by the chardev */
>      CharBackend vhost_chr;
> -    QemuDmaBuf dmabuf[VIRTIO_GPU_MAX_SCANOUTS];
> +    QemuDmaBuf *dmabuf[VIRTIO_GPU_MAX_SCANOUTS];
>      bool backend_blocked;
>  };
>
> diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
> index 454e5afcff..744792cf78 100644
> --- a/hw/display/vhost-user-gpu.c
> +++ b/hw/display/vhost-user-gpu.c
> @@ -249,6 +249,7 @@ vhost_user_gpu_handle_display(VhostUserGPU *g, VhostU=
serGpuMsg *msg)
>      case VHOST_USER_GPU_DMABUF_SCANOUT: {
>          VhostUserGpuDMABUFScanout *m =3D &msg->payload.dmabuf_scanout;
>          int fd =3D qemu_chr_fe_get_msgfd(&g->vhost_chr);
> +        uint64_t modifier =3D 0;
>          QemuDmaBuf *dmabuf;
>
>          if (m->scanout_id >=3D g->parent_obj.conf.max_outputs) {
> @@ -261,27 +262,27 @@ vhost_user_gpu_handle_display(VhostUserGPU *g, Vhos=
tUserGpuMsg *msg)
>
>          g->parent_obj.enable =3D 1;
>          con =3D g->parent_obj.scanout[m->scanout_id].con;
> -        dmabuf =3D &g->dmabuf[m->scanout_id];
> +        dmabuf =3D g->dmabuf[m->scanout_id];
>          qemu_dmabuf_close(dmabuf);
>          dpy_gl_release_dmabuf(con, dmabuf);
> +        qemu_dmabuf_free(dmabuf);
>          if (fd =3D=3D -1) {
>              dpy_gl_scanout_disable(con);
>              break;

This is still incorrect. You replaced g_clear_pointer(&dmabuf,
qemu_dmabuf_free), but that's not the point.

g->dmabuf[m->scanout_id] must be set to NULL, before breaking, at least.

>          }
> -        *dmabuf =3D (QemuDmaBuf) {
> -            .fd =3D fd,
> -            .width =3D m->fd_width,
> -            .height =3D m->fd_height,
> -            .stride =3D m->fd_stride,
> -            .fourcc =3D m->fd_drm_fourcc,
> -            .y0_top =3D m->fd_flags & VIRTIO_GPU_RESOURCE_FLAG_Y_0_TOP,
> -        };
>          if (msg->request =3D=3D VHOST_USER_GPU_DMABUF_SCANOUT2) {
>              VhostUserGpuDMABUFScanout2 *m2 =3D &msg->payload.dmabuf_scan=
out2;
> -            dmabuf->modifier =3D m2->modifier;
> +            modifier =3D m2->modifier;
>          }
>
> +        dmabuf =3D qemu_dmabuf_new(m->fd_width, m->fd_height,
> +                                 m->fd_stride, 0, 0, 0, 0,
> +                                 m->fd_drm_fourcc, modifier,
> +                                 fd, false, m->fd_flags &
> +                                 VIRTIO_GPU_RESOURCE_FLAG_Y_0_TOP);
> +
>          dpy_gl_scanout_dmabuf(con, dmabuf);
> +        g->dmabuf[m->scanout_id] =3D dmabuf;
>          break;
>      }
>      case VHOST_USER_GPU_DMABUF_UPDATE: {
> diff --git a/hw/display/virtio-gpu-udmabuf.c b/hw/display/virtio-gpu-udma=
buf.c
> index c90eba281e..c02ec6d37d 100644
> --- a/hw/display/virtio-gpu-udmabuf.c
> +++ b/hw/display/virtio-gpu-udmabuf.c
> @@ -162,7 +162,8 @@ static void virtio_gpu_free_dmabuf(VirtIOGPU *g, VGPU=
DMABuf *dmabuf)
>      struct virtio_gpu_scanout *scanout;
>
>      scanout =3D &g->parent_obj.scanout[dmabuf->scanout_id];
> -    dpy_gl_release_dmabuf(scanout->con, &dmabuf->buf);
> +    dpy_gl_release_dmabuf(scanout->con, dmabuf->buf);
> +    g_clear_pointer(&dmabuf->buf, qemu_dmabuf_free);
>      QTAILQ_REMOVE(&g->dmabuf.bufs, dmabuf, next);
>      g_free(dmabuf);
>  }
> @@ -181,17 +182,10 @@ static VGPUDMABuf
>      }
>
>      dmabuf =3D g_new0(VGPUDMABuf, 1);
> -    dmabuf->buf.width =3D r->width;
> -    dmabuf->buf.height =3D r->height;
> -    dmabuf->buf.stride =3D fb->stride;
> -    dmabuf->buf.x =3D r->x;
> -    dmabuf->buf.y =3D r->y;
> -    dmabuf->buf.backing_width =3D fb->width;
> -    dmabuf->buf.backing_height =3D fb->height;
> -    dmabuf->buf.fourcc =3D qemu_pixman_to_drm_format(fb->format);
> -    dmabuf->buf.fd =3D res->dmabuf_fd;
> -    dmabuf->buf.allow_fences =3D true;
> -    dmabuf->buf.draw_submitted =3D false;
> +    dmabuf->buf =3D qemu_dmabuf_new(r->width, r->height, fb->stride,
> +                                  r->x, r->y, fb->width, fb->height,
> +                                  qemu_pixman_to_drm_format(fb->format),
> +                                  0, res->dmabuf_fd, true, false);
>      dmabuf->scanout_id =3D scanout_id;
>      QTAILQ_INSERT_HEAD(&g->dmabuf.bufs, dmabuf, next);
>
> @@ -217,11 +211,11 @@ int virtio_gpu_update_dmabuf(VirtIOGPU *g,
>          old_primary =3D g->dmabuf.primary[scanout_id];
>      }
>
> -    width =3D qemu_dmabuf_get_width(&new_primary->buf);
> -    height =3D qemu_dmabuf_get_height(&new_primary->buf);
> +    width =3D qemu_dmabuf_get_width(new_primary->buf);
> +    height =3D qemu_dmabuf_get_height(new_primary->buf);
>      g->dmabuf.primary[scanout_id] =3D new_primary;
>      qemu_console_resize(scanout->con, width, height);
> -    dpy_gl_scanout_dmabuf(scanout->con, &new_primary->buf);
> +    dpy_gl_scanout_dmabuf(scanout->con, new_primary->buf);
>
>      if (old_primary) {
>          virtio_gpu_free_dmabuf(g, old_primary);
> diff --git a/hw/vfio/display.c b/hw/vfio/display.c
> index 7784502b53..fe624a6c9b 100644
> --- a/hw/vfio/display.c
> +++ b/hw/vfio/display.c
> @@ -241,14 +241,11 @@ static VFIODMABuf *vfio_display_get_dmabuf(VFIOPCID=
evice *vdev,
>
>      dmabuf =3D g_new0(VFIODMABuf, 1);
>      dmabuf->dmabuf_id  =3D plane.dmabuf_id;
> -    dmabuf->buf.width  =3D plane.width;
> -    dmabuf->buf.height =3D plane.height;
> -    dmabuf->buf.backing_width =3D plane.width;
> -    dmabuf->buf.backing_height =3D plane.height;
> -    dmabuf->buf.stride =3D plane.stride;
> -    dmabuf->buf.fourcc =3D plane.drm_format;
> -    dmabuf->buf.modifier =3D plane.drm_format_mod;
> -    dmabuf->buf.fd     =3D fd;
> +    dmabuf->buf =3D qemu_dmabuf_new(plane.width, plane.height,
> +                                  plane.stride, 0, 0, plane.width,
> +                                  plane.height, plane.drm_format,
> +                                  plane.drm_format_mod, fd, false, false=
);
> +
>      if (plane_type =3D=3D DRM_PLANE_TYPE_CURSOR) {
>          vfio_display_update_cursor(dmabuf, &plane);
>      }
> @@ -261,8 +258,9 @@ static void vfio_display_free_one_dmabuf(VFIODisplay =
*dpy, VFIODMABuf *dmabuf)
>  {
>      QTAILQ_REMOVE(&dpy->dmabuf.bufs, dmabuf, next);
>
> -    qemu_dmabuf_close(&dmabuf->buf);
> -    dpy_gl_release_dmabuf(dpy->con, &dmabuf->buf);
> +    qemu_dmabuf_close(dmabuf->buf);
> +    dpy_gl_release_dmabuf(dpy->con, dmabuf->buf);
> +    g_clear_pointer(&dmabuf->buf, qemu_dmabuf_free);
>      g_free(dmabuf);
>  }
>
> @@ -298,13 +296,13 @@ static void vfio_display_dmabuf_update(void *opaque=
)
>          return;
>      }
>
> -    width =3D qemu_dmabuf_get_width(&primary->buf);
> -    height =3D qemu_dmabuf_get_height(&primary->buf);
> +    width =3D qemu_dmabuf_get_width(primary->buf);
> +    height =3D qemu_dmabuf_get_height(primary->buf);
>
>      if (dpy->dmabuf.primary !=3D primary) {
>          dpy->dmabuf.primary =3D primary;
>          qemu_console_resize(dpy->con, width, height);
> -        dpy_gl_scanout_dmabuf(dpy->con, &primary->buf);
> +        dpy_gl_scanout_dmabuf(dpy->con, primary->buf);
>          free_bufs =3D true;
>      }
>
> @@ -318,7 +316,7 @@ static void vfio_display_dmabuf_update(void *opaque)
>      if (cursor && (new_cursor || cursor->hot_updates)) {
>          bool have_hot =3D (cursor->hot_x !=3D 0xffffffff &&
>                           cursor->hot_y !=3D 0xffffffff);
> -        dpy_gl_cursor_dmabuf(dpy->con, &cursor->buf, have_hot,
> +        dpy_gl_cursor_dmabuf(dpy->con, cursor->buf, have_hot,
>                               cursor->hot_x, cursor->hot_y);
>          cursor->hot_updates =3D 0;
>      } else if (!cursor && new_cursor) {
> diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
> index 62d1e2d3f9..5490088043 100644
> --- a/ui/dbus-listener.c
> +++ b/ui/dbus-listener.c
> @@ -442,28 +442,24 @@ static void dbus_scanout_texture(DisplayChangeListe=
ner *dcl,
>      trace_dbus_scanout_texture(tex_id, backing_y_0_top,
>                                 backing_width, backing_height, x, y, w, h=
);
>  #ifdef CONFIG_GBM
> -    QemuDmaBuf dmabuf =3D {
> -        .width =3D w,
> -        .height =3D h,
> -        .y0_top =3D backing_y_0_top,
> -        .x =3D x,
> -        .y =3D y,
> -        .backing_width =3D backing_width,
> -        .backing_height =3D backing_height,
> -    };
> +    g_autoptr(QemuDmaBuf) dmabuf =3D NULL;
> +    int fd;
> +    uint32_t stride, fourcc;
> +    uint64_t modifier;
>
>      assert(tex_id);
> -    dmabuf.fd =3D egl_get_fd_for_texture(
> -        tex_id, (EGLint *)&dmabuf.stride,
> -        (EGLint *)&dmabuf.fourcc,
> -        &dmabuf.modifier);
> -    if (dmabuf.fd < 0) {
> +    fd =3D egl_get_fd_for_texture(tex_id, (EGLint *)&stride, (EGLint *)&=
fourcc,
> +                                &modifier);
> +    if (fd < 0) {
>          error_report("%s: failed to get fd for texture", __func__);
>          return;
>      }
> +    dmabuf =3D qemu_dmabuf_new(w, h, stride, x, y, backing_width,
> +                             backing_height, fourcc, modifier, fd,
> +                             false, backing_y_0_top);
>
> -    dbus_scanout_dmabuf(dcl, &dmabuf);
> -    close(dmabuf.fd);
> +    dbus_scanout_dmabuf(dcl, dmabuf);
> +    qemu_dmabuf_close(dmabuf);
>  #endif
>
>  #ifdef WIN32
> --
> 2.34.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

