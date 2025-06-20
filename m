Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EEC2C71155
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 10:41:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSZAs-0005sJ-TP; Fri, 20 Jun 2025 06:40:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uSZAq-0005rj-Dz; Fri, 20 Jun 2025 06:40:44 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uSZAl-0000ze-Fi; Fri, 20 Jun 2025 06:40:44 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bNv850nq5z6L57d;
 Fri, 20 Jun 2025 18:38:13 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 758931400D7;
 Fri, 20 Jun 2025 18:40:31 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 20 Jun
 2025 12:40:30 +0200
Date: Fri, 20 Jun 2025 11:40:29 +0100
To: Eric Auger <eric.auger@redhat.com>
CC: <eric.auger.pro@gmail.com>, <qemu-devel@nongnu.org>,
 <qemu-arm@nongnu.org>, <peter.maydell@linaro.org>, <imammedo@redhat.com>,
 <gustavo.romero@linaro.org>, <anisinha@redhat.com>, <mst@redhat.com>,
 <shannon.zhaosl@gmail.com>, <pbonzini@redhat.com>, <philmd@linaro.org>,
 <alex.bennee@linaro.org>
Subject: Re: [PATCH v3 28/29] tests/qtest/bios-tables-test: Add aarch64 ACPI
 PCI hotplug test
Message-ID: <20250620114029.00005a94@huawei.com>
In-Reply-To: <20250616094903.885753-29-eric.auger@redhat.com>
References: <20250616094903.885753-1-eric.auger@redhat.com>
 <20250616094903.885753-29-eric.auger@redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
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

On Mon, 16 Jun 2025 11:46:57 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> From: Gustavo Romero <gustavo.romero@linaro.org>
> 
> The test uses -global acpi-ged.acpi-pci-hotplug-with-bridge-support=on
> to force the usage of ACPI PCI hotplug.
> 
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Could we add the necessary (I'm not quite sure what) to trigger the _DSM
creation so EDSM gets used?  I'm not keen on that being dead code
wrt to tests on ARM.

Jonathan



> ---
>  tests/qtest/bios-tables-test.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> index 0b2bdf9d0d..4b9e391eaf 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -1643,6 +1643,38 @@ static void test_acpi_aarch64_virt_tcg_memhp(void)
>  
>  }
>  
> +static void test_acpi_aarch64_virt_acpi_pci_hotplug(void)
> +{
> +    test_data data = {
> +        .machine = "virt",
> +        .arch = "aarch64",
> +        .tcg_only = true,
> +        .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
> +        .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
> +        .cd = "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2",
> +        .ram_start = 0x40000000ULL,
> +        .scan_len = 256ULL * MiB,
> +        .variant = ".acpipcihp",
> +    };
> +
> +   /* Use ACPI PCI Hotplug */
> +   test_acpi_one(" -global acpi-ged.acpi-pci-hotplug-with-bridge-support=on"
> +                 " -cpu cortex-a57"
> +                 /*
> +                  * We just pick address=0x04 for the root port to avoid
> +                  * collisions with other PCI devices on the root bus (pcie.0).
> +                  * It could be any other value that doesn't collide.
> +                  *
> +                  * The 'chassis' and 'slot' options equal to 1 have no special
> +                  * meaning here, could be any integer, but we set them to known
> +                  * values to keep the test consistent.
> +                  */
> +                 " -device pcie-root-port,bus=pcie.0,chassis=1,slot=1,addr=0x04.0x00",
> +                 &data);
> +
> +    free_test_data(&data);
> +}
> +
>  static void test_acpi_microvm_prepare(test_data *data)
>  {
>      data->machine = "microvm";
> @@ -2580,6 +2612,8 @@ int main(int argc, char *argv[])
>              qtest_add_func("acpi/virt/numamem",
>                             test_acpi_aarch64_virt_tcg_numamem);
>              qtest_add_func("acpi/virt/memhp", test_acpi_aarch64_virt_tcg_memhp);
> +            qtest_add_func("acpi/virt/acpipcihp",
> +                           test_acpi_aarch64_virt_acpi_pci_hotplug);
>              qtest_add_func("acpi/virt/pxb", test_acpi_aarch64_virt_tcg_pxb);
>              qtest_add_func("acpi/virt/oem-fields",
>                             test_acpi_aarch64_virt_oem_fields);


