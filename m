Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57708C25B74
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2024 11:06:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s8HsV-00029G-IB; Sat, 18 May 2024 07:05:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s8HsT-000293-Tj
 for qemu-devel@nongnu.org; Sat, 18 May 2024 07:05:25 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s8HsO-0005ps-0Q
 for qemu-devel@nongnu.org; Sat, 18 May 2024 07:05:25 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-51f57713684so3643954e87.1
 for <qemu-devel@nongnu.org>; Sat, 18 May 2024 04:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716030317; x=1716635117; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NG8E2TZilBtVr0R9Ze5SaPWCyVAJvmn7+F7VJlAL9RU=;
 b=m4jOorSy9KlHrdjlA3TnPybDnovYzI4gyQvFMjKKhSDQgWpr6t8SCaK5i5xbhUJDGq
 Rkg7BozFjypA8A5m/o3h8r8Yh5yxd99SBYEtZ9xdadNRAmfiiFz6HG0tgWcM7+leZvK4
 /RhgchvIk6Z73XPuyTTZE1AbDPxK/WL/zWWjDFdnmBfYeGV7togJXIue+4UUqqhfHWqZ
 8BaHvRihrb/8AKM6LDdu1DC7d9Fqo+x/heenltmEDVL/xm9etZ2CutzfAV9k0CXo5gFt
 Ap3WMWq/1U/PFAuVTfbe7soGfVqIhdLTOH92ueakXIUhHqVPYieZmnPOeSwVaSjfOxXQ
 bJhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716030317; x=1716635117;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NG8E2TZilBtVr0R9Ze5SaPWCyVAJvmn7+F7VJlAL9RU=;
 b=N1iXtcedqIflIS0SDZXkxwQdUOtQiYxXUEw7nwoc3YHqWvxx5sA4vPjMN92O06i2rU
 Tq23sAntn6iq0pcJQQQmmDT50gdTbgA/PUUvOWo5olPxAk3wKemyinkiPpmb9A/1AmO0
 oiQ6GYy4ykp2BqZLrfGeoMUifGdqtIcFemBx6fmUCZlIMHusxXD0UdYkOyLhVQim49YA
 v76lOK1nVx71PtNPOsTnVUgOjA/suKrhCm+XJWD8zVg8KnVkd4L0+p/WILlEuFQmV7Xr
 g+FY6lIwaZ9Gn6dS2hSlwOWSrygt7LJw3WCtwN4EyNER/l1VQ6a3ChYfueFbdI8M8m1u
 qvLA==
X-Gm-Message-State: AOJu0YzeVkXguayP+Qqp44ZfNwVKxe7mYzpbQB5tTmnfiNMWr1Blur4I
 0El89m9QBOkkfYmI4lWd1PGDk5/CC6jpsZO6Tl0w9xptS2nXxjHwVAuyYJS6ns0=
X-Google-Smtp-Source: AGHT+IGHKS+vet9uZy6KQkwHenPuBXNupvCW+oNiX9+D6oTFlY5K7BQ+FOUhtaVwUa6kARNYW4dXGQ==
X-Received: by 2002:a05:6512:b9a:b0:51f:4e7b:a770 with SMTP id
 2adb3069b0e04-5220fe7990amr18837615e87.47.1716030317602; 
 Sat, 18 May 2024 04:05:17 -0700 (PDT)
Received: from [10.1.1.126] ([149.14.240.163])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a1781d27bsm1207399166b.21.2024.05.18.04.05.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 May 2024 04:05:17 -0700 (PDT)
Message-ID: <6bedceb6-1f40-4ab5-ac30-ce89f415ee84@linaro.org>
Date: Sat, 18 May 2024 13:05:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/14] target/ppc: Implement attn instruction on BookS
 64-bit processors
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Glenn Miles <milesg@linux.vnet.ibm.com>
References: <20240518093157.407144-1-npiggin@gmail.com>
 <20240518093157.407144-6-npiggin@gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240518093157.407144-6-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x12c.google.com
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

On 5/18/24 11:31, Nicholas Piggin wrote:
> @@ -425,17 +426,17 @@ static void powerpc_set_excp_state(PowerPCCPU *cpu, target_ulong vector,
>       env->reserve_addr = -1;
>   }
>   
> -static void powerpc_mcheck_checkstop(CPUPPCState *env)
> -{
> -    /* KVM guests always have MSR[ME] enabled */
>   #ifdef CONFIG_TCG
> +/*
> + * This stops the machine and logs CPU state without killing QEMU (like
> + * cpu_abort()) because it is often a guest error as opposed to a QEMU error,
> + * so the machine can still be debugged.
> + */
> +static G_NORETURN void powerpc_checkstop(CPUPPCState *env, const char *reason)
> +{
>       CPUState *cs = env_cpu(env);
>       FILE *f;
>   
> -    if (FIELD_EX64(env->msr, MSR, ME)) {
> -        return;
> -    }
> -
>       f = qemu_log_trylock();
>       if (f) {
>           fprintf(f, "Entering checkstop state: "
> @@ -451,6 +452,30 @@ static void powerpc_mcheck_checkstop(CPUPPCState *env)
>        */
>       qemu_system_guest_panicked(NULL);
>       cpu_loop_exit_noexc(cs);
> +}

Looks like you're not using reason.
Missed swapping out in the logging block?


r~

