Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE4EAC0218C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 15:08:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbhm1-0007QP-R5; Sat, 25 Jan 2025 10:08:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbhm0-0007QE-Ap
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 10:08:36 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbhly-0001de-Ok
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 10:08:36 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-216401de828so54386735ad.3
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 07:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737817713; x=1738422513; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=x0lKuKfPENf5kgVJNmfCizy/0aiB6EtS5e8NwvFqoOE=;
 b=U/cKt1imxVaFglEYXACZEj20jIjuHrkUNmpP3VA73/aXxc2MWtQPIuKxIzBC8GvEuq
 dS3mmATmZWiUPr8ZHZJHb+VrPZYTN4EU5v6ZHe4YlQmcLkP4AWdLCkMmSBAIaY7DI7Mv
 Huq3hUUFjUZV3WEA6owjUO203qIP5EJP6JieU5+12kEBbm6B4tFBZp2XInlcmPMg80o9
 8V3atcqCeZ/nIqDRqIMwweVxbKDK1XlDUfoUqKW4Xfl1/xYQ1PeR5mjU/9KwWFBca/Nv
 Io9HUJlII5/lF179zBy9k4hSSquprGNQnUcXFAOyeeFEJf26Mb2AtzMv67ibzBc6gtZA
 Mb0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737817713; x=1738422513;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x0lKuKfPENf5kgVJNmfCizy/0aiB6EtS5e8NwvFqoOE=;
 b=lE7AJm0i8NdU7ciePuCU0g/BCrU9hf7FcNJB3I1uATwMkkI+0tR9rqLVvCOe7gPGaj
 tFPEQCylIcpN+Ejo/TRz/iL9qTaniZCyYDWctjMsBVDAwQUqZn7yNN7SJGpel4aD9zzF
 Edd0IS0vdUwhoCvA71HxYC2+voGrNo1o3uV7UUcRFvFBfOfPAMp+l4DoRv/RwPW9OkMi
 e8spSt1pxqgYtS06+XquTDuieyV9mvbve6hOTe6DP7qkTVVeobNsOPzrFG5NEGRYATUk
 RZpwvlxk0YeL4pCcoAeICHMZVTdKtM4yVpiBMO42QQRD51pLf/QSXGXOxcugtIEmDrhW
 KJiA==
X-Gm-Message-State: AOJu0YzROj0UChTQ/liL/SuZWzRAMMPW4K6GbdsDwU982HF63gEQI+kW
 5t1Uwd9qPE5avB10RRaZBrH0d4cf5pKJ2RnA1jIgM0U86pfLEJIH6oQzs6scwiS2sff8W89+w6a
 u
X-Gm-Gg: ASbGncuOwiSI4QWEP5xNzNXUEBM8QTX9REbalTl6qhcgXfyqP8+21JssmybUeqV083g
 PdiB3IbX8KL0BVBEmR2F7wvPWQvM+cleTxfB+kIliom+dcVA6x8b9zWa265qEGJ15qXOFay55Zz
 AUPdI0Bemn4pr4eH4KNkLK6LsKt89c+CDa7571VL0cwdpceUQUT/bIg89JAaUmDuh5B2zIPRKan
 Z7mod6rwURlHZqUgtVnEQsLxS0nPImUQ9WAXHq9NGjqcU7GF9gyO4km1eefOKHbVICXap1Qahoz
 zy8ktoVM0siqjlovDmkqcw==
X-Google-Smtp-Source: AGHT+IF4fp/RXYcucMRbZlEiJhqV89NFaZEQFCm/4tEinNDz7Fabg0Gs6bvKhm8obLeHfzGuPlkLhA==
X-Received: by 2002:a17:902:ecc5:b0:215:9d58:6f35 with SMTP id
 d9443c01a7336-21c351bd5c7mr604993875ad.1.1737817713194; 
 Sat, 25 Jan 2025 07:08:33 -0800 (PST)
Received: from [192.168.74.94] ([50.200.230.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da414db7fsm32979635ad.176.2025.01.25.07.08.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Jan 2025 07:08:32 -0800 (PST)
Message-ID: <f5a37d14-fbfb-4512-a44f-3cbb07484026@linaro.org>
Date: Sat, 25 Jan 2025 07:08:30 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/76] target/arm: Use uint32_t in
 vfp_exceptbits_from_host()
To: qemu-devel@nongnu.org
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-6-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250124162836.2332150-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 1/24/25 08:27, Peter Maydell wrote:
> In vfp_exceptbits_from_host(), we accumulate the FPSR flags in
> an "int", and our return type is also "int". However, the only
> callsite returns the same information as a uint32_t, and
> more generally we handle FPSR values in the code as uint32_t,
> not int. Bring this function in to line with that convention.
> 
> There is no behaviour change because none of the FPSR bits
> we set in this function are bit 31. The input argument to
> the function remains 'int' because that is the return type
> of the softfloat get_float_exception_flags().
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/vfp_helper.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
> index fcc9e5d382e..afc41420eb1 100644
> --- a/target/arm/vfp_helper.c
> +++ b/target/arm/vfp_helper.c
> @@ -34,9 +34,9 @@
>   #ifdef CONFIG_TCG
>   
>   /* Convert host exception flags to vfp form.  */
> -static inline int vfp_exceptbits_from_host(int host_bits)
> +static inline uint32_t vfp_exceptbits_from_host(int host_bits)
>   {
> -    int target_bits = 0;
> +    uint32_t target_bits = 0;
>   
>       if (host_bits & float_flag_invalid) {
>           target_bits |= FPSR_IOC;

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

