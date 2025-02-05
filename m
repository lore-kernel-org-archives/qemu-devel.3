Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9D81C02192
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 17:45:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfjSv-0000yS-BA; Wed, 05 Feb 2025 12:45:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tfjSg-0000x0-6J
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 12:45:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tfjSa-0002o7-3B
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 12:45:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738777510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=qgbRWZPmem0dn5MbC65zsT8ZVYv9ctIb96GI430D/Pk=;
 b=Fd85H9K6EUE+pXk7Azy/VhpYAJRo9VWHtzm40SAiyqoTH4rX7W77/DflSs8wTMsFBFYbWw
 +gv4r/dWuqPgYYwj4gjQ58H7DVtR9x1hLulYsVOF9UshmEFeIuBKYY9DnZb/aLqLnJRNIR
 BWPWKGY7+wQTi6SeQZ5glI7IYmeodtg=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-lRSJXHiwNamndEjkZh_f3A-1; Wed, 05 Feb 2025 12:45:09 -0500
X-MC-Unique: lRSJXHiwNamndEjkZh_f3A-1
X-Mimecast-MFC-AGG-ID: lRSJXHiwNamndEjkZh_f3A
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7b6ef813ed1so1035267185a.3
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2025 09:45:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738777508; x=1739382308;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qgbRWZPmem0dn5MbC65zsT8ZVYv9ctIb96GI430D/Pk=;
 b=csDMKxAnyCMyV3Wgp9ZryRTex/5zFbX/hRZpnjavqS2ORdeXceVsZMUZh7ysyuY3vm
 DsMHUkU/+YncycCr63MY1bFT5hmWZ5qE9Gx+GAUp9tQyES43uGWkF5R5LqhXfbLG6KFR
 Sg8OowuupkyWx5mFVzRDITMk/pMPh7IWiRRn7/eNeFyFBJhDOtscIbSAh5WRdpkro2nH
 I87yj8d83Hg9FhLb4XYyRr4Z4B1VgBeomRMZPGz6t7/HJEIGGhR4YSWTjttZSsL5E0gr
 wNGgr8AAG3Q5SQ2EHrdKPsmjqTnZ5qCtcEhE5FTQQ93YP2DxnDp2vJMSlwwINO1HVyWZ
 kGHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCkptP5xfE3k1MdNCeVal4uQDoqk6uxQwJcy8f9sdRmCygWVBZJzwhEBY8f+n94KAEQ01Mc8H2Yykm@nongnu.org
X-Gm-Message-State: AOJu0YzBXtQsVrnjyqRNjj8t/CMkrUTCInCLpinOil/iNrna8U19Ypgq
 qhrR8aUd43hhrtXB8NJ3LV2dndAIRGpcdiHZhw1nYVLsMvcs4w2oBu/+eItUnju26Y1+0z75aXc
 3X0ZgwIiV9cUwm6yZt2LlgGpTsMhwAn8vg9m5RgIYGESlwhF1G50AuH+0QDG8
X-Gm-Gg: ASbGncuTckUw97oZ2JOA+WROUIrNFvTNuEXJCSXjVp/Owdb4fJFTzGcgMXa6oGO05b/
 N62bfrsh3zWVYVDY4jQMk3GWA4TuaCV+cBKrAaSCcesSOCk/VRpLo9T/Jlh2b43X3PrbkPzJlFg
 yGtEYfKnDyaU1tsrMJ9/kEajHCiRYqtb6+6BpN0RFU08GBXZQd5J/Kd+1yZYOr+aFF0xFtSaAWX
 n8O5nyQ+OAWBuxJ/qLwthCTrO3IFraemRC5qOi8uoX3ajBH40WiguMzBEN9haZdZxuhqlb1B5XV
 a1kp1UEh1JtYJyjfWHvKFHFe5RsQlNsTcux4/RrA3HA=
X-Received: by 2002:a05:620a:1707:b0:7b6:efd0:3d1e with SMTP id
 af79cd13be357-7c03a04250amr478104785a.53.1738777508340; 
 Wed, 05 Feb 2025 09:45:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHt3oNoPbMolxEIU3V7EHHHJYhmGpZIi7lwr3ilinhzzgY1d09rzbJ6IWHQwovNhc58Kj/ffg==
X-Received: by 2002:a05:620a:1707:b0:7b6:efd0:3d1e with SMTP id
 af79cd13be357-7c03a04250amr478100685a.53.1738777507978; 
 Wed, 05 Feb 2025 09:45:07 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c00a8d947asm768956585a.50.2025.02.05.09.45.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Feb 2025 09:45:07 -0800 (PST)
Message-ID: <8fdf7ccf-455d-4bbf-9630-5b46a7fabc16@redhat.com>
Date: Wed, 5 Feb 2025 18:45:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 23/26] vfio/iommufd: register container for cpr
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu
 <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <1738161802-172631-1-git-send-email-steven.sistare@oracle.com>
 <1738161802-172631-24-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <1738161802-172631-24-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 1/29/25 15:43, Steve Sistare wrote:
> Register a vfio iommufd container for CPR.  Add a blocker if the kernel does
> not support IOMMU_IOAS_CHANGE_PROCESS.
> 
> This is mostly boiler plate.  The fields to to saved and restored are added
> in subsequent patches.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   hw/vfio/cpr-iommufd.c         | 96 +++++++++++++++++++++++++++++++++++++++++++
>   hw/vfio/iommufd.c             | 12 +++---
>   hw/vfio/meson.build           |  1 +
>   include/hw/vfio/vfio-common.h |  6 +++
>   4 files changed, 110 insertions(+), 5 deletions(-)
>   create mode 100644 hw/vfio/cpr-iommufd.c
> 
> diff --git a/hw/vfio/cpr-iommufd.c b/hw/vfio/cpr-iommufd.c
> new file mode 100644
> index 0000000..4eb358a
> --- /dev/null
> +++ b/hw/vfio/cpr-iommufd.c
> @@ -0,0 +1,96 @@
> +/*
> + * Copyright (c) 2024-2025 Oracle and/or its affiliates.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "hw/vfio/vfio-common.h"
> +#include "migration/blocker.h"
> +#include "migration/cpr.h"
> +#include "migration/migration.h"
> +#include "migration/vmstate.h"
> +#include "system/iommufd.h"
> +
> +static bool vfio_cpr_supported(VFIOIOMMUFDContainer *container, Error **errp)
> +{
> +    if (!iommufd_change_process_capable(container->be)) {
> +        error_setg(errp,
> +                   "VFIO container does not support IOMMU_IOAS_CHANGE_PROCESS");
> +        return false;
> +    }
> +    return true;
> +}
> +
> +static const VMStateDescription vfio_container_vmstate = {
> +    .name = "vfio-iommufd-container",
> +    .version_id = 0,
> +    .minimum_version_id = 0,
> +    .needed = cpr_needed_for_reuse,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static const VMStateDescription iommufd_cpr_vmstate = {
> +    .name = "iommufd",
> +    .version_id = 0,
> +    .minimum_version_id = 0,
> +    .needed = cpr_needed_for_reuse,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +bool vfio_iommufd_cpr_register_container(VFIOIOMMUFDContainer *container,
> +                                         Error **errp)
> +{
> +    VFIOContainerBase *bcontainer = &container->bcontainer;
> +    Error **cpr_blocker = &container->cpr_blocker;
> +
> +    if (!vfio_cpr_register_container(bcontainer, errp)) {
> +        return false;
> +    }
> +
> +    if (!vfio_cpr_supported(container, cpr_blocker)) {
> +        return migrate_add_blocker_modes(cpr_blocker, errp,
> +                                         MIG_MODE_CPR_TRANSFER, -1) == 0;
> +    }
> +
> +    vmstate_register(NULL, -1, &vfio_container_vmstate, container);
> +    vmstate_register(NULL, -1, &iommufd_cpr_vmstate, container->be);
> +
> +    return true;
> +}
> +
> +void vfio_iommufd_cpr_unregister_container(VFIOIOMMUFDContainer *container)
> +{
> +    VFIOContainerBase *bcontainer = &container->bcontainer;
> +
> +    vmstate_unregister(NULL, &iommufd_cpr_vmstate, container->be);
> +    vmstate_unregister(NULL, &vfio_container_vmstate, container);
> +    migrate_del_blocker(&container->cpr_blocker);
> +    vfio_cpr_unregister_container(bcontainer);
> +}
> +
> +static const VMStateDescription vfio_device_vmstate = {
> +    .name = "vfio-iommufd-device",
> +    .version_id = 0,
> +    .minimum_version_id = 0,
> +    .needed = cpr_needed_for_reuse,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +void vfio_iommufd_cpr_register_device(VFIODevice *vbasedev)
> +{
> +    vmstate_register(NULL, -1, &vfio_device_vmstate, vbasedev);
> +}
> +
> +void vfio_iommufd_cpr_unregister_device(VFIODevice *vbasedev)
> +{
> +    vmstate_unregister(NULL, &vfio_device_vmstate, vbasedev);
> +}
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 8308715..ae78e00 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -592,6 +592,10 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
>   
>       bcontainer->initialized = true;
>   
> +    if (!vfio_iommufd_cpr_register_container(container, errp)) {
> +        goto err_listener_register;
> +    }
> +

why this change ?


Thanks,

C.



>   found_container:
>       ret = ioctl(devfd, VFIO_DEVICE_GET_INFO, &dev_info);
>       if (ret) {
> @@ -599,10 +603,6 @@ found_container:
>           goto err_listener_register;
>       }
>   
> -    if (!vfio_cpr_register_container(bcontainer, errp)) {
> -        goto err_listener_register;
> -    }
> -
>       /*
>        * TODO: examine RAM_BLOCK_DISCARD stuff, should we do group level
>        * for discarding incompatibility check as well?
> @@ -619,6 +619,7 @@ found_container:
>       vbasedev->bcontainer = bcontainer;
>       QLIST_INSERT_HEAD(&bcontainer->device_list, vbasedev, container_next);
>       QLIST_INSERT_HEAD(&vfio_device_list, vbasedev, global_next);
> +    vfio_iommufd_cpr_register_device(vbasedev);
>   
>       trace_iommufd_cdev_device_info(vbasedev->name, devfd, vbasedev->num_irqs,
>                                      vbasedev->num_regions, vbasedev->flags);
> @@ -653,12 +654,13 @@ static void iommufd_cdev_detach(VFIODevice *vbasedev)
>           iommufd_cdev_ram_block_discard_disable(false);
>       }
>   
> -    vfio_cpr_unregister_container(bcontainer);
> +    vfio_iommufd_cpr_unregister_container(container);
>       iommufd_cdev_detach_container(vbasedev, container);
>       iommufd_cdev_container_destroy(container);
>       vfio_put_address_space(space);
>   
>       migrate_del_blocker(&vbasedev->cpr_id_blocker);
> +    vfio_iommufd_cpr_unregister_device(vbasedev);
>       iommufd_cdev_unbind_and_disconnect(vbasedev);
>       close(vbasedev->fd);
>   }
> diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
> index 5487815..998adb5 100644
> --- a/hw/vfio/meson.build
> +++ b/hw/vfio/meson.build
> @@ -13,6 +13,7 @@ vfio_ss.add(when: 'CONFIG_IOMMUFD', if_true: files(
>   vfio_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
>     'cpr.c',
>     'cpr-legacy.c',
> +  'cpr-iommufd.c',
>     'display.c',
>     'pci-quirks.c',
>     'pci.c',
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 37e7c26..add44d4 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -113,6 +113,7 @@ typedef struct VFIOIOASHwpt {
>   typedef struct VFIOIOMMUFDContainer {
>       VFIOContainerBase bcontainer;
>       IOMMUFDBackend *be;
> +    Error *cpr_blocker;
>       uint32_t ioas_id;
>       QLIST_HEAD(, VFIOIOASHwpt) hwpt_list;
>   } VFIOIOMMUFDContainer;
> @@ -271,6 +272,11 @@ bool vfio_legacy_cpr_register_container(VFIOContainer *container, Error **errp);
>   void vfio_legacy_cpr_unregister_container(VFIOContainer *container);
>   bool iommufd_cdev_get_info_iova_range(VFIOIOMMUFDContainer *container,
>                                         uint32_t ioas_id, Error **errp);
> +bool vfio_iommufd_cpr_register_container(VFIOIOMMUFDContainer *container,
> +                                         Error **errp);
> +void vfio_iommufd_cpr_unregister_container(VFIOIOMMUFDContainer *container);
> +void vfio_iommufd_cpr_register_device(VFIODevice *vbasedev);
> +void vfio_iommufd_cpr_unregister_device(VFIODevice *vbasedev);
>   
>   extern const MemoryRegionOps vfio_region_ops;
>   typedef QLIST_HEAD(VFIOGroupList, VFIOGroup) VFIOGroupList;


