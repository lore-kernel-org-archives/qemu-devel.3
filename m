Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3DDFD3C54C
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 05:29:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1fXl-0007DJ-6e; Fri, 18 Oct 2024 01:28:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t1fXi-0007Co-0n
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 01:28:54 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t1fXf-0007kK-My
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 01:28:53 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-7db54269325so1388573a12.2
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 22:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1729229330; x=1729834130;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7lkY7o8upz7BFgv/zNO9pDfD5iIrdfFvxVUHDeQKrC0=;
 b=2L/U9CoheatvAM0WGcZxL27vTIL7YwGUNEpxJ6v42M/ui/nA7/lUKRCCdxasG6+lC/
 nIDmSRyhVYwpXBWFYFgxkhmm+w1jCjuSELRq8DcN6uFzWYfU564fFBtJBGZ+T/oGcWiH
 NqzW8EcYK0Zw2dEuxZ5oLyv7XHVgy00ArDbJl7tuMeiBwoGhOA82dfitBH5F6Ro0Eg7O
 T9AVgVJg9uJPj6YM+rqbD96wsROjUxA9uM1jREfRJqdM94DeKBw5oaMHz7WrtZkMjfTy
 q7pBDoEMPNEpz5lKVOYJ+Qy2XFk9Q9c3L3U1I3sxMEjJmrId+JBXN8O0rtK7xxp/yxe9
 rSYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729229330; x=1729834130;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7lkY7o8upz7BFgv/zNO9pDfD5iIrdfFvxVUHDeQKrC0=;
 b=naP1+RrfbY5YCkYXImVC3PyFYakp2q3bd+1f2Qh+5MvmjSrgIhCsfDlP8kMgKNxOCK
 pFoQjYAm5+j+1e5j6HM6xm9JK7miAPmuld/W3e+/UdQ7zNQrMMiYIan8fL1N+M1TbBeq
 Gem01u1PeqwP/CvLid7eywJK2XAIH9gwB2Wbl7ylYJFuTVt+0bTvTqVekj3AtAw7mks4
 FOLNeuksQeCJvWfvlAE6t0oOwBBX4fc7hefddIMcoYguU20ypRWAHtIoQ6t2bIv/kur1
 w1Wd+iZ2lZdC5cJa8bb0eAcM0F9TLF8/MYC3EtVe47kIxEOPzMfIBAaxS3osLA+3ZeRL
 nOGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXClkQOszshsLpjc6tAfnEUBsGgLc9NsgNUBw1C2L5Vyv//vqLmrblhTEB9XD4ruDz6LqGBDq3BsEF/@nongnu.org
X-Gm-Message-State: AOJu0YweM2g2By5t6jM7ZMm7+wiaGGFhwGkb6hJCdBtkrgKozWXHn+Xo
 r1zjMl51V/jNWjybuvz5RtQGgxIgiUijlYWlWZKL/OyV46D8whbRN2FSiN+QoTY=
X-Google-Smtp-Source: AGHT+IF6IVDrAghxgM7XqFs28lp/RlJDbORFsaQ+GVdtRjLx/ZxZCLApKn9acYac7dTJcJSnzfch9w==
X-Received: by 2002:a05:6a21:1643:b0:1d9:23ab:470 with SMTP id
 adf61e73a8af0-1d92c5298d3mr1732872637.29.1729229329992; 
 Thu, 17 Oct 2024 22:28:49 -0700 (PDT)
Received: from [157.82.202.230] ([157.82.202.230])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20e5a8d6794sm5090145ad.151.2024.10.17.22.28.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Oct 2024 22:28:49 -0700 (PDT)
Message-ID: <9362f8ac-5616-4f6d-b424-3a2b679c2141@daynix.com>
Date: Fri, 18 Oct 2024 14:28:44 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] virtio-gpu: Support asynchronous fencing
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Rob Clark <robdclark@gmail.com>,
 Yiwei Zhang <zzyiwei@chromium.org>, Sergio Lopez Pascual <slp@redhat.com>
References: <20241015043238.114034-1-dmitry.osipenko@collabora.com>
 <20241015043238.114034-6-dmitry.osipenko@collabora.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20241015043238.114034-6-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::533;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x533.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/10/15 13:32, Dmitry Osipenko wrote:
> Support asynchronous fencing feature of virglrenderer. It allows Qemu to
> handle fence as soon as it's signalled instead of periodically polling
> the fence status. This feature is required for enabling DRM context
> support in Qemu because legacy fencing mode isn't supported for DRM
> contexts in virglrenderer.
> 
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>   hw/display/virtio-gpu-gl.c     |   3 +
>   hw/display/virtio-gpu-virgl.c  | 134 ++++++++++++++++++++++++++++-----
>   include/hw/virtio/virtio-gpu.h |  14 ++++
>   3 files changed, 133 insertions(+), 18 deletions(-)
> 
> diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
> index 7c0e448b4661..53d938f23f20 100644
> --- a/hw/display/virtio-gpu-gl.c
> +++ b/hw/display/virtio-gpu-gl.c
> @@ -170,6 +170,9 @@ static void virtio_gpu_gl_device_unrealize(DeviceState *qdev)
>       if (gl->renderer_state >= RS_INITED) {
>   #if VIRGL_VERSION_MAJOR >= 1
>           qemu_bh_delete(gl->cmdq_resume_bh);
> +
> +        virtio_gpu_virgl_reset_async_fences(g);
> +        qemu_bh_delete(gl->async_fence_bh);
>   #endif
>           if (virtio_gpu_stats_enabled(g->parent_obj.conf)) {
>               timer_free(gl->print_stats);
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index b32ce44ba2b1..ad6512987079 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -891,6 +891,7 @@ static void virgl_cmd_set_scanout_blob(VirtIOGPU *g,
>   void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
>                                         struct virtio_gpu_ctrl_command *cmd)
>   {
> +    VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
>       bool cmd_suspended = false;
>       int ret;
>   
> @@ -992,35 +993,117 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
>   
>       trace_virtio_gpu_fence_ctrl(cmd->cmd_hdr.fence_id, cmd->cmd_hdr.type);
>   
> -    ret = virgl_renderer_create_fence(cmd->cmd_hdr.fence_id, 0);
> -    if (ret)
> -        qemu_log_mask(LOG_GUEST_ERROR,
> -                      "%s: virgl_renderer_create_fence error: %s",
> -                      __func__, strerror(-ret));
> +    if (gl->context_fence_enabled &&
> +        (cmd->cmd_hdr.flags & VIRTIO_GPU_FLAG_INFO_RING_IDX)) {
> +        uint32_t flags = 0;
> +
> +        ret = virgl_renderer_context_create_fence(cmd->cmd_hdr.ctx_id, flags,
> +                                                  cmd->cmd_hdr.ring_idx,
> +                                                  cmd->cmd_hdr.fence_id);
> +        if (ret)
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: virgl_renderer_context_create_fence error: %s",
> +                          __func__, strerror(ret));
> +    } else {
> +        ret = virgl_renderer_create_fence(cmd->cmd_hdr.fence_id, 0);
> +        if (ret)
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: virgl_renderer_create_fence error: %s",
> +                          __func__, strerror(-ret));
> +    }
>   }
>   
> -static void virgl_write_fence(void *opaque, uint32_t fence)
> +static void virtio_gpu_virgl_async_fence_bh(void *opaque)
>   {
> -    VirtIOGPU *g = opaque;
> +    struct virtio_gpu_virgl_context_fence *f, *f_tmp;
>       struct virtio_gpu_ctrl_command *cmd, *tmp;
> +    VirtIOGPU *g = opaque;
> +    VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
>   
> -    QTAILQ_FOREACH_SAFE(cmd, &g->fenceq, next, tmp) {
> -        /*
> -         * the guest can end up emitting fences out of order
> -         * so we should check all fenced cmds not just the first one.
> -         */
> -        if (cmd->cmd_hdr.fence_id > fence) {
> -            continue;
> +    qemu_mutex_lock(&gl->async_fence_lock);
> +
> +    QSLIST_FOREACH_SAFE(f, &gl->async_fenceq, next, f_tmp) {
> +        QTAILQ_FOREACH_SAFE(cmd, &g->fenceq, next, tmp) {
> +            /*
> +             * the guest can end up emitting fences out of order
> +             * so we should check all fenced cmds not just the first one.
> +             */
> +            if (cmd->cmd_hdr.fence_id > f->fence_id) {
> +                continue;
> +            }
> +            if (cmd->cmd_hdr.flags & VIRTIO_GPU_FLAG_INFO_RING_IDX) {
> +                if (cmd->cmd_hdr.ring_idx != f->ring_idx) {
> +                    continue;
> +                }
> +                if (cmd->cmd_hdr.ctx_id != f->ctx_id) {
> +                    continue;
> +                }
> +            } else if (f->ring_idx >= 0) {
> +                /* ctx0 GL-query fences don't have ring info */
> +                continue;
> +            }
> +            virtio_gpu_ctrl_response_nodata(g, cmd, VIRTIO_GPU_RESP_OK_NODATA);
> +            QTAILQ_REMOVE(&g->fenceq, cmd, next);
> +            g_free(cmd);
>           }
> -        trace_virtio_gpu_fence_resp(cmd->cmd_hdr.fence_id);
> -        virtio_gpu_ctrl_response_nodata(g, cmd, VIRTIO_GPU_RESP_OK_NODATA);
> -        QTAILQ_REMOVE(&g->fenceq, cmd, next);
> -        g_free(cmd);
> +
> +        trace_virtio_gpu_fence_resp(f->fence_id);
> +        QSLIST_REMOVE(&gl->async_fenceq, f, virtio_gpu_virgl_context_fence,
> +                      next);
> +        g_free(f);
>           g->inflight--;
>           if (virtio_gpu_stats_enabled(g->parent_obj.conf)) {
>               trace_virtio_gpu_dec_inflight_fences(g->inflight);
>           }
>       }
> +
> +    qemu_mutex_unlock(&gl->async_fence_lock);
> +}
> +
> +void virtio_gpu_virgl_reset_async_fences(VirtIOGPU *g)
> +{
> +    struct virtio_gpu_virgl_context_fence *f, *f_tmp;
> +    VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
> +
> +    QSLIST_FOREACH_SAFE(f, &gl->async_fenceq, next, f_tmp) {
> +        QSLIST_REMOVE(&gl->async_fenceq, f, virtio_gpu_virgl_context_fence,
> +                      next);
> +        g_free(f);
> +    }
> +}
> +
> +static void
> +virtio_gpu_virgl_push_async_fence(VirtIOGPU *g, uint32_t ctx_id,
> +                                  int64_t ring_idx, uint64_t fence_id)
> +{
> +    struct virtio_gpu_virgl_context_fence *f;
> +    VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
> +
> +    f = g_new(struct virtio_gpu_virgl_context_fence, 1);
> +    f->ctx_id = ctx_id;
> +    f->ring_idx = ring_idx;
> +    f->fence_id = fence_id;
> +
> +    qemu_mutex_lock(&gl->async_fence_lock);
> +    QSLIST_INSERT_HEAD(&gl->async_fenceq, f, next);
> +    qemu_mutex_unlock(&gl->async_fence_lock);
> +
> +    qemu_bh_schedule(gl->async_fence_bh);
> +}
> +
> +static void virgl_write_fence(void *opaque, uint32_t fence)
> +{
> +    VirtIOGPU *g = opaque;
> +
> +    virtio_gpu_virgl_push_async_fence(g, 0, -1, fence);
> +}
> +
> +static void virgl_write_context_fence(void *opaque, uint32_t ctx_id,
> +                                      uint32_t ring_idx, uint64_t fence)
> +{
> +    VirtIOGPU *g = opaque;

What about taking the BQL here instead of having a QEMUBH?

> +
> +    virtio_gpu_virgl_push_async_fence(g, ctx_id, ring_idx, fence);
>   }
>   
>   static virgl_renderer_gl_context
> @@ -1110,6 +1193,8 @@ void virtio_gpu_virgl_reset_scanout(VirtIOGPU *g)
>           dpy_gfx_replace_surface(g->parent_obj.scanout[i].con, NULL);
>           dpy_gl_scanout_disable(g->parent_obj.scanout[i].con);
>       }
> +
> +    virtio_gpu_virgl_reset_async_fences(g);
>   }
>   
>   void virtio_gpu_virgl_reset(VirtIOGPU *g)
> @@ -1127,6 +1212,12 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
>       if (qemu_egl_display) {
>           virtio_gpu_3d_cbs.version = 4;
>           virtio_gpu_3d_cbs.get_egl_display = virgl_get_egl_display;
> +#if VIRGL_VERSION_MAJOR >= 1
> +        virtio_gpu_3d_cbs.write_context_fence = virgl_write_context_fence;
> +        flags |= VIRGL_RENDERER_ASYNC_FENCE_CB;
> +        flags |= VIRGL_RENDERER_THREAD_SYNC;
> +        gl->context_fence_enabled = true;
> +#endif
>       }
>   #endif
>   #ifdef VIRGL_RENDERER_D3D11_SHARE_TEXTURE
> @@ -1160,6 +1251,13 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
>       gl->cmdq_resume_bh = aio_bh_new(qemu_get_aio_context(),
>                                       virtio_gpu_virgl_resume_cmdq_bh,
>                                       g);
> +
> +    gl->async_fence_bh = aio_bh_new(qemu_get_aio_context(),
> +                                    virtio_gpu_virgl_async_fence_bh,
> +                                    g);
> +
> +    qemu_mutex_init(&gl->async_fence_lock);
> +    QSLIST_INIT(&gl->async_fenceq);
>   #endif
>   
>       return 0;
> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
> index 230fa0c4ee0a..5673f0be85f4 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -229,6 +229,13 @@ struct VirtIOGPUClass {
>                                Error **errp);
>   };
>   
> +struct virtio_gpu_virgl_context_fence {
> +    uint32_t ctx_id;
> +    int64_t ring_idx;
> +    uint64_t fence_id;
> +    QSLIST_ENTRY(virtio_gpu_virgl_context_fence) next;
> +};
> +
>   /* VirtIOGPUGL renderer states */
>   typedef enum {
>       RS_START,       /* starting state */
> @@ -246,6 +253,12 @@ struct VirtIOGPUGL {
>       QEMUTimer *print_stats;
>   
>       QEMUBH *cmdq_resume_bh;
> +
> +    QEMUBH *async_fence_bh;
> +    QemuMutex async_fence_lock;
> +    QSLIST_HEAD(, virtio_gpu_virgl_context_fence) async_fenceq;
> +
> +    bool context_fence_enabled;
>   };
>   
>   struct VhostUserGPU {
> @@ -360,5 +373,6 @@ void virtio_gpu_virgl_reset_scanout(VirtIOGPU *g);
>   void virtio_gpu_virgl_reset(VirtIOGPU *g);
>   int virtio_gpu_virgl_init(VirtIOGPU *g);
>   GArray *virtio_gpu_virgl_get_capsets(VirtIOGPU *g);
> +void virtio_gpu_virgl_reset_async_fences(VirtIOGPU *g);
>   
>   #endif


