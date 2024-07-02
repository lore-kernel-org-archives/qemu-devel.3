Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49AFCC30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 22:49:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOmIC-0002lY-3R; Tue, 02 Jul 2024 18:48:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sOmIA-0002l8-8P
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 18:48:06 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sOmI8-00028j-KI
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 18:48:05 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2c9785517c0so40605a91.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 15:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719960483; x=1720565283; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xzViVz0RgqTMnq6v0aLF/VAMt1kEy90VTp6r2oT6g1I=;
 b=h9oOYOh+CFEA53v4yfv6KVLWyLGrjgnaYyBXIFGTBW8EsXz46TGUN7yBrL1TaRigJO
 2Ndf1jzjwSTSxEXkrNnvHgcRWlrAswBcM8Uhezg38G/yEvoTtMYVdi1PxVB6D+6qkM6F
 XgoAmNbHsOx3QF76WXZI+azi+kouaNQgB9ryjOAzWbFwMW8WlEgRUibO/7DK0aXWtb0f
 HNu3Yd3EozjtjdJVdmbl0CyaBXnrAUDYOBaKJQL4VVFhqeU0jhTKj9tbRxX2k55/I0GW
 YiABGHL9snHudKCTC5x0rCvhCrG1/sWTCvoWnqe0d9dZam2TeDBWNW4WbLkkcvjYKupD
 AEow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719960483; x=1720565283;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xzViVz0RgqTMnq6v0aLF/VAMt1kEy90VTp6r2oT6g1I=;
 b=Eg+Ntq3zC8xwDzqnlbP0mhaGmHpBtFY4GLwaNISKj3/7AQrEbGl4C+vx0tRaLCT/Vi
 e2xH1PrnuC60Mg11dHJqOw1gr13Cxow9jlsnUYSjq6d4zJjuVZ7j7w+SS6RAP5U9UObl
 O63wqyK4hljtuFFkZTlT84/rCm4dytWXYwdjm+U9tK6VOdrswPFTjYZt3vDejECHwXlm
 ynpDC/1Zkwepw1I/DXqxOb7WAGzAI6V5iRFJNIbacg7Fo7fFGI0k4vkFS/Ud6VZSPbGj
 C+iNg2IpB/dcCM8C0b2FjBM3X+oziPK+/Yg7oTGEA+sXNGVKhH1qpAiy7HgerB+4N1Fk
 IxGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXk9M52FdKtgLPy00FyI2l6a93+xNLYzTsS4ZvKbY/9da+JI/jUfSzQm+LGewURoqbc+/VwpM0EUL6E7fKcz384UAT0stI=
X-Gm-Message-State: AOJu0YwNvmFZJ6VETlD5nd9aEC01nBvYgg2QJTk9TRFhQo43sX/l2f4r
 YMbT/uC/+cgaLrsgd4vYUU95bsqknSShRYop3RU7xYapLPu/2voU0u8GghdU8jY=
X-Google-Smtp-Source: AGHT+IESsUmUPn0mR9Lkogu6oeX3uqgLBLF9s98fUmHA3eNA51JlnFxLYP2TJ5E3tkS1Kd4i0tSScw==
X-Received: by 2002:a17:90a:9ca:b0:2c9:649b:c249 with SMTP id
 98e67ed59e1d1-2c9649bc32dmr1751898a91.27.1719960482571; 
 Tue, 02 Jul 2024 15:48:02 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c9784b9ed5sm62631a91.33.2024.07.02.15.48.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jul 2024 15:48:01 -0700 (PDT)
Message-ID: <5079f504-1b65-4a44-8fd7-bb676b2367b6@linaro.org>
Date: Tue, 2 Jul 2024 15:47:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/6] aspeed queue
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240702080042.464220-1-clg@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240702080042.464220-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

On 7/2/24 01:00, Cédric Le Goater wrote:
> The following changes since commit c80a339587fe4148292c260716482dd2f86d4476:
> 
>    Merge tag 'pull-target-arm-20240701' ofhttps://git.linaro.org/people/pmaydell/qemu-arm  into staging (2024-07-01 10:41:45 -0700)
> 
> are available in the Git repository at:
> 
>    https://github.com/legoater/qemu/  tags/pull-aspeed-20240702
> 
> for you to fetch changes up to 5b0961f7ad6790f473623703834351b6e43fbaa6:
> 
>    hw/net:ftgmac100: fix coding style (2024-07-02 07:53:53 +0200)
> 
> ----------------------------------------------------------------
> aspeed queue:
> 
> * Coverity fixes
> * Deprecation of tacoma-bmc machine
> * Buffer overflow fix in GPIO model
> * Minor cleanup

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


