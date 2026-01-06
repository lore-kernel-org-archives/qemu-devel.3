Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A36EACE9D7F
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 16:42:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdA8c-0001AB-Cq; Tue, 06 Jan 2026 11:42:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vdA8W-00015q-EC; Tue, 06 Jan 2026 11:42:24 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vdA8S-0007iM-Si; Tue, 06 Jan 2026 11:42:24 -0500
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dlxlp5XLSzJ46nx;
 Wed,  7 Jan 2026 00:42:14 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
 by mail.maildlp.com (Postfix) with ESMTPS id 9783E40571;
 Wed,  7 Jan 2026 00:42:16 +0800 (CST)
Received: from localhost (10.195.245.156) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 6 Jan
 2026 16:42:15 +0000
Date: Tue, 6 Jan 2026 16:42:11 +0000
To: Alireza Sanaee <alireza.sanaee@huawei.com>
CC: <qemu-devel@nongnu.org>, <gustavo.romero@linaro.org>,
 <anisinha@redhat.com>, <armbru@redhat.com>, <berrange@redhat.com>,
 <dapeng1.mi@linux.intel.com>, <eric.auger@redhat.com>,
 <farman@linux.ibm.com>, <imammedo@redhat.com>, <jiangkunkun@huawei.com>,
 <maobibo@loongson.cn>, <mst@redhat.com>, <mtosatti@redhat.com>,
 <peter.maydell@linaro.org>, <philmd@linaro.org>, <qemu-arm@nongnu.org>,
 <richard.henderson@linaro.org>, <shannon.zhaosl@gmail.com>,
 <yangyicong@hisilicon.com>, <linuxarm@huawei.com>, <zhao1.liu@intel.com>
Subject: Re: [PATCH v17 6/8] hw/acpi: add cache hierarchy to pptt table
Message-ID: <20260106164211.00006f95@huawei.com>
In-Reply-To: <20260106155828.643-7-alireza.sanaee@huawei.com>
References: <20260106155828.643-1-alireza.sanaee@huawei.com>
 <20260106155828.643-7-alireza.sanaee@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.195.245.156]
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml100005.china.huawei.com (7.214.146.113)
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Jonathan Cameron <jonathan.cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 6 Jan 2026 15:58:25 +0000
Alireza Sanaee <alireza.sanaee@huawei.com> wrote:

> Add cache topology to PPTT table.
> 
> Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>

Some trivial stuff inline around an error message that I think wants a tiny
tweak, mostly because I missunderstood it when rereading this!

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
>  hw/acpi/aml-build.c      | 200 +++++++++++++++++++++++++++++++++++++--
>  hw/arm/virt-acpi-build.c |   8 +-
>  include/hw/acpi/cpu.h    |  10 ++
>  3 files changed, 209 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> index a711a9600e..580eceb24a 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c

>   * ACPI spec, Revision 6.3
>   * 5.2.29 Processor Properties Topology Table (PPTT)
> @@ -2150,11 +2249,32 @@ void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
>  {
>      MachineClass *mc = MACHINE_GET_CLASS(ms);
>      CPUArchIdList *cpus = ms->possible_cpus;
> -    int64_t socket_id = -1, cluster_id = -1, core_id = -1;
> -    uint32_t socket_offset = 0, cluster_offset = 0, core_offset = 0;
> +    uint32_t core_data_offset = 0;
> +    uint32_t core_instr_offset = 0;
> +    uint32_t cluster_instr_offset = 0;
> +    uint32_t cluster_data_offset = 0;
> +    uint32_t node_data_offset = 0;
> +    uint32_t node_instr_offset = 0;
> +    int top_node = 3;
> +    int top_cluster = 3;
> +    int top_core = 3;
> +    int bottom_node = 3;
> +    int bottom_cluster = 3;
> +    int bottom_core = 3;
> +    int64_t socket_id = -1;
> +    int64_t cluster_id = -1;
> +    int64_t core_id = -1;
> +    uint32_t socket_offset = 0;
> +    uint32_t cluster_offset = 0;
> +    uint32_t core_offset = 0;
>      uint32_t pptt_start = table_data->len;
>      uint32_t root_offset;
>      int n;
> +    uint32_t priv_rsrc[2];
> +    uint32_t num_priv = 0;
> +    bool cache_available;
> +    bool llevel;
> +
>      AcpiTable table = { .sig = "PPTT", .rev = 2,
>                          .oem_id = oem_id, .oem_table_id = oem_table_id };
>  
> @@ -2184,11 +2304,30 @@ void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
>              socket_id = cpus->cpus[n].props.socket_id;
>              cluster_id = -1;
>              core_id = -1;
> +            bottom_node = top_node;
> +            num_priv = 0;
> +            cache_available = machine_defines_cache_at_topo_level(
> +                ms, CPU_TOPOLOGY_LEVEL_SOCKET);
> +            llevel = machine_find_lowest_level_cache_at_topo_level(
> +                ms, &bottom_node, CPU_TOPOLOGY_LEVEL_SOCKET);
> +            if (cache_available && llevel) {
> +                build_caches(table_data, pptt_start, num_caches, caches,
> +                             top_node, bottom_node, &node_data_offset,
> +                             &node_instr_offset);
> +                priv_rsrc[0] = node_instr_offset;
> +                priv_rsrc[1] = node_data_offset;
> +                if (node_instr_offset || node_data_offset) {
> +                    num_priv = node_instr_offset == node_data_offset ? 1 : 2;
> +                }
> +
> +                top_cluster = bottom_node - 1;
> +            }
> +
>              socket_offset = table_data->len - pptt_start;
>              build_processor_hierarchy_node(table_data,
>                  (1 << 0) | /* Physical package */
>                  (1 << 4), /* Identical Implementation */
> -                root_offset, socket_id, NULL, 0);
> +                root_offset, socket_id, priv_rsrc, num_priv);
>          }
>  
>          if (mc->smp_props.clusters_supported && mc->smp_props.has_clusters) {
> @@ -2196,21 +2335,68 @@ void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
>                  assert(cpus->cpus[n].props.cluster_id > cluster_id);
>                  cluster_id = cpus->cpus[n].props.cluster_id;
>                  core_id = -1;
> +                bottom_cluster = top_cluster;
> +                num_priv = 0;
> +                cache_available = machine_defines_cache_at_topo_level(
> +                    ms, CPU_TOPOLOGY_LEVEL_CLUSTER);
> +                llevel = machine_find_lowest_level_cache_at_topo_level(
> +                    ms, &bottom_cluster, CPU_TOPOLOGY_LEVEL_CLUSTER);
> +
Trivial consistency thing, but in the equivalent socket block above you don't
have a blank line here.

> +                if (cache_available && llevel) {
> +                    build_caches(table_data, pptt_start, num_caches, caches,
> +                                 top_cluster, bottom_cluster,
> +                                 &cluster_data_offset, &cluster_instr_offset);
> +                    priv_rsrc[0] = cluster_instr_offset;
> +                    priv_rsrc[1] = cluster_data_offset;
> +                    if (cluster_instr_offset || cluster_data_offset) {
> +                        num_priv =
> +                            cluster_instr_offset == cluster_data_offset ? 1 : 2;
> +                    }
> +                    top_core = bottom_cluster - 1;
> +                } else if (top_cluster == bottom_node - 1) {
> +                    /* socket cache but no cluster cache */
> +                    top_core = bottom_node - 1;
> +                }
> +
>                  cluster_offset = table_data->len - pptt_start;
>                  build_processor_hierarchy_node(table_data,
>                      (0 << 0) | /* Not a physical package */
>                      (1 << 4), /* Identical Implementation */
> -                    socket_offset, cluster_id, NULL, 0);
> +                    socket_offset, cluster_id, priv_rsrc, num_priv);
>              }
>          } else {
> +            if (machine_defines_cache_at_topo_level(
> +                    ms, CPU_TOPOLOGY_LEVEL_CLUSTER)) {
> +                error_setg(&error_fatal, "Not clusters found for the cache");

I'd rewrite this error message as something like
"Cache specified for cluster level but no clusters in topology"

> +                return;
> +            }
> +
>              cluster_offset = socket_offset;
> +            top_core = bottom_node - 1; /* there is no cluster */

