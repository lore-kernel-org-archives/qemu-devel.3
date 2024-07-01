Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D81F5C30653
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 10:43:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOEVD-0005gC-65; Mon, 01 Jul 2024 06:43:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sOEVB-0005ft-2x
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 06:43:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sOEV9-0001um-Co
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 06:43:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719830594;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xIDZfLFGIc+t/Hlmi27d88Nvvw+ba72jkbjZoyaJg/c=;
 b=MmMDweA1aQSL38Wd59pzb265mA6H8uTbHiPUTEOnxTiB8g3iVbbeNCzR54hl0tHZGRGhN2
 8Dr2nQIZRNErjxZ97KnRBKvX4x3g6Z26hKXogn4Tvqq+1VSUC9wU5TNlgXOHcKICPS9LHU
 lDHpvpklKHG4EdF6LZsFNJ1acErSDEI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-9JMwsjiNMQ-OQtUd5-Sdgg-1; Mon, 01 Jul 2024 06:43:13 -0400
X-MC-Unique: 9JMwsjiNMQ-OQtUd5-Sdgg-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-79d5ae48999so455569185a.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 03:43:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719830592; x=1720435392;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xIDZfLFGIc+t/Hlmi27d88Nvvw+ba72jkbjZoyaJg/c=;
 b=duYyrNqAmHYndXfAtWNnaT+1eFEiCm63bHwLk9T5z06PVrwv8+bmMOuWPTAwgMzYDM
 7VpQhWYhO+1BMaco25ctUM5gwruzfFOCXbJQ9azApLJYJGOKMajnp9QBfyfBahTXWa91
 ILhIaWAUlAfbsiM+o5D8f2q0yF0aZ05KF7xTaFavBW/te8sPVEEnTd4PXl4lGd2TAyze
 iwZUMj2jKBZIn/Yybsig/nEsWy+tk/FgmlItmMqJdcoHNc4lvQhCXU292DTsu/lxDtmf
 ol6CbzbvjdlbLNXyhoRHGSgvT8izif93VPwDfs7Nwh88eo3IZQ0vQiYklreYG5H414Iz
 Ul5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZBdVO5eZb3wz/9iXmHsttBqI6bHSLb2AKfqKHTGuDry4cqpP5s/jYYtF41BvciRrC0TNGPXMXBBbNwS6CqUgLaf9h+T0=
X-Gm-Message-State: AOJu0YxVfnlp9k/ZHqltnBbfmSt64XPNKkwWwKHI8LOTqAY4+Cg4yL0V
 mycYkfKFzIIAav/2q7HjVOSVFzpqBSpwF7T58GAySxF2C9Kmunezn/u6NSGbS3ZVVbPY4cMtyMk
 m0GC5OhqOnewm4A5O61/Jof9fPWfKjn8RHPAtiTmroFUqecxSpsdx
X-Received: by 2002:a05:620a:44d1:b0:79d:90e0:1a7b with SMTP id
 af79cd13be357-79d90e01b5dmr66813285a.76.1719830592560; 
 Mon, 01 Jul 2024 03:43:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLwsi1LHxtgCLJjXexRSufURQ52mEMZIrD1Q5lVN9eFAi64S1NyToU7M/qFa/S+tGSu63rUg==
X-Received: by 2002:a05:620a:44d1:b0:79d:90e0:1a7b with SMTP id
 af79cd13be357-79d90e01b5dmr66812585a.76.1719830592252; 
 Mon, 01 Jul 2024 03:43:12 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-79d6927a81dsm335552485a.31.2024.07.01.03.43.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jul 2024 03:43:11 -0700 (PDT)
Message-ID: <cc971942-5eca-47ce-88b0-f2d72ca616d1@redhat.com>
Date: Mon, 1 Jul 2024 12:43:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio-iommu: Clear IOMMUDevice when VFIO device is
 unplugged
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>
References: <20240701101453.203985-1-clg@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240701101453.203985-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Cédric,

On 7/1/24 12:14, Cédric Le Goater wrote:
> When a VFIO device is hoplugged in a VM using virtio-iommu, IOMMUPciBus
> and IOMMUDevice cache entries are created in the .get_address_space()
> handler of the machine IOMMU device. However, these entries are never
> destroyed, not even when the VFIO device is detached from the machine.
> This can lead to an assert if the device is reattached again.
>
> When reattached, the .get_address_space() handler reuses an
> IOMMUDevice entry allocated when the VFIO device was first attached.
> virtio_iommu_set_host_iova_ranges() is called later on from the
> .set_iommu_device() handler an fails with an assert on 'probe_done'
> because the device appears to have been already probed when this is
> not the case.
This patch fixes the assert on hotplug/hotunplug/hotplug which is
definitively needed.

However the deallocation issue also exists for other devices (for
instance a virtio-net device) where
pbdev[devfn] is also leaked. I see Intel IOMMU uses a hash table
indexeed by both the bus and devfn. This would allow to avoid leaking
devfns on unrealize. I think we need that change both on virtio-iommu
and smmu.

Besides you could imagine to unplug a virtio-net device and plug a vfio
device on same BDF. In such as case unplugging the virtio-net device
won't deallocate the IOMMUDevice and the first device will be leaked. In
mid term we really would need something symetrical to the
get_address_space but it is unclear to me where we should call it.
Michael, do you have any advice?

Thanks

Eric
>
> The IOMMUDevice entry is allocated in pci_device_iommu_address_space()
> called from under vfio_realize(), the VFIO PCI realize handler. Since
> pci_device_unset_iommu_device() is called from vfio_exitfn(), a sub
> function of the PCIDevice unrealize() handler, it seems that the
> .unset_iommu_device() handler is the best place to release resources
> allocated at realize time. Clear the IOMMUDevice cache entry there to
> fix hotplug.
>
> Fixes: 817ef10da23c ("virtio-iommu: Implement set|unset]_iommu_device() callbacks")
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>  hw/virtio/virtio-iommu.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
> index 72011d2d11ebf1da343b5924f5514ccfe6b2580d..57f53f0fa79cb34bfb75f80bcb9301b523b2a6ab 100644
> --- a/hw/virtio/virtio-iommu.c
> +++ b/hw/virtio/virtio-iommu.c
> @@ -467,6 +467,26 @@ static AddressSpace *virtio_iommu_find_add_as(PCIBus *bus, void *opaque,
>      return &sdev->as;
>  }
>  
> +static void virtio_iommu_device_clear(VirtIOIOMMU *s, PCIBus *bus, int devfn)
> +{
> +    IOMMUPciBus *sbus = g_hash_table_lookup(s->as_by_busptr, bus);
> +    IOMMUDevice *sdev;
> +
> +    if (!sbus) {
> +        return;
> +    }
> +
> +    sdev = sbus->pbdev[devfn];
> +    if (!sdev) {
> +        return;
> +    }
> +
> +    g_list_free_full(sdev->resv_regions, g_free);
> +    sdev->resv_regions = NULL;
I am not sure the above is requested
> +    g_free(sdev);
> +    sbus->pbdev[devfn] = NULL;
> +}
> +
>  static gboolean hiod_equal(gconstpointer v1, gconstpointer v2)
>  {
>      const struct hiod_key *key1 = v1;
> @@ -708,6 +728,7 @@ virtio_iommu_unset_iommu_device(PCIBus *bus, void *opaque, int devfn)
>      }
>  
>      g_hash_table_remove(viommu->host_iommu_devices, &key);
> +    virtio_iommu_device_clear(viommu, bus, devfn);
>  }
>  
>  static const PCIIOMMUOps virtio_iommu_ops = {


