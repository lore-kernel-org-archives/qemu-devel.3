Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD4AAC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 12:18:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1PxY-0003Tn-WC; Mon, 29 Apr 2024 08:18:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1PxW-0003TG-Pr
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 08:18:14 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1PxV-00007W-3P
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 08:18:14 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-347c197a464so3276642f8f.2
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 05:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714393091; x=1714997891; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DT0JlThAl9PnlzgThiayQJ0mPR4CYop29qaAFwFr+Zw=;
 b=qzHQFxYR8f24ZxMvRSYQo7nGq+wgUqP1lAEGtFuy2mnTsASAZTLACxUwgoS6N13YxY
 AvLi5YtZaXpQZWeIZccoT2g1iGFEaJA74uIN+SuSqHKaB/1DkT31RnOxiDoA+kcc/6A0
 8Ai0St3h4itp8eK3+zIQKq8CENV0IBDJBlTkXBnVR6PI5+OJRCZCIlr4HT3dh8nDNvIB
 NB3IKOJ8YPYaXe2sWGiVWaJS7WDtE05oxJJHIAor4Rx5AZ4gQFkdzYQajVRz6zP7kJt3
 8S0u2IlA7crZuyXkV0hP4QiCtPSn5yyfDK0n59C7iE7dWjOzR9v22zs1MD9kaWtGpI5u
 s0VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714393091; x=1714997891;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DT0JlThAl9PnlzgThiayQJ0mPR4CYop29qaAFwFr+Zw=;
 b=XtEh/5DRcku3ppg3iE2uXMZaSz4nhPfSCzLoBnKSrr1hXB9/b51rcaazVoHnAl7OkC
 Jn52bk75tzLm7p0/D6/n/ijGbJm9sUrm7rHQFMtOny23TxsoEY/VX8hTsuVOcskqEhaM
 thEuHfWwia4zikRvDxDoSvlUbxJejeLwZ7+kXipjybLSlVup0V05QZGKmASWkdAID9AK
 eGCmPuV34WzsDMCM3TW0Dbiojzfbc2RPAVx5LReJM5Ir+9g5HmcFMqbPbZJXuRDJe2z9
 bdqXWmbkZNC1/8/Y799aVA9Jk/SWDEUXFGhq+PH820qNhwCu8jxStX47/i7wentTgVKT
 QkXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWntQqnsvxGtg3nSJsHJO1pcW2zE6cKtsSthWLn3RU7POO0Erf2r3Sianlcc6SkrP6hKiHAgEOaJ/57Eqn8awPpwQYWfJU=
X-Gm-Message-State: AOJu0YyhJNNfYBcoKLLMZwDeED5x/7g5b20sJ7Yz1X37vfT211wOmkSd
 Ob4LmUYKCpN9O2q4yf26eBQDoeyO8tJjDXVLVYEOrBuKEDcU0rAyhItGISyg3aw0HeN2YGZNwdu
 SAMc=
X-Google-Smtp-Source: AGHT+IFLwMC4IzVZgqvvX5Ur8z6s4eBNQkk9uWizRkIp5CP2sxFze9rpzsrn9w5kCXUwDB9fpUoPlQ==
X-Received: by 2002:adf:dd87:0:b0:34c:6b36:33e5 with SMTP id
 x7-20020adfdd87000000b0034c6b3633e5mr6464780wrl.71.1714393090964; 
 Mon, 29 Apr 2024 05:18:10 -0700 (PDT)
Received: from [192.168.69.100] (bny92-h02-176-184-44-142.dsl.sta.abo.bbox.fr.
 [176.184.44.142]) by smtp.gmail.com with ESMTPSA id
 a3-20020adffb83000000b0034b32e5e9ccsm18893034wrr.64.2024.04.29.05.18.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Apr 2024 05:18:10 -0700 (PDT)
Message-ID: <400f20e7-3c33-4916-897a-0d6b21d572c4@linaro.org>
Date: Mon, 29 Apr 2024 14:18:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/10] util/bufferiszero: Improve scalar variant
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240424225705.929812-1-richard.henderson@linaro.org>
 <20240424225705.929812-7-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240424225705.929812-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 25/4/24 00:57, Richard Henderson wrote:
> Split less-than and greater-than 256 cases.
> Use unaligned accesses for head and tail.
> Avoid using out-of-bounds pointers in loop boundary conditions.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   util/bufferiszero.c | 85 +++++++++++++++++++++++++++------------------
>   1 file changed, 51 insertions(+), 34 deletions(-)
> 
> diff --git a/util/bufferiszero.c b/util/bufferiszero.c
> index 02df82b4ff..c9a7ded016 100644
> --- a/util/bufferiszero.c
> +++ b/util/bufferiszero.c
> @@ -28,40 +28,57 @@
>   
>   static bool (*buffer_is_zero_accel)(const void *, size_t);
>   
> -static bool buffer_is_zero_integer(const void *buf, size_t len)
> +static bool buffer_is_zero_int_lt256(const void *buf, size_t len)
>   {
> -    if (unlikely(len < 8)) {
> -        /* For a very small buffer, simply accumulate all the bytes.  */
> -        const unsigned char *p = buf;
> -        const unsigned char *e = buf + len;
> -        unsigned char t = 0;
> +    uint64_t t;
> +    const uint64_t *p, *e;
>   
> -        do {
> -            t |= *p++;
> -        } while (p < e);
> -
> -        return t == 0;
> -    } else {
> -        /* Otherwise, use the unaligned memory access functions to
> -           handle the beginning and end of the buffer, with a couple
> -           of loops handling the middle aligned section.  */
> -        uint64_t t = ldq_he_p(buf);
> -        const uint64_t *p = (uint64_t *)(((uintptr_t)buf + 8) & -8);
> -        const uint64_t *e = (uint64_t *)(((uintptr_t)buf + len) & -8);
> -
> -        for (; p + 8 <= e; p += 8) {
> -            if (t) {
> -                return false;
> -            }
> -            t = p[0] | p[1] | p[2] | p[3] | p[4] | p[5] | p[6] | p[7];
> -        }
> -        while (p < e) {
> -            t |= *p++;
> -        }
> -        t |= ldq_he_p(buf + len - 8);
> -
> -        return t == 0;
> +    /*
> +     * Use unaligned memory access functions to handle
> +     * the beginning and end of the buffer.
> +     */
> +    if (unlikely(len <= 8)) {
> +        return (ldl_he_p(buf) | ldl_he_p(buf + len - 4)) == 0;
>       }
> +
> +    t = ldq_he_p(buf) | ldq_he_p(buf + len - 8);

Here we read #0 and #31, ...

> +    p = QEMU_ALIGN_PTR_DOWN(buf + 8, 8);
> +    e = QEMU_ALIGN_PTR_DOWN(buf + len - 1, 8);
> +
> +    /* Read 0 to 31 aligned words from the middle. */

... so here is #1 to #30?

> +    while (p < e) {
> +        t |= *p++;
> +    }
> +    return t == 0;
> +}

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


