Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51AECC54ED1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 16:07:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJwo9-0007o7-6b; Tue, 27 May 2025 12:05:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uJwo5-0007mj-G3; Tue, 27 May 2025 12:05:37 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uJwnx-0006SR-23; Tue, 27 May 2025 12:05:36 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b6HVw1Q9sz6K9D6;
 Wed, 28 May 2025 00:03:52 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 6E8BF14050D;
 Wed, 28 May 2025 00:05:02 +0800 (CST)
Received: from localhost (10.122.19.247) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 27 May
 2025 18:05:01 +0200
Date: Tue, 27 May 2025 17:04:59 +0100
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Fan Ni
 <fan.ni@samsung.com>, Peter Maydell <peter.maydell@linaro.org>,
 "mst@redhat.com" <mst@redhat.com>, "linux-cxl@vger.kernel.org"
 <linux-cxl@vger.kernel.org>, "linuxarm@huawei.com" <linuxarm@huawei.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Yuquan Wang
 <wangyuquan1236@phytium.com.cn>, Itaru Kitayama <itaru.kitayama@linux.dev>,
 Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v13 2/5] hw/cxl: Make the CXL fixed memory windows devices.
Message-ID: <20250527170459.00002418@huawei.com>
In-Reply-To: <1c90834e-f4ed-4707-8d46-57bc37fbf320@fujitsu.com>
References: <20250513111455.128266-1-Jonathan.Cameron@huawei.com>
 <20250513111455.128266-3-Jonathan.Cameron@huawei.com>
 <1c90834e-f4ed-4707-8d46-57bc37fbf320@fujitsu.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.19.247]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
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

On Fri, 16 May 2025 05:44:34 +0000
"Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com> wrote:

> On 13/05/2025 19:14, Jonathan Cameron via wrote:
> > Previously these somewhat device like structures were tracked using a list
> > in the CXLState in each machine.  This is proving restrictive in a few
> > cases where we need to iterate through these without being aware of the
> > machine type. Just make them sysbus devices.  
> Make sense.
> 
> Minor comments inline

> > diff --git a/hw/acpi/cxl.c b/hw/acpi/cxl.c
> > index 9cd7905ea2..20806e5dd4 100644
> > --- a/hw/acpi/cxl.c
> > +++ b/hw/acpi/cxl.c
> > @@ -22,6 +22,7 @@
> >   #include "hw/pci/pci_bridge.h"
> >   #include "hw/pci/pci_host.h"
> >   #include "hw/cxl/cxl.h"
> > +#include "hw/cxl/cxl_host.h"
> >   #include "hw/mem/memory-device.h"
> >   #include "hw/acpi/acpi.h"
> >   #include "hw/acpi/aml-build.h"
> > @@ -135,56 +136,62 @@ static void cedt_build_chbs(GArray *table_data, PXBCXLDev *cxl)
> >    * Interleave ways encoding in CXL 2.0 ECN: 3, 6, 12 and 16-way memory
> >    * interleaving.
> >    */
> > -static void cedt_build_cfmws(GArray *table_data, CXLState *cxls)
> > +static int cedt_build_cfmws(Object *obj, void *opaque)  
> 
> Too much unrelated indent updates in this function

Fan addressed this.  It's due to the loop now being external to this
call.

> 
> 
> >   {
> > -    GList *it;
> > +    struct CXLFixedWindow *fw;
> > +    Aml *cedt = opaque;
> > +    GArray *table_data = cedt->buf;
> > +    int i;
> >   
> > -    for (it = cxls->fixed_windows; it; it = it->next) {
> > -        CXLFixedWindow *fw = it->data;
> > -        int i;
> > +    if (!object_dynamic_cast(obj, TYPE_CXL_FMW)) {
> > +        return 0;  
> 
> Never reach here? It seems the caller has ensured passing TYPE_CXL_FMW obj.

Excellent point.  Further than that, now the iterator is gone
I can just pass in correctly typed pointers from the caller
which is a nice to have as well!

> 
> 
> 
> 
> > +    }
> > +    fw = CXL_FMW(obj);
> >   
> > -        /* Type */
> > -        build_append_int_noprefix(table_data, 1, 1);
> > +    /* Type */
> > +    build_append_int_noprefix(table_data, 1, 1);
> >   
> > -        /* Reserved */
> > -        build_append_int_noprefix(table_data, 0, 1);
> > +    /* Reserved */
> > +    build_append_int_noprefix(table_data, 0, 1);
> >   
> > -        /* Record Length */
> > -        build_append_int_noprefix(table_data, 36 + 4 * fw->num_targets, 2);
> > +    /* Record Length */
> > +    build_append_int_noprefix(table_data, 36 + 4 * fw->num_targets, 2);
> >   
> > -        /* Reserved */
> > -        build_append_int_noprefix(table_data, 0, 4);
> > +    /* Reserved */
> > +    build_append_int_noprefix(table_data, 0, 4);
> >   
> > -        /* Base HPA */
> > -        build_append_int_noprefix(table_data, fw->mr.addr, 8);
> > +    /* Base HPA */
> > +    build_append_int_noprefix(table_data, fw->mr.addr, 8);
> >   
> > -        /* Window Size */
> > -        build_append_int_noprefix(table_data, fw->size, 8);
> > +    /* Window Size */
> > +    build_append_int_noprefix(table_data, fw->size, 8);
> >   
> > -        /* Host Bridge Interleave Ways */
> > -        build_append_int_noprefix(table_data, fw->enc_int_ways, 1);
> > +    /* Host Bridge Interleave Ways */
> > +    build_append_int_noprefix(table_data, fw->enc_int_ways, 1);
> >   
> > -        /* Host Bridge Interleave Arithmetic */
> > -        build_append_int_noprefix(table_data, 0, 1);
> > +    /* Host Bridge Interleave Arithmetic */
> > +    build_append_int_noprefix(table_data, 0, 1);
> >   
> > -        /* Reserved */
> > -        build_append_int_noprefix(table_data, 0, 2);
> > +    /* Reserved */
> > +    build_append_int_noprefix(table_data, 0, 2);
> >   
> > -        /* Host Bridge Interleave Granularity */
> > -        build_append_int_noprefix(table_data, fw->enc_int_gran, 4);
> > +    /* Host Bridge Interleave Granularity */
> > +    build_append_int_noprefix(table_data, fw->enc_int_gran, 4);
> >   
> > -        /* Window Restrictions */
> > -        build_append_int_noprefix(table_data, 0x0f, 2); /* No restrictions */
> > +    /* Window Restrictions */
> > +    build_append_int_noprefix(table_data, 0x0f, 2);
> >   
> > -        /* QTG ID */
> > -        build_append_int_noprefix(table_data, 0, 2);
> > +    /* QTG ID */
> > +    build_append_int_noprefix(table_data, 0, 2);
> >   
> > -        /* Host Bridge List (list of UIDs - currently bus_nr) */
> > -        for (i = 0; i < fw->num_targets; i++) {
> > -            g_assert(fw->target_hbs[i]);
> > -            build_append_int_noprefix(table_data, PXB_DEV(fw->target_hbs[i])->bus_nr, 4);
> > -        }
> > +    /* Host Bridge List (list of UIDs - currently bus_nr) */
> > +    for (i = 0; i < fw->num_targets; i++) {
> > +        g_assert(fw->target_hbs[i]);
> > +        build_append_int_noprefix(table_data,
> > +                                  PXB_DEV(fw->target_hbs[i])->bus_nr, 4);
> >       }
> > +
> > +    return 0;
> >   }

> > index cae4afcdde..13eb6bf6a4 100644
> > --- a/hw/cxl/cxl-host-stubs.c
> > +++ b/hw/cxl/cxl-host-stubs.c
> > @@ -8,8 +8,12 @@

> > +
> > +struct cfmw_update_state {
> > +    hwaddr base;
> > +    hwaddr maxaddr;
> > +};
> > +
> > +static void cxl_fmws_update(Object *obj, void *opaque)
> > +{
> > +    struct CXLFixedWindow *fw;
> > +    struct cfmw_update_state *s = opaque;
> > +
> > +    if (!object_dynamic_cast(obj, TYPE_CXL_FMW)) {  
> 
> 
> Never reach here? It seems the caller has ensured passing TYPE_CXL_FMW obj.

Also a good point.  Here as well I can simply pass the
correct type of pointer in for this and hwaddr *base, hwaddr max_addr
removing the need for cfmw_update_state()

That is all stale infrastructure from before I changed this handling
to force the device order.

Thanks,

Jonathan


