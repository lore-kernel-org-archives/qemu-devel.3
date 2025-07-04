Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B7DDC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 03:11:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXWov-0002h3-Vs; Thu, 03 Jul 2025 23:10:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uXWou-0002gl-4p
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 23:10:36 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uXWoq-0007Db-VX
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 23:10:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751598633; x=1783134633;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=qXCD25ut4CAhIeU3RMLzbMxwPuskPekcD++sEt3n6iQ=;
 b=WXIzT68hKxv/hKwvM9BaWaFyblGiOxPRlhpJK94ubutGvdVD0SLJxo4G
 9MxMoX0WuMfjTgbtYSDmHT2e6bIvQjwUzYB1Szp5wTbFUZ/6zMLLl6o4p
 GXKSnnxuYHtk0I4DLgpbMYKM6aYgBdvcXTWEIqysKPN2Xud04zAg+ASvO
 vjdySPWF/6JLoS/QXeHEsVV298fvtY1BL5Mqy9SZzCXdvUEo0A/hWAmp7
 FOcZkJMtkmsK/EMFFJgvxl/GPb4oTP7SKuKNJWDmCbtgW31vAZ52eE3Y0
 ZXcqMUx3+nOINkvnmgPIEc4NnW1Q5sKGQ0mpy9aVNO40cnDc+daTsdXrI g==;
X-CSE-ConnectionGUID: aV+q8xpRTaC7RROLp6oluQ==
X-CSE-MsgGUID: Ij49lPj0SnG0BMpQPww/qg==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="53804862"
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; d="scan'208";a="53804862"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2025 20:10:29 -0700
X-CSE-ConnectionGUID: gbb1yT3WTtGunediYwyc1Q==
X-CSE-MsgGUID: h39tLWyZTTOcJW8XwJ4doA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; d="scan'208";a="154177472"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2025 20:10:26 -0700
Message-ID: <b7fb3201-f892-4352-b84b-239e0f6916c5@intel.com>
Date: Fri, 4 Jul 2025 11:10:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/39] hw/core/machine: Display CPU model name in 'info
 cpus' command
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20250703173248.44995-1-philmd@linaro.org>
 <20250703173248.44995-2-philmd@linaro.org>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250703173248.44995-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.21; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 7/4/2025 1:32 AM, Philippe Mathieu-Daudé wrote:
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
>   * CPU #0: thread_id=42916 (cortex-a72)
>     CPU #1: thread_id=42916 (cortex-a72)
>     CPU #2: thread_id=42916 (cortex-r5f)
>     CPU #3: thread_id=42916 (cortex-r5f)
>   (qemu)

wow, it's really useful to the architectures can run with multiple CPU 
cores.

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> Tested-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>   qapi/machine.json          | 3 +++
>   hw/core/machine-hmp-cmds.c | 3 ++-
>   hw/core/machine-qmp-cmds.c | 1 +
>   3 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/qapi/machine.json b/qapi/machine.json
> index 0650b8de71a..d5bbb5e367e 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -80,6 +80,8 @@
>   #
>   # @thread-id: ID of the underlying host thread
>   #
> +# @model: CPU model name (since 10.1)
> +#
>   # @props: properties associated with a virtual CPU, e.g. the socket id
>   #
>   # @target: the QEMU system emulation target, which determines which
> @@ -91,6 +93,7 @@
>     'base'          : { 'cpu-index'    : 'int',
>                         'qom-path'     : 'str',
>                         'thread-id'    : 'int',
> +                      'model'        : 'str',
>                         '*props'       : 'CpuInstanceProperties',
>                         'target'       : 'SysEmuTarget' },
>     'discriminator' : 'target',
> diff --git a/hw/core/machine-hmp-cmds.c b/hw/core/machine-hmp-cmds.c
> index c6325cdcaaa..65eeb5e9cc2 100644
> --- a/hw/core/machine-hmp-cmds.c
> +++ b/hw/core/machine-hmp-cmds.c
> @@ -40,7 +40,8 @@ void hmp_info_cpus(Monitor *mon, const QDict *qdict)
>   
>           monitor_printf(mon, "%c CPU #%" PRId64 ":", active,
>                          cpu->value->cpu_index);
> -        monitor_printf(mon, " thread_id=%" PRId64 "\n", cpu->value->thread_id);
> +        monitor_printf(mon, " thread_id=%" PRId64 " (%s)\n",
> +                       cpu->value->thread_id, cpu->value->model);
>       }
>   
>       qapi_free_CpuInfoFastList(cpu_list);
> diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
> index d82043e1c68..ab4fd1ec08a 100644
> --- a/hw/core/machine-qmp-cmds.c
> +++ b/hw/core/machine-qmp-cmds.c
> @@ -47,6 +47,7 @@ CpuInfoFastList *qmp_query_cpus_fast(Error **errp)
>           value->cpu_index = cpu->cpu_index;
>           value->qom_path = object_get_canonical_path(OBJECT(cpu));
>           value->thread_id = cpu->thread_id;
> +        value->model = cpu_model_from_type(object_get_typename(OBJECT(cpu)));
>   
>           if (mc->cpu_index_to_instance_props) {
>               CpuInstanceProperties *props;


