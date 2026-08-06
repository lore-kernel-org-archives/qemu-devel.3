Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC210C55ABF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 11:36:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrwOl-0004XN-LH; Thu, 06 Aug 2026 07:36:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wrwOb-0004VS-Pw
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 07:36:24 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wrwOY-00063w-Cj
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 07:36:20 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6769nfaL865611
 for <qemu-devel@nongnu.org>; Thu, 6 Aug 2026 11:36:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pIKbBduoXm6gWnew9dkF96g81OjwlUftXNbqQaJOh/U=; b=YCVW4cjcesCLnR36
 jrvCRBGzxiu0fsqrv4NQtUcoOU2fcrTeBI0TBVEo2oBHhbXh9D699AlgZ4TIy5No
 PnWwepYAbMz8ibZqhi3BTRA/wBg7VgM0+OXzv4XCr1zS5unyc7I77NDPNTtYQcdI
 XL8LRdJP0I9cjQY/SmVZQxaxHlpTFYHz4r2x6IQ4bJCfRCArdVL+y3WgU/rsZ69n
 uEMuOZv2rTsSUGq0t4ZzgrNCOfQn3p/wprGGrbeIWisZwnMmHrvHNi087Dr7y2IX
 IMLL20tbODgWnKQjft78E4qGoTd4lW1rqj5/l1YIs+Q87uo6OjRpv8UliJ9f7DVe
 u8unhg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fv9f5c0mc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 11:36:16 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8f45dde7595so20782536d6.3
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 04:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786016175; x=1786620975; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=pIKbBduoXm6gWnew9dkF96g81OjwlUftXNbqQaJOh/U=;
 b=AiKm45IGc1YRtf6ROpHgo/mhxfF79HWc8AMMiDty9pw8CPXebQcf67bwvTur9uM8M/
 ClBPJ++m27xZeXMuPoZpK/M5HXjGoPEIsnEtkAFTUG8bZg1FdhJw/sjPJJi+5U3iDP5K
 /XA2KodLSHmX8zqWCxI0O+TH/AEVbHVv+0UD+p2QQMMXoKFXcwts7etqKCM0pfEO+bgC
 CZn5nlRCUodmpDFL5/PFs+g0V75tSS9sWWdPBJ77qsrb0apVKKiLbnstX9DPbQnlxTJx
 jvXcgQcw/s3dRmWjLdrLNVZkUmtvVnKX/oWahqI22swGMDcJrx//BHeLvTzF+6apDv7b
 RA7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786016175; x=1786620975;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pIKbBduoXm6gWnew9dkF96g81OjwlUftXNbqQaJOh/U=;
 b=Gg5xaMlGoL6bFq1CGHrpesZyjiWdfIepbtz/iO2Wj+y7a6OkLB/p/otw4QvQljo8VH
 4rHwgfMPJ7MErl+mHeE4uHzISZ9v3phg3jxXfjH0srlRBQ6iABfWPVhsb6LupDBPbR7l
 ON1QSuodc+G5VWFggnewUSAWZabIgbse52qeg6iHm64GLf57tqBpNBv3IlPO8dTNG3Np
 IN8jjpbM1luunchwl6ovr6lmE9y38kjncYgEPmTDVY4aFVAcBrEwsrbXcfLaUJoTY7C1
 pz0gjoeH6/0q4q/s8Auc+OFbTsNyNNPzFqUgx9tvGQ/HaVswTNvV/1L/KubuaMlNyQd9
 3yNg==
X-Forwarded-Encrypted: i=1;
 AHgh+RplLcpwyDDFfmhi/U6+TYH6RcrAlXVTssL8wWZECDfUg+ToS//5HvqnHIl0gKChES4WR7OXyAG+K9ac@nongnu.org
X-Gm-Message-State: AOJu0Yy9+WUC1zeL3VBTpTH2pL/XpNM1GPnRlUwtXt/qocr6NKGL/UqP
 8YXllvB46Zb3uPbWWrLO+x/Z05qOR3Wa6suNi/Zdp07iLOmrl9WEbe7HWqw3l1ChvU/PdZTRBHD
 cIU9FPb3oLPiOtmyYEswOwLdg48g2NegmFUhr22J1nDbS5zZ9Z5YWlvK2jg==
X-Gm-Gg: AR+sD10jzvhn9hs7aKghHyudRcTtiKMfwkZEwVdCHENRUTj0IZb9eij5gkO/rX2qBdi
 UuGKoY04/G7gKac6FWCNr3v1oBbxCTSsNOr+f/4sZ6eIn7HRc61ZHBDR/8z5nRjohbZSbZ4mz/7
 kNClubGl8u6Fud0KEIvezAb+SrS2v8mqYIti4CTAVVG9Gqv4OY8BnF64Yrvx6QlMKGwkqPaNfsb
 5DKlxyO5xuYJ1Qul5z5h78opeM7gs4BHOZrfKEvDqqsziGADYRlvwAvHzBF+WRox7BdLc+IaDAw
 qoCo6T3z/Iu4Bf/9/xYdFwCClvYESsdKj7SBocevpi95/MoyRmiyvInF/t4CWEmEhx6lpe4QG53
 EIj5+HWCMv/cg3oAhL7oENNKvjp7nDRjxk619
X-Received: by 2002:a05:6214:5b88:b0:8e8:7de7:ec20 with SMTP id
 6a1803df08f44-9088105dc42mr183448756d6.4.1786016174748; 
 Thu, 06 Aug 2026 04:36:14 -0700 (PDT)
X-Received: by 2002:a05:6214:5b88:b0:8e8:7de7:ec20 with SMTP id
 6a1803df08f44-9088105dc42mr183447806d6.4.1786016174144; 
 Thu, 06 Aug 2026 04:36:14 -0700 (PDT)
Received: from [192.168.15.12] ([177.196.135.131])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9087ff9d6e9sm49178796d6.7.2026.08.06.04.36.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2026 04:36:12 -0700 (PDT)
Message-ID: <197c1e99-ba1e-47bf-aa93-ecb893ae6534@oss.qualcomm.com>
Date: Thu, 6 Aug 2026 08:36:08 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] tests/qtest: add test for K230 gsdma
To: Tao Ding <dingtao0430@163.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, pbonzini@redhat.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 farosas@suse.de, lvivier@redhat.com, pierrick.bouvier@oss.qualcomm.com,
 caojunze424@gmail.com
References: <20260727155702.36484-1-dingtao0430@163.com>
 <20260727155702.36484-4-dingtao0430@163.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260727155702.36484-4-dingtao0430@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: QwkKYTwaWOIpBbN7NPxCJBWzWoBnm3BG
X-Proofpoint-ORIG-GUID: QwkKYTwaWOIpBbN7NPxCJBWzWoBnm3BG
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDA5MSBTYWx0ZWRfX7o5oznZq2CMT
 F8f0HVRbxWzH58O3hpdMo/AbcDajEmuZgFEj+ZMYLjEFTLTfb5AgiNRQ8T+UZyc66gRDyQjI6GO
 VXve8hIrzDqde7qKZ2RVCmke7OjU+g0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDA5MSBTYWx0ZWRfX6GHQmpm7Ss5u
 1sWpXTdMCJU44OVkj2yvwOI589+au/VLtjBkeZ80Qm4Mq1QyqY3A9sg/ncsj3sgQnGzGyQz+4yk
 m0ZH72CfGIZG2T32eK6v04GOQWdheWYUBCSP/ENUfk7kLOIcnBYqTea2CRqNboH7p3/3dHKl7Vl
 062V0kIVI674xJCv6+a/sqHIA00Q377beD6LPLwtPeVnjYAGe0FKSyWqqcgFQk0teI8NlFVOMpo
 AUDpeyu/quZgO4xSX3VP3+GFM97RjHZU1JKuG2pinEtwudzxaN1oKl8w+VKpV/imP19HrhwjUr5
 SaGmFJ98c3yfTMlsDXPhwmFfMJGNwIC1Pl/X9bx/Lfl3RRrL0iDkb15cxz8xz71z5KcDmsywNxZ
 o2l8Mnj2NLTvBWOB4NDHz645LP2N4yaNDvNVUie4mJh4xxG6HmWuyERFWt+r5ZbwJEkuBFHRp54
 rz0akXpXVnRj+SfgvoA==
X-Authority-Analysis: v=2.4 cv=d4bFDxjE c=1 sm=1 tr=0 ts=6a7471b0 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=TqADvzrrTdHTq19dv/zLaQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=Byx-y9mGAAAA:8 a=EUspDBNiAAAA:8 a=pPI8FLIT4_VpT0bWqI8A:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060091
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



On 7/27/2026 12:56 PM, Tao Ding wrote:
> This commit adds test cases for GSDMA.
> Imitate the behavior of the driver, set LLT and sdma registers.
> After the data transmission is completed, check the destination address data.
> 
> Update MAINTAINERS for this test.
> 
> Run this qtest:
>      $ mkdir build && cd build && ../configure --target-list="riscv64-softmmu"
>      $ QTEST_QEMU_BINARY=./qemu-system-riscv64   tests/qtest/k230-gsdma-test
> 
> Signed-off-by: Tao Ding <dingtao0430@163.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   MAINTAINERS                   |   1 +
>   tests/qtest/k230-gsdma-test.c | 201 ++++++++++++++++++++++++++++++++++
>   tests/qtest/meson.build       |   2 +-
>   3 files changed, 203 insertions(+), 1 deletion(-)
>   create mode 100644 tests/qtest/k230-gsdma-test.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 49c8013d5f..9c546596e7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1835,6 +1835,7 @@ F: include/hw/watchdog/k230_wdt.h
>   F: include/hw/dma/k230_gsdma.h
>   F: tests/functional/riscv64/test_k230.py
>   F: tests/qtest/k230-wdt-test.c
> +F: tests/qtest/k230-gsdma-test.c
>   
>   RX Machines
>   -----------
> diff --git a/tests/qtest/k230-gsdma-test.c b/tests/qtest/k230-gsdma-test.c
> new file mode 100644
> index 0000000000..44d4248739
> --- /dev/null
> +++ b/tests/qtest/k230-gsdma-test.c
> @@ -0,0 +1,201 @@
> +/*
> + * QTest testcase for K230 GSDMA
> + *
> + * Copyright (c) 2026 Tao Ding <dingtao0430@163.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/bitops.h"
> +#include "exec/hwaddr.h"
> +#include "hw/dma/k230_gsdma.h"
> +#include "libqtest.h"
> +
> +#define K230_GSDMA_BASE              0x80800000
> +#define TEST_LLT_ADDR0               0x10000
> +#define TEST_LLT_ADDR1               0x10040
> +#define TEST_LLT_ADDR2               0x10080
> +
> +#define TEST_SRC_ADDR0               0x20000
> +#define TEST_SRC_ADDR1               0x22000
> +#define TEST_SRC_ADDR2               0x23000
> +#define TEST_DST_ADDR0               0x30000
> +#define TEST_DST_ADDR1               0x32000
> +#define TEST_DST_ADDR2               0x33000
> +
> +static inline uint64_t gsdma_reg(hwaddr off)
> +{
> +    return K230_GSDMA_BASE + off;
> +}
> +
> +static inline uint64_t gsdma_ch_reg(unsigned int ch, hwaddr off)
> +{
> +    return K230_GSDMA_BASE + K230_GSDMA_CH_BASE +
> +           ch * K230_GSDMA_CH_STRIDE + off;
> +}
> +
> +static void write_sdma_llt_node_full(QTestState *qts, hwaddr addr,
> +                                     uint32_t cfg, hwaddr src,
> +                                     uint32_t size, hwaddr dst,
> +                                     hwaddr next)
> +{
> +    qtest_writel(qts, addr + offsetof(K230GSDMALLT, cfg), cfg);
> +    qtest_writel(qts, addr + offsetof(K230GSDMALLT, src_addr), src);
> +    qtest_writel(qts, addr + offsetof(K230GSDMALLT, line_size), size);
> +    qtest_writel(qts, addr + offsetof(K230GSDMALLT, line_cfg), 0x1);
> +    qtest_writel(qts, addr + offsetof(K230GSDMALLT, dst_addr), dst);
> +    qtest_writel(qts, addr + offsetof(K230GSDMALLT, next_llt_addr), next);
> +}
> +
> +static void write_sdma_llt_node(QTestState *qts, hwaddr addr, uint32_t cfg,
> +                                uint32_t next)
> +{
> +    write_sdma_llt_node_full(qts, addr, cfg, 0x11110000, 0x200,
> +                             0x22220000, next);
> +}
> +
> +static void fill_pattern(uint8_t *buf, size_t size, uint8_t seed)
> +{
> +    for (size_t i = 0; i < size; i++) {
> +        buf[i] = seed + i * 37;
> +    }
> +}
> +
> +static void test_global_registers(void)
> +{
> +    QTestState *qts = qtest_init("-machine k230");
> +
> +    g_assert_cmphex(qtest_readl(qts, gsdma_reg(K230_GSDMA_DMA_CFG)), ==,
> +                    K230_GSDMA_DMA_CFG_RESET);
> +
> +    qtest_writel(qts, gsdma_reg(K230_GSDMA_DMA_CH_EN), 0xff);
> +    g_assert_cmphex(qtest_readl(qts, gsdma_reg(K230_GSDMA_DMA_CH_EN)), ==,
> +                    K230_GSDMA_DMA_CH_EN_MASK);
> +
> +    qtest_writel(qts, gsdma_reg(K230_GSDMA_DMA_INT_MASK), 0x12345);
> +    g_assert_cmphex(qtest_readl(qts, gsdma_reg(K230_GSDMA_DMA_INT_MASK)), ==,
> +                    0x12345);
> +
> +    qtest_writel(qts, gsdma_reg(K230_GSDMA_DMA_CFG), 0xa5a5a5a5);
> +    g_assert_cmphex(qtest_readl(qts, gsdma_reg(K230_GSDMA_DMA_CFG)), ==,
> +                    0xa5a5a5a5);
> +
> +    qtest_writel(qts, gsdma_reg(K230_GSDMA_DMA_WEIGHT), 0xff55aa55);
> +    g_assert_cmphex(qtest_readl(qts, gsdma_reg(K230_GSDMA_DMA_WEIGHT)), ==,
> +                    0x55aa55);
> +
> +    qtest_quit(qts);
> +}
> +
> +static void test_sdma_pause_resume(void)
> +{
> +    uint32_t int_stat;
> +    QTestState *qts = qtest_init("-machine k230");
> +
> +    write_sdma_llt_node(qts, TEST_LLT_ADDR0, K230_GSDMA_LLT_PAUSE,
> +                        TEST_LLT_ADDR1);
> +    write_sdma_llt_node(qts, TEST_LLT_ADDR1, K230_GSDMA_LLT_NODE_INTR, 0);
> +
> +    qtest_writel(qts, gsdma_reg(K230_GSDMA_DMA_CH_EN), BIT(0));
> +    qtest_writel(qts, gsdma_ch_reg(0, K230_GSDMA_CH_LLT_SADDR), TEST_LLT_ADDR0);
> +    qtest_writel(qts, gsdma_ch_reg(0, K230_GSDMA_CH_CTL), K230_GSDMA_CTL_START);
> +
> +    g_assert_cmphex(qtest_readl(qts, gsdma_ch_reg(0, K230_GSDMA_CH_STATUS)), ==,
> +                    K230_GSDMA_SDMA_STATUS_PAUSE);
> +    g_assert_cmphex(qtest_readl(qts, gsdma_ch_reg(0, K230_GSDMA_CH_CURRENT_LLT)),
> +                    ==, TEST_LLT_ADDR0);
> +
> +    int_stat = qtest_readl(qts, gsdma_reg(K230_GSDMA_DMA_INT_STAT));
> +    g_assert_cmphex(int_stat & K230_GSDMA_SDMA_PAUSE_INT(0), ==,
> +                    K230_GSDMA_SDMA_PAUSE_INT(0));
> +    g_assert_cmphex(int_stat & K230_GSDMA_SDMA_DONE_INT(0), ==, 0);
> +
> +    qtest_writel(qts, gsdma_reg(K230_GSDMA_DMA_INT_STAT), int_stat);
> +    qtest_writel(qts, gsdma_ch_reg(0, K230_GSDMA_CH_CTL), K230_GSDMA_CTL_RESUME);
> +
> +    g_assert_cmphex(qtest_readl(qts, gsdma_ch_reg(0, K230_GSDMA_CH_STATUS)), ==,
> +                    0);
> +    g_assert_cmphex(qtest_readl(qts, gsdma_ch_reg(0, K230_GSDMA_CH_CURRENT_LLT)),
> +                    ==, TEST_LLT_ADDR1);
> +
> +    int_stat = qtest_readl(qts, gsdma_reg(K230_GSDMA_DMA_INT_STAT));
> +    g_assert_cmphex(int_stat & K230_GSDMA_SDMA_DONE_INT(0), ==,
> +                    K230_GSDMA_SDMA_DONE_INT(0));
> +    g_assert_cmphex(int_stat & K230_GSDMA_SDMA_ITEM_INT(0), ==,
> +                    K230_GSDMA_SDMA_ITEM_INT(0));
> +
> +    qtest_quit(qts);
> +}
> +
> +static void test_sdma_three_llt_copy(void)
> +{
> +    uint8_t src0[0x1000];
> +    uint8_t src1[1];
> +    uint8_t src2[511];
> +    uint8_t dst0[sizeof(src0)];
> +    uint8_t dst1[sizeof(src1)];
> +    uint8_t dst2[sizeof(src2)];
> +    uint32_t int_stat;
> +    QTestState *qts = qtest_init("-machine k230");
> +
> +    fill_pattern(src0, sizeof(src0), 0x10);
> +    fill_pattern(src1, sizeof(src1), 0x31);
> +    fill_pattern(src2, sizeof(src2), 0x52);
> +    memset(dst0, 0xa5, sizeof(dst0));
> +    memset(dst1, 0xa5, sizeof(dst1));
> +    memset(dst2, 0xa5, sizeof(dst2));
> +
> +    qtest_memwrite(qts, TEST_SRC_ADDR0, src0, sizeof(src0));
> +    qtest_memwrite(qts, TEST_SRC_ADDR1, src1, sizeof(src1));
> +    qtest_memwrite(qts, TEST_SRC_ADDR2, src2, sizeof(src2));
> +    qtest_memwrite(qts, TEST_DST_ADDR0, dst0, sizeof(dst0));
> +    qtest_memwrite(qts, TEST_DST_ADDR1, dst1, sizeof(dst1));
> +    qtest_memwrite(qts, TEST_DST_ADDR2, dst2, sizeof(dst2));
> +
> +    write_sdma_llt_node_full(qts, TEST_LLT_ADDR0, 0, TEST_SRC_ADDR0,
> +                             sizeof(src0), TEST_DST_ADDR0, TEST_LLT_ADDR1);
> +    write_sdma_llt_node_full(qts, TEST_LLT_ADDR1, 0, TEST_SRC_ADDR1,
> +                             sizeof(src1), TEST_DST_ADDR1, TEST_LLT_ADDR2);
> +    write_sdma_llt_node_full(qts, TEST_LLT_ADDR2, 0, TEST_SRC_ADDR2,
> +                             sizeof(src2), TEST_DST_ADDR2, 0);
> +
> +    qtest_writel(qts, gsdma_reg(K230_GSDMA_DMA_CH_EN), BIT(0));
> +    qtest_writel(qts, gsdma_ch_reg(0, K230_GSDMA_CH_LLT_SADDR), TEST_LLT_ADDR0);
> +    qtest_writel(qts, gsdma_ch_reg(0, K230_GSDMA_CH_CTL), K230_GSDMA_CTL_START);
> +
> +    g_assert_cmphex(qtest_readl(qts, gsdma_ch_reg(0, K230_GSDMA_CH_STATUS)), ==,
> +                    0);
> +    g_assert_cmphex(qtest_readl(qts, gsdma_ch_reg(0, K230_GSDMA_CH_CURRENT_LLT)),
> +                    ==, TEST_LLT_ADDR2);
> +
> +    int_stat = qtest_readl(qts, gsdma_reg(K230_GSDMA_DMA_INT_STAT));
> +    g_assert_cmphex(int_stat & K230_GSDMA_SDMA_DONE_INT(0), ==,
> +                    K230_GSDMA_SDMA_DONE_INT(0));
> +    g_assert_cmphex(int_stat & K230_GSDMA_SDMA_PAUSE_INT(0), ==, 0);
> +
> +    memset(dst0, 0, sizeof(dst0));
> +    memset(dst1, 0, sizeof(dst1));
> +    memset(dst2, 0, sizeof(dst2));
> +    qtest_memread(qts, TEST_DST_ADDR0, dst0, sizeof(dst0));
> +    qtest_memread(qts, TEST_DST_ADDR1, dst1, sizeof(dst1));
> +    qtest_memread(qts, TEST_DST_ADDR2, dst2, sizeof(dst2));
> +
> +    g_assert_cmpmem(dst0, sizeof(dst0), src0, sizeof(src0));
> +    g_assert_cmpmem(dst1, sizeof(dst1), src1, sizeof(src1));
> +    g_assert_cmpmem(dst2, sizeof(dst2), src2, sizeof(src2));
> +
> +    qtest_quit(qts);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    g_test_init(&argc, &argv, NULL);
> +
> +    qtest_add_func("/k230-gsdma/global-registers", test_global_registers);
> +    qtest_add_func("/k230-gsdma/sdma-pause-resume", test_sdma_pause_resume);
> +    qtest_add_func("/k230-gsdma/sdma-three-llt-copy",
> +                   test_sdma_three_llt_copy);
> +
> +    return g_test_run();
> +}
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 56ff860e21..1b13a777c9 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -297,7 +297,7 @@ qtests_riscv64 = ['riscv-csr-test'] + \
>     (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') and
>      config_all_devices.has_key('CONFIG_RISCV_IOMMU') ?
>      ['iommu-riscv-test'] : []) + \
> -  (config_all_devices.has_key('CONFIG_K230') ? ['k230-wdt-test'] : [])
> +  (config_all_devices.has_key('CONFIG_K230') ? ['k230-wdt-test', 'k230-gsdma-test'] : [])
>   
>   qtests_hexagon = ['boot-serial-test']
>   


