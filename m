Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86C47C9830E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 16:12:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xA8XG-0003lr-GO; Fri, 25 Sep 2026 12:12:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xA8TC-0000g2-Fe
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 12:08:20 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xA8T7-0007ie-QF
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 12:08:17 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PG0iT62515800
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 16:08:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mxB611+hWxACu6YmxPADCJtRZ0wFU7KHtrRoV4JAiV4=; b=h6Pn0XGyUnEerwj4
 0gFVt59oda3ZTK9GGqZlUzTWtCHuBKWwP5h+heAW+GeC2aoRjoxEXKQVkXV/pb+S
 OoGV7zhPGKo1OJWmg34hIqHrIX/qmPw4Xy6sIsWPZQZCOnzszLhwSFW1UxQeiJZc
 VNrKFkq6RtQQi4/2KxON3tuj0TZUXKP/5/M47ZobW1o0gX6+HIHAnTk4eG51L9pH
 CMnm0MYXCCIdIoTrXBbhh015b87PeT2itGk+DCjOD2ZrkqkmX6o9XcZExseqUP/N
 NMvt/oFfKzV4myV8GQMIioem30YNzP1FbnMEMq3LBvcju1JnrZytYGLgkqec8drr
 NFVFEg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwce7b7pk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 16:08:11 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-91430af782dso20134176d6.2
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 09:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790352491; x=1790957291; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=mxB611+hWxACu6YmxPADCJtRZ0wFU7KHtrRoV4JAiV4=;
 b=WK2+9xn1qyO0geDYtPpOyz9KMwvSuFKMAwx9H64iWJUoTBlDNubsPqyHfM5i0HpCbl
 NSccwuS0cPKACTBFuSepRGJgiPyfqaCXGh/yQM1jHbEp692ynJA89rk35Hphgzfk0bJi
 UL4jDZ/WYInT21bvit9IE351ERaRcfvy/Qst9hrujrgi3+qEBqc4ZQWr+X+WCHiVAhz/
 pUb6y9EATyY/bLtcjoCbFp9fCnmkSTDunGguaimByqjtivEXRGmABrA4mq2JULZ5W3/1
 k7ww6RGzTL4GpxbfOoDwSJyS+ScvBiIGt0CMCr1zm5jKsyTopo6TR0pEMm1+M+NBsWPF
 aj4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790352491; x=1790957291;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mxB611+hWxACu6YmxPADCJtRZ0wFU7KHtrRoV4JAiV4=;
 b=jUXWK+T8+c+9azx/dbHLfkcICYs2O1RqWiQ9s9r4g2DyIx06P86MlIjWEAp6RHAJ8V
 OTT5JoVwrC70VUokIc0DawI4QDDltCcdXlkCKIDHH0K2u6vlgMDTWK4ACQuPeJzwStxG
 aHggpoABAxzY+rQe8P47UXuyZUQAh1P0n+zRH9aPFCtuH0PsZxlBfn4r12lRF76vjDYT
 ajwPeCFXv4XG0AR5YRlwOuid445w7V9MCy1p8ppU1roGXWmdAv0AShpLiHPa7gphCcr4
 H5yx3kk5P0mVw5N9q5BrneMTJLdJSHLtQsJng8AwtnBjpgatjOa+yX3lebxtsYooQBc6
 Zg2A==
X-Forwarded-Encrypted: i=1;
 AKwUvByDYfwib5T6xvZx+jsE3B66cMOucmSN91dAEtbeeFxBuXG03n3BkbJM6zgGrsDwuuutlTytpukFsKlf@nongnu.org
X-Gm-Message-State: AFuF++lDbOI6H+THNPD5MMgA2KGMAY3/RtljHUUP2dkJszStuowkYtmq
 lw/g0vGtM8P6a4e1G6+U6sZTarOV5jmP5ra0f1Xg+Kol+kU1tBQq8Y3lPOEGvNrQTK2uFrJ8Ajw
 AtBa0qK2kpqB0BNK6UvN/6bwtNCaQUwssIzmIuvHOh8ls9W787FtZwUEfVg==
X-Gm-Gg: AYBFou3RHE8aQvdkyr4MN+EuJ6wpIzHQUZIGbWOnyUTpn696QxIQpDN6R9H56odroiT
 5fBdrvYXVT8oI223tjh44GU7Mx2gIcGFE4lMd1X02dRTtzjprnGFK2iriFlSeyKDFiowMihFsSH
 kPjIQwNrDpEEPxNIBF/DwzQiXs7f3GHcjLD84zlF0dYOM2RA+sLhTKi3OorNIJEWI/LY3qLhDX2
 rzjVsYIl6ZsEYJLlPzjPp6PwE3cycNtPD5jNFTEXaPsb22ZVSUIzIyxIDM287Pv8wc6VvnE39u7
 z4k7wJxkZXfDBrz3QcxEFAWXykpesP7/v3EFrdgPZcLa4gCJWFi3dLRjgL2T/uVcT40z9i+d936
 kmX0b+YN+EvXGzLCHuXtvmrrne24QYIeJvw==
X-Received: by 2002:a05:6214:1cc5:b0:8ef:e0d0:9fae with SMTP id
 6a1803df08f44-9142f68c10bmr51355646d6.14.1790352490640; 
 Fri, 25 Sep 2026 09:08:10 -0700 (PDT)
X-Received: by 2002:a05:6214:1cc5:b0:8ef:e0d0:9fae with SMTP id
 6a1803df08f44-9142f68c10bmr51354756d6.14.1790352489995; 
 Fri, 25 Sep 2026 09:08:09 -0700 (PDT)
Received: from [192.168.68.102] ([177.94.15.187])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91430dd2858sm20134756d6.21.2026.09.25.09.08.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2026 09:08:09 -0700 (PDT)
Message-ID: <9055f131-2091-4c6c-83b9-64980be56911@oss.qualcomm.com>
Date: Fri, 25 Sep 2026 13:08:05 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/14] target/riscv: Require Sscofpmf for non-fixed
 event overflow
To: TANG Tiancheng <lyndra@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: Zephyr Li <fritchleybohrer@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20260910-riscv-pmu-correctness-v2-0-5da5159a0c64@linux.alibaba.com>
 <20260910-riscv-pmu-correctness-v2-8-5da5159a0c64@linux.alibaba.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260910-riscv-pmu-correctness-v2-8-5da5159a0c64@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ApXBQmYJtfeQMhIoXDIN1JJ-kxE1ygIm
X-Proofpoint-ORIG-GUID: ApXBQmYJtfeQMhIoXDIN1JJ-kxE1ygIm
X-Authority-Analysis: v=2.4 cv=NJFAaE6g c=1 sm=1 tr=0 ts=6ab69c6b cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=0kFmPUMe/4ewoYCJjrGTNA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=SRrdq9N9AAAA:8 a=EUspDBNiAAAA:8 a=XtTp2mjT3OapW3OsOAEA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA2NCBTYWx0ZWRfX98CWByG95h0M
 c0ZHP16YUkCaImb4whFU4drXBQggjfKE8AIchkvCQkspzkOLeWAicXFatlTroW4dKxcvu2Wj/+K
 1HhDn2S0ev1E0phr8jxEf+gUf1LJAG/9Y6Kp++sGTz2oHxbs3EvqDd2mqp3MC5rAX4UAe4IAO6I
 O6CNGo1d0Tvth2d+kj0gMUO3uD9LjUrmK7RauBIMs05h1C6FdHgBzpLOTmb8UBMgpOy8z7bFR1F
 EPUuXD5CgAWWY+4PTyuRaagHbzNFkCy4Q7n8aNJymZUiqV/IeGSDg4SaFZourWS81ssAKy7C02S
 Y7GydncIH9/hHVv0BaHFT9bWevgbIWO7f/tjTjzST8ipTNY4RNPDO9MAVcF7thAZq6hOi69TNJ1
 hNTAPOq2+46obEHKAyO9E6nMOcA7+11wpOBKvGEioq4RTK5mRd46P11rzDwxrovz3QRgGh7sjtH
 9GheNgWuNHi13Upl1+w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA2NCBTYWx0ZWRfX7UDiaO1d3nrg
 lKR4BHLA7LHr4NpxjvxLvXZz36EgtAy251oMIoA8Q/CPPbXdg+EpXK8i5Zc/Fh4Zt9QnXQeRNqf
 d0d4z7nO+rZSNzlhjrgRvGo/Do+PmPk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 spamscore=0
 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250064
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



On 9/10/2026 11:39 AM, TANG Tiancheng wrote:
> riscv_pmu_incr_ctr() sets OF and LCOFIP on wrap even when Sscofpmf is
> disabled. Use the shared overflow helper to require Sscofpmf and suppress
> notifications while OF is set without stopping the counter.
> 
> Test DTLB overflow with Sscofpmf enabled and disabled, including
> notification suppression and continued counting.
> 
> Fixes: 14664483457b ("target/riscv: Add sscofpmf extension support")
> Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/tcg/pmu.c                      |   6 +-
>   tests/tcg/riscv64/sscofpmf-event-overflow.S | 103 ++++++++++++++++++++++++++++
>   tests/tcg/riscv64/system/meson.build        |  15 ++++
>   3 files changed, 119 insertions(+), 5 deletions(-)
> 
> diff --git a/target/riscv/tcg/pmu.c b/target/riscv/tcg/pmu.c
> index 16942e53489cd5a2d2dd055fdffef07d04d59465..2f600c5a0fc2d7ba380ef34f89af6366e3e27884 100644
> --- a/target/riscv/tcg/pmu.c
> +++ b/target/riscv/tcg/pmu.c
> @@ -448,11 +448,7 @@ int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum riscv_pmu_event_idx event_idx)
>           counter = &env->pmu_ctrs[ctr_idx];
>           if (counter->mhpmcounter_val == max_val) {
>               counter->mhpmcounter_val = 0;
> -            /* Generate interrupt only if OF bit is clear */
> -            if (!(env->mhpmevent_val[ctr_idx] & MHPMEVENT_BIT_OF)) {
> -                env->mhpmevent_val[ctr_idx] |= MHPMEVENT_BIT_OF;
> -                riscv_cpu_update_mip(env, MIP_LCOFIP, BOOL_TO_MASK(1));
> -            }
> +            riscv_pmu_set_overflow(env, ctr_idx);
>           } else {
>               counter->mhpmcounter_val++;
>           }
> diff --git a/tests/tcg/riscv64/sscofpmf-event-overflow.S b/tests/tcg/riscv64/sscofpmf-event-overflow.S
> new file mode 100644
> index 0000000000000000000000000000000000000000..cce06da10f9c7c20c18c7863b58b6dd724c45182
> --- /dev/null
> +++ b/tests/tcg/riscv64/sscofpmf-event-overflow.S
> @@ -0,0 +1,103 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +/* Non-fixed event overflow with and without Sscofpmf. */
> +
> +#ifndef EXPECT_SSCOFPMF
> +#define EXPECT_SSCOFPMF 1
> +#endif
> +
> +	.option	norvc
> +	.option	norelax
> +
> +	.text
> +	.global _start
> +_start:
> +	/* Unexpected exceptions report the current check number. */
> +	li	t4, 1
> +	lla	t0, exit
> +	csrw	mtvec, t0
> +	csrw	mie, zero
> +	csrw	mip, zero
> +	csrw	mcountinhibit, zero
> +	csrw	mhpmevent3, zero
> +	li	t0, -1
> +	csrw	mhpmcounter3, t0
> +	li	t0, 0x10019		/* DTLB read miss */
> +	csrw	mhpmevent3, t0
> +
> +	/* One load after flushing the TLB must wrap the counter to zero. */
> +	sfence.vma
> +	lla	t0, first_page
> +	lw	t1, 0(t0)
> +	csrr	t0, mhpmcounter3
> +	bnez	t0, exit
> +
> +	/* Only Sscofpmf turns that wrap into OF and LCOFIP. */
> +	li	t4, 2
> +	csrr	t0, mhpmevent3
> +	srli	t0, t0, 63
> +	li	t1, EXPECT_SSCOFPMF
> +	bne	t0, t1, exit
> +	li	t4, 3
> +	csrr	t0, mip
> +	srli	t0, t0, 13
> +	andi	t0, t0, 1
> +	bne	t0, t1, exit
> +
> +	/* Clearing LCOFIP alone must not re-enable overflow notification. */
> +	li	t0, 1 << 13
> +	csrc	mip, t0
> +	li	t0, -1
> +	csrw	mhpmcounter3, t0
> +	sfence.vma
> +	lla	t0, second_page
> +	lw	t1, 0(t0)
> +	li	t4, 4
> +	csrr	t0, mhpmcounter3
> +	bnez	t0, exit
> +	li	t4, 5
> +	csrr	t0, mhpmevent3
> +	srli	t0, t0, 63
> +	li	t1, EXPECT_SSCOFPMF
> +	bne	t0, t1, exit
> +	li	t4, 6
> +	csrr	t0, mip
> +	li	t1, 1 << 13
> +	and	t0, t0, t1
> +	bnez	t0, exit
> +
> +	/* Overflow notification must not stop event counting. */
> +	sfence.vma
> +	lla	t0, third_page
> +	lw	t1, 0(t0)
> +	li	t4, 7
> +	csrr	t0, mhpmcounter3
> +	li	t1, 1
> +	bne	t0, t1, exit
> +	li	t4, 0
> +
> +exit:
> +	lla	a1, semiargs
> +	li	t0, 0x20026		/* ADP_Stopped_ApplicationExit */
> +	sd	t0, 0(a1)
> +	sd	t4, 8(a1)
> +	li	a0, 0x20		/* TARGET_SYS_EXIT_EXTENDED */
> +	.balign	16
> +	slli	zero, zero, 0x1f
> +	ebreak
> +	srai	zero, zero, 0x7
> +	j	.
> +
> +	.data
> +	.balign	4096
> +first_page:
> +	.word	0
> +	.balign	4096
> +second_page:
> +	.word	0
> +	.balign	4096
> +third_page:
> +	.word	0
> +	.balign	16
> +semiargs:
> +	.space	16
> diff --git a/tests/tcg/riscv64/system/meson.build b/tests/tcg/riscv64/system/meson.build
> index 1dd0402631036d0d377bb90d7cb1da2bae34ead4..13ee7954ef4f09559a02a3730fb017ccf2cfd882 100644
> --- a/tests/tcg/riscv64/system/meson.build
> +++ b/tests/tcg/riscv64/system/meson.build
> @@ -99,6 +99,21 @@ tests += {
>     },
>   }
>   
> +tests += {
> +  'sscofpmf-event-overflow.S': {
> +    'cflags': cflags,
> +    'qemu_args': ['-cpu', 'max', qemu_args],
> +  },
> +}
> +
> +tests += {
> +  'sscofpmf-event-overflow.S': {
> +    'exe_name': 'sscofpmf-event-overflow-off',
> +    'cflags': cflags + ['-DEXPECT_SSCOFPMF=0'],
> +    'qemu_args': ['-cpu', 'max,sscofpmf=false', qemu_args],
> +  },
> +}
> +
>   tests += {
>     'sscofpmf-cycle-overflow.S': {
>       'cflags': cflags,
> 


