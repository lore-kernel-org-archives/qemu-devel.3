Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A097DC25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 12:57:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE7FL-000077-VF; Mon, 03 Jun 2024 08:57:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sE7FK-0008TR-T6
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 08:57:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sE7FI-0002EO-Hr
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 08:57:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717419423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uJgF4prksJTHhKe1OAA3+KwVurXP/KwVHaakDnrdJ6U=;
 b=eAxuZ4J9/ozVJ4pexxbrLWbZh8JK+FDqoj0WNCsFjjTMLvtSKPGBiruKLP0jU+1B5BnSF1
 Ipf4wdZBKJlhs9+dbX2CzHZBNpeClA3YRBw8ZPY28IyWagz18Aj4g7E4JSHoFYmzGv13wg
 1mTPTwq4sUqiHw180NgRQY7iAhW6QFQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-UX9XwdYAMxG52bLecgjjXA-1; Mon, 03 Jun 2024 08:57:02 -0400
X-MC-Unique: UX9XwdYAMxG52bLecgjjXA-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-794ab0a4c4cso551935485a.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 05:57:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717419422; x=1718024222;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uJgF4prksJTHhKe1OAA3+KwVurXP/KwVHaakDnrdJ6U=;
 b=MOQJDY7He8oJ0eDtJnhg0FYWXISTmejoSO6uW72JhjAWOGEBBgsOKy5aJeevNkhfdX
 I9rm3IGr4mqTgh//zGpv2GQ5Jek6Br5CqwxxIIYIMS9+dElY9i1s6O/EIpkBeHG2roUN
 2xgoE6c7hyzfknpFdr8gUhoRoqOxTqawAwTqXz7CWID6CPluSNu9HGlVmFVZWrUbvSP5
 2xn1BKYlQ9fgzHxEygUtB2Tq20kUMWxax406RlxY0H9HocY/cofPf5zIH8nbceJHz9RX
 Tcjxw4y6Lsw/cBnHyyYybGAgsJFAG1csZ0/Aid/KiHHAViCIkrUpZfdRwxKNr45sSLxf
 ROXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+a+L0YF+Z5hYviB6l/1fn1pzd9MTlgqzB09VEooTVl/ILjTLj9R40b4fy1j3dwcnBSySIiCW+K6EP2ihDjQRAHeVafVA=
X-Gm-Message-State: AOJu0YzD+YZvnH8qcS8DrAJFodJ2inawE/LUP751fuqyJvUMROwC81LW
 xoz5tNL29pqc9uKJWO808Xx7+qC8G7rcVU0MwTZmsjsySL2QofJ45wCwc9TRf9ATdboPiuxwexF
 IL0J2LW8L0TutLzrwlTHhA/Nj//MpVLCJxq3dTWYXFUPm3C4VnE1W
X-Received: by 2002:a05:620a:8101:b0:793:1c64:131e with SMTP id
 af79cd13be357-794f5ebe42emr844159785a.50.1717419421573; 
 Mon, 03 Jun 2024 05:57:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEo6smrqfm2O1hxsJzqqV0QdHsasdfd4VhzUqCMcCO3cf9iuUfQoeKBvZfdNhEnWitdc/hhRA==
X-Received: by 2002:a05:620a:8101:b0:793:1c64:131e with SMTP id
 af79cd13be357-794f5ebe42emr844157285a.50.1717419421135; 
 Mon, 03 Jun 2024 05:57:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-794f317073fsm281044385a.112.2024.06.03.05.56.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 05:57:00 -0700 (PDT)
Message-ID: <f07bd445-f1f8-4395-baf4-ddcc847d428d@redhat.com>
Date: Mon, 3 Jun 2024 14:56:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 18/19] intel_iommu: Implement
 [set|unset]_iommu_device() callbacks
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20240603061023.269738-1-zhenzhong.duan@intel.com>
 <20240603061023.269738-19-zhenzhong.duan@intel.com>
 <6cfdde68-a138-4ac3-ab3c-29f6a94a1045@eviden.com>
 <SJ0PR11MB6744E89A1A959BE312ECE5B592FF2@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <SJ0PR11MB6744E89A1A959BE312ECE5B592FF2@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 6/3/24 13:02, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
>> Subject: Re: [PATCH v6 18/19] intel_iommu: Implement
>> [set|unset]_iommu_device() callbacks
>>
>>
>> On 03/06/2024 08:10, Zhenzhong Duan wrote:
>>> Caution: External email. Do not open attachments or click links, unless this
>> email comes from a known sender and you know the content is safe.
>>>
>>>
>>> From: Yi Liu <yi.l.liu@intel.com>
>>>
>>> Implement [set|unset]_iommu_device() callbacks in Intel vIOMMU.
>>> In set call, a new structure VTDHostIOMMUDevice which holds
>>> a reference to HostIOMMUDevice is stored in hash table
>>> indexed by PCI BDF.
>>>
>>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>>> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> ---
>>>    hw/i386/intel_iommu_internal.h |  9 ++++
>>>    include/hw/i386/intel_iommu.h  |  2 +
>>>    hw/i386/intel_iommu.c          | 76
>> ++++++++++++++++++++++++++++++++++
>>>    3 files changed, 87 insertions(+)
>>>
>>> diff --git a/hw/i386/intel_iommu_internal.h
>> b/hw/i386/intel_iommu_internal.h
>>> index f8cf99bddf..b800d62ca0 100644
>>> --- a/hw/i386/intel_iommu_internal.h
>>> +++ b/hw/i386/intel_iommu_internal.h
>>> @@ -28,6 +28,7 @@
>>>    #ifndef HW_I386_INTEL_IOMMU_INTERNAL_H
>>>    #define HW_I386_INTEL_IOMMU_INTERNAL_H
>>>    #include "hw/i386/intel_iommu.h"
>>> +#include "sysemu/host_iommu_device.h"
>>>
>>>    /*
>>>     * Intel IOMMU register specification
>>> @@ -537,4 +538,12 @@ typedef struct VTDRootEntry VTDRootEntry;
>>>    #define VTD_SL_IGN_COM              0xbff0000000000000ULL
>>>    #define VTD_SL_TM                   (1ULL << 62)
>>>
>>> +
>>> +typedef struct VTDHostIOMMUDevice {
>>> +    IntelIOMMUState *iommu_state;
>>> +    PCIBus *bus;
>>> +    uint8_t devfn;
>>> +    HostIOMMUDevice *dev;
>>> +    QLIST_ENTRY(VTDHostIOMMUDevice) next;
>>> +} VTDHostIOMMUDevice;
>>>    #endif
>>> diff --git a/include/hw/i386/intel_iommu.h
>> b/include/hw/i386/intel_iommu.h
>>> index 7d694b0813..2bbde41e45 100644
>>> --- a/include/hw/i386/intel_iommu.h
>>> +++ b/include/hw/i386/intel_iommu.h
>>> @@ -293,6 +293,8 @@ struct IntelIOMMUState {
>>>        /* list of registered notifiers */
>>>        QLIST_HEAD(, VTDAddressSpace) vtd_as_with_notifiers;
>>>
>>> +    GHashTable *vtd_host_iommu_dev;             /* VTDHostIOMMUDevice
>> */
>>> +
>>>        /* interrupt remapping */
>>>        bool intr_enabled;              /* Whether guest enabled IR */
>>>        dma_addr_t intr_root;           /* Interrupt remapping table pointer */
>>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>>> index 519063c8f8..747c988bc4 100644
>>> --- a/hw/i386/intel_iommu.c
>>> +++ b/hw/i386/intel_iommu.c
>>> @@ -237,6 +237,13 @@ static gboolean vtd_as_equal(gconstpointer v1,
>> gconstpointer v2)
>>>               (key1->pasid == key2->pasid);
>>>    }
>>>
>>> +static gboolean vtd_as_idev_equal(gconstpointer v1, gconstpointer v2)
>>> +{
>>> +    const struct vtd_as_key *key1 = v1;
>>> +    const struct vtd_as_key *key2 = v2;
>>> +
>>> +    return (key1->bus == key2->bus) && (key1->devfn == key2->devfn);
>>> +}
>>>    /*
>>>     * Note that we use pointer to PCIBus as the key, so hashing/shifting
>>>     * based on the pointer value is intended. Note that we deal with
>>> @@ -3812,6 +3819,70 @@ VTDAddressSpace
>> *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
>>>        return vtd_dev_as;
>>>    }
>>>
>>> +static bool vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int
>> devfn,
>>> +                                     HostIOMMUDevice *hiod, Error **errp)
>>> +{
>>> +    IntelIOMMUState *s = opaque;
>>> +    VTDHostIOMMUDevice *vtd_hdev;
>>> +    struct vtd_as_key key = {
>>> +        .bus = bus,
>>> +        .devfn = devfn,
>>> +    };
>>> +    struct vtd_as_key *new_key;
>>> +
>>> +    assert(hiod);
>>> +
>>> +    vtd_iommu_lock(s);
>>> +
>>> +    vtd_hdev = g_hash_table_lookup(s->vtd_host_iommu_dev, &key);
>>> +
>>> +    if (vtd_hdev) {
>>> +        error_setg(errp, "IOMMUFD device already exist");
>>> +        vtd_iommu_unlock(s);
>>> +        return false;
>>> +    }
>>> +
>>> +    vtd_hdev = g_malloc0(sizeof(VTDHostIOMMUDevice));
>>> +    vtd_hdev->bus = bus;
>>> +    vtd_hdev->devfn = (uint8_t)devfn;
>>> +    vtd_hdev->iommu_state = s;
>>> +    vtd_hdev->dev = hiod;
>>> +
>>> +    new_key = g_malloc(sizeof(*new_key));
>>> +    new_key->bus = bus;
>>> +    new_key->devfn = devfn;
>>> +
>>> +    object_ref(hiod);
>>> +    g_hash_table_insert(s->vtd_host_iommu_dev, new_key, vtd_hdev);
>>> +
>>> +    vtd_iommu_unlock(s);
>>> +
>>> +    return true;
>>> +}
>>> +
>>> +static void vtd_dev_unset_iommu_device(PCIBus *bus, void *opaque, int
>> devfn)
>>> +{
>>> +    IntelIOMMUState *s = opaque;
>>> +    VTDHostIOMMUDevice *vtd_hdev;
>>> +    struct vtd_as_key key = {
>>> +        .bus = bus,
>>> +        .devfn = devfn,
>>> +    };
>>> +
>>> +    vtd_iommu_lock(s);
>>> +
>>> +    vtd_hdev = g_hash_table_lookup(s->vtd_host_iommu_dev, &key);
>>> +    if (!vtd_hdev) {
>>> +        vtd_iommu_unlock(s);
>>> +        return;
>>> +    }
>>> +
>>> +    g_hash_table_remove(s->vtd_host_iommu_dev, &key);
>>> +    object_unref(vtd_hdev->dev);
>> Not sure but isn't that a potential use after free?
> 
> Good catch! Will fix. Should be:
> 
> object_unref(vtd_hdev->dev);
> g_hash_table_remove(s->vtd_host_iommu_dev, &key);

you could also implement a custom destroy hash function.


Thanks,

C.


> 
> Thanks
> Zhenzhong
> 
>>> +
>>> +    vtd_iommu_unlock(s);
>>> +}
>>> +
>>>    /* Unmap the whole range in the notifier's scope. */
>>>    static void vtd_address_space_unmap(VTDAddressSpace *as,
>> IOMMUNotifier *n)
>>>    {
>>> @@ -4116,6 +4187,8 @@ static AddressSpace
>> *vtd_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
>>>
>>>    static PCIIOMMUOps vtd_iommu_ops = {
>>>        .get_address_space = vtd_host_dma_iommu,
>>> +    .set_iommu_device = vtd_dev_set_iommu_device,
>>> +    .unset_iommu_device = vtd_dev_unset_iommu_device,
>>>    };
>>>
>>>    static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
>>> @@ -4235,6 +4308,9 @@ static void vtd_realize(DeviceState *dev, Error
>> **errp)
>>>                                         g_free, g_free);
>>>        s->vtd_address_spaces = g_hash_table_new_full(vtd_as_hash,
>> vtd_as_equal,
>>>                                          g_free, g_free);
>>> +    s->vtd_host_iommu_dev = g_hash_table_new_full(vtd_as_hash,
>>> +                                                  vtd_as_idev_equal,
>>> +                                                  g_free, g_free);
>>>        vtd_init(s);
>>>        pci_setup_iommu(bus, &vtd_iommu_ops, dev);
>>>        /* Pseudo address space under root PCI bus. */
>>> --
>>> 2.34.1
>>>


