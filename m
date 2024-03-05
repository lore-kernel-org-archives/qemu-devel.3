Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ECEAC54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 16:10:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhXM4-0007Yu-J1; Tue, 05 Mar 2024 11:09:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rhXM0-0007Xw-4C
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 11:09:21 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rhXLx-00038o-E5
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 11:09:19 -0500
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tq0lJ4frDz6J7ft;
 Wed,  6 Mar 2024 00:05:16 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 42238140DE1;
 Wed,  6 Mar 2024 00:09:12 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 5 Mar
 2024 16:09:09 +0000
Date: Tue, 5 Mar 2024 16:09:08 +0000
To: <nifan.cxl@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
 <gregory.price@memverge.com>, <ira.weiny@intel.com>,
 <dan.j.williams@intel.com>, <a.manzanares@samsung.com>, <dave@stgolabs.net>,
 <nmtadam.samsung@gmail.com>, <jim.harris@samsung.com>,
 <Jorgen.Hansen@wdc.com>, <wj28.lee@gmail.com>, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v5 13/13] qapi/cxl.json: Add QMP interfaces to print out
 accepted and pending DC extents
Message-ID: <20240305160908.000010c5@Huawei.com>
In-Reply-To: <20240304194331.1586191-14-nifan.cxl@gmail.com>
References: <20240304194331.1586191-1-nifan.cxl@gmail.com>
 <20240304194331.1586191-14-nifan.cxl@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
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

On Mon,  4 Mar 2024 11:34:08 -0800
nifan.cxl@gmail.com wrote:

> From: Fan Ni <fan.ni@samsung.com>
> 
> With the change, we add the following two QMP interfaces to print out
> extents information in the device,
> 1. cxl-display-accepted-dc-extents: print out the accepted DC extents in
>    the device;
> 2. cxl-display-pending-to-add-dc-extents: print out the pending-to-add
>    DC extents in the device;
> The output is appended to a file passed to the command and by default
> it is /tmp/dc-extent.txt.
Hi Fan,

Is there precedence for this sort of logging to a file from a qmp
command?  I can see something like this being useful.

A few comments inline.

Jonathan


> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>
> ---
>  hw/mem/cxl_type3.c       | 80 ++++++++++++++++++++++++++++++++++++++++
>  hw/mem/cxl_type3_stubs.c | 12 ++++++
>  qapi/cxl.json            | 32 ++++++++++++++++
>  3 files changed, 124 insertions(+)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 5bd64e604e..6a08e7ae40 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -2089,6 +2089,86 @@ void qmp_cxl_release_dynamic_capacity(const char *path, uint8_t region_id,
>                                       region_id, records, errp);
>  }
>  
> +static void cxl_dcd_display_extent_list(const CXLType3Dev *dcd, const char *f,
> +                                        bool accepted_list, Error **errp)
> +{
> +    const CXLDCExtentList *list;
> +    CXLDCExtent *ent;
> +    FILE *fp = NULL;
> +    int i = 0;
> +
> +    if (!dcd->dc.num_regions) {
> +        error_setg(errp, "No dynamic capacity support from the device");
> +        return;
> +    }
> +
> +    if (!f) {
> +        fp = fopen("/tmp/dc-extent.txt", "a+");
> +    } else {
> +        fp = fopen(f, "a+");
> +    }
> +
> +    if (!fp) {
> +        error_setg(errp, "Open log file failed");
> +        return;
> +    }
> +    if (accepted_list) {
> +        list = &dcd->dc.extents;
> +        fprintf(fp, "Print accepted extent info:\n");
> +    } else {
> +        list = &dcd->dc.extents_pending_to_add;
> +        fprintf(fp, "Print pending-to-add extent info:\n");
> +    }
> +
> +    QTAILQ_FOREACH(ent, list, node) {
> +        fprintf(fp, "%d: [0x%lx - 0x%lx]\n", i++, ent->start_dpa,
> +                               ent->start_dpa + ent->len);
> +    }
> +    fprintf(fp, "In total, %d extents printed!\n", i);
> +    fclose(fp);
> +}

> +void qmp_cxl_display_pending_to_add_dc_extents(const char *path, const char *f,
> +                                               Error **errp)
> +{
> +    Object *obj;
> +    CXLType3Dev *dcd;
> +
> +    obj = object_resolve_path(path, NULL);

As an aside, we could probably flatten a lot of these cases into
object_resolve_path_type()

> +    if (!obj) {
> +        error_setg(errp, "Unable to resolve path");
> +        return;
> +    }
> +    if (!object_dynamic_cast(obj, TYPE_CXL_TYPE3)) {
> +        error_setg(errp, "Path not point to a valid CXL type3 device");
> +        return;
> +    }
> +
> +
> +    dcd = CXL_TYPE3(obj);
> +    cxl_dcd_display_extent_list(dcd, f, false, errp);
> +}
> +
>  static void ct3_class_init(ObjectClass *oc, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(oc);

> diff --git a/qapi/cxl.json b/qapi/cxl.json
> index 2645004666..6f10300ec6 100644
> --- a/qapi/cxl.json
> +++ b/qapi/cxl.json
> @@ -420,3 +420,35 @@
>              'extents': [ 'CXLDCExtentRecord' ]
>             }
>  }
> +
> +##
> +# @cxl-display-accepted-dc-extents:
> +#
> +# Command to print out all the accepted DC extents in the device
> +#
> +# @path: CXL DCD canonical QOM path
> +# @output: path of output file to dump the results to

We take a path, but dump to the same file whatever this is set to?
I'm not sure what precedence there is for qom commands that
dump to a debug log.  Perhaps reference any other cases in the
patch description.  

> +#
> +# Since : 9.0
> +##
> +{ 'command': 'cxl-display-accepted-dc-extents',
> +  'data': { 'path': 'str',
> +            'output': 'str'
> +           }
> +}
> +
> +##
> +# @cxl-display-pending-to-add-dc-extents:
> +#
> +# Command to print out all the pending-to-add DC extents in the device
> +#
> +# @path: CXL DCD canonical QOM path
> +# @output: path of output file to dump the results to
> +#
> +# Since : 9.0
> +##
> +{ 'command': 'cxl-display-pending-to-add-dc-extents',
> +  'data': { 'path': 'str',
> +            'output': 'str'
> +           }
> +}


