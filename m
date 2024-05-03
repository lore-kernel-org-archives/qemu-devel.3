Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B97BC10F16
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 19:13:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2yL7-0001Mo-26; Fri, 03 May 2024 15:13:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2yKs-0001FM-MA
 for qemu-devel@nongnu.org; Fri, 03 May 2024 15:12:47 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2yKq-0001np-QC
 for qemu-devel@nongnu.org; Fri, 03 May 2024 15:12:46 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-41b869326daso435375e9.0
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 12:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714763563; x=1715368363; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gmp0PVmm2lIG1cghi5u5AQ2w1/nS0HVMNY1RpuMvmv4=;
 b=DQk+XYfVucBbHsOk2z7kEIEVhpibHHRS6zVsecQYccIG1vmuTp6JQXKLt/tcyONFwQ
 tSMIDObLkFAIMEYEvxQJ+RAyQZL2ElF/0XwKu9HTt17Lc/d72aWOCNzGewht8eqczKcG
 qO0MspcJ3WS9e2v+B4EXQMGExYojKE7PlxlxeOSLsEUlRDPQzYHUR4vR2XIRtFmbgdU0
 gwxV0td0CTns4b8hgWRqXLOBkABrrr/Cmf/bRVjkXny2CJUPaDNqXAg6YreZY0qEHhJp
 vYO2C3Zn5vRgVRwnptoiwTtrsI/LStgpdZ68dYuAJZJn0ClVWwVWU8lVVdDlgmae/te/
 EP6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714763563; x=1715368363;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gmp0PVmm2lIG1cghi5u5AQ2w1/nS0HVMNY1RpuMvmv4=;
 b=gy+IPDlqhPu8LfREKF1OnU2yFC1qx105ZigQvCqgg6+NtQHDlySWCETLaosmp+dEiq
 t5wo+31TfmE7A34DpvNi+5SK2urx6spAJjD02F/pFvRP1aN+iNnWhY8J3Oyr5HEHyKng
 eBeC83rXn8i5lQHojZlHIWJGdC3yUKQuc4p1koilOjuQX01Kyyff7j3efRopE20FqTyr
 GLiLc2JUA7+i6RpbQP9ousq/UYbDcD2A43UM8Z+XPxdkr9Ed6K5U3JYKEkh/u+zKQ7MO
 xr3F1khlEpEARU3+vPBvv9f0i9zvVlCAuP1v18Iw6Er1lL3eFYp0PQSe5UJX0P64FPU8
 y1NQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaEOAfiqZat6mCYO85JPzkCCoNT5TK0SWpPFuft0/LF3tDFcpDxc/C+Zh+htkQUF9WpuQ62zma4c/OOACjTtQnah1NYqI=
X-Gm-Message-State: AOJu0Yy7nNTf20drQhHb4giuIWmaxEDi3QoE5gioX1CWvhcWfwm+Gm1H
 Y6/ZV++GEWgBd5M+T9Mjt1bmqSwzOpGG+Auu5OrLvE8Ghc8uoF37tBAzlcDGc+k=
X-Google-Smtp-Source: AGHT+IF7StSjDXIc8csjdv46Bt4r7bDqInS8dTfrO+cksZWnCm7ygj9DOH5Qu+uEhDGkpvkOxe2Pwg==
X-Received: by 2002:a05:600c:4453:b0:41b:e2f6:afc2 with SMTP id
 v19-20020a05600c445300b0041be2f6afc2mr3310994wmn.16.1714763562812; 
 Fri, 03 May 2024 12:12:42 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.179.187])
 by smtp.gmail.com with ESMTPSA id
 d1-20020a05600c34c100b0041c130520f3sm10367537wmq.6.2024.05.03.12.12.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 May 2024 12:12:42 -0700 (PDT)
Message-ID: <04d8919d-4fcf-4fc5-839a-6d08947b87f8@linaro.org>
Date: Fri, 3 May 2024 21:12:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] target/sparc: Split out do_ms16b
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
References: <20240502165528.244004-1-richard.henderson@linaro.org>
 <20240502165528.244004-8-richard.henderson@linaro.org>
 <fc03eef5-ab39-4684-b89a-4d690ad4217e@linaro.org>
Content-Language: en-US
In-Reply-To: <fc03eef5-ab39-4684-b89a-4d690ad4217e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 3/5/24 21:11, Philippe Mathieu-Daudé wrote:
> On 2/5/24 18:55, Richard Henderson wrote:
>> The unit operation for fmul8x16 and friends is described in the
>> manual as "MS16b".  Split that out for clarity.  Improve rounding
>> with an unconditional addition of 0.5 as a fixed-point integer.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/sparc/vis_helper.c | 78 ++++++++++++---------------------------
>>   1 file changed, 24 insertions(+), 54 deletions(-)
> 
> 
>> @@ -150,23 +138,14 @@ uint64_t helper_fmul8x16a(uint32_t src1, int32_t 
>> src2)
>>   uint64_t helper_fmul8sux16(uint64_t src1, uint64_t src2)
>>   {
>>       VIS64 s, d;
>> -    uint32_t tmp;
>>       s.ll = src1;
>>       d.ll = src2;
>> -#define 
>> PMUL(r)                                                         \
>> -    tmp = (int32_t)d.VIS_SW64(r) * ((int32_t)s.VIS_SW64(r) >> 
>> 8);       \
>> -    if ((tmp & 0xff) > 0x7f) 
>> {                                          \
>> -        tmp += 
>> 0x100;                                                   \
>> -    
>> }                                                                   \
>> -    d.VIS_W64(r) = tmp >> 8;
>> -
>> -    PMUL(0);
>> -    PMUL(1);
>> -    PMUL(2);
>> -    PMUL(3);
>> -#undef PMUL
>> +    d.VIS_W64(0) = do_ms16b(s.VIS_SB64(1), d.VIS_SW64(0));
> 
> s.VIS_SB64(1) = upper bit, OK.

I meant "bits" (plural)!

> 
>> +    d.VIS_W64(1) = do_ms16b(s.VIS_SB64(3), d.VIS_SW64(1));
>> +    d.VIS_W64(2) = do_ms16b(s.VIS_SB64(5), d.VIS_SW64(2));
>> +    d.VIS_W64(3) = do_ms16b(s.VIS_SB64(7), d.VIS_SW64(3));
>>       return d.ll;
>>   }
>> @@ -174,23 +153,14 @@ uint64_t helper_fmul8sux16(uint64_t src1, 
>> uint64_t src2)
>>   uint64_t helper_fmul8ulx16(uint64_t src1, uint64_t src2)
>>   {
>>       VIS64 s, d;
>> -    uint32_t tmp;
>>       s.ll = src1;
>>       d.ll = src2;
>> -#define 
>> PMUL(r)                                                         \
>> -    tmp = (int32_t)d.VIS_SW64(r) * ((uint32_t)s.VIS_B64(r * 
>> 2));        \
>> -    if ((tmp & 0xff) > 0x7f) 
>> {                                          \
>> -        tmp += 
>> 0x100;                                                   \
>> -    
>> }                                                                   \
>> -    d.VIS_W64(r) = tmp >> 8;
>> -
>> -    PMUL(0);
>> -    PMUL(1);
>> -    PMUL(2);
>> -    PMUL(3);
>> -#undef PMUL
>> +    d.VIS_W64(0) = do_ms16b(s.VIS_B64(0), d.VIS_SW64(0));
> 
> s.VIS_B64(0) for lower bit, OK.

Ditto.

> 
>> +    d.VIS_W64(1) = do_ms16b(s.VIS_B64(2), d.VIS_SW64(1));
>> +    d.VIS_W64(2) = do_ms16b(s.VIS_B64(4), d.VIS_SW64(2));
>> +    d.VIS_W64(3) = do_ms16b(s.VIS_B64(6), d.VIS_SW64(3));
>>       return d.ll;
>>   }
> 
> Maybe add a comment for high/low bits in fmul8sux16/fmul8ulx16,
> as it was not obvious at first. Otherwise,
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 


