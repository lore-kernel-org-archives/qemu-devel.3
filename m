Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 161EED232FC
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 09:12:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve8Xc-000172-Je; Fri, 09 Jan 2026 04:12:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ve8Xa-0000tc-Pq
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 04:12:18 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ve8XZ-0000Qy-0F
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 04:12:18 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-477a219dbcaso32845495e9.3
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 01:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767949934; x=1768554734; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lHNUKZWYlEWLqhYJoTVDVMRcI//8NdIsRHOApThBdqk=;
 b=r/JXlTg4qd25BrBvFJUimqTeX5FHMyI59gAvKmmwbyFhzMo4ztDQLxWAxjJ3cp/MaI
 JELs3d3ZkvX2XsbZ9dvuJ7TK3w7oaI0bBLoOIZpfdNyBcNg+rRB+NiuxSSYRfAvLwjvH
 m0dIGSsJ+vtTk1xJaytUYHg4ADkaBMOhF2Fn3rVqcB5lKkq0gyblfMxewF4Wizwmxl7q
 65r/we/ZoMA0ZPEnvx6gSlPWYjpPx8mEnMxDZC0xUEeuehMutwJN8Hf+XQH/J9OG3zrW
 +9Qcr8OvIn4++zzuC+a2Stgm/ln8K9BZAl1RjFx141skvmd9jrRuWxrUZ3NJHzSeYyo1
 BwYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767949934; x=1768554734;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lHNUKZWYlEWLqhYJoTVDVMRcI//8NdIsRHOApThBdqk=;
 b=Rx7vQgjLIuv8zm2J/q+kcK4HFaNgrj16wD2mMR0SM1IaMcUnKxQe3Fmm1OlLZyViou
 +u7XrMJ6WIECKWoIU4EsxQ9nQMR95wkn16/ePpyxjFkhrHprYnOVQ6FNwUvqEwlbVgQT
 2t3JqmGz/j3s5FQeIbDHar8pRndHIhbRtEi6+vPtSKme7Y9emIjeYXbAgr8YVY5M7HoK
 bAThvYOd5d0LFic6cN6S2PZ71CvODyJlJUqOfOr3RO0KsAYVeH1N8lw1RI/3/exMbu4N
 YlMBkyCruPSRCm3wnjpLD7lbO6V0+9nkyLo3NdkHYOXfSYSK7kjgUh9Py8VNZrZhkUjs
 eOIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+AXxz7uDmQ/lLWn695U8JBnxqfDHEv3rSC8oZGP0pUIRc172wowBuiN73JJXEsES9xts0yw/PhHeH@nongnu.org
X-Gm-Message-State: AOJu0YwknlUvq3OCbPXzG6c/BXZoNj4qxTvfVHo3z1uSuuPtCR0GzLFg
 BddhY6qns9k4meHiGOD4vgoifX37nZSAa3p2nYbZI5aKn3O7u+qx/y4K6g2i5e6bJImvnicec36
 KVlzkUTE=
X-Gm-Gg: AY/fxX6W7V/0w+ShUmI8oTV8Nt8UinRyZcsiFn1Pz159gsoCdwRhVEYC7UGRkQni1sW
 nVpyc4VXobmP36J703pOcUv11QqFfpnJzC5YpIVNorE2/lKgWTv3lMNBUjw5LmFXP9/PRR5uACx
 A2rwg486hxYxbWboV68DkInLXwYm97aL5YHWK8tfGWsye3NRHtpx2gwCtAP2Vv+3Eohawd6zIzZ
 9Re+opk+905hqqdqEb3FMR1kQYYFA+hadMmEweVFoFYD4sV6jBMPVz90s/0yFBy5P1hvVs27hZQ
 nVPIAZL2HNx/ZkhrvCllBvFsJtv+Fki5jl9J8p5IWhaX3D54IgsSTMivGdlQS8vttKpQGpuSghb
 Hy6pa5G3adRe/GLYHRPEvnIsIriMi+f9UtGIAgXjjEiBNU27tWM5y6jYcLmWipC3T5OKFJUvRXM
 Vh7fKEgpydeHG35BlEk6D6WdQA5v5i60FX6I7CBP8avVs63p3Yh1kXmg==
X-Google-Smtp-Source: AGHT+IEtvvvD5eeJGDf/TXQU5jVAa5R9fSQE9gjTJ4jp8YSiiSyTLaSmfMrrjaugTrmxZxM4vyYpfA==
X-Received: by 2002:a05:600c:4443:b0:477:755b:5587 with SMTP id
 5b1f17b1804b1-47d84b0aad1mr103759605e9.8.1767949934509; 
 Fri, 09 Jan 2026 01:12:14 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f7053f5sm193266275e9.14.2026.01.09.01.12.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 01:12:14 -0800 (PST)
Message-ID: <88877e28-57d0-4bd2-89fa-47516478b690@linaro.org>
Date: Fri, 9 Jan 2026 10:12:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] linux-user: cleanup epoll_pwait ifdeff'ery
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
References: <20260109090937.599881-1-mjt@tls.msk.ru>
 <20260109090937.599881-2-mjt@tls.msk.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260109090937.599881-2-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 9/1/26 10:09, Michael Tokarev wrote:
> All linux targets these days have epoll_pwait system call
> (while some miss epoll_wait, which is less generic).  And
> all linux targets definitely has one or another epoll_*wait*

s/has/have/?

> system call - so whole code block dealing with this system
> call should always be present.
> 
> Remove the now-unneeded ifdef'fery.
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>   linux-user/syscall.c | 8 +-------
>   1 file changed, 1 insertion(+), 7 deletions(-)


