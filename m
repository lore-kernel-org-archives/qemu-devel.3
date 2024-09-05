Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF3EECD5BAE
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 11:48:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smAyZ-0000K8-5i; Thu, 05 Sep 2024 07:48:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smAyX-0000An-Lt
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 07:48:34 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smAyW-000168-3L
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 07:48:33 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-42c7a384b18so5625265e9.0
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 04:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725536910; x=1726141710; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=o3LeNeqFA1chLo4v9reQ6Zo07hWo9a7KOgJu8yzKmoE=;
 b=yqhxsVgckAPb4FGnlnjZG7t0KuR9MHhmDW+8NE30fYklRXEDqlwn8N00KPyhuAnwNC
 PqS0mcuRa37apaU46AHwciV3I8WRicyhzUFZ5z7WmrI/pReZ2twDUDhfS1OXo5TcUFpG
 Yxp/oCV7NMX9x+NLXErlzXZopjGdmo4Si0tJE7/MNoZ3VnnFjHGlfdwqbpzxeMTIsmaj
 2wwN/0jxdY4J/aSE1Z4lHyDQ0P4A4DvUNAaPgr31EIryyOk4b8JRRq5WK312K+RNvHdN
 VJgkrtlnfT1dnqnMcGPZGUKP6x8uLU084JZluo6FjIVImNafmm1boN9nHoAwXdmtWyWK
 HTtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725536910; x=1726141710;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o3LeNeqFA1chLo4v9reQ6Zo07hWo9a7KOgJu8yzKmoE=;
 b=fyvnDu5JEADm0GXedIgEoWYz/jyNlUJRS3har4slAaK1l0uvEmNYbCl+YMR720hf4Q
 bvadICoVElDTulCLfFZN5vTKBRHmcCm1T0JtbVQQmgKQK0XBgf4dHZPOVpmP+O5K50eP
 y6TxB+Xyxv5wGQYoDsNvAGiMfhXJTWmQdoOZc3uqLGJHebhM25ADdcShh2Rgu/Yqww9W
 k/byZ0cG9pnsBvZA99gIja9gqQnO4pCuiAGzxnAgh8rULKwsP3mjamo6EVCKS+/7fBG1
 M4stTG69ebreZCBmMtsvum92S4L3Rvhz6oYCf+bWreNbNOZlRmDnKRtpTNmb0Dwuan0O
 8QMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSkxiw2Qfg5/xZiZ4q7jpgIovF/jBqYrt+pbfnAAF+OPIBl/FLYKO+TT5GwFDPET653ZuW8lU2P04x@nongnu.org
X-Gm-Message-State: AOJu0YyE+JYjsvRL+cWCld2XILRESf3AcSo7tvlg5TgNrUcf7l0XSKNL
 rWlwHobV6H4SxE4ghFA1IHNN/fFf9JRJuivYqqf3WapVqzl/j4gfCjZP3s58Tzk=
X-Google-Smtp-Source: AGHT+IHayxmaVh6NKchzoJSnWMcrlIFA7I3FZbb+WXENrtUslaI+0DmAvs60tmWc1PVtk0Lb2ywEGg==
X-Received: by 2002:a05:600c:154d:b0:429:cc03:6450 with SMTP id
 5b1f17b1804b1-42bd731ee10mr132357145e9.7.1725536910347; 
 Thu, 05 Sep 2024 04:48:30 -0700 (PDT)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42c9a5ed98csm16992855e9.0.2024.09.05.04.48.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Sep 2024 04:48:29 -0700 (PDT)
Message-ID: <2a70e589-50fd-404c-9d7c-b34942d904ee@linaro.org>
Date: Thu, 5 Sep 2024 13:48:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 21/53] hw/arm: Remove pxa2xx_gpio
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240903160751.4100218-1-peter.maydell@linaro.org>
 <20240903160751.4100218-22-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240903160751.4100218-22-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 3/9/24 18:07, Peter Maydell wrote:
> Remove the pxa2xx-specific GPIO device.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/hw/arm/pxa.h |   5 -
>   hw/arm/pxa2xx_gpio.c | 365 -------------------------------------------
>   hw/arm/meson.build   |   2 +-
>   3 files changed, 1 insertion(+), 371 deletions(-)
>   delete mode 100644 hw/arm/pxa2xx_gpio.c

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


