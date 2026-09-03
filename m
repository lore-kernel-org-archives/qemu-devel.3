Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E353C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 19:57:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2DZC-0001ai-Qr; Thu, 03 Sep 2026 15:57:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>) id 1x2DZB-0001aZ-Jq
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 15:57:45 -0400
Received: from fhigh-a7-smtp.messagingengine.com ([103.168.172.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>) id 1x2DZ9-0001nv-CC
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 15:57:45 -0400
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 8EE5D140012F;
 Thu,  3 Sep 2026 15:57:40 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Thu, 03 Sep 2026 15:57:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1788465460;
 x=1788551860; bh=y9HhjDID3MIygSTh9CzK/EFoikTA5uGFAmR/6cmncJ0=; b=
 M58sAHcxJyFR7qA891ZBv9u3vSCjYJlcvBDBNxlnod7cv/dHLWA00aOedJM50/s5
 d2PVlHMb3mlL0EkGML2piw5rjCmrpMEx1NxT7GbEYCdqIOHl3GQ5l9L73B4vG+eU
 13XfDnDEGTcs/u+NYHSkF2a7zwdzNKJNRjwFxZX6bMUG2wsXmd/3B+0qjVEYM/rj
 BMoI0T2G2A8FETd3xyNtS+wGhDzgMLUIJ2JUp06UmKSj205jdFoDtlfQbUAS1Rgi
 7oMjbD9LHCQ0u9gKmZuut6L3YpPr9XCIdmuvh6EFKWVFNvO4nS+xkHbYVblIm6b6
 GsVAQPTQJlFccFf94kLC6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788465460; x=
 1788551860; bh=y9HhjDID3MIygSTh9CzK/EFoikTA5uGFAmR/6cmncJ0=; b=q
 E55Ven6ylsc0gKkarX28HCLMwHhTYSOmjd8x+Gtqg+DueWHsdeDOGK070x4Aa7Y3
 2KNY9fmZfu2a5K3BUpZDV7WxTYubY44eUGMuzk3JXWcNUxaERsKUYQCweLD/w/uH
 13oftPDQdV8/z2b3BDz498duarIrufKPCUhgef4d5gM5PcFwF5oUSZm9WKxdiuSI
 5an/4lBsYyR0GmV/vlbYZlXe8uGXotoEFQMO3y/QLLPBcA+tYq8E/uW4tx73SzjW
 Y4k/FxIYs2/gmJqpLOENH49HjhHrP9G03naU+wm7ROIaI7wT4RRQei8R/1Deyg0f
 CsLb+mqrPWf0Vp4ubKvaw==
X-ME-Sender: <xms:M9GZan9tG3t-D7AF5-BwT4tgHJpsGoz1A1elh4XtERsQ07Ag0-kRmw>
 <xme:M9GZaiy0irCHvhU_1IPDBexbLZL2RbWzQ9g0pUMJgYoOtAk79aAczYA_2Wtnbx1e8
 zwDkOl2rmQeGMqqmkG2GtBaKEA40oYUGIY-oa2m2FQg0IZDmT73oQ>
X-ME-Received: <xmr:M9GZarP8Cp1sZnhF96mISgNDuQYIw7gmJyeJuma3ygh3u3D5mF1QIqfRznWRLw>
X-ME-Proxy-Cause: dmFkZTFdNa99XIfphgU5KWh6IM15t87MRB3EAE2Ivk6C9N4OvHO3yryFQ7y+vFOiSlwbBP
 zcrtUN0qgs6o4YOA4IyPV8N0Ya7gwIwipM+b0RFOylGc40GcqOPLnzOO9ZzwlO/UgrlX+0
 GgvaZSJqqiAkDRkB/6B69aXxaUFzgd+JwZUJBxHOht2d4MVdcl3C+z9qj4DwnSnFxG7mIA
 LsRcITno6CZ5DMNqFA0IrIfdRxvfJ6p7vwvqXvgEFVCaDSW863h1J19dUppMxp+AndrrHN
 f7uZLg+z2RZWQOeJjAwV/oIRtx4AZF0UtIEsKJVORrdRtc2IDfwUf/TtmXg2lM3Vs98GGM
 Ko3pb5q4akrXKZ+t5c/4BNYnAVFAzn3el/PkBD+zsZ2KuSO0bGzyGzOjmGd4QR4nUKlDdj
 1n3uy4GimMJR6/tYaHkbUUJ+SgvH2dvLVY2fRpVf4d9ARrMqDRMrwB3ZdIMeVJFqlFdBrY
 Ovip3aoWqfeDnBNaGtuV1pnYVI09rzhpiUmL5BRNA/cinSyIjHrpRGCZWPhv6mi6WCiWqg
 7doe9cbJWsScJgdhi8wSNrOtGo1z7XOIg01xoMgEYpa1WS5bM9mOLF3AD7x5IJqamySp61
 BOJYMTzUMe2JEIcZZko1qg7lQJ216n2/VYNVr+pgzor89/LjMxaHQrY6k4SQ
X-ME-Proxy: <xmx:M9GZav-Ho2Ct56SrvaE9yEmDvaqDzNuJMLZaHnfaL5YRbN9vcAesjg>
 <xmx:M9GZag6QIrviMudN1U2_DHWZP4sAXRiC3oeEeJhajHFDJxLFwuDINg>
 <xmx:M9GZat7nw4ycJBmTiIPDdbo9BFTcvtvxC8aidV0G6JrhVvtAdZ-ZWA>
 <xmx:M9GZahp-JrmSidwQe1H3PlAGSUghvQ2DYaix1r2aRf6EbgveRSDmwQ>
 <xmx:NNGZagsxRsWNbrjZ_--o-xj3VFxZVbXUHhrK2OcAg4zGSkKnvs_y0kt->
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Sep 2026 15:57:38 -0400 (EDT)
Date: Thu, 3 Sep 2026 13:57:36 -0600
From: Alex Williamson <alex@shazbot.org>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, Jason Wang
 <jasowangio@gmail.com>, Peter Xu <peterx@redhat.com>, alex@shazbot.org
Subject: Re: [RFC PATCH v2 1/9] igb: Add x-vf-migration property and DVSEC
 extended capability
Message-ID: <20260903135736.6b527d04@shazbot.org>
In-Reply-To: <20260902192054.3329753-2-clg@redhat.com>
References: <20260902192054.3329753-1-clg@redhat.com>
 <20260902192054.3329753-2-clg@redhat.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=103.168.172.158; envelope-from=alex@shazbot.org;
 helo=fhigh-a7-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed,  2 Sep 2026 21:20:46 +0200
C=C3=A9dric Le Goater <clg@redhat.com> wrote:

> diff --git a/hw/net/igb_migration.c b/hw/net/igb_migration.c
> new file mode 100644
> index 000000000000..4dfebd82344c
> --- /dev/null
> +++ b/hw/net/igb_migration.c
> @@ -0,0 +1,106 @@
> +/*
> + * QEMU Intel 82576 SR/IOV VF Migration Support
> + *
> + * Copyright (c) 2026 Red Hat, Inc.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/pci/pci_device.h"
> +#include "hw/pci/pcie.h"
> +#include "igb_common.h"
> +#include "igb_migration.h"
> +
> +static void igbvf_mig_update_status(IgbVfState *s, uint8_t err)
> +{
> +    IgbVfMigState *ms =3D &s->mig;
> +    PCIDevice *dev =3D PCI_DEVICE(s);
> +    uint32_t status;
> +
> +    status =3D ms->mig_state & IGB_MIG_STATUS_STATE_MASK;
> +
> +    if (err) {
> +        status =3D IGB_MIG_STATE_ERROR | IGB_MIG_STATUS_ERR(err);
> +    }
> +
> +    pci_set_long(dev->config + IGB_MIG_DVSEC_OFFSET + IGB_MIG_STATUS, st=
atus);
> +}
> +
> +
> +bool igbvf_add_migration_dvsec(PCIDevice *dev, Error **errp)
> +{
> +    uint16_t offset =3D IGB_MIG_DVSEC_OFFSET;
> +    uint32_t caps;
> +
> +    pcie_add_capability(dev, PCI_EXT_CAP_ID_DVSEC, 1, offset,
> +                        IGB_MIG_DVSEC_SIZE);
> +
> +    /* DVSEC header 1: length[31:20] | rev[19:16] | vendor_id[15:0] */
> +    pci_set_long(dev->config + offset + 0x4,
> +                 (IGB_MIG_DVSEC_SIZE << 20) |
> +                 (IGB_MIG_DVSEC_VER << 16) |
> +                 PCI_VENDOR_ID_INTEL);

Let's not co-opt an Intel DVSEC ID, we should use a vendor ID that we
have a claim to, the RedHat/Qumranet one, I'd guess.  We may need to
add DVSEC IDs to the spreadsheet for whoever is tracking Device IDs.
Gerd?

> +
> +    /* DVSEC header 2: DVSEC ID */
> +    pci_set_word(dev->config + offset + 0x8, IGB_MIG_DVSEC_ID);
> +
> +    /* CAPS: features (state migration only) */
> +    caps =3D IGB_MIG_CAP_F_STATE;
> +    pci_set_long(dev->config + offset + IGB_MIG_CAPS, caps);
> +
> +    /* STATUS: initial state is RUNNING */
> +    pci_set_long(dev->config + offset + IGB_MIG_STATUS,
> +                 IGB_MIG_STATE_RUNNING);
> +
> +    /* BUF_ADDR_LO and BUF_ADDR_HI are writable */
> +    memset(dev->wmask + offset + IGB_MIG_BUF_ADDR_LO, 0xff, 4);
> +    memset(dev->wmask + offset + IGB_MIG_BUF_ADDR_HI, 0xff, 4);
> +
> +    return true;
> +}
...
> diff --git a/hw/net/igbvf.c b/hw/net/igbvf.c
> index 9a165c7063ee..30dfdb574ac7 100644
> --- a/hw/net/igbvf.c
> +++ b/hw/net/igbvf.c
> @@ -38,27 +38,21 @@
>   */
> =20
>  #include "qemu/osdep.h"
> +#include "qemu/range.h"
>  #include "hw/core/hw-error.h"
>  #include "hw/net/mii.h"
>  #include "hw/pci/pci_device.h"
>  #include "hw/pci/pcie.h"
> +#include "hw/pci/pcie_sriov.h"
>  #include "hw/pci/msix.h"
>  #include "net/eth.h"
>  #include "net/net.h"
>  #include "igb_common.h"
>  #include "igb_core.h"
> +#include "igb_migration.h"
>  #include "trace.h"
>  #include "qapi/error.h"
> =20
> -OBJECT_DECLARE_SIMPLE_TYPE(IgbVfState, IGBVF)
> -
> -struct IgbVfState {
> -    PCIDevice parent_obj;
> -
> -    MemoryRegion mmio;
> -    MemoryRegion msix;
> -};
> -
>  static hwaddr vf_to_pf_addr(hwaddr addr, uint16_t vfn, bool write)
>  {
>      switch (addr) {
> @@ -199,10 +193,35 @@ static hwaddr vf_to_pf_addr(hwaddr addr, uint16_t v=
fn, bool write)
>      return HWADDR_MAX;
>  }
> =20
> +static bool igbvf_addr_in_dvsec(uint32_t addr, int len)
> +{
> +    return ranges_overlap(addr, len,
> +                          IGB_MIG_DVSEC_OFFSET, IGB_MIG_DVSEC_SIZE);
> +}
> +
> +static uint32_t igbvf_read_config(PCIDevice *dev, uint32_t addr, int siz=
e)
> +{
> +    IgbVfState *s =3D IGBVF(dev);
> +
> +    if (s->migration_enabled && igbvf_addr_in_dvsec(addr, size)) {
> +        return igbvf_mig_config_read(s, addr, size);
> +    }
> +
> +    return pci_default_read_config(dev, addr, size);
> +}
> +
>  static void igbvf_write_config(PCIDevice *dev, uint32_t addr, uint32_t v=
al,
>      int len)
>  {
> +    IgbVfState *s =3D IGBVF(dev);
> +
>      trace_igbvf_write_config(addr, val, len);
> +
> +    if (s->migration_enabled && igbvf_addr_in_dvsec(addr, len)) {
> +        igbvf_mig_config_write(s, addr, val, len);
> +        return;
> +    }
> +
>      pci_default_write_config(dev, addr, val, len);
>      if (object_property_get_bool(OBJECT(pcie_sriov_get_pf(dev)),
>                                   "x-pcie-flr-init", &error_abort)) {
> @@ -282,13 +301,27 @@ static void igbvf_pci_realize(PCIDevice *dev, Error=
 **errp)
>      }
> =20
>      pcie_ari_init(dev, 0x150);
> +
> +    if (object_property_get_bool(OBJECT(pcie_sriov_get_pf(dev)),
> +                                 "x-vf-migration", &error_abort)) {
> +        s->vfn =3D pcie_sriov_vf_number(dev);
> +        s->migration_enabled =3D true;
> +        if (!igbvf_add_migration_dvsec(dev, errp)) {
> +            return;
> +        }

The migration blocker noted later in the docs should be added here.
Trivial to add, avoids the internal migration state being reset by the
L0 VM being migrated, doesn't seem worth extending this driver's VMState
while the feature is experimental.

> +    }
>  }
> =20
>  static void igbvf_qdev_reset_hold(Object *obj, ResetType type)
>  {
>      PCIDevice *vf =3D PCI_DEVICE(obj);
> +    IgbVfState *s =3D IGBVF(vf);
> =20
>      igb_vf_reset(pcie_sriov_get_pf(vf), pcie_sriov_vf_number(vf));
> +
> +    if (s->migration_enabled) {
> +        igbvf_mig_state_reset(s);
> +    }

Hmm, I think reset is more complicated that this.  This seems to define
that any device reset will reset the migration state.  The vfio
migration protocol only defines that a VFIO_DEVICE_RESET returns the
device to running.

Consider the case of an FLR triggered by the L2 guest.  L1 QEMU passes
through the config space write, that lands in vfio-pci core config
space handling in the L1 variant driver, which turns into a
pci_reset_function() in the L1 kernel and I think lands here in the L0
QEMU.  Therefore, it seems like the L2 guest can corrupt the migration
state.

As above, the migration state is defined to be reset via the RESET
ioctl, which also turns into a pci_reset_function() in the L1 kernel.
So L0 QEMU can't tell the difference here.

I think that means that the variant driver itself needs to own this
part of the protocol, performing the migration state housekeeping on
RESET ioctl, while both allow the state to persist on other resets.  In
that sense QEMU cannot emulate this DVSEC as normal config space, it's
a persistent control plane that lives in the VMM and happens to be
accessed through config space.  Thanks,

Alex

>  }
> =20
>  static void igbvf_pci_uninit(PCIDevice *dev)
> @@ -309,6 +342,7 @@ static void igbvf_class_init(ObjectClass *class, cons=
t void *data)
> =20
>      c->realize =3D igbvf_pci_realize;
>      c->exit =3D igbvf_pci_uninit;
> +    c->config_read =3D igbvf_read_config;
>      c->vendor_id =3D PCI_VENDOR_ID_INTEL;
>      c->device_id =3D E1000_DEV_ID_82576_VF;
>      c->revision =3D 1;
> diff --git a/hw/net/meson.build b/hw/net/meson.build
> index 84f142df222a..bb4b449b25ba 100644
> --- a/hw/net/meson.build
> +++ b/hw/net/meson.build
> @@ -11,7 +11,7 @@ system_ss.add(when: 'CONFIG_E1000_PCI', if_true: files(=
'e1000.c', 'e1000x_common
>  system_ss.add(when: 'CONFIG_E1000E_PCI_EXPRESS', if_true: files('net_tx_=
pkt.c', 'net_rx_pkt.c'))
>  system_ss.add(when: 'CONFIG_E1000E_PCI_EXPRESS', if_true: files('e1000e.=
c', 'e1000e_core.c', 'e1000x_common.c'))
>  system_ss.add(when: 'CONFIG_IGB_PCI_EXPRESS', if_true: files('net_tx_pkt=
.c', 'net_rx_pkt.c'))
> -system_ss.add(when: 'CONFIG_IGB_PCI_EXPRESS', if_true: files('igb.c', 'i=
gbvf.c', 'igb_core.c'))
> +system_ss.add(when: 'CONFIG_IGB_PCI_EXPRESS', if_true: files('igb.c', 'i=
gbvf.c', 'igb_core.c', 'igb_migration.c'))
>  system_ss.add(when: 'CONFIG_RTL8139_PCI', if_true: files('rtl8139.c'))
>  system_ss.add(when: 'CONFIG_TULIP', if_true: files('tulip.c'))
>  system_ss.add(when: 'CONFIG_VMXNET3_PCI', if_true: files('net_tx_pkt.c',=
 'net_rx_pkt.c'))


