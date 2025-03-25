Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2229C36002
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 00:53:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twsXD-0002mL-2W; Mon, 24 Mar 2025 20:52:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twsXA-0002lp-5A
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 20:52:48 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twsX8-00029f-81
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 20:52:47 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-30155bbbed9so6539970a91.1
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 17:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742863964; x=1743468764; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BE/NCzDcfcW/KkqxAOSGBRp4qdENKnqvok87Fmjw3sw=;
 b=InXQAarI0J2o8jygm35nKPKvf1PbTTQZwHWjQ2nCsZC/i8PP4JU8D7m4kpoWjmmkRm
 8wPNQOEW6mc/xdnMnxk2fHCKNCb5y+0GxZuq1abPkMz1HlAdqDieYyeX+b26w1NvhtUT
 kuyzengvTDk8SsI378kWkx+3dgypx13bZRAezL6iUfTMiYlM0bNHj1MVxG/WFk7V91JB
 6sQYWu4b8EV1nXmg3/AHHEMp2epajrPsrr4OK2yVFObES2exlhiYziov/GPRRbsQJXnZ
 ArHDrf3FK4XPf2AfXvYuMc2nT0mFX8V5mvmWX3tb7ralmQpKdMDZoQ//4rvsPLmVC51E
 9R6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742863964; x=1743468764;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BE/NCzDcfcW/KkqxAOSGBRp4qdENKnqvok87Fmjw3sw=;
 b=HPusDPureZ/ab/sOP1xPB/tSXXLMeHqKRxF5iMUqwjfn433+5XRaAa9VN+cXdnaL+z
 UDgwnL8GL4Yuf0PoNboWeqskRYD+6ogW0/efGS6V+64yE4Q9UdUuUT15HVHinqPIfa9x
 JMkADDH0IqK/L5BdBpv3Hd4Kve/6S+wl0Lz3LJ2nyM9gWdjgqYb5evg7JZ+KcSxvkudH
 FsqP+oxltdoQRNJ4f8v2fhInCUW7QG6YLd9Mi3xL98f8+J4mWa9ebGMTn0Wb0k3cORvO
 JNcH80rm0M9Bql4LeFN/X3pugzBoeR1JdhrqtIvMXkNZoJGdNwX+pvVwhrazH+Egqrr5
 ftOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUKuPESc+heGG45ksORtMifNqNjd1iR06ZTnDjRg2WDYkPql2uqRHZdVZ9W6Ht89WRrdQG+e2VXSIt@nongnu.org
X-Gm-Message-State: AOJu0YzaNtwyjZasUHWHiuJRpxkxPuwFo7M0jePiMKgdASkBh0Utv0ZX
 HipJwogBs9LtNu+Z14MLf+VLCH+YaDagbg4VANMid/Zj6RRzaQ2qlSK+fL5VBh0=
X-Gm-Gg: ASbGncvRR1xMgLk064RHwVY2GmV4pAiV2ELYaPYahX6g8J0nf4RFyAIZ1T6+bUuzit7
 juTLnhMazYjCGglOrpyq6cjIBTW81kBh6xWfL74bSm3iQFn+VPW3Ak1KZPB0BG/5fNc5Q44HNMS
 ZQDxV+EEbrSI0SOVwc8HrM+O0JN6S9j1exsswwbJw+zcPOaFxWpqOI3ksMUfR3Plre8zxya/Mjb
 G6rJl6FZSOmQ7ltQusZ7JhCy2TmQAXcGpaQj1Om1SjgpzUMu9MqyjXlTmc//3sSIyNs4LGTgsBj
 xxNWMrKWFyuJUMlJH8qDIuXAKWSJeKNMWCimh8r/FrIFBAd9WlQu5eMnBg==
X-Google-Smtp-Source: AGHT+IHlW8Ikl6Rzech/fbv2H0rEKRkseQHB2cG2DNd6RXNuskMKTEOfcaaajMQ+zUu98iMYqVTBxw==
X-Received: by 2002:a17:90b:280b:b0:2ee:d824:b559 with SMTP id
 98e67ed59e1d1-3030fef09b9mr22048027a91.28.1742863964141; 
 Mon, 24 Mar 2025 17:52:44 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301bf58c243sm12927453a91.16.2025.03.24.17.52.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 17:52:43 -0700 (PDT)
Message-ID: <7124e6ea-2843-4e39-a577-915d7bf16df3@linaro.org>
Date: Mon, 24 Mar 2025 17:52:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/17] target/avr: Fix buffer read in avr_print_insn
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mrolnik@gmail.com, philmd@linaro.org, qemu-stable@nongnu.org
References: <20250323173730.3213964-1-richard.henderson@linaro.org>
 <20250323173730.3213964-3-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250323173730.3213964-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1030.google.com
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

On 3/23/25 10:37, Richard Henderson wrote:
> Do not unconditionally attempt to read 4 bytes, as there
> may only be 2 bytes remaining in the translator cache.
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/avr/disas.c | 21 ++++++++++++++-------
>   1 file changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/target/avr/disas.c b/target/avr/disas.c
> index b7689e8d7c..d341030174 100644
> --- a/target/avr/disas.c
> +++ b/target/avr/disas.c
> @@ -68,28 +68,35 @@ static bool decode_insn(DisasContext *ctx, uint16_t insn);
>   
>   int avr_print_insn(bfd_vma addr, disassemble_info *info)
>   {
> -    DisasContext ctx;
> +    DisasContext ctx = { info };
>       DisasContext *pctx = &ctx;
>       bfd_byte buffer[4];
>       uint16_t insn;
>       int status;
>   
> -    ctx.info = info;
> -
> -    status = info->read_memory_func(addr, buffer, 4, info);
> +    status = info->read_memory_func(addr, buffer, 2, info);
>       if (status != 0) {
>           info->memory_error_func(status, addr, info);
>           return -1;
>       }
>       insn = bfd_getl16(buffer);
> -    ctx.next_word = bfd_getl16(buffer + 2);
> -    ctx.next_word_used = false;
> +
> +    status = info->read_memory_func(addr + 2, buffer + 2, 2, info);
> +    if (status == 0) {
> +        ctx.next_word = bfd_getl16(buffer + 2);
> +    }
>   
>       if (!decode_insn(&ctx, insn)) {
>           output(".db", "0x%02x, 0x%02x", buffer[0], buffer[1]);
>       }
>   
> -    return ctx.next_word_used ? 4 : 2;
> +    if (!ctx.next_word_used) {
> +        return 2;
> +    } else if (status == 0) {
> +        return 4;
> +    }
> +    info->memory_error_func(status, addr + 2, info);
> +    return -1;
>   }
>   
>   

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


