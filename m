Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3DA6C47422
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 11:09:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUPVB-00080s-8q; Mon, 29 Jan 2024 06:08:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rUPV9-00080a-Ek; Mon, 29 Jan 2024 06:08:31 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rUPV7-0004OX-HF; Mon, 29 Jan 2024 06:08:31 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TNlp75wKXz6K61q;
 Mon, 29 Jan 2024 19:05:35 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 6AF44140D1A;
 Mon, 29 Jan 2024 19:08:25 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Jan
 2024 11:08:24 +0000
Date: Mon, 29 Jan 2024 11:08:23 +0000
To: Sia Jee Heng <jeeheng.sia@starfivetech.com>
CC: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <qemu-riscv@nongnu.org>,
 <mst@redhat.com>, <imammedo@redhat.com>, <anisinha@redhat.com>,
 <shannon.zhaosl@gmail.com>, <peter.maydell@linaro.org>,
 <sunilvl@ventanamicro.com>, <palmer@dabbelt.com>, <alistair.francis@wdc.com>, 
 <bin.meng@windriver.com>, <liwei1518@gmail.com>, <dbarboza@ventanamicro.com>, 
 <zhiwei_liu@linux.alibaba.com>
Subject: Re: [RFC v1 3/3] hw/arm/virt-acpi-build.c: Enable CPU cache topology
Message-ID: <20240129110823.000076df@Huawei.com>
In-Reply-To: <20240129081423.116615-4-jeeheng.sia@starfivetech.com>
References: <20240129081423.116615-1-jeeheng.sia@starfivetech.com>
 <20240129081423.116615-4-jeeheng.sia@starfivetech.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 29 Jan 2024 00:14:23 -0800
Sia Jee Heng <jeeheng.sia@starfivetech.com> wrote:

> Introduced a 3-layer cache for the ARM virtual machine.
> 
> Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>

There are a bunch of CPU registers that also need updating to reflect the
described cache.
https://lore.kernel.org/qemu-devel/20230808115713.2613-3-Jonathan.Cameron@huawei.com/
It's called HACK for a reason ;)
But there is some discussion about this issue in the thread.

The l1 etc also needs to reflect the CPU model.  This stuff needs to match.
Wrong information being passed to a VM is probably worse than no information.

Whilst I plan to circle back to the MPAM support (perhaps next month) there
is a lot more to be done here before we have useful cache descriptions for
guests.

Jonathan

> ---
>  hw/arm/virt-acpi-build.c | 44 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 43 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 17aeec7a6f..c57067cd63 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -426,6 +426,48 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      g_array_free(its_idmaps, true);
>  }
>  
> +static void pptt_setup(GArray *table_data, BIOSLinker *linker, MachineState *ms,
> +                       const char *oem_id, const char *oem_table_id)
> +{
> +    CPUCaches default_cache_info = {
> +        .l1d_cache = &(CPUCacheInfo) {
> +            .type = DATA_CACHE,
> +            .size = 64 * KiB,
> +            .line_size = 64,
> +            .associativity = 4,
> +            .sets = 256,
> +            .attributes = 0x02,
> +        },
> +        .l1i_cache = &(CPUCacheInfo) {
> +            .type = INSTRUCTION_CACHE,
> +            .size = 64 * KiB,
> +            .line_size = 64,
> +            .associativity = 4,
> +            .sets = 256,
> +            .attributes = 0x04,

This is the duplication I commented on in patch 1.
The bit set there is the one to indicate it's an instruction
cache and we have type doing that as well.


> +        },
> +        .l2_cache = &(CPUCacheInfo) {
> +            .type = UNIFIED_CACHE,
> +            .size = 2048 * KiB,
> +            .line_size = 64,
> +            .associativity = 8,
> +            .sets = 4096,
> +            .attributes = 0x0a,
> +        },
> +        .l3_cache = &(CPUCacheInfo) {
> +            .type = UNIFIED_CACHE,
> +            .size = 4096 * KiB,
> +            .line_size = 64,
> +            .associativity = 8,
> +            .sets = 8192,
> +            .attributes = 0x0a,
> +        },
> +    };
> +
> +    build_pptt(table_data, linker, ms, oem_id, oem_table_id,
> +               &default_cache_info);
> +}
> +
>  /*
>   * Serial Port Console Redirection Table (SPCR)
>   * Rev: 1.07
> @@ -912,7 +954,7 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>  
>      if (!vmc->no_cpu_topology) {
>          acpi_add_table(table_offsets, tables_blob);
> -        build_pptt(tables_blob, tables->linker, ms,
> +        pptt_setup(tables_blob, tables->linker, ms,
>                     vms->oem_id, vms->oem_table_id);
>      }
>  


