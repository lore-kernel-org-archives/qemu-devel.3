Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2759C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 16:08:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAWSb-0000XG-2S; Thu, 01 May 2025 12:08:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uAWPo-0005l6-JT
 for qemu-devel@nongnu.org; Thu, 01 May 2025 12:05:38 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uAWPh-0005gs-3V
 for qemu-devel@nongnu.org; Thu, 01 May 2025 12:05:32 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2279915e06eso12867075ad.1
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 09:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746115525; x=1746720325; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HQ9Qwt8p27DQA87QhA5+uAb1ZO2G4eLNiDIaMCg8dBs=;
 b=cMyQu+WGjNmGFH5H8aJtWlRRjUW0yH8k+l7GOmAWAYXdebLeUBvG5EJLO4aRg0DD33
 /uzzIg9r8Arb4og3DiKsuHSITlKaQJ1T5PtdGbfYh9hF1PRftXMakaJBApTWudN/CIkk
 dCw5svpTFls/IexQHsWYlIU8Z9DWT6R4SwOOtSscQ91nMCGsWKnoQwLPlwZ8EarONaZA
 JIXUFQVBr3BuUCi9uIp5H47ddlmlGmQIbaHI4EMPZzWVZdDxKoCzEf9OTC0nwKkdKSxZ
 kbSc8rkJ8NvyMHw6xsZ8QpfnFkEihLiqd9nDtgMIAktE8Nb8pdRLS1ZmHdjxUHcGpy2W
 5nPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746115525; x=1746720325;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HQ9Qwt8p27DQA87QhA5+uAb1ZO2G4eLNiDIaMCg8dBs=;
 b=gtQiYzrJLiREcINgdLOPfz7jxw4QIoUR5TYlnrYniZ1fmO2xMP9DqnI5xmFY+mEPaQ
 BWrqYjsh6r5mRrL81NjVpkfuCJaYaBYyxLNaMBLIzRmvBr6vdtLbv00oAiRz+ZVTLE4d
 +srXIX1/37jzMl4NN4HjmR0RW4Qgp5q7z8BYO0wbNtmzekUFtDwXXPKelSG8FV35bNde
 yjBI/dkzA56M5vMyuKGk4odWR+LQdBW5ShifkuZmxyjWiN0ecEDv9mC7q/12yc/vmcjE
 08u7Yvf0rbFGQSOr1XEfTfzv/cHg5DIFEGVl1ytaKh8aXK4wzrKofQrk0mN+KUhTo3Pg
 8joQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4KVsFao6Y6Q3DWpdHFC9YLPo276XXmberovGeuYKSSonAHzZF6pF6EyJwKonjLRQ9n+paS4oBqxUn@nongnu.org
X-Gm-Message-State: AOJu0YzyyzL4N6V+6dWS0KyNpYjfloaKGmLH1uFZYHW8o7YebgQ408hL
 bTTS+f9VM6pTLs64+L+yAPCFFN8Eo7t9pDuH5hwh+QNgGcDYAX2fvtRlR+yv87ONBvhhRYCItjV
 3
X-Gm-Gg: ASbGncv3hRKz1SUzDB0fcfh404QlNwiZHdQwVIS70vj81L31EcDgOiwxMW8SjZAMufA
 OISKERZ51iMWEluavDCj25IhV8G0XH983eobLo+X8zV6RLFyonUWRL0IL0/BPT7mQei3J4xKxY7
 beyd4OiTTFw+TQ1wpGvmMFDKhIavwIFmlodAP8LsWtYEf+EL+FE4U3zg2NxErx2sC57OPTceeZ7
 MOfls9Q//9t9Mxj/2SfYelPIv6EStRHISi93i3fZdFgAzm7802MkpLj0Iub6HrMmnwEfPkqVAh4
 MZeqeSM7C7sOND9xayA0Itb7kmj4eLjD0grqY27GXjc3kkGmzavEyuFItoUZ9+dh
X-Google-Smtp-Source: AGHT+IHWKh1V6koNax/qQ2Xkm6TBlZecUF1b80Tlwlvcm4v4F+3S443jdbGgc/eOXtUG71zXfXxXHA==
X-Received: by 2002:a17:903:2a87:b0:21f:988d:5756 with SMTP id
 d9443c01a7336-22e0422dd1dmr49015965ad.42.1746115524882; 
 Thu, 01 May 2025 09:05:24 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e0bb0d585sm8558645ad.59.2025.05.01.09.05.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 May 2025 09:05:24 -0700 (PDT)
Message-ID: <39e9026f-4ca7-4186-9262-c2ff4c4ea0b4@linaro.org>
Date: Thu, 1 May 2025 09:05:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] accel/tcg: Build user-exec.c once
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250501145520.2695073-1-richard.henderson@linaro.org>
 <20250501145520.2695073-12-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250501145520.2695073-12-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
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

On 5/1/25 7:55 AM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/user-exec.c | 5 ++---
>   accel/tcg/meson.build | 5 +----
>   2 files changed, 3 insertions(+), 7 deletions(-)

Yeah!

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

