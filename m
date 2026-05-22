Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67D81CD5BB1
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 12:46:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQPG1-0002E6-Jx; Fri, 22 May 2026 08:45:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1wQPFz-0002De-6g
 for qemu-devel@nongnu.org; Fri, 22 May 2026 08:45:39 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1wQPFt-0003hL-Je
 for qemu-devel@nongnu.org; Fri, 22 May 2026 08:45:37 -0400
Received: from example.com (unknown [167.220.208.35])
 by linux.microsoft.com (Postfix) with ESMTPSA id DE6E020B7167;
 Fri, 22 May 2026 05:45:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DE6E020B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1779453924;
 bh=J1+O6L1PCwR+QOW9od5rOy+9aojlU53os7Z0aQhc5z4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=IqslhLMlbiyy070qFWRB1lZT44tEdC8XxzsSiBY8jIn0drbCviJJiXiDD3TqW8bZc
 0EixtEdLMjm02OnTnKU0UxBV1EQOvPhbzOfNwS+61OWF6JIDwB4bYfCgfFKYM4oQxh
 wCJDMhIE3AKUozG1U8aLC2uQkIFEcsdaGPsKRhb4=
Date: Fri, 22 May 2026 14:45:28 +0200
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <dblanzeanu@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Wei Liu <liuwe@microsoft.com>,
 Magnus Kulke <magnuskulke@microsoft.com>, Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH v3 3/7] include/hw/hyperv: add hv_vp_register_page struct
 definition
Message-ID: <ahBP6L943xGggKDd@example.com>
References: <20260521165041.131477-1-dblanzeanu@linux.microsoft.com>
 <20260521165041.131477-4-dblanzeanu@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260521165041.131477-4-dblanzeanu@linux.microsoft.com>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, May 21, 2026 at 07:50:37PM +0300, Doru Blânzeanu wrote:
> Define the `hv_vp_register_page` structure that the linux kernel uses
> to allow access to vcpu registers.
> 
> This structure is going to be used in later patches to access vcpu
> registers.
> 
> Signed-off-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>
> ---
>  include/hw/hyperv/hvgdk.h |   2 +
>  include/hw/hyperv/hvhdk.h | 106 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 108 insertions(+)
> 
> diff --git a/include/hw/hyperv/hvgdk.h b/include/hw/hyperv/hvgdk.h
> index 71161f477c..e4be861716 100644
> --- a/include/hw/hyperv/hvgdk.h
> +++ b/include/hw/hyperv/hvgdk.h
> @@ -9,6 +9,8 @@
>  #ifndef HW_HYPERV_HVGDK_H
>  #define HW_HYPERV_HVGDK_H
>  
> +#include "hvgdk_mini.h"
> +
>  #define HVGDK_H_VERSION         (25125)
>  
>  enum hv_unimplemented_msr_action {
> diff --git a/include/hw/hyperv/hvhdk.h b/include/hw/hyperv/hvhdk.h
> index 41af743847..39b1e2497b 100644
> --- a/include/hw/hyperv/hvhdk.h
> +++ b/include/hw/hyperv/hvhdk.h
> @@ -9,7 +9,12 @@
>  #ifndef HW_HYPERV_HVHDK_H
>  #define HW_HYPERV_HVHDK_H
>  
> +#include "hvgdk.h"
> +#include "hvhdk_mini.h"
> +
>  #define HV_PARTITION_SYNTHETIC_PROCESSOR_FEATURES_BANKS 1
> +#define HV_VP_REGISTER_PAGE_VERSION_1  1u
> +#define HV_VP_REGISTER_PAGE_MAX_VECTOR_COUNT  7
>  
>  struct hv_input_set_partition_property {
>      uint64_t partition_id;
> @@ -246,4 +251,105 @@ typedef struct hv_input_register_intercept_result {
>      union hv_register_intercept_result_parameters parameters;
>  } QEMU_PACKED hv_input_register_intercept_result;
>  
> +/* Flags for dirty mask of hv_vp_register_page */
> +enum hv_x64_register_class_type {
> +    HV_X64_REGISTER_CLASS_GENERAL = 0,
> +    HV_X64_REGISTER_CLASS_IP = 1,
> +    HV_X64_REGISTER_CLASS_XMM = 2,
> +    HV_X64_REGISTER_CLASS_SEGMENT = 3,
> +    HV_X64_REGISTER_CLASS_FLAGS = 4,
> +};
> +
> +union hv_vp_register_page_interrupt_vectors {
> +    uint64_t as_uint64;
> +    struct {
> +        uint8_t vector_count;
> +        uint8_t vector[HV_VP_REGISTER_PAGE_MAX_VECTOR_COUNT];
> +    };
> +};
> +
> +struct hv_vp_register_page {
> +    uint16_t version;
> +    uint8_t isvalid;
> +    uint8_t rsvdz;
> +    uint32_t dirty;
> +
> +    union {
> +        struct {
> +            /* General purpose registers (HV_X64_REGISTER_CLASS_GENERAL) */
> +            union {
> +                struct {
> +                    uint64_t rax;
> +                    uint64_t rcx;
> +                    uint64_t rdx;
> +                    uint64_t rbx;
> +                    uint64_t rsp;
> +                    uint64_t rbp;
> +                    uint64_t rsi;
> +                    uint64_t rdi;
> +                    uint64_t r8;
> +                    uint64_t r9;
> +                    uint64_t r10;
> +                    uint64_t r11;
> +                    uint64_t r12;
> +                    uint64_t r13;
> +                    uint64_t r14;
> +                    uint64_t r15;
> +                } QEMU_PACKED;
> +
> +                uint64_t gp_registers[16];
> +            };
> +            /* Instruction pointer (HV_X64_REGISTER_CLASS_IP) */
> +            uint64_t rip;
> +            /* Flags (HV_X64_REGISTER_CLASS_FLAGS) */
> +            uint64_t rflags;
> +        } QEMU_PACKED;
> +
> +        uint64_t registers[18];
> +    };
> +    uint8_t reserved[8];
> +    /* Volatile XMM registers (HV_X64_REGISTER_CLASS_XMM) */
> +    union {
> +        struct {
> +            struct hv_u128 xmm0;
> +            struct hv_u128 xmm1;
> +            struct hv_u128 xmm2;
> +            struct hv_u128 xmm3;
> +            struct hv_u128 xmm4;
> +            struct hv_u128 xmm5;
> +        } QEMU_PACKED;
> +
> +        struct hv_u128 xmm_registers[6];
> +    };
> +    /* Segment registers (HV_X64_REGISTER_CLASS_SEGMENT) */
> +    union {
> +        struct {
> +            struct hv_x64_segment_register es;
> +            struct hv_x64_segment_register cs;
> +            struct hv_x64_segment_register ss;
> +            struct hv_x64_segment_register ds;
> +            struct hv_x64_segment_register fs;
> +            struct hv_x64_segment_register gs;
> +        } QEMU_PACKED;
> +
> +        struct hv_x64_segment_register segment_registers[6];
> +    };
> +    /* Misc. control registers (cannot be set via this interface) */
> +    uint64_t cr0;
> +    uint64_t cr3;
> +    uint64_t cr4;
> +    uint64_t cr8;
> +    uint64_t efer;
> +    uint64_t dr7;
> +    union hv_x64_pending_interruption_register pending_interruption;
> +    union hv_x64_interrupt_state_register interrupt_state;
> +    uint64_t instruction_emulation_hints;
> +    uint64_t xfem;
> +
> +    uint8_t reserved1[0x100];
> +
> +    /* Interrupts injected as part of HvCallDispatchVp. */
> +    union hv_vp_register_page_interrupt_vectors interrupt_vectors;
> +} QEMU_PACKED;
> +
>  #endif /* HW_HYPERV_HVHDK_H */
> -- 
> 2.53.0

Reviewed-by: Magnus Kulke <magnuskulke@linux.microsoft.com>

