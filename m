Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 327EAC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 19:04:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg8BU-00046g-Vr; Fri, 01 Mar 2024 14:04:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rg8BO-0003xQ-5O
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 14:04:34 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rg8BM-00053o-FN
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 14:04:33 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-412c23551e2so11150425e9.1
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 11:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709319870; x=1709924670; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sbbQzXlvGesnWORgLlEla8Z960pQ0cPJxPFpzNxBQjk=;
 b=AJVd+vTkmWHEBYfngJ9ZT/7+DFU0H8fIdtFxVhBR0UNELq+uAVd9Eq72uaLokY2L/j
 rusPuPOCQvdO9iH7ISNb48sepz3jhCJVu+wWht3pjhunwkkm+w4qBVhw945ECZrUz/r/
 jz4Qz+VkHTNCe5qhJnitjvoVIOm8VbcZFDYlrLHYKSYikdk+xUBu5+sXn59+FqIt1K2H
 KnJq5tdecpsX3vnRv7LMyCn/+Uo+TqEEN+8Q+S0aUlwHevaNJcik7W0lDBkg3lZooWPe
 lTzJjDofR9NsvFf5jxP0IvZKnwVgn0N0uLAnGYz0QuJDBhES/spuH9+AbJQUbw0VZLNc
 kX5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709319870; x=1709924670;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sbbQzXlvGesnWORgLlEla8Z960pQ0cPJxPFpzNxBQjk=;
 b=XpkI1jW2IN62BcLdsDvnPxc8cJMr5lgxbz4IhRBHnLcAOiPwTCcfxbE5g+osz8y9dy
 LCauSmt59uyuimeBhtX4oOtDjM3LguEe+P+mZ68yoyHV5kKCgDb8U7hWn7Td+0S+eAFD
 S9K47TnM0uF+unltin8OJeFBby2LFq+cri26mPmfY7FYk569Jg12Zt220HTobF5OMofE
 HWSEMAzr96odG/h3Im5YVHw6BqsXf2jeDz1oKIK0eqFhfJq3Za9Y4rDdlmpC3D+AiCtJ
 JYKZh2pt11U9I3D3GCVZKUiIQ4osa5eYYRTUlOJRQNP+Kw8MhcGJyHsofpIQJP/HM5ag
 BLEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcUAVDFATqEukziojT+5cx9WmidOpmTmw+3evlCEG6lt73tbMTbsZ10FR5q2B5J9om9O9uXBNK3tr1myCE0VOhP4gtq58=
X-Gm-Message-State: AOJu0YzOHAKdCsOLasX2OrfiQwCaZ0KBoNqUkitJRvIh6Qd2HDRn2dpI
 G+oVVMNmoXOXctjjCSnfMbLvzzatKh3ofRh2xTxX1NZQPR6oNdf1SPvWMl2jO5gLrYD0RWNFhEJ
 MhLnYwQ==
X-Google-Smtp-Source: AGHT+IHbCXuVA2ainRkHAvZ364EMm4SlixsGRIrVCxgpNhgWHhe++W0Pvrp/riAXUmu5ot+5xhGl3A==
X-Received: by 2002:a05:600c:154f:b0:412:bca4:6a00 with SMTP id
 f15-20020a05600c154f00b00412bca46a00mr3287036wmg.18.1709319870300; 
 Fri, 01 Mar 2024 11:04:30 -0800 (PST)
Received: from [192.168.69.100] ([176.187.210.84])
 by smtp.gmail.com with ESMTPSA id
 s16-20020a05600c45d000b00412b67388f0sm8572229wmo.6.2024.03.01.11.04.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Mar 2024 11:04:29 -0800 (PST)
Message-ID: <1068621a-fce2-4c1c-80e4-a9f5cec74e22@linaro.org>
Date: Fri, 1 Mar 2024 20:04:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] target/arm: use FIELD macro for CNTHCTL bit
 definitions
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20240301183219.2424889-1-peter.maydell@linaro.org>
 <20240301183219.2424889-4-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240301183219.2424889-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 1/3/24 19:32, Peter Maydell wrote:
> We prefer the FIELD macro over ad-hoc #defines for register bits;
> switch CNTHCTL to that style before we add any more bits.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/internals.h | 19 +++++++++++++++++--
>   target/arm/helper.c    |  9 ++++-----
>   2 files changed, 21 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


