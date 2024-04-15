Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99822C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2024 16:38:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwPLJ-0004B9-C9; Mon, 15 Apr 2024 12:38:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rwPLG-00047f-FP
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 12:38:04 -0400
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rwPLE-0003Xb-FF
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 12:38:01 -0400
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-5acb90b2a82so569482eaf.0
 for <qemu-devel@nongnu.org>; Mon, 15 Apr 2024 09:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713199078; x=1713803878; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WR0C/bDlj0yZGBR3HjZISTZYjAKrgqB1NvNhAZgHqQo=;
 b=w3xoMlpillAvyWp4hIJxSZ5kx+OUSarp1Q3WRbur29FmRxb/lJncXUmOXLlRJz1JAA
 zR/dzgOKOeZSE8LAOaEWK8x4Y5pzqmIwpdwcjlYmUIeAU9rgkBLu2775jQ5b4fW1if3q
 KcKTFFITLXS3dZ+20sB+7LGC05Y5O2g84MJUnsKCorPmeB386r79RTwreGPJ0/wKnRnh
 O7xRjkinbxSGTQ0kfdEKlexEdN0QlnRxUGkblG2+2fk0EEQcoxYP3TG6IN3WIeto4XNk
 lk5aChe34t6zODUC2cl09hbLp0re46lZcHUldfN7HRycAeyULTOP16jKqcbr0PJZWLRG
 CXgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713199078; x=1713803878;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WR0C/bDlj0yZGBR3HjZISTZYjAKrgqB1NvNhAZgHqQo=;
 b=wGy1zhrWUKuP1CNW2ZO+I313Ky3eNq2KxImnxSwsnRKw2AJx/FVQxaIY7q1VUzWb9Q
 ijxRxr65j9VBvAAWcTTqRhIqbzJveSOOPBdMpk8vmSv4RtEtnWoR0SHZ6nWaFtI2nClg
 7dyPpmdV1EOFP1WqnMfhzygObkKtzU/77owKHj6g7rGbFo5LaK94nyc8bw0BHbklwJQp
 JsttAEnC8bTMUpR8e7jrBFKgEDXA5ZPx17Oq/JXbt0ofvLJwKxP5OEZ+dJ2ztBmTKY7Q
 r+RB2FYOBh1vI2tuk3oePc8QaPgsIAQkW2k2OgSegAX2sNpVKraAv3g6Rm+ADxvzjN86
 xc8Q==
X-Gm-Message-State: AOJu0Yx/LcRhjKQo7lTP1TrV65e20WZQp64iKM7VjbpPvAIonLL4oLHY
 MOnPdhCGTT9SVEIiZT3Os1RwcjFC1UWS25OPBZEmd2Ou8r7rINS/JBdRVWBollQ=
X-Google-Smtp-Source: AGHT+IHgWVvhZzWkiN7bSoQLwXrK6tOUBxwz4XdZXwHMSQbo8VufG5N4lNzHA/psCgfg1imJRtp1Pg==
X-Received: by 2002:a05:6870:9627:b0:22e:e26e:73ad with SMTP id
 d39-20020a056870962700b0022ee26e73admr10914954oaq.58.1713199078695; 
 Mon, 15 Apr 2024 09:37:58 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 v12-20020aa799cc000000b006edcdb08d25sm7600326pfi.91.2024.04.15.09.37.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Apr 2024 09:37:58 -0700 (PDT)
Message-ID: <139c7bdf-a62d-4993-a076-eb46ce742748@linaro.org>
Date: Mon, 15 Apr 2024 09:37:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/sparc: resolve ASI_USERTXT correctly
To: M Bazz <bazz@bazz1.com>
Cc: qemu-devel@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20240411212936.945-1-bazz@bazz1.com>
 <dfa87b87-8685-46ea-ae5d-3735124fc76a@linaro.org>
 <CAMFqb-anRmzo1HP8Gn2y0eD98+ZsG_a54c_fLMaMc=0AGAz7DA@mail.gmail.com>
 <48ec5cfe-e584-4e84-85d8-856bfd46345a@linaro.org>
 <CAMFqb-Y5mRrVk7dmEjt=EWerFu3qKAVjxE74=X6yfrRJJnqF5g@mail.gmail.com>
 <d831adc5-bfd7-482c-9e83-a10da1014b4b@linaro.org>
 <CAMFqb-ZV9FJ3JBZNv9APpkmLWdBm1YsWRJyGkKqyN7F0HbNVZw@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAMFqb-ZV9FJ3JBZNv9APpkmLWdBm1YsWRJyGkKqyN7F0HbNVZw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c29;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc29.google.com
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

On 4/14/24 15:48, M Bazz wrote:
> I noticed that cpu_mmu_index() would have returned MMU_USER_IDX
> if the supervisor bit hadn't happened to be set (not sure if this
> execution path can occur for lda).

No, it cannot.

> Note that this check is gone in your patch.

Correct.  Since 'lda' has already checked that supervisor mode has been enabled, the 
translator may jump directly to the desired result of MMU_KERNEL_IDX.

> If I understand everything you've taught me, then the following patch would
> have also satisfied the permissions issue. Could you confirm this please?
> The essential change is the MMU_USER_IDX in the call to make_memop_idx()
> 
> diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
> index e581bb42ac..be3c03a3b6 100644
> --- a/target/sparc/ldst_helper.c
> +++ b/target/sparc/ldst_helper.c
> @@ -702,6 +702,24 @@ uint64_t helper_ld_asi(CPUSPARCState *env,
> target_ulong addr,
>               break;
>           }
>           break;
> +    case ASI_USERTXT: /* User code access */
> +        oi = make_memop_idx(memop, MMU_USER_IDX);
> +        switch (size) {
> +        case 1:
> +            ret = cpu_ldb_code_mmu(env, addr, oi, GETPC());
> +            break;
> +        case 2:
> +            ret = cpu_ldw_code_mmu(env, addr, oi, GETPC());
> +            break;
> +        default:
> +        case 4:
> +            ret = cpu_ldl_code_mmu(env, addr, oi, GETPC());
> +            break;
> +        case 8:
> +            ret = cpu_ldq_code_mmu(env, addr, oi, GETPC());
> +            break;
> +        }
> +        break;

Correct, that would also work.


r~

