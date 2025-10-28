Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24BC7CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 16:23:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDmRz-0003pQ-Ql; Tue, 28 Oct 2025 12:21:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vDmRx-0003p8-Cm
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 12:21:33 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vDmRm-0001qz-6P
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 12:21:32 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cwwWF2hxhz6M4hV;
 Wed, 29 Oct 2025 00:17:13 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
 by mail.maildlp.com (Postfix) with ESMTPS id C92391402EB;
 Wed, 29 Oct 2025 00:21:02 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 28 Oct
 2025 16:21:02 +0000
Date: Tue, 28 Oct 2025 16:21:00 +0000
To: <anisa.su887@gmail.com>
CC: <qemu-devel@nongnu.org>, <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>, 
 Anisa Su <anisa.su@samsung.com>
Subject: Re: [QEMU PATCH 1/1] hw/cxl/cxl-mailbox-utils: Enable FMAPI
 Initiate Add for MHSLD
Message-ID: <20251028162100.00006fa8@huawei.com>
In-Reply-To: <20250927002125.860668-2-anisa.su887@gmail.com>
References: <20250927002125.860668-1-anisa.su887@gmail.com>
 <20250927002125.860668-2-anisa.su887@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 dubpeml100005.china.huawei.com (7.214.146.113)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-to:  Jonathan Cameron <jonathan.cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, 27 Sep 2025 00:18:07 +0000
anisa.su887@gmail.com wrote:

> From: Anisa Su <anisa.su@samsung.com>
> 
> Call mhd_reserve_extents in FMAPI Init Add (5604h)to enable sending
> FMAPI Add command to MHSLD.
> 
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
Hi Anisa,

I've not been quick on this one partly because it sits on top of the MHSLD
work that I think needs a proper revisit to establish what is an up streamable
path, but I haven't had time to do that :(

Anyhow in meantime I'll take a look.  I suppose nothing stops me carrying
this on top.

Just one minor comment inline.
> ---
>  hw/cxl/cxl-mailbox-utils.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index c5177dfd92..9ac60db4e1 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -24,6 +24,7 @@
>  #include "system/hostmem.h"
>  #include "qemu/range.h"
>  #include "qapi/qapi-types-cxl.h"
> +#include "hw/cxl/mhsld/mhsld.h"
>  
>  #define CXL_CAPACITY_MULTIPLIER   (256 * MiB)
>  #define CXL_DC_EVENT_LOG_SIZE 8
> @@ -4163,6 +4164,8 @@ static CXLRetCode cmd_fm_initiate_dc_add(const struct cxl_cmd *cmd,
>          CXLDCExtentRaw extents[];
>      } QEMU_PACKED *in = (void *)payload_in;
>      CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> +    CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
> +    CXLDCRegion *region = &ct3d->dc.regions[in->reg_num];
>      int i, rc;
>  
>      switch (in->selection_policy) {
> @@ -4201,6 +4204,28 @@ static CXLRetCode cmd_fm_initiate_dc_add(const struct cxl_cmd *cmd,
>                  return rc;
>              }
>  
> +            /* If this is an MHD, attempt to reserve the extents */
> +            if (cvc->mhd_reserve_extents) {
> +                g_autofree CxlDynamicCapacityExtentList *records =
> +                    g_malloc0(in->ext_count * sizeof(*records));

I think it makes sense to use g_malloc0_n for these

I changed this whilst applying it locally so it'll be there next time
I push out a tree.

Thanks,

Jonathan


> +                g_autofree CxlDynamicCapacityExtent *dc_exts =
> +                    g_malloc0(in->ext_count * sizeof(*dc_exts));
> +
> +                for (i = 0; i < in->ext_count; i++) {
> +                    CxlDynamicCapacityExtent *value = &dc_exts[i];
> +                    value->offset =
> +                        in->extents[i].start_dpa - region->base;
> +                    value->len = in->extents[i].len;
> +
> +                    records[i].value = value;
> +                    records[i].next = &records[i + 1];
> +                }
> +                records[in->ext_count - 1].next = NULL;
> +                if (!cvc->mhd_reserve_extents(&ct3d->parent_obj, records, in->reg_num)) {
> +                    return CXL_MBOX_INVALID_INPUT;
> +                }
> +            }
> +
>              CXLDCExtentGroup *group = NULL;
>              for (i = 0; i < in->ext_count; i++) {
>                  CXLDCExtentRaw *ext = &in->extents[i];


