Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14580C88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 17:50:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6XIa-0005C0-5j; Tue, 15 Sep 2026 13:50:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1x6XIX-000582-Jl; Tue, 15 Sep 2026 13:50:25 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1x6XIV-0002xr-RH; Tue, 15 Sep 2026 13:50:25 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F2C2D43A4A;
 Tue, 15 Sep 2026 17:50:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4250B1F000FF;
 Tue, 15 Sep 2026 17:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789494620;
 bh=Nqyz/fo8sDe5tWT6T0Vt9gjXn3fPwXMtGCd4dYC8aHk=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=lSgeDpYTBUoJ10iGKz8nL9N/sqb5uW9d1jg9LgV24J5n9xtW7QA0YEZ+mU8BDNkXM
 fplQnbj2Aq+m20pOci5Ujx2HSL4q+CTclrkouquzU4TVKA5yi5BALnZqU7wWM6ynJm
 jBDBOkJVs5P0mcpFMi3uKbxP50GdfBq3wrzrTAE1L9CH0CZR3ezol/tDvrgfXhYdMg
 lXeVLKKi88XWkwzSe58c7CButVHXqFsILYHn1qRUTqiw7IyHABMoCuZ1hQHMv2FiH7
 GDrBZdJQ2RfwF9Zt8WPOuLT+Xhdhc2vs0bwTW4D+1L+qCcuvVZV+GNgbouwRPjhFFQ
 xVaZc8tpfz+2Q==
Date: Tue, 15 Sep 2026 18:50:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chen Pei <cp0613@linux.alibaba.com>
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, mst@redhat.com,
 imammedo@redhat.com, sunilvl@ventanamicro.com, pbonzini@redhat.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 anisinha@redhat.com, dave.jiang@intel.com, alison.schofield@intel.com,
 junjie.cao@intel.com, guoren@kernel.org, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, linux-cxl@vger.kernel.org, Sunil V L
 <sunilvl@oss.qualcomm.com>
Subject: Re: [PATCH v6 2/6] hw/riscv/virt-acpi-build: Add _DEP to ACPI0017
 for CXL host bridge dependency
Message-ID: <20260915185014.697c5a38@jic23-hlaptop>
In-Reply-To: <20260907093735.2753-3-cp0613@linux.alibaba.com>
References: <20260907093735.2753-1-cp0613@linux.alibaba.com>
 <20260907093735.2753-3-cp0613@linux.alibaba.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=jic23@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Mon,  7 Sep 2026 17:37:29 +0800
Chen Pei <cp0613@linux.alibaba.com> wrote:

> On RISC-V QEMU virt platform with CXL enabled, the probe ordering
> of acpi_pci_root (ACPI0016) and cxl_acpi (ACPI0017) is not
> guaranteed. If cxl_acpi probes before acpi_pci_root has attached
> the CXL host bridges, the CXL port topology will be incomplete
> because to_cxl_host_bridge() silently skips devices whose PCI root
> is not yet ready.
> 
> Add a _DEP object to the ACPI0017 device in the DSDT, declaring
> its dependency on the ACPI0016 CXL host bridge devices. This tells
> the OS to defer ACPI0017 enumeration until all ACPI0016 devices
> have been attached by acpi_pci_root.
> 
> This pairs with two kernel commits, both merged in v7.2:
> bf5418a5fe63 ("ACPI: scan: Honor _DEP for ACPI0016 PCI/CXL host
> bridge") makes the ACPI core defer ACPI0017 enumeration while its
> _DEP targets are unattached, and 3a59c3b772e5 ("ACPI: PCI: Clear _DEP
> dependencies after PCI root bridge attach") clears the dependency
> from acpi_pci_root_add() once the host bridge is attached.
> 
> Note on kernel compatibility: this is a "new QEMU feature requires a
> sufficiently new kernel" situation.  Kernels that process _DEP but
> lack the acpi_dev_clear_dependencies() call will leave the CXLM device
> deferred, so CXL memory is unusable there; kernels old enough to ignore
> _DEP entirely behave exactly as before this change.  In neither case is
> existing (non-CXL) PCIe affected.
> 
> The resulting DSDT fragment (iasl -d output) for a single CXL host
> bridge at bus 0x0C looks like:
> 
>   Device (CXLM)
>   {
>       Name (_HID, "ACPI0017")
>       Name (_DEP, Package (0x01)
>       {
>           \_SB.PC0C
>       })
>       Method (_STA, 0, NotSerialized)
>       {
>           Return (0x0B)
>       }
>       ...
>   }
> 
> Reviewed-by: Sunil V L <sunilvl@oss.qualcomm.com>
> Reviewed-by: Junjie Cao <junjie.cao@intel.com>
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>

Whilst by luck we don't need this for Linux to be happy on other
architectures, it may make sense to do it anyway.

When we do that maybe this should be factored out as a helper.
For now LGTM

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

> ---
>  hw/riscv/virt-acpi-build.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
> index 2be8c6d572..e1beb2068d 100644
> --- a/hw/riscv/virt-acpi-build.c
> +++ b/hw/riscv/virt-acpi-build.c
> @@ -525,6 +525,38 @@ static void build_dsdt(GArray *table_data,
>      if (s->cxl_devices_state.is_enabled) {
>          Aml *cxl_dev = aml_device("CXLM");
>          aml_append(cxl_dev, aml_name_decl("_HID", aml_string("ACPI0017")));
> +
> +        /*
> +         * Declare a _DEP on every ACPI0016 CXL host bridge so the OS
> +         * defers ACPI0017 enumeration until acpi_pci_root has attached
> +         * the CXL host bridges. Without this, cxl_acpi may probe before
> +         * to_cxl_host_bridge() can resolve the PCI root and the CXL
> +         * port topology comes up empty.
> +         */
> +        if (s->pci_bus) {
> +            PCIBus *bus;
> +            uint32_t num_cxl_hbs = 0;
> +
> +            QLIST_FOREACH(bus, &s->pci_bus->child, sibling) {
> +                if (pci_bus_is_root(bus) && pci_bus_is_cxl(bus)) {
> +                    num_cxl_hbs++;
> +                }
> +            }
> +
> +            if (num_cxl_hbs > 0) {
> +                Aml *dep_pkg = aml_package(num_cxl_hbs);
> +
> +                QLIST_FOREACH(bus, &s->pci_bus->child, sibling) {
> +                    if (pci_bus_is_root(bus) && pci_bus_is_cxl(bus)) {
> +                        aml_append(dep_pkg,
> +                                   aml_name("\\_SB.PC%.02X",
> +                                            pci_bus_num(bus)));
> +                    }
> +                }
> +                aml_append(cxl_dev, aml_name_decl("_DEP", dep_pkg));
> +            }
> +        }
> +
>          Aml *method = aml_method("_STA", 0, AML_NOTSERIALIZED);
>          aml_append(method, aml_return(aml_int(0x0B)));
>          aml_append(cxl_dev, method);


