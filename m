Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3090DC4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 16:50:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXOeQ-0008Fn-Q7; Tue, 06 Feb 2024 11:50:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rXOeP-0008FQ-J8
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 11:50:25 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rXOeO-000768-5O
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 11:50:25 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-33b189ae5e8so3049020f8f.2
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 08:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707238223; x=1707843023; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=s49/HD0qFkU4ujycZbidgOmgKRRWit3c4XLOPxJLbLA=;
 b=gWoMrBQLca4MKlUOxl0oTqVNej3Yu90ugE1ArKt0tU89In5LAiRYp+RE6al/O4Nln4
 h534StnoGUC1dda/CxsFyLdCaTjTFmYn9IROQc9QIdj+ArpH2e/oKcR4InPETItUQjZx
 ro8iWi2eWBE6sA3TDuo1WfgOYe5a/3Oz9qmZDxPKN9n+esiRgK1y0dtV0IdbWKZ3Xswr
 OHFAlH7hY+2lnfyG8Bd6G99CSvJC2dXe1a4Ot5gfpMq2cA9WsCypbthJ8RV6GLBmfzW7
 eDXl88sEo1VAqKW0BW2WR74Kw1obymaFcSJrsxobDTY6pL+z4pZlvWg8Nq+vrT/ONoXu
 itYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707238223; x=1707843023;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s49/HD0qFkU4ujycZbidgOmgKRRWit3c4XLOPxJLbLA=;
 b=gMc4IaQkT8KW5kpZqAfBX6WbviM2uWKJ0r3AxkpPB7jhXT5B+ihOwTiqjFN5x/6gHt
 Coa2CEyZxzfyuUXctIXCZVBLqKxuOpuvFsT8DrXnCr9YRDMrPZg1+1cLlNtRRFm8jsc4
 nNv2OBpJE/CrNYWRdh6aVsVPGowjzOx45tOQZwgkOnvJIbWY9I7Bsq1OwKfKeH1zFt73
 v5NUu7+ynuzujhr4O/2gypPUg2G969S1r4rx8r+/ZrpZX8twW5cu/YC6DXt229Sgny24
 BaAFtakIlFSOe2XefofD5N5dGztrMoH2oFWV3dLDGT5RZshhzieofztLgKiH10HAJqVz
 ufvg==
X-Gm-Message-State: AOJu0Yz7zQGUS0B3zAYR50GDlxxx5WjtXBMfja3+j+Ib07AnDtvIydhH
 UC6c5DlcFfcYbO/MQvaG8o7XaMx9cWnekkNSD7LFgO3H9T4aFRKPhFl7FhrIMmE=
X-Google-Smtp-Source: AGHT+IFgk37QLgSR1mzlmyGGX1G9Zqg6067WHf/pYRTRPzcE6zuv8bV2BhKuIkinFq+Rfz98VKmNIw==
X-Received: by 2002:a5d:58f0:0:b0:33b:296f:defa with SMTP id
 f16-20020a5d58f0000000b0033b296fdefamr1842839wrd.9.1707238222724; 
 Tue, 06 Feb 2024 08:50:22 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWb6QQlk4KNn+adOCDQS6DL2LS3IC2ND6ua2Lu1uLmP/sNyrORGlwM5hfVO0fU/rC1WZY7sfF7DRebx7TCXpiBs9uZdWS9c9+OFITsEh/wyIXt4aodIT+V+/0I=
Received: from [192.168.69.100] ([176.176.170.22])
 by smtp.gmail.com with ESMTPSA id
 l31-20020a05600c1d1f00b0040e3635ca65sm2534632wms.2.2024.02.06.08.50.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Feb 2024 08:50:22 -0800 (PST)
Message-ID: <8ed5b586-d62e-47d7-b74d-2c4ab63331ef@linaro.org>
Date: Tue, 6 Feb 2024 17:50:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/13] docs: Add documentation for the mps3-an536 board
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240206132931.38376-1-peter.maydell@linaro.org>
 <20240206132931.38376-14-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240206132931.38376-14-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 6/2/24 14:29, Peter Maydell wrote:
> Add documentation for the mps3-an536 board type.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   docs/system/arm/mps2.rst | 37 ++++++++++++++++++++++++++++++++++---
>   1 file changed, 34 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

