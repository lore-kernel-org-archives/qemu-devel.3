Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0271DC48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 13:15:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ray34-0000KZ-4D; Fri, 16 Feb 2024 08:14:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <charlie@rivosinc.com>)
 id 1rarFW-0003pg-Lg
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 00:59:02 -0500
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <charlie@rivosinc.com>)
 id 1rarFU-0002Sf-Oq
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 00:59:02 -0500
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-607d9c4fa90so13432367b3.2
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 21:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1708063138; x=1708667938;
 darn=nongnu.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qkt6gzG86HYBPO5PBKdyksyrZ9wuJF9yjWjHm8/bdzM=;
 b=i6HFdH8QGao2zMYLndDRIBJpfoEMxhBvNMXTj1DP/CzqiGDf3shKDjeksC4C8g+j19
 nsjQu1sxfdSdqX+Eb4MNe0Eeb138KdG3EeFx3ohs+VlCE6PO/gCm3lqkCacNyG6NE+Jd
 O796okjjDe7dLzrUhowhgiLNyuf8QZ0MbDre60Ytb3SlsaczqhcYoofIR3JS2EXqYDzV
 eT4jP+E0vAf0ejErgCbsEDDlEAflQWO8fFpA6ZcZckuU2Dc4VLFOS38YkswLIElm5deL
 rDIyj9LTmlmMCbt9a6iTYK0+yiFGfVGfcy+TOAHUDlgWvM7kKxEIBAb1EYjGratkXYJH
 VFhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708063138; x=1708667938;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qkt6gzG86HYBPO5PBKdyksyrZ9wuJF9yjWjHm8/bdzM=;
 b=BuDJhGEPHkdrK6n/7ctO8eBLuHlVFU4n18q1PwXzYLm+gysA4y8FQ0uOHYTIA+r4XB
 lXf4hIScA6x13rx2yzrtCwZ8TflYH9cZf+6DO4occFFM+uU7qCKmHE5yU9NvCGBwDwUX
 dwknSmR6LnEo5hA+vTgsZALr9czzFwUwd/4zQ6ymepRpp75vzGnNpuCLQXrh4tUpsz0q
 1ZxsG0eLyu36fmwsXtC9Od9EKuRlu/FWV8oULB7AShaGnOr48OCRo9Z7OLzk5oHLJSUi
 bzjifsb91ZroYsduG8kBtcU8GRvOExbnHn7VwlbyFSTI7DKSxMCENdogU8JzEV1z3NOG
 EB5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWu2XNpDZRkIL8u2T5MQ31wmDXwjyh3cPAzgswPWLL6z9M3+vADaYWG2Q+j+BG7umDNtlfg70WVGCzfp8eePmbT3qTujIg=
X-Gm-Message-State: AOJu0YyMSUEh9DkbRjBFyinXEXZ5rOoiSZHUaN679KPTYiZ8DsaShX6J
 8TAjascOw7WEleh5A6/+ru20qq8yXTOv2XpQ06CzaVVng79k+1wQyjz8ljbNtK0=
X-Google-Smtp-Source: AGHT+IG0YQeP3a55UeL2dPLivTEtmwPUZxTwga0rFX7vur+O1AF9hPkrFxutjRNb2b9SOk6reFrQDw==
X-Received: by 2002:a81:4c41:0:b0:607:a085:b434 with SMTP id
 z62-20020a814c41000000b00607a085b434mr3801690ywa.8.1708063138659; 
 Thu, 15 Feb 2024 21:58:58 -0800 (PST)
Received: from ghost ([50.146.0.2]) by smtp.gmail.com with ESMTPSA id
 p202-20020a0de6d3000000b00607fc1e4fe6sm113000ywe.30.2024.02.15.21.58.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 21:58:57 -0800 (PST)
Date: Fri, 16 Feb 2024 00:58:56 -0500
From: Charlie Jenkins <charlie@rivosinc.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Helge Deller <deller@gmx.de>
Subject: Re: [PATCH] target: hppa: Fix unaligned double word accesses for
 hppa64
Message-ID: <Zc75oNNSPx5n2ODr@ghost>
References: <20240216053415.2163286-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216053415.2163286-1-linux@roeck-us.net>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=charlie@rivosinc.com; helo=mail-yw1-x1130.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 16 Feb 2024 08:14:33 -0500
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

On Thu, Feb 15, 2024 at 09:34:15PM -0800, Guenter Roeck wrote:
> Unaligned 64-bit accesses were found in Linux to clobber carry bits,
> resulting in bad results if an arithmetic operation involving a
> carry bit was executed after an unaligned 64-bit operation.
> 
> hppa 2.0 defines additional carry bits in PSW register bits 32..39.
> When restoring PSW after executing an unaligned instruction trap,
> those bits were not cleared and ended up to be active all the time.
> Clearing bit 32..39 in psw prior to restoring it solves the problem.
> 
> Fixes: 931adff31478 ("target/hppa: Update cpu_hppa_get/put_psw for hppa64")
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Charlie Jenkins <charlie@rivosinc.com>
> Cc: Helge Deller <deller@gmx.de>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  target/hppa/helper.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/target/hppa/helper.c b/target/hppa/helper.c
> index 859644c47a..7b798d1227 100644
> --- a/target/hppa/helper.c
> +++ b/target/hppa/helper.c
> @@ -76,7 +76,12 @@ void cpu_hppa_put_psw(CPUHPPAState *env, target_ulong psw)
>      }
>      psw &= ~reserved;
>  
> -    env->psw = psw & ~(PSW_N | PSW_V | PSW_CB);
> +    if (hppa_is_pa20(env)) {
> +        env->psw = psw & ~(PSW_N | PSW_V | PSW_CB | 0xff00000000ull);

I thought there was something fishy in this function but was slow on the
uptake...

How about defining a new macro (PSW_CB_HIGH) to hold this value?

- Charlie

> +    } else {
> +        env->psw = psw & ~(PSW_N | PSW_V | PSW_CB);
> +    }
> +
>      env->psw_n = (psw / PSW_N) & 1;
>      env->psw_v = -((psw / PSW_V) & 1);
>  
> -- 
> 2.39.2
> 

