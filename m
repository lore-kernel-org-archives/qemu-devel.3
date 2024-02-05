Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2600EC4828D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 09:15:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWv3k-0002Em-0i; Mon, 05 Feb 2024 04:14:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rWv3g-0002EO-Cp
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 04:14:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rWv3d-0007FS-HS
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 04:14:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707124463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DzNp7sWBNaERwY/1vkfXUPUo3G5xyIojHBmkAPU/Fto=;
 b=GGI/I/8Oi43sn7ljAd7Bj4pFvQ9BcGMV+zYbvCghe6BGN516ZXtGyB8otoSslfpd2pCQh3
 5/Q6XXW45QWAaKKHDrQa99EHsZBi0/UQNZt6O3pRK7EawkkUShmV8/f9EUbgnGRNxHkauu
 ryb0oVuUPX7WQn0AQpkyx8Tu24ztUP8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-qP0no6_vM9Om4NjUke6s1g-1; Mon, 05 Feb 2024 04:14:22 -0500
X-MC-Unique: qP0no6_vM9Om4NjUke6s1g-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-40f00a86728so22455935e9.2
 for <qemu-devel@nongnu.org>; Mon, 05 Feb 2024 01:14:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707124461; x=1707729261;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DzNp7sWBNaERwY/1vkfXUPUo3G5xyIojHBmkAPU/Fto=;
 b=TiN58JwgSkxnrlYYbhFnMIUGoAN4P1hX+rRJXui281EdQYzEmvINF6qROzULTSaIDx
 sY28OP1fgRKoWID73Mt455It8bM+AdbabLUBtyl8la7PK73/8xcD0Masv7Mth3e/XlM0
 BtKJ8I5LYlqTzVB48LsIQ9/HWljKOe0p3Z9mhe6zrxXJNnRb3fSEQpnQt7aMdETWVmWy
 s4ynarPmwmtyu+vqA+ogI86Icq4dlawHt5BJNSlaUBuqW9gmK7SLtRMgKGXYG4cSRFOs
 7JU7vpEgbzos6F07iuojCUAztHsQRAQi2oCYhyLgKL4A/frMxXHLBOsU6VnH9gnY+eMB
 N7Sg==
X-Gm-Message-State: AOJu0YzdurgugPwnM0gmiGTnq5Pn0u9IokFzXi0wX2CS3nXWl1x4Qri4
 4LhGbowHUDEGA+5jMmPb0ykyn1mm8WscG48HERLUN6IdjahjSYXsnrmg2gLnf3L9XdqYXAv9NOW
 VrWm4uZyFuS0p2SPQ1vqkq4H8u0AsAsRPCPauoDeC0HgDPt3DOu2W
X-Received: by 2002:a05:600c:46cb:b0:40f:bdf1:58cc with SMTP id
 q11-20020a05600c46cb00b0040fbdf158ccmr4230227wmo.33.1707124461542; 
 Mon, 05 Feb 2024 01:14:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFAV/kp2c8zfes5ygFv53BG2uDzxzxD+NbDTutnyHu+JaeSIZTkYb1WZXXIIzHrEP9Nw/F0XQ==
X-Received: by 2002:a05:600c:46cb:b0:40f:bdf1:58cc with SMTP id
 q11-20020a05600c46cb00b0040fbdf158ccmr4230210wmo.33.1707124461206; 
 Mon, 05 Feb 2024 01:14:21 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCVdoLYOvCva2nfQ97SqK0QGnWa+LPFccwGXmsWN617vAlXGYM6DsRhPlf2vPUCmAEE11AMPn1gXTZXjrw7pXlfRSztkT8cJxbeiOoBbDxe+SwOQOwno6djeXPExDAll8xPlmMZTAiq61uRXSg6rcrvTk00l8RCdOgapSnfkVKVFSmSslis0zqq857FywD1N0aa616dfNFlvyoR/SaFpaBj8H5ZfF37C6VhjpDbk8V51Ezi3m9jA5hXdCpAw7x/ybJAG013rjPbC4h1CyDoW+WxE4ZNTN0RR9KdX2QtOw4SgXP+B5eYFpB+6Ymd6lYYTLWn0cDsV6Z6lRp7wJqSMaU1QqDcZgk5a5cg=
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 k15-20020a05600c1c8f00b0040eea5dc778sm2060515wms.1.2024.02.05.01.14.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Feb 2024 01:14:20 -0800 (PST)
Message-ID: <319bda87-1d7e-40e3-812f-0f9c4d61f357@redhat.com>
Date: Mon, 5 Feb 2024 10:14:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] virtio-iommu: Add an option to define the input
 range width
Content-Language: en-US
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, jean-philippe@linaro.org,
 alex.williamson@redhat.com, peter.maydell@linaro.org,
 zhenzhong.duan@intel.com, yanghliu@redhat.com
Cc: mst@redhat.com, jasowang@redhat.com
References: <20240201163324.564525-1-eric.auger@redhat.com>
 <20240201163324.564525-2-eric.auger@redhat.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240201163324.564525-2-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.361,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 2/1/24 17:32, Eric Auger wrote:
> aw-bits is a new option that allows to set the bit width of
> the input address range. This value will be used as a default for
> the device config input_range.end. By default it is set to 64 bits
> which is the current value.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> 
> v1 -> v2:
> - Check the aw-bits value is within [32,64]
> ---
>   include/hw/virtio/virtio-iommu.h | 1 +
>   hw/virtio/virtio-iommu.c         | 7 ++++++-
>   2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virtio-iommu.h
> index 781ebaea8f..5fbe4677c2 100644
> --- a/include/hw/virtio/virtio-iommu.h
> +++ b/include/hw/virtio/virtio-iommu.h
> @@ -66,6 +66,7 @@ struct VirtIOIOMMU {
>       bool boot_bypass;
>       Notifier machine_done;
>       bool granule_frozen;
> +    uint8_t aw_bits;
>   };
>   
>   #endif
> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
> index ec2ba11d1d..7870bdbeee 100644
> --- a/hw/virtio/virtio-iommu.c
> +++ b/hw/virtio/virtio-iommu.c
> @@ -1314,7 +1314,11 @@ static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
>        */
>       s->config.bypass = s->boot_bypass;
>       s->config.page_size_mask = qemu_real_host_page_mask();
> -    s->config.input_range.end = UINT64_MAX;
> +    if (s->aw_bits < 32 || s->aw_bits > 64) {
> +        error_setg(errp, "aw-bits must be within [32,64]");
> +    }
> +    s->config.input_range.end =
> +        s->aw_bits == 64 ? UINT64_MAX : BIT_ULL(s->aw_bits) - 1;


This could be simplified :

   s->config.input_range.end = BIT_ULL(s->aw_bits) - 1;

Anyhow,


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



>       s->config.domain_range.end = UINT32_MAX;
>       s->config.probe_size = VIOMMU_PROBE_SIZE;
>   
> @@ -1525,6 +1529,7 @@ static Property virtio_iommu_properties[] = {
>       DEFINE_PROP_LINK("primary-bus", VirtIOIOMMU, primary_bus,
>                        TYPE_PCI_BUS, PCIBus *),
>       DEFINE_PROP_BOOL("boot-bypass", VirtIOIOMMU, boot_bypass, true),
> +    DEFINE_PROP_UINT8("aw-bits", VirtIOIOMMU, aw_bits, 64),
>       DEFINE_PROP_END_OF_LIST(),
>   };
>   


