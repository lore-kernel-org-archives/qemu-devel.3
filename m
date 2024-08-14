Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DCD4C52D7B
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 02:54:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1se48h-0003A7-Jv; Tue, 13 Aug 2024 22:53:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1se48f-00038V-2v
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 22:53:29 -0400
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1se48c-0004FX-DC
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 22:53:28 -0400
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-5d5bf833de7so3415086eaf.2
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 19:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723604004; x=1724208804; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tYG8/HXCSkpO/+RF+n/1m/ZLDDptRxFV5ezFdouyG04=;
 b=OtFkhgdKo9PChf/eecL2+yWv7PqRYWnATHY2Od8I1S6NLeLatTgg5zsJAQ1IlpaHK/
 xv3aK/PCkuRY6JGv6Ha4OCnwCVYXIBWY41hF+9zfKtTMQwTt3xiOiwMSlOvVk1ueLvlm
 DctGbA+DXYy0vxGzBElc9UlwDH1Eqkp/HnxTASdhgmax5TPtbHL/zNMFWZvbF8a+RsnL
 2iD1nPa7SnG/dxzN83GrmCjspcNhB4bWZrCa/snZfsONbruWrX9XClyCBnD/hXdV8gka
 je3SAMFv7IFRwqvxyMCY7QzTDcrudCJ1Hasxt2rXbRTcYVYvSX3zORi49f7YmWBRhXSg
 VYwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723604004; x=1724208804;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tYG8/HXCSkpO/+RF+n/1m/ZLDDptRxFV5ezFdouyG04=;
 b=loJ1+ddiFX/AJTTRh7B3hy+LCTFXiG1qmtNFFkmrZKNfFlf5tIrNJoADem7QW1k3Y0
 va6xk11GZ6reYM11Lhol5QMAmrnqM5J/JiAZKZjCIZ/eaNpKAS5A2Hpz2Njy05Dvw/xv
 1fIO4Z4ejv4Ztr4dlX89gUscL5t5e0X02FxuP/oM7Cs085ZmFV3nC473gURTEn1WDWZY
 J+EVh5JpmRIotVkI1uY9Hh05CVlv1QrrfTFbjMT7pvoN1LCBrO7hd9ySrn+C/pxYht9t
 pT+4cOfdI1kigRL6UtHwrTOMnVgmUfkfLdsWEbADkX8/67CAeJmVnzO13RkhlxqegY/I
 IQjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWD4ph4QRBYOuZn0/XfWodatSquw+tn7sGwpyMp9/etW0XnleGXXRvtfDn0u3a+eHcwT7xBCSh3Wn8d+EwlVSerxz8fvJU=
X-Gm-Message-State: AOJu0YzNGZCe/8CbkVNTwnK+CqmSlNWt3itmAD4r+fBilCLBIX21doUp
 32lXV83Ak82MmKHgsJS4w9Fa0XPx6zTczCKLVn3+aTI9u4zAwcL9S//zQEr1Mek=
X-Google-Smtp-Source: AGHT+IF19qqjWserNQwSCQ00i20ib71uAZXR5cxZN0J2dK5NyY3o9SYMcmQYPsB3rK7uwJ8JX5G7qg==
X-Received: by 2002:a05:6870:a54c:b0:261:17e7:59b3 with SMTP id
 586e51a60fabf-26fe59dc705mr1947968fac.3.1723604004471; 
 Tue, 13 Aug 2024 19:53:24 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.111])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7126b66dafasm157383b3a.158.2024.08.13.19.53.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Aug 2024 19:53:23 -0700 (PDT)
Message-ID: <a3f2b59b-8303-4e2a-8ad2-a8a548a78fb6@linaro.org>
Date: Wed, 14 Aug 2024 12:53:18 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/4] target-arm queue
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20240813152054.2445099-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240813152054.2445099-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 8/14/24 01:20, Peter Maydell wrote:
> Three last bugfixes to sneak into rc2 if we can. The fix
> for the EL3-is-AArch32-and-we-run-code-at-EL0 bug is the
> most important one here I think (though also the most risky).
> 
> thanks
> -- PMM
> 
> The following changes since commit 9eb51530c12ae645b91e308d16196c68563ea883:
> 
>    Merge tag 'block-pull-request' ofhttps://gitlab.com/stefanha/qemu into staging (2024-08-13 07:59:32 +1000)
> 
> are available in the Git repository at:
> 
>    https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20240813
> 
> for you to fetch changes up to 4c2c0474693229c1f533239bb983495c5427784d:
> 
>    target/arm: Fix usage of MMU indexes when EL3 is AArch32 (2024-08-13 11:44:53 +0100)
> 
> ----------------------------------------------------------------
> target-arm queue:
>   * hw/misc/stm32l4x5_rcc: Add validation for MCOPRE and MCOSEL values
>   * target/arm: Clear high SVE elements in handle_vec_simd_wshli
>   * target/arm: Fix usage of MMU indexes when EL3 is AArch32


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.

r~



