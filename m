Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAF8BC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 06:21:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxhc0-0003Km-5a; Fri, 19 Apr 2024 02:20:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rxhby-0003KF-Ey
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 02:20:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rxhbw-0005wu-6M
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 02:20:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713507634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SNsXdbh5JRmV3JN71Y8UFfXWKlcgEy4Q1cXLoEVrQWU=;
 b=e0nMdeZAg6MHj0xjL6XavgP3Rgj+wkfg6+aVCV/0WY86pzzJvCcEDwDJ+j8XvnFfwkZDP7
 S0BpaBPh24Pp+adp6GykIFpjb412HdP2SYqumqRnT4E0LbjrIyKtLPHn5pMR+0AFt7xkVJ
 GPq50+F6MGucdHvFYpXIWjEcKr4s5U0=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-YUxlV1q_MsWiBaOQaCokpQ-1; Fri, 19 Apr 2024 02:20:32 -0400
X-MC-Unique: YUxlV1q_MsWiBaOQaCokpQ-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-515d139f285so1215736e87.1
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 23:20:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713507630; x=1714112430;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SNsXdbh5JRmV3JN71Y8UFfXWKlcgEy4Q1cXLoEVrQWU=;
 b=bR1vsW6PEk1NxU0MADlZ6VSMfHCSjJfpxkzu2j06AfZ++ncANUvzybIggwUSDFL9Yn
 sLVEr3CQZHa+LeBjlpeo+dIUalkH7hjgEZXhiN5nhnUjnOiS+KPXxr7RuNkcJlCUF5nT
 q7x1IPMO5k55U7eHyKmj6E2DCQHD8+YS1mqqdtF2ZVKSkm2PK84r0XVElSoSOwtjoOIP
 NdBb2dZotGPhu9acjXqGEa90v25P/e5wAa2yNKrfY6M+iKzolwoLpzbhsvhERmZ/ZdIi
 UoJV3F2Ql03VjjrYng6k69qxjovqY5J+jfM4g1lmHDbtdwvGezgwOt5qrjOwct4oti1n
 PZOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDwPILCQ6f8+/qyPb2RYeGHz5vXRkiNvztaG/2dvMiAHhtO58TSLK3SjEWXfkJKTZnqHcxB0tY5H9U0EziAVeL9YQkYnA=
X-Gm-Message-State: AOJu0Yw9gje5kFEsKAJPJ1v2x9kMMiSP7fR7zRw3/6E5/Fij8mo9Nwz3
 8G4uytIDd8PS0dOumiLRLfjom/yrmOXudamSy0rpLEZls0cpf7a/+8V2Bcs1SxweVJsRcHnwz05
 SfA7mIFcHmPIkwkOLN4Tphg4B9OgaEJbaToYsJVEXcUGimVgBm/SP
X-Received: by 2002:ac2:430b:0:b0:51a:a400:785e with SMTP id
 l11-20020ac2430b000000b0051aa400785emr620143lfh.43.1713507630603; 
 Thu, 18 Apr 2024 23:20:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvm3ea1j6vzqtNr8YPYtO2x9HFFDOjDwIdrUjkBeL8novU5KqkzDpmBblojDW5BdduYOrgzA==
X-Received: by 2002:ac2:430b:0:b0:51a:a400:785e with SMTP id
 l11-20020ac2430b000000b0051aa400785emr620112lfh.43.1713507630170; 
 Thu, 18 Apr 2024 23:20:30 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:d55d:ba01:adf2:d3ae?
 ([2a01:e0a:9e2:9000:d55d:ba01:adf2:d3ae])
 by smtp.gmail.com with ESMTPSA id
 d8-20020a170906344800b00a4e2dc1283asm1765576ejb.50.2024.04.18.23.20.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Apr 2024 23:20:29 -0700 (PDT)
Message-ID: <6d607d16-fe5e-4be2-bea3-f286c78ada53@redhat.com>
Date: Fri, 19 Apr 2024 08:20:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
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
Content-Language: en-US, fr
In-Reply-To: <SJ0PR11MB6744455DBE4D52AF635403C1920E2@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.067,
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

Hello Zhenzhong,

On 4/18/24 10:42, Duan, Zhenzhong wrote:
> Hi Cédric,
> 
>> -----Original Message-----
>> From: Cédric Le Goater <clg@redhat.com>
>> Subject: Re: [PATCH v2 3/5] intel_iommu: Add a framework to do
>> compatibility check with host IOMMU cap/ecap
>>
>> Hello Zhenzhong
>>
>> On 4/17/24 11:24, Duan, Zhenzhong wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Cédric Le Goater <clg@redhat.com>
>>>> Subject: Re: [PATCH v2 3/5] intel_iommu: Add a framework to do
>>>> compatibility check with host IOMMU cap/ecap
>>>>
>>>> On 4/17/24 06:21, Duan, Zhenzhong wrote:
>>>>>
>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Cédric Le Goater <clg@redhat.com>
>>>>>> Subject: Re: [PATCH v2 3/5] intel_iommu: Add a framework to do
>>>>>> compatibility check with host IOMMU cap/ecap
>>>>>>
>>>>>> Hello,
>>>>>>
>>>>>> On 4/16/24 09:09, Duan, Zhenzhong wrote:
>>>>>>> Hi Cédric,
>>>>>>>
>>>>>>>> -----Original Message-----
>>>>>>>> From: Cédric Le Goater <clg@redhat.com>
>>>>>>>> Subject: Re: [PATCH v2 3/5] intel_iommu: Add a framework to do
>>>>>>>> compatibility check with host IOMMU cap/ecap
>>>>>>>>
>>>>>>>> On 4/8/24 10:44, Zhenzhong Duan wrote:
>>>>>>>>> From: Yi Liu <yi.l.liu@intel.com>
>>>>>>>>>
>>>>>>>>> If check fails, the host side device(either vfio or vdpa device) should
>>>> not
>>>>>>>>> be passed to guest.
>>>>>>>>>
>>>>>>>>> Implementation details for different backends will be in following
>>>>>> patches.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>>>>>>>>> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
>>>>>>>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>>>>>>>> ---
>>>>>>>>>       hw/i386/intel_iommu.c | 35
>>>>>>>> +++++++++++++++++++++++++++++++++++
>>>>>>>>>       1 file changed, 35 insertions(+)
>>>>>>>>>
>>>>>>>>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>>>>>>>>> index 4f84e2e801..a49b587c73 100644
>>>>>>>>> --- a/hw/i386/intel_iommu.c
>>>>>>>>> +++ b/hw/i386/intel_iommu.c
>>>>>>>>> @@ -35,6 +35,7 @@
>>>>>>>>>       #include "sysemu/kvm.h"
>>>>>>>>>       #include "sysemu/dma.h"
>>>>>>>>>       #include "sysemu/sysemu.h"
>>>>>>>>> +#include "sysemu/iommufd.h"
>>>>>>>>>       #include "hw/i386/apic_internal.h"
>>>>>>>>>       #include "kvm/kvm_i386.h"
>>>>>>>>>       #include "migration/vmstate.h"
>>>>>>>>> @@ -3819,6 +3820,32 @@ VTDAddressSpace
>>>>>>>> *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
>>>>>>>>>           return vtd_dev_as;
>>>>>>>>>       }
>>>>>>>>>
>>>>>>>>> +static int vtd_check_legacy_hdev(IntelIOMMUState *s,
>>>>>>>>> +                                 HostIOMMUDevice *hiod,
>>>>>>>>> +                                 Error **errp)
>>>>>>>>> +{
>>>>>>>>> +    return 0;
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>> +static int vtd_check_iommufd_hdev(IntelIOMMUState *s,
>>>>>>>>> +                                  HostIOMMUDevice *hiod,
>>>>>>>>> +                                  Error **errp)
>>>>>>>>> +{
>>>>>>>>> +    return 0;
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>> +static int vtd_check_hdev(IntelIOMMUState *s,
>>>>>> VTDHostIOMMUDevice
>>>>>>>> *vtd_hdev,
>>>>>>>>> +                          Error **errp)
>>>>>>>>> +{
>>>>>>>>> +    HostIOMMUDevice *hiod = vtd_hdev->dev;
>>>>>>>>> +
>>>>>>>>> +    if (object_dynamic_cast(OBJECT(hiod), TYPE_HIOD_IOMMUFD))
>> {
>>>>>>>>> +        return vtd_check_iommufd_hdev(s, hiod, errp);
>>>>>>>>> +    }
>>>>>>>>> +
>>>>>>>>> +    return vtd_check_legacy_hdev(s, hiod, errp);
>>>>>>>>> +}
>>>>>>>>
>>>>>>>>
>>>>>>>> I think we should be using the .get_host_iommu_info() class handler
>>>>>>>> instead. Can we refactor the code slightly to avoid this check on
>>>>>>>> the type ?
>>>>>>>
>>>>>>> There is some difficulty ini avoiding this check, the behavior of
>>>>>> vtd_check_legacy_hdev
>>>>>>> and vtd_check_iommufd_hdev are different especially after nesting
>>>>>> support introduced.
>>>>>>> vtd_check_iommufd_hdev() has much wider check over cap/ecap bits
>>>>>> besides aw_bits.
>>>>>>
>>>>>> I think it is important to fully separate the vIOMMU model from the
>>>>>> host IOMMU backing device.
>>
>> This comment is true for the structures also.
>>
>>>>>> Could we introduce a new HostIOMMUDeviceClass
>>>>>> handler .check_hdev() handler, which would
>> call .get_host_iommu_info() ?
>>
>> This means that HIOD_LEGACY_INFO and HIOD_IOMMUFD_INFO should be
>> a common structure 'HostIOMMUDeviceInfo' holding all attributes
>> for the different backends. Each .get_host_iommu_info() implementation
>> would translate the specific host iommu device data presentation
>> into the common 'HostIOMMUDeviceInfo', this is true for host_aw_bits.
> 
> I see, it's just not easy to define the unified elements in HostIOMMUDeviceInfo
> so that they maps to bits or fields in host return IOMMU info.

The proposal is adding a vIOMMU <-> HostIOMMUDevice interface and a new
API needs to be completely defined for it. The IOMMU backend implementation
could be anything, legacy, iommufd, iommufd v2, some other framework and
the vIOMMU shouldn't be aware of its implementation.

Exposing the kernel structures as done below should be avoided because
they are part of the QEMU <-> kernel IOMMUFD interface.


> Different platform returned host IOMMU info is platform specific.
> For vtd and siommu:
> 
> struct iommu_hw_info_vtd {
>          __u32 flags;
>          __u32 __reserved;
>          __aligned_u64 cap_reg;
>          __aligned_u64 ecap_reg;
> };
> 
> struct iommu_hw_info_arm_smmuv3 {
>         __u32 flags;
>         __u32 __reserved;
>         __u32 idr[6];
>         __u32 iidr;
>         __u32 aidr;
> };
> 
> I can think of two kinds of declaration of HostIOMMUDeviceInfo:
> 
> struct HostIOMMUDeviceInfo {
>      uint8_t aw_bits;
>      enum iommu_hw_info_type type;
>      union {
>          struct iommu_hw_info_vtd vtd;
>          struct iommu_hw_info_arm_smmuv3;
>          ......
>      } data;
> }
> 
> or
> 
> struct HostIOMMUDeviceInfo {
>      uint8_t aw_bits;
>      enum iommu_hw_info_type type;
>      __u32 flags;
>      __aligned_u64 cap_reg;
>      __aligned_u64 ecap_reg;
>      __u32 idr[6];
>      __u32 iidr;
>      __u32 aidr;
>     ......
> }
> 
> Not clear if any is your expected format.
>
>> 'type' could be handled the same way, with a 'HostIOMMUDeviceInfo'
>> type attribute and host iommu device type definitions, or as you
>> suggested with a QOM interface. This is more complex however. In
>> this case, I would suggest to implement a .compatible() handler to
>> compare the host iommu device type with the vIOMMU type.
>>
>> The resulting check_hdev routine would look something like :
>>
>> static int vtd_check_hdev(IntelIOMMUState *s, VTDHostIOMMUDevice
>> *vtd_hdev,
>>                            Error **errp)
>> {
>>      HostIOMMUDevice *hiod = vtd_hdev->dev;
>>      HostIOMMUDeviceClass *hiodc =
>> HOST_IOMMU_DEVICE_GET_CLASS(hiod);
>>      HostIOMMUDevice info;
>>      int host_aw_bits, ret;
>>
>>      ret = hiodc->get_host_iommu_info(hiod, &info, sizeof(info), errp);
>>      if (ret) {
>>          return ret;
>>      }
>>
>>      ret = hiodc->is_compatible(hiod, VIOMMU_INTERFACE(s));
>>      if (ret) {
>>          return ret;
>>      }
>>
>>      if (s->aw_bits > info.aw_bits) {
>>          error_setg(errp, "aw-bits %d > host aw-bits %d",
>>                     s->aw_bits, info.aw_bits);
>>          return -EINVAL;
>>      }
>> }
>>
>> and the HostIOMMUDeviceClass::is_compatible() handler would call a
>> vIOMMUInterface::compatible() handler simply returning
>> IOMMU_HW_INFO_TYPE_INTEL_VTD. How does that sound ?
> 
> Not quite get what HostIOMMUDeviceClass::is_compatible() does.

HostIOMMUDeviceClass::is_compatible() calls in the host IOMMU backend
to determine which IOMMU types are exposed by the host, then calls the
vIOMMUInterface::compatible() handler to do the compare. API is to be
defined.

As a refinement, we could introduce in the vIOMMU <-> HostIOMMUDevice
interface capabilities, or features, to check more precisely the level
of compatibility between the vIOMMU and the host IOMMU device. This is
similar to what is done between QEMU and KVM.

If you think this is too complex, include type in HostIOMMUDeviceInfo.

> Currently legacy and IOMMUFD host device has different check logic, how it can help
> in merging vtd_check_legacy_hdev() and vtd_check_iommufd_hdev() into a single vtd_check_hdev()?

IMHO, IOMMU shouldn't be aware of the IOMMU backend implementation, but
if you think the Intel vIOMMU should access directly the iommufd backend
when available, then we should drop this proposal and revisit the design
to take a different approach.

> Below is the two functions after nesting series, for your easy reference:
> 
> static int vtd_check_legacy_hdev()
> {
>      if (s->scalable_modern) {
>          /* Modern vIOMMU and legacy backend */
>          error_setg(errp, "Need IOMMUFD backend in scalable modern mode");
>          return -EINVAL;
>      }

This part would typically go in the compatible() handler.

> 
>      ret = hiodc->get_host_iommu_info(hiod, &info, sizeof(info), errp);
>      if (ret) {
>          return ret;
>      }
> 
>      if (s->aw_bits > info.aw_bits) {
>          error_setg(errp, "aw-bits %d > host aw-bits %d",
>                     s->aw_bits, info.aw_bits);
>          return -EINVAL;
>      }
> 
>      return 0;
> }
> 
> static int vtd_check_iommufd_hdev(IntelIOMMUState *s,
>                                    VTDHostIOMMUDevice *vtd_hdev,
>                                    Error **errp)
> {
>      ret = hiodc->get_host_iommu_info(hiod, &info, sizeof(info), errp);
>      if (ret) {
>          return ret;
>      }
> 
>      if (info.type != IOMMU_HW_INFO_TYPE_INTEL_VTD) {
>          error_setg(errp, "IOMMU hardware is not compatible");
>          return -EINVAL;
>      }
> 
>      vtd = &info.data.vtd;
>      host_aw_bits = VTD_MGAW_FROM_CAP(vtd->cap_reg) + 1;
>      if (s->aw_bits > host_aw_bits) {
>          error_setg(errp, "aw-bits %d > host aw-bits %d",
>                     s->aw_bits, host_aw_bits);
>          return -EINVAL;
>      }
> 
>      if (!s->scalable_modern) {
>          goto done;
>      }
> 
>      if (!(vtd->ecap_reg & VTD_ECAP_NEST)) {
>          error_setg(errp, "Host IOMMU doesn't support nested translation");
>          return -EINVAL;
>      }
> 
>      if (s->fl1gp && !(vtd->cap_reg & VTD_CAP_FL1GP)) {
>          error_setg(errp, "Stage-1 1GB huge page is unsupported by host IOMMU");
>          return -EINVAL;
>      }

These checks above would typically go in the compatible() handler also.

Now, the question is how useful will that framework be if hotplugging
devices always fail because the vIOMMU and host IOMMU devices have
incompatible settings/capabilities ? Shouldn't we also add properties
at the vIOMMU level ?


Thanks,

C.


