Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46C7BC47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 14:15:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTMyw-0001CD-Kp; Fri, 26 Jan 2024 09:14:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rTMyu-0001Ba-II
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:14:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rTMyp-0001Px-4j
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:14:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706278490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wf6pprME8qyXJwFw/8frPz2Btvjyh5bgiQx2mhvizNU=;
 b=Msxp6B0waBmti4mk3XNOB7/hLZnfJ2TJfwmgDod9SQg3NC8jnph/6nsLjopxSy+Cg+qvT2
 xohD5IbbPj5J9FteXDDxV5nGsamJrd0iRSZVTxzQbwq3Hd5X+xS5jpFzLd2gtsVhEXA3Kg
 Le55wywF08xXuDiABCJm4+L9mdTjrmo=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-lRLCzOSGNjqmIreVHvb_Fg-1; Fri, 26 Jan 2024 09:14:48 -0500
X-MC-Unique: lRLCzOSGNjqmIreVHvb_Fg-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6800a9505ddso6472756d6.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 06:14:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706278488; x=1706883288;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wf6pprME8qyXJwFw/8frPz2Btvjyh5bgiQx2mhvizNU=;
 b=wDPo0WmDcxhKutE+eooXqQnyTVxrh0cQ1LlTMbq2JloAKW2IBbrv9GLA7a/QNO4cfb
 oTn68EIMkTzNJ69RrZPE2adxHAv0+ZLPFTGejwxkUf5faye656nCauYHwVCQJAHy3eKl
 Kg82K5pDAOrwhyuGv8b2eTQ/PHEhaUPeR8FUITVJm1X0yynz7Oc3nrAgrM9l75qoIM83
 fnogF3ganeiZidE+j0gVBZcRDwfkuvD4qtl+3LQetHs8c36ryPYwj7dwdESRbVGY8zCL
 EBaLAfDG0fSgSCTFQxu4mM57MAnrNv1/jVcBj1LzTpRxzFKueabkp20AwOjYJ8nMBOIN
 CERA==
X-Gm-Message-State: AOJu0YwCSN5TrHQrMmFDTHSstQPjwuOAg58OQ8QAI5fZy6Pq+7f0U3HW
 Cu3LdgnG2CI+o3zb+v2aHfAMMiZ0ssbprVB9xarfUtKzu5dz779Q3eObPHvpX4Fv+xoOhu1T9Jg
 unyD1fKoQf8DH/5V/1la0xoTgF8T/MWLqekkp/R5I3ZwoN12rnr/B
X-Received: by 2002:a05:6214:5085:b0:686:949b:6b11 with SMTP id
 kk5-20020a056214508500b00686949b6b11mr1398316qvb.22.1706278488405; 
 Fri, 26 Jan 2024 06:14:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHBeY0hg2RH/A9hOq0rtuvOALNCfhEzLGchoEG2DdBulBz3C82YuN3QG8J8pF8EsrWBohVAFw==
X-Received: by 2002:a05:6214:5085:b0:686:949b:6b11 with SMTP id
 kk5-20020a056214508500b00686949b6b11mr1398301qvb.22.1706278488157; 
 Fri, 26 Jan 2024 06:14:48 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-176-119.web.vodafone.de.
 [109.43.176.119]) by smtp.gmail.com with ESMTPSA id
 f18-20020a0ccc92000000b0068690f98949sm531729qvl.117.2024.01.26.06.14.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jan 2024 06:14:47 -0800 (PST)
Message-ID: <abc72ab7-3c7f-4ffa-9543-8b0cbdf27402@redhat.com>
Date: Fri, 26 Jan 2024 15:14:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 17/46] hw/ppc: use pci_init_nic_devices()
Content-Language: en-US
To: David Woodhouse <dwmw2@infradead.org>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Jason Wang <jasowang@redhat.com>, Stafford Horne <shorne@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 David Woodhouse <dwmw@amazon.co.uk>
References: <20240108204909.564514-1-dwmw2@infradead.org>
 <20240108204909.564514-18-dwmw2@infradead.org>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240108204909.564514-18-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.313,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   hw/ppc/e500.c          |  4 +---
>   hw/ppc/mac_newworld.c  |  4 +---
>   hw/ppc/mac_oldworld.c  |  4 +---
>   hw/ppc/ppc440_bamboo.c | 14 +++++---------
>   4 files changed, 8 insertions(+), 18 deletions(-)
> 
> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
> index 566f1200dd..3bd12b54ab 100644
> --- a/hw/ppc/e500.c
> +++ b/hw/ppc/e500.c
> @@ -1079,9 +1079,7 @@ void ppce500_init(MachineState *machine)
>   
>       if (pci_bus) {
>           /* Register network interfaces. */
> -        for (i = 0; i < nb_nics; i++) {
> -            pci_nic_init_nofail(&nd_table[i], pci_bus, mc->default_nic, NULL);
> -        }
> +        pci_init_nic_devices(pci_bus, mc->default_nic);
>       }
>   
>       /* Register spinning region */
> diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
> index 535710314a..b36dbaf2b6 100644
> --- a/hw/ppc/mac_newworld.c
> +++ b/hw/ppc/mac_newworld.c
> @@ -444,9 +444,7 @@ static void ppc_core99_init(MachineState *machine)
>           graphic_depth = 15;
>       }
>   
> -    for (i = 0; i < nb_nics; i++) {
> -        pci_nic_init_nofail(&nd_table[i], pci_bus, mc->default_nic, NULL);
> -    }
> +    pci_init_nic_devices(pci_bus, mc->default_nic);
>   
>       /* The NewWorld NVRAM is not located in the MacIO device */
>       if (kvm_enabled() && qemu_real_host_page_size() > 4096) {
> diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
> index 9acc7adfc9..1981d3d8f6 100644
> --- a/hw/ppc/mac_oldworld.c
> +++ b/hw/ppc/mac_oldworld.c
> @@ -277,9 +277,7 @@ static void ppc_heathrow_init(MachineState *machine)
>   
>       pci_vga_init(pci_bus);
>   
> -    for (i = 0; i < nb_nics; i++) {
> -        pci_nic_init_nofail(&nd_table[i], pci_bus, mc->default_nic, NULL);
> -    }
> +    pci_init_nic_devices(pci_bus, mc->default_nic);
>   
>       /* MacIO IDE */
>       ide_drive_get(hd, ARRAY_SIZE(hd));
> diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
> index a189942de4..c75c3083e6 100644
> --- a/hw/ppc/ppc440_bamboo.c
> +++ b/hw/ppc/ppc440_bamboo.c
> @@ -161,7 +161,6 @@ static void bamboo_init(MachineState *machine)
>       DeviceState *uicdev;
>       SysBusDevice *uicsbd;
>       int success;
> -    int i;
>   
>       if (kvm_enabled()) {
>           error_report("machine %s does not support the KVM accelerator",
> @@ -234,14 +233,11 @@ static void bamboo_init(MachineState *machine)
>       }
>   
>       if (pcibus) {
> -        /* Register network interfaces. */
> -        for (i = 0; i < nb_nics; i++) {
> -            /*
> -             * There are no PCI NICs on the Bamboo board, but there are
> -             * PCI slots, so we can pick whatever default model we want.
> -             */
> -            pci_nic_init_nofail(&nd_table[i], pcibus, mc->default_nic, NULL);
> -        }
> +        /*
> +         * There are no PCI NICs on the Bamboo board, but there are
> +         * PCI slots, so we can pick whatever default model we want.
> +         */
> +        pci_init_nic_devices(pcibus, mc->default_nic);
>       }
>   
>       /* Load kernel. */

Reviewed-by: Thomas Huth <thuth@redhat.com>


