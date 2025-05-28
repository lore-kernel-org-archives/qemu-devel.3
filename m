Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5959CC5AE59
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 10:30:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKE2A-00008B-89; Wed, 28 May 2025 06:29:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uKE27-00007z-Uy
 for qemu-devel@nongnu.org; Wed, 28 May 2025 06:29:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uKE25-0003kF-2K
 for qemu-devel@nongnu.org; Wed, 28 May 2025 06:29:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748428150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MZl3cYV7ZRLU32M1BP0+WBBxFPD5fJ4lC1KgwA6ROlM=;
 b=AlEsCOS+XLASUv9G05+wiLB49On3tkxJEsCe2FR7RfmJU2IKH/Izfy6iAyE2UOHklCzRZe
 YArxHj1B1m7qcl4tTTVMSkgeZplGwnaD6UnpJVv64dS9LIwJI1HjRnyS9Sd9sQzfJRKwCr
 Wa4bj+uGxLpeRW+56ZuWzTb+MWRMuGo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-IEc8QIcrO4GQ5vUAYN5I9A-1; Wed, 28 May 2025 06:29:09 -0400
X-MC-Unique: IEc8QIcrO4GQ5vUAYN5I9A-1
X-Mimecast-MFC-AGG-ID: IEc8QIcrO4GQ5vUAYN5I9A_1748428148
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a4ea7e46dfso223683f8f.3
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 03:29:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748428145; x=1749032945;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MZl3cYV7ZRLU32M1BP0+WBBxFPD5fJ4lC1KgwA6ROlM=;
 b=pEjwGQ3szdaiEqrLjq7dR03VSQlHLrfZA1liqoFY2d5UBZOCYOEN9RawxUR3ts5pHC
 mNuUnzE8XLtbkBYO3AROf/flwkRPs7w8InUkh6EujiV2Hq5x7p32qB4E44/nRBl+sHI0
 YgeJyAr8a1SsXkRYSUO8+NmWuzzg3906wz1m7vJ50d/f9ydtS90bR0RWmFC1rndxGbwa
 aMhixkZ1+VMedpDdWHmpSUeL8aFgyKIQcNpaAkiWIKY98FoAHGnbuCxSPSXNykjAExVo
 jYsH1xKaFvOR3iUBHtrId0Eqz21Y26u+yfIbglVWsV/22wnm0952Kv1bDqtdfi4NiSoG
 gFmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWg/Px2i544J9qY1TZOBCvirsCELoAEiCowSQ8FtR8Y2fnRI4ul23Ru3m8Y/nMrP8Dp+k28fAkIjooD@nongnu.org
X-Gm-Message-State: AOJu0Yy9fYaluQVJ5Q9uwgolWdzSn2URZr5mAkn3VcHe97idS6VkQDyl
 I/fJu8YcXB5PMLtClKHnx8gmZ9Gu4UQ+clsniFRzASN68+37IIapAGjiHAKZYBOjRUHCG7In8ha
 WR0REa3BmbziC9N2ok7bwnCyn/DdDeIxlR9YHR6VH9nJ387QhWZzC/NvH
X-Gm-Gg: ASbGncslKrr5cgBswzCm6Fzqy65ruMZK1j7TUAARyf5puBvDuBsyjY+5WQW70xDpJEl
 Ofze9OAgTK31Oq8l07o6ZuvUoQgSEQ9XN3aKIPZCUOB8+aUxbplqHRlCrjpk1k4X7VyWbob696h
 uMA7s6U8cgO7mn8YvzggCrZQae1WObNFyBnpQUf6cNe70uILzywLmljrr81EXgPaZeCOAmtwEhh
 zEaJgUkAHEXbQDbElS85eEPvW0mAjG7iP5aojayjYBpkHBCovg451gCxSRQvEQzX6orS/V4E0JR
 TfAwQw==
X-Received: by 2002:a05:6000:2011:b0:3a4:eb92:b5eb with SMTP id
 ffacd0b85a97d-3a4eb92b7damr809361f8f.50.1748428145386; 
 Wed, 28 May 2025 03:29:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUrEkw6NlwUINCS+TFBB8A/3JA6A4cOO31Ow/fjyJBUhwIOASIEOav5l1yTLHpzfim1+gVTw==
X-Received: by 2002:a05:6000:2011:b0:3a4:eb92:b5eb with SMTP id
 ffacd0b85a97d-3a4eb92b7damr809344f8f.50.1748428144928; 
 Wed, 28 May 2025 03:29:04 -0700 (PDT)
Received: from [10.0.5.211] ([91.126.222.130])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450787cc3b9sm13107715e9.26.2025.05.28.03.29.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 May 2025 03:29:04 -0700 (PDT)
Message-ID: <d4d0a5b8-1d4a-4c17-8267-8bb362d89772@redhat.com>
Date: Wed, 28 May 2025 12:29:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/6] vfio/iommufd: Add properties and handlers to
 TYPE_HOST_IOMMU_DEVICE_IOMMUFD
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com
References: <20250528060409.3710008-1-zhenzhong.duan@intel.com>
 <20250528060409.3710008-3-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250528060409.3710008-3-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 5/28/25 08:04, Zhenzhong Duan wrote:
> Enhance HostIOMMUDeviceIOMMUFD object with 3 new members, specific
> to the iommufd BE + 2 new class functions.
> 
> IOMMUFD BE includes IOMMUFD handle, devid and hwpt_id. IOMMUFD handle
> and devid are used to allocate/free ioas and hwpt. hwpt_id is used to
> re-attach IOMMUFD backed device to its default VFIO sub-system created
> hwpt, i.e., when vIOMMU is disabled by guest. These properties will be
> initialized after attachment.
> 
> 2 new class functions are [at|de]tach_hwpt(). They are used to
> attach/detach hwpt. VFIO and VDPA can have different implementions,
> so implementation will be in sub-class instead of HostIOMMUDeviceIOMMUFD,
> e.g., in HostIOMMUDeviceIOMMUFDVFIO.
> 
> Add two wrappers host_iommu_device_iommufd_[at|de]tach_hwpt to
> wrap the two functions.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   include/system/iommufd.h | 50 ++++++++++++++++++++++++++++++++++++++++
>   backends/iommufd.c       | 22 ++++++++++++++++++
>   2 files changed, 72 insertions(+)
> 
> diff --git a/include/system/iommufd.h b/include/system/iommufd.h
> index 5399519626..a704575662 100644
> --- a/include/system/iommufd.h
> +++ b/include/system/iommufd.h
> @@ -67,4 +67,54 @@ bool iommufd_backend_invalidate_cache(IOMMUFDBackend *be, uint32_t id,
>                                         Error **errp);
>   
>   #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD TYPE_HOST_IOMMU_DEVICE "-iommufd"
> +OBJECT_DECLARE_TYPE(HostIOMMUDeviceIOMMUFD, HostIOMMUDeviceIOMMUFDClass,
> +                    HOST_IOMMU_DEVICE_IOMMUFD)
> +
> +/* Overload of the host IOMMU device for the iommufd backend */
> +struct HostIOMMUDeviceIOMMUFD {
> +    HostIOMMUDevice parent_obj;
> +
> +    IOMMUFDBackend *iommufd;
> +    uint32_t devid;
> +    uint32_t hwpt_id;
> +};

the addition of new attributes would be better placed in the next patch.

Anyhow,



Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



> +struct HostIOMMUDeviceIOMMUFDClass {
> +    HostIOMMUDeviceClass parent_class;
> +
> +    /**
> +     * @attach_hwpt: attach host IOMMU device to IOMMUFD hardware page table.
> +     * VFIO and VDPA device can have different implementation.
> +     *
> +     * Mandatory callback.
> +     *
> +     * @idev: host IOMMU device backed by IOMMUFD backend.
> +     *
> +     * @hwpt_id: ID of IOMMUFD hardware page table.
> +     *
> +     * @errp: pass an Error out when attachment fails.
> +     *
> +     * Returns: true on success, false on failure.
> +     */
> +    bool (*attach_hwpt)(HostIOMMUDeviceIOMMUFD *idev, uint32_t hwpt_id,
> +                        Error **errp);
> +    /**
> +     * @detach_hwpt: detach host IOMMU device from IOMMUFD hardware page table.
> +     * VFIO and VDPA device can have different implementation.
> +     *
> +     * Mandatory callback.
> +     *
> +     * @idev: host IOMMU device backed by IOMMUFD backend.
> +     *
> +     * @errp: pass an Error out when attachment fails.
> +     *
> +     * Returns: true on success, false on failure.
> +     */
> +    bool (*detach_hwpt)(HostIOMMUDeviceIOMMUFD *idev, Error **errp);
> +};
> +
> +bool host_iommu_device_iommufd_attach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
> +                                           uint32_t hwpt_id, Error **errp);
> +bool host_iommu_device_iommufd_detach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
> +                                           Error **errp);
>   #endif
> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index c8788a6438..b114fb08e7 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -344,6 +344,26 @@ bool iommufd_backend_invalidate_cache(IOMMUFDBackend *be, uint32_t id,
>       return !ret;
>   }
>   
> +bool host_iommu_device_iommufd_attach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
> +                                           uint32_t hwpt_id, Error **errp)
> +{
> +    HostIOMMUDeviceIOMMUFDClass *idevc =
> +        HOST_IOMMU_DEVICE_IOMMUFD_GET_CLASS(idev);
> +
> +    g_assert(idevc->attach_hwpt);
> +    return idevc->attach_hwpt(idev, hwpt_id, errp);
> +}
> +
> +bool host_iommu_device_iommufd_detach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
> +                                           Error **errp)
> +{
> +    HostIOMMUDeviceIOMMUFDClass *idevc =
> +        HOST_IOMMU_DEVICE_IOMMUFD_GET_CLASS(idev);
> +
> +    g_assert(idevc->detach_hwpt);
> +    return idevc->detach_hwpt(idev, errp);
> +}
> +
>   static int hiod_iommufd_get_cap(HostIOMMUDevice *hiod, int cap, Error **errp)
>   {
>       HostIOMMUDeviceCaps *caps = &hiod->caps;
> @@ -382,6 +402,8 @@ static const TypeInfo types[] = {
>       }, {
>           .name = TYPE_HOST_IOMMU_DEVICE_IOMMUFD,
>           .parent = TYPE_HOST_IOMMU_DEVICE,
> +        .instance_size = sizeof(HostIOMMUDeviceIOMMUFD),
> +        .class_size = sizeof(HostIOMMUDeviceIOMMUFDClass),
>           .class_init = hiod_iommufd_class_init,
>           .abstract = true,
>       }


