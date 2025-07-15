Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 841CEC83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 09:31:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubbzf-0007Z6-Vn; Tue, 15 Jul 2025 05:30:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ubbzX-0007R1-LM
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 05:30:27 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ubbzS-0005cn-Qn
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 05:30:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752571823; x=1784107823;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=mP0q4YqqaiGLIAwiuXkkrUZ/nN99pTLywY45wJu2+S4=;
 b=Fa1TUHVw4YYmgd7MflLyfmcFDQzX1lNjKw4BgtoDu60O597xlBgVOJA3
 uB91DsfoXM1ZTYbQsZRDwA2yQ+7sV/IlKCmds8G4jLYcRdxFkhVZqiGAs
 2xZ3iAPDrxwngQhUczveIF+4gJBZpynX7Zxh51Dqu1B4IXWqYYH2ZfXW5
 7U41QtAYSUOTu7sDy8uvjQh/O3JGgQrjsQOfn5l6E8bO7/Ib3PK7Y+QwR
 fcvwkMUs5wsQDZU7nd3tG/7hJp1NHVZoFL0oWyjYALe5P8qQUL/9iCHz1
 oe3Na8uvv6I2SbO+irptaTrwsEookPOe93eVXHY59B2JCUpp/CasP+tm8 Q==;
X-CSE-ConnectionGUID: +QfO6TDpRN6E0tSmrOdM2Q==
X-CSE-MsgGUID: jabu5E3DTICrmOga/TgaSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54655820"
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; d="scan'208";a="54655820"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2025 02:30:19 -0700
X-CSE-ConnectionGUID: H7HkxjUyQEuo+VYXkbBp6g==
X-CSE-MsgGUID: dAqX6n9pT/mqL7w8yv3wqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; d="scan'208";a="156835507"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2025 02:30:16 -0700
Message-ID: <aa44356d-7f1b-4718-bff0-e5bfad88bf26@intel.com>
Date: Tue, 15 Jul 2025 17:30:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v7 1/2] qapi/machine: Add @qom-type field to
 CpuInfoFast structure
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eric Blake
 <eblake@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250715090624.52377-1-philmd@linaro.org>
 <20250715090624.52377-2-philmd@linaro.org>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250715090624.52377-2-philmd@linaro.org>
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
> Knowing the QOM type name of a CPU can be useful,
> in particular to infer its model name.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
>   qapi/machine.json          | 3 +++
>   hw/core/machine-qmp-cmds.c | 1 +
>   2 files changed, 4 insertions(+)
> 
> diff --git a/qapi/machine.json b/qapi/machine.json
> index f712e7da6d6..a3f6fcec4d3 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -76,6 +76,8 @@
>   #
>   # @cpu-index: index of the virtual CPU
>   #
> +# @qom-type: QOM type name of the CPU (since 10.1)
> +#
>   # @qom-path: path to the CPU object in the QOM tree
>   #
>   # @thread-id: ID of the underlying host thread
> @@ -89,6 +91,7 @@
>   ##
>   { 'union'         : 'CpuInfoFast',
>     'base'          : { 'cpu-index'    : 'int',
> +                      'qom-type'     : 'str',
>                         'qom-path'     : 'str',
>                         'thread-id'    : 'int',
>                         '*props'       : 'CpuInstanceProperties',
> diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
> index d82043e1c68..5655bfcfee4 100644
> --- a/hw/core/machine-qmp-cmds.c
> +++ b/hw/core/machine-qmp-cmds.c
> @@ -47,6 +47,7 @@ CpuInfoFastList *qmp_query_cpus_fast(Error **errp)
>           value->cpu_index = cpu->cpu_index;
>           value->qom_path = object_get_canonical_path(OBJECT(cpu));
>           value->thread_id = cpu->thread_id;
> +        value->qom_type = g_strdup(object_get_typename(OBJECT(cpu)));
>   
>           if (mc->cpu_index_to_instance_props) {
>               CpuInstanceProperties *props;


