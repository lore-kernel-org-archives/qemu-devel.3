Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C817CD3423
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 06:22:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJmgd-0008Su-N6; Mon, 04 May 2026 02:21:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wJmgb-0008Sm-CC
 for qemu-devel@nongnu.org; Mon, 04 May 2026 02:21:45 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wJmgX-0001nH-IG
 for qemu-devel@nongnu.org; Mon, 04 May 2026 02:21:43 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-449d6c68ed8so2716948f8f.0
 for <qemu-devel@nongnu.org>; Sun, 03 May 2026 23:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777875698; x=1778480498; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HDGUUlnL6RcXCnE/O5wTkYUC48nCEBKQO8xPXMV5mTw=;
 b=kjcoXeETQZ7SSA08A0eMaX6A1pSjSeCu30l2ufesc5CozbH08HoO2hHaWdDLbsv/Ma
 7D+/+C6xvzUEOne+C5sDEdUzslo0fCnraDzimIElG/BanCT/R0Frc9zSA0n/9OjH5m+3
 qhXke4qdX/YYb9KMmaGG3defJN/y7mP3KHmEQ3kObahZKssp3cPpC8iYWOD8xieywX2t
 XOzNgCzeOJ6O6DcBo4o2cXpuRHBi63mYbBH3B5OeHfCA2D28EfzBboWz9wn0Ez9BCVcc
 tvsUoudNvkZlgOpCqyjw/lVeheu6BY6gCeSjdK8YXCZWpCaJzZ1MyIyYdybmQYEu4qsT
 ZWmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777875698; x=1778480498;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HDGUUlnL6RcXCnE/O5wTkYUC48nCEBKQO8xPXMV5mTw=;
 b=LGmdYrACr4fG2JQApO/yae/k592d0ttNJ2kXOKQ6TQXzvcTewgJXrNAAtXLyP47fd6
 TIBcXzzwwLCEN7oNFJB7clM4eThnWDhnp6lK4uMgXa0immC9gpU26DQ8SgWfZinTTIVe
 iVRmu8pIP/qxnzj4DChx5zZmV1e2pFNk2jA8tEJKKqDKr9bWB1VYDU4W57iFiCIdV5Xu
 7AZ2wSy1lrYav6S/kpmYBomhuXgd4upK5fibLLbypx6+/Bu0HO+XyEfR8ZKyibQPdvNK
 NIssZB99s5yLUy6xqEqESBkI4dcZGKqLyHkqsXfQWLDgHd5w6TGEz3XxaNJHA6gof+9H
 kLOw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/hO8Jflj2+OKA3K+KOjqYrg8b6Qb02YctFXCC+P+UMW4agdxXI+X8d2jvoTfsdxSP+rJeb46AgtEFO@nongnu.org
X-Gm-Message-State: AOJu0YyNtEeXyajvlc7d5DSX7JNsXlkSr/JalN1YVPKLycX2TxoPGx6D
 KMGbtrJSQ7NuW1XL63nWTR8N5sdsqX3zSNtijIcafYY/teXYefWkQckXihRPU5i+A30=
X-Gm-Gg: AeBDieuGBVJ5JLQ/3gRJiIfOIlx2IBsHcx9zuDYqaPoLARwybRy20WFQQguyj3bFolf
 VFg+AGyjOslWd0LLe/XTGpTR1F7n0VjWo6GfSB+9fX0mOp2FBuWb9/Ii/AXqaYtQUzjb9B4nQ1L
 DGYGokl8sQDAGPtRb1puLB8o33u3yCl8RnEwKUL5txM5iwyi+A/Q38KF8nAPbUW+ayKqJC7GmBr
 pkTN1nKP3ep2I4K9OTEvE/v+ftUSYTdPiHzZoCjkdrB88H9Oi3lN3b+6utVODvtrO5GDAWSOVVm
 siRTNQ/r7Wcuucb2ouBCeWB8zPjjX/sgpYaBp00XDyWrhfO4HIjMvlVR7vuVt8Cpc7/cIEXlXHW
 rleKiM2QdC+am9yx8mI+08Kcnuq0MfUH19gjR/gwCLF4q5msABdbLADTFrq+nsNAtHFFXtMDbfe
 nq0E84UB2qUFwJ6dRk7ly7f2y/vnT9kOqvhFA3dE4b5FIwDZmPQ+iE7ziHV0EVdT4I8RhyuBVZG
 MK9
X-Received: by 2002:a05:6000:2081:b0:43d:77e1:6a69 with SMTP id
 ffacd0b85a97d-44bb6ab16fdmr14244737f8f.38.1777875698344; 
 Sun, 03 May 2026 23:21:38 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-44a8ea7cf6asm23631610f8f.8.2026.05.03.23.21.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 May 2026 23:21:37 -0700 (PDT)
Message-ID: <e166fff7-c965-4bce-aa30-147dcc4ac4ff@linaro.org>
Date: Mon, 4 May 2026 08:21:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 26/40] fpu: Return struct from parts{64,128}_muladd
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260430000524.56046-1-richard.henderson@linaro.org>
 <20260430000524.56046-27-richard.henderson@linaro.org>
 <9796771d-4d8f-44f9-ba8c-49f0c39a5a51@linaro.org>
 <13b0fb09-c634-4cd6-8566-4142508cbd67@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <13b0fb09-c634-4cd6-8566-4142508cbd67@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 30/4/26 23:30, Richard Henderson wrote:
> On 4/30/26 15:17, Philippe Mathieu-Daudé wrote:
>> Hi Richard,
>>
>> On 30/4/26 02:05, Richard Henderson wrote:
>>> At the same time, export.
>>>
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>>   include/fpu/softfloat-parts.h |  9 ++++
>>>   fpu/softfloat.c               | 83 +++++++++++++++++------------------
>>>   fpu/softfloat-parts.c.inc     | 38 ++++++++--------
>>>   3 files changed, 69 insertions(+), 61 deletions(-)
>>
>>
>>> diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
>>> index 77465cce6e..09b79f8d44 100644
>>> --- a/fpu/softfloat-parts.c.inc
>>> +++ b/fpu/softfloat-parts.c.inc
>>> @@ -679,9 +679,8 @@ static FloatPartsN *partsN(mul)(FloatPartsN *a, 
>>> FloatPartsN *b,
>>>    * Requires A and C extracted into a double-sized structure to 
>>> provide the
>>>    * extra space for the widening multiply.
>>>    */
>>> -static FloatPartsN *partsN(muladd)(FloatPartsN *a, FloatPartsN *b,
>>> -                                   FloatPartsN *c,
>>> -                                   int flags, float_status *s)
>>> +FloatPartsN partsN(muladd)(const FloatPartsN *a, const FloatPartsN *b,
>>> +                           const FloatPartsN *c, int flags, 
>>> float_status *s)
>>>   {
>>>       int ab_mask = float_cmask(a->cls) | float_cmask(b->cls);
>>>       int c_mask = float_cmask(c->cls);
>>> @@ -719,10 +718,13 @@ static FloatPartsN *partsN(muladd)(FloatPartsN 
>>> *a, FloatPartsN *b,
>>>           }
>>>           /* Narrow with sticky bit, for proper rounding later. */
>>> -        fracN(truncjam)(a, &p_widen);
>>> -        a->sign = p_widen.sign;
>>> -        a->exp = p_widen.exp;
>>> -        return a;
>>> +        FloatPartsN r = {
>>> +            .sign = p_widen.sign,
>>> +            .exp = p_widen.exp,
>>> +            .cls = float_class_normal,
>>
>> It would be clearer if the float_class_normal change start appearing
>> during previous reorganizative patch:
>>
>>             a->cls = float_class_normal;
> 
> Before, we proved that a->cls was anynorm, aka in { normal, denormal }, 
> and we simply re-used that.  Here, we're initializing a new structure, 
> so we have to put something, and I choose normal.  I really don't think 
> it's clearer in the previous patch.

OK.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


