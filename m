Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B077C54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 18:17:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJcNU-0000KZ-D5; Mon, 26 May 2025 14:16:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJcNS-0000KG-Ql
 for qemu-devel@nongnu.org; Mon, 26 May 2025 14:16:46 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJcNR-0006aa-25
 for qemu-devel@nongnu.org; Mon, 26 May 2025 14:16:46 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-44a57d08bbfso18910435e9.2
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 11:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748283403; x=1748888203; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jKLwdwro/mVPpscoQYxiX/J6E6d2FavrO+/L+vO9WYA=;
 b=c9k+zv+14gZl/mzMaweNDu18QztqzyF2xxCWkR7AAI5AWO+8iQGxNKKhsrxYRjpNbO
 G0nSawb08JEfPPmgYUuZwJv/0hZEg0ic8HalWVxntKlw1praBKfaZAAGGMeIgU2wGkDC
 8WbHtxzre9nShNbRpDUv3Q455H/wPKqodXm8yNyGfy4mxti3S4UMFfaixo6k4Zw2wlrA
 +q9zY6mqsUgp2wSzo8pQmtkXjj+9v8nRSJPJ3IsvRZ0socIrLAdKXWGkNDZvV0k9gc3n
 G4MNiIquTZZ1LTAn+OBzOyzZFsdOu71Vp0hzG/l0c8GYpFaGSqTyecWtKAb4UdJkKvAZ
 XHlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748283403; x=1748888203;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jKLwdwro/mVPpscoQYxiX/J6E6d2FavrO+/L+vO9WYA=;
 b=igwwX6v9z0aBQPhvjHtHxL2Ss30RIVHiFEzt+BYnvk+0wvbRGl7NcgaxC6eSWqPnTv
 1Zkrks/9ausFzVfb55eVyZQI/dA9zjkUrj0YZB3TUYdrQznQEflVhaJK0HY5Y47+Qvsv
 5q1osaGb2OLsLsgAgtMZ7XSLfijgVuj6DJdBD6DQHfNGCq4hUpq/MtL7mNF1e0rXcCyJ
 anAXgxy2n749iWKOYIlPMj0kFiUJLXMDi7tNdoeBi8q5u4fxMmnmON80oxGZcJfSGsHD
 sreN7NRdGJSgxg8ZSESAdN4QGaaF0USW942LOBw0dhglPJVNW2Ob8NwRaiVpwUxGXYO2
 14DQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0Ni5Zx+4x/lO/biUH1rOLd3u2jm+SKeJd3H47D/TF6jpzEmgLLX26y10txsjnJyazdLTk1f29xa2V@nongnu.org
X-Gm-Message-State: AOJu0Yz1KflPaFa4CkswfuV/5pBTAWU+hE3I8yICnMaoi7GgWCgDwt9a
 5GkN2KQoSKUwgEvhhLM3JzSOIQ10q/CruaMinrv4dMsx0Dlj1p7rUvxxlJrRA9elAsM=
X-Gm-Gg: ASbGncu1ym3GO35EBd6yZeb8cs+8bCSby5Df0jZ5XB2Bt7pI6W9legm3PQWRlRwBc+j
 EG9IXlQS/KqjtxwK0UgwSS5wJeEmf6TInBfibTO82vvJvuWyVpu5ldTEnX3glB4JZT8alPqujZh
 +URbe/MpL+0+UwMw1wQAP+0onAYINJIxZOV9KmNKMmK8dsK1pKmbQnca0ObCv8uvs9sX06XV4Oz
 wC8Qghp+jQUsvhATQ050356F7DJqcTgvGHD4yRvDB3I3HapqC2Ke7DL+z8LFXd9v0gJxePxuXJn
 0pGVZTwWPjXGO+cVUJLLeeeFbJCUVOp4+qK3skCE2pyGIrExUtFgE7UiReOvuheZlA8z7MVdI6B
 Zhlzvn8DJVoLGun9UzreCzqsq
X-Google-Smtp-Source: AGHT+IGRQJCVNDHorTCTMdhoyFpq8GIbMyurbkLvgDepU6sCOr7YYeIbigbhUeU22DMzVCXzEx/Zjg==
X-Received: by 2002:a05:6000:4203:b0:3a3:71cb:f0bd with SMTP id
 ffacd0b85a97d-3a4cb452b6amr8795925f8f.23.1748283403414; 
 Mon, 26 May 2025 11:16:43 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4de9c9853sm1456351f8f.27.2025.05.26.11.16.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 May 2025 11:16:42 -0700 (PDT)
Message-ID: <bf4f6f32-3c46-4fbf-b305-cd023c1c916f@linaro.org>
Date: Mon, 26 May 2025 20:16:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/12] target/s390x: Fill in TCGCPUOps.pointer_wrap
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: foss@percivaleng.com, qemu-s390x@nongnu.org
References: <20250504205714.3432096-1-richard.henderson@linaro.org>
 <20250504205714.3432096-11-richard.henderson@linaro.org>
 <9aebfbbc-ff29-4af7-8afe-8e0d82c62557@linaro.org>
 <aa4579d9-4e15-409a-9cf9-232b94aa7f7d@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <aa4579d9-4e15-409a-9cf9-232b94aa7f7d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 5/5/25 18:16, Richard Henderson wrote:
> On 5/5/25 07:41, Philippe Mathieu-Daudé wrote:
>> On 4/5/25 22:57, Richard Henderson wrote:
>>> Use the existing wrap_address function.
>>>
>>> Cc: qemu-s390x@nongnu.org
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>>   target/s390x/cpu.c | 9 +++++++++
>>>   1 file changed, 9 insertions(+)
>>>
>>> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
>>> index 9c1158ebcc..f05ce317da 100644
>>> --- a/target/s390x/cpu.c
>>> +++ b/target/s390x/cpu.c
>>> @@ -347,6 +347,14 @@ static TCGTBCPUState 
>>> s390x_get_tb_cpu_state(CPUState *cs)
>>>       };
>>>   }
>>> +#ifndef CONFIG_USER_ONLY
>>> +static vaddr s390_pointer_wrap(CPUState *cs, int mmu_idx,
>>> +                               vaddr result, vaddr base)
>>> +{
>>> +    return wrap_address(cpu_env(cs), result);
>>> +}
>>> +#endif
>>> +
>>>   static const TCGCPUOps s390_tcg_ops = {
>>>       .mttcg_supported = true,
>>>       .precise_smc = true,
>>> @@ -367,6 +375,7 @@ static const TCGCPUOps s390_tcg_ops = {
>>>       .record_sigbus = s390_cpu_record_sigbus,
>>>   #else
>>>       .tlb_fill = s390_cpu_tlb_fill,
>>> +    .pointer_wrap = s390_pointer_wrap,
>>
>> As future cleanup, we might now remove the wrap_address() calls
>> in target/s390x/tcg/crypto_helper.c, and target/s390x/tcg/vec_helper.c,
>> is that correct?
>>
>> Also some uses in target/s390x/tcg/mem_helper.c.
> 
> No, not correct.
> 
> The new pointer_wrap hook is only used for unaligned accesses that cross 
> page boundaries. It does not apply to a sequence of individual accesses 
> like we have in the s390x helpers.

Ah, now I understand, thanks!


