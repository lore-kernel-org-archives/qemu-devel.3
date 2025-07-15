Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A294C83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 17:07:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubj6j-00054f-S7; Tue, 15 Jul 2025 13:06:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1ubihc-0002dx-Ni
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 12:40:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1ubiha-0005Sa-D4
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 12:40:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752597618;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=npASAj0rawN/MuiodbDWzXPpzb2MCx626I/MYSwc4iA=;
 b=H7gO/0xdRvT91C00VQNxXJ0i8IcTpGTkCdl1IQKkrvf6opeSxtIqy6Jy/Yw0jQo2CSvUIb
 og41x6vriKhLAu7ilMZZ3KqYpdpBkJ9QXVx/J9pOjo+Bq/Q5CxwP7jM3T6J3PjRMCnOsy2
 ZYgz4D+Cxjz2TFLv5TAet15Xq722AaY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-Yzf32sSnOd2WE7s40m7Tbg-1; Tue, 15 Jul 2025 12:40:17 -0400
X-MC-Unique: Yzf32sSnOd2WE7s40m7Tbg-1
X-Mimecast-MFC-AGG-ID: Yzf32sSnOd2WE7s40m7Tbg_1752597616
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3b5fe97af5fso1121404f8f.2
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 09:40:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752597614; x=1753202414;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=npASAj0rawN/MuiodbDWzXPpzb2MCx626I/MYSwc4iA=;
 b=UchEAFOHyw3mgq4OSTv07Rvbwru4B4poLCmmAZS2TFsPHcV/9C/mnc8KNIuPrudR1l
 04oEiZ231GbKeOW7rMLQ2bjypL/N7eXty4WFBfSEWkKXSgH6pq/Q55oM4Ndcf+Ey23yy
 bKisyi45sxAf99rDAfjaPL2jx4em9VTnRPJmjMcVwTvvnpCkWdL92DWgnR46Oc2cr5Ur
 XnQbhdhD1qz3y6XOzRg2ihc4yKSr5wWqKttZuBaKFCPWTFNRMPBlVgRc/cHJ/PXatBa0
 r3M2RKgBFDZ4jxzyjInWvJhosSvy5TsGFR9iCLmpUNj3gCtC8cZyEHDWjh5frP5SgaMi
 MeaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyT468szDjMn28557LTYEZO/vXVXtewJlLCMixj+jmXY4UhEr4FvLbj9M8GWgeMyl60VmNf5LeTBmx@nongnu.org
X-Gm-Message-State: AOJu0YzJG4HeNNkz0OWVOivN3N1SuB7i1l283bpzreSCKkOckRWWBQG8
 t9XyEk0A5htFOd/FcbjaELFEgJcRFxTZZ/yGn11beG8GhwcBLdrzy+hr6yzUmlf6ZG/EmhqvPwe
 QxftEm/eu7/XFaq08yK7WMMgaLq5o+isarRYaHk4ISaeYFDBYEwvKiwrr
X-Gm-Gg: ASbGncsWgoErlVVoeNUGR7mQGtbI2/MJHWg21u16O1sx5eP1YIen/mkIWxYGCns6+ia
 3v0TRMLm370L2Q73jDgdwzRsSqKFVGnRVhCP7vACrBNmmFNvi5q4GLRa6T0QRmk2sw+rfk5310i
 QT6kgE5sroNqsu2Sk8Lsw/7ikgAT/IPEhRZg0P9z1cFValaniat2j47XHPRcIPw5Cw5yO24cISQ
 Nv6jBW5UFLbFsA5r97lX0U0GCgykV3mxrdc0VINdoNbSYKNh5p0RhPtPFUMq/nuGWYo+1mgKPBV
 Duq9n/HfRakvhGqiIpah0cTbA6ONbVn0y9EkutcoQE00vHRoPhVuE6ncpDAsQv+vsZ4z+CYlEIq
 iILqDB1n6igk=
X-Received: by 2002:a05:600c:3592:b0:456:173c:8a53 with SMTP id
 5b1f17b1804b1-456173c8b27mr104742415e9.2.1752597614158; 
 Tue, 15 Jul 2025 09:40:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+NBFXkJkUFkQV+B8Fqpy0ajL6f9mSFsFa5z5wLg1YB4IGah+Zx0++w+g4zg8LmMM1gkvbmA==
X-Received: by 2002:a05:600c:3592:b0:456:173c:8a53 with SMTP id
 5b1f17b1804b1-456173c8b27mr104741935e9.2.1752597613716; 
 Tue, 15 Jul 2025 09:40:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454dd43915dsm167672765e9.7.2025.07.15.09.40.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jul 2025 09:40:12 -0700 (PDT)
Message-ID: <cfa02f0f-d20e-4088-b377-3f233d3ec3f7@redhat.com>
Date: Tue, 15 Jul 2025 18:40:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/20] hw/pci: Export pci_device_get_iommu_bus_devfn()
 and return bool
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com
References: <20250708110601.633308-1-zhenzhong.duan@intel.com>
 <20250708110601.633308-6-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250708110601.633308-6-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 7/8/25 1:05 PM, Zhenzhong Duan wrote:
> Returns true if PCI device is aliased or false otherwise. This will be
> used in following patch to determine if a PCI device is under a PCI
> bridge.
>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  hw/pci/pci.c         | 12 ++++++++----
>  include/hw/pci/pci.h |  2 ++
>  2 files changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index df1fb615a8..87f7c942b3 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -2857,20 +2857,21 @@ static void pci_device_class_base_init(ObjectClass *klass, const void *data)
>   * For call sites which don't need aliased BDF, passing NULL to
>   * aliased_[bus|devfn] is allowed.
>   *
> + * Returns true if PCI device is aliased or false otherwise.
s/PCI device/PCI device RID

Besides
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
> + *
>   * @piommu_bus: return root #PCIBus backed by an IOMMU for the PCI device.
>   *
>   * @aliased_bus: return aliased #PCIBus of the PCI device, optional.
>   *
>   * @aliased_devfn: return aliased devfn of the PCI device, optional.
>   */
> -static void pci_device_get_iommu_bus_devfn(PCIDevice *dev,
> -                                           PCIBus **piommu_bus,
> -                                           PCIBus **aliased_bus,
> -                                           int *aliased_devfn)
> +bool pci_device_get_iommu_bus_devfn(PCIDevice *dev, PCIBus **piommu_bus,
> +                                    PCIBus **aliased_bus, int *aliased_devfn)
>  {
>      PCIBus *bus = pci_get_bus(dev);
>      PCIBus *iommu_bus = bus;
>      int devfn = dev->devfn;
> +    bool aliased = false;
>  
>      while (iommu_bus && !iommu_bus->iommu_ops && iommu_bus->parent_dev) {
>          PCIBus *parent_bus = pci_get_bus(iommu_bus->parent_dev);
> @@ -2907,6 +2908,7 @@ static void pci_device_get_iommu_bus_devfn(PCIDevice *dev,
>                  devfn = parent->devfn;
>                  bus = parent_bus;
>              }
> +            aliased = true;
>          }
>  
>          iommu_bus = parent_bus;
> @@ -2928,6 +2930,8 @@ static void pci_device_get_iommu_bus_devfn(PCIDevice *dev,
>      if (aliased_devfn) {
>          *aliased_devfn = devfn;
>      }
> +
> +    return aliased;
>  }
>  
>  AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index a11ab14bdc..8795808155 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -641,6 +641,8 @@ typedef struct PCIIOMMUOps {
>                              bool is_write);
>  } PCIIOMMUOps;
>  
> +bool pci_device_get_iommu_bus_devfn(PCIDevice *dev, PCIBus **piommu_bus,
> +                                    PCIBus **aliased_bus, int *aliased_devfn);
>  AddressSpace *pci_device_iommu_address_space(PCIDevice *dev);
>  bool pci_device_set_iommu_device(PCIDevice *dev, HostIOMMUDevice *hiod,
>                                   Error **errp);


