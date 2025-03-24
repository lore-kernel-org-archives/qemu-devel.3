Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3B77C36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 10:16:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tweqe-0001ey-65; Mon, 24 Mar 2025 06:16:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1tweqb-0001eW-D7
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 06:15:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1tweqY-0006Di-Co
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 06:15:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742811353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CfsIViENMp64D3d6+V1cpZuCx6WkBwj+zTv3BGFcQfw=;
 b=XFq65EgrkWb47FV3EgizkJKM9NPp6+lg08Jc0Bd6K+Z/KgeqvJZZf8sLVd3nEJHlKXmyfZ
 +nkHLe9L/3MV20Wgk9SCIIFWQhUO/V2QRuNu9zV6bjst71oWCCQydIUOOvD7LGXhxIUcKi
 3pJDdKkqj32q4sPh5t0IYjVFUszDTYk=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-AmZeZGo-MR6NWjXiFCYPoA-1; Mon, 24 Mar 2025 06:15:50 -0400
X-MC-Unique: AmZeZGo-MR6NWjXiFCYPoA-1
X-Mimecast-MFC-AGG-ID: AmZeZGo-MR6NWjXiFCYPoA_1742811350
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7c54e7922a1so941683585a.2
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 03:15:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742811350; x=1743416150;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CfsIViENMp64D3d6+V1cpZuCx6WkBwj+zTv3BGFcQfw=;
 b=FfQwixYF2VJF9OEYreHlHsXcsMuojzFKkbce5QMXo5EuThaDBdbaF7aT5h5OM7qOn0
 l1GtJ6UsS1u/t7A50ALKiAnNIcR32bwerwKDCTcwQQGzgIi9v/ehuNljJ2E0i4PYybB8
 7G0kPi5i7bbbFdO6QdQtwHqWvzY0v9BjR4OjVHJRwUhPXcHPbufauHL61XbT35mJ+Wsj
 T1O3xEta2SwhOKxoc33LYoUqcD1/eO3uCVqbynZSyZUPEFIX2zR+O4sionP7DSjnl+zd
 BU29L6/LtdjlDEOoXDVXMFmBqVn1LiQiF6VMuuqmEuj1u+UAxJvjM356T+bd+O4Xgv+6
 OgvA==
X-Gm-Message-State: AOJu0YzBLUcfOChyBiq/iXSV+P+f+INeGAGdzn330AhXbMkVh3Rj/aQn
 mQRYq6Du1SM+LsureImHq//IRPyOzCV7OmxYzTyt1QcRnxyNqACAPCXHM3nQu16wYgbHVK0/iyE
 jy9LkWYqxgp62LOs1cMj/c45jN4HWNSNdkCzafr/SZ764q3PEawAJGPUXjt/7kmhrDxLKLrGIfK
 oExzhavHKmuIGrTSUzHVKqt00XNq6QnTVeK53C5AHp
X-Gm-Gg: ASbGnctevXb8QspwhVxOhd9sjtphJajYxtXjqPKKftkg/HvxjTzEMz7RXUzWUWbs3WE
 Ubd2GXCyStR0a1d6iBk9iLp7SiJeGJQFTQHTI30c6h8wG/q0+sUuuPUQQO1JixAICnHBV0vg3cu
 7gMUi2JG/tdqK8jCyoRLvBfs9PQQeSUg==
X-Received: by 2002:a05:620a:2608:b0:7c5:3f38:9583 with SMTP id
 af79cd13be357-7c5ba1f10f0mr1929108985a.50.1742811349859; 
 Mon, 24 Mar 2025 03:15:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsV+6zJXqgWTjrMbMGN2y7INen/V7NkNLamM9Wjb1sJhbL/H7+C1741S8igG+U2vnX4isnTw8/6fI4vLeVgEI=
X-Received: by 2002:a05:620a:2608:b0:7c5:3f38:9583 with SMTP id
 af79cd13be357-7c5ba1f10f0mr1929105985a.50.1742811349460; Mon, 24 Mar 2025
 03:15:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250324081922.359369-1-yuq825@gmail.com>
 <20250324081922.359369-4-yuq825@gmail.com>
In-Reply-To: <20250324081922.359369-4-yuq825@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 24 Mar 2025 14:15:38 +0400
X-Gm-Features: AQ5f1JrWN3rJ5SS-izyNX-DDEr8qTt_Ab1N0jMtTIziVRKW3C9ZzQw7FUupQmys
Message-ID: <CAMxuvazFKkHAuhUSS_Uc5ZBo8Q83Rb3mLtfREq52f+AgyHmaxQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] ui/egl: use DRM_FORMAT_MOD_INVALID as default modifier
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

On Mon, Mar 24, 2025 at 12:19=E2=80=AFPM <yuq825@gmail.com> wrote:
>
> From: Qiang Yu <yuq825@gmail.com>
>
> 0 is used as DRM_FORMAT_MOD_LINEAR already.
>
> Signed-off-by: Qiang Yu <yuq825@gmail.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  hw/display/vhost-user-gpu.c     | 3 ++-
>  hw/display/virtio-gpu-udmabuf.c | 4 +++-
>  ui/egl-helpers.c                | 3 ++-
>  3 files changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
> index a7949c7078..a6a510db65 100644
> --- a/hw/display/vhost-user-gpu.c
> +++ b/hw/display/vhost-user-gpu.c
> @@ -18,6 +18,7 @@
>  #include "chardev/char-fe.h"
>  #include "qapi/error.h"
>  #include "migration/blocker.h"
> +#include "standard-headers/drm/drm_fourcc.h"
>
>  typedef enum VhostUserGpuRequest {
>      VHOST_USER_GPU_NONE =3D 0,
> @@ -251,7 +252,7 @@ vhost_user_gpu_handle_display(VhostUserGPU *g, VhostU=
serGpuMsg *msg)
>          int fd =3D qemu_chr_fe_get_msgfd(&g->vhost_chr);
>          uint32_t offset =3D 0;
>          uint32_t stride =3D m->fd_stride;
> -        uint64_t modifier =3D 0;
> +        uint64_t modifier =3D DRM_FORMAT_MOD_INVALID;
>          QemuDmaBuf *dmabuf;
>
>          if (m->scanout_id >=3D g->parent_obj.conf.max_outputs) {
> diff --git a/hw/display/virtio-gpu-udmabuf.c b/hw/display/virtio-gpu-udma=
buf.c
> index 34fbe05b7a..de6ce53f16 100644
> --- a/hw/display/virtio-gpu-udmabuf.c
> +++ b/hw/display/virtio-gpu-udmabuf.c
> @@ -25,6 +25,7 @@
>  #include <linux/memfd.h>
>  #include "qemu/memfd.h"
>  #include "standard-headers/linux/udmabuf.h"
> +#include "standard-headers/drm/drm_fourcc.h"
>
>  static void virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource =
*res)
>  {
> @@ -187,7 +188,8 @@ static VGPUDMABuf
>                                    &offset, &fb->stride,
>                                    r->x, r->y, fb->width, fb->height,
>                                    qemu_pixman_to_drm_format(fb->format),
> -                                  0, &res->dmabuf_fd, 1, true, false);
> +                                  DRM_FORMAT_MOD_INVALID, &res->dmabuf_f=
d,
> +                                  1, true, false);
>      dmabuf->scanout_id =3D scanout_id;
>      QTAILQ_INSERT_HEAD(&g->dmabuf.bufs, dmabuf, next);
>
> diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
> index 45b1b0b700..970286325f 100644
> --- a/ui/egl-helpers.c
> +++ b/ui/egl-helpers.c
> @@ -23,6 +23,7 @@
>  #include "system/system.h"
>  #include "qapi/error.h"
>  #include "trace.h"
> +#include "standard-headers/drm/drm_fourcc.h"
>
>  EGLDisplay *qemu_egl_display;
>  EGLConfig qemu_egl_config;
> @@ -333,7 +334,7 @@ void egl_dmabuf_import_texture(QemuDmaBuf *dmabuf)
>      attrs[i++] =3D qemu_dmabuf_get_stride(dmabuf)[0];
>      attrs[i++] =3D EGL_DMA_BUF_PLANE0_OFFSET_EXT;
>      attrs[i++] =3D 0;
> -    if (modifier) {
> +    if (modifier !=3D DRM_FORMAT_MOD_INVALID) {
>          attrs[i++] =3D EGL_DMA_BUF_PLANE0_MODIFIER_LO_EXT;
>          attrs[i++] =3D (modifier >>  0) & 0xffffffff;
>          attrs[i++] =3D EGL_DMA_BUF_PLANE0_MODIFIER_HI_EXT;
> --
> 2.43.0
>


