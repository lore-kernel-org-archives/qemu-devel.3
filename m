Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49D0EC282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 21:03:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tspiM-0006zE-UD; Thu, 13 Mar 2025 17:03:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tspiK-0006w9-KA
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 17:03:36 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tspiH-0006hz-T8
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 17:03:35 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-301493f461eso1108447a91.3
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 14:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741899812; x=1742504612; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZsrWtMscD/ehKx5SGoUIEQ5mzeO1jCYPCQKfymPffrg=;
 b=HWZ7mQimJVmM2winWmM/68GF8snrMByfZRBFrZRSuEKEtUiayuCoqBO17LwqzQDTUt
 E2lI6nKTM8zTSLLzSzhOEpAYQON3lanXAJTMIsehNeFUB9w/G5eUqDlgZglSolzGlbE3
 najugISzWLVmk3mqfiEwYrJhKXwH5wofAULswdag1Pil0IEdPWJ4ipcDTdADDwMx4D7a
 jZUqRmWafzoO/aiP0opvoOdWlNjKr8HdO131qn7kl5HjSOhFeKWXgiNPEfnhMM5jqUAf
 i8iP2wRySvyb+3T2YUiS9FR1MFPyM1fN20DjBpupfw4kGteGsuZeil0upzckFYTjmZiM
 lO0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741899812; x=1742504612;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZsrWtMscD/ehKx5SGoUIEQ5mzeO1jCYPCQKfymPffrg=;
 b=toWC3ZVQeJYPu7LguedBa6R94yzNgxOncGwhy3rj0Ya5884AgxliSsGMFYZ+EVnzeo
 wpE//3LUyQpK/3jA4/DCgX0zACLioNTZVYnJIDiiNLS/Y04CfpOa4NXBjdsFQwyyp6g6
 VPQ+3J9MgnH80LDn3zyfYTnQh84i0McrOlvIzIm9AP5zx6uw5eY6eTt8Gcof6gzDBB1T
 nIqgyCP0GCGN/IDBQmrSuIGYlr0aFzN9KfM75rQGMuu18DPx95zwmS1rEZUKhhSYp149
 LenXYz61UBSX28+0E0R6nGTPvGi+BwJzbDs2GFcmc0MmiX7HXvGREBcrL2714Tvesnhk
 W9ww==
X-Forwarded-Encrypted: i=1;
 AJvYcCVILiDAQHvQnn/M4xVZEb/C0UpcE17fkM7Mx0aFbkr5Jb43ArA9VUJEEaGgopDMcQY2pj4rJ9MsFjzZ@nongnu.org
X-Gm-Message-State: AOJu0YwkVEP7SWQ0IAaZrKanVO/KCBdC4/QM9wfFrOfqbXj1Odv3KHya
 U5ZaowKAjP+lg+rthu+t0Fp1mw0D0pPtdp0eAzXssDDb6d4u6ZcwEb5KtGdoRn4=
X-Gm-Gg: ASbGncsPSipvGx0tAGeO6kVX5c2/odgcGNA0jhXGnskGXZnYXNXWpJnP/korJ8lwp2C
 hxLgpgkI4ed2do/fZQKTh5nJOF9yodXn1u+Xw1vgmLlfZyAfq6N8oYY/fD155m0T00PvCtwVnzz
 1FRA15uu8Fl2iD0tqMIbFvft9JGMXz83TpK0GPnc8BXVCfgoTC4p4FEfyqwyuw/xa9TGWnra3pe
 opBilit+H9zl9NLIOLzgDZlFbj4KQhPYpjwfZOqILlw80zlw3vBB+2IVwci4hl6eY5r0Tc+rii8
 DJ5MXYvI3TAl261Zqo1jVLNh/JihDbxlf5HBIAXRwXLShWzDHt/jZnzvS9Y5CMVaVfhL
X-Google-Smtp-Source: AGHT+IG/eAER5uE8kzjB0xin0Xci9bnE33Lb+15hUZuqT30cLuXNxN3zplWV+vW7UMUAG9ATa3DzDA==
X-Received: by 2002:a17:90b:4ec3:b0:2ee:d7d3:3019 with SMTP id
 98e67ed59e1d1-30151c7a384mr23024a91.12.1741899811732; 
 Thu, 13 Mar 2025 14:03:31 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-737115295a2sm1805159b3a.32.2025.03.13.14.03.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 14:03:31 -0700 (PDT)
Message-ID: <57d0643d-40cc-4712-a651-7a2342f931f8@linaro.org>
Date: Thu, 13 Mar 2025 14:03:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 36/37] target/riscv: Remove ifndef CONFIG_USER_ONLY from
 cpu_cfg.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@linaro.org
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
 <20250313034524.3069690-37-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250313034524.3069690-37-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102a.google.com
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

On 3/12/25 20:45, Richard Henderson wrote:
> While RISCVCPUConfig.satp_mode is unused for user-only,
> this header is used from disas/riscv.h, whose users are
> only built once.  The savings of 4 bytes isn't worth it.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/riscv/cpu_cfg.h | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index 8a843482cc..cfe371b829 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -196,9 +196,7 @@ struct RISCVCPUConfig {
>   
>       bool short_isa_string;
>   
> -#ifndef CONFIG_USER_ONLY
>       RISCVSATPMap satp_mode;
> -#endif
>   };
>   
>   typedef struct RISCVCPUConfig RISCVCPUConfig;

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


