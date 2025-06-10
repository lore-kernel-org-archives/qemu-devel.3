Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4C7EC5B552
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 16:49:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP26q-0001ou-IM; Tue, 10 Jun 2025 12:46:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uOzyc-0007wL-8Z
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 10:29:22 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uOzyV-0005OF-Us
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 10:29:21 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bGrfD5kTlz6K5c8;
 Tue, 10 Jun 2025 22:24:52 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 2F41814025A;
 Tue, 10 Jun 2025 22:29:08 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 10 Jun
 2025 16:29:07 +0200
Date: Tue, 10 Jun 2025 15:29:06 +0100
To: Arpit Kumar <arpit1.kumar@samsung.com>
CC: <qemu-devel@nongnu.org>, <gost.dev@samsung.com>,
 <linux-cxl@vger.kernel.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
 <vishak.g@samsung.com>, <krish.reddy@samsung.com>,
 <a.manzanares@samsung.com>, <alok.rathore@samsung.com>
Subject: Re: [PATCH 2/3] hw/cxl: Simplified Identify Switch Device & Get
 Physical Port State
Message-ID: <20250610152906.00002c4b@huawei.com>
In-Reply-To: <20250602135942.2773823-3-arpit1.kumar@samsung.com>
References: <20250602135942.2773823-1-arpit1.kumar@samsung.com>
 <CGME20250602140026epcas5p131c1af3cdd05056e7dccf0f91efe490b@epcas5p1.samsung.com>
 <20250602135942.2773823-3-arpit1.kumar@samsung.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
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

On Mon,  2 Jun 2025 19:29:41 +0530
Arpit Kumar <arpit1.kumar@samsung.com> wrote:

> Modified Identify Switch Device (Opcode 5100h)
> & Get Physical Port State(Opcode 5101h)
> using physical ports info stored during enumeration
> 
> Signed-off-by: Arpit Kumar <arpit1.kumar@samsung.com>
A few additional comments in here.

J
> ---
>  hw/cxl/cxl-mailbox-utils.c | 133 +++++++------------------------------
>  1 file changed, 24 insertions(+), 109 deletions(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 680055c6c0..b2fa79a721 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -558,17 +558,7 @@ static CXLRetCode cmd_set_response_msg_limit(const struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> -static void cxl_set_dsp_active_bm(PCIBus *b, PCIDevice *d,
> -                                  void *private)
> -{
> -    uint8_t *bm = private;
> -    if (object_dynamic_cast(OBJECT(d), TYPE_CXL_DSP)) {
> -        uint8_t port = PCIE_PORT(d)->port;
> -        bm[port / 8] |= 1 << (port % 8);
> -    }
> -}
> -
> -/* CXL r3.1 Section 7.6.7.1.1: Identify Switch Device (Opcode 5100h) */
> +/* CXL r3.2 Section 7.6.7.1.1: Identify Switch Device (Opcode 5100h) */

I'd prefer the spec reference updates in a separate patch. They are noise here
and kind of suggest there are real changes rather than just refactoring.


> @@ -611,16 +599,14 @@ static CXLRetCode cmd_identify_switch_device(const struct cxl_cmd *cmd,
>          out->ingress_port_id = 0;
>      }
>  
> -    pci_for_each_device_under_bus(bus, cxl_set_dsp_active_bm,
> -                                  out->active_port_bitmask);
> -    out->active_port_bitmask[usp->port / 8] |= (1 << usp->port % 8);

Ah. With this in front of me the reason for the sizeing is much clearer
than in previous patch on it's own. Combining the two will make it all more obvious.

> -
> +    memcpy(out->active_port_bitmask, cci->pports.active_port_bitmask,
> +           sizeof(cci->pports.active_port_bitmask));
>      *len_out = sizeof(*out);
>  
>      return CXL_MBOX_SUCCESS;
>  }
>  
> -/* CXL r3.1 Section 7.6.7.1.2: Get Physical Port State (Opcode 5101h) */
> +/* CXL r3.2 Section 7.6.7.1.2: Get Physical Port State (Opcode 5101h) */
>  static CXLRetCode cmd_get_physical_port_state(const struct cxl_cmd *cmd,
>                                                uint8_t *payload_in,
>                                                size_t len_in,
> @@ -628,44 +614,21 @@ static CXLRetCode cmd_get_physical_port_state(const struct cxl_cmd *cmd,
>                                                size_t *len_out,
>                                                CXLCCI *cci)
>  {

>  
>      in = (struct cxl_fmapi_get_phys_port_state_req_pl *)payload_in;
>      out = (struct cxl_fmapi_get_phys_port_state_resp_pl *)payload_out;
> @@ -673,72 +636,24 @@ static CXLRetCode cmd_get_physical_port_state(const struct cxl_cmd *cmd,
>      if (len_in < sizeof(*in)) {
>          return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
>      }
> -    /* Check if what was requested can fit */
> +

The check is still here... So why remove the comment?

>      if (sizeof(*out) + sizeof(*out->ports) * in->num_ports > cci->payload_max) {
>          return CXL_MBOX_INVALID_INPUT;
>      }
>  
> -    /* For success there should be a match for each requested */
> -    out->num_ports = in->num_ports;
> +    if (in->num_ports > cci->pports.num_ports) {
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
>  
> +    out->num_ports = in->num_ports;
>      for (i = 0; i < in->num_ports; i++) {
> -        struct cxl_fmapi_port_state_info_block *port;
> -        /* First try to match on downstream port */
> -        PCIDevice *port_dev;
> -        uint16_t lnkcap, lnkcap2, lnksta;
> -
> -        port = &out->ports[i];
> -
> -        port_dev = pcie_find_port_by_pn(bus, in->ports[i]);
> -        if (port_dev) { /* DSP */
> -            PCIDevice *ds_dev = pci_bridge_get_sec_bus(PCI_BRIDGE(port_dev))
> -                ->devices[0];  
> -            port->config_state = 3;
> -            if (ds_dev) {
> -                if (object_dynamic_cast(OBJECT(ds_dev), TYPE_CXL_TYPE3)) {
> -                    port->connected_device_type = 5; /* Assume MLD for now */
> -                } else {
> -                    port->connected_device_type = 1;
> -                }
> -            } else {
> -                port->connected_device_type = 0;
> +        int pn = in->ports[i];
> +        for (int j = 0; j < PCI_DEVFN_MAX; j++) {
> +            if (pn == cci->pports.pport_info[j].port_id) {

Given port id is 0-255 and your port_info has 256 elements, why not index
by port_id when storing them in the first place? That should reduce
complexity of this look up.  I don't think we ever actually look up
by devfn?

> +                memcpy(&out->ports[i], &(cci->pports.pport_info[pn]),
> +                       sizeof(struct cxl_phy_port_info));

