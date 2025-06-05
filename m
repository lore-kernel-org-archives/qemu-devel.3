Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8192C5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 09:53:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN7He-0006ld-BI; Thu, 05 Jun 2025 05:53:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uN7Hb-0006kt-Bo
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 05:53:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uN7HZ-0002q3-U7
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 05:53:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749117186;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yFqkuWNIjNZJCTXr6GVjp6ZBu3pwiLlyN+Nhg61CpMM=;
 b=MVBL2olT37j1DaSOtg8OVt7bAw0BnQSdP8HYzxLV/DuSeeLnqn+vU5QrBHYg1FWTWuQY8d
 1BKSp5VFY8hpx4oVh6iE4nFoVunJZytZJpf57ZoLqmWfgJZx15ljyOK6RzWAJyBTV8bU0u
 cvtAyRiomwjmaKpdg/HaD+0vKM50MJc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687--FBT2YhdNLyN2_AaB6EKCw-1; Thu, 05 Jun 2025 05:53:05 -0400
X-MC-Unique: -FBT2YhdNLyN2_AaB6EKCw-1
X-Mimecast-MFC-AGG-ID: -FBT2YhdNLyN2_AaB6EKCw_1749117184
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-442e0e6eb84so4796245e9.0
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 02:53:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749117184; x=1749721984;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yFqkuWNIjNZJCTXr6GVjp6ZBu3pwiLlyN+Nhg61CpMM=;
 b=ndhPy8dEqfyaiNil/gxUrjmDxxxbfLb6zdq7vT78HOpuTRMRMBn2wOjI6df1qv/IEr
 brTvbchF3OL4NhQU8Dt+RDILVmwtS6zqcJ5msn0KOpv9VOxItjK3yBGteeXPc9lb9Jtv
 0b21+juiV6unVkr8HAA0H9L1eRyQPccBB68JMYJw9pJjPDZLOv/cYeX0+5YKTo6mpz9Z
 tn3BKTQxALSpIcCYPY/UCqusAzZnSn9oH9z9X9NpmrNN9wXFzh3fgoq+1jCZAP0ffKur
 2QNqxF7i0TdVajNklpE12nq22l0of+PhmvfyFEr8er6l9s1hg+uxecTppaSDY9JkXRX9
 RpGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJfmTZU0g0ye25tr9FmOPr16h+eIiFB8wAYb6H3I92O8DYhxbqF5FGKWA++3OVXbnExVBQgNJD/c4T@nongnu.org
X-Gm-Message-State: AOJu0YwIKRc5pjGMsYDB46bWcjey8940Fv8Ci7frEMa4ULt66miAl+2n
 Ly9zDHOQ4Z1E0uLaN+wyxUvU2C5N1PSYnk4gt+Z4usA6dXtyUVanMV3FCyKq9Zyf+NDzeE+0vSD
 VgnJsGwLTidEE/yj1olF9rHughgGSWFAKvhBRP/j2LFGjSZ5TaoZnx/p1
X-Gm-Gg: ASbGnct+mAGgWSpeNh+NO8c1xbsADozvKtM6la5ckmze6ZDoI8q5uwczKtmHpgGs9rP
 K9P8P8y7duKvzR+NMLMCW4WX2Vo3cV6hvaC3vN9YdRgP5dUEZKKGI9y04m+6WOHwCkY1FNWa7cs
 kLVw0RNG3t+swtvg9mqhhQdZQL1kmmnK96n/sT8Xsqjb+Jq+D6myStW0SEbOU4NyiygFKt8YxpB
 JWj1FqmaHOQWjBxXbdIoU/jQC+GBXwWp7xwknk6VB9aq0KEymtP6tAsUHPdn9ASSJhCpTxLViPp
 mYdES9zUN8ElXaBTES5xRetcTtWWsHRF/ir2OSeE6jhMKSkxxWLkNWpERN0=
X-Received: by 2002:a05:6000:258a:b0:3a1:fe77:9e1d with SMTP id
 ffacd0b85a97d-3a51d91faf2mr4742375f8f.16.1749117183877; 
 Thu, 05 Jun 2025 02:53:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEaLMsQPlWmjli03d5TEu+Gn9qoT2rpZLuTO7LXCJC8QyhdE0YVXhiHFAZwDGPJy+gpz7Nhjw==
X-Received: by 2002:a05:6000:258a:b0:3a1:fe77:9e1d with SMTP id
 ffacd0b85a97d-3a51d91faf2mr4742343f8f.16.1749117183435; 
 Thu, 05 Jun 2025 02:53:03 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4f00a0421sm24319058f8f.97.2025.06.05.02.53.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Jun 2025 02:53:02 -0700 (PDT)
Message-ID: <15b1fd04-2dd0-4191-8958-9d8db8dff7c9@redhat.com>
Date: Thu, 5 Jun 2025 11:53:01 +0200
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 6/2/25 5:41 PM, Shameer Kolothum wrote:
> Although this change does not affect functionality at present, it is
> required when we add support for user-creatable SMMUv3 devices in
> future patches.
>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
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
shouldn't you check as well that !pci_bus_bypass_iommu(bus)?

Eric
>  
>      c->parent_realize(d, &local_err);
>      if (local_err) {


