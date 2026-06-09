Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09C57CD8CBF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 12:48:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWvsH-0006Gm-EX; Tue, 09 Jun 2026 08:48:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1wWvrb-0006DX-Dz; Tue, 09 Jun 2026 08:47:29 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1wWvrX-0006w0-0A; Tue, 09 Jun 2026 08:47:26 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1C1A343D63;
 Tue,  9 Jun 2026 12:47:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D3951F00893;
 Tue,  9 Jun 2026 12:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781009241;
 bh=4X26vcbCVfZIBSpn5p7qHWYu06T8VSoTygDc7YdrmQI=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=ngmzzyV8D+ZRrg4wKWrbKLcxQ4xQ64A+1/QXnRBEorASK97a076dQqjX0D/Wui9pC
 iVzSlxS2FVIgX5pYtJsDrSxsqjIvHy2sOD8LZRVLc3Y0uG3NfM/4aOjLU83jwQUjy9
 szu8cvIo3UQJuqBBVjkVZiZLy02pRZBA7tQgV3Oq2uvWzXGBztYzLIdgiHdiJy3pAU
 Wi68IwapiOIxAM0pSytYhKKpXoV/CzlI5R85klE8GM76+2Rv9me1kFE9zTrbp7IOCJ
 TDh3+rHMr0C7ozK4ZYlg4vmWoLB4bXacaXOKLSSnWouZ1oChagHriXD8OBpug3isDY
 Y5oPbYanmt87Q==
Date: Tue, 9 Jun 2026 13:47:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chen Pei <cp0613@linux.alibaba.com>
Cc: pbonzini@redhat.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 sunilvl@ventanamicro.com, jonathan.cameron@huawei.com, fan.ni@samsung.com,
 guoren@kernel.org, qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 linux-cxl@vger.kernel.org
Subject: Re: [PATCH 2/4] hw/riscv/virt-acpi-build: Add _DEP to ACPI0017 for
 CXL host bridge dependency
Message-ID: <20260609134659.3dc89b40@jic23-huawei>
In-Reply-To: <20260602074127.63819-3-cp0613@linux.alibaba.com>
References: <20260602074127.63819-1-cp0613@linux.alibaba.com>
 <20260602074127.63819-3-cp0613@linux.alibaba.com>
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

On Tue,  2 Jun 2026 15:41:25 +0800
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
> This requires a corresponding kernel change to call
> acpi_dev_clear_dependencies() in acpi_pci_root_add().
> 
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>

It may be a good idea to add a bios tables test as well.
 
We only have the x86 q35 one today because I argued at the time
the ARM64 one would be just duplication.  Now we have this new _DEP
stuff we should probably add something to cover it.

Please also include an iasl -d dump of the relevant additions to DSDT
in the patch description.  Much easier to review than the code that
generates it!

In general looks fine to me and great that you are clearing this up.
Seems it's luck that x86 and ARM64 worked without this (or strictly
speaking other things enforcing the ordering).  Ultimately we probably
want to add this to those two architectures a well.

One small thing inline.

Thanks,

Jonathan


> ---
>  hw/riscv/virt-acpi-build.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
> index 309d64b322..a5bafd1dcf 100644
> --- a/hw/riscv/virt-acpi-build.c
> +++ b/hw/riscv/virt-acpi-build.c
> @@ -510,6 +510,38 @@ static void build_dsdt(GArray *table_data,
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
> +        if (s->bus) {
> +            PCIBus *bus;
> +            uint32_t num_cxl_hbs = 0;
> +
> +            QLIST_FOREACH(bus, &s->bus->child, sibling) {
> +                if (pci_bus_is_root(bus) && pci_bus_is_cxl(bus)) {
> +                    num_cxl_hbs++;

I think you only care if there is at least one. Instead of counting, just set
a bool and break out early if you find one.

> +                }
> +            }
> +
> +            if (num_cxl_hbs > 0) {
> +                Aml *dep_pkg = aml_package(num_cxl_hbs);
> +
> +                QLIST_FOREACH(bus, &s->bus->child, sibling) {
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


