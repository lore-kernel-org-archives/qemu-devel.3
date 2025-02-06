Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9CE9C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 09:22:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfy5l-0004DV-Tk; Thu, 06 Feb 2025 04:22:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfy5k-0004DG-0M
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 04:22:36 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfy5i-0002TI-56
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 04:22:35 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4363ae65100so7058985e9.0
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 01:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738833752; x=1739438552; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ucLbf6McKPZCu5LWqoHXPjVgQjymbuLDL3K2a69zdug=;
 b=YIAUvItNSSWjU0maTptRuHQ1VaYTviH/CpfTrW4raEvSSqxDMp/+H2DSuVIaSTZBGb
 6/GbNlg0pbV3+odsTFMWalwHzeq7qAQpAFOTAaKjT5he3fytCurYJHQPtQfv9Jnx0xkU
 N9HkFSgKPuw7VptfQwmy3PXgJMff8vdK2Q/yXpMankYXghaZTzwIbu4/KaPtIXeKWdbS
 eJjzMzplUjrWyMk++kmf/ZbeThx9RMbUkhLpBDOCRnYnOWhHpCHUzGL/9ErLmHQCr3ol
 jHz0+5en48wZ/F6kjWCXpYYHy7lV8IwgdI+M4/2b8Q1CtaXaB4ArqTyiQtx0jRPq+OCH
 6R2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738833752; x=1739438552;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ucLbf6McKPZCu5LWqoHXPjVgQjymbuLDL3K2a69zdug=;
 b=qjYGVYL4/01Nd9/Uj3NZwCap9jRTxBd/mxyvtMKxSJ9Scyjy7NwVgT0Ohe6WXlAF4K
 md/UpxZqcTnVVNKsP+bjy3+s3yX5iC16BPopsBvyObbNV2CHxUOfDDz2zWTyRz+XHg7M
 1tQVHWPYLsGpcs6PXNX0Cz9ipwhtWX2sikX6/PknOGeeOOrDp6HOYSPI9TbVv/PKM/es
 SGHGs0u3IpUfcfXuK2ksb1KAMmt8wMTBbaTf45TPelpdgOv/0ZXnOM+4bUM3wdRiVLaV
 sEOI8RT8Zw6flX82F31gnEyPjaQQTYnOXe6d9l/1bzhNSBHDOzFus9lYRbl4DrK7xcLi
 UFsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXj9cUe+V4PflrHRIwGR3a8BzaobVhsio+ONy9F2KiW+UdL0qJ527+MFV/9+CcC5/e0j44R3Jx1QI/E@nongnu.org
X-Gm-Message-State: AOJu0Yz9Ke4H197cNrp2gy1m6U3WnSsmnAWjf6fqs+5U0HuvPpbAH/vL
 sJEq4PhxzTgv5Rqf2iHlpnzgJCiP0YpYPZIoKKQiwBs48cjryZgROLgTlxM6FMI=
X-Gm-Gg: ASbGncviJSh01/UmXTOdkCL2VDQAYZE3g2c5sMMm1NPSS8ls/LwI3NYGIu/k63wUt77
 IxBqbMFYxunE7L7PuqKEg1oocw9ANUEqqT6IU+i1ad+H71TURNl625U1gfYUJEdLxMoWT0cC79+
 /YV9bgO4NduQSbHpZZRtkijfaaPqIvObL5g2pDc/CP5ENWEKd7gPSaGRi59EmKUi/dP3+1gx/q9
 cIq/Y8YuBuXYPxkTpHn/37RdBroKweFtcHjl1jagFgAXd529ImEhNMv8I69rtTpIb6uWexmvxgB
 KsJgseHUQf/SskXseTixLvRG743C0O97UcvoOpO5CGDRwlaPk6TnsYQbbnI=
X-Google-Smtp-Source: AGHT+IEVYcUq6Nr0L7kZXbp6erAI5QIlIKdpmrDCLGz3PYH94ASF7bBA+osaWCov+hBssnNy+1mq3g==
X-Received: by 2002:a05:6000:1889:b0:385:f909:eb2c with SMTP id
 ffacd0b85a97d-38db49005f5mr5297634f8f.38.1738833752020; 
 Thu, 06 Feb 2025 01:22:32 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4391dfc87desm12531185e9.25.2025.02.06.01.22.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2025 01:22:31 -0800 (PST)
Message-ID: <387122a2-0e10-44bf-9810-aa8b122b7425@linaro.org>
Date: Thu, 6 Feb 2025 10:22:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/17] hw/misc: Add nr_regs and cold_reset_values to
 NPCM CLK
To: Hao Wu <wuhaotsh@google.com>, peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, venture@google.com,
 Avi.Fishman@nuvoton.com, kfting@nuvoton.com, hskinnemoen@google.com,
 titusr@google.com, chli30@nuvoton.corp-partner.google.com
References: <20250206013105.3228344-1-wuhaotsh@google.com>
 <20250206013105.3228344-13-wuhaotsh@google.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250206013105.3228344-13-wuhaotsh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 6/2/25 02:31, Hao Wu wrote:
> These 2 values are different between NPCM7XX and NPCM8XX
> CLKs. So we add them to the class and assign different values
> to them.
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Hao Wu <wuhaotsh@google.com>
> ---
>   hw/misc/npcm_clk.c         | 19 +++++++++++++------
>   include/hw/misc/npcm_clk.h |  9 ++++++++-
>   2 files changed, 21 insertions(+), 7 deletions(-)


> @@ -870,10 +872,11 @@ static const struct MemoryRegionOps npcm_clk_ops = {
>   static void npcm_clk_enter_reset(Object *obj, ResetType type)
>   {
>       NPCMCLKState *s = NPCM_CLK(obj);
> +    NPCMCLKClass *c = NPCM_CLK_GET_CLASS(s);
>   
> -    QEMU_BUILD_BUG_ON(sizeof(s->regs) != sizeof(cold_reset_values));
> -
> -    memcpy(s->regs, cold_reset_values, sizeof(cold_reset_values));
> +    g_assert(sizeof(s->regs) >= sizeof(c->cold_reset_values));

Equivalent to:

        g_assert(sizeof(s->regs) >= sizeof(uintptr_t));

Not very useful IMHO.

> +    g_assert(sizeof(s->regs) >= c->nr_regs * sizeof(uint32_t));
> +    memcpy(s->regs, c->cold_reset_values, sizeof(s->regs));
>       s->ref_ns = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>       npcm7xx_clk_update_all_clocks(s);
>       /*
> @@ -1045,11 +1048,14 @@ static void npcm_clk_class_init(ObjectClass *klass, void *data)
>   
>   static void npcm7xx_clk_class_init(ObjectClass *klass, void *data)
>   {
> +    NPCMCLKClass *c = NPCM_CLK_CLASS(klass);
>       DeviceClass *dc = DEVICE_CLASS(klass);
>   
>       QEMU_BUILD_BUG_ON(NPCM7XX_CLK_REGS_END > NPCM_CLK_MAX_NR_REGS);
>       QEMU_BUILD_BUG_ON(NPCM7XX_CLK_REGS_END != NPCM7XX_CLK_NR_REGS);
>       dc->desc = "NPCM7xx Clock Control Registers";
> +    c->nr_regs = NPCM7XX_CLK_NR_REGS;
> +    c->cold_reset_values = npcm7xx_cold_reset_values;
>   }
>   
>   static const TypeInfo npcm7xx_clk_pll_info = {
> @@ -1081,6 +1087,7 @@ static const TypeInfo npcm_clk_info = {
>       .parent             = TYPE_SYS_BUS_DEVICE,
>       .instance_size      = sizeof(NPCMCLKState),
>       .instance_init      = npcm_clk_init,
> +    .class_size         = sizeof(NPCMCLKClass),
>       .class_init         = npcm_clk_class_init,
>       .abstract           = true,
>   };
> diff --git a/include/hw/misc/npcm_clk.h b/include/hw/misc/npcm_clk.h
> index db03b46a52..f47614ac8d 100644
> --- a/include/hw/misc/npcm_clk.h
> +++ b/include/hw/misc/npcm_clk.h
> @@ -175,8 +175,15 @@ struct NPCMCLKState {
>       Clock *clkref;
>   };
>   
> +typedef struct NPCMCLKClass {
> +    SysBusDeviceClass parent;
> +
> +    size_t nr_regs;
> +    const uint32_t *cold_reset_values;
> +} NPCMCLKClass;

