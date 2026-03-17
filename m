Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F8EFED9E8
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 16:47:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2XYr-0003Ok-Pt; Tue, 17 Mar 2026 12:46:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1w2XYi-0003Hb-PT
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 12:46:21 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1w2XYg-0003My-5E
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 12:46:20 -0400
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fZyWQ1B85zHnGdj;
 Wed, 18 Mar 2026 00:45:38 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id 0AFA740587;
 Wed, 18 Mar 2026 00:45:58 +0800 (CST)
Received: from localhost (10.122.19.247) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 17 Mar
 2026 16:45:57 +0000
Date: Tue, 17 Mar 2026 16:45:56 +0000
To: <shiju.jose@huawei.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, <mst@redhat.com>,
 <peter.maydell@linaro.org>, <dave@stgolabs.net>, <linuxarm@huawei.com>
Subject: Re: [PATCH v2 0/3] hw/cxl: Add fixes in maintenance, PPR and event
 records
Message-ID: <20260317164556.0000794d@huawei.com>
In-Reply-To: <20260306101423.986-1-shiju.jose@huawei.com>
References: <20260306101423.986-1-shiju.jose@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.19.247]
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 dubpeml500005.china.huawei.com (7.214.145.207)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 6 Mar 2026 10:14:19 +0000
<shiju.jose@huawei.com> wrote:

> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Add few fixes in CXL maintenance, PPR and event records generation.
All 3 of these look good to me.

Michael, please pick these up directly (assuming you think
they look good as well1)


Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

Thanks,

Jonathan

> 
> 1. In cxl_create_mem_sparing_event_records(), replace strncpy with memcpy
> to solve coverity warning (CID 1645325) to copy the entire component ID
> data, which is 16 bytes data, not a string.
> 
> 2. In cxl_maintenance_insert(),
>  - replace strncpy with memcpy to copy full data because component ID is
>    16 bytes data, not a string.
>  - remove memset which is not required.
> 
> 3. In cxl_perform_ppr(), remove and free the maintenance entry from QLIST
> if match is found and PPR operation is performed.
> 
> 4. Component ID in CXL events is 16 bytes data, not a string, but event
> record generation copy 15 bytes only from the qmp "component-id" field
> using strncpy. Replace strncpy with memcpy and copy the entire component
> ID data.
> 
> Changes:
> v1 -> v2
> 1. Fix for the feedback from Jonathan.
>   - Modified title of patch[1] & patch[3].
>   - Added fixes tags to all 3 patche's header.
> 
> Shiju Jose (3):
>   hw/cxl: Fix handling of component ID to not assume it is a string
>   hw/cxl: Add fixes in Post Package Repair (PPR)
>   hw/cxl/events: Fix handling of component ID in event records
>     generation to not assume it is a string
> 
>  hw/cxl/cxl-mailbox-utils.c |  6 ++++--
>  hw/mem/cxl_type3.c         | 13 ++++---------
>  2 files changed, 8 insertions(+), 11 deletions(-)
> 


