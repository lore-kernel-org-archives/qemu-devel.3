Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49E23CAC59A
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 16:45:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyvGv-00028q-2B; Wed, 17 Sep 2025 12:44:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uyvFV-0001Uh-Ah
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 12:43:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uyvFS-0006m0-Oz
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 12:43:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758127394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=cF+XbhQV08JqnRQnwMd0zvV6KTMFIVPdSKK/ivNIoDw=;
 b=CUh9rmmh4uiM8lkEownkVs5s/O+/WGQZfujqSvo9H1unpXTH9EvlLK9V0IGHyeQkTNI64l
 ZYQh3nrFktEONJVkr8bJo8gsNcWtLE6dlWypmOuMk9nSZFjtfmo3Dcgl2TndGF+HwiaMq2
 dIThL5Mu/8TjWNIhRi32QX9U8hZz/WI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-NoIIGQivP9q1V864wePhTg-1; Wed, 17 Sep 2025 12:43:06 -0400
X-MC-Unique: NoIIGQivP9q1V864wePhTg-1
X-Mimecast-MFC-AGG-ID: NoIIGQivP9q1V864wePhTg_1758127385
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-b047a0345eeso591586566b.3
 for <qemu-devel@nongnu.org>; Wed, 17 Sep 2025 09:43:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758127385; x=1758732185;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cF+XbhQV08JqnRQnwMd0zvV6KTMFIVPdSKK/ivNIoDw=;
 b=nN9liycY4lpA1V/754DxZ2fXTDCBMgWw775Ep7L9EekR9gQijrO6jknrL0Ym6C5rwq
 LjwoXHZl5bhvD4VzWgrFw+kBM5NsaVD4w3IYSmyUodu1h9PSw+BTVcxlHQOS5HpaEy7J
 EUzkHnlj4jtsY3d/qQHkG9FUvF8lrdswTNw3/ztjXYCtNbvWBVal3nlr+PlJMO0iKwHs
 BgUYF5VL1ZTqrDvLnjszENUDvKk50eYSO9HxWR8FOHq5POaLQgtTpUBsAN2PrOtq8KPo
 X1ttSIrxT9cG+N1yVS8AvQTwdyPFDqeXyu6C3owoQhjUcWNiKJoexV1/exjy29V0ncBp
 8Gng==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbasgr5QO7Jkj78lfOABD21LmN5y+jgCRJtsa4g8bkVrGHNPdhcsrsJzP5Hca0yAbRMRta9DpE8/Jj@nongnu.org
X-Gm-Message-State: AOJu0YzyKI/vsc6l8Db4sh0yj0hxZYIrUA+tN5hs09gpfSoDkrCqenPw
 l+0TPGpYxgejy6BifwE32gvNchabf7p0ZxYYz+DwWuZxqfd4U3Kz30UuE4msnwNVUi/vxpiiJeq
 PBgPROVVSnl4uJ3J/kIryohyhjH/KbER2JtiaEvI8sfBti82wwuMTYEqA
X-Gm-Gg: ASbGncsLOQ/h62CCMogFfgCcSfAu6t3FpyRf4sOso+qGfLN75QNIdqSmgGJqo38dqNU
 cgH39ZM/ERCZafvSgec49RWMFjZEK123n53svXKrbCjcdxeiAFYEaO/AZ6K1YAdmkkgTaPAROpS
 bTNB0lU0IUcRk8zMnStjzdVVUAd0eRrQACHx4VhobpjIPgVIl2AdmOpeJubYGSpg4TZUt7ZHxo+
 eaRWR0FmHZcC6CyDjHH09zVkF+EtslL8XhuCLEa3H6bt5HHmJ1NgrvlXrfxqyrEkGIbgNd36PF9
 3HHvMWp2/DVfWU9BbeGoLrAbZ3b2HDgHoz2jbDjczKYEFB9Sui4azOZLu6AjyrqKCdEjpGt4Ezi
 xBPRhoQ==
X-Received: by 2002:a17:907:6e9e:b0:b07:c815:242a with SMTP id
 a640c23a62f3a-b1bbc731e33mr329329566b.52.1758127385291; 
 Wed, 17 Sep 2025 09:43:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDZH1Hv3AOiSzJzZ8UhhrWyT1bzCqfIRsDJ4zq2gHCQQMIFn11exz7Pw40j8OEmBef52QhWA==
X-Received: by 2002:a17:907:6e9e:b0:b07:c815:242a with SMTP id
 a640c23a62f3a-b1bbc731e33mr329327766b.52.1758127384854; 
 Wed, 17 Sep 2025 09:43:04 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-113-218.pools.arcor-ip.net.
 [47.64.113.218]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b1fba8d2700sm8765066b.0.2025.09.17.09.43.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Sep 2025 09:43:04 -0700 (PDT)
Message-ID: <f698514c-798f-43f8-80cb-dc1b35b15f5e@redhat.com>
Date: Wed, 17 Sep 2025 18:43:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/9] target/ppc: Add IBM PPE42 special instructions
To: BALATON Zoltan <balaton@eik.bme.hu>, Miles Glenn <milesg@linux.ibm.com>
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, clg@redhat.com, npiggin@gmail.com, rathc@linux.ibm.com,
 richard.henderson@linaro.org
References: <20250912164808.371944-1-milesg@linux.ibm.com>
 <20250912164808.371944-7-milesg@linux.ibm.com>
 <a419ef55-d0d5-4d88-8302-ebcc9a8c4bab@linux.ibm.com>
 <db99b84a-4d7c-49af-8185-97db09843006@redhat.com>
 <14ea64c1c7c2f9e154b0d607d88b737adb067127.camel@linux.ibm.com>
 <2e4a6d39-650e-74a4-ad60-56d5422c83a1@eik.bme.hu>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <2e4a6d39-650e-74a4-ad60-56d5422c83a1@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 17/09/2025 18.07, BALATON Zoltan wrote:
> On Wed, 17 Sep 2025, Miles Glenn wrote:
>> On Wed, 2025-09-17 at 08:20 +0200, Thomas Huth wrote:
>>> On 17/09/2025 06.57, Harsh Prateek Bora wrote:
>>>>
>>>> On 9/12/25 22:17, Glenn Miles wrote:
>>>>> Adds the following instructions exclusively for
>>>>> IBM PPE42 processors:
>>>>>
>>>>>    LSKU
>>>>>    LCXU
>>>>>    STSKU
>>>>>    STCXU
>>>>>    LVD
>>>>>    LVDU
>>>>>    LVDX
>>>>>    STVD
>>>>>    STVDU
>>>>>    STVDX
>>>>>    SLVD
>>>>>    SRVD
>>>>>    CMPWBC
>>>>>    CMPLWBC
>>>>>    CMPWIBC
>>>>>    BNBWI
>>>>>    BNBW
>>>>>    CLRBWIBC
>>>>>    CLRWBC
>>>>>    DCBQ
>>>>>    RLDICL
>>>>>    RLDICR
>>>>>    RLDIMI
>>>>>
>>>>> A PPE42 GCC compiler is available here:
>>>>> https://github.com/open-power/ppe42-gcc
>>>>>
>>>>> For more information on the PPE42 processors please visit:
>>>>> https://wiki.raptorcs.com/w/images/a/a3/PPE_42X_Core_Users_Manual.pdf
>>>>>
>>>>> Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
>>>>> ---
>>>>> Changes from v3:
>>>>>    - Removed copy of CHECK_VDR
>>>>>    - Refactored ld/st instructions
>>>>>
>>>>>   target/ppc/insn32.decode            |  66 ++-
>>>>>   target/ppc/translate.c              |  29 +-
>>>>>   target/ppc/translate/ppe-impl.c.inc | 665 ++++++++++++++++++++++++++++
>>>>>   3 files changed, 750 insertions(+), 10 deletions(-)
>>>>>   create mode 100644 target/ppc/translate/ppe-impl.c.inc
>>>>>
>>>>
>>>> <snip>
>>>>
>>>>> diff --git a/target/ppc/translate/ppe-impl.c.inc b/target/ppc/translate/
>>>>> ppe-impl.c.inc
>>>>> new file mode 100644
>>>>> index 0000000000..792103d7c2
>>>>> --- /dev/null
>>>>> +++ b/target/ppc/translate/ppe-impl.c.inc
>>>>> @@ -0,0 +1,665 @@
>>>>> +/*
>>>>> + * IBM PPE Instructions
>>>>> + *
>>>>> + * Copyright (c) 2025, IBM Corporation.
>>>>> + *
>>>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>>>> + */
>>>>> +
>>>>> +
>>>>> +#if !defined(TARGET_PPC64)
>>>>> +static bool vdr_is_valid(uint32_t vdr)
>>>>> +{
>>>>> +    const uint32_t valid_bitmap = 0xf00003ff;
>>>>> +    return !!((1ul << (vdr & 0x1f)) & valid_bitmap);
>>>>> +}
>>>>> +
>>>>> +static bool ppe_gpr_is_valid(uint32_t reg)
>>>>> +{
>>>>> +    const uint32_t valid_bitmap = 0xf00027ff;
>>>>> +    return !!((1ul << (reg & 0x1f)) & valid_bitmap);
>>>>> +}
>>>>> +#endif
>>>>> +
>>>>> +#define CHECK_VDR(CTX, VDR)                             \
>>>>> +    do {                                                \
>>>>> +        if (unlikely(!vdr_is_valid(VDR))) {             \
>>>>> +            gen_invalid(CTX);                           \
>>>>> +            return true;                                \
>>>>> +        }                                               \
>>>>> +    } while (0)
>>>>> +
>>>>> +#define CHECK_PPE_GPR(CTX, REG)                         \
>>>>> +    do {                                                \
>>>>> +        if (unlikely(!ppe_gpr_is_valid(REG))) {         \
>>>>> +            gen_invalid(CTX);                           \
>>>>> +            return true;                                \
>>>>> +        }                                               \
>>>>> +    } while (0)
>>>>> +
>>>>> +#define VDR_PAIR_REG(VDR) (((VDR) + 1) & 0x1f)
>>>>> +
>>>>> +#define CHECK_PPE_LEVEL(CTX, LVL)                       \
>>>>> +    do {                                                \
>>>>> +        if (unlikely(!((CTX)->insns_flags2 & (LVL)))) { \
>>>>> +            gen_invalid(CTX);                           \
>>>>> +            return true;                                \
>>>>> +        }                                               \
>>>>> +    } while (0)
>>>>> +
>>>>> +static bool trans_LCXU(DisasContext *ctx, arg_LCXU *a)
>>>>> +{
>>>>> +#if defined(TARGET_PPC64)
>>>>> +    return false;
>>>>> +#else
>>>>
>>>> If we are building the PPE42 instructions only for !TARGET_PPC64, does
>>>> it still make it usable with qemu-system-ppc64?
>>>
>>> As explained in an earlier thread already, qemu-system-ppc64 is a superset
>>> of qemu-system-ppc. Thus the ppe42 stuff should work in qemu-system- 
>>> ppc64, too.
>>>
>>>   Thomas
>>>
>>
>> Ah, yes, I don't think I fully understood the ramifications of Thomas's
>> statements earlier.  Looks like I'll need to scrub the code to ensure
>> that PPE42 can run even if TARGET_PPC64 is defined.
>>
>> Cedric, this requires me to change my response to your request to add
>> the check for TARGET_PPC64 inside the is_ppe() function.  I will need
>> to leave that function as-is if we want PPE42 to be supported in both
>> targets.  Will you be ok with that?
> 
> Does it make sense to support it with !TARGET_PPC64 if its only use is in 
> qemu-system-ppc64? Even if the CPU is 32-bit it has some 64-bit instructions 
> IIUC so does that make it TARGET_PPC64 only?

As long as the GPRs are 32 bit only (which is the case here, I assume), it's 
a 32-bit PPC CPU, isn't it? So that certainly should not go into the ppc64 
binary only.

  Thomas


