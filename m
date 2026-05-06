Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44CF2CD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 10:50:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKZop-0004gs-4a; Wed, 06 May 2026 06:49:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKZoo-0004gE-6i
 for qemu-devel@nongnu.org; Wed, 06 May 2026 06:49:30 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKZom-0000LF-9k
 for qemu-devel@nongnu.org; Wed, 06 May 2026 06:49:29 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-44dd5cb0f81so491170f8f.0
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 03:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778064565; x=1778669365; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zU9LBj5AhZF1r4qrOfG0t5oxandCJxxHJOrOeSyYs4c=;
 b=NpjW8F1ipzbDJpxPjiidBiaRRBQnpnX7e6mpe28wVCrnL90bNxwy5RHDuHxT6sd/+s
 utIPCkeZouB3n+oaHCX8mnHfHWP5kQwIwYy4/G/ryqqMDxfaIWxdMZOJ/scr8Nypt8XH
 /2ldE8qvhH0BBhd6B4NTgOCJgN+jPD0aKAF3thvM98dx3jGqASlv2ecw3+rT/3bwi947
 yTWKanK5pM88f+kkM9ECOkISCPdT2eu1PxT86F8JWEp4BmSOe3aMsmiVnQ9xGro3p+ZB
 RjPjFo/K2lAllCgvWxcGozf/vOESjeNReMP7KNbECxR0zwNQ6mhkrKYyR+RbzE5UEJ8i
 15oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778064565; x=1778669365;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zU9LBj5AhZF1r4qrOfG0t5oxandCJxxHJOrOeSyYs4c=;
 b=sMCo8dwlrnq01Fb9rBrWCpkcbtwWvxrBp9iTCelWcZu+SJhbWWD1tqCXjEybETGHdC
 P4hY9/6iipz8GO2/3BPTHcOcxr/8Bs04aZPNxuRSK0czpxMtSp9vgHT1BDidwPJG5vub
 cVBftKh/TcGm3uvoZXpWn7XnmpYELviIjWhUAxXiusx4AmhLHLHyMdLyzbqvmf0jJLq8
 lL5yV307BYxsn9SrVMVJLtIPVo32JAjlUNCFDCoaP0KJogZHvAKbWJMc15us04JnLLNK
 lDREjVSs2LNXj3gIBkX/x6pe6rh3X1QmHo8lIAAgBtsv65uL9GvjURXnd22JGAJNEi/e
 S9MQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/gGXiYaK22/CWwwU/i4zCJqQoxkEYWP+Rh9ibnqJN7eZE1+Ak/oZui3xhiTSixixoFAAyTBVoBnDQD@nongnu.org
X-Gm-Message-State: AOJu0YxUoipUKCStabN+skvkI2ctyHxckE0nHB41oeheoOfmEqEsEc1X
 CFzMQ2mMMGTlv0NoBAN2Em2YQTYFqgqP5hLXKrnS1e89o/QGMdVzxz3XKXvlgUjIS70=
X-Gm-Gg: AeBDietfsUqnowxEhB+K+Jod3nOU156FcbVUZpcD/YhdHI3GAjkZHXwGYvcSPNEFJqE
 g4BOzYAxo4bjclC8yBKi1IA4aN/y8OSZ5vPMxOYRTR8VY4Jnp07KXnSbYjcBKq8h0KqpOXHsZC6
 ynISGY7m9U1qFtzMJI0rfMokKPyzlUrLZkXS9Bgdz7Ikk3c4huk0JyOtqxb745Jf13DvWjJfGC7
 0idQtFi9OJQN3GQlKEj79NtWyQXUpHBpskkiDKDKwi4He5YAf0ndS6GQvgH2LDmdf+L6rZ1dTQr
 JPX9xDLoE1ulzMJHO4Ii8bDcf3kKD9ARbpi+YgR2H57ON4xQNgpf0rVk5d4zPfOkludITVs8pVu
 G1q4rWPVYfZGCpVam9wgud29PGS6dRI5BoIK49jxkhcwpSZJ67raJigBBz9ganq0htQO9mhM8JZ
 zxnX5s4KU/SI7bTR0lqYThcJTDyg7NXALit3aa9XeZzOovFxgqTMxYRtsK83TTnm9gWCP/APS9k
 gWL
X-Received: by 2002:a05:6000:2f89:b0:446:708e:1e8d with SMTP id
 ffacd0b85a97d-44fe007e545mr10870142f8f.30.1778064565131; 
 Wed, 06 May 2026 03:49:25 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45055f249bbsm10318847f8f.36.2026.05.06.03.49.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 May 2026 03:49:24 -0700 (PDT)
Message-ID: <289ac111-5f8e-4809-b826-859437894a8b@linaro.org>
Date: Wed, 6 May 2026 12:49:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] target/mips: Move 'mvp' field from CPUMIPSState to
 MIPSCPU
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
References: <20260317175031.3035740-1-peter.maydell@linaro.org>
 <20260317175031.3035740-2-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260317175031.3035740-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 17/3/26 18:50, Peter Maydell wrote:
> The 'mvp' field in the CPUMIPSState is a pointer to memory allocated
> in mvp_init().  This is in theory fine, but in practice it clashes
> with the current linux-user implementation of cpu_copy(), which
> assumes it can do a shallow memcpy() copy of the CPU env struct in
> order to clone the CPU when creating a new thread.
> 
> Almost all of the MIPS env struct is actually memcpy() copyable;
> one of the exceptions is the mvp pointer. We don't need this
> to be in the env struct; move it to the CPU object struct instead.
> 
> At the moment the memcpy() of the env->mvp pointer doesn't have any
> obvious ill-effects, because we never free the memory and it
> doesn't contain anything that varies at runtime for user-mode.
> So thread 2 ends up pointing at thread 1's mvp struct, but it
> still works OK. However, we would like to free the mvp memory to
> avoid a leak when a user-mode thread exits, and unless we avoid
> the shallow copy this will end up with a double-free when both
> thread 1 and thread 2 free the same mvp struct.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/mips/malta.c                     |  4 ++--
>   target/mips/cpu-defs.c.inc          | 10 +++++----
>   target/mips/cpu.c                   |  2 +-
>   target/mips/cpu.h                   |  3 ++-
>   target/mips/internal.h              |  3 ++-
>   target/mips/system/machine.c        |  2 +-
>   target/mips/tcg/system/cp0_helper.c | 35 ++++++++++++++++++-----------
>   target/mips/tcg/translate.c         |  6 +++--
>   8 files changed, 40 insertions(+), 25 deletions(-)


> diff --git a/target/mips/cpu-defs.c.inc b/target/mips/cpu-defs.c.inc
> index d93b9d341a..faefab0473 100644
> --- a/target/mips/cpu-defs.c.inc
> +++ b/target/mips/cpu-defs.c.inc
> @@ -1034,7 +1034,9 @@ static void fpu_init (CPUMIPSState *env, const mips_def_t *def)
>   
>   static void mvp_init(CPUMIPSState *env)
>   {
> -    env->mvp = g_malloc0(sizeof(CPUMIPSMVPContext));
> +    MIPSCPU *cpu = env_archcpu(env);
> +
> +    cpu->mvp = g_malloc0(sizeof(CPUMIPSMVPContext));

There is no point in allocating this 12-byte structure...
Another cleanup for tomorrow.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> diff --git a/target/mips/cpu.h b/target/mips/cpu.h
> index ed662135cb..8de3178b6d 100644
> --- a/target/mips/cpu.h
> +++ b/target/mips/cpu.h
> @@ -1174,7 +1174,6 @@ typedef struct CPUArchState {
>       struct {} end_reset_fields;
>   
>       /* Fields from here on are preserved across CPU reset. */
> -    CPUMIPSMVPContext *mvp;
>   #if !defined(CONFIG_USER_ONLY)
>       CPUMIPSTLBContext *tlb;
>       qemu_irq irq[8];
> @@ -1209,6 +1208,8 @@ struct ArchCPU {
>       Clock *clock;
>       Clock *count_div; /* Divider for CP0_Count clock */
>   
> +    CPUMIPSMVPContext *mvp;
> +
>       /* Properties */
>       bool is_big_endian;
>   };


> diff --git a/target/mips/system/machine.c b/target/mips/system/machine.c
> index 8af11fd896..67f6f414d9 100644
> --- a/target/mips/system/machine.c
> +++ b/target/mips/system/machine.c
> @@ -233,7 +233,7 @@ const VMStateDescription vmstate_mips_cpu = {
>                          CPUMIPSFPUContext),
>   
>           /* MVP */
> -        VMSTATE_STRUCT_POINTER(env.mvp, MIPSCPU, vmstate_mvp,
> +        VMSTATE_STRUCT_POINTER(mvp, MIPSCPU, vmstate_mvp,
>                                  CPUMIPSMVPContext),

