Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E57ECD11C2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 19:14:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rudNf-0001bH-GE; Wed, 10 Apr 2024 15:13:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rudNe-0001b5-5b
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 15:13:10 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rudNM-0007oV-Ey
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 15:13:08 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6ecf3f001c5so5849067b3a.1
 for <qemu-devel@nongnu.org>; Wed, 10 Apr 2024 12:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712776370; x=1713381170; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=K5DcqdSAdbuKnYaF+G88dGl3X18nqFIMKDGaSYN84kA=;
 b=OjguU1xlrYtePClOdGfl0EzzPj/NZV+Sz0dm5h4W8H2OFBv2ZOfr9ruTLeveyaDrAp
 UeKX+K/gRlp26HEmnMV9oogLKVCoiPhu+2VwnIaWTCHZKdI3l9C6nPkN/CI8sR8NnLpn
 VY+ThO1Ju/0+30fGueQ3tkc5JWRHgL++9asO1NYfAlibi5nwuzpXhzWvlF/5OwGLlbkK
 YSFRHjZDQ6EZbj4oDTdEsIFowoKa9Oi1U1fqRcNyAQ0sYZItgHwUaYZ6u3AxSM9vCl5K
 7lSkuUf4bWqCbST+PYcDEsxIuyz9rN+vwkErma8XrCGMN7Mv0yxRkaloIbbmjsMRyWc8
 i7rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712776370; x=1713381170;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K5DcqdSAdbuKnYaF+G88dGl3X18nqFIMKDGaSYN84kA=;
 b=Z3NAlSSzYoxPyijjTuRH85YFB4HFgFUnJU5mynhx0OXqsV4pMSlyZ7LfddBW5dqGxX
 V2d92bDvSYHvhKJkgzbJscz9TtwY27G7gsGxYql0aZQiZ1XwMG2gTpRyNGNZI9RAOjFo
 PyqXxkUfaiSlxqfidsVSd6AhUY+CUuGuOEr8NKx2gllZ7XXPRS6r6fHyZx63b1tXmfqh
 YIXlK+bxuRBKiw0MubRK6/xDQXuoe35/uiPCFU24tgDcV8OxHeY/sMUtPidxz5cU2wdo
 SzHkqBDmmY3qv1i9zGX+9Kbz57ADd1kXiWCXVK1/9AHv1/1cQWXF8TY+kU5VnVtnn3LF
 rpXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX96dPNwRj/++4AidLkRo+C4UmTenkGa79AZQbCibG1ESRDbJWJ//79+dqx+9deMF3wOqYtE/E1GZxdfqdfH172ohiVD80=
X-Gm-Message-State: AOJu0Yyl0C/CPjdvTz8wDSP9XtNTbbHxeGSx98r0yuq+cosRwya2OErn
 ar8HIUyT3ju9emeEeVd7Lz3SyewWFahtKpX62OMBp1NlkAgSb7nHgoIRDZTi7V4=
X-Google-Smtp-Source: AGHT+IGAIvaQZUWcau85aBTFYcIsnR2JWC7pHE+dbHcMPtb4garlu+sNi1OykxzFnwdpF2kGh+rDbQ==
X-Received: by 2002:a05:6a00:4fd1:b0:6eb:2fdc:f8d9 with SMTP id
 le17-20020a056a004fd100b006eb2fdcf8d9mr3682039pfb.9.1712776370309; 
 Wed, 10 Apr 2024 12:12:50 -0700 (PDT)
Received: from [172.20.1.19] (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 e15-20020aa78c4f000000b006ea858e6e78sm10478196pfd.45.2024.04.10.12.12.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Apr 2024 12:12:49 -0700 (PDT)
Message-ID: <c4c8f2b8-7ef2-4b2f-a9d4-8c1e64668570@linaro.org>
Date: Wed, 10 Apr 2024 09:12:46 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] misc: Remove sprintf() due to macOS deprecation
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org
References: <20240410160614.90627-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240410160614.90627-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 4/10/24 06:06, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> sprintf() is deprecated on Darwin since macOS 13.0 / XCode 14.1,
> resulting in painful developper experience.

Is snprintf also deprecated?
It might be easier to convert some of these fixed buffer cases that way, if allowed.


r~

