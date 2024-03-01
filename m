Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CE64C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 19:05:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg8C3-0005U8-9J; Fri, 01 Mar 2024 14:05:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rg8C1-0005Tk-2U
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 14:05:13 -0500
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rg8Bz-0005Ij-JR
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 14:05:12 -0500
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2d2505352e6so29520671fa.3
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 11:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709319910; x=1709924710; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=A1KumXMvs94AkoZIHrVcipeV0Nv8ZwgZzsg4ytbfNNI=;
 b=SZKQulceShgDc9gmLZjkgvxvMEOSPfsdiBVKqIkJDrNX1DOifh/pPaG3rRxp2cXaWr
 hGyvabi7QXWAwLZJ3hptotLN/g5tsNFYOrreliM6xIWijyDIyPryb21jU/Aggj/uAJiA
 5XYzEDl7cYdl63TWZC3ic7Pn4iRaTs17E3zpfH8sV2JTN3WXV+Tz2faQy4l/B25OOngO
 uSH80rLB7N2DDue0BKKrnSROUaMDDMN/rW+ZnFQJ/qKjcbAQO6mc3Z9uAKoneIgEIuW5
 WqpG/FAgktNy86SrKQOp3xKF9MzIbAQwpMADFsdMfix6KnX9VWxtUzJnPFIQ0YCRzPR/
 8Gxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709319910; x=1709924710;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=A1KumXMvs94AkoZIHrVcipeV0Nv8ZwgZzsg4ytbfNNI=;
 b=fFCTqda+F3o36xK3/qS5TSHnL+bp8t/1MiGMO4+k5KR/MMuMmPtrVJjHguKfdoxzSE
 nh5nq5oA95LjifEexv5DtPIEiPQyb+bJooOtjMn6oL4nyHGnISX4z2pMyPbyc8BWD1Gw
 C+fkpbkkFpne8a+ata48jDreE6z6ccUuYGiCaY0EFKm6QD4E5JSmlxHgtnWt17Y2hGQ/
 ggUnD7y4UGoPDiciGXmhXY/hN5HLQ6R1ISGRCPI9glnMCTpjeC1PMxuc8HpCqKEW/Ue1
 Y3fy0sW7kWpITcug+5TOd1WNvYFGXbRTfqhZT7scfai6dsu28KFZBLjLym9VEO9XhIKj
 uOwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCHFONqX3CsBkSUvpjtfR+yoLYD9TvRO0A5fvoHbMqQqt0cx8FZIriowFQk15wZeA0ZzLv5CGy6SwVr4Swd57ikpQfSw0=
X-Gm-Message-State: AOJu0Yx1PKntuA0OeTrqoHAqzptFeW9R5UvPIb9xV/KHTVF8pivFZQhF
 4pgEbhMYgysUdQmudb5JG21mf8XwMqOR9uLkMh+Ftfi7ryzBHyJ8qlPP1e9fBdg=
X-Google-Smtp-Source: AGHT+IGFaqNc8RL9F55uD9SX9X77w4nDoRzVI60Q3ICjQDqJzDSD47xSDfhkstAEGWmBhKnr0LZfJw==
X-Received: by 2002:a05:651c:2dd:b0:2d3:20f2:ff29 with SMTP id
 f29-20020a05651c02dd00b002d320f2ff29mr1695316ljo.36.1709319909674; 
 Fri, 01 Mar 2024 11:05:09 -0800 (PST)
Received: from [192.168.69.100] ([176.187.210.84])
 by smtp.gmail.com with ESMTPSA id
 s16-20020a05600c45d000b00412b67388f0sm8572229wmo.6.2024.03.01.11.05.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Mar 2024 11:05:09 -0800 (PST)
Message-ID: <043b6698-ffe4-42ea-a56e-10b2976a7bd9@linaro.org>
Date: Fri, 1 Mar 2024 20:05:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] target/arm: Enable FEAT_ECV for 'max' CPU
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20240301183219.2424889-1-peter.maydell@linaro.org>
 <20240301183219.2424889-9-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240301183219.2424889-9-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22b.google.com
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

On 1/3/24 19:32, Peter Maydell wrote:
> Enable all FEAT_ECV features on the 'max' CPU.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   docs/system/arm/emulation.rst | 1 +
>   target/arm/tcg/cpu64.c        | 1 +
>   2 files changed, 2 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


