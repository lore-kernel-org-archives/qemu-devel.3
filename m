Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C04E1CAC5A5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 00:43:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1a4e-0005Sb-Ls; Wed, 24 Sep 2025 20:43:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1a4c-0005SI-EC
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 20:43:02 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1a4W-0000jl-9z
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 20:43:01 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-46e1bc8ffa1so3782165e9.0
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 17:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758760971; x=1759365771; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5TnokRxIW4+yJtUNuWKk6xbStWlbJttM6DVb8o8afWg=;
 b=zmWAdDw7JPYtuvLpTkaqt3+BeUGb3dgHh+YFFpPiFVcIxKniZk1I0dRuC1qxcrsOsl
 eAYGBBcJrAa8Iw9oBcho9QmTbe/UUNGrK4MWgRYFagJRcQ3m8OEkUgXFvghVHHEETeKd
 ivUHvcvvGcnZdcKo7knoZwo9DkicHZY4+dMtyPF3Ple8LoGSr7rF0gpWcFDu0XmWfhv1
 gM7LcNZf8rPtQBNoFLUx9cimkhBYnSoJCxyUtPvOP+/NPe7FO+JqnYq2yHxjzKK+VYLF
 sdkAvjIPyWoFTURmEaCKAerSGGZRvXPwUodb2Gf27uN4yUOZPmRMzAmq1aEjwH/H8ag3
 rejQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758760971; x=1759365771;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5TnokRxIW4+yJtUNuWKk6xbStWlbJttM6DVb8o8afWg=;
 b=cxFzTPIVx6BBWQN8gKYVTdEb1Agdx/845TwAoJlIGzekrAObfYxGVD45Cn3z6cD2fd
 lgrt0lJ/AtH+kLDHYMiq26SWGDJubu6pIYR0stKGU/eErN7pQxgGbBi7O+Fehc4hmeab
 qbtrENBQ0PNiwH7h0Hg99pzL6OmkEYRTtuEPoLwjyL6sdVyHqlCocbanpjbnIep03Y2L
 Cq/hOVOffh21JAG+ULbfFqEct0GSIVQLtJc+qsKvl9unngTJ5Ja+tf7pnddlOzFkRlxS
 HuKuB3uNkDv3RFhMMgDriaX8Th8nGoNT28GZI6ahiKspw1cexmQhW3DR/SjoXJQMbQwm
 q6GQ==
X-Gm-Message-State: AOJu0Yyx3fcEKm4yOjs+z1JzjwQRL0dewVGv5ma7MsXpbOGmreBhoWzu
 ed5J2x1l2i5n9I0ocEJzsFHHktfJsw6V5WTTUiVAMYF1X/sZuuVgttk5UaMSzC2agWuG2bL7l7I
 NcKSTYJXKZg==
X-Gm-Gg: ASbGncv7q8IZ5HYtpxH4hxE+Wgtlq2J9Qtj7xKwZmBrVwVeJ56LHJzo1bC6ekHvApsN
 TOW9Wzg9no5oU3ovHvUKCOYO723yKhZYJmevkFnKluE6HV1crk39humDbkRtVZckMhJQioXCfmG
 O9yXfYflX1ZEmjkbKXF1uYHNUjoRsufuuNIbPb153plhb0mM9KTMyU/gja44lJlqtCCOUcm6NVk
 SDi/7il93LfOZechhzQq1Vn9WBgKUQjhr83fmPhz2Dp2EwIgVN4KV6My257tb7WaY2MQMctcGih
 iRUMW/ctF8+b/H7R5qAHPXiPf0GXclIR87u5xTZq8A43/drjs4buJi6WteurhJx+hnpKmHHbA3R
 ELuqzvycdpN+Wjv2EjXRMuGqBLIUkuIeFo6dl/Ecb2YWxjkjuCI3MtAub/9XBaqu4V98VhIXTxE
 dH
X-Google-Smtp-Source: AGHT+IEaCDeB+jk0FtwcSkmhYq/IPQPpAEMcGDSuf1wzPJryGz/sLsHwnJcz6DqyZfSEbPTq4XXnfw==
X-Received: by 2002:a05:6000:2585:b0:404:ac77:6598 with SMTP id
 ffacd0b85a97d-40e429c9c4dmr1483425f8f.11.1758760971469; 
 Wed, 24 Sep 2025 17:42:51 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e33bede39sm9420745e9.18.2025.09.24.17.42.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Sep 2025 17:42:50 -0700 (PDT)
Message-ID: <87d90a88-5e8b-47be-b090-815b811f254d@linaro.org>
Date: Thu, 25 Sep 2025 02:42:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/alpha: Replace VMSTATE_UINTTL() -> VMSTATE_UINT64()
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250925003628.58392-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250925003628.58392-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 25/9/25 02:36, Philippe Mathieu-Daudé wrote:
> All these CPUAlphaState fields are of uint64_t type (except
> the @fir[] array which uses float64, expanded to the same
> type definition). Use the appropriate VMSTATE_UINT64() macro.
> 
> There is no functional change (the migration stream is not
> modified), because the Alpha target is only built as 64-bit:

"targets are"

> 
>    $ git grep TARGET_LONG_BITS configs/targets/alpha*
>    configs/targets/alpha-linux-user.mak:4:TARGET_LONG_BITS=64
>    configs/targets/alpha-softmmu.mak:2:TARGET_LONG_BITS=64
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/alpha/machine.c | 34 +++++++++++++++++-----------------
>   1 file changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/target/alpha/machine.c b/target/alpha/machine.c
> index 5f302b166da..6828b123ca1 100644
> --- a/target/alpha/machine.c
> +++ b/target/alpha/machine.c
> @@ -25,8 +25,8 @@ static const VMStateInfo vmstate_fpcr = {
>   };
>   
>   static const VMStateField vmstate_env_fields[] = {
> -    VMSTATE_UINTTL_ARRAY(ir, CPUAlphaState, 31),
> -    VMSTATE_UINTTL_ARRAY(fir, CPUAlphaState, 31),
> +    VMSTATE_UINT64_ARRAY(ir, CPUAlphaState, 31),
> +    VMSTATE_UINT64_ARRAY(fir, CPUAlphaState, 31),
>       /* Save the architecture value of the fpcr, not the internally
>          expanded version.  Since this architecture value does not
>          exist in memory to be stored, this requires a but of hoop
> @@ -41,27 +41,27 @@ static const VMStateField vmstate_env_fields[] = {
>           .flags = VMS_SINGLE,
>           .offset = 0
>       },
> -    VMSTATE_UINTTL(pc, CPUAlphaState),
> -    VMSTATE_UINTTL(unique, CPUAlphaState),
> -    VMSTATE_UINTTL(lock_addr, CPUAlphaState),
> -    VMSTATE_UINTTL(lock_value, CPUAlphaState),
> +    VMSTATE_UINT64(pc, CPUAlphaState),
> +    VMSTATE_UINT64(unique, CPUAlphaState),
> +    VMSTATE_UINT64(lock_addr, CPUAlphaState),
> +    VMSTATE_UINT64(lock_value, CPUAlphaState),
>   
>       VMSTATE_UINT32(flags, CPUAlphaState),
>       VMSTATE_UINT32(pcc_ofs, CPUAlphaState),
>   
> -    VMSTATE_UINTTL(trap_arg0, CPUAlphaState),
> -    VMSTATE_UINTTL(trap_arg1, CPUAlphaState),
> -    VMSTATE_UINTTL(trap_arg2, CPUAlphaState),
> +    VMSTATE_UINT64(trap_arg0, CPUAlphaState),
> +    VMSTATE_UINT64(trap_arg1, CPUAlphaState),
> +    VMSTATE_UINT64(trap_arg2, CPUAlphaState),
>   
> -    VMSTATE_UINTTL(exc_addr, CPUAlphaState),
> -    VMSTATE_UINTTL(palbr, CPUAlphaState),
> -    VMSTATE_UINTTL(ptbr, CPUAlphaState),
> -    VMSTATE_UINTTL(vptptr, CPUAlphaState),
> -    VMSTATE_UINTTL(sysval, CPUAlphaState),
> -    VMSTATE_UINTTL(usp, CPUAlphaState),
> +    VMSTATE_UINT64(exc_addr, CPUAlphaState),
> +    VMSTATE_UINT64(palbr, CPUAlphaState),
> +    VMSTATE_UINT64(ptbr, CPUAlphaState),
> +    VMSTATE_UINT64(vptptr, CPUAlphaState),
> +    VMSTATE_UINT64(sysval, CPUAlphaState),
> +    VMSTATE_UINT64(usp, CPUAlphaState),
>   
> -    VMSTATE_UINTTL_ARRAY(shadow, CPUAlphaState, 8),
> -    VMSTATE_UINTTL_ARRAY(scratch, CPUAlphaState, 24),
> +    VMSTATE_UINT64_ARRAY(shadow, CPUAlphaState, 8),
> +    VMSTATE_UINT64_ARRAY(scratch, CPUAlphaState, 24),
>   
>       VMSTATE_END_OF_LIST()
>   };


