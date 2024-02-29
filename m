Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28BC6C54798
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 08:36:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfbtX-0002cF-B3; Thu, 29 Feb 2024 03:36:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rfbtQ-0002bf-84
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 03:35:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rfbtO-0004YQ-3S
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 03:35:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709195748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5o28n49GkcvR3iDM3B2nFbD6tgxA2x4Caj4CYlLPUao=;
 b=OZj7IrB8YT7pUT80SmDBuNieE63XuZn7tow56rtIkWa8fl0sAEZ8Nr4CRLaI/26Jum7JoT
 5+dPpttpt3LYUogSuqtrkpthda0BWXrR+KuWYErMy9EpT/UqUxQ2H9rYFvYhghxg4x9V0p
 jkaDNesP6A9RC6jqeIyuGdukkOrrTfo=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-vKto1XDwMIeqlZ37yi14Qg-1; Thu, 29 Feb 2024 03:35:46 -0500
X-MC-Unique: vKto1XDwMIeqlZ37yi14Qg-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-68fefa8c983so9842946d6.3
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 00:35:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709195746; x=1709800546;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5o28n49GkcvR3iDM3B2nFbD6tgxA2x4Caj4CYlLPUao=;
 b=p0Cg0wCCMOmyFQrUPg9olIllTUGbHTlbS9hXKgSStR+KRi2TNO/SFpftESbvrQseNt
 8VPGvsC4dmED5KRFNyq1gKvxLFkQbMJAZ+yCtk2O5cddxt6cVvX5KvHgwXZYLAfDFR3P
 7hchfzsNTyAB++ZCTtDOsnBke5dg+OgXeuo1UYA/BnDno6O0/exsnvft5TftL02KP0hk
 aKYRXYxMbtVTr4EFAjMFVf1/CpBTdGC2yYiauMmKmOOcX2pb+Dzjw4FKRtZ2mSsiyrQO
 MYpi/xRYsM0XAo5q/2Ht7XNAIxFTrpzHZb+4wQ8jv2pIa0SLWg56jAfVuFIs6jXNX2g4
 TbXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAQCvh0B6BlsAgoGChPlxNo+uVIPqZaOUJmhr0c9vdNEs/YHi9jboqdk0pqce4hWDONXeY6Vk5tiuPGrV3zzxT6KqHyzQ=
X-Gm-Message-State: AOJu0Yy/DQhDsxSepfIsEpi9Ypo7S7DUbzR6pAo+qomkATU/p9y2HWQS
 0WYGouEvM9tIiW9dwbN8shROnklqrEGxbJc3EcJqcnS1WL+uJJ2sEoDscIfNSw9vshWDIuf78e9
 qQi7/3vq4BVggQ7WUAv2vhakLowNvyr9bxlnXyq5LA4Jjtz4po3km
X-Received: by 2002:a0c:e4d4:0:b0:68f:280f:14cb with SMTP id
 g20-20020a0ce4d4000000b0068f280f14cbmr1718689qvm.34.1709195746250; 
 Thu, 29 Feb 2024 00:35:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IElQtNMkxFj5H/WuSLnrRKPKm4BmOBvqKBJZBG+KZeVvIKU3POvCA5aD/1tmQmic3gydPU7gQ==
X-Received: by 2002:a0c:e4d4:0:b0:68f:280f:14cb with SMTP id
 g20-20020a0ce4d4000000b0068f280f14cbmr1718675qvm.34.1709195745985; 
 Thu, 29 Feb 2024 00:35:45 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 or33-20020a05621446a100b0068f455083fbsm494304qvb.63.2024.02.29.00.35.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Feb 2024 00:35:45 -0800 (PST)
Message-ID: <4b75e51c-6798-4b3d-8841-7009dd34517a@redhat.com>
Date: Thu, 29 Feb 2024 09:35:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 11/14] vfio: register container for cpr
Content-Language: en-US, fr
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>
References: <1708622920-68779-1-git-send-email-steven.sistare@oracle.com>
 <1708622920-68779-12-git-send-email-steven.sistare@oracle.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <1708622920-68779-12-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_SORBS_WEB=1.5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Hello Steve,

On 2/22/24 18:28, Steve Sistare wrote:
> Define entry points to perform per-container cpr-specific initialization
> and teardown.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   hw/vfio/container.c           | 11 ++++++++++-
>   hw/vfio/cpr.c                 | 19 +++++++++++++++++++
>   hw/vfio/iommufd.c             |  6 ++++++
>   hw/vfio/meson.build           |  1 +
>   include/hw/vfio/vfio-common.h |  3 +++
>   5 files changed, 39 insertions(+), 1 deletion(-)
>   create mode 100644 hw/vfio/cpr.c
> 
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index bd25b9f..096d77e 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -621,10 +621,15 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>           goto free_container_exit;
>       }
>   
> +    ret = vfio_cpr_register_container(bcontainer, errp);
> +    if (ret) {
> +        goto free_container_exit;
> +    }
> +
>       ret = vfio_ram_block_discard_disable(container, true);
>       if (ret) {
>           error_setg_errno(errp, -ret, "Cannot set discarding of RAM broken");
> -        goto free_container_exit;
> +        goto unregister_container_exit;
>       }
>   
>       assert(bcontainer->ops->setup);
> @@ -667,6 +672,9 @@ listener_release_exit:
>   enable_discards_exit:
>       vfio_ram_block_discard_disable(container, false);
>   
> +unregister_container_exit:
> +    vfio_cpr_unregister_container(bcontainer);
> +
>   free_container_exit:
>       g_free(container);
>   
> @@ -710,6 +718,7 @@ static void vfio_disconnect_container(VFIOGroup *group)
>           vfio_container_destroy(bcontainer);
>   
>           trace_vfio_disconnect_container(container->fd);
> +        vfio_cpr_unregister_container(bcontainer);
>           close(container->fd);
>           g_free(container);
>   
> diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
> new file mode 100644
> index 0000000..3bede54
> --- /dev/null
> +++ b/hw/vfio/cpr.c
> @@ -0,0 +1,19 @@
> +/*
> + * Copyright (c) 2021-2024 Oracle and/or its affiliates.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/vfio/vfio-common.h"
> +#include "qapi/error.h"
> +
> +int vfio_cpr_register_container(VFIOContainerBase *bcontainer, Error **errp)
> +{
> +    return 0;
> +}
> +
> +void vfio_cpr_unregister_container(VFIOContainerBase *bcontainer)
> +{
> +}
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 9bfddc1..e1be224 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -411,6 +411,11 @@ found_container:
>           goto err_listener_register;
>       }
>   
> +    ret = vfio_cpr_register_container(bcontainer, errp);
> +    if (ret) {
> +        goto err_listener_register;
> +    }
> +
>       /*
>        * TODO: examine RAM_BLOCK_DISCARD stuff, should we do group level
>        * for discarding incompatibility check as well?
> @@ -461,6 +466,7 @@ static void iommufd_cdev_detach(VFIODevice *vbasedev)
>           iommufd_cdev_ram_block_discard_disable(false);
>       }
>   
> +    vfio_cpr_unregister_container(bcontainer);
>       iommufd_cdev_detach_container(vbasedev, container);
>       iommufd_cdev_container_destroy(container);
>       vfio_put_address_space(space);
> diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
> index bb98493..bba776f 100644
> --- a/hw/vfio/meson.build
> +++ b/hw/vfio/meson.build
> @@ -5,6 +5,7 @@ vfio_ss.add(files(
>     'container-base.c',
>     'container.c',
>     'migration.c',
> +  'cpr.c',
>   ))
>   vfio_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr.c'))
>   vfio_ss.add(when: 'CONFIG_IOMMUFD', if_true: files(
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 4a6c262..b9da6c0 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -205,6 +205,9 @@ void vfio_detach_device(VFIODevice *vbasedev);
>   int vfio_kvm_device_add_fd(int fd, Error **errp);
>   int vfio_kvm_device_del_fd(int fd, Error **errp);
>   
> +int vfio_cpr_register_container(VFIOContainerBase *bcontainer, Error **errp);

Should we return bool since we have an errp ? the returned value
is not an errno AFAICT.

Anyhow,

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



> +void vfio_cpr_unregister_container(VFIOContainerBase *bcontainer);
> +
>   extern const MemoryRegionOps vfio_region_ops;
>   typedef QLIST_HEAD(VFIOGroupList, VFIOGroup) VFIOGroupList;
>   typedef QLIST_HEAD(VFIODeviceList, VFIODevice) VFIODeviceList;


