Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2484CD8CAA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 14:34:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWxWY-0000SG-4B; Tue, 09 Jun 2026 10:33:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wWxWV-0000Rt-Sx
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 10:33:48 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wWxWU-0006Ul-Di
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 10:33:47 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-c85a2ca7bf7so2094457a12.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 07:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781015624; x=1781620424; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=b38ofrrBZbh3N7PockUt/wJ+PHtvxjxr+dRL1CGBkRM=;
 b=X5JA+FP4Nj/TbjKYvSS+Iy6ABSUyDTobbh/PSBUp5+JUD1eeLuJiJtVsC/TtrdyEhc
 VVt0OnSDKjUauYNbugXNnncSAgtIiM3EDjzw8TKcvOeY/w3KsUjYi2LVtb3ITRpf3IfA
 uTngpSSi0eAkKQiHzffypqdzIT9R5FEGWIC2qtJ1CpplcJi9wHKv5UpJOYYqE9vQf28e
 sU3EvOm3de9LUxW8DraFjmywstoue6sCHkhhJnf8x+BtxhbFqv3iKiEdjm00Ws9+ZPUg
 W7wQTlC3gt4yShYq8hUOLpjzM+Nu4Tr33/whUx1tCjtUaOISYCRP+deXfkSg8VB3wJRC
 j3lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781015624; x=1781620424;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=b38ofrrBZbh3N7PockUt/wJ+PHtvxjxr+dRL1CGBkRM=;
 b=pKYLQVRe3giDk29ehlNx6QNrynQCokDsMHke9RbrP3uJ8hhgyG4qsefAsjpFtbAp8f
 ji58VHwdwAluezBRrnfn+CPDJGwZYAR/RzlL9o2hotvRH3S4qZskVHENCZo/GdFNfwJe
 +ScRe3L8TMlLITK/57MiD8TpDBPROw0IIO4N1lkKJgShIhl+GOGZ3rmc85KIJ+M3kXyb
 vWx8/LCTEVJv3NZ2yvWQa+Hhu+Rj0/cLU4gqthzpc0LY8mqlXQ8BlsjWgE0ndlWS6xwX
 5btnGdd4VDU8oiqJY52fbA9+zsWn9gCMkUuOmen9XtvwFexllPKZk1W7u3sZ1eYZ/iUC
 Pe4A==
X-Gm-Message-State: AOJu0Yxda9Ey1GAkPW6VpAPbdUnCA1gADNhEcKnlURO2lTQ4Hgl30jVN
 d+XGwpNtyJwL8aIAWa3dNErj+7y+qREQEps3IrpipIz2uLjPeoGqmHXqvRuJFW3HMG8=
X-Gm-Gg: Acq92OESXF8X5xqrJU0A2scNeXcx9s6j+uAXbs7v5SDfEQNabz/5KjmGOvtvWiyoUz8
 7uxnAn4k2ctTYp5tRXAx+3G/zowYc0VTSWSZhQ8YpmXk55mM2BcCff2TX/EIRf52QY8sfB7HFte
 CKPeIweAPUatzIJxs7m3NC1LxOQF26y9nuIOK62nr/kW8nhdrXKzqjH3gRNfi9LDqR2c7KuIdzW
 08Exfb+diKk6xH97RyR9u3we4kgNV222IhK+SpqIWzJbmjSy85IyWXKV8v0JPXYuR0ZHGAfSt81
 wQszo0NEBmiVzr9xTXm4tguvVsSWFRyU8q5WN8n0wYPE4e/7OMf/KlUd2l7zKg5ifALMyl7I099
 9WdwLj6kHV8RRqssNDjVWzZsWPESySHB0oxx9GD7Srjpag7dioDFylnHcu/Z70FXHarbkyc4ZDL
 vXBtsPb/XjOtDHBnJM7aJLNxAKw/CC4FjI5PhyGcxmCz+meW4=
X-Received: by 2002:a05:6a20:db09:b0:3b1:80c7:5f8c with SMTP id
 adf61e73a8af0-3b4ccf3c4b2mr25422052637.28.1781015624301; 
 Tue, 09 Jun 2026 07:33:44 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c85df032df5sm18265942a12.6.2026.06.09.07.33.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2026 07:33:43 -0700 (PDT)
Message-ID: <9ef94406-6544-4262-866c-c84d6ced6e3b@linaro.org>
Date: Tue, 9 Jun 2026 07:33:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 03/45] target/arm: Use FloatParts64 in f16_dotadd
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20260603032855.106930-1-richard.henderson@linaro.org>
 <20260603032855.106930-4-richard.henderson@linaro.org>
 <CAFEAcA9D3x7hD=RmhddTmuHWvd+cpp027A18k+OQY3sPiQrW_g@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA9D3x7hD=RmhddTmuHWvd+cpp027A18k+OQY3sPiQrW_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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

On 6/9/26 03:51, Peter Maydell wrote:
> On Wed, 3 Jun 2026 at 04:29, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Use softfloat-parts.h so that we can more naturally
>> perform the required operations witha single rounding step.
>> This happens to also simplify the NaN detection step.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Message-Id: <20260517002550.321291-11-richard.henderson@linaro.org>
>> ---
>>   target/arm/tcg/sme_helper.c | 96 ++++++++++++++++---------------------
>>   1 file changed, 40 insertions(+), 56 deletions(-)
> 
> 
> 
>> @@ -1240,48 +1238,49 @@ static float32 f16_dotadd(float32 sum, uint32_t e1, uint32_t e2,
>>       float16 h2c = e2 >> 16;
>>       float32 t32;
>>
>> +    FloatParts64 p1r = float16_unpack_canonical(h1r, s_f16);
>> +    FloatParts64 p1c = float16_unpack_canonical(h1c, s_f16);
>> +    FloatParts64 p2r = float16_unpack_canonical(h2r, s_f16);
>> +    FloatParts64 p2c = float16_unpack_canonical(h2c, s_f16);
>> +
>> +    int all_mask = (float_cmask(p1r.cls) | float_cmask(p1c.cls) |
>> +                    float_cmask(p1r.cls) | float_cmask(p1c.cls));
> 
> This looks like a cut-and-paste error : we don't take account
> of p2r.cls and p2c.cls, so if those inputs are NaNs we won't
> handle them correctly. This should fix it:
> 
> --- a/target/arm/tcg/sme_helper.c
> +++ b/target/arm/tcg/sme_helper.c
> @@ -1244,7 +1244,7 @@ static float32 f16_dotadd(float32 sum, uint32_t
> e1, uint32_t e2,
>       FloatParts64 p2c = float16_unpack_canonical(h2c, s_f16);
> 
>       int all_mask = (float_cmask(p1r.cls) | float_cmask(p1c.cls) |
> -                    float_cmask(p1r.cls) | float_cmask(p1c.cls));
> +                    float_cmask(p2r.cls) | float_cmask(p2c.cls));
> 
>       /* C.f. FPProcessNaNs4 */
>       if (unlikely(all_mask & float_cmask_anynan)) {

Gah.  Same error in patch 1.

r~

