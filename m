Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D347DC4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 10:31:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2Thh-0007Ux-LX; Thu, 02 May 2024 06:30:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s2Thf-0007UO-M6
 for qemu-devel@nongnu.org; Thu, 02 May 2024 06:30:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s2Thc-0006jX-VV
 for qemu-devel@nongnu.org; Thu, 02 May 2024 06:30:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714645811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K5JL8Ms+ibese4eVihYqXTNgBEuoz1xU9QRy8DCEBd4=;
 b=CztdUtl0RAWdam7SgPHSa3luCY7I1SiQ0Qdzf7frjgFIIC8kS8hkhdPcY10YfTghmDj/20
 nflYDWox2PlbGasiusNQ0ayzNoICVVerjHre9jmHGJW+5Hsx+TWFZPNp4vhp7iDlqMG2bA
 oaNF3sVmHgIgSiF1u8JBXsbJtoq7gHM=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-jQnlXq7rNJePUM4JV9qvxQ-1; Thu, 02 May 2024 06:30:10 -0400
X-MC-Unique: jQnlXq7rNJePUM4JV9qvxQ-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2d855c0362bso64990191fa.3
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 03:30:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714645809; x=1715250609;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K5JL8Ms+ibese4eVihYqXTNgBEuoz1xU9QRy8DCEBd4=;
 b=CNES0lStaDMn6xFb9pvgWjYEbbaSlV7B9DBkG0P30XEjqeXMTofhKM2zL20TEmt6by
 +1M3zUhgqILZ8KtyQv38Jveqh+Gtw9WdDTiCVdlTs1tpOwSppItabxxq2eTJQxmRwcVM
 yUE0Ibp93PAhv8b+2BQnSsaAtArmsgWBPYfFNAE11lBjb5DzsvmB0PgzCBFG8XDnHYuh
 +Zyr5B8x9+izn6GF3XrFOUFMIg6BwqOGqftzMU7c0xnoHxxZWDND3qWcbpcZxKNHbLYr
 c0eoZJaaQxKjMdonrjg+G7p8F1gT9RoPJqR7Ld+4qbyZ4aU2hbSOvWGDsTRIBDVJdI2r
 PHeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvXLwAtbv1sAooMCKkdrwsEpYkS+S+FrKQDTmUWIDxO3w3veX8Cksie23e6/pns1+t5SYWW2uI9oEgiCWDuxlptLMIVNI=
X-Gm-Message-State: AOJu0YxkiiE57tM9LLq8Lq+MqTWGdvg9p6J1jS9bsz3DeAB050HQd0PT
 S9iDCoE3WPvW+Z/mTLnByEBp8tr2TXHnDvMCA9onyZeGdJZ+TXzyp6cGs6MLLvCkyrGMdDBGzX8
 xV2U/bMwloPR5NSS9fkd87NVDjsEp5KPqaRE3pQzE8alXCnWPfj0L
X-Received: by 2002:a2e:9101:0:b0:2e2:f2d:b8ad with SMTP id
 m1-20020a2e9101000000b002e20f2db8admr178828ljg.26.1714645808747; 
 Thu, 02 May 2024 03:30:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8PUPxjEMRrEYPboat0OKyrFw9LLZigdHEQJQ8CYOudGBISqoWGVIWEUc2WZXX16LJJ9KD6g==
X-Received: by 2002:a2e:9101:0:b0:2e2:f2d:b8ad with SMTP id
 m1-20020a2e9101000000b002e20f2db8admr178810ljg.26.1714645808356; 
 Thu, 02 May 2024 03:30:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 s7-20020a05600c384700b0041c12324eb6sm5254607wmr.22.2024.05.02.03.30.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 May 2024 03:30:07 -0700 (PDT)
Message-ID: <e2aa7e67-cda6-4f0b-9289-acb88cf3a624@redhat.com>
Date: Thu, 2 May 2024 12:30:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/19] range: Introduce range_get_last_bit()
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>
References: <20240429065046.3688701-1-zhenzhong.duan@intel.com>
 <20240429065046.3688701-7-zhenzhong.duan@intel.com>
 <bc6b71f7-242f-4de4-b440-67689039886a@redhat.com>
 <SJ0PR11MB67440124211B42A33071CAED921A2@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <SJ0PR11MB67440124211B42A33071CAED921A2@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.897,
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

On 4/30/24 11:58, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Cédric Le Goater <clg@redhat.com>
>> Subject: Re: [PATCH v3 06/19] range: Introduce range_get_last_bit()
>>
>> On 4/29/24 08:50, Zhenzhong Duan wrote:
>>> This helper get the highest 1 bit position of the upper bound.
>>>
>>> If the range is empty or upper bound is zero, -1 is returned.
>>>
>>> Suggested-by: Cédric Le Goater <clg@redhat.com>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> ---
>>>    include/qemu/range.h | 11 +++++++++++
>>>    1 file changed, 11 insertions(+)
>>>
>>> diff --git a/include/qemu/range.h b/include/qemu/range.h
>>> index 205e1da76d..8e05bc1d9f 100644
>>> --- a/include/qemu/range.h
>>> +++ b/include/qemu/range.h
>>> @@ -20,6 +20,8 @@
>>>    #ifndef QEMU_RANGE_H
>>>    #define QEMU_RANGE_H
>>>
>>> +#include "qemu/bitops.h"
>>> +
>>>    /*
>>>     * Operations on 64 bit address ranges.
>>>     * Notes:
>>> @@ -217,6 +219,15 @@ static inline int ranges_overlap(uint64_t first1,
>> uint64_t len1,
>>>        return !(last2 < first1 || last1 < first2);
>>>    }
>>>
>>> +/* Get highest non-zero bit position of a range */
>>> +static inline int range_get_last_bit(Range *range)
>>> +{
>>> +    if (range_is_empty(range) || !range->upb) {
>>> +        return -1;
>>> +    }
>>> +    return find_last_bit(&range->upb, sizeof(range->upb));
>>
>> This breaks builds on 32-bit host systems.
> 
> Oh, I missed 32bit build. Thanks, will fix.

This should provide the same result ?

     return 63 - clz64(range->upb);

Thanks,

C.



