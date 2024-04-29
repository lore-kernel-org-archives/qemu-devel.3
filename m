Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8FD8C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 01:03:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1FQ6-0006kn-Ov; Sun, 28 Apr 2024 21:03:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1FQ5-0006jy-6a
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 21:03:01 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1FQ1-00068V-DE
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 21:02:58 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-5e4f79007ffso2523931a12.2
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 18:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714352571; x=1714957371; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=A6zujvr+iKpUATQxmL199NHKSx+ZW9oQPoXNidoLRJo=;
 b=OJpPypGt8Iw8b+faNYCUGo0IN33joHu5Ptv7Bf3XrCFw/1QilsxlB4pTzKo37pn7kr
 8yGCe6DqtjDda44uD/5x7cuPap8UV019bYLWOv6dB8xDwYdvLdLautPbOYDtvOPJr4TA
 ggiE0EKVKbMxJaLscrTy4grwvh/ZAq9yAahhhI0guP84otZYeH2nTetm3904unDv0IIm
 sIYpobCRxRu5GuiGiZLtr977yyR+xQhtWenEYWxzvSCAfVwhz46eFwzhtQPDh9kTjDyZ
 BdRqKFZH/cgS1KVXlqdxGQHz6qlrcVP7CEyljoGoVU3o+t2uc94jM5XAqTjNVThTInW4
 IZjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714352571; x=1714957371;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=A6zujvr+iKpUATQxmL199NHKSx+ZW9oQPoXNidoLRJo=;
 b=iBQkEVtZ1bZPkFPQeaEfqbt6jNjehr8B2Xk+1Wi96Cnei+o30/wqzRrID/zMe/dZIH
 LUNTpXEUp4D2vXzSt4A+kqRYcxdKDOrc1GeLFyTRhftluD6cQEAG6Fr3GLB5GwZwMsLH
 U8iQHVOX0opY2OIbtBdKkGwwGS7gEqheqVdyHrXouc3z2px8qIVo51a+pm7+w/mZvIgp
 n/gLBoOTSHBWfCynD2EnvPlAxwcvHxJchEYpkBdz5CUiLulEjkgLtOJWGaajYu5ixnh6
 hdHzmH7324O6H29B2+m23aqSvsR1B7xR2O3wHHDGtrikx+4dZFSf3PHSWbVEC+vluBbA
 w1xA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlDaZCaIJIsiFcrWyBmmCKjh9UAhRa+sU0wUPKZN4/ZMx19bTlR7/mwPRomIQfpKXhINjJaVDo42CRZv+ntH+9wRqFBrg=
X-Gm-Message-State: AOJu0YwNEQtJx7Ho8pXgfpCvBCiB17aKXnVj2bLIu1bhcp9EVn1+IkBX
 A5mrYQ0dLXXDWQ2GTfiZscbCU/DDKGUgiQNaKNZ7bbYEnDbaHw2L09v1nomD5t+viZsj90kGf4T
 p
X-Google-Smtp-Source: AGHT+IHRU4CjWaYJ5UIVTjjF0IcBILFItB2MM6v+316Vrlxrkl5cTPCTqu75iIPHuOSB7s11Jw6BfQ==
X-Received: by 2002:a17:90b:3842:b0:2b1:782:8827 with SMTP id
 nl2-20020a17090b384200b002b107828827mr4043603pjb.20.1714352570798; 
 Sun, 28 Apr 2024 18:02:50 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 t15-20020a17090aba8f00b002b15e6ec4efsm1572160pjr.15.2024.04.28.18.02.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Apr 2024 18:02:50 -0700 (PDT)
Message-ID: <ea15a03d-162f-42be-ac71-ba6d561c30e9@linaro.org>
Date: Sun, 28 Apr 2024 18:02:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/24] accel/tcg: Extract tcg_cpu_exit() from cpu_exit()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
References: <20240428221450.26460-1-philmd@linaro.org>
 <20240428221450.26460-6-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240428221450.26460-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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
> Extract tcg_cpu_exit() from the user cpu_exit() implementation.
> In few commits we will re-use it in the system one (via a
> per-accel handler).
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/tcg/internal-common.h | 2 ++
>   accel/tcg/translate-all.c   | 7 +++++++
>   accel/tcg/user-exec.c       | 4 +---
>   3 files changed, 10 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/accel/tcg/internal-common.h b/accel/tcg/internal-common.h
> index ead53cb8a5..df317e7496 100644
> --- a/accel/tcg/internal-common.h
> +++ b/accel/tcg/internal-common.h
> @@ -24,4 +24,6 @@ static inline bool cpu_in_serial_context(CPUState *cs)
>       return !tcg_cflags_has(cs, CF_PARALLEL) || cpu_in_exclusive_context(cs);
>   }
>   
> +void tcg_cpu_exit(CPUState *cpu);
> +
>   #endif
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index fdf6d8ac19..b67adce20e 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -663,3 +663,10 @@ void tcg_flush_jmp_cache(CPUState *cpu)
>           qatomic_set(&jc->array[i].tb, NULL);
>       }
>   }
> +
> +void tcg_cpu_exit(CPUState *cpu)
> +{
> +    /* Ensure cpu_exec will see the exit request after TCG has exited.  */
> +    smp_wmb();
> +    qatomic_set(&cpu->neg.icount_decr.u16.high, -1);
> +}
> diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
> index 404d8a145c..d7e5f00c97 100644
> --- a/accel/tcg/user-exec.c
> +++ b/accel/tcg/user-exec.c
> @@ -49,9 +49,7 @@ void cpu_interrupt(CPUState *cpu, int mask)
>   void cpu_exit(CPUState *cpu)
>   {
>       qatomic_set(&cpu->exit_request, 1);
> -    /* Ensure cpu_exec will see the exit request after TCG has exited.  */
> -    smp_wmb();
> -    qatomic_set(&cpu->neg.icount_decr.u16.high, -1);
> +    tcg_cpu_exit(cpu);
>   }
>   
>   /*


