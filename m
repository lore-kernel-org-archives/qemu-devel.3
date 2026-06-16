Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B98B4CD98E4
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 17:21:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZXSz-0002hl-P6; Tue, 16 Jun 2026 13:20:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>) id 1wZXSv-0002hO-OO
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 13:20:45 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>) id 1wZXSr-0000bt-7s
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 13:20:42 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 01EFA40475;
 Tue, 16 Jun 2026 17:20:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A204C1F000E9;
 Tue, 16 Jun 2026 17:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781630438;
 bh=P4BxE9Vk8Q70Zy9QJlxtVeh2hAdKmdkmaWSqUttmwJA=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=jvRmL6wi3fiKnu6kdjeoHfE2CkcNoZCA9ofmUg+Qk2yhx55nNF4w1dQXBakshPoIg
 fIDIwJnWUIjUj0HUHWGVfezioaezykaujlBCNxsQzZQuTottEs49qxo1ZvBvlUuSQ0
 J9O0OnGyrlo0eviNszJEV7LdD7Ec3Cpk2RJ2FZpropiyaw/+xDqzjAuQUNPsrEre/E
 fLHiKo1Fdlu5odUfKJV7FWoM1JAXnayAo9QmONsnYrtP6abIBAsXMhh0lVHcGpzA0k
 l60enSXll9WGRRsaykXl4/tN0ud5v1bM8LeuHqOJVZLU2KrWiiTVocGrgWJHR12/TF
 h+jg/SG+Hmgtw==
Date: Tue, 16 Jun 2026 18:20:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Shrihari E S <shrihari.s@samsung.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
 qemu-devel@nongnu.org, cpgs@samsung.com, arun.george@samsung.com,
 vikash.k5@samsung.com, s.neeraj@samsung.com, dongjoo.seo1@samsung.com,
 dave@stgolabs.net, gost.dev@samsung.com
Subject: Re: [RFC 3/8] hw/pci: Add SVC capability and UIO properties to PCIe
 ports
Message-ID: <20260616182029.3dc0af33@jic23-huawei>
In-Reply-To: <20260609105836.3702787-4-shrihari.s@samsung.com>
References: <20260609105836.3702787-1-shrihari.s@samsung.com>
 <CGME20260609104517epcas5p222b4fc4a5fd8671b47a68abc785a6422@epcas5p2.samsung.com>
 <20260609105836.3702787-4-shrihari.s@samsung.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=jic23@kernel.org; helo=sea.source.kernel.org
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

On Tue,  9 Jun 2026 16:28:31 +0530
Shrihari E S <shrihari.s@samsung.com> wrote:

> From: Dongjoo Seo <dongjoo.seo1@samsung.com>
> 
> Implement the Streamlined Virtual Channel (SVC) extended capability
> for PCIe ports (Root, Upstream, and Downstream). This capability is
> mandatory for enabling Unordered IO (UIO) traffic as per PCIe 6.4
> specification [1].
> 
> UIO functionality depends on two key prerequisites:
>   1. SVC support (SVC3 mandatory, SVC4 optional)
>   2. 256-byte Flit mode support
> 
> This patch adds the following experimental properties to PCIe ports:
>   - x-uio-svc: Enable UIO traffic via SVC3 (mandatory path)
>   - x-uio-svc-opt: Enable UIO traffic via SVC4 (optional path)

That doesn't feel like naming that will stand the test of time.
I think it needs to mention svc4 in the name.  Or I suppose we could
do something with a single x-uio-svc parameter taking values.


>   - x-256b-flit: Enable 256B flit mode required for UIO
> 
> Helper functions are included to manage UIO traffic gating and SVC
> configuration. This change lays the groundwork for UIO emulation in
> QEMU.
> 
> [1]: PCIe 6.4 Specification, Table 2-46 (Streamlined Virtual Channel)

I'm currently out of the loop for PCIe specs. So if someone else could
review against spec that would be great.

> 
> Signed-off-by: Dongjoo Seo <dongjoo.seo1@samsung.com>
> Signed-off-by: Shrihari E S <shrihari.s@samsung.com>
> ---
>  hw/pci-bridge/pcie_root_port.c     |  2 ++
>  hw/pci-bridge/xio3130_downstream.c |  3 +++
>  hw/pci-bridge/xio3130_upstream.c   |  8 ++++++++
>  include/hw/pci/pcie_port.h         | 21 +++++++++++++++++++++
>  4 files changed, 34 insertions(+)
> 
> diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_port.c
> index eeee24e042..20554bd854 100644
> --- a/hw/pci-bridge/pcie_root_port.c
> +++ b/hw/pci-bridge/pcie_root_port.c
> @@ -153,6 +153,8 @@ static const Property rp_props[] = {
>                      QEMU_PCIE_SLTCAP_PCP_BITNR, true),
>      DEFINE_PROP_BOOL("disable-acs", PCIESlot, disable_acs, false),
>      DEFINE_PROP_BOOL("x-256b-flit", PCIEPort, flitmode, true),
> +    DEFINE_PROP_BIT("x-uio-svc", PCIEPort, svc, UIO_MANDATORY_SVC, false),
> +    DEFINE_PROP_BIT("x-uio-svc-opt", PCIEPort, svc, UIO_OPTIONAL_SVC, false),
>  };
>  
>  static void rp_instance_post_init(Object *obj)
> diff --git a/hw/pci-bridge/xio3130_downstream.c b/hw/pci-bridge/xio3130_downstream.c
> index 0c3fed3053..b0b297bb53 100644
> --- a/hw/pci-bridge/xio3130_downstream.c
> +++ b/hw/pci-bridge/xio3130_downstream.c
> @@ -137,6 +137,9 @@ static void xio3130_downstream_exitfn(PCIDevice *d)
>  static const Property xio3130_downstream_props[] = {
>      DEFINE_PROP_BIT(COMPAT_PROP_PCP, PCIDevice, cap_present,
>                      QEMU_PCIE_SLTCAP_PCP_BITNR, true),
> +    DEFINE_PROP_BIT("x-uio-svc", PCIEPort, svc, UIO_MANDATORY_SVC, false),
> +    DEFINE_PROP_BIT("x-uio-svc-opt", PCIEPort, svc, UIO_OPTIONAL_SVC, false),
> +    DEFINE_PROP_BOOL("x-256b-flit", PCIEPort, flitmode, false),
>  };
>  
>  static const VMStateDescription vmstate_xio3130_downstream = {
> diff --git a/hw/pci-bridge/xio3130_upstream.c b/hw/pci-bridge/xio3130_upstream.c
> index 40057b749b..925df5add3 100644
> --- a/hw/pci-bridge/xio3130_upstream.c
> +++ b/hw/pci-bridge/xio3130_upstream.c
> @@ -24,6 +24,7 @@
>  #include "hw/pci/msi.h"
>  #include "hw/pci/pcie.h"
>  #include "hw/pci/pcie_port.h"
> +#include "hw/core/qdev-properties.h"
>  #include "migration/vmstate.h"
>  #include "qemu/module.h"
>  
> @@ -123,6 +124,12 @@ static const VMStateDescription vmstate_xio3130_upstream = {
>      }
>  };
>  
> +static const Property xio3130_upstream_props[] = {
> +    DEFINE_PROP_BIT("x-uio-svc", PCIEPort, svc, UIO_MANDATORY_SVC, false),
> +    DEFINE_PROP_BIT("x-uio-svc-opt", PCIEPort, svc, UIO_OPTIONAL_SVC, false),
> +    DEFINE_PROP_BOOL("x-256b-flit", PCIEPort, flitmode, false),
> +};
> +
>  static void xio3130_upstream_class_init(ObjectClass *klass, const void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> @@ -138,6 +145,7 @@ static void xio3130_upstream_class_init(ObjectClass *klass, const void *data)
>      dc->desc = "TI X3130 Upstream Port of PCI Express Switch";
>      device_class_set_legacy_reset(dc, xio3130_upstream_reset);
>      dc->vmsd = &vmstate_xio3130_upstream;
> +    device_class_set_props(dc, xio3130_upstream_props);
>  }
>  
>  static const TypeInfo xio3130_upstream_info = {
> diff --git a/include/hw/pci/pcie_port.h b/include/hw/pci/pcie_port.h
> index 1bcc734649..a6b1b8a6cf 100644
> --- a/include/hw/pci/pcie_port.h
> +++ b/include/hw/pci/pcie_port.h
> @@ -37,8 +37,29 @@ struct PCIEPort {
>  
>      /* pci express switch port */
>      uint8_t     port;
> +
> +    /*
> +     * This field declares Streamlined Virtual Channel (SVC) capability.
> +     * Per PCIe 6.4 specification section 7.9.29, a pcie port supports
> +     * upto 8 SVCs, in that SVC0 is a default one, SVC3 is for UIO traffic
> +     * and SVC 4 is shared by both UIO and non-UIO traffic.

What actually goes in there?  Is this literally the SVC capability content?

> +     */
> +    uint32_t    svc;
>  };
>  
> +#define UIO_MANDATORY_SVC 3
> +#define UIO_OPTIONAL_SVC 4
> +
> +static inline bool get_uio_mandatory_svc(PCIEPort *port)
> +{
> +    return (port->svc >> UIO_MANDATORY_SVC) & 1;

Could just define the field mask given I don't think you ever care about them
being the numeric values themselves. If you need the value defines later, then
fair enough.

If you do switch to defining fields.
	return port->svc & UIO_MANDATORY_SVC;
and rely on boolean cast from non 0 to be true.

Also, do we want to route those two defines through the kernel uapi/linux/pci_regs.h
and then just make use of them in QEMU?

I kind of assume you have some kernel patches as well as this qemu support so
it would form part of that?

> +}
> +
> +static inline bool get_uio_optional_svc(PCIEPort *port)
> +{
> +    return (port->svc >> UIO_OPTIONAL_SVC) & 1;
> +}
> +
>  void pcie_port_init_reg(PCIDevice *d);
>  
>  PCIDevice *pcie_find_port_by_pn(PCIBus *bus, uint8_t pn);


