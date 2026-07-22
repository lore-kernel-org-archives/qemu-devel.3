Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF738C4453A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 20:17:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmdNI-0003vw-IO; Wed, 22 Jul 2026 16:17:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wmdNG-0003vI-AF
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 16:17:02 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wmdND-00039p-NX
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 16:17:02 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66MHqmY81054052
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 20:16:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yIRWZ6106kn+OZ3ttXKrJvJwkCUWLuvtIglE8CAYVuE=; b=ors/zyfNq15TOD37
 WRnlJmyCRisAhSuZNyPKXsl9c1EJ60HY8sStXNcCBCpIvvCekyHSNSqE2gGH3nn3
 8933U6mvsQG2jRSpwMjjo34eOAhqlViMyH6hzA2Qhg5NHz1nvYLFh4LoK7oU1Tdi
 jBtteBv3905khjGQ5jOHhOkSYzH3kWP6SgQTXpaqX4tX1zB/Hoi0soVerVrCAwYz
 6Uy3alqP+RtpKpFjVfY/oJOpdspMpiLcJ8rOhATsHevYHszVENDv59mZ9/G1Jn3r
 Y73qKPiylhPMjQhpXBGfiU4mv2J8xYFOdaLotoF73zlbRiaRloJqZ9oxb7ExjVrJ
 7LyclQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjxmghsd6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 20:16:57 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8f0f45415cfso219501406d6.2
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 13:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784751416; x=1785356216; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=yIRWZ6106kn+OZ3ttXKrJvJwkCUWLuvtIglE8CAYVuE=;
 b=DkotghTUdanJ2vBmiFtWhQAmnp5h+yiB1iuXVNcPJ0m/guQIRPuzE0AVgFeoLMzL2A
 FXZyMI1kFGNIZJI4EteS0WVe757Iud0r4As2zHA08K42d3TqU6ZVUlfXDI6LmzBFLsr0
 bdZhDsRBSBzr1L6W+Vq9C7BVD0767PAGO+rGPA258s2XwEmA3nfHCbkzpcheBS3vHcBJ
 D+T0iNVdWaApz1XY5XSzlrS+rNJQIzkwYxDqd9bOMy7frruDyXYpt4j3R6k8ZS5L7W7D
 jst1h0WFyD5KbXbEck4l1smxrWSfGVj+bBYclBoyigoqi1xowH3AYDCLmv4yKouTOxbR
 9AjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784751416; x=1785356216;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yIRWZ6106kn+OZ3ttXKrJvJwkCUWLuvtIglE8CAYVuE=;
 b=T6noJjnDFaFemmXhkO9cNgjII9+6kLqgnv8x24aAXdw8zVqSOnObijOgngD0Yeep3Z
 3Ub1xbZncON7VnAc7LCfpFEFk4qbnxUk8WnJm2Zf5X04UuqmEwV+m/LcWxaEYqnpyUaK
 eW1p2qzRCdF1y+Q2uFeMINRT+ShNbacbYiWyhTV/AWISB22MGB+07Gs3XPG0Trs2OwOZ
 Ds37KRtNFbZvK8lsMyKQ05tz1/dOtBobGRV1o7DZB019pT1BjKrxDJ3Zzf34djHxsiOO
 F8IEa8Am+FGj1tQImzAV5pMGmiFO3NjeKEmgDE0knODy9aNlBdyNndBhWYecMJ4ttd9+
 TtDQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq3rGM5PEqajU/JXAfe6j+yxMLjXfs3hp/SONCEEPSpnbH+e/L/6N/8/dOpuLs8W4ne+4idelAvNVyl@nongnu.org
X-Gm-Message-State: AOJu0YwYZKwYMqbJmSHzfEhweFTQ7VQAKyD6NFCqtD1uig0KclkkpAel
 ggFOlaD/A6H4lHzq7e2118mkfr9UGOcb+NuGYg6loXHg58xILMGifUCTjLBd9CvLu/g6bbVBors
 6wKQ+2Ke2e/YtaZ5k6/clriki7BuFh20hAhe5kgJMbHcwegbO84oFRJEUdg==
X-Gm-Gg: AR+sD12tlQzUYSa9FIMmflcGuW39qLT2JUqtBPSMlIwX9FrwcSQx52GPj5/33AvqZJI
 wacu+XeN5WDHL5JGmfuF3kWWDFnA3QsXsnr7NY9+hlTOUVa2KZHc11nb6ocUGQNd+8jtkF5tDkc
 9Fn/kbGzhbrw9P4qRfNjKvp3bX/DBvlabCb8DKZS+TjcxcV1pnxPdMV9X1BXseKKfg6iYfe0lLL
 J5eLLamOcYMy7x6wnvkOr9vuC/aXj31hOpg5oiRFoIOKB7s8+Aude6tuBdQDt+g0ki/Izin90t1
 pe00I0y988kZdqPGewOgwL8OQfJjOSrtMPz+m/fq/nyL0JudXROYtUdfmtU+weDK2AFpaw0RXfA
 3Om3TBKvgyJyHiJKHuN9JCDkkGR/u52uCfnLSDA==
X-Received: by 2002:a05:6214:3d11:b0:8ee:b165:5dbf with SMTP id
 6a1803df08f44-907ca28ff6dmr5650696d6.10.1784751415804; 
 Wed, 22 Jul 2026 13:16:55 -0700 (PDT)
X-Received: by 2002:a05:6214:3d11:b0:8ee:b165:5dbf with SMTP id
 6a1803df08f44-907ca28ff6dmr5650036d6.10.1784751415098; 
 Wed, 22 Jul 2026 13:16:55 -0700 (PDT)
Received: from [192.168.68.107] ([152.234.122.204])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-907ba9ddd4bsm28798306d6.26.2026.07.22.13.16.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jul 2026 13:16:54 -0700 (PDT)
Message-ID: <dbbba142-41d0-4a62-ba46-1338591429d7@oss.qualcomm.com>
Date: Wed, 22 Jul 2026 17:16:51 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] tests/qtest: Add K230 DDR controller tests
To: Junze Cao <caojunze424@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, chao.liu@processmission.com,
 pierrick.bouvier@oss.qualcomm.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, farosas@suse.de, lvivier@redhat.com,
 pbonzini@redhat.com
References: <20260716132423.931427-1-caojunze424@gmail.com>
 <20260716132423.931427-4-caojunze424@gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260716132423.931427-4-caojunze424@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=D+V37PRj c=1 sm=1 tr=0 ts=6a612539 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=J0RmenBMOwS19r/fhzI3tQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=wTgq6UDN7QN8hzUyWYkA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: 3M-bQa_om9Fz16DMLN3PZS2ztK4VT_Fe
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDIwMCBTYWx0ZWRfX7/zLFx2AcASX
 BDT2BjwxZG85WYSZSmzB5kENq4BUH8C9+CCc4doOpjGuMDUURUAWnkTBqpzg2LPWSByWMkIM16S
 um4QMUmSoR/LLV1xmSV/Ag4NCi5n234=
X-Proofpoint-ORIG-GUID: 3M-bQa_om9Fz16DMLN3PZS2ztK4VT_Fe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDIwMCBTYWx0ZWRfX2gZZ3ome7WbF
 KiKjn2a3fFo4tptrzvst+E9Qh42mpA2uvqCZG8GXqo4JKF85RYNvUpqcffaPIIlQlnulNypNavz
 H5OXh0dILI1TpJIwW4ZiiB/Sey8OstNTKFgvDtAneMfviJq8+3TwS2+IEwg0oLTFgy4Q/e/SilV
 SbABrEqO9y3kpNPYoucpcWoOPNH1Yk5j5hVaRvvjlV/08QvfNdDZ2Oe+h9IZl/inU99yh3Zw0Dp
 s1EEKr0ptH8He58A2ilxmlybna48hzu6i8AzfBMJcuKnCyktwvUV4IpE0pN0wpC5v2G88VQ+3pc
 QPKOm2mPRyrCAxsqJaNpRK72GewCnoKWKwFgTNn/DaTE6kAzntu5xBejcam6q+uq7bnxw68Vf2I
 JiRfYdP4Ry2dd+l9zLxOiCEtSKZeZXkIas4QRIMu1+QXulqFrtW5wdZ51uFOANcibzDLuj/yE5a
 uwMZ75347kxYgs4Qz1w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_05,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220200
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



On 7/16/2026 10:24 AM, Junze Cao wrote:
> Add qtests for DDRC and PHY reset values, register access policy, the
> software-update handshake, and PHY register ownership.
> 
> Exercise PHY training and mailbox acknowledgement through the DFI
> initialization sequence. Include negative coverage to ensure DFI cannot
> complete before PHY training or enter Normal mode before completion is
> enabled.
> 
> Signed-off-by: Junze Cao <caojunze424@gmail.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   MAINTAINERS                 |   1 +
>   tests/qtest/k230-ddr-test.c | 226 ++++++++++++++++++++++++++++++++++++
>   tests/qtest/meson.build     |   3 +-
>   3 files changed, 229 insertions(+), 1 deletion(-)
>   create mode 100644 tests/qtest/k230-ddr-test.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1cb3ef6c02..ace7def55e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1833,6 +1833,7 @@ F: include/hw/misc/k230_ddr.h
>   F: include/hw/riscv/k230.h
>   F: include/hw/watchdog/k230_wdt.h
>   F: tests/functional/riscv64/test_k230.py
> +F: tests/qtest/k230-ddr-test.c
>   F: tests/qtest/k230-wdt-test.c
>   
>   RX Machines
> diff --git a/tests/qtest/k230-ddr-test.c b/tests/qtest/k230-ddr-test.c
> new file mode 100644
> index 0000000000..72362929bc
> --- /dev/null
> +++ b/tests/qtest/k230-ddr-test.c
> @@ -0,0 +1,226 @@
> +/*
> + * QTest testcase for the K230 DDR controller and PHY
> + *
> + * Exercises register access, reset, PHY ownership, training mailbox, and DFI
> + * initialization.
> + *
> + * Copyright (c) 2026 Junze Cao <caojunze424@gmail.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "libqtest.h"
> +
> +#define K230_DDRC_BASE    UINT64_C(0x98000000)
> +#define K230_DDR_PHY_BASE UINT64_C(0x9a000000)
> +
> +#define K230_DDRC_MSTR    0x000
> +#define K230_DDRC_STAT    0x004
> +#define K230_DDRC_DRAMTMG4 0x110
> +#define K230_DDRC_DFIMISC 0x1b0
> +#define K230_DDRC_DFISTAT 0x1bc
> +#define K230_DDRC_SWCTL   0x320
> +#define K230_DDRC_SWSTAT  0x324
> +
> +#define K230_DDRC_STAT_OPERATING_MODE_MASK          0x7
> +#define K230_DDRC_DFISTAT_DFI_INIT_COMPLETE_MASK    0x1
> +
> +#define K230_DDR_PHY_CSR(index) \
> +    (K230_DDR_PHY_BASE + (uint64_t)(index) * sizeof(uint32_t))
> +
> +#define K230_DDR_PHY_ATX_IMPEDANCE      0x00043
> +#define K230_DDR_PHY_TX_IMPEDANCE_CTRL1 0x10049
> +#define K230_DDR_PHY_VREF_IN_GLOBAL     0x200b2
> +#define K230_DDR_PHY_MICRO_CONT_MUX_SEL 0xd0000
> +#define K230_DDR_PHY_TRAINING_STATUS    0xd0004
> +#define K230_DDR_PHY_TRAINING_ACK       0xd0031
> +#define K230_DDR_PHY_TRAINING_MESSAGE   0xd0032
> +#define K230_DDR_PHY_TRAINING_TRIGGER   0xd0099
> +
> +static void complete_phy_training(QTestState *qts)
> +{
> +    qtest_writel(qts,
> +                 K230_DDR_PHY_CSR(K230_DDR_PHY_MICRO_CONT_MUX_SEL), 1);
> +    qtest_writel(qts, K230_DDR_PHY_CSR(K230_DDR_PHY_TRAINING_TRIGGER), 9);
> +    qtest_writel(qts, K230_DDR_PHY_CSR(K230_DDR_PHY_TRAINING_TRIGGER), 1);
> +    qtest_writel(qts, K230_DDR_PHY_CSR(K230_DDR_PHY_TRAINING_TRIGGER), 0);
> +}
> +
> +static void test_reset_and_register_access(void)
> +{
> +    QTestState *qts = qtest_init("-machine k230");
> +
> +    g_assert_cmphex(qtest_readl(qts, K230_DDRC_BASE + K230_DDRC_MSTR),
> +                    ==, 0x01040000);
> +    g_assert_cmphex(qtest_readl(qts, K230_DDRC_BASE + K230_DDRC_STAT),
> +                    ==, 0x00000000);
> +    g_assert_cmphex(qtest_readl(qts, K230_DDRC_BASE + K230_DDRC_DRAMTMG4),
> +                    ==, 0x05040405);
> +    g_assert_cmphex(qtest_readl(qts, K230_DDRC_BASE + K230_DDRC_DFIMISC),
> +                    ==, 0x00000001);
> +    g_assert_cmphex(qtest_readl(qts, K230_DDRC_BASE + K230_DDRC_SWCTL),
> +                    ==, 0x00000001);
> +    g_assert_cmphex(qtest_readl(qts, K230_DDRC_BASE + K230_DDRC_SWSTAT),
> +                    ==, 0x00000001);
> +
> +    g_assert_cmphex(qtest_readl(qts,
> +                    K230_DDR_PHY_CSR(K230_DDR_PHY_ATX_IMPEDANCE)),
> +                    ==, 0x03ff);
> +    g_assert_cmphex(qtest_readl(qts,
> +                    K230_DDR_PHY_CSR(K230_DDR_PHY_TX_IMPEDANCE_CTRL1)),
> +                    ==, 0x0fff);
> +    g_assert_cmphex(qtest_readl(qts,
> +                    K230_DDR_PHY_CSR(K230_DDR_PHY_VREF_IN_GLOBAL)),
> +                    ==, 0x0200);
> +
> +    qtest_writel(qts, K230_DDRC_BASE + K230_DDRC_MSTR, 0x01040008);
> +    g_assert_cmphex(qtest_readl(qts, K230_DDRC_BASE + K230_DDRC_MSTR),
> +                    ==, 0x01040008);
> +
> +    qtest_writel(qts, K230_DDRC_BASE + K230_DDRC_STAT, 0xffffffff);
> +    g_assert_cmphex(qtest_readl(qts, K230_DDRC_BASE + K230_DDRC_STAT),
> +                    ==, 0x00000000);
> +
> +    qtest_writel(qts, K230_DDR_PHY_CSR(K230_DDR_PHY_VREF_IN_GLOBAL),
> +                 0xffffffff);
> +    g_assert_cmphex(qtest_readl(qts,
> +                    K230_DDR_PHY_CSR(K230_DDR_PHY_VREF_IN_GLOBAL)),
> +                    ==, 0x7fff);
> +
> +    qtest_writel(qts, K230_DDRC_BASE + K230_DDRC_DRAMTMG4, 0);
> +
> +    qtest_system_reset(qts);
> +    g_assert_cmphex(qtest_readl(qts, K230_DDRC_BASE + K230_DDRC_MSTR),
> +                    ==, 0x01040000);
> +    g_assert_cmphex(qtest_readl(qts, K230_DDRC_BASE + K230_DDRC_DRAMTMG4),
> +                    ==, 0x05040405);
> +    g_assert_cmphex(qtest_readl(qts,
> +                    K230_DDR_PHY_CSR(K230_DDR_PHY_VREF_IN_GLOBAL)),
> +                    ==, 0x0200);
> +
> +    qtest_quit(qts);
> +}
> +
> +static void test_software_update_handshake(void)
> +{
> +    QTestState *qts = qtest_init("-machine k230");
> +
> +    qtest_writel(qts, K230_DDRC_BASE + K230_DDRC_SWCTL, 0);
> +    g_assert_cmphex(qtest_readl(qts, K230_DDRC_BASE + K230_DDRC_SWSTAT),
> +                    ==, 0);
> +
> +    qtest_writel(qts, K230_DDRC_BASE + K230_DDRC_SWCTL, 1);
> +    g_assert_cmphex(qtest_readl(qts, K230_DDRC_BASE + K230_DDRC_SWSTAT),
> +                    ==, 1);
> +
> +    qtest_writel(qts, K230_DDRC_BASE + K230_DDRC_SWSTAT, 0);
> +    g_assert_cmphex(qtest_readl(qts, K230_DDRC_BASE + K230_DDRC_SWSTAT),
> +                    ==, 1);
> +
> +    qtest_quit(qts);
> +}
> +
> +static void test_phy_ownership(void)
> +{
> +    QTestState *qts = qtest_init("-machine k230");
> +    uint64_t atx = K230_DDR_PHY_CSR(K230_DDR_PHY_ATX_IMPEDANCE);
> +    uint64_t mux = K230_DDR_PHY_CSR(K230_DDR_PHY_MICRO_CONT_MUX_SEL);
> +
> +    qtest_writel(qts, atx, 0x155);
> +    g_assert_cmphex(qtest_readl(qts, atx), ==, 0x155);
> +
> +    qtest_writel(qts, mux, 1);
> +    qtest_writel(qts, atx, 0x2aa);
> +    g_assert_cmphex(qtest_readl(qts, atx), ==, 0x155);
> +
> +    qtest_writel(qts, mux, 0);
> +    qtest_writel(qts, atx, 0x2aa);
> +    g_assert_cmphex(qtest_readl(qts, atx), ==, 0x2aa);
> +
> +    qtest_quit(qts);
> +}
> +
> +static void test_dfi_prerequisites(void)
> +{
> +    QTestState *qts = qtest_init("-machine k230");
> +
> +    qtest_writel(qts, K230_DDRC_BASE + K230_DDRC_DFIMISC, 0x20);
> +
> +    g_assert_cmphex(qtest_readl(qts,
> +                    K230_DDRC_BASE + K230_DDRC_DFISTAT) &
> +                    K230_DDRC_DFISTAT_DFI_INIT_COMPLETE_MASK,
> +                    ==, 0);
> +    g_assert_cmphex(qtest_readl(qts, K230_DDRC_BASE + K230_DDRC_STAT) &
> +                    K230_DDRC_STAT_OPERATING_MODE_MASK,
> +                    ==, 0);
> +
> +    qtest_quit(qts);
> +}
> +
> +static void test_dfi_complete_enable(void)
> +{
> +    QTestState *qts = qtest_init("-machine k230");
> +
> +    complete_phy_training(qts);
> +    qtest_writel(qts, K230_DDRC_BASE + K230_DDRC_DFIMISC, 0x20);
> +
> +    g_assert_cmphex(qtest_readl(qts,
> +                    K230_DDRC_BASE + K230_DDRC_DFISTAT) &
> +                    K230_DDRC_DFISTAT_DFI_INIT_COMPLETE_MASK,
> +                    ==, 1);
> +    g_assert_cmphex(qtest_readl(qts, K230_DDRC_BASE + K230_DDRC_STAT) &
> +                    K230_DDRC_STAT_OPERATING_MODE_MASK,
> +                    ==, 0);
> +
> +    qtest_quit(qts);
> +}
> +
> +static void test_training_and_dfi_handshake(void)
> +{
> +    QTestState *qts = qtest_init("-machine k230");
> +
> +    complete_phy_training(qts);
> +
> +    g_assert_cmphex(qtest_readl(qts,
> +                    K230_DDR_PHY_CSR(K230_DDR_PHY_TRAINING_STATUS)),
> +                    ==, 0);
> +    g_assert_cmphex(qtest_readl(qts,
> +                    K230_DDR_PHY_CSR(K230_DDR_PHY_TRAINING_MESSAGE)),
> +                    ==, 0x07);
> +
> +    qtest_writel(qts, K230_DDR_PHY_CSR(K230_DDR_PHY_TRAINING_ACK), 0);
> +    g_assert_cmphex(qtest_readl(qts,
> +                    K230_DDR_PHY_CSR(K230_DDR_PHY_TRAINING_STATUS)),
> +                    ==, 1);
> +    qtest_writel(qts, K230_DDR_PHY_CSR(K230_DDR_PHY_TRAINING_ACK), 1);
> +
> +    qtest_writel(qts, K230_DDRC_BASE + K230_DDRC_DFIMISC, 0x20);
> +    g_assert_cmphex(qtest_readl(qts, K230_DDRC_BASE + K230_DDRC_DFISTAT),
> +                    ==, 1);
> +
> +    qtest_writel(qts, K230_DDRC_BASE + K230_DDRC_DFIMISC, 0);
> +    qtest_writel(qts, K230_DDRC_BASE + K230_DDRC_DFIMISC, 1);
> +    g_assert_cmphex(qtest_readl(qts, K230_DDRC_BASE + K230_DDRC_STAT) & 0x7,
> +                    ==, 1);
> +
> +    qtest_quit(qts);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    g_test_init(&argc, &argv, NULL);
> +
> +    qtest_add_func("/k230-ddr/reset-and-register-access",
> +                   test_reset_and_register_access);
> +    qtest_add_func("/k230-ddr/software-update-handshake",
> +                   test_software_update_handshake);
> +    qtest_add_func("/k230-ddr/phy-ownership", test_phy_ownership);
> +    qtest_add_func("/k230-ddr/dfi-prerequisites", test_dfi_prerequisites);
> +    qtest_add_func("/k230-ddr/dfi-complete-enable",
> +                   test_dfi_complete_enable);
> +    qtest_add_func("/k230-ddr/training-and-dfi-handshake",
> +                   test_training_and_dfi_handshake);
> +
> +    return g_test_run();
> +}
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 56ff860e21..dc110f72c8 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -297,7 +297,8 @@ qtests_riscv64 = ['riscv-csr-test'] + \
>     (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') and
>      config_all_devices.has_key('CONFIG_RISCV_IOMMU') ?
>      ['iommu-riscv-test'] : []) + \
> -  (config_all_devices.has_key('CONFIG_K230') ? ['k230-wdt-test'] : [])
> +  (config_all_devices.has_key('CONFIG_K230') ?
> +   ['k230-ddr-test', 'k230-wdt-test'] : [])
>   
>   qtests_hexagon = ['boot-serial-test']
>   


