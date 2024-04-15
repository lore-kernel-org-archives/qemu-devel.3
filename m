Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2234C00A94
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2024 15:31:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwOIe-0004i4-8d; Mon, 15 Apr 2024 11:31:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rwOIY-0004hH-EB
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 11:31:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rwOIW-0000K2-MK
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 11:31:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713195067;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=auKFO1AZqC8KLYq+lreUp1bKXpqDjWwGiKZDct91Rc8=;
 b=jTB1GhnRV9Bwh/PnuDgEYmeCzloKpBKgzVnCq8DZCPOMiVd3tjhiQwIAwLGyw+bf7P4MBX
 SISwbICLHwC1slXzihKgnZCrdR9L+rUCoBOTECeqDn4Bws6acgCwhHwm4f86y8WJakLyWg
 dW8JfgSTpV7CZLtdaxb83zwBeLqguEA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-XUpZIqX3Mt-mOfAmydl--g-1; Mon, 15 Apr 2024 11:31:04 -0400
X-MC-Unique: XUpZIqX3Mt-mOfAmydl--g-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a4488afb812so202504666b.3
 for <qemu-devel@nongnu.org>; Mon, 15 Apr 2024 08:31:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713195063; x=1713799863;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=auKFO1AZqC8KLYq+lreUp1bKXpqDjWwGiKZDct91Rc8=;
 b=oRkKALf7D2a78vC6p+ATXAc9iSvECj2/IYt6aau9A/bWMJhTbCp4oANYJ9R2pzYE0e
 1fvIt5mczRi3qIM2wq1jjs06ZtR4Q1Vm2SakCeaGWZALVGOpRbzMXW57eUFAlb03mmfh
 YpMfJR+u5EsuzyNpXmZSMf5QHPcpdp85zllTK564tJXdROu12BnAXZ5hXYDDXljhGcQy
 S4Emur1gEDVwZ3AR51WrHEZ+N6sqd4q3YRBGD1HneRXjh8Dvs+S4NHF5By757DE0lW2H
 AiJGc4jWUBWDQ3KVUxfRUngAD1t8ffb9ut7yBj89cr34tlwEsGilPbsdyf017wW5iZQ1
 1j/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3CXgOjJXu2Escj8XrmJxbQ7EW6Pr6zVCNOAtTr1lqiFqol7wPCfTk8On255ZwmYkZgv30XEk4z5OK5FzM0EUdXexL4KI=
X-Gm-Message-State: AOJu0YzSbBazXKwDWgWxou6qIcOd1IMVykx7xjNMa+HyZ9F8qkj6jbX8
 zuc/eYlCDBkCFUZVslUuEmRNv95lg0JbXOcpC1k5vRhSXwq7DvU8lwDiifXO3TtrVMGjPfgq40f
 c34IB0iPwVqmFhMZ75H5MnuUa/bZ1QrCTOTYpjl74KoUYs2OQ+/RY
X-Received: by 2002:a17:907:d2a:b0:a4d:fc83:70e1 with SMTP id
 gn42-20020a1709070d2a00b00a4dfc8370e1mr6536473ejc.56.1713195063368; 
 Mon, 15 Apr 2024 08:31:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyNo0AAtPiLBHNP6Fyah0vVBedm5wTs1fNmqX/WbGwaUAlg1Eoyf1MWvhHmhHIDcODgHXCew==
X-Received: by 2002:a17:907:d2a:b0:a4d:fc83:70e1 with SMTP id
 gn42-20020a1709070d2a00b00a4dfc8370e1mr6536446ejc.56.1713195062953; 
 Mon, 15 Apr 2024 08:31:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:d55d:ba01:adf2:d3ae?
 ([2a01:e0a:9e2:9000:d55d:ba01:adf2:d3ae])
 by smtp.gmail.com with ESMTPSA id
 mb24-20020a170906eb1800b00a525609ae30sm2770842ejb.169.2024.04.15.08.31.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Apr 2024 08:31:02 -0700 (PDT)
Message-ID: <251715ae-5378-4dfb-bc14-47ba2e62f83a@redhat.com>
Date: Mon, 15 Apr 2024 17:31:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] intel_iommu: Add a framework to do compatibility
 check with host IOMMU cap/ecap
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Yi Sun <yi.y.sun@linux.intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20240408084404.1111628-1-zhenzhong.duan@intel.com>
 <20240408084404.1111628-4-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240408084404.1111628-4-zhenzhong.duan@intel.com>
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

On 4/8/24 10:44, Zhenzhong Duan wrote:
> From: Yi Liu <yi.l.liu@intel.com>
> 
> If check fails, the host side device(either vfio or vdpa device) should not
> be passed to guest.
> 
> Implementation details for different backends will be in following patches.
> 
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/i386/intel_iommu.c | 35 +++++++++++++++++++++++++++++++++++
>   1 file changed, 35 insertions(+)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 4f84e2e801..a49b587c73 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -35,6 +35,7 @@
>   #include "sysemu/kvm.h"
>   #include "sysemu/dma.h"
>   #include "sysemu/sysemu.h"
> +#include "sysemu/iommufd.h"
>   #include "hw/i386/apic_internal.h"
>   #include "kvm/kvm_i386.h"
>   #include "migration/vmstate.h"
> @@ -3819,6 +3820,32 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
>       return vtd_dev_as;
>   }
>   
> +static int vtd_check_legacy_hdev(IntelIOMMUState *s,
> +                                 HostIOMMUDevice *hiod,
> +                                 Error **errp)
> +{
> +    return 0;
> +}
> +
> +static int vtd_check_iommufd_hdev(IntelIOMMUState *s,
> +                                  HostIOMMUDevice *hiod,
> +                                  Error **errp)
> +{
> +    return 0;
> +}
> +
> +static int vtd_check_hdev(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hdev,
> +                          Error **errp)
> +{
> +    HostIOMMUDevice *hiod = vtd_hdev->dev;
> +
> +    if (object_dynamic_cast(OBJECT(hiod), TYPE_HIOD_IOMMUFD)) {
> +        return vtd_check_iommufd_hdev(s, hiod, errp);
> +    }
> +
> +    return vtd_check_legacy_hdev(s, hiod, errp);
> +}


I think we should be using the .get_host_iommu_info() class handler
instead. Can we refactor the code slightly to avoid this check on
the type ?


Thanks,

C.




> +
>   static int vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
>                                       HostIOMMUDevice *hiod, Error **errp)
>   {
> @@ -3829,6 +3856,7 @@ static int vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
>           .devfn = devfn,
>       };
>       struct vtd_as_key *new_key;
> +    int ret;
>   
>       assert(hiod);
>   
> @@ -3848,6 +3876,13 @@ static int vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
>       vtd_hdev->iommu_state = s;
>       vtd_hdev->dev = hiod;
>   
> +    ret = vtd_check_hdev(s, vtd_hdev, errp);
> +    if (ret) {
> +        g_free(vtd_hdev);
> +        vtd_iommu_unlock(s);
> +        return ret;
> +    }
> +
>       new_key = g_malloc(sizeof(*new_key));
>       new_key->bus = bus;
>       new_key->devfn = devfn;


