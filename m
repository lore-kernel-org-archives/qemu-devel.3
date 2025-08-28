Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38559CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:58:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usOgk-0003ot-QZ; Sat, 30 Aug 2025 12:44:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1urkNU-0006Fd-Nf
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 17:41:52 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1urkNR-00037u-Kj
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 17:41:52 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-45b7d87b90fso5041295e9.0
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 14:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756417307; x=1757022107; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=f2LEVdYEHwnqBH/a6hUr+DHF4tWatjySkwL68arjJ3E=;
 b=IuXMwFVWeV8hYKURSWKLocyLhtn3pQcHhsa20nAWD8xKEcfPmRS2HwUx0wQHCJwaCM
 aUnXTNhhK/KdNOC9NXu/I2UP5W3j4bschcnVIyL4R8AtDsgnU34FHdzsqGQrhgfBeHMU
 HdVDl3er3CjQxDzhTsLhQOdoSeKi1p0/FVGyBqZlDMzksdJqIsXxOHVEdMSSCDBDkhYm
 zAuVFX0xiZkusHPAVi+Bt6pEPAZRZly5782R2HWi6F2OQGyqe1H0vd7tZWn3tabPAwFx
 38wiknm47Y+gy/FVe6Y3jV+hvArCFn0p8ws8lXWqj6OJ0OPlsgnD+4ADlwcCZ1wMe6Y+
 i2AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756417307; x=1757022107;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f2LEVdYEHwnqBH/a6hUr+DHF4tWatjySkwL68arjJ3E=;
 b=e3POLsxO7PLtER+MApZyiwA8e0R3cyQSg52tmu6YHEsuF1vP5nVK9bIJAU3OIW9anC
 88xXfnZRWkFXkrAQz5uG9k9OXqyC8tKcQT/D2oPzyJWeY1v4bbyCHvBc6nr0EDqz2tIN
 FtbAh+rD6MbQiRynTT987gGqOBUR3VqimLkCzmJRx7MJlFw8bY+iwFsgiaKc91E8r6vs
 AyXA9xVFWnfxTo0ntIFyek1BkS4+8lAjGPSaRJQI9BuWqe31hs+lBtk9ctICfef7D8gc
 ZaDj7/C7o/+IQCOUo90iZXZ5EGSLuIJg1+IKvDQNPhM4iHjKr3cUPJeUDv7Qk359YuAx
 eCig==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrWIn8gL3r1H4Xw/eqwaUffltrW/Z4mY7UufFoF3HQv5ntuXW5C2PTyUW8HCN4tXZXORXMeG6XpQzI@nongnu.org
X-Gm-Message-State: AOJu0Yx95pjkq8PDRnvCZgXfE1dU96x/0Rp4oGL0MZVM9CAgsgMCPPdL
 7H+uGWXxCde2hzNPujtc0nRSTavJF0lTM+K7NVSKJKkzOAHBY29+oP8tNdJ0kCktN3wlo3qseC4
 Ajs6F
X-Gm-Gg: ASbGncuybPSQdZWjBMBB/+QdMtBEJJnhN9ZVFW41wv4YagD3FMCbpKOWWYsCvqjYM14
 d8pIs0nCCTq82TsXp3vmfHAalpsREyG2mUrfrpGPMWvvzBx+3lNq444XnMTRG01rAXKLf8Nl9HT
 R+dEUdqXdNgDdJw7tRt1GjSOHKTrHsQKihEi24yppnZHgjUbznyE0ivwW4rYZhaCVP/DeKOWaDq
 gMBNoqj4JVNm8frvjjoZIKH3kIP76YoTgoYtlZ6dIdfzn76W1m4AGZwEPC9xW5/mbKXZAjCCZep
 fOKs1H5RWqSwlcZW9EagnypxayKB5pWUg2uz24S3pWbRCpb6rjqNSIMDUtgD9Hl7t2xlcCZY1+P
 lwpBclt2Hn+NWGATv6rPiMLNXSHYNyqwhuSBNjPxvcYI9AXq2PNW61TbeqMTwYaHLaUFk4nH1mu
 Iw
X-Google-Smtp-Source: AGHT+IHSFmdmBQw9ezUYZQz/HZgCxab6wY/SVtXOB98mYOSt/BJh2/fILZ4HQuGPVh/A6OJGERdSfw==
X-Received: by 2002:a05:600c:a49:b0:459:d9d5:7f2b with SMTP id
 5b1f17b1804b1-45b6870dac5mr91678515e9.16.1756417307033; 
 Thu, 28 Aug 2025 14:41:47 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf33fb9d37sm745623f8f.49.2025.08.28.14.41.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Aug 2025 14:41:46 -0700 (PDT)
Message-ID: <7b4d4f6a-7aad-41be-99f5-a81c7290dfc5@linaro.org>
Date: Thu, 28 Aug 2025 23:41:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] system: drop the -old-param option
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20250828162700.3308812-1-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250828162700.3308812-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 28/8/25 18:27, Peter Maydell wrote:
> We deprecated the command line option -old-param for the 10.0
> release, which allows us to drop it in 10.2.  This option was used to
> boot Arm targets with a very old boot protocol using the
> 'param_struct' ABI.  We only ever needed this on a handful of board
> types which have all now been removed from QEMU.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   docs/about/deprecated.rst       | 13 ------
>   docs/about/removed-features.rst | 12 +++++
>   include/system/system.h         |  1 -
>   hw/arm/boot.c                   | 81 +--------------------------------
>   system/globals.c                |  1 -
>   system/vl.c                     |  4 --
>   qemu-options.hx                 |  7 ---
>   7 files changed, 13 insertions(+), 106 deletions(-)


> diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
> index d7c2113fc3e..b1b3d1b1b3f 100644
> --- a/docs/about/removed-features.rst
> +++ b/docs/about/removed-features.rst
> @@ -560,6 +560,18 @@ the options along with the machine models they were intended for.
>   
>   Use ``-run-with user=..`` instead.
>   
> +``-old-param`` option for booting Arm kernels via param_struct (since 10.0)

s/since 10.0/removed in 10.2/

> +'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +The ``-old-param`` command line option was specific to Arm targets:
> +it was used when directly booting a guest kernel to pass it the
> +command line and other information via the old ``param_struct`` ABI,
> +rather than the newer ATAGS or DTB mechanisms. This option was only
> +ever needed to support ancient kernels on some old board types
> +like the ``akita`` or ``terrier``; it has been deprecated in the
> +kernel since 2001. None of the board types QEMU supports need
> +``param_struct`` support, so this option has been removed.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


