Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4A74C48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 20:20:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcWaT-0002gf-Gu; Tue, 20 Feb 2024 15:19:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rcWaS-0002gX-NE
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 15:19:32 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rcWaL-0007h6-2P
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 15:19:32 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1d751bc0c15so53407715ad.2
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 12:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708460363; x=1709065163; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oRmXAlO5bRvY311P4jcHuhOYEgZgAVZ2zJcpmHk+66k=;
 b=rpTBTXKUNTsw8QKGPJmf51LW5tnn1SEp27kGVxKJe17nmP6G22GGiNXLAHpcvMvpxl
 WFsx0NM4moQIeb8C2e6u9Tvh8DPVUoa/T0E012+IdimXTHV9ssfFklTjDiovdddGhEaX
 nbSvzRRm9cGUwAx4UCxEk7aI6K07ZyHs/AIJIjJFbKIdxRNZZUflBhTR4+SkiEBsUs/n
 o4vdgbtDkNNp/OBLUrZpYVjcaQvzwe2ymMueQang+ehAcvE1rtE4A4KeHtwouHNt9cYv
 NfRrs7rUwDLVY1kYVQdij4gV48dZCeGZDBA6zcLcBXa7e7Mu6pJcdg4B8CY858l5GJPV
 a5Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708460363; x=1709065163;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oRmXAlO5bRvY311P4jcHuhOYEgZgAVZ2zJcpmHk+66k=;
 b=i0NJUI+HANmFk9YhvzIZNb69RhPPl/K7KgO3wh3/swHhY5WalOs4Da1R3tC9msvTfm
 HqAKdzTwKWrHYhP2P5yNibfogyv4O1+6nKSAMj5a87UMrAGG9I+9gfecFBOY4pg0HVVZ
 pvBciRplLbrTK2EO4fXmBhJ2/1vUnKLS1MAbrU8BClGQLMeyo9tXVchlutQCva2d8N19
 6jdC7yt+wIaU3lQI/0M6LCNgojbRDEYAbutb9O7ge/xLJk3qAsOXQvp1gzuBBnTRLFuw
 GSirRea2k3zHvf8LuR8PL5T43JuM9EI6eqRSaF1AbikurFv+BIwNs+DBOJ3SG+3CUK0C
 dAZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBSpn284bwHz1IsRfcvOsOqSqHs8vYN10TKeZnB/KUFQaod4vvyAghJQ8Gk0ZU3JLUo+k4N6f6TPIhIeSB8RoW5O/8OZI=
X-Gm-Message-State: AOJu0Yyai6VY7WgyzC9LTTZ42DX4fw635mSD5MlP7WrbW2hQ809/Cumh
 uA3RLicqSgLguGFxUwCW7yWmaZeUEPOHey+S6HkAEV9H2AZKhCu2OKU5uJT61rQ=
X-Google-Smtp-Source: AGHT+IFF0JtO7s5eeBDAuaCHuNVgVqZ2LCrODosz2D8ArEt/8gNgt0QUUlCiyuEcYpAy178QnLUoWw==
X-Received: by 2002:a17:902:ced2:b0:1db:cf63:b8d2 with SMTP id
 d18-20020a170902ced200b001dbcf63b8d2mr13218834plg.1.1708460363621; 
 Tue, 20 Feb 2024 12:19:23 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 6-20020a170902e9c600b001db45b65e13sm6580544plk.279.2024.02.20.12.19.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Feb 2024 12:19:23 -0800 (PST)
Message-ID: <e9cdebea-555f-4eb4-9a71-305f3ef92c42@linaro.org>
Date: Tue, 20 Feb 2024 10:19:20 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] target/riscv: remove 'over' brconds from vector
 trans
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 max.chou@sifive.com
References: <20240220192607.141880-1-dbarboza@ventanamicro.com>
 <20240220192607.141880-3-dbarboza@ventanamicro.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240220192607.141880-3-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 2/20/24 09:26, Daniel Henrique Barboza wrote:
> Most of the vector translations has this following pattern at the start:
> 
>      TCGLabel *over = gen_new_label();
>      tcg_gen_brcond_tl(TCG_COND_GEU, cpu_vstart, cpu_vl, over);
> 
> And then right at the end:
> 
>       gen_set_label(over);
>       return true;
> 
> This means that if vstart >= vl we'll not set vstart = 0 at the end of
> the insns - this is done inside the helper that is being skipped.  The
> reason why this pattern hasn't been a bigger problem is because the
> conditional vstart >= vl is very rare.
> 
> Checking all the helpers in vector_helper.c we see all of them with a
> pattern like this:
> 
>      for (i = env->vstart; i < vl; i++) {
>          (...)
>      }
>      env->vstart = 0;
> 
> Thus they can handle vstart >= vl case gracefully, with the benefit of
> setting env->vstart = 0 during the process.
> 
> Remove all 'over' conditionals and let the helper set env->vstart = 0
> every time.
> 
> Suggested-by: Richard Henderson<richard.henderson@linaro.org>
> Signed-off-by: Daniel Henrique Barboza<dbarboza@ventanamicro.com>
> ---
>   target/riscv/insn_trans/trans_rvv.c.inc  | 116 -----------------------
>   target/riscv/insn_trans/trans_rvvk.c.inc |  18 ----
>   2 files changed, 134 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

