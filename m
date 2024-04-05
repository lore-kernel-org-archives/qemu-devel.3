Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 427A2CD11C2
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 12:53:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsj4D-0003bE-2x; Fri, 05 Apr 2024 08:53:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rsj4B-0003b1-8Y
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 08:53:11 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rsj49-0000iw-Pp
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 08:53:10 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4156a29ff70so16110555e9.3
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 05:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712321588; x=1712926388; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jFWg+wLpnhRyJ9g/pQ4e8En95ese4kLgmfLugtU0GsA=;
 b=NcPBupmPhPatqsMrDVwhOtQDhCpDvvntb/s+nwy7nCJkxPSMekZ0mPzDvsrrW6XjYk
 b4PA2yKy/X+RNkHjd/CsAn34UcD2IoPlzi30N4GHfLnY/O1C0CkM9WOqvM7c2zFu6CtA
 Ef0TrlmaYc17F5xMLm7n54d8xyc5GXQIO4ZiahBsDehPEm8iTYXi/2nb7UrL5Gr9fiyz
 B3E+n4BKfGuEc9UuSjxOmmTiJvBB3gJPIaqISEKwYCGS4d4hiTPOjw4zj1Ct1kAMPsqv
 YTqaNXPR6YEusBTBlqEX1bxYD2yJOXcKGqFLhJh6oyeOAyG60Q+owuWTYNTsJooNuSsB
 Bl6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712321588; x=1712926388;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jFWg+wLpnhRyJ9g/pQ4e8En95ese4kLgmfLugtU0GsA=;
 b=qUnaoaWoxewDcwSFn3ioxkswmGHp8eQZLX+HWLN5/t+lVNyDTqQLGVNuc5ovQLACha
 q3kmtLG2lX9pqnjE+ALEa6wMDrcUBrav9lC6k8ZjO8qdfustCtqQejsWT9XBcjIDpF6f
 ZI/a1tHbKbdLMqZy+ES4HBfm16UbYho55mtSGvhnyl0zFoUJIwKS1jQhuas9auhdmH9V
 o8h2JmeupHvovNv5ggPHE6k23tDg8Y9KzNVYJPjVqZKDhNmDHohrnvH/qh0BLn+KP0uU
 CKiQQ7MmpbC0xriKncwqBqM8DCvsuMMuASm80V7yaOMdzwXfoDbLb66PGmf1be1QKC2p
 kU8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiutuaJiGjBy9miCPKCpJoftZ4j7QaWIaYNoH6WapUUVYvpjhkmBZgLo6K1i90KPB9ZfgAGr9iy6PkTJOWlJBCVi3oBW4=
X-Gm-Message-State: AOJu0YxVdJO0O+ajihnmy5D+v/gjcDpNIymHXNVnIxH6uHNg9gzztwk4
 qD219V/CS6QiF7F+MrF8ZVwENFhkyK/IUTgQBlj3WxpTMrVX8oCsrgBjNcGX6syQCRvQJC0P5HB
 Q
X-Google-Smtp-Source: AGHT+IES6jvMx0cOEUF8mndz6VitCsfOKUX+UWqH85oTCUtPFsbZg5kA3s3pDvoQ3+IROlVPhkwV9g==
X-Received: by 2002:a05:600c:5489:b0:415:46ef:8b6f with SMTP id
 iv9-20020a05600c548900b0041546ef8b6fmr1124863wmb.30.1712321588241; 
 Fri, 05 Apr 2024 05:53:08 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.216.34])
 by smtp.gmail.com with ESMTPSA id
 jd12-20020a05600c68cc00b0041468961233sm6232787wmb.35.2024.04.05.05.53.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Apr 2024 05:53:07 -0700 (PDT)
Message-ID: <bbf4b0ac-7bf3-4e7a-aab5-18d3684fbe3e@linaro.org>
Date: Fri, 5 Apr 2024 14:53:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 24/32] target/microblaze: Use translator_ldl
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: "Edgar E . Iglesias" <edgar.iglesias@gmail.com>
References: <20240405102459.462551-1-richard.henderson@linaro.org>
 <20240405102459.462551-25-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240405102459.462551-25-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 5/4/24 12:24, Richard Henderson wrote:
> Cc: Edgar E. Iglesias <edgar.iglesias@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/microblaze/translate.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


