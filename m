Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CD63C3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 13:34:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHN6t-0000Ka-QT; Tue, 20 May 2025 09:34:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uHN6s-0000KS-D5
 for qemu-devel@nongnu.org; Tue, 20 May 2025 09:34:22 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uHN6q-0000y0-4s
 for qemu-devel@nongnu.org; Tue, 20 May 2025 09:34:21 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b1wRp1Mxjz6L5H6;
 Tue, 20 May 2025 21:31:02 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 77B7C14050C;
 Tue, 20 May 2025 21:34:10 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 20 May
 2025 15:34:10 +0200
Date: Tue, 20 May 2025 14:34:08 +0100
To: <anisa.su887@gmail.com>
CC: <qemu-devel@nongnu.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
 <linux-cxl@vger.kernel.org>, Anisa Su <anisa.su@samsung.com>
Subject: Re: [PATCH v2 09/10] cxl-mailbox-utils: 0x5604 - FMAPI Initiate DC Add
Message-ID: <20250520143408.00003237@huawei.com>
In-Reply-To: <20250508001754.122180-10-anisa.su887@gmail.com>
References: <20250508001754.122180-1-anisa.su887@gmail.com>
 <20250508001754.122180-10-anisa.su887@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu,  8 May 2025 00:01:05 +0000
anisa.su887@gmail.com wrote:

> From: Anisa Su <anisa.su@samsung.com>
> 
> FM DCD Management command 0x5604 implemented per CXL r3.2 Spec Section 7.6.7.6.5
> 
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
A few really minor things inline.

> ---
>  hw/cxl/cxl-mailbox-utils.c   | 195 +++++++++++++++++++++++++++++++++++
>  hw/mem/cxl_type3.c           |   8 +-
>  include/hw/cxl/cxl_device.h  |   4 +
>  include/hw/cxl/cxl_opcodes.h |   1 +
>  4 files changed, 204 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index a897a34ef9..9b176dea08 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -3589,6 +3589,194 @@ static CXLRetCode cmd_fm_get_dc_region_extent_list(const struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> +static CXLRetCode cxl_mbox_dc_prescriptive_sanity_check(CXLType3Dev *dcd,
> +                                                        uint16_t host_id,
> +                                                        uint32_t ext_count,
> +                                                        CXLDCExtentRaw extents[],
> +                                                        CXLDCEventType type)
> +{
> +    CXLDCExtentRaw ext;
> +    CXLDCRegion *reg = NULL;

I'd move reg declaration into the loop and not initialize it to NULL.
Probably also j and ext.


> +    int i, j;
> +
> +    if (host_id != 0) {
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +
> +    for (i = 0; i < ext_count; i++) {
> +        ext = extents[i];
> +
> +        if (ext.len == 0) {
> +            return CXL_MBOX_INVALID_EXTENT_LIST;
> +        }
> +
> +        reg = cxl_find_dc_region(dcd, ext.start_dpa, ext.len);
> +        if (!reg) {
> +            return CXL_MBOX_INVALID_EXTENT_LIST;
> +        }
> +
> +        if (ext.len % reg->block_size || ext.start_dpa % reg->block_size) {
> +            return CXL_MBOX_INVALID_EXTENT_LIST;
> +        }
> +
> +        /* Check requested extents do not overlap with each other. */
> +        for (j = i + 1; j < ext_count; j++) {
> +            if (ranges_overlap(ext.start_dpa, ext.len, extents[j].start_dpa,
> +                               extents[j].len)) {
> +                return CXL_MBOX_INVALID_EXTENT_LIST;
> +            }
> +        }
> +
> +        if (type == DC_EVENT_ADD_CAPACITY) {
> +            /* Check requested extents do not overlap with pending extents. */
> +            if (cxl_extent_groups_overlaps_dpa_range(&dcd->dc.extents_pending,
> +                ext.start_dpa, ext.len)) {

Misaligned parameters.

> +                return CXL_MBOX_INVALID_EXTENT_LIST;
> +            }
> +            /* Check requested extents do not overlap with existing extents. */
> +            if (cxl_extents_overlaps_dpa_range(&dcd->dc.extents,
> +                                               ext.start_dpa, ext.len)) {
> +                return CXL_MBOX_INVALID_EXTENT_LIST;
> +            }
> +        }
> +    }
> +
> +    return CXL_MBOX_SUCCESS;
> +}

