Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09E12CCFA1F
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2024 12:11:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stnL9-0004mC-Jl; Thu, 26 Sep 2024 08:11:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1stnL7-0004kI-LQ; Thu, 26 Sep 2024 08:11:21 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1stnL4-0001gu-RZ; Thu, 26 Sep 2024 08:11:21 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XDsqz3xGYz6J73k;
 Thu, 26 Sep 2024 20:10:39 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 9A8BC1401F3;
 Thu, 26 Sep 2024 20:11:14 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 26 Sep
 2024 14:11:14 +0200
Date: Thu, 26 Sep 2024 13:11:12 +0100
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: Igor Mammedov <imammedo@redhat.com>, Shiju Jose <shiju.jose@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, <linux-kernel@vger.kernel.org>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH 13/15] acpi/ghes: rename etc/hardware_error file macros
Message-ID: <20240926131112.00002c49@Huawei.com>
In-Reply-To: <fb795e722d0b7baf9b1d3c328d7a3b917470194e.1727236561.git.mchehab+huawei@kernel.org>
References: <cover.1727236561.git.mchehab+huawei@kernel.org>
 <fb795e722d0b7baf9b1d3c328d7a3b917470194e.1727236561.git.mchehab+huawei@kernel.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 25 Sep 2024 06:04:18 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Now that we have also have a file to store HEST data location,
> which is part of GHES, better name the file where CPER records
> are stored.
> 
> No functional changes.
> 
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
In general fine, but I'd have preferred if you'd avoided
code realignment where possible so the changes are more minimal
and easier to spot.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  hw/acpi/ghes.c | 32 +++++++++++++++++++-------------
>  1 file changed, 19 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index 209095f67e9a..3d03506fdaf8 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -28,8 +28,8 @@
>  #include "hw/nvram/fw_cfg.h"
>  #include "qemu/uuid.h"
>  
> -#define ACPI_GHES_ERRORS_FW_CFG_FILE        "etc/hardware_errors"
> -#define ACPI_GHES_DATA_ADDR_FW_CFG_FILE     "etc/hardware_errors_addr"
> +#define ACPI_HW_ERROR_FW_CFG_FILE           "etc/hardware_errors"
> +#define ACPI_HW_ERROR_ADDR_FW_CFG_FILE      "etc/hardware_errors_addr"
>  
>  /* The max size in bytes for one error block */
>  #define ACPI_GHES_MAX_RAW_DATA_LENGTH   (1 * KiB)
> @@ -249,7 +249,7 @@ static void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker,
>          ACPI_GHES_MAX_RAW_DATA_LENGTH * num_sources);
>  
>      /* Tell guest firmware to place hardware_errors blob into RAM */
> -    bios_linker_loader_alloc(linker, ACPI_GHES_ERRORS_FW_CFG_FILE,
> +    bios_linker_loader_alloc(linker, ACPI_HW_ERROR_FW_CFG_FILE,
>                               hardware_errors, sizeof(uint64_t), false);
>  
>      for (i = 0; i < num_sources; i++) {
> @@ -258,17 +258,21 @@ static void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker,
>           * corresponding "Generic Error Status Block"
>           */
>          bios_linker_loader_add_pointer(linker,
> -            ACPI_GHES_ERRORS_FW_CFG_FILE, sizeof(uint64_t) * i,
> -            sizeof(uint64_t), ACPI_GHES_ERRORS_FW_CFG_FILE,
> -            error_status_block_offset + i * ACPI_GHES_MAX_RAW_DATA_LENGTH);
> +                                       ACPI_HW_ERROR_FW_CFG_FILE,
> +                                       sizeof(uint64_t) * i,
> +                                       sizeof(uint64_t),
> +                                       ACPI_HW_ERROR_FW_CFG_FILE,
> +                                       error_status_block_offset +
> +                                       i * ACPI_GHES_MAX_RAW_DATA_LENGTH);

I'd rather it kept closer to original formatting so the changes are more obvious.

>      }
>  
>      /*
>       * tell firmware to write hardware_errors GPA into
>       * hardware_errors_addr fw_cfg, once the former has been initialized.
>       */
> -    bios_linker_loader_write_pointer(linker, ACPI_GHES_DATA_ADDR_FW_CFG_FILE,
> -        0, sizeof(uint64_t), ACPI_GHES_ERRORS_FW_CFG_FILE, 0);
> +    bios_linker_loader_write_pointer(linker, ACPI_HW_ERROR_ADDR_FW_CFG_FILE, 0,
> +                                     sizeof(uint64_t),
> +                                     ACPI_HW_ERROR_FW_CFG_FILE, 0);
>  }
>  
>  /* Build Generic Hardware Error Source version 2 (GHESv2) */
> @@ -307,8 +311,10 @@ static void build_ghes_v2(GArray *table_data,
>      build_append_gas(table_data, AML_AS_SYSTEM_MEMORY, 0x40, 0,
>                       4 /* QWord access */, 0);
>      bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
> -        address_offset + GAS_ADDR_OFFSET, sizeof(uint64_t),
> -        ACPI_GHES_ERRORS_FW_CFG_FILE, index * sizeof(uint64_t));
> +                                   address_offset + GAS_ADDR_OFFSET,
> +                                   sizeof(uint64_t),
> +                                   ACPI_HW_ERROR_FW_CFG_FILE,
> +                                   index * sizeof(uint64_t));
As above. Closer to original code alignment and this would be easier to
review.

>  
>      /* Notification Structure */
>      build_ghes_hw_error_notification(table_data, notify);
> @@ -327,7 +333,7 @@ static void build_ghes_v2(GArray *table_data,
>      bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
>                                     address_offset + GAS_ADDR_OFFSET,
>                                     sizeof(uint64_t),
> -                                   ACPI_GHES_ERRORS_FW_CFG_FILE,
> +                                   ACPI_HW_ERROR_FW_CFG_FILE,
>                                     (num_sources + index) * sizeof(uint64_t));
>  
>      /*
> @@ -368,11 +374,11 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
>                            GArray *hardware_error)
>  {
>      /* Create a read-only fw_cfg file for GHES */
> -    fw_cfg_add_file(s, ACPI_GHES_ERRORS_FW_CFG_FILE, hardware_error->data,
> +    fw_cfg_add_file(s, ACPI_HW_ERROR_FW_CFG_FILE, hardware_error->data,
>                      hardware_error->len);
>  
>      /* Create a read-write fw_cfg file for Address */
> -    fw_cfg_add_file_callback(s, ACPI_GHES_DATA_ADDR_FW_CFG_FILE, NULL, NULL,
> +    fw_cfg_add_file_callback(s, ACPI_HW_ERROR_ADDR_FW_CFG_FILE, NULL, NULL,
>          NULL, &(ags->ghes_addr_le), sizeof(ags->ghes_addr_le), false);
>  
>      ags->present = true;


