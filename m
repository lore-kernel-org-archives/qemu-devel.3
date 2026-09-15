Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CED36C982C1
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 17:56:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6XO6-00072H-4S; Tue, 15 Sep 2026 13:56:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1x6XNl-0006zD-8i; Tue, 15 Sep 2026 13:55:58 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1x6XNh-00042r-5Z; Tue, 15 Sep 2026 13:55:47 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0936B40599;
 Tue, 15 Sep 2026 17:55:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E9A81F000FF;
 Tue, 15 Sep 2026 17:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789494941;
 bh=CfFwWgtl+eibAQ5fpOdX+5AtdE11X/LWsJ9WbQHfDiY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=AfTMvzD7PiM80+hUHUu4fUIuPoZOK2mTmLvGj/ejAnfuET5O1Slpl4dyAR+Z1Ra58
 cU1IBTVLAwrbTQan9ht5X5UCdYGPcgaJaP0NkvvCpShhriEf0AejyqKkKP0J2zGuaw
 f7C69KAfcnzqAbj29k64F/3o+WbCTGJCMjPM7/8LzWqkkYYtYgqu3cp81h7AOT/l1G
 veI0F7mvOjUIASJvpx0pUhw22O6Tsk/U4750xn5h1e5gqSU5HSiArtuhdz0Esxewml
 eS74sfUdG2xQxgmpCohzpuhVvDoYdDHeewHEBbRofeTNFZlTwRh1id0licX2eJUdrE
 KBi9aXQ7bsTlQ==
Date: Tue, 15 Sep 2026 18:55:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chen Pei <cp0613@linux.alibaba.com>
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, mst@redhat.com,
 imammedo@redhat.com, sunilvl@ventanamicro.com, pbonzini@redhat.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 anisinha@redhat.com, dave.jiang@intel.com, alison.schofield@intel.com,
 junjie.cao@intel.com, guoren@kernel.org, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v6 5/6] tests/qtest: Add RISC-V ACPI bios tables test
 for CXL
Message-ID: <20260915185538.18e5526a@jic23-hlaptop>
In-Reply-To: <20260907093735.2753-6-cp0613@linux.alibaba.com>
References: <20260907093735.2753-1-cp0613@linux.alibaba.com>
 <20260907093735.2753-6-cp0613@linux.alibaba.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=jic23@kernel.org; helo=sea.source.kernel.org
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

On Mon,  7 Sep 2026 17:37:32 +0800
Chen Pei <cp0613@linux.alibaba.com> wrote:

> Add test_acpi_riscv64_virt_tcg_cxl() to verify that enabling CXL on
> the RISC-V virt machine produces correct ACPI tables, including the
> ACPI0017 CXLM device with _DEP in the DSDT and the CEDT table.
> 
> The test boots with cxl=on, one pxb-cxl bus (bus_nr=12), a CXL root
> port, a cxl-type3 device and a fixed memory window, mirroring the
> existing x86 q35 CXL test pattern.
> 
> Since pxb-cxl is a root bus, using -cdrom causes QEMU to auto-plug the
> cdrom drive into pxb-cxl, triggering "Only PCI/PCIe bridges can be
> plugged into pxb-cxl".  The ISO is instead attached explicitly via a
> virtio-scsi-pci controller on pcie.0, following the same approach as
> test_acpi_aarch64_virt_tcg_pxb().
> 
> Acked-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Junjie Cao <junjie.cao@intel.com>
> Tested-by: Junjie Cao <junjie.cao@intel.com>
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>

One possible extra thing below and a general comment. This does the job
though so no need to change anything.

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>


> ---
>  tests/qtest/bios-tables-test.c | 54 ++++++++++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
> 
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> index f6dfa4131b..41c0d6a295 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -2214,6 +2214,56 @@ static void test_acpi_riscv64_virt_tcg(void)
>      free_test_data(&data);
>  }
>  
> +#ifdef CONFIG_POSIX
> +static void test_acpi_riscv64_virt_tcg_cxl(void)
> +{
> +    gchar *tmp_path = g_dir_make_tmp("qemu-test-cxl.XXXXXX", NULL);
> +    gchar *params;
> +
> +    test_data data = {
> +        .machine = "virt",
> +        .arch = "riscv64",
> +        .tcg_only = true,
> +        .uefi_fl1 = "pc-bios/edk2-riscv64-code.fd",
> +        .uefi_fl2 = "pc-bios/edk2-riscv64-vars.fd",
> +        .ram_start = 0x80000000ULL,
> +        .scan_len = 128ULL * MiB,
> +        .variant = ".cxl",
> +    };
> +
> +    /*
> +     * While using -cdrom, the cdrom would auto-plug into pxb-cxl because
> +     * its bus is also a root bus, triggering "Only PCI/PCIe bridges can be
> +     * plugged into pxb-cxl".  Attach the ISO explicitly to a scsi controller
> +     * on pcie.0 instead, following the same pattern as
> +     * test_acpi_aarch64_virt_tcg_pxb().
> +     */
> +    params = g_strdup_printf("-cpu rva22s64"
> +                             " -machine cxl=on"
> +                             " -device pcie-root-port,chassis=1,id=pci.1,bus=pcie.0"
> +                             " -device virtio-scsi-pci,id=scsi0,bus=pci.1"
> +                             " -drive file=tests/data/uefi-boot-images/"
> +                             "bios-tables-test.riscv64.iso.qcow2,"
> +                             "if=none,media=cdrom,id=drive-scsi0-0-0-1,readonly=on"
> +                             " -device scsi-cd,bus=scsi0.0,scsi-id=0,"
> +                             "drive=drive-scsi0-0-0-1,id=scsi0-0-0-1,bootindex=1"
> +                             " -object memory-backend-file,id=cxl-mem1,mem-path=%s,size=256M"
> +                             " -object memory-backend-file,id=lsa1,mem-path=%s,size=256M"
> +                             " -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1"
> +                             " -device cxl-rp,port=0,bus=cxl.1,id=rp1,chassis=0,slot=2"
> +                             " -device cxl-type3,bus=rp1,persistent-memdev=cxl-mem1,lsa=lsa1"

Only thing maybe to consider adding is the serial number given the problems we've had with
that in the past and that persistent mem is basically unuseable without one (it ends
up as part of the stuff stored in LSA).

I am a bit curious if you actually care enough about persistent for that to be better to
test than volatile, but doesn't really matter wrt to what is being tested in practice
which is the arch integration.

> +                             " -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,"
> +                             "cxl-fmw.0.interleave-granularity=8k",
> +                             tmp_path, tmp_path);
> +    test_acpi_one(params, &data);
> +
> +    g_free(params);
> +    g_assert(g_rmdir(tmp_path) == 0);
> +    g_free(tmp_path);
> +    free_test_data(&data);
> +}
> +#endif /* CONFIG_POSIX */
> +
>  static void test_acpi_aarch64_virt_tcg(void)
>  {
>      test_data data = {
> @@ -2971,6 +3021,10 @@ int main(int argc, char *argv[])
>                             test_acpi_riscv64_virt_tcg_numamem);
>              qtest_add_func("acpi/virt/acpispcr",
>                             test_acpi_riscv64_virt_tcg_acpi_spcr);
> +#ifdef CONFIG_POSIX
> +            qtest_add_func("acpi/virt/cxl",
> +                           test_acpi_riscv64_virt_tcg_cxl);
> +#endif
>          }
>      } else if (strcmp(arch, "loongarch64") == 0) {
>          if (has_tcg && qtest_has_machine("virt")) {


