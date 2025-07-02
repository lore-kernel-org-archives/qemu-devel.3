Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30CF5C7EE30
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 09:41:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWtxV-0007s9-NG; Wed, 02 Jul 2025 05:40:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uWtxT-0007rb-AI
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 05:40:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uWtxP-00059f-6n
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 05:40:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751449242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=7EB32nMW+NfTgwnALYAiwheNNTW6vSfg07z9dHMaDhE=;
 b=TDlJI/QZItLVPk1aw0pcRLaUOA1btiisZwdXZ2RPQhfMMrOJ+srNSrtiHl9fFQM9D6UrT8
 TubdWmn01EHcD64+gEylqY7buzssUhIatcRXitHTD3rRVLBuwJlU/jGN+fhIdPezwnX6Jx
 fBTHsTGdqQZeQVoDGDW/livrm3w1UzU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-7iRmZDhbNWKZ3fqrbL0JGQ-1; Wed, 02 Jul 2025 05:40:41 -0400
X-MC-Unique: 7iRmZDhbNWKZ3fqrbL0JGQ-1
X-Mimecast-MFC-AGG-ID: 7iRmZDhbNWKZ3fqrbL0JGQ_1751449239
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-451d5600a54so45160015e9.2
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 02:40:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751449238; x=1752054038;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7EB32nMW+NfTgwnALYAiwheNNTW6vSfg07z9dHMaDhE=;
 b=kKkrfTXcfapV9pB+X20lc8moyO8oN7c67YQ6V6y+N1x6icEL0ylGKpPYJyd6sUCxJU
 cwL5Z7bGAdn7jZYzQUwIWtTNrDAepIryypTZzV7T+3YqgdCsoEowb0H8hOJ31CD/E8TE
 2if9rYui2VcWEOJEATTYY1/cH088kvqIEJDskX8J9woNnIoOsWdGw1TmAOGN6HDzhule
 SzgdsHJX9EWTxpPAesV8jvgLzYBAei860hUUTnaK1ojwX4Sv4ljYopzaRl/BtMlh6t75
 jabD55ZBRsSHSMlPxspSTvRGbDaF/fYmSQdMNAwtO4ZU7m8hlr+vP16mp4vE1evJKPwp
 QC8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRKFV6mD/cX1lWILFPO7BCuJezxPtZzvRC429XhKJP3RSboVXrrex+3B/pg55UnrZJIGMBTfUtWq+x@nongnu.org
X-Gm-Message-State: AOJu0Yz+RswbKpvvhgZy0epVIgiu3m1v3dnF2466EST8kgtmsWrttMyv
 8avx1v5kQ2zL3wuGFXgIdICN3fzAGrxDXDWxe5a/m/geYRiwqOgIdT9YPQ0HcpofEspL8e5rXI0
 QNH+Tz2l8L4xgzUubfu5gmqCEivbZ75+RBcTqE+xJD4NBe89O7E7rN/hvcUCU6OUG
X-Gm-Gg: ASbGncswMBKbdIvggz8bof4+uc0WQVr7OP75uD3jAQM1G99Dc+kdbQ9/mah7e9YqFw0
 cDkVk3WGLLHjUY6UU+Aac/zahDuJBMxUJ29hFwdXJf7KzAywCsJb8tvpIfyFPR3NBSR3FrYiaOW
 sM7pTPNA9svwYP92gQqpsYtn6RNoTgYhL426fWh/+iJSJk5yc2i3DTR30Q08E6pPCrO/dzIsZLd
 T9tVM39RpFpcwrtBxTE9ezNA0dtWQrIGo4kmXKpbLKqiYhItIK4s6ZBwoHv5wgkoVs6YhhpVhwr
 TxP5Dk1ctTf7Id9cgQkhVoTvMP6RV72o2Vkmf71I0vP6YGjq7Ad0Mg4sd4bZ
X-Received: by 2002:a05:600c:3b01:b0:451:df07:f437 with SMTP id
 5b1f17b1804b1-454a3732ff3mr28473925e9.30.1751449237796; 
 Wed, 02 Jul 2025 02:40:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQK6DkS8KPafhO+kBnbYdSTQw7ywJKANBtl1Opm/rdNR+X2r/nyaIDSc5aJbsN1nln7lszZA==
X-Received: by 2002:a05:600c:3b01:b0:451:df07:f437 with SMTP id
 5b1f17b1804b1-454a3732ff3mr28473535e9.30.1751449237181; 
 Wed, 02 Jul 2025 02:40:37 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538234bc1fsm221085285e9.14.2025.07.02.02.40.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 02:40:36 -0700 (PDT)
Message-ID: <be7b72b1-548d-4b0e-91b8-1f1650e56204@redhat.com>
Date: Wed, 2 Jul 2025 11:40:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/19] vfio-user: add vfio-user class and container
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Steve Sistare <steven.sistare@oracle.com>
References: <20250625193012.2316242-1-john.levon@nutanix.com>
 <20250625193012.2316242-2-john.levon@nutanix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250625193012.2316242-2-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

+Steve

On 6/25/25 21:29, John Levon wrote:
> Introduce basic plumbing for vfio-user with CONFIG_VFIO_USER.
> 
> We introduce VFIOUserContainer in hw/vfio-user/container.c, which is a
> container type for the "IOMMU" type "vfio-iommu-user", and share some
> common container code from hw/vfio/container.c.
> 
> Add hw/vfio-user/pci.c for instantiating VFIOUserPCIDevice objects,
> sharing some common code from hw/vfio/pci.c.
> 
> Originally-by: John Johnson <john.g.johnson@oracle.com>
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> Signed-off-by: John Levon <john.levon@nutanix.com>
> ---
>   MAINTAINERS                           |   8 +
>   hw/vfio-user/container.h              |  21 +++
>   include/hw/vfio/vfio-container-base.h |   1 +
>   hw/vfio-user/container.c              | 208 ++++++++++++++++++++++++++
>   hw/vfio-user/pci.c                    | 185 +++++++++++++++++++++++
>   hw/Kconfig                            |   1 +
>   hw/meson.build                        |   1 +
>   hw/vfio-user/Kconfig                  |   7 +
>   hw/vfio-user/meson.build              |   9 ++
>   9 files changed, 441 insertions(+)
>   create mode 100644 hw/vfio-user/container.h
>   create mode 100644 hw/vfio-user/container.c
>   create mode 100644 hw/vfio-user/pci.c
>   create mode 100644 hw/vfio-user/Kconfig
>   create mode 100644 hw/vfio-user/meson.build
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 27f4fe3f25..2369391004 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4253,6 +4253,14 @@ F: hw/remote/iommu.c
>   F: include/hw/remote/iommu.h
>   F: tests/functional/test_multiprocess.py
>   
> +VFIO-USER:
> +M: John Levon <john.levon@nutanix.com>
> +M: Thanos Makatos <thanos.makatos@nutanix.com>
> +S: Supported
> +F: hw/vfio-user/*
> +F: include/hw/vfio-user/*
> +F: subprojects/libvfio-user
> +
>   EBPF:
>   M: Jason Wang <jasowang@redhat.com>
>   R: Andrew Melnychenko <andrew@daynix.com>
> diff --git a/hw/vfio-user/container.h b/hw/vfio-user/container.h
> new file mode 100644
> index 0000000000..e4a46d2c1b
> --- /dev/null
> +++ b/hw/vfio-user/container.h
> @@ -0,0 +1,21 @@
> +/*
> + * vfio-user specific definitions.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_VFIO_USER_CONTAINER_H
> +#define HW_VFIO_USER_CONTAINER_H
> +
> +#include "qemu/osdep.h"
> +
> +#include "hw/vfio/vfio-container-base.h"
> +
> +/* MMU container sub-class for vfio-user. */
> +typedef struct VFIOUserContainer {
> +    VFIOContainerBase bcontainer;
> +} VFIOUserContainer;
> +
> +OBJECT_DECLARE_SIMPLE_TYPE(VFIOUserContainer, VFIO_IOMMU_USER);
> +
> +#endif /* HW_VFIO_USER_CONTAINER_H */
> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
> index f0232654ee..3cd86ec59e 100644
> --- a/include/hw/vfio/vfio-container-base.h
> +++ b/include/hw/vfio/vfio-container-base.h
> @@ -109,6 +109,7 @@ vfio_container_get_page_size_mask(const VFIOContainerBase *bcontainer)
>   #define TYPE_VFIO_IOMMU_LEGACY TYPE_VFIO_IOMMU "-legacy"
>   #define TYPE_VFIO_IOMMU_SPAPR TYPE_VFIO_IOMMU "-spapr"
>   #define TYPE_VFIO_IOMMU_IOMMUFD TYPE_VFIO_IOMMU "-iommufd"
> +#define TYPE_VFIO_IOMMU_USER TYPE_VFIO_IOMMU "-user"
>   
>   OBJECT_DECLARE_TYPE(VFIOContainerBase, VFIOIOMMUClass, VFIO_IOMMU)
>   
> diff --git a/hw/vfio-user/container.c b/hw/vfio-user/container.c
> new file mode 100644
> index 0000000000..2367332177
> --- /dev/null
> +++ b/hw/vfio-user/container.c
> @@ -0,0 +1,208 @@
> +/*
> + * Container for vfio-user IOMMU type: rather than communicating with the kernel
> + * vfio driver, we communicate over a socket to a server using the vfio-user
> + * protocol.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include <sys/ioctl.h>
> +#include <linux/vfio.h>
> +#include "qemu/osdep.h"
> +
> +#include "hw/vfio-user/container.h"
> +#include "hw/vfio/vfio-cpr.h"
> +#include "hw/vfio/vfio-device.h"
> +#include "hw/vfio/vfio-listener.h"
> +#include "qapi/error.h"
> +
> +static int vfio_user_dma_unmap(const VFIOContainerBase *bcontainer,
> +                               hwaddr iova, ram_addr_t size,
> +                               IOMMUTLBEntry *iotlb, bool unmap_all)
> +{
> +    return -ENOTSUP;
> +}
> +
> +static int vfio_user_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
> +                             ram_addr_t size, void *vaddr, bool readonly,
> +                             MemoryRegion *mrp)
> +{
> +    return -ENOTSUP;
> +}
> +
> +static int
> +vfio_user_set_dirty_page_tracking(const VFIOContainerBase *bcontainer,
> +                                    bool start, Error **errp)
> +{
> +    error_setg_errno(errp, ENOTSUP, "Not supported");
> +    return -ENOTSUP;
> +}
> +
> +static int vfio_user_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
> +                                         VFIOBitmap *vbmap, hwaddr iova,
> +                                         hwaddr size, Error **errp)
> +{
> +    error_setg_errno(errp, ENOTSUP, "Not supported");
> +    return -ENOTSUP;
> +}
> +
> +static bool vfio_user_setup(VFIOContainerBase *bcontainer, Error **errp)
> +{
> +    error_setg_errno(errp, ENOTSUP, "Not supported");
> +    return -ENOTSUP;
> +}
> +
> +static VFIOUserContainer *vfio_user_create_container(Error **errp)
> +{
> +    VFIOUserContainer *container;
> +
> +    container = VFIO_IOMMU_USER(object_new(TYPE_VFIO_IOMMU_USER));
> +    return container;
> +}
> +
> +/*
> + * Try to mirror vfio_container_connect() as much as possible.
> + */
> +static VFIOUserContainer *
> +vfio_user_container_connect(AddressSpace *as, Error **errp)
> +{
> +    VFIOContainerBase *bcontainer;
> +    VFIOUserContainer *container;
> +    VFIOAddressSpace *space;
> +    VFIOIOMMUClass *vioc;
> +
> +    space = vfio_address_space_get(as);
> +
> +    container = vfio_user_create_container(errp);
> +    if (!container) {
> +        goto put_space_exit;
> +    }
> +
> +    bcontainer = &container->bcontainer;
> +
> +    if (!vfio_cpr_register_container(bcontainer, errp)) {
> +        goto free_container_exit;
> +    }

I missed the CPR usage in vfio-user when reviewing and I think it should
be addressed in a separate series. This also interferes with Steve's "live
update" changes.

John,

Could please drop the CPR register ?


Thanks,

C.


  

> +
> +    vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
> +    assert(vioc->setup);
> +
> +    if (!vioc->setup(bcontainer, errp)) {
> +        goto unregister_container_exit;
> +    }
> +
> +    vfio_address_space_insert(space, bcontainer);
> +
> +    if (!vfio_listener_register(bcontainer, errp)) {
> +        goto listener_release_exit;
> +    }
> +
> +    bcontainer->initialized = true;
> +
> +    return container;
> +
> +listener_release_exit:
> +    vfio_listener_unregister(bcontainer);
> +    if (vioc->release) {
> +        vioc->release(bcontainer);
> +    }
> +
> +unregister_container_exit:
> +    vfio_cpr_unregister_container(bcontainer);
> +
> +free_container_exit:
> +    object_unref(container);
> +
> +put_space_exit:
> +    vfio_address_space_put(space);
> +
> +    return NULL;
> +}
> +
> +static void vfio_user_container_disconnect(VFIOUserContainer *container)
> +{
> +    VFIOContainerBase *bcontainer = &container->bcontainer;
> +    VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
> +
> +    vfio_listener_unregister(bcontainer);
> +    if (vioc->release) {
> +        vioc->release(bcontainer);
> +    }
> +
> +    VFIOAddressSpace *space = bcontainer->space;
> +
> +    vfio_cpr_unregister_container(bcontainer);
> +    object_unref(container);
> +
> +    vfio_address_space_put(space);
> +}
> +
> +static bool vfio_user_device_get(VFIOUserContainer *container,
> +                                 VFIODevice *vbasedev, Error **errp)
> +{
> +    struct vfio_device_info info = { 0 };
> +
> +    vbasedev->fd = -1;
> +
> +    vfio_device_prepare(vbasedev, &container->bcontainer, &info);
> +
> +    return true;
> +}
> +
> +/*
> + * vfio_user_device_attach: attach a device to a new container.
> + */
> +static bool vfio_user_device_attach(const char *name, VFIODevice *vbasedev,
> +                                    AddressSpace *as, Error **errp)
> +{
> +    VFIOUserContainer *container;
> +
> +    container = vfio_user_container_connect(as, errp);
> +    if (container == NULL) {
> +        error_prepend(errp, "failed to connect proxy");
> +        return false;
> +    }
> +
> +    return vfio_user_device_get(container, vbasedev, errp);
> +}
> +
> +static void vfio_user_device_detach(VFIODevice *vbasedev)
> +{
> +    VFIOUserContainer *container = container_of(vbasedev->bcontainer,
> +                                                VFIOUserContainer, bcontainer);
> +
> +    vfio_device_unprepare(vbasedev);
> +
> +    vfio_user_container_disconnect(container);
> +}
> +
> +static int vfio_user_pci_hot_reset(VFIODevice *vbasedev, bool single)
> +{
> +    /* ->needs_reset is always false for vfio-user. */
> +    return 0;
> +}
> +
> +static void vfio_iommu_user_class_init(ObjectClass *klass, const void *data)
> +{
> +    VFIOIOMMUClass *vioc = VFIO_IOMMU_CLASS(klass);
> +
> +    vioc->setup = vfio_user_setup;
> +    vioc->dma_map = vfio_user_dma_map;
> +    vioc->dma_unmap = vfio_user_dma_unmap;
> +    vioc->attach_device = vfio_user_device_attach;
> +    vioc->detach_device = vfio_user_device_detach;
> +    vioc->set_dirty_page_tracking = vfio_user_set_dirty_page_tracking;
> +    vioc->query_dirty_bitmap = vfio_user_query_dirty_bitmap;
> +    vioc->pci_hot_reset = vfio_user_pci_hot_reset;
> +};
> +
> +static const TypeInfo types[] = {
> +    {
> +        .name = TYPE_VFIO_IOMMU_USER,
> +        .parent = TYPE_VFIO_IOMMU,
> +        .instance_size = sizeof(VFIOUserContainer),
> +        .class_init = vfio_iommu_user_class_init,
> +    },
> +};
> +
> +DEFINE_TYPES(types)
> diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
> new file mode 100644
> index 0000000000..86d7055747
> --- /dev/null
> +++ b/hw/vfio-user/pci.c
> @@ -0,0 +1,185 @@
> +/*
> + * vfio PCI device over a UNIX socket.
> + *
> + * Copyright © 2018, 2021 Oracle and/or its affiliates.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include <sys/ioctl.h>
> +#include "qemu/osdep.h"
> +#include "qapi-visit-sockets.h"
> +
> +#include "hw/qdev-properties.h"
> +#include "hw/vfio/pci.h"
> +
> +#define TYPE_VFIO_USER_PCI "vfio-user-pci"
> +OBJECT_DECLARE_SIMPLE_TYPE(VFIOUserPCIDevice, VFIO_USER_PCI)
> +
> +struct VFIOUserPCIDevice {
> +    VFIOPCIDevice device;
> +    SocketAddress *socket;
> +};
> +
> +/*
> + * Emulated devices don't use host hot reset
> + */
> +static void vfio_user_compute_needs_reset(VFIODevice *vbasedev)
> +{
> +    vbasedev->needs_reset = false;
> +}
> +
> +static Object *vfio_user_pci_get_object(VFIODevice *vbasedev)
> +{
> +    VFIOUserPCIDevice *vdev = container_of(vbasedev, VFIOUserPCIDevice,
> +                                           device.vbasedev);
> +
> +    return OBJECT(vdev);
> +}
> +
> +static VFIODeviceOps vfio_user_pci_ops = {
> +    .vfio_compute_needs_reset = vfio_user_compute_needs_reset,
> +    .vfio_eoi = vfio_pci_intx_eoi,
> +    .vfio_get_object = vfio_user_pci_get_object,
> +    /* No live migration support yet. */
> +    .vfio_save_config = NULL,
> +    .vfio_load_config = NULL,
> +};
> +
> +static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
> +{
> +    ERRP_GUARD();
> +    VFIOUserPCIDevice *udev = VFIO_USER_PCI(pdev);
> +    VFIOPCIDevice *vdev = VFIO_PCI_BASE(pdev);
> +    VFIODevice *vbasedev = &vdev->vbasedev;
> +    const char *sock_name;
> +    AddressSpace *as;
> +
> +    if (!udev->socket) {
> +        error_setg(errp, "No socket specified");
> +        error_append_hint(errp, "e.g. -device '{"
> +            "\"driver\":\"vfio-user-pci\", "
> +            "\"socket\": {\"path\": \"/tmp/vfio-user.sock\", "
> +            "\"type\": \"unix\"}'"
> +            "}'\n");
> +        return;
> +    }
> +
> +    sock_name = udev->socket->u.q_unix.path;
> +
> +    vbasedev->name = g_strdup_printf("vfio-user:%s", sock_name);
> +
> +    /*
> +     * vfio-user devices are effectively mdevs (don't use a host iommu).
> +     */
> +    vbasedev->mdev = true;
> +
> +    as = pci_device_iommu_address_space(pdev);
> +    if (!vfio_device_attach_by_iommu_type(TYPE_VFIO_IOMMU_USER,
> +                                          vbasedev->name, vbasedev,
> +                                          as, errp)) {
> +        error_prepend(errp, VFIO_MSG_PREFIX, vbasedev->name);
> +        return;
> +    }
> +}
> +
> +static void vfio_user_instance_init(Object *obj)
> +{
> +    PCIDevice *pci_dev = PCI_DEVICE(obj);
> +    VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
> +    VFIODevice *vbasedev = &vdev->vbasedev;
> +
> +    device_add_bootindex_property(obj, &vdev->bootindex,
> +                                  "bootindex", NULL,
> +                                  &pci_dev->qdev);
> +    vdev->host.domain = ~0U;
> +    vdev->host.bus = ~0U;
> +    vdev->host.slot = ~0U;
> +    vdev->host.function = ~0U;
> +
> +    vfio_device_init(vbasedev, VFIO_DEVICE_TYPE_PCI, &vfio_user_pci_ops,
> +                     DEVICE(vdev), false);
> +
> +    vdev->nv_gpudirect_clique = 0xFF;
> +
> +    /*
> +     * QEMU_PCI_CAP_EXPRESS initialization does not depend on QEMU command
> +     * line, therefore, no need to wait to realize like other devices.
> +     */
> +    pci_dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
> +}
> +
> +static void vfio_user_instance_finalize(Object *obj)
> +{
> +    VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
> +
> +    vfio_pci_put_device(vdev);
> +}
> +
> +static const Property vfio_user_pci_dev_properties[] = {
> +    DEFINE_PROP_UINT32("x-pci-vendor-id", VFIOPCIDevice,
> +                       vendor_id, PCI_ANY_ID),
> +    DEFINE_PROP_UINT32("x-pci-device-id", VFIOPCIDevice,
> +                       device_id, PCI_ANY_ID),
> +    DEFINE_PROP_UINT32("x-pci-sub-vendor-id", VFIOPCIDevice,
> +                       sub_vendor_id, PCI_ANY_ID),
> +    DEFINE_PROP_UINT32("x-pci-sub-device-id", VFIOPCIDevice,
> +                       sub_device_id, PCI_ANY_ID),
> +};
> +
> +static void vfio_user_pci_set_socket(Object *obj, Visitor *v, const char *name,
> +                                     void *opaque, Error **errp)
> +{
> +    VFIOUserPCIDevice *udev = VFIO_USER_PCI(obj);
> +    bool success;
> +
> +    qapi_free_SocketAddress(udev->socket);
> +
> +    udev->socket = NULL;
> +
> +    success = visit_type_SocketAddress(v, name, &udev->socket, errp);
> +
> +    if (!success) {
> +        return;
> +    }
> +
> +    if (udev->socket->type != SOCKET_ADDRESS_TYPE_UNIX) {
> +        error_setg(errp, "Unsupported socket type %s",
> +                   SocketAddressType_str(udev->socket->type));
> +        qapi_free_SocketAddress(udev->socket);
> +        udev->socket = NULL;
> +        return;
> +    }
> +}
> +
> +static void vfio_user_pci_dev_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    PCIDeviceClass *pdc = PCI_DEVICE_CLASS(klass);
> +
> +    device_class_set_props(dc, vfio_user_pci_dev_properties);
> +
> +    object_class_property_add(klass, "socket", "SocketAddress", NULL,
> +                              vfio_user_pci_set_socket, NULL, NULL);
> +    object_class_property_set_description(klass, "socket",
> +                                          "SocketAddress (UNIX sockets only)");
> +
> +    dc->desc = "VFIO over socket PCI device assignment";
> +    pdc->realize = vfio_user_pci_realize;
> +}
> +
> +static const TypeInfo vfio_user_pci_dev_info = {
> +    .name = TYPE_VFIO_USER_PCI,
> +    .parent = TYPE_VFIO_PCI_BASE,
> +    .instance_size = sizeof(VFIOUserPCIDevice),
> +    .class_init = vfio_user_pci_dev_class_init,
> +    .instance_init = vfio_user_instance_init,
> +    .instance_finalize = vfio_user_instance_finalize,
> +};
> +
> +static void register_vfio_user_dev_type(void)
> +{
> +    type_register_static(&vfio_user_pci_dev_info);
> +}
> +
> + type_init(register_vfio_user_dev_type)
> diff --git a/hw/Kconfig b/hw/Kconfig
> index 9a86a6a28a..9e6c789ae7 100644
> --- a/hw/Kconfig
> +++ b/hw/Kconfig
> @@ -42,6 +42,7 @@ source ufs/Kconfig
>   source usb/Kconfig
>   source virtio/Kconfig
>   source vfio/Kconfig
> +source vfio-user/Kconfig
>   source vmapple/Kconfig
>   source xen/Kconfig
>   source watchdog/Kconfig
> diff --git a/hw/meson.build b/hw/meson.build
> index b91f761fe0..791ce21ab4 100644
> --- a/hw/meson.build
> +++ b/hw/meson.build
> @@ -39,6 +39,7 @@ subdir('uefi')
>   subdir('ufs')
>   subdir('usb')
>   subdir('vfio')
> +subdir('vfio-user')
>   subdir('virtio')
>   subdir('vmapple')
>   subdir('watchdog')
> diff --git a/hw/vfio-user/Kconfig b/hw/vfio-user/Kconfig
> new file mode 100644
> index 0000000000..24bdf7af90
> --- /dev/null
> +++ b/hw/vfio-user/Kconfig
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +config VFIO_USER
> +    bool
> +    default y
> +    depends on VFIO_PCI
> +
> diff --git a/hw/vfio-user/meson.build b/hw/vfio-user/meson.build
> new file mode 100644
> index 0000000000..b82c558252
> --- /dev/null
> +++ b/hw/vfio-user/meson.build
> @@ -0,0 +1,9 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +vfio_user_ss = ss.source_set()
> +vfio_user_ss.add(files(
> +  'container.c',
> +  'pci.c',
> +))
> +
> +system_ss.add_all(when: 'CONFIG_VFIO_USER', if_true: vfio_user_ss)


