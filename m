Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20A8BC3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 23:49:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqLSe-00006G-1n; Mon, 16 Sep 2024 19:48:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1sqLSb-0008OL-SN
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 19:48:50 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1sqLSa-0001oD-9b
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 19:48:49 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 1CD885C2DAE;
 Mon, 16 Sep 2024 23:48:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29E61C4CEC4;
 Mon, 16 Sep 2024 23:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1726530526;
 bh=XyAe+H4z6/oaTcsJNFRVYs80s5u8wMYSBLvm3nLc+E0=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=sX8pRVVtbMlpDqxfqDy6ahs0y189+0/SrJw9c9IJ1lGCqWQSG1eo4w8budveszqNh
 90r4BzGgJ7+DCPIsycZX/4eLF2jT206ojT+AIuqmQbTahLK0aeoRwejZ/mRSY9hKXE
 J4dbgUeLhyVLRDHfC+3Zn/m0UXf3GZyNl3k9RU4zMU8VA91hsQqyEGZ7GlDwcjZD5k
 Jj5f/WCWAeWEurRcskvT0beHvH7/YWYr4gMy/2nZ8WFyvl9O97un1hpQ4/gBD1xDOB
 1pxzsJhTiF7cHVY1KEJ5DamhzRbidefrEalcGUHyANB1SRlzvdH8usmnZz67ys+pEL
 6ruRu5g6C4Prw==
Date: Mon, 16 Sep 2024 16:48:43 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
cc: qemu-devel@nongnu.org, sstabellini@kernel.org, anthony@xenproject.org, 
 paul@xen.org, peter.maydell@linaro.org, alex.bennee@linaro.org, 
 edgar.iglesias@amd.com, xen-devel@lists.xenproject.org
Subject: Re: [PATCH v1 3/4] hw/xen: xenpvh: Add pci-intx-irq-base property
In-Reply-To: <20240916150853.1216703-4-edgar.iglesias@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2409161648370.1417852@ubuntu-linux-20-04-desktop>
References: <20240916150853.1216703-1-edgar.iglesias@gmail.com>
 <20240916150853.1216703-4-edgar.iglesias@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=139.178.84.217;
 envelope-from=sstabellini@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 16 Sep 2024, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>

Acked-by: Stefano Stabellini <sstabellini@kernel.org>

> ---
>  hw/xen/xen-pvh-common.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/hw/xen/xen-pvh-common.c b/hw/xen/xen-pvh-common.c
> index 76a9b2b945..218ac851cf 100644
> --- a/hw/xen/xen-pvh-common.c
> +++ b/hw/xen/xen-pvh-common.c
> @@ -218,6 +218,11 @@ static void xen_pvh_init(MachineState *ms)
>              error_report("pci-ecam-size only supports values 0 or 0x10000000");
>              exit(EXIT_FAILURE);
>          }
> +        if (!s->cfg.pci_intx_irq_base) {
> +            error_report("PCI enabled but pci-intx-irq-base not set");
> +            exit(EXIT_FAILURE);
> +        }
> +
>          xenpvh_gpex_init(s, xpc, sysmem);
>      }
>  
> @@ -273,6 +278,30 @@ XEN_PVH_PROP_MEMMAP(pci_ecam)
>  XEN_PVH_PROP_MEMMAP(pci_mmio)
>  XEN_PVH_PROP_MEMMAP(pci_mmio_high)
>  
> +static void xen_pvh_set_pci_intx_irq_base(Object *obj, Visitor *v,
> +                                          const char *name, void *opaque,
> +                                          Error **errp)
> +{
> +    XenPVHMachineState *xp = XEN_PVH_MACHINE(obj);
> +    uint32_t value;
> +
> +    if (!visit_type_uint32(v, name, &value, errp)) {
> +        return;
> +    }
> +
> +    xp->cfg.pci_intx_irq_base = value;
> +}
> +
> +static void xen_pvh_get_pci_intx_irq_base(Object *obj, Visitor *v,
> +                                          const char *name, void *opaque,
> +                                          Error **errp)
> +{
> +    XenPVHMachineState *xp = XEN_PVH_MACHINE(obj);
> +    uint32_t value = xp->cfg.pci_intx_irq_base;
> +
> +    visit_type_uint32(v, name, &value, errp);
> +}
> +
>  void xen_pvh_class_setup_common_props(XenPVHMachineClass *xpc)
>  {
>      ObjectClass *oc = OBJECT_CLASS(xpc);
> @@ -318,6 +347,13 @@ do {                                                                      \
>          OC_MEMMAP_PROP(oc, "pci-ecam", pci_ecam);
>          OC_MEMMAP_PROP(oc, "pci-mmio", pci_mmio);
>          OC_MEMMAP_PROP(oc, "pci-mmio-high", pci_mmio_high);
> +
> +        object_class_property_add(oc, "pci-intx-irq-base", "uint32_t",
> +                                  xen_pvh_get_pci_intx_irq_base,
> +                                  xen_pvh_set_pci_intx_irq_base,
> +                                  NULL, NULL);
> +        object_class_property_set_description(oc, "pci-intx-irq-base",
> +                                  "Set PCI INTX interrupt base line.");
>      }
>  
>  #ifdef CONFIG_TPM
> -- 
> 2.43.0
> 

