Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24B48C54E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 17:36:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdZSU-0005dm-H7; Fri, 23 Feb 2024 12:35:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rdZ4W-0007o8-Sv
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 12:10:52 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rdZ4K-00072n-QY
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 12:10:52 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-33d9d43a1eeso763002f8f.2
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 09:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708708238; x=1709313038; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZZBqh+z1qni28alYcEVsiCYGytkpGpY7x9bD6vf7S3M=;
 b=CLzqlQhiUEwwfZsw5MIAM8Bshzv7cSM8aG8qzsQ9gvML0/vhmcgUT1TbJsTo/txfco
 QvE7u5irnm5Nb7AFGdjjZbaqnSeqpxwe9mgMI0wVxo0hEIh8TKC2SLey44W/HYxY1CCd
 GHGN+BTvzlzWmKnGHuVk7p3wg5GcBISlWWDPtlo25wK4797oCMjUigiOJP6FoimC+bSg
 keKkMKoSdSrIfqpX0tlfmixAHc4sv280jDJygvApTlG2n1l2UhMZBGgoF16KVqAXhvnm
 BKlBJ2MRiKmVFz4pKbvbWqU2P50Y1kf2rNSG6ih182ruda3elskdJpvGAumuSobJBPYt
 5TDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708708238; x=1709313038;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZZBqh+z1qni28alYcEVsiCYGytkpGpY7x9bD6vf7S3M=;
 b=hXQ0zYtIds4yK6rhyzT0LWUHmL2SCSi47jsvmY3r2LRfoQis+GdMlwDw3ucWUo3U0/
 chvpPZ0aj0wGQy52H84ZxRorHye1E2tGBHwkNOCRhhD7XmZQ6+9jX3gmAZBfdRC7MaEx
 phv0D0IsiUL7GPfteAMaog+138eamjeJxtTwL7Ul/CWofogxWb8ViH4X3IFWSfhin3ml
 rnNh53G9TidhIbol6VMLdc63Q0j7gwDoD4BKNJRjiVM1IKei0jFSAgKh/svukcLSra7A
 9SMSNX7QADZE/sBRDxlxiHyLags2SCtOoebvDmSvantqjTFKQY1LVaXvm7FpxiUwoQdq
 4NKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrvS8okyNTjRi01FUbNhMz2AFUh5nBw6ns6e8PqeF7FIU16+ZMnIupaObjPcYhJOY2/pFCc7qpSm9xS987RvtM5Em9Rzk=
X-Gm-Message-State: AOJu0YwZoeniGpEPEafNY6EL4AHX+hD6fusKazNNYfwxtonk0j29tpPP
 1zAieUeALlUFzdzFmkoyCEgQIn34JFYMkmM/Z7DjTZ73f7hq/FUid2KajWPd4K4=
X-Google-Smtp-Source: AGHT+IElIOXXb8Z1DYgNSUKxXrPpAr3dsvlHsTR0PIiufECS/rv04J5SBx1NkbHvHw7pSGzvg5jW4A==
X-Received: by 2002:adf:e4c1:0:b0:33d:1ad9:a20c with SMTP id
 v1-20020adfe4c1000000b0033d1ad9a20cmr225455wrm.28.1708708238279; 
 Fri, 23 Feb 2024 09:10:38 -0800 (PST)
Received: from [192.168.69.100] (xbn44-h02-176-184-35-109.dsl.sta.abo.bbox.fr.
 [176.184.35.109]) by smtp.gmail.com with ESMTPSA id
 co18-20020a0560000a1200b0033b684d6d5csm4152122wrb.20.2024.02.23.09.10.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Feb 2024 09:10:37 -0800 (PST)
Message-ID: <2fcf3eea-38b7-4d3a-82cf-048d12176f90@linaro.org>
Date: Fri, 23 Feb 2024 18:10:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] usb: extract sysbus-ohci to a separate file
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu
References: <20240223124406.234509-1-pbonzini@redhat.com>
 <20240223124406.234509-10-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240223124406.234509-10-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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
> Split the sysbus version to a separate file so that it is not
> included in PCI-only machines, and adjust Kconfig for machines
> that do need sysbus-ohci.  The copyrights are based on the
> time and employer of balrog and Paul Brook's contributions.
> 
> While adjusting the SM501 dependency, move it to the right place
> instead of keeping it in the R4D machine.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   hw/usb/hcd-ohci-sysbus.c | 91 ++++++++++++++++++++++++++++++++++++++++
>   hw/usb/hcd-ohci.c        | 58 ------------------------
>   hw/arm/Kconfig           | 12 +++--
>   hw/display/Kconfig       |  1 +
>   hw/ppc/Kconfig           |  2 +-
>   hw/sh4/Kconfig           |  1 -
>   hw/usb/Kconfig           |  4 ++
>   hw/usb/meson.build       |  1 +
>   8 files changed, 105 insertions(+), 65 deletions(-)
>   create mode 100644 hw/usb/hcd-ohci-sysbus.c


> +static void ohci_realize_pxa(DeviceState *dev, Error **errp)

s/ohci_realize_pxa/ohci_sysbus_realize/

> +{
> +    OHCISysBusState *s = SYSBUS_OHCI(dev);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> +    Error *err = NULL;
> +
> +    usb_ohci_init(&s->ohci, dev, s->num_ports, s->dma_offset,
> +                  s->masterbus, s->firstport,
> +                  &address_space_memory, ohci_sysbus_die, &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +    sysbus_init_irq(sbd, &s->ohci.irq);
> +    sysbus_init_mmio(sbd, &s->ohci.mem);
> +}
> +
> +static void usb_ohci_reset_sysbus(DeviceState *dev)

s/usb_ohci_reset_sysbus/ohci_sysbus/reset/.

To be converted to Resettable API.

> +{
> +    OHCISysBusState *s = SYSBUS_OHCI(dev);
> +    OHCIState *ohci = &s->ohci;
> +
> +    ohci_hard_reset(ohci);
> +}


> +static void ohci_register_types(void)
> +{
> +    type_register_static(&ohci_sysbus_info);
> +}
> +
> +type_init(ohci_register_types)

Better directly use DEFINE_TYPES() in new uses, even for
a single type.


> diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
> index 0f486764ed6..f569ed7eeaa 100644
> --- a/hw/usb/Kconfig
> +++ b/hw/usb/Kconfig
> @@ -11,6 +11,10 @@ config USB_OHCI
>       bool
>       select USB
>   
> +config USB_OHCI_SYSBUS
> +    bool
> +    select USB_OHCI

I start to think USB_OHCI_MMIO would be clearer. I can
clean that up later, so:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>   config USB_OHCI_PCI
>       bool
>       default y if PCI_DEVICES

