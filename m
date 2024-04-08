Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1D82C67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 06:18:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtiKo-0003fz-7E; Mon, 08 Apr 2024 02:18:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rtiKl-0003J4-D3
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 02:18:23 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rtiKY-0007Kl-4t
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 02:18:23 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a44ad785a44so469501166b.3
 for <qemu-devel@nongnu.org>; Sun, 07 Apr 2024 23:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712557088; x=1713161888; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jXT+u91YzwnYisHkGtQ7RMNE8T/27Hhc7IWGPE+hJUk=;
 b=pfhN53t0Ab9/QaSGYf5U0qDkJCWGrQwiFJwhsVJshKaKacR3IVxcKrFav9OLvL7I/f
 taGdOCLuEjVIzqDhXxSJkMYDrBCP3hDXKbpd/3gW7sohj7/F6FlYhqIN0XSEAIu0dklg
 GzqrCOeBZIo8+JTUi40avyNWnRKn0GCIi4dB/hLj4sX4mTROxZ7BnXQOCVZVNyxTXfB9
 Z5bJK2hszQ9DXn6Wjrz83fOCMXc9BMMvmrVjsmrsSTVFFXz0FUM2cNMBx2dBbAOnO0Nc
 PNH/a83+Tqmk6CWgw9q6s09KWbivk99qz3D0dlDbcq8vkUfSO0n61Kmn2K21BR14V8tW
 ZIuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712557088; x=1713161888;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jXT+u91YzwnYisHkGtQ7RMNE8T/27Hhc7IWGPE+hJUk=;
 b=IQ62R2kRqMN/wJiH5b1XpKCvhAna5ql77SPVt6M9yP4oEgJM0vreeIpTymmxlxpCDj
 hUdtVAJv/5K9aPWuzzAC7WBHmmdh8qlh9uiF94ApFvRdr9v460g0NZbClWZ2LNf0KOv4
 DahuXYeYO7D+8bcqsgPE9x3n9Z00teX98x/vOc5eYPwqVOTDS/EVGBWGkjB0J1vFR/mq
 Q24RuMqXrI+O5Za/UQbHp5gsUcvQZszWVh9BYtMr3Ndm93Nom1v777Jb9aCVf/4soBNR
 GsVZ1ceHgbUdIRidyTYHF+DYiFccdqWnmLNCe3tvJWXlhd6vLIHQCtTClxaAP2tVJKT3
 eHzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNtEh7nmlg0tTA6eY989D8ejIHq7kxAJpk/LhaxW3Igohw/J2psG/v016Z9g1lufNK0ct9udL+mfC4nLzWw5KDDM/eR1M=
X-Gm-Message-State: AOJu0YwNydlFpp4KZhdLz7PFQ5KmcQxcndzuw+45J9T9nNaxoewEQKXb
 bg9h3XEItP4beJk3oLEV2duKT2Fldm5aFpT7ssq9H7f/VjR7ElhiW0KMc4Q5Lux5QUlUDMLtvFh
 x
X-Google-Smtp-Source: AGHT+IE8G9FpbuiFt9N94IrkmybyxwuXdQpcHdFJjNKBkNE/AuE8zdWhQVkv8X+AFRyuXYXSlr4TXA==
X-Received: by 2002:a17:907:6d16:b0:a4e:2e25:75b5 with SMTP id
 sa22-20020a1709076d1600b00a4e2e2575b5mr7169015ejc.55.1712557088770; 
 Sun, 07 Apr 2024 23:18:08 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.144.67])
 by smtp.gmail.com with ESMTPSA id
 e27-20020a1709062c1b00b00a4650ec48d0sm4029273ejh.140.2024.04.07.23.18.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 07 Apr 2024 23:18:08 -0700 (PDT)
Message-ID: <625affbb-c883-4624-8c30-893f37ecbabb@linaro.org>
Date: Mon, 8 Apr 2024 08:18:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] target/s390x: Use insn_start from DisasContextBase
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Jorgen.Hansen@wdc.com,
 Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org
References: <20240406223248.502699-1-richard.henderson@linaro.org>
 <20240406223248.502699-9-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240406223248.502699-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 7/4/24 00:32, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/s390x/tcg/translate.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


