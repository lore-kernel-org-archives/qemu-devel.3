Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17652C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 16:00:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU74Q-0002Uf-9f; Wed, 17 Jul 2024 11:59:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sU74P-0002Or-17
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 11:59:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sU74M-0004kf-Qk
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 11:59:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721231993;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cs9ZcroJdwtw+36hFuCqozA/bRksIR/Mx+j58P9MtJM=;
 b=UyzOwrl8SkdI8JtvIBxm0jRYwOdopuuOe8JMQvEaK0bzNMP2pznZ7+p67B0SPL/yx5FwlY
 nwpl2B8O3kNI/LgWRcCzV4hRtN9jnwh8z+nT5UTMaJEMFk5AUGFCDpS7QyykummaPfAFaY
 ypddJom7WMQKdZnC4nH28KLmR65EQOY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-CZprSjt7NpO7F3O5SmmKkA-1; Wed, 17 Jul 2024 11:59:51 -0400
X-MC-Unique: CZprSjt7NpO7F3O5SmmKkA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-36835f6ebdcso407669f8f.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 08:59:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721231990; x=1721836790;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Cs9ZcroJdwtw+36hFuCqozA/bRksIR/Mx+j58P9MtJM=;
 b=MDlKTLdg5QZECkiSnpxqGfSRGt6f6t3RQlswtrVgESWFTzJHFo2pSZ/EZZ7y8BWwg8
 W93nRvzsplKERnCt+BWNgkFtb6tePgCaQQ2UfY2/L8GewR6iOiyDC59YShhrktKxC7Ff
 9b2FR3wDmcoRTjl1hD4Gy0Jn/SLCqx1lnjrxYl59GvF6dUFpDCc4czcFFt4bYNs9issw
 Yr0xg3S9XEwhmlb2HkZ36It9X0kytH/EhcOdBuuygHhaONo1beVjPnS2mOnabbtuyUWh
 +FXPRe4r0O/HxRT9V5XGm0BAUGNMuRnbKF8W/0Y8REmgrwb379DMV5I5ipvqGJIM6GtC
 XCIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVp6Igkih6VMDrC0ufY+O9v6scHCBxApR4URMX532gkBkHq6cJ9HZ6y9cldqZMCpICExFSOZf9in1F9JqQ5Lg92BSacD+4=
X-Gm-Message-State: AOJu0Yz/WaiV0W+Fi+oYU9YMqJ10MmEeKZH5jpL6qicOMLMD5KCof2i2
 deQtQIkUW7yLSAmi/RX0eiQ2wif8WiCzUU0VjOnI1ZmXl46vARDnm0/LgUaPjN52lxDyDOAPHSG
 XgXGBGOloXBkyI3PCe5E2qNWB05Ao1YBLjh12LHaw6/7heozPfLgU
X-Received: by 2002:a5d:58cf:0:b0:367:4383:d9b4 with SMTP id
 ffacd0b85a97d-36831745e31mr1792417f8f.56.1721231990257; 
 Wed, 17 Jul 2024 08:59:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGv7NxsLjERKa+GXDNLBu5IspphqEsG8bEq8dZU1ehg/uYzGn+/WBpjTLXm2042T777WLKXHQ==
X-Received: by 2002:a5d:58cf:0:b0:367:4383:d9b4 with SMTP id
 ffacd0b85a97d-36831745e31mr1792401f8f.56.1721231989788; 
 Wed, 17 Jul 2024 08:59:49 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dab3d37sm12157998f8f.14.2024.07.17.08.59.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jul 2024 08:59:49 -0700 (PDT)
Message-ID: <8bc7d848-dcf8-4d12-ad2e-8e077732a592@redhat.com>
Date: Wed, 17 Jul 2024 17:59:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/18] hw/arm/smmuv3: Fix encoding of CLASS in events
Content-Language: en-US
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Mostafa Saleh <smostafa@google.com>, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, qemu-devel@nongnu.org, alex.bennee@linaro.org,
 maz@kernel.org, nicolinc@nvidia.com, julien@xen.org,
 richard.henderson@linaro.org, marcin.juszkiewicz@linaro.org
References: <20240715084519.1189624-1-smostafa@google.com>
 <20240715084519.1189624-4-smostafa@google.com>
 <cb687788-4bf4-4bc1-94e1-5f023b731b9c@redhat.com>
 <20240717155838.GA4073279@myrica>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240717155838.GA4073279@myrica>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 7/17/24 17:58, Jean-Philippe Brucker wrote:
> Hi Eric,
>
> On Wed, Jul 17, 2024 at 05:07:57PM +0200, Eric Auger wrote:
>> Hi Jean,
>>
>> On 7/15/24 10:45, Mostafa Saleh wrote:
>>> The SMMUv3 spec (ARM IHI 0070 F.b - 7.3 Event records) defines the
>>> class of events faults as:
>>>
>>> CLASS: The class of the operation that caused the fault:
>>> - 0b00: CD, CD fetch.
>>> - 0b01: TTD, Stage 1 translation table fetch.
>>> - 0b10: IN, Input address
>>>
>>> However, this value was not set and left as 0 which means CD and not
>>> IN (0b10).
>>>
>>> Another problem was that stage-2 class is considered IN not TT for
>>> EABT, according to the spec:
>>>     Translation of an IPA after successful stage 1 translation (or,
>>>     in stage 2-only configuration, an input IPA)
>>>     - S2 == 1 (stage 2), CLASS == IN (Input to stage)
>>>
>>> This would change soon when nested translations are supported.
>>>
>>> While at it, add an enum for class as it would be used for nesting.
>>> However, at the moment stage-1 and stage-2 use the same class values,
>>> except for EABT.
>>>
>>> Fixes: 9bde7f0674 “hw/arm/smmuv3: Implement translate callback”
>>> Signed-off-by: Mostafa Saleh <smostafa@google.com>
>>> ---
>>>  hw/arm/smmuv3-internal.h | 6 ++++++
>>>  hw/arm/smmuv3.c          | 8 +++++++-
>>>  2 files changed, 13 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
>>> index e4dd11e1e6..0f3ecec804 100644
>>> --- a/hw/arm/smmuv3-internal.h
>>> +++ b/hw/arm/smmuv3-internal.h
>>> @@ -32,6 +32,12 @@ typedef enum SMMUTranslationStatus {
>>>      SMMU_TRANS_SUCCESS,
>>>  } SMMUTranslationStatus;
>>>  
>>> +typedef enum SMMUTranslationClass {
>>> +    SMMU_CLASS_CD,
>>> +    SMMU_CLASS_TT,
>>> +    SMMU_CLASS_IN,
>>> +} SMMUTranslationClass;
>>> +
>>>  /* MMIO Registers */
>>>  
>>>  REG32(IDR0,                0x0)
>>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>>> index 9dd3ea48e4..3d214c9f57 100644
>>> --- a/hw/arm/smmuv3.c
>>> +++ b/hw/arm/smmuv3.c
>>> @@ -942,7 +942,9 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>>>              event.type = SMMU_EVT_F_WALK_EABT;
>>>              event.u.f_walk_eabt.addr = addr;
>>>              event.u.f_walk_eabt.rnw = flag & 0x1;
>>> -            event.u.f_walk_eabt.class = 0x1;
>>> +            /* Stage-2 (only) is class IN while stage-1 is class TT */
>>> +            event.u.f_walk_eabt.class = (ptw_info.stage == 2) ?
>>> +                                         SMMU_CLASS_IN : SMMU_CLASS_TT;
>> does it match your expectations. While reading your previous comment I
>> have the impression what you had in mind was more complicated than that
>>
>> * s2 walk that encounters EABT on S2 descriptor while translating
>>   non-descriptor IPA is reported as class=IN, even when doing s2-only.
> At this point we only support single-stage, so I believe this is correct:
> 	"A stage 1-only table walk that encounters EABT ... CLASS == TT"
> 	"translation of ... in stage 2-only configuration, an input IPA...
> 	 CLASS == IN"
>
> Later in the series this code changes in order to support nesting, but I
> think it's still correct, because the EABT class works similarly to
> translation errors, except for stage-1 faults which have CLASS==TT

OK thank you for the confirmation!

Eric
>
> Thanks,
> Jean
>
>> Thanks
>>
>> Eric
>>
>>>              event.u.f_walk_eabt.addr2 = ptw_info.addr;
>>>              break;
>>>          case SMMU_PTW_ERR_TRANSLATION:
>>> @@ -950,6 +952,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>>>                  event.type = SMMU_EVT_F_TRANSLATION;
>>>                  event.u.f_translation.addr = addr;
>>>                  event.u.f_translation.addr2 = ptw_info.addr;
>>> +                event.u.f_translation.class = SMMU_CLASS_IN;
>>>                  event.u.f_translation.rnw = flag & 0x1;
>>>              }
>>>              break;
>>> @@ -958,6 +961,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>>>                  event.type = SMMU_EVT_F_ADDR_SIZE;
>>>                  event.u.f_addr_size.addr = addr;
>>>                  event.u.f_addr_size.addr2 = ptw_info.addr;
>>> +                event.u.f_translation.class = SMMU_CLASS_IN;
>>>                  event.u.f_addr_size.rnw = flag & 0x1;
>>>              }
>>>              break;
>>> @@ -966,6 +970,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>>>                  event.type = SMMU_EVT_F_ACCESS;
>>>                  event.u.f_access.addr = addr;
>>>                  event.u.f_access.addr2 = ptw_info.addr;
>>> +                event.u.f_translation.class = SMMU_CLASS_IN;
>>>                  event.u.f_access.rnw = flag & 0x1;
>>>              }
>>>              break;
>>> @@ -974,6 +979,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>>>                  event.type = SMMU_EVT_F_PERMISSION;
>>>                  event.u.f_permission.addr = addr;
>>>                  event.u.f_permission.addr2 = ptw_info.addr;
>>> +                event.u.f_translation.class = SMMU_CLASS_IN;
>>>                  event.u.f_permission.rnw = flag & 0x1;
>>>              }
>>>              break;


