Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB62606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 19:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WItU75J4;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gxZlFbUL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNEJZ-0004d0-Uw; Sat, 31 Oct 2026 15:00:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xNEJA-0004JO-Bt
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 15:00:11 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xNEJ7-0001eE-Jd
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 15:00:04 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69VGUAMA1020234
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2026 18:59:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +oDmP653b7noBfI68TR23wGzbkvJ34PPEWowfFeCW1g=; b=WItU75J4ANHhoM60
 az8Tk78FOXhw2yHZAXR7wiVxwbjd+6NjvTNaccWsrzcDzlQltEGb1HSIiEtRjeQS
 hVOGLNyU8RCNe44wrmV0OAhE/SyGl4+IFQZaxspAb5tA301mYXIewqcyE5Ro3jw1
 Ls9e0J7e7ULrV/JqgXthbat+BXv8J+RmcrU1O8XI1hKKVMfVsUGLTVYFK2EUblpH
 nX88iz1G4xExTPe9Gg1/+mnDuN75HnpwUorRGPC/ZInyUbz8JNNSo0K90yLVq2Sz
 EgsZh2A8clpDKTg8NVKherWrIqTcSWkSYj8xbsUwbluemETHX568YYzh+yqn+fpE
 72I6oQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn9gk1nwu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2026 18:59:53 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-9197553d398so37695366d6.1
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2026 11:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793473192; x=1794077992; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+oDmP653b7noBfI68TR23wGzbkvJ34PPEWowfFeCW1g=;
 b=gxZlFbULhLBLIU6MGvPpZV1voSOVZP3tTnioncSxu5qCuOA+hF7e2mPnz4lll9tdfw
 nF8zzTRQx71l30+rKS93KyU0WX1jEFYst+QSWSF4uA4zQ6bvOrKE7gSOcjTJr2uTCqYU
 /A6xs8bLwuaERsN3zF88gf6bQ+yYHLXbWjUY28/B9+sAiAxwCMMQfK2smBJ0w45wuGaH
 QdF8rBDMKjR+g+7dX6p4JSNqTHkT5vo8d870z3wxBZsaL0JbE416cnoQWhdGpiC9R0Aj
 yKDrhvk5STN55XCzAgSTy7YeWqwmvza96vdT6MBbhAv9154M2DhgLQ4O+5AjxM37VMrE
 9NRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793473192; x=1794077992;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+oDmP653b7noBfI68TR23wGzbkvJ34PPEWowfFeCW1g=;
 b=cIOmCMgiqS35vaNM5zdc0LNwUNE5eGB/83JW8h4XqO2lN6paol9n3UsuF8AdPvwnLj
 UD5n7vDJKii7UNBO+7bz4y3WJekGp93p/IuRy5Bix6KBNM5foJVg+Gqhk2Pv8cLwTUg8
 js9IpZKOlkqwudVP9hwNRDTNybAnJoqlKXHwvzd91xz7Y2khxZcfnRufTUmrHrgImt4Z
 enVcmLbVvO6K56xlhsXAIyIxSj8i1BCwKwBptYM6BY03MmMYDn17Zef4Ke1ePGNTR3U1
 CGyBgSDJPYv6RsDzfbuDB4FhStGd1JStdlevV9YhvR03Ivym8lskDXfxyQkIap+IOqEi
 TKCA==
X-Forwarded-Encrypted: i=1;
 AKwUvByQWbOTrHvQMXXFN+1Ui9AxEHMKnBhwMiHhMrrba4Oo5WeJpW8HzKkcqps3x6O0VB/t6KBF1E43eUSk@nongnu.org
X-Gm-Message-State: AFq9FYLNfUsNvxuU6lvIQ3fIq8xGlX7Bap3QUAKWx9rwVHQvJsGOOney
 e7nEhQ34NmY+y0zt+hiNZ99hCDqC6fzNR5xrxXOzTlINqnZbWgaYJ/hRoi8GI4U8MT1jyVQs3Qe
 IIY1NO6hOb+NCFOWYWXyN4vH38XVwkGgj9sHHSlGJQ4TTiftxFOP0PKfhog==
X-Gm-Gg: AYBFou3BVcZU9oqx2uhK5Zp3p/q20CSUBbAV1Ik+BDMXQ1tzehmBtLwPDUlbnlzI+G8
 W+ACWoqHtOI9q+Gr7fCMt0/hwq4BEJwX2Qylo3+hcEv8pJVN5JMHNuFPaAD0L9hsL1HLHjyv8vl
 UbdvTVvJ4Nag+dX/ma3/JX/bc42x1jLRK+u9s52B1qNFRSlFtYSQ5VIavIaTHgnJSDXDKFS9bc0
 6lmZeMSQMqvo5QmR8/XngWNu9MSRAPsSyzt6T0uxNiGT/itUNFoyx0ZPnKK6iezVX/TK+YpXouM
 Zp01PanWp9huPqerwDf9mmV+Wrckx+lvfybU9Ag+YNzRoZe4edpZrAvyVZSVWqvk8/30I0d0IPu
 9uvy87kHU9PqF4vfWyuVOw0mllRuyBknBUzNE2KULbtNxgSPa2YT41IjlfX23tJXXjjzwCqCSw+
 /iinCyMsDCCw==
X-Received: by 2002:a05:6214:85c6:10b0:91c:aadc:5725 with SMTP id
 6a1803df08f44-91caadc57e4mr58362176d6.34.1793473192276; 
 Sat, 31 Oct 2026 11:59:52 -0700 (PDT)
X-Received: by 2002:a05:6214:85c6:10b0:91c:aadc:5725 with SMTP id
 6a1803df08f44-91caadc57e4mr58361996d6.34.1793473191766; 
 Sat, 31 Oct 2026 11:59:51 -0700 (PDT)
Received: from [192.168.68.102] ([152.234.122.251])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91ca7e23441sm47871466d6.4.2026.10.31.11.59.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 31 Oct 2026 11:59:50 -0700 (PDT)
Message-ID: <b2dc0bb7-75ae-4355-a551-cddb9b2c3ab3@oss.qualcomm.com>
Date: Sat, 31 Oct 2026 15:59:47 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] tests/tcg/riscv64: add test for mret to S-mode
 with no PMP entry
To: tewaro <tewaro@theorem.dev>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, disclosures@theorem.dev, tewaro@tewaro.org
References: <cover.1793217528.git.tewaro@theorem.dev>
 <e6710bc2fb2759f2272ba037a6019374293f7aa9.1793217528.git.tewaro@theorem.dev>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <e6710bc2fb2759f2272ba037a6019374293f7aa9.1793217528.git.tewaro@theorem.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: sQLUV1rNUmbEryqP_E-A431Dt6jWHBT9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMxMDA3NSBTYWx0ZWRfX43Wh4qWJQqhE
 /VigJ7uNmRVLc89kLDLWP+teqHd6IfmG2HJA+TxQy2yo/Y3oWMobrbRu+rIS4I0cTG3/yl1OtmX
 hquVYQts66kc+ZoCVtHuZVIcmnjGXHB78gT9mEc9zoPyLgRBN9AEAWcvaYuqwQ+rINTCF1ETBVS
 WgUQ4KM/ELyRzpsiVwBATrTLPJNxdOqEXt+uhJkeW9LEhyIC1r6gdpie+J+Fy9gTEqOMwggdqP9
 u7+ElyoMbiJjoLTeZY5YXPS1dB24zYJXTDR+H4Q9VXIkIDBbRZYzyfjAYRC+JBryPSOJbUctLE3
 KG1//oTNDrvmHEM+LZpWepONegy1mtcHJzAflXRtgYZ4Idce5vpUTAyj46SImEfpMN1XSuyHQnA
 T7bg9g9GI2fJFEs3S9sh9EMXXe4YPMcbrNdjrGgSk6JinOe9T1RL7O4KC9gP/y7Nj428zbYFUbx
 ik1voYoOcqQPCBnMXZA==
X-Authority-Analysis: v=2.4 cv=HNBWhYtv c=1 sm=1 tr=0 ts=6ae63aa9 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=QOY8BskYDu05dfarAz2gNQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=xvfqbYfxAAAA:20 a=EUspDBNiAAAA:8 a=AhPGFGNvZDribPAcdpEA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMxMDA3NSBTYWx0ZWRfX7aUMh2hDJ6J1
 e4AFzzPONt+Dw0iGBNXN1be2aty6MPU0uSCEz9KWzN2gXiTnN1NMGNOydgFAo8OcXSTQ6zs2oWr
 iDgVg1YfpfrvofcSaGL+BuI5ycsOvKk=
X-Proofpoint-ORIG-GUID: sQLUV1rNUmbEryqP_E-A431Dt6jWHBT9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-31_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 adultscore=0 suspectscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2610310075
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/28/2026 5:01 PM, tewaro wrote:
> Regression test for the previous commit. With PMP implemented and no
> entry configured, the test executes mret to S-mode and checks in the
> M-mode trap handler that the fault is an instruction access fault
> taken from S-mode on the mret target, with mcause 1, mepc and mtval
> equal to the target and MPP equal to S. It exits with 0 on success or
> the number of the failed check.
> 
> Signed-off-by: tewaro <tewaro@theorem.dev>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

> v2: rebased onto current master; the meson.build entry moved to sit
> between the tests added since v1. No other change.
> 
>   tests/tcg/riscv64/system/meson.build |   1 +
>   tests/tcg/riscv64/test-mret-nopmp.S  | 100 +++++++++++++++++++++++++++
>   2 files changed, 101 insertions(+)
>   create mode 100644 tests/tcg/riscv64/test-mret-nopmp.S
> 
> diff --git a/tests/tcg/riscv64/system/meson.build b/tests/tcg/riscv64/system/meson.build
> index 3c8b018d9e..f7410c6a65 100644
> --- a/tests/tcg/riscv64/system/meson.build
> +++ b/tests/tcg/riscv64/system/meson.build
> @@ -25,6 +25,7 @@ tests += {
>     'test-minstret-ecall.S': setup + {'qemu_args': ['-icount', 'shift=1', qemu_args]},
>     'test-minstret-wfi.S': setup + {'qemu_args': ['-icount', 'shift=1', qemu_args]},
>     'test-misa-w.S': setup + {'qemu_args': ['-cpu', 'rv64,x-misa-w=true,c=true,v=true', qemu_args]},
> +  'test-mret-nopmp.S': setup + {'qemu_args': ['-cpu', 'rv64,pmp=true', qemu_args]},
>     'test-zvabd.S': setup + {'qemu_args': ['-cpu', 'rv64,v=true,vlen=256,x-zvabd=true', qemu_args]},
>     'test-vsepc-masking.S': setup + {
>       'test_name': 'test-vsepc-masking-c',
> diff --git a/tests/tcg/riscv64/test-mret-nopmp.S b/tests/tcg/riscv64/test-mret-nopmp.S
> new file mode 100644
> index 0000000000..df20f35bc8
> --- /dev/null
> +++ b/tests/tcg/riscv64/test-mret-nopmp.S
> @@ -0,0 +1,100 @@
> +/*
> + * Test mret to S-mode when PMP is implemented but no PMP entry is
> + * configured.
> + *
> + * The mret must succeed and the first S-mode fetch must fail [1][2].
> + * The trap is therefore taken from S-mode, with mcause 1, mepc and
> + * mtval equal to the mret target [3][4] and mstatus.MPP equal to S
> + * [5].
> + *
> + * Exit code is 0 on success, otherwise the number of the failed check.
> + *
> + * [1] Privileged ISA v1.12, 3.7.1 "Physical Memory Protection CSRs",
> + *     Priority and Matching Logic
> + * [2] Privileged ISA v1.12, 3.3.2 "Trap-Return Instructions"
> + * [3] Privileged ISA v1.12, 3.1.14 "Machine Exception Program Counter"
> + * [4] Privileged ISA v1.12, 3.1.16 "Machine Trap Value Register"
> + * [5] Privileged ISA v1.12, 3.1.6.1 "Privilege and Global
> + *     Interrupt-Enable Stack in mstatus register"
> + *
> + * Privileged ISA v1.12 (ratified, 2021-12-03):
> + * https://github.com/riscv/riscv-isa-manual/releases/tag/Priv-v1.12
> + * Current source, same wording:
> + * https://github.com/riscv/riscv-isa-manual/blob/4877e41a/src/priv/machine.adoc
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +	.option	norvc
> +
> +	.text
> +	.global _start
> +_start:
> +	/* Set up machine trap vector, handle everything in M-mode */
> +	lla	t0, machine_trap_handler
> +	csrw	mtvec, t0
> +	csrw	medeleg, zero
> +
> +	/* mstatus.MPP = S */
> +	li	t0, 0x1800
> +	csrc	mstatus, t0
> +	li	t0, 0x0800
> +	csrs	mstatus, t0
> +
> +	/* Return to S-mode at `target` with no PMP entry configured */
> +	lla	t0, target
> +	csrw	mepc, t0
> +	mret
> +
> +target:
> +	/* Should be unreachable with no PMP */
> +	li	a0, 5
> +	j	_exit
> +
> +machine_trap_handler:
> +	/* 1: mcause is instruction access fault */
> +	li	a0, 1
> +	csrr	t0, mcause
> +	li	t1, 1
> +	bne	t0, t1, _exit
> +
> +	/* 2: mepc == target, not mret in _start */
> +	li	a0, 2
> +	csrr	t0, mepc
> +	lla	t1, target
> +	bne	t0, t1, _exit
> +
> +	/* 3: mtval == target because aligned instructions */
> +	li	a0, 3
> +	csrr	t0, mtval
> +	bne	t0, t1, _exit
> +
> +	/* 4: trap from S-mode */
> +	li	a0, 4
> +	csrr	t0, mstatus
> +	srli	t0, t0, 11
> +	andi	t0, t0, 3
> +	li	t1, 1
> +	bne	t0, t1, _exit
> +
> +	li	a0, 0
> +	j	_exit
> +
> +/* Exit with semihosting */
> +_exit:
> +	lla	a1, semiargs
> +	li	t0, 0x20026	/* ADP_Stopped_ApplicationExit */
> +	sd	t0, 0(a1)
> +	sd	a0, 8(a1)
> +	li	a0, 0x20	/* TARGET_SYS_EXIT_EXTENDED */
> +
> +	/* Semihosting call sequence */
> +	slli	zero, zero, 0x1f
> +	ebreak
> +	srai	zero, zero, 0x7
> +	j	.
> +
> +	.data
> +	.balign	8
> +semiargs:
> +	.space	16


