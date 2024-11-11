Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C19DBD12D51
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 14:59:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAVt3-0006ec-Im; Mon, 11 Nov 2024 09:59:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tAVt0-0006dd-Hs
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 09:59:26 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tAVsy-0003At-RM
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 09:59:26 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-720b2d8bb8dso3244845b3a.1
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2024 06:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731337162; x=1731941962; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=e2jZB5X7XxZusWcEl8AMGv7znGj0ABP7iOkyzhlTpAA=;
 b=atE7G+feUMmvSNOs2AlGYNVbwtjxkQg1yhOh0WrsOWkrgNu+ZWbry8PI4kXVG9Nlt6
 XLdeE+4CWHkG1IFip/Feu1AIWlV7SYUgFyG0RSDs8aSmN0gS7vpGje6TCWpxU+KQ4Z2H
 NMc79Hoq1JWVLLwz88uI40hjb9MMou36qU2sXwTtXuwOkpmGGx1lT9t2vIfb07VX+ugR
 jI4FhNPK7ktxbQ2oiGRsaQGL5pXXanvSjuoGJ3FRTgGZ2hmtb56HGDIX6C2+4dwBWtXK
 k1vZ358DaA3wPjRM+n7LU8mkEVtl3T5dVS5rSum3QNj3clqkeojEsoKx5tjkHHL+clxI
 6szA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731337162; x=1731941962;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e2jZB5X7XxZusWcEl8AMGv7znGj0ABP7iOkyzhlTpAA=;
 b=tVoRLkyEibU+pGcywK1nwFdeOG1KD9Qnzuz2qX/PBaOhI6KJcFLXXWQu4M2WTtLdYZ
 xscgNothMk7Ha3nE2XjKhDh5T284yvRuolYa6sArvRmaQMYbMU9GJuzoDaKLeVDR+6fp
 aZoB8Lo7tLELX0kiLW9rortHVPpGEhokDvOgDnKFO3RuVnaazoerWxZZBA50XWb3DhwF
 +ezfVIaoKMyZPbfPZkv4GBfCg9Gs8R/VkFWAdWFVneY7YgXtTcJpYQE3j6a1+wxQNShv
 MpTNBT2qFYfmV5xCRThWs+qCeAbDpj1OzMTTVnDDnHUut0SL11TzUbFgTVUcMSZEJyic
 J5RA==
X-Gm-Message-State: AOJu0Yxm0fvR4yL37KxJYSy+J7wim1chjdF1JKHSwJp9Ke1qRX3In5mG
 rB7NL1IDeFxKZwD/T+gj6su5+AjRPj7PlS9yEQnmXgqPDzphXO2SVlWCnLpwEjHLYlhxbLBs+2w
 B
X-Google-Smtp-Source: AGHT+IFNDccMiqX+s459NfX+pdm9E5/SdMc/qX1GxpQOAdmIqVuROkfjUOisys6tolLBfjHUKo2qfA==
X-Received: by 2002:a05:6a00:2ea8:b0:71e:6046:87c2 with SMTP id
 d2e1a72fcca58-724133b7d62mr15036200b3a.26.1731337162547; 
 Mon, 11 Nov 2024 06:59:22 -0800 (PST)
Received: from [192.168.52.227] (wsip-24-120-228-34.lv.lv.cox.net.
 [24.120.228.34]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7240799bb25sm9487489b3a.109.2024.11.11.06.59.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Nov 2024 06:59:22 -0800 (PST)
Message-ID: <10610014-c6d6-4d39-9df1-f66a0900c754@linaro.org>
Date: Mon, 11 Nov 2024 06:59:20 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user/strace: show TID instead of PID
To: qemu-devel@nongnu.org
References: <20241024-strace-v1-1-56c4161431cd@gmx.net>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241024-strace-v1-1-56c4161431cd@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

On 10/23/24 16:47, J. Neuschäfer wrote:
> This aligns with strace, and is very useful when tracing multi-threaded
> programs. The result is the same in single-threaded programs.

See also "-D log.%d -d tid -strace" which will split the output into per-tid files.

> 
> gettid() requires the _GNU_SOURCE feature test macro, so it might be
> unavailable in rare cases. I don't expect it to be a problem though,
> because it's implemented by both glibc and musl.
> 
> Signed-off-by: J. Neuschäfer <j.neuschaefer@gmx.net>
> ---
>   linux-user/strace.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index c3eb3a2706a93fdcaf693b3413b13921a3c97e8e..93e8c73de8a4a307e6e0df5555bee4c769e41e64 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -4337,7 +4337,7 @@ print_syscall(CPUArchState *cpu_env, int num,
>       if (!f) {
>           return;
>       }
> -    fprintf(f, "%d ", getpid());
> +    fprintf(f, "%d ", gettid());

Probably better as qemu_get_thread_id(), but otherwise

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

