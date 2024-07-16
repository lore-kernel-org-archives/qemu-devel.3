Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF8F6C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 10:20:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTfHT-0002lw-GX; Tue, 16 Jul 2024 06:19:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sTfHO-0002kV-Fl
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 06:19:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sTfHL-0006YA-Ev
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 06:19:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721125166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JE+7+OoyAxSdYZfRR8Xtyv9JyHUKQtBpGDYiVfdg/0w=;
 b=gGtP9IXxc+eRZoHIxqQ7V/zlMbINdlF2IrrZrNeTnSBnuZ53WA64Qeazu9vDC8M8TL1ehh
 pLrrLuy6CcRl23q9BFgrK/efwk2f3S/cGfbZfBrnIAP/AdHkoSDzb3qtLNZPsUtdtXU81V
 MLRtGDsYeKzHxf+w6aZfWiKvmzs80IA=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-a7KfdNOSMK-ITG6QqR_iVg-1; Tue, 16 Jul 2024 06:19:24 -0400
X-MC-Unique: a7KfdNOSMK-ITG6QqR_iVg-1
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-48ff6c5d2e3so1825750137.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 03:19:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721125164; x=1721729964;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JE+7+OoyAxSdYZfRR8Xtyv9JyHUKQtBpGDYiVfdg/0w=;
 b=s4sHx/X8SIOy+RY1MbBpAyYrsxakvvv77VMhjI6bGCjHQolbslw+bWialqQEfOvejn
 WoP74/1wiwK2MAfdNxLHCwEZSvAO1rw2hMpiDQ/al9bDQmc3qaPPBTwYz63SIZyflJPo
 s9PUK+S6zKziN0+v2Qgo7q5yMcwDtT+eEaNE/zRXxMqOXfn4fvKkX4nJSO1H8i+g20AL
 YRvVAXN/34RBdNcQ1KgwwweoMW69nEwra3cGvNtEQTaFItHrKdId7HnqH0QgbtPI5EiJ
 sf7dKcAaPcOFVGikMmXgPAx1PUTewPxCjGCT2bpp0xO143L1j5kimfr/JPgjEuAopSaR
 VHjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVQG3nZeTzbdEHks76Tp7j9MZbd+/faWjksoXLttKNJn4cnzhGH5sps4+V0FsPIHLVBHTRI43rXnr6+zTv76ec4+Jl1WQ=
X-Gm-Message-State: AOJu0YxYO8bWQxYqCPj7XXmFetT1G5XjrFA1y9OMaywpimAyYaUOET4/
 XqeyKp4olYS5TMF+Av31Kzr6EjPvChPnudqa+V7Tpm6XgdxeSy0ROEiaH6x9JMcyjIjJ67FCXAd
 qhxOz2tC5jiHcfDkQGkWsYJ3fL2XqRofkhRdIufDl5BMO1t9lZ4RK
X-Received: by 2002:a05:6102:2c10:b0:48f:e68a:81b1 with SMTP id
 ada2fe7eead31-4914c578c58mr2047867137.23.1721125164178; 
 Tue, 16 Jul 2024 03:19:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGoByM3vy8iPwvzY+5PYLmC2SRJe5jj4S7YMOpzM20Zk51q6/z3EF6viET+QRpj5ehsynxHlA==
X-Received: by 2002:a05:6102:2c10:b0:48f:e68a:81b1 with SMTP id
 ada2fe7eead31-4914c578c58mr2047843137.23.1721125163807; 
 Tue, 16 Jul 2024 03:19:23 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:26c5:842:8baa:576b?
 ([2a01:e0a:9e2:9000:26c5:842:8baa:576b])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-44f5b7bb8edsm33342671cf.18.2024.07.16.03.19.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jul 2024 03:19:23 -0700 (PDT)
Message-ID: <aa34d6c6-dadf-4181-8d77-75a4eb31182a@redhat.com>
Date: Tue, 16 Jul 2024 12:19:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/12] vfio/{iommufd,container}: Remove caps::aw_bits
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
References: <20240712114704.8708-1-joao.m.martins@oracle.com>
 <20240712114704.8708-7-joao.m.martins@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240712114704.8708-7-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 7/12/24 13:46, Joao Martins wrote:
> In preparation to moving HostIOMMUDevice realize() being able to called
> early during attach_device(), remove properties that rely on container
> being initialized.
> 
> This means removing caps::aw_bits which requires the
> bcontainer::iova_ranges to be inititalized after device is actually
> attached. Instead defer that to .get_cap() and call
> vfio_device_get_aw_bits() directly.
> 
> Suggested-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/sysemu/host_iommu_device.h | 1 -
>   backends/iommufd.c                 | 3 ++-
>   hw/vfio/container.c                | 5 +----
>   hw/vfio/iommufd.c                  | 1 -
>   4 files changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/include/sysemu/host_iommu_device.h b/include/sysemu/host_iommu_device.h
> index ee6c813c8b22..20e77cf54568 100644
> --- a/include/sysemu/host_iommu_device.h
> +++ b/include/sysemu/host_iommu_device.h
> @@ -24,7 +24,6 @@
>    */
>   typedef struct HostIOMMUDeviceCaps {
>       uint32_t type;
> -    uint8_t aw_bits;
>   } HostIOMMUDeviceCaps;
>   
>   #define TYPE_HOST_IOMMU_DEVICE "host-iommu-device"
> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index 5d3dfa917415..41a9dec3b2c5 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -18,6 +18,7 @@
>   #include "qemu/error-report.h"
>   #include "monitor/monitor.h"
>   #include "trace.h"
> +#include "hw/vfio/vfio-common.h"
>   #include <sys/ioctl.h>
>   #include <linux/iommufd.h>
>   
> @@ -270,7 +271,7 @@ static int hiod_iommufd_get_cap(HostIOMMUDevice *hiod, int cap, Error **errp)
>       case HOST_IOMMU_DEVICE_CAP_IOMMU_TYPE:
>           return caps->type;
>       case HOST_IOMMU_DEVICE_CAP_AW_BITS:
> -        return caps->aw_bits;
> +        return vfio_device_get_aw_bits(hiod->agent);
>       default:
>           error_setg(errp, "%s: unsupported capability %x", hiod->name, cap);
>           return -EINVAL;
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 88ede913d6f7..c27f448ba26e 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -1144,7 +1144,6 @@ static bool hiod_legacy_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
>       VFIODevice *vdev = opaque;
>   
>       hiod->name = g_strdup(vdev->name);
> -    hiod->caps.aw_bits = vfio_device_get_aw_bits(vdev);
>       hiod->agent = opaque;
>   
>       return true;
> @@ -1153,11 +1152,9 @@ static bool hiod_legacy_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
>   static int hiod_legacy_vfio_get_cap(HostIOMMUDevice *hiod, int cap,
>                                       Error **errp)
>   {
> -    HostIOMMUDeviceCaps *caps = &hiod->caps;
> -
>       switch (cap) {
>       case HOST_IOMMU_DEVICE_CAP_AW_BITS:
> -        return caps->aw_bits;
> +        return vfio_device_get_aw_bits(hiod->agent);
>       default:
>           error_setg(errp, "%s: unsupported capability %x", hiod->name, cap);
>           return -EINVAL;
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 325c7598d5a1..873c919e319c 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -722,7 +722,6 @@ static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
>   
>       hiod->name = g_strdup(vdev->name);
>       caps->type = type;
> -    caps->aw_bits = vfio_device_get_aw_bits(vdev);
>   
>       return true;
>   }


