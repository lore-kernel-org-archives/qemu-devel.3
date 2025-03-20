Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 352FEC28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 19:27:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvLX1-0003cN-Va; Thu, 20 Mar 2025 15:26:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tvLWz-0003bX-Pw
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 15:26:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tvLWw-0002kC-Fz
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 15:26:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742498771;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=s7teVjlOaFHdrTbcfvvH3mP6MNox6Ep586N9QIuF9ew=;
 b=VEXHOHv5nSvLmWeOBpwW/rqkUNp1MmQOnJf3qpNYRCxuQyJyOzinKohlRuvpk/uQbPEhDc
 JQCuajgxCMBLZFYsfdjahDEY8ZGAZeOFODzFH9tU8p27mI4Qa9dI26AvU6QEOEloolxg0x
 wmjKJnAD+iQsQ2DJEqbFTeGkbTYq5u8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-rpNSvzz-McebOPw0VncJRw-1; Thu, 20 Mar 2025 15:26:10 -0400
X-MC-Unique: rpNSvzz-McebOPw0VncJRw-1
X-Mimecast-MFC-AGG-ID: rpNSvzz-McebOPw0VncJRw_1742498769
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43935e09897so8020645e9.1
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 12:26:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742498769; x=1743103569;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s7teVjlOaFHdrTbcfvvH3mP6MNox6Ep586N9QIuF9ew=;
 b=k0vKLx0NNGaqBn1knslkSCn+XkAjIgTTscWPyTA0ObefH3oWuiiSowqyMxLhl54M12
 +FmqsDPKDl2dZl3hieMRfXN+aYdJovPvuwpao4Jdf1h4vtVIstSulPI1zYtlfM2B5SWH
 CUFlEiNnl8GHFNEyd3qjX2lz93uX0Qql0Z8Lsu9w5mDxEDIPSG3byHQcra/ooCEsLXCD
 Hd+aOm0kFSSAdrABCVdD+2ILrETc5XqM0ps/iEPTuiAlzrLZHFg+JQW4RkyrVVSO9c7s
 YvxGSgOtrfbH6ZhDrcuUdCcJixBIdB5rcMj1v6Ko14LP9hCUlZ4/IiI09+ilH8vLimec
 Fhjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdh/DX3tbSxCBj2dVAq2Tfgwa4W6BSk7JIsgX3RNII3lDeq3xJ1qnB92NKddi2G/X9ZPijT9Wu/3k5@nongnu.org
X-Gm-Message-State: AOJu0YzbHlF8jQS4ZzIoItDVnSWT+w2+Tu5JFTrXkW5HLO5dyQEzRUG7
 caWhHq4g3Sqo76f4msBAJ0ySv4+9OdK8Swz2WdbnlRc31OE0x/h4pV280JAfzsWueqmXsIWoUbD
 vJqNm3ffujhDQH1J67g27xAqb5AbzPvanoEA8ZQoZGdhZQA3t92HR
X-Gm-Gg: ASbGncvKaVYYvmhWfPjKT6YdkTWAeuXOv4HSiLR+GjjhkHPCszZIz0xebbQFBFOEtVf
 31ejTtpUb4YogR1XKnCkYaUZalimzuoMf8D8DUmcfn8mYkdaSd1rHgz8hTV/x5D35gEfxSM0GDz
 hvoZczaoi3ukAjgc06HEZv7LU2viaVUE4h0SfghP7Zg4sVwWi8KRuxn0TS78Ik6TLozD6WwawKX
 kQ+yL6r1SZCOJDeSnwnI7vXToY1KhgMkvU4oqL39acPIlmgHf4nByU0L4o9rWNumjJd1t002Y0a
 w3LN4aIJ0PUJGx7jyHmPqREJyTs9113YmgFDpQHSgA3DZiXkYFGGnQ==
X-Received: by 2002:a05:600c:3c82:b0:43d:45a:8fbb with SMTP id
 5b1f17b1804b1-43d50a1d1ebmr2869235e9.22.1742498768461; 
 Thu, 20 Mar 2025 12:26:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPqxJCsvG7W6ObNuhlzZh6zLT8jI7Dl4chiqwnicX4zSyAaTAZRmpiLRtUOZUiQzRUNu3u7Q==
X-Received: by 2002:a05:600c:3c82:b0:43d:45a:8fbb with SMTP id
 5b1f17b1804b1-43d50a1d1ebmr2869085e9.22.1742498767927; 
 Thu, 20 Mar 2025 12:26:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43fdac9dsm56513695e9.30.2025.03.20.12.26.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Mar 2025 12:26:07 -0700 (PDT)
Message-ID: <c36e00cf-c440-47c4-abba-3f312e1fe27e@redhat.com>
Date: Thu, 20 Mar 2025 20:26:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.1 13/32] vfio: Move VFIOAddressSpace helpers into
 container-base.c
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Alex Williamson <alex.williamson@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 John Levon <levon@movementarian.org>
References: <20250318095415.670319-1-clg@redhat.com>
 <20250318095415.670319-14-clg@redhat.com>
 <SJ0PR11MB67448F80023E79545BE260AF92D82@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <SJ0PR11MB67448F80023E79545BE260AF92D82@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

+John

On 3/20/25 10:36, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Cédric Le Goater <clg@redhat.com>
>> Subject: [PATCH for-10.1 13/32] vfio: Move VFIOAddressSpace helpers into
>> container-base.c
>>
>> VFIOAddressSpace is a common object used by VFIOContainerBase which is
>> declared in "hw/vfio/vfio-container-base.h". Move the VFIOAddressSpace
>> related services into "container-base.c".
>>
>> While at it, rename :
>>
>>   vfio_get_address_space -> vfio_address_space_get
>>   vfio_put_address_space -> vfio_address_space_put
>>
>> to better reflect the namespace these routines belong to.
>>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>> include/hw/vfio/vfio-common.h         |  6 ---
>> include/hw/vfio/vfio-container-base.h |  5 ++
>> hw/ppc/spapr_pci_vfio.c               |  5 +-
>> hw/vfio/common.c                      | 66 -------------------------
>> hw/vfio/container-base.c              | 69 +++++++++++++++++++++++++++
>> hw/vfio/container.c                   |  6 +--
>> hw/vfio/iommufd.c                     |  6 +--
>> hw/vfio/trace-events                  |  4 +-
>> 8 files changed, 85 insertions(+), 82 deletions(-)
>>
>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>> index
>> e23626856e6ff96939a4660f059833f166aa88e9..2ea7f9c6f6e7e752699954ac236
>> cac0bbe834b39 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -120,18 +120,12 @@ struct VFIODeviceOps {
>> #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO \
>>              TYPE_HOST_IOMMU_DEVICE_IOMMUFD "-vfio"
>>
>> -VFIOAddressSpace *vfio_get_address_space(AddressSpace *as);
>> -void vfio_put_address_space(VFIOAddressSpace *space);
>> -void vfio_address_space_insert(VFIOAddressSpace *space,
>> -                               VFIOContainerBase *bcontainer);
>> -
>> void vfio_disable_irqindex(VFIODevice *vbasedev, int index);
>> void vfio_unmask_single_irqindex(VFIODevice *vbasedev, int index);
>> void vfio_mask_single_irqindex(VFIODevice *vbasedev, int index);
>> bool vfio_set_irq_signaling(VFIODevice *vbasedev, int index, int subindex,
>>                              int action, int fd, Error **errp);
>>
>> -void vfio_reset_handler(void *opaque);
>> struct vfio_device_info *vfio_get_device_info(int fd);
>> bool vfio_device_is_mdev(VFIODevice *vbasedev);
>> bool vfio_device_hiod_realize(VFIODevice *vbasedev, Error **errp);
>> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-
>> container-base.h
>> index
>> 4cff9943ab4861a25d07b5ebd1200509ebfab12d..27668879f5ca77e558a2bda954
>> 8c8e60afefe794 100644
>> --- a/include/hw/vfio/vfio-container-base.h
>> +++ b/include/hw/vfio/vfio-container-base.h
>> @@ -71,6 +71,11 @@ typedef struct VFIORamDiscardListener {
>>      QLIST_ENTRY(VFIORamDiscardListener) next;
>> } VFIORamDiscardListener;
>>
>> +VFIOAddressSpace *vfio_address_space_get(AddressSpace *as);
>> +void vfio_address_space_put(VFIOAddressSpace *space);
>> +void vfio_address_space_insert(VFIOAddressSpace *space,
>> +                               VFIOContainerBase *bcontainer);
>> +
>> int vfio_container_dma_map(VFIOContainerBase *bcontainer,
>>                             hwaddr iova, ram_addr_t size,
>>                             void *vaddr, bool readonly);
>> diff --git a/hw/ppc/spapr_pci_vfio.c b/hw/ppc/spapr_pci_vfio.c
>> index
>> 1722a5bfa3983d42baac558f22410e36eed375f5..e318d0d912f3e90d1289e4bc21
>> 95bf68418e5206 100644
>> --- a/hw/ppc/spapr_pci_vfio.c
>> +++ b/hw/ppc/spapr_pci_vfio.c
>> @@ -24,7 +24,6 @@
>> #include "hw/pci-host/spapr.h"
>> #include "hw/pci/msix.h"
>> #include "hw/pci/pci_device.h"
>> -#include "hw/vfio/vfio-common.h"
>> #include "hw/vfio/vfio-container.h"
>> #include "qemu/error-report.h"
>> #include CONFIG_DEVICES /* CONFIG_VFIO_PCI */
>> @@ -86,7 +85,7 @@ static int vfio_eeh_container_op(VFIOContainer *container,
>> uint32_t op)
>>
>> static VFIOContainer *vfio_eeh_as_container(AddressSpace *as)
>> {
>> -    VFIOAddressSpace *space = vfio_get_address_space(as);
>> +    VFIOAddressSpace *space = vfio_address_space_get(as);
>>      VFIOContainerBase *bcontainer = NULL;
>>
>>      if (QLIST_EMPTY(&space->containers)) {
>> @@ -106,7 +105,7 @@ static VFIOContainer
>> *vfio_eeh_as_container(AddressSpace *as)
>>      }
>>
>> out:
>> -    vfio_put_address_space(space);
>> +    vfio_address_space_put(space);
>>      return container_of(bcontainer, VFIOContainer, bcontainer);
>> }
>>
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index
>> 0e3746eddd1c08e98bf57a59d542e158487d346e..08e2494d7c4a9858657724730
>> b2829290fb3f197 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -36,7 +36,6 @@
>> #include "qemu/main-loop.h"
>> #include "qemu/range.h"
>> #include "system/kvm.h"
>> -#include "system/reset.h"
>> #include "system/runstate.h"
>> #include "trace.h"
>> #include "qapi/error.h"
>> @@ -48,8 +47,6 @@
>>
>> VFIODeviceList vfio_device_list =
>>      QLIST_HEAD_INITIALIZER(vfio_device_list);
>> -static QLIST_HEAD(, VFIOAddressSpace) vfio_address_spaces =
>> -    QLIST_HEAD_INITIALIZER(vfio_address_spaces);
>>
>> #ifdef CONFIG_KVM
>> /*
>> @@ -1304,24 +1301,6 @@ const MemoryListener vfio_memory_listener = {
>>      .log_sync = vfio_listener_log_sync,
>> };
>>
>> -void vfio_reset_handler(void *opaque)
>> -{
>> -    VFIODevice *vbasedev;
>> -
>> -    trace_vfio_reset_handler();
>> -    QLIST_FOREACH(vbasedev, &vfio_device_list, global_next) {
>> -        if (vbasedev->dev->realized) {
>> -            vbasedev->ops->vfio_compute_needs_reset(vbasedev);
>> -        }
>> -    }
>> -
>> -    QLIST_FOREACH(vbasedev, &vfio_device_list, global_next) {
>> -        if (vbasedev->dev->realized && vbasedev->needs_reset) {
>> -            vbasedev->ops->vfio_hot_reset_multi(vbasedev);
>> -        }
>> -    }
>> -}
>> -
>> int vfio_kvm_device_add_fd(int fd, Error **errp)
>> {
>> #ifdef CONFIG_KVM
>> @@ -1380,51 +1359,6 @@ int vfio_kvm_device_del_fd(int fd, Error **errp)
>>      return 0;
>> }
>>
>> -VFIOAddressSpace *vfio_get_address_space(AddressSpace *as)
>> -{
>> -    VFIOAddressSpace *space;
>> -
>> -    QLIST_FOREACH(space, &vfio_address_spaces, list) {
>> -        if (space->as == as) {
>> -            return space;
>> -        }
>> -    }
>> -
>> -    /* No suitable VFIOAddressSpace, create a new one */
>> -    space = g_malloc0(sizeof(*space));
>> -    space->as = as;
>> -    QLIST_INIT(&space->containers);
>> -
>> -    if (QLIST_EMPTY(&vfio_address_spaces)) {
>> -        qemu_register_reset(vfio_reset_handler, NULL);
>> -    }
>> -
>> -    QLIST_INSERT_HEAD(&vfio_address_spaces, space, list);
>> -
>> -    return space;
>> -}
>> -
>> -void vfio_put_address_space(VFIOAddressSpace *space)
>> -{
>> -    if (!QLIST_EMPTY(&space->containers)) {
>> -        return;
>> -    }
>> -
>> -    QLIST_REMOVE(space, list);
>> -    g_free(space);
>> -
>> -    if (QLIST_EMPTY(&vfio_address_spaces)) {
>> -        qemu_unregister_reset(vfio_reset_handler, NULL);
>> -    }
>> -}
>> -
>> -void vfio_address_space_insert(VFIOAddressSpace *space,
>> -                               VFIOContainerBase *bcontainer)
>> -{
>> -    QLIST_INSERT_HEAD(&space->containers, bcontainer, next);
>> -    bcontainer->space = space;
>> -}
>> -
>> struct vfio_device_info *vfio_get_device_info(int fd)
>> {
>>      struct vfio_device_info *info;
>> diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
>> index
>> 749a3fd29dd6fc9143f14edf7e4ac6238315fcce..83e83ab9e67de8b004dfaf0067e
>> 4c466a6c88451 100644
>> --- a/hw/vfio/container-base.c
>> +++ b/hw/vfio/container-base.c
>> @@ -13,7 +13,76 @@
>> #include "qemu/osdep.h"
>> #include "qapi/error.h"
>> #include "qemu/error-report.h"
>> +#include "system/reset.h"
>> #include "hw/vfio/vfio-container-base.h"
>> +#include "hw/vfio/vfio-common.h" /* for vfio_device_list */
>> +#include "trace.h"
>> +
>> +static QLIST_HEAD(, VFIOAddressSpace) vfio_address_spaces =
>> +    QLIST_HEAD_INITIALIZER(vfio_address_spaces);
>> +
>> +static void vfio_reset_handler(void *opaque)
>> +{
>> +    VFIODevice *vbasedev;
>> +
>> +    trace_vfio_reset_handler();
>> +    QLIST_FOREACH(vbasedev, &vfio_device_list, global_next) {
>> +        if (vbasedev->dev->realized) {
>> +            vbasedev->ops->vfio_compute_needs_reset(vbasedev);
>> +        }
>> +    }
>> +
>> +    QLIST_FOREACH(vbasedev, &vfio_device_list, global_next) {
>> +        if (vbasedev->dev->realized && vbasedev->needs_reset) {
>> +            vbasedev->ops->vfio_hot_reset_multi(vbasedev);
>> +        }
>> +    }
>> +}
> 
> This is not an address space scoped function, 

yep.

AIUI, pass-through devices of a VM are not necessarily in the same
group and we need to scan all groups/address_spaces when the machine
is reset.

There use to be a long comment explaining the context but we lost it
along the way. I will add it back :

   /*
    * We want to differentiate hot reset of mulitple in-use devices vs hot reset
    * of a single in-use device.  VFIO_DEVICE_RESET will already handle the case
    * of doing hot resets when there is only a single device per bus.  The in-use
    * here refers to how many VFIODevices are affected.  A hot reset that affects
    * multiple devices, but only a single in-use device, means that we can call
    * it from our bus ->reset() callback since the extent is effectively a single
    * device.  This allows us to make use of it in the hotplug path.  When there
    * are multiple in-use devices, we can only trigger the hot reset during a
    * system reset and thus from our reset handler.  We separate _one vs _multi
    * here so that we don't overlap and do a double reset on the system reset
    * path where both our reset handler and ->reset() callback are used.  Calling
    * _one() will only do a hot reset for the one in-use devices case, calling
    * _multi() will do nothing if a _one() would have been sufficient.
    */

See commit f16f39c3fc97 ("Implement PCI hot reset").

> no sure if better to move to helper.c or common.c

This is a machine scope "helper" calling VFIODevice handlers, may be in
device.c  ?


Thanks,

C.


  
> Thanks
> Zhenzhong
> 
>> +
>> +VFIOAddressSpace *vfio_address_space_get(AddressSpace *as)
>> +{
>> +    VFIOAddressSpace *space;
>> +
>> +    QLIST_FOREACH(space, &vfio_address_spaces, list) {
>> +        if (space->as == as) {
>> +            return space;
>> +        }
>> +    }
>> +
>> +    /* No suitable VFIOAddressSpace, create a new one */
>> +    space = g_malloc0(sizeof(*space));
>> +    space->as = as;
>> +    QLIST_INIT(&space->containers);
>> +
>> +    if (QLIST_EMPTY(&vfio_address_spaces)) {
>> +        qemu_register_reset(vfio_reset_handler, NULL);
>> +    }
>> +
>> +    QLIST_INSERT_HEAD(&vfio_address_spaces, space, list);
>> +
>> +    return space;
>> +}
>> +
>> +void vfio_address_space_put(VFIOAddressSpace *space)
>> +{
>> +    if (!QLIST_EMPTY(&space->containers)) {
>> +        return;
>> +    }
>> +
>> +    QLIST_REMOVE(space, list);
>> +    g_free(space);
>> +
>> +    if (QLIST_EMPTY(&vfio_address_spaces)) {
>> +        qemu_unregister_reset(vfio_reset_handler, NULL);
>> +    }
>> +}
>> +
>> +void vfio_address_space_insert(VFIOAddressSpace *space,
>> +                               VFIOContainerBase *bcontainer)
>> +{
>> +    QLIST_INSERT_HEAD(&space->containers, bcontainer, next);
>> +    bcontainer->space = space;
>> +}
>>
>> int vfio_container_dma_map(VFIOContainerBase *bcontainer,
>>                             hwaddr iova, ram_addr_t size,
>> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>> index
>> 8badeb98ec052ad1fa7b5d45bb1733b1184bc6fb..9b86e24a4072e579bcdc2c060c
>> e42608ee44ee2e 100644
>> --- a/hw/vfio/container.c
>> +++ b/hw/vfio/container.c
>> @@ -546,7 +546,7 @@ static bool vfio_connect_container(VFIOGroup *group,
>> AddressSpace *as,
>>      VFIOAddressSpace *space;
>>      VFIOIOMMUClass *vioc;
>>
>> -    space = vfio_get_address_space(as);
>> +    space = vfio_address_space_get(as);
>>
>>      /*
>>       * VFIO is currently incompatible with discarding of RAM insofar as the
>> @@ -675,7 +675,7 @@ close_fd_exit:
>>      close(fd);
>>
>> put_space_exit:
>> -    vfio_put_address_space(space);
>> +    vfio_address_space_put(space);
>>
>>      return false;
>> }
>> @@ -714,7 +714,7 @@ static void vfio_disconnect_container(VFIOGroup *group)
>>          close(container->fd);
>>          object_unref(container);
>>
>> -        vfio_put_address_space(space);
>> +        vfio_address_space_put(space);
>>      }
>> }
>>
>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>> index
>> a219b6453037e2d4e0d12800ea25678885af98f8..a170f5c71218db8c9b2f00b1a4
>> 5ee900b6b21346 100644
>> --- a/hw/vfio/iommufd.c
>> +++ b/hw/vfio/iommufd.c
>> @@ -487,7 +487,7 @@ static bool iommufd_cdev_attach(const char *name,
>> VFIODevice *vbasedev,
>>          goto err_connect_bind;
>>      }
>>
>> -    space = vfio_get_address_space(as);
>> +    space = vfio_address_space_get(as);
>>
>>      /*
>>       * The HostIOMMUDevice data from legacy backend is static and doesn't need
>> @@ -607,7 +607,7 @@ err_discard_disable:
>> err_attach_container:
>>      iommufd_cdev_container_destroy(container);
>> err_alloc_ioas:
>> -    vfio_put_address_space(space);
>> +    vfio_address_space_put(space);
>>      iommufd_cdev_unbind_and_disconnect(vbasedev);
>> err_connect_bind:
>>      close(vbasedev->fd);
>> @@ -632,7 +632,7 @@ static void iommufd_cdev_detach(VFIODevice *vbasedev)
>>      vfio_cpr_unregister_container(bcontainer);
>>      iommufd_cdev_detach_container(vbasedev, container);
>>      iommufd_cdev_container_destroy(container);
>> -    vfio_put_address_space(space);
>> +    vfio_address_space_put(space);
>>
>>      iommufd_cdev_unbind_and_disconnect(vbasedev);
>>      close(vbasedev->fd);
>> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
>> index
>> 81f4130100c48012c15b5b4858446149a7eaf5b6..c3691c1a172c31c5b10bfd6967
>> c32fd32b65d0f7 100644
>> --- a/hw/vfio/trace-events
>> +++ b/hw/vfio/trace-events
>> @@ -109,7 +109,6 @@ vfio_get_dev_region(const char *name, int index,
>> uint32_t type, uint32_t subtype
>> vfio_legacy_dma_unmap_overflow_workaround(void) ""
>> vfio_get_dirty_bitmap(uint64_t iova, uint64_t size, uint64_t bitmap_size,
>> uint64_t start, uint64_t dirty_pages) "iova=0x%"PRIx64" size= 0x%"PRIx64"
>> bitmap_size=0x%"PRIx64" start=0x%"PRIx64" dirty_pages=%"PRIu64
>> vfio_iommu_map_dirty_notify(uint64_t iova_start, uint64_t iova_end) "iommu
>> dirty @ 0x%"PRIx64" - 0x%"PRIx64
>> -vfio_reset_handler(void) ""
>>
>> # region.c
>> vfio_region_write(const char *name, int index, uint64_t addr, uint64_t data,
>> unsigned size) " (%s:region%d+0x%"PRIx64", 0x%"PRIx64 ", %d)"
>> @@ -194,3 +193,6 @@ iommufd_cdev_fail_attach_existing_container(const
>> char *msg) " %s"
>> iommufd_cdev_alloc_ioas(int iommufd, int ioas_id) " [iommufd=%d] new
>> IOMMUFD container with ioasid=%d"
>> iommufd_cdev_device_info(char *name, int devfd, int num_irqs, int
>> num_regions, int flags) " %s (%d) num_irqs=%d num_regions=%d flags=%d"
>> iommufd_cdev_pci_hot_reset_dep_devices(int domain, int bus, int slot, int
>> function, int dev_id) "\t%04x:%02x:%02x.%x devid %d"
>> +
>> +# container-base.c
>> +vfio_reset_handler(void) ""
>> --
>> 2.48.1
> 


