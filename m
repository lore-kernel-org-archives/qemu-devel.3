Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C92AC25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 14:24:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAVpZ-00084j-IN; Fri, 24 May 2024 10:23:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAVpY-00084B-5t
 for qemu-devel@nongnu.org; Fri, 24 May 2024 10:23:36 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAVpW-0001Ch-Kd
 for qemu-devel@nongnu.org; Fri, 24 May 2024 10:23:35 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1f32448e8fbso22842395ad.1
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 07:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716560613; x=1717165413; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Adg6H6IUpy+LEuIStxZ+3oYrT9ga0yhxyO7NdBlTw2k=;
 b=HARo2X2zibec7n0f5WYsyeuQR7iOSuyc846nGj1cdvZJFSfPQHkZZPLZiFNE7hpm4+
 40nFjhir1yfRjVTOVDljSVMFz/e94ecPARGHLLnZT2R7f8sFloYeUMWVV1spSOHgXLqT
 hIeJZGCPzUkr1eIsW6bFBE1rGX9Rcb+yoMOLhdmxG1xefjjj0liAqbAINZO+MiKhXa9a
 OaIYg/nzNvwrXSAuai1k9UaiByUGGcd5+Y4iDY8bUFeiboeGNWY8utOycQyjl5fRtvXE
 DOkp+SiB3u2072tQP1KeaMfLrLEydhSN1Dyt1E87/fUYoVCZdHNedjLGfFnpwIiC7l0B
 PgBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716560613; x=1717165413;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Adg6H6IUpy+LEuIStxZ+3oYrT9ga0yhxyO7NdBlTw2k=;
 b=DmQpdE3IQQjs1Yqi4a/JDBWCw9iU8BVqrs9t7RCGlc9luSinC5axaZ558EKBwAH/IL
 v/kKrcz+UALVicrRZvpG0UgEO5P//PTW/4/PJS6R/lU7e1XOokTToETKHqZnSflXd99n
 p+Wwm8Wo2R5ZrGFM/CShB4nUogXEbuxkW6MHEfiq7hL9IMD41yqeWDZl2JA0wcQqYzzR
 uQMKtlAU+ehPamdouCVOXGjkvWVJDDeXHZTk/k0PzjFnORNjAxQRAvI+ozyjOCbjNjxx
 QBTY0+UokL4BNN0uMg6bHY79lMIuzR1RriLb2hjVK4YnXIwVsQqCQ3AZVuTqZqh/cJQf
 IuCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUx+7mz2N2dP06LDggF+geDofEXesS+iYVAUD6aL5VfQfC+/+phe8J5XJKVsZOpz4NStaaKwCN/Ix6jGkh7ABGItYtJRvA=
X-Gm-Message-State: AOJu0YwPonSMomw63JJrcHBftEqWnJCHD/p+YzwzrslDEDdoYFgMebqT
 Tm262dz1Igo/c1/GBUMbXbEH7bVYGpPK4Wakjf67TgM2ceQ6g+6C6MctO0LYRkFWC7eGLD8CbaM
 1
X-Google-Smtp-Source: AGHT+IELARk1W57KARR1mNRs3eviw7XOGieCvw4SpfL2p+IzFILAU0GapavK04ELirFMnZT+gy/f/w==
X-Received: by 2002:a17:902:e5cb:b0:1f2:f566:8920 with SMTP id
 d9443c01a7336-1f4486bd864mr26315695ad.3.1716560613073; 
 Fri, 24 May 2024 07:23:33 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c971b01sm14428365ad.170.2024.05.24.07.23.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 May 2024 07:23:32 -0700 (PDT)
Message-ID: <a11a973a-bd0f-4f46-ae39-4dc1d7a65615@linaro.org>
Date: Fri, 24 May 2024 07:23:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/16] target/i386: document and group DISAS_* constants
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240524081019.1141359-1-pbonzini@redhat.com>
 <20240524081019.1141359-4-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240524081019.1141359-4-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 5/24/24 01:10, Paolo Bonzini wrote:
> Place DISAS_* constants that update cpu_eip first, and
> the "jump" ones last.  Add comments explaining the differences
> and usage.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 25 ++++++++++++++++++++++---
>   1 file changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
> index 3c7d8d72144..52d758a224b 100644
> --- a/target/i386/tcg/translate.c
> +++ b/target/i386/tcg/translate.c
> @@ -144,9 +144,28 @@ typedef struct DisasContext {
>       TCGOp *prev_insn_end;
>   } DisasContext;
>   
> -#define DISAS_EOB_ONLY         DISAS_TARGET_0
> -#define DISAS_EOB_NEXT         DISAS_TARGET_1
> -#define DISAS_EOB_INHIBIT_IRQ  DISAS_TARGET_2
> +/*
> + * Point EIP to next instruction before ending translation.
> + * For instructions that can change hflags.
> + */
> +#define DISAS_EOB_NEXT         DISAS_TARGET_0
> +
> +/*
> + * Point EIP to next instruction and set HF_INHIBIT_IRQ if not
> + * already set.  For instructions that activate interrupt shadow.
> + */
> +#define DISAS_EOB_INHIBIT_IRQ  DISAS_TARGET_1
> +
> +/*
> + * EIP has already been updated.  For jumps that do not use
> + * lookup_and_goto_ptr()
> + */
> +#define DISAS_EOB_ONLY         DISAS_TARGET_2

Better as "for instructions that must return to the main loop", because pure jumps should 
either use goto_tb (DISAS_NORETURN) or lookup_and_goto_ptr (DISAS_JUMP).

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

