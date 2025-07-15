Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2017C83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 09:40:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubc39-0004C1-Gj; Tue, 15 Jul 2025 05:34:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ubc1A-0000za-QH
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 05:32:09 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ubc18-0005nN-Hc
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 05:32:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752571927; x=1784107927;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=0szfmmr3b99jV/AQ05PXrI4IEdV20dMAF3J2PItM0PU=;
 b=hfEXhQ5m0ABNewWB2XmUUwMArbW31w+F7Lylgt4icfcU0GhkAdGZeC7x
 C4JbYCD6UluV3003geqpo2I2Wdr5Sa0PQtyG/jyCKPZBCjHl2SMoLUXh9
 t0thpUvIvfg3GaV2ns1xgaMu7/CFT7F2BHXJPNiuqdOidA465JsjWM6Y4
 i9/ORc5CPzD8Gu0WmrLXd0XlHcJIjS+KdlEA/i7tZBgSSnwPcnPLYLL8N
 p35vZTZ7lEa8lAVX1yGhUy8axzX4cs4z7aK0BWlxu8trRR8wXttY5Ckhi
 O+WWkkTg4HJwLB0hjBYmnAnM+T6Gv+FlJbcsdyXmCcPciGbvhFktbBVmR A==;
X-CSE-ConnectionGUID: ecd+LmU0TTWwHndoLcXFeg==
X-CSE-MsgGUID: vB4UozodTRmXIBjEpb4e3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54656093"
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; d="scan'208";a="54656093"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2025 02:31:29 -0700
X-CSE-ConnectionGUID: pHvkkKjsTFGjt40u7IU3Cw==
X-CSE-MsgGUID: e2gWFKf0R5q1M7U+HNCxEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; d="scan'208";a="156836022"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2025 02:31:01 -0700
Message-ID: <f08283bd-51b7-44a0-821c-544107f46dfa@intel.com>
Date: Tue, 15 Jul 2025 17:30:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v7 2/2] hw/core/machine: Display CPU model name
 in 'info cpus' command
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eric Blake
 <eblake@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250715090624.52377-1-philmd@linaro.org>
 <20250715090624.52377-3-philmd@linaro.org>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250715090624.52377-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.21; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 7/15/2025 5:06 PM, Philippe Mathieu-Daudé wrote:
> Display the CPU model in 'info cpus'. Example before:
> 
>   $ qemu-system-aarch64 -M xlnx-versal-virt -S -monitor stdio
>   QEMU 10.0.0 monitor - type 'help' for more information
>   (qemu) info cpus
>   * CPU #0: thread_id=42924
>     CPU #1: thread_id=42924
>     CPU #2: thread_id=42924
>     CPU #3: thread_id=42924
>   (qemu) q
> 
> and after:
> 
>   $ qemu-system-aarch64 -M xlnx-versal-virt -S -monitor stdio
>   QEMU 10.0.50 monitor - type 'help' for more information
>   (qemu) info cpus
>   * CPU #0: thread_id=42916 model=cortex-a72
>     CPU #1: thread_id=42916 model=cortex-a72
>     CPU #2: thread_id=42916 model=cortex-r5f
>     CPU #3: thread_id=42916 model=cortex-r5f
>   (qemu)
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> Tested-by: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

IIRC, I gave r-b tag before. Anyway,

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>   hw/core/machine-hmp-cmds.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/core/machine-hmp-cmds.c b/hw/core/machine-hmp-cmds.c
> index c6325cdcaaa..54b6f5406dc 100644
> --- a/hw/core/machine-hmp-cmds.c
> +++ b/hw/core/machine-hmp-cmds.c
> @@ -32,6 +32,7 @@ void hmp_info_cpus(Monitor *mon, const QDict *qdict)
>       cpu_list = qmp_query_cpus_fast(NULL);
>   
>       for (cpu = cpu_list; cpu; cpu = cpu->next) {
> +        g_autofree char *cpu_model = cpu_model_from_type(cpu->value->qom_type);
>           int active = ' ';
>   
>           if (cpu->value->cpu_index == monitor_get_cpu_index(mon)) {
> @@ -40,7 +41,8 @@ void hmp_info_cpus(Monitor *mon, const QDict *qdict)
>   
>           monitor_printf(mon, "%c CPU #%" PRId64 ":", active,
>                          cpu->value->cpu_index);
> -        monitor_printf(mon, " thread_id=%" PRId64 "\n", cpu->value->thread_id);
> +        monitor_printf(mon, " thread_id=%" PRId64 " model=%s\n",
> +                       cpu->value->thread_id, cpu_model);
>       }
>   
>       qapi_free_CpuInfoFastList(cpu_list);


