Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17C82D3516C
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 10:14:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7saR-0000BY-SZ; Wed, 01 Apr 2026 06:14:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7saQ-0000BI-8e
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 06:14:10 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7saO-0003Oz-LY
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 06:14:10 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-43b95e5b3afso3918525f8f.3
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 03:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775038447; x=1775643247; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PUzZ309io7zd9/oYiYDhr2fctRgOa4WHpXvd7DTB8+w=;
 b=A2+9sL1xqN1NiiGsCKtpB3ZrSf7xCRRlIb8COyEDgjGSeVcZTIfUl8sqB9cN5R/Elu
 HZ9R5dz7eJdiv0x8tiLV5X0kzfSaM1ZpKsdI1YcvmICn1+AVK/VzlnQ6lNM+kHEO7+pV
 mBd07LVGprRfDJbYJBAw+sB8j5cRZJ7KQh8g1U51dFCnZejQxdQIzhmVHjPm5UcndKGe
 k+OMfXgLKAuAN2w4htaWeLyrvLe1G0jjooyQwn8s9gzhRcQ0gpBoA3pnoSqub/o+310E
 Ki+FGjzJL1KBnUKaQYmsaBGaEOI6wVJFPr1RbI1dMVt3LjE1S3+RqviYqtnOlu/mcSSq
 NQug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775038447; x=1775643247;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PUzZ309io7zd9/oYiYDhr2fctRgOa4WHpXvd7DTB8+w=;
 b=Pk0E+YhX7IS35LbXoINbGP6bm3Os6gi+x5M+PRyxrucBfUhyRq7pxBwc4huhteQehs
 /lNd4VS6LAwi7YXOjgKnsW7Rwvtb+1s2W12NcnxELicCnYBW5tpLHSoZRfk7U1IQn/Rp
 jKAFm/oLwydxisgzgT5NqycH9PYCzk+8zyCB0wa1O76XFnkI08j4uuDuj12JmYyeMY4M
 I53i8XR1kg3CaOkJHw14uI3+jIJrsAVAd4zBEp8XmcnIBzchhMr8SQGt7khLgsCJmDEV
 5GNI0Jpy+Ogb5hNskit3xeMfeUGPSXIUVUQ5/BnDw38DvAg3F537cdj9cNxqqZ8Ul6Sg
 OAIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKnz5US4crfsf4SyYFEggwAnp0BfZ4N1KJCCazobwJCa2t0pSuaSn/ieCz2RUAbVt9DXs1qMGevH+q@nongnu.org
X-Gm-Message-State: AOJu0Ywkv/DwggBd40ZoziAe3Uu56EeXVQLQYAGMUEiV3+NHyb10OPpT
 gYuGz6xtyq2BgFHH/u1owutw9+HNOg11OJyRBltrU9KeBwIwmXesNtQImisU/JiqvmU=
X-Gm-Gg: ATEYQzz/x7Uu7sgfWZtOdwcvPRi29bOCG2F3iLXFpjuEtEvrIzGdGuyG3JgvIcZ3tmk
 pUhLSug6P2hWxxe0j5Eb63fkYmTmJpiH0v+gFTXZS7W0Nwxg+AsE/SWbadZM48a5hWMoDVDs4xk
 AfhBn4v4dfw0Ql1mw6nyPMDI86NaJu/VlrVdVX2IxEE/A8btzO2XaAANFgRRRpNhZCl7Lg2ygam
 ZNpwYGLUE3zg+av7TNAmXyOpzcfo+EUnM9p+0mvjAogbrS4jemg3MrWukCSdvmYEKchXDCbN0PV
 EWKHYy5SHxNbAh+Q2jqSszOB5nDk597hWVtAHLCg1yYFyjBPpuCoFxYmlGrGrN7XCJZ76t8tjf4
 HRFxab05/xMJJUb5vnZJ/9nvNvxGjCBP6AL3rswcVN0t2nxcY6zwkXba1490DHFRTtow2B15qKf
 GAEjQYqWSnIpjLKKOVmS5qfhQv4TsM4DqWaf79e9EMubGUlX62zRBu6ij1m5COtz/fcQ==
X-Received: by 2002:a05:6000:4008:b0:43b:8858:1146 with SMTP id
 ffacd0b85a97d-43d150f0ae4mr5506771f8f.41.1775038446907; 
 Wed, 01 Apr 2026 03:14:06 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43cf2580194sm32260253f8f.37.2026.04.01.03.14.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2026 03:14:06 -0700 (PDT)
Message-ID: <32560216-c9e8-47e6-baa3-14f70c6d2b1c@linaro.org>
Date: Wed, 1 Apr 2026 12:14:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] physmem: Simplify dirty memory type checks with loop
Content-Language: en-US
To: Bin Guo <guobin@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, richard.henderson@linaro.org, pbonzini@redhat.com
References: <20260401100005.20651-1-guobin@linux.alibaba.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260401100005.20651-1-guobin@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 1/4/26 12:00, Bin Guo wrote:
> In physical_memory_range_includes_clean(), we have three nearly identical
> if-statements checking different DIRTY_MEMORY types (VGA, CODE, MIGRATION).
> This code duplication makes maintenance harder and increases the risk of
> inconsistencies when adding new dirty memory types.
> 
> Replace the repetitive checks with a simple loop that iterates through
> all DIRTY_MEMORY_NUM types, checking only those specified in the mask.
> This reduces code size and makes it easier to add new dirty memory types
> in the future.
> 
> Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
> ---
>   system/physmem.c | 16 +++++-----------
>   1 file changed, 5 insertions(+), 11 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

