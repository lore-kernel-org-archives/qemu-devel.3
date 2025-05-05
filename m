Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19685C3ABAA
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 19:22:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC1Nn-0005ge-Ur; Mon, 05 May 2025 15:21:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC1Na-0005de-31
 for qemu-devel@nongnu.org; Mon, 05 May 2025 15:21:30 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC1NX-0002BU-V1
 for qemu-devel@nongnu.org; Mon, 05 May 2025 15:21:29 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-224171d6826so71285285ad.3
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 12:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746472886; x=1747077686; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rKUeGEJlprcUuMRYQLCNcs8/KtlUslt/cF30WTx3Smg=;
 b=BPjLSdoaua6/2f24sC96BztVYyf10w14oEKOiOQGxR6EuSos+MwT+I29/igNhMPepQ
 8yb1rgRwZE5aef2EJg5RON6Q7gKix+8gCa5NJKB3unsvdjdLYAkjeEiejSHyioogz7Mw
 FvOYpLFwRDol4OAIoYAGu6jtVwOwU7ktrAvegZaR2IC0slBy15Gr4DvA2z8R8czjF9AX
 vYXlsLPRQtMdQmGUZXofXZtMTa/4vbgkkvyUhu5OaOVBGhKAy7TxB8VIm7czL4yn3olh
 wVgUSGd61xrvqT3o2E7MxkZJyuXM2jOGZsy2Vu6Yw9OqT2QtDo1Wxx9nTHXLfCsxdZRz
 SD2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746472886; x=1747077686;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rKUeGEJlprcUuMRYQLCNcs8/KtlUslt/cF30WTx3Smg=;
 b=cbUgQYBYbHuS5eMtWiFLTsaZwhGZz3u7UwhVfNjJpZdsdpIm7JWS+6zPAMokSJUtgJ
 qvzUkOjqj27uZ9XxETY4hwO2ll5DCZqHUdgAVt3zZSUfv1pJgoVUdd1G6+Z5Hue3ENhJ
 e7NQqBUBdkJ1rP4zA5Is+7xJ2fmMA7NA9hCai7AFYlWG8Zh7MMCK9N2bfTBwSMUkdR7U
 DnkRX+nEV5wKDx5uFFGiCC0ROkZgAq25RUcgXT0siGGq95Z5JGlbfol8LOI1FX3O8RmX
 +T/iGYDEWYZh7LpFBDyyKqg4mEBzN74m09gXszO2Rx1bdfQA4Jfkf2SQqHALVE3aAJ54
 dcSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTvLBfArtXwcgor2PnBHlKqUMGW1IuWYS20bn3etzgqyBNAZE2xVgcrb0cUI+AerXnN3JwlLXApcNW@nongnu.org
X-Gm-Message-State: AOJu0Ywc3pvItBHNeMJ870NCp8bBy8bSUqC7ox/Ulv0EXLRfgzTH9U+G
 hJ5saUnxO3ed3h/2qGYLM+o+DWB2e1EWF+uAg1v9lHd5KWYKrIOp4oUqzWrUBd8=
X-Gm-Gg: ASbGncsg5jXSai4wDoickJr2ki9MaVW/yE8Xo0FBoNPqW68qR6Yyvb6EZD+rM85VB4K
 /QkaY2xjdGxZXvS7BwZVYHya26qcRh6HnkJjairetONIinuRoE1w8ExtRkYMdd1ijNlpm3mJvVt
 7/K3mCfUj6aepGQmxCwuYzlm4sBlghpsgrGXOD31CHJhu32mbc85nVN6c41GEa4fXAn8xXjYeNc
 xmlUOfjfO1357TXjY4JEa6KRO/GIiyN6hYyrjKtxr3B9F+t2eTi6akDskpxyowk3XOGSgpRuZtM
 su5CFt990I3ryGVGKHVy88legTfIRXxcH1Jqce3QNZ0IFKwvjKRZkg==
X-Google-Smtp-Source: AGHT+IEU3LO3BLYHgDWrtN9CLYWTq6t5MCfWL98ImCZ5M7qGwidnZY2CVsEvZfUEZd+rLsDHEoZTxw==
X-Received: by 2002:a17:902:ecc3:b0:223:5c33:56a8 with SMTP id
 d9443c01a7336-22e32eeea95mr8802935ad.35.1746472886426; 
 Mon, 05 May 2025 12:21:26 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e363a1aa1sm648655ad.194.2025.05.05.12.21.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 12:21:25 -0700 (PDT)
Message-ID: <afa68161-39cf-4d3b-96b9-9c20d3a3f732@linaro.org>
Date: Mon, 5 May 2025 12:21:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 44/48] target/arm/tcg/neon_helper: compile file twice
 (system, user)
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>, anjo@rev.ng,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
 <20250505015223.3895275-45-pierrick.bouvier@linaro.org>
 <7ff2dff3-20dd-4144-8905-149f30f665b1@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <7ff2dff3-20dd-4144-8905-149f30f665b1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
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

On 5/5/25 11:44 AM, Richard Henderson wrote:
> On 5/4/25 18:52, Pierrick Bouvier wrote:
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    target/arm/tcg/neon_helper.c | 4 +++-
>>    target/arm/tcg/meson.build   | 3 ++-
>>    2 files changed, 5 insertions(+), 2 deletions(-)
> 
> Likewise, I think this could be built once.
> 

needs access to env->vfp.qc[0], so pulls cpu.h.

> 
> r~
> 
>>
>> diff --git a/target/arm/tcg/neon_helper.c b/target/arm/tcg/neon_helper.c
>> index e2cc7cf4ee6..2cc8241f1e4 100644
>> --- a/target/arm/tcg/neon_helper.c
>> +++ b/target/arm/tcg/neon_helper.c
>> @@ -9,11 +9,13 @@
>>    
>>    #include "qemu/osdep.h"
>>    #include "cpu.h"
>> -#include "exec/helper-proto.h"
>>    #include "tcg/tcg-gvec-desc.h"
>>    #include "fpu/softfloat.h"
>>    #include "vec_internal.h"
>>    
>> +#define HELPER_H "tcg/helper.h"
>> +#include "exec/helper-proto.h.inc"
>> +
>>    #define SIGNBIT (uint32_t)0x80000000
>>    #define SIGNBIT64 ((uint64_t)1 << 63)
>>    
>> diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
>> index 3482921ccf0..ec087076b8c 100644
>> --- a/target/arm/tcg/meson.build
>> +++ b/target/arm/tcg/meson.build
>> @@ -32,7 +32,6 @@ arm_ss.add(files(
>>      'translate-vfp.c',
>>      'm_helper.c',
>>      'mve_helper.c',
>> -  'neon_helper.c',
>>      'op_helper.c',
>>      'tlb_helper.c',
>>      'vec_helper.c',
>> @@ -65,9 +64,11 @@ arm_common_system_ss.add(files(
>>      'crypto_helper.c',
>>      'hflags.c',
>>      'iwmmxt_helper.c',
>> +  'neon_helper.c',
>>    ))
>>    arm_user_ss.add(files(
>>      'crypto_helper.c',
>>      'hflags.c',
>>      'iwmmxt_helper.c',
>> +  'neon_helper.c',
>>    ))
> 


