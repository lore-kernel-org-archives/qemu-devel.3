Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D64B9C36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 10:05:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twefx-0005fD-Cw; Mon, 24 Mar 2025 06:04:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1twefo-0005eP-NH
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 06:04:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1twefm-0004os-Bz
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 06:04:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742810684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j1yizPaucWl/SdRQFGDIi9PUTOZgb6M3xOsbGGzx3sY=;
 b=E3GUdkDGK8g5ZR0NUMGjDPAbuoYzJhS848p1izjn8vFMVxs1xJUK1xDkux/hybqNLOLdpP
 VgG10jbMDIaAcYBkREXqgG1V0NQtinksRC9DsW3fndM7lb+5C0gdoTspACGst2orTVvG5g
 2cXCDckqa1d32hzZnljPZbwU/Xss4vQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-p801ho9cNsG8_71u9nXGNQ-1; Mon, 24 Mar 2025 06:04:43 -0400
X-MC-Unique: p801ho9cNsG8_71u9nXGNQ-1
X-Mimecast-MFC-AGG-ID: p801ho9cNsG8_71u9nXGNQ_1742810683
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7c5d608e6f5so70204685a.0
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 03:04:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742810683; x=1743415483;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j1yizPaucWl/SdRQFGDIi9PUTOZgb6M3xOsbGGzx3sY=;
 b=YrjpgAGcUp9i5b9r4Lt6Vrf5b7PxPwZzZ6hC36aJ2mKCSBNyzoyiY7s3/bTUN//9Ac
 Yn5c5+12t/i/Wi5uOsVvPtaKHbcAVCl5SgBGc3nNL+S3MWm+xn1plySw9TodN/J9L2CT
 8vPIFu+cDgjOr/JNXVcs8S20iUhEVF2GYveCq/e8NvSOvU+MNqsV1g2XAciCVpedRRpa
 pPn3HwqUiwlT/24tPg4633QunM4ahHvDFTGF/fbL7OxO1gxV3qIkJhNc00EiYwvfGVm3
 eypUPakQyhTn2DnWKnhpNRFa3ogAuK4b57FTCW/A8K8fqM0Fb19NhlJk1eWdZ7q9lqCQ
 2YAg==
X-Gm-Message-State: AOJu0YwVY907Y055D5sGqLDas0LM7L4/g/fGv3X857zSwSJTP4leu4V8
 IvpCPUgjVtfNUslsg3cvmFJkUmig8//Sm6PkZsUvrFqfPIOqyvVjqinR3BRyX4Xm1HBn/zqGSOU
 DS1bq5lwyZiCwA4U3FjKbRQktZJyaIcynMbOrEZ7qnV/88IGvXd8j5cH+rmK1d6UefToMh5cMtQ
 115w7LflL1Kt9WcCiNTLdP4DVognOezEeLEu5Rs37g
X-Gm-Gg: ASbGnctLmOHGVTb0TI7McS5FQfkFKIRjSHGn52xEoCPSFhASfMyFty+2k9oUfK+9qvD
 UwRm42XnThe0wUN/eowsOfLBftClOSaJdJ4y+wZ1LP6M/JCHiOokwkxmmjAlHe9lbpa/E1gJW7g
 lLvrwVCpWPFpSdHAbEgdQmI9Dl86oXWQ==
X-Received: by 2002:a05:620a:46a1:b0:7c5:5670:bd81 with SMTP id
 af79cd13be357-7c5ba1deeb7mr1930686285a.35.1742810682557; 
 Mon, 24 Mar 2025 03:04:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiAAE1lDa55TCyfWMw83h8dho48/Pj2AzhrjOm2vGO0xthuzbK28oLCVlKmR5qlA+a6vJjBQPZ5qH3q3hOH/k=
X-Received: by 2002:a05:620a:46a1:b0:7c5:5670:bd81 with SMTP id
 af79cd13be357-7c5ba1deeb7mr1930681785a.35.1742810681959; Mon, 24 Mar 2025
 03:04:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250324081922.359369-1-yuq825@gmail.com>
 <20250324081922.359369-2-yuq825@gmail.com>
In-Reply-To: <20250324081922.359369-2-yuq825@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 24 Mar 2025 14:04:30 +0400
X-Gm-Features: AQ5f1Jp_LnvQ0q0hn9zOLEzJVrAgfl6vz1YVVbLe_FaoW8xRXYXI0yUGlIjl4t8
Message-ID: <CAMxuvawwGTN9Dh5tor-ADmNd_5AGnBEgwj7npiMSC59OWZJETg@mail.gmail.com>
Subject: Re: [PATCH 1/6] ui/dmabuf: extend QemuDmaBuf to support multi-plane
To: yuq825@gmail.com
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Mar 24, 2025 at 12:19=E2=80=AFPM <yuq825@gmail.com> wrote:
>
> From: Qiang Yu <yuq825@gmail.com>
>
> mesa/radeonsi is going to support explicit midifier which
> may export a multi-plane texture. For example, texture with
> DCC enabled (a compressed format) has two planes, one with
> compressed data, the other with meta data for compression.
>
> Signed-off-by: Qiang Yu <yuq825@gmail.com>
> ---
>  hw/display/vhost-user-gpu.c     |  6 ++-
>  hw/display/virtio-gpu-udmabuf.c |  6 ++-
>  hw/vfio/display.c               |  7 ++--
>  include/ui/dmabuf.h             | 20 ++++++----
>  ui/dbus-listener.c              | 10 ++---
>  ui/dmabuf.c                     | 67 +++++++++++++++++++++------------
>  ui/egl-helpers.c                |  4 +-
>  ui/spice-display.c              |  4 +-
>  8 files changed, 76 insertions(+), 48 deletions(-)
>
> diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
> index 2aed6243f6..a7949c7078 100644
> --- a/hw/display/vhost-user-gpu.c
> +++ b/hw/display/vhost-user-gpu.c
> @@ -249,6 +249,8 @@ vhost_user_gpu_handle_display(VhostUserGPU *g, VhostU=
serGpuMsg *msg)
>      case VHOST_USER_GPU_DMABUF_SCANOUT: {
>          VhostUserGpuDMABUFScanout *m =3D &msg->payload.dmabuf_scanout;
>          int fd =3D qemu_chr_fe_get_msgfd(&g->vhost_chr);
> +        uint32_t offset =3D 0;
> +        uint32_t stride =3D m->fd_stride;
>          uint64_t modifier =3D 0;
>          QemuDmaBuf *dmabuf;
>
> @@ -282,10 +284,10 @@ vhost_user_gpu_handle_display(VhostUserGPU *g, Vhos=
tUserGpuMsg *msg)
>          }
>
>          dmabuf =3D qemu_dmabuf_new(m->width, m->height,
> -                                 m->fd_stride, 0, 0,
> +                                 &offset, &stride, 0, 0,
>                                   m->fd_width, m->fd_height,
>                                   m->fd_drm_fourcc, modifier,
> -                                 fd, false, m->fd_flags &
> +                                 &fd, 1, false, m->fd_flags &
>                                   VIRTIO_GPU_RESOURCE_FLAG_Y_0_TOP);
>
>          dpy_gl_scanout_dmabuf(con, dmabuf);
> diff --git a/hw/display/virtio-gpu-udmabuf.c b/hw/display/virtio-gpu-udma=
buf.c
> index 85ca23cb32..34fbe05b7a 100644
> --- a/hw/display/virtio-gpu-udmabuf.c
> +++ b/hw/display/virtio-gpu-udmabuf.c
> @@ -176,16 +176,18 @@ static VGPUDMABuf
>                            struct virtio_gpu_rect *r)
>  {
>      VGPUDMABuf *dmabuf;
> +    uint32_t offset =3D 0;
>
>      if (res->dmabuf_fd < 0) {
>          return NULL;
>      }
>
>      dmabuf =3D g_new0(VGPUDMABuf, 1);
> -    dmabuf->buf =3D qemu_dmabuf_new(r->width, r->height, fb->stride,
> +    dmabuf->buf =3D qemu_dmabuf_new(r->width, r->height,
> +                                  &offset, &fb->stride,
>                                    r->x, r->y, fb->width, fb->height,
>                                    qemu_pixman_to_drm_format(fb->format),
> -                                  0, res->dmabuf_fd, true, false);
> +                                  0, &res->dmabuf_fd, 1, true, false);
>      dmabuf->scanout_id =3D scanout_id;
>      QTAILQ_INSERT_HEAD(&g->dmabuf.bufs, dmabuf, next);
>
> diff --git a/hw/vfio/display.c b/hw/vfio/display.c
> index ea87830fe0..9d882235fb 100644
> --- a/hw/vfio/display.c
> +++ b/hw/vfio/display.c
> @@ -214,6 +214,7 @@ static VFIODMABuf *vfio_display_get_dmabuf(VFIOPCIDev=
ice *vdev,
>      struct vfio_device_gfx_plane_info plane;
>      VFIODMABuf *dmabuf;
>      int fd, ret;
> +    uint32_t offset =3D 0;
>
>      memset(&plane, 0, sizeof(plane));
>      plane.argsz =3D sizeof(plane);
> @@ -246,10 +247,10 @@ static VFIODMABuf *vfio_display_get_dmabuf(VFIOPCID=
evice *vdev,
>
>      dmabuf =3D g_new0(VFIODMABuf, 1);
>      dmabuf->dmabuf_id  =3D plane.dmabuf_id;
> -    dmabuf->buf =3D qemu_dmabuf_new(plane.width, plane.height,
> -                                  plane.stride, 0, 0, plane.width,
> +    dmabuf->buf =3D qemu_dmabuf_new(plane.width, plane.height, &offset,
> +                                  &plane.stride, 0, 0, plane.width,
>                                    plane.height, plane.drm_format,
> -                                  plane.drm_format_mod, fd, false, false=
);
> +                                  plane.drm_format_mod, &fd, 1, false, f=
alse);
>
>      if (plane_type =3D=3D DRM_PLANE_TYPE_CURSOR) {
>          vfio_display_update_cursor(dmabuf, &plane);
> diff --git a/include/ui/dmabuf.h b/include/ui/dmabuf.h
> index dc74ba895a..407fb2274e 100644
> --- a/include/ui/dmabuf.h
> +++ b/include/ui/dmabuf.h
> @@ -10,24 +10,29 @@
>  #ifndef DMABUF_H
>  #define DMABUF_H
>
> +#define DMABUF_MAX_PLANES 4
> +
>  typedef struct QemuDmaBuf QemuDmaBuf;
>
>  QemuDmaBuf *qemu_dmabuf_new(uint32_t width, uint32_t height,
> -                            uint32_t stride, uint32_t x,
> -                            uint32_t y, uint32_t backing_width,
> -                            uint32_t backing_height, uint32_t fourcc,
> -                            uint64_t modifier, int dmabuf_fd,
> +                            const uint32_t *offset, const uint32_t *stri=
de,
> +                            uint32_t x, uint32_t y,
> +                            uint32_t backing_width, uint32_t backing_hei=
ght,
> +                            uint32_t fourcc, uint64_t modifier,
> +                            const int32_t *dmabuf_fd, uint32_t num_plane=
s,
>                              bool allow_fences, bool y0_top);
>  void qemu_dmabuf_free(QemuDmaBuf *dmabuf);
>
>  G_DEFINE_AUTOPTR_CLEANUP_FUNC(QemuDmaBuf, qemu_dmabuf_free);
>
> -int qemu_dmabuf_get_fd(QemuDmaBuf *dmabuf);
> -int qemu_dmabuf_dup_fd(QemuDmaBuf *dmabuf);
> +const int *qemu_dmabuf_get_fd(QemuDmaBuf *dmabuf);

For clarity, I think the functions should be renamed to a plural form:
get_fds, dup_fds, get_strides, get_offsets etc.. I would also have a
size_t *n_fds to return the length of the returned array.

> +void qemu_dmabuf_dup_fd(QemuDmaBuf *dmabuf, int *fd);

That function should take an n_fds arguments as well (fd being renamed
to fds as well)

thanks

>  void qemu_dmabuf_close(QemuDmaBuf *dmabuf);
>  uint32_t qemu_dmabuf_get_width(QemuDmaBuf *dmabuf);
>  uint32_t qemu_dmabuf_get_height(QemuDmaBuf *dmabuf);
> -uint32_t qemu_dmabuf_get_stride(QemuDmaBuf *dmabuf);
> +const uint32_t *qemu_dmabuf_get_offset(QemuDmaBuf *dmabuf);
> +const uint32_t *qemu_dmabuf_get_stride(QemuDmaBuf *dmabuf);
> +uint32_t qemu_dmabuf_get_num_planes(QemuDmaBuf *dmabuf);
>  uint32_t qemu_dmabuf_get_fourcc(QemuDmaBuf *dmabuf);
>  uint64_t qemu_dmabuf_get_modifier(QemuDmaBuf *dmabuf);
>  uint32_t qemu_dmabuf_get_texture(QemuDmaBuf *dmabuf);
> @@ -44,6 +49,5 @@ void qemu_dmabuf_set_texture(QemuDmaBuf *dmabuf, uint32=
_t texture);
>  void qemu_dmabuf_set_fence_fd(QemuDmaBuf *dmabuf, int32_t fence_fd);
>  void qemu_dmabuf_set_sync(QemuDmaBuf *dmabuf, void *sync);
>  void qemu_dmabuf_set_draw_submitted(QemuDmaBuf *dmabuf, bool draw_submit=
ted);
> -void qemu_dmabuf_set_fd(QemuDmaBuf *dmabuf, int32_t fd);
>
>  #endif
> diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
> index 51244c9240..3b39a23846 100644
> --- a/ui/dbus-listener.c
> +++ b/ui/dbus-listener.c
> @@ -299,7 +299,7 @@ static void dbus_scanout_dmabuf(DisplayChangeListener=
 *dcl,
>      uint64_t modifier;
>      bool y0_top;
>
> -    fd =3D qemu_dmabuf_get_fd(dmabuf);
> +    fd =3D qemu_dmabuf_get_fd(dmabuf)[0];
>      fd_list =3D g_unix_fd_list_new();
>      if (g_unix_fd_list_append(fd_list, fd, &err) !=3D 0) {
>          error_report("Failed to setup dmabuf fdlist: %s", err->message);
> @@ -310,7 +310,7 @@ static void dbus_scanout_dmabuf(DisplayChangeListener=
 *dcl,
>
>      width =3D qemu_dmabuf_get_width(dmabuf);
>      height =3D qemu_dmabuf_get_height(dmabuf);
> -    stride =3D qemu_dmabuf_get_stride(dmabuf);
> +    stride =3D qemu_dmabuf_get_stride(dmabuf)[0];
>      fourcc =3D qemu_dmabuf_get_fourcc(dmabuf);
>      modifier =3D qemu_dmabuf_get_modifier(dmabuf);
>      y0_top =3D qemu_dmabuf_get_y0_top(dmabuf);
> @@ -505,7 +505,7 @@ static void dbus_scanout_texture(DisplayChangeListene=
r *dcl,
>  #ifdef CONFIG_GBM
>      g_autoptr(QemuDmaBuf) dmabuf =3D NULL;
>      int fd;
> -    uint32_t stride, fourcc;
> +    uint32_t offset =3D 0, stride, fourcc;
>      uint64_t modifier;
>
>      assert(tex_id);
> @@ -515,8 +515,8 @@ static void dbus_scanout_texture(DisplayChangeListene=
r *dcl,
>          error_report("%s: failed to get fd for texture", __func__);
>          return;
>      }
> -    dmabuf =3D qemu_dmabuf_new(w, h, stride, x, y, backing_width,
> -                             backing_height, fourcc, modifier, fd,
> +    dmabuf =3D qemu_dmabuf_new(w, h, &offset, &stride, x, y, backing_wid=
th,
> +                             backing_height, fourcc, modifier, &fd, 1,
>                               false, backing_y_0_top);
>
>      dbus_scanout_dmabuf(dcl, dmabuf);
> diff --git a/ui/dmabuf.c b/ui/dmabuf.c
> index df7a09703f..c4eb307042 100644
> --- a/ui/dmabuf.c
> +++ b/ui/dmabuf.c
> @@ -11,10 +11,12 @@
>  #include "ui/dmabuf.h"
>
>  struct QemuDmaBuf {
> -    int       fd;
> +    int       fd[DMABUF_MAX_PLANES];
>      uint32_t  width;
>      uint32_t  height;
> -    uint32_t  stride;
> +    uint32_t  offset[DMABUF_MAX_PLANES];
> +    uint32_t  stride[DMABUF_MAX_PLANES];
> +    uint32_t  num_planes;
>      uint32_t  fourcc;
>      uint64_t  modifier;
>      uint32_t  texture;
> @@ -30,28 +32,33 @@ struct QemuDmaBuf {
>  };
>
>  QemuDmaBuf *qemu_dmabuf_new(uint32_t width, uint32_t height,
> -                            uint32_t stride, uint32_t x,
> -                            uint32_t y, uint32_t backing_width,
> -                            uint32_t backing_height, uint32_t fourcc,
> -                            uint64_t modifier, int32_t dmabuf_fd,
> +                            const uint32_t *offset, const uint32_t *stri=
de,
> +                            uint32_t x, uint32_t y,
> +                            uint32_t backing_width, uint32_t backing_hei=
ght,
> +                            uint32_t fourcc, uint64_t modifier,
> +                            const int32_t *dmabuf_fd, uint32_t num_plane=
s,
>                              bool allow_fences, bool y0_top) {
>      QemuDmaBuf *dmabuf;
>
> +    assert(num_planes > 0 && num_planes <=3D DMABUF_MAX_PLANES);
> +
>      dmabuf =3D g_new0(QemuDmaBuf, 1);
>
>      dmabuf->width =3D width;
>      dmabuf->height =3D height;
> -    dmabuf->stride =3D stride;
> +    memcpy(dmabuf->offset, offset, num_planes * sizeof(*offset));
> +    memcpy(dmabuf->stride, stride, num_planes * sizeof(*stride));
>      dmabuf->x =3D x;
>      dmabuf->y =3D y;
>      dmabuf->backing_width =3D backing_width;
>      dmabuf->backing_height =3D backing_height;
>      dmabuf->fourcc =3D fourcc;
>      dmabuf->modifier =3D modifier;
> -    dmabuf->fd =3D dmabuf_fd;
> +    memcpy(dmabuf->fd, dmabuf_fd, num_planes * sizeof(*dmabuf_fd));
>      dmabuf->allow_fences =3D allow_fences;
>      dmabuf->y0_top =3D y0_top;
>      dmabuf->fence_fd =3D -1;
> +    dmabuf->num_planes =3D num_planes;
>
>      return dmabuf;
>  }
> @@ -65,31 +72,35 @@ void qemu_dmabuf_free(QemuDmaBuf *dmabuf)
>      g_free(dmabuf);
>  }
>
> -int qemu_dmabuf_get_fd(QemuDmaBuf *dmabuf)
> +const int *qemu_dmabuf_get_fd(QemuDmaBuf *dmabuf)
>  {
>      assert(dmabuf !=3D NULL);
>
>      return dmabuf->fd;
>  }
>
> -int qemu_dmabuf_dup_fd(QemuDmaBuf *dmabuf)
> +void qemu_dmabuf_dup_fd(QemuDmaBuf *dmabuf, int *fd)
>  {
> +    int i;
> +
>      assert(dmabuf !=3D NULL);
>
> -    if (dmabuf->fd >=3D 0) {
> -        return dup(dmabuf->fd);
> -    } else {
> -        return -1;
> +    for (i =3D 0; i < dmabuf->num_planes; i++) {
> +        fd[i] =3D dmabuf->fd[i] >=3D 0 ? dup(dmabuf->fd[i]) : -1;
>      }
>  }
>
>  void qemu_dmabuf_close(QemuDmaBuf *dmabuf)
>  {
> +    int i;
> +
>      assert(dmabuf !=3D NULL);
>
> -    if (dmabuf->fd >=3D 0) {
> -        close(dmabuf->fd);
> -        dmabuf->fd =3D -1;
> +    for (i =3D 0; i < dmabuf->num_planes; i++) {
> +        if (dmabuf->fd[i] >=3D 0) {
> +            close(dmabuf->fd[i]);
> +            dmabuf->fd[i] =3D -1;
> +        }
>      }
>  }
>
> @@ -107,13 +118,27 @@ uint32_t qemu_dmabuf_get_height(QemuDmaBuf *dmabuf)
>      return dmabuf->height;
>  }
>
> -uint32_t qemu_dmabuf_get_stride(QemuDmaBuf *dmabuf)
> +const uint32_t *qemu_dmabuf_get_offset(QemuDmaBuf *dmabuf)
> +{
> +    assert(dmabuf !=3D NULL);
> +
> +    return dmabuf->offset;
> +}
> +
> +const uint32_t *qemu_dmabuf_get_stride(QemuDmaBuf *dmabuf)
>  {
>      assert(dmabuf !=3D NULL);
>
>      return dmabuf->stride;
>  }
>
> +uint32_t qemu_dmabuf_get_num_planes(QemuDmaBuf *dmabuf)
> +{
> +    assert(dmabuf !=3D NULL);
> +
> +    return dmabuf->num_planes;
> +}
> +
>  uint32_t qemu_dmabuf_get_fourcc(QemuDmaBuf *dmabuf)
>  {
>      assert(dmabuf !=3D NULL);
> @@ -221,9 +246,3 @@ void qemu_dmabuf_set_draw_submitted(QemuDmaBuf *dmabu=
f, bool draw_submitted)
>      assert(dmabuf !=3D NULL);
>      dmabuf->draw_submitted =3D draw_submitted;
>  }
> -
> -void qemu_dmabuf_set_fd(QemuDmaBuf *dmabuf, int32_t fd)
> -{
> -    assert(dmabuf !=3D NULL);
> -    dmabuf->fd =3D fd;
> -}
> diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
> index d591159480..72a1405782 100644
> --- a/ui/egl-helpers.c
> +++ b/ui/egl-helpers.c
> @@ -323,9 +323,9 @@ void egl_dmabuf_import_texture(QemuDmaBuf *dmabuf)
>      attrs[i++] =3D qemu_dmabuf_get_fourcc(dmabuf);
>
>      attrs[i++] =3D EGL_DMA_BUF_PLANE0_FD_EXT;
> -    attrs[i++] =3D qemu_dmabuf_get_fd(dmabuf);
> +    attrs[i++] =3D qemu_dmabuf_get_fd(dmabuf)[0];
>      attrs[i++] =3D EGL_DMA_BUF_PLANE0_PITCH_EXT;
> -    attrs[i++] =3D qemu_dmabuf_get_stride(dmabuf);
> +    attrs[i++] =3D qemu_dmabuf_get_stride(dmabuf)[0];
>      attrs[i++] =3D EGL_DMA_BUF_PLANE0_OFFSET_EXT;
>      attrs[i++] =3D 0;
>  #ifdef EGL_DMA_BUF_PLANE0_MODIFIER_LO_EXT
> diff --git a/ui/spice-display.c b/ui/spice-display.c
> index c794ae0649..82598fe9e8 100644
> --- a/ui/spice-display.c
> +++ b/ui/spice-display.c
> @@ -1075,10 +1075,10 @@ static void qemu_spice_gl_update(DisplayChangeLis=
tener *dcl,
>                                       stride, fourcc, false);
>              }
>          } else {
> -            stride =3D qemu_dmabuf_get_stride(dmabuf);
> +            stride =3D qemu_dmabuf_get_stride(dmabuf)[0];
>              fourcc =3D qemu_dmabuf_get_fourcc(dmabuf);
>              y_0_top =3D qemu_dmabuf_get_y0_top(dmabuf);
> -            fd =3D qemu_dmabuf_dup_fd(dmabuf);
> +            qemu_dmabuf_dup_fd(dmabuf, &fd);
>
>              trace_qemu_spice_gl_forward_dmabuf(ssd->qxl.id, width, heigh=
t);
>              /* note: spice server will close the fd, so hand over a dup =
*/
> --
> 2.43.0
>


