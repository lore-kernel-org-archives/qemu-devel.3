Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4361C4345F
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Apr 2024 06:58:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0bzr-00010f-Nj; Sat, 27 Apr 2024 02:57:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s0bzp-0000ya-1R
 for qemu-devel@nongnu.org; Sat, 27 Apr 2024 02:57:17 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s0bzm-0007D0-Mj
 for qemu-devel@nongnu.org; Sat, 27 Apr 2024 02:57:16 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-5d8b519e438so2257274a12.1
 for <qemu-devel@nongnu.org>; Fri, 26 Apr 2024 23:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1714201033; x=1714805833;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=X2ngU3WsexHQ6kqJ09HLjnCYNG3VZMrCw4aa803Dprk=;
 b=phb/fmQGYFMPbKbUyH181vMKdRc83cQiNzLrVLeuvKo88taMJcuDmcD+05o95rI2IL
 1XKJHyE3FojwoORnvVRIuMKbmSCTgo9zYV3t6pCdKvN/11FlB1yCOTWyhNN4Qd8rz/6p
 trH7h1gDmlPIPzMk1K5pcbosRA3pwMLfhfeDg0eLUjAuNVimZGM1fX9CQvdwfCAAb12u
 Vs8xd1N3cIirwyT5KxyMic1E71PIqF/7t6ruYfctnZvB3mSqCkt+OqTDFGFtnuJR/N2u
 M5Bzy9Ty82ZtEkPIar3Hx8zFOCyp7NlMAT9CvpNNqmGMvg+PvTZoVEHoZCdO2qLqiQJK
 Cn8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714201033; x=1714805833;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X2ngU3WsexHQ6kqJ09HLjnCYNG3VZMrCw4aa803Dprk=;
 b=NNl9DPQpm1zYZKG/4k1+w0BeXLS1ntKnTUPBh1JZkck0UKC6JpfV+Vf334TB4PXdle
 mh1I3NrQm5J6/zXta2Z6GB9MKUWI5AbVvwOWk/8TmoyHixm5DgQ3aSI2Kw8QMjN/zC9m
 32DMqhN5M5Q92gARytlmH8YzkXT6nSeeGbj3fwEqWJgWy8rfcdatOh+aeNa9tInN7WO4
 xmEcHKT1VEw0i7Cb2oXvhfvaj75FkUgiwX+RYdMfU6xOkVwUfvhrUbLSTJdDc52g9Roq
 Q2V0GW6maE/UkY1zq7T6LBKeuUzUUgDKwpdiV2kgc2cfOavohgdFrcCwR8xPJGhDy/PF
 Q++g==
X-Gm-Message-State: AOJu0Yy40mgKulwxlJmWr6Y8PzYGgOHW177MwcUi5tWXxWVDaCOCQgNb
 04dT1vSmBGGDnO0urx7GOXgPIeux6rsxivgHTCvGPB+dDEV1CNnjI7AVZ+Af1SA=
X-Google-Smtp-Source: AGHT+IEwcrUIgkA2xZbZqinBzKNkAVAD+jwS9C2u5zE9PxNAxulq322DZ+Gvk4wdpYonE3XVDbEtZQ==
X-Received: by 2002:a05:6a20:1005:b0:1aa:6613:2387 with SMTP id
 gs5-20020a056a20100500b001aa66132387mr5163896pzc.47.1714201033164; 
 Fri, 26 Apr 2024 23:57:13 -0700 (PDT)
Received: from [157.82.202.162] ([157.82.202.162])
 by smtp.gmail.com with ESMTPSA id
 f3-20020a170902684300b001eb2eac7012sm1430655pln.138.2024.04.26.23.57.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Apr 2024 23:57:12 -0700 (PDT)
Message-ID: <9b155a47-87ac-4395-84ba-2a31b16a2e56@daynix.com>
Date: Sat, 27 Apr 2024 15:57:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 07/11] virtio-gpu: Handle resource blob commands
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
References: <20240425154539.2680550-1-dmitry.osipenko@collabora.com>
 <20240425154539.2680550-8-dmitry.osipenko@collabora.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240425154539.2680550-8-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::52d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52d.google.com
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

On 2024/04/26 0:45, Dmitry Osipenko wrote:
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
>   hw/display/virtio-gpu-virgl.c | 268 ++++++++++++++++++++++++++++++++++
>   hw/display/virtio-gpu.c       |   4 +-
>   2 files changed, 271 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index 0feaa9f2c52e..73d4acbf1777 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -26,6 +26,8 @@
>   
>   struct virtio_gpu_virgl_resource {
>       struct virtio_gpu_simple_resource base;
> +    bool async_unmap_in_progress;

Why is this flag needed?

> +    MemoryRegion *mr;
>   };
>   
>   static struct virtio_gpu_virgl_resource *
> @@ -49,6 +51,120 @@ virgl_get_egl_display(G_GNUC_UNUSED void *cookie)
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
> +static void virtio_gpu_virgl_resume_cmdq(void *opaque)
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
> +
> +    vmr = container_of(mr, struct virtio_gpu_virgl_hostmem_region, mr);
> +    vmr->res->async_unmap_in_progress = false;
> +
> +    b = VIRTIO_GPU_BASE(vmr->g);
> +    b->renderer_blocked--;
> +
> +    /*
> +     * memory_region_unref() may be executed from RCU thread context, while
> +     * virglrenderer works only on the main-loop thread that's holding GL
> +     * context.
> +     */
> +    aio_bh_schedule_oneshot(qemu_get_aio_context(),
> +                            virtio_gpu_virgl_resume_cmdq, vmr->g);

Use aio_bh_new() and qemu_bh_schedule() instead to save one-time bottom 
half allocation.

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
> +        return -EOPNOTSUPP; > +    }
> +
> +    ret = virgl_renderer_resource_map(res->base.resource_id, &data, &size);
> +    if (ret) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: failed to map virgl resource\n",
> +                      __func__);

Print strerror(-ret) here instead as printing strerror(EOPNOTSUPP) helps 
little when !virtio_gpu_hostmem_enabled(b->conf).

> +        return -ret;
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
> +                                     struct virtio_gpu_virgl_resource *res)
> +{
> +    VirtIOGPUBase *b = VIRTIO_GPU_BASE(g);
> +
> +    if (!res->async_unmap_in_progress && res->mr) {
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
> +    if (res->async_unmap_in_progress) {
> +        return false;
> +    }
> +
> +    virgl_renderer_resource_unmap(res->base.resource_id);
> +
> +    return true;
> +}
> +#endif /* HAVE_VIRGL_RESOURCE_BLOB */
> +
>   static void virgl_cmd_create_resource_2d(VirtIOGPU *g,
>                                            struct virtio_gpu_ctrl_command *cmd)
>   {
> @@ -162,6 +278,14 @@ static void virgl_cmd_resource_unref(VirtIOGPU *g,
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
> @@ -512,6 +636,141 @@ static void virgl_cmd_get_capset(VirtIOGPU *g,
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
> +            cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
> +            return;
> +        }
> +    }
> +
> +    QTAILQ_INSERT_HEAD(&g->reslist, &res->base, next);
> +
> +    virgl_args.res_handle = cblob.resource_id;
> +    virgl_args.ctx_id = cblob.hdr.ctx_id;
> +    virgl_args.blob_mem = cblob.blob_mem;
> +    virgl_args.blob_id = cblob.blob_id;
> +    virgl_args.blob_flags = cblob.blob_flags;
> +    virgl_args.size = cblob.size;
> +    virgl_args.iovecs = res->base.iov;
> +    virgl_args.num_iovs = res->base.iov_cnt;
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
> +    struct virtio_gpu_virgl_resource *res;
> +    struct virtio_gpu_resp_map_info resp;
> +    int ret;
> +
> +    VIRTIO_GPU_FILL_CMD(mblob);
> +    virtio_gpu_map_blob_bswap(&mblob);
> +
> +    res = virtio_gpu_virgl_find_resource(g, mblob.resource_id);
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

I think it's better to use VIRTIO_GPU_RESP_ERR_UNSPEC here; we don't 
know if the error is out-of-memory or something else.

