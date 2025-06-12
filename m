Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60DFAC61CE8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 06:40:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPbb1-0001UZ-RM; Thu, 12 Jun 2025 02:39:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uPbb0-0001UG-4p
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 02:39:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uPbav-0008A8-Dl
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 02:39:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749710363;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=kXnN02I0e2K8GXSwTrhKc1qtUscUJbeKAMpqaYp3/+c=;
 b=hdkBrOwzh/+eoh4M/HiD8E0NTjI9stY9D0rlSDzubJnfcQF4La2tap3xgafP4mlZ7AepTT
 msgdIQ9y3wm9c8wLOIzoM9fDmRaUzsb2kBeylboFT1wcROplZjcDfbEZxKrIkkwt3MI1d6
 pzyf7Hgk46pu0qmpA3penPflYGvq0BY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-ECuXofYtMLyM_MQ7X3QE0Q-1; Thu, 12 Jun 2025 02:39:21 -0400
X-MC-Unique: ECuXofYtMLyM_MQ7X3QE0Q-1
X-Mimecast-MFC-AGG-ID: ECuXofYtMLyM_MQ7X3QE0Q_1749710360
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a50816ccc6so297545f8f.1
 for <qemu-devel@nongnu.org>; Wed, 11 Jun 2025 23:39:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749710360; x=1750315160;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kXnN02I0e2K8GXSwTrhKc1qtUscUJbeKAMpqaYp3/+c=;
 b=A9GHjfZ7ot+RaSwG/cw9ja+hrATerM7Hs6B6+G0kCyEUcbMZWWInfxG412zBc126PW
 6DCxHOjkiuV38rGapwP5KLQCvNG+3NiEAP5Q6pKbtacsI4H3bLuJk3qo8+F7ha95186k
 TZEf5CLRPjuQw6+q19WhzcCHX4Y4dx6cPzzAmM51pbMl4vTcsExhfT9XfqWBTROOrTgS
 aOxrUHSgt6NusuwaCizptfnzBErDifD5lHSNBZs+PNO4qv/+etD3Y/Nmz791PFZ+BOGI
 zmzojXd/3lOFDGLBwWTpBjY5305Ba0SXjdqZKbrfIzSd3WBYeC3FMvR8qgtOVv8fY2Fb
 /glA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwWGM3WT031cMqsutcWgYAm20jH+769OtoKFuaFe+ZWuDx8NjzLhORdrWXt339j0grrNptizdAiX24@nongnu.org
X-Gm-Message-State: AOJu0Yx1G60fX8IOoCaSUkle6nGagsDMIBlboJxWJdc6H70RWyZsIZhZ
 QJ4h9gC32cxI3p5DNNeyrwQeeKVgyBYSCuXaL+8K/clQor5go4NhSQjhkZX6zrFDcTT1BfrKfin
 aMBJ/xYVGaR9E/aXEAaOCav9pRz3UgbcRdmeFZ/k4D9Vn+eEj6oOnKJlX
X-Gm-Gg: ASbGncsFmSD6SCba89+u4fwehpNOSrRBLRu19wh8URrvHSIaotqP27pzdkQma4xDBDy
 RiWbyu23Z0x/e4OYWQXiLn7xwRgDtKl81n5k0tRrx0aUL6A0VgSQ2n1c3u1tqDV+gcmyMEfmJCS
 0KdKwObwxmJ6Ohw2ycDvDaPwqZtPNbetGnL4Jp8rX+8kdy+wg2JVXtC23qH1KiB+D6hTjU33i7b
 ZorNgpxtY8a4PGWbYw0mZosBeIUW0iPL2KKtxuYEHXlnhF9ursUSAVhT0LcXupn/fhmb+gGiPTX
 VWjaigO5+dP/vhnVSjhEUSx4tpFoLDHbewU0KH+vitZcbgD+7FmjPsruvc8C
X-Received: by 2002:a5d:5f84:0:b0:3a4:db49:94aa with SMTP id
 ffacd0b85a97d-3a56128d18bmr1095804f8f.21.1749710360149; 
 Wed, 11 Jun 2025 23:39:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVkhBSVtXU0U6fiLjXVYGMb0TGkrEZ6x7dky1B7BTHdtSpYMcE04M7Ic9EmNHEsQ+nmhDskQ==
X-Received: by 2002:a5d:5f84:0:b0:3a4:db49:94aa with SMTP id
 ffacd0b85a97d-3a56128d18bmr1095775f8f.21.1749710359614; 
 Wed, 11 Jun 2025 23:39:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a561a3ce55sm1020279f8f.65.2025.06.11.23.39.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Jun 2025 23:39:18 -0700 (PDT)
Message-ID: <daaf6576-abf8-4c0f-9070-8dfb0234d6db@redhat.com>
Date: Thu, 12 Jun 2025 08:39:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/23] vfio-user: add vfio-user class and container
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
References: <20250607001056.335310-1-john.levon@nutanix.com>
 <20250607001056.335310-7-john.levon@nutanix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250607001056.335310-7-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 6/7/25 02:10, John Levon wrote:
> Introduce basic plumbing for vfio-user behind a new
> --enable-vfio-user-client option.
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
>   MAINTAINERS                           |   2 +
>   hw/vfio-user/container.h              |  25 +++
>   include/hw/vfio/vfio-container-base.h |   1 +
>   hw/vfio-user/container.c              | 212 ++++++++++++++++++++++++++
>   hw/vfio-user/pci.c                    | 155 +++++++++++++++++++
>   hw/meson.build                        |   1 +
>   hw/vfio-user/meson.build              |   9 ++
>   meson_options.txt                     |   2 +
>   scripts/meson-buildoptions.sh         |   4 +
>   9 files changed, 411 insertions(+)
>   create mode 100644 hw/vfio-user/container.h
>   create mode 100644 hw/vfio-user/container.c
>   create mode 100644 hw/vfio-user/pci.c
>   create mode 100644 hw/vfio-user/meson.build
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index dbc393989a..328bab8d19 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4252,6 +4252,8 @@ M: John Levon <john.levon@nutanix.com>
>   M: Thanos Makatos <thanos.makatos@nutanix.com>
>   S: Supported
>   F: docs/devel/vfio-user.rst
> +F: hw/vfio-user/*
> +F: include/hw/vfio-user/*
>   F: subprojects/libvfio-user
>   
>   EBPF:
> diff --git a/hw/vfio-user/container.h b/hw/vfio-user/container.h
> new file mode 100644
> index 0000000000..3cd3303e68
> --- /dev/null
> +++ b/hw/vfio-user/container.h
> @@ -0,0 +1,25 @@
> +/*
> + * vfio-user specific definitions.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2.  See
> + * the COPYING file in the top-level directory.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_VFIO_USER_CONTAINER_H
> +#define HW_VFIO_USER_CONTAINER_H
> +
> +#include <inttypes.h>
> +#include <stdbool.h>
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
> index 9d37f86115..28899ca0a6 100644
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
> index 0000000000..2892845b4f
> --- /dev/null
> +++ b/hw/vfio-user/container.c
> @@ -0,0 +1,212 @@
> +/*
> + * Container for vfio-user IOMMU type: rather than communicating with the kernel
> + * vfio driver, we communicate over a socket to a server using the vfio-user
> + * protocol.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2.  See
> + * the COPYING file in the top-level directory.
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
> +#include "trace.h"
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
> index 0000000000..74b0c61f9b
> --- /dev/null
> +++ b/hw/vfio-user/pci.c
> @@ -0,0 +1,155 @@
> +/*
> + * vfio PCI device over a UNIX socket.
> + *
> + * Copyright © 2018, 2021 Oracle and/or its affiliates.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include <sys/ioctl.h>
> +#include "qemu/osdep.h"
> +
> +#include "hw/qdev-properties.h"
> +#include "hw/vfio/pci.h"
> +
> +#define TYPE_VFIO_USER_PCI "vfio-user-pci"
> +OBJECT_DECLARE_SIMPLE_TYPE(VFIOUserPCIDevice, VFIO_USER_PCI)
> +
> +struct VFIOUserPCIDevice {
> +    VFIOPCIDevice device;
> +    char *sock_name;
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
> +    AddressSpace *as;
> +
> +    /*
> +     * TODO: make option parser understand SocketAddress
> +     * and use that instead of having scalar options
> +     * for each socket type.

Please take a look at vfu_object_class_init() to handle the
"socket" property.

C.

> +     */
> +    if (!udev->sock_name) {
> +        error_setg(errp, "No socket specified");
> +        error_append_hint(errp, "Use -device vfio-user-pci,socket=<name>\n");
> +        return;
> +    }
> +
> +    vbasedev->name = g_strdup_printf("VFIO user <%s>", udev->sock_name);
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
> +    DEFINE_PROP_STRING("socket", VFIOUserPCIDevice, sock_name),
> +};
> +
> +static void vfio_user_pci_dev_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    PCIDeviceClass *pdc = PCI_DEVICE_CLASS(klass);
> +
> +    device_class_set_props(dc, vfio_user_pci_dev_properties);
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
> diff --git a/hw/vfio-user/meson.build b/hw/vfio-user/meson.build
> new file mode 100644
> index 0000000000..f1fee70c85
> --- /dev/null
> +++ b/hw/vfio-user/meson.build
> @@ -0,0 +1,9 @@
> +vfio_user_ss = ss.source_set()
> +vfio_user_ss.add(files(
> +  'container.c',
> +  'pci.c',
> +))
> +
> +if get_option('vfio_user_client').enabled()
> +  specific_ss.add_all(vfio_user_ss)
> +endif
> diff --git a/meson_options.txt b/meson_options.txt
> index a442be2995..97d3db44cd 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -109,6 +109,8 @@ option('multiprocess', type: 'feature', value: 'auto',
>          description: 'Out of process device emulation support')
>   option('relocatable', type : 'boolean', value : true,
>          description: 'toggle relocatable install')
> +option('vfio_user_client', type: 'feature', value: 'disabled',
> +       description: 'vfio-user client support')
>   option('vfio_user_server', type: 'feature', value: 'disabled',
>          description: 'vfio-user server support')
>   option('dbus_display', type: 'feature', value: 'auto',
> diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
> index f09ef9604f..2c5673769a 100644
> --- a/scripts/meson-buildoptions.sh
> +++ b/scripts/meson-buildoptions.sh
> @@ -201,6 +201,8 @@ meson_options_help() {
>     printf "%s\n" '  vdi             vdi image format support'
>     printf "%s\n" '  vduse-blk-export'
>     printf "%s\n" '                  VDUSE block export support'
> +  printf "%s\n" '  vfio-user-client'
> +  printf "%s\n" '                  vfio-user client support'
>     printf "%s\n" '  vfio-user-server'
>     printf "%s\n" '                  vfio-user server support'
>     printf "%s\n" '  vhdx            vhdx image format support'
> @@ -529,6 +531,8 @@ _meson_option_parse() {
>       --disable-vdi) printf "%s" -Dvdi=disabled ;;
>       --enable-vduse-blk-export) printf "%s" -Dvduse_blk_export=enabled ;;
>       --disable-vduse-blk-export) printf "%s" -Dvduse_blk_export=disabled ;;
> +    --enable-vfio-user-client) printf "%s" -Dvfio_user_client=enabled ;;
> +    --disable-vfio-user-client) printf "%s" -Dvfio_user_client=disabled ;;
>       --enable-vfio-user-server) printf "%s" -Dvfio_user_server=enabled ;;
>       --disable-vfio-user-server) printf "%s" -Dvfio_user_server=disabled ;;
>       --enable-vhdx) printf "%s" -Dvhdx=enabled ;;


