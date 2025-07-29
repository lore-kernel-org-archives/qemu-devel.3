Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05746C87FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 16:15:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugmyj-0008T9-BT; Tue, 29 Jul 2025 12:15:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1ugmlH-0000kG-AG
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 12:01:10 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1ugmlE-0007gN-Ey
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 12:01:06 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-b420b87cb04so1525998a12.0
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 09:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753804861; x=1754409661; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LnQEZ1V+Aw/n6ZeZhS1eBlAAbEkwYS8JpHmsMfcI02Y=;
 b=hYxyZ4/gVQUjZyO3ep/OM8oaSlQAbs5fba8HKzL5CVS+qjhM20laN/KYXI0ixul5DM
 yDsVHjmn1BuIHECdf3Zp7xqynT2gRj8GEwfn6IcaXqxUImNz6dzYIcjs/31323HZvlbp
 6P3wqsNeSYjXyxIgd3Tefol0Y9IOLNohax4zZaRxJdmaBVQ14OcZ/rxxuiUF+wfHmYMI
 o54C1L4kHdIZmIw/hWa+hG2hsgq2EcSJEaAqzbLrJZFd8zazyxiYjmgkzQhrY++/pQwH
 lqrZ3gOXrtXsrOs7bFPLDPdlxvJ/JN25L4xoJhEHFYEnnbqaAbYswa3fsREaZRvhVP5c
 vHjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753804861; x=1754409661;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LnQEZ1V+Aw/n6ZeZhS1eBlAAbEkwYS8JpHmsMfcI02Y=;
 b=FlJieDy1r9fH2flauv8N9mJkjW0wc8jXHjITpmc1/KxeNccVnYXN+FCidg5/4+vdOh
 OMnicJ7lGe3kHPKqFOXc+TYH9DUyc1ittqGyu5Mihhy/r9stBmBQHysdATTlGh3jtYIA
 j8A76qJayBJI9LSdr3WutPbEPW3nrfCUCRQK+4WR0g6k420XM+Vy5ZRvFZzOYZDh8aER
 y/sOtMBeswKiMGUJZ1kJqjaORDmKQIqwcn/MSDlHcFX2PM//w3PMr5OJ7S/9FXmz+EoY
 IJ0eFPONnS4GKaMhNapXLvqLzM4Zuf35OfpsNKbX7SE2e9DDrcVOZkY8YvHjB7Qmk9zc
 O/qQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4KTfT03sYZYQNAB2YHAFpQYa2RVmwFH5+skf9+pUdNiRqF92fVuqkILcOqs2OS6UF3m1bMjo3gW1m@nongnu.org
X-Gm-Message-State: AOJu0Yw8WcUKCoT//iiE9P1ZpnrVY8ZeyuaaT6wsw1S17WWgtCm6N1rN
 5kvOMGsXIqtASSFbG/9o7Dy79pyxxvCeFLWUd8xYeJcJDyGsQVfuWmeSCMcoLzv+ilBnAJz7JpB
 JKgkaBzk=
X-Gm-Gg: ASbGnctr+w61rf+uDCyrecc3LIL7GFLZg8UddJJoqTffXgRa0m7pJRIH4GoZh6kheyM
 q1em5xASNGj7okQfIeww2i8tGIY1cE1B8FzR1JLVwiEKOKF77p61A0cy2g05yeqCoM43ArU8nFK
 eb8RvLBEQyXegLJiiagLU7Nh2k/LQUeM3V1BTQkX83Ra4dkrVqfqgNpWsY/BVeEUXjaj3/ulEsu
 vSO+bA1UQ6jyWmgGx/8rmQv7ArBA6D+VtJSJupGb0LyITrqLidDWHBggSXdSWrXIFz1WfiuS6UV
 fLY1bkEbvzqwAr+63kUseTqHypk2IKj5OW8Bma23/z0+D8T+LEJEyzxik3I8aJeAjJgqsd82ePo
 1E78uy7XtApDg7WGJpZ+pvtaBrPrHoUx2Hw==
X-Google-Smtp-Source: AGHT+IGY0IFeC4gyDYXjaWkD5GnX6rsOdmZRc4w8QnY0ArJFJF/yZaZYHY8opopXPIWH4/rD5JrAcQ==
X-Received: by 2002:a17:90b:2686:b0:31e:e4a5:437e with SMTP id
 98e67ed59e1d1-31f5ddb5352mr76128a91.12.1753804859014; 
 Tue, 29 Jul 2025 09:00:59 -0700 (PDT)
Received: from [192.168.0.102] ([187.75.37.236])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31e6625052asm12551264a91.6.2025.07.29.09.00.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Jul 2025 09:00:58 -0700 (PDT)
Message-ID: <9209927c-6c5f-4499-a3ef-1f4c70951ad0@linaro.org>
Date: Tue, 29 Jul 2025 13:01:50 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 46/82] target/arm: Implement FEAT_CHK
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-47-richard.henderson@linaro.org>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20250727080254.83840-47-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pg1-x52c.google.com
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

Hi Richard,

On 7/27/25 05:02, Richard Henderson wrote:
> This feature contains only the CHKFEAT instruction.  It has
> no ID enable, being back-allocated into the hint nop space.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/translate-a64.c | 14 ++++++++++++++
>   docs/system/arm/emulation.rst  |  1 +
>   target/arm/tcg/a64.decode      |  1 +
>   3 files changed, 16 insertions(+)
> 
> diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
> index 7831b3dab3..34d22cac8a 100644
> --- a/target/arm/tcg/translate-a64.c
> +++ b/target/arm/tcg/translate-a64.c
> @@ -2124,6 +2124,20 @@ static bool trans_AUTIBSP(DisasContext *s, arg_AUTIBSP *a)
>       return true;
>   }
>   
> +static bool trans_CHKFEAT(DisasContext *s, arg_CHKFEAT *a)
> +{
> +    uint64_t feat_en = 0;
> +
> +    if (s->gcs_en) {
> +        feat_en |= 1 << 0;

I understand that CHKFEAT is currently only tied to GCS but will cover more features
in the future so we can keep feat_en |= 1 << 0 even if it could gate TCG andi directly
on s->gcs_en and do andi with 0. ok.

It's curious that this instruction is tied to x16, it seems easy to use any other
general purpose register to query for the features.


> +    }
> +    if (feat_en) {
> +        TCGv_i64 x16 = cpu_reg(s, 16);
> +        tcg_gen_andi_i64(x16, x16, ~feat_en);
> +    }
> +    return true;
> +}
> +
>   static bool trans_CLREX(DisasContext *s, arg_CLREX *a)
>   {
>       tcg_gen_movi_i64(cpu_exclusive_addr, -1);
> diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
> index 6ebf9c9ce9..b894aced89 100644
> --- a/docs/system/arm/emulation.rst
> +++ b/docs/system/arm/emulation.rst
> @@ -28,6 +28,7 @@ the following architecture extensions:
>   - FEAT_BF16 (AArch64 BFloat16 instructions)
>   - FEAT_BTI (Branch Target Identification)
>   - FEAT_CCIDX (Extended cache index)
> +- FEAT_CHK (Check Feature Status)
>   - FEAT_CMOW (Control for cache maintenance permission)
>   - FEAT_CRC32 (CRC32 instructions)
>   - FEAT_Crypto (Cryptographic Extension)
> diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
> index 8c798cde2b..4315ed8dab 100644
> --- a/target/arm/tcg/a64.decode
> +++ b/target/arm/tcg/a64.decode
> @@ -246,6 +246,7 @@ ERETA           1101011 0100 11111 00001 m:1 11111 11111 &reta  # ERETAA, ERETAB
>       AUTIASP     1101 0101 0000 0011 0010 0011 101 11111
>       AUTIBZ      1101 0101 0000 0011 0010 0011 110 11111
>       AUTIBSP     1101 0101 0000 0011 0010 0011 111 11111
> +    CHKFEAT     1101 0101 0000 0011 0010 0101 000 11111
>     ]
>     # The canonical NOP has CRm == op2 == 0, but all of the space
>     # that isn't specifically allocated to an instruction must NOP

Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>


Cheers,
Gustavo

