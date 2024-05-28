Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7446BC25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 13:42:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBx5W-00015D-JA; Tue, 28 May 2024 09:42:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1sBx5U-00014S-Li
 for qemu-devel@nongnu.org; Tue, 28 May 2024 09:42:00 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1sBx5S-0002bJ-Qo
 for qemu-devel@nongnu.org; Tue, 28 May 2024 09:42:00 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-42017f8de7aso5956015e9.1
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 06:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1716903717; x=1717508517; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ublzVFutB1HyFEg/ymKAbgFU8dLLAzP5QKRUL6B91Sk=;
 b=dm0uoQKyRk1HS63yBLHv7spascp/GfyXGWuEUM+JFx211eDE010pSSzP54MeUBKLg7
 JIuohFc+CuQFBYnKGx/YzNLOztj69/Rvj5RZ504zZvViyEdp0+Sqo0DW4aqs+AheUR9a
 U/Ih1kKfiY8XZh87/Oe1642VhBC7cK8oy5PruS6wVDqyHunWd1h8BghiUYyycsO5AXPA
 m0iww4QF/DszENCBe35OpboZ6TKA1wRuDwk7o4vI5h7z239WsK6dh8E/eagvCHe2jMgn
 uvrAa004gEICoEQFTp8LyNtsXhbIIaPqRZ4a5jQced/xOxWd4u5ZpB0Rs7JKEsyKPeOS
 D90Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716903717; x=1717508517;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ublzVFutB1HyFEg/ymKAbgFU8dLLAzP5QKRUL6B91Sk=;
 b=xQPn7czX+3f/CNsayy+d1b4f4OAbbHQAlbFWVTYaDhTbLEzHpHDnWnameqxMil3yRL
 xJSuhS9n7gGVR6Rz23rKNh9aI3bK6SvUcGcLdhojeme96gDJbod5qaYA7DTwsvzQ2FDq
 B4lBldC4zyK+GlsqYA/f0MZAxmp5xwiqw/goT1sFsIOO9oCFU7DC/PuZbfmRzaLogu1c
 OQyuEAZWt3lRqpVD6gQuu4gcX/Qi97rTAteZAjfrNHH9PA8xAEsj4b9uNnNN05cf/GoE
 l1HKkzqCa6afEaJwkfAT3DA2dSZ2ZSDZKh7PPTACljflfrCRawSU93THSfnwTmG7X4Ja
 2TLw==
X-Gm-Message-State: AOJu0Yy8O/mJviU9I5icjrYrBxIbyc3mQSnKPtGMvc4knF/BQxI3EObf
 DsEJWNdYBXU+poWE5eJFZ3LeGOHnsyEv4VShdNAWGJTaelc6kdKVRSRbaxpu1WQ=
X-Google-Smtp-Source: AGHT+IHOzU5le4fTSI4XHp3s7ZIw8xVERCreVBh5bfKMVJUp0yGFtIp61UqsQSiCXidCWruQZQmeXw==
X-Received: by 2002:a7b:c04f:0:b0:420:355f:1c07 with SMTP id
 5b1f17b1804b1-421089f8665mr98809655e9.13.1716903716507; 
 Tue, 28 May 2024 06:41:56 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42100f1ad4bsm175774865e9.19.2024.05.28.06.41.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 06:41:56 -0700 (PDT)
Date: Tue, 28 May 2024 15:41:55 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Chao Du <duchao@eswincomputing.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com, 
 alistair23@gmail.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com, 
 anup@brainfault.org, duchao713@qq.com
Subject: Re: [PATCH RESEND v2 1/3] target/riscv/kvm: add software breakpoints
 support
Message-ID: <20240528-d45f1806e04d913e1d2de9e5@orel>
References: <20240528080759.26439-1-duchao@eswincomputing.com>
 <20240528080759.26439-2-duchao@eswincomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528080759.26439-2-duchao@eswincomputing.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=ajones@ventanamicro.com; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, May 28, 2024 at 08:07:57AM GMT, Chao Du wrote:
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
> ---
>  target/riscv/kvm/kvm-cpu.c | 69 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
> 
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index 235e2cdaca..c50f058aff 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -1969,3 +1969,72 @@ static const TypeInfo riscv_kvm_cpu_type_infos[] = {
>  };
> 
>  DEFINE_TYPES(riscv_kvm_cpu_type_infos)
> +
> +static const uint32_t ebreak_insn = 0x00100073;
> +static const uint16_t c_ebreak_insn = 0x9002;
> +
> +int kvm_arch_insert_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
> +{
> +    if (cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&bp->saved_insn, 2, 0)) {
> +        return -EINVAL;
> +    }
> +
> +    if ((bp->saved_insn & 0x3) == 0x3) {
> +        if (cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&bp->saved_insn, 4, 0)
> +            || cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&ebreak_insn, 4, 1)) {
> +            return -EINVAL;
> +        }
> +    } else {
> +        if (cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&c_ebreak_insn, 2, 1)) {
> +            return -EINVAL;
> +        }
> +    }
> +
> +    return 0;
> +}
> +
> +int kvm_arch_remove_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
> +{
> +    uint32_t ebreak;
> +    uint16_t c_ebreak;
> +
> +    if ((bp->saved_insn & 0x3) == 0x3) {
> +        if (cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&ebreak, 4, 0) ||
> +            ebreak != ebreak_insn ||
> +            cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&bp->saved_insn, 4, 1)) {
> +            return -EINVAL;
> +        }
> +    } else {
> +        if (cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&c_ebreak, 2, 0) ||
> +            c_ebreak != c_ebreak_insn ||
> +            cpu_memory_rw_debug(cs, bp->pc, (uint8_t *)&bp->saved_insn, 2, 1)) {
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
> +void kvm_arch_update_guest_debug(CPUState *cs, struct kvm_guest_debug *dbg)
> +{
> +    if (kvm_sw_breakpoints_active(cs)) {
> +        dbg->control |= KVM_GUESTDBG_ENABLE;
> +    }
> +}
> --
> 2.17.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

