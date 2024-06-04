Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2245C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 14:40:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEVJw-0001iu-49; Tue, 04 Jun 2024 10:39:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sEVJu-0001iU-2O
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 10:39:26 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sEVJr-0007V9-BW
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 10:39:25 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-62c5fd61d2bso55862847b3.3
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 07:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717511962; x=1718116762; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tDK99Rs06cPg+pTIZVKTN0SiCYfDY/wstuouRW0DCnI=;
 b=KsdAQGzTzw7x9szrsv8Ul9fvMCk3RHPSNt8/GO2I2rEenVyROS9yCTcfWvH9QWHpaq
 SSsdn6h/VAXTuoD12dX+Vo+9fHb4LKReVSXEyyGEAOgcC7X1QWHUvQwhwaoqpKtK4HAO
 vjYFFsePfUfGNY5XuMNSJbmxycC52cStw7MYXmOLm+gSHqVSx8/iI12XoVkJHKGlxKeK
 viKChlP02plMqD7BYBqI5wN+GFrL8r9guHLCSe7YQ9k/OoQDIyGsGrPva1snsw+tmpJ+
 sPN/tN6I+VOpKVywF8KJZ8x/MPvo7MLVtU0GfX2s8e8hNeHVFhUWKG22vUEtKH8OLFXm
 kroA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717511962; x=1718116762;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tDK99Rs06cPg+pTIZVKTN0SiCYfDY/wstuouRW0DCnI=;
 b=sVnNYUEh38YoNjRmNvX5Q5XkdHD1Gdxnp0RJ1wNzxvW4CV0g+cTeU7iMXhxW7kGtla
 kXXQpG8JFEYOmSxHE97/EJIRqnfWD/H1F+Nwj9JZGZzOgLAp0wgW8fN7FX3OF8YEYoqY
 4XwYRAbneuwX1br0Xcia9ufkertf0MPgTpQFLdSDXZ95RiVsDXEplZ1USiCKxeWGgaNr
 3hGN4KC/Y9Fa5CUGqLW6UkZkxIv2k92iZNspXPQ/CHzbi9m7Y4UsiChRq8/kD4ZQAVAC
 iDflAHqyskKvt3oJ8PQbXf32FJc/5LzuotHfL1qGZuUPCUv1vwuVJlgYhT7UYFRfyD9Y
 Sl2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRc9ny8eteeHgr+WmCXgQIUog6IrQt0mf3nbGhWcte0sBklv3pupV3qoJ3vCusUtEBiAa4LbbR4TbUt4bif7E8njx++4w=
X-Gm-Message-State: AOJu0YwIT5Ts35IQjxOxYJo3r6M6c4EEum1unVamRAHHY/cF1i+1Oe3j
 QgJ6H8QTWC+gSX4acd8150qhjmxIUAv71vt5S4/lOVbxPV5a0cBSfPwV4+iRJ/TZFl7PoonD7Bf
 URxzZRHQ0FZ4Kuuo75rQCD4p059A=
X-Google-Smtp-Source: AGHT+IHgklUJPw9yGKU1ABwHgoUCLj3dsuAeBN036CYAp6XoMvbjhhQmuAgPUy/gTSR2QRkOC7jfRUN6dJwSOgVBWkI=
X-Received: by 2002:a0d:dc07:0:b0:61d:fd3e:abe5 with SMTP id
 00721157ae682-62c7984485cmr113166397b3.52.1717511960590; Tue, 04 Jun 2024
 07:39:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240527030233.3775514-1-dmitry.osipenko@collabora.com>
 <20240527030233.3775514-10-dmitry.osipenko@collabora.com>
In-Reply-To: <20240527030233.3775514-10-dmitry.osipenko@collabora.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 4 Jun 2024 18:39:07 +0400
Message-ID: <CAJ+F1CJVpYT+pbA80qYom-FXBgqfNvcA-VmU=8tY=pMYQnK0CA@mail.gmail.com>
Subject: Re: [PATCH v13 09/13] virtio-gpu: Support blob scanout using dmabuf fd
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
 Stefano Stabellini <sstabellini@kernel.org>,
 Antonio Caggiano <quic_acaggian@quicinc.com>, 
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Robert Beckett <bob.beckett@collabora.com>, 
 Gert Wollny <gert.wollny@collabora.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org, Gurchetan Singh <gurchetansingh@chromium.org>,
 ernunes@redhat.com, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>, 
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, 
 Julia Zhang <julia.zhang@amd.com>, Chen Jiqian <Jiqian.Chen@amd.com>, 
 Yiwei Zhang <zzyiwei@chromium.org>
Content-Type: multipart/alternative; boundary="0000000000004f051d061a116ae5"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-yw1-x1134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--0000000000004f051d061a116ae5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Mon, May 27, 2024 at 7:03=E2=80=AFAM Dmitry Osipenko <
dmitry.osipenko@collabora.com> wrote:

> From: Robert Beckett <bob.beckett@collabora.com>
>
> Support displaying blob resources by handling SET_SCANOUT_BLOB
> command.
>
> Signed-by: Antonio Caggiano <antonio.caggiano@collabora.com>
> Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> Reviewed-by: Antonio Caggiano <quic_acaggian@quicinc.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  hw/display/virtio-gpu-virgl.c  | 109 +++++++++++++++++++++++++++++++++
>  hw/display/virtio-gpu.c        |  12 ++--
>  include/hw/virtio/virtio-gpu.h |   7 +++
>  meson.build                    |   1 +
>  4 files changed, 123 insertions(+), 6 deletions(-)
>
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.=
c
> index 8392d0fde984..7f45b4fa5fd7 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -17,6 +17,8 @@
>  #include "trace.h"
>  #include "hw/virtio/virtio.h"
>  #include "hw/virtio/virtio-gpu.h"
> +#include "hw/virtio/virtio-gpu-bswap.h"
> +#include "hw/virtio/virtio-gpu-pixman.h"
>
>  #include "ui/egl-helpers.h"
>
> @@ -78,6 +80,7 @@ static void virgl_cmd_create_resource_2d(VirtIOGPU *g,
>      res->base.height =3D c2d.height;
>      res->base.format =3D c2d.format;
>      res->base.resource_id =3D c2d.resource_id;
> +    res->base.dmabuf_fd =3D -1;
>      QTAILQ_INSERT_HEAD(&g->reslist, &res->base, next);
>
>      args.handle =3D c2d.resource_id;
> @@ -125,6 +128,7 @@ static void virgl_cmd_create_resource_3d(VirtIOGPU *g=
,
>      res->base.height =3D c3d.height;
>      res->base.format =3D c3d.format;
>      res->base.resource_id =3D c3d.resource_id;
> +    res->base.dmabuf_fd =3D -1;
>      QTAILQ_INSERT_HEAD(&g->reslist, &res->base, next);
>
>      args.handle =3D c3d.resource_id;
> @@ -509,6 +513,106 @@ static void virgl_cmd_get_capset(VirtIOGPU *g,
>      g_free(resp);
>  }
>
> +#ifdef HAVE_VIRGL_RESOURCE_BLOB
> +static void virgl_cmd_set_scanout_blob(VirtIOGPU *g,
> +                                       struct virtio_gpu_ctrl_command
> *cmd)
> +{
> +    struct virtio_gpu_framebuffer fb =3D { 0 };
> +    struct virgl_renderer_resource_info info;
> +    struct virtio_gpu_virgl_resource *res;
> +    struct virtio_gpu_set_scanout_blob ss;
> +    uint64_t fbend;
> +
> +    VIRTIO_GPU_FILL_CMD(ss);
> +    virtio_gpu_scanout_blob_bswap(&ss);
> +    trace_virtio_gpu_cmd_set_scanout_blob(ss.scanout_id, ss.resource_id,
> +                                          ss.r.width, ss.r.height, ss.r.=
x,
> +                                          ss.r.y);
> +
> +    if (ss.scanout_id >=3D g->parent_obj.conf.max_outputs) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: illegal scanout id specified
> %d",
> +                      __func__, ss.scanout_id);
> +        cmd->error =3D VIRTIO_GPU_RESP_ERR_INVALID_SCANOUT_ID;
> +        return;
> +    }
> +
> +    if (ss.resource_id =3D=3D 0) {
> +        virtio_gpu_disable_scanout(g, ss.scanout_id);
> +        return;
> +    }
> +
> +    if (ss.width < 16 ||
> +        ss.height < 16 ||
> +        ss.r.x + ss.r.width > ss.width ||
> +        ss.r.y + ss.r.height > ss.height) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: illegal scanout %d bounds fo=
r"
> +                      " resource %d, rect (%d,%d)+%d,%d, fb %d %d\n",
> +                      __func__, ss.scanout_id, ss.resource_id,
> +                      ss.r.x, ss.r.y, ss.r.width, ss.r.height,
> +                      ss.width, ss.height);
> +        cmd->error =3D VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
> +        return;
> +    }
> +
> +    res =3D virtio_gpu_virgl_find_resource(g, ss.resource_id);
> +    if (!res) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource does not exist %d\n=
",
> +                      __func__, ss.resource_id);
> +        cmd->error =3D VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
> +        return;
> +    }
> +    if (virgl_renderer_resource_get_info(ss.resource_id, &info)) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource does not have info
> %d\n",
> +                      __func__, ss.resource_id);
> +        cmd->error =3D VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
> +        return;
> +    }
> +    if (res->base.dmabuf_fd < 0) {
> +        res->base.dmabuf_fd =3D info.fd;
> +    }
> +    if (res->base.dmabuf_fd < 0) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource not backed by dmabu=
f
> %d\n",
> +                      __func__, ss.resource_id);
> +        cmd->error =3D VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
> +        return;
> +    }
> +
> +    fb.format =3D virtio_gpu_get_pixman_format(ss.format);
> +    if (!fb.format) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: pixel format not supported
> %d\n",
> +                      __func__, ss.format);
> +        cmd->error =3D VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
> +        return;
> +    }
> +
> +    fb.bytes_pp =3D DIV_ROUND_UP(PIXMAN_FORMAT_BPP(fb.format), 8);
> +    fb.width =3D ss.width;
> +    fb.height =3D ss.height;
> +    fb.stride =3D ss.strides[0];
> +    fb.offset =3D ss.offsets[0] + ss.r.x * fb.bytes_pp + ss.r.y * fb.str=
ide;
> +
> +    fbend =3D fb.offset;
> +    fbend +=3D fb.stride * (ss.r.height - 1);
> +    fbend +=3D fb.bytes_pp * ss.r.width;
> +    if (fbend > res->base.blob_size) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: fb end out of range\n",
> +                      __func__);
> +        cmd->error =3D VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
> +        return;
> +    }
> +
> +    g->parent_obj.enable =3D 1;
> +    if (virtio_gpu_update_dmabuf(g, ss.scanout_id, &res->base, &fb,
> &ss.r)) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: failed to update dmabuf\n",
> +                      __func__);
> +        cmd->error =3D VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
> +        return;
> +    }
> +
> +    virtio_gpu_update_scanout(g, ss.scanout_id, &res->base, &fb, &ss.r);
> +}
> +#endif /* HAVE_VIRGL_RESOURCE_BLOB */
> +
>  void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
>                                        struct virtio_gpu_ctrl_command *cm=
d)
>  {
> @@ -575,6 +679,11 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
>      case VIRTIO_GPU_CMD_GET_EDID:
>          virtio_gpu_get_edid(g, cmd);
>          break;
> +#ifdef HAVE_VIRGL_RESOURCE_BLOB
> +    case VIRTIO_GPU_CMD_SET_SCANOUT_BLOB:
> +        virgl_cmd_set_scanout_blob(g, cmd);
> +        break;
> +#endif /* HAVE_VIRGL_RESOURCE_BLOB */
>      default:
>          cmd->error =3D VIRTIO_GPU_RESP_ERR_UNSPEC;
>          break;
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 672279e57f3f..f3d2def9a49f 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -380,7 +380,7 @@ static void virtio_gpu_resource_create_blob(VirtIOGPU
> *g,
>      QTAILQ_INSERT_HEAD(&g->reslist, res, next);
>  }
>
> -static void virtio_gpu_disable_scanout(VirtIOGPU *g, int scanout_id)
> +void virtio_gpu_disable_scanout(VirtIOGPU *g, int scanout_id)
>  {
>      struct virtio_gpu_scanout *scanout =3D
> &g->parent_obj.scanout[scanout_id];
>      struct virtio_gpu_simple_resource *res;
> @@ -597,11 +597,11 @@ static void virtio_unref_resource(pixman_image_t
> *image, void *data)
>      pixman_image_unref(data);
>  }
>
> -static void virtio_gpu_update_scanout(VirtIOGPU *g,
> -                                      uint32_t scanout_id,
> -                                      struct virtio_gpu_simple_resource
> *res,
> -                                      struct virtio_gpu_framebuffer *fb,
> -                                      struct virtio_gpu_rect *r)
> +void virtio_gpu_update_scanout(VirtIOGPU *g,
> +                               uint32_t scanout_id,
> +                               struct virtio_gpu_simple_resource *res,
> +                               struct virtio_gpu_framebuffer *fb,
> +                               struct virtio_gpu_rect *r)
>  {
>      struct virtio_gpu_simple_resource *ores;
>      struct virtio_gpu_scanout *scanout;
> diff --git a/include/hw/virtio/virtio-gpu.h
> b/include/hw/virtio/virtio-gpu.h
> index 2faeda6f6abe..0bfdfd91db46 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -338,6 +338,13 @@ int virtio_gpu_update_dmabuf(VirtIOGPU *g,
>                               struct virtio_gpu_framebuffer *fb,
>                               struct virtio_gpu_rect *r);
>
> +void virtio_gpu_update_scanout(VirtIOGPU *g,
> +                               uint32_t scanout_id,
> +                               struct virtio_gpu_simple_resource *res,
> +                               struct virtio_gpu_framebuffer *fb,
> +                               struct virtio_gpu_rect *r);
> +void virtio_gpu_disable_scanout(VirtIOGPU *g, int scanout_id);
> +
>  /* virtio-gpu-3d.c */
>  void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
>                                    struct virtio_gpu_ctrl_command *cmd);
> diff --git a/meson.build b/meson.build
> index 65fddfbbc3a7..e753da4c76c3 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -2311,6 +2311,7 @@ config_host_data.set('CONFIG_VNC_SASL', sasl.found(=
))
>  if virgl.version().version_compare('>=3D1.0.0')
>    config_host_data.set('HAVE_VIRGL_D3D_INFO_EXT', 1)
>    config_host_data.set('HAVE_VIRGL_CONTEXT_CREATE_WITH_FLAGS', 1)
> +  config_host_data.set('HAVE_VIRGL_RESOURCE_BLOB', 1)
>

Instead of accumulating various #define values, we could simply have
HAVE_VIRGL1 or something..

Alternatively,  virgl.version().version_compare('>=3D1.0.1') and use #if
VIRGL_MAJOR_VERSION >=3D 1 in the code.

(the VIRGL_CHECK_VERSION macro is borked, it needs a 1.0.2 release)

--=20
Marc-Andr=C3=A9 Lureau

--0000000000004f051d061a116ae5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, May 27, 2024 at 7:03=E2=80=
=AFAM Dmitry Osipenko &lt;<a href=3D"mailto:dmitry.osipenko@collabora.com">=
dmitry.osipenko@collabora.com</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">From: Robert Beckett &lt;<a href=3D"mailto:bob=
.beckett@collabora.com" target=3D"_blank">bob.beckett@collabora.com</a>&gt;=
<br>
<br>
Support displaying blob resources by handling SET_SCANOUT_BLOB<br>
command.<br>
<br>
Signed-by: Antonio Caggiano &lt;<a href=3D"mailto:antonio.caggiano@collabor=
a.com" target=3D"_blank">antonio.caggiano@collabora.com</a>&gt;<br>
Signed-off-by: Robert Beckett &lt;<a href=3D"mailto:bob.beckett@collabora.c=
om" target=3D"_blank">bob.beckett@collabora.com</a>&gt;<br>
Signed-off-by: Huang Rui &lt;<a href=3D"mailto:ray.huang@amd.com" target=3D=
"_blank">ray.huang@amd.com</a>&gt;<br>
Reviewed-by: Antonio Caggiano &lt;<a href=3D"mailto:quic_acaggian@quicinc.c=
om" target=3D"_blank">quic_acaggian@quicinc.com</a>&gt;<br>
Signed-off-by: Dmitry Osipenko &lt;<a href=3D"mailto:dmitry.osipenko@collab=
ora.com" target=3D"_blank">dmitry.osipenko@collabora.com</a>&gt;<br>
---<br>
=C2=A0hw/display/virtio-gpu-virgl.c=C2=A0 | 109 +++++++++++++++++++++++++++=
++++++<br>
=C2=A0hw/display/virtio-gpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 12 ++--<br=
>
=C2=A0include/hw/virtio/virtio-gpu.h |=C2=A0 =C2=A07 +++<br>
=C2=A0meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
=C2=A04 files changed, 123 insertions(+), 6 deletions(-)<br>
<br>
diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c<=
br>
index 8392d0fde984..7f45b4fa5fd7 100644<br>
--- a/hw/display/virtio-gpu-virgl.c<br>
+++ b/hw/display/virtio-gpu-virgl.c<br>
@@ -17,6 +17,8 @@<br>
=C2=A0#include &quot;trace.h&quot;<br>
=C2=A0#include &quot;hw/virtio/virtio.h&quot;<br>
=C2=A0#include &quot;hw/virtio/virtio-gpu.h&quot;<br>
+#include &quot;hw/virtio/virtio-gpu-bswap.h&quot;<br>
+#include &quot;hw/virtio/virtio-gpu-pixman.h&quot;<br>
<br>
=C2=A0#include &quot;ui/egl-helpers.h&quot;<br>
<br>
@@ -78,6 +80,7 @@ static void virgl_cmd_create_resource_2d(VirtIOGPU *g,<br=
>
=C2=A0 =C2=A0 =C2=A0res-&gt;base.height =3D c2d.height;<br>
=C2=A0 =C2=A0 =C2=A0res-&gt;base.format =3D c2d.format;<br>
=C2=A0 =C2=A0 =C2=A0res-&gt;base.resource_id =3D c2d.resource_id;<br>
+=C2=A0 =C2=A0 res-&gt;base.dmabuf_fd =3D -1;<br>
=C2=A0 =C2=A0 =C2=A0QTAILQ_INSERT_HEAD(&amp;g-&gt;reslist, &amp;res-&gt;bas=
e, next);<br>
<br>
=C2=A0 =C2=A0 =C2=A0args.handle =3D c2d.resource_id;<br>
@@ -125,6 +128,7 @@ static void virgl_cmd_create_resource_3d(VirtIOGPU *g,<=
br>
=C2=A0 =C2=A0 =C2=A0res-&gt;base.height =3D c3d.height;<br>
=C2=A0 =C2=A0 =C2=A0res-&gt;base.format =3D c3d.format;<br>
=C2=A0 =C2=A0 =C2=A0res-&gt;base.resource_id =3D c3d.resource_id;<br>
+=C2=A0 =C2=A0 res-&gt;base.dmabuf_fd =3D -1;<br>
=C2=A0 =C2=A0 =C2=A0QTAILQ_INSERT_HEAD(&amp;g-&gt;reslist, &amp;res-&gt;bas=
e, next);<br>
<br>
=C2=A0 =C2=A0 =C2=A0args.handle =3D c3d.resource_id;<br>
@@ -509,6 +513,106 @@ static void virgl_cmd_get_capset(VirtIOGPU *g,<br>
=C2=A0 =C2=A0 =C2=A0g_free(resp);<br>
=C2=A0}<br>
<br>
+#ifdef HAVE_VIRGL_RESOURCE_BLOB<br>
+static void virgl_cmd_set_scanout_blob(VirtIOGPU *g,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct vi=
rtio_gpu_ctrl_command *cmd)<br>
+{<br>
+=C2=A0 =C2=A0 struct virtio_gpu_framebuffer fb =3D { 0 };<br>
+=C2=A0 =C2=A0 struct virgl_renderer_resource_info info;<br>
+=C2=A0 =C2=A0 struct virtio_gpu_virgl_resource *res;<br>
+=C2=A0 =C2=A0 struct virtio_gpu_set_scanout_blob ss;<br>
+=C2=A0 =C2=A0 uint64_t fbend;<br>
+<br>
+=C2=A0 =C2=A0 VIRTIO_GPU_FILL_CMD(ss);<br>
+=C2=A0 =C2=A0 virtio_gpu_scanout_blob_bswap(&amp;ss);<br>
+=C2=A0 =C2=A0 trace_virtio_gpu_cmd_set_scanout_blob(ss.scanout_id, ss.reso=
urce_id,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s=
s.r.width, ss.r.height, ss.r.x,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s=
s.r.y);<br>
+<br>
+=C2=A0 =C2=A0 if (ss.scanout_id &gt;=3D g-&gt;parent_obj.conf.max_outputs)=
 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR, &quot;%s: illeg=
al scanout id specified %d&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 __func__, ss.scanout_id);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd-&gt;error =3D VIRTIO_GPU_RESP_ERR_INVALID_=
SCANOUT_ID;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (ss.resource_id =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_gpu_disable_scanout(g, ss.scanout_id);<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (ss.width &lt; 16 ||<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ss.height &lt; 16 ||<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ss.r.x + ss.r.width &gt; ss.width ||<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ss.r.y + ss.r.height &gt; ss.height) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR, &quot;%s: illeg=
al scanout %d bounds for&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &quot; resource %d, rect (%d,%d)+%d,%d, fb %d %d\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 __func__, ss.scanout_id, ss.resource_id,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 ss.r.x, ss.r.y, ss.r.width, ss.r.height,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 ss.width, ss.height);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd-&gt;error =3D VIRTIO_GPU_RESP_ERR_INVALID_=
PARAMETER;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 res =3D virtio_gpu_virgl_find_resource(g, ss.resource_id);<b=
r>
+=C2=A0 =C2=A0 if (!res) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR, &quot;%s: resou=
rce does not exist %d\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 __func__, ss.resource_id);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd-&gt;error =3D VIRTIO_GPU_RESP_ERR_INVALID_=
RESOURCE_ID;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if (virgl_renderer_resource_get_info(ss.resource_id, &amp;in=
fo)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR, &quot;%s: resou=
rce does not have info %d\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 __func__, ss.resource_id);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd-&gt;error =3D VIRTIO_GPU_RESP_ERR_INVALID_=
RESOURCE_ID;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if (res-&gt;base.dmabuf_fd &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 res-&gt;base.dmabuf_fd =3D info.fd;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if (res-&gt;base.dmabuf_fd &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR, &quot;%s: resou=
rce not backed by dmabuf %d\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 __func__, ss.resource_id);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd-&gt;error =3D VIRTIO_GPU_RESP_ERR_INVALID_=
RESOURCE_ID;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 fb.format =3D virtio_gpu_get_pixman_format(ss.format);<br>
+=C2=A0 =C2=A0 if (!fb.format) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR, &quot;%s: pixel=
 format not supported %d\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 __func__, ss.format);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd-&gt;error =3D VIRTIO_GPU_RESP_ERR_INVALID_=
PARAMETER;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 fb.bytes_pp =3D DIV_ROUND_UP(PIXMAN_FORMAT_BPP(fb.format), 8=
);<br>
+=C2=A0 =C2=A0 fb.width =3D ss.width;<br>
+=C2=A0 =C2=A0 fb.height =3D ss.height;<br>
+=C2=A0 =C2=A0 fb.stride =3D ss.strides[0];<br>
+=C2=A0 =C2=A0 fb.offset =3D ss.offsets[0] + ss.r.x * fb.bytes_pp + ss.r.y =
* fb.stride;<br>
+<br>
+=C2=A0 =C2=A0 fbend =3D fb.offset;<br>
+=C2=A0 =C2=A0 fbend +=3D fb.stride * (ss.r.height - 1);<br>
+=C2=A0 =C2=A0 fbend +=3D fb.bytes_pp * ss.r.width;<br>
+=C2=A0 =C2=A0 if (fbend &gt; res-&gt;base.blob_size) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR, &quot;%s: fb en=
d out of range\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 __func__);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd-&gt;error =3D VIRTIO_GPU_RESP_ERR_INVALID_=
PARAMETER;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 g-&gt;parent_obj.enable =3D 1;<br>
+=C2=A0 =C2=A0 if (virtio_gpu_update_dmabuf(g, ss.scanout_id, &amp;res-&gt;=
base, &amp;fb, &amp;ss.r)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR, &quot;%s: faile=
d to update dmabuf\n&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 __func__);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd-&gt;error =3D VIRTIO_GPU_RESP_ERR_INVALID_=
PARAMETER;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 virtio_gpu_update_scanout(g, ss.scanout_id, &amp;res-&gt;bas=
e, &amp;fb, &amp;ss.r);<br>
+}<br>
+#endif /* HAVE_VIRGL_RESOURCE_BLOB */<br>
+<br>
=C2=A0void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct vi=
rtio_gpu_ctrl_command *cmd)<br>
=C2=A0{<br>
@@ -575,6 +679,11 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,<br>
=C2=A0 =C2=A0 =C2=A0case VIRTIO_GPU_CMD_GET_EDID:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0virtio_gpu_get_edid(g, cmd);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
+#ifdef HAVE_VIRGL_RESOURCE_BLOB<br>
+=C2=A0 =C2=A0 case VIRTIO_GPU_CMD_SET_SCANOUT_BLOB:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 virgl_cmd_set_scanout_blob(g, cmd);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+#endif /* HAVE_VIRGL_RESOURCE_BLOB */<br>
=C2=A0 =C2=A0 =C2=A0default:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cmd-&gt;error =3D VIRTIO_GPU_RESP_ERR_UNS=
PEC;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c<br>
index 672279e57f3f..f3d2def9a49f 100644<br>
--- a/hw/display/virtio-gpu.c<br>
+++ b/hw/display/virtio-gpu.c<br>
@@ -380,7 +380,7 @@ static void virtio_gpu_resource_create_blob(VirtIOGPU *=
g,<br>
=C2=A0 =C2=A0 =C2=A0QTAILQ_INSERT_HEAD(&amp;g-&gt;reslist, res, next);<br>
=C2=A0}<br>
<br>
-static void virtio_gpu_disable_scanout(VirtIOGPU *g, int scanout_id)<br>
+void virtio_gpu_disable_scanout(VirtIOGPU *g, int scanout_id)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0struct virtio_gpu_scanout *scanout =3D &amp;g-&gt;paren=
t_obj.scanout[scanout_id];<br>
=C2=A0 =C2=A0 =C2=A0struct virtio_gpu_simple_resource *res;<br>
@@ -597,11 +597,11 @@ static void virtio_unref_resource(pixman_image_t *ima=
ge, void *data)<br>
=C2=A0 =C2=A0 =C2=A0pixman_image_unref(data);<br>
=C2=A0}<br>
<br>
-static void virtio_gpu_update_scanout(VirtIOGPU *g,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t scanou=
t_id,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_g=
pu_simple_resource *res,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_g=
pu_framebuffer *fb,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_g=
pu_rect *r)<br>
+void virtio_gpu_update_scanout(VirtIOGPU *g,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t scanout_id,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct virtio_gpu_simple_resource *re=
s,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct virtio_gpu_framebuffer *fb,<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct virtio_gpu_rect *r)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0struct virtio_gpu_simple_resource *ores;<br>
=C2=A0 =C2=A0 =C2=A0struct virtio_gpu_scanout *scanout;<br>
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.=
h<br>
index 2faeda6f6abe..0bfdfd91db46 100644<br>
--- a/include/hw/virtio/virtio-gpu.h<br>
+++ b/include/hw/virtio/virtio-gpu.h<br>
@@ -338,6 +338,13 @@ int virtio_gpu_update_dmabuf(VirtIOGPU *g,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_gpu_framebuffer *fb,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_gpu_rect *r);<br>
<br>
+void virtio_gpu_update_scanout(VirtIOGPU *g,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t scanout_id,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct virtio_gpu_simple_resource *re=
s,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct virtio_gpu_framebuffer *fb,<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct virtio_gpu_rect *r);<br>
+void virtio_gpu_disable_scanout(VirtIOGPU *g, int scanout_id);<br>
+<br>
=C2=A0/* virtio-gpu-3d.c */<br>
=C2=A0void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct virtio_gpu_ctrl_=
command *cmd);<br>
diff --git a/meson.build b/meson.build<br>
index 65fddfbbc3a7..e753da4c76c3 100644<br>
--- a/meson.build<br>
+++ b/meson.build<br>
@@ -2311,6 +2311,7 @@ config_host_data.set(&#39;CONFIG_VNC_SASL&#39;, sasl.=
found())<br>
=C2=A0if virgl.version().version_compare(&#39;&gt;=3D1.0.0&#39;)<br>
=C2=A0 =C2=A0config_host_data.set(&#39;HAVE_VIRGL_D3D_INFO_EXT&#39;, 1)<br>
=C2=A0 =C2=A0config_host_data.set(&#39;HAVE_VIRGL_CONTEXT_CREATE_WITH_FLAGS=
&#39;, 1)<br>
+=C2=A0 config_host_data.set(&#39;HAVE_VIRGL_RESOURCE_BLOB&#39;, 1)<br></bl=
ockquote><div><br></div><div>Instead of accumulating various #define values=
, we could simply have HAVE_VIRGL1 or something..</div><div><br></div>Alter=
natively,=C2=A0 virgl.version().version_compare(&#39;&gt;=3D1.0.1&#39;) and=
 use #if VIRGL_MAJOR_VERSION &gt;=3D 1 in the code.</div><div class=3D"gmai=
l_quote"><br clear=3D"all"></div><div>(the VIRGL_CHECK_VERSION macro is bor=
ked, it needs a 1.0.2 release)</div><br><div><span class=3D"gmail_signature=
_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=
=C3=A9 Lureau<br></div></div></div>

--0000000000004f051d061a116ae5--

