Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AF60C54E4A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 15:41:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1red5a-0003MJ-Uu; Mon, 26 Feb 2024 10:40:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1red5Y-0003La-5L; Mon, 26 Feb 2024 10:40:20 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1red5S-0001ES-3m; Mon, 26 Feb 2024 10:40:18 -0500
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tk4Sg116Hz6K6VK;
 Mon, 26 Feb 2024 23:35:31 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 1708B140A08;
 Mon, 26 Feb 2024 23:39:50 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 26 Feb
 2024 15:39:49 +0000
Date: Mon, 26 Feb 2024 15:39:47 +0000
To: Zhao Liu <zhao1.liu@linux.intel.com>
CC: "Daniel P . =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>, "Eduardo
 Habkost" <eduardo@habkost.net>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@linaro.org>, Yanan Wang <wangyanan55@huawei.com>, "Michael S .
 Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Richard
 Henderson" <richard.henderson@linaro.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, 
 Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Peter Maydell
 <peter.maydell@linaro.org>, "Sia Jee Heng" <jeeheng.sia@starfivetech.com>,
 <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>, <qemu-riscv@nongnu.org>,
 <qemu-arm@nongnu.org>, "Zhenyu Wang" <zhenyu.z.wang@intel.com>, Dapeng Mi
 <dapeng1.mi@linux.intel.com>, Yongwei Ma <yongwei.ma@intel.com>, Zhao Liu
 <zhao1.liu@intel.com>
Subject: Re: [RFC 4/8] hw/core: Add cache topology options in -smp
Message-ID: <20240226153947.00006fd6@Huawei.com>
In-Reply-To: <20240220092504.726064-5-zhao1.liu@linux.intel.com>
References: <20240220092504.726064-1-zhao1.liu@linux.intel.com>
 <20240220092504.726064-5-zhao1.liu@linux.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
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

On Tue, 20 Feb 2024 17:25:00 +0800
Zhao Liu <zhao1.liu@linux.intel.com> wrote:

> From: Zhao Liu <zhao1.liu@intel.com>
> 
> Add "l1d-cache", "l1i-cache". "l2-cache", and "l3-cache" options in
> -smp to define the cache topology for SMP system.
> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Hi Zhao Liu

I like the scheme.  Strikes a good balance between complexity of description
and systems that actually exist. Sure there are systems with more cache
levels etc but they are rare and support can be easily added later
if people want to model them.

A few minor comments inline.

Jonathan
> ---
>  hw/core/machine-smp.c | 128 ++++++++++++++++++++++++++++++++++++++++++
>  hw/core/machine.c     |   4 ++
>  qapi/machine.json     |  14 ++++-
>  system/vl.c           |  15 +++++
>  4 files changed, 160 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/core/machine-smp.c b/hw/core/machine-smp.c
> index 8a8296b0d05b..2cbd19f4aa57 100644
> --- a/hw/core/machine-smp.c
> +++ b/hw/core/machine-smp.c
> @@ -61,6 +61,132 @@ static char *cpu_hierarchy_to_string(MachineState *ms)
>      return g_string_free(s, false);
>  }
>  
> +static bool machine_check_topo_support(MachineState *ms,
> +                                       CPUTopoLevel topo)
> +{
> +    MachineClass *mc = MACHINE_GET_CLASS(ms);
> +
> +    if (topo == CPU_TOPO_LEVEL_MODULE && !mc->smp_props.modules_supported) {
> +        return false;
> +    }
> +
> +    if (topo == CPU_TOPO_LEVEL_CLUSTER && !mc->smp_props.clusters_supported) {
> +        return false;
> +    }
> +
> +    if (topo == CPU_TOPO_LEVEL_DIE && !mc->smp_props.dies_supported) {
> +        return false;
> +    }
> +
> +    if (topo == CPU_TOPO_LEVEL_BOOK && !mc->smp_props.books_supported) {
> +        return false;
> +    }
> +
> +    if (topo == CPU_TOPO_LEVEL_DRAWER && !mc->smp_props.drawers_supported) {
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
> +static int smp_cache_string_to_topology(MachineState *ms,

Not a good name for a function that does rather more than that.

> +                                        char *topo_str,
> +                                        CPUTopoLevel *topo,
> +                                        Error **errp)
> +{
> +    *topo = string_to_cpu_topo(topo_str);
> +
> +    if (*topo == CPU_TOPO_LEVEL_MAX || *topo == CPU_TOPO_LEVEL_INVALID) {
> +        error_setg(errp, "Invalid cache topology level: %s. The cache "
> +                   "topology should match the CPU topology level", topo_str);
> +        return -1;
> +    }
> +
> +    if (!machine_check_topo_support(ms, *topo)) {
> +        error_setg(errp, "Invalid cache topology level: %s. The topology "
> +                   "level is not supported by this machine", topo_str);
> +        return -1;
> +    }
> +
> +    return 0;
> +}
> +
> +static void machine_parse_smp_cache_config(MachineState *ms,
> +                                           const SMPConfiguration *config,
> +                                           Error **errp)
> +{
> +    MachineClass *mc = MACHINE_GET_CLASS(ms);
> +
> +    if (config->l1d_cache) {
> +        if (!mc->smp_props.l1_separated_cache_supported) {
> +            error_setg(errp, "L1 D-cache topology not "
> +                       "supported by this machine");
> +            return;
> +        }
> +
> +        if (smp_cache_string_to_topology(ms, config->l1d_cache,
> +            &ms->smp_cache.l1d, errp)) {

Indent is to wrong opening bracket.
Same for other cases.


> +            return;
> +        }
> +    }

> +}
> +
>  /*
>   * machine_parse_smp_config: Generic function used to parse the given
>   *                           SMP configuration
> @@ -249,6 +375,8 @@ void machine_parse_smp_config(MachineState *ms,
>                     mc->name, mc->max_cpus);
>          return;
>      }
> +
> +    machine_parse_smp_cache_config(ms, config, errp);
>  }
>  
>  unsigned int machine_topo_get_cores_per_socket(const MachineState *ms)


