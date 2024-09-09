Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8122ECE577
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 17:52:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sniZD-0007jX-4D; Mon, 09 Sep 2024 13:52:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sniZ4-00075Z-5s
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:52:38 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sniZ1-0008Td-AN
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:52:36 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5c3d87dd4c3so2087548a12.3
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 10:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725904353; x=1726509153; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=q+H6rs+ItgsedqXQR6BT1tgoIknxzO4oov6O/T3RK7w=;
 b=CkWywX+FTUPL1SBLPE7xHa+bBr6olccc9Z+DFSHkCH+m6qJwHilZkPZ9xnHwfusjhL
 KQK0tXhBsi8pkxVqqJTEVnRbZf6itVAtCBaPiDvUXfK/gN1llBuUI67l9q2fDp4+tJ+O
 cIlq5kYkBP/UOFaClF9+NNJP3IjzV8X1X0GZDMQFHoOAeo3QO2FqtSGcK41gLzW7NbxI
 mhcrm9JhWuOFcJNeVs4N3etkXLStB4XPiKRHy0EamgbfjJ6F9W8hJEqTjQUKovM8ETA9
 SCbB21l1WYaJ4n7wTT3yc0FKz+uSvgOXJZ8s5UAVRLMohhuXs7IJLAHSssOr9l0lmvxL
 gRFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725904353; x=1726509153;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q+H6rs+ItgsedqXQR6BT1tgoIknxzO4oov6O/T3RK7w=;
 b=KodBSG+zy7kyD+Z6hlTFbdiSO4OQBBLKuYSImP1OAP2+DdnB/oA4pAgf7tdBxou6Yf
 smki0OWTaICgVVsHG+WgxiFPsi1Xc5H2k37rEBHcddjO+rxt7nSpcLLsoQh/iHuqxJ/R
 BOM2iVqkwaes4OwvmlInpeCR+LV9VzL+Fl6iVRhuTbarqyc4Sxc81oGdDkQciqB2Xd30
 8oUp+7DnhNT78xKVv5lSaOIUAESJEdRNWKHkVqTF217XH4pKXUeLBbRMEXf5En4ql1+E
 T6RgYTlXYHHPrJNhJhUoBJ8hWgZAggbRr4TALKtQaRgS+QxbRY/OQPddUmXu9L4ugQkn
 uf0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgZDGyj+4cYWt+Z2qZbQSNy8lXIzirUFdyYMpyQ+pNS7ViFiuWfRmBE/r6i/XJRjv4p2ikeOH6TwTG@nongnu.org
X-Gm-Message-State: AOJu0YwurISpwN95Vpc8tRvzOcx4Wuq72AlQ7cY2A2GMA77xD68+ADYX
 Xc1U2tq1NPqoFnVLANOoMu8u1+1zdT/+DgUo7WhoR08K7zaL4uw3NEWS1KPnnNY=
X-Google-Smtp-Source: AGHT+IHMpnubMxGJE6CkiAtLoSIGIln6jBiNFF+UqQB12mkoLGlG5zAZScuLfdHmXj+Z/ouHY3NEtQ==
X-Received: by 2002:a05:6402:3510:b0:5c3:c4d1:83d with SMTP id
 4fb4d7f45d1cf-5c3dc7b7d5dmr9021668a12.26.1725904353438; 
 Mon, 09 Sep 2024 10:52:33 -0700 (PDT)
Received: from [192.168.69.100] (nsg93-h02-176-184-54-166.dsl.sta.abo.bbox.fr.
 [176.184.54.166]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebd5245dsm3302697a12.52.2024.09.09.10.52.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 10:52:33 -0700 (PDT)
Message-ID: <9489b46a-9ae5-46c0-b2b8-72a27112b205@linaro.org>
Date: Mon, 9 Sep 2024 19:52:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 38/53] hw/gpio: Remove TYPE_OMAP2_GPIO
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240903160751.4100218-1-peter.maydell@linaro.org>
 <20240903160751.4100218-39-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240903160751.4100218-39-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
> We've removed the OMAP2 SoC, so we can remove the OMAP2 GPIO
> device. (The source file remains, as it also has the model of
> the OMAP1 GPIO device.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/hw/arm/omap.h |   8 -
>   hw/gpio/omap_gpio.c   | 557 ------------------------------------------
>   2 files changed, 565 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

