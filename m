Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF34606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 13:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=MLnpRZpm
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVqFx-0006SL-3n; Tue, 24 Nov 2026 08:08:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aastharawat@linux.microsoft.com>)
 id 1xVqFt-0006Rn-E6; Tue, 24 Nov 2026 08:08:17 -0500
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aastharawat@linux.microsoft.com>)
 id 1xVqFn-0001lG-Eh; Tue, 24 Nov 2026 08:08:16 -0500
Received: by linux.microsoft.com (Postfix, from userid 1236)
 id 97BC420B7166; Tue, 24 Nov 2026 05:08:05 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 97BC420B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1795525685;
 bh=A1NIEVYLNQFyJDw66BCXNCtb7KiovPrl90uyB2LIVFE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MLnpRZpm84klkcWcaFZcJ2Di0+ZfSNWDHsjBju2q8JgqllSPVGcG4SAUh6qmtOa6M
 Nw1snV1nKBNGFvHqMmOabwp9Lzjqb+ixW/VQs5hevpaiIE1Sz/LZGpuv2+7Tx+oRQ4
 w04i3rltKTNgJfNrWYZIhPYckCc3ObSARuadBD5g=
Date: Tue, 24 Nov 2026 05:08:05 -0800
From: Aastha Rawat <aastharawat@linux.microsoft.com>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
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
Subject: Re: [PATCH v6 08/14] accel/mshv: Add access_vp_regs synthetic proc
 features
Message-ID: <awWMNQ2r9HWaze8u@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20261001-mshv_accel_arm64_supp-v6-0-aefe5e76a0e3@linux.microsoft.com>
 <20261001-mshv_accel_arm64_supp-v6-8-aefe5e76a0e3@linux.microsoft.com>
 <awBMp+6l6DWP2EpA@example.com>
 <awWF9qhfluCzaZbM@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <awWF9qhfluCzaZbM@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=aastharawat@linux.microsoft.com; helo=linux.microsoft.com
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

On Tue, Nov 24, 2026 at 04:41:26AM -0800, Aastha Rawat wrote:
> On Fri, Nov 20, 2026 at 02:35:35PM +0100, Magnus Kulke wrote:
> > On Thu, Oct 01, 2026 at 10:52:53AM +0000, Aastha Rawat wrote:
> > > Enable access_vp_regs feature for regs. In arm64, this feature bit
> > > allows the guest to set VP registers using hypercall. This wasn't
> > > required for x86 because such registers are set using wrmsr instead of
> > > hypercall.
> > > 
> > > Signed-off-by: Aastha Rawat <aastharawat@linux.microsoft.com>
> > > ---
> > >  accel/mshv/mshv-all.c     |  1 +
> > >  include/hw/hyperv/hvhdk.h | 91 ++++++++++++++++++++++++++++++++++++++++++++++-
> > >  2 files changed, 91 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
> > > index f3f1825b0b..9603f0360e 100644
> > > --- a/accel/mshv/mshv-all.c
> > > +++ b/accel/mshv/mshv-all.c
> > > @@ -235,6 +235,7 @@ static int set_synthetic_proc_features(int vm_fd)
> > >      features.tb_flush_hypercalls = 1;
> > >      features.synthetic_cluster_ipi = 1;
> > >      features.direct_synthetic_timers = 1;
> > > +    features.access_vp_regs = 1;
> > 
> > is this safe to use on x86_64? if not/unsure we can use the
> > mshv_arch_amend_proc_features to only set this bit on arm64
> 
> This is unconditionally enabled for MSHV in cloud-hypervisor so I
> believe it to be safe for x86.
>  
> > >  
> > >      mshv_arch_amend_proc_features(&features);
> > >  
> > > diff --git a/include/hw/hyperv/hvhdk.h b/include/hw/hyperv/hvhdk.h
> > > index 9e6dcb22f6..d0adbea0c7 100644
> > > --- a/include/hw/hyperv/hvhdk.h
> > > +++ b/include/hw/hyperv/hvhdk.h
> > > @@ -94,11 +94,16 @@ union hv_partition_synthetic_processor_features {
> > >           */
> > >          uint64_t access_partition_reference_tsc:1;
> > >  
> > > +#if defined(__x86_64__)
> > 
> > Maybe we can use the `HOST_x86_64/AARCH64` qemu equivalent here.

Replying to the second point I missed in my last message...

Yes, using HOST_X86_64/HOST_AARCH64 also removes the checkpatch.pl
warnings. Will do.

> > > +
> > >          /*
> > >           * Partition has access to the guest idle reg. Corresponds to
> > >           * access_guest_idle_reg privilege.
> > >           */
> > >          uint64_t access_guest_idle_reg:1;
> > > +#else
> > > +        uint64_t reserved_z10:1;
> > > +#endif
> > >  
> > >          /*
> > >           * Partition has access to frequency regs. corresponds to
> > > @@ -110,11 +115,16 @@ union hv_partition_synthetic_processor_features {
> > >          uint64_t reserved_z13:1; /* Reserved for access_root_scheduler_reg */
> > >          uint64_t reserved_z14:1; /* Reserved for access_tsc_invariant_controls */
> > >  
> > > +#if defined(__x86_64__)
> > > +
> > >          /*
> > >           * Extended GVA ranges for HvCallFlushVirtualAddressList hypercall.
> > >           * Corresponds to privilege.
> > >           */
> > >          uint64_t enable_extended_gva_ranges_for_flush_virtual_address_list:1;
> > > +#else
> > > +        uint64_t reserved_z15:1;
> > > +#endif
> > >  
> > >          uint64_t reserved_z16:1; /* Reserved for access_vsm. */
> > >          uint64_t reserved_z17:1; /* Reserved for access_vp_registers. */
> > > @@ -161,13 +171,92 @@ union hv_partition_synthetic_processor_features {
> > >          /* HvCallRetargetDeviceInterrupt is supported. */
> > >          uint64_t retarget_device_interrupt:1;
> > >  
> > > +#if defined(__x86_64__)
> > >          /* HvCallRestorePartitionTime is supported. */
> > >          uint64_t restore_time:1;
> > >  
> > >          /* EnlightenedVmcs nested enlightenment is supported. */
> > >          uint64_t enlightened_vmcs:1;
> > >  
> > > -        uint64_t reserved:30;
> > > +        uint64_t nested_debug_ctl:1;
> > > +        uint64_t synthetic_time_unhalted_timer:1;
> > > +        uint64_t idle_spec_ctrl:1;
> > > +
> > > +#else
> > > +        uint64_t reserved_z31:1;
> > > +        uint64_t reserved_z32:1;
> > > +        uint64_t reserved_z33:1;
> > > +        uint64_t reserved_z34:1;
> > > +        uint64_t reserved_z35:1;
> > > +#endif
> > > +
> > > +#if defined(__aarch64__)
> > > +        /*
> > > +         * Register intercepts supported in V1. As more registers are supported
> > > +         * in future releases, new bits will be added here to prevent migration
> > > +         * between incompatible hosts.
> > > +         *
> > > +         * List of registers supported in V1:
> > > +         * 1. TPIDRRO_EL0
> > > +         * 2. TPIDR_EL1
> > > +         * 3. SCTLR_EL1 - Supports write intercept mask.
> > > +         * 4. VBAR_EL1
> > > +         * 5. TCR_EL1 - Supports write intercept mask.
> > > +         * 6. MAIR_EL1 - Supports write intercept mask.
> > > +         * 7. CPACR_EL1 - Supports write intercept mask.
> > > +         * 8. CONTEXTIDR_EL1
> > > +         * 9. PAuth keys (total 10 registers)
> > > +         * 10. HvArm64RegisterSyntheticException
> > > +         */
> > > +        uint64_t register_intercepts_v1:1;
> > > +#else
> > > +        uint64_t reserved_z36:1;
> > > +#endif
> > > +
> > > +        /* HvCallWakeVps is supported */
> > > +        uint64_t wake_vps:1;
> > > +
> > > +        /*
> > > +         * HvCallGet/SetVpRegisters is supported.
> > > +         * Corresponds to AccessVpRegisters privilege.
> > > +         * This feature only affects exo partitions.
> > > +         */
> > > +        uint64_t access_vp_regs:1;
> > > +
> > > +#if defined(__aarch64__)
> > > +        /* HvCallSyncContext/Ex is supported. */
> > > +        uint64_t sync_context:1;
> > > +#else
> > > +        uint64_t reserved_z39:1;
> > > +#endif /* __aarch64__ */
> > > +
> > > +        /*
> > > +         * Management VTL synic support is allowed.
> > > +         * Corresponds to the ManagementVtlSynicSupport privilege.
> > > +         */
> > > +        uint64_t management_vtl_synic_support:1;
> > > +
> > > +#if defined(__x86_64__)
> > > +        /*
> > > +         * Hypervisor supports guest mechanism to signal pending interrupts to
> > > +         * paravisor.
> > > +         */
> > > +        uint64_t proxy_interrupt_doorbell_support:1;
> > > +#else
> > > +        uint64_t reserved_z41:1;
> > > +#endif
> > > +
> > > +#if defined(__aarch64__)
> > > +        /* InterceptSystemResetAvailable is exposed. */
> > > +        uint64_t intercept_system_reset:1;
> > > +#else
> > > +        uint64_t reserved_z42:1;
> > > +#endif
> > > +
> > > +        /* Hypercalls for host MMIO operations are available. */
> > > +        uint64_t mmio_hypercalls:1;
> > > +
> > > +        uint64_t reserved:20;
> > >      };
> > >  };
> > >  
> > > 
> > > -- 
> > > 2.45.4

