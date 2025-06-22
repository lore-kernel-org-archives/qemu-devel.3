Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9E7BC7115C
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 02:36:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTAYn-0005W8-TO; Sat, 21 Jun 2025 22:35:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTAYk-0005V8-Gj
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 22:35:54 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTAYi-0005uK-Px
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 22:35:54 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-b31d592bbe8so2079746a12.2
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 19:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750559751; x=1751164551; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FueuyjpSWwRxISKss69t5CsjSOmJ1/9sSnRI9jCahm8=;
 b=Woo4DfTSL1AwwlrRy9DAf9u8hSyedzRtAULks+rcaoOw143mFD/Mx6NqZVUeAvFCW6
 j1xor9LZ0GVhlWZwlwA+AfniAbhUutivCbEIWZLrcWU7Z/osuCGZzHEldGBnvNuL6KIa
 kEyNr5t5gbLHMesd/tcQSWlUXgrIZMDp/ycA6XjqMtcisMnInNetH2wEzEeGsvet1xwS
 C70M5Ll+hRan4VQcDedGj+5vrs9vWmTdMMMQQhYYdkkxE8VFkj6QXIYAjbIbknuoJzGR
 qSJIL8YByKoyHyxDiCnufPQ2bg2YndSY0aMaLA5skFsw40fx4lrmLf0CfNOSNxM57XXi
 FFgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750559751; x=1751164551;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FueuyjpSWwRxISKss69t5CsjSOmJ1/9sSnRI9jCahm8=;
 b=pU1xW3SrUqcLNKzUm3hClhMwUr+M6CJIgamijo/y1wEEl074/SsrNYn+IexJb8ET1n
 Oo8lGoHTIsTn8/0yOk2HDfPvlPzVJ3WkjsiR2kdEG3774Z1ncuPmjZGZR7GvTRRIPKPt
 y6T+nSSmT1h+EHMJgvbwQSzKum8e7ow40lp/x07Ttsf8fvYjlFymitHL5dWgZKU1245P
 2Q+V39j7xmup38+8xZ8eEnGhB7RTF45fx9pfeu659CWgc+GnEaZMCY+khC/C/MB41AiU
 VM1hIvyH8bNl6wCObFkm7JT+66K7dIvVdjU72z1+fKZxE6dqWYZTLyAjGLrAUW3/BD4/
 v0vw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6M6a0S6k3BMTio8OmxQLfWlJGElfk6BZG8kSfE8ENFucg2UEqhGfEIs4++UTPHPA5XdJUFupnH3uz@nongnu.org
X-Gm-Message-State: AOJu0YxW38CZTx+KJtIteoBGG73uOQLfAuGcWYQ1bzh0aYXgC/Sj+EOF
 2Srb9fubUlloZzAkxxm96VuyRQ3rDO9gfmLueNAe4/IklsgYqJOaqF5Iyz14VmRug1c=
X-Gm-Gg: ASbGnct8G3q8rrdyGdebtiQ48XoEWMjZ4UuepPfP6bz4sVvs3Se1nLJ+Ns2LojpwFWl
 CVSgMzKbOyXtuoktJh6d3DGe0AMBKsCwzkaObBh3f0j25XWqdci+HPEifdWGJbtQiC9SaaRlW6k
 qc6+WqRA/Uc42mPIktDgTIOGDDvPGHza+R0r3GThAYMLfzhWdCBMGU/LproY5BSnVJM+HPTRYII
 ZDOfkCyTXiWcXe/a+dKPz2LUrAi8QDtn+dZJ5tcEDV0RYvcCJMSaPZ/3YxmPuhiKJqBGvkwQYFi
 9QQRyo31niu4gJm0RXFl8NRhsjltiP5rs31eMI7AJjbsGya4iK6ePeNKEF8S/bK3xi8ChBTnaDz
 XL7+J7ZH3Q6SVnJFkmf2fvjx0Y2sTwno9J/p0pgI=
X-Google-Smtp-Source: AGHT+IHGnc/vQ6iES5IPULIFIMYMEejrL9T+G/3oAISivNsz0I8FK1vuUYhG6tUOurByNwwXB/gdgw==
X-Received: by 2002:a05:6a20:e687:b0:201:4061:bd94 with SMTP id
 adf61e73a8af0-22026f58b82mr12295444637.19.1750559751314; 
 Sat, 21 Jun 2025 19:35:51 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a62636bsm5312107b3a.107.2025.06.21.19.35.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 19:35:50 -0700 (PDT)
Message-ID: <4f844970-0fa9-418d-a0bf-8f96851a10d8@linaro.org>
Date: Sat, 21 Jun 2025 19:35:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH RESEND 10/42] accel/split: Define and allocate
 AccelCPUState
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Mark Burton <mburton@qti.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250620172751.94231-1-philmd@linaro.org>
 <20250620172751.94231-11-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620172751.94231-11-philmd@linaro.org>
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

On 6/20/25 10:27, Philippe Mathieu-Daudé wrote:
> AccelCPUState is where we store per-vCPU accelerator
> related information.
> 
> FIXME: structures might clash so add padding (ok with TCG+HVF)
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/split/split-accel.h     | 7 +++++++
>   accel/split/split-accel-ops.c | 9 ++++++++-
>   2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/accel/split/split-accel.h b/accel/split/split-accel.h
> index 19fb530f207..87a08454ce6 100644
> --- a/accel/split/split-accel.h
> +++ b/accel/split/split-accel.h
> @@ -38,4 +38,11 @@ struct SplitAccelState {
>       char *sw_name;
>   };
>   
> +struct AccelCPUState {
> +    char pad[128];

That's a pretty big fixme.
Is this a problem of name overloading?


r~

> +
> +    AccelState *accel;
> +    bool use_hw;
> +};
> +
>   #endif /* SPLIT_ACCEL_H */
> diff --git a/accel/split/split-accel-ops.c b/accel/split/split-accel-ops.c
> index 294ea79420e..efef0d60fde 100644
> --- a/accel/split/split-accel-ops.c
> +++ b/accel/split/split-accel-ops.c
> @@ -12,10 +12,13 @@
>   #include "exec/cpu-common.h"
>   #include "system/accel-ops.h"
>   #include "system/cpus.h"
> +#include "split-accel.h"
>   
>   static void *split_cpu_thread_routine(void *arg)
>   {
> +    AccelState *as = current_accel();
>       CPUState *cpu = arg;
> +    AccelCPUState *acs;
>       int r;
>   
>       /* TODO: check accel allowed */
> @@ -29,7 +32,10 @@ static void *split_cpu_thread_routine(void *arg)
>       current_cpu = cpu;
>   
>       /* TODO: init_vcpu_thread() */
> -    /* TODO: allocate AccelCPUState */
> +    cpu->accel = g_renew(AccelCPUState, cpu->accel, 1); /* XXX only with current TCG */
> +    acs = cpu->accel;
> +    acs->accel = as;
> +    acs->use_hw = false;
>   
>       /* signal CPU creation */
>       cpu_thread_signal_created(cpu);
> @@ -60,6 +66,7 @@ static void *split_cpu_thread_routine(void *arg)
>                    */
>                   break;
>               case EXCP_ATOMIC:
> +                assert(!acs->use_hw);
>                   bql_unlock();
>                   cpu_exec_step_atomic(cpu);
>                   bql_lock();


