Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2608C47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 09:07:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnaqk-0005zb-7b; Fri, 22 Mar 2024 05:06:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rnaqj-0005zM-19
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 05:06:05 -0400
Received: from mail-qk1-x72b.google.com ([2607:f8b0:4864:20::72b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rnaqg-00032P-PG
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 05:06:04 -0400
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-78a06e38527so131754585a.2
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 02:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711098361; x=1711703161; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lfuw8aehbErLcbZDWQAcA7Ny8GXzd/Gxk3vUhvUcf2Y=;
 b=mdmcrVC5IwDPc877eCE7ouI0rSgDlhmxtyG9gt+w5VftDbou02gJZtlU0iJPhzVEBu
 WXMANDAsnCDGQKbZEmVV/9jignP0zdJslNh7xzueRdrvy/lxqBvjerriV6GT9SYKshjx
 5FqEcDZ3lOsQ3O/IlpqqPmv6fGBzswtGubsh/ugypruk/UWaOyHupfZfLHDtcsm17ebm
 Ymw4cPyLNLaC1iUWQNH6CVdc8xSx7n8G4E5VZKlAPUdxXuBa0s8p0yNvG8HhYBjFc4+M
 /ieT7xA2yyye3uls2ranpjtxNkQnUdolQKNZXqmw+eUWsE5PVCpDuak80Yg9XHDgseA8
 TLhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711098361; x=1711703161;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lfuw8aehbErLcbZDWQAcA7Ny8GXzd/Gxk3vUhvUcf2Y=;
 b=xDCwIfMNew93+OuxRygrDGC38Zp2RvPtUoUMxgqXbpCnxiM/m/x2JRbrJqC75qzZlM
 p9K8AmT9ZHY4+DN2SuGxZjsj4ASxcHxJUk1/n8aGdQnF6+GfPOlGA2FsDfokY6isz1FJ
 3cPkSpd6FKk8o5Cdk9mmXAaDwT33vC/1ng+9fDCqfxZPXNTeBfHeiUCPDJ/QCEaJ2CkY
 kM+VtCJS3aMLnbWxNvydFr+gRTsJAlH1E17dcGTyU0Uk3CfosZr/B7019cptGIlYZjHl
 0l7TTvhjZIYZikT1uz8D92VCEPjXzt8dFVBm/i9WnnNGnicwsOj7fSJ3dGsZo3sxVcbY
 VVUQ==
X-Gm-Message-State: AOJu0YzJrx8rhDH5pVCMIklnYbtKc4l9MP7AJ9VbwSqFqV/W0ZNpuzcp
 dcbMal8tZwqTB3JFCdcSGFAQmmCVihjwqpGPtUfdqZPhhBFh+BVoy6sTxNq4rlfj6M3aBGWiJRh
 tuIAKJbeQUIr6tLLObZOW9s/mJdY=
X-Google-Smtp-Source: AGHT+IE1BcSrWx8PyWKIRaYHOVSbreqkaP59uSS0aPHZWkvKFyTacYeISWA4Vl4NJfcbREMUKTfaN6pfAQEGk7t460k=
X-Received: by 2002:a05:622a:4b18:b0:431:3034:e626 with SMTP id
 et24-20020a05622a4b1800b004313034e626mr1180173qtb.10.1711098361327; Fri, 22
 Mar 2024 02:06:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240321234236.3476163-1-dongwon.kim@intel.com>
 <20240321234236.3476163-4-dongwon.kim@intel.com>
In-Reply-To: <20240321234236.3476163-4-dongwon.kim@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 22 Mar 2024 13:05:49 +0400
Message-ID: <CAJ+F1CK0uaTxEG87wkRi7OoN3-RH1wMuwCpMD7hdobWhcp_MMw@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] ui/console: Introduce dpy_gl_create_dmabuf() helper
To: dongwon.kim@intel.com
Cc: qemu-devel@nongnu.org, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::72b;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qk1-x72b.google.com
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

On Fri, Mar 22, 2024 at 3:45=E2=80=AFAM <dongwon.kim@intel.com> wrote:
>
> From: Dongwon Kim <dongwon.kim@intel.com>
>
> dpy_gl_create_dmabuf() allocates QemuDmaBuf and initialize fields.
> hw/display modules, hw/vfio and ui/dbus-listener now use this method
> to create QemuDmaBuf instead of declaring and initializing it on their
> own.
>
> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
> Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
> ---
>  include/hw/vfio/vfio-common.h   |  2 +-
>  include/hw/virtio/virtio-gpu.h  |  4 ++--
>  include/ui/console.h            |  6 ++++++
>  hw/display/vhost-user-gpu.c     | 33 ++++++++++++++++++---------------
>  hw/display/virtio-gpu-udmabuf.c | 23 ++++++++---------------
>  hw/vfio/display.c               | 26 +++++++++++---------------
>  ui/console.c                    | 28 ++++++++++++++++++++++++++++
>  ui/dbus-listener.c              | 28 ++++++++++++----------------
>  8 files changed, 86 insertions(+), 64 deletions(-)
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
> index d5334a806c..01e998264b 100644
> --- a/include/ui/console.h
> +++ b/include/ui/console.h
> @@ -358,6 +358,12 @@ void dpy_gl_cursor_dmabuf(QemuConsole *con, QemuDmaB=
uf *dmabuf,
>                            bool have_hot, uint32_t hot_x, uint32_t hot_y)=
;
>  void dpy_gl_cursor_position(QemuConsole *con,
>                              uint32_t pos_x, uint32_t pos_y);
> +QemuDmaBuf *dpy_gl_create_dmabuf(uint32_t width, uint32_t height,
> +                                 uint32_t stride, uint32_t x,
> +                                 uint32_t y, uint32_t backing_width,
> +                                 uint32_t backing_height, uint32_t fourc=
c,
> +                                 uint64_t modifier, uint32_t dmabuf_fd,
> +                                 bool allow_fences, bool y0_top);
>  uint32_t dpy_gl_dmabuf_get_width(QemuDmaBuf *dmabuf);
>  uint32_t dpy_gl_dmabuf_get_height(QemuDmaBuf *dmabuf);
>  int32_t dpy_gl_dmabuf_get_fd(QemuDmaBuf *dmabuf);
> diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
> index 709c8a02a1..0e49a934ed 100644
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
> @@ -261,30 +262,32 @@ vhost_user_gpu_handle_display(VhostUserGPU *g, Vhos=
tUserGpuMsg *msg)
>
>          g->parent_obj.enable =3D 1;
>          con =3D g->parent_obj.scanout[m->scanout_id].con;
> -        dmabuf =3D &g->dmabuf[m->scanout_id];
> -        if (dmabuf->fd >=3D 0) {
> -            close(dmabuf->fd);
> -            dmabuf->fd =3D -1;
> +        dmabuf =3D g->dmabuf[m->scanout_id];
> +        if (dmabuf) {
> +            int dmabuf_fd =3D dpy_gl_dmabuf_get_fd(dmabuf);
> +            if (dmabuf_fd >=3D 0) {
> +                close(dmabuf_fd);
> +            }
> +            dpy_gl_release_dmabuf(con, dmabuf);
>          }
> -        dpy_gl_release_dmabuf(con, dmabuf);
> +
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
> -        dpy_gl_scanout_dmabuf(con, dmabuf);
> +        dmabuf =3D dpy_gl_create_dmabuf(m->fd_width, m->fd_height, m->fd=
_stride,
> +                                      0, 0, 0, 0, m->fd_drm_fourcc, modi=
fier,
> +                                      fd, false, m->fd_flags &
> +                                      VIRTIO_GPU_RESOURCE_FLAG_Y_0_TOP);
> +
> +        dpy_gl_scanout_dmabuf(con, g->dmabuf[m->scanout_id]);
> +        g->dmabuf[m->scanout_id] =3D dmabuf;
>          break;
>      }
>      case VHOST_USER_GPU_DMABUF_UPDATE: {
> diff --git a/hw/display/virtio-gpu-udmabuf.c b/hw/display/virtio-gpu-udma=
buf.c
> index a4ebf828ec..2bc8697d86 100644
> --- a/hw/display/virtio-gpu-udmabuf.c
> +++ b/hw/display/virtio-gpu-udmabuf.c
> @@ -162,7 +162,7 @@ static void virtio_gpu_free_dmabuf(VirtIOGPU *g, VGPU=
DMABuf *dmabuf)
>      struct virtio_gpu_scanout *scanout;
>
>      scanout =3D &g->parent_obj.scanout[dmabuf->scanout_id];
> -    dpy_gl_release_dmabuf(scanout->con, &dmabuf->buf);
> +    dpy_gl_release_dmabuf(scanout->con, dmabuf->buf);
>      QTAILQ_REMOVE(&g->dmabuf.bufs, dmabuf, next);
>      g_free(dmabuf);
>  }
> @@ -181,17 +181,10 @@ static VGPUDMABuf
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
> +    dmabuf->buf =3D dpy_gl_create_dmabuf(r->width, r->height, fb->stride=
,
> +                                       r->x, r->y, fb->width, fb->height=
,
> +                                       qemu_pixman_to_drm_format(fb->for=
mat),
> +                                       0, res->dmabuf_fd, false, 0);
>      dmabuf->scanout_id =3D scanout_id;
>      QTAILQ_INSERT_HEAD(&g->dmabuf.bufs, dmabuf, next);
>
> @@ -217,11 +210,11 @@ int virtio_gpu_update_dmabuf(VirtIOGPU *g,
>          old_primary =3D g->dmabuf.primary[scanout_id];
>      }
>
> -    width =3D dpy_gl_dmabuf_get_width(&new_primary->buf);
> -    height =3D dpy_gl_dmabuf_get_height(&new_primary->buf);
> +    width =3D dpy_gl_dmabuf_get_width(new_primary->buf);
> +    height =3D dpy_gl_dmabuf_get_height(new_primary->buf);
>      g->dmabuf.primary[scanout_id] =3D new_primary;
>      qemu_console_resize(scanout->con, width, height);
> -    dpy_gl_scanout_dmabuf(scanout->con, &new_primary->buf);
> +    dpy_gl_scanout_dmabuf(scanout->con, new_primary->buf);
>
>      if (old_primary) {
>          virtio_gpu_free_dmabuf(g, old_primary);
> diff --git a/hw/vfio/display.c b/hw/vfio/display.c
> index 676b2fc5f3..62f5db2d54 100644
> --- a/hw/vfio/display.c
> +++ b/hw/vfio/display.c
> @@ -240,15 +240,11 @@ static VFIODMABuf *vfio_display_get_dmabuf(VFIOPCID=
evice *vdev,
>      }
>
>      dmabuf =3D g_new0(VFIODMABuf, 1);
> -    dmabuf->dmabuf_id  =3D plane.dmabuf_id;
> -    dmabuf->buf.width  =3D plane.width;
> -    dmabuf->buf.height =3D plane.height;
> -    dmabuf->buf.backing_width =3D plane.width;
> -    dmabuf->buf.backing_height =3D plane.height;
> -    dmabuf->buf.stride =3D plane.stride;
> -    dmabuf->buf.fourcc =3D plane.drm_format;
> -    dmabuf->buf.modifier =3D plane.drm_format_mod;
> -    dmabuf->buf.fd     =3D fd;
> +    dmabuf->dmabuf_id =3D plane.dmabuf_id;
> +    dmabuf->buf =3D dpy_gl_create_dmabuf(plane.width, plane.height, plan=
e.stride,
> +                                       0, 0, plane.width, plane.height,
> +                                       plane.drm_format, plane.drm_forma=
t_mod,
> +                                       fd, false, 0);
>      if (plane_type =3D=3D DRM_PLANE_TYPE_CURSOR) {
>          vfio_display_update_cursor(dmabuf, &plane);
>      }
> @@ -262,12 +258,12 @@ static void vfio_display_free_one_dmabuf(VFIODispla=
y *dpy, VFIODMABuf *dmabuf)
>      int fd;
>
>      QTAILQ_REMOVE(&dpy->dmabuf.bufs, dmabuf, next);
> -    fd =3D dpy_gl_dmabuf_get_fd(&dmabuf->buf);
> +    fd =3D dpy_gl_dmabuf_get_fd(dmabuf->buf);
>      if (fd > -1) {
>          close(fd);
>      }
>
> -    dpy_gl_release_dmabuf(dpy->con, &dmabuf->buf);
> +    dpy_gl_release_dmabuf(dpy->con, dmabuf->buf);
>      g_free(dmabuf);
>  }
>
> @@ -303,13 +299,13 @@ static void vfio_display_dmabuf_update(void *opaque=
)
>          return;
>      }
>
> -    width =3D dpy_gl_dmabuf_get_width(&primary->buf);
> -    height =3D dpy_gl_dmabuf_get_height(&primary->buf);
> +    width =3D dpy_gl_dmabuf_get_width(primary->buf);
> +    height =3D dpy_gl_dmabuf_get_height(primary->buf);
>
>      if (dpy->dmabuf.primary !=3D primary) {
>          dpy->dmabuf.primary =3D primary;
>          qemu_console_resize(dpy->con, width, height);
> -        dpy_gl_scanout_dmabuf(dpy->con, &primary->buf);
> +        dpy_gl_scanout_dmabuf(dpy->con, primary->buf);
>          free_bufs =3D true;
>      }
>
> @@ -323,7 +319,7 @@ static void vfio_display_dmabuf_update(void *opaque)
>      if (cursor && (new_cursor || cursor->hot_updates)) {
>          bool have_hot =3D (cursor->hot_x !=3D 0xffffffff &&
>                           cursor->hot_y !=3D 0xffffffff);
> -        dpy_gl_cursor_dmabuf(dpy->con, &cursor->buf, have_hot,
> +        dpy_gl_cursor_dmabuf(dpy->con, cursor->buf, have_hot,
>                               cursor->hot_x, cursor->hot_y);
>          cursor->hot_updates =3D 0;
>      } else if (!cursor && new_cursor) {
> diff --git a/ui/console.c b/ui/console.c
> index 69560aac7e..f3920e7713 100644
> --- a/ui/console.c
> +++ b/ui/console.c
> @@ -1132,6 +1132,33 @@ void dpy_gl_cursor_position(QemuConsole *con,
>      }
>  }
>
> +QemuDmaBuf *dpy_gl_create_dmabuf(uint32_t width, uint32_t height,
> +                                 uint32_t stride, uint32_t x,
> +                                 uint32_t y, uint32_t backing_width,
> +                                 uint32_t backing_height, uint32_t fourc=
c,
> +                                 uint64_t modifier, uint32_t dmabuf_fd,
> +                                 bool allow_fences, bool y0_top) {

We usually follow glib conventions, name the function according to the
type allocated, and add a "_new" suffix: qemu_dma_buf_new()

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
> +
>  uint32_t dpy_gl_dmabuf_get_width(QemuDmaBuf *dmabuf)
>  {
>      if (dmabuf) {
> @@ -1164,6 +1191,7 @@ void dpy_gl_release_dmabuf(QemuConsole *con,
>              dcl->ops->dpy_gl_release_dmabuf(dcl, dmabuf);
>          }
>      }
> +    g_free(dmabuf);

This is not a good place to free dmabuf, since it's a place to notify
console listeners. I suggest introducing another function,
qemu_dma_buf_free(). And to use it through g_clear_pointer(&buf,
qemu_dma_buf_free), to avoid dangling pointers later.

>  }
>
>  void dpy_gl_update(QemuConsole *con,
> diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
> index 4a0a5d78f9..a2145704cc 100644
> --- a/ui/dbus-listener.c
> +++ b/ui/dbus-listener.c
> @@ -438,28 +438,24 @@ static void dbus_scanout_texture(DisplayChangeListe=
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
> +    dmabuf =3D dpy_gl_create_dmabuf(w, h, stride, x, y, backing_width,
> +                                  backing_height, fourcc, modifier, fd,
> +                                  false, backing_y_0_top);
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
>


--=20
Marc-Andr=C3=A9 Lureau

