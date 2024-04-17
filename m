Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34B22C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 11:16:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rx3Gn-0008N8-N3; Wed, 17 Apr 2024 07:16:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1rx3Gl-0008Mw-SB
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 07:16:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1rx3Gj-0005sC-Cm
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 07:16:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713352560;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9QV+5q/hlht8TwLGdjGxNqKWuZgYm8+boC+Nu2wJnuo=;
 b=VKh8FA1QU7/DFjBnkx3CkP2Y6GJfXGThM5qWlBO2MJJWUKjht560hc6L4DRN5S7RUSMYCk
 TEMN3vp+oi2TDzIn/AHFJlDslDcP+NsV+igISoIsQWkcKXOMZGcn8nPqpNx+g6kodKJ3cs
 XtHAg5h0NWqwsa6zx5vOhw24BNVVpBo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-ImnBkAmbMASZeMHHWzgkKA-1; Wed, 17 Apr 2024 07:15:58 -0400
X-MC-Unique: ImnBkAmbMASZeMHHWzgkKA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a51acf7c214so131625666b.1
 for <qemu-devel@nongnu.org>; Wed, 17 Apr 2024 04:15:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713352557; x=1713957357;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9QV+5q/hlht8TwLGdjGxNqKWuZgYm8+boC+Nu2wJnuo=;
 b=bhvCD7seHytLR3VwhtX4+Zysn0WYHeL793A9UO9PddfSQgw4F3eyZ9OnkeqFqdQ56J
 qpscR3fFcMBH3Pxk93NoyEeZPpFRyV+hg/Ko1OYd79Q+ni3CyPo+9R46OQgGQCiugWSV
 5qzOJDVewDUQaN8QB0k4pwhWz7R9RX01j8erLVpURsmh527fXE/nbUhG+nJE1ufdVBuG
 uyaPgRhwpFjvjiOpGiWl7fNEVUrgmmwXZtoktlyt9lGG+mPnwqkAeSZk4xOUzY7CFU1H
 8C3UvNuKo+uoQ/uhWXc4Vj22dzPMdQ98vpMgwA5JAAmfgp2XxNFFHHpUdMeUfqvJ3Agv
 f2/Q==
X-Gm-Message-State: AOJu0Yz7b0us8H/pq27KEgOa0i7N+1aymdtgI8oUHvueEPlk4lNLJZy/
 KrOACHAxQTc1h3u7+8am+B2Mv22rWvRpxUoollHmmFof3Dm4jBFXfBbewXjGWa15gyY++uuVMwJ
 izSFgz/zJRjYjKb2tUuQvMGx2rjnDXHuboEy98eHww2jbuO6UFSnlFuSyoagDiWlCmsuU8ZJ7ky
 nFr6Rppzmjibkx4kVXNCge4HnwFP/hCA7xKcI=
X-Received: by 2002:a50:9eee:0:b0:56e:1010:cd7c with SMTP id
 a101-20020a509eee000000b0056e1010cd7cmr6087440edf.12.1713352556749; 
 Wed, 17 Apr 2024 04:15:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvsoIH0OzpAgVOFgV01YffzA0HsdXaHoihZoQWUsGno/yiyXHtFqeUjo7VCstZNKZ2JQpyK6ImQV7vzWYLjk4=
X-Received: by 2002:a50:9eee:0:b0:56e:1010:cd7c with SMTP id
 a101-20020a509eee000000b0056e1010cd7cmr6087415edf.12.1713352556223; Wed, 17
 Apr 2024 04:15:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240417040954.55641-1-dongwon.kim@intel.com>
 <20240417040954.55641-4-dongwon.kim@intel.com>
In-Reply-To: <20240417040954.55641-4-dongwon.kim@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 17 Apr 2024 15:15:43 +0400
Message-ID: <CAMxuvawAAe6V42BiiFLq1Vyv=2i5BF7KcMt61M9b-60aPcd7HQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] ui/console: Introduce dpy_gl_qemu_dmabuf_new() and
 free() helpers
To: dongwon.kim@intel.com
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.719,
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

On Wed, Apr 17, 2024 at 8:14=E2=80=AFAM <dongwon.kim@intel.com> wrote:
>
> From: Dongwon Kim <dongwon.kim@intel.com>
>
> This commit introduces utility functions for the creation and deallocatio=
n
> of QemuDmaBuf instances. Additionally, it updates all relevant sections
> of the codebase to utilize these new utility functions.
>
> Suggested-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
> Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
> ---
>  include/hw/vfio/vfio-common.h   |  2 +-
>  include/hw/virtio/virtio-gpu.h  |  4 ++--
>  include/ui/console.h            |  8 +++++++-
>  hw/display/vhost-user-gpu.c     | 32 +++++++++++++++++--------------
>  hw/display/virtio-gpu-udmabuf.c | 24 +++++++++--------------
>  hw/vfio/display.c               | 26 ++++++++++++-------------
>  ui/console.c                    | 34 +++++++++++++++++++++++++++++++++
>  ui/dbus-listener.c              | 28 ++++++++++++---------------
>  8 files changed, 95 insertions(+), 63 deletions(-)
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
> diff --git a/include/ui/console.h b/include/ui/console.h
> index 3d9d8b9fce..6d7c03b7c5 100644
> --- a/include/ui/console.h
> +++ b/include/ui/console.h
> @@ -358,7 +358,13 @@ void dpy_gl_cursor_dmabuf(QemuConsole *con, QemuDmaB=
uf *dmabuf,
>                            bool have_hot, uint32_t hot_x, uint32_t hot_y)=
;
>  void dpy_gl_cursor_position(QemuConsole *con,
>                              uint32_t pos_x, uint32_t pos_y);
> -
> +QemuDmaBuf *dpy_gl_qemu_dmabuf_new(uint32_t width, uint32_t height,
> +                                   uint32_t stride, uint32_t x,
> +                                   uint32_t y, uint32_t backing_width,
> +                                   uint32_t backing_height, uint32_t fou=
rcc,
> +                                   uint64_t modifier, uint32_t dmabuf_fd=
,

An fd is an int.

> +                                   bool allow_fences, bool y0_top);
> +void dpy_gl_qemu_dmabuf_free(QemuDmaBuf *dmabuf);
>  int32_t dpy_gl_qemu_dmabuf_get_fd(QemuDmaBuf *dmabuf);
>  uint32_t dpy_gl_qemu_dmabuf_get_width(QemuDmaBuf *dmabuf);
>  uint32_t dpy_gl_qemu_dmabuf_get_height(QemuDmaBuf *dmabuf);
> diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
> index 87dcfbca10..4d8461e94a 100644
> --- a/hw/display/vhost-user-gpu.c
> +++ b/hw/display/vhost-user-gpu.c
> @@ -250,6 +250,7 @@ vhost_user_gpu_handle_display(VhostUserGPU *g, VhostU=
serGpuMsg *msg)
>          VhostUserGpuDMABUFScanout *m =3D &msg->payload.dmabuf_scanout;
>          int fd =3D qemu_chr_fe_get_msgfd(&g->vhost_chr);
>          int old_fd;
> +        uint64_t modifier =3D 0;
>          QemuDmaBuf *dmabuf;
>
>          if (m->scanout_id >=3D g->parent_obj.conf.max_outputs) {
> @@ -262,31 +263,34 @@ vhost_user_gpu_handle_display(VhostUserGPU *g, Vhos=
tUserGpuMsg *msg)
>
>          g->parent_obj.enable =3D 1;
>          con =3D g->parent_obj.scanout[m->scanout_id].con;
> -        dmabuf =3D &g->dmabuf[m->scanout_id];
> -        old_fd =3D dpy_gl_qemu_dmabuf_get_fd(dmabuf);
> -        if (old_fd >=3D 0) {
> -            close(old_fd);
> -            dmabuf->fd =3D -1;
> +        dmabuf =3D g->dmabuf[m->scanout_id];
> +        if (dmabuf) {
> +            old_fd =3D dpy_gl_qemu_dmabuf_get_fd(dmabuf);
> +            if (old_fd >=3D 0) {
> +                close(old_fd);
> +                dpy_gl_qemu_dmabuf_set_fd(dmabuf, -1);
> +            }
>          }
>          dpy_gl_release_dmabuf(con, dmabuf);
> +        g_clear_pointer(&dmabuf, dpy_gl_qemu_dmabuf_free);
>          if (fd =3D=3D -1) {
>              dpy_gl_scanout_disable(con);
>              break;
>          }
> -        *dmabuf =3D (QemuDmaBuf) {
> -            .fd =3D fd,
> -            .width =3D m->fd_width,
> -            .height =3D m->fd_height,
> -            .stride =3D m->fd_stride,
> -            .fourcc =3D m->fd_drm_fourcc,
> -            .y0_top =3D m->fd_flags & VIRTIO_GPU_RESOURCE_FLAG_Y_0_TOP,
> -        };
> +
>          if (msg->request =3D=3D VHOST_USER_GPU_DMABUF_SCANOUT2) {
>              VhostUserGpuDMABUFScanout2 *m2 =3D &msg->payload.dmabuf_scan=
out2;
> -            dmabuf->modifier =3D m2->modifier;
> +            modifier =3D m2->modifier;
>          }
>
> +        dmabuf =3D dpy_gl_qemu_dmabuf_new(m->fd_width, m->fd_height,
> +                                        m->fd_stride, 0, 0, 0, 0,
> +                                        m->fd_drm_fourcc, modifier,
> +                                        fd, false, m->fd_flags &
> +                                        VIRTIO_GPU_RESOURCE_FLAG_Y_0_TOP=
);
> +
>          dpy_gl_scanout_dmabuf(con, dmabuf);
> +        g->dmabuf[m->scanout_id] =3D dmabuf;
>          break;
>      }
>      case VHOST_USER_GPU_DMABUF_UPDATE: {
> diff --git a/hw/display/virtio-gpu-udmabuf.c b/hw/display/virtio-gpu-udma=
buf.c
> index e3f358b575..79eafc7289 100644
> --- a/hw/display/virtio-gpu-udmabuf.c
> +++ b/hw/display/virtio-gpu-udmabuf.c
> @@ -162,7 +162,8 @@ static void virtio_gpu_free_dmabuf(VirtIOGPU *g, VGPU=
DMABuf *dmabuf)
>      struct virtio_gpu_scanout *scanout;
>
>      scanout =3D &g->parent_obj.scanout[dmabuf->scanout_id];
> -    dpy_gl_release_dmabuf(scanout->con, &dmabuf->buf);
> +    dpy_gl_release_dmabuf(scanout->con, dmabuf->buf);
> +    g_clear_pointer(&dmabuf->buf, dpy_gl_qemu_dmabuf_free);
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
> +    dmabuf->buf =3D dpy_gl_qemu_dmabuf_new(r->width, r->height, fb->stri=
de,
> +                                         r->x, r->y, fb->width, fb->heig=
ht,
> +                                         qemu_pixman_to_drm_format(fb->f=
ormat),
> +                                         0, res->dmabuf_fd, false, 0);
>      dmabuf->scanout_id =3D scanout_id;
>      QTAILQ_INSERT_HEAD(&g->dmabuf.bufs, dmabuf, next);
>
> @@ -217,11 +211,11 @@ int virtio_gpu_update_dmabuf(VirtIOGPU *g,
>          old_primary =3D g->dmabuf.primary[scanout_id];
>      }
>
> -    width =3D dpy_gl_qemu_dmabuf_get_width(&new_primary->buf);
> -    height =3D dpy_gl_qemu_dmabuf_get_height(&new_primary->buf);
> +    width =3D dpy_gl_qemu_dmabuf_get_width(new_primary->buf);
> +    height =3D dpy_gl_qemu_dmabuf_get_height(new_primary->buf);
>      g->dmabuf.primary[scanout_id] =3D new_primary;
>      qemu_console_resize(scanout->con, width, height);
> -    dpy_gl_scanout_dmabuf(scanout->con, &new_primary->buf);
> +    dpy_gl_scanout_dmabuf(scanout->con, new_primary->buf);
>
>      if (old_primary) {
>          virtio_gpu_free_dmabuf(g, old_primary);
> diff --git a/hw/vfio/display.c b/hw/vfio/display.c
> index f9c39cbd51..7e26d9667f 100644
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
> +    dmabuf->buf =3D dpy_gl_qemu_dmabuf_new(plane.width, plane.height,
> +                                         plane.stride, 0, 0, plane.width=
,
> +                                         plane.height, plane.drm_format,
> +                                         plane.drm_format_mod, fd, false=
, 0);
> +
>      if (plane_type =3D=3D DRM_PLANE_TYPE_CURSOR) {
>          vfio_display_update_cursor(dmabuf, &plane);
>      }
> @@ -263,8 +260,9 @@ static void vfio_display_free_one_dmabuf(VFIODisplay =
*dpy, VFIODMABuf *dmabuf)
>
>      QTAILQ_REMOVE(&dpy->dmabuf.bufs, dmabuf, next);
>
> -    fd =3D dpy_gl_qemu_dmabuf_get_fd(&dmabuf->buf);
> -    dpy_gl_release_dmabuf(dpy->con, &dmabuf->buf);
> +    fd =3D dpy_gl_qemu_dmabuf_get_fd(dmabuf->buf);
> +    dpy_gl_release_dmabuf(dpy->con, dmabuf->buf);
> +    g_clear_pointer(&dmabuf->buf, dpy_gl_qemu_dmabuf_free);
>      close(fd);
>      g_free(dmabuf);
>  }
> @@ -301,13 +299,13 @@ static void vfio_display_dmabuf_update(void *opaque=
)
>          return;
>      }
>
> -    width =3D dpy_gl_qemu_dmabuf_get_width(&primary->buf);
> -    height =3D dpy_gl_qemu_dmabuf_get_height(&primary->buf);
> +    width =3D dpy_gl_qemu_dmabuf_get_width(primary->buf);
> +    height =3D dpy_gl_qemu_dmabuf_get_height(primary->buf);
>
>      if (dpy->dmabuf.primary !=3D primary) {
>          dpy->dmabuf.primary =3D primary;
>          qemu_console_resize(dpy->con, width, height);
> -        dpy_gl_scanout_dmabuf(dpy->con, &primary->buf);
> +        dpy_gl_scanout_dmabuf(dpy->con, primary->buf);
>          free_bufs =3D true;
>      }
>
> @@ -321,7 +319,7 @@ static void vfio_display_dmabuf_update(void *opaque)
>      if (cursor && (new_cursor || cursor->hot_updates)) {
>          bool have_hot =3D (cursor->hot_x !=3D 0xffffffff &&
>                           cursor->hot_y !=3D 0xffffffff);
> -        dpy_gl_cursor_dmabuf(dpy->con, &cursor->buf, have_hot,
> +        dpy_gl_cursor_dmabuf(dpy->con, cursor->buf, have_hot,
>                               cursor->hot_x, cursor->hot_y);
>          cursor->hot_updates =3D 0;
>      } else if (!cursor && new_cursor) {
> diff --git a/ui/console.c b/ui/console.c
> index d4ca9e6e0f..ea23fd8af6 100644
> --- a/ui/console.c
> +++ b/ui/console.c
> @@ -1132,6 +1132,40 @@ void dpy_gl_cursor_position(QemuConsole *con,
>      }
>  }
>
> +QemuDmaBuf *dpy_gl_qemu_dmabuf_new(uint32_t width, uint32_t height,
> +                                   uint32_t stride, uint32_t x,
> +                                   uint32_t y, uint32_t backing_width,
> +                                   uint32_t backing_height, uint32_t fou=
rcc,
> +                                   uint64_t modifier, uint32_t dmabuf_fd=
,
> +                                   bool allow_fences, bool y0_top) {
> +    QemuDmaBuf *dmabuf;
> +
> +    dmabuf =3D g_new0(QemuDmaBuf, 1);
> +
> +    dmabuf->width =3D width;
> +    dmabuf->height =3D height;
> +    dmabuf->stride =3D stride;
> +    dmabuf->x =3D x;
> +    dmabuf->y =3D y;
> +    dmabuf->backing_width =3D backing_width;
> +    dmabuf->backing_height =3D backing_height;
> +    dmabuf->fourcc =3D fourcc;
> +    dmabuf->modifier =3D modifier;
> +    dmabuf->fd =3D dmabuf_fd;
> +    dmabuf->allow_fences =3D allow_fences;
> +    dmabuf->y0_top =3D y0_top;
> +    dmabuf->fence_fd =3D -1;
> +
> +    return dmabuf;
> +}

After those changes you should be able to make QemuDmaBuf a private
struct (defined in the a .c). This can be an additional patch to ease
review.

> +
> +void dpy_gl_qemu_dmabuf_free(QemuDmaBuf *dmabuf)
> +{
> +    assert(dmabuf !=3D NULL);
> +
> +    g_free(dmabuf);
> +}
> +
>  int32_t dpy_gl_qemu_dmabuf_get_fd(QemuDmaBuf *dmabuf)
>  {
>      assert(dmabuf !=3D NULL);
> diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
> index c6c7d93753..85d779a45c 100644
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
> +    int32_t fd;
> +    uint32_t stride, fourcc;
> +    uint64_t modifier;
> +    QemuDmaBuf *dmabuf;
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
> +    dmabuf =3D dpy_gl_qemu_dmabuf_new(w, h, stride, x, y, backing_width,
> +                                    backing_height, fourcc, modifier, fd=
,
> +                                    false, backing_y_0_top);
>
> -    dbus_scanout_dmabuf(dcl, &dmabuf);
> -    close(dmabuf.fd);
> +    dbus_scanout_dmabuf(dcl, dmabuf);
> +    close(fd);
>  #endif
>
>  #ifdef WIN32
> --
> 2.34.1
>


