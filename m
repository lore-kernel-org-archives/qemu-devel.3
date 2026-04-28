Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39760FF885A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 17:45:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHmUO-0007RK-O5; Tue, 28 Apr 2026 13:44:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wHmUK-0007NT-IE
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 13:44:48 -0400
Received: from pv-2006h-snip4-11.eps.apple.com ([57.103.67.123]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wHmUH-0004zr-P4
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 13:44:47 -0400
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-8 (Postfix) with ESMTPS id
 003DE1800A3A; Tue, 28 Apr 2026 17:44:39 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFIHV8DWRxBAUkdXw9LVxQEFVwFVgZXFHkNXR1FDlYZWgxSD1sOHBZLWFUJCgZdGFgVVgl3HlwASx1XBFQfUxJVHR0LRUtAEwROEwVSB11NVg1HD1geXBQXCEVDXgheH0wcHQ5YBhIATQoONgZZBV4JVgNDBTYSFF1FRgNHGVcUUBtHDFUHV15fChMAXg8PTAA+C10CKgsyFEkALgJGBkR4Oh4vBC0KXQFOAVQCWXFJDk0KVHceXABLHVcEVB9TElUdHQtFVRIEQAhWUFQeQQRWFWwJWAZTGVc=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1777398283; x=1779990283;
 bh=H1m10sRKI7yRQfRgIYM7CUDUVsi+FfrE1MBTHuRUGMg=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=QzvEe3BVPXzmVKfYnTvLi81PJubNJpm1UlgiIoLKcaOmLoPU/i6dEowhlC6VbQPuT1i6HHogf9KHMQlofBNAFLR3yDpRtuuhh8O1mBQh2rwziRpRBsfVZQWBcCjeOslIFEtPRcBWcZ/urVOMvjwPQsci0bi2q83txAYY77h6lio7n6x065Xl8r4t6802fGG4YC5S+3zadkBHx9NAc5LqNwKuzn5RwcQq37H7HgUzyjBiwOW+wndoGD5ybsqYcnU82f/vgT2at2BJvB1707exGJpHNfHwKlYmXHLy2x2v5y09DwBVM/p48MsYusb/Uv7e/Oqul0Hjswi3x5PCqPV5Xw==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-8 (Postfix) with ESMTPSA id
 DF9C5180009B; Tue, 28 Apr 2026 17:44:37 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH 3/6] include/hw/hyperv: add hv_vp_register_page struct
 definition
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260428135053.251200-4-dblanzeanu@linux.microsoft.com>
Date: Tue, 28 Apr 2026 19:44:25 +0200
Cc: qemu-devel@nongnu.org, Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9F805A9B-13C5-44AB-B3F8-862952C97599@unpredictable.fr>
References: <20260428135053.251200-1-dblanzeanu@linux.microsoft.com>
 <20260428135053.251200-4-dblanzeanu@linux.microsoft.com>
To: =?utf-8?Q?Doru_Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>
X-Mailer: Apple Mail (2.3864.500.181)
X-Authority-Info-Out: v=2.4 cv=Gr9PO01C c=1 sm=1 tr=0 ts=69f0f208
 cx=c_apl:c_pps:t_out a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=yMhMjlubAAAA:8 a=eUc4BW3GRF4Kgis8M-0A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: lCvG9B8fzqwv6CfBHEfak3pWV-IHE84M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDE3MSBTYWx0ZWRfX8MyX0WAbD80t
 SeachQzJ5pd202jZ4NSuS1PwaiSiGafRLOFfTudiEhB8/ssRCf5RZCGm2brJ27YdiNKQsa7t0Dq
 omqAPGBhMRzjcSy6rUJ6JIklsaNM32PxFnx6xoliarBfeLG4NX4xQwjmckhl5//jxkbnC5/w+2I
 4A/88iNUUJYfoteDkwr2ubrm1qhst2rUNd+Ok3P7CXDfWEFQOgHThv/Madx47NXNHsFStURs7Nl
 TndC/7V/LqZdbYRXM4AJBJ//+0oXmmg034/rVe+wJFxUZLj75UoSOsBcVPQqRtj9ObIffiCZH58
 Mie/rXiEFBNA1lh7hgGhRBiH4un3BDofPz7UFcFs/zOgnsOWo6RqJ9eWwN+PPw=
X-Proofpoint-GUID: lCvG9B8fzqwv6CfBHEfak3pWV-IHE84M
Received-SPF: pass client-ip=57.103.67.123;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



> On 28. Apr 2026, at 15:50, Doru Bl=C3=A2nzeanu =
<dblanzeanu@linux.microsoft.com> wrote:
>=20
> Define the `hv_vp_register_page` structure that the linux kernel uses
> to allow access to vcpu registers.
>=20
> This structure is going to be used in later patches to access vcpu
> registers.
>=20
> Signed-off-by: Doru Bl=C3=A2nzeanu <dblanzeanu@linux.microsoft.com>
Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>

> ---
> include/hw/hyperv/hvgdk_mini.h | 103 +++++++++++++++++++++++++++++++++
> 1 file changed, 103 insertions(+)
>=20
> diff --git a/include/hw/hyperv/hvgdk_mini.h =
b/include/hw/hyperv/hvgdk_mini.h
> index c3a8f33280..07e322865a 100644
> --- a/include/hw/hyperv/hvgdk_mini.h
> +++ b/include/hw/hyperv/hvgdk_mini.h
> @@ -474,6 +474,109 @@ struct hv_input_assert_virtual_interrupt {
>     uint16_t rsvd_z1;
> } QEMU_PACKED;
>=20
> +/* Flags for dirty mask of hv_vp_register_page */
> +enum hv_x64_register_class_type {
> +    HV_X64_REGISTER_CLASS_GENERAL =3D 0,
> +    HV_X64_REGISTER_CLASS_IP =3D 1,
> +    HV_X64_REGISTER_CLASS_XMM =3D 2,
> +    HV_X64_REGISTER_CLASS_SEGMENT =3D 3,
> +    HV_X64_REGISTER_CLASS_FLAGS =3D 4,
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
> +            /* General purpose registers =
(HV_X64_REGISTER_CLASS_GENERAL) */
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
> /* /dev/mshv */
> #define MSHV_CREATE_PARTITION   _IOW(MSHV_IOCTL, 0x00, struct =
mshv_create_partition)
> #define MSHV_CREATE_VP          _IOW(MSHV_IOCTL, 0x01, struct =
mshv_create_vp)
> --=20
> 2.53.0
>=20
>=20


