Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F85DC79F9F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 11:46:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4dDb-0003IO-Se; Thu, 10 Sep 2026 07:45:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x4dDa-0003I7-AS
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 07:45:26 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x4dDY-0000O7-5i
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 07:45:26 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68A8pwuX3998388
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 11:45:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7lqFDL0oLjUl3F0ftVH44imTKW7jovpyppb/cNvXUwU=; b=bfxbn0+EFmQvzT+H
 1MUwyuAlz5HxXjyCA0S8gRdgOH0LwoQUdyI1oTXyf1moUy1XN78A6hKmiqLqpxrj
 MuwDDYw7Zt/K3k0EFnJIlUOaTdAwFuaXrTjBQriaevFcNRsQGGKwbKifZCMY5l4C
 Vvhe+fIiGGq3D6eMvTcUl7BnAX0YRfGealNF50OnLjOxEuk3JB98jT57I71JY7NT
 KRotGKXfW3ob9k/iXd6Q3Wyvexd1/3PxQH6qHZ+G4wmzd12Moxt7l2IZJOpiqXdl
 8fo2RAyulKRorFNgndQibTFq2asBS3cEIK2obwn7wPg9Eh/w4/ZXf3o3qcNZKdbA
 qsmFlA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkcyfkq3r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 11:45:22 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93903622880so178609285a.0
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 04:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789040722; x=1789645522; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7lqFDL0oLjUl3F0ftVH44imTKW7jovpyppb/cNvXUwU=;
 b=PJ4sAsHtvmypR4myVfvJs4i/GYgub+NhedZcG5lq2gcJFnsSb60NfspBGuOSy4+RIF
 lbmR9KXj7nBtT7sFeXZM4grYeSw98qfo8HqJ8Zq2ZaU/vvYBtK1J0/EB9ANJvoKjULGu
 Q1R6e92TU5jk/w8lb3fF8UXrK7lcmvhqkJbE7fxgLjLUtaHMxdP3RRM5SmrAZesrxAii
 jAKez74aGmPA8cLUgyUFeIIsxSnVncNKqlxds8szU+h5D7NErM0UX/CyfR23SBMwq/AF
 /iyGeT9rTOdyzB5OEo0qH/edtkLosdZHGN5rxwrgBYrbUO8qBK2VKc/MT0f4mgnEbMxU
 fsKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789040722; x=1789645522;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7lqFDL0oLjUl3F0ftVH44imTKW7jovpyppb/cNvXUwU=;
 b=RQ048dXcHWVzeajdQ8Az/NdT5h86ZmlJy4pUFIL8gPGpIX+0Zf+e7jrKktaC41AtLU
 Dl01Bt8OObboTDOUJSO7h4wSc0wjz2ohVIqadAZShbKcytsb+qfZHtVcDnUVQ9yBkSlq
 cYA7rmckaMyEZyuf6TKQ/twjdSkLxdAFX4/j57QYZ3aXXbGw6qumJiDBLX6cmEDXSjf6
 VWCJns+twO6mcpYz/6kdidl1X0v29sVBc6AYHA/Jsw2+PzL4+bGVeD11qqlbASnRU5JT
 V5P2C5k4lkFvGRWO0AonnWizqW71w0WfOKDmfc65URZwoItto05p+rprKemKbKKANYTq
 beJQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxdFvDmrLmwSnYTbOLEGIaMFlIY1KtkpeFkZjjKiBNnMQJUJOgl+BkrCajxXZOw2YTBa0Yd7Dd5+DVt@nongnu.org
X-Gm-Message-State: AFuF++n9mBBzEJoifzNsAesVqPqNGBnNmopOGPr4dZ4z7YFnlCo2fblo
 GKIDKkjq7sPo0mznnzH2IBCQMmzxib4sg3UXrA+ldF0aFLtgntSBJFGT3N25PeXIPP46bYyJ4OW
 f4BmpBNW2Z+7AX9zRcwKyAs5EJzILfOIwnPTyxSPBtPAL9/tPjSaKmpVlCw==
X-Gm-Gg: AYBFou0P/Gl0ZcSIDHjJOYbOEDLq2uJmGjQH3Tedor1J+iB2G/IHuG6ktsiKgnlnyMx
 hCdcK+BBQf7lqstyRHWqgIj2dWU2sCRrFxSpBitMiiVhn4e2ixs5VIr5xGwB/p4JkzQEojGrzbG
 nj6HBXL76gW3rODqMv1O81Ouu4PYocGUlMLlaeTz/YwxiX7rI7pDsq5OSBeVjcqF/BX9jmeAFHr
 KPOFDcVfk/MrOLhyBss94qmXPxdvNfrfs19mTExfBtgxvKNGIiDA8syMaYAHp7vcSCWRqJvClkG
 BqHMsEZC8ewTzQwBY7LCoID/VQEkirC22AW06DKHs9fgy8t774cQcmvcEESS6Vv5XMoR1xJ+m0N
 bxdb8mUnQdiT8/OFvr8mlnH73T6/0NFKmYiw=
X-Received: by 2002:a05:620a:46a0:b0:939:7cca:ed30 with SMTP id
 af79cd13be357-939d8018302mr517734285a.45.1789040721566; 
 Thu, 10 Sep 2026 04:45:21 -0700 (PDT)
X-Received: by 2002:a05:620a:46a0:b0:939:7cca:ed30 with SMTP id
 af79cd13be357-939d8018302mr517727885a.45.1789040721097; 
 Thu, 10 Sep 2026 04:45:21 -0700 (PDT)
Received: from [192.168.68.102] ([177.18.66.131])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91048476220sm138330086d6.31.2026.09.10.04.45.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Sep 2026 04:45:20 -0700 (PDT)
Message-ID: <1a3404e8-a9c7-40e2-8bd7-5a4d7c386537@oss.qualcomm.com>
Date: Thu, 10 Sep 2026 08:45:17 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/riscv: stop translating after WFI
To: Zephyr Li <fritchleybohrer@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com
References: <20260910025324.54990-1-fritchleybohrer@gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260910025324.54990-1-fritchleybohrer@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDEzOCBTYWx0ZWRfX1rRmabpNMgh/
 vFl4iwe0V6w1cFWuz71XwmAsKAye4HLq8+2tjdz++hpMtFH/bmbi04qPQd0S2F9TOsSIlzzMbwl
 bU+tOminchP9ccv5oB923cIo8g5mB1k=
X-Proofpoint-ORIG-GUID: 2L6MKIN19GU_1Ziv10GG8ykl5zp0dwHi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDEzOCBTYWx0ZWRfX8hO8hjm7BNYu
 fhrLeBbI+EYd848QTQBEhNZHEqyfMdOmvX3MkL8VUIKaMUfrn6SI4UjbJn7fs2LCkkkGHaDcFdg
 ZY8IGC3BxjNTW9zHikyK9je+lgJzUbSJoijEJ5iaK0sSZwG2ZNFY8mZ+kcur51bDwgNfB/7k+iU
 9Wf1CznWOq+qn49zwbudhMxugQ0RDIuBHGII5xysl1NZay4ZpYFi382jRRMnt2GnvylfD+Wackv
 v/4C7LEoVKQvtYcViuxpPTweP8GYe6lOp97hh13+ujjRRjDNq7dpOgfrbHJbUjMc28qPkAipOFe
 GkmgljqqcSEcJD3k6Fbnu3TzJkM1Q1H6YgTWW+QGhjYdGFhxtJHc7APhrz+W3cthZDbotWBdW72
 qNAPhZf/6stta/os7MvQmKJkto8bgFkaiXxrsfkh9xw6y2a1UyFknkydUqIyhYL07CVvZIANb5X
 7nBnp1VU42cyd5z8X8w==
X-Authority-Analysis: v=2.4 cv=H5pOUOYi c=1 sm=1 tr=0 ts=6aa29852 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=CQQxcbsX5Byh3TlVSSGwig==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=p0WdMEafAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=voxrwLIUQBIEJ0OO-V8A:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: 2L6MKIN19GU_1Ziv10GG8ykl5zp0dwHi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_03,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100138
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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



On 9/9/2026 11:53 PM, Zephyr Li wrote:
> helper_wfi() never returns to translated code: it either raises an
> exception or exits the CPU loop after marking the CPU as halted. However,
> trans_wfi() leaves the translation state as DISAS_NEXT, so instructions
> following WFI can be included in the same TB.
> 
> With icount enabled, this makes the following instruction part of the TB's
> instruction count when WFI exits, causing minstret to be incremented once
> too many. Set DISAS_NORETURN after emitting the helper.
> 
> Add a TCG test for both reported cases: WFI waking for a locally enabled
> pending interrupt with mstatus.MIE clear, and WFI taking a timer interrupt.
> 
> Fixes: 55c2a12cbcd3 ("RISC-V TCG Code Generation")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4230
> Signed-off-by: Zephyr Li <fritchleybohrer@gmail.com>
> 
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

> Changes in v2:
> - Register test-minstret-wfi.S with the Meson TCG test framework so
>    check-tcg executes it.
> 
> diff --git a/target/riscv/tcg/insn_trans/trans_privileged.c.inc b/target/riscv/tcg/insn_trans/trans_privileged.c.inc
> index a8eaccef67..ebbbb01179 100644
> --- a/target/riscv/tcg/insn_trans/trans_privileged.c.inc
> +++ b/target/riscv/tcg/insn_trans/trans_privileged.c.inc
> @@ -145,6 +145,7 @@ static bool trans_wfi(DisasContext *ctx, arg_wfi *a)
>       decode_save_opc(ctx, 0);
>       gen_update_pc(ctx, ctx->cur_insn_len);
>       gen_helper_wfi(tcg_env);
> +    ctx->base.is_jmp = DISAS_NORETURN;
>       return true;
>   #else
>       return false;
> diff --git a/tests/tcg/riscv64/system/meson.build b/tests/tcg/riscv64/system/meson.build
> index 8604c2a45a..2aca68e078 100644
> --- a/tests/tcg/riscv64/system/meson.build
> +++ b/tests/tcg/riscv64/system/meson.build
> @@ -23,6 +23,7 @@ tests += {
>     'test-mepc-masking.S': setup,
>     'test-crc32.S': setup + {'qemu_args': ['-cpu', 'rv64,xlrbr=true', qemu_args]},
>     'test-minstret-ecall.S': setup + {'qemu_args': ['-icount', 'shift=1', qemu_args]},
> +  'test-minstret-wfi.S': setup + {'qemu_args': ['-icount', 'shift=1', qemu_args]},
>     'test-misa-w.S': setup + {'qemu_args': ['-cpu', 'rv64,x-misa-w=true,c=true,v=true', qemu_args]},
>   }
>   
> diff --git a/tests/tcg/riscv64/test-minstret-wfi.S b/tests/tcg/riscv64/test-minstret-wfi.S
> new file mode 100644
> index 0000000000..0fd0158d5b
> --- /dev/null
> +++ b/tests/tcg/riscv64/test-minstret-wfi.S
> @@ -0,0 +1,100 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +	.option	norvc
> +
> +	.text
> +	.global	_start
> +_start:
> +	lla	t0, trap
> +	csrw	mtvec, t0
> +	li	s3, 0
> +
> +	/*
> +	 * A pending, locally enabled interrupt wakes WFI even with MIE
> +	 * clear.
> +	 */
> +	li	t0, 0x8		/* MIE_MSIE */
> +	csrw	mie, t0
> +	csrci	mstatus, 0x8	/* MSTATUS_MIE */
> +	li	t0, 0x2000000	/* MSIP0 */
> +	li	t1, 1
> +	sw	t1, 0(t0)
> +
> +	/*
> +	 * The first CSR read and WFI retire before the second read obtains s1,
> +	 * so the expected difference is two.
> +	 */
> +	csrr	s0, minstret
> +	wfi
> +	csrr	s1, minstret
> +	sub	s1, s1, s0
> +	li	t1, 2
> +	beq	s1, t1, 1f
> +	ori	s3, s3, 1
> +1:
> +
> +	/* Clear the software interrupt before testing the trap path. */
> +	sw	zero, 0(t0)
> +	csrw	mie, zero
> +
> +	/* Schedule a timer interrupt far enough ahead to reach WFI first. */
> +	li	t0, 0x200bff8	/* MTIME */
> +	ld	t1, 0(t0)
> +	addi	t1, t1, 100
> +	li	t0, 0x2004000	/* MTIMECMP0 */
> +	sd	t1, 0(t0)
> +	li	t0, 0x80		/* MIE_MTIE */
> +	csrw	mie, t0
> +	csrsi	mstatus, 0x8	/* MSTATUS_MIE */
> +
> +	/*
> +	 * The first CSR read and WFI retire before the trap handler obtains s1,
> +	 * so the expected difference is again two.
> +	 */
> +	li	s2, 1
> +	csrr	s0, minstret
> +	wfi
> +	beqz	s2, 1f
> +	ori	s3, s3, 2
> +1:
> +	bnez	s3, fail
> +	li	a0, 0
> +	j	_exit
> +
> +fail:
> +	mv	a0, s3
> +
> +_exit:
> +	lla	a1, semiargs
> +	li	t0, 0x20026	/* ADP_Stopped_ApplicationExit */
> +	sd	t0, 0(a1)
> +	sd	a0, 8(a1)
> +	li	a0, 0x20	/* TARGET_SYS_EXIT_EXTENDED */
> +
> +	/* Semihosting call sequence */
> +	.balign	16
> +	slli	zero, zero, 0x1f
> +	ebreak
> +	srai	zero, zero, 0x7
> +	j	.
> +
> +	.balign	4
> +trap:
> +	/* Read minstret before retiring an instruction in the handler. */
> +	csrr	s1, minstret
> +	sub	s1, s1, s0
> +	addi	s1, s1, -2
> +	snez	s2, s1
> +
> +	/* Disable the timer interrupt before returning past WFI. */
> +	li	t0, 0x2004000	/* MTIMECMP0 */
> +	li	t1, -1
> +	sd	t1, 0(t0)
> +	li	t0, 0x80		/* MIE_MTIE */
> +	csrc	mie, t0
> +	mret
> +
> +	.data
> +	.balign	16
> +semiargs:
> +	.space	16


