Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72565C52D6F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 00:50:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbUrU-0003ef-SY; Tue, 06 Aug 2024 20:49:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sbUrT-0003dj-Aq
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 20:49:07 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sbUrR-00074h-Ku
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 20:49:07 -0400
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3db23a60850so775298b6e.0
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 17:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722991744; x=1723596544; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rzGAyB2zaFQfErI2z42+QKfudRuq534mir41QN6P2Rw=;
 b=qrK662vsKA9D98ggssxYiqco9jCnSF1oKJCimqLGH0H9aVcyxDq4piklUZtQ42UCrv
 kovwybukWyW9Tx3tfsHmtkH7fQQUGR96Frk9yi/iWfdxL/P3P7K0BoOmFsORdmBlftHl
 ntG3SPJlHWxLLyof7rUZgFA90knJXNlrZmYHk7L+852qz/bSfGiQ5LlxB6Llyw+UIrn2
 dJ3jncrgrAz+ZYST3PojYM8EYaawsjE7y43R5EFiyqBn8sgMg+BWLoxEyiVvODSKpmdK
 9jjXW0Z/B5GvR30qLOkTYJ6wIL4ANTI1sbbTYiXIIP+QOvOg/qpSCHHmWc0T2gfLz8YY
 gfJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722991744; x=1723596544;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rzGAyB2zaFQfErI2z42+QKfudRuq534mir41QN6P2Rw=;
 b=FY96Q0XosZvWtqt6aY+ikY6TTwdrfmKY4A+S92g+2Oai6EmD1zd/cpb+rPuXlh7DxR
 hBZFuWLu+XsgXsldmVTw8CfrE3aJ3rNps+clF/F3ePrXGux9ijP0TfSzVzVHXebELrrU
 HEO31xjxrW1JFUyLAOLUjwuToB7K8Ziatf67qqyEUCa7c1/bbFT8ZQoOjFzYNz5i456a
 V0SjMpSjn5lgRpxfCxGDzhAGPLlia4QQOiNF0di13X60Q3fJfXODMxi9x9ofZMNbZmbk
 /yBT+42WJFcKSp5SacLuIgLvUvjY2r9ohFFw7oIe2pQp5mhRRsfhMJ71OvZySPRXGt+F
 O5jA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkRvMdmuScOvIL7AbuCxltvwke0xeSq0B7/4OLAIxRKet5XViWIvdZ74lx3Ekyj/FQdophlzcoYBcIzzB158wLtgQqIXo=
X-Gm-Message-State: AOJu0Yz+8MDaRW/dtnfzPYCMwnf6jUQrUNpoB4gt3WBBwNrSNTYUCAdt
 omN+Y+R7OJ0K9FrjpBJ8eFZ87usUXZDJ2OK8KsxVXGvNv6rHlw6I5+7x0eaHUmw=
X-Google-Smtp-Source: AGHT+IG4l+6QcI1kcoC0vuF1bQhMAPDZ3jSY545i/J9/mztHhYQBZVgLQwODJ9rF2D/I1TTjvVcv/g==
X-Received: by 2002:a05:6870:519:b0:261:6c0:8a2a with SMTP id
 586e51a60fabf-26891d4ba75mr20554755fac.20.1722991744157; 
 Tue, 06 Aug 2024 17:49:04 -0700 (PDT)
Received: from ?IPV6:2403:580a:f89b:0:e01b:92e5:d779:1bc0?
 (2403-580a-f89b-0-e01b-92e5-d779-1bc0.ip6.aussiebb.net.
 [2403:580a:f89b:0:e01b:92e5:d779:1bc0])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7106ec02a4asm7455247b3a.24.2024.08.06.17.48.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Aug 2024 17:49:03 -0700 (PDT)
Message-ID: <9c987cbf-f702-4e1f-88d8-82a149c98007@linaro.org>
Date: Wed, 7 Aug 2024 10:48:56 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/20] accel/tcg: restrict assert on icount_enabled to
 qemu-system
To: Deepak Gupta <debug@rivosinc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: pbonzini@redhat.com, palmer@dabbelt.com, Alistair.Francis@wdc.com,
 laurent@vivier.eu, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com
References: <20240807000652.1417776-1-debug@rivosinc.com>
 <20240807000652.1417776-2-debug@rivosinc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240807000652.1417776-2-debug@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22d.google.com
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

On 8/7/24 10:06, Deepak Gupta wrote:
> commit 16ad9788 [1] restricted icount to qemu-system only. Although
> assert in `cpu_loop_exec_tb` is on `icount_enabled()` which is 0 when
> its qemu-user and debug build starts asserting.
> Move assert for qemu-system.
> 
> [1] - https://lists.gnu.org/archive/html/qemu-riscv/2024-01/msg00608.html
> 
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
>   accel/tcg/cpu-exec.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index 245fd6327d..8cc2a6104f 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -927,9 +927,9 @@ static inline void cpu_loop_exec_tb(CPUState *cpu, TranslationBlock *tb,
>           return;
>       }
>   
> +#ifndef CONFIG_USER_ONLY
>       /* Instruction counter expired.  */
>       assert(icount_enabled());
> -#ifndef CONFIG_USER_ONLY
>       /* Ensure global icount has gone forward */
>       icount_update(cpu);
>       /* Refill decrementer and continue execution.  */

No, this is a real bug.

Just above we handled

   (1) exit for tcg (non-)chaining (!= TB_EXIT_REQUESTED),
   (2) exit for exception/interrupt (cpu_loop_exit_requested).

The only thing that is left is exit for icount expired.
And for that we *must* have icount enabled.

How did you encounter this?


r~

