Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8085DEE209E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 12:50:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voLHT-0000NY-DL; Fri, 06 Feb 2026 07:49:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1voLHS-0000NF-Gk
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 07:49:50 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1voLHQ-00008Z-Gk
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 07:49:50 -0500
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f6v7B5Vz0zHnH9R;
 Fri,  6 Feb 2026 20:49:42 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id 3342B40565;
 Fri,  6 Feb 2026 20:49:47 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 6 Feb
 2026 12:49:46 +0000
Date: Fri, 6 Feb 2026 12:49:42 +0000
To: Alireza Sanaee <alireza.sanaee@huawei.com>
CC: <qemu-devel@nongnu.org>, <linuxarm@huawei.com>, <eblake@redhat.com>,
 <armbru@redhat.com>, <berrange@redhat.com>, <pbonzini@redhat.com>,
 <mst@redhat.com>, <lizhijian@fujitsu.com>, <anisa.su@samsung.com>,
 <linux-cxl@vger.kernel.org>
Subject: Re: [RFC PATCH 7/7] hw/cxl: Add tag-based removal functionality
Message-ID: <20260206124942.00007fb0@huawei.com>
In-Reply-To: <20251127225526.700-8-alireza.sanaee@huawei.com>
References: <20251127225526.700-1-alireza.sanaee@huawei.com>
 <20251127225526.700-8-alireza.sanaee@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml500005.china.huawei.com (7.214.145.207)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-to:  Jonathan Cameron <jonathan.cameron@huawei.com>
From:  Jonathan Cameron via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 27 Nov 2025 22:55:25 +0000
Alireza Sanaee <alireza.sanaee@huawei.com> wrote:

> Add tag based removal, in which alias tear down must be done properly.

I'd add the status check as as separate patch.
Aim to keep the addition of the removal command super simple.

I'm not sure how this interacts with the older handling.  Maybe it's
worth adding a release by tag before all the rest of the series?

Seems like a useful thing on it's own - as is the status check
though I think that interface may need some more thought.

Jonathan

> 
> Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
> ---
>  hw/mem/cxl_type3.c | 119 +++++++++++++++++++++++++++++++++++++++++++++
>  qapi/cxl.json      |  46 ++++++++++++++++++
>  2 files changed, 165 insertions(+)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index d3ea62ef3f..29355792da 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -2186,6 +2186,61 @@ void qmp_cxl_add_dynamic_capacity(const char *path, uint16_t host_id,
>      }
>  }
>  
> +static void qmp_cxl_process_dynamic_capacity_tag_based(const char *path,
> +        uint16_t hid, CXLDCEventType type, uint8_t rid, const char *tag,
> +        CxlDynamicCapacityExtentList *records, Error **errp) {
Check style...  I don't remember qemu doing { on that line.


> +
> +    Object *obj;
> +    CXLType3Dev *dcd;
> +    CXLDCExtentList *list = NULL;
> +    CXLDCExtent *ent;
> +    g_autofree CXLDCExtentRaw *extents = NULL;
> +
> +    obj = object_resolve_path_type(path, TYPE_CXL_TYPE3, NULL);
> +    if (!obj) {
> +        error_setg(errp, "Unable to resolve CXL type 3 device");
> +        return;
> +    }
> +
> +    dcd = CXL_TYPE3(obj);
> +    if (!dcd->dc.num_regions) {
> +        error_setg(errp, "No dynamic capacity support from the device");
> +        return;
> +    }
> +
> +    if (rid >= dcd->dc.num_regions) {
> +        error_setg(errp, "region id is too large");
> +        return;
> +    }
> +
> +    QemuUUID uuid_req;
> +    qemu_uuid_parse(tag, &uuid_req);
> +
> +    list = &dcd->dc.extents;
> +    size_t cap = 8, n = 0;
> +    extents = g_new0(CXLDCExtentRaw, cap);
> +    QTAILQ_FOREACH(ent, list, node) {
> +        QemuUUID uuid_ext;
> +        memcpy(&uuid_ext.data, ent->tag, sizeof(ent->tag));
> +        if (!qemu_uuid_is_equal(&uuid_req, &uuid_ext)) {
> +            continue;
> +        }
> +
> +        if (n == cap) {
> +            cap = cap < 8 ? 8 : cap * 2;
> +            extents = g_renew(CXLDCExtentRaw, extents, cap);
> +        }
> +
> +        extents[n++] = (CXLDCExtentRaw){ .start_dpa = ent->start_dpa,
> +                                         .len = ent->len,
> +                                         .shared_seq = 0 };
> +    }
> +
> +    extents = g_renew(CXLDCExtentRaw, extents, n);
> +    cxl_create_dc_event_records_for_extents(dcd, type, extents, n);
> +    return;
> +}
> +



