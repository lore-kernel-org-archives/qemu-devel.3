Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8492C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 16:58:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ridXd-0003mC-6R; Fri, 08 Mar 2024 11:57:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ridXb-0003j1-Bw
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 11:57:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ridXZ-00083t-KB
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 11:57:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709917064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8h41LIQv5P1I/TGPAjsPO3yIcvwvreifU1dV3BqXUn4=;
 b=UZ0AU5EzUgFd4NUSdU/RKTcJhuQXIlp1DTsC0rifBnjc2FTiOaayGUgPznWLgS6Ncc5oCu
 +3x/xTku1D0XNi9bVqSgo2VJ/wI/ZFKa655/y1ytP/rVM0NBMSQPLmEyO6nFDGAGf75XJc
 /GThEw/I5aaaWiKYwxCOmi1QBSXoyfI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-NSCZQ1H-Pci3sAdss6AL6g-1; Fri, 08 Mar 2024 11:57:43 -0500
X-MC-Unique: NSCZQ1H-Pci3sAdss6AL6g-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-412dcaf0bd6so9714425e9.0
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 08:57:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709917062; x=1710521862;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8h41LIQv5P1I/TGPAjsPO3yIcvwvreifU1dV3BqXUn4=;
 b=KR1yNTQ7DNMQ6NMrqgcWtahWHTp3ejL/1OOpIZ1aMCkJTznDLG3vt/DfDd1emZs6Uk
 vqvvTFdke3Zk2CC8IFQ9xNf11BZLegXL82yn2c9buIFYhLn/Y0RWyuLroNhvkUveqF94
 o74XD94QwQmEgTelQEFOQjjFuh7X6g2oZpfzCpsorLwiEI9tz2R/WZHThLiN/fFoKxfe
 Pd8hrC4BanHpVhrVEhSDTKeAgVMsy4yrNs/SiuB6ZnA1BFayUb+DhB4jKcr2HXRnzPfN
 8gyTGUKbmF/20futcW8NlbGz+DdCqZ6X4WsKJF4aJvSMTVZhUwEdJBFT896QljT0nriq
 wD8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeHGW4WG+yNszZo+7JUUPieXyhnL4HlVbtGrNy3B7DWerQou0xi3/x3sKfMgiPNWRwFduWq9g15mEra4chQeSpZ6gO5zk=
X-Gm-Message-State: AOJu0YwUDFz1Ge/RnGMb7lzdjX1DRQPL0P6BjKgwD+XwMPIh5spSQmYG
 us+C0Y0xmn02IbbO0etPIdUiYdTv3xelu+hXd3A2YsOXrApua+ujYb4884VdtMbzqXqc/b6KjcT
 zgLEj7KuIxKD8pdzP8RYups4VdhtSQGfnOQtTrATV9uLE2vbzaLAB
X-Received: by 2002:a05:600c:3111:b0:412:ffc9:d551 with SMTP id
 g17-20020a05600c311100b00412ffc9d551mr5585112wmo.14.1709917061908; 
 Fri, 08 Mar 2024 08:57:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHFZ/4yCpb42ZPPX7d0e/B/VlsQK74EohLqEtaPtIEI6fpzVfw2L5lVHV6qomtmGDUBpr8JVg==
X-Received: by 2002:a05:600c:3111:b0:412:ffc9:d551 with SMTP id
 g17-20020a05600c311100b00412ffc9d551mr5585092wmo.14.1709917061420; 
 Fri, 08 Mar 2024 08:57:41 -0800 (PST)
Received: from redhat.com ([2a06:c701:73cd:f300:bc74:daca:b316:492a])
 by smtp.gmail.com with ESMTPSA id
 t14-20020a05600c198e00b0041312c4865asm4739254wmq.2.2024.03.08.08.57.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 08:57:40 -0800 (PST)
Date: Fri, 8 Mar 2024 11:57:38 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: marcel.apfelbaum@gmail.com, qemu-devel@nongnu.org, clg@redhat.com
Subject: Re: [PATCH] pci: Add option to disable device level INTx masking
Message-ID: <20240308115643-mutt-send-email-mst@kernel.org>
References: <20240307184645.104349-1-alex.williamson@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307184645.104349-1-alex.williamson@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.572,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, Mar 07, 2024 at 11:46:42AM -0700, Alex Williamson wrote:
> The PCI 2.3 spec added definitions of the INTx disable and status bits,
> in the command and status registers respectively.  The command register
> bit, commonly known as DisINTx in lspci, controls whether the device
> can assert the INTx signal.
> 
> Operating systems will often write to this bit to test whether a device
> supports this style of legacy interrupt masking.  When using device
> assignment, such as with vfio-pci, the result of this test dictates
> whether the device can use a shared or exclusive interrupt (ie. generic
> INTx masking at the device via DisINTx or IRQ controller level INTx
> masking).
> 
> Add an experimental option to the base set of properties for PCI
> devices which allows the DisINTx bit to be excluded from wmask, making
> it read-only to the guest for testing purposes related to INTx masking.
> 

Could you clarify the use a bit more? It's unstable - do you
expect to experiment with it and then make it permanent down
the road?

> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>  hw/pci/pci.c         | 14 ++++++++++----
>  include/hw/pci/pci.h |  2 ++
>  2 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 6496d027ca61..8c78326ad67f 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -85,6 +85,8 @@ static Property pci_props[] = {
>                      QEMU_PCIE_ERR_UNC_MASK_BITNR, true),
>      DEFINE_PROP_BIT("x-pcie-ari-nextfn-1", PCIDevice, cap_present,
>                      QEMU_PCIE_ARI_NEXTFN_1_BITNR, false),
> +    DEFINE_PROP_BIT("x-pci-disintx", PCIDevice, cap_present,
> +                    QEMU_PCI_DISINTX_BITNR, true),
>      DEFINE_PROP_END_OF_LIST()
>  };
>  
> @@ -861,13 +863,17 @@ static void pci_init_cmask(PCIDevice *dev)
>  static void pci_init_wmask(PCIDevice *dev)
>  {
>      int config_size = pci_config_size(dev);
> +    uint16_t cmd_wmask = PCI_COMMAND_IO | PCI_COMMAND_MEMORY |
> +                         PCI_COMMAND_MASTER | PCI_COMMAND_SERR;
>  
>      dev->wmask[PCI_CACHE_LINE_SIZE] = 0xff;
>      dev->wmask[PCI_INTERRUPT_LINE] = 0xff;
> -    pci_set_word(dev->wmask + PCI_COMMAND,
> -                 PCI_COMMAND_IO | PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER |
> -                 PCI_COMMAND_INTX_DISABLE);
> -    pci_word_test_and_set_mask(dev->wmask + PCI_COMMAND, PCI_COMMAND_SERR);
> +
> +    if (dev->cap_present & QEMU_PCI_DISINTX) {
> +        cmd_wmask |= PCI_COMMAND_INTX_DISABLE;
> +    }
> +
> +    pci_set_word(dev->wmask + PCI_COMMAND, cmd_wmask);
>  
>      memset(dev->wmask + PCI_CONFIG_HEADER_SIZE, 0xff,
>             config_size - PCI_CONFIG_HEADER_SIZE);
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index eaa3fc99d884..45f0fac435cc 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -212,6 +212,8 @@ enum {
>      QEMU_PCIE_ERR_UNC_MASK = (1 << QEMU_PCIE_ERR_UNC_MASK_BITNR),
>  #define QEMU_PCIE_ARI_NEXTFN_1_BITNR 12
>      QEMU_PCIE_ARI_NEXTFN_1 = (1 << QEMU_PCIE_ARI_NEXTFN_1_BITNR),
> +#define QEMU_PCI_DISINTX_BITNR 13
> +    QEMU_PCI_DISINTX = (1 << QEMU_PCI_DISINTX_BITNR),
>  };
>  
>  typedef struct PCIINTxRoute {
> -- 
> 2.44.0


