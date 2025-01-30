Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 982EAC0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 22:09:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdcj0-0000Hc-Tu; Thu, 30 Jan 2025 17:09:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdcit-0000FY-6V
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 17:09:23 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdciq-0006SK-50
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 17:09:18 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-385d7f19f20so636972f8f.1
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 14:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738274954; x=1738879754; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Fn/F6x47VKrDSM0Uhbt6IuerLOa+Dsq54IJS5cGe/U8=;
 b=SdR00HAbtpVPnFylqoPdVYkRfv+Ibvw41O6S8oVT6keF5j9bwwYlTlNcEDNrRb1irv
 pQcTn8Vbe/dI2ixC/VTJx8oGicB2HR/DZAyYfaQEoWraFHiYSBOX07mB9dxLgBhMg0Aa
 pfou4yYv3OfZAS5keAn7h+iCpnQjGGK4svZw75Be9+L+3t90GsB8SMwpEvF0c4wF/DdK
 VwPfm3jc/2aaOjsigKVmVCva+PkRR4SkdVe0eNQzkNz4k4t8MQX6YzaSBuOGnRg2ZyGl
 EKzr77F7e7LdOfASL2aKMiJ7krro9Yje3qNk9sTSJoUMEib9bKar4C9I3g4MNFmEUSpx
 +d/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738274954; x=1738879754;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Fn/F6x47VKrDSM0Uhbt6IuerLOa+Dsq54IJS5cGe/U8=;
 b=qp+RoK18IYLLrKiyzrCUg+eQUU4NgJtdCWRPOCvakWC1vpAJN68UW0QE7hoMCf+pGx
 cmCRVk4Cw/6n4Ow73Yn4FLfEF50mGXGpSnp4nI5ls7ZVrPZp4kb+KdKHrABLfyoyfUOg
 Yt7OcLPHaZbPlhkOQ04stGcZwvCNTvIfqE2oF3WPB6PieTCxaiKeqLD8NxUOAhnmWD0F
 3XeGAPgT1FCK8zNMAM8UkKh2uWj+RYLyKbCpV2humFynXomE1U0HmBx1UQxn21qGw0gi
 cvbEAEPEFgDExasePW8ZtbnGOtwIc+jLI/6//5BKI7g9v8rb1zDFkXdfq0iAUhhKENg1
 oOjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBcoNnsHytq/Eb5grk+zKOqJU1fy4uvtQJkOQ4FHR75mA5an2r1aNuG1YPiiMN3mJ+XDu9qwlTgrnz@nongnu.org
X-Gm-Message-State: AOJu0YwTKIIykfbFjoys3kzF/jxIcWaKNPQz5VmWdUNSZIEAWGK7rJY/
 q0kTe2W4AxpqU1ACWlyjXI0tJOVJwrpi1Dy9xQlUer4KaIPVJST9SUkEQTsZgOc=
X-Gm-Gg: ASbGncszpO9sZHZimBKSIPwYgm+Fcg/02jnf9XzXM7Td8ME+DAOllTEpPPUYYmL3tOw
 pifho6KUHzQmB/z7oayDp3QkABduOBoGABi6q8xOY4en9Mo7HP7VdRdp3t9kudnX4TtrK9ZYbih
 Wj1DGtVVhdNVujjthBO/iJQ4yl8Ast06yfoQZ0MSw09udcUjkG1JECX62NuPyHBsUlFNp/tBdTq
 y4a7wTcF00WgX4t62FyPm26Gq7X/HsBYjuOJ9ZKIcGbg/IskZFudisHJKpmB/TBkEL8k1wsQQ6S
 qD/UvXLSsEeSEYy5UD/dmyDU9VCFmZXoc9JpXQKwVgJL7xQ2akzubbpxu9k=
X-Google-Smtp-Source: AGHT+IE1wKv85b1gVxN2LC+9PHs5WzPiiRGPThf+uczoQft0PILKWvlzAHyGBlrNxk+MVe1vT6OUCw==
X-Received: by 2002:a5d:59ad:0:b0:38a:86fe:52dc with SMTP id
 ffacd0b85a97d-38c51949a3cmr7701983f8f.13.1738274954505; 
 Thu, 30 Jan 2025 14:09:14 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c10191asm3061626f8f.22.2025.01.30.14.09.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jan 2025 14:09:13 -0800 (PST)
Message-ID: <cdd71a5d-f754-4224-ab0c-96ce5b18a9f9@linaro.org>
Date: Thu, 30 Jan 2025 23:09:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/11] hw/sd/omap_mmc: Use similar API for "wire up
 omap_clk" to other OMAP devices
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Bin Meng <bmeng.cn@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>
References: <20250128104519.3981448-1-peter.maydell@linaro.org>
 <20250128104519.3981448-6-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250128104519.3981448-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 28/1/25 11:45, Peter Maydell wrote:
> The approach we've settled on for handling the omap_clk wiring for
> OMAP devices converted to QDev is to have a function omap_foo_set_clk()
> whose implementation just sets the field directly in the device's
> state struct. (See the "TODO" comment near the top of omap.h.)
> Make omap_mmc do the same.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/hw/arm/omap.h | 3 +++
>   hw/sd/omap_mmc.c      | 9 ++++++++-
>   2 files changed, 11 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


