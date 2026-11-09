Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FD5606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 13:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HRL522g7;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=O3FpcTUW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQP2X-0005Ln-2C; Mon, 09 Nov 2026 08:04:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xQP2R-0005JU-AD
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 08:03:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xQP2M-0001Uk-9e
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 08:03:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794229422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hvSJg7w2TifYeDAmgvrMg9CSlNuhG/srFCat0L4TrkU=;
 b=HRL522g7LYeiuVUeZC/bFJXgXk/QINchTPuf1Rw6YYloMURUUC5vL+2CWdE5Vd74I03Zq0
 GIGxx1i+L/hLC8vSuG1AS6VYoEFmdSUMTUEI14cQPQsH/AORtP0nWygRbIUZhaiQa66A1J
 szEPFthYmMMpsL4Ou83afz038eIS7yA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-cTa6igRhOSaIkzKIr7TNYA-1; Mon, 09 Nov 2026 08:03:41 -0500
X-MC-Unique: cTa6igRhOSaIkzKIr7TNYA-1
X-Mimecast-MFC-AGG-ID: cTa6igRhOSaIkzKIr7TNYA_1794229420
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-c4322d31021so93643266b.3
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 05:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1794229420; x=1794834220; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hvSJg7w2TifYeDAmgvrMg9CSlNuhG/srFCat0L4TrkU=;
 b=O3FpcTUWfcoHZrciUNXVSYD6SX1MFAcBL0cCZ+V3emfRtEKYwGLAyVM8/F+mn+DuYI
 nT3cVr2zePsv3xoyzx9GhP7wd6i9kgevNWoWLjEQrEs0e4FESFsioB4CxQH4dFLmmutP
 JKvU8yfnjgf0WEme2uQtlpVrWLCuCbADuT28uscWZSsc9eEmOz/Nh59D1C5SqDS346CI
 3PhkqA1EyaZaqHNlAAL23o7Lb6AjYuuQnYwtXV+9Rqu6wxrHV/1cqjqDbFS4iylhe/pC
 tLiyBuKz8Ek2BERZPkBupG7bjNK+gvMDZogZ0plwRtW/CpbBIKdAsvxq2Az1Diylf4Hy
 UjYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794229420; x=1794834220;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=hvSJg7w2TifYeDAmgvrMg9CSlNuhG/srFCat0L4TrkU=;
 b=c2n0CjdQlx2Z5QWQJj8uWabmhDl0g27jeUNEldVSPH34wTmJBwcQdoTAczMGcvgi4x
 wdsGIxuPcfS6+yIh77eOW9S4cS9dR33Tvvq3kAtobZIVhdak5hwszJ0+wS7ALdBCFxcG
 UFWkvduLYU5jpwDp6iYH0AIk+swljwxoEPCzv3Inrmowq/XB5hLEzwrETLwOnaTznh3q
 TgpZKZZugd7WtgiCE+XawtPVxpQfaKuqyh13Xh2DYYgwxpavMy3UyY6GmiBY5sNLKuHq
 CRXRg90hJUgfcS4HrHmT8RpOwdBJs2nTM7S3HKzMArGJyqyaHQGgA6tow3OC7LqgtFBO
 mcFg==
X-Gm-Message-State: APuU4Z9gYMyTmXEf3De7CPTi/tqvNPJizOS5p2vPuwFzHZgqANanBSCF
 5YvDZ8w7KjqCE7ma+GyWd3/z2P1eeeQ13d3kT8Mub/Jnou4oSVmasS1kN+zxVRUg9tRgZ0vD3En
 AGXLNbSZLl/eilu7NEaEJYMQVRZVsNBfeGCAqFR17O1r8zi0H6xEHx4TE7o0g9vUNyufAMQ==
X-Gm-Gg: AYBFou2dK6sMdvOF6tPgBEyd5gvSJ5pshXnTGRdz+wBXeNcilV9bppdVUVR9Ut56voE
 u4hR7qsU4O5JGjl5gMSN+mFW0q/LOaXRP7WcvTsD3BhtJkA2zuFwLduUR8UlwpDpZEW611na1wo
 A2Spsi71j5x7QNftwTy+F++JxCpQTGnAjZY74wEektBz1e5gsf8QiARB02nlglWY8zucq3RCziv
 Mxe0EFeHwziVsiaX9kH+FhUK4I7tPmY1ZBmzzVnGDt81KsjuyiKrcDTXV/8M1VyK64yBXM2F6G4
 DBXgRJmkQ0WvcT7Cre8NIb4DvbGDGwjocvaMf6qgv9bHZHqZCiIgyNSd/tBEiFf/P8jMm/8wB5w
 opZ85n3fNRDqvzMOA8xExR6lf7CkUyFjGS3gPMiNB
X-Received: by 2002:a17:906:c110:b0:c41:8e21:4d5a with SMTP id
 a640c23a62f3a-c4d6d168068mr258365766b.5.1794229418360; 
 Mon, 09 Nov 2026 05:03:38 -0800 (PST)
X-Received: by 2002:a17:906:c110:b0:c41:8e21:4d5a with SMTP id
 a640c23a62f3a-c4d6d168068mr258362766b.5.1794229417575; 
 Mon, 09 Nov 2026 05:03:37 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1511:2900:ff37:b35c:a97:952d])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b721ef48fasm1591591a12.34.2026.11.09.05.03.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 05:03:35 -0800 (PST)
Date: Mon, 9 Nov 2026 08:03:32 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>
Subject: Re: [PATCH for-12.0] pcie: Model DLLLA transitions on Secondary Bus
 Reset
Message-ID: <20261109075120-mutt-send-email-mst@kernel.org>
References: <20261109091225.914552-1-clg@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261109091225.914552-1-clg@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Nov 09, 2026 at 10:12:25AM +0100, Cédric Le Goater wrote:
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
>  include/hw/pci/pcie.h |  2 ++
>  hw/pci/pci_bridge.c   | 13 ++++++++++++-
>  hw/pci/pcie.c         | 33 +++++++++++++++++++++++++++++++++
>  3 files changed, 47 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
> index ec25e7a7de99..c362f55f9b58 100644
> --- a/include/hw/pci/pcie.h
> +++ b/include/hw/pci/pcie.h
> @@ -112,6 +112,8 @@ void pcie_cap_slot_get(PCIDevice *dev, uint16_t *slt_ctl, uint16_t *slt_sta);
>  void pcie_cap_slot_write_config(PCIDevice *dev,
>                                  uint16_t old_slt_ctl, uint16_t old_slt_sta,
>                                  uint32_t addr, uint32_t val, int len);
> +void pcie_cap_slot_link_down(PCIDevice *dev);
> +void pcie_cap_slot_link_up(PCIDevice *dev);
>  int pcie_cap_slot_post_load(void *opaque, int version_id);
>  void pcie_cap_slot_push_attention_button(PCIDevice *dev);
>  void pcie_cap_slot_enable_power(PCIDevice *dev);
> diff --git a/hw/pci/pci_bridge.c b/hw/pci/pci_bridge.c
> index e85932e41a92..747d90e1ca46 100644
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
> +            pcie_cap_slot_link_down(d);
> +        }
>          bus_cold_reset(BUS(&s->sec_bus));
>      }
> +
> +    if (oldctl & ~newctl & PCI_BRIDGE_CTL_BUS_RESET) {
> +        /* SBR de-assertion (1->0): bring link back up. */
> +        if (pci_is_express_downstream_port(d)) {
> +            pcie_cap_slot_link_up(d);
> +        }
> +    }
>  }
>  
>  void pci_bridge_disable_base_limit(PCIDevice *dev)
> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> index bd00305ecca6..e89a65eea37b 100644
> --- a/hw/pci/pcie.c
> +++ b/hw/pci/pcie.c
> @@ -803,6 +803,7 @@ void pcie_cap_slot_reset(PCIDevice *dev)
>                                   PCI_EXP_SLTSTA_PDC |
>                                   PCI_EXP_SLTSTA_ABP);
>  
> +    pcie_cap_slot_link_up(dev);
>      pcie_cap_update_power(dev);
>      hotplug_event_update_event_status(dev);
>  }
> @@ -946,6 +947,38 @@ void pcie_cap_slot_push_attention_button(PCIDevice *dev)
>      pcie_cap_slot_event(dev, PCI_EXP_HP_EV_ABP);
>  }
>  
> +/*
> + * PCIe r6.5, sec 7.5.3.8: setting the SBR bit eventually transitions
> + * the port to DL_Down, clearing DLLLA.
> + */
> +void pcie_cap_slot_link_down(PCIDevice *dev)
> +{
> +    assert(pci_is_express_downstream_port(dev));
> +    uint8_t *exp_cap = dev->config + dev->exp.exp_cap;
> +
> +    pci_word_test_and_clear_mask(exp_cap + PCI_EXP_LNKSTA,
> +                                 PCI_EXP_LNKSTA_DLLLA);
> +}
> +
> +/*
> + * PCIe r6.5, sec 7.5.3.8: on SBR de-assertion the link retrains and
> + * DLLLA is re-asserted if a device is still present.
> + */
> +void pcie_cap_slot_link_up(PCIDevice *dev)
> +{
> +    assert(pci_is_express_downstream_port(dev));
> +    PCIBus *sec_bus = pci_bridge_get_sec_bus(PCI_BRIDGE(dev));
> +    uint8_t *exp_cap = dev->config + dev->exp.exp_cap;
> +    uint32_t lnkcap = pci_get_long(exp_cap + PCI_EXP_LNKCAP);
> +
> +    if (sec_bus->devices[0] &&
> +        (dev->cap_present & QEMU_PCIE_LNKSTA_DLLLA ||
> +         (lnkcap & PCI_EXP_LNKCAP_DLLLARC))) {
> +        pci_word_test_and_set_mask(exp_cap + PCI_EXP_LNKSTA,
> +                                   PCI_EXP_LNKSTA_DLLLA);
> +    }
> +}
> +

It would be slightly simpler if we just have a function that
sets DLLLA to the correct value.

Something like (completely untested):


void pcie_cap_update_slot_link(PCIDevice *dev, uint16_t bctl)
{
    PCIBus *sec_bus = pci_bridge_get_sec_bus(PCI_BRIDGE(dev));
    uint8_t *exp_cap = dev->config + dev->exp.exp_cap;
    uint32_t lnkcap = pci_get_long(exp_cap + PCI_EXP_LNKCAP);
    bool link_up = sec_bus->devices[0] &&
        !(bctl & PCI_BRIDGE_CTL_BUS_RESET);

    if (dev->cap_present & QEMU_PCIE_LNKSTA_DLLLA ||
         lnkcap & PCI_EXP_LNKCAP_DLLLARC)
	    pci_set_word_by_mask(exp_cap + PCI_EXP_LNKSTA,
				 PCI_EXP_LNKSTA_DLLLA, link_up);
}

Then we just call it everywhere.


>  /* root control/capabilities/status. PME isn't emulated for now */
>  void pcie_cap_root_init(PCIDevice *dev)
>  {
> -- 
> 2.56.0


