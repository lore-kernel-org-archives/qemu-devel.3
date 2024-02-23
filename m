Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59A5CC5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 20:18:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdc01-0005mM-Jz; Fri, 23 Feb 2024 15:18:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rdb9O-0004jU-NE
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 14:24:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rdb9M-0000la-Ku
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 14:24:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708716239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=FI6NALMnRssrxJhK1u6w8pb11/25tCigeIRjQOikSCA=;
 b=Kq7bdZe+t+RyphjAah4IWnqBUJzH5tViEiAI9di6lkmeWOC8MEB52HOG0o1rE0sneopfAV
 cH/2Rj297OBCKmirJbaQfQjuFkq0TvrOBi3Yergs+9eh6bcfpVFKfq96ORe7s1rLlYnFYm
 uIEGYtInafJt3TLFB1V2IPK2d+bw92U=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-fqvT_g3AOz-Exdi7eFafAg-1; Fri, 23 Feb 2024 14:23:57 -0500
X-MC-Unique: fqvT_g3AOz-Exdi7eFafAg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4128defb707so6058425e9.0
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 11:23:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708716236; x=1709321036;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FI6NALMnRssrxJhK1u6w8pb11/25tCigeIRjQOikSCA=;
 b=F15nx4Ip5A37YePD2Xsj9K6xeKxVfpqCq7MZfUrPh+k1BZJ2Vy207/+TB7zwYV9N2L
 ZqDsbIczo9p/+qyxq2dO4t6tfZrxDfRUUhVZmGGAg9LD3nlxd4X5Jb1uL0mhgjNU9qmN
 8GALjNqEpXvCtXw5hvOliU1QQsqO8GqcNFvwmqvmsj+3Bu0NIK4xj2TbTHfVWw05CdF1
 7BiqBsPFtyI/1850tu2LAtYKFDadzUwPjDWHCb8irzeLD9ZTRCpAz9y7E2skSQFDxXLy
 ubO5pp2w7s0gPJPHdpuSFxeVYw7u6SbjMfeEdo5UyMQZiYD/dgiHAfS0x8GBQyrdupNe
 JSzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWiSeTBEt2V8mrq3R1MAv0+35JzAEQy0QyULbyBPVouCNSI3FfdnINOq1KW6Z68w1dLqTDyPch9N8FeManWBUC6dVk3iw=
X-Gm-Message-State: AOJu0YzVJd+sQPF88WUcvXAyZ5V3ld21zue8GSdtetgsHRNteeTfrjNX
 /eTY+cgLeRE/Who+LS5trCSYUhwvUZ+uxOVJD95aw0ZN2olzHz53kBscqxui7H9rS1RHqzCXv75
 NvU7NhyRrFxRm7KJ6e0IqdptOePuaNk07g/IbuprGZ3JZW8vnnw/s
X-Received: by 2002:a05:600c:46d0:b0:412:5fbe:3740 with SMTP id
 q16-20020a05600c46d000b004125fbe3740mr470424wmo.24.1708716236796; 
 Fri, 23 Feb 2024 11:23:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJzI9ucWUCK6qgWxloeDwwgIxwDgxlkEeLOGwQSEdyORyWzD70L6dPRpbxycamRdW7M13KjA==
X-Received: by 2002:a05:600c:46d0:b0:412:5fbe:3740 with SMTP id
 q16-20020a05600c46d000b004125fbe3740mr470415wmo.24.1708716236460; 
 Fri, 23 Feb 2024 11:23:56 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-176-215.web.vodafone.de.
 [109.43.176.215]) by smtp.gmail.com with ESMTPSA id
 ba14-20020a0560001c0e00b0033da66e7bedsm3564604wrb.66.2024.02.23.11.23.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Feb 2024 11:23:55 -0800 (PST)
Message-ID: <50972788-77b0-4494-b956-367e227575b6@redhat.com>
Date: Fri, 23 Feb 2024 20:23:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] hppa: do not require CONFIG_USB
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, balaton@eik.bme.hu
References: <20240223124406.234509-1-pbonzini@redhat.com>
 <20240223124406.234509-6-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240223124406.234509-6-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.066,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 23/02/2024 13.44, Paolo Bonzini wrote:
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

Do we need the defaults_enabled() here? Isn't enable_graphics already 
disabled if defaults_enabled() is not set?

  Thomas


>           pci_create_simple(pci_bus, -1, "pci-ohci");
> -        usb_create_simple(usb_bus_find(-1), "usb-kbd");
> -        usb_create_simple(usb_bus_find(-1), "usb-mouse");
> +        Object *usb_bus = object_resolve_type_unambiguous(TYPE_USB_BUS, &error_abort);
> +        usb_create_simple(USB_BUS(usb_bus), "usb-kbd");
> +        usb_create_simple(USB_BUS(usb_bus), "usb-mouse");
>       }



