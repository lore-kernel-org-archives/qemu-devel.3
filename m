Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98460C25B74
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 06:49:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4b6U-0007nZ-5h; Wed, 08 May 2024 02:48:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1s4b6Q-0007mJ-SO
 for qemu-devel@nongnu.org; Wed, 08 May 2024 02:48:35 -0400
Received: from mail-qk1-x72d.google.com ([2607:f8b0:4864:20::72d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1s4b6O-00061F-Qa
 for qemu-devel@nongnu.org; Wed, 08 May 2024 02:48:34 -0400
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-78f05e56cb3so288407685a.1
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 23:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715150909; x=1715755709; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d3qUsKlfp2qSydu/vTdviz46SAYn0sd1Lt2n6QbCXXQ=;
 b=OSAcVKwprGcfSkmQXF0oQ8FfZ8rUVwWdpYRLPbBbV/7t4LJZVRiIKnMIS7bcBVnOJ1
 1sIn1a6BWnL2HYhdWOh56Bi6JxekKGSxr7J7qnoE9kNo58QobITCF4jkdgS3tt5Lp3GW
 T7rmWGZWId+mKWmQPcQem0GJlRxfrrYO2bykbN5LF1zkHUjbvM083aWIX0ZzkyG33tR2
 0LcrW/H4ABm+0k6daUxfLuXKdYVQVIDpponQTLq5OBU5QpgIprvD1kHt3ptQ3N22SHrm
 Ig2eWxKklONW9gCIOOjtM4yen9y0plccI+kEen2Lgun66I2AY5p5LEvSVkY6tUJwZqbF
 k9Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715150909; x=1715755709;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d3qUsKlfp2qSydu/vTdviz46SAYn0sd1Lt2n6QbCXXQ=;
 b=j/A/ubBk5dB11Z/gvTkIxeWZ6JFMQ9oJbJw1oD86uECrzcNplQ5b73GT7MUzE/4Hr3
 DYSZzR6EqGUf11ji0bXOa+W++P80Vuyo83Y1YMYuN4KXSaReR9zn37lUKhLNmfCyO25j
 5SxOWBoEOwtrrmWzBxbZt1d1V2PBENbTcSvCY11LeCek2GpFKWvcCrGRHDAN6IeSToYj
 qIrjUV/WBG769SojQJ68E1aLobkD06OAhsbe2xon9kDzmvAY5NeDgKfuhhamHmb2uX7O
 vdrQEzT99DB+EkZADxEBQSbh331SNe3TUpwWHCceXMgiXzc6FStHtvklA1HWVwTzeGXQ
 KAMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfuISAf/4wvmrTzeTJqqJtLZZtMV6eMRPq6hMwX9XZVBVilriNtSjzKMCCWVy98fW0SEVY7VjlSeF+HoL6F5Xa/4Qh/Gw=
X-Gm-Message-State: AOJu0YygaLFYuc31L574jJ1rVaHtIcQNL6j5M/yAOqKPgbQRTWne4At/
 6cNdT8IWuEKy9qUX7Lgzc4Xndfb2jXP4gQT1tf5OkRWQNqWDzyzsaFbJkeBhNi2ptgdp80U4yMc
 WiP0cLaq4d9T7msbmx69k43bIjT4=
X-Google-Smtp-Source: AGHT+IFUip7M/B2gHyiXE1W9DtPbW1VlEM5qpwi1d8dpPc3y2S6MhtqxdBhKfwehDjJtlFYy2G9oTyMAk7YGRR+lX3I=
X-Received: by 2002:ac8:5888:0:b0:43b:86d:744d with SMTP id
 d75a77b69052e-43dbf3c76e0mr22757251cf.9.1715150908971; Tue, 07 May 2024
 23:48:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240504202834.399780-1-dmitry.osipenko@collabora.com>
 <20240504202834.399780-7-dmitry.osipenko@collabora.com>
In-Reply-To: <20240504202834.399780-7-dmitry.osipenko@collabora.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 8 May 2024 10:48:16 +0400
Message-ID: <CAJ+F1CJOqzmnGhcj5hVbXq0a6HKeZcF113vuGYMUvsJciCrsfg@mail.gmail.com>
Subject: Re: [PATCH v10 06/10] virtio-gpu: Support blob scanout using dmabuf fd
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony.perard@citrix.com>, 
 Antonio Caggiano <quic_acaggian@quicinc.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, 
 Robert Beckett <bob.beckett@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org, 
 Gurchetan Singh <gurchetansingh@chromium.org>, ernunes@redhat.com, 
 Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>, 
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, 
 Julia Zhang <julia.zhang@amd.com>, Chen Jiqian <Jiqian.Chen@amd.com>, 
 Yiwei Zhang <zzyiwei@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::72d;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qk1-x72d.google.com
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

On Sun, May 5, 2024 at 12:29=E2=80=AFAM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
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

Acked-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  hw/display/virtio-gpu-virgl.c  | 109 +++++++++++++++++++++++++++++++++
>  hw/display/virtio-gpu.c        |  12 ++--
>  include/hw/virtio/virtio-gpu.h |   7 +++
>  meson.build                    |   1 +
>  4 files changed, 123 insertions(+), 6 deletions(-)
>
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.=
c
> index a040324f5024..2fedccb1fc8d 100644
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
> @@ -507,6 +511,106 @@ static void virgl_cmd_get_capset(VirtIOGPU *g,
>      g_free(resp);
>  }
>
> +#ifdef HAVE_VIRGL_RESOURCE_BLOB
> +static void virgl_cmd_set_scanout_blob(VirtIOGPU *g,
> +                                       struct virtio_gpu_ctrl_command *c=
md)
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
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: illegal scanout id specified=
 %d",
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
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource does not have info =
%d\n",
> +                      __func__, ss.resource_id);
> +        cmd->error =3D VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
> +        return;
> +    }
> +    if (res->base.dmabuf_fd < 0) {
> +        res->base.dmabuf_fd =3D info.fd;
> +    }
> +    if (res->base.dmabuf_fd < 0) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource not backed by dmabu=
f %d\n",
> +                      __func__, ss.resource_id);
> +        cmd->error =3D VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
> +        return;
> +    }
> +
> +    fb.format =3D virtio_gpu_get_pixman_format(ss.format);
> +    if (!fb.format) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: pixel format not supported %=
d\n",
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
> +    if (virtio_gpu_update_dmabuf(g, ss.scanout_id, &res->base, &fb, &ss.=
r)) {
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
> @@ -573,6 +677,11 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
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
> index dac272ecadb1..1e57a53d346c 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -380,7 +380,7 @@ static void virtio_gpu_resource_create_blob(VirtIOGPU=
 *g,
>      QTAILQ_INSERT_HEAD(&g->reslist, res, next);
>  }
>
> -static void virtio_gpu_disable_scanout(VirtIOGPU *g, int scanout_id)
> +void virtio_gpu_disable_scanout(VirtIOGPU *g, int scanout_id)
>  {
>      struct virtio_gpu_scanout *scanout =3D &g->parent_obj.scanout[scanou=
t_id];
>      struct virtio_gpu_simple_resource *res;
> @@ -597,11 +597,11 @@ static void virtio_unref_resource(pixman_image_t *i=
mage, void *data)
>      pixman_image_unref(data);
>  }
>
> -static void virtio_gpu_update_scanout(VirtIOGPU *g,
> -                                      uint32_t scanout_id,
> -                                      struct virtio_gpu_simple_resource =
*res,
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
> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gp=
u.h
> index b657187159d9..ba36497c477f 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -329,6 +329,13 @@ int virtio_gpu_update_dmabuf(VirtIOGPU *g,
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
> index 513cb2ea6d03..9a00e29a80cf 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -2289,6 +2289,7 @@ config_host_data.set('CONFIG_VNC_SASL', sasl.found(=
))
>  if virgl.version().version_compare('>=3D1.0.0')
>    config_host_data.set('HAVE_VIRGL_D3D_INFO_EXT', 1)
>    config_host_data.set('HAVE_VIRGL_CONTEXT_CREATE_WITH_FLAGS', 1)
> +  config_host_data.set('HAVE_VIRGL_RESOURCE_BLOB', 1)
>  endif
>  config_host_data.set('CONFIG_VIRTFS', have_virtfs)
>  config_host_data.set('CONFIG_VTE', vte.found())
> --
> 2.44.0
>


--=20
Marc-Andr=C3=A9 Lureau

