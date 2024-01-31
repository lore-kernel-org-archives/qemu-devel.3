Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23A7BC47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 12:07:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rV9Ml-0008Uu-Kd; Wed, 31 Jan 2024 07:06:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rV9Mk-0008Tg-7N
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 07:06:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rV9Mi-0006Qw-Fr
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 07:06:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706702810;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=bNaEjfn7BRdxUXTf1mBkB9165kz2h6h7Evv6wFMcl9E=;
 b=BowmnYHCLlC2sazOzw4DCl/QebXgHB6fLhdOoEAZ6/aoptj8+aE/mFi36La/i89GoKRuAo
 yW39fkNlojY1VnVMdWuIjc/i/NlrxCxA3pS/okFplmHYNSGsFYtNXhek7/yHHvPRXiwidy
 8NpmvVfVJcuMM6LyBzU/kFI1RVnI06w=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-UuMsxFZmMues4Qm_-Vd8pQ-1; Wed, 31 Jan 2024 07:06:49 -0500
X-MC-Unique: UuMsxFZmMues4Qm_-Vd8pQ-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-68c48347f7aso54219666d6.0
 for <qemu-devel@nongnu.org>; Wed, 31 Jan 2024 04:06:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706702809; x=1707307609;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bNaEjfn7BRdxUXTf1mBkB9165kz2h6h7Evv6wFMcl9E=;
 b=RVQQNOdJMz6bUvT0t03vZqEp04pY6PpOgabuaiUG7/8smLCAO9wsZo6fhzO4vslORI
 MYNP/6u6TfkWqsQfYlnGHw5ujiW9m4cDCmzZzkHpSNOxQ9S7rpLRNx+WuZxwXencKZHl
 wku3Z+faRvR/Z5kefdF3rhv10foXh/AGMyifZHUmFvNu8dOV0hNDAZtlkSfJ3dUOX1s3
 EiyUeLs8hTxf9JJOIqigymw1Pbz1mHU5VJ/56YebkLin1iVvN+kNYE0yM6JtVG+YWwIL
 OUgHY+9/vO750MW/pX6q4XCUd4gO74Cmk0j6IluIYl4OTU3MALL2eNmJj7Yb6++QvfNj
 4JSA==
X-Gm-Message-State: AOJu0YyLV7y9N2B7w1kXTuEBpXvnGqd9cATG+SPN7n9fKQSNEk2JKkUf
 UPvYJvogloSQ0l4b1pVzw3iloynXRqE9uGgktCx/SdBs3ULhPeNt1qLl3hZH0JeyrdagftIgyqP
 k0vfsALrvpwKt3CWJOC8BtcGVSpTQRBf2CC0Sh9Ctqj2ijpDdaSSU
X-Received: by 2002:ad4:5c6d:0:b0:68c:5c39:5ef9 with SMTP id
 i13-20020ad45c6d000000b0068c5c395ef9mr1669007qvh.56.1706702809000; 
 Wed, 31 Jan 2024 04:06:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGFGznmOvny8yOuLZp5rMC1hNAjlNkjP89Jk6G+vjYz04UMkyOIZJm8GEQcxS5yCOmMyNRDvg==
X-Received: by 2002:ad4:5c6d:0:b0:68c:5c39:5ef9 with SMTP id
 i13-20020ad45c6d000000b0068c5c395ef9mr1668985qvh.56.1706702808740; 
 Wed, 31 Jan 2024 04:06:48 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-177-196.web.vodafone.de.
 [109.43.177.196]) by smtp.gmail.com with ESMTPSA id
 qq16-20020a0562142c1000b0067f53e25d1esm788452qvb.14.2024.01.31.04.06.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Jan 2024 04:06:48 -0800 (PST)
Message-ID: <3c496c3a-9aa7-4759-b08d-afab6b6063fc@redhat.com>
Date: Wed, 31 Jan 2024 13:06:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 42/47] hw/sparc/sun4m: use qemu_find_nic_info()
Content-Language: en-US
To: David Woodhouse <dwmw2@infradead.org>, qemu-devel@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Rob Herring <robh@kernel.org>, Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Jan Kiszka <jan.kiszka@web.de>, Tyrone Ting <kfting@nuvoton.com>,
 Hao Wu <wuhaotsh@google.com>, Radoslaw Biernacki <rad@semihalf.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, Helge Deller <deller@gmx.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Song Gao
 <gaosong@loongson.cn>, Laurent Vivier <laurent@vivier.eu>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Jason Wang <jasowang@redhat.com>,
 Jia Liu <proljc@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Bin Meng
 <bin.meng@windriver.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 Max Filippov <jcmvbkbc@gmail.com>, David Woodhouse <dwmw@amazon.co.uk>
References: <20240126173228.394202-1-dwmw2@infradead.org>
 <20240126173228.394202-43-dwmw2@infradead.org>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240126173228.394202-43-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 26/01/2024 18.25, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> Obtain the MAC address from the NIC configuration if there is one, or
> generate one explicitly so that it can be placed in the PROM.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   hw/sparc/sun4m.c | 20 ++++++++++++++------
>   1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
> index 550af01690..e782c8ec7a 100644
> --- a/hw/sparc/sun4m.c
> +++ b/hw/sparc/sun4m.c
> @@ -299,13 +299,15 @@ static void *iommu_init(hwaddr addr, uint32_t version, qemu_irq irq)
>   
>   static void *sparc32_dma_init(hwaddr dma_base,
>                                 hwaddr esp_base, qemu_irq espdma_irq,
> -                              hwaddr le_base, qemu_irq ledma_irq, NICInfo *nd)
> +                              hwaddr le_base, qemu_irq ledma_irq,
> +                              MACAddr *mac)
>   {
>       DeviceState *dma;
>       ESPDMADeviceState *espdma;
>       LEDMADeviceState *ledma;
>       SysBusESPState *esp;
>       SysBusPCNetState *lance;
> +    NICInfo *nd = qemu_find_nic_info("lance", true, NULL);
>   
>       dma = qdev_new(TYPE_SPARC32_DMA);
>       espdma = SPARC32_ESPDMA_DEVICE(object_resolve_path_component(
> @@ -320,7 +322,14 @@ static void *sparc32_dma_init(hwaddr dma_base,
>   
>       lance = SYSBUS_PCNET(object_resolve_path_component(
>                            OBJECT(ledma), "lance"));
> -    qdev_set_nic_properties(DEVICE(lance), nd);
> +
> +    if (nd) {
> +        qdev_set_nic_properties(DEVICE(lance), nd);
> +        memcpy(mac->a, nd->macaddr.a, sizeof(mac->a));
> +    } else {
> +        qemu_macaddr_default_if_unset(mac);
> +        qdev_prop_set_macaddr(DEVICE(lance), "mac", mac->a);
> +    }
>   
>       sysbus_realize_and_unref(SYS_BUS_DEVICE(dma), &error_fatal);
>       sysbus_mmio_map(SYS_BUS_DEVICE(dma), 0, dma_base);
> @@ -823,7 +832,7 @@ static void sun4m_hw_init(MachineState *machine)
>       unsigned int smp_cpus = machine->smp.cpus;
>       unsigned int max_cpus = machine->smp.max_cpus;
>       HostMemoryBackend *ram_memdev = machine->memdev;
> -    NICInfo *nd = &nd_table[0];
> +    MACAddr hostid;
>   
>       if (machine->ram_size > hwdef->max_mem) {
>           error_report("Too much memory for this machine: %" PRId64 ","
> @@ -884,10 +893,9 @@ static void sun4m_hw_init(MachineState *machine)
>                           hwdef->iommu_pad_base, hwdef->iommu_pad_len);
>       }
>   
> -    qemu_check_nic_model(nd, TYPE_LANCE);
>       sparc32_dma_init(hwdef->dma_base,
>                        hwdef->esp_base, slavio_irq[18],
> -                     hwdef->le_base, slavio_irq[16], nd);
> +                     hwdef->le_base, slavio_irq[16], &hostid);
>   
>       if (graphic_depth != 8 && graphic_depth != 24) {
>           error_report("Unsupported depth: %d", graphic_depth);
> @@ -1039,7 +1047,7 @@ static void sun4m_hw_init(MachineState *machine)
>                                       machine->initrd_filename,
>                                       machine->ram_size, &initrd_size);
>   
> -    nvram_init(nvram, (uint8_t *)&nd->macaddr, machine->kernel_cmdline,
> +    nvram_init(nvram, hostid.a, machine->kernel_cmdline,
>                  machine->boot_config.order, machine->ram_size, kernel_size,
>                  graphic_width, graphic_height, graphic_depth,
>                  hwdef->nvram_machine_id, "Sun4m");

Reviewed-by: Thomas Huth <thuth@redhat.com>


