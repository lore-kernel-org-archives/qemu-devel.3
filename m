Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDCC5C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 19:34:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxB2W-0004zq-QJ; Wed, 17 Apr 2024 15:33:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rxB2U-0004yS-LI
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 15:33:50 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rxB2T-00033f-4k
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 15:33:50 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6ecec796323so150735b3a.3
 for <qemu-devel@nongnu.org>; Wed, 17 Apr 2024 12:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713382427; x=1713987227; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=25MscXAdIly07T/fJANdiEI24luDKo3UrL7pMCJEuZQ=;
 b=MIbzwYqGUUlqIYPpVqMXknbQ0hpgMU2sudBz6YiA1NND1os5rl6/M9WFeruPqeMB9Z
 dmmnbHt1I6pwBEW5lCUIj+grSiTn3rV3/Lj6vKW5cFEXib2y3j8m9MP6wFytNtrTJvEF
 cPNBG5JNPpvDveeXEiDliVpzsb0bMROc+P+9l4HNzgNSkV80KVR8Etgjezqm8z5Pq6pT
 dDl1ju6SyqLV71qWAeZSyUDz0yIg8HNQx7ijfwz/eQVyJuPWsJVQMxGRKPBIGaWsn0Gl
 j7AvunShWftaE1i5MGOUFV0vn2piJrDWspuB+c6dHQ4/by80sdj64n/seXBW7oCIh4N7
 xAQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713382427; x=1713987227;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=25MscXAdIly07T/fJANdiEI24luDKo3UrL7pMCJEuZQ=;
 b=fZ9RVsHTPuAvxdp1KNNFIJFQV6Wnx+Dd3ZFIoZpm4Kyluz66JI54u81dEblqZf7DkL
 1nSLbZdyQAglLOtRfhwUSGiuIp7Wp1uVx0nnpCILHAjvciLuWl6Gzygc2h2IZhqHSfOD
 4W9YI2cv9TZPQAS5+lxmBIaD7bvE+184KzpRrB3lwiCgwpuqlhb9ooUHSMeira5EiuPM
 9u96fRhvS7qW8JXaidhny10HNW6u7VwrOdcy5PWMcbdyCRkr197IeQROxQz74lIYzbM3
 VEXLaMNZnVy2qYBhRt+dMYNH/ZIM3Bn530OAOT40WwV7QRURAAV3L933MlRcpPWY23IH
 6p0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5H876ge8NSKRaW/AoYtgFKp+HUb755x6oR1rcDx38lfVcj/v6fPNfxfp7SIWMUnrFPCNLTkJ0Yf61WWdCynJb2aJHNTc=
X-Gm-Message-State: AOJu0Yzvth33YJx+QtKPCJUDZ2VdzKRGKB2Ohy+sQlWAOI6pmG53Nqj3
 0tKtJqPQzPCzdAK+lc8RCMugND2c/VmMBsnF2VDQVAFbi2AI6QMtrT3lypomF3Q=
X-Google-Smtp-Source: AGHT+IFWN5yjrpu6VYtfelsufQNBcJYr8aHM9GO9r+tuAa4bdy+ecCRfe1ZIKE29M2Z7C/sGZBWLBA==
X-Received: by 2002:a05:6300:808a:b0:1a7:7d2f:6c01 with SMTP id
 ap10-20020a056300808a00b001a77d2f6c01mr718586pzc.48.1713382427069; 
 Wed, 17 Apr 2024 12:33:47 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 4-20020a056a00070400b006eab9ef5d4esm24705pfl.50.2024.04.17.12.33.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Apr 2024 12:33:46 -0700 (PDT)
Message-ID: <b5d98d4a-f2b5-419e-9768-5296208d1720@linaro.org>
Date: Wed, 17 Apr 2024 12:33:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/21] exec: Move [b]tswapl() declarations to
 'exec/user/tswap-target.h'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
References: <20240417182806.69446-1-philmd@linaro.org>
 <20240417182806.69446-20-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240417182806.69446-20-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

On 4/17/24 11:28, Philippe Mathieu-Daudé wrote:
> tswapl() and bswaptls() are target-dependent and only used
> by user emulation. Move their definitions to a new header:
> "exec/user/tswap-target.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Anton Johansson<anjo@rev.ng>
> Message-Id:<20231212123401.37493-17-philmd@linaro.org>
> ---
>   MAINTAINERS                        |  1 +
>   bsd-user/freebsd/target_os_elf.h   |  1 +
>   bsd-user/freebsd/target_os_stack.h |  1 +
>   bsd-user/netbsd/target_os_elf.h    |  1 +
>   bsd-user/openbsd/target_os_elf.h   |  1 +
>   include/exec/cpu-all.h             |  8 --------
>   include/exec/user/abitypes.h       |  1 +
>   include/user/tswap-target.h        | 22 ++++++++++++++++++++++
>   bsd-user/signal.c                  |  1 +
>   bsd-user/strace.c                  |  1 +
>   linux-user/elfload.c               |  1 +
>   linux-user/i386/signal.c           |  1 +
>   linux-user/ppc/signal.c            |  1 +
>   13 files changed, 33 insertions(+), 8 deletions(-)
>   create mode 100644 include/user/tswap-target.h

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

