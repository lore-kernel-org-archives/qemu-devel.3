Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ECC4CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 16:55:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyCTS-0005lU-CO; Mon, 15 Sep 2025 12:54:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=keIv=32=kaod.org=clg@ozlabs.org>)
 id 1uyCTJ-0005jV-U7; Mon, 15 Sep 2025 12:54:34 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=keIv=32=kaod.org=clg@ozlabs.org>)
 id 1uyCTB-0002P2-0d; Mon, 15 Sep 2025 12:54:33 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4cQWMx6TSZz4wBB;
 Tue, 16 Sep 2025 02:54:21 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4cQWMs0xmhz4w9s;
 Tue, 16 Sep 2025 02:54:16 +1000 (AEST)
Message-ID: <db7c52d5-d6f0-4478-b6b7-9c45517f0e21@kaod.org>
Date: Mon, 15 Sep 2025 18:54:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [SPAM] [PATCH v2 05/14] hw/pci-host/aspeed: Add AST2600 PCIe Root
 Port and make address configurable
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
 <20250911072452.314553-6-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20250911072452.314553-6-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
> Introduce an ASPEED PCIe Root Port and wire it under the RC. The root port
> is modeled as TYPE_ASPEED_PCIE_ROOT_PORT (subclass of TYPE_PCIE_ROOT_PORT).
> 
> Key changes:
> - Add TYPE_ASPEED_PCIE_ROOT_PORT (PCIESlot-based) with vendor/device IDs
>    and AER capability offset.
> - Extend AspeedPCIERcState to embed a root_port instance and a
>    configurable rp_addr.
> - Add "rp-addr" property to the RC to place the root port at a specific
>    devfn on the root bus.
> - Set the root port's "chassis" property to ensure a unique chassis per RC.
> - Extend AspeedPCIECfgClass with rc_rp_addr defaulting to PCI_DEVFN(8,0).
> 
> Rationale:
> - AST2600 places the root port at 80:08.0 (bus 0x80, dev 8, fn 0).
> - AST2700 must place the root port at 00:00.0, and it supports three RCs.
>    Each root port must therefore be uniquely identifiable; uses the
>    PCIe "chassis" ID for that.
> - Providing a configurable "rp-addr" lets platforms select the correct
>    devfn per SoC family, while the "chassis" property ensures uniqueness
>    across multiple RC instances on AST2700.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   include/hw/pci-host/aspeed_pcie.h | 11 +++++++
>   hw/pci-host/aspeed_pcie.c         | 48 +++++++++++++++++++++++++++++++
>   2 files changed, 59 insertions(+)
> 
> diff --git a/include/hw/pci-host/aspeed_pcie.h b/include/hw/pci-host/aspeed_pcie.h
> index e7c231e847..4026d5b4c5 100644
> --- a/include/hw/pci-host/aspeed_pcie.h
> +++ b/include/hw/pci-host/aspeed_pcie.h
> @@ -22,6 +22,7 @@
>   #include "hw/sysbus.h"
>   #include "hw/pci/pci_bridge.h"
>   #include "hw/pci/pcie_host.h"
> +#include "hw/pci/pcie_port.h"
>   #include "qom/object.h"
>   
>   typedef struct AspeedPCIECfgTxDesc {
> @@ -42,6 +43,13 @@ typedef struct AspeedPCIERegMap {
>       AspeedPCIERcRegs rc;
>   } AspeedPCIERegMap;
>   
> +#define TYPE_ASPEED_PCIE_ROOT_PORT "aspeed.pcie-root-port"
> +OBJECT_DECLARE_SIMPLE_TYPE(AspeedPCIERootPortState, ASPEED_PCIE_ROOT_PORT)
> +
> +typedef struct AspeedPCIERootPortState {
> +    PCIESlot parent_obj;
> +} AspeedPCIERootPortState;
> +
>   #define TYPE_ASPEED_PCIE_ROOT_DEVICE "aspeed.pcie-root-device"
>   OBJECT_DECLARE_SIMPLE_TYPE(AspeedPCIERootDeviceState, ASPEED_PCIE_ROOT_DEVICE);
>   
> @@ -60,12 +68,14 @@ struct AspeedPCIERcState {
>       MemoryRegion mmio;
>       MemoryRegion io;
>   
> +    uint32_t rp_addr;
>       uint32_t bus_nr;
>       char name[16];
>       bool has_rd;
>       qemu_irq irq;
>   
>       AspeedPCIERootDeviceState root_device;
> +    AspeedPCIERootPortState root_port;
>   };
>   
>   /* Bridge between AHB bus and PCIe RC. */
> @@ -88,6 +98,7 @@ struct AspeedPCIECfgClass {
>       const AspeedPCIERegMap *reg_map;
>       const MemoryRegionOps *reg_ops;
>   
> +    uint32_t rc_rp_addr;
>       uint64_t rc_bus_nr;
>       uint64_t nr_regs;
>       bool rc_has_rd;
> diff --git a/hw/pci-host/aspeed_pcie.c b/hw/pci-host/aspeed_pcie.c
> index fa8854fe7a..3f04f0d379 100644
> --- a/hw/pci-host/aspeed_pcie.c
> +++ b/hw/pci-host/aspeed_pcie.c
> @@ -23,6 +23,7 @@
>   #include "hw/registerfields.h"
>   #include "hw/irq.h"
>   #include "hw/pci/pci_host.h"
> +#include "hw/pci/pcie_port.h"
>   #include "hw/pci-host/aspeed_pcie.h"
>   #include "hw/pci/msi.h"
>   #include "trace.h"
> @@ -65,6 +66,32 @@ static const TypeInfo aspeed_pcie_root_device_info = {
>       },
>   };
>   
> +/*
> + * PCIe Root Port
> + */
> +
> +static void aspeed_pcie_root_port_class_init(ObjectClass *klass,
> +                                             const void *data)
> +{
> +    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    PCIERootPortClass *rpc = PCIE_ROOT_PORT_CLASS(klass);
> +
> +    dc->desc = "ASPEED PCIe Root Port";
> +    k->vendor_id = PCI_VENDOR_ID_ASPEED;
> +    k->device_id = 0x1150;
> +    dc->user_creatable = true;
> +
> +    rpc->aer_offset = 0x100;
> +}
> +
> +static const TypeInfo aspeed_pcie_root_port_info = {
> +    .name = TYPE_ASPEED_PCIE_ROOT_PORT,
> +    .parent = TYPE_PCIE_ROOT_PORT,
> +    .instance_size = sizeof(AspeedPCIERootPortState),
> +    .class_init = aspeed_pcie_root_port_class_init,
> +};
> +
>   /*
>    * PCIe Root Complex (RC)
>    */
> @@ -144,6 +171,11 @@ static void aspeed_pcie_rc_realize(DeviceState *dev, Error **errp)
>           qdev_prop_set_bit(DEVICE(&rc->root_device), "multifunction", false);
>           qdev_realize(DEVICE(&rc->root_device), BUS(pci->bus), &error_fatal);
>       }
> +
> +    /* setup root port */
> +    qdev_prop_set_int32(DEVICE(&rc->root_port), "addr", rc->rp_addr);
> +    qdev_prop_set_uint16(DEVICE(&rc->root_port), "chassis", cfg->id);
> +    qdev_realize(DEVICE(&rc->root_port), BUS(pci->bus), &error_fatal);

errp ?

C.


>   }
>   
>   static const char *aspeed_pcie_rc_root_bus_path(PCIHostState *host_bridge,
> @@ -158,9 +190,19 @@ static const char *aspeed_pcie_rc_root_bus_path(PCIHostState *host_bridge,
>       return rc->name;
>   }
>   
> +static void aspeed_pcie_rc_instance_init(Object *obj)
> +{
> +    AspeedPCIERcState *rc = ASPEED_PCIE_RC(obj);
> +    AspeedPCIERootPortState *root_port = &rc->root_port;
> +
> +    object_initialize_child(obj, "root_port", root_port,
> +                            TYPE_ASPEED_PCIE_ROOT_PORT);
> +}
> +
>   static const Property aspeed_pcie_rc_props[] = {
>       DEFINE_PROP_UINT32("bus-nr", AspeedPCIERcState, bus_nr, 0),
>       DEFINE_PROP_BOOL("has-rd", AspeedPCIERcState, has_rd, 0),
> +    DEFINE_PROP_UINT32("rp-addr", AspeedPCIERcState, rp_addr, 0),
>   };
>   
>   static void aspeed_pcie_rc_class_init(ObjectClass *klass, const void *data)
> @@ -183,6 +225,7 @@ static const TypeInfo aspeed_pcie_rc_info = {
>       .name = TYPE_ASPEED_PCIE_RC,
>       .parent = TYPE_PCIE_HOST_BRIDGE,
>       .instance_size = sizeof(AspeedPCIERcState),
> +    .instance_init = aspeed_pcie_rc_instance_init,
>       .class_init = aspeed_pcie_rc_class_init,
>   };
>   
> @@ -456,6 +499,9 @@ static void aspeed_pcie_cfg_realize(DeviceState *dev, Error **errp)
>       object_property_set_bool(OBJECT(&s->rc), "has-rd",
>                               apc->rc_has_rd,
>                               &error_abort);
> +    object_property_set_int(OBJECT(&s->rc), "rp-addr",
> +                            apc->rc_rp_addr,
> +                            &error_abort);
>       if (!sysbus_realize(SYS_BUS_DEVICE(&s->rc), errp)) {
>           return;
>       }
> @@ -489,6 +535,7 @@ static void aspeed_pcie_cfg_class_init(ObjectClass *klass, const void *data)
>       apc->nr_regs = 0x100 >> 2;
>       apc->rc_bus_nr = 0x80;
>       apc->rc_has_rd = true;
> +    apc->rc_rp_addr = PCI_DEVFN(8, 0);
>   }
>   
>   static const TypeInfo aspeed_pcie_cfg_info = {
> @@ -627,6 +674,7 @@ static void aspeed_pcie_register_types(void)
>   {
>       type_register_static(&aspeed_pcie_rc_info);
>       type_register_static(&aspeed_pcie_root_device_info);
> +    type_register_static(&aspeed_pcie_root_port_info);
>       type_register_static(&aspeed_pcie_cfg_info);
>       type_register_static(&aspeed_pcie_phy_info);
>   }


