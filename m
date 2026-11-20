Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072CD606A330
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 15:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=JhfdSI0M
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUQkD-0002xk-MP; Fri, 20 Nov 2026 10:41:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1xUQkA-0002wq-Qw; Fri, 20 Nov 2026 10:41:42 -0500
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1xUQk9-0002ZY-8F; Fri, 20 Nov 2026 10:41:42 -0500
Received: from example.com (unknown [167.220.208.76])
 by linux.microsoft.com (Postfix) with ESMTPSA id 1A9A620B7169;
 Fri, 20 Nov 2026 07:41:33 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1A9A620B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1795189297;
 bh=DFOyE6YXGgDyTxl9Qoev9K8wbAkDQ4CL451RjbB3Oc8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JhfdSI0MSGyYvXcr+O3Yun6qePNsRI9oe/+UttGJKYDo2O5TCg3zHWVGXpXNRUu48
 eWIF1ycgmCRDRvFhMrS0r95MnO2nKUEIvoXzSMS1GlhQtfHeVUxT6dtf/IRMtKHRKp
 fFn4z7SbpNEKMJAOQJmiBYtLvk7WkTr0Pdzf/SrE=
Date: Fri, 20 Nov 2026 16:41:33 +0100
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
Subject: Re: [PATCH v6 12/14] include/hw/hyperv: adjust hv_interrupt_control
 structure for arm64
Message-ID: <awBqLXipVEZTlj4g@example.com>
References: <20261001-mshv_accel_arm64_supp-v6-0-aefe5e76a0e3@linux.microsoft.com>
 <20261001-mshv_accel_arm64_supp-v6-12-aefe5e76a0e3@linux.microsoft.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001-mshv_accel_arm64_supp-v6-12-aefe5e76a0e3@linux.microsoft.com>
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
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 01, 2026 at 10:52:57AM +0000, Aastha Rawat wrote:
> From: "Anirudh Rayabharam (Microsoft)" <anirudh@anirudhrb.com>
> 
> Add the arm64 specific fields to the hv_interrupt_control struct and
> adjust the existing usage accordingly. mshv_request_interrupt is only
> needed only for x86 so compile it out entirely for arm64.
> 
> Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> ---
>  accel/mshv/irq.c               |  2 ++
>  include/hw/hyperv/hvgdk_mini.h | 24 ++++++++++++++++++++++++
>  include/system/mshv.h          |  2 ++
>  3 files changed, 28 insertions(+)
> 
> diff --git a/accel/mshv/irq.c b/accel/mshv/irq.c
> index 4828ac51ac..f18e6a0f66 100644
> --- a/accel/mshv/irq.c
> +++ b/accel/mshv/irq.c
> @@ -259,6 +259,7 @@ int mshv_irqchip_update_msi_route(int virq, MSIMessage msg, PCIDevice *dev)
>      return 0;
>  }
>  
> +#if defined(__x86_64__)

if it's arch-specific then we probably want to move this to
target/i386/mshv

>  int mshv_request_interrupt(MshvState *mshv_state, uint32_t interrupt_type, uint32_t vector,
>                             uint32_t vp_index, bool logical_dest_mode,
>                             bool level_triggered)
> @@ -295,6 +296,7 @@ int mshv_request_interrupt(MshvState *mshv_state, uint32_t interrupt_type, uint3
>      }
>      return 0;
>  }
> +#endif
>  
>  void mshv_irqchip_commit_routes(MshvState *s)
>  {
> diff --git a/include/hw/hyperv/hvgdk_mini.h b/include/hw/hyperv/hvgdk_mini.h
> index 53dc58813e..d81c9816e7 100644
> --- a/include/hw/hyperv/hvgdk_mini.h
> +++ b/include/hw/hyperv/hvgdk_mini.h
> @@ -543,14 +543,38 @@ typedef struct hv_input_set_vp_registers {
>  } QEMU_PACKED hv_input_set_vp_registers;
>  
>  #define MSHV_VP_MAX_REGISTERS   128
> +enum hv_interrupt_type {

maybe we don't need those defines, since the values are prefixed with
the arch name?

> +#if defined(__x86_64__)
> +    HV_X64_INTERRUPT_TYPE_FIXED             = 0x0000,
> +    HV_X64_INTERRUPT_TYPE_LOWESTPRIORITY    = 0x0001,
> +    HV_X64_INTERRUPT_TYPE_SMI               = 0x0002,
> +    HV_X64_INTERRUPT_TYPE_REMOTEREAD        = 0x0003,
> +    HV_X64_INTERRUPT_TYPE_NMI               = 0x0004,
> +    HV_X64_INTERRUPT_TYPE_INIT              = 0x0005,
> +    HV_X64_INTERRUPT_TYPE_SIPI              = 0x0006,
> +    HV_X64_INTERRUPT_TYPE_EXTINT            = 0x0007,
> +    HV_X64_INTERRUPT_TYPE_LOCALINT0         = 0x0008,
> +    HV_X64_INTERRUPT_TYPE_LOCALINT1         = 0x0009,
> +    HV_X64_INTERRUPT_TYPE_MAXIMUM           = 0x000A,
> +#elif defined(__aarch64__)
> +    HV_ARM64_INTERRUPT_TYPE_FIXED           = 0x0000,
> +    HV_ARM64_INTERRUPT_TYPE_MAXIMUM         = 0x0008,
> +#endif
> +};
>  
>  union hv_interrupt_control {
>      uint64_t as_uint64;
>      struct {
>          uint32_t interrupt_type; /* enum hv_interrupt type */
> +#if defined(__x86_64__)
>          uint32_t level_triggered:1;
>          uint32_t logical_dest_mode:1;
>          uint32_t rsvd:30;
> +#elif defined(__aarch64__)
> +        uint32_t rsvd1:2;
> +        uint32_t asserted:1;
> +        uint32_t rsvd2:29;
> +#endif
>      };
>  };
>  
> diff --git a/include/system/mshv.h b/include/system/mshv.h
> index 114f065db5..80b6712af9 100644
> --- a/include/system/mshv.h
> +++ b/include/system/mshv.h
> @@ -60,10 +60,12 @@ extern MshvState *mshv_state;
>  /* clock (partition reference time) */
>  void mshv_arch_clock_init(void);
>  
> +#if defined(__x86_64__)
>  /* interrupt */
>  int mshv_request_interrupt(MshvState *mshv_state, uint32_t interrupt_type, uint32_t vector,
>                             uint32_t vp_index, bool logical_destination_mode,
>                             bool level_triggered);
> +#endif
>  
>  int mshv_irqchip_add_msi_route(AccelRouteChange *c, int vector, PCIDevice *dev);
>  int mshv_irqchip_update_msi_route(int virq, MSIMessage msg, PCIDevice *dev);
> 
> -- 
> 2.45.4

