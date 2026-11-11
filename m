Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B35606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 12:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NrWaTeoa;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Mp6iYK+t
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR7kS-0003Er-Ba; Wed, 11 Nov 2026 07:48:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xR7kI-0003EE-P7
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 07:48:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xR7kG-0003Jj-W1
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 07:48:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794401287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jY6f3TYO7wKGr0AnuudA7ADnOrmDt1vykQdZJekbSnI=;
 b=NrWaTeoajzln7+u2QDMGvweqHfT/02n8KLO5h9y5JSsCmC2wDzHitX5lMQvsNK6ZeWGWf6
 oeG6EJsQ/RZNf9r2pzo5NtIiYxbvow9J4NcGOyzJ9qNZEQd9cNIlNRBOoONnXUTlCcC1zM
 LLZbDT6I09n6dU0It60d7ItHbx95XNg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-mRiYxrzjMXCtA7BVEYsVCQ-1; Wed, 11 Nov 2026 07:48:06 -0500
X-MC-Unique: mRiYxrzjMXCtA7BVEYsVCQ-1
X-Mimecast-MFC-AGG-ID: mRiYxrzjMXCtA7BVEYsVCQ_1794401285
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-49034831bb3so2770433f8f.1
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 04:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1794401285; x=1795006085; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jY6f3TYO7wKGr0AnuudA7ADnOrmDt1vykQdZJekbSnI=;
 b=Mp6iYK+tOuBSuttmLE8HonT/ZABQ+PvJtCQ53Mi5kc8H55mzQsVafmse1BhNJLM7og
 rpkzdsmPFysuVO+9vWlSzJ7JM8z++rvJnrXAJ5gFQeahh1MdMlesFGNq3ky4jklIamfh
 mLDPEXiAZ9bhNr8X0qhCrfrj4o4eVYPQh8TB5/MeXsCdUHURGJu1ins2rDupSO3hN2gZ
 PLdNP6awE2wh5UjlVRmbfQtf+VUuF/PFL5x/z/Ocoj0Wz2mNtX8Xng/Twsk3g1ggCNcr
 v7cnCOt//5MnpKd+i1oPfHYxwkSdxL+Fgs58huHZWtJFmF25fnPaqna/iY9CZ3SAxP4l
 pQMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794401285; x=1795006085;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jY6f3TYO7wKGr0AnuudA7ADnOrmDt1vykQdZJekbSnI=;
 b=jqrH+7ryqoaUZ/pEBMsjBBw+X5mzeUj7aM1vfRANWVpCsyLZq17WaymoVnvSG2U5PN
 cncm+GCEE+1TlWGpi/IxQoFEDJTRsdWaFX6kQRkiZrYNqhAN3PaT7AF/Jb3d8e4+8Cjf
 HQuZ8BK9nW+uY7f7wrFpZTvGGdLEjO4qe9LiLLLANjtZZhD4GrwNFTAFGzf9+p+IzArb
 nR6oZ7IvdyiFEmG4zIx1mahcpUCEGuc6/lgQ2O9VS397wxfsUJcbMvEI96TjPMsvG8He
 vv/dM2C6DHOGv5OmgqsUsFvEDdcIkvtKCNl4zo6BsDkZQZdSE1wGgpDkd3Sm+8jnsUHK
 O9OA==
X-Gm-Message-State: APuU4Z/NEeP4uNA0rL8W+NwMuHss0MfaE2MNlBIJ8KaAHMVMMwEdThEo
 JA8+zobsx+ekX5a3cgrCFPIW3wD6vxJ9jsCzFdoAuB0ruX+CyWfg9q4FWWt3JK9aDf9E6Zi85eQ
 4WZWM/xYc38PIOtgmkX00dIERTGjNKwlqAVqDAZS+RLWIvGsGDIHcrxP3
X-Gm-Gg: AYBFou36BENZ2DrE604m9NUhBVNfqRSzRSV/c+LE2Nhpe5K0tnm1m706BrIlk+6ZKZX
 r67xV35jgzg9GHrJqX0lHpVa9+fjISAtGkfe5RNIjWO9ZJ01vcjsNnY0r01VboIDoeuhOx4TeA2
 RR4V4D+QQYfEBeW978cbSJd5K/2Mhsw78/BUTRCL25qm5VZbLamtovCkDJQN3SvJXYkCL1dOFLj
 lt3nZTjfY3TOop2hHwbImayldetScMsKLMF6jUsaOpI5p08R1iP+0rS/Wvur1CE2/FwQQhynN0P
 6l5d3IHtfnWA3uVo4y0pRD2fCHe8owox8ZUu2YvZBc1hC9CnJyAfOxLT0pN/g+KVd5KX3Peodmj
 Sd1ZbWiKelM6C/OF3WRXvI0Cz1uPAJMvCZJdxRDgdeg==
X-Received: by 2002:a05:600c:8708:b0:4a7:c366:d791 with SMTP id
 5b1f17b1804b1-4ba0931c364mr37903615e9.1.1794401284591; 
 Wed, 11 Nov 2026 04:48:04 -0800 (PST)
X-Received: by 2002:a05:600c:8708:b0:4a7:c366:d791 with SMTP id
 5b1f17b1804b1-4ba0931c364mr37903115e9.1.1794401284012; 
 Wed, 11 Nov 2026 04:48:04 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1511:2900:ff37:b35c:a97:952d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba0204785dsm144206585e9.9.2026.11.11.04.48.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 04:48:03 -0800 (PST)
Date: Wed, 11 Nov 2026 07:48:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>
Subject: Re: [PATCH for-12.0 v2] pcie: Model DLLLA transitions on Secondary
 Bus Reset
Message-ID: <20261111074653-mutt-send-email-mst@kernel.org>
References: <20261110060205.1147027-1-clg@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261110060205.1147027-1-clg@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 10, 2026 at 07:02:04AM +0100, Cédric Le Goater wrote:
> Per PCIe r6.5 sec 6.6.1 and 7.5.3.8, setting the Secondary Bus Reset
> bit on a downstream port drives the Data Link Layer to DL_Down,
> clearing the Data Link Layer Link Active bit (DLLLA). On de-assertion
> the link retrains and DLLLA is re-asserted.
> 
> Currently DLLLA is only managed during plug/unplug events, so a
> guest sees stale DLLLA=1 while SBR is in progress.
> 
> Handle both SBR transitions in pci_bridge_write_config(), the common
> config write path for all bridge types, guarded by
> pci_is_express_downstream_port(). Also restore DLLLA in
> pcie_cap_slot_reset() so that a system reset while SBR is asserted
> does not leave DLLLA stuck at 0.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>  include/hw/pci/pcie.h |  1 +
>  hw/pci/pci_bridge.c   | 13 ++++++++++++-
>  hw/pci/pcie.c         | 20 ++++++++++++++++++++
>  3 files changed, 33 insertions(+), 1 deletion(-)
> 
>  Changes in v2 :
> 
>  - Introduced pcie_cap_update_slot_link() as suggested by Michael.
> 
> diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
> index ec25e7a7de99..50fbbacb2200 100644
> --- a/include/hw/pci/pcie.h
> +++ b/include/hw/pci/pcie.h
> @@ -112,6 +112,7 @@ void pcie_cap_slot_get(PCIDevice *dev, uint16_t *slt_ctl, uint16_t *slt_sta);
>  void pcie_cap_slot_write_config(PCIDevice *dev,
>                                  uint16_t old_slt_ctl, uint16_t old_slt_sta,
>                                  uint32_t addr, uint32_t val, int len);
> +void pcie_cap_update_slot_link(PCIDevice *dev, uint16_t bctl);
>  int pcie_cap_slot_post_load(void *opaque, int version_id);
>  void pcie_cap_slot_push_attention_button(PCIDevice *dev);
>  void pcie_cap_slot_enable_power(PCIDevice *dev);
> diff --git a/hw/pci/pci_bridge.c b/hw/pci/pci_bridge.c
> index e85932e41a92..a11cf2f20afa 100644
> --- a/hw/pci/pci_bridge.c
> +++ b/hw/pci/pci_bridge.c
> @@ -33,6 +33,7 @@
>  #include "qemu/units.h"
>  #include "hw/pci/pci_bridge.h"
>  #include "hw/pci/pci_bus.h"
> +#include "hw/pci/pcie.h"
>  #include "qemu/module.h"
>  #include "qemu/range.h"
>  #include "qapi/error.h"
> @@ -274,9 +275,19 @@ void pci_bridge_write_config(PCIDevice *d,
>  
>      newctl = pci_get_word(d->config + PCI_BRIDGE_CONTROL);
>      if (~oldctl & newctl & PCI_BRIDGE_CTL_BUS_RESET) {
> -        /* Trigger hot reset on 0->1 transition. */
> +        /* SBR assertion (0->1): bring link down, then reset devices. */
> +        if (pci_is_express_downstream_port(d)) {
> +            pcie_cap_update_slot_link(d, newctl);
> +        }
>          bus_cold_reset(BUS(&s->sec_bus));
>      }
> +
> +    if (oldctl & ~newctl & PCI_BRIDGE_CTL_BUS_RESET) {
> +        /* SBR de-assertion (1->0): bring link back up. */
> +        if (pci_is_express_downstream_port(d)) {
> +            pcie_cap_update_slot_link(d, newctl);
> +        }
> +    }
>  }
>  
>  void pci_bridge_disable_base_limit(PCIDevice *dev)


I'd rather call it once, unconditionally: it's idempotent.

Or if you really want:
	if ((oldctl ^ newctl) & PCI_BRIDGE_CTL_BUS_RESET)


> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> index bd00305ecca6..3b6dcd15aa44 100644
> --- a/hw/pci/pcie.c
> +++ b/hw/pci/pcie.c
> @@ -803,6 +803,8 @@ void pcie_cap_slot_reset(PCIDevice *dev)
>                                   PCI_EXP_SLTSTA_PDC |
>                                   PCI_EXP_SLTSTA_ABP);
>  
> +    pcie_cap_update_slot_link(dev,
> +                              pci_get_word(dev->config + PCI_BRIDGE_CONTROL));
>      pcie_cap_update_power(dev);
>      hotplug_event_update_event_status(dev);
>  }
> @@ -946,6 +948,24 @@ void pcie_cap_slot_push_attention_button(PCIDevice *dev)
>      pcie_cap_slot_event(dev, PCI_EXP_HP_EV_ABP);
>  }
>  
> +/*
> + * Set DLLLA to reflect the actual link state: up iff a device is
> + * present on the secondary bus and SBR is not asserted.
> + */
> +void pcie_cap_update_slot_link(PCIDevice *dev, uint16_t bctl)
> +{
> +    PCIBus *sec_bus = pci_bridge_get_sec_bus(PCI_BRIDGE(dev));
> +    uint8_t *exp_cap = dev->config + dev->exp.exp_cap;
> +    uint32_t lnkcap = pci_get_long(exp_cap + PCI_EXP_LNKCAP);
> +    bool link_up = sec_bus->devices[0] && !(bctl & PCI_BRIDGE_CTL_BUS_RESET);
> +
> +    if (dev->cap_present & QEMU_PCIE_LNKSTA_DLLLA ||
> +        (lnkcap & PCI_EXP_LNKCAP_DLLLARC)) {
> +        pci_set_word_by_mask(exp_cap + PCI_EXP_LNKSTA,
> +                             PCI_EXP_LNKSTA_DLLLA, link_up);
> +    }
> +}
> +
>  /* root control/capabilities/status. PME isn't emulated for now */
>  void pcie_cap_root_init(PCIDevice *dev)
>  {
> -- 
> 2.56.0


