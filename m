Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94ECCC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 17:41:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTmAh-0008C5-PZ; Tue, 16 Jul 2024 13:41:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sTmAa-0008Ab-Qv
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 13:40:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sTmAU-000439-L1
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 13:40:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721151648;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PHiqoCl323aqZPUSxM4kA48IRRNUeQ2nvta0Ggt1GDo=;
 b=DoSBXnoV4Z7TnBRhXqqivyjptYBCTJlNtdM4Twr/yUdS1u2ubT1J/AYTvlRz2oAtXRu+ob
 KRebquMJ+jMUCu6AJJSodSY9XnC+xzcL2ddFq8Es7CYKcgD0ooQpQ26YpgCt/FAOQi8okN
 xUu/8La78y6ESkSn1v5k5UIZNAZrTGY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-02jS2VTcNUST7QlayoA7xQ-1; Tue, 16 Jul 2024 13:40:47 -0400
X-MC-Unique: 02jS2VTcNUST7QlayoA7xQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3678fd1edf8so3289907f8f.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 10:40:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721151646; x=1721756446;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PHiqoCl323aqZPUSxM4kA48IRRNUeQ2nvta0Ggt1GDo=;
 b=sAIJR/NVpw7+8wOFy8aDJApiVfr1pQBtlA3Q+RMLzZD/KSvuGq7m86wvh1hBhBGjxA
 vIM6Z3B3DumIQv2Dj/n6oLU5Ors/faQINmgIms8R7sp0ESzMioT89X8KADDxn/lJIB6j
 37fA0UnGLGwskK9jXrWDPfHGWuv37R6XrKaFXblqnrY8RFopME9rq8NuX+jWFzQ+IDrW
 0YCMMU/B1LOtuS82ia0WsBoLRisyO1GLmmQH6DBT9Ro+iBWKbw79b1EZA29d8CbA4V8l
 C6k4IDrnCenicQkSys4EiQHxFBSdIp3Jf4tLs0A29ekb3DvgEVA2HdgSoeWppASp4ACT
 +Lvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzRMDN3QCsz3gWraMeRblUMLGO1J82P74QLhlG7hWx5zSMl0xG0yIvFoMxKlH//40rkXEu4hpUv6jF3pZTLyyTaqm7n8Q=
X-Gm-Message-State: AOJu0YxhUGEtviP2nueZp+meajKMbiIIMguadabatRrgpaf5LFY5cYsN
 lkJJWWzMDBz4rViMCAMJZ9XQ77ZZZ5syL1ZddRpArk9w0woqh7wX9ssz6D9QjcnZlSiRVSdTtgM
 NXtAkVU9z6igUPTYtxnCHSRRfH3Ku01gTUK342+XHSwv6YdBNTgoL
X-Received: by 2002:a5d:5582:0:b0:361:94d9:1e9f with SMTP id
 ffacd0b85a97d-3682734828dmr1797863f8f.7.1721151646089; 
 Tue, 16 Jul 2024 10:40:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNG20euGOoSq4tdUGY7h9qrT/UGYpUMWEMyqYq/KDNlg1Y+LQwAVzqMhzMfFBvbCoYnNZ+Eg==
X-Received: by 2002:a5d:5582:0:b0:361:94d9:1e9f with SMTP id
 ffacd0b85a97d-3682734828dmr1797853f8f.7.1721151645630; 
 Tue, 16 Jul 2024 10:40:45 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f25a962sm170036915e9.12.2024.07.16.10.40.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jul 2024 10:40:45 -0700 (PDT)
Message-ID: <903e6f5a-76fc-4f8c-b83e-d7d2a0f45d7c@redhat.com>
Date: Tue, 16 Jul 2024 19:40:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/12] vfio/{iommufd,container}: Remove caps::aw_bits
Content-Language: en-US
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>
References: <20240712114704.8708-1-joao.m.martins@oracle.com>
 <20240712114704.8708-7-joao.m.martins@oracle.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240712114704.8708-7-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Hi Joao,

On 7/12/24 13:46, Joao Martins wrote:
> In preparation to moving HostIOMMUDevice realize() being able to called
> early during attach_device(), remove properties that rely on container
> being initialized.
It is difficult to parse the above sentence. Would deserve some rephrasing.

Also properties have a different meaning in qemu.
>
> This means removing caps::aw_bits which requires the
> bcontainer::iova_ranges to be inititalized after device is actually
initialized
> attached. Instead defer that to .get_cap() and call
> vfio_device_get_aw_bits() directly.
>
> Suggested-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>  include/sysemu/host_iommu_device.h | 1 -
>  backends/iommufd.c                 | 3 ++-
>  hw/vfio/container.c                | 5 +----
>  hw/vfio/iommufd.c                  | 1 -
>  4 files changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/include/sysemu/host_iommu_device.h b/include/sysemu/host_iommu_device.h
> index ee6c813c8b22..20e77cf54568 100644
> --- a/include/sysemu/host_iommu_device.h
> +++ b/include/sysemu/host_iommu_device.h
> @@ -24,7 +24,6 @@
>   */
>  typedef struct HostIOMMUDeviceCaps {
>      uint32_t type;
> -    uint8_t aw_bits;
the doc comment needs to be updated accordingly.
>  } HostIOMMUDeviceCaps;
>  
>  #define TYPE_HOST_IOMMU_DEVICE "host-iommu-device"
> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index 5d3dfa917415..41a9dec3b2c5 100644
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
> @@ -270,7 +271,7 @@ static int hiod_iommufd_get_cap(HostIOMMUDevice *hiod, int cap, Error **errp)
>      case HOST_IOMMU_DEVICE_CAP_IOMMU_TYPE:
>          return caps->type;
>      case HOST_IOMMU_DEVICE_CAP_AW_BITS:
> -        return caps->aw_bits;
> +        return vfio_device_get_aw_bits(hiod->agent);
>      default:
>          error_setg(errp, "%s: unsupported capability %x", hiod->name, cap);
>          return -EINVAL;
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 88ede913d6f7..c27f448ba26e 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -1144,7 +1144,6 @@ static bool hiod_legacy_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
>      VFIODevice *vdev = opaque;
>  
>      hiod->name = g_strdup(vdev->name);
> -    hiod->caps.aw_bits = vfio_device_get_aw_bits(vdev);
>      hiod->agent = opaque;
>  
>      return true;
> @@ -1153,11 +1152,9 @@ static bool hiod_legacy_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
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
> index 325c7598d5a1..873c919e319c 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -722,7 +722,6 @@ static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
>  
>      hiod->name = g_strdup(vdev->name);
>      caps->type = type;
> -    caps->aw_bits = vfio_device_get_aw_bits(vdev);
>  
>      return true;
>  }


