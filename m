Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3DC1C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 12:53:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOGWl-0005dR-HD; Mon, 01 Jul 2024 08:53:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sOGWj-0005Xi-Kh
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 08:53:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sOGWa-0004Jw-3O
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 08:52:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719838370;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ER2n8XX+rdi/HN6MIOTYblKrQNJlgAzXsR/KkKAodwI=;
 b=QhewCxKzt4yXbgo1sA1tbg18srtYJpv8RFexob+JAIjOdVZcDi5hhUq8SvznvSFJjOmUI5
 U/E0guzhJFcSvkCss8lkWgE5CwpB4/JM+g7I/Kay4Yas3YAY0oxShK9yR+zvSfHxwO+vt7
 0YMMJzcUl3ArR3nnB37kTbrDT1yZjkI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-2W0w0PpsPDSpxsgEDZbN_A-1; Mon, 01 Jul 2024 08:52:49 -0400
X-MC-Unique: 2W0w0PpsPDSpxsgEDZbN_A-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6b50a228363so37425116d6.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 05:52:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719838368; x=1720443168;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ER2n8XX+rdi/HN6MIOTYblKrQNJlgAzXsR/KkKAodwI=;
 b=fnrN3ISRb/VG5gCKvWW1NMr7iMpZAjTCb03Cmc0KixEZFXQiZVABkC5UavnZLpHjOS
 vOnCirckw2nZVxWrddnmARxj/uF6hZUr7bFD2U3HC5W7x3vzLS/Ve4223PN0cPaCBKnR
 csJTtI3QvltG9arVcLd8fe2m3mNrhUSJOWlMsBj6lvQreneJv/zh8zZSI2m5w60moQSq
 CYApMYHEoPojNJ+p79OkRvghJGXqDameYmqhuCA4v1xcKnpK8txlmQulgGbONEIz5iIk
 Vqif2blvWvKoVpxIjaFjDzbHN4gPwZqgZPknQ8cCutwu1C9szI0dyzvAepw0DWFJBUF+
 tqbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfjekhfB5iUh3IZ2cBFd8e11XP1xg5Haza0IwETmoDjGRW8HnhIsVvOO4vUl8IyqwxMJqIIjJJh5X6XALTLkqEMiencM0=
X-Gm-Message-State: AOJu0YzWwidy6fGt0eZ3fZOCW8zl5PhcT05fSuAcXQxkveglHrNQ6Vo6
 dQJPW32jnZ818yzljrHXBY5x4bsYRnen2rAMKRKR8OiPrSqxzlB9SH71uhugSICIJCP1E3Zq3G+
 QUwUFfVE1iQCW8wayISUqG76JXOxxbJb2sFs4iZn8rkyqtN7ggP8+
X-Received: by 2002:ad4:4ee5:0:b0:6b0:7716:e9a4 with SMTP id
 6a1803df08f44-6b5b70a8154mr66857486d6.12.1719838368640; 
 Mon, 01 Jul 2024 05:52:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHMtpGdtMk/SVMoZyrGHSrGf0eFcKnfJZZKkp7N2jd5EDussFpZeRPrp7eGMa3qGs2uChawQ==
X-Received: by 2002:ad4:4ee5:0:b0:6b0:7716:e9a4 with SMTP id
 6a1803df08f44-6b5b70a8154mr66857356d6.12.1719838368334; 
 Mon, 01 Jul 2024 05:52:48 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b5ba68d03esm18197326d6.112.2024.07.01.05.52.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jul 2024 05:52:47 -0700 (PDT)
Message-ID: <587c5ab8-0a11-42fb-883d-9c8ad8a2d232@redhat.com>
Date: Mon, 1 Jul 2024 14:52:44 +0200
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
Besides my previous general comments, I think this is a reasonable fix
to get in while implementing something better
Feel free to add my

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>


Thanks

Eric

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


