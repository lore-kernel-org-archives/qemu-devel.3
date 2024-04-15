Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B84BC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2024 13:23:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwMHx-000139-Tx; Mon, 15 Apr 2024 09:22:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rwMHv-00012x-0Z
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 09:22:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rwMHq-0001Ld-Mn
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 09:22:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713187336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DCpsJXQee2/KeIWV/1g6licO1BhAyOokfoMT4a7agww=;
 b=ZpcAqR9sIN+UYsYjm+4Z60MuAikp9k0hg4i/A8VfKuoShadPV2IlKbRDw/oWAzjG32NGLh
 m9JyT9JYB9ZIkVBDAJ8UQohYrE0lMEP2gKtR31UMRM38ZS/mech62tg+b+ngaCPRO4aOsb
 dBPK+5bjznspEP2pfLjcRDxcT/+ji0Y=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-WZq6oRKhPcyOC0MDmum_Fw-1; Mon, 15 Apr 2024 09:22:13 -0400
X-MC-Unique: WZq6oRKhPcyOC0MDmum_Fw-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-78d5ef6055fso412272385a.1
 for <qemu-devel@nongnu.org>; Mon, 15 Apr 2024 06:22:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713187333; x=1713792133;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DCpsJXQee2/KeIWV/1g6licO1BhAyOokfoMT4a7agww=;
 b=kZT8QoIMQ6x51mxgqekYXhnzmUWSkErgpTI6jlaSzQCGS9e3/BSndq8yXI0y0j8Xa7
 U5qPKq+tepqdKFe5s3ZiaBz0rTKDiu9BQoUXDe+4ViPQyfBxu6tffyiKRDGvB7NSYuHs
 J2Vgi15sTaNnuSPzqX19XGme9QhbfPsUbg085nxGYn7zdu5FpiaerzaZu8oBtDzSL8Nt
 bgKmIHG9IxKohXqKJxvOvXlejmVzyY7Rl3sVAXIoAhKb56X3VN4eYFUtq4DEJBKK5mzp
 TPyoYYo7dnkKTUI0gEfmJa+NBk8bfooo0VFK7XjoyB9tOXnxV2zjIWmI9S0mEXVxqEKu
 vBgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5PMxigBgkC5/tBwxURNZnEf6b2EGuel0yliKmeq/+NK3xUb0/rzkz2WaBEMyJwsdVT025wiCAWocoJeX0w7tcY/zDwnk=
X-Gm-Message-State: AOJu0YzlTP5tFbYa4GXVQ+KuXfWgXETFI7WGmalW95urKemmIupIZEfv
 S8EeshFgcp3btCU6tqOHxZfOfcxgBz5Yti9px99uxT9TtJifQ6rZJVEregkLUCv0A+W3YPwR+em
 H8jCRD8mbZByDn8mCjY+6wI7YF/L/Gq51ni5HpfRfgPZAsugr2CDn
X-Received: by 2002:a05:620a:3b89:b0:78d:7034:c145 with SMTP id
 ye9-20020a05620a3b8900b0078d7034c145mr10735473qkn.53.1713187333439; 
 Mon, 15 Apr 2024 06:22:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6p47rDiIIR3nEe41tiJYC8tEne0t9SVcQU4ODwVvjvuXlm5AHu5snpAxmmdKU+wLe+Jtl0A==
X-Received: by 2002:a05:620a:3b89:b0:78d:7034:c145 with SMTP id
 ye9-20020a05620a3b8900b0078d7034c145mr10735448qkn.53.1713187333145; 
 Mon, 15 Apr 2024 06:22:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:d55d:ba01:adf2:d3ae?
 ([2a01:e0a:9e2:9000:d55d:ba01:adf2:d3ae])
 by smtp.gmail.com with ESMTPSA id
 l25-20020a05620a211900b0078d67d40c49sm6301513qkl.70.2024.04.15.06.22.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Apr 2024 06:22:12 -0700 (PDT)
Message-ID: <82065d07-3c7b-41dc-9a22-8b1f58a61830@redhat.com>
Date: Mon, 15 Apr 2024 15:22:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/10] backends/iommufd: Introduce helper function
 iommufd_backend_get_device_info()
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Yi Sun <yi.y.sun@linux.intel.com>
References: <20240408081230.1030078-1-zhenzhong.duan@intel.com>
 <20240408081230.1030078-7-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240408081230.1030078-7-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.185,
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

On 4/8/24 10:12, Zhenzhong Duan wrote:
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
> index 71c53cbb45..fa1a866237 100644
> --- a/include/sysemu/iommufd.h
> +++ b/include/sysemu/iommufd.h
> @@ -4,6 +4,7 @@
>   #include "qom/object.h"
>   #include "exec/hwaddr.h"
>   #include "exec/cpu-common.h"
> +#include <linux/iommufd.h>
>   #include "sysemu/host_iommu_device.h"
>   
>   #define TYPE_IOMMUFD_BACKEND "iommufd"
> @@ -34,6 +35,9 @@ int iommufd_backend_map_dma(IOMMUFDBackend *be, uint32_t ioas_id, hwaddr iova,
>                               ram_addr_t size, void *vaddr, bool readonly);
>   int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
>                                 hwaddr iova, ram_addr_t size);
> +int iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
> +                                    enum iommu_hw_info_type *type,
> +                                    void *data, uint32_t len, Error **errp);
>   
>   #define TYPE_HIOD_IOMMUFD TYPE_HOST_IOMMU_DEVICE "-iommufd"
>   OBJECT_DECLARE_TYPE(HIODIOMMUFD, HIODIOMMUFDClass, HIOD_IOMMUFD)
> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index ef8b3a808b..559affa9ec 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -20,7 +20,6 @@
>   #include "monitor/monitor.h"
>   #include "trace.h"
>   #include <sys/ioctl.h>
> -#include <linux/iommufd.h>
>   
>   static void iommufd_backend_init(Object *obj)
>   {
> @@ -212,6 +211,28 @@ int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
>       return ret;
>   }
>   
> +int iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
> +                                    enum iommu_hw_info_type *type,
> +                                    void *data, uint32_t len, Error **errp)
> +{
> +    struct iommu_hw_info info = {
> +        .size = sizeof(info),
> +        .dev_id = devid,
> +        .data_len = len,
> +        .data_uptr = (uintptr_t)data,
> +    };
> +    int ret;
> +
> +    ret = ioctl(be->fd, IOMMU_GET_HW_INFO, &info);
> +    if (ret) {
> +        error_setg_errno(errp, errno, "Failed to get hardware info");
> +    } else {
> +        *type = info.out_data_type;

type should not be NULL.
> +    }
> +
> +    return ret;
> +}
> +
>   void hiod_iommufd_init(HIODIOMMUFD *idev, IOMMUFDBackend *iommufd,
>                          uint32_t devid)
>   {


