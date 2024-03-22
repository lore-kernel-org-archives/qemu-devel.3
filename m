Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5D82CD11BF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 09:07:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnaqs-00060K-Nk; Fri, 22 Mar 2024 05:06:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rnaqq-00060A-In
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 05:06:12 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rnaqo-00033y-TU
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 05:06:12 -0400
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3c36f882372so1169781b6e.2
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 02:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711098370; x=1711703170; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gcs+OOC7RqYfwUgHZVH954GIB09KrTRqw371HJ1bBTU=;
 b=CUcHixBavl6R0mqSzlvEaSIXTL2tGsGNyrWZccERBvAwOiewU3QGNJ++yya3TIgSOd
 9eqxJ+pLaEoDN8hR1OioKv0IyRmSTNuQn0cymwgHSPNssQjrlrBvtsI9k5WHPG34D9N4
 ssAnstKEOoHiOnPgfPsYD20GaduZCb8Uo0CRJm90qHZlQFZrnpGm1cBQYSXYlh2GhfeT
 M9kZKR137rx1iw+lhyfMtE87SZPJbJAxyQJJUwv4yISoG04RLdGjYUJ4PiVrhf/J4k96
 H0f/PPWsmJEjuMQ1eWPfP0qpDsqr/VE/ELymsaeCoiN3nicQ2A0gYxdomADZCMG1VD2z
 q2yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711098370; x=1711703170;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gcs+OOC7RqYfwUgHZVH954GIB09KrTRqw371HJ1bBTU=;
 b=WUpab7yh1fLHjZv8QPmqdjMJmNwqNa2IiUQiKotzZgL8ytim9uii1pJAgWlod2jLZu
 Vde32W4ZUS2kMI2rjKLz3AULD4NvAecJMcnoCMXkDT2ERIkUYjmMmHbX/U3pKbQ0bwFX
 Mv/0DZwH7ou7zEq4ZLNh4M3BGift0FuPYeMXt8alE9yTrXcRVgZa+BhvxEf8zoLJiBH/
 qmKEFc87TiIHyLmd/BEUEEBzhSW2Ya4tUKx5dpyeBb/Hi9hfKB3a3q0Bp+EOEQ2dWbqU
 n09lYZGPIeiiXUV7BCKWnZDGNAUCXp717Yi7c3cIyYjHV+9zy8axCJ36/uOkHgqAvtuS
 35vw==
X-Gm-Message-State: AOJu0YxwbvXYlpGW97JY143WPD8XV97xMHFSGdBX5oMgnppQgcB/J+JQ
 qrcAvPranmKTvT7bbQ4CXMibLgNOi9tRYv0rL8ZXf/Yc7S7cz42Cj4ofafpLHpSeGUWHnerWmXQ
 5SAt4c20UY5j2yKGGe45+ylW84HU=
X-Google-Smtp-Source: AGHT+IEUQ4VQarZGWsi8k3CymKSrDRc14EbkcOVf+9mnZBQPS+7MRkyfzWYnEXk0jFfybFKQp9j45XJSRHeBdbF6us0=
X-Received: by 2002:a05:6808:10d4:b0:3c2:60cb:5bb4 with SMTP id
 s20-20020a05680810d400b003c260cb5bb4mr2142230ois.6.1711098369619; Fri, 22 Mar
 2024 02:06:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240321234236.3476163-1-dongwon.kim@intel.com>
 <20240321234236.3476163-2-dongwon.kim@intel.com>
In-Reply-To: <20240321234236.3476163-2-dongwon.kim@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 22 Mar 2024 13:05:58 +0400
Message-ID: <CAJ+F1C+UJtiSpx09hq+RRO4GZ9UKuQrqDLAGn8hYayP8pyb5Lw@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] ui/console: Introduce
 dpy_gl_dmabuf_get_height/width() helpers
To: dongwon.kim@intel.com
Cc: qemu-devel@nongnu.org, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-oi1-x229.google.com
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

Hi Kim

On Fri, Mar 22, 2024 at 3:45=E2=80=AFAM <dongwon.kim@intel.com> wrote:
>
> From: Dongwon Kim <dongwon.kim@intel.com>
>
> dpy_gl_dmabuf_get_height() and dpy_gl_dmabuf_get_width() are helpers for
> retrieving width and height fields from QemuDmaBuf struct.
>

There are many places left where width/height fields are still
accessed directly.

If we want to make the whole structure private, we will probably need sette=
rs.

I don't see why the function should silently return 0 when given NULL.
Imho an assert(dmabuf !=3D NULL) is appropriate (or
g_return_val_if_fail).





> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
> Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
> ---
>  include/ui/console.h            |  2 ++
>  hw/display/virtio-gpu-udmabuf.c |  7 ++++---
>  hw/vfio/display.c               |  9 ++++++---
>  ui/console.c                    | 18 ++++++++++++++++++
>  4 files changed, 30 insertions(+), 6 deletions(-)
>
> diff --git a/include/ui/console.h b/include/ui/console.h
> index 0bc7a00ac0..6064487fc4 100644
> --- a/include/ui/console.h
> +++ b/include/ui/console.h
> @@ -358,6 +358,8 @@ void dpy_gl_cursor_dmabuf(QemuConsole *con, QemuDmaBu=
f *dmabuf,
>                            bool have_hot, uint32_t hot_x, uint32_t hot_y)=
;
>  void dpy_gl_cursor_position(QemuConsole *con,
>                              uint32_t pos_x, uint32_t pos_y);
> +uint32_t dpy_gl_dmabuf_get_width(QemuDmaBuf *dmabuf);
> +uint32_t dpy_gl_dmabuf_get_height(QemuDmaBuf *dmabuf);
>  void dpy_gl_release_dmabuf(QemuConsole *con,
>                             QemuDmaBuf *dmabuf);
>  void dpy_gl_update(QemuConsole *con,
> diff --git a/hw/display/virtio-gpu-udmabuf.c b/hw/display/virtio-gpu-udma=
buf.c
> index d51184d658..a4ebf828ec 100644
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
> +    width =3D dpy_gl_dmabuf_get_width(&new_primary->buf);
> +    height =3D dpy_gl_dmabuf_get_height(&new_primary->buf);
>      g->dmabuf.primary[scanout_id] =3D new_primary;
> -    qemu_console_resize(scanout->con,
> -                        new_primary->buf.width,
> -                        new_primary->buf.height);
> +    qemu_console_resize(scanout->con, width, height);
>      dpy_gl_scanout_dmabuf(scanout->con, &new_primary->buf);
>
>      if (old_primary) {
> diff --git a/hw/vfio/display.c b/hw/vfio/display.c
> index 1aa440c663..c962e5f88f 100644
> --- a/hw/vfio/display.c
> +++ b/hw/vfio/display.c
> @@ -286,6 +286,7 @@ static void vfio_display_dmabuf_update(void *opaque)
>      VFIOPCIDevice *vdev =3D opaque;
>      VFIODisplay *dpy =3D vdev->dpy;
>      VFIODMABuf *primary, *cursor;
> +    uint32_t width, height;
>      bool free_bufs =3D false, new_cursor =3D false;
>
>      primary =3D vfio_display_get_dmabuf(vdev, DRM_PLANE_TYPE_PRIMARY);
> @@ -296,10 +297,12 @@ static void vfio_display_dmabuf_update(void *opaque=
)
>          return;
>      }
>
> +    width =3D dpy_gl_dmabuf_get_width(&primary->buf);
> +    height =3D dpy_gl_dmabuf_get_height(&primary->buf);
> +
>      if (dpy->dmabuf.primary !=3D primary) {
>          dpy->dmabuf.primary =3D primary;
> -        qemu_console_resize(dpy->con,
> -                            primary->buf.width, primary->buf.height);
> +        qemu_console_resize(dpy->con, width, height);
>          dpy_gl_scanout_dmabuf(dpy->con, &primary->buf);
>          free_bufs =3D true;
>      }
> @@ -328,7 +331,7 @@ static void vfio_display_dmabuf_update(void *opaque)
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
> index 43226c5c14..1d0513a733 100644
> --- a/ui/console.c
> +++ b/ui/console.c
> @@ -1132,6 +1132,24 @@ void dpy_gl_cursor_position(QemuConsole *con,
>      }
>  }
>
> +uint32_t dpy_gl_dmabuf_get_width(QemuDmaBuf *dmabuf)
> +{
> +    if (dmabuf) {
> +        return dmabuf->width;
> +    }
> +
> +    return 0;
> +}
> +
> +uint32_t dpy_gl_dmabuf_get_height(QemuDmaBuf *dmabuf)
> +{
> +    if (dmabuf) {
> +        return dmabuf->height;
> +    }
> +
> +    return 0;
> +}
> +
>  void dpy_gl_release_dmabuf(QemuConsole *con,
>                            QemuDmaBuf *dmabuf)
>  {
> --
> 2.34.1
>
>


--
Marc-Andr=C3=A9 Lureau

