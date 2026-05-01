Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51BFECD3424
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 14:01:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIoQ1-0004AI-Gc; Fri, 01 May 2026 10:00:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wIoPv-00046x-ST; Fri, 01 May 2026 10:00:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wIoPs-000655-2M; Fri, 01 May 2026 10:00:31 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 641BU9411957237; Fri, 1 May 2026 14:00:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=HdHTaO
 qQVd1bhiNjlr9VVUztDVvxCkqLZJ+KKnEmavY=; b=klB1iCUroIWVHZB0w2rFyV
 SHB67nzxwgoj/MJ6Ug34NgHAj2NJZ7gdR6wkIC2DDiurSvhC4b4UzTXy9RYcxqFT
 7iSCHK5L1/yYVpy6gcB0hfisPPT9yWIgsGfO+MAqHytbp/tp8vsLEeMsZVKAPdmt
 Bhl5Ib0FTf7dNww9tEIEqu0uwWiCj8jxj7VtiiYrhEqm77GvZeB62GUV9AiITdVZ
 6VNxmFFIbSjX2DvN57ZAYe4Brouis3GZjVzAC17GB3j6cglMdzq2GTD+MJTkFU91
 KdI17iHOJDVFfL4LWpIUnR+8wjBgYdg1U7XYSojDdBSY07JFM477qATTjW3wlMFA
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drm1eawub-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 01 May 2026 14:00:13 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 641Drtwq010610;
 Fri, 1 May 2026 14:00:12 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dsamyqexd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 01 May 2026 14:00:12 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 641E0Ant33423914
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 1 May 2026 14:00:11 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9C3AE58061;
 Fri,  1 May 2026 14:00:10 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3A2BA5805A;
 Fri,  1 May 2026 14:00:02 +0000 (GMT)
Received: from [9.39.16.180] (unknown [9.39.16.180])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  1 May 2026 14:00:01 +0000 (GMT)
Message-ID: <a772b506-e306-4fef-a357-3f25374b7354@linux.ibm.com>
Date: Fri, 1 May 2026 19:29:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/9] qtest/phb4: Add testbench for PHB4
Content-Language: en-GB
To: Saif Abrar <saif.abrar@linux.vnet.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: clg@kaod.org, npiggin@gmail.com, fbarrat@linux.ibm.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, danielhb413@gmail.com,
 Michael Kowal <kowal@linux.ibm.com>, chalapathi.v@linux.ibm.com,
 Caleb Schlossin <calebs@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>, jishnuvw@linux.ibm.com,
 Aditya Gupta <adityag@linux.ibm.com>, amachhiw@linux.ibm.com
References: <20260210134110.1515322-1-saif.abrar@linux.vnet.ibm.com>
 <20260305060923.3753402-1-saif.abrar@linux.vnet.ibm.com>
 <20260305060923.3753402-2-saif.abrar@linux.vnet.ibm.com>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20260305060923.3753402-2-saif.abrar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 3nhT7DIsCkQZ0sQnsJeJDMn6WTKZxKGc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTAxMDEzNCBTYWx0ZWRfX6wlaN2sB4ix4
 wA2JRqjXKm48LS0l6SA4BNU7cfysGd5IfAu8LxR0pTxbgJoSJsUw2BSr/T0aRYoYlYrDwO3GOaR
 9T5WgJMld+W7dGh3Qv37L3Bd7IvSc5EsXw8MoW1dmyf9Xi8nVJci24rNDYsEfShf4VMrfHXWw2q
 B0mqq3Bcf1xpIM63LTIMFuhC8p3Zq8S042lm3XSxjMP+mHys6+MPZPk9ihCyWZSyEsbrOqbRg+m
 FeiwgIFpJN+nlxmcqkGu7jQeHfL3fVffFv/4uzBQ8jbhTB6ifQsTYQN91yMpssNoLiKQTagBP/1
 lNT9ZdlUQmqaNhBMoIMjDS7TEan3Td6FDDtdJwGTFDNx/eZ1B7tQtFVdUb2MZjKli1L7cLNh+ch
 S9doI5l1t7q1MAKdC7UX7S+UsI6C7fX7mgLeHAHhfRiGkCJhGFLDjEmkrcaY95wo9pNJUCKfLBH
 Wln5Dd4ea5Iw1SouNnA==
X-Authority-Analysis: v=2.4 cv=VZLH+lp9 c=1 sm=1 tr=0 ts=69f4b1ed cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22
 a=VnNF1IyMAAAA:8 a=aow-egSQAAAA:8 a=cGCsTGRZkh4ummbXGDYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=gFNbaldVC-z-bsjSTzMo:22
X-Proofpoint-GUID: EwxHrBp5405GI-c7HGaZ0aWSrEbN5Dtw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-01_03,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605010134
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

<Adding folks working in this area or who might be interested in it>

On 05/03/26 11:39 am, Saif Abrar wrote:
> New qtest testbench added for PHB[345].
> Testbench reads PHB Version register and asserts that
> bits[24:31] have value 0xA3, 0xA4 and 0xA5 respectively.
> 
> Signed-off-by: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
> Reviewed-by: Cédric Le Goater <clg@kaod.org>
> ---
> v3: Updates for coding guidelines.
> v2: Added version check for PHB3 and PHB4 also.
> 
>   tests/qtest/meson.build     |  1 +
>   tests/qtest/pnv-phb4-test.c | 98 +++++++++++++++++++++++++++++++++++++
>   2 files changed, 99 insertions(+)
>   create mode 100644 tests/qtest/pnv-phb4-test.c
> 
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index ba9f59d2f8..030f3f4fc6 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -182,6 +182,7 @@ qtests_ppc64 = \
>     (config_all_devices.has_key('CONFIG_POWERNV') ? ['pnv-xive2-test'] : []) +                 \
>     (config_all_devices.has_key('CONFIG_POWERNV') ? ['pnv-spi-seeprom-test'] : []) +           \
>     (config_all_devices.has_key('CONFIG_POWERNV') ? ['pnv-host-i2c-test'] : []) +              \
> +  (config_all_devices.has_key('CONFIG_POWERNV') ? ['pnv-phb4-test'] : []) +                  \

Should we just call it pnv-phb-test as it takes care of all PHB 3/4/5.

Also, need to audit all the patches whether to keep the naming as just 
phb or phb{3,4,5} as applicable.


>     (config_all_devices.has_key('CONFIG_PSERIES') ? ['numa-test'] : []) +                      \
>     (config_all_devices.has_key('CONFIG_PSERIES') ? ['rtas-test'] : []) +                      \
>     (slirp.found() ? ['pxe-test'] : []) +              \
> diff --git a/tests/qtest/pnv-phb4-test.c b/tests/qtest/pnv-phb4-test.c
> new file mode 100644
> index 0000000000..797f6b6c87
> --- /dev/null
> +++ b/tests/qtest/pnv-phb4-test.c
> @@ -0,0 +1,98 @@
> +/*
> + * QTest testcase for PowerNV PHB4
> + *
> + * Copyright (c) 2025, IBM Corporation.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "libqtest.h"
> +#include "hw/pci-host/pnv_phb4_regs.h"
> +#include "pnv-xscom.h"
> +
> +#define PPC_BIT(bit)            (0x8000000000000000ULL >> (bit))
> +#define PPC_BITMASK(bs, be)     ((PPC_BIT(bs) - PPC_BIT(be)) | PPC_BIT(bs))

Looks like we already have 2 files in tests/qtest folder which contains 
these macros. Time to cleanup common code into a common header ?
> +
> +#define PHB3_PBCQ_SPCI_ASB_ADDR      0x0
> +#define PHB3_PBCQ_SPCI_ASB_DATA      0x2
> +
> +/* Index of PNV_CHIP_POWER10 in pnv_chips[] within "pnv-xscom.h" */
> +#define PNV_P10_CHIP_INDEX      3

Where is this being used and do we really need it?

> +#define PHB4_XSCOM              0x40084800ull
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
> +    qtest_writeq(qts, pnv_xscom_addr(chip, (scom >> 3) + indirect_addr), reg);

What does bit shift 3 signify here, can we have a self explanatory macro 
for this?

> +    return qtest_readq(qts, pnv_xscom_addr(chip, (scom >> 3) + indirect_data));
> +}
> +
> +/* Assert that 'PHB - Version Register' bits[24:31] are as expected */
> +static void phb_version_test(const void *data)
> +{
> +    const PnvChip *chip = (PnvChip *)data;
> +    QTestState *qts;
> +    const char *machine = "powernv8";
> +    uint64_t phb_xscom = 0x4809e000;
> +    uint64_t reg_phb_version = PHB_VERSION;
> +    uint32_t indirect_addr = PHB3_PBCQ_SPCI_ASB_ADDR;
> +    uint32_t indirect_data = PHB3_PBCQ_SPCI_ASB_DATA;
> +    uint32_t expected_ver = 0xA3;
> +    uint64_t ver;
> +
> +    if (chip->chip_type == PNV_CHIP_POWER9) {
> +        machine = "powernv9";
> +        phb_xscom = 0x68084800;
> +        indirect_addr = PHB_SCOM_HV_IND_ADDR;
> +        indirect_data = PHB_SCOM_HV_IND_DATA;
> +        reg_phb_version |= PPC_BIT(0);
> +        expected_ver = 0xA4;
> +    } else if (chip->chip_type == PNV_CHIP_POWER10) {

What about POWER11? Also, could the check be based on PHB type supported
(need new attribute?) so that we dont need to add checks for every next
PnvChip->chip_type which supports the existing PHB type?

> +        machine = "powernv10";
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
> +    ver = ver >> (63 - 31);

It is always preferable to mask the remaining bits before extracting.

> +    g_assert_cmpuint(ver, ==, expected_ver);
> +
> +    qtest_quit(qts);
> +}
> +
> +/* Verify versions of all supported PHB's */
> +static void add_phbX_version_test(void)
> +{
> +    for (int i = 0; i < ARRAY_SIZE(pnv_chips); i++) {
> +        char *tname = g_strdup_printf("pnv-phb/%s",
> +                                      pnv_chips[i].cpu_model);
> +        qtest_add_data_func(tname, &pnv_chips[i], phb_version_test);
> +        g_free(tname);
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


