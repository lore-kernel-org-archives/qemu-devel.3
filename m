Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908D5606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 10:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lEtGkYsT;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=T2ZoFiOC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTd7P-00025F-2V; Wed, 18 Nov 2026 05:42:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xTd7K-00024U-77
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 05:42:18 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xTd7H-00009R-IG
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 05:42:17 -0500
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AI9k9sD2398719
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 10:42:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ewan6kk3VJuBlRggzcxKfU8w1yZL56d/UCdqV/8JsiQ=; b=lEtGkYsTUQtELL69
 QJGIIYP3ykOJXfP5YHLLgjOFI6a8UrJELMKsNOnlc5GsYm/8Ps0An62jx+EZqtGH
 DtpNse/SdCSs5GAKGK+RmzG25sQRaam7nhwMcIYvxvNGoVdcmz4reIsBFXFiYcgb
 5fcimS9+6LqEwQ2uSKBfmcLZPjYvQFm/tD2GAwage/gYrOQiCRYscPAplJMapJ86
 UBSIHXJOSpSZdkJbR+1aYAKXvtGR0f7ooG+C4lWAUYz4DwHvc9Y3L2qxXa6zHLbe
 uZ5lAi4xlI135YSxk0dtqxIcUsmPXcgtdjHIqMboVyS3sBC9DycHVO5ZERw925Gt
 FoAiBg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0yv92mhg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 10:42:13 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f32050e72so220182385a.1
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 02:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794998532; x=1795603332; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ewan6kk3VJuBlRggzcxKfU8w1yZL56d/UCdqV/8JsiQ=;
 b=T2ZoFiOCXxQF7bBUg7hnHVk5nOw6OEHEj79w3Cg8MDacxyyB0tHodiJimMyUBKYftx
 Clez8Sdq3XoAPG69zGnE2v//aJmuPlKvjcSARHTObmnkHiwRWYbmU16cXmjKaEVZHXTM
 EwJA+iBMxZf9lr4LvFC2x+qv3J1Dhv+/QqJZcz1NHtQaD2Y0thdY11FAtNkhoP4pA/UG
 a8Ta17h2r/Mxbuxep/QGCvsj5kKe7MhleyfYInL+rVJraSsou8P1DWqsO5ElZVhDSEs1
 pc1UGYeHeI1phSp3gMkPIbjyvj+9o/tUcMbvdfnR6ibsKSYEhWT6hF7Sz75ZSKHPofj6
 cSuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794998532; x=1795603332;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ewan6kk3VJuBlRggzcxKfU8w1yZL56d/UCdqV/8JsiQ=;
 b=udoGx6i+Msg/s0E1qFb8RDYGOJ0vjGukuckb5O5CqnJ4rM+E5ugKJZBBZdvDuNX/LQ
 evMLsxs6Bsf8IZXfT7BihDzWOgF+Us4NMPI+vV+AQe14S+i6+I9I1ORvDNQxjr1dpG7U
 51VcNH1KGrJT1ZHkJEbaBkprl/BuD9ZPkp1s9Itew5MX4Z22LaEK5hRSOetJU+DUyUun
 2Umctw7yFafwQaQH433FRyO0srGFLdTfwskR0/ucUSneVGbt1zCaYQL4HrmX1VcvmJwt
 7Dpt/OJSfFPWHRnUfGqLEpoI1/ILcqYvkHarhO1cWk4AzvijRfafkdi0u3drGFVhHUdE
 t5WA==
X-Gm-Message-State: APuU4Z+OydGozCw5l/cvPLiyXf2TBBwg+MR1Y5PwnuSmLyV5BrzS7C1b
 j01e82qDEvih0Y6Nkg2SCssu+ZCaBqIQNfQMzbO+abq8C9MgfOx7kCmnWyhJSZRaL+WzoId3boG
 +G9pz1SgcXFrLGqt1TdgKG+a45PU/u2VmLGvbOiSX5HM//GWsgkHeHJi9Ui+cUH5ZPw==
X-Gm-Gg: AYBFou3cc9u8123gzBaqyWg6KB7DRq0xiZCrZ9jdTGoZPXqEE4ySiJnfvCsar5w2yar
 rqOwmHhihVO20767D49+RhrLOZDbRsV6+NO7xMpub1f9evOmgOGeF6u09JWAXr9JnlzDHbncYnD
 xMj8VLJB6v9itn8CMUcSffEXo3gu1eyimg8CbvsYa5/0G9tdfx3BhKlHt10HW7Y8FlhqvqZLNcs
 PKKLC1hAIL7Wh6Z0VvTpJd4MCvxJ/zUmBiXmIXZcpIGHS7PSSLe8reEtzNHdbBQ0y21e3KYGhLt
 6C2OTZfKvfpW5Tlwe+yYH9YxH520jSUObmmUW66nvbYAZn/WASXFYx+rT7mObZ3HE8AtNVENgj1
 BMMQnnp1McH37mm82LVAuAxnDC2/E+FaKCZaKZkIgQDqVdoYsqU6FhRGy9yEvgPe0gf1BLyC7j7
 NjRdyffWxgaw==
X-Received: by 2002:a05:620a:628b:b0:93f:2c95:658c with SMTP id
 af79cd13be357-9499957e6famr410621485a.14.1794998532229; 
 Wed, 18 Nov 2026 02:42:12 -0800 (PST)
X-Received: by 2002:a05:620a:628b:b0:93f:2c95:658c with SMTP id
 af79cd13be357-9499957e6famr410616885a.14.1794998531584; 
 Wed, 18 Nov 2026 02:42:11 -0800 (PST)
Received: from [192.168.68.104] ([177.170.227.223])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9499b72186csm149606885a.14.2026.11.18.02.42.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Nov 2026 02:42:11 -0800 (PST)
Message-ID: <c9f853d2-781c-40b3-93ed-4849a2c885bf@oss.qualcomm.com>
Date: Wed, 18 Nov 2026 07:42:08 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: do not clear mstatush after mstatus write
 [GL4488]
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Palmer Dabbelt <palmer@dabbelt.com>
References: <20261112211029.562640-1-daniel.barboza@oss.qualcomm.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261112211029.562640-1-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA0MiBTYWx0ZWRfX9eHyGy3LIOY/
 4N4b+zyOGyLBeJkChX4aksWMlVV+wsgukL0Pq0dXOTteQTwgICaRaPt/bQoR16FRKHBk0JW8bsh
 ziEq/ysjA4Ry2pyQQGeR487DG/DWA4bH+S4Aw2ur+dB2grHMvjk0ynTVUNhMP2jJXj3woTi2k13
 jXafObyRhWq7VKhj0uNKkOLIgjsPVL5DcIYtuS/ifZ3QzRo0KYmm9EOavJ+N5QiRtfTorfBOyNR
 d2qFuwcN3IEq6KzYEtMVUGYb4TnGDZscJJObVxkmdbwUZKn8L5KoIvd3goqs08EYP/zUcKVx7PE
 NhTF9xNyuknIKMGgbEqdK5mgVDuU7e/YUVSo/W4hUv33gXgx6UKUS+n+78NQUR7+ZQz6bTSi32X
 QQ61tZAlt712fypssLtLfJOoPX8k0bypRLwzuGhqvb3eOyk9GX8GjUryOH95zQdjArku4X+gCBB
 BM0QbHRAqPhzm2fGNog==
X-Proofpoint-GUID: kqW71ahKW0YDpv3pRhR569pyxNniFc0J
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA0MiBTYWx0ZWRfXwLXabMepG5pv
 qFr8v0DSzH12MlsFa8o6z0jbdwWL4C9VcFKqHk3UFuGn9H4baCvU/1PgdhJyCk5m0nidUATE+x7
 xJ11PesWrXWf/U9B5dN89JdtOWppkg8=
X-Authority-Analysis: v=2.4 cv=LuQHWXdc c=1 sm=1 tr=0 ts=6afd8105 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=WERq1Tg1Nl5IKGfG0e6imA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=lXExS8YvyDYxxBmGfQ0A:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: kqW71ahKW0YDpv3pRhR569pyxNniFc0J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180042
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
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

Please disregard this patch.  I just re-sent it folded in a short series here:


  [PATCH 0/2] target/riscv: rv32/mstatush related fixes [GL4488,GL4827]


Thanks,

Daniel

On 11/12/2026 6:10 PM, Daniel Henrique Barboza wrote:
> For RV32 we have mstatus and mstatush, both 32 bit CSRs, that shares the
> same 64 bit container in env->mstatus.  mstatus will read/write the
> lower 32 bits of env->mstatus, mstatush will read/write the higher 32
> bits of env->mstatus.
> 
> We forgot about that in write_mstatus() and, when running in 32 bits,
> we're happily setting the write mask with bits that belongs to higher
> half of env->mstatus.  The result is that whatever was written there via
> mstatush is being cleared.
> 
> The solution is to clear the higher half of the mask if we're running 32
> bits.
> 
> Fixes: 284d697c74ef ("target/riscv: Merge m/vsstatus and m/vsstatush into one uint64_t unit")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4488
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> ---
>   target/riscv/tcg/csr.c                  |  9 ++++
>   tests/tcg/riscv32/system/meson.build    |  7 +++
>   tests/tcg/riscv32/test-mstatush-clear.S | 57 +++++++++++++++++++++++++
>   3 files changed, 73 insertions(+)
>   create mode 100644 tests/tcg/riscv32/test-mstatush-clear.S
> 
> diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
> index af444e3e6f..ab436244cf 100644
> --- a/target/riscv/tcg/csr.c
> +++ b/target/riscv/tcg/csr.c
> @@ -2127,6 +2127,15 @@ static RISCVException write_mstatus(CPURISCVState *env, int csrno,
>           mask |= (MSTATUS_MPELP | MSTATUS_SPELP);
>       }
>   
> +    /*
> +     * For 32 bit accesses we're writing just the lower 32 bits of
> +     * the env->mstatus container.  The higher bits are written via
> +     * write_mstatush().
> +     */
> +    if (xl == MXL_RV32) {
> +        mask &= MAKE_64BIT_MASK(0, 32);
> +    }
> +
>       mstatus = (mstatus & ~mask) | (val & mask);
>   
>       env->mstatus = mstatus;
> diff --git a/tests/tcg/riscv32/system/meson.build b/tests/tcg/riscv32/system/meson.build
> index 117ae6fbce..c70cc12517 100644
> --- a/tests/tcg/riscv32/system/meson.build
> +++ b/tests/tcg/riscv32/system/meson.build
> @@ -22,6 +22,13 @@ tests += {
>     },
>   }
>   
> +tests += {
> +  'test-mstatush-clear.S': {
> +    'cflags': cflags,
> +    'qemu_args': ['-cpu', 'max,smdbltrp=on', qemu_args],
> +  },
> +}
> +
>   if 'qemu-system-riscv32' in emulators
>     tcg_tests += {
>       'riscv32-softmmu': {
> diff --git a/tests/tcg/riscv32/test-mstatush-clear.S b/tests/tcg/riscv32/test-mstatush-clear.S
> new file mode 100644
> index 0000000000..5053832700
> --- /dev/null
> +++ b/tests/tcg/riscv32/test-mstatush-clear.S
> @@ -0,0 +1,57 @@
> +/*
> + * Verify that mstatush is not being cleared after writing mstatus
> + * (Gitlab 4488).
> + *
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#define MSTATUSH_MDT 0x400
> +
> +.option norvc
> +	.text
> +	.global _start
> +
> +_start:
> +	lla	t0, trap
> +	csrw	mtvec, t0
> +
> +	/* Write mstatush.MDT.  */
> +	csrr	s0, mstatush
> +	li	t0, MSTATUSH_MDT
> +	or	t1, s0, t0
> +	csrw	mstatush, t1
> +
> +	/* Check if mstatush.MDT is indeed written.  */
> +	csrr	s0, mstatush
> +	and	t1, s0, t0
> +	bne	t0, t1, _fail
> +
> +	/* Read mstatus, write the same stuff back to it.  */
> +	csrr	t1, mstatus
> +	csrw	mstatus, t1
> +
> +	/*
> +	 * Make sure that we didn't clear mstatush.MDT after
> +	 * writing mstatus.
> +	 */
> +	csrr	s0, mstatush
> +	and	t1, s0, t0
> +	bne	t0, t1, _fail
> +
> +	j	_pass
> +
> +trap:
> +	j	_fail
> +
> +_pass:
> +	li	t0, 0x100000
> +	li	t1, 0x5555	/* FINISHER_PASS */
> +	sw	t1, 0(t0)
> +	j	.
> +
> +_fail:
> +	li	t0, 0x100000
> +	li	t1, 0x13333	/* status = FINISHER_FAIL, code = 1 */
> +	sw	t1, 0(t0)
> +	j	.


