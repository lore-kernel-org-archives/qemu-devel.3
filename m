Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD9ECC98321
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 16:50:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xA97i-0002l5-FB; Fri, 25 Sep 2026 12:50:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xA97b-0002k8-SN
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 12:50:03 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xA97Y-00038D-AJ
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 12:50:02 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PG1KvR796594
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 16:49:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hsmMaQgqxPNNZVQoNA0BpW7AQv2zWg0p5sPsKfrkAwo=; b=hkimgEVsoyyDzhQv
 UAY0iEkV+5+MvfVc3bBj5cYYWaU8Xhq4gUCWfakZlE+9BR8p/KIPynV7JtojTaY9
 SkwKptpKfgbHI9zWTmA8mSb7SikJULVnu0Yi00r/qkN2joBDnQ4XL2PylYh9zX0y
 5AAmAjaitsn6b3QW6hfWwjdDIWyr69GwvotrW73SgIKbiawXFi0r+7sbzpWy5wZR
 W0kbm6yhdSzfjK9VpkyJdhHr4+44Tl61PY/ZY1iO9bNGEhjWwgtbm6q3OK+3XB2K
 t/0KScqz08hmcsuFbtuj0wdTxXPX4AZqIZvWmo4NIsEEZcluUpn4GMfG0U8iBAOv
 MPvMgA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwjq3aat4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 16:49:58 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-939f248907fso112161485a.3
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 09:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790354998; x=1790959798; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hsmMaQgqxPNNZVQoNA0BpW7AQv2zWg0p5sPsKfrkAwo=;
 b=TC89N26Ldqeik6xw0RBbDk8VGNUap+YzLgC9cfV17Gw7JIkUbsUDDFqsdFqlkMWQ7n
 lWyBfhMkknsmPs2QrSv1nJRCBaC2aIeiIwNtzo+xXY5shOyPEPdfKaxO+PB8pcdvHkOp
 iN67s+AFnyX7H2lXXSeEhls20dG9wIR64tFiDue+hxQiZ63+cB34mRNzBN/PGAxwXXwQ
 ZPBtlCfdabCgIBGBXm6fzybVAwGJh28kt+C3BJ5Pr7LqGtyKRmRTu5chSf9PihgmoRPb
 FMjvLM5IFmeTttQ+ZxtuwVbdcLC3jQ2iojVGYWbMsC2sxmtlkzCW5uMiRHPvW2qKDVoH
 CymQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790354998; x=1790959798;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hsmMaQgqxPNNZVQoNA0BpW7AQv2zWg0p5sPsKfrkAwo=;
 b=fTAmF0y4oi8Wh0rtRhnHgZWHKPxJkaDMFNxhVZrTskfz3Z3WEBSlkcLwpXdnWbpMuB
 IJs/QpTI+WEe+60WWIraiJoFAxkPmRvlncUEUXCROPcAGcaNhZxGO4nYp+lunV4FZxGp
 W7o9DLnOAaFCufjKmnt784yrMCMg+SPTno3kD5/z9jC0THMYZpD2Uvv/jxc0P2LGvebR
 kBolRUNcfV5SCss0EPk1cKXRuJ3IvjfzK5wYXh/2Z38mrwlctBL433ZsaVemXqvnlJU7
 Cr7WKsZf2Ld9KIOcLGQ/SflSMjP4UEQj5Pm30OVO0xxVxVEyTRNIZlNJ4bsFDC32ntw9
 EJng==
X-Forwarded-Encrypted: i=1;
 AKwUvBxZ2J+LaeBKjnhH2JV/hEHnv28T1vbCEO4+w9ViKrxBkYnpaL4xSakec/B0k7ctYya1pjZ4nRpUKeWg@nongnu.org
X-Gm-Message-State: AFuF++mGuQZ6V+NrBDQt+RPih0OZmNc4iUG0nFjA3epWGVDIkj2RWRME
 BrxO2VwvBk0ICRXU/ALP18+/hGU6K6ufuZ2E+TO+B6GxgsAnD1AaSiT85fqdow2r6Jv4FJc8m9S
 4B8fYx6I2KFdz7zZ5MFwCFlQmPw8gFTrdxpFLN6gIxB4WDuSZG9BareV4Fw==
X-Gm-Gg: AYBFou3QuPijv4IMMvct4MtyCgv+BFM7JvaYWtHE3miMabYB0PXzcCjfSWrU8mKzX/6
 8QhD0Fxe3Brh552ncvVaTUqNeEUZFHqi6keRI+uFpbMwn2aphFV0qfkOTqPq9Gggz/PMqqqAahT
 I2zwMYVnQHF6jOpN7BvPX9z24ftMigTq/97Vuj8/TgVP3GQfY5nTPrYPtlOTiMOhOXyrCFMP6xt
 q0q2u4798CVBPV7dzcgEK5b0fszqSXekID02z6uwui5sBzxq1gfONW7K2qg2PT/9B/w/ZPpLDIE
 wxDjTsFPcmDr0perzWB9x01B3wPq3UkN7KYveSVoF9uZ95/wJadGpNMDNybs5S5wN9kA7cAC72o
 aNBXCFzV/fzW4/H4k81acJ/fEaV+9OPUKnQ==
X-Received: by 2002:a05:620a:4450:b0:93a:1fa7:1afb with SMTP id
 af79cd13be357-93c43cb6a76mr584405385a.42.1790354998197; 
 Fri, 25 Sep 2026 09:49:58 -0700 (PDT)
X-Received: by 2002:a05:620a:4450:b0:93a:1fa7:1afb with SMTP id
 af79cd13be357-93c43cb6a76mr584400085a.42.1790354997614; 
 Fri, 25 Sep 2026 09:49:57 -0700 (PDT)
Received: from [192.168.68.102] ([177.94.15.187])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93c44652f98sm224487785a.6.2026.09.25.09.49.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2026 09:49:57 -0700 (PDT)
Message-ID: <4c58ea2b-bccf-48a4-95a6-87f38050eb9d@oss.qualcomm.com>
Date: Fri, 25 Sep 2026 13:49:52 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: mask vsepc according to IALIGN
To: Zephyr Li <fritchleybohrer@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com
References: <20260915024945.32329-1-fritchleybohrer@gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260915024945.32329-1-fritchleybohrer@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA2NyBTYWx0ZWRfX8coyyQsLp2t7
 c9EaP3UH1l+X4OCnBrng8GshfAczttfMiPMiMG9DMkojc5y0qE/eEl496ALCuvSLz028Y7seY0C
 /QGzrEDdnNiFmDZYnSRWIxrM9H9j9Ro=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA2NyBTYWx0ZWRfX6Jcvx+4HYjLy
 0Ml0EoJu+j7cyP6vg0bbY4mibLHzypVPhCCOlt2tnC+RMT0AvfNvQMYil8VI2Ihko427PpjA0bd
 /ggOb48d9xtmPs6LjgpRTwcKTR2fZPEH/TNc5TvEMhyAZBYQBY5vd7tA2R0alqND6WU1QvIy90t
 0AsHU27SP4bvhJWKQ6RF8qWLWOn0AiK7KPCPY4r8fSXmNaUZMNQU+c2HKigTFbsQDo1GSLBPA0e
 pgx/yc8k78TPHkwFeDQRkBaoUPvd2G+s9vqwsKwiHU70mJAsMvJ1hioyNjzUnBbwrI4SF8eh/rf
 q+mmKv3f1124aW6JR6byHJGaC3sd3FOyJPt3R5nFDK6zTfH0KOzpfNkIZm1sieJ+iCwLk0cHE5h
 IIFJi8ekh+s3s5AYFIg//SlwEpdjGeukGOd7p5elqyYw795FXFeurVlJrA8vKWQjFkeeBPW1myu
 FgXegzpv82qjh9qO9mA==
X-Authority-Analysis: v=2.4 cv=VuO2kO2n c=1 sm=1 tr=0 ts=6ab6a636 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=0kFmPUMe/4ewoYCJjrGTNA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=p0WdMEafAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=WWe3HN8v-xbs8q0Pu_QA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: 4A3DLg256tja4wysVYP6RiNll-fYx7FL
X-Proofpoint-ORIG-GUID: 4A3DLg256tja4wysVYP6RiNll-fYx7FL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250067
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



On 9/14/2026 11:49 PM, Zephyr Li wrote:
> vsepc is the VS-mode counterpart of sepc and is a WARL register, but
> unlike mepc and sepc its accessors do not mask the low address bits
> according to IALIGN.  As a result, values with invalid low bits can be
> observed through vsepc.
> 
> Apply get_xepc_mask() to both vsepc reads and writes, matching the
> existing mepc/sepc handling.
> 
> Add a TCG regression test covering both IALIGN=16 and IALIGN=32.
> 
> Fixes: 8747c9eeb2aa ("target/riscv: Add Hypervisor virtual CSRs accesses")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4420
> Signed-off-by: Zephyr Li <fritchleybohrer@gmail.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/tcg/csr.c                 |  4 +-
>   tests/tcg/riscv64/system/meson.build   | 11 ++++++
>   tests/tcg/riscv64/test-vsepc-masking.S | 54 ++++++++++++++++++++++++++
>   3 files changed, 67 insertions(+), 2 deletions(-)
>   create mode 100644 tests/tcg/riscv64/test-vsepc-masking.S
> 
> diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
> index bd4b6dc114..274c5cfbf4 100644
> --- a/target/riscv/tcg/csr.c
> +++ b/target/riscv/tcg/csr.c
> @@ -5299,14 +5299,14 @@ static RISCVException write_vsscratch(CPURISCVState *env, int csrno,
>   static RISCVException read_vsepc(CPURISCVState *env, int csrno,
>                                    target_ulong *val)
>   {
> -    *val = env->vsepc;
> +    *val = env->vsepc & get_xepc_mask(env);
>       return RISCV_EXCP_NONE;
>   }
>   
>   static RISCVException write_vsepc(CPURISCVState *env, int csrno,
>                                     target_ulong val, uintptr_t ra)
>   {
> -    env->vsepc = val;
> +    env->vsepc = val & get_xepc_mask(env);
>       return RISCV_EXCP_NONE;
>   }
>   
> diff --git a/tests/tcg/riscv64/system/meson.build b/tests/tcg/riscv64/system/meson.build
> index 8604c2a45a..5d633a266a 100644
> --- a/tests/tcg/riscv64/system/meson.build
> +++ b/tests/tcg/riscv64/system/meson.build
> @@ -24,6 +24,17 @@ tests += {
>     'test-crc32.S': setup + {'qemu_args': ['-cpu', 'rv64,xlrbr=true', qemu_args]},
>     'test-minstret-ecall.S': setup + {'qemu_args': ['-icount', 'shift=1', qemu_args]},
>     'test-misa-w.S': setup + {'qemu_args': ['-cpu', 'rv64,x-misa-w=true,c=true,v=true', qemu_args]},
> +  'test-vsepc-masking.S': setup + {
> +    'test_name': 'test-vsepc-masking-c',
> +    'qemu_args': ['-cpu', 'rv64,h=true,c=true', qemu_args],
> +  },
> +}
> +
> +tests += {
> +  'test-vsepc-masking.S': {
> +    'test_name': 'test-vsepc-masking-no-c',
> +    'qemu_args': ['-cpu', 'rv64,h=true,c=false,zca=false', qemu_args],
> +  },
>   }
>   
>   tests += {
> diff --git a/tests/tcg/riscv64/test-vsepc-masking.S b/tests/tcg/riscv64/test-vsepc-masking.S
> new file mode 100644
> index 0000000000..e5460f8aee
> --- /dev/null
> +++ b/tests/tcg/riscv64/test-vsepc-masking.S
> @@ -0,0 +1,54 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +#define MISA_C          (1 << 2)
> +
> +	.option	norvc
> +	.text
> +	.global	_start
> +_start:
> +	csrr	s0, misa
> +	andi	s0, s0, MISA_C
> +
> +	lla	s1, test_addr
> +	ori	t0, s1, 3
> +	csrw	vsepc, t0
> +	csrr	t1, vsepc
> +
> +	beqz	s0, ialign32
> +	addi	t2, s1, 2	/* IALIGN=16: bit 0 reads as zero. */
> +	j	check
> +
> +ialign32:
> +	/* IALIGN=32: bits [1:0] read as zero. */
> +	mv	t2, s1
> +
> +check:
> +	li	a0, 2
> +	bne	t1, t2, _exit
> +
> +	li	a0, 0
> +	j	_exit
> +
> +	.balign	4
> +test_addr:
> +	nop
> +
> +/* Exit code in a0. */
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


