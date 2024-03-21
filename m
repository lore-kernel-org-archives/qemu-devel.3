Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD800C54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 02:51:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rn8W9-0007c5-N5; Wed, 20 Mar 2024 22:50:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rn8W8-0007bl-Dt
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 22:50:56 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rn8W6-0008Ia-P9
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 22:50:56 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1def59b537cso3166185ad.2
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 19:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710989453; x=1711594253; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D/DqUZhxsP9omlrKabDo//rOz8qxrnQUf6tz2Tp4hSs=;
 b=FXyY/SQXbb/9V6h7B+O8VH9Tt8b+dfX59G6sm8qzyfUNVBG7qlH8t+a362O9HCs3II
 8fb0f9Z2+q0yavf/1k7snLx6jWbrP5eczeXuwAWnQO+YRBDyjPm2JTOLpc1qeNpSrwbf
 4x8CZqp5h61Q2fEXwigWOnYtK5tMxqCjo4y3v3/SpRl0zvb2N8EvP692StG/jZ7RYAVH
 C9JBspYlilKhqrmhRgGR3u4k31/iyHcVGQlGHudzYOmAfEYEBz9OH0wmF9H+oDey/99l
 DlIXtYEb6jEK78LG5xI3qkR61JL90N2Lx6vcA90HwK7YG4ChSqK+Q4+1UxOpGQqIEWgy
 PMow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710989453; x=1711594253;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D/DqUZhxsP9omlrKabDo//rOz8qxrnQUf6tz2Tp4hSs=;
 b=iO348qBlx1fJCS0YfE+C/LJPcqwi/fgdcFIlnrey8Fu+26NHZJ639t+iZ0o8n4s+N4
 pXKxgsPsXRtLyWAckLt3GwG39TaUYDAUPp5PlUpSpsEcabTB0MBE0HH5znsrgmN7EU2N
 irxeTL+pH66HfcSUy5XpG4k+IXnzmW0wRKxxACfbYdCbc0y8soouV7Q3LQFmIlBY+w3q
 k8ZwJmYPqxTQvEarZlsJTuWUnuyYkxUBesqFfDP9BvZ4eP3v6Qn73+u1RAQKXR9UQ0ut
 rd85nw92tReS6wtNXqXsQ3hc7lXH/kNrAPYX5+ecpJakgNbwC16wK9kWIpaChICATZgU
 vt+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUci3PwePFFcVW8r9ebSdmq/74lkyC0kyP4gJTp+FoCW7a9kJcz4lWD5xk+qfg3vrNb2xaJy76pJqbYcTPLNfYnduACKPg=
X-Gm-Message-State: AOJu0YwTOa9plZzDOJuqLUB/Mhqvxyfj8Xba4iPvMX5xvEPI6TSygfdT
 iajJeF5uxqA6vSQ4/wK0Kp2hNn4A7c7sBCr2EifKxjuZ4NV0ZSyyqdxz+z2NAqs=
X-Google-Smtp-Source: AGHT+IGGdI7tItRZfR+8j1zmq0JyhWkuPvIEpzOWCk9W4JRYxfCwJMHzRnjy/d2v5r9HI0ZhIyNvfQ==
X-Received: by 2002:a17:903:124a:b0:1dd:861b:3666 with SMTP id
 u10-20020a170903124a00b001dd861b3666mr965196plh.55.1710989452982; 
 Wed, 20 Mar 2024 19:50:52 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 im1-20020a170902bb0100b001dcfaab3457sm14734175plb.104.2024.03.20.19.50.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Mar 2024 19:50:52 -0700 (PDT)
Message-ID: <aa8ebf98-6b7f-4a5b-9ef3-4257a1bfdd1a@linaro.org>
Date: Wed, 20 Mar 2024 16:50:49 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] target/loongarch: Fix qemu-system-loongarch64 assert
 failed with the option '-d int'
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, maobibo@loongson.cn
References: <20240321021155.1696910-1-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240321021155.1696910-1-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 3/20/24 16:11, Song Gao wrote:
> qemu-system-loongarch64 assert failed with the option '-d int',
> the helper_idle() raise an exception EXCP_HLT, but the exception name is undefined.
> 
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   target/loongarch/cpu.c | 75 ++++++++++++++++++++++++++----------------
>   1 file changed, 46 insertions(+), 29 deletions(-)
> 
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index f6ffb3aadb..17a923de02 100644
> --- a/target/loongarch/cpu.c
> +++ b/target/loongarch/cpu.c
> @@ -45,33 +45,46 @@ const char * const fregnames[32] = {
>       "f24", "f25", "f26", "f27", "f28", "f29", "f30", "f31",
>   };
>   
> -static const char * const excp_names[] = {
> -    [EXCCODE_INT] = "Interrupt",
> -    [EXCCODE_PIL] = "Page invalid exception for load",
> -    [EXCCODE_PIS] = "Page invalid exception for store",
> -    [EXCCODE_PIF] = "Page invalid exception for fetch",
> -    [EXCCODE_PME] = "Page modified exception",
> -    [EXCCODE_PNR] = "Page Not Readable exception",
> -    [EXCCODE_PNX] = "Page Not Executable exception",
> -    [EXCCODE_PPI] = "Page Privilege error",
> -    [EXCCODE_ADEF] = "Address error for instruction fetch",
> -    [EXCCODE_ADEM] = "Address error for Memory access",
> -    [EXCCODE_SYS] = "Syscall",
> -    [EXCCODE_BRK] = "Break",
> -    [EXCCODE_INE] = "Instruction Non-Existent",
> -    [EXCCODE_IPE] = "Instruction privilege error",
> -    [EXCCODE_FPD] = "Floating Point Disabled",
> -    [EXCCODE_FPE] = "Floating Point Exception",
> -    [EXCCODE_DBP] = "Debug breakpoint",
> -    [EXCCODE_BCE] = "Bound Check Exception",
> -    [EXCCODE_SXD] = "128 bit vector instructions Disable exception",
> -    [EXCCODE_ASXD] = "256 bit vector instructions Disable exception",
> +struct TypeExcp {
> +    int32_t exccode;
> +    const char *name;
> +};
> +
> +static const struct TypeExcp excp_names[] = {
> +    {EXCCODE_INT, "Interrupt"},
> +    {EXCCODE_PIL, "Page invalid exception for load"},
> +    {EXCCODE_PIS, "Page invalid exception for store"},
> +    {EXCCODE_PIF, "Page invalid exception for fetch"},
> +    {EXCCODE_PME, "Page modified exception"},
> +    {EXCCODE_PNR, "Page Not Readable exception"},
> +    {EXCCODE_PNX, "Page Not Executable exception"},
> +    {EXCCODE_PPI, "Page Privilege error"},
> +    {EXCCODE_ADEF, "Address error for instruction fetch"},
> +    {EXCCODE_ADEM, "Address error for Memory access"},
> +    {EXCCODE_SYS, "Syscall"},
> +    {EXCCODE_BRK, "Break"},
> +    {EXCCODE_INE, "Instruction Non-Existent"},
> +    {EXCCODE_IPE, "Instruction privilege error"},
> +    {EXCCODE_FPD, "Floating Point Disabled"},
> +    {EXCCODE_FPE, "Floating Point Exception"},
> +    {EXCCODE_DBP, "Debug breakpoint"},
> +    {EXCCODE_BCE, "Bound Check Exception"},
> +    {EXCCODE_SXD, "128 bit vector instructions Disable exception"},
> +    {EXCCODE_ASXD, "256 bit vector instructions Disable exception"},
>   };
>   
>   const char *loongarch_exception_name(int32_t exception)
>   {
> -    assert(excp_names[exception]);
> -    return excp_names[exception];
> +    int i;
> +    const char *name = "unknown";
> +
> +    for (i = 0; i < ARRAY_SIZE(excp_names); i++) {
> +        if (excp_names[i].exccode == exception) {
> +            name = excp_names[i].name;
> +            break;
> +        }
> +    }
> +    return name;
>   }

I think you should return null for unknown, and then...

>   
>   void G_NORETURN do_raise_exception(CPULoongArchState *env,
> @@ -79,11 +92,17 @@ void G_NORETURN do_raise_exception(CPULoongArchState *env,
>                                      uintptr_t pc)
>   {
>       CPUState *cs = env_cpu(env);
> +    const char *name;
>   
> +    if (exception == EXCP_HLT) {
> +        name = "EXCP_HLT";
> +    } else {
> +        name = loongarch_exception_name(exception);
> +    }
>       qemu_log_mask(CPU_LOG_INT, "%s: %d (%s)\n",
>                     __func__,
>                     exception,
> -                  loongarch_exception_name(exception));
> +                  name);

... use two different printfs, one of which prints the exception number.
Why would you special case HLT here instead of putting it in the table?


r~

