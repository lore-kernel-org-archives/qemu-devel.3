Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D398C27C54
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 17:08:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFGZz-0000wi-AD; Thu, 06 Jun 2024 13:07:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sFGZy-0000wa-BD
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 13:07:10 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sFGZw-0006jM-JH
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 13:07:10 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-70245b22365so969268b3a.1
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 10:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717693626; x=1718298426; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sMKaUfFJSCCeVdYepRV3sONy8MFeXfebG/SWl2417+w=;
 b=ZlUhnHSNDBmo5VvaKyv4t/u4DcHTEMu4skyBIe9CfWuH5TP/0etxQT8LHg9l+Gree8
 M8Zj+3/fxr0zKBCgAPOBPraaIxzfRskrVDOuUpyGtMWcN0suPf0Aa55I7n1iNzG6QDTb
 /rSNeTFSu4fSegx4Wz3lsA93OzxlWWClSI8lXz7IwHVK7hTQyBbzT5ghiMj/Na2cQgU/
 6NxaSHyo0qIKmcK8JcxLCBpf/nAxG991Ogvx05BxBjp4MDOGTY7OIBeCYhf7ZJR8CCU2
 3o+3GLMM3c75Y4MQKAWvbhz0xGWofe4krE455R2hW+wMV/9ObIqIyF57aK159pjo2yDP
 NcCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717693626; x=1718298426;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sMKaUfFJSCCeVdYepRV3sONy8MFeXfebG/SWl2417+w=;
 b=pBxLvlrMT/mI6GpE0rv/0OFUVZvdDNWn3NNQFQmhm6s7n47b+yyA/qi2uKJpf4Kz4l
 z55rGlBMTlURSnYfnzucnbI9PaQi5ZXps59XogeROk5Bx4l7JwVzTGE0FPaHi9tLlCoP
 uPVYkJ1u3CC7EhzN9Nt7iwiXYGcOaawskc8DdoSSxjDq2IMKgWE5BtV6W2mokMEkX5gi
 cHHWAfYP2pMEC6rA0rsxigkqAuIYlGu9ysnH8/Pc+Jv7KSsd2v4SCejv8Wv2Lbdz66/r
 2tTZ2HZErlbRUZIr30FHTFx2ZlViwwJyVDkLQApPw8O4MXMqYO/HRnH6MTqAPcNUG7zn
 cJow==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvuKc7yQlAhScR/8WSm+6ize5yD+cwe11ml6jrLRrvsT7wS3OHuFk+XCVYbY9lQDfIVdt3k8rSE6kbuS1jGFsJyMdWRe0=
X-Gm-Message-State: AOJu0Yy7g6sL8Im0jkzas9atTXg6QzsezOX5X+oY7LBwry/5vtK+kpiI
 qrOpALKYS5OWuO65yRDftVZfzAUlmlbFdBzpt8DEtVnyAXeg8CmKt+0HgILPFzLRwYtRqsxfqT7
 M
X-Google-Smtp-Source: AGHT+IF9kXht5UTQLQGLfxfr26YoLlMjah0V3YQErieA+Rl4x8D0AKmf0EsHjCqYrsSXC3pbcI2ACg==
X-Received: by 2002:a05:6a00:2d81:b0:702:3a47:2b13 with SMTP id
 d2e1a72fcca58-7040c72264bmr42828b3a.22.1717693626580; 
 Thu, 06 Jun 2024 10:07:06 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-703fde38722sm1277335b3a.215.2024.06.06.10.07.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jun 2024 10:07:06 -0700 (PDT)
Message-ID: <36f234ff-2928-406a-ab9c-848c54ed2f38@linaro.org>
Date: Thu, 6 Jun 2024 10:07:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/sparc: use signed denominator in sdiv helper
To: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>, qemu-devel@nongnu.org
References: <20240606144331.698361-1-chigot@adacore.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240606144331.698361-1-chigot@adacore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

On 6/6/24 07:43, Clément Chigot wrote:
> The result has to be done with the signed denominator (b32) instead of
> the unsigned value passed in argument (b).
> 
> Fixes: 1326010322d6 ("target/sparc: Remove CC_OP_DIV")
> Signed-off-by: Clément Chigot <chigot@adacore.com>
> ---
>   target/sparc/helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/sparc/helper.c b/target/sparc/helper.c
> index 2247e243b5..7846ddd6f6 100644
> --- a/target/sparc/helper.c
> +++ b/target/sparc/helper.c
> @@ -121,7 +121,7 @@ uint64_t helper_sdiv(CPUSPARCState *env, target_ulong a, target_ulong b)
>           return (uint32_t)(b32 < 0 ? INT32_MAX : INT32_MIN) | (-1ull << 32);
>       }
>   
> -    a64 /= b;
> +    a64 /= b32;
>       r = a64;
>       if (unlikely(r != a64)) {
>           return (uint32_t)(a64 < 0 ? INT32_MIN : INT32_MAX) | (-1ull << 32);

Oops.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

