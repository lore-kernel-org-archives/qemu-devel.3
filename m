Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE6A1CD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 18:46:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZYo0-0005Z1-0C; Tue, 16 Jun 2026 14:46:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>) id 1wZYnu-0005Wd-Dr
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 14:46:33 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>) id 1wZYnp-0001Ul-Eb
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 14:46:27 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 64A70600AB;
 Tue, 16 Jun 2026 18:46:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07FDA1F000E9;
 Tue, 16 Jun 2026 18:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781635584;
 bh=bxkRjBuLQ0Zqo2JG7wtIZXNuW/9rXa7UeVCDeoroQGg=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=JO+xc/wYmK/g2IQDtLOnTV6z5c8+xuaB5uGwg8D8mH1so1/HZkXCm7cNaUjl+1Mkl
 NX2SSOf6n/GUSnub7H6eK+Jj6kh4dofqvc3WD4+HBGXx8KoRlmiUoQjwv3zZ4cwPPy
 zM1P5KVkW+zENyngxB8q1Ki1EuwiylU6tRHDirrOFYEvHo7qEi+APzkF3KiMKvnG1j
 KfD9BYbOdZxFd1hMGeqHmkF7aK6dJGXHaI3JZcDWXR/JgPoiF6ooGFnvHRR4zLIQFL
 9hW6UdTyJ4fht1Cb/GzdjjBeeEzjbd/DTx26+PJiIWG33D9U1Ci/E/4n60ngGlEemK
 5SUP8Xhthm7gg==
Date: Tue, 16 Jun 2026 19:46:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Shrihari E S <shrihari.s@samsung.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
 qemu-devel@nongnu.org, cpgs@samsung.com, arun.george@samsung.com,
 vikash.k5@samsung.com, s.neeraj@samsung.com, dongjoo.seo1@samsung.com,
 dave@stgolabs.net, gost.dev@samsung.com
Subject: Re: [RFC 6/8] hw/pci: Add PCIe Streamlined Virtual Channel (SVC)
 capability.
Message-ID: <20260616194619.47336bac@jic23-huawei>
In-Reply-To: <20260609105836.3702787-7-shrihari.s@samsung.com>
References: <20260609105836.3702787-1-shrihari.s@samsung.com>
 <CGME20260609104528epcas5p4b7379fbb5bcc8ee74461a039e88b1637@epcas5p4.samsung.com>
 <20260609105836.3702787-7-shrihari.s@samsung.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=jic23@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue,  9 Jun 2026 16:28:34 +0530
Shrihari E S <shrihari.s@samsung.com> wrote:

> From: Dongjoo Seo <dongjoo.seo1@samsung.com>
> 
> Implement the PCIe Streamlined Virtual Channel (SVC) Extended
> Capability by adding support of capability, control and status
> registers per PCIe 6.4 section 7.9.29. This capability is one
> of the main requisites for UIO support in both PCIe and CXL ports.
> 
> Key changes include:
>     - New pcie_svc.c file for SVC capability management.
>     - Updated pcie_cap_fill_lnk() to handle flitmode signaling.
>     - Implement Lifecycle hooks (reset and config_write) to manage
>       SVC state.
> 
> Signed-off-by: Dongjoo Seo <dongjoo.seo1@samsung.com>
> Signed-off-by: Shrihari E S <shrihari.s@samsung.com>
A very quick review on this one as I'm more or less out of time for today
(and not listening to a call ;)

> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 5996229c81..0469250f42 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c

>  /***********************************************************/
> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> index d452199d85..7c7d948e00 100644
> --- a/hw/pci/pcie.c
> +++ b/hw/pci/pcie.c
> @@ -112,8 +112,9 @@ pcie_cap_v1_fill(PCIDevice *dev, uint8_t port, uint8_t type, uint8_t version)
>  }
>  
>  /* Includes setting the target speed default */
> -static void pcie_cap_fill_lnk(uint8_t *exp_cap, PCIExpLinkWidth width,
> -                              PCIExpLinkSpeed speed, bool flitmode)
> +static void pcie_cap_fill_lnk(PCIDevice *dev, uint8_t *exp_cap,
> +                              PCIExpLinkWidth width, PCIExpLinkSpeed speed,
> +                              bool flitmode)
>  {
>      /* Clear and fill LNKCAP from what was configured above */
>      pci_long_test_and_clear_mask(exp_cap + PCI_EXP_LNKCAP,
> @@ -160,8 +161,14 @@ static void pcie_cap_fill_lnk(uint8_t *exp_cap, PCIExpLinkWidth width,
>      }
>  
>      if (flitmode) {
> -        pci_long_test_and_set_mask(exp_cap + PCI_EXP_LNKSTA2,
> +        uint32_t pos = dev->exp.exp_cap;
> +
> +        pci_word_test_and_set_mask(exp_cap + PCI_EXP_FLAGS,
>                                     PCI_EXP_LNKSTA2_FLIT);

Why is this writing a field from LNKSTA2 into FLAGS?

> +        pci_word_test_and_set_mask(exp_cap + PCI_EXP_FLAGS,
> +                                   PCI_EXP_FLAGS_FLIT);
> +        pci_word_test_and_set_mask(dev->wmask + pos + PCI_EXP_LNKCTL,
> +                                   PCI_EXP_LNKCTL_FLIT_DIS);
>      }
>  }
>  

>  static void pcie_cap_fill_slot_lnk(PCIDevice *dev)
>  {
>      PCIESlot *s = (PCIESlot *)object_dynamic_cast(OBJECT(dev), TYPE_PCIE_SLOT);
> @@ -217,7 +259,8 @@ static void pcie_cap_fill_slot_lnk(PCIDevice *dev)
>          /* the PCI_EXP_LNKSTA_DLLLA will be set in the hotplug function */
>      }
>  
> -    pcie_cap_fill_lnk(exp_cap, s->width, s->speed, s->parent_obj.flitmode);
> +    pcie_cap_fill_lnk(dev, exp_cap, s->width, s->speed,
> +                      s->parent_obj.flitmode);

As previously I think that should be a PCIE_PORT(s)->flitmode

>  }
>  
>  int pcie_cap_init(PCIDevice *dev, uint8_t offset,
> diff --git a/hw/pci/pcie_svc.c b/hw/pci/pcie_svc.c
> new file mode 100644
> index 0000000000..84db73de58
> --- /dev/null
> +++ b/hw/pci/pcie_svc.c
> @@ -0,0 +1,164 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * PCIe Streamlined Virtual Channel (SVC) Extended Capability
> + *
> + * Copyright (c) 2026 Samsung Electronics Co., Ltd.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/bitops.h"
> +#include "hw/pci/pci_device.h"
> +#include "hw/pci/pcie.h"
> +#include "hw/pci/pcie_svc.h"
> +#include "hw/pci/pcie_port.h"
> +
> +static void pcie_svc_update_map(PCIDevice *dev)
> +{
> +    uint32_t non_uio_ctrl = SVC_VC0_PROTOCOL | SVC_VC_ENABLE;
> +    uint32_t uio_ctrl = SVC_UIO_PROTOCOL_SELECTED | SVC_VC_ENABLE;
> +    int offset;
> +
> +    if (!pci_is_express(dev) || !dev->exp.svc_cap) {
> +        return;
> +    }
> +
> +    offset = pcie_find_capability(dev, PCI_EXT_CAP_ID_SVC);
> +
> +    /* SVC VC0 & VC3 initialization */
> +    pci_set_long(dev->config + offset + SVC_RES_CTRL(0), BIT(0) | non_uio_ctrl);
> +    pci_set_long(dev->config + offset + SVC_RES_CTRL(3), BIT(3) | uio_ctrl);
> +
> +    /* SVC VC4 initialization - optional */
> +    if (dev->exp.svc.uio_opt_svc) {
> +        pci_set_long(dev->config + offset + SVC_RES_CTRL(4), BIT(4) | uio_ctrl);
> +    }
> +}
> +
> +int pcie_config_uio_svc(PCIDevice *d, Error **errp)
> +{
> +    PCIEPort *p = PCIE_PORT(d);
> +
> +    if (!get_uio_mandatory_svc(p)
> +        || pcie_svc_cap_init(d, PCI_EXT_CAP_BASE_OFFSET, errp) < 0) {

|| on the line above

> +        return -1;
> +    }
> +
> +    if (get_uio_optional_svc(p)) {
> +        pcie_svc_set_vc4(d, true);
> +    }
> +
> +    return 0;
> +}
> +
> +int pcie_svc_cap_init(PCIDevice *dev, uint16_t offset, Error **errp)
> +{
> +    uint32_t hdr;
> +
> +    if (!pci_is_express(dev)) {
> +        error_setg(errp, "SVC ECAP requires PCIe");
> +        return -EINVAL;
> +    }
> +
> +    /*
> +     * If no other ECAPs are present, make SVC the first at 0x100.
> +     * This avoids pcie_add_capability() asserting on a non-0x100 offset.
> +     */
> +    hdr = pci_get_long(dev->config + PCI_CONFIG_SPACE_SIZE);

Is there precedence for this?  Seems like most cases hand code
an offset. I think letting this run has the risk that an ordering
change might end up with this where something else wants to go.

> +    if (hdr == 0) {
> +        offset = PCI_CONFIG_SPACE_SIZE;
> +    }


>  void pcie_cap_slot_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
>                                 Error **errp);
> diff --git a/include/hw/pci/pcie_regs.h b/include/hw/pci/pcie_regs.h
> index 33a22229fe..644da744b2 100644
> --- a/include/hw/pci/pcie_regs.h
> +++ b/include/hw/pci/pcie_regs.h
> @@ -81,6 +81,7 @@ typedef enum PCIExpLinkWidth {
>  #define PCI_EXP_DEVCAP2_EETLPP          0x200000
>  
>  #define PCI_EXP_DEVCTL2_EETLPPB         0x8000
> +#define  PCI_EXP_LNKCTL_FLIT_DIS        0x2000

This extra indent is supposed to associate the field with the register
but the register isn't defined here so it makes little sense.


>  
I see there is some precedence in here for registers that are also defined
in the linux header that is included via hw/pci/pci_regs.h

Maybe we should clean that up a t somepoint.

>  /* ARI */
>  #define PCI_ARI_VER                     1
> diff --git a/include/hw/pci/pcie_svc.h b/include/hw/pci/pcie_svc.h
> new file mode 100644
> index 0000000000..4872905501
> --- /dev/null
> +++ b/include/hw/pci/pcie_svc.h
> @@ -0,0 +1,91 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * PCIe Streamlined Virtual Channel (SVC) Extended Capability
> + *
> + * Copyright (c) 2026 Samsung Electronics Co., Ltd.
> + */
> +
> +#ifndef HW_PCIE_SVC_H
> +#define HW_PCIE_SVC_H

Much of this feels like it will end up in pci_regs.h
so maybe just do that from the start.

For this series you'd have to have a patch adding them with
a note on when you expect them to be in the linux header.

> +
> +#include "hw/pci/pci.h"
> +#include "qemu/bitops.h"
> +
> +/*
> + * The PCIe config space starts from 0x00 till 0xFF. In that
> + * extended capability starts from 0x100 and each extended capability
> + * is of dword size (32 bit). So we have to give a proper base offset
> + * value which should be >= 0x100 and <= 0xFF and in between other
> + * capability will also be registerd. We might not know where exactly
> + * SVC extended capability will sit, so to avoid the overlapping we have
> + * to give a very high offset.
> + */
> +#define PCI_EXT_CAP_BASE_OFFSET                0x200
> +#define PCI_EXT_CAP_ID_SVC                     0x35
> +#define PCI_EXT_CAP_SVC_SIZE                   0x74
> +
> +/* PCIe 6.4 section 7.9.29 */
> +#define PCIE_SVC_CAP_HEAD_OFFSET               0x00
> +#define PCIE_SVC_CAP_OFFSET                    0x04

> +#define SVC_TC_VC_MAP(n)                       ((n & 0xff) << 0)
> +
> +/* 7.9.27.8 SVC Resource Status Register */
> +#define SVC_RES_STATUS_BASE                    0x1c
> +#define SVC_RES_STATUS(n)                      (SVC_RES_STATUS_BASE + \
> +                                                (n) * 0x0c)

That's not a nice line break for readabilty. If you have two, move the whole thing to next line.

> +#define SVC_VC_NEGO                            BIT(1)


