Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 501B4E77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 17:03:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNxRy-0003nQ-Ip; Wed, 18 Dec 2024 12:03:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNxRw-0003lH-H8
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 12:03:04 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNxRu-0001Rl-BE
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 12:03:04 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3862ca8e0bbso5651041f8f.0
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 09:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734541380; x=1735146180; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MR5KoQU6NXC5lcdjooLgMl/qAwcNdBTJRIvU+ztV38s=;
 b=koQ90HY+mHUJAHvN9sibrLJJZKFcsPOJwnkp6cYA940BRAYMBZsEf7WHSKN04y/poC
 jHr9/3/Cz1A95mM6TWPDyuMU/cwTzo7hX6YoMZLPddD0FMXvuuf7mm7s/5XrHS1hNq33
 T9yVflnFJs3wZqjCoF/Q+pZ6N7jRMMDes0bG/r7EHRL65slZo6QcyyQLkLjm7s4SMup4
 qB9zpr5p/8+gAlj18u2jo+WvVq9+kdfd3AUxOPE+pABLTzeq6CXtWo+HqCIyL8e7Ck9K
 i7OaysyKQVkTvn+kSatduQCyXZ9hJaIGIbDAO9QHPwN8v3QcRAPdPml+f/rLezySmsTL
 uYPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734541380; x=1735146180;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MR5KoQU6NXC5lcdjooLgMl/qAwcNdBTJRIvU+ztV38s=;
 b=imHGmoT9UMVILnoOoXmWMVMDZJH0QuI45h+M0a2CHPpFIHnjn7TdGQYR2hG+Kx5Cl7
 HL2PJO8Cr4qLXcgmGyjoTU9yudVT0xG6r5Nh6zrutAnYqGXzVUaJ1XTwAF/H23ySj6GC
 CYdIrutPdz6uhgeSnEGEBEFg/2hnyLbRfV+1rUtHSTwddGNUwl+4FKSRE1ufl81f4SHN
 XbeZs/Kwi+AVf0xAg5rqyfvRNZ48ex7TtlgLJVrOwIoNiwNG6OwuwBf7KKHUoLzbC+y4
 fYb2V4U4H4kloBEFwrEwnm4nJs2JJmbGrqHXisylQ1f1ji9NuWgdu8U/Cis7iUpHibQA
 BIoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYa+1CzAEPkkGRyRCbyaLFMuq4SsAbIWDDCANcUj98MtugYEB3PN4AEci0AshbYIER0qXj9oVRY8rw@nongnu.org
X-Gm-Message-State: AOJu0YwJJdDhT8doBHNeswKDHGGEV4yq9c4xcN0cHtxXPK+SmShiXzgN
 F8HwuFhyRZrZBLV0V2PTwxoLuOh8nWO3atou1N4ftl7856aqWoEN2GExHlO44mM=
X-Gm-Gg: ASbGnct4gC4DFpUQ6D3glTee2pgQtAUeBOJsZGB+XOfAXY5qamQNPTQawadvvppT9Qd
 CAh9XHi2zXnB0/0TN2I4sy/weO925ygmLerJ5ICD4CvUWai51m46PrGyEDTnELQUIJPLm43cxva
 pBQvPAG1rUQqsItLEujD5lNcjRjrmpz/w4NqVTOoWyg5fkfg7zYjOY+AihNwjaj6uNqJTkYbc3+
 max/DTKgmgxau+4z61LhhgI/a2JdoHVB0kD0fa60zZrAHIJX6TgkDeE9YnZIxrOCSxDw8WP
X-Google-Smtp-Source: AGHT+IFxRFIUncw0hLHKy0Sh5ENrf5mgeFxqM41CrgaeJq9WQh1VqSomamjFX2bptsmvdxjp8dZtlw==
X-Received: by 2002:a5d:6d81:0:b0:386:3a8e:64bd with SMTP id
 ffacd0b85a97d-38a19b05201mr436331f8f.22.1734541378748; 
 Wed, 18 Dec 2024 09:02:58 -0800 (PST)
Received: from [192.168.1.117] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c8046c66sm14386927f8f.69.2024.12.18.09.02.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 09:02:58 -0800 (PST)
Message-ID: <65ea7da3-cf1d-43c8-be93-075855c66e5d@linaro.org>
Date: Wed, 18 Dec 2024 18:02:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] target/ppc: Include missing headers in
 mmu-hash[32,64].h
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org
References: <20241218155202.71931-1-philmd@linaro.org>
 <20241218155202.71931-2-philmd@linaro.org>
 <1b2eeff6-e559-449a-b3cf-3d1e0001f56e@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <1b2eeff6-e559-449a-b3cf-3d1e0001f56e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 18/12/24 17:41, Richard Henderson wrote:
> On 12/18/24 09:51, Philippe Mathieu-Daudé wrote:
>> CPUState* is dereferenced, so we need the structure definition
>> from "cpu.h". PowerPCCPU is declared in "cpu-qom.h". Include
>> them in order to avoid when refactoring:
>>
>>    In file included from ../../target/ppc/cpu_init.c:27:
>>    target/ppc/mmu-hash32.h:6:23: error: unknown type name 'PowerPCCPU'
>>        6 | bool ppc_hash32_xlate(PowerPCCPU *cpu, vaddr eaddr, 
>> MMUAccessType access_type,
>>          |                       ^
>>    target/ppc/mmu-hash32.h:66:15: error: incomplete definition of type 
>> 'struct ArchCPU'
>>       66 |     return cpu->env.spr[SPR_SDR1] & SDR_32_HTABORG;
>>          |            ~~~^
>>    target/ppc/mmu-hash64.h:173:36: error: unknown type name 
>> ‘PowerPCCPU’; did you mean ‘PowerPCCPUAlias’?
>>      173 | static inline void ppc_hash64_init(PowerPCCPU *cpu)
>>          |                                    ^~~~~~~~~~
>>          |                                    PowerPCCPUAlias
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/ppc/mmu-hash32.h | 3 +++
>>   target/ppc/mmu-hash64.h | 2 ++
>>   2 files changed, 5 insertions(+)
>>
>> diff --git a/target/ppc/mmu-hash32.h b/target/ppc/mmu-hash32.h
>> index 2838de031c7..abbff206d4e 100644
>> --- a/target/ppc/mmu-hash32.h
>> +++ b/target/ppc/mmu-hash32.h
>> @@ -3,6 +3,9 @@
>>   #ifndef CONFIG_USER_ONLY
>> +#include "target/ppc/cpu-qom.h"
>> +#include "cpu.h"
> 
> cpu.h handles cpu-qom.h.
> Do we really need both?

"cpu-qom.h" is the one I want. Currently we need "cpu.h" for all the
inlined functions dereferencing ArchCPU, like ppc_hash32_hpt_base(),
but long term it should be avoided in .h because sources become too
specific. Here we want to link the different MMU 32/64 in the same
PPC binary, having 2 different ArchCPU implementations. This patch
is quite old now so I don't remember well, I'll revisit and see if
it is still necessary.

>> +
>>   bool ppc_hash32_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType 
>> access_type,
>>                         hwaddr *raddrp, int *psizep, int *protp, int 
>> mmu_idx,
>>                         bool guest_visible);
>> diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
>> index ae8d4b37aed..b32e17c2c58 100644
>> --- a/target/ppc/mmu-hash64.h
>> +++ b/target/ppc/mmu-hash64.h
>> @@ -3,6 +3,8 @@
>>   #ifndef CONFIG_USER_ONLY
>> +#include "target/ppc/cpu-qom.h"
>> +
>>   #ifdef TARGET_PPC64
>>   void dump_slb(PowerPCCPU *cpu);
>>   int ppc_store_slb(PowerPCCPU *cpu, target_ulong slot,
> 


