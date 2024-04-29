Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9444C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 01:05:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1FSV-0007oL-LD; Sun, 28 Apr 2024 21:05:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1FSM-0007nZ-1q
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 21:05:22 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1FSI-0006iv-Do
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 21:05:21 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-5f415fd71f8so3202905a12.3
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 18:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714352715; x=1714957515; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cwbrXi3wcQe12yiwGa3vYi9wVS+vaXJDohW3oZvEoDo=;
 b=CGusJalc60XP/he5k9c7nQMp5j8ejfFJWtnkNwub4i3MPnaK+3QLTB0KgsyzqPoaIY
 2PeELCpYE6S6E2/J0jFlN5BRFvUo9EeFbcfhuLzv/ILQfZQ3ARLa75MYMhmFMexzXG8c
 q46usOdytVQPcqGP70sPhhppg25lZ+q7+L78ou7E+eWnzlGnIoHZd5A3PpKRROpgz5xC
 qS3vsWps0OySNo8dDOzkVlwCOA1vsgv6uESuToO5RGq/m9BUSoEmv2yN0KDFMOhoadZS
 THC0sXgUUKHTR0fQwBcIyj0nU63GQ2RUBVWNpiWuGs6Bb8m4XPOFHbZfjcPbEXphTIsC
 OYaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714352715; x=1714957515;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cwbrXi3wcQe12yiwGa3vYi9wVS+vaXJDohW3oZvEoDo=;
 b=dSjLDdDqv8yQ3gF3xvTAAIB/C/RULj9HPrr+7zd//JFuMTorLnz+sJNta/Q+voVHZG
 KIZZ1HfaZuH9c0M1ql13GLwjBCfJca8G4WP0jUMNVuegYmFYEjkOULP/oFcNsBDO5jxj
 J3UD9KuNUh3aIjnkxJYbbxhVq/NntNjEtvF8IAFqeVY3sFErKxT8UQPcmOhGXDlKNGtx
 1hTRFagdOdhc3tUFXR5/jSXEt2/DDidfF1waxPfHbnIXUFvVQq1xuviN9te7VuvfifBW
 IXemcF0kY52fEPDEZDVpvwoitIhHOLfbYzdwQebLZ9kkWCYbGGNm3cN/F1VKfzIwEKy0
 5Oig==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqk/3LDallI0mc6Z3J0ywgQVzEiFrKAN6GcwOwJLM8CRMYaECYIr5UhDVzuDdqd9B9Asp5+AUTT+A4GettI7IqEYN3zD4=
X-Gm-Message-State: AOJu0Yz7byzJfKDEUhOIhbP1hAZz1LFZstQ+dzpBOqBbwTGwwV6zKmT0
 5bdS2WTiYm0ImOCU4L1DdUIN3ZI0YO3ACqYvpH+Mn0sRT+rHBHsMyRZL0Je9oXU=
X-Google-Smtp-Source: AGHT+IEAaFHS7xIj5seaCxQzgVNob0mtosD2WHg+dWR0Ry/zhs37ilu42K4ZagNVftfnry8zPLzBNg==
X-Received: by 2002:a05:6a20:9189:b0:1a7:186:f976 with SMTP id
 v9-20020a056a20918900b001a70186f976mr10310131pzd.40.1714352715691; 
 Sun, 28 Apr 2024 18:05:15 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 o16-20020a170902d4d000b001eb3ea77ee3sm3527501plg.38.2024.04.28.18.05.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Apr 2024 18:05:15 -0700 (PDT)
Message-ID: <b1db7f61-536e-4696-bdba-6bfd1657a252@linaro.org>
Date: Sun, 28 Apr 2024 18:05:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/24] accel: Introduce AccelOpsClass::exit_vcpu_thread()
 handler
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
References: <20240428221450.26460-1-philmd@linaro.org>
 <20240428221450.26460-7-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240428221450.26460-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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

On 4/28/24 15:14, Philippe Mathieu-Daudé wrote:
> Introduce a per-accelerator handler that can be call
> when a vCPU exits.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/sysemu/accel-ops.h | 1 +
>   system/cpus.c              | 3 +++
>   2 files changed, 4 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/include/sysemu/accel-ops.h b/include/sysemu/accel-ops.h
> index ef91fc28bb..35dfb7e266 100644
> --- a/include/sysemu/accel-ops.h
> +++ b/include/sysemu/accel-ops.h
> @@ -35,6 +35,7 @@ struct AccelOpsClass {
>       void (*create_vcpu_thread)(CPUState *cpu); /* MANDATORY NON-NULL */
>       void (*kick_vcpu_thread)(CPUState *cpu);
>       bool (*cpu_thread_is_idle)(CPUState *cpu);
> +    void (*exit_vcpu_thread)(CPUState *cpu);
>   
>       void (*synchronize_post_reset)(CPUState *cpu);
>       void (*synchronize_post_init)(CPUState *cpu);
> diff --git a/system/cpus.c b/system/cpus.c
> index e0530ad603..d0d585e8b9 100644
> --- a/system/cpus.c
> +++ b/system/cpus.c
> @@ -425,6 +425,9 @@ void cpu_exit(CPUState *cpu)
>       /* Ensure cpu_exec will see the exit request after TCG has exited.  */
>       smp_wmb();
>       qatomic_set(&cpu->neg.icount_decr.u16.high, -1);
> +    if (cpus_accel->exit_vcpu_thread) {
> +        cpus_accel->exit_vcpu_thread(cpu);
> +    }
>   }
>   
>   static void qemu_cpu_stop(CPUState *cpu, bool exit)


