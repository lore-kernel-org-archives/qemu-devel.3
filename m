Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A23BC3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 15:00:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTjeJ-00061k-Ep; Tue, 16 Jul 2024 10:59:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sTjeH-0005sY-2S
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 10:59:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sTjeE-0007Ai-IH
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 10:59:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721141961;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S1PxolepRSOrb2n2US5yhZ+v8cjPWcxydv/e3e2gsfg=;
 b=I+y+T/HSinX2+tstBE6QM332bDSlaAjEBC2PNkCIDIL41k2i++fDw2OmLwrT2+7sY/7+FQ
 hM7Gdi/d+5Of3XPYQzuW8RnkyBHQeSsfgp7foYYZWiMMwOMkLy4Bejb+LVVyu27C1Fw3Cy
 YDtWRfOQnLjP3kPatDj9L2Qap754aPc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-wvf5uRbWN6iJyYr0vG3Img-1; Tue, 16 Jul 2024 10:59:18 -0400
X-MC-Unique: wvf5uRbWN6iJyYr0vG3Img-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42667cc80e8so40101605e9.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 07:59:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721141957; x=1721746757;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S1PxolepRSOrb2n2US5yhZ+v8cjPWcxydv/e3e2gsfg=;
 b=IOx0htD0MY+tnsRf/VE3DS9/XLHC5gqZusznx0tstAkAG0Yr5adUHh/ECvyLhP5lT7
 flydheMXrSUJUHHNYxu3OGs7vhXnZlCp01zebE3Ddl9KePER8Hq8jdCdmeIKfVfVXayG
 VUidcd9g52wyQNzOYuxd1hqr+aCc78XX6/5T8x+6Yly8qfpVU0u74fsbPqLYZh+66igm
 nMciBmMM5zkxh+Yi87pUpclFBNEn9Dyk8jTycoZn17zyRDFJRqC/lJCGzZhiXCZ+nW0b
 JAXB3ZehWUoe9Wlds+VSamx8aalBORXjzZmXRZGRkWnZCQkbvLBSPV/2IB6sBz23jWEv
 v93g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVo0xUrMRvVQNFPbVO1OPHpVpidGcNMSQesu5vng4wDuoKzUaQjjYrSSvN97xOFatVrr7MSK+Y6U7kBXyb0jX9G/tU1PTM=
X-Gm-Message-State: AOJu0YwfgzoJX8i6KWt/zVxtnGX+9gRLBWs8v7L/KYjb2dsNOwQXLBUe
 PCoIjnbs59Gr6Lf4pSliTqmOPrp8tYA+/cuO2yCLmarrb9IkXPuPs/QHKIeyD+HhXpsuzYC1iXN
 ifwlb7tq1o7V8xTeYJQy5i5VFJehUlYS2DkyD2qbsqll7EjHAVI6m
X-Received: by 2002:a05:600c:4f4d:b0:426:6f31:a605 with SMTP id
 5b1f17b1804b1-427ba64599fmr18891105e9.17.1721141957444; 
 Tue, 16 Jul 2024 07:59:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGVsCu1EKInsOLeUFMHgwraVarKlZvjbJTvFad3RUWeAskgXPWtPSnHMAdALnRCZgZMCkmZQ==
X-Received: by 2002:a05:600c:4f4d:b0:426:6f31:a605 with SMTP id
 5b1f17b1804b1-427ba64599fmr18890945e9.17.1721141957087; 
 Tue, 16 Jul 2024 07:59:17 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dabf02csm9252330f8f.41.2024.07.16.07.59.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jul 2024 07:59:16 -0700 (PDT)
Message-ID: <8a642d1e-0ae1-431e-91de-654e717c6894@redhat.com>
Date: Tue, 16 Jul 2024 16:59:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] VIRTIO-IOMMU/VFIO: Revert IOMMUDevice clear and fix
 hotunplug
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 mst@redhat.com, jean-philippe@linaro.org, peter.maydell@linaro.org,
 zhenzhong.duan@intel.com, alex.williamson@redhat.com, jasowang@redhat.com
Cc: yanghliu@redhat.com
References: <20240716094619.1713905-1-eric.auger@redhat.com>
 <5f64db5d-7690-4d18-8c31-cfe8e2083f5f@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <5f64db5d-7690-4d18-8c31-cfe8e2083f5f@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 7/16/24 16:02, Cédric Le Goater wrote:
> On 7/16/24 11:45, Eric Auger wrote:
>> 1b889d6e39c3 ("virtio-iommu: Clear IOMMUDevice when VFIO
>> device is unplugged" fixes the VFIO hotplug/hotunplug/hotplug
>> sequence by clearing the IOMMUDevice which backs the VFIO device.
>> However this brings other troubles such as a memory corruption.
>>
>> Even when fixing some cleanups that were missed on the first
>> attempt the memory corruption still exists if the IOMMUDevice is
>> freed. Until we understand the exact cause let's make things simpler:
>> let the backing IOMMUDevice survive the unplug as what is done
>> on intel iommu for instance. Clean up/reset resources that would
>> prevent the device from being hotplugged again (probe_done is removed,
>> [host_]resv_regions are reset). By doing this we also rule out the
>> use case of aliased BDFs which is known to be not functional with
>> virtio-iommu (missing guest kernel support) and the virtio-iommu device
>> implementation is not ready either.
>>
>> This series can be found at:
>> https://github.com/eauger/qemu/tree/virtio_iommu_device_clear_fixes_v1
>>
>>
>> Eric Auger (6):
>>    Revert "virtio-iommu: Clear IOMMUDevice when VFIO device is
>> unplugged"
>>    virtio-iommu: Remove probe_done
>>    virtio-iommu: Free [host_]resv_ranges on unset_iommu_devices
>>    virtio-iommu: Remove the end point on detach
>>    hw/vfio/common: Add vfio_listener_region_del_iommu trace event
>>    virtio-iommu: Add trace point on
>>      virtio_iommu_detach_endpoint_from_domain
>>
>>   include/hw/virtio/virtio-iommu.h |  1 -
>>   hw/vfio/common.c                 |  3 +-
>>   hw/virtio/virtio-iommu.c         | 88 +++++++++++---------------------
>>   hw/vfio/trace-events             |  3 +-
>>   hw/virtio/trace-events           |  1 +
>>   5 files changed, 35 insertions(+), 61 deletions(-)
>>
>
>
> Tested-by: Cédric Le Goater <clg@redhat.com>
>
> with a vfio-pci device (mlx5 VF) and a virtio-net-pci device.

Many Thanks!

Eric
>
> Thanks,
>
> C.
>


