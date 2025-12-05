Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7112D32D9C
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 15:30:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRXl5-0006N1-Bh; Fri, 05 Dec 2025 10:30:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vRXl3-0006MZ-UX
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 10:30:09 -0500
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vRXl2-0006vs-F6
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 10:30:09 -0500
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-450b8afe3e0so1302666b6e.0
 for <qemu-devel@nongnu.org>; Fri, 05 Dec 2025 07:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764948607; x=1765553407; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=h3dQYBDgpGrAxqPaHUP/2xVWRMFarQlHtGlRVV0FIkc=;
 b=NYnzWqEPzfOm3HVreNWdBPW3Kccj+aFbojuV933pxZVUt5QpuOgAiNwua9SsPOGAax
 tY01CLibP1bBA9lVbyWI9Ij1TjiB29q5uJbTHtSBd7pigVrn+iAFcRSP2D25pQ0CCrf7
 pgqFI7wZ3AAx+zHcj0Na3TVKQbeOhngYBlujtStanNYqm9IHwFgK3lAPoUfwaBNb1DHS
 onwWFvPWSrTkBzJjTvNvIXi8YpkMdBa2HPINYea4uooKfbDkw5uN6sgdEvpgWOPM2ou4
 dduiBpmWXgtYFTRNYQLdvSw4mB2FWYFLJfzsHOKoBSSPVdieWJ3MWaOvG3WENu1KxUjI
 h0Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764948607; x=1765553407;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h3dQYBDgpGrAxqPaHUP/2xVWRMFarQlHtGlRVV0FIkc=;
 b=hnTMC9DgMS0oPP5kO7yRAVDCWQkJMzeGCP5fGPU6oldT1/BGaf5waFqYneBWB0wPYW
 0Iy9ZqUoTH5pxkBphCPonD3BIpcGaQcHfwPn4bjmucfuX8upEP/LkQkq55PxAIcbYGk7
 LYmCsiSBwwMO2axaC+hb3GLPk6L1DVd6Hlgjn2HSOOMSgxs5frASOIZXN5xp+6cMnlZO
 EPoNcGr0faO8qNk0swz2roZNesIUHwGjxzgP963kln9TWp+1/DesaaX9eevTUsGYOaSj
 0j08Nd9sHQiFk24QFlW7t1q+E/Zj4rfGB8jiIs+NyG9WqHCjoFqesC4VaD1PtL2APMB6
 RRzw==
X-Gm-Message-State: AOJu0Ywpc6o6ntr9FrxEHbser6zZOzoEuBAhaMerBeTBdhtG85f3LPst
 iOJaOFlJBcl+QzvUfUxwR5lH9FS9NZV8MONhNlNLFKUZH5erRM9gkV5mS8SM7SqYz8jGhonXwzX
 67q8Ndyc=
X-Gm-Gg: ASbGncv/KoUz6bI46KWzUBBJQVZoJL1v6L8kvrY7fWBC3VR02t6osS8wUhDNK8yVNIa
 P+XMqkJIqy4Dr69vd/8W6PKIb9kxfiRvdTw9vOkf/fnPWZvh/pB/G/kqAFu97ChjYIaE9nM34QE
 b6QTO+zoPVArWIoyU+SijSGh8npmRerGthjuNV4qkMMhDJxyVsFsHiz1VFTTolV3VwU4CBIQTSt
 VGpFlbl2LvO61qe8O7iMmMf2hsz5pJZqWC05C5kdmzOsxiPlqS5Am9L6s2jIZNDP1gn+AEwq5xH
 bmfIkWmkf/cU6+6kxhtjj6iH4J57XbvklhEwADDYRkNGjDkHPuZ+GooMhs3NDLXqW2OTYZb39IQ
 CvxHvIx8uLcKjMilmW66QHpyhSkiW06gCJVARP3vGs1FMLH+xD7ZBPUoA9oi0o178sfno7vDzmV
 wo8DlsvoKviyMEwXDNgeKVd+tS3fQGC0qd5CJXmHt+R/OAbBiDa+o2WBZ059rPDWFi
X-Google-Smtp-Source: AGHT+IF/TKh3tdL6NDzJOBHDVchgK45PFpU6x8i0LyKIikqEcrVLyq3kYa5bqFiZ2O/Try1jJz5LhA==
X-Received: by 2002:a05:6808:4fdf:b0:44e:2f1b:e4b0 with SMTP id
 5614622812f47-4536e539ac9mr5697597b6e.51.1764948606452; 
 Fri, 05 Dec 2025 07:30:06 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45380154ea5sm2373093b6e.19.2025.12.05.07.30.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Dec 2025 07:30:06 -0800 (PST)
Message-ID: <59cb24e2-699e-4511-84e5-ad5d3ee90b58@linaro.org>
Date: Fri, 5 Dec 2025 09:30:04 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] target/arm: Allow writes to FNG1, FNG0, A2
To: qemu-devel@nongnu.org
References: <20251204180617.1190660-1-jim.macarthur@linaro.org>
 <20251204180617.1190660-3-jim.macarthur@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251204180617.1190660-3-jim.macarthur@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x230.google.com
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

On 12/4/25 12:04, Jim MacArthur wrote:
> @@ -6121,8 +6131,16 @@ static void tcr2_el2_write(CPUARMState *env, const ARMCPRegInfo *ri,
>       if (cpu_isar_feature(aa64_mec, cpu)) {
>           valid_mask |= TCR2_AMEC0 | TCR2_AMEC1;
>       }
> +    if (cpu_isar_feature(aa64_asid2, cpu)) {
> +        valid_mask |= TCR2_FNG1 | TCR2_FNG0 | TCR2_A2;
> +        require_flush = true;
> +    }
>       value &= valid_mask;
>       raw_write(env, ri, value);
> +
> +    if (require_flush) {
> +        tlb_flush(CPU(cpu));
> +    }

Just because A2 is valid doesn't mean the A2 bit changed.

Compare, for instance, vmsa_ttbr_write, where we notice if the ASID has changed before 
performing the flush.

Note as well that we don't need to flush all tlbs.  In tcr2_el1_write we know that we are 
only affecting the EL1&0 regime (alle1_tlbmask).  In tcr2_el2_write, we know that we are 
only affecting the EL2&0 regime (see the E2H part of vae2_tlbmask).


r~

