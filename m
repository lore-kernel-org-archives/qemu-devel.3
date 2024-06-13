Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75524C27C75
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 08:14:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHfaA-0005qE-Qc; Thu, 13 Jun 2024 04:13:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sHfa9-0005pn-15
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 04:13:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sHfa7-0000zk-9N
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 04:13:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718266394;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=waa3WhU5CDGh+4DeM+IwdGCxmWc26gMoUuETCM0A7/I=;
 b=Gz1vCK89URn2FssYw3j09KtuLekcVVABb21B32lQVCXu2I3KjSblrLMjlJvXCth3RkrKC+
 XppDlT0eWNz5oiA83lx2J05+ONakf3chnf2V0cMvET2xte74CsaS/zVueXC0+FC43X8fih
 f8F410XPehNgmsRFgJ5Kvsw3YFKdIec=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-8XugwTBFOhO_LYPeJCV47g-1; Thu, 13 Jun 2024 04:13:08 -0400
X-MC-Unique: 8XugwTBFOhO_LYPeJCV47g-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-43fb05ef704so7754791cf.2
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2024 01:13:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718266388; x=1718871188;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=waa3WhU5CDGh+4DeM+IwdGCxmWc26gMoUuETCM0A7/I=;
 b=oyp4UmiNByshuc1BzcaLt073K+27WrDLydj++ZOFF58+vRSw8q6byqVh/qpAARpAR4
 MM+zi8g57Pv0p55OHxqvmDwkXW2VB2f8WaPIwpP7iF6tOyw6u/6ZpE1umuRWV5CXL8D0
 IRl0v/FHGVPexkcvjIjiSwR4LJZCVdlmPkwmRJCNar7Ade5Se2Popy0DuhvJifUPgNMS
 NYOT5/3pxXrzLzDIUswfCQLYyoVLPHpUltT4UHn8RGxyAa8QJ0unxa3ZAYlrcFVHjlaj
 X9WLhm3C3xL/BQls+05UkJfeV2L4EB5XoLwmvfQyKHoU/NXinrWnPlL8MIj0Qk4A/5jE
 18hg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnNFuat9eqf1M/3i119sK7nLVGLhnIri9VXHKY3h7b7uTgfA7XMHFzs6pxE26Q0oIuoDJLTIOe70s1Nk12d/jGthJl8ME=
X-Gm-Message-State: AOJu0Yxv26cjBJlgBrT7WKrTdbBuJMxyGfjtf6jpeFn/6kDhd71ExCVG
 pmxAS8edfB5uxLEngipWfJTp/AELWmNOT6nU+tLzxcrG7qsiAT6ZejOxf5UNJRgTNTBXfafA8KW
 ydloYzkaPfnoOmhA+81KOcp/oMA23MoT5lDYTBzucA4g6eD2Xg7bm
X-Received: by 2002:ac8:5dc9:0:b0:440:6c89:378f with SMTP id
 d75a77b69052e-4415abb0a33mr40285721cf.9.1718266388078; 
 Thu, 13 Jun 2024 01:13:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFLax7cRzYch7wabO6wdDKq2KPZMk/7upXFUeP1CZGrA3k/qAiSrIsFDyG9C1sG45PArqs/Q==
X-Received: by 2002:ac8:5dc9:0:b0:440:6c89:378f with SMTP id
 d75a77b69052e-4415abb0a33mr40285501cf.9.1718266387731; 
 Thu, 13 Jun 2024 01:13:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-441f2ff9ef8sm4012831cf.89.2024.06.13.01.13.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Jun 2024 01:13:07 -0700 (PDT)
Message-ID: <19e732e7-38c5-4164-b023-eb4bb534ddb8@redhat.com>
Date: Thu, 13 Jun 2024 10:13:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 2/7] virtio-iommu: Implement set|unset]_iommu_device()
 callbacks
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "mst@redhat.com"
 <mst@redhat.com>, "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "clg@redhat.com" <clg@redhat.com>, "yanghliu@redhat.com"
 <yanghliu@redhat.com>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>
References: <20240607143905.765133-1-eric.auger@redhat.com>
 <20240607143905.765133-3-eric.auger@redhat.com>
 <SJ0PR11MB6744E8907BBF000C73278B0A92C72@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <SJ0PR11MB6744E8907BBF000C73278B0A92C72@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Zhenzhong,

On 6/11/24 04:38, Duan, Zhenzhong wrote:
> Hi Eric,
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Subject: [RFC v2 2/7] virtio-iommu: Implement set|unset]_iommu_device()
>> callbacks
>>
>> Implement PCIIOMMUOPs [set|unset]_iommu_device() callbacks.
>> In set(), a VirtioHostIOMMUDevice is allocated which holds
>> a reference to the HostIOMMUDevice. This object is stored in a hash
>> table indexed by PCI BDF. The handle to the Host IOMMU device
>> will allow to retrieve information related to the physical IOMMU.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>> include/hw/virtio/virtio-iommu.h |  9 ++++
>> hw/virtio/virtio-iommu.c         | 87
>> ++++++++++++++++++++++++++++++++
>> 2 files changed, 96 insertions(+)
>>
>> diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virtio-
>> iommu.h
>> index 83a52cc446..4f664ea0c4 100644
>> --- a/include/hw/virtio/virtio-iommu.h
>> +++ b/include/hw/virtio/virtio-iommu.h
>> @@ -45,6 +45,14 @@ typedef struct IOMMUDevice {
>>     bool probe_done;
>> } IOMMUDevice;
>>
>> +typedef struct VirtioHostIOMMUDevice {
>> +    void *viommu;
>> +    PCIBus *bus;
>> +    uint8_t devfn;
>> +    HostIOMMUDevice *dev;
>> +    QLIST_ENTRY(VirtioHostIOMMUDevice) next;
>> +} VirtioHostIOMMUDevice;
>> +
>> typedef struct IOMMUPciBus {
>>     PCIBus       *bus;
>>     IOMMUDevice  *pbdev[]; /* Parent array is sparse, so dynamically alloc
>> */
>> @@ -57,6 +65,7 @@ struct VirtIOIOMMU {
>>     struct virtio_iommu_config config;
>>     uint64_t features;
>>     GHashTable *as_by_busptr;
>> +    GHashTable *host_iommu_devices;
>>     IOMMUPciBus *iommu_pcibus_by_bus_num[PCI_BUS_MAX];
>>     PCIBus *primary_bus;
>>     ReservedRegion *prop_resv_regions;
>> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
>> index 1326c6ec41..0680a357f0 100644
>> --- a/hw/virtio/virtio-iommu.c
>> +++ b/hw/virtio/virtio-iommu.c
>> @@ -28,6 +28,7 @@
>> #include "sysemu/kvm.h"
>> #include "sysemu/reset.h"
>> #include "sysemu/sysemu.h"
>> +#include "sysemu/host_iommu_device.h"
> Not sure if better to move this to include/hw/virtio/virtio-iommu.h
> as HostIOMMUDevice is used there.
agreed!
>
>> #include "qemu/reserved-region.h"
>> #include "qemu/units.h"
>> #include "qapi/error.h"
>> @@ -69,6 +70,11 @@ typedef struct VirtIOIOMMUMapping {
>>     uint32_t flags;
>> } VirtIOIOMMUMapping;
>>
>> +struct hiod_key {
>> +    PCIBus *bus;
>> +    uint8_t devfn;
>> +};
>> +
>> static inline uint16_t virtio_iommu_get_bdf(IOMMUDevice *dev)
>> {
>>     return PCI_BUILD_BDF(pci_bus_num(dev->bus), dev->devfn);
>> @@ -462,8 +468,86 @@ static AddressSpace
>> *virtio_iommu_find_add_as(PCIBus *bus, void *opaque,
>>     return &sdev->as;
>> }
>>
>> +static gboolean hiod_equal(gconstpointer v1, gconstpointer v2)
>> +{
>> +    const struct hiod_key *key1 = v1;
>> +    const struct hiod_key *key2 = v2;
>> +
>> +    return (key1->bus == key2->bus) && (key1->devfn == key2->devfn);
>> +}
>> +
>> +static guint hiod_hash(gconstpointer v)
>> +{
>> +    const struct hiod_key *key = v;
>> +    guint value = (guint)(uintptr_t)key->bus;
>> +
>> +    return (guint)(value << 8 | key->devfn);
>> +}
>> +
>> +static VirtioHostIOMMUDevice *
>> +get_host_iommu_device(VirtIOIOMMU *viommu, PCIBus *bus, int devfn) {
>> +    struct hiod_key key = {
>> +        .bus = bus,
>> +        .devfn = devfn,
>> +    };
>> +
>> +    return g_hash_table_lookup(viommu->host_iommu_devices, &key);
>> +}
>> +
>> +static bool virtio_iommu_set_iommu_device(PCIBus *bus, void *opaque,
>> int devfn,
>> +                                          HostIOMMUDevice *hiod, Error **errp)
>> +{
>> +    VirtIOIOMMU *viommu = opaque;
>> +    VirtioHostIOMMUDevice *vhiod;
>> +    struct hiod_key *new_key;
>> +
>> +    assert(hiod);
>> +
>> +    vhiod = get_host_iommu_device(viommu, bus, devfn);
>> +    if (vhiod) {
>> +        error_setg(errp, "VirtioHostIOMMUDevice already exists");
>> +        return false;
>> +    }
>> +
>> +    vhiod = g_malloc0(sizeof(VirtioHostIOMMUDevice));
>> +    vhiod->bus = bus;
>> +    vhiod->devfn = (uint8_t)devfn;
>> +    vhiod->viommu = viommu;
>> +    vhiod->dev = hiod;
>> +
>> +    new_key = g_malloc(sizeof(*new_key));
>> +    new_key->bus = bus;
>> +    new_key->devfn = devfn;
>> +
>> +    object_ref(hiod);
>> +    g_hash_table_insert(viommu->host_iommu_devices, new_key, vhiod);
>> +
>> +    return true;
>> +}
>> +
>> +static void
>> +virtio_iommu_unset_iommu_device(PCIBus *bus, void *opaque, int devfn)
>> +{
>> +    VirtIOIOMMU *viommu = opaque;
>> +    VirtioHostIOMMUDevice *vhiod;
>> +    struct hiod_key key = {
>> +        .bus = bus,
>> +        .devfn = devfn,
>> +    };
>> +
>> +    vhiod = g_hash_table_lookup(viommu->host_iommu_devices, &key);
>> +    if (!vhiod) {
>> +        return;
>> +    }
>> +
>> +    g_hash_table_remove(viommu->host_iommu_devices, &key);
>> +    object_unref(vhiod->dev);
> This looks a use-after-free.
yes. Adopting the destroy function now in place in intel iommu

Thanks!

Eric
>
> Thanks
> Zhenzhong
>
>> +}
>> +
>> static const PCIIOMMUOps virtio_iommu_ops = {
>>     .get_address_space = virtio_iommu_find_add_as,
>> +    .set_iommu_device = virtio_iommu_set_iommu_device,
>> +    .unset_iommu_device = virtio_iommu_unset_iommu_device,
>> };
>>
>> static int virtio_iommu_attach(VirtIOIOMMU *s,
>> @@ -1357,6 +1441,9 @@ static void
>> virtio_iommu_device_realize(DeviceState *dev, Error **errp)
>>
>>     s->as_by_busptr = g_hash_table_new_full(NULL, NULL, NULL, g_free);
>>
>> +    s->host_iommu_devices = g_hash_table_new_full(hiod_hash,
>> hiod_equal,
>> +                                                  g_free, g_free);
>> +
>>     if (s->primary_bus) {
>>         pci_setup_iommu(s->primary_bus, &virtio_iommu_ops, s);
>>     } else {
>> --
>> 2.41.0


