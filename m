Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12652CD4F57
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 10:58:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPI8D-0007MT-Kc; Tue, 19 May 2026 06:57:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wPI8C-0007Ll-8G
 for qemu-devel@nongnu.org; Tue, 19 May 2026 06:57:00 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wPI8A-0000oz-4m
 for qemu-devel@nongnu.org; Tue, 19 May 2026 06:56:59 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-44ce78ab5feso2858889f8f.0
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 03:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779188216; x=1779793016; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=taL1e/49K8Tp+n1wLKAFHSzShc90U/zNifJC1HnscxQ=;
 b=rGtpLNVrDQAJaLQl/hhnjd0d5kV2HutMb4Jg8alXWPKgcPvgtHhJp6KD4F4CwiNEEI
 fXFt+eE7ggVYQ1K5SGlFxrBt5v3K8cTwlW6yxntPJjmiQxDHHAzgRDYrErJL/DTyc8m1
 DfVeTiQ+2PYjY3helksng8R06ODDyy3XMwgiUoYeAxGT/Kls5xV8MQwIUK8Xsak3Rrue
 a31Cv0JE6FMmaIGYqM6wBA2ADFmocO+Q5zKcc6Bip/gRilqJy09YTKeB7z86l7bok4u3
 huIrCm+uOJ6VqCNqdLBWEmbaY85Wh6yBauFuVxlSUbQ+91LyDClu+vqZ88PO3OgBTxHE
 3nVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779188216; x=1779793016;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=taL1e/49K8Tp+n1wLKAFHSzShc90U/zNifJC1HnscxQ=;
 b=Y7AI6jcXK/Bnt/IywEzt9y6becwM2ywMNCaWtRZro35mtbWbpNFaCM3Q6c05/QbScz
 iRz2+ol0jfTJD7R6wslSEGO1lGlNtprsyx4coMIefg2vA+i+PrWXVpcB49FSQef5VBLw
 ObuYcipoyJn/D9Tj5C+gJ6IQnakFQEKjzNTMiX1dDIsrensuRa7XfyfVy4MpoRIxYWd4
 QCPshmBRv31nrXP9RI9RqtKaC5EdJRLEJWG1ldvQDuZkwjlGk9ZLpjf360JOYUnV1lnm
 h1Y1IAixP1xyD9S73U7vX8UUh5xhqNpIKMGy/yrORFTMmt/z5FmeEjwHMa2LIPUKGnfe
 aoRw==
X-Gm-Message-State: AOJu0Ywp5Tpd3M5yDZkEJ3x8l52P/eXiTMb4+tQ68ZlwncIuYHmvypNt
 HEwevyJdvniRbWnss5xDKDU6O+2tg4QHSuJFGn7Ptz4MyKLaGIldRwitk+8B3+3BuWc=
X-Gm-Gg: Acq92OEtfH+h6PE1LedrDODKU6L8MDhb1NvIR5/jiTSzFiOe1Ef7BWHcoyAZFuzjLVE
 /tSZs91VIPdiFYCkpXg5YfrLoncX1S16FIYqSgsitLJRSDKaYiFxLiX8ciJbf2ag8zJOo0YU02X
 xUta038ASOssyFmCsQ/TjW598IaX3XPldSbTpRoNVoaw8G5UZWP++88wqYPIfK4BCjXsbGRpXcs
 C9LG5rJwpWlEOf+KTbm/pdea5mMcXGYftUIQacooPMo51UprJrtxEvhxab6kLnIqAzwL72sGuFP
 HksachdywgdQmaOYq5xAo4YHMxRGaiiznS0QOqWs/i6xsxf89c2kicvH4SAPD5RxrGdmHVuQP8x
 VpBwnQNud+EnRwCGs8Nn6qGAbguMOoGr/IQdcdSHP2H4ivsc8GlGyRd9c1O7OGw8bGxcEzMhG2J
 Kfuww6ioAjKn/btHS4bY8voWI=
X-Received: by 2002:a05:6000:2f83:b0:43b:3d02:7806 with SMTP id
 ffacd0b85a97d-45e5c58ed80mr32026415f8f.28.1779188216307; 
 Tue, 19 May 2026 03:56:56 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9ec39ff1sm47887709f8f.10.2026.05.19.03.56.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 03:56:55 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4E10C5F81D;
 Tue, 19 May 2026 11:56:54 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Lucas Amaral <lucaaamaral@gmail.com>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,
 dmitry.osipenko@collabora.com,  marcandre.lureau@redhat.com,
 visitorckw@gmail.com
Subject: Re: [PATCH v5 3/4] virtio-gpu: decouple Venus from CONFIG_OPENGL
In-Reply-To: <20260317182049.33848-4-lucaaamaral@gmail.com> (Lucas Amaral's
 message of "Tue, 17 Mar 2026 15:20:48 -0300")
References: <20260317182049.33848-1-lucaaamaral@gmail.com>
 <20260317182049.33848-4-lucaaamaral@gmail.com>
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Tue, 19 May 2026 11:56:54 +0100
Message-ID: <87y0hfbrbd.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Lucas Amaral <lucaaamaral@gmail.com> writes:

> Venus (virtio-gpu Vulkan context) currently requires an OpenGL
> display backend due to build-time and runtime coupling.  On macOS,
> no OpenGL display backend exists.
>
> Remove the opengl.found() build requirement for the virtio-gpu-gl
> module; virglrenderer provides Venus independently of OpenGL.
>
> Gate GL-specific code paths behind CONFIG_OPENGL and display_opengl:
> - Only advertise VIRGL/VIRGL2 capsets when display_opengl is set
> - Only pass VIRGL_RENDERER_NO_VIRGL when !display_opengl with Venus
> - Null out GL context callbacks when no GL display is available
> - Route 2D display commands to the software renderer (pixman) when
>   Venus runs without GL (venus no-GL mode)
> - Allow Venus to bypass the OpenGL display check at device realize
>
> Signed-off-by: Lucas Amaral <lucaaamaral@gmail.com>
<snip>
> @@ -157,7 +158,18 @@ virtio_gpu_get_flags(void *opaque)
>      VirtIOGPUBase *g =3D opaque;
>      int flags =3D GRAPHIC_FLAGS_NONE;
>=20=20
> -    if (virtio_gpu_virgl_enabled(g->conf)) {
> +    if (virtio_gpu_venus_enabled(g->conf)) {
> +        /* TODO: set GRAPHIC_FLAGS_VK for direct Vulkan scanout */
> +    }
> +
> +    /*
> +     * TODO: virtio_gpu_virgl_enabled() checks VIRTIO_GPU_FLAG_VIRGL_ENA=
BLED
> +     * which is set for both OpenGL (VIRGL) and Vulkan (Venus) backends.
> +     * This condition should ideally use a dedicated OpenGL-only
> flag.

Isn't this entirely in QEMU's control? The Venus flag is checked when
needed and set by:

    DEFINE_PROP_BIT("venus", VirtIOGPU, parent_obj.conf.flags,
                    VIRTIO_GPU_FLAG_VENUS_ENABLED, false),

So do we just need to define:

    DEFINE_PROP_BIT("virgl", VirtIOGPU, parent_obj.conf.flags,
                    VIRTIO_GPU_FLAG_VIRGL_ENABLED, true),

and allow the user to squash it and drop the:

    g->parent_obj.conf.flags |=3D (1 << VIRTIO_GPU_FLAG_VIRGL_ENABLED);

I guess we need to drop the prop bit definition on platforms that can't
support OpenGL?

> For
> +     * now, display_opengl correctly gates GL scanout since Venus leaves=
 it
> +     * at 0.
> +     */
> +    if (virtio_gpu_virgl_enabled(g->conf) && display_opengl) {
>          flags |=3D GRAPHIC_FLAGS_GL;
>      }
>=20=20
> @@ -273,6 +285,7 @@ virtio_gpu_base_get_features(VirtIODevice *vdev, uint=
64_t features,
>      }
>      if (virtio_gpu_blob_enabled(g->conf)) {
>          features |=3D (1 << VIRTIO_GPU_F_RESOURCE_BLOB);
> +        features |=3D (1 << VIRTIO_GPU_F_BLOB_ALIGNMENT);
>      }
>      if (virtio_gpu_context_init_enabled(g->conf)) {
>          features |=3D (1 << VIRTIO_GPU_F_CONTEXT_INIT);
> diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
> index 2b7a41c4..1a95e6a7 100644
> --- a/hw/display/virtio-gpu-gl.c
> +++ b/hw/display/virtio-gpu-gl.c
> @@ -124,7 +124,9 @@ static void virtio_gpu_gl_device_realize(DeviceState =
*qdev, Error **errp)
>          return;
>      }
>=20=20
> -    if (!display_opengl) {
> +    if (virtio_gpu_venus_enabled(g->parent_obj.conf)) {
> +        /* Venus uses Vulkan in the render server, no GL needed */
> +    } else if (!display_opengl) {
>          error_setg(errp,
>                     "The display backend does not have OpenGL support ena=
bled");
>          error_append_hint(errp,
> @@ -245,4 +247,6 @@ static void virtio_register_types(void)
>  type_init(virtio_register_types)
>=20=20
>  module_dep("hw-display-virtio-gpu");
> +#ifdef CONFIG_OPENGL
>  module_dep("ui-opengl");
> +#endif
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index b7a2d160..2f9700e0 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -19,8 +19,10 @@
>  #include "hw/virtio/virtio-gpu.h"
>  #include "hw/virtio/virtio-gpu-bswap.h"
>  #include "hw/virtio/virtio-gpu-pixman.h"
> -
> +#include "system/system.h"
> +#ifdef CONFIG_OPENGL
>  #include "ui/egl-helpers.h"
> +#endif
>=20=20
>  #include <virglrenderer.h>
>=20=20
> @@ -50,6 +52,16 @@ struct virtio_gpu_virgl_resource {
>      void *map_fixed;
>  };
>=20=20
> +/*
> + * Venus no-GL mode: Venus is enabled but no OpenGL display is available.
> + * Display commands use software (pixman) rendering; Venus/3D commands
> + * go through the virglrenderer render server.
> + */
> +static bool virtio_gpu_venus_nogl(VirtIOGPU *g)
> +{
> +    return virtio_gpu_venus_enabled(g->parent_obj.conf) && !display_open=
gl;
> +}
> +
>  static struct virtio_gpu_virgl_resource *
>  virtio_gpu_virgl_find_resource(VirtIOGPU *g, uint32_t resource_id)
>  {
> @@ -63,7 +75,7 @@ virtio_gpu_virgl_find_resource(VirtIOGPU *g, uint32_t r=
esource_id)
>      return container_of(res, struct virtio_gpu_virgl_resource, base);
>  }
>=20=20
> -#if VIRGL_RENDERER_CALLBACKS_VERSION >=3D 4
> +#if VIRGL_RENDERER_CALLBACKS_VERSION >=3D 4 && defined(CONFIG_OPENGL)
>  static void *
>  virgl_get_egl_display(G_GNUC_UNUSED void *cookie)
>  {
> @@ -1032,6 +1044,45 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
>=20=20
>      VIRTIO_GPU_FILL_CMD(cmd->cmd_hdr);
>=20=20
> +    /*
> +     * Venus no-GL mode: route 2D display commands to the base software
> +     * renderer (pixman). The guest kernel always uses 2D commands for
> +     * display framebuffers even with VIRGL enabled; Venus/3D commands
> +     * go through the virglrenderer render server as usual.
> +     */
> +    if (virtio_gpu_venus_nogl(g)) {
> +        switch (cmd->cmd_hdr.type) {
> +        case VIRTIO_GPU_CMD_RESOURCE_CREATE_2D:
> +        case VIRTIO_GPU_CMD_SET_SCANOUT:
> +        case VIRTIO_GPU_CMD_RESOURCE_FLUSH:
> +        case VIRTIO_GPU_CMD_TRANSFER_TO_HOST_2D:
> +        case VIRTIO_GPU_CMD_GET_DISPLAY_INFO:
> +        case VIRTIO_GPU_CMD_GET_EDID:
> +            virtio_gpu_simple_process_cmd(g, cmd);
> +            return;
> +        case VIRTIO_GPU_CMD_RESOURCE_UNREF:
> +        case VIRTIO_GPU_CMD_RESOURCE_ATTACH_BACKING:
> +        case VIRTIO_GPU_CMD_RESOURCE_DETACH_BACKING: {
> +            /*
> +             * Both 2D (simple) and blob (virgl) resources share g->resl=
ist.
> +             * Check if virglrenderer owns the resource to pick
> +             * the right handler.
> +             */
> +            struct virtio_gpu_resource_unref hdr;
> +            struct virgl_renderer_resource_info info;
> +            VIRTIO_GPU_FILL_CMD(hdr);
> +            if (virgl_renderer_resource_get_info(hdr.resource_id, &info)=
) {
> +                /* Not in virglrenderer =E2=80=94 it's a 2D software res=
ource */
> +                virtio_gpu_simple_process_cmd(g, cmd);
> +                return;
> +            }
> +            break; /* virglrenderer owns it =E2=80=94 fall through */
> +        }
> +        default:
> +            break;
> +        }
> +    }
> +
>      virgl_renderer_force_ctx_0();
>      switch (cmd->cmd_hdr.type) {
>      case VIRTIO_GPU_CMD_CTX_CREATE:
> @@ -1433,6 +1484,7 @@ static int virtio_gpu_virgl_init(VirtIOGPU *g)
>      uint32_t flags =3D 0;
>      VirtIOGPUGL *gl =3D VIRTIO_GPU_GL(g);
>=20=20
> +#ifdef CONFIG_OPENGL
>  #if VIRGL_RENDERER_CALLBACKS_VERSION >=3D 4
>      if (qemu_egl_display) {
>          virtio_gpu_3d_cbs.version =3D 4;
> @@ -1450,9 +1502,14 @@ static int virtio_gpu_virgl_init(VirtIOGPU *g)
>          flags |=3D VIRGL_RENDERER_D3D11_SHARE_TEXTURE;
>      }
>  #endif
> +#endif /* CONFIG_OPENGL */
>  #if VIRGL_VERSION_MAJOR >=3D 1
>      if (virtio_gpu_venus_enabled(g->parent_obj.conf)) {
> -        flags |=3D VIRGL_RENDERER_VENUS | VIRGL_RENDERER_RENDER_SERVER;
> +        flags |=3D VIRGL_RENDERER_VENUS
> +               | VIRGL_RENDERER_RENDER_SERVER;
> +        if (!display_opengl) {
> +            flags |=3D VIRGL_RENDERER_NO_VIRGL;
> +        }
>      }
>      if (virtio_gpu_drm_enabled(g->parent_obj.conf)) {
>          flags |=3D VIRGL_RENDERER_DRM;
> @@ -1475,6 +1532,12 @@ static int virtio_gpu_virgl_init(VirtIOGPU *g)
>      }
>  #endif
>=20=20
> +    if (!display_opengl) {
> +        virtio_gpu_3d_cbs.create_gl_context =3D NULL;
> +        virtio_gpu_3d_cbs.destroy_gl_context =3D NULL;
> +        virtio_gpu_3d_cbs.make_current =3D NULL;
> +    }
> +
>      ret =3D virgl_renderer_init(g, flags, &virtio_gpu_3d_cbs);
>      if (ret !=3D 0) {
>          error_report("virgl could not be initialized: %d", ret);
> @@ -1546,14 +1609,16 @@ GArray *virtio_gpu_virgl_get_capsets(VirtIOGPU *g)
>=20=20
>      capset_ids =3D g_array_new(false, false, sizeof(uint32_t));
>=20=20
> -    /* VIRGL is always supported. */
> -    virtio_gpu_virgl_add_capset(capset_ids, VIRTIO_GPU_CAPSET_VIRGL);
> +    /* OpenGL: VIRGL/VIRGL2 require a GL display backend */
> +    if (display_opengl) {
> +        virtio_gpu_virgl_add_capset(capset_ids, VIRTIO_GPU_CAPSET_VIRGL);
>=20=20
> -    virgl_renderer_get_cap_set(VIRTIO_GPU_CAPSET_VIRGL2,
> -                               &capset_max_ver,
> -                               &capset_max_size);
> -    if (capset_max_ver) {
> -        virtio_gpu_virgl_add_capset(capset_ids, VIRTIO_GPU_CAPSET_VIRGL2=
);
> +        virgl_renderer_get_cap_set(VIRTIO_GPU_CAPSET_VIRGL2,
> +                                   &capset_max_ver,
> +                                   &capset_max_size);
> +        if (capset_max_ver) {
> +            virtio_gpu_virgl_add_capset(capset_ids, VIRTIO_GPU_CAPSET_VI=
RGL2);
> +        }
>      }
>=20=20
>      if (virtio_gpu_venus_enabled(g->parent_obj.conf)) {

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

