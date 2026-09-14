Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B203C88E7B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 21:22:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6E7i-0003kt-4r; Mon, 14 Sep 2026 17:21:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6E75-00034u-3r
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 17:21:21 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6E70-0003AJ-AG
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 17:21:18 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EJYSY11702504
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 21:21:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vCVGtT4p4sixepfwjGMqn5yNIzRmom3/Jo6hHma0RI0=; b=K8ScYmE8aaxNcQ3j
 RovCcxFl8duXi35GIX6lVB5eHG9QKX+yDLmvFhDBYzvW7nfGfVVp9O4aGwsaN/cm
 HtjmwfXVpGdQhdK+Ws42zJqMBAFYDMsxAfeUvameB5NXHgjFy4sP3WExfFh3U3eD
 1t6E+jZ8+XWswacQ+9jMGW6XlLJ+NXAs8ImPs1yMfLs3TbFGEkXhffidrRMso7i0
 f3R4fngqfZZSYXPuZrfg2xqjzyCbr4LBS8JiaEERwp3PV1EP0MsGNovv4p5qePdF
 Sy4D0wOiGCaJCk2TQAWkYdqDY3ocE+aQt4V4aXBZBnqhdeaGnCQogQ0dfbt0zfi5
 ElKVlg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpmx9rwxj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 21:21:12 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2dd53f2b27cso24641065ad.0
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 14:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789420871; x=1790025671; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=vCVGtT4p4sixepfwjGMqn5yNIzRmom3/Jo6hHma0RI0=;
 b=cCVrAnrUG2TGQInAILOv1maMqohd3110wewWY2nksYl3gKG40ohTrBKj/3ILTNDunI
 RkJqjEfDEJqOo3NLWizq04QOTflj4CKQXXuOtPck11loGjdCz1W/hFNmN+5ioX48pXoB
 jS9MIfjEs68IJrMZY5P0pesVjOI9/SLsQE9PNwEg7xLXesjKGDxLrAxaFPv0xQXqJ+yb
 qPo7XgSoqwX7CA/JzIaVhP3BhjNu/wgiOWRf/jUDaNbq1wOe1fzOqKmbkEDnqHPSzHmt
 npL+gd9hfpL2WNC+J8KDfPZ1pYmq7IDm+BfqmMqxLW+yLhF52CQfMpG48rPVHxjJjDam
 WDUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789420871; x=1790025671;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vCVGtT4p4sixepfwjGMqn5yNIzRmom3/Jo6hHma0RI0=;
 b=mNYZzt34jovbJgLbzSfFpbpcxe3xDaWTYMD/Mvh6tqEKkUwtcUP42Z4HWzbGYgqSUn
 tyrkZ7nEuZx5Wv/VNBsBD62Dn1w8lq7KJoKnvby+frmkgJHqeElni+y+Cst47kX+DPmg
 BY18X7eikplX1EahcuClhMvLBj0VVO43CkD7peWmFiqnhKxm0DG93evkOs41f7iyJH09
 eOEt3Oyn/v2loHammcU0B33qNtcVcu8BSDvaBKiWGw1Ui/0cASZANEVlPUf5V1ZPDg7t
 5VAJPT8iqDf1709MkqDZryjDISVmxh7gJupBV4eMgWsTw+14+CH9g7MgqtU8UOywWLuI
 +YZg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwky946D/o1V/rGsSSWQFMSzouV96goRAoBGwhHhvHpsEydEbPQYP0q62EScnB3urCTxTNEyPeoaHEY@nongnu.org
X-Gm-Message-State: AFuF++lwJu6mxVqQGFdEMLKj1q5MoDQ0gwqShPi0Qp9DH1MZmdYG/93Q
 9km1cKhe1Mnj1uy5Zg6vVgKYUlR76bKPKvF7pMlx2OW1gZ3E0A82LAPWV2m2M3rUS8zTUvPZpEk
 QRoYQw0iObVpA8Zq+oUf2ufX5rMvkGmVnEq5HTQTiCbL8p0O1Q1Cwqg9xChvWC+nRIA==
X-Gm-Gg: AYBFou1htnNHSo5bsS4AJeQt9niQ7zgNdVyHAUllaXIHgFkTOpQH6sFIa0Twa75nzkZ
 9Qan7NmnyngyMHOUXnQrDNY7Q5BA/rNmOGjPV5IOdqQDwKTxi3RIR5Qu5CyY15zxF97QVk9Nvul
 oMO119AUC6yDVhN+H1aRH14tYuMEjUMO2+zgB4rtVhUxncWOxvsXM8GYTWUZi+TbjbHUKy+bxX0
 QTAx3kCSJCisQ9cyGF7O73F8azedGisBBcis57wWl8KGdGshcjm3KB/FUGut2BTQ789/mbhDsrD
 4u8vOpKfjJefvVoiCR8BS6m7WbDuUTYkXr9eSWJ6WnvZsKAXJZAfPF7J2M4p2RthCwEjQ7YhplU
 WUKQo3JQjojSPPeF1q3M/6H19z3clpnuRbD7FgNpqY3ti40tvdBGtnnH29AhBe7jL61dS
X-Received: by 2002:a17:902:f68f:b0:2c0:a555:80d6 with SMTP id
 d9443c01a7336-2dd6c5c19d3mr83425385ad.2.1789420870995; 
 Mon, 14 Sep 2026 14:21:10 -0700 (PDT)
X-Received: by 2002:a17:902:f68f:b0:2c0:a555:80d6 with SMTP id
 d9443c01a7336-2dd6c5c19d3mr83424665ad.2.1789420870238; 
 Mon, 14 Sep 2026 14:21:10 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33be76d0988sm316188eec.8.2026.09.14.14.21.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2026 14:21:09 -0700 (PDT)
Message-ID: <92ff5291-7e27-4e2c-af01-09744c97dfe1@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 14:21:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/17] tests/tcg/hexagon: add HVX vwhist tests
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 sid.manning@oss.qualcomm.com
References: <20260905180949.1852673-1-brian.cain@oss.qualcomm.com>
 <20260905180949.1852673-11-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260905180949.1852673-11-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=G+KJgNk5 c=1 sm=1 tr=0 ts=6aa86548 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=thfcjYoyEOBvKXdW8-EA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDMwNSBTYWx0ZWRfX1Qus/dGhnaLq
 Vl0uji+B3Le0nr82FgKYQDD/c08xtTCNz3YmbXs5fEwVdo4lHDESQr5AqWfGvvtYABMEFr+mUdk
 Z4RfzyO7d593WG0wHKPEho8/6pvdKmdu3PihimGpl1Ab0xrG+jUcC6i+EnskUjRO8cJe1cHREU5
 3t3/IGVybfwUJBkZxkaR2ZfoFmOAYjYXlPWDSyu/z31wAdV/4usHHISddc2gURXhCRvBzqhI1qx
 SaDULHSj2MafXkRHI7TtynXaxei+x3cUOgRGPsrFtGhFH61S5d2MLzXBZNKSai4ugFvHhtCO1I3
 gFum/s+qV2+y/Tq4yoLAJGdIbYcqxv7OVmyDTaeOS4SaBJbfWxRuFhOqENbhyDsZDgLYo7w7J7L
 jATR6BGA+4QS72p+36sNKkqEGWR7L/ne0cAlQBw6twg+GM09IqZHCxEXumVRHgY/2gV3QxcElOi
 IJ8nuYFi12c3MDeepQg==
X-Proofpoint-GUID: qzV9gf__CS4D9saEdiZVoEs4n9WXpTtO
X-Proofpoint-ORIG-GUID: qzV9gf__CS4D9saEdiZVoEs4n9WXpTtO
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDMwNSBTYWx0ZWRfXyWH9Y8mHM0jR
 CsSPKUJH4w0/eZo5kNo+PlRJ45Ygsa1T05M0xlZNUVmpG1Qv11NXTJPDGDKi6VvwbNTHuIX0wUR
 4dpQ58shzYLIEa509v7DhNMNJqO7GmA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_04,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 adultscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140305
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 9/5/2026 11:09 AM, Brian Cain wrote:
> Test all eight vwhist instruction variants and the four Q-masked forms.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  tests/tcg/hexagon/test_vwhist.c | 361 ++++++++++++++++++++++++++++++++
>  tests/tcg/hexagon/meson.build   |   1 +
>  2 files changed, 362 insertions(+)
>  create mode 100644 tests/tcg/hexagon/test_vwhist.c
> 
> diff --git a/tests/tcg/hexagon/test_vwhist.c b/tests/tcg/hexagon/test_vwhist.c
> new file mode 100644
> index 00000000000..5e143f79a43
> --- /dev/null
> +++ b/tests/tcg/hexagon/test_vwhist.c
> @@ -0,0 +1,361 @@
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +/*
> + * Test HVX weighted histogram instructions (vwhist128/vwhist256 variants).
> + *
> + * Each halfword in the input vector (loaded via Vx.tmp) contains a bucket
> + * index (low byte) and a weight (high byte).  The instruction accumulates
> + * the weight into the appropriate element of the destination vector.
> + */
> +
> +#include <stdio.h>
> +#include <stdint.h>
> +#include <string.h>
> +
> +int err;
> +
> +#define MAX_VEC_SIZE_BYTES  128
> +
> +typedef union {
> +    uint32_t uw[MAX_VEC_SIZE_BYTES / 4];
> +    uint16_t uh[MAX_VEC_SIZE_BYTES / 2];
> +    uint8_t  ub[MAX_VEC_SIZE_BYTES];
> +} MMVector;
> +
> +/*
> + * Build input vector for vwhist256: each halfword is (weight << 8 | bucket).
> + * We put bucket=0, weight=1 in every slot so that v0.uh[0] gets incremented
> + * by 1 for each of the 64 halfwords -> v0.uh[0] should equal 64.
> + */
> +static MMVector input __attribute__((aligned(MAX_VEC_SIZE_BYTES)));
> +static MMVector zero_vec __attribute__((aligned(MAX_VEC_SIZE_BYTES)));
> +static MMVector result __attribute__((aligned(MAX_VEC_SIZE_BYTES)));
> +
> +static void check_uint32(int line, int idx, uint32_t val, uint32_t expect)
> +{
> +    if (val != expect) {
> +        printf("ERROR at line %d: [%d] 0x%08x != 0x%08x\n",
> +               line, idx, val, expect);
> +        err++;
> +    }
> +}
> +
> +static void check_uint16(int line, int idx, uint16_t val, uint16_t expect)
> +{
> +    if (val != expect) {
> +        printf("ERROR at line %d: [%d] 0x%04x != 0x%04x\n",
> +               line, idx, val, expect);
> +        err++;
> +    }
> +}
> +

Seems like duplication of check* in hex_test.h.
check16 needs to be added there.

> +/*
> + * Test vwhist256: 256-bin histogram with 16-bit accumulation.
> + * Each halfword of the input: low byte = bucket, high byte = weight.
> + * bucket bits [7:3] -> vindex (which vector register), [2:0] + lane -> element.
> + * All entries have bucket=0 weight=1, so v0.uh[0..7] get incremented.
> + */
> +static void test_vwhist256(void)
> +{
> +    int i;
> +
> +    /* Set all input halfwords to bucket=0, weight=1 */
> +    for (i = 0; i < MAX_VEC_SIZE_BYTES / 2; i++) {
> +        input.uh[i] = 0x0100;  /* weight=1, bucket=0 */
> +    }
> +
> +    asm volatile(
> +        /* Zero out v0 (the target for bucket 0) */
> +        "v0 = vmem(%[zero] + #0)\n\t"
> +        "{\n\t"
> +        "    v12.tmp = vmem(%[inp] + #0)\n\t"
> +        "    vwhist256\n\t"
> +        "}\n\t"
> +        "vmem(%[out] + #0) = v0\n\t"
> +        :
> +        : [inp] "r"(&input), [zero] "r"(&zero_vec),
> +          [out] "r"(&result)
> +        : "v0", "v12", "memory");
> +
> +    /*
> +     * 64 input halfwords all targeting bucket 0.
> +     * elindex = (i & ~7) | (bucket & 7) = i & ~7  (since bucket=0).
> +     * So elements 0,8,16,24,32,40,48,56 each get 8 increments.
> +     */
> +    for (i = 0; i < 64; i++) {
> +        uint16_t expected = ((i & 7) == 0) ? 8 : 0;
> +        check_uint16(__LINE__, i, result.uh[i], expected);
> +    }
> +}
> +
> +/*
> + * Test vwhist256:sat -- saturating variant.
> + * Use weight=0xFF to test that saturation to 0xFFFF works.
> + */
> +static void test_vwhist256_sat(void)
> +{
> +    int i;
> +
> +    for (i = 0; i < MAX_VEC_SIZE_BYTES / 2; i++) {
> +        input.uh[i] = 0xFF00;  /* weight=0xFF, bucket=0 */
> +    }
> +
> +    asm volatile(
> +        "v0 = vmem(%[zero] + #0)\n\t"
> +        "{\n\t"
> +        "    v12.tmp = vmem(%[inp] + #0)\n\t"
> +        "    vwhist256:sat\n\t"
> +        "}\n\t"
> +        "vmem(%[out] + #0) = v0\n\t"
> +        :
> +        : [inp] "r"(&input), [zero] "r"(&zero_vec),
> +          [out] "r"(&result)
> +        : "v0", "v12", "memory");
> +
> +    /*
> +     * Same distribution as vwhist256: elements 0,8,16,...,56.
> +     * Each gets 8 * 0xFF = 2040 = 0x7F8 (within uint16 range).
> +     */
> +    for (i = 0; i < 64; i++) {
> +        uint16_t expected = ((i & 7) == 0) ? 8 * 0xFF : 0;
> +        check_uint16(__LINE__, i, result.uh[i], expected);
> +    }
> +}
> +
> +/*
> + * Test vwhist128: 128-bin histogram with 32-bit accumulation.
> + * bucket bits [7:3] -> vindex, [2:1] + lane -> element (word granularity).
> + */
> +static void test_vwhist128(void)
> +{
> +    int i;
> +
> +    for (i = 0; i < MAX_VEC_SIZE_BYTES / 2; i++) {
> +        input.uh[i] = 0x0100;  /* weight=1, bucket=0 */
> +    }
> +
> +    asm volatile(
> +        "v0 = vmem(%[zero] + #0)\n\t"
> +        "{\n\t"
> +        "    v12.tmp = vmem(%[inp] + #0)\n\t"
> +        "    vwhist128\n\t"
> +        "}\n\t"
> +        "vmem(%[out] + #0) = v0\n\t"
> +        :
> +        : [inp] "r"(&input), [zero] "r"(&zero_vec),
> +          [out] "r"(&result)
> +        : "v0", "v12", "memory");
> +
> +    /*
> +     * 128-bin: 64 halfwords all targeting bucket 0.
> +     * bucket 0 -> vindex=0, elindex based on (i>>1)&(~3) | (bucket>>1)&3.
> +     * With bucket=0, elindex = (i>>1)&(~3).
> +     * For i=0,1: elindex=0; i=2,3: elindex=0; ... up to i=6,7: elindex=0
> +     * i ranges 0..63. (i>>1) ranges 0..31.
> +     * (i>>1)&(~3) = 0,0,0,0,4,4,4,4,8,...
> +     * So elements 0,4,8,12,16,20,24,28 each get 8 increments.
> +     */
> +    for (i = 0; i < 32; i++) {
> +        uint32_t expected = ((i & 3) == 0) ? 8 : 0;
> +        check_uint32(__LINE__, i, result.uw[i], expected);
> +    }
> +}
> +
> +/*
> + * Test vwhist128(#0) -- masked variant.
> + * Only processes elements where (bucket & 1) == mode.
> + */
> +static void test_vwhist128m(void)
> +{
> +    int i;
> +
> +    /* All bucket=0, weight=1.  bucket&1==0, so mode=0 matches all. */
> +    for (i = 0; i < MAX_VEC_SIZE_BYTES / 2; i++) {
> +        input.uh[i] = 0x0100;  /* weight=1, bucket=0 */
> +    }
> +
> +    asm volatile(
> +        "v0 = vmem(%[zero] + #0)\n\t"
> +        "{\n\t"
> +        "    v12.tmp = vmem(%[inp] + #0)\n\t"
> +        "    vwhist128(#0)\n\t"
> +        "}\n\t"
> +        "vmem(%[out] + #0) = v0\n\t"
> +        :
> +        : [inp] "r"(&input), [zero] "r"(&zero_vec),
> +          [out] "r"(&result)
> +        : "v0", "v12", "memory");
> +
> +    /* Same distribution as vwhist128 since all buckets have bit0=0 */
> +    for (i = 0; i < 32; i++) {
> +        uint32_t expected = ((i & 3) == 0) ? 8 : 0;
> +        check_uint32(__LINE__, i, result.uw[i], expected);
> +    }
> +
> +    /* Now test with mode=1: bucket=0 has bit0=0, so nothing should match */
> +    memset(&result, 0, sizeof(result));
> +    asm volatile(
> +        "v0 = vmem(%[zero] + #0)\n\t"
> +        "{\n\t"
> +        "    v12.tmp = vmem(%[inp] + #0)\n\t"
> +        "    vwhist128(#1)\n\t"
> +        "}\n\t"
> +        "vmem(%[out] + #0) = v0\n\t"
> +        :
> +        : [inp] "r"(&input), [zero] "r"(&zero_vec),
> +          [out] "r"(&result)
> +        : "v0", "v12", "memory");
> +
> +    for (i = 0; i < 32; i++) {
> +        check_uint32(__LINE__, i, result.uw[i], 0);
> +    }
> +}
> +
> +static MMVector ones_vec __attribute__((aligned(MAX_VEC_SIZE_BYTES)));
> +
> +/*
> + * Test vwhist256(Qv4) -- Q-masked vwhist256.
> + * Set Q0 to all-ones so all elements pass the mask -> same as vwhist256.
> + */
> +static void test_vwhist256q(void)
> +{
> +    int i;
> +
> +    for (i = 0; i < MAX_VEC_SIZE_BYTES / 2; i++) {
> +        input.uh[i] = 0x0100;  /* weight=1, bucket=0 */
> +    }
> +
> +    asm volatile(
> +        "v0 = vmem(%[zero] + #0)\n\t"
> +        "v1 = vmem(%[ones] + #0)\n\t"
> +        "q0 = vcmp.eq(v1.b, v1.b)\n\t"  /* all-ones Q0 */
> +        "{\n\t"
> +        "    v12.tmp = vmem(%[inp] + #0)\n\t"
> +        "    vwhist256(q0)\n\t"
> +        "}\n\t"
> +        "vmem(%[out] + #0) = v0\n\t"
> +        :
> +        : [inp] "r"(&input), [zero] "r"(&zero_vec),
> +          [out] "r"(&result), [ones] "r"(&ones_vec)
> +        : "v0", "v1", "v12", "q0", "memory");
> +
> +    for (i = 0; i < 64; i++) {
> +        uint16_t expected = ((i & 7) == 0) ? 8 : 0;
> +        check_uint16(__LINE__, i, result.uh[i], expected);
> +    }
> +}
> +
> +/*
> + * Test vwhist256(Qv4):sat -- Q-masked saturating vwhist256.
> + */
> +static void test_vwhist256q_sat(void)
> +{
> +    int i;
> +
> +    for (i = 0; i < MAX_VEC_SIZE_BYTES / 2; i++) {
> +        input.uh[i] = 0xFF00;  /* weight=0xFF, bucket=0 */
> +    }
> +
> +    asm volatile(
> +        "v0 = vmem(%[zero] + #0)\n\t"
> +        "v1 = vmem(%[ones] + #0)\n\t"
> +        "q0 = vcmp.eq(v1.b, v1.b)\n\t"
> +        "{\n\t"
> +        "    v12.tmp = vmem(%[inp] + #0)\n\t"
> +        "    vwhist256(q0):sat\n\t"
> +        "}\n\t"
> +        "vmem(%[out] + #0) = v0\n\t"
> +        :
> +        : [inp] "r"(&input), [zero] "r"(&zero_vec),
> +          [out] "r"(&result), [ones] "r"(&ones_vec)
> +        : "v0", "v1", "v12", "q0", "memory");
> +
> +    for (i = 0; i < 64; i++) {
> +        uint16_t expected = ((i & 7) == 0) ? 8 * 0xFF : 0;
> +        check_uint16(__LINE__, i, result.uh[i], expected);
> +    }
> +}
> +
> +/*
> + * Test vwhist128(Qv4) -- Q-masked vwhist128.
> + */
> +static void test_vwhist128q(void)
> +{
> +    int i;
> +
> +    for (i = 0; i < MAX_VEC_SIZE_BYTES / 2; i++) {
> +        input.uh[i] = 0x0100;  /* weight=1, bucket=0 */
> +    }
> +
> +    asm volatile(
> +        "v0 = vmem(%[zero] + #0)\n\t"
> +        "v1 = vmem(%[ones] + #0)\n\t"
> +        "q0 = vcmp.eq(v1.b, v1.b)\n\t"
> +        "{\n\t"
> +        "    v12.tmp = vmem(%[inp] + #0)\n\t"
> +        "    vwhist128(q0)\n\t"
> +        "}\n\t"
> +        "vmem(%[out] + #0) = v0\n\t"
> +        :
> +        : [inp] "r"(&input), [zero] "r"(&zero_vec),
> +          [out] "r"(&result), [ones] "r"(&ones_vec)
> +        : "v0", "v1", "v12", "q0", "memory");
> +
> +    for (i = 0; i < 32; i++) {
> +        uint32_t expected = ((i & 3) == 0) ? 8 : 0;
> +        check_uint32(__LINE__, i, result.uw[i], expected);
> +    }
> +}
> +
> +/*
> + * Test vwhist128(Qv4,#0) -- Q-masked mode vwhist128.
> + */
> +static void test_vwhist128qm(void)
> +{
> +    int i;
> +
> +    for (i = 0; i < MAX_VEC_SIZE_BYTES / 2; i++) {
> +        input.uh[i] = 0x0100;  /* weight=1, bucket=0 */
> +    }
> +
> +    asm volatile(
> +        "v0 = vmem(%[zero] + #0)\n\t"
> +        "v1 = vmem(%[ones] + #0)\n\t"
> +        "q0 = vcmp.eq(v1.b, v1.b)\n\t"
> +        "{\n\t"
> +        "    v12.tmp = vmem(%[inp] + #0)\n\t"
> +        "    vwhist128(q0,#0)\n\t"
> +        "}\n\t"
> +        "vmem(%[out] + #0) = v0\n\t"
> +        :
> +        : [inp] "r"(&input), [zero] "r"(&zero_vec),
> +          [out] "r"(&result), [ones] "r"(&ones_vec)
> +        : "v0", "v1", "v12", "q0", "memory");
> +
> +    /* bucket=0, bit0=0, mode=0 matches -> same as vwhist128 */
> +    for (i = 0; i < 32; i++) {
> +        uint32_t expected = ((i & 3) == 0) ? 8 : 0;
> +        check_uint32(__LINE__, i, result.uw[i], expected);
> +    }
> +}
> +
> +int main(void)
> +{
> +    memset(&zero_vec, 0, sizeof(zero_vec));
> +    memset(&ones_vec, 0xff, sizeof(ones_vec));
> +
> +    test_vwhist256();
> +    test_vwhist256_sat();
> +    test_vwhist128();
> +    test_vwhist128m();
> +    test_vwhist256q();
> +    test_vwhist256q_sat();
> +    test_vwhist128q();
> +    test_vwhist128qm();
> +
> +    puts(err ? "FAIL" : "PASS");
> +    return err ? 1 : 0;
> +}
> diff --git a/tests/tcg/hexagon/meson.build b/tests/tcg/hexagon/meson.build
> index fcf0bd38f26..4c70875034d 100644
> --- a/tests/tcg/hexagon/meson.build
> +++ b/tests/tcg/hexagon/meson.build
> @@ -94,6 +94,7 @@ tests += {
>    'test_vminh.S': {'cflags': asmflags},
>    'test_vpmpyh.S': {'cflags': asmflags},
>    'test_vspliceb.S': {'cflags': asmflags},
> +  'test_vwhist.c': {'cflags': [cflags, '-mhvx']},
>    'unaligned_pc.c': {'cflags': cflags},
>    'unaligned_data.c': {'cflags': cflags},
>    'usr.c': {


