Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9959C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 09:45:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udn40-0007NF-IP; Mon, 21 Jul 2025 05:44:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1udn3t-0007I6-Gs; Mon, 21 Jul 2025 05:43:58 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1udn3r-00087Y-65; Mon, 21 Jul 2025 05:43:57 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4blwLX4yqrz6L5GR;
 Mon, 21 Jul 2025 17:38:12 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 09341140279;
 Mon, 21 Jul 2025 17:39:39 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 21 Jul
 2025 11:39:38 +0200
Date: Mon, 21 Jul 2025 10:39:37 +0100
To: Vadim Chichikalyuk <chichikalyuk@gmail.com>
CC: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, "Peter
 Maydell" <peter.maydell@linaro.org>
Subject: Re: [PATCH 1/4] hw: acpi: add support for SPCR revision 3
Message-ID: <20250721103937.00007933@huawei.com>
In-Reply-To: <20250718162045.49012-2-chichikalyuk@gmail.com>
References: <20250718162045.49012-1-chichikalyuk@gmail.com>
 <20250718162045.49012-2-chichikalyuk@gmail.com>
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

On Fri, 18 Jul 2025 19:20:42 +0300
Vadim Chichikalyuk <chichikalyuk@gmail.com> wrote:

> The UART clock frequency field of the SPCR table was added in revision 3.
> Currently, build_spcr() treats revision 3 tables the same as revision 2 and
> only includes this field in revision 4 tables.

Given this isn't in the ACPI spec, I'd make sure you have a reference to the MS
documentation for this. I think it is this one:
https://learn.microsoft.com/en-us/windows-hardware/drivers/bringup/serial-port-console-redirection-table

> 
> Fix build_spcr() to include the clock frequency field in revision 3 tables.
> Per the specification, this is the only change between revisions 2 and 3.

Maybe say why this has never mattered - I think because no code actually uses
revision 3.  Prior to this series, arm-virt and loongarch were 2 and
riscv-virt was 4.

> 
> Signed-off-by: Vadim Chichikalyuk <chichikalyuk@gmail.com>
Code looks fine so with those additions to the description

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
>  hw/acpi/aml-build.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> index 1e685f982f..9855d5f053 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c
> @@ -2123,20 +2123,22 @@ void build_spcr(GArray *table_data, BIOSLinker *linker,
>      build_append_int_noprefix(table_data, f->pci_flags, 4);
>      /* PCI Segment */
>      build_append_int_noprefix(table_data, f->pci_segment, 1);
> -    if (rev < 4) {
> +    if (rev < 3) {
>          /* Reserved */
>          build_append_int_noprefix(table_data, 0, 4);
>      } else {
>          /* UartClkFreq */
>          build_append_int_noprefix(table_data, f->uart_clk_freq, 4);
> -        /* PreciseBaudrate */
> -        build_append_int_noprefix(table_data, f->precise_baudrate, 4);
> -        /* NameSpaceStringLength */
> -        build_append_int_noprefix(table_data, f->namespace_string_length, 2);
> -        /* NameSpaceStringOffset */
> -        build_append_int_noprefix(table_data, f->namespace_string_offset, 2);
> -        /* NamespaceString[] */
> -        g_array_append_vals(table_data, name, f->namespace_string_length);
> +        if (rev >= 4) {
> +            /* PreciseBaudrate */

Obviously historical, but this does seem like a lot of unnecessary comments
given the clear naming of the input parameters!

> +            build_append_int_noprefix(table_data, f->precise_baudrate, 4);
> +            /* NameSpaceStringLength */
> +            build_append_int_noprefix(table_data, f->namespace_string_length, 2);
> +            /* NameSpaceStringOffset */
> +            build_append_int_noprefix(table_data, f->namespace_string_offset, 2);
> +            /* NamespaceString[] */
> +            g_array_append_vals(table_data, name, f->namespace_string_length);
> +        }
>      }
>      acpi_table_end(linker, &table);
>  }


