Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1280C5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 17:36:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdZTB-0007cU-4o; Fri, 23 Feb 2024 12:36:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rdZD3-000385-Hr
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 12:19:41 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rdZCy-00007f-7f
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 12:19:41 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a3f4464c48dso134625966b.3
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 09:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708708774; x=1709313574; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Zig0T/UqVIwC26pFGSRHo5sx0ZUq18HJeUpRJAO0l1o=;
 b=sHrIgzwaZ8TjVED0lapRLTO1jExzzQya+1a5xDjDbVfbuDy5KsGU1spw+dWkirDcJC
 yyLKaEHQtgKGr75Al2vxLqHmdDsQ6QPbq17W3YjwpLhyLMu35FQ1cj8WG9oTO6fTXrDo
 5lw89sP0IN/Ic6/Vzvxui8YfQThuDPGCC4GHBwezWUqlCER2qalYomJJWs2f4THgGYZ0
 mQ46T7K//UdzkHTdIZRGgopdEnR3qD9wBSusI4MYqsRPYPjKiNbhdcqHzfFnPiOFv1rk
 MKR8GWuFceLkNUqQKx4Xcly5v8QpSpJO2n9Kr5Z37+42xKpBQOLU+UpEfELCHMRjkIA2
 h3iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708708774; x=1709313574;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Zig0T/UqVIwC26pFGSRHo5sx0ZUq18HJeUpRJAO0l1o=;
 b=tl9B660qMvsbLZYUesEKKtxIcMWGI2QMbP85TYdp/pMjq9g3LOpVV5Gsh4bRSqWw/n
 wO5Vr2qBV7+XTMOjvjdR0RPPYjENjaFBHvNtvQNfWJpEalSjrYy19mpyP4bIgkBiw4uC
 YzeK6UHJuO/z0ANUrIuMkqI8+vPZOvPrSInV87KgS1gxWBV/DDfuyVbWIe7EOqJi3Mo5
 hDjHlWJJRaqbr/pShATe9KPwqE59m8VpCBriwGaXR77N8ODP/5NhLJGxAcybwAnAz7ZX
 /PIBhPfu3FqlbFMyraDXERCWlvsMYRB93qE3q77+4CJNBPqCMrvNcdHn5/AHLUhGxfbw
 L1jQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9joK5uwgouQf/lQA2i5nETFvoa2TWDQTuxGv13JufFue/ZGYTh3FoBNg/SM+C8hncntZsNmqqnUWzQaz6oAzR5zqU3gI=
X-Gm-Message-State: AOJu0Yxy69J1cbZEImjLmWUfaCQz9HC7HAgfYcLpK68H56Kv+xETbZEu
 n8qOxm2pCaR77stUWLbvZ3AwQGTSJPBwWlBsplMkhg0Fdc519cPDFAtVFE5ezxM=
X-Google-Smtp-Source: AGHT+IHIXMGw/61BuXRD7B/iNG8mZ2kuer6TDMI0Cro44hdNW9qI7AKStclBWpCNi9UlUBOYbmlx6w==
X-Received: by 2002:a17:906:260d:b0:a3e:d2ea:ff5e with SMTP id
 h13-20020a170906260d00b00a3ed2eaff5emr327606ejc.58.1708708774157; 
 Fri, 23 Feb 2024 09:19:34 -0800 (PST)
Received: from [192.168.69.100] (xbn44-h02-176-184-35-109.dsl.sta.abo.bbox.fr.
 [176.184.35.109]) by smtp.gmail.com with ESMTPSA id
 vh9-20020a170907d38900b00a3f1ea776a1sm3101721ejc.94.2024.02.23.09.19.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Feb 2024 09:19:32 -0800 (PST)
Message-ID: <7b5502aa-f9fa-4d5e-8e98-15d846f41df1@linaro.org>
Date: Fri, 23 Feb 2024 18:19:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] hppa: do not require CONFIG_USB
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu, Thomas Huth <thuth@redhat.com>
References: <20240223124406.234509-1-pbonzini@redhat.com>
 <20240223124406.234509-6-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240223124406.234509-6-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
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

On 23/2/24 13:44, Paolo Bonzini wrote:
> With --without-default-devices it is possible to build a binary that
> does not include any USB host controller and therefore that does not
> include the code guarded by CONFIG_USB.  While the simpler creation
> functions such as usb_create_simple can be inlined, this is not true
> of usb_bus_find().  Remove it, replacing it with a search of the single
> USB bus on the machine.
> 
> Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   hw/hppa/machine.c | 7 ++++---
>   hw/hppa/Kconfig   | 2 +-
>   2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
> index 5fcaf5884be..11982d5776c 100644
> --- a/hw/hppa/machine.c
> +++ b/hw/hppa/machine.c
> @@ -396,10 +396,11 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
>       }
>   
>       /* create USB OHCI controller for USB keyboard & mouse on Astro machines */
> -    if (!lasi_dev && machine->enable_graphics) {
> +    if (!lasi_dev && machine->enable_graphics && defaults_enabled()) {
>           pci_create_simple(pci_bus, -1, "pci-ohci");
> -        usb_create_simple(usb_bus_find(-1), "usb-kbd");
> -        usb_create_simple(usb_bus_find(-1), "usb-mouse");
> +        Object *usb_bus = object_resolve_type_unambiguous(TYPE_USB_BUS, &error_abort);

Declare variable at begin of function; can be casted to USB_BUS once.
Otherwise:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +        usb_create_simple(USB_BUS(usb_bus), "usb-kbd");
> +        usb_create_simple(USB_BUS(usb_bus), "usb-mouse");
>       }


