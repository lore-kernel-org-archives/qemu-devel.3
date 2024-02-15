Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31F72C48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 20:10:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rai47-0001pn-GV; Thu, 15 Feb 2024 15:10:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rai43-0001p5-5L
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 15:10:35 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rai41-0004dW-HQ
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 15:10:34 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1da0cd9c0e5so18292795ad.0
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 12:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708027832; x=1708632632; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sBO7s9OnNhTYNTyXX4miScGwOB0NA0FUCfHjizB/i30=;
 b=vTtQM66CQdLIs2iTAre8wQmo71C1566Ab1pVru3Ove/UpPrtWyOp3fAT5IATMj2B6K
 t9EFgM9O6UD4C6nQsroT9xL/Z1/MUmH0qt5L+57U9x0ywAH0S1P7HobWLnL7ZW/rjn/r
 Bwtosi4TlMbzeIsq8+e/dEEqyLMv1+sFqpeKMf9+tLrBB2oInk7Rh88VMQpNgBR5ylAl
 10A2IjSJ2ttRN5vs1pdeKG+BFo3+9bINBMtKYh3LGCQaERFODxJJOMpgJFcRJJTYLDMX
 G3zEcUAL3omUgLO8S8YovianOGrwvjFkMPDztw0CoyrP2ZpBprr2kqDchWH7ycCeDSVA
 MOsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708027832; x=1708632632;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sBO7s9OnNhTYNTyXX4miScGwOB0NA0FUCfHjizB/i30=;
 b=EKvsnjmMcLeo4wKK9dex+q8bxSZxJ+1ZLyoh5OFsUylg3ZQhEM04srXMb5dxzgSk66
 TdOc8RuVGLvmvpDFDiUDUPgpLj2jBclD3EAtZAJ0NoIGyEUzX+NN6/DqV0giSuR6DhZE
 YvNMO48jotaEC/r5+LBQkPUASXAotk66CMcLKs2GBV1oqIP7Mo65EbARlvHBcH5S5e7G
 PHrH7NGfoDZYAzIpexQjozUYgM4UGNABzx4R1HYl5aiq9eaiTEMFn0L6nlJ//kgDyT69
 vFB7crk6Lgde+WZzTdKj2LOH6bm1MOwiWLRgiAZn5k8s349sxN5SI/pUhTvi3NgHAV6Q
 BknA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTVA8SWoWXTrWGHWaMszggRzEwVGQooRHAo3HIiVPwLjE3+x0Evcerne7lblDGda1+RHM+ZMIaBsbscAsaDwexr8L3734=
X-Gm-Message-State: AOJu0Yx0+vmLn6wQhRAFmPpE6CVv53E+liXH39Oum3UvL+ITUEj5h4VO
 tPufTywkX+7Kv5likmzrgtyK9BB5enUn6ZXsMQoafOudeYB/E2wf+To9YvSm9zt4hXghZIHQKh+
 p
X-Google-Smtp-Source: AGHT+IFglSYn1EbmZqN1zLcRz+D/wLFmtEWjEFLtDnvZcFG2xR+kBtOjPH5D7zI/ZbxlRAiXj0tPXQ==
X-Received: by 2002:a17:902:db04:b0:1d9:ae31:83f1 with SMTP id
 m4-20020a170902db0400b001d9ae3183f1mr3553287plx.18.1708027832108; 
 Thu, 15 Feb 2024 12:10:32 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 d23-20020a170902729700b001d8a93fa5b1sm1634176pll.131.2024.02.15.12.10.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Feb 2024 12:10:31 -0800 (PST)
Message-ID: <4a2b1c91-0f25-4474-ad5c-13d9993a16f5@linaro.org>
Date: Thu, 15 Feb 2024 10:10:29 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/6] accel/tcg: Inline cpu_mmu_lookup function
Content-Language: en-US
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: dbarboza@ventanamicro.com, Riku Voipio <riku.voipio@iki.fi>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20240215192823.729209-1-max.chou@sifive.com>
 <20240215192823.729209-5-max.chou@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240215192823.729209-5-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 2/15/24 09:28, Max Chou wrote:
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---
>   accel/tcg/user-exec.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
> index 68b252cb8e8..c5453810eee 100644
> --- a/accel/tcg/user-exec.c
> +++ b/accel/tcg/user-exec.c
> @@ -942,8 +942,11 @@ void page_reset_target_data(target_ulong start, target_ulong last) { }
>   
>   /* The system-mode versions of these helpers are in cputlb.c.  */
>   
> -static void *cpu_mmu_lookup(CPUState *cpu, vaddr addr,
> -                            MemOp mop, uintptr_t ra, MMUAccessType type)
> +static inline QEMU_ALWAYS_INLINE void *cpu_mmu_lookup(CPUState *cpu,
> +                                                      vaddr addr,
> +                                                      MemOp mop,
> +                                                      uintptr_t ra,
> +                                                      MMUAccessType type)
>   {
>       int a_bits = get_alignment_bits(mop);
>       void *ret;

This is a large function.  Why does it need to be inlined?
For this and the next two patches I require evidence, because I don't believe you are 
attacking the problem correctly.


r~

