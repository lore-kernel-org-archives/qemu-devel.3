Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFA49C9EC90
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 13:44:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfICA-0007VF-RN; Mon, 12 Jan 2026 08:42:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vfIBI-0006ks-DE
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:42:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vfIBF-0007BH-Tm
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:42:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768225320;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sSOFOJ+erpTVcwZLIS0VeOYrOKY5D834x8/Xo70MAR8=;
 b=ilEkLoDxRtHrPCS8TQQYr5Kw0YEcheWwAJGBI7n1MznjFAwc7rozTU2d+8HAhoWWhOe7jk
 saquBu9bSKCBpoXG4Sq2wQZXv4CerdiXhY/Ut79uvf0AHRHF0HdCPnvAgtGDwp+W524TUk
 Esr6jpeH8wUPYTZqySLBcMCkhSMeLlg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-zdHJtXf-PXex004ECKmJ2w-1; Mon, 12 Jan 2026 08:41:59 -0500
X-MC-Unique: zdHJtXf-PXex004ECKmJ2w-1
X-Mimecast-MFC-AGG-ID: zdHJtXf-PXex004ECKmJ2w_1768225318
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-b8711b467f3so151142966b.1
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 05:41:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768225318; x=1768830118;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sSOFOJ+erpTVcwZLIS0VeOYrOKY5D834x8/Xo70MAR8=;
 b=m7aAPTz0vnD0lf+xqcBDUcfYoP7Lfvdw1x29mfVveEXQuFV04SmmUpToI7HFzKJpWP
 L/F6A3kLkPMa8NVfyhab4+dkb3wNqZ4mqtMqjEEPLYOpPMQfUHeljPs0IV8XfVInpSs/
 zthmqEqbXhAtIpvrejJaSyiuTUBrZIg3u/R4c3axLsMRyFfryDumf4U0fU/QGyBmyYOY
 z6PUA91/40+1M3G3E1LUVM2OJa+moAtxAP9+dxZ2Yk05pkSXTdiF6l7XF5rAPZq6o6Hc
 GQ8Ub5gCvjpRSCbeJbHSeqcmBCHq4MEn28t+Ab5xz9NqeQVSQNHJ1djj/2qZORTL56aQ
 B9oQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTljM4qQZ0bSynB9N3u/VNNqHyWEnJASPjKxrktnRIPPX+ID0wyXnXaQjJDgmPNpnJtkfdySmSW9M+@nongnu.org
X-Gm-Message-State: AOJu0YwtsEFtsn4+YWU4o1DR4aA2cE/84ndglBu/MjeEKMHuh7LoOWSQ
 5H6RD9iTZZDKnl9HME2+tbByuBFnroWkAoecTYU/HXiGqZhTQ+RnIzO214wHMELX2WLJSumtysY
 TWel1uc8T6BKZVUl4UWTmtaCj8i5UtcdA61m/mRQ3mH8Wkpa9Txu/DMUr
X-Gm-Gg: AY/fxX41VnWAJJDI93GyTc/iUh+F1TZ25iaOOMEqHkD5/louRK6dhrUamXch/H8XYos
 CMVRgRRis1BxQ+H0g8l1gVyl5gQMMF8IJzNzggD7V95XbPDc7jkMYG2dkj376xBYPfQThVfq95z
 zyrNetDObSv2qSXtX1A2umSOwaMVi92Ci61Q34HA2ETevgW1Sxwu1D3OVMPkTEIxqz5tkr5lV1q
 SOl5BQAUhocXf9NCKAhTXbBcnq21IPRXG6Z95CbkUMpLP1uLU0G1Hzur4gvp99WDz2ytgi37v1J
 gR8Gq8sMwIPvgVTchWhqkhekSbWXHZhxCJLIRJOgh26Pk9tVztKk7FEiicjdGLrfZlMh/wj45RG
 uJvQOdOtLi7XeaODIv2tJYcWAzU4HRb9mOfzIudpoWAcW1QWOHNFkqP88eg==
X-Received: by 2002:a17:907:7f8e:b0:b87:31d1:4133 with SMTP id
 a640c23a62f3a-b8731d152ffmr42330966b.25.1768225317662; 
 Mon, 12 Jan 2026 05:41:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEWPGbXw3ne5/9pX8JaidjHlm8zSzme54+pcocD/pDduEZ2DmbJ0WD4LWWn9g1O4YrOFgTx2g==
X-Received: by 2002:a17:907:7f8e:b0:b87:31d1:4133 with SMTP id
 a640c23a62f3a-b8731d152ffmr42326666b.25.1768225317191; 
 Mon, 12 Jan 2026 05:41:57 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87162bf433sm374298066b.33.2026.01.12.05.41.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 05:41:56 -0800 (PST)
Message-ID: <578a6434-d155-4865-b7b5-b4b2b269c5e8@redhat.com>
Date: Mon, 12 Jan 2026 14:41:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 03/16] backends/iommufd: Introduce
 iommufd_backend_alloc_hw_queue
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, nicolinc@nvidia.com, nathanc@nvidia.com,
 mochs@nvidia.com, jgg@nvidia.com, jonathan.cameron@huawei.com,
 zhangfei.gao@linaro.org, zhenzhong.duan@intel.com, kjaju@nvidia.com
References: <20251210133737.78257-1-skolothumtho@nvidia.com>
 <20251210133737.78257-4-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251210133737.78257-4-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Shameer,

On 12/10/25 2:37 PM, Shameer Kolothum wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>
>
> Add a helper to allocate an iommufd backed HW queue for a vIOMMU.
>
> While at it, define a struct IOMMUFDHWqueue for use by vendor
> implementations.
>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  backends/iommufd.c       | 31 +++++++++++++++++++++++++++++++
>  backends/trace-events    |  1 +
>  include/system/iommufd.h | 11 +++++++++++
>  3 files changed, 43 insertions(+)
>
> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index 2f6fa832a7..a644763239 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -544,6 +544,37 @@ bool iommufd_backend_alloc_veventq(IOMMUFDBackend *be, uint32_t viommu_id,
>      return true;
>  }
>  
> +bool iommufd_backend_alloc_hw_queue(IOMMUFDBackend *be, uint32_t viommu_id,
> +                                    uint32_t data_type, uint32_t index,
this is named type in the uapi
> +                                    uint64_t addr, uint64_t length,
> +                                    uint32_t *out_hw_queue_id, Error **errp)
> +{
> +    int ret;
> +    struct iommu_hw_queue_alloc alloc_hw_queue = {
> +        .size = sizeof(alloc_hw_queue),
> +        .flags = 0,
> +        .viommu_id = viommu_id,
> +        .type = data_type,
> +        .index = index,
> +        .nesting_parent_iova = addr,
> +        .length = length,
> +    };
> +
> +    ret = ioctl(be->fd, IOMMU_HW_QUEUE_ALLOC, &alloc_hw_queue);
> +
> +    trace_iommufd_backend_alloc_hw_queue(be->fd, viommu_id, data_type,
> +                                         index, addr, length,
> +                                         alloc_hw_queue.out_hw_queue_id, ret);
> +    if (ret) {
> +        error_setg_errno(errp, errno, "IOMMU_HW_QUEUE_ALLOC failed");
> +        return false;
> +    }
> +
> +    g_assert(out_hw_queue_id);
> +    *out_hw_queue_id = alloc_hw_queue.out_hw_queue_id;
> +    return true;
> +}
> +
>  bool host_iommu_device_iommufd_attach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
>                                             uint32_t hwpt_id, Error **errp)
>  {
> diff --git a/backends/trace-events b/backends/trace-events
> index 5afa7a40be..a22ad30e55 100644
> --- a/backends/trace-events
> +++ b/backends/trace-events
> @@ -24,3 +24,4 @@ iommufd_backend_invalidate_cache(int iommufd, uint32_t id, uint32_t data_type, u
>  iommufd_backend_alloc_viommu(int iommufd, uint32_t dev_id, uint32_t type, uint32_t hwpt_id, uint32_t viommu_id, int ret) " iommufd=%d type=%u dev_id=%u hwpt_id=%u viommu_id=%u (%d)"
>  iommufd_backend_alloc_vdev(int iommufd, uint32_t dev_id, uint32_t viommu_id, uint64_t virt_id, uint32_t vdev_id, int ret) " iommufd=%d dev_id=%u viommu_id=%u virt_id=0x%"PRIx64" vdev_id=%u (%d)"
>  iommufd_viommu_alloc_eventq(int iommufd, uint32_t viommu_id, uint32_t type, uint32_t veventq_id, uint32_t veventq_fd, int ret) " iommufd=%d viommu_id=%u type=%u veventq_id=%u veventq_fd=%u (%d)"
> +iommufd_backend_alloc_hw_queue(int iommufd, uint32_t viommu_id, uint32_t vqueue_type, uint32_t index, uint64_t addr, uint64_t size, uint32_t vqueue_id, int ret) " iommufd=%d viommu_id=%u vqueue_type=%u index=%u addr=0x%"PRIx64" size=0x%"PRIx64" vqueue_id=%u (%d)"
prefer using length instead of size to stick to the uapi terms
> diff --git a/include/system/iommufd.h b/include/system/iommufd.h
> index a3e8087b3a..9b8602a558 100644
> --- a/include/system/iommufd.h
> +++ b/include/system/iommufd.h
> @@ -63,6 +63,12 @@ typedef struct IOMMUFDVeventq {
>      uint32_t veventq_fd;
>  } IOMMUFDVeventq;
>  
> +/* HW queue object for a vIOMMU-specific HW-accelerated queue */
> +typedef struct IOMMUFDHWqueue {
> +    IOMMUFDViommu *viommu;
> +    uint32_t hw_queue_id;
> +} IOMMUFDHWqueue;
> +
>  bool iommufd_backend_connect(IOMMUFDBackend *be, Error **errp);
>  void iommufd_backend_disconnect(IOMMUFDBackend *be);
>  
> @@ -99,6 +105,11 @@ bool iommufd_backend_alloc_veventq(IOMMUFDBackend *be, uint32_t viommu_id,
>                                     uint32_t *out_veventq_id,
>                                     uint32_t *out_veventq_fd, Error **errp);
>  
> +bool iommufd_backend_alloc_hw_queue(IOMMUFDBackend *be, uint32_t viommu_id,
> +                                    uint32_t data_type, uint32_t index,
> +                                    uint64_t addr, uint64_t length,
> +                                    uint32_t *out_hw_queue_id, Error **errp);
> +
>  bool iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be, uint32_t hwpt_id,
>                                          bool start, Error **errp);
>  bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t hwpt_id,
Besides
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric


