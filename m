Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 921FEFF885A
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 09:54:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIkZD-0003kb-EU; Fri, 01 May 2026 05:53:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIkZ9-0003kJ-0I
 for qemu-devel@nongnu.org; Fri, 01 May 2026 05:53:47 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIkZ7-0000DH-Gk
 for qemu-devel@nongnu.org; Fri, 01 May 2026 05:53:46 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-82fbdd60b64so1328275b3a.3
 for <qemu-devel@nongnu.org>; Fri, 01 May 2026 02:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777629224; x=1778234024; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IeLVOD9N89udI1osFaD3I6tZs+bM+yyTeF6lWU1eM60=;
 b=rX8AZJuXZ1zzjeipCCu9bxLOtIIDPJIx8BaSWQslayzgRG2/uc8x7mQJfMZUUsdVXv
 QM/BQBw79uevgrNkuitHViNRusJmBc0s5b4/kUGGXvfVGbvvTi9N+zVr/ZfEfCtQMIOC
 GjWTxIu9fquIAt6Dld+M/s5KVmU4B0mVB+yytjQuBC/97ClLD+l/nrkgmX+YwZqTYxdX
 sQj82ADELOPkm1M5WZkEHbgtA5/3XqLCnBPcU7HuoqnzswQTuVea6vceRwex/Q8DKDN4
 FJMqNIudYyAnbZgSkVItKijm24QssTnkf5o9Fflq8NhO6S83JItjSNA79pAOPNEKdQes
 GJPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777629224; x=1778234024;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IeLVOD9N89udI1osFaD3I6tZs+bM+yyTeF6lWU1eM60=;
 b=oG7srbyG90jr9Cx2u3ogszuPu0CVc2Lgq29PycHnK09ltCqogrA4Xqkb0XFS6tGv01
 6O8cWZjmEPpSnJLycLCdBMHImiCA16o9szjXXnmAZiLJPMI12wxK79mKzkGorUx7KsDh
 L0tdpQn2OfBrsisPPkGw8vB2of+cl6P33V6yO5xUxqzDmkOkUsSg8kJy4DJFxvlYSXgV
 OgrfZJIr66taUyGjkPoFnYBgjP8y6y4xxRYMmdYHo6GmqnpdRvG1QSp+FvzYtTx40El5
 LjFgMN82bFBy3GSoBjBYjvmPldkbXM9TfA2vxpz7jmu+1hjFzTMOPp81I59/s9p0Od3F
 HsyA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8i7SgnOWu6t6+4RdnTBTC2GRiZSfJ8Xo2lRzpVp3cKj54HiR4l0EZCXuOMHNnjcm6gT6wKBjAcpSaD@nongnu.org
X-Gm-Message-State: AOJu0Yyfookg9JLnWHwGKF4FOO9YjhFZ85NDUt0ziWEodxIsW9C2tFMb
 pGZRoJbOxKOOu1HNGqZuTWMkBEwk7YhxfT8aJinZPh25nr/LMTiVtL7LwDe/Ff3mrqqBl7VJv8w
 ozozyoxY=
X-Gm-Gg: AeBDiesz22fG+LFiDQf1JG3bdbiwv2xNjLzj0P+hwmiKrlNe52saROQkPmuXpEZCVlX
 hna7/jYvM03KucbDymJgPvBrjjFX2ncHimCy3maopE14YKC18jZyQR/MRZs1CYqLe9Am8danvs2
 gRSesTebL2gfrD01wtRWETDUWQboI6xOmzMBf8W2BnVnZJgpjE1aHmeyccO9MrUm2ohlfzpaPMP
 41JtAEXxAN2rrLR/Iv2gQ2ow4zq47REv07SKujY9xtAsDn1lV2hqSax65faQrrRN9JOW2qqQEC6
 o2Cdfh6chFE04TSzdwRowIwnRrOM5GWNYKylL8z5PvivOxzbOC6aym/03/vluBua1E8+cjlBYSk
 eWGOePa6XS3kwKbfStZW78FoML9Au1uomShy2WMZmn5C34QDpriAUIA3zt+5wVQWryqw8tEVLmH
 N0yMxFcrEvLjHhdOXwpF7z/P/cV0Ni4P7IRO9ruCU+SnUuw+17FTSI4+ggZKAyX3M=
X-Received: by 2002:a05:6a00:2e9b:b0:82f:4628:4186 with SMTP id
 d2e1a72fcca58-8351a5bc618mr2691369b3a.42.1777629223541; 
 Fri, 01 May 2026 02:53:43 -0700 (PDT)
Received: from [192.168.10.140] ([180.233.125.15])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83515ad0183sm2302374b3a.31.2026.05.01.02.53.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 May 2026 02:53:43 -0700 (PDT)
Message-ID: <8bf0ba25-3261-4244-885f-967da949f243@linaro.org>
Date: Fri, 1 May 2026 19:53:38 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/25] hw/i386/vapic: Cope with non-page-aligned return
 from cpu_get_phys_page_debug()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20260430093810.2762539-1-peter.maydell@linaro.org>
 <20260430093810.2762539-2-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260430093810.2762539-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 4/30/26 19:37, Peter Maydell wrote:
> Currently the i386 implementation of get_phys_page_debug() always
> returns an address aligned to a page boundary, and the vapic.c code
> assumes this: it adds back in the page offset after the call.  Change
> this to OR in the page offset, so that it works whether
> cpu_get_phys_page_debug() returns the page address or the exact
> physical address. This will mean the code continues to work when
> we change the semantics to standardize on "return exact
> physical address".
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/i386/vapic.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/i386/vapic.c b/hw/i386/vapic.c
> index 1acb9f91b2..3738031a05 100644
> --- a/hw/i386/vapic.c
> +++ b/hw/i386/vapic.c
> @@ -309,7 +309,7 @@ static int update_rom_mapping(VAPICROMState *s, CPUX86State *env, target_ulong i
>       if (paddr == -1) {
>           return -1;
>       }
> -    paddr += rom_state_vaddr & ~TARGET_PAGE_MASK;
> +    paddr |= rom_state_vaddr & ~TARGET_PAGE_MASK;
>       if (paddr != s->rom_state_paddr) {
>           return -1;
>       }

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

