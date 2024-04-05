Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B7BC67861
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 22:45:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rssJM-00077O-2g; Fri, 05 Apr 2024 18:45:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rssJE-000758-Bs
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 18:45:22 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rssJ8-0003kO-TY
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 18:45:19 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6ead4093f85so2371700b3a.3
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 15:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712357113; x=1712961913; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5Nac1mkC9SF5lrbB+OCnIUPcKgmn1BFjaQ7HVMjBgZc=;
 b=OPt/3aCf6XcD/+6TaFQR4wK7IPDPIZK9C9OKfQmR1jGIu4Q/5Te2xGfdhTTuw8g3p3
 utWH+lx0yYBqwwb5//8dK0VJfIS22G0XzK/PoADrzfvOOd67cQV5o49dWFfVXa8/6QPN
 VWytGuVL/znbrw2HZO3DmtTOG1Dl9NJysD5aC3CnwxVSGIp8WEbNDzVRRggNtRpJMi2C
 uIc5Li2eRwX3BrN8KXBuuD6YjIXk5Lramlohu5BF1YKrP67W8R8tkCQghyT5EhdDeswL
 GLvTuWrxFuaB9K63y7Czwv/ZcEEtHDXhK9aFodKy757hrxKlGD8KYpaTnyil2G+G7A+p
 58BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712357113; x=1712961913;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5Nac1mkC9SF5lrbB+OCnIUPcKgmn1BFjaQ7HVMjBgZc=;
 b=q8B6nLQiNp/Kr/H+7H3kDF106vFR1+3OIIl1zLeEDnRRSkNn5TX2qKr6bfuKFXzN7n
 sYpZ18w+YrhDAExToJ+ZJzj+HpngS9OgZyAaEqaf4t32nDradRIBTFZlAC5Gepnc/KAK
 0OGYyLuK5UeWPVMayhv1knt3KnSAPdb7T6OYV9TCKZb5XEkX7qH0UjJAh7sReyFa/GFX
 3tIoyOIZXs5UuVN7o1AeCFI0asbwlUZ7+OCZnelHfPvgTGg96r/rER/3hG4LOpDniPaY
 +5c7YX0mmHhl+OPrTjlR4JWQ5KTOweXjAGOoqvFHQbG15BdqzPcuFbs1Ce0tUT8JELLR
 2zyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPcCHDj5TgS5jcXWRVUvcGBvemMoiP4jRIQxQow70EONfJs89huOWBp/50MD3P4fp1ERyRPzlzc2luLLSbf4+tUSg0S6I=
X-Gm-Message-State: AOJu0Yy6RpVlZA5QvEIWZxaHW9DCMkFBQGJ2NGCV7vF+oI7H30lNmx0g
 fJkxZGhI3+4B9TzL/kKa8DAvO1KUa2cl0b2xUFteby8J7LpIY+T7lU/2+QHnK3E=
X-Google-Smtp-Source: AGHT+IF2g9C9603a1cjf5Z6nS+5wvVUPfTSW8BL/FUP+KMkokPNE/OT69TUrwHfo8cL5wqfuiGLCgw==
X-Received: by 2002:a05:6a20:ce4b:b0:1a7:175:2cac with SMTP id
 id11-20020a056a20ce4b00b001a701752cacmr3636710pzb.13.1712357112965; 
 Fri, 05 Apr 2024 15:45:12 -0700 (PDT)
Received: from [172.20.1.19] (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 m6-20020a6562c6000000b005bdbe9a597fsm1755090pgv.57.2024.04.05.15.45.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Apr 2024 15:45:12 -0700 (PDT)
Message-ID: <6ff8c8cf-0009-4132-88fb-30ddf61b690c@linaro.org>
Date: Fri, 5 Apr 2024 12:45:09 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 7/7] hw: Include minimal source set in user
 emulation build
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20240404194757.9343-1-philmd@linaro.org>
 <20240404194757.9343-8-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240404194757.9343-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

On 4/4/24 09:47, Philippe Mathieu-Daudé wrote:
> Only the files in hwcore_ss[] are required to link
> a user emulation binary.
> 
> Have meson process the hw/ sub-directories if system
> emulation is selected, otherwise directly process
> hw/core/ to get hwcore_ss[], which is the only set
> required by user emulation.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   meson.build | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

