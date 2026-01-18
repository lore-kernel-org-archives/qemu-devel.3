Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DFC7C9832F
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Jan 2026 18:30:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhXXU-0002G3-LT; Sun, 18 Jan 2026 13:30:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhXXR-0002AO-Ux
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 13:30:13 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhXXP-000187-T8
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 13:30:13 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4801c314c84so20059505e9.0
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 10:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768761010; x=1769365810; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3IthRlNnly2cg5WoaH2GSVigWhvCuOJCMh/LkVg9BAE=;
 b=Ih5z5VMufxS6RjEXzU2Tl0oztq/JC35WDBK+ZLpw3Rc/6mZ3G78s43tV/ClNKdQXDI
 gHla4l4crYQlhOHHZnUzKxkvq5dW0NW8Tq9IeinoOIt5fSqbjtwGbjPnXTi9swzXWRcd
 n18Qulsr1DDcbw1qiC3VLWzhulGXtoQbUcXP8lf7vgOXXEcOLY9Iftrzg+Xte7DwS57S
 Lbp5QwQb00zVbpOckxIU2o+e9scb63ZVIsi+oC061//rv1ATXXMP1ZSWiDkDB5TKyWDN
 OuDVoiKttsYNUibUlBM+x3VSGM2/565uaoy3gxnh3VrydMiUIgU/Dd8IGqVCbeB8RDEP
 lbRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768761010; x=1769365810;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3IthRlNnly2cg5WoaH2GSVigWhvCuOJCMh/LkVg9BAE=;
 b=TGr++kK3w+C8+eBfXl7fzMHfDOKoSg9/c/GjA2OD3MKaUjFLlrkfz9ny+hrXtsmdrK
 W3CK7FWbzEe9B/OeUdt5B9XwrsQmcS0OfWHkTSY1V/6eaV8Y4H72P+Hj4CR0xTnuQDJW
 ZdjH8gHchKgoejlim6+W4IFnr03qGy1i4Je7q0+cSBj1qY++Qjv8xehRmCsjTMX1ovTz
 UtvmqMOHi/wnjh0skkEZPumXMVszLazeVDpC3xS059FqPUurXUDHcZtnZbsPISvPodLq
 XUyeZfnHm733T+4Qn1tbjJqrSFff3MyFoxrJYUDNZQU49PpUaJxvBFy2GRitKwlyGUah
 ClAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyGTtB2mj+K7jGvGJG+iPnNaadRBbnRR79KgkfYj6XMmvWIE1ujDd3biY+U0Vp89EamtaPS4TcqcUg@nongnu.org
X-Gm-Message-State: AOJu0Yw1lGhpi9H4vCiL9d0Vf1OgZqY/DRd7qGgB2+rW9mf/stnsM92w
 Lz/DImlaDVsfmJESWBFbM3nPSkacL1eSUN7tCI4NUvwJGq7s6a+++6BV5f/Lnmyr1JQ=
X-Gm-Gg: AY/fxX6QzczFD9zGWTFRqcximn3QG9k3Tf3RYyXg73CbVxKZrTbQypKuvDzpIoyJEan
 VLZR6T1mh189rSgj6Echh+5tzGBOF4G+6lEV1DQAs5aVXm6Xvv9CZoKCzvtt2ZYo8NSbFlJ834O
 ScgyHnJPh2nlqOnXggq30tHZhnJdmNqY8IKwz9KgRb+KMN+lzD3MBuRGMC3HyOWeV6F0HqrScJB
 vH2Fa5SoQbhFxCE3qc/AzMC2pZOLhoVCG5PRDlNY2eYi3mAfEtzHANg6nHo8uLvivPGKYSJQeT4
 zTug4bKOdZNJB0LWK+lKnLosQsl7UiYw9r1/HCXDbpjLO2Bm+9TadsxgYRdd/vovelqJITg2y8v
 wL2CHUcd4poGrxYqE0Pae7CS4wLowfOfIA3e22QxNO5mv4MsU2kUlPGbP50IwQJUj/qljEJz/XK
 1ZJIXTAgEy0kPcEI9jolinC0uAmRhYkaSGIPN0uwbLFXB72iBIS73USQ==
X-Received: by 2002:a05:600c:1991:b0:47e:e4ff:e2ac with SMTP id
 5b1f17b1804b1-4801e356cebmr110811825e9.33.1768761009995; 
 Sun, 18 Jan 2026 10:30:09 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48020312253sm63350955e9.14.2026.01.18.10.30.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 18 Jan 2026 10:30:08 -0800 (PST)
Message-ID: <4a8c9715-d77d-417a-b2c7-387246185df2@linaro.org>
Date: Sun, 18 Jan 2026 19:30:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/11] tests/tcg/plugins/mem.c: remove dependency on
 qemu headers
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260102214724.4128196-1-pierrick.bouvier@linaro.org>
 <20260102214724.4128196-6-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260102214724.4128196-6-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 2/1/26 22:47, Pierrick Bouvier wrote:
> This plugin uses endianness conversion primitives from QEMU headers. As
> next commit will strongly isolate plugins code from those headers, those
> primitives can't be used anymore.

\o/

> glib.h provides such primitives:
> https://docs.gtk.org/glib/conversion-macros.html#byte-order-conversion
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   tests/tcg/plugins/mem.c | 59 ++++++++++++++++-------------------------
>   1 file changed, 23 insertions(+), 36 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

