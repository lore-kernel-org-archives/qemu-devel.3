Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8124C46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 10:18:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUlBZ-0004Zu-3W; Tue, 30 Jan 2024 05:17:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUlBT-0004XM-1n
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 05:17:40 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUlBM-0005FE-UB
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 05:17:38 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6de0ba30994so2196792b3a.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 02:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706609851; x=1707214651; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mVKvcAzd5Z/+IZPKvmVbDt0d4d8EcB0Atp0XjO4aScc=;
 b=DIl7EVWHWVaBOzEAcJAhDj2JSm9logkfBYSmwB1H3WKmWlpITP/Fj1FSep+G76JliM
 ZsjMuTm5HVXgZ51rnxsQ9PcAOlu1S5zqegBbVlSmpYCUtwkLwmMhfVWmb28pdhBAzu5v
 /jvozTyKk8h7wodSdQktqgQM6TYgtWqggvicB3ydccpjz+rS4SaRPr+nwQvIzzQPge5E
 3qPwltLO5oIb754HSYZ/VlTPVqEDD+Z5bz2KiV3LeG0akIVywomclNC8xNaLAm9ckx8I
 1CZrpWXbWFhfhbR5GXYHB3uFf85CBlyGB3R2KoBLx5QLqV0dz83aW9a32+Ni1GNpRuhq
 X3Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706609851; x=1707214651;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mVKvcAzd5Z/+IZPKvmVbDt0d4d8EcB0Atp0XjO4aScc=;
 b=oYIbHrJ1cnm39O6sLjFCm+GaJlICWqyPfDM4mTOBNV6vLsZMWdM/LIdjbD+B+wZtpj
 PBhe2M4HPBE0RElIqWfNg2uRkvF6dutg0NouJfOtYDtleX/kwF7T8t//zVWxAlm2lZHa
 5cr/13OeIjZ7XnCNKWhxQo88FzxAWlBgi33x/xg2EjKPwFdOA5vaCd5qKJMxnKqsuoCE
 U/Q6Ji4gM+fQY0RSIuowzqbEk/U70md2vpu0ZX0oAaOotJggSyiVuE3CevWvwKuGAUTC
 CPxkLgRGXcxgexUzhvFEbiAlE4nSlfkg/nocTlD1gVA72inB0oyWeGLirYqGIIw6J2Xs
 q0yA==
X-Gm-Message-State: AOJu0YwpqHe1hc7lEdmifzOubo3DWKI6+BWuBNqeE5yF2Nx8kIEhBdbt
 Ors6HRj1+7VJieafRC/aWXuWy+cQJlhxq4pyGD9WA/bhDqu3ap0OQgGc87yF2xlQC/FTk/qcB64
 uTB8=
X-Google-Smtp-Source: AGHT+IE5yXCz9EhKch77jBpFtyUu1V8YoVkiC3OIfBPP5qi6CM9GAQwQ3z/br7Y6CplenW9qd2/CXg==
X-Received: by 2002:a05:6a00:4f88:b0:6db:cf4c:d836 with SMTP id
 ld8-20020a056a004f8800b006dbcf4cd836mr1438228pfb.4.1706609851140; 
 Tue, 30 Jan 2024 02:17:31 -0800 (PST)
Received: from [192.168.0.103] ([103.210.27.218])
 by smtp.gmail.com with ESMTPSA id
 s24-20020a056a00179800b006d9a6a9992dsm7365515pfg.123.2024.01.30.02.17.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jan 2024 02:17:30 -0800 (PST)
Message-ID: <a8221c8e-e7e3-4a85-a3c9-04d40062f787@linaro.org>
Date: Tue, 30 Jan 2024 20:17:26 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 29/29] user: Prefer fast cpu_env() over slower CPU QOM
 cast macro
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240129164514.73104-1-philmd@linaro.org>
 <20240129164514.73104-30-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240129164514.73104-30-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

On 1/30/24 02:45, Philippe Mathieu-Daudé wrote:
> Mechanical patch produced running the command documented
> in scripts/coccinelle/cpu_env.cocci_template header.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   bsd-user/signal.c   | 3 +--
>   linux-user/signal.c | 6 ++----
>   2 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/bsd-user/signal.c b/bsd-user/signal.c
> index ca31470772..c6f0b1be38 100644
> --- a/bsd-user/signal.c
> +++ b/bsd-user/signal.c
> @@ -463,14 +463,13 @@ static int fatal_signal(int sig)
>   void force_sig_fault(int sig, int code, abi_ulong addr)
>   {
>       CPUState *cpu = thread_cpu;
> -    CPUArchState *env = cpu_env(cpu);
>       target_siginfo_t info = {};
>   
>       info.si_signo = sig;
>       info.si_errno = 0;
>       info.si_code = code;
>       info.si_addr = addr;
> -    queue_signal(env, sig, QEMU_SI_FAULT, &info);
> +    queue_signal(cpu_env(cpu), sig, QEMU_SI_FAULT, &info);

Might as well propagate thread_cpu here, and remove local cpu variable.

> @@ -631,7 +630,7 @@ void force_sig(int sig)
>       info.si_code = TARGET_SI_KERNEL;
>       info._sifields._kill._pid = 0;
>       info._sifields._kill._uid = 0;
> -    queue_signal(env, info.si_signo, QEMU_SI_KILL, &info);
> +    queue_signal(cpu_env(cpu), info.si_signo, QEMU_SI_KILL, &info);

More instances?

Either way,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

