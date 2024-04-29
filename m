Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25792C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 14:59:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1SCm-0000Jm-T2; Mon, 29 Apr 2024 10:42:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1SCl-0000JU-Lc
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 10:42:07 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1SCj-0005nV-Jo
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 10:42:07 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1e5aa82d1f6so36049205ad.0
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 07:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714401724; x=1715006524; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Eb8tODcAL1sz5+enA0kf3zKCnYciW+a9N+12xXiSfKg=;
 b=Fp7a6XhUNXNtsecXyxIIQWaqo31LE/dWB07M46yfEUH4MWnq0U98+P9aSMpoAb7O3H
 rfUEn2qKOR4G08Q5P7PsiLA+EkkPiV3w06+YbgE/sBLghQZ88LTuu0XCitNbQAjbCguE
 +iEPo6XFfdNuE/w6LP5avCrOQB8CCYpa48vQd5fKOVIqCqYMO0Z5t83ZL1bKX4tTpba7
 1SWeYWTO9BVq/LG87Nsup3UmtfN0c52NIOkq3ittP1n3/9AeMk+5GP/ArJ3+Pvz3b9NX
 6PAqpR/mDg9rBTEJCQw7kBkfJ8ijOMPk7igle7DaTvvm2PhV8LFuI50uoparJU1LhFYP
 TZzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714401724; x=1715006524;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Eb8tODcAL1sz5+enA0kf3zKCnYciW+a9N+12xXiSfKg=;
 b=NOo9qmu0cAm2e154xZYj4uLpG3zVvlBX73XYUkDIQYQ7/y7onjUqSs30OvyxJbhygx
 X9fCixM0ev1Ihr9qFBpz+SjhrHmkHhBXZZUooR2W3Cyp4w5NvUjTjUOl4e396/7NW5Gi
 yHPQN3H+FWMQwFAOWeXL6a4ApHfQn+YVQpKBi4lseO1bityXRh4bd5YGj8us/GOvRQYx
 i+0lo9nwQ1o8OSQhIxXNOX4ygwbyi5koKLzvPJz6fgpy13nOotChROaoAEO5xzOaDwZn
 PFRHiF6k1d43+HraGOJAHgyPIkoDZ5wmiS4+GmE91+KFdvrks/hnT0uCG6oikrTxtvRI
 3erg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9j13ft9KDBSaRjv5cUsVerATMoJAwYnPiiq0K3vIuOVgaXfUkzZ0vpi0D5cvswHIUK80CdwmtPiElQrT8U1X31UGpTZQ=
X-Gm-Message-State: AOJu0Ywy2E7TRLWTU4nzpoysk7mIIdwwifPPL5M0Opi/Bd/gBjBUsOOo
 ZzTwKaYI2oLxjjPjHfDSRpyzt/qdDpe6XTn0Lkc8L4EbBfw5gaEM5p0zZYNXesY=
X-Google-Smtp-Source: AGHT+IFfhmpDY990JN3DvR3+PVGGb2FCgCsjq5JcNqaJfstZdhnICZwH+R/AhHV7pKWYZkHhL7xVFQ==
X-Received: by 2002:a17:903:192:b0:1e4:733c:eac8 with SMTP id
 z18-20020a170903019200b001e4733ceac8mr15959485plg.8.1714401723517; 
 Mon, 29 Apr 2024 07:42:03 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 q5-20020a170902a3c500b001e8532292a6sm20815663plb.195.2024.04.29.07.42.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Apr 2024 07:42:03 -0700 (PDT)
Message-ID: <8e0091a1-474f-40a4-acba-ffe4e956f9eb@linaro.org>
Date: Mon, 29 Apr 2024 07:42:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/24] accel/tcg: Move plugin fields to
 CPUNegativeOffsetState
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
References: <20240428221450.26460-1-philmd@linaro.org>
 <20240428221450.26460-15-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240428221450.26460-15-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/core/cpu.h  | 22 ++++++++++------------
>   include/qemu/plugin.h  |  2 +-
>   accel/tcg/plugin-gen.c |  8 +++++---
>   hw/core/cpu-common.c   |  2 +-
>   plugins/core.c         |  8 ++++----
>   5 files changed, 21 insertions(+), 21 deletions(-)
> 
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index beb37342e9..ef8b85b6fe 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -342,9 +342,18 @@ typedef union IcountDecr {
>    * CPUNegativeOffsetState: Elements of CPUState most efficiently accessed
>    *                         from CPUArchState, via small negative offsets.
>    * @can_do_io: True if memory-mapped IO is allowed.
> + * @plugin_mem_cbs: active plugin memory callbacks
> + * @plugin_state: per-CPU plugin state
>    */
>   typedef struct CPUNegativeOffsetState {
>       CPUTLB tlb;
> +#ifdef CONFIG_PLUGIN
> +    /*
> +     * The callback pointer are accessed via TCG (see gen_empty_mem_helper).
> +     */
> +    GArray *plugin_mem_cbs;
> +    CPUPluginState *plugin_state;

While plugin_mem_cbs is accessed by tcg generated code, plugin_state is not.
I would move plugin_state to cpu->accel.


r~

