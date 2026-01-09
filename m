Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2FBAD26D6F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 16:26:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veFJM-0004ds-KG; Fri, 09 Jan 2026 11:26:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1veFJL-0004dY-Sa
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 11:26:03 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1veFJK-00035W-47
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 11:26:03 -0500
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-34c21417781so3118843a91.3
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 08:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767975960; x=1768580760; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Qu2wFnGRtbehRdqkEmYr47vOdAnKrlZavO8n8gQYgNA=;
 b=smqtkI9IjvWbMb6n96YZEsEKUKkxq/a1GObfH2w+WLk6K7EJqwtvKbaW9VBdJ0yjoj
 aSH5Kn9+uZZ8pseAAtalZlwwcc8ypXztnzVOo81kL/dUPWFNmTKXikzhJ474sLo2u0pD
 7KqQInB/SWIqIqrv5uUJD3ZbjA1EQC5KHXNw3cYwiRMtuQm8y3L3V03+tTotet+pSlTv
 qqJxe+wyA0j33XDhokN9eq3GURWk99JC+u8VTExbUHjKg0dZsgnW/3kOkErVLp1h0+fO
 4UXCmBQrtbUOPrFgFj+pRheBWd+xsihB1iehedRE+7lI/5XukEzzTcfykfoG9jVs49Vb
 ps3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767975960; x=1768580760;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Qu2wFnGRtbehRdqkEmYr47vOdAnKrlZavO8n8gQYgNA=;
 b=n9MxCcoBQUIMGBHMt1CXPvMYalCv1941t++R8volwrRlB2w0sZX5u99qWXDB0bhD6m
 uyfIhgWxp2HuZtcnLT+/vbSY4Cbrf9UeYFgdqsTelNL0jkz2PhJU4qxdKigTVRFGcXOA
 J60ALk3vCqGHroD7P55yWSKiSMU7qXn0R3S5AqAIvJ2Ujl1HHwOPCqXNU/yMjhMaUFpx
 4a5UMz3dGcUgA8sFP9l0BV0X2lGv5s7gnQydCZ2ReRIIxdfoMYL9fFpVPeZRZi11Q+Nm
 z6U0kvQY48rUK59Eryxpl4Ls9V8z/eJyZA9kmT3/8UJMN1utNiRCipdD7bIptnpDsMZw
 m/cg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUO9srIvS+lSv//xtaqWqimr+QxSVSFL32TP9mSlO83gnON6gcE+vg8EABygPFiJMEsMHbT40DhYG88@nongnu.org
X-Gm-Message-State: AOJu0YwA0Ai4wy6tcpdUDkqt/mVM1KDhPBSSATWyT8//6t7Caou8lHUc
 i8l6rUlW+K6JNaHMWT0f9Uv5bR8ySg+aMvM51COttfZHeBRQV+MHhqjcpL/oYlX4ktPDE3371eU
 ss3nD
X-Gm-Gg: AY/fxX5XZ5wrfsE0OryyEUg5dAX4ABkTM7tr1zmTUr8odh7niXpfaN/IktD7c/em7kt
 rUYS5uvnlonbaG8myT3CCzeUCEZeYk2u7BRKVKLpquPzD9VVnn/WKPYBaGUs/KLyCCBzQoZlVBB
 UBLrpZtqUvEyRXIwiDjFr/QdomJu0jKZnyWo24KTBPyMlDW+2NB+QVZnJdA2/fkYEwkW07e0llU
 z9N0O+nBGqdYJ5D20+135A1NVAy2Nbs2saNcXLOyY6Uxvo6ww9vKGigVPwnlODQxU99gr6Mp5N/
 uuf8vaMpr6osO+HQctxfa2DxBe0PnjRDx3rmJBXFCQtcDm5AbQkIrtPKqUxZD5FT8GRC17ZujtO
 Hoo+gHQ+G5+Il6zbMbKHsAZDud66vHXHY+7j0mmLLLF+HotaxU4WvaNXXKVZorAEXwZX4AWncKg
 4py1UfcQu4gqX6EMWYHWOaYtwEPsYvnQe77eESS+LXuvljcwQjhWVjdj3p
X-Google-Smtp-Source: AGHT+IHfKGxMn2GTto686mlrdfo/EtAXQaE+jtlhAXT80GCsyQmWNQfjeL6IDg8YqxAq8P5Fn/JlKg==
X-Received: by 2002:a17:90b:2783:b0:340:c179:3666 with SMTP id
 98e67ed59e1d1-34f68c023dfmr9600355a91.8.1767975960127; 
 Fri, 09 Jan 2026 08:26:00 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f5f88e95dsm11040987a91.12.2026.01.09.08.25.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 08:25:59 -0800 (PST)
Message-ID: <44f59945-0de8-48e7-91da-6322182b4721@linaro.org>
Date: Fri, 9 Jan 2026 08:25:59 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/29] accel/tcg/translate-all.c: detect addr_type
 dynamically
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>, anjo@rev.ng
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
 <20260109053158.2800705-16-pierrick.bouvier@linaro.org>
 <73ac5b61-ebd1-4451-884f-0b78eaf0ff02@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <73ac5b61-ebd1-4451-884f-0b78eaf0ff02@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102f.google.com
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

On 1/9/26 6:23 AM, Paolo Bonzini wrote:
> On 1/9/26 06:31, Pierrick Bouvier wrote:
>> With TARGET_ADDRESS_BITS mechanism, it's now possible to specify which
>> variant every source file is written for. Compared to before, it means
>> that addr_type will now vary per tb translation, where it was constant
>> for a given target previously.
>>
>> Instead of introducing a new parameter to translator_loop(), we simply
>> add this information in TCGTBCPUState, which is returned by
>> get_tb_cpu_state() during the translation, and passed down to
>> tb_gen_code().
>>
>> To avoid modifying all target with this new field, we simply define a
>> default value that is equivalent to current state: use
>> target_long_bits(). With this, we can progressively convert new
>> architectures.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    include/accel/tcg/tb-cpu-state.h | 12 ++++++++++++
>>    accel/tcg/translate-all.c        | 15 ++++++++++++++-
>>    2 files changed, 26 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/accel/tcg/tb-cpu-state.h b/include/accel/tcg/tb-cpu-state.h
>> index 8f912900ca6..b77c4dd5100 100644
>> --- a/include/accel/tcg/tb-cpu-state.h
>> +++ b/include/accel/tcg/tb-cpu-state.h
>> @@ -8,11 +8,23 @@
>>    
>>    #include "exec/vaddr.h"
>>    
>> +/*
>> + * Default value 0 means to refer to target_long_bits(). It allows to stay
>> + * compatible with architectures that don't yet have varying definition of TCGv
>> + * depending on execution mode.
>> + */
>> +typedef enum TCGvType {
>> +    TCGV_TYPE_TARGET_LONG = 0,
>> +    TCGV_TYPE_I32,
>> +    TCGV_TYPE_I64,
>> +} TCGvType;
>> +
>>    typedef struct TCGTBCPUState {
>>        vaddr pc;
>>        uint32_t flags;
>>        uint32_t cflags;
>>        uint64_t cs_base;
>> +    TCGvType tcgv_type;
> ./
> I know you're trying to avoid more treewide changes and focus on arm
> instead; but it would not be hard to make this TCGType already, or at
> least use TCGV_TYPE_TARGET_LONG only for the other four mixed-length
> frontends (i386, riscv, sparc, and x86_64).
>

I'm not opposed to do this change, but I was (and am) not sure which 
value should apply to which arch.
Mips and ppc have 32 and 64 bits also.
I would feel safer to start with arm only for now and tag other 
architecture while we continue progressing on the single-binary.

> Also, please call it addr_type since tcgv_type makes less sense in the
> long run.
>

Ok!

> Paolo

