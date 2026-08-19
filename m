Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95ECBC5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 00:34:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwUG6-0004qf-ON; Tue, 18 Aug 2026 20:34:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwUG4-0004qR-Ka
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 20:34:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwUG2-0001Le-Hu
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 20:34:20 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67INm2Sr3119956
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 00:34:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1koLxZRwl7Uu11BvtuWs9126vNl30SnGLeI3eJ9dfzM=; b=YpMu0Eo8qL7gTEfk
 HrBK/FEEab2ppTuYz1tDyRpHD8lVJD2RLep3WERr8bXgrmIwFZrWn7AjplO86s7O
 FA8dFZ9hYzvgZnoa38owN8k4XVgXoG0t4cvA2KYvrdtzSX0jiz8uHRNcAEvxOZ+D
 m7taxQBuImBdYNYxtYnNUiIevtf328JfoSLjilS/K3+u8y5ivIhLEyf/zcfYRP9H
 GMLfc5DcYtn7j/mnMJcitbvxgMhXRytXs/idax/rPUyKt6HFHEwsRSYyRStDwyLS
 lDeVXYywLGIv6EidBcKtfqNRDOrIe+hjlarkEDaUxOR3vc/8rmHaP3lWO+ietcQT
 +hl3Ig==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4yfm8hxx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 00:34:15 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-9368b4c5964so45546085a.1
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 17:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787099655; x=1787704455; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1koLxZRwl7Uu11BvtuWs9126vNl30SnGLeI3eJ9dfzM=;
 b=hsvalOT5EJvKSXOWDOSiV+/DBFF0JLuACuvE0zUM6jy9LmA140FVI5K68F2c7ba9P/
 HxzmOGf4jwifn2hqEzZi8k1DysIMeWNlWQv6S0lLOKDE7ubPET+jXT95gI/4VUxPBST+
 pZlBfq0b5GcdBm4Il/c0nu0lUB8ZsNXOeEc+acfYQVk7Tc2P+wJ/bpLVJfA1fV51e6jc
 M7M8da5c0m59QbtVQhQoA1D7ISAR/ywBj2QIkl3lzok6wTgN8qej6KEwdpYMRByk2Gtd
 bXlifWi3tRgzI49MxJ0PkbAUuTltEGHZVV10gnYR6CbXEpWyLKkT9aGAKxm4xHMIzG+8
 rhiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787099655; x=1787704455;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1koLxZRwl7Uu11BvtuWs9126vNl30SnGLeI3eJ9dfzM=;
 b=Wy+h/3IYJ+bylhr9H1c7Dasx6zmNQww9t3ZVDv8m8F1kjyPqj65tLHQwLB82xNdTQ7
 ZiwArJanW9GjTFR6KdGbGcXy1GrZyx3LuXKUXuXjggaTKYGJkKEf410aKtdwQf/JDnxO
 0ppT4EpIZ56v8FPBLHfIV9KaSSbh7QVD8DvOij/RUGFS2emB1aGKByfbJOB9/6Oy7WsW
 c7TSuLDmA23/LONWxHlpF/tMLWl0XgQgf44HG+BokpEGfSosq8q65dEIyrPlkb4Qnp7l
 TNW1dRxCx+T/f8HlpqzNSS3YHL0PZKBymlXMONdEq1vq9XqnOHTwvyI2+wPg4F+cWgzh
 69Dg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr+HWAASw7w7FJ6nOqwS3/JC9c7RMwTrd6miFtE+K/yTqHT3J0ni/Y+aLrAnbgAIuQ/oE7qTPHfJDrT@nongnu.org
X-Gm-Message-State: AOJu0Yz1zdnZ81LMk29DeBEVWlSZkfv6/RWap4VBVlT8NHe5P2MW3x5Q
 1vSxaNA4kGkj/T4UEAF6w5B/XHUe91G6jvtztBIR4l/vpfH+ALvfZ+8SQiKURyPLpYt1jncEYFX
 t8iP5ADApawiDROqMigNYnt3j5DWqlzR+9fI/4ZLRJY39qEAER0P1KMbK3Q==
X-Gm-Gg: AR+sD1364ACk3xUsrIDi5w583AGO8Fzv8eXfQaBhGNX6IE/XVoYeKIeltSDp/zOBAiG
 sAQlF19qYf6gEKrh2oUnX/zNbauL76mmQ3OGrzfrdPkD71QaUtK/ixftf1xz7t876Zi9D9Z+eGR
 NdneJ7ngLGM7N63ZJrV52SAwCYoflfa2qePsnJRypqo5feBxcnPHIVZR5Um7EV+JdoNu+5hDawT
 67vPmS+ZRTV8ygKaGkxAjqYKy99e84m/d3Ids9twu4dkKnl/dny6VgGZRLdrwkEfcw0rLrE/Qxi
 te0nMKEVHrjEZlJzLK+/g8el9lP82r1bSBy+xNCGAGHwbVkiRYrmS756kMtehm1VhPlvFYerxoE
 Qya2nfqQNzXqb9ySmR4Ku01ZHU4wD+BtoMIQ=
X-Received: by 2002:a05:620a:6408:b0:915:d443:e6e1 with SMTP id
 af79cd13be357-9371e301758mr124369385a.26.1787099655035; 
 Tue, 18 Aug 2026 17:34:15 -0700 (PDT)
X-Received: by 2002:a05:620a:6408:b0:915:d443:e6e1 with SMTP id
 af79cd13be357-9371e301758mr124365785a.26.1787099654485; 
 Tue, 18 Aug 2026 17:34:14 -0700 (PDT)
Received: from [192.168.69.231] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa11f832sm12790215e9.7.2026.08.18.17.34.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2026 17:34:13 -0700 (PDT)
Message-ID: <a008db27-2c01-401e-b84e-19d6bce10193@oss.qualcomm.com>
Date: Wed, 19 Aug 2026 02:34:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] RFC: tcg: probe the TB jump cache inline instead of
 calling a helper
Content-Language: en-US
To: Matt Turner <mattst88@gmail.com>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, pbonzini@redhat.com, philmd@mailo.com,
 zhao1.liu@intel.com, laurent@vivier.eu, deller@gmx.de,
 pierrick.bouvier@oss.qualcomm.com, Anton Johansson <anjo@rev.ng>
References: <20260818174247.649526-1-mattst88@gmail.com>
 <20260818174247.649526-5-mattst88@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260818174247.649526-5-mattst88@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: iZgbE1_mA_1crx4t9-dzhHcqVqXh15sY
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDAwMiBTYWx0ZWRfX2NSXZ1ly3m+X
 dy7eLdV43Sza1IexN31JsBJxVnaDNTK1oFxw5JzxH9K2lgP2hVSXe4ly4JcwUI0GzuH21kci1C5
 VtfKxdZHe69y2f3LWpnxqo0zhTz0jSI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDAwMiBTYWx0ZWRfX4I2ZgydSNtwg
 /OkkoiU/YConxkUDcpWlydC1dB5giJTxDvOr07fryXZ0sXOvQKKs9c5Y7m6T1scWm8cdMZoxTV7
 KyXB5rs0I5fm3+YMrMKTlXD5zaCKqnazTwqdfMO0f119Y2lfefsr1B6jEhkOfMu62eYK68pphVQ
 po4OHAestBMPTnuN+62fxsrf0Nk8MkfilQPid+MbAVXVbqvBEdh4Pt8fClQS8rEWFjz8mqZG4YJ
 I1CPnPXv5IDij84X0sPhEeoGGFGVQ10XoglDnlpRCAHiOcXOKgs521S2F6jERoqu1c1axEE7+/A
 4D9DhqCDUhKA62+yJIze5BUGxCS3dxCwP1LXiE7QjL8jz+WRnEnPES7J/SJPmCobbAyitntqE+l
 QtHyTi+z8z8V1BqkGqMdl12SLkiDIEee7ECJqKTpr0pOkDT7PL1Bw3f+YjZHZIsXiy7AYbBspE1
 29/fCl4Ryz5TVUqF+xQ==
X-Authority-Analysis: v=2.4 cv=aNrAb79m c=1 sm=1 tr=0 ts=6a84fa07 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=pGLkceISAAAA:8 a=x5VL1JuEwXFcF9dteioA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: iZgbE1_mA_1crx4t9-dzhHcqVqXh15sY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_05,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190002
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 18/8/26 19:42, Matt Turner wrote:
> Every indirect branch that cannot use goto_tb ends in
> tcg_gen_lookup_and_goto_ptr(), which calls helper_lookup_tb_ptr(). For an
> emulated compiler that is 8.4 billion helper calls in a single translation
> unit: 24.6% of all TB exits take this path, because jsr/ret/jmp have a
> register destination and because goto_tb is restricted to same-page
> targets.
> 
> The helper itself is already tight, but each call pays for a call frame,
> the can_do_io store, the get_tb_cpu_state() indirect call through
> TCGCPUOps, curr_cflags(), and a breakpoint check, before it gets to the
> jump cache probe that almost always hits (95.8% for this workload).
> 
> Emit the probe inline instead. The destination PC is already in a TCG
> temp, and the flags and cflags the destination must match are constants at
> translation time, so the fast path is a hash, three guarded loads and a
> goto_ptr. Only a miss calls the helper, which still owns filling the cache.
> 
> Two details matter for the generated code. The flags and cflags guards are
> folded into a single aligned 64-bit load and compare, since the fields are
> adjacent. And each path emits its own goto_ptr rather than branching to a
> shared one: a temp live across the label is spilled and reloaded on every
> dispatch, which cost 6.3% on its own.
> 
> Measured with qemu-alpha running an emulated alpha gcc 16.2.0 compiling
> the SQLite 3.45.1 amalgamation (255k lines, -O2) on an x86-64 host, LTO
> build, on top of the preceding three patches:
> 
>      before: 1,402,816,253,499 instructions
>      after:    890,713,633,237 instructions   -36.51%
> 
>      before: 115.75s wall clock
>      after:   84.44s wall clock               -27.05%
> 
> The gap between the two is the point at which this stops being a
> straight-line win: the helper call was highly predictable work that the
> host pipelined well, so removing it retires far fewer instructions than it
> saves time. IPC falls from 2.48 to 2.15 across this patch for that reason.
> 
> Despite emitting more code, this also reduces instruction cache pressure,
> because a dispatch no longer jumps into qemu's .text and evicts translated
> code:
> 
>      before: 11,476,318,964 L1-icache-load-misses
>      after:   6,990,186,701 L1-icache-load-misses   -39.1%
> 
> The mechanism is visible directly in a profile: helper_lookup_tb_ptr()
> falls from 30.97% of samples to 0.42%, and qemu's own .text falls from
> 38.9% to 5.4%, with the balance moving into generated code.
> 
> Combined with the three preceding patches, against an unmodified LTO
> build, 1,647,901,588,726 instructions fall to 890,713,633,237, or -45.95%.
> The emulated compiler produces byte-identical output throughout.
> 
> Open issues, hence RFC:
> 
> - The flags/cflags guards use the *current* TB's values as constants. That
>    assumes the CPU flags feeding get_tb_cpu_state() cannot change within a
>    TB, and that curr_cflags() cannot change under a running TB (gdb
>    attaching to enable single-step would). Both need to be established or
>    the values need to be loaded at runtime.
> - tcg/tcg-op.c has no business including accel/tcg/tb-jmp-cache.h or
>    knowing the CPUJumpCache layout. The probe likely belongs in accel/tcg
>    with a small emit helper exported from tcg/.
> - The jump cache entry is read without qatomic_read(); entries are
>    invalidated concurrently by setting tb to NULL.
> - Only wired up for alpha so far, and only for 64-bit guest PCs.
> 
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> ---
>   include/tcg/tcg-op-common.h |  2 +
>   target/alpha/translate.c    |  4 +-
>   tcg/tcg-op.c                | 79 +++++++++++++++++++++++++++++++++++++
>   3 files changed, 83 insertions(+), 2 deletions(-)
> 
> diff --git ./include/tcg/tcg-op-common.h ./include/tcg/tcg-op-common.h
> index 1fe342db0d..65084c38b9 100644
> --- ./include/tcg/tcg-op-common.h
> +++ ./include/tcg/tcg-op-common.h
> @@ -84,6 +84,8 @@ void tcg_gen_goto_tb(unsigned idx);
>    * this op is equivalent to calling tcg_gen_exit_tb() with 0 as the argument.
>    */
>   void tcg_gen_lookup_and_goto_ptr(void);
> +void tcg_gen_lookup_and_goto_ptr_inline(TCGv_i64 pc,
> +                                        const TranslationBlock *tb);
>   
>   void tcg_gen_plugin_cb(unsigned from);
>   void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
> diff --git ./target/alpha/translate.c ./target/alpha/translate.c
> index c66e3f9c14..939170a28b 100644
> --- ./target/alpha/translate.c
> +++ ./target/alpha/translate.c
> @@ -449,7 +449,7 @@ static void gen_goto_tb(DisasContext *ctx, unsigned tb_slot_idx, int32_t disp)
>           tcg_gen_exit_tb(ctx->base.tb, tb_slot_idx);
>       } else {
>           gen_pc_disp(ctx, cpu_pc, disp);
> -        tcg_gen_lookup_and_goto_ptr();
> +        tcg_gen_lookup_and_goto_ptr_inline(cpu_pc, ctx->base.tb);
>       }
>   }
>   
> @@ -2917,7 +2917,7 @@ static void alpha_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
>           gen_pc_disp(ctx, cpu_pc, 0);
>           /* FALLTHRU */
>       case DISAS_PC_UPDATED:
> -        tcg_gen_lookup_and_goto_ptr();
> +        tcg_gen_lookup_and_goto_ptr_inline(cpu_pc, ctx->base.tb);
>           break;
>       case DISAS_PC_UPDATED_NOCHAIN:
>           tcg_gen_exit_tb(NULL, 0);
> diff --git ./tcg/tcg-op.c ./tcg/tcg-op.c
> index bbcb510c76..ab8d101871 100644
> --- ./tcg/tcg-op.c
> +++ ./tcg/tcg-op.c
> @@ -28,6 +28,8 @@
>   #include "tcg/tcg-op-common.h"
>   #include "exec/translation-block.h"
>   #include "exec/plugin-gen.h"
> +#include "hw/core/cpu.h"
> +#include "../accel/tcg/tb-jmp-cache.h"
>   #include "tcg-internal.h"
>   #include "tcg-has.h"
>   
> @@ -2620,3 +2622,80 @@ void tcg_gen_lookup_and_goto_ptr(void)
>       tcg_gen_op1i(INDEX_op_goto_ptr, TCG_TYPE_PTR, tcgv_ptr_arg(ptr));
>       tcg_temp_free_ptr(ptr);
>   }
> +
> +/*
> + * As tcg_gen_lookup_and_goto_ptr(), but probe the TB jump cache inline
> + * instead of calling helper_lookup_tb_ptr() unconditionally.  @pc must
> + * hold the destination guest PC; @flags and @cflags are the values the
> + * destination TB must have been translated with.
> + */
> +void tcg_gen_lookup_and_goto_ptr_inline(TCGv_i64 pc,
> +                                        const TranslationBlock *tb)

Thinking loudly, we should modify tcg_gen_lookup_and_goto_ptr() to
unconditionally expect these arguments.

> +{
> +    uint32_t flags = tb->flags;
> +    uint32_t cflags = tb->cflags;
> +    TCGv_ptr jc, ent, tbp, ptr;
> +    TCGv_i64 h, tmp;
> +    TCGLabel *slow;
> +    uint64_t fpair;
> +
> +    if (tcg_ctx->gen_tb->cflags & CF_NO_GOTO_PTR) {
> +        tcg_gen_exit_tb(NULL, 0);
> +        return;
> +    }
> +
> +    plugin_gen_disable_mem_helpers();
> +

Then here we decides whether to use this new fast path or generate the
the helper call.

As you mentioned the current implementation restriction is having
a 64-bit target.

> +    QEMU_BUILD_BUG_ON(sizeof(((CPUJumpCache *)0)->array[0]) != 16);
> +    QEMU_BUILD_BUG_ON(offsetof(TranslationBlock, cflags) !=
> +                      offsetof(TranslationBlock, flags) + 4);
> +
> +    jc = tcg_temp_ebb_new_ptr();
> +    ent = tcg_temp_ebb_new_ptr();
> +    tbp = tcg_temp_ebb_new_ptr();
> +    ptr = tcg_temp_ebb_new_ptr();
> +    h = tcg_temp_ebb_new_i64();
> +    tmp = tcg_temp_ebb_new_i64();
> +    slow = gen_new_label();
> +
> +    /* h = tb_jmp_cache_hash_func(pc) * sizeof(array[0]) */
> +    tcg_gen_shri_i64(h, pc, TB_JMP_CACHE_BITS);
> +    tcg_gen_xor_i64(h, h, pc);
> +    tcg_gen_andi_i64(h, h, TB_JMP_CACHE_SIZE - 1);
> +    tcg_gen_shli_i64(h, h, 4);
> +
> +    tcg_gen_ld_ptr(jc, tcg_env,
> +                   offsetof(CPUState, tb_jmp_cache) - sizeof(CPUState));
> +    tcg_gen_trunc_i64_ptr(ent, h);
> +    tcg_gen_add_ptr(ent, jc, ent);
> +
> +    tcg_gen_ld_ptr(tbp, ent, offsetof(CPUJumpCache, array[0].tb));
> +    tcg_gen_brcondi_ptr(TCG_COND_EQ, tbp, 0, slow);
> +
> +    tcg_gen_ld_i64(tmp, ent, offsetof(CPUJumpCache, array[0].pc));
> +    tcg_gen_brcond_i64(TCG_COND_NE, tmp, pc, slow);
> +
> +    /*
> +     * flags and cflags are adjacent uint32_t, so one aligned 64-bit load
> +     * and compare covers both.
> +     */
> +#if HOST_BIG_ENDIAN
> +    fpair = ((uint64_t)flags << 32) | cflags;
> +#else
> +    fpair = ((uint64_t)cflags << 32) | flags;
> +#endif
> +    tcg_gen_ld_i64(tmp, tbp, offsetof(TranslationBlock, flags));
> +    tcg_gen_brcondi_i64(TCG_COND_NE, tmp, fpair, slow);
> +
> +    tcg_gen_ld_ptr(ptr, tbp, offsetof(TranslationBlock, tc.ptr));
> +    tcg_gen_op1i(INDEX_op_goto_ptr, TCG_TYPE_PTR, tcgv_ptr_arg(ptr));
> +
> +    /*
> +     * Emit a second goto_ptr rather than branching to a shared one: a temp
> +     * live across the label would be spilled and reloaded on every dispatch.
> +     */
> +    gen_set_label(slow);
> +    ptr = tcg_temp_ebb_new_ptr();
> +    gen_helper_lookup_tb_ptr(ptr, tcg_env);
> +    tcg_gen_op1i(INDEX_op_goto_ptr, TCG_TYPE_PTR, tcgv_ptr_arg(ptr));
> +}


