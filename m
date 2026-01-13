Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65BA6D30CDB
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 21:55:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfmM4-0005wF-Bi; Tue, 13 Jan 2026 16:55:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vfmLx-0005iY-U5
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 16:55:06 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vfmLv-0002FX-HJ
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 16:55:04 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-34ab8e0df53so6487395a91.3
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 13:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768341302; x=1768946102; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tNOSPzEz6dvnctQDi2a4Enx1q3gLUDEzSBKlrHkfg+M=;
 b=toMKCgvR4g1w1l04vclfg4FfgCHkk+RLvQBc/dl0lSEW5EySNhEJWOxRmPdUfpBIP4
 TUyqkfwKDazRFOodKODr6rG9bD+DrVlzOh7XXx/b4TLHY3qB8eXnA5dDPbFACza+E3cu
 ASu5KQdnSvTYFUQbWFgqs06syfQY+0AfXRWgOEGc1CUIh90vJ4J/4o7pZ8ospBsJzzHo
 8mnIqhYWQ1uJpkghI+OSYWGcZOhk42hjUGzCmG7AgZ/BN0oLzIzxhAEpyElOhlvaUbZW
 aWNhHCcHSuBv48XxR12ZnL00Cyt0HeEXjKAnC5/ODxgEivFfl1mUQl5t+0D359jHSG/c
 nyNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768341302; x=1768946102;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tNOSPzEz6dvnctQDi2a4Enx1q3gLUDEzSBKlrHkfg+M=;
 b=nUqGbf5iz97jSPomGyIfrNwdUYS1VhraFPO7BGBXCXzXUzE1Sw7ySn+xnNwnP0TfxD
 6COxt3xtNM/ujdX8fmsyCxh449pcAGZ9hW18XYgp+54xjQj+0W3HJN7FxRRoO6BG/ANV
 4+oJLVaaTYQO2m9BXfLFxbhll6qQ/9atdVwXVU9heajS9zNtDuGvUfbYEtAuGCM1JMil
 GR44cN2GNu24gmij0ivxWF9V0q1sp0mrmFjRWaa/2fBcMFYQS44L/TcTafADGDYC+tgi
 eV1zyuwOWAVcKLAUjWBnsdIz+rCqMWgbTWph32qyixtj6iynrG/TK/iYX31YmlZfmY/R
 F4dw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyd3moIY98bvpXTYjy6jaAlioiTcWn+lYl8OWhfxpvP+iCcYfKKxzc3PJyqazh6VyHZAIrKnjXsEba@nongnu.org
X-Gm-Message-State: AOJu0Yx7+6aPDvkU7ulwOajPOXTcj8GQiCjA2PWRpyHZLjqS9MIyUzhr
 O/V4lEGR3a/y2jVW0+6d9WIOYTsO0yLEhS5gJ/B0XCfp1Y0b7xGCS97k1SRKvZmU9fo=
X-Gm-Gg: AY/fxX7qlnPFFpoUFEKtH6KtxWb9dGyqsA9qLOPkcZcyPyvi8GiThz+0LZw9pWcNVYv
 fyjCM1PVecjqA0xqsLyDdqcsLHkojuxPY3J62mjPIJadiu0buRu9PwV1WpRFhlnjsrVbIVLdzBy
 RSNbcH6LThfd+tWFLiEsReLc2JhNcNWMay2x/inXYWTuVekXPVMLqCTxv45481ifz/1W9R4H9Ej
 m+Vz2jptK4jErw+KIg42LOYDoCfalECdc8TBcZYukwyupz1vWTgxqMSWKk4xjA36FnlFdJEm6OL
 2I4BjAfDJHsYTOADsTpMVihThd2hFutarO8hoB3zBMfsZEUeqjOovTg/yg3dwhDJM7GdY4CHo4Z
 sadETOyfJPTbdefnwBHNdCl8ur7blkqz5iYLBqM1bqBFjZNJnspj8dxX5D+iLj+G5aFkanybxkC
 bC2DiFACw/EaeOsMufsxqQsI8faYilOsq1jYdTiKj/CLR0CfaUq9uFP6iR
X-Received: by 2002:a17:90b:35c5:b0:340:d578:f299 with SMTP id
 98e67ed59e1d1-351090c7fa2mr465807a91.3.1768341301722; 
 Tue, 13 Jan 2026 13:55:01 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3510a8566edsm7697a91.15.2026.01.13.13.55.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jan 2026 13:55:01 -0800 (PST)
Message-ID: <188b2d41-de97-4d68-b60e-4a9ae3384787@linaro.org>
Date: Tue, 13 Jan 2026 13:55:00 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user/aarch64/target_fcntl.h: add missing
 TARGET_O_LARGEFILE definition
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Phil_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 alex.bennee@linaro.org, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260113194029.1691393-1-pierrick.bouvier@linaro.org>
 <5a1cd565-3a18-4a49-8f5e-e06c19cd12e6@tls.msk.ru>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <5a1cd565-3a18-4a49-8f5e-e06c19cd12e6@tls.msk.ru>
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

On 1/13/26 1:53 PM, Michael Tokarev wrote:
> On 1/13/26 22:40, Pierrick Bouvier wrote:
>> This caused a failure with program using openat2, where O_LARGEFILE was
>> replaced by O_NOFOLLOW.
>> This issue is only visible when QEMU is compiled with musl libc, where
>> O_LARGEFILE is different from 0 (vs glibc).
>>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3262
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    linux-user/aarch64/target_fcntl.h | 1 +
>>    1 file changed, 1 insertion(+)
>>
>> diff --git a/linux-user/aarch64/target_fcntl.h b/linux-user/aarch64/target_fcntl.h
>> index efdf6e5f058..55ab788a7ce 100644
>> --- a/linux-user/aarch64/target_fcntl.h
>> +++ b/linux-user/aarch64/target_fcntl.h
>> @@ -11,6 +11,7 @@
>>    #define TARGET_O_DIRECTORY      040000 /* must be a directory */
>>    #define TARGET_O_NOFOLLOW      0100000 /* don't follow links */
>>    #define TARGET_O_DIRECT        0200000 /* direct disk access hint */
>> +#define TARGET_O_LARGEFILE     0400000
>>    
>>    #include "../generic/fcntl.h"
>>    #endif
> 
> Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
> 
> Heck.  I was this >< close to discovering this :))
> 
> Thanks,
> 
> /mjt

Given that we both took a look at this, and the original bug reporter 
also, I think it can be considered as a shared "discovery" :).

