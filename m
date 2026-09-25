Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D06BEC98321
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 16:31:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xA8pm-00062P-9S; Fri, 25 Sep 2026 12:31:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xA8pZ-00060m-9x
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 12:31:26 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xA8pW-0001gT-8m
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 12:31:24 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PG5LKT1759224
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 16:31:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wBI3IGXFWyol4HJyolejM/zmrxcgSQd6w1OEhCOKrwo=; b=W9l9d6eX4Rrcwjuh
 /uVgfvBKJpFBQ+TooqURm67XwXIhkUXMfDW76zvlCiEJfKguINSQHok3Wytll1gB
 38tZRU+LrQDbBLNhtiSaXO9CyzhWLaXWIsWdqK8M+bFimh/6WYcijIBKbXJ8Mypc
 FkUBCpSL26YnJpO7iLkqCtTJLumuYtjy5WCM4XevETW83Lk+6ddYm91nx7ofi8tk
 IGHDWrvkS/Un6Y63M13IAk44zU4qqR45x86/VhoosQUazeUmnbo0YTURFq4ykIJB
 tsyU553laCvdGVDvCA6ZCWBf7xSwpmzp6v+vyFIp1HaSIqD0+vCsMiUS5JOC6GZ1
 XJ8BEQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwv5yr3d5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 16:31:20 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-934963b2bc0so248328285a.3
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 09:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790353880; x=1790958680; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wBI3IGXFWyol4HJyolejM/zmrxcgSQd6w1OEhCOKrwo=;
 b=E9QPJOKgB24T/qU0FIK7Vo8TohRDchASjHZZ4IGXsSEtdMGPpLhHvQ+ODbDXPcu6KW
 +uwqdJ1jevEUrkhb6DwKvIQ/sez69rUZm9qFE8VYbfpfc8ewofDFIr5Mc33jn5EYrT3h
 2n/LQLONpENjyoI26C1Brle36nmNO/rrsW3Wlo1hjm9kEptPY+oemkjXZvhtUAK6pp0R
 EkKhk0VwP5VPQi89rHJQJWpAvZj3EvIieHkDiOWDvuBxnouIDeoQ8rWoCOptsr7G/9TM
 l2l/N0ZoT2MKzi199WYOeESc/yeDqtqijuVQnRaPGsGbv+jc3Cw6I8tHXqj5AiA6PoV1
 pxEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790353880; x=1790958680;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wBI3IGXFWyol4HJyolejM/zmrxcgSQd6w1OEhCOKrwo=;
 b=ZW0Bme52eqPotbFNOWZRO6jvl5NdvlmpX3pWMl+L2HnWTibWQ0ETG7uf3hpMHTB0jK
 ZqRM1x5UYgtGYDRhTUjIuf8gg/31P5E7uVPqrWSP3fhijgiwDSJADbRX8zgCUxRbxBPQ
 O6a/fm/bw6kj4zEUaRFdAkKfE6SnyJfN+tTUS1wS8YKDT0WzpB63SHRC/yFdsxNe3BUy
 QzQrvOPTJacE3hIPlQpDATJsGfvaAKw9r2dY7PKFGgJ9BEQvbTzAYiVgHQ2IaSgCcX9f
 WVPJCeyXdLsgyacxeDWUFHAGqD62QQE0N4jKZhD0BVOO8mLo8bcD+gX7Agc1QsaE8rDW
 EITA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz1REslsiLzjDhflo0c8UehPAk9h23z8BYNeoX09R0dJUbIBkOZQynYid8jLVIANwYKOqd/R3G81kIw@nongnu.org
X-Gm-Message-State: AFuF++m63WvJQpmeIoWbjZPyYt9sg2A0D2xgCb0ucgfCntnc4BxOFEr2
 M7EoHoHh8FZX63uW12VUsfYU+XDy5tc/L6R+u4Z2BkanSnQPi6/AEfUcTUIOjHuxhppnTi5N2Xs
 FIBv5Ie7RuhBBjxYhiZMm/6F1Xbo4VT2jmvx1seJvPRWID2Ae/uqCMWK1/w==
X-Gm-Gg: AYBFou30cHjZGTAmLZtpD/kckdHLPy7pEkzUVfqgrcX2U+pQOZpYy9K0NfskZsTgVhM
 Xw1SJBnOxUaLjvYtbk5iLKRXKp9QrjWx+oVuPAYwhiPNuYGLRD8YwVJgu/eR8BkkCY00xzoqeFt
 O5wGDbTpmxsfsE2uUeUpmTSkWZAGldmcf8bcOTLMjEUkoiYBBtIGXUkMmcdzINbVMPZc6RvUjVO
 n23zqiZ36oCHl3+g2tq8FZQjqw5sMfVaKGBricBCM0XVwSrig5j9LZ88knysRn6nlz/nIa043YT
 w3gIPU1DbXs9uk4C451Cg8fnw+JFiQuhV7hTjBul0nHP0yp/Xligd7AryxW4EwXRqep2Ed3MxhC
 wBuKflnNt4A/wVBY6LbMw3FIVlucBhvJZkw==
X-Received: by 2002:a05:620a:4050:b0:93b:ec83:80ee with SMTP id
 af79cd13be357-93c43e0ee3bmr558344685a.57.1790353879580; 
 Fri, 25 Sep 2026 09:31:19 -0700 (PDT)
X-Received: by 2002:a05:620a:4050:b0:93b:ec83:80ee with SMTP id
 af79cd13be357-93c43e0ee3bmr558338685a.57.1790353879009; 
 Fri, 25 Sep 2026 09:31:19 -0700 (PDT)
Received: from [192.168.68.102] ([177.94.15.187])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93c4497ca93sm219118585a.44.2026.09.25.09.31.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2026 09:31:18 -0700 (PDT)
Message-ID: <cb85596b-485b-4380-9f67-2a8348a57eb5@oss.qualcomm.com>
Date: Fri, 25 Sep 2026 13:31:15 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/14] target/riscv: Apply minstret exception
 accounting to HPM counters
To: TANG Tiancheng <lyndra@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: Zephyr Li <fritchleybohrer@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20260910-riscv-pmu-correctness-v2-0-5da5159a0c64@linux.alibaba.com>
 <20260910-riscv-pmu-correctness-v2-10-5da5159a0c64@linux.alibaba.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260910-riscv-pmu-correctness-v2-10-5da5159a0c64@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA2NSBTYWx0ZWRfXyW+s3cGPzXnH
 OX7wz+Tj34KM6zMuwctPPIhvG00aCCkzVePi3qUekK8LXOX5GgaxGajGfcu8VHUuq+XoiAPMbfc
 eWHBr3+zRrr5T30QzCbNfUqgz3422zAKayD5VO8mT3evFqSmujo9Ssvm49QqCXsUT7N0s7eaxMX
 snDpQNe+k8LRjBUPb1nxMTZIkxcbNugYd7l4+l6MfU+8tkRu9uRJ9R79k9NjjawV1UEeec2hIZB
 ajVwLVbIsBG8uM/to4+VKSPIDNb2OO+UmYuadptgvuo7UhD8tRCNynZ5roptPWuNlxZaydIEWeg
 K35b/UC+2Im6gwRgL/YjDzTu/fn4edy/b/apSZEvAx9hwrXknQL3d17G/znUwsgatiWgGlQ/r4y
 G0PfYQRu/xq2NTONGX9BZQ6DdbpiROS3G8BSjUqlz/2Y8mRkNdiMSFL050OBKpLOox1k9H2Gw+5
 BBPEb+TBs4/nXL6BW3w==
X-Proofpoint-ORIG-GUID: 7zfiLeGoUdPw4B-eSy76RKQWkaIk2V7-
X-Authority-Analysis: v=2.4 cv=EoRHPicA c=1 sm=1 tr=0 ts=6ab6a1d8 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=0kFmPUMe/4ewoYCJjrGTNA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=SRrdq9N9AAAA:8 a=EUspDBNiAAAA:8 a=HLlE97lRRq6cRs4FlAoA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA2NSBTYWx0ZWRfX+iYOyVwuNi0I
 h9LREG6lgDd4K5diCZsvNhIVAElq0FoIgkQ09vLazAUNcB2CWtbItg2fuIP+dwzqWdDVhrlu6TR
 9AmsXxMnz7ulUWu9O9XoOnCWd4VJXj8=
X-Proofpoint-GUID: 7zfiLeGoUdPw4B-eSy76RKQWkaIk2V7-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 impostorscore=0
 adultscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250065
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



On 9/10/2026 11:39 AM, TANG Tiancheng wrote:
> With icount, helper_raise_exception() excludes faulting instructions from
> minstret but not HPM counters selecting HW_INSTRUCTIONS.
> 
> Adjust the baseline of every running instruction counter that counts the
> current privilege mode. Do not read icount here: the helper can run inside
> a TB. Keep the existing timer, since excluding an instruction can only
> postpone overflow and expiry checks for an actual wrap.
> 
> Extend the ECALL regression to compare both counters and add an LPAD
> fault test covering an exception inside a multi-instruction TB.
> 
> Fixes: 14664483457b ("target/riscv: Add sscofpmf extension support")
> Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/tcg/pmu.c                  | 35 ++++++++++++----
>   tests/tcg/riscv64/pmu-lpad.S            | 72 +++++++++++++++++++++++++++++++++
>   tests/tcg/riscv64/system/meson.build    |  7 ++++
>   tests/tcg/riscv64/test-minstret-ecall.S | 26 ++++++++++++
>   4 files changed, 133 insertions(+), 7 deletions(-)
> 
> diff --git a/target/riscv/tcg/pmu.c b/target/riscv/tcg/pmu.c
> index f88f6ae671d877ed874d22c9d4b840edb6f433a5..08298010b6d06f5792fa14ff81fe2f7a28c6476f 100644
> --- a/target/riscv/tcg/pmu.c
> +++ b/target/riscv/tcg/pmu.c
> @@ -387,18 +387,39 @@ void riscv_pmu_write_inhibit(CPURISCVState *env, uint32_t value)
>   
>   void riscv_pmu_decr_instret(CPURISCVState *env)
>   {
> -    if (!icount_enabled() ||
> -        (env->mcountinhibit & COUNTEREN_IR) ||
> -        riscv_pmu_counter_filtered(env, env->minstretcfg)) {
> +    RISCVCPU *cpu = env_archcpu(env);
> +    uint32_t ctr_mask;
> +
> +    if (!icount_enabled()) {
>           return;
>       }
>   
>       /*
> -     * minstret is derived from icount, which includes the current
> -     * instruction.  Move the baseline forward to exclude an instruction
> -     * that raises an exception and therefore does not retire.
> +     * Fixed instruction events are derived from icount, which includes the
> +     * current instruction.  Move the baseline of each running
> +     * instruction-source counter that counts the current privilege mode to
> +     * exclude an instruction that raises an exception and does not retire.
> +     *
> +     * Do not read icount here: this helper can run in the middle of a TB.
> +     * Excluding an instruction only postpones overflow, so keep the current
> +     * timer deadline. The expiry handler checks for an actual counter wrap.
>        */
> -    env->pmu_ctrs[2].mhpmcounter_prev++;
> +    ctr_mask = COUNTEREN_IR |
> +               riscv_pmu_event_counter_mask(
> +                   cpu, RISCV_PMU_EVENT_HW_INSTRUCTIONS);
> +    while (ctr_mask) {
> +        uint32_t ctr_idx = ctz32(ctr_mask);
> +        uint64_t cfg = ctr_idx == 2 ? env->minstretcfg :
> +                                      env->mhpmevent_val[ctr_idx];
> +
> +        ctr_mask &= ~BIT(ctr_idx);
> +        if (!riscv_pmu_fixed_ctr_running(env, ctr_idx) ||
> +            riscv_pmu_counter_filtered(env, cfg)) {
> +            continue;
> +        }
> +
> +        env->pmu_ctrs[ctr_idx].mhpmcounter_prev++;
> +    }
>   }
>   
>   int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum riscv_pmu_event_idx event_idx)
> diff --git a/tests/tcg/riscv64/pmu-lpad.S b/tests/tcg/riscv64/pmu-lpad.S
> new file mode 100644
> index 0000000000000000000000000000000000000000..40a6b34b7c2b71dd42e78b6873d72df4d508289d
> --- /dev/null
> +++ b/tests/tcg/riscv64/pmu-lpad.S
> @@ -0,0 +1,72 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +/* CSR number for older assemblers. */
> +#define CSR_MSECCFG          0x747
> +
> +/* An LPAD fault must be deliverable with HPM instruction counting enabled. */
> +
> +	.option	norvc
> +	.option	norelax
> +
> +	.text
> +	.global	_start
> +_start:
> +	lla	t0, trap
> +	csrw	mtvec, t0
> +	li	t0, 2		/* HW_INSTRUCTIONS */
> +	csrw	mhpmevent3, t0
> +	li	t0, 1 << 10	/* mseccfg.MLPE */
> +	csrs	CSR_MSECCFG, t0
> +
> +	/* x7[31:12] = 0 does not match the nonzero LPAD label. */
> +	li	t2, 0
> +	lla	a0, target
> +	jalr	ra, a0, 0
> +	j	fail
> +
> +	.balign	4
> +target:
> +	.word	0x00001017	/* lpad 1 */
> +	/*
> +	 * Keep the LPAD check inside a multi-instruction TB. Its exception
> +	 * helper must not read icount before leaving generated code.
> +	 */
> +	.rept	16
> +	nop
> +	.endr
> +	j	fail
> +
> +trap:
> +	csrr	t0, mcause
> +	li	t1, 18		/* Software-check exception */
> +	bne	t0, t1, fail
> +	csrr	t0, mtval
> +	li	t1, 2		/* Landing-pad fault */
> +	bne	t0, t1, fail
> +	csrr	t0, mepc
> +	lla	t1, target
> +	bne	t0, t1, fail
> +	li	a0, 0
> +	j	exit
> +
> +fail:
> +	li	a0, 1
> +
> +exit:
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
> diff --git a/tests/tcg/riscv64/system/meson.build b/tests/tcg/riscv64/system/meson.build
> index 13ee7954ef4f09559a02a3730fb017ccf2cfd882..d2355090121ba7a7d0046c1fc1824d6a89c1267f 100644
> --- a/tests/tcg/riscv64/system/meson.build
> +++ b/tests/tcg/riscv64/system/meson.build
> @@ -61,6 +61,13 @@ tests += {
>     }
>   }
>   
> +tests += {
> +  'pmu-lpad.S': {
> +    'cflags': cflags,
> +    'qemu_args': ['-cpu', 'max', '-icount', 'shift=0', qemu_args],
> +  },
> +}
> +
>   # Exercise RV32 CSRs with the RV64 emulator's 64-bit target_ulong.
>   tests += {
>     '../riscv32/smcdeleg-rv32.S': {
> diff --git a/tests/tcg/riscv64/test-minstret-ecall.S b/tests/tcg/riscv64/test-minstret-ecall.S
> index ab268f7f22985820f19bde353215385608643f3a..b1857543d488df984b923ad1c135edb35cb948c7 100644
> --- a/tests/tcg/riscv64/test-minstret-ecall.S
> +++ b/tests/tcg/riscv64/test-minstret-ecall.S
> @@ -18,11 +18,37 @@ _start:
>   	li	t1, 1
>   	bne	t0, t1, fail
>   
> +	/*
> +	 * minstret and a counter selecting HW_INSTRUCTIONS must both exclude
> +	 * ECALL, so they must contain the same number of retired instructions.
> +	 */
> +	li	t0, 12		/* mcountinhibit.IR | mcountinhibit.HPM3 */
> +	csrs	mcountinhibit, t0
> +	csrw	minstret, zero
> +	csrw	mhpmcounter3, zero
> +	li	t0, 2		/* RISCV_PMU_EVENT_HW_INSTRUCTIONS */
> +	csrw	mhpmevent3, t0
> +	lla	t0, trap_hpm
> +	csrw	mtvec, t0
> +	li	t0, 12
> +	csrc	mcountinhibit, t0
> +	ecall
> +	bne	s3, s4, fail
> +
>   	li	a0, 0
>   	j	_exit
>   
>   trap:
>   	csrr	s1, minstret
> +	j	trap_check
> +
> +trap_hpm:
> +	li	t0, 12
> +	csrs	mcountinhibit, t0
> +	csrr	s3, minstret
> +	csrr	s4, mhpmcounter3
> +
> +trap_check:
>   	csrr	t0, mcause
>   	li	t1, 11		/* Environment call from M-mode */
>   	bne	t0, t1, fail
> 


