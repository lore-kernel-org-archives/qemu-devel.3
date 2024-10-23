Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 640FECFA450
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 16:21:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3e5h-000661-7a; Wed, 23 Oct 2024 12:20:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t3e5e-000643-U9
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 12:20:06 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t3e5d-0005aL-0S
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 12:20:06 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-20c767a9c50so66421315ad.1
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 09:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729700403; x=1730305203; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0qpqGOqT5xSMKEKvrLVG7GrL+60d+8B1JJN/RjSk8AI=;
 b=EI23NYMBqjENbWS8kwdLGo/Ku2kXjt1idHNvVkyLLuM3EeQAFif7nENFXFwYHWUGCT
 8vR6Bu7ZvNr4f7Eu6lcnmlOo5kDsGyeuA48U/8qq3Oufac/7NVQi/qc1TrVhIyz1/HSz
 QoFnNa+D3GAPrDFsrnTNQLYrSDCVvXimn1cpJjA5sRmqj6zCzIgPD6/e+S6s3ZTxU0wg
 e6GECTqFcndkHSDCJ+M0owvlAaJTMOQkzbkAe5l6VHQh6f6moNMeXUncDE+nc94pdAur
 VDQyt8rGxdeYhEsn2UnsSYVIkD6HQzb8+bqOLgwhM1/okZdnk/rjYzdqhGH9qiMhcJsI
 wWrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729700403; x=1730305203;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0qpqGOqT5xSMKEKvrLVG7GrL+60d+8B1JJN/RjSk8AI=;
 b=gn94oIfljkiBXY0Skj9nuqWW6Bu9rR4X7bnAADWSwgQHTnH7f7QSh62rseDNYvLXbP
 YVinrM79Gs+er+q8Oyod2KWHwMPGRBs/untWic/f/zmWLuWHQlbunuaFLXKFV04yAvRU
 gyRJiAxzrgp1Lu69onDWkFegMFlRz8iAE4nvzIB+1C+zW7MTBK+MLKOtwTxGWDrKPaMX
 PV0G/B28dfaUG1Ktr/SEFpQylhAs9nVW//NYryxwTT0eLMcoXGI+dzQP9d/yII05HkAQ
 5qdFNdUOnC2boqVQPqMFBJsi1WqMxgWO/aCRJoriLdcTDdx/Rl01Pl7WdWabBlnfIM3h
 UJVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6heOiCMB1+SYLuAzs99OMm+oMciAviYcp/Ok8CtYvKkxTWMLfkdj5OfFMY6Do+DZbvkJs/5TJWseC@nongnu.org
X-Gm-Message-State: AOJu0YwNlPUtMmwhe+vMTBAkLMbWLLb35eyKRzTanQB2ogelI4ETAWIN
 IdFniP8shMHynkoSDTF25THcBiJgfvkw0k1VoT1RiVuSiKfCejE12NV86xabEe0=
X-Google-Smtp-Source: AGHT+IHWd/38I8/uB4OKBVM6whSMnGTDWZKKDOzwGIAcQRuayYnVE+1i+K31x0kcyy95kF4wokAtiQ==
X-Received: by 2002:a17:902:cec4:b0:20c:771c:b5fd with SMTP id
 d9443c01a7336-20fab324842mr30678805ad.60.1729700402711; 
 Wed, 23 Oct 2024 09:20:02 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20e7f0f368asm59295245ad.268.2024.10.23.09.20.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Oct 2024 09:20:02 -0700 (PDT)
Message-ID: <0ebc95ae-bff8-46ed-9112-d3ed47867c93@linaro.org>
Date: Wed, 23 Oct 2024 09:20:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/tcg: Replace -mpower8-vector with -mvsx
To: Ilya Leoshkevich <iii@linux.ibm.com>, Nicholas Piggin
 <npiggin@gmail.com>, Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Kewen Lin <linkw@linux.ibm.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org
References: <20241021142830.486149-1-iii@linux.ibm.com>
 <56b09f33-d176-4489-989a-ddf02329636f@linaro.org>
 <935ba5fe7f761e641e9bcdd2e000c6e6c0c12fba.camel@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <935ba5fe7f761e641e9bcdd2e000c6e6c0c12fba.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 10/23/24 05:17, Ilya Leoshkevich wrote:
> On Mon, 2024-10-21 at 19:59 -0700, Richard Henderson wrote:
>> On 10/21/24 07:27, Ilya Leoshkevich wrote:
>>> [1] deprecated -mpower8-vector, resulting in:
>>>
>>>       powerpc64-linux-gnu-gcc: warning: switch '-mpower8-vector' is
>>> no longer supported
>>>       qemu/tests/tcg/ppc64/vsx_f2i_nan.c:4:15: error: expected ';'
>>> before 'float'
>>>           4 | typedef vector float vsx_float32_vec_t;
>>>             |               ^~~~~~
>>>
>>> Similar to how this was done for the GCC testcases, replace
>>> -mpower8-vector with -mvsx.
>>>
>>> [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=109987
>>>
>>> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
>>> ---
>>>    tests/tcg/ppc64/Makefile.target | 10 +++++-----
>>>    1 file changed, 5 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/tests/tcg/ppc64/Makefile.target
>>> b/tests/tcg/ppc64/Makefile.target
>>> index 1940886c737..d1b00d2bf09 100644
>>> --- a/tests/tcg/ppc64/Makefile.target
>>> +++ b/tests/tcg/ppc64/Makefile.target
>>> @@ -6,7 +6,7 @@ VPATH += $(SRC_PATH)/tests/tcg/ppc64
>>>    
>>>    config-cc.mak: Makefile
>>>    	$(quiet-@)( \
>>> -	    $(call cc-option,-mpower8-vector,
>>> CROSS_CC_HAS_POWER8_VECTOR); \
>>> +	    $(call cc-option,-mvsx,             CROSS_CC_HAS_VSX);
>>> \
>>>    	    $(call cc-option,-mpower10,
>>> CROSS_CC_HAS_POWER10)) 3> config-cc.mak
>>
>> I don't think this is quite right.
>> I think you need -mpower8 to get OPTION_MASK_P8_VECTOR set.
> 
> Do you mean -mcpu=power8? -mpower8 is a GAS option.

It looks like I do, yes.
Also in that vein, -mpower10 has been marked WarnRemoved in gcc trunk.


> I was confused why -mvsx works in practice, so I spent some time and
> managed to create a "hostile" gcc build, in which this is now a
> problem, using:
> 
>      ./configure --target=powerpc64-linux-gnu --enable-checking \
>                  --disable-bootstrap \
>                  --with-as="$(which powerpc64-linux-gnu-as)"
> 
> The issue is masked by two things:
> 
> - GCC passes "-many" to GAS. GCC commit e154242724b0 ("[RS6000] Don't
>    pass -many to the assembler") stops --enable-checking builds from
>    doing this.
> 
> - binutils has the following line:
> 
>    /* The minimum supported cpu for 64-bit little-endian is power8.  */
>    ppc_cpu |= ppc_parse_cpu (ppc_cpu, &sticky, "power8");
> 
>    so one needs to use the big-endian toolchain to see the problem.

Ah hah!  Good sleuthing.


r~

