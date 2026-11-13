Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB40606A32E
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 12:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=mm78s/wv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRqq1-0005Ka-SR; Fri, 13 Nov 2026 07:57:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dblanzeanu@linux.microsoft.com>)
 id 1xRqpx-0005Hj-Ke; Fri, 13 Nov 2026 07:57:02 -0500
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dblanzeanu@linux.microsoft.com>)
 id 1xRqpn-0006iP-Qg; Fri, 13 Nov 2026 07:56:53 -0500
Received: from linux.microsoft.com (unknown [52.164.184.190])
 by linux.microsoft.com (Postfix) with ESMTPSA id 27CD820B7166;
 Fri, 13 Nov 2026 04:56:41 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 27CD820B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1794574605;
 bh=Mgbu8zIPWx7hnR+YUHakvK2oeo+6CHDNjKUq6b4AiP4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mm78s/wvBLhoc+liGm0Gf1KGccrGE9UAX9oAOywUbyUxxLcsUGzNVBkDTyakpaW9S
 xKPhZfpCo/zF1qKVNz+Exg5YHtZt2u8JAODhM1DF4pPd1NMBBzXHZslL2HTqLSgCc7
 3W6cBco4ga9X9j9hpvwUNsH0gTADZ32iOOnL74Jw=
Date: Fri, 13 Nov 2026 14:56:37 +0200
From: Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <dblanzeanu@linux.microsoft.com>
To: Aastha Rawat <aastharawat@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Anirudh Rayabharam <anirudh@anirudhrb.com>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Subject: Re: [PATCH v6 04/14] meson, target/arm/mshv: Enable arm64 build &
 add initial MSHV support
Message-ID: <avcJBaVOdK05xwwW@linux.microsoft.com>
References: <20261001-mshv_accel_arm64_supp-v6-0-aefe5e76a0e3@linux.microsoft.com>
 <20261001-mshv_accel_arm64_supp-v6-4-aefe5e76a0e3@linux.microsoft.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001-mshv_accel_arm64_supp-v6-4-aefe5e76a0e3@linux.microsoft.com>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=dblanzeanu@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 01, 2026 at 10:52:49AM +0000, Aastha Rawat wrote:
> Enable the build of the MSHV accelerator for arm64 in the Meson build
> system. Introduce initial files and stub implementations to support MSHV
> for the ARM target.
> 
> Signed-off-by: Aastha Rawat <aastharawat@linux.microsoft.com>
> ---
>  accel/mshv/mshv-all.c       | 10 ++++--
>  hw/i386/mshv/clock.c        |  2 +-
>  include/system/mshv.h       |  2 +-
>  meson.build                 |  8 ++---
>  target/arm/meson.build      |  1 +
>  target/arm/mshv/meson.build |  7 ++++
>  target/arm/mshv/mshv-all.c  | 81 +++++++++++++++++++++++++++++++++++++++++++++
>  7 files changed, 103 insertions(+), 8 deletions(-)
> 
> diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
> index efe19a3914..f3f1825b0b 100644
> --- a/accel/mshv/mshv-all.c
> +++ b/accel/mshv/mshv-all.c
> @@ -142,8 +142,10 @@ static int create_partition(int mshv_fd, int *vm_fd)
>  {
>      int ret;
>      uint64_t pt_flags, host_proc_features;
> -    union hv_partition_processor_xsave_features disabled_xsave_features;
>      union hv_partition_processor_features disabled_partition_features = {0};
> +#if defined(__x86_64__)
> +    union hv_partition_processor_xsave_features disabled_xsave_features;
> +#endif
>  
>      struct mshv_create_partition_v2 args = {0};
>  
> @@ -155,7 +157,8 @@ static int create_partition(int mshv_fd, int *vm_fd)
>                 (1ULL << MSHV_PT_BIT_GPA_SUPER_PAGES) |
>                 (1ULL << MSHV_PT_BIT_CPU_AND_XSAVE_FEATURES);
>  
> -    /* enable all */
> +#if defined(__x86_64__)
> +    /* enable all xsave features (0 = enabled) */
>      disabled_xsave_features.as_uint64 = 0;
>      /*
>       * AMX TILE XSAVE state (XTILE_DATA) is 8KB, which exceeds the
> @@ -165,6 +168,7 @@ static int create_partition(int mshv_fd, int *vm_fd)
>      disabled_xsave_features.amx_bf16_support = 1;
>      disabled_xsave_features.amx_int8_support = 1;
>      disabled_xsave_features.amx_fp16_support = 1;
> +#endif
>  
>      /*
>       * query host for supported processor features and disable unsupported
> @@ -196,7 +200,9 @@ static int create_partition(int mshv_fd, int *vm_fd)
>      /* populate args structure */
>      args.pt_flags = pt_flags;
>      args.pt_isolation = MSHV_PT_ISOLATION_NONE;
> +#if defined(__x86_64__)
>      args.pt_disabled_xsave = disabled_xsave_features.as_uint64;
> +#endif
>      args.pt_num_cpu_fbanks = MSHV_NUM_CPU_FEATURES_BANKS;
>  
>      ret = ioctl(mshv_fd, MSHV_CREATE_PARTITION, &args);
> diff --git a/hw/i386/mshv/clock.c b/hw/i386/mshv/clock.c
> index 02c586503a..b7db382752 100644
> --- a/hw/i386/mshv/clock.c
> +++ b/hw/i386/mshv/clock.c
> @@ -182,7 +182,7 @@ static const VMStateDescription vmstate_mshv_clock = {
>      },
>  };
>  
> -void mshv_clock_init(void)
> +void mshv_arch_clock_init(void)
>  {
>      vmstate_register(NULL, 0, &vmstate_mshv_clock, &mshv_clock);
>      qemu_add_vm_change_state_handler(mshv_clock_vm_state_change, &mshv_clock);
> diff --git a/include/system/mshv.h b/include/system/mshv.h
> index f98ddff9b5..114f065db5 100644
> --- a/include/system/mshv.h
> +++ b/include/system/mshv.h
> @@ -58,7 +58,7 @@ DECLARE_INSTANCE_CHECKER(MshvState, MSHV_STATE,
>  extern MshvState *mshv_state;
>  

This renames the `mshv_clock_init`, but the place where it is called is not
changed in this commit, which leads to a compilation issue on the x86 arch.

>  /* clock (partition reference time) */
> -void mshv_clock_init(void);
> +void mshv_arch_clock_init(void);
>  
>  /* interrupt */
>  int mshv_request_interrupt(MshvState *mshv_state, uint32_t interrupt_type, uint32_t vector,
> diff --git a/meson.build b/meson.build
> index cae1591cd2..6a90a394a2 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -304,7 +304,8 @@ if cpu == 'aarch64'
>    accelerator_targets += {
>      'CONFIG_HVF': ['aarch64-softmmu'],
>      'CONFIG_NITRO': ['aarch64-softmmu'],
> -    'CONFIG_WHPX': ['aarch64-softmmu']
> +    'CONFIG_WHPX': ['aarch64-softmmu'],
> +    'CONFIG_MSHV': ['aarch64-softmmu'],
>    }
>  elif cpu == 'x86_64'
>    accelerator_targets += {
> @@ -884,10 +885,9 @@ if get_option('kvm').allowed() and host_os == 'linux'
>  endif
>  
>  if get_option('mshv').allowed() and host_os == 'linux'
> -  if get_option('mshv').enabled() and host_machine.cpu() != 'x86_64'
> -    error('mshv accelerator requires x64_64 host')
> +  if host_machine.cpu() in [ 'x86_64', 'aarch64' ]
> +    accelerators += 'CONFIG_MSHV'
>    endif
> -  accelerators += 'CONFIG_MSHV'
>  endif
>  
>  if get_option('whpx').allowed() and host_os == 'windows'
> diff --git a/target/arm/meson.build b/target/arm/meson.build
> index 0369f96b4c..1ac2cef26b 100644
> --- a/target/arm/meson.build
> +++ b/target/arm/meson.build
> @@ -63,6 +63,7 @@ arm_common_system_ss.add(files(
>  
>  subdir('hvf')
>  subdir('whpx')
> +subdir('mshv')
>  
>  if 'CONFIG_TCG' in config_all_accel
>     subdir('tcg')
> diff --git a/target/arm/mshv/meson.build b/target/arm/mshv/meson.build
> new file mode 100644
> index 0000000000..169643691e
> --- /dev/null
> +++ b/target/arm/mshv/meson.build
> @@ -0,0 +1,7 @@
> +arm_mshv_ss = ss.source_set()
> +
> +arm_mshv_ss.add(files(
> +  'mshv-all.c',
> +))
> +
> +arm_system_ss.add_all(when: 'CONFIG_MSHV', if_true: arm_mshv_ss)
> diff --git a/target/arm/mshv/mshv-all.c b/target/arm/mshv/mshv-all.c
> new file mode 100644
> index 0000000000..00c54f5d66
> --- /dev/null
> +++ b/target/arm/mshv/mshv-all.c
> @@ -0,0 +1,81 @@
> +/*
> + * QEMU MSHV support
> + *
> + * Copyright Microsoft, Corp. 2026
> + *
> + * Authors: Aastha Rawat          <aastharawat@linux.microsoft.com>
> + *          Anirudh Rayabharam    <anirudh@anirudhrb.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/arm/virt.h"
> +#include "system/mshv.h"
> +#include "system/mshv_int.h"
> +
> +static int load_regs(CPUState *cpu)
> +{
> +    return 0;
> +}
> +
> +static int store_regs(const CPUState *cpu)
> +{
> +    return 0;
> +}
> +
> +int mshv_arch_load_vcpu_state(CPUState *cpu)
> +{
> +    return load_regs(cpu);
> +}
> +
> +int mshv_arch_store_vcpu_state(const CPUState *cpu)
> +{
> +    return store_regs(cpu);
> +}
> +
> +int mshv_run_vcpu(int vm_fd, CPUState *cpu, hv_message *msg, MshvVmExit *exit)
> +{
> +    return 0;
> +}
> +
> +void mshv_arch_init_vcpu(CPUState *cpu)
> +{
> +
> +}
> +
> +void mshv_arch_destroy_vcpu(CPUState *cpu)
> +{
> +
> +}
> +
> +int mshv_arch_accel_init(AccelState *as, MachineState *ms, int mshv_fd)
> +{
> +    return 0;
> +}
> +
> +void mshv_arch_amend_proc_features(
> +    union hv_partition_synthetic_processor_features *features)
> +{
> +    /*
> +     * TLB-flush hypercalls are an x86 enlightenment. ARM guests use
> +     * broadcast TLBI instructions instead.
> +     */
> +    features->tb_flush_hypercalls = 0;
> +}
> +
> +void mshv_arch_disable_partition_proc_features(
> +    union hv_partition_processor_features *disabled_features)
> +{
> +    /* No processor features to disable on ARM */
> +}
> +
> +int mshv_arch_post_init_vm(int vm_fd)
> +{
> +    return 0;
> +}
> +
> +int mshv_arch_migration_init(MshvState *s)
> +{
> +    return 0;
> +}
> 
> -- 
> 2.45.4

