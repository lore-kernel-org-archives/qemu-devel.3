Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC73210F9972
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:52:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYcI-0005uz-Gc; Wed, 08 Apr 2026 15:31:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1wAYAF-00013F-U4
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 15:02:11 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1wAF06-0003Ez-Ru
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 18:34:28 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-82cd9d0eceaso4169404b3a.3
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 15:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775601265; x=1776206065; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=LYc49bLXJNcDA8VBrfK90CEwYrXh/e078SceomJiDEg=;
 b=JOg+/e3BvCyvnGBZ1rHITwd6nbT1SuplAUF9kpzOtPfw9L91HB4SZruPAYG4AhSDWo
 CnG/6OkyPItj3dxa4vhTpsQl3sRZD4dMcCtBDCASRIaMoGj3KHT0fcNKFfBqxBz4xa1K
 w5oVNu6zHMVIIn/kWdxQeDWbb2fYDpxAE8kyRr2xfjFNyqyN4QZOZ5DO46SZH3hl49Mc
 5tnJjb8IdF5Esh2vH/JJlBghiBCeH/URGYsDuIWvulMBSQe8+hgZZH+lgMJrBeVJaFHu
 sp/lJqd554B7RgKlhmwjTcwo0CzR6dGS75b1ssIBjWIUKrGZSA10b+622Hvj+5dB4qJY
 nM7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775601265; x=1776206065;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LYc49bLXJNcDA8VBrfK90CEwYrXh/e078SceomJiDEg=;
 b=JQxEIG8MaqVZNEc12TYk3LF3ZRA299rcLH10e12bEMGROmH0o7VRaCnYxbSgudNR5o
 KDeyzkfmpHw7TTiZaNAAcuRZ+Xu2zEfWCZ/zTQxa35UUzuszdGOVIQFjHXx3O3Yri/mY
 2DWGo84Yi21EqRs6pq4oMJiSS3vCe9/7D5ZrV00Q27t71siVY/c8H9bLql53N9ZeOexj
 TmjPwAIEujWam0+FGqZWVK3275uv5ez6vj7LDSp9qtnc4U5u6tZDvr5YjFPsRa/l0fwJ
 4PT1CMYEuJErVB0zRUpMC0fOjscpOkBVEvpf6u3XDDnYvLFiD5wPMkfHL22OMUkEbujK
 z7IA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUepqVGip0Srm6U644L4aOmKIN56ZTWaKGAkLRxWALhzqfDq5/XoXBWrNY3AbPfRANouYuP4D8ruJRA@nongnu.org
X-Gm-Message-State: AOJu0YyHiHYIERTcNxMBo1UeidsApqsgqokl+HqvjNEmI9LRCRfNiV4c
 /cZ29fLGGsaDmyA0A/qBN5E+LwRCdJmckq/5fUUx+2O4RM7hTAWczy7vOdYs20kqMUI=
X-Gm-Gg: AeBDietaXwchxgohKbuLT3MpwcySq4Pu//URmT0iiQCeZnztZiyv0WT9rBgyIhUPBDl
 03TbFgbUbJ7D1eAvUM70efgGnNGddAMRTs1GPnnaCxte0rF8lXOd1wDRGNxmrXwRIS4P7i89hPr
 is9p1LxMkpVEKuPcYcC7bVjBWfzGjSypXgOuuh33CX+8MLCS3msAN97CGXt0fEqde+k+u4HfqjL
 nWsQu46mFdb+aLCNGyYYiN3gdxvIvEllgNSMb9Z2mhXzhX2GaaiXPgEB3/wsgDqtlGrh5Ix5fl/
 qxNove6F+O5pXIWeQdKV9fs8otKjd96zT6BvIo1gHO9sD6RYjLhHNS0OseTPOAgQuzqn3WF6DTe
 z74y+UgJNwfsLsQfg0MHzN189pkW3cjnXFNtmtuOBRWgXkb0ASlJTOWZFcg/DVod3sG7WqTWLIU
 qPK0hpSsRjyRJLk0X94Y6iYZCk38f5nl6cpKOH4EiWWGZEucwK8wIh/HBIPZzoPkGxGxF0Kg==
X-Received: by 2002:a05:6a00:10d5:b0:82c:e4b9:531c with SMTP id
 d2e1a72fcca58-82d0da41aa6mr17229515b3a.7.1775601264864; 
 Tue, 07 Apr 2026 15:34:24 -0700 (PDT)
Received: from [192.168.1.169] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82d11cd2ce2sm17888135b3a.6.2026.04.07.15.34.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2026 15:34:24 -0700 (PDT)
Message-ID: <6ff0ba9a-fa63-45e1-bd98-61f53125037d@linaro.org>
Date: Tue, 7 Apr 2026 15:34:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 15/21] target/arm/tcg/translate.c: replace TCGv with
 TCGv_va
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, jim.macarthur@linaro.org,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20260407195922.196410-1-pierrick.bouvier@linaro.org>
 <20260407195922.196410-16-pierrick.bouvier@linaro.org>
 <c18cb395-afa8-42c8-aedd-87863d49befc@linaro.org>
 <7dfc0566-1266-4466-b2aa-707848957153@linaro.org>
 <7ccbc31f-b3ce-49a4-80e7-e052f517f0e1@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <7ccbc31f-b3ce-49a4-80e7-e052f517f0e1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42c.google.com
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

On 4/7/26 3:27 PM, Richard Henderson wrote:
> On 4/8/26 08:20, Pierrick Bouvier wrote:
>> On 4/7/26 2:02 PM, Philippe Mathieu-Daudé wrote:
>>> On 7/4/26 21:59, Pierrick Bouvier wrote:
>>>> We know this file is for 32-bit runtime target, so we can set
>>>> TCG_ADDRESS_BITS. TCG_TYPE_VA is derived accordingly and is already
>>>> passed to translator_loop.
>>>>
>>>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>> ---
>>>>     target/arm/tcg/translate.c | 29 +++++++++++++++--------------
>>>>     1 file changed, 15 insertions(+), 14 deletions(-)
>>>>
>>>> diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
>>>> index fa4c7907dcd..0b3b4ab86be 100644
>>>> --- a/target/arm/tcg/translate.c
>>>> +++ b/target/arm/tcg/translate.c
>>>> @@ -22,7 +22,8 @@
>>>>     #include "translate.h"
>>>>     #include "translate-a32.h"
>>>> -#include "tcg/tcg-op.h"
>>>> +#define TCG_ADDRESS_BITS 32
>>>> +#include "tcg/tcg-op-mem.h"
>>>>     #include "qemu/log.h"
>>>>     #include "arm_ldst.h"
>>>>     #include "semihosting/semihost.h"
>>>> @@ -910,14 +911,14 @@ MemOp pow2_align(unsigned i)
>>>>      * that the address argument is TCGv_i32 rather than TCGv.
>>>>      */
>>>> -static TCGv gen_aa32_addr(DisasContext *s, TCGv_i32 a32, MemOp op)
>>>> +static TCGv_va gen_aa32_addr(DisasContext *s, TCGv_i32 a32, MemOp op)
>>>>     {
>>>> -    TCGv addr = tcg_temp_new();
>>>> -    tcg_gen_extu_i32_tl(addr, a32);
>>>> +    TCGv_va addr = tcgv_va_temp_new();
>>>> +    tcg_gen_mov_i32(addr, a32);
>>>
>>> The implicit TCGv_va -> TCGv_i32 bugs me here, but the overall change
>>> will make my sleep better :) So:
>>>
>>
>> We could use TCGv_i32 directly, TCGv_va is just useful here to document the intention. I
>> can update this if Richard and you prefer this.
> 
> I think this is fine, as I'm not keen on introducing a complete set of tcg_gen_foo_va
> macros.  As is, any mismatch will be caught at compile-time.
>

Agreed. Usage should be reduced to address related functions.

> 
> r~


