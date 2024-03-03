Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB728C5478C
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Mar 2024 02:30:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgbcW-000050-MS; Sat, 02 Mar 2024 21:30:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgbcF-0008Tz-Lr
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 21:30:15 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgbcE-0006aB-7c
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 21:30:15 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1d94b222a3aso35521915ad.2
 for <qemu-devel@nongnu.org>; Sat, 02 Mar 2024 18:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709433013; x=1710037813; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oPxjqm/nrwBz4yHMdy3StCwtla3bd9mq8OZRdUGqSnM=;
 b=F9yt/JSkE94/UzR9k4D9myynIyup6DCkBLNUmHd/Lwa3pcyrcvKGVu6IQ4EZLNt7ev
 MIOneQbPA4kTzKXjaHaz3gvZFKKTI9HcF8HSe05kny/s9KLLTzgZmvQwpOI1jxFROiMi
 8lK0Y7kYjzGpXt4Tm21r2rOIqDx3BZVWWGowRsvF6NnEuzHQP08IVVmmkgYGJKBDhnLd
 ptMWLRi7mUrnzQIlf2UKBd4ZQ7U+ZomdYohXE/Iy9inmM1TFmN8VhBzlzKHN4OENs53g
 p5viANTRp8cLT+Jjg1MQMbyjDzWX/dZmW5DvVp2k+Xs4Lo4czhqpQLtMXx8eH0e8aCgB
 /jXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709433013; x=1710037813;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oPxjqm/nrwBz4yHMdy3StCwtla3bd9mq8OZRdUGqSnM=;
 b=YvxS2+K1vQnjaMAaUgCvh7s+NsAgO6g6WyE46CFlKDnqpr41bNaeU2oC9pTTlHgzsN
 3/7VAdWPnKIOngKUUrykRuZhqNSUyKC+Vx5iySCMLV2+iKLWCcAgAHt0QiTEMARiI8Ww
 eIQ2MC/eM9If9EEAPm4dQeq30z1V7mVeLqP4iDFHQGHeouP0B2ymFO5k94bNuGwIpOoh
 nYT6Ar3ehmoON9MK4rPglBzjrX335PnNmbuE7PycI4eD+CrLLJbfY+gYGQ5TjcBgOYIU
 jh9rAuji1JpDjBISXqg8MjYWGENH7RT8LsX3MZHzX3Niw0gUPXZnkOdqMxXDVt5jcvxz
 IBYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV83jag0HT9E1QU9s8UdjGX/A6UQtOWdOclTdnyULsbYoef6WLWy54p83dxOuRfn40QSpr10sgn+XhQwuGI2vhxPr/YfKc=
X-Gm-Message-State: AOJu0YxiqKoQu4dTIiafdBfYmQuLoWVqp86W0f0yyb+h9/UOmUV9aG2G
 cqiI3CdSs8Qw/mjnK7WBYIog5eKFvP1NidZcE45x7EhmF3LHMTG4fG/FiPK4o42lK/QDvgMwrYP
 T
X-Google-Smtp-Source: AGHT+IGTWUZmJ6bmlTIQKzbSrZEAxQ4weQgYn8FMek4wfYvsenewGsujXJ/As9AQdnPg7aGXYiNqnw==
X-Received: by 2002:a17:902:a3cc:b0:1dc:794e:27b2 with SMTP id
 q12-20020a170902a3cc00b001dc794e27b2mr6058959plb.56.1709433012903; 
 Sat, 02 Mar 2024 18:30:12 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 p6-20020a170902b08600b001dc30f13e6asm5827636plr.137.2024.03.02.18.30.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 02 Mar 2024 18:30:12 -0800 (PST)
Message-ID: <9d259d41-8f89-4173-ab0d-d44b0cfe8698@linaro.org>
Date: Sat, 2 Mar 2024 16:30:10 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] roms/hppa: Add build rules for hppa-firmware
Content-Language: en-US
To: deller@kernel.org, qemu-devel@nongnu.org
Cc: deller@gmx.de
References: <20240302223524.24421-1-deller@kernel.org>
 <20240302223524.24421-6-deller@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240302223524.24421-6-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 3/2/24 12:35, deller@kernel.org wrote:
> From: Helge Deller<deller@gmx.de>
> 
> Signed-off-by: Helge Deller<deller@gmx.de>
> Suggested-by: Michael Tokarev<mjt@tls.msk.ru>
> ---
>   roms/Makefile | 7 +++++++
>   1 file changed, 7 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

