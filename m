Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2CBDC4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 03:36:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZjai-0006nh-C5; Mon, 12 Feb 2024 22:36:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZjag-0006n4-EX
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 22:36:14 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZjae-00046Q-Sn
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 22:36:14 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-33b670d8a74so2594193f8f.1
 for <qemu-devel@nongnu.org>; Mon, 12 Feb 2024 19:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707795370; x=1708400170; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=J9FQDA+6SRNN0wcncWcrLohmh1dHpmxjYZkcDl4/AII=;
 b=zcjNnVk/wp1HVhOXPlp+Ilzdh4jbXfcjzqbD9xUjEVc2G5C5NFsfJuqCebKLvzryqw
 eAJsxnvJda8HAzSc0JbbTR91V5DPs0Swq5wPbkqpDSUt3ZRm2vCfHU+/YxgFV6ENHGY/
 exlP+BfstmeL8jri0ypWIC3BVpuQ2dWiuBI+NhW2TMTw1sw7td8f8ERwIJnlN6ZoC+9H
 T6jv5v5IFJc+/i+3265sI7FvsMQNAynhDOzwQB6j9+fjQ0cMK05bbBlxDEXUsjzOUX0d
 UotM5/3zkl17WzBMQuLnFaqmK6zvALSMN0jbR1RkPK+orfeqYdFzHKBkU+FuUojTAfyS
 kH9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707795370; x=1708400170;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J9FQDA+6SRNN0wcncWcrLohmh1dHpmxjYZkcDl4/AII=;
 b=I8THBFVg254otfCb0c5/jK8RET63/eGtWQcLpL49+QWePPzDstcfehEMMeGTguNnEs
 Nz/125kvT+G67n3MD4vS9Z4BLa/5ZgobumNrNaHmIZQYvMrfsaAyuP2Jb6Ine9dKWP2Z
 jXmZs5GPAMwCEwaqg1Uli7xqSRdmxwJb68XQc9v5v8+7LW9C4bsu+zTfRWdsWFDrjGfw
 MdejLDvcHbs50vHNoqUbM8tVn67y8bPkxY1JnOXno77JVeAPzMJrHJHf7z9hjTxBNiPm
 HQJM6HKVFmqzM8TPVMTnqqt2kgGk2qMD/L1vYRVKQsd6b0wWOSocKyu4KZTrb3AQRxkZ
 WS4w==
X-Gm-Message-State: AOJu0YzD3SQlNyOjVvJUXLFraTdRckx7xNe4njUflGhwL0Z7s+gkgcHo
 CTKoqWw18wYt0OspeGaUzh/ViM0k3qye7y1SovSvnQRfLokplMdwN3VmjVVu0CA=
X-Google-Smtp-Source: AGHT+IE8iCY3nBY2TIf5+l3sB/F64exrL92Ti9QUJvsYcXDdlu2ywX//A/RgqTzOwPC5uFN7GVffeA==
X-Received: by 2002:adf:f4d0:0:b0:33b:4382:c50 with SMTP id
 h16-20020adff4d0000000b0033b43820c50mr5289282wrp.26.1707795370369; 
 Mon, 12 Feb 2024 19:36:10 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUztHa9tctwR7fPDjtyhZ67NrcpFuQUI8xX3tkJl9NEsF5HO3+LWi9m2BeNMHf8w6qqO3HrjGw1n9hq5d1JLd7213LB7SE=
Received: from [192.168.69.100] ([176.176.128.243])
 by smtp.gmail.com with ESMTPSA id
 n4-20020a5d67c4000000b0033b888a0a63sm2138846wrw.0.2024.02.12.19.36.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Feb 2024 19:36:10 -0800 (PST)
Message-ID: <5b89aba6-febf-4400-817a-d3291f4c6761@linaro.org>
Date: Tue, 13 Feb 2024 04:36:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg: Increase width of temp_subindex
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20240213022132.116383-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240213022132.116383-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 13/2/24 03:21, Richard Henderson wrote:
> We need values 0-3 for TCG_TYPE_I128 on 32-bit hosts.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 43eef72f4109 ("tcg: Add temp allocation for TCGv_i128")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2159
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> 
> I feel certain that I made this change back when I introduced TCGv_i128.
> I imagine that something went wrong with a rebase and it got lost.
> Worse, we don't use temp_subindex often, and we usually handle i128
> this value correctly.  It took a quirk of register allocation ordering
> to make an invalid value in temp_subindex lead to a crash.
> 
> ---
>   include/tcg/tcg.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



