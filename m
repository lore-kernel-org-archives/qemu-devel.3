Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93A1AC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 09:42:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udn1q-0004CC-Gr; Mon, 21 Jul 2025 05:41:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1udn1W-00044U-Fb; Mon, 21 Jul 2025 05:41:31 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1udn1U-0008P6-91; Mon, 21 Jul 2025 05:41:30 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4blwKp0qpLz6L4tM;
 Mon, 21 Jul 2025 17:37:34 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 13BDE140279;
 Mon, 21 Jul 2025 17:41:21 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 21 Jul
 2025 11:41:20 +0200
Date: Mon, 21 Jul 2025 10:41:19 +0100
To: Vadim Chichikalyuk <chichikalyuk@gmail.com>
CC: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, "Peter
 Maydell" <peter.maydell@linaro.org>
Subject: Re: [PATCH 3/4] hw: arm: acpi: add UART clock frequency to SPCR table
Message-ID: <20250721104119.00001882@huawei.com>
In-Reply-To: <20250718162045.49012-4-chichikalyuk@gmail.com>
References: <20250718162045.49012-1-chichikalyuk@gmail.com>
 <20250718162045.49012-4-chichikalyuk@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, 18 Jul 2025 19:20:44 +0300
Vadim Chichikalyuk <chichikalyuk@gmail.com> wrote:

> On the ARM virt machine, there is currently no way to programmatically
> discover the frequency of the UART reference clock solely through the use of
> UEFI/ACPI (without the DTB). The SPCR table can include this information
> as of revision 3.
> 
> Bump the revision to 3 and add the clock frequency of 24 MHz to the table.

Maybe add something on why you aren't just skipping forwards to 4 and filling
in the rest of the stuff?

> 
> Signed-off-by: Vadim Chichikalyuk <chichikalyuk@gmail.com>

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
>  hw/arm/virt-acpi-build.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index b01fc4f8ef..029cbb37f7 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -559,12 +559,13 @@ spcr_setup(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>          .pci_function = 0,
>          .pci_flags = 0,
>          .pci_segment = 0,
> +        .uart_clk_freq = 24000000, /* 24MHz */
>      };
>      /*
> -     * Passing NULL as the SPCR Table for Revision 2 doesn't support
> +     * Passing NULL as the SPCR Table for Revision 3 doesn't support
>       * NameSpaceString.
>       */
> -    build_spcr(table_data, linker, &serial, 2, vms->oem_id, vms->oem_table_id,
> +    build_spcr(table_data, linker, &serial, 3, vms->oem_id, vms->oem_table_id,
>                 NULL);
>  }
>  


