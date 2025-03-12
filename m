Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F314BC28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 15:35:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsNtV-0004X0-Up; Wed, 12 Mar 2025 11:21:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tsNtM-0004Um-Ax
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 11:21:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tsNtK-0000QJ-KY
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 11:21:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741792863;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EndKC3E+5tKj8bcm2j4ez5mYagnB+Ve5EldOVX32vo4=;
 b=CKbzMkG5bMHBe5mCmO55jpVRYDso1zhUxVnhAx4LnZS7k+8o70uiSTrVOdON8zlhz5N+1p
 HMNEG9I1gcthNuVW5pYW4rmAaFpHZ9SEfPudpE+m5U685fST8ZmkMb7AG+bBdUnHbd0DaT
 Fg6Lx3m634VTWoLVzugh9UgVba/lEeM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-L2lfIqsXNCer4GqCPGK3Uw-1; Wed, 12 Mar 2025 11:20:50 -0400
X-MC-Unique: L2lfIqsXNCer4GqCPGK3Uw-1
X-Mimecast-MFC-AGG-ID: L2lfIqsXNCer4GqCPGK3Uw_1741792850
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7bb849aa5fbso1655059185a.0
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 08:20:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741792850; x=1742397650;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EndKC3E+5tKj8bcm2j4ez5mYagnB+Ve5EldOVX32vo4=;
 b=AKT14WgncZOWS7AbzyHRN4d5FFbUW7SwV4+0kgFqLKWBDaNmtlDvJTEwHAI0ZDaYI1
 6VnB+2jtM6MYQ3ZpNBIzdEEqYWLQulDxeBtK3LNoig+NabW92Dd2c7mM86FMXyBzhUeO
 z6uI7FHEolQzkfMBT7U2CNbOtaRAzIi7xp7LdY7U/SH/BcQFxcq3R57/gzhZfJOC20o/
 sWoc7foslsMJhZjSZ9T4GUMyc9aH54gJPuWclWV7Csy/Fx4j54rFzxQP9ZF0aDc4+Xcg
 bUAXRrCqcCMxXatCxvlyP3/GIG3XnArZ0i47jEAc/fNSuP8DN4i4MH4kBgie1ymgulSt
 pCRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+AbsHd4BAsP7TKsfnQkYG8OqhTeqk4NjzkqFaIPp+nNyKP4a/i1w8W6fwV+iXTTsZd5uWT/g6kSdL@nongnu.org
X-Gm-Message-State: AOJu0Yw7RbnSO00G8MJSCy6IOHgem87Ng52mi5LKV3gKrjTHkupLq7Je
 xND/6Mr9oh5See8giLMa1wWQFXyGnbgW99FIuedva4u7I8YaGogOxCxpukBvyhDRPU3B6eFO8R9
 0EdVxYB+bw+KcCUtj4vTlsBD8CmMWXwv0SE1ovlcfS8lfeihtlW6k
X-Gm-Gg: ASbGncsNQVcv8wAQMNsHvltUZduIvqRl2j8cb7gQMTX8ewCkxOvwjx7tdnvrn8ISFtR
 9YigwRfaMNy6Mi2rjIhHZ6DSSmmx5ufD6ys5KH7sl2bljrUKj/nq8hBqcK2Wuy9a2V+vVf1wYT4
 F4PhnFRQZnD1iO/z69Q79ttgyQJ5MBYdzaDMhTKAVJm0KbvkjC5dHLquqf5Q9995mqdzQqn7UIy
 r9cG8Bljf5Mk0kkqvjb0Lofvq6WNx96GG97LGI1SzFjy8aOnsnfwrwUxfsR4HyDZTav0mg/ztH4
 vvqSZ446gyHv50EGU4SNAnqtChkK0ZJajDy8KybmCxAV+Nfa35Ra8szQ7HUJWhQ=
X-Received: by 2002:a05:620a:6288:b0:7c5:4caa:21b6 with SMTP id
 af79cd13be357-7c54caa3459mr1996127485a.57.1741792850348; 
 Wed, 12 Mar 2025 08:20:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+VW+3Flv8QuVT9A1xrDQI/nkjqwjzwou4+Npa8nH3zBdSLqRFmJSlMN7M4DyBz4xKv7Jm0A==
X-Received: by 2002:a05:620a:6288:b0:7c5:4caa:21b6 with SMTP id
 af79cd13be357-7c54caa3459mr1996125485a.57.1741792850114; 
 Wed, 12 Mar 2025 08:20:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c566e847a5sm171161385a.80.2025.03.12.08.20.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Mar 2025 08:20:49 -0700 (PDT)
Message-ID: <266823f4-5b98-48e3-8414-ce27b4ede087@redhat.com>
Date: Wed, 12 Mar 2025 16:20:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 01/20] backends/iommufd: Introduce
 iommufd_backend_alloc_viommu
Content-Language: en-US
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, linuxarm@huawei.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-2-shameerali.kolothum.thodi@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250311141045.66620-2-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi,


On 3/11/25 3:10 PM, Shameer Kolothum wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>
>
> Add a helper to allocate a viommu object.
>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  backends/iommufd.c       | 25 +++++++++++++++++++++++++
>  backends/trace-events    |  1 +
>  include/system/iommufd.h |  4 ++++
>  3 files changed, 30 insertions(+)
>
> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index 3c23caef96..3fac08c96e 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -341,6 +341,31 @@ int iommufd_backend_invalidate_cache(IOMMUFDBackend *be, uint32_t hwpt_id,
>      return ret;
>  }
>  
> +bool iommufd_backend_alloc_viommu(IOMMUFDBackend *be, uint32_t dev_id,
> +                                  uint32_t viommu_type, uint32_t hwpt_id,
> +                                  uint32_t *out_viommu_id, Error **errp)
> +{
> +    int ret, fd = be->fd;
> +    struct iommu_viommu_alloc alloc_viommu = {
> +        .size = sizeof(alloc_viommu),
> +        .type = viommu_type,
> +        .dev_id = dev_id,
> +        .hwpt_id = hwpt_id,
> +    };
> +
> +    ret = ioctl(fd, IOMMU_VIOMMU_ALLOC, &alloc_viommu);
> +
> +    trace_iommufd_backend_alloc_viommu(fd, viommu_type, dev_id, hwpt_id,
> +                                       alloc_viommu.out_viommu_id, ret);
> +    if (ret) {
> +        error_setg_errno(errp, errno, "IOMMU_VIOMMU_ALLOC failed");
> +        return false;
> +    }
> +
> +    *out_viommu_id = alloc_viommu.out_viommu_id;
> +    return true;
> +}
> +
>  bool host_iommu_device_iommufd_attach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
>                                             uint32_t hwpt_id, Error **errp)
>  {
> diff --git a/backends/trace-events b/backends/trace-events
> index 5a23db6c8a..a835827540 100644
> --- a/backends/trace-events
> +++ b/backends/trace-events
> @@ -19,3 +19,4 @@ iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=%d id=%d (%
>  iommufd_backend_set_dirty(int iommufd, uint32_t hwpt_id, bool start, int ret) " iommufd=%d hwpt=%u enable=%d (%d)"
>  iommufd_backend_get_dirty_bitmap(int iommufd, uint32_t hwpt_id, uint64_t iova, uint64_t size, uint64_t page_size, int ret) " iommufd=%d hwpt=%u iova=0x%"PRIx64" size=0x%"PRIx64" page_size=0x%"PRIx64" (%d)"
>  iommufd_backend_invalidate_cache(int iommufd, uint32_t hwpt_id, uint32_t data_type, uint32_t entry_len, uint32_t entry_num, uint32_t done_num, uint64_t data_ptr, int ret) " iommufd=%d hwpt_id=%u data_type=%u entry_len=%u entry_num=%u done_num=%u data_ptr=0x%"PRIx64" (%d)"
> +iommufd_backend_alloc_viommu(int iommufd, uint32_t type, uint32_t dev_id, uint32_t hwpt_id, uint32_t viommu_id, int ret) " iommufd=%d type=%u dev_id=%u hwpt_id=%u viommu_id=%u (%d)"
> diff --git a/include/system/iommufd.h b/include/system/iommufd.h
> index b93421ac7c..7e5507f2db 100644
> --- a/include/system/iommufd.h
> +++ b/include/system/iommufd.h
> @@ -55,6 +55,10 @@ bool iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t dev_id,
>                                  uint32_t data_type, uint32_t data_len,
>                                  void *data_ptr, uint32_t *out_hwpt,
>                                  Error **errp);
> +bool iommufd_backend_alloc_viommu(IOMMUFDBackend *be, uint32_t dev_id,
> +                                  uint32_t viommu_type, uint32_t hwpt_id,
> +                                  uint32_t *out_hwpt, Error **errp);
> +
>  bool iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be, uint32_t hwpt_id,
>                                          bool start, Error **errp);
>  bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t hwpt_id,


