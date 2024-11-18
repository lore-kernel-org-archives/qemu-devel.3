Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E21AD49223
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 13:46:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD24p-0002Zb-4X; Mon, 18 Nov 2024 08:46:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tD24l-0002YR-Ar
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 08:46:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tD24j-00065s-2M
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 08:45:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731937555;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4aXRwMuXZA9xXLR2PBwNDTi0Od7kPErzY7NzN0KuU8c=;
 b=CdaiS87yhbnITTF/7Mwg58rOXWzu3dSRUbHaJ6K0Xl0PrfBWw3ndGc47m2J4BJFpWQMmZ8
 BkVvSOwQfcJQXMeQ8+wzREw/GgUuv9bGmwqQRbNtAwueRGGTcCj0S58Tr98BlXyzxHeGsc
 sp64bFfIbFgL+PEsEVQmN2/P/NYALDA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-dtac_isaM76n2VomqzLwKA-1; Mon, 18 Nov 2024 08:45:54 -0500
X-MC-Unique: dtac_isaM76n2VomqzLwKA-1
X-Mimecast-MFC-AGG-ID: dtac_isaM76n2VomqzLwKA
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4316655b2f1so20566155e9.0
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 05:45:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731937553; x=1732542353;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4aXRwMuXZA9xXLR2PBwNDTi0Od7kPErzY7NzN0KuU8c=;
 b=uwAOAk0iZUS93DdufeeLcO7+HMW5KszjLnTcHA1M8mtHd+K0dzSpwNHaFjksu/K7ST
 ZsGmqWtOoQoyR9l9iIOJ2ijE5InoPvNAzMRsFYv+BlQ4UgomtbVj9U1T9i+E1dK3I0h2
 UREWjdLvvkQKR6loByOEHLoR4+iCRWQEWcootdh1tUUthBrTsuBinxHbxnw5Ouu3X6Ao
 Om0i7iXfSBJAyntSa5i5934ZT7zsNu4XHYFOIAaZwQJdlHTdPFg9YGp0BEL5QtSL8Dy9
 dfa09TYGV65tFkNv3TWcVLG0R6URiNyYd8j5Ro2IySQUzNe2ZjubgPJXxdOuv7sa0W5g
 Iy3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIONqmpJpEJj4CSAthlJrMIM4e2V3IaNPUMLAEsdEUFdXGhA/fiCgHKTWM4pyMphm/VtYfKK/Yp5VH@nongnu.org
X-Gm-Message-State: AOJu0YwOOBml7CxKkHrN23fZySRficBbjfkqbp5FAtUDXPFvN64rD3mz
 O3Hu3rPlDrFeJcz9RUFXq9rzYopw5ge/pYomZDJKv0HIJ+tl55/XuJyZR5zGVdwUSQk/QZFhOjD
 B71Uv4kxuKos0UEu5f/wQH/fGR4GDErKCEZ/BY4af8yLWSFg/3CV/
X-Received: by 2002:a05:600c:5492:b0:431:5d89:646e with SMTP id
 5b1f17b1804b1-432df792df0mr91996335e9.32.1731937552982; 
 Mon, 18 Nov 2024 05:45:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHSyR4PH6PDcQ5QSVAmQRRQvdKh8qidN9xp1DJ13iZ2La9UZItbGi6K8nL5Ftpie0twUE2yXA==
X-Received: by 2002:a05:600c:5492:b0:431:5d89:646e with SMTP id
 5b1f17b1804b1-432df792df0mr91995995e9.32.1731937552676; 
 Mon, 18 Nov 2024 05:45:52 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432da28b76fsm163395515e9.28.2024.11.18.05.45.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Nov 2024 05:45:52 -0800 (PST)
Message-ID: <48bb0455-7c2e-4cc6-aa15-ebe4311d8430@redhat.com>
Date: Mon, 18 Nov 2024 14:45:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/5] hw/arm/virt-acpi-build: Build IORT with multiple
 SMMU nodes
Content-Language: en-US
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 Linuxarm <linuxarm@huawei.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>,
 jiangkunkun <jiangkunkun@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
 <20241108125242.60136-5-shameerali.kolothum.thodi@huawei.com>
 <1dcea5ca-806f-4f51-8b13-faf5d62eb086@redhat.com>
 <efb9fb7fb0f04d92b7776cdbc474585d@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <efb9fb7fb0f04d92b7776cdbc474585d@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Shameer,

On 11/18/24 12:44, Shameerali Kolothum Thodi wrote:
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Sent: Monday, November 18, 2024 10:02 AM
>> To: Shameerali Kolothum Thodi
>> <shameerali.kolothum.thodi@huawei.com>; qemu-arm@nongnu.org;
>> qemu-devel@nongnu.org
>> Cc: peter.maydell@linaro.org; jgg@nvidia.com; nicolinc@nvidia.com;
>> ddutile@redhat.com; Linuxarm <linuxarm@huawei.com>; Wangzhou (B)
>> <wangzhou1@hisilicon.com>; jiangkunkun <jiangkunkun@huawei.com>;
>> Jonathan Cameron <jonathan.cameron@huawei.com>;
>> zhangfei.gao@linaro.org
>> Subject: Re: [RFC PATCH 4/5] hw/arm/virt-acpi-build: Build IORT with
>> multiple SMMU nodes
>>
>>>      /* Number of IORT Nodes */
>>> @@ -342,10 +356,9 @@ build_iort(GArray *table_data, BIOSLinker
>> *linker, VirtMachineState *vms)
>>>      /* GIC ITS Identifier Array */
>>>      build_append_int_noprefix(table_data, 0 /* MADT translation_id */,
>> 4);
>>> -    if (vms->iommu == VIRT_IOMMU_SMMUV3) {
>>> -        int irq =  vms->irqmap[VIRT_SMMU] + ARM_SPI_BASE;
>>> +    for (i = 0; i < num_smmus; i++) {
>>> +        smmu_offset[i] = table_data->len - table.table_offset;
>>>
>> I would have expected changes in the smmu idmap has well. If a given
>> SMMU instance now protects a given bus hierarchy shouldn't it be
>> reflected in a differentiated SMMU idmap for each of them (RID subset of
>> SMMU->pci-bus mapping to a specific IORT SMMU node)? How is it done
>> currently?
> I thought that smmu_idmaps will be handled by this ?
>
> object_child_foreach_recursive(object_get_root(),
>                                        iort_host_bridges, smmu_idmaps);
to me this traverses the qemu object hierarchy to find all host bridges
and for each of them builds an idmap array (smmu_idmaps mapping this RC
RID range to this SMMU). But to me those idmaps will be assigned to
*all* SMMU insteaces leading to a wong IORT description because all
SMMUs will be protecting all devices. You shall only retain idmaps which
correspond to the pci_bus a given vSMMU is attached to. Then each SMMU
will protect a distinct PCIe subtree which does not seem the case today.
At least that's my current understanding.

Eric


>
> But it is possible that, there is a bug in this IORT generation here as I am not
> able to hot add  devices. It looks like the pciehp interrupt is not generated/received
> for some reason. Nicolin[0] is suspecting the min/max bus range in
> iort_host_bridges() may not leave enough ranges for hot add later.
>
> Cold plugging devices to different SMMUv3/pcie-pxb seems to be alright.
>
> I will debug that soon.
>
> Thanks,
> Shameer
> [0] https://lore.kernel.org/qemu-devel/ZzPd1F%2FUA2MKMbwl@Asurada-Nvidia/
>
>


