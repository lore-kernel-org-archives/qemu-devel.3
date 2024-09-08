Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74C56CD4F4C
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2024 20:57:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snOyE-0000Ns-Gv; Sun, 08 Sep 2024 16:57:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1snOyC-0000NN-VK
 for qemu-devel@nongnu.org; Sun, 08 Sep 2024 16:57:16 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1snOyB-0006YT-4z
 for qemu-devel@nongnu.org; Sun, 08 Sep 2024 16:57:16 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-206b9455460so29598545ad.0
 for <qemu-devel@nongnu.org>; Sun, 08 Sep 2024 13:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725829033; x=1726433833; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lOnxo3WPcdlSAN8Byyn41aZrldl+bFA8fK0Eo3Pj9uA=;
 b=EPAcnXOxVAGQWKbil7HDWzuCwBXGb/nLClMVlslF7xpob8A3Lij3l11U2qsIvT8T+K
 NNSLiYK0zIXyNbD6xRYnlOL84VG7rR5JR6p6fxGPkODpqxDTbfb9cNwyerLYRipuzeKS
 foMXfrUCttABOWA9YE6CQMmlOUJAdQXQztemV0JN/udAZd+CpwxpdLjQsdGXz6IeX+ii
 exZ42xtX3LYdBvIq7t61ezFAPOpxGjBvDdzXlKYZ2ZEMmlvf2ESPUFa4GFrfh6id/BsQ
 xeTjgG4y3uUbsw4Ihs1u5cBs/0U33+Bh8U5D2mDT+dVLfC7uKWFiNIDeZ/UvxSA5w91R
 B5qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725829033; x=1726433833;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lOnxo3WPcdlSAN8Byyn41aZrldl+bFA8fK0Eo3Pj9uA=;
 b=gSqlEq0/5A9zp25HxVHtWvUEQUWhR+vFAMjk8QR+YWKXgjgUzHmHmH/Zds7oHKeXmJ
 AqKW1Uo2GandvoLvySwaeMkhe2wxfrJ8V1FoA9g6DRA8OfrwF50bNmFeFBDha0xUhHS+
 AH4JJKk60zmIWByrYVvELvLB4r86dMvrc2stGJHefPSNQ5JkWUEeMqSLHhzXpdkldpYT
 UHIueSMtQ0WSN8NpCijbVT/D5lcxYZIcds9QA/t1clwMDrwxzzmcG3vVeGylEaeV42vQ
 546l9i7VRTKU27OnzpmALpmPYNXhhpzq+HcIdISILz2hDKBmqCj6jiuWQOlEB9aGXY/X
 dZwA==
X-Gm-Message-State: AOJu0YwHqCj3aHJH59FnWMK8/J4abJNc2cEh+1uEw0wbsEV0dSGy9eoO
 dgxrwlmVHUQOTZzOZb0pOOTbzHDOrq7HA8gH0nzuOAoqSW4ghYrwKHN+FahbaDk=
X-Google-Smtp-Source: AGHT+IHHDsqVBkD1TbzQzWUwFXBmF1sJRLlH/Uj6hsjTJiEitipW7zmL31FhqwLe6k5hu6orDcTwZg==
X-Received: by 2002:a17:902:d501:b0:205:76c1:3742 with SMTP id
 d9443c01a7336-206ee92559dmr122548225ad.3.1725829033060; 
 Sun, 08 Sep 2024 13:57:13 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710f222a2sm22943065ad.203.2024.09.08.13.57.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Sep 2024 13:57:12 -0700 (PDT)
Message-ID: <a1ac975f-6d79-43bd-8c2e-68a2fbb9c3b2@linaro.org>
Date: Sun, 8 Sep 2024 13:57:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] target/i386/gdbstub: Factor out gdb_get_reg() and
 gdb_write_reg()
To: Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>, 
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20240802095942.34565-1-iii@linux.ibm.com>
 <20240802095942.34565-4-iii@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240802095942.34565-4-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 8/2/24 02:59, Ilya Leoshkevich wrote:
> @@ -248,6 +253,22 @@ static int x86_cpu_gdb_load_seg(X86CPU *cpu, X86Seg sreg, uint8_t *mem_buf)
>       return 4;
>   }
>   
> +static int gdb_write_reg(CPUX86State *env, uint8_t *mem_buf, target_ulong *val)
> +{
> +    if (TARGET_LONG_BITS == 64) {
> +        if (env->hflags & HF_CS64_MASK) {
> +            *val = ldq_p(mem_buf);
> +        } else {
> +            *val = ldq_p(mem_buf) & 0xffffffffUL;
> +        }
> +        return 8;
> +    } else {
> +        *val &= ~0xffffffffUL;
> +        *val |= (uint32_t)ldl_p(mem_buf);
> +        return 4;
> +    }
> +}
> +
>   int x86_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
>   {
>       X86CPU *cpu = X86_CPU(cs);
> @@ -288,18 +309,7 @@ int x86_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
>       } else {
>           switch (n) {
>           case IDX_IP_REG:
> -            if (TARGET_LONG_BITS == 64) {
> -                if (env->hflags & HF_CS64_MASK) {
> -                    env->eip = ldq_p(mem_buf);
> -                } else {
> -                    env->eip = ldq_p(mem_buf) & 0xffffffffUL;
> -                }
> -                return 8;
> -            } else {
> -                env->eip &= ~0xffffffffUL;
> -                env->eip |= (uint32_t)ldl_p(mem_buf);
> -                return 4;
> -            }
> +            return gdb_write_reg(env, mem_buf, &env->eip);

Existing bug, but the insert in the !(TARGET_LONG_BITS == 64) case is silly.
Because TARGET_LONG_BITS == 32, target_ulong eip is 32-bits, so the "insert" doesn't 
really insert anything.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

