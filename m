Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E5A8C46CD2
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jan 2024 04:52:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTafM-00018k-US; Fri, 26 Jan 2024 23:51:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTafK-00018A-Nk
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 23:51:38 -0500
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTafJ-0001Qu-8v
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 23:51:38 -0500
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3be1029514eso225449b6e.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 20:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706331096; x=1706935896; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=C8Zo+wX5Um6ydXJtmLK/qFywq+UTD+BBOql/TbEVjY0=;
 b=Zg/dUUUw2PHP4HjOS+ICXybccWzLTO/6WfQs4LgQ1zgPtnFLJ122Oi21qwQLRI3Ni2
 jAWpe6I4pOJsN9oK7FGp3kUgRXozzPOzbjgiEapUTDiejm13b42mg9JPF270MEy6du+t
 h0Km07uJjLgknj/S5yGHyuiNyBnKBqcu/V1au28jLSbuSiDukBTeJqheP7gz2PSHGUsb
 A4U18IxKOO/rv/CNwG5QGj8trbuJOLFkg/QTYydBhQBBiDSJPosekWxfTBhucv6m2DmU
 2nGYDkumsdekOy4ZoipKmg7bcVP7bbRXrMSLnVkEYuUzaKXRAi6oixTfbV9YN9S37Az1
 iNIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706331096; x=1706935896;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=C8Zo+wX5Um6ydXJtmLK/qFywq+UTD+BBOql/TbEVjY0=;
 b=mVkzAzyu/hMbCtN48ww+zEUKBZcgWFajyiBP3Ukjsqn0wjN8SV9vUorGTey8++kYuE
 rbQUuqagvxgMN+yJ/xNHqByZsIPtcSxE7l9pbEqSbO4sJDpx+z210xMfIaHujBfroISC
 ZGqsKZf1o/9QOMg1LXtRK/xXbdHG+p2yI3SGPi2Bqph+fwk9BDui3ZThiaOAYt6AT5y3
 f4ipLvNDxPm8cheflJXNMjZCBfkviZwz2gK9xbI4PlM8FrVXmvnUo3aPUok43PTu1Shr
 CPNCsEFGCT3zHSskPKe4tkBzuE5TxpVSWaW5EVxmje2Cnq3O/hs83sqmfMQyEp+r88hr
 pSDg==
X-Gm-Message-State: AOJu0Yye48E8ntz9sBvDjddG3dIIq5VcWPw3q69U20ZqbNin4Y2FVeHW
 MooMVGQ/D9kgRg/J0KoIlXF2wXABuc+t3gp4z0y+/nXwxlCGoOshBVw9cHD1hwVzp6kPDMbknXk
 aQ6w=
X-Google-Smtp-Source: AGHT+IGuI2uwpt/IsCzzNsZf8Mu2I5PlosnUI0d/CuMQ9ImBnemo/pmqnA+xN1KoDjjCUk1pC/rQLg==
X-Received: by 2002:a05:6808:3c8e:b0:3bd:dfba:f9b3 with SMTP id
 gs14-20020a0568083c8e00b003bddfbaf9b3mr1469226oib.49.1706331096149; 
 Fri, 26 Jan 2024 20:51:36 -0800 (PST)
Received: from ?IPV6:2001:8003:c96c:3c00:b5dc:ba0f:990f:fb9e?
 ([2001:8003:c96c:3c00:b5dc:ba0f:990f:fb9e])
 by smtp.gmail.com with ESMTPSA id
 h13-20020aa79f4d000000b006d9974a87fcsm1882908pfr.215.2024.01.26.20.51.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jan 2024 20:51:35 -0800 (PST)
Message-ID: <0339dccd-fa74-4535-82d2-55e4ad0030aa@linaro.org>
Date: Sat, 27 Jan 2024 14:51:33 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 22/23] target/xtensa: Prefer fast cpu_env() over slower
 CPU QOM cast macro
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240126220407.95022-1-philmd@linaro.org>
 <20240126220407.95022-23-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240126220407.95022-23-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22c.google.com
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

On 1/27/24 08:04, Philippe Mathieu-Daudé wrote:
> Mechanical patch produced running the command documented
> in scripts/coccinelle/cpu_env.cocci_template header.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/xtensa/dbg_helper.c | 3 +--
>   target/xtensa/exc_helper.c | 3 +--
>   target/xtensa/gdbstub.c    | 6 ++----
>   target/xtensa/helper.c     | 9 +++------
>   target/xtensa/translate.c  | 3 +--
>   5 files changed, 8 insertions(+), 16 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

