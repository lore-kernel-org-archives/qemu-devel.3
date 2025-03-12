Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B2FAC28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 18:31:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsQqx-0007iU-64; Wed, 12 Mar 2025 14:30:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tsQqo-0007g6-1w
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 14:30:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tsQqm-0003WN-1A
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 14:30:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741804237;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CWORE9gkDVvMOWO7MsPN5L11w6mKMTpxSYPB9jqPXZo=;
 b=Tzge2VQSKZltUC1tfm748p3xck624VhzMDWLxknZ7yo7+EBhZMhOjZ2+FVACDySBms2gFA
 OivGI02h+qQb9Zigx/FhR4AiBLeUYNLm6cbVmVcv4FzC6xl5fbcanFHVhwOiZ7PAV4nBdD
 FplH5ynyoS1LF1qYIAGsF0zuVGCSDVw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-CB7vVbCuOSm3cxq4-ExWUQ-1; Wed, 12 Mar 2025 14:30:35 -0400
X-MC-Unique: CB7vVbCuOSm3cxq4-ExWUQ-1
X-Mimecast-MFC-AGG-ID: CB7vVbCuOSm3cxq4-ExWUQ_1741804235
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6e905e89798so3231656d6.3
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 11:30:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741804235; x=1742409035;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CWORE9gkDVvMOWO7MsPN5L11w6mKMTpxSYPB9jqPXZo=;
 b=ert0WgyGh/ECfzvD1OU4rSVAiRgEMs7QohYt0mvvOghVYXge7OMoFZbljDlnWvL9jM
 UdGEvzzv+VLYGGm/U+NZC+N5znch5CjmHpXrlHHjIvpmVIwhl+Nlgf1pMnNKBhTHofYe
 1dv05s0Sb/QU+QAJhV7P2CvhBoN1jrA9Sa8spWNnUHIE2oGtZtuvpNIM/XjdXy3EkLTf
 68oQSpWpk87UH/VmWaq86p1NvU5oQabmRkS6SZ8b8Y1H5jV8+sQIgX9Si6IMGy5V/lnO
 FgyaMhznKl5ilovsvRqt7aPRqBzbYsJTuYBlppQEJBJOBH5Xs42ByiuG3gnH4i7mA2ft
 GBKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+8/0Xpiw6RVW5qEvPIZRM2kOKgZd9iMRq0A32f4nIoDXAdJ//R96S16N9y+1cLYiZUUYZTbvT2Z5Z@nongnu.org
X-Gm-Message-State: AOJu0YymnIPsa53Dj1p8udFp87fn4KzwNnj9MUZR9Ri9YJ4krQScmDif
 Nq+Frrkr5uvShGl1Aha6GrsHiwUZIZnOEjM+vRtoiWOLvm1hidIn/RJcHTQc4rL1ADRpyyNuark
 7rmvninu+Xb+LxLH4BQqbh/SsK7mj4K5WQFtByRTFZau0Nsst7zYF
X-Gm-Gg: ASbGnctb6fO0e6PBLC7Oix/OU4adU+TMluJVQ1Zdl9/xTYxXqMjS72kLqnjx0TddbAp
 /KSN9TQXrDOVScCmtZzB+qMIKr3iTQW83qUHQLWRUFsIF0gBVpetPUWC/Yg9UFsY4zblnFB95HC
 Zju/W+jYaGdRfmLs49D2RNDJfXDHMqumNkafn2LdCUaSryfWV56uk5+/YeADicq5p8TAf2PeScp
 vzmNdkliiD1Fcp2SyLHwCyPm9Pqs4y32y3q6+E7ANs9Bs5mWKK1yW8Xf601G0n2MPslbMiep2Gz
 ef1Z85y2Xq+GOs5ZfrxV+tj8CdaLwkoo6Nv/67Oaz2/U4Az0SKHv2qBwMtmDgpU=
X-Received: by 2002:a05:6214:180d:b0:6ea:d033:284c with SMTP id
 6a1803df08f44-6ead0332c18mr47557746d6.0.1741804235225; 
 Wed, 12 Mar 2025 11:30:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHM8kg3Fx2B3x8/h1NDETkUxqB6vJn4kX0d9Gc09bZG51UynQHsaCK18qelmLS/+3yAKzBtwQ==
X-Received: by 2002:a05:6214:180d:b0:6ea:d033:284c with SMTP id
 6a1803df08f44-6ead0332c18mr47557296d6.0.1741804234928; 
 Wed, 12 Mar 2025 11:30:34 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e8f71709b9sm87526576d6.115.2025.03.12.11.30.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Mar 2025 11:30:34 -0700 (PDT)
Message-ID: <df336b78-5a0f-450a-8d3c-95326f5eb9a0@redhat.com>
Date: Wed, 12 Mar 2025 19:30:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 04/20] hw/arm/virt: Add support for smmuv3-accel
Content-Language: en-US
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "nathanc@nvidia.com" <nathanc@nvidia.com>,
 "mochs@nvidia.com" <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, Linuxarm <linuxarm@huawei.com>,
 "Wangzhou (B)" <wangzhou1@hisilicon.com>,
 jiangkunkun <jiangkunkun@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-5-shameerali.kolothum.thodi@huawei.com>
 <547f961e-380c-4ffe-8b8b-3e9d543aa702@redhat.com>
 <58c9c37876c64584b0c7961ec61696a3@huawei.com>
 <5b29ea01-1b86-4b48-a769-14986751a0f1@redhat.com>
 <5d894a546d3f4081ac2cfe98bd2ea612@huawei.com>
 <fb28c228-0c78-4412-ba91-a62cb4351793@redhat.com>
 <8490942b9428411e858a62a80ea12530@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <8490942b9428411e858a62a80ea12530@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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


On 3/12/25 6:34 PM, Shameerali Kolothum Thodi wrote:
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Sent: Wednesday, March 12, 2025 4:28 PM
>> To: Shameerali Kolothum Thodi
>> <shameerali.kolothum.thodi@huawei.com>; qemu-arm@nongnu.org;
>> qemu-devel@nongnu.org
>> Cc: peter.maydell@linaro.org; jgg@nvidia.com; nicolinc@nvidia.com;
>> ddutile@redhat.com; berrange@redhat.com; nathanc@nvidia.com;
>> mochs@nvidia.com; smostafa@google.com; Linuxarm
>> <linuxarm@huawei.com>; Wangzhou (B) <wangzhou1@hisilicon.com>;
>> jiangkunkun <jiangkunkun@huawei.com>; Jonathan Cameron
>> <jonathan.cameron@huawei.com>; zhangfei.gao@linaro.org
>> Subject: Re: [RFC PATCH v2 04/20] hw/arm/virt: Add support for smmuv3-
>> accel
>>>> Hi Shameer,
>>>>>> I know there were quite a lot of dicussions on the 1st multi
>>>>>> instantiation series related to the way we instanatiate that device
>>>>>> and maybe I missed some blockers but why wouldn't we allow the
>>>>>> instantiation of the legacy smmu device with -device too. I think
>>>>>> this would be simpler for libvirt and we would somehow deprecate
>>>>>> the machine option method? would that make a problem if you were
>> to
>>>>>> use -device smmu,accel or something alike?
>>>>> Thanks for taking a look. I am just jumping on this one for now.
>>>>> Yes, there were discussions around that. But I was not sure we
>>>>> concluded on deprecating the machine option. So if I get you
>>>>> correctly the idea is,
>>>>>
>>>>> if we have,
>>>>> -device smmuv3 it will instantiate the current machine wide smmuv3
>>>>> and for -device smmuv3,accel this device?
>>>> yes that would be my preference.
>>> Ok. I will look into that in my next respin. A quick question. Does
>>> qemu DEVICE model support the differentiation like above easily? Or we
>>> have to manage it with properties?
>> Not sure if I understand you question. I meant it can be a boolean device
>> property (DEFINE_PROP_BOOL) smmuv3,accel=on
>>
>> No?
> Right. My query was more about any hidden Qemu magic to have device instantiation
> similar to what we have at the moment even though we name both devices "smmuv3".
>  
> That way I can keep much of the code rather than checking "accel" property
> in SMMUv3 code and redirecting calls. But looks like not. 
I don't think there is any such a trick.

Having the legacy device (without accel) only instantiable with the virt
machine option and the new accelerated one only instantiable with a
-device option looks strange to me. By the way they model the same
device so I think it makes more sense to use the same device with an
option.

Also do you see anything that would prevent the acceleration enhanced
device from being able to translate emulated devices as well. Ideally
the smmu device should react differently depending on the device which
is translated. I think it worked with the original implementation as far
as I remember.

Thanks

Eric
>
> Thanks,
> Shameer
>
>
>
>


