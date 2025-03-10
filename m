Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0B11C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 16:39:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trg9R-0005HP-Sx; Mon, 10 Mar 2025 12:38:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trg9J-00058f-1N
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 12:38:43 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trg9G-0003w7-Lb
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 12:38:40 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2240b4de12bso75039415ad.2
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 09:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741624715; x=1742229515; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YbpczRVMyRdSpW39rNpW62KskPPHf7oWPxnlmBGEAS8=;
 b=xlV2aH/vtSGhLCxrZpe1kHKLisbxfcaPLkmmeP98JSqhz8AMsc21Av+AVnb7FPOTFC
 CBrJ/njvBC5aia+a8fptUB+vwXJKUBETu4i+LkiWpn8+GvkpPlHGiLbrEWyZreT/f0vp
 GtzXbzU5HPOFC1syIuZUZIkkSmI+/eTfTSpZIXoKZHtMue0Ct/IkZih5HqNv2sCQfyI+
 zG6ns31WcTGaFlEKtE/QUbL2GRzvlYHXcKt+wJQtWOaRSxRubB3IKo9q+4FmAzMsEmwu
 o3Tr4bx6bSj7jlAJgL+muYihVwq14EA6pdgOENCbV8qzLAfGXXvJFOiNVjLCILzYZ0wI
 exWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741624715; x=1742229515;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YbpczRVMyRdSpW39rNpW62KskPPHf7oWPxnlmBGEAS8=;
 b=TnQPLDRnp0q+mMWaEl7cRS0aAeSzUZw6s9S3JH25wWe62rq74F8iaL9brTIIrXjFVs
 Kr+A30WwYx52cFZFtiuhzwcBbi+sTV2vB4UGfZGiDMjCeY9B34Xfrx5zdzcBvVJmBFoH
 T/Dsg71Y7xuneFKONg0zYRTxS6+GliHK8r0kWvoK/k5KzAIJBgjUd5m1ipwTWKo1CeyR
 dLPDSkbtervLVstad+iSuo22vi2Yn8GYyPVK4nDzNtpUAAHHVx3fJNVzrJ0hVBhFo2w8
 /fYHN5IDyPXhSeP06z/OCNZ1ZloE9mw6c2wzW0MZm6+zWbH0gddggbkfMueqhBJB7xQR
 k8yQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUx1+yF71eWDDE558iGOKGYSs3WB6B+wFHiNgcP7MtppEPCJ0dCTngxTDGqMsLYwM8lt/b/+ZoeUFim@nongnu.org
X-Gm-Message-State: AOJu0YxTehGSBguhczLBrnowWPr6LsFvdWDU+920g0v5AJmOi77buR/V
 EsL3XY2aCfiN9PZTMHu1eCWt8Bru+ypHoDlCwkxacCMDM/eBlSizWzvMpjRF9VE=
X-Gm-Gg: ASbGnctiauWNFEp3BVTYY5tTkdIoHCvWkHSRkLU4LvellFIKA/b/VG0JgUt1JxAXctD
 5dX4k1vOC7/jnpe//Ug2fF+9Ac3jsyVivNMTDPJuqNHkjN8FX6q4lRikqQmYP8CNBhzfNFPgU33
 nCjhDwD3KArmEpQKVSwb9rbiISDwve2iA5qNHYTC3JR6sM5cbjmekOX1P1xENNsbCfTLidMURMC
 3I6plLhH4T6LisYdB49esMThZpeUyPh52gx/rF48bJ1qv3RbuJKtQasAZFvjhRYpLTi6L9eVLhh
 C3V+w0I4qyx8NoHg5Hxcs8lLE40ggundUPzRwv24xjcfpxMISSpxfiRLFQ==
X-Google-Smtp-Source: AGHT+IHtjhZMXUdjTWWe4ezFEtIomqITEUB6KbeNNNr5RauBWjXC28ZcpRFGjreYdhiuMExqFx585g==
X-Received: by 2002:a17:902:fc48:b0:215:7421:262 with SMTP id
 d9443c01a7336-2242888a6a1mr257546995ad.12.1741624715052; 
 Mon, 10 Mar 2025 09:38:35 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736c0d62199sm4755435b3a.151.2025.03.10.09.38.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 09:38:34 -0700 (PDT)
Message-ID: <becad76f-3116-4959-9cfb-7c0285faf3bf@linaro.org>
Date: Mon, 10 Mar 2025 09:38:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/16] exec/memory.h: make devend_memop target agnostic
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250310045842.2650784-1-pierrick.bouvier@linaro.org>
 <20250310045842.2650784-5-pierrick.bouvier@linaro.org>
 <ad2229d3-cd42-47e0-bd96-4134fca9d950@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <ad2229d3-cd42-47e0-bd96-4134fca9d950@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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

On 3/10/25 09:30, Richard Henderson wrote:
> On 3/9/25 21:58, Pierrick Bouvier wrote:
>> Will allow to make system/memory.c common later.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    include/exec/memory.h | 12 +++++-------
>>    1 file changed, 5 insertions(+), 7 deletions(-)
>>
>> diff --git a/include/exec/memory.h b/include/exec/memory.h
>> index 7c20f36a312..698179b26d2 100644
>> --- a/include/exec/memory.h
>> +++ b/include/exec/memory.h
>> @@ -3164,25 +3164,23 @@ address_space_write_cached(MemoryRegionCache *cache, hwaddr addr,
>>    MemTxResult address_space_set(AddressSpace *as, hwaddr addr,
>>                                  uint8_t c, hwaddr len, MemTxAttrs attrs);
>>    
>> -#ifdef COMPILING_PER_TARGET
>>    /* enum device_endian to MemOp.  */
>>    static inline MemOp devend_memop(enum device_endian end)
>>    {
>>        QEMU_BUILD_BUG_ON(DEVICE_HOST_ENDIAN != DEVICE_LITTLE_ENDIAN &&
>>                          DEVICE_HOST_ENDIAN != DEVICE_BIG_ENDIAN);
>>    
>> -#if HOST_BIG_ENDIAN != TARGET_BIG_ENDIAN
>> -    /* Swap if non-host endianness or native (target) endianness */
>> -    return (end == DEVICE_HOST_ENDIAN) ? 0 : MO_BSWAP;
>> -#else
>> +    if (HOST_BIG_ENDIAN != target_words_bigendian()) {
>> +        /* Swap if non-host endianness or native (target) endianness */
>> +        return (end == DEVICE_HOST_ENDIAN) ? 0 : MO_BSWAP;
>> +    }
>> +
>>        const int non_host_endianness =
>>            DEVICE_LITTLE_ENDIAN ^ DEVICE_BIG_ENDIAN ^ DEVICE_HOST_ENDIAN;
>>    
>>        /* In this case, native (target) endianness needs no swap.  */
>>        return (end == non_host_endianness) ? MO_BSWAP : 0;
>> -#endif
>>    }
>> -#endif /* COMPILING_PER_TARGET */
> 
> Someone (me?) was trying to be overly clever here.

Tends to happen through the QEMU codebase :).

> We can simplify this function and conditionally avoid the function call:
> 
>       bool big_endian = (end == DEVICE_NATIVE_ENDIAN
>                          ? target_words_bigendian()
>                          : end == DEVICE_BIG_ENDIAN);
>       return big_endian ? MO_BE : MO_LE;
> 

That's fine for me (still requires a bit of cleverness to read it at first).

> 
> r~


