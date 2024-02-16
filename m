Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BC19C48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 13:23:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rayB4-0003kW-Ef; Fri, 16 Feb 2024 08:22:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rayB2-0003jY-Q4
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 08:22:52 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rayAw-0004LA-MG
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 08:22:52 -0500
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-5ce2aada130so1757012a12.1
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 05:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1708089765; x=1708694565; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2ULQ6zGJw6sA295fwNsjNCpIKe/+hkjRIauLMp7hLr8=;
 b=mP+Okxbz94uiIM//qc1U5gPPDfqpOCwKicKp3m6HGo5DEhY7qlNeKn/QUfHmaXKNhH
 dYm6jyvNBEHC6Tj7bXmt8CHveUxP1WB1PEwUdajXT7qHyLEeVqH8JrOJZ1zWZmR3z9UR
 vCX1YaXQvZ/yYlyefzhzKKg/tH1Md3qoqx6GoLYlTtDwaQvwZbZdGp6LW9cqK1bOQB+3
 oycBwH/qTQIQkPCpLGeSV252B4sIwYzfRDw2w+7CggaMfHff3qFO9LGdtJ7jSlL6XUhK
 z8uEU0SJEEJNtw90+FcrBa64+j0jsgIlx5T4oMvHzpigbRsSZjprrGKlIVGcnZuJOA4d
 lO5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708089765; x=1708694565;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2ULQ6zGJw6sA295fwNsjNCpIKe/+hkjRIauLMp7hLr8=;
 b=Bo6/bQBklwwyqAbvr+TyNPwqygRNVAKjYlPsTEQ/bKNhC+Tm6C0+YVgPx1HbXSFX5R
 ckLzEPG48+PFt8vyoV0kDzM/7hsFMvRP7OfvCiBolxU5atV7GnqEX5SF+XexKIQBrfBe
 2m2JIZzIa1KijVloDqnQiLoY/yirlN0ZFKEOSV4+LF/Tr9+wp14JQpR/3qXHRCtqAtwH
 qM5dstFUMLRQTKYCWVqpQMj4fRkV5VtiQyTBTRYe62xGWLNuZVNEDxw0GxFkIgvib8h3
 rtEYqeds9qeDp+Q0WI9evlq+ceHAf0AarfGAnq9IWO5CdhtKieEroW3CGdDKkTJGvB3U
 cueA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLSi+C7ScP/soVsnAJ5xf7qqZ8RnBfEr+/ajv1DBn0jt5cMoqSsODE0s6Z1lwkTJnknHDdICCjZRqrickT/To1+sJ4w4A=
X-Gm-Message-State: AOJu0YzH5ebeQmgncstXfCOgnugnCcvmYZML4Ud2qujlViaHfm9WtCon
 2OL0b3y4oy4yT2V7iTgNCQfeb404h5nWfM/iKFSil7y0/r0gCV5O+sS+qAVOmJY=
X-Google-Smtp-Source: AGHT+IGTmaekq+uwPCu9V0nbDcKQGIbF2Z69wJFj03R1u2ENWQB7BatFKWhpLqDi6lU9zpsnV//z4w==
X-Received: by 2002:a17:90b:2357:b0:299:dd1:d0bf with SMTP id
 ms23-20020a17090b235700b002990dd1d0bfmr4552080pjb.0.1708089764941; 
 Fri, 16 Feb 2024 05:22:44 -0800 (PST)
Received: from [192.168.68.110] ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 t22-20020a17090a1c9600b00298e639d17esm3643324pjt.22.2024.02.16.05.22.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Feb 2024 05:22:44 -0800 (PST)
Message-ID: <d18d1a7e-3374-477e-b69e-d69c796b0d44@ventanamicro.com>
Date: Fri, 16 Feb 2024 10:22:22 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] target/riscv: Set the value of CSR tcontrol when
 trapping to M-mode
Content-Language: en-US
To: Alvin Chang <alvinga@andestech.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com
References: <20240216061332.50229-1-alvinga@andestech.com>
 <20240216061332.50229-4-alvinga@andestech.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240216061332.50229-4-alvinga@andestech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x532.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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



On 2/16/24 03:13, Alvin Chang wrote:
>  From the RISC-V debug specification, it defines the following operations
> for CSR tcontrol when any trap into M-mode is taken:
> 1. tcontrol.MPTE is set to the value of tcontrol.MTE
> 2. tcontrol.MTE is set to 0
> 
> This commit implements the above operations into
> riscv_cpu_do_interrupt().
> 
> Signed-off-by: Alvin Chang <alvinga@andestech.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>


>   target/riscv/cpu_helper.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index d462d95ee1..037ae21062 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -1806,6 +1806,12 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>               riscv_cpu_set_virt_enabled(env, 0);
>           }
>   
> +        /* Trapping to M-mode. Set tcontrol CSR in debug Sdtrig extension. */
> +        s = env->tcontrol;
> +        s = set_field(s, TCONTROL_MPTE, get_field(s, TCONTROL_MTE));
> +        s = set_field(s, TCONTROL_MTE, 0);
> +        env->tcontrol = s;
> +
>           s = env->mstatus;
>           s = set_field(s, MSTATUS_MPIE, get_field(s, MSTATUS_MIE));
>           s = set_field(s, MSTATUS_MPP, env->priv);

