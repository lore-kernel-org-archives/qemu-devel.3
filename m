Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABE90C04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 03:51:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s8u2j-0008OL-Sy; Sun, 19 May 2024 23:50:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s8u2f-0008O2-8n
 for qemu-devel@nongnu.org; Sun, 19 May 2024 23:50:29 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s8u2c-0000kU-QA
 for qemu-devel@nongnu.org; Sun, 19 May 2024 23:50:28 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1ec69e3dbcfso63562425ad.0
 for <qemu-devel@nongnu.org>; Sun, 19 May 2024 20:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1716177024; x=1716781824;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ztT1I6FJZDuXXXyXDnBR21efu0cDZhuXU6/zf8RyCPY=;
 b=mqqgipkK41/BYnAvy9EGzO60AWhEdxDpNp0N3Y7b2zgD+MAYakBLAw7Qa8M64deUtG
 Cw36/Gb94hscifO9XP3rj1Ibbf9mq1sIhrtwwF5ini3XV6yIIWPrieUaA98lZrYRjO0I
 ATOhkQO/QGiN5Qq3QQde+gJqwX9ztIY7yWAcWqS0U+d0J1bIqtIvasop4y285oVExrxZ
 ehu2BSFcwDfYCUyQ57CTy2FYE5xeH8hKUmsuNImRZ/cCSDTJGp2h7q2JYoTbllGjJgNz
 T9fkalBlLIlFyCvUtQ9jR1jsFuoQWDQEQRVO5Zr+dfE7N2H9Vcm4z8l9zD6fN3FS1I6v
 4tcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716177024; x=1716781824;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ztT1I6FJZDuXXXyXDnBR21efu0cDZhuXU6/zf8RyCPY=;
 b=MiSprnrIWtz9OiLq66CctWwtCo2rYZ3ZnVmOqQBVarzBA5I2I8A7NKU53Rd66Rrd/y
 7Ezrb8rAsnRoqTg764Ny0LEd++cRvwPzQw6wpy6x93nDiWqUDoToM5HJu/xVoMk5y9eR
 A19STSfWyYRmbr1GFs1ianRReDFpW89iv8mwijBi6Se0e5h1l0PKg0lKaMwe/bikekNa
 mRo86Cj+tkcfTKxqCCax6kZpNTY6TruJDWnbiuyLJmRQdGo+7lMrQ5N5D0TJLInyMQFQ
 XmAp+MUwTpGn4aC45ESenhJ5x/GsOwgGWngtSTZh1ocgnayHBDloSm2PbkLYHNhodorG
 esFQ==
X-Gm-Message-State: AOJu0Yxs0pgg+xAXh4xertbc1jN1EZwRbBMoVUPAJ2ZtdvjpSYw7txA8
 1WOp/uHvdU3pFc3TPBNphZSZMTUjbJS3AfEV6w5uFzkhCkv31ehVlrdR6M/LkTA=
X-Google-Smtp-Source: AGHT+IHeG64CHS396K0u1P9GkXPDK8ZsbF8Py1GSraCOv2aSm5vch1tAOeV+Rn1E4Moe1rJ8usNKDA==
X-Received: by 2002:a05:6a20:3c8b:b0:1b0:1ce1:e7ac with SMTP id
 adf61e73a8af0-1b01ce1e851mr14549752637.53.1716177023759; 
 Sun, 19 May 2024 20:50:23 -0700 (PDT)
Received: from [157.82.204.135] ([157.82.204.135])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2bd671e1b56sm2961938a91.0.2024.05.19.20.50.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 19 May 2024 20:50:23 -0700 (PDT)
Message-ID: <a9879055-ede1-476c-b40a-7baf5f77843c@daynix.com>
Date: Mon, 20 May 2024 12:50:17 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 09/13] virtio-gpu: Handle resource blob commands
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Huang Rui <ray.huang@amd.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
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
References: <20240519212712.2605419-1-dmitry.osipenko@collabora.com>
 <20240519212712.2605419-10-dmitry.osipenko@collabora.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240519212712.2605419-10-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62c.google.com
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

On 2024/05/20 6:27, Dmitry Osipenko wrote:
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
>   hw/display/virtio-gpu-virgl.c  | 310 ++++++++++++++++++++++++++++++++-
>   hw/display/virtio-gpu.c        |   4 +-
>   include/hw/virtio/virtio-gpu.h |   2 +
>   3 files changed, 312 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index 7d4d2882a5af..63a5a983aad6 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -26,6 +26,18 @@
>   
>   struct virtio_gpu_virgl_resource {
>       struct virtio_gpu_simple_resource base;
> +    MemoryRegion *mr;
> +
> +    /*
> +     * Used by virgl_cmd_resource_unref() to know whether async
> +     * unmapping has been started.  Blob can be both mapped/unmapped
> +     * on unref and we shouldn't unmap blob that wasn't mapped in the
> +     * first place because it's a error condition.  This flag prevents
> +     * performing step 3 of the async unmapping process described in the
> +     * comment to virtio_gpu_virgl_async_unmap_resource_blob() if blob
> +     * wasn't mapped in the first place on unref.
> +     */
> +    bool async_unmap_in_progress;

I suggest adding a field that tells if mr is deleted to 
virtio_gpu_virgl_hostmem_region instead to minimize the size of 
virtio_gpu_virgl_resource.

>   };
>   
>   static struct virtio_gpu_virgl_resource *
> @@ -49,6 +61,128 @@ virgl_get_egl_display(G_GNUC_UNUSED void *cookie)
>   }
>   #endif
>   
> +#ifdef HAVE_VIRGL_RESOURCE_BLOB
> +struct virtio_gpu_virgl_hostmem_region {
> +    MemoryRegion mr;
> +    struct VirtIOGPU *g;
> +    struct virtio_gpu_virgl_resource *res;
> +};
> +
> +static void virtio_gpu_virgl_resume_cmdq_bh(void *opaque)
> +{
> +    VirtIOGPU *g = opaque;
> +
> +    virtio_gpu_process_cmdq(g);
> +}
> +
> +static void virtio_gpu_virgl_hostmem_region_free(void *obj)
> +{
> +    MemoryRegion *mr = MEMORY_REGION(obj);
> +    struct virtio_gpu_virgl_hostmem_region *vmr;
> +    VirtIOGPUBase *b;
> +    VirtIOGPUGL *gl;
> +
> +    vmr = container_of(mr, struct virtio_gpu_virgl_hostmem_region, mr);
> +    vmr->res->mr = NULL;
> +
> +    b = VIRTIO_GPU_BASE(vmr->g);
> +    b->renderer_blocked--;
> +
> +    /*
> +     * memory_region_unref() is executed from RCU thread context, while
> +     * virglrenderer works only on the main-loop thread that's holding GL
> +     * context.
> +     */
> +    gl = VIRTIO_GPU_GL(vmr->g);
> +    qemu_bh_schedule(gl->cmdq_resume_bh);
> +    g_free(vmr);
> +}
> +
> +static int
> +virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
> +                                   struct virtio_gpu_virgl_resource *res,
> +                                   uint64_t offset)
> +{
> +    struct virtio_gpu_virgl_hostmem_region *vmr;
> +    VirtIOGPUBase *b = VIRTIO_GPU_BASE(g);
> +    MemoryRegion *mr;
> +    uint64_t size;
> +    void *data;
> +    int ret;
> +
> +    if (!virtio_gpu_hostmem_enabled(b->conf)) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: hostmem disabled\n", __func__);
> +        return -EOPNOTSUPP;
> +    }
> +
> +    ret = virgl_renderer_resource_map(res->base.resource_id, &data, &size);
> +    if (ret) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: failed to map virgl resource: %s\n",
> +                      __func__, strerror(-ret));
> +        return ret;
> +    }
> +
> +    vmr = g_new0(struct virtio_gpu_virgl_hostmem_region, 1);
> +    vmr->res = res;
> +    vmr->g = g;
> +
> +    mr = &vmr->mr;
> +    memory_region_init_ram_ptr(mr, OBJECT(mr), "blob", size, data);
> +    memory_region_add_subregion(&b->hostmem, offset, mr);
> +    memory_region_set_enabled(mr, true);
> +
> +    /*
> +     * MR could outlive the resource if MR's reference is held outside of
> +     * virtio-gpu. In order to prevent unmapping resource while MR is alive,
> +     * and thus, making the data pointer invalid, we will block virtio-gpu
> +     * command processing until MR is fully unreferenced and freed.
> +     */
> +    OBJECT(mr)->free = virtio_gpu_virgl_hostmem_region_free;
> +
> +    res->mr = mr;
> +
> +    return 0;
> +}
> +
> +static int
> +virtio_gpu_virgl_async_unmap_resource_blob(VirtIOGPU *g,
> +                                           struct virtio_gpu_virgl_resource *res)
> +{
> +    VirtIOGPUBase *b = VIRTIO_GPU_BASE(g);
> +    MemoryRegion *mr = res->mr;
> +    int ret;
> +
> +    /*
> +     * Perform async unmapping in 3 steps:
> +     *
> +     * 1. Begin async unmapping with memory_region_del_subregion()
> +     *    and suspend/block cmd processing.
> +     * 2. Wait for res->mr to be freed and cmd processing resumed
> +     *    asynchronously by virtio_gpu_virgl_hostmem_region_free().
> +     * 3. Finish the unmapping with final virgl_renderer_resource_unmap().
> +     */
> +    if (mr) {
> +        /* render will be unblocked once MR is freed */
> +        b->renderer_blocked++;
> +
> +        /* memory region owns self res->mr object and frees it by itself */
> +        memory_region_set_enabled(mr, false);
> +        memory_region_del_subregion(&b->hostmem, mr);
> +        object_unparent(OBJECT(mr));
> +    } else {
> +        ret = virgl_renderer_resource_unmap(res->base.resource_id);
> +        if (ret) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: failed to unmap virgl resource: %s\n",
> +                          __func__, strerror(-ret));
> +            return ret;
> +        }
> +    }
> +
> +    return 0;
> +}
> +#endif /* HAVE_VIRGL_RESOURCE_BLOB */
> +
>   static void virgl_cmd_create_resource_2d(VirtIOGPU *g,
>                                            struct virtio_gpu_ctrl_command *cmd)
>   {
> @@ -146,12 +280,14 @@ static void virgl_cmd_create_resource_3d(VirtIOGPU *g,
>   }
>   
>   static void virgl_cmd_resource_unref(VirtIOGPU *g,
> -                                     struct virtio_gpu_ctrl_command *cmd)
> +                                     struct virtio_gpu_ctrl_command *cmd,
> +                                     bool *cmd_suspended)
>   {
>       struct virtio_gpu_resource_unref unref;
>       struct virtio_gpu_virgl_resource *res;
>       struct iovec *res_iovs = NULL;
>       int num_iovs = 0;
> +    int ret;
>   
>       VIRTIO_GPU_FILL_CMD(unref);
>       trace_virtio_gpu_cmd_res_unref(unref.resource_id);
> @@ -164,6 +300,22 @@ static void virgl_cmd_resource_unref(VirtIOGPU *g,
>           return;
>       }
>   
> +    if (res->mr || res->async_unmap_in_progress) {
> +        ret = virtio_gpu_virgl_async_unmap_resource_blob(g, res);
> +        if (ret) {
> +            cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
> +            return;
> +        }
> +
> +        if (res->mr) {

I suggest letting virtio_gpu_virgl_async_unmap_resource_blob() having a 
"suspended" parameter since we have a similar pattern also in 
virgl_cmd_resource_unmap_blob().

You may also remove "async" from the name of 
virtio_gpu_virgl_async_unmap_resource_blob() because:
- It's obvious it can be asynchronous if there is a "suspended" 
parameter; asynchronous if it becomes true.
- It synchronously completes the operation if the memory region is 
already deleted. Again, it's obvious if there is a "suspended" 
parameter; synchrouns if it becomes false.
- You don't name virgl_cmd_resource_unref() like 
virgl_cmd_resource_async_unref().

> +            res->async_unmap_in_progress = true;
> +            *cmd_suspended = true;
> +            return;
> +        } else {
> +            res->async_unmap_in_progress = false;
> +        }
> +    }
> +
>       virgl_renderer_resource_detach_iov(unref.resource_id,
>                                          &res_iovs,
>                                          &num_iovs);
> @@ -514,6 +666,137 @@ static void virgl_cmd_get_capset(VirtIOGPU *g,
>   }
>   
>   #ifdef HAVE_VIRGL_RESOURCE_BLOB
> +static void virgl_cmd_resource_create_blob(VirtIOGPU *g,
> +                                           struct virtio_gpu_ctrl_command *cmd)
> +{
> +    struct virgl_renderer_resource_create_blob_args virgl_args = { 0 };
> +    struct virtio_gpu_resource_create_blob cblob;
> +    struct virtio_gpu_virgl_resource *res;
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
> +    res = virtio_gpu_virgl_find_resource(g, cblob.resource_id);
> +    if (res) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource already exists %d\n",
> +                      __func__, cblob.resource_id);
> +        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
> +        return;
> +    }
> +
> +    res = g_new0(struct virtio_gpu_virgl_resource, 1);
> +    res->base.resource_id = cblob.resource_id;
> +    res->base.blob_size = cblob.size;
> +    res->base.dmabuf_fd = -1;
> +
> +    if (cblob.blob_mem != VIRTIO_GPU_BLOB_MEM_HOST3D) {
> +        ret = virtio_gpu_create_mapping_iov(g, cblob.nr_entries, sizeof(cblob),
> +                                            cmd, &res->base.addrs,
> +                                            &res->base.iov, &res->base.iov_cnt);
> +        if (!ret) {
> +            g_free(res);

Use g_autofree instead of writing duplicate g_free() calls. See 
docs/devel/style.rst for details.

