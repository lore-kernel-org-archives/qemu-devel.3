Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5074C48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 20:12:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rai5a-0002Zp-PB; Thu, 15 Feb 2024 15:12:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rai5Z-0002ZR-LK
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 15:12:09 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rai5Y-0004pU-5J
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 15:12:09 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1dba177c596so2083345ad.0
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 12:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708027927; x=1708632727; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fKfXcfqw4JM+WAdIaGRsAwYOerKOCph/zHVaDnT5h38=;
 b=Q9Tw+EcLi61fecmNt/vtsTyqPevrGw/jQNFw9CrDgiIsnXO3AG4LoeJVSjc/Ew5txo
 jUeYcECMvfq2KBbMQNu/teF4td9zWBPLLmECyQOq8IpaEXpcjoUsBDtvEbQ1bN6ddIFj
 0Gm8+pLn0AETg9Ozuf8ycCyXn7j9CppQ6fk5Rr7fUAxD6XzmjhYrqm5zR5ovUoLVdOhy
 +99ZgP87Y8OX3aTwzLEF+xYLQQI7NEwvgqSrw2GE5gVjCOLndHkms6nop+f9ur4GL/V1
 lYonTQyu/uFZZTe5crrXXq6i/a8fIj+VSylFEipw7fRpg0nnSKqO2P1UeT7KGRDzfbg8
 lgsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708027927; x=1708632727;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fKfXcfqw4JM+WAdIaGRsAwYOerKOCph/zHVaDnT5h38=;
 b=T4Pjpg4BsgEBDg8phszq+KoRuaemccVBovObXrXC/l5mcOHi55gq7g48SVM1xEb3dQ
 JLfrYRQA8jGLJCk7MWoeXh6dzPj8PQvcJ31nOHZe4QtqUTb6rr7FGqvQJ8MoTSqZOIrS
 eqJxyNEJ+x/pPrO6X2+y/pa9S7tqbwU3K8fZOEo/DWXGF2nVMIk574dp187qulPdH38X
 t0Jp8a1nLobjVmhDzl4JmDRt2+3lAnIdRxY+V04ldiWH3tZll1c1hcmUH3WBRm2lo6MG
 eNG1neouSHt2NBx7iNyXGDPuO/XPGCOSHREZL9h0K0KWD47HZNlGprjMRNQ7hwaiju13
 oXlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTsJQCKI70jIoKNeyX7v2rX4FpigXGVYyOEyjoGQ9fyMrDCqtZLGmLExx67EvQZI6rWdlRKELSlXB2JONaYY6SG3mDC4w=
X-Gm-Message-State: AOJu0Yyan7kdQ0xItM1BQR8SCsmdAY4QVTeilxKu+sUFU88gq2e85JkJ
 khPmb3lNvKgQgGL1K7NiQI4/xvDMARi7M9BkvsJuUYgZTzYj3YaMQwRoGuq0P2ckWjgXFMPsHL/
 R
X-Google-Smtp-Source: AGHT+IEV6HbIE9COvHPzu6Ufi52okT4AyG/SxwBex5d/iLY1vwc9pvmzLRFx9J7/uA+2SdMpQ6luDw==
X-Received: by 2002:a17:903:2311:b0:1d9:b58e:709c with SMTP id
 d17-20020a170903231100b001d9b58e709cmr4248627plh.4.1708027926634; 
 Thu, 15 Feb 2024 12:12:06 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 d23-20020a170902729700b001d8a93fa5b1sm1634176pll.131.2024.02.15.12.12.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Feb 2024 12:12:06 -0800 (PST)
Message-ID: <dab5685c-8051-44b6-92c6-a52df9c57eb8@linaro.org>
Date: Thu, 15 Feb 2024 10:12:04 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 5/6] accel/tcg: Inline do_ld1_mmu function
Content-Language: en-US
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: dbarboza@ventanamicro.com, Riku Voipio <riku.voipio@iki.fi>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20240215192823.729209-1-max.chou@sifive.com>
 <20240215192823.729209-6-max.chou@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240215192823.729209-6-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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
>   accel/tcg/user-exec.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
> index c5453810eee..803c271df11 100644
> --- a/accel/tcg/user-exec.c
> +++ b/accel/tcg/user-exec.c
> @@ -963,8 +963,9 @@ static inline QEMU_ALWAYS_INLINE void *cpu_mmu_lookup(CPUState *cpu,
>   
>   #include "ldst_atomicity.c.inc"
>   
> -static uint8_t do_ld1_mmu(CPUState *cpu, vaddr addr, MemOpIdx oi,
> -                          uintptr_t ra, MMUAccessType access_type)
> +static inline QEMU_ALWAYS_INLINE uint8_t do_ld1_mmu(CPUState *cpu, vaddr addr,
> +                                                    MemOpIdx oi, uintptr_t ra,
> +                                                    MMUAccessType access_type)
>   {
>       void *haddr;
>       uint8_t ret;

I expect the small functions that use this to tail-call into this common function.  I do 
not believe that inlining helps.  Same with do_st1_mmu.


r~

