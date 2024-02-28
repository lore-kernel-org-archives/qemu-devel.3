Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEC74C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 18:28:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfOek-0007OM-07; Wed, 28 Feb 2024 13:27:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1rfOeg-0007Ne-RA
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 13:27:46 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1rfOee-0006a8-90
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 13:27:46 -0500
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 97AF23FA51
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 18:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1709144861;
 bh=kZvENfPhbSwqdNEm6dXborXlxbm5KH21OpV2E2o9eT4=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=jENBPOXXyT7PRVs3Q11g69e4qKC6x0b971N8sGhm5tP7eYOj3EPaHcAjkFMC9Zsn8
 CS8FVJcs9lfj+t4kX+yjCSwbzgwOktNl0g0mHidIbBCWAc8w2hRii6iP16/IhrKhM2
 cUpakqpWKknyKI8IwBjQAdHH0z2MV+n7/bnk28tnwTAHUrZXcZbDCKEcFu+cjWvXTz
 7HAp1/5TKeo6kIT9lW2RjhYleaK0TxJHwfRZ4VYuONUbPTQdmPvB8RfZ2E+krVvUc5
 lld62hBSk3zD7t0g/zsOxrxFPMKi3TU+dSThaUP2DtO9hOMvX+6LuNN75CVsfnRykr
 7I9vOFhv4JwRA==
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5664cac7b14so102580a12.0
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 10:27:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709144861; x=1709749661;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kZvENfPhbSwqdNEm6dXborXlxbm5KH21OpV2E2o9eT4=;
 b=qLEpj/JknpNKBASqZo+Pk5yRmtIhJM9l62gQQTHbJsIaKMlYw4SVtS4P0h54J891dw
 Sc0HXg6SvPQCg8VY+NZszqR73W9osPM5kKv67qp7SDRnfrxzUuZY2r8B7i4x7MEP0jXY
 X/KsQAWLcLDLno9g3/bkCMDCMhbzqI/bn0I9v2f04LoBU4QqfVm3xknJ0PTKDRxLL+Ow
 nIqxOhpWsJAiVMPMuNTjN0u4K/WO5BkZkSrPO/kPywLZsmsnlhnw7JPwMAKF7xwRnpLU
 QUqDmFytz+FPhjVsLzRs7m4YzRAxk9V5H3qLoWs9wUm5fuM+dEj5uxGcDimEmT3iH3uA
 8gLg==
X-Gm-Message-State: AOJu0YyyLvAe8epKGNu5LmGdaSR+uRfgxacJYU5I56FR3nnGUBEK7+Em
 Cx48+8V4WuScXAJDJqNCSAWhDxZ9ORMKNA1uHjYZls6A+By/k8i30v3N0MQKjdYyYlXhQNvqnEV
 kYYg3awB1FKdQobhAvBfBYrONkxk+AUkAs53vM1GvIDz73yYjvCABYy/LV3QCdEo2wJYQ
X-Received: by 2002:aa7:c442:0:b0:564:54c6:6903 with SMTP id
 n2-20020aa7c442000000b0056454c66903mr161368edr.7.1709144861242; 
 Wed, 28 Feb 2024 10:27:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFdacuHXKISpgSoFjoH+LjHC96HeVq7xexBKu2WF4uDHoR/OFTYnSFFVsUdgWAf8QH2BIF0/Q==
X-Received: by 2002:aa7:c442:0:b0:564:54c6:6903 with SMTP id
 n2-20020aa7c442000000b0056454c66903mr161357edr.7.1709144860857; 
 Wed, 28 Feb 2024 10:27:40 -0800 (PST)
Received: from ?IPV6:2a00:20:10:8f6:59d8:16c:6bf7:73e4?
 ([2a00:20:10:8f6:59d8:16c:6bf7:73e4])
 by smtp.gmail.com with ESMTPSA id
 s21-20020aa7cb15000000b005645961ad39sm2021834edt.47.2024.02.28.10.27.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Feb 2024 10:27:40 -0800 (PST)
Message-ID: <b9937680-8c0b-46f6-86ef-55139562e2c4@canonical.com>
Date: Wed, 28 Feb 2024 19:27:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH, v2] physmem: avoid bounce buffer too small
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20240228125939.56925-1-heinrich.schuchardt@canonical.com>
 <fb6ef90d-4a3e-4bdd-8516-8b15c1f2329f@linaro.org>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <fb6ef90d-4a3e-4bdd-8516-8b15c1f2329f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.125.188.122;
 envelope-from=heinrich.schuchardt@canonical.com;
 helo=smtp-relay-internal-0.canonical.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 28.02.24 16:06, Philippe Mathieu-Daudé wrote:
> Hi Heinrich,
> 
> On 28/2/24 13:59, Heinrich Schuchardt wrote:
>> virtqueue_map_desc() is called with values of sz exceeding that may 
>> exceed
>> TARGET_PAGE_SIZE. sz = 0x2800 has been observed.
>>
>> We only support a single bounce buffer. We have to avoid
>> virtqueue_map_desc() calling address_space_map() multiple times. 
>> Otherwise
>> we see an error
>>
>>      qemu: virtio: bogus descriptor or out of resources
>>
>> Increase the minimum size of the bounce buffer to 0x10000 which matches
>> the largest value of TARGET_PAGE_SIZE for all architectures.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>> v2:
>>     remove unrelated change
>> ---
>>   system/physmem.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/system/physmem.c b/system/physmem.c
>> index e3ebc19eef..3c82da1c86 100644
>> --- a/system/physmem.c
>> +++ b/system/physmem.c
>> @@ -3151,8 +3151,12 @@ void *address_space_map(AddressSpace *as,
>>               *plen = 0;
>>               return NULL;
>>           }
>> -        /* Avoid unbounded allocations */
>> -        l = MIN(l, TARGET_PAGE_SIZE);
>> +        /*
>> +         * There is only one bounce buffer. The largest occuring 
>> value of
>> +         * parameter sz of virtqueue_map_desc() must fit into the bounce
>> +         * buffer.
>> +         */
>> +        l = MIN(l, 0x10000);
> 
> Please define this magic value. Maybe ANY_TARGET_PAGE_SIZE or
> TARGETS_BIGGEST_PAGE_SIZE?
> 
> Then along:
>    QEMU_BUILD_BUG_ON(TARGET_PAGE_SIZE <= TARGETS_BIGGEST_PAGE_SIZE);

Thank you Philippe for reviewing.

TARGETS_BIGGEST_PAGE_SIZE does not fit as the value is not driven by the 
page size.
How about MIN_BOUNCE_BUFFER_SIZE?
Is include/exec/memory.h the right include for the constant?

I don't think that TARGET_PAGE_SIZE has any relevance for setting the 
bounce buffer size. I only mentioned it to say that we are not 
decreasing the value on any existing architecture.

I don't know why TARGET_PAGE_SIZE ever got into this piece of code. 
e3127ae0cdcd ("exec: reorganize address_space_map") does not provide a 
reason for this choice. Maybe Paolo remembers.

Best regards

Heinrich

> 
>>           bounce.buffer = qemu_memalign(TARGET_PAGE_SIZE, l);
>>           bounce.addr = addr;
>>           bounce.len = l;
> 


