Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC0A606A31B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 09:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=vTKKfbTr
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKBqC-0001IQ-5d; Fri, 23 Oct 2026 05:45:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKBq2-0001FJ-68
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 05:45:27 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKBpz-0000N3-OK
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 05:45:25 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-8b0db268bd8so4598647b3.1
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 02:45:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792748722; cv=none;
 d=google.com; s=arc-20260327;
 b=lE0C38f1frHLiukMMxfF4pRKqZl6lBzb3Ii+V5yJAvRIKINO+G8CJbVEk/gBWy5MWW
 qSiL9paTStxn3z4KnOLal/Fl5qXgNIynPkHylChrobuuOGUwu+PRfT5P7mHkG9qtOBh+
 eFEN8cl5onSYAI2JtHqUpHAz/eb/qWps9avSqHxouou6/QJNmt6wzO8+Lt3J0TrlmBol
 vpR5SzRQze/1A4dsInY/ZcfX0Xo84UvxVuL4a0m/3tN7Y4BOII51QI5lwvQHV1Nh+GkC
 6ZVQKIzjsu5KElkyzLuvwdk7kswdg4MfUbQj6/R6RD7GHxcFkLqJJB39GaX9EzYUyPDD
 BaGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=8BrR+Pio7CCCB9+nG0fX38QnEWHzzc0u3B4EIvqfUK8=;
 fh=XTTVB6ywah99SChND1zlNweUq8YqXd4UiqbWz1Dd4iI=;
 b=Z0J1jhf6TUZJ7mdfyf2TheMelcUOFRtAt6bcV+lA5AoFi0pZd1OAO7962BdmWUbdXl
 t7t4pq5rrGijyjzZJWiMJbfctgcl1HYlUV1ml9Q7Qd7NaTVbbgSCrqBw09K6no3FoxDN
 bGBlOBRkH1Mb9HR1Lj/NVvs6/9BcKqCur3QEyNC2SIVgFaijF0L31kDTNGdgLA43kl0W
 ucUTFnOSrCOAVll+2iBK0NdHsDqyJMEhl+gtYioCFmw0n5a/1kQRG+00+8Dky2b4o/B9
 6lci9TGoMUCvfrzDsrCTM/oENQyyzHwLEy5uAv1Cs+hLHwvb+BfDaxf3MnW3HdV5GRQv
 s0Hg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792748722; x=1793353522; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=8BrR+Pio7CCCB9+nG0fX38QnEWHzzc0u3B4EIvqfUK8=;
 b=vTKKfbTrqp54LEH1n7KoguSzh79qgLupkE+/hVDJiQwsYwJf7LoKp/RThBFZ19Y51A
 duXBIqc+X5cjGggjWvQFv6R5sYSgPfAFW3Aod9h5sBKlD6ZTj9XlKMatN/MdJI5thL08
 Ncg6K6yM93j31mQ4pGWTrDLW8iml5N85G288BodAemmFSdO3E9uo2PUCTgJTjks6u3ij
 25bDzB2KxVqcOML+y02RXIyR3/YMxITUkHpefsueGPDGsvkgtMUzMBovwRZ6KDOQetwZ
 js1J7TfNfUZs2REzWV6JJEg+v7PSWymqkqu9fAk1PMSc4cirx8Xgrlhm2Ieir3CozSgp
 mscA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792748722; x=1793353522;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=8BrR+Pio7CCCB9+nG0fX38QnEWHzzc0u3B4EIvqfUK8=;
 b=ULgGJpZ54TbsIb7MwYsY0lorz5r63u6PPcHsB9VAPrnzao146GdUAfewYv0BiGyhPX
 UHTUoN9Uoc82aFGjgjY4nsv0gunZIV20qXnzbF0KR2zQtvx2LjQwDkQJT/dLcjEgZyhm
 kaPjqeAR9y+ckS7Suo7HvP8+4cM/9KqiZuquVMt/gOoe6VXvGk4dKVl50U6qiJIWY9lh
 E0vdSW5OrsQ/u1fLYwuI6CIuj4uwYkKpit15kFICWpQUncEYN/PLdmOE/n0qiwUaFdWj
 Ucv1HobnQoEsPmmm8FFhj0TGOQRYsWXhEAg6LCEJLGitoOLve4zDwLoik3449yt41A9y
 X5iQ==
X-Gm-Message-State: AFq9FYKaQqFvmalqIbLz/SKzN9mkWTddI0GDRQ+8hopeiUbYCu2UkG+A
 h4kVawNJ0JqUdVTiqUeSPrc9CRT3KgZ9ZGr4bdJ9Avuymd3l3O3POv3ax0du47lOZ9HnGr8sLcX
 oEO6MG1m72AlB+n2LjVQ5NJU6eb2Zx2sbAfVvz1HCSw==
X-Gm-Gg: AYBFou0LZNq2YP+00qmmlpbqHYohu98v+CrdAM7Uhr2ZgZ0fnWWtxNkAoRU8BEYTJXU
 D+Hpx8SltRutDIFMtmnCYB5UKz3AgoRvHCWelBAlYOijKopNYifv35pwKuqG/dhcD9s0S6T0rc9
 ZLVFHbOWIk4dNsRWXNBaghkMfw5U97DDr1sKtGTIo/QPec6p7o8X9qvXvNGog8mwoFniTLV9ehS
 EqXxqa2HYzG5hjCqvm1UbCjpFQP064VvhSKCLcrf9pnMDZ2e/inCfKGXYq8yapkyJiXL8Ci6W1P
 pd3w4PXAEPO2KZRDIfz1/nMEiyTd4tKHZD0C4H9A/LI3QNAUZxyGjMatS6WtTXEz5E3DNM9Pmhe
 lOrdu3fyFGDRsLLU/tfRq6jB4iSfsGcLRiFcw49k1vyw2buiO+mFT/8EAnDG0rh1v09a4wg4NYP
 In1IZNv2D1+CjCYhJclkIK
X-Received: by 2002:a05:690c:c50d:b0:8ac:d426:105a with SMTP id
 00721157ae682-8b157e4d3b4mr12869287b3.39.1792748721939; Fri, 23 Oct 2026
 02:45:21 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261018133603.64323-1-marcelomanzo@gmail.com>
 <20261018133603.64323-3-marcelomanzo@gmail.com>
In-Reply-To: <20261018133603.64323-3-marcelomanzo@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Oct 2026 10:45:09 +0100
X-Gm-Features: AclHuK-UH5wkoGl837263GRxcCg4DEQ4oFndjr8EAGLeBe5rgv57El8M5Ptlhwc
Message-ID: <CAFEAcA8YjohpfajDVg9XRmmsHB_VOzfSHEe-pq+6L5W+jypudg@mail.gmail.com>
Subject: Re: [PATCH v4 02/17] hw/arm/bcm2838_pcie: add BCM2838 PCIe host
To: Marcelo Manzo <marcelomanzo@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, philmd@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, 18 Oct 2026 at 14:36, Marcelo Manzo <marcelomanzo@gmail.com> wrote:
>
> Add the BCM2838 PCIe host bridge model: config space, MMIO window,
> and register access for the root port.
>
> Per Peter Maydell's review of a later follow-up series, fold in what
> was originally a separate bugfix here, since this device isn't in
> upstream git yet and the bug was in code this patch itself introduces.
> Four defects fixed, all on the enumeration path (none of this was
> exercised until a later patch actually attaches a PCI device):
>
> 1. bcm2838_pcie_host_read/write computed
>    "offset - PCIE_CONFIG_SPACE_SIZE" on an unsigned hwaddr, which
>    underflows for every offset below 4KB. The root port's own config
>    space -- including vendor/device ID at offset 0 -- therefore always
>    fell into the out-of-range branch and read back as all-ones, i.e.
>    "no device present", so the guest stopped scanning immediately.
>
> 2. pcie_host_mmcfg_init() was never called, yet both accessors
>    dereference pcie_hb->mmio.ops to service EXT_CFG_DATA. Once (1) was
>    fixed and the guest actually reached that path, it touched an
>    uninitialised MemoryRegion.
>
> 3. The root port overrode PCIDeviceClass::config_read/config_write with
>    plain pci_default_*_config(). That bypasses rp_write_config() ->
>    pci_bridge_write_config(), so programming the bridge's memory window
>    never updated the bridge's address space and BARs behind the root
>    port stayed unreachable. Drop the overrides and dispatch through
>    pci_host_config_{read,write}_common() so the device's real handlers
>    run.
>
> Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
> ---
>  hw/arm/bcm2838_pcie.c         | 208 ++++++++++++++++++++++++++++++++++
>  hw/arm/trace-events           |   4 +
>  include/hw/arm/bcm2838_pcie.h |  19 ++++
>  3 files changed, 231 insertions(+)
>
> diff --git a/hw/arm/bcm2838_pcie.c b/hw/arm/bcm2838_pcie.c
> index 1ebb05657b..04d976f1d0 100644
> --- a/hw/arm/bcm2838_pcie.c
> +++ b/hw/arm/bcm2838_pcie.c
> @@ -11,6 +11,7 @@
>  #include "qapi/error.h"
>  #include "hw/core/irq.h"
>  #include "hw/pci-host/gpex.h"
> +#include "hw/pci/pci_host.h"
>  #include "hw/core/qdev-properties.h"
>  #include "migration/vmstate.h"
>  #include "qemu/module.h"
> @@ -19,6 +20,212 @@
>  #include "hw/arm/bcm2838_pcie.h"
>  #include "trace.h"
>
> +/*
> + * The register bytes in root_port.regs[] are little-endian whatever the host
> + * is, so access them with the ld*_le_p()/st*_le_p() helpers.
> + */
> +static uint32_t bcm2838_pcie_ext_cfg_index(const uint8_t *root_regs)
> +{
> +    return ldl_le_p(root_regs + BCM2838_PCIE_EXT_CFG_INDEX
> +                    - PCIE_CONFIG_SPACE_SIZE);
> +}
> +
> +static uint64_t bcm2838_pcie_host_read(void *opaque, hwaddr offset,
> +                                       unsigned size) {
> +    hwaddr mmcfg_addr;
> +    uint64_t value = ~0;
> +    BCM2838PcieHostState *s = opaque;
> +    PCIExpressHost *pcie_hb = PCIE_HOST_BRIDGE(s);
> +    uint8_t *root_regs = s->root_port.regs;
> +
> +    if (offset < PCIE_CONFIG_SPACE_SIZE) {
> +        /*
> +         * The first 4KB of the window is the root port's own PCI config
> +         * space (vendor/device ID, BARs, capabilities). Serve it from the
> +         * real PCIDevice, not from the raw regs[] shadow buffer, which is
> +         * only backing store for the controller registers above 4KB.
> +         */
> +        value = pci_host_config_read_common(PCI_DEVICE(&s->root_port),
> +                                            offset, PCIE_CONFIG_SPACE_SIZE,
> +                                            size);
> +    } else if (offset - PCIE_CONFIG_SPACE_SIZE + size
> +               <= sizeof(s->root_port.regs)) {
> +        switch (offset) {
> +        case BCM2838_PCIE_EXT_CFG_DATA
> +            ... BCM2838_PCIE_EXT_CFG_DATA + PCIE_CONFIG_SPACE_SIZE - 1:
> +            mmcfg_addr = bcm2838_pcie_ext_cfg_index(root_regs)
> +                | PCIE_MMCFG_CONFOFFSET(offset - BCM2838_PCIE_EXT_CFG_DATA);
> +            value = pcie_hb->mmio.ops->read(opaque, mmcfg_addr, size);

This looks weird. You shouldn't be directly reaching into something's
mmio ops struct and calling read and write functions on it. We
have memory_region_dispatch_read() and memory_region_dispatch_write()
for when you need to do a read/write to a MemoryRegion, but those
are fairly rarely necessary.

Looking at other pci controller models, it looks like the more usual
way to approach "config space is accessible via a set of registers"
is to directly call pci_host_config_read_common() and
pci_host_config_write_common(). (The pcie mmcfg MMIO region
read and write accessors are just wrappers around that if you
look at their implementation.)

> +            break;
> +        default:
> +            value = ldn_le_p(root_regs + offset - PCIE_CONFIG_SPACE_SIZE, size);
> +        }
> +    } else {
> +        qemu_log_mask(
> +            LOG_GUEST_ERROR,
> +            "%s: out-of-range access, %u bytes @ offset 0x%04" PRIx64 "\n",
> +            __func__, size, offset);
> +    }
> +
> +    trace_bcm2838_pcie_host_read(size, offset, value);
> +    return value;
> +}
> +
> +static void bcm2838_pcie_host_write(void *opaque, hwaddr offset,
> +                                    uint64_t value, unsigned size) {
> +    hwaddr mmcfg_addr;
> +    BCM2838PcieHostState *s = opaque;
> +    PCIExpressHost *pcie_hb = PCIE_HOST_BRIDGE(s);
> +    uint8_t *root_regs = s->root_port.regs;
> +
> +    trace_bcm2838_pcie_host_write(size, offset, value);
> +
> +    if (offset < PCIE_CONFIG_SPACE_SIZE) {
> +        /* Root port's own PCI config space -- see read path above */
> +        pci_host_config_write_common(PCI_DEVICE(&s->root_port), offset,
> +                                     PCIE_CONFIG_SPACE_SIZE, value, size);
> +    } else if (offset - PCIE_CONFIG_SPACE_SIZE + size
> +               <= sizeof(s->root_port.regs)) {
> +        switch (offset) {
> +        case BCM2838_PCIE_EXT_CFG_DATA
> +            ... BCM2838_PCIE_EXT_CFG_DATA + PCIE_CONFIG_SPACE_SIZE - 1:
> +            mmcfg_addr = bcm2838_pcie_ext_cfg_index(root_regs)
> +                | PCIE_MMCFG_CONFOFFSET(offset - BCM2838_PCIE_EXT_CFG_DATA);
> +            pcie_hb->mmio.ops->write(opaque, mmcfg_addr, value, size);
> +            break;
> +        default:
> +            stn_le_p(root_regs + offset - PCIE_CONFIG_SPACE_SIZE, size, value);
> +        }
> +    } else {
> +        qemu_log_mask(
> +            LOG_GUEST_ERROR,
> +            "%s: out-of-range access, %u bytes @ offset 0x%04" PRIx64 "\n",
> +            __func__, size, offset);
> +    }
> +}
> +
> +static const MemoryRegionOps bcm2838_pcie_host_ops = {
> +    .read = bcm2838_pcie_host_read,
> +    .write = bcm2838_pcie_host_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .impl = {.max_access_size = sizeof(uint64_t)},

Say "8" here.

> +};
> +
> +static void bcm2838_pcie_host_set_irq(void *opaque, int irq_num, int level)
> +{
> +    BCM2838PcieHostState *s = opaque;
> +
> +    qemu_set_irq(s->irq[irq_num], level);
> +}
> +
> +static int bcm2838_pcie_host_map_irq(PCIDevice *pci_dev, int pin)
> +{
> +    return pin;

Is this definitely right? A lot of pci controllers have a
"swizzle" function where the interrupt line used by a device
depends on what slot it's in. (The idea being to spread out
interrupt line use rather than having every device using INTA.)

> +}
> +
> +static void bcm2838_pcie_host_realize(DeviceState *dev, Error **errp)
> +{
> +    PCIHostState *pci = PCI_HOST_BRIDGE(dev);
> +    BCM2838PcieHostState *s = BCM2838_PCIE_HOST(dev);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> +    PCIExpressHost *pex = PCIE_HOST_BRIDGE(dev);
> +
> +    int i;
> +
> +    /*
> +     * Initialise the ECAM config-space window. The BCM2838 does not expose
> +     * it to the guest directly; config accesses are made indirectly through
> +     * the EXT_CFG_INDEX/EXT_CFG_DATA register pair, which dispatch into
> +     * pex->mmio. Without this the ops pointer is never set up.
> +     */
> +    pcie_host_mmcfg_init(pex, PCIE_MMCFG_SIZE_MAX);
> +
> +    memory_region_init_io(&s->cfg_regs, OBJECT(s), &bcm2838_pcie_host_ops, s,
> +                          "bcm2838_pcie_cfg_regs", BCM2838_PCIE_REGS_SIZE);
> +    sysbus_init_mmio(sbd, &s->cfg_regs);
> +
> +    /*
> +     * The MemoryRegions io_mmio and io_ioport that we pass to
> +     * pci_register_root_bus() are not the same as the MemoryRegions
> +     * io_mmio_window and io_ioport_window that we expose as SysBus MRs.
> +     * The difference is in the behavior of accesses to addresses where no PCI
> +     * device has been mapped.
> +     *
> +     * io_mmio and io_ioport are the underlying PCI view of the PCI address
> +     * space, and when a PCI device does a bus master access to a bad address
> +     * this is reported back to it as a transaction failure.
> +     *
> +     * io_mmio_window and io_ioport_window implement "unmapped addresses read as
> +     * -1 and ignore writes"; this is a traditional x86 PC behavior, which is
> +     * not mandated properly by the PCI spec but expected by the majority of
> +     * PCI-using guest software, including Linux.

This is a weird comment, for two reasons:
(1) it's borrowed from gpex.c, but not as an exact copy-and-paste
(2) it makes sense in gpex.c, which is a QEMU-specific "generic" pcie
controller and so QEMU is making decisions about what the behaviour should
be. But it doesn't make sense here, because we're modelling a real piece
fo hardware. If the real bcm2838 makes unmapped addresses in PCI space
be "read -1/write ignore", then that is all the justification we need
for making our model do that. If the real hardware does something else
then we should do something else, regardless of what guest software might
prefer to see.

> +     *
> +     * We implement it in the PCIe host controller, by providing the *_window
> +     * MRs, which are containers with io ops that implement the 'background'
> +     * behavior and which hold the real PCI MRs as sub-regions.
> +     */
> +    memory_region_init(&s->io_mmio, OBJECT(s), "bcm2838_pcie_mmio", UINT64_MAX);
> +    memory_region_init(&s->io_ioport, OBJECT(s), "bcm2838_pcie_ioport",
> +                       64 * 1024);
> +
> +    memory_region_init_io(&s->io_mmio_window, OBJECT(s),
> +                            &unassigned_io_ops, OBJECT(s),
> +                            "bcm2838_pcie_mmio_window", UINT64_MAX);
> +    memory_region_init_io(&s->io_ioport_window, OBJECT(s),
> +                            &unassigned_io_ops, OBJECT(s),
> +                            "bcm2838_pcie_ioport_window", 64 * 1024);
> +
> +    memory_region_add_subregion(&s->io_mmio_window, 0, &s->io_mmio);
> +    memory_region_add_subregion(&s->io_ioport_window, 0, &s->io_ioport);
> +    sysbus_init_mmio(sbd, &s->io_mmio_window);
> +    sysbus_init_mmio(sbd, &s->io_ioport_window);
> +
> +    for (i = 0; i < BCM2838_PCIE_NUM_IRQS; i++) {
> +        sysbus_init_irq(sbd, &s->irq[i]);
> +    }
> +
> +    pci->bus = pci_register_root_bus(dev, "pcie.0", bcm2838_pcie_host_set_irq,
> +                                     bcm2838_pcie_host_map_irq, s, &s->io_mmio,
> +                                     &s->io_ioport, 0, BCM2838_PCIE_NUM_IRQS,
> +                                     TYPE_PCIE_BUS);
> +    qdev_realize(DEVICE(&s->root_port), BUS(pci->bus), &error_fatal);
> +}

-- PMM

