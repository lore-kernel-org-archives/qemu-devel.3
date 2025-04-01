Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5CD7C36010
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 13:10:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzbNa-0002Yl-8h; Tue, 01 Apr 2025 09:10:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1tzbNF-0002LT-24
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 09:09:57 -0400
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1tzbN8-0000ue-Jm
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 09:09:46 -0400
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-2c7e5fb8c38so3673931fac.1
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 06:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1743512981; x=1744117781;
 darn=nongnu.org; 
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YH/Pf2fUukOiTkG7suY+XqZeCP/y/uoyxkC1HJDAlik=;
 b=vBLZw+kaAI0XnVmxJymuHDgiNuogZM0GvagkA14Vpugb8nmu9NTsILaFz64B9qHQhz
 xo1IL3qF2tq3hEckcGBxPO2MuQopa8tbZ0uWRFiL1i4hcmwXoO1e3M52KXtBGl3voBl8
 RWNpBKt5J/VRY0VXiWL09+b2uYtvtE/RnQXuX0uvJNRumnx+wi/sIW6eyLUiUeQVHXj6
 5PQPO+fQ1fyKlFZYnbJ39S5FglAVWIqRzwQ9iFw8E4fnIs6YFLFRhzk5Qu1xaWgjLYxh
 k/Jvd2/kWCJEQQjmJpKnW2spBLhaA07p9jnl5MeyWFVMPB5tetyJo17m8p9dzeESQg0z
 3E6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743512981; x=1744117781;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YH/Pf2fUukOiTkG7suY+XqZeCP/y/uoyxkC1HJDAlik=;
 b=J+V79xWg33ldqyTMloZJulVnwEQle0dBlEhsCGiwsBqJlQZiY1MD9Vspwx1GV2dSK2
 2OpzBNOMNCyzTbJYAScdZ5OAaf9FiB/HKttOGkO4S6mgfOmeuooDGvAH3nZDuaX3zs51
 ILK3vibUF1Jp/qI2NW5iixObIAeF15vvwyObGWga0TV+19ycqx2jLoACfYuHiWwqrzlz
 IRlEzF3lzuAWjEYzwktzrqH48Ey1myV3TkMKuHqzRMy/cVBbWLc194MUJH8vUt/9iSka
 WtHy7dnl+4Upb9PQsekeIdZk5M11Ep0j9/mPxs4U2x8E5Xj0u1piPAC7c8EJaTu83F9q
 YswQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9IxosJESNP2Mvx32VVMf39ZlJSij8Jb+2fXiXorJWNCBCuaObZuEUYM6HdO7pBGIsbU9cVmwhIon7@nongnu.org
X-Gm-Message-State: AOJu0YzoLQoV9Cho/7peld5JwLCYrfsGZMUB+NibrTHMcO+WBINmsj7f
 e72gw86QLZVnXiUNHOVoXd5oPADHWjwBUD/Nh5alikygRypsHtd2RSHB6gxHRLEkoG3uw2Tlb95
 g
X-Gm-Gg: ASbGnctS2IGpxCrpphR3rUDQ+B/tw2rNuDd/Svey9uKe0dMtmuIC9RmGrXSmggNI4Qz
 kEUfAWeEBe3deneBC3jIXm6thXFCeN67CJmYIU/tIbqvcjZrb7uJWuPlyOcjATFyEpHHY2X7IlZ
 1ptToKM+tcidXy1SbIaZO8SxQ1KKIgQODrqWhH2Uh1qYLjKyht9A/m3J0hZel6VfVEQHpc3CzJB
 khaLMGw+b8IC/hRTepBP1bTJHidcPchb7kRyI022VnGzDCwOA5exo29+ZdMu+1oJmj8XpBeQCND
 Zs4x1W4AEQnWV4Cc9fjrG0vlkDKNT9jYcVRjQM56/oUBvDnP
X-Google-Smtp-Source: AGHT+IGM0XuRUT4v0h+JeFz/TNI4W13BPNBPsSy0K2KQNjAbYaZ7lnzTlbfGMnELYeKY45/X86B1kw==
X-Received: by 2002:a05:6870:c10f:b0:2c2:4090:9e8 with SMTP id
 586e51a60fabf-2cbcf5b4c35mr6823926fac.22.1743512980748; 
 Tue, 01 Apr 2025 06:09:40 -0700 (PDT)
Received: from mail.minyard.net ([2001:470:b8f6:1b:8459:d76b:f4fb:8568])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2cae8d4422fsm1956262fac.35.2025.04.01.06.09.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 06:09:40 -0700 (PDT)
Date: Tue, 1 Apr 2025 08:09:35 -0500
From: Corey Minyard <corey@minyard.net>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Corey Minyard <minyard@acm.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 2/5] ipmi: add fwinfo to pci ipmi devices
Message-ID: <Z-vljw1_-im7VR-l@mail.minyard.net>
References: <20250401114412.676636-1-npiggin@gmail.com>
 <20250401114412.676636-3-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401114412.676636-3-npiggin@gmail.com>
Received-SPF: none client-ip=2001:4860:4864:20::2b;
 envelope-from=corey@minyard.net; helo=mail-oa1-x2b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Reply-To: corey@minyard.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Apr 01, 2025 at 09:44:09PM +1000, Nicholas Piggin wrote:
> This requires some adjustments to callers to avoid possible behaviour
> changes for PCI devices.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  include/hw/ipmi/ipmi.h     |  5 +++++
>  hw/acpi/ipmi.c             |  2 +-
>  hw/ipmi/isa_ipmi_bt.c      |  1 +
>  hw/ipmi/isa_ipmi_kcs.c     |  1 +
>  hw/ipmi/pci_ipmi_bt.c      | 12 ++++++++++++
>  hw/ipmi/pci_ipmi_kcs.c     | 11 +++++++++++
>  hw/smbios/smbios_type_38.c |  6 +++++-
>  7 files changed, 36 insertions(+), 2 deletions(-)
> 
> diff --git a/include/hw/ipmi/ipmi.h b/include/hw/ipmi/ipmi.h
> index 77a7213ed93..71c4efac8cd 100644
> --- a/include/hw/ipmi/ipmi.h
> +++ b/include/hw/ipmi/ipmi.h
> @@ -90,6 +90,11 @@ typedef struct IPMIFwInfo {
>      } memspace;
>  
>      int interrupt_number;
> +    enum {
> +        IPMI_NO_IRQ = 0,
> +        IPMI_ISA_IRQ,
> +        IPMI_PCI_IRQ,
> +    } irq;

In addition to Phillippe's comment, can you name this "irq_source" to
make it clear what it is?

Overall this patch set looks good.

-corey

>      enum {
>          IPMI_LEVEL_IRQ,
>          IPMI_EDGE_IRQ
> diff --git a/hw/acpi/ipmi.c b/hw/acpi/ipmi.c
> index a20e57d465c..c81cbd2f158 100644
> --- a/hw/acpi/ipmi.c
> +++ b/hw/acpi/ipmi.c
> @@ -55,7 +55,7 @@ static Aml *aml_ipmi_crs(IPMIFwInfo *info)
>          abort();
>      }
>  
> -    if (info->interrupt_number) {
> +    if (info->irq == IPMI_ISA_IRQ && info->interrupt_number) {
>          aml_append(crs, aml_irq_no_flags(info->interrupt_number));
>      }
>  
> diff --git a/hw/ipmi/isa_ipmi_bt.c b/hw/ipmi/isa_ipmi_bt.c
> index a1b66d5ee82..b5556436b82 100644
> --- a/hw/ipmi/isa_ipmi_bt.c
> +++ b/hw/ipmi/isa_ipmi_bt.c
> @@ -49,6 +49,7 @@ static void isa_ipmi_bt_get_fwinfo(struct IPMIInterface *ii, IPMIFwInfo *info)
>      ISAIPMIBTDevice *iib = ISA_IPMI_BT(ii);
>  
>      ipmi_bt_get_fwinfo(&iib->bt, info);
> +    info->irq = IPMI_ISA_IRQ;
>      info->interrupt_number = iib->isairq;
>      info->i2c_slave_address = iib->bt.bmc->slave_addr;
>      info->uuid = iib->uuid;
> diff --git a/hw/ipmi/isa_ipmi_kcs.c b/hw/ipmi/isa_ipmi_kcs.c
> index d9ebdd5371f..326115f51bb 100644
> --- a/hw/ipmi/isa_ipmi_kcs.c
> +++ b/hw/ipmi/isa_ipmi_kcs.c
> @@ -49,6 +49,7 @@ static void isa_ipmi_kcs_get_fwinfo(IPMIInterface *ii, IPMIFwInfo *info)
>      ISAIPMIKCSDevice *iik = ISA_IPMI_KCS(ii);
>  
>      ipmi_kcs_get_fwinfo(&iik->kcs, info);
> +    info->irq = IPMI_ISA_IRQ;
>      info->interrupt_number = iik->isairq;
>      info->uuid = iik->uuid;
>  }
> diff --git a/hw/ipmi/pci_ipmi_bt.c b/hw/ipmi/pci_ipmi_bt.c
> index a3b742d22c9..33ff7190ee8 100644
> --- a/hw/ipmi/pci_ipmi_bt.c
> +++ b/hw/ipmi/pci_ipmi_bt.c
> @@ -38,6 +38,17 @@ struct PCIIPMIBTDevice {
>      uint32_t uuid;
>  };
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
>  static void pci_ipmi_raise_irq(IPMIBT *ib)
>  {
>      PCIIPMIBTDevice *pib = ib->opaque;
> @@ -125,6 +136,7 @@ static void pci_ipmi_bt_class_init(ObjectClass *oc, void *data)
>  
>      iic->get_backend_data = pci_ipmi_bt_get_backend_data;
>      ipmi_bt_class_init(iic);
> +    iic->get_fwinfo = pci_ipmi_bt_get_fwinfo;
>  }
>  
>  static const TypeInfo pci_ipmi_bt_info = {
> diff --git a/hw/ipmi/pci_ipmi_kcs.c b/hw/ipmi/pci_ipmi_kcs.c
> index 05ba97ec58f..6673b2088ef 100644
> --- a/hw/ipmi/pci_ipmi_kcs.c
> +++ b/hw/ipmi/pci_ipmi_kcs.c
> @@ -38,6 +38,16 @@ struct PCIIPMIKCSDevice {
>      uint32_t uuid;
>  };
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
>  static void pci_ipmi_raise_irq(IPMIKCS *ik)
>  {
>      PCIIPMIKCSDevice *pik = ik->opaque;
> @@ -125,6 +135,7 @@ static void pci_ipmi_kcs_class_init(ObjectClass *oc, void *data)
>  
>      iic->get_backend_data = pci_ipmi_kcs_get_backend_data;
>      ipmi_kcs_class_init(iic);
> +    iic->get_fwinfo = pci_ipmi_kcs_get_fwinfo;
>  }
>  
>  static const TypeInfo pci_ipmi_kcs_info = {
> diff --git a/hw/smbios/smbios_type_38.c b/hw/smbios/smbios_type_38.c
> index 168b886647d..2823929c258 100644
> --- a/hw/smbios/smbios_type_38.c
> +++ b/hw/smbios/smbios_type_38.c
> @@ -72,7 +72,11 @@ static void smbios_build_one_type_38(IPMIFwInfo *info)
>                       " SMBIOS, ignoring this entry.", info->register_spacing);
>          return;
>      }
> -    t->interrupt_number = info->interrupt_number;
> +    if (info->irq == IPMI_ISA_IRQ) {
> +        t->interrupt_number = info->interrupt_number;
> +    } else {
> +        t->interrupt_number = 0;
> +    }
>  
>      SMBIOS_BUILD_TABLE_POST;
>  }
> -- 
> 2.47.1
> 

