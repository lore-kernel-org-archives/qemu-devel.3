Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D94E4C48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 19:18:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rb3iT-0006wB-8u; Fri, 16 Feb 2024 14:17:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rb3iP-0006vp-PN
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 14:17:42 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rb3iM-0001PK-AJ
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 14:17:41 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1d746ce7d13so9646155ad.0
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 11:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708111056; x=1708715856; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ipa2AM2+0IQzaimn5gn7z5C81bygfD9LxyUBDHSCB1E=;
 b=lfErnamAJX82tJYnrQ+CPCAfJG3vwEIFKPjD3NCCAW1mJqeZQkVceHCcT9qf4+/tDo
 zdfo3ipYG7zzh9oLjvXjkQJAYloAoh7xfP8dJQUG+LziKxqkuFquPsLf+e+BodKTCD4R
 1p3emBcsDYpsBmo+0VY7Hv4tv4sJUWrm4KZdh+VMxufEC0hW+ajDFiEHvp7PtSxS8D+B
 2ny+T43No1h7Yex0KIPVJeBuVQsT4L3JKEOXOqoSrxADTTjFwXcCdohdehu52MjeCA3L
 HpZHo7k4whl/k21p/VmNr/d5bhMBvFTWjiGwOR4wxl73rMNFpd/seg+H8qWvjPbBFt8i
 E+CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708111056; x=1708715856;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ipa2AM2+0IQzaimn5gn7z5C81bygfD9LxyUBDHSCB1E=;
 b=iu5cZEmAF2rXTUFiyXPJ9+19VOO7NqM+jujs52RxypuyCBXxLt7Xmgca3o4GfoXoTt
 /l5WUaKzE0jh/ntLeGKr3JYuzxcIPsTaFvNbsbhFlP4doEnxG/baXXgwlQsTtFceAPWR
 zo+unnvxY6HPR1DzAJ8Kp/YapEl/d3fK+Tr0nQIfMrzkWbZV1FOgqrnRxb2Q4VaFopLB
 f/bXbuio3G0wSvcM4TqQhe45uUYdtFH1ePeZ6uL3U/8UXmPG4n12MJL13+05SHeuX4cg
 lpM6tGMvmQIKBoMI1rfNDcD4ad1Un8QqmEKF3bTQLCJPaoH/deeHSpxcaMOk/mGe08oI
 2V8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVh1/tXG1wPk0YGphYELxsJOQ0GXMQyjke8gbP9OhRcvYDeVnxD/CF/lmh/nQLu5U64vySHLGWaL/4ZdryRdP5gdONvb0=
X-Gm-Message-State: AOJu0YzP5udACVLh5HYUwSur+v7wifP7XOnYi+pYKrpx79LzVhSMS/0c
 2M393KYafd5eQk6569Hktk7Ijlw56wOoDHE1qIO3Ps8DDJFM+FKcL5V8XMP1r3g=
X-Google-Smtp-Source: AGHT+IEmzxuEb5frJyuqBv7zhc6JcYzhyr1IJEsTkE8YMUZR7lEFTArhtyNmx3fVv5M+E1GqXbr+tg==
X-Received: by 2002:a17:902:7ec2:b0:1da:192f:3eb2 with SMTP id
 p2-20020a1709027ec200b001da192f3eb2mr4309447plb.46.1708111056525; 
 Fri, 16 Feb 2024 11:17:36 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 p3-20020a170902c70300b001db86c48221sm217260plp.22.2024.02.16.11.17.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Feb 2024 11:17:35 -0800 (PST)
Message-ID: <b93bf454-723e-456b-9328-2e2ec74070e0@linaro.org>
Date: Fri, 16 Feb 2024 09:17:32 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] target/arm: Adjust and validate mtedesc sizem1
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, gustavo.romero@linaro.org, qemu-stable@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240207025210.8837-1-richard.henderson@linaro.org>
 <20240207025210.8837-4-richard.henderson@linaro.org>
 <572bd0e6-002e-4990-a9e0-e70eec65fd93@tls.msk.ru>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <572bd0e6-002e-4990-a9e0-e70eec65fd93@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2/16/24 05:12, Michael Tokarev wrote:
> 07.02.2024 05:52, Richard Henderson :
>> When we added SVE_MTEDESC_SHIFT, we effectively limited the
>> maximum size of MTEDESC.  Adjust SIZEM1 to consume the remaining
>> bits (32 - 10 - 5 - 12 == 5).  Assert that the data to be stored
>> fits within the field (expecting 8 * 4 - 1 == 31, exact fit).
>>
>> Cc: qemu-stable@nongnu.org
>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/arm/internals.h         | 2 +-
>>   target/arm/tcg/translate-sve.c | 7 ++++---
>>   2 files changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/target/arm/internals.h b/target/arm/internals.h
>> index fc337fe40e..50bff44549 100644
>> --- a/target/arm/internals.h
>> +++ b/target/arm/internals.h
>> @@ -1278,7 +1278,7 @@ FIELD(MTEDESC, TBI,   4, 2)
>>   FIELD(MTEDESC, TCMA,  6, 2)
>>   FIELD(MTEDESC, WRITE, 8, 1)
>>   FIELD(MTEDESC, ALIGN, 9, 3)
>> -FIELD(MTEDESC, SIZEM1, 12, SIMD_DATA_BITS - 12)  /* size - 1 */
>> +FIELD(MTEDESC, SIZEM1, 12, SIMD_DATA_BITS - SVE_MTEDESC_SHIFT - 12)  /* size - 1 */
>>   bool mte_probe(CPUARMState *env, uint32_t desc, uint64_t ptr);
>>   uint64_t mte_check(CPUARMState *env, uint32_t desc, uint64_t ptr, uintptr_t ra);
>> diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
>> index 7108938251..a88e523cba 100644
>> --- a/target/arm/tcg/translate-sve.c
>> +++ b/target/arm/tcg/translate-sve.c
>> @@ -4443,17 +4443,18 @@ static void do_mem_zpa(DisasContext *s, int zt, int pg, TCGv_i64 
>> addr,
>>   {
>>       unsigned vsz = vec_full_reg_size(s);
>>       TCGv_ptr t_pg;
>> +    uint32_t sizem1;
>>       int desc = 0;
>>       assert(mte_n >= 1 && mte_n <= 4);
>> +    sizem1 = (mte_n << dtype_msz(dtype)) - 1;
>> +    assert(sizem1 <= R_MTEDESC_SIZEM1_MASK >> R_MTEDESC_SIZEM1_SHIFT);
>>       if (s->mte_active[0]) {
>> -        int msz = dtype_msz(dtype);
>> -
>>           desc = FIELD_DP32(desc, MTEDESC, MIDX, get_mem_index(s));
>>           desc = FIELD_DP32(desc, MTEDESC, TBI, s->tbid);
>>           desc = FIELD_DP32(desc, MTEDESC, TCMA, s->tcma);
>>           desc = FIELD_DP32(desc, MTEDESC, WRITE, is_write);
>> -        desc = FIELD_DP32(desc, MTEDESC, SIZEM1, (mte_n << msz) - 1);
>> +        desc = FIELD_DP32(desc, MTEDESC, SIZEM1, sizem1);
>>           desc <<= SVE_MTEDESC_SHIFT;
>>       } else {
>>           addr = clean_data_tbi(s, addr);
> 
> There's no question about stable-8.2 here, this change needed there.
> But I've a question about stable-7.2 - does it make sense to pick this
> one up for 7.2?  It quickly goes out of control, because this one
> is on top of
> 
>   523da6b963455ce0a0e8d572d98d9cd91f952785 target/arm: Check alignment in helper_mte_check
>   (this one might be good for 7.2 by its own)
>   which needs:
>    3b97520c86e704b0533627c26b98173b71834bad target/arm: Pass single_memop to gen_mte_checkN
>    which needs:
>     6f47e7c18972802c428a5e03eb52a8f0a7bebe5c target/arm: Load/store integer pair with one 
> tcg operation
>     which needs:
>      needs 128bit ops
>      659aed5feda4472d8aed4ccc69e125bba2af8b89 target/arm: Drop tcg_temp_free from 
> translator-a64.c
>      ...
> 
> So I think it's not a good idea to go down this hole..
> 
> Probably ditto for the other two:
>    target/arm: Split out make_svemte_desc
>    target/arm: Handle mte in do_ldrq, do_ldro
> 
> Makes sense?  Or it's better to do a proper backport?

I don't think it makes sense to go back too far.

r~


