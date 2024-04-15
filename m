Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0B78C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2024 08:10:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwHPL-0005Q2-8k; Mon, 15 Apr 2024 04:09:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rwHPJ-0005P7-Gp
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 04:09:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rwHPH-0001kD-Pf
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 04:09:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713168575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ByrGr+i/GWf80ZTqSy3vA8yb9cQhJgKJXPgfgtjFdBI=;
 b=RZI8T09gQmPcKjXXrEFVBu/MkZLhY24ZQImLIfm2r+3dFSgd/O04+Uy7B5kyRReUKeggHg
 opt9aJaF1P8y2W0oDXVBATdhanzpPuIwCfjYlHLslZ7StlYWN/l7lgFkF6EWgt/YA3TPTj
 j+JKh/eEjfjH1wJq8z0Pr+Avyi73wLo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-CWKWKSqqNeqO8Y4WEUyPyQ-1; Mon, 15 Apr 2024 04:09:24 -0400
X-MC-Unique: CWKWKSqqNeqO8Y4WEUyPyQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4167351545cso18124745e9.1
 for <qemu-devel@nongnu.org>; Mon, 15 Apr 2024 01:09:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713168563; x=1713773363;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ByrGr+i/GWf80ZTqSy3vA8yb9cQhJgKJXPgfgtjFdBI=;
 b=CjBu3qz3F3vrQWkebX/mndodvG2xubuIOOo161Mhyb3kAqiUBwiiWipSvAfXMFa196
 XI9r+FPT2jmTuL/q5NNY77vMk2Rkk7AymGAJegBncaprVvwlh8Jb4laU6OaFZ7bkvmO7
 4kgoSOdXR32+85X5/IPWssWigRi8WLVxiS772ruLlusCoqzbW+cMvGDAGP4gbwbKLWuJ
 HcnQaMvKj56CQVeOXjUU7HVL7qFaz61cwYI3YcBbA1syBfw+E/BY8dUwBpfm1kcKZFkX
 OnfcL51RH7GUF7Q/p2jxiO/iHGkczLS4uisnrMbZ7yI5GBAfRjStZNOqAELUrO882xUU
 1BcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNVaN+1lItBpJDbbMYRelSNWxulIO9AtQXd6JH9smfMdSJnUUUq9VGEfFFb9UtAo2zd5xvOZIFu/szUDpY8gcZeKzjrZQ=
X-Gm-Message-State: AOJu0YyU2m7P9eM3YYDn9GaOroQif6Hz7jvzwgIkruQHKzJCmZrrQmhg
 f/XGVAWtQij76dwsks1No6fMlJK9d7iq0+n/BOL8SeQ3HizoupPm8TgrNXOEJMSoJqRsznFyMBs
 T2kp2FqqbSNz7UpG4Cee5cm3/KXED2E6bxRVetQevQHuDH4rAKh91
X-Received: by 2002:a05:600c:a09:b0:418:5d8f:79e6 with SMTP id
 z9-20020a05600c0a0900b004185d8f79e6mr1666799wmp.27.1713168563288; 
 Mon, 15 Apr 2024 01:09:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMXxakYUGP24taYRHQMB53VwDeh/ofRm9IePFksbE7x3HxVNucxQYRbxWAI+WBTLcK2y2Bbg==
X-Received: by 2002:a05:600c:a09:b0:418:5d8f:79e6 with SMTP id
 z9-20020a05600c0a0900b004185d8f79e6mr1666776wmp.27.1713168562975; 
 Mon, 15 Apr 2024 01:09:22 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:d55d:ba01:adf2:d3ae?
 ([2a01:e0a:9e2:9000:d55d:ba01:adf2:d3ae])
 by smtp.gmail.com with ESMTPSA id
 u2-20020a05600c4d0200b0041668053ca9sm12255370wmp.0.2024.04.15.01.09.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Apr 2024 01:09:22 -0700 (PDT)
Message-ID: <677ab8a4-0d64-4a55-bb46-4ee5a5a1c543@redhat.com>
Date: Mon, 15 Apr 2024 10:09:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/10] backends: Introduce abstract HostIOMMUDevice
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Paolo Bonzini <pbonzini@redhat.com>
References: <20240408081230.1030078-1-zhenzhong.duan@intel.com>
 <20240408081230.1030078-2-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240408081230.1030078-2-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.127,
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

On 4/8/24 10:12, Zhenzhong Duan wrote:
> Introduce HostIOMMUDevice as an abstraction of host IOMMU device.
> 
> get_host_iommu_info() is used to get host IOMMU info, different
> backends can have different implementations and result format.
> 
> Introduce a macro CONFIG_HOST_IOMMU_DEVICE to define the usage
> for VFIO, and VDPA in the future.
> 
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

LGTM,

> ---
>   MAINTAINERS                        |  2 ++
>   include/sysemu/host_iommu_device.h | 19 +++++++++++++++++++
>   backends/host_iommu_device.c       | 19 +++++++++++++++++++
>   backends/Kconfig                   |  5 +++++
>   backends/meson.build               |  1 +
>   5 files changed, 46 insertions(+)
>   create mode 100644 include/sysemu/host_iommu_device.h
>   create mode 100644 backends/host_iommu_device.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e71183eef9..22f71cbe02 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2202,6 +2202,8 @@ M: Zhenzhong Duan <zhenzhong.duan@intel.com>
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
> index 0000000000..22ccbe3a5d
> --- /dev/null
> +++ b/include/sysemu/host_iommu_device.h
> @@ -0,0 +1,19 @@
> +#ifndef HOST_IOMMU_DEVICE_H
> +#define HOST_IOMMU_DEVICE_H
> +
> +#include "qom/object.h"
> +
> +#define TYPE_HOST_IOMMU_DEVICE "host-iommu-device"
> +OBJECT_DECLARE_TYPE(HostIOMMUDevice, HostIOMMUDeviceClass, HOST_IOMMU_DEVICE)
> +
> +struct HostIOMMUDevice {
> +    Object parent;
> +};
> +
> +struct HostIOMMUDeviceClass {
> +    ObjectClass parent_class;

Could you please document the struct and its handlers ? This is more for
the future reader to understand the VFIO concepts than for the generated
docs. Anyhow, it could be useful for the docs also. Overall, the QEMU VFIO
susbsytem suffers from a lack of documentation and we should try to improve
that in the next cycle.

Thanks,

C.



> +    int (*get_host_iommu_info)(HostIOMMUDevice *hiod, void *data, uint32_t len,
> +                               Error **errp);
> +};
> +#endif
> diff --git a/backends/host_iommu_device.c b/backends/host_iommu_device.c
> new file mode 100644
> index 0000000000..6cb6007d8c
> --- /dev/null
> +++ b/backends/host_iommu_device.c
> @@ -0,0 +1,19 @@
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
>   if have_vhost_user_crypto
>     system_ss.add(when: 'CONFIG_VIRTIO_CRYPTO', if_true: files('cryptodev-vhost-user.c'))
>   endif


