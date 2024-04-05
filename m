Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60A02C3A59D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 22:54:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rssRo-0001DR-US; Fri, 05 Apr 2024 18:54:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rssRn-00015f-KA
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 18:54:11 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rssRl-0004vM-R3
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 18:54:11 -0400
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3c3ca3c3bbaso1466327b6e.0
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 15:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712357648; x=1712962448; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ql1z0oZrcLRhApHZo5EHDSlh5xB0V1bfS5gTRV8Uqd4=;
 b=Iatjp3nrt7XAXXM2We/4CQ0Fa0wn5Pk2j7ZbogmFch4TFMgKoFMaVm8sFMTtwH+KTB
 PidZcm+jLqqVdD5egxArk3MtYOYPSyLZ0FUQVsx1zc5YwOpvwb12hpUi8ljOeK/DNsum
 G+gERqZ8cdqwDoE8F39FMgE51K5bJXqmM8Bc+Vwvl4lVZTVSYVly+oB1qWC/122MOQ/n
 evaVdzDci8upkbjydXcJ/aNAp6mS5f62f7bGX4MGCNXQ2dnBfAi7KXOWEvutP0Gk9+aB
 VbF9+qIRstGV/U0jbuH9X6p9S7N6TwSBqnF5oHu493bG8QKVjTUSbZFLoLa3neiIePuQ
 wu5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712357648; x=1712962448;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ql1z0oZrcLRhApHZo5EHDSlh5xB0V1bfS5gTRV8Uqd4=;
 b=xQeJAPZl1k03uBXEUq6MiHME3KXE1zXiY/yv/d3/b9HMSSizY4LWSF+NIozVwX63nE
 qsf7UIx/tJcgevFM+xqgXEbo23QPJY2Efd+aZ64+xrrxPhx4zRTUjtbu3hzWLgAVqGyU
 N1zHVBrcG4VxBEdbG9+OrjXY646W3qLbPVUBmM9b7erQaToImvQ4EE2lkZK5EOYQN75N
 Eac6fefSCAMgtMw1Jk6O4IMwC4teiHkXEscZzMUXKhOY8+WXTdHEkWKq4xpYyLsoerf4
 krtMyxDmUwr/K4ydpFhCkPzQLfMGVp+KQ0X584uLDgIeZILLU1RIyRcsnbodqMJ/NgE5
 HdmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFNh3SdwjIVPX54kDRVP0lhu8vZUpIQV0hQaWOkKHvUApxZgP5ZCEgZFnk4LhllieE7YIqiKP+racs5Pfc+p0OCgoxvM8=
X-Gm-Message-State: AOJu0YysjtIRGXULZPTMpi0LcGhR5R9deWyMLI0sLW7p52QA7fEEFATs
 gc1h6dp5/CFDfxzp36ORAaohx7bz8U8UJ9iEmyqr4jklcnAUk1/MA/GlOeytYs1RcTO68MOe2yi
 z
X-Google-Smtp-Source: AGHT+IEDIcyZQbjKZE6hzoeSTh0wxUXDzY2kkgI3fMH+ElI4SicQfohtBIhu8nCYFR2dPrvMFwZYjw==
X-Received: by 2002:a05:6359:7908:b0:17e:9fed:d986 with SMTP id
 xc8-20020a056359790800b0017e9fedd986mr3336593rwb.29.1712357648321; 
 Fri, 05 Apr 2024 15:54:08 -0700 (PDT)
Received: from [172.20.1.19] (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 27-20020a630f5b000000b005dc5289c4edsm1985865pgp.64.2024.04.05.15.54.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Apr 2024 15:54:07 -0700 (PDT)
Message-ID: <036c4107-676d-42b1-9ece-31dc94295f1b@linaro.org>
Date: Fri, 5 Apr 2024 12:54:04 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sh4: mac.w: memory accesses are 16-bit words
To: Zack Buhman <zack@buhman.org>, qemu-devel@nongnu.org
References: <20240402093756.27466-1-zack@buhman.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240402093756.27466-1-zack@buhman.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x236.google.com
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

On 4/1/24 23:37, Zack Buhman wrote:
> Before this change, executing a code sequence such as:
> 
>             mova   tblm,r0
>             mov    r0,r1
>             mova   tbln,r0
>             clrs
>             clrmac
>             mac.w  @r0+,@r1+
>             mac.w  @r0+,@r1+
> 
>             .align 4
>    tblm:    .word  0x1234
>             .word  0x5678
>    tbln:    .word  0x9abc
>             .word  0xdefg
> 
> Does not result in correct behavior:
> 
> Expected behavior:
>    first macw : macl = 0x1234 * 0x9abc + 0x0
>                 mach = 0x0
> 
>    second macw: macl = 0x5678 * 0xdefg + 0xb00a630
>                 mach = 0x0
> 
> Observed behavior (qemu-sh4eb, prior to this commit):
> 
>    first macw : macl = 0x5678 * 0xdefg + 0x0
>                 mach = 0x0
> 
>    second macw: (unaligned longword memory access, SIGBUS)
> 
> Various SH-4 ISA manuals also confirm that `mac.w` is a 16-bit word memory
> access, not a 32-bit longword memory access.
> 
> Signed-off-by: Zack Buhman <zack@buhman.org>
> ---
>   target/sh4/translate.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Queued, thanks.


r~

