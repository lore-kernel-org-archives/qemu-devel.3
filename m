Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1CBBC4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 15:02:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2uPp-0008NY-G8; Fri, 03 May 2024 11:01:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2uPn-0008NB-DA
 for qemu-devel@nongnu.org; Fri, 03 May 2024 11:01:35 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2uPi-0004hl-6V
 for qemu-devel@nongnu.org; Fri, 03 May 2024 11:01:33 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-41a1d88723bso65803205e9.0
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 08:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714748488; x=1715353288; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UISWXDdGx3MARazyllH2Nd9uNjD7QkHT7NFUFZeDgAU=;
 b=VdAr9sw1bb1t8xjQBUQo8q9aJT0DlrvZBXpHTLU2B51oMOoc5tYBp7WL4aXdBtO7Go
 Qxhy+EfppBUBXGX7+hyE9KGBh3Fru/T6o/Bj5TsAo5q7Mo/MfAT80By3gEpedJW37x0j
 Mq1aIXvLjCZmGFSZdR6e/HV0FT/5R67dEjMCnZIPRuaoHmWaadQWvdkoatdSWkwHPGJ5
 8tCDE70tZwQUJjdOxZrNQZ5Tyc9gHjoigoTCcn3x1j+HJcpkpgtr3oQDd8oER2s7gtym
 oEbEr9S4iKJHTbYTz9DedyETeXWW7+Jpv/yQcRRXC4iotF35UYvM05FgyaCVtsS34N/h
 fRFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714748488; x=1715353288;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UISWXDdGx3MARazyllH2Nd9uNjD7QkHT7NFUFZeDgAU=;
 b=TnKlsu6Egb66BQcNbirUmSABfqPLCSx1fLUHcSvDLATnH4QTg2kZy405Q1ktQD4339
 253LE56TDozcAYxjZVznuVOTUl6chV2xvXW1K2htCwzYXb9RNDoHR0Ub4P7q4zv1o9CM
 N9cViIRLSX7KIGxrNRoFyGqU0GlalZDNfp1wVlDJnTZgXIfKHhyjlR43Ytg1ovFbilyJ
 Nmq4EcsUVQS1LXKwNZwdDIMpNiY32Qghh9GENjV/YHdMTTQiLWjg5zVA3pm79hO0+D7+
 6FyxCtx5CZIhvvbaxqH8OTLfCeYP53AKmQy8Ts5qSMAFLjBqEsKQsdrBVPAGLrtlC3Ew
 zXwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXW02vUPqiCdjNZ5JUfeEgMiwdWh44wQv86eGXw+XwMSzOHwM4j7rdFmpLdJeY/ZXRuHWdN3noRCvBa/MuMATAAUfIW1w8=
X-Gm-Message-State: AOJu0Yw5q9OEGMZuadEtHcQ5Xv7Ps0SQMy19gSkULCUjXeFOOXDh2xFo
 8pzTGOMHP4vhVEITaWu+rIUSM4B7yFQni0T5nXUdX7emCmezf/Kd6TKXoGAcaOI=
X-Google-Smtp-Source: AGHT+IEMSOLfbg+gM/h29Kz4dQKU7JWE9UQDTCYec55vmIithHujCExYU9jmRH7KWQwvjCMpIRFBWw==
X-Received: by 2002:a05:600c:1c0f:b0:41a:41c8:d8e7 with SMTP id
 j15-20020a05600c1c0f00b0041a41c8d8e7mr2212335wms.3.1714748487129; 
 Fri, 03 May 2024 08:01:27 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.179.187])
 by smtp.gmail.com with ESMTPSA id
 bd23-20020a05600c1f1700b0041bfb176a87sm9682822wmb.27.2024.05.03.08.01.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 May 2024 08:01:26 -0700 (PDT)
Message-ID: <ea7f98ff-44fe-4cec-8717-0c113eeab074@linaro.org>
Date: Fri, 3 May 2024 17:01:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] tcg: Add write_aofs to GVecGen3i
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240424170908.759043-1-richard.henderson@linaro.org>
 <20240424170908.759043-3-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240424170908.759043-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 24/4/24 19:09, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-op-gvec-common.h |  2 ++
>   tcg/tcg-op-gvec.c                | 30 ++++++++++++++++++++++--------
>   2 files changed, 24 insertions(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


