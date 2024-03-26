Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E9E6CD1280
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 09:57:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp3Xo-0007yU-Hy; Tue, 26 Mar 2024 05:56:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rp3Xm-0007tY-Lp
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 05:56:34 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rp3Xj-0006zV-BN
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 05:56:33 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-41488f9708fso13093085e9.3
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 02:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711446990; x=1712051790; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qeE5IqzdinRWh6lTlE0AtWqMokUPKMdMOciWC6LfJAE=;
 b=q8Zk5Rb4OTLBovvAs3Ydr0Tp0rP7R9kZ5CGA2R57WElXnLxBIGQGMVbJLbVAHo7OAh
 X5BLsLe9ELPbCVa50LZTezQ/sHZiRvzcQtdFkbrs6hfUD6otd2EWQW7r0WUG74hyuItL
 ecOb6vVVxErVTwRaN2pjVdJ3xgHVzXIFHhq28pzK8bsQv/xbUNcE6YrUU7t1k/8cX8QD
 6t2ESk7Ymm8aQXAO5ynUzFTSLWk67z+3V1ukCxExrD825Ag2X/1cbntV7IIugGM0T6FK
 kVboPIup951wFvs50HRFU3qOLLqrw9/tI/Tgj0rFCIrVfWmxyDYo59y8JPnMR9ESgFHo
 sFUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711446990; x=1712051790;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qeE5IqzdinRWh6lTlE0AtWqMokUPKMdMOciWC6LfJAE=;
 b=uSVKlHNb0mOxfnarls5kRwiMJl11eNFh9aoiLlV2bwoAbhb7fzjwWyUQ/qKiu9vRl0
 9cfTCnk4TB3sl2g8DmNUTapW0jH09U5dnC9zpY7aSVF/VbVtw1kmcE1nevlPOvRmlOcT
 Imgkxls6CyUFb2sCo6OaFVLUnVE5wZ0A3W9pLoD0tveSq8yLqB3FgutqM577vE8mjHy9
 ONiNTI4yEEPFD2TTQzc99c42j/RkYQjeNbHcGZLuV3oSd/GJ/38SPV5rcO0fRRjOoHi+
 I+5nH2w+y31P1h5OsqLq0Mtlgocw76Q7ta897lHdweOxNdAhX9MD3Q1p539tkupENaSf
 7nCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWj0r0zM0lMquRco0WftSNuxQJQTZD1AzG3WGSplPUUz75BFfaourQxL58tqwCzZ/u9rmbTY7SUnUwbmnPq/iwICRjUoXo=
X-Gm-Message-State: AOJu0YzIAAXaL2QV1VLN+LEn3OFZN/XKaOZm0ZewJI5znInvFINS171/
 h3+YP/vJ0cSbpHMm1FvdYAUmhTXuKj9EsLG9wx2EINjAOIjirXj3AN/dS0gGGlk=
X-Google-Smtp-Source: AGHT+IHmQIRTDEIOw9WFpimkhJHl7IXlFHt30wjN6LKdKXnpUUjIazryJ1GuoVvCRIURrW7j6gutTg==
X-Received: by 2002:a05:600c:2e51:b0:414:250:ccaa with SMTP id
 q17-20020a05600c2e5100b004140250ccaamr6858790wmf.12.1711446989647; 
 Tue, 26 Mar 2024 02:56:29 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.155.229])
 by smtp.gmail.com with ESMTPSA id
 g4-20020a05600c310400b0041462294fe3sm11043010wmo.42.2024.03.26.02.56.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Mar 2024 02:56:29 -0700 (PDT)
Message-ID: <a8408559-7eb4-4643-bae7-4039f16ef00e@linaro.org>
Date: Tue, 26 Mar 2024 10:56:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/system/ppc/amigang.rst: Fix formatting
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-trivial@nongnu.org
References: <20240324161148.4650D4E601F@zero.eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240324161148.4650D4E601F@zero.eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 24/3/24 17:11, BALATON Zoltan wrote:
> Add missing space to fix character formatting where it was missed in
> two places.
> 
> Fixes: 623d9065b6 (docs/system/ppc: Document running Linux on AmigaNG machines)
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   docs/system/ppc/amigang.rst | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Thanks, patch queued.

