Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AEDDC48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 11:04:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfeD1-0000H4-6R; Thu, 29 Feb 2024 06:04:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rfeCy-0000GV-Ln
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 06:04:13 -0500
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rfeCv-0000AZ-SN
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 06:04:11 -0500
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2d094bc2244so9565801fa.1
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 03:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709204647; x=1709809447; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=N9zLbaFO/RECE58f9323vvtDq8jRLk1AZi3G2mWE4dA=;
 b=LXErKTLzHgd6jjCPO2cEK/4tJw2AWyzlbonqBZS+Z/u13IiDq0C9bdRef42+NFRJ4u
 RGUPKL4Z9aH9LtwecL1/350mpwceieLP1U8d7TBdV9x/7ycVxKuTpJvCf+49p3R9/NMJ
 ye2nbinQoC71SI7JsO+1tjmchA3oTFY0SGFjAjbCZx1PNatovMMqkZapSqfm3PncpTib
 gYDhF8tdinXdvB3AlGTgfes+8NikVrVx6El+0us/biUDns5lNqzWI1StrTzvVV6fbCGW
 FwWaGMjGPBMBgzaGx4DG7p6on1ei/a1LxCHhmHWoJQKzzdrLzl8LiLKUOQoZzHOco4zo
 fIWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709204647; x=1709809447;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=N9zLbaFO/RECE58f9323vvtDq8jRLk1AZi3G2mWE4dA=;
 b=Yb+95q619FB3FHevuDCkcf6HP5tbfRIaooZeaAxszQphTH6gTQDzGnsIBiU6/GyExe
 M61kpYrbvPW5lU3XWmO7Brw+Hh1VQT+qaBy+zJB3bnl5DBp1Xf/NxhEiy2R7IV4oWNOo
 CMq4meg+KJOAjIAfJafaYjQdOO8NWQushHNxACbXlEAvMJuiNGbtItxQSVYXCChXvU2u
 E3+Q5xcbkngJ1fHSa2rcS30SzYP4TC52Je2nnFXyhYG2aPWQOGaKjFgcUzPVieJACVOJ
 eY/Ksa3m2xTGzFn6vwq8+EHxoOjwwgzR28Q7+Ns842i2OL/ZDPErNr86lWmGdDo0Rbot
 NLbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWd8N+3SgOKiP7XRg1ICvvXZwxrC5OHcUi3W3vMa1grOkM1MFxPV0VE/NZBKTMlVlkj719ObR75JbbvqH72pWh9nmVECEU=
X-Gm-Message-State: AOJu0YyfCQ/pkVW9zxeXehjI1sjIpMDizaTDIdnV4QlhvqCFxdfahDb0
 91FaHn7d/9zeJkcomDYKATVGPTqmXPVfG80Yt7FfBX5wH82Obc6zjCz6ycHJymo=
X-Google-Smtp-Source: AGHT+IEuJpBoxEnuInDVndL3SZMLKbLPWkw1jfacrojwXfRCGOD+vzrehB84+ZCqj4oxlpcDar5yfw==
X-Received: by 2002:a05:6512:e81:b0:513:166c:353f with SMTP id
 bi1-20020a0565120e8100b00513166c353fmr1241316lfb.38.1709204646911; 
 Thu, 29 Feb 2024 03:04:06 -0800 (PST)
Received: from [192.168.55.101] ([80.215.236.171])
 by smtp.gmail.com with ESMTPSA id
 u23-20020ac243d7000000b0051318551937sm208690lfl.162.2024.02.29.03.04.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Feb 2024 03:04:06 -0800 (PST)
Message-ID: <ffbd52ae-cebf-43f0-8ff7-a983a7cdf87d@linaro.org>
Date: Thu, 29 Feb 2024 12:04:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] Hexagon (target/hexagon) Add is_old/is_new to
 Register class
Content-Language: en-US
To: Taylor Simpson <ltaylorsimpson@gmail.com>, qemu-devel@nongnu.org
Cc: bcain@quicinc.com, quic_mathbern@quicinc.com, sidneym@quicinc.com,
 quic_mliebel@quicinc.com, richard.henderson@linaro.org, ale@rev.ng,
 anjo@rev.ng
References: <20240226201722.391879-1-ltaylorsimpson@gmail.com>
 <20240226201722.391879-2-ltaylorsimpson@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240226201722.391879-2-ltaylorsimpson@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x232.google.com
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

On 26/2/24 21:17, Taylor Simpson wrote:
> Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> ---
>   target/hexagon/hex_common.py | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
> index 195620c7ec..4bacef223f 100755
> --- a/target/hexagon/hex_common.py
> +++ b/target/hexagon/hex_common.py
> @@ -1,7 +1,7 @@
>   #!/usr/bin/env python3
>   
>   ##
> -##  Copyright(c) 2019-2023 Qualcomm Innovation Center, Inc. All Rights Reserved.
> +##  Copyright(c) 2019-2024 Qualcomm Innovation Center, Inc. All Rights Reserved.

:)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


