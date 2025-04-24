Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BDEDC369D1
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 10:12:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7tYa-0001Lb-0L; Thu, 24 Apr 2025 06:11:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1u7tYR-0001L3-Cz
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 06:11:39 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1u7tYP-00055Z-3A
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 06:11:39 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Zjs8p2W4xz6M4KQ;
 Thu, 24 Apr 2025 18:07:22 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id F2FBF1400DB;
 Thu, 24 Apr 2025 18:11:32 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 24 Apr
 2025 12:11:32 +0200
Date: Thu, 24 Apr 2025 11:11:31 +0100
To: <anisa.su887@gmail.com>
CC: <qemu-devel@nongnu.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
 <linux-cxl@vger.kernel.org>, Anisa Su <anisa.su@samsung.com>
Subject: Re: [PATCH 1/9] cxl/type3: Add supported block sizes bitmask to
 CXLDCRegion struct
Message-ID: <20250424111131.00005ff2@huawei.com>
In-Reply-To: <20250317164204.2299371-2-anisa.su887@gmail.com>
References: <20250317164204.2299371-1-anisa.su887@gmail.com>
 <20250317164204.2299371-2-anisa.su887@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Mon, 17 Mar 2025 16:31:28 +0000
anisa.su887@gmail.com wrote:

> From: Anisa Su <anisa.su@samsung.com>
> 
> Add supported_blk_size field to CXLDCRegion struct in preparation for
> next patch. It is needed by command 0x5600 Get DC Region Config.
Hi Anisa,

Sorry it took me so long to your series!

Squash this with patch 2.  It isn't complex enough addition to justify
as separate patch where we need to explain it is there for that patch
in the cover letter.

> 
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
> ---
>  hw/mem/cxl_type3.c          | 3 +++
>  include/hw/cxl/cxl_device.h | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 11c38a9292..731497ebda 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -8,6 +8,7 @@
>   *
>   * SPDX-License-Identifier: GPL-v2-only
>   */
> +#include <math.h>
>  
>  #include "qemu/osdep.h"
>  #include "qemu/units.h"
> @@ -766,6 +767,7 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
>      uint64_t region_len;
>      uint64_t decode_len;
>      uint64_t blk_size = 2 * MiB;
> +    uint64_t supported_blk_size_bitmask = BIT((int) log2(blk_size));

Isn't this going in circles?  I guess it sort of acts as documentation that it
is a bitmap but then the name is already doing that. 
Maybe set it to blk_size and add a comment that for now only a fixed block size
is supported?

I'm a little confused on what this is for given you don't check it in patch 6
which is changing the block size?

>      CXLDCRegion *region;
>      MemoryRegion *mr;
>      uint64_t dc_size;
> @@ -811,6 +813,7 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
>              .block_size = blk_size,
>              /* dsmad_handle set when creating CDAT table entries */
>              .flags = 0,
> +            .supported_blk_size_bitmask = supported_blk_size_bitmask,
>          };
>          ct3d->dc.total_capacity += region->len;
>          region->blk_bitmap = bitmap_new(region->len / region->block_size);
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index ca515cab13..bebed04085 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -608,6 +608,7 @@ typedef struct CXLDCRegion {
>      uint32_t dsmadhandle;
>      uint8_t flags;
>      unsigned long *blk_bitmap;
> +    uint64_t supported_blk_size_bitmask;
>  } CXLDCRegion;
>  
>  typedef struct CXLSetFeatureInfo {


