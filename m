Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D55FC369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 16:10:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7cfS-0007Mn-FN; Wed, 23 Apr 2025 12:09:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u7cfQ-0007MZ-Fg
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 12:09:44 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u7cfO-0000ZO-HP
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 12:09:44 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-736aa9d0f2aso8287369b3a.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 09:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745424580; x=1746029380; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3FvwZcXatJm3X5qO04axWJ7Kvcw5ht7/qVoQmgqNZw4=;
 b=bVJb8nyAI6nNjw/C+c5wp9vVcHKF1GgU0llJeh7VsKMV37aLhSuYdqU42RSALZLpk8
 i0iopx9Wik346imodzre5SM35/is6y0P9UBcHbeU85GNI7FN9LE1CHrfgYsl0agwAir6
 mO+oUkuv14o7YdrKqbKoYPUMg1Ss7F6dzuKuHtnnUS0cO2RqEeskjVz6HRQMjPKJl4cG
 qI/SPoWsAkFM2l4j495TxieE9N1JQkD8OdZgTU8w+loXA79mkfEGEKF39sV2L56smFi2
 t59vFDZmngODQFl9iXzB1tLY42Z7YGHcbj6e0ZnkNVaXiYgiwf4H7/LdvLxmet+kurs2
 PaiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745424580; x=1746029380;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3FvwZcXatJm3X5qO04axWJ7Kvcw5ht7/qVoQmgqNZw4=;
 b=P+llgketFng9qmIPQwdzjR1gCWpQzlYlqhOTSAc7HwsCUzjeQingXEcHhsHhWhflKX
 Apz4zoMlSsnMO01mt/ldiz1PK1i/Ze327i9x08QGT5I985nTBF2O9Vfc8myQTEgz9pFM
 MH6Kunt+bZQyfcAyE2FLIHmATYeXXCIstNkj7yIdpwIUdA5tXf7q0pE0cKyxvhRH/kku
 81ZF2hKWKpsTfsuY0RKuS2uG0B2yPbKnvFHuwmd781q6/XicCxk9ppobV5rI+/NvgeK5
 MLZ26GeT5LiLm4wVgWyz5ojvpoVM8Mci6GkvH/Lv9Sx7esIxhCpp3fN6mfWXYdyLz2mp
 kiHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVonM9OXVZqFkkmoPHMIqez0MxhbxYiBSD+XeQBnHqGKDHkybl60Id3jR5zXAZe1pUPz3Iifb6lNcn/@nongnu.org
X-Gm-Message-State: AOJu0Yz8inEyGqyNk81bIlreejuYZtKL6qiPeLv8mXxZELdV9/idgAgJ
 R3o26AQJs3RytbGSn5SFvIFaLbuj1WpmKkttiAK2N1TYGq1zigHIvjbezH5jmWc=
X-Gm-Gg: ASbGncsMoPdtg0LZHFSpp6ziwGvxKej/Fy948ol5xaZpru9tEBMgBqvsVeqB45fX01h
 dh0s+Od6+MB57InlifXF/zDroTUE7ZL69+Kphera52NelZW2SDqHXkualoG1iSxJ+gXrvMjVoZR
 dxCZhFaXEl7p3ytyArxL8JMGBROM/QZMBq5vj+OH06nEMMLvctkzBfUOvNTum7Yx0rC+GqakU77
 RJQGysmLy/1WT3hBT4zI94npHcLLeL1ZioFEpmUJVSb6vL9jg8h+vViuZE0BYohxAJqlWCVxpg+
 yGA4152gPynMOmkDGIkr2iJlLTqkNuE7jxr5bhIpxTSFTIwZrVHyFA==
X-Google-Smtp-Source: AGHT+IFKIGEKAI7qcb0XZS0cq/w+b+B1xJudNJI1tlN3oPHtYNhXnjG7UmwNFm0wovYPry42HEJ/BA==
X-Received: by 2002:a05:6a00:3a22:b0:736:5822:74b4 with SMTP id
 d2e1a72fcca58-73e21ca977amr36037b3a.21.1745424579635; 
 Wed, 23 Apr 2025 09:09:39 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73dbf8c0228sm10622105b3a.25.2025.04.23.09.09.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 09:09:39 -0700 (PDT)
Message-ID: <f3ce25db-36dd-41fb-be98-45db9716634d@linaro.org>
Date: Wed, 23 Apr 2025 09:09:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 105/147] exec/cpu-all: remove tswap include
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250422192819.302784-1-richard.henderson@linaro.org>
 <20250422192819.302784-106-richard.henderson@linaro.org>
 <86ba7919-db11-45cd-8bdd-ede8f25f92d2@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <86ba7919-db11-45cd-8bdd-ede8f25f92d2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x434.google.com
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

On 4/23/25 03:27, Philippe Mathieu-Daudé wrote:
> On 22/4/25 21:27, Richard Henderson wrote:
>> From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> Message-ID: <20250325045915.994760-7-pierrick.bouvier@linaro.org>
>> ---
>>    include/exec/cpu-all.h               | 1 -
>>    target/ppc/mmu-hash64.h              | 2 ++
>>    target/i386/tcg/system/excp_helper.c | 1 +
>>    target/i386/xsave_helper.c           | 1 +
>>    target/riscv/vector_helper.c         | 1 +
>>    5 files changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
>> index 957c86886e..bfa039ab76 100644
>> --- a/include/exec/cpu-all.h
>> +++ b/include/exec/cpu-all.h
>> @@ -21,7 +21,6 @@
>>    
>>    #include "exec/cpu-common.h"
>>    #include "exec/cpu-interrupt.h"
>> -#include "exec/tswap.h"
>>    #include "hw/core/cpu.h"
>>    #include "exec/cpu-defs.h"
>>    #include "exec/target_page.h"
>> diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
>> index ae8d4b37ae..b8fb12a970 100644
>> --- a/target/ppc/mmu-hash64.h
>> +++ b/target/ppc/mmu-hash64.h
>> @@ -1,6 +1,8 @@
>>    #ifndef MMU_HASH64_H
>>    #define MMU_HASH64_H
>>    
>> +#include "exec/tswap.h"
> 
> This header doesn't use "exec/tswap.h". Maybe you want this
> reviewed patch instead:
> 
> https://lore.kernel.org/qemu-devel/20241211230357.97036-6-philmd@linaro.org/
> 
>> +
>>    #ifndef CONFIG_USER_ONLY
>>    
>>    #ifdef TARGET_PPC64
> 

See: [PATCH 002/147] exec/tswap: implement {ld,st}.*_p as functions 
instead of macros.
It removes macro definitions from cpu-all.h, and implement those as 
proper functions in exec/tswap.h.

ppc/mmu-hash64.h uses ld*_p, which are defined in exec/tswap.h, so it's 
the correct place for this include.

