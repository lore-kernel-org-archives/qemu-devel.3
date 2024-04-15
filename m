Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FC7AC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2024 11:13:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwKGR-0002n3-B1; Mon, 15 Apr 2024 07:12:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwKGQ-0002mB-2r
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 07:12:42 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwKGM-0007s7-6a
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 07:12:41 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4187481e3feso2320295e9.1
 for <qemu-devel@nongnu.org>; Mon, 15 Apr 2024 04:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713179556; x=1713784356; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Me1m/CUyr3PDGjWeHZ8S+XC++axadX1bqmyN4Ku0vvA=;
 b=YxhFwmxDapqh4nBsPJlWkYvXt+MyjQaKGzeTCLJjldT9m269mOj44SVGl9cVl2mJnh
 KSP7SDFM8Vcts0cnzFS7flbknPXDrAEpAongisuOVcxL7nlbnAqjXym/vCNOIQKxa4qf
 GF/gZf9kdPMr5PiIWj9LKXwpWojt17lqOGvm9AbsEL+R8BkYquAxuoMzrfRhOJmSEhuY
 80GRE5r8JKd11hr7RIMt3PfmHte0OdjCo4wMHjI1BMbDNSBny5//M1ODEPQ4djD8H9ss
 2+g6zfasloBbICq2PbhHS7zbNV+H5lLK87+QUwO/WPPZCqhsYt1bUEkHoYXXRAviDuBS
 /edQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713179556; x=1713784356;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Me1m/CUyr3PDGjWeHZ8S+XC++axadX1bqmyN4Ku0vvA=;
 b=SKDgwsbT/lW/Gj/7KG36I1wB8Ek72yVxNNSadB6As8sRkSFJcy0ESuEV/XvC8yKXyh
 234Ex5BCD3bVNLRziMJ7Ty/rPNCVrdHs9k3GeB0iC1V7BJUg4DVZATyHYh9Nf4j50s/3
 eWfR1zHh0ouXdOjLuBdK6sDQc4fQnMdLPzSIDcjNKVZ/HB9f6YfCAFVqNeIZAmXOdrIu
 +VlANSf4LFnaCsewQpOPRk9leE2RnYNSH/OCWCY5BHPORuaExKa8q8Ofe8FbTCSupRgK
 kSNFjWoltDzTjVietsxCFhtIaJY2jlyD0NAsKARkA6h5CAn4vGlWuEHYEl3dN2pPIbJA
 KY5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3ccWaSwKMPqQae8MbpWKXZIpqbDFGy3Fnk9tvhtSet2wKWliopkys/wwwGGztr2mOc0fXEWMZ/wO/yHbqXwrHaj84hQE=
X-Gm-Message-State: AOJu0Yws9JzWPgKEo+iT8IdPBT2PxV8iJha+PXuBEGfPTQ3091FkLAWA
 jwjPocbEfnMDN6WvRIiUIHWs9IJLuWMB9o3vgSvqAIpYUKmix/jDRO6wfxHUuhw=
X-Google-Smtp-Source: AGHT+IEwmTsuvEG3oNcGZT297anbg7jK+CKPTW9BVyfUdAaX0aKr94cymWOXEaGJSS9IN8AEi6ffrw==
X-Received: by 2002:a05:600c:4ecd:b0:417:ec11:c445 with SMTP id
 g13-20020a05600c4ecd00b00417ec11c445mr5854624wmq.13.1713179555910; 
 Mon, 15 Apr 2024 04:12:35 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.132.126])
 by smtp.gmail.com with ESMTPSA id
 p7-20020a05600c358700b004182cd07133sm8332586wmq.3.2024.04.15.04.12.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Apr 2024 04:12:35 -0700 (PDT)
Message-ID: <7ffb8e3d-d02e-452f-9ed7-d977b5870a70@linaro.org>
Date: Mon, 15 Apr 2024 13:12:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/10] vfio: Introduce HIODLegacyVFIO device
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>
References: <20240408081230.1030078-1-zhenzhong.duan@intel.com>
 <20240408081230.1030078-3-zhenzhong.duan@intel.com>
 <9e71a87e-ad23-4048-bc9a-c26dfafa646c@linaro.org>
 <SJ0PR11MB67448B10E7E9C052417D6C0392092@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <SJ0PR11MB67448B10E7E9C052417D6C0392092@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 15/4/24 12:10, Duan, Zhenzhong wrote:
> Hi Philippe,
> 
>> -----Original Message-----
>> From: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Sent: Monday, April 15, 2024 5:20 PM
>> To: Duan, Zhenzhong <zhenzhong.duan@intel.com>; qemu-
>> devel@nongnu.org
>> Cc: alex.williamson@redhat.com; clg@redhat.com; eric.auger@redhat.com;
>> peterx@redhat.com; jasowang@redhat.com; mst@redhat.com;
>> jgg@nvidia.com; nicolinc@nvidia.com; joao.m.martins@oracle.com; Tian,
>> Kevin <kevin.tian@intel.com>; Liu, Yi L <yi.l.liu@intel.com>; Peng, Chao P
>> <chao.p.peng@intel.com>
>> Subject: Re: [PATCH v2 02/10] vfio: Introduce HIODLegacyVFIO device
>>
>> On 8/4/24 10:12, Zhenzhong Duan wrote:
>>> HIODLegacyVFIO represents a host IOMMU device under VFIO legacy
>>> container backend.
>>>
>>> It includes a link to VFIODevice.
>>>
>>> Suggested-by: Eric Auger <eric.auger@redhat.com>
>>> Suggested-by: Cédric Le Goater <clg@redhat.com>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> ---
>>>    include/hw/vfio/vfio-common.h | 11 +++++++++++
>>>    hw/vfio/container.c           | 11 ++++++++++-
>>>    2 files changed, 21 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-
>> common.h
>>> index b9da6c08ef..f30772f534 100644
>>> --- a/include/hw/vfio/vfio-common.h
>>> +++ b/include/hw/vfio/vfio-common.h
>>> @@ -31,6 +31,7 @@
>>>    #endif
>>>    #include "sysemu/sysemu.h"
>>>    #include "hw/vfio/vfio-container-base.h"
>>> +#include "sysemu/host_iommu_device.h"
>>>
>>>    #define VFIO_MSG_PREFIX "vfio %s: "
>>>
>>> @@ -147,6 +148,16 @@ typedef struct VFIOGroup {
>>>        bool ram_block_discard_allowed;
>>>    } VFIOGroup;
>>>
>>> +#define TYPE_HIOD_LEGACY_VFIO TYPE_HOST_IOMMU_DEVICE "-legacy-
>> vfio"
>>> +OBJECT_DECLARE_SIMPLE_TYPE(HIODLegacyVFIO, HIOD_LEGACY_VFIO)
>>> +
>>> +/* Abstraction of VFIO legacy host IOMMU device */
>>> +struct HIODLegacyVFIO {
>>> +    /*< private >*/
>>
>> Please drop this comment.
> 
> Will do. But may I ask the rules when to use that comment and when not?

Sure, see 
https://www.qemu.org/docs/master/devel/style.html#qemu-object-model-declarations

> I see some QOM use that comment to mark private vs. public, for example:
> 
> struct AccelState {
>      /*< private >*/
>      Object parent_obj;

This is old style which might be cleaned some day...

> };
> 
> typedef struct AccelClass {
>      /*< private >*/
>      ObjectClass parent_class;
>      /*< public >*/
> 
>>
>>> +    HostIOMMUDevice parent;
>>
>> Please name 'parent_obj'.
> 
> Will do.

Thanks,

Phil.

> 
> Thanks
> Zhenzhong
> 
>>
>>> +    VFIODevice *vdev;
>>> +};
> 


