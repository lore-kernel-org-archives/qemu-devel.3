Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC704C7EE31
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 11:53:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uV7d3-0003a3-Eo; Fri, 27 Jun 2025 07:52:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uV7cv-0003YB-Ot
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 07:52:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uV7cs-0007Iz-S9
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 07:52:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751025131;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YlWygZYUVVARXUXJIwF1rWLqfCfUV0SACC/eUvzJut0=;
 b=S4GFOf3MT65bJ6dkzkg9VSaFvR8BsjxQ6HFjKpOD1dze6hND0Yujv4smVpD7GSOoZvKZBN
 ZY7hmMVLp6kBdiw8wPBRhj3G1aRd3OhC/n/VfoyX/lNLyONNCgFJ34RiyLShR5N//CP1gl
 yiVvo/y76o25uY1cx7aGoVNSO5Tic8U=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-a_xy857MNUqNAonQsiIMZQ-1; Fri, 27 Jun 2025 07:52:10 -0400
X-MC-Unique: a_xy857MNUqNAonQsiIMZQ-1
X-Mimecast-MFC-AGG-ID: a_xy857MNUqNAonQsiIMZQ_1751025129
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45311704d1fso13300275e9.1
 for <qemu-devel@nongnu.org>; Fri, 27 Jun 2025 04:52:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751025129; x=1751629929;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YlWygZYUVVARXUXJIwF1rWLqfCfUV0SACC/eUvzJut0=;
 b=IVJWk64ZR87HBriDtJoOZw25e1fUQaKmpNctVczYFN6A2boaXhkQst8E/txfE4V5Gg
 nrwDJ7MtmVtIJhk5KwBH1yPJ+B2jGqcHci8M/NMGugE2RsKz3kHyr5PRiGjs5vYqhxlY
 WUxMdXtBqWokcRFBgN9/uL6D+e9+BDgBveAs6sW6NvBpYzIcP8Zo6AvkaYaHSjXerXcG
 PRC6xc3kmJWSvJqZqeeSx29+o5e5EJAT+KvC1AjoJ0HQ5I1ti4+lrLCTZZpLqd0kBxdt
 d8c74VwxrsMR3RQsQ+3+ulAqlQ4fRXkHCWRPm+mxPGOnBoLPcXpt7eI6VFZAAhS1TPgK
 l89Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXP1BrSdseO4v3H0czG0siB2bsvykL7FpaaCExfeXPYK53bqk+cyGHRPPH1r0pjUbl2ZCIg0ei4zoPV@nongnu.org
X-Gm-Message-State: AOJu0YzNuLY2jLHZJKyy/kP4T2ctv9KZzzbIrKWjorazwAlhlULcSik0
 RuCBXVo+u0GTSpJf9FdevMN7FS4oQDD7SS/WUNqDTb6tYqnMztjBINQH7BkD8L+2P64juJPQj8G
 2MgjW7g541dOhsIeawpAlGZVg1/Engl8UHmX8yKLdCahayV14A58NTjR2
X-Gm-Gg: ASbGncuVe1LD46z7dFxxpOxNCvqJKJDyAsbE3vJ9d8kcP+I04bwBh/T+XyZgknVt785
 xB6Wa54577piCJePbMor/WIXkNdXfYGXnrbj9Cpc6mYw7D5kSM5tBRRMKCmA7Fpq5Hvug1QOjzO
 wF2TTiuo8LXEa8KmPzyQQJpnJEl9OMxQdTXpvUppkbtxXkJSF5rHwV1A4b1BD+jI+D4ZOR8860n
 eD3J2iraIRp+McIPUE8sUnkYU+wGdB16u46QK/wmNjNjUnzdQzgZjSQfB9Xm1wqqaTA1NUYnFPK
 m4TZZZWeNeV15GZxTXAnDijDhQbzHAd9JM63c4BODqQJw5qPDk8SIdPhmvkuMREKJDbtaw==
X-Received: by 2002:a05:600c:5307:b0:43d:4e9:27ff with SMTP id
 5b1f17b1804b1-4538fadee1fmr24724445e9.7.1751025128667; 
 Fri, 27 Jun 2025 04:52:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFv9ij/Ttis4dOrOmRi9rMpTYkEUJrDbCsHbdB7OctKQcYNpjAyE9JSI2pb+be3eKDVVcNnNg==
X-Received: by 2002:a05:600c:5307:b0:43d:4e9:27ff with SMTP id
 5b1f17b1804b1-4538fadee1fmr24724145e9.7.1751025128162; 
 Fri, 27 Jun 2025 04:52:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538233c4acsm76947895e9.1.2025.06.27.04.52.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Jun 2025 04:52:07 -0700 (PDT)
Message-ID: <ce1d4b22-d613-4143-9b50-bd3e8047bff8@redhat.com>
Date: Fri, 27 Jun 2025 13:52:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/11] hw/arm/smmu-common: Check SMMU has PCIe Root
 Complex association
Content-Language: en-US
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, imammedo@redhat.com,
 nathanc@nvidia.com, mochs@nvidia.com, smostafa@google.com,
 gustavo.romero@linaro.org, linuxarm@huawei.com, wangzhou1@hisilicon.com,
 jiangkunkun@huawei.com, jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
References: <20250623094230.76084-1-shameerali.kolothum.thodi@huawei.com>
 <20250623094230.76084-2-shameerali.kolothum.thodi@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250623094230.76084-2-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hi Shameer,

On 6/23/25 11:42 AM, Shameer Kolothum wrote:
> We only allow default PCIe Root Complex(pcie.0) or pxb-pcie based extra
> root complexes to be associated with SMMU.
>
> Although this change does not affect functionality at present, it is
> required when we add support for user-creatable SMMUv3 devices in
> future patches.
>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  hw/arm/smmu-common.c                | 29 ++++++++++++++++++++++++++---
>  hw/pci-bridge/pci_expander_bridge.c |  1 -
>  include/hw/pci/pci_bridge.h         |  1 +
>  3 files changed, 27 insertions(+), 4 deletions(-)
>
> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index f39b99e526..b15e7fd0e4 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -20,6 +20,7 @@
>  #include "trace.h"
>  #include "exec/target_page.h"
>  #include "hw/core/cpu.h"
> +#include "hw/pci/pci_bridge.h"
>  #include "hw/qdev-properties.h"
>  #include "qapi/error.h"
>  #include "qemu/jhash.h"
> @@ -925,6 +926,7 @@ static void smmu_base_realize(DeviceState *dev, Error **errp)
>  {
>      SMMUState *s = ARM_SMMU(dev);
>      SMMUBaseClass *sbc = ARM_SMMU_GET_CLASS(dev);
> +    PCIBus *pci_bus = s->primary_bus;
>      Error *local_err = NULL;
>  
>      sbc->parent_realize(dev, &local_err);
> @@ -937,11 +939,32 @@ static void smmu_base_realize(DeviceState *dev, Error **errp)
>                                       g_free, g_free);
>      s->smmu_pcibus_by_busptr = g_hash_table_new(NULL, NULL);
>  
> -    if (s->primary_bus) {
> -        pci_setup_iommu(s->primary_bus, &smmu_ops, s);
> -    } else {
> +    if (!pci_bus) {
>          error_setg(errp, "SMMU is not attached to any PCI bus!");
> +        return;
> +    }
> +
> +    /*
> +     * We only allow default PCIe Root Complex(pcie.0) or pxb-pcie based extra
> +     * root complexes to be associated with SMMU.
> +     */
> +    if (pci_bus_is_express(pci_bus) && pci_bus_is_root(pci_bus) &&
> +        object_dynamic_cast(OBJECT(pci_bus)->parent, TYPE_PCI_HOST_BRIDGE)) {
> +        /*
> +         * For pxb-pcie, parent_dev will be set. Make sure it is
> +         * pxb-pcie indeed.
> +         */
> +        if (pci_bus->parent_dev) {
> +            if (!object_dynamic_cast(OBJECT(pci_bus), TYPE_PXB_PCIE_BUS)) {
> +                goto out_err;
> +            }
I still wonder whether the above check was mandated as it works for what
it is meant:

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> +        }
> +        pci_setup_iommu(pci_bus, &smmu_ops, s);
> +        return;
>      }
> +out_err:
> +    error_setg(errp, "SMMU should be attached to a default PCIe root complex"
> +               "(pcie.0) or a pxb-pcie based root complex");
>  }
>  
>  /*
> diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
> index 3a29dfefc2..1bcceddbc4 100644
> --- a/hw/pci-bridge/pci_expander_bridge.c
> +++ b/hw/pci-bridge/pci_expander_bridge.c
> @@ -34,7 +34,6 @@ typedef struct PXBBus PXBBus;
>  DECLARE_INSTANCE_CHECKER(PXBBus, PXB_BUS,
>                           TYPE_PXB_BUS)
>  
> -#define TYPE_PXB_PCIE_BUS "pxb-pcie-bus"
>  DECLARE_INSTANCE_CHECKER(PXBBus, PXB_PCIE_BUS,
>                           TYPE_PXB_PCIE_BUS)
>  
> diff --git a/include/hw/pci/pci_bridge.h b/include/hw/pci/pci_bridge.h
> index b0f5204d80..de0eba55b7 100644
> --- a/include/hw/pci/pci_bridge.h
> +++ b/include/hw/pci/pci_bridge.h
> @@ -104,6 +104,7 @@ typedef struct PXBPCIEDev {
>      PXBDev parent_obj;
>  } PXBPCIEDev;
>  
> +#define TYPE_PXB_PCIE_BUS "pxb-pcie-bus"
>  #define TYPE_PXB_CXL_BUS "pxb-cxl-bus"
>  #define TYPE_PXB_DEV "pxb"
>  OBJECT_DECLARE_SIMPLE_TYPE(PXBDev, PXB_DEV)


