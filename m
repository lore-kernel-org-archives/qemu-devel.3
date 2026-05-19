Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 431B6CD5BA4
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 12:46:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPJpn-0004au-AG; Tue, 19 May 2026 08:46:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1wPJpe-0004Vu-Gu; Tue, 19 May 2026 08:45:59 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1wPJpc-0006As-Hj; Tue, 19 May 2026 08:45:58 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 0E22543AB1;
 Tue, 19 May 2026 12:45:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20A93C2BCB3;
 Tue, 19 May 2026 12:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1779194753;
 bh=C87IXNJFNuffOPo6j/clO/ETCIoredweTuvFWS9kwRo=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=UW0J9gop/eSaKgskULyG7KraU52ARclJ4PYF99h/cA5Wzh+vAgGwxL8PUttXl44vh
 ZchTvo6DGmDuvwTAa5tc7i1d/C+5J3EKbUWPaQM5RhSyTOg5CUKceMw3mYLoRAIpOa
 L88HsPbmxNr1Jg4mHXobck9L1c5F934hcZKhvNev/dEoeOd/66+uQKNAWMXh/6zt2l
 IG8ac7n+8FsHKIUN7s3nilp6974Y7d4bpw+9QTjRBmOS6tMBi9do6TvDFg7AluN1/5
 d1yKmH7rSneQKbcRbDtSUC+eMdhJumP5DRiQLSkl7z/r8sYzsepl1rPnfrlF9LJ/Qq
 sYoaajKqzFcNw==
Date: Tue, 19 May 2026 13:45:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: <mhonap@nvidia.com>
Cc: <alwilliamson@nvidia.com>, <skolothumtho@nvidia.com>,
 <ankita@nvidia.com>, <mst@redhat.com>, <imammedo@redhat.com>,
 <anisinha@redhat.com>, <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <shannon.zhaosl@gmail.com>, <jonathan.cameron@huawei.com>,
 <fan.ni@samsung.com>, <pbonzini@redhat.com>,
 <richard.henderson@linaro.org>, <marcel.apfelbaum@gmail.com>,
 <clg@redhat.com>, <cohuck@redhat.com>, <dan.j.williams@intel.com>,
 <dave.jiang@intel.com>, <alejandro.lucero-palau@amd.com>,
 <vsethi@nvidia.com>, <cjia@nvidia.com>, <targupta@nvidia.com>,
 <zhiw@nvidia.com>, <kjaju@nvidia.com>, <linux-cxl@vger.kernel.org>,
 <kvm@vger.kernel.org>, <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
Subject: Re: [RFC 2/9] cxl: Add preserve_config to pxb-cxl OSC method
Message-ID: <20260519134539.1b11ace4@jic23-huawei>
In-Reply-To: <20260427181235.3003865-3-mhonap@nvidia.com>
References: <20260427181235.3003865-1-mhonap@nvidia.com>
 <20260427181235.3003865-3-mhonap@nvidia.com>
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

On Mon, 27 Apr 2026 23:42:28 +0530
<mhonap@nvidia.com> wrote:

> From: Manish Honap <mhonap@nvidia.com>
> 
> Before this patch, pxb-cxl bridges had no _DSM method at all. When the
> OS called _DSM on a CXL host bridge, ACPI returned an error and the OS
> defaulted to reassigning resources across suspend/resume. On machines
> where firmware pre-commits the HDM decoder, that reassignment breaks the
> DPA mapping.

Ah. Ok. So it's suspend / resume that is causing trouble. I wasn't aware
PCI reenumerated on that as opposed to boot. I surprised more doesn't
break.  Make sure to call that out in the cover letter as the impression
I got was the problem was initial enumeration.

Mind you I'm still confused. Why is CXL.mem path affected?  That's
nothing to do with PCI enumeration.

Jonathan

> 
> Wire preserve_config through GPEXConfig into build_cxl_osc_method() so
> pxb-cxl host bridges get a _DSM method that signals the OS to keep
> resource assignments stable when needed. The _DSM function 5 (preserve
> firmware PCI configuration) is the mechanism used to convey this.
> 
> build_pci_host_bridge_dsm_method() is promoted from static to exported
> so cxl.c can call it without duplicating the AML.
> 
> The x86 build_cxl_osc_method() call site passes false since x86 does
> not use firmware-committed HDM decoders.
> 
> build_cxl_osc_method is renamed to acpi_dsdt_add_cxl_host_bridge_methods
> The function now appends both the CXL _OSC method and the _DSM method,
> so its old name is misleading. Renamed it to match the pxb-pcie analogue
> acpi_dsdt_add_host_bridge_methods(), making the two root bridge code
> paths symmetric. No AML change.
> 
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> Signed-off-by: Manish Honap <mhonap@nvidia.com>
> ---
>  hw/acpi/cxl-stub.c         | 2 +-
>  hw/acpi/cxl.c              | 4 +++-
>  hw/i386/acpi-build.c       | 2 +-
>  hw/pci-host/gpex-acpi.c    | 5 +++--
>  include/hw/acpi/cxl.h      | 2 +-
>  include/hw/pci-host/gpex.h | 1 +
>  6 files changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/acpi/cxl-stub.c b/hw/acpi/cxl-stub.c
> index 15bc21076b..d7c6731975 100644
> --- a/hw/acpi/cxl-stub.c
> +++ b/hw/acpi/cxl-stub.c
> @@ -6,7 +6,7 @@
>  #include "hw/acpi/aml-build.h"
>  #include "hw/acpi/cxl.h"
>  
> -void build_cxl_osc_method(Aml *dev)
> +void acpi_dsdt_add_cxl_host_bridge_methods(Aml *dev, bool preserve_config)
>  {
>      g_assert_not_reached();
>  }
> diff --git a/hw/acpi/cxl.c b/hw/acpi/cxl.c
> index f92f7fa3d5..b32740a3e3 100644
> --- a/hw/acpi/cxl.c
> +++ b/hw/acpi/cxl.c
> @@ -23,6 +23,7 @@
>  #include "hw/pci/pci_host.h"
>  #include "hw/cxl/cxl.h"
>  #include "hw/cxl/cxl_host.h"
> +#include "hw/pci-host/gpex.h"
>  #include "hw/mem/memory-device.h"
>  #include "hw/acpi/acpi.h"
>  #include "hw/acpi/aml-build.h"
> @@ -320,11 +321,12 @@ static Aml *__build_cxl_osc_method(void)
>      return method;
>  }
>  
> -void build_cxl_osc_method(Aml *dev)
> +void acpi_dsdt_add_cxl_host_bridge_methods(Aml *dev, bool preserve_config)
>  {
>      aml_append(dev, aml_name_decl("SUPP", aml_int(0)));
>      aml_append(dev, aml_name_decl("CTRL", aml_int(0)));
>      aml_append(dev, aml_name_decl("SUPC", aml_int(0)));
>      aml_append(dev, aml_name_decl("CTRC", aml_int(0)));
>      aml_append(dev, __build_cxl_osc_method());
> +    aml_append(dev, build_pci_host_bridge_dsm_method(preserve_config));
>  }
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index f622b91b76..f66ec8ed24 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1013,7 +1013,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>                  aml_append(aml_pkg, aml_eisaid("PNP0A08"));
>                  aml_append(aml_pkg, aml_eisaid("PNP0A03"));
>                  aml_append(dev, aml_name_decl("_CID", aml_pkg));
> -                build_cxl_osc_method(dev);
> +                acpi_dsdt_add_cxl_host_bridge_methods(dev, false);
>              } else if (pci_bus_is_express(bus)) {
>                  aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A08")));
>                  aml_append(dev, aml_name_decl("_CID", aml_eisaid("PNP0A03")));
> diff --git a/hw/pci-host/gpex-acpi.c b/hw/pci-host/gpex-acpi.c
> index 7de57bbc46..247bd78152 100644
> --- a/hw/pci-host/gpex-acpi.c
> +++ b/hw/pci-host/gpex-acpi.c
> @@ -52,7 +52,7 @@ static void acpi_dsdt_add_pci_route_table(Aml *dev, uint32_t irq,
>      }
>  }
>  
> -static Aml *build_pci_host_bridge_dsm_method(bool preserve_config)
> +Aml *build_pci_host_bridge_dsm_method(bool preserve_config)
>  {
>      Aml *method = aml_method("_DSM", 4, AML_NOTSERIALIZED);
>      Aml *UUID, *ifctx, *ifctx1, *buf;
> @@ -204,7 +204,8 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
>              aml_append(dev, aml_name_decl("_CRS", crs));
>  
>              if (is_cxl) {
> -                build_cxl_osc_method(dev);
> +                acpi_dsdt_add_cxl_host_bridge_methods(dev,
> +                                                      cfg->preserve_config);
>              } else {
>                  /* pxb bridges do not have ACPI PCI Hot-plug enabled */
>                  acpi_dsdt_add_host_bridge_methods(dev, true,
> diff --git a/include/hw/acpi/cxl.h b/include/hw/acpi/cxl.h
> index 8f22c71530..6fe6c9c58d 100644
> --- a/include/hw/acpi/cxl.h
> +++ b/include/hw/acpi/cxl.h
> @@ -24,7 +24,7 @@
>  void cxl_build_cedt(GArray *table_offsets, GArray *table_data,
>                      BIOSLinker *linker, const char *oem_id,
>                      const char *oem_table_id, CXLState *cxl_state);
> -void build_cxl_osc_method(Aml *dev);
> +void acpi_dsdt_add_cxl_host_bridge_methods(Aml *dev, bool preserve_config);
>  void build_cxl_dsm_method(Aml *dev);
>  
>  #endif
> diff --git a/include/hw/pci-host/gpex.h b/include/hw/pci-host/gpex.h
> index a7c2e2edf3..e5c2ebef78 100644
> --- a/include/hw/pci-host/gpex.h
> +++ b/include/hw/pci-host/gpex.h
> @@ -73,6 +73,7 @@ struct GPEXHost {
>  int gpex_set_irq_num(GPEXHost *s, int index, int gsi);
>  
>  void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg);
> +Aml *build_pci_host_bridge_dsm_method(bool preserve_config);
>  void acpi_dsdt_add_gpex_host(Aml *scope, uint32_t irq);
>  
>  #define PCI_HOST_PIO_BASE               "x-pio-base"


