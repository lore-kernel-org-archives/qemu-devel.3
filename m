Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C2BFFF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 10:29:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI2A3-0000sa-SC; Wed, 29 Apr 2026 06:28:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1wI29y-0000sL-Bj
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 06:28:50 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1wI29v-00071l-2Q
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 06:28:49 -0400
Received: from example.com (unknown [167.220.208.81])
 by linux.microsoft.com (Postfix) with ESMTPSA id 6A4EF20B716C;
 Wed, 29 Apr 2026 03:28:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6A4EF20B716C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1777458525;
 bh=BQTZQZJpyPOZP8Q4VLbsIux3awQ7Yq1u1L0CJlBdCAY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=eXWkpYsjAIfpbKkVqA/hY0+We7rhnnG3XEn+Q4oT3Mu5rw0wWZ34D/lDMMFtA7y1j
 17h/yca+pK/yJuEXK5NMg8Xml4ucBZgR+kJ+UAlqmBLVt8y7OPjDHsIlkibfxqAyc3
 SNa4Q4yBoBc2URH7OLfF5LluauIKN07dsfXBN0mg=
Date: Wed, 29 Apr 2026 12:28:41 +0200
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <dblanzeanu@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Wei Liu <wei.liu@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 3/6] include/hw/hyperv: add hv_vp_register_page struct
 definition
Message-ID: <afHdWUlOt1ldMy6V@example.com>
References: <20260428135053.251200-1-dblanzeanu@linux.microsoft.com>
 <20260428135053.251200-4-dblanzeanu@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260428135053.251200-4-dblanzeanu@linux.microsoft.com>
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Apr 28, 2026 at 04:50:50PM +0300, Doru Blânzeanu wrote:
> Define the `hv_vp_register_page` structure that the linux kernel uses
> to allow access to vcpu registers.
> 
> This structure is going to be used in later patches to access vcpu
> registers.
> 
> Signed-off-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>
> ---
>  include/hw/hyperv/hvgdk_mini.h | 103 +++++++++++++++++++++++++++++++++
>  1 file changed, 103 insertions(+)
> 
> diff --git a/include/hw/hyperv/hvgdk_mini.h b/include/hw/hyperv/hvgdk_mini.h

In the kernel and the mshv crates the definitions are in hvhdk.h. We
probably want to put it into the same header in QEMU to avoid confusion.

> index c3a8f33280..07e322865a 100644
> --- a/include/hw/hyperv/hvgdk_mini.h
> +++ b/include/hw/hyperv/hvgdk_mini.h
> @@ -474,6 +474,109 @@ struct hv_input_assert_virtual_interrupt {
>      uint16_t rsvd_z1;
>  } QEMU_PACKED;
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
> +#define HV_VP_REGISTER_PAGE_MAX_VECTOR_COUNT  7
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
>  /* /dev/mshv */
>  #define MSHV_CREATE_PARTITION   _IOW(MSHV_IOCTL, 0x00, struct mshv_create_partition)
>  #define MSHV_CREATE_VP          _IOW(MSHV_IOCTL, 0x01, struct mshv_create_vp)
> -- 
> 2.53.0

