Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9055C5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 18:15:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhvmh-00065Z-RR; Wed, 06 Mar 2024 13:14:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rhvmf-000655-M4
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 13:14:29 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rhvmc-00072l-Vc
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 13:14:29 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TqgYq3yHfz6J9Tw;
 Thu,  7 Mar 2024 02:14:23 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 56AB61400D7;
 Thu,  7 Mar 2024 02:14:24 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 6 Mar
 2024 18:14:23 +0000
Date: Wed, 6 Mar 2024 18:14:22 +0000
To: <nifan.cxl@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
 <gregory.price@memverge.com>, <ira.weiny@intel.com>,
 <dan.j.williams@intel.com>, <a.manzanares@samsung.com>, <dave@stgolabs.net>,
 <nmtadam.samsung@gmail.com>, <jim.harris@samsung.com>,
 <Jorgen.Hansen@wdc.com>, <wj28.lee@gmail.com>, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v5 12/13] hw/mem/cxl_type3: Allow to release partial
 extent and extent superset in QMP interface
Message-ID: <20240306181422.00002b75@Huawei.com>
In-Reply-To: <20240304194331.1586191-13-nifan.cxl@gmail.com>
References: <20240304194331.1586191-1-nifan.cxl@gmail.com>
 <20240304194331.1586191-13-nifan.cxl@gmail.com>
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
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On Mon,  4 Mar 2024 11:34:07 -0800
nifan.cxl@gmail.com wrote:

> From: Fan Ni <fan.ni@samsung.com>
> 
> Before the change, the QMP interface used for add/release DC extents
> only allows to release extents that exist in either pending-to-add list
> or accepted list in the device, which means the DPA range of the extent must
> match exactly that of an extent in either list. Otherwise, the release
> request will be ignored.
> 
> With the change, we relax the constraints. As long as the DPA range of the
> extent to release is covered by extents in one of the two lists
> mentioned above, we allow the release.
> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>
Run out of time today,  so just took a very quick look at this.

Seemed fine but similar comments on exit conditions and retry gotos as
earlier patches.

> +/*
> + * Remove all extents whose DPA range has overlaps with  the DPA range
> + * [dpa, dpa + len) from the list, and delete the overlapped portion.
> + * Note:
> + * 1. If the removed extents is fully within the DPA range, delete the extent;
> + * 2. Otherwise, keep the portion that does not overlap, insert new extents to
> + * the list if needed for the un-coverlapped part.
> + */
> +static void cxl_delist_extent_by_dpa_range(CXLDCExtentList *list,
> +                                           uint64_t dpa, uint64_t len)
> +{
> +    CXLDCExtent *ent;
>  
> -    return NULL;
> +process_leftover:

As before can we turn this into a while loop so the exit conditions are 
more obvious?  Based on len I think.


> +    QTAILQ_FOREACH(ent, list, node) {
> +        if (ent->start_dpa <= dpa && dpa < ent->start_dpa + ent->len) {
> +            uint64_t ent_start_dpa = ent->start_dpa;
> +            uint64_t ent_len = ent->len;
> +            uint64_t len1 = dpa - ent_start_dpa;
> +
> +            cxl_remove_extent_from_extent_list(list, ent);
> +            if (len1) {
> +                cxl_insert_extent_to_extent_list(list, ent_start_dpa,
> +                                                 len1, NULL, 0);
> +            }
> +
> +            if (dpa + len <= ent_start_dpa + ent_len) {
> +                uint64_t len2 = ent_start_dpa + ent_len - dpa - len;
> +                if (len2) {
> +                    cxl_insert_extent_to_extent_list(list, dpa + len,
> +                                                     len2, NULL, 0);
> +                }
> +            } else {
> +                len = dpa + len - ent_start_dpa - ent_len;
> +                dpa = ent_start_dpa + ent_len;
> +                goto process_leftover;
> +            }
> +        }
> +    }
>  }
>  
>  /*
> @@ -1915,8 +1966,8 @@ static void qmp_cxl_process_dynamic_capacity(const char *path, CxlEventLog log,
>      list = records;
>      extents = g_new0(CXLDCExtentRaw, num_extents);
>      while (list) {
> -        CXLDCExtent *ent;
>          bool skip_extent = false;
> +        CXLDCExtentList *extent_list;
>  
>          offset = list->value->offset;
>          len = list->value->len;
> @@ -1933,15 +1984,32 @@ static void qmp_cxl_process_dynamic_capacity(const char *path, CxlEventLog log,
>               * remove it from the pending extent list, so later when the add
>               * response for the extent arrives, the device can reject the
>               * extent as it is not in the pending list.
> +             * Now, we can handle the case where the extent covers the DPA

No need for Now. Anyone reading it is look at the cod here.

> +             * range of multiple extents in the pending_to_add list.
> +             * TODO: we do not allow the extent covers range of extents in
> +             * pending_to_add list and accepted list at the same time for now.
>               */
> -            ent = cxl_dc_extent_exists(&dcd->dc.extents_pending_to_add,
> -                        &extents[i]);
> -            if (ent) {
> -                QTAILQ_REMOVE(&dcd->dc.extents_pending_to_add, ent, node);
> -                g_free(ent);
> +            extent_list = &dcd->dc.extents_pending_to_add;
> +            if (cxl_test_dpa_range_covered_by_extents(extent_list,
> +                                                      extents[i].start_dpa,
> +                                                      extents[i].len)) {
> +                cxl_delist_extent_by_dpa_range(extent_list,
> +                                               extents[i].start_dpa,
> +                                               extents[i].len);
> +            } else if (!ct3_test_region_block_backed(dcd, extents[i].start_dpa,
> +                                                     extents[i].len)) {
> +                /*
> +                 * If the DPA range of the extent is not covered by extents
> +                 * in the accepted list, skip
> +                 */
>                  skip_extent = true;
> -            } else if (!cxl_dc_extent_exists(&dcd->dc.extents, &extents[i])) {
> -                /* If the exact extent is not in the accepted list, skip */
> +            }
> +        } else if (type == DC_EVENT_ADD_CAPACITY) {
> +            extent_list = &dcd->dc.extents;
> +            /* If the extent is ready pending to add, skip */
> +            if (cxl_test_dpa_range_covered_by_extents(extent_list,
> +                                                      extents[i].start_dpa,
> +                                                      extents[i].len)) {
>                  skip_extent = true;
>              }
>          }


