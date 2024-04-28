Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F6BFC4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 18:35:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s19N7-0003J7-9r; Sun, 28 Apr 2024 14:35:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s19N3-0003Ie-1X
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 14:35:29 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s19Mz-0002ud-Iy
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 14:35:27 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2a6fa7773d3so3081429a91.3
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 11:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714329324; x=1714934124; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bTNIx8CkeV+RCgjWY5UL9EgQYbINHLerLJZuyhrTMcc=;
 b=u4uui7XvCLXiNoN6QLR5btp2Y4mqOYiSkpiG222h7XCbCKTByoz64vuB3qHyVZ23OM
 +alZHRteabr3Nov+wJ7YSWYytH8E3/cKf+UrwLf0sLugLthwmdu8bb/tJw/6CgHWzTGi
 6ZIMxJaIq9hx9ENa7VjDf1j/FW0W2LdcgZ07f87iFZNp/ms728QJPPjw3bWfnp/Y4gow
 cyNp/m87cZ9J5dErxIerSCwg2piQSytqLbgphz6xoLwfTP/8qsx4WQ0pppS6uzp8LjRJ
 V33bmOv5C40WzWo4G3goyOq4osXXAReEOypYkXB1IfJ1EjQB+aYlifCFong+ZMNvTVcD
 9MFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714329324; x=1714934124;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bTNIx8CkeV+RCgjWY5UL9EgQYbINHLerLJZuyhrTMcc=;
 b=CQ9Ndj8LDao+qZ47LtlgoBGSc2JuO0UswrjW9SLiGoxaKQvG17YLOpTaiYqmsJ6f8Y
 wgXFUwSl44bq4vsLublBmqjMdrSx8WvkER5cf+yfeHBArCwv49A4VotlyCSJ62xbmb5D
 3cTNyoi9AuvTuV4Z9eCwkAM5/4OvKm8iJjU/MKsZA7vF6XSf9EnnLGMxtV73e6CCvfZQ
 Xl5aSabcgzVs2530gX85wyRNAuNJcQYTk8b+IoyEU+mz2OMMmsqWzqzFZmzaPhROuveX
 UoL6deZgtgaj8gHOdgSQzHhMnSa2mUWkRMaBqMj4+nZxKJOEGqqn+8lVeAfHQ/43kv/a
 nFLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2ginlJ+rbnoY0SS/S2N4LU5CxlWhWniIhRpdUej18S1qHjPGA7mAB3Cg1fZaki4lJcr9l34KPNM17zq9PqTs8Nkxdav0=
X-Gm-Message-State: AOJu0YyxQGz+mSNjUYTGe9HeVCC0RFrAxike8p52QsFrnEzXcPHjUVkc
 DsnePPP7R/dtPp6GB06FzubIs3sNOFYo4N185QEkHjhlBMaofDGkHnsy4ZyOLz4=
X-Google-Smtp-Source: AGHT+IHtDpIB59mMNsNxg8LDCMUpkBhscocFL30Ts+ITCHhbCUcaQr7rTsYY70BbH0Lp2z2A/Mnsvg==
X-Received: by 2002:a17:90a:dac2:b0:2a4:6a31:600c with SMTP id
 g2-20020a17090adac200b002a46a31600cmr7913211pjx.14.1714329323945; 
 Sun, 28 Apr 2024 11:35:23 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 ev16-20020a17090aead000b002ae2579ffeesm11496242pjb.19.2024.04.28.11.35.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Apr 2024 11:35:23 -0700 (PDT)
Message-ID: <2ec058f5-dfb1-4ce7-b935-8530a9487394@linaro.org>
Date: Sun, 28 Apr 2024 11:35:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/14] accel/tcg: Use cpu_loop_exit_requested() in
 cpu_loop_exec_tb()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240427155714.53669-1-philmd@linaro.org>
 <20240427155714.53669-12-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240427155714.53669-12-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

On 4/27/24 08:57, Philippe Mathieu-Daudé wrote:
> Do not open-code cpu_loop_exit_requested().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/tcg/cpu-exec.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index 225e5fbd3e..0329c6423e 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -900,8 +900,6 @@ static inline void cpu_loop_exec_tb(CPUState *cpu, TranslationBlock *tb,
>                                       vaddr pc, TranslationBlock **last_tb,
>                                       int *tb_exit)
>   {
> -    int32_t insns_left;
> -
>       trace_exec_tb(tb, pc);
>       tb = cpu_tb_exec(cpu, tb, tb_exit);
>       if (*tb_exit != TB_EXIT_REQUESTED) {
> @@ -910,8 +908,7 @@ static inline void cpu_loop_exec_tb(CPUState *cpu, TranslationBlock *tb,
>       }
>   
>       *last_tb = NULL;
> -    insns_left = qatomic_read(&cpu->neg.icount_decr.u32);
> -    if (insns_left < 0) {
> +    if (cpu_loop_exit_requested(cpu)) {
>           /* Something asked us to stop executing chained TBs; just
>            * continue round the main loop. Whatever requested the exit
>            * will also have set something else (eg exit_request or
> @@ -925,6 +922,8 @@ static inline void cpu_loop_exec_tb(CPUState *cpu, TranslationBlock *tb,
>       /* Instruction counter expired.  */
>       assert(icount_enabled());
>   #ifndef CONFIG_USER_ONLY
> +    int32_t insns_left;
> +

If you're going to declare in the middle of a block, you might as well delay until the 
initialization a few lines down.


r~

