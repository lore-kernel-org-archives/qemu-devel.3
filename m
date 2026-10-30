Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33B6606A325
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 14:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bxbAA/ZT;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LcdEDtIG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMntJ-0007Yz-Se; Fri, 30 Oct 2026 10:47:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMntE-0007YV-8i
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:47:32 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMnt7-0005fa-Sm
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 10:47:30 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UER7Yj3552195
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 14:47:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OxChkVTnJAXwRHY/vzghLxn9JVae5NG9/vllTsrHws0=; b=bxbAA/ZTc81dzahr
 V4HDeqRkPN1nCDXwx2mWW0ffl2+W85YsOjdU9oxpCXvuO+RAu98/uVgg8MutYlc5
 LnEeyxVRGZd+SvmttR1Sm3IcDm6oYguHkJWiKR3NiZC5q6Zwgtdyx0Ou2LYbHY1M
 grdLN6TmBjjAi1x2oWmNC/DxnOoXvTcjPWA6XmGZqxZQftr3lkVO0fep9o1dbYOm
 8EmDBS3UeoDFRFqnAtcJwhikumTtmOLnQk7v8n5AF6CfGru29b4ZdtUkVWH9tulF
 bigp+jwXOHTZb6Ndd0BKxWn0nz/yIKFuerXydexR8aMYvvvmWE+G3fel2CC84JR1
 IGjOew==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qkh3w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 14:47:23 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f559420f3so70308585a.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 07:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793371643; x=1793976443; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=OxChkVTnJAXwRHY/vzghLxn9JVae5NG9/vllTsrHws0=;
 b=LcdEDtIG9IKK1dRaTMi7+Kddqllaqq6Td4Ra7/KJBTh5INCZPrh1180Tz4VLHf2mhw
 tIRNSFIdxeOFRbPfW76iuVDN/tqafU5cxB90XBWB0yHNzgbiysj7fRAp3eF2L1qileXX
 ebTV15FyTIBurbfG4OnWDuMmpfMxJZBnFtwjpNHkagM+JSxl3M9dtO0ZtrX0cUwCNmzB
 QvB1i9nYCu3n0FNHsv83yrwO3Csh63LcqNqo0LGPmxNB7iq3UWXUiebK4fWDQ8nCqIXn
 8nhR2Z1vxTEnGEVzksYPPm64Km8UrKnFM0D6HLzq2CXNVoqZHpom1lF6dTHGD35DEvEb
 fB+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793371643; x=1793976443;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OxChkVTnJAXwRHY/vzghLxn9JVae5NG9/vllTsrHws0=;
 b=S4HKMP8NJFXF11VHzU3YLFiH8KtPtlQjEbY/dpcJzESa4LDt19J4Vqj/BoIcaPScSy
 E2NDMfSDsikU1bpV5KoITgqDMY8uCLGh+t4ysJq/Avh7Ru+arOluZy5Rob6d16g21y1o
 GXNo17RP1oFhYjeEmjw9jDkW+GtA4nVtc/RgBXaVQZBABwO8Nml3yBplR6UboLeSJ+uT
 RnedBY4QHF1aIKY36dZpmb8AqeiVABtxz5jyifFKo6/HBdjTtNOpmdsNaHGVV1bE0Lwf
 VHMdXG41ctZvSrwRdkGeyGek8ISHIDnfvKwTh+iQDwM4Qca7mkZzn8udw7r4XiVhnBmB
 nTXg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxyMehakwza9DdcyRLmMOUgBRI1PLZzGVSB4s9sWIckkwN+Qji1MYw5682FCRA9fnfAz4d1YRO9yNTb@nongnu.org
X-Gm-Message-State: AFq9FYKlxdlvvTjjw6NGKSIWDARKoFJZ9IGwG/1e+RIefraKwk2uS/En
 zgB7s3fxiuodCAw35zAlPZAC4njXsOwZtf+tj288IsSa7Kn5Ea6XH0vrmWEGz6Y5humvnb7e7/3
 7YnN6eFfj6ccc3fU8igORwGEqt1zkTCO8Gg3OhHB7tMJOQ10QFwE5q7f9hQ==
X-Gm-Gg: AYBFou2PSEcYia3mzCnMe0S3YxbhY8TcK1wda8OUnKU7YE7Fy9kda/i6Xr2GJFLwIm+
 hOPzqEXg0QfSnHk7NzxFbFmj+V+MgxXSapdGWOXjab7eF+KgHk4n2bJ09UrW0KSdETnwmYSIOnl
 MVCHtx+DbhgwDZN9e607tRyPpMsWn9ErIE29dZ0FlfujO+5eWyaNHDhh4vuctT2J77woph5gIB1
 vYmAiIug2ud3cU99xgblopRKPeaszNwSDd+DxYRDF2Keufp4VpDOrUo0W47LVAiIlwbZYMjOyG1
 WQXc245FY0NFpuiOICKc6Ua1BHEYQhKcGJC8aFu/6xlovQn7s5r27L/WZvc8GLbGFmgR6D4nLT2
 JXCPAoV3HMusTlM3aYHy12vyGyDVR/6cQQ0vwSjxmXsbKZieQncFdnBnzekbNGpt9b4BzCLAa9e
 wfT6u6IMXWMa5Glrio3M7hLKc517Q6UVMPugENXQ==
X-Received: by 2002:a05:620a:801c:b0:93e:c12c:fbcd with SMTP id
 af79cd13be357-944217a3ad0mr415112985a.73.1793371641108; 
 Fri, 30 Oct 2026 07:47:21 -0700 (PDT)
X-Received: by 2002:a05:620a:801c:b0:93e:c12c:fbcd with SMTP id
 af79cd13be357-944217a3ad0mr415092985a.73.1793371638700; 
 Fri, 30 Oct 2026 07:47:18 -0700 (PDT)
Received: from [10.222.168.219] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ac09cc3e9asm25697325e9.3.2026.10.30.07.47.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2026 07:47:17 -0700 (PDT)
Message-ID: <22317ef8-8b77-4a8f-9f5d-7bc0ccfc29a9@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 09:47:12 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/20] tests/tcg/hexagon: add HLX instruction tests
To: Marco Liebel <marco.liebel@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Alessandro Di Federico <ale@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
References: <20261029174413.643130-1-marco.liebel@oss.qualcomm.com>
 <20261029174413.643130-20-marco.liebel@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20261029174413.643130-20-marco.liebel@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 7EeDbop9PWAUShJOdLsNN5FoQAUU5bNe
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1OCBTYWx0ZWRfX0OO0fLByAPTG
 CdY45dvDJIQWXclCQMKV/k4IhKFypllqEViG4mFVMIZIZHJujzrlcasQkKQOSkuYPnWxT8tYLsG
 2R7NhdynqLXGa2LkQDcfwFDaUoh/1oY=
X-Authority-Analysis: v=2.4 cv=DfSCOftW c=1 sm=1 tr=0 ts=6ae4adfc cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=vCx4X6kPOn2897H1-EsA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: 7EeDbop9PWAUShJOdLsNN5FoQAUU5bNe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1OCBTYWx0ZWRfXw5Fnohj9SEyz
 pKcD4ctWYwGEY9aDk9dTXFNSc1Sik3sXoMntnEYClANYxuJL2bZze7MmnYKZw+6c0ou2/NbZJv1
 8BVJleIbC9kMg/i8eL2VI1rXxi+XsfyfxTuU6IfXkyeZpO4PtfSqI8mKGNs2j/54DBvNLnzjFvL
 lU+ZlgLcD3KFNp7cFgQo32r8+Jh0iyUccOEfy1h7N9xZY0mmXLGWkQ9R7e6og3X0xqAufntQcti
 whvNbuC6xonV7qwBBswyn02HAOglBqNY6bgkNBb9GGTDdn8I3Ukk06NOEVIHvmYs1adgJZ9znfD
 hlQJUpGjlwa+JsvIylNbkv0sITCURALQFSJXpAiwwQOiwwL91TPOOocBIG1GAmNdLc6n1VumtKM
 VqQV88kl92zsalBFrIHTTVYzY6vYBmIuOagfKIsL/hyXhgpO7p+cpQJdd692IwG97jhtA/IFI35
 gusjPcohBHuE2cZT+uA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 adultscore=0 priorityscore=1501 spamscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300058
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 10/29/2026 12:44 PM, Marco Liebel wrote:
> Test HLX arithmetic, logical, conversion, multiply, shift, and memory
> instructions in linux-user mode.
>
> Use encoded instructions so the tests work with toolchains that do not
> assemble HLX.
>
> Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   tests/tcg/hexagon/check_rev_gating.c |   10 +-
>   tests/tcg/hexagon/hlx_abs_cmp.c      |  570 +++++++
>   tests/tcg/hexagon/hlx_arith_h.c      |  197 +++
>   tests/tcg/hexagon/hlx_arith_w.c      |  695 ++++++++
>   tests/tcg/hexagon/hlx_asm.h          | 2286 ++++++++++++++++++++++++++
>   tests/tcg/hexagon/hlx_assign_conv.c  |  354 ++++
>   tests/tcg/hexagon/hlx_basic.c        |  119 ++
>   tests/tcg/hexagon/hlx_lanes.c        |  455 +++++
>   tests/tcg/hexagon/hlx_logical.c      |  275 ++++
>   tests/tcg/hexagon/hlx_lut_ilog2.c    |  289 ++++
>   tests/tcg/hexagon/hlx_mem.c          |  258 +++
>   tests/tcg/hexagon/hlx_minmax_avg.c   |  801 +++++++++
>   tests/tcg/hexagon/hlx_mpy.c          |  375 +++++
>   tests/tcg/hexagon/hlx_mpy_adv.c      |  452 +++++
>   tests/tcg/hexagon/hlx_reg_writes.c   |  151 ++
>   tests/tcg/hexagon/hlx_shift.c        |  545 ++++++
>   tests/tcg/hexagon/hlx_shift_acc.c    |  275 ++++
>   tests/tcg/hexagon/hlx_test.h         |  162 ++
>   tests/tcg/hexagon/meson.build        |   16 +
>   19 files changed, 8284 insertions(+), 1 deletion(-)
>   create mode 100644 tests/tcg/hexagon/hlx_abs_cmp.c
>   create mode 100644 tests/tcg/hexagon/hlx_arith_h.c
>   create mode 100644 tests/tcg/hexagon/hlx_arith_w.c
>   create mode 100644 tests/tcg/hexagon/hlx_asm.h
>   create mode 100644 tests/tcg/hexagon/hlx_assign_conv.c
>   create mode 100644 tests/tcg/hexagon/hlx_basic.c
>   create mode 100644 tests/tcg/hexagon/hlx_lanes.c
>   create mode 100644 tests/tcg/hexagon/hlx_logical.c
>   create mode 100644 tests/tcg/hexagon/hlx_lut_ilog2.c
>   create mode 100644 tests/tcg/hexagon/hlx_mem.c
>   create mode 100644 tests/tcg/hexagon/hlx_minmax_avg.c
>   create mode 100644 tests/tcg/hexagon/hlx_mpy.c
>   create mode 100644 tests/tcg/hexagon/hlx_mpy_adv.c
>   create mode 100644 tests/tcg/hexagon/hlx_reg_writes.c
>   create mode 100644 tests/tcg/hexagon/hlx_shift.c
>   create mode 100644 tests/tcg/hexagon/hlx_shift_acc.c
>   create mode 100644 tests/tcg/hexagon/hlx_test.h

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>


> diff --git a/tests/tcg/hexagon/check_rev_gating.c b/tests/tcg/hexagon/check_rev_gating.c
> index 3a5ed9c71c..a10080bf76 100644
> --- a/tests/tcg/hexagon/check_rev_gating.c
> +++ b/tests/tcg/hexagon/check_rev_gating.c
> @@ -3,7 +3,7 @@
>    * are rejected with SIGILL.
>    *
>    * Compiled with -mv66 so that e_flags selects CPU v66. The test embeds
> - * instructions from v68 up through v81 via .word encoding: the
> + * instructions from v68 up through v85 via .word encoding: the
>    * assembler enforces the selected CPU's own minimum version, so none
>    * of these -- including ones it otherwise knows how to assemble at
>    * their own target, such as callrh or unpause -- can be written as
> @@ -135,6 +135,11 @@ TRY_FUNC(v79hvx_vmerge_qf,
>   TRY_FUNC(v81hvx_veqhf,
>            ".word 0x1f82c11c    /* q0 = vcmp.eq(v1.hf, v2.hf) */\n")
>   
> +TRY_FUNC(v85hlx_assign_r,
> +         ".word 0xe520e422    /* L1.h = r0.h */\n")
> +TRY_FUNC(v85hlx_zero_store,
> +         ".word 0xa480c001    /* mem(r0) = L1.new */\n")
> +
>   int main(void)
>   {
>       struct sigaction act;
> @@ -180,6 +185,9 @@ int main(void)
>   
>       assert(try_v81hvx_veqhf() == SIGILL);
>   
> +    assert(try_v85hlx_assign_r() == SIGILL);
> +    assert(try_v85hlx_zero_store() == SIGILL);
> +
>       assert(signals_handled == expected_signals);
>   
>       puts("PASS");
> diff --git a/tests/tcg/hexagon/hlx_abs_cmp.c b/tests/tcg/hexagon/hlx_abs_cmp.c
> new file mode 100644
> index 0000000000..ec777e92b5
> --- /dev/null
> +++ b/tests/tcg/hexagon/hlx_abs_cmp.c
> @@ -0,0 +1,570 @@
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "hlx_test.h"
> +
> +#define SIGNED_VAL_A     ((int16_t)-150)
> +#define SIGNED_VAL_B     ((int16_t)200)
> +#define UNSIGNED_VAL_A   300
> +#define UNSIGNED_VAL_B   100
> +
> +#define SIGNED_W_A       (-50000)
> +#define SIGNED_W_B       30000
> +#define UNSIGNED_W_A     100000u
> +#define UNSIGNED_W_B     70000u
> +
> +#define SAT_VAL_H        ((int16_t)0x8000)  /* INT16_MIN for abs sat test */
> +#define SAT_VAL_W        ((int32_t)0x80000000)  /* INT32_MIN for abs sat test */
> +
> +#define PAIRED_A_LO      ((int16_t)(-150))
> +#define PAIRED_A_HI      ((int16_t)200)
> +#define PAIRED_B_LO      ((int16_t)100)
> +#define PAIRED_B_HI      ((int16_t)(-50))
> +
> +static uint16_t *buf_a;
> +static uint16_t *buf_b;
> +static uint16_t *buf_out;
> +static uint16_t expected[HLX_HALF_ELEMS];
> +
> +static uint32_t *pw_a_lo;
> +static uint32_t *pw_a_hi;
> +static uint32_t *pw_b_lo;
> +static uint32_t *pw_b_hi;
> +static uint32_t *pw_out_lo;
> +static uint32_t *pw_out_hi;
> +static uint32_t expected_w[HLX_HALF_ELEMS];
> +
> +static inline uint32_t pack_h(uint16_t lo, uint16_t hi)
> +{
> +    return ((uint32_t)hi << 16) | lo;
> +}
> +
> +static inline int32_t my_abs(int32_t x)
> +{
> +    return x < 0 ? -x : x;
> +}
> +
> +static inline int64_t my_abs64(int64_t x)
> +{
> +    return x < 0 ? -x : x;
> +}
> +
> +static void fill_h(uint16_t *buf, int16_t val)
> +{
> +    Q6_mem_Ku16_new_AL(buf, Q6_Lh_equals_Rh(val));
> +}
> +
> +static void fill_w(uint32_t *buf_lo, uint32_t *buf_hi, int32_t val)
> +{
> +    HLX_VectorPair wp = Q6_LWw_equals_Rw(val);
> +    Q6_mem_Ku16_new_AL((uint16_t *)buf_lo, Q6_L_lo_LW(wp));
> +    Q6_mem_Ku16_new_AL((uint16_t *)buf_hi, Q6_L_hi_LW(wp));
> +}
> +
> +
> +static void test_abs_uh(void)
> +{
> +    HLX_Vector la;
> +
> +    fill_h(buf_a, SIGNED_VAL_A);
> +
> +    la = Q6_L_tmp_mem_A(buf_a);
> +    Q6_mem_Ku16_new_AL(buf_out, Q6_Luh_abs_Lh(la));
> +
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        expected[i] = (uint16_t)my_abs((int32_t)SIGNED_VAL_A);
> +    }
> +    check_h("LX_abs_uh", buf_out, expected, HLX_HALF_ELEMS);
> +}
> +
> +static void test_abs_uh_sat(void)
> +{
> +    HLX_Vector la;
> +
> +    fill_h(buf_a, SAT_VAL_H);
> +
> +    la = Q6_L_tmp_mem_A(buf_a);
> +    Q6_mem_Ku16_new_AL(buf_out, Q6_Lh_abs_Lh_sat(la));
> +
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        int32_t v = my_abs((int32_t)SAT_VAL_H);
> +        expected[i] = (uint16_t)sat_h(v);
> +    }
> +    check_h("LX_abs_uh_sat", buf_out, expected, HLX_HALF_ELEMS);
> +}
> +
> +
> +static void test_abs_uw(void)
> +{
> +    HLX_VectorPair pa;
> +    HLX_VectorPair pc;
> +
> +    /* Test with negative input */
> +    fill_w(pw_a_lo, pw_a_hi, SIGNED_W_A);
> +
> +    pa = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_a_hi),
> +                          Q6_L_tmp_mem_A(pw_a_lo));
> +    pc = Q6_LWuw_abs_LWw(pa);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(pc));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(pc));
> +
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected_w[j] = (uint32_t)my_abs(SIGNED_W_A);
> +    }
> +    check_wp("LX_abs_uw (neg)", pw_out_lo, pw_out_hi,
> +             expected_w, HLX_HALF_ELEMS);
> +
> +    /* Test with positive input */
> +    fill_w(pw_a_lo, pw_a_hi, SIGNED_W_B);
> +
> +    pa = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_a_hi),
> +                          Q6_L_tmp_mem_A(pw_a_lo));
> +    pc = Q6_LWuw_abs_LWw(pa);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(pc));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(pc));
> +
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected_w[j] = (uint32_t)my_abs(SIGNED_W_B);
> +    }
> +    check_wp("LX_abs_uw (pos)", pw_out_lo, pw_out_hi,
> +             expected_w, HLX_HALF_ELEMS);
> +}
> +
> +static void test_abs_uw_sat(void)
> +{
> +    HLX_VectorPair pa;
> +    HLX_VectorPair pc;
> +
> +    fill_w(pw_a_lo, pw_a_hi, SAT_VAL_W);
> +
> +    pa = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_a_hi),
> +                          Q6_L_tmp_mem_A(pw_a_lo));
> +    pc = Q6_LWw_abs_LWw_sat(pa);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(pc));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(pc));
> +
> +    /*
> +     * abs(INT32_MIN) = 2^31, which overflows int32_t.
> +     * The hardware saturates this to INT32_MAX (0x7fffffff).
> +     */
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected_w[j] = (uint32_t)sat_w(my_abs64((int64_t)SAT_VAL_W));
> +    }
> +    check_wp("LX_abs_uw_sat", pw_out_lo, pw_out_hi,
> +             expected_w, HLX_HALF_ELEMS);
> +}
> +
> +static void test_abs_uhp(void)
> +{
> +    HLX_VectorPair pa;
> +    HLX_VectorPair pc;
> +    uint16_t abs_lo;
> +    uint16_t abs_hi;
> +    uint32_t exp_packed;
> +    uint32_t packed_a = pack_h((uint16_t)PAIRED_A_LO, (uint16_t)PAIRED_A_HI);
> +    fill_w(pw_a_lo, pw_a_hi, (int32_t)packed_a);
> +
> +    pa = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_a_hi),
> +                          Q6_L_tmp_mem_A(pw_a_lo));
> +    pc = Q6_LWuh_abs_LWh(pa);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(pc));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(pc));
> +
> +    abs_lo = (uint16_t)my_abs((int32_t)PAIRED_A_LO);
> +    abs_hi = (uint16_t)my_abs((int32_t)PAIRED_A_HI);
> +    exp_packed = pack_h(abs_lo, abs_hi);
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected_w[j] = exp_packed;
> +    }
> +    check_wp("LX_abs_uhp", pw_out_lo, pw_out_hi,
> +             expected_w, HLX_HALF_ELEMS);
> +}
> +
> +static void test_abs_uhp_sat(void)
> +{
> +    HLX_VectorPair pa;
> +    HLX_VectorPair pc;
> +    uint16_t sat_lo;
> +    uint16_t sat_hi;
> +    uint32_t exp_packed;
> +    uint32_t packed_sat = pack_h((uint16_t)SAT_VAL_H, (uint16_t)SAT_VAL_H);
> +    fill_w(pw_a_lo, pw_a_hi, (int32_t)packed_sat);
> +
> +    pa = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_a_hi),
> +                          Q6_L_tmp_mem_A(pw_a_lo));
> +    pc = Q6_LWh_abs_LWh_sat(pa);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(pc));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(pc));
> +
> +    sat_lo = (uint16_t)sat_h(my_abs((int32_t)SAT_VAL_H));
> +    sat_hi = sat_lo;
> +    exp_packed = pack_h(sat_lo, sat_hi);
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected_w[j] = exp_packed;
> +    }
> +    check_wp("LX_abs_uhp_sat", pw_out_lo, pw_out_hi,
> +             expected_w, HLX_HALF_ELEMS);
> +}
> +
> +
> +static void test_absdiff_h(void)
> +{
> +    HLX_Vector la;
> +    HLX_Vector lb;
> +
> +    fill_h(buf_a, SIGNED_VAL_A);
> +    fill_h(buf_b, SIGNED_VAL_B);
> +
> +    la = Q6_L_tmp_mem_A(buf_a);
> +    lb = Q6_L_tmp_mem_A(buf_b);
> +    Q6_mem_Ku16_new_AL(buf_out, Q6_Luh_absdiff_LhLh(la, lb));
> +
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        expected[i] = (uint16_t)my_abs((int32_t)SIGNED_VAL_A -
> +                                       (int32_t)SIGNED_VAL_B);
> +    }
> +    check_h("LX_absdiff_h", buf_out, expected, HLX_HALF_ELEMS);
> +}
> +
> +static void test_absdiff_uh(void)
> +{
> +    HLX_Vector la;
> +    HLX_Vector lb;
> +
> +    fill_h(buf_a, (int16_t)UNSIGNED_VAL_A);
> +    fill_h(buf_b, (int16_t)UNSIGNED_VAL_B);
> +
> +    la = Q6_L_tmp_mem_A(buf_a);
> +    lb = Q6_L_tmp_mem_A(buf_b);
> +    Q6_mem_Ku16_new_AL(buf_out, Q6_Luh_absdiff_LuhLuh(la, lb));
> +
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        expected[i] = (UNSIGNED_VAL_A > UNSIGNED_VAL_B) ?
> +                      (UNSIGNED_VAL_A - UNSIGNED_VAL_B) :
> +                      (UNSIGNED_VAL_B - UNSIGNED_VAL_A);
> +    }
> +    check_h("LX_absdiff_uh", buf_out, expected, HLX_HALF_ELEMS);
> +}
> +
> +static void test_absdiff_w(void)
> +{
> +    HLX_VectorPair pa;
> +    HLX_VectorPair pb;
> +    HLX_VectorPair pc;
> +
> +    /* Test with first pair of values: A - B */
> +    fill_w(pw_a_lo, pw_a_hi, SIGNED_W_A);
> +    fill_w(pw_b_lo, pw_b_hi, SIGNED_W_B);
> +
> +    pa = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_a_hi),
> +                          Q6_L_tmp_mem_A(pw_a_lo));
> +    pb = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_b_hi),
> +                          Q6_L_tmp_mem_A(pw_b_lo));
> +    pc = Q6_LWuw_absdiff_LWwLWw(pa, pb);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(pc));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(pc));
> +
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        int64_t diff = (int64_t)SIGNED_W_A - (int64_t)SIGNED_W_B;
> +        expected_w[j] = (uint32_t)my_abs64(diff);
> +    }
> +    check_wp("LX_absdiff_w (a-b)", pw_out_lo, pw_out_hi,
> +             expected_w, HLX_HALF_ELEMS);
> +
> +    /* Test with swapped values: B - A */
> +    fill_w(pw_a_lo, pw_a_hi, SIGNED_W_B);
> +    fill_w(pw_b_lo, pw_b_hi, SIGNED_W_A);
> +
> +    pa = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_a_hi),
> +                          Q6_L_tmp_mem_A(pw_a_lo));
> +    pb = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_b_hi),
> +                          Q6_L_tmp_mem_A(pw_b_lo));
> +    pc = Q6_LWuw_absdiff_LWwLWw(pa, pb);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(pc));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(pc));
> +
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        int64_t diff = (int64_t)SIGNED_W_B - (int64_t)SIGNED_W_A;
> +        expected_w[j] = (uint32_t)my_abs64(diff);
> +    }
> +    check_wp("LX_absdiff_w (b-a)", pw_out_lo, pw_out_hi,
> +             expected_w, HLX_HALF_ELEMS);
> +}
> +
> +static void test_absdiff_uw(void)
> +{
> +    HLX_VectorPair pa;
> +    HLX_VectorPair pb;
> +    HLX_VectorPair pc;
> +
> +    /* Test with first pair of values: A - B */
> +    fill_w(pw_a_lo, pw_a_hi, (int32_t)UNSIGNED_W_A);
> +    fill_w(pw_b_lo, pw_b_hi, (int32_t)UNSIGNED_W_B);
> +
> +    pa = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_a_hi),
> +                          Q6_L_tmp_mem_A(pw_a_lo));
> +    pb = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_b_hi),
> +                          Q6_L_tmp_mem_A(pw_b_lo));
> +    pc = Q6_LWuw_absdiff_LWuwLWuw(pa, pb);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(pc));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(pc));
> +
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected_w[j] = (UNSIGNED_W_A > UNSIGNED_W_B) ?
> +                        (UNSIGNED_W_A - UNSIGNED_W_B) :
> +                        (UNSIGNED_W_B - UNSIGNED_W_A);
> +    }
> +    check_wp("LX_absdiff_uw (a-b)", pw_out_lo, pw_out_hi,
> +             expected_w, HLX_HALF_ELEMS);
> +
> +    /* Test with swapped values: B - A */
> +    fill_w(pw_a_lo, pw_a_hi, (int32_t)UNSIGNED_W_B);
> +    fill_w(pw_b_lo, pw_b_hi, (int32_t)UNSIGNED_W_A);
> +
> +    pa = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_a_hi),
> +                          Q6_L_tmp_mem_A(pw_a_lo));
> +    pb = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_b_hi),
> +                          Q6_L_tmp_mem_A(pw_b_lo));
> +    pc = Q6_LWuw_absdiff_LWuwLWuw(pa, pb);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(pc));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(pc));
> +
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected_w[j] = (UNSIGNED_W_B > UNSIGNED_W_A) ?
> +                        (UNSIGNED_W_B - UNSIGNED_W_A) :
> +                        (UNSIGNED_W_A - UNSIGNED_W_B);
> +    }
> +    check_wp("LX_absdiff_uw (b-a)", pw_out_lo, pw_out_hi,
> +             expected_w, HLX_HALF_ELEMS);
> +}
> +
> +
> +static void test_cmp_gt_h(void)
> +{
> +    HLX_Vector la;
> +    HLX_Vector lb;
> +
> +    fill_h(buf_a, SIGNED_VAL_A);
> +    fill_h(buf_b, SIGNED_VAL_B);
> +
> +    la = Q6_L_tmp_mem_A(buf_a);
> +    lb = Q6_L_tmp_mem_A(buf_b);
> +    Q6_mem_Ku16_new_AL(buf_out, Q6_Lh_cmp_gt_LhLh(la, lb));
> +
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        expected[i] = (SIGNED_VAL_A > SIGNED_VAL_B) ? 0xFFFF : 0x0000;
> +    }
> +    check_h("LX_cmp_gt_h", buf_out, expected, HLX_HALF_ELEMS);
> +}
> +
> +static void test_cmp_gt_uh(void)
> +{
> +    HLX_Vector la;
> +    HLX_Vector lb;
> +
> +    fill_h(buf_a, (int16_t)UNSIGNED_VAL_A);
> +    fill_h(buf_b, (int16_t)UNSIGNED_VAL_B);
> +
> +    la = Q6_L_tmp_mem_A(buf_a);
> +    lb = Q6_L_tmp_mem_A(buf_b);
> +    Q6_mem_Ku16_new_AL(buf_out, Q6_Lh_cmp_gt_LuhLuh(la, lb));
> +
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        expected[i] = (UNSIGNED_VAL_A > UNSIGNED_VAL_B) ? 0xFFFF : 0x0000;
> +    }
> +    check_h("LX_cmp_gt_uh", buf_out, expected, HLX_HALF_ELEMS);
> +}
> +
> +static void test_cmp_gt_w(void)
> +{
> +    HLX_VectorPair pa;
> +    HLX_VectorPair pb;
> +    HLX_VectorPair pc;
> +
> +    /* Test A > B */
> +    fill_w(pw_a_lo, pw_a_hi, SIGNED_W_A);
> +    fill_w(pw_b_lo, pw_b_hi, SIGNED_W_B);
> +
> +    pa = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_a_hi),
> +                          Q6_L_tmp_mem_A(pw_a_lo));
> +    pb = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_b_hi),
> +                          Q6_L_tmp_mem_A(pw_b_lo));
> +    pc = Q6_LWw_cmp_gt_LWwLWw(pa, pb);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(pc));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(pc));
> +
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected_w[j] = (SIGNED_W_A > SIGNED_W_B) ? 0xFFFFFFFF : 0x0;
> +    }
> +    check_wp("LX_cmp_gt_w (a>b)", pw_out_lo, pw_out_hi,
> +             expected_w, HLX_HALF_ELEMS);
> +
> +    /* Test B > A */
> +    fill_w(pw_a_lo, pw_a_hi, SIGNED_W_B);
> +    fill_w(pw_b_lo, pw_b_hi, SIGNED_W_A);
> +
> +    pa = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_a_hi),
> +                          Q6_L_tmp_mem_A(pw_a_lo));
> +    pb = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_b_hi),
> +                          Q6_L_tmp_mem_A(pw_b_lo));
> +    pc = Q6_LWw_cmp_gt_LWwLWw(pa, pb);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(pc));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(pc));
> +
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected_w[j] = (SIGNED_W_B > SIGNED_W_A) ? 0xFFFFFFFF : 0x0;
> +    }
> +    check_wp("LX_cmp_gt_w (b>a)", pw_out_lo, pw_out_hi,
> +             expected_w, HLX_HALF_ELEMS);
> +}
> +
> +static void test_cmp_gt_uw(void)
> +{
> +    HLX_VectorPair pa;
> +    HLX_VectorPair pb;
> +    HLX_VectorPair pc;
> +
> +    /* Test A > B */
> +    fill_w(pw_a_lo, pw_a_hi, (int32_t)UNSIGNED_W_A);
> +    fill_w(pw_b_lo, pw_b_hi, (int32_t)UNSIGNED_W_B);
> +
> +    pa = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_a_hi),
> +                          Q6_L_tmp_mem_A(pw_a_lo));
> +    pb = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_b_hi),
> +                          Q6_L_tmp_mem_A(pw_b_lo));
> +    pc = Q6_LWw_cmp_gt_LWuwLWuw(pa, pb);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(pc));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(pc));
> +
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected_w[j] = (UNSIGNED_W_A > UNSIGNED_W_B) ? 0xFFFFFFFF : 0x0;
> +    }
> +    check_wp("LX_cmp_gt_uw (a>b)", pw_out_lo, pw_out_hi,
> +             expected_w, HLX_HALF_ELEMS);
> +
> +    /* Test B > A */
> +    fill_w(pw_a_lo, pw_a_hi, (int32_t)UNSIGNED_W_B);
> +    fill_w(pw_b_lo, pw_b_hi, (int32_t)UNSIGNED_W_A);
> +
> +    pa = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_a_hi),
> +                          Q6_L_tmp_mem_A(pw_a_lo));
> +    pb = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_b_hi),
> +                          Q6_L_tmp_mem_A(pw_b_lo));
> +    pc = Q6_LWw_cmp_gt_LWuwLWuw(pa, pb);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(pc));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(pc));
> +
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected_w[j] = (UNSIGNED_W_B > UNSIGNED_W_A) ? 0xFFFFFFFF : 0x0;
> +    }
> +    check_wp("LX_cmp_gt_uw (b>a)", pw_out_lo, pw_out_hi,
> +             expected_w, HLX_HALF_ELEMS);
> +}
> +
> +static void test_cmp_gt_hp(void)
> +{
> +    HLX_VectorPair pa;
> +    HLX_VectorPair pb;
> +    HLX_VectorPair pc;
> +    uint16_t cmp_lo;
> +    uint16_t cmp_hi;
> +    uint32_t exp_packed;
> +    uint32_t packed_a = pack_h((uint16_t)PAIRED_A_LO, (uint16_t)PAIRED_A_HI);
> +    uint32_t packed_b = pack_h((uint16_t)PAIRED_B_LO, (uint16_t)PAIRED_B_HI);
> +    fill_w(pw_a_lo, pw_a_hi, (int32_t)packed_a);
> +    fill_w(pw_b_lo, pw_b_hi, (int32_t)packed_b);
> +
> +    pa = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_a_hi),
> +                          Q6_L_tmp_mem_A(pw_a_lo));
> +    pb = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_b_hi),
> +                          Q6_L_tmp_mem_A(pw_b_lo));
> +    pc = Q6_LWh_cmp_gt_LWhLWh(pa, pb);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(pc));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(pc));
> +
> +    cmp_lo = (PAIRED_A_LO > PAIRED_B_LO) ? 0xFFFF : 0x0000;
> +    cmp_hi = (PAIRED_A_HI > PAIRED_B_HI) ? 0xFFFF : 0x0000;
> +    exp_packed = pack_h(cmp_lo, cmp_hi);
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected_w[j] = exp_packed;
> +    }
> +    check_wp("LX_cmp_gt_hp", pw_out_lo, pw_out_hi,
> +             expected_w, HLX_HALF_ELEMS);
> +}
> +
> +static void test_cmp_gt_uhp(void)
> +{
> +    HLX_VectorPair pa;
> +    HLX_VectorPair pb;
> +    HLX_VectorPair pc;
> +    uint16_t cmp_lo;
> +    uint16_t cmp_hi;
> +    uint32_t exp_packed;
> +    uint32_t packed_a = pack_h((uint16_t)PAIRED_A_LO, (uint16_t)PAIRED_A_HI);
> +    uint32_t packed_b = pack_h((uint16_t)PAIRED_B_LO, (uint16_t)PAIRED_B_HI);
> +    fill_w(pw_a_lo, pw_a_hi, (int32_t)packed_a);
> +    fill_w(pw_b_lo, pw_b_hi, (int32_t)packed_b);
> +
> +    pa = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_a_hi),
> +                          Q6_L_tmp_mem_A(pw_a_lo));
> +    pb = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_b_hi),
> +                          Q6_L_tmp_mem_A(pw_b_lo));
> +    pc = Q6_LWh_cmp_gt_LWuhLWuh(pa, pb);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(pc));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(pc));
> +
> +    cmp_lo = ((uint16_t)PAIRED_A_LO > (uint16_t)PAIRED_B_LO) ?
> +             0xFFFF : 0x0000;
> +    cmp_hi = ((uint16_t)PAIRED_A_HI > (uint16_t)PAIRED_B_HI) ?
> +             0xFFFF : 0x0000;
> +    exp_packed = pack_h(cmp_lo, cmp_hi);
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected_w[j] = exp_packed;
> +    }
> +    check_wp("LX_cmp_gt_uhp", pw_out_lo, pw_out_hi,
> +             expected_w, HLX_HALF_ELEMS);
> +}
> +
> +int main(void)
> +{
> +    init_vtcm();
> +    enable_hlx();
> +
> +    buf_a = vtcm_alloc(HLX_HALF_ELEMS * sizeof(uint16_t));
> +    buf_b = vtcm_alloc(HLX_HALF_ELEMS * sizeof(uint16_t));
> +    buf_out = vtcm_alloc(HLX_HALF_ELEMS * sizeof(uint16_t));
> +    pw_a_lo = vtcm_alloc(HLX_WORD_ELEMS * sizeof(uint32_t));
> +    pw_a_hi = vtcm_alloc(HLX_WORD_ELEMS * sizeof(uint32_t));
> +    pw_b_lo = vtcm_alloc(HLX_WORD_ELEMS * sizeof(uint32_t));
> +    pw_b_hi = vtcm_alloc(HLX_WORD_ELEMS * sizeof(uint32_t));
> +    pw_out_lo = vtcm_alloc(HLX_WORD_ELEMS * sizeof(uint32_t));
> +    pw_out_hi = vtcm_alloc(HLX_WORD_ELEMS * sizeof(uint32_t));
> +    init_hlx_vsp();
> +
> +    /* Absolute value */
> +    test_abs_uh();
> +    test_abs_uh_sat();
> +    test_abs_uw();
> +    test_abs_uw_sat();
> +    test_abs_uhp();
> +    test_abs_uhp_sat();
> +
> +    /* Absolute differences */
> +    test_absdiff_h();
> +    test_absdiff_uh();
> +    test_absdiff_w();
> +    test_absdiff_uw();
> +
> +    /* Compare greater-than */
> +    test_cmp_gt_h();
> +    test_cmp_gt_uh();
> +    test_cmp_gt_w();
> +    test_cmp_gt_uw();
> +    test_cmp_gt_hp();
> +    test_cmp_gt_uhp();
> +
> +    puts(err ? "FAIL" : "PASS");
> +    return err;
> +}
> diff --git a/tests/tcg/hexagon/hlx_arith_h.c b/tests/tcg/hexagon/hlx_arith_h.c
> new file mode 100644
> index 0000000000..0be3069431
> --- /dev/null
> +++ b/tests/tcg/hexagon/hlx_arith_h.c
> @@ -0,0 +1,197 @@
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "hlx_test.h"
> +
> +/* Basic add/sub operands (no overflow) */
> +#define ARITH_A             100
> +#define ARITH_B             200
> +
> +/* Signed positive saturation: NEAR_MAX + SAT_STEP overflows INT16_MAX */
> +#define NEAR_INT16_MAX      32000
> +#define SAT_STEP            1000
> +
> +/* Signed negative saturation: NEAR_MIN - SAT_STEP underflows INT16_MIN */
> +#define NEAR_INT16_MIN      (-32000)
> +
> +/* Unsigned saturation: NEAR_UMAX + SAT_STEP overflows UINT16_MAX */
> +#define NEAR_UINT16_MAX     ((int16_t)65000u)
> +
> +static uint16_t *buf_a;
> +static uint16_t *buf_b;
> +static uint16_t *buf_out;
> +static uint16_t expected[HLX_HALF_ELEMS];
> +
> +static void fill_h(uint16_t *buf, int16_t val)
> +{
> +    Q6_mem_Ku16_new_AL(buf, Q6_Lh_equals_Rh(val));
> +}
> +
> +static void test_add_h(void)
> +{
> +    HLX_Vector la;
> +    HLX_Vector lb;
> +
> +    fill_h(buf_a, ARITH_A);
> +    fill_h(buf_b, ARITH_B);
> +
> +    la = Q6_L_tmp_mem_A(buf_a);
> +    lb = Q6_L_tmp_mem_A(buf_b);
> +    Q6_mem_Ku16_new_AL(buf_out, Q6_Lh_add_LhLh(la, lb));
> +
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        expected[i] = ARITH_A + ARITH_B;
> +    }
> +    check_h("LX_add_h", buf_out, expected, HLX_HALF_ELEMS);
> +}
> +
> +static void test_add_h_sat(void)
> +{
> +    HLX_Vector la;
> +    HLX_Vector lb;
> +
> +    fill_h(buf_a, NEAR_INT16_MAX);
> +    fill_h(buf_b, SAT_STEP);
> +
> +    la = Q6_L_tmp_mem_A(buf_a);
> +    lb = Q6_L_tmp_mem_A(buf_b);
> +    Q6_mem_Ku16_new_AL(buf_out, Q6_Lh_add_LhLh_sat(la, lb));
> +
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        expected[i] = (uint16_t)sat_h((int32_t)NEAR_INT16_MAX + SAT_STEP);
> +    }
> +    check_h("LX_add_h_sat", buf_out, expected, HLX_HALF_ELEMS);
> +}
> +
> +static void test_add_uh_sat(void)
> +{
> +    HLX_Vector la;
> +    HLX_Vector lb;
> +
> +    fill_h(buf_a, NEAR_UINT16_MAX);
> +    fill_h(buf_b, SAT_STEP);
> +
> +    la = Q6_L_tmp_mem_A(buf_a);
> +    lb = Q6_L_tmp_mem_A(buf_b);
> +    Q6_mem_Ku16_new_AL(buf_out, Q6_Luh_add_LuhLuh_sat(la, lb));
> +
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        expected[i] = sat_uh((int32_t)65000u + SAT_STEP);
> +    }
> +    check_h("LX_add_uh_sat", buf_out, expected, HLX_HALF_ELEMS);
> +}
> +
> +static void test_add_uhh_sat(void)
> +{
> +    HLX_Vector la;
> +    HLX_Vector lb;
> +
> +    fill_h(buf_a, ARITH_A);
> +    fill_h(buf_b, ARITH_B);
> +
> +    la = Q6_L_tmp_mem_A(buf_a);
> +    lb = Q6_L_tmp_mem_A(buf_b);
> +    Q6_mem_Ku16_new_AL(buf_out, Q6_Luh_add_LhLh_sat(la, lb));
> +
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        expected[i] = sat_uh((int32_t)ARITH_A + ARITH_B);
> +    }
> +    check_h("LX_add_uhh_sat", buf_out, expected, HLX_HALF_ELEMS);
> +}
> +
> +static void test_sub_h(void)
> +{
> +    HLX_Vector la;
> +    HLX_Vector lb;
> +
> +    fill_h(buf_a, ARITH_A + ARITH_B);
> +    fill_h(buf_b, ARITH_B);
> +
> +    la = Q6_L_tmp_mem_A(buf_a);
> +    lb = Q6_L_tmp_mem_A(buf_b);
> +    Q6_mem_Ku16_new_AL(buf_out, Q6_Lh_sub_LhLh(la, lb));
> +
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        expected[i] = ARITH_A;
> +    }
> +    check_h("LX_sub_h", buf_out, expected, HLX_HALF_ELEMS);
> +}
> +
> +static void test_sub_h_sat(void)
> +{
> +    HLX_Vector la;
> +    HLX_Vector lb;
> +
> +    fill_h(buf_a, NEAR_INT16_MIN);
> +    fill_h(buf_b, SAT_STEP);
> +
> +    la = Q6_L_tmp_mem_A(buf_a);
> +    lb = Q6_L_tmp_mem_A(buf_b);
> +    Q6_mem_Ku16_new_AL(buf_out, Q6_Lh_sub_LhLh_sat(la, lb));
> +
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        expected[i] = (uint16_t)sat_h((int32_t)NEAR_INT16_MIN - SAT_STEP);
> +    }
> +    check_h("LX_sub_h_sat", buf_out, expected, HLX_HALF_ELEMS);
> +}
> +
> +static void test_sub_uh_sat(void)
> +{
> +    HLX_Vector la;
> +    HLX_Vector lb;
> +
> +    fill_h(buf_a, ARITH_A);
> +    fill_h(buf_b, ARITH_B);
> +
> +    la = Q6_L_tmp_mem_A(buf_a);
> +    lb = Q6_L_tmp_mem_A(buf_b);
> +    Q6_mem_Ku16_new_AL(buf_out, Q6_Luh_sub_LuhLuh_sat(la, lb));
> +
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        expected[i] = sat_uh((int32_t)ARITH_A - ARITH_B);
> +    }
> +    check_h("LX_sub_uh_sat", buf_out, expected, HLX_HALF_ELEMS);
> +}
> +
> +static void test_sub_uhh_sat(void)
> +{
> +    HLX_Vector la;
> +    HLX_Vector lb;
> +
> +    fill_h(buf_a, -ARITH_A);
> +    fill_h(buf_b, ARITH_B);
> +
> +    la = Q6_L_tmp_mem_A(buf_a);
> +    lb = Q6_L_tmp_mem_A(buf_b);
> +    Q6_mem_Ku16_new_AL(buf_out, Q6_Luh_sub_LhLh_sat(la, lb));
> +
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        expected[i] = sat_uh((int32_t)-ARITH_A - ARITH_B);
> +    }
> +    check_h("LX_sub_uhh_sat", buf_out, expected, HLX_HALF_ELEMS);
> +}
> +
> +int main(void)
> +{
> +    init_vtcm();
> +    enable_hlx();
> +
> +    buf_a = vtcm_alloc(HLX_HALF_ELEMS * sizeof(uint16_t));
> +    buf_b = vtcm_alloc(HLX_HALF_ELEMS * sizeof(uint16_t));
> +    buf_out = vtcm_alloc(HLX_HALF_ELEMS * sizeof(uint16_t));
> +    init_hlx_vsp();
> +
> +    test_add_h();
> +    test_add_h_sat();
> +    test_add_uh_sat();
> +    test_add_uhh_sat();
> +    test_sub_h();
> +    test_sub_h_sat();
> +    test_sub_uh_sat();
> +    test_sub_uhh_sat();
> +
> +    puts(err ? "FAIL" : "PASS");
> +    return err;
> +}
> diff --git a/tests/tcg/hexagon/hlx_arith_w.c b/tests/tcg/hexagon/hlx_arith_w.c
> new file mode 100644
> index 0000000000..ad1b4bcfca
> --- /dev/null
> +++ b/tests/tcg/hexagon/hlx_arith_w.c
> @@ -0,0 +1,695 @@
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "hlx_test.h"
> +
> +#define WORD_A           1000
> +#define WORD_B           2000
> +#define NEAR_INT32_MAX   0x7FFFFF00
> +#define NEAR_INT32_MIN   ((int32_t)0x80000100)
> +#define NEAR_UINT32_MAX  0xFFFFFF00u
> +#define SAT_STEP_W       256
> +#define HALF_A           100
> +#define HALF_B           200
> +#define PAIRED_A_LO      ((int16_t)300)
> +#define PAIRED_A_HI      ((int16_t)500)
> +#define PAIRED_B_LO      ((int16_t)700)
> +#define PAIRED_B_HI      ((int16_t)900)
> +#define PAIRED_SAT_A     ((int16_t)0x7F00)
> +#define PAIRED_SAT_B     ((int16_t)1)
> +
> +static uint32_t *pw_a_lo;
> +static uint32_t *pw_a_hi;
> +static uint32_t *pw_b_lo;
> +static uint32_t *pw_b_hi;
> +static uint32_t *pw_out_lo;
> +static uint32_t *pw_out_hi;
> +static uint32_t expected_w[HLX_HALF_ELEMS];
> +
> +static uint16_t *buf_a;
> +static uint16_t *buf_b;
> +
> +
> +static void fill_h(uint16_t *buf, int16_t val)
> +{
> +    Q6_mem_Ku16_new_AL(buf, Q6_Lh_equals_Rh(val));
> +}
> +
> +static void fill_w(uint32_t *buf_lo, uint32_t *buf_hi, int32_t val)
> +{
> +    HLX_VectorPair wp = Q6_LWw_equals_Rw(val);
> +    Q6_mem_Ku16_new_AL((uint16_t *)buf_lo, Q6_L_lo_LW(wp));
> +    Q6_mem_Ku16_new_AL((uint16_t *)buf_hi, Q6_L_hi_LW(wp));
> +}
> +
> +/* Helper: pack two halfwords into a word */
> +static inline uint32_t pack_h(uint16_t lo, uint16_t hi)
> +{
> +    return ((uint32_t)hi << 16) | lo;
> +}
> +
> +
> +static void test_add_w(void)
> +{
> +    HLX_VectorPair pa;
> +    HLX_VectorPair pb;
> +    HLX_VectorPair pc;
> +
> +    fill_w(pw_a_lo, pw_a_hi, WORD_A);
> +    fill_w(pw_b_lo, pw_b_hi, WORD_B);
> +
> +    pa = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_a_hi),
> +                          Q6_L_tmp_mem_A(pw_a_lo));
> +    pb = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_b_hi),
> +                          Q6_L_tmp_mem_A(pw_b_lo));
> +    pc = Q6_LWw_add_LWwLWw(pa, pb);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(pc));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(pc));
> +
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected_w[j] = (uint32_t)((int32_t)WORD_A + (int32_t)WORD_B);
> +    }
> +    check_wp("LX_add_w", pw_out_lo, pw_out_hi, expected_w, HLX_HALF_ELEMS);
> +}
> +
> +static void test_add_w_sat(void)
> +{
> +    HLX_VectorPair pa;
> +    HLX_VectorPair pb;
> +    HLX_VectorPair pc;
> +
> +    fill_w(pw_a_lo, pw_a_hi, NEAR_INT32_MAX);
> +    fill_w(pw_b_lo, pw_b_hi, SAT_STEP_W);
> +
> +    pa = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_a_hi),
> +                          Q6_L_tmp_mem_A(pw_a_lo));
> +    pb = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_b_hi),
> +                          Q6_L_tmp_mem_A(pw_b_lo));
> +    pc = Q6_LWw_add_LWwLWw_sat(pa, pb);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(pc));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(pc));
> +
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected_w[j] = (uint32_t)sat_w((int64_t)NEAR_INT32_MAX +
> +                                        (int64_t)SAT_STEP_W);
> +    }
> +    check_wp("LX_add_w_sat", pw_out_lo, pw_out_hi, expected_w, HLX_HALF_ELEMS);
> +}
> +
> +static void test_add_uw_sat(void)
> +{
> +    HLX_VectorPair pa;
> +    HLX_VectorPair pb;
> +    HLX_VectorPair pc;
> +
> +    fill_w(pw_a_lo, pw_a_hi, (int32_t)NEAR_UINT32_MAX);
> +    fill_w(pw_b_lo, pw_b_hi, SAT_STEP_W);
> +
> +    pa = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_a_hi),
> +                          Q6_L_tmp_mem_A(pw_a_lo));
> +    pb = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_b_hi),
> +                          Q6_L_tmp_mem_A(pw_b_lo));
> +    pc = Q6_LWuw_add_LWuwLWuw_sat(pa, pb);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(pc));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(pc));
> +
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        int64_t sum = (int64_t)(uint64_t)NEAR_UINT32_MAX +
> +                      (int64_t)(uint64_t)SAT_STEP_W;
> +        expected_w[j] = sat_uw(sum);
> +    }
> +    check_wp("LX_add_uw_sat", pw_out_lo, pw_out_hi, expected_w, HLX_HALF_ELEMS);
> +}
> +
> +static void test_add_uw_w_sat(void)
> +{
> +    HLX_VectorPair pa;
> +    HLX_VectorPair pb;
> +    HLX_VectorPair pc;
> +
> +    fill_w(pw_a_lo, pw_a_hi, WORD_A);
> +    fill_w(pw_b_lo, pw_b_hi, WORD_B);
> +
> +    pa = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_a_hi),
> +                          Q6_L_tmp_mem_A(pw_a_lo));
> +    pb = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_b_hi),
> +                          Q6_L_tmp_mem_A(pw_b_lo));
> +    pc = Q6_LWuw_add_LWwLWw_sat(pa, pb);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(pc));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(pc));
> +
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        int64_t sum = (int64_t)(int32_t)WORD_A +
> +                      (int64_t)(int32_t)WORD_B;
> +        expected_w[j] = sat_uw(sum);
> +    }
> +    check_wp("LX_add_uw_w_sat", pw_out_lo, pw_out_hi,
> +             expected_w, HLX_HALF_ELEMS);
> +}
> +
> +static void test_sub_w(void)
> +{
> +    HLX_VectorPair pa;
> +    HLX_VectorPair pb;
> +    HLX_VectorPair pc;
> +
> +    fill_w(pw_a_lo, pw_a_hi, WORD_A);
> +    fill_w(pw_b_lo, pw_b_hi, WORD_B);
> +
> +    pa = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_a_hi),
> +                          Q6_L_tmp_mem_A(pw_a_lo));
> +    pb = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_b_hi),
> +                          Q6_L_tmp_mem_A(pw_b_lo));
> +    pc = Q6_LWw_sub_LWwLWw(pa, pb);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(pc));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(pc));
> +
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected_w[j] = (uint32_t)((int32_t)WORD_A - (int32_t)WORD_B);
> +    }
> +    check_wp("LX_sub_w", pw_out_lo, pw_out_hi, expected_w, HLX_HALF_ELEMS);
> +}
> +
> +static void test_sub_w_sat(void)
> +{
> +    HLX_VectorPair pa;
> +    HLX_VectorPair pb;
> +    HLX_VectorPair pc;
> +
> +    fill_w(pw_a_lo, pw_a_hi, NEAR_INT32_MIN);
> +    fill_w(pw_b_lo, pw_b_hi, SAT_STEP_W);
> +
> +    pa = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_a_hi),
> +                          Q6_L_tmp_mem_A(pw_a_lo));
> +    pb = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_b_hi),
> +                          Q6_L_tmp_mem_A(pw_b_lo));
> +    pc = Q6_LWw_sub_LWwLWw_sat(pa, pb);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(pc));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(pc));
> +
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected_w[j] = (uint32_t)sat_w((int64_t)NEAR_INT32_MIN -
> +                                        (int64_t)SAT_STEP_W);
> +    }
> +    check_wp("LX_sub_w_sat", pw_out_lo, pw_out_hi, expected_w, HLX_HALF_ELEMS);
> +}
> +
> +static void test_sub_uw_sat(void)
> +{
> +    HLX_VectorPair pa;
> +    HLX_VectorPair pb;
> +    HLX_VectorPair pc;
> +
> +    fill_w(pw_a_lo, pw_a_hi, WORD_A);
> +    fill_w(pw_b_lo, pw_b_hi, WORD_B);
> +
> +    pa = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_a_hi),
> +                          Q6_L_tmp_mem_A(pw_a_lo));
> +    pb = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_b_hi),
> +                          Q6_L_tmp_mem_A(pw_b_lo));
> +    pc = Q6_LWuw_sub_LWuwLWuw_sat(pa, pb);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(pc));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(pc));
> +
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        int64_t diff = (int64_t)(uint64_t)(uint32_t)WORD_A -
> +                       (int64_t)(uint64_t)(uint32_t)WORD_B;
> +        expected_w[j] = sat_uw(diff);
> +    }
> +    check_wp("LX_sub_uw_sat", pw_out_lo, pw_out_hi, expected_w, HLX_HALF_ELEMS);
> +}
> +
> +static void test_sub_uw_w_sat(void)
> +{
> +    HLX_VectorPair pa;
> +    HLX_VectorPair pb;
> +    HLX_VectorPair pc;
> +
> +    fill_w(pw_a_lo, pw_a_hi, WORD_A);
> +    fill_w(pw_b_lo, pw_b_hi, WORD_B);
> +
> +    pa = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_a_hi),
> +                          Q6_L_tmp_mem_A(pw_a_lo));
> +    pb = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_b_hi),
> +                          Q6_L_tmp_mem_A(pw_b_lo));
> +    pc = Q6_LWuw_sub_LWwLWw_sat(pa, pb);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(pc));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(pc));
> +
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        int64_t diff = (int64_t)(int32_t)WORD_A -
> +                       (int64_t)(int32_t)WORD_B;
> +        expected_w[j] = sat_uw(diff);
> +    }
> +    check_wp("LX_sub_uw_w_sat", pw_out_lo, pw_out_hi,
> +             expected_w, HLX_HALF_ELEMS);
> +}
> +
> +
> +static void test_add_wwh(void)
> +{
> +    HLX_VectorPair pa;
> +    HLX_Vector la;
> +    HLX_VectorPair pc;
> +
> +    fill_w(pw_a_lo, pw_a_hi, WORD_A);
> +    fill_h(buf_a, HALF_A);
> +
> +    pa = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_a_hi),
> +                          Q6_L_tmp_mem_A(pw_a_lo));
> +    la = Q6_L_tmp_mem_A(buf_a);
> +    pc = Q6_LWw_add_LWwLh(pa, la);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(pc));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(pc));
> +
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected_w[j] = (uint32_t)((int32_t)WORD_A + (int32_t)HALF_A);
> +    }
> +    check_wp("LX_add_wwh", pw_out_lo, pw_out_hi, expected_w, HLX_HALF_ELEMS);
> +}
> +
> +static void test_add_wwuh(void)
> +{
> +    HLX_VectorPair pa;
> +    HLX_Vector la;
> +    HLX_VectorPair pc;
> +
> +    fill_w(pw_a_lo, pw_a_hi, WORD_A);
> +    fill_h(buf_a, HALF_A);
> +
> +    pa = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_a_hi),
> +                          Q6_L_tmp_mem_A(pw_a_lo));
> +    la = Q6_L_tmp_mem_A(buf_a);
> +    pc = Q6_LWw_add_LWwLuh(pa, la);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(pc));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(pc));
> +
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected_w[j] = (uint32_t)((int32_t)WORD_A +
> +                                   (int32_t)(uint32_t)(uint16_t)HALF_A);
> +    }
> +    check_wp("LX_add_wwuh", pw_out_lo, pw_out_hi, expected_w, HLX_HALF_ELEMS);
> +}
> +
> +static void test_sub_wwh(void)
> +{
> +    HLX_VectorPair pa;
> +    HLX_Vector la;
> +    HLX_VectorPair pc;
> +
> +    fill_w(pw_a_lo, pw_a_hi, WORD_A);
> +    fill_h(buf_a, HALF_A);
> +
> +    pa = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_a_hi),
> +                          Q6_L_tmp_mem_A(pw_a_lo));
> +    la = Q6_L_tmp_mem_A(buf_a);
> +    pc = Q6_LWw_sub_LWwLh(pa, la);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(pc));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(pc));
> +
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected_w[j] = (uint32_t)((int32_t)WORD_A - (int32_t)HALF_A);
> +    }
> +    check_wp("LX_sub_wwh", pw_out_lo, pw_out_hi, expected_w, HLX_HALF_ELEMS);
> +}
> +
> +static void test_sub_wwuh(void)
> +{
> +    HLX_VectorPair pa;
> +    HLX_Vector la;
> +    HLX_VectorPair pc;
> +
> +    fill_w(pw_a_lo, pw_a_hi, WORD_A);
> +    fill_h(buf_a, HALF_A);
> +
> +    pa = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_a_hi),
> +                          Q6_L_tmp_mem_A(pw_a_lo));
> +    la = Q6_L_tmp_mem_A(buf_a);
> +    pc = Q6_LWw_sub_LWwLuh(pa, la);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(pc));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(pc));
> +
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected_w[j] = (uint32_t)((int32_t)WORD_A -
> +                                   (int32_t)(uint32_t)(uint16_t)HALF_A);
> +    }
> +    check_wp("LX_sub_wwuh", pw_out_lo, pw_out_hi, expected_w, HLX_HALF_ELEMS);
> +}
> +
> +
> +static void test_add_wuh(void)
> +{
> +    HLX_Vector la;
> +    HLX_Vector lb;
> +    HLX_VectorPair pc;
> +
> +    fill_h(buf_a, HALF_A);
> +    fill_h(buf_b, HALF_B);
> +
> +    la = Q6_L_tmp_mem_A(buf_a);
> +    lb = Q6_L_tmp_mem_A(buf_b);
> +    pc = Q6_LWw_add_LuhLuh(la, lb);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(pc));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(pc));
> +
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected_w[j] = (uint32_t)(uint16_t)HALF_A +
> +                        (uint32_t)(uint16_t)HALF_B;
> +    }
> +    check_wp("LX_add_wuh", pw_out_lo, pw_out_hi, expected_w, HLX_HALF_ELEMS);
> +}
> +
> +static void test_sub_wuh(void)
> +{
> +    HLX_Vector la;
> +    HLX_Vector lb;
> +    HLX_VectorPair pc;
> +
> +    fill_h(buf_a, HALF_B);
> +    fill_h(buf_b, HALF_A);
> +
> +    la = Q6_L_tmp_mem_A(buf_a);
> +    lb = Q6_L_tmp_mem_A(buf_b);
> +    pc = Q6_LWw_sub_LuhLuh(la, lb);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(pc));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(pc));
> +
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected_w[j] = (uint32_t)((int32_t)(uint32_t)(uint16_t)HALF_B -
> +                                   (int32_t)(uint32_t)(uint16_t)HALF_A);
> +    }
> +    check_wp("LX_sub_wuh", pw_out_lo, pw_out_hi, expected_w, HLX_HALF_ELEMS);
> +}
> +
> +
> +static void test_add_hp(void)
> +{
> +    HLX_VectorPair pa;
> +    HLX_VectorPair pb;
> +    HLX_VectorPair pc;
> +    uint16_t elo;
> +    uint16_t ehi;
> +
> +    fill_w(pw_a_lo, pw_a_hi,
> +           (int32_t)pack_h((uint16_t)PAIRED_A_LO,
> +                           (uint16_t)PAIRED_A_HI));
> +    fill_w(pw_b_lo, pw_b_hi,
> +           (int32_t)pack_h((uint16_t)PAIRED_B_LO,
> +                           (uint16_t)PAIRED_B_HI));
> +
> +    pa = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_a_hi),
> +                          Q6_L_tmp_mem_A(pw_a_lo));
> +    pb = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_b_hi),
> +                          Q6_L_tmp_mem_A(pw_b_lo));
> +    pc = Q6_LWh_add_LWhLWh(pa, pb);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(pc));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(pc));
> +
> +    elo = (uint16_t)((int16_t)PAIRED_A_LO + (int16_t)PAIRED_B_LO);
> +    ehi = (uint16_t)((int16_t)PAIRED_A_HI + (int16_t)PAIRED_B_HI);
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected_w[j] = pack_h(elo, ehi);
> +    }
> +    check_wp("LX_add_hp", pw_out_lo, pw_out_hi, expected_w, HLX_HALF_ELEMS);
> +}
> +
> +static void test_add_hp_sat(void)
> +{
> +    HLX_VectorPair pa;
> +    HLX_VectorPair pb;
> +    HLX_VectorPair pc;
> +    uint16_t elo;
> +    uint16_t ehi;
> +
> +    fill_w(pw_a_lo, pw_a_hi,
> +           (int32_t)pack_h((uint16_t)PAIRED_SAT_A,
> +                           (uint16_t)PAIRED_SAT_A));
> +    fill_w(pw_b_lo, pw_b_hi,
> +           (int32_t)pack_h((uint16_t)PAIRED_SAT_B,
> +                           (uint16_t)PAIRED_SAT_B));
> +
> +    pa = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_a_hi),
> +                          Q6_L_tmp_mem_A(pw_a_lo));
> +    pb = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_b_hi),
> +                          Q6_L_tmp_mem_A(pw_b_lo));
> +    pc = Q6_LWh_add_LWhLWh_sat(pa, pb);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(pc));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(pc));
> +
> +    elo = (uint16_t)sat_h((int32_t)PAIRED_SAT_A
> +                           + (int32_t)PAIRED_SAT_B);
> +    ehi = (uint16_t)sat_h((int32_t)PAIRED_SAT_A
> +                           + (int32_t)PAIRED_SAT_B);
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected_w[j] = pack_h(elo, ehi);
> +    }
> +    check_wp("LX_add_hp_sat", pw_out_lo, pw_out_hi,
> +             expected_w, HLX_HALF_ELEMS);
> +}
> +
> +static void test_add_uhp_sat(void)
> +{
> +    HLX_VectorPair pa;
> +    HLX_VectorPair pb;
> +    HLX_VectorPair pc;
> +    uint16_t elo;
> +    uint16_t ehi;
> +
> +    fill_w(pw_a_lo, pw_a_hi,
> +           (int32_t)pack_h((uint16_t)PAIRED_SAT_A,
> +                           (uint16_t)PAIRED_SAT_A));
> +    fill_w(pw_b_lo, pw_b_hi,
> +           (int32_t)pack_h((uint16_t)PAIRED_SAT_B,
> +                           (uint16_t)PAIRED_SAT_B));
> +
> +    pa = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_a_hi),
> +                          Q6_L_tmp_mem_A(pw_a_lo));
> +    pb = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_b_hi),
> +                          Q6_L_tmp_mem_A(pw_b_lo));
> +    pc = Q6_LWuh_add_LWuhLWuh_sat(pa, pb);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(pc));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(pc));
> +
> +    elo = sat_uh((int32_t)(uint16_t)PAIRED_SAT_A +
> +                 (int32_t)(uint16_t)PAIRED_SAT_B);
> +    ehi = sat_uh((int32_t)(uint16_t)PAIRED_SAT_A +
> +                 (int32_t)(uint16_t)PAIRED_SAT_B);
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected_w[j] = pack_h(elo, ehi);
> +    }
> +    check_wp("LX_add_uhp_sat", pw_out_lo, pw_out_hi,
> +             expected_w, HLX_HALF_ELEMS);
> +}
> +
> +static void test_add_uhp_h_sat(void)
> +{
> +    HLX_VectorPair pa;
> +    HLX_VectorPair pb;
> +    HLX_VectorPair pc;
> +    uint16_t elo;
> +    uint16_t ehi;
> +
> +    fill_w(pw_a_lo, pw_a_hi,
> +           (int32_t)pack_h((uint16_t)PAIRED_A_LO,
> +                           (uint16_t)PAIRED_A_HI));
> +    fill_w(pw_b_lo, pw_b_hi,
> +           (int32_t)pack_h((uint16_t)PAIRED_B_LO,
> +                           (uint16_t)PAIRED_B_HI));
> +
> +    pa = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_a_hi),
> +                          Q6_L_tmp_mem_A(pw_a_lo));
> +    pb = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_b_hi),
> +                          Q6_L_tmp_mem_A(pw_b_lo));
> +    pc = Q6_LWuh_add_LWhLWh_sat(pa, pb);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(pc));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(pc));
> +
> +    elo = sat_uh((int32_t)PAIRED_A_LO + (int32_t)PAIRED_B_LO);
> +    ehi = sat_uh((int32_t)PAIRED_A_HI + (int32_t)PAIRED_B_HI);
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected_w[j] = pack_h(elo, ehi);
> +    }
> +    check_wp("LX_add_uhp_h_sat", pw_out_lo, pw_out_hi,
> +             expected_w, HLX_HALF_ELEMS);
> +}
> +
> +static void test_sub_hp(void)
> +{
> +    HLX_VectorPair pa;
> +    HLX_VectorPair pb;
> +    HLX_VectorPair pc;
> +    uint16_t elo;
> +    uint16_t ehi;
> +
> +    fill_w(pw_a_lo, pw_a_hi,
> +           (int32_t)pack_h((uint16_t)PAIRED_A_LO,
> +                           (uint16_t)PAIRED_A_HI));
> +    fill_w(pw_b_lo, pw_b_hi,
> +           (int32_t)pack_h((uint16_t)PAIRED_B_LO,
> +                           (uint16_t)PAIRED_B_HI));
> +
> +    pa = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_a_hi),
> +                          Q6_L_tmp_mem_A(pw_a_lo));
> +    pb = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_b_hi),
> +                          Q6_L_tmp_mem_A(pw_b_lo));
> +    pc = Q6_LWh_sub_LWhLWh(pa, pb);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(pc));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(pc));
> +
> +    elo = (uint16_t)((int16_t)PAIRED_A_LO - (int16_t)PAIRED_B_LO);
> +    ehi = (uint16_t)((int16_t)PAIRED_A_HI - (int16_t)PAIRED_B_HI);
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected_w[j] = pack_h(elo, ehi);
> +    }
> +    check_wp("LX_sub_hp", pw_out_lo, pw_out_hi, expected_w, HLX_HALF_ELEMS);
> +}
> +
> +static void test_sub_hp_sat(void)
> +{
> +    HLX_VectorPair pa;
> +    HLX_VectorPair pb;
> +    HLX_VectorPair pc;
> +    uint16_t elo;
> +    uint16_t ehi;
> +
> +    fill_w(pw_a_lo, pw_a_hi,
> +           (int32_t)pack_h((uint16_t)PAIRED_SAT_A,
> +                           (uint16_t)PAIRED_SAT_A));
> +    fill_w(pw_b_lo, pw_b_hi,
> +           (int32_t)pack_h((uint16_t)PAIRED_SAT_B,
> +                           (uint16_t)PAIRED_SAT_B));
> +
> +    pa = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_a_hi),
> +                          Q6_L_tmp_mem_A(pw_a_lo));
> +    pb = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_b_hi),
> +                          Q6_L_tmp_mem_A(pw_b_lo));
> +    pc = Q6_LWh_sub_LWhLWh_sat(pa, pb);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(pc));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(pc));
> +
> +    elo = (uint16_t)sat_h((int32_t)PAIRED_SAT_A
> +                           - (int32_t)PAIRED_SAT_B);
> +    ehi = (uint16_t)sat_h((int32_t)PAIRED_SAT_A
> +                           - (int32_t)PAIRED_SAT_B);
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected_w[j] = pack_h(elo, ehi);
> +    }
> +    check_wp("LX_sub_hp_sat", pw_out_lo, pw_out_hi, expected_w, HLX_HALF_ELEMS);
> +}
> +
> +static void test_sub_uhp_sat(void)
> +{
> +    HLX_VectorPair pa;
> +    HLX_VectorPair pb;
> +    HLX_VectorPair pc;
> +    uint16_t elo;
> +    uint16_t ehi;
> +
> +    fill_w(pw_a_lo, pw_a_hi,
> +           (int32_t)pack_h((uint16_t)PAIRED_SAT_A,
> +                           (uint16_t)PAIRED_SAT_A));
> +    fill_w(pw_b_lo, pw_b_hi,
> +           (int32_t)pack_h((uint16_t)PAIRED_SAT_B,
> +                           (uint16_t)PAIRED_SAT_B));
> +
> +    pa = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_a_hi),
> +                          Q6_L_tmp_mem_A(pw_a_lo));
> +    pb = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_b_hi),
> +                          Q6_L_tmp_mem_A(pw_b_lo));
> +    pc = Q6_LWuh_sub_LWuhLWuh_sat(pa, pb);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(pc));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(pc));
> +
> +    elo = sat_uh((int32_t)(uint16_t)PAIRED_SAT_A -
> +                 (int32_t)(uint16_t)PAIRED_SAT_B);
> +    ehi = sat_uh((int32_t)(uint16_t)PAIRED_SAT_A -
> +                 (int32_t)(uint16_t)PAIRED_SAT_B);
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected_w[j] = pack_h(elo, ehi);
> +    }
> +    check_wp("LX_sub_uhp_sat", pw_out_lo, pw_out_hi,
> +             expected_w, HLX_HALF_ELEMS);
> +}
> +
> +static void test_sub_uhp_h_sat(void)
> +{
> +    HLX_VectorPair pa;
> +    HLX_VectorPair pb;
> +    HLX_VectorPair pc;
> +    uint16_t elo;
> +    uint16_t ehi;
> +
> +    fill_w(pw_a_lo, pw_a_hi,
> +           (int32_t)pack_h((uint16_t)PAIRED_A_LO,
> +                           (uint16_t)PAIRED_A_HI));
> +    fill_w(pw_b_lo, pw_b_hi,
> +           (int32_t)pack_h((uint16_t)PAIRED_B_LO,
> +                           (uint16_t)PAIRED_B_HI));
> +
> +    pa = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_a_hi),
> +                          Q6_L_tmp_mem_A(pw_a_lo));
> +    pb = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_b_hi),
> +                          Q6_L_tmp_mem_A(pw_b_lo));
> +    pc = Q6_LWuh_sub_LWhLWh_sat(pa, pb);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(pc));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(pc));
> +
> +    elo = sat_uh((int32_t)PAIRED_A_LO - (int32_t)PAIRED_B_LO);
> +    ehi = sat_uh((int32_t)PAIRED_A_HI - (int32_t)PAIRED_B_HI);
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected_w[j] = pack_h(elo, ehi);
> +    }
> +    check_wp("LX_sub_uhp_h_sat", pw_out_lo, pw_out_hi,
> +             expected_w, HLX_HALF_ELEMS);
> +}
> +
> +int main(void)
> +{
> +    init_vtcm();
> +    enable_hlx();
> +
> +    pw_a_lo = vtcm_alloc(HLX_WORD_ELEMS * sizeof(uint32_t));
> +    pw_a_hi = vtcm_alloc(HLX_WORD_ELEMS * sizeof(uint32_t));
> +    pw_b_lo = vtcm_alloc(HLX_WORD_ELEMS * sizeof(uint32_t));
> +    pw_b_hi = vtcm_alloc(HLX_WORD_ELEMS * sizeof(uint32_t));
> +    pw_out_lo = vtcm_alloc(HLX_WORD_ELEMS * sizeof(uint32_t));
> +    pw_out_hi = vtcm_alloc(HLX_WORD_ELEMS * sizeof(uint32_t));
> +    buf_a = vtcm_alloc(HLX_HALF_ELEMS * sizeof(uint16_t));
> +    buf_b = vtcm_alloc(HLX_HALF_ELEMS * sizeof(uint16_t));
> +    init_hlx_vsp();
> +
> +    /* Pair-pair word operations */
> +    test_add_w();
> +    test_add_w_sat();
> +    test_add_uw_sat();
> +    test_add_uw_w_sat();
> +    test_sub_w();
> +    test_sub_w_sat();
> +    test_sub_uw_sat();
> +    test_sub_uw_w_sat();
> +
> +    /* Mixed word+half operations */
> +    test_add_wwh();
> +    test_add_wwuh();
> +    test_sub_wwh();
> +    test_sub_wwuh();
> +
> +    /* Widening operations */
> +    test_add_wuh();
> +    test_sub_wuh();
> +
> +    /* Paired halfword operations */
> +    test_add_hp();
> +    test_add_hp_sat();
> +    test_add_uhp_sat();
> +    test_add_uhp_h_sat();
> +    test_sub_hp();
> +    test_sub_hp_sat();
> +    test_sub_uhp_sat();
> +    test_sub_uhp_h_sat();
> +
> +    puts(err ? "FAIL" : "PASS");
> +    return err;
> +}
> diff --git a/tests/tcg/hexagon/hlx_asm.h b/tests/tcg/hexagon/hlx_asm.h
> new file mode 100644
> index 0000000000..7fd7f74e73
> --- /dev/null
> +++ b/tests/tcg/hexagon/hlx_asm.h
> @@ -0,0 +1,2286 @@
> +/*
> + * HLX intrinsics encoded with .word directives
> + *
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +/*
> + * Stand-ins for the HLX intrinsics of hlx_hexagon_protos.h, for toolchains
> + * that cannot assemble v85 or HLX.  Every instruction is a pre-encoded
> + * packet emitted with .word, like the v85 instructions of atomics.c.
> + *
> + * The compiler does not know about the L registers, so an HLX_Vector is
> + * the 2KB contents of one and every intrinsic is self-contained: it copies
> + * its operands to a 2KB-aligned staging area, loads them into fixed L
> + * registers, executes the instruction and stores the result back to the
> + * staging area.  The loads and stores therefore use HLX memory accesses
> + * too, and the intrinsics are not reentrant.
> + *
> + * Register assignment:
> + *   Lu = L0, Luu = L1:0   Lv = L2, Lvv = L3:2   Lx = L4, Lxx = L5:4
> + *   Ld = L6, Ldd = L7:6   Rt = r10, Rtt = r13:12
> + *   r0..r7 address the staging slots, r9 holds a user address.
> + *
> + * The packets were assembled with the Hexagon SDK 21.0.04 assembler
> + *   hexagon-llvm-mc -mcpu=hexagonv85 -mattr=+hlx
> + * from the "Assembly Syntax" of each intrinsic, shown in the comments.
> + * Immediates are patched into the packet in the assembler.
> + */
> +
> +#ifndef HLX_ASM_H
> +#define HLX_ASM_H
> +
> +#include <stdint.h>
> +#include <string.h>
> +
> +#define HLX_ASM_VEC_BYTES 2048
> +
> +typedef struct {
> +    uint16_t h[HLX_ASM_VEC_BYTES / sizeof(uint16_t)];
> +} HLX_Vector;
> +
> +typedef struct {
> +    HLX_Vector lo;
> +    HLX_Vector hi;
> +} HLX_VectorPair;
> +
> +/* Operand slots: u0 u1 v0 v1 x0 x1 d0 d1, then the scalar operands. */
> +struct hlx_scalars {
> +    uint32_t rt;
> +    uint32_t pad;
> +    uint64_t rtt;
> +    uint32_t addr;
> +};
> +
> +#define HLX_ASM_SCALARS_OFFSET (8 * HLX_ASM_VEC_BYTES)
> +
> +#define HLX_ASM_STAGE_BYTES (HLX_ASM_SCALARS_OFFSET + HLX_ASM_VEC_BYTES)
> +
> +/*
> + * The staging area is BSS by default.  Tests that need the HLX memory
> + * accesses to go to VTCM point hlx_stage at a VTCM allocation instead.
> + */
> +static uint8_t hlx_stage_bss[HLX_ASM_STAGE_BYTES]
> +    __attribute__((aligned(HLX_ASM_VEC_BYTES), unused));
> +static uint8_t *hlx_stage __attribute__((unused)) = hlx_stage_bss;
> +
> +#define HLX_SCALARS \
> +    ((struct hlx_scalars *)(hlx_stage + HLX_ASM_SCALARS_OFFSET))
> +
> +static inline void hlx_put_v(int slot, HLX_Vector v)
> +{
> +    memcpy(hlx_stage + slot * HLX_ASM_VEC_BYTES, &v, sizeof(v));
> +}
> +
> +static inline void hlx_put_vp(int slot, HLX_VectorPair v)
> +{
> +    hlx_put_v(slot, v.lo);
> +    hlx_put_v(slot + 1, v.hi);
> +}
> +
> +static inline HLX_Vector hlx_get_v(int slot)
> +{
> +    HLX_Vector v;
> +
> +    memcpy(&v, hlx_stage + slot * HLX_ASM_VEC_BYTES, sizeof(v));
> +    return v;
> +}
> +
> +static inline HLX_VectorPair hlx_get_vp(int slot)
> +{
> +    HLX_VectorPair v = { hlx_get_v(slot), hlx_get_v(slot + 1) };
> +
> +    return v;
> +}
> +
> +/* Place the low @bits of @imm at bit @pos of an instruction word. */
> +#define HLX_IMM(imm, bits, pos) (((imm) & ((1 << (bits)) - 1)) << (pos))
> +
> +#define HLX_STR_(x) #x
> +#define HLX_STR(x) HLX_STR_(x)
> +
> +#define HLX_CLOBBERS "r0", "r1", "r2", "r3", "r4", "r5", "r6", "r7", "r8", \
> +                     "r9", "r10", "r12", "r13", "memory"
> +
> +/* r0..r7 = staging slots, r9 = user address, r10 = Rt, r13:12 = Rtt */
> +#define HLX_PTRS \
> +    "r0 = %[stage]\n" \
> +    "r1 = add(r0, #2048)\n" \
> +    "r2 = add(r0, #4096)\n" \
> +    "r3 = add(r0, #6144)\n" \
> +    "r4 = add(r0, #8192)\n" \
> +    "r5 = add(r0, #10240)\n" \
> +    "r6 = add(r0, #12288)\n" \
> +    "r7 = add(r0, #14336)\n" \
> +    "r8 = add(r0, #16384)\n" \
> +    "r10 = memw(r8 + #0)\n" \
> +    "r13:12 = memd(r8 + #8)\n" \
> +    "r9 = memw(r8 + #16)\n"
> +
> +/* Ln.tmp = mem(rn), copied to Ln within the packet */
> +#define HLX_LD0 \
> +    ".word 0xe5007820\n" \
> +    ".word 0x9800d000\n"
> +
> +#define HLX_LD1 \
> +    ".word 0xe5007862\n" \
> +    ".word 0x9801d001\n"
> +
> +#define HLX_LD2 \
> +    ".word 0xe50078a4\n" \
> +    ".word 0x9802d002\n"
> +
> +#define HLX_LD3 \
> +    ".word 0xe50078e6\n" \
> +    ".word 0x9803d003\n"
> +
> +#define HLX_LD4 \
> +    ".word 0xe5007928\n" \
> +    ".word 0x9804d004\n"
> +
> +#define HLX_LD5 \
> +    ".word 0xe500796a\n" \
> +    ".word 0x9805d005\n"
> +
> +/* mem(rn) = Ln.new */
> +#define HLX_ST4 \
> +    ".word 0xe5007928\n" \
> +    ".word 0xa484c004\n"
> +
> +#define HLX_ST5 \
> +    ".word 0xe500796a\n" \
> +    ".word 0xa485c005\n"
> +
> +#define HLX_ST6 \
> +    ".word 0xe50079ac\n" \
> +    ".word 0xa486c006\n"
> +
> +#define HLX_ST7 \
> +    ".word 0xe50079ee\n" \
> +    ".word 0xa487c007\n"
> +
> +/* L6.tmp = mem(r9), and mem(r9) = L0.new */
> +#define HLX_LD_MEM \
> +    ".word 0xe50079ac\n" \
> +    ".word 0x9809d006\n"
> +
> +#define HLX_ST_MEM \
> +    ".word 0xe5007820\n" \
> +    ".word 0xa489c000\n"
> +
> +/* L6.tmp = mem(Rs32) */
> +static inline HLX_Vector Q6_L_tmp_mem_A(void *base)
> +{
> +    HLX_SCALARS->addr = (uint32_t)(uintptr_t)base;
> +    asm volatile(HLX_PTRS HLX_LD_MEM HLX_ST6
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_v(6);
> +}
> +
> +/* mem(Rs32) = Ku16.new */
> +static inline void Q6_mem_Ku16_new_AL(void *base, HLX_Vector ku)
> +{
> +    hlx_put_v(0, ku);
> +    HLX_SCALARS->addr = (uint32_t)(uintptr_t)base;
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_ST_MEM
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +}
> +
> +/* Ld16 = lo(Luu16) and Ld16 = hi(Luu16) are register renames */
> +static inline HLX_Vector Q6_L_lo_LW(HLX_VectorPair luu)
> +{
> +    return luu.lo;
> +}
> +
> +static inline HLX_Vector Q6_L_hi_LW(HLX_VectorPair luu)
> +{
> +    return luu.hi;
> +}
> +
> +/* Ld16.uh=abs(Lu16.h) */
> +static inline HLX_Vector Q6_Luh_abs_Lh(HLX_Vector lu)
> +{
> +    hlx_put_v(0, lu);
> +    asm volatile(HLX_PTRS HLX_LD0
> +                 ".word 0xe501e82c\n"
> +                 HLX_ST6
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_v(6);
> +}
> +
> +/* Ld16.h=abs(Lu16.h):sat */
> +static inline HLX_Vector Q6_Lh_abs_Lh_sat(HLX_Vector lu)
> +{
> +    hlx_put_v(0, lu);
> +    asm volatile(HLX_PTRS HLX_LD0
> +                 ".word 0xe501e82d\n"
> +                 HLX_ST6
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_v(6);
> +}
> +
> +/* Ldd16.uh=abs(Luu16.h) */
> +static inline HLX_VectorPair Q6_LWuh_abs_LWh(HLX_VectorPair luu)
> +{
> +    hlx_put_vp(0, luu);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD1
> +                 ".word 0xef00f02c\n"
> +                 HLX_ST6 HLX_ST7
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(6);
> +}
> +
> +/* Ldd16.h=abs(Luu16.h):sat */
> +static inline HLX_VectorPair Q6_LWh_abs_LWh_sat(HLX_VectorPair luu)
> +{
> +    hlx_put_vp(0, luu);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD1
> +                 ".word 0xef00f02d\n"
> +                 HLX_ST6 HLX_ST7
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(6);
> +}
> +
> +/* Ldd16.uw=abs(Luu16.w) */
> +static inline HLX_VectorPair Q6_LWuw_abs_LWw(HLX_VectorPair luu)
> +{
> +    hlx_put_vp(0, luu);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD1
> +                 ".word 0xef00f00c\n"
> +                 HLX_ST6 HLX_ST7
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(6);
> +}
> +
> +/* Ldd16.w=abs(Luu16.w):sat */
> +static inline HLX_VectorPair Q6_LWw_abs_LWw_sat(HLX_VectorPair luu)
> +{
> +    hlx_put_vp(0, luu);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD1
> +                 ".word 0xef00f00d\n"
> +                 HLX_ST6 HLX_ST7
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(6);
> +}
> +
> +/* Ld16.uh=absdiff(Lu16.h,Lv16.h) */
> +static inline HLX_Vector Q6_Luh_absdiff_LhLh(HLX_Vector lu, HLX_Vector lv)
> +{
> +    hlx_put_v(0, lu);
> +    hlx_put_v(2, lv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD2
> +                 ".word 0xed04e40c\n"
> +                 HLX_ST6
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_v(6);
> +}
> +
> +/* Ld16.uh=absdiff(Lu16.uh,Lv16.uh) */
> +static inline HLX_Vector Q6_Luh_absdiff_LuhLuh(HLX_Vector lu, HLX_Vector lv)
> +{
> +    hlx_put_v(0, lu);
> +    hlx_put_v(2, lv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD2
> +                 ".word 0xed04e42c\n"
> +                 HLX_ST6
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_v(6);
> +}
> +
> +/* Ldd16.uw=absdiff(Luu16.uw,Lvv16.uw) */
> +static inline HLX_VectorPair
> +Q6_LWuw_absdiff_LWuwLWuw(HLX_VectorPair luu,
> +                         HLX_VectorPair lvv)
> +{
> +    hlx_put_vp(0, luu);
> +    hlx_put_vp(2, lvv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD1 HLX_LD2 HLX_LD3
> +                 ".word 0xed04e42d\n"
> +                 HLX_ST6 HLX_ST7
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(6);
> +}
> +
> +/* Ldd16.uw=absdiff(Luu16.w,Lvv16.w) */
> +static inline HLX_VectorPair
> +Q6_LWuw_absdiff_LWwLWw(HLX_VectorPair luu,
> +                       HLX_VectorPair lvv)
> +{
> +    hlx_put_vp(0, luu);
> +    hlx_put_vp(2, lvv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD1 HLX_LD2 HLX_LD3
> +                 ".word 0xed04e40d\n"
> +                 HLX_ST6 HLX_ST7
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(6);
> +}
> +
> +/* Ld16.h=add(Lu16.h,Lv16.h) */
> +static inline HLX_Vector Q6_Lh_add_LhLh(HLX_Vector lu, HLX_Vector lv)
> +{
> +    hlx_put_v(0, lu);
> +    hlx_put_v(2, lv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD2
> +                 ".word 0xe504ec0c\n"
> +                 HLX_ST6
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_v(6);
> +}
> +
> +/* Ld16.h=add(Lu16.h,Lv16.h):sat */
> +static inline HLX_Vector Q6_Lh_add_LhLh_sat(HLX_Vector lu, HLX_Vector lv)
> +{
> +    hlx_put_v(0, lu);
> +    hlx_put_v(2, lv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD2
> +                 ".word 0xe504ec0d\n"
> +                 HLX_ST6
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_v(6);
> +}
> +
> +/* Ldd16.h=add(Luu16.h,Lvv16.h) */
> +static inline HLX_VectorPair
> +Q6_LWh_add_LWhLWh(HLX_VectorPair luu,
> +                  HLX_VectorPair lvv)
> +{
> +    hlx_put_vp(0, luu);
> +    hlx_put_vp(2, lvv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD1 HLX_LD2 HLX_LD3
> +                 ".word 0xef04e80c\n"
> +                 HLX_ST6 HLX_ST7
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(6);
> +}
> +
> +/* Ldd16.h=add(Luu16.h,Lvv16.h):sat */
> +static inline HLX_VectorPair
> +Q6_LWh_add_LWhLWh_sat(HLX_VectorPair luu,
> +                      HLX_VectorPair lvv)
> +{
> +    hlx_put_vp(0, luu);
> +    hlx_put_vp(2, lvv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD1 HLX_LD2 HLX_LD3
> +                 ".word 0xef04e80d\n"
> +                 HLX_ST6 HLX_ST7
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(6);
> +}
> +
> +/* Ld16.uh=add(Lu16.uh,Lv16.uh):sat */
> +static inline HLX_Vector Q6_Luh_add_LuhLuh_sat(HLX_Vector lu, HLX_Vector lv)
> +{
> +    hlx_put_v(0, lu);
> +    hlx_put_v(2, lv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD2
> +                 ".word 0xe504ec2c\n"
> +                 HLX_ST6
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_v(6);
> +}
> +
> +/* Ld16.uh=add(Lu16.h,Lv16.h):sat */
> +static inline HLX_Vector Q6_Luh_add_LhLh_sat(HLX_Vector lu, HLX_Vector lv)
> +{
> +    hlx_put_v(0, lu);
> +    hlx_put_v(2, lv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD2
> +                 ".word 0xe504ec2d\n"
> +                 HLX_ST6
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_v(6);
> +}
> +
> +/* Ldd16.uh=add(Luu16.h,Lvv16.h):sat */
> +static inline HLX_VectorPair
> +Q6_LWuh_add_LWhLWh_sat(HLX_VectorPair luu,
> +                       HLX_VectorPair lvv)
> +{
> +    hlx_put_vp(0, luu);
> +    hlx_put_vp(2, lvv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD1 HLX_LD2 HLX_LD3
> +                 ".word 0xef04e82d\n"
> +                 HLX_ST6 HLX_ST7
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(6);
> +}
> +
> +/* Ldd16.uh=add(Luu16.uh,Lvv16.uh):sat */
> +static inline HLX_VectorPair
> +Q6_LWuh_add_LWuhLWuh_sat(HLX_VectorPair luu,
> +                         HLX_VectorPair lvv)
> +{
> +    hlx_put_vp(0, luu);
> +    hlx_put_vp(2, lvv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD1 HLX_LD2 HLX_LD3
> +                 ".word 0xef04e82c\n"
> +                 HLX_ST6 HLX_ST7
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(6);
> +}
> +
> +/* Ldd16.uw=add(Luu16.uw,Lvv16.uw):sat */
> +static inline HLX_VectorPair
> +Q6_LWuw_add_LWuwLWuw_sat(HLX_VectorPair luu,
> +                         HLX_VectorPair lvv)
> +{
> +    hlx_put_vp(0, luu);
> +    hlx_put_vp(2, lvv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD1 HLX_LD2 HLX_LD3
> +                 ".word 0xef04e02c\n"
> +                 HLX_ST6 HLX_ST7
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(6);
> +}
> +
> +/* Ldd16.uw=add(Luu16.w,Lvv16.w):sat */
> +static inline HLX_VectorPair
> +Q6_LWuw_add_LWwLWw_sat(HLX_VectorPair luu,
> +                       HLX_VectorPair lvv)
> +{
> +    hlx_put_vp(0, luu);
> +    hlx_put_vp(2, lvv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD1 HLX_LD2 HLX_LD3
> +                 ".word 0xef04e02d\n"
> +                 HLX_ST6 HLX_ST7
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(6);
> +}
> +
> +/* Ldd16.w=add(Luu16.w,Lvv16.w) */
> +static inline HLX_VectorPair
> +Q6_LWw_add_LWwLWw(HLX_VectorPair luu,
> +                  HLX_VectorPair lvv)
> +{
> +    hlx_put_vp(0, luu);
> +    hlx_put_vp(2, lvv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD1 HLX_LD2 HLX_LD3
> +                 ".word 0xef04e00c\n"
> +                 HLX_ST6 HLX_ST7
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(6);
> +}
> +
> +/* Ldd16.w=add(Luu16.w,Lvv16.w):sat */
> +static inline HLX_VectorPair
> +Q6_LWw_add_LWwLWw_sat(HLX_VectorPair luu,
> +                      HLX_VectorPair lvv)
> +{
> +    hlx_put_vp(0, luu);
> +    hlx_put_vp(2, lvv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD1 HLX_LD2 HLX_LD3
> +                 ".word 0xef04e00d\n"
> +                 HLX_ST6 HLX_ST7
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(6);
> +}
> +
> +/* Ldd16.w=add(Lu16.uh,Lv16.uh) */
> +static inline HLX_VectorPair Q6_LWw_add_LuhLuh(HLX_Vector lu, HLX_Vector lv)
> +{
> +    hlx_put_v(0, lu);
> +    hlx_put_v(2, lv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD2
> +                 ".word 0xe524e80c\n"
> +                 HLX_ST6 HLX_ST7
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(6);
> +}
> +
> +/* Ldd16.w=add(Luu16.w,Lv16.h) */
> +static inline HLX_VectorPair
> +Q6_LWw_add_LWwLh(HLX_VectorPair luu,
> +                 HLX_Vector lv)
> +{
> +    hlx_put_vp(0, luu);
> +    hlx_put_v(2, lv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD1 HLX_LD2
> +                 ".word 0xe504fc2c\n"
> +                 HLX_ST6 HLX_ST7
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(6);
> +}
> +
> +/* Ldd16.w=add(Luu16.w,Lv16.uh) */
> +static inline HLX_VectorPair
> +Q6_LWw_add_LWwLuh(HLX_VectorPair luu,
> +                  HLX_Vector lv)
> +{
> +    hlx_put_vp(0, luu);
> +    hlx_put_v(2, lv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD1 HLX_LD2
> +                 ".word 0xe504fc2d\n"
> +                 HLX_ST6 HLX_ST7
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(6);
> +}
> +
> +/* Ld16=and(Lu16,Lv16) */
> +static inline HLX_Vector Q6_L_and_LL(HLX_Vector lu, HLX_Vector lv)
> +{
> +    hlx_put_v(0, lu);
> +    hlx_put_v(2, lv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD2
> +                 ".word 0xe504f40c\n"
> +                 HLX_ST6
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_v(6);
> +}
> +
> +/* Ldd16=and(Luu16,Lvv16) */
> +static inline HLX_VectorPair
> +Q6_LW_and_LWLW(HLX_VectorPair luu,
> +               HLX_VectorPair lvv)
> +{
> +    hlx_put_vp(0, luu);
> +    hlx_put_vp(2, lvv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD1 HLX_LD2 HLX_LD3
> +                 ".word 0xef24e00c\n"
> +                 HLX_ST6 HLX_ST7
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(6);
> +}
> +
> +/* Ld16=andn(Lu16,Lv16) */
> +static inline HLX_Vector Q6_L_andn_LL(HLX_Vector lu, HLX_Vector lv)
> +{
> +    hlx_put_v(0, lu);
> +    hlx_put_v(2, lv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD2
> +                 ".word 0xe504f40d\n"
> +                 HLX_ST6
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_v(6);
> +}
> +
> +/* Ldd16=andn(Luu16,Lvv16) */
> +static inline HLX_VectorPair
> +Q6_LW_andn_LWLW(HLX_VectorPair luu,
> +                HLX_VectorPair lvv)
> +{
> +    hlx_put_vp(0, luu);
> +    hlx_put_vp(2, lvv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD1 HLX_LD2 HLX_LD3
> +                 ".word 0xef24e40c\n"
> +                 HLX_ST6 HLX_ST7
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(6);
> +}
> +
> +/* Ld16.h=Lu16.h */
> +static inline HLX_Vector Q6_Lh_equals_Lh(HLX_Vector lu)
> +{
> +    hlx_put_v(0, lu);
> +    asm volatile(HLX_PTRS HLX_LD0
> +                 ".word 0xe500f82c\n"
> +                 HLX_ST6
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_v(6);
> +}
> +
> +/* Ld16.h=Rt32.h */
> +static inline HLX_Vector Q6_Lh_equals_Rh(uint32_t rt)
> +{
> +    HLX_SCALARS->rt = rt;
> +    asm volatile(HLX_PTRS
> +                 ".word 0xe52ae42c\n"
> +                 HLX_ST6
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_v(6);
> +}
> +
> +/* Ldd16.w=Rt32.w */
> +static inline HLX_VectorPair Q6_LWw_equals_Rw(uint32_t rt)
> +{
> +    HLX_SCALARS->rt = rt;
> +    asm volatile(HLX_PTRS
> +                 ".word 0xe52ae42d\n"
> +                 HLX_ST6 HLX_ST7
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(6);
> +}
> +
> +/* Ld16.h=#s5 */
> +#define Q6_Lh_equals_Is(is5) \
> +    ({ \
> +        asm volatile(HLX_PTRS \
> +                     ".word " HLX_STR(0xe520e82d | HLX_IMM(is5, 5, 16)) "\n" \
> +                     HLX_ST6 \
> +                     : : [stage] "r"(hlx_stage) : HLX_CLOBBERS); \
> +        hlx_get_v(6); \
> +    })
> +
> +/* Ld16.uh=#u5 */
> +#define Q6_Luh_equals_I(iu5) \
> +    ({ \
> +        asm volatile(HLX_PTRS \
> +                     ".word " HLX_STR(0xe520e82c | HLX_IMM(iu5, 5, 16)) "\n" \
> +                     HLX_ST6 \
> +                     : : [stage] "r"(hlx_stage) : HLX_CLOBBERS); \
> +        hlx_get_v(6); \
> +    })
> +
> +/* Ld16.h=avg(Lu16.h,Lv16.h) */
> +static inline HLX_Vector Q6_Lh_avg_LhLh(HLX_Vector lu, HLX_Vector lv)
> +{
> +    hlx_put_v(0, lu);
> +    hlx_put_v(2, lv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD2
> +                 ".word 0xed04e80c\n"
> +                 HLX_ST6
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_v(6);
> +}
> +
> +/* Ld16.h=avg(Lu16.h,Lv16.h):rnd */
> +static inline HLX_Vector Q6_Lh_avg_LhLh_rnd(HLX_Vector lu, HLX_Vector lv)
> +{
> +    hlx_put_v(0, lu);
> +    hlx_put_v(2, lv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD2
> +                 ".word 0xed04ec0c\n"
> +                 HLX_ST6
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_v(6);
> +}
> +
> +/* Ld16.uh=avg(Lu16.uh,Lv16.uh) */
> +static inline HLX_Vector Q6_Luh_avg_LuhLuh(HLX_Vector lu, HLX_Vector lv)
> +{
> +    hlx_put_v(0, lu);
> +    hlx_put_v(2, lv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD2
> +                 ".word 0xed04e82c\n"
> +                 HLX_ST6
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_v(6);
> +}
> +
> +/* Ld16.uh=avg(Lu16.uh,Lv16.uh):rnd */
> +static inline HLX_Vector Q6_Luh_avg_LuhLuh_rnd(HLX_Vector lu, HLX_Vector lv)
> +{
> +    hlx_put_v(0, lu);
> +    hlx_put_v(2, lv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD2
> +                 ".word 0xed04ec2c\n"
> +                 HLX_ST6
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_v(6);
> +}
> +
> +/* Ldd16.uw=avg(Luu16.uw,Lvv16.uw) */
> +static inline HLX_VectorPair
> +Q6_LWuw_avg_LWuwLWuw(HLX_VectorPair luu,
> +                     HLX_VectorPair lvv)
> +{
> +    hlx_put_vp(0, luu);
> +    hlx_put_vp(2, lvv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD1 HLX_LD2 HLX_LD3
> +                 ".word 0xed04e82d\n"
> +                 HLX_ST6 HLX_ST7
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(6);
> +}
> +
> +/* Ldd16.uw=avg(Luu16.uw,Lvv16.uw):rnd */
> +static inline HLX_VectorPair
> +Q6_LWuw_avg_LWuwLWuw_rnd(HLX_VectorPair luu,
> +                         HLX_VectorPair lvv)
> +{
> +    hlx_put_vp(0, luu);
> +    hlx_put_vp(2, lvv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD1 HLX_LD2 HLX_LD3
> +                 ".word 0xed04ec2d\n"
> +                 HLX_ST6 HLX_ST7
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(6);
> +}
> +
> +/* Ldd16.w=avg(Luu16.w,Lvv16.w) */
> +static inline HLX_VectorPair
> +Q6_LWw_avg_LWwLWw(HLX_VectorPair luu,
> +                  HLX_VectorPair lvv)
> +{
> +    hlx_put_vp(0, luu);
> +    hlx_put_vp(2, lvv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD1 HLX_LD2 HLX_LD3
> +                 ".word 0xed04e80d\n"
> +                 HLX_ST6 HLX_ST7
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(6);
> +}
> +
> +/* Ldd16.w=avg(Luu16.w,Lvv16.w):rnd */
> +static inline HLX_VectorPair
> +Q6_LWw_avg_LWwLWw_rnd(HLX_VectorPair luu,
> +                      HLX_VectorPair lvv)
> +{
> +    hlx_put_vp(0, luu);
> +    hlx_put_vp(2, lvv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD1 HLX_LD2 HLX_LD3
> +                 ".word 0xed04ec0d\n"
> +                 HLX_ST6 HLX_ST7
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(6);
> +}
> +
> +/* Ld16.h=cmp.gt(Lu16.h, Lv16.h) */
> +static inline HLX_Vector Q6_Lh_cmp_gt_LhLh(HLX_Vector lu, HLX_Vector lv)
> +{
> +    hlx_put_v(0, lu);
> +    hlx_put_v(2, lv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD2
> +                 ".word 0xe504e00d\n"
> +                 HLX_ST6
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_v(6);
> +}
> +
> +/* Ldd16.h=cmp.gt(Luu16.h, Lvv16.h) */
> +static inline HLX_VectorPair
> +Q6_LWh_cmp_gt_LWhLWh(HLX_VectorPair luu,
> +                     HLX_VectorPair lvv)
> +{
> +    hlx_put_vp(0, luu);
> +    hlx_put_vp(2, lvv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD1 HLX_LD2 HLX_LD3
> +                 ".word 0xef04f42c\n"
> +                 HLX_ST6 HLX_ST7
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(6);
> +}
> +
> +/* Ld16.h=cmp.gt(Lu16.uh, Lv16.uh) */
> +static inline HLX_Vector Q6_Lh_cmp_gt_LuhLuh(HLX_Vector lu, HLX_Vector lv)
> +{
> +    hlx_put_v(0, lu);
> +    hlx_put_v(2, lv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD2
> +                 ".word 0xe504e02c\n"
> +                 HLX_ST6
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_v(6);
> +}
> +
> +/* Ldd16.h=cmp.gt(Luu16.uh, Lvv16.uh) */
> +static inline HLX_VectorPair
> +Q6_LWh_cmp_gt_LWuhLWuh(HLX_VectorPair luu,
> +                       HLX_VectorPair lvv)
> +{
> +    hlx_put_vp(0, luu);
> +    hlx_put_vp(2, lvv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD1 HLX_LD2 HLX_LD3
> +                 ".word 0xef04f42d\n"
> +                 HLX_ST6 HLX_ST7
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(6);
> +}
> +
> +/* Ldd16.w=cmp.gt(Luu16.uw, Lvv16.uw) */
> +static inline HLX_VectorPair
> +Q6_LWw_cmp_gt_LWuwLWuw(HLX_VectorPair luu,
> +                       HLX_VectorPair lvv)
> +{
> +    hlx_put_vp(0, luu);
> +    hlx_put_vp(2, lvv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD1 HLX_LD2 HLX_LD3
> +                 ".word 0xef04f40c\n"
> +                 HLX_ST6 HLX_ST7
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(6);
> +}
> +
> +/* Ldd16.w=cmp.gt(Luu16.w, Lvv16.w) */
> +static inline HLX_VectorPair
> +Q6_LWw_cmp_gt_LWwLWw(HLX_VectorPair luu,
> +                     HLX_VectorPair lvv)
> +{
> +    hlx_put_vp(0, luu);
> +    hlx_put_vp(2, lvv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD1 HLX_LD2 HLX_LD3
> +                 ".word 0xef04f40d\n"
> +                 HLX_ST6 HLX_ST7
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(6);
> +}
> +
> +/* Ldd16=combine(Lu16,Lv16) */
> +static inline HLX_VectorPair Q6_LW_combine_LL(HLX_Vector lu, HLX_Vector lv)
> +{
> +    hlx_put_v(0, lu);
> +    hlx_put_v(2, lv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD2
> +                 ".word 0xef24e02d\n"
> +                 HLX_ST6 HLX_ST7
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(6);
> +}
> +
> +/* Ld16.b=packhi(Lu16.h,Lv16.h) */
> +static inline HLX_Vector Q6_Lb_packhi_LhLh(HLX_Vector lu, HLX_Vector lv)
> +{
> +    hlx_put_v(0, lu);
> +    hlx_put_v(2, lv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD2
> +                 ".word 0xed04f40d\n"
> +                 HLX_ST6
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_v(6);
> +}
> +
> +/* Ld16.b=packlo(Lu16.h,Lv16.h) */
> +static inline HLX_Vector Q6_Lb_packlo_LhLh(HLX_Vector lu, HLX_Vector lv)
> +{
> +    hlx_put_v(0, lu);
> +    hlx_put_v(2, lv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD2
> +                 ".word 0xed04f40c\n"
> +                 HLX_ST6
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_v(6);
> +}
> +
> +/* Ldd16.h=unpackhi(Lu16.b) */
> +static inline HLX_VectorPair Q6_LWh_unpackhi_Lb(HLX_Vector lu)
> +{
> +    hlx_put_v(0, lu);
> +    asm volatile(HLX_PTRS HLX_LD0
> +                 ".word 0xed00f42d\n"
> +                 HLX_ST6 HLX_ST7
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(6);
> +}
> +
> +/* Ldd16.h=unpacklo(Lu16.b) */
> +static inline HLX_VectorPair Q6_LWh_unpacklo_Lb(HLX_Vector lu)
> +{
> +    hlx_put_v(0, lu);
> +    asm volatile(HLX_PTRS HLX_LD0
> +                 ".word 0xed00f42c\n"
> +                 HLX_ST6 HLX_ST7
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(6);
> +}
> +
> +/* Ldd16.uw=zxt(Lu16.uh) */
> +static inline HLX_VectorPair Q6_LWuw_zxt_Luh(HLX_Vector lu)
> +{
> +    hlx_put_v(0, lu);
> +    asm volatile(HLX_PTRS HLX_LD0
> +                 ".word 0xe501e80c\n"
> +                 HLX_ST6 HLX_ST7
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(6);
> +}
> +
> +/* Ldd16.w=sxt(Lu16.h) */
> +static inline HLX_VectorPair Q6_LWw_sxt_Lh(HLX_Vector lu)
> +{
> +    hlx_put_v(0, lu);
> +    asm volatile(HLX_PTRS HLX_LD0
> +                 ".word 0xe501e80d\n"
> +                 HLX_ST6 HLX_ST7
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(6);
> +}
> +
> +/* Ld16.h=lut4(Lu16.uh,Rtt32.h) */
> +static inline HLX_Vector Q6_Lh_lut4_LuhPh(HLX_Vector lu, uint64_t rtt)
> +{
> +    hlx_put_v(0, lu);
> +    HLX_SCALARS->rtt = rtt;
> +    asm volatile(HLX_PTRS HLX_LD0
> +                 ".word 0xed0ce00c\n"
> +                 HLX_ST6
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_v(6);
> +}
> +
> +/* Ld16.h=lut4(Lu16.uh,Rtt32.h):mask */
> +static inline HLX_Vector Q6_Lh_lut4_LuhPh_mask(HLX_Vector lu, uint64_t rtt)
> +{
> +    hlx_put_v(0, lu);
> +    HLX_SCALARS->rtt = rtt;
> +    asm volatile(HLX_PTRS HLX_LD0
> +                 ".word 0xed0ce02d\n"
> +                 HLX_ST6
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_v(6);
> +}
> +
> +/* Ldd16.w=lut4(Lu16.uh,Rtt32.uh):>>1 */
> +static inline HLX_VectorPair
> +Q6_LWw_lut4_LuhPuh_rs1(HLX_Vector lu,
> +                       uint64_t rtt)
> +{
> +    hlx_put_v(0, lu);
> +    HLX_SCALARS->rtt = rtt;
> +    asm volatile(HLX_PTRS HLX_LD0
> +                 ".word 0xed0ce00d\n"
> +                 HLX_ST6 HLX_ST7
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(6);
> +}
> +
> +/* Ldd16.w=lut4(Lu16.uh,Rtt32.uh):>>1:neg */
> +static inline HLX_VectorPair
> +Q6_LWw_lut4_LuhPuh_rs1_neg(HLX_Vector lu,
> +                           uint64_t rtt)
> +{
> +    hlx_put_v(0, lu);
> +    HLX_SCALARS->rtt = rtt;
> +    asm volatile(HLX_PTRS HLX_LD0
> +                 ".word 0xed0ce02c\n"
> +                 HLX_ST6 HLX_ST7
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(6);
> +}
> +
> +/* Ld16.h=max(Lu16.h,Lv16.h) */
> +static inline HLX_Vector Q6_Lh_max_LhLh(HLX_Vector lu, HLX_Vector lv)
> +{
> +    hlx_put_v(0, lu);
> +    hlx_put_v(2, lv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD2
> +                 ".word 0xe504e40c\n"
> +                 HLX_ST6
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_v(6);
> +}
> +
> +/* Ldd16.h=max(Luu16.h,Lvv16.h) */
> +static inline HLX_VectorPair
> +Q6_LWh_max_LWhLWh(HLX_VectorPair luu,
> +                  HLX_VectorPair lvv)
> +{
> +    hlx_put_vp(0, luu);
> +    hlx_put_vp(2, lvv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD1 HLX_LD2 HLX_LD3
> +                 ".word 0xef04f82c\n"
> +                 HLX_ST6 HLX_ST7
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(6);
> +}
> +
> +/* Ld16.uh=max(Lu16.uh,Lv16.uh) */
> +static inline HLX_Vector Q6_Luh_max_LuhLuh(HLX_Vector lu, HLX_Vector lv)
> +{
> +    hlx_put_v(0, lu);
> +    hlx_put_v(2, lv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD2
> +                 ".word 0xe504e42c\n"
> +                 HLX_ST6
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_v(6);
> +}
> +
> +/* Ldd16.uh=max(Luu16.uh,Lvv16.uh) */
> +static inline HLX_VectorPair
> +Q6_LWuh_max_LWuhLWuh(HLX_VectorPair luu,
> +                     HLX_VectorPair lvv)
> +{
> +    hlx_put_vp(0, luu);
> +    hlx_put_vp(2, lvv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD1 HLX_LD2 HLX_LD3
> +                 ".word 0xef04f82d\n"
> +                 HLX_ST6 HLX_ST7
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(6);
> +}
> +
> +/* Ldd16.uw=max(Luu16.uw,Lvv16.uw) */
> +static inline HLX_VectorPair
> +Q6_LWuw_max_LWuwLWuw(HLX_VectorPair luu,
> +                     HLX_VectorPair lvv)
> +{
> +    hlx_put_vp(0, luu);
> +    hlx_put_vp(2, lvv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD1 HLX_LD2 HLX_LD3
> +                 ".word 0xef04fc2d\n"
> +                 HLX_ST6 HLX_ST7
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(6);
> +}
> +
> +/* Ldd16.w=max(Luu16.w,Lvv16.w) */
> +static inline HLX_VectorPair
> +Q6_LWw_max_LWwLWw(HLX_VectorPair luu,
> +                  HLX_VectorPair lvv)
> +{
> +    hlx_put_vp(0, luu);
> +    hlx_put_vp(2, lvv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD1 HLX_LD2 HLX_LD3
> +                 ".word 0xef04fc2c\n"
> +                 HLX_ST6 HLX_ST7
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(6);
> +}
> +
> +/* Ld16.h=min(Lu16.h,Lv16.h) */
> +static inline HLX_Vector Q6_Lh_min_LhLh(HLX_Vector lu, HLX_Vector lv)
> +{
> +    hlx_put_v(0, lu);
> +    hlx_put_v(2, lv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD2
> +                 ".word 0xe504e40d\n"
> +                 HLX_ST6
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_v(6);
> +}
> +
> +/* Ldd16.h=min(Luu16.h,Lvv16.h) */
> +static inline HLX_VectorPair
> +Q6_LWh_min_LWhLWh(HLX_VectorPair luu,
> +                  HLX_VectorPair lvv)
> +{
> +    hlx_put_vp(0, luu);
> +    hlx_put_vp(2, lvv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD1 HLX_LD2 HLX_LD3
> +                 ".word 0xef04f80c\n"
> +                 HLX_ST6 HLX_ST7
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(6);
> +}
> +
> +/* Ld16.uh=min(Lu16.uh,Lv16.uh) */
> +static inline HLX_Vector Q6_Luh_min_LuhLuh(HLX_Vector lu, HLX_Vector lv)
> +{
> +    hlx_put_v(0, lu);
> +    hlx_put_v(2, lv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD2
> +                 ".word 0xe504e42d\n"
> +                 HLX_ST6
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_v(6);
> +}
> +
> +/* Ldd16.uh=min(Luu16.uh,Lvv16.uh) */
> +static inline HLX_VectorPair
> +Q6_LWuh_min_LWuhLWuh(HLX_VectorPair luu,
> +                     HLX_VectorPair lvv)
> +{
> +    hlx_put_vp(0, luu);
> +    hlx_put_vp(2, lvv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD1 HLX_LD2 HLX_LD3
> +                 ".word 0xef04f80d\n"
> +                 HLX_ST6 HLX_ST7
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(6);
> +}
> +
> +/* Ldd16.uw=min(Luu16.uw,Lvv16.uw) */
> +static inline HLX_VectorPair
> +Q6_LWuw_min_LWuwLWuw(HLX_VectorPair luu,
> +                     HLX_VectorPair lvv)
> +{
> +    hlx_put_vp(0, luu);
> +    hlx_put_vp(2, lvv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD1 HLX_LD2 HLX_LD3
> +                 ".word 0xef04fc0d\n"
> +                 HLX_ST6 HLX_ST7
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(6);
> +}
> +
> +/* Ldd16.w=min(Luu16.w,Lvv16.w) */
> +static inline HLX_VectorPair
> +Q6_LWw_min_LWwLWw(HLX_VectorPair luu,
> +                  HLX_VectorPair lvv)
> +{
> +    hlx_put_vp(0, luu);
> +    hlx_put_vp(2, lvv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD1 HLX_LD2 HLX_LD3
> +                 ".word 0xef04fc0c\n"
> +                 HLX_ST6 HLX_ST7
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(6);
> +}
> +
> +/* Lxx16.uw=add(mpy(Lu16.uh,hi(Lxx16).uh),Lvv16.w) */
> +static inline HLX_VectorPair
> +Q6_LWuw_add_mpy_hi_LuhLWuhLWw(HLX_Vector lu,
> +                              HLX_VectorPair lxx,
> +                              HLX_VectorPair lvv)
> +{
> +    hlx_put_v(0, lu);
> +    hlx_put_vp(4, lxx);
> +    hlx_put_vp(2, lvv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD4 HLX_LD5 HLX_LD2 HLX_LD3
> +                 ".word 0xe7e4f409\n"
> +                 HLX_ST4 HLX_ST5
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(4);
> +}
> +
> +/* Lxx16.w+=mpy(Lu16.h,Lv16.h) */
> +static inline HLX_VectorPair
> +Q6_LWw_mpyacc_LhLh(HLX_VectorPair lxx,
> +                   HLX_Vector lu,
> +                   HLX_Vector lv)
> +{
> +    hlx_put_vp(4, lxx);
> +    hlx_put_v(0, lu);
> +    hlx_put_v(2, lv);
> +    asm volatile(HLX_PTRS HLX_LD4 HLX_LD5 HLX_LD0 HLX_LD2
> +                 ".word 0xe704e829\n"
> +                 HLX_ST4 HLX_ST5
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(4);
> +}
> +
> +/* Lxx16.uw=add(mpy(Lu16.h,Lv16.uh),hi(Lxx16).uh) */
> +static inline HLX_VectorPair
> +Q6_LWuw_add_mpy_hi_LhLuhLWuh(HLX_Vector lu,
> +                             HLX_Vector lv,
> +                             HLX_VectorPair lxx)
> +{
> +    hlx_put_v(0, lu);
> +    hlx_put_v(2, lv);
> +    hlx_put_vp(4, lxx);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD2 HLX_LD4 HLX_LD5
> +                 ".word 0xe704f029\n"
> +                 HLX_ST4 HLX_ST5
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(4);
> +}
> +
> +/* Lxx16.w+=mpy(Lu16.h,Lv16.uh) */
> +static inline HLX_VectorPair
> +Q6_LWw_mpyacc_LhLuh(HLX_VectorPair lxx,
> +                    HLX_Vector lu,
> +                    HLX_Vector lv)
> +{
> +    hlx_put_vp(4, lxx);
> +    hlx_put_v(0, lu);
> +    hlx_put_v(2, lv);
> +    asm volatile(HLX_PTRS HLX_LD4 HLX_LD5 HLX_LD0 HLX_LD2
> +                 ".word 0xe704e809\n"
> +                 HLX_ST4 HLX_ST5
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(4);
> +}
> +
> +/* Lxx16.w=add(mpy(Lu16.h,Lv16.uh),lo(Lxx16).uh) */
> +static inline HLX_VectorPair
> +Q6_LWw_add_mpy_lo_LhLuhLWuh(HLX_Vector lu,
> +                            HLX_Vector lv,
> +                            HLX_VectorPair lxx)
> +{
> +    hlx_put_v(0, lu);
> +    hlx_put_v(2, lv);
> +    hlx_put_vp(4, lxx);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD2 HLX_LD4 HLX_LD5
> +                 ".word 0xe704ec29\n"
> +                 HLX_ST4 HLX_ST5
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(4);
> +}
> +
> +/* Lxx16.w+=mpy(Lu16.uh,Lv16.uh) */
> +static inline HLX_VectorPair
> +Q6_LWw_mpyacc_LuhLuh(HLX_VectorPair lxx,
> +                     HLX_Vector lu,
> +                     HLX_Vector lv)
> +{
> +    hlx_put_vp(4, lxx);
> +    hlx_put_v(0, lu);
> +    hlx_put_v(2, lv);
> +    asm volatile(HLX_PTRS HLX_LD4 HLX_LD5 HLX_LD0 HLX_LD2
> +                 ".word 0xe704e428\n"
> +                 HLX_ST4 HLX_ST5
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(4);
> +}
> +
> +/* Lxx16.uw=add(mpy(Lu16.uh,Lv16.uh),hi(Lxx16).uh) */
> +static inline HLX_VectorPair
> +Q6_LWuw_add_mpy_hi_LuhLuhLWuh(HLX_Vector lu,
> +                              HLX_Vector lv,
> +                              HLX_VectorPair lxx)
> +{
> +    hlx_put_v(0, lu);
> +    hlx_put_v(2, lv);
> +    hlx_put_vp(4, lxx);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD2 HLX_LD4 HLX_LD5
> +                 ".word 0xe704f009\n"
> +                 HLX_ST4 HLX_ST5
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(4);
> +}
> +
> +/* Lxx16.uw=add(mpy(Lu16.uh,Lv16.uh),lo(Lxx16).uh) */
> +static inline HLX_VectorPair
> +Q6_LWuw_add_mpy_lo_LuhLuhLWuh(HLX_Vector lu,
> +                              HLX_Vector lv,
> +                              HLX_VectorPair lxx)
> +{
> +    hlx_put_v(0, lu);
> +    hlx_put_v(2, lv);
> +    hlx_put_vp(4, lxx);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD2 HLX_LD4 HLX_LD5
> +                 ".word 0xe704ec09\n"
> +                 HLX_ST4 HLX_ST5
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(4);
> +}
> +
> +/* Lxx16.w=add(mpy(Lu16.uh,hi(Lxx16).h),Lvv16.w) */
> +static inline HLX_VectorPair
> +Q6_LWw_add_mpy_hi_LuhLWhLWw(HLX_Vector lu,
> +                            HLX_VectorPair lxx,
> +                            HLX_VectorPair lvv)
> +{
> +    hlx_put_v(0, lu);
> +    hlx_put_vp(4, lxx);
> +    hlx_put_vp(2, lvv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD4 HLX_LD5 HLX_LD2 HLX_LD3
> +                 ".word 0xe7e4f429\n"
> +                 HLX_ST4 HLX_ST5
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(4);
> +}
> +
> +/* Lxx16.uw=add(mpy(Lu16.uh,hi(Lxx16).uh),Rt32.w) */
> +static inline HLX_VectorPair
> +Q6_LWuw_add_mpy_hi_LuhLWuhRw(HLX_Vector lu,
> +                             HLX_VectorPair lxx,
> +                             uint32_t rt)
> +{
> +    hlx_put_v(0, lu);
> +    hlx_put_vp(4, lxx);
> +    HLX_SCALARS->rt = rt;
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD4 HLX_LD5
> +                 ".word 0xe7eaf408\n"
> +                 HLX_ST4 HLX_ST5
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(4);
> +}
> +
> +/* Lxx16.w+=mpy(Lu16.h,Rt32.h) */
> +static inline HLX_VectorPair
> +Q6_LWw_mpyacc_LhRh(HLX_VectorPair lxx,
> +                   HLX_Vector lu,
> +                   uint32_t rt)
> +{
> +    hlx_put_vp(4, lxx);
> +    hlx_put_v(0, lu);
> +    HLX_SCALARS->rt = rt;
> +    asm volatile(HLX_PTRS HLX_LD4 HLX_LD5 HLX_LD0
> +                 ".word 0xe70ae828\n"
> +                 HLX_ST4 HLX_ST5
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(4);
> +}
> +
> +/* Lxx16.uw=add(mpy(Lu16.h,Rt32.uh),hi(Lxx16).uh) */
> +static inline HLX_VectorPair
> +Q6_LWuw_add_mpy_hi_LhRuhLWuh(HLX_Vector lu,
> +                             uint32_t rt,
> +                             HLX_VectorPair lxx)
> +{
> +    hlx_put_v(0, lu);
> +    HLX_SCALARS->rt = rt;
> +    hlx_put_vp(4, lxx);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD4 HLX_LD5
> +                 ".word 0xe70af028\n"
> +                 HLX_ST4 HLX_ST5
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(4);
> +}
> +
> +/* Lxx16.w+=mpy(Lu16.h,Rt32.uh) */
> +static inline HLX_VectorPair
> +Q6_LWw_mpyacc_LhRuh(HLX_VectorPair lxx,
> +                    HLX_Vector lu,
> +                    uint32_t rt)
> +{
> +    hlx_put_vp(4, lxx);
> +    hlx_put_v(0, lu);
> +    HLX_SCALARS->rt = rt;
> +    asm volatile(HLX_PTRS HLX_LD4 HLX_LD5 HLX_LD0
> +                 ".word 0xe70ae808\n"
> +                 HLX_ST4 HLX_ST5
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(4);
> +}
> +
> +/* Lxx16.w=add(mpy(Lu16.h,Rt32.uh),lo(Lxx16).uh) */
> +static inline HLX_VectorPair
> +Q6_LWw_add_mpy_lo_LhRuhLWuh(HLX_Vector lu,
> +                            uint32_t rt,
> +                            HLX_VectorPair lxx)
> +{
> +    hlx_put_v(0, lu);
> +    HLX_SCALARS->rt = rt;
> +    hlx_put_vp(4, lxx);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD4 HLX_LD5
> +                 ".word 0xe70aec28\n"
> +                 HLX_ST4 HLX_ST5
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(4);
> +}
> +
> +/* Lxx16.w+=mpy(Lu16.uh,Rt32.uh) */
> +static inline HLX_VectorPair
> +Q6_LWw_mpyacc_LuhRuh(HLX_VectorPair lxx,
> +                     HLX_Vector lu,
> +                     uint32_t rt)
> +{
> +    hlx_put_vp(4, lxx);
> +    hlx_put_v(0, lu);
> +    HLX_SCALARS->rt = rt;
> +    asm volatile(HLX_PTRS HLX_LD4 HLX_LD5 HLX_LD0
> +                 ".word 0xe70ae429\n"
> +                 HLX_ST4 HLX_ST5
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(4);
> +}
> +
> +/* Lxx16.uw=add(mpy(Lu16.uh,Rt32.uh),hi(Lxx16).uh) */
> +static inline HLX_VectorPair
> +Q6_LWuw_add_mpy_hi_LuhRuhLWuh(HLX_Vector lu,
> +                              uint32_t rt,
> +                              HLX_VectorPair lxx)
> +{
> +    hlx_put_v(0, lu);
> +    HLX_SCALARS->rt = rt;
> +    hlx_put_vp(4, lxx);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD4 HLX_LD5
> +                 ".word 0xe70af008\n"
> +                 HLX_ST4 HLX_ST5
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(4);
> +}
> +
> +/* Lxx16.uw=add(mpy(Lu16.uh,Rt32.uh),lo(Lxx16).uh) */
> +static inline HLX_VectorPair
> +Q6_LWuw_add_mpy_lo_LuhRuhLWuh(HLX_Vector lu,
> +                              uint32_t rt,
> +                              HLX_VectorPair lxx)
> +{
> +    hlx_put_v(0, lu);
> +    HLX_SCALARS->rt = rt;
> +    hlx_put_vp(4, lxx);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD4 HLX_LD5
> +                 ".word 0xe70aec08\n"
> +                 HLX_ST4 HLX_ST5
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(4);
> +}
> +
> +/* Lxx16.w=add(mpy(Lu16.uh,hi(Lxx16).h),Rt32.w) */
> +static inline HLX_VectorPair
> +Q6_LWw_add_mpy_hi_LuhLWhRw(HLX_Vector lu,
> +                           HLX_VectorPair lxx,
> +                           uint32_t rt)
> +{
> +    hlx_put_v(0, lu);
> +    hlx_put_vp(4, lxx);
> +    HLX_SCALARS->rt = rt;
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD4 HLX_LD5
> +                 ".word 0xe7eaf428\n"
> +                 HLX_ST4 HLX_ST5
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(4);
> +}
> +
> +/* Ldd16.uw=mpy(Lu16.uh,Lv16.uh) */
> +static inline HLX_VectorPair Q6_LWuw_mpy_LuhLuh(HLX_Vector lu, HLX_Vector lv)
> +{
> +    hlx_put_v(0, lu);
> +    hlx_put_v(2, lv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD2
> +                 ".word 0xe704e00d\n"
> +                 HLX_ST6 HLX_ST7
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(6);
> +}
> +
> +/* Ldd16.w=mpy(Lu16.h,Lv16.h) */
> +static inline HLX_VectorPair Q6_LWw_mpy_LhLh(HLX_Vector lu, HLX_Vector lv)
> +{
> +    hlx_put_v(0, lu);
> +    hlx_put_v(2, lv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD2
> +                 ".word 0xe704e40c\n"
> +                 HLX_ST6 HLX_ST7
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(6);
> +}
> +
> +/* Ldd16.w=mpy(Lu16.h,Lv16.uh) */
> +static inline HLX_VectorPair Q6_LWw_mpy_LhLuh(HLX_Vector lu, HLX_Vector lv)
> +{
> +    hlx_put_v(0, lu);
> +    hlx_put_v(2, lv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD2
> +                 ".word 0xe704e02d\n"
> +                 HLX_ST6 HLX_ST7
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(6);
> +}
> +
> +/* Ldd16.uw=mpy(Lu16.uh,Rt32.uh) */
> +static inline HLX_VectorPair Q6_LWuw_mpy_LuhRuh(HLX_Vector lu, uint32_t rt)
> +{
> +    hlx_put_v(0, lu);
> +    HLX_SCALARS->rt = rt;
> +    asm volatile(HLX_PTRS HLX_LD0
> +                 ".word 0xe70ae00c\n"
> +                 HLX_ST6 HLX_ST7
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(6);
> +}
> +
> +/* Ldd16.w=mpy(Lu16.h,Rt32.h) */
> +static inline HLX_VectorPair Q6_LWw_mpy_LhRh(HLX_Vector lu, uint32_t rt)
> +{
> +    hlx_put_v(0, lu);
> +    HLX_SCALARS->rt = rt;
> +    asm volatile(HLX_PTRS HLX_LD0
> +                 ".word 0xe70ae40d\n"
> +                 HLX_ST6 HLX_ST7
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(6);
> +}
> +
> +/* Ldd16.w=mpy(Lu16.h,Rt32.uh) */
> +static inline HLX_VectorPair Q6_LWw_mpy_LhRuh(HLX_Vector lu, uint32_t rt)
> +{
> +    hlx_put_v(0, lu);
> +    HLX_SCALARS->rt = rt;
> +    asm volatile(HLX_PTRS HLX_LD0
> +                 ".word 0xe70ae02c\n"
> +                 HLX_ST6 HLX_ST7
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(6);
> +}
> +
> +/* Lx16.h=mux(Lx16.h,Lu16.h,Lv16.h) */
> +static inline HLX_Vector
> +Q6_Lh_mux_LhLhLh(HLX_Vector lx,
> +                 HLX_Vector lu,
> +                 HLX_Vector lv)
> +{
> +    hlx_put_v(4, lx);
> +    hlx_put_v(0, lu);
> +    hlx_put_v(2, lv);
> +    asm volatile(HLX_PTRS HLX_LD4 HLX_LD0 HLX_LD2
> +                 ".word 0xe504e008\n"
> +                 HLX_ST4
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_v(4);
> +}
> +
> +/* Ld16.h=navg(Lu16.h,Lv16.h) */
> +static inline HLX_Vector Q6_Lh_navg_LhLh(HLX_Vector lu, HLX_Vector lv)
> +{
> +    hlx_put_v(0, lu);
> +    hlx_put_v(2, lv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD2
> +                 ".word 0xed04f00c\n"
> +                 HLX_ST6
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_v(6);
> +}
> +
> +/* Ld16.h=navg(Lu16.uh,Lv16.uh) */
> +static inline HLX_Vector Q6_Lh_navg_LuhLuh(HLX_Vector lu, HLX_Vector lv)
> +{
> +    hlx_put_v(0, lu);
> +    hlx_put_v(2, lv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD2
> +                 ".word 0xed04f02c\n"
> +                 HLX_ST6
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_v(6);
> +}
> +
> +/* Ldd16.w=navg(Luu16.uw,Lvv16.uw) */
> +static inline HLX_VectorPair
> +Q6_LWw_navg_LWuwLWuw(HLX_VectorPair luu,
> +                     HLX_VectorPair lvv)
> +{
> +    hlx_put_vp(0, luu);
> +    hlx_put_vp(2, lvv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD1 HLX_LD2 HLX_LD3
> +                 ".word 0xed04f02d\n"
> +                 HLX_ST6 HLX_ST7
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(6);
> +}
> +
> +/* Ldd16.w=navg(Luu16.w,Lvv16.w) */
> +static inline HLX_VectorPair
> +Q6_LWw_navg_LWwLWw(HLX_VectorPair luu,
> +                   HLX_VectorPair lvv)
> +{
> +    hlx_put_vp(0, luu);
> +    hlx_put_vp(2, lvv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD1 HLX_LD2 HLX_LD3
> +                 ".word 0xed04f00d\n"
> +                 HLX_ST6 HLX_ST7
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(6);
> +}
> +
> +/* Ld16=not(Lu16) */
> +static inline HLX_Vector Q6_L_not_L(HLX_Vector lu)
> +{
> +    hlx_put_v(0, lu);
> +    asm volatile(HLX_PTRS HLX_LD0
> +                 ".word 0xe500f42c\n"
> +                 HLX_ST6
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_v(6);
> +}
> +
> +/* Ldd16=not(Luu16) */
> +static inline HLX_VectorPair Q6_LW_not_LW(HLX_VectorPair luu)
> +{
> +    hlx_put_vp(0, luu);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD1
> +                 ".word 0xef20e40d\n"
> +                 HLX_ST6 HLX_ST7
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(6);
> +}
> +
> +/* Ld16=or(Lu16,Lv16) */
> +static inline HLX_Vector Q6_L_or_LL(HLX_Vector lu, HLX_Vector lv)
> +{
> +    hlx_put_v(0, lu);
> +    hlx_put_v(2, lv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD2
> +                 ".word 0xe504f80c\n"
> +                 HLX_ST6
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_v(6);
> +}
> +
> +/* Ldd16=or(Luu16,Lvv16) */
> +static inline HLX_VectorPair
> +Q6_LW_or_LWLW(HLX_VectorPair luu,
> +              HLX_VectorPair lvv)
> +{
> +    hlx_put_vp(0, luu);
> +    hlx_put_vp(2, lvv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD1 HLX_LD2 HLX_LD3
> +                 ".word 0xef24e00d\n"
> +                 HLX_ST6 HLX_ST7
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(6);
> +}
> +
> +/* Ld16=orn(Lu16,Lv16) */
> +static inline HLX_Vector Q6_L_orn_LL(HLX_Vector lu, HLX_Vector lv)
> +{
> +    hlx_put_v(0, lu);
> +    hlx_put_v(2, lv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD2
> +                 ".word 0xe504f80d\n"
> +                 HLX_ST6
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_v(6);
> +}
> +
> +/* Ldd16=orn(Luu16,Lvv16) */
> +static inline HLX_VectorPair
> +Q6_LW_orn_LWLW(HLX_VectorPair luu,
> +               HLX_VectorPair lvv)
> +{
> +    hlx_put_vp(0, luu);
> +    hlx_put_vp(2, lvv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD1 HLX_LD2 HLX_LD3
> +                 ".word 0xef24e42c\n"
> +                 HLX_ST6 HLX_ST7
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(6);
> +}
> +
> +/* Ld16.h=shr(Lu16.h,Lv16.h) */
> +static inline HLX_Vector Q6_Lh_shr_LhLh(HLX_Vector lu, HLX_Vector lv)
> +{
> +    hlx_put_v(0, lu);
> +    hlx_put_v(2, lv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD2
> +                 ".word 0xed24e80c\n"
> +                 HLX_ST6
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_v(6);
> +}
> +
> +/* Ld16.h=shr(Luu16.w,Lv16.h):rnd:sat */
> +static inline HLX_Vector
> +Q6_Lh_shr_LWwLh_rnd_sat(HLX_VectorPair luu,
> +                        HLX_Vector lv)
> +{
> +    hlx_put_vp(0, luu);
> +    hlx_put_v(2, lv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD1 HLX_LD2
> +                 ".word 0xed24f40c\n"
> +                 HLX_ST6
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_v(6);
> +}
> +
> +/* Ld16.h=shr(Luu16.w,Lv16.h):sat */
> +static inline HLX_Vector Q6_Lh_shr_LWwLh_sat(HLX_VectorPair luu, HLX_Vector lv)
> +{
> +    hlx_put_vp(0, luu);
> +    hlx_put_v(2, lv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD1 HLX_LD2
> +                 ".word 0xed24f02c\n"
> +                 HLX_ST6
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_v(6);
> +}
> +
> +/* Ld16.h=shr(Luu16.w,Lv16.uh) */
> +static inline HLX_Vector Q6_Lh_shr_LWwLuh(HLX_VectorPair luu, HLX_Vector lv)
> +{
> +    hlx_put_vp(0, luu);
> +    hlx_put_v(2, lv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD1 HLX_LD2
> +                 ".word 0xed24f00c\n"
> +                 HLX_ST6
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_v(6);
> +}
> +
> +/* Ld16.uh=shr(Lu16.uh,Lv16.h) */
> +static inline HLX_Vector Q6_Luh_shr_LuhLh(HLX_Vector lu, HLX_Vector lv)
> +{
> +    hlx_put_v(0, lu);
> +    hlx_put_v(2, lv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD2
> +                 ".word 0xed24e82c\n"
> +                 HLX_ST6
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_v(6);
> +}
> +
> +/* Ld16.uh=shr(Luu16.uw,Lv16.h):rnd:sat */
> +static inline HLX_Vector
> +Q6_Luh_shr_LWuwLh_rnd_sat(HLX_VectorPair luu,
> +                          HLX_Vector lv)
> +{
> +    hlx_put_vp(0, luu);
> +    hlx_put_v(2, lv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD1 HLX_LD2
> +                 ".word 0xed24f82c\n"
> +                 HLX_ST6
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_v(6);
> +}
> +
> +/* Ld16.uh=shr(Luu16.uw,Lv16.h):sat */
> +static inline HLX_Vector
> +Q6_Luh_shr_LWuwLh_sat(HLX_VectorPair luu,
> +                      HLX_Vector lv)
> +{
> +    hlx_put_vp(0, luu);
> +    hlx_put_v(2, lv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD1 HLX_LD2
> +                 ".word 0xed24fc0c\n"
> +                 HLX_ST6
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_v(6);
> +}
> +
> +/* Ld16.uh=shr(Luu16.w,Lv16.h):rnd:sat */
> +static inline HLX_Vector
> +Q6_Luh_shr_LWwLh_rnd_sat(HLX_VectorPair luu,
> +                         HLX_Vector lv)
> +{
> +    hlx_put_vp(0, luu);
> +    hlx_put_v(2, lv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD1 HLX_LD2
> +                 ".word 0xed24f80c\n"
> +                 HLX_ST6
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_v(6);
> +}
> +
> +/* Ld16.uh=shr(Luu16.w,Lv16.h):sat */
> +static inline HLX_Vector
> +Q6_Luh_shr_LWwLh_sat(HLX_VectorPair luu,
> +                     HLX_Vector lv)
> +{
> +    hlx_put_vp(0, luu);
> +    hlx_put_v(2, lv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD1 HLX_LD2
> +                 ".word 0xed24f42c\n"
> +                 HLX_ST6
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_v(6);
> +}
> +
> +/* Ldd16.uw=shr(Luu16.uw,Lv16.h) */
> +static inline HLX_VectorPair
> +Q6_LWuw_shr_LWuwLh(HLX_VectorPair luu,
> +                   HLX_Vector lv)
> +{
> +    hlx_put_vp(0, luu);
> +    hlx_put_v(2, lv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD1 HLX_LD2
> +                 ".word 0xed24ec0c\n"
> +                 HLX_ST6 HLX_ST7
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(6);
> +}
> +
> +/* Ldd16.w=shr(Luu16.w,Lv16.h) */
> +static inline HLX_VectorPair
> +Q6_LWw_shr_LWwLh(HLX_VectorPair luu,
> +                 HLX_Vector lv)
> +{
> +    hlx_put_vp(0, luu);
> +    hlx_put_v(2, lv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD1 HLX_LD2
> +                 ".word 0xed24ec2c\n"
> +                 HLX_ST6 HLX_ST7
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(6);
> +}
> +
> +/* Lx16.h+=shr(Lu16.h,Lv16.h) */
> +static inline HLX_Vector
> +Q6_Lh_shracc_LhLh(HLX_Vector lx,
> +                  HLX_Vector lu,
> +                  HLX_Vector lv)
> +{
> +    hlx_put_v(4, lx);
> +    hlx_put_v(0, lu);
> +    hlx_put_v(2, lv);
> +    asm volatile(HLX_PTRS HLX_LD4 HLX_LD0 HLX_LD2
> +                 ".word 0xed04f828\n"
> +                 HLX_ST4
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_v(4);
> +}
> +
> +/* Lx16.h+=shr(Lu16.uh,Lv16.h) */
> +static inline HLX_Vector
> +Q6_Lh_shracc_LuhLh(HLX_Vector lx,
> +                   HLX_Vector lu,
> +                   HLX_Vector lv)
> +{
> +    hlx_put_v(4, lx);
> +    hlx_put_v(0, lu);
> +    hlx_put_v(2, lv);
> +    asm volatile(HLX_PTRS HLX_LD4 HLX_LD0 HLX_LD2
> +                 ".word 0xed04f808\n"
> +                 HLX_ST4
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_v(4);
> +}
> +
> +/* Lxx16.w+=shr(Luu16.uw,Lv16.h) */
> +static inline HLX_VectorPair
> +Q6_LWw_shracc_LWuwLh(HLX_VectorPair lxx,
> +                     HLX_VectorPair luu,
> +                     HLX_Vector lv)
> +{
> +    hlx_put_vp(4, lxx);
> +    hlx_put_vp(0, luu);
> +    hlx_put_v(2, lv);
> +    asm volatile(HLX_PTRS HLX_LD4 HLX_LD5 HLX_LD0 HLX_LD1 HLX_LD2
> +                 ".word 0xed04fc08\n"
> +                 HLX_ST4 HLX_ST5
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(4);
> +}
> +
> +/* Lxx16.w+=shr(Luu16.w,Lv16.h) */
> +static inline HLX_VectorPair
> +Q6_LWw_shracc_LWwLh(HLX_VectorPair lxx,
> +                    HLX_VectorPair luu,
> +                    HLX_Vector lv)
> +{
> +    hlx_put_vp(4, lxx);
> +    hlx_put_vp(0, luu);
> +    hlx_put_v(2, lv);
> +    asm volatile(HLX_PTRS HLX_LD4 HLX_LD5 HLX_LD0 HLX_LD1 HLX_LD2
> +                 ".word 0xed04fc28\n"
> +                 HLX_ST4 HLX_ST5
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(4);
> +}
> +
> +/* Lx16.h+=shr(Lu16.h,Rt32.h) */
> +static inline HLX_Vector
> +Q6_Lh_shracc_LhRh(HLX_Vector lx,
> +                  HLX_Vector lu,
> +                  uint32_t rt)
> +{
> +    hlx_put_v(4, lx);
> +    hlx_put_v(0, lu);
> +    HLX_SCALARS->rt = rt;
> +    asm volatile(HLX_PTRS HLX_LD4 HLX_LD0
> +                 ".word 0xed0af829\n"
> +                 HLX_ST4
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_v(4);
> +}
> +
> +/* Lx16.h+=shr(Lu16.uh,Rt32.h) */
> +static inline HLX_Vector
> +Q6_Lh_shracc_LuhRh(HLX_Vector lx,
> +                   HLX_Vector lu,
> +                   uint32_t rt)
> +{
> +    hlx_put_v(4, lx);
> +    hlx_put_v(0, lu);
> +    HLX_SCALARS->rt = rt;
> +    asm volatile(HLX_PTRS HLX_LD4 HLX_LD0
> +                 ".word 0xed0af809\n"
> +                 HLX_ST4
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_v(4);
> +}
> +
> +/* Lxx16.w+=shr(Luu16.uw,Rt32.h) */
> +static inline HLX_VectorPair
> +Q6_LWw_shracc_LWuwRh(HLX_VectorPair lxx,
> +                     HLX_VectorPair luu,
> +                     uint32_t rt)
> +{
> +    hlx_put_vp(4, lxx);
> +    hlx_put_vp(0, luu);
> +    HLX_SCALARS->rt = rt;
> +    asm volatile(HLX_PTRS HLX_LD4 HLX_LD5 HLX_LD0 HLX_LD1
> +                 ".word 0xed0afc09\n"
> +                 HLX_ST4 HLX_ST5
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(4);
> +}
> +
> +/* Lxx16.w+=shr(Luu16.w,Rt32.h) */
> +static inline HLX_VectorPair
> +Q6_LWw_shracc_LWwRh(HLX_VectorPair lxx,
> +                    HLX_VectorPair luu,
> +                    uint32_t rt)
> +{
> +    hlx_put_vp(4, lxx);
> +    hlx_put_vp(0, luu);
> +    HLX_SCALARS->rt = rt;
> +    asm volatile(HLX_PTRS HLX_LD4 HLX_LD5 HLX_LD0 HLX_LD1
> +                 ".word 0xed0afc29\n"
> +                 HLX_ST4 HLX_ST5
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(4);
> +}
> +
> +/* Ld16.h=shr(Lu16.h,Rt32.h) */
> +static inline HLX_Vector Q6_Lh_shr_LhRh(HLX_Vector lu, uint32_t rt)
> +{
> +    hlx_put_v(0, lu);
> +    HLX_SCALARS->rt = rt;
> +    asm volatile(HLX_PTRS HLX_LD0
> +                 ".word 0xed2ae80d\n"
> +                 HLX_ST6
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_v(6);
> +}
> +
> +/* Ld16.h=shr(Luu16.w,Rt32.h):rnd:sat */
> +static inline HLX_Vector
> +Q6_Lh_shr_LWwRh_rnd_sat(HLX_VectorPair luu,
> +                        uint32_t rt)
> +{
> +    hlx_put_vp(0, luu);
> +    HLX_SCALARS->rt = rt;
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD1
> +                 ".word 0xed2af40d\n"
> +                 HLX_ST6
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_v(6);
> +}
> +
> +/* Ld16.h=shr(Luu16.w,Rt32.h):sat */
> +static inline HLX_Vector Q6_Lh_shr_LWwRh_sat(HLX_VectorPair luu, uint32_t rt)
> +{
> +    hlx_put_vp(0, luu);
> +    HLX_SCALARS->rt = rt;
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD1
> +                 ".word 0xed2af02d\n"
> +                 HLX_ST6
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_v(6);
> +}
> +
> +/* Ld16.h=shr(Luu16.w,Rt32.uh) */
> +static inline HLX_Vector Q6_Lh_shr_LWwRuh(HLX_VectorPair luu, uint32_t rt)
> +{
> +    hlx_put_vp(0, luu);
> +    HLX_SCALARS->rt = rt;
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD1
> +                 ".word 0xed2af00d\n"
> +                 HLX_ST6
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_v(6);
> +}
> +
> +/* Ld16.uh=shr(Lu16.uh,Rt32.h) */
> +static inline HLX_Vector Q6_Luh_shr_LuhRh(HLX_Vector lu, uint32_t rt)
> +{
> +    hlx_put_v(0, lu);
> +    HLX_SCALARS->rt = rt;
> +    asm volatile(HLX_PTRS HLX_LD0
> +                 ".word 0xed2ae82d\n"
> +                 HLX_ST6
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_v(6);
> +}
> +
> +/* Ld16.uh=shr(Luu16.uw,Rt32.h):rnd:sat */
> +static inline HLX_Vector
> +Q6_Luh_shr_LWuwRh_rnd_sat(HLX_VectorPair luu,
> +                          uint32_t rt)
> +{
> +    hlx_put_vp(0, luu);
> +    HLX_SCALARS->rt = rt;
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD1
> +                 ".word 0xed2af82d\n"
> +                 HLX_ST6
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_v(6);
> +}
> +
> +/* Ld16.uh=shr(Luu16.uw,Rt32.h):sat */
> +static inline HLX_Vector Q6_Luh_shr_LWuwRh_sat(HLX_VectorPair luu, uint32_t rt)
> +{
> +    hlx_put_vp(0, luu);
> +    HLX_SCALARS->rt = rt;
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD1
> +                 ".word 0xed2afc0d\n"
> +                 HLX_ST6
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_v(6);
> +}
> +
> +/* Ld16.uh=shr(Luu16.w,Rt32.h):rnd:sat */
> +static inline HLX_Vector
> +Q6_Luh_shr_LWwRh_rnd_sat(HLX_VectorPair luu,
> +                         uint32_t rt)
> +{
> +    hlx_put_vp(0, luu);
> +    HLX_SCALARS->rt = rt;
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD1
> +                 ".word 0xed2af80d\n"
> +                 HLX_ST6
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_v(6);
> +}
> +
> +/* Ld16.uh=shr(Luu16.w,Rt32.h):sat */
> +static inline HLX_Vector Q6_Luh_shr_LWwRh_sat(HLX_VectorPair luu, uint32_t rt)
> +{
> +    hlx_put_vp(0, luu);
> +    HLX_SCALARS->rt = rt;
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD1
> +                 ".word 0xed2af42d\n"
> +                 HLX_ST6
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_v(6);
> +}
> +
> +/* Ldd16.uw=shr(Luu16.uw,Rt32.h) */
> +static inline HLX_VectorPair
> +Q6_LWuw_shr_LWuwRh(HLX_VectorPair luu,
> +                   uint32_t rt)
> +{
> +    hlx_put_vp(0, luu);
> +    HLX_SCALARS->rt = rt;
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD1
> +                 ".word 0xed2aec0d\n"
> +                 HLX_ST6 HLX_ST7
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(6);
> +}
> +
> +/* Ldd16.w=shr(Luu16.w,Rt32.h) */
> +static inline HLX_VectorPair Q6_LWw_shr_LWwRh(HLX_VectorPair luu, uint32_t rt)
> +{
> +    hlx_put_vp(0, luu);
> +    HLX_SCALARS->rt = rt;
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD1
> +                 ".word 0xed2aec2d\n"
> +                 HLX_ST6 HLX_ST7
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(6);
> +}
> +
> +/* Ld16.h=sub(Lu16.h,Lv16.h) */
> +static inline HLX_Vector Q6_Lh_sub_LhLh(HLX_Vector lu, HLX_Vector lv)
> +{
> +    hlx_put_v(0, lu);
> +    hlx_put_v(2, lv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD2
> +                 ".word 0xe504f00c\n"
> +                 HLX_ST6
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_v(6);
> +}
> +
> +/* Ld16.h=sub(Lu16.h,Lv16.h):sat */
> +static inline HLX_Vector Q6_Lh_sub_LhLh_sat(HLX_Vector lu, HLX_Vector lv)
> +{
> +    hlx_put_v(0, lu);
> +    hlx_put_v(2, lv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD2
> +                 ".word 0xe504f00d\n"
> +                 HLX_ST6
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_v(6);
> +}
> +
> +/* Ldd16.h=sub(Luu16.h,Lvv16.h) */
> +static inline HLX_VectorPair
> +Q6_LWh_sub_LWhLWh(HLX_VectorPair luu,
> +                  HLX_VectorPair lvv)
> +{
> +    hlx_put_vp(0, luu);
> +    hlx_put_vp(2, lvv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD1 HLX_LD2 HLX_LD3
> +                 ".word 0xef04ec0c\n"
> +                 HLX_ST6 HLX_ST7
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(6);
> +}
> +
> +/* Ldd16.h=sub(Luu16.h,Lvv16.h):sat */
> +static inline HLX_VectorPair
> +Q6_LWh_sub_LWhLWh_sat(HLX_VectorPair luu,
> +                      HLX_VectorPair lvv)
> +{
> +    hlx_put_vp(0, luu);
> +    hlx_put_vp(2, lvv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD1 HLX_LD2 HLX_LD3
> +                 ".word 0xef04ec0d\n"
> +                 HLX_ST6 HLX_ST7
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(6);
> +}
> +
> +/* Ld16.h=sub(ilog2(Lu16.h),#u4) */
> +#define Q6_Lh_sub_ilog2_LhI(lu, iu4) \
> +    ({ \
> +        hlx_put_v(0, lu); \
> +        asm volatile(HLX_PTRS HLX_LD0 \
> +                     ".word " HLX_STR(0xed20e40c | HLX_IMM(iu4, 4, 17)) "\n" \
> +                     HLX_ST6 \
> +                     : : [stage] "r"(hlx_stage) : HLX_CLOBBERS); \
> +        hlx_get_v(6); \
> +    })
> +
> +/* Ld16.h=sub(ilog2(Lu16.uh),#u4) */
> +#define Q6_Lh_sub_ilog2_LuhI(lu, iu4) \
> +    ({ \
> +        hlx_put_v(0, lu); \
> +        asm volatile(HLX_PTRS HLX_LD0 \
> +                     ".word " HLX_STR(0xed20e40d | HLX_IMM(iu4, 4, 17)) "\n" \
> +                     HLX_ST6 \
> +                     : : [stage] "r"(hlx_stage) : HLX_CLOBBERS); \
> +        hlx_get_v(6); \
> +    })
> +
> +/* Ld16.h=sub(ilog2(Luu16.uw),#u5) */
> +#define Q6_Lh_sub_ilog2_LWuwI(luu, iu5) \
> +    ({ \
> +        hlx_put_vp(0, luu); \
> +        asm volatile(HLX_PTRS HLX_LD0 HLX_LD1 \
> +                     ".word " HLX_STR(0xed20e42d | HLX_IMM(iu5, 5, 16)) "\n" \
> +                     HLX_ST6 \
> +                     : : [stage] "r"(hlx_stage) : HLX_CLOBBERS); \
> +        hlx_get_v(6); \
> +    })
> +
> +/* Ld16.h=sub(ilog2(Luu16.w),#u5) */
> +#define Q6_Lh_sub_ilog2_LWwI(luu, iu5) \
> +    ({ \
> +        hlx_put_vp(0, luu); \
> +        asm volatile(HLX_PTRS HLX_LD0 HLX_LD1 \
> +                     ".word " HLX_STR(0xed20e42c | HLX_IMM(iu5, 5, 16)) "\n" \
> +                     HLX_ST6 \
> +                     : : [stage] "r"(hlx_stage) : HLX_CLOBBERS); \
> +        hlx_get_v(6); \
> +    })
> +
> +/* Ld16.uh=sub(Lu16.uh,Lv16.uh):sat */
> +static inline HLX_Vector Q6_Luh_sub_LuhLuh_sat(HLX_Vector lu, HLX_Vector lv)
> +{
> +    hlx_put_v(0, lu);
> +    hlx_put_v(2, lv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD2
> +                 ".word 0xe504fc0c\n"
> +                 HLX_ST6
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_v(6);
> +}
> +
> +/* Ld16.uh=sub(Lu16.h,Lv16.h):sat */
> +static inline HLX_Vector Q6_Luh_sub_LhLh_sat(HLX_Vector lu, HLX_Vector lv)
> +{
> +    hlx_put_v(0, lu);
> +    hlx_put_v(2, lv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD2
> +                 ".word 0xe504fc0d\n"
> +                 HLX_ST6
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_v(6);
> +}
> +
> +/* Ldd16.uh=sub(Luu16.h,Lvv16.h):sat */
> +static inline HLX_VectorPair
> +Q6_LWuh_sub_LWhLWh_sat(HLX_VectorPair luu,
> +                       HLX_VectorPair lvv)
> +{
> +    hlx_put_vp(0, luu);
> +    hlx_put_vp(2, lvv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD1 HLX_LD2 HLX_LD3
> +                 ".word 0xef04ec2d\n"
> +                 HLX_ST6 HLX_ST7
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(6);
> +}
> +
> +/* Ldd16.uh=sub(Luu16.uh,Lvv16.uh):sat */
> +static inline HLX_VectorPair
> +Q6_LWuh_sub_LWuhLWuh_sat(HLX_VectorPair luu,
> +                         HLX_VectorPair lvv)
> +{
> +    hlx_put_vp(0, luu);
> +    hlx_put_vp(2, lvv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD1 HLX_LD2 HLX_LD3
> +                 ".word 0xef04ec2c\n"
> +                 HLX_ST6 HLX_ST7
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(6);
> +}
> +
> +/* Ldd16.uw=sub(Luu16.uw,Lvv16.uw):sat */
> +static inline HLX_VectorPair
> +Q6_LWuw_sub_LWuwLWuw_sat(HLX_VectorPair luu,
> +                         HLX_VectorPair lvv)
> +{
> +    hlx_put_vp(0, luu);
> +    hlx_put_vp(2, lvv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD1 HLX_LD2 HLX_LD3
> +                 ".word 0xef04e42c\n"
> +                 HLX_ST6 HLX_ST7
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(6);
> +}
> +
> +/* Ldd16.uw=sub(Luu16.w,Lvv16.w):sat */
> +static inline HLX_VectorPair
> +Q6_LWuw_sub_LWwLWw_sat(HLX_VectorPair luu,
> +                       HLX_VectorPair lvv)
> +{
> +    hlx_put_vp(0, luu);
> +    hlx_put_vp(2, lvv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD1 HLX_LD2 HLX_LD3
> +                 ".word 0xef04e42d\n"
> +                 HLX_ST6 HLX_ST7
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(6);
> +}
> +
> +/* Ldd16.w=sub(Luu16.w,Lvv16.w) */
> +static inline HLX_VectorPair
> +Q6_LWw_sub_LWwLWw(HLX_VectorPair luu,
> +                  HLX_VectorPair lvv)
> +{
> +    hlx_put_vp(0, luu);
> +    hlx_put_vp(2, lvv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD1 HLX_LD2 HLX_LD3
> +                 ".word 0xef04e40c\n"
> +                 HLX_ST6 HLX_ST7
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(6);
> +}
> +
> +/* Ldd16.w=sub(Luu16.w,Lvv16.w):sat */
> +static inline HLX_VectorPair
> +Q6_LWw_sub_LWwLWw_sat(HLX_VectorPair luu,
> +                      HLX_VectorPair lvv)
> +{
> +    hlx_put_vp(0, luu);
> +    hlx_put_vp(2, lvv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD1 HLX_LD2 HLX_LD3
> +                 ".word 0xef04e40d\n"
> +                 HLX_ST6 HLX_ST7
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(6);
> +}
> +
> +/* Ldd16.w=sub(Lu16.uh,Lv16.uh) */
> +static inline HLX_VectorPair Q6_LWw_sub_LuhLuh(HLX_Vector lu, HLX_Vector lv)
> +{
> +    hlx_put_v(0, lu);
> +    hlx_put_v(2, lv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD2
> +                 ".word 0xe524e80d\n"
> +                 HLX_ST6 HLX_ST7
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(6);
> +}
> +
> +/* Ldd16.w=sub(Luu16.w,Lv16.h) */
> +static inline HLX_VectorPair
> +Q6_LWw_sub_LWwLh(HLX_VectorPair luu,
> +                 HLX_Vector lv)
> +{
> +    hlx_put_vp(0, luu);
> +    hlx_put_v(2, lv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD1 HLX_LD2
> +                 ".word 0xe524e00c\n"
> +                 HLX_ST6 HLX_ST7
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(6);
> +}
> +
> +/* Ldd16.w=sub(Luu16.w,Lv16.uh) */
> +static inline HLX_VectorPair
> +Q6_LWw_sub_LWwLuh(HLX_VectorPair luu,
> +                  HLX_Vector lv)
> +{
> +    hlx_put_vp(0, luu);
> +    hlx_put_v(2, lv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD1 HLX_LD2
> +                 ".word 0xe524e00d\n"
> +                 HLX_ST6 HLX_ST7
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(6);
> +}
> +
> +/* Ld16=xor(Lu16,Lv16) */
> +static inline HLX_Vector Q6_L_xor_LL(HLX_Vector lu, HLX_Vector lv)
> +{
> +    hlx_put_v(0, lu);
> +    hlx_put_v(2, lv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD2
> +                 ".word 0xe504f42d\n"
> +                 HLX_ST6
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_v(6);
> +}
> +
> +/* Ldd16=xor(Luu16,Lvv16) */
> +static inline HLX_VectorPair
> +Q6_LW_xor_LWLW(HLX_VectorPair luu,
> +               HLX_VectorPair lvv)
> +{
> +    hlx_put_vp(0, luu);
> +    hlx_put_vp(2, lvv);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD1 HLX_LD2 HLX_LD3
> +                 ".word 0xef24e02c\n"
> +                 HLX_ST6 HLX_ST7
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    return hlx_get_vp(6);
> +}
> +
> +#endif /* HLX_ASM_H */
> diff --git a/tests/tcg/hexagon/hlx_assign_conv.c b/tests/tcg/hexagon/hlx_assign_conv.c
> new file mode 100644
> index 0000000000..8192882b8e
> --- /dev/null
> +++ b/tests/tcg/hexagon/hlx_assign_conv.c
> @@ -0,0 +1,354 @@
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "hlx_test.h"
> +
> +/* Broadcast constants for uniform buffer init */
> +#define VAL_A       ((int16_t)0x1234)
> +#define VAL_B       ((int16_t)0x5678)
> +#define VAL_C       ((int16_t)-300)       /* 0xFED4 -- negative for mux test */
> +#define VAL_W       ((int32_t)0x12345678)
> +
> +static uint16_t *buf_a;
> +static uint16_t *buf_b;
> +static uint16_t *buf_c;
> +static uint16_t *buf_out;
> +static uint16_t expected[HLX_HALF_ELEMS];
> +
> +static uint32_t *pw_out_lo;
> +static uint32_t *pw_out_hi;
> +static uint32_t *pw_a_lo;
> +static uint32_t *pw_a_hi;
> +static uint32_t expected_w[HLX_HALF_ELEMS];
> +
> +static inline uint32_t pack_h(uint16_t lo, uint16_t hi)
> +{
> +    return ((uint32_t)hi << 16) | lo;
> +}
> +
> +static void fill_h(uint16_t *buf, int16_t val)
> +{
> +    Q6_mem_Ku16_new_AL(buf, Q6_Lh_equals_Rh(val));
> +}
> +
> +static void fill_w(uint32_t *buf_lo, uint32_t *buf_hi, int32_t val)
> +{
> +    HLX_VectorPair wp = Q6_LWw_equals_Rw(val);
> +    Q6_mem_Ku16_new_AL((uint16_t *)buf_lo, Q6_L_lo_LW(wp));
> +    Q6_mem_Ku16_new_AL((uint16_t *)buf_hi, Q6_L_hi_LW(wp));
> +}
> +
> +
> +static void test_assign(void)
> +{
> +    HLX_Vector la;
> +
> +    fill_h(buf_a, VAL_A);
> +
> +    la = Q6_L_tmp_mem_A(buf_a);
> +    Q6_mem_Ku16_new_AL(buf_out, Q6_Lh_equals_Lh(la));
> +
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        expected[i] = (uint16_t)VAL_A;
> +    }
> +    check_h("LX_assign", buf_out, expected, HLX_HALF_ELEMS);
> +}
> +
> +static void test_assign_w(void)
> +{
> +    HLX_Vector l_lo;
> +    HLX_Vector l_hi;
> +    HLX_VectorPair pp;
> +
> +    fill_w(pw_a_lo, pw_a_hi, VAL_W);
> +
> +    l_lo = Q6_L_tmp_mem_A(pw_a_lo);
> +    l_hi = Q6_L_tmp_mem_A(pw_a_hi);
> +    pp = Q6_LW_combine_LL(l_hi, l_lo);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(pp));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(pp));
> +
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected_w[j] = (uint32_t)VAL_W;
> +    }
> +    check_wp("LX_assign_w", pw_out_lo, pw_out_hi, expected_w, HLX_HALF_ELEMS);
> +}
> +
> +static void test_assign_r(void)
> +{
> +    int16_t scalar = 0x1234;
> +    Q6_mem_Ku16_new_AL(buf_out, Q6_Lh_equals_Rh(scalar));
> +
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        expected[i] = (uint16_t)scalar;
> +    }
> +    check_h("LX_assign_r", buf_out, expected, HLX_HALF_ELEMS);
> +}
> +
> +static void test_assign_s(void)
> +{
> +    Q6_mem_Ku16_new_AL(buf_out, Q6_Lh_equals_Is(-5));
> +
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        expected[i] = (uint16_t)(int16_t)(-5);
> +    }
> +    check_h("LX_assign_s", buf_out, expected, HLX_HALF_ELEMS);
> +}
> +
> +static void test_assign_u(void)
> +{
> +    Q6_mem_Ku16_new_AL(buf_out, Q6_Luh_equals_I(17));
> +
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        expected[i] = 17;
> +    }
> +    check_h("LX_assign_u", buf_out, expected, HLX_HALF_ELEMS);
> +}
> +
> +static void test_assign_rw(void)
> +{
> +    int32_t scalar = 0x12345678;
> +    HLX_VectorPair wp = Q6_LWw_equals_Rw(scalar);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(wp));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(wp));
> +
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected_w[j] = (uint32_t)scalar;
> +    }
> +    check_wp("LX_assign_rw", pw_out_lo, pw_out_hi, expected_w, HLX_HALF_ELEMS);
> +}
> +
> +
> +static void test_combine_w(void)
> +{
> +    HLX_Vector la;
> +    HLX_Vector lb;
> +    HLX_VectorPair pp;
> +    uint32_t exp_val;
> +
> +    fill_h(buf_a, VAL_A);
> +    fill_h(buf_b, VAL_B);
> +
> +    la = Q6_L_tmp_mem_A(buf_a);
> +    lb = Q6_L_tmp_mem_A(buf_b);
> +    pp = Q6_LW_combine_LL(la, lb);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(pp));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(pp));
> +
> +    /* combine(Lu, Lv): l[i].h[1] = Lu.h[i], l[i].h[0] = Lv.h[i] */
> +    exp_val = pack_h((uint16_t)VAL_B, (uint16_t)VAL_A);
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected_w[j] = exp_val;
> +    }
> +    check_wp("LX_combine_w", pw_out_lo, pw_out_hi, expected_w, HLX_HALF_ELEMS);
> +}
> +
> +
> +static void test_mux_h(void)
> +{
> +    HLX_Vector la;
> +    HLX_Vector lc;
> +    HLX_Vector lb;
> +    HLX_Vector res;
> +
> +    fill_h(buf_a, VAL_A);
> +    fill_h(buf_b, VAL_B);
> +    fill_h(buf_c, VAL_C);
> +
> +    /* mux(Lx, Lu, Lv): Lx.h < 0 ? Lu : Lv */
> +    la = Q6_L_tmp_mem_A(buf_a);
> +    lc = Q6_L_tmp_mem_A(buf_c);
> +    lb = Q6_L_tmp_mem_A(buf_b);
> +    res = Q6_Lh_mux_LhLhLh(lb, la, lc);
> +    Q6_mem_Ku16_new_AL(buf_out, res);
> +
> +    /* VAL_C < 0, so mux selects VAL_A for every element */
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        expected[i] = (uint16_t)VAL_A;
> +    }
> +    check_h("LX_mux_h", buf_out, expected, HLX_HALF_ELEMS);
> +}
> +
> +
> +static void test_conv_uw_uh(void)
> +{
> +    HLX_Vector la;
> +    HLX_VectorPair pp;
> +    uint32_t exp_val;
> +
> +    fill_h(buf_a, VAL_A);
> +
> +    la = Q6_L_tmp_mem_A(buf_a);
> +    pp = Q6_LWuw_zxt_Luh(la);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(pp));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(pp));
> +
> +    exp_val = (uint32_t)(uint16_t)VAL_A;
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected_w[j] = exp_val;
> +    }
> +    check_wp("LX_conv_uw_uh", pw_out_lo, pw_out_hi, expected_w, HLX_HALF_ELEMS);
> +}
> +
> +static void test_conv_w_h(void)
> +{
> +    HLX_Vector la;
> +    HLX_VectorPair pp;
> +    uint32_t exp_val;
> +
> +    fill_h(buf_a, VAL_A);
> +
> +    la = Q6_L_tmp_mem_A(buf_a);
> +    pp = Q6_LWw_sxt_Lh(la);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(pp));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(pp));
> +
> +    exp_val = (uint32_t)(int32_t)VAL_A;
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected_w[j] = exp_val;
> +    }
> +    check_wp("LX_conv_w_h", pw_out_lo, pw_out_hi, expected_w, HLX_HALF_ELEMS);
> +}
> +
> +static void test_conv_b_h_hi(void)
> +{
> +    HLX_Vector la;
> +    HLX_Vector lb;
> +    uint8_t hi_a;
> +    uint8_t hi_b;
> +    uint16_t exp_val;
> +
> +    fill_h(buf_a, VAL_A);
> +    fill_h(buf_b, VAL_B);
> +
> +    la = Q6_L_tmp_mem_A(buf_a);
> +    lb = Q6_L_tmp_mem_A(buf_b);
> +    Q6_mem_Ku16_new_AL(buf_out, Q6_Lb_packhi_LhLh(la, lb));
> +
> +    /* packhi: Ld.b[2i+1] = Lu.b[2i+1], Ld.b[2i] = Lv.b[2i+1] */
> +    hi_a = ((uint16_t)VAL_A >> 8) & 0xFF;
> +    hi_b = ((uint16_t)VAL_B >> 8) & 0xFF;
> +    exp_val = ((uint16_t)hi_a << 8) | hi_b;
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        expected[i] = exp_val;
> +    }
> +    check_h("LX_conv_b_h_hi", buf_out, expected, HLX_HALF_ELEMS);
> +}
> +
> +static void test_conv_b_h_lo(void)
> +{
> +    HLX_Vector la;
> +    HLX_Vector lb;
> +    uint8_t lo_a;
> +    uint8_t lo_b;
> +    uint16_t exp_val;
> +
> +    fill_h(buf_a, VAL_A);
> +    fill_h(buf_b, VAL_B);
> +
> +    la = Q6_L_tmp_mem_A(buf_a);
> +    lb = Q6_L_tmp_mem_A(buf_b);
> +    Q6_mem_Ku16_new_AL(buf_out, Q6_Lb_packlo_LhLh(la, lb));
> +
> +    /* packlo: Ld.b[2i+1] = Lu.b[2i], Ld.b[2i] = Lv.b[2i] */
> +    lo_a = (uint16_t)VAL_A & 0xFF;
> +    lo_b = (uint16_t)VAL_B & 0xFF;
> +    exp_val = ((uint16_t)lo_a << 8) | lo_b;
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        expected[i] = exp_val;
> +    }
> +    check_h("LX_conv_b_h_lo", buf_out, expected, HLX_HALF_ELEMS);
> +}
> +
> +static void test_conv_h_b_hi(void)
> +{
> +    HLX_Vector la;
> +    HLX_VectorPair pp;
> +    uint8_t hi_byte;
> +    uint8_t lo_byte;
> +    uint32_t exp_val;
> +
> +    fill_h(buf_a, VAL_A);
> +
> +    la = Q6_L_tmp_mem_A(buf_a);
> +    pp = Q6_LWh_unpackhi_Lb(la);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(pp));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(pp));
> +
> +    /* unpackhi: b[3] = Lu.b[2i+1], b[1] = Lu.b[2i], b[0]=b[2]=0 */
> +    hi_byte = ((uint16_t)VAL_A >> 8) & 0xFF;
> +    lo_byte = (uint16_t)VAL_A & 0xFF;
> +    exp_val = ((uint32_t)hi_byte << 24) | ((uint32_t)lo_byte << 8);
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected_w[j] = exp_val;
> +    }
> +    check_wp("LX_conv_h_b_hi", pw_out_lo, pw_out_hi,
> +             expected_w, HLX_HALF_ELEMS);
> +}
> +
> +static void test_conv_h_b_lo(void)
> +{
> +    HLX_Vector la;
> +    HLX_VectorPair pp;
> +    uint8_t hi_byte;
> +    uint8_t lo_byte;
> +    uint32_t exp_val;
> +
> +    fill_h(buf_a, VAL_A);
> +
> +    la = Q6_L_tmp_mem_A(buf_a);
> +    pp = Q6_LWh_unpacklo_Lb(la);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(pp));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(pp));
> +
> +    /* unpacklo: b[2] = Lu.b[2i+1], b[0] = Lu.b[2i] */
> +    hi_byte = ((uint16_t)VAL_A >> 8) & 0xFF;
> +    lo_byte = (uint16_t)VAL_A & 0xFF;
> +    exp_val = ((uint32_t)hi_byte << 16) | lo_byte;
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected_w[j] = exp_val;
> +    }
> +    check_wp("LX_conv_h_b_lo", pw_out_lo, pw_out_hi,
> +             expected_w, HLX_HALF_ELEMS);
> +}
> +
> +int main(void)
> +{
> +    init_vtcm();
> +    enable_hlx();
> +
> +    buf_a = vtcm_alloc(HLX_HALF_ELEMS * sizeof(uint16_t));
> +    buf_b = vtcm_alloc(HLX_HALF_ELEMS * sizeof(uint16_t));
> +    buf_c = vtcm_alloc(HLX_HALF_ELEMS * sizeof(uint16_t));
> +    buf_out = vtcm_alloc(HLX_HALF_ELEMS * sizeof(uint16_t));
> +    pw_out_lo = vtcm_alloc(HLX_WORD_ELEMS * sizeof(uint32_t));
> +    pw_out_hi = vtcm_alloc(HLX_WORD_ELEMS * sizeof(uint32_t));
> +    pw_a_lo = vtcm_alloc(HLX_WORD_ELEMS * sizeof(uint32_t));
> +    pw_a_hi = vtcm_alloc(HLX_WORD_ELEMS * sizeof(uint32_t));
> +    init_hlx_vsp();
> +
> +    /* Assign operations */
> +    test_assign();
> +    test_assign_w();
> +    test_assign_r();
> +    test_assign_s();
> +    test_assign_u();
> +    test_assign_rw();
> +
> +    /* Combine and mux */
> +    test_combine_w();
> +    test_mux_h();
> +
> +    /* Conversions */
> +    test_conv_uw_uh();
> +    test_conv_w_h();
> +    test_conv_b_h_hi();
> +    test_conv_b_h_lo();
> +    test_conv_h_b_hi();
> +    test_conv_h_b_lo();
> +
> +    puts(err ? "FAIL" : "PASS");
> +    return err;
> +}
> diff --git a/tests/tcg/hexagon/hlx_basic.c b/tests/tcg/hexagon/hlx_basic.c
> new file mode 100644
> index 0000000000..7bc55f70fe
> --- /dev/null
> +++ b/tests/tcg/hexagon/hlx_basic.c
> @@ -0,0 +1,119 @@
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "hlx_test.h"
> +
> +#define ADD_A           100
> +#define ADD_B           200
> +#define PATTERN_EVEN    ((int16_t)0xAAAA)
> +#define PATTERN_ODD     0x5555
> +
> +static uint16_t *buf_a;
> +static uint16_t *buf_b;
> +static uint16_t *buf_out;
> +static uint16_t expected[HLX_HALF_ELEMS];
> +
> +/*
> + * Test: Halfword add - validates load/compute/store pipeline
> + */
> +static void test_add_h(void)
> +{
> +    HLX_Vector vb;
> +    HLX_Vector la;
> +    HLX_Vector lb;
> +    HLX_Vector va = Q6_Lh_equals_Rh(ADD_A);
> +    Q6_mem_Ku16_new_AL(buf_a, va);
> +
> +    vb = Q6_Lh_equals_Rh(ADD_B);
> +    Q6_mem_Ku16_new_AL(buf_b, vb);
> +
> +    la = Q6_L_tmp_mem_A(buf_a);
> +    lb = Q6_L_tmp_mem_A(buf_b);
> +    Q6_mem_Ku16_new_AL(buf_out, Q6_Lh_add_LhLh(la, lb));
> +
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        expected[i] = ADD_A + ADD_B;
> +    }
> +    check_h("add_h", buf_out, expected, HLX_HALF_ELEMS);
> +}
> +
> +/*
> + * Test: Logical AND
> + */
> +static void test_and(void)
> +{
> +    HLX_Vector la;
> +    HLX_Vector lb;
> +
> +    Q6_mem_Ku16_new_AL(buf_a, Q6_Lh_equals_Rh(PATTERN_EVEN));
> +    Q6_mem_Ku16_new_AL(buf_b, Q6_Lh_equals_Rh(PATTERN_ODD));
> +
> +    la = Q6_L_tmp_mem_A(buf_a);
> +    lb = Q6_L_tmp_mem_A(buf_b);
> +    Q6_mem_Ku16_new_AL(buf_out, Q6_L_and_LL(la, lb));
> +
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        expected[i] = (uint16_t)PATTERN_EVEN & PATTERN_ODD;
> +    }
> +    check_h("and", buf_out, expected, HLX_HALF_ELEMS);
> +}
> +
> +/*
> + * Test: Logical OR
> + */
> +static void test_or(void)
> +{
> +    HLX_Vector la;
> +    HLX_Vector lb;
> +
> +    Q6_mem_Ku16_new_AL(buf_a, Q6_Lh_equals_Rh(PATTERN_EVEN));
> +    Q6_mem_Ku16_new_AL(buf_b, Q6_Lh_equals_Rh(PATTERN_ODD));
> +
> +    la = Q6_L_tmp_mem_A(buf_a);
> +    lb = Q6_L_tmp_mem_A(buf_b);
> +    Q6_mem_Ku16_new_AL(buf_out, Q6_L_or_LL(la, lb));
> +
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        expected[i] = (uint16_t)PATTERN_EVEN | PATTERN_ODD;
> +    }
> +    check_h("or", buf_out, expected, HLX_HALF_ELEMS);
> +}
> +
> +/*
> + * Test: Logical NOT
> + */
> +static void test_not(void)
> +{
> +    HLX_Vector la;
> +
> +    Q6_mem_Ku16_new_AL(buf_a, Q6_Lh_equals_Rh(PATTERN_EVEN));
> +
> +    la = Q6_L_tmp_mem_A(buf_a);
> +    Q6_mem_Ku16_new_AL(buf_out, Q6_L_not_L(la));
> +
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        expected[i] = (uint16_t)~(uint16_t)PATTERN_EVEN;
> +    }
> +    check_h("not", buf_out, expected, HLX_HALF_ELEMS);
> +}
> +
> +int main(void)
> +{
> +    init_vtcm();
> +    enable_hlx();
> +
> +    buf_a = vtcm_alloc(HLX_HALF_ELEMS * sizeof(uint16_t));
> +    buf_b = vtcm_alloc(HLX_HALF_ELEMS * sizeof(uint16_t));
> +    buf_out = vtcm_alloc(HLX_HALF_ELEMS * sizeof(uint16_t));
> +    init_hlx_vsp();
> +
> +    test_add_h();
> +    test_and();
> +    test_or();
> +    test_not();
> +
> +    puts(err ? "FAIL" : "PASS");
> +    return err;
> +}
> diff --git a/tests/tcg/hexagon/hlx_lanes.c b/tests/tcg/hexagon/hlx_lanes.c
> new file mode 100644
> index 0000000000..752967df8b
> --- /dev/null
> +++ b/tests/tcg/hexagon/hlx_lanes.c
> @@ -0,0 +1,455 @@
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +/*
> + * Run every intrinsic of hlx_asm.h on inputs that differ in each lane, and
> + * compare a checksum of the result with the value from the reference
> + * simulator (hexagon-sim -mv85qa_1).  The inputs cover both signs, the
> + * saturation limits, and shift amounts on both sides of zero.
> + */
> +
> +#include "hlx_test.h"
> +
> +static HLX_Vector va, vb, vc, vd;
> +static HLX_VectorPair pa, pb, pc;
> +
> +/* Values that hit the corner cases, mixed with a pseudo-random sequence */
> +static const uint16_t corners[] = {
> +    0x0000, 0x0001, 0x7fff, 0x8000, 0x8001, 0xffff, 0xfffe, 0x00ff,
> +    0xff00, 0x0010, 0xfff0, 0x0021, 0xffdf, 0x4000, 0xc000, 0x1234,
> +};
> +
> +static void fill(HLX_Vector *v, uint32_t seed)
> +{
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        seed = seed * 1103515245u + 12345u;
> +        v->h[i] = (i % 3 == 0) ? corners[(i / 3 + seed) % 16]
> +                               : (uint16_t)(seed >> 16);
> +    }
> +}
> +
> +/* Small signed values, for operands that are shift amounts */
> +static void fill_shamt(HLX_Vector *v, uint32_t seed)
> +{
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        seed = seed * 1103515245u + 12345u;
> +        v->h[i] = (uint16_t)((int)((seed >> 16) % 41) - 20);
> +    }
> +}
> +
> +static void init_inputs(void)
> +{
> +    fill(&va, 1);
> +    fill(&vb, 2);
> +    fill_shamt(&vc, 3);
> +    fill(&vd, 10);
> +    fill(&pa.lo, 4);
> +    fill(&pa.hi, 5);
> +    fill(&pb.lo, 6);
> +    fill(&pb.hi, 7);
> +    fill_shamt(&pc.lo, 8);
> +    fill_shamt(&pc.hi, 9);
> +}
> +
> +/* FNV-1a over the result; the lane index is part of the hash */
> +static uint32_t hash_v(uint32_t h, const HLX_Vector *v)
> +{
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        h = (h ^ v->h[i]) * 16777619u;
> +    }
> +    return h;
> +}
> +
> +static uint32_t hash(const void *p, size_t size)
> +{
> +    const HLX_Vector *v = p;
> +    uint32_t h = 2166136261u;
> +
> +    for (size_t i = 0; i < size / sizeof(HLX_Vector); i++) {
> +        h = hash_v(h, &v[i]);
> +    }
> +    return h;
> +}
> +
> +#define RUN(EXPR) \
> +    do { \
> +        __typeof__(EXPR) r_ = (EXPR); \
> +        record(#EXPR, hash(&r_, sizeof(r_))); \
> +    } while (0)
> +
> +static const struct {
> +    const char *name;
> +    uint32_t hash;
> +} refs[] = {
> +    { "Q6_Luh_abs_Lh(va)", 0xe208ed39 },
> +    { "Q6_Lh_abs_Lh_sat(va)", 0xe208ed39 },
> +    { "Q6_LWuh_abs_LWh(pa)", 0x74782dca },
> +    { "Q6_LWh_abs_LWh_sat(pa)", 0x74782dca },
> +    { "Q6_LWuw_abs_LWw(pa)", 0xdee4d30d },
> +    { "Q6_LWw_abs_LWw_sat(pa)", 0xdee4d30d },
> +    { "Q6_Luh_absdiff_LhLh(va, vb)", 0x9ee5549c },
> +    { "Q6_Luh_absdiff_LuhLuh(va, vb)", 0x862d481c },
> +    { "Q6_LWuw_absdiff_LWuwLWuw(pa, pb)", 0xba0386ea },
> +    { "Q6_LWuw_absdiff_LWwLWw(pa, pb)", 0x2ae4bcdd },
> +    { "Q6_Lh_add_LhLh(va, vb)", 0xd4fc73ee },
> +    { "Q6_Lh_add_LhLh_sat(va, vb)", 0x89a0022a },
> +    { "Q6_LWh_add_LWhLWh(pa, pb)", 0x42d44fc6 },
> +    { "Q6_LWh_add_LWhLWh_sat(pa, pb)", 0x92e5270d },
> +    { "Q6_Luh_add_LuhLuh_sat(va, vb)", 0x7bc2dc15 },
> +    { "Q6_Luh_add_LhLh_sat(va, vb)", 0x99c92690 },
> +    { "Q6_LWuh_add_LWhLWh_sat(pa, pb)", 0x4c51008f },
> +    { "Q6_LWuh_add_LWuhLWuh_sat(pa, pb)", 0x1e245da0 },
> +    { "Q6_LWuw_add_LWuwLWuw_sat(pa, pb)", 0x02895b4e },
> +    { "Q6_LWuw_add_LWwLWw_sat(pa, pb)", 0x02700fbe },
> +    { "Q6_LWw_add_LWwLWw(pa, pb)", 0x6b8dae20 },
> +    { "Q6_LWw_add_LWwLWw_sat(pa, pb)", 0xbe188e99 },
> +    { "Q6_LWw_add_LuhLuh(va, vb)", 0xfb54d181 },
> +    { "Q6_LWw_add_LWwLh(pa, va)", 0xe1a91d98 },
> +    { "Q6_LWw_add_LWwLuh(pa, va)", 0x95d9e358 },
> +    { "Q6_L_and_LL(va, vb)", 0x6c4a260f },
> +    { "Q6_LW_and_LWLW(pa, pb)", 0xe7b38739 },
> +    { "Q6_L_andn_LL(va, vb)", 0xef59c6e5 },
> +    { "Q6_LW_andn_LWLW(pa, pb)", 0x3845ed10 },
> +    { "Q6_Lh_equals_Lh(va)", 0xa7cbb137 },
> +    { "Q6_Lh_equals_Rh(0x8003fff7u)", 0xf513a9c5 },
> +    { "Q6_LWw_equals_Rw(0x8003fff7u)", 0x78229dc5 },
> +    { "Q6_Lh_avg_LhLh(va, vb)", 0x35b56e25 },
> +    { "Q6_Lh_avg_LhLh_rnd(va, vb)", 0xb5c0023a },
> +    { "Q6_Luh_avg_LuhLuh(va, vb)", 0x688f6e25 },
> +    { "Q6_Luh_avg_LuhLuh_rnd(va, vb)", 0x91f7023a },
> +    { "Q6_LWuw_avg_LWuwLWuw(pa, pb)", 0xffaf0ec2 },
> +    { "Q6_LWuw_avg_LWuwLWuw_rnd(pa, pb)", 0xb711deea },
> +    { "Q6_LWw_avg_LWwLWw(pa, pb)", 0x5bfc8ec2 },
> +    { "Q6_LWw_avg_LWwLWw_rnd(pa, pb)", 0x5bb25eea },
> +    { "Q6_Lh_cmp_gt_LhLh(va, vb)", 0x298abd92 },
> +    { "Q6_LWh_cmp_gt_LWhLWh(pa, pb)", 0xba856439 },
> +    { "Q6_Lh_cmp_gt_LuhLuh(va, vb)", 0x5ed1611c },
> +    { "Q6_LWh_cmp_gt_LWuhLWuh(pa, pb)", 0x6721933f },
> +    { "Q6_LWw_cmp_gt_LWuwLWuw(pa, pb)", 0xa22f6dc5 },
> +    { "Q6_LWw_cmp_gt_LWwLWw(pa, pb)", 0x072b56b1 },
> +    { "Q6_Lb_packhi_LhLh(va, vb)", 0x64b5261a },
> +    { "Q6_Lb_packlo_LhLh(va, vb)", 0x63f3c4c8 },
> +    { "Q6_LWh_unpackhi_Lb(va)", 0x24e6aec5 },
> +    { "Q6_LWh_unpacklo_Lb(va)", 0x2416b6b0 },
> +    { "Q6_LWuw_zxt_Luh(va)", 0x314ca137 },
> +    { "Q6_LWw_sxt_Lh(va)", 0x6fa3a531 },
> +    { "Q6_Lh_lut4_LuhPh(va, 0x8001400220037ffcull)", 0x85ece3b4 },
> +    { "Q6_Lh_lut4_LuhPh_mask(va, 0x8001400220037ffcull)", 0x85eabb7f },
> +    { "Q6_LWw_lut4_LuhPuh_rs1(va, 0x8001400220037ffcull)", 0xc6c71e5a },
> +    { "Q6_LWw_lut4_LuhPuh_rs1_neg(va, 0x8001400220037ffcull)", 0x967a1e5a },
> +    { "Q6_Lh_max_LhLh(va, vb)", 0xa2280b7f },
> +    { "Q6_LWh_max_LWhLWh(pa, pb)", 0x54976798 },
> +    { "Q6_Luh_max_LuhLuh(va, vb)", 0x10e49b8d },
> +    { "Q6_LWuh_max_LWuhLWuh(pa, pb)", 0x7beb3ada },
> +    { "Q6_LWuw_max_LWuwLWuw(pa, pb)", 0x22b0216e },
> +    { "Q6_LWw_max_LWwLWw(pa, pb)", 0x9db97202 },
> +    { "Q6_Lh_min_LhLh(va, vb)", 0xb9bbad5c },
> +    { "Q6_LWh_min_LWhLWh(pa, pb)", 0x3f5c87ef },
> +    { "Q6_Luh_min_LuhLuh(va, vb)", 0x88885262 },
> +    { "Q6_LWuh_min_LWuhLWuh(pa, pb)", 0x19535359 },
> +    { "Q6_LWuw_min_LWuwLWuw(pa, pb)", 0xa9cc9df5 },
> +    { "Q6_LWw_min_LWwLWw(pa, pb)", 0x2d4e5035 },
> +    { "Q6_LWuw_add_mpy_hi_LuhLWuhLWw(va, pa, pb)", 0xb10a0e04 },
> +    { "Q6_LWw_mpyacc_LhLh(pa, va, vb)", 0x5a128fd8 },
> +    { "Q6_LWuw_add_mpy_hi_LhLuhLWuh(va, vb, pa)", 0xa7a992fe },
> +    { "Q6_LWw_mpyacc_LhLuh(pa, va, vb)", 0x32860054 },
> +    { "Q6_LWw_add_mpy_lo_LhLuhLWuh(va, vb, pa)", 0x2bb52f8b },
> +    { "Q6_LWw_mpyacc_LuhLuh(pa, va, vb)", 0x6e06afd3 },
> +    { "Q6_LWuw_add_mpy_hi_LuhLuhLWuh(va, vb, pa)", 0x7e000f51 },
> +    { "Q6_LWuw_add_mpy_lo_LuhLuhLWuh(va, vb, pa)", 0xf8b44e16 },
> +    { "Q6_LWw_add_mpy_hi_LuhLWhLWw(va, pa, pb)", 0x8d70f878 },
> +    { "Q6_LWuw_add_mpy_hi_LuhLWuhRw(va, pa, 0x8003fff7u)", 0x9e247fea },
> +    { "Q6_LWw_mpyacc_LhRh(pa, va, 0x8003fff7u)", 0x49c5558a },
> +    { "Q6_LWuw_add_mpy_hi_LhRuhLWuh(va, 0x8003fff7u, pa)", 0x81094382 },
> +    { "Q6_LWw_mpyacc_LhRuh(pa, va, 0x8003fff7u)", 0xf8af5c2e },
> +    { "Q6_LWw_add_mpy_lo_LhRuhLWuh(va, 0x8003fff7u, pa)", 0xfeadbfad },
> +    { "Q6_LWw_mpyacc_LuhRuh(pa, va, 0x8003fff7u)", 0x78eaea72 },
> +    { "Q6_LWuw_add_mpy_hi_LuhRuhLWuh(va, 0x8003fff7u, pa)", 0x19c9c382 },
> +    { "Q6_LWuw_add_mpy_lo_LuhRuhLWuh(va, 0x8003fff7u, pa)", 0x09c1eb27 },
> +    { "Q6_LWw_add_mpy_hi_LuhLWhRw(va, pa, 0x8003fff7u)", 0x441e6eb6 },
> +    { "Q6_LWuw_mpy_LuhLuh(va, vb)", 0x897f396a },
> +    { "Q6_LWw_mpy_LhLh(va, vb)", 0x3cd908a1 },
> +    { "Q6_LWw_mpy_LhLuh(va, vb)", 0x5f06285b },
> +    { "Q6_LWuw_mpy_LuhRuh(va, 0x8003fff7u)", 0x142eba14 },
> +    { "Q6_LWw_mpy_LhRh(va, 0x8003fff7u)", 0x8b1fd45c },
> +    { "Q6_LWw_mpy_LhRuh(va, 0x8003fff7u)", 0x96278c28 },
> +    { "Q6_Lh_mux_LhLhLh(va, vb, vd)", 0x3f84f4d3 },
> +    { "Q6_Lh_navg_LhLh(va, vb)", 0xb6e258de },
> +    { "Q6_Lh_navg_LuhLuh(va, vb)", 0x268358de },
> +    { "Q6_LWw_navg_LWuwLWuw(pa, pb)", 0xdac7a17f },
> +    { "Q6_LWw_navg_LWwLWw(pa, pb)", 0xedb5217f },
> +    { "Q6_L_not_L(va)", 0xec113827 },
> +    { "Q6_LW_not_LW(pa)", 0xa5cde948 },
> +    { "Q6_L_or_LL(va, vb)", 0x3479ea88 },
> +    { "Q6_LW_or_LWLW(pa, pb)", 0xcdcd4ac2 },
> +    { "Q6_L_orn_LL(va, vb)", 0x12daa3b2 },
> +    { "Q6_LW_orn_LWLW(pa, pb)", 0x69680f57 },
> +    { "Q6_Lh_shr_LhLh(va, vc)", 0xbcf72dec },
> +    { "Q6_Lh_shr_LWwLh_rnd_sat(pa, vc)", 0xceb3bba7 },
> +    { "Q6_Lh_shr_LWwLh_sat(pa, vc)", 0x2cb1f5ef },
> +    { "Q6_Lh_shr_LWwLuh(pa, vc)", 0x2c62cfec },
> +    { "Q6_Luh_shr_LuhLh(va, vc)", 0xc59d9a2d },
> +    { "Q6_Luh_shr_LWuwLh_rnd_sat(pa, vc)", 0x09f60d4f },
> +    { "Q6_Luh_shr_LWuwLh_sat(pa, vc)", 0x4604930b },
> +    { "Q6_Luh_shr_LWwLh_rnd_sat(pa, vc)", 0x90446497 },
> +    { "Q6_Luh_shr_LWwLh_sat(pa, vc)", 0x280313b6 },
> +    { "Q6_LWuw_shr_LWuwLh(pa, vc)", 0x4e213370 },
> +    { "Q6_LWw_shr_LWwLh(pa, vc)", 0x9cb55f22 },
> +    { "Q6_Lh_shracc_LhLh(va, vb, vc)", 0x79f50ab7 },
> +    { "Q6_Lh_shracc_LuhLh(va, vb, vc)", 0xdb4f251b },
> +    { "Q6_LWw_shracc_LWuwLh(pa, pb, vc)", 0x544f508c },
> +    { "Q6_LWw_shracc_LWwLh(pa, pb, vc)", 0xcf47b87d },
> +    { "Q6_Lh_shracc_LhRh(va, vb, 0x7ffefffbu)", 0x51b09f57 },
> +    { "Q6_Lh_shracc_LhRh(va, vb, 0x80010007u)", 0x292e5f78 },
> +    { "Q6_Lh_shracc_LuhRh(va, vb, 0x7ffefffbu)", 0x51b09f57 },
> +    { "Q6_Lh_shracc_LuhRh(va, vb, 0x80010007u)", 0x70a6bf78 },
> +    { "Q6_LWw_shracc_LWuwRh(pa, pb, 0x7ffefffbu)", 0xd70d3b57 },
> +    { "Q6_LWw_shracc_LWuwRh(pa, pb, 0x80010007u)", 0xe694b5e3 },
> +    { "Q6_LWw_shracc_LWwRh(pa, pb, 0x7ffefffbu)", 0xd70d3b57 },
> +    { "Q6_LWw_shracc_LWwRh(pa, pb, 0x80010007u)", 0xc9032de3 },
> +    { "Q6_Lh_shr_LhRh(va, 0x7ffefffbu)", 0x70ede845 },
> +    { "Q6_Lh_shr_LhRh(va, 0x80010007u)", 0x37a5547d },
> +    { "Q6_Lh_shr_LWwRh_rnd_sat(pa, 0x7ffefffbu)", 0x90219110 },
> +    { "Q6_Lh_shr_LWwRh_rnd_sat(pa, 0x80010007u)", 0xbb6803ae },
> +    { "Q6_Lh_shr_LWwRh_sat(pa, 0x7ffefffbu)", 0x90219110 },
> +    { "Q6_Lh_shr_LWwRh_sat(pa, 0x80010007u)", 0x949be419 },
> +    { "Q6_Lh_shr_LWwRuh(pa, 0x7ffefffbu)", 0xe02116d2 },
> +    { "Q6_Lh_shr_LWwRuh(pa, 0x80010007u)", 0x40ad898b },
> +    { "Q6_Luh_shr_LuhRh(va, 0x7ffefffbu)", 0x70ede845 },
> +    { "Q6_Luh_shr_LuhRh(va, 0x80010007u)", 0xbc0b287d },
> +    { "Q6_Luh_shr_LWuwRh_rnd_sat(pa, 0x7ffefffbu)", 0x4c7f29c5 },
> +    { "Q6_Luh_shr_LWuwRh_rnd_sat(pa, 0x80010007u)", 0x7c412f37 },
> +    { "Q6_Luh_shr_LWuwRh_sat(pa, 0x7ffefffbu)", 0x4c7f29c5 },
> +    { "Q6_Luh_shr_LWuwRh_sat(pa, 0x80010007u)", 0x7c412f37 },
> +    { "Q6_Luh_shr_LWwRh_rnd_sat(pa, 0x7ffefffbu)", 0xe1199110 },
> +    { "Q6_Luh_shr_LWwRh_rnd_sat(pa, 0x80010007u)", 0xf37903c2 },
> +    { "Q6_Luh_shr_LWwRh_sat(pa, 0x7ffefffbu)", 0xe1199110 },
> +    { "Q6_Luh_shr_LWwRh_sat(pa, 0x80010007u)", 0xf37903c2 },
> +    { "Q6_LWuw_shr_LWuwRh(pa, 0x7ffefffbu)", 0x19bae0d2 },
> +    { "Q6_LWuw_shr_LWuwRh(pa, 0x80010007u)", 0xd5a0f236 },
> +    { "Q6_LWw_shr_LWwRh(pa, 0x7ffefffbu)", 0x19bae0d2 },
> +    { "Q6_LWw_shr_LWwRh(pa, 0x80010007u)", 0xa20a4436 },
> +    { "Q6_Lh_sub_LhLh(va, vb)", 0xfafb43a8 },
> +    { "Q6_Lh_sub_LhLh_sat(va, vb)", 0x8b8ef26a },
> +    { "Q6_LWh_sub_LWhLWh(pa, pb)", 0xf28311d2 },
> +    { "Q6_LWh_sub_LWhLWh_sat(pa, pb)", 0x7656ec67 },
> +    { "Q6_Luh_sub_LuhLuh_sat(va, vb)", 0x557fb708 },
> +    { "Q6_Luh_sub_LhLh_sat(va, vb)", 0xde83c0e6 },
> +    { "Q6_LWuh_sub_LWhLWh_sat(pa, pb)", 0x6b4c37a4 },
> +    { "Q6_LWuh_sub_LWuhLWuh_sat(pa, pb)", 0x64e25576 },
> +    { "Q6_LWuw_sub_LWuwLWuw_sat(pa, pb)", 0x6df5cd38 },
> +    { "Q6_LWuw_sub_LWwLWw_sat(pa, pb)", 0xb6390227 },
> +    { "Q6_LWw_sub_LWwLWw(pa, pb)", 0x4b3aabf3 },
> +    { "Q6_LWw_sub_LWwLWw_sat(pa, pb)", 0xcbddbf89 },
> +    { "Q6_LWw_sub_LuhLuh(va, vb)", 0xf9a49ec1 },
> +    { "Q6_LWw_sub_LWwLh(pa, va)", 0x6076d35d },
> +    { "Q6_LWw_sub_LWwLuh(pa, va)", 0x0e272d6f },
> +    { "Q6_L_xor_LL(va, vb)", 0x8628eede },
> +    { "Q6_LW_xor_LWLW(pa, pb)", 0xaddd6d12 },
> +    { "Q6_Lh_equals_Is(3)", 0x7b4691c5 },
> +    { "Q6_Luh_equals_I(3)", 0x7b4691c5 },
> +    { "Q6_Lh_sub_ilog2_LhI(va, 3)", 0xbc6d0cf2 },
> +    { "Q6_Lh_sub_ilog2_LuhI(va, 3)", 0x34ae4b20 },
> +    { "Q6_Lh_sub_ilog2_LWuwI(pa, 3)", 0xc0c8e5dd },
> +    { "Q6_Lh_sub_ilog2_LWwI(pa, 3)", 0x6f45672a },
> +};
> +
> +static int next_ref;
> +
> +static void record(const char *name, uint32_t h)
> +{
> +    if (strcmp(refs[next_ref].name, name) != 0) {
> +        printf("FAIL table out of order at %s\n", name);
> +        exit(1);
> +    }
> +    if (refs[next_ref].hash != h) {
> +        printf("FAIL %s: expected 0x%08lx, got 0x%08lx\n", name,
> +               (unsigned long)refs[next_ref].hash, (unsigned long)h);
> +        err++;
> +    }
> +    next_ref++;
> +}
> +
> +int main(void)
> +{
> +    init_vtcm();
> +    enable_hlx();
> +    init_inputs();
> +
> +    RUN(Q6_Luh_abs_Lh(va));
> +    RUN(Q6_Lh_abs_Lh_sat(va));
> +    RUN(Q6_LWuh_abs_LWh(pa));
> +    RUN(Q6_LWh_abs_LWh_sat(pa));
> +    RUN(Q6_LWuw_abs_LWw(pa));
> +    RUN(Q6_LWw_abs_LWw_sat(pa));
> +    RUN(Q6_Luh_absdiff_LhLh(va, vb));
> +    RUN(Q6_Luh_absdiff_LuhLuh(va, vb));
> +    RUN(Q6_LWuw_absdiff_LWuwLWuw(pa, pb));
> +    RUN(Q6_LWuw_absdiff_LWwLWw(pa, pb));
> +    RUN(Q6_Lh_add_LhLh(va, vb));
> +    RUN(Q6_Lh_add_LhLh_sat(va, vb));
> +    RUN(Q6_LWh_add_LWhLWh(pa, pb));
> +    RUN(Q6_LWh_add_LWhLWh_sat(pa, pb));
> +    RUN(Q6_Luh_add_LuhLuh_sat(va, vb));
> +    RUN(Q6_Luh_add_LhLh_sat(va, vb));
> +    RUN(Q6_LWuh_add_LWhLWh_sat(pa, pb));
> +    RUN(Q6_LWuh_add_LWuhLWuh_sat(pa, pb));
> +    RUN(Q6_LWuw_add_LWuwLWuw_sat(pa, pb));
> +    RUN(Q6_LWuw_add_LWwLWw_sat(pa, pb));
> +    RUN(Q6_LWw_add_LWwLWw(pa, pb));
> +    RUN(Q6_LWw_add_LWwLWw_sat(pa, pb));
> +    RUN(Q6_LWw_add_LuhLuh(va, vb));
> +    RUN(Q6_LWw_add_LWwLh(pa, va));
> +    RUN(Q6_LWw_add_LWwLuh(pa, va));
> +    RUN(Q6_L_and_LL(va, vb));
> +    RUN(Q6_LW_and_LWLW(pa, pb));
> +    RUN(Q6_L_andn_LL(va, vb));
> +    RUN(Q6_LW_andn_LWLW(pa, pb));
> +    RUN(Q6_Lh_equals_Lh(va));
> +    RUN(Q6_Lh_equals_Rh(0x8003fff7u));
> +    RUN(Q6_LWw_equals_Rw(0x8003fff7u));
> +    RUN(Q6_Lh_avg_LhLh(va, vb));
> +    RUN(Q6_Lh_avg_LhLh_rnd(va, vb));
> +    RUN(Q6_Luh_avg_LuhLuh(va, vb));
> +    RUN(Q6_Luh_avg_LuhLuh_rnd(va, vb));
> +    RUN(Q6_LWuw_avg_LWuwLWuw(pa, pb));
> +    RUN(Q6_LWuw_avg_LWuwLWuw_rnd(pa, pb));
> +    RUN(Q6_LWw_avg_LWwLWw(pa, pb));
> +    RUN(Q6_LWw_avg_LWwLWw_rnd(pa, pb));
> +    RUN(Q6_Lh_cmp_gt_LhLh(va, vb));
> +    RUN(Q6_LWh_cmp_gt_LWhLWh(pa, pb));
> +    RUN(Q6_Lh_cmp_gt_LuhLuh(va, vb));
> +    RUN(Q6_LWh_cmp_gt_LWuhLWuh(pa, pb));
> +    RUN(Q6_LWw_cmp_gt_LWuwLWuw(pa, pb));
> +    RUN(Q6_LWw_cmp_gt_LWwLWw(pa, pb));
> +    RUN(Q6_Lb_packhi_LhLh(va, vb));
> +    RUN(Q6_Lb_packlo_LhLh(va, vb));
> +    RUN(Q6_LWh_unpackhi_Lb(va));
> +    RUN(Q6_LWh_unpacklo_Lb(va));
> +    RUN(Q6_LWuw_zxt_Luh(va));
> +    RUN(Q6_LWw_sxt_Lh(va));
> +    RUN(Q6_Lh_lut4_LuhPh(va, 0x8001400220037ffcull));
> +    RUN(Q6_Lh_lut4_LuhPh_mask(va, 0x8001400220037ffcull));
> +    RUN(Q6_LWw_lut4_LuhPuh_rs1(va, 0x8001400220037ffcull));
> +    RUN(Q6_LWw_lut4_LuhPuh_rs1_neg(va, 0x8001400220037ffcull));
> +    RUN(Q6_Lh_max_LhLh(va, vb));
> +    RUN(Q6_LWh_max_LWhLWh(pa, pb));
> +    RUN(Q6_Luh_max_LuhLuh(va, vb));
> +    RUN(Q6_LWuh_max_LWuhLWuh(pa, pb));
> +    RUN(Q6_LWuw_max_LWuwLWuw(pa, pb));
> +    RUN(Q6_LWw_max_LWwLWw(pa, pb));
> +    RUN(Q6_Lh_min_LhLh(va, vb));
> +    RUN(Q6_LWh_min_LWhLWh(pa, pb));
> +    RUN(Q6_Luh_min_LuhLuh(va, vb));
> +    RUN(Q6_LWuh_min_LWuhLWuh(pa, pb));
> +    RUN(Q6_LWuw_min_LWuwLWuw(pa, pb));
> +    RUN(Q6_LWw_min_LWwLWw(pa, pb));
> +    RUN(Q6_LWuw_add_mpy_hi_LuhLWuhLWw(va, pa, pb));
> +    RUN(Q6_LWw_mpyacc_LhLh(pa, va, vb));
> +    RUN(Q6_LWuw_add_mpy_hi_LhLuhLWuh(va, vb, pa));
> +    RUN(Q6_LWw_mpyacc_LhLuh(pa, va, vb));
> +    RUN(Q6_LWw_add_mpy_lo_LhLuhLWuh(va, vb, pa));
> +    RUN(Q6_LWw_mpyacc_LuhLuh(pa, va, vb));
> +    RUN(Q6_LWuw_add_mpy_hi_LuhLuhLWuh(va, vb, pa));
> +    RUN(Q6_LWuw_add_mpy_lo_LuhLuhLWuh(va, vb, pa));
> +    RUN(Q6_LWw_add_mpy_hi_LuhLWhLWw(va, pa, pb));
> +    RUN(Q6_LWuw_add_mpy_hi_LuhLWuhRw(va, pa, 0x8003fff7u));
> +    RUN(Q6_LWw_mpyacc_LhRh(pa, va, 0x8003fff7u));
> +    RUN(Q6_LWuw_add_mpy_hi_LhRuhLWuh(va, 0x8003fff7u, pa));
> +    RUN(Q6_LWw_mpyacc_LhRuh(pa, va, 0x8003fff7u));
> +    RUN(Q6_LWw_add_mpy_lo_LhRuhLWuh(va, 0x8003fff7u, pa));
> +    RUN(Q6_LWw_mpyacc_LuhRuh(pa, va, 0x8003fff7u));
> +    RUN(Q6_LWuw_add_mpy_hi_LuhRuhLWuh(va, 0x8003fff7u, pa));
> +    RUN(Q6_LWuw_add_mpy_lo_LuhRuhLWuh(va, 0x8003fff7u, pa));
> +    RUN(Q6_LWw_add_mpy_hi_LuhLWhRw(va, pa, 0x8003fff7u));
> +    RUN(Q6_LWuw_mpy_LuhLuh(va, vb));
> +    RUN(Q6_LWw_mpy_LhLh(va, vb));
> +    RUN(Q6_LWw_mpy_LhLuh(va, vb));
> +    RUN(Q6_LWuw_mpy_LuhRuh(va, 0x8003fff7u));
> +    RUN(Q6_LWw_mpy_LhRh(va, 0x8003fff7u));
> +    RUN(Q6_LWw_mpy_LhRuh(va, 0x8003fff7u));
> +    RUN(Q6_Lh_mux_LhLhLh(va, vb, vd));
> +    RUN(Q6_Lh_navg_LhLh(va, vb));
> +    RUN(Q6_Lh_navg_LuhLuh(va, vb));
> +    RUN(Q6_LWw_navg_LWuwLWuw(pa, pb));
> +    RUN(Q6_LWw_navg_LWwLWw(pa, pb));
> +    RUN(Q6_L_not_L(va));
> +    RUN(Q6_LW_not_LW(pa));
> +    RUN(Q6_L_or_LL(va, vb));
> +    RUN(Q6_LW_or_LWLW(pa, pb));
> +    RUN(Q6_L_orn_LL(va, vb));
> +    RUN(Q6_LW_orn_LWLW(pa, pb));
> +    RUN(Q6_Lh_shr_LhLh(va, vc));
> +    RUN(Q6_Lh_shr_LWwLh_rnd_sat(pa, vc));
> +    RUN(Q6_Lh_shr_LWwLh_sat(pa, vc));
> +    RUN(Q6_Lh_shr_LWwLuh(pa, vc));
> +    RUN(Q6_Luh_shr_LuhLh(va, vc));
> +    RUN(Q6_Luh_shr_LWuwLh_rnd_sat(pa, vc));
> +    RUN(Q6_Luh_shr_LWuwLh_sat(pa, vc));
> +    RUN(Q6_Luh_shr_LWwLh_rnd_sat(pa, vc));
> +    RUN(Q6_Luh_shr_LWwLh_sat(pa, vc));
> +    RUN(Q6_LWuw_shr_LWuwLh(pa, vc));
> +    RUN(Q6_LWw_shr_LWwLh(pa, vc));
> +    RUN(Q6_Lh_shracc_LhLh(va, vb, vc));
> +    RUN(Q6_Lh_shracc_LuhLh(va, vb, vc));
> +    RUN(Q6_LWw_shracc_LWuwLh(pa, pb, vc));
> +    RUN(Q6_LWw_shracc_LWwLh(pa, pb, vc));
> +    RUN(Q6_Lh_shracc_LhRh(va, vb, 0x7ffefffbu));
> +    RUN(Q6_Lh_shracc_LhRh(va, vb, 0x80010007u));
> +    RUN(Q6_Lh_shracc_LuhRh(va, vb, 0x7ffefffbu));
> +    RUN(Q6_Lh_shracc_LuhRh(va, vb, 0x80010007u));
> +    RUN(Q6_LWw_shracc_LWuwRh(pa, pb, 0x7ffefffbu));
> +    RUN(Q6_LWw_shracc_LWuwRh(pa, pb, 0x80010007u));
> +    RUN(Q6_LWw_shracc_LWwRh(pa, pb, 0x7ffefffbu));
> +    RUN(Q6_LWw_shracc_LWwRh(pa, pb, 0x80010007u));
> +    RUN(Q6_Lh_shr_LhRh(va, 0x7ffefffbu));
> +    RUN(Q6_Lh_shr_LhRh(va, 0x80010007u));
> +    RUN(Q6_Lh_shr_LWwRh_rnd_sat(pa, 0x7ffefffbu));
> +    RUN(Q6_Lh_shr_LWwRh_rnd_sat(pa, 0x80010007u));
> +    RUN(Q6_Lh_shr_LWwRh_sat(pa, 0x7ffefffbu));
> +    RUN(Q6_Lh_shr_LWwRh_sat(pa, 0x80010007u));
> +    RUN(Q6_Lh_shr_LWwRuh(pa, 0x7ffefffbu));
> +    RUN(Q6_Lh_shr_LWwRuh(pa, 0x80010007u));
> +    RUN(Q6_Luh_shr_LuhRh(va, 0x7ffefffbu));
> +    RUN(Q6_Luh_shr_LuhRh(va, 0x80010007u));
> +    RUN(Q6_Luh_shr_LWuwRh_rnd_sat(pa, 0x7ffefffbu));
> +    RUN(Q6_Luh_shr_LWuwRh_rnd_sat(pa, 0x80010007u));
> +    RUN(Q6_Luh_shr_LWuwRh_sat(pa, 0x7ffefffbu));
> +    RUN(Q6_Luh_shr_LWuwRh_sat(pa, 0x80010007u));
> +    RUN(Q6_Luh_shr_LWwRh_rnd_sat(pa, 0x7ffefffbu));
> +    RUN(Q6_Luh_shr_LWwRh_rnd_sat(pa, 0x80010007u));
> +    RUN(Q6_Luh_shr_LWwRh_sat(pa, 0x7ffefffbu));
> +    RUN(Q6_Luh_shr_LWwRh_sat(pa, 0x80010007u));
> +    RUN(Q6_LWuw_shr_LWuwRh(pa, 0x7ffefffbu));
> +    RUN(Q6_LWuw_shr_LWuwRh(pa, 0x80010007u));
> +    RUN(Q6_LWw_shr_LWwRh(pa, 0x7ffefffbu));
> +    RUN(Q6_LWw_shr_LWwRh(pa, 0x80010007u));
> +    RUN(Q6_Lh_sub_LhLh(va, vb));
> +    RUN(Q6_Lh_sub_LhLh_sat(va, vb));
> +    RUN(Q6_LWh_sub_LWhLWh(pa, pb));
> +    RUN(Q6_LWh_sub_LWhLWh_sat(pa, pb));
> +    RUN(Q6_Luh_sub_LuhLuh_sat(va, vb));
> +    RUN(Q6_Luh_sub_LhLh_sat(va, vb));
> +    RUN(Q6_LWuh_sub_LWhLWh_sat(pa, pb));
> +    RUN(Q6_LWuh_sub_LWuhLWuh_sat(pa, pb));
> +    RUN(Q6_LWuw_sub_LWuwLWuw_sat(pa, pb));
> +    RUN(Q6_LWuw_sub_LWwLWw_sat(pa, pb));
> +    RUN(Q6_LWw_sub_LWwLWw(pa, pb));
> +    RUN(Q6_LWw_sub_LWwLWw_sat(pa, pb));
> +    RUN(Q6_LWw_sub_LuhLuh(va, vb));
> +    RUN(Q6_LWw_sub_LWwLh(pa, va));
> +    RUN(Q6_LWw_sub_LWwLuh(pa, va));
> +    RUN(Q6_L_xor_LL(va, vb));
> +    RUN(Q6_LW_xor_LWLW(pa, pb));
> +    RUN(Q6_Lh_equals_Is(3));
> +    RUN(Q6_Luh_equals_I(3));
> +    RUN(Q6_Lh_sub_ilog2_LhI(va, 3));
> +    RUN(Q6_Lh_sub_ilog2_LuhI(va, 3));
> +    RUN(Q6_Lh_sub_ilog2_LWuwI(pa, 3));
> +    RUN(Q6_Lh_sub_ilog2_LWwI(pa, 3));
> +
> +    puts(err ? "FAIL" : "PASS");
> +    return err;
> +}
> diff --git a/tests/tcg/hexagon/hlx_logical.c b/tests/tcg/hexagon/hlx_logical.c
> new file mode 100644
> index 0000000000..56ac6ede2b
> --- /dev/null
> +++ b/tests/tcg/hexagon/hlx_logical.c
> @@ -0,0 +1,275 @@
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "hlx_test.h"
> +
> +static uint16_t *buf_a;
> +static uint16_t *buf_b;
> +static uint16_t *buf_out;
> +static uint16_t expected[HLX_HALF_ELEMS];
> +
> +static uint16_t *pair_a_lo;
> +static uint16_t *pair_a_hi;
> +static uint16_t *pair_b_lo;
> +static uint16_t *pair_b_hi;
> +static uint16_t *pair_out_lo;
> +static uint16_t *pair_out_hi;
> +
> +#define VAL_A     ((int16_t)0xAAAA)
> +#define VAL_B     ((int16_t)0x5555)
> +#define VAL_PA_LO ((int16_t)0xFF00)
> +#define VAL_PA_HI ((int16_t)0x00FF)
> +#define VAL_PB_LO ((int16_t)0x0F0F)
> +#define VAL_PB_HI ((int16_t)0xF0F0)
> +
> +static void init_logical(void)
> +{
> +    Q6_mem_Ku16_new_AL(buf_a, Q6_Lh_equals_Rh(VAL_A));
> +    Q6_mem_Ku16_new_AL(buf_b, Q6_Lh_equals_Rh(VAL_B));
> +    Q6_mem_Ku16_new_AL(pair_a_lo, Q6_Lh_equals_Rh(VAL_PA_LO));
> +    Q6_mem_Ku16_new_AL(pair_a_hi, Q6_Lh_equals_Rh(VAL_PA_HI));
> +    Q6_mem_Ku16_new_AL(pair_b_lo, Q6_Lh_equals_Rh(VAL_PB_LO));
> +    Q6_mem_Ku16_new_AL(pair_b_hi, Q6_Lh_equals_Rh(VAL_PB_HI));
> +}
> +
> +
> +static void test_and(void)
> +{
> +    HLX_Vector la = Q6_L_tmp_mem_A(buf_a);
> +    HLX_Vector lb = Q6_L_tmp_mem_A(buf_b);
> +    Q6_mem_Ku16_new_AL(buf_out, Q6_L_and_LL(la, lb));
> +
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        expected[i] = (uint16_t)VAL_A & (uint16_t)VAL_B;
> +    }
> +    check_h("LX_and", buf_out, expected, HLX_HALF_ELEMS);
> +}
> +
> +static void test_or(void)
> +{
> +    HLX_Vector la = Q6_L_tmp_mem_A(buf_a);
> +    HLX_Vector lb = Q6_L_tmp_mem_A(buf_b);
> +    Q6_mem_Ku16_new_AL(buf_out, Q6_L_or_LL(la, lb));
> +
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        expected[i] = (uint16_t)VAL_A | (uint16_t)VAL_B;
> +    }
> +    check_h("LX_or", buf_out, expected, HLX_HALF_ELEMS);
> +}
> +
> +static void test_xor(void)
> +{
> +    HLX_Vector la = Q6_L_tmp_mem_A(buf_a);
> +    HLX_Vector lb = Q6_L_tmp_mem_A(buf_b);
> +    Q6_mem_Ku16_new_AL(buf_out, Q6_L_xor_LL(la, lb));
> +
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        expected[i] = (uint16_t)VAL_A ^ (uint16_t)VAL_B;
> +    }
> +    check_h("LX_xor", buf_out, expected, HLX_HALF_ELEMS);
> +}
> +
> +static void test_not(void)
> +{
> +    HLX_Vector la = Q6_L_tmp_mem_A(buf_a);
> +    Q6_mem_Ku16_new_AL(buf_out, Q6_L_not_L(la));
> +
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        expected[i] = (uint16_t)~(uint16_t)VAL_A;
> +    }
> +    check_h("LX_not", buf_out, expected, HLX_HALF_ELEMS);
> +}
> +
> +static void test_andn(void)
> +{
> +    HLX_Vector la = Q6_L_tmp_mem_A(buf_a);
> +    HLX_Vector lb = Q6_L_tmp_mem_A(buf_b);
> +    Q6_mem_Ku16_new_AL(buf_out, Q6_L_andn_LL(la, lb));
> +
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        expected[i] = (uint16_t)VAL_A & ~(uint16_t)VAL_B;
> +    }
> +    check_h("LX_andn", buf_out, expected, HLX_HALF_ELEMS);
> +}
> +
> +static void test_orn(void)
> +{
> +    HLX_Vector la = Q6_L_tmp_mem_A(buf_a);
> +    HLX_Vector lb = Q6_L_tmp_mem_A(buf_b);
> +    Q6_mem_Ku16_new_AL(buf_out, Q6_L_orn_LL(la, lb));
> +
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        expected[i] = (uint16_t)VAL_A | ~(uint16_t)VAL_B;
> +    }
> +    check_h("LX_orn", buf_out, expected, HLX_HALF_ELEMS);
> +}
> +
> +
> +static void test_and_w(void)
> +{
> +    HLX_VectorPair pb;
> +    HLX_VectorPair pc;
> +    HLX_VectorPair pa = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pair_a_hi),
> +                                         Q6_L_tmp_mem_A(pair_a_lo));
> +    pb = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pair_b_hi),
> +                          Q6_L_tmp_mem_A(pair_b_lo));
> +    pc = Q6_LW_and_LWLW(pa, pb);
> +    Q6_mem_Ku16_new_AL(pair_out_lo, Q6_L_lo_LW(pc));
> +    Q6_mem_Ku16_new_AL(pair_out_hi, Q6_L_hi_LW(pc));
> +
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        expected[i] = (uint16_t)VAL_PA_LO & (uint16_t)VAL_PB_LO;
> +    }
> +    check_h("LX_and_w (lo)", pair_out_lo, expected, HLX_HALF_ELEMS);
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        expected[i] = (uint16_t)VAL_PA_HI & (uint16_t)VAL_PB_HI;
> +    }
> +    check_h("LX_and_w (hi)", pair_out_hi, expected, HLX_HALF_ELEMS);
> +}
> +
> +static void test_or_w(void)
> +{
> +    HLX_VectorPair pb;
> +    HLX_VectorPair pc;
> +    HLX_VectorPair pa = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pair_a_hi),
> +                                         Q6_L_tmp_mem_A(pair_a_lo));
> +    pb = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pair_b_hi),
> +                          Q6_L_tmp_mem_A(pair_b_lo));
> +    pc = Q6_LW_or_LWLW(pa, pb);
> +    Q6_mem_Ku16_new_AL(pair_out_lo, Q6_L_lo_LW(pc));
> +    Q6_mem_Ku16_new_AL(pair_out_hi, Q6_L_hi_LW(pc));
> +
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        expected[i] = (uint16_t)VAL_PA_LO | (uint16_t)VAL_PB_LO;
> +    }
> +    check_h("LX_or_w (lo)", pair_out_lo, expected, HLX_HALF_ELEMS);
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        expected[i] = (uint16_t)VAL_PA_HI | (uint16_t)VAL_PB_HI;
> +    }
> +    check_h("LX_or_w (hi)", pair_out_hi, expected, HLX_HALF_ELEMS);
> +}
> +
> +static void test_xor_w(void)
> +{
> +    HLX_VectorPair pb;
> +    HLX_VectorPair pc;
> +    HLX_VectorPair pa = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pair_a_hi),
> +                                         Q6_L_tmp_mem_A(pair_a_lo));
> +    pb = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pair_b_hi),
> +                          Q6_L_tmp_mem_A(pair_b_lo));
> +    pc = Q6_LW_xor_LWLW(pa, pb);
> +    Q6_mem_Ku16_new_AL(pair_out_lo, Q6_L_lo_LW(pc));
> +    Q6_mem_Ku16_new_AL(pair_out_hi, Q6_L_hi_LW(pc));
> +
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        expected[i] = (uint16_t)VAL_PA_LO ^ (uint16_t)VAL_PB_LO;
> +    }
> +    check_h("LX_xor_w (lo)", pair_out_lo, expected, HLX_HALF_ELEMS);
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        expected[i] = (uint16_t)VAL_PA_HI ^ (uint16_t)VAL_PB_HI;
> +    }
> +    check_h("LX_xor_w (hi)", pair_out_hi, expected, HLX_HALF_ELEMS);
> +}
> +
> +static void test_not_w(void)
> +{
> +    HLX_VectorPair pc;
> +    HLX_VectorPair pa = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pair_a_hi),
> +                                         Q6_L_tmp_mem_A(pair_a_lo));
> +    pc = Q6_LW_not_LW(pa);
> +    Q6_mem_Ku16_new_AL(pair_out_lo, Q6_L_lo_LW(pc));
> +    Q6_mem_Ku16_new_AL(pair_out_hi, Q6_L_hi_LW(pc));
> +
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        expected[i] = (uint16_t)~(uint16_t)VAL_PA_LO;
> +    }
> +    check_h("LX_not_w (lo)", pair_out_lo, expected, HLX_HALF_ELEMS);
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        expected[i] = ~(uint16_t)VAL_PA_HI;
> +    }
> +    check_h("LX_not_w (hi)", pair_out_hi, expected, HLX_HALF_ELEMS);
> +}
> +
> +static void test_andn_w(void)
> +{
> +    HLX_VectorPair pb;
> +    HLX_VectorPair pc;
> +    HLX_VectorPair pa = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pair_a_hi),
> +                                         Q6_L_tmp_mem_A(pair_a_lo));
> +    pb = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pair_b_hi),
> +                          Q6_L_tmp_mem_A(pair_b_lo));
> +    pc = Q6_LW_andn_LWLW(pa, pb);
> +    Q6_mem_Ku16_new_AL(pair_out_lo, Q6_L_lo_LW(pc));
> +    Q6_mem_Ku16_new_AL(pair_out_hi, Q6_L_hi_LW(pc));
> +
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        expected[i] = (uint16_t)VAL_PA_LO & ~(uint16_t)VAL_PB_LO;
> +    }
> +    check_h("LX_andn_w (lo)", pair_out_lo, expected, HLX_HALF_ELEMS);
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        expected[i] = (uint16_t)VAL_PA_HI & ~(uint16_t)VAL_PB_HI;
> +    }
> +    check_h("LX_andn_w (hi)", pair_out_hi, expected, HLX_HALF_ELEMS);
> +}
> +
> +static void test_orn_w(void)
> +{
> +    HLX_VectorPair pb;
> +    HLX_VectorPair pc;
> +    HLX_VectorPair pa = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pair_a_hi),
> +                                         Q6_L_tmp_mem_A(pair_a_lo));
> +    pb = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pair_b_hi),
> +                          Q6_L_tmp_mem_A(pair_b_lo));
> +    pc = Q6_LW_orn_LWLW(pa, pb);
> +    Q6_mem_Ku16_new_AL(pair_out_lo, Q6_L_lo_LW(pc));
> +    Q6_mem_Ku16_new_AL(pair_out_hi, Q6_L_hi_LW(pc));
> +
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        expected[i] = (uint16_t)VAL_PA_LO | ~(uint16_t)VAL_PB_LO;
> +    }
> +    check_h("LX_orn_w (lo)", pair_out_lo, expected, HLX_HALF_ELEMS);
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        expected[i] = (uint16_t)((uint16_t)VAL_PA_HI | ~(uint16_t)VAL_PB_HI);
> +    }
> +    check_h("LX_orn_w (hi)", pair_out_hi, expected, HLX_HALF_ELEMS);
> +}
> +
> +int main(void)
> +{
> +    init_vtcm();
> +    enable_hlx();
> +
> +    buf_a = vtcm_alloc(HLX_HALF_ELEMS * sizeof(uint16_t));
> +    buf_b = vtcm_alloc(HLX_HALF_ELEMS * sizeof(uint16_t));
> +    buf_out = vtcm_alloc(HLX_HALF_ELEMS * sizeof(uint16_t));
> +    pair_a_lo = vtcm_alloc(HLX_HALF_ELEMS * sizeof(uint16_t));
> +    pair_a_hi = vtcm_alloc(HLX_HALF_ELEMS * sizeof(uint16_t));
> +    pair_b_lo = vtcm_alloc(HLX_HALF_ELEMS * sizeof(uint16_t));
> +    pair_b_hi = vtcm_alloc(HLX_HALF_ELEMS * sizeof(uint16_t));
> +    pair_out_lo = vtcm_alloc(HLX_HALF_ELEMS * sizeof(uint16_t));
> +    pair_out_hi = vtcm_alloc(HLX_HALF_ELEMS * sizeof(uint16_t));
> +    init_hlx_vsp();
> +
> +    init_logical();
> +
> +    /* Single-register operations */
> +    test_and();
> +    test_or();
> +    test_xor();
> +    test_not();
> +    test_andn();
> +    test_orn();
> +
> +    /* Word-pair operations */
> +    test_and_w();
> +    test_or_w();
> +    test_xor_w();
> +    test_not_w();
> +    test_andn_w();
> +    test_orn_w();
> +
> +    puts(err ? "FAIL" : "PASS");
> +    return err;
> +}
> diff --git a/tests/tcg/hexagon/hlx_lut_ilog2.c b/tests/tcg/hexagon/hlx_lut_ilog2.c
> new file mode 100644
> index 0000000000..2edc24ddd2
> --- /dev/null
> +++ b/tests/tcg/hexagon/hlx_lut_ilog2.c
> @@ -0,0 +1,289 @@
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "hlx_test.h"
> +
> +/*
> + * Broadcast constants for uniform buffer init.
> + *
> + * LUT_SRC: top 2 bits = 3 (selects table entry[3]), lower 14 bits nonzero
> + * (so lut4:mask produces 0).
> + */
> +#define LUT_SRC         ((int16_t)0xC123)
> +
> +/* A second LUT source whose lower 14 bits are zero (so lut4:mask passes) */
> +#define LUT_SRC_MASK    ((int16_t)0xC000)   /* top 2 bits = 3, lower = 0 */
> +
> +/* ilog2 sources */
> +#define ILOG_SRC_UH     ((int16_t)500)      /* unsigned halfword */
> +#define ILOG_SRC_SH     ((int16_t)-500)     /* signed halfword */
> +#define ILOG_SRC_UW     ((int32_t)100000)   /* unsigned word */
> +#define ILOG_SRC_SW     ((int32_t)-100000)  /* signed word */
> +
> +static uint16_t *buf_src;
> +static uint16_t *buf_out;
> +static uint16_t expected[HLX_HALF_ELEMS];
> +
> +static uint32_t *pw_src_lo;
> +static uint32_t *pw_src_hi;
> +static uint32_t *pw_out_lo;
> +static uint32_t *pw_out_hi;
> +static uint32_t expected_w[HLX_HALF_ELEMS];
> +
> +static void fill_h(uint16_t *buf, int16_t val)
> +{
> +    Q6_mem_Ku16_new_AL(buf, Q6_Lh_equals_Rh(val));
> +}
> +
> +static void fill_w(uint32_t *buf_lo, uint32_t *buf_hi, int32_t val)
> +{
> +    HLX_VectorPair wp = Q6_LWw_equals_Rw(val);
> +    Q6_mem_Ku16_new_AL((uint16_t *)buf_lo, Q6_L_lo_LW(wp));
> +    Q6_mem_Ku16_new_AL((uint16_t *)buf_hi, Q6_L_hi_LW(wp));
> +}
> +
> +
> +static void test_lut4(void)
> +{
> +    int16_t entries[4] = { 100, -200, 300, -400 };
> +    uint64_t table;
> +    HLX_Vector la;
> +    int idx;
> +    uint16_t exp_val;
> +
> +    fill_h(buf_src, LUT_SRC);
> +
> +    /*
> +     * Ld.h = lut4(Lu.uh, Rtt.h): look up by top 2 bits of each element
> +     * Table entries in Rtt: h[0], h[1], h[2], h[3]
> +     */
> +    memcpy(&table, entries, 8);
> +
> +    la = Q6_L_tmp_mem_A(buf_src);
> +    Q6_mem_Ku16_new_AL(buf_out, Q6_Lh_lut4_LuhPh(la, table));
> +
> +    idx = ((uint16_t)LUT_SRC >> 14) & 0x3;
> +    exp_val = (uint16_t)entries[idx];
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        expected[i] = exp_val;
> +    }
> +    check_h("LX_lut4", buf_out, expected, HLX_HALF_ELEMS);
> +}
> +
> +static void test_lut4_sh(void)
> +{
> +    uint16_t entries[4] = { 10, 200, 3000, 40000 };
> +    uint64_t table;
> +    HLX_Vector la;
> +    HLX_VectorPair pp;
> +    int idx;
> +    uint32_t exp_val;
> +
> +    fill_h(buf_src, LUT_SRC);
> +
> +    /*
> +     * Ldd.w = lut4(Lu.uh, Rtt.uh):>>1
> +     * Semantics: LddV.l[i].w = (int32_t)(uint16_t entry) << 15
> +     */
> +    memcpy(&table, entries, 8);
> +
> +    la = Q6_L_tmp_mem_A(buf_src);
> +    pp = Q6_LWw_lut4_LuhPuh_rs1(la, table);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(pp));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(pp));
> +
> +    idx = ((uint16_t)LUT_SRC >> 14) & 0x3;
> +    exp_val = (uint32_t)((int32_t)(uint32_t)entries[idx] << 15);
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected_w[j] = exp_val;
> +    }
> +    check_wp("LX_lut4_sh", pw_out_lo, pw_out_hi, expected_w, HLX_HALF_ELEMS);
> +}
> +
> +static void test_lut4_sh_neg(void)
> +{
> +    uint16_t entries[4] = { 10, 200, 3000, 40000 };
> +    uint64_t table;
> +    HLX_Vector la;
> +    HLX_VectorPair pp;
> +    int idx;
> +    uint32_t e;
> +    uint32_t exp_val;
> +
> +    fill_h(buf_src, LUT_SRC);
> +
> +    /*
> +     * Ldd.w = lut4(Lu.uh, Rtt.uh):>>1:neg
> +     * Semantics: LddV.l[i].w = ((uint32_t)entry - (1<<16)) << 15
> +     */
> +    memcpy(&table, entries, 8);
> +
> +    la = Q6_L_tmp_mem_A(buf_src);
> +    pp = Q6_LWw_lut4_LuhPuh_rs1_neg(la, table);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(pp));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(pp));
> +
> +    idx = ((uint16_t)LUT_SRC >> 14) & 0x3;
> +    e = (uint32_t)entries[idx];
> +    exp_val = (uint32_t)((uint32_t)((int32_t)(e - (1u << 16))) << 15);
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected_w[j] = exp_val;
> +    }
> +    check_wp("LX_lut4_sh_neg", pw_out_lo, pw_out_hi,
> +             expected_w, HLX_HALF_ELEMS);
> +}
> +
> +static void test_lut4_mask(void)
> +{
> +    int16_t entries[4] = { 100, -200, 300, -400 };
> +    uint64_t table;
> +    HLX_Vector la;
> +    int idx;
> +    int16_t val;
> +    int mask;
> +    uint16_t exp_val;
> +
> +    /*
> +     * Ld.h = lut4(Lu.uh, Rtt.h):mask
> +     * If lower 14 bits are 0, use table value; otherwise 0.
> +     *
> +     * Use LUT_SRC_MASK (lower 14 bits == 0) so the mask passes.
> +     */
> +    fill_h(buf_src, LUT_SRC_MASK);
> +
> +    memcpy(&table, entries, 8);
> +
> +    la = Q6_L_tmp_mem_A(buf_src);
> +    Q6_mem_Ku16_new_AL(buf_out, Q6_Lh_lut4_LuhPh_mask(la, table));
> +
> +    idx = ((uint16_t)LUT_SRC_MASK >> 14) & 0x3;
> +    val = entries[idx];
> +    mask = ((uint16_t)LUT_SRC_MASK & 0x3FFF) == 0 ? 0xFFFF : 0;
> +    exp_val = (uint16_t)(val & mask);
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        expected[i] = exp_val;
> +    }
> +    check_h("LX_lut4_mask", buf_out, expected, HLX_HALF_ELEMS);
> +}
> +
> +
> +static void test_sub_ilog2_uh(void)
> +{
> +    HLX_Vector la;
> +    uint16_t exp_val;
> +
> +    fill_h(buf_src, ILOG_SRC_UH);
> +
> +    /*
> +     * Ld.h = sub(ilog2(Lu.uh), #u4)
> +     * Semantics: fBIT_WIDTH(16, Lu.uh[i]) - 1 - u4
> +     */
> +    la = Q6_L_tmp_mem_A(buf_src);
> +    Q6_mem_Ku16_new_AL(buf_out, Q6_Lh_sub_ilog2_LuhI(la, 2));
> +
> +    /* bit_width(500) = 9 */
> +    exp_val = 9 - 1 - 2;
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        expected[i] = exp_val;
> +    }
> +    check_h("LX_sub_ilog2_uh", buf_out, expected, HLX_HALF_ELEMS);
> +}
> +
> +static void test_sub_ilog2_h(void)
> +{
> +    HLX_Vector la;
> +    uint16_t exp_val;
> +
> +    fill_h(buf_src, ILOG_SRC_SH);
> +
> +    /*
> +     * Ld.h = sub(ilog2(Lu.h), #u4)
> +     * Semantics: fBIT_WIDTH(16, Lu.h[i] ^ -(Lu.h[i] < 0)) - 1 - u4
> +     */
> +    la = Q6_L_tmp_mem_A(buf_src);
> +    Q6_mem_Ku16_new_AL(buf_out, Q6_Lh_sub_ilog2_LhI(la, 3));
> +
> +    /* bit_width(-500 ^ -1) = bit_width(499) = 9 */
> +    exp_val = 9 - 1 - 3;
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        expected[i] = exp_val;
> +    }
> +    check_h("LX_sub_ilog2_h", buf_out, expected, HLX_HALF_ELEMS);
> +}
> +
> +static void test_sub_ilog2_uw(void)
> +{
> +    HLX_Vector l_lo;
> +    HLX_Vector l_hi;
> +    HLX_VectorPair pa;
> +    uint16_t exp_val;
> +
> +    fill_w(pw_src_lo, pw_src_hi, ILOG_SRC_UW);
> +
> +    /* Ld.h = sub(ilog2(Luu.uw), #u5) */
> +    l_lo = Q6_L_tmp_mem_A(pw_src_lo);
> +    l_hi = Q6_L_tmp_mem_A(pw_src_hi);
> +    pa = Q6_LW_combine_LL(l_hi, l_lo);
> +    Q6_mem_Ku16_new_AL(buf_out, Q6_Lh_sub_ilog2_LWuwI(pa, 4));
> +
> +    /* bit_width(100000) = 17 */
> +    exp_val = 17 - 1 - 4;
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        expected[i] = exp_val;
> +    }
> +    check_h("LX_sub_ilog2_uw", buf_out, expected, HLX_HALF_ELEMS);
> +}
> +
> +static void test_sub_ilog2_w(void)
> +{
> +    HLX_Vector l_lo;
> +    HLX_Vector l_hi;
> +    HLX_VectorPair pa;
> +    uint16_t exp_val;
> +
> +    fill_w(pw_src_lo, pw_src_hi, ILOG_SRC_SW);
> +
> +    /* Ld.h = sub(ilog2(Luu.w), #u5) */
> +    l_lo = Q6_L_tmp_mem_A(pw_src_lo);
> +    l_hi = Q6_L_tmp_mem_A(pw_src_hi);
> +    pa = Q6_LW_combine_LL(l_hi, l_lo);
> +    Q6_mem_Ku16_new_AL(buf_out, Q6_Lh_sub_ilog2_LWwI(pa, 5));
> +
> +    /* bit_width(-100000 ^ -1) = bit_width(99999) = 17 */
> +    exp_val = 17 - 1 - 5;
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        expected[i] = exp_val;
> +    }
> +    check_h("LX_sub_ilog2_w", buf_out, expected, HLX_HALF_ELEMS);
> +}
> +
> +int main(void)
> +{
> +    init_vtcm();
> +    enable_hlx();
> +
> +    buf_src = vtcm_alloc(HLX_HALF_ELEMS * sizeof(uint16_t));
> +    buf_out = vtcm_alloc(HLX_HALF_ELEMS * sizeof(uint16_t));
> +    pw_src_lo = vtcm_alloc(HLX_WORD_ELEMS * sizeof(uint32_t));
> +    pw_src_hi = vtcm_alloc(HLX_WORD_ELEMS * sizeof(uint32_t));
> +    pw_out_lo = vtcm_alloc(HLX_WORD_ELEMS * sizeof(uint32_t));
> +    pw_out_hi = vtcm_alloc(HLX_WORD_ELEMS * sizeof(uint32_t));
> +    init_hlx_vsp();
> +
> +    /* Lookup table */
> +    test_lut4();
> +    test_lut4_sh();
> +    test_lut4_sh_neg();
> +    test_lut4_mask();
> +
> +    /* ilog2 */
> +    test_sub_ilog2_uh();
> +    test_sub_ilog2_h();
> +    test_sub_ilog2_uw();
> +    test_sub_ilog2_w();
> +
> +    puts(err ? "FAIL" : "PASS");
> +    return err;
> +}
> diff --git a/tests/tcg/hexagon/hlx_mem.c b/tests/tcg/hexagon/hlx_mem.c
> new file mode 100644
> index 0000000000..643b499fd9
> --- /dev/null
> +++ b/tests/tcg/hexagon/hlx_mem.c
> @@ -0,0 +1,258 @@
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include <setjmp.h>
> +#include <signal.h>
> +
> +#include "hlx_test.h"
> +
> +/* Committed-value seed for the false-predicate load test */
> +#define SEED_VAL  0x1234
> +
> +static uint16_t *buf_a;
> +static uint16_t *buf_out;
> +static uint16_t expected[HLX_HALF_ELEMS];
> +
> +static void init_data(void)
> +{
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        buf_a[i] = (i * 37 + 100) & 0xFFFF;
> +        buf_out[i] = 0xDEAD;
> +    }
> +}
> +
> +
> +static void test_pred_load_true(void)
> +{
> +    init_data();
> +    /*
> +     * if (Pv) Ld.tmp = mem(Rs) -- with true predicate.
> +     *
> +     * A .tmp load only forwards its data within the same packet, so the
> +     * consuming assign (L1.h = L0.h) and the .new store must live in the
> +     * same packet as the load.
> +     */
> +    /*
> +     * { if (p0) L0.tmp = mem(r1)
> +     *   L1.h = L0.h
> +     *   mem(r2) = L1.new }
> +     */
> +    asm volatile("p0 = cmp.eq(r0, r0)\n"      /* p0 = true */
> +                 "r1 = %[src]\n"
> +                 "r2 = %[dst]\n"
> +                 ".word 0xe5007822\n"
> +                 ".word 0x98015040\n"
> +                 ".word 0xa482c001\n"
> +                 : : [src] "r"(buf_a), [dst] "r"(buf_out)
> +                 : "r1", "r2", "p0", "memory");
> +    check_h("LX_L16b_p_tmp (true)", buf_out, buf_a, HLX_HALF_ELEMS);
> +}
> +
> +static void test_pred_load_false(void)
> +{
> +    uint32_t seed;
> +
> +    init_data();
> +    /*
> +     * if (Pv) Ld.tmp = mem(Rs) -- with false predicate.
> +     *
> +     * A .tmp load never writes the register file; it only forwards within
> +     * its packet.  With a false predicate the load is cancelled, so the
> +     * same-packet consumer (L1.h = L0.h) reads whatever committed value L0
> +     * already holds.  Seed L0 with a regular (non-tmp) HLX write first, then
> +     * confirm the cancelled tmp load does not override it.
> +     */
> +    seed = SEED_VAL;
> +    /*
> +     * { if (p0) L0.tmp = mem(r1)
> +     *   L1.h = L0.h
> +     *   mem(r2) = L1.new }
> +     */
> +    asm volatile("r3 = %[seed]\n"
> +                 "r1 = %[src]\n"
> +                 "r2 = %[dst]\n"
> +                 ".word 0xe523e420\n"       /* { L0.h = r3.h } */
> +                 "p0 = !cmp.eq(r0, r0)\n"   /* p0 = false (always) */
> +                 ".word 0xe5007822\n"
> +                 ".word 0x98015040\n"
> +                 ".word 0xa482c001\n"
> +                 : : [seed] "r"(seed), [src] "r"(buf_a), [dst] "r"(buf_out)
> +                 : "r1", "r2", "r3", "p0", "memory");
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        expected[i] = SEED_VAL;
> +    }
> +    check_h("LX_L16b_p_tmp (false)", buf_out, expected, HLX_HALF_ELEMS);
> +}
> +
> +
> +static void test_pred_store_true(void)
> +{
> +    init_data();
> +    /*
> +     * if (Pv) mem(Rs) = Ku.new -- with true predicate.
> +     *
> +     * The .tmp load, its consumer, and the predicated .new store all live
> +     * in one packet so the loaded data is forwarded correctly.
> +     */
> +    /*
> +     * { L0.tmp = mem(r1)
> +     *   L1.h = L0.h
> +     *   if (p0) mem(r2) = L1.new }
> +     */
> +    asm volatile("p0 = cmp.eq(r0, r0)\n"      /* p0 = true */
> +                 "r1 = %[src]\n"
> +                 "r2 = %[dst]\n"
> +                 ".word 0xe5007822\n"
> +                 ".word 0x98015000\n"
> +                 ".word 0xa482c041\n"
> +                 : : [src] "r"(buf_a), [dst] "r"(buf_out)
> +                 : "r1", "r2", "p0", "memory");
> +    check_h("LX_S16b_p_new (true)", buf_out, buf_a, HLX_HALF_ELEMS);
> +}
> +
> +static void test_pred_store_false(void)
> +{
> +    init_data();
> +    /*
> +     * if (Pv) mem(Rs) = Ku.new -- with false predicate.
> +     * Same same-packet producer pattern, but the false predicate cancels
> +     * the store; buf_out retains 0xDEAD.
> +     */
> +    /*
> +     * { L0.tmp = mem(r1)
> +     *   L1.h = L0.h
> +     *   if (p0) mem(r2) = L1.new }
> +     */
> +    asm volatile("p0 = !cmp.eq(r0, r0)\n"     /* p0 = false (always) */
> +                 "r1 = %[src]\n"
> +                 "r2 = %[dst]\n"
> +                 ".word 0xe5007822\n"
> +                 ".word 0x98015000\n"
> +                 ".word 0xa482c041\n"
> +                 : : [src] "r"(buf_a), [dst] "r"(buf_out)
> +                 : "r1", "r2", "p0", "memory");
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        expected[i] = 0xDEAD;
> +    }
> +    check_h("LX_S16b_p_new (false)", buf_out, expected, HLX_HALF_ELEMS);
> +}
> +
> +
> +static void test_zero_store(void)
> +{
> +    uint32_t seed;
> +
> +    init_data();
> +    /*
> +     * A .new store with no producer in the packet stores 2KB of zeros.
> +     * Give L1 a committed value first, so the test sees if the store
> +     * uses the register instead of zeros.
> +     */
> +    seed = SEED_VAL;
> +    /*
> +     * { L1.h = r3.h }
> +     * { mem(r2) = L1.new }
> +     */
> +    asm volatile("r3 = %[seed]\n"
> +                 "r2 = %[dst]\n"
> +                 ".word 0xe523e422\n"
> +                 ".word 0xa482c001\n"
> +                 : : [seed] "r"(seed), [dst] "r"(buf_out)
> +                 : "r2", "r3", "memory");
> +    memset(expected, 0, sizeof(expected));
> +    check_h("LX_S16b_new (no producer)", buf_out, expected, HLX_HALF_ELEMS);
> +}
> +
> +static void test_pred_zero_store(bool pred)
> +{
> +    init_data();
> +    /* { if (p0) mem(r2) = L1.new } with no producer of L1 */
> +    asm volatile("p0 = cmp.eq(%[pred], #1)\n"
> +                 "r2 = %[dst]\n"
> +                 ".word 0xa482c041\n"
> +                 : : [pred] "r"(pred), [dst] "r"(buf_out)
> +                 : "r2", "p0", "memory");
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        expected[i] = pred ? 0 : 0xDEAD;
> +    }
> +    check_h(pred ? "LX_S16b_p_new (no producer, true)"
> +                 : "LX_S16b_p_new (no producer, false)",
> +            buf_out, expected, HLX_HALF_ELEMS);
> +}
> +
> +
> +static sigjmp_buf segv_env;
> +
> +static void handle_segv(int sig)
> +{
> +    siglongjmp(segv_env, 1);
> +}
> +
> +static void test_store_fault(void)
> +{
> +    struct sigaction act;
> +    /* volatile: the value must survive siglongjmp() */
> +    volatile bool caught = false;
> +
> +    init_data();
> +    memset(&act, 0, sizeof(act));
> +    act.sa_handler = handle_segv;
> +    sigaction(SIGSEGV, &act, NULL);
> +    /*
> +     * A packet commits all stores or none.  The scalar store faults, so
> +     * the HLX store in the same packet must not change memory.
> +     *
> +     * { memw(r19+#0) = #0
> +     *   mem(r2) = L1.new }
> +     */
> +    if (sigsetjmp(segv_env, 1) == 0) {
> +        asm volatile("r2 = %[dst]\n"
> +                     "r19 = #0\n"
> +                     ".word 0x3c534000\n"
> +                     ".word 0xa482c001\n"
> +                     : : [dst] "r"(buf_out) : "r2", "r19", "memory");
> +    } else {
> +        caught = true;
> +    }
> +    act.sa_handler = SIG_DFL;
> +    sigaction(SIGSEGV, &act, NULL);
> +
> +    if (!caught) {
> +        printf("FAIL LX_S16b_new (fault): no SIGSEGV\n");
> +        err++;
> +    }
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        expected[i] = 0xDEAD;
> +    }
> +    check_h("LX_S16b_new (fault)", buf_out, expected, HLX_HALF_ELEMS);
> +}
> +
> +int main(void)
> +{
> +    init_vtcm();
> +    enable_hlx();
> +
> +    buf_a = vtcm_alloc(HLX_HALF_ELEMS * sizeof(uint16_t));
> +    buf_out = vtcm_alloc(HLX_HALF_ELEMS * sizeof(uint16_t));
> +
> +    /* Predicated load */
> +    test_pred_load_true();
> +    test_pred_load_false();
> +
> +    /* Predicated store */
> +    test_pred_store_true();
> +    test_pred_store_false();
> +
> +    /* Zero store */
> +    test_zero_store();
> +    test_pred_zero_store(true);
> +    test_pred_zero_store(false);
> +
> +    /* Store in a faulting packet */
> +    test_store_fault();
> +
> +    puts(err ? "FAIL" : "PASS");
> +    return err;
> +}
> diff --git a/tests/tcg/hexagon/hlx_minmax_avg.c b/tests/tcg/hexagon/hlx_minmax_avg.c
> new file mode 100644
> index 0000000000..9fb36ca1de
> --- /dev/null
> +++ b/tests/tcg/hexagon/hlx_minmax_avg.c
> @@ -0,0 +1,801 @@
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "hlx_test.h"
> +
> +#define SIGNED_A         ((int16_t)-150)
> +#define SIGNED_B         ((int16_t)200)
> +#define UNSIGNED_A       300
> +#define UNSIGNED_B       100
> +
> +#define SIGNED_W_A       (-50000)
> +#define SIGNED_W_B       30000
> +#define UNSIGNED_W_A     100000u
> +#define UNSIGNED_W_B     70000u
> +
> +#define PAIRED_A_LO      ((int16_t)(-150))
> +#define PAIRED_A_HI      ((int16_t)200)
> +#define PAIRED_B_LO      ((int16_t)100)
> +#define PAIRED_B_HI      ((int16_t)(-50))
> +
> +static uint16_t *buf_a;
> +static uint16_t *buf_b;
> +static uint16_t *buf_out;
> +static uint16_t expected[HLX_HALF_ELEMS];
> +
> +static uint32_t *pw_a_lo;
> +static uint32_t *pw_a_hi;
> +static uint32_t *pw_b_lo;
> +static uint32_t *pw_b_hi;
> +static uint32_t *pw_out_lo;
> +static uint32_t *pw_out_hi;
> +static uint32_t expected_w[HLX_HALF_ELEMS];
> +
> +static inline uint32_t pack_h(uint16_t lo, uint16_t hi)
> +{
> +    return ((uint32_t)hi << 16) | lo;
> +}
> +
> +static void fill_h(uint16_t *buf, int16_t val)
> +{
> +    Q6_mem_Ku16_new_AL(buf, Q6_Lh_equals_Rh(val));
> +}
> +
> +static void fill_w(uint32_t *buf_lo, uint32_t *buf_hi, int32_t val)
> +{
> +    HLX_VectorPair wp = Q6_LWw_equals_Rw(val);
> +    Q6_mem_Ku16_new_AL((uint16_t *)buf_lo, Q6_L_lo_LW(wp));
> +    Q6_mem_Ku16_new_AL((uint16_t *)buf_hi, Q6_L_hi_LW(wp));
> +}
> +
> +
> +static void test_max_h(void)
> +{
> +    HLX_Vector la;
> +    HLX_Vector lb;
> +
> +    fill_h(buf_a, SIGNED_A);
> +    fill_h(buf_b, SIGNED_B);
> +
> +    la = Q6_L_tmp_mem_A(buf_a);
> +    lb = Q6_L_tmp_mem_A(buf_b);
> +    Q6_mem_Ku16_new_AL(buf_out, Q6_Lh_max_LhLh(la, lb));
> +
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        expected[i] = (uint16_t)(SIGNED_A > SIGNED_B ? SIGNED_A : SIGNED_B);
> +    }
> +    check_h("LX_max_h", buf_out, expected, HLX_HALF_ELEMS);
> +}
> +
> +static void test_min_h(void)
> +{
> +    HLX_Vector la;
> +    HLX_Vector lb;
> +
> +    fill_h(buf_a, SIGNED_A);
> +    fill_h(buf_b, SIGNED_B);
> +
> +    la = Q6_L_tmp_mem_A(buf_a);
> +    lb = Q6_L_tmp_mem_A(buf_b);
> +    Q6_mem_Ku16_new_AL(buf_out, Q6_Lh_min_LhLh(la, lb));
> +
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        expected[i] = (uint16_t)(SIGNED_A < SIGNED_B ? SIGNED_A : SIGNED_B);
> +    }
> +    check_h("LX_min_h", buf_out, expected, HLX_HALF_ELEMS);
> +}
> +
> +static void test_max_uh(void)
> +{
> +    HLX_Vector la;
> +    HLX_Vector lb;
> +
> +    fill_h(buf_a, (int16_t)UNSIGNED_A);
> +    fill_h(buf_b, (int16_t)UNSIGNED_B);
> +
> +    la = Q6_L_tmp_mem_A(buf_a);
> +    lb = Q6_L_tmp_mem_A(buf_b);
> +    Q6_mem_Ku16_new_AL(buf_out, Q6_Luh_max_LuhLuh(la, lb));
> +
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        expected[i] = UNSIGNED_A > UNSIGNED_B ? UNSIGNED_A : UNSIGNED_B;
> +    }
> +    check_h("LX_max_uh", buf_out, expected, HLX_HALF_ELEMS);
> +}
> +
> +static void test_min_uh(void)
> +{
> +    HLX_Vector la;
> +    HLX_Vector lb;
> +
> +    fill_h(buf_a, (int16_t)UNSIGNED_A);
> +    fill_h(buf_b, (int16_t)UNSIGNED_B);
> +
> +    la = Q6_L_tmp_mem_A(buf_a);
> +    lb = Q6_L_tmp_mem_A(buf_b);
> +    Q6_mem_Ku16_new_AL(buf_out, Q6_Luh_min_LuhLuh(la, lb));
> +
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        expected[i] = UNSIGNED_A < UNSIGNED_B ? UNSIGNED_A : UNSIGNED_B;
> +    }
> +    check_h("LX_min_uh", buf_out, expected, HLX_HALF_ELEMS);
> +}
> +
> +
> +static void test_max_w(void)
> +{
> +    HLX_VectorPair pa;
> +    HLX_VectorPair pb;
> +    HLX_VectorPair pc;
> +
> +    /* Test max(A, B) */
> +    fill_w(pw_a_lo, pw_a_hi, SIGNED_W_A);
> +    fill_w(pw_b_lo, pw_b_hi, SIGNED_W_B);
> +
> +    pa = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_a_hi),
> +                          Q6_L_tmp_mem_A(pw_a_lo));
> +    pb = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_b_hi),
> +                          Q6_L_tmp_mem_A(pw_b_lo));
> +    pc = Q6_LWw_max_LWwLWw(pa, pb);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(pc));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(pc));
> +
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected_w[j] = (uint32_t)(SIGNED_W_A > SIGNED_W_B ?
> +                                   SIGNED_W_A : SIGNED_W_B);
> +    }
> +    check_wp("LX_max_w (a,b)", pw_out_lo, pw_out_hi,
> +             expected_w, HLX_HALF_ELEMS);
> +
> +    /* Test max(B, A) */
> +    fill_w(pw_a_lo, pw_a_hi, SIGNED_W_B);
> +    fill_w(pw_b_lo, pw_b_hi, SIGNED_W_A);
> +
> +    pa = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_a_hi),
> +                          Q6_L_tmp_mem_A(pw_a_lo));
> +    pb = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_b_hi),
> +                          Q6_L_tmp_mem_A(pw_b_lo));
> +    pc = Q6_LWw_max_LWwLWw(pa, pb);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(pc));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(pc));
> +
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected_w[j] = (uint32_t)(SIGNED_W_B > SIGNED_W_A ?
> +                                   SIGNED_W_B : SIGNED_W_A);
> +    }
> +    check_wp("LX_max_w (b,a)", pw_out_lo, pw_out_hi,
> +             expected_w, HLX_HALF_ELEMS);
> +}
> +
> +static void test_min_w(void)
> +{
> +    HLX_VectorPair pa;
> +    HLX_VectorPair pb;
> +    HLX_VectorPair pc;
> +
> +    /* Test min(A, B) */
> +    fill_w(pw_a_lo, pw_a_hi, SIGNED_W_A);
> +    fill_w(pw_b_lo, pw_b_hi, SIGNED_W_B);
> +
> +    pa = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_a_hi),
> +                          Q6_L_tmp_mem_A(pw_a_lo));
> +    pb = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_b_hi),
> +                          Q6_L_tmp_mem_A(pw_b_lo));
> +    pc = Q6_LWw_min_LWwLWw(pa, pb);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(pc));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(pc));
> +
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected_w[j] = (uint32_t)(SIGNED_W_A < SIGNED_W_B ?
> +                                   SIGNED_W_A : SIGNED_W_B);
> +    }
> +    check_wp("LX_min_w (a,b)", pw_out_lo, pw_out_hi,
> +             expected_w, HLX_HALF_ELEMS);
> +
> +    /* Test min(B, A) */
> +    fill_w(pw_a_lo, pw_a_hi, SIGNED_W_B);
> +    fill_w(pw_b_lo, pw_b_hi, SIGNED_W_A);
> +
> +    pa = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_a_hi),
> +                          Q6_L_tmp_mem_A(pw_a_lo));
> +    pb = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_b_hi),
> +                          Q6_L_tmp_mem_A(pw_b_lo));
> +    pc = Q6_LWw_min_LWwLWw(pa, pb);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(pc));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(pc));
> +
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected_w[j] = (uint32_t)(SIGNED_W_B < SIGNED_W_A ?
> +                                   SIGNED_W_B : SIGNED_W_A);
> +    }
> +    check_wp("LX_min_w (b,a)", pw_out_lo, pw_out_hi,
> +             expected_w, HLX_HALF_ELEMS);
> +}
> +
> +static void test_max_uw(void)
> +{
> +    HLX_VectorPair pa;
> +    HLX_VectorPair pb;
> +    HLX_VectorPair pc;
> +
> +    /* Test max(A, B) */
> +    fill_w(pw_a_lo, pw_a_hi, (int32_t)UNSIGNED_W_A);
> +    fill_w(pw_b_lo, pw_b_hi, (int32_t)UNSIGNED_W_B);
> +
> +    pa = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_a_hi),
> +                          Q6_L_tmp_mem_A(pw_a_lo));
> +    pb = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_b_hi),
> +                          Q6_L_tmp_mem_A(pw_b_lo));
> +    pc = Q6_LWuw_max_LWuwLWuw(pa, pb);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(pc));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(pc));
> +
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected_w[j] = UNSIGNED_W_A > UNSIGNED_W_B ?
> +                        UNSIGNED_W_A : UNSIGNED_W_B;
> +    }
> +    check_wp("LX_max_uw (a,b)", pw_out_lo, pw_out_hi,
> +             expected_w, HLX_HALF_ELEMS);
> +
> +    /* Test max(B, A) */
> +    fill_w(pw_a_lo, pw_a_hi, (int32_t)UNSIGNED_W_B);
> +    fill_w(pw_b_lo, pw_b_hi, (int32_t)UNSIGNED_W_A);
> +
> +    pa = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_a_hi),
> +                          Q6_L_tmp_mem_A(pw_a_lo));
> +    pb = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_b_hi),
> +                          Q6_L_tmp_mem_A(pw_b_lo));
> +    pc = Q6_LWuw_max_LWuwLWuw(pa, pb);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(pc));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(pc));
> +
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected_w[j] = UNSIGNED_W_B > UNSIGNED_W_A ?
> +                        UNSIGNED_W_B : UNSIGNED_W_A;
> +    }
> +    check_wp("LX_max_uw (b,a)", pw_out_lo, pw_out_hi,
> +             expected_w, HLX_HALF_ELEMS);
> +}
> +
> +static void test_min_uw(void)
> +{
> +    HLX_VectorPair pa;
> +    HLX_VectorPair pb;
> +    HLX_VectorPair pc;
> +
> +    /* Test min(A, B) */
> +    fill_w(pw_a_lo, pw_a_hi, (int32_t)UNSIGNED_W_A);
> +    fill_w(pw_b_lo, pw_b_hi, (int32_t)UNSIGNED_W_B);
> +
> +    pa = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_a_hi),
> +                          Q6_L_tmp_mem_A(pw_a_lo));
> +    pb = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_b_hi),
> +                          Q6_L_tmp_mem_A(pw_b_lo));
> +    pc = Q6_LWuw_min_LWuwLWuw(pa, pb);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(pc));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(pc));
> +
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected_w[j] = UNSIGNED_W_A < UNSIGNED_W_B ?
> +                        UNSIGNED_W_A : UNSIGNED_W_B;
> +    }
> +    check_wp("LX_min_uw (a,b)", pw_out_lo, pw_out_hi,
> +             expected_w, HLX_HALF_ELEMS);
> +
> +    /* Test min(B, A) */
> +    fill_w(pw_a_lo, pw_a_hi, (int32_t)UNSIGNED_W_B);
> +    fill_w(pw_b_lo, pw_b_hi, (int32_t)UNSIGNED_W_A);
> +
> +    pa = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_a_hi),
> +                          Q6_L_tmp_mem_A(pw_a_lo));
> +    pb = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_b_hi),
> +                          Q6_L_tmp_mem_A(pw_b_lo));
> +    pc = Q6_LWuw_min_LWuwLWuw(pa, pb);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(pc));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(pc));
> +
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected_w[j] = UNSIGNED_W_B < UNSIGNED_W_A ?
> +                        UNSIGNED_W_B : UNSIGNED_W_A;
> +    }
> +    check_wp("LX_min_uw (b,a)", pw_out_lo, pw_out_hi,
> +             expected_w, HLX_HALF_ELEMS);
> +}
> +
> +
> +static void test_max_hp(void)
> +{
> +    HLX_VectorPair pa;
> +    HLX_VectorPair pb;
> +    HLX_VectorPair pc;
> +    uint32_t exp_packed;
> +    uint32_t packed_a = pack_h((uint16_t)PAIRED_A_LO, (uint16_t)PAIRED_A_HI);
> +    uint32_t packed_b = pack_h((uint16_t)PAIRED_B_LO, (uint16_t)PAIRED_B_HI);
> +    fill_w(pw_a_lo, pw_a_hi, (int32_t)packed_a);
> +    fill_w(pw_b_lo, pw_b_hi, (int32_t)packed_b);
> +
> +    pa = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_a_hi),
> +                          Q6_L_tmp_mem_A(pw_a_lo));
> +    pb = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_b_hi),
> +                          Q6_L_tmp_mem_A(pw_b_lo));
> +    pc = Q6_LWh_max_LWhLWh(pa, pb);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(pc));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(pc));
> +
> +    exp_packed = pack_h(
> +        (uint16_t)(PAIRED_A_LO > PAIRED_B_LO ? PAIRED_A_LO : PAIRED_B_LO),
> +        (uint16_t)(PAIRED_A_HI > PAIRED_B_HI ? PAIRED_A_HI : PAIRED_B_HI));
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected_w[j] = exp_packed;
> +    }
> +    check_wp("LX_max_hp", pw_out_lo, pw_out_hi,
> +             expected_w, HLX_HALF_ELEMS);
> +}
> +
> +static void test_min_hp(void)
> +{
> +    HLX_VectorPair pa;
> +    HLX_VectorPair pb;
> +    HLX_VectorPair pc;
> +    uint32_t exp_packed;
> +    uint32_t packed_a = pack_h((uint16_t)PAIRED_A_LO, (uint16_t)PAIRED_A_HI);
> +    uint32_t packed_b = pack_h((uint16_t)PAIRED_B_LO, (uint16_t)PAIRED_B_HI);
> +    fill_w(pw_a_lo, pw_a_hi, (int32_t)packed_a);
> +    fill_w(pw_b_lo, pw_b_hi, (int32_t)packed_b);
> +
> +    pa = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_a_hi),
> +                          Q6_L_tmp_mem_A(pw_a_lo));
> +    pb = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_b_hi),
> +                          Q6_L_tmp_mem_A(pw_b_lo));
> +    pc = Q6_LWh_min_LWhLWh(pa, pb);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(pc));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(pc));
> +
> +    exp_packed = pack_h(
> +        (uint16_t)(PAIRED_A_LO < PAIRED_B_LO ? PAIRED_A_LO : PAIRED_B_LO),
> +        (uint16_t)(PAIRED_A_HI < PAIRED_B_HI ? PAIRED_A_HI : PAIRED_B_HI));
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected_w[j] = exp_packed;
> +    }
> +    check_wp("LX_min_hp", pw_out_lo, pw_out_hi,
> +             expected_w, HLX_HALF_ELEMS);
> +}
> +
> +static void test_max_uhp(void)
> +{
> +    HLX_VectorPair pa;
> +    HLX_VectorPair pb;
> +    HLX_VectorPair pc;
> +    uint16_t a_lo;
> +    uint16_t b_lo;
> +    uint16_t a_hi;
> +    uint16_t b_hi;
> +    uint32_t exp_packed;
> +    uint32_t packed_a = pack_h((uint16_t)PAIRED_A_LO, (uint16_t)PAIRED_A_HI);
> +    uint32_t packed_b = pack_h((uint16_t)PAIRED_B_LO, (uint16_t)PAIRED_B_HI);
> +    fill_w(pw_a_lo, pw_a_hi, (int32_t)packed_a);
> +    fill_w(pw_b_lo, pw_b_hi, (int32_t)packed_b);
> +
> +    pa = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_a_hi),
> +                          Q6_L_tmp_mem_A(pw_a_lo));
> +    pb = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_b_hi),
> +                          Q6_L_tmp_mem_A(pw_b_lo));
> +    pc = Q6_LWuh_max_LWuhLWuh(pa, pb);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(pc));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(pc));
> +
> +    a_lo = (uint16_t)PAIRED_A_LO;
> +
> +    b_lo = (uint16_t)PAIRED_B_LO;
> +    a_hi = (uint16_t)PAIRED_A_HI;
> +    b_hi = (uint16_t)PAIRED_B_HI;
> +    exp_packed = pack_h(a_lo > b_lo ? a_lo : b_lo,
> +                         a_hi > b_hi ? a_hi : b_hi);
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected_w[j] = exp_packed;
> +    }
> +    check_wp("LX_max_uhp", pw_out_lo, pw_out_hi,
> +             expected_w, HLX_HALF_ELEMS);
> +}
> +
> +static void test_min_uhp(void)
> +{
> +    HLX_VectorPair pa;
> +    HLX_VectorPair pb;
> +    HLX_VectorPair pc;
> +    uint16_t a_lo;
> +    uint16_t b_lo;
> +    uint16_t a_hi;
> +    uint16_t b_hi;
> +    uint32_t exp_packed;
> +    uint32_t packed_a = pack_h((uint16_t)PAIRED_A_LO, (uint16_t)PAIRED_A_HI);
> +    uint32_t packed_b = pack_h((uint16_t)PAIRED_B_LO, (uint16_t)PAIRED_B_HI);
> +    fill_w(pw_a_lo, pw_a_hi, (int32_t)packed_a);
> +    fill_w(pw_b_lo, pw_b_hi, (int32_t)packed_b);
> +
> +    pa = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_a_hi),
> +                          Q6_L_tmp_mem_A(pw_a_lo));
> +    pb = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_b_hi),
> +                          Q6_L_tmp_mem_A(pw_b_lo));
> +    pc = Q6_LWuh_min_LWuhLWuh(pa, pb);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(pc));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(pc));
> +
> +    a_lo = (uint16_t)PAIRED_A_LO;
> +
> +    b_lo = (uint16_t)PAIRED_B_LO;
> +    a_hi = (uint16_t)PAIRED_A_HI;
> +    b_hi = (uint16_t)PAIRED_B_HI;
> +    exp_packed = pack_h(a_lo < b_lo ? a_lo : b_lo,
> +                         a_hi < b_hi ? a_hi : b_hi);
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected_w[j] = exp_packed;
> +    }
> +    check_wp("LX_min_uhp", pw_out_lo, pw_out_hi,
> +             expected_w, HLX_HALF_ELEMS);
> +}
> +
> +
> +static void test_avg_h(void)
> +{
> +    HLX_Vector la;
> +    HLX_Vector lb;
> +
> +    fill_h(buf_a, SIGNED_A);
> +    fill_h(buf_b, SIGNED_B);
> +
> +    la = Q6_L_tmp_mem_A(buf_a);
> +    lb = Q6_L_tmp_mem_A(buf_b);
> +    Q6_mem_Ku16_new_AL(buf_out, Q6_Lh_avg_LhLh(la, lb));
> +
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        int32_t sum = (int32_t)SIGNED_A + (int32_t)SIGNED_B;
> +        expected[i] = (uint16_t)(int16_t)(sum >> 1);
> +    }
> +    check_h("LX_avg_h", buf_out, expected, HLX_HALF_ELEMS);
> +}
> +
> +static void test_avg_h_rnd(void)
> +{
> +    HLX_Vector la;
> +    HLX_Vector lb;
> +
> +    fill_h(buf_a, SIGNED_A);
> +    fill_h(buf_b, SIGNED_B);
> +
> +    la = Q6_L_tmp_mem_A(buf_a);
> +    lb = Q6_L_tmp_mem_A(buf_b);
> +    Q6_mem_Ku16_new_AL(buf_out, Q6_Lh_avg_LhLh_rnd(la, lb));
> +
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        int32_t sum = (int32_t)SIGNED_A + (int32_t)SIGNED_B + 1;
> +        expected[i] = (uint16_t)(int16_t)(sum >> 1);
> +    }
> +    check_h("LX_avg_h_rnd", buf_out, expected, HLX_HALF_ELEMS);
> +}
> +
> +static void test_navg_h(void)
> +{
> +    HLX_Vector la;
> +    HLX_Vector lb;
> +
> +    fill_h(buf_a, SIGNED_A);
> +    fill_h(buf_b, SIGNED_B);
> +
> +    la = Q6_L_tmp_mem_A(buf_a);
> +    lb = Q6_L_tmp_mem_A(buf_b);
> +    Q6_mem_Ku16_new_AL(buf_out, Q6_Lh_navg_LhLh(la, lb));
> +
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        int32_t diff = (int32_t)SIGNED_A - (int32_t)SIGNED_B;
> +        expected[i] = (uint16_t)(int16_t)(diff >> 1);
> +    }
> +    check_h("LX_navg_h", buf_out, expected, HLX_HALF_ELEMS);
> +}
> +
> +static void test_avg_uh(void)
> +{
> +    HLX_Vector la;
> +    HLX_Vector lb;
> +
> +    fill_h(buf_a, (int16_t)UNSIGNED_A);
> +    fill_h(buf_b, (int16_t)UNSIGNED_B);
> +
> +    la = Q6_L_tmp_mem_A(buf_a);
> +    lb = Q6_L_tmp_mem_A(buf_b);
> +    Q6_mem_Ku16_new_AL(buf_out, Q6_Luh_avg_LuhLuh(la, lb));
> +
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        uint32_t sum = (uint32_t)UNSIGNED_A + (uint32_t)UNSIGNED_B;
> +        expected[i] = (uint16_t)(sum >> 1);
> +    }
> +    check_h("LX_avg_uh", buf_out, expected, HLX_HALF_ELEMS);
> +}
> +
> +static void test_avg_uh_rnd(void)
> +{
> +    HLX_Vector la;
> +    HLX_Vector lb;
> +
> +    fill_h(buf_a, (int16_t)UNSIGNED_A);
> +    fill_h(buf_b, (int16_t)UNSIGNED_B);
> +
> +    la = Q6_L_tmp_mem_A(buf_a);
> +    lb = Q6_L_tmp_mem_A(buf_b);
> +    Q6_mem_Ku16_new_AL(buf_out, Q6_Luh_avg_LuhLuh_rnd(la, lb));
> +
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        uint32_t sum = (uint32_t)UNSIGNED_A + (uint32_t)UNSIGNED_B + 1;
> +        expected[i] = (uint16_t)(sum >> 1);
> +    }
> +    check_h("LX_avg_uh_rnd", buf_out, expected, HLX_HALF_ELEMS);
> +}
> +
> +static void test_navg_uh(void)
> +{
> +    HLX_Vector la;
> +    HLX_Vector lb;
> +
> +    fill_h(buf_a, (int16_t)UNSIGNED_A);
> +    fill_h(buf_b, (int16_t)UNSIGNED_B);
> +
> +    la = Q6_L_tmp_mem_A(buf_a);
> +    lb = Q6_L_tmp_mem_A(buf_b);
> +    Q6_mem_Ku16_new_AL(buf_out, Q6_Lh_navg_LuhLuh(la, lb));
> +
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        int32_t diff = (int32_t)(uint32_t)UNSIGNED_A -
> +                       (int32_t)(uint32_t)UNSIGNED_B;
> +        expected[i] = (uint16_t)(int16_t)(diff >> 1);
> +    }
> +    check_h("LX_navg_uh", buf_out, expected, HLX_HALF_ELEMS);
> +}
> +
> +
> +static void test_avg_w(void)
> +{
> +    HLX_VectorPair pa;
> +    HLX_VectorPair pb;
> +    HLX_VectorPair pc;
> +
> +    fill_w(pw_a_lo, pw_a_hi, SIGNED_W_A);
> +    fill_w(pw_b_lo, pw_b_hi, SIGNED_W_B);
> +
> +    pa = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_a_hi),
> +                          Q6_L_tmp_mem_A(pw_a_lo));
> +    pb = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_b_hi),
> +                          Q6_L_tmp_mem_A(pw_b_lo));
> +    pc = Q6_LWw_avg_LWwLWw(pa, pb);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(pc));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(pc));
> +
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        int64_t sum = (int64_t)SIGNED_W_A + (int64_t)SIGNED_W_B;
> +        expected_w[j] = (uint32_t)(int32_t)(sum >> 1);
> +    }
> +    check_wp("LX_avg_w", pw_out_lo, pw_out_hi,
> +             expected_w, HLX_HALF_ELEMS);
> +}
> +
> +static void test_avg_w_rnd(void)
> +{
> +    HLX_VectorPair pa;
> +    HLX_VectorPair pb;
> +    HLX_VectorPair pc;
> +
> +    fill_w(pw_a_lo, pw_a_hi, SIGNED_W_A);
> +    fill_w(pw_b_lo, pw_b_hi, SIGNED_W_B);
> +
> +    pa = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_a_hi),
> +                          Q6_L_tmp_mem_A(pw_a_lo));
> +    pb = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_b_hi),
> +                          Q6_L_tmp_mem_A(pw_b_lo));
> +    pc = Q6_LWw_avg_LWwLWw_rnd(pa, pb);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(pc));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(pc));
> +
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        int64_t sum = (int64_t)SIGNED_W_A + (int64_t)SIGNED_W_B + 1;
> +        expected_w[j] = (uint32_t)(int32_t)(sum >> 1);
> +    }
> +    check_wp("LX_avg_w_rnd", pw_out_lo, pw_out_hi,
> +             expected_w, HLX_HALF_ELEMS);
> +}
> +
> +static void test_navg_w(void)
> +{
> +    HLX_VectorPair pa;
> +    HLX_VectorPair pb;
> +    HLX_VectorPair pc;
> +
> +    /* Test navg(A, B) = (A - B) / 2 */
> +    fill_w(pw_a_lo, pw_a_hi, SIGNED_W_A);
> +    fill_w(pw_b_lo, pw_b_hi, SIGNED_W_B);
> +
> +    pa = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_a_hi),
> +                          Q6_L_tmp_mem_A(pw_a_lo));
> +    pb = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_b_hi),
> +                          Q6_L_tmp_mem_A(pw_b_lo));
> +    pc = Q6_LWw_navg_LWwLWw(pa, pb);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(pc));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(pc));
> +
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        int64_t diff = (int64_t)SIGNED_W_A - (int64_t)SIGNED_W_B;
> +        expected_w[j] = (uint32_t)(int32_t)(diff >> 1);
> +    }
> +    check_wp("LX_navg_w (a-b)", pw_out_lo, pw_out_hi,
> +             expected_w, HLX_HALF_ELEMS);
> +
> +    /* Test navg(B, A) = (B - A) / 2 */
> +    fill_w(pw_a_lo, pw_a_hi, SIGNED_W_B);
> +    fill_w(pw_b_lo, pw_b_hi, SIGNED_W_A);
> +
> +    pa = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_a_hi),
> +                          Q6_L_tmp_mem_A(pw_a_lo));
> +    pb = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_b_hi),
> +                          Q6_L_tmp_mem_A(pw_b_lo));
> +    pc = Q6_LWw_navg_LWwLWw(pa, pb);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(pc));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(pc));
> +
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        int64_t diff = (int64_t)SIGNED_W_B - (int64_t)SIGNED_W_A;
> +        expected_w[j] = (uint32_t)(int32_t)(diff >> 1);
> +    }
> +    check_wp("LX_navg_w (b-a)", pw_out_lo, pw_out_hi,
> +             expected_w, HLX_HALF_ELEMS);
> +}
> +
> +static void test_avg_uw(void)
> +{
> +    HLX_VectorPair pa;
> +    HLX_VectorPair pb;
> +    HLX_VectorPair pc;
> +
> +    fill_w(pw_a_lo, pw_a_hi, (int32_t)UNSIGNED_W_A);
> +    fill_w(pw_b_lo, pw_b_hi, (int32_t)UNSIGNED_W_B);
> +
> +    pa = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_a_hi),
> +                          Q6_L_tmp_mem_A(pw_a_lo));
> +    pb = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_b_hi),
> +                          Q6_L_tmp_mem_A(pw_b_lo));
> +    pc = Q6_LWuw_avg_LWuwLWuw(pa, pb);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(pc));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(pc));
> +
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        uint64_t sum = (uint64_t)UNSIGNED_W_A + (uint64_t)UNSIGNED_W_B;
> +        expected_w[j] = (uint32_t)(sum >> 1);
> +    }
> +    check_wp("LX_avg_uw", pw_out_lo, pw_out_hi,
> +             expected_w, HLX_HALF_ELEMS);
> +}
> +
> +static void test_avg_uw_rnd(void)
> +{
> +    HLX_VectorPair pa;
> +    HLX_VectorPair pb;
> +    HLX_VectorPair pc;
> +
> +    fill_w(pw_a_lo, pw_a_hi, (int32_t)UNSIGNED_W_A);
> +    fill_w(pw_b_lo, pw_b_hi, (int32_t)UNSIGNED_W_B);
> +
> +    pa = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_a_hi),
> +                          Q6_L_tmp_mem_A(pw_a_lo));
> +    pb = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_b_hi),
> +                          Q6_L_tmp_mem_A(pw_b_lo));
> +    pc = Q6_LWuw_avg_LWuwLWuw_rnd(pa, pb);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(pc));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(pc));
> +
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        uint64_t sum = (uint64_t)UNSIGNED_W_A + (uint64_t)UNSIGNED_W_B + 1;
> +        expected_w[j] = (uint32_t)(sum >> 1);
> +    }
> +    check_wp("LX_avg_uw_rnd", pw_out_lo, pw_out_hi,
> +             expected_w, HLX_HALF_ELEMS);
> +}
> +
> +static void test_navg_uw(void)
> +{
> +    HLX_VectorPair pa;
> +    HLX_VectorPair pb;
> +    HLX_VectorPair pc;
> +
> +    /* Test navg(A, B) = (A - B) / 2 */
> +    fill_w(pw_a_lo, pw_a_hi, (int32_t)UNSIGNED_W_A);
> +    fill_w(pw_b_lo, pw_b_hi, (int32_t)UNSIGNED_W_B);
> +
> +    pa = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_a_hi),
> +                          Q6_L_tmp_mem_A(pw_a_lo));
> +    pb = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_b_hi),
> +                          Q6_L_tmp_mem_A(pw_b_lo));
> +    pc = Q6_LWw_navg_LWuwLWuw(pa, pb);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(pc));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(pc));
> +
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        int64_t diff = (int64_t)(uint64_t)UNSIGNED_W_A -
> +                       (int64_t)(uint64_t)UNSIGNED_W_B;
> +        expected_w[j] = (uint32_t)(int32_t)(diff >> 1);
> +    }
> +    check_wp("LX_navg_uw (a-b)", pw_out_lo, pw_out_hi,
> +             expected_w, HLX_HALF_ELEMS);
> +
> +    /* Test navg(B, A) = (B - A) / 2 */
> +    fill_w(pw_a_lo, pw_a_hi, (int32_t)UNSIGNED_W_B);
> +    fill_w(pw_b_lo, pw_b_hi, (int32_t)UNSIGNED_W_A);
> +
> +    pa = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_a_hi),
> +                          Q6_L_tmp_mem_A(pw_a_lo));
> +    pb = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_b_hi),
> +                          Q6_L_tmp_mem_A(pw_b_lo));
> +    pc = Q6_LWw_navg_LWuwLWuw(pa, pb);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(pc));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(pc));
> +
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        int64_t diff = (int64_t)(uint64_t)UNSIGNED_W_B -
> +                       (int64_t)(uint64_t)UNSIGNED_W_A;
> +        expected_w[j] = (uint32_t)(int32_t)(diff >> 1);
> +    }
> +    check_wp("LX_navg_uw (b-a)", pw_out_lo, pw_out_hi,
> +             expected_w, HLX_HALF_ELEMS);
> +}
> +
> +int main(void)
> +{
> +    init_vtcm();
> +    enable_hlx();
> +
> +    buf_a = vtcm_alloc(HLX_HALF_ELEMS * sizeof(uint16_t));
> +    buf_b = vtcm_alloc(HLX_HALF_ELEMS * sizeof(uint16_t));
> +    buf_out = vtcm_alloc(HLX_HALF_ELEMS * sizeof(uint16_t));
> +    pw_a_lo = vtcm_alloc(HLX_WORD_ELEMS * sizeof(uint32_t));
> +    pw_a_hi = vtcm_alloc(HLX_WORD_ELEMS * sizeof(uint32_t));
> +    pw_b_lo = vtcm_alloc(HLX_WORD_ELEMS * sizeof(uint32_t));
> +    pw_b_hi = vtcm_alloc(HLX_WORD_ELEMS * sizeof(uint32_t));
> +    pw_out_lo = vtcm_alloc(HLX_WORD_ELEMS * sizeof(uint32_t));
> +    pw_out_hi = vtcm_alloc(HLX_WORD_ELEMS * sizeof(uint32_t));
> +    init_hlx_vsp();
> +
> +    /* Single-register min/max */
> +    test_max_h();
> +    test_min_h();
> +    test_max_uh();
> +    test_min_uh();
> +
> +    /* Pair min/max (word) */
> +    test_max_w();
> +    test_min_w();
> +    test_max_uw();
> +    test_min_uw();
> +
> +    /* Paired halfword min/max */
> +    test_max_hp();
> +    test_min_hp();
> +    test_max_uhp();
> +    test_min_uhp();
> +
> +    /* Single-register average */
> +    test_avg_h();
> +    test_avg_h_rnd();
> +    test_navg_h();
> +    test_avg_uh();
> +    test_avg_uh_rnd();
> +    test_navg_uh();
> +
> +    /* Pair average (word) */
> +    test_avg_w();
> +    test_avg_w_rnd();
> +    test_navg_w();
> +    test_avg_uw();
> +    test_avg_uw_rnd();
> +    test_navg_uw();
> +
> +    puts(err ? "FAIL" : "PASS");
> +    return err;
> +}
> diff --git a/tests/tcg/hexagon/hlx_mpy.c b/tests/tcg/hexagon/hlx_mpy.c
> new file mode 100644
> index 0000000000..adee715602
> --- /dev/null
> +++ b/tests/tcg/hexagon/hlx_mpy.c
> @@ -0,0 +1,375 @@
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "hlx_test.h"
> +
> +#define MPY_A_UH        100
> +#define MPY_B_UH        200
> +#define MPY_A_SH        ((int16_t)-50)
> +#define MPY_B_SH        ((int16_t)30)
> +#define MPY_SCALAR_UH   42
> +#define MPY_SCALAR_SH   ((int16_t)-13)
> +#define MPY_SCALAR_SUH  50
> +#define ACC_INIT         5000
> +
> +static uint32_t *pw_out_lo;
> +static uint32_t *pw_out_hi;
> +static uint32_t *pw_acc_lo;
> +static uint32_t *pw_acc_hi;
> +static uint32_t expected_w[HLX_HALF_ELEMS];
> +
> +static uint16_t *buf_a;
> +static uint16_t *buf_b;
> +
> +/* fLMPY16UU: (uint32_t)((uint16_t)A * (uint16_t)B) */
> +static inline uint32_t ref_mpy_uu(uint16_t a, uint16_t b)
> +{
> +    return (uint32_t)a * (uint32_t)b;
> +}
> +
> +/* fLMPY16SU: (int32_t)((int16_t)A * (uint16_t)B) */
> +static inline int32_t ref_mpy_su(int16_t a, uint16_t b)
> +{
> +    return (int32_t)a * (int32_t)(uint32_t)b;
> +}
> +
> +/* fLMPY16SS: (int32_t)((int16_t)A * (int16_t)B) */
> +static inline int32_t ref_mpy_ss(int16_t a, int16_t b)
> +{
> +    return (int32_t)a * (int32_t)b;
> +}
> +
> +static void fill_h(uint16_t *buf, int16_t val)
> +{
> +    Q6_mem_Ku16_new_AL(buf, Q6_Lh_equals_Rh(val));
> +}
> +
> +static void fill_w(uint32_t *buf_lo, uint32_t *buf_hi, int32_t val)
> +{
> +    HLX_VectorPair wp = Q6_LWw_equals_Rw(val);
> +    Q6_mem_Ku16_new_AL((uint16_t *)buf_lo, Q6_L_lo_LW(wp));
> +    Q6_mem_Ku16_new_AL((uint16_t *)buf_hi, Q6_L_hi_LW(wp));
> +}
> +
> +
> +static void test_mpy_uw_uh(void)
> +{
> +    HLX_Vector la;
> +    HLX_Vector lb;
> +    HLX_VectorPair result;
> +    uint32_t exp;
> +
> +    fill_h(buf_a, MPY_A_UH);
> +    fill_h(buf_b, MPY_B_UH);
> +
> +    la = Q6_L_tmp_mem_A(buf_a);
> +    lb = Q6_L_tmp_mem_A(buf_b);
> +    result = Q6_LWuw_mpy_LuhLuh(la, lb);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(result));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(result));
> +
> +    exp = ref_mpy_uu(MPY_A_UH, MPY_B_UH);
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected_w[j] = exp;
> +    }
> +    check_wp("LX_mpy_uw_uh", pw_out_lo, pw_out_hi, expected_w, HLX_HALF_ELEMS);
> +}
> +
> +static void test_mpyr_uw_uh(void)
> +{
> +    HLX_Vector la;
> +    HLX_VectorPair result;
> +    uint32_t exp;
> +
> +    fill_h(buf_a, MPY_A_UH);
> +
> +    la = Q6_L_tmp_mem_A(buf_a);
> +    result = Q6_LWuw_mpy_LuhRuh(la, MPY_SCALAR_UH);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(result));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(result));
> +
> +    exp = ref_mpy_uu(MPY_A_UH, MPY_SCALAR_UH);
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected_w[j] = exp;
> +    }
> +    check_wp("LX_mpyr_uw_uh", pw_out_lo, pw_out_hi, expected_w, HLX_HALF_ELEMS);
> +}
> +
> +static void test_mpy_w_huh(void)
> +{
> +    HLX_Vector la;
> +    HLX_Vector lb;
> +    HLX_VectorPair result;
> +    uint32_t exp;
> +
> +    fill_h(buf_a, MPY_A_SH);
> +    fill_h(buf_b, MPY_B_UH);
> +
> +    la = Q6_L_tmp_mem_A(buf_a);
> +    lb = Q6_L_tmp_mem_A(buf_b);
> +    result = Q6_LWw_mpy_LhLuh(la, lb);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(result));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(result));
> +
> +    exp = (uint32_t)ref_mpy_su(MPY_A_SH, MPY_B_UH);
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected_w[j] = exp;
> +    }
> +    check_wp("LX_mpy_w_huh", pw_out_lo, pw_out_hi, expected_w, HLX_HALF_ELEMS);
> +}
> +
> +static void test_mpyr_w_huh(void)
> +{
> +    HLX_Vector la;
> +    HLX_VectorPair result;
> +    uint32_t exp;
> +
> +    fill_h(buf_a, MPY_A_SH);
> +
> +    la = Q6_L_tmp_mem_A(buf_a);
> +    result = Q6_LWw_mpy_LhRuh(la, MPY_SCALAR_SUH);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(result));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(result));
> +
> +    exp = (uint32_t)ref_mpy_su(MPY_A_SH, MPY_SCALAR_SUH);
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected_w[j] = exp;
> +    }
> +    check_wp("LX_mpyr_w_huh", pw_out_lo, pw_out_hi, expected_w, HLX_HALF_ELEMS);
> +}
> +
> +static void test_mpy_w_h(void)
> +{
> +    HLX_Vector la;
> +    HLX_Vector lb;
> +    HLX_VectorPair result;
> +    uint32_t exp;
> +
> +    fill_h(buf_a, MPY_A_SH);
> +    fill_h(buf_b, MPY_B_SH);
> +
> +    la = Q6_L_tmp_mem_A(buf_a);
> +    lb = Q6_L_tmp_mem_A(buf_b);
> +    result = Q6_LWw_mpy_LhLh(la, lb);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(result));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(result));
> +
> +    exp = (uint32_t)ref_mpy_ss(MPY_A_SH, MPY_B_SH);
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected_w[j] = exp;
> +    }
> +    check_wp("LX_mpy_w_h", pw_out_lo, pw_out_hi, expected_w, HLX_HALF_ELEMS);
> +}
> +
> +static void test_mpyr_w_h(void)
> +{
> +    HLX_Vector la;
> +    HLX_VectorPair result;
> +    uint32_t exp;
> +
> +    fill_h(buf_a, MPY_A_SH);
> +
> +    la = Q6_L_tmp_mem_A(buf_a);
> +    result = Q6_LWw_mpy_LhRh(la, MPY_SCALAR_SH);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(result));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(result));
> +
> +    exp = (uint32_t)ref_mpy_ss(MPY_A_SH, MPY_SCALAR_SH);
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected_w[j] = exp;
> +    }
> +    check_wp("LX_mpyr_w_h", pw_out_lo, pw_out_hi, expected_w, HLX_HALF_ELEMS);
> +}
> +
> +
> +static void test_mpa_wuh(void)
> +{
> +    HLX_Vector la;
> +    HLX_Vector lb;
> +    HLX_VectorPair acc;
> +    HLX_VectorPair result;
> +    uint32_t exp;
> +
> +    fill_h(buf_a, MPY_A_UH);
> +    fill_h(buf_b, MPY_B_UH);
> +    fill_w(pw_acc_lo, pw_acc_hi, ACC_INIT);
> +
> +    la = Q6_L_tmp_mem_A(buf_a);
> +    lb = Q6_L_tmp_mem_A(buf_b);
> +    acc = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_acc_hi),
> +                           Q6_L_tmp_mem_A(pw_acc_lo));
> +    result = Q6_LWw_mpyacc_LuhLuh(acc, la, lb);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(result));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(result));
> +
> +    exp = ACC_INIT + ref_mpy_uu(MPY_A_UH, MPY_B_UH);
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected_w[j] = exp;
> +    }
> +    check_wp("LX_mpa_wuh", pw_out_lo, pw_out_hi, expected_w, HLX_HALF_ELEMS);
> +}
> +
> +static void test_mpar_wuh(void)
> +{
> +    HLX_Vector la;
> +    HLX_VectorPair acc;
> +    HLX_VectorPair result;
> +    uint32_t exp;
> +
> +    fill_h(buf_a, MPY_A_UH);
> +    fill_w(pw_acc_lo, pw_acc_hi, ACC_INIT);
> +
> +    la = Q6_L_tmp_mem_A(buf_a);
> +    acc = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_acc_hi),
> +                           Q6_L_tmp_mem_A(pw_acc_lo));
> +    result = Q6_LWw_mpyacc_LuhRuh(acc, la, MPY_SCALAR_UH);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(result));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(result));
> +
> +    exp = ACC_INIT + ref_mpy_uu(MPY_A_UH, MPY_SCALAR_UH);
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected_w[j] = exp;
> +    }
> +    check_wp("LX_mpar_wuh", pw_out_lo, pw_out_hi, expected_w, HLX_HALF_ELEMS);
> +}
> +
> +static void test_mpa_whuh(void)
> +{
> +    HLX_Vector la;
> +    HLX_Vector lb;
> +    HLX_VectorPair acc;
> +    HLX_VectorPair result;
> +    uint32_t exp;
> +
> +    fill_h(buf_a, MPY_A_SH);
> +    fill_h(buf_b, MPY_B_UH);
> +    fill_w(pw_acc_lo, pw_acc_hi, ACC_INIT);
> +
> +    la = Q6_L_tmp_mem_A(buf_a);
> +    lb = Q6_L_tmp_mem_A(buf_b);
> +    acc = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_acc_hi),
> +                           Q6_L_tmp_mem_A(pw_acc_lo));
> +    result = Q6_LWw_mpyacc_LhLuh(acc, la, lb);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(result));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(result));
> +
> +    exp = (uint32_t)((int32_t)ACC_INIT +
> +          ref_mpy_su(MPY_A_SH, MPY_B_UH));
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected_w[j] = exp;
> +    }
> +    check_wp("LX_mpa_whuh", pw_out_lo, pw_out_hi, expected_w, HLX_HALF_ELEMS);
> +}
> +
> +static void test_mpar_whuh(void)
> +{
> +    HLX_Vector la;
> +    HLX_VectorPair acc;
> +    HLX_VectorPair result;
> +    uint32_t exp;
> +
> +    fill_h(buf_a, MPY_A_SH);
> +    fill_w(pw_acc_lo, pw_acc_hi, ACC_INIT);
> +
> +    la = Q6_L_tmp_mem_A(buf_a);
> +    acc = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_acc_hi),
> +                           Q6_L_tmp_mem_A(pw_acc_lo));
> +    result = Q6_LWw_mpyacc_LhRuh(acc, la, MPY_SCALAR_SUH);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(result));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(result));
> +
> +    exp = (uint32_t)((int32_t)ACC_INIT +
> +          ref_mpy_su(MPY_A_SH, MPY_SCALAR_SUH));
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected_w[j] = exp;
> +    }
> +    check_wp("LX_mpar_whuh", pw_out_lo, pw_out_hi, expected_w, HLX_HALF_ELEMS);
> +}
> +
> +static void test_mpa_wh(void)
> +{
> +    HLX_Vector la;
> +    HLX_Vector lb;
> +    HLX_VectorPair acc;
> +    HLX_VectorPair result;
> +    uint32_t exp;
> +
> +    fill_h(buf_a, MPY_A_SH);
> +    fill_h(buf_b, MPY_B_SH);
> +    fill_w(pw_acc_lo, pw_acc_hi, ACC_INIT);
> +
> +    la = Q6_L_tmp_mem_A(buf_a);
> +    lb = Q6_L_tmp_mem_A(buf_b);
> +    acc = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_acc_hi),
> +                           Q6_L_tmp_mem_A(pw_acc_lo));
> +    result = Q6_LWw_mpyacc_LhLh(acc, la, lb);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(result));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(result));
> +
> +    exp = (uint32_t)((int32_t)ACC_INIT +
> +          ref_mpy_ss(MPY_A_SH, MPY_B_SH));
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected_w[j] = exp;
> +    }
> +    check_wp("LX_mpa_wh", pw_out_lo, pw_out_hi, expected_w, HLX_HALF_ELEMS);
> +}
> +
> +static void test_mpar_wh(void)
> +{
> +    HLX_Vector la;
> +    HLX_VectorPair acc;
> +    HLX_VectorPair result;
> +    uint32_t exp;
> +
> +    fill_h(buf_a, MPY_A_SH);
> +    fill_w(pw_acc_lo, pw_acc_hi, ACC_INIT);
> +
> +    la = Q6_L_tmp_mem_A(buf_a);
> +    acc = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_acc_hi),
> +                           Q6_L_tmp_mem_A(pw_acc_lo));
> +    result = Q6_LWw_mpyacc_LhRh(acc, la, MPY_SCALAR_SH);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(result));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(result));
> +
> +    exp = (uint32_t)((int32_t)ACC_INIT +
> +          ref_mpy_ss(MPY_A_SH, MPY_SCALAR_SH));
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected_w[j] = exp;
> +    }
> +    check_wp("LX_mpar_wh", pw_out_lo, pw_out_hi, expected_w, HLX_HALF_ELEMS);
> +}
> +
> +int main(void)
> +{
> +    init_vtcm();
> +    enable_hlx();
> +
> +    buf_a = vtcm_alloc(HLX_HALF_ELEMS * sizeof(uint16_t));
> +    buf_b = vtcm_alloc(HLX_HALF_ELEMS * sizeof(uint16_t));
> +    pw_out_lo = vtcm_alloc(HLX_WORD_ELEMS * sizeof(uint32_t));
> +    pw_out_hi = vtcm_alloc(HLX_WORD_ELEMS * sizeof(uint32_t));
> +    pw_acc_lo = vtcm_alloc(HLX_WORD_ELEMS * sizeof(uint32_t));
> +    pw_acc_hi = vtcm_alloc(HLX_WORD_ELEMS * sizeof(uint32_t));
> +    init_hlx_vsp();
> +
> +    /* Widening multiply */
> +    test_mpy_uw_uh();
> +    test_mpyr_uw_uh();
> +    test_mpy_w_huh();
> +    test_mpyr_w_huh();
> +    test_mpy_w_h();
> +    test_mpyr_w_h();
> +
> +    /* Multiply-accumulate */
> +    test_mpa_wuh();
> +    test_mpar_wuh();
> +    test_mpa_whuh();
> +    test_mpar_whuh();
> +    test_mpa_wh();
> +    test_mpar_wh();
> +
> +    puts(err ? "FAIL" : "PASS");
> +    return err;
> +}
> diff --git a/tests/tcg/hexagon/hlx_mpy_adv.c b/tests/tcg/hexagon/hlx_mpy_adv.c
> new file mode 100644
> index 0000000000..7696fd76a9
> --- /dev/null
> +++ b/tests/tcg/hexagon/hlx_mpy_adv.c
> @@ -0,0 +1,452 @@
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "hlx_test.h"
> +
> +/* Operand values for multiplies */
> +#define ADV_A_UH        100
> +#define ADV_B_UH        200
> +#define ADV_A_SH        ((int16_t)-50)
> +#define ADV_SCALAR_UH   42
> +#define ADV_SCALAR_SUH  50
> +
> +/*
> + * Accumulator word value whose lo/hi halves are tested separately.
> + * 0x00300500 => lo half = 0x0500 = 1280, hi half = 0x0030 = 48
> + */
> +#define ACC_W_VAL       0x00300500
> +#define ACC_W_LO        (ACC_W_VAL & 0xFFFF)           /* 1280 */
> +#define ACC_W_HI        ((ACC_W_VAL >> 16) & 0xFFFF)   /* 48   */
> +
> +/* Bias for complex-mpy tests */
> +#define BIAS_VAL        1000
> +#define BIAS_SCALAR      12345
> +#define BIAS_SCALAR_NEG  (-5000)
> +
> +static uint16_t *buf_a;
> +static uint16_t *buf_b;
> +
> +static uint32_t *pw_acc_lo;
> +static uint32_t *pw_acc_hi;
> +static uint32_t *pw_out_lo;
> +static uint32_t *pw_out_hi;
> +static uint32_t *pw_bias_lo;
> +static uint32_t *pw_bias_hi;
> +static uint32_t expected_w[HLX_HALF_ELEMS];
> +
> +static inline uint32_t ref_mpy_uu(uint16_t a, uint16_t b)
> +{
> +    return (uint32_t)a * (uint32_t)b;
> +}
> +
> +static inline int32_t ref_mpy_su(int16_t a, uint16_t b)
> +{
> +    return (int32_t)a * (int32_t)(uint32_t)b;
> +}
> +
> +static void fill_h(uint16_t *buf, int16_t val)
> +{
> +    Q6_mem_Ku16_new_AL(buf, Q6_Lh_equals_Rh(val));
> +}
> +
> +static void fill_w(uint32_t *buf_lo, uint32_t *buf_hi, int32_t val)
> +{
> +    HLX_VectorPair wp = Q6_LWw_equals_Rw(val);
> +    Q6_mem_Ku16_new_AL((uint16_t *)buf_lo, Q6_L_lo_LW(wp));
> +    Q6_mem_Ku16_new_AL((uint16_t *)buf_hi, Q6_L_hi_LW(wp));
> +}
> +
> +
> +static void test_mpa_wuh_lo(void)
> +{
> +    HLX_Vector la;
> +    HLX_Vector lb;
> +    HLX_VectorPair acc;
> +    HLX_VectorPair result;
> +    uint32_t exp;
> +
> +    fill_h(buf_a, ADV_A_UH);
> +    fill_h(buf_b, ADV_B_UH);
> +    fill_w(pw_acc_lo, pw_acc_hi, ACC_W_VAL);
> +
> +    /*
> +     * Lxx.uw = add(mpy(Lu.uh, Lv.uh), lo(Lxx).uh)
> +     * Q6_LWuw_add_mpy_lo_LuhLuhLWuh(Lu, Lv, Lxx)
> +     */
> +    la = Q6_L_tmp_mem_A(buf_a);
> +    lb = Q6_L_tmp_mem_A(buf_b);
> +    acc = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_acc_hi),
> +                           Q6_L_tmp_mem_A(pw_acc_lo));
> +    result = Q6_LWuw_add_mpy_lo_LuhLuhLWuh(la, lb, acc);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(result));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(result));
> +
> +    exp = ref_mpy_uu(ADV_A_UH, ADV_B_UH) + ACC_W_LO;
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected_w[j] = exp;
> +    }
> +    check_wp("LX_mpa_wuh_lo", pw_out_lo, pw_out_hi, expected_w, HLX_HALF_ELEMS);
> +}
> +
> +static void test_mpar_wuh_lo(void)
> +{
> +    HLX_Vector la;
> +    HLX_VectorPair acc;
> +    HLX_VectorPair result;
> +    uint32_t exp;
> +
> +    fill_h(buf_a, ADV_A_UH);
> +    fill_w(pw_acc_lo, pw_acc_hi, ACC_W_VAL);
> +
> +    la = Q6_L_tmp_mem_A(buf_a);
> +    acc = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_acc_hi),
> +                           Q6_L_tmp_mem_A(pw_acc_lo));
> +    result = Q6_LWuw_add_mpy_lo_LuhRuhLWuh(la, ADV_SCALAR_UH,
> +                                           acc);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(result));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(result));
> +
> +    exp = ref_mpy_uu(ADV_A_UH, ADV_SCALAR_UH) + ACC_W_LO;
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected_w[j] = exp;
> +    }
> +    check_wp("LX_mpar_wuh_lo", pw_out_lo, pw_out_hi,
> +             expected_w, HLX_HALF_ELEMS);
> +}
> +
> +static void test_mpa_whuh_lo(void)
> +{
> +    HLX_Vector la;
> +    HLX_Vector lb;
> +    HLX_VectorPair acc;
> +    HLX_VectorPair result;
> +    uint32_t exp;
> +
> +    fill_h(buf_a, ADV_A_SH);
> +    fill_h(buf_b, ADV_B_UH);
> +    fill_w(pw_acc_lo, pw_acc_hi, ACC_W_VAL);
> +
> +    la = Q6_L_tmp_mem_A(buf_a);
> +    lb = Q6_L_tmp_mem_A(buf_b);
> +    acc = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_acc_hi),
> +                           Q6_L_tmp_mem_A(pw_acc_lo));
> +    result = Q6_LWw_add_mpy_lo_LhLuhLWuh(la, lb, acc);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(result));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(result));
> +
> +    exp = (uint32_t)(ref_mpy_su(ADV_A_SH, ADV_B_UH) +
> +          (int32_t)ACC_W_LO);
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected_w[j] = exp;
> +    }
> +    check_wp("LX_mpa_whuh_lo", pw_out_lo, pw_out_hi,
> +             expected_w, HLX_HALF_ELEMS);
> +}
> +
> +static void test_mpar_whuh_lo(void)
> +{
> +    HLX_Vector la;
> +    HLX_VectorPair acc;
> +    HLX_VectorPair result;
> +    uint32_t exp;
> +
> +    fill_h(buf_a, ADV_A_SH);
> +    fill_w(pw_acc_lo, pw_acc_hi, ACC_W_VAL);
> +
> +    la = Q6_L_tmp_mem_A(buf_a);
> +    acc = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_acc_hi),
> +                           Q6_L_tmp_mem_A(pw_acc_lo));
> +    result = Q6_LWw_add_mpy_lo_LhRuhLWuh(la, ADV_SCALAR_SUH,
> +                                         acc);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(result));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(result));
> +
> +    exp = (uint32_t)(ref_mpy_su(ADV_A_SH, ADV_SCALAR_SUH) +
> +          (int32_t)ACC_W_LO);
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected_w[j] = exp;
> +    }
> +    check_wp("LX_mpar_whuh_lo", pw_out_lo, pw_out_hi,
> +             expected_w, HLX_HALF_ELEMS);
> +}
> +
> +
> +static void test_mpa_wuh_hi(void)
> +{
> +    HLX_Vector la;
> +    HLX_Vector lb;
> +    HLX_VectorPair acc;
> +    HLX_VectorPair result;
> +    uint32_t exp;
> +
> +    fill_h(buf_a, ADV_A_UH);
> +    fill_h(buf_b, ADV_B_UH);
> +    fill_w(pw_acc_lo, pw_acc_hi, ACC_W_VAL);
> +
> +    la = Q6_L_tmp_mem_A(buf_a);
> +    lb = Q6_L_tmp_mem_A(buf_b);
> +    acc = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_acc_hi),
> +                           Q6_L_tmp_mem_A(pw_acc_lo));
> +    result = Q6_LWuw_add_mpy_hi_LuhLuhLWuh(la, lb, acc);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(result));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(result));
> +
> +    exp = ref_mpy_uu(ADV_A_UH, ADV_B_UH) + ACC_W_HI;
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected_w[j] = exp;
> +    }
> +    check_wp("LX_mpa_wuh_hi", pw_out_lo, pw_out_hi, expected_w, HLX_HALF_ELEMS);
> +}
> +
> +static void test_mpar_wuh_hi(void)
> +{
> +    HLX_Vector la;
> +    HLX_VectorPair acc;
> +    HLX_VectorPair result;
> +    uint32_t exp;
> +
> +    fill_h(buf_a, ADV_A_UH);
> +    fill_w(pw_acc_lo, pw_acc_hi, ACC_W_VAL);
> +
> +    la = Q6_L_tmp_mem_A(buf_a);
> +    acc = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_acc_hi),
> +                           Q6_L_tmp_mem_A(pw_acc_lo));
> +    result = Q6_LWuw_add_mpy_hi_LuhRuhLWuh(la, ADV_SCALAR_UH,
> +                                           acc);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(result));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(result));
> +
> +    exp = ref_mpy_uu(ADV_A_UH, ADV_SCALAR_UH) + ACC_W_HI;
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected_w[j] = exp;
> +    }
> +    check_wp("LX_mpar_wuh_hi", pw_out_lo, pw_out_hi,
> +             expected_w, HLX_HALF_ELEMS);
> +}
> +
> +static void test_mpa_wh_hi(void)
> +{
> +    HLX_Vector la;
> +    HLX_Vector lb;
> +    HLX_VectorPair acc;
> +    HLX_VectorPair result;
> +    uint32_t exp;
> +
> +    fill_h(buf_a, ADV_A_SH);
> +    fill_h(buf_b, ADV_B_UH);
> +    fill_w(pw_acc_lo, pw_acc_hi, ACC_W_VAL);
> +
> +    la = Q6_L_tmp_mem_A(buf_a);
> +    lb = Q6_L_tmp_mem_A(buf_b);
> +    acc = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_acc_hi),
> +                           Q6_L_tmp_mem_A(pw_acc_lo));
> +    result = Q6_LWuw_add_mpy_hi_LhLuhLWuh(la, lb, acc);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(result));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(result));
> +
> +    exp = (uint32_t)(ref_mpy_su(ADV_A_SH, ADV_B_UH) +
> +          (int32_t)ACC_W_HI);
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected_w[j] = exp;
> +    }
> +    check_wp("LX_mpa_wh_hi", pw_out_lo, pw_out_hi, expected_w, HLX_HALF_ELEMS);
> +}
> +
> +static void test_mpar_wh_hi(void)
> +{
> +    HLX_Vector la;
> +    HLX_VectorPair acc;
> +    HLX_VectorPair result;
> +    uint32_t exp;
> +
> +    fill_h(buf_a, ADV_A_SH);
> +    fill_w(pw_acc_lo, pw_acc_hi, ACC_W_VAL);
> +
> +    la = Q6_L_tmp_mem_A(buf_a);
> +    acc = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_acc_hi),
> +                           Q6_L_tmp_mem_A(pw_acc_lo));
> +    result = Q6_LWuw_add_mpy_hi_LhRuhLWuh(la, ADV_SCALAR_SUH,
> +                                          acc);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(result));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(result));
> +
> +    exp = (uint32_t)(ref_mpy_su(ADV_A_SH, ADV_SCALAR_SUH) +
> +          (int32_t)ACC_W_HI);
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected_w[j] = exp;
> +    }
> +    check_wp("LX_mpar_wh_hi", pw_out_lo, pw_out_hi, expected_w, HLX_HALF_ELEMS);
> +}
> +
> +
> +static void test_mpa_uwuhuw_si(void)
> +{
> +    HLX_Vector la;
> +    HLX_VectorPair acc;
> +    HLX_VectorPair bias;
> +    HLX_VectorPair result;
> +    uint32_t mpy;
> +    uint32_t exp;
> +
> +    fill_h(buf_a, ADV_A_UH);
> +    fill_w(pw_acc_lo, pw_acc_hi, ACC_W_VAL);
> +    fill_w(pw_bias_lo, pw_bias_hi, BIAS_VAL);
> +
> +    /*
> +     * Lxx.uw = add(mpy(Lu.uh, hi(Lxx).uh), Lvv.w)
> +     * fMPY3216UU(A,B) = (uint32_t)((uint64_t)A * (uint32_t)B)
> +     * Q6_LWuw_add_mpy_hi_LuhLWuhLWw(Lu, Lxx, Lvv)
> +     */
> +    la = Q6_L_tmp_mem_A(buf_a);
> +    acc = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_acc_hi),
> +                           Q6_L_tmp_mem_A(pw_acc_lo));
> +    bias = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_bias_hi),
> +                            Q6_L_tmp_mem_A(pw_bias_lo));
> +    result = Q6_LWuw_add_mpy_hi_LuhLWuhLWw(la, acc, bias);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(result));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(result));
> +
> +    mpy = (uint32_t)((uint64_t)ACC_W_HI * (uint32_t)ADV_A_UH);
> +    exp = (uint32_t)BIAS_VAL + mpy;
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected_w[j] = exp;
> +    }
> +    check_wp("LX_mpa_uwuhuw_si", pw_out_lo, pw_out_hi,
> +             expected_w, HLX_HALF_ELEMS);
> +}
> +
> +static void test_mpar_uwuhuw_si(void)
> +{
> +    HLX_Vector la;
> +    HLX_VectorPair acc;
> +    HLX_VectorPair result;
> +    uint32_t mpy;
> +    uint32_t exp;
> +
> +    fill_h(buf_a, ADV_A_UH);
> +    fill_w(pw_acc_lo, pw_acc_hi, ACC_W_VAL);
> +
> +    la = Q6_L_tmp_mem_A(buf_a);
> +    acc = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_acc_hi),
> +                           Q6_L_tmp_mem_A(pw_acc_lo));
> +    result = Q6_LWuw_add_mpy_hi_LuhLWuhRw(la, acc,
> +                                          BIAS_SCALAR);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(result));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(result));
> +
> +    mpy = (uint32_t)((uint64_t)ACC_W_HI * (uint32_t)ADV_A_UH);
> +    exp = (uint32_t)BIAS_SCALAR + mpy;
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected_w[j] = exp;
> +    }
> +    check_wp("LX_mpar_uwuhuw_si", pw_out_lo, pw_out_hi,
> +             expected_w, HLX_HALF_ELEMS);
> +}
> +
> +static void test_mpa_wuhw_si(void)
> +{
> +    HLX_Vector la;
> +    HLX_VectorPair acc;
> +    HLX_VectorPair bias;
> +    HLX_VectorPair result;
> +    int16_t hi_half;
> +    int32_t mpy;
> +    uint32_t exp;
> +
> +    fill_h(buf_a, ADV_A_UH);
> +    fill_w(pw_acc_lo, pw_acc_hi, ACC_W_VAL);
> +    fill_w(pw_bias_lo, pw_bias_hi, BIAS_VAL);
> +
> +    /*
> +     * Lxx.w = add(mpy(Lu.uh, hi(Lxx).h), Lvv.w)
> +     * fMPY3216SU(A,B) = (int32_t)(fSE32_64(A) * fZXTN(16,64,B))
> +     * Here A=hi(Lxx).h (signed), B=Lu.uh (unsigned)
> +     * Q6_LWw_add_mpy_hi_LuhLWhLWw(Lu, Lxx, Lvv)
> +     */
> +    la = Q6_L_tmp_mem_A(buf_a);
> +    acc = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_acc_hi),
> +                           Q6_L_tmp_mem_A(pw_acc_lo));
> +    bias = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_bias_hi),
> +                            Q6_L_tmp_mem_A(pw_bias_lo));
> +    result = Q6_LWw_add_mpy_hi_LuhLWhLWw(la, acc, bias);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(result));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(result));
> +
> +    hi_half = (int16_t)ACC_W_HI;
> +    mpy = (int32_t)((int64_t)hi_half * (uint32_t)ADV_A_UH);
> +    exp = (uint32_t)((int32_t)BIAS_VAL + mpy);
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected_w[j] = exp;
> +    }
> +    check_wp("LX_mpa_wuhw_si", pw_out_lo, pw_out_hi,
> +             expected_w, HLX_HALF_ELEMS);
> +}
> +
> +static void test_mpar_wuhw_si(void)
> +{
> +    HLX_Vector la;
> +    HLX_VectorPair acc;
> +    HLX_VectorPair result;
> +    int16_t hi_half;
> +    int32_t mpy;
> +    uint32_t exp;
> +
> +    fill_h(buf_a, ADV_A_UH);
> +    fill_w(pw_acc_lo, pw_acc_hi, ACC_W_VAL);
> +
> +    la = Q6_L_tmp_mem_A(buf_a);
> +    acc = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_acc_hi),
> +                           Q6_L_tmp_mem_A(pw_acc_lo));
> +    result = Q6_LWw_add_mpy_hi_LuhLWhRw(la, acc,
> +                                        BIAS_SCALAR_NEG);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(result));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(result));
> +
> +    hi_half = (int16_t)ACC_W_HI;
> +    mpy = (int32_t)((int64_t)hi_half * (uint32_t)ADV_A_UH);
> +    exp = (uint32_t)(BIAS_SCALAR_NEG + mpy);
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected_w[j] = exp;
> +    }
> +    check_wp("LX_mpar_wuhw_si", pw_out_lo, pw_out_hi,
> +             expected_w, HLX_HALF_ELEMS);
> +}
> +
> +int main(void)
> +{
> +    init_vtcm();
> +    enable_hlx();
> +
> +    buf_a = vtcm_alloc(HLX_HALF_ELEMS * sizeof(uint16_t));
> +    buf_b = vtcm_alloc(HLX_HALF_ELEMS * sizeof(uint16_t));
> +    pw_acc_lo = vtcm_alloc(HLX_WORD_ELEMS * sizeof(uint32_t));
> +    pw_acc_hi = vtcm_alloc(HLX_WORD_ELEMS * sizeof(uint32_t));
> +    pw_out_lo = vtcm_alloc(HLX_WORD_ELEMS * sizeof(uint32_t));
> +    pw_out_hi = vtcm_alloc(HLX_WORD_ELEMS * sizeof(uint32_t));
> +    pw_bias_lo = vtcm_alloc(HLX_WORD_ELEMS * sizeof(uint32_t));
> +    pw_bias_hi = vtcm_alloc(HLX_WORD_ELEMS * sizeof(uint32_t));
> +    init_hlx_vsp();
> +
> +    /* mpy + lo(Lxx) */
> +    test_mpa_wuh_lo();
> +    test_mpar_wuh_lo();
> +    test_mpa_whuh_lo();
> +    test_mpar_whuh_lo();
> +
> +    /* mpy + hi(Lxx) */
> +    test_mpa_wuh_hi();
> +    test_mpar_wuh_hi();
> +    test_mpa_wh_hi();
> +    test_mpar_wh_hi();
> +
> +    /* Complex mpy */
> +    test_mpa_uwuhuw_si();
> +    test_mpar_uwuhuw_si();
> +    test_mpa_wuhw_si();
> +    test_mpar_wuhw_si();
> +
> +    puts(err ? "FAIL" : "PASS");
> +    return err;
> +}
> diff --git a/tests/tcg/hexagon/hlx_reg_writes.c b/tests/tcg/hexagon/hlx_reg_writes.c
> new file mode 100644
> index 0000000000..2bb0a5a767
> --- /dev/null
> +++ b/tests/tcg/hexagon/hlx_reg_writes.c
> @@ -0,0 +1,151 @@
> +/*
> + * Test HLX packet writes:
> + * - Repeated L-register writes conflict.
> + * - Pair reads use .tmp halves when available.
> + *
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include <signal.h>
> +#include <unistd.h>
> +
> +#include "hlx_test.h"
> +
> +static void *resume_pc;
> +
> +static void handle_sigill(int sig, siginfo_t *info, void *puc)
> +{
> +    ucontext_t *uc = (ucontext_t *)puc;
> +
> +    if (sig != SIGILL) {
> +        _exit(EXIT_FAILURE);
> +    }
> +
> +    uc->uc_mcontext.r0 = SIGILL;
> +    uc->uc_mcontext.pc = (unsigned long)resume_pc;
> +}
> +
> +/* { L6.h = L0.h; L6.h = L1.h } */
> +static int test_conflict_single(void)
> +{
> +    int sig;
> +
> +    asm volatile("r0 = #0\n"
> +                 "r1 = ##1f\n"
> +                 "memw(%[resume_pc]) = r1\n"
> +                 ".word 0xe500782c\n"
> +                 ".word 0xe500f86c\n"
> +                 "1:\n"
> +                 "%[sig] = r0\n"
> +                 : [sig] "=r"(sig)
> +                 : [resume_pc] "r"(&resume_pc)
> +                 : "r0", "r1", "memory");
> +    return sig;
> +}
> +
> +/* { L6.h = L1.h; L7:6 = combine(L0, L2) } */
> +static int test_conflict_pair(void)
> +{
> +    int sig;
> +
> +    asm volatile("r0 = #0\n"
> +                 "r1 = ##1f\n"
> +                 "memw(%[resume_pc]) = r1\n"
> +                 ".word 0xe500786c\n"
> +                 ".word 0xef24e02d\n"
> +                 "1:\n"
> +                 "%[sig] = r0\n"
> +                 : [sig] "=r"(sig)
> +                 : [resume_pc] "r"(&resume_pc)
> +                 : "r0", "r1", "memory");
> +    return sig;
> +}
> +
> +static HLX_Vector zero, live_lo, live_hi, tmp_val, stale;
> +
> +static void init_vectors(void)
> +{
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        zero.h[i] = 0;
> +        live_lo.h[i] = i * 3 + 1;
> +        live_hi.h[i] = i * 5 + 7;
> +        tmp_val.h[i] = i * 11 + 2;
> +        stale.h[i] = 0xdead;
> +    }
> +}
> +
> +static void check_v(const char *name, HLX_Vector got, HLX_Vector exp)
> +{
> +    check_h(name, got.h, exp.h, HLX_HALF_ELEMS);
> +}
> +
> +/* L4 uses .tmp while L5 uses its live value. */
> +static void test_tmp_pair_lo(void)
> +{
> +    hlx_put_v(0, zero);
> +    hlx_put_v(2, zero);
> +    hlx_put_v(3, live_hi);
> +    hlx_put_v(4, live_lo);
> +    hlx_put_v(6, tmp_val);
> +    hlx_put_v(7, stale);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD2 HLX_LD3 HLX_LD4
> +                 /* { L5.h = L3.h } */
> +                 ".word 0xe500f8ea\n"
> +                 /* { L1.h = L5.h; L5.tmp = mem(r7) } */
> +                 ".word 0xe5007962\n"
> +                 ".word 0x9807d005\n"
> +                 /* { mem(r7) = L5.new } stores zero without changing L5. */
> +                 ".word 0xa487c005\n"
> +                 /* { L5:4.w += mpy(L0.h, L2.h); L4.tmp = mem(r6) } */
> +                 ".word 0xe7046829\n"
> +                 ".word 0x9806d004\n"
> +                 HLX_ST4 HLX_ST5
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    check_v("tmp pair lo: L4", hlx_get_v(4), tmp_val);
> +    check_v("tmp pair lo: L5", hlx_get_v(5), live_hi);
> +}
> +
> +/* The packet loads the high half of L5:4 with .tmp. */
> +static void test_tmp_pair_hi(void)
> +{
> +    hlx_put_v(0, zero);
> +    hlx_put_v(2, zero);
> +    hlx_put_v(4, live_lo);
> +    hlx_put_v(5, live_hi);
> +    hlx_put_v(6, tmp_val);
> +    asm volatile(HLX_PTRS HLX_LD0 HLX_LD2 HLX_LD4 HLX_LD5
> +                 /* { L5:4.w += mpy(L0.h, L2.h); L5.tmp = mem(r6) } */
> +                 ".word 0xe7046829\n"
> +                 ".word 0x9806d005\n"
> +                 HLX_ST4 HLX_ST5
> +                 : : [stage] "r"(hlx_stage) : HLX_CLOBBERS);
> +    check_v("tmp pair hi: L4", hlx_get_v(4), live_lo);
> +    check_v("tmp pair hi: L5", hlx_get_v(5), tmp_val);
> +}
> +
> +int main(void)
> +{
> +    struct sigaction act;
> +
> +    memset(&act, 0, sizeof(act));
> +    act.sa_sigaction = handle_sigill;
> +    act.sa_flags = SA_SIGINFO;
> +    sigaction(SIGILL, &act, NULL);
> +
> +    if (test_conflict_single() != SIGILL) {
> +        printf("FAIL conflict single: no SIGILL\n");
> +        err++;
> +    }
> +    if (test_conflict_pair() != SIGILL) {
> +        printf("FAIL conflict pair: no SIGILL\n");
> +        err++;
> +    }
> +
> +    init_vectors();
> +    test_tmp_pair_lo();
> +    test_tmp_pair_hi();
> +
> +    puts(err ? "FAIL" : "PASS");
> +    return err;
> +}
> diff --git a/tests/tcg/hexagon/hlx_shift.c b/tests/tcg/hexagon/hlx_shift.c
> new file mode 100644
> index 0000000000..2b540a7b24
> --- /dev/null
> +++ b/tests/tcg/hexagon/hlx_shift.c
> @@ -0,0 +1,545 @@
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "hlx_test.h"
> +
> +/* Expected values are from hexagon-sim -mv85qa_1. */
> +#define SRC_UH           0x5678
> +#define SRC_SH           ((int16_t)-1234)
> +#define SHAMT_H          4
> +#define SRC_UW           0x12345678u
> +#define SRC_SW           ((int32_t)-12345678)
> +#define SHAMT_W          8
> +#define NARROW_SRC_W     0x00ABCD00
> +#define NARROW_SHAMT     8
> +
> +static uint16_t *buf_src;
> +static uint16_t *buf_shamt;
> +static uint16_t *buf_out;
> +static uint16_t expected[HLX_HALF_ELEMS];
> +
> +static uint32_t *pw_src_lo;
> +static uint32_t *pw_src_hi;
> +static uint32_t *pw_out_lo;
> +static uint32_t *pw_out_hi;
> +static uint32_t expected_w[HLX_HALF_ELEMS];
> +
> +static void fill_h(uint16_t *buf, int16_t val)
> +{
> +    Q6_mem_Ku16_new_AL(buf, Q6_Lh_equals_Rh(val));
> +}
> +
> +static void fill_w(uint32_t *buf_lo, uint32_t *buf_hi, int32_t val)
> +{
> +    HLX_VectorPair wp = Q6_LWw_equals_Rw(val);
> +    Q6_mem_Ku16_new_AL((uint16_t *)buf_lo, Q6_L_lo_LW(wp));
> +    Q6_mem_Ku16_new_AL((uint16_t *)buf_hi, Q6_L_hi_LW(wp));
> +}
> +
> +
> +static void test_shr_uh_uh(void)
> +{
> +    HLX_Vector la;
> +    HLX_Vector lshamt;
> +    uint16_t exp;
> +
> +    fill_h(buf_src, (int16_t)SRC_UH);
> +    fill_h(buf_shamt, (int16_t)SHAMT_H);
> +
> +    la = Q6_L_tmp_mem_A(buf_src);
> +    lshamt = Q6_L_tmp_mem_A(buf_shamt);
> +    Q6_mem_Ku16_new_AL(buf_out, Q6_Luh_shr_LuhLh(la, lshamt));
> +
> +    exp = 0x0567;
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        expected[i] = exp;
> +    }
> +    check_h("LX_shr_uh_uh", buf_out, expected, HLX_HALF_ELEMS);
> +}
> +
> +static void test_shrr_uh_uh(void)
> +{
> +    int16_t scalar;
> +    HLX_Vector la;
> +    uint16_t exp;
> +
> +    fill_h(buf_src, (int16_t)SRC_UH);
> +    scalar = -SHAMT_H;
> +
> +    la = Q6_L_tmp_mem_A(buf_src);
> +    Q6_mem_Ku16_new_AL(buf_out, Q6_Luh_shr_LuhRh(la, scalar));
> +
> +    exp = 0x6780;
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        expected[i] = exp;
> +    }
> +    check_h("LX_shrr_uh_uh", buf_out, expected, HLX_HALF_ELEMS);
> +}
> +
> +static void test_shr_h(void)
> +{
> +    HLX_Vector la;
> +    HLX_Vector lshamt;
> +    uint16_t exp;
> +
> +    fill_h(buf_src, SRC_SH);
> +    fill_h(buf_shamt, (int16_t)SHAMT_H);
> +
> +    la = Q6_L_tmp_mem_A(buf_src);
> +    lshamt = Q6_L_tmp_mem_A(buf_shamt);
> +    Q6_mem_Ku16_new_AL(buf_out, Q6_Lh_shr_LhLh(la, lshamt));
> +
> +    exp = 0xffb2;
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        expected[i] = exp;
> +    }
> +    check_h("LX_shr_h", buf_out, expected, HLX_HALF_ELEMS);
> +}
> +
> +static void test_shrr_h(void)
> +{
> +    int16_t scalar;
> +    HLX_Vector la;
> +    uint16_t exp;
> +
> +    fill_h(buf_src, SRC_SH);
> +    scalar = -SHAMT_H;
> +
> +    la = Q6_L_tmp_mem_A(buf_src);
> +    Q6_mem_Ku16_new_AL(buf_out, Q6_Lh_shr_LhRh(la, scalar));
> +
> +    exp = 0xb2e0;
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        expected[i] = exp;
> +    }
> +    check_h("LX_shrr_h", buf_out, expected, HLX_HALF_ELEMS);
> +}
> +
> +
> +static void test_shr_uw_uw(void)
> +{
> +    HLX_VectorPair pa;
> +    HLX_Vector lshamt;
> +    HLX_VectorPair result;
> +
> +    fill_w(pw_src_lo, pw_src_hi, (int32_t)SRC_UW);
> +    fill_h(buf_shamt, (int16_t)SHAMT_W);
> +
> +    pa = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_src_hi),
> +                          Q6_L_tmp_mem_A(pw_src_lo));
> +    lshamt = Q6_L_tmp_mem_A(buf_shamt);
> +    result = Q6_LWuw_shr_LWuwLh(pa, lshamt);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(result));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(result));
> +
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected_w[j] = 0x00123456u;
> +    }
> +    check_wp("LX_shr_uw_uw", pw_out_lo, pw_out_hi, expected_w, HLX_HALF_ELEMS);
> +}
> +
> +static void test_shrr_uw_uw(void)
> +{
> +    int16_t scalar;
> +    HLX_VectorPair pa;
> +    HLX_VectorPair result;
> +
> +    fill_w(pw_src_lo, pw_src_hi, (int32_t)SRC_UW);
> +    scalar = -SHAMT_W;
> +
> +    pa = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_src_hi),
> +                          Q6_L_tmp_mem_A(pw_src_lo));
> +    result = Q6_LWuw_shr_LWuwRh(pa, scalar);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(result));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(result));
> +
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected_w[j] = 0x34567800u;
> +    }
> +    check_wp("LX_shrr_uw_uw", pw_out_lo, pw_out_hi, expected_w, HLX_HALF_ELEMS);
> +}
> +
> +static void test_shr_w_w(void)
> +{
> +    HLX_VectorPair pa;
> +    HLX_Vector lshamt;
> +    HLX_VectorPair result;
> +
> +    fill_w(pw_src_lo, pw_src_hi, SRC_SW);
> +    fill_h(buf_shamt, (int16_t)SHAMT_W);
> +
> +    pa = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_src_hi),
> +                          Q6_L_tmp_mem_A(pw_src_lo));
> +    lshamt = Q6_L_tmp_mem_A(buf_shamt);
> +    result = Q6_LWw_shr_LWwLh(pa, lshamt);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(result));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(result));
> +
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected_w[j] = 0xffff439eu;
> +    }
> +    check_wp("LX_shr_w_w", pw_out_lo, pw_out_hi, expected_w, HLX_HALF_ELEMS);
> +}
> +
> +static void test_shrr_w_w(void)
> +{
> +    int16_t scalar;
> +    HLX_VectorPair pa;
> +    HLX_VectorPair result;
> +
> +    fill_w(pw_src_lo, pw_src_hi, SRC_SW);
> +    scalar = -SHAMT_W;
> +
> +    pa = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_src_hi),
> +                          Q6_L_tmp_mem_A(pw_src_lo));
> +    result = Q6_LWw_shr_LWwRh(pa, scalar);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(result));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(result));
> +
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected_w[j] = 0x439eb200u;
> +    }
> +    check_wp("LX_shrr_w_w", pw_out_lo, pw_out_hi, expected_w, HLX_HALF_ELEMS);
> +}
> +
> +
> +static void test_shr_h_w_uh(void)
> +{
> +    HLX_VectorPair pa;
> +    HLX_Vector lshamt;
> +    uint16_t exp;
> +
> +    fill_w(pw_src_lo, pw_src_hi, (int32_t)NARROW_SRC_W);
> +    fill_h(buf_shamt, (int16_t)NARROW_SHAMT);
> +
> +    pa = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_src_hi),
> +                          Q6_L_tmp_mem_A(pw_src_lo));
> +    lshamt = Q6_L_tmp_mem_A(buf_shamt);
> +    Q6_mem_Ku16_new_AL(buf_out, Q6_Lh_shr_LWwLuh(pa, lshamt));
> +
> +    exp = (uint16_t)((int32_t)NARROW_SRC_W >> (NARROW_SHAMT & 15));
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        expected[i] = exp;
> +    }
> +    check_h("LX_shr_h_w_uh", buf_out, expected, HLX_HALF_ELEMS);
> +}
> +
> +static void test_shrr_h_w_uh(void)
> +{
> +    uint16_t scalar;
> +    HLX_VectorPair pa;
> +    uint16_t exp;
> +
> +    fill_w(pw_src_lo, pw_src_hi, (int32_t)NARROW_SRC_W);
> +    scalar = NARROW_SHAMT;
> +
> +    pa = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_src_hi),
> +                          Q6_L_tmp_mem_A(pw_src_lo));
> +    Q6_mem_Ku16_new_AL(buf_out, Q6_Lh_shr_LWwRuh(pa, scalar));
> +
> +    exp = (uint16_t)((int32_t)NARROW_SRC_W >> (scalar & 15));
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        expected[i] = exp;
> +    }
> +    check_h("LX_shrr_h_w_uh", buf_out, expected, HLX_HALF_ELEMS);
> +}
> +
> +
> +static void test_shr_h_w_sat(void)
> +{
> +    HLX_VectorPair pa;
> +    HLX_Vector lshamt;
> +    uint16_t exp;
> +
> +    fill_w(pw_src_lo, pw_src_hi, SRC_SW);
> +    fill_h(buf_shamt, (int16_t)SHAMT_W);
> +
> +    pa = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_src_hi),
> +                          Q6_L_tmp_mem_A(pw_src_lo));
> +    lshamt = Q6_L_tmp_mem_A(buf_shamt);
> +    Q6_mem_Ku16_new_AL(buf_out, Q6_Lh_shr_LWwLh_sat(pa, lshamt));
> +
> +    exp = 0x8000;
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        expected[i] = exp;
> +    }
> +    check_h("LX_shr_h_w_sat", buf_out, expected, HLX_HALF_ELEMS);
> +}
> +
> +static void test_shrr_h_w_sat(void)
> +{
> +    int16_t scalar;
> +    HLX_VectorPair pa;
> +    uint16_t exp;
> +
> +    fill_w(pw_src_lo, pw_src_hi, SRC_SW);
> +    scalar = -SHAMT_H;
> +
> +    pa = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_src_hi),
> +                          Q6_L_tmp_mem_A(pw_src_lo));
> +    Q6_mem_Ku16_new_AL(buf_out, Q6_Lh_shr_LWwRh_sat(pa, scalar));
> +
> +    exp = 0x8000;
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        expected[i] = exp;
> +    }
> +    check_h("LX_shrr_h_w_sat", buf_out, expected, HLX_HALF_ELEMS);
> +}
> +
> +static void test_shr_h_w_rnd_sat(void)
> +{
> +    HLX_VectorPair pa;
> +    HLX_Vector lshamt;
> +    uint16_t exp;
> +
> +    fill_w(pw_src_lo, pw_src_hi, SRC_SW);
> +    fill_h(buf_shamt, (int16_t)SHAMT_W);
> +
> +    pa = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_src_hi),
> +                          Q6_L_tmp_mem_A(pw_src_lo));
> +    lshamt = Q6_L_tmp_mem_A(buf_shamt);
> +    Q6_mem_Ku16_new_AL(buf_out, Q6_Lh_shr_LWwLh_rnd_sat(pa, lshamt));
> +
> +    exp = 0x8000;
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        expected[i] = exp;
> +    }
> +    check_h("LX_shr_h_w_rnd_sat", buf_out, expected, HLX_HALF_ELEMS);
> +}
> +
> +static void test_shrr_h_w_rnd_sat(void)
> +{
> +    int16_t scalar;
> +    HLX_VectorPair pa;
> +    uint16_t exp;
> +
> +    fill_w(pw_src_lo, pw_src_hi, SRC_SW);
> +    scalar = -SHAMT_W;
> +
> +    pa = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_src_hi),
> +                          Q6_L_tmp_mem_A(pw_src_lo));
> +    Q6_mem_Ku16_new_AL(buf_out, Q6_Lh_shr_LWwRh_rnd_sat(pa, scalar));
> +
> +    exp = 0x8000;
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        expected[i] = exp;
> +    }
> +    check_h("LX_shrr_h_w_rnd_sat", buf_out, expected, HLX_HALF_ELEMS);
> +}
> +
> +
> +static void test_shr_uh_uw_sat(void)
> +{
> +    HLX_VectorPair pa;
> +    HLX_Vector lshamt;
> +    uint16_t exp;
> +
> +    fill_w(pw_src_lo, pw_src_hi, (int32_t)SRC_UW);
> +    fill_h(buf_shamt, (int16_t)SHAMT_W);
> +
> +    pa = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_src_hi),
> +                          Q6_L_tmp_mem_A(pw_src_lo));
> +    lshamt = Q6_L_tmp_mem_A(buf_shamt);
> +    Q6_mem_Ku16_new_AL(buf_out, Q6_Luh_shr_LWuwLh_sat(pa, lshamt));
> +
> +    exp = 0xffff;
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        expected[i] = exp;
> +    }
> +    check_h("LX_shr_uh_uw_sat", buf_out, expected, HLX_HALF_ELEMS);
> +}
> +
> +static void test_shrr_uh_uw_sat(void)
> +{
> +    int16_t scalar;
> +    HLX_VectorPair pa;
> +    uint16_t exp;
> +
> +    fill_w(pw_src_lo, pw_src_hi, (int32_t)SRC_UW);
> +    scalar = -SHAMT_W;
> +
> +    pa = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_src_hi),
> +                          Q6_L_tmp_mem_A(pw_src_lo));
> +    Q6_mem_Ku16_new_AL(buf_out, Q6_Luh_shr_LWuwRh_sat(pa, scalar));
> +
> +    exp = 0xffff;
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        expected[i] = exp;
> +    }
> +    check_h("LX_shrr_uh_uw_sat", buf_out, expected, HLX_HALF_ELEMS);
> +}
> +
> +static void test_shr_uh_uw_rnd_sat(void)
> +{
> +    HLX_VectorPair pa;
> +    HLX_Vector lshamt;
> +    uint16_t exp;
> +
> +    fill_w(pw_src_lo, pw_src_hi, (int32_t)SRC_UW);
> +    fill_h(buf_shamt, (int16_t)SHAMT_W);
> +
> +    pa = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_src_hi),
> +                          Q6_L_tmp_mem_A(pw_src_lo));
> +    lshamt = Q6_L_tmp_mem_A(buf_shamt);
> +    Q6_mem_Ku16_new_AL(buf_out, Q6_Luh_shr_LWuwLh_rnd_sat(pa, lshamt));
> +
> +    exp = 0xffff;
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        expected[i] = exp;
> +    }
> +    check_h("LX_shr_uh_uw_rnd_sat", buf_out, expected, HLX_HALF_ELEMS);
> +}
> +
> +static void test_shrr_uh_uw_rnd_sat(void)
> +{
> +    int16_t scalar;
> +    HLX_VectorPair pa;
> +    uint16_t exp;
> +
> +    fill_w(pw_src_lo, pw_src_hi, (int32_t)SRC_UW);
> +    scalar = -SHAMT_W;
> +
> +    pa = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_src_hi),
> +                          Q6_L_tmp_mem_A(pw_src_lo));
> +    Q6_mem_Ku16_new_AL(buf_out, Q6_Luh_shr_LWuwRh_rnd_sat(pa, scalar));
> +
> +    exp = 0xffff;
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        expected[i] = exp;
> +    }
> +    check_h("LX_shrr_uh_uw_rnd_sat", buf_out, expected, HLX_HALF_ELEMS);
> +}
> +
> +static void test_shr_uh_w_sat(void)
> +{
> +    HLX_VectorPair pa;
> +    HLX_Vector lshamt;
> +    uint16_t exp;
> +
> +    fill_w(pw_src_lo, pw_src_hi, SRC_SW);
> +    fill_h(buf_shamt, (int16_t)SHAMT_W);
> +
> +    pa = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_src_hi),
> +                          Q6_L_tmp_mem_A(pw_src_lo));
> +    lshamt = Q6_L_tmp_mem_A(buf_shamt);
> +    Q6_mem_Ku16_new_AL(buf_out, Q6_Luh_shr_LWwLh_sat(pa, lshamt));
> +
> +    exp = 0x0000;
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        expected[i] = exp;
> +    }
> +    check_h("LX_shr_uh_w_sat", buf_out, expected, HLX_HALF_ELEMS);
> +}
> +
> +static void test_shrr_uh_w_sat(void)
> +{
> +    int16_t scalar;
> +    HLX_VectorPair pa;
> +    uint16_t exp;
> +
> +    fill_w(pw_src_lo, pw_src_hi, SRC_SW);
> +    scalar = -SHAMT_W;
> +
> +    pa = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_src_hi),
> +                          Q6_L_tmp_mem_A(pw_src_lo));
> +    Q6_mem_Ku16_new_AL(buf_out, Q6_Luh_shr_LWwRh_sat(pa, scalar));
> +
> +    exp = 0x0000;
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        expected[i] = exp;
> +    }
> +    check_h("LX_shrr_uh_w_sat", buf_out, expected, HLX_HALF_ELEMS);
> +}
> +
> +static void test_shr_uh_w_rnd_sat(void)
> +{
> +    HLX_VectorPair pa;
> +    HLX_Vector lshamt;
> +    uint16_t exp;
> +
> +    fill_w(pw_src_lo, pw_src_hi, SRC_SW);
> +    fill_h(buf_shamt, (int16_t)SHAMT_W);
> +
> +    pa = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_src_hi),
> +                          Q6_L_tmp_mem_A(pw_src_lo));
> +    lshamt = Q6_L_tmp_mem_A(buf_shamt);
> +    Q6_mem_Ku16_new_AL(buf_out, Q6_Luh_shr_LWwLh_rnd_sat(pa, lshamt));
> +
> +    exp = 0x0000;
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        expected[i] = exp;
> +    }
> +    check_h("LX_shr_uh_w_rnd_sat", buf_out, expected, HLX_HALF_ELEMS);
> +}
> +
> +static void test_shrr_uh_w_rnd_sat(void)
> +{
> +    int16_t scalar;
> +    HLX_VectorPair pa;
> +    uint16_t exp;
> +
> +    fill_w(pw_src_lo, pw_src_hi, SRC_SW);
> +    scalar = -SHAMT_W;
> +
> +    pa = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_src_hi),
> +                          Q6_L_tmp_mem_A(pw_src_lo));
> +    Q6_mem_Ku16_new_AL(buf_out, Q6_Luh_shr_LWwRh_rnd_sat(pa, scalar));
> +
> +    exp = 0x0000;
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        expected[i] = exp;
> +    }
> +    check_h("LX_shrr_uh_w_rnd_sat", buf_out, expected, HLX_HALF_ELEMS);
> +}
> +
> +int main(void)
> +{
> +    init_vtcm();
> +    enable_hlx();
> +
> +    buf_src = vtcm_alloc(HLX_HALF_ELEMS * sizeof(uint16_t));
> +    buf_shamt = vtcm_alloc(HLX_HALF_ELEMS * sizeof(uint16_t));
> +    buf_out = vtcm_alloc(HLX_HALF_ELEMS * sizeof(uint16_t));
> +    pw_src_lo = vtcm_alloc(HLX_WORD_ELEMS * sizeof(uint32_t));
> +    pw_src_hi = vtcm_alloc(HLX_WORD_ELEMS * sizeof(uint32_t));
> +    pw_out_lo = vtcm_alloc(HLX_WORD_ELEMS * sizeof(uint32_t));
> +    pw_out_hi = vtcm_alloc(HLX_WORD_ELEMS * sizeof(uint32_t));
> +    init_hlx_vsp();
> +
> +    /* Basic halfword shifts */
> +    test_shr_uh_uh();
> +    test_shrr_uh_uh();
> +    test_shr_h();
> +    test_shrr_h();
> +
> +    /* Word pair shifts */
> +    test_shr_uw_uw();
> +    test_shrr_uw_uw();
> +    test_shr_w_w();
> +    test_shrr_w_w();
> +
> +    /* Narrowing shifts */
> +    test_shr_h_w_uh();
> +    test_shrr_h_w_uh();
> +
> +    /* Narrowing shifts with saturation */
> +    test_shr_h_w_sat();
> +    test_shrr_h_w_sat();
> +    test_shr_h_w_rnd_sat();
> +    test_shrr_h_w_rnd_sat();
> +
> +    /* Unsigned narrowing with saturation */
> +    test_shr_uh_uw_sat();
> +    test_shrr_uh_uw_sat();
> +    test_shr_uh_uw_rnd_sat();
> +    test_shrr_uh_uw_rnd_sat();
> +    test_shr_uh_w_sat();
> +    test_shrr_uh_w_sat();
> +    test_shr_uh_w_rnd_sat();
> +    test_shrr_uh_w_rnd_sat();
> +
> +    puts(err ? "FAIL" : "PASS");
> +    return err;
> +}
> diff --git a/tests/tcg/hexagon/hlx_shift_acc.c b/tests/tcg/hexagon/hlx_shift_acc.c
> new file mode 100644
> index 0000000000..a03b91e2dd
> --- /dev/null
> +++ b/tests/tcg/hexagon/hlx_shift_acc.c
> @@ -0,0 +1,275 @@
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "hlx_test.h"
> +
> +/* Named constants */
> +#define ACC_H            1000
> +#define SRC_H            0x1234
> +#define SHAMT_H          4
> +#define ACC_W            50000
> +#define SRC_W            0x00123400
> +#define SHAMT_W          8
> +
> +static uint16_t *buf_src;
> +static uint16_t *buf_shamt;
> +static uint16_t *buf_acc;
> +static uint16_t *buf_out;
> +static uint16_t expected[HLX_HALF_ELEMS];
> +
> +static uint32_t *pw_src_lo;
> +static uint32_t *pw_src_hi;
> +static uint32_t *pw_acc_lo;
> +static uint32_t *pw_acc_hi;
> +static uint32_t *pw_out_lo;
> +static uint32_t *pw_out_hi;
> +static uint32_t expected_w[HLX_HALF_ELEMS];
> +
> +static void fill_h(uint16_t *buf, int16_t val)
> +{
> +    Q6_mem_Ku16_new_AL(buf, Q6_Lh_equals_Rh(val));
> +}
> +
> +static void fill_w(uint32_t *buf_lo, uint32_t *buf_hi, int32_t val)
> +{
> +    HLX_VectorPair wp = Q6_LWw_equals_Rw(val);
> +    Q6_mem_Ku16_new_AL((uint16_t *)buf_lo, Q6_L_lo_LW(wp));
> +    Q6_mem_Ku16_new_AL((uint16_t *)buf_hi, Q6_L_hi_LW(wp));
> +}
> +
> +
> +static void test_shra_h_uh(void)
> +{
> +    HLX_Vector lacc;
> +    HLX_Vector lsrc;
> +    HLX_Vector lshamt;
> +    uint16_t exp;
> +
> +    fill_h(buf_acc, ACC_H);
> +    fill_h(buf_src, (int16_t)SRC_H);
> +    fill_h(buf_shamt, (int16_t)SHAMT_H);
> +
> +    lacc = Q6_L_tmp_mem_A(buf_acc);
> +    lsrc = Q6_L_tmp_mem_A(buf_src);
> +    lshamt = Q6_L_tmp_mem_A(buf_shamt);
> +    Q6_mem_Ku16_new_AL(buf_out, Q6_Lh_shracc_LuhLh(lacc, lsrc, lshamt));
> +
> +    exp = 0x050b;
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        expected[i] = exp;
> +    }
> +    check_h("LX_shra_h_uh", buf_out, expected, HLX_HALF_ELEMS);
> +}
> +
> +static void test_shrar_h_uh(void)
> +{
> +    int16_t scalar;
> +    HLX_Vector lacc;
> +    HLX_Vector lsrc;
> +    uint16_t exp;
> +
> +    fill_h(buf_acc, ACC_H);
> +    fill_h(buf_src, (int16_t)SRC_H);
> +    scalar = -SHAMT_H;
> +
> +    lacc = Q6_L_tmp_mem_A(buf_acc);
> +    lsrc = Q6_L_tmp_mem_A(buf_src);
> +    Q6_mem_Ku16_new_AL(buf_out, Q6_Lh_shracc_LuhRh(lacc, lsrc, scalar));
> +
> +    exp = 0x2728;
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        expected[i] = exp;
> +    }
> +    check_h("LX_shrar_h_uh", buf_out, expected, HLX_HALF_ELEMS);
> +}
> +
> +static void test_shra_h_h(void)
> +{
> +    HLX_Vector lacc;
> +    HLX_Vector lsrc;
> +    HLX_Vector lshamt;
> +    uint16_t exp;
> +
> +    fill_h(buf_acc, ACC_H);
> +    fill_h(buf_src, (int16_t)SRC_H);
> +    fill_h(buf_shamt, (int16_t)SHAMT_H);
> +
> +    lacc = Q6_L_tmp_mem_A(buf_acc);
> +    lsrc = Q6_L_tmp_mem_A(buf_src);
> +    lshamt = Q6_L_tmp_mem_A(buf_shamt);
> +    Q6_mem_Ku16_new_AL(buf_out, Q6_Lh_shracc_LhLh(lacc, lsrc, lshamt));
> +
> +    exp = 0x050b;
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        expected[i] = exp;
> +    }
> +    check_h("LX_shra_h_h", buf_out, expected, HLX_HALF_ELEMS);
> +}
> +
> +static void test_shrar_h_h(void)
> +{
> +    int16_t scalar;
> +    HLX_Vector lacc;
> +    HLX_Vector lsrc;
> +    uint16_t exp;
> +
> +    fill_h(buf_acc, ACC_H);
> +    fill_h(buf_src, (int16_t)SRC_H);
> +    scalar = -SHAMT_H;
> +
> +    lacc = Q6_L_tmp_mem_A(buf_acc);
> +    lsrc = Q6_L_tmp_mem_A(buf_src);
> +    Q6_mem_Ku16_new_AL(buf_out, Q6_Lh_shracc_LhRh(lacc, lsrc, scalar));
> +
> +    exp = 0x2728;
> +    for (int i = 0; i < HLX_HALF_ELEMS; i++) {
> +        expected[i] = exp;
> +    }
> +    check_h("LX_shrar_h_h", buf_out, expected, HLX_HALF_ELEMS);
> +}
> +
> +
> +static void test_shra_w_uw(void)
> +{
> +    HLX_VectorPair acc;
> +    HLX_VectorPair src;
> +    HLX_Vector lshamt;
> +    HLX_VectorPair result;
> +    uint32_t exp;
> +
> +    fill_w(pw_acc_lo, pw_acc_hi, ACC_W);
> +    fill_w(pw_src_lo, pw_src_hi, (int32_t)SRC_W);
> +    fill_h(buf_shamt, (int16_t)SHAMT_W);
> +
> +    acc = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_acc_hi),
> +                           Q6_L_tmp_mem_A(pw_acc_lo));
> +    src = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_src_hi),
> +                           Q6_L_tmp_mem_A(pw_src_lo));
> +    lshamt = Q6_L_tmp_mem_A(buf_shamt);
> +    result = Q6_LWw_shracc_LWuwLh(acc, src, lshamt);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(result));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(result));
> +
> +    exp = 0x0000d584;
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected_w[j] = exp;
> +    }
> +    check_wp("LX_shra_w_uw", pw_out_lo, pw_out_hi, expected_w, HLX_HALF_ELEMS);
> +}
> +
> +static void test_shrar_w_uw(void)
> +{
> +    int16_t scalar;
> +    HLX_VectorPair acc;
> +    HLX_VectorPair src;
> +    HLX_VectorPair result;
> +    uint32_t exp;
> +
> +    fill_w(pw_acc_lo, pw_acc_hi, ACC_W);
> +    fill_w(pw_src_lo, pw_src_hi, (int32_t)SRC_W);
> +    scalar = -SHAMT_W;
> +
> +    acc = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_acc_hi),
> +                           Q6_L_tmp_mem_A(pw_acc_lo));
> +    src = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_src_hi),
> +                           Q6_L_tmp_mem_A(pw_src_lo));
> +    result = Q6_LWw_shracc_LWuwRh(acc, src, scalar);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(result));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(result));
> +
> +    exp = 0x1234c350;
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected_w[j] = exp;
> +    }
> +    check_wp("LX_shrar_w_uw", pw_out_lo, pw_out_hi, expected_w, HLX_HALF_ELEMS);
> +}
> +
> +static void test_shra_w_w(void)
> +{
> +    HLX_VectorPair acc;
> +    HLX_VectorPair src;
> +    HLX_Vector lshamt;
> +    HLX_VectorPair result;
> +    uint32_t exp;
> +
> +    fill_w(pw_acc_lo, pw_acc_hi, ACC_W);
> +    fill_w(pw_src_lo, pw_src_hi, (int32_t)SRC_W);
> +    fill_h(buf_shamt, (int16_t)SHAMT_W);
> +
> +    acc = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_acc_hi),
> +                           Q6_L_tmp_mem_A(pw_acc_lo));
> +    src = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_src_hi),
> +                           Q6_L_tmp_mem_A(pw_src_lo));
> +    lshamt = Q6_L_tmp_mem_A(buf_shamt);
> +    result = Q6_LWw_shracc_LWwLh(acc, src, lshamt);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(result));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(result));
> +
> +    exp = 0x0000d584;
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected_w[j] = exp;
> +    }
> +    check_wp("LX_shra_w_w", pw_out_lo, pw_out_hi, expected_w, HLX_HALF_ELEMS);
> +}
> +
> +static void test_shrar_w_w(void)
> +{
> +    int16_t scalar;
> +    HLX_VectorPair acc;
> +    HLX_VectorPair src;
> +    HLX_VectorPair result;
> +    uint32_t exp;
> +
> +    fill_w(pw_acc_lo, pw_acc_hi, ACC_W);
> +    fill_w(pw_src_lo, pw_src_hi, (int32_t)SRC_W);
> +    scalar = -SHAMT_W;
> +
> +    acc = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_acc_hi),
> +                           Q6_L_tmp_mem_A(pw_acc_lo));
> +    src = Q6_LW_combine_LL(Q6_L_tmp_mem_A(pw_src_hi),
> +                           Q6_L_tmp_mem_A(pw_src_lo));
> +    result = Q6_LWw_shracc_LWwRh(acc, src, scalar);
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_lo, Q6_L_lo_LW(result));
> +    Q6_mem_Ku16_new_AL((uint16_t *)pw_out_hi, Q6_L_hi_LW(result));
> +
> +    exp = 0x1234c350;
> +    for (int j = 0; j < HLX_HALF_ELEMS; j++) {
> +        expected_w[j] = exp;
> +    }
> +    check_wp("LX_shrar_w_w", pw_out_lo, pw_out_hi, expected_w, HLX_HALF_ELEMS);
> +}
> +
> +int main(void)
> +{
> +    init_vtcm();
> +    enable_hlx();
> +
> +    buf_src = vtcm_alloc(HLX_HALF_ELEMS * sizeof(uint16_t));
> +    buf_shamt = vtcm_alloc(HLX_HALF_ELEMS * sizeof(uint16_t));
> +    buf_acc = vtcm_alloc(HLX_HALF_ELEMS * sizeof(uint16_t));
> +    buf_out = vtcm_alloc(HLX_HALF_ELEMS * sizeof(uint16_t));
> +    pw_src_lo = vtcm_alloc(HLX_WORD_ELEMS * sizeof(uint32_t));
> +    pw_src_hi = vtcm_alloc(HLX_WORD_ELEMS * sizeof(uint32_t));
> +    pw_acc_lo = vtcm_alloc(HLX_WORD_ELEMS * sizeof(uint32_t));
> +    pw_acc_hi = vtcm_alloc(HLX_WORD_ELEMS * sizeof(uint32_t));
> +    pw_out_lo = vtcm_alloc(HLX_WORD_ELEMS * sizeof(uint32_t));
> +    pw_out_hi = vtcm_alloc(HLX_WORD_ELEMS * sizeof(uint32_t));
> +    init_hlx_vsp();
> +
> +    /* Halfword shift-accumulate */
> +    test_shra_h_uh();
> +    test_shrar_h_uh();
> +    test_shra_h_h();
> +    test_shrar_h_h();
> +
> +    /* Word shift-accumulate */
> +    test_shra_w_uw();
> +    test_shrar_w_uw();
> +    test_shra_w_w();
> +    test_shrar_w_w();
> +
> +    puts(err ? "FAIL" : "PASS");
> +    return err;
> +}
> diff --git a/tests/tcg/hexagon/hlx_test.h b/tests/tcg/hexagon/hlx_test.h
> new file mode 100644
> index 0000000000..b3c36d3853
> --- /dev/null
> +++ b/tests/tcg/hexagon/hlx_test.h
> @@ -0,0 +1,162 @@
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +/* .word encodings let these tests build without HLX assembler support. */
> +
> +#ifndef HLX_TEST_H
> +#define HLX_TEST_H
> +
> +#include <stdbool.h>
> +#include <stdint.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +
> +#include "hlx_asm.h"
> +
> +static int err;
> +
> +static inline void check_h(const char *name, const uint16_t *out,
> +                     const uint16_t *expected, int count)
> +{
> +    for (int i = 0; i < count; i++) {
> +        if (out[i] != expected[i]) {
> +            printf("FAIL %s [%d]: expected 0x%04x, got 0x%04x\n",
> +                   name, i, expected[i], out[i]);
> +            err++;
> +            if (err > 20) {
> +                printf("Too many errors, stopping %s\n", name);
> +                return;
> +            }
> +        }
> +    }
> +}
> +
> +static inline void check_w(const char *name, const uint32_t *out,
> +                     const uint32_t *expected, int count)
> +{
> +    for (int i = 0; i < count; i++) {
> +        if (out[i] != expected[i]) {
> +            printf("FAIL %s [%d]: expected 0x%08lx, got 0x%08lx\n",
> +                   name, i, (unsigned long)expected[i],
> +                   (unsigned long)out[i]);
> +            err++;
> +            if (err > 20) {
> +                printf("Too many errors, stopping %s\n", name);
> +                return;
> +            }
> +        }
> +    }
> +}
> +
> +/* Reconstruct word-pair values from interleaved L-register buffers. */
> +static inline void check_wp(const char *name, const uint32_t *out_lo,
> +                      const uint32_t *out_hi, const uint32_t *expected,
> +                      int count)
> +{
> +    const uint16_t *lo = (const uint16_t *)out_lo;
> +    const uint16_t *hi = (const uint16_t *)out_hi;
> +    for (int i = 0; i < count; i++) {
> +        uint32_t got = ((uint32_t)hi[i] << 16) | lo[i];
> +        if (got != expected[i]) {
> +            printf("FAIL %s [%d]: expected 0x%08lx, got 0x%08lx\n",
> +                   name, i, (unsigned long)expected[i],
> +                   (unsigned long)got);
> +            err++;
> +            if (err > 20) {
> +                printf("Too many errors, stopping %s\n", name);
> +                return;
> +            }
> +        }
> +    }
> +}
> +
> +static inline int16_t sat_h(int32_t val)
> +{
> +    if (val > 32767) {
> +        return 32767;
> +    }
> +    if (val < -32768) {
> +        return -32768;
> +    }
> +    return (int16_t)val;
> +}
> +
> +static inline uint16_t sat_uh(int32_t val)
> +{
> +    if (val > 65535) {
> +        return 65535;
> +    }
> +    if (val < 0) {
> +        return 0;
> +    }
> +    return (uint16_t)val;
> +}
> +
> +static inline int32_t sat_w(int64_t val)
> +{
> +    if (val > 2147483647LL) {
> +        return 2147483647;
> +    }
> +    if (val < -2147483648LL) {
> +        return -2147483648;
> +    }
> +    return (int32_t)val;
> +}
> +
> +static inline uint32_t sat_uw(int64_t val)
> +{
> +    if (val > 4294967295LL) {
> +        return 4294967295U;
> +    }
> +    if (val < 0) {
> +        return 0;
> +    }
> +    return (uint32_t)val;
> +}
> +
> +/* HLX registers and their load/store buffers are 2048-byte aligned. */
> +#define HLX_HALF_ELEMS  1024
> +#define HLX_WORD_ELEMS  512
> +#define HLX_VEC_BYTES   2048
> +#define HLX_ALIGN       __attribute__((aligned(2048)))
> +
> +/* Linux user mode uses aligned heap buffers and enables HLX. */
> +
> +/* Linux does not need VTCM setup. */
> +static inline void init_vtcm(void) { }
> +
> +/* Linux already enables HLX. */
> +static inline void enable_hlx(void) { }
> +
> +/* Allocate a 2KB-aligned heap buffer. */
> +static inline void *vtcm_alloc(size_t bytes)
> +{
> +    size_t aligned_bytes = (bytes + (HLX_VEC_BYTES - 1))
> +                           & ~(size_t)(HLX_VEC_BYTES - 1);
> +    void *ptr = aligned_alloc(HLX_VEC_BYTES, aligned_bytes);
> +    if (!ptr) {
> +        fprintf(stderr, "aligned_alloc failed for %zu bytes\n",
> +                aligned_bytes);
> +        exit(1);
> +    }
> +    memset(ptr, 0, aligned_bytes);
> +    return ptr;
> +}
> +
> +/* Set VSP to the end of an aligned L-register spill area. */
> +#define HLX_VSP_SIZE  (16 * HLX_VEC_BYTES) /* 32 KB for spill slots */
> +
> +static inline void init_hlx_vsp(void)
> +{
> +    void *vsp_area = vtcm_alloc(HLX_VSP_SIZE);
> +    /* VSP grows downward. */
> +    uint32_t vsp_top = (uint32_t)(uintptr_t)vsp_area + HLX_VSP_SIZE;
> +    asm volatile("r0 = %[top]\n"
> +                 ".word 0x6220c01d\n" /* vsp = r0 */
> +                 : : [top] "r"(vsp_top) : "r0");
> +}
> +
> +#endif /* HLX_TEST_H */
> diff --git a/tests/tcg/hexagon/meson.build b/tests/tcg/hexagon/meson.build
> index 2b92459864..ccaf624cb6 100644
> --- a/tests/tcg/hexagon/meson.build
> +++ b/tests/tcg/hexagon/meson.build
> @@ -58,6 +58,22 @@ tests += {
>                  'qemu_args': ['-cpu', 'v81']},
>     'qfloat_v81.c': {'cflags': [cflags, '-mv81', '-mhvx', '-mhvx-ieee-fp'],
>                      'qemu_args': ['-cpu', 'v81']},
> +  # HLX instructions use .word encodings.
> +  'hlx_abs_cmp.c': {'cflags': cflags, 'qemu_args': ['-cpu', 'v85']},
> +  'hlx_arith_h.c': {'cflags': cflags, 'qemu_args': ['-cpu', 'v85']},
> +  'hlx_arith_w.c': {'cflags': cflags, 'qemu_args': ['-cpu', 'v85']},
> +  'hlx_assign_conv.c': {'cflags': cflags, 'qemu_args': ['-cpu', 'v85']},
> +  'hlx_basic.c': {'cflags': cflags, 'qemu_args': ['-cpu', 'v85']},
> +  'hlx_lanes.c': {'cflags': cflags, 'qemu_args': ['-cpu', 'v85']},
> +  'hlx_logical.c': {'cflags': cflags, 'qemu_args': ['-cpu', 'v85']},
> +  'hlx_lut_ilog2.c': {'cflags': cflags, 'qemu_args': ['-cpu', 'v85']},
> +  'hlx_mem.c': {'cflags': cflags, 'qemu_args': ['-cpu', 'v85']},
> +  'hlx_minmax_avg.c': {'cflags': cflags, 'qemu_args': ['-cpu', 'v85']},
> +  'hlx_mpy.c': {'cflags': cflags, 'qemu_args': ['-cpu', 'v85']},
> +  'hlx_mpy_adv.c': {'cflags': cflags, 'qemu_args': ['-cpu', 'v85']},
> +  'hlx_reg_writes.c': {'cflags': cflags, 'qemu_args': ['-cpu', 'v85']},
> +  'hlx_shift.c': {'cflags': cflags, 'qemu_args': ['-cpu', 'v85']},
> +  'hlx_shift_acc.c': {'cflags': cflags, 'qemu_args': ['-cpu', 'v85']},
>     # Run the QFloat test below and above the v79 extended-QFloat boundary.
>     'hvx_ext.c': {
>       'cflags': [cflags, '-mv79', '-mhvx', '-mhvx-ieee-fp'],

