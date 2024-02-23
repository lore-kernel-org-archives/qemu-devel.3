Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4B29C5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 17:44:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdZaM-000331-S3; Fri, 23 Feb 2024 12:43:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rdZPy-0001d7-W4
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 12:33:03 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rdZPw-0002ob-7G
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 12:33:02 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-41275855dc4so8710925e9.0
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 09:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708709578; x=1709314378; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=20Qy7DS735n6Lgdwx0zYJ/Et6GVH8ibQhhFZjZwNaJM=;
 b=xPR7cJZaM54laFohftSv42qm1Gc5Nslps9fnn+MFDI/nlgShCwSqi3uHlUZ5nmrZF6
 C3Jm/Raju2SA6AS8V4eValn0oGT55JaYjQwwxNrWc9+2Q0UG92tsv9+H19Zbb2IbwMg9
 23tlu91enrnoB9LB3Z1FGT3y987AQRLCXYyhWfRTCfdtqw+n0yGAykbE2B82HB6C5FC8
 7TpTH0dQNCVwIa3i/bF6blDtqvdn0PVTopew6fm0wthY3uuSwq1MoK5E/4vM1MdA7DzC
 owa/VDPlXhnrJiAT18bDFG4mzlDw02FDK4+U7i2q56HjLcG2+HWNl/UEeZ9i2PCh0zdo
 s13A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708709578; x=1709314378;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=20Qy7DS735n6Lgdwx0zYJ/Et6GVH8ibQhhFZjZwNaJM=;
 b=L4ClQA8yy3vtCVm//XOYX2208O3KjHXLNfYehemXn4pZCG5NX564aSeQo+uNXNCYQH
 QbIyuDgEvVE+Cqc7XwpNm3jjfNrjHHX3Oa20naIdi27HHnMAfhjkJLzR0romPqE5KJ+B
 u/ex3fVkVXHq4C4lp6Xu+VpDUNvl9+rHYC5npn0k/Qn1nJ2+ErckUvDskGwpWH2NhNw3
 OBWNl7QtrCP6ezTl+l9iBjIGW60J+8WKoSqa7o5IrCM8kdynHrTA6lN+LoDKO8/2bY49
 /3jnaoCCkv4ja2QQPkVLD3oQwEHa0R4rjV4mvD23qPXgr98LVi3u1BuvyzNA9qfGUQiu
 rDag==
X-Forwarded-Encrypted: i=1;
 AJvYcCVn0Y646BohKPKYori8pstB8Oi+Ay3dS0boStw4FGX3uwyGlDyZZv3gGmLwqQ6WCWJ79uGTEfM7S93pkO+Cu53qn8+x6tM=
X-Gm-Message-State: AOJu0YyoxI3pAZDmqZs3ktwtqDQreMKIrOthjlFojl+kjKigQ2BBjkaD
 X78baWtl3QATWTO80BF75b0O6OnOgaygfCcAveF12GmVqGn17wLxV/mhCF5Maz4=
X-Google-Smtp-Source: AGHT+IGR5iH9o/xiBx7Ag2qMWtTpkY5xjmW5wT6/fZNmn9JeRrjtxykV6/6jD9gmSnUc3c73HjE4OQ==
X-Received: by 2002:a05:600c:4743:b0:40f:cf69:3e1a with SMTP id
 w3-20020a05600c474300b0040fcf693e1amr301465wmo.39.1708709578390; 
 Fri, 23 Feb 2024 09:32:58 -0800 (PST)
Received: from [192.168.69.100] (xbn44-h02-176-184-35-109.dsl.sta.abo.bbox.fr.
 [176.184.35.109]) by smtp.gmail.com with ESMTPSA id
 l8-20020a5d6688000000b0033cf7eb4a85sm3440228wru.65.2024.02.23.09.32.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Feb 2024 09:32:57 -0800 (PST)
Message-ID: <8341e152-1002-4350-8f23-2ab80ed253eb@linaro.org>
Date: Fri, 23 Feb 2024 18:32:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] pseries: do not require CONFIG_USB
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu, qemu-ppc <qemu-ppc@nongnu.org>
References: <20240223124406.234509-1-pbonzini@redhat.com>
 <20240223124406.234509-8-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240223124406.234509-8-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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
>   hw/ppc/spapr.c | 7 +++----
>   hw/ppc/Kconfig | 1 +
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 0d72d286d80..44d339982da 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3024,10 +3024,9 @@ static void spapr_machine_init(MachineState *machine)
>           }
>   
>           if (has_vga) {

Pre-existing, don't we want defaults_enabled() instead of has_vga here?

> -            USBBus *usb_bus = usb_bus_find(-1);
> -
> -            usb_create_simple(usb_bus, "usb-kbd");
> -            usb_create_simple(usb_bus, "usb-mouse");
> +            Object *usb_bus = object_resolve_type_unambiguous(TYPE_USB_BUS, &error_abort);
> +            usb_create_simple(USB_BUS(usb_bus), "usb-kbd");
> +            usb_create_simple(USB_BUS(usb_bus), "usb-mouse");
>           }
>       }
>   
> diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
> index 9841c2c9690..d497fa2b825 100644
> --- a/hw/ppc/Kconfig
> +++ b/hw/ppc/Kconfig
> @@ -1,5 +1,6 @@
>   config PSERIES
>       bool
> +    imply USB_OHCI_PCI
>       imply PCI_DEVICES
>       imply TEST_DEVICES
>       imply VIRTIO_VGA

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


