Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 644CFC47258
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jan 2024 16:27:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rU80D-0004Xg-Cj; Sun, 28 Jan 2024 11:27:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rU80A-0004X1-6B
 for qemu-devel@nongnu.org; Sun, 28 Jan 2024 11:27:23 -0500
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rU808-000357-LX
 for qemu-devel@nongnu.org; Sun, 28 Jan 2024 11:27:21 -0500
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2cf59087d50so9525271fa.0
 for <qemu-devel@nongnu.org>; Sun, 28 Jan 2024 08:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706459238; x=1707064038; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CRCShPh4nGq0rQsWoS1RW1DVPa+hIuHEmWI75wZR6cA=;
 b=Nl+e7QJm3J1lXWJYHk56/0k/J6QXxYq7N67z9N3YPefZZ7goDzjonY+ohJirZJd5vZ
 8YUIQqyLk+YwJnSS0LakB0tlYq76ry9eiP43BaNQZe7ZHF915BPvooXRaiYGMOrxtKzj
 BuBvzl4Q3qujRW8rQPtGVZtqNqe/Eozlo2iR82CjVl66qU4pMjDeZlKt+BGbKeeSN40y
 X3GZCWKzzrs4bU3tkJ/ea0de5AwKpqH5peW+l5RXsSvelSnV6QbfoulRQpVF3npNZdiq
 yXxUJT8/l8qgDojhecZF4Ek2XDoUqrNYz4YbM5UjA32KziYd2OhWhKfPES7lsbPT3aJE
 BmlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706459238; x=1707064038;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CRCShPh4nGq0rQsWoS1RW1DVPa+hIuHEmWI75wZR6cA=;
 b=MYKXGU+pAwm1UFOXxQ0ZjLq0LzK/QdAKW2j2J0/OKY7zMHZsAcWINt+pkmkQLLnGRf
 VNjfT4PGzLCaCHhwCv8XG5xm/XikDusElGmr24MeUH+Oscx8daNNIltiCVj0Ngti1Lps
 JGoM3ajovN2XbxxgMwM4cFbS32FQiQAi8D5E2hly+3gm5HPWeLAFYeNowQ1PvJTl70u6
 gltimMsUfj/wVE9BrXcWJA2YKobQ5c4hRS9Qf+FTuepp8LJy118etJrasoT6kJ/ToTA3
 SdF77uU+Vt9KO8CaQvZ6qEDNkLXOUx/GHHaxaMRcVA0OToIaEX4JhQRSPgWnrbAUa7Lf
 F78w==
X-Gm-Message-State: AOJu0YzP5Xrxi4LXA1/TaORJqPbXBpeAP6czG5VEOHFtz0c0Qht6TIqQ
 X3eZlfMIwbNd3wT7ZRuJEV3LTIkasCFn2tmgqpQDL7rs53wq9N+ifM/3ob21ZNo=
X-Google-Smtp-Source: AGHT+IEJGAFkbhDhd8s1GBerR9D3OBxELS+SiGLMhDvbad9QZMQfWz+WoZiYIn0QdXxS1dQOfcWXdg==
X-Received: by 2002:ac2:4c12:0:b0:510:1a2f:cf51 with SMTP id
 t18-20020ac24c12000000b005101a2fcf51mr1402955lfq.7.1706459238426; 
 Sun, 28 Jan 2024 08:27:18 -0800 (PST)
Received: from [192.168.69.100] (sev93-h02-176-184-17-196.dsl.sta.abo.bbox.fr.
 [176.184.17.196]) by smtp.gmail.com with ESMTPSA id
 vv9-20020a170907a68900b00a354a5d2c39sm1706401ejc.31.2024.01.28.08.27.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Jan 2024 08:27:18 -0800 (PST)
Message-ID: <3dda67dd-1f85-4279-b90b-f4798c22b0f6@linaro.org>
Date: Sun, 28 Jan 2024 17:27:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/33] accel/tcg/cpu-exec: Use RCU_READ_LOCK_GUARD
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240128044213.316480-1-richard.henderson@linaro.org>
 <20240128044213.316480-17-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240128044213.316480-17-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x234.google.com
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

On 28/1/24 05:41, Richard Henderson wrote:
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> Replace the manual rcu_read_(un)lock calls in cpu_exec().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Message-Id: <20240124074201.8239-2-philmd@linaro.org>
> [rth: Use RCU_READ_LOCK_GUARD not WITH_RCU_READ_LOCK_GUARD]

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/cpu-exec.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index 40c268bfa1..950dad63cb 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -1050,7 +1050,7 @@ int cpu_exec(CPUState *cpu)
>           return EXCP_HALTED;
>       }
>   
> -    rcu_read_lock();
> +    RCU_READ_LOCK_GUARD();
>       cpu_exec_enter(cpu);
>   
>       /*
> @@ -1064,8 +1064,6 @@ int cpu_exec(CPUState *cpu)
>       ret = cpu_exec_setjmp(cpu, &sc);
>   
>       cpu_exec_exit(cpu);
> -    rcu_read_unlock();
> -
>       return ret;
>   }
>   


