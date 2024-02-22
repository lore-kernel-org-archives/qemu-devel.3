Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C224C48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 07:59:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd3zH-00031R-Cv; Thu, 22 Feb 2024 02:59:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rd3zG-00030y-5v
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 02:59:22 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rd3zD-0005by-Md
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 02:59:21 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-33d18931a94so1205223f8f.1
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 23:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708588757; x=1709193557; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PTfd0q6IlCbhp+wnxdg6xPabhiUdh+fzFjNpq8Gg0Jg=;
 b=Sz1QNdoY06/FXbBReZopveCHZ032xtJvUCBcFb/Bjv+0XJE9c9IHRn/PfUpfus7AUW
 93ocM4+FYNXsvL0ebL0KX8mY4yaWPBQw4T5Jjp7uqema7T02+jqLxK1V1jgw6K693/sl
 3WQktBWgcSsk2WRB4mnc2siQBlNHSyPCMZJEDSoCAZuscYszn5mLvz6sk5wQS/BYkIOY
 dJOjIULE95M/uskPQfyqXIsdiBUfo1QduPdALVgecC2LvDjc1N/uq5jCv3AzoH9DeqUj
 5xz9+5pRxBn1tt9LJ71k5IBhxB2FhtA+7AEOalqCPM2bEGUmf5ArLrZgPiyjWAlhZ6QG
 Oe3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708588757; x=1709193557;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PTfd0q6IlCbhp+wnxdg6xPabhiUdh+fzFjNpq8Gg0Jg=;
 b=P8HSxXcwVEuyHH2sJKaYjzgUKZz4OEpqX/eWfC0G3SpPveYXtm4mg+FabDKiVK86D8
 HuZJQwdn4euaDIpPM1Cz1omotHXS6KsQi7gHp2SgPSxaeZLdlwAqggRcll8hZ7F6oe/o
 zfeJpE5F3nrnymPvDV0LCsG5eBQ92MKovUUFereuAcMmSI6d6TsoAUKVNVVWmo76wixg
 MwdzfQw7p8UT41Wcw06WI2Kn+Alp6fLr9czTU/mk4B9o/UMOAxYLawV6ztJA/qGYg8h8
 roH4uBcMC0t7SxkRY/uokkzLj7/t1GwEu8BSnzRLCAKnAfupVretMDvRq35oAXQontnq
 MaBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJILW6ncXhzfkk60p7qrGFpxc/d54U/RUyg4Y5YTuo6I0PQNdXdf4vOn5jKJm8VQM9oyO75RW5zV9WaGyiCGlLVoiUxT8=
X-Gm-Message-State: AOJu0YyYamKUWkQzfmtM9RHoBM4IvwsTtmQnufRXVOuB9I23HsvOnsD9
 BIzh24Lf50tGBxpJO5ZVvP0aRoluGmG65QCxTfHUnsLy9Kk0K/strmlngQOUMCc=
X-Google-Smtp-Source: AGHT+IHzB8VoMt3cAxDtjwsEpkK95SKUfcG3x58INcGfH1eh+liIVK6mMSxh5gTiiGwSnnZqslsOIw==
X-Received: by 2002:a05:6000:1546:b0:33d:5a6f:a856 with SMTP id
 6-20020a056000154600b0033d5a6fa856mr8084976wry.30.1708588757478; 
 Wed, 21 Feb 2024 23:59:17 -0800 (PST)
Received: from [192.168.184.175] (41.red-95-127-32.staticip.rima-tde.net.
 [95.127.32.41]) by smtp.gmail.com with ESMTPSA id
 ba20-20020a0560001c1400b0033d640c8942sm9188080wrb.10.2024.02.21.23.59.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Feb 2024 23:59:17 -0800 (PST)
Message-ID: <6ca85567-c941-42b3-a7d8-3de5a9cbd22c@linaro.org>
Date: Thu, 22 Feb 2024 08:59:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/9] target/riscv: remove 'cpu_vl' global
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, max.chou@sifive.com
References: <20240221213140.365232-1-dbarboza@ventanamicro.com>
 <20240221213140.365232-6-dbarboza@ventanamicro.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240221213140.365232-6-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 21/2/24 22:31, Daniel Henrique Barboza wrote:
> At this moment the global is used only in do_vsetvl(). Do a direct env
> load in do_vsetvl() to read 'vl' and remove the global.
> 
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>   target/riscv/insn_trans/trans_rvv.c.inc | 2 +-
>   target/riscv/translate.c                | 3 +--
>   2 files changed, 2 insertions(+), 3 deletions(-)

I was expecting this to be squashed in previous patch, but it
is indeed clearer as a separate one.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


