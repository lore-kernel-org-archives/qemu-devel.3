Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 467A6CA0EFF
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 10:32:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjyv1-00083a-Hc; Fri, 30 Aug 2024 06:31:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sjyuy-00082Q-PN
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 06:31:48 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sjyuv-0001YU-SE
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 06:31:48 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WwDrN2W7nz6J7t2;
 Fri, 30 Aug 2024 18:28:20 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 6560E140155;
 Fri, 30 Aug 2024 18:31:39 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 30 Aug
 2024 11:31:38 +0100
Date: Fri, 30 Aug 2024 11:31:38 +0100
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
CC: <ardb+tianocore@kernel.org>, <quic_llindhol@quicinc.com>,
 <peter.maydell@linaro.org>, <devel@edk2.groups.io>, <qemu-devel@nongnu.org>,
 <linux-cxl@vger.kernel.org>, <chenbaozi@phytium.com.cn>,
 <wangyinfeng@phytium.com.cn>, <shuyiqi@phytium.com.cn>
Subject: Re: [RFC PATCH edk2-platforms 2/2] SbsaQemu: AcpiTables: Add CEDT
 Table
Message-ID: <20240830113138.00005149@Huawei.com>
In-Reply-To: <20240830031545.548789-3-wangyuquan1236@phytium.com.cn>
References: <20240830031545.548789-1-wangyuquan1236@phytium.com.cn>
 <20240830031545.548789-3-wangyuquan1236@phytium.com.cn>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, 30 Aug 2024 11:15:45 +0800
Yuquan Wang <wangyuquan1236@phytium.com.cn> wrote:

> Provide CXL Early Discovery Table that describes the static CXL
> Platform Components of sbsa-ref.
> 
> This adds a static CXL Host Bridge structure and a CXL Fixed Memory
> Window structure which are implemented as two independent space on
> sbsa-ref: [SBSA_CXL_HOST] & [SBSA_CXL_FIXED_WINDOW].
> 
> Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
A few superficial comments.

I'd love to see a dump of iasl -d for this table in the commit message.
That's much easier to sanity check for spec compliance than reading
the code that creates it.

Jonathan

> ---
>  .../Qemu/SbsaQemu/AcpiTables/AcpiTables.inf   |  6 +-
>  Silicon/Qemu/SbsaQemu/AcpiTables/Cedt.aslc    | 70 +++++++++++++++++++
>  Silicon/Qemu/SbsaQemu/SbsaQemu.dec            |  7 ++
>  3 files changed, 82 insertions(+), 1 deletion(-)
>  create mode 100644 Silicon/Qemu/SbsaQemu/AcpiTables/Cedt.aslc
> 
> diff --git a/Silicon/Qemu/SbsaQemu/AcpiTables/AcpiTables.inf b/Silicon/Qemu/SbsaQemu/AcpiTables/AcpiTables.inf
> index b4d5aa807bd9..f39b06d708d5 100644
> --- a/Silicon/Qemu/SbsaQemu/AcpiTables/AcpiTables.inf
> +++ b/Silicon/Qemu/SbsaQemu/AcpiTables/AcpiTables.inf
> @@ -21,7 +21,7 @@
>    Fadt.aslc
>    Mcfg.aslc
>    Spcr.aslc
> -
> +  Cedt.aslc
Fix up to keep the white space. Also this seems to be alphabetical
order so probably should stick to that.

>  [Packages]
>    ArmPlatformPkg/ArmPlatformPkg.dec
>    ArmPkg/ArmPkg.dec
> @@ -78,6 +78,10 @@
>    gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlBarSize
>    gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlBarLimit
>  
> +  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdChbcrBase
> +  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCfmwsBase
> +  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCfmwsSize
> +
>    gEfiMdeModulePkgTokenSpaceGuid.PcdSerialRegisterBase
>  
>    gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdPlatformAhciBase
> diff --git a/Silicon/Qemu/SbsaQemu/AcpiTables/Cedt.aslc b/Silicon/Qemu/SbsaQemu/AcpiTables/Cedt.aslc
> new file mode 100644
> index 000000000000..66c9dc8858bc
> --- /dev/null
> +++ b/Silicon/Qemu/SbsaQemu/AcpiTables/Cedt.aslc
> @@ -0,0 +1,70 @@
> +/** @file
> +*  CXL Early Discovery Table (CEDT)
> +*
> +*  Copyright (c) 2024, Phytium Technology Co Ltd. All rights reserved.
> +*
> +**/
> +
> +#include <IndustryStandard/CXLEarlyDiscoveryTable.h>
> +#include <IndustryStandard/Acpi64.h>
> +#include <IndustryStandard/SbsaQemuAcpi.h>
> +
> +#pragma pack(1)
> +
> +typedef struct
> +{
> +  EFI_ACPI_6_4_CXL_Early_Discovery_TABLE           Header;
> +  EFI_ACPI_6_4_CXL_Host_Bridge_Structure           Chbs;
> +  EFI_ACPI_6_4_CXL_Fixed_Memory_Window_Structure   Cfmws;
> +} SBSA_REF_CEDT;
> +
> +
> +SBSA_REF_CEDT Cedt =
> +{
> +  // EFI_ACPI_6_4_CXL_Early_Discovery_TABLE(Header)
> +  {
> +     SBSAQEMU_ACPI_HEADER  // EFI_ACPI_DESCRIPTION_HEADER
> +     (
> +       EFI_ACPI_6_4_CXL_EARLY_DISCOVERY_TABLE_SIGNATURE,
> +       SBSA_REF_CEDT,
> +       EFI_ACPI_CXL_Early_Discovery_TABLE_REVISION_01
> +     ),
> +  },
> +  // EFI_ACPI_6_4_CXL_Host_Bridge_Structure
> +  {
> +    // EFI_ACPI_6_4_CEDT_Structure
> +    {
> +        EFI_ACPI_CEDT_TYPE_CHBS,                                 // Type
> +        0,                                                       // Reserved
> +        sizeof (EFI_ACPI_6_4_CXL_Host_Bridge_Structure),         // Length
> +    },
> +    FixedPcdGet32 (PcdCxlBusMin),          // UID
> +    0x1,                                   // CXLVersion
> +    0,                                     // Reserved
> +    FixedPcdGet32 (PcdChbcrBase),          // CHBCR Base
> +    0X10000,                               // Length
> +  },
> +  // EFI_ACPI_6_4_CXL_Fixed_Memory_Window_Structure
> +  {
> +    // EFI_ACPI_6_4_CEDT_Structure
> +    {
> +        EFI_ACPI_CEDT_TYPE_CFMWS,                                // Type
> +        0,                                                       // Reserved
> +        sizeof (EFI_ACPI_6_4_CXL_Fixed_Memory_Window_Structure), // Length
> +    },
> +    0,                                     // Reserved
> +    FixedPcdGet32 (PcdCfmwsBase),          // BaseHPA
> +    FixedPcdGet32 (PcdCfmwsSize),          // WindowSize
> +    0,                                     // InterleaveMembers
> +    0,                                     // InterleaveArithmetic
> +    0,                                     // Reserved1
> +    0,                                     // Granularity
> +    0xF,                                   // Restrictions
> +    0,                                     // QtgId

You'll need to implement the QTG DSM or I think the kernel will still moan at you.


> +    FixedPcdGet32 (PcdCxlBusMin),          // FirstTarget
> +  }
> +};
> +
> +#pragma pack ()
> +
> +VOID* CONST ReferenceAcpiTable = &Cedt;
> diff --git a/Silicon/Qemu/SbsaQemu/SbsaQemu.dec b/Silicon/Qemu/SbsaQemu/SbsaQemu.dec
> index 7d8c7997160b..dff838315d06 100644
> --- a/Silicon/Qemu/SbsaQemu/SbsaQemu.dec
> +++ b/Silicon/Qemu/SbsaQemu/SbsaQemu.dec
> @@ -65,6 +65,13 @@ HardwareInfoLib|Include/Library/HardwareInfoLib.h
>    gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlBusMin|254|UINT32|0x00000019
>    gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlBusMax|255|UINT32|0x00000020
>  
> +  # PCDs complementing base address for CXL CHBCR (CXL Host Bridge Component Registers)
> +  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdChbcrBase|0x60120000|UINT64|0x00000021
> +
> +  # CXL Fixed Memory Window

I'd add an index from the start just to make this easier to extend.
PcdCFwms0Base perhaps?

> +  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCfmwsBase|0xA0000000000|UINT64|0x00000022
> +  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCfmwsSize|0x10000000000|UINT64|0x00000023
> +
>  [PcdsDynamic.common]
>    gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdSystemManufacturer|L""|VOID*|0x00000110
>    gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdSystemSerialNumber|L""|VOID*|0x00000111


