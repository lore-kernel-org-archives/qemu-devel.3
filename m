Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2CB710F996A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 18:45:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAXtE-0002eT-2e; Wed, 08 Apr 2026 14:44:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1wAXsz-0002U9-6n
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:44:24 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1wAEkE-0008R4-3s
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 18:18:03 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-35d971fb6f1so4789005a91.0
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 15:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775600279; x=1776205079; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/9tFviCthByTM3SmVu/IoOMYPiiEJc8zgoYy8zDUdiU=;
 b=wFIV5m93u/52xPyQFcpqqBK2v1CEHnUebMQfjQrUtEaD6YgEjs3CBfAPQRStWy1l2K
 Dsy9B3wgnR2b1e/zaUhCKe9KitupUTSc4AH+8fvWwmVUvVDVPU2gxZfOjaJDvvCf3BjR
 abPdLRtVh9097xEWc/Z2U8CNg8UAUkXCi6EBYngL5gDbzjM5ZNbEm8EFYK4tIM0IYMuq
 I27ImTl9zyivNWJnNFh3V3Kx5cizGbKyl0vloE8d4xulQNZDtMJLPlqBhQzzJORT4eBt
 CR8o5ve20O4Cu+oAJGPS8AokwEMy81rW6qIFUfNJJCq3/ElU+6hTwg2Fx7wWs/rzBSNN
 McDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775600279; x=1776205079;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/9tFviCthByTM3SmVu/IoOMYPiiEJc8zgoYy8zDUdiU=;
 b=YX364w4E90fplKfM6B0T5d1EpZDwXM7+G/XoMnygbCpP0D/DA9assSg+e0yaXWfwKB
 xYmygsW2G/jnM4NCqru8U8jBeiLMPxiXcgHDWL3C8lqsU4spOKIb8f9L4RxNORIJ7m0Q
 TrmYdWH3EJeirEg8y7FyxSqLrKtEKssk7apE7Fkdla71PmrLu0rdEHiBXD+eKQ72KILY
 5JIUhPB9X6sg6GHUm170QmTXCpJJ5SZTQMhp9pXW/nPlwfwnJFwhNco3t2Xplue9KFvX
 QT6PlxiMU2SWyBLt+twvVAg3hU9nkVGLnK965lqB4ylPMyiSOIlW/igGCBYgQxpxUDWs
 yN3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxqiN6mU2N4pG5C4w191tiFNOduHdAyWwwRLaQN/Nbp63qwmyEdPeznbtrruQIx7SMRT6kLYQ0zhyg@nongnu.org
X-Gm-Message-State: AOJu0Yy1m68Dvd5hOeu7WtNCjVdBFJGMqmAgZ0bVu0mNHxJxwuvsJ7Bz
 97ZBukfycnEAr3T6brsWvR91gSZCuTlebJPHVwruf9G+nM2sxP8v3T3zHdy//fV5uQM=
X-Gm-Gg: AeBDieuasYgPJjQj7+XfV7X7iOQZOw4QCm3nW11gumoGIy+n04NE4AeUf5bCVKPZEPV
 ZAt4mGIl7ELaEPvMUmlOpKyycsDDDWeTbNpmBBQn8OnbUXA0aqRc5jZKNEplALdggRM/W7ukcrA
 RXUbZJcMnNn8lr7s50cVz+pYo63rsz9RkROrH1UsHva/Y5BBYRjbdXQrpZON1kFqL/DqVUU9c8y
 rFDAHRPtW414GgXt9lAStPgv0LVebLTIo58CMzSWdT3bPc7gcRMISyJIUbGfKmK3cn42nKcMHL+
 905qHyd5JCjX0XtHvZRYJEg9tskCG6MPCc1xCXetomYw0MWCHf0zOizAu962oCWIBgqJ5/Y5aO7
 wJul3o81VdA3/ZpSHGY3VthOKRA5EQ2J3YIV7E4fSOm59UB5LzsB8W0x4YfR9qLHFBUS4i+vGgN
 TUU9ZSw0OEI48deWt7fVvySQSUpVGbmWRMiaDu+m+HaAYVpl8EhiUPu0Vu4RbBSu7xvE1eMA==
X-Received: by 2002:a17:90b:53cb:b0:359:fd9a:c513 with SMTP id
 98e67ed59e1d1-35de697ef49mr17652108a91.24.1775600279523; 
 Tue, 07 Apr 2026 15:17:59 -0700 (PDT)
Received: from [192.168.1.169] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35dbe9379f3sm23446568a91.9.2026.04.07.15.17.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2026 15:17:59 -0700 (PDT)
Message-ID: <c6287f89-56cf-4f3d-9dcf-de5e9494f36d@linaro.org>
Date: Tue, 7 Apr 2026 15:17:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 14/21] tcg/translator: add parameter to
 translator_loop for current addr type
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, jim.macarthur@linaro.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260407195922.196410-1-pierrick.bouvier@linaro.org>
 <20260407195922.196410-15-pierrick.bouvier@linaro.org>
 <3718ca35-2035-4e62-847f-71c546ad194a@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <3718ca35-2035-4e62-847f-71c546ad194a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 4/7/26 2:40 PM, Philippe Mathieu-Daudé wrote:
> On 7/4/26 21:59, Pierrick Bouvier wrote:
>> With TCG_ADDRESS_BITS mechanism, it's now possible to specify which
>> variant every source file is written for. Compared to before, it means
>> that addr_type will now vary per tb translation, where it was constant
>> for a given target previously.
>>
>> Thus, we add new a parameter to translator_loop().
>> This will allow us to convert targets one by one.
>>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    include/exec/translator.h        | 4 +++-
>>    accel/tcg/translate-all.c        | 1 -
>>    accel/tcg/translator.c           | 4 +++-
>>    target/alpha/translate.c         | 3 ++-
>>    target/arm/tcg/translate-a64.c   | 3 ++-
>>    target/arm/tcg/translate.c       | 2 +-
>>    target/avr/translate.c           | 3 ++-
>>    target/hexagon/translate.c       | 3 ++-
>>    target/hppa/translate.c          | 3 ++-
>>    target/i386/tcg/translate.c      | 3 ++-
>>    target/loongarch/tcg/translate.c | 3 ++-
>>    target/m68k/translate.c          | 3 ++-
>>    target/microblaze/translate.c    | 3 ++-
>>    target/mips/tcg/translate.c      | 3 ++-
>>    target/or1k/translate.c          | 3 ++-
>>    target/ppc/translate.c           | 3 ++-
>>    target/riscv/translate.c         | 3 ++-
>>    target/rx/translate.c            | 3 ++-
>>    target/s390x/tcg/translate.c     | 3 ++-
>>    target/sh4/translate.c           | 3 ++-
>>    target/sparc/translate.c         | 3 ++-
>>    target/tricore/translate.c       | 3 ++-
>>    target/xtensa/translate.c        | 3 ++-
>>    23 files changed, 45 insertions(+), 23 deletions(-)
>>
>> diff --git a/include/exec/translator.h b/include/exec/translator.h
>> index 8d343627bd9..c1d31e06b53 100644
>> --- a/include/exec/translator.h
>> +++ b/include/exec/translator.h
>> @@ -20,6 +20,7 @@
>>    
>>    #include "exec/memop.h"
>>    #include "exec/vaddr.h"
>> +#include "tcg/tcg.h"
>>    
>>    /**
>>     * DisasJumpType:
>> @@ -132,6 +133,7 @@ typedef struct TranslatorOps {
>>     * @host_pc: host physical program counter address
>>     * @ops: Target-specific operations.
>>     * @db: Disassembly context.
>> + * @addr_type: TCG Type for addresses (TCGv_va).
> 
> "TCGv_va" confuses me here, do you mean TCG_TYPE_VA?
> 
> What about:
> 
>     "@addr_type: #TCG_TYPE_VA for TCGv_va address expansion."
>

Right, I'll update comment.

> Otherwise,
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 


