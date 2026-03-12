Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA21B106703A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 14:23:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0gwr-0006gf-42; Thu, 12 Mar 2026 10:23:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1w0gwn-0006fA-BJ; Thu, 12 Mar 2026 10:23:33 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1w0gwk-00012o-JO; Thu, 12 Mar 2026 10:23:32 -0400
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fWqb65yWWzHnGjR;
 Thu, 12 Mar 2026 22:22:58 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id 9D3CC4056B;
 Thu, 12 Mar 2026 22:23:08 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 12 Mar
 2026 14:23:08 +0000
Date: Thu, 12 Mar 2026 14:23:06 +0000
To: Peter Maydell <peter.maydell@linaro.org>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH 61/65] hw/arm/virt: Advertise GICv5 in the DTB
Message-ID: <20260312142306.000016d2@huawei.com>
In-Reply-To: <20260223170212.441276-62-peter.maydell@linaro.org>
References: <20260223170212.441276-1-peter.maydell@linaro.org>
 <20260223170212.441276-62-peter.maydell@linaro.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml500005.china.huawei.com (7.214.145.207)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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
Reply-to:  Jonathan Cameron <jonathan.cameron@huawei.com>
From:  Jonathan Cameron via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 23 Feb 2026 17:02:08 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> Advertise the GICv5 in the DTB. This binding is final as it is in
> the upstream Linux kernel as:
> Documentation/devicetree/bindings/interrupt-controller/arm,gic-v5.yaml
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
One trivial thing inline that might every so slightly help other reviewers.

Otherwise looks correct to me - though take into account I only review this
side of bindings once in a blue moon.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
>  hw/arm/virt.c | 68 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index a9addf5ac0..6775062c5d 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -795,6 +795,72 @@ static void create_v2m(VirtMachineState *vms)
>      vms->msi_controller = VIRT_MSI_CTRL_GICV2M;
>  }
>  
> +static void fdt_add_gicv5_node(VirtMachineState *vms)
> +{
> +    MachineState *ms = MACHINE(vms);
> +    const char *nodename = "/intc";
> +    g_autofree char *irsnodename = NULL;
> +    g_autofree uint32_t *cpu_phandles = g_new(uint32_t, ms->smp.cpus);
> +    g_autofree uint16_t *iaffids = g_new(uint16_t, ms->smp.cpus);
> +
> +    vms->gic_phandle = qemu_fdt_alloc_phandle(ms->fdt);
> +    qemu_fdt_setprop_cell(ms->fdt, "/", "interrupt-parent", vms->gic_phandle);
> +
> +    qemu_fdt_add_subnode(ms->fdt, nodename);
> +    qemu_fdt_setprop_cell(ms->fdt, nodename, "phandle", vms->gic_phandle);
> +    qemu_fdt_setprop_string(ms->fdt, nodename, "compatible", "arm,gic-v5");
> +    qemu_fdt_setprop_cell(ms->fdt, nodename, "#interrupt-cells", 3);
> +    qemu_fdt_setprop(ms->fdt, nodename, "interrupt-controller", NULL, 0);
> +    qemu_fdt_setprop_cell(ms->fdt, nodename, "#address-cells", 0x2);
> +    qemu_fdt_setprop_cell(ms->fdt, nodename, "#size-cells", 0x2);
> +    qemu_fdt_setprop(ms->fdt, nodename, "ranges", NULL, 0);
> +
> +    /* The IRS node is a child of the top level /intc node */
> +    irsnodename = g_strdup_printf("%s/irs@%" PRIx64,
> +                                  nodename,
> +                                  vms->memmap[VIRT_GICV5_IRS_NS].base);
> +    qemu_fdt_add_subnode(ms->fdt, irsnodename);
> +    qemu_fdt_setprop_string(ms->fdt, irsnodename, "compatible",
> +                            "arm,gic-v5-irs");
> +    /*
> +     * "reg-names" describes the frames whose address/size is in "reg";
> +     * at the moment we have only the NS config register frame.
> +     */
> +    qemu_fdt_setprop_string(ms->fdt, irsnodename, "reg-names", "ns-config");
Don't really care, but you could keep these ordered as per the binding doc
to make review a tiny little bit easier.  reg comes before reg-names.

> +    qemu_fdt_setprop_sized_cells(ms->fdt, irsnodename, "reg",
> +                                 2, vms->memmap[VIRT_GICV5_IRS_NS].base,
> +                                 2, vms->memmap[VIRT_GICV5_IRS_NS].size);


