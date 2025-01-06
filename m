Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 415CAE77188
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 21:27:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUud4-0000gA-4z; Mon, 06 Jan 2025 16:27:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tUucz-0000fz-HA
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 16:27:14 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tUucx-0003Yh-T9
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 16:27:13 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-436249df846so102945165e9.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2025 13:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736198830; x=1736803630; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SSiNQ8sqWZB4cPwLp3TA7EvESDV1v64f7n14KvOaGXE=;
 b=hoFwbrHX7LvBYayWcO0z1AO+WoYL37JVQrrpFqO9CGzq5fQuEe0hNgzm5qBSCX9my4
 x/V+tbJaYX0d6i+YK7y/AZGhxhbPU4QZopC2fMGwp3844m4z1o539oJ/L3FMk1Ob00Af
 dCINfzyjJx2F4bJ89ZFLU7ipWIbJ5PsSyjIc/qoFCG9++0v1QAMo8iaJQRMF7iPU/X01
 uOInYK1+2YQNhyEHwjMUM2c43wgLsHYWYCNP7gUlIa2IaAs4X/DHAd0+fKoX4baM2ODp
 z1WCXkot4kpbK+OZfCV0AgUBLQtxT5d5YxjcuSDPk4JR9Cy02TsLQ/YqaqaRp+yd6B7B
 AV1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736198830; x=1736803630;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SSiNQ8sqWZB4cPwLp3TA7EvESDV1v64f7n14KvOaGXE=;
 b=bGBN5fZ7pBXQM5QmjWe8CsMjPk78qWoXv4vAjm14XoYfkxl3FxjJORr6Fh/n+cwkSJ
 ICPXv61UG2Lf0sMusjwLgK/8zvuzJnCfFecNbYjeYyTlLCYJqb5udbyd/8r+amc0OYZA
 RUFeUmpB1C2GUR+V96OXa7qGnb+xmMAceh6PX3fbwDQYRoMTUDa26COTHR23lDytuaRQ
 tZp8nY2GTCUYdnJHU0SOtauxIM1Sjo9U2kFAtHsY3rdTKHtce318d/Q4BEJKPqyT9i83
 5tRcn5BO5WXNyLFmYPbCXGM/p9d2ep/lHIhBSTn9wsAhvyTRC0OOXkx9i09jd90DfU90
 IFYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfkROCWy1L+o+P4syretoKfhiF7iat9ogyBM3lBxpCSBuoLVv98fAwQ4xNA95NNsc/vWB/E/My0MHl@nongnu.org
X-Gm-Message-State: AOJu0Yx+kfd+4jKf15zs8rUjyjjJ7q0xWrccHe8WZTRdtB54UHRdAngF
 Z/rXTHuRVQ3a7E4iws5Abba7bn9AjMJKM1mLRX6HFlXJLp+jhD6cyVJNkLWgc+0tmv2DTWxrUCT
 MYig=
X-Gm-Gg: ASbGnctdFZKaue9aZAgWjkC7IV+QzVtiWvoFYd5G1CY6OXA2PUhSxfp10itIB5l8gqr
 ZkFpu2/JioB6MerPjkVG59O4uZlo7EGPnvCNiO9qFjr+mSYGeCResbt6Kvs5THYoMR/T1JhMl6H
 ri+C6X3WJ3nR77Ly4kCfAQ1T9pMAck1qUNq+tUMjI2ft+UkrWUerYb+Kto3fIwgFcQBK7nJgjZb
 NsMGSlQL6e18duUxQLm/ndnXtX95Mum1lfbN1dJkCLFk5WnVqoPatw7XKLyxi0RuryH1CpzTUZQ
 x6NGQVe8RBE+KHWb1mLyJgM0
X-Google-Smtp-Source: AGHT+IE2Fv7By17H4uW0Nc/cHdZqaHvCWoGk2nl2CGLxsrs8+b2HfikFy0X9Lkj31lLg2AliJcJJUw==
X-Received: by 2002:a05:600c:5488:b0:436:5165:f21f with SMTP id
 5b1f17b1804b1-43668b498ddmr461655555e9.26.1736198829976; 
 Mon, 06 Jan 2025 13:27:09 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436d8115be5sm36103605e9.28.2025.01.06.13.27.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jan 2025 13:27:09 -0800 (PST)
Message-ID: <df74ae2d-2623-4415-ae5d-d3cefbb81052@linaro.org>
Date: Mon, 6 Jan 2025 22:27:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/73] tcg: Move call abi parameters from tcg-target.h to
 tcg-target.c.inc
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
 <20250102180654.1420056-7-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250102180654.1420056-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 2/1/25 19:05, Richard Henderson wrote:
> These defines are not required outside of tcg/tcg.c,
> which includes tcg-target.c.inc before use.
> Reduces the exported symbol set of tcg-target.h.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/aarch64/tcg-target.h         | 13 -------------
>   tcg/arm/tcg-target.h             |  8 --------
>   tcg/i386/tcg-target.h            | 20 --------------------
>   tcg/loongarch64/tcg-target.h     |  9 ---------
>   tcg/mips/tcg-target.h            | 14 --------------
>   tcg/riscv/tcg-target.h           |  9 ---------
>   tcg/s390x/tcg-target.h           |  8 --------
>   tcg/sparc64/tcg-target.h         | 11 -----------
>   tcg/tci/tcg-target.h             | 14 --------------
>   tcg/aarch64/tcg-target.c.inc     | 13 +++++++++++++
>   tcg/arm/tcg-target.c.inc         |  8 ++++++++
>   tcg/i386/tcg-target.c.inc        | 20 ++++++++++++++++++++
>   tcg/loongarch64/tcg-target.c.inc |  9 +++++++++
>   tcg/mips/tcg-target.c.inc        | 14 ++++++++++++++
>   tcg/riscv/tcg-target.c.inc       |  9 +++++++++
>   tcg/s390x/tcg-target.c.inc       |  8 ++++++++
>   tcg/sparc64/tcg-target.c.inc     | 10 ++++++++++
>   tcg/tci/tcg-target.c.inc         | 14 ++++++++++++++
>   18 files changed, 105 insertions(+), 106 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


