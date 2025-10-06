Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A4DBCCA471
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 08:25:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5gW1-0007Uy-38; Mon, 06 Oct 2025 04:24:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v5gVz-0007Uo-Kx
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 04:24:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v5gVx-0001LA-NH
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 04:24:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759739050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=yDArku8s3wff9/dOWUcvttKiMz54w7q4Et4Av25fTfk=;
 b=QBmgBMoLq/WU/XS7+f9LE1uiFmRNH++NeFgueIT2frw6fZJaJIoygCqMi+2CLd0lUUZLqQ
 EvKXRVINFDm1RaVTuc4WWVOSatybMizVzl56C1JhI13PeYw8zUpbSc2sPN935CKFj1ARtR
 iffp8SC2NoJ4P+oAlRTics1vYjY/Sjk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-YuH4HdxrMSaoO-mGV5T8iA-1; Mon, 06 Oct 2025 04:24:08 -0400
X-MC-Unique: YuH4HdxrMSaoO-mGV5T8iA-1
X-Mimecast-MFC-AGG-ID: YuH4HdxrMSaoO-mGV5T8iA_1759739048
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3ee12ab7f33so2468058f8f.2
 for <qemu-devel@nongnu.org>; Mon, 06 Oct 2025 01:24:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759739048; x=1760343848;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yDArku8s3wff9/dOWUcvttKiMz54w7q4Et4Av25fTfk=;
 b=vupVOy5mhXBT9o4FMn12LjSjGg790X004HPUUVEh47rzQbCytWfCKePV5FNx9vILck
 gov1L0Ovw3aVc/kfThYUoixDvZQBvWORIERQJndj9ufl8oxPcPKtX+6cQesIwV3sAGi0
 a4SDNdYsBgZOfVwtwqt1O7smNR/T8J/WX8AmWObuwa693P+52K8Bb7aB8IIBz/V/XTra
 MC4+Eegu1iRCMdFmXpBF7Yit1ZJnpPE9lNsZa2VeP0r05xhTnEx7jpyxMPxS9okUz0P8
 Yoy31hXQWfr+N21CJEnyI1xWlBgmLPpDMICKhRhl0a+dqavSNpVSPrPLmC4P6j2rs7HM
 aAKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6C3/4sj8PE3cgWMuaZFKXkVi3AJfPbaF5nbhPx3wZDWio/+wzXs/U06RsEbs1vLw8hwOoDDcXKkCa@nongnu.org
X-Gm-Message-State: AOJu0YyoGg8JX/+63XzMaR7vOp0kgvYXWelOv1jBpuWqlXrrDuuqIpxw
 nLv3l6fiSYrmBRk3gMukpX37NyH1MTzYLBYNDqOzVnl8QIwOY1evNF59oaevNgIctl+i24aJLzP
 w91pwa0eVSn/JHhnDmsccqsOT3ELa5MZpThCczoI6/HWOzM0a2KexiLbi
X-Gm-Gg: ASbGncuqsVBRmel7fuBwDRmALtfOfNkHq9JZsTL0NEXTuxfYs6SgM1p/xXsFbLgBK7y
 HLtwSDdJ5e0AUXtb+v+Ov9RG3MAL7E1ZP3yg+ha4ZYbsFlur0y1NnQaPjo+je1qjfv8D+Bps7I+
 PDIEp31Ar5KRM8AW2wyeidhrbXXV+7BpX/isFkVjnXrJaYoI9IFh/eSB772JuBKSUu3Rt0GUHGg
 ydfTbzJGJn5ySkDJu2QQG7Pu3+1eA4OUa1XRF0LALtRTwji8uNrPvb+shPYvLaLRAEwGP9C6Ssi
 FcsGCoHPRMiCMTXPYKuG8ji4f4DWYzzMNLnvaaJkneShHJDEZUyD3jE71GbqmDU1OlR4RIYCMOG
 DTGK4GqYQ
X-Received: by 2002:a05:6000:180a:b0:425:7284:331f with SMTP id
 ffacd0b85a97d-425728434e7mr2911566f8f.0.1759739047601; 
 Mon, 06 Oct 2025 01:24:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFURPZjy88lCwuQR4Rg7DSsaZRuAKE+v7a4FFKUfCLA74m67gnX5i1TyTN/A3eW/FOM7SNDlA==
X-Received: by 2002:a05:6000:180a:b0:425:7284:331f with SMTP id
 ffacd0b85a97d-425728434e7mr2911548f8f.0.1759739047180; 
 Mon, 06 Oct 2025 01:24:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8a6b77sm19720721f8f.6.2025.10.06.01.24.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Oct 2025 01:24:06 -0700 (PDT)
Message-ID: <9f3e4af2-aa60-434b-8269-706696431882@redhat.com>
Date: Mon, 6 Oct 2025 10:24:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 6/7] vfio/device: Add support for
 VFIO_DEVICE_FEATURE_DMA_BUF
To: Vivek Kasireddy <vivek.kasireddy@intel.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>
References: <20251003234138.85820-1-vivek.kasireddy@intel.com>
 <20251003234138.85820-7-vivek.kasireddy@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20251003234138.85820-7-vivek.kasireddy@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.43,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hello Vivek,

On 10/4/25 01:35, Vivek Kasireddy wrote:
> In order to implement VFIO_DEVICE_FEATURE_DMA_BUF, we first need
> to identify the VFIO region and index the buffer (represented by
> iovec) belongs to and then translate its addresses to offsets
> within that region.
> 
> The qemu_ram_block_from_host() API gives us both the region and the
> offset info we need to populate the dma ranges in order to invoke
> this feature.
> 
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> ---
>   hw/vfio/device.c              | 43 +++++++++++++++++++++++++++++++++++
>   include/hw/vfio/vfio-device.h |  3 +++
>   2 files changed, 46 insertions(+)
> 
> diff --git a/hw/vfio/device.c b/hw/vfio/device.c
> index 64f8750389..49070929ac 100644
> --- a/hw/vfio/device.c
> +++ b/hw/vfio/device.c
> @@ -21,6 +21,7 @@
>   #include "qemu/osdep.h"
>   #include <sys/ioctl.h>
>   
> +#include "system/ramblock.h"
>   #include "hw/vfio/vfio-device.h"
>   #include "hw/vfio/pci.h"
>   #include "hw/hw.h"
> @@ -592,3 +593,45 @@ static VFIODeviceIOOps vfio_device_io_ops_ioctl = {
>       .region_read = vfio_device_io_region_read,
>       .region_write = vfio_device_io_region_write,
>   };
> +
> +int vfio_device_create_dmabuf(VFIODevice *vdev,

a 'vbasedev' name is preferred for VFIODevice variables/parameters.

> +                              struct iovec *iov, unsigned int iov_cnt)
> +{
> +    g_autofree struct vfio_device_feature *feature;

g_autofree variables should be set: 'feature = NULL'

> +    struct vfio_device_feature_dma_buf *dma_buf;
> +    ram_addr_t offset;
> +    RAMBlock *rb;
> +    size_t argsz;
> +    int i, index;
> +
> +    argsz = sizeof(*feature) + sizeof (*dma_buf) +
> +            sizeof(struct vfio_region_dma_range) * iov_cnt;
> +    feature = g_malloc0(argsz);
> +    dma_buf = (struct vfio_device_feature_dma_buf *)feature->data;
> +
> +    for (i = 0; i < iov_cnt; i++) {
> +        rcu_read_lock();

Is it needed ?

> +        rb = qemu_ram_block_from_host(iov[i].iov_base, false, &offset);
> +        rcu_read_unlock();
> +
> +        if (!rb) {
> +            return -1;

wouldn't an errno be more appropriate ?

> +        }
> +
> +        index = vfio_get_region_index_from_mr(rb->mr);
> +        if (index < 0) {
> +            return -1;
> +        }
> +
> +        dma_buf->region_index = index;
> +        dma_buf->dma_ranges[i].offset = offset;
> +        dma_buf->dma_ranges[i].length = iov[i].iov_len;
> +    }
> +
> +    dma_buf->nr_ranges = iov_cnt;
> +    dma_buf->open_flags = O_RDONLY | O_CLOEXEC;
> +    feature->argsz = argsz;
> +    feature->flags = VFIO_DEVICE_FEATURE_GET | VFIO_DEVICE_FEATURE_DMA_BUF;
> +
> +    return ioctl(vdev->fd, VFIO_DEVICE_FEATURE, feature);
Please use :

    return vbasedev->io_ops->device_feature(vbasedev, feature);

This would be returning an errno. Callers should be aware.

> +}
> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
> index bdb106c937..74b3c4eef7 100644
> --- a/include/hw/vfio/vfio-device.h
> +++ b/include/hw/vfio/vfio-device.h
> @@ -279,6 +279,9 @@ int vfio_device_get_irq_info(VFIODevice *vbasedev, int index,
>                                   struct vfio_irq_info *info);
>   
>   int vfio_get_region_index_from_mr(MemoryRegion *mr);
> +
> +int vfio_device_create_dmabuf(VFIODevice *vbasedev,
> +                              struct iovec *iov, unsigned int iov_cnt);


Since this is an external routine, please add documentation.


Thanks,

C.


>   #endif
>   
>   /* Returns 0 on success, or a negative errno. */


