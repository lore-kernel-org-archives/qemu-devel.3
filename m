Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A3EFCA1015
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Sep 2025 08:16:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuRbB-0007OS-As; Fri, 05 Sep 2025 04:15:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uuRb9-0007Nv-HV
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 04:15:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uuRb3-0006gb-2D
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 04:15:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757060096;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O+PayS1R6yjytuFedY16fNFmPZjDAWgR7JOATbu6l5k=;
 b=G4VWmkJBkVwkkn08SSziQ22Fg1LCYFQX6SNSs1S0HLn5x4K2p75IzYAJd6ilp8avncfbLj
 9jh36IptMOvX5CTqmVZhB4ZOD0LTAFrOQlwhynie1cWDznRWb5kh+5sxkpP8mTAOuaIe+X
 qcz42BdhcmNXm8d6IrgVJrdSes/bAaQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-SOQY8uH9NIObIWt74yb95A-1; Fri, 05 Sep 2025 04:14:54 -0400
X-MC-Unique: SOQY8uH9NIObIWt74yb95A-1
X-Mimecast-MFC-AGG-ID: SOQY8uH9NIObIWt74yb95A_1757060094
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45b9ca27a11so13224095e9.1
 for <qemu-devel@nongnu.org>; Fri, 05 Sep 2025 01:14:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757060093; x=1757664893;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O+PayS1R6yjytuFedY16fNFmPZjDAWgR7JOATbu6l5k=;
 b=QhGzQ03urbs+aVp5H4qeULnUmnFBvjEAT8oI7jHO5OEs+Ab0tzt027rNkYrm1Yw5cD
 d0ubBHoHhDT+S4GoPzuhndMvppwJ52buo5t+g+MbXd4cQokpe46nijCRBL9n4SYig7xe
 vu4VyURfhkU0k/FCJfr1skb+mdlkYw0g83NppbsWrQFrRIOZ66mFMGbwRKqR0NbQ0QFK
 4Twwea8+cMe2NUSuEukE9OH9zwRrYmslTV+/S/I8Q6Ci1iLE8RvkCjY6TozR+abmZCQT
 jaDMywyU+oTzSlPyZ0yXZUFHkoFSFFkcUkKRgwMYaKo/82OjOmx7OoSqiI/Won2cL9Xx
 VAVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyKyCHv/KLiLIt+Oat1sOqZsuxBXwJlc2v755LR4Z+Reamlqr8k1ylxrHTPFw2O/vqMpEV07CQ6R73@nongnu.org
X-Gm-Message-State: AOJu0YzdT4HFrvqKG6smI5fXH9k9FBrtqFaGUMEZoxVwgjvzmgrewb+t
 JS1uuxfzbUw4ETGG0lISzrAzLNX2eHnSfvMDG7Apw+ihqHQE8HXPaxBEi8dzwQGZvJgquOc8Md3
 Q+16CwTNpqHYzNFyZ1TBsSubxDIW8rDVzR8Lk5hSUSllERT7HUPPCAZhU
X-Gm-Gg: ASbGncscQzpga11WIZlKJfxks/ri3CxOJbA483rHhvsAUSbKlIZWY2PszLiow2RL7aE
 Wx8p1kqrhRgf+l9JIMEYOhoLjH1kRh2fLB4ltstTVkG0/1MP1eR7XBh9rJxSUi0oQ/oHw3MLo7D
 dPhVsDs39kLUUqkg257bVqJ2k68PBc+oAv8WxZocxUOdiyX/W65F79FPnFReVm0wdXv1ngoA1vr
 r1Db+S2ZrmLciUFBSWiT5kYEWTNTi2zO2yVyFrOH+G4RLtSvLgE3cUSK+gd9RULhV5ck4DckYg4
 FYGVv5UmACddT2sX9QX6FCf1vxE7N9ZO8MBW2yBtdXNf45tyruL3LqQ6PZrZ1RHcxWYxXt6I7W6
 YX1QcfjoG94E=
X-Received: by 2002:a05:600c:888a:b0:45b:7510:4042 with SMTP id
 5b1f17b1804b1-45dd5b8d545mr16660845e9.17.1757060093506; 
 Fri, 05 Sep 2025 01:14:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsbVNCMzcqnzfswLXtF5t6yImXwxOHAc9jnhfVXGiWWaAlAAyCZ9rf4rdXDGa4Lbuy0tMdEg==
X-Received: by 2002:a05:600c:888a:b0:45b:7510:4042 with SMTP id
 5b1f17b1804b1-45dd5b8d545mr16660505e9.17.1757060093014; 
 Fri, 05 Sep 2025 01:14:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3df4fd372ccsm8588342f8f.32.2025.09.05.01.14.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Sep 2025 01:14:52 -0700 (PDT)
Message-ID: <f0b2123a-f7cb-42bf-a7b0-ba326149fcf4@redhat.com>
Date: Fri, 5 Sep 2025 10:14:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 06/15] hw/arm/smmuv3-accel: Restrict accelerated
 SMMUv3 to vfio-pci endpoints with iommufd
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 Nicolin Chen <nicolinc@nvidia.com>, skolothumtho@nvidia.com
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>,
 "nathanc@nvidia.com" <nathanc@nvidia.com>,
 "mochs@nvidia.com" <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>,
 "linuxarm@huawei.com" <linuxarm@huawei.com>,
 "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "shameerkolothum@gmail.com" <shameerkolothum@gmail.com>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-7-shameerali.kolothum.thodi@huawei.com>
 <IA3PR11MB9136A660E9FAE540037986FB9257A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <aHaW9IpjbaVcRUpA@Asurada-Nvidia>
 <IA3PR11MB9136E0D793F99E3837D208229256A@IA3PR11MB9136.namprd11.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <IA3PR11MB9136E0D793F99E3837D208229256A@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Hi,

On 7/16/25 8:26 AM, Duan, Zhenzhong wrote:
>
>> -----Original Message-----
>> From: Nicolin Chen <nicolinc@nvidia.com>
>> Subject: Re: [RFC PATCH v3 06/15] hw/arm/smmuv3-accel: Restrict
>> accelerated SMMUv3 to vfio-pci endpoints with iommufd
>>
>> On Tue, Jul 15, 2025 at 10:53:50AM +0000, Duan, Zhenzhong wrote:
>>>
>>>> -----Original Message-----
>>>> From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
>>>> Subject: [RFC PATCH v3 06/15] hw/arm/smmuv3-accel: Restrict
>> accelerated
>>>> SMMUv3 to vfio-pci endpoints with iommufd
>>>>
>>>> Accelerated SMMUv3 is only useful when the device can take advantage of
>>>> the host's SMMUv3 in nested mode. To keep things simple and correct, we
>>>> only allow this feature for vfio-pci endpoint devices that use the iommufd
>>>> backend. We also allow non-endpoint emulated devices like PCI bridges
>> and
>>>> root ports, so that users can plug in these vfio-pci devices.
>>>>
>>>> Another reason for this limit is to avoid problems with IOTLB
>>>> invalidations. Some commands (e.g., CMD_TLBI_NH_ASID) lack an
>> associated
>>>> SID, making it difficult to trace the originating device. If we allowed
>>>> emulated endpoint devices, QEMU would have to invalidate both its own
>>>> software IOTLB and the host's hardware IOTLB, which could slow things
>>>> down.
>>>>
>>>> Since vfio-pci devices in nested mode rely on the host SMMUv3's nested
>>>> translation (S1+S2), their get_address_space() callback must return the
>>>> system address space to enable correct S2 mappings of guest RAM.
>>>>
>>>> So in short:
>>>> - vfio-pci devices return the system address space
>>>> - bridges and root ports return the IOMMU address space
>>>>
>>>> Note: On ARM, MSI doorbell addresses are also translated via SMMUv3.
>>> So the translation result is a doorbell addr(gpa) for guest?
>>> IIUC, there should be a mapping between guest doorbell addr(gpa) to host
>>> doorbell addr(hpa) in stage2 page table? Where is this mapping setup?
>> Yes and yes.
>>
>> On ARM, MSI is behind IOMMU. When 2-stage translation is enabled,
>> it goes through two stages as you understood.
>>
>> There are a few ways to implement this, though the current kernel
>> only supports one solution, which is a hard-coded RMR (reserved
>> memory region).
>>
>> The solution sets up a RMR region in the ACPI's IORT, which maps
>> the stage1 linearly, i.e. gIOVA=gPA.
>>
>> The gPA=>hPA mappings in the stage-2 are done by the kernel that
>> polls an IOMMU_RESV_SW_MSI region defined in the kernel driver.
>>
>> It's not the ideal solution, but it's the simplest to implement.
>>
>> There are other ways to support this like a true 2-stage mapping
>> but they are still on the way.
>>
>> For more details, please refer to this:
>> https://lore.kernel.org/all/cover.1740014950.git.nicolinc@nvidia.com/
> Thanks for the link, it helps much for understanding arm smmu arch.
>
>>>> +static bool smmuv3_accel_pdev_allowed(PCIDevice *pdev, bool
>> *vfio_pci)
>>>> +{
>>>> +
>>>> +    if (object_dynamic_cast(OBJECT(pdev), TYPE_PCI_BRIDGE) ||
>>>> +        object_dynamic_cast(OBJECT(pdev), "pxb-pcie") ||
>>>> +        object_dynamic_cast(OBJECT(pdev), "gpex-root")) {
>>>> +        return true;
>>>> +    } else if ((object_dynamic_cast(OBJECT(pdev), TYPE_VFIO_PCI) &&
>>>> +        object_property_find(OBJECT(pdev), "iommufd"))) {
>>> Will this always return true?
>> It won't if a vfio-pci device doesn't have the "iommufd" property?
> IIUC, iommufd property is always there, just value not filled for legacy container case.
> What about checking VFIOPCIDevice.vbasedev.iommufd?
>
>>>> +        *vfio_pci = true;
>>>> +        return true;
>>>> +    }
>>>> +    return false;
>> Then, it returns "false" here.
>>
>>>> static AddressSpace *smmuv3_accel_find_add_as(PCIBus *bus, void
>>>> *opaque,
>>>>                                               int devfn)
>>>> {
>>>> +    PCIDevice *pdev = pci_find_device(bus, pci_bus_num(bus), devfn);
>>>>     SMMUState *bs = opaque;
>>>> +    bool vfio_pci = false;
>>>>     SMMUPciBus *sbus;
>>>>     SMMUv3AccelDevice *accel_dev;
>>>>     SMMUDevice *sdev;
>>>>
>>>> +    if (pdev && !smmuv3_accel_pdev_allowed(pdev, &vfio_pci)) {
>>>> +        error_report("Device(%s) not allowed. Only PCIe root complex
>>>> devices "
>>>> +                     "or PCI bridge devices or vfio-pci endpoint
>> devices
>>>> with "
>>>> +                     "iommufd as backend is allowed with
>>>> arm-smmuv3,accel=on",
>>>> +                     pdev->name);
>>>> +        exit(1);
>>> Seems aggressive for a hotplug, could we fail hotplug instead of kill QEMU?
>> Hotplug will unlikely be supported well, as it would introduce
>> too much complication.
>>
>> With iommufd, a vIOMMU object is allocated per device (vfio). If
>> the device fd (cdev) is not yet given to the QEMU. It isn't able
>> to allocate a vIOMMU object when creating a VM.
>>
>> While a vIOMMU object can be allocated at a later stage once the
>> device is hotplugged. But things like IORT mappings aren't able
>> to get refreshed since the OS is likely already booted. Even an
>> IOMMU capability sync via the hw_info ioctl will be difficult to
>> do at the runtime post the guest iommu driver's initialization.
>>
>> I am not 100% sure. But I think Intel model could have a similar
>> problem if the guest boots with zero cold-plugged device and then
>> hot-plugs a PASID-capable device at the runtime, when the guest-
>> level IOMMU driver is already inited?
> For vtd we define a property for each capability we care about.
> When hotplug a device, we get hw_info through ioctl and compare
> host's capability with virtual vtd's property setting, if incompatible,
> we fail the hotplug.
>
> In old implementation we sync host iommu caps into virtual vtd's cap,
> but that's Naked by maintainer. The suggested way is to define property
> for each capability we care and do compatibility check.
>
> There is a "pasid" property in virtual vtd, only when it's true, the PASID-capable
> device can work with pasid.
>
> Zhenzhong

I don't think this is an option not to support hotplug. I agree with
Zhenzhong, we shall try to align with the way it is done on intel-iommu
and study whether it also fits the needs for accelerated smmu.

Thanks

Eric
>
>> FWIW, Shameer's cover-letter has the following line:
>> "At least one vfio-pci device must currently be cold-plugged to
>>  a PCIe root complex associated with arm-smmuv3,accel=on."
>>
>> Perhaps there should be a similar highlight in this smmuv3-accel
>> file as well (@Shameer).
>>
>> Nicolin


