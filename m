Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE1D7C48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 07:56:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raWb4-0006Vs-WB; Thu, 15 Feb 2024 02:55:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1raWb3-0006Vc-LF
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 02:55:53 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1raWb2-0005i1-4m
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 02:55:53 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4121b1aad00so1317275e9.1
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 23:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707983749; x=1708588549; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bsDEKjTridWalYMepfct1/C1l2Q8aMDTysDtOMui0Os=;
 b=D+1VFAaYbiLcatojm4zmt6dgGKKbAGZnbr5cE9fpZc2p47+FvAiHBmLADWYG867gS8
 gYdYYKLOU6nzJ7bWJgFbfvLYelzepo7mnw/N/opuKN1lw8D1ELMcNL3ikhQumUBw27ff
 NlOoM9LuQknJR9N4N9+sL7v7Wu6PwQQ08YgotZX9LA27uSvlj1rvtT/bPHkY4xsqZHay
 tQH1SWOCieLntVDVY9hcweImOfQXRY3sq7vK7rjkq6QPKe6DF64Lh63HFieJP/BxCoXR
 pIHe6UguxlDopYFzdqSC6HSKIvH34PxgtgwCzKfRGB7jcdagL1qSxzOErSNf75xCf/2l
 kXdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707983749; x=1708588549;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bsDEKjTridWalYMepfct1/C1l2Q8aMDTysDtOMui0Os=;
 b=QdOT4Mt1d9G3SbbnhZe31rzoaJg+CqZaE2sQab8i5v/KXyt9TrfN+K2FNE9HuASuNL
 chElhpfguDCq4p81eBBIQXVdatNGIqDN968TQnKmDemNadbFVc6iXE6JAynApD2cxSLG
 g8rK5quJeXB3C4D9VRe6Ptk1IFPBaD3K5olMjVqh1LvvZNr1Oe1eAeEKgXfHbYdhSvv3
 513h8UCQ6aOFV7H3E/kl2NoS+PCmKnpifPcuU1K+L+ApEc49nLSUW2I+DrXrypE4MIcp
 2VDH6d6u9l3iScTiGhyk/eycYUH1ISQr/vmMj+Su5LdUWJpOoP5uAqZz4xwPaxzfPzvv
 IOnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWN2O7eEta3q4YXrpjnN/D6+6WkCQfTqnEeNivZ56AtrSBDIt0W8O4w8lC+rXvDkiObqZwi/Ax9jYE1TVnZA7G/wLZi1ks=
X-Gm-Message-State: AOJu0YyuUV5BBL7ly0haIZtE9IvzAKZpRXj3rDLWzkF6vQ68qig4WllT
 MGTPC9Go9RrQvE5mpDJJ68f/5BUZyB4EBQ2NVwBNPUTXCmbrUfMcDhauQe4Y7ts=
X-Google-Smtp-Source: AGHT+IFd0EdrPyO6T8IJa9gee6hjRfTOuTH6uxU0isS/8bhI3IOf4x7FaihVW0sct8Cj9CkXHICcPw==
X-Received: by 2002:a05:600c:1553:b0:40e:fc29:f527 with SMTP id
 f19-20020a05600c155300b0040efc29f527mr791527wmg.31.1707983748987; 
 Wed, 14 Feb 2024 23:55:48 -0800 (PST)
Received: from [192.168.124.175] (14.red-88-28-17.dynamicip.rima-tde.net.
 [88.28.17.14]) by smtp.gmail.com with ESMTPSA id
 g11-20020adff3cb000000b0033b1c321070sm932014wrp.31.2024.02.14.23.55.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Feb 2024 23:55:48 -0800 (PST)
Message-ID: <47a999a8-a0e0-4995-8f8c-8d18f564c30b@linaro.org>
Date: Thu, 15 Feb 2024 08:55:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/9] mips/loongson3_virt: do not require CONFIG_USB
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: shentey@gmail.com, balaton@eik.bme.hu
References: <20240213155005.109954-1-pbonzini@redhat.com>
 <20240213155005.109954-9-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240213155005.109954-9-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 13/2/24 16:50, Paolo Bonzini wrote:
> Once the Kconfig for hw/mips is cleaned up, it will be possible to build a
> binary that does not include any USB host controller and therefore that
> does not include the code guarded by CONFIG_USB.  While the simpler
> creation functions such as usb_create_simple can be inlined, this is not
> true of usb_bus_find().  Remove it, replacing it with a search of the
> single USB bus created by loongson3_virt_devices_init().
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   hw/mips/loongson3_virt.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
> index caedde2df00..bedd3d496bd 100644
> --- a/hw/mips/loongson3_virt.c
> +++ b/hw/mips/loongson3_virt.c
> @@ -447,8 +447,9 @@ static inline void loongson3_virt_devices_init(MachineState *machine,
>   
>       if (defaults_enabled() && object_class_by_name("pci-ohci")) {
>           pci_create_simple(pci_bus, -1, "pci-ohci");
> -        usb_create_simple(usb_bus_find(-1), "usb-kbd");
> -        usb_create_simple(usb_bus_find(-1), "usb-tablet");
> +        Object *usb_bus = object_resolve_path_type("", TYPE_USB_BUS, NULL);
> +        usb_create_simple(USB_BUS(usb_bus), "usb-kbd");
> +        usb_create_simple(USB_BUS(usb_bus), "usb-tablet");
>       }
>   
>       pci_init_nic_devices(pci_bus, mc->default_nic);

Can we remove usb_bus_find() completely instead?

$ git grep -w usb_bus_find
hw/hppa/machine.c:401:        usb_create_simple(usb_bus_find(-1), 
"usb-kbd");
hw/hppa/machine.c:402:        usb_create_simple(usb_bus_find(-1), 
"usb-mouse");
hw/mips/loongson3_virt.c:450:        usb_create_simple(usb_bus_find(-1), 
"usb-kbd");
hw/mips/loongson3_virt.c:451:        usb_create_simple(usb_bus_find(-1), 
"usb-tablet");
hw/ppc/mac_newworld.c:434:            USBBus *usb_bus = usb_bus_find(-1);
hw/ppc/sam460ex.c:423:    usb_create_simple(usb_bus_find(-1), "usb-kbd");
hw/ppc/sam460ex.c:424:    usb_create_simple(usb_bus_find(-1), "usb-mouse");
hw/ppc/spapr.c:3027:            USBBus *usb_bus = usb_bus_find(-1);
hw/sh4/r2d.c:315:    usb_create_simple(usb_bus_find(-1), "usb-kbd");
hw/usb/bus.c:103:USBBus *usb_bus_find(int busnr)
hw/usb/bus.c:669:    USBBus *bus = usb_bus_find(-1 /* any */);
include/hw/usb.h:500:USBBus *usb_bus_find(int busnr);


