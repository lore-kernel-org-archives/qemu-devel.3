Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDF29C369DC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 16:30:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBcE2-0002lt-0x; Sun, 04 May 2025 12:29:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBcE0-0002lZ-KO
 for qemu-devel@nongnu.org; Sun, 04 May 2025 12:29:56 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBcDy-0000Hn-Rv
 for qemu-devel@nongnu.org; Sun, 04 May 2025 12:29:56 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-22435603572so43723395ad.1
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 09:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746376193; x=1746980993; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=flwasTZuJuRJQjKKfHx/Jki6vfwUMVpkVeX2nZYOmHc=;
 b=WN9GgAJO5W9UpLvfGqbqLI1OeppV+aT1Zm0/l/nZpr/I2Ty9D+0BbIM3vQkUj9V01q
 oAuitM1KIXu9Vnh+AUgI947kP8Nr644CpmWR/T6d4ZWsQ/Q+x/ARYycQIdw2K/tK4s/D
 5x6mu/P9z3Fmyc/6rCXI8bVl5/yY8CbvCVLFfU+kG2SGHpgHW+XV02H6eHvdjEJgQcrK
 bWPchcxmP5RslO46ABNkW+0IDez6JEvayGNnUUc0gtWCdQdgpD+zDZefnDbrIQmrd2CO
 lNqrXS6J0oEAZYI4KWFA+4lUrf5O6e/+2SDIik3o6WbngybUw6Q0zHebPkprqGLPZHSl
 Obcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746376193; x=1746980993;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=flwasTZuJuRJQjKKfHx/Jki6vfwUMVpkVeX2nZYOmHc=;
 b=T1PbrFd2P6vplzs7r2aABVVnwHZf89e1rmZ8qXfKLQWFu/xZ3ditdE4qLtflriXyiN
 89INf5c5sph8Yp+XjOVB68rNROJpHLeqW/vqRKQaFv/awaj6z2IdPZ9GPWy3krT2mUw7
 +wmscpacBeGnS94byEJtY/Rq85YDEGKGTq/BISDhdQxU/LZWKyCBu3WuzFGy/PpmX5M9
 7pLEA6UY6RYvof3zIfy4L7VtpRUlA4bGZv6oty3BFXl1ZJQBawaLIyYU3gRNFPTevim+
 LbbscA3Apj2ohxHkiCH0dXyXmLbZq0zfifv89F/mevCtiKIrvDHqVJJxJWPNcHtB//uD
 5LSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUT8k09mU8ZWieJYVW8RocmddOAK1I9HGmJH0Xq5Adk/+BAwwhbQ8NWSzHbKV2l11u1WNXWTZmxPI/u@nongnu.org
X-Gm-Message-State: AOJu0YySzbUMi4Is7ben9OmgKHvLKngoRPh6dKz1x4Ne6jQIcm2JYLSX
 j0Q0V4swpI1OlEgm4NiN7XyLXG5pxMRxfwZAtdtbXB7N4G2cXPFcSeynH7XqJe4=
X-Gm-Gg: ASbGnctekpt2NWO6FteGay5CyqO7I5VcYoIxzNDRk/YdKU8xJ1Qni2VpZ4AJAeCzk3M
 DX2gE6sHCLWFlDWHbG1mEDknU2ZIh1v9+pnWNSaoshhAAME8mbfvl+/zXHfUcmodgLFReSSmohH
 KlcieBydYcDUTU2sP8xceEhjxGBz+HLhQqJRmglGGAjBeLfzfmDk1g9BZSCPWR9dveIjLdHXtH3
 dkv8OPBp6jQ9B18RS9TUPh2arj2cTZgbOWDCOfHe+zJgREnIlvlz4B9pstVhySlE4W5QJF16IvY
 q4o9kgue2fgdsTf/1vQ3paw3IaqrS62XcV28Tw/39LUsLjWHr45bBQ==
X-Google-Smtp-Source: AGHT+IFUvkPvo+NhY3ntt8T6pn9WxQwRYyY1sF5qimroiZid0sEQmoCyAGZR+08a4QGy+f2RwIsoaw==
X-Received: by 2002:a17:903:11c9:b0:226:5dbf:373f with SMTP id
 d9443c01a7336-22e1e8ca3cbmr61521405ad.10.1746376193168; 
 Sun, 04 May 2025 09:29:53 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e1521fae5sm39307645ad.132.2025.05.04.09.29.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 May 2025 09:29:52 -0700 (PDT)
Message-ID: <e9381208-fdcd-4c62-b1c7-60cc9f6542ab@linaro.org>
Date: Sun, 4 May 2025 09:29:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 16/40] target/arm/helper: use vaddr instead of
 target_ulong for probe_access
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, anjo@rev.ng,
 kvm@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 alex.bennee@linaro.org
References: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
 <20250504052914.3525365-17-pierrick.bouvier@linaro.org>
 <5b152664-a752-4be8-aa15-8c71c040b026@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <5b152664-a752-4be8-aa15-8c71c040b026@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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

On 5/4/25 9:17 AM, Richard Henderson wrote:
> On 5/3/25 22:28, Pierrick Bouvier wrote:
>> +++ b/target/arm/tcg/translate-a64.c
>> @@ -258,7 +258,7 @@ static void gen_address_with_allocation_tag0(TCGv_i64 dst, TCGv_i64 src)
>>    static void gen_probe_access(DisasContext *s, TCGv_i64 ptr,
>>                                 MMUAccessType acc, int log2_size)
>>    {
>> -    gen_helper_probe_access(tcg_env, ptr,
>> +    gen_helper_probe_access(tcg_env, (TCGv_vaddr) ptr,
>>                                tcg_constant_i32(acc),
>>                                tcg_constant_i32(get_mem_index(s)),
>>                                tcg_constant_i32(1 << log2_size));
> 
> This cast is incorrect.

I'll change to i32/i64 typedef, but I wonder if it's ok in tcg code to 
do this kind of cast, when you know the dh_typecode will match behind 
the hoods?

In this case, I thought it was ok since this compilation units is only 
compiled for 64 bits hosts, thus ensuring TCGv_vaddr has the same 
storage size and dh_typecode behind the hoods.

> You need something akin to tcg_gen_trunc_i64_ptr.
> 
> Alternately, do not create TCGv_vaddr as a distinct type,
> but simply a #define for either TCGv_{i32,i64}.
> 

Ok.

> In this case, it'll be TCGv_i64 and everything will match.
> 
> 
> r~
> 
> 


