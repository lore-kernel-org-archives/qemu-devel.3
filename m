Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 357DDC3ABAA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 16:14:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAt0y-0006Ws-CR; Fri, 02 May 2025 12:13:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uAt0u-0006WO-0i
 for qemu-devel@nongnu.org; Fri, 02 May 2025 12:13:24 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uAt0q-0002IM-U5
 for qemu-devel@nongnu.org; Fri, 02 May 2025 12:13:22 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-736aa9d0f2aso3174193b3a.0
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 09:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746202399; x=1746807199; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wXEUlTRcnhe1HcrsomLd2HTF9lYmi8YpwQzWpH5iy2A=;
 b=CtIRRczqGi+m4mMYN0KJ62Tc8ZCeA6aZjD7KbAYEbMBF+tWvgPqx8W4/0V3zYMBnav
 xdAzPkzOoMWXf4zYyBVf9YHwbhaJ/ZVCnltd62koJU6l1eyunEry1X5I1kfr4D3lz3Po
 eh38yt5x3dlaetFA0frcKEuv0KBEkqauGcX4oRAaSJxhZicOtFSAxle+i048hUXGK3tc
 oLk4HZAFFmJ9K+CjzppwzM3+iddYbzS8ii7F2g42qd/AN8hy/TeXtFwfchuavs2gsaW1
 6B5fYTiWvctc0S2CmiZtLPMmK0ZNggFCklEjFGkecQSClS+Mr2vkjgFJXxG1rZv6CvH4
 9UiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746202399; x=1746807199;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wXEUlTRcnhe1HcrsomLd2HTF9lYmi8YpwQzWpH5iy2A=;
 b=PDG19Qdn4ZYHg2AqS4uWMieVZvkyjIWgBNcMLq8ztdMnlxkw0Kbam3yDYZ2gC4qrBT
 L4Ke8jRTsBj47IeenNQ+DYqtZ3EKg5qxE0ZKbBUdwxDik4VUf6aSqm07W+tGuH3WGu9B
 U8T2A7v3i0ywgwv14DpZWGfYd5lT7owg0uKf8JA+i7hDfm98/UzuOaf2oCJwH0B82lEo
 BAJy+TbrfzMiRAkEdii1z9dCm1WdDwKUwVLHspmKsXW8QxNz+wCAbnW0Ce9aPZ8jXRNe
 n0KjmOG+CKslGEKq8n6izytJiKh6y197GdOj0rFJm8vX2jjkytgWK3e5yYcxEy3Qa6fO
 zTSA==
X-Gm-Message-State: AOJu0YylxZlptCJlQLOrUsrAvhOjdrjZELjv4sbIhRnoBiakTG5E47UH
 BlwmcqDQnHkD61hbi2Xkm4/U3ZtX15Hc1hcW+otX0vRKt0ek+PdY4b6C+IYLOP8=
X-Gm-Gg: ASbGncsTSQdC20wj3ADyS5d8YG23BZqlzd56gYzRRntyyH3ZR3GqTYUBzwThZzwZZXO
 +bapJZViRQPGw93B8GBydsYWBVvDAyvs6Q8MJ2qXjZwiTFXlx0wiTh5Mwi5Lbj4B9f9KCtebOpj
 DxAgMSIx3nD0CUP6fxNdr0gtx8urdFovKZ0vAQx9nZ2uwp9dlXbtjnteG2HF97LK2O9qC3N4kNd
 UanehUxR60KwAvDLVtD1yUo4gj6FIHE010C/eYEAi9EXFrf7nXMOHK3EaMmnTtX+isOl1m91MpQ
 gHPIfoQFhJ8Q2vSGgDN2VPUNHqTf6nxjadGNgHiW5v87eLX3yZMCuw==
X-Google-Smtp-Source: AGHT+IE37k9QAdxJxApNWGXISr8wxzIX29NjEHn/d4ixWkIpY+SoYa8IBivUo7zM3LfIVL5gmhNwCQ==
X-Received: by 2002:a05:6a00:8c04:b0:736:457b:9858 with SMTP id
 d2e1a72fcca58-74058a188d7mr4597030b3a.10.1746202398661; 
 Fri, 02 May 2025 09:13:18 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74058d7a397sm1765156b3a.28.2025.05.02.09.13.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 May 2025 09:13:18 -0700 (PDT)
Message-ID: <8900b336-6d2c-47d0-9054-e6648a5f9294@linaro.org>
Date: Fri, 2 May 2025 09:13:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] target/arm: fix arm_cpu_get_phys_page_attrs_debug
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, philmd@linaro.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Yannis Bolliger <yannis.bolliger@protonmail.com>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20250414153027.1486719-1-pierrick.bouvier@linaro.org>
 <21843e8d-cdbc-4f84-a652-01ee467f2dc7@linaro.org>
 <CAFEAcA8cBUc_iJCA_D6ZDsJad75Rmad6xDz34FPXWrnyEhk4tg@mail.gmail.com>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <CAFEAcA8cBUc_iJCA_D6ZDsJad75Rmad6xDz34FPXWrnyEhk4tg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42e.google.com
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

On 5/2/25 6:05 AM, Peter Maydell wrote:
> 
> I've queued this series to target-arm.next; thanks.
> 
> -- PMM

Thank you Peter :)

