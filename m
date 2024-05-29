Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94273C25B7E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 06:39:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCCy5-0007s0-IH; Wed, 29 May 2024 02:39:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCCy4-0007rq-4Q
 for qemu-devel@nongnu.org; Wed, 29 May 2024 02:39:24 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCCxu-000795-0c
 for qemu-devel@nongnu.org; Wed, 29 May 2024 02:39:22 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-355080e6ff9so1606067f8f.2
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 23:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716964752; x=1717569552; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=84Qm+QnIgd5WtFui+LSl0NRyOUMvXlkghoCddpEQ+lc=;
 b=iYWG3g63H6pUMvsTTgtKlIrFtntBRSWsX7Q3Iuk1jofl9+NyqY3mlg6QKY/e9vuTox
 7WMqjp2I+M0thszHc+skcCqUC1/OWBE/A+j6J11R9RdAousKA5DgVTahT0KNAxD4G17t
 iOMC7gXHPahJRdU6n9tnAKrxWK8mxxGzrJQfbVMHPeEr7CAvDn4PkZBIOLZL1I9+XhcC
 REu2ylSXnsOJnwfgn+n9+mC41MQ+HvAiXyxveJTXg39un2K7OTQAQovwN/ne/v1Er3pa
 Fci1CptANkAJXqXnaNEWOzlfHtJcdURic2S3UzMi8XUdYoxV9RSSzHSZwXFoAc5VAs0C
 czVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716964752; x=1717569552;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=84Qm+QnIgd5WtFui+LSl0NRyOUMvXlkghoCddpEQ+lc=;
 b=vR7/3ReicoQScs/eSdGPYik5E1ie5n5al87uIdzHEB5Q7oyQyKwaSaJQ6lh2BGIajD
 /aeIXgcSVRjIaIzEIF2kRQUGcXdcb1F5VGQOkYh6tU6lmGNtNIgg4uy+kJQA1y4iZg21
 vCWFXn4n7k/hW+Z2UPduy++cVU4buPmR2fz7ik4K4h6spDfxQSxkBxvWX820omrA/O5E
 nOTdPWmVHUNw+VpVmlPRotgtJ/gVatt9VXTXd/RO8PEPiX0meG9fGRg2Zf2W0ESFafL6
 qDGk6qRXSu1iWY1o4H9fUc98UZZBk8qWI1zwe4Gr3OtbLvn2HTWPN0UUjcbFyfed/GGW
 Jj3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYCdDtrlWVfQmBzOFohydesH8mRqhnEoqowYAl68AVD3Zee3MKx92lHG0gAun0oYOfQq9a6bIti8Pq1pyzscstmExGpvA=
X-Gm-Message-State: AOJu0YySU0nXJ0mpIH2v75d/N7pBZ86c9zJoupgi7Mr6TOWaJE0RvQC0
 RDlA3ebuT83wpJezqig8E0S+EFqYGjp2MxIV9kpZX8IYWbVy17YZxMtvgcPgTQU=
X-Google-Smtp-Source: AGHT+IFyB2xnGhK0rMmFylZdljQJDC9/fh8yYV4lDtF5uGA2FumUw+UO/bEt8Mpx9RQLOwxUSSoUJQ==
X-Received: by 2002:adf:e589:0:b0:34d:b40e:79cd with SMTP id
 ffacd0b85a97d-3552fdc0aa5mr10089144f8f.42.1716964752126; 
 Tue, 28 May 2024 23:39:12 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.204.141])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-358c0acf7d5sm8466415f8f.7.2024.05.28.23.39.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 May 2024 23:39:11 -0700 (PDT)
Message-ID: <66800a74-2a89-4c35-acac-30898302b3d0@linaro.org>
Date: Wed, 29 May 2024 08:39:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/18] tcg/loongarch64: Enable v256 with LASX
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: git@xen0n.name, gaosong@loongson.cn
References: <20240527211912.14060-1-richard.henderson@linaro.org>
 <20240527211912.14060-19-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240527211912.14060-19-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 27/5/24 23:19, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/loongarch64/tcg-target.h     |  2 +-
>   tcg/loongarch64/tcg-target.c.inc | 11 ++++++++---
>   2 files changed, 9 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
> index e2b5aad5e3..0b41b807e3 100644
> --- a/tcg/loongarch64/tcg-target.c.inc
> +++ b/tcg/loongarch64/tcg-target.c.inc
> @@ -2484,9 +2484,14 @@ static void tcg_target_init(TCGContext *s)
>       tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_S8);
>       tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_S9);
>   
> -    if (cpuinfo & CPUINFO_LSX) {
> -        tcg_target_available_regs[TCG_TYPE_V64] = ALL_VECTOR_REGS;
> -        tcg_target_available_regs[TCG_TYPE_V128] = ALL_VECTOR_REGS;
> +    if (cpuinfo & (CPUINFO_LSX | CPUINFO_LASX)) {
> +        if (cpuinfo & CPUINFO_LSX) {
> +            tcg_target_available_regs[TCG_TYPE_V64] = ALL_VECTOR_REGS;
> +            tcg_target_available_regs[TCG_TYPE_V128] = ALL_VECTOR_REGS;
> +        }
> +        if (cpuinfo & CPUINFO_LASX) {
> +            tcg_target_available_regs[TCG_TYPE_V256] = ALL_VECTOR_REGS;
> +        }

Out of curiosity, could we have LASX without LSX?

