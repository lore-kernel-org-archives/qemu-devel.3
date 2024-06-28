Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDFB1C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 17:20:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNFH3-0003f6-Gn; Fri, 28 Jun 2024 13:20:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNFH1-0003e6-LP
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 13:20:35 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNFGz-000337-6n
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 13:20:35 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-706a1711ee5so610451b3a.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 10:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719595232; x=1720200032; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VgdEKm7+1QNNWK1/ZXdA7xtdJBKvNqs1BAkxK9w6SZk=;
 b=nOu2hsL8bY5oh5THzIwe7rPvsdS3ELxKo+KtSCP7ABGhW+QRx5JV1Jay6ARcIi/q9W
 bX62itC5gA2BxuaI1T283aSeUFtx+cNYOUBcgj4HCk0AVtFejU4eawWVLvLBZqgyA1jw
 bbYjQMk/lSyrawydGfc8l9Zq+serjaPBFM8jjqc5Kvx1FuI5BU7qHuUwaoWtzw3ZjPDX
 bmSDAh0FKG4hEZyy9U+ctDxyqYocX/DOE4CW1zjfBWTXxL5sE2iMBkbUcBDY6GYhe2IO
 D+ISzZlY1egNMG9/PaaI+PRvDfLRdCcHQnD0xuVZ7ivkaDbY4pd+sBIfwAqubo4Imfrz
 dN9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719595232; x=1720200032;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VgdEKm7+1QNNWK1/ZXdA7xtdJBKvNqs1BAkxK9w6SZk=;
 b=sHyrLeagG/Mx1UE3K5EPpRxIL0FABGfBr9sYOavewOxp8EvY/PCKhebL405eJKLK7U
 TosfkX0t3DRnbNx83i+qL9U3xSxliwzdQ4g4RDZy7Iqo61Ur0TYzyOpUvi2MZRGqSTGf
 LzyL+6FlilIQZEYK31hYOukbSWXUSw+C/rskjr5rfplVjsvsLeQUtnJ3rnYF4om/Rqou
 mYMa6dRcGzePkEo9YXF0effuywb5TECjSOhTavFJiDKN0neiiOELTnFrWwCq0mZXi+aR
 +5053PWMsl89/kYGafQIQ6ibCEf5NztHvfbnxWwA2IXOS/G6/5V3uR/GXgiOn0+3iV6t
 GuSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDWGNHP1N6muoWMa/HH96AHDUqDciHGqNLIVMAhS0nYgAAV9NrFINWem+8sQItiDdzMOEe6QM6CxHpP+L7v+FSSCct10k=
X-Gm-Message-State: AOJu0YzXWerpcy3RNHZQPNIuzc0wbHlriLkmxVIdzrwp9uKv6FRHpWiY
 nKfRIhv5dsAsFlwZydJkJnHLfzf9QUTeGS6pD+BbKEiJDiq0vwLF4hLSIY12K2E=
X-Google-Smtp-Source: AGHT+IE631yBFAaMhq+LllV6RzOy1Z/TtFwJDzY3Y+I/Y73tXxFPjueEUu5zdYbrh4y1+drVhYmD8g==
X-Received: by 2002:a62:e905:0:b0:706:2bd4:a68a with SMTP id
 d2e1a72fcca58-706745bcc7bmr15708455b3a.10.1719595231550; 
 Fri, 28 Jun 2024 10:20:31 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70802466aedsm1875140b3a.46.2024.06.28.10.20.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Jun 2024 10:20:31 -0700 (PDT)
Message-ID: <31d2954d-0749-434b-8eaa-cf85f7035a09@linaro.org>
Date: Fri, 28 Jun 2024 10:20:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] tests/tcg/aarch64: Do not use x constraint
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20240627-tcg-v2-0-1690a813348e@daynix.com>
 <20240627-tcg-v2-5-1690a813348e@daynix.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240627-tcg-v2-5-1690a813348e@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

On 6/27/24 06:58, Akihiko Odaki wrote:
> clang version 18.1.6 does not support x constraint for AArch64.
> Use w instead.
> 
> Signed-off-by: Akihiko Odaki<akihiko.odaki@daynix.com>
> ---
>   tests/tcg/arm/fcvt.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)

Oops, this was an error from the beginning.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

