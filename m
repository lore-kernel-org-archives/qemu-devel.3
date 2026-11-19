Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADCC606A320
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 15:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=JNuZi1KQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU3lU-00042f-L0; Thu, 19 Nov 2026 10:09:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1xU3iR-0002UL-Ne; Thu, 19 Nov 2026 10:06:28 -0500
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1xU3iP-0001iC-6D; Thu, 19 Nov 2026 10:06:23 -0500
Received: from example.com (unknown [167.220.208.76])
 by linux.microsoft.com (Postfix) with ESMTPSA id 8CA1320B7169;
 Thu, 19 Nov 2026 07:06:14 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8CA1320B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1795100777;
 bh=lhki+DaTPRnWOksp1PiPaK2HEqg9Tt/WHms9hAH/xrE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JNuZi1KQXWNMLuqJ/nH9oZ9NA8q5gH7wbj8YF9nP37Fd2T+PrkezNbW1xSV0GWGpB
 hRWtP5XqT5QwGJOAhu/2v1aSKO0uplMelyyJp/wfFmc5j6XlOXtb/mGsNHLFPkC34Q
 zuQnJDi0R2pUqvgmXsyJpnockrrp9h2790vICe8I=
Date: Thu, 19 Nov 2026 16:06:13 +0100
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: Aastha Rawat <aastharawat@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Wei Liu <wei.liu@kernel.org>,
 Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <dblanzeanu@linux.microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
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
Subject: Re: [PATCH v6 02/14] accel/mshv: add arch-specific accelerator init
 hook
Message-ID: <av8QZaVwh+rgKDX/@example.com>
References: <20261001-mshv_accel_arm64_supp-v6-0-aefe5e76a0e3@linux.microsoft.com>
 <20261001-mshv_accel_arm64_supp-v6-2-aefe5e76a0e3@linux.microsoft.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001-mshv_accel_arm64_supp-v6-2-aefe5e76a0e3@linux.microsoft.com>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
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
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 01, 2026 at 10:52:47AM +0000, Aastha Rawat wrote:
> From: "Anirudh Rayabharam (Microsoft)" <anirudh@anirudhrb.com>
> 
> Introduce mshv_arch_accel_init() as an arch-specific hook called early
> in mshv_init(), before VM creation. This allows each architecture to
> perform platform-specific initialization at accelerator init time.
> 
> For x86, the hook calls mshv_init_mmio_emu() which was previously called
> directly from the common init path. Also move set_unimplemented_msr_action()
> and mshv_arch_post_init_vm() from mshv-cpu.c to the new mshv-all.c, as
> they are not vCPU-specific.
> 
> Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> ---
>  accel/mshv/mshv-all.c        |  5 ++-
>  include/system/mshv_int.h    |  1 +
>  target/i386/mshv/meson.build |  1 +
>  target/i386/mshv/mshv-all.c  | 80 ++++++++++++++++++++++++++++++++++++++++++++
>  target/i386/mshv/mshv-cpu.c  | 40 ----------------------
>  5 files changed, 86 insertions(+), 41 deletions(-)
> 
> diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
> index 5921ce693ee..860f511fcba 100644
> --- a/accel/mshv/mshv-all.c
> +++ b/accel/mshv/mshv-all.c
> @@ -544,7 +544,10 @@ static int mshv_init(AccelState *as, MachineState *ms)
>          return -1;
>      }
>  
> -    mshv_init_mmio_emu();
> +    ret = mshv_arch_accel_init(as, ms, mshv_fd);
> +    if (ret < 0) {

since this is now fallible, we probably want to close mshv_fd before
returning here

> +        return -1;
> +    }
>  
>      ret = create_vm(mshv_fd, &vm_fd);
>      if (ret < 0) {
> diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
> index 2e8caad8fde..0e68365c63f 100644
> --- a/include/system/mshv_int.h
> +++ b/include/system/mshv_int.h
> @@ -106,6 +106,7 @@ void mshv_arch_amend_proc_features(
>      union hv_partition_synthetic_processor_features *features);
>  void mshv_arch_disable_partition_proc_features(
>       union hv_partition_processor_features *disabled_features);
> +int mshv_arch_accel_init(AccelState *as, MachineState *ms, int mshv_fd);
>  int mshv_arch_post_init_vm(int vm_fd);
>  void mshv_setup_hvcall_args(AccelCPUState *state);
>  int mshv_get_vp_state(int cpu_fd, struct mshv_get_set_vp_state *state);
> diff --git a/target/i386/mshv/meson.build b/target/i386/mshv/meson.build
> index 31ff4cc9950..0e95c5a00b9 100644
> --- a/target/i386/mshv/meson.build
> +++ b/target/i386/mshv/meson.build
> @@ -1,6 +1,7 @@
>  i386_mshv_ss = ss.source_set()
>  
>  i386_mshv_ss.add(files(
> +  'mshv-all.c',
>    'mshv-cpu.c',
>    'msr.c',
>    'synic.c',
> diff --git a/target/i386/mshv/mshv-all.c b/target/i386/mshv/mshv-all.c
> new file mode 100644
> index 00000000000..f0b43aa86f1
> --- /dev/null
> +++ b/target/i386/mshv/mshv-all.c
> @@ -0,0 +1,80 @@
> +/*
> + * QEMU MSHV support
> + *
> + * Copyright Microsoft, Corp. 2026
> + *
> + * Authors: Ziqiao Zhou   <ziqiaozhou@microsoft.com>
> + *          Magnus Kulke  <magnuskulke@microsoft.com>
> + *          Jinank Jain   <jinankjain@microsoft.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/error-report.h"
> +#include "qemu/memalign.h"
> +
> +#include "system/mshv.h"
> +#include "system/mshv_int.h"
> +#include "system/address-spaces.h"
> +#include "linux/mshv.h"
> +#include "hw/hyperv/hvgdk.h"
> +#include "hw/hyperv/hvgdk_mini.h"
> +#include "hw/hyperv/hvhdk_mini.h"
> +#include "hw/i386/apic_internal.h"
> +
> +#include "cpu.h"
> +#include "emulate/x86_decode.h"
> +#include "emulate/x86_emu.h"
> +#include "emulate/x86_flags.h"
> +
> +#include "trace-accel_mshv.h"
> +#include "trace.h"
> +
> +#include <sys/ioctl.h>
> +
> +int mshv_arch_accel_init(AccelState *as, MachineState *ms, int mshv_fd)
> +{
> +    mshv_init_mmio_emu();
> +    return 0;
> +}
> +
> +/*
> + * Default Microsoft Hypervisor behavior for unimplemented MSR is to send a
> + * fault to the guest if it tries to access it. It is possible to override
> + * this behavior with a more suitable option i.e., ignore writes from the guest
> + * and return zero in attempt to read unimplemented.
> + */
> +static int set_unimplemented_msr_action(int vm_fd)
> +{
> +    struct hv_input_set_partition_property in = {0};
> +    struct mshv_root_hvcall args = {0};
> +
> +    in.property_code  = HV_PARTITION_PROPERTY_UNIMPLEMENTED_MSR_ACTION;
> +    in.property_value = HV_UNIMPLEMENTED_MSR_ACTION_IGNORE_WRITE_READ_ZERO;
> +
> +    args.code   = HVCALL_SET_PARTITION_PROPERTY;
> +    args.in_sz  = sizeof(in);
> +    args.in_ptr = (uint64_t)&in;
> +
> +    trace_mshv_hvcall_args("unimplemented_msr_action", args.code, args.in_sz);
> +
> +    int ret = mshv_hvcall(vm_fd, &args);
> +    if (ret < 0) {
> +        error_report("Failed to set unimplemented MSR action");
> +        return -1;
> +    }
> +    return 0;
> +}
> +
> +int mshv_arch_post_init_vm(int vm_fd)
> +{
> +    int ret;
> +
> +    ret = set_unimplemented_msr_action(vm_fd);
> +    if (ret < 0) {
> +        error_report("Failed to set unimplemented MSR action");
> +    }
> +
> +    return ret;
> +}
> diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
> index 3eee097432a..f1056bd215e 100644
> --- a/target/i386/mshv/mshv-cpu.c
> +++ b/target/i386/mshv/mshv-cpu.c
> @@ -2125,46 +2125,6 @@ uint32_t mshv_get_supported_cpuid(uint32_t func, uint32_t idx, int reg)
>      return ret;
>  }
>  
> -/*
> - * Default Microsoft Hypervisor behavior for unimplemented MSR is to send a
> - * fault to the guest if it tries to access it. It is possible to override
> - * this behavior with a more suitable option i.e., ignore writes from the guest
> - * and return zero in attempt to read unimplemented.
> - */
> -static int set_unimplemented_msr_action(int vm_fd)
> -{
> -    struct hv_input_set_partition_property in = {0};
> -    struct mshv_root_hvcall args = {0};
> -
> -    in.property_code  = HV_PARTITION_PROPERTY_UNIMPLEMENTED_MSR_ACTION;
> -    in.property_value = HV_UNIMPLEMENTED_MSR_ACTION_IGNORE_WRITE_READ_ZERO;
> -
> -    args.code   = HVCALL_SET_PARTITION_PROPERTY;
> -    args.in_sz  = sizeof(in);
> -    args.in_ptr = (uint64_t)&in;
> -
> -    trace_mshv_hvcall_args("unimplemented_msr_action", args.code, args.in_sz);
> -
> -    int ret = mshv_hvcall(vm_fd, &args);
> -    if (ret < 0) {
> -        error_report("Failed to set unimplemented MSR action");
> -        return -1;
> -    }
> -    return 0;
> -}
> -
> -int mshv_arch_post_init_vm(int vm_fd)
> -{
> -    int ret;
> -
> -    ret = set_unimplemented_msr_action(vm_fd);
> -    if (ret < 0) {
> -        error_report("Failed to set unimplemented MSR action");
> -    }
> -
> -    return ret;
> -}
> -
>  static void mshv_cpu_xsave_init(void)
>  {
>      static bool first = true;
> 
> -- 
> 2.45.4

