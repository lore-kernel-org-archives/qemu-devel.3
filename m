Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86E54C25B75
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 09:30:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6S0h-0006lA-0O; Mon, 13 May 2024 05:30:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s6S0X-0006kk-1J
 for qemu-devel@nongnu.org; Mon, 13 May 2024 05:30:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s6S0U-0006IX-QX
 for qemu-devel@nongnu.org; Mon, 13 May 2024 05:30:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715592601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0Q0ecshzutwH0+pCpa893hFUOFv+4F5h71s66N0azlc=;
 b=QbIMXPG7VW0ZD17X4em3au3jMq9h77fOrLYZuy71RLDVSdr7jyzrHyoK/oZGnNkDWK2IsQ
 sFcFWngbPugIbEw/dchtJkUbX9dInLNwYWKbVH+2HzAfiShdOcJjVZLDrwX7zSIh2SuXPg
 KX03WlyChlhRSsWsCJ0SCUlwCVFsXvA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-386-YnaOR9XXPp6COayKBQmbzA-1; Mon, 13 May 2024 05:30:00 -0400
X-MC-Unique: YnaOR9XXPp6COayKBQmbzA-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-792cbf1db11so219648085a.3
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 02:30:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715592600; x=1716197400;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0Q0ecshzutwH0+pCpa893hFUOFv+4F5h71s66N0azlc=;
 b=LEfh0iIBaGM8jqzWUQVrOh7I2DUr0UUD4kQNa3svK8wi9CtYhJ8fufg8Rm3N8CRdJP
 +ftyDDfHzLuYC1MJs7TympNUVkIH2Ey/gtipm/ssVbJ5gENg9UW5/Oew/gJAWMiqRP5G
 3ngFACnLQ0Lxbi3ZKam2eKSUPMkgFnJIjJNkpEc2O+CMqKM5NPIwLkCjJJLeQnn+WZlL
 rTOtrw6/fjxK5YT612lHTBg9CufBvA0CUZ7g9NiAERTXco/5MydrLsRIcQKBFCSeNF31
 n7wMvtvNRcJaS9dEuxXxvDaaEabkxLC8u1S5lrDgR4v6I5SGOp2/D8076GunL6tm9Zzp
 /l1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJy8rRs1GOu1h+55vU2DWEAyH3Lxv3FBWEUWSrx2qIUnKIG9MfZjWagzeVxcO+0E8/W51+6nGn2oL+ub6Fh3VauCp1nck=
X-Gm-Message-State: AOJu0YwkefIjTUSaQLsNMXGqmUSPOws/n8mnRpvEd26eF4ka3siEGwhB
 p6For47o70vsaIzB0X1X9s9Fy/VepITj3HfG3jcWw4WH0XUJgP/q2/5Bi/uu+9+GoyMlddMFi8J
 CS9BsXd14y7IhuHjlpk3v6Lg5DRkjhl6gglQBFNLP/KkPSZEHvl5V
X-Received: by 2002:a05:6214:54ca:b0:6a0:a368:364 with SMTP id
 6a1803df08f44-6a1681c912cmr112551206d6.36.1715592599590; 
 Mon, 13 May 2024 02:29:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiX8fZaDJzgzKBmBw47IVWcWgCkLG1iECh5LPUTY0bXldpwM+uxSi8o5yRvkfQge/d0L7OYA==
X-Received: by 2002:a05:6214:54ca:b0:6a0:a368:364 with SMTP id
 6a1803df08f44-6a1681c912cmr112550936d6.36.1715592599207; 
 Mon, 13 May 2024 02:29:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a15f185520sm41986676d6.37.2024.05.13.02.29.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 May 2024 02:29:58 -0700 (PDT)
Message-ID: <0134a4f2-5a88-42d3-bcb7-f309a0dd62e5@redhat.com>
Date: Mon, 13 May 2024 11:29:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/19] backends: Introduce HostIOMMUDevice abstract
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20240508090354.1815561-1-zhenzhong.duan@intel.com>
 <20240508090354.1815561-2-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240508090354.1815561-2-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Hello Zhenzhong,

On 5/8/24 11:03, Zhenzhong Duan wrote:
> Introduce HostIOMMUDevice as an abstraction of host IOMMU device.
> 
> Introduce .realize() to initialize HostIOMMUDevice further after
> instance init.
> 
> Introduce a macro CONFIG_HOST_IOMMU_DEVICE to define the usage
> for VFIO, and VDPA in the future.

This looks like a way to work around some other problem, like
avoiding exposing Linux definitions on windows build.

Thanks,

C.




> 
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   MAINTAINERS                        |  2 ++
>   include/sysemu/host_iommu_device.h | 51 ++++++++++++++++++++++++++++++
>   backends/host_iommu_device.c       | 30 ++++++++++++++++++
>   backends/Kconfig                   |  5 +++
>   backends/meson.build               |  1 +
>   5 files changed, 89 insertions(+)
>   create mode 100644 include/sysemu/host_iommu_device.h
>   create mode 100644 backends/host_iommu_device.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 84391777db..5dab60bd04 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2191,6 +2191,8 @@ M: Zhenzhong Duan <zhenzhong.duan@intel.com>
>   S: Supported
>   F: backends/iommufd.c
>   F: include/sysemu/iommufd.h
> +F: backends/host_iommu_device.c
> +F: include/sysemu/host_iommu_device.h
>   F: include/qemu/chardev_open.h
>   F: util/chardev_open.c
>   F: docs/devel/vfio-iommufd.rst
> diff --git a/include/sysemu/host_iommu_device.h b/include/sysemu/host_iommu_device.h
> new file mode 100644
> index 0000000000..2b58a94d62
> --- /dev/null
> +++ b/include/sysemu/host_iommu_device.h
> @@ -0,0 +1,51 @@
> +/*
> + * Host IOMMU device abstract declaration
> + *
> + * Copyright (C) 2024 Intel Corporation.
> + *
> + * Authors: Zhenzhong Duan <zhenzhong.duan@intel.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2.  See
> + * the COPYING file in the top-level directory.
> + */
> +
> +#ifndef HOST_IOMMU_DEVICE_H
> +#define HOST_IOMMU_DEVICE_H
> +
> +#include "qom/object.h"
> +#include "qapi/error.h"
> +
> +#define TYPE_HOST_IOMMU_DEVICE "host-iommu-device"
> +OBJECT_DECLARE_TYPE(HostIOMMUDevice, HostIOMMUDeviceClass, HOST_IOMMU_DEVICE)
> +
> +struct HostIOMMUDevice {
> +    Object parent_obj;
> +};
> +
> +/**
> + * struct HostIOMMUDeviceClass - The base class for all host IOMMU devices.
> + *
> + * Different type of host devices (e.g., VFIO or VDPA device) or devices
> + * with different backend (e.g., VFIO legacy container or IOMMUFD backend)
> + * can have different sub-classes.
> + */
> +struct HostIOMMUDeviceClass {
> +    ObjectClass parent_class;
> +
> +    /**
> +     * @realize: initialize host IOMMU device instance further.
> +     *
> +     * Mandatory callback.
> +     *
> +     * @hiod: pointer to a host IOMMU device instance.
> +     *
> +     * @opaque: pointer to agent device of this host IOMMU device,
> +     *          i.e., for VFIO, pointer to VFIODevice
> +     *
> +     * @errp: pass an Error out when realize fails.
> +     *
> +     * Returns: true on success, false on failure.
> +     */
> +    bool (*realize)(HostIOMMUDevice *hiod, void *opaque, Error **errp);
> +};
> +#endif
> diff --git a/backends/host_iommu_device.c b/backends/host_iommu_device.c
> new file mode 100644
> index 0000000000..41f2fdce20
> --- /dev/null
> +++ b/backends/host_iommu_device.c
> @@ -0,0 +1,30 @@
> +/*
> + * Host IOMMU device abstract
> + *
> + * Copyright (C) 2024 Intel Corporation.
> + *
> + * Authors: Zhenzhong Duan <zhenzhong.duan@intel.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2.  See
> + * the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "sysemu/host_iommu_device.h"
> +
> +OBJECT_DEFINE_ABSTRACT_TYPE(HostIOMMUDevice,
> +                            host_iommu_device,
> +                            HOST_IOMMU_DEVICE,
> +                            OBJECT)
> +
> +static void host_iommu_device_class_init(ObjectClass *oc, void *data)
> +{
> +}
> +
> +static void host_iommu_device_init(Object *obj)
> +{
> +}
> +
> +static void host_iommu_device_finalize(Object *obj)
> +{
> +}
> diff --git a/backends/Kconfig b/backends/Kconfig
> index 2cb23f62fa..34ab29e994 100644
> --- a/backends/Kconfig
> +++ b/backends/Kconfig
> @@ -3,3 +3,8 @@ source tpm/Kconfig
>   config IOMMUFD
>       bool
>       depends on VFIO
> +
> +config HOST_IOMMU_DEVICE
> +    bool
> +    default y
> +    depends on VFIO
> diff --git a/backends/meson.build b/backends/meson.build
> index 8b2b111497..2e975d641e 100644
> --- a/backends/meson.build
> +++ b/backends/meson.build
> @@ -25,6 +25,7 @@ if have_vhost_user
>   endif
>   system_ss.add(when: 'CONFIG_VIRTIO_CRYPTO', if_true: files('cryptodev-vhost.c'))
>   system_ss.add(when: 'CONFIG_IOMMUFD', if_true: files('iommufd.c'))
> +system_ss.add(when: 'CONFIG_HOST_IOMMU_DEVICE', if_true: files('host_iommu_device.c'))

Euh. Why is that ?


>   if have_vhost_user_crypto
>     system_ss.add(when: 'CONFIG_VIRTIO_CRYPTO', if_true: files('cryptodev-vhost-user.c'))
>   endif


