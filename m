Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46845C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 12:19:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4JmK-0004TQ-Jt; Tue, 07 May 2024 08:18:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s4Jla-00042s-4w
 for qemu-devel@nongnu.org; Tue, 07 May 2024 08:17:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s4JlY-0001UX-C9
 for qemu-devel@nongnu.org; Tue, 07 May 2024 08:17:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715084271;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GpQuhCG/bpGmSCG2U2i+dTIA1hWdswts2kJJK0IqYgY=;
 b=jRSiqlEkH5jSYw3fkVpoTB/Ak5Sm2O0kZmMgOGTK+U85WvRKqA4apaIeHrmNpJAD293jJG
 yD5jcDuJ3N/K4UQrVgDNUSU+vFIbogUdclGVq2/rAlnSa7hWyXTu0eaknIZ3Eo4os+WDRL
 eyrbfaA8FbsfWRAf+OmBe/pTnsu4UhI=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-fkiHMqCQO6Sey7Obw-eJyA-1; Tue, 07 May 2024 08:17:49 -0400
X-MC-Unique: fkiHMqCQO6Sey7Obw-eJyA-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2e279eeec2dso26659421fa.1
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 05:17:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715084268; x=1715689068;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GpQuhCG/bpGmSCG2U2i+dTIA1hWdswts2kJJK0IqYgY=;
 b=Ti16R3MDNmiyIB8DmUzLvllUnEPtsOvKenLlJIlAMg/VeG4rg74ju1ATuwSu193Uaf
 Sf6i19GTijikw5SE3VLDDXs8ctYtyz2SjibMs7j6LO0UIT2cQVJtWuu6THE+sL0S0XYA
 lflBFmQ5CGoyX6rXj7m1+IlivoC8CXGj80y9FprULuWR01PZrwsQCQTGjk+RW1Bz6cf8
 bLsrJzVSLPMGeMCcH1gTG3Fhitwm/53Wo0jwv72JNZR5Cm6NacCTTeJJEq7P+n2tM/Fe
 4YNBoNPGv/AOypyCf6/9Wx8uECfxzueTHLiMUVAAiltB42eTMGJ0NZbDVisUFJw3KovT
 qUhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWe8Xaeot49M025wH9zyVWIGAvZ8pEeISYsa76aZLJFC3w6uXhA4G2D4oyJqpilGQrS395obEt3VUl6ieEvp3FiBUacjdg=
X-Gm-Message-State: AOJu0YxbKArryvM8TUiXNb4kiTsnzX9vKL3aTqbGc7FCM0YZBbqqcCIg
 OBMbf5mpfRocvmhPZoVz6bIPTX4TLspS9esq6T0/8SW6g1G1UHwjBlBoUWs7JB2A32iIhy/YCor
 X0+9npwi+3kTR4f+rf+KO+/5+caZ722tDqtRqSQnME7NlNXAf+Dhe
X-Received: by 2002:a2e:b1ca:0:b0:2e1:e0cc:e4e1 with SMTP id
 e10-20020a2eb1ca000000b002e1e0cce4e1mr7305412lja.50.1715084267834; 
 Tue, 07 May 2024 05:17:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOwl3QTUrXoXTLAzOA9+6d5gR7Kw/NtBULwTf0Eyh9oe5KfPT/BeBiQdWmgsM0ITJ/z9iA+w==
X-Received: by 2002:a2e:b1ca:0:b0:2e1:e0cc:e4e1 with SMTP id
 e10-20020a2eb1ca000000b002e1e0cce4e1mr7305391lja.50.1715084267363; 
 Tue, 07 May 2024 05:17:47 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 bi15-20020a05600c3d8f00b0041c24321934sm23279140wmb.41.2024.05.07.05.17.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 May 2024 05:17:46 -0700 (PDT)
Message-ID: <472bcb78-c29f-40ff-85ff-ba4a0f2d7552@redhat.com>
Date: Tue, 7 May 2024 14:17:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/19] backends/iommufd: Introduce helper function
 iommufd_backend_get_device_info()
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Yi Sun <yi.y.sun@linux.intel.com>
References: <20240507092043.1172717-1-zhenzhong.duan@intel.com>
 <20240507092043.1172717-9-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240507092043.1172717-9-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 5/7/24 11:20, Zhenzhong Duan wrote:
> Introduce a helper function iommufd_backend_get_device_info() to get
> host IOMMU related information through iommufd uAPI.
> 
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   include/sysemu/iommufd.h |  4 ++++
>   backends/iommufd.c       | 23 ++++++++++++++++++++++-
>   2 files changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
> index f6e6d6e1f9..ee1907c23a 100644
> --- a/include/sysemu/iommufd.h
> +++ b/include/sysemu/iommufd.h
> @@ -17,6 +17,7 @@
>   #include "qom/object.h"
>   #include "exec/hwaddr.h"
>   #include "exec/cpu-common.h"
> +#include <linux/iommufd.h>

With this linux include, sysemu/iommufd.h is Linnux tainted. It could mean
trouble on windows.

Thanks,

C.



>   #include "sysemu/host_iommu_device.h"
>   
>   #define TYPE_IOMMUFD_BACKEND "iommufd"
> @@ -47,6 +48,9 @@ int iommufd_backend_map_dma(IOMMUFDBackend *be, uint32_t ioas_id, hwaddr iova,
>                               ram_addr_t size, void *vaddr, bool readonly);
>   int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
>                                 hwaddr iova, ram_addr_t size);
> +bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
> +                                     enum iommu_hw_info_type *type,
> +                                     void *data, uint32_t len, Error **errp);
>   
>   #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD TYPE_HOST_IOMMU_DEVICE "-iommufd"
>   #endif
> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index 012f18d8d8..06bf20fd05 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -19,7 +19,6 @@
>   #include "monitor/monitor.h"
>   #include "trace.h"
>   #include <sys/ioctl.h>
> -#include <linux/iommufd.h>
>   
>   static void iommufd_backend_init(Object *obj)
>   {
> @@ -208,6 +207,28 @@ int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
>       return ret;
>   }
>   
> +bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
> +                                     enum iommu_hw_info_type *type,
> +                                     void *data, uint32_t len, Error **errp)
> +{
> +    struct iommu_hw_info info = {
> +        .size = sizeof(info),
> +        .dev_id = devid,
> +        .data_len = len,
> +        .data_uptr = (uintptr_t)data,
> +    };
> +
> +    if (ioctl(be->fd, IOMMU_GET_HW_INFO, &info)) {
> +        error_setg_errno(errp, errno, "Failed to get hardware info");
> +        return false;
> +    }
> +
> +    g_assert(type);
> +    *type = info.out_data_type;
> +
> +    return true;
> +}
> +
>   static const TypeInfo types[] = {
>       {
>           .name = TYPE_IOMMUFD_BACKEND,


