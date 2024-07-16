Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AFBBC3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 12:24:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sThE4-0001LK-Ue; Tue, 16 Jul 2024 08:24:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sThE4-0001KH-56
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 08:24:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sThE2-0007A7-E3
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 08:24:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721132648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UdS83IvNJLwfSwN9FiEgATBMKBR189+2rm0NqPmACx4=;
 b=MfaKYqGGMUtCG8UgG+k64WYg3GBl6sZ5+JMc4JdMIbYWcaRs0gEtKaEjvCri6V5X11p0GC
 IVaj6dT+IFmhSnUmQWyrP5JTfqv8M8VJYBRuKrGcHUZybKqz0uDgcofOxucI4vQDYLgF+H
 GieUM8ptUe3uDXD6TwzObJy33buNHTA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-ZzWNDtGTMtSJEmBtG5_VYw-1; Tue, 16 Jul 2024 08:24:05 -0400
X-MC-Unique: ZzWNDtGTMtSJEmBtG5_VYw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42794cb8251so35269015e9.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 05:24:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721132645; x=1721737445;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UdS83IvNJLwfSwN9FiEgATBMKBR189+2rm0NqPmACx4=;
 b=TW8f2UHDtNl4KIK6i7WwJB1rYc2TRhNw7cOEUnfn5C3W6hw7+3TzH7BzIjGRE9JO90
 xBii128m4Xu32sr93J7M60X5+t2nvXS5f//JVr+FtavsifccJV6r3OEMCIDhxkhzyeDD
 oiY/ECEVH2n+0EWAulaYuB/mxGoib3LwT4rCzhTFdHyueeUl44VgQDcKBtfID95wwsKQ
 OpJLt8HUlkYiYt3YF1r+xH6TR4/rcdpS1Violwq2xtJ0ZEdngT0q44nI81JlJ+NZxzSF
 2myS0e/hJHOf1fOD06D/81AsIkHet5HCTRFSvLWv4HafGOAWK2gLvRnlVjS3gcBMe/9P
 vCsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvCp80DlmXx27CZzAUF7UpdnJ/V1qdyhnkmOHWtkgNMFKc+C/fxx0ikzdwZ78vedEgN2Nj4ZB0CQ0BCdkfqy0jdT7KAAI=
X-Gm-Message-State: AOJu0YzVuNgbvWjWDoxClS7ZjYFd+V+UhIaP1OMkXk8ZVFB2MK3vQsUZ
 GEZ8aIM+/2lwaN1nnLse5THyI7Y51GHnJSUHmQWqQNnS4I9jZpZ/xLl0yMDXGid85hUKZq3Ml+o
 Z9Iu3pMWQ4arj6YAlSc5idpM8HAZjtSo1EBXPVk4MVzGTDIHS3KmY
X-Received: by 2002:a05:600c:4f8e:b0:426:61af:e1d3 with SMTP id
 5b1f17b1804b1-427ba6dc04fmr12598055e9.31.1721132644803; 
 Tue, 16 Jul 2024 05:24:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4qAhwQuX1zddJwAaxvkdsbDCmgGr/nowHSeY6q9fU4150zJd0EPKrsmcDcmTEjcBJnGkVjw==
X-Received: by 2002:a05:600c:4f8e:b0:426:61af:e1d3 with SMTP id
 5b1f17b1804b1-427ba6dc04fmr12597905e9.31.1721132644426; 
 Tue, 16 Jul 2024 05:24:04 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:26c5:842:8baa:576b?
 ([2a01:e0a:9e2:9000:26c5:842:8baa:576b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dafbe93sm8861098f8f.77.2024.07.16.05.24.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jul 2024 05:24:03 -0700 (PDT)
Message-ID: <df0fef13-447b-4ace-af86-741f8f3e25d8@redhat.com>
Date: Tue, 16 Jul 2024 14:24:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/12] vfio/iommufd: Implement
 VFIOIOMMUClass::set_dirty_tracking support
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
References: <20240712114704.8708-1-joao.m.martins@oracle.com>
 <20240712114704.8708-10-joao.m.martins@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240712114704.8708-10-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 7/12/24 13:47, Joao Martins wrote:
> ioctl(iommufd, IOMMU_HWPT_SET_DIRTY_TRACKING, arg) is the UAPI that
> enables or disables dirty page tracking. It is used if the hwpt
> has been created with dirty tracking supported domain (stored in
> hwpt::flags) and it is called on the whole list of iommu domains
> it is are tracking. On failure it rolls it back.
> 
> The checking of hwpt::flags is introduced here as a second user
> and thus consolidate such check into a helper function
> iommufd_hwpt_dirty_tracking().
> 
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>   include/sysemu/iommufd.h |  3 +++
>   backends/iommufd.c       | 23 +++++++++++++++++++++++
>   hw/vfio/iommufd.c        | 39 ++++++++++++++++++++++++++++++++++++++-
>   backends/trace-events    |  1 +
>   4 files changed, 65 insertions(+), 1 deletion(-)
> 
> diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
> index e917e7591d05..7416d9219703 100644
> --- a/include/sysemu/iommufd.h
> +++ b/include/sysemu/iommufd.h
> @@ -55,6 +55,9 @@ bool iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t dev_id,
>                                   uint32_t data_type, uint32_t data_len,
>                                   void *data_ptr, uint32_t *out_hwpt,
>                                   Error **errp);
> +bool iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be, uint32_t hwpt_id,
> +                                        bool start, Error **errp);
>   
>   #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD TYPE_HOST_IOMMU_DEVICE "-iommufd"
> +
>   #endif
> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index 41a9dec3b2c5..239f0976e0ad 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -239,6 +239,29 @@ bool iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t dev_id,
>       return true;
>   }
>   
> +bool iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be,
> +                                        uint32_t hwpt_id, bool start,
> +                                        Error **errp)
> +{
> +    int ret;
> +    struct iommu_hwpt_set_dirty_tracking set_dirty = {
> +            .size = sizeof(set_dirty),
> +            .hwpt_id = hwpt_id,
> +            .flags = !start ? 0 : IOMMU_HWPT_DIRTY_TRACKING_ENABLE,

How about :

             .flags = start ? IOMMU_HWPT_DIRTY_TRACKING_ENABLE : 0,

?


Thanks,

C.


> +    };
> +
> +    ret = ioctl(be->fd, IOMMU_HWPT_SET_DIRTY_TRACKING, &set_dirty);
> +    trace_iommufd_backend_set_dirty(be->fd, hwpt_id, start, ret ? errno : 0);
> +    if (ret) {
> +        error_setg_errno(errp, errno,
> +                         "IOMMU_HWPT_SET_DIRTY_TRACKING(hwpt_id %u) failed",
> +                         hwpt_id);
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
>   bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
>                                        uint32_t *type, void *data, uint32_t len,
>                                        uint64_t *caps, Error **errp)
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index edc8f97d8f3d..da678315faeb 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -110,6 +110,42 @@ static void iommufd_cdev_unbind_and_disconnect(VFIODevice *vbasedev)
>       iommufd_backend_disconnect(vbasedev->iommufd);
>   }
>   
> +static bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt)
> +{
> +    return hwpt->hwpt_flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
> +}
> +
> +static int iommufd_set_dirty_page_tracking(const VFIOContainerBase *bcontainer,
> +                                           bool start, Error **errp)
> +{
> +    const VFIOIOMMUFDContainer *container =
> +        container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
> +    VFIOIOASHwpt *hwpt;
> +
> +    QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
> +        if (!iommufd_hwpt_dirty_tracking(hwpt)) {
> +            continue;
> +        }
> +
> +        if (!iommufd_backend_set_dirty_tracking(container->be,
> +                                                hwpt->hwpt_id, start, errp)) {
> +            goto err;
> +        }
> +    }
> +
> +    return 0;
> +
> +err:
> +    QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
> +        if (!iommufd_hwpt_dirty_tracking(hwpt)) {
> +            continue;
> +        }
> +        iommufd_backend_set_dirty_tracking(container->be,
> +                                           hwpt->hwpt_id, !start, NULL);
> +    }
> +    return -EINVAL;
> +}
> +
>   static int iommufd_cdev_getfd(const char *sysfs_path, Error **errp)
>   {
>       ERRP_GUARD();
> @@ -278,7 +314,7 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>       QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
>       QLIST_INSERT_HEAD(&container->hwpt_list, hwpt, next);
>       container->bcontainer.dirty_pages_supported |=
> -                              (flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING);
> +                              iommufd_hwpt_dirty_tracking(hwpt);
>       return true;
>   }
>   
> @@ -717,6 +753,7 @@ static void vfio_iommu_iommufd_class_init(ObjectClass *klass, void *data)
>       vioc->attach_device = iommufd_cdev_attach;
>       vioc->detach_device = iommufd_cdev_detach;
>       vioc->pci_hot_reset = iommufd_cdev_pci_hot_reset;
> +    vioc->set_dirty_page_tracking = iommufd_set_dirty_page_tracking;
>   };
>   
>   static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
> diff --git a/backends/trace-events b/backends/trace-events
> index 4d8ac02fe7d6..28aca3b859d4 100644
> --- a/backends/trace-events
> +++ b/backends/trace-events
> @@ -16,3 +16,4 @@ iommufd_backend_unmap_dma(int iommufd, uint32_t ioas, uint64_t iova, uint64_t si
>   iommufd_backend_alloc_ioas(int iommufd, uint32_t ioas) " iommufd=%d ioas=%d"
>   iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id, uint32_t pt_id, uint32_t flags, uint32_t hwpt_type, uint32_t len, uint64_t data_ptr, uint32_t out_hwpt_id, int ret) " iommufd=%d dev_id=%u pt_id=%u flags=0x%x hwpt_type=%u len=%u data_ptr=0x%"PRIx64" out_hwpt=%u (%d)"
>   iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=%d id=%d (%d)"
> +iommufd_backend_set_dirty(int iommufd, uint32_t hwpt_id, bool start, int ret) " iommufd=%d hwpt=%u enable=%d (%d)"


