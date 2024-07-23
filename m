Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFEBDC3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 07:22:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW9qd-0001dn-D3; Tue, 23 Jul 2024 03:22:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sW9qb-0001WQ-Gz
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 03:22:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sW9qY-0004Nd-Tt
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 03:22:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721719324;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F+MawaUq5hyoDP0Lx2efI9pCdNExscWs7C2RC8hKyOk=;
 b=WjHUM9w+nCDkdhMQDv0JvS6TXOX+IdByighnY3y2Uqm02CsmScfuKGHsjhqjJuOpcrkfU6
 qyPr7jgetUnSFLBueBh7gH/vW8/YnvhISTkPORuwQz4HRl2GDjxNMmuFhTZzcXwWMh3CT4
 OcEomyl1buUovx5MpEoeApwxXj+beEg=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-KsMKOB6qNSWfrS9iAyRB_A-1; Tue, 23 Jul 2024 03:22:02 -0400
X-MC-Unique: KsMKOB6qNSWfrS9iAyRB_A-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2ef2018bb2dso24133861fa.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 00:22:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721719320; x=1722324120;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F+MawaUq5hyoDP0Lx2efI9pCdNExscWs7C2RC8hKyOk=;
 b=MiboNxHCqHJqTSryypsWKP2aLBK5fHIguJ2qfLLdOrsPZ1mlJ+OPFaGRzkswcIDuZh
 D1EqPgA9xc6J5yVbFh1xS/ED1uFmoVyob2ZalUk1biGoJj+ebOrCsX2zWkVacAYfb/T/
 BjtcN1pSnIEqqnvfodGcSnNMNCOwTdEAalDmbNZogGJU0J4NP/LKc8hZL1WoIKhNRPYT
 WXg7psUymgxTAP7hhLtSWVB+EI/pgZJ9jmlCsSASlTba02ik0vNQM8cmBT24bmntVb/n
 deqFbe36NLYnEBStWhSygV8+xPAki+piVgTLHueGa/z96hQzhGC01wtPnIOEe0y+p2Rs
 AMGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3svJF2txdlecfonR0s38t9bylURaGGMURS+0ZKzlrwcILocILJLZhq/rk7idjR6omMGn8cBPS50THNh+ixdMxoQRgZJc=
X-Gm-Message-State: AOJu0Yxy8bEEFC6OAg0C3UXF6Bxj9zEJwM4DS82KEIfxaUbbwjxRvBAO
 zokGkN9V8k0fo6Dmkrb8TsIXeR+KB5c2pdS+ZYvNLnvA+AYIXAN5oUtrDauxa81v9Z2iBBaMNNc
 dHXRnwFHyhJ4tC2L3rIK7vcmAoZUCT3bYcfC/Z3Dpa8wHpjTjNE7wXDGVjUV9
X-Received: by 2002:a2e:930e:0:b0:2ef:22ef:a24e with SMTP id
 38308e7fff4ca-2f01ea4b411mr14131931fa.10.1721719320570; 
 Tue, 23 Jul 2024 00:22:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXwu8hlRLTKdY8FlG2uIJLzfOTNHnhcXrMTvwp4unyWFUzmiHRANKJzPATtFFWa0jVGAzwYw==
X-Received: by 2002:a2e:930e:0:b0:2ef:22ef:a24e with SMTP id
 38308e7fff4ca-2f01ea4b411mr14131771fa.10.1721719320145; 
 Tue, 23 Jul 2024 00:22:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a3c159sm187116965e9.8.2024.07.23.00.21.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jul 2024 00:21:59 -0700 (PDT)
Message-ID: <ad2b135f-d6f2-4c2e-b747-9843ebd99ba9@redhat.com>
Date: Tue, 23 Jul 2024 09:21:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/9] vfio/{iommufd,container}: Remove caps::aw_bits
Content-Language: en-US
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>
References: <20240722211326.70162-1-joao.m.martins@oracle.com>
 <20240722211326.70162-3-joao.m.martins@oracle.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240722211326.70162-3-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 7/22/24 23:13, Joao Martins wrote:
> Remove caps::aw_bits which requires the bcontainer::iova_ranges being
> initialized after device is actually attached. Instead defer that to
> .get_cap() and call vfio_device_get_aw_bits() directly.
>
> This is in preparation for HostIOMMUDevice::realize() being called early
> during attach_device().
>
> Suggested-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> Reviewed-by: Cédric Le Goater <clg@redhat.com
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  include/sysemu/host_iommu_device.h | 3 ---
>  backends/iommufd.c                 | 3 ++-
>  hw/vfio/container.c                | 5 +----
>  hw/vfio/iommufd.c                  | 1 -
>  4 files changed, 3 insertions(+), 9 deletions(-)
>
> diff --git a/include/sysemu/host_iommu_device.h b/include/sysemu/host_iommu_device.h
> index c1bf74ae2c7a..d1c10ff7c239 100644
> --- a/include/sysemu/host_iommu_device.h
> +++ b/include/sysemu/host_iommu_device.h
> @@ -19,12 +19,9 @@
>   * struct HostIOMMUDeviceCaps - Define host IOMMU device capabilities.
>   *
>   * @type: host platform IOMMU type.
> - *
> - * @aw_bits: host IOMMU address width. 0xff if no limitation.
>   */
>  typedef struct HostIOMMUDeviceCaps {
>      uint32_t type;
> -    uint8_t aw_bits;
>  } HostIOMMUDeviceCaps;
>  
>  #define TYPE_HOST_IOMMU_DEVICE "host-iommu-device"
> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index 60a3d14bfab4..06b135111f30 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -18,6 +18,7 @@
>  #include "qemu/error-report.h"
>  #include "monitor/monitor.h"
>  #include "trace.h"
> +#include "hw/vfio/vfio-common.h"
>  #include <sys/ioctl.h>
>  #include <linux/iommufd.h>
>  
> @@ -269,7 +270,7 @@ static int hiod_iommufd_get_cap(HostIOMMUDevice *hiod, int cap, Error **errp)
>      case HOST_IOMMU_DEVICE_CAP_IOMMU_TYPE:
>          return caps->type;
>      case HOST_IOMMU_DEVICE_CAP_AW_BITS:
> -        return caps->aw_bits;
> +        return vfio_device_get_aw_bits(hiod->agent);
>      default:
>          error_setg(errp, "%s: unsupported capability %x", hiod->name, cap);
>          return -EINVAL;
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index ce9a858e5621..10cb4b4320ac 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -1141,7 +1141,6 @@ static bool hiod_legacy_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
>      VFIODevice *vdev = opaque;
>  
>      hiod->name = g_strdup(vdev->name);
> -    hiod->caps.aw_bits = vfio_device_get_aw_bits(vdev);
>      hiod->agent = opaque;
>  
>      return true;
> @@ -1150,11 +1149,9 @@ static bool hiod_legacy_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
>  static int hiod_legacy_vfio_get_cap(HostIOMMUDevice *hiod, int cap,
>                                      Error **errp)
>  {
> -    HostIOMMUDeviceCaps *caps = &hiod->caps;
> -
>      switch (cap) {
>      case HOST_IOMMU_DEVICE_CAP_AW_BITS:
> -        return caps->aw_bits;
> +        return vfio_device_get_aw_bits(hiod->agent);
>      default:
>          error_setg(errp, "%s: unsupported capability %x", hiod->name, cap);
>          return -EINVAL;
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 172553b1f7f8..5bb623879abe 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -724,7 +724,6 @@ static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
>  
>      hiod->name = g_strdup(vdev->name);
>      caps->type = type;
> -    caps->aw_bits = vfio_device_get_aw_bits(vdev);
>  
>      return true;
>  }


