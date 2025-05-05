Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E14C3ABB0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 14:42:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBx15-0000C4-LM; Mon, 05 May 2025 10:42:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uBx13-0000Bq-QR
 for qemu-devel@nongnu.org; Mon, 05 May 2025 10:41:57 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uBx11-0004AE-O6
 for qemu-devel@nongnu.org; Mon, 05 May 2025 10:41:57 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5f62d3ed994so2857886a12.2
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 07:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746456114; x=1747060914; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7TLzdzXxgZvnqe3FXObxE+hlbODLuIZJ+qKj68426Hw=;
 b=SW1hM49k2Q9jfceQFLBWlls5t3xUCdhsG204zmNEeEvhLiPlLblE0yF6e/RBmV+Ptg
 /1Q98iQD4rj6yrMkrlVZJE2jiLnNd3sUMZfuYZ1L19L78CNzoBrWXsRBINuGDOpw0aCF
 7R9sKF2RptUDnSJnTVKKKmKpfHqZ1k5SaElmgANNNgoMrX6Xi/O/NEm0ahgQaq1/i0Qa
 9AhkMlPSlJwoBlE8uuSDgGD0sruw62PCe3a8LNoZ43+1D0aJ51P1Ub6ZQuPWJuqVQiug
 VVxbn6WfzBOcJJktgC/p0j9QSh4pVHxB7yc/wnM3IwqSVBvTtQAR/YRpjjVv3JtFjFmN
 nc6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746456114; x=1747060914;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7TLzdzXxgZvnqe3FXObxE+hlbODLuIZJ+qKj68426Hw=;
 b=u6j41rvQZmH0eyWaRQCD38TFGtKLNSBphCahaosIDI673lmqmyukVqJmU72g0xaB33
 z8TRLeu1qxuk6kO0M6woDwtVePZWfsx2X9GBy23z3E8VWW/AGrZoWsZxQFt69U1UwElU
 lpqvdNRv8/kfDyGGwzIDy3PUECQ851h2lTiHhNVjp2bvf5uyS9V53WOXykNEqjIcg82e
 bjoMl1LtbCxkB/7+op/O7crI0Xazn3KW0NHTtaRHvXVx4v3oU0GI9gCedB2FPoXbFJJT
 Y6he0HamwXzfB4niYd89Gul9ARjseKeajBzOD67Dzk3QnSQOQClZWSRuHV44bJMTEhQW
 vQBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfThDXr6X8AwPoxhYr6gWao/aYNGVrjkOfOlHI1zhiqVcW0CFMxa9lT4kRobTX4jnBHuI+XpS1Yq+r@nongnu.org
X-Gm-Message-State: AOJu0Yy/0K+C9SGTH8jdxoHfUwA9Q9P14AsaMpgbA/VjXDWi66/jnfnu
 0giogWoABtA+SZIgcwxXCoyVdm3CFMkMA+eYQi0ZbDJUspglk/OMdzpo64LflB8=
X-Gm-Gg: ASbGncvRGISVxw1gp5Flp0UZP/UrqsuzjMKfkIX/9QqfSUhp4DTgeStdB1PlpCIw/5a
 xJlzVqlaMnyhImyhb9rcvCzdNhnafEvWoLdgn86GLyTm61mEuqGnbcxpJnvZYjfUwugb18NEHK0
 PTA9Pp0HXLRnANUcftnTRxLAqSXBjDwDSFPoD3unXGsJOs6bmT343eK+l6aasYZb87qVr41qyHD
 LQluGelyX5lEwxIpiTuOEZv53m9U9FtgCCzm8boRFepc3b2iUpHxUOEXhduqp56wfCoduOmh9SL
 uXDpC1oTKG+7yZf6QHmkOu82ymipROWNb8m3i67iIq/gSN4it9rlxa6HjDJ/YeV/Q/gtmT6/hur
 hn4uqh2ZKesrLaQ==
X-Google-Smtp-Source: AGHT+IGyMr0zuEMIChkNbFFyF+0P5hhwWg6hQHK/ya4TEM+owgoQzmSfk9AlIHczEZuSfk9ACOpC9g==
X-Received: by 2002:a05:6402:26c5:b0:5f3:4ad5:692b with SMTP id
 4fb4d7f45d1cf-5faa7f3168bmr6885562a12.2.1746456113573; 
 Mon, 05 May 2025 07:41:53 -0700 (PDT)
Received: from [10.194.152.213] (129.21.205.77.rev.sfr.net. [77.205.21.129])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5fa7775cabfsm5688039a12.2.2025.05.05.07.41.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 07:41:53 -0700 (PDT)
Message-ID: <9aebfbbc-ff29-4af7-8afe-8e0d82c62557@linaro.org>
Date: Mon, 5 May 2025 16:41:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/12] target/s390x: Fill in TCGCPUOps.pointer_wrap
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: foss@percivaleng.com, qemu-s390x@nongnu.org
References: <20250504205714.3432096-1-richard.henderson@linaro.org>
 <20250504205714.3432096-11-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250504205714.3432096-11-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52f.google.com
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

On 4/5/25 22:57, Richard Henderson wrote:
> Use the existing wrap_address function.
> 
> Cc: qemu-s390x@nongnu.org
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/s390x/cpu.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> index 9c1158ebcc..f05ce317da 100644
> --- a/target/s390x/cpu.c
> +++ b/target/s390x/cpu.c
> @@ -347,6 +347,14 @@ static TCGTBCPUState s390x_get_tb_cpu_state(CPUState *cs)
>       };
>   }
>   
> +#ifndef CONFIG_USER_ONLY
> +static vaddr s390_pointer_wrap(CPUState *cs, int mmu_idx,
> +                               vaddr result, vaddr base)
> +{
> +    return wrap_address(cpu_env(cs), result);
> +}
> +#endif
> +
>   static const TCGCPUOps s390_tcg_ops = {
>       .mttcg_supported = true,
>       .precise_smc = true,
> @@ -367,6 +375,7 @@ static const TCGCPUOps s390_tcg_ops = {
>       .record_sigbus = s390_cpu_record_sigbus,
>   #else
>       .tlb_fill = s390_cpu_tlb_fill,
> +    .pointer_wrap = s390_pointer_wrap,

As future cleanup, we might now remove the wrap_address() calls
in target/s390x/tcg/crypto_helper.c, and target/s390x/tcg/vec_helper.c,
is that correct?

Also some uses in target/s390x/tcg/mem_helper.c.

Meanwhile for this patch:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


