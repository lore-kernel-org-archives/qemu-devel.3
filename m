Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D86AD1D892
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 08:47:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vR4zI-0001Vu-9E; Thu, 04 Dec 2025 03:46:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vR4z8-0001Uq-FK
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 03:46:47 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vR4z6-0007ta-4e
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 03:46:46 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-47795f6f5c0so4210695e9.1
 for <qemu-devel@nongnu.org>; Thu, 04 Dec 2025 00:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764838001; x=1765442801; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=byC/O7uvQ3QfQ+BYrKViM2qHfaZmZPPE131X2B71AS4=;
 b=ZIyj3IB4TPHG/oTxtKE0LRXtMncw+vA7ZOceJKD2i/05MNNe7TX2WLAd12xGBuGBis
 bvbyy0upuqXHMJG3Ci0uLkNpSVj82Ual5BtzJu1dIuCdMmfxgTnKUKi4HGmIhfx293rl
 QSjT3SSeft2EJwLvulcfsXpSV8dMrXgt4L1ben4i8lROoZ3phw5bF0QR37/NNBE0DXeS
 8+GHzWMk+bH70Frd9gseEknDjgYH3UFxU/fvk2n9nl9dCIRysyHafeXGm2vLtCtW+rZ+
 HSAdS5Mo+wFaoL2qwqy5bHW4UOAaAZivQbT9A2AydDUF2C6kZPJwqoSyLaeAH8SkHWrg
 4czA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764838001; x=1765442801;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=byC/O7uvQ3QfQ+BYrKViM2qHfaZmZPPE131X2B71AS4=;
 b=NfZLzA7tb6INjSW6rzOu0Yk2IfluwjAPOwahK/31+A/Sih0GOFIwKoG3AZKu0ZkVsb
 ArRvGWd72028CnIcXo+c0mgInYN+QUeFKktYdxaluwV+aO/uZVnJCLPH5bP0gay0pEb1
 geSNsEcVVh5jHnQuZDwxxpNIH9y4TT0eSBP1BHv24sXk24nDt6qmdOpVbn6H2J2YKn+X
 rXUUWxedI8qWHHsMY6xHbGFyhikSFfpSxAft81CncO3F7g3WvDJVGQONlijVZ4jdpWFB
 rXqtWJCx23ooWt8uysO9TiIQFdylu+OMh8wgNn7j2LSgCX1ENtnx1nUKDIng+N+NU+wU
 OStw==
X-Gm-Message-State: AOJu0YzFpzOQ/tkWrEMQU0mzKTZDQ0GdP9ORPmi5esvUkHKFyGzjZfRo
 PuF04fV8HBQWS/GUhQRjW0rJb6LDcJVXMPAgQAR6yAg6MqhVdxy1Xx/7nvc52AzkBu4=
X-Gm-Gg: ASbGncu13tMjaMeaSyQIqHxttiUZGNP+RQ9IWrIli1gCd/O4T9tmDBOBaEYW/1LUUGj
 ke1ziJvzsZ71jfxh35/RRu1rgx1PgX51uAuwNTg4pwTyUu6OZx1gbklGuYoTDb+tjIbIMqbAKWd
 rJ0QmouA303Ati/9nFpXQWJ872Ose934Bf5yUj2hpXk+1N+2rx3H1UHsyj39cNicVkwaAw5AiL9
 CvdFADsKV79OU/cuE8nSRvOjhCr5y7FTztvqPZTKXhj061lcjq07S1ZgkgUZ6xrBG3r0V4iYCO9
 QwcedX3fB5+5sPO2UT6uPxSHsqcoYSEdjHpJMP35Amz7Rc31kymtBlFXMrtU/zEbtEfJhNwBGrf
 6YBYYsuzSd/u6Zf3l+xWxv/WUVFL5+HX6CbuwY3zzobNjWKXl7Elg6A68rvu5vR7AAAOA/dSzbs
 P3FzB2DyvPncYyWWMerbE4ffNIdoKXY31EX2uW5bTicRfR2AC7lE9DIw==
X-Google-Smtp-Source: AGHT+IEaRn5nhvLV+puId7fa/atVZmEQPs0KIab2tcOhVRPOR48xBvjSBbpfJ/m7gKn+Wp8iIgdjkw==
X-Received: by 2002:a5d:5f93:0:b0:42b:3ab7:b8b8 with SMTP id
 ffacd0b85a97d-42f731870f9mr5547891f8f.25.1764838001220; 
 Thu, 04 Dec 2025 00:46:41 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7d330b20sm1826044f8f.29.2025.12.04.00.46.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Dec 2025 00:46:40 -0800 (PST)
Message-ID: <6ea77767-5442-4868-b9e6-8633a15c5c9b@linaro.org>
Date: Thu, 4 Dec 2025 09:46:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Clean up end-of-instruction processing
Content-Language: en-US
To: Taylor Simpson <ltaylorsimpson@gmail.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, ale@rev.ng, anjo@rev.ng
References: <20251114230013.158098-1-ltaylorsimpson@gmail.com>
 <d3323b18-5822-431e-aad6-cbe4470d1a2d@linaro.org>
 <CAEqNhNYCUwK6UDXKSONA67yfmLPaSt14gtgrK26AfAQqyBopTg@mail.gmail.com>
 <CAATN3Nps8qxYPBHxM6NfP6qt+NSNHzhiC_C-tuK796rQG+qbAQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAATN3Nps8qxYPBHxM6NfP6qt+NSNHzhiC_C-tuK796rQG+qbAQ@mail.gmail.com>
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

On 17/11/25 19:35, Taylor Simpson wrote:
> 
> They are based on this one
> commit bc831f37398b51dfe65d99a67bcff9352f84a9d2 (origin/staging, origin/ 
> master, origin/HEAD)
> Merge: 76929d6117 7dbe2d7df0
> Author: Richard Henderson <richard.henderson@linaro.org 
> <mailto:richard.henderson@linaro.org>>
> Date:   Tue Oct 28 11:48:05 2025 +0100
> 
> They also apply cleanly to Brian's hex-next-express branch.
> 
> What error are you getting on your end?

Maybe I did something wrong and was based I don't remember where =)

No more issue, sorry for the noise!

> 
> Thanks,
> Taylor
> 
> 
> On Mon, Nov 17, 2025 at 10:08 AM Brian Cain <brian.cain@oss.qualcomm.com 
> <mailto:brian.cain@oss.qualcomm.com>> wrote:
> 
>     Maybe they're based on the other commits on my tree which are queued
>     for inclusion after 10.2? https://github.com/quic/qemu/commits/hex-
>     next-express/ <https://github.com/quic/qemu/commits/hex-next-express/>
> 


