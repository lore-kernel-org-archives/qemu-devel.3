Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E7F606A32A
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Nov 2026 12:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gYRWenxQ;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=j4+lCjyk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUkSH-0001wf-00; Sat, 21 Nov 2026 07:44:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xUkSF-0001wQ-8G
 for qemu-devel@nongnu.org; Sat, 21 Nov 2026 07:44:31 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xUkSD-0002Yy-Cf
 for qemu-devel@nongnu.org; Sat, 21 Nov 2026 07:44:30 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ALCGFs8206561
 for <qemu-devel@nongnu.org>; Sat, 21 Nov 2026 12:44:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Da6xAt7hKA/OTIGh2+Uf8diabrWMSKHHVafFvlU5+54=; b=gYRWenxQmJMNdY4t
 4Shf7jQCebofJTYukrEgGfOz9x62CAl+V4iyJnHpuvlsib7LG6DZp9bSSPa1GBzl
 ZTw95XRNoLjLfyE3/sjcnRm3KhoC+1ETIPL5GPTeQYPiGGK4YMCQaauNtxzBL654
 3+EH34o89tVB6bKXY3zODlXWogMGPYG9CD570Rv32b63loMIuei5iGqEKQQQNTOO
 nbnqCtljHafjeOWDz216aNRtjLEOSx6sL+8q6hndLKF1anY/XhQvqsAfVD94vZ5x
 k1fWKd1GsOTTfdwfiKLUjNiwrFttgbg799TSQidLAggeSN2R3YqtTlR7Hp/7Wz31
 +EoQIQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j32mg973q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 21 Nov 2026 12:44:27 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-9210357af78so45557736d6.1
 for <qemu-devel@nongnu.org>; Sat, 21 Nov 2026 04:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795265067; x=1795869867; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Da6xAt7hKA/OTIGh2+Uf8diabrWMSKHHVafFvlU5+54=;
 b=j4+lCjykCmj5WcAxtJIkI8BNIsRbSzstoPgeaxZFgcbrRPYhVCmgcyziALdIoTTRHQ
 UsLJ3FS9oEATfcpQbG9umvG5QMI9YfmxVUMQ3C+p7tEvhgARxFw/QzzxCO2KLYgpoXVj
 Qw1wmWPHLJABdCCqf4CmeVteB9sm69JemFzvB3KL2KNsaMjOobFhc2XRz3nEUtOi592p
 75HWig3AcyI5ZK53rkK3wn3YyveohHgGcnZj+W8Rl4nABgKEkHwwjxgwwxnv0QqADYoM
 Akief1M+qDzgNDeKansT+nAk6hxOKzAhMwF4nqOn0tLsopMa8jwjJ1IaYT4IWsk2Bh8c
 voaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795265067; x=1795869867;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Da6xAt7hKA/OTIGh2+Uf8diabrWMSKHHVafFvlU5+54=;
 b=GLD45X+lx5U7UJXlKq3mtAKjAWTcDQ455GTuoKGoyUAAED3nWVqsnhioSL60BPRi+X
 QgL66QS2g96ZzpBJQi784PGjt63E88X/3jAM6P34msUVuJR9re4wmhmlZ32sElF0/6hf
 5SrZfgAVAG/TBxNT+uh8TKpaf3YAbrNJZlFmU6notnqaWsXLBF7xU9grsj2WqsEMC8Fp
 kGHICnZNlzQhLxAC+I2wjkbwHjoVfaod8jUXabXoJl7Cn6V5+4Re0AFr2Do6lu6o0gXQ
 t3ARBiijzDbhuZ5IdONIRfhusg0Qz+pdtY4IBy0KHf3zjd7yN8p4BLg7SYVtwzkAtL0g
 qhcQ==
X-Gm-Message-State: APuU4Z+07jiavjVM9gjujSkozVKESustqmW3HWNuEUk3Ivsfunn4Ffuj
 AMwg+IlQHMpTYOaWm12VHuGu0MGm3lp8DcRn8ZC+veyx8sluoD8oppuybRSmLwNVnFqyE9jN74l
 VnFDFj7c7sJMecofzR7BigHF6egeVbPC7asDdRYW8u1l9GLxpUBOkaXFXKvczTF8yxw==
X-Gm-Gg: AZFdTZc/xCiptnoO64AL9fOPhZJkwWIAW9vu/M5Qakn9xk9WHTcqthr4MK4tpf8SIxJ
 JFbUKSnhMFlVCN7kKze7XiDDI8wcLS0lMyKBeu/OZMza8pjde4gZqL7cuOqSctfpG+8d8geaHMQ
 mMraerwJ9eV7tjA5zRX3XclYJDV89/Xr5QtJrov7MhRcmIApzQXYoYRghjly2BzH3ZfDzt0wVRt
 GCbnFz35HyIAzK/Oqcbww+AVUclFDH829YrnHwnxY3dwFvDh13Yyrfu9+yRPlUNroZdtA3xlfAi
 9Btx2uO1iBqG0PYVaQ4LI3FE/cEXD5EsmtF/QG59hbN1KrK2CYc/CtU+E4d8cFqO0faV6TeTvZt
 AHrwNTOwxdHlUa8Huid4Sd3r9L7Au0rY/euAQnB8OKUF4GrRsqonFlfB497Qf/BzAG0z34de2ZW
 LEv7al9oMV
X-Received: by 2002:a05:6214:2dc4:b0:921:3475:4bf2 with SMTP id
 6a1803df08f44-92134b9d275mr92478766d6.25.1795265067160; 
 Sat, 21 Nov 2026 04:44:27 -0800 (PST)
X-Received: by 2002:a05:6214:2dc4:b0:921:3475:4bf2 with SMTP id
 6a1803df08f44-92134b9d275mr92478556d6.25.1795265066697; 
 Sat, 21 Nov 2026 04:44:26 -0800 (PST)
Received: from [192.168.68.105] ([189.110.107.17])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-92134a2806dsm51653596d6.45.2026.11.21.04.44.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Nov 2026 04:44:26 -0800 (PST)
Message-ID: <e61303cd-34b0-4f3a-92f2-cab9834b24bb@oss.qualcomm.com>
Date: Sat, 21 Nov 2026 09:44:23 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: make mstatush.MPELP writable [GL4220]
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Palmer Dabbelt <palmer@dabbelt.com>
References: <20261112200635.549520-1-daniel.barboza@oss.qualcomm.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261112200635.549520-1-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIxMDA1MCBTYWx0ZWRfX9zq8LBoQ+w2Y
 ron2G6iQBA59+KSiGTODd4LAq0IASceZrr0GujiwKO/Sr1YXPzV5xrb5uQi7kFbnJgJklDxS1gO
 DbDj/G3g/V10BDrwTdgOkyzcWKtwxyShCsTU6BIezi8VFTqaM7UwPE2oopIC9MS+WFl5yPL9xnl
 0GTuZCcxKv9wDiNav43ho3aqkbhIgjGh/RUoHb+v0LiMB7og/w6Uo3RVgTY+CCSOZn8IsWqdgMJ
 NSyGWFBR/pXb1pVVVWTZNdTwH30x47qYgyqbBv75r0u/Out9AWxgQ1Z88/deU8Kn2OtCJTbVCGo
 y6bTUq9l4v8MFg7XfYlNK6KfLvd7wjYLymYnQXsPYUwkGzjAqBBVgwMps2/h7WQq3wC9E6ZQHXJ
 nv4zNF1nyV5wZqTiIJykeoXC7ZaBzWUREfhEB3KDsHGk7PLgDddyQJ0l+mOJicTZk0tM+slhp+X
 UOq24FN3Sg/RyiNTElA==
X-Authority-Analysis: v=2.4 cv=OM+yTiaB c=1 sm=1 tr=0 ts=6b01922b cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=2Chh/y2wedAoPG2p3qwUfw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=cg53bU8Wj0-TdxcqrnAA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIxMDA1MCBTYWx0ZWRfX6V7VX7Hjd9Qo
 4kP1IrwumJw98f6IT9qsy1ct1oAwRBbaCcmFBvbwcEr6IOGktvvVWNYbO5faPRfk/d/E4HvFbuR
 HjnHHNaYR0Lvhd3GrJvj7/TT22IiedA=
X-Proofpoint-GUID: M69IMGGFPnrQSAjWP0w6r1rtmkBw60Kn
X-Proofpoint-ORIG-GUID: M69IMGGFPnrQSAjWP0w6r1rtmkBw60Kn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-21_03,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611210050
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

Ping review/Sashiko

Let's not miss the great "Gitlab fixes" train coming up in the next PR :)


Thanks,
Daniel

On 11/12/2026 5:06 PM, Daniel Henrique Barboza wrote:
> Add MSTATUS_MPELP in the write mask inside write_mstatush().
> 
> Fixes: 4923f672e3d7 ("target/riscv: Introduce elp state and enabling controls for zicfilp")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4220
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> ---
>   target/riscv/tcg/csr.c                  |  5 +++
>   tests/tcg/riscv32/system/meson.build    |  7 +++++
>   tests/tcg/riscv32/test-mstatush-mpelp.S | 42 +++++++++++++++++++++++++
>   3 files changed, 54 insertions(+)
>   create mode 100644 tests/tcg/riscv32/test-mstatush-mpelp.S
> 
> diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
> index af444e3e6f..e73455d021 100644
> --- a/target/riscv/tcg/csr.c
> +++ b/target/riscv/tcg/csr.c
> @@ -2155,6 +2155,11 @@ static RISCVException write_mstatush(CPURISCVState *env, int csrno,
>       uint64_t valh = (uint64_t)val << 32;
>       uint64_t mask = riscv_has_ext(env, RVH) ? MSTATUS_MPV | MSTATUS_GVA : 0;
>   
> +    /* If cfi lp extension is available, then apply cfi lp mask */
> +    if (env_archcpu(env)->cfg.ext_zicfilp) {
> +        mask |= MSTATUS_MPELP;
> +    }
> +
>       if (riscv_cpu_cfg(env)->ext_smdbltrp) {
>           mask |= MSTATUS_MDT;
>           if ((valh & MSTATUS_MDT) != 0) {
> diff --git a/tests/tcg/riscv32/system/meson.build b/tests/tcg/riscv32/system/meson.build
> index 117ae6fbce..415a1c212d 100644
> --- a/tests/tcg/riscv32/system/meson.build
> +++ b/tests/tcg/riscv32/system/meson.build
> @@ -22,6 +22,13 @@ tests += {
>     },
>   }
>   
> +tests += {
> +  'test-mstatush-mpelp.S': {
> +    'cflags': cflags,
> +    'qemu_args': ['-cpu', 'max', qemu_args],
> +  },
> +}
> +
>   if 'qemu-system-riscv32' in emulators
>     tcg_tests += {
>       'riscv32-softmmu': {
> diff --git a/tests/tcg/riscv32/test-mstatush-mpelp.S b/tests/tcg/riscv32/test-mstatush-mpelp.S
> new file mode 100644
> index 0000000000..f70b4dfc32
> --- /dev/null
> +++ b/tests/tcg/riscv32/test-mstatush-mpelp.S
> @@ -0,0 +1,42 @@
> +/*
> + * Test that mstatush.MPELP is writable (Gitlab 4220).
> + *
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#define MSTATUSH_MPELP 0x200
> +
> +.option norvc
> +	.text
> +	.global _start
> +
> +_start:
> +	lla	t0, trap
> +	csrw	mtvec, t0
> +
> +	csrr	s0, mstatush
> +	li	t0, MSTATUSH_MPELP
> +	or	t1, s0, t0
> +	csrw	mstatush, t1
> +
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


