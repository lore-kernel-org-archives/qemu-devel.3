Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A9C8CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 16:54:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyCRH-0005EB-7M; Mon, 15 Sep 2025 12:52:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=keIv=32=kaod.org=clg@ozlabs.org>)
 id 1uyCR8-0005Dh-LU; Mon, 15 Sep 2025 12:52:18 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=keIv=32=kaod.org=clg@ozlabs.org>)
 id 1uyCQq-00023N-MR; Mon, 15 Sep 2025 12:52:18 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4cQWJz6drtz4w9w;
 Tue, 16 Sep 2025 02:51:47 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4cQWJt45f5z4w9s;
 Tue, 16 Sep 2025 02:51:42 +1000 (AEST)
Message-ID: <1069a725-0ef9-45eb-a71b-9930e6444587@kaod.org>
Date: Mon, 15 Sep 2025 18:51:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [SPAM] [PATCH v2 03/14] hw/pci-host/aspeed: Add AST2600 PCIe
 config space and host bridge
To: Jamin Lin <jamin_lin@aspeedtech.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com, nabihestefan@google.com, wuhaotsh@google.com,
 titusr@google.com
References: <20250911072452.314553-1-jamin_lin@aspeedtech.com>
 <20250911072452.314553-4-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20250911072452.314553-4-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=keIv=32=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/11/25 09:24, Jamin Lin wrote:
> Introduce PCIe config and host bridge model for the AST2600 platform.
> 
> This patch adds support for the H2X (AHB to PCIe Bus Bridge) controller
> with a 0x100 byte register space. The register layout is shared between
> two root complexes: 0x00–0x7f is common, 0x80–0xbf for RC_L, and 0xc0–0xff
> for RC_H. Only RC_H is modeled in this implementation.
> 
> The RC_H bus uses bus numbers in the 0x80–0xff range instead of the
> standard root bus 0x00. To allow the PCI subsystem to discover devices,
> the host bridge logic remaps the root bus number back to 0x00 whenever the
> configured bus number matches the "bus-nr" property.
> 
> New MMIO callbacks are added for the H2X config space:
> - aspeed_pcie_cfg_read() and aspeed_pcie_cfg_write() handle register
>    accesses.
> - aspeed_pcie_cfg_readwrite() provides configuration read/write support.
> - aspeed_pcie_cfg_translate_write() handles PCIe byte-enable semantics for
>    write operations.
> 
> The reset handler initializes the H2X register block with default values
> as defined in the AST2600 datasheet.
> 
> Additional changes:
> - Implement ASPEED PCIe root complex (TYPE_ASPEED_PCIE_RC).
> - Wire up interrupt propagation via aspeed_pcie_rc_set_irq().
> - Add tracepoints for config read/write and INTx handling.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   include/hw/pci-host/aspeed_pcie.h |  58 ++++
>   hw/pci-host/aspeed_pcie.c         | 422 ++++++++++++++++++++++++++++++
>   hw/pci-host/trace-events          |   4 +
>   3 files changed, 484 insertions(+)
> 
> diff --git a/include/hw/pci-host/aspeed_pcie.h b/include/hw/pci-host/aspeed_pcie.h
> index faf87073ab..e2c5dc6f62 100644
> --- a/include/hw/pci-host/aspeed_pcie.h
> +++ b/include/hw/pci-host/aspeed_pcie.h
> @@ -24,6 +24,64 @@
>   #include "hw/pci/pcie_host.h"
>   #include "qom/object.h"
>   
> +typedef struct AspeedPCIECfgTxDesc {
> +    uint32_t desc0;
> +    uint32_t desc1;
> +    uint32_t desc2;
> +    uint32_t desc3;
> +    uint32_t wdata;
> +    uint32_t rdata_reg;
> +} AspeedPCIECfgTxDesc;
> +
> +typedef struct AspeedPCIERcRegs {
> +    uint32_t int_en_reg;
> +    uint32_t int_sts_reg;
> +} AspeedPCIERcRegs;
> +
> +typedef struct AspeedPCIERegMap {
> +    AspeedPCIERcRegs rc;
> +} AspeedPCIERegMap;
> +
> +#define TYPE_ASPEED_PCIE_RC "aspeed.pcie-rc"
> +OBJECT_DECLARE_SIMPLE_TYPE(AspeedPCIERcState, ASPEED_PCIE_RC);
> +
> +struct AspeedPCIERcState {
> +    PCIExpressHost parent_obj;
> +
> +    MemoryRegion mmio_window;
> +    MemoryRegion io_window;
> +    MemoryRegion mmio;
> +    MemoryRegion io;
> +
> +    uint32_t bus_nr;
> +    char name[16];
> +    qemu_irq irq;
> +};
> +
> +/* Bridge between AHB bus and PCIe RC. */
> +#define TYPE_ASPEED_PCIE_CFG "aspeed.pcie-cfg"
> +OBJECT_DECLARE_TYPE(AspeedPCIECfgState, AspeedPCIECfgClass, ASPEED_PCIE_CFG);
> +
> +struct AspeedPCIECfgState {
> +    SysBusDevice parent_obj;
> +
> +    MemoryRegion mmio;
> +    uint32_t *regs;
> +    uint32_t id;
> +
> +    AspeedPCIERcState rc;
> +};
> +
> +struct AspeedPCIECfgClass {
> +    SysBusDeviceClass parent_class;
> +
> +    const AspeedPCIERegMap *reg_map;
> +    const MemoryRegionOps *reg_ops;
> +
> +    uint64_t rc_bus_nr;
> +    uint64_t nr_regs;
> +};
> +
>   #define TYPE_ASPEED_PCIE_PHY "aspeed.pcie-phy"
>   OBJECT_DECLARE_TYPE(AspeedPCIEPhyState, AspeedPCIEPhyClass, ASPEED_PCIE_PHY);
>   
> diff --git a/hw/pci-host/aspeed_pcie.c b/hw/pci-host/aspeed_pcie.c
> index 5584449b17..9fb7c1ef67 100644
> --- a/hw/pci-host/aspeed_pcie.c
> +++ b/hw/pci-host/aspeed_pcie.c
> @@ -27,6 +27,426 @@
>   #include "hw/pci/msi.h"
>   #include "trace.h"
>   
> +/*
> + * PCIe Root Complex (RC)
> + */
> +
> +static void aspeed_pcie_rc_set_irq(void *opaque, int irq, int level)
> +{
> +    AspeedPCIERcState *rc = (AspeedPCIERcState *) opaque;
> +    AspeedPCIECfgState *cfg =
> +        container_of(rc, AspeedPCIECfgState, rc);
> +    AspeedPCIECfgClass *apc = ASPEED_PCIE_CFG_GET_CLASS(cfg);
> +    const AspeedPCIERcRegs *rc_regs;

I suggest you cache &apc->reg_map->rc under AspeedPCIECfgState as
an attribute (at realize time). This will ease reading the code
and improve performance.

> +    bool intx;
> +
> +    assert(irq < PCI_NUM_PINS);
> +
> +    rc_regs = &apc->reg_map->rc;
> +
> +    if (level) {
> +        cfg->regs[rc_regs->int_sts_reg] |= BIT(irq);
> +    } else {
> +        cfg->regs[rc_regs->int_sts_reg] &= ~BIT(irq);
> +    }
> +
> +    intx = !!(cfg->regs[rc_regs->int_sts_reg] & cfg->regs[rc_regs->int_en_reg]);
> +    trace_aspeed_pcie_rc_intx_set_irq(cfg->id, irq, intx);
> +    qemu_set_irq(rc->irq, intx);
> +}
> +
> +static int aspeed_pcie_rc_map_irq(PCIDevice *pci_dev, int irq_num)
> +{
> +    return irq_num % PCI_NUM_PINS;
> +}
> +
> +static void aspeed_pcie_rc_realize(DeviceState *dev, Error **errp)
> +{
> +    PCIExpressHost *pex = PCIE_HOST_BRIDGE(dev);
> +    AspeedPCIERcState *rc = ASPEED_PCIE_RC(dev);
> +    AspeedPCIECfgState *cfg =
> +           container_of(rc, AspeedPCIECfgState, rc);
> +    PCIHostState *pci = PCI_HOST_BRIDGE(dev);
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> +    g_autofree char *name;
> +
> +    /* PCI configuration space */
> +    pcie_host_mmcfg_init(pex, PCIE_MMCFG_SIZE_MAX);
> +    sysbus_init_mmio(sbd, &pex->mmio);
> +
> +    /* MMIO and IO region */
> +    memory_region_init(&rc->mmio, OBJECT(rc), "mmio", UINT64_MAX);
> +    memory_region_init(&rc->io, OBJECT(rc), "io", 0x10000);
> +
> +    name = g_strdup_printf("pcie.%d.mmio_window", cfg->id);
> +    memory_region_init_io(&rc->mmio_window, OBJECT(rc), &unassigned_io_ops,
> +                          OBJECT(rc), name, UINT64_MAX);
> +    name = g_strdup_printf("pcie.%d.ioport_window", cfg->id);
> +    memory_region_init_io(&rc->io_window, OBJECT(rc), &unassigned_io_ops,
> +                          OBJECT(rc), name, 0x10000);
> +
> +    memory_region_add_subregion(&rc->mmio_window, 0, &rc->mmio);
> +    memory_region_add_subregion(&rc->io_window, 0, &rc->io);
> +    sysbus_init_mmio(sbd, &rc->mmio_window);
> +    sysbus_init_mmio(sbd, &rc->io_window);
> +
> +    sysbus_init_irq(sbd, &rc->irq);
> +    name = g_strdup_printf("pcie.rc%d", cfg->id);
> +    pci->bus = pci_register_root_bus(dev, name, aspeed_pcie_rc_set_irq,
> +                                     aspeed_pcie_rc_map_irq, rc, &rc->mmio,
> +                                     &rc->io, 0, 4, TYPE_PCIE_BUS);
> +    pci->bus->flags |= PCI_BUS_EXTENDED_CONFIG_SPACE;
> +}
> +
> +static const char *aspeed_pcie_rc_root_bus_path(PCIHostState *host_bridge,
> +                                                PCIBus *rootbus)
> +{
> +    AspeedPCIERcState *rc = ASPEED_PCIE_RC(host_bridge);
> +    AspeedPCIECfgState *cfg =
> +           container_of(rc, AspeedPCIECfgState, rc);
> +
> +    snprintf(rc->name, sizeof(rc->name), "%04x:%02x", cfg->id, rc->bus_nr);
> +
> +    return rc->name;
> +}
> +
> +static const Property aspeed_pcie_rc_props[] = {
> +    DEFINE_PROP_UINT32("bus-nr", AspeedPCIERcState, bus_nr, 0),
> +};
> +
> +static void aspeed_pcie_rc_class_init(ObjectClass *klass, const void *data)
> +{
> +    PCIHostBridgeClass *hc = PCI_HOST_BRIDGE_CLASS(klass);
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->desc = "ASPEED PCIe RC";
> +    dc->realize = aspeed_pcie_rc_realize;
> +    dc->fw_name = "pci";
> +    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
> +
> +    hc->root_bus_path = aspeed_pcie_rc_root_bus_path;
> +    device_class_set_props(dc, aspeed_pcie_rc_props);
> +
> +    msi_nonbroken = true;
> +}
> +
> +static const TypeInfo aspeed_pcie_rc_info = {
> +    .name = TYPE_ASPEED_PCIE_RC,
> +    .parent = TYPE_PCIE_HOST_BRIDGE,
> +    .instance_size = sizeof(AspeedPCIERcState),
> +    .class_init = aspeed_pcie_rc_class_init,
> +};
> +
> +/*
> + * PCIe Config
> + *
> + * AHB to PCIe Bus Bridge (H2X)
> + *
> + * On the AST2600:
> + * NOTE: rc_l is not supported by this model.
> + * - Registers 0x00 - 0x7F are shared by both PCIe0 (rc_l) and PCIe1 (rc_h).
> + * - Registers 0x80 - 0xBF are specific to PCIe0.
> + * - Registers 0xC0 - 0xFF are specific to PCIe1.
> + */
> +
> +/* AST2600 */
> +REG32(H2X_CTRL,             0x00)
> +    FIELD(H2X_CTRL, CLEAR_RX, 4, 1)
> +REG32(H2X_TX_CLEAR,         0x08)
> +    FIELD(H2X_TX_CLEAR, IDLE, 0, 1)
> +REG32(H2X_RDATA,            0x0C)
> +REG32(H2X_TX_DESC0,         0x10)
> +REG32(H2X_TX_DESC1,         0x14)
> +REG32(H2X_TX_DESC2,         0x18)
> +REG32(H2X_TX_DESC3,         0x1C)
> +REG32(H2X_TX_DATA,          0x20)
> +REG32(H2X_TX_STS,           0x24)
> +    FIELD(H2X_TX_STS, IDLE, 31, 1)
> +    FIELD(H2X_TX_STS, RC_L_TX_COMP, 24, 1)
> +    FIELD(H2X_TX_STS, RC_H_TX_COMP, 25, 1)
> +    FIELD(H2X_TX_STS, TRIG, 0, 1)
> +REG32(H2X_RC_H_CTRL,        0xC0)
> +REG32(H2X_RC_H_INT_EN,      0xC4)
> +REG32(H2X_RC_H_INT_STS,     0xC8)
> +    SHARED_FIELD(H2X_RC_INT_INTDONE, 4, 1)
> +    SHARED_FIELD(H2X_RC_INT_INTX, 0, 4)
> +REG32(H2X_RC_H_RDATA,       0xCC)
> +
> +#define TLP_FMTTYPE_CFGRD0  0x04 /* Configuration Read  Type 0 */
> +#define TLP_FMTTYPE_CFGWR0  0x44 /* Configuration Write Type 0 */
> +#define TLP_FMTTYPE_CFGRD1  0x05 /* Configuration Read  Type 1 */
> +#define TLP_FMTTYPE_CFGWR1  0x45 /* Configuration Write Type 1 */
> +
> +#define PCIE_CFG_FMTTYPE_MASK(x) (((x) >> 24) & 0xff)
> +#define PCIE_CFG_BYTE_EN(x) ((x) & 0xf)
> +
> +static const AspeedPCIERegMap aspeed_regmap = {
> +    .rc = {
> +        .int_en_reg     = R_H2X_RC_H_INT_EN,
> +        .int_sts_reg    = R_H2X_RC_H_INT_STS,
> +    },
> +};
> +
> +static uint64_t aspeed_pcie_cfg_read(void *opaque, hwaddr addr,
> +                                     unsigned int size)
> +{
> +    AspeedPCIECfgState *s = ASPEED_PCIE_CFG(opaque);
> +    uint32_t reg = addr >> 2;
> +    uint32_t value = 0;
> +
> +    value = s->regs[reg];
> +
> +    trace_aspeed_pcie_cfg_read(s->id, addr, value);
> +
> +    return value;
> +}
> +
> +static void aspeed_pcie_cfg_translate_write(uint8_t byte_en, uint32_t *addr,
> +                                            uint64_t *val, int *len)
> +{
> +    uint64_t packed_val = 0;
> +    int first_bit = -1;
> +    int index = 0;
> +    int i;
> +
> +    *len = ctpop8(byte_en);
> +
> +    if (*len == 0 || *len > 4) {
> +        goto err;
> +    }
> +
> +    /* Special case: full 4-byte write must be 4-byte aligned */
> +    if (byte_en == 0x0f) {
> +        if (*addr % 4 != 0) {

This is an aligment issue to be reported as such and not with
"invalid byte enable"

I think you should remove the "goto err" and generate a
LOG_GUEST_ERROR instead.

> +            goto err;
> +        }
> +        *val = *val & 0xffffffff;
> +        return;
> +    }
> +
> +    for (i = 0; i < 4; i++) {
> +        if (byte_en & (1 << i)) {
> +            if (first_bit < 0) {
> +                first_bit = i;
> +            }
> +            packed_val |= ((*val >> (i * 8)) & 0xff) << (index * 8);
> +            index++;> +        }
> +    }
> +
> +    *addr += first_bit;
> +    *val = packed_val;
> +
> +    return;
> +
> +err:
> +    qemu_log_mask(LOG_GUEST_ERROR, "%s: invalid byte enable: 0x%x\n",
> +                  __func__, byte_en);
> +}
> +
> +static void aspeed_pcie_cfg_readwrite(AspeedPCIECfgState *s,
> +                                      const AspeedPCIECfgTxDesc *desc)
> +{
> +    AspeedPCIERcState *rc = &s->rc;
> +    PCIHostState *pci;
> +    uint32_t cfg_addr;
> +    PCIDevice *pdev;
> +    uint32_t offset;
> +    uint8_t byte_en;
> +    bool is_write;
> +    uint8_t devfn;
> +    uint64_t val;
> +    uint8_t bus;
> +    int len;
> +
> +    val = ~0;
> +    is_write = !!(desc->desc0 & BIT(30));
> +    cfg_addr = desc->desc2;


hmm, what about endianess ?

> +    bus = (cfg_addr >> 24) & 0xff;
> +    devfn  = (cfg_addr >> 16) & 0xff;
> +    offset = cfg_addr & 0xffc;
> +
> +    pci = PCI_HOST_BRIDGE(rc);
> +
> +    /*
> +     * On the AST2600, the RC_H bus number ranges from 0x80 to 0xFF, and its
> +     * root port uses bus number 0x80 instead of the standard 0x00. To locate
> +     * the device at root port 0, remap bus number 0x80 to 0x00 so that the
> +     * PCI subsystem can correctly discover the devices.
> +     */
> +    if (bus == rc->bus_nr) {
> +        bus = 0;
> +    }
> +
> +    pdev = pci_find_device(pci->bus, bus, devfn);
> +    if (!pdev) {
> +        s->regs[desc->rdata_reg] = ~0;
> +        goto out;
> +    }
> +
> +    switch (PCIE_CFG_FMTTYPE_MASK(desc->desc0)) {
> +    case TLP_FMTTYPE_CFGWR0:
> +    case TLP_FMTTYPE_CFGWR1:
> +        byte_en = PCIE_CFG_BYTE_EN(desc->desc1);
> +        val = desc->wdata;

what about endianess ?

> +        aspeed_pcie_cfg_translate_write(byte_en, &offset, &val, &len);
> +        pci_host_config_write_common(pdev, offset, pci_config_size(pdev),
> +                                     val, len);
> +        break;
> +    case TLP_FMTTYPE_CFGRD0:
> +    case TLP_FMTTYPE_CFGRD1:
> +        val = pci_host_config_read_common(pdev, offset,
> +                                          pci_config_size(pdev), 4);
> +        s->regs[desc->rdata_reg] = val;
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: invalid CFG type. DESC0=0x%x\n",
> +                      __func__, desc->desc0);
> +    }
> +
> +out:
> +    trace_aspeed_pcie_cfg_rw(s->id, is_write ?  "write" : "read", bus, devfn,
> +                             cfg_addr, val);
> +}
> +
> +static void aspeed_pcie_cfg_write(void *opaque, hwaddr addr, uint64_t data,
> +                                  unsigned int size)
> +{
> +    AspeedPCIECfgState *s = ASPEED_PCIE_CFG(opaque);
> +    AspeedPCIECfgClass *apc = ASPEED_PCIE_CFG_GET_CLASS(s);
> +    AspeedPCIECfgTxDesc desc;
> +    uint32_t reg = addr >> 2;
> +    uint32_t rc_reg;
> +
> +    trace_aspeed_pcie_cfg_write(s->id, addr, data);
> +
> +    switch (reg) {
> +    case R_H2X_CTRL:
> +        if (data & R_H2X_CTRL_CLEAR_RX_MASK) {
> +            s->regs[R_H2X_RDATA] = ~0;
> +        }
> +        break;
> +    case R_H2X_TX_CLEAR:
> +        if (data & R_H2X_TX_CLEAR_IDLE_MASK) {
> +            s->regs[R_H2X_TX_STS] &= ~R_H2X_TX_STS_IDLE_MASK;
> +        }
> +        break;
> +    case R_H2X_TX_STS:
> +        if (data & R_H2X_TX_STS_TRIG_MASK) {
> +            desc.desc0 = s->regs[R_H2X_TX_DESC0];
> +            desc.desc1 = s->regs[R_H2X_TX_DESC1];
> +            desc.desc2 = s->regs[R_H2X_TX_DESC2];
> +            desc.desc3 = s->regs[R_H2X_TX_DESC3];
> +            desc.wdata = s->regs[R_H2X_TX_DATA];
> +            desc.rdata_reg = R_H2X_RC_H_RDATA;

endianess.


Thanks,

C.



> +            aspeed_pcie_cfg_readwrite(s, &desc);
> +            rc_reg = apc->reg_map->rc.int_sts_reg;
> +            s->regs[rc_reg] |= H2X_RC_INT_INTDONE_MASK;
> +            s->regs[R_H2X_TX_STS] |=
> +                BIT(R_H2X_TX_STS_RC_H_TX_COMP_SHIFT);
> +            s->regs[R_H2X_TX_STS] |= R_H2X_TX_STS_IDLE_MASK;
> +        }
> +        break;
> +    /* preserve INTx status */
> +    case R_H2X_RC_H_INT_STS:
> +        if (data & H2X_RC_INT_INTDONE_MASK) {
> +            s->regs[R_H2X_TX_STS] &= ~R_H2X_TX_STS_RC_H_TX_COMP_MASK;
> +        }
> +        s->regs[reg] &= ~data | H2X_RC_INT_INTX_MASK;
> +        break;
> +    default:
> +        s->regs[reg] = data;
> +        break;
> +    }
> +}
> +
> +static const MemoryRegionOps aspeed_pcie_cfg_ops = {
> +    .read = aspeed_pcie_cfg_read,
> +    .write = aspeed_pcie_cfg_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid = {
> +        .min_access_size = 1,
> +        .max_access_size = 4,
> +    },
> +};
> +
> +static void aspeed_pcie_cfg_instance_init(Object *obj)
> +{
> +    AspeedPCIECfgState *s = ASPEED_PCIE_CFG(obj);
> +
> +    object_initialize_child(obj, "rc", &s->rc, TYPE_ASPEED_PCIE_RC);
> +
> +    return;
> +}
> +
> +static void aspeed_pcie_cfg_reset(DeviceState *dev)
> +{
> +    AspeedPCIECfgState *s = ASPEED_PCIE_CFG(dev);
> +    AspeedPCIECfgClass *apc = ASPEED_PCIE_CFG_GET_CLASS(s);
> +
> +    memset(s->regs, 0, apc->nr_regs << 2);
> +}
> +
> +static void aspeed_pcie_cfg_realize(DeviceState *dev, Error **errp)
> +{
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> +    AspeedPCIECfgState *s = ASPEED_PCIE_CFG(dev);
> +    AspeedPCIECfgClass *apc = ASPEED_PCIE_CFG_GET_CLASS(s);
> +    g_autofree char *name;
> +
> +    s->regs = g_new(uint32_t, apc->nr_regs);
> +    name = g_strdup_printf(TYPE_ASPEED_PCIE_CFG ".regs.%d", s->id);
> +    memory_region_init_io(&s->mmio, OBJECT(s), apc->reg_ops, s, name,
> +                          apc->nr_regs << 2);
> +    sysbus_init_mmio(sbd, &s->mmio);
> +
> +    object_property_set_int(OBJECT(&s->rc), "bus-nr",
> +                            apc->rc_bus_nr,
> +                            &error_abort);
> +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->rc), errp)) {
> +        return;
> +    }
> +}
> +
> +static void aspeed_pcie_cfg_unrealize(DeviceState *dev)
> +{
> +    AspeedPCIECfgState *s = ASPEED_PCIE_CFG(dev);
> +
> +    g_free(s->regs);
> +    s->regs = NULL;
> +}
> +
> +static const Property aspeed_pcie_cfg_props[] = {
> +    DEFINE_PROP_UINT32("id", AspeedPCIECfgState, id, 0),
> +};
> +
> +static void aspeed_pcie_cfg_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    AspeedPCIECfgClass *apc = ASPEED_PCIE_CFG_CLASS(klass);
> +
> +    dc->desc = "ASPEED PCIe Config";
> +    dc->realize = aspeed_pcie_cfg_realize;
> +    dc->unrealize = aspeed_pcie_cfg_unrealize;
> +    device_class_set_legacy_reset(dc, aspeed_pcie_cfg_reset);
> +    device_class_set_props(dc, aspeed_pcie_cfg_props);
> +
> +    apc->reg_ops = &aspeed_pcie_cfg_ops;
> +    apc->reg_map = &aspeed_regmap;
> +    apc->nr_regs = 0x100 >> 2;
> +    apc->rc_bus_nr = 0x80;
> +}
> +
> +static const TypeInfo aspeed_pcie_cfg_info = {
> +    .name       = TYPE_ASPEED_PCIE_CFG,
> +    .parent     = TYPE_SYS_BUS_DEVICE,
> +    .instance_init = aspeed_pcie_cfg_instance_init,
> +    .instance_size = sizeof(AspeedPCIECfgState),
> +    .class_init = aspeed_pcie_cfg_class_init,
> +    .class_size = sizeof(AspeedPCIECfgClass),
> +};
> +
>   /*
>    * PCIe PHY
>    *
> @@ -152,6 +572,8 @@ static const TypeInfo aspeed_pcie_phy_info = {
>   
>   static void aspeed_pcie_register_types(void)
>   {
> +    type_register_static(&aspeed_pcie_rc_info);
> +    type_register_static(&aspeed_pcie_cfg_info);
>       type_register_static(&aspeed_pcie_phy_info);
>   }
>   
> diff --git a/hw/pci-host/trace-events b/hw/pci-host/trace-events
> index 3438516756..2584ea56e2 100644
> --- a/hw/pci-host/trace-events
> +++ b/hw/pci-host/trace-events
> @@ -1,6 +1,10 @@
>   # See docs/devel/tracing.rst for syntax documentation.
>   
>   # aspeed_pcie.c
> +aspeed_pcie_rc_intx_set_irq(uint32_t id, int num, int level) "%d: num %d set IRQ leve %d"
> +aspeed_pcie_cfg_read(uint32_t id, uint64_t addr, uint32_t value) "%d: addr 0x%" PRIx64 " value 0x%" PRIx32
> +aspeed_pcie_cfg_write(uint32_t id, uint64_t addr, uint32_t value) "%d: addr 0x%" PRIx64 " value 0x%" PRIx32
> +aspeed_pcie_cfg_rw(uint32_t id, const char *dir, uint8_t bus, uint8_t devfn, uint64_t addr, uint64_t data) "%d: %s bus:0x%x devfn:0x%x addr 0x%" PRIx64 " data 0x%" PRIx64
>   aspeed_pcie_phy_read(uint32_t id, uint64_t addr, uint32_t value) "%d: addr 0x%" PRIx64 " value 0x%" PRIx32
>   aspeed_pcie_phy_write(uint32_t id, uint64_t addr, uint32_t value) "%d: addr 0x%" PRIx64 " value 0x%" PRIx32
>   


