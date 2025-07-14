Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9949BC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 15:05:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubKji-0001Mm-WA; Mon, 14 Jul 2025 11:04:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1ubJL9-0003Rn-TF
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 09:35:32 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1ubJL2-0001yn-LS
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 09:35:31 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-747c2cc3419so3494969b3a.2
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 06:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1752500121; x=1753104921; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+sKk50Mo4QGxo3A1JEraQgJ7dZKu6iCqoahIO2s8CZw=;
 b=TLVzrpbz2cierE1ts0dW0in7fw9CTqaMJwW3iQiyuxXvxsKE5N1iWSxr4uV4n6emLD
 68CBPOMHx6Jg7KDdQ2qb4UHhrujMYq3G3Rf8KETqOuQNRnYlzbZ9O458TaHQ1CGzJp98
 yOah6vjRDTYpGTTTYDYvIxWS2bICrjhToYXhfiZ1zazZBF3KzZIPBKJJBNqGFEezx3uo
 YRA5bKHJZOgMt0GRSS3rWWoVq5c78PXRcHceKsFdTltfzRKCAvoC/i3EkuJnQULKfRIN
 0k0JvJ6A/KP0NU1MJDyYeGcSczO3iSaNj2VPJLpE1VTnsQ7MRxSRLHcXUaiLfFpKP2/D
 9R3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752500121; x=1753104921;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+sKk50Mo4QGxo3A1JEraQgJ7dZKu6iCqoahIO2s8CZw=;
 b=L0gODj3Yb1f766HP1i2JBq+7fr8pGA0r90lI8Y1N/taJpmb0aWQSmYIePwy44ZpA6O
 vlzW/z9du4ANizPgT6CpT00G56fOIdmBZHeHkh7G2bkH1vFmUXUbSiUWxb83NW8hZER4
 R4jI4WHn3cWBtS5xsbpp9LgscDTAXvEjONRbEyTRo9WWlEeulTLHA3rAmC7rvvOvq+rW
 Xc9bZjdE0gLxLIfK0Jbzf2KvFn//ClDZaXNO4IjmjogwJbTlNokcaPe+0W6Dv7Vb1/XY
 a7idiUZZR/1NO/fF49KLHSr7WOfw1RNOHsRuYt8ADsGt5FhFnMdoK/Ks1JC/QdwYfFgE
 Xznw==
X-Gm-Message-State: AOJu0YwS4yJOSaKGlo6QhKl8aVywlIzH1i3u7atKNANQl0nhQ0fDjLwN
 i6eLikHO5C4MEfYPFw3HEhzI6NrR0SS5t5wVS6G5oScNhofbnqviHhtAob1G18PgJvJ3an/mEA8
 KkvyW
X-Gm-Gg: ASbGncuej0euOTJsoCHHqJAl9d9cmoucBZxX6e62U+GdxjoNXyeQ93iZF3if8BHie1n
 a25xPH7Zl1mnenPNqblLTnWpuFV4xG3e0hWoARWJOHQLzcKmUkmAw2Cz/vTGTkKPE5g0lV1WZqD
 u1lJZrX/tOP+wTxN/+LXzUjZH7WUTqVkliSmSK3pHfFQ5Tuf33yJL577uVJwnu4VDmlcsygENZ7
 QYA6fMPY+txCMKjFxNpCNFdexZwiIduC0pmhXELFS2ovDw/0z1tOWaWahlm5RDwM+HlPVRWCnRK
 0RBlWILzsQPXbLd+ccwzLfuMjwUVs/bwQCyEdlusoLY952eB1QebeySV4W8SOOAwwL89p4DlNfP
 EzfnEeo91n0JS14SYhIYzHiXq4zMFzsdUmXmQVg==
X-Google-Smtp-Source: AGHT+IGS/4lFxPF9rwRlRd16lyhSm3s12ssZ3HK6jYY2yEo16zTSS4YfcrefEmt8DbJKDjAxnh5nAg==
X-Received: by 2002:a05:6a00:2d12:b0:748:e4f6:ff31 with SMTP id
 d2e1a72fcca58-74ee129846cmr22352316b3a.8.1752500121018; 
 Mon, 14 Jul 2025 06:35:21 -0700 (PDT)
Received: from [192.168.68.110] ([177.170.118.252])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74eb9f5c7f7sm11005711b3a.142.2025.07.14.06.35.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Jul 2025 06:35:20 -0700 (PDT)
Message-ID: <24b7c6e7-4594-4978-8e00-e40d72bccb14@ventanamicro.com>
Date: Mon, 14 Jul 2025 10:35:16 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: set mtval = 0 for illegal_inst if no opcode
 avail
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 richard.henderson@linaro.org
References: <20250714120822.1243870-1-dbarboza@ventanamicro.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250714120822.1243870-1-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi,


Please disregard this patch. Richard taught me how to fix the unwinding instead.


Thanks,

Daniel

On 7/14/25 9:08 AM, Daniel Henrique Barboza wrote:
> There is no guarantee that we'll able to get a proper opcode to put into
> mtval for illegal inst exceptions, as demonstrated in [1].
> 
> The 'proper opcode' would be retrieved via unwinding the CPU state (via
> cpu_restore_state(), down to riscv_restore_state_to_opc()) after
> riscv_raise_exception(). There are cases where that doesn't happen:
> we'll see a failure in cpu_restore_state(), where in_code_gen_buffer()
> will return 'false' even for a 'host_pc' that is retrieved via GETPC()
> and not in an instruction fetch context.
> 
> Hopefully we don't have to always provide mtval in these cases. The
> RISC-V priv ISA says that mtval for illegal_inst exceptions are
> optional, and the faulting instruction address will be reported in
> env->mepc.
> 
> The ISA also says that we can set mtval to ILEN/MXLEN bits of the
> faulting insn address, and we could do that when we're not able to fetch
> the opcode. But that would add inconsistency in how we behave since
> mtval would have either the opcode or the insn addr, and no easy way of
> knowing which one we have, and software would need to check it with mepc
> regardless. Zeroing mtval when we don't have the opcode is clearer.
> 
> And yes, zeroing mtval due to an unwind failure isn't ideal either, but
> it's less worse than reporting a wrong mtval. Until we figure out a way
> to fix the unwinding in this case, let's clear mtval and let software
> know that it must find the faulting opcode via other means.
> 
> [1] https://gitlab.com/qemu-project/qemu/-/issues/3020
> 
> Closes: https://gitlab.com/qemu-project/qemu/-/issues/3020
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>   target/riscv/cpu_helper.c |  5 +++++
>   target/riscv/op_helper.c  | 21 +++++++++++++++++++++
>   2 files changed, 26 insertions(+)
> 
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 3479a62cc7..1cd1849a1d 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -2243,6 +2243,11 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>               break;
>           case RISCV_EXCP_ILLEGAL_INST:
>           case RISCV_EXCP_VIRT_INSTRUCTION_FAULT:
> +            /*
> +             * Note: we'll set tval = 0 for illegal_inst cases
> +             * where we failed to unwind and to get the proper
> +             * opcode. See riscv_raise_exception() for more info.
> +             */
>               tval = env->bins;
>               break;
>           case RISCV_EXCP_BREAKPOINT:
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index 15460bf84b..930981a076 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -40,6 +40,27 @@ G_NORETURN void riscv_raise_exception(CPURISCVState *env,
>                             env->pc);
>   
>       cs->exception_index = exception;
> +
> +    /*
> +     * There is no guarantee that we'll be able to unwind
> +     * and set env->bins (the opcode for the current PC)
> +     * properly via the cpu_restore_state() path. The RISC-V
> +     * priv ISA says that:
> +     *
> +     * "The mtval register can optionally also be used to return
> +     * the faulting instruction bits on an illegal-instruction
> +     * exception (mepc points to the faulting instruction in
> +     * memory)."
> +     *
> +     * It's not ideal to set mtval != 0 in some cases and zero
> +     * in others due to unwind failures, but it's way better
> +     * than to set mtval to a bogus env->bins opcode from
> +     * the last successful unwinding.
> +     */
> +    if (cs->exception_index == RISCV_EXCP_ILLEGAL_INST) {
> +        env->bins = 0;
> +    }
> +
>       cpu_loop_exit_restore(cs, pc);
>   }
>   


