Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FC1DC4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 20:00:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2cbj-00065x-CU; Thu, 02 May 2024 16:00:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2cbg-000659-Aq
 for qemu-devel@nongnu.org; Thu, 02 May 2024 16:00:40 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2cbe-0007KQ-96
 for qemu-devel@nongnu.org; Thu, 02 May 2024 16:00:40 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-61c4ebd0c99so149790a12.0
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 13:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714680036; x=1715284836; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LZqfh/KwcCsUqY+24v3RlfgsNvqPd8x5mQUp5UsxqHc=;
 b=WmOkcMRV7A9cRJu6lO7Qg13VWmJoIgS28xfitVDVI2HNg7WGaCpfe6vz2uqJNQgJoJ
 SrIcU1NjjvA6AJKvpMbt+ADFwr84eDnnACuoZs9wFFeRNo0L9FMhj94UFHaRCX7G31if
 A3Lzr+uTCOrMDf+pJrEW/PSYU7gqcWiUmTw56XPOhF7mssXTCmo+D1CbUpQkqm7Dcy/H
 G+vUrEV4L2VKtzo0m5VYDirJDUNudJ/7oFzvqpNy0gy4aDLh2SA5SFpSo+F1TZ2CgXe4
 tt/8kUwLTGMmMQ4CXSLwEFUoTz4ELXmIn76HmAr4RyoWCxOh41m/yylUoiJ4ul4CZ8My
 im8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714680036; x=1715284836;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LZqfh/KwcCsUqY+24v3RlfgsNvqPd8x5mQUp5UsxqHc=;
 b=eBURCajVDMj747EQkYj/TaiDprfO/7Uyu+Itxtj2/YRcRQ/3vNv/V4w8ou4GeNJ35Q
 i3ZfzET/wz0f67X1v6WfYyELXsiJPLuhuJ4pN5WUsy6NHmbBOG9yOEnI8oSBOtsJiJXO
 WMuEYqCc3/lt98EztIbaIHG7FS0R6gOz2T+ynwfCiwW+Ui/UeojH3suXywz4SWZq8oiT
 MyMuXnIJPeWtOoz2A38DJelAO3ATNyf7HF0wRUtLKoQ5dpA+GAm56jV3OLGdTcWQfLES
 jer5/yU4wNt1HqPJGtOu+h8icVdgu0ASDhSxOoO6RfTAxZkevwsJrlVdxCWCZ7Kr47gf
 we6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUH2FnhWndm9AFu+Gwix/4ntc9ZaVswYF1s0F2+IcQSushSWx0PGGL0G6/Z7/ei5ZteBkngVegxJIOhnMrVK2lvmUHprLE=
X-Gm-Message-State: AOJu0Yx9vyd+A2F/n9X4FvGFy5eQlHJHUGXlg7p0rydyM6L9EcDfT6OW
 qnvAMS9DzugsrvnKucJ/KRemwgC46jEICCypIINmJIxlPZ2oxs3fsOm2ROREuN8=
X-Google-Smtp-Source: AGHT+IFhftyP3JLzT2okIADO+Xsf/wJgWWPD/GbF6DIc4t1NFy66CYVsegI8ex5BEyDe8kSEwfdXYg==
X-Received: by 2002:a17:90a:5897:b0:2a2:5db5:b1ed with SMTP id
 j23-20020a17090a589700b002a25db5b1edmr891341pji.17.1714680036598; 
 Thu, 02 May 2024 13:00:36 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 m4-20020a17090a858400b002b328adaa40sm1664959pjn.17.2024.05.02.13.00.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 May 2024 13:00:36 -0700 (PDT)
Message-ID: <c5613f05-5cfe-4f8a-b5b2-0d62ea1cf808@linaro.org>
Date: Thu, 2 May 2024 13:00:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] Hexagon: add PC alignment check and exception
To: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>,
 qemu-devel@nongnu.org
Cc: bcain@quicinc.com, sidneym@quicinc.com, ale@rev.ng, anjo@rev.ng,
 ltaylorsimpson@gmail.com, Laurent Vivier <laurent@vivier.eu>
References: <1b9cf61fb615d081f480b3f4a8ef1ef26fd4aeb4.1714677574.git.quic_mathbern@quicinc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <1b9cf61fb615d081f480b3f4a8ef1ef26fd4aeb4.1714677574.git.quic_mathbern@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 5/2/24 12:20, Matheus Tavares Bernardino wrote:
> The Hexagon Programmer's Reference Manual says that the exception 0x1e
> should be raised upon an unaligned program counter. Let's implement that
> and also add some tests.
> 
> Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> ---
> Changes in v5:
> - Merged asm and C test files into a single file.
> 
>   target/hexagon/cpu.h              |  7 +++
>   target/hexagon/cpu_bits.h         |  4 ++
>   target/hexagon/macros.h           |  3 -
>   linux-user/hexagon/cpu_loop.c     |  4 ++
>   target/hexagon/op_helper.c        |  9 ++-
>   tests/tcg/hexagon/unaligned_pc.c  | 98 +++++++++++++++++++++++++++++++
>   tests/tcg/hexagon/Makefile.target |  2 +
>   7 files changed, 119 insertions(+), 8 deletions(-)
>   create mode 100644 tests/tcg/hexagon/unaligned_pc.c
> 
> diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
> index 3eef58fe8f..764f3c38cc 100644
> --- a/target/hexagon/cpu.h
> +++ b/target/hexagon/cpu.h
> @@ -134,6 +134,10 @@ struct ArchCPU {
>   
>   FIELD(TB_FLAGS, IS_TIGHT_LOOP, 0, 1)
>   
> +G_NORETURN void hexagon_raise_exception_err(CPUHexagonState *env,
> +                                            uint32_t exception,
> +                                            uintptr_t pc);
> +
>   static inline void cpu_get_tb_cpu_state(CPUHexagonState *env, vaddr *pc,
>                                           uint64_t *cs_base, uint32_t *flags)
>   {
> @@ -144,6 +148,9 @@ static inline void cpu_get_tb_cpu_state(CPUHexagonState *env, vaddr *pc,
>           hex_flags = FIELD_DP32(hex_flags, TB_FLAGS, IS_TIGHT_LOOP, 1);
>       }
>       *flags = hex_flags;
> +    if (*pc & PCALIGN_MASK) {
> +        hexagon_raise_exception_err(env, HEX_EXCP_PC_NOT_ALIGNED, 0);
> +    }
>   }
>   
>   typedef HexagonCPU ArchCPU;
> diff --git a/target/hexagon/cpu_bits.h b/target/hexagon/cpu_bits.h
> index 96fef71729..4279281a71 100644
> --- a/target/hexagon/cpu_bits.h
> +++ b/target/hexagon/cpu_bits.h
> @@ -20,9 +20,13 @@
>   
>   #include "qemu/bitops.h"
>   
> +#define PCALIGN 4
> +#define PCALIGN_MASK (PCALIGN - 1)
> +
>   #define HEX_EXCP_FETCH_NO_UPAGE  0x012
>   #define HEX_EXCP_INVALID_PACKET  0x015
>   #define HEX_EXCP_INVALID_OPCODE  0x015
> +#define HEX_EXCP_PC_NOT_ALIGNED  0x01e
>   #define HEX_EXCP_PRIV_NO_UREAD   0x024
>   #define HEX_EXCP_PRIV_NO_UWRITE  0x025
>   
> diff --git a/target/hexagon/macros.h b/target/hexagon/macros.h
> index 1376d6ccc1..f375471a98 100644
> --- a/target/hexagon/macros.h
> +++ b/target/hexagon/macros.h
> @@ -22,9 +22,6 @@
>   #include "hex_regs.h"
>   #include "reg_fields.h"
>   
> -#define PCALIGN 4
> -#define PCALIGN_MASK (PCALIGN - 1)
> -
>   #define GET_FIELD(FIELD, REGIN) \
>       fEXTRACTU_BITS(REGIN, reg_field_info[FIELD].width, \
>                      reg_field_info[FIELD].offset)
> diff --git a/linux-user/hexagon/cpu_loop.c b/linux-user/hexagon/cpu_loop.c
> index 7f1499ed28..d41159e52a 100644
> --- a/linux-user/hexagon/cpu_loop.c
> +++ b/linux-user/hexagon/cpu_loop.c
> @@ -60,6 +60,10 @@ void cpu_loop(CPUHexagonState *env)
>                   env->gpr[0] = ret;
>               }
>               break;
> +        case HEX_EXCP_PC_NOT_ALIGNED:
> +            force_sig_fault(TARGET_SIGBUS, TARGET_BUS_ADRALN,
> +                            env->gpr[HEX_REG_R31]);
> +            break;
>           case EXCP_ATOMIC:
>               cpu_exec_step_atomic(cs);
>               break;
> diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
> index da10ac5847..ae5a605513 100644
> --- a/target/hexagon/op_helper.c
> +++ b/target/hexagon/op_helper.c
> @@ -36,10 +36,9 @@
>   #define SF_MANTBITS    23
>   
>   /* Exceptions processing helpers */
> -static G_NORETURN
> -void do_raise_exception_err(CPUHexagonState *env,
> -                            uint32_t exception,
> -                            uintptr_t pc)
> +G_NORETURN void hexagon_raise_exception_err(CPUHexagonState *env,
> +                                            uint32_t exception,
> +                                            uintptr_t pc)
>   {
>       CPUState *cs = env_cpu(env);
>       qemu_log_mask(CPU_LOG_INT, "%s: %d\n", __func__, exception);
> @@ -49,7 +48,7 @@ void do_raise_exception_err(CPUHexagonState *env,
>   
>   G_NORETURN void HELPER(raise_exception)(CPUHexagonState *env, uint32_t excp)
>   {
> -    do_raise_exception_err(env, excp, 0);
> +    hexagon_raise_exception_err(env, excp, 0);
>   }
>   
>   void log_store32(CPUHexagonState *env, target_ulong addr,
> diff --git a/tests/tcg/hexagon/unaligned_pc.c b/tests/tcg/hexagon/unaligned_pc.c
> new file mode 100644
> index 0000000000..de50e5be9d
> --- /dev/null
> +++ b/tests/tcg/hexagon/unaligned_pc.c
> @@ -0,0 +1,98 @@
> +#include <stdio.h>
> +#include <signal.h>
> +#include <setjmp.h>
> +#include <stdlib.h>
> +
> +/* will be changed in signal handler */
> +volatile sig_atomic_t completed_tests;
> +static jmp_buf after_test;
> +static int nr_tests;
> +
> +void __attribute__((naked)) test_return(void)
> +{
> +    asm volatile(
> +        "allocframe(#0x8)\n"
> +        "r0 = #0xffffffff\n"
> +        "framekey = r0\n"
> +        "dealloc_return\n"
> +        :
> +        :
> +        : "r0", "r29", "r30", "r31", "framekey");
> +}
> +
> +void test_endloop(void)
> +{
> +    asm volatile(
> +        "loop0(1f, #2)\n"
> +        "1: r0 = #0x3\n"
> +        "sa0 = r0\n"
> +        "{ nop }:endloop0\n"
> +        :
> +        :
> +        : "r0", "sa0", "lc0", "usr");
> +}
> +
> +asm(".org 0x3\n"
> +    ".global test_multi_cof_unaligned\n"
> +    "test_multi_cof_unaligned:\n"
> +    "   jumpr r31\n");

This seems fragile, because you don't really know that the compiler has not emitted 
something else before setting origin to 3.  Nor do you really know that you're emitting 
this hunk into the text section.

> +
> +void test_multi_cof(void)
> +{
> +    asm volatile(
> +        "p0 = cmp.eq(r0, r0)\n"
> +        "{\n"
> +        "    if (p0) jump test_multi_cof_unaligned\n"
> +        "    if (!p0) jump 1f\n"
> +        "}\n"
> +        "1: nop\n"

Does it work to write "jump 1f+1" or something?

While it shouldn't matter, perhaps trap[01] would be better than nop here?
Also, the bike shed should be green.


r~

