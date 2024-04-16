Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56309C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 10:56:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwgT9-0001XN-Ac; Tue, 16 Apr 2024 06:55:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1rwgT0-0001Wt-9j
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 06:55:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1rwgSw-00008I-O5
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 06:55:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713264904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FCC22FqBr40F236kkDVGY7hVlcBEE87b5d+gp354X8Y=;
 b=boYZk3Iwkr22U114zuEqvi58ZDpEpFPbt9SODxBkfKFkpc/J1VO0qgj62M2/PWWNbJ4hqi
 1DIvBd7vDKo3RduYcm+KSmZqx6Dt0y0EfxdrMKEfSfIu+J2qUHsx6IIEGB6pHB8zTyP1Nj
 qEzI4OO310vEOtA3f9dLO2vUr3vjApU=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-xbaoSSWwO8Cmm-T64GzaeA-1; Tue, 16 Apr 2024 06:55:02 -0400
X-MC-Unique: xbaoSSWwO8Cmm-T64GzaeA-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-516d92389e0so3748661e87.3
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 03:55:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713264901; x=1713869701;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FCC22FqBr40F236kkDVGY7hVlcBEE87b5d+gp354X8Y=;
 b=Z7ToDFsr845unIInttDFaKJmV+WZrHbBLmcxk/aC4iwgAsYXl+WnedLCRPieRiYpXB
 R9XuSCQKPqr56QThtMHcElH9uvO3Idi0I00FP+7X3Rf2sNAxlvIorSBlPgdXA15E/vid
 PrphXhKfJ/FAfojM5SY6BueoCyvdiYIdjx94Fn1wVZk7NX53FYuu4sxkWRBj2oQosZiN
 w6QvmKhlTqQEYkGjXETirALfWtxYC3OoU4m04ItGVjz65/eFgWqoAuRV6mC103UR/9Ru
 DS3oYQ1vkLlmdtzGR2kPMWpEz9oS0LYmFEgaNHOj9O3KXMVxW1sc9GAA8PFCvAPACaVG
 XhyQ==
X-Gm-Message-State: AOJu0YzE3PlxWVzVlQXeuztt8na+PPOFAWY0ALX+utFG5ziQk47iX6sM
 vMnRDebMphgiDjRBJUju8sLt1SbHrJKH7znQUIub3aWeMq1mbTl5eANjO1GN6g0IBRqGFTEIYnA
 yrbxFrGo75k6qRGjz8zOpygMUvYEgb8F6jNf4qQVi3byXlQf5vT2WzmcRiBRO2cWRF0kVr0hLVq
 CiYo7zalOu1hGm0RndbJUgeachiN8=
X-Received: by 2002:ac2:53b4:0:b0:519:231:e4b9 with SMTP id
 j20-20020ac253b4000000b005190231e4b9mr2566192lfh.48.1713264901077; 
 Tue, 16 Apr 2024 03:55:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdpeLFbm22vw/CZ76TyYeWT4K7LNv2KRgWNFK1nr97d0gL/nwGxgAaxsCYSLJPMNl2j/EJMLusYJMePTdjktI=
X-Received: by 2002:ac2:53b4:0:b0:519:231:e4b9 with SMTP id
 j20-20020ac253b4000000b005190231e4b9mr2566168lfh.48.1713264900414; Tue, 16
 Apr 2024 03:55:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240415230724.9573-1-dongwon.kim@intel.com>
 <20240415230724.9573-2-dongwon.kim@intel.com>
In-Reply-To: <20240415230724.9573-2-dongwon.kim@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 16 Apr 2024 14:54:48 +0400
Message-ID: <CAMxuvawGwOE0HRyANuF8k5jDUH+0XaZYKWG6M=3fNeYU0ctR3g@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] ui/console: Introduce dpy_gl_qemu_dmabuf_get_..()
 helpers
To: dongwon.kim@intel.com
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.844,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Apr 16, 2024 at 3:11=E2=80=AFAM <dongwon.kim@intel.com> wrote:
>
> From: Dongwon Kim <dongwon.kim@intel.com>
>
> This commit introduces dpy_gl_qemu_dmabuf_get_... helpers to extract
> specific fields from the QemuDmaBuf struct. It also updates all instances
> where fields within the QemuDmaBuf struct are directly accessed, replacin=
g
> them with calls to these new helper functions.
>
> Suggested-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
> Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
> ---
>  include/ui/console.h            |  17 +++++
>  hw/display/vhost-user-gpu.c     |   6 +-
>  hw/display/virtio-gpu-udmabuf.c |   7 +-
>  hw/vfio/display.c               |  15 +++--
>  ui/console.c                    | 116 +++++++++++++++++++++++++++++++-
>  ui/dbus-console.c               |   9 ++-
>  ui/dbus-listener.c              |  43 +++++++-----
>  ui/egl-headless.c               |  23 +++++--
>  ui/egl-helpers.c                |  47 +++++++------
>  ui/gtk-egl.c                    |  48 ++++++++-----
>  ui/gtk-gl-area.c                |  37 ++++++----
>  ui/gtk.c                        |   6 +-
>  ui/spice-display.c              |  50 ++++++++------
>  13 files changed, 316 insertions(+), 108 deletions(-)
>
> diff --git a/include/ui/console.h b/include/ui/console.h
> index 0bc7a00ac0..6292943a82 100644
> --- a/include/ui/console.h
> +++ b/include/ui/console.h
> @@ -358,6 +358,23 @@ void dpy_gl_cursor_dmabuf(QemuConsole *con, QemuDmaB=
uf *dmabuf,
>                            bool have_hot, uint32_t hot_x, uint32_t hot_y)=
;
>  void dpy_gl_cursor_position(QemuConsole *con,
>                              uint32_t pos_x, uint32_t pos_y);
> +
> +int32_t dpy_gl_qemu_dmabuf_get_fd(QemuDmaBuf *dmabuf);
> +uint32_t dpy_gl_qemu_dmabuf_get_width(QemuDmaBuf *dmabuf);
> +uint32_t dpy_gl_qemu_dmabuf_get_height(QemuDmaBuf *dmabuf);
> +uint32_t dpy_gl_qemu_dmabuf_get_stride(QemuDmaBuf *dmabuf);
> +uint32_t dpy_gl_qemu_dmabuf_get_fourcc(QemuDmaBuf *dmabuf);
> +uint64_t dpy_gl_qemu_dmabuf_get_modifier(QemuDmaBuf *dmabuf);
> +uint32_t dpy_gl_qemu_dmabuf_get_texture(QemuDmaBuf *dmabuf);
> +uint32_t dpy_gl_qemu_dmabuf_get_x(QemuDmaBuf *dmabuf);
> +uint32_t dpy_gl_qemu_dmabuf_get_y(QemuDmaBuf *dmabuf);
> +uint32_t dpy_gl_qemu_dmabuf_get_backing_width(QemuDmaBuf *dmabuf);
> +uint32_t dpy_gl_qemu_dmabuf_get_backing_height(QemuDmaBuf *dmabuf);
> +bool dpy_gl_qemu_dmabuf_get_y0_top(QemuDmaBuf *dmabuf);
> +void *dpy_gl_qemu_dmabuf_get_sync(QemuDmaBuf *dmabuf);
> +int32_t dpy_gl_qemu_dmabuf_get_fence_fd(QemuDmaBuf *dmabuf);
> +bool dpy_gl_qemu_dmabuf_get_allow_fences(QemuDmaBuf *dmabuf);
> +bool dpy_gl_qemu_dmabuf_get_draw_submitted(QemuDmaBuf *dmabuf);
>  void dpy_gl_release_dmabuf(QemuConsole *con,
>                             QemuDmaBuf *dmabuf);
>  void dpy_gl_update(QemuConsole *con,
> diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
> index 709c8a02a1..87dcfbca10 100644
> --- a/hw/display/vhost-user-gpu.c
> +++ b/hw/display/vhost-user-gpu.c
> @@ -249,6 +249,7 @@ vhost_user_gpu_handle_display(VhostUserGPU *g, VhostU=
serGpuMsg *msg)
>      case VHOST_USER_GPU_DMABUF_SCANOUT: {
>          VhostUserGpuDMABUFScanout *m =3D &msg->payload.dmabuf_scanout;
>          int fd =3D qemu_chr_fe_get_msgfd(&g->vhost_chr);
> +        int old_fd;
>          QemuDmaBuf *dmabuf;
>
>          if (m->scanout_id >=3D g->parent_obj.conf.max_outputs) {
> @@ -262,8 +263,9 @@ vhost_user_gpu_handle_display(VhostUserGPU *g, VhostU=
serGpuMsg *msg)
>          g->parent_obj.enable =3D 1;
>          con =3D g->parent_obj.scanout[m->scanout_id].con;
>          dmabuf =3D &g->dmabuf[m->scanout_id];
> -        if (dmabuf->fd >=3D 0) {
> -            close(dmabuf->fd);
> +        old_fd =3D dpy_gl_qemu_dmabuf_get_fd(dmabuf);
> +        if (old_fd >=3D 0) {
> +            close(old_fd);
>              dmabuf->fd =3D -1;
>          }
>          dpy_gl_release_dmabuf(con, dmabuf);
> diff --git a/hw/display/virtio-gpu-udmabuf.c b/hw/display/virtio-gpu-udma=
buf.c
> index d51184d658..e3f358b575 100644
> --- a/hw/display/virtio-gpu-udmabuf.c
> +++ b/hw/display/virtio-gpu-udmabuf.c
> @@ -206,6 +206,7 @@ int virtio_gpu_update_dmabuf(VirtIOGPU *g,
>  {
>      struct virtio_gpu_scanout *scanout =3D &g->parent_obj.scanout[scanou=
t_id];
>      VGPUDMABuf *new_primary, *old_primary =3D NULL;
> +    uint32_t width, height;
>
>      new_primary =3D virtio_gpu_create_dmabuf(g, scanout_id, res, fb, r);
>      if (!new_primary) {
> @@ -216,10 +217,10 @@ int virtio_gpu_update_dmabuf(VirtIOGPU *g,
>          old_primary =3D g->dmabuf.primary[scanout_id];
>      }
>
> +    width =3D dpy_gl_qemu_dmabuf_get_width(&new_primary->buf);
> +    height =3D dpy_gl_qemu_dmabuf_get_height(&new_primary->buf);
>      g->dmabuf.primary[scanout_id] =3D new_primary;
> -    qemu_console_resize(scanout->con,
> -                        new_primary->buf.width,
> -                        new_primary->buf.height);
> +    qemu_console_resize(scanout->con, width, height);
>      dpy_gl_scanout_dmabuf(scanout->con, &new_primary->buf);
>
>      if (old_primary) {
> diff --git a/hw/vfio/display.c b/hw/vfio/display.c
> index 1aa440c663..f9c39cbd51 100644
> --- a/hw/vfio/display.c
> +++ b/hw/vfio/display.c
> @@ -259,9 +259,13 @@ static VFIODMABuf *vfio_display_get_dmabuf(VFIOPCIDe=
vice *vdev,
>
>  static void vfio_display_free_one_dmabuf(VFIODisplay *dpy, VFIODMABuf *d=
mabuf)
>  {
> +    int fd;
> +
>      QTAILQ_REMOVE(&dpy->dmabuf.bufs, dmabuf, next);
> +
> +    fd =3D dpy_gl_qemu_dmabuf_get_fd(&dmabuf->buf);
>      dpy_gl_release_dmabuf(dpy->con, &dmabuf->buf);
> -    close(dmabuf->buf.fd);
> +    close(fd);
>      g_free(dmabuf);
>  }
>
> @@ -286,6 +290,7 @@ static void vfio_display_dmabuf_update(void *opaque)
>      VFIOPCIDevice *vdev =3D opaque;
>      VFIODisplay *dpy =3D vdev->dpy;
>      VFIODMABuf *primary, *cursor;
> +    uint32_t width, height;
>      bool free_bufs =3D false, new_cursor =3D false;
>
>      primary =3D vfio_display_get_dmabuf(vdev, DRM_PLANE_TYPE_PRIMARY);
> @@ -296,10 +301,12 @@ static void vfio_display_dmabuf_update(void *opaque=
)
>          return;
>      }
>
> +    width =3D dpy_gl_qemu_dmabuf_get_width(&primary->buf);
> +    height =3D dpy_gl_qemu_dmabuf_get_height(&primary->buf);
> +
>      if (dpy->dmabuf.primary !=3D primary) {
>          dpy->dmabuf.primary =3D primary;
> -        qemu_console_resize(dpy->con,
> -                            primary->buf.width, primary->buf.height);
> +        qemu_console_resize(dpy->con, width, height);
>          dpy_gl_scanout_dmabuf(dpy->con, &primary->buf);
>          free_bufs =3D true;
>      }
> @@ -328,7 +335,7 @@ static void vfio_display_dmabuf_update(void *opaque)
>          cursor->pos_updates =3D 0;
>      }
>
> -    dpy_gl_update(dpy->con, 0, 0, primary->buf.width, primary->buf.heigh=
t);
> +    dpy_gl_update(dpy->con, 0, 0, width, height);
>
>      if (free_bufs) {
>          vfio_display_free_dmabufs(vdev);
> diff --git a/ui/console.c b/ui/console.c
> index 43226c5c14..5d5635f783 100644
> --- a/ui/console.c
> +++ b/ui/console.c
> @@ -1132,6 +1132,118 @@ void dpy_gl_cursor_position(QemuConsole *con,
>      }
>  }
>
> +int32_t dpy_gl_qemu_dmabuf_get_fd(QemuDmaBuf *dmabuf)
> +{
> +    assert(dmabuf !=3D NULL);
> +
> +    return dmabuf->fd;
> +}
> +
> +uint32_t dpy_gl_qemu_dmabuf_get_width(QemuDmaBuf *dmabuf)
> +{
> +    assert(dmabuf !=3D NULL);
> +
> +    return dmabuf->width;
> +}
> +
> +uint32_t dpy_gl_qemu_dmabuf_get_height(QemuDmaBuf *dmabuf)
> +{
> +    assert(dmabuf !=3D NULL);
> +
> +    return dmabuf->height;
> +}
> +
> +uint32_t dpy_gl_qemu_dmabuf_get_stride(QemuDmaBuf *dmabuf)
> +{
> +    assert(dmabuf !=3D NULL);
> +
> +    return dmabuf->stride;
> +}
> +
> +uint32_t dpy_gl_qemu_dmabuf_get_fourcc(QemuDmaBuf *dmabuf)
> +{
> +    assert(dmabuf !=3D NULL);
> +
> +    return dmabuf->fourcc;
> +}
> +
> +uint64_t dpy_gl_qemu_dmabuf_get_modifier(QemuDmaBuf *dmabuf)
> +{
> +    assert(dmabuf !=3D NULL);
> +
> +    return dmabuf->modifier;
> +}
> +
> +uint32_t dpy_gl_qemu_dmabuf_get_texture(QemuDmaBuf *dmabuf)
> +{
> +    assert(dmabuf !=3D NULL);
> +
> +    return dmabuf->texture;
> +}
> +
> +uint32_t dpy_gl_qemu_dmabuf_get_x(QemuDmaBuf *dmabuf)
> +{
> +    assert(dmabuf !=3D NULL);
> +
> +    return dmabuf->x;
> +}
> +
> +uint32_t dpy_gl_qemu_dmabuf_get_y(QemuDmaBuf *dmabuf)
> +{
> +    assert(dmabuf !=3D NULL);
> +
> +    return dmabuf->y;
> +}
> +
> +uint32_t dpy_gl_qemu_dmabuf_get_backing_width(QemuDmaBuf *dmabuf)
> +{
> +    assert(dmabuf !=3D NULL);
> +
> +    return dmabuf->backing_width;
> +}
> +
> +uint32_t dpy_gl_qemu_dmabuf_get_backing_height(QemuDmaBuf *dmabuf)
> +{
> +    assert(dmabuf !=3D NULL);
> +
> +    return dmabuf->backing_height;
> +}
> +
> +bool dpy_gl_qemu_dmabuf_get_y0_top(QemuDmaBuf *dmabuf)
> +{
> +    assert(dmabuf !=3D NULL);
> +
> +    return dmabuf->y0_top;
> +}
> +
> +void *dpy_gl_qemu_dmabuf_get_sync(QemuDmaBuf *dmabuf)
> +{
> +    assert(dmabuf !=3D NULL);
> +
> +    return dmabuf->sync;
> +}
> +
> +int32_t dpy_gl_qemu_dmabuf_get_fence_fd(QemuDmaBuf *dmabuf)
> +{
> +    assert(dmabuf !=3D NULL);
> +
> +    return dmabuf->fence_fd;
> +}
> +
> +bool dpy_gl_qemu_dmabuf_get_allow_fences(QemuDmaBuf *dmabuf)
> +{
> +    assert(dmabuf !=3D NULL);
> +
> +    return dmabuf->allow_fences;
> +}
> +
> +bool dpy_gl_qemu_dmabuf_get_draw_submitted(QemuDmaBuf *dmabuf)
> +{
> +    assert(dmabuf !=3D NULL);
> +
> +    return dmabuf->draw_submitted;
> +}
> +
>  void dpy_gl_release_dmabuf(QemuConsole *con,
>                            QemuDmaBuf *dmabuf)
>  {
> @@ -1459,7 +1571,7 @@ int qemu_console_get_width(QemuConsole *con, int fa=
llback)
>      }
>      switch (con->scanout.kind) {
>      case SCANOUT_DMABUF:
> -        return con->scanout.dmabuf->width;
> +        return dpy_gl_qemu_dmabuf_get_width(con->scanout.dmabuf);
>      case SCANOUT_TEXTURE:
>          return con->scanout.texture.width;
>      case SCANOUT_SURFACE:
> @@ -1476,7 +1588,7 @@ int qemu_console_get_height(QemuConsole *con, int f=
allback)
>      }
>      switch (con->scanout.kind) {
>      case SCANOUT_DMABUF:
> -        return con->scanout.dmabuf->height;
> +        return dpy_gl_qemu_dmabuf_get_height(con->scanout.dmabuf);
>      case SCANOUT_TEXTURE:
>          return con->scanout.texture.height;
>      case SCANOUT_SURFACE:
> diff --git a/ui/dbus-console.c b/ui/dbus-console.c
> index 49da9ccc83..124fe16253 100644
> --- a/ui/dbus-console.c
> +++ b/ui/dbus-console.c
> @@ -110,11 +110,14 @@ static void
>  dbus_gl_scanout_dmabuf(DisplayChangeListener *dcl,
>                         QemuDmaBuf *dmabuf)
>  {
> +    uint32_t width, height;
> +
>      DBusDisplayConsole *ddc =3D container_of(dcl, DBusDisplayConsole, dc=
l);
>
> -    dbus_display_console_set_size(ddc,
> -                                  dmabuf->width,
> -                                  dmabuf->height);
> +    width =3D dpy_gl_qemu_dmabuf_get_width(dmabuf);
> +    height =3D dpy_gl_qemu_dmabuf_get_height(dmabuf);
> +
> +    dbus_display_console_set_size(ddc, width, height);
>  }
>
>  static void
> diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
> index 4a0a5d78f9..c6c7d93753 100644
> --- a/ui/dbus-listener.c
> +++ b/ui/dbus-listener.c
> @@ -278,29 +278,33 @@ static void dbus_scanout_dmabuf(DisplayChangeListen=
er *dcl,
>      DBusDisplayListener *ddl =3D container_of(dcl, DBusDisplayListener, =
dcl);
>      g_autoptr(GError) err =3D NULL;
>      g_autoptr(GUnixFDList) fd_list =3D NULL;
> +    int fd;
> +    uint32_t width, height, stride, fourcc;
> +    uint64_t modifier;
> +    bool y0_top;
>
> +    fd =3D dpy_gl_qemu_dmabuf_get_fd(dmabuf);
>      fd_list =3D g_unix_fd_list_new();
> -    if (g_unix_fd_list_append(fd_list, dmabuf->fd, &err) !=3D 0) {
> +    if (g_unix_fd_list_append(fd_list, fd, &err) !=3D 0) {
>          error_report("Failed to setup dmabuf fdlist: %s", err->message);
>          return;
>      }
>
>      ddl_discard_pending_messages(ddl);
>
> +    width =3D dpy_gl_qemu_dmabuf_get_width(dmabuf);
> +    height =3D dpy_gl_qemu_dmabuf_get_height(dmabuf);
> +    stride =3D dpy_gl_qemu_dmabuf_get_stride(dmabuf);
> +    fourcc =3D dpy_gl_qemu_dmabuf_get_fourcc(dmabuf);
> +    modifier =3D dpy_gl_qemu_dmabuf_get_modifier(dmabuf);
> +    y0_top =3D dpy_gl_qemu_dmabuf_get_y0_top(dmabuf);
> +
>      /* FIXME: add missing x/y/w/h support */
>      qemu_dbus_display1_listener_call_scanout_dmabuf(
> -        ddl->proxy,
> -        g_variant_new_handle(0),
> -        dmabuf->width,
> -        dmabuf->height,
> -        dmabuf->stride,
> -        dmabuf->fourcc,
> -        dmabuf->modifier,
> -        dmabuf->y0_top,
> -        G_DBUS_CALL_FLAGS_NONE,
> -        -1,
> -        fd_list,
> -        NULL, NULL, NULL);
> +        ddl->proxy, g_variant_new_handle(0),
> +        width, height, stride, fourcc, modifier,
> +        y0_top, G_DBUS_CALL_FLAGS_NONE,
> +        -1, fd_list, NULL, NULL, NULL);
>  }
>  #endif /* GBM */
>  #endif /* OPENGL */
> @@ -488,6 +492,7 @@ static void dbus_cursor_dmabuf(DisplayChangeListener =
*dcl,
>      DisplaySurface *ds;
>      GVariant *v_data =3D NULL;
>      egl_fb cursor_fb =3D EGL_FB_INIT;
> +    uint32_t width, height, texture;
>
>      if (!dmabuf) {
>          qemu_dbus_display1_listener_call_mouse_set(
> @@ -497,12 +502,16 @@ static void dbus_cursor_dmabuf(DisplayChangeListene=
r *dcl,
>      }
>
>      egl_dmabuf_import_texture(dmabuf);
> -    if (!dmabuf->texture) {
> +    texture =3D dpy_gl_qemu_dmabuf_get_texture(dmabuf);
> +    if (!texture) {
>          return;
>      }
> -    egl_fb_setup_for_tex(&cursor_fb, dmabuf->width, dmabuf->height,
> -                         dmabuf->texture, false);
> -    ds =3D qemu_create_displaysurface(dmabuf->width, dmabuf->height);
> +
> +    width =3D dpy_gl_qemu_dmabuf_get_width(dmabuf);
> +    height =3D dpy_gl_qemu_dmabuf_get_height(dmabuf);
> +
> +    egl_fb_setup_for_tex(&cursor_fb, width, height, texture, false);
> +    ds =3D qemu_create_displaysurface(width, height);
>      egl_fb_read(ds, &cursor_fb);
>
>      v_data =3D g_variant_new_from_data(
> diff --git a/ui/egl-headless.c b/ui/egl-headless.c
> index d5637dadb2..158924379b 100644
> --- a/ui/egl-headless.c
> +++ b/ui/egl-headless.c
> @@ -85,29 +85,38 @@ static void egl_scanout_texture(DisplayChangeListener=
 *dcl,
>  static void egl_scanout_dmabuf(DisplayChangeListener *dcl,
>                                 QemuDmaBuf *dmabuf)
>  {
> +    uint32_t width, height, texture;
> +
>      egl_dmabuf_import_texture(dmabuf);
> -    if (!dmabuf->texture) {
> +    texture =3D dpy_gl_qemu_dmabuf_get_texture(dmabuf);
> +    if (!texture) {
>          return;
>      }
>
> -    egl_scanout_texture(dcl, dmabuf->texture,
> -                        false, dmabuf->width, dmabuf->height,
> -                        0, 0, dmabuf->width, dmabuf->height, NULL);
> +    width =3D dpy_gl_qemu_dmabuf_get_width(dmabuf);
> +    height =3D dpy_gl_qemu_dmabuf_get_height(dmabuf);
> +
> +    egl_scanout_texture(dcl, texture, false, width, height, 0, 0,
> +                        width, height, NULL);
>  }
>
>  static void egl_cursor_dmabuf(DisplayChangeListener *dcl,
>                                QemuDmaBuf *dmabuf, bool have_hot,
>                                uint32_t hot_x, uint32_t hot_y)
>  {
> +    uint32_t width, height, texture;
>      egl_dpy *edpy =3D container_of(dcl, egl_dpy, dcl);
>
>      if (dmabuf) {
>          egl_dmabuf_import_texture(dmabuf);
> -        if (!dmabuf->texture) {
> +        texture =3D dpy_gl_qemu_dmabuf_get_texture(dmabuf);
> +        if (!texture) {
>              return;
>          }
> -        egl_fb_setup_for_tex(&edpy->cursor_fb, dmabuf->width, dmabuf->he=
ight,
> -                             dmabuf->texture, false);
> +
> +        width =3D dpy_gl_qemu_dmabuf_get_width(dmabuf);
> +        height =3D dpy_gl_qemu_dmabuf_get_height(dmabuf);
> +        egl_fb_setup_for_tex(&edpy->cursor_fb, width, height, texture, f=
alse);
>      } else {
>          egl_fb_destroy(&edpy->cursor_fb);
>      }
> diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
> index 3d19dbe382..86d64c68ce 100644
> --- a/ui/egl-helpers.c
> +++ b/ui/egl-helpers.c
> @@ -146,10 +146,10 @@ void egl_fb_blit(egl_fb *dst, egl_fb *src, bool fli=
p)
>      glViewport(0, 0, dst->width, dst->height);
>
>      if (src->dmabuf) {
> -        x1 =3D src->dmabuf->x;
> -        y1 =3D src->dmabuf->y;
> -        w =3D src->dmabuf->width;
> -        h =3D src->dmabuf->height;
> +        x1 =3D dpy_gl_qemu_dmabuf_get_x(src->dmabuf);
> +        y1 =3D dpy_gl_qemu_dmabuf_get_y(src->dmabuf);
> +        w =3D dpy_gl_qemu_dmabuf_get_width(src->dmabuf);
> +        h =3D dpy_gl_qemu_dmabuf_get_height(src->dmabuf);
>      }
>
>      w =3D (x1 + w) > src->width ? src->width - x1 : w;
> @@ -308,30 +308,33 @@ void egl_dmabuf_import_texture(QemuDmaBuf *dmabuf)
>      EGLImageKHR image =3D EGL_NO_IMAGE_KHR;
>      EGLint attrs[64];
>      int i =3D 0;
> +    uint64_t modifier;
> +    uint32_t texture =3D dpy_gl_qemu_dmabuf_get_texture(dmabuf);
>
> -    if (dmabuf->texture !=3D 0) {
> +    if (texture !=3D 0) {
>          return;
>      }
>
>      attrs[i++] =3D EGL_WIDTH;
> -    attrs[i++] =3D dmabuf->backing_width;
> +    attrs[i++] =3D dpy_gl_qemu_dmabuf_get_backing_width(dmabuf);
>      attrs[i++] =3D EGL_HEIGHT;
> -    attrs[i++] =3D dmabuf->backing_height;
> +    attrs[i++] =3D dpy_gl_qemu_dmabuf_get_backing_height(dmabuf);
>      attrs[i++] =3D EGL_LINUX_DRM_FOURCC_EXT;
> -    attrs[i++] =3D dmabuf->fourcc;
> +    attrs[i++] =3D dpy_gl_qemu_dmabuf_get_fourcc(dmabuf);
>
>      attrs[i++] =3D EGL_DMA_BUF_PLANE0_FD_EXT;
> -    attrs[i++] =3D dmabuf->fd;
> +    attrs[i++] =3D dpy_gl_qemu_dmabuf_get_fd(dmabuf);
>      attrs[i++] =3D EGL_DMA_BUF_PLANE0_PITCH_EXT;
> -    attrs[i++] =3D dmabuf->stride;
> +    attrs[i++] =3D dpy_gl_qemu_dmabuf_get_stride(dmabuf);
>      attrs[i++] =3D EGL_DMA_BUF_PLANE0_OFFSET_EXT;
>      attrs[i++] =3D 0;
>  #ifdef EGL_DMA_BUF_PLANE0_MODIFIER_LO_EXT
> -    if (dmabuf->modifier) {
> +    modifier =3D dpy_gl_qemu_dmabuf_get_modifier(dmabuf);
> +    if (modifier) {
>          attrs[i++] =3D EGL_DMA_BUF_PLANE0_MODIFIER_LO_EXT;
> -        attrs[i++] =3D (dmabuf->modifier >>  0) & 0xffffffff;
> +        attrs[i++] =3D (modifier >>  0) & 0xffffffff;
>          attrs[i++] =3D EGL_DMA_BUF_PLANE0_MODIFIER_HI_EXT;
> -        attrs[i++] =3D (dmabuf->modifier >> 32) & 0xffffffff;
> +        attrs[i++] =3D (modifier >> 32) & 0xffffffff;
>      }
>  #endif
>      attrs[i++] =3D EGL_NONE;
> @@ -346,7 +349,8 @@ void egl_dmabuf_import_texture(QemuDmaBuf *dmabuf)
>      }
>
>      glGenTextures(1, &dmabuf->texture);
> -    glBindTexture(GL_TEXTURE_2D, dmabuf->texture);
> +    texture =3D dpy_gl_qemu_dmabuf_get_texture(dmabuf);
> +    glBindTexture(GL_TEXTURE_2D, texture);
>      glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
>      glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
>
> @@ -356,11 +360,14 @@ void egl_dmabuf_import_texture(QemuDmaBuf *dmabuf)
>
>  void egl_dmabuf_release_texture(QemuDmaBuf *dmabuf)
>  {
> -    if (dmabuf->texture =3D=3D 0) {
> +    uint32_t texture;
> +
> +    texture =3D dpy_gl_qemu_dmabuf_get_texture(dmabuf);
> +    if (texture =3D=3D 0) {
>          return;
>      }
>
> -    glDeleteTextures(1, &dmabuf->texture);
> +    glDeleteTextures(1, &texture);
>      dmabuf->texture =3D 0;
>  }
>
> @@ -382,10 +389,12 @@ void egl_dmabuf_create_sync(QemuDmaBuf *dmabuf)
>
>  void egl_dmabuf_create_fence(QemuDmaBuf *dmabuf)
>  {
> -    if (dmabuf->sync) {
> +    void *sync =3D dpy_gl_qemu_dmabuf_get_sync(dmabuf);
> +
> +    if (sync) {
>          dmabuf->fence_fd =3D eglDupNativeFenceFDANDROID(qemu_egl_display=
,
> -                                                      dmabuf->sync);
> -        eglDestroySyncKHR(qemu_egl_display, dmabuf->sync);
> +                                                      sync);
> +        eglDestroySyncKHR(qemu_egl_display, sync);
>          dmabuf->sync =3D NULL;
>      }
>  }
> diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
> index 3af5ac5bcf..c9469af9ed 100644
> --- a/ui/gtk-egl.c
> +++ b/ui/gtk-egl.c
> @@ -70,6 +70,7 @@ void gd_egl_draw(VirtualConsole *vc)
>      QemuDmaBuf *dmabuf =3D vc->gfx.guest_fb.dmabuf;
>  #endif
>      int ww, wh, ws;
> +    int fence_fd;
>
>      if (!vc->gfx.gls) {
>          return;
> @@ -83,7 +84,7 @@ void gd_egl_draw(VirtualConsole *vc)
>      if (vc->gfx.scanout_mode) {
>  #ifdef CONFIG_GBM
>          if (dmabuf) {
> -            if (!dmabuf->draw_submitted) {
> +            if (!dpy_gl_qemu_dmabuf_get_draw_submitted(dmabuf)) {
>                  return;
>              } else {
>                  dmabuf->draw_submitted =3D false;
> @@ -99,8 +100,9 @@ void gd_egl_draw(VirtualConsole *vc)
>  #ifdef CONFIG_GBM
>          if (dmabuf) {
>              egl_dmabuf_create_fence(dmabuf);
> -            if (dmabuf->fence_fd > 0) {
> -                qemu_set_fd_handler(dmabuf->fence_fd, gd_hw_gl_flushed, =
NULL, vc);
> +            fence_fd =3D dpy_gl_qemu_dmabuf_get_fence_fd(dmabuf);
> +            if (fence_fd > 0) {
> +                qemu_set_fd_handler(fence_fd, gd_hw_gl_flushed, NULL, vc=
);
>                  return;
>              }
>              graphic_hw_gl_block(vc->gfx.dcl.con, false);
> @@ -149,7 +151,8 @@ void gd_egl_refresh(DisplayChangeListener *dcl)
>      gd_update_monitor_refresh_rate(
>              vc, vc->window ? vc->window : vc->gfx.drawing_area);
>
> -    if (vc->gfx.guest_fb.dmabuf && vc->gfx.guest_fb.dmabuf->draw_submitt=
ed) {
> +    if (vc->gfx.guest_fb.dmabuf &&
> +        dpy_gl_qemu_dmabuf_get_draw_submitted(vc->gfx.guest_fb.dmabuf)) =
{
>          return;
>      }
>
> @@ -264,22 +267,30 @@ void gd_egl_scanout_dmabuf(DisplayChangeListener *d=
cl,
>  {
>  #ifdef CONFIG_GBM
>      VirtualConsole *vc =3D container_of(dcl, VirtualConsole, gfx.dcl);
> +    uint32_t x, y, width, height, backing_width, backing_height, texture=
;
> +    bool y0_top;
>
>      eglMakeCurrent(qemu_egl_display, vc->gfx.esurface,
>                     vc->gfx.esurface, vc->gfx.ectx);
>
>      egl_dmabuf_import_texture(dmabuf);
> -    if (!dmabuf->texture) {
> +    texture =3D dpy_gl_qemu_dmabuf_get_texture(dmabuf);
> +    if (!texture) {
>          return;
>      }
>
> -    gd_egl_scanout_texture(dcl, dmabuf->texture,
> -                           dmabuf->y0_top,
> -                           dmabuf->backing_width, dmabuf->backing_height=
,
> -                           dmabuf->x, dmabuf->y, dmabuf->width,
> -                           dmabuf->height, NULL);
> +    x =3D dpy_gl_qemu_dmabuf_get_x(dmabuf);
> +    y =3D dpy_gl_qemu_dmabuf_get_y(dmabuf);
> +    width =3D dpy_gl_qemu_dmabuf_get_width(dmabuf);
> +    height =3D dpy_gl_qemu_dmabuf_get_height(dmabuf);
> +    backing_width =3D dpy_gl_qemu_dmabuf_get_backing_width(dmabuf);
> +    backing_height =3D dpy_gl_qemu_dmabuf_get_backing_height(dmabuf);
> +    y0_top =3D dpy_gl_qemu_dmabuf_get_y0_top(dmabuf);
>
> -    if (dmabuf->allow_fences) {
> +    gd_egl_scanout_texture(dcl, texture, y0_top, backing_width, backing_=
height,
> +                           x, y, width, height, NULL);
> +
> +    if (dpy_gl_qemu_dmabuf_get_allow_fences(dmabuf)) {
>          vc->gfx.guest_fb.dmabuf =3D dmabuf;
>      }
>  #endif
> @@ -291,15 +302,19 @@ void gd_egl_cursor_dmabuf(DisplayChangeListener *dc=
l,
>  {
>  #ifdef CONFIG_GBM
>      VirtualConsole *vc =3D container_of(dcl, VirtualConsole, gfx.dcl);
> +    uint32_t backing_width, backing_height, texture;
>
>      if (dmabuf) {
>          egl_dmabuf_import_texture(dmabuf);
> -        if (!dmabuf->texture) {
> +        texture =3D dpy_gl_qemu_dmabuf_get_texture(dmabuf);
> +        if (!texture) {
>              return;
>          }
> -        egl_fb_setup_for_tex(&vc->gfx.cursor_fb,
> -                             dmabuf->backing_width, dmabuf->backing_heig=
ht,
> -                             dmabuf->texture, false);
> +
> +        backing_width =3D dpy_gl_qemu_dmabuf_get_backing_width(dmabuf);
> +        backing_height =3D dpy_gl_qemu_dmabuf_get_backing_height(dmabuf)=
;
> +        egl_fb_setup_for_tex(&vc->gfx.cursor_fb, backing_width, backing_=
height,
> +                             texture, false);
>      } else {
>          egl_fb_destroy(&vc->gfx.cursor_fb);
>      }
> @@ -363,7 +378,8 @@ void gd_egl_flush(DisplayChangeListener *dcl,
>      VirtualConsole *vc =3D container_of(dcl, VirtualConsole, gfx.dcl);
>      GtkWidget *area =3D vc->gfx.drawing_area;
>
> -    if (vc->gfx.guest_fb.dmabuf && !vc->gfx.guest_fb.dmabuf->draw_submit=
ted) {
> +    if (vc->gfx.guest_fb.dmabuf &&
> +        !dpy_gl_qemu_dmabuf_get_draw_submitted(vc->gfx.guest_fb.dmabuf))=
 {
>          graphic_hw_gl_block(vc->gfx.dcl.con, true);
>          vc->gfx.guest_fb.dmabuf->draw_submitted =3D true;
>          gtk_egl_set_scanout_mode(vc, true);
> diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
> index 52dcac161e..193862ecc2 100644
> --- a/ui/gtk-gl-area.c
> +++ b/ui/gtk-gl-area.c
> @@ -60,7 +60,7 @@ void gd_gl_area_draw(VirtualConsole *vc)
>
>  #ifdef CONFIG_GBM
>          if (dmabuf) {
> -            if (!dmabuf->draw_submitted) {
> +            if (!dpy_gl_qemu_dmabuf_get_draw_submitted(dmabuf)) {
>                  return;
>              } else {
>                  dmabuf->draw_submitted =3D false;
> @@ -85,9 +85,11 @@ void gd_gl_area_draw(VirtualConsole *vc)
>          glFlush();
>  #ifdef CONFIG_GBM
>          if (dmabuf) {
> +            int fence_fd;
>              egl_dmabuf_create_fence(dmabuf);
> -            if (dmabuf->fence_fd > 0) {
> -                qemu_set_fd_handler(dmabuf->fence_fd, gd_hw_gl_flushed, =
NULL, vc);
> +            fence_fd =3D dpy_gl_qemu_dmabuf_get_fence_fd(dmabuf);
> +            if (fence_fd > 0) {
> +                qemu_set_fd_handler(fence_fd, gd_hw_gl_flushed, NULL, vc=
);
>                  return;
>              }
>              graphic_hw_gl_block(vc->gfx.dcl.con, false);
> @@ -125,7 +127,8 @@ void gd_gl_area_refresh(DisplayChangeListener *dcl)
>
>      gd_update_monitor_refresh_rate(vc, vc->window ? vc->window : vc->gfx=
.drawing_area);
>
> -    if (vc->gfx.guest_fb.dmabuf && vc->gfx.guest_fb.dmabuf->draw_submitt=
ed) {
> +    if (vc->gfx.guest_fb.dmabuf &&
> +        dpy_gl_qemu_dmabuf_get_draw_submitted(vc->gfx.guest_fb.dmabuf)) =
{
>          return;
>      }
>
> @@ -285,7 +288,8 @@ void gd_gl_area_scanout_flush(DisplayChangeListener *=
dcl,
>  {
>      VirtualConsole *vc =3D container_of(dcl, VirtualConsole, gfx.dcl);
>
> -    if (vc->gfx.guest_fb.dmabuf && !vc->gfx.guest_fb.dmabuf->draw_submit=
ted) {
> +    if (vc->gfx.guest_fb.dmabuf &&
> +        !dpy_gl_qemu_dmabuf_get_draw_submitted(vc->gfx.guest_fb.dmabuf))=
 {
>          graphic_hw_gl_block(vc->gfx.dcl.con, true);
>          vc->gfx.guest_fb.dmabuf->draw_submitted =3D true;
>          gtk_gl_area_set_scanout_mode(vc, true);
> @@ -298,20 +302,29 @@ void gd_gl_area_scanout_dmabuf(DisplayChangeListene=
r *dcl,
>  {
>  #ifdef CONFIG_GBM
>      VirtualConsole *vc =3D container_of(dcl, VirtualConsole, gfx.dcl);
> +    uint32_t x, y, width, height, backing_width, backing_height, texture=
;
> +    bool y0_top;
>
>      gtk_gl_area_make_current(GTK_GL_AREA(vc->gfx.drawing_area));
>      egl_dmabuf_import_texture(dmabuf);
> -    if (!dmabuf->texture) {
> +    texture =3D dpy_gl_qemu_dmabuf_get_texture(dmabuf);
> +    if (!texture) {
>          return;
>      }
>
> -    gd_gl_area_scanout_texture(dcl, dmabuf->texture,
> -                               dmabuf->y0_top,
> -                               dmabuf->backing_width, dmabuf->backing_he=
ight,
> -                               dmabuf->x, dmabuf->y, dmabuf->width,
> -                               dmabuf->height, NULL);
> +    x =3D dpy_gl_qemu_dmabuf_get_x(dmabuf);
> +    y =3D dpy_gl_qemu_dmabuf_get_y(dmabuf);
> +    width =3D dpy_gl_qemu_dmabuf_get_width(dmabuf);
> +    height =3D dpy_gl_qemu_dmabuf_get_height(dmabuf);
> +    backing_width =3D dpy_gl_qemu_dmabuf_get_backing_width(dmabuf);
> +    backing_height =3D dpy_gl_qemu_dmabuf_get_backing_height(dmabuf);
> +    y0_top =3D dpy_gl_qemu_dmabuf_get_y0_top(dmabuf);
>
> -    if (dmabuf->allow_fences) {
> +    gd_gl_area_scanout_texture(dcl, texture, y0_top,
> +                               backing_width, backing_height,
> +                               x, y, width, height, NULL);
> +
> +    if (dpy_gl_qemu_dmabuf_get_allow_fences(dmabuf)) {
>          vc->gfx.guest_fb.dmabuf =3D dmabuf;
>      }
>  #endif
> diff --git a/ui/gtk.c b/ui/gtk.c
> index 810d7fc796..2c054a42ba 100644
> --- a/ui/gtk.c
> +++ b/ui/gtk.c
> @@ -596,9 +596,11 @@ void gd_hw_gl_flushed(void *vcon)
>  {
>      VirtualConsole *vc =3D vcon;
>      QemuDmaBuf *dmabuf =3D vc->gfx.guest_fb.dmabuf;
> +    int fence_fd;
>
> -    qemu_set_fd_handler(dmabuf->fence_fd, NULL, NULL, NULL);
> -    close(dmabuf->fence_fd);
> +    fence_fd =3D dpy_gl_qemu_dmabuf_get_fence_fd(dmabuf);
> +    qemu_set_fd_handler(fence_fd, NULL, NULL, NULL);
> +    close(fence_fd);
>      dmabuf->fence_fd =3D -1;
>      graphic_hw_gl_block(vc->gfx.dcl.con, false);
>  }
> diff --git a/ui/spice-display.c b/ui/spice-display.c
> index 6eb98a5a5c..fe49e910a0 100644
> --- a/ui/spice-display.c
> +++ b/ui/spice-display.c
> @@ -976,6 +976,7 @@ static void qemu_spice_gl_cursor_dmabuf(DisplayChange=
Listener *dcl,
>                                          uint32_t hot_x, uint32_t hot_y)
>  {
>      SimpleSpiceDisplay *ssd =3D container_of(dcl, SimpleSpiceDisplay, dc=
l);
> +    uint32_t width, height, texture;
>
>      ssd->have_hot =3D have_hot;
>      ssd->hot_x =3D hot_x;
> @@ -984,11 +985,13 @@ static void qemu_spice_gl_cursor_dmabuf(DisplayChan=
geListener *dcl,
>      trace_qemu_spice_gl_cursor(ssd->qxl.id, dmabuf !=3D NULL, have_hot);
>      if (dmabuf) {
>          egl_dmabuf_import_texture(dmabuf);
> -        if (!dmabuf->texture) {
> +        texture =3D dpy_gl_dmabuf_get_texture(dmabuf);

Same as earlier:
../ui/spice-display.c:988:19: error: implicit declaration of function
=E2=80=98dpy_gl_dmabuf_get_texture=E2=80=99; did you mean
=E2=80=98dpy_gl_qemu_dmabuf_get_texture=E2=80=99?
[-Werror=3Dimplicit-function-declaration]

Please fix the build with --enable-spice.

> +        if (!texture) {
>              return;
>          }
> -        egl_fb_setup_for_tex(&ssd->cursor_fb, dmabuf->width, dmabuf->hei=
ght,
> -                             dmabuf->texture, false);
> +        width =3D dpy_gl_dmabuf_get_width(dmabuf);
> +        height =3D dpy_gl_dmabuf_get_height(dmabuf);
> +        egl_fb_setup_for_tex(&ssd->cursor_fb, width, height, texture, fa=
lse);
>      } else {
>          egl_fb_destroy(&ssd->cursor_fb);
>      }
> @@ -1026,6 +1029,7 @@ static void qemu_spice_gl_update(DisplayChangeListe=
ner *dcl,
>      bool y_0_top =3D false; /* FIXME */
>      uint64_t cookie;
>      int fd;
> +    uint32_t width, height, texture;
>
>      if (!ssd->have_scanout) {
>          return;
> @@ -1042,41 +1046,45 @@ static void qemu_spice_gl_update(DisplayChangeLis=
tener *dcl,
>
>      if (ssd->guest_dmabuf_refresh) {
>          QemuDmaBuf *dmabuf =3D ssd->guest_dmabuf;
> +        width =3D dpy_gl_dmabuf_get_width(dmabuf);
> +        height =3D dpy_gl_dmabuf_get_height(dmabuf);
> +
>          if (render_cursor) {
>              egl_dmabuf_import_texture(dmabuf);
> -            if (!dmabuf->texture) {
> +            texture =3D dpy_gl_dmabuf_get_texture(dmabuf);
> +            if (!texture) {
>                  return;
>              }
>
>              /* source framebuffer */
> -            egl_fb_setup_for_tex(&ssd->guest_fb,
> -                                 dmabuf->width, dmabuf->height,
> -                                 dmabuf->texture, false);
> +            egl_fb_setup_for_tex(&ssd->guest_fb, width, height,
> +                                 texture, false);
>
>              /* dest framebuffer */
> -            if (ssd->blit_fb.width  !=3D dmabuf->width ||
> -                ssd->blit_fb.height !=3D dmabuf->height) {
> -                trace_qemu_spice_gl_render_dmabuf(ssd->qxl.id, dmabuf->w=
idth,
> -                                                  dmabuf->height);
> +            if (ssd->blit_fb.width  !=3D width ||
> +                ssd->blit_fb.height !=3D height) {
> +                trace_qemu_spice_gl_render_dmabuf(ssd->qxl.id, width,
> +                                                  height);
>                  egl_fb_destroy(&ssd->blit_fb);
>                  egl_fb_setup_new_tex(&ssd->blit_fb,
> -                                     dmabuf->width, dmabuf->height);
> +                                     width, height);
>                  fd =3D egl_get_fd_for_texture(ssd->blit_fb.texture,
>                                              &stride, &fourcc, NULL);
> -                spice_qxl_gl_scanout(&ssd->qxl, fd,
> -                                     dmabuf->width, dmabuf->height,
> +                spice_qxl_gl_scanout(&ssd->qxl, fd, width, height,
>                                       stride, fourcc, false);
>              }
>          } else {
> -            trace_qemu_spice_gl_forward_dmabuf(ssd->qxl.id,
> -                                               dmabuf->width, dmabuf->he=
ight);
> +            int stride =3D dpy_gl_dmabuf_get_stride(dmabuf);
> +            int fourcc =3D dpy_gl_dmabuf_get_fourcc(dmabuf);
> +            int y0top =3D dpy_gl_dmabuf_get_y0top(dmabuf);
> +            int fd =3D dpy_gl_dmabuf_get_fd(dmabuf);
> +
> +            trace_qemu_spice_gl_forward_dmabuf(ssd->qxl.id, width, heigh=
t);
>              /* note: spice server will close the fd, so hand over a dup =
*/
> -            spice_qxl_gl_scanout(&ssd->qxl, dup(dmabuf->fd),
> -                                 dmabuf->width, dmabuf->height,
> -                                 dmabuf->stride, dmabuf->fourcc,
> -                                 dmabuf->y0_top);
> +            spice_qxl_gl_scanout(&ssd->qxl, dup(fd), width, height,
> +                                 stride, fourcc, y0top);
>          }
> -        qemu_spice_gl_monitor_config(ssd, 0, 0, dmabuf->width, dmabuf->h=
eight);
> +        qemu_spice_gl_monitor_config(ssd, 0, 0, width, height);
>          ssd->guest_dmabuf_refresh =3D false;
>      }
>
> --
> 2.34.1
>


