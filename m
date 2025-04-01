Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E46A2C36010
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 11:58:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzaEv-0000tO-Ae; Tue, 01 Apr 2025 07:57:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzaEs-0000t9-O2
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 07:57:06 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzaEq-0005kB-K8
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 07:57:06 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43cf3192f3bso55337745e9.1
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 04:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743508622; x=1744113422; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nO/9GIWR1eUdDzreXzOiJZXm8p+Xh8DpUVcEmpP/YPA=;
 b=cUuA6M3XVT0gAycnyaL+tqtx0gBjn+Bm15xctcP/H8TYSPpLqXndPeqzi9R/ZBP+er
 mC0b2sMzpmSRLaI8l4NXm/pXoMMY1xWCdXDMC8TuMfqL980/rdwptUEWTqin4yjjVdVG
 1OYbg97EsRNX4FTOcOpiUVO+bf9uWnS1xcPXGdYnUgtTNrEtO1ul0BK5kyN7juvObUxI
 7s/CKxHxgQpa6zaZP/GyX0FJ3zhWiGVu8xL0z8Y4pZQDUSetphgeqtuOYFZwxTIlhP28
 UFsAq/h5zAdudD61rA/G8eSkco8F5yvWiGlKO6Jj5N8IiapXjbrG97AlKXUUEItRFla4
 hgzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743508622; x=1744113422;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nO/9GIWR1eUdDzreXzOiJZXm8p+Xh8DpUVcEmpP/YPA=;
 b=v5F9YVQpba+FOShw4shSAIs51nwTzJVq5hnf8/QqOe1ihLofbMlVTpuIjWaTKwEow6
 UabcMmwKJzb4y/VIcthAwxg0M0E5bQeJ1G+hkdUsXTeSdEkpjFACm03AsQdfPSNQiUsn
 qinpJTmQwbrhuNZTwikONntRWfiuQF6UqEjpC5yoaRb5q5vhWl+whodbDaK+OiveifwK
 NVqqGfs6XDiG5rk6r4pSY7irO0AAgdvIuBnYmoTExBMHLUntq0Lq4lxJVuCCSz5Nn5p7
 Z8sN5mQSxq/kS4QFYJshdAaBdtp9jByBNw4vJKZQiUtgwsok49Us/JBHxXbRJChH0Nn1
 B6nw==
X-Gm-Message-State: AOJu0Yz2AC+WOtXCFNdY1fSnSuMvcHsIwbf7X7sSD9L3h9gqGAyDl0n+
 si2V56dNNWv7DwQNZXos8LHbsO5AnSlCifBRWh9PUcVtvZeXWpV7uPMmMjmeNKG3esXN7bkaM8Q
 j
X-Gm-Gg: ASbGncu6aM7LJucLhdx8z0z3P7Y+sl6Q4rWb4quyCwgw24O7fPcMsbW1UvCdigUZJxx
 SVK3kjAmkgccXMPtFuL5MUKeehkGEguTLTO5QW6y0RPDG1yOXYtDfmaKEVJJ8c+cUWAKt88RZdD
 PlehtKQ0v5LssB1eNBJitW0sTdDgLOWnj67s1WuWfp2XTLPPf57ko9B1i2UOuRzZMMRs8c66atp
 8bxY2l214JCeA2IOrauWuMHjWWNS5hx/jEKe1H2WgFuEXTZlffkDA1v+sYmGKraG/RDQskCsGZ8
 ZeEXSRHjk8gjljdRLAGuK8GQVtT5P2Vt7KIxGpIZh+5A+IZDK9Ibn/WK2nlI9Qpim/1K8gQ0WyK
 QWhz2vGrbsMxuRaJ36VlrDkY=
X-Google-Smtp-Source: AGHT+IHTPqqHvVQwaRIitGkq7ws6VkbC04Ck2/WWpCDx76LK5IzZzUb72jJHnc+TzfRdDyxecTmDbQ==
X-Received: by 2002:a05:600c:1f17:b0:439:643a:c8d5 with SMTP id
 5b1f17b1804b1-43e99ab533cmr92558875e9.0.1743508622372; 
 Tue, 01 Apr 2025 04:57:02 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b7a8e0asm13806929f8f.101.2025.04.01.04.57.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Apr 2025 04:57:01 -0700 (PDT)
Message-ID: <b0842a9c-dac4-4433-b69a-054ac65d8735@linaro.org>
Date: Tue, 1 Apr 2025 13:57:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] ipmi: add fwinfo to pci ipmi devices
To: Nicholas Piggin <npiggin@gmail.com>, Corey Minyard <minyard@acm.org>
Cc: qemu-devel@nongnu.org
References: <20250401114412.676636-1-npiggin@gmail.com>
 <20250401114412.676636-3-npiggin@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250401114412.676636-3-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Nick,

On 1/4/25 13:44, Nicholas Piggin wrote:
> This requires some adjustments to callers to avoid possible behaviour
> changes for PCI devices.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   include/hw/ipmi/ipmi.h     |  5 +++++
>   hw/acpi/ipmi.c             |  2 +-
>   hw/ipmi/isa_ipmi_bt.c      |  1 +
>   hw/ipmi/isa_ipmi_kcs.c     |  1 +
>   hw/ipmi/pci_ipmi_bt.c      | 12 ++++++++++++
>   hw/ipmi/pci_ipmi_kcs.c     | 11 +++++++++++
>   hw/smbios/smbios_type_38.c |  6 +++++-
>   7 files changed, 36 insertions(+), 2 deletions(-)
> 
> diff --git a/include/hw/ipmi/ipmi.h b/include/hw/ipmi/ipmi.h
> index 77a7213ed93..71c4efac8cd 100644
> --- a/include/hw/ipmi/ipmi.h
> +++ b/include/hw/ipmi/ipmi.h
> @@ -90,6 +90,11 @@ typedef struct IPMIFwInfo {
>       } memspace;
>   
>       int interrupt_number;
> +    enum {
> +        IPMI_NO_IRQ = 0,
> +        IPMI_ISA_IRQ,
> +        IPMI_PCI_IRQ,
> +    } irq;
>       enum {
>           IPMI_LEVEL_IRQ,
>           IPMI_EDGE_IRQ
> diff --git a/hw/acpi/ipmi.c b/hw/acpi/ipmi.c
> index a20e57d465c..c81cbd2f158 100644
> --- a/hw/acpi/ipmi.c
> +++ b/hw/acpi/ipmi.c
> @@ -55,7 +55,7 @@ static Aml *aml_ipmi_crs(IPMIFwInfo *info)
>           abort();
>       }
>   
> -    if (info->interrupt_number) {
> +    if (info->irq == IPMI_ISA_IRQ && info->interrupt_number) {
>           aml_append(crs, aml_irq_no_flags(info->interrupt_number));
>       }
>   
> diff --git a/hw/ipmi/isa_ipmi_bt.c b/hw/ipmi/isa_ipmi_bt.c
> index a1b66d5ee82..b5556436b82 100644
> --- a/hw/ipmi/isa_ipmi_bt.c
> +++ b/hw/ipmi/isa_ipmi_bt.c
> @@ -49,6 +49,7 @@ static void isa_ipmi_bt_get_fwinfo(struct IPMIInterface *ii, IPMIFwInfo *info)
>       ISAIPMIBTDevice *iib = ISA_IPMI_BT(ii);
>   
>       ipmi_bt_get_fwinfo(&iib->bt, info);
> +    info->irq = IPMI_ISA_IRQ;
>       info->interrupt_number = iib->isairq;
>       info->i2c_slave_address = iib->bt.bmc->slave_addr;
>       info->uuid = iib->uuid;
> diff --git a/hw/ipmi/isa_ipmi_kcs.c b/hw/ipmi/isa_ipmi_kcs.c
> index d9ebdd5371f..326115f51bb 100644
> --- a/hw/ipmi/isa_ipmi_kcs.c
> +++ b/hw/ipmi/isa_ipmi_kcs.c
> @@ -49,6 +49,7 @@ static void isa_ipmi_kcs_get_fwinfo(IPMIInterface *ii, IPMIFwInfo *info)
>       ISAIPMIKCSDevice *iik = ISA_IPMI_KCS(ii);
>   
>       ipmi_kcs_get_fwinfo(&iik->kcs, info);
> +    info->irq = IPMI_ISA_IRQ;
>       info->interrupt_number = iik->isairq;
>       info->uuid = iik->uuid;
>   }
> diff --git a/hw/ipmi/pci_ipmi_bt.c b/hw/ipmi/pci_ipmi_bt.c
> index a3b742d22c9..33ff7190ee8 100644
> --- a/hw/ipmi/pci_ipmi_bt.c
> +++ b/hw/ipmi/pci_ipmi_bt.c
> @@ -38,6 +38,17 @@ struct PCIIPMIBTDevice {
>       uint32_t uuid;
>   };
>   
> +static void pci_ipmi_bt_get_fwinfo(struct IPMIInterface *ii, IPMIFwInfo *info)
> +{
> +    PCIIPMIBTDevice *pib = PCI_IPMI_BT(ii);
> +
> +    ipmi_bt_get_fwinfo(&pib->bt, info);
> +    info->irq = IPMI_PCI_IRQ;
> +    info->interrupt_number = pci_intx(&pib->dev);
> +    info->i2c_slave_address = pib->bt.bmc->slave_addr;
> +    info->uuid = pib->uuid;
> +}
> +
>   static void pci_ipmi_raise_irq(IPMIBT *ib)
>   {
>       PCIIPMIBTDevice *pib = ib->opaque;
> @@ -125,6 +136,7 @@ static void pci_ipmi_bt_class_init(ObjectClass *oc, void *data)
>   
>       iic->get_backend_data = pci_ipmi_bt_get_backend_data;
>       ipmi_bt_class_init(iic);
> +    iic->get_fwinfo = pci_ipmi_bt_get_fwinfo;
>   }
>   
>   static const TypeInfo pci_ipmi_bt_info = {
> diff --git a/hw/ipmi/pci_ipmi_kcs.c b/hw/ipmi/pci_ipmi_kcs.c
> index 05ba97ec58f..6673b2088ef 100644
> --- a/hw/ipmi/pci_ipmi_kcs.c
> +++ b/hw/ipmi/pci_ipmi_kcs.c
> @@ -38,6 +38,16 @@ struct PCIIPMIKCSDevice {
>       uint32_t uuid;
>   };
>   
> +static void pci_ipmi_bt_get_fwinfo(struct IPMIInterface *ii, IPMIFwInfo *info)
> +{
> +    PCIIPMIKCSDevice *pik = PCI_IPMI_KCS(ii);
> +
> +    ipmi_kcs_get_fwinfo(&pik->kcs, info);
> +    info->irq = IPMI_PCI_IRQ;
> +    info->interrupt_number = pci_intx(&pik->dev);
> +    info->uuid = pik->uuid;
> +}
> +
>   static void pci_ipmi_raise_irq(IPMIKCS *ik)
>   {
>       PCIIPMIKCSDevice *pik = ik->opaque;
> @@ -125,6 +135,7 @@ static void pci_ipmi_kcs_class_init(ObjectClass *oc, void *data)
>   
>       iic->get_backend_data = pci_ipmi_kcs_get_backend_data;
>       ipmi_kcs_class_init(iic);
> +    iic->get_fwinfo = pci_ipmi_kcs_get_fwinfo;
>   }
>   
>   static const TypeInfo pci_ipmi_kcs_info = {
> diff --git a/hw/smbios/smbios_type_38.c b/hw/smbios/smbios_type_38.c
> index 168b886647d..2823929c258 100644
> --- a/hw/smbios/smbios_type_38.c
> +++ b/hw/smbios/smbios_type_38.c
> @@ -72,7 +72,11 @@ static void smbios_build_one_type_38(IPMIFwInfo *info)
>                        " SMBIOS, ignoring this entry.", info->register_spacing);
>           return;
>       }
> -    t->interrupt_number = info->interrupt_number;
> +    if (info->irq == IPMI_ISA_IRQ) {
> +        t->interrupt_number = info->interrupt_number;
> +    } else {
> +        t->interrupt_number = 0;

Can you explain why use 0 for PCI?

> +    }
>   
>       SMBIOS_BUILD_TABLE_POST;
>   }


