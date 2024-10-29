Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6880FD2AB3E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 13:22:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5m9q-0000AV-BT; Tue, 29 Oct 2024 09:21:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t5m9n-0000A5-QF
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 09:21:11 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t5m9g-0007Nw-R3
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 09:21:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730208065; x=1761744065;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=pC840BIA9GXB59AHCLL02bmZnX6ZvGGHfYFkXdFaxRI=;
 b=VywQIi20nA9M50n3seHFseHMqaaO4+yGgbhaBZjCY3S5uLpCESFcEmam
 upDMRLMQMF2d8ywqUGtjYDPQbPL4j8X4yFPXkTkQ8fj051LG95P1JLKhX
 6VmDKV4MnH1si9R+hw8qLIkwQZBBqHJww8RihZ7g/qa0E7p3QjGPPYd8C
 VK/mj5U+MJBy/Ji6bY3khhVzezL5tsz94FGbY33P73XfrOMUrXSDK28k/
 0uZLasAmgtz2VHzMznQu148SCG9uoNsBYa5vG0Ud2NyyPSDsLxJJicKCc
 rJEBkBIXjIA76SkO1xf21DWjG/Wh4HlUWu+MnfXPnLWkfO1p/bc1fLtDK Q==;
X-CSE-ConnectionGUID: t5Fwyf+dQZOqxwjPzw1etQ==
X-CSE-MsgGUID: kKUWirRqR/28D0fDC0t/iw==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="40430831"
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; d="scan'208";a="40430831"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2024 06:21:01 -0700
X-CSE-ConnectionGUID: xdYOwmJ9R7qGYzWLD904cw==
X-CSE-MsgGUID: E1eARmqkS2CeSGdC9NLHEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; d="scan'208";a="82768478"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa008.jf.intel.com with ESMTP; 29 Oct 2024 06:20:59 -0700
Date: Tue, 29 Oct 2024 21:37:18 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Bibo Mao <maobibo@loongson.cn>
Cc: Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org,
 Xianglai Li <lixianglai@loongson.cn>, Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH v2 2/4] hw/loongarch/virt: Implement cpu plug interface
Message-ID: <ZyDlDjkO8ewhiE/m@intel.com>
References: <20241029095335.2219343-1-maobibo@loongson.cn>
 <20241029095335.2219343-3-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029095335.2219343-3-maobibo@loongson.cn>
Received-SPF: pass client-ip=192.198.163.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.302,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

(CC Igor since I want to refer his comment on hotplug design.)

Hi Bibo,

I have some comments about your hotplug design.

[snip]

> +static void virt_cpu_pre_plug(HotplugHandler *hotplug_dev,
> +                              DeviceState *dev, Error **errp)
> +{
> +    LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(hotplug_dev);
> +    MachineState *ms = MACHINE(OBJECT(hotplug_dev));
> +    LoongArchCPU *cpu = LOONGARCH_CPU(dev);
> +    CPUState *cs = CPU(dev);
> +    CPUArchId *cpu_slot;
> +    Error *local_err = NULL;
> +    LoongArchCPUTopo topo;
> +    int arch_id, index = 0;

[snip]

> +    if (cpu->phy_id == UNSET_PHY_ID) {
> +        error_setg(&local_err, "CPU hotplug not supported");
> +        goto out;
> +    } else {
> +        /*
> +         * For non hot-add cpu, topo property is not set. And only physical id
> +         * property is set, setup topo information from physical id.
> +         *
> +         * Supposing arch_id is equal to cpu slot index
> +         */
> +        arch_id = cpu->phy_id;
> +        virt_get_topo_from_index(ms, &topo, arch_id);
> +        cpu->socket_id = topo.socket_id;
> +        cpu->core_id   = topo.core_id;
> +        cpu->thread_id = topo.thread_id;
> +        cpu_slot = virt_find_cpu_slot(ms, arch_id, &index);
> +    }

It seems you want to use "phy_id" (instead of topology IDs as for now)
as the parameter to plug CPU. And IIUC in previous patch, "phy_id" is
essentially the CPU index.

Igor has previously commented [1] on ARM's hotplug design that the
current QEMU should use the topology-id (socket-id/core-id/thread-id) as
the parameters, not the CPU index or the x86-like apic id.

So I think his comment can apply on loongarch, too.

From my own understanding, the CPU index lacks topological intuition,
and the APIC ID for x86 is even worse, as its sometimes even
discontinuous. Requiring the user to specify topology ids would allow
for clearer localization to CPU slots.

[1]: https://lore.kernel.org/qemu-devel/20240812101556.1a395712@imammedo.users.ipa.redhat.com/

> +    /*
> +     * update cpu_index calculation method since it is easily used as index
> +     * with possible_cpus array by function virt_cpu_index_to_props
> +     */
> +    cs->cpu_index = index;
> +    numa_cpu_pre_plug(cpu_slot, dev, &local_err);
> +    return ;
> +
> +out:
> +    error_propagate(errp, local_err);
> +}
> +

Thanks,
Zhao



