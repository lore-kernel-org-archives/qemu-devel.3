Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC8C0C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 10:48:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1OYI-0006QK-97; Mon, 29 Apr 2024 06:48:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1OYF-0006Q3-SJ
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 06:48:03 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1OYE-0004Yq-DT
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 06:48:03 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-34b029296f5so4343182f8f.2
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 03:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714387681; x=1714992481; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=25/Ck7HxUQDOucWH96PH/43pHzrY12U9E7u6UpNWF50=;
 b=C4pzr7yzaA4BBwNbx5+2sHKyiY09eFJB4GCCmuaOa+klNImssceZEyRP1A/DAMOTgi
 afi9Pik1B1cxjX9z0wOf3YM7YoVutbUFkG48Sk2Z6Hl6ep3+vHA1hdwuyQRPVBqTkw3s
 +Lj4llkT95vsR8U4rTNe0l1TLYR/7Vubaw1DIFScFeQM6MclKB9Xtczq2rOi8WEDIaJe
 AA5ZbtckfDi8EDPlTZfvPImm98lYZJjQOptC+SjN+NV0y3UW8lq4xJ4e6aOpZgWIwPGy
 oH4CztAeCXXbraY7CuCZ0yngLKH3SVchfzbmdrptKWn5Y8xy6tU/OT34CsaWj7D0MpYE
 4Glg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714387681; x=1714992481;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=25/Ck7HxUQDOucWH96PH/43pHzrY12U9E7u6UpNWF50=;
 b=iVTr36945icubd0ZR9/1fEHHRu5FnttqnTLf/Ld1yf5TVPHDLE4kWCFtlY1alG+7Y0
 AKCK9DWfYhjQ7zwnZV9aP33x3wJzbp48uCIjU62WtUCHdEtAU39NC5OrkZJKYsT38pwC
 TDI9Ju1YVx2qPk5fSKO0O6/fFyFFzq3K3KZ8oVXJR5k2Q0rog1atsitaYRKUv4LaGM0n
 JPnruccm6vTPGjsaygF1YCBkMxKZaR/uApczcV/GW/hkIczpzdUTawix5lOmV533XB78
 wIZXCOLLZPd31DDgbI+gtMv3PrGLRo+1TRfKD75y3IQFQ3lRf94Ye1yjO6lm1f/A6ZS/
 u+2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0aEzCSa+mOrRMcLbUZNem7Csjdi8EoD/S9oeh4wd4kGo/uE0PnKsF5rpkhVBPcnNFUvwFo2utUGtIKHWAMx0LvyquXxQ=
X-Gm-Message-State: AOJu0Yw/+Cq2KxlLs6xDQXzMV0LB5WAPL7FmFaKLJx7HaH/LXfjTjRQk
 t8TODjuvw5o6KwPThCkz74n4nkUDE0X5bzu9eKRro+0ZEAhBOuONswZPCXTmRKQ=
X-Google-Smtp-Source: AGHT+IGsTaYWbvzRr6Z/TvHpFxfZVTGO/f0SUsGM4SkazImLvUz70vQgRS55tHb9R4WcluFO57+L6w==
X-Received: by 2002:adf:9dc7:0:b0:34c:924e:14d3 with SMTP id
 q7-20020adf9dc7000000b0034c924e14d3mr5871247wre.30.1714387680718; 
 Mon, 29 Apr 2024 03:48:00 -0700 (PDT)
Received: from [10.79.37.248] ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 f15-20020a5d4dcf000000b0034ccf959d6asm4250918wru.74.2024.04.29.03.48.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Apr 2024 03:48:00 -0700 (PDT)
Message-ID: <290a1eb0-67bf-497c-8a7e-25c863be7135@linaro.org>
Date: Mon, 29 Apr 2024 12:47:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 23/33] target/hexagon: Use translator_ldl in
 pkt_crosses_page
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240424233131.988727-1-richard.henderson@linaro.org>
 <20240424233131.988727-24-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240424233131.988727-24-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 25/4/24 01:31, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/hexagon/translate.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


