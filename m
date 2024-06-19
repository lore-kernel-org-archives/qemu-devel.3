Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2D80C27C79
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 14:35:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJwOR-0002GA-TW; Wed, 19 Jun 2024 10:34:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sJwOO-0002Fl-Dr
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 10:34:32 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sJwOL-0003Xy-EJ
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 10:34:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1718807670; x=1750343670;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=nZDlhvUT6Rsc5q2kZ2/8XKGyU+Gz7O9C5IAeCTS2DhM=;
 b=MQHM9AftRf1y/4vBBuNDeDGl1BDkDAOFQLa+pqFdbayIlClGFaxBlb9i
 VXKeeiQmZhFJMlopJckl9VdWFELQ0CByUVQTtsFF6F13eMgovb53XCc31
 BcMTSiOq9Y26mG0WCQ+Oa7wT7x8qcTP0ZnRpNP/77VCXDY4YVCyGPRM+/
 IZ0bvys+PYK/nburF/OCDN/jyQULs7JZZQcYyb5E33r/WVQ25U09r0ouz
 k5fCHPEhrms5NfSIlU3Rz9csD4duLjNn9PrBfADOpVGupPGhX7EXwRwl3
 dNiJwxqie36uVVXAguJcZN2upCy80p63w+zBy0RDfXyv8Sx/eS8uITGUG g==;
X-CSE-ConnectionGUID: 2VStCrZ5SyeHCyJ4XCE+GQ==
X-CSE-MsgGUID: 5zPR7RujSoK//oG04J2vKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="38262409"
X-IronPort-AV: E=Sophos;i="6.08,250,1712646000"; d="scan'208";a="38262409"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2024 07:34:27 -0700
X-CSE-ConnectionGUID: hpNDQ1S4Q8Ciyu9raLmJFg==
X-CSE-MsgGUID: /HlVoESnRLeDe5D7q/IjRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,250,1712646000"; d="scan'208";a="73143909"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa001.fm.intel.com with ESMTP; 19 Jun 2024 07:34:24 -0700
Date: Wed, 19 Jun 2024 22:49:56 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Thomas Huth <thuth@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH] hw/core: Rename CpuTopology to CPUTopology
Message-ID: <ZnLwFPb3iLNiC8li@intel.com>
References: <20240527131837.2630961-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527131837.2630961-1-zhao1.liu@intel.com>
Received-SPF: pass client-ip=198.175.65.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi maintainers,

Per my communication with Markus, it seems this renaming matches the
"local consistency" principle in (include/hw/boards.h). :-)

So do you think this change is acceptable?

Thanks,
Zhao

On Mon, May 27, 2024 at 09:18:37PM +0800, Zhao Liu wrote:
> Date: Mon, 27 May 2024 21:18:37 +0800
> From: Zhao Liu <zhao1.liu@intel.com>
> Subject: [PATCH] hw/core: Rename CpuTopology to CPUTopology
> X-Mailer: git-send-email 2.34.1
> 
> Use CPUTopology to honor the generic style of CPU capitalization
> abbreviations.
> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>  * Split from the previous SMP cache RFC:
>    https://lore.kernel.org/qemu-devel/20240220092504.726064-2-zhao1.liu@linux.intel.com/
> ---
>  hw/s390x/cpu-topology.c         |  6 +++---
>  include/hw/boards.h             |  8 ++++----
>  include/hw/s390x/cpu-topology.h |  6 +++---
>  tests/unit/test-smp-parse.c     | 14 +++++++-------
>  4 files changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/hw/s390x/cpu-topology.c b/hw/s390x/cpu-topology.c
> index f16bdf65faa0..016f6c1c15ac 100644
> --- a/hw/s390x/cpu-topology.c
> +++ b/hw/s390x/cpu-topology.c
> @@ -86,7 +86,7 @@ bool s390_has_topology(void)
>   */
>  static void s390_topology_init(MachineState *ms)
>  {
> -    CpuTopology *smp = &ms->smp;
> +    CPUTopology *smp = &ms->smp;
>  
>      s390_topology.cores_per_socket = g_new0(uint8_t, smp->sockets *
>                                              smp->books * smp->drawers);
> @@ -181,7 +181,7 @@ void s390_topology_reset(void)
>   */
>  static bool s390_topology_cpu_default(S390CPU *cpu, Error **errp)
>  {
> -    CpuTopology *smp = &current_machine->smp;
> +    CPUTopology *smp = &current_machine->smp;
>      CPUS390XState *env = &cpu->env;
>  
>      /* All geometry topology attributes must be set or all unset */
> @@ -234,7 +234,7 @@ static bool s390_topology_check(uint16_t socket_id, uint16_t book_id,
>                                  uint16_t drawer_id, uint16_t entitlement,
>                                  bool dedicated, Error **errp)
>  {
> -    CpuTopology *smp = &current_machine->smp;
> +    CPUTopology *smp = &current_machine->smp;
>  
>      if (socket_id >= smp->sockets) {
>          error_setg(errp, "Unavailable socket: %d", socket_id);
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 2fa800f11ae4..c1737f2a5736 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -334,7 +334,7 @@ typedef struct DeviceMemoryState {
>  } DeviceMemoryState;
>  
>  /**
> - * CpuTopology:
> + * CPUTopology:
>   * @cpus: the number of present logical processors on the machine
>   * @drawers: the number of drawers on the machine
>   * @books: the number of books in one drawer
> @@ -346,7 +346,7 @@ typedef struct DeviceMemoryState {
>   * @threads: the number of threads in one core
>   * @max_cpus: the maximum number of logical processors on the machine
>   */
> -typedef struct CpuTopology {
> +typedef struct CPUTopology {
>      unsigned int cpus;
>      unsigned int drawers;
>      unsigned int books;
> @@ -357,7 +357,7 @@ typedef struct CpuTopology {
>      unsigned int cores;
>      unsigned int threads;
>      unsigned int max_cpus;
> -} CpuTopology;
> +} CPUTopology;
>  
>  /**
>   * MachineState:
> @@ -409,7 +409,7 @@ struct MachineState {
>      const char *cpu_type;
>      AccelState *accelerator;
>      CPUArchIdList *possible_cpus;
> -    CpuTopology smp;
> +    CPUTopology smp;
>      struct NVDIMMState *nvdimms_state;
>      struct NumaState *numa_state;
>  };
> diff --git a/include/hw/s390x/cpu-topology.h b/include/hw/s390x/cpu-topology.h
> index c064f427e948..ff09c57a4428 100644
> --- a/include/hw/s390x/cpu-topology.h
> +++ b/include/hw/s390x/cpu-topology.h
> @@ -63,17 +63,17 @@ static inline void s390_topology_reset(void)
>  
>  extern S390Topology s390_topology;
>  
> -static inline int s390_std_socket(int n, CpuTopology *smp)
> +static inline int s390_std_socket(int n, CPUTopology *smp)
>  {
>      return (n / smp->cores) % smp->sockets;
>  }
>  
> -static inline int s390_std_book(int n, CpuTopology *smp)
> +static inline int s390_std_book(int n, CPUTopology *smp)
>  {
>      return (n / (smp->cores * smp->sockets)) % smp->books;
>  }
>  
> -static inline int s390_std_drawer(int n, CpuTopology *smp)
> +static inline int s390_std_drawer(int n, CPUTopology *smp)
>  {
>      return (n / (smp->cores * smp->sockets * smp->books)) % smp->drawers;
>  }
> diff --git a/tests/unit/test-smp-parse.c b/tests/unit/test-smp-parse.c
> index 9fdba24fce56..f51138794ca1 100644
> --- a/tests/unit/test-smp-parse.c
> +++ b/tests/unit/test-smp-parse.c
> @@ -120,8 +120,8 @@
>   */
>  typedef struct SMPTestData {
>      SMPConfiguration config;
> -    CpuTopology expect_prefer_sockets;
> -    CpuTopology expect_prefer_cores;
> +    CPUTopology expect_prefer_sockets;
> +    CPUTopology expect_prefer_cores;
>      const char *expect_error;
>  } SMPTestData;
>  
> @@ -643,7 +643,7 @@ static char *smp_config_to_string(const SMPConfiguration *config)
>  }
>  
>  /* Use the different calculation than machine_topo_get_threads_per_socket(). */
> -static unsigned int cpu_topology_get_threads_per_socket(const CpuTopology *topo)
> +static unsigned int cpu_topology_get_threads_per_socket(const CPUTopology *topo)
>  {
>      /* Check the divisor to avoid invalid topology examples causing SIGFPE. */
>      if (!topo->drawers || !topo->books || !topo->sockets) {
> @@ -654,7 +654,7 @@ static unsigned int cpu_topology_get_threads_per_socket(const CpuTopology *topo)
>  }
>  
>  /* Use the different calculation than machine_topo_get_cores_per_socket(). */
> -static unsigned int cpu_topology_get_cores_per_socket(const CpuTopology *topo)
> +static unsigned int cpu_topology_get_cores_per_socket(const CPUTopology *topo)
>  {
>      /* Check the divisor to avoid invalid topology examples causing SIGFPE. */
>      if (!topo->threads) {
> @@ -664,13 +664,13 @@ static unsigned int cpu_topology_get_cores_per_socket(const CpuTopology *topo)
>      }
>  }
>  
> -static char *cpu_topology_to_string(const CpuTopology *topo,
> +static char *cpu_topology_to_string(const CPUTopology *topo,
>                                      unsigned int threads_per_socket,
>                                      unsigned int cores_per_socket,
>                                      bool has_clusters)
>  {
>      return g_strdup_printf(
> -        "(CpuTopology) {\n"
> +        "(CPUTopology) {\n"
>          "    .cpus               = %u,\n"
>          "    .drawers            = %u,\n"
>          "    .books              = %u,\n"
> @@ -692,7 +692,7 @@ static char *cpu_topology_to_string(const CpuTopology *topo,
>  }
>  
>  static void check_parse(MachineState *ms, const SMPConfiguration *config,
> -                        const CpuTopology *expect_topo, const char *expect_err,
> +                        const CPUTopology *expect_topo, const char *expect_err,
>                          bool is_valid)
>  {
>      MachineClass *mc = MACHINE_GET_CLASS(ms);
> -- 
> 2.34.1
> 

