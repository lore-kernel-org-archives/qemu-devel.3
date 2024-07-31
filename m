Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16E1AC3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 01:19:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYxzM-0001lN-OU; Tue, 30 Jul 2024 21:18:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYxzK-0001kD-UH
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 21:18:46 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYxzJ-0004AE-3n
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 21:18:46 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7104f93a20eso16901b3a.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 18:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722388723; x=1722993523; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=azBpmjAa783JAc7v2vCMZZKKjmYPeP0KQBXELmqRQkc=;
 b=AbC7360+Yy4VXKxb+gyHpzlm8BnUrVBTK3qqAJcjpREfCp/AsFQEepWzDriOnSautJ
 VBiwljYn/duYrhl8Ejrhkqc1jt+HSG2aF50kZhHX30zj5ljW5Tcb6HfWMC3ZFFZgGKJa
 yGmWiORdIWKD40+yRSYDqr61DjmASXuU9T0XFYatrWhDxrwnCSDVVR41WdP5lDy4v5mW
 ff0Bn8GQsjjLqLjmQz0FNRhnKwb/vgtd8cQseblzFgs6Tisb7zPApT6NYtReEEiF4q3y
 StooUPphmg1d1GvE7FPw0o37ZbW6RVfxVNX7xJkaIVJ6Tnu4Fy7glyj5vHDZpNTEcBPX
 Iy0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722388723; x=1722993523;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=azBpmjAa783JAc7v2vCMZZKKjmYPeP0KQBXELmqRQkc=;
 b=AA3rF/oD723m9JQ+VIfl2xfz0y5kpb5Op2P98hjpnW63TWijoB0GSn/s9MVCgKkFQy
 0/GkobJHW+YybhvLAort+rs07ulfQEvgYlr+mwAq+xJPrtqVyj1NoYCv03Hh2DiSpfJ7
 Ls6+LWew7crwUAMy6vyAtAnoWjnVpefSHZLpMbvinftehbDQqczcU1yCpEXfy4MvGxxH
 VnX5IGj2YciYTDMIYHWp6fTeko8eRGrVeD7SX+X8k7MpAKGQTBa/awdeoaK5aTI/ETwq
 sJ9VI+e5RMZOKCo5zgEMpJnysQ15RhcrTxwIwzxqhq7QLMFmNk8iRYpYpRhvNB2hBu3p
 TFDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVKlEFvnOI9Vkdsp8/4g1kPVnUAvSdqMOMb2YTB4aEuy6wMhia569Wq8JftfunGTQLxIEk+DvxwUIeUakrD6WgsgOLCtM=
X-Gm-Message-State: AOJu0Yzh0GtaziNbxVaHYbgStV7mznjpC0JDgu1OdfmA0hQany66R74K
 0lGp7UhlQGIsHVimkf6qe07I99jeKKcmZaqBqogjArVNT3avv5mu4UJp/MxLrdM=
X-Google-Smtp-Source: AGHT+IENSSxhRiodfgfyLHnMWE/V53jE8h4X3jUnSsZMQLpdYNMlOblWJ4ggMeEEManxBv93Hqu4mA==
X-Received: by 2002:a05:6a21:150c:b0:1c4:2324:737a with SMTP id
 adf61e73a8af0-1c4a0e0c484mr10869325637.0.1722388722912; 
 Tue, 30 Jul 2024 18:18:42 -0700 (PDT)
Received: from ?IPV6:2403:580a:f89b:0:7406:659b:9ac8:69bb?
 (2403-580a-f89b-0-7406-659b-9ac8-69bb.ip6.aussiebb.net.
 [2403:580a:f89b:0:7406:659b:9ac8:69bb])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fed7cf6fbesm109625545ad.88.2024.07.30.18.18.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jul 2024 18:18:42 -0700 (PDT)
Message-ID: <4cb0b5ba-d4bb-4491-af3d-420f99aab399@linaro.org>
Date: Wed, 31 Jul 2024 11:18:37 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/21] target-arm queue
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20240730094020.2758637-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240730094020.2758637-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 7/30/24 19:39, Peter Maydell wrote:
> Arm pullreq: these are all bugfixes. I've included a handful
> of my fixes for various non-arm minor Coverity issues too.
> 
> thanks
> -- PMM
> 
> The following changes since commit 93b799fafd9170da3a79a533ea6f73a18de82e22:
> 
>    Merge tag 'pull-ppc-for-9.1-2-20240726-1' ofhttps://gitlab.com/npiggin/qemu into staging (2024-07-26 15:10:45 +1000)
> 
> are available in the Git repository at:
> 
>    https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20240730
> 
> for you to fetch changes up to 73188068d7ba40c8a37b4763db38bb1ce24ca07d:
> 
>    system/physmem: Where we assume we have a RAM MR, assert it (2024-07-29 17:03:35 +0100)
> 
> ----------------------------------------------------------------
> target-arm queue:
>   * hw/char/bcm2835_aux: Fix assert when receive FIFO fills up
>   * hw/arm/smmuv3: Assert input to oas2bits() is valid
>   * target/arm/kvm: Set PMU for host only when available
>   * target/arm/kvm: Do not silently remove PMU
>   * hvf: arm: Properly disable PMU
>   * hvf: arm: Do not advance PC when raising an exception
>   * hw/misc/bcm2835_property: several minor bugfixes
>   * target/arm: Don't assert for 128-bit tile accesses when SVL is 128
>   * target/arm: Fix UMOPA/UMOPS of 16-bit values
>   * target/arm: Ignore SMCR_EL2.LEN and SVCR_EL2.LEN if EL2 is not enabled
>   * system/physmem: Where we assume we have a RAM MR, assert it
>   * sh4, i386, m68k, xtensa, tricore, arm: fix minor Coverity issues

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.

r~

