Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EE9CC624A4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 16:52:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Ag0-0004f5-S2; Thu, 03 Sep 2026 12:52:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1x2Afz-0004ea-OZ; Thu, 03 Sep 2026 12:52:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1x2Afx-0007l2-5M; Thu, 03 Sep 2026 12:52:35 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683G2Qbm3425219; Thu, 3 Sep 2026 16:52:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=AgoUhCWDjJD/JyRb5WPgT8zYhVzTnK
 lj+Ix2ecfe/Pc=; b=mGFDDYTPPrdoanlXW27Bh9hxOivYZOrTO09itrI1m54gLC
 HKX0zmMNm8j6FkCQQpMedMc1yPC7cZn+lGztuegwhmjA3j8g27Gczc5H8e266RJZ
 uSTAbNGWN7UV9uPkk4MqnrAp0pMgnJur3KquEhI7MhxXsK/VUXOk5i5N8w/1DGDc
 0O8jocM5dFqipIFjLsW8XAptzEcZXxxlEQaZxnoSOAblmIwXJpPXjQ4LzveTTDLY
 XHl3o9we6kIORtZhY3pAYYJEPAbUbX2VZc9PBNta1y06DLNVJNFCz2xaU4tFrwva
 peQAonyXehzLNnugOl9aBtO7qG7Vs9EiLSfn74ig==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbpx5x001-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Sep 2026 16:52:23 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 683GfGhI027065;
 Thu, 3 Sep 2026 16:52:22 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gc9rqrq81-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Sep 2026 16:52:22 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 683GqKBp18023072
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 3 Sep 2026 16:52:20 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5543458050;
 Thu,  3 Sep 2026 16:52:20 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BCC5B58045;
 Thu,  3 Sep 2026 16:52:18 +0000 (GMT)
Received: from [9.10.80.39] (unknown [9.10.80.39])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  3 Sep 2026 16:52:18 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------iAf0l0kRqCWP6dORPdj3THcu"
Message-ID: <11055133-18e8-48b7-8aa7-57fac9eb9a55@linux.ibm.com>
Date: Thu, 3 Sep 2026 11:52:17 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/9] qtest/phb5: Add testbench for PHB
To: Saif Abrar <saif.abrar@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: harshpb@linux.ibm.com, clg@kaod.org, npiggin@gmail.com,
 fbarrat@linux.ibm.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 cohuck@redhat.com, pbonzini@redhat.com, thuth@redhat.com,
 lvivier@redhat.com, danielhb413@gmail.com, chalapathi.v@linux.ibm.com,
 calebs@linux.ibm.com, milesg@linux.ibm.com, jishnuvw@linux.ibm.com,
 adityag@linux.ibm.com, amachhiw@linux.ibm.com
References: <20260831123005.1485518-1-saif.abrar@linux.ibm.com>
 <20260831123005.1485518-2-saif.abrar@linux.ibm.com>
Content-Language: en-US
From: Mike Kowal <kowal@linux.ibm.com>
In-Reply-To: <20260831123005.1485518-2-saif.abrar@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=PPc/P/qC c=1 sm=1 tr=0 ts=6a99a5c7 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=r77TgQKjGQsHNAKrUKIA:9 a=VnNF1IyMAAAA:8
 a=aow-egSQAAAA:8 a=PClYFOg19u5Z3GYdm5AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=-0P0_LzdpgOpHJt5G-4A:9 a=QQraQ1-GEmNdHsLk:21 a=_W_S_7VecoQA:10
 a=lqcHg5cX4UMA:10 a=gFNbaldVC-z-bsjSTzMo:22
X-Proofpoint-GUID: XF3PLKplX3WmXG8ZZKJn82BWBhPS26N-
X-Proofpoint-ORIG-GUID: t1YJwMUAFen3SN-EySWySiUE5Yp55uJ8
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE0NCBTYWx0ZWRfX0prIesQRROEB
 SfwoKLRMMWAZ+Zx0pA8EJhsc399iNnm/zLzBlgJxxzH/Lq1sONi/x4PA3isvqMoQv6xvLWykdTR
 wnIdwOb9n/BlQABhJRgIugL6gSkxx90=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE0NCBTYWx0ZWRfX+q1eyq4uAGjc
 sWbJURkkRpyfNh1yII7zwMCFDtwnu2XgXAeZhmBdYnzIbmUWCOXTgnDxTEAT/eKA7DaZe0PPuSr
 3WVKRr5W4XT1FuPjxzOUNbQyHkBxW+bzxSJCjt6pQl8kXNF73mejBp+J9t6yIYkH1cIx6Afhs2e
 v/jYCLVhUEiYIQV/USuj/3DRaidbJL9k4sfBRZz9MybNAL8dfjfIz7kIKk0ZDoGSk+GPd2neO8f
 cUHmr/odE7lA62Z+4m4ZX5gNlnQKRx/yrWLtsthY73FxFPLMhaD60nGO7+SeEyr1Lk2JSOEju/Q
 7TiaTqmXFTd6kBVSQSm0Bd/9it+dl811tnDWuF53t0w7EOHQqSKv5TSwDwq7S1VFMeocoTpAYWF
 hUIldEgATKP3+uV/aELWa0HfN+PIozPb8r3EVg0sgF4uIm9c63/LwshGaXaMavI9L8vmAWZETSm
 N0OKq8TX2qWQ5GzGSyA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609030144
Received-SPF: pass client-ip=148.163.156.1; envelope-from=kowal@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This is a multi-part message in MIME format.
--------------iAf0l0kRqCWP6dORPdj3THcu
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Reviewed-by: Michael Kowal<kowal@linux.ibm.com>

Thanks, MAK


On 8/31/2026 7:29 AM, Saif Abrar wrote:
> From: Saif Abrar<saif.abrar@linux.vnet.ibm.com>
>
> New qtest testbench added for PHB[345].
> Testbench reads PHB Version register and asserts that
> bits[24:31] have value 0xA3, 0xA4 and 0xA5 respectively.
>
> Signed-off-by: Saif Abrar<saif.abrar@linux.ibm.com>
> Reviewed-by: Cédric Le Goater<clg@kaod.org>
> Reviewed-by: Caleb Schlossin<calebs@linux.ibm.com>
> ---
>   tests/qtest/meson.build         |   1 +
>   tests/qtest/pnv-host-i2c-test.c |  13 +----
>   tests/qtest/pnv-phb-test.c      | 100 ++++++++++++++++++++++++++++++++
>   tests/qtest/pnv-qtest-common.h  |  24 ++++++++
>   tests/qtest/pnv-xive2-common.h  |   7 +--
>   5 files changed, 127 insertions(+), 18 deletions(-)
>   create mode 100644 tests/qtest/pnv-phb-test.c
>   create mode 100644 tests/qtest/pnv-qtest-common.h
>
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index cbdef5a545..bfea40bdf3 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -191,6 +191,7 @@ qtests_ppc64 = \
>     (config_all_devices.has_key('CONFIG_POWERNV') ? ['pnv-xive2-test'] : []) +                 \
>     (config_all_devices.has_key('CONFIG_POWERNV') ? ['pnv-spi-seeprom-test'] : []) +           \
>     (config_all_devices.has_key('CONFIG_POWERNV') ? ['pnv-host-i2c-test'] : []) +              \
> +  (config_all_devices.has_key('CONFIG_POWERNV') ? ['pnv-phb-test'] : []) +                  \
>     (config_all_devices.has_key('CONFIG_PSERIES') ? ['numa-test'] : []) +                      \
>     (config_all_devices.has_key('CONFIG_PSERIES') ? ['rtas-test'] : []) +                      \
>     (slirp.found() ? ['pxe-test'] : []) +              \
> diff --git a/tests/qtest/pnv-host-i2c-test.c b/tests/qtest/pnv-host-i2c-test.c
> index 5fd54f9de7..7d3c0035f9 100644
> --- a/tests/qtest/pnv-host-i2c-test.c
> +++ b/tests/qtest/pnv-host-i2c-test.c
> @@ -11,18 +11,7 @@
>   #include "hw/gpio/pca9554_regs.h"
>   #include "hw/gpio/pca9552_regs.h"
>   #include "pnv-xscom.h"
> -
> -#define PPC_BIT(bit)            (0x8000000000000000ULL >> (bit))
> -#define PPC_BIT32(bit)          (0x80000000 >> (bit))
> -#define PPC_BIT8(bit)           (0x80 >> (bit))
> -#define PPC_BITMASK(bs, be)     ((PPC_BIT(bs) - PPC_BIT(be)) | PPC_BIT(bs))
> -#define PPC_BITMASK32(bs, be)   ((PPC_BIT32(bs) - PPC_BIT32(be)) | \
> -                                 PPC_BIT32(bs))
> -
> -#define MASK_TO_LSH(m)          (__builtin_ffsll(m) - 1)
> -#define GETFIELD(m, v)          (((v) & (m)) >> MASK_TO_LSH(m))
> -#define SETFIELD(m, v, val) \
> -        (((v) & ~(m)) | ((((typeof(v))(val)) << MASK_TO_LSH(m)) & (m)))
> +#include "pnv-qtest-common.h" #define PNV10_XSCOM_I2CM_BASE 0xa0000 #define PNV10_XSCOM_I2CM_SIZE 
> 0x1000 diff --git a/tests/qtest/pnv-phb-test.c 
> b/tests/qtest/pnv-phb-test.c new file mode 100644 index 
> 0000000000..a6f890ba79 --- /dev/null +++ b/tests/qtest/pnv-phb-test.c 
> @@ -0,0 +1,100 @@ +/* + * QTest testcase for PowerNV PHB + * + * 
> Copyright (c) 2026, IBM Corporation. + * + * SPDX-License-Identifier: 
> GPL-2.0-or-later + * + */ + +#include "qemu/osdep.h"
> +#include "libqtest.h"
> +#include "hw/pci-host/pnv_phb4_regs.h"
> +#include "pnv-xscom.h"
> +#include "pnv-qtest-common.h"
> +
> +#define PHB3_PBCQ_SPCI_ASB_ADDR      0x0
> +#define PHB3_PBCQ_SPCI_ASB_DATA      0x2
> +
> +/* Index of PNV_CHIP_POWER10 in pnv_chips[] within "pnv-xscom.h" */
> +#define PHB4_XSCOM              0x40084800ull
> +
> +/* SCOM to PCBA address conversion */
> +#define SCOM_TO_PCBA(scom, addr) (((scom) >> 3) + (addr))
> +
> +/*
> + * Indirect XSCOM read::
> + * - Write 'Indirect Address Register' with register-offset to read.
> + * - Read 'Indirect Data Register' to get the value.
> + */
> +static uint64_t pnv_phb_xscom_read(QTestState *qts, const PnvChip *chip,
> +        uint64_t scom, uint32_t indirect_addr, uint32_t indirect_data,
> +        uint64_t reg)
> +{
> +    qtest_writeq(qts, pnv_xscom_addr(chip, SCOM_TO_PCBA(scom, indirect_addr)),
> +                 reg);
> +    return qtest_readq(qts, pnv_xscom_addr(chip, SCOM_TO_PCBA(scom,
> +                                                              indirect_data)));
> +}
> +
> +/* Assert that 'PHB - Version Register' bits[24:31] are as expected */
> +static void phb_version_test(const void *data)
> +{
> +    const PnvChip *chip = (PnvChip *)data;
> +    QTestState *qts;
> +    const char *machine = pnv_get_machine_type(chip->chip_type);
> +
> +    /* Defaults to PNV_CHIP_POWER8 */
> +    uint64_t phb_xscom = 0x4809e000;
> +    uint64_t reg_phb_version = PHB_VERSION;
> +    uint32_t indirect_addr = PHB3_PBCQ_SPCI_ASB_ADDR;
> +    uint32_t indirect_data = PHB3_PBCQ_SPCI_ASB_DATA;
> +    uint32_t expected_ver = 0xA3;
> +    uint64_t ver;
> +
> +    if (chip->chip_type == PNV_CHIP_POWER9) {
> +        phb_xscom = 0x68084800;
> +        indirect_addr = PHB_SCOM_HV_IND_ADDR;
> +        indirect_data = PHB_SCOM_HV_IND_DATA;
> +        reg_phb_version |= PPC_BIT(0);
> +        expected_ver = 0xA4;
> +    } else if ((chip->chip_type == PNV_CHIP_POWER10) ||
> +               (chip->chip_type == PNV_CHIP_POWER11)) {
> +        phb_xscom = PHB4_XSCOM;
> +        indirect_addr = PHB_SCOM_HV_IND_ADDR;
> +        indirect_data = PHB_SCOM_HV_IND_DATA;
> +        reg_phb_version |= PPC_BIT(0);
> +        expected_ver = 0xA5;
> +    }
> +
> +    qts = qtest_initf("-M %s -accel tcg -cpu %s", machine, chip->cpu_model);
> +
> +    ver = pnv_phb_xscom_read(qts, chip, phb_xscom,
> +                                indirect_addr, indirect_data, reg_phb_version);
> +
> +    /* PHB Version register bits [24:31] */
> +    ver = GETFIELD(PPC_BITMASK(24, 31), ver);
> +    g_assert_cmpuint(ver, ==, expected_ver);
> +
> +    qtest_quit(qts);
> +}
> +
> +/* Verify versions of all supported PHB's */
> +static void add_phbX_version_test(void)
> +{
> +    for (int i = 0; i < ARRAY_SIZE(pnv_chips); i++) {
> +        g_autofree char *tname = g_strdup_printf("pnv-phb/%s",
> +                                      pnv_chips[i].cpu_model);
> +        qtest_add_data_func(tname, &pnv_chips[i], phb_version_test);
> +    }
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    g_test_init(&argc, &argv, NULL);
> +
> +    /* PHB[345] tests */
> +    add_phbX_version_test();
> +
> +    return g_test_run();
> +}
> diff --git a/tests/qtest/pnv-qtest-common.h b/tests/qtest/pnv-qtest-common.h
> new file mode 100644
> index 0000000000..c2d1bae7bb
> --- /dev/null
> +++ b/tests/qtest/pnv-qtest-common.h
> @@ -0,0 +1,24 @@
> +/*
> + * PNV QTest common definitions
> + *
> + * Copyright (c) 2026, IBM Corporation.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef TEST_PNV_QTEST_COMMON_H
> +#define TEST_PNV_QTEST_COMMON_H
> +
> +#define PPC_BIT(bit)            (0x8000000000000000ULL >> (bit))
> +#define PPC_BIT32(bit)          (0x80000000 >> (bit))
> +#define PPC_BIT8(bit)           (0x80 >> (bit))
> +#define PPC_BITMASK(bs, be)     ((PPC_BIT(bs) - PPC_BIT(be)) | PPC_BIT(bs))
> +#define PPC_BITMASK32(bs, be)   ((PPC_BIT32(bs) - PPC_BIT32(be)) | \
> +                                 PPC_BIT32(bs))
> +
> +#define MASK_TO_LSH(m)          (__builtin_ffsll(m) - 1)
> +#define GETFIELD(m, v)          (((v) & (m)) >> MASK_TO_LSH(m))
> +#define SETFIELD(m, v, val) \
> +        (((v) & ~(m)) | ((((typeof(v))(val)) << MASK_TO_LSH(m)) & (m)))
> +
> +#endif
> diff --git a/tests/qtest/pnv-xive2-common.h b/tests/qtest/pnv-xive2-common.h
> index 3b84227424..4b823a57e2 100644
> --- a/tests/qtest/pnv-xive2-common.h
> +++ b/tests/qtest/pnv-xive2-common.h
> @@ -9,12 +9,7 @@
>   #ifndef TEST_PNV_XIVE2_COMMON_H
>   #define TEST_PNV_XIVE2_COMMON_H
>   
> -#define PPC_BIT(bit)            (0x8000000000000000ULL >> (bit))
> -#define PPC_BIT32(bit)          (0x80000000 >> (bit))
> -#define PPC_BIT8(bit)           (0x80 >> (bit))
> -#define PPC_BITMASK(bs, be)     ((PPC_BIT(bs) - PPC_BIT(be)) | PPC_BIT(bs))
> -#define PPC_BITMASK32(bs, be)   ((PPC_BIT32(bs) - PPC_BIT32(be)) | \
> -                                 PPC_BIT32(bs))
> +#include "pnv-qtest-common.h"
>   #include "hw/intc/pnv_xive2_regs.h"
>   #include "hw/ppc/xive_regs.h"
>   #include "hw/ppc/xive2_regs.h"
--------------iAf0l0kRqCWP6dORPdj3THcu
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>
    </p>
    <div
style="font-family: &quot;Consolas&quot;; font-size: 11.0pt; color: #000000;background-color: #FFFFFF; font-style: normal; font-weight: normal; text-decoration: none;">
      <pre>Reviewed-by: Michael Kowal <a class="moz-txt-link-rfc2396E" href="mailto:kowal@linux.ibm.com">&lt;kowal@linux.ibm.com&gt;</a>

Thanks, MAK
</pre>
    </div>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 8/31/2026 7:29 AM, Saif Abrar wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20260831123005.1485518-2-saif.abrar@linux.ibm.com">
      <pre wrap="" class="moz-quote-pre">From: Saif Abrar <a class="moz-txt-link-rfc2396E" href="mailto:saif.abrar@linux.vnet.ibm.com">&lt;saif.abrar@linux.vnet.ibm.com&gt;</a>

New qtest testbench added for PHB[345].
Testbench reads PHB Version register and asserts that
bits[24:31] have value 0xA3, 0xA4 and 0xA5 respectively.

Signed-off-by: Saif Abrar <a class="moz-txt-link-rfc2396E" href="mailto:saif.abrar@linux.ibm.com">&lt;saif.abrar@linux.ibm.com&gt;</a>
Reviewed-by: Cédric Le Goater <a class="moz-txt-link-rfc2396E" href="mailto:clg@kaod.org">&lt;clg@kaod.org&gt;</a>
Reviewed-by: Caleb Schlossin <a class="moz-txt-link-rfc2396E" href="mailto:calebs@linux.ibm.com">&lt;calebs@linux.ibm.com&gt;</a>
---
 tests/qtest/meson.build         |   1 +
 tests/qtest/pnv-host-i2c-test.c |  13 +----
 tests/qtest/pnv-phb-test.c      | 100 ++++++++++++++++++++++++++++++++
 tests/qtest/pnv-qtest-common.h  |  24 ++++++++
 tests/qtest/pnv-xive2-common.h  |   7 +--
 5 files changed, 127 insertions(+), 18 deletions(-)
 create mode 100644 tests/qtest/pnv-phb-test.c
 create mode 100644 tests/qtest/pnv-qtest-common.h

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index cbdef5a545..bfea40bdf3 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -191,6 +191,7 @@ qtests_ppc64 = \
   (config_all_devices.has_key('CONFIG_POWERNV') ? ['pnv-xive2-test'] : []) +                 \
   (config_all_devices.has_key('CONFIG_POWERNV') ? ['pnv-spi-seeprom-test'] : []) +           \
   (config_all_devices.has_key('CONFIG_POWERNV') ? ['pnv-host-i2c-test'] : []) +              \
+  (config_all_devices.has_key('CONFIG_POWERNV') ? ['pnv-phb-test'] : []) +                  \
   (config_all_devices.has_key('CONFIG_PSERIES') ? ['numa-test'] : []) +                      \
   (config_all_devices.has_key('CONFIG_PSERIES') ? ['rtas-test'] : []) +                      \
   (slirp.found() ? ['pxe-test'] : []) +              \
diff --git a/tests/qtest/pnv-host-i2c-test.c b/tests/qtest/pnv-host-i2c-test.c
index 5fd54f9de7..7d3c0035f9 100644
--- a/tests/qtest/pnv-host-i2c-test.c
+++ b/tests/qtest/pnv-host-i2c-test.c
@@ -11,18 +11,7 @@
 #include "hw/gpio/pca9554_regs.h"
 #include "hw/gpio/pca9552_regs.h"
 #include "pnv-xscom.h"
-
-#define PPC_BIT(bit)            (0x8000000000000000ULL &gt;&gt; (bit))
-#define PPC_BIT32(bit)          (0x80000000 &gt;&gt; (bit))
-#define PPC_BIT8(bit)           (0x80 &gt;&gt; (bit))
-#define PPC_BITMASK(bs, be)     ((PPC_BIT(bs) - PPC_BIT(be)) | PPC_BIT(bs))
-#define PPC_BITMASK32(bs, be)   ((PPC_BIT32(bs) - PPC_BIT32(be)) | \
-                                 PPC_BIT32(bs))
-
-#define MASK_TO_LSH(m)          (__builtin_ffsll(m) - 1)
-#define GETFIELD(m, v)          (((v) &amp; (m)) &gt;&gt; MASK_TO_LSH(m))
-#define SETFIELD(m, v, val) \
-        (((v) &amp; ~(m)) | ((((typeof(v))(val)) &lt;&lt; MASK_TO_LSH(m)) &amp; (m)))
+#include "pnv-qtest-common.h<a class="moz-txt-link-rfc2396E" href="mailto:#definePNV10_XSCOM_I2CM_BASE0xa0000#definePNV10_XSCOM_I2CM_SIZE0x1000diff--gita/tests/qtest/pnv-phb-test.cb/tests/qtest/pnv-phb-test.cnewfilemode100644index0000000000..a6f890ba79---/dev/null+++b/tests/qtest/pnv-phb-test.c@@-0,0+1,100@@+/*+*QTesttestcaseforPowerNVPHB+*+*Copyright(c)2026,IBMCorporation.+*+*SPDX-License-Identifier:GPL-2.0-or-later+*+*/++#include">"
 
 #define PNV10_XSCOM_I2CM_BASE   0xa0000
 #define PNV10_XSCOM_I2CM_SIZE   0x1000
diff --git a/tests/qtest/pnv-phb-test.c b/tests/qtest/pnv-phb-test.c
new file mode 100644
index 0000000000..a6f890ba79
--- /dev/null
+++ b/tests/qtest/pnv-phb-test.c
@@ -0,0 +1,100 @@
+/*
+ * QTest testcase for PowerNV PHB
+ *
+ * Copyright (c) 2026, IBM Corporation.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#include "</a>qemu/osdep.h"
+#include "libqtest.h"
+#include "hw/pci-host/pnv_phb4_regs.h"
+#include "pnv-xscom.h"
+#include "pnv-qtest-common.h"
+
+#define PHB3_PBCQ_SPCI_ASB_ADDR      0x0
+#define PHB3_PBCQ_SPCI_ASB_DATA      0x2
+
+/* Index of PNV_CHIP_POWER10 in pnv_chips[] within "pnv-xscom.h" */
+#define PHB4_XSCOM              0x40084800ull
+
+/* SCOM to PCBA address conversion */
+#define SCOM_TO_PCBA(scom, addr) (((scom) &gt;&gt; 3) + (addr))
+
+/*
+ * Indirect XSCOM read::
+ * - Write 'Indirect Address Register' with register-offset to read.
+ * - Read 'Indirect Data Register' to get the value.
+ */
+static uint64_t pnv_phb_xscom_read(QTestState *qts, const PnvChip *chip,
+        uint64_t scom, uint32_t indirect_addr, uint32_t indirect_data,
+        uint64_t reg)
+{
+    qtest_writeq(qts, pnv_xscom_addr(chip, SCOM_TO_PCBA(scom, indirect_addr)),
+                 reg);
+    return qtest_readq(qts, pnv_xscom_addr(chip, SCOM_TO_PCBA(scom,
+                                                              indirect_data)));
+}
+
+/* Assert that 'PHB - Version Register' bits[24:31] are as expected */
+static void phb_version_test(const void *data)
+{
+    const PnvChip *chip = (PnvChip *)data;
+    QTestState *qts;
+    const char *machine = pnv_get_machine_type(chip-&gt;chip_type);
+
+    /* Defaults to PNV_CHIP_POWER8 */
+    uint64_t phb_xscom = 0x4809e000;
+    uint64_t reg_phb_version = PHB_VERSION;
+    uint32_t indirect_addr = PHB3_PBCQ_SPCI_ASB_ADDR;
+    uint32_t indirect_data = PHB3_PBCQ_SPCI_ASB_DATA;
+    uint32_t expected_ver = 0xA3;
+    uint64_t ver;
+
+    if (chip-&gt;chip_type == PNV_CHIP_POWER9) {
+        phb_xscom = 0x68084800;
+        indirect_addr = PHB_SCOM_HV_IND_ADDR;
+        indirect_data = PHB_SCOM_HV_IND_DATA;
+        reg_phb_version |= PPC_BIT(0);
+        expected_ver = 0xA4;
+    } else if ((chip-&gt;chip_type == PNV_CHIP_POWER10) ||
+               (chip-&gt;chip_type == PNV_CHIP_POWER11)) {
+        phb_xscom = PHB4_XSCOM;
+        indirect_addr = PHB_SCOM_HV_IND_ADDR;
+        indirect_data = PHB_SCOM_HV_IND_DATA;
+        reg_phb_version |= PPC_BIT(0);
+        expected_ver = 0xA5;
+    }
+
+    qts = qtest_initf("-M %s -accel tcg -cpu %s", machine, chip-&gt;cpu_model);
+
+    ver = pnv_phb_xscom_read(qts, chip, phb_xscom,
+                                indirect_addr, indirect_data, reg_phb_version);
+
+    /* PHB Version register bits [24:31] */
+    ver = GETFIELD(PPC_BITMASK(24, 31), ver);
+    g_assert_cmpuint(ver, ==, expected_ver);
+
+    qtest_quit(qts);
+}
+
+/* Verify versions of all supported PHB's */
+static void add_phbX_version_test(void)
+{
+    for (int i = 0; i &lt; ARRAY_SIZE(pnv_chips); i++) {
+        g_autofree char *tname = g_strdup_printf("pnv-phb/%s",
+                                      pnv_chips[i].cpu_model);
+        qtest_add_data_func(tname, &amp;pnv_chips[i], phb_version_test);
+    }
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&amp;argc, &amp;argv, NULL);
+
+    /* PHB[345] tests */
+    add_phbX_version_test();
+
+    return g_test_run();
+}
diff --git a/tests/qtest/pnv-qtest-common.h b/tests/qtest/pnv-qtest-common.h
new file mode 100644
index 0000000000..c2d1bae7bb
--- /dev/null
+++ b/tests/qtest/pnv-qtest-common.h
@@ -0,0 +1,24 @@
+/*
+ * PNV QTest common definitions
+ *
+ * Copyright (c) 2026, IBM Corporation.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef TEST_PNV_QTEST_COMMON_H
+#define TEST_PNV_QTEST_COMMON_H
+
+#define PPC_BIT(bit)            (0x8000000000000000ULL &gt;&gt; (bit))
+#define PPC_BIT32(bit)          (0x80000000 &gt;&gt; (bit))
+#define PPC_BIT8(bit)           (0x80 &gt;&gt; (bit))
+#define PPC_BITMASK(bs, be)     ((PPC_BIT(bs) - PPC_BIT(be)) | PPC_BIT(bs))
+#define PPC_BITMASK32(bs, be)   ((PPC_BIT32(bs) - PPC_BIT32(be)) | \
+                                 PPC_BIT32(bs))
+
+#define MASK_TO_LSH(m)          (__builtin_ffsll(m) - 1)
+#define GETFIELD(m, v)          (((v) &amp; (m)) &gt;&gt; MASK_TO_LSH(m))
+#define SETFIELD(m, v, val) \
+        (((v) &amp; ~(m)) | ((((typeof(v))(val)) &lt;&lt; MASK_TO_LSH(m)) &amp; (m)))
+
+#endif
diff --git a/tests/qtest/pnv-xive2-common.h b/tests/qtest/pnv-xive2-common.h
index 3b84227424..4b823a57e2 100644
--- a/tests/qtest/pnv-xive2-common.h
+++ b/tests/qtest/pnv-xive2-common.h
@@ -9,12 +9,7 @@
 #ifndef TEST_PNV_XIVE2_COMMON_H
 #define TEST_PNV_XIVE2_COMMON_H
 
-#define PPC_BIT(bit)            (0x8000000000000000ULL &gt;&gt; (bit))
-#define PPC_BIT32(bit)          (0x80000000 &gt;&gt; (bit))
-#define PPC_BIT8(bit)           (0x80 &gt;&gt; (bit))
-#define PPC_BITMASK(bs, be)     ((PPC_BIT(bs) - PPC_BIT(be)) | PPC_BIT(bs))
-#define PPC_BITMASK32(bs, be)   ((PPC_BIT32(bs) - PPC_BIT32(be)) | \
-                                 PPC_BIT32(bs))
+#include "pnv-qtest-common.h"
 #include "hw/intc/pnv_xive2_regs.h"
 #include "hw/ppc/xive_regs.h"
 #include "hw/ppc/xive2_regs.h"
</pre>
    </blockquote>
  </body>
</html>

--------------iAf0l0kRqCWP6dORPdj3THcu--


