Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3A6606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 11:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=UxxIjDBD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRpbJ-0006pj-BU; Fri, 13 Nov 2026 06:37:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dblanzeanu@linux.microsoft.com>)
 id 1xRpbG-0006Ze-HP; Fri, 13 Nov 2026 06:37:46 -0500
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dblanzeanu@linux.microsoft.com>)
 id 1xRpbE-0005Yp-PP; Fri, 13 Nov 2026 06:37:46 -0500
Received: from linux.microsoft.com (unknown [52.164.184.190])
 by linux.microsoft.com (Postfix) with ESMTPSA id F05A220B7167;
 Fri, 13 Nov 2026 03:37:33 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F05A220B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1794569857;
 bh=HUu8rwANeiNcv7uQl6pAD3GR21+JRhehZsTlNO+otFA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UxxIjDBDTXJl/Ke6oC5zJzdP3MA5426iXua8gzfSe3kMyLaTscrh/xwGlPrm3/QKv
 Cu9VAiwnLpB0OrqIJfl3GwZAkH0vAtfq70l8m2s7YZfsNlA5WrhMRTzy14K9FsVvmy
 zOH9/fCuOycukvQaDgBx5KGEtXmST5koi3wDL4yA=
Date: Fri, 13 Nov 2026 13:37:30 +0200
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
Subject: Re: [PATCH v6 03/14] accel/mshv: make MSHV migration initialization
 arch-specific
Message-ID: <avb2etJ16sVs3QIk@linux.microsoft.com>
References: <20261001-mshv_accel_arm64_supp-v6-0-aefe5e76a0e3@linux.microsoft.com>
 <20261001-mshv_accel_arm64_supp-v6-3-aefe5e76a0e3@linux.microsoft.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001-mshv_accel_arm64_supp-v6-3-aefe5e76a0e3@linux.microsoft.com>
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

On Thu, Oct 01, 2026 at 10:52:48AM +0000, Aastha Rawat wrote:
> x86 specific migration handlers currently live in common MSHV code. Move
> these handlers into x86 backend and add a generic architecture migration
> initialization hook. ARM MSHV live migration support is not added yet,
> this will allow ARM to add an empty initialization hook.
> 
> Signed-off-by: Aastha Rawat <aastharawat@linux.microsoft.com>
> ---
>  accel/mshv/mshv-all.c       | 35 ++++-------------------------------
>  include/system/mshv_int.h   |  1 +
>  target/i386/mshv/mshv-all.c | 34 ++++++++++++++++++++++++++++++++++
>  3 files changed, 39 insertions(+), 31 deletions(-)
> 
> diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
> index 860f511fcba..efe19a39140 100644
> --- a/accel/mshv/mshv-all.c
> +++ b/accel/mshv/mshv-all.c
> @@ -60,30 +60,6 @@ static int init_mshv(int *mshv_fd)
>      return 0;
>  }
>  
> -static int mshv_load_cleanup(void *opaque)
> -{
> -    CPUState *cpu;
> -    int ret;
> -
> -    ret = mshv_arch_set_partition_msrs(first_cpu);
> -    if (ret < 0) {
> -        error_report("Failed to set partition MSRs: %s", strerror(-ret));
> -        return -1;
> -    }
> -
> -    CPU_FOREACH(cpu) {
> -        ret = mshv_arch_set_mp_state(cpu);
> -        if (ret < 0) {
> -            error_report("Failed to set mp state for vCPU %d: %s",
> -                         cpu->cpu_index, strerror(-ret));
> -            return -1;
> -        }
> -    }
> -
> -    return 0;
> -}
> -
> -
>  static int get_host_partition_property(int mshv_fd, uint32_t property_code,
>                                         uint64_t *value)
>  {
> @@ -519,10 +495,6 @@ static int mshv_init_vcpu(CPUState *cpu)
>      return 0;
>  }
>  
> -static SaveVMHandlers savevm_mshv = {
> -    .load_cleanup = mshv_load_cleanup,
> -};
> -
>  static int mshv_init(AccelState *as, MachineState *ms)
>  {
>      MshvState *s;
> @@ -574,9 +546,10 @@ static int mshv_init(AccelState *as, MachineState *ms)
>                                    0, "mshv-memory");
>      memory_listener_register(&mshv_io_listener, &address_space_io);
>  
> -    register_savevm_live("mshv", 0, 1, &savevm_mshv, s);
> -
> -    mshv_clock_init();
> +    ret = mshv_arch_migration_init(s);
> +    if (ret < 0) {
> +        return ret;
> +    }
>  
>      return 0;
>  }
> diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
> index 0e68365c63f..31d2f4381c7 100644
> --- a/include/system/mshv_int.h
> +++ b/include/system/mshv_int.h
> @@ -109,6 +109,7 @@ void mshv_arch_disable_partition_proc_features(
>  int mshv_arch_accel_init(AccelState *as, MachineState *ms, int mshv_fd);
>  int mshv_arch_post_init_vm(int vm_fd);
>  void mshv_setup_hvcall_args(AccelCPUState *state);
> +int mshv_arch_migration_init(MshvState *s);
>  int mshv_get_vp_state(int cpu_fd, struct mshv_get_set_vp_state *state);
>  int mshv_set_vp_state(int cpu_fd, const struct mshv_get_set_vp_state *state);
>  typedef struct mshv_root_hvcall mshv_root_hvcall;
> diff --git a/target/i386/mshv/mshv-all.c b/target/i386/mshv/mshv-all.c
> index f0b43aa86f1..968fe2a4494 100644
> --- a/target/i386/mshv/mshv-all.c
> +++ b/target/i386/mshv/mshv-all.c
> @@ -78,3 +78,37 @@ int mshv_arch_post_init_vm(int vm_fd)
>  
>      return ret;
>  }
> +
> +static int mshv_load_cleanup(void *opaque)
> +{
> +    CPUState *cpu;
> +    int ret;
> +
> +    ret = mshv_arch_set_partition_msrs(first_cpu);
> +    if (ret < 0) {
> +        error_report("Failed to set partition MSRs: %s", strerror(-ret));
> +        return -1;
> +    }
> +
> +    CPU_FOREACH(cpu) {
> +        ret = mshv_arch_set_mp_state(cpu);
> +        if (ret < 0) {
> +            error_report("Failed to set mp state for vCPU %d: %s",
> +                         cpu->cpu_index, strerror(-ret));
> +            return -1;
> +        }
> +    }
> +
> +    return 0;
> +}
> +

For me, on x86 this does not build. The SaveVMHandlers type is unknown.

> +static SaveVMHandlers savevm_mshv = {
> +    .load_cleanup = mshv_load_cleanup,
> +};
> +
> +int mshv_arch_migration_init(MshvState *s)
> +{

Also, this function here is seen as implicit declaration.
I think there's a missing include in this file.

> +    register_savevm_live("mshv", 0, 1, &savevm_mshv, s);
> +    mshv_clock_init();
> +    return 0;
> +}
> 
> -- 
> 2.45.4

