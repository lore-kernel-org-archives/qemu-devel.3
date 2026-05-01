Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92EABFF885A
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 09:37:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIkIt-0000Tn-6L; Fri, 01 May 2026 05:36:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIkIr-0000Tf-9e
 for qemu-devel@nongnu.org; Fri, 01 May 2026 05:36:57 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIkIp-0003Br-Rz
 for qemu-devel@nongnu.org; Fri, 01 May 2026 05:36:57 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2adbfab4501so7670105ad.2
 for <qemu-devel@nongnu.org>; Fri, 01 May 2026 02:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777628214; x=1778233014; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cz/ingkOX9rnJiAR0BaZNZlFtqqNJnUoEA+uwl1m/i8=;
 b=xul0yJJ4lYK7UXxN4gX8oOcMn2nQ8rnB685VzKC1mTW5Q3YfMtEhXMQe7+G1V6jfjX
 ak5r03B7ZVM4n5nyVXvU9N5r7ZMhDUN9QaaShVQHEnLQ8dJjEn+TL83OjsVdXSs13FdS
 Pk3fBiXxjjGeItdwTNlMw2dNxbqMtXaJQK2LOZiCLD/HpeyP2hQB8xQCFVhVTpeRL5mB
 K2/tylsH/b4+bB/mHYZiNnO0OiggIx8z8NJaRJRpASD4fhDMm1yEeggy/ZG45Iq/6cOg
 gh2PA1XZVb9Axc9i38WFjp5BI9XEgl/y1QJajXDBwuCSfeZMALYU/Qv+xlSGt+gl7GDV
 H3nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777628214; x=1778233014;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cz/ingkOX9rnJiAR0BaZNZlFtqqNJnUoEA+uwl1m/i8=;
 b=KWpAPn/fUCT5KIC1iZ0lrohnn/TcUZFzupl8QSQfgkw3qv6R8dfckf8IWPcKRfhpBr
 4MQ/42SW+NlJtcw9a5cfEDt6/lpn0aqEi3Sa86UWJOrFMpmhTeNTI/1PiyuLr+xGwUOH
 HJF0MfgTi5ZMBJqgMmZRUjyO0oyvEkB5mIPQXLBI5w41UqQEuu/5UTf2gBHbEoGyvX/6
 gOBUjkbAEzzXTDiK0oxQrsKK/koEnvpE6GPybkVrjwjfTbJn4U4dqmuQvrx+jzWHTkIE
 Y4J/NSX9Ficf+C6GgnymAYlcz37cVWN6FLPPgs/UUtPWjti1f7t7VYL+SSaMDrAS9avd
 YztQ==
X-Gm-Message-State: AOJu0YxtxL7XoYM3ToailuO4wwztBZWtsgXjTfYZRXEG4S+FNIjFB9iV
 50dAPNU32BjsaawrO/USe4qnsjxpQ9hmqKRGzoM4U1u+0SDaAiu8LY2khRHLodfIxGN+qh/ypxo
 FwRh5JO4=
X-Gm-Gg: AeBDieuRR8H0vaozXwAFiiTXsLVIB9sBMwQASnnzJ6GnKtR/oWEvkcVr5IFkKmOnA2J
 3i872c01lv6iStPr9WT+Mi9dtZ3/TdtOiG9dViP8MBsr5ObQvwbVF79x4KT1vizLFQQm7cV6zw9
 7IGSzQFsCloUev5QkM/Agf3sRbSjeHGT1ydRQKkffNk2glfjl067JFcUxNVWEtiRNpJkbNTLehl
 mSgj+27miX7L3+9S7RBmsa3+JW3npmADz+lylWuhoVPxE0bEXhFzz8TRU/rBV2I4hqIM8p6wx1p
 N6QAFfour2K5STdl6lkaAlpuxVMbDKdNvQHuL5Gs6hxL268wXKa3RfNjLsBz0suYLhIHGNHnKM6
 7WI+OUhBro2Mkg581OFhMPZQdIn0CKm7vgPhxzaXbEsNq/4X1fJzVvsemk7N4JGcvpIYYdqBV8H
 ZMrDDU31lm8kdSW1f/8j/jBMfsVQ6i3YNa0bU4ZtD9seApiqh/nzV5
X-Received: by 2002:a17:903:1af0:b0:2b0:6d33:e7c0 with SMTP id
 d9443c01a7336-2b9a22f6fcfmr65783085ad.1.1777628213871; 
 Fri, 01 May 2026 02:36:53 -0700 (PDT)
Received: from [192.168.10.140] ([180.233.125.15])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b9caa7e855sm18247605ad.10.2026.05.01.02.36.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 May 2026 02:36:53 -0700 (PDT)
Message-ID: <5e440ba1-c029-4e2e-976a-41d35b4dffed@linaro.org>
Date: Fri, 1 May 2026 19:36:49 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/7] target/arm: enable event stream on WFE instructions
To: qemu-devel@nongnu.org
References: <20260430104434.1482407-1-alex.bennee@linaro.org>
 <20260430104434.1482407-6-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260430104434.1482407-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 4/30/26 20:44, Alex Bennée wrote:
>   void HELPER(wfe)(CPUARMState *env)
>   {
>   #ifdef CONFIG_USER_ONLY
> @@ -495,32 +586,44 @@ void HELPER(wfe)(CPUARMState *env)
>   #else
>       /*
>        * WFE (Wait For Event) is a hint instruction.
> -     * For Cortex-M (M-profile), we implement the strict architectural behavior:
> +     *
>        * 1. Check the Event Register (set by SEV or SEVONPEND).
>        * 2. If set, clear it and continue (consume the event).
>        */
> -    if (arm_feature(env, ARM_FEATURE_M)) {
> -        CPUState *cs = env_cpu(env);
> +    CPUState *cs = env_cpu(env);
> +    ARMCPU *cpu = ARM_CPU(cs);

ARMCPU *cpu = env_archcpu(env);

> +    /* For A-profile we also can be woken by the event stream */
> +    if (arm_feature(env, ARM_FEATURE_AARCH64) && cpu->wfxt_timer) {
> +        int64_t next_event = gt_calc_next_event_stream(env);
> +        if (next_event > 0) {
> +            timer_mod(cpu->wfxt_timer, next_event);
> +        }
>       }

You shouldn't need the feature test, since we'll only instantiate the timer when the 
feature is available.



r~

