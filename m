Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00A8AC54F30
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 09:52:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJqyM-0000uL-AM; Tue, 27 May 2025 05:51:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1uJqyJ-0000u2-PU
 for qemu-devel@nongnu.org; Tue, 27 May 2025 05:51:47 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1uJqyG-00041U-1l
 for qemu-devel@nongnu.org; Tue, 27 May 2025 05:51:47 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b67F85JQRz6DB5p;
 Tue, 27 May 2025 17:51:24 +0800 (CST)
Received: from frapeml500003.china.huawei.com (unknown [7.182.85.28])
 by mail.maildlp.com (Postfix) with ESMTPS id A18A4140433;
 Tue, 27 May 2025 17:51:25 +0800 (CST)
Received: from localhost (10.47.70.225) by frapeml500003.china.huawei.com
 (7.182.85.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 27 May
 2025 11:51:24 +0200
Date: Tue, 27 May 2025 10:51:21 +0100
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: <qemu-devel@nongnu.org>, <anisinha@redhat.com>, <imammedo@redhat.com>,
 <jonathan.cameron@huawei.com>, <linuxarm@huawei.com>,
 <peter.maydell@linaro.org>, <prime.zeng@hisilicon.com>,
 <shameerali.kolothum.thodi@huawei.com>, <wangyanan55@huawei.com>,
 <yangyicong@hisilicon.com>
Subject: Re: [PATCH v4 3/4] hw/acpi/aml-build: Build a root node in the PPTT
 table
Message-ID: <20250527105121.00005a5f.alireza.sanaee@huawei.com>
In-Reply-To: <20250524063700-mutt-send-email-mst@kernel.org>
References: <20250424122439.550-1-alireza.sanaee@huawei.com>
 <20250424122439.550-4-alireza.sanaee@huawei.com>
 <20250511140938-mutt-send-email-mst@kernel.org>
 <20250519095551.0000525d.alireza.sanaee@huawei.com>
 <20250524063700-mutt-send-email-mst@kernel.org>
Organization: Huawei
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.70.225]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 frapeml500003.china.huawei.com (7.182.85.28)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=alireza.sanaee@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-to:  Alireza Sanaee <alireza.sanaee@huawei.com>
From:  Alireza Sanaee via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, 24 May 2025 06:37:07 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Mon, May 19, 2025 at 09:55:51AM +0100, Alireza Sanaee wrote:
> > On Sun, 11 May 2025 14:10:46 -0400
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >   
> > > On Thu, Apr 24, 2025 at 01:24:38PM +0100, Alireza Sanaee wrote:  
> > > > From: Yicong Yang <yangyicong@hisilicon.com>
> > > > 
> > > > Currently we build the PPTT starting from the socket node and
> > > > each socket will be a separate tree. For a multi-socket system
> > > > it'll be hard for the OS to know the whole system is
> > > > homogeneous or not (actually we're in the current
> > > > implementation) since no parent node to telling the identical
> > > > implementation informentation. Add a root node for indicating
> > > > this.
> > > > 
> > > > Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> > > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
> > > > ---
> > > >  hw/acpi/aml-build.c | 15 ++++++++++++++-
> > > >  1 file changed, 14 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> > > > index 560cee12a24b..3010325ca423 100644
> > > > --- a/hw/acpi/aml-build.c
> > > > +++ b/hw/acpi/aml-build.c
> > > > @@ -2153,12 +2153,25 @@ void build_pptt(GArray *table_data,
> > > > BIOSLinker *linker, MachineState *ms, int64_t socket_id = -1,
> > > > cluster_id = -1, core_id = -1; uint32_t socket_offset = 0,
> > > > cluster_offset = 0, core_offset = 0; uint32_t pptt_start =
> > > > table_data->len;
> > > > +    uint32_t root_offset;
> > > >      int n;
> > > >      AcpiTable table = { .sig = "PPTT", .rev = 2,
> > > >                          .oem_id = oem_id, .oem_table_id =
> > > > oem_table_id }; 
> > > >      acpi_table_begin(&table, table_data);
> > > >  
> > > > +    /*
> > > > +     * Build a root node for all the processor nodes. Otherwise
> > > > when
> > > > +     * building a multi-socket system each socket tree are
> > > > separated    
> > > 
> > > is separated  
> > Hi Michael,
> > 
> > Happy to send another version for this issue, or maybe you can
> > fix this when pulling, if that's the only problem? Up to you :)
> > 
> > Alireza  
> 
> resend pls.
Thanks, I already have.

v5: https://lore.kernel.org/all/20250523102654.1719-1-alireza.sanaee@huawei.com/
> 
> > >   
> > > > +     * and will be hard for the OS like Linux to know whether
> > > > the
> > > > +     * system is homogeneous.
> > > > +     */
> > > > +    root_offset = table_data->len - pptt_start;
> > > > +    build_processor_hierarchy_node(table_data,
> > > > +        (1 << 0) | /* Physical package */
> > > > +        (1 << 4), /* Identical Implementation */
> > > > +        0, 0, NULL, 0);
> > > > +
> > > >      /*
> > > >       * This works with the assumption that cpus[n].props.*_id
> > > > has been
> > > >       * sorted from top to down levels in
> > > > mc->possible_cpu_arch_ids(). @@ -2175,7 +2188,7 @@ void
> > > > build_pptt(GArray *table_data, BIOSLinker *linker, MachineState
> > > > *ms, build_processor_hierarchy_node(table_data, (1 << 0) | /*
> > > > Physical package */ (1 << 4), /* Identical Implementation */
> > > > -                0, socket_id, NULL, 0);
> > > > +                root_offset, socket_id, NULL, 0);
> > > >          }
> > > >  
> > > >          if (mc->smp_props.clusters_supported &&
> > > > mc->smp_props.has_clusters) { -- 
> > > > 2.34.1    
> > > 
> > >   
> 
> 


