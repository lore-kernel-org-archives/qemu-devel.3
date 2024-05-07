Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E3C4C25B4F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 12:27:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4Jtv-0004Id-Q0; Tue, 07 May 2024 08:26:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s4Jtk-0004IL-O9
 for qemu-devel@nongnu.org; Tue, 07 May 2024 08:26:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s4Jth-0003rY-DR
 for qemu-devel@nongnu.org; Tue, 07 May 2024 08:26:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715084776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GcyMXeYO6Y752j6WMqbWC4MiiIKx5csJMTuQjSAteg4=;
 b=SOG7+/efXHPXuc1nkYhnAE3zKmIMArx7o3HuIyObKiYYkDuS8/qpjhDMCiBe5PUEX5bLZi
 QMjU8lSATkUAdpPK9WliZ6gIdtceO44nHkJr6DDoXJGKTYp0sS3rnyYvYQsm2BJ9CSjDus
 +TD73sNAktb13VHkTb6T3l5Zqeh30Ao=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-ih0N1ccAMFiHBK8NxWTS1Q-1; Tue, 07 May 2024 08:26:15 -0400
X-MC-Unique: ih0N1ccAMFiHBK8NxWTS1Q-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-34eb54c888cso3274351f8f.3
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 05:26:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715084774; x=1715689574;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GcyMXeYO6Y752j6WMqbWC4MiiIKx5csJMTuQjSAteg4=;
 b=EWpDotPz1yEXvtKpPwK8dEvMD0HddccdkqmzaS/1ryIDNXXkLwH55WwTZm60K8fMEh
 z2Iu4x1/Iv83+yg6lB6Mqanr06t4Jo5NX5Wl0y9LYrqn22rbh7AKYTjarJ7WC8ihUQdF
 Is/Y0Gd4F2OF4j7X20b+tuXNTq/XKvozxtzs5Xrw5K2lhRmiAWUqmF5kbNn+EsWtxGbb
 nYLbTOnEUkzxzEjWczBt4gDLtc7vR5bqFtjl3yEqRJZOILRl1r5vCjoRUYcgrjxITWkp
 xHQu4XnQzl/S69cGEQ1xFf26WZxql7fZ97U9oQ/YmZSDElRWxs8s3FDNp6Qr5QkfIkoa
 ASyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4G6JD9NCbwzvidI4Z3Y6tTFObSKf7yqZlOkeP9KGXaZocYdjJXkzMk3e4N2efGGz/dYsXyhlTtn668S9zwsO+3vWu9ro=
X-Gm-Message-State: AOJu0Yz2GHFt8JLBUPBYZucmCtpJlmI3c66zZaSqTL6YG2gvH4lu+59U
 kSkXjlVbH1p7C78joRxsCvN26Oq2wGaPX+ZbEkScTBuTlzxxydl+20pLlhy00Gt198dj9iqCQCP
 ChO8K32nW0Zl1iu53RVJK+CAXhSPfupWSJT2JNbZmojnpy58o2yJc
X-Received: by 2002:adf:e4c3:0:b0:34d:8fac:9540 with SMTP id
 v3-20020adfe4c3000000b0034d8fac9540mr11234782wrm.59.1715084773502; 
 Tue, 07 May 2024 05:26:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjgqOjJibPm/9rNV9htR2+HkaOQa9F+6GBAzYbOv68KjAPiGylM4SnfgkimvUbCrlKx1ET0Q==
X-Received: by 2002:adf:e4c3:0:b0:34d:8fac:9540 with SMTP id
 v3-20020adfe4c3000000b0034d8fac9540mr11234762wrm.59.1715084773113; 
 Tue, 07 May 2024 05:26:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 f14-20020a0560001b0e00b003462fec9f5asm12839310wrz.62.2024.05.07.05.26.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 May 2024 05:26:12 -0700 (PDT)
Message-ID: <f90dff15-bc08-46bb-a583-48622062249f@redhat.com>
Date: Tue, 7 May 2024 14:26:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/19] hw/pci: Introduce
 pci_device_[set|unset]_iommu_device()
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20240429065046.3688701-1-zhenzhong.duan@intel.com>
 <20240429065046.3688701-16-zhenzhong.duan@intel.com>
 <adb10cf9-faff-41f1-a6e4-e7c169f16c72@redhat.com>
 <SJ0PR11MB6744EEA78AD1ADA4CC71DD8092E42@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <SJ0PR11MB6744EEA78AD1ADA4CC71DD8092E42@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
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

On 5/7/24 09:48, Duan, Zhenzhong wrote:
> Hi Cédric,
> 
>> -----Original Message-----
>> From: Cédric Le Goater <clg@redhat.com>
>> Subject: Re: [PATCH v3 15/19] hw/pci: Introduce
>> pci_device_[set|unset]_iommu_device()
>>
>> Hello Zhenzhong,
>>
>> On 4/29/24 08:50, Zhenzhong Duan wrote:
>>> From: Yi Liu <yi.l.liu@intel.com>
>>>
>>> pci_device_[set|unset]_iommu_device() call
>> pci_device_get_iommu_bus_devfn()
>>> to get iommu_bus->iommu_ops and call [set|unset]_iommu_device
>> callback to
>>> set/unset HostIOMMUDevice for a given PCI device.
>>>
>>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>>> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
>>> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> ---
>>>    include/hw/pci/pci.h | 38
>> +++++++++++++++++++++++++++++++++++++-
>>>    hw/pci/pci.c         | 27 +++++++++++++++++++++++++++
>>>    2 files changed, 64 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
>>> index eaa3fc99d8..849e391813 100644
>>> --- a/include/hw/pci/pci.h
>>> +++ b/include/hw/pci/pci.h
>>> @@ -3,6 +3,7 @@
>>>
>>>    #include "exec/memory.h"
>>>    #include "sysemu/dma.h"
>>> +#include "sysemu/host_iommu_device.h"
>>
>> This include directive pulls a Linux header file <linux/iommufd.h>
>> which doesn't exist on all platforms, such as windows and it breaks
>> compile. So,
>>
>>>
>>>    /* PCI includes legacy ISA access.  */
>>>    #include "hw/isa/isa.h"
>>> @@ -383,10 +384,45 @@ typedef struct PCIIOMMUOps {
>>>         *
>>>         * @devfn: device and function number
>>>         */
>>> -   AddressSpace * (*get_address_space)(PCIBus *bus, void *opaque, int
>> devfn);
>>> +    AddressSpace * (*get_address_space)(PCIBus *bus, void *opaque, int
>> devfn);
>>> +    /**
>>> +     * @set_iommu_device: attach a HostIOMMUDevice to a vIOMMU
>>> +     *
>>> +     * Optional callback, if not implemented in vIOMMU, then vIOMMU
>> can't
>>> +     * retrieve host information from the associated HostIOMMUDevice.
>>> +     *
>>> +     * @bus: the #PCIBus of the PCI device.
>>> +     *
>>> +     * @opaque: the data passed to pci_setup_iommu().
>>> +     *
>>> +     * @devfn: device and function number of the PCI device.
>>> +     *
>>> +     * @dev: the data structure representing host IOMMU device.
>>> +     *
>>> +     * @errp: pass an Error out only when return false
>>> +     *
>>> +     * Returns: 0 if HostIOMMUDevice is attached, or else <0 with errp set.
>>> +     */
>>> +    int (*set_iommu_device)(PCIBus *bus, void *opaque, int devfn,
>>> +                            HostIOMMUDevice *dev, Error **errp);
>>> +    /**
>>> +     * @unset_iommu_device: detach a HostIOMMUDevice from a
>> vIOMMU
>>> +     *
>>> +     * Optional callback.
>>> +     *
>>> +     * @bus: the #PCIBus of the PCI device.
>>> +     *
>>> +     * @opaque: the data passed to pci_setup_iommu().
>>> +     *
>>> +     * @devfn: device and function number of the PCI device.
>>> +     */
>>> +    void (*unset_iommu_device)(PCIBus *bus, void *opaque, int devfn);
>>>    } PCIIOMMUOps;
>>>
>>>    AddressSpace *pci_device_iommu_address_space(PCIDevice *dev);
>>> +int pci_device_set_iommu_device(PCIDevice *dev, HostIOMMUDevice
>> *hiod,
>>> +                                Error **errp);
>>
>> please include a forward declaration for HostIOMMUDevice instead.
> 
> Got it, will do.
> Maybe using iommu_hw_info_type in include/sysemu/host_iommu_device.h
> isn't a good idea from start.

It is not indeed since some included files are used on the Windows build.

Thanks,

C.



> 
> Thanks
> Zhenzhong
> 


