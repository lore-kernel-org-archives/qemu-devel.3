Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0269C47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 14:07:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTMqt-0004RP-L9; Fri, 26 Jan 2024 09:06:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rTMqZ-0004My-7r
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:06:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rTMqW-00082w-1d
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:06:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706277974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=fhEflVQmOH8ynwYJQAVG5NGPUljFKsIx9aOfzBw9VDo=;
 b=b1s4ir9OIgQmzr78NFl22/dMuqKBmJcHpy285GyjF5ADAC4pEvl7LZ9yDC/zMKcUBARV0g
 qgxwYTkVTbTt3C6XxrupvsYXQept9dskzvOsRKU25ySctCOYQSfKQRwifB9msrlKxcdyRP
 3VaScyC2Ku60oxKjU7qkDyE/hJFks20=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-X5lYpgUcN_mB45XqSQNS4A-1; Fri, 26 Jan 2024 09:06:13 -0500
X-MC-Unique: X5lYpgUcN_mB45XqSQNS4A-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7816e45f957so66556485a.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 06:06:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706277972; x=1706882772;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fhEflVQmOH8ynwYJQAVG5NGPUljFKsIx9aOfzBw9VDo=;
 b=VzKzNPaboGOkYP7MFER5fNtsn6trVhK45XrUlAExI/xPkE6qPJlHa+Kw5czjkmnJsi
 wWpDpn9NZnxTZcsnTCC7U2QEj7sX/2Wvh04UCrUPXtidrDXbt6CYX4KHXVFDrPT057Lv
 unanHnpXGoTU36XYQnfkcrWesTiVvY95EOx/sQNhDWl4EXCChgd6U45hja/Gm/c+2XOl
 IKBxnp+YTnKT/tWjcd9dw6JdE7gM3n7sWd1X8HYPmplxK4EK75lPMepz9j5Wd/SgDOWa
 nUbuPAjnPPIKx1HzL2SB0pSU/gFMFfQ1U9LgJ8Pqnx6w2gOBWFEXn9GUNWZi87y895bB
 LztQ==
X-Gm-Message-State: AOJu0Yw+LKtfitre7bmz/Jl6GyHeOGcG043VejUhoTejX8k0OjSJxiT1
 4jr4pCXSY0nVoe10Es2oQDWJoKE+Ub3azjENFux5J6GA92YyUroh0K4qqECfKJjz6tbrlsX80yG
 vlpKfjrrXBojRR52bTUQvuPNq2YAz6EDBNrrznu/SZzc2r76eugKI
X-Received: by 2002:ae9:c109:0:b0:781:3a8a:8eca with SMTP id
 z9-20020ae9c109000000b007813a8a8ecamr1746300qki.46.1706277972681; 
 Fri, 26 Jan 2024 06:06:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHc9nX2exl0HPnj4a/3igGvf2iYuX57KLmTmzRmj7AxnnovKkNj1C/dJ9R9KG4F0pHgZoNhoQ==
X-Received: by 2002:ae9:c109:0:b0:781:3a8a:8eca with SMTP id
 z9-20020ae9c109000000b007813a8a8ecamr1746287qki.46.1706277972386; 
 Fri, 26 Jan 2024 06:06:12 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-176-119.web.vodafone.de.
 [109.43.176.119]) by smtp.gmail.com with ESMTPSA id
 l7-20020a05620a0c0700b007832a7c7fcbsm597399qki.108.2024.01.26.06.06.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jan 2024 06:06:12 -0800 (PST)
Message-ID: <02a0dd0d-b0ed-460f-9fe2-33c840dfcd3b@redhat.com>
Date: Fri, 26 Jan 2024 15:06:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/46] hw/ppc/prep: use pci_init_nic_devices()
Content-Language: en-US
To: David Woodhouse <dwmw2@infradead.org>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>
Cc: qemu-ppc@nongnu.org
References: <20240108204909.564514-1-dwmw2@infradead.org>
 <20240108204909.564514-16-dwmw2@infradead.org>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240108204909.564514-16-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.313,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 08/01/2024 21.26, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> Previously, the first PCI NIC would be placed in PCI slot 3 and the rest
> would be dynamically assigned. Even if the user overrode the default NIC
> type and made it something other than PCNet.
> 
> Now, the first PCNet NIC (that is, anything not explicitly specified
> to be anything different) will go to slot 3 even if it isn't the first
> NIC specified on the commnd line. And anything else will be dynamically
> assigned.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   hw/ppc/prep.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
> index 137276bcb9..1a6cd05c61 100644
> --- a/hw/ppc/prep.c
> +++ b/hw/ppc/prep.c
> @@ -241,7 +241,6 @@ static void ibm_40p_init(MachineState *machine)
>       ISADevice *isa_dev;
>       ISABus *isa_bus;
>       void *fw_cfg;
> -    int i;
>       uint32_t kernel_base = 0, initrd_base = 0;
>       long kernel_size = 0, initrd_size = 0;
>       char boot_device;
> @@ -336,10 +335,9 @@ static void ibm_40p_init(MachineState *machine)
>           /* XXX: s3-trio at PCI_DEVFN(2, 0) */
>           pci_vga_init(pci_bus);
>   
> -        for (i = 0; i < nb_nics; i++) {
> -            pci_nic_init_nofail(&nd_table[i], pci_bus, mc->default_nic,
> -                                i == 0 ? "3" : NULL);
> -        }
> +        /* First PCNET device at PCI_DEVFN(3, 0) */
> +        pci_init_nic_in_slot(pci_bus, mc->default_nic, NULL, "3");
> +        pci_init_nic_devices(pci_bus, mc->default_nic);
>       }
>   
>       /* Prepare firmware configuration for OpenBIOS */

Fine for me ... Hervé, could you maybe comment from a 40p point of view, too?

Reviewed-by: Thomas Huth <thuth@redhat.com>


