Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F310DC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 08:19:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1MDa-0007Xg-W8; Mon, 29 Apr 2024 04:18:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1MDO-0007Ss-Jy
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 04:18:25 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1MDK-0007vT-RM
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 04:18:20 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-41c011bb920so5513235e9.1
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 01:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714378697; x=1714983497; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+jYjJeRfh2Sv+cRuiHXrA7VNex+0fAJJdEjw1BQ35cw=;
 b=fTbkUVDpcLTA90F7rA3oNj/MTfHt1eZEUdjevTZP2PC0wBdN7NjdFLrN2ONqY8b4/F
 L/vlAb4cwSfQkogY48wQzPDQF57Te1LqmzNdDwEdyCjywpvJbuVVueXH/q3qlrCPk5Hm
 d/xkJR9LcheIv6IbrVei4c547IPjGrxPa6FLtIvYdoyUEJDJXweGxWaZT4jgiD5zSt1Y
 nYa9cE/FUp1388iUi5QqSdyBBRpD2QBwwzcC/7Uv7t13ye/y3QHVd4fuhHEjWDx1o9rR
 B3rF0gLf3bCdjNaE28P0D789irXh3cV8MdyKIGwbRsl6fLdKn/zlTTdVXxkaXGYYkF/f
 otog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714378697; x=1714983497;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+jYjJeRfh2Sv+cRuiHXrA7VNex+0fAJJdEjw1BQ35cw=;
 b=UrFwy7r+nObjWXaSaaM1kbf3Esr394TLEh39lisGwmGQM8gn6R9E4+PCxnatOzMoDV
 8xr01gpxT3+iXupiybq2KcXUgP+XvfOFTwcrvXOol0SE055ghOGmY7gUUKGXsgsFSaON
 KIkV8n6+P2F2oYL1WUQ51T0K55RCaDS4CgeIjAvYFeCYMctOtsgFGdNkW2jbL1Doq68I
 bMLOXOKsRBnotqGKpsdk0SE8cjI346NdWiLfpPFN/o9Ka0AXdcqz67mHE1xqClZ2UIZ4
 VJjVIWSy+U9pEQE0bderK1oCLeqwapXjn4OrIDJ9OvgBIG61Hzp3hnaqsppQ1mdILPgN
 gSkw==
X-Gm-Message-State: AOJu0YwN35ccRZczUtPWxpQHseCUtiMuyXEz1azVb6wCK7WUeMEdwPKX
 IXA4kSzlY8h49gk+fF2RtFncNY3/MZSlA1728hjY9BBLJP7Nc7+Vif9WsPmtlfE=
X-Google-Smtp-Source: AGHT+IHdTLMDutRGSF2e1QG7EWuYiPZHRr4Lh01sKEXj5CoIR+4wPNyl0ZFY2bAp0vwyiP46vLbf6w==
X-Received: by 2002:adf:f34d:0:b0:34c:600b:b016 with SMTP id
 e13-20020adff34d000000b0034c600bb016mr7554749wrp.27.1714378696904; 
 Mon, 29 Apr 2024 01:18:16 -0700 (PDT)
Received: from [192.168.69.100] (bny92-h02-176-184-44-142.dsl.sta.abo.bbox.fr.
 [176.184.44.142]) by smtp.gmail.com with ESMTPSA id
 r30-20020adfb1de000000b00343e392829dsm29080304wra.97.2024.04.29.01.18.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Apr 2024 01:18:16 -0700 (PDT)
Message-ID: <db6a1901-6264-48ec-833e-863f8d54e680@linaro.org>
Date: Mon, 29 Apr 2024 10:18:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/char/stm32l4x5_usart: Fix memory corruption by adding
 correct class_size
To: Thomas Huth <thuth@redhat.com>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 =?UTF-8?Q?In=C3=A8s_Varhol?= <ines.varhol@telecom-paris.fr>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20240429075908.36302-1-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240429075908.36302-1-thuth@redhat.com>
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

On 29/4/24 09:59, Thomas Huth wrote:
> "make check-qtest-aarch64" recently started failing on FreeBSD builds,
> and valgrind on Linux also detected that there is something fishy with
> the new stm32l4x5-usart: The code forgot to set the correct class_size
> here, so the various class_init functions in this file wrote beyond
> the allocated buffer when setting the subc->type field.
> 
> Fixes: 4fb37aea7e ("hw/char: Implement STM32L4x5 USART skeleton")
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/char/stm32l4x5_usart.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


