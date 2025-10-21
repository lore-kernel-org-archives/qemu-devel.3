Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EA5ACCD1A7
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 16:17:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBF2j-0006ee-6a; Tue, 21 Oct 2025 12:17:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vBF2Y-0006FK-PF
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 12:16:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vBF2V-00020I-H9
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 12:16:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761063400;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gUfxbCJU0O58X9kYLTKNd/jDB9XXAb8h/+FGLLp0ww4=;
 b=bMfNyXXOyS6/8U3Z4Z0Wid06TVsP5nFKDT3ifMQi4qRVnUoUyCXM8hiYFDyEYESDrRYn3i
 u41Ew+Bh2Lo4yo/uoeBjeBV1sre0K5FSPajl09JfISC8tHSS95SmQ3wNnjYG6lW21C/Btb
 UIAUgjLBWZgThDDDIoWSGYTZu7QXCDI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-wIW9cJKHMKeM4KJ6Vke0vA-1; Tue, 21 Oct 2025 12:16:38 -0400
X-MC-Unique: wIW9cJKHMKeM4KJ6Vke0vA-1
X-Mimecast-MFC-AGG-ID: wIW9cJKHMKeM4KJ6Vke0vA_1761063398
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-46e4cb3e4deso186855e9.1
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 09:16:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761063397; x=1761668197;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gUfxbCJU0O58X9kYLTKNd/jDB9XXAb8h/+FGLLp0ww4=;
 b=eYT1i/4moaa9HxTj0JYgjbuMeG39YDpmHsVKZ5jTR222A5GQk/PY8/11OW3tesrRxZ
 HHY9w+UrohBAyqftOTHLY49phxkHRNjFYt6KZMvRRIDJUGTlB+D3YiJpL7dh8RfJSyxh
 AileLvlaKNAk4s3tT7tYJLA3mqG84Z/OYkorE4F9ptyNGlx7sAMzeYJO71rHzS2+OvoG
 Lz0junFifym0nKc8gagVOSE9gnVy1OQ8e6noAtVwSccZReASoQ46tuRJTQUdgYaQ7wEg
 vn7N41X3h7D5/5gNsQoG6A62caMVH10VzIXbYstXFXuNXBkSBxdQOGU0gpZ7p4o0ka1q
 mfrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkkUBrPUbt+3zflwsI3d4gEQxmNsEWmuTlYA7EqBJMQbssbbK84e5XDGOF4l6A3uolLIj6wXEq7yaM@nongnu.org
X-Gm-Message-State: AOJu0Yy5S7FPhf6/VbXzuxrWbqxns1w/KedyVs4BPnqmXLpRSc40rUPw
 t8fiJpZmkgFXuSYElUC65z+NyPwOkaEFaknD66HXp4Qlrc4uCWeDommKTL8ielYKQhY7D7Sw421
 eHiUPIlDTkCjvwS28YBhk3weYDg4arjC9UA8mv/LLVzujLZoKmr4/bKO8
X-Gm-Gg: ASbGncv9yuM7efYhzXgkA2wnqISvBe/jw1MsC0GaLIc7mi4E/xDXrs5eIVr98z6NM6/
 XnFq/zBYBTFRpTlNA4nwuBjgje0Ef3mgw/UQ9Sc3+URQkh0yawTNAZa9GdbFT/kbPUJVdIKusu+
 +yYkRUjYRS4EMS+82UGoQLqoqJU87yusmdPMmsixkx60cxYbSpbTARuac+J7W4baAFtjp99/Bb1
 uxEVA9p/JtYQTxhsFrdfuIG/A77MISWwyLt0b6NLEx6RYaoEw7aNggjeYR3BRAEiUCbUKIP6I9d
 1Co7GBqFT2Hfkyt1fz6xSx+jrgtin40SdiuAPaJqgVLhgXaaSA3kF7uDVPVDan+NpFtTKbHsrz3
 rKJnG
X-Received: by 2002:a05:600c:468b:b0:45b:92a6:63e3 with SMTP id
 5b1f17b1804b1-475c3eaf656mr2128635e9.9.1761063397476; 
 Tue, 21 Oct 2025 09:16:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEqUF2Nl1eabLNJoukdEvoP9IAE9TrACLu+/Cjiv5t5AUKxzkiuEZId+H1bpbkJZ2FzpyLKA==
X-Received: by 2002:a05:600c:468b:b0:45b:92a6:63e3 with SMTP id
 5b1f17b1804b1-475c3eaf656mr2128225e9.9.1761063396972; 
 Tue, 21 Oct 2025 09:16:36 -0700 (PDT)
Received: from [192.168.43.95] ([78.245.103.33])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c427ed3fsm246295e9.1.2025.10.21.09.16.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Oct 2025 09:16:36 -0700 (PDT)
Message-ID: <a6beff3c-f704-4e0e-9ae9-c8c150845fa0@redhat.com>
Date: Tue, 21 Oct 2025 18:16:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/27] hw/arm/smmuv3-accel: Make use of
 get_msi_address_space() callback
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>,
 "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "shameerkolothum@gmail.com" <shameerkolothum@gmail.com>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-13-skolothumtho@nvidia.com>
 <8ce5574e-3e31-456c-9579-0fbf8526651f@redhat.com>
 <CH3PR12MB754810AE8D308630041F9AFEABF2A@CH3PR12MB7548.namprd12.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CH3PR12MB754810AE8D308630041F9AFEABF2A@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 10/21/25 10:15 AM, Shameer Kolothum wrote:
> Hi Eric,
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Sent: 20 October 2025 17:44
>> To: Shameer Kolothum <skolothumtho@nvidia.com>; qemu-
>> arm@nongnu.org; qemu-devel@nongnu.org
>> Cc: peter.maydell@linaro.org; Jason Gunthorpe <jgg@nvidia.com>; Nicolin
>> Chen <nicolinc@nvidia.com>; ddutile@redhat.com; berrange@redhat.com;
>> Nathan Chen <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>;
>> smostafa@google.com; wangzhou1@hisilicon.com;
>> jiangkunkun@huawei.com; jonathan.cameron@huawei.com;
>> zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; yi.l.liu@intel.com;
>> shameerkolothum@gmail.com
>> Subject: Re: [PATCH v4 12/27] hw/arm/smmuv3-accel: Make use of
>> get_msi_address_space() callback
>>
>> External email: Use caution opening links or attachments
>>
>>
>> Hi Shameer,
>>
>> On 9/29/25 3:36 PM, Shameer Kolothum wrote:
>>> Here we return the IOMMU address space if the device has S1 translation
>>> enabled by Guest. Otherwise return system address space.
>>>
>>> Signed-off-by: Shameer Kolothum
>> <shameerali.kolothum.thodi@huawei.com>
>>> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
>>> ---
>>>  hw/arm/smmuv3-accel.c | 21 +++++++++++++++++++++
>>>  1 file changed, 21 insertions(+)
>>>
>>> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
>>> index 790887ac31..f4e01fba6d 100644
>>> --- a/hw/arm/smmuv3-accel.c
>>> +++ b/hw/arm/smmuv3-accel.c
>>> @@ -387,6 +387,26 @@ static void
>> smmuv3_accel_unset_iommu_device(PCIBus *bus, void *opaque,
>>>      }
>>>  }
>>>
>>> +static AddressSpace *smmuv3_accel_find_msi_as(PCIBus *bus, void
>> *opaque,
>>> +                                              int devfn)
>>> +{
>>> +    SMMUState *bs = opaque;
>>> +    SMMUPciBus *sbus = smmu_get_sbus(bs, bus);
>>> +    SMMUv3AccelDevice *accel_dev = smmuv3_accel_get_dev(bs, sbus,
>> bus, devfn);
>>> +    SMMUDevice *sdev = &accel_dev->sdev;
>>> +
>>> +    /*
>>> +     * If the assigned vfio-pci dev has S1 translation enabled by
>>> +     * Guest, return IOMMU address space for MSI translation.
>>> +     * Otherwise, return system address space.
>>> +     */
>>> +    if (accel_dev->s1_hwpt) {
>>> +        return &sdev->as;
>>> +    } else {
>>> +        return &address_space_memory;
>>> +    }
>> At the moment I don't understand this code either. In case of emulated
>> device it then returns address_space_memory whereas I would have
>> expected the opposite. I definitively need to trace things ;-)
Thank you for the traces!
> We have,
> [VIRT_GIC_ITS] =            { 0x08080000, 0x00020000 },
>
> I added a few prints in kvm_arch_fixup_msi_route() so that it may help
> to understand how the translation of MSI doorbell is performed here.
>
> If we return IOMMU addr space(&sdev->as) here,
>
> kvm_arch_fixup_msi_route: MSI IOVA=0xffbf0040 msi_addr_lo=0xffbf0040 msi_addr_hi=0x0
so this gIOVA
> kvm_arch_fixup_msi_route: Translated doorbell_gpa= 0x8090040
> kvm_arch_fixup_msi_route: ret:MSI IOVA=0xffbf0040 translated: msi_addr_lo=0x8090040 msi_addr_hi=0x0
>
> It gets the correct vITS gpA address after the translation through address_space_translate().
I agree it needs to be translated into the vITS doorbell reg.
>
> Since host uses the (MSI_IOVA_BASE, MSI_IOVA_LENGTH) for ITS doorbell mapping 
> and using IORT RMR we make sure there is an identity mapping for that range, it all
> works fine.
>
> Now, suppose if we return system addr space(&address_space_memory):
>
> kvm_arch_fixup_msi_route: MSI IOVA=0xffbf0040 msi_addr_lo 0xffbf0040 msi_addr_hi 0x0
> kvm_arch_fixup_msi_route:  address_space_memory, nothing to do, return
>
> And the device doorbell gets configured with gIOVA 0xffbf0040 instead of the vITS gPA
> as Nicolin explained in the other thread.
I agree that for MSI support you must remy on the IOMMU MR translate
function, even for VFIO devices.

Thanks

Eric
>
> Hope this helps.
>
> Thanks,
> Shameer
>


