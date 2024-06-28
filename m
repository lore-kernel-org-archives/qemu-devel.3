Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42CE8C30658
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 17:54:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNFo3-0000kJ-Ij; Fri, 28 Jun 2024 13:54:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNFnx-0000k2-HJ
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 13:54:37 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNFnu-0005oE-Ls
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 13:54:37 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1f9fb3ca81bso5887855ad.3
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 10:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719597273; x=1720202073; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pjjqyjZ8J34sht009LlJRNPgghPkN+NXbRwyTaCgcRE=;
 b=O+gX/fGP8tfO6Fg4lVHurewH5JZx8u7ST4XUuBMkLTI5COJ6wgF9JHL7+kTTWuy/qw
 atKQxLO28er1RGUxw1QOoMbyj4dzCStkJ12oYI7MbXNC1B4Xh4hQU0yQrfLDIijdLStT
 /i9sdZuodbJxSbHT7AMXTcqdGzqX1KBAYpqWNrbLqkRVmRorkL/sSVamx19WL99C1MXO
 M5pOVyKLeFR00tmiLehH4HQB4o1ziDMPTpESB4Hn+CLwg//luZZjaEMu9QzYsOj4UmOd
 YSIPi/imuhDW973zrssMZcy0+C09c6/AJRjy+kmRQH0ld7UpBsZkcgLJ65rvO3Tfxzir
 fvBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719597273; x=1720202073;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pjjqyjZ8J34sht009LlJRNPgghPkN+NXbRwyTaCgcRE=;
 b=eoXi0/Pi5gnozDZbPm8HWYHi/UFG+YCCyQQr0px+QDr4OIXXdAU2qsX/qdM89C/ZK9
 /+Oev/oY7H6fgJNDE1beQJnB8STLVjzW9DKt9mOXk2GB3STPXP93HumGMhF1Ea0uYled
 RS54G8J8aPc1v0zw2hJEm7cogK9kMZPJHucEVhoZgfEb7WI0emVt6F2DVvMmscQu8V7L
 FXPbpRl6jnTyww85k+Kb/uVfs4XqtUE8AuJeldtuRuRp1kmGJxz08rjS7hLrXvRLZO00
 SeU24oD7QJLbiWoW7viGhlOEgPCgmB6gPwZNVsO3TDkO+xubNG60o87w+xnRlw6/D8GQ
 L2aw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+SySTfKjJYolSR0S0+gABBMEQ4o1XI9rm8axwAjXK2nkvqMacdnBbMVlKRjJuHw38LRg2qXwU1tUknf3rC1iNeHk9KM4=
X-Gm-Message-State: AOJu0YzOFLUe8sgjtr42fLCJL6EyKayCIJjqmSSpKgyczM7mNKf8t0L4
 KY3/0q31QKPvOLtV2Ig9RbPJvGQ7P1lsgB1VGfnWGNWU3FTeTP/3pxzCxXh8cgfQusBb0oopnq/
 6
X-Google-Smtp-Source: AGHT+IGJzVDp2UOv9vNQ+XyFNYGSUD6c2HaqBGUA4nrlVmJjN5wrqOcSzSLaLvWAj/ZgsC2NsMn1Rw==
X-Received: by 2002:a17:903:32ce:b0:1f6:fe05:30e4 with SMTP id
 d9443c01a7336-1fa23fbf6c6mr176738085ad.27.1719597272697; 
 Fri, 28 Jun 2024 10:54:32 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fac15693e8sm18108665ad.217.2024.06.28.10.54.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Jun 2024 10:54:32 -0700 (PDT)
Message-ID: <627f05b5-7abe-423f-829e-4215bcf1bccd@linaro.org>
Date: Fri, 28 Jun 2024 10:54:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/23] target/i386: fix gen_prepare_size_nz condition
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20240628124258.832466-1-alex.bennee@linaro.org>
 <20240628124258.832466-3-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240628124258.832466-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 6/28/24 05:42, Alex Bennée wrote:
> Incorrect brace positions causes an unintended overflow on 32 bit
> builds and shenanigans result.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2413
> Suggested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   target/i386/tcg/translate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
> index ad1819815a..94f13541c3 100644
> --- a/target/i386/tcg/translate.c
> +++ b/target/i386/tcg/translate.c
> @@ -877,7 +877,7 @@ static CCPrepare gen_prepare_sign_nz(TCGv src, MemOp size)
>           return (CCPrepare) { .cond = TCG_COND_LT, .reg = src };
>       } else {
>           return (CCPrepare) { .cond = TCG_COND_TSTNE, .reg = src,
> -                             .imm = 1ull << ((8 << size) - 1) };
> +                             .imm = (1ull << (8 << size)) - 1 };

This is incorrect -- we want only to test the sign bit.
Perhaps MAKE_64BIT_MASK((8 << size) - 1, 1) would make this more explicit?

I'll have a quick look at the issue and see if I can reproduce.


r~

