Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B402C25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 16:10:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBcvh-00058B-4w; Mon, 27 May 2024 12:10:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sBcvg-00057y-CT
 for qemu-devel@nongnu.org; Mon, 27 May 2024 12:10:32 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sBcvQ-0001bx-LS
 for qemu-devel@nongnu.org; Mon, 27 May 2024 12:10:32 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-42102c51524so24723495e9.1
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 09:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716826215; x=1717431015; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=R9qSmOdrCVnRR6Mk4dZsp5uLeuOZ6apDqnW//et28CY=;
 b=KprlFfGvgUOMXuMQvUfTs/ch/kDLdtI61lWvvJ1ZFVP6vZ7bFx5vJoAryT48PnPNWm
 EMH3bGIU7LSC8mcYrQWepX3qrgIRTGsmn3neeqZdFGi40ySKXFspOJhtKfNk89CiBqP3
 0smB7iZTVlVOy1/06vU+dinCYlBAgd08xZhuJJzv6Y8yO7ObJLNpTsKY8hXuAzFJBpfg
 ek/dAhLKopNcCiBIwouFXW5uZt+EDr9IzJgpSRRbGwb7DJuPsMfTU4gUevs4wnGkfYDM
 iXmVbn1Cup0LmSqgLqVgPYtKXQUH8+KDJR87nb5rvswrHnpBpvmU21pkztgynj8CqT1M
 tM0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716826215; x=1717431015;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R9qSmOdrCVnRR6Mk4dZsp5uLeuOZ6apDqnW//et28CY=;
 b=RnYB4R6NhPBaEBNpA6KwuuF7LIybu+hSYgqeseWh62u/nJS8HwEkwJCNhuuH0nJWMs
 /LrbctGfkI9/aoMw4EUHFLFPMkT1wY/laOIbOcpC1udJLUh01Eq2znk8/Z6W1PSQa+lw
 iO35ALQQNx3dvnicfKdPmuobHSXGnA0dQ7iGS+CJB6h976yHZhWGXAxmj9AalUBkleiB
 rOWLaR40NiKESukozYRaBRUZk7eex3cYMDW0cJwCqxpIcsm0gCr+tljCphJVaSL28aOZ
 Aj371t3Utu5uBlS+iKAqXSs7EPNv3W5ZA4J/Nm4YADbeA5+h7rP83xjZojW4LqlWSJsa
 Zcjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOpBuVPSJwsVJns8Bum9YS5nrIGwaTnZVyWio1gcl0lxmhoX5cQQF3AgGD7HpR8yiAtjUAHl2fiXSCrFzXWiB+7e6S5x0=
X-Gm-Message-State: AOJu0Yy2DysoYopfFkP4yas8aaxnvNZ3naNWFB+SssZvnDjgDeAiqrf9
 MbTg4EelcHUq4JdwcqMK6BpGE2n6nNQZsSfOxaWX9ma0eXEzbDiRiyLUYSgq02A=
X-Google-Smtp-Source: AGHT+IH0J+a7Uq+ZMw+hXeLyApfdhVWMU2QpApI3DSam8AE7bf15zO64/zBOzVYFhlcMleXuk0ZMRw==
X-Received: by 2002:a05:600c:1386:b0:41c:66:18c2 with SMTP id
 5b1f17b1804b1-421015a6086mr105678435e9.4.1716826214964; 
 Mon, 27 May 2024 09:10:14 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.152.134])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-421089afcfdsm113725695e9.36.2024.05.27.09.10.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 May 2024 09:10:14 -0700 (PDT)
Message-ID: <f8ef776b-3ae8-416f-ba73-bf141bbd33b8@linaro.org>
Date: Mon, 27 May 2024 18:10:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] aspeed/smc: Reintroduce "dram-base" property for AST2700
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>
References: <20240527124315.35356-1-clg@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240527124315.35356-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 27/5/24 14:43, Cédric Le Goater wrote:
> The Aspeed SMC device model use to have a 'sdram_base' property. It
> was removed by commit d177892d4a48 ("aspeed/smc: Remove unused
> "sdram-base" property") because previous changes simplified the DMA
> transaction model to use an offset in RAM and not the physical
> address.
> 
> The AST2700 SoC has larger address space (64-bit) and a new register
> DMA DRAM Side Address High Part (0x7C) is introduced to deal with the
> high bits of the DMA address. To be able to compute the offset of the
> DMA transaction, as done on the other SoCs, we will need to know where
> the DRAM is mapped in the address space. Re-introduce a "dram-base"
> property to hold this value.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   include/hw/ssi/aspeed_smc.h | 1 +
>   hw/ssi/aspeed_smc.c         | 1 +
>   2 files changed, 2 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


