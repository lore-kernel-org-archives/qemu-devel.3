Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BACCDC54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 08:05:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rm7z8-0000Ty-5R; Mon, 18 Mar 2024 04:04:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rm7z5-0000Tg-Bt
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 04:04:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rm7ys-0001jh-Dd
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 04:04:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710749062;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MKezJqL4w19nBxCNntscYpJbXJ7ro8ADsyqjjBLcNog=;
 b=VAO6ofoARjgRxfjTV0K8H8P6kY8ZetdKlR4mNll5ZqOYTbm1eA+y7EbV52VZx1iu38iU5k
 xqtgDW2UyIoqenO1IkARUH5FcLz4Heoongz2lQEWsuwN9afK6+qyLlAkU0Trku7MrU/UEx
 6idgkdEfmS+I+9EvhOXM7pO05HI3FuA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-F7hsex17ORSgyyPlPPwnTA-1; Mon, 18 Mar 2024 04:04:21 -0400
X-MC-Unique: F7hsex17ORSgyyPlPPwnTA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-33ed0a8beb5so1793707f8f.1
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 01:04:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710749059; x=1711353859;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MKezJqL4w19nBxCNntscYpJbXJ7ro8ADsyqjjBLcNog=;
 b=KKtXpEr/PT9pu7qUUL/6FYHFM3YiCU/HnNBObNcysecS51cpthOz9onRz6JtO1KoC7
 iSKxASn6MLkCY66M+tY29lOJ/pDZ73SkRObEcrUgy21p6LJleoOahpE2pdzPSJxavkqb
 xSZP+MwX0md3jfmA8MqyZe2q+HFal5uGwi6vX/39c8oK9n31rzZCfZQXkusPLUu2IUGB
 vZkikzeUiLEoc1vI7GohaEuY9zdn4qRSLM0vZUn9tzT077fNX7g4TtjuNb4aS56C42FY
 TxY3ndh9TZ1kRQSwQeoRw8jDjWrqzNRO/Q7jxwotCJmIsBUzLVNi+joFZOuv8HkVJU1b
 WOpQ==
X-Gm-Message-State: AOJu0YzTEtMZykiHYD4TP9TEOUigNJUXHHizue8LnR3mrIAgG2KBrfLf
 oN5n5kc2klsPcRdh6p6MiFn4O7dBhFkY5LBBtaFITtOXf+3iiQzPv4z10ARGKPaB7wzFqW61I12
 pEITxpgr6tZ5+4XMYAMHt/QaQOd/UINwC9PdOTbYe/HAwQ97vMhJA48gks4S+
X-Received: by 2002:adf:fa87:0:b0:33e:7946:4cd2 with SMTP id
 h7-20020adffa87000000b0033e79464cd2mr6872288wrr.10.1710749058954; 
 Mon, 18 Mar 2024 01:04:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkr0uPssNWJWwnp5pkdKug8aJ/HKyly1Ewh4Lb046Mda2kJBDtu+abVoHZi3gPWKdcNJ2Qtg==
X-Received: by 2002:adf:fa87:0:b0:33e:7946:4cd2 with SMTP id
 h7-20020adffa87000000b0033e79464cd2mr6872260wrr.10.1710749058299; 
 Mon, 18 Mar 2024 01:04:18 -0700 (PDT)
Received: from redhat.com ([2.52.5.113]) by smtp.gmail.com with ESMTPSA id
 w16-20020adfcd10000000b0033e5c54d0d9sm9208566wrm.38.2024.03.18.01.04.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Mar 2024 01:04:17 -0700 (PDT)
Date: Mon, 18 Mar 2024 04:04:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiqian Chen <Jiqian.Chen@amd.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [QEMU PATCH v6 1/1] virtio-pci: implement No_Soft_Reset bit
Message-ID: <20240318035505-mutt-send-email-mst@kernel.org>
References: <20240222034010.887390-1-Jiqian.Chen@amd.com>
 <20240222034010.887390-2-Jiqian.Chen@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222034010.887390-2-Jiqian.Chen@amd.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.316,
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

On Thu, Feb 22, 2024 at 11:40:10AM +0800, Jiqian Chen wrote:
> In current code, when guest does S3, virtio devices are reset due to
> the bit No_Soft_Reset is not set. After resetting, the display resources
> of virtio-gpu are destroyed, then the display can't come back and only
> show blank after resuming.
> 
> Implement No_Soft_Reset bit of PCI_PM_CTRL register, then guest can check
> this bit, if this bit is set, the devices resetting will not be done, and
> then the display can work after resuming.
> 
> Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
> ---
>  hw/virtio/virtio-pci.c         | 37 +++++++++++++++++++++++++++++++++-
>  include/hw/virtio/virtio-pci.h |  5 +++++
>  2 files changed, 41 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index 1a7039fb0c68..da5312010345 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -2197,6 +2197,11 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
>              pcie_cap_lnkctl_init(pci_dev);
>          }
>  
> +        if (proxy->flags & VIRTIO_PCI_FLAG_PM_NO_SOFT_RESET) {
> +            pci_set_word(pci_dev->config + pos + PCI_PM_CTRL,
> +                         PCI_PM_CTRL_NO_SOFT_RESET);
> +        }
> +
>          if (proxy->flags & VIRTIO_PCI_FLAG_INIT_PM) {
>              /* Init Power Management Control Register */
>              pci_set_word(pci_dev->wmask + pos + PCI_PM_CTRL,


Don't we need compat machinery to avoid breaking migration for
existing machine types?

> @@ -2259,18 +2264,46 @@ static void virtio_pci_reset(DeviceState *qdev)
>      }
>  }
>  
> +static bool device_no_need_reset(PCIDevice *dev)
> +{
> +    if (pci_is_express(dev)) {
> +        uint16_t pmcsr;
> +
> +        pmcsr = pci_get_word(dev->config + dev->exp.pm_cap + PCI_PM_CTRL);
> +        /*
> +         * When No_Soft_Reset bit is set and device

the device

> +         * is in D3hot state, can't reset device

can't? or don't?

> +         */
> +        if ((pmcsr & PCI_PM_CTRL_NO_SOFT_RESET) &&
> +            (pmcsr & PCI_PM_CTRL_STATE_MASK) == 3)
> +            return true;

coding style violation

> +    }
> +
> +    return false;
> +}
> +
>  static void virtio_pci_bus_reset_hold(Object *obj)
>  {
>      PCIDevice *dev = PCI_DEVICE(obj);
>      DeviceState *qdev = DEVICE(obj);
>  
> +    if (device_no_need_reset(dev))
> +        return;
> +
>      virtio_pci_reset(qdev);
>  
>      if (pci_is_express(dev)) {
> +        uint16_t pmcsr;
> +        uint16_t val = 0;
> +
>          pcie_cap_deverr_reset(dev);
>          pcie_cap_lnkctl_reset(dev);
>  
> -        pci_set_word(dev->config + dev->exp.pm_cap + PCI_PM_CTRL, 0);
> +        /* don't reset the RO bits */
> +        pmcsr = pci_get_word(dev->config + dev->exp.pm_cap + PCI_PM_CTRL);
> +        val = val | (pmcsr & PCI_PM_CTRL_NO_SOFT_RESET) |
> +                (pmcsr & PCI_PM_CTRL_DATA_SCALE_MASK);
> +        pci_set_word(dev->config + dev->exp.pm_cap + PCI_PM_CTRL, val);

First, we have test and clear for this.

Second, this has to be conditional on the flag, no?
Without the flag don't we reset everything?
Or you can reuse wmask for this, also an option.

Also what's going on with PCI_PM_CTRL_DATA_SCALE_MASK?
Where does that come from?

>      }
>  }
>  
> @@ -2297,6 +2330,8 @@ static Property virtio_pci_properties[] = {
>                      VIRTIO_PCI_FLAG_INIT_LNKCTL_BIT, true),
>      DEFINE_PROP_BIT("x-pcie-pm-init", VirtIOPCIProxy, flags,
>                      VIRTIO_PCI_FLAG_INIT_PM_BIT, true),
> +    DEFINE_PROP_BIT("x-pcie-pm-no-soft-reset", VirtIOPCIProxy, flags,
> +                    VIRTIO_PCI_FLAG_PM_NO_SOFT_RESET_BIT, true),
>      DEFINE_PROP_BIT("x-pcie-flr-init", VirtIOPCIProxy, flags,
>                      VIRTIO_PCI_FLAG_INIT_FLR_BIT, true),
>      DEFINE_PROP_BIT("aer", VirtIOPCIProxy, flags,
> diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-pci.h
> index 59d88018c16a..9e67ba38c748 100644
> --- a/include/hw/virtio/virtio-pci.h
> +++ b/include/hw/virtio/virtio-pci.h
> @@ -43,6 +43,7 @@ enum {
>      VIRTIO_PCI_FLAG_INIT_FLR_BIT,
>      VIRTIO_PCI_FLAG_AER_BIT,
>      VIRTIO_PCI_FLAG_ATS_PAGE_ALIGNED_BIT,
> +    VIRTIO_PCI_FLAG_PM_NO_SOFT_RESET_BIT,
>  };
>  
>  /* Need to activate work-arounds for buggy guests at vmstate load. */
> @@ -79,6 +80,10 @@ enum {
>  /* Init Power Management */
>  #define VIRTIO_PCI_FLAG_INIT_PM (1 << VIRTIO_PCI_FLAG_INIT_PM_BIT)
>  
> +/* Init The No_Soft_Reset bit of Power Management */
> +#define VIRTIO_PCI_FLAG_PM_NO_SOFT_RESET \
> +  (1 << VIRTIO_PCI_FLAG_PM_NO_SOFT_RESET_BIT)
> +
>  /* Init Function Level Reset capability */
>  #define VIRTIO_PCI_FLAG_INIT_FLR (1 << VIRTIO_PCI_FLAG_INIT_FLR_BIT)
>  
> -- 
> 2.34.1


