Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14915C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 07:07:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpiqq-0007cZ-7r; Wed, 05 Mar 2025 02:07:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1tpiqk-0007bh-HW
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 02:07:27 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dapeng1.mi@linux.intel.com>)
 id 1tpiqi-0007VP-R5
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 02:07:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741158445; x=1772694445;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=tGcC8AKHL36G6KKjYkJ2djPBvA8fScGzKykiUMbohgA=;
 b=KMD3QkZBPu18WDAebPf53jbKwoQ+ZkIiUh9kgMeiIWN3MPH5nY6G3hRi
 6ItnA0csM/4gry7A2HYb7q486KaJxiN7GEy+pISTjeFYvCrS70Xb+C9o7
 TcPtNwHY90zsFHGEOG3ArljYFBZPYTkR4jtsNv5U+19Pv1Y5oE4AQ8zus
 YdwJ/Tu4r7dRg71mAa7gqhVC534S+chuIJm/64FwuqqdS74/d37wmzZQI
 uSkW+M6t2wS9zpuYYNAsMTni/8LDdgjL7EmDxw0xoTk2j8Xl/OCLiAC4b
 yLOBs6Zq4m2629JHR5qx/x4ZlUy7eJCSr0hS56EeKjAqHj529LycrVw8I Q==;
X-CSE-ConnectionGUID: qZhW+8/1TvuqUQk8TmmrNQ==
X-CSE-MsgGUID: yYPZAraGRUmHZvK0ForRkg==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="67475201"
X-IronPort-AV: E=Sophos;i="6.14,222,1736841600"; d="scan'208";a="67475201"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2025 23:07:23 -0800
X-CSE-ConnectionGUID: CngObJnVT/GAgcDIZQc0yw==
X-CSE-MsgGUID: pn+k+QgaRuKQNoXuwC+4UA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,222,1736841600"; d="scan'208";a="123623659"
Received: from unknown (HELO [10.238.2.135]) ([10.238.2.135])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2025 23:07:18 -0800
Message-ID: <d2e9fc7f-76f0-41da-98bc-96886fe9f660@linux.intel.com>
Date: Wed, 5 Mar 2025 15:07:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/10] target/i386/kvm: rename architectural PMU
 variables
To: Dongli Zhang <dongli.zhang@oracle.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Cc: pbonzini@redhat.com, zhao1.liu@intel.com, mtosatti@redhat.com,
 sandipan.das@amd.com, babu.moger@amd.com, likexu@tencent.com,
 like.xu.linux@gmail.com, zhenyuw@linux.intel.com, groug@kaod.org,
 khorenko@virtuozzo.com, alexander.ivanov@virtuozzo.com, den@virtuozzo.com,
 davydov-max@yandex-team.ru, xiaoyao.li@intel.com, joe.jin@oracle.com
References: <20250302220112.17653-1-dongli.zhang@oracle.com>
 <20250302220112.17653-7-dongli.zhang@oracle.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20250302220112.17653-7-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=192.198.163.7;
 envelope-from=dapeng1.mi@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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


On 3/3/2025 6:00 AM, Dongli Zhang wrote:
> AMD does not have what is commonly referred to as an architectural PMU.
> Therefore, we need to rename the following variables to be applicable for
> both Intel and AMD:
>
> - has_architectural_pmu_version
> - num_architectural_pmu_gp_counters
> - num_architectural_pmu_fixed_counters
>
> For Intel processors, the meaning of has_pmu_version remains unchanged.
>
> For AMD processors:
>
> has_pmu_version == 1 corresponds to versions before AMD PerfMonV2.
> has_pmu_version == 2 corresponds to AMD PerfMonV2.
>
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
>  target/i386/kvm/kvm.c | 49 ++++++++++++++++++++++++-------------------
>  1 file changed, 28 insertions(+), 21 deletions(-)
>
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 8f293ffd61..e895d22f94 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -164,9 +164,16 @@ static bool has_msr_perf_capabs;
>  static bool has_msr_pkrs;
>  static bool has_msr_hwcr;
>  
> -static uint32_t has_architectural_pmu_version;
> -static uint32_t num_architectural_pmu_gp_counters;
> -static uint32_t num_architectural_pmu_fixed_counters;
> +/*
> + * For Intel processors, the meaning is the architectural PMU version
> + * number.
> + *
> + * For AMD processors: 1 corresponds to the prior versions, and 2
> + * corresponds to AMD PerfMonV2.
> + */
> +static uint32_t has_pmu_version;
> +static uint32_t num_pmu_gp_counters;
> +static uint32_t num_pmu_fixed_counters;
>  
>  static int has_xsave2;
>  static int has_xcrs;
> @@ -2072,24 +2079,24 @@ static void kvm_init_pmu_info(CPUX86State *env)
>  
>      cpu_x86_cpuid(env, 0x0a, 0, &eax, &unused, &unused, &edx);
>  
> -    has_architectural_pmu_version = eax & 0xff;
> -    if (has_architectural_pmu_version > 0) {
> -        num_architectural_pmu_gp_counters = (eax & 0xff00) >> 8;
> +    has_pmu_version = eax & 0xff;
> +    if (has_pmu_version > 0) {
> +        num_pmu_gp_counters = (eax & 0xff00) >> 8;
>  
>          /*
>           * Shouldn't be more than 32, since that's the number of bits
>           * available in EBX to tell us _which_ counters are available.
>           * Play it safe.
>           */
> -        if (num_architectural_pmu_gp_counters > MAX_GP_COUNTERS) {
> -            num_architectural_pmu_gp_counters = MAX_GP_COUNTERS;
> +        if (num_pmu_gp_counters > MAX_GP_COUNTERS) {
> +            num_pmu_gp_counters = MAX_GP_COUNTERS;
>          }
>  
> -        if (has_architectural_pmu_version > 1) {
> -            num_architectural_pmu_fixed_counters = edx & 0x1f;
> +        if (has_pmu_version > 1) {
> +            num_pmu_fixed_counters = edx & 0x1f;
>  
> -            if (num_architectural_pmu_fixed_counters > MAX_FIXED_COUNTERS) {
> -                num_architectural_pmu_fixed_counters = MAX_FIXED_COUNTERS;
> +            if (num_pmu_fixed_counters > MAX_FIXED_COUNTERS) {
> +                num_pmu_fixed_counters = MAX_FIXED_COUNTERS;
>              }
>          }
>      }
> @@ -4041,25 +4048,25 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
>              kvm_msr_entry_add(cpu, MSR_KVM_POLL_CONTROL, env->poll_control_msr);
>          }
>  
> -        if (has_architectural_pmu_version > 0) {
> -            if (has_architectural_pmu_version > 1) {
> +        if (has_pmu_version > 0) {
> +            if (has_pmu_version > 1) {
>                  /* Stop the counter.  */
>                  kvm_msr_entry_add(cpu, MSR_CORE_PERF_FIXED_CTR_CTRL, 0);
>                  kvm_msr_entry_add(cpu, MSR_CORE_PERF_GLOBAL_CTRL, 0);
>              }
>  
>              /* Set the counter values.  */
> -            for (i = 0; i < num_architectural_pmu_fixed_counters; i++) {
> +            for (i = 0; i < num_pmu_fixed_counters; i++) {
>                  kvm_msr_entry_add(cpu, MSR_CORE_PERF_FIXED_CTR0 + i,
>                                    env->msr_fixed_counters[i]);
>              }
> -            for (i = 0; i < num_architectural_pmu_gp_counters; i++) {
> +            for (i = 0; i < num_pmu_gp_counters; i++) {
>                  kvm_msr_entry_add(cpu, MSR_P6_PERFCTR0 + i,
>                                    env->msr_gp_counters[i]);
>                  kvm_msr_entry_add(cpu, MSR_P6_EVNTSEL0 + i,
>                                    env->msr_gp_evtsel[i]);
>              }
> -            if (has_architectural_pmu_version > 1) {
> +            if (has_pmu_version > 1) {
>                  kvm_msr_entry_add(cpu, MSR_CORE_PERF_GLOBAL_STATUS,
>                                    env->msr_global_status);
>                  kvm_msr_entry_add(cpu, MSR_CORE_PERF_GLOBAL_OVF_CTRL,
> @@ -4519,17 +4526,17 @@ static int kvm_get_msrs(X86CPU *cpu)
>      if (env->features[FEAT_KVM] & CPUID_KVM_POLL_CONTROL) {
>          kvm_msr_entry_add(cpu, MSR_KVM_POLL_CONTROL, 1);
>      }
> -    if (has_architectural_pmu_version > 0) {
> -        if (has_architectural_pmu_version > 1) {
> +    if (has_pmu_version > 0) {
> +        if (has_pmu_version > 1) {
>              kvm_msr_entry_add(cpu, MSR_CORE_PERF_FIXED_CTR_CTRL, 0);
>              kvm_msr_entry_add(cpu, MSR_CORE_PERF_GLOBAL_CTRL, 0);
>              kvm_msr_entry_add(cpu, MSR_CORE_PERF_GLOBAL_STATUS, 0);
>              kvm_msr_entry_add(cpu, MSR_CORE_PERF_GLOBAL_OVF_CTRL, 0);
>          }
> -        for (i = 0; i < num_architectural_pmu_fixed_counters; i++) {
> +        for (i = 0; i < num_pmu_fixed_counters; i++) {
>              kvm_msr_entry_add(cpu, MSR_CORE_PERF_FIXED_CTR0 + i, 0);
>          }
> -        for (i = 0; i < num_architectural_pmu_gp_counters; i++) {
> +        for (i = 0; i < num_pmu_gp_counters; i++) {
>              kvm_msr_entry_add(cpu, MSR_P6_PERFCTR0 + i, 0);
>              kvm_msr_entry_add(cpu, MSR_P6_EVNTSEL0 + i, 0);
>          }

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>



