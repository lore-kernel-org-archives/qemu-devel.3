Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACC8CC54E64
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 08:12:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpkrM-0002He-U3; Thu, 28 Mar 2024 04:11:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rpkrL-0002HV-3V
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 04:11:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rpkrJ-0000cE-6S
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 04:11:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711613495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/PeQP9bKz07aTx2PqB++crcU6xbdavmac5tR18giZsw=;
 b=QI28OYlEAP5nviPKq1x71nvAtPp2EBadrh+wVmCduKmhHduW+bjuo2wXQsHFHkceLYLNZ+
 ekEN5njNZojsVVO3jnWt29FY9haRWg/SC7m3BK8aREQ3Q5KlTWsvIv1D6paSTEThvAb4if
 3wct+18L7us2Du2q4GuDQ5Lf1sfRvlQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-Vd6EtdicP4qjOHTc6LDrCA-1; Thu, 28 Mar 2024 04:11:28 -0400
X-MC-Unique: Vd6EtdicP4qjOHTc6LDrCA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a4698fc37dfso39986466b.2
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 01:11:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711613487; x=1712218287;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/PeQP9bKz07aTx2PqB++crcU6xbdavmac5tR18giZsw=;
 b=w3HhE9kNrPPwGbQpqcwupz81BbNIivriVv/d5ta3tfuwWYOawmRn+cX9u1pD9qmMu5
 DPrfGVh0mXMuYYPHQw7OONxRjMks1z6xJ/AASAb0jVe3q7sgxw1PjJIAtPTw/rNNUCzq
 q3xftk/JGT5cwcUY/i7qDJ9Anjim9mpEuocQrKH8P8t7tpVUcVWRU+ov+pm6N8Bi2QGv
 L1POXsff8+H2TSVu7Vjrp+mXGSQGjYKhN0L3vuKiOj6cuD2zX4+mOjvQzeRLXF9v1Ajc
 1i63vL+89U1DsPiFFoDu5FJ+BpD9shIAykTaz0TP1ar/jX5RdQl4jJ22B65OtD1lxBrB
 AKKw==
X-Gm-Message-State: AOJu0YzOp8vh8+rSH36BT00NsxnzWbFbRXimwabQxQ2TRdnEERGtKtnk
 Es2Oow5SMGcn6+lwPgNX1d/TsKEK2erCdOYL5hdf71NszH9OKfx/RAmXgjaf727vzQsR/GIEOHQ
 l+x51pK6axsVdLhnEJs+V76pNI0yXNF0RT5s+QAMla4Coc+6QijaR
X-Received: by 2002:a17:906:1b42:b0:a4e:1897:2306 with SMTP id
 p2-20020a1709061b4200b00a4e18972306mr879708ejg.5.1711613487436; 
 Thu, 28 Mar 2024 01:11:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3QncM6ChPJm9SjammzmW+HBUpVFRfklMAzxSnpOfi+tkaB4l1Chd+yPZVcegzGlkt8V2Rbw==
X-Received: by 2002:a17:906:1b42:b0:a4e:1897:2306 with SMTP id
 p2-20020a1709061b4200b00a4e18972306mr879691ejg.5.1711613486866; 
 Thu, 28 Mar 2024 01:11:26 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f0:5969:7af8:be53:dc56:3ccc])
 by smtp.gmail.com with ESMTPSA id
 c7-20020a170906340700b00a468bf8586bsm458449ejb.174.2024.03.28.01.11.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Mar 2024 01:11:26 -0700 (PDT)
Date: Thu, 28 Mar 2024 04:11:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiqian Chen <Jiqian.Chen@amd.com>
Cc: qemu-devel@nongnu.org, Huang Rui <Ray.Huang@amd.com>
Subject: Re: [RFC QEMU PATCH v7 1/1] virtio-pci: implement No_Soft_Reset bit
Message-ID: <20240328034641-mutt-send-email-mst@kernel.org>
References: <20240325070724.574508-1-Jiqian.Chen@amd.com>
 <20240325070724.574508-2-Jiqian.Chen@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325070724.574508-2-Jiqian.Chen@amd.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Mar 25, 2024 at 03:07:24PM +0800, Jiqian Chen wrote:
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
>  hw/virtio/virtio-pci.c         | 38 +++++++++++++++++++++++++++++++++-
>  include/hw/virtio/virtio-pci.h |  5 +++++
>  2 files changed, 42 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index 1a7039fb0c68..daafda315f8c 100644
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
> @@ -2259,18 +2264,47 @@ static void virtio_pci_reset(DeviceState *qdev)
>      }
>  }
>  
> +static bool device_no_need_reset(PCIDevice *dev)


I'd just call it virtio_pci_no_soft_reset() .

> +{
> +    if (pci_is_express(dev)) {

A cleaner way to structure this is by reversing the test:
	if (!pci_is_express(dev)) {
		return false;
	}

I would also check that pm_cap is actually set here.

> +        uint16_t pmcsr;
> +
> +        pmcsr = pci_get_word(dev->config + dev->exp.pm_cap + PCI_PM_CTRL);



> +        /*
> +         * When No_Soft_Reset bit is set and the device
> +         * is in D3hot state, don't reset device
> +         */
> +        if ((pmcsr & PCI_PM_CTRL_NO_SOFT_RESET) &&
> +            (pmcsr & PCI_PM_CTRL_STATE_MASK) == 3) {
> +            return true;

And then here it will be 
	return (pmcsr & PCI_PM_CTRL_NO_SOFT_RESET) &&
		(pmcsr & PCI_PM_CTRL_STATE_MASK) == 3;


> +        }
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
> +    if (device_no_need_reset(dev)) {
> +        return;
> +    }
> +
>      virtio_pci_reset(qdev);
>  
>      if (pci_is_express(dev)) {
> +        uint16_t val = 0;

call it pm_ctrl

> +        VirtIOPCIProxy *proxy = VIRTIO_PCI(dev);
> +
>          pcie_cap_deverr_reset(dev);
>          pcie_cap_lnkctl_reset(dev);
>  
> -        pci_set_word(dev->config + dev->exp.pm_cap + PCI_PM_CTRL, 0);
> +        if (proxy->flags & VIRTIO_PCI_FLAG_PM_NO_SOFT_RESET) {
> +            val |= PCI_PM_CTRL_NO_SOFT_RESET;
> +        }
> +        pci_set_word(dev->config + dev->exp.pm_cap + PCI_PM_CTRL, val);


There is no need to do it like this - only state is writeable
anyway. So simply
	pci_word_test_and_clear_mask(dev->config + dev->exp.pm_cap + PCI_PM_CTRL, PCI_PM_CTRL_STATE_MASK)


maybe we should actually check here:
       if (proxy->flags & VIRTIO_PCI_FLAG_INIT_PM)
there's a chance commit 27ce0f3afc9 broke things for old machines
and we never noticed. If so that should be a separate bugfix patch though.



>      }
>  }
>  
> @@ -2297,6 +2331,8 @@ static Property virtio_pci_properties[] = {
>                      VIRTIO_PCI_FLAG_INIT_LNKCTL_BIT, true),
>      DEFINE_PROP_BIT("x-pcie-pm-init", VirtIOPCIProxy, flags,
>                      VIRTIO_PCI_FLAG_INIT_PM_BIT, true),
> +    DEFINE_PROP_BIT("x-pcie-pm-no-soft-reset", VirtIOPCIProxy, flags,
> +                    VIRTIO_PCI_FLAG_PM_NO_SOFT_RESET_BIT, false),
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


