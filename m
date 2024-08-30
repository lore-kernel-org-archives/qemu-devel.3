Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0521FCA0FE0
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 11:17:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjzce-0004sO-Ov; Fri, 30 Aug 2024 07:16:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sjzcc-0004jY-1l
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 07:16:54 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sjzcZ-000778-Kj
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 07:16:53 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WwFrN0bfLz6HJlm;
 Fri, 30 Aug 2024 19:13:24 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id DC5B91402C7;
 Fri, 30 Aug 2024 19:16:47 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 30 Aug
 2024 12:16:47 +0100
Date: Fri, 30 Aug 2024 12:16:46 +0100
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
CC: <marcin.juszkiewicz@linaro.org>, <gaoliming@byosoft.com.cn>,
 <michael.d.kinney@intel.com>, <ardb+tianocore@kernel.org>,
 <chenbaozi@phytium.com.cn>, <wangyinfeng@phytium.com.cn>,
 <shuyiqi@phytium.com.cn>, <qemu-devel@nongnu.org>, <devel@edk2.groups.io>
Subject: Re: [RFC PATCH 1/1] MdePkg/IndustryStandard: add definitions for
 ACPI 6.4 CEDT
Message-ID: <20240830121646.0000729a@Huawei.com>
In-Reply-To: <20240830021117.538954-2-wangyuquan1236@phytium.com.cn>
References: <20240830021117.538954-1-wangyuquan1236@phytium.com.cn>
 <20240830021117.538954-2-wangyuquan1236@phytium.com.cn>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, 30 Aug 2024 10:11:17 +0800
Yuquan Wang <wangyuquan1236@phytium.com.cn> wrote:
One request - when cross posting to multiple lists, it is useful to
add something to the patch title to make it clear what is EDK2, what
is QEMU etc.

[RFC EDK2 PATCH 1/1]  

It might irritate the EDK2 folk but it is useful for everyone else
to figure out what they are looking at.

> This adds #defines and struct typedefs for the various structure
> types in the ACPI 6.4 CXL Early Discovery Table (CEDT).

It's in the CXL spec, not ACPI spec so call out in this
patch description that all that was added in ACPI 6.4 was
the reservation of the ID.  The rest needs to refer to appropriate
CXL specifications.

For naming I have no idea on the EDK2 Convention for
structures in specifications other than ACPI that are for
ACPI structures.  The current one is definitely missleading
however.


> 
> Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
> ---
>  MdePkg/Include/IndustryStandard/Acpi64.h      |  5 ++
>  .../IndustryStandard/CXLEarlyDiscoveryTable.h | 69 +++++++++++++++++++
>  2 files changed, 74 insertions(+)
>  create mode 100644 MdePkg/Include/IndustryStandard/CXLEarlyDiscoveryTable.h
> 

> diff --git a/MdePkg/Include/IndustryStandard/CXLEarlyDiscoveryTable.h b/MdePkg/Include/IndustryStandard/CXLEarlyDiscoveryTable.h
> new file mode 100644
> index 0000000000..84f88dc737
> --- /dev/null
> +++ b/MdePkg/Include/IndustryStandard/CXLEarlyDiscoveryTable.h
> @@ -0,0 +1,69 @@
> +/** @file
> +  ACPI CXL Early Discovery Table (CEDT) definitions.
> +
> +  Copyright (c) 2024, Phytium Technology Co Ltd. All rights reserved.
> +
> +**/
> +
> +#ifndef __CXL_Early_Discovery_TABLE_H__
> +#define __CXL_Early_Discovery_TABLE_H__
> +
> +#include <IndustryStandard/Acpi.h>
> +#include <IndustryStandard/Acpi64.h>
> +
> +#define EFI_ACPI_CXL_Early_Discovery_TABLE_REVISION_01  0x1   //CXL2.0
> +#define EFI_ACPI_CXL_Early_Discovery_TABLE_REVISION_02  0x2   //CXL3.1
> +
> +#define EFI_ACPI_CEDT_TYPE_CHBS     0x0
> +#define EFI_ACPI_CEDT_TYPE_CFMWS    0x1

Sensible to add all defines from the start?
So CXIMS, RDPAS and CSDS
(only that last one was added in 3.1 / revision 2.0)


> +} EFI_ACPI_6_4_CEDT_Structure;
> +

> +///
> +/// Definition for CXL Host Bridge Structure
> +///
> +typedef struct {
> +  EFI_ACPI_6_4_CEDT_Structure    header;
> +  UINT32                         UID;
> +  UINT32                         CXLVersion;
> +  UINT32                         Reserved;
> +  UINT64                         Base;
> +  UINT64                         Length;
> +} EFI_ACPI_6_4_CXL_Host_Bridge_Structure;
Should this naming reflect where it's actually defined?
EFI_ACPI_CXL_3_1_CXL_Host_Bridge_Structure etc

> +
> +///
> +/// Definition for CXL Fixed Memory Window Structure
> +///
> +typedef struct {
> +  EFI_ACPI_6_4_CEDT_Structure    header;
> +  UINT32                         Reserved;
> +  UINT64                         BaseHPA;
> +  UINT64                         WindowSize;
> +  UINT8                          InterleaveMembers;
> +  UINT8                          InterleaveArithmetic;
> +  UINT16                         Reserved1;
> +  UINT32                         Granularity;
> +  UINT16                         Restrictions;
> +  UINT16                         QtgId;
> +  UINT32                         FirstTarget;

Is this common for an EDK2 definition?  If it were kernel we'd
be using a [] to indicate this has variable number of elements.
I'm too lazy to check for EDK2 equivalents ;)

> +} EFI_ACPI_6_4_CXL_Fixed_Memory_Window_Structure;
> +
> +#pragma pack()
> +
> +#endif


