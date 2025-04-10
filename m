Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2469BC3601E
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 09:26:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2o9u-0006xx-Lq; Thu, 10 Apr 2025 05:25:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u2o9l-0006si-UX; Thu, 10 Apr 2025 05:25:10 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u2o9j-00026A-9F; Thu, 10 Apr 2025 05:25:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744277107; x=1775813107;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=vWFTCAHyc4ZZSNblinRf0t8BBfuIQYEI8cO6hq8NbrA=;
 b=CAGLPQl78R5F/0eb8DNCrhKsax4H8oLxcWT2JI5YQkfjoPvE6V3ZsJZs
 z6DogORdau5iKKoShp6lla52jwJmoJPjtQ7uqxf+1nPyxt3JNrHHEzdP7
 OIkum8zy1tUayGCMXP/NY6axmXrwUjjHoBhxooKmShKeatvnl5hzegPUG
 F3katX1LpNIjL8ETP0+30y+R/SLTxC0OSxqZh0qlORH9BwUH3p/lMBl9U
 n3vMKzwlJMmIbUmphPOQrtEKDYCtYTETaKAPTJGWC4MWJLq1eJiR/99jr
 8QIq0jIjVJa0ITghG3jyOYj5mX86KDQIvyydEc+VwrbOG+pG323l7xoIo A==;
X-CSE-ConnectionGUID: Xx6nNb4dTQGIrOXlLCgZuA==
X-CSE-MsgGUID: hE6bzLpVRNKkM6EHcckQPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="49625375"
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; d="scan'208";a="49625375"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Apr 2025 02:25:00 -0700
X-CSE-ConnectionGUID: 7EFLD+8sQoiP2fdPZgk4+Q==
X-CSE-MsgGUID: aiCRLBNDQsqVw5PNhNlRAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; d="scan'208";a="129685784"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa009.fm.intel.com with ESMTP; 10 Apr 2025 02:24:51 -0700
Date: Thu, 10 Apr 2025 17:45:41 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 pbonzini@redhat.com, mtosatti@redhat.com, sandipan.das@amd.com,
 babu.moger@amd.com, likexu@tencent.com, like.xu.linux@gmail.com,
 groug@kaod.org, khorenko@virtuozzo.com,
 alexander.ivanov@virtuozzo.com, den@virtuozzo.com,
 davydov-max@yandex-team.ru, xiaoyao.li@intel.com,
 dapeng1.mi@linux.intel.com, joe.jin@oracle.com,
 peter.maydell@linaro.org, gaosong@loongson.cn,
 chenhuacai@kernel.org, philmd@linaro.org, aurelien@aurel32.net,
 jiaxun.yang@flygoat.com, arikalo@gmail.com, npiggin@gmail.com,
 danielhb413@gmail.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 thuth@redhat.com, flavra@baylibre.com, ewanhai-oc@zhaoxin.com,
 ewanhai@zhaoxin.com, cobechen@zhaoxin.com, louisqi@zhaoxin.com,
 liamni@zhaoxin.com, frankzhu@zhaoxin.com, silviazhao@zhaoxin.com
Subject: Re: [PATCH v3 10/10] target/i386/kvm: don't stop Intel PMU counters
Message-ID: <Z/eTRVSveNMwZBaa@intel.com>
References: <20250331013307.11937-1-dongli.zhang@oracle.com>
 <20250331013307.11937-11-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250331013307.11937-11-dongli.zhang@oracle.com>
Received-SPF: pass client-ip=192.198.163.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.505,
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

On Sun, Mar 30, 2025 at 06:32:29PM -0700, Dongli Zhang wrote:
> Date: Sun, 30 Mar 2025 18:32:29 -0700
> From: Dongli Zhang <dongli.zhang@oracle.com>
> Subject: [PATCH v3 10/10] target/i386/kvm: don't stop Intel PMU counters
> X-Mailer: git-send-email 2.43.5
> 
> The kvm_put_msrs() sets the MSRs using KVM_SET_MSRS. The x86 KVM processes
> these MSRs one by one in a loop, only saving the config and triggering the
> KVM_REQ_PMU request. This approach does not immediately stop the event
> before updating PMC.

This is ture after KVM's 68fb4757e867 (v6.2). QEMU even supports v4.5
(docs/system/target-i386.rst)... I'm not sure whether it is outdated,
but it's better to mention the Linux version.

> In additional, PMU MSRs are set only at levels >= KVM_PUT_RESET_STATE,
> excluding runtime. Therefore, updating these MSRs without stopping events
> should be acceptable.

I agree.

> Finally, KVM creates kernel perf events with host mode excluded
> (exclude_host = 1). While the events remain active, they don't increment
> the counter during QEMU vCPU userspace mode.
> 
> No Fixed tag is going to be added for the commit 0d89436786b0 ("kvm:
> migrate vPMU state"), because this isn't a bugfix.
> 
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
>  target/i386/kvm/kvm.c | 9 ---------
>  1 file changed, 9 deletions(-)

Fine for me,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


