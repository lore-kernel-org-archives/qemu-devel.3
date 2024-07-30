Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D843C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 22:37:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYvSR-0005bU-FU; Tue, 30 Jul 2024 18:36:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYvSP-0005Z4-FF
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 18:36:37 -0400
Received: from mail-il1-x12d.google.com ([2607:f8b0:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYvSL-0001RD-Ox
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 18:36:37 -0400
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-395e9f2ebc0so29991295ab.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 15:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722378992; x=1722983792; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ObO4rf3+Yh1uQa1rPri0fpxTbgw3SANBVkBBG+duNQk=;
 b=VOOQonCKsrt/K6aP23Uf1T0G++cwMad6JxvQWGA5a5cTQpFBNSec0DReYEtBmxHoh8
 30SRvhDI5SPWt3I8UbeMXbI7zOSowpKTjr7PNBcn8SyqrGYER2EJYtrGECyHhxe83hwo
 fcgDImm/csG9fwBemDu5hdu7ygn3hlLEWpf8Uk5/UkJ+5IFra9Jyeeg1DQN10Y/vBvCv
 xXWqidN6nEfZJQXHWvpsl8HLG7i0LVgPFOCwNGrdgPntFVWOF2A4xnBFudOpakOhxvGK
 hvbbXBe6TU5qBByHpuTlMBr9UZ/y3884iqGgqxQGt1nN1JpkrQ4vLKhi2YstQrmYNIKj
 ul0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722378992; x=1722983792;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ObO4rf3+Yh1uQa1rPri0fpxTbgw3SANBVkBBG+duNQk=;
 b=WVfQKEosQrQhxWFz/+5G/y9T3AwjyzCsFCN2kVSF82q/vGXDvArN2xpcJJpYOzjx7w
 BNAbS9NbHUhjf2oglKy6Z1FZfQxFERpPuN02rM740JmPLZWkZ1Sll1wJ7L43TFvJRU5Y
 sFI/mZVV5/Sm4zaifGOnGm6xg5DrQdgO+XKO/Zm4udsiVr3YOPvhdv6Qwx1fR8QaKg0v
 X49LE17kJ+OWJe1DVpdxKs5g8MUpL7rurZPVLmJDOrDjL6Oib75/cBK5C9oSumE1fozE
 /i3XEqgaJdopx3AEPmr3QSP5YmzMBsKiNEn8UsvVwK7i9f4RSbixIAlzcp5XjqS4PAQ+
 ilog==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGnmYecuDX8EjFqUDUyrYBEIHcpsUN1mgac8iq1uTX5lR2NhQ1WKfCTZhOL2QKfwGMXBBx73MZJtWtwepXXc5cTbKNOsI=
X-Gm-Message-State: AOJu0YyNKX0Hq4WmmW4ZI6rg+u5T9uGyEBbkT0UKOVN0lR8mLTBvyz5W
 Sam4qTetMzsynxa7+62V6ISQWh4W07+GjZQ7pIehendXcITg09J2wIsiI95/H8I=
X-Google-Smtp-Source: AGHT+IFort65k2CnKQJNC5X+UbmYERnaCL1Fai51jHT1GGoXXxmFsE+LYb8pvo0U5+18TirPRKmvUw==
X-Received: by 2002:a05:6e02:12cb:b0:374:a44b:1186 with SMTP id
 e9e14a558f8ab-39aec2df3e3mr172211655ab.12.1722378992169; 
 Tue, 30 Jul 2024 15:36:32 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7a9f7b7b029sm9310999a12.11.2024.07.30.15.36.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jul 2024 15:36:31 -0700 (PDT)
Message-ID: <7c9662a0-240b-4bf5-9676-5eff403f86ef@linaro.org>
Date: Wed, 31 Jul 2024 08:36:24 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Handle denormals correctly for FMOPA
 (widening)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20240730155819.2958924-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240730155819.2958924-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12d;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x12d.google.com
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

On 7/31/24 01:58, Peter Maydell wrote:
> -void HELPER(sme_fmopa_h)(void *vza, void *vzn, void *vzm, void *vpn,
> -                         void *vpm, void *vst, uint32_t desc)
> +void HELPER(sme_fmopa_h)(CPUARMState *env,
> +                         void *vza, void *vzn, void *vzm, void *vpn,
> +                         void *vpm, uint32_t desc)

I think the env pointer should replace vst in the argument ordering.
That keeps with the standard gvec signature.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

