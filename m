Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 286B2C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 19:09:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rophc-0000bG-NY; Mon, 25 Mar 2024 15:09:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ropha-0000at-VE
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 15:09:46 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rophZ-0005X1-6X
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 15:09:46 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-5f034b4dcecso2341642a12.1
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 12:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711393783; x=1711998583; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6lgrukV1NVlUfDpJbDQZ+nx/NARfPIpipCkGiBoicUQ=;
 b=FGQfZwMxzF4n97/g34qfugLSPowch1fa2F0LBJEBMERdK4NLqTuN7vfoBMXUD257An
 hXiOsGr8lbiq0Doq+Zc6XgmL9a4LUWkgR3aioraXLmAgtWThfn2l95B0NrIpwM+V6X5i
 XICo+77ukiGNzMmpMoqSuV5jqQYJGNTb4YtbELJ7GhzOdZRq42Ml5cWO6n72fm1chBx+
 tE4zlQxRlvKrNWKLP5ekAJf7dFeC5dzW8j5eWIuJm8zDntOxQEDyEeIHu7uCdtFbtKAP
 nVD8jeCjTKs6K1FjAMSBFlOOo7s7VnDliHkksyHlbEUK0/C+y16DRxtqB1x6Fi1hLa0o
 XcDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711393783; x=1711998583;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6lgrukV1NVlUfDpJbDQZ+nx/NARfPIpipCkGiBoicUQ=;
 b=ezXGiJpwEqbL117J61Rh+/Q4s9Xo7AwWA2pbIgiIxi6FCiylj6X3uDkLnXclb4hR7s
 C+k5ojm2kBPHVBsbMKp53y9J1THRJ3SrAicGMKfh79iGspWWxrU0UgO35/fDLCAvoR4+
 nidRlMZEbZ2PxdWf6Lh6Mv+Q98FfoS51GVUO1Yf7x9aQtD4X5oj1riVQtK0dzJ6W/KP2
 VgXKJkRlGAN+oLyASbpzh/y2N4etS/+h4qaSSFz+rWkk44YZCcJbMlphLjpL5kd+3E4s
 pxMxofWpSlMpvf0wYAcQEkN9+L/5cXLOvPniDHu1UZTo1V2QdSNe4HCT0kw84CGpP+7+
 QH0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCOMZ43TZi9ub642vVhO5sUA+a69zM22dlBc525meyElU/4s6NJnY3Bl0yX1T7hVVvmomIb6UR+OMYGHWMysXyD5s9YYg=
X-Gm-Message-State: AOJu0Yzc1s6TCMvZsnNEy8uH400XOjaPhhs7MCGNkNN2l8427ljZSe4S
 yoHoDoYJP4Ip6Fsc64yn9jWW3SuTF+hvnFUYVO5V0ETpw+loAEJy/n4V6au8G6Y=
X-Google-Smtp-Source: AGHT+IHRdA5buQZI/nEuOt/vLvUFxQSBuq4D4dx/9DuGqEHc38p10i7ApBclFdEgVSKthMQiQySBgw==
X-Received: by 2002:a17:903:2447:b0:1e0:92ee:e9c with SMTP id
 l7-20020a170903244700b001e092ee0e9cmr11138346pls.2.1711393783526; 
 Mon, 25 Mar 2024 12:09:43 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 q14-20020a170902a3ce00b001d8edfec673sm5175268plb.214.2024.03.25.12.09.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Mar 2024 12:09:43 -0700 (PDT)
Message-ID: <6b4fad2b-ee6e-42e7-9a43-2766ee7379db@linaro.org>
Date: Mon, 25 Mar 2024 09:09:39 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/8] plugins: extract generate ptr for qemu_plugin_u64
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20240325124151.336003-1-pierrick.bouvier@linaro.org>
 <20240325124151.336003-3-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240325124151.336003-3-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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

On 3/25/24 02:41, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   accel/tcg/plugin-gen.c | 27 ++++++++++++++++++---------
>   1 file changed, 18 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

