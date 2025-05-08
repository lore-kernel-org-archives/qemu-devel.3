Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC28BC3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 12:19:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD0DY-0003GG-RA; Thu, 08 May 2025 08:19:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uD0DW-0003Fz-49
 for qemu-devel@nongnu.org; Thu, 08 May 2025 08:19:10 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uD0DU-0001zt-E8
 for qemu-devel@nongnu.org; Thu, 08 May 2025 08:19:09 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-73bf1cef6ceso974235b3a.0
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 05:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746706746; x=1747311546; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vneQPxpJlDDokGiIiyPtLhHxMJalMcA0+iSqBwt+LGw=;
 b=lxe611LVKa2XjjdDSHFqIYgB16jE04Bbn2UWnmva4BIjcYINErHdccuao2jl1hjo9b
 nPGafDa2o6p4MXo4/OIDE3GZyfJDW1SXIPs5J28OSlvw4i8S5IefZ+ZTvJvpGHbNAJZe
 ddbbKrceJEZxygQ3EYrqmL6OUlpIYgTxj7DQM/pEgpXnJaXuil4zOxYm1SG9IcCKquBS
 jX6r0O7MHsjbgS6Fr7y397oDYxF4tMwbBjVSNLltgMW0xchOJL2N+s0tWkU58pGDtj4s
 4muIEhnaQHVTUPP6p/Pre9gPXkuEtKXQUA1wmEN2wIopdoLvuFTCfQd5m0JDu4t/bL40
 89Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746706746; x=1747311546;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vneQPxpJlDDokGiIiyPtLhHxMJalMcA0+iSqBwt+LGw=;
 b=fGLsI4C9VqjTJsi2hqFo0LcJNs7AkYwt0/CIfOsVKvrILa7BKbT+H6E0gQRG6W3hLC
 b3cmmwwiFVtoDURWFHoZrznGlXuirkEITCX/zWT6yqnGNshozgUmflpPPirYe7aTqv8p
 xHgLauTlZ2pMMdZh5k8nPM9/a8p7ZiXZEP9588948X5zEiBdU0L5zhpsdilIDAPo+8C2
 gWeN4b+ozeVd8xixbrjr8WW+aqB1huzgnipwORPNn0wT2Nuip3Ang0z3oloKlettueec
 5pIaaiPltrruWCuSPpyRH/cnLNWR9+GM8OINS+x8HBJ7jOKAqB0CuxKi4xwJ/RuOIps9
 +vkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVajmPLbgHGKrMW4UfccBFMnpbZjQmvn/FASUfZKbIfIOqJAW/LC9uTTt8v78lem6L4MV26419AFOob@nongnu.org
X-Gm-Message-State: AOJu0Yx32RWcSkVy0XexcdyfIHinMr7JekNGWgIByAa360TFOCDoSexD
 EFSSUKLwX9HPJGeyatHrIb/DLewbwX5gUFikgRZw1h2jUIiJ7f7cKdDbQh95exk=
X-Gm-Gg: ASbGncvLbQt8dSbmCg4HzFxuXnBuv2mSYZ6mPuCXS/S1tSa8JUS3X3Dfw9o7cWJAW2L
 eCkcUX4IMdaXboGo6qCxvlsSm8qRsiPvh10Av0F+lFDOkxSwLavLHkS6N2757VgcJg4dE40ptb8
 JjeclidQfTbwriJs5AkGj0rmFd7izxEAoy4Ibkv5KYKXhjWj2EOAFEyJWVIJcGx6N+Vz6PuUjvv
 o3cjAMVGv8dQ83n4TDBgF3mlzBdsTV2RBl3RLMHrKBZj5dL+PWB0zzBNTgXHtBAVaenTMzIEtzz
 POmZBOPgWFZSUy3i9TSI9c1Fj115HMh6Pri9+sDJheUHJ/NWCstQZES9gTIytcE5ex2so73I17O
 2L+iN6J5d
X-Google-Smtp-Source: AGHT+IEK1b8V6FcPHKhSRwC5GSZwbCidJEV3gjMZFWX35jytS1ath+i2nKLdYjCvPCZTjBMBFzRj9Q==
X-Received: by 2002:a05:6a00:2905:b0:740:9a4b:fb2a with SMTP id
 d2e1a72fcca58-7409cfea3camr10489274b3a.20.1746706746399; 
 Thu, 08 May 2025 05:19:06 -0700 (PDT)
Received: from [192.168.69.244] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7405905ce9fsm13599041b3a.136.2025.05.08.05.19.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 May 2025 05:19:05 -0700 (PDT)
Message-ID: <df5c04b4-f5a7-4e54-b4aa-12ad3f37267d@linaro.org>
Date: Thu, 8 May 2025 14:18:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bsd-user: add option to enable plugins
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, richard.henderson@linaro.org,
 alex.bennee@linaro.org, Kyle Evans <kevans@freebsd.org>
References: <20250331234228.3475706-1-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250331234228.3475706-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-pf1-x434.google.com
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

On 1/4/25 01:42, Pierrick Bouvier wrote:
> Nothing prevent plugins to be enabled on this platform for user
> binaries, only the option in the driver is missing.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   bsd-user/main.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)

Patch queued, thanks.

