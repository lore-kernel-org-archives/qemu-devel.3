Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FEFBC27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 12:00:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMRJb-0003lE-NA; Wed, 26 Jun 2024 07:59:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMRJa-0003kq-55
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 07:59:54 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMRJY-0008RG-JH
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 07:59:53 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-42561c16ffeso581075e9.3
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 04:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719403190; x=1720007990; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7wHcWilqVSRZPvFxkj06uhy4pkzct8uXR1y7Br2IGyo=;
 b=eiXqcgmAG1NTHiH6d9tUq228DWe1DQu+eTbGxf8y8XEsoSEeqPfvBiAdYPUwKykKtO
 faUHleJf8+rzkioLd9HnvEtCErY/3QmiN9tuK2FE60nuTCN5TywNlZbU9Xm74oZRfLLQ
 MAPGduEOcBoGbYO4AiCojJm6OJRrT0xs+M5C9F9oxs2g4EtPoe5x6OYXcLVoMrzkNCR/
 xV2P8VL6SVoQ46W+iuYaRbgRdbyXhwrRPi5Zvlg9XRXJJzg9fTd6RsgPu+fE51l13YOE
 3NFe7vXsTWFRgVcD9bheqcVcWtB1OE/vC/nq2VgeUtfaOXoyiCfZrPCexTyizWUw3x2g
 PHxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719403190; x=1720007990;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7wHcWilqVSRZPvFxkj06uhy4pkzct8uXR1y7Br2IGyo=;
 b=n8wBKcM6S1ZfLek3HTULB9gYNxLa84mU/k2HO/m8gC/LdUyrCBl0mmLYmmE0FK4uKE
 FgqyuSjChWTseMR9rK0YDETMnYOCY2T+l5R4cW03lyIuTrRJDMCnmHrFLmxX9EAWTCpV
 0NV2N7v8UhRYpY+UZOePbwP0HYiYT4i0v91DjHepWU/F7WtzdDGUVGeneBFqw8typRos
 iEVF/tcu77tFLrXLy7JDgkz+ZLnfW0/JEJr1chLvOMqXtGAdrlhWcGEHITXsY+9mHgOY
 2Xb5qz9E+ri85fO3EkFfEZPJPbmbw0hlKDWZaFEH31iPlPmIccF0ALnVUtsrdyuTfLZi
 wQfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlZDwLYuiFDi69IAVjRxRDi8TAEl31Y1RlZKWynxmblfbskS3gB9l8IIXmgpDXg7DjOWBTyxNDMLVwrw/P0VSIuIpGeFA=
X-Gm-Message-State: AOJu0Yyme5wdfS0ayQaqh4Ocwg2Pd760T2FEMcXjCNJ+28eP2B4zyXbA
 IjRp+TVvMcet22UfW6oyI6vCeGd+lswbuJdGDCV16wqeIOig+ufGyRDXqzGDGbw=
X-Google-Smtp-Source: AGHT+IFbkM6EGc89VPRfeNSwpIH8kVr6dyOl5JZQcU4Wae212EsXiuzf+/Cll3sS9WtLWGn7X87GvQ==
X-Received: by 2002:adf:f48c:0:b0:35f:1753:7159 with SMTP id
 ffacd0b85a97d-366e948e6ccmr7028384f8f.19.1719403190135; 
 Wed, 26 Jun 2024 04:59:50 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.212.234])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367011c4600sm4320196f8f.61.2024.06.26.04.59.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jun 2024 04:59:49 -0700 (PDT)
Message-ID: <6be35719-6dc0-4e3a-b0db-3614f0c028b0@linaro.org>
Date: Wed, 26 Jun 2024 13:59:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] tests/tcg/aarch64: Explicitly specify register width
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20240626-tcg-v1-0-0bad656307d8@daynix.com>
 <20240626-tcg-v1-3-0bad656307d8@daynix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240626-tcg-v1-3-0bad656307d8@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 26/6/24 13:26, Akihiko Odaki wrote:
> clang version 18.1.6 assumes a register is 64-bit by default and
> complains if a 32-bit value is given. Explicitly specify register width
> when passing a 32-bit value.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   tests/tcg/aarch64/bti-1.c | 6 +++---
>   tests/tcg/aarch64/bti-3.c | 6 +++---
>   2 files changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


