Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21FA51076387
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 17:38:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7zVr-00072X-8c; Wed, 01 Apr 2026 13:37:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w7zVp-000722-2C
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 13:37:53 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w7zVn-0004JY-9Q
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 13:37:52 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-35d99bae2ebso3977005a91.3
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 10:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775065070; x=1775669870; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/JGemNzKw2+46l6L5/WRcnaXeyFfe6THPM44+90gQ2k=;
 b=gc6847A4imzu6Zfs4qmeMze7b6zZidu9wBqdrvBpcUTtV93Ftpfmf/3jCMsfR4i3cH
 336xo4EDMsuilOCanE/EhGBRj53i9Q79D+8lVU6BZDiW6GRV158qzZwhqthyTCkz8drr
 6fysoiaPwrJQPOcVrU+sDeoOgaex68/LcRDet0YRM2SlAgXWpDjUBmKPNl6pT9KIG3b1
 2M/5NZhbALaB7b50+OFPTWLVkMtRSMSb3uqIsWeJtEv//ZBvmpO1lauYxZhDvqh5eck9
 t1MqWV9Rtm08A3M/gZWc0Z1+zN17PvG7I6QbJaHgU5lfXo8WZ9x6afV4edJXEiwHRi1b
 23gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775065070; x=1775669870;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/JGemNzKw2+46l6L5/WRcnaXeyFfe6THPM44+90gQ2k=;
 b=aTKqz+CBesiGO+/DpBMPhhA8F5xYJj6JpYsbUS8dLlSz5Q4CB/b/E1jhQVPY17fQWI
 kk3sA+7sjoE1CO6yeLnsa4MKfzomJruwDEAWdtTtYISnJrKSDxdUiZc60eZR+LWWuzkK
 y0kFQ6DQ9Kp4nwGgYW4Up1Eud7aqQSL74TEZ6VyDhJf/OyL83zThXsh1kTS8qlR3wNgl
 cAns0LDg+piCvZM2B1oYBbts561pyzcFBojOwOrq7GwUs93YTIKhX/MUQmxU5MY6dSLA
 bge9fI/CpV8hjMVzKEOhfLpGPdW3b3ljiZs9vzbNNk1TGOVdKWe9xXIo0G7hez1jeNqV
 5XzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXraK1updpqtjjbnivkHNPAcRmx3Fk8VG7k1id/l4HTAs9JQ9dQUTR35PQqlL3a/5+ix/9nnv5fTfvm@nongnu.org
X-Gm-Message-State: AOJu0YyISTheABF1U0MB0dFoSURts6LwuFji2S1F/lMkpdUyC3Zkk4g2
 YlJHWyfhUYfnNtPM14BIAQAM66JR9rvwYtMobKAoYmVzkI1oF/CzbCfHWy3gy9Hm67M=
X-Gm-Gg: ATEYQzxPxpE74AFdrApseD7imeZm8JzbYMih1T8JREZXx4Q4rrazCEfcNZWGuDLHEas
 pp+FKEFoVK2pn14TVhDov0Dc0v4WL7aNXV1CdT7jYsVfft/wReYADzjKhhhS5hd3nRCEbAEcCMH
 06YhXdDt9Y4hrKtdWuGEBuFbq07ej3sVTYTIjSKyPbTACERBLsKZzWE0dXtIB+s0zoOZmThH44Z
 toXxhXclLL2e8aw1/BeKBkHIshU78yeH1TwndO8UEDtpOiGNgCreVhP6MPri56+Tj36Tt1+Y/4i
 r8yOXfUqdyIsYBL5lU/8Yu/I0ZU0SvQbFUrJq7s+1dXNKZvf5RB1vksqhORLnzPMtSGX5eb4CTg
 vdCeyMh9IcHIXv0iU2ARMWzvQAXA623jAFq6ZAyCItwnv5XDB1hsk/J+/p3bs8zmsnH+ET87QVa
 KJdG4wQSWjO91eQ3MlPJfkciQrifwsXyrahCGW7RaLLv++46FeLRIfwlGoilUI+v2gqkNx
X-Received: by 2002:a17:902:e851:b0:2ae:b9cd:d2ce with SMTP id
 d9443c01a7336-2b275b4a227mr1609565ad.27.1775065069607; 
 Wed, 01 Apr 2026 10:37:49 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2749ce29esm3496855ad.81.2026.04.01.10.37.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2026 10:37:49 -0700 (PDT)
Message-ID: <66b06ada-ec8a-471a-b270-9e71b2291ea5@linaro.org>
Date: Wed, 1 Apr 2026 10:37:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/12] include/tcg/tcg-op: extract memory operations to
 tcg-op-mem.h
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, jim.macarthur@linaro.org
References: <20260327165042.604105-1-pierrick.bouvier@linaro.org>
 <20260327165042.604105-2-pierrick.bouvier@linaro.org>
 <75a472a5-3b7e-4fc3-864a-4d726eb0d88f@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <75a472a5-3b7e-4fc3-864a-4d726eb0d88f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1029.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 4/1/26 5:13 AM, Philippe Mathieu-Daudé wrote:
> On 27/3/26 17:50, Pierrick Bouvier wrote:
>> This new header defines a new type for target virtual address,
>> independent from TCGv and is parameterized by a new define
>> TCG_ADDRESS_BITS (name was suggested by Paolo instead of
>> TARGET_ADDRESS_BITS).
>>
>> By default, tcg-op.h include set this define to TARGET_LONG_BITS, but
>> it's also possible to include only tcg-op-common.h and tcg-op-mem.h and
>> set TCG_ADDRESS_BITS manually, which is what next commits will do.
>>
>> We preserve existing MIT license when extracting this new header.
>>
>> Implemented from:
>> https://lore.kernel.org/qemu-devel/a68321f0-3d54-4909-864c-9793cda05b2a@linaro.org/
>>
>> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    include/tcg/tcg-op-mem.h | 126 +++++++++++++++++++++++++++++++++++++++
>>    include/tcg/tcg-op.h     | 100 +------------------------------
>>    2 files changed, 129 insertions(+), 97 deletions(-)
>>    create mode 100644 include/tcg/tcg-op-mem.h
>>
>> diff --git a/include/tcg/tcg-op-mem.h b/include/tcg/tcg-op-mem.h
>> new file mode 100644
>> index 00000000000..36931d1dd57
>> --- /dev/null
>> +++ b/include/tcg/tcg-op-mem.h
>> @@ -0,0 +1,126 @@
>> +/* SPDX-License-Identifier: MIT */
>> +/*
>> + * Target dependent memory related functions.
>> + *
>> + * Copyright (c) 2008 Fabrice Bellard
>> + */
>> +
>> +#ifndef TCG_TCG_OP_MEM_H
>> +#define TCG_TCG_OP_MEM_H
>> +
>> +#ifndef TCG_ADDRESS_BITS
>> +#error TCG_ADDRESS_BITS must be defined
> 
> Alternatively rename as tcg-op-mem.h.inc and check for TCG_TCG_OP_H,
> erroring "this header can't be included directly" or "can only be
> included by "tcg/tcg-op.h"?
>

The idea is that it can be either included from "tcg/tcg-op.h" for 
target specific code, and directly in common code, by manually setting 
TCG_ADDRESS_BITS accordingly.

>> +#endif
>> +
>> +#if TCG_ADDRESS_BITS == 32
>> +typedef TCGv_i32 TCGv_va;
>> +#define TCG_TYPE_VA TCG_TYPE_I32
>> +#define tcgv_va_temp tcgv_i32_temp
>> +#define tcgv_va_temp_new tcg_temp_new_i32
>> +#elif TCG_ADDRESS_BITS == 64
>> +typedef TCGv_i64 TCGv_va;
>> +#define TCG_TYPE_VA TCG_TYPE_I64
>> +#define tcgv_va_temp tcgv_i64_temp
>> +#define tcgv_va_temp_new tcg_temp_new_i64
>> +#else
>> +#error
>> +#endif
>> +
> 
> ...
> 
>> +
>> +#endif /* TCG_TCG_OP_MEM_H */
>> diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
>> index 7024be938e6..96a5af1a298 100644
>> --- a/include/tcg/tcg-op.h
>> +++ b/include/tcg/tcg-op.h
>> @@ -16,6 +16,9 @@
>>    #error must include QEMU headers
>>    #endif
>>    
>> +#define TCG_ADDRESS_BITS TARGET_LONG_BITS
>> +#include "tcg/tcg-op-mem.h"
>> +
>>    #if TARGET_LONG_BITS == 32
>>    # define TCG_TYPE_TL  TCG_TYPE_I32
>>    #elif TARGET_LONG_BITS == 64
>> @@ -46,103 +49,6 @@ typedef TCGv_i64 TCGv;
>>    #error Unhandled TARGET_LONG_BITS value
>>    #endif
> 
> ...


