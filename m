Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30ABFC677C4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 17:05:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP27y-0003eR-18; Tue, 10 Jun 2025 12:47:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uP0E6-0004SS-BE
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 10:45:22 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uP0E1-0007Qw-MX
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 10:45:20 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bGs0c1LMxz6L5WY;
 Tue, 10 Jun 2025 22:40:48 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 95DEE140417;
 Tue, 10 Jun 2025 22:45:03 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 10 Jun
 2025 16:45:02 +0200
Date: Tue, 10 Jun 2025 15:45:01 +0100
To: Arpit Kumar <arpit1.kumar@samsung.com>
CC: <qemu-devel@nongnu.org>, <gost.dev@samsung.com>,
 <linux-cxl@vger.kernel.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
 <vishak.g@samsung.com>, <krish.reddy@samsung.com>,
 <a.manzanares@samsung.com>, <alok.rathore@samsung.com>
Subject: Re: [PATCH 3/3] hw/cxl: Add Physical Port Control (Opcode 5102h)
Message-ID: <20250610154501.0000213b@huawei.com>
In-Reply-To: <20250602135942.2773823-4-arpit1.kumar@samsung.com>
References: <20250602135942.2773823-1-arpit1.kumar@samsung.com>
 <CGME20250602140045epcas5p2445a99b249ba9588af027d59b0c8bd35@epcas5p2.samsung.com>
 <20250602135942.2773823-4-arpit1.kumar@samsung.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon,  2 Jun 2025 19:29:42 +0530
Arpit Kumar <arpit1.kumar@samsung.com> wrote:


Very interesting to see support for this. It will enable a load
of additional test cases.

> added assert-deassert PERST implementation, reset PPB
> for physical port.
Added

Please also include some details of testing done and what happens.
Given I know we have some issues with reset that we haven't resolved
I'm curious if you see them here.

> 
> Signed-off-by: Arpit Kumar <arpit1.kumar@samsung.com>

> +/* Assert - Deassert PERST */
> +#define ASSERT_WAIT_TIME_MS 100
> +
>  /* link state flags */
>  #define LINK_STATE_FLAG_LANE_REVERSED    (1 << 0)
>  #define LINK_STATE_FLAG_PERST_ASSERTED   (1 << 1)
> @@ -662,6 +666,114 @@ static CXLRetCode cmd_get_physical_port_state(const struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> +static struct PCIDevice *cxl_find_port_dev(uint8_t ppb_id, PCIBus *bus)
> +{
> +    PCIDevice *d;
> +    int devfn;
> +
> +    for (devfn = 0; devfn < ARRAY_SIZE(bus->devices); devfn++) {

As in patch one, maybe use the for_each_pci_...  Though with the callback
needed it may end up slightly more complex that this.


> +        d = bus->devices[devfn];
> +        if (d) {
> +            if (object_dynamic_cast(OBJECT(d), TYPE_CXL_DSP)) {
> +                uint8_t port = PCIE_PORT(d)->port;
I'd not bother with the local variable for this one.

                 if (PCIE_PORT(d)->port == ppb_id) {
                     return d;
                 }

> +                if (port == ppb_id) {
> +                    return d;
> +                }
> +            }
> +        }
> +    }
> +    return NULL;
> +}
> +
> +static CXLRetCode deassert_PERST(Object *obj, ResetType type, uint8_t pn, CXLCCI *cci)
> +{
> +    ResettableClass *rc = RESETTABLE_GET_CLASS(obj);
> +    ResettableState *s = rc->get_state(obj);
> +
> +    if (cci->pports.perst[pn].issued_assert_PERST) {
> +        if (cci->pports.perst[pn].asrt_time == -1 && !s->hold_phase_pending) {

I'd flip the logic as then can return early in error case and reduce
indent of the rest.


> +            qemu_mutex_lock(&cci->pports.perst[pn].lock);

            QEMU_LOCK_GUARD(&cci->pports.prst[pn].lock);

> +            resettable_release_reset(obj, type);
> +            cci->pports.perst[pn].issued_assert_PERST = false;
> +            cci->pports.pport_info[pn].link_state_flags &=
> +                ~LINK_STATE_FLAG_PERST_ASSERTED;
> +            cci->pports.perst[pn].asrt_time = ASSERT_WAIT_TIME_MS;
> +            qemu_mutex_unlock(&cci->pports.perst[pn].lock);
and drop explicit unlock.
> +        } else {
> +            return CXL_MBOX_INTERNAL_ERROR;
> +        }
> +    } else {
> +        return CXL_MBOX_INTERNAL_ERROR;
> +    }
> +    return CXL_MBOX_SUCCESS;
> +}
> +
> +static CXLRetCode assert_PERST(Object *obj, ResetType type, uint8_t pn, CXLCCI *cci)
> +{
> +    ResettableClass *rc = RESETTABLE_GET_CLASS(obj);
> +    ResettableState *s = rc->get_state(obj);
> +
> +    if (cci->pports.perst[pn].issued_assert_PERST || s->exit_phase_in_progress) {
> +        return CXL_MBOX_INTERNAL_ERROR;
> +    }
> +

WITH_QEMU_LOCK_GUARD() perhaps

> +    qemu_mutex_lock(&cci->pports.perst[pn].lock);
> +    cci->pports.perst[pn].issued_assert_PERST = true;
> +    cci->pports.pport_info[pn].link_state_flags |=
> +        LINK_STATE_FLAG_PERST_ASSERTED;
> +    resettable_assert_reset(obj, type);
> +    qemu_mutex_unlock(&cci->pports.perst[pn].lock);
> +
> +    /* holding reset phase for 100ms */
> +    while (cci->pports.perst[pn].asrt_time--) {
> +        usleep(1000);
Is this happening synchronously?  I'd kind of expect it to be a background thing
where we'd just check it had finished.
> +    }
> +    return CXL_MBOX_SUCCESS;
> +}
> +
> +/*CXL r3.2 Section 7.6.7.1.3: Get Physical Port Control (Opcode 5102h)*/
> +static CXLRetCode cmd_physical_port_control(const struct cxl_cmd *cmd,
> +                                            uint8_t *payload_in,
> +                                            size_t len_in,
> +                                            uint8_t *payload_out,
> +                                            size_t *len_out,
> +                                            CXLCCI *cci)
> +{
> +    PCIBus *bus = &PCI_BRIDGE(cci->d)->sec_bus;
> +    PCIDevice *dev;
> +    struct cxl_fmapi_get_physical_port_control_req_pl {
> +        uint8_t PPB_ID;
> +        uint8_t Ports_Op;
> +    } QEMU_PACKED *in;
> +
> +    in = (struct cxl_fmapi_get_physical_port_control_req_pl *)payload_in;

Often we cheat on these where the type is locally defined and do

    struct cxl_fmapi_get_physical_port_control_req_pl {
        uint8_t ppb_id;
        uint8_t ports_op;
    } QEMU_PACKED *in = (void *)payload_in;

Given it's all together the type isn't confusing or ambiguous even
though we use a void * instead of the more specific cast.

Note also that it is better to stick to local style and use lower_case
style for structure element naming etc.

> +
> +    if (len_in < sizeof(*in)) {
> +        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
> +    }
> +
> +    uint8_t pn = in->PPB_ID;
> +    dev = cxl_find_port_dev(pn, bus);
> +    if (!dev) {
> +        return CXL_MBOX_INTERNAL_ERROR;
> +    }
> +
> +    switch (in->Ports_Op) {
> +    case 0:
> +        assert_PERST(OBJECT(&dev->qdev), RESET_TYPE_COLD, pn, cci);

Even for these probably

assert_perst()

> +        break;
return CXL_MBOX_SUCESS;
> +    case 1:
> +        deassert_PERST(OBJECT(&dev->qdev), RESET_TYPE_COLD, pn, cci);
> +        break;
> +    case 2:
> +        device_cold_reset(&dev->qdev);
> +        break;
> +    default:
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +    return CXL_MBOX_SUCCESS;
> +}
> +

> @@ -3878,4 +3995,15 @@ void cxl_initialize_usp_mctpcci(CXLCCI *cci, DeviceState *d, DeviceState *intf,
>      cci->intf = intf;
>      cxl_init_cci(cci, payload_max);
>      cxl_set_phy_port_info(cci); /* store port info */
> +    /* physical port control */
> +    for (int i = 0; i < PCI_DEVFN_MAX; i++) {
> +        qemu_mutex_init(&cci->pports.perst[i].lock);

perst is definitely port wise - not linked to CCI so that stuff should be
in the port structures themselves.

> +        cci->pports.perst[i].issued_assert_PERST = false;
> +        /* Assert PERST involves physical port to be in
wrap at 80 chars.
> +         * hold reset phase for minimum 100ms. No other calls
> +         * are entertained until Deassert PERST command.
> +         * https://patchwork.ozlabs.org/project/linux-pci/patch/20190523194409.17718-1-niklas.cassel@linaro.org/#2178369

Blocking other commands is fine but we should lock up emulation of other stuff
in the system and I think you currently do.

> +         */
> +        cci->pports.perst[i].asrt_time = ASSERT_WAIT_TIME_MS;
> +    }
>  }
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index 9eb128a1e8..f877d60b39 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -146,10 +146,18 @@ struct cxl_phy_port_info {
>      uint8_t supported_ld_count;
>  } QEMU_PACKED;
>  
> +/* assert-deassert PERST */
> +struct pperst {
> +    bool issued_assert_PERST;
> +    int asrt_time;
> +    QemuMutex lock;
> +};
> +
>  struct phy_port {
>      uint8_t num_ports;
>      uint8_t active_port_bitmask[0x20];
>      struct cxl_phy_port_info pport_info[PCI_DEVFN_MAX];
> +    struct pperst perst[PCI_DEVFN_MAX];
>  };
>  
>  /* CXL r3.1 Table 8-34: Command Return Codes */


