Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B19BC47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 15:54:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVCuU-0004wV-Hb; Wed, 31 Jan 2024 10:53:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rVCuS-0004vz-OA; Wed, 31 Jan 2024 10:53:56 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rVCuP-0007Hc-4M; Wed, 31 Jan 2024 10:53:56 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TQ61j5C58z6D8Wg;
 Wed, 31 Jan 2024 23:50:17 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id C92D814058E;
 Wed, 31 Jan 2024 23:53:37 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 31 Jan
 2024 15:53:37 +0000
Date: Wed, 31 Jan 2024 15:53:36 +0000
To: JeeHeng Sia <jeeheng.sia@starfivetech.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "mst@redhat.com" <mst@redhat.com>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "anisinha@redhat.com" <anisinha@redhat.com>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "sunilvl@ventanamicro.com" <sunilvl@ventanamicro.com>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "alistair.francis@wdc.com" <alistair.francis@wdc.com>,
 "bin.meng@windriver.com" <bin.meng@windriver.com>, "liwei1518@gmail.com"
 <liwei1518@gmail.com>, "dbarboza@ventanamicro.com"
 <dbarboza@ventanamicro.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>
Subject: Re: [RFC v1 1/3] hw/acpi/aml-build: Add cache structure table
 creation for PPTT table
Message-ID: <20240131155336.000068d1@Huawei.com>
In-Reply-To: <BJSPR01MB0561E7899F52BC33FAD1A88E9C7DA@BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn>
References: <20240129081423.116615-1-jeeheng.sia@starfivetech.com>
 <20240129081423.116615-2-jeeheng.sia@starfivetech.com>
 <20240129110244.0000606b@Huawei.com>
 <BJSPR01MB0561E7899F52BC33FAD1A88E9C7DA@BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1256"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On Tue, 30 Jan 2024 05:00:57 +0000
JeeHeng Sia <jeeheng.sia@starfivetech.com> wrote:

> > -----Original Message-----
> > From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> > Sent: Monday, January 29, 2024 7:03 PM
> > To: JeeHeng Sia <jeeheng.sia@starfivetech.com>
> > Cc: qemu-devel@nongnu.org; qemu-arm@nongnu.org; qemu-riscv@nongnu.org; mst@redhat.com; imammedo@redhat.com;
> > anisinha@redhat.com; shannon.zhaosl@gmail.com; peter.maydell@linaro.org; sunilvl@ventanamicro.com; palmer@dabbelt.com;
> > alistair.francis@wdc.com; bin.meng@windriver.com; liwei1518@gmail.com; dbarboza@ventanamicro.com;
> > zhiwei_liu@linux.alibaba.com
> > Subject: Re: [RFC v1 1/3] hw/acpi/aml-build: Add cache structure table creation for PPTT table
> > 
> > On Mon, 29 Jan 2024 00:14:21 -0800
> > Sia Jee Heng <jeeheng.sia@starfivetech.com> wrote:
> >   
> > > Adds cache structure table generation for the Processor Properties
> > > Topology Table (PPTT) to describe cache hierarchy information for
> > > ACPI guests.
> > >
> > > A 3-level cache topology is employed here, referring to the type 1 cache
> > > structure according to ACPI spec v6.3. The L1 cache and L2 cache are
> > > private resources for the core, while the L3 cache is the private
> > > resource for the cluster.
> > >
> > > In the absence of cluster values in the QEMU command, a 2-layer cache is
> > > expected. The default cache value should be passed in from the
> > > architecture code.
> > >
> > > Examples:
> > > 3-layer: -smp 4,sockets=1,clusters=2,cores=2,threads=1
> > > 2-layer: -smp 4,sockets=1,cores=2,threads=2
> > >
> > > Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>  
> > 
> > Hi,
> > 
> > I'm not keen on the topology assumptions this is making.
> > If were to use this on our Kunpeng 920 for guests then the description would
> > be wrong as we only share the l3 tags at the cluster level, the
> > L3 is die level (NUMA node). So for the physical machine we present
> > a cluster with no associated caches.  For other platforms this would be
> > even further from the truth.  
> Should you consider a file like kunpeng920.c and then pass the necessary
> value to the build_pptt() function?

No.  This will vary across all CPUs and we don't want a separate
file for every type of CPU. This needs to be controlled from the
qemu commandline or similar.

> > 
> > If we are presenting caches in PPTT (which I do want to see) then
> > we need additional controls to specify the levels at which the
> > appropriate caches are found.  
> I understood and I'm wonder if adding default value meet your needs?

Default is fine, but I would want to see a control interface from the
start so there is an obvious way to correct any configuration for
which the defaults are unsuited.

> > 
> > There have been various proposals for how to do that description:
> > https://lore.kernel.org/qemu-devel/20230808115713.2613-2-Jonathan.Cameron@huawei.com/
> > was my brief go at this (and had PPTT cache descriptions).  
> I can spend time to try out your patches, but it will be good for a
> short command. Btw, it seems you stop for many months, do you
> plan for a v2 or I will continue by update with your v2?

Lots to do and that achieved it's main aim which was to test he
MPAM code from arm.  I'll get back to it fairly soon.

https://mail.gnu.org/archive/html/qemu-devel/2023-02/msg05167.html referenced
form that thread includes some other proposals on topology description.

https://lore.kernel.org/qemu-devel/20240108082727.420817-1-zhao1.liu@linux.intel.com/
and other threads earlier for that discuss some of the options for
topology description.


> > 
> > Maybe it's acceptable to have some defaults.  
> I would suggest to have some default value.
> > 
> > A few other review comments inline.
> > 
> > Give an example of the disassembled PPTT so we can see what is being
> > built.  Need to clear if you are sharing descriptions across multiple
> > instances of a given cache (which is allowed if no cache IDs).
> > Looks like you do separate entries which is good because that's needed
> > in latest definition (but wasn't in 6.3 and people built systems that
> > didn't do separate entries).  
> Sure, here is the example output with clusters=2,core=2,thread=1
> [000h 0000 004h]                   Signature : "PPTT"    [Processor Properties Topology Table]
> [004h 0004 004h]                Table Length : 00000208
> [008h 0008 001h]                    Revision : 02
> [009h 0009 001h]                    Checksum : 88
> [00Ah 0010 006h]                      Oem ID : "BOCHS "
> [010h 0016 008h]                Oem Table ID : "BXPC    "
> [018h 0024 004h]                Oem Revision : 00000001
> [01Ch 0028 004h]             Asl Compiler ID : "BXPC"
> [020h 0032 004h]       Asl Compiler Revision : 00000001
> 
> 
> [024h 0036 001h]               Subtable Type : 00 [Processor Hierarchy Node]
> [025h 0037 001h]                      Length : 14
> [026h 0038 002h]                    Reserved : 0000
> [028h 0040 004h]       Flags (decoded below) : 00000001
>                             Physical package : 1
>                      ACPI Processor ID valid : 0
>                        Processor is a thread : 0
>                               Node is a leaf : 0
>                     Identical Implementation : 0
> [02Ch 0044 004h]                      Parent : 00000000
> [030h 0048 004h]           ACPI Processor ID : 00000000
> [034h 0052 004h]     Private Resource Number : 00000000
> [038h 0056 001h]               Subtable Type : 01 [Cache Type]
> [039h 0057 001h]                      Length : 18
> [03Ah 0058 002h]                    Reserved : 0000
> [03Ch 0060 004h]       Flags (decoded below) : 0000007F
>                                   Size valid : 1
>                         Number of Sets valid : 1
>                          Associativity valid : 1
>                        Allocation Type valid : 1
>                             Cache Type valid : 1
>                           Write Policy valid : 1
>                              Line Size valid : 1
>                               Cache ID valid : 0
> [040h 0064 004h]         Next Level of Cache : 00000000
> [044h 0068 004h]                        Size : 00400000
> [048h 0072 004h]              Number of Sets : 00002000
> [04Ch 0076 001h]               Associativity : 08
> [04Dh 0077 001h]                  Attributes : 0A
>                              Allocation Type : 2
>                                   Cache Type : 2
>                                 Write Policy : 0
> [04Eh 0078 002h]                   Line Size : 0040
> 
> [050h 0080 001h]               Subtable Type : 00 [Processor Hierarchy Node]
> [051h 0081 001h]                      Length : 18
> [052h 0082 002h]                    Reserved : 0000
> [054h 0084 004h]       Flags (decoded below) : 00000000
>                             Physical package : 0
>                      ACPI Processor ID valid : 0
>                        Processor is a thread : 0
>                               Node is a leaf : 0
>                     Identical Implementation : 0
> [058h 0088 004h]                      Parent : 00000024
> [05Ch 0092 004h]           ACPI Processor ID : 00000000
> [060h 0096 004h]     Private Resource Number : 00000001
> [064h 0100 004h]            Private Resource : 00000038
> [068h 0104 001h]               Subtable Type : 01 [Cache Type]
> [069h 0105 001h]                      Length : 18
> [06Ah 0106 002h]                    Reserved : 0000
> [06Ch 0108 004h]       Flags (decoded below) : 0000007F
>                                   Size valid : 1
>                         Number of Sets valid : 1
>                          Associativity valid : 1
>                        Allocation Type valid : 1
>                             Cache Type valid : 1
>                           Write Policy valid : 1
>                              Line Size valid : 1
>                               Cache ID valid : 0
> [070h 0112 004h]         Next Level of Cache : 00000000
> [074h 0116 004h]                        Size : 00200000
> [078h 0120 004h]              Number of Sets : 00001000
> [07Ch 0124 001h]               Associativity : 08
> [07Dh 0125 001h]                  Attributes : 0A
>                              Allocation Type : 2
>                                   Cache Type : 2
>                                 Write Policy : 0
> [07Eh 0126 002h]                   Line Size : 0040
> 
> [080h 0128 001h]               Subtable Type : 01 [Cache Type]
> [081h 0129 001h]                      Length : 18
> [082h 0130 002h]                    Reserved : 0000
> [084h 0132 004h]       Flags (decoded below) : 0000007F
>                                   Size valid : 1
>                         Number of Sets valid : 1
>                          Associativity valid : 1
>                        Allocation Type valid : 1
>                             Cache Type valid : 1
>                           Write Policy valid : 1
>                              Line Size valid : 1
>                               Cache ID valid : 0
> [088h 0136 004h]         Next Level of Cache : 00000068
> [08Ch 0140 004h]                        Size : 00010000
> [090h 0144 004h]              Number of Sets : 00000100
> [094h 0148 001h]               Associativity : 04
> [095h 0149 001h]                  Attributes : 02
>                              Allocation Type : 2
>                                   Cache Type : 0
>                                 Write Policy : 0
> [096h 0150 002h]                   Line Size : 0040
> [098h 0152 001h]               Subtable Type : 01 [Cache Type]
> [099h 0153 001h]                      Length : 18
> [09Ah 0154 002h]                    Reserved : 0000
> [09Ch 0156 004h]       Flags (decoded below) : 0000007F
>                                   Size valid : 1
>                         Number of Sets valid : 1
>                          Associativity valid : 1
>                        Allocation Type valid : 1
>                             Cache Type valid : 1
>                           Write Policy valid : 1
>                              Line Size valid : 1
>                               Cache ID valid : 0
> [0A0h 0160 004h]         Next Level of Cache : 00000068
> [0A4h 0164 004h]                        Size : 00010000
> [0A8h 0168 004h]              Number of Sets : 00000100
> [0ACh 0172 001h]               Associativity : 04
> [0ADh 0173 001h]                  Attributes : 04
>                              Allocation Type : 0
>                                   Cache Type : 1
>                                 Write Policy : 0
> [0AEh 0174 002h]                   Line Size : 0040
> 
> [0B0h 0176 001h]               Subtable Type : 00 [Processor Hierarchy Node]
> [0B1h 0177 001h]                      Length : 20
> [0B2h 0178 002h]                    Reserved : 0000
> [0B4h 0180 004h]       Flags (decoded below) : 0000000A
>                             Physical package : 0
>                      ACPI Processor ID valid : 1
>                        Processor is a thread : 0
>                               Node is a leaf : 1
>                     Identical Implementation : 0
> [0B8h 0184 004h]                      Parent : 00000050
> [0BCh 0188 004h]           ACPI Processor ID : 00000000
> [0C0h 0192 004h]     Private Resource Number : 00000003
> [0C4h 0196 004h]            Private Resource : 00000068
> [0C8h 0200 004h]            Private Resource : 00000080
> [0CCh 0204 004h]            Private Resource : 00000098

Thanks.  I'd obey the ACPI spec example and not list the l2
directly as a private resource.

> > 
> >   
> > > ---
> > >  hw/acpi/aml-build.c         | 65 ++++++++++++++++++++++++++++++++++---
> > >  include/hw/acpi/aml-build.h | 26 ++++++++++++++-
> > >  2 files changed, 85 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> > > index af66bde0f5..416275fdcc 100644
> > > --- a/hw/acpi/aml-build.c
> > > +++ b/hw/acpi/aml-build.c
> > > @@ -1994,18 +1994,48 @@ static void build_processor_hierarchy_node(GArray *tbl, uint32_t flags,
> > >      }
> > >  }
> > >
> > > +/* ACPI spec, Revision 6.3 Cache type structure (Type 1) */
> > > +static void build_cache_structure(GArray *tbl,
> > > +                                  uint32_t next_level,
> > > +                                  CPUCacheInfo *cache_info)
> > > +{
> > > +    /* 1 â€“ Cache type structure */
> > > +    build_append_byte(tbl, 1);
> > > +    /* Length */
> > > +    build_append_byte(tbl, 24);  
> > 
> > If we are introducing cache descriptions, can we jump directly to the latest
> > definition. That has an extra 4 byte Cache ID field so length is 28.  
> We don’t have the compatible acpi guest to test it, do you?

Yes. James' MPAM tree requires it.

https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/log/?h=mpam/snapshot/v6.7-rc2

Specifically it's used here:
https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/commit/?h=mpam/snapshot/v6.7-rc2&id=7bf596309dc800428c5ca5bfabe5053e45e47cfb


> > 
> > I need that for MPAM support and I'd rather we didn't go through the churn
> > of first introducing cache descriptions then updating them (and the tests
> > etc) soon after.  
> Does your acpi os support the cache id?

The kernel tree above requires it as you can't do MPAM for caches
without it.


> >   
> > > +    /* Reserved */
> > > +    build_append_int_noprefix(tbl, 0, 2);
> > > +    /* Flags */
> > > +    build_append_int_noprefix(tbl, 0x7f, 4);
> > > +    /* Next level cache */
> > > +    build_append_int_noprefix(tbl, next_level, 4);
> > > +    /* Size */
> > > +    build_append_int_noprefix(tbl, cache_info->size, 4);
> > > +    /* Number of sets */
> > > +    build_append_int_noprefix(tbl, cache_info->sets, 4);
> > > +    /* Associativity */
> > > +    build_append_byte(tbl, cache_info->associativity);
> > > +    /* Attributes */
> > > +    build_append_byte(tbl, cache_info->attributes);
> > > +    /* Line size */
> > > +    build_append_int_noprefix(tbl, cache_info->line_size, 2);
> > > +}
> > > +
> > >  /*
> > >   * ACPI spec, Revision 6.3
> > >   * 5.2.29 Processor Properties Topology Table (PPTT)
> > >   */
> > >  void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
> > > -                const char *oem_id, const char *oem_table_id)
> > > +                const char *oem_id, const char *oem_table_id,
> > > +                const CPUCaches *CPUCaches)
> > >  {
> > >      MachineClass *mc = MACHINE_GET_CLASS(ms);
> > >      CPUArchIdList *cpus = ms->possible_cpus;
> > >      int64_t socket_id = -1, cluster_id = -1, core_id = -1;
> > >      uint32_t socket_offset = 0, cluster_offset = 0, core_offset = 0;
> > >      uint32_t pptt_start = table_data->len;
> > > +    uint32_t l3_offset = 0, priv_num = 0;
> > > +    uint32_t priv_rsrc[3] = {0};
> > >      int n;
> > >      AcpiTable table = { .sig = "PPTT", .rev = 2,
> > >                          .oem_id = oem_id, .oem_table_id = oem_table_id };
> > > @@ -2024,10 +2054,11 @@ void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
> > >              socket_id = cpus->cpus[n].props.socket_id;
> > >              cluster_id = -1;
> > >              core_id = -1;
> > > +            priv_num = 0;
> > >              socket_offset = table_data->len - pptt_start;
> > >              build_processor_hierarchy_node(table_data,
> > >                  (1 << 0), /* Physical package */
> > > -                0, socket_id, NULL, 0);
> > > +                0, socket_id, NULL, priv_num);
> > >          }
> > >
> > >          if (mc->smp_props.clusters_supported && mc->smp_props.has_clusters) {
> > > @@ -2035,20 +2066,44 @@ void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
> > >                  assert(cpus->cpus[n].props.cluster_id > cluster_id);
> > >                  cluster_id = cpus->cpus[n].props.cluster_id;
> > >                  core_id = -1;
> > > +                priv_num = 0;
> > > +                l3_offset = table_data->len - pptt_start;
> > > +                /* L3 cache type structure */
> > > +                if (CPUCaches && CPUCaches->l3_cache) {
> > > +                    priv_num = 1;
> > > +                    build_cache_structure(table_data, 0, CPUCaches->l3_cache);
> > > +                }
> > >                  cluster_offset = table_data->len - pptt_start;
> > >                  build_processor_hierarchy_node(table_data,
> > >                      (0 << 0), /* Not a physical package */
> > > -                    socket_offset, cluster_id, NULL, 0);
> > > +                    socket_offset, cluster_id, &l3_offset, priv_num);
> > >              }
> > >          } else {
> > >              cluster_offset = socket_offset;
> > >          }
> > >
> > > +        if (CPUCaches) {
> > > +            /* L2 cache type structure */
> > > +            priv_rsrc[0] = table_data->len - pptt_start;
> > > +            build_cache_structure(table_data, 0, CPUCaches->l2_cache);
> > > +
> > > +            /* L1d cache type structure */
> > > +            priv_rsrc[1] = table_data->len - pptt_start;
> > > +            build_cache_structure(table_data, priv_rsrc[0],
> > > +                                  CPUCaches->l1d_cache);
> > > +
> > > +            /* L1i cache type structure */
> > > +            priv_rsrc[2] = table_data->len - pptt_start;
> > > +            build_cache_structure(table_data, priv_rsrc[0],
> > > +                                  CPUCaches->l1i_cache);
> > > +
> > > +            priv_num = 3;  
> > Ah.  This one - whilst it's hard to derive from the ACPI spec,
> > intent is that the hierarchy node should only point to the the caches
> > that are nearest to that node. So here priv_num should be
> > covering both the l1i and l1d but not the l2 which should only be  
> We can follow kunpeng arch, np.

You can follow one generation - I make no statement on future ones.
I don't mind that much what defaults are, I just want to be sure there
is some control available.


> > found by following the next level info in the other two caches.
> > 
> > See the example in Figure 5.15 of ACPI 6.5
> > - the spec doesn't 'enforce' it because the original text
> >  was vague so that would be backwards compatability issue,
> > but does include
> > "Only the head of the list needs to be listed as a resource by
> > a processor node (and counted toward Number of Private Resources")).
> > Take that as a strong hint!
> > 
> >   
> > > +        }
> > >          if (ms->smp.threads == 1) {
> > >              build_processor_hierarchy_node(table_data,
> > >                  (1 << 1) | /* ACPI Processor ID valid */
> > >                  (1 << 3),  /* Node is a Leaf */
> > > -                cluster_offset, n, NULL, 0);
> > > +                cluster_offset, n, priv_rsrc, priv_num);
> > >          } else {
> > >              if (cpus->cpus[n].props.core_id != core_id) {
> > >                  assert(cpus->cpus[n].props.core_id > core_id);
> > > @@ -2063,7 +2118,7 @@ void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
> > >                  (1 << 1) | /* ACPI Processor ID valid */
> > >                  (1 << 2) | /* Processor is a Thread */
> > >                  (1 << 3),  /* Node is a Leaf */
> > > -                core_offset, n, NULL, 0);
> > > +                core_offset, n, priv_rsrc, priv_num);
> > >          }
> > >      }
> > >
> > > diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
> > > index ff2a310270..2dd949f41e 100644
> > > --- a/include/hw/acpi/aml-build.h
> > > +++ b/include/hw/acpi/aml-build.h
> > > @@ -234,6 +234,29 @@ struct CrsRangeSet {
> > >      GPtrArray *mem_64bit_ranges;
> > >  } CrsRangeSet;
> > >
> > > +enum CacheType {
> > > +    DATA_CACHE,
> > > +    INSTRUCTION_CACHE,
> > > +    UNIFIED_CACHE
> > > +};
> > > +
> > > +typedef
> > > +struct CPUCacheInfo {
> > > +    enum CacheType type;      /* Cache Type*/
> > > +    uint32_t size;            /* Size of the cache in bytes */
> > > +    uint32_t sets;            /* Number of sets in the cache */
> > > +    uint8_t associativity;    /* Cache associativity */
> > > +    uint8_t attributes;       /* Cache attributes */  
> > 
> > Incorporates the type.  I would avoid duplication by having a couple more
> > enums to cover the other flags in here rather than having to fill type
> > in 2 places.  
> This struct is almost identical to the acpi guest os, it gives great readability.

Then drop CacheType as there is no such entry in the ACPI table.
Use some macros to extract it form the attributes.

I'd prefer flags broken up, but it's fine to use attributes if you prefer that.
Having both is not fine.


> >   
> > > +    uint16_t line_size;       /* Line size in bytes */
> > > +} CPUCacheInfo;
> > > +
> > > +typedef
> > > +struct CPUCaches {
> > > +        CPUCacheInfo *l1d_cache;
> > > +        CPUCacheInfo *l1i_cache;
> > > +        CPUCacheInfo *l2_cache;
> > > +        CPUCacheInfo *l3_cache;
> > > +} CPUCaches;
> > >
> > >  /*
> > >   * ACPI 5.0: 6.4.3.8.2 Serial Bus Connection Descriptors
> > > @@ -490,7 +513,8 @@ void build_slit(GArray *table_data, BIOSLinker *linker, MachineState *ms,
> > >                  const char *oem_id, const char *oem_table_id);
> > >
> > >  void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
> > > -                const char *oem_id, const char *oem_table_id);
> > > +                const char *oem_id, const char *oem_table_id,
> > > +                const CPUCaches *CPUCaches);
> > >
> > >  void build_fadt(GArray *tbl, BIOSLinker *linker, const AcpiFadtData *f,
> > >                  const char *oem_id, const char *oem_table_id);  
> 


