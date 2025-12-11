Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8591D41D57
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 15:19:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTiRq-0002rn-5n; Thu, 11 Dec 2025 10:19:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vTiRX-0002kx-H6
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 10:19:01 -0500
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vTiRV-0002j1-Da
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 10:18:58 -0500
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7c77fc7c11bso180760a34.1
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 07:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765466336; x=1766071136; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=m1d5Y60NxBSfXIwKJ0HcBeCfMBbImq3x5hRkPLl0AHA=;
 b=ZWUrjgv1FP9vdbZAX/Zd9wC1Y+t6nKmsUphtN42tMZSkZI3V5HO6TOJMhqu9fcQyEC
 UXb+R5RDAdlSD9LrccimP8+4clQE5Iw3yNXMaSxh+XSSRH/jSV72ksUh4wTA5lXFdz4j
 OVc9mt6mXOr9mlVChpXPp25Z9Fiazyq+pQvAZmMC4mHFrGVWPcyZrdfwBkOcf2ZqXBek
 G2Kzpx8c520FdCLifqJM9IeB+jbwsdj98PECpLy6GgQ8qAvjnDfJZaB3U9l+ohOmUgwI
 +oRZVBC4waeiEW5bSrY8YLnwwzHCL12XePclZHVjKriG2ULR1GbfE8y8tTyvNxhq5R17
 tepQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765466336; x=1766071136;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m1d5Y60NxBSfXIwKJ0HcBeCfMBbImq3x5hRkPLl0AHA=;
 b=MO6kvqcj8R2sW/lKEQHZYQV/WnNpvdYoRfyCPMhQKD5fjFzpEhZE3q+mX/Flx/h/aO
 6y2N4lSpzUrw+fo444ZmBr3u2azaSEwEz7b9EzaWSxNgqaWJTDdpoy9gbjmZO5gJMcYh
 UvxKHlwR4Yvg2CeA4uVn1lR0bRjuLM0dFnUEgpA8MV8yOgaIi9IHXe0W2WbG+dEWPimM
 67DuuhXBdneSZnYVcNpCBtWL+5KmyZgVxZ4l/TST2j0GuTcjXpsiwYXF5nc2z0XeOjLM
 pfV/oHNC2Hy2jUT3j0KhH/2m0EDnEIJNttI6Jil4jrgNe4aoacI8jS6+HooyopscBhuf
 CoWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjOx/3MLS+mDWKplKCTHI0d51aIvyU5FTpNX2c/7bJX0UAwjkQiWsTxF5+eZnt4HNlSIMaLgo6QP1y@nongnu.org
X-Gm-Message-State: AOJu0YzSFknS0/Oj8fQaCL1SDj0WeOeFJq3Qb/cSsKH+kiY307q2lEn/
 dzvGenUu0DUgFHh2z5m5LSOY5T7NGOXDpePvgiVDB7C/tAl564La7wcp5pk5NGn6Ag8=
X-Gm-Gg: AY/fxX6+R7Kc7lrTe31w6bgmmUnoe9XHQs/Hof6Z5Bnh5tyZOVGF95sm4OWCvOApRoN
 5nG/1o9Y0Fp2VoTYR/RzncN/Y4JYQBdfRiOmMgcG+8M2fFX7NJnmizaOQZjmjhW21bDA6xmHLK3
 7mU9e4YA72YoLvJWNsxt/LxPzozJtc3xSP/AbYMHEAz7BmE2BQ6UCR8Y3lkCRRH7PF4PJ64lJMd
 EpKujEa/SeteK6Q/E+RAGS1KfCCl0Db5OoiIGHhYFlxGTa8Il0SyzIlSFFTZO4sjqR/9ZHKvEcw
 i7vcvptmpe+ANrjREHIXiGrn4KKjlSotUNS2JlHbkDD4ujC5bWWVNzOruBe4MktKLBLzN/dpDm5
 6jxdHjzZfRVGYDS5tyGiAdBxH3lK9YHvUboJrwSTmFl0xMjoEnwcZDGC3qav1jGJZF6fhagL1ax
 vx6n6Nyzg0B5UHajsEeHJT5i3o4Nhs++0AvJy6oS8snksTPVBKKe7EcspHTlvQHyILxIsg5yf81
 yY=
X-Google-Smtp-Source: AGHT+IEOkeW6EZdhDK/9dcz1vb58zLYXphcuvopIw3vmhkHPnEaaczRbJIhuIczniss+6fvipfw2Rw==
X-Received: by 2002:a05:6830:3153:b0:7c7:e3b:4860 with SMTP id
 46e09a7af769-7cadce5f25emr1233868a34.10.1765466335733; 
 Thu, 11 Dec 2025 07:18:55 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cadb365bb1sm1591791a34.31.2025.12.11.07.18.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Dec 2025 07:18:55 -0800 (PST)
Message-ID: <0c828790-8199-4a5b-8765-5ba626bae2a5@linaro.org>
Date: Thu, 11 Dec 2025 09:18:53 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] Drop TARGET_PHYS_ADDR_SPACE_BITS
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20251209-phys_addr-v1-0-c387f3e72d77@rev.ng>
 <20251209-phys_addr-v1-7-c387f3e72d77@rev.ng>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251209-phys_addr-v1-7-c387f3e72d77@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x335.google.com
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

On 12/9/25 07:56, Anton Johansson wrote:
> The macro is no longer in use and can safely be dropped.
> 
> Signed-off-by: Anton Johansson<anjo@rev.ng>
> ---
>   include/exec/cpu-defs.h       | 3 ---
>   include/exec/poison.h         | 2 --
>   target/alpha/cpu-param.h      | 3 ---
>   target/arm/cpu-param.h        | 2 --
>   target/avr/cpu-param.h        | 1 -
>   target/hexagon/cpu-param.h    | 1 -
>   target/hppa/cpu-param.h       | 2 --
>   target/i386/cpu-param.h       | 2 --
>   target/loongarch/cpu-param.h  | 1 -
>   target/m68k/cpu-param.h       | 1 -
>   target/microblaze/cpu-param.h | 2 --
>   target/mips/cpu-param.h       | 2 --
>   target/openrisc/cpu-param.h   | 1 -
>   target/ppc/cpu-param.h        | 7 -------
>   target/riscv/cpu-param.h      | 2 --
>   target/rx/cpu-param.h         | 1 -
>   target/s390x/cpu-param.h      | 1 -
>   target/sh4/cpu-param.h        | 1 -
>   target/sparc/cpu-param.h      | 2 --
>   target/tricore/cpu-param.h    | 1 -
>   target/xtensa/cpu-param.h     | 1 -
>   21 files changed, 39 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

