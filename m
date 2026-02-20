Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B427C55843
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 11:03:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtOHS-0000kg-Kq; Fri, 20 Feb 2026 06:02:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vtOHQ-0000kR-EG
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 06:02:41 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vtOHN-0000mT-Hw
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 06:02:40 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-65a3527c5easo3462498a12.0
 for <qemu-devel@nongnu.org>; Fri, 20 Feb 2026 03:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771585355; x=1772190155; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RA85PjwVTKDqv7S0WOSbDO7sOanHYYfkUmPb0hIH6Sk=;
 b=LH5Fzbtu8whkmlKe4zw4txd2jnty9xmcX5gllAIniHGYv2AXBy/jmBw8SMMHjoIMT/
 iQ8pRFEjGHi112P8A9zE5q+Ttow6cZCDPdZ0ZxtdbvT6ZdsjT4D9mbl7feP/BjDbQ6Fa
 9CmCXQR/yaJwgwIprIJwpo+BDeYNHLOVGUBbJqAEzZxmXRYhgdowaSsZQIpEWXy5ogcX
 g2SiJCYxT3jfwpQGxFOwWSXHvcfD2ruKa9QZHYan+kF41py52203VwvFqEy+Iz/ysF74
 yR67WKPGVKl1J+i0VvQvlkK+WrvQBhaUAXAOilpvMXUbwSGsinkRwdIexv81lDKiopHI
 CE5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771585355; x=1772190155;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RA85PjwVTKDqv7S0WOSbDO7sOanHYYfkUmPb0hIH6Sk=;
 b=bTis+mMLwU6685XfoGw66eDwjTlzJ5Lv7RpxLdrX9hdZXET3ExdltBXrAJI9hI1KB3
 Su0RaVC9W/4z0k7XNhLEnz2XYOLtQ5N+OanyIukfM3lbV7vizPJHy5LefmsREEjwll3p
 WLvH8tXP+TF5Rhbr/tSd8K/u00bSccvAqFJwRgaKehgDs9PV7+47JnINNuNQm/h9igJc
 W7+MINOdHqXx9hAOdnXkyRkqJm9JNPZ4DyjeuJPGrRZKUTb0LwMOgjGrrhDCS9x2X5sM
 mtJUi49zFpuKDRdyBH7b75xe5wxb2tkcF4NCfpUQowZnp4u2YA819AapOkBGSh9ze+cK
 X0aw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEJY+tiZMk8VNo4Xgpbat+kai1QJx5j4FD1rm4g6SsPc4YkZuhHHAXWuZinGhh2k6nEo/7pZRMyRAM@nongnu.org
X-Gm-Message-State: AOJu0Yy2ivqL1uboItWcY5TAj1zBpNSSrlRd2c7lBYJZU0VIKs9Q7swW
 m+4WJ23qoOgO8oH6BBul9HiCxZWCliTpabT2JhDSpup87nisN5lyh/Fjj39bO0sOps4=
X-Gm-Gg: AZuq6aKtl6WVwHiR0+NlVffMti+ih4zV+2M7/flYUmyq3ZKxRnVKYO2VNTVGnbqjm3x
 CuuciQlbJAIHJAH/S8O6LUgnFnxgLgC+CteXdoR162UC8G3gkAl33aqG++M9X4gWWwOfgdpCsuv
 NsKCuUGG/zXD46812Q3suAjua5Vn0lF5U3j28g0MMpTE/ZYdu0zX28X7kVe0hoysoDW6jgfrQWF
 vxp5aRBgDeIRDTWJ7vubhODIzdafCn27nLg8lXjPatR7cx6WMkcXpQy9S6o8YTJPafZYjGctMsy
 VredpER7QvFXitlTA0azH6lr8hFY6uWk+6VYy2DaVfLC/Sq8GRqWdi35oMDDu/AthOKKNTJjf1k
 FSd79A0X1RwpXqtsvu6qjBajCHKK5Z8D5S5V3QJLpw6hLMgogc0SGckeSNgIAXftLgdFehuOr8r
 HIOTwRHFLaROgu6fgqUivYTYzKXbJeOXQ7WyolIXonl8FFjK67WNRr/UkXQCN8hLdhVg==
X-Received: by 2002:a17:907:3ccb:b0:b8f:9ba8:e512 with SMTP id
 a640c23a62f3a-b904dc686cfmr386739966b.30.1771585354629; 
 Fri, 20 Feb 2026 03:02:34 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a31d3ebbsm61283185e9.13.2026.02.20.03.02.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Feb 2026 03:02:34 -0800 (PST)
Message-ID: <a38b2328-e877-4b19-8d3b-e5aaa0bae83c@linaro.org>
Date: Fri, 20 Feb 2026 12:02:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] contrib/plugins/uftrace_symbols.py: filter out some
 addr2line error messages
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>
References: <20260218172356.938236-1-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260218172356.938236-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 18/2/26 18:23, Pierrick Bouvier wrote:
> This was found when tracing Hafnium and SLOF binaries, and it's probably
> related to a bug in toolchain used. It's safe to ignore those entries,
> and related symbols will still be present in output, whether they can be
> found or not.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   contrib/plugins/uftrace_symbols.py | 3 +++
>   1 file changed, 3 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

