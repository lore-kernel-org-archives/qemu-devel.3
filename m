Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 382DEC3ABA1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 01:39:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twtEb-0001Zc-K9; Mon, 24 Mar 2025 21:37:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twtEZ-0001Z4-E0
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 21:37:39 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twtEQ-0007QO-HF
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 21:37:32 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2243803b776so25110405ad.0
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 18:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742866649; x=1743471449; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hy7YxU/BOkkmct0LEa6sX5iFnTbsVC/VEJwRAgXKmQ8=;
 b=DPY0Iwfgyv//K7WXSeaEv2tzdMiQFY/nRdF9la2TR6q/7Jm/0WbDDfbVRbSI1DXr4+
 I2l1pviPHuXFkoBME9BDGdR6M/VP1ffLsYa435rvzw10z3Q4bz8Ad+5D4lXvqCWsfTA9
 YD8GIDveIED0uBRWWNdS0AcfBdDB/NoEAC/2vOB5DJ5JsJODv3fju9IrQckghA7JKgrj
 /buQvMR7c2ruYYJNP83r/LHkXrY330ixFtjkN2nE559TSOyqnQM3lx3KOtTxrptDut0u
 2eOOP+WSlqgJxt6DefeLMxU+VjJpv7vU/XjwtrKyhbHUjLkIzPwP+qrV+AwllDTuj3Zc
 5jSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742866649; x=1743471449;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hy7YxU/BOkkmct0LEa6sX5iFnTbsVC/VEJwRAgXKmQ8=;
 b=kQshcRdUXA253ZsXEh+RdNdJe9Oh7yHcV1L9Oev39GCDvWqCZByFSrjSAJMt5Of6WW
 lj80y/HdBHk9Ikw2bX0gj1n0YrEA6aoBpAJWXMYYCqhu7HXArxkUvRo0sKVKD8LWu+up
 MwfmyZ9+MCV47owllGf2PnKlnRIco/t4/sBM5srZR6T9OCw1UeGnPpj8Wg0X/syxHsQR
 ceAq9U9Rknu7/A6OSKK54abrhbj7nMifOKEUopYrCv1OrEgcf7r8k3EzDZugqCGbjQO+
 +vwJ6YdajmA3LHBI1igGVyUJDigyEvGQP+wWsQUpUjxnI7sGGXPSbkLe9Iuy72kqjCiM
 fyeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNGZhmHVFN5HfBQJw2brADUJn+suyaOrh3BZu8+OYF7y78F+xO8QsoMC5DdA3SwiFykWnBTPCiDRwJ@nongnu.org
X-Gm-Message-State: AOJu0YxnJCmnVTra8qpPcyi7EekJYd83xrOYdMSghY9qKw4llxp10lxo
 hqgwSPK5ye23jGfb+WrTCyAosezvaUsMVfHIzZJeK/k1nL7WQYA5MVgLpYOAasA=
X-Gm-Gg: ASbGnct2wbHDDGszcSausVCmZb0To+dTlgtQoDKsbRCG7tYsJz3zlV1BDcBd2Iw17I7
 i9Rrk71ffFSy5phe455/NP/6oOtv+Gv/G7gF2LCvpL2ioJcDcpYSDWzcT0qJnU54wmM7lriPnX+
 uIqyOIza8obILotWBUuuEIRi8Y3J4P3728bZs0F1/z4ArgLfgw/u0cmlCFYGLGvP08svwjHwBlV
 OiusPF7wowpiQF4N6bGCFUWR2xebmqswwc1XpG//zglj+BfWu37cBfsoahvLUPxdcJnF/tZUjit
 gPNXMueGomDvHzdi132x2GRJAF5nzDVYUV3IpZgJRdeYXmKlIy/oT9xbCg==
X-Google-Smtp-Source: AGHT+IE0ViLTJJKIDYC+v+HjmD2dTkpz1tg1gxPDYjWHjlVt9rgnR8M9FQqYMVsIQunInfx02DfYAg==
X-Received: by 2002:a05:6a00:2291:b0:735:7bc0:dcda with SMTP id
 d2e1a72fcca58-7390597e330mr21664245b3a.5.1742866648965; 
 Mon, 24 Mar 2025 18:37:28 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73906158ef2sm9090422b3a.141.2025.03.24.18.37.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 18:37:28 -0700 (PDT)
Message-ID: <a4f03a8b-4bfa-4039-97c8-11f1a04d4c94@linaro.org>
Date: Mon, 24 Mar 2025 18:22:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/17] hw/avr: Move AtmegaMcuClass to atmega.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mrolnik@gmail.com, philmd@linaro.org
References: <20250323173730.3213964-1-richard.henderson@linaro.org>
 <20250323173730.3213964-17-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250323173730.3213964-17-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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

On 3/23/25 10:37, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   hw/avr/atmega.h | 20 ++++++++++++++++++++
>   hw/avr/atmega.c | 22 +---------------------
>   2 files changed, 21 insertions(+), 21 deletions(-)
> 
> diff --git a/hw/avr/atmega.h b/hw/avr/atmega.h
> index a99ee15c7e..f031e6c10a 100644
> --- a/hw/avr/atmega.h
> +++ b/hw/avr/atmega.h
> @@ -23,6 +23,10 @@
>   #define TYPE_ATMEGA1280_MCU "ATmega1280"
>   #define TYPE_ATMEGA2560_MCU "ATmega2560"
>   
> +typedef struct AtmegaMcuClass AtmegaMcuClass;
> +DECLARE_CLASS_CHECKERS(AtmegaMcuClass, ATMEGA_MCU,
> +                       TYPE_ATMEGA_MCU)
> +
>   typedef struct AtmegaMcuState AtmegaMcuState;
>   DECLARE_INSTANCE_CHECKER(AtmegaMcuState, ATMEGA_MCU,
>                            TYPE_ATMEGA_MCU)
> @@ -32,6 +36,22 @@ DECLARE_INSTANCE_CHECKER(AtmegaMcuState, ATMEGA_MCU,
>   #define TIMER_MAX 6
>   #define GPIO_MAX 12
>   
> +struct AtmegaMcuClass {
> +    /*< private >*/
> +    SysBusDeviceClass parent_class;
> +    /*< public >*/
> +    const char *uc_name;
> +    const char *cpu_type;
> +    size_t flash_size;
> +    size_t eeprom_size;
> +    size_t sram_size;
> +    size_t io_size;
> +    size_t gpio_count;
> +    size_t adc_count;
> +    const uint8_t *irq;
> +    const struct peripheral_cfg *dev;
> +};
> +
>   struct AtmegaMcuState {
>       /*< private >*/
>       SysBusDevice parent_obj;
> diff --git a/hw/avr/atmega.c b/hw/avr/atmega.c
> index d4fc9c4aee..96e36743bc 100644
> --- a/hw/avr/atmega.c
> +++ b/hw/avr/atmega.c
> @@ -36,7 +36,7 @@ enum AtmegaPeripheral {
>   #define TIMER(n)    (n + TIMER0)
>   #define POWER(n)    (n + POWER0)
>   
> -typedef struct {
> +typedef struct peripheral_cfg {
>       uint16_t addr;
>       enum AtmegaPeripheral power_index;
>       uint8_t power_bit;
> @@ -46,26 +46,6 @@ typedef struct {
>       bool is_timer16;
>   } peripheral_cfg;
>   
> -struct AtmegaMcuClass {
> -    /*< private >*/
> -    SysBusDeviceClass parent_class;
> -    /*< public >*/
> -    const char *uc_name;
> -    const char *cpu_type;
> -    size_t flash_size;
> -    size_t eeprom_size;
> -    size_t sram_size;
> -    size_t io_size;
> -    size_t gpio_count;
> -    size_t adc_count;
> -    const uint8_t *irq;
> -    const peripheral_cfg *dev;
> -};
> -typedef struct AtmegaMcuClass AtmegaMcuClass;
> -
> -DECLARE_CLASS_CHECKERS(AtmegaMcuClass, ATMEGA_MCU,
> -                       TYPE_ATMEGA_MCU)
> -
>   static const peripheral_cfg dev168_328[PERIFMAX] = {
>       [USART0]        = {  0xc0, POWER0, 1 },
>       [TIMER2]        = {  0xb0, POWER0, 6, 0x70, 0x37, false },

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


