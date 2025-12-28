Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F202E9271B
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Dec 2025 16:01:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZtBw-0006P2-9b; Sun, 28 Dec 2025 11:00:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vZtBt-0006Ok-Sw
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 11:00:21 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vZtBs-0002al-Cz
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 11:00:21 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-42fb6ce71c7so6662727f8f.1
 for <qemu-devel@nongnu.org>; Sun, 28 Dec 2025 08:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766937618; x=1767542418; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LqWOWU3XDh7jX6tlGGaFahQELO3kvKEEAIC3/pwpSPQ=;
 b=lPZCesCqSwDHCTK3Auixnrvg/YcVvMF2vzXHg8FcNx1p59n5eZeLsTI1yLcLpPQtYI
 Mge7NVc4Ks+7QMLOSkxLsa55+HHkGZo0DsI2YUiPTVNgiXxVsCood3lNQVz/TAOCRu1B
 uBQ9kqAY1qva+wJleZ78KXPDDn8i4IN+hAs5ty2Cl5F1Z95qK7iZSAi6DKYZQHABYED3
 lxhpu9ka9b5USTKD4casBVQptRCy3mqctAqxOs8Eo90NdZ17Pi4B8aeVqlokrtAwtJh4
 Yzg+eSd6tbYIyjfJ4VwJQxfEdI5TnNJiBJFLSjetAj5S61P8/owO8yazfDYUejPuL9Yi
 rE0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766937618; x=1767542418;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LqWOWU3XDh7jX6tlGGaFahQELO3kvKEEAIC3/pwpSPQ=;
 b=JUGcUtfEHaaR8CFETgL74gLia+D7xVE4LbnxKZO5bHqZdeJ52/ENqT++xNp5CZ89rC
 wRFVy8jlsSVRTyW7ALgmk9aX/R0hDjcybzVaV70S5XSniMGb2UH7n7FEbiVn8RsnmXQC
 xMHRffAHHo8zHcwIHT0cOdFXmB4YYT80svlC3ECGwKJN5di4Y4e5CkqQcLKgejX8D34t
 XjQ7F01IftFljPtGRltVPw1wvVFOhrREBvv/ZARh+zALSXUqH+YoTmR+m3dQBQI4wxDp
 vD3iT9JEkJevPKfOQZbXfrwOMz9uZ9jlTwvkfF92pRgFFydQ1UDVDxOEI8Xpd2TBN55o
 IwOA==
X-Gm-Message-State: AOJu0Yy2lZgAzcpH4WHKoJvX5DKdxFH3DOdl07gpsD+6jk++uw5o8f5S
 rnznoHL3OYYzUw7GkvZs3feVXgOmFRUJ+byjYzvENA0AY7TlR4ZzA+pr4oEb3pF6kQo=
X-Gm-Gg: AY/fxX7Om51VZZdGJOX5KkBYVgGzbkFADstWVvx5wlrOp4a1H9Afi1S/dggH81kko1C
 jPSr9FnDp5bhuu5bKRDXtZVwISfECc2lZ+/EEax7Ia/VkseE7MWw4qk+CNtGPz8An1SNtKg+sXA
 BnQVeKT7d3h3nEzR87gxghIwcx7F5EK7jZcrIppXU14NKaCkTYBOLJKQVSGrI2Ei+3Odp7qfA1Y
 nxO4mWW73WVw4Ids6eEPgccQE5ZfcFmoX28zBR5Q/Vtq57qgicH9efCY1Y5aWO4rsIyjd9qXrDC
 ZY1SWdoFqnWEtbOc3oSbqJX4mwg44SRzrJpe3kLsKvPHkkVW7LSEdS1c1ZWCRQDNU+vKdvDy7LX
 D49D2U3+0B3Hy+4qcGY4DoZM6Z3CKNMr9+nfvA8QZ6yCy7wzlpNMf00O99zSIndj/kxJdZlQ6J2
 FjI0dfjfOHeNoXOMFPXLuYgfPeKDtGGD2J9KZyEvE62B5rXZ6fRJjf2/kqF1blXA==
X-Google-Smtp-Source: AGHT+IEL2Xz8w5uOC3QkjdQ9UzjWO3YAG7DWEIJBbRopNxYDXJQ346qhwH/72DFadH1hI7de6Wwj2Q==
X-Received: by 2002:a5d:6e88:0:b0:430:fcda:4529 with SMTP id
 ffacd0b85a97d-4324e703b00mr28604269f8f.61.1766937618197; 
 Sun, 28 Dec 2025 08:00:18 -0800 (PST)
Received: from [192.168.1.15] (alyon-655-1-564-32.w80-9.abo.wanadoo.fr.
 [80.9.105.32]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43277b0efefsm24128692f8f.25.2025.12.28.08.00.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Dec 2025 08:00:17 -0800 (PST)
Message-ID: <1b73aeb0-fa3f-4ced-9c07-5f0accebc324@linaro.org>
Date: Sun, 28 Dec 2025 17:00:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 16/25] system: Allow restricting the legacy ld/st_he()
 'native-endian' API
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Peter Xu
 <peterx@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Anton Johansson <anjo@rev.ng>
References: <20251224152210.87880-1-philmd@linaro.org>
 <20251224152210.87880-17-philmd@linaro.org>
 <CABgObfa9gHpK3CR8Aa6MA4YqfaMs3bn70pba58QQ2+32+xwxzQ@mail.gmail.com>
 <e0b99887-934e-4587-9410-b090a4fcfdc8@linaro.org>
 <5e44a3e7-5eb3-4220-9193-8eb86690535c@linaro.org>
 <CABgObfaXgpdPe32ks+xkzOuNxvJMJhsfpvtjFobBJTueR1X24A@mail.gmail.com>
 <913b7541-d8f0-47b9-8523-9e1389bf4f84@linaro.org>
 <CABgObfYXW7RqZjqHVQd8T-RfZvy8oxb7-uWK0Au1W5VXzHVSNA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CABgObfYXW7RqZjqHVQd8T-RfZvy8oxb7-uWK0Au1W5VXzHVSNA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 28/12/25 16:38, Paolo Bonzini wrote:
> 
> 
> Il dom 28 dic 2025, 16:14 Philippe Mathieu-Daudé <philmd@linaro.org 
> <mailto:philmd@linaro.org>> ha scritto:
> 
>      > Perhaps the source of the confusion is that they are in bswap.h
>     but they
>      > (quite obviously since it's host endianness) never swap?
> 
>     Hmm, maybe not well named API then.
> 
> 
> The name is fine, the placement maybe a bit less; they could be moved 
> out of bswap.h but it's not really necessary to do it now.

Indeed not needed now, but already done to figure this API ;) This
helped me to understand what we don't need is "DO_STN_LDN_P(he)"
because this is a convoluted expansion to a plain memcpy().

>     OK. Let's consider the following patches removed then:
> 
>     - 03/25 system: Use explicit endianness in subpage_ops::read/write()
>     - 14/25 system: Use explicit endianness in ram_device::read/write()
>     - 16/25 system: Allow restricting legacy ld/st_he() 'native-endian' API
> 
>     All the series I posted this week build fine without them.
> 
> 
> Great, the other change I suggested was about the handling of MO_BSWAP 
> but it can be done separately.

This request is not ignored, but I plan to address it on top to keep
current changes simple enough.

> 
> If you don't want to repost and prefer to drop patch 14, we will also 
> remove DEVICE_NATIVE_ENDIAN from subpages in a second step, for example 
> by using "HOST_BIG_ENDIAN ? DEVICE_BIG_ENDIAN : DEVICE_LITTLE_ENDIAN" as 
> in the ram_device ops.

Yeah, that would even be smth like "DEVICE_ENDIANNESS_IS_IRRELEVANT", as
we call directly the ld/st_unaligned helpers. I'll think about that later.

