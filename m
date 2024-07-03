Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12659C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 12:47:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOzMy-000200-70; Wed, 03 Jul 2024 08:45:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=dfZQ=OD=kaod.org=clg@ozlabs.org>)
 id 1sOzMr-0001yo-BM; Wed, 03 Jul 2024 08:45:49 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=dfZQ=OD=kaod.org=clg@ozlabs.org>)
 id 1sOzMo-0000DM-8P; Wed, 03 Jul 2024 08:45:49 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4WDfdZ4zWKz4wcJ;
 Wed,  3 Jul 2024 22:45:38 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4WDfdR46jwz4wZx;
 Wed,  3 Jul 2024 22:45:30 +1000 (AEST)
Message-ID: <cf451844-7b47-46be-baa8-af6544f00a81@kaod.org>
Date: Wed, 3 Jul 2024 14:45:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] hw/net:ftgmac100: support 64 bits dma dram address
 for AST2700
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>
Cc: troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com
References: <20240703081623.2740862-1-jamin_lin@aspeedtech.com>
 <20240703081623.2740862-3-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240703081623.2740862-3-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=dfZQ=OD=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
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

On 7/3/24 10:16 AM, Jamin Lin wrote:
> ASPEED AST2700 SOC is a 64 bits quad core CPUs (Cortex-a35)
> And the base address of dram is "0x4 00000000" which
> is 64bits address.
> 
> It have "Normal Priority Transmit Ring Base Address Register High(0x17C)",
> "High Priority Transmit Ring Base Address Register High(0x184)" and
> "Receive Ring Base Address Register High(0x18C)" to save the high part physical
> address of descriptor manager.
> Ex: TX descriptor manager address [34:0]
> The "Normal Priority Transmit Ring Base Address Register High(0x17C)"
> bits [2:0] which corresponds the bits [34:32] of the 64 bits address of
> the TX ring buffer address.
> The "Normal Priority Transmit Ring Base Address Register(0x20)" bits [31:0]
> which corresponds the bits [31:0] of the 64 bits address
> of the TX ring buffer address.
> 
> Besides, it have "TXDES 2" and "RXDES 2"
> to save the high part physical address of packet buffer.
> Ex: TX packet buffer address [34:0]
> The "TXDES 2" bits [18:16] which corresponds the bits [34:32]
> of the 64 bits address of the TX packet buffer address
> and "TXDES 3" bits [31:0] which corresponds the bits [31:0]
> of the 64 bits address of the TX packet buffer address.
> 
> Update TX/RX ring and descriptor data type to uint64_t
> and supports TX/RX ring, descriptor and packet buffers
> 64 bits address for all ASPEED SOCs models.
> 
> Incrementing the version of vmstate to 2.
> 
> Introduce a new class(ftgmac100_high),
> class attribute and memop handlers,
> the realize handler instantiate a new memory
> region and map it on top of the current one to
> read/write FTGMAC100_*_HIGH regs.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/net/ftgmac100.c         | 156 ++++++++++++++++++++++++++++++++-----
>   include/hw/net/ftgmac100.h |  24 ++++--
>   2 files changed, 151 insertions(+), 29 deletions(-)
> 
> diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
> index 4e88430b2f..3d13f54efc 100644
> --- a/hw/net/ftgmac100.c
> +++ b/hw/net/ftgmac100.c
> @@ -56,6 +56,16 @@
>   #define FTGMAC100_PHYDATA         0x64
>   #define FTGMAC100_FCR             0x68
>   
> +/*
> + * FTGMAC100 High registers
> + *
> + * values below are offset by - FTGMAC100_HIGH_OFFSET from datasheet
> + * because its memory region is start at FTGMAC100_HIGH_OFFSET
> + */
> +#define FTGMAC100_NPTXR_BADR_HIGH   (0x17C - FTGMAC100_HIGH_OFFSET)
> +#define FTGMAC100_HPTXR_BADR_HIGH   (0x184 - FTGMAC100_HIGH_OFFSET)
> +#define FTGMAC100_RXR_BADR_HIGH     (0x18C - FTGMAC100_HIGH_OFFSET)
> +
>   /*
>    * Interrupt status register & interrupt enable register
>    */
> @@ -165,6 +175,8 @@
>   #define FTGMAC100_TXDES1_TX2FIC          (1 << 30)
>   #define FTGMAC100_TXDES1_TXIC            (1 << 31)
>   
> +#define FTGMAC100_TXDES2_TXBUF_BADR_HI(x)   (((x) >> 16) & 0x7)
> +
>   /*
>    * Receive descriptor
>    */
> @@ -198,13 +210,15 @@
>   #define FTGMAC100_RXDES1_UDP_CHKSUM_ERR  (1 << 26)
>   #define FTGMAC100_RXDES1_IP_CHKSUM_ERR   (1 << 27)
>   
> +#define FTGMAC100_RXDES2_RXBUF_BADR_HI(x)   (((x) >> 16) & 0x7)
> +
>   /*
>    * Receive and transmit Buffer Descriptor
>    */
>   typedef struct {
>       uint32_t        des0;
>       uint32_t        des1;
> -    uint32_t        des2;        /* not used by HW */
> +    uint32_t        des2;        /* used by HW high address */
>       uint32_t        des3;
>   } FTGMAC100Desc;
>   
> @@ -515,12 +529,14 @@ out:
>       return frame_size;
>   }
>   
> -static void ftgmac100_do_tx(FTGMAC100State *s, uint32_t tx_ring,
> -                            uint32_t tx_descriptor)
> +static void ftgmac100_do_tx(FTGMAC100State *s, uint64_t tx_ring,
> +                            uint64_t tx_descriptor)
>   {
> +    FTGMAC100Class *fc = FTGMAC100_GET_CLASS(s);
>       int frame_size = 0;
>       uint8_t *ptr = s->frame;
> -    uint32_t addr = tx_descriptor;
> +    uint64_t addr = tx_descriptor;
> +    uint64_t buf_addr = 0;

To ease reading, I would extract in a standalone patch the part converting
addresses to 64 bits.

>       uint32_t flags = 0;
>   
>       while (1) {
> @@ -559,7 +575,12 @@ static void ftgmac100_do_tx(FTGMAC100State *s, uint32_t tx_ring,
>               len =  sizeof(s->frame) - frame_size;
>           }
>   
> -        if (dma_memory_read(&address_space_memory, bd.des3,
> +        buf_addr = bd.des3;
> +        if (fc->is_dma64) {
> +            buf_addr = deposit64(buf_addr, 32, 32,
> +                                 FTGMAC100_TXDES2_TXBUF_BADR_HI(bd.des2));
> +        }
> +        if (dma_memory_read(&address_space_memory, buf_addr,
>                               ptr, len, MEMTXATTRS_UNSPECIFIED)) {
>               qemu_log_mask(LOG_GUEST_ERROR, "%s: failed to read packet @ 0x%x\n",
>                             __func__, bd.des3);
> @@ -726,9 +747,9 @@ static uint64_t ftgmac100_read(void *opaque, hwaddr addr, unsigned size)
>       case FTGMAC100_MATH1:
>           return s->math[1];
>       case FTGMAC100_RXR_BADR:
> -        return s->rx_ring;
> +        return extract64(s->rx_ring, 0, 32);
>       case FTGMAC100_NPTXR_BADR:
> -        return s->tx_ring;
> +        return extract64(s->tx_ring, 0, 32);
>       case FTGMAC100_ITC:
>           return s->itc;
>       case FTGMAC100_DBLAC:
> @@ -799,9 +820,8 @@ static void ftgmac100_write(void *opaque, hwaddr addr,
>                             HWADDR_PRIx "\n", __func__, value);
>               return;
>           }
> -
> -        s->rx_ring = value;
> -        s->rx_descriptor = s->rx_ring;
> +        s->rx_ring = deposit64(s->rx_ring, 0, 32, value);
> +        s->rx_descriptor = deposit64(s->rx_descriptor, 0, 32, value);
>           break;
>   
>       case FTGMAC100_RBSR: /* DMA buffer size */
> @@ -814,8 +834,8 @@ static void ftgmac100_write(void *opaque, hwaddr addr,
>                             HWADDR_PRIx "\n", __func__, value);
>               return;
>           }
> -        s->tx_ring = value;
> -        s->tx_descriptor = s->tx_ring;
> +        s->tx_ring = deposit64(s->tx_ring, 0, 32, value);
> +        s->tx_descriptor = deposit64(s->tx_descriptor, 0, 32, value);
>           break;
>   
>       case FTGMAC100_NPTXPD: /* Trigger transmit */
> @@ -914,6 +934,60 @@ static void ftgmac100_write(void *opaque, hwaddr addr,
>       ftgmac100_update_irq(s);
>   }
>   
> +static uint64_t ftgmac100_high_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    FTGMAC100State *s = FTGMAC100(opaque);
> +    uint64_t val = 0;
> +
> +    switch (addr) {
> +    case FTGMAC100_NPTXR_BADR_HIGH:
> +        val = extract64(s->tx_ring, 32, 32);
> +        break;
> +    case FTGMAC100_HPTXR_BADR_HIGH:
> +        /* High Priority Transmit Ring Base High Address */
> +        qemu_log_mask(LOG_UNIMP, "%s: read to unimplemented register 0x%"
> +                      HWADDR_PRIx "\n", __func__, addr);
> +        break;
> +    case FTGMAC100_RXR_BADR_HIGH:
> +        val = extract64(s->rx_ring, 32, 32);
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad address at offset 0x%"
> +                      HWADDR_PRIx "\n", __func__, addr);
> +        break;
> +    }
> +
> +    return val;
> +}
> +
> +static void ftgmac100_high_write(void *opaque, hwaddr addr,
> +                          uint64_t value, unsigned size)
> +{
> +    FTGMAC100State *s = FTGMAC100(opaque);
> +
> +    switch (addr) {
> +    case FTGMAC100_NPTXR_BADR_HIGH:
> +        s->tx_ring = deposit64(s->tx_ring, 32, 32, value);
> +        s->tx_descriptor = deposit64(s->tx_descriptor, 32, 32, value);
> +        break;
> +    case FTGMAC100_HPTXR_BADR_HIGH:
> +        /* High Priority Transmit Ring Base High Address */
> +        qemu_log_mask(LOG_UNIMP, "%s: write to unimplemented register 0x%"
> +                      HWADDR_PRIx "\n", __func__, addr);
> +        break;
> +    case FTGMAC100_RXR_BADR_HIGH:
> +        s->rx_ring = deposit64(s->rx_ring, 32, 32, value);
> +        s->rx_descriptor = deposit64(s->rx_descriptor, 32, 32, value);
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad address at offset 0x%"
> +                      HWADDR_PRIx "\n", __func__, addr);
> +        break;
> +    }
> +
> +    ftgmac100_update_irq(s);
> +}
> +
>   static int ftgmac100_filter(FTGMAC100State *s, const uint8_t *buf, size_t len)
>   {
>       unsigned mcast_idx;
> @@ -955,11 +1029,12 @@ static ssize_t ftgmac100_receive(NetClientState *nc, const uint8_t *buf,
>                                    size_t len)
>   {
>       FTGMAC100State *s = FTGMAC100(qemu_get_nic_opaque(nc));
> +    FTGMAC100Class *fc = FTGMAC100_GET_CLASS(s);
>       FTGMAC100Desc bd;
>       uint32_t flags = 0;
> -    uint32_t addr;
> +    uint64_t addr;
>       uint32_t crc;
> -    uint32_t buf_addr;
> +    uint64_t buf_addr = 0;
>       uint8_t *crc_ptr;
>       uint32_t buf_len;
>       size_t size = len;
> @@ -1024,7 +1099,12 @@ static ssize_t ftgmac100_receive(NetClientState *nc, const uint8_t *buf,
>           if (size < 4) {
>               buf_len += size - 4;
>           }
> +
>           buf_addr = bd.des3;
> +        if (fc->is_dma64) {
> +            buf_addr = deposit64(buf_addr, 32, 32,
> +                                 FTGMAC100_RXDES2_RXBUF_BADR_HI(bd.des2));
> +        }
>           if (first && proto == ETH_P_VLAN && buf_len >= 18) {
>               bd.des1 = lduw_be_p(buf + 14) | FTGMAC100_RXDES1_VLANTAG_AVAIL;
>   
> @@ -1078,6 +1158,14 @@ static const MemoryRegionOps ftgmac100_ops = {
>       .endianness = DEVICE_LITTLE_ENDIAN,
>   };
>   
> +static const MemoryRegionOps ftgmac100_high_ops = {
> +    .read = ftgmac100_high_read,
> +    .write = ftgmac100_high_write,
> +    .valid.min_access_size = 4,
> +    .valid.max_access_size = 4,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +};
> +
>   static void ftgmac100_cleanup(NetClientState *nc)
>   {
>       FTGMAC100State *s = FTGMAC100(qemu_get_nic_opaque(nc));
> @@ -1097,6 +1185,7 @@ static NetClientInfo net_ftgmac100_info = {
>   static void ftgmac100_realize(DeviceState *dev, Error **errp)
>   {
>       FTGMAC100State *s = FTGMAC100(dev);
> +    FTGMAC100Class *fc = FTGMAC100_GET_CLASS(s);
>       SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
>   
>       if (s->aspeed) {
> @@ -1107,9 +1196,17 @@ static void ftgmac100_realize(DeviceState *dev, Error **errp)
>           s->rxdes0_edorr = FTGMAC100_RXDES0_EDORR;
>       }
>   
> -    memory_region_init_io(&s->iomem, OBJECT(dev), &ftgmac100_ops, s,
> +    memory_region_init_io(&s->iomem, OBJECT(s), &ftgmac100_ops, s,
>                             TYPE_FTGMAC100, FTGMAC100_NR_REGS);
>       sysbus_init_mmio(sbd, &s->iomem);
> +
> +    if (fc->is_dma64) {
> +        memory_region_init_io(&s->iomem_high, OBJECT(s), &ftgmac100_high_ops,
> +                              s, TYPE_FTGMAC100_HIGH, FTGMAC100_HIGH_NR_REGS);
> +        memory_region_add_subregion(&s->iomem, FTGMAC100_HIGH_OFFSET,
> +                                    &s->iomem_high);
> +    }

I think that, first, we should introduce a container region. In this
container region would be mapped a sub region for the current set of
registers. This container region would be the one that the SoC maps as
it is done today.

Then, in a second patch, we should introduce a extra sub region for the
set of new registers and map it at 0x100 in the container region.

It is close to what you did but it lacks an overall container region.
This container region should be sized as specified in the datasheet.

>       sysbus_init_irq(sbd, &s->irq);
>       qemu_macaddr_default_if_unset(&s->conf.macaddr);
>   
> @@ -1121,18 +1218,14 @@ static void ftgmac100_realize(DeviceState *dev, Error **errp)
>   
>   static const VMStateDescription vmstate_ftgmac100 = {
>       .name = TYPE_FTGMAC100,
> -    .version_id = 1,
> -    .minimum_version_id = 1,
> +    .version_id = 2,
> +    .minimum_version_id = 2,
>       .fields = (const VMStateField[]) {
>           VMSTATE_UINT32(irq_state, FTGMAC100State),
>           VMSTATE_UINT32(isr, FTGMAC100State),
>           VMSTATE_UINT32(ier, FTGMAC100State),
>           VMSTATE_UINT32(rx_enabled, FTGMAC100State),
> -        VMSTATE_UINT32(rx_ring, FTGMAC100State),
>           VMSTATE_UINT32(rbsr, FTGMAC100State),
> -        VMSTATE_UINT32(tx_ring, FTGMAC100State),
> -        VMSTATE_UINT32(rx_descriptor, FTGMAC100State),
> -        VMSTATE_UINT32(tx_descriptor, FTGMAC100State),
>           VMSTATE_UINT32_ARRAY(math, FTGMAC100State, 2),
>           VMSTATE_UINT32(itc, FTGMAC100State),
>           VMSTATE_UINT32(aptcr, FTGMAC100State),
> @@ -1151,6 +1244,10 @@ static const VMStateDescription vmstate_ftgmac100 = {
>           VMSTATE_UINT32(phy_int_mask, FTGMAC100State),
>           VMSTATE_UINT32(txdes0_edotr, FTGMAC100State),
>           VMSTATE_UINT32(rxdes0_edorr, FTGMAC100State),
> +        VMSTATE_UINT64(rx_ring, FTGMAC100State),
> +        VMSTATE_UINT64(tx_ring, FTGMAC100State),
> +        VMSTATE_UINT64(rx_descriptor, FTGMAC100State),
> +        VMSTATE_UINT64(tx_descriptor, FTGMAC100State),
>           VMSTATE_END_OF_LIST()
>       }
>   };
> @@ -1180,6 +1277,22 @@ static const TypeInfo ftgmac100_info = {
>       .class_init = ftgmac100_class_init,
>   };
>   
> +static void ftgmac100_high_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    FTGMAC100Class *fc = FTGMAC100_CLASS(klass);
> +
> +    dc->desc = "Faraday FTGMAC100 Gigabit Ethernet High emulation";
> +    fc->is_dma64 = true;
> +}

Using a property to activate the region for new registers, instead of a
class, would simplify the changes IMO. Let's call the property "dma64" ?

Thanks,

C.



> +
> +static const TypeInfo ftgmac100_high_info = {
> +    .name = TYPE_FTGMAC100_HIGH,
> +    .parent = TYPE_FTGMAC100,
> +    .instance_size = sizeof(FTGMAC100State),
> +    .class_init = ftgmac100_high_class_init,
> +};
> +
>   /*
>    * AST2600 MII controller
>    */
> @@ -1342,6 +1455,7 @@ static const TypeInfo aspeed_mii_info = {
>   static void ftgmac100_register_types(void)
>   {
>       type_register_static(&ftgmac100_info);
> +    type_register_static(&ftgmac100_high_info);
>       type_register_static(&aspeed_mii_info);
>   }
>   
> diff --git a/include/hw/net/ftgmac100.h b/include/hw/net/ftgmac100.h
> index 5a970676da..3e44ed97c9 100644
> --- a/include/hw/net/ftgmac100.h
> +++ b/include/hw/net/ftgmac100.h
> @@ -12,13 +12,15 @@
>   #include "qom/object.h"
>   
>   #define TYPE_FTGMAC100 "ftgmac100"
> -OBJECT_DECLARE_SIMPLE_TYPE(FTGMAC100State, FTGMAC100)
> +#define TYPE_FTGMAC100_HIGH "ftgmac100_high"
> +OBJECT_DECLARE_TYPE(FTGMAC100State, FTGMAC100Class, FTGMAC100)
>   
> -#define FTGMAC100_NR_REGS   0x200
> +#define FTGMAC100_NR_REGS 0x200
> +#define FTGMAC100_HIGH_OFFSET 0x100
> +#define FTGMAC100_HIGH_NR_REGS 0x100
>   
>   #include "hw/sysbus.h"
>   #include "net/net.h"
> -
>   /*
>    * Max frame size for the receiving buffer
>    */
> @@ -33,6 +35,7 @@ struct FTGMAC100State {
>       NICConf conf;
>       qemu_irq irq;
>       MemoryRegion iomem;
> +    MemoryRegion iomem_high;
>   
>       uint8_t frame[FTGMAC100_MAX_FRAME_SIZE];
>   
> @@ -40,10 +43,6 @@ struct FTGMAC100State {
>       uint32_t isr;
>       uint32_t ier;
>       uint32_t rx_enabled;
> -    uint32_t rx_ring;
> -    uint32_t rx_descriptor;
> -    uint32_t tx_ring;
> -    uint32_t tx_descriptor;
>       uint32_t math[2];
>       uint32_t rbsr;
>       uint32_t itc;
> @@ -56,7 +55,10 @@ struct FTGMAC100State {
>       uint32_t phycr;
>       uint32_t phydata;
>       uint32_t fcr;
> -
> +    uint64_t rx_ring;
> +    uint64_t rx_descriptor;
> +    uint64_t tx_ring;
> +    uint64_t tx_descriptor;
>   
>       uint32_t phy_status;
>       uint32_t phy_control;
> @@ -69,6 +71,12 @@ struct FTGMAC100State {
>       uint32_t rxdes0_edorr;
>   };
>   
> +struct FTGMAC100Class {
> +    SysBusDeviceClass parent_class;
> +
> +    bool is_dma64;
> +};
> +
>   #define TYPE_ASPEED_MII "aspeed-mmi"
>   OBJECT_DECLARE_SIMPLE_TYPE(AspeedMiiState, ASPEED_MII)
>   


