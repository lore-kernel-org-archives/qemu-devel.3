Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75B3CC46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 23:11:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSmO3-0005kl-0m; Wed, 24 Jan 2024 18:10:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSmNx-0005iD-RY
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 18:10:23 -0500
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSmNv-0002Fd-Ve
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 18:10:21 -0500
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-5cedfc32250so3406917a12.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 15:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706137818; x=1706742618; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FPJsYTCrrJYmiIpsYm+UwPIHv7Gtw161W2iaz3Rf7Jc=;
 b=qJd9NpidO3ngqu14ij0CFDlKEAxW5ogQTNnln65GAY7PEKwGq9iN8kUaeydaQ9IqNZ
 js+hZNXFx2vw5FA9xw+Xg2bUUZIrLWTj5S+DXGFkm1bPaTpqwNPqzFMcOTfF6zOwbndD
 4lwiTPVWzwi65gV2rlKzZl1SZUjjHs5QirNdFRNPYISzckB8wq+mk7ssFF9JMcnE1qzo
 +k81fGLZRE/QZQXLc0GKNBnzN5aOv+rkAxo4nAI2OsBSkh+vtEqjx7UiHqLLtzd6TOdg
 T2OOc4mHo04i3iuNBSFFIWr3kPryswDDpPSCZoad86e7XLQPkEqOYdXo2vEVuC1nDqD1
 /9HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706137818; x=1706742618;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FPJsYTCrrJYmiIpsYm+UwPIHv7Gtw161W2iaz3Rf7Jc=;
 b=gOStqzFYkxZKXgWnbW4Ss3Qf3xcf+5GOU+VchA/PWRTEIPBtNagkRlmgz3W2+AQrvv
 eF5M321dIkOLe5WQIKCFsl4RW/leudt823akr5jNIZP4+FU6vVj6kiUBnwrtiKUQzprT
 yd9wIoztYuzY3Q5yLOVnJickkYun7BdtiiPkTo1RMtWVs1277vbxaEtK5tE9o4iSG41m
 W/Ta5X149bD+fjWgSRG5/nCKwqzgYFF7TWVKSomXbQlqLrLzcIlUODNeWybYhACto0I4
 EcgMwn7/0jyjhzrAnfJb6UYSjG7LsCx8X0bl/TM5gD5tKZ+3Ij+GjgvwP3n8s0ZmpDO6
 tpfQ==
X-Gm-Message-State: AOJu0YyJqWg135bjNO9ugfYnppW+OhnsDifcC0OArl6vzSGirfdkFv8Q
 6K/fLxXeBm7BEhjUewHVrkPFaZG0eeIo5ZJudhEgc5JoNYLuWOf+y4JASq/RMjc=
X-Google-Smtp-Source: AGHT+IH4LXzhP+hUZ6x1jzhbT0alh3h5GU9CRvLaY055EIS2cx/hzp3MeCHsDI92YYmg8dJcmxm5Ig==
X-Received: by 2002:a05:6a20:da8a:b0:19c:68da:777c with SMTP id
 iy10-20020a056a20da8a00b0019c68da777cmr166938pzb.52.1706137817866; 
 Wed, 24 Jan 2024 15:10:17 -0800 (PST)
Received: from ?IPV6:2001:44b8:2176:c800:5fcf:9e3:2e58:9c7?
 (2001-44b8-2176-c800-5fcf-09e3-2e58-09c7.static.ipv6.internode.on.net.
 [2001:44b8:2176:c800:5fcf:9e3:2e58:9c7])
 by smtp.gmail.com with ESMTPSA id
 d1-20020a056a0010c100b006dbc750ea5asm9684090pfu.196.2024.01.24.15.10.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jan 2024 15:10:17 -0800 (PST)
Message-ID: <5b1c79c7-746e-4558-8512-573084755c29@linaro.org>
Date: Thu, 25 Jan 2024 09:10:12 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] hw/arm/zynq: Check for CPU types in
 machine_run_board_init()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Rob Herring <robh@kernel.org>,
 Joel Stanley <joel@jms.id.au>, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Gavin Shan <gshan@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Igor Mammedov <imammedo@redhat.com>
References: <20240123222508.13826-1-philmd@linaro.org>
 <20240123222508.13826-7-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240123222508.13826-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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

On 1/24/24 08:25, Philippe Mathieu-Daudé wrote:
> Restrict MachineClass::valid_cpu_types[] to the single
> valid CPU type.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/arm/xilinx_zynq.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
> index 66d0de139f..6ec65d4780 100644
> --- a/hw/arm/xilinx_zynq.c
> +++ b/hw/arm/xilinx_zynq.c
> @@ -355,6 +355,10 @@ static void zynq_init(MachineState *machine)
>   
>   static void zynq_machine_class_init(ObjectClass *oc, void *data)
>   {
> +    static const char * const valid_cpu_types[] = {
> +        ARM_CPU_TYPE_NAME("cortex-a9"),
> +        NULL
> +    };
>       MachineClass *mc = MACHINE_CLASS(oc);
>       mc->desc = "Xilinx Zynq Platform Baseboard for Cortex-A9";
>       mc->init = zynq_init;
> @@ -362,6 +366,7 @@ static void zynq_machine_class_init(ObjectClass *oc, void *data)
>       mc->no_sdcard = 1;
>       mc->ignore_memory_transaction_failures = true;
>       mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a9");
> +    mc->valid_cpu_types = valid_cpu_types;

Same comment re default_cpu_type.  Otherwise,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


