Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F807C4345F
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2024 11:58:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvc0b-0002xi-2q; Sat, 13 Apr 2024 07:57:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rvc0Z-0002xA-0b
 for qemu-devel@nongnu.org; Sat, 13 Apr 2024 07:57:23 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rvc0V-0006H0-Vg
 for qemu-devel@nongnu.org; Sat, 13 Apr 2024 07:57:22 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-5cf2d73a183so1727528a12.1
 for <qemu-devel@nongnu.org>; Sat, 13 Apr 2024 04:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1713009437; x=1713614237;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OLavlV+H2aR5Ib4NgUrGTvgi/nHqJ3ORqvKb4l9L5NE=;
 b=CfyAmIqH8Vx0sXsijTRjKW1NRTZZ3+8C0546EyFOZml8xzaJT26NqHuVrwwh6YJ8pp
 m05rn0hqwCMRxLzRjYIzmv2saQpHVZCXDeY+5ScUa+VpqF8S4pfwvDPy8qT/vlfMHuWE
 qIUuG++XmzBbgwr6VbIzw2Luk8piBlshNig+e1vSYpAykM4VTQthwa0VHdgaXDCK0hO6
 39VDnK/7jmgfP+DxNXArEf67apbH7KiUUwnGQ49l1VtK6DZVRxOii4s41nUWU4iGjHCB
 PSD3UjCX+pdm+lNeritntPHdBKnGtkSQQkqTEMSinaa1ynNAL53sCTCOqGS8FHZv7bNM
 A3dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713009437; x=1713614237;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OLavlV+H2aR5Ib4NgUrGTvgi/nHqJ3ORqvKb4l9L5NE=;
 b=afD8R4vP8DvhB7RqBafl647VydlowJXmdQh692MiGQoyABwpHwFCbpue8zaVfZ3//p
 N4DK8m5EX0a/3OkjBX6BevejdrbZpDuh1Y93l79FI/9CJmsPUdWcUe99ZFmfUKq4fGk7
 SLa5m7o6UPOCXNvGrHvWdoYCv2C7n9QGVwJI8dovM2w/IGYa/38uTr6ZWL3EpKiT6No7
 AlaO5JGQclvnyaiovn2TdfwKy8Jimg6sTvo3UsFHj2NaN5OOFmufPokkL+vIloQRp2ey
 /gkGJ4bSAyu8wdjsH56SXbY9mvfe589sVO8svKMQ7UwY9kPgEyrAz64y7c/lL6h1+Ybz
 QupQ==
X-Gm-Message-State: AOJu0YwDEswbNUPe5pU6Bm/GdQxs8fTS13h+zv3+pd4FSGxpuXnktIwZ
 X1sGZ77fusbtjJCWtIBeNATOAAus3hsp1UeJLqv4ehv1/wkb4N2RoTRswhjv6U0=
X-Google-Smtp-Source: AGHT+IF0NjNpaB5NKJmgKGvA3jaGdac0x3TIu7K2JdQCU+WZg+NxzuXaEjYDimwjpSI6oYT2aYCjTA==
X-Received: by 2002:a17:90a:3946:b0:2a5:5f9f:6733 with SMTP id
 n6-20020a17090a394600b002a55f9f6733mr10874061pjf.20.1713009437502; 
 Sat, 13 Apr 2024 04:57:17 -0700 (PDT)
Received: from [157.82.206.17] ([157.82.206.17])
 by smtp.gmail.com with ESMTPSA id
 gq9-20020a17090b104900b002a24886fa5asm5820525pjb.36.2024.04.13.04.57.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 13 Apr 2024 04:57:16 -0700 (PDT)
Message-ID: <29a55f63-593e-46d0-8dfe-f55e2b2de7ac@daynix.com>
Date: Sat, 13 Apr 2024 20:57:10 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 07/10] virtio-gpu: Handle resource blob commands
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
 Chen Jiqian <Jiqian.Chen@amd.com>
References: <20240411102002.240536-1-dmitry.osipenko@collabora.com>
 <20240411102002.240536-8-dmitry.osipenko@collabora.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240411102002.240536-8-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::529;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x529.google.com
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

On 2024/04/11 19:19, Dmitry Osipenko wrote:
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
>   hw/display/virtio-gpu-virgl.c  | 196 +++++++++++++++++++++++++++++++++
>   hw/display/virtio-gpu.c        |   4 +-
>   include/hw/virtio/virtio-gpu.h |   1 +
>   3 files changed, 200 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index c2057b0c2147..ec63f5d698b7 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -32,6 +32,55 @@ virgl_get_egl_display(G_GNUC_UNUSED void *cookie)
>   }
>   #endif
>   
> +#ifdef HAVE_VIRGL_RESOURCE_BLOB
> +static int
> +virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
> +                                   struct virtio_gpu_simple_resource *res,
> +                                   uint64_t offset)
> +{
> +    VirtIOGPUBase *b = VIRTIO_GPU_BASE(g);
> +    uint64_t size;
> +    void *data;
> +    int ret;
> +
> +    if (!virtio_gpu_hostmem_enabled(b->conf)) {
> +        return -EOPNOTSUPP;
> +    }
> +
> +    ret = virgl_renderer_resource_map(res->resource_id, &data, &size);
> +    if (ret) {
> +        return -ret;
> +    }
> +
> +    res->mr = g_new0(MemoryRegion, 1);
> +    memory_region_init_ram_ptr(res->mr, OBJECT(res->mr), "blob",
> +                               size, data);
> +    memory_region_add_subregion(&b->hostmem, offset, res->mr);
> +    memory_region_set_enabled(res->mr, true);
> +
> +    return 0;
> +}
> +
> +static void
> +virtio_gpu_virgl_unmap_resource_blob(VirtIOGPU *g,
> +                                     struct virtio_gpu_simple_resource *res)
> +{
> +    VirtIOGPUBase *b = VIRTIO_GPU_BASE(g);
> +
> +    if (!res->mr) {
> +        return;
> +    }
> +
> +    memory_region_set_enabled(res->mr, false);
> +    memory_region_del_subregion(&b->hostmem, res->mr);
> +
> +    /* memory region owns res->mr object and frees it when mr is released */
> +    res->mr = NULL;
> +
> +    virgl_renderer_resource_unmap(res->resource_id);

Hi,

First, thanks for keeping working on this.

This patch has some changes since the previous version, but it is still 
vulnerable to the race condition pointed out. The memory region is 
asynchronously unmapped from the guest address space, but the backing 
memory on the host address space is unmapped synchronously before that. 
This results in use-after-free. The whole unmapping operation needs to 
be implemented in an asynchronous manner.

Regards,
Akihiko Odaki

> +}
> +#endif /* HAVE_VIRGL_RESOURCE_BLOB */
> +
>   static void virgl_cmd_create_resource_2d(VirtIOGPU *g,
>                                            struct virtio_gpu_ctrl_command *cmd)
>   {
> @@ -145,6 +194,10 @@ static void virgl_cmd_resource_unref(VirtIOGPU *g,
>           return;
>       }
>   
> +#ifdef HAVE_VIRGL_RESOURCE_BLOB
> +    virtio_gpu_virgl_unmap_resource_blob(g, res);
> +#endif
> +
>       virgl_renderer_resource_detach_iov(unref.resource_id,
>                                          &res_iovs,
>                                          &num_iovs);
> @@ -495,6 +548,140 @@ static void virgl_cmd_get_capset(VirtIOGPU *g,
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
> +    if (!res->mr) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource already unmapped %d\n",
> +                      __func__, ublob.resource_id);
> +        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
> +        return;
> +    }
> +
> +    virtio_gpu_virgl_unmap_resource_blob(g, res);
> +}
> +
>   static void virgl_cmd_set_scanout_blob(VirtIOGPU *g,
>                                          struct virtio_gpu_ctrl_command *cmd)
>   {
> @@ -661,6 +848,15 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
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
> index 1e57a53d346c..e6e09f4bf8da 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -1478,10 +1478,12 @@ void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
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
> index 44c676c3ca4a..f3681476eaf6 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -60,6 +60,7 @@ struct virtio_gpu_simple_resource {
>       void *blob;
>       int dmabuf_fd;
>       uint8_t *remapped;
> +    MemoryRegion *mr;
>   
>       QTAILQ_ENTRY(virtio_gpu_simple_resource) next;
>   };

