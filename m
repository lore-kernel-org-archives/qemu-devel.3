Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBBE3D46617
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 20:55:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgUN1-0003C2-Ll; Thu, 15 Jan 2026 15:55:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vgUMz-00038q-MT
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 15:55:05 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vgUMx-0004Je-TB
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 15:55:05 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2a3e76d0f64so12181315ad.1
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 12:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768510502; x=1769115302; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sgnG7+PDyshqgooRGZm5P2xFaRbmleKWjT+Zpe3V7+g=;
 b=xCzf329OB4wBqF+Kt4fKvqHDshohfFbVQRgrXvXdiGwkjzhmroc58yPe39uM+JEffL
 GV4kGsA7QyrOug4VDKJ0DQam3F1VtaC1bPYdOPjblHbdwhKN3k/fvWakFDU8pQ9Ptb27
 XsykR3DkUtpuKyysIckpo2MXRpJ//qHnic8wtXhXCJuYvm6Nn/3SgD54BrLKp5H/Qood
 LEBIARH6LX14Ac15lCpFCNa+fXgOVpThJgbkUFzIagraKGqDIGbiAcMTHgw6y97dv8Dl
 VRVQyN2rqoYNvPoe/C8GRqQw8rLW27bPhl2AeyqEbX88tZASWnInW1Fqn7SXTK/GbIgq
 OK2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768510502; x=1769115302;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sgnG7+PDyshqgooRGZm5P2xFaRbmleKWjT+Zpe3V7+g=;
 b=VVSfzRbE46fCKcNvJSRTa1T5FCUqNBkdRQMJBvoJ45HVerxeenT54fIYE1qB0HEbEE
 RcU4cZHt2TChDU7xfRizdP49f9wLK291jdR27eFy/bNWG7npND+f6TDmesz1nr9A7LWW
 21vpTA1cnSsYLYfWPQ/mgRa5OErQyQgmX6P4skftROnPckwbbrXNyTgm7ZnD7HNOXqbE
 MjPvmEPoGYiJpLQ2nuo7SwHJBG9nGbiIuQ0qxfYkF8crkLdh2iBNg3SKE5LUEXLfef8M
 FktnY3tx9sPujGaFNgLazX1SMG8yo0Yvc8SU57MHQmgdDu/v3lrfKNzgtzAIfvi2n7GW
 5jFg==
X-Gm-Message-State: AOJu0YyNsl+yKuXqaDvU8lXZnvb02wIeeM63SIHgKIG0pHdeHMcR+rny
 KJUIBNv72NYaHJ0dbnnOpAwxw3bCwI0T9cuAcLSyyWXwzuAK/IUu4YVUmccdyl3Z1mkwa1lk/QI
 Or+0H
X-Gm-Gg: AY/fxX7KOqZL1eE9c0GjaEpEf9BLA9XKQOoX5xo7Myzm4gjfCi8p67g4KZTQ2cpktn1
 LzDqA/B4IQeTKmswcWTaaOIdzorRZo8ps65jUy6tBBsLwabrwh0pCEddCPLYI8CRFtXBS+HDi6T
 JVZUE8LX7qCjSjQbrdsJoGZZm8DihDCngeIvorCaqzveNIbI61qST9G3a1cWJxaYbxocpmEk6rQ
 m8RBqC8AXQlr2ZFbCV1ibLmuIWrnWVLqPxGwHAezJjytY23/uoLID632wu8HUHgSJ2f4MN8AVH8
 1l5VW1LsudtFpprb1FZ02dSLWwnEwdIStKmO2gaSM0Vp5d+J8ijkTGsT/oYFC5NFTLIBOPANW1Z
 BceJ7aBspGG3liWPLaGOhaY2Xo42Ga1Fb9MmekdDloEfyYtQJ8e82hcAq7CneuZ4aB31k8MkePJ
 psE1Unq0qy78LkJO3QeeZFP04OcLB6XLLV0NdkhnvLVOOdJXv7vyeCWv8I
X-Received: by 2002:a17:902:e787:b0:2a0:fb1c:144e with SMTP id
 d9443c01a7336-2a700990c98mr40609645ad.7.1768510502346; 
 Thu, 15 Jan 2026 12:55:02 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a71941c1ffsm1681515ad.95.2026.01.15.12.55.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jan 2026 12:55:01 -0800 (PST)
Message-ID: <9828f4a9-1f0a-41d2-8525-92f5598b9402@linaro.org>
Date: Thu, 15 Jan 2026 12:55:00 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user/aarch64/target_fcntl.h: add missing
 TARGET_O_LARGEFILE definition
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Phil_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, alex.bennee@linaro.org,
 Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260113194029.1691393-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260113194029.1691393-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
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

On 1/13/26 11:40 AM, Pierrick Bouvier wrote:
> This caused a failure with program using openat2, where O_LARGEFILE was
> replaced by O_NOFOLLOW.
> This issue is only visible when QEMU is compiled with musl libc, where
> O_LARGEFILE is different from 0 (vs glibc).
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3262
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   linux-user/aarch64/target_fcntl.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/linux-user/aarch64/target_fcntl.h b/linux-user/aarch64/target_fcntl.h
> index efdf6e5f058..55ab788a7ce 100644
> --- a/linux-user/aarch64/target_fcntl.h
> +++ b/linux-user/aarch64/target_fcntl.h
> @@ -11,6 +11,7 @@
>   #define TARGET_O_DIRECTORY      040000 /* must be a directory */
>   #define TARGET_O_NOFOLLOW      0100000 /* don't follow links */
>   #define TARGET_O_DIRECT        0200000 /* direct disk access hint */
> +#define TARGET_O_LARGEFILE     0400000
>   
>   #include "../generic/fcntl.h"
>   #endif

Michael, any chance you could pull this as part of one of your series 
for linux-user?

Regards,
Pierrick

