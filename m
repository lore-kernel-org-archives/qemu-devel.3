Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F006C3DA41
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 07:08:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR4xG-0005ML-10; Tue, 09 Jul 2024 03:08:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sR4xE-0005Lh-Ig
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 03:08:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sR4xC-0008HL-Qw
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 03:08:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720508877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HlmmFOkHBz2FTdwBHanUBET7+prQWPRprnE7gXmZB3c=;
 b=g+KXnCX4gFXfmOZg1pQ1CFqevvlTFc9xoiOab7dHSLKqqALNdl5b9+1SkRc5dftUGrRiwD
 JnZmpfUAfCyn4NK5ga69a0J8AWZv7vm/k4VMMxWCoOdfalNdsXlMbm1zswWxOcd8rP+euV
 X5l5Xubovm2+sFLsAOrF6hnpX9tre+M=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-t7wH3n8sNEqvZt5NpN9qyw-1; Tue, 09 Jul 2024 03:07:51 -0400
X-MC-Unique: t7wH3n8sNEqvZt5NpN9qyw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-367990b4beeso3363183f8f.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 00:07:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720508871; x=1721113671;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HlmmFOkHBz2FTdwBHanUBET7+prQWPRprnE7gXmZB3c=;
 b=XtTK+CJUG/yKQTqtbXZ18MNXYiSt0RV9nqWqMss/tVBGjPJqVChPpBGfUcPuGrR/Xg
 jzWRELKT0fbfQWMc7/xM8pp6dsYacuvsH9OXoR3uXcSFZHpHtX57QvbcmNehATpMpNzX
 p24ocd/EoNdCCoTKksvkiy5+fWjhgCSRTR3g1X59PVaD/frETYEDOOLtGyGng/Wz+3ou
 EX94ZDHu/uevJM7rEoOduoBhwAvKPc1Wy/rF3B/UXrST1K+/JlK1f89A70ZtCq5vXOLt
 vSugLOPNjSYND6sGYSV8L1NgWTV4VwfucwjXz9aMG7JGV8eMCzdDywAQyexga/DWPje6
 Suhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCSUu340Zs232H/FFT9dAz4nsHP8BQu5FWQlZCR6jZGKpx1G0i1KkZPjJ2neZktIe4NF/tbRGLzVZAo0hXc5VuQToXr2c=
X-Gm-Message-State: AOJu0YwpCf2A9HabTRkdeaI6eH50yT7EvZCmMZTZBbRFmMV89IbkfDet
 F2K1SzXbwTqC54Uzwb1ku244rlqdvbuwsZCP2cTid6KYNKqFxavCFUKKY+tWYmOCo7xboQcpRk6
 JVmwElaPAkNtfj9YLXuhblsZ/dRqvdpvagSSzPAXbBBmpLoZk/SlV
X-Received: by 2002:a5d:68cd:0:b0:367:9d21:22cb with SMTP id
 ffacd0b85a97d-367cea73551mr1079229f8f.22.1720508870792; 
 Tue, 09 Jul 2024 00:07:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJQJ6vPtG1yy30QYJ6ZPSItAJC+68Fyg8EN41x40CxS5I+Vz7Br7kCdt9dXk7W5P2fu+Yxtw==
X-Received: by 2002:a5d:68cd:0:b0:367:9d21:22cb with SMTP id
 ffacd0b85a97d-367cea73551mr1079208f8f.22.1720508870330; 
 Tue, 09 Jul 2024 00:07:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367cde891e4sm1630637f8f.64.2024.07.09.00.07.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jul 2024 00:07:49 -0700 (PDT)
Message-ID: <4aa6309f-d529-4cb6-8ea9-014423d0a1cb@redhat.com>
Date: Tue, 9 Jul 2024 09:07:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/10] vfio/iommufd: Implement
 VFIOIOMMUClass::set_dirty_tracking support
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
References: <20240708143420.16953-1-joao.m.martins@oracle.com>
 <20240708143420.16953-7-joao.m.martins@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240708143420.16953-7-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
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

On 7/8/24 4:34 PM, Joao Martins wrote:
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
>   backends/iommufd.c       | 20 ++++++++++++++++++
>   hw/vfio/iommufd.c        | 45 +++++++++++++++++++++++++++++++++++++++-
>   backends/trace-events    |  1 +
>   4 files changed, 68 insertions(+), 1 deletion(-)
> 
> diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
> index 35a8cec9780f..1470377f55ba 100644
> --- a/include/sysemu/iommufd.h
> +++ b/include/sysemu/iommufd.h
> @@ -54,6 +54,9 @@ int iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t dev_id,
>                                  uint32_t pt_id, uint32_t flags,
>                                  uint32_t data_type, uint32_t data_len,
>                                  void *data_ptr, uint32_t *out_hwpt);
> +int iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be, uint32_t hwpt_id,
> +                                       bool start);
>   
>   #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD TYPE_HOST_IOMMU_DEVICE "-iommufd"
> +
>   #endif
> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index f5f73eaf4a1a..69daabc27473 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -237,6 +237,26 @@ int iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t dev_id,
>       return ret;
>   }
>   
> +int iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be, uint32_t hwpt_id,
> +                                       bool start)
> +{
> +    int ret;
> +    struct iommu_hwpt_set_dirty_tracking set_dirty = {
> +            .size = sizeof(set_dirty),
> +            .hwpt_id = hwpt_id,
> +            .flags = !start ? 0 : IOMMU_HWPT_DIRTY_TRACKING_ENABLE,
> +    };
> +
> +    ret = ioctl(be->fd, IOMMU_HWPT_SET_DIRTY_TRACKING, &set_dirty);
> +    trace_iommufd_backend_set_dirty(be->fd, hwpt_id, start, ret);
> +    if (ret) {
> +        ret = -errno;
> +        error_report("IOMMU_HWPT_SET_DIRTY_TRACKING failed: %s",
> +                     strerror(errno));
> +    }
> +    return ret;
> +}
> +
>   bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
>                                        uint32_t *type, void *data, uint32_t len,
>                                        uint64_t *caps, Error **errp)
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 1b5b46d28ed6..158a98cb3b12 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -110,6 +110,48 @@ static void iommufd_cdev_unbind_and_disconnect(VFIODevice *vbasedev)
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
> +    int ret;
> +    VFIOIOASHwpt *hwpt;
> +
> +    QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
> +        if (!iommufd_hwpt_dirty_tracking(hwpt)) {
> +            continue;
> +        }
> +
> +        ret = iommufd_backend_set_dirty_tracking(container->be,
> +                                                 hwpt->hwpt_id, start);
> +        if (ret) {
> +            ret = -errno;
> +            error_setg_errno(errp, errno,
> +                             "Failed to start dirty tracking on hwpt_id %u",
> +                             hwpt->hwpt_id);



This error looks redundant with the one printed out in the lower backend
version. Couldn't we add an 'Error **' parameter and return a bool ?


Thanks,

C.

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
> +                                           hwpt->hwpt_id, !start);
> +    }
> +    return ret;
> +}
> +
>   static int iommufd_cdev_getfd(const char *sysfs_path, Error **errp)
>   {
>       ERRP_GUARD();
> @@ -292,7 +334,7 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>       QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
>       QLIST_INSERT_HEAD(&container->hwpt_list, hwpt, next);
>       container->bcontainer.dirty_pages_supported |=
> -                              (flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING);
> +                              iommufd_hwpt_dirty_tracking(hwpt);
>       return true;
>   }
>   
> @@ -734,6 +776,7 @@ static void vfio_iommu_iommufd_class_init(ObjectClass *klass, void *data)
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


