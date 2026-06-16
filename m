Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F5D7CD98E4
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 17:22:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZXUL-0003UV-Mf; Tue, 16 Jun 2026 13:22:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>) id 1wZXUI-0003TA-Jy
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 13:22:11 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>) id 1wZXUH-0001Ah-14
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 13:22:10 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1E4774456F;
 Tue, 16 Jun 2026 17:22:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4E281F000E9;
 Tue, 16 Jun 2026 17:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781630528;
 bh=yAQBjErfWgKwY+rmANd6szMivaukHje+DeQu981RCrg=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=Px2IsKNZKDILQyYuYAEI04Zuhq2MnyRcOtsSTFX+w95yDaUX74SpOFSFpnQcmaE6M
 OfDkbi3VxwIBcoM8QZv8cTSFCpK0wQahVCDeZKYUiUBWD9Bq4ond8ZQkTXzPpUNxas
 81bR/5bv2junus46Pw2oecNulzaRor9OTN1qjinLZUL5AXcQk9esnGM2cC/i/6J71k
 aPsGRJ9ZyuNF6RZlVf1jcz2PN2/G1VV7XK9PR9+MTZelZpn6FF1YaT713/IaZOmYM+
 +AgcwONSHi4O8UnAiT3Fkk3vP5uP5mzg1uarku8AL25P8moCoalzEarL8Z9i/ahTkT
 YjYCtDXmtSXHw==
Date: Tue, 16 Jun 2026 18:21:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Shrihari E S <shrihari.s@samsung.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
 qemu-devel@nongnu.org, cpgs@samsung.com, arun.george@samsung.com,
 vikash.k5@samsung.com, s.neeraj@samsung.com, dongjoo.seo1@samsung.com,
 dave@stgolabs.net, gost.dev@samsung.com
Subject: Re: [RFC 4/8] hw/cxl: Add Streamlined Virtual Channel (SVC)
 property to CXL ports
Message-ID: <20260616182159.6c618a75@jic23-huawei>
In-Reply-To: <20260609105836.3702787-5-shrihari.s@samsung.com>
References: <20260609105836.3702787-1-shrihari.s@samsung.com>
 <CGME20260609104521epcas5p1d91703d83cfe9fd9d38506a64fa276a7@epcas5p1.samsung.com>
 <20260609105836.3702787-5-shrihari.s@samsung.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=jic23@kernel.org;
 helo=sea.source.kernel.org
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

On Tue,  9 Jun 2026 16:28:32 +0530
Shrihari E S <shrihari.s@samsung.com> wrote:

> Add Unordered IO (UIO) dependent property SVC to CXL ports
> (Root, Upstream and Downstream).
> 
> The following properties are added to CXL ports:
>     - x-uio-svc: Enable UIO traffic via SVC3 (mandatory path)
>     - x-uio-svc-opt: Enable UIO traffic via SVC4 (optional path)
> 
> Note: 256B flit mode property was already added in CXL ports, so reused it.
> 
> Signed-off-by: Shrihari E S <shrihari.s@samsung.com>
> Signed-off-by: Dongjoo Seo <dongjoo.seo1@samsung.com>
> ---
>  hw/pci-bridge/cxl_downstream.c            | 2 ++
>  hw/pci-bridge/cxl_root_port.c             | 1 +
>  hw/pci-bridge/cxl_upstream.c              | 2 ++
>  include/hw/pci-bridge/cxl_upstream_port.h | 1 +
>  4 files changed, 6 insertions(+)
> 
> diff --git a/hw/pci-bridge/cxl_downstream.c b/hw/pci-bridge/cxl_downstream.c
> index 7c7a1d1221..6f6f332c07 100644
> --- a/hw/pci-bridge/cxl_downstream.c
> +++ b/hw/pci-bridge/cxl_downstream.c
> @@ -260,6 +260,8 @@ static const Property cxl_dsp_props[] = {
>      DEFINE_PROP_PCIE_LINK_WIDTH("x-width", PCIESlot,
>                                  width, PCIE_LINK_WIDTH_16),
>      DEFINE_PROP_BOOL("x-256b-flit", PCIEPort, flitmode, true),
> +    DEFINE_PROP_BIT("x-uio-svc", PCIEPort, svc, UIO_MANDATORY_SVC, false),
> +    DEFINE_PROP_BIT("x-uio-svc-opt", PCIEPort, svc, UIO_OPTIONAL_SVC, false),
>  };
>  
>  static void cxl_dsp_class_init(ObjectClass *oc, const void *data)
> diff --git a/hw/pci-bridge/cxl_root_port.c b/hw/pci-bridge/cxl_root_port.c
> index e82685d1ab..83fb5968b8 100644
> --- a/hw/pci-bridge/cxl_root_port.c
> +++ b/hw/pci-bridge/cxl_root_port.c
> @@ -53,6 +53,7 @@ typedef struct CXLRootPort {
>      CPMUState cpmu;
>      MemoryRegion cpmu_registers;
>      PCIResReserve res_reserve;
> +    bool uio_capable;
I'd bring these in with a patch that uses them.

This whole thing is simple enough maybe just have it as part of a commit
that uses the properties.

>  } CXLRootPort;
>  
>  #define TYPE_CXL_ROOT_PORT "cxl-rp"
> diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
> index ef5480b116..dadad3e15c 100644
> --- a/hw/pci-bridge/cxl_upstream.c
> +++ b/hw/pci-bridge/cxl_upstream.c
> @@ -437,6 +437,8 @@ static const Property cxl_upstream_props[] = {
>      DEFINE_PROP_PCIE_LINK_WIDTH("x-width", CXLUpstreamPort,
>                                  width, PCIE_LINK_WIDTH_16),
>      DEFINE_PROP_BOOL("x-256b-flit", CXLUpstreamPort, flitmode, false),
> +    DEFINE_PROP_BIT("x-uio-svc", PCIEPort, svc, UIO_MANDATORY_SVC, false),
> +    DEFINE_PROP_BIT("x-uio-svc-opt", PCIEPort, svc, UIO_OPTIONAL_SVC, false),
>  };
>  
>  static void cxl_upstream_class_init(ObjectClass *oc, const void *data)
> diff --git a/include/hw/pci-bridge/cxl_upstream_port.h b/include/hw/pci-bridge/cxl_upstream_port.h
> index d4186234c8..d23541e23a 100644
> --- a/include/hw/pci-bridge/cxl_upstream_port.h
> +++ b/include/hw/pci-bridge/cxl_upstream_port.h
> @@ -22,6 +22,7 @@ typedef struct CXLUpstreamPort {
>      PCIExpLinkSpeed speed;
>      PCIExpLinkWidth width;
>      bool flitmode;
> +    bool uio_capable;
>  
>      DOECap doe_cdat;
>      uint64_t sn;


