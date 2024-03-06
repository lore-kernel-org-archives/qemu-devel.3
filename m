Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DFC2C5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 06:43:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhl06-0004yz-6G; Wed, 06 Mar 2024 01:43:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhl04-0004ya-OY
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 01:43:36 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhl02-00010b-AP
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 01:43:35 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-412e0feb40eso22704955e9.2
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 22:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709707413; x=1710312213; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VXGwh/oAeRzz0RfIcZ0nIw2irzCqS0IIYnFJAT3+TGA=;
 b=zTMJK5qaMZB24oP0ouKBmNk+W11FODinnDLW0e73LVZQ6TnCDqTJQ81teGwcF00Yfx
 yR2NfSfkB4yzkPva60Hu0oFAFyED7Hv4etcqekLe1Vwcv/QpISaG4Gxmw6BybuIncskv
 XpDL4Yr8x4dFVKopx56sI3x49SNjDXsbtpCXYhqbWdfDOEM+HZDjdHtgavJyH0Sp6TKt
 RUbgArxgE/mFSRq26BulM2S0jpKHOZUIDampYWJfLvZzcXJq42ptfMKPHJSBUmSuxzs4
 nlcpz52uLAuAe9GfNqJHcJSHfCibfte8Y373EBkZ0jPBc286pbYX61+/l/FuwTJ4r8dl
 q6BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709707413; x=1710312213;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VXGwh/oAeRzz0RfIcZ0nIw2irzCqS0IIYnFJAT3+TGA=;
 b=SWPqcR5fMubBVOWV2hYsBh93aXQwPcSWhJtNy6HCuddt8Ty3v/tR1s0P1y+vWJgCyS
 n7chAth4t46kDTD/FQkhqsBdrpEfP9LkRtzk7zukFeckHRO1ldrAtfz7Jk+awIPYhEAh
 WVCUHJnAjB7DG8XnXAZAyp+h5H4DPxDB7Pp9FhqdMB7Ob74bjysKg6bJmOpDOGv8PRfE
 rhtboXnIuxt1i3FccnNlDyHiS1lX/Y3QacUOzAp7Fg/+VfpJDyiIcsVFX91/n7L0HxeX
 UguhazqFrgHE2po7Pk971zU6g94mcdMl8ux69B+vZ7lEuvN/ScqJBY6DB28+25xdpnwt
 203A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJUZf9bfPxlBGwCBRFiPPwitdLTZaSPetC9KuuUTnjo/Qlk3eAQ/eYGHHc7i+OzBU0bmFraQbL9ALhLNmFnRUVqlLHTSs=
X-Gm-Message-State: AOJu0Yznzqyp2mD9q0e+aO4LszWUzo/o5Xc+m/GyNj+ww+gtG6cG8Sxl
 gcWzqYpwHgSgHOhHT0YDORS9woXdTlk/xtGW1zWxJE4nZiGx/mJCC+UdEWlglb4=
X-Google-Smtp-Source: AGHT+IG1khc2lE8gq63qTXxsG1QeWq04VSXS+7k6ffnkI7eUvCniW1z/3x95jmLmJKycnimtQlobvw==
X-Received: by 2002:a05:600c:474e:b0:412:f81a:48c4 with SMTP id
 w14-20020a05600c474e00b00412f81a48c4mr206531wmo.13.1709707412710; 
 Tue, 05 Mar 2024 22:43:32 -0800 (PST)
Received: from [192.168.69.100] ([176.187.210.193])
 by smtp.gmail.com with ESMTPSA id
 r9-20020a05600c458900b00412b3bf811bsm19861767wmo.8.2024.03.05.22.43.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Mar 2024 22:43:32 -0800 (PST)
Message-ID: <862d9c9a-8141-4c51-924a-07782930d8c5@linaro.org>
Date: Wed, 6 Mar 2024 07:43:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] linux-user/elfload: Don't close an unopened file
 descriptor
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240305233931.283629-1-richard.henderson@linaro.org>
 <20240305233931.283629-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240305233931.283629-2-richard.henderson@linaro.org>
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

On 6/3/24 00:39, Richard Henderson wrote:
> Fixes Coverity CID: 1534964
> Fixes: 106f8da664 ("linux-user/elfload: Open core file after vma_init")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/elfload.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



