Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5192210F996B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 18:36:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAXkz-00005N-Bg; Wed, 08 Apr 2026 14:36:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1wAXkx-0008UF-BK
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:36:03 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1wAEms-0000Xj-PD
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 18:20:49 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-356337f058aso3139872a91.2
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 15:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775600445; x=1776205245; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Tn7TFn5WY9BfwPmjK8Pf5nI6A/CjXIUDqR9R3qGPUA4=;
 b=hWkXDlEGE8XkjsH9g+uXErwqhgX1gQZi6u2SVIgSppWX9LdUHnJW1feTuD2F3WtvW3
 Dq9VvXInl16vE/8RNoZp/mrNsSyfTIuQayvqjB2CUwMiTEo353TJzlyO57SDyhBWahNt
 7I28+ziCmPL2B4s6WB0cyzQU1TEbAZJ797Ov5tgM+ZnsaaSuQic/v791ohyN8ePKvA5p
 wppavnGXV4nIL0ooICYMrtg/ynrZPb0l+041l1lw5SyVos2bjk9/1USPp4JibRKo2Fms
 e9sGLb1O+zFdred5bRRi3ZLJ3zYwR7ClFydPA8HkuVCu4cIxtaXbOYhugQ+YrVBGc1fR
 6Icg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775600445; x=1776205245;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Tn7TFn5WY9BfwPmjK8Pf5nI6A/CjXIUDqR9R3qGPUA4=;
 b=Is9xKhcqpUpM819tnB7PsWzVaNDf5v7RpmXDvDKJKfv+vO+YW7GV+C36V+8/BaqoGl
 uISDkWbc+qVIhvMqwIxV5rraH1vT9dsGu5cSHa7gRQ4hkte/JwCSp3YrH1RTIB1jTtrD
 zxKR46K0eLmPZGvDds6UeoZAn1hjwfDuULOgrZ0aLH4aad2ipQhF74UQgZ2cYpduYhDf
 nZcqn31T8ojGmlRXIWIrryTX5C2/sdZUKdCtgPwInB4YB1XhsDqz9Hd3Geg2LGZOOXKY
 nuoeKK3CniBzi1mltMvRXnVzgiDuXVuCFh8uTT/YXTdd3aCulRRSdwuepd04VTEWtdsT
 4wiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqfeAP987ekjs/CLRzYzM54Wc8NRFiyOadxln5MIeBXycFy7QR71WPzgJ++mi2+mUwnT5SHwvJTRNX@nongnu.org
X-Gm-Message-State: AOJu0YzYiapLjtgvEDz382sOVbM5I1wbIWlDU2itatiWcfk3aAF6n3/L
 ZGltSDmplpxl9EZdlt9EAjWqk61ekkJwQ9D9vF2DIczU+ynPmrwTEk6dFdxOehILiUQ=
X-Gm-Gg: AeBDiet7DZON8vYllsXgmfxm6aO5ACbCUKo/RTkCe84TmE+FsXjLlVmbdFZAbpBUwPF
 VnpwywcuQW872Af49C2T7G8Vp8m9j1QqRayFSAgzcWG7DCfMCnSvIEOzNufCwlqoh8/LSHIlP/B
 0lQ0nZwdvyJZnaVqO7nYfwc4QC18XuVAE4D3N3l4tFbJZFVeAMSw3J9Mb5kpjJmGwppGILRluaI
 KoLBYbQGOvtGheCn3nrssE06LiV9YoVKn6ZHgwPUdmYB6eEiEWZEA6s44NArZ+0ls6qBvAL9Y+B
 wmNMogDiwDeJ22gZsSkFCtYgbvChwK+JbmmGftAyoBXLoAW4PHd1pm052dxxL9aV1t5HWcHUV6T
 cVsXeq9lfwBcqzVbr9Fg+lfEvfo5ycD8QaySZGXbckI6VM1t3PF/43t/sRn8O2lebBio4Jd2GRk
 HjHyVYAzkjcs9i4Kb9MXFqRo2NzCdadNqdzaxDhqT1C01asLo+oVLPzx/s6MoiLZtx67ok4OatB
 pqvXBNw
X-Received: by 2002:a17:902:ccc9:b0:2ab:230d:2d96 with SMTP id
 d9443c01a7336-2b28173ee68mr186824715ad.11.1775600445004; 
 Tue, 07 Apr 2026 15:20:45 -0700 (PDT)
Received: from [192.168.1.169] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2749cada2sm177884795ad.71.2026.04.07.15.20.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2026 15:20:44 -0700 (PDT)
Message-ID: <7dfc0566-1266-4466-b2aa-707848957153@linaro.org>
Date: Tue, 7 Apr 2026 15:20:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 15/21] target/arm/tcg/translate.c: replace TCGv with
 TCGv_va
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, jim.macarthur@linaro.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260407195922.196410-1-pierrick.bouvier@linaro.org>
 <20260407195922.196410-16-pierrick.bouvier@linaro.org>
 <c18cb395-afa8-42c8-aedd-87863d49befc@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <c18cb395-afa8-42c8-aedd-87863d49befc@linaro.org>
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

On 4/7/26 2:02 PM, Philippe Mathieu-Daudé wrote:
> On 7/4/26 21:59, Pierrick Bouvier wrote:
>> We know this file is for 32-bit runtime target, so we can set
>> TCG_ADDRESS_BITS. TCG_TYPE_VA is derived accordingly and is already
>> passed to translator_loop.
>>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    target/arm/tcg/translate.c | 29 +++++++++++++++--------------
>>    1 file changed, 15 insertions(+), 14 deletions(-)
>>
>> diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
>> index fa4c7907dcd..0b3b4ab86be 100644
>> --- a/target/arm/tcg/translate.c
>> +++ b/target/arm/tcg/translate.c
>> @@ -22,7 +22,8 @@
>>    
>>    #include "translate.h"
>>    #include "translate-a32.h"
>> -#include "tcg/tcg-op.h"
>> +#define TCG_ADDRESS_BITS 32
>> +#include "tcg/tcg-op-mem.h"
>>    #include "qemu/log.h"
>>    #include "arm_ldst.h"
>>    #include "semihosting/semihost.h"
>> @@ -910,14 +911,14 @@ MemOp pow2_align(unsigned i)
>>     * that the address argument is TCGv_i32 rather than TCGv.
>>     */
>>    
>> -static TCGv gen_aa32_addr(DisasContext *s, TCGv_i32 a32, MemOp op)
>> +static TCGv_va gen_aa32_addr(DisasContext *s, TCGv_i32 a32, MemOp op)
>>    {
>> -    TCGv addr = tcg_temp_new();
>> -    tcg_gen_extu_i32_tl(addr, a32);
>> +    TCGv_va addr = tcgv_va_temp_new();
>> +    tcg_gen_mov_i32(addr, a32);
> 
> The implicit TCGv_va -> TCGv_i32 bugs me here, but the overall change
> will make my sleep better :) So:
>

We could use TCGv_i32 directly, TCGv_va is just useful here to document 
the intention. I can update this if Richard and you prefer this.

> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
>>    
>>        /* Not needed for user-mode BE32, where we use MO_BE instead.  */
>>        if (!IS_USER_ONLY && s->sctlr_b && (op & MO_SIZE) < MO_32) {
>> -        tcg_gen_xori_tl(addr, addr, 4 - (1 << (op & MO_SIZE)));
>> +        tcg_gen_xori_i32(addr, addr, 4 - (1 << (op & MO_SIZE)));
>>        }
>>        return addr;
>>    }
>> @@ -929,21 +930,21 @@ static TCGv gen_aa32_addr(DisasContext *s, TCGv_i32 a32, MemOp op)
>>    void gen_aa32_ld_internal_i32(DisasContext *s, TCGv_i32 val,
>>                                  TCGv_i32 a32, int index, MemOp opc)
>>    {
>> -    TCGv addr = gen_aa32_addr(s, a32, opc);
>> +    TCGv_va addr = gen_aa32_addr(s, a32, opc);
>>        tcg_gen_qemu_ld_i32(val, addr, index, opc);
>>    }
> 


