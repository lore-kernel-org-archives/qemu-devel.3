Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0407C624D0
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 11:32:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1jBo-0003LE-Vr; Wed, 02 Sep 2026 07:31:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x1jBn-0003Kl-K3
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 07:31:35 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x1jBl-0005cA-9J
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 07:31:35 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6829ND4L463877
 for <qemu-devel@nongnu.org>; Wed, 2 Sep 2026 11:31:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cSBypMk7UZ10ta6l8Hs0ZmoDf/3ZTmVqdRtsTSdvwWQ=; b=n0ZOYtpu5QRpdKTm
 8L+IcH6EEfcwMqCuMZjpib80c9n3ct67K4Hg7SkvdShqI/0cvJuvEm73sjyw4sVq
 YsVApg9G9qTAZtkrCDd3R3keejY8aaesQPW7YSj6QRtjpdxvYOPaXl8MV6zgP+yd
 TstM8qakATdvt9oTurfGpKc2Mhob6sPUOtF5KLMrxiUTjgvl/JG7NY5a4QLwLGj4
 alZ0DOLjR6dVthMnREIF+6O1dOh6MobHOa/grpBs/0mk2ZfKRVUX/9WeHTAXZdW8
 sU249+CN6SDarc4CsrXivWsAemiYUhFips11QStRIokfB1i2YWtvXsHUu1jK2beu
 6+6Uiw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ge35k3pb8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 11:31:31 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-90cc2b97f8fso16104956d6.0
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 04:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788348690; x=1788953490; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cSBypMk7UZ10ta6l8Hs0ZmoDf/3ZTmVqdRtsTSdvwWQ=;
 b=Z1YhUskbpLbEZpuRStcqpMsg5xDDunydPLiRG+zES67GbUFYz8wZQoizh3xxU8+Q32
 MxuTS3pi9rGmfQ0Gsm/8GlKxA75kpaZ4yoDgcZS8Xh0Xy58WRCnerKoe+83WELPS47lz
 MnF50QddrYT8DhBCTImpGdKqIG3kkWZIJQwuBnqWPGuYGwT05lG0hyq3rAjVm7q35Zzx
 239eHUgQLoU/1fz2yn/yyLcWln8DEjLds5ue+/TRzSk2yk10Z31Eel6fHGnW9AcATJiI
 8B4w6d+Ehtub85lA4sVV/ZNjUp5jS22X1WDdRDQu4b3B5VqZXaNo6fFuDMziewDxhRyO
 Vj3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788348690; x=1788953490;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cSBypMk7UZ10ta6l8Hs0ZmoDf/3ZTmVqdRtsTSdvwWQ=;
 b=MTulXY2wpEYWJ03voWqvAUa064pZKGzI42+4gOYkxP/M5Bl3W1ynN4E3ULjkFkSvCP
 LuqXRMq2IlcLlFMTn/rj7X2n8MDZCnbk4+iObR2KXKVskdsUfpO34vG0JJxlzy/8LGAx
 o+nMhfZD7uTV/aS+sTHAdTnoQQI+gNYJBrYK7Jp9vIUIEug80kFezGOQHYhyBRMsK6CV
 FviH1WuZ/35rA9GONW3NzZVeMJL4miA+HG3AaWdDXdWsqsGEvnegkusSPS/Tn+tjgjVa
 o4ddQ1fE39nc03CCC3eM7rW9SdRuaeC7avE1Lhj6I04mFxbCdSO7Utos1VGGy/sFBQDU
 zDLQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzdskS7fW+B2Y7fMeWBJXnd9OubRCybzfoTTrEAMUWNU5sQzs324oz//wfKZnbUbBOfYv4NfXOiCYig@nongnu.org
X-Gm-Message-State: AFuF++kVMqZNDWO5JPrCTZ8aX9fmjBv68Wtsi4ReLTkGmV2RrwAePhpf
 mFD3SHIYrj9zJ50CVul0y56ywPKuzksRAM0uK7RpclU5JUoWALZl1DgNPyEHlabrcbot2gnIPzq
 Wz/bQGr+TSomkWRnd+kQ47NYpKayhpkolaY39iey10V51s+m7Yap0aiXO4w==
X-Gm-Gg: AYBFou0CBOIsc33cT4+yGPseJCt7k9X7bxlbHyKTe9OmxGlAOQfdET3Og+PCG6vXwmN
 6Mb+Z4rrS59KJbvrk/ubAnNLVLdA0IA80GZDQ8/EjJeRmdyWppnIxeXOWivc/TEyWalmZRcxFrS
 Gq950SrXngdHh3Y5lNlGzo+Srv1N6s7NRQ2o1ObQC+anOBIj6AOhqA/U6Fw6VCgqTdEeLu9ucux
 /8poOUn+rT0ycTf86t6OvyRRbzEcM/jeUqnulDrNouwMY0gZt8NdWoXuLRbFptIPq6wX+OjCRH9
 UgsWF+JpTeEiNkRzdGHDUbMsHRQwkV4YN2t5IifTGoiMkb21nmFYERjfl57YXenW2/gUgQjXlV5
 PjXnRXMYnuqawtfqJo8PGrdWs+ot+Mbw6rhVM
X-Received: by 2002:a05:6214:202b:b0:90e:880e:dc2f with SMTP id
 6a1803df08f44-90e9f21f15cmr61227266d6.7.1788348690200; 
 Wed, 02 Sep 2026 04:31:30 -0700 (PDT)
X-Received: by 2002:a05:6214:202b:b0:90e:880e:dc2f with SMTP id
 6a1803df08f44-90e9f21f15cmr61226056d6.7.1788348689584; 
 Wed, 02 Sep 2026 04:31:29 -0700 (PDT)
Received: from [192.168.68.101] ([152.250.131.13])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90e9ee2ed6csm15897426d6.17.2026.09.02.04.31.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2026 04:31:28 -0700 (PDT)
Message-ID: <2d8f63f8-721f-42a4-843e-3ec79de2c2ce@oss.qualcomm.com>
Date: Wed, 2 Sep 2026 08:31:25 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: save ELP in MPELP for NMIE=0 exceptions
To: Zephyr Li <fritchleybohrer@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
References: <20260902015704.101990-1-fritchleybohrer@gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260902015704.101990-1-fritchleybohrer@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDEwMiBTYWx0ZWRfX7M0gEYARvX3E
 JOqFjyAPFmLx/FatIrb0obrL6afzgZXJCVu+6OgpVyNJ/V4T9Ihcy6amTXT4Ilekbl+VXzAGUyO
 VbUaLgodtvuzv60d68XCQ/dgPH8PIaaRS7tuNNK5kvlhWLfyWKK32S3Wosys/Q9elgatlFTO5HK
 dfn5svmXIz3tfzyy47tCvsoO6w1pFRZrsVTLwF6DCqluUHWhVoZwfHZ5piTwRFWBgcKi3biXOlU
 d/JBVoWkoPsZU8VYb6ccKJuoq7EHjZmAZuFNV5T5otLcG44QUuJL/esjR5boiKYYOw+zkZ+Mnnb
 b3D1thzrydXdz01dCIfc7n7zC0U7hwYwjVKbSeLZAFSgLNz3lzgdD+RuafH+qy/CXXe+5oAgJ2p
 ZHL2SrI0jTAiTa+DwyBGFmMPRv3hJ9BHM+coZ+8tMNlXgVAUUJ72NgP6u5IkbLFLscnOq0tQrzp
 0nZ6IW9K4075Jm2Iqtw==
X-Proofpoint-GUID: o9pYcP3ckdQDYrtGZyPN3dWJENSL-cQj
X-Proofpoint-ORIG-GUID: o9pYcP3ckdQDYrtGZyPN3dWJENSL-cQj
X-Authority-Analysis: v=2.4 cv=VLrtWdPX c=1 sm=1 tr=0 ts=6a980913 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=CXdxNCAnTuDr1kYd6DjE4g==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=p0WdMEafAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=XUmsnmsZDxSA-LP2MZ4A:9
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDEwMiBTYWx0ZWRfX5m/y59s2FcFc
 YLNqYPEOsVTpNcoRxyABUDKkMzZrcb85iIHku2R/bSE8MAtuTC1ZAVQt1dSl6cOStc1lZ/ka+cZ
 vuTzo1mZ7RRy3nmFM3oW6/6ORZDeXhk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_02,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020102
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 9/1/2026 10:57 PM, Zephyr Li wrote:
> When an exception occurs in M-mode while mnstatus.NMIE is clear,
> Smrnmi only changes the exception handler address. Trap state is still
> saved in the regular M-mode CSRs and the handler returns with MRET.

I believe it's worth adding the quote from the smrnmi spec.  It's section 8.5,
"RNMI Operation":

"If the hart encounters an exception while executing in M-mode with the
  mnstatus.NMIE bit clear, the exception is an RNMI exception. Trap state
  is still saved in the regular M-mode CSRs and the handler returns with MRET."

> 
> riscv_cpu_do_interrupt() instead saves ELP in mnstatus.MNPELP on this
> path. MRET restores ELP from mstatus.MPELP, so the expected landing-pad
> state is lost.
> 
> Always save ELP in mstatus.MPELP for M-mode exceptions. Keep MNPELP for
> the actual RNMI interrupt path, which returns with MNRET.
> 
> Add a TCG test that checks ELP preservation across an NMIE=0 M-mode
> exception and MRET.
> 
> Fixes: 0266fd8b56a4 ("target/riscv: Add Zicfilp support for Smrnmi")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4223
> Signed-off-by: Zephyr Li <fritchleybohrer@gmail.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/tcg/cpu_helper.c             |  18 +---
>   tests/tcg/riscv64/Makefile.softmmu-target |   8 ++
>   tests/tcg/riscv64/test-zicfilp-smrnmi.S   | 117 ++++++++++++++++++++++
>   3 files changed, 127 insertions(+), 16 deletions(-)
>   create mode 100644 tests/tcg/riscv64/test-zicfilp-smrnmi.S
> 
> diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
> index 07d9222652..a0d79b33a5 100644
> --- a/target/riscv/tcg/cpu_helper.c
> +++ b/target/riscv/tcg/cpu_helper.c
> @@ -2264,23 +2264,9 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>   
>           src = env->sepc;
>       } else {
> -        /*
> -         * If the hart encounters an exception while executing in M-mode
> -         * with the mnstatus.NMIE bit clear, the exception is an RNMI exception.
> -         */
> -        nnmi_excep = cpu->cfg.ext_smrnmi &&
> -                     !get_field(env->mnstatus, MNSTATUS_NMIE) &&
> -                     !async;
> -
> -        /* handle the trap in M-mode */
> -        /* save elp status */
> +        /* Save ELP for MRET. */
>           if (cpu_get_fcfien(env)) {
> -            if (nnmi_excep) {
> -                env->mnstatus = set_field(env->mnstatus, MNSTATUS_MNPELP,
> -                                          env->elp);
> -            } else {
> -                env->mstatus = set_field(env->mstatus, MSTATUS_MPELP, env->elp);
> -            }
> +            env->mstatus = set_field(env->mstatus, MSTATUS_MPELP, env->elp);
>           }
>   
>           if (riscv_has_ext(env, RVH)) {
> diff --git a/tests/tcg/riscv64/Makefile.softmmu-target b/tests/tcg/riscv64/Makefile.softmmu-target
> index 6a219c306c..8522c3fe6f 100644
> --- a/tests/tcg/riscv64/Makefile.softmmu-target
> +++ b/tests/tcg/riscv64/Makefile.softmmu-target
> @@ -45,6 +45,14 @@ comma:= ,
>   run-test-crc32: test-crc32
>   	$(call run-test, $<, $(QEMU) -cpu rv64$(comma)xlrbr=true $(QEMU_OPTS)$<)
>   
> +EXTRA_RUNS += run-test-zicfilp-smrnmi
> +run-test-zicfilp-smrnmi: test-zicfilp-smrnmi
> +	$(call run-test, $<, \
> +	  $(QEMU) \
> +	  -cpu rv64$(comma)zicsr=true$(comma)zicfilp=true$(comma)smrnmi=true \
> +	  -global rv64-riscv-cpu.rnmi-exception-vector=0x80000100 \
> +	  $(QEMU_OPTS)$<)
> +
>   # Zicclsm: misaligned load/store support. Assemble one source twice: the
>   # default build expects every misaligned access to succeed (zicclsm=true),
>   # the -DZICCLSM_DISABLED build expects every one to trap (zicclsm=false).
> diff --git a/tests/tcg/riscv64/test-zicfilp-smrnmi.S b/tests/tcg/riscv64/test-zicfilp-smrnmi.S
> new file mode 100644
> index 0000000000..b5965bf705
> --- /dev/null
> +++ b/tests/tcg/riscv64/test-zicfilp-smrnmi.S
> @@ -0,0 +1,117 @@
> +/*
> + * Test that an M-mode exception taken with mnstatus.NMIE clear saves ELP in
> + * mstatus.MPELP, so that it is restored by MRET.  MNPELP is reserved for the
> + * actual RNMI path, which returns with MNRET.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +	.option	norvc
> +
> +	.equ	CSR_MNSTATUS, 0x744
> +	.equ	CSR_MSECCFG, 0x747
> +	.equ	MNSTATUS_NMIE, 1 << 3
> +	.equ	MNSTATUS_MNPELP, 1 << 9
> +	.equ	MSECCFG_MLPE, 1 << 10
> +	.equ	MSTATUS_MPELP, 1 << 41
> +	.equ	EXCP_INST_ACCESS_FAULT, 1
> +	.equ	EXCP_SW_CHECK, 18
> +	.equ	SW_CHECK_FCFI_TVAL, 2
> +
> +	.text
> +	.global	_start
> +_start:
> +	/* Verify that NMIE is clear before exercising the exception path. */
> +	csrr	t0, CSR_MNSTATUS
> +	andi	t0, t0, MNSTATUS_NMIE
> +	bnez	t0, fail_nmie
> +
> +	/* Enable landing-pad checks in M-mode, then start a new TB. */
> +	li	t0, MSECCFG_MLPE
> +	csrs	CSR_MSECCFG, t0
> +	j	tracked_jump
> +
> +tracked_jump:
> +	/* Make a Zicfilp-tracked indirect jump to an address that faults. */
> +	li	t1, 0
> +	jalr	zero, 0(t1)
> +
> +	/*
> +	 * The instruction access fault should have redirected to the handler.
> +	 */
> +	li	a0, 1
> +	j	_exit
> +
> +fail_nmie:
> +	li	a0, 6
> +	j	_exit
> +
> +	/* Must match rnmi-exception-vector in Makefile.softmmu-target. */
> +	.org	0x100
> +rnmi_exception:
> +	csrr	t0, mcause
> +	li	t1, EXCP_INST_ACCESS_FAULT
> +	beq	t0, t1, handle_fetch_fault
> +	li	t1, EXCP_SW_CHECK
> +	beq	t0, t1, handle_sw_check
> +
> +	li	a0, 4
> +	j	_exit
> +
> +handle_fetch_fault:
> +	/* This is an M-mode exception and will return with MRET. */
> +	csrr	t0, mstatus
> +	li	t1, MSTATUS_MPELP
> +	and	t0, t0, t1
> +	beqz	t0, fail_mpelp
> +
> +	csrr	t0, CSR_MNSTATUS
> +	andi	t0, t0, MNSTATUS_MNPELP
> +	bnez	t0, fail_mnpelp
> +
> +	lla	t0, resume_non_lpad
> +	csrw	mepc, t0
> +	mret
> +
> +resume_non_lpad:
> +	/* MRET must restore ELP, so this instruction must not retire. */
> +	li	a0, 1
> +	j	_exit
> +
> +handle_sw_check:
> +	csrr	t0, mtval
> +	li	t1, SW_CHECK_FCFI_TVAL
> +	bne	t0, t1, fail_tval
> +
> +	li	a0, 0
> +	j	_exit
> +
> +fail_mpelp:
> +	li	a0, 2
> +	j	_exit
> +
> +fail_mnpelp:
> +	li	a0, 3
> +	j	_exit
> +
> +fail_tval:
> +	li	a0, 5
> +
> +_exit:
> +	lla	a1, semiargs
> +	li	t0, 0x20026	/* ADP_Stopped_ApplicationExit */
> +	sd	t0, 0(a1)
> +	sd	a0, 8(a1)
> +	li	a0, 0x20	/* TARGET_SYS_EXIT_EXTENDED */
> +
> +	/* Semihosting call sequence. */
> +	.balign	16
> +	slli	zero, zero, 0x1f
> +	ebreak
> +	srai	zero, zero, 0x7
> +	j	.
> +
> +	.data
> +	.balign	16
> +semiargs:
> +	.space	16


