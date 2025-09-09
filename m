Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08C10CA0FED
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 13:35:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvyUe-0000Hg-3l; Tue, 09 Sep 2025 09:34:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uvyUa-00009y-Kv
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 09:34:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uvyUO-0001Vl-09
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 09:34:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757424862;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BDf2ec//Zgwk83/n5MdyJ11ZiNqCJFNVN2yHeIZeJOg=;
 b=RY9FVAWNVOjhXPby/zv5EcppENjUNnM0GYa8HGdEpVHDfLobX1Hj1Rs+lN7a7hdjJObsLJ
 /+yGL3yUk8SdQS5I1jr48TVDtRoGpgz93aBfRIZG9D/g+6TBS4Po9CxVkSh3coVB/nsl0C
 0ois7SjVAYDU7VVdFpWtc5G/m/QMbeY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-NuosV8sJP1WTTn-d_EzWcQ-1; Tue, 09 Sep 2025 09:34:21 -0400
X-MC-Unique: NuosV8sJP1WTTn-d_EzWcQ-1
X-Mimecast-MFC-AGG-ID: NuosV8sJP1WTTn-d_EzWcQ_1757424860
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3e04ea95c6cso2665247f8f.1
 for <qemu-devel@nongnu.org>; Tue, 09 Sep 2025 06:34:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757424860; x=1758029660;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BDf2ec//Zgwk83/n5MdyJ11ZiNqCJFNVN2yHeIZeJOg=;
 b=u0DIWCZqlrREZYYL1+ja4cIzAT/B5b3C6lSdBHJUOuPUn7e5eu6DBlAs5ukhYm8aKn
 FxA1lQkmTwSWOKI90v6uNCLfPrpgZXqAtl/T7yqg5y/gHFuzgrOygB9ckgsGI46s7etW
 WJc3Phw5KoYh7UjMedir/wagl/HhxorMUS2QykkL9YWf4ztaEMQvTbed7RVfpRn0doJO
 FW+mkR5kV2lbuI4gCZtSaECyG+AiVH6qI2//QJUrMAzZB3OTz+UDmCj+I3ZgvIsue0Qr
 cDo+JGYrl/e0foKYCejGMF9yAt/lBJjlh/1lBEwfUGC/bEjqkYfX6LWzrjyH+Hd10Mb3
 bQVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYyM/1tnbauuCEPb0/jsom3oHiNp5nDKgMN1SQDBf0/cB/ZMEK9vD04QYnfQdBQkU/R4ntsI1+m3+D@nongnu.org
X-Gm-Message-State: AOJu0YwAFCwS9kjidfOGsmKXQIZC2uxVRpZqJ8WjTBPNmnrzLH1+2Ayu
 VBpGrX8eRpybIT8WojuCwdq/yilwRZZO3EXqSAnva4McHrKApf9Sucyb0TLLDqXKFrq7OPca9OU
 KNWV/HbrHKzpQtbe6Jnscnus1UbPv/C+/F+hDqfI93MKLdqUwPc0HS9do
X-Gm-Gg: ASbGncuZsGVuMq1vTNMcPY6+scvOXIXcpNCtutx8kO2sYeOWrvfV824Q6xZ3ysiyL6N
 SSiVCRY0z2jaKXemlvzCriyJ/NBmXX9uoippozBwNmSCiwJJXIZvg583A3hMbB6gV1Fm9ayURsU
 FmT5ZKHX0KrMWv5AOV70FpVEMKde6DWAiJc0tPGxyLeUyuciAkt/EP1pQsTHnymL70G26Fq/+V7
 wiY8GHENRGjNjk4TEMkaqgysOkxK0V5myiGg9hSJ+kVFxTgcBxZdxzJx0Oej9qStzghfaFZfhmn
 merRefa9qVlFItFPqYPYiMh0anCr/iJ3c2Xr36Kj89VjRNI=
X-Received: by 2002:a05:6000:230e:b0:3df:7b7b:6d20 with SMTP id
 ffacd0b85a97d-3e64317d5cemr8838385f8f.27.1757424859633; 
 Tue, 09 Sep 2025 06:34:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFt1Iu6kbdPykNVdXI/8J1EXJmC/OGFK9eIc6Fl9JTvFULPp1BJR69wZRMX+EKPTtGi08qcDQ==
X-Received: by 2002:a05:6000:230e:b0:3df:7b7b:6d20 with SMTP id
 ffacd0b85a97d-3e64317d5cemr8838363f8f.27.1757424859198; 
 Tue, 09 Sep 2025 06:34:19 -0700 (PDT)
Received: from [192.168.43.95] ([37.167.152.186])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e75223885csm2682528f8f.36.2025.09.09.06.34.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Sep 2025 06:34:18 -0700 (PDT)
Message-ID: <e6c07d2e-d48b-49a2-af6c-c81fb87196ce@redhat.com>
Date: Tue, 9 Sep 2025 15:34:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 06/15] hw/arm/smmuv3-accel: Restrict accelerated
 SMMUv3 to vfio-pci endpoints with iommufd
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>,
 "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 Nicolin Chen <nicolinc@nvidia.com>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Jason Gunthorpe <jgg@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
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
 <f0b2123a-f7cb-42bf-a7b0-ba326149fcf4@redhat.com>
 <IA0PR12MB7555BC2CAE15B3D7DF216196AB0CA@IA0PR12MB7555.namprd12.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <IA0PR12MB7555BC2CAE15B3D7DF216196AB0CA@IA0PR12MB7555.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 9/8/25 9:41 AM, Shameer Kolothum wrote:
> Hi Eric,
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Sent: 05 September 2025 09:15
>> To: Duan, Zhenzhong <zhenzhong.duan@intel.com>; Nicolin Chen
>> <nicolinc@nvidia.com>; Shameer Kolothum <skolothumtho@nvidia.com>
>> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
>> peter.maydell@linaro.org; Jason Gunthorpe <jgg@nvidia.com>;
>> ddutile@redhat.com; berrange@redhat.com; Nathan Chen
>> <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>;
>> smostafa@google.com; linuxarm@huawei.com; wangzhou1@hisilicon.com;
>> jiangkunkun@huawei.com; jonathan.cameron@huawei.com;
>> zhangfei.gao@linaro.org; shameerkolothum@gmail.com
>> Subject: Re: [RFC PATCH v3 06/15] hw/arm/smmuv3-accel: Restrict accelerated
>> SMMUv3 to vfio-pci endpoints with iommufd
>>
> [..]
>>>>>> static AddressSpace *smmuv3_accel_find_add_as(PCIBus *bus, void
>>>>>> *opaque,
>>>>>>                                               int devfn)
>>>>>> {
>>>>>> +    PCIDevice *pdev = pci_find_device(bus, pci_bus_num(bus), devfn);
>>>>>>     SMMUState *bs = opaque;
>>>>>> +    bool vfio_pci = false;
>>>>>>     SMMUPciBus *sbus;
>>>>>>     SMMUv3AccelDevice *accel_dev;
>>>>>>     SMMUDevice *sdev;
>>>>>>
>>>>>> +    if (pdev && !smmuv3_accel_pdev_allowed(pdev, &vfio_pci)) {
>>>>>> +        error_report("Device(%s) not allowed. Only PCIe root complex
>>>>>> devices "
>>>>>> +                     "or PCI bridge devices or vfio-pci endpoint
>>>> devices
>>>>>> with "
>>>>>> +                     "iommufd as backend is allowed with
>>>>>> arm-smmuv3,accel=on",
>>>>>> +                     pdev->name);
>>>>>> +        exit(1);
>>>>> Seems aggressive for a hotplug, could we fail hotplug instead of kill
>> QEMU?
>>>> Hotplug will unlikely be supported well, as it would introduce
>>>> too much complication.
>>>>
>>>> With iommufd, a vIOMMU object is allocated per device (vfio). If
>>>> the device fd (cdev) is not yet given to the QEMU. It isn't able
>>>> to allocate a vIOMMU object when creating a VM.
>>>>
>>>> While a vIOMMU object can be allocated at a later stage once the
>>>> device is hotplugged. But things like IORT mappings aren't able
>>>> to get refreshed since the OS is likely already booted. Even an
>>>> IOMMU capability sync via the hw_info ioctl will be difficult to
>>>> do at the runtime post the guest iommu driver's initialization.
>>>>
>>>> I am not 100% sure. But I think Intel model could have a similar
>>>> problem if the guest boots with zero cold-plugged device and then
>>>> hot-plugs a PASID-capable device at the runtime, when the guest-
>>>> level IOMMU driver is already inited?
>>> For vtd we define a property for each capability we care about.
>>> When hotplug a device, we get hw_info through ioctl and compare
>>> host's capability with virtual vtd's property setting, if incompatible,
>>> we fail the hotplug.
>>>
>>> In old implementation we sync host iommu caps into virtual vtd's cap,
>>> but that's Naked by maintainer. The suggested way is to define property
>>> for each capability we care and do compatibility check.
>>>
>>> There is a "pasid" property in virtual vtd, only when it's true, the PASID-
>> capable
>>> device can work with pasid.
>>>
>>> Zhenzhong
>> I don't think this is an option not to support hotplug. I agree with
>> Zhenzhong, we shall try to align with the way it is done on intel-iommu
>> and study whether it also fits the needs for accelerated smmu.
> Hotplug is supported. The only current requirement is that we need at least
> one cold-plugged device to retrieve the host SMMUv3 features. These are
> then used to update the vSMMUv3 features during the reset phase so that
> the Guest can probe them at boot.
>
> Based on the discussions in this series, we plan to remove that dependency
> going forward. Instead, the accelerated vSMMUv3 will be initialized based
> on the current emulated SMMUv3 features, plus any additional features
> specified by the user on the command line.
>
> During every device attachment to the accelerated SMMUv3, we will
> cross-check for any disparities and allow or disallow the attachment
> accordingly.
>
> Please let me know if you see any drawbacks with this approach.
This looks aligned with the intel-iommu strategy and up to now I don't
see any cons. Let's try to relax the requirement and we will see if it
brings further issues ...

Thanks

Eric
>
> Thanks,
> Shameer
> 	
>
>
>


