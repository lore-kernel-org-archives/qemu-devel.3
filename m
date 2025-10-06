Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6084FCAC5B8
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 16:02:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5ndX-0001PE-Vg; Mon, 06 Oct 2025 12:00:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v5ndB-0001FZ-8p
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 12:00:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v5nd2-0001ll-4b
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 12:00:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759766394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/90QR0B/R7Wk0AGDH5In3uWBhb0POMd1KLce7hbV8ns=;
 b=Rsrr28fdeefgf7FheoAWDg/sGw0/jto/qoL/CvAHzG8FWyQOIkemvi1inANOoAzb4rSzDa
 119UDl/703EWAqhI+Vm5x7uDwm+6iGR/1D+9QZcLFPpT0eeaUXQ96PHN85rCZVOqC2BZ7e
 5IU2xsFGn+fcNAQieligoL0xVJ7/XVk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-sEfnadyOMlSWejoPN5DF5A-1; Mon, 06 Oct 2025 11:59:53 -0400
X-MC-Unique: sEfnadyOMlSWejoPN5DF5A-1
X-Mimecast-MFC-AGG-ID: sEfnadyOMlSWejoPN5DF5A_1759766392
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-46e3d9bf9e1so22629345e9.1
 for <qemu-devel@nongnu.org>; Mon, 06 Oct 2025 08:59:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759766392; x=1760371192;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/90QR0B/R7Wk0AGDH5In3uWBhb0POMd1KLce7hbV8ns=;
 b=WXNCARiTPrlEzUYfBwCv14LID7kH9yLHY7Une6GrCeeYFcTKCe40JNEgihh3bgKAwK
 5r/sxfHLjUM/u6JNMtZmxdU3Z0zHGnJEOsY2Z6WqpfDb6R4Ghi/T4SxPattO0URwzyy6
 bnvvDiyF6PJZyev1gECzCCjCN26Ew3WHTrxe89er41sO6MzIeyFXGCJxjXVp9cCIvcFJ
 aU5ZccGT4uCEgF3I0ujTf2+ZMWFeQv/b34MbD9C/fnAIk3v0XkIHQvsxjmjbq9c9zYh0
 O616JfdLNLecWpFS0EBV4SO3QRF/x5NhnVgMelqJ0yNFaLEHg0W/iT9oweuBhYB3yfbc
 2Z7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXH2LSjoTiyGCJUL2R0tfolLTmO76u1Zm7L4hxYLWWSbzWbX+o0LDJH73c0CLoq705TAsyxh38NZCcM@nongnu.org
X-Gm-Message-State: AOJu0Yw3l5bBdCaC0JCSSw9oppUxPwfUSpau7gRJxVFD/x7io5UUAV0K
 yfzY9y3MZhfO8oHgF1qCUBUX6SWXoEGX4uOtLPL84J3i1JW/QsbLgnxwxqmwMDimef2u+pIGNje
 y/GS7fvc0bK5aEllrBHSuoGHZZWwYcHmJfsB+Jsat/LDe/XfSOg/pjn8C
X-Gm-Gg: ASbGncvKNTsF/WXzW4BHiBQlYv0IP7RXNzUmo7QIciimef/thjA0LL69UzEqnW26MrN
 2Wb3xnqkTKVFE7SWIADTjAX1J2dlzE+imswPZSg2QIEmQEBHIl8PbR3pyQ0tLljpTkKv1D8kI1+
 RFamcXdtw3TbjkreKt0iAIO6jbN9YL1xfnKuafKMayxcnrKFSJhUIkvim1Z7ozzr3DbyJkfNn5U
 jusg6rX/LYGhjuS9+iuqEtfNGpGjWfYgjl+uKk/T8uYg1HIwSwIrTHqVFyCGPf2sqsYFKj7hYqN
 YM2hTrkS//4AjuVjYOZQFew7hVERGaDYOgecIh5WwBZARBTeP2OsXYSCh7sda7VxdR9eCdZPmXX
 C1o9Xp+hm
X-Received: by 2002:a05:600c:4510:b0:461:8bdb:e8 with SMTP id
 5b1f17b1804b1-46e7114ea07mr108101505e9.30.1759766391738; 
 Mon, 06 Oct 2025 08:59:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSzDZ/h4B14dDp/zhj8+RA8AncfddvenuCw737xJ5jswvGO5RKwYBKbrssNNhYTcOnSPt4GA==
X-Received: by 2002:a05:600c:4510:b0:461:8bdb:e8 with SMTP id
 5b1f17b1804b1-46e7114ea07mr108101205e9.30.1759766391283; 
 Mon, 06 Oct 2025 08:59:51 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8f4abcsm21260760f8f.53.2025.10.06.08.59.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Oct 2025 08:59:50 -0700 (PDT)
Message-ID: <cd0b246e-7f75-4df6-b1e7-8ae41834f6d1@redhat.com>
Date: Mon, 6 Oct 2025 17:59:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 7/7] virtio-gpu-udmabuf: Create dmabuf for blobs
 associated with VFIO devices
To: Vivek Kasireddy <vivek.kasireddy@intel.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
References: <20251003234138.85820-1-vivek.kasireddy@intel.com>
 <20251003234138.85820-8-vivek.kasireddy@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20251003234138.85820-8-vivek.kasireddy@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/4/25 01:36, Vivek Kasireddy wrote:
> In addition to memfd, a blob resource can also have its backing
> storage in a VFIO device region. Therefore, we first need to figure
> out if the blob is backed by a VFIO device region or a memfd before
> we can call the right API to get a dmabuf fd created.
> 
> So, once we have the ramblock and the associated mr, we rely on
> memory_region_is_ram_device() to tell us where the backing storage
> is located. If the blob resource is VFIO backed, we try to find the
> right VFIO device that contains the blob and then invoke the API
> vfio_device_create_dmabuf().
> 
> Note that in virtio_gpu_remap_udmabuf(), we first try to test if
> the VFIO dmabuf exporter supports mmap or not. If it doesn't, we
> use the VFIO device fd directly to create the CPU mapping.
> 
> Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
> Cc: Alex Bennée <alex.bennee@linaro.org>
> Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> ---
>   hw/display/Kconfig              |   5 ++
>   hw/display/virtio-gpu-udmabuf.c | 143 ++++++++++++++++++++++++++++++--
>   2 files changed, 141 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/display/Kconfig b/hw/display/Kconfig
> index 1e95ab28ef..0d090f25f5 100644
> --- a/hw/display/Kconfig
> +++ b/hw/display/Kconfig
> @@ -106,6 +106,11 @@ config VIRTIO_VGA
>       depends on VIRTIO_PCI
>       select VGA
>   
> +config VIRTIO_GPU_VFIO_BLOB
> +    bool
> +    default y
> +    depends on VFIO
> +
>   config VHOST_USER_GPU
>       bool
>       default y
> diff --git a/hw/display/virtio-gpu-udmabuf.c b/hw/display/virtio-gpu-udmabuf.c
> index d804f321aa..bd06b4f300 100644
> --- a/hw/display/virtio-gpu-udmabuf.c
> +++ b/hw/display/virtio-gpu-udmabuf.c
> @@ -18,6 +18,7 @@
>   #include "ui/console.h"
>   #include "hw/virtio/virtio-gpu.h"
>   #include "hw/virtio/virtio-gpu-pixman.h"
> +#include "hw/vfio/vfio-device.h"
>   #include "trace.h"
>   #include "system/ramblock.h"
>   #include "system/hostmem.h"
> @@ -27,6 +28,33 @@
>   #include "standard-headers/linux/udmabuf.h"
>   #include "standard-headers/drm/drm_fourcc.h"
>   
> +static void vfio_create_dmabuf(VFIODevice *vdev,
> +                               struct virtio_gpu_simple_resource *res)
> +{
> +#if defined(VIRTIO_GPU_VFIO_BLOB)
> +    res->dmabuf_fd = vfio_device_create_dmabuf(vdev, res->iov, res->iov_cnt);

I didn't realize an fd was returned until this patch. I'd suggest
renaming vfio_device_create_dmabuf() to vfio_device_create_dmabuf_fd(),
or something explicit IMO.

> +    if (res->dmabuf_fd < 0) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: VFIO_DEVICE_FEATURE_DMA_BUF: %s\n",
> +                      __func__, strerror(errno));
> +    }
> +#endif
> +}
> +
> +static VFIODevice *vfio_device_lookup(MemoryRegion *mr)
> +{
> +#if defined(VIRTIO_GPU_VFIO_BLOB)
> +    VFIODevice *vdev;
> +
> +    QLIST_FOREACH(vdev, &vfio_device_list, next) {
Hmm, I'm not sure we want to expose the VFIOdevice list to other
subsystems. I understand the need, and it's faster than iterating
over QOM devices, but I’d prefer that an API be provided for this
purpose.

I missed how much vfio_device_list has proliferated. Needs a check.


> +        if (vdev->dev == mr->dev) {
> +            return vdev;
> +        }
> +    }
> +#endif
> +    return NULL;
> +}
> +
>   static void virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource *res)
>   {
>       struct udmabuf_create_list *list;
> @@ -68,11 +96,73 @@ static void virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource *res)
>       g_free(list);
>   }
>   
> -static void virtio_gpu_remap_udmabuf(struct virtio_gpu_simple_resource *res)
> +static void *vfio_dmabuf_mmap(struct virtio_gpu_simple_resource *res,
> +                              VFIODevice *vdev)
> +{
> +    struct vfio_region_info *info;
> +    ram_addr_t offset, len = 0;
> +    void *map, *submap;
> +    int i, ret = -1;
> +    RAMBlock *rb;
> +
> +    /*
> +     * We first reserve a contiguous chunk of address space for the entire
> +     * dmabuf, then replace it with smaller mappings that correspond to the
> +     * individual segments of the dmabuf.
> +     */
> +    map = mmap(NULL, res->blob_size, PROT_READ, MAP_SHARED, vdev->fd, 0);
> +    if (map == MAP_FAILED) {
> +        return map;
> +    }
> +
> +    for (i = 0; i < res->iov_cnt; i++) {
> +        rcu_read_lock();
> +        rb = qemu_ram_block_from_host(res->iov[i].iov_base, false, &offset);
> +        rcu_read_unlock();
> +
> +        if (!rb) {
> +            goto err;
> +        }
> +
> +#if defined(VIRTIO_GPU_VFIO_BLOB)
> +        ret = vfio_get_region_index_from_mr(rb->mr);
> +        if (ret < 0) {
> +            goto err;
> +        }
> +
> +        ret = vfio_device_get_region_info(vdev, ret, &info);
> +#endif
> +        if (ret < 0) {
> +            goto err;
> +        }

"hmm" again. Not this patch fault but we lack proper documentation
for the VFIO API. Something to work on. Since this patch is using
vfio_device_get_region_info() could you please add documentation
for it ?


Thanks,

C.



> +        submap = mmap(map + len, res->iov[i].iov_len, PROT_READ,
> +                      MAP_SHARED | MAP_FIXED, vdev->fd,
> +                      info->offset + offset);
> +        if (submap == MAP_FAILED) {
> +            goto err;
> +        }
> +
> +        len += res->iov[i].iov_len;
> +    }
> +    return map;
> +err:
> +    munmap(map, res->blob_size);
> +    return MAP_FAILED;
> +}
> +
> +static void virtio_gpu_remap_udmabuf(struct virtio_gpu_simple_resource *res,
> +                                     VFIODevice *vdev)
>   {
>       res->remapped = mmap(NULL, res->blob_size, PROT_READ,
>                            MAP_SHARED, res->dmabuf_fd, 0);
>       if (res->remapped == MAP_FAILED) {
> +        if (vdev) {
> +            res->remapped = vfio_dmabuf_mmap(res, vdev);
> +            if (res->remapped != MAP_FAILED) {
> +                return;
> +            }
> +        }
>           warn_report("%s: dmabuf mmap failed: %s", __func__,
>                       strerror(errno));
>           res->remapped = NULL;
> @@ -130,18 +220,59 @@ bool virtio_gpu_have_udmabuf(void)
>   
>   void virtio_gpu_init_udmabuf(struct virtio_gpu_simple_resource *res)
>   {
> +    VFIODevice *vdev = NULL;
>       void *pdata = NULL;
> +    ram_addr_t offset;
> +    RAMBlock *rb;
>   
>       res->dmabuf_fd = -1;
>       if (res->iov_cnt == 1 &&
>           res->iov[0].iov_len < 4096) {
>           pdata = res->iov[0].iov_base;
>       } else {
> -        virtio_gpu_create_udmabuf(res);
> -        if (res->dmabuf_fd < 0) {
> +        rcu_read_lock();
> +        rb = qemu_ram_block_from_host(res->iov[0].iov_base, false, &offset);
> +        rcu_read_unlock();
> +
> +        if (!rb) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: Could not find ram block for host address\n",
> +                          __func__);
>               return;
>           }
> -        virtio_gpu_remap_udmabuf(res);
> +
> +        if (memory_region_is_ram_device(rb->mr)) {
> +            vdev = vfio_device_lookup(rb->mr);
> +            if (!vdev) {
> +                qemu_log_mask(LOG_GUEST_ERROR,
> +                              "%s: Could not find device to create dmabuf\n",
> +                              __func__);
> +                return;
> +            }
> +
> +            vfio_create_dmabuf(vdev, res);
> +            if (res->dmabuf_fd < 0) {
> +                qemu_log_mask(LOG_GUEST_ERROR,
> +                              "%s: Could not create dmabuf from vfio device\n",
> +                              __func__);
> +                return;
> +            }
> +        } else if (memory_region_is_ram(rb->mr) && virtio_gpu_have_udmabuf()) {
> +            virtio_gpu_create_udmabuf(res);
> +            if (res->dmabuf_fd < 0) {
> +                qemu_log_mask(LOG_GUEST_ERROR,
> +                              "%s: Could not create dmabuf from memfd\n",
> +                              __func__);
> +                return;
> +            }
> +        } else {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: memory region cannot be used to create dmabuf\n",
> +                          __func__);
> +            return;
> +        }
> +
> +        virtio_gpu_remap_udmabuf(res, vdev);
>           if (!res->remapped) {
>               return;
>           }
> @@ -153,9 +284,7 @@ void virtio_gpu_init_udmabuf(struct virtio_gpu_simple_resource *res)
>   
>   void virtio_gpu_fini_udmabuf(struct virtio_gpu_simple_resource *res)
>   {
> -    if (res->remapped) {
> -        virtio_gpu_destroy_udmabuf(res);
> -    }
> +    virtio_gpu_destroy_udmabuf(res);
>   }
>   
>   static void virtio_gpu_free_dmabuf(VirtIOGPU *g, VGPUDMABuf *dmabuf)


