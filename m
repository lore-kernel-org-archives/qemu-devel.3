Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5421CC35FF3
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 15:23:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tskOq-0006up-Rk; Thu, 13 Mar 2025 11:23:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tskOn-0006u8-6f
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 11:23:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tskOl-0001YL-EK
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 11:23:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741879382;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EZP3EINMiau0DOh25+wD2QEqLTqxWivDHuODrVbyHUE=;
 b=Z6BuiXS7Nl+aYru//T69wn4j3c1bTWYYrSIqdT+ZIITVnEUu6P3kb8hGHn9E2G/0uf83Pq
 ZTwS9UloVOiG/ziltbhdmfzvMOsXqVHRNtt4xAG1SYCTRUwpiYCdmPG1+u0bBxeuq02sBR
 CTfl6miHy8rykg8iLxylJWbPBzKUOWY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-ke4pkn3RMiy0gL36vXHMFA-1; Thu, 13 Mar 2025 11:22:55 -0400
X-MC-Unique: ke4pkn3RMiy0gL36vXHMFA-1
X-Mimecast-MFC-AGG-ID: ke4pkn3RMiy0gL36vXHMFA_1741879375
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7c54e9f6e00so383824085a.0
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 08:22:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741879375; x=1742484175;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EZP3EINMiau0DOh25+wD2QEqLTqxWivDHuODrVbyHUE=;
 b=NmXnhp+0m41LlWTgu6fT1mN3R3463xBN6rLwM4oHx/ZqRbuy3tcHIXdYXs18Sq+lao
 Q4evBeU2luc9JVTxaiQ4CQM2Uo+bpvJqNGhqFs1ZuUysa1nF9xUI8le0xCQFKFrHLZGj
 WDA/7ijqHqa7EJdNDP1Ue6LlaPbpIyZH43YCIknuK/MNOPSedY0GMPAU2hAjUg1SWs6m
 2Ujc6tusX4BqTsvWyy5rKcM9W1BDtMfVXMEN/6mJLltkJQZvoiWYBqPaUy+3PwEt/WNs
 25KfFYRdBqp69R20ssYniwpUklsjd84Ni+wTLPdaB6n3qT+dBn32M1ZjDvnB17A+Zof2
 4SMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBy/uNkOJTzUwltWCTyy5ZBHfWOSzlwhEtTCIo7IJoaMFjuUhTGToq9PyPWauBUXtvGFbUHTZkqpOV@nongnu.org
X-Gm-Message-State: AOJu0YzKx0eJK+4HFBfKrPQIfd2U73W56mDA43LxANoLDSfwyiTAzyf3
 03mttB+zH/FYx5A39umiRKox2/Bgg/EocDR5AT3H2g7djucaNDv8u6X7rjT/xdAYsj0p/r8Gl8x
 jxdnPT2dTrYYbrdBcVglTeFhqQJ7Htw4GphhZWPX67sEYPMFGY33t
X-Gm-Gg: ASbGnctoOfb06KVJ476tjJQ89/PEgJvywsdWa3ortgnmYJAIyqCWTMIlOdcLAk8LZh0
 XZnWWZX5S3vAZYulPjyFexvtvB9s/CZQmzbU5sW5rTsg32YneuXj5Dqg+UtEbAD78GdBc+nqU0C
 CZAWxHEMaeTI3aT9DfMh1xlIftoPiOPVwZvSUNCUQ/Eg7vzUxK9k0OVsce63CURc8S/f3Mvv+L8
 DxTGnKxI+G+a9+pXhYnEr+B8wlWfu0Kvu1GxYycs5hRLkU8vHYAsMFNvE2ul/ho5wogAOS+d62p
 vUa3++kGamglsK3hmolgSWTyb6+yeCxUNhbsTrOlF/lUAFa3G62LG+SPLSMtfHA=
X-Received: by 2002:a05:620a:608c:b0:7b7:142d:53a8 with SMTP id
 af79cd13be357-7c5737f16c7mr504515285a.19.1741879375194; 
 Thu, 13 Mar 2025 08:22:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHj9tVgQN6tyRft4x1YKcUrO93MlRKB7/+4lThR0JPTAlsMjOUIE+hAwfV2kqwxFaG+3oowjQ==
X-Received: by 2002:a05:620a:608c:b0:7b7:142d:53a8 with SMTP id
 af79cd13be357-7c5737f16c7mr504511485a.19.1741879374876; 
 Thu, 13 Mar 2025 08:22:54 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c573c71628sm110305885a.32.2025.03.13.08.22.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 08:22:54 -0700 (PDT)
Message-ID: <dcd67e50-8dea-4793-86a3-0c987f46a0c5@redhat.com>
Date: Thu, 13 Mar 2025 16:22:49 +0100
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
 <df336b78-5a0f-450a-8d3c-95326f5eb9a0@redhat.com>
 <f4381814d71841a185ced57dfc4f4c62@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <f4381814d71841a185ced57dfc4f4c62@huawei.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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




On 3/13/25 9:26 AM, Shameerali Kolothum Thodi wrote:
> Hi Eric,
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Sent: Wednesday, March 12, 2025 6:31 PM
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
>>
>> Hi Shameer,
>>
>>
>>>>>>> Thanks for taking a look. I am just jumping on this one for now.
>>>>>>> Yes, there were discussions around that. But I was not sure we
>>>>>>> concluded on deprecating the machine option. So if I get you
>>>>>>> correctly the idea is,
>>>>>>>
>>>>>>> if we have,
>>>>>>> -device smmuv3 it will instantiate the current machine wide smmuv3
>>>>>>> and for -device smmuv3,accel this device?
>>>>>> yes that would be my preference.
>>>>> Ok. I will look into that in my next respin. A quick question. Does
>>>>> qemu DEVICE model support the differentiation like above easily? Or
>> we
>>>>> have to manage it with properties?
>>>> Not sure if I understand you question. I meant it can be a boolean
>> device
>>>> property (DEFINE_PROP_BOOL) smmuv3,accel=on
>>>>
>>>> No?
>>> Right. My query was more about any hidden Qemu magic to have device
>> instantiation
>>> similar to what we have at the moment even though we name both
>> devices "smmuv3".
>>> That way I can keep much of the code rather than checking "accel"
>> property
>>> in SMMUv3 code and redirecting calls. But looks like not.
>> I don't think there is any such a trick.
>>
>> Having the legacy device (without accel) only instantiable with the virt
>> machine option and the new accelerated one only instantiable with a
>> -device option looks strange to me. By the way they model the same
>> device so I think it makes more sense to use the same device with an
>> option.
> Ok. Will address that in the next respin.
>
>> Also do you see anything that would prevent the acceleration enhanced
>> device from being able to translate emulated devices as well. Ideally
>> the smmu device should react differently depending on the device which
>> is translated. I think it worked with the original implementation as far
>> as I remember.
> Yes, smmuv3-accel works with emulated devices as well. Currently the only
> limitation is, we should have at least one vfi-pci dev cold plugged as mentioned
> in the cover letter. Hopefully we will be able to resolve that restriction soon.

OK thanks

Eric
>
> Thanks,
> Shameer
>


