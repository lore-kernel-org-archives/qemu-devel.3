Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F457C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 09:39:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsf1x-0007gK-KY; Thu, 13 Mar 2025 05:39:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1tsf1w-0007dZ-2k; Thu, 13 Mar 2025 05:39:08 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1tsf1q-0004s1-Gx; Thu, 13 Mar 2025 05:39:07 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZD2SF53CQz6K9YG;
 Thu, 13 Mar 2025 17:36:13 +0800 (CST)
Received: from frapeml500003.china.huawei.com (unknown [7.182.85.28])
 by mail.maildlp.com (Postfix) with ESMTPS id 642B6140A70;
 Thu, 13 Mar 2025 17:38:51 +0800 (CST)
Received: from localhost (10.47.78.235) by frapeml500003.china.huawei.com
 (7.182.85.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 13 Mar
 2025 10:38:50 +0100
Date: Thu, 13 Mar 2025 09:38:44 +0000
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <mst@redhat.com>,
 <zhao1.liu@intel.com>, <dapeng1.mi@linux.intel.com>, <armbru@redhat.com>,
 <farman@linux.ibm.com>, <peter.maydell@linaro.org>, <anisinha@redhat.com>,
 <shannon.zhaosl@gmail.com>, <imammedo@redhat.com>, <mtosatti@redhat.com>,
 <berrange@redhat.com>, <richard.henderson@linaro.org>,
 <shameerali.kolothum.thodi@huawei.com>, <jiangkunkun@huawei.com>,
 <yangyicong@hisilicon.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH v8 4/6] hw/acpi/aml-build.c: add cache hierarchy to pptt
 table
Message-ID: <20250313093844.00006f74.alireza.sanaee@huawei.com>
In-Reply-To: <20250313092456.000024f1@huawei.com>
References: <20250310162337.844-1-alireza.sanaee@huawei.com>
 <20250310162337.844-5-alireza.sanaee@huawei.com>
 <20250313092456.000024f1@huawei.com>
Organization: Huawei
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.78.235]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 frapeml500003.china.huawei.com (7.182.85.28)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=alireza.sanaee@huawei.com; helo=frasgout.his.huawei.com
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
Reply-to:  Alireza Sanaee <alireza.sanaee@huawei.com>
From:  Alireza Sanaee via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 13 Mar 2025 09:24:56 +0000
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> On Mon, 10 Mar 2025 16:23:35 +0000
> Alireza Sanaee <alireza.sanaee@huawei.com> wrote:
> 
> > Add cache topology to PPTT table. With this patch, both ACPI PPTT
> > table and device tree will represent the same cache topology given
> > users input.
> > 
> > Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
> > Co-developed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> > Signed-off-by: Jonathan Cameron <jonathan.cameron@huawei.com>  
> Hi Ali,
> 
> A few trivial style things. You'll need to rebase after 10.0 is out
> anyway, so just tidy these up when you do that.
> 
> Jonathan

Hi Jonathan,

Sure.

Alireza
> 
> > ---
> >  hw/acpi/aml-build.c            | 205
> > ++++++++++++++++++++++++++++++++- hw/arm/virt-acpi-build.c       |
> >  8 +- hw/loongarch/virt-acpi-build.c |   2 +-
> >  include/hw/acpi/aml-build.h    |   4 +-
> >  include/hw/cpu/core.h          |   1 +
> >  5 files changed, 212 insertions(+), 8 deletions(-)
> > 
> > diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> > index e5401dfdb1a8..e2568522660d 100644
> > --- a/hw/acpi/aml-build.c
> > +++ b/hw/acpi/aml-build.c  
> ...
> 
> >  /*
> >   * ACPI spec, Revision 6.3
> >   * 5.2.29.1 Processor hierarchy node structure (Type 0)
> > @@ -2146,15 +2247,24 @@ void build_spcr(GArray *table_data,
> > BIOSLinker *linker,
> >   * 5.2.29 Processor Properties Topology Table (PPTT)
> >   */
> >  void build_pptt(GArray *table_data, BIOSLinker *linker,
> > MachineState *ms,
> > -                const char *oem_id, const char *oem_table_id)
> > +                const char *oem_id, const char *oem_table_id,  
> ...
> 
> > @@ -2184,11 +2294,35 @@ void build_pptt(GArray *table_data,
> > BIOSLinker *linker, MachineState *ms, socket_id =
> > cpus->cpus[n].props.socket_id; cluster_id = -1;
> >              core_id = -1;
> > +            bottom_node = top_node;
> > +            num_priv = 0;
> > +            if (cache_described_at(ms, CPU_TOPOLOGY_LEVEL_SOCKET)
> > &&
> > +                find_the_lowest_level_cache_defined_at_level(
> > +                    ms,
> > +                    &bottom_node,
> > +                    CPU_TOPOLOGY_LEVEL_SOCKET))
> > +            {  
> As below.
> 
> > +                build_caches(table_data, pptt_start,
> > +                             num_caches, caches,
> > +                             n, top_node, bottom_node,
> > +                             &node_data_offset,
> > &node_instr_offset); +
> > +                priv_rsrc[0] = node_instr_offset;
> > +                priv_rsrc[1] = node_data_offset;
> > +
> > +                if (node_instr_offset || node_data_offset) {
> > +                    num_priv = node_instr_offset ==
> > node_data_offset ? 1 : 2;
> > +                }
> > +
> > +                top_cluster = bottom_node - 1;
> > +            }
> > +
> >              socket_offset = table_data->len - pptt_start;
> >              build_processor_hierarchy_node(table_data,
> >                  (1 << 0) | /* Physical package */
> >                  (1 << 4), /* Identical Implementation */
> > -                root_offset, socket_id, NULL, 0);
> > +                root_offset, socket_id,
> > +                priv_rsrc, num_priv);
> >          }
> >  
> >          if (mc->smp_props.clusters_supported &&
> > mc->smp_props.has_clusters) { @@ -2196,21 +2330,81 @@ void
> > build_pptt(GArray *table_data, BIOSLinker *linker, MachineState
> > *ms, assert(cpus->cpus[n].props.cluster_id > cluster_id);
> > cluster_id = cpus->cpus[n].props.cluster_id; core_id = -1;
> > +                bottom_cluster = top_cluster;
> > +                num_priv = 0;
> > +
> > +                if (cache_described_at(ms,
> > CPU_TOPOLOGY_LEVEL_CLUSTER) &&
> > +                    find_the_lowest_level_cache_defined_at_level(
> > +                        ms,
> > +                        &bottom_cluster,
> > +                        CPU_TOPOLOGY_LEVEL_CLUSTER))
> > +                {  
> 
> As below, style not correct.  Please check for other cases.
> 
> > +
> > +                    build_caches(table_data, pptt_start,
> > +                                 num_caches, caches, n,
> > top_cluster,
> > +                                 bottom_cluster,
> > &cluster_data_offset,
> > +                                 &cluster_instr_offset);
> > +
> > +                    priv_rsrc[0] = cluster_instr_offset;
> > +                    priv_rsrc[1] = cluster_data_offset;
> > +
> > +                    if (cluster_instr_offset ||
> > cluster_data_offset) {
> > +                        num_priv =
> > +                        cluster_instr_offset ==
> > cluster_data_offset ? 1 : 2;
> > +                    }
> > +
> > +                    top_core = bottom_cluster - 1;
> > +                } else if (top_cluster == bottom_node - 1) {
> > +                    /* socket cache but no cluster cache */
> > +                    top_core = bottom_node - 1;
> > +                }  
> 
> ...
> 
> > +        if (cpus->cpus[n].props.core_id != core_id) {
> > +            bottom_core = top_core;
> > +            num_priv = 0;
> > +
> > +            if (cache_described_at(ms, CPU_TOPOLOGY_LEVEL_CORE) &&
> > +                find_the_lowest_level_cache_defined_at_level(
> > +                    ms,
> > +                    &bottom_core,
> > +                    CPU_TOPOLOGY_LEVEL_CORE))
> > +            {  
> 
> Trivial but that's not qemu coding style.  Bracket needs to go on end
> of line above.
> 
> > +                build_caches(table_data, pptt_start,
> > +                             num_caches, caches,
> > +                             n, top_core, bottom_core,
> > +                             &core_data_offset,
> > &core_instr_offset); +
> > +                priv_rsrc[0] = core_instr_offset;
> > +                priv_rsrc[1] = core_data_offset;
> > +
> > +                num_priv = core_instr_offset == core_data_offset ?
> > 1 : 2;
> > +            }
> > +        }
> > +
> > +  
> 
> One blank line enough.
> 
> >          if (ms->smp.threads == 1) {
> >              build_processor_hierarchy_node(table_data,
> >                  (1 << 1) | /* ACPI Processor ID valid */
> >                  (1 << 3),  /* Node is a Leaf */
> > -                cluster_offset, n, NULL, 0);
> > +                cluster_offset, n,
> > +                priv_rsrc, num_priv);  
> 
> 


