Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94491C25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 17:35:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9TNq-0005Cb-VW; Tue, 21 May 2024 13:34:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s9TNn-0005BD-2g
 for qemu-devel@nongnu.org; Tue, 21 May 2024 13:34:39 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s9TNj-00026g-BJ
 for qemu-devel@nongnu.org; Tue, 21 May 2024 13:34:38 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6f47787a0c3so638776b3a.0
 for <qemu-devel@nongnu.org>; Tue, 21 May 2024 10:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716312873; x=1716917673; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=N9YyYjnfgwBc0TZQVflJLaxqMhi1Onl2FcUdAnCkII4=;
 b=rws4vYuqdOZmmr5ElXGsjvn86e7aQJZlEQXtayuWXu4PK68BK0s67s04R+Ixt4iZUg
 EPvGJLlOR8aHOIyUlDcYCZdItgFhB1L61+nAuW53k4j9fLzalTfCXXnmG03wvDbwjfSQ
 uSLKb8LTfuWqEUnYIItY24hWHwaQ00UKgNZHrpPhboqqMn+ajg/lGzT6/NpmDT/Wn3Au
 yfv+wON7csK6enfvjjXOzji8dvTNvH1iRUODNI8zYXrNB5caasCLLSLs1ZU7OT97Faqm
 TkCos+bUhb3qYiA0kORg/DZwjk+G6HJ5YHvWlHy+AeFzzDoj2Hl4lLSwYeGgEnXslsmI
 v64w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716312873; x=1716917673;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=N9YyYjnfgwBc0TZQVflJLaxqMhi1Onl2FcUdAnCkII4=;
 b=UmHILHR2TMsyYmcLADPT4EIfe71HEtRZNz8TU7eTe4JR/yyrmdkG401ZakHDMocXcF
 iTpxjabovns14sIelUgC9vEkJGLE5wBmwYCbsvh/nyod77rT4/PdPCWPCe7H8SniUPwR
 8SN1/a3sMd80bxFUZZpHAey7l/VmyM93973Rb5x2UrBAVZi5DH/5wFFADqIUBte7iaqF
 UW70dkJMYUfSlRT4jnhuVpKRK4B3MhHgnCoBSzMAG4TlRyhGjNfAKYiblaELSeVkyfDi
 pskfsrz8VVjpXG//tQnJc8rypVrPQsvVIeAc6zbAd0c6l7lG5N/lGL71sTO5DY+cRfCL
 PADQ==
X-Gm-Message-State: AOJu0YzzdzsNZPxMCB9cErz0dzSVaIo9lu+jPFqyjaA1tT4PLQ5uG1Di
 aDDo7suZlaLdVx4CToCTaefgt5DL4WIzfcf94dJ/H4WJLXe9nTukL4U/pi8j09k=
X-Google-Smtp-Source: AGHT+IEELy3/DmNfPJdJ+nwszQDTWI1No/I5/BRNEpMmRdf4UM10T9KTNFD47nCqcwB/Gq0gVMUILA==
X-Received: by 2002:a05:6a00:468b:b0:6f6:7c6a:2c14 with SMTP id
 d2e1a72fcca58-6f67c6a3007mr12527648b3a.4.1716312873562; 
 Tue, 21 May 2024 10:34:33 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f4d2a66c6asm21045970b3a.6.2024.05.21.10.34.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 May 2024 10:34:33 -0700 (PDT)
Message-ID: <f407d5ba-2405-4723-bf86-dacdb7cf9a91@linaro.org>
Date: Tue, 21 May 2024 10:34:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/12] target/ppc: Implement attn instruction on BookS
 64-bit processors
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Glenn Miles <milesg@linux.vnet.ibm.com>, Chinmay Rath <rathc@linux.ibm.com>
References: <20240521013029.30082-1-npiggin@gmail.com>
 <20240521013029.30082-4-npiggin@gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240521013029.30082-4-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 5/20/24 18:30, Nicholas Piggin wrote:
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index c358927211..2532408be0 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -3025,6 +3031,12 @@ static inline int check_pow_nocheck(CPUPPCState *env)
>       return 1;
>   }
>   
> +/* attn enable check                                                         */
> +static inline int check_attn_none(CPUPPCState *env)
> +{
> +    return 0;
> +}

No point in putting this here, as a static inline...

> @@ -2138,6 +2158,7 @@ POWERPC_FAMILY(405)(ObjectClass *oc, void *data)
>       dc->desc = "PowerPC 405";
>       pcc->init_proc = init_proc_405;
>       pcc->check_pow = check_pow_nocheck;
> +    pcc->check_attn = check_attn_none;

... when the only uses force an out-of-line instance.

Alternately,

> +#if defined(TARGET_PPC64) && !defined(CONFIG_USER_ONLY)
> +void helper_attn(CPUPPCState *env)
> +{
> +    /* POWER attn is unprivileged when enabled by HID, otherwise illegal */
> +    if ((*env->check_attn)(env)) {
> +        powerpc_checkstop(env, "host executed attn");

... allow the hook to be null to indicate no attn.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

