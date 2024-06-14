Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31363C27C6E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 07:49:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sI1gJ-0007tM-7n; Fri, 14 Jun 2024 03:49:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sI1gH-0007sj-GN
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 03:49:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sI1gF-0004ce-3r
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 03:49:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718351342;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2cpC6HAtTayYyncybi493nb4HO/dRbMmUWxVgvSxpcg=;
 b=G5NRlTmGPUUfkiDv69O3BCs8qvyuMYxJvEzam7v0NbLwiGXEucghdCT4/+gNHhrXKhkZ3P
 z/jkxQIBg9KOGpjlNaBTCvAGmBej/HO+SKHtORloA10wAZ95XF5f0jjNx92PsAGn4cncME
 Yw2ueqJzoU8917x14mAQ3YEbxx0aQhs=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-gpCrjju2OcaWSjwtDTL6QQ-1; Fri, 14 Jun 2024 03:48:58 -0400
X-MC-Unique: gpCrjju2OcaWSjwtDTL6QQ-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2ebd5d5e151so13541181fa.2
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2024 00:48:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718351337; x=1718956137;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2cpC6HAtTayYyncybi493nb4HO/dRbMmUWxVgvSxpcg=;
 b=JgOL08uPpM1LdjHenXxMEUBABySPxEnupD3UoD2CZ5umH33XcKI9EFXDP6gmYPoLRk
 /G+FFYGGFRMPynKXoQRNza2/5DNpVBBwpfXZQK8ukrtDHOUCmpYH4HpJH6ilLO/Hz19S
 uQGGiB1Do39u4tTOFxTz0FfdLxmPl5kZBMeuZ5iiCvfyFI12v65JYe2OxhetfsYbEQTP
 DIPIAne1VgWzKHHZAHzUO/DSS812AHtwtVOYSIwVrd5BvFJlciCotAGo3y+yorPFb32+
 6+r7G0Ufh7tqcsq5NWN98qAW/ThyGTtkOozHLnVhkdr5djwG4szvHqYEVjJa5MEbhPuR
 efXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlLRl0JHBFtS7I0CMRr+C5kCRuf1MLh9TC8A77rzEmBZ067MdxqZT2zrw5S4XjYq/QQiIOwIdnAuagUisTtAp6Il+GssE=
X-Gm-Message-State: AOJu0Yyu4MMuGoUO9Le1M53dR/is52uaD3w+7x8uOAJSCFh9UMKVHl4e
 emGdZmRo7CaHvc7J6QP23BJBiHgPq/iJwmv0EkeVB6mG0kGyp5xyA8+q5W8p5+lfAWq08OogJ5K
 NV/uoyIIWVORRita6lOVI8AI7mJIFGapetA3VKeWSzGXzlSIg34K0
X-Received: by 2002:a2e:7218:0:b0:2ea:e759:749f with SMTP id
 38308e7fff4ca-2ec0e5b5347mr11823791fa.11.1718351336876; 
 Fri, 14 Jun 2024 00:48:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmez4S+MZ1chEz4hwQjqqz3rdb3x7LBzZqKSr483CcOsAhPophxlkdGBowTLDxZBySBhn1hA==
X-Received: by 2002:a2e:7218:0:b0:2ea:e759:749f with SMTP id
 38308e7fff4ca-2ec0e5b5347mr11823571fa.11.1718351336461; 
 Fri, 14 Jun 2024 00:48:56 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422874e74c7sm87586085e9.47.2024.06.14.00.48.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Jun 2024 00:48:56 -0700 (PDT)
Message-ID: <5778dc35-018d-4a5e-932c-1869a2339ae1@redhat.com>
Date: Fri, 14 Jun 2024 09:48:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/7] virtio-iommu: Implement set|unset]_iommu_device()
 callbacks
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "mst@redhat.com"
 <mst@redhat.com>, "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "clg@redhat.com" <clg@redhat.com>, "yanghliu@redhat.com"
 <yanghliu@redhat.com>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>
References: <20240613092359.847145-1-eric.auger@redhat.com>
 <20240613092359.847145-3-eric.auger@redhat.com>
 <SJ0PR11MB674452B1D7B17383EFA73E6C92C12@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <SJ0PR11MB674452B1D7B17383EFA73E6C92C12@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
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

Hi Zhenzhong,

On 6/13/24 11:57, Duan, Zhenzhong wrote:
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Subject: [PATCH v3 2/7] virtio-iommu: Implement
>> set|unset]_iommu_device() callbacks
>>
>> Implement PCIIOMMUOPs [set|unset]_iommu_device() callbacks.
>> In set(), a VirtioHostIOMMUDevice is allocated which holds
>> a reference to the HostIOMMUDevice. This object is stored in a hash
>> table indexed by PCI BDF. The handle to the Host IOMMU device
>> will allow to retrieve information related to the physical IOMMU.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> ---
>>
>> v2 -> v3:
>> - include host_iommu_device.h in virtio-iommu.h header
>> - introduce hiod_destroy() and fix UAF in
>>  virtio_iommu_unset_iommu_device()	
>> ---
>> include/hw/virtio/virtio-iommu.h | 10 ++++
>> hw/virtio/virtio-iommu.c         | 90
>> ++++++++++++++++++++++++++++++++
>> 2 files changed, 100 insertions(+)
>>
>> diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virtio-
>> iommu.h
>> index 83a52cc446..a5926de947 100644
>> --- a/include/hw/virtio/virtio-iommu.h
>> +++ b/include/hw/virtio/virtio-iommu.h
>> @@ -25,6 +25,7 @@
>> #include "hw/pci/pci.h"
>> #include "qom/object.h"
>> #include "qapi/qapi-types-virtio.h"
>> +#include "sysemu/host_iommu_device.h"
>>
>> #define TYPE_VIRTIO_IOMMU "virtio-iommu-device"
>> #define TYPE_VIRTIO_IOMMU_PCI "virtio-iommu-pci"
>> @@ -45,6 +46,14 @@ typedef struct IOMMUDevice {
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
> Do you have plan to use the elements in VirtioHostIOMMUDevice?
As of now I get rid of this derived object and do something similar as
what you did on vtd.
>
>> +
>> typedef struct IOMMUPciBus {
>>     PCIBus       *bus;
>>     IOMMUDevice  *pbdev[]; /* Parent array is sparse, so dynamically alloc
>> */
>> @@ -57,6 +66,7 @@ struct VirtIOIOMMU {
>>     struct virtio_iommu_config config;
>>     uint64_t features;
>>     GHashTable *as_by_busptr;
>> +    GHashTable *host_iommu_devices;
>>     IOMMUPciBus *iommu_pcibus_by_bus_num[PCI_BUS_MAX];
>>     PCIBus *primary_bus;
>>     ReservedRegion *prop_resv_regions;
>> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
>> index 1326c6ec41..db842555c8 100644
>> --- a/hw/virtio/virtio-iommu.c
>> +++ b/hw/virtio/virtio-iommu.c
>> @@ -69,6 +69,11 @@ typedef struct VirtIOIOMMUMapping {
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
>> @@ -462,8 +467,90 @@ static AddressSpace
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
>> +static void hiod_destroy(gpointer v)
>> +{
>> +    object_unref(v);
> This is a bit different from intel_iommu, here v represents VirtioHostIOMMUDevice *.
damned, you are totally right.

Fixed in next version.

Thank you very much!

Eric
>
> Thanks
> Zhenzhong
>
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
>> +}
>> +
>> static const PCIIOMMUOps virtio_iommu_ops = {
>>     .get_address_space = virtio_iommu_find_add_as,
>> +    .set_iommu_device = virtio_iommu_set_iommu_device,
>> +    .unset_iommu_device = virtio_iommu_unset_iommu_device,
>> };
>>
>> static int virtio_iommu_attach(VirtIOIOMMU *s,
>> @@ -1357,6 +1444,9 @@ static void
>> virtio_iommu_device_realize(DeviceState *dev, Error **errp)
>>
>>     s->as_by_busptr = g_hash_table_new_full(NULL, NULL, NULL, g_free);
>>
>> +    s->host_iommu_devices = g_hash_table_new_full(hiod_hash,
>> hiod_equal,
>> +                                                  g_free, hiod_destroy);
>> +
>>     if (s->primary_bus) {
>>         pci_setup_iommu(s->primary_bus, &virtio_iommu_ops, s);
>>     } else {
>> --
>> 2.41.0


