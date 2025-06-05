Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 994B4C5AE59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 09:14:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN6fF-0006yE-B0; Thu, 05 Jun 2025 05:13:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uN6f8-0006xH-Ke
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 05:13:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uN6f6-0000jV-Kb
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 05:13:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749114802;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mcVuqByWhcIeIPikzMkKDKFUX7b6Fi548juUgAk9raU=;
 b=VD8IRQ6F09WDRNB1H1v/Nc7ZcrmKE2I/NBvk+N7/z+LYYLK851aawUVNCtINV3yRGcjrMH
 OkxsEMXMtqKWf1mkR7Q30zMmLScu1YKtZtx3tLd28/743W3ST0znoyJRosBgULzeO6ETFe
 iGcs2ur4XFIIucHabgdjRwmUBjdkstA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-VyLjXyI1OumhT_MTZ9NxUw-1; Thu, 05 Jun 2025 05:13:21 -0400
X-MC-Unique: VyLjXyI1OumhT_MTZ9NxUw-1
X-Mimecast-MFC-AGG-ID: VyLjXyI1OumhT_MTZ9NxUw_1749114800
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a503f28b09so371803f8f.0
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 02:13:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749114800; x=1749719600;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mcVuqByWhcIeIPikzMkKDKFUX7b6Fi548juUgAk9raU=;
 b=F+xgIDIASIXdPD6+p6hgBT3NkxPlryZg42KlAHYjhstSfwE0GuhKdwO2bJbJIinuRc
 H5FeITUe1nIwaSpND9EjwhS9FVkOmKXd7NK53hD/mQcw1fd1npNJ0t/Mij88OJHLSHlw
 Zbir4Xsitwl/XWO3vwu/e13UYI6bAyzRBLYp65cY99PyxtpWKYLOCEaIoR35RS4pHE4P
 vb38xqOSphSAGlHHHsSRPgM/FnC2YuAdoPwAJNZgDbNqH57yxYLlLvG+4Z9mhEpPGMCr
 ObCUrgRbhRIq5pP13L0qVyryFQnHFWp1t6b5JDwbySqj+1f6SEhkJy5hVVv/27A+ciqL
 BoQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUF0EtgiBHXUcVn01dbM5e7Y/SOIxstjUYWoOX4YLbENogsOdUD55f5wpOaUJPLWQsU7t7+C9WDMfsc@nongnu.org
X-Gm-Message-State: AOJu0Yy994ZHKGD3ULtXwSIKtZTCdDi7SJRTtmH87rn376duK2z6wd3Z
 ygzeCLm18IjPXrTTePHj07bJQmfeY4+fqZkR0QIcxyC9O6bZ3IwcSdKHczxXPujFCx+j9QYCPde
 Wf8HoaLOlcFbH1WiBNJt9vNZ1FuH5d+p2l1JEDKYZ/HvQNhTH1vWegIfP
X-Gm-Gg: ASbGncs+c9MmXN6ZBhlRSDeJO2YTz0ptIUsP3iN6DZvLuxhFLtmQ2AUt3xxzorsw9wt
 EBQhxOEui6S0jOlfmuZO9DlNHIsV0aG2Z6IZEh9yfBirhOKDj3mWjzdCBlOER+g4SjQS+Rtdckh
 piKZMUNpFb9dQiop7HU2sNYuAV31n7RRhI2zEE9u2I+va7qRZ2gGs5DsaRbiPI8kxfaBaDL1qEB
 azVgMpLvJ8oXKl0foY/aao95eSTWUYz6eR8e5iWcp0cjcLGzNCMFXjnP6xPfmPHJCJtuZRB6IYs
 x/OJEwievcUpMIFz5RXKm9Ut1lrczZ2UdmUwUg96HlzGQFcavIwTOXnDeik=
X-Received: by 2002:a05:6000:2302:b0:3a3:6478:e08 with SMTP id
 ffacd0b85a97d-3a526e13838mr2493538f8f.23.1749114799854; 
 Thu, 05 Jun 2025 02:13:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxEPTcYEkPVX2O7YwmyEAviHVQsmEs1TBaKGhjReBhaf3tu0YCh8hpxHBW00Jwstik03Gm9w==
X-Received: by 2002:a05:6000:2302:b0:3a3:6478:e08 with SMTP id
 ffacd0b85a97d-3a526e13838mr2493498f8f.23.1749114799394; 
 Thu, 05 Jun 2025 02:13:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe6cd15sm24351195f8f.39.2025.06.05.02.13.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Jun 2025 02:13:18 -0700 (PDT)
Message-ID: <9a9c70eb-6b2e-4bd5-b665-8b91ae06ae43@redhat.com>
Date: Thu, 5 Jun 2025 11:13:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] hw/arm/smmuv3: Check SMMUv3 has PCIe Root Complex
 association
Content-Language: en-US
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, linuxarm@huawei.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
References: <20250602154110.48392-1-shameerali.kolothum.thodi@huawei.com>
 <20250602154110.48392-2-shameerali.kolothum.thodi@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250602154110.48392-2-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hi Shameer,

On 6/2/25 5:41 PM, Shameer Kolothum wrote:
> Although this change does not affect functionality at present, it is
> required when we add support for user-creatable SMMUv3 devices in
> future patches.
>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/arm/smmuv3.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index ab67972353..7e934336c2 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -24,6 +24,7 @@
>  #include "hw/qdev-properties.h"
>  #include "hw/qdev-core.h"
>  #include "hw/pci/pci.h"
> +#include "hw/pci/pci_bridge.h"
>  #include "cpu.h"
>  #include "exec/target_page.h"
>  #include "trace.h"
> @@ -1881,6 +1882,13 @@ static void smmu_realize(DeviceState *d, Error **errp)
>      SMMUv3Class *c = ARM_SMMUV3_GET_CLASS(s);
>      SysBusDevice *dev = SYS_BUS_DEVICE(d);
>      Error *local_err = NULL;
> +    Object *bus;
> +
> +    bus = object_property_get_link(OBJECT(d), "primary-bus", &error_abort);
> +    if (!bus || !object_dynamic_cast(bus->parent, TYPE_PCI_HOST_BRIDGE)) {
> +        error_setg(errp, "SMMUv3 is not attached to any PCIe Root Complex!");
> +        return;
> +    }
>  
>      c->parent_realize(d, &local_err);
>      if (local_err) {


