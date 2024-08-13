Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1BBCC52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 08:41:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdn5U-0000Qs-QZ; Tue, 13 Aug 2024 04:41:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sdn5S-0000QE-6m
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 04:41:02 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sdn5Q-0007nT-5m
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 04:41:01 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a7a843bef98so52246466b.2
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 01:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723538457; x=1724143257; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fnY+3lEVxCrtSQqFw92lJe9+cv6UseKsfupU3agfLXI=;
 b=JMuhezYtUB23cp9y6gpDUtGBAUWk4b1DhpCJTK1pDk1WE6/v+ZLCb2uVS+pcK8A0R9
 cJLFEp5Csb8mwOJ3H3HG0+AoJ5fQ5/2fndDgRfSd1hcvba729E68Tobr9L92ox7+MvsU
 H6HyNt5X6uYpldt5NscgRa7iw5O2U/Bn9s8ebW7BhVJwmEL8sxl/Rjs3JwtxoDkqXUZA
 8LJeCB3BFh7Wv0gw6gxr7ZEFrqjSf9EdiQIFQn34RQtNgbwtCq2dAHI29MztkUuUhheQ
 EYm1HJEL8BJdSFiWibsIeHYjN6efXgR+9exryxtCxOm1G8M2AjR0jSbCjFhIDHmpMMFc
 gfKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723538457; x=1724143257;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fnY+3lEVxCrtSQqFw92lJe9+cv6UseKsfupU3agfLXI=;
 b=Ruin+0tjSK+mKEnMcBV+22+uH3V//Ck0UcAi+DgXHklGt3imPVQL6cNDjxlLSbY25D
 8xbUTXqfLagwXdxN+y8ijjOio+0LMTMTC2IMoeeYLOjuB9toYT2iz7nNslnW0Yy31Dsj
 R4MLz78u1auuMZ8EwEXF33ITtN2DJmYUlND5foAXAQeOrtJpyF34pyOkJ2tFvHkM9M1L
 aEqZVpcTFeyd3M2IPRRcPWxYemRw3H/xqS169ow8ryW+G9SiRFp+N0E6WRZ3Q33Y/gAx
 TdkvEvzJWDcs5FXhVQwcM2zrdwOwEaVHoc5UxbNyycev+8xdMdTYvVKX3uXVL3gWRsIL
 hcBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVob7/EuItrsmsiz+QGHjGSLk0KzLkW/0l0J2ZRqxsY6MbaxnSYilQ4OsXrKcJ1RCYgIfL0fGH4+YrTZR+/vjkJex4lG+s=
X-Gm-Message-State: AOJu0Yy7wS+FBtjPrX8NQJcrSqRCXCqbjfdChOhttBOTErDRGZWYPgAH
 WCyn2wMEclIzhDdPgPz08fTxfphuutuoH1suQL7ByJOMJb1sIhZ+zDt0qLX0sBE=
X-Google-Smtp-Source: AGHT+IFdsa+JX0jojCp1MDMdrT+2MUthvVjb4WWoBoPWHfb4j+aOVcT48UEI3+BZHBU2WtUbB9HhuA==
X-Received: by 2002:a17:906:6a0a:b0:a7d:edb2:220f with SMTP id
 a640c23a62f3a-a80ed2d617amr193127566b.59.1723538457388; 
 Tue, 13 Aug 2024 01:40:57 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.129.17])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a80f414e555sm49214266b.160.2024.08.13.01.40.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Aug 2024 01:40:56 -0700 (PDT)
Message-ID: <04f36277-085d-4b15-8ff3-42f582df1ebd@linaro.org>
Date: Tue, 13 Aug 2024 10:40:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.1] target/m68k: Always return a temporary from
 gen_lea_mode
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240813000737.228470-1-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240813000737.228470-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
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

On 13/8/24 02:07, Richard Henderson wrote:
> Returning a raw areg does not preserve the value if the areg
> is subsequently modified.  Fixes, e.g. "jsr (sp)", where the
> return address is pushed before the branch.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2483
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/m68k/translate.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



