Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5034D4A5F4
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Jan 2026 18:11:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhXEp-0000N0-Ly; Sun, 18 Jan 2026 13:10:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhXEj-0000G4-Fw
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 13:10:54 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhXEg-000711-Sp
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 13:10:53 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-42fb2314eb0so2951395f8f.2
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 10:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768759848; x=1769364648; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=henWba5x/9LjBcKr1vmCemJf+c1tGNtHiKStGq0IWxY=;
 b=HSrlvIrzozOqf9pAUq7sodCkZSJr88GfgZfvbUFosXxPck8dBaH0OCrzdQ21dk3cTy
 tXt0Zvij9OfQ5klQbdCeKpR0wXJ5GiHaKtx8tuU7ckbPxkuOkAVNv1hZnVJP+ClLsEWQ
 9glnUnS2j14ia35rjGVnmVXpINNDWCgPLmca/R/ls/Na/OuQ37eeytATXbB5c5xFH7n1
 W6sJT8M2sS8AMfcaqF6GCsebcyBXuQrYjSX7L6R8OusOk+suuHSCbapR9BoP7l6Ps0P+
 qFCo+RAQZOGCNSoqjuS3AfAS9IUyU6Qi/8dK7O+1sAM4nSRhYkd34Y85BdFNIIjobA9j
 OOTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768759848; x=1769364648;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=henWba5x/9LjBcKr1vmCemJf+c1tGNtHiKStGq0IWxY=;
 b=CuHzdmroGNA9jlusTqzeU4CAoKnX12psxRgSNytAefCzwayWT64ZEbQ5rqKaPAcPwy
 h6CdbUBhellehbOSjDbM7/aPOwN3X4VxNML+3hkMmYJfQ3RNip64ydPBZ17IkpeU3+w1
 UtQ6anefXp6ExUv/HhNC4fU3FpWF6BK/lT5llBCFejP6WeWqqDhylgbWwEDDcL5K95B/
 TtPlSbGh/PvM2QWZi9zik5gdg/nSaHV/LO5TdafjjQlRsODH51OE+E9bvLkOezIkfhHC
 D0tQT/B0LDqigbecEzBMh+JFRQVQvZnNWXiVDNTn3uqKiSEromekfrzxzmMb7diTBNYw
 820g==
X-Gm-Message-State: AOJu0YwZRJd34Z89AMQsWZQkSNHdeAjlkylyw0nF5BIgLlz5HwGsG6ez
 cuG+xnVrdyzrNXe1ETMrdqKmnpnOyvBvff0ZM95DxmVAKxupEZn+XteTLf131AMolpk=
X-Gm-Gg: AY/fxX5YUYMxlqaxafh/DUl4a94detTMMcCAC87m8TFguPwS39HHFtrSKVlFqZZtgNw
 OPl7chxPlRZrgAK+2ieju5vce1ptmlrfTb1dcjvfCOKuJQoZsxRfYtW9PgIUY53Xk9bV826liMQ
 JSPa7067OlazSEL9Ln4XM1CxPI9Kd8kY/D+LtpLicJorOJ6i3dV1oG9pr9lb4cPUeNoKLU6f2a7
 iuVFWIf6rh6lPH4ltAPuirfxaeix5TseHDfa54vp0x27sSm2gRyY4dIbg8KjQlL2l1WCgnz3sML
 K6irm8mFC5cPSrjue3yg5sg0t7/Vpe+r+sYqBKujIWlocM5JW0mNq1PB9DH6NdgCuP9gm7HoBwp
 Afu1kZyZqmwOdqHBwGbGCx9ThIHFgdRUNKMX96Z/WFfV1KW+pHim08yBQPbkgwN9YZJ3hD5eax0
 Q2Yl+up7n80BBEhCWMZuk+6wkT0xNyc//MlXS30t6L7k/8ttazrKiSMA==
X-Received: by 2002:a05:6000:2506:b0:432:8504:befd with SMTP id
 ffacd0b85a97d-43569bbb23dmr11589941f8f.32.1768759847280; 
 Sun, 18 Jan 2026 10:10:47 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43569926ff1sm17944481f8f.13.2026.01.18.10.10.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 18 Jan 2026 10:10:46 -0800 (PST)
Message-ID: <18c498af-2985-4595-ade8-a9d0fecefe7e@linaro.org>
Date: Sun, 18 Jan 2026 19:10:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/22] system/memory: Clean ups around
 address_space_ldst() endian variants
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Peter Xu
 <peterx@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20260109165058.59144-1-philmd@linaro.org>
 <CABgObfaEj8_ssaUhZRpsH1u-wRiPU=V0yj165WRuMBoOy92qBA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <CABgObfaEj8_ssaUhZRpsH1u-wRiPU=V0yj165WRuMBoOy92qBA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 9/1/26 18:26, Paolo Bonzini wrote:
> 
> 
> Il ven 9 gen 2026, 17:51 Philippe Mathieu-Daudé <philmd@linaro.org 
> <mailto:philmd@linaro.org>> ha scritto:
> 
>     Missing review: 2, 12, 20
> 
>     Since v4:
>     - No change (RESEND)
> 
> 
> For subpages, are you leaving for later the switch away from 
> DEVICE_NATIVE_ENDIAN?

Yes, this can be done later (I rather not delay the rest).

> 
> Paolo

