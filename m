Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDD87C54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 18:54:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdafp-00083C-Kr; Fri, 23 Feb 2024 13:53:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdaST-00016s-3w
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 13:39:41 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdaSQ-0005PR-68
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 13:39:39 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6e457fab0e2so879010b3a.0
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 10:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708713574; x=1709318374; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=i39Kk/8J/M2+6LqMq2m1OohHbPuQZnKxxD342gpAOdg=;
 b=Y2Adqvr+wEaWbMhZXMZirel+Q2pLjczkI7B3NqcnZnIP9YpNpbV8ptXeYe+XqD92bO
 gKGTw5Wc67JaDdij9ysmAx6ekJ93Ncsm/TysbTpPwYGJqgzv1n3UWY2gfl+o/SsZX04N
 /rPYagpGuJxT+viFRHIKfl343QECPC8/uUmSIb4KMRUnhpjEd413wzMzJx0FzxeyH7Xu
 6FxT/RKEQGkrvV+dNCKBOPyx0WQNzreZSuGSigJXIlTS3MTDd5PjXEQFKH7L273zikuw
 xwDJPqqT8gGCM1QVmD9zglkZMdIqzOyBGoI/cEehPd68PZeLGfzIt6uEB4dXKxEvJS93
 ANSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708713574; x=1709318374;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i39Kk/8J/M2+6LqMq2m1OohHbPuQZnKxxD342gpAOdg=;
 b=Xawe7Pn82tnzt+4TsHiOvQchLZrrQdAK4ccT9AlTHz1yr5xq+zgxkxl5MBK/SPDxOn
 ReAjU1zVele0jboPPPxjhdafnojpgHNft2lN6idwbKIzS6hHwmDPExZS+SlrAkaKiEm5
 2XLPFO7T0wRymDGTW6160UtgLu7n92KBEb3fwcZtuRuZei/EVvCLiBcUcwXaRQ0T6Zsf
 H8SJiHy9Y2JHeA7Td9FK0q3E/ZyReCbMeV2ogix5C7m5CgJxuWNCS2IhBjlRapNzm1tG
 Ke8n3iO7S5oEinZwgBfDq3AWP+xvkqf/9/nRX8ID0gxoC9v8JtooPqrlTvu1GIqTk3zJ
 uARA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWekaCpWoiLttG3tBLk3Cax08Ed4MErqhnd+d4C12MdDvrYH+7rFYD32cVvSe6bK6cW3DNZBayvvAqK6pFkERI2H2Lm7dE=
X-Gm-Message-State: AOJu0Yw+4jo+sjKrm5Dl91d/geaxCx9199x9XW/0fu+rx2n2nf7clELb
 EZADgmcbfttDuCdQZS4hg4DNR03MYFjvRAgLK0xjlFyhzehPXuFnEGM9qbcoHCY=
X-Google-Smtp-Source: AGHT+IEF2e/CWF8qfrC6fw6mXT3q/C25Iha/w/IUPl3x3Lkup0QVspSpLRrNclyCiGhhwgjByL2eAw==
X-Received: by 2002:a05:6a00:3cd5:b0:6e4:c592:deaa with SMTP id
 ln21-20020a056a003cd500b006e4c592deaamr637651pfb.11.1708713573979; 
 Fri, 23 Feb 2024 10:39:33 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 b14-20020aa7870e000000b006e3dbec4e7esm11986302pfo.19.2024.02.23.10.39.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Feb 2024 10:39:33 -0800 (PST)
Message-ID: <40f9ea46-9351-42b4-bf70-4713fb476b44@linaro.org>
Date: Fri, 23 Feb 2024 08:39:30 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 02/21] target/arm: Add PSTATE.ALLINT
Content-Language: en-US
To: Jinjie Ruan <ruanjinjie@huawei.com>, peter.maydell@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20240223103221.1142518-1-ruanjinjie@huawei.com>
 <20240223103221.1142518-3-ruanjinjie@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240223103221.1142518-3-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

On 2/23/24 00:32, Jinjie Ruan via wrote:
> The ALLINT bit in PSTATE is used to mask all IRQ or FIQ interrupts.
> 
> Place this in its own field within ENV, as that will
> make it easier to handle ALLINT set/clear.
> 
> With the change to pstate_read/write, exception entry
> and return are automatically handled.
> 
> Signed-off-by: Jinjie Ruan<ruanjinjie@huawei.com>
> ---
> v3:
> - Remove ALLINT dump in aarch64_cpu_dump_state().
> - Update the commit message.
> ---
>   target/arm/cpu.h | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 63f31e0d98..f9646dbbfb 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -224,6 +224,7 @@ typedef struct CPUArchState {
>        *    semantics as for AArch32, as described in the comments on each field)
>        *  nRW (also known as M[4]) is kept, inverted, in env->aarch64
>        *  DAIF (exception masks) are kept in env->daif
> +     *  ALLINT (all IRQ or FIQ interrupts masks) are kept in env->allint
>        *  BTYPE is kept in env->btype
>        *  SM and ZA are kept in env->svcr
>        *  all other bits are stored in their correct places in env->pstate
> @@ -261,6 +262,7 @@ typedef struct CPUArchState {
>       uint32_t btype;  /* BTI branch type.  spsr[11:10].  */
>       uint64_t daif; /* exception masks, in the bits they are in PSTATE */
>       uint64_t svcr; /* PSTATE.{SM,ZA} in the bits they are in SVCR */
> +    uint64_t allint; /* All IRQ or FIQ interrupt mask, in the bit in PSTATE */
>   

I still think you should keep this bit in env->pstate.


r~

