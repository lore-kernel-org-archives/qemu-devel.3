Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15A94C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 10:36:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBuBX-0004H2-JW; Tue, 28 May 2024 06:36:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sBuBR-0004G7-QA
 for qemu-devel@nongnu.org; Tue, 28 May 2024 06:35:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sBuBO-0008AH-UW
 for qemu-devel@nongnu.org; Tue, 28 May 2024 06:35:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716892553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XvKscefYRc91+9tvT0/sO9ZaHfeTPf1skQR38pqQ1xY=;
 b=gR+S/BskpnjdM/SGtRGBDgVoj9eB5IaDc+6kwrqOA+M9lZz7tRCqrKmc8+9MuU8ZxvKfOB
 6MfodP32Kgk4TxuFtVXg9MqnYQIXRyUUBdVai/ZNTD8VD3FM2k8pcIwwJCmO4EOVmIZqnI
 HRim+AtqjSWU3qVbkuvA+W3XoZFxSHU=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-Jf74jar-OaWOVhu8IrK6jw-1; Tue, 28 May 2024 06:35:52 -0400
X-MC-Unique: Jf74jar-OaWOVhu8IrK6jw-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6ab9e08d5f9so64158516d6.1
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 03:35:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716892552; x=1717497352;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XvKscefYRc91+9tvT0/sO9ZaHfeTPf1skQR38pqQ1xY=;
 b=i48UcsScM7S3dqzQdPpBM87ZkIBQtBcAjkUeayg64nsVV+FW3G1KUr21Xy6fFfq4AJ
 dx13IY23wi6VqWZfoT0q9fbo4GXFIg+dYTUtsJJEOh96n1/4fnFKjsW6PeGe4CkpMa0T
 I/cXRzACrdf2rbzcQKBO0Wyk+B5WiWJI18ZINO1Sh+qN31rJeIGt1/h21AkfnHgucPzL
 B4sLQ43R9qAiZ3Z4CAQm1/lxPWSLGZmQSd7QyjR8e5woJtHfrykmjsX5JQRb1zykSeZK
 3osv20+cQPVV6fg/kBD1RTuSAKPei5hIBOZWcQpEL0W/NofFSDaAH4OeVG1FS4zQ6loK
 q5zA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpq3n5pWjcHMSBRzeuHk6jYOcC8+W/u4jf/rqHgqRxEAhYNeJiXNDYSMz2tX/UIeXRiqTHCZhbr4DAHUGyF01y0C8X6ek=
X-Gm-Message-State: AOJu0YxKLQf7D3JhY9OGvPzx1Y6zuxqFCy9ppKFgB/m2N5D2nAXF1B4i
 hlt2O+r0+LCuiOV/Hz28BVNhwAOTyRa4w/STVyDQ4aQhXa+RFQz0/wVf6GC7HrXzxlAGhnSr2V/
 R52g3drpXx123GiU0/9uuWTbohmxgj7Loe6XuWNpqMZwPaAqPKn04
X-Received: by 2002:a05:6214:4984:b0:6ab:7088:c0ce with SMTP id
 6a1803df08f44-6ab9cfbeaf8mr178667066d6.2.1716892551986; 
 Tue, 28 May 2024 03:35:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRpkQ2GqYp1+qvrsimix36gXRbX4PcxQcB9AZO/FC6uDHkQQaYsbQ9Y6xmpThn6gkSLg+Gag==
X-Received: by 2002:a05:6214:4984:b0:6ab:7088:c0ce with SMTP id
 6a1803df08f44-6ab9cfbeaf8mr178666736d6.2.1716892551511; 
 Tue, 28 May 2024 03:35:51 -0700 (PDT)
Received: from [192.168.0.4] (ip-109-43-179-186.web.vodafone.de.
 [109.43.179.186]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ac162f05d3sm43437566d6.86.2024.05.28.03.35.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 May 2024 03:35:51 -0700 (PDT)
Message-ID: <8fa84896-f534-4d2e-8b00-057514a7de03@redhat.com>
Date: Tue, 28 May 2024 12:35:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] usb/ohci-pci: deprecate, don't build by default
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20240528095459.896594-1-kraxel@redhat.com>
 <20240528095459.896594-4-kraxel@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240528095459.896594-4-kraxel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 28/05/2024 11.54, Gerd Hoffmann wrote:
> The xhci host adapter is the much better choice.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   hw/usb/hcd-ohci-pci.c | 1 +
>   hw/usb/Kconfig        | 1 -
>   2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/usb/hcd-ohci-pci.c b/hw/usb/hcd-ohci-pci.c
> index 33ed9b6f5a52..88de657def71 100644
> --- a/hw/usb/hcd-ohci-pci.c
> +++ b/hw/usb/hcd-ohci-pci.c
> @@ -143,6 +143,7 @@ static void ohci_pci_class_init(ObjectClass *klass, void *data)
>       dc->hotpluggable = false;
>       dc->vmsd = &vmstate_ohci;
>       dc->reset = usb_ohci_reset_pci;
> +    klass->deprecation_note = "use qemu-xhci instead";
>   }
>   
>   static const TypeInfo ohci_pci_info = {
> diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
> index 84bc7fbe36cd..c4a6ea5a687f 100644
> --- a/hw/usb/Kconfig
> +++ b/hw/usb/Kconfig
> @@ -17,7 +17,6 @@ config USB_OHCI_SYSBUS
>   
>   config USB_OHCI_PCI
>       bool
> -    default y if PCI_DEVICES
>       depends on PCI
>       select USB_OHCI

Not sure whether we should disable it by default just because it is 
deprecated. We don't do that for any other devices as far as I know.

Anyway, you should add the device to docs/about/deprecated.rst to really 
mark it as deprecated, since that's our official list (AFAIK).

Also, there are still some machines that use this device:

$ grep -r USB_OHCI_PCI *
hw/hppa/Kconfig:    imply USB_OHCI_PCI
hw/mips/Kconfig:    imply USB_OHCI_PCI
hw/ppc/Kconfig:    imply USB_OHCI_PCI
hw/ppc/Kconfig:    imply USB_OHCI_PCI

pseries could certainly continue without OHCI AFAICT, but the others? Maybe 
this needs some discussion first... (thus putting some more people on CC:)

  Thomas


