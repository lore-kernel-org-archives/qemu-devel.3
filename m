Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AF2DC25B10
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 17:06:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5Th2-00011X-71; Fri, 10 May 2024 13:06:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s5Tgk-0000ud-B9
 for qemu-devel@nongnu.org; Fri, 10 May 2024 13:05:44 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s5Tgb-0007q6-Tj
 for qemu-devel@nongnu.org; Fri, 10 May 2024 13:05:39 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a59c448b44aso601731166b.2
 for <qemu-devel@nongnu.org>; Fri, 10 May 2024 10:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715360731; x=1715965531; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZA6Y6PZH+0vk/+O5kyGD7UJmXuUVucS8ED6sxm6cY1U=;
 b=X5E70DYpq6Qjxiga+5rYVHhHGT6YjZNTymDs8mHck00Zg2bC7pMg/8/G0e8HPcr47K
 JWTwePUrPg1fwH6W1FIYw2Qsv2x90edxhxD6Ls72YfQa0WOmP4tG9zOunkN9fjEMzj/Q
 HjAoyw0E0C2C/C4jMpmRSyLDNgdRgL+lx6zU1dflYKEtamINjNUoo7+K0a7S288MvdkG
 0apYn0S733r4oZCuNaAeQ/RiiB1P3QHrrGZus3HjoZNXIyR4lWxKwz+hlNMHH14uiWj1
 Re1mUz7fNTg8UTba7QZK3uzH3NaVsNguLI9Fkt+W67wbZK5YQaENXCOw0SLgohw4BgU4
 ZcfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715360731; x=1715965531;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZA6Y6PZH+0vk/+O5kyGD7UJmXuUVucS8ED6sxm6cY1U=;
 b=N9f9GRRn+aCkcUQ12qvWD/K6mV0ZyQqiFKhFg2Ww2PqU6kYJup0/oYMQQpPPA+lvqk
 cfVxlUw9zSLHpCo2b/80Mkds/J4XeV5fM49WSZKbMUNLexgCW1sACDG9iTR7SkO8wOuk
 MPZQNKwU/WJ6U5Wr02pLyT73BxW2M/jYgwA9WTBDi1vFeS584W+xCDpxzN2aqzFk0wn2
 T3Z/GDP29OUJk2sf5eWVMFgKkoO4NTREFCUZqGGUPYjPYr9buh77Lr8bUyhfodsHdrPE
 y3TLqAeIrCE45b9Ge0qcEFv3eqALqav9A8Zon76MauFtPCRQogrt9oIQ5Xw+LMOLSxNI
 HM7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYPjrQf9B9dIZoiTjqOPuloqANO5itiKIYIguJ6YKAY6S5CPHsM9PIguLqn2TDH6iAWWqNMaM32T1rFVxkfdKTEcoMfJ0=
X-Gm-Message-State: AOJu0YwFjIDyCBgZ3sX9ZIH5vDm3WFYNqB8fwNbaJhkdV7WYo4tnGXyr
 7YsFPO6J6H53PAem4E7yzjY+68LoSfIfItgU7d9D5gr5GY/dzg+7/79hm79ClZQ=
X-Google-Smtp-Source: AGHT+IEmpOXaHaXsIhfwf0HGs3yqzKBfyrZ0Elpwb7cVx4nyrT9GPlz55clSn2AhniywGBNIewXU6g==
X-Received: by 2002:a17:906:17c5:b0:a59:c9ad:bd26 with SMTP id
 a640c23a62f3a-a5a2d54c601mr200672366b.12.1715360731660; 
 Fri, 10 May 2024 10:05:31 -0700 (PDT)
Received: from [192.168.69.100] (sev93-h02-176-184-17-152.dsl.sta.abo.bbox.fr.
 [176.184.17.152]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a17b01451sm203930466b.149.2024.05.10.10.05.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 May 2024 10:05:31 -0700 (PDT)
Message-ID: <321848a5-61ff-4f97-890c-2dce30715a52@linaro.org>
Date: Fri, 10 May 2024 19:05:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 33/41] target/sparc: Add feature bit for VIS4
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com
References: <20240302051601.53649-1-richard.henderson@linaro.org>
 <20240302051601.53649-34-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240302051601.53649-34-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x634.google.com
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

On 2/3/24 06:15, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/sparc/translate.c       | 2 ++
>   target/sparc/cpu-feature.h.inc | 1 +
>   2 files changed, 3 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


