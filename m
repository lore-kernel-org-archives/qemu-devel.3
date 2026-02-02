Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D848E7DF11
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 17:58:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmyBX-0007rS-Op; Mon, 02 Feb 2026 12:58:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vmyBS-0007qQ-7S
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 12:57:58 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vmyBP-0008KK-NI
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 12:57:57 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2a9004e4239so8403875ad.0
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 09:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770055074; x=1770659874; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JAuTrxn4gQGmEPvqo+iM+qmIJ0RYyWcQiCHd6otGo3U=;
 b=Torc3i1ncbxpY/YY1O6VqE9MYZWcFE7SzNUhjHQxDKp76TgP9fb/yd/iHgbwgorkUp
 lGqlm5kE2jBVJrboqVfEYHwEXs4dPxANxJl3y3mfhyIU7X6JVT1o9YFyrpcJjNttWmzT
 9sFb9OcETZxMOb+3yDLiu6zf7nDLHLZVHEjrsyc6rwQuuMe46e34efjr8AmfYKLe0v47
 S1i76uSXYsHSd0A3MLH1YmH+cjM7rvU9L52gsVgF+qCJ/HoFvBzQOBCD4JAZN9NSaIHQ
 1Nwx7cYvse8bO9hk42RWd4f0BXLK5qkBcrH1qXxVAiVqV/yCfOkdo7TM9nKSJbMA1eSc
 HGew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770055074; x=1770659874;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JAuTrxn4gQGmEPvqo+iM+qmIJ0RYyWcQiCHd6otGo3U=;
 b=lgsE3nmW1CUAu6MYEPlolFBZhlQgue3PRvG7QDq8g9sQ2tZprVlqQik4XVgAWFE5rS
 Yc7FI+DyAegmnRFTpvCnuvyscdahRtpvSFK9xhRIN3qUw88yPf4StmK82XsCWgbv7ufi
 kLftw1IAwHR4gdJJRwhUdcDbJAf9ek25tLWHUMxLVDPHdyHsM/3qniFAAH7ydhs89w92
 h8uSb9oxMsUJwKDFkIJNuRvDzFuEz/jnRbvDxqZ4mn6u7K7m+lwog2iYwgxT58jWei5P
 WTNwX7xIFup2bc0brQXIdYu/hO5psmm90Cs+zAJDvJFXKH6J9O4gYIdsOaprWQFlCUeQ
 OEXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcoSsDzFohtydAtnyMPRXs6Ne0zI3v/giPjdiIp9Gj1Lr2gVPqneAGHgQmNKyotYfk6/w794XZezYz@nongnu.org
X-Gm-Message-State: AOJu0Yx/mHH6LwzGIoMDfpc3PnYKjxrnFwJPhBG7f5OpbHbUTTCEqPv/
 ltujydzsZpDk/1OKU+XeAGl9XszDmYm2W99UJ8WChBhYovDE9vcqKeE/1X01ftvFt/c=
X-Gm-Gg: AZuq6aLbqa5tXVB2PdPjOfLNC76+L9SM2c8bEHB5d+OO9tdaHS/Waqyqd8eStqw5+e9
 QrkHM0PXYon69Y7pLJ6QTTPk0uHE73LIEDGntOsubL2fu3uaJGX8W+8ZLb0q/Ib94CvW9c0CdOV
 79njHQvBrvMXbsq7at3WSTEXPlLceVWZbvl5OZzoXLaf8iN2GGnViv0CIbP+yfLFtCKDh6Vtj41
 5YRoMD2xEuCOrB3eD//IWMLJGqdd7wij/ODzhBJ/N183pv6Z8wqIev8XT6wsVxoIMxzYHdfUwse
 Rdj+wyvO3imLkd4qsSqmfKlt+ESRtmCWltYZ46SvMnbmKOoZQVF9nLw1Qw2pdWpf2cbpYEd4fCh
 +Y9gy1GvUMBzT+9JljakcMzS/9ogec1lUtHvy7fvJWt6O4RyLuWVNzUJ31wClNiHItYNuF9O/1n
 mCQA6Afe9W7azeITHHPJYjeDXl4+F15V1w8mgmIJsEnnLAsf+2PFDWI7fP
X-Received: by 2002:a17:903:46c6:b0:2a9:4c2:e53 with SMTP id
 d9443c01a7336-2a904c242c9mr60520465ad.48.1770055074180; 
 Mon, 02 Feb 2026 09:57:54 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a88b6e5fb0sm159459165ad.91.2026.02.02.09.57.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Feb 2026 09:57:53 -0800 (PST)
Message-ID: <681e7b2c-73c1-4861-88dc-23dcecec9c99@linaro.org>
Date: Mon, 2 Feb 2026 09:57:53 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] target/arm: Remove dead code
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 devel@lists.libvirt.org, Richard Henderson <richard.henderson@linaro.org>
References: <20260202153618.78675-1-philmd@linaro.org>
 <20260202153618.78675-2-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260202153618.78675-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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

On 2/2/26 7:36 AM, Philippe Mathieu-Daudé wrote:
> Since commit a0032cc5427 ("target/arm: Make 'any' CPU just
> an alias for 'max'") the 'any' entry is never used (we use
> 'max' instead): remove it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/cpu32.c | 3 ---
>   1 file changed, 3 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

