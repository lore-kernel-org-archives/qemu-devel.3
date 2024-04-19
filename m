Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D01BDC04FF6
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 09:18:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxkOM-0008TM-4S; Fri, 19 Apr 2024 05:18:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rxkOI-0008Ri-CE
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 05:18:43 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rxkOE-0004EV-6L
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 05:18:40 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6ecec796323so1865212b3a.3
 for <qemu-devel@nongnu.org>; Fri, 19 Apr 2024 02:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1713518317; x=1714123117;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=agokSpXx187JS2jPBGgis9sMKQVQTUIBGL8x2lluVgw=;
 b=bkHR0klbWVGoIRd6YJkdoB4hCZdBk8SjIgUgacfdJqWWceCkAXTI6KkSgCDDBl5j0h
 NQ6PpioHuUEzWWT2OquKjq3PdoR5eVSxj4USuWQ0w+SE00TZuS7wm4s01qLllp/Xiwog
 4wnxcj/KenkNDMD6Vrr24I3XzN2JkajB8GXvetBoe2Nz252M67STpUaT0VnHHAVv3zQv
 4X29cVcI1HnafUmfK9eeAsaGdpyDY1k9o1Z7OpdvdaKOb8C8qFXexrhHWwLm+BshbmAy
 W9sSiy9UE/yaft0m0WLY8ufBjCAytRyKl2zb1HD/CyWDgVYZwppnRzhKN/5W7kDRXBJj
 81JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713518317; x=1714123117;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=agokSpXx187JS2jPBGgis9sMKQVQTUIBGL8x2lluVgw=;
 b=OPx8No4wfMbQQZGRzzS1Xg3JwDwxBLVYy25mWyjUjI/rsFYWtHgCF51QtB5IWEBviW
 HiVZGL0DXMFi1If6i3CLw599TvpL3qc2ACagxxXMR0njP2sJ26ZGWbvD2fGTV8CIeluF
 7xVD/rzMQ9Lh+0HdOQyo72tftARI34NMm3Fq13QHvWpzcwoks/bBPYGaRlvJq/3I+Dgg
 BJzxi92KBIVRNOHb8rKz9U+vvHYe9oN/xkSxYFzkmO/ULONuIoceQ+k0AzOx1mQIK0/T
 fVSUq67GOBCF2qGeWkTn2Xrj0w65maQdFFx7jMxgLb9c8ShhEfz6/DJFThmF/lwHUhjh
 1Nyg==
X-Gm-Message-State: AOJu0Ywke2ds38IeZiRSW+uddy0diAfr1u92rn4jzNh9WN6+uYx0kXJd
 WMmgeY7MZl41iFOjGoyI5om4hG+DLB9hvTIqZrmQUgvxFHM2ImYbOGKZV4lagho=
X-Google-Smtp-Source: AGHT+IFaqXAZXI5cM+872/9+Q77yLG7ZhjL9hc2+O8Zp5LleNw19o0xwA145bnYazOipNnsnZKW96A==
X-Received: by 2002:a17:903:2b04:b0:1e8:6614:51cc with SMTP id
 mc4-20020a1709032b0400b001e8661451ccmr2079110plb.5.1713518316696; 
 Fri, 19 Apr 2024 02:18:36 -0700 (PDT)
Received: from [157.82.207.134] ([157.82.207.134])
 by smtp.gmail.com with ESMTPSA id
 x7-20020a1709027c0700b001e2c8bc6bebsm2893924pll.81.2024.04.19.02.18.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Apr 2024 02:18:36 -0700 (PDT)
Message-ID: <2c5a0b2e-58ef-4766-baea-5df98fa6fc2f@daynix.com>
Date: Fri, 19 Apr 2024 18:18:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 08/11] virtio-gpu: Handle resource blob commands
Content-Language: en-US
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Huang Rui <ray.huang@amd.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony.perard@citrix.com>,
 Antonio Caggiano <quic_acaggian@quicinc.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Robert Beckett <bob.beckett@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Gurchetan Singh <gurchetansingh@chromium.org>,
 ernunes@redhat.com, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Yiwei Zhang <zzyiwei@chromium.org>
References: <20240418190040.1110210-1-dmitry.osipenko@collabora.com>
 <20240418190040.1110210-9-dmitry.osipenko@collabora.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240418190040.1110210-9-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42f.google.com
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

On 2024/04/19 4:00, Dmitry Osipenko wrote:
> From: Antonio Caggiano <antonio.caggiano@collabora.com>
> 
> Support BLOB resources creation, mapping and unmapping by calling the
> new stable virglrenderer 0.10 interface. Only enabled when available and
> via the blob config. E.g. -device virtio-vga-gl,blob=true
> 
> Signed-off-by: Antonio Caggiano <antonio.caggiano@collabora.com>
> Signed-off-by: Xenia Ragiadakou <xenia.ragiadakou@amd.com>
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>   hw/display/virtio-gpu-virgl.c  | 248 +++++++++++++++++++++++++++++++++
>   hw/display/virtio-gpu.c        |   4 +-
>   include/hw/virtio/virtio-gpu.h |   4 +
>   3 files changed, 255 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index bb9ee1eba9a0..de132b22f554 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -32,6 +32,102 @@ virgl_get_egl_display(G_GNUC_UNUSED void *cookie)
>   }
>   #endif
>   
> +#ifdef HAVE_VIRGL_RESOURCE_BLOB
> +struct virtio_gpu_virgl_hostmem_region {
> +    MemoryRegion mr;
> +    VirtIOGPUBase *b;
> +    struct virtio_gpu_simple_resource *res;
> +};
> +
> +static void virtio_gpu_virgl_hostmem_region_free(void *obj)
> +{
> +    MemoryRegion *mr = MEMORY_REGION(obj);
> +    struct virtio_gpu_virgl_hostmem_region *vmr;
> +
> +    vmr = container_of(mr, struct virtio_gpu_virgl_hostmem_region, mr);
> +    vmr->res->async_unmap_in_progress = false;
> +    vmr->res->async_unmap_completed = true;
> +    vmr->b->renderer_blocked--;

Resume the command queue processing here.

> +
> +    g_free(vmr);
> +}
> +
> +static int
> +virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
> +                                   struct virtio_gpu_simple_resource *res,
> +                                   uint64_t offset)
> +{
> +    struct virtio_gpu_virgl_hostmem_region *vmr;
> +    VirtIOGPUBase *b = VIRTIO_GPU_BASE(g);
> +    uint64_t size;
> +    void *data;
> +    int ret;
> +
> +    if (!virtio_gpu_hostmem_enabled(b->conf)) {
> +        return -EOPNOTSUPP;

Log a message here instead of picking an error number.

> +    }
> +
> +    ret = virgl_renderer_resource_map(res->resource_id, &data, &size);
> +    if (ret) {
> +        return -ret;
> +    }
> +
> +    vmr = g_new0(struct virtio_gpu_virgl_hostmem_region, 1);
> +    MemoryRegion *mr = &vmr->mr;

Mixed declarations are not allowed; see: docs/devel/style.rst

> +    vmr->res = res;
> +    vmr->b = b;
> +
> +    memory_region_init_ram_ptr(mr, OBJECT(mr), "blob", size, data);
> +    memory_region_add_subregion(&b->hostmem, offset, mr);
> +    memory_region_set_enabled(mr, true);
> +
> +    /*
> +     * Potentially, MR could outlive the resource if MR's reference is held
> +     * outside of virtio-gpu. In order to prevent unmapping resource while
> +     * MR is alive, and thus, making the data pointer invalid, we will block
> +     * virtio-gpu command processing until MR is fully unreferenced and
> +     * released.
> +     */
> +    OBJECT(mr)->free = virtio_gpu_virgl_hostmem_region_free;
> +
> +    res->mr = mr;
> +
> +    return 0;
> +}
> +
> +static bool
> +virtio_gpu_virgl_unmap_resource_blob(VirtIOGPU *g,
> +                                     struct virtio_gpu_simple_resource *res)
> +{
> +    VirtIOGPUBase *b = VIRTIO_GPU_BASE(g);
> +
> +    if (!res->async_unmap_in_progress && !res->async_unmap_completed) {
> +        /* memory region owns self res->mr object and frees it by itself */
> +        MemoryRegion *mr = res->mr;
> +        res->mr = NULL;
> +
> +        res->async_unmap_in_progress = true;
> +
> +        /* render will be unblocked when MR is freed */
> +        b->renderer_blocked++;
> +
> +        memory_region_set_enabled(mr, false);
> +        memory_region_del_subregion(&b->hostmem, mr);
> +        object_unparent(OBJECT(mr));
> +    }
> +
> +    if (!res->async_unmap_completed) {

This check is unnecessary as the command processing is blocked until the 
unmap operation completes.

> +        return false;
> +    }
> +
> +    virgl_renderer_resource_unmap(res->resource_id);
> +    res->async_unmap_completed = false;
> +
> +    return true;
> +
> +}
> +#endif /* HAVE_VIRGL_RESOURCE_BLOB */
> +
>   static void virgl_cmd_create_resource_2d(VirtIOGPU *g,
>                                            struct virtio_gpu_ctrl_command *cmd)
>   {
> @@ -145,6 +241,14 @@ static void virgl_cmd_resource_unref(VirtIOGPU *g,
>           return;
>       }
>   
> +    if (res->mr || cmd->suspended) {
> +        bool unmapped = virtio_gpu_virgl_unmap_resource_blob(g, res);
> +        cmd->suspended = !unmapped;
> +        if (cmd->suspended) {
> +            return;
> +        }
> +    }
> +
>       virgl_renderer_resource_detach_iov(unref.resource_id,
>                                          &res_iovs,
>                                          &num_iovs);
> @@ -495,6 +599,141 @@ static void virgl_cmd_get_capset(VirtIOGPU *g,
>   }
>   
>   #ifdef HAVE_VIRGL_RESOURCE_BLOB
> +static void virgl_cmd_resource_create_blob(VirtIOGPU *g,
> +                                           struct virtio_gpu_ctrl_command *cmd)
> +{
> +    struct virgl_renderer_resource_create_blob_args virgl_args = { 0 };
> +    struct virtio_gpu_resource_create_blob cblob;
> +    struct virtio_gpu_simple_resource *res;
> +    int ret;
> +
> +    if (!virtio_gpu_blob_enabled(g->parent_obj.conf)) {
> +        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
> +        return;
> +    }
> +
> +    VIRTIO_GPU_FILL_CMD(cblob);
> +    virtio_gpu_create_blob_bswap(&cblob);
> +    trace_virtio_gpu_cmd_res_create_blob(cblob.resource_id, cblob.size);
> +
> +    if (cblob.resource_id == 0) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource id 0 is not allowed\n",
> +                      __func__);
> +        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
> +        return;
> +    }
> +
> +    res = virtio_gpu_find_resource(g, cblob.resource_id);
> +    if (res) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource already exists %d\n",
> +                      __func__, cblob.resource_id);
> +        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
> +        return;
> +    }
> +
> +    res = g_new0(struct virtio_gpu_simple_resource, 1);
> +    res->resource_id = cblob.resource_id;
> +    res->blob_size = cblob.size;
> +    res->dmabuf_fd = -1;
> +
> +    if (cblob.blob_mem != VIRTIO_GPU_BLOB_MEM_HOST3D) {
> +        ret = virtio_gpu_create_mapping_iov(g, cblob.nr_entries, sizeof(cblob),
> +                                            cmd, &res->addrs,
> +                                            &res->iov, &res->iov_cnt);
> +        if (!ret) {
> +            g_free(res);
> +            cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
> +            return;
> +        }
> +    }
> +
> +    QTAILQ_INSERT_HEAD(&g->reslist, res, next);
> +
> +    virgl_args.res_handle = cblob.resource_id;
> +    virgl_args.ctx_id = cblob.hdr.ctx_id;
> +    virgl_args.blob_mem = cblob.blob_mem;
> +    virgl_args.blob_id = cblob.blob_id;
> +    virgl_args.blob_flags = cblob.blob_flags;
> +    virgl_args.size = cblob.size;
> +    virgl_args.iovecs = res->iov;
> +    virgl_args.num_iovs = res->iov_cnt;
> +
> +    ret = virgl_renderer_resource_create_blob(&virgl_args);
> +    if (ret) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: virgl blob create error: %s\n",
> +                      __func__, strerror(-ret));
> +        cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
> +    }
> +}
> +
> +static void virgl_cmd_resource_map_blob(VirtIOGPU *g,
> +                                        struct virtio_gpu_ctrl_command *cmd)
> +{
> +    struct virtio_gpu_resource_map_blob mblob;
> +    struct virtio_gpu_simple_resource *res;
> +    struct virtio_gpu_resp_map_info resp;
> +    int ret;
> +
> +    VIRTIO_GPU_FILL_CMD(mblob);
> +    virtio_gpu_map_blob_bswap(&mblob);
> +
> +    res = virtio_gpu_find_resource(g, mblob.resource_id);
> +    if (!res) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource does not exist %d\n",
> +                      __func__, mblob.resource_id);
> +        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
> +        return;
> +    }
> +
> +    if (res->mr) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource already mapped %d\n",
> +                      __func__, mblob.resource_id);
> +        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
> +        return;
> +    }
> +
> +    ret = virtio_gpu_virgl_map_resource_blob(g, res, mblob.offset);
> +    if (ret) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource map error: %s\n",
> +                      __func__, strerror(ret));
> +        cmd->error = VIRTIO_GPU_RESP_ERR_OUT_OF_MEMORY;
> +        return;
> +    }
> +
> +    memset(&resp, 0, sizeof(resp));
> +    resp.hdr.type = VIRTIO_GPU_RESP_OK_MAP_INFO;
> +    virgl_renderer_resource_get_map_info(mblob.resource_id, &resp.map_info);
> +    virtio_gpu_ctrl_response(g, cmd, &resp.hdr, sizeof(resp));
> +}
> +
> +static void virgl_cmd_resource_unmap_blob(VirtIOGPU *g,
> +                                          struct virtio_gpu_ctrl_command *cmd)
> +{
> +    struct virtio_gpu_resource_unmap_blob ublob;
> +    struct virtio_gpu_simple_resource *res;
> +
> +    VIRTIO_GPU_FILL_CMD(ublob);
> +    virtio_gpu_unmap_blob_bswap(&ublob);
> +
> +    res = virtio_gpu_find_resource(g, ublob.resource_id);
> +    if (!res) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource does not exist %d\n",
> +                      __func__, ublob.resource_id);
> +        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
> +        return;
> +    }
> +
> +    if (!res->mr && !cmd->suspended) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource already unmapped %d\n",
> +                      __func__, ublob.resource_id);
> +        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
> +        return;
> +    }
> +
> +    bool unmapped = virtio_gpu_virgl_unmap_resource_blob(g, res);
> +    cmd->suspended = !unmapped;
> +}
> +
>   static void virgl_cmd_set_scanout_blob(VirtIOGPU *g,
>                                          struct virtio_gpu_ctrl_command *cmd)
>   {
> @@ -661,6 +900,15 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
>           virtio_gpu_get_edid(g, cmd);
>           break;
>   #ifdef HAVE_VIRGL_RESOURCE_BLOB
> +    case VIRTIO_GPU_CMD_RESOURCE_CREATE_BLOB:
> +        virgl_cmd_resource_create_blob(g, cmd);
> +        break;
> +    case VIRTIO_GPU_CMD_RESOURCE_MAP_BLOB:
> +        virgl_cmd_resource_map_blob(g, cmd);
> +        break;
> +    case VIRTIO_GPU_CMD_RESOURCE_UNMAP_BLOB:
> +        virgl_cmd_resource_unmap_blob(g, cmd);
> +        break;
>       case VIRTIO_GPU_CMD_SET_SCANOUT_BLOB:
>           virgl_cmd_set_scanout_blob(g, cmd);
>           break;
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index a1bd4d6914c4..45c1f2006712 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -1483,10 +1483,12 @@ void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
>               return;
>           }
>   
> +#ifndef HAVE_VIRGL_RESOURCE_BLOB
>           if (virtio_gpu_virgl_enabled(g->parent_obj.conf)) {
> -            error_setg(errp, "blobs and virgl are not compatible (yet)");
> +            error_setg(errp, "old virglrenderer, blob resources unsupported");
>               return;
>           }
> +#endif
>       }
>   
>       if (!virtio_gpu_base_device_realize(qdev,
> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
> index dc24360656ce..b9d5e106f3c5 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -61,6 +61,10 @@ struct virtio_gpu_simple_resource {
>       int dmabuf_fd;
>       uint8_t *remapped;
>   
> +    MemoryRegion *mr;
> +    bool async_unmap_completed;
> +    bool async_unmap_in_progress;
> +

Don't add fields to virtio_gpu_simple_resource but instead create a 
struct that embeds virtio_gpu_simple_resource in virtio-gpu-virgl.c.

>       QTAILQ_ENTRY(virtio_gpu_simple_resource) next;
>   };
>   

