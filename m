Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CE93C47DDF
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jan 2024 00:16:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTsq6-0006mi-VY; Sat, 27 Jan 2024 19:15:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTsq5-0006mZ-Gd
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 19:15:57 -0500
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTsq3-0003LW-MO
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 19:15:57 -0500
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-5d8b70b39efso372874a12.0
 for <qemu-devel@nongnu.org>; Sat, 27 Jan 2024 16:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706400952; x=1707005752; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/EKWqtgEQ9kdDW/GW6lVbtuPcBXx65x9PYzHXgmXFnY=;
 b=tsu2TzBfEB10iZMB1+UjSQR66ZVANbUGiyU8KP9EqazAEMwsQa5E2PDzvdtHVivnRG
 qg8UOw9yg3+G1qEjrThfouIWEXAUKy7s/Exvry1/ZlzoMbde4Wyx5gzeAHrvXYMZC+Cr
 f+9qH1s9y9V9k0qClXZ1PzyF5wrQPgUnhU0fDhTF2VeNsJuUqrZARKvrXO6KdaTmnggj
 V6Rn/qERKdxOnW5fgu8tzr8DlPdy126v7E1plDz33uh7edBIsZMET9BWtUXRHz/twWKz
 /+LWI7FNkgH9BmpkRbO5ioEvRpXX0b+3QLUdEoJNaUhkGo0b7I5g0JcTj5EBML7fX7Fv
 SvOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706400952; x=1707005752;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/EKWqtgEQ9kdDW/GW6lVbtuPcBXx65x9PYzHXgmXFnY=;
 b=SkIRlXAEyYdTfiz5MRwVd+N53ZYW8nKkpTnv2XvnPpxs0a6J4BgiuStskVuWvSA8GP
 FjT6uRn38s20tY5vRvtES1gF8GRaXOFHglb79YiJnL6bpd4x/YSe5GUWgTiyV5n/DpM1
 JdwAhy5IBAgj3TC8DL71AzXdvT/etOZGouBoxHT1u1BkJjFmU6ApTySh89EOzvBT9HV3
 1zy4LomzzG6ab/MpVP44a93e2ANB22mnQTWPD2tKKa3ch0+dBDQQ7gOcQZ2CHVJfnj8E
 c9bBzmK7z2JKvpRKsYdW4kljUFzwc0X9j8EJyvCDkv87cWgLdZTzy11XCF8dtqZe7CpS
 q3+w==
X-Gm-Message-State: AOJu0YxsFPeonNeoKQ7r3L9Pw1Eo/D6sWlXWofbifd2m28hmJR7lvalt
 jefUrM3r9ZEfNWCPgkDzLf3bAaIR5SAZqHKrA1r27+anC32TnM2WNqbzZq6vLsA=
X-Google-Smtp-Source: AGHT+IFKAvY28kpLoa5mhYcwlr1UDzKKcCfGM4wp2Y9KAdmnwB+6ogkA6+F+taTllz9pMqNDX8vl5w==
X-Received: by 2002:a17:90a:9743:b0:290:5217:47eb with SMTP id
 i3-20020a17090a974300b00290521747ebmr853879pjw.86.1706400951875; 
 Sat, 27 Jan 2024 16:15:51 -0800 (PST)
Received: from ?IPV6:2001:44b8:2176:c800:5c13:51aa:e666:7387?
 ([2001:44b8:2176:c800:5c13:51aa:e666:7387])
 by smtp.gmail.com with ESMTPSA id
 jw20-20020a170903279400b001d8b8e1a67bsm1360305plb.297.2024.01.27.16.15.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 27 Jan 2024 16:15:51 -0800 (PST)
Message-ID: <afc77d82-6f8f-4e16-a178-01630ee10b69@linaro.org>
Date: Sun, 28 Jan 2024 10:15:43 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 16/34] exec: [CPUTLB] Move cpu_*()/cpu_env() to common
 header
From: Richard Henderson <richard.henderson@linaro.org>
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, philmd@linaro.org
References: <20240119144024.14289-1-anjo@rev.ng>
 <20240119144024.14289-17-anjo@rev.ng>
 <b18b9f43-dcf7-4eac-8e97-5a6f805b257a@linaro.org>
Content-Language: en-US
In-Reply-To: <b18b9f43-dcf7-4eac-8e97-5a6f805b257a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
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

On 1/28/24 08:14, Richard Henderson wrote:
> On 1/20/24 00:40, Anton Johansson wrote:
>> --- a/include/exec/cpu-common.h
>> +++ b/include/exec/cpu-common.h
>> @@ -347,4 +347,29 @@ G_NORETURN void cpu_loop_exit_restore(CPUState *cpu, uintptr_t pc);
>>    */
>>   #define PAGE_PASSTHROUGH 0x0800
>> +/* accel/tcg/cpu-exec.c */
>> +int cpu_exec(CPUState *cpu);
>> +
>> +/**
>> + * env_archcpu(env)
>> + * @env: The architecture environment
>> + *
>> + * Return the ArchCPU associated with the environment.
>> + */
>> +static inline ArchCPU *env_archcpu(CPUArchState *env)
>> +{
>> +    return (void *)env - sizeof(CPUState);
>> +}
>> +
>> +/**
>> + * env_cpu(env)
>> + * @env: The architecture environment
>> + *
>> + * Return the CPUState associated with the environment.
>> + */
>> +static inline CPUState *env_cpu(CPUArchState *env)
>> +{
>> +    return (void *)env - sizeof(CPUState);
>> +}
>> +
>>   #endif /* CPU_COMMON_H */
> 
> Missing include of hw/core/cpu.h, as far as I can see?

Queued, with this fix.

r~


