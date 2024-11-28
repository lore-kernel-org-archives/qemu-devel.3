Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07CBED6910C
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 13:29:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGeaJ-0001xl-9t; Thu, 28 Nov 2024 08:29:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGeZv-0001uH-R8
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 08:29:10 -0500
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGeZq-00043s-3q
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 08:29:03 -0500
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3ea405aa7b3so443370b6e.3
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 05:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732800540; x=1733405340; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WH9X2IaqWEVeslxnPTdjMz6ZZ3KemVz2USNlmowLyTQ=;
 b=jesTqxf/rJdVKLwXIVWRChu2cd597HeYRVDUaMCQa1lypmko73jO2p7Q1BBweeQEe+
 pDK8BgFaaCstFyb+5kj6wc2kgxPvoB54QThe+6fx+1+XzmYxt3xAVY8RgMmRxX0O22xD
 r96FMQ1TvsoL8YcCj24/jEAgqFkJ3l1NS2MVjtYdtlg2CKIGt2xtyVTfTq8e/mb3jctl
 iOkMqfdj8e9tuF664lK9wpYBmpp5kW940hagZtbzUV0FRwo535jUFoz6PqtOir5V3d9e
 TgTjbpVAW2sYflwoiKLKF8Jj/pV+8XILHP93TM+aWA/grFm+Xy4bBGg4PQufl/6tsG2a
 3T7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732800540; x=1733405340;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WH9X2IaqWEVeslxnPTdjMz6ZZ3KemVz2USNlmowLyTQ=;
 b=Z948sZy0pLiHteDKFjQAPcpq5/RdviczlxQGvmmrXGcUe7zotXiGnd+1RlONR0H0mg
 nwe07YDBXtb1gyGYdvZ+BtvR5aq4Xn/3bUEEcmo9ru8DQTQVEyKRhsTa5/F20eT0wELS
 3pSd7vL19xu4tbWtAdAtdxihO6C4oB3PMlSEegzWdGsdQ2cDj7mhNhltlR0lF8YH36UB
 mziZBpYcOOUpkVQZSR0ZQatxUx9+Bq87wpG2sg2dFJIIHajPaMASCoO938hjsOX4LUn3
 TE+Iy99Epe2i1WWlJrppLO4tMo2aks6WXPOh3AEz+6q9D1ZbsNeFlA6d43yn/sx834+F
 O3ag==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlaEsorGfYKhcthiYh2Mo7WdypTEQBZz7Yy28wvU2JnlYvcN7t/3J6Lces2FE1M107Ms5OqJGA0pSh@nongnu.org
X-Gm-Message-State: AOJu0Ywz05JjWKXRFY3Mjafwyt1uyhEDRVv7HOltIXUXmm+iYvz5y9Vk
 NykgBTQ1tPFQFo1SvzmUH7aOk9OEPS8pXDe5nxUT36VCxpMlkdcwJINxXLSSJ7laMtu0vP+Q8Ec
 0mq8=
X-Gm-Gg: ASbGnct884x39E1GDkhYJUwSh11A/4+/m7J155BUcECf4xZRi1qDKPyn1BpaW+XCLQk
 n+CJqfhR5BZMGxCOTnRZOZCllOzqud2j4Bx9ASD+X1p76hg4+OlKzpOXqhMfJleowM3PGRIENWX
 O8QJcu1FTfRyvwQCIK1g0C/7MV9M9aUHER/C9CV1bOermH/aYXpdlcC8A1sW3D4q5QArURXaqc0
 nStZUTog6Z4If+KfUMpVpimyni+/hpKPre/SG7vfeF7gyAeYy1dtoZDSgKyS+Cp4kJGtl34ZUmU
 GeFrvXD4R6875O57O2NIcTHJ6Jmg
X-Google-Smtp-Source: AGHT+IGr3KH48K9RPY2MyiYtnpeTRyUt0jnk9b2iCumUqx5lp28GFcYxDR4V0gAG8Oy07HGcp0p1JA==
X-Received: by 2002:a05:6808:181d:b0:3ea:43b8:29de with SMTP id
 5614622812f47-3ea6dbc34e2mr5687562b6e.11.1732800540671; 
 Thu, 28 Nov 2024 05:29:00 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ea86036a2dsm259198b6e.9.2024.11.28.05.28.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Nov 2024 05:29:00 -0800 (PST)
Message-ID: <cdc217bd-2844-4edc-b65f-aba9b56e6a34@linaro.org>
Date: Thu, 28 Nov 2024 07:28:58 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.0 07/25] target/ppc: Set FloatInfZeroNaNRule
 explicitly
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20241128104310.3452934-1-peter.maydell@linaro.org>
 <20241128104310.3452934-8-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241128104310.3452934-8-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x229.google.com
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

On 11/28/24 04:42, Peter Maydell wrote:
> Set the FloatInfZeroNaNRule explicitly for the PPC target,
> so we can remove the ifdef from pickNaNMulAdd().
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/ppc/cpu_init.c          | 7 +++++++
>   fpu/softfloat-specialize.c.inc | 7 +------
>   2 files changed, 8 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

