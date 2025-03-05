Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0187AC19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 11:06:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpmZ4-0003Nu-RV; Wed, 05 Mar 2025 06:05:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tpmZ0-0003NE-1s
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 06:05:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tpmYu-0002S9-SQ
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 06:05:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741172713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=HOCSf5W/oX94MTlg5yxxkUQ3sSFhzlHC8+SWEbW74b8=;
 b=R2xu04FMjyXctspNkddTIOhnkRamvGnpIBZPppSaxKKAj8QC+5X+NIL5J4Kk8hdngn+Eyb
 aCF8aAhzGxWISsscN47zGwMmEu+HYMk0KnLedxxX8UeyANnM43VzIEF0bFQr2XV1PvRaYS
 FzawlaGJGTDyDyinGCQkK2iGi314U5E=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-hdofV72NP220KvSgOGPmPg-1; Wed, 05 Mar 2025 06:05:12 -0500
X-MC-Unique: hdofV72NP220KvSgOGPmPg-1
X-Mimecast-MFC-AGG-ID: hdofV72NP220KvSgOGPmPg_1741172711
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4388eee7073so3267165e9.0
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 03:05:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741172711; x=1741777511;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HOCSf5W/oX94MTlg5yxxkUQ3sSFhzlHC8+SWEbW74b8=;
 b=vYQAfoxNIGGvuezR+jDEiFp2zLvVm78+98hnX2umpYwM8QWhclcMZ0pcsRN6R3+rVJ
 ueYUdomEk8jHjVfiMnyO6VLEywlxuLMjv1ltGyCg1/NzoR6s9z8ktyZKLTlZl3xJBTaf
 Kz4IdVf+fCffBJW691TBxC4xJtgXCTttIEBax8Pmht+8hXqPFkuWnL6ZI53ZyqO1H21x
 vxtc2/j/5xVO6uxRBjgNeHzumqfow5K+g4m6Yl99qrz0nZh/5/mV1yH58DxOUC+Cf9v7
 lkjrFHDqr1hmemRVkUH5nxBHp0YL5bstf/tCG4wNKXM0D9L7Vptai1NP70P9+Z5mkGeu
 sOuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV61bXsB/PAlkbqhpX9G8EkfJyc8DDl3nsW0OGix6T3EeUBsokXwdvrNuGZilC7QpzWIXN8uKfwWPNe@nongnu.org
X-Gm-Message-State: AOJu0YzQ9+lVg5w30f9ftMok7UiqVKvs2FS5G1k/EGZGjszP8/yB24M5
 1Z76MXSFWTqEHKJIVVX6+fMFK5ykq5uShCIlIh84+SooM0ka8DVTT9IqWBGCojlSr8c4cqPiJAu
 YjyCZkAzt1rHNSAA86bYt2aV2gkXCsNyqyLQgm8DxpOyiP+9oeDp/
X-Gm-Gg: ASbGncuf+ftQ+1k+aDac+OBBQivCvNP8jrFhgLTs8U91qTZzpAylYdU6MgEqQ64s/s1
 C/aBEZROfTlqsoKkAKzpoeRGrESLZGAdLqR+L1HYavlbgD3IbDFRp4S8boigp8TYsx+nrGfYNcw
 BqAMB2A9gp0bjENVFij9YyliksNier3LpJKXEOlTIJ4RLF8Hn7AujZgHjwmwmZZS7y4Hcv3usCu
 nf45JScJOznFBu49OktRpVx+7jdcfR8slFSmLMl72XLg5PPcMwfGyXAysY+tyZ7jpp2OlNNiSHh
 wUFY3M6iz8HbiwFc2UYUQ3dylawFQ5m/Hl8mkJNnwTf71nMI6DgTwg==
X-Received: by 2002:a05:600c:4f88:b0:43b:bb72:1dce with SMTP id
 5b1f17b1804b1-43bcae1941fmr53470405e9.5.1741172711216; 
 Wed, 05 Mar 2025 03:05:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEhKBwZ8xa/koZVdJHdU6iujjIppH2mTDyrFitEwJBhjasFsEUbDgUADdQupeR1E6JQ0fJngA==
X-Received: by 2002:a05:600c:4f88:b0:43b:bb72:1dce with SMTP id
 5b1f17b1804b1-43bcae1941fmr53470185e9.5.1741172710756; 
 Wed, 05 Mar 2025 03:05:10 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd42c5dd1sm14042185e9.18.2025.03.05.03.05.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Mar 2025 03:05:10 -0800 (PST)
Message-ID: <7c0acf9a-4578-40f0-8909-e67a386a3bd5@redhat.com>
Date: Wed, 5 Mar 2025 12:05:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio-platform: Deprecate all forms of vfio-platform
 devices
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, alex.williamson@redhat.com,
 peter.maydell@linaro.org, philmd@linaro.org
Cc: zhenzhong.duan@intel.com, will@kernel.org, maz@kernel.org
References: <20250305105800.949153-1-eric.auger@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250305105800.949153-1-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 3/5/25 11:58, Eric Auger wrote:
> As an outcome of KVM forum 2024 "vfio-platform: live and let die?"
> talk, let's deprecate vfio-platform devices.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>   docs/about/deprecated.rst | 25 +++++++++++++++++++++++++
>   hw/vfio/amd-xgbe.c        |  2 ++
>   hw/vfio/calxeda-xgmac.c   |  2 ++
>   hw/vfio/platform.c        |  1 +
>   4 files changed, 30 insertions(+)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index abadf8de27..d11a7004df 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -434,6 +434,31 @@ Stream ``reconnect`` (since 9.2)
>   The ``reconnect`` option only allows specifiying second granularity timeouts,
>   which is not enough for all types of use cases, use ``reconnect-ms`` instead.
>   
> +VFIO device options
> +''''''''''''''''''
> +
> +``-device vfio-calxeda-xgmac`` (since v2.4)
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The version mentioned after since corresponds to the version in which
the machine/device/feature was deprecated, not the version it was added.

With that changed,

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



  
> +The vfio-calxeda-xgmac device allows to assign a host Calxeda Highbank
> +10Gb XGMAC Ethernet controller device ("calxeda,hb-xgmac" compatibility
> +string) to a guest. Calxeda HW has been ewasted now and there is no point
> +keeping that device.
> +
> +``-device vfio-amd-xgbe`` (since v2.6)
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +The vfio-amd-xgbe devices allows to assign a host AMD 10GbE controller
> +to a guest ("amd,xgbe-seattle-v1a" compatibility string). AMD "Seattle"
> +is not supported anymore and there is no point keeping that device.
> +
> +``-device vfio-platform`` (since v3.1)
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +The vfio-platform device allows to assign a host platform device
> +to a guest in a generic manner. Integrating a new device into
> +the vfio-platform infrastructure requires some adaptation at
> +both kernel and qemu level. No such attempt has been done for years
> +and the conclusion is that vfio-platform has not got any traction.
> +PCIe passthrough shall be the mainline solution.
> +
>   CPU device properties
>   '''''''''''''''''''''
>   
> diff --git a/hw/vfio/amd-xgbe.c b/hw/vfio/amd-xgbe.c
> index aaa96903db..5927503b5c 100644
> --- a/hw/vfio/amd-xgbe.c
> +++ b/hw/vfio/amd-xgbe.c
> @@ -15,12 +15,14 @@
>   #include "hw/vfio/vfio-amd-xgbe.h"
>   #include "migration/vmstate.h"
>   #include "qemu/module.h"
> +#include "qemu/error-report.h"
>   
>   static void amd_xgbe_realize(DeviceState *dev, Error **errp)
>   {
>       VFIOPlatformDevice *vdev = VFIO_PLATFORM_DEVICE(dev);
>       VFIOAmdXgbeDeviceClass *k = VFIO_AMD_XGBE_DEVICE_GET_CLASS(dev);
>   
> +    warn_report("-device vfio-amd-xgbe is deprecated");
>       vdev->compat = g_strdup("amd,xgbe-seattle-v1a");
>       vdev->num_compat = 1;
>   
> diff --git a/hw/vfio/calxeda-xgmac.c b/hw/vfio/calxeda-xgmac.c
> index b016d42b49..a5ef262def 100644
> --- a/hw/vfio/calxeda-xgmac.c
> +++ b/hw/vfio/calxeda-xgmac.c
> @@ -15,12 +15,14 @@
>   #include "hw/vfio/vfio-calxeda-xgmac.h"
>   #include "migration/vmstate.h"
>   #include "qemu/module.h"
> +#include "qemu/error-report.h"
>   
>   static void calxeda_xgmac_realize(DeviceState *dev, Error **errp)
>   {
>       VFIOPlatformDevice *vdev = VFIO_PLATFORM_DEVICE(dev);
>       VFIOCalxedaXgmacDeviceClass *k = VFIO_CALXEDA_XGMAC_DEVICE_GET_CLASS(dev);
>   
> +    warn_report("-device vfio-calxeda-xgmac is deprecated");
>       vdev->compat = g_strdup("calxeda,hb-xgmac");
>       vdev->num_compat = 1;
>   
> diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
> index f491f4dc95..a09f7f65c6 100644
> --- a/hw/vfio/platform.c
> +++ b/hw/vfio/platform.c
> @@ -575,6 +575,7 @@ static void vfio_platform_realize(DeviceState *dev, Error **errp)
>       VFIODevice *vbasedev = &vdev->vbasedev;
>       int i;
>   
> +    warn_report("-device vfio-platform is deprecated");
>       qemu_mutex_init(&vdev->intp_mutex);
>   
>       trace_vfio_platform_realize(vbasedev->sysfsdev ?


