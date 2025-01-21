Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44AE1C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 16:24:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taH36-0005Pf-GF; Tue, 21 Jan 2025 11:24:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1taH33-0005PV-Bd
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 11:24:17 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1taH31-0006je-Dt
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 11:24:17 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YcstL0p2dz6M4fG;
 Wed, 22 Jan 2025 00:22:18 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 7537B140A46;
 Wed, 22 Jan 2025 00:24:12 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 21 Jan
 2025 17:24:12 +0100
Date: Tue, 21 Jan 2025 16:24:10 +0000
To: Hongjian Fan <hongjian.fan@seagate.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, <fan.ni@samsung.com>
Subject: Re: [PATCH v2] hw/mem: support zero memory size CXL device
Message-ID: <20250121162410.000009fa@huawei.com>
In-Reply-To: <20241204022618.1572959-1-hongjian.fan@seagate.com>
References: <20241203172328.00001a00@huawei.com>
 <20241204022618.1572959-1-hongjian.fan@seagate.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.086, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue,  3 Dec 2024 20:26:19 -0600
Hongjian Fan <hongjian.fan@seagate.com> wrote:

> This patch allows a CXL type3 device to be initialized with zero memory
> size, when there is no memory device property provided.
> 
> Signed-off-by: Hongjian Fan <hongjian.fan@seagate.com>
Hi Hongjian

Some remaining questions on the v1 thread.
We need to understand a little more on why this is useful to support.
It's adding another thing we need to test so whilst simple it's not
zero maintenance cost.

Thanks,

Jonathan

> ---
>  hw/mem/cxl_type3.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 5cf754b38f..4c9d6b8f17 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -159,7 +159,12 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
>      int len = 0;
>  
>      if (!ct3d->hostpmem && !ct3d->hostvmem && !ct3d->dc.num_regions) {
> -        return 0;
> +        /* zero memory size device. Build one entry with size 0 */
> +        table = g_malloc0(CT3_CDAT_NUM_ENTRIES * sizeof(*table));
> +        ct3_build_cdat_entries_for_mr(&(table[0]), dsmad_handle++,
> +                                0, false, false, 0);
> +        *cdat_table = g_steal_pointer(&table);
> +        return CT3_CDAT_NUM_ENTRIES;
>      }
>  
>      if (ct3d->hostvmem) {
> @@ -712,8 +717,11 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
>  
>      if (!ct3d->hostmem && !ct3d->hostvmem && !ct3d->hostpmem
>          && !ct3d->dc.num_regions) {
> -        error_setg(errp, "at least one memdev property must be set");
> -        return false;
> +        /* no memdev property provided. Default to zero memory size device */
> +        ct3d->cxl_dstate.pmem_size = 0;
> +        ct3d->cxl_dstate.vmem_size = 0;
> +        ct3d->cxl_dstate.static_mem_size = 0;
> +        return true;
>      } else if (ct3d->hostmem && ct3d->hostpmem) {
>          error_setg(errp, "[memdev] cannot be used with new "
>                           "[persistent-memdev] property");


