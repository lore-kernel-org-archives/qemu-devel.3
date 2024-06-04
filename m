Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD1D6C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 23:12:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEdKF-0002uf-2G; Tue, 04 Jun 2024 19:12:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEdKC-0002uD-SC; Tue, 04 Jun 2024 19:12:16 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEdKB-0004Cm-3e; Tue, 04 Jun 2024 19:12:16 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a68e9b84d0eso172880666b.1; 
 Tue, 04 Jun 2024 16:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717542732; x=1718147532; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VXyQApF4PKzn2EzpLof1NxGe2z8aAvsSgG+6urwG8d4=;
 b=b7VKZg9zzHBQ1pvMEzKFGtio5TD3N/nMIo2/X4FhdmOUeyLh9Vs3OQyA5zdIClTuSb
 D3Hu+jkDHo6PWsLCeqTcvS31PY3KYhzMx+Q3fKnLujUSYYv8bPAJPN+VbGS/X6vf0fL3
 JWrHOj5C7mwWJBuE80huimHchmThHfrseQ/egdqPDuWa9GjWOmS+f5wYUuen4qdPCJh5
 hIOeS7dJIHE+U5+WQyDoEhA6Nr6HYt71zpd2yaMdvz8On2IrC5jw6V7ZXWFmv2NDlPAO
 QmGMwMjQFA1Tbl4GDRSLnm0Y/MY++S7UhrF5HrJfUUd7xTrnGza4Sji3yGfuDi72cxfl
 ChBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717542732; x=1718147532;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VXyQApF4PKzn2EzpLof1NxGe2z8aAvsSgG+6urwG8d4=;
 b=cJefhTaZVkYcQbac9oXVXg1fB2jJ4lDNx9e3YWaeTxOmJW//uZCq2Emc4XzLnPDbAo
 DTeqalh3PnrveEEhwvKbftr2R1p8/NlrkcpfXevxYPEHWKR4e7siuwlsutUEiMonmpef
 vYNKe8TRggVzRk68Q1wdA5I4AM/tnd3CnKufKnsW5gMdV1PEcAt9r3CvP29RDrkw/71h
 pEuBVxprV3Oac8R77L1KN3+6dMxm7j+Xi+ffyMiwuN+yT41JiqrqmXYvKi0uPXe3yYWl
 nbe5vwK8djxlM2FDOqSmJCrezpIlDBuoL0zNQ3CDRi3uOFYYjcYm7SW8VWkDcUvoDjm7
 rYZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU46GWIlRsrQdGDtKOIfboWbkYNiqfiiPApPdS6TToJERuxejDDxuaf4VdsraHn8wj6Ldb84tya8vnLBn5LHyU/BfqtJCQ=
X-Gm-Message-State: AOJu0YzntubKq6v1i7wM7CLqyMO1D5jMbBb0uY6n7kpXr512dSlPh/+l
 avIMc91jZtyE08r0vS+HV/dW1qfZmpgIJ5ptD18gs1x+kkLTZsIkAfz8NrlEeTFOtYxVqJIGulO
 yzx6LdZdJg0pOkAvbCc46FZtLy4g=
X-Google-Smtp-Source: AGHT+IF0Q0Hi87niLEI7ma/n1b+wYBmeM0+ctwytc1lRTlpollucDP1M+tM2xdcwOIyLGNQROKglEYBg3u9ZQPCMLeo=
X-Received: by 2002:a50:d597:0:b0:572:a770:1371 with SMTP id
 4fb4d7f45d1cf-57a8bcc6116mr573513a12.42.1717542732168; Tue, 04 Jun 2024
 16:12:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240528080759.26439-1-duchao@eswincomputing.com>
 <20240528080759.26439-2-duchao@eswincomputing.com>
In-Reply-To: <20240528080759.26439-2-duchao@eswincomputing.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 5 Jun 2024 09:11:44 +1000
Message-ID: <CAKmqyKNea0Fv-DSEFBEm-_7pSFLVQz-_C5HD5Vz9EDbiY8TjAA@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 1/3] target/riscv/kvm: add software breakpoints
 support
To: Chao Du <duchao@eswincomputing.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com, 
 ajones@ventanamicro.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com, 
 anup@brainfault.org, duchao713@qq.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x629.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, May 28, 2024 at 6:12=E2=80=AFPM Chao Du <duchao@eswincomputing.com>=
 wrote:
>
> This patch implements insert/remove software breakpoint process.
>
> For RISC-V, GDB treats single-step similarly to breakpoint: add a
> breakpoint at the next step address, then continue. So this also
> works for single-step debugging.
>
> Implement kvm_arch_update_guest_debug(): Set the control flag
> when there are active breakpoints. This will help KVM to know
> the status in the userspace.
>
> Add some stubs which are necessary for building, and will be
> implemented later.
>
> Signed-off-by: Chao Du <duchao@eswincomputing.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/kvm/kvm-cpu.c | 69 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
>
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index 235e2cdaca..c50f058aff 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -1969,3 +1969,72 @@ static const TypeInfo riscv_kvm_cpu_type_infos[] =
=3D {
>  };
>
>  DEFINE_TYPES(riscv_kvm_cpu_type_infos)
> +
> +static const uint32_t ebreak_insn =3D 0x00100073;
> +static const uint16_t c_ebreak_insn =3D 0x9002;
> +
> +int kvm_arch_insert_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint=
 *bp)
> +{
> +    if (cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&bp->saved_insn, 2, 0=
)) {
> +        return -EINVAL;
> +    }
> +
> +    if ((bp->saved_insn & 0x3) =3D=3D 0x3) {
> +        if (cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&bp->saved_insn, =
4, 0)
> +            || cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&ebreak_insn, =
4, 1)) {
> +            return -EINVAL;
> +        }
> +    } else {
> +        if (cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&c_ebreak_insn, 2=
, 1)) {
> +            return -EINVAL;
> +        }
> +    }
> +
> +    return 0;
> +}
> +
> +int kvm_arch_remove_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint=
 *bp)
> +{
> +    uint32_t ebreak;
> +    uint16_t c_ebreak;
> +
> +    if ((bp->saved_insn & 0x3) =3D=3D 0x3) {
> +        if (cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&ebreak, 4, 0) ||
> +            ebreak !=3D ebreak_insn ||
> +            cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&bp->saved_insn, =
4, 1)) {
> +            return -EINVAL;
> +        }
> +    } else {
> +        if (cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&c_ebreak, 2, 0) =
||
> +            c_ebreak !=3D c_ebreak_insn ||
> +            cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&bp->saved_insn, =
2, 1)) {
> +            return -EINVAL;
> +        }
> +    }
> +
> +    return 0;
> +}
> +
> +int kvm_arch_insert_hw_breakpoint(vaddr addr, vaddr len, int type)
> +{
> +    /* TODO; To be implemented later. */
> +    return -EINVAL;
> +}
> +
> +int kvm_arch_remove_hw_breakpoint(vaddr addr, vaddr len, int type)
> +{
> +    /* TODO; To be implemented later. */
> +    return -EINVAL;
> +}
> +
> +void kvm_arch_remove_all_hw_breakpoints(void)
> +{
> +    /* TODO; To be implemented later. */
> +}
> +
> +void kvm_arch_update_guest_debug(CPUState *cs, struct kvm_guest_debug *d=
bg)
> +{
> +    if (kvm_sw_breakpoints_active(cs)) {
> +        dbg->control |=3D KVM_GUESTDBG_ENABLE;
> +    }
> +}
> --
> 2.17.1
>

