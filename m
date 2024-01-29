Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64343C47422
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 11:03:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUPPj-00061t-LD; Mon, 29 Jan 2024 06:02:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rUPPh-00061K-Cn; Mon, 29 Jan 2024 06:02:53 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rUPPe-0003Fr-3L; Mon, 29 Jan 2024 06:02:53 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TNlgd01nGz67Xxn;
 Mon, 29 Jan 2024 18:59:57 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 84762140B67;
 Mon, 29 Jan 2024 19:02:46 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Jan
 2024 11:02:45 +0000
Date: Mon, 29 Jan 2024 11:02:44 +0000
To: Sia Jee Heng <jeeheng.sia@starfivetech.com>
CC: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <qemu-riscv@nongnu.org>,
 <mst@redhat.com>, <imammedo@redhat.com>, <anisinha@redhat.com>,
 <shannon.zhaosl@gmail.com>, <peter.maydell@linaro.org>,
 <sunilvl@ventanamicro.com>, <palmer@dabbelt.com>, <alistair.francis@wdc.com>, 
 <bin.meng@windriver.com>, <liwei1518@gmail.com>, <dbarboza@ventanamicro.com>, 
 <zhiwei_liu@linux.alibaba.com>
Subject: Re: [RFC v1 1/3] hw/acpi/aml-build: Add cache structure table
 creation for PPTT table
Message-ID: <20240129110244.0000606b@Huawei.com>
In-Reply-To: <20240129081423.116615-2-jeeheng.sia@starfivetech.com>
References: <20240129081423.116615-1-jeeheng.sia@starfivetech.com>
 <20240129081423.116615-2-jeeheng.sia@starfivetech.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

On Mon, 29 Jan 2024 00:14:21 -0800
Sia Jee Heng <jeeheng.sia@starfivetech.com> wrote:

> Adds cache structure table generation for the Processor Properties
> Topology Table (PPTT) to describe cache hierarchy information for
> ACPI guests.
>=20
> A 3-level cache topology is employed here, referring to the type 1 cache
> structure according to ACPI spec v6.3. The L1 cache and L2 cache are
> private resources for the core, while the L3 cache is the private
> resource for the cluster.
>=20
> In the absence of cluster values in the QEMU command, a 2-layer cache is
> expected. The default cache value should be passed in from the
> architecture code.
>=20
> Examples:
> 3-layer: -smp 4,sockets=3D1,clusters=3D2,cores=3D2,threads=3D1
> 2-layer: -smp 4,sockets=3D1,cores=3D2,threads=3D2
>=20
> Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>

Hi,

I'm not keen on the topology assumptions this is making.
If were to use this on our Kunpeng 920 for guests then the description would
be wrong as we only share the l3 tags at the cluster level, the
L3 is die level (NUMA node). So for the physical machine we present
a cluster with no associated caches.  For other platforms this would be
even further from the truth.

If we are presenting caches in PPTT (which I do want to see) then
we need additional controls to specify the levels at which the
appropriate caches are found.

There have been various proposals for how to do that description:
https://lore.kernel.org/qemu-devel/20230808115713.2613-2-Jonathan.Cameron@h=
uawei.com/
was my brief go at this (and had PPTT cache descriptions).

Maybe it's acceptable to have some defaults.

A few other review comments inline.

Give an example of the disassembled PPTT so we can see what is being
built.  Need to clear if you are sharing descriptions across multiple
instances of a given cache (which is allowed if no cache IDs).
Looks like you do separate entries which is good because that's needed
in latest definition (but wasn't in 6.3 and people built systems that
didn't do separate entries).


> ---
>  hw/acpi/aml-build.c         | 65 ++++++++++++++++++++++++++++++++++---
>  include/hw/acpi/aml-build.h | 26 ++++++++++++++-
>  2 files changed, 85 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> index af66bde0f5..416275fdcc 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c
> @@ -1994,18 +1994,48 @@ static void build_processor_hierarchy_node(GArray=
 *tbl, uint32_t flags,
>      }
>  }
> =20
> +/* ACPI spec, Revision 6.3 Cache type structure (Type 1) */
> +static void build_cache_structure(GArray *tbl,
> +                                  uint32_t next_level,
> +                                  CPUCacheInfo *cache_info)
> +{
> +    /* 1 =E2=80=93 Cache type structure */
> +    build_append_byte(tbl, 1);
> +    /* Length */
> +    build_append_byte(tbl, 24);

If we are introducing cache descriptions, can we jump directly to the latest
definition. That has an extra 4 byte Cache ID field so length is 28.

I need that for MPAM support and I'd rather we didn't go through the churn
of first introducing cache descriptions then updating them (and the tests
etc) soon after.

> +    /* Reserved */
> +    build_append_int_noprefix(tbl, 0, 2);
> +    /* Flags */
> +    build_append_int_noprefix(tbl, 0x7f, 4);
> +    /* Next level cache */
> +    build_append_int_noprefix(tbl, next_level, 4);
> +    /* Size */
> +    build_append_int_noprefix(tbl, cache_info->size, 4);
> +    /* Number of sets */
> +    build_append_int_noprefix(tbl, cache_info->sets, 4);
> +    /* Associativity */
> +    build_append_byte(tbl, cache_info->associativity);
> +    /* Attributes */
> +    build_append_byte(tbl, cache_info->attributes);
> +    /* Line size */
> +    build_append_int_noprefix(tbl, cache_info->line_size, 2);
> +}
> +
>  /*
>   * ACPI spec, Revision 6.3
>   * 5.2.29 Processor Properties Topology Table (PPTT)
>   */
>  void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
> -                const char *oem_id, const char *oem_table_id)
> +                const char *oem_id, const char *oem_table_id,
> +                const CPUCaches *CPUCaches)
>  {
>      MachineClass *mc =3D MACHINE_GET_CLASS(ms);
>      CPUArchIdList *cpus =3D ms->possible_cpus;
>      int64_t socket_id =3D -1, cluster_id =3D -1, core_id =3D -1;
>      uint32_t socket_offset =3D 0, cluster_offset =3D 0, core_offset =3D =
0;
>      uint32_t pptt_start =3D table_data->len;
> +    uint32_t l3_offset =3D 0, priv_num =3D 0;
> +    uint32_t priv_rsrc[3] =3D {0};
>      int n;
>      AcpiTable table =3D { .sig =3D "PPTT", .rev =3D 2,
>                          .oem_id =3D oem_id, .oem_table_id =3D oem_table_=
id };
> @@ -2024,10 +2054,11 @@ void build_pptt(GArray *table_data, BIOSLinker *l=
inker, MachineState *ms,
>              socket_id =3D cpus->cpus[n].props.socket_id;
>              cluster_id =3D -1;
>              core_id =3D -1;
> +            priv_num =3D 0;
>              socket_offset =3D table_data->len - pptt_start;
>              build_processor_hierarchy_node(table_data,
>                  (1 << 0), /* Physical package */
> -                0, socket_id, NULL, 0);
> +                0, socket_id, NULL, priv_num);
>          }
> =20
>          if (mc->smp_props.clusters_supported && mc->smp_props.has_cluste=
rs) {
> @@ -2035,20 +2066,44 @@ void build_pptt(GArray *table_data, BIOSLinker *l=
inker, MachineState *ms,
>                  assert(cpus->cpus[n].props.cluster_id > cluster_id);
>                  cluster_id =3D cpus->cpus[n].props.cluster_id;
>                  core_id =3D -1;
> +                priv_num =3D 0;
> +                l3_offset =3D table_data->len - pptt_start;
> +                /* L3 cache type structure */
> +                if (CPUCaches && CPUCaches->l3_cache) {
> +                    priv_num =3D 1;
> +                    build_cache_structure(table_data, 0, CPUCaches->l3_c=
ache);
> +                }
>                  cluster_offset =3D table_data->len - pptt_start;
>                  build_processor_hierarchy_node(table_data,
>                      (0 << 0), /* Not a physical package */
> -                    socket_offset, cluster_id, NULL, 0);
> +                    socket_offset, cluster_id, &l3_offset, priv_num);
>              }
>          } else {
>              cluster_offset =3D socket_offset;
>          }
> =20
> +        if (CPUCaches) {
> +            /* L2 cache type structure */
> +            priv_rsrc[0] =3D table_data->len - pptt_start;
> +            build_cache_structure(table_data, 0, CPUCaches->l2_cache);
> +
> +            /* L1d cache type structure */
> +            priv_rsrc[1] =3D table_data->len - pptt_start;
> +            build_cache_structure(table_data, priv_rsrc[0],
> +                                  CPUCaches->l1d_cache);
> +
> +            /* L1i cache type structure */
> +            priv_rsrc[2] =3D table_data->len - pptt_start;
> +            build_cache_structure(table_data, priv_rsrc[0],
> +                                  CPUCaches->l1i_cache);
> +
> +            priv_num =3D 3;
Ah.  This one - whilst it's hard to derive from the ACPI spec,
intent is that the hierarchy node should only point to the the caches
that are nearest to that node. So here priv_num should be
covering both the l1i and l1d but not the l2 which should only be
found by following the next level info in the other two caches.

See the example in Figure 5.15 of ACPI 6.5
- the spec doesn't 'enforce' it because the original text
 was vague so that would be backwards compatability issue,=20
but does include
"Only the head of the list needs to be listed as a resource by
a processor node (and counted toward Number of Private Resources")).
Take that as a strong hint!


> +        }
>          if (ms->smp.threads =3D=3D 1) {
>              build_processor_hierarchy_node(table_data,
>                  (1 << 1) | /* ACPI Processor ID valid */
>                  (1 << 3),  /* Node is a Leaf */
> -                cluster_offset, n, NULL, 0);
> +                cluster_offset, n, priv_rsrc, priv_num);
>          } else {
>              if (cpus->cpus[n].props.core_id !=3D core_id) {
>                  assert(cpus->cpus[n].props.core_id > core_id);
> @@ -2063,7 +2118,7 @@ void build_pptt(GArray *table_data, BIOSLinker *lin=
ker, MachineState *ms,
>                  (1 << 1) | /* ACPI Processor ID valid */
>                  (1 << 2) | /* Processor is a Thread */
>                  (1 << 3),  /* Node is a Leaf */
> -                core_offset, n, NULL, 0);
> +                core_offset, n, priv_rsrc, priv_num);
>          }
>      }
> =20
> diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
> index ff2a310270..2dd949f41e 100644
> --- a/include/hw/acpi/aml-build.h
> +++ b/include/hw/acpi/aml-build.h
> @@ -234,6 +234,29 @@ struct CrsRangeSet {
>      GPtrArray *mem_64bit_ranges;
>  } CrsRangeSet;
> =20
> +enum CacheType {
> +    DATA_CACHE,
> +    INSTRUCTION_CACHE,
> +    UNIFIED_CACHE
> +};
> +
> +typedef
> +struct CPUCacheInfo {
> +    enum CacheType type;      /* Cache Type*/
> +    uint32_t size;            /* Size of the cache in bytes */
> +    uint32_t sets;            /* Number of sets in the cache */
> +    uint8_t associativity;    /* Cache associativity */
> +    uint8_t attributes;       /* Cache attributes */

Incorporates the type.  I would avoid duplication by having a couple more
enums to cover the other flags in here rather than having to fill type
in 2 places.

> +    uint16_t line_size;       /* Line size in bytes */
> +} CPUCacheInfo;
> +
> +typedef
> +struct CPUCaches {
> +        CPUCacheInfo *l1d_cache;
> +        CPUCacheInfo *l1i_cache;
> +        CPUCacheInfo *l2_cache;
> +        CPUCacheInfo *l3_cache;
> +} CPUCaches;
> =20
>  /*
>   * ACPI 5.0: 6.4.3.8.2 Serial Bus Connection Descriptors
> @@ -490,7 +513,8 @@ void build_slit(GArray *table_data, BIOSLinker *linke=
r, MachineState *ms,
>                  const char *oem_id, const char *oem_table_id);
> =20
>  void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
> -                const char *oem_id, const char *oem_table_id);
> +                const char *oem_id, const char *oem_table_id,
> +                const CPUCaches *CPUCaches);
> =20
>  void build_fadt(GArray *tbl, BIOSLinker *linker, const AcpiFadtData *f,
>                  const char *oem_id, const char *oem_table_id);


