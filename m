Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08DC3C36010
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 15:12:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzdHk-00030p-Ut; Tue, 01 Apr 2025 11:12:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tzdHk-00030W-1x
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 11:12:16 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tzdHi-0004JQ-6Y
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 11:12:15 -0400
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-72bbc03d436so3505854a34.3
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 08:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743520333; x=1744125133; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3Nm8PYH6LY3OejxSpb3j/pHlgFT65+/bVNicxIayOaM=;
 b=Yax+VYzmz+Vb8az0rwjh3CKlFrdGUSfQ8SVgeOZaW2tFHP8agAt7IQ9ZF1uSuJN8+k
 6idWJsIoQ9lXXCg6yBxeQxrCkzE1LZ8jBoak1gLMJvXpHV4mhiippb4AM1ABJRBycHhS
 xknKAJu3smk2ElOf4Qxgz7MEwdTxKAjX6RmJxvb3d99JyXcz6KKSGC0IhlHoysjF0CBg
 UtUEONpxWdvJG4RlwOsqbNmN+HXU0LmLnDJ9sUwUrNjNeMz8jKg8y6fW1tRpQ0A/Fqvt
 czQeYPcSMRAKxnqtFNJauuykHx5ndYQ+LMZjrLBE217i+4SIo3stwKuLwEXLjlPg7sX4
 mViA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743520333; x=1744125133;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3Nm8PYH6LY3OejxSpb3j/pHlgFT65+/bVNicxIayOaM=;
 b=UNjRw9WkZM/wSnUgP4BTwZRxavQWh3M2JHfQYWefW7o82s9eO1+413suCh7ZPFfu0b
 7J2c70b00fTq24rccAvMOb3sGNqeB8WcyHHbTJXGpOfYDjVh9Iw8emOM217pQAD7LUwk
 0nC2JB3zcRqMbYr5XzRFgn5Xvr1u3GlxKLcTewynmni+iYswGZECRUSLt57ujdJn7teU
 ckOebj9VQApws/8rjEQ6YVFFQNtFeTRsTW0MtwCkplqEBt/8V5FWa3782XBgo5igXh8L
 nFw6EbrR5KtiU1OtZzOEE/gnVV0H4fd/089mdgbvav6/nN//f6py9RU/cgPz4XMlCW6d
 Bp6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3nUi188tjwZ+MkpnR2zOflFWCG8UlGXnxaKmbFM2xohJvk2jVb7zMBpxEIHEAcoldsgyjN7eccUg+@nongnu.org
X-Gm-Message-State: AOJu0Yy0ndCIFBcanDtkaSTBxFrEilyIz9TOBzgNTffaoo7SUp6Yc915
 2mcUekqfAyM1dMk8UIibA+ZAeW41LLQV7C9tozWcKMiI76TxdFxYxXBG8NdhDoLD3nGT3M4t3YU
 o
X-Gm-Gg: ASbGnct7qyhXw8Tq/IOTtO7fqtjPqtI3iuZT8t2G8oei2mZUgG2Qpvn9y5p3pwDo4eP
 o1rRVqHcSVOXQ8UULgnVm1sbC8vmzliBltw/9C74DAi/zkPGbJMfQGcT+v1WekGDAUuEGMFpyYx
 tjf8fyy7bJ1QJIW5djZd3TYQ3TeoQE0aAxNltqusKVmcN64KBHi7xtuQJncTAG2J/eMCSVCEuVJ
 kP2xCMU8zwV/Om+IIwfHZ+AowYXOWZryLs7MfDw/WYyl3L9WBhLANRE9e2a4wzRX5JbUZsIAdck
 w6Oyk0bDk+f8Q4uAwm+gYCMrILzdt2e0PrWIaGnijzP04ODGhSyRsy7nkqhJ2ZcAj8no1R6Ocvw
 zK6qcus90AYuDOQo0iNY2aQ==
X-Google-Smtp-Source: AGHT+IF/UyC0rED8dgmqHGSNHiJBp/XzKSqFtqX4gqhQJAAQM1TaQTE5xK0USGQs0ChzZXlg8EyO/A==
X-Received: by 2002:a05:6830:64ca:b0:727:24ab:3e4 with SMTP id
 46e09a7af769-72dae5b759emr2449371a34.9.1743520332747; 
 Tue, 01 Apr 2025 08:12:12 -0700 (PDT)
Received: from [172.20.102.85] (syn-071-042-197-003.biz.spectrum.com.
 [71.42.197.3]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72c5828b38csm1846322a34.61.2025.04.01.08.12.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Apr 2025 08:12:12 -0700 (PDT)
Message-ID: <c34d39a9-1481-4dc4-9eab-42c9a9626228@linaro.org>
Date: Tue, 1 Apr 2025 10:12:10 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.0] tcg: Allocate TEMP_VAL_MEM frame in temp_load()
From: Richard Henderson <richard.henderson@linaro.org>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Emilio G . Cota" <cota@braap.org>, Stefan Weil <sw@weilnetz.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Helge Konetzka <hk@zapateado.de>
References: <20250401144332.41615-1-philmd@linaro.org>
 <3d1e544c-5e26-4690-b8d0-d25a34c0c7fe@linaro.org>
Content-Language: en-US
In-Reply-To: <3d1e544c-5e26-4690-b8d0-d25a34c0c7fe@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x330.google.com
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

On 4/1/25 10:02, Richard Henderson wrote:
> On 4/1/25 09:43, Philippe Mathieu-Daudé wrote:
>> Be sure to allocate the temp frame if it wasn't.
>>
>> Fixes: c896fe29d6c ("TCG code generator")
>> Reported-by: Michael Tokarev <mjt@tls.msk.ru>
>> Reported-by: Helge Konetzka <hk@zapateado.de>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2891
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2899
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   tcg/tcg.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/tcg/tcg.c b/tcg/tcg.c
>> index e8950df2ad3..dfd48b82642 100644
>> --- a/tcg/tcg.c
>> +++ b/tcg/tcg.c
>> @@ -4671,6 +4671,9 @@ static void temp_load(TCGContext *s, TCGTemp *ts, TCGRegSet 
>> desired_regs,
>>           ts->mem_coherent = 0;
>>           break;
>>       case TEMP_VAL_MEM:
>> +        if (!ts->mem_allocated) {
>> +            temp_allocate_frame(s, ts);
>> +        }
>>           reg = tcg_reg_alloc(s, desired_regs, allocated_regs,
>>                               preferred_regs, ts->indirect_base);
>>           tcg_out_ld(s, ts->type, reg, ts->mem_base->reg, ts->mem_offset);
> 
> I suspect this is a read from a temporary that is uninitialized.  Ordinarily the stack 
> slot would have been allocated by the store.
> 
> I guess I should have a look at the testcase...

Interesting.  This is a case of incomplete dead code elimination: the store was eliminated 
and the load *should* have been eliminated.  In any case, the uninitialized load isn't 
actually reachable, so all we need to do is not crash.

For 10.0,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

For 10.1, we should probably fix the dead code elimination issue.


r~

