Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E33BC27C52
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 08:17:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEPMK-0008VI-8c; Tue, 04 Jun 2024 04:17:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sEPMI-0008Uq-LT
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 04:17:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sEPMG-0004ni-Il
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 04:17:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717489047;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VAjOJSXzoksk3d6w9ZAxdP4lH4Nep6545WQmRiiNnms=;
 b=F1uhg07uKgnfJGBxY7HgsGyzqqZyRAaqiPbsOWhTDTKeJEXGQa0M0MaOOFwChCmZ6zzOgD
 FeQJKqXnBKD1uJWbQQwOya9S1j7dp/UhFfPWdnGcwWplwg+7mPnCXL/Au1nT9DYa6Pm4ya
 eYFOgn/bSUtQV08QcxwQgNl9MqIp/SQ=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-WeDtnHxoPIGXlSlIHBmO8Q-1; Tue, 04 Jun 2024 04:17:24 -0400
X-MC-Unique: WeDtnHxoPIGXlSlIHBmO8Q-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2eaa77740deso5791401fa.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 01:17:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717489043; x=1718093843;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VAjOJSXzoksk3d6w9ZAxdP4lH4Nep6545WQmRiiNnms=;
 b=jNGXmd+JGEFPhsMl6J1vhpLJUMa9mpwwG7/r9Y0ugTd5IFATdXqTZ3jXhv+iPzo7NY
 r3l++c8O9H4S6yELYIaspx0jydnDEhhmmZuwn1CoJJQikd/90vGelM7vdCNiD+ljwb1I
 GlegteAH8VkYDC/3z3wEuhjWOrqjHKYldtLN82rUR0w/yyK2sJOC7ESHeJAYTA4kTy1k
 jLi+iSValnEjHvNqCjMSdSd1JVzxproY1KLjP5ReSirSOzMLM+lkFHDJH+EVCG83gXQO
 7ITUN0DaX/xCF8PgFjmKyfpxd5kdQ+PAvVnCV50MMtL/JwPTkOWEHMTIm9hKD6RrgRfR
 YcAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuFMI4dLenAOiXB7nlwRmYoiCg7dRxKUGHLZX+Ai+U6DenJobWU3jf8ArxO+99OxpV8BWitNupEBfp7eF4Gt9hC1pfnRI=
X-Gm-Message-State: AOJu0Ywf+SsqraQpLiOjDxHk1+Oz/bxHkmGXiWRRgX6bs/2Zf7Xxp2nV
 JOdG4+Ni54nD+YRtrprbeFKFKcq/l4KJEW9miDvgiY7lroUBm2rcQtPJz0xLrmAh7dLm8S0QQ+F
 EcpEUzsBZBjiKGWSgr1Bv1pqhzVngll0f8emC+wXH5MkYjMNhkwY6
X-Received: by 2002:a2e:920e:0:b0:2e9:4a5b:b6c2 with SMTP id
 38308e7fff4ca-2ea9519b62emr78538211fa.41.1717489043504; 
 Tue, 04 Jun 2024 01:17:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG736uMi2QiiXv0zGG+qWrOlcj6aam1LoRCebMn9QOnbII8gupvhS/1jlKl2F1B3mHLMWBbhA==
X-Received: by 2002:a2e:920e:0:b0:2e9:4a5b:b6c2 with SMTP id
 38308e7fff4ca-2ea9519b62emr78537971fa.41.1717489043050; 
 Tue, 04 Jun 2024 01:17:23 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4214beb7fa9sm10876275e9.48.2024.06.04.01.17.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jun 2024 01:17:22 -0700 (PDT)
Message-ID: <b2995975-5589-406f-bd07-817291ed4404@redhat.com>
Date: Tue, 4 Jun 2024 10:17:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 18/19] intel_iommu: Implement
 [set|unset]_iommu_device() callbacks
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20240603061023.269738-1-zhenzhong.duan@intel.com>
 <20240603061023.269738-19-zhenzhong.duan@intel.com>
 <fcec6a43-3ac1-46fd-aca2-96097b85175a@redhat.com>
 <SJ0PR11MB67441662E0FD34AE114217AF92F82@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <SJ0PR11MB67441662E0FD34AE114217AF92F82@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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



On 6/4/24 07:46, Duan, Zhenzhong wrote:
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Subject: Re: [PATCH v6 18/19] intel_iommu: Implement
>> [set|unset]_iommu_device() callbacks
>>
>>
>>
>> On 6/3/24 08:10, Zhenzhong Duan wrote:
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
>>>  hw/i386/intel_iommu_internal.h |  9 ++++
>>>  include/hw/i386/intel_iommu.h  |  2 +
>>>  hw/i386/intel_iommu.c          | 76
>> ++++++++++++++++++++++++++++++++++
>>>  3 files changed, 87 insertions(+)
>>>
>>> diff --git a/hw/i386/intel_iommu_internal.h
>> b/hw/i386/intel_iommu_internal.h
>>> index f8cf99bddf..b800d62ca0 100644
>>> --- a/hw/i386/intel_iommu_internal.h
>>> +++ b/hw/i386/intel_iommu_internal.h
>>> @@ -28,6 +28,7 @@
>>>  #ifndef HW_I386_INTEL_IOMMU_INTERNAL_H
>>>  #define HW_I386_INTEL_IOMMU_INTERNAL_H
>>>  #include "hw/i386/intel_iommu.h"
>>> +#include "sysemu/host_iommu_device.h"
>>>
>>>  /*
>>>   * Intel IOMMU register specification
>>> @@ -537,4 +538,12 @@ typedef struct VTDRootEntry VTDRootEntry;
>>>  #define VTD_SL_IGN_COM              0xbff0000000000000ULL
>>>  #define VTD_SL_TM                   (1ULL << 62)
>>>
>>> +
>>> +typedef struct VTDHostIOMMUDevice {
>>> +    IntelIOMMUState *iommu_state;
>>> +    PCIBus *bus;
>>> +    uint8_t devfn;
>>> +    HostIOMMUDevice *dev;
>>> +    QLIST_ENTRY(VTDHostIOMMUDevice) next;
>>> +} VTDHostIOMMUDevice;
>>>  #endif
>>> diff --git a/include/hw/i386/intel_iommu.h
>> b/include/hw/i386/intel_iommu.h
>>> index 7d694b0813..2bbde41e45 100644
>>> --- a/include/hw/i386/intel_iommu.h
>>> +++ b/include/hw/i386/intel_iommu.h
>>> @@ -293,6 +293,8 @@ struct IntelIOMMUState {
>>>      /* list of registered notifiers */
>>>      QLIST_HEAD(, VTDAddressSpace) vtd_as_with_notifiers;
>>>
>>> +    GHashTable *vtd_host_iommu_dev;             /* VTDHostIOMMUDevice
>> */
>>> +
>>>      /* interrupt remapping */
>>>      bool intr_enabled;              /* Whether guest enabled IR */
>>>      dma_addr_t intr_root;           /* Interrupt remapping table pointer */
>>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>>> index 519063c8f8..747c988bc4 100644
>>> --- a/hw/i386/intel_iommu.c
>>> +++ b/hw/i386/intel_iommu.c
>>> @@ -237,6 +237,13 @@ static gboolean vtd_as_equal(gconstpointer v1,
>> gconstpointer v2)
>>>             (key1->pasid == key2->pasid);
>>>  }
>>>
>>> +static gboolean vtd_as_idev_equal(gconstpointer v1, gconstpointer v2)
>>> +{
>>> +    const struct vtd_as_key *key1 = v1;
>>> +    const struct vtd_as_key *key2 = v2;
>>> +
>>> +    return (key1->bus == key2->bus) && (key1->devfn == key2->devfn);
>>> +}
>>>  /*
>>>   * Note that we use pointer to PCIBus as the key, so hashing/shifting
>>>   * based on the pointer value is intended. Note that we deal with
>>> @@ -3812,6 +3819,70 @@ VTDAddressSpace
>> *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
>>>      return vtd_dev_as;
>>>  }
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
>> I am still not totally clear about why we couldn't reuse VTDAddressSpace
>> instance for this bus/devid. Is it a matter of aliased versus non
>> aliased bus/devfn, or a matter of pasid diff. An AddressSpace could back
>> an assigned device in which case a HostIOMMUDevice could be added to
>> this latter. I think this should be explained in the commit msg
> Yes, as you said, it's a matter of aliased vs non aliased BDF.
>
> VTDAddressSpace is per aliased BDF while VTDHostIOMMUDevice is per non aliased BDF.
> There can be multiple assigned devices under same virtual iommu group and share same 
> VTDAddressSpace, but they have their own VTDHostIOMMUDevice.
>
> Will refine commit msg.

OK thank you for the confirmation. A general concern is this is the kind
of code we are going to duplicate in each vIOMMU. This is beyond the
scope of this series but we shall really think about introducing a
common base object for vIOMMU. Unfortunately there are issues related to
multiple inheritence that may prevent us from using usual QOM
inheritence but just as we have done for backends and HostIOMMUDevice we
may implement inheritence another way.

Eric
>
> Thanks
> Zhenzhong
>
>> Eric
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
>>> +
>>> +    vtd_iommu_unlock(s);
>>> +}
>>> +
>>>  /* Unmap the whole range in the notifier's scope. */
>>>  static void vtd_address_space_unmap(VTDAddressSpace *as,
>> IOMMUNotifier *n)
>>>  {
>>> @@ -4116,6 +4187,8 @@ static AddressSpace
>> *vtd_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
>>>  static PCIIOMMUOps vtd_iommu_ops = {
>>>      .get_address_space = vtd_host_dma_iommu,
>>> +    .set_iommu_device = vtd_dev_set_iommu_device,
>>> +    .unset_iommu_device = vtd_dev_unset_iommu_device,
>>>  };
>>>
>>>  static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
>>> @@ -4235,6 +4308,9 @@ static void vtd_realize(DeviceState *dev, Error
>> **errp)
>>>                                       g_free, g_free);
>>>      s->vtd_address_spaces = g_hash_table_new_full(vtd_as_hash,
>> vtd_as_equal,
>>>                                        g_free, g_free);
>>> +    s->vtd_host_iommu_dev = g_hash_table_new_full(vtd_as_hash,
>>> +                                                  vtd_as_idev_equal,
>>> +                                                  g_free, g_free);
>>>      vtd_init(s);
>>>      pci_setup_iommu(bus, &vtd_iommu_ops, dev);
>>>      /* Pseudo address space under root PCI bus. */


