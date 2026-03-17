Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42F18FEDA00
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 18:13:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Yud-0008J6-HR; Tue, 17 Mar 2026 14:13:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <visitorckw@gmail.com>)
 id 1w2YuW-0008Ib-Fq
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 14:12:58 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <visitorckw@gmail.com>)
 id 1w2YuS-0004TN-Gg
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 14:12:54 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-35a09e0dd63so6775955a91.3
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 11:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773771170; x=1774375970; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1WJD5wVdjDJkiEZrU/yWZ7Qx+oL3g1iyYYzXZ9pndhw=;
 b=DtCX+kA5j0JxEQdWXC75bufdKOKPrVK71hc7Ph4nFUaK0NjF39m8DXEps4u6At+YBX
 JCgRIBuno1cW6NA27/pAR2C6jORf8Zt189qO9WDGCQm1J/JZCcdq1GiHPzXFP2YpGKne
 AKZ2NUptGCAGwGyRg55E/HJ3G/e1IHqc09nqE33hTMCh/TdxJIHWF78LiZuShpVQLlj6
 0OJTAgtSjhkCF+hwDFmjGJ/5wsDGXCppZHKuWmWixMAGFlRVQbSdJc+/AMB/aq+Gb5ww
 6PZ14eqYnCM6/c/rNuTtPony9c21+23qyvs91ONxyHo7lq+eIz7eqrB2ZwzSE6GofESi
 VOHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773771170; x=1774375970;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1WJD5wVdjDJkiEZrU/yWZ7Qx+oL3g1iyYYzXZ9pndhw=;
 b=e+CvmLk82UUbPuF1TKYt9dvecJamLBR1Ef3HD5nGblYdlVWjgd77Ni0YRDzKALmG4b
 tBYOqxNmej1tL26h8sIpKXxj59iNhmrtJSFPBWgPMnyjO/fZ6i1kyn4YXS+c3up/4lpY
 7A9Atv7gYgRTs/9V4g6NfkkPpTvJRM3wtqL5bqVd/FnLjP/4GPAeeoGZHcBy4CkV4v+P
 y6XbSO0h3OkRc/YbAPoGL5JBkR1I/f/h558S8ywrdJ05gZC8oDwrTF+RefRDxnLuiit/
 JAecTGJLbg9tpqnF4HlSfdOM33GUZ7xBVP4vdqofmX/oO+Hx5JiDOk/9tCc35Fm+a+D4
 3dMQ==
X-Gm-Message-State: AOJu0YyRzbFygnKcm4xqooFnRlOZJkRWZvxlYJc6S/snKX0M/isyHjXv
 ggyCqszQL2Jx4dMeap9olzEhk6W1JGNCBsjm9emQwaQnxf56YhVOHAL7
X-Gm-Gg: ATEYQzwy7Rr5au9kz5hEgSj1YhH3ysLo0mZ2maj7DiekUgNqi96OomTh0IyCHteCfCC
 UXJBFVZAfMA9KG1URBrVntYzgJFy6qPalw3MTa5+pszc+ogN1p8lXua6rxWIH6DD0ZXqISTyVFI
 Eu9P14+5orbN70YneB1sDJalACc3poESRTRPMosbBf76NV5LYW6MC0GavveuzGnFybje1vykpSn
 2p39Ya7ZPKjbsP6cCTHKrme97f3LZrpDAof5OuXOxZWokcSg4fXmbHqQi/OIwd48AIFgIlpZZMg
 15F13h/Kq0CJt9b2epVFfWGtxzoWiOriCu25PpxuLlI7A6r2Dlxtf+MvNJZXRqbUpOsq6KHrD4n
 aMsQ3xxyJLM6eVWMlBQyk2dvPjkf05+XcgJnYN6xDZqdaI2G0OcI7TKhuyLqMy/y9uMmWIRI8GX
 eiT8DbJIxpftRPuj7IuPg61cA1J2OCsatTHkMhsMo8vZNlPA==
X-Received: by 2002:a17:90b:1848:b0:35b:a1b6:5bf5 with SMTP id
 98e67ed59e1d1-35bb9f2c3ffmr328257a91.31.1773771169905; 
 Tue, 17 Mar 2026 11:12:49 -0700 (PDT)
Received: from google.com ([2402:7500:a44:85b:33eb:25ae:8a8a:6a70])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c741e0d4b10sm276112a12.10.2026.03.17.11.12.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 11:12:49 -0700 (PDT)
Date: Wed, 18 Mar 2026 02:12:45 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Lucas Amaral <lucaaamaral@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, alex.bennee@linaro.org,
 dmitry.osipenko@collabora.com, marcandre.lureau@redhat.com
Subject: Re: [PATCH v4 2/4] virtio-gpu: decouple Venus from CONFIG_OPENGL
Message-ID: <abmZnVdAH3pbIGFs@google.com>
References: <20260317174915.31829-1-lucaaamaral@gmail.com>
 <20260317174915.31829-3-lucaaamaral@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260317174915.31829-3-lucaaamaral@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=visitorckw@gmail.com; helo=mail-pj1-x102f.google.com
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

Hi Lucas,

On Tue, Mar 17, 2026 at 02:49:13PM -0300, Lucas Amaral wrote:
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
> ---
>  hw/display/meson.build        |  8 ++--
>  hw/display/virtio-gpu-base.c  | 15 ++++++-
>  hw/display/virtio-gpu-gl.c    |  6 ++-
>  hw/display/virtio-gpu-virgl.c | 85 ++++++++++++++++++++++++++++++-----
>  4 files changed, 98 insertions(+), 16 deletions(-)
> 
> diff --git a/hw/display/meson.build b/hw/display/meson.build
> index 90e6c041..509479e7 100644
> --- a/hw/display/meson.build
> +++ b/hw/display/meson.build
> @@ -76,9 +76,9 @@ if config_all_devices.has_key('CONFIG_VIRTIO_GPU')
>    virtio_gpu_ss.add(when: 'CONFIG_VHOST_USER_GPU', if_true: files('vhost-user-gpu.c'))
>    hw_display_modules += {'virtio-gpu': virtio_gpu_ss}
>  
> -  if virgl.found() and opengl.found()
> +  if virgl.found()
>      virtio_gpu_gl_ss = ss.source_set()
> -    virtio_gpu_gl_ss.add(when: ['CONFIG_VIRTIO_GPU', virgl, opengl],
> +    virtio_gpu_gl_ss.add(when: ['CONFIG_VIRTIO_GPU', virgl],
>                           if_true: [files('virtio-gpu-gl.c', 'virtio-gpu-virgl.c'), pixman, virgl])
>      hw_display_modules += {'virtio-gpu-gl': virtio_gpu_gl_ss}
>    endif
> @@ -99,9 +99,9 @@ if config_all_devices.has_key('CONFIG_VIRTIO_PCI')
>                          if_true: files('vhost-user-gpu-pci.c'))
>    hw_display_modules += {'virtio-gpu-pci': virtio_gpu_pci_ss}
>  
> -  if virgl.found() and opengl.found()
> +  if virgl.found()
>      virtio_gpu_pci_gl_ss = ss.source_set()
> -    virtio_gpu_pci_gl_ss.add(when: ['CONFIG_VIRTIO_GPU', 'CONFIG_VIRTIO_PCI', virgl, opengl],
> +    virtio_gpu_pci_gl_ss.add(when: ['CONFIG_VIRTIO_GPU', 'CONFIG_VIRTIO_PCI', virgl],
>                               if_true: [files('virtio-gpu-pci-gl.c'), pixman])
>      hw_display_modules += {'virtio-gpu-pci-gl': virtio_gpu_pci_gl_ss}
>    endif
> diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
> index cb76302e..cc9704cd 100644
> --- a/hw/display/virtio-gpu-base.c
> +++ b/hw/display/virtio-gpu-base.c
> @@ -18,6 +18,7 @@
>  #include "qapi/error.h"
>  #include "qemu/error-report.h"
>  #include "hw/display/edid.h"
> +#include "system/system.h"
>  #include "trace.h"
>  #include "qapi/qapi-types-virtio.h"
>  
> @@ -157,7 +158,18 @@ virtio_gpu_get_flags(void *opaque)
>      VirtIOGPUBase *g = opaque;
>      int flags = GRAPHIC_FLAGS_NONE;
>  
> -    if (virtio_gpu_virgl_enabled(g->conf)) {
> +    if (virtio_gpu_venus_enabled(g->conf)) {
> +        /* TODO: set GRAPHIC_FLAGS_VK for direct Vulkan scanout */
> +    }
> +
> +    /*
> +     * TODO: virtio_gpu_virgl_enabled() checks VIRTIO_GPU_FLAG_VIRGL_ENABLED
> +     * which is set for both OpenGL (VIRGL) and Vulkan (Venus) backends.
> +     * This condition should ideally use a dedicated OpenGL-only flag. For
> +     * now, display_opengl correctly gates GL scanout since Venus leaves it
> +     * at 0.
> +     */
> +    if (virtio_gpu_virgl_enabled(g->conf) && display_opengl) {
>          flags |= GRAPHIC_FLAGS_GL;
>      }
>  
> @@ -273,6 +285,7 @@ virtio_gpu_base_get_features(VirtIODevice *vdev, uint64_t features,
>      }
>      if (virtio_gpu_blob_enabled(g->conf)) {
>          features |= (1 << VIRTIO_GPU_F_RESOURCE_BLOB);
> +        features |= (1 << VIRTIO_GPU_F_BLOB_ALIGNMENT);

Thanks for the patch.

You are using VIRTIO_GPU_F_BLOB_ALIGNMENT here in patch2, but the macro
isn't actually defined until Patch 3. This breaks git bisect because
the project will fail to compile if someone checks out this specific
commit.

Here is the build error it causes:

../hw/display/virtio-gpu-base.c: In function ‘virtio_gpu_base_get_features’:
../hw/display/virtio-gpu-base.c:288:27: error: ‘VIRTIO_GPU_F_BLOB_ALIGNMENT’ undeclared (first use in this function); did you mean ‘VIRTIO_GPU_BLOB_MEM_GUEST’?
  288 |         features |= (1 << VIRTIO_GPU_F_BLOB_ALIGNMENT);
      |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~
      |                           VIRTIO_GPU_BLOB_MEM_GUEST

Regards,
Kuan-Wei

>      }
>      if (virtio_gpu_context_init_enabled(g->conf)) {
>          features |= (1 << VIRTIO_GPU_F_CONTEXT_INIT);
> diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
> index 2b7a41c4..1a95e6a7 100644
> --- a/hw/display/virtio-gpu-gl.c
> +++ b/hw/display/virtio-gpu-gl.c
> @@ -124,7 +124,9 @@ static void virtio_gpu_gl_device_realize(DeviceState *qdev, Error **errp)
>          return;
>      }
>  
> -    if (!display_opengl) {
> +    if (virtio_gpu_venus_enabled(g->parent_obj.conf)) {
> +        /* Venus uses Vulkan in the render server, no GL needed */
> +    } else if (!display_opengl) {
>          error_setg(errp,
>                     "The display backend does not have OpenGL support enabled");
>          error_append_hint(errp,
> @@ -245,4 +247,6 @@ static void virtio_register_types(void)
>  type_init(virtio_register_types)
>  
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
>  
>  #include <virglrenderer.h>
>  
> @@ -50,6 +52,16 @@ struct virtio_gpu_virgl_resource {
>      void *map_fixed;
>  };
>  
> +/*
> + * Venus no-GL mode: Venus is enabled but no OpenGL display is available.
> + * Display commands use software (pixman) rendering; Venus/3D commands
> + * go through the virglrenderer render server.
> + */
> +static bool virtio_gpu_venus_nogl(VirtIOGPU *g)
> +{
> +    return virtio_gpu_venus_enabled(g->parent_obj.conf) && !display_opengl;
> +}
> +
>  static struct virtio_gpu_virgl_resource *
>  virtio_gpu_virgl_find_resource(VirtIOGPU *g, uint32_t resource_id)
>  {
> @@ -63,7 +75,7 @@ virtio_gpu_virgl_find_resource(VirtIOGPU *g, uint32_t resource_id)
>      return container_of(res, struct virtio_gpu_virgl_resource, base);
>  }
>  
> -#if VIRGL_RENDERER_CALLBACKS_VERSION >= 4
> +#if VIRGL_RENDERER_CALLBACKS_VERSION >= 4 && defined(CONFIG_OPENGL)
>  static void *
>  virgl_get_egl_display(G_GNUC_UNUSED void *cookie)
>  {
> @@ -1032,6 +1044,45 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
>  
>      VIRTIO_GPU_FILL_CMD(cmd->cmd_hdr);
>  
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
> +             * Both 2D (simple) and blob (virgl) resources share g->reslist.
> +             * Check if virglrenderer owns the resource to pick
> +             * the right handler.
> +             */
> +            struct virtio_gpu_resource_unref hdr;
> +            struct virgl_renderer_resource_info info;
> +            VIRTIO_GPU_FILL_CMD(hdr);
> +            if (virgl_renderer_resource_get_info(hdr.resource_id, &info)) {
> +                /* Not in virglrenderer — it's a 2D software resource */
> +                virtio_gpu_simple_process_cmd(g, cmd);
> +                return;
> +            }
> +            break; /* virglrenderer owns it — fall through */
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
>      uint32_t flags = 0;
>      VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
>  
> +#ifdef CONFIG_OPENGL
>  #if VIRGL_RENDERER_CALLBACKS_VERSION >= 4
>      if (qemu_egl_display) {
>          virtio_gpu_3d_cbs.version = 4;
> @@ -1450,9 +1502,14 @@ static int virtio_gpu_virgl_init(VirtIOGPU *g)
>          flags |= VIRGL_RENDERER_D3D11_SHARE_TEXTURE;
>      }
>  #endif
> +#endif /* CONFIG_OPENGL */
>  #if VIRGL_VERSION_MAJOR >= 1
>      if (virtio_gpu_venus_enabled(g->parent_obj.conf)) {
> -        flags |= VIRGL_RENDERER_VENUS | VIRGL_RENDERER_RENDER_SERVER;
> +        flags |= VIRGL_RENDERER_VENUS
> +               | VIRGL_RENDERER_RENDER_SERVER;
> +        if (!display_opengl) {
> +            flags |= VIRGL_RENDERER_NO_VIRGL;
> +        }
>      }
>      if (virtio_gpu_drm_enabled(g->parent_obj.conf)) {
>          flags |= VIRGL_RENDERER_DRM;
> @@ -1475,6 +1532,12 @@ static int virtio_gpu_virgl_init(VirtIOGPU *g)
>      }
>  #endif
>  
> +    if (!display_opengl) {
> +        virtio_gpu_3d_cbs.create_gl_context = NULL;
> +        virtio_gpu_3d_cbs.destroy_gl_context = NULL;
> +        virtio_gpu_3d_cbs.make_current = NULL;
> +    }
> +
>      ret = virgl_renderer_init(g, flags, &virtio_gpu_3d_cbs);
>      if (ret != 0) {
>          error_report("virgl could not be initialized: %d", ret);
> @@ -1546,14 +1609,16 @@ GArray *virtio_gpu_virgl_get_capsets(VirtIOGPU *g)
>  
>      capset_ids = g_array_new(false, false, sizeof(uint32_t));
>  
> -    /* VIRGL is always supported. */
> -    virtio_gpu_virgl_add_capset(capset_ids, VIRTIO_GPU_CAPSET_VIRGL);
> +    /* OpenGL: VIRGL/VIRGL2 require a GL display backend */
> +    if (display_opengl) {
> +        virtio_gpu_virgl_add_capset(capset_ids, VIRTIO_GPU_CAPSET_VIRGL);
>  
> -    virgl_renderer_get_cap_set(VIRTIO_GPU_CAPSET_VIRGL2,
> -                               &capset_max_ver,
> -                               &capset_max_size);
> -    if (capset_max_ver) {
> -        virtio_gpu_virgl_add_capset(capset_ids, VIRTIO_GPU_CAPSET_VIRGL2);
> +        virgl_renderer_get_cap_set(VIRTIO_GPU_CAPSET_VIRGL2,
> +                                   &capset_max_ver,
> +                                   &capset_max_size);
> +        if (capset_max_ver) {
> +            virtio_gpu_virgl_add_capset(capset_ids, VIRTIO_GPU_CAPSET_VIRGL2);
> +        }
>      }
>  
>      if (virtio_gpu_venus_enabled(g->parent_obj.conf)) {
> -- 
> 2.52.0
> 
> 
> 

