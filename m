Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C118BC4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 20:29:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXoXN-0002YK-MQ; Wed, 07 Feb 2024 15:28:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rXoXM-0002YC-5m
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 15:28:52 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rXoXJ-0000fv-J3
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 15:28:51 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40fd280421aso9540465e9.3
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 12:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707337726; x=1707942526; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zT/I2jyxv8Y6sRBMJjpn4cs8UMqDcuyYLnU2M2pYSaA=;
 b=P0fuPjCZiEzSbxHltwLFbgoy2rxVyBm/iqVsMHpDfy4IrySeAlwmkF8M8SrIOBpPMk
 qh7OHs/evcl9jlZn0dou+zL86Qq+1NOAMIMM3gk9Km57PjXQWgjpOsHOKCDr/IbbFiu6
 4T3qLyJ1cjNTWSjFJ511XKh9NrIboUL436ZflpQ+m7kLZ7gFBn+896OHq90vq4od8w+s
 kLr23Rl4YEkMPnVgpDpggfFl8mKYy9Mw2Quf5pW+M/YYbcuCUY3Qh62V/bGtZX1TjCyC
 KupeVcRdyFH6k68C4EKXJzLIiDapQhm4jjva+9IWM0XNPSkz1UL85mfhuvfEsoukYVol
 nCfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707337726; x=1707942526;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zT/I2jyxv8Y6sRBMJjpn4cs8UMqDcuyYLnU2M2pYSaA=;
 b=ey2UIZW3pvLXb02ZYSjmowi4rmJLrNnsJ9YLcmjtGQSGC0a1zLzxEMIsnyEYnQd2hz
 gaCrEvPX/H7TajQrcOfkgsAijYQ/OhlivVo0+oXVyVIaaGO0sur2UNvA6bAJpp8aPGvt
 lDZXxAYmpjA0uUA+TpObwsHYeLrJXAvep/hD3W1tpDUBKRKjTlIobpJuA+ahylbSHvBV
 NfqUK8+C6dEJhkcZ0d8U+n14Gcm+qWXbLsfXFulb8N8T0wUDFyQeix0IcWDuwBCDMxgu
 3ApuJgVjbX+bjYRSmbKuCSBhePJOKwicH/vQ2XMNAL7mAhbGPyq05TnL8jJLWGzUutla
 JVJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDSJQoBQ2sOiTyML0+yZN1qhIYx6qIeYBhu91YU/Lq0ly9C/a1ev0e+6bl3Hn7pEl5znZGSVV0agOWfpwn/Grfe+wSfC8=
X-Gm-Message-State: AOJu0Yy+/PhSCqnPiaPDkS1MJQGQcATc8vkk9YLAW2ZWbexCuzGjx2j3
 4UrY5C5AOVMtVDKsVyw7AXkWxQJUhjJor5R7aGh+XMmzYHwgRxd/MG5+6/JuAUY=
X-Google-Smtp-Source: AGHT+IH0TOkbc2DSI6KQljqnMERpO4FLwUMLPc7uhGSXg8QGLrHPVxNFY7kmsMgcPBLU5du9I3FAyg==
X-Received: by 2002:a05:600c:998:b0:40f:bdda:161b with SMTP id
 w24-20020a05600c099800b0040fbdda161bmr5359779wmp.22.1707337726000; 
 Wed, 07 Feb 2024 12:28:46 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVggWr/FFLVx6egaHyshsIEBGpCJSI/2YGBT7isVcto54EZ0MX6bcACBjR3nEEzeX3ln6zV9NKluE0ph1prgtjtVuZx+k1nrC3No454Rnbbqvm+J/dyylYwaCo2YctkwbYPrfOOssGNbMwpWNKPVket1iSo3FcZrBrIvax9DgQUJc04we4pOHRL1GKONe8zPGQMCJRbuY5X84LkZr/D4d+HF2FoYdLv1+A9pfAwSopV
Received: from [192.168.69.100] ([176.187.214.82])
 by smtp.gmail.com with ESMTPSA id
 d11-20020adff2cb000000b0033b278cf5fesm2203720wrp.102.2024.02.07.12.28.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Feb 2024 12:28:45 -0800 (PST)
Message-ID: <09f9ca34-4e0c-4ada-b808-643a8c578511@linaro.org>
Date: Wed, 7 Feb 2024 21:28:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] aspeed: fix hardcode boot address 0
Content-Language: en-US
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com
References: <20240207195224.452987-1-jamin_lin@aspeedtech.com>
 <20240207195224.452987-3-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240207195224.452987-3-jamin_lin@aspeedtech.com>
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

Hi Jamin,

On 7/2/24 20:52, Jamin Lin via wrote:
> In the previous design of ASPEED SOCs QEMU model, it set the boot
> address at "0" which was the hardcode setting for ast10x0, ast2600,
> ast2500 and ast2400.
> 
> According to the design of ast2700, it has bootmcu which is used for
> executing SPL and initialize DRAM, then, CPUs(cortex-a35)
> execute u-boot, kernel and rofs. QEMU will only support CPU(cortex-a35)
> parts and the boot address is "0x4 00000000" for ast2700.

This justification from here ...

> Therefore, fixed hardcode boot address 0.

... to here is still unclear. You provided an explanation in previous
patch, maybe worth including it in this description?

Otherwise for the code changes:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/arm/aspeed.c             | 4 +++-
>   hw/arm/aspeed_ast2400.c     | 4 ++--
>   hw/arm/aspeed_ast2600.c     | 2 +-
>   include/hw/arm/aspeed_soc.h | 2 --
>   4 files changed, 6 insertions(+), 6 deletions(-)


