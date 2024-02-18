Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12DCCC48BF6
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Feb 2024 10:48:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbehs-0001Kj-Lb; Sun, 18 Feb 2024 05:47:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rbeho-0001K8-T7
 for qemu-devel@nongnu.org; Sun, 18 Feb 2024 05:47:34 -0500
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rbehn-0004e4-CN
 for qemu-devel@nongnu.org; Sun, 18 Feb 2024 05:47:32 -0500
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-512a65cd2c7so972635e87.0
 for <qemu-devel@nongnu.org>; Sun, 18 Feb 2024 02:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708253249; x=1708858049; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BJcvJhiwaejnTO/DIOGvejGfy+J2P3nr370D+BNUmbA=;
 b=u3z/Zl9IO8dWSBbRICVYgbfW93LdxOMrjsD8Q2cHb8hpcXGi5cqiArqr6nsMfyStOj
 5WjN74TudXRrj72areCyd4imRRrbhTfFItr9BDMxVUF6tLAZ3EDyO0jEdpfbvCC/sVGI
 09A9WTEoLO0zD5hRwE9HsAC8buEKVTxaO72N2WD5WjtqZwyppp3OmHxGErTHgttJcxpS
 uDabFD9X5DAR8ye3MWVpMq77heYPlIuMrPv5g1lz92Weg7reerkNLtszUQ5LPR3bxsat
 Um/MEsP9/4q25rkzXx2xFXu9A0AjKwiK4wyqZ0Gchc+jbsnLfe5Y8pYObQseLK0BzDbL
 mCsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708253249; x=1708858049;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BJcvJhiwaejnTO/DIOGvejGfy+J2P3nr370D+BNUmbA=;
 b=PEw5umlTBJ2aZh73PXLA6N5Mhg/gyzVpGUbYY756PXo7eS8b2zVEH3hLgagPHHOslM
 SnRScahPpLspNef9tHul9FiCgFfW5IAcvFk8X2v4GX94oVHMXrWnQC5NRrLgKnXH1IOK
 bH/r/nx8NzUfGWWdnrSEl/fLfCfP+Ejf53d7jSmAK++yOBwLHO3IK4+oVtEaO17RIfNH
 m70hthIDMqNW5TtDZJTEFhxAFRldPeoVMishmirNjIUXW2HaAnTpnCp4fxvBq+ffm+IN
 bBCmEty1zQ+V2mcfXqq0zTeUoU9xn4SEKierLuHEM6m20n3z2dln2kEyw7lwKfslldLj
 P31A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/MCtOCE8ZwjnNyDWCxWX/Uw5vTl7XqKzR4+lq67B9U28oQIRR+zqzXGZsNCIMESi6uxB4uXfLdFzUddz/o6umNfbrahQ=
X-Gm-Message-State: AOJu0Yx46LKexSyZOexrDR26XBpYhiK25KZ55hlqbwNOWyk1FnOfdDrr
 /YDM2xp1TMyoQ6egkMMQ6CoqY/hv2a8Li0PdwNtITBbl9mVWTu6+3lnR1CgNFHQUwJuWRo55wUI
 3
X-Google-Smtp-Source: AGHT+IE5dV++T7h/HyKyL9nmnvqUL98rGZvYGCHGzPVuJnx9f5M/f18dvvKcOpT5NDicHDUAilzn8w==
X-Received: by 2002:ac2:51a3:0:b0:511:7f2f:47a3 with SMTP id
 f3-20020ac251a3000000b005117f2f47a3mr6666509lfk.8.1708253249135; 
 Sun, 18 Feb 2024 02:47:29 -0800 (PST)
Received: from [192.168.69.100] ([176.176.153.199])
 by smtp.gmail.com with ESMTPSA id
 jw15-20020a170906e94f00b00a3e86a9c55asm149085ejb.146.2024.02.18.02.47.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 18 Feb 2024 02:47:28 -0800 (PST)
Message-ID: <a69d2291-4bd6-42de-9049-e973b11d0acf@linaro.org>
Date: Sun, 18 Feb 2024 11:47:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/i386/pc_q35: Populate interrupt handlers before
 realizing LPC PCI function
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20240217104644.19755-1-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240217104644.19755-1-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 17/2/24 11:46, Bernhard Beschow wrote:
> The interrupt handlers need to be populated before the device is realized since
> internal devices such as the RTC are wired during realize(). If the interrupt
> handlers aren't populated, devices such as the RTC will be wired with a NULL
> interrupt handler, i.e. MC146818RtcState::irq is NULL.

Why no CI test caught that?

> Fixes: fc11ca08bc29 "hw/i386/q35: Realize LPC PCI function before accessing it"
> 
> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/i386/pc_q35.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index d346fa3b1d..43675bf597 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -240,10 +240,10 @@ static void pc_q35_init(MachineState *machine)
>       lpc_dev = DEVICE(lpc);
>       qdev_prop_set_bit(lpc_dev, "smm-enabled",
>                         x86_machine_is_smm_enabled(x86ms));
> -    pci_realize_and_unref(lpc, host_bus, &error_fatal);
>       for (i = 0; i < IOAPIC_NUM_PINS; i++) {
>           qdev_connect_gpio_out_named(lpc_dev, ICH9_GPIO_GSI, i, x86ms->gsi[i]);
>       }
> +    pci_realize_and_unref(lpc, host_bus, &error_fatal);
>   
>       rtc_state = ISA_DEVICE(object_resolve_path_component(OBJECT(lpc), "rtc"));
>   


