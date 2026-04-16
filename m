Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42C1CF88089
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 07:19:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDGzw-0005bd-Ob; Thu, 16 Apr 2026 03:18:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wDGzv-0005bT-2T
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 03:18:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wDGzs-0002sh-K3
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 03:18:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776323922;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XnZYZmkGidVvlTyRTnmDtycEam8frS6hp84MyCN2aYE=;
 b=hijmYVfKExTz+dDC5+BKZMw4LxHXjdpCIIkQulahlQBdYECpqEUbBidMzdzpKtmEOyl5vT
 59uwFnmEBDx1XUYzWCyYItZI5cRH+heSIU9FNAERp45KuZKtlXLuZ6rWgQ+HFmHsJxLTwF
 uCimHMCv8IHn0cf59GaXkLe1x1P8mNM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-369-DD6BEPwnOna9dS8TsZwKvQ-1; Thu,
 16 Apr 2026 03:18:40 -0400
X-MC-Unique: DD6BEPwnOna9dS8TsZwKvQ-1
X-Mimecast-MFC-AGG-ID: DD6BEPwnOna9dS8TsZwKvQ_1776323919
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D990A1956095; Thu, 16 Apr 2026 07:18:38 +0000 (UTC)
Received: from redhat.com (headnet01.pony-001.prod.rdu2.dc.redhat.com
 [10.11.142.86])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 682831800446; Thu, 16 Apr 2026 07:18:35 +0000 (UTC)
Date: Thu, 16 Apr 2026 08:18:31 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, Mitsuya Ikuya =?utf-8?B?KOS4ieODhOWxiyDpg4Hlk4kp?=
 <mitsuya.ikuya@jp.panasonic.com>, 
 KUZU KAZUKI =?utf-8?B?KOiRm+eUnyDkuIDmqLkp?= <kuzu.kazuki@jp.panasonic.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio: Add vhost-user-rtc and vhost-user-rtc-pci
Message-ID: <aeCNR5CmtcbuNRm_@redhat.com>
References: <20260416-vhost-user-rtc-v1-1-1b2d44f0c889@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260416-vhost-user-rtc-v1-1-1b2d44f0c889@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


Missing commit message.....

On Thu, Apr 16, 2026 at 08:54:40AM +0300, Manos Pitsidianakis wrote:
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>  include/hw/virtio/vhost-user-rtc.h        | 22 ++++++++++
>  MAINTAINERS                               |  6 +++
>  docs/system/devices/virtio/vhost-user.rst |  3 ++
>  hw/virtio/Kconfig                         |  5 +++
>  hw/virtio/meson.build                     |  3 ++
>  hw/virtio/vhost-user-rtc-pci.c            | 70 +++++++++++++++++++++++++++++++
>  hw/virtio/vhost-user-rtc.c                | 64 ++++++++++++++++++++++++++++
>  7 files changed, 173 insertions(+)
> 
> diff --git a/include/hw/virtio/vhost-user-rtc.h b/include/hw/virtio/vhost-user-rtc.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..6b7b53c28f93032886d82687199585aba0edd917
> --- /dev/null
> +++ b/include/hw/virtio/vhost-user-rtc.h
> @@ -0,0 +1,22 @@
> +/*
> + * Vhost-user RTC virtio device
> + *
> + * Copyright (c) 2025 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> + * Copyright 2026 Panasonic Automotive Systems Co., Ltd.

This commit is only signed off by yourself, as @linaro.org but the
newest copyright is from Panasonic.  What is the situation with
authorship here ?

If it was co-authored by people from multiple companies then I'd
expect to see multiple signed-off-bys, so that each company is
represented.

> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef QEMU_VHOST_USER_RTC_H
> +#define QEMU_VHOST_USER_RTC_H
> +
> +#include "hw/virtio/vhost-user-base.h"
> +
> +#define TYPE_VHOST_USER_RTC "vhost-user-rtc"
> +OBJECT_DECLARE_SIMPLE_TYPE(VHostUserRTC, VHOST_USER_RTC)
> +
> +struct VHostUserRTC {
> +    VHostUserBase parent_obj;
> +};
> +
> +#endif /* QEMU_VHOST_USER_RTC_H */
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ad215eced84d1ac58956ea374ee012acbb3cbd18..da6376b0f5e6fa99495504e88da9fef5a7a969e3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2573,6 +2573,12 @@ S: Maintained
>  F: include/hw/virtio/vhost-user-spi.h
>  F: hw/virtio/vhost-user-spi*
>  
> +vhost-user-rtc
> +M: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> +S: Supported
> +F: include/hw/virtio/vhost-user-rtc.h
> +F: hw/virtio/vhost-user-rtc*
> +
>  virtio-crypto
>  M: Gonglei <arei.gonglei@huawei.com>
>  S: Supported
> diff --git a/docs/system/devices/virtio/vhost-user.rst b/docs/system/devices/virtio/vhost-user.rst
> index 2806d81ca201551a91246a10e0d98fd36d74200b..acfbd609d0f9c87e3af684797adf156a8a61bc88 100644
> --- a/docs/system/devices/virtio/vhost-user.rst
> +++ b/docs/system/devices/virtio/vhost-user.rst
> @@ -61,6 +61,9 @@ platform details for what sort of virtio bus to use.
>    * - vhost-user-spi
>      - Proxy spi devices to host
>      - `vhost-device-spi <https://github.com/rust-vmm/vhost-device/tree/main/vhost-device-spi>`_
> +  * - vhost-user-rtc
> +    - Real time clock
> +    - `vhost-device-rtc <https://github.com/rust-vmm/vhost-device/tree/main/vhost-device-rtc>`_
>  
>  The referenced *daemons* are not exhaustive, any conforming backend
>  implementing the device and using the vhost-user protocol should work.
> diff --git a/hw/virtio/Kconfig b/hw/virtio/Kconfig
> index 8895682c619402eb3c9cd7269d3319f39711b4bd..2ebdac16b31aec3ec283c0285a4dcfa67f0a5157 100644
> --- a/hw/virtio/Kconfig
> +++ b/hw/virtio/Kconfig
> @@ -136,3 +136,8 @@ config VHOST_USER_TEST
>      bool
>      default y
>      depends on VIRTIO && VHOST_USER
> +
> +config VHOST_USER_RTC
> +    bool
> +    default y
> +    depends on VIRTIO && VHOST_USER
> diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
> index 415e359e9fc79b6b1adbbcfc4f87a7106ef1d4a6..e0566a60de7989c4048956e268f151659467fe34 100644
> --- a/hw/virtio/meson.build
> +++ b/hw/virtio/meson.build
> @@ -27,6 +27,7 @@ if have_vhost
>      system_virtio_ss.add(when: 'CONFIG_VHOST_USER_SND', if_true: files('vhost-user-snd.c'))
>      system_virtio_ss.add(when: 'CONFIG_VHOST_USER_INPUT', if_true: files('vhost-user-input.c'))
>      system_virtio_ss.add(when: 'CONFIG_VHOST_USER_SPI', if_true: files('vhost-user-spi.c'))
> +    system_virtio_ss.add(when: 'CONFIG_VHOST_USER_RTC', if_true: files('vhost-user-rtc.c'))
>  
>      # PCI Stubs
>      system_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_TEST'],
> @@ -43,6 +44,8 @@ if have_vhost
>                           if_true: files('vhost-user-input-pci.c'))
>      system_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_SPI'],
>                           if_true: files('vhost-user-spi-pci.c'))
> +    system_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_RTC'],
> +                         if_true: files('vhost-user-rtc-pci.c'))
>    endif
>    if have_vhost_vdpa
>      system_virtio_ss.add(files('vhost-vdpa.c'))
> diff --git a/hw/virtio/vhost-user-rtc-pci.c b/hw/virtio/vhost-user-rtc-pci.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..449368d27009acde20aa4af2542a912ac8b82cbc
> --- /dev/null
> +++ b/hw/virtio/vhost-user-rtc-pci.c
> @@ -0,0 +1,70 @@
> +/*
> + * Vhost-user RTC virtio device PCI glue
> + *
> + * Copyright (c) 2025 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> + * Copyright 2026 Panasonic Automotive Systems Co., Ltd.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/virtio/vhost-user-rtc.h"
> +#include "hw/virtio/virtio-pci.h"
> +
> +struct VHostUserRTCPCI {
> +    VirtIOPCIProxy parent_obj;
> +    VHostUserRTC vdev;
> +};
> +
> +typedef struct VHostUserRTCPCI VHostUserRTCPCI;
> +
> +#define TYPE_VHOST_USER_RTC_PCI "vhost-user-rtc-pci-base"
> +
> +DECLARE_INSTANCE_CHECKER(VHostUserRTCPCI, VHOST_USER_RTC_PCI,
> +                         TYPE_VHOST_USER_RTC_PCI)
> +
> +static void vhost_user_rtc_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
> +{
> +    VHostUserRTCPCI *dev = VHOST_USER_RTC_PCI(vpci_dev);
> +    DeviceState *vdev = DEVICE(&dev->vdev);
> +
> +    vpci_dev->nvectors = 1;
> +
> +    qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
> +}
> +
> +static void vhost_user_rtc_pci_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
> +    PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
> +    k->realize = vhost_user_rtc_pci_realize;
> +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> +    pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
> +    pcidev_k->device_id = 0; /* Set by virtio-pci based on virtio id */
> +    pcidev_k->revision = 0x00;
> +    pcidev_k->class_id = PCI_CLASS_SYSTEM_RTC;
> +}
> +
> +static void vhost_user_rtc_pci_instance_init(Object *obj)
> +{
> +    VHostUserRTCPCI *dev = VHOST_USER_RTC_PCI(obj);
> +
> +    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
> +                                TYPE_VHOST_USER_RTC);
> +}
> +
> +static const VirtioPCIDeviceTypeInfo vhost_user_rtc_pci_info = {
> +    .base_name = TYPE_VHOST_USER_RTC_PCI,
> +    .non_transitional_name = "vhost-user-rtc-pci",
> +    .instance_size = sizeof(VHostUserRTCPCI),
> +    .instance_init = vhost_user_rtc_pci_instance_init,
> +    .class_init = vhost_user_rtc_pci_class_init,
> +};
> +
> +static void vhost_user_rtc_pci_register(void)
> +{
> +    virtio_pci_types_register(&vhost_user_rtc_pci_info);
> +}
> +
> +type_init(vhost_user_rtc_pci_register);
> diff --git a/hw/virtio/vhost-user-rtc.c b/hw/virtio/vhost-user-rtc.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..88b0c70b903363fc9ac7ccb65a1b1755e095c6bc
> --- /dev/null
> +++ b/hw/virtio/vhost-user-rtc.c
> @@ -0,0 +1,64 @@
> +/*
> + * Vhost-user RTC virtio device
> + *
> + * Copyright (c) 2025 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> + * Copyright 2026 Panasonic Automotive Systems Co., Ltd.
> + *
> + * Simple wrapper of the generic vhost-user-device.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "hw/virtio/vhost-user-rtc.h"
> +#include "standard-headers/linux/virtio_ids.h"
> +
> +static const VMStateDescription vu_rtc_vmstate = {
> +    .name = "vhost-user-rtc",
> +    .unmigratable = 1,
> +};
> +
> +static const Property vrtc_properties[] = {
> +    DEFINE_PROP_CHR("chardev", VHostUserBase, chardev),
> +};
> +
> +static void vu_rtc_base_realize(DeviceState *dev, Error **errp)
> +{
> +    VHostUserBase *vub = VHOST_USER_BASE(dev);
> +    VHostUserBaseClass *vubs = VHOST_USER_BASE_GET_CLASS(dev);
> +
> +    vub->virtio_id = VIRTIO_ID_CLOCK;
> +    vub->num_vqs = 2;
> +    vub->config_size = 0;
> +    vub->vq_size = 1024;
> +
> +    vubs->parent_realize(dev, errp);
> +}
> +
> +static void vu_rtc_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    VHostUserBaseClass *vubc = VHOST_USER_BASE_CLASS(klass);
> +
> +    dc->vmsd = &vu_rtc_vmstate;
> +    device_class_set_props(dc, vrtc_properties);
> +    device_class_set_parent_realize(dc, vu_rtc_base_realize,
> +                                    &vubc->parent_realize);
> +
> +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> +}
> +
> +static const TypeInfo vu_rtc_info = {
> +    .name = TYPE_VHOST_USER_RTC,
> +    .parent = TYPE_VHOST_USER_BASE,
> +    .instance_size = sizeof(VHostUserRTC),
> +    .class_init = vu_rtc_class_init,
> +};
> +
> +static void vu_rtc_register_types(void)
> +{
> +    type_register_static(&vu_rtc_info);
> +}
> +
> +type_init(vu_rtc_register_types)
> 
> ---
> base-commit: da6c4fe60fee30dd77267764d55b38af9cb89d4b
> change-id: 20260416-vhost-user-rtc-ce8ff0377356
> 
> --
> γαῖα πυρί μιχθήτω
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


