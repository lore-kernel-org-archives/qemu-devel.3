Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96FCFC47DDF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 14:21:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTN5F-0005FO-6t; Fri, 26 Jan 2024 09:21:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rTN5D-000593-Ru
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:21:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rTN5C-0005GJ-An
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:21:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706278885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vzWahgOJ/yQWXz7ebyRO1qrWT/XNUxSXdozBBTvnMFM=;
 b=H5+Y+XmmanhgMl+FubFQy/oxJt2v6OuhqLHKTsPwBE9NsnM1bdE81fq7YzcLE2xYsZ/x0Y
 cBwdUFsi5JvVQ+F6TMZhRvvaNJqfYYd8Ht4LpXNzeQ5dFot8tqJZiSY5/Gc1JY2u9AkQAR
 ZbZ0SG8/EdQ4LTU0jR/Y3Ne2eMXdi8k=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-mh11ikvaMN-QjM7CUuT_ww-1; Fri, 26 Jan 2024 09:21:21 -0500
X-MC-Unique: mh11ikvaMN-QjM7CUuT_ww-1
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-3bd3bdcd87fso767130b6e.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 06:21:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706278881; x=1706883681;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vzWahgOJ/yQWXz7ebyRO1qrWT/XNUxSXdozBBTvnMFM=;
 b=Rzucdthmdx5Hxxu2omGfJFYZk2ks5bOYkiPhHgW6funTSsaYh5Ui1MFaG7WgJS9d1b
 Qbcm9+FML8iBkoQWlJMiNCZ7vZujPbTOzgn+0PdH1P0gijN86NlTDW7rFZubzmxA+P3z
 4y/ayqU3KB5G3D3A032mw2iTViCNrMh9DMuicEbgkR595Lv1J74dl0E7gY3M6rLKvR43
 vCO3PVCd0Ucn4c+EP/kHkOMtngdfdVkA9rchV4E/Twa4e/a7llUdYd3NEJrOFBZoyPC3
 nh3EOeqDOS/gJYIe0GwokEYYgDEt9NzotHDA5WGPXeF0gJxofngjlaFqzaicbduOs9yy
 E9ug==
X-Gm-Message-State: AOJu0YwlxMPQqVcZAeXDSM3ajG2S7cZPFJ1ls8OV89Ck1mAuuVZtRpAe
 iwy3KUm+mEzfO8QfxxN7/Mg/v4PORPvru+nneUEUbTCCxrAx5uEUzLRREIDKfW2TQl3XdyJtUBr
 4qeRw60rb2TW+GWWdvEVqk9VeYLihOKWvPrTaAZR4tS79kO1WWrQg
X-Received: by 2002:a05:6808:1451:b0:3bd:cb43:4d5b with SMTP id
 x17-20020a056808145100b003bdcb434d5bmr1924449oiv.42.1706278881026; 
 Fri, 26 Jan 2024 06:21:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHuoZ64zCJYounwAO14cGE15nPWbT+uKwDa+h116aVrb+sj2sYq3meIFlC6b+ubGAmMgO0STQ==
X-Received: by 2002:a05:6808:1451:b0:3bd:cb43:4d5b with SMTP id
 x17-20020a056808145100b003bdcb434d5bmr1924434oiv.42.1706278880745; 
 Fri, 26 Jan 2024 06:21:20 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-176-119.web.vodafone.de.
 [109.43.176.119]) by smtp.gmail.com with ESMTPSA id
 l18-20020a05620a28d200b00783dfd725absm3457qkp.42.2024.01.26.06.21.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jan 2024 06:21:20 -0800 (PST)
Message-ID: <1386595e-e476-4398-927e-10bea407fbb4@redhat.com>
Date: Fri, 26 Jan 2024 15:21:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 19/46] hw/sparc64/sun4u: use pci_init_nic_devices()
Content-Language: en-US
To: David Woodhouse <dwmw2@infradead.org>, qemu-devel@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Wang <jasowang@redhat.com>, David Woodhouse <dwmw@amazon.co.uk>
References: <20240108204909.564514-1-dwmw2@infradead.org>
 <20240108204909.564514-20-dwmw2@infradead.org>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240108204909.564514-20-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.313,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 08/01/2024 21.26, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> The first sunhme NIC gets placed a function 1 on slot 1 of PCI bus A,
> and the rest are dynamically assigned on PCI bus B.
> 
> Previously, any PCI NIC would get the special treatment purely by
> virtue of being first in the list.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   hw/sparc64/sun4u.c | 27 ++++++++-------------------
>   1 file changed, 8 insertions(+), 19 deletions(-)
> 
> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
> index 24d53bf5fd..eda9b58a21 100644
> --- a/hw/sparc64/sun4u.c
> +++ b/hw/sparc64/sun4u.c
> @@ -639,29 +639,18 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
>   
>       memset(&macaddr, 0, sizeof(MACAddr));
>       onboard_nic = false;
> -    for (i = 0; i < nb_nics; i++) {
> -        PCIBus *bus;
> -        nd = &nd_table[i];
> -
> -        if (!nd->model || strcmp(nd->model, mc->default_nic) == 0) {
> -            if (!onboard_nic) {
> -                pci_dev = pci_new_multifunction(PCI_DEVFN(1, 1), mc->default_nic);
> -                bus = pci_busA;
> -                memcpy(&macaddr, &nd->macaddr.a, sizeof(MACAddr));
> -                onboard_nic = true;
> -            } else {
> -                pci_dev = pci_new(-1, mc->default_nic);
> -                bus = pci_busB;
> -            }
> -        } else {
> -            pci_dev = pci_new(-1, nd->model);
> -            bus = pci_busB;
> -        }
>   
> +    nd = qemu_find_nic_info(mc->default_nic, true, NULL);
> +    if (nd) {
> +        pci_dev = pci_new_multifunction(PCI_DEVFN(1, 1), mc->default_nic);
>           dev = &pci_dev->qdev;
>           qdev_set_nic_properties(dev, nd);
> -        pci_realize_and_unref(pci_dev, bus, &error_fatal);
> +        pci_realize_and_unref(pci_dev, pci_busA, &error_fatal);
> +
> +        memcpy(&macaddr, &nd->macaddr.a, sizeof(MACAddr));
> +        onboard_nic = true;
>       }
> +    pci_init_nic_devices(pci_busB, mc->default_nic);
>   
>       /* If we don't have an onboard NIC, grab a default MAC address so that
>        * we have a valid machine id */

Reviewed-by: Thomas Huth <thuth@redhat.com>


