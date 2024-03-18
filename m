Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2D17C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 14:55:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmEOA-0003GY-Sw; Mon, 18 Mar 2024 10:54:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rmEO7-0003Fs-PX
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 10:54:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rmEO5-0006uL-6V
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 10:54:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710773690;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6aEuYRjBQEZI5V8EC4/CRtllUeT8VoS3YDZXi2ULUjk=;
 b=dqsmeMZb60vrL4kqK7dvX4Fz0VWkK1FTsdxPni5uB653Z0Uqb12LHUay9XOu8ZZeE1bCKM
 Hpd1OpiFq+lcG3kFYgkgRokMWhuAl5jUKPie4ekPhiGr/tGC+eqN5PrUfSpPITQUv8JFmJ
 qE2n843tXBk7Bmc/4lvR9G01wJeu1KU=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-i_A-ADz3OVai7AlsNdbizQ-1; Mon, 18 Mar 2024 10:54:49 -0400
X-MC-Unique: i_A-ADz3OVai7AlsNdbizQ-1
Received: by mail-yb1-f197.google.com with SMTP id
 3f1490d57ef6-dccc49ef73eso5500803276.2
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 07:54:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710773689; x=1711378489;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6aEuYRjBQEZI5V8EC4/CRtllUeT8VoS3YDZXi2ULUjk=;
 b=QQ6PN1UZEItK3sbmYmzjS9X+ZGaJ9CfymJAQwie+jD+GBiG0E5TaWqwLyZnwoEJIlG
 ltyKlVndX8JjXTY1JpPpTJST0kTgxgMIPqTEySgoQbZuJjh5/xl+5uLtKwF345MUa77t
 6P++w3Ah2/+1urhV5ZxMZjsxQPHdigTO/LFnVFPEYado/we+CmA71P0nnIHtsWiFjgyi
 KxuISNpnhguf/cT13AP8g/LZ4MV00ioccxi5WS2wgpYmh8249yo5erSO5C0A7vLUr9bM
 xK5ysUe4X3t58yv/MqA1BhH8gLKcwW2x5MtXdJy3dQT1HqSQqCabaBobNTfgvo/+AC65
 3pOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXm2xqcF2jq2+wOYjMb3VIxH1yddVwvYxhdFJl0sosVkcFlD18GYlD4M3KHHOjdKBBPIJog2AXtZWdXpVDaqo3XtRMP6lw=
X-Gm-Message-State: AOJu0Yw5kLQ+1QFy5yPOftcECURT2oOijC4Qsi1k1sc8mX5ghqDPDn+m
 2nFU3ctdxNY0/lW2+0319YfUq9iC0bS1e8zWZCkjLTYj1AZ+XgVgLFRSG4oVRTEz+5Vtivqnwpx
 LFC5Yak3qJw1ki/1YOAsxzlx564lPfa5lRsZFqL/5sj9pivxVJk3e
X-Received: by 2002:a05:6902:82:b0:dc2:2041:fc49 with SMTP id
 h2-20020a056902008200b00dc22041fc49mr7149467ybs.5.1710773687494; 
 Mon, 18 Mar 2024 07:54:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYGV+O2/PW24LEV3XLKpAXIwUiWGUaVuxW2YhMnjHwAWakFj1Z0/Q5EIXy2OnuOS8Bv6VukA==
X-Received: by 2002:a05:6902:82:b0:dc2:2041:fc49 with SMTP id
 h2-20020a056902008200b00dc22041fc49mr7149449ybs.5.1710773687204; 
 Mon, 18 Mar 2024 07:54:47 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 f3-20020ac84983000000b0042f0504229esm4995727qtq.60.2024.03.18.07.54.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Mar 2024 07:54:46 -0700 (PDT)
Message-ID: <db2f0780-7817-423b-a286-c3c67b95367c@redhat.com>
Date: Mon, 18 Mar 2024 15:54:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 11/11] backends/iommufd: Introduce helper function
 iommufd_device_get_info()
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com, Yi Sun <yi.y.sun@linux.intel.com>
References: <20240228035900.1085727-1-zhenzhong.duan@intel.com>
 <20240228035900.1085727-12-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240228035900.1085727-12-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Zhenzhong,

On 2/28/24 04:59, Zhenzhong Duan wrote:
> Introduce a helper function iommufd_device_get_info() to get
> host IOMMU related information through iommufd uAPI.
Looks strange to have this patch in this series. I Would rather put it
in your second series alongs with its user.

Eric
>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  include/sysemu/iommufd.h |  4 ++++
>  backends/iommufd.c       | 23 ++++++++++++++++++++++-
>  2 files changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
> index d509ff88ef..518b97bfed 100644
> --- a/include/sysemu/iommufd.h
> +++ b/include/sysemu/iommufd.h
> @@ -4,6 +4,7 @@
>  #include "qom/object.h"
>  #include "exec/hwaddr.h"
>  #include "exec/cpu-common.h"
> +#include <linux/iommufd.h>
>  #include "sysemu/host_iommu_device.h"
>  
>  #define TYPE_IOMMUFD_BACKEND "iommufd"
> @@ -48,4 +49,7 @@ typedef struct IOMMUFDDevice {
>  
>  void iommufd_device_init(IOMMUFDDevice *idev,
>                           IOMMUFDBackend *iommufd, int devid);
> +int iommufd_device_get_info(IOMMUFDDevice *idev,
> +                            enum iommu_hw_info_type *type,
> +                            uint32_t len, void *data, Error **errp);
>  #endif
> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index 6d280e4aea..69f3f75ea5 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -20,7 +20,6 @@
>  #include "monitor/monitor.h"
>  #include "trace.h"
>  #include <sys/ioctl.h>
> -#include <linux/iommufd.h>
>  
>  static void iommufd_backend_init(Object *obj)
>  {
> @@ -240,3 +239,25 @@ void iommufd_device_init(IOMMUFDDevice *idev,
>      idev->iommufd = iommufd;
>      idev->devid = devid;
>  }
> +
> +int iommufd_device_get_info(IOMMUFDDevice *idev,
> +                            enum iommu_hw_info_type *type,
> +                            uint32_t len, void *data, Error **errp)
> +{
> +    struct iommu_hw_info info = {
> +        .size = sizeof(info),
> +        .dev_id = idev->devid,
> +        .data_len = len,
> +        .data_uptr = (uintptr_t)data,
> +    };
> +    int ret;
> +
> +    ret = ioctl(idev->iommufd->fd, IOMMU_GET_HW_INFO, &info);
> +    if (ret) {
> +        error_setg_errno(errp, errno, "Failed to get hardware info");
> +    } else {
> +        *type = info.out_data_type;
> +    }
> +
> +    return ret;
> +}


