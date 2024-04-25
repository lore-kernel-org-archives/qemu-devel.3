Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 557B0C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 12:41:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzyPI-0006Tm-VS; Thu, 25 Apr 2024 08:40:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rzyP9-0006R6-1n
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 08:40:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rzyP4-000748-DD
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 08:40:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714048836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lXk4GKho5IrUDnSFB7uhRvrsTCGLIn4fUU/2f6HXFuQ=;
 b=ROBo49N/2d7axJxVkEv/8qxCfqxR15BjoqBwsJMcw34c2i6Ro87/232UZpctoGfmF7BBp1
 AhqlB1cs3p6e/2GnsrBFkVnCDdmL3exb8TF0/dYgs9ykNF7fft6hJ3p/PzPPUHMeLbvqUy
 qIqQZ5dpPq/4ql3ZpXfGad7XsB1v+Rg=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-Cg5u0MHhMxCII4jsXH2jbQ-1; Thu, 25 Apr 2024 08:40:35 -0400
X-MC-Unique: Cg5u0MHhMxCII4jsXH2jbQ-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-439846258c4so12324841cf.1
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 05:40:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714048835; x=1714653635;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lXk4GKho5IrUDnSFB7uhRvrsTCGLIn4fUU/2f6HXFuQ=;
 b=f3FS2BjLGaI6XZzkWrVgXV2OFPteKWlEw9PnGGNRYuJvJgHkFABVmoue5x2/4duB3+
 O0SW9h5FOfs4TnyKnHgPnDbLe3PVOKNMrJ6a/gdtJYXg2Wn/54C124DkYmvC8C0f/l5q
 raroRrQqKl9QPbSpwxarskRky5nsRJzY02V1RWEp9SeVQdWreAWXsq+V2ZeexxCphD0t
 ygorwc5fEF7jok8cwkKbJZ3er5Z4wo4wAuCtGjHIbxB24RuGyWIO42pL7OAnJD72nc+J
 JkiNZ6uT16EvRg08/gy/B+GjRNPlis7km1el51soo3RcANkYRUwhJj6O0Izum3i58Zpn
 x0Yg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+0PBRk60Nf0WquPB+p8eo3JfpUXGPrhASyLfboFYN7OEWrDPnCgHuOMfuaCJL1p5BvRGLsYJi3xxkxXRoFJV9CjNuUUU=
X-Gm-Message-State: AOJu0Yyp7M035Ok4Z2jco13XgPUv1/CWTX3EpucXyk+6Fbxsl3MvAqKc
 w81pXbl+sGUOPbj7sUwj2htIAWx+igh5yfRehe1l/LuTGrKF7DKbVckO6LUJ1+G2SJJL6u1dES4
 e7NDJ3WgB4aAWy5fw2wQ2qNrqlQh4LQ+OQBSsE39eI2aMZecmb5su
X-Received: by 2002:ac8:588c:0:b0:436:8220:8c44 with SMTP id
 t12-20020ac8588c000000b0043682208c44mr6665034qta.59.1714048834773; 
 Thu, 25 Apr 2024 05:40:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpdHEzUc+JX8ST8IRJi2ETaVa2K5eREciXSon320Ec3NIhk9FZGvlvWZQjtPuHH+uNwLa4+Q==
X-Received: by 2002:ac8:588c:0:b0:436:8220:8c44 with SMTP id
 t12-20020ac8588c000000b0043682208c44mr6664986qta.59.1714048834139; 
 Thu, 25 Apr 2024 05:40:34 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 d12-20020ac851cc000000b00438527a4eb5sm5683907qtn.10.2024.04.25.05.40.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Apr 2024 05:40:33 -0700 (PDT)
Message-ID: <1ae5ea29-f7f3-4988-8a68-ad2c9156d606@redhat.com>
Date: Thu, 25 Apr 2024 14:40:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] intel_iommu: Add a framework to do compatibility
 check with host IOMMU cap/ecap
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20240408084404.1111628-1-zhenzhong.duan@intel.com>
 <20240408084404.1111628-4-zhenzhong.duan@intel.com>
 <251715ae-5378-4dfb-bc14-47ba2e62f83a@redhat.com>
 <SJ0PR11MB67443BF6BC7CABCE28F482A392082@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <5eb6c665-df8f-4c5e-8426-4678d8433a0c@redhat.com>
 <SJ0PR11MB6744F7A99B9303C8A3699EE9920F2@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <b67b6ba8-b506-4865-9ab0-e9107cd5b12a@redhat.com>
 <SJ0PR11MB67442AA733CF06B144D33934920F2@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <afac1b03-11ea-4bb9-ab79-92cff2c0ea20@redhat.com>
 <SJ0PR11MB6744455DBE4D52AF635403C1920E2@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <6d607d16-fe5e-4be2-bea3-f286c78ada53@redhat.com>
 <SJ0PR11MB6744C9A7EB6DF3413BD4CDE592172@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <SJ0PR11MB6744C9A7EB6DF3413BD4CDE592172@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.669,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 4/25/24 10:46, Duan, Zhenzhong wrote:
> Hi Cédric,
> 
>> -----Original Message-----
>> From: Cédric Le Goater <clg@redhat.com>
>> Subject: Re: [PATCH v2 3/5] intel_iommu: Add a framework to do
>> compatibility check with host IOMMU cap/ecap
>>
>> Hello Zhenzhong,
>>
>> On 4/18/24 10:42, Duan, Zhenzhong wrote:
>>> Hi Cédric,
>>>
>>>> -----Original Message-----
>>>> From: Cédric Le Goater <clg@redhat.com>
>>>> Subject: Re: [PATCH v2 3/5] intel_iommu: Add a framework to do
>>>> compatibility check with host IOMMU cap/ecap
>>>>
>>>> Hello Zhenzhong
>>>>
>>>> On 4/17/24 11:24, Duan, Zhenzhong wrote:
>>>>>
>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Cédric Le Goater <clg@redhat.com>
>>>>>> Subject: Re: [PATCH v2 3/5] intel_iommu: Add a framework to do
>>>>>> compatibility check with host IOMMU cap/ecap
>>>>>>
>>>>>> On 4/17/24 06:21, Duan, Zhenzhong wrote:
>>>>>>>
>>>>>>>
>>>>>>>> -----Original Message-----
>>>>>>>> From: Cédric Le Goater <clg@redhat.com>
>>>>>>>> Subject: Re: [PATCH v2 3/5] intel_iommu: Add a framework to do
>>>>>>>> compatibility check with host IOMMU cap/ecap
>>>>>>>>
>>>>>>>> Hello,
>>>>>>>>
>>>>>>>> On 4/16/24 09:09, Duan, Zhenzhong wrote:
>>>>>>>>> Hi Cédric,
>>>>>>>>>
>>>>>>>>>> -----Original Message-----
>>>>>>>>>> From: Cédric Le Goater <clg@redhat.com>
>>>>>>>>>> Subject: Re: [PATCH v2 3/5] intel_iommu: Add a framework to do
>>>>>>>>>> compatibility check with host IOMMU cap/ecap
>>>>>>>>>>
>>>>>>>>>> On 4/8/24 10:44, Zhenzhong Duan wrote:
>>>>>>>>>>> From: Yi Liu <yi.l.liu@intel.com>
>>>>>>>>>>>
>>>>>>>>>>> If check fails, the host side device(either vfio or vdpa device)
>> should
>>>>>> not
>>>>>>>>>>> be passed to guest.
>>>>>>>>>>>
>>>>>>>>>>> Implementation details for different backends will be in
>> following
>>>>>>>> patches.
>>>>>>>>>>>
>>>>>>>>>>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>>>>>>>>>>> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
>>>>>>>>>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>>>>>>>>>> ---
>>>>>>>>>>>        hw/i386/intel_iommu.c | 35
>>>>>>>>>> +++++++++++++++++++++++++++++++++++
>>>>>>>>>>>        1 file changed, 35 insertions(+)
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>>>>>>>>>>> index 4f84e2e801..a49b587c73 100644
>>>>>>>>>>> --- a/hw/i386/intel_iommu.c
>>>>>>>>>>> +++ b/hw/i386/intel_iommu.c
>>>>>>>>>>> @@ -35,6 +35,7 @@
>>>>>>>>>>>        #include "sysemu/kvm.h"
>>>>>>>>>>>        #include "sysemu/dma.h"
>>>>>>>>>>>        #include "sysemu/sysemu.h"
>>>>>>>>>>> +#include "sysemu/iommufd.h"
>>>>>>>>>>>        #include "hw/i386/apic_internal.h"
>>>>>>>>>>>        #include "kvm/kvm_i386.h"
>>>>>>>>>>>        #include "migration/vmstate.h"
>>>>>>>>>>> @@ -3819,6 +3820,32 @@ VTDAddressSpace
>>>>>>>>>> *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
>>>>>>>>>>>            return vtd_dev_as;
>>>>>>>>>>>        }
>>>>>>>>>>>
>>>>>>>>>>> +static int vtd_check_legacy_hdev(IntelIOMMUState *s,
>>>>>>>>>>> +                                 HostIOMMUDevice *hiod,
>>>>>>>>>>> +                                 Error **errp)
>>>>>>>>>>> +{
>>>>>>>>>>> +    return 0;
>>>>>>>>>>> +}
>>>>>>>>>>> +
>>>>>>>>>>> +static int vtd_check_iommufd_hdev(IntelIOMMUState *s,
>>>>>>>>>>> +                                  HostIOMMUDevice *hiod,
>>>>>>>>>>> +                                  Error **errp)
>>>>>>>>>>> +{
>>>>>>>>>>> +    return 0;
>>>>>>>>>>> +}
>>>>>>>>>>> +
>>>>>>>>>>> +static int vtd_check_hdev(IntelIOMMUState *s,
>>>>>>>> VTDHostIOMMUDevice
>>>>>>>>>> *vtd_hdev,
>>>>>>>>>>> +                          Error **errp)
>>>>>>>>>>> +{
>>>>>>>>>>> +    HostIOMMUDevice *hiod = vtd_hdev->dev;
>>>>>>>>>>> +
>>>>>>>>>>> +    if (object_dynamic_cast(OBJECT(hiod),
>> TYPE_HIOD_IOMMUFD))
>>>> {
>>>>>>>>>>> +        return vtd_check_iommufd_hdev(s, hiod, errp);
>>>>>>>>>>> +    }
>>>>>>>>>>> +
>>>>>>>>>>> +    return vtd_check_legacy_hdev(s, hiod, errp);
>>>>>>>>>>> +}
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> I think we should be using the .get_host_iommu_info() class
>> handler
>>>>>>>>>> instead. Can we refactor the code slightly to avoid this check on
>>>>>>>>>> the type ?
>>>>>>>>>
>>>>>>>>> There is some difficulty ini avoiding this check, the behavior of
>>>>>>>> vtd_check_legacy_hdev
>>>>>>>>> and vtd_check_iommufd_hdev are different especially after
>> nesting
>>>>>>>> support introduced.
>>>>>>>>> vtd_check_iommufd_hdev() has much wider check over cap/ecap
>> bits
>>>>>>>> besides aw_bits.
>>>>>>>>
>>>>>>>> I think it is important to fully separate the vIOMMU model from the
>>>>>>>> host IOMMU backing device.
>>>>
>>>> This comment is true for the structures also.
>>>>
>>>>>>>> Could we introduce a new HostIOMMUDeviceClass
>>>>>>>> handler .check_hdev() handler, which would
>>>> call .get_host_iommu_info() ?
>>>>
>>>> This means that HIOD_LEGACY_INFO and HIOD_IOMMUFD_INFO should
>> be
>>>> a common structure 'HostIOMMUDeviceInfo' holding all attributes
>>>> for the different backends. Each .get_host_iommu_info() implementation
>>>> would translate the specific host iommu device data presentation
>>>> into the common 'HostIOMMUDeviceInfo', this is true for host_aw_bits.
>>>
>>> I see, it's just not easy to define the unified elements in
>> HostIOMMUDeviceInfo
>>> so that they maps to bits or fields in host return IOMMU info.
>>
>> The proposal is adding a vIOMMU <-> HostIOMMUDevice interface and a
>> new
>> API needs to be completely defined for it. The IOMMU backend
>> implementation
>> could be anything, legacy, iommufd, iommufd v2, some other framework
>> and
>> the vIOMMU shouldn't be aware of its implementation.
>>
>> Exposing the kernel structures as done below should be avoided because
>> they are part of the QEMU <-> kernel IOMMUFD interface.
>>
>>
>>> Different platform returned host IOMMU info is platform specific.
>>> For vtd and siommu:
>>>
>>> struct iommu_hw_info_vtd {
>>>           __u32 flags;
>>>           __u32 __reserved;
>>>           __aligned_u64 cap_reg;
>>>           __aligned_u64 ecap_reg;
>>> };
>>>
>>> struct iommu_hw_info_arm_smmuv3 {
>>>          __u32 flags;
>>>          __u32 __reserved;
>>>          __u32 idr[6];
>>>          __u32 iidr;
>>>          __u32 aidr;
>>> };
>>>
>>> I can think of two kinds of declaration of HostIOMMUDeviceInfo:
>>>
>>> struct HostIOMMUDeviceInfo {
>>>       uint8_t aw_bits;
>>>       enum iommu_hw_info_type type;
>>>       union {
>>>           struct iommu_hw_info_vtd vtd;
>>>           struct iommu_hw_info_arm_smmuv3;
>>>           ......
>>>       } data;
>>> }
>>>
>>> or
>>>
>>> struct HostIOMMUDeviceInfo {
>>>       uint8_t aw_bits;
>>>       enum iommu_hw_info_type type;
>>>       __u32 flags;
>>>       __aligned_u64 cap_reg;
>>>       __aligned_u64 ecap_reg;
>>>       __u32 idr[6];
>>>       __u32 iidr;
>>>       __u32 aidr;
>>>      ......
>>> }
>>>
>>> Not clear if any is your expected format.
>>>
>>>> 'type' could be handled the same way, with a 'HostIOMMUDeviceInfo'
>>>> type attribute and host iommu device type definitions, or as you
>>>> suggested with a QOM interface. This is more complex however. In
>>>> this case, I would suggest to implement a .compatible() handler to
>>>> compare the host iommu device type with the vIOMMU type.
>>>>
>>>> The resulting check_hdev routine would look something like :
>>>>
>>>> static int vtd_check_hdev(IntelIOMMUState *s, VTDHostIOMMUDevice
>>>> *vtd_hdev,
>>>>                             Error **errp)
>>>> {
>>>>       HostIOMMUDevice *hiod = vtd_hdev->dev;
>>>>       HostIOMMUDeviceClass *hiodc =
>>>> HOST_IOMMU_DEVICE_GET_CLASS(hiod);
>>>>       HostIOMMUDevice info;
>>>>       int host_aw_bits, ret;
>>>>
>>>>       ret = hiodc->get_host_iommu_info(hiod, &info, sizeof(info), errp);
>>>>       if (ret) {
>>>>           return ret;
>>>>       }
>>>>
>>>>       ret = hiodc->is_compatible(hiod, VIOMMU_INTERFACE(s));
>>>>       if (ret) {
>>>>           return ret;
>>>>       }
>>>>
>>>>       if (s->aw_bits > info.aw_bits) {
>>>>           error_setg(errp, "aw-bits %d > host aw-bits %d",
>>>>                      s->aw_bits, info.aw_bits);
>>>>           return -EINVAL;
>>>>       }
>>>> }
>>>>
>>>> and the HostIOMMUDeviceClass::is_compatible() handler would call a
>>>> vIOMMUInterface::compatible() handler simply returning
>>>> IOMMU_HW_INFO_TYPE_INTEL_VTD. How does that sound ?
>>>
>>> Not quite get what HostIOMMUDeviceClass::is_compatible() does.
>>
>> HostIOMMUDeviceClass::is_compatible() calls in the host IOMMU backend
>> to determine which IOMMU types are exposed by the host, then calls the
>> vIOMMUInterface::compatible() handler to do the compare. API is to be
>> defined.
>>
>> As a refinement, we could introduce in the vIOMMU <-> HostIOMMUDevice
>> interface capabilities, or features, to check more precisely the level
>> of compatibility between the vIOMMU and the host IOMMU device. This is
>> similar to what is done between QEMU and KVM.
>>
>> If you think this is too complex, include type in HostIOMMUDeviceInfo.
>>
>>> Currently legacy and IOMMUFD host device has different check logic, how
>> it can help
>>> in merging vtd_check_legacy_hdev() and vtd_check_iommufd_hdev() into
>> a single vtd_check_hdev()?
>>
>> IMHO, IOMMU shouldn't be aware of the IOMMU backend implementation,
>> but
>> if you think the Intel vIOMMU should access directly the iommufd backend
>> when available, then we should drop this proposal and revisit the design
>> to take a different approach.
> 
> I implemented a draft following your suggestions so we could explore further.
> See https://github.com/yiliu1765/qemu/tree/zhenzhong/iommufd_nesting_preq_v3_tmp
> 
> In this draft, it uses .check_cap() to query HOST_IOMMU_DEVICE_CAP_xxx
> just like KVM CAPs.
> A common HostIOMMUDeviceCaps structure is introduced to be used by
> both legacy and iommufd backend.
> 
> It indeed is cleaner. Only problem is I failed to implement .compatible()
> as all the check could go ahead by just calling check_cap().
> Could you help a quick check to see if I misunderstood any of your suggestion?

Thanks for the changes. It looks cleaner and simpler ! Some comments,

* HostIOMMUDeviceIOMMUFDClass seems useless as it is empty. I don't
   remember if you told me already you had plans for future changes.
   Sorry about that if this is the case. I forgot.

* I would use the 'host_iommu_device_' prefix for external routines
   which are part of the HostIOMMUDevice API and use 'hiod_' for
   internal routines where it makes sense, to limit the name length for
   instance.

* I would rename HOST_IOMMU_DEVICE_CAP_IOMMUFD_V1 to
   HOST_IOMMU_DEVICE_CAP_IOMMUFD. I mentioned IOMMUFD v2 as a
   theoretical example of a different IOMMU interface. I don't think we
   need to anticipate yet :)

* HostIOMMUDeviceCaps is using 'enum iommu_hw_info_type' from
   'linux/iommufd.h', that's not my preferred choice but I won't
   object. The result looks good.

* HostIOMMUDevice now has a realize() routine to query the host IOMMU
   capability for later usage. This is a good idea. However, you could
   change the return value to bool and avoid the ERRP_GUARD() prologue.

* Beware of :
     
     struct Range {
         /*
          * Do not access members directly, use the functions!
          * A non-empty range has @lob <= @upb.
          * An empty range has @lob == @upb + 1.
          */
         uint64_t lob;        /* inclusive lower bound */
         uint64_t upb;        /* inclusive upper bound */
     };
     

* I think you could introduce a new VFIOIOMMUClass attribute. Let's
   call it VFIOIOMMUClass::hiod_typename. The creation of HostIOMMUDevice
   would become generic and you could move :

     hiod= HOST_IOMMU_DEVICE(object_new(TYPE_HOST_IOMMU_DEVICE_LEGACY_VFIO));
     HOST_IOMMU_DEVICE_GET_CLASS(hiod)->realize(hiod, vbasedev, errp);
     if (*errp) {
         object_unref(hiod);
         return -EINVAL;
     }
     vbasedev->hiod = hiod;

   at the end of vfio_attach_device().


Thanks,

C.



