Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB361C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 08:35:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raXCN-00037w-KZ; Thu, 15 Feb 2024 03:34:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1raXCJ-00037O-Bq
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 03:34:23 -0500
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1raXCH-0006UN-QT
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 03:34:23 -0500
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-51182f8590bso734889e87.0
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 00:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707986059; x=1708590859; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YP7xkt45aWXhXRq2rZ6SZfzxIkJ43WwsPqekp9/XFQ0=;
 b=ZBklSf+HL42nYQ5q3UT2yIMgqIwGnyEuZP8noar1OuHf7eWbc0ipEsxHkKFcmy6y//
 cLP+Ru8B4wLjlp5kAw1TPkzAongt0bAeVeTG0Qf88wVhDB+DkDjeiD7SeFFX5uYWzsFa
 FnvC7TvqNt+gWlJV5ztyqco2F6VLOW5woJz2aEv+00bZoHBwFx29qawYyH5vm8845BoB
 e3R0aFsryWeQPMk5q57yXu0xJ0wLrSWVFzWkRIC3hNm4rq6sQRfXk4KgP7qj1NPR7lre
 0w34QsVo4/U9FJweyaLZPIJ6PRi1tZN+npi+p6q5WpIuUtyeLDM/tC0DRsxguFCr397T
 zZIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707986059; x=1708590859;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YP7xkt45aWXhXRq2rZ6SZfzxIkJ43WwsPqekp9/XFQ0=;
 b=vzNM147zlZo/3A8yFBoZTWrfIcAbydRZpJlWtf9DOJ51qdCxEAoln/2VA3eHr5Tz73
 QkTt7Ia93ikyoM1cm2J/ikyHTOrA/C8s5IqSKfiktZJGssIa3VlVdv8Y9XPdh8vtgqkE
 uvTXc8H3XtyowaAwT8Z6jkesPK2sOKZsS/yweYGaZxpreoVFl0Iq0miuwJSfBAuwMM7z
 jTI4DBx2YC10baLiWL/a3HpBdeK/YAFDK+729ztbMrKL69dT/PRSgrfmtxe9qhzDKaFr
 I1LoJvhAFqJq7+MDjMA46MdSFkEJQP27iHvpur/mmimDmMz6/ZlUfyp0pwIaYY4WpI7/
 96VA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkDOTne+X8qOVsOecysVCgXMXQS+UQK2gnw6ZzpRuLhFiq+fUTbhB+Ujs/TcrJLwqhMxI9s0XTvoV9r3a/9az9cIRAFbs=
X-Gm-Message-State: AOJu0YxFUNh1HgFvrM96kx6eSJMzx9Lz4TGl3FSlL+jXezmyC84uqWoS
 rsur9sqoZhToXb53psKrgbm0UMlvXZPNGBp/djHR8bHEujII6e895M759MiTJTU=
X-Google-Smtp-Source: AGHT+IGTZIPIN1WyXwHXPdnhTFWPrRr6GnNN0PRIFePUNIbq5FqwTpdsnKV3xOnYkmXQcEeUvBMVcA==
X-Received: by 2002:a19:f011:0:b0:511:a2ed:f6cc with SMTP id
 p17-20020a19f011000000b00511a2edf6ccmr889965lfc.29.1707986059596; 
 Thu, 15 Feb 2024 00:34:19 -0800 (PST)
Received: from [192.168.124.175] (14.red-88-28-17.dynamicip.rima-tde.net.
 [88.28.17.14]) by smtp.gmail.com with ESMTPSA id
 m40-20020a05600c3b2800b00411c9c0ede4sm1246191wms.7.2024.02.15.00.34.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Feb 2024 00:34:19 -0800 (PST)
Message-ID: <2c225784-458d-43ad-b262-facaa0926cdd@linaro.org>
Date: Thu, 15 Feb 2024 09:34:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/10] util/bufferiszero: Introduce biz_accel_fn typedef
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: amonakov@ispras.ru, mmromanov@ispras.ru
References: <20240215081449.848220-1-richard.henderson@linaro.org>
 <20240215081449.848220-8-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240215081449.848220-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x136.google.com
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

On 15/2/24 09:14, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   util/bufferiszero.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


