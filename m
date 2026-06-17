Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F5B6CD98EE
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 06:23:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZjfy-0001uL-AX; Wed, 17 Jun 2026 02:23:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.ibm.com>)
 id 1wZjFB-0003u0-OC; Wed, 17 Jun 2026 01:55:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.ibm.com>)
 id 1wZjF9-00070s-6K; Wed, 17 Jun 2026 01:55:21 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GLn6ch2895340; Wed, 17 Jun 2026 05:55:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=LxX8Y19oKCVD2SLmRY/e64YjUIpLq/
 IRzSL+7OYQeE0=; b=Y5Yc3LTO4aS7dkSxK96oiXAJgaRpmwXXb8+KcKHSx3vVzA
 KARpC2OFPZl1yWMCKbnm5dGMsyN1Qqmk0zU9ova9WDe6oO2jD7OxEGwNyLaPBhsd
 hkKx7GTdUpw3sFt9tK6ZRKm5G9cweTxb6ER0HcP57UePMlqZd+2Obm6Vdbf2zAoC
 tQc/hoPYjE70urYl0gdjNs1+QqStIB66rCtniejXR7xpkAzib1JEEYpOt02yvOCX
 1Kw2245fdU3E2O/baXHbzHtGSpU2eLuX6rblIjYTGKD3S0DxDYzGWhOdRTkjakrI
 afwfR+wjR3h500TewS5Cdaf/k1kLQ1S+cgSndd/w==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4euequ1dvm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jun 2026 05:55:06 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65H5nc4T030020;
 Wed, 17 Jun 2026 05:55:05 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eudva9qcq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jun 2026 05:55:05 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65H5t2Gl7471778
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jun 2026 05:55:03 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D6EB658064;
 Wed, 17 Jun 2026 05:55:02 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8A08B58056;
 Wed, 17 Jun 2026 05:54:55 +0000 (GMT)
Received: from [9.43.52.172] (unknown [9.43.52.172])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 17 Jun 2026 05:54:55 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------jKccWE9fJ6LvFeqP9TmJXlzP"
Message-ID: <cc5239b4-e4ff-456d-9db8-23df55e2faf7@linux.ibm.com>
Date: Wed, 17 Jun 2026 11:24:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/9] qtest/phb4: Add testbench for PHB4
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
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
 <a772b506-e306-4fef-a357-3f25374b7354@linux.ibm.com>
Content-Language: en-US
From: Saif Abrar <saif.abrar@linux.ibm.com>
In-Reply-To: <a772b506-e306-4fef-a357-3f25374b7354@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDA1MSBTYWx0ZWRfX8835IGC+gbKv
 Hx+4gjPMFmZ2lDry111Zr6HHiWICiwg6/7SwBHu5JEH27mHlaYpF4V3CoSZVlhDaItZVBxkcIW2
 9wak8CXTLiTlypKp1XNuw2sgc4ypvMs=
X-Proofpoint-ORIG-GUID: rKxS6I2HWY45c1X9aGlZkqHaoDrcqh5I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDA1MSBTYWx0ZWRfX8uEc9YYshv79
 jJfAibD5Sg1dnVBpPogw0IZG4MH7EiOgL0puFPhgIJz6m4nP96K1kqYxm0KLtH4y6nDuPf2xX64
 hML4f7CH7n5N49zVqK82dArf9qO8lrao8D/AnX8HruHO4Xx3/+krG+1f81BZlHjayndzoDwdz9O
 7UZH/N0/uu3sDzelFrC1fIwVM3qFguoWy2YvOP7sm20dcUrkBmbS+ZTmuUQAvDNb3jzHcNYJNdI
 4hvgWgFwFfdJWTeON5ciZ3Y3MEy5k/2HuYXWMFUSuB4SGhwOhJzUw0zILsh/v+mFYaAMLseHfpJ
 nKY7AuvzTmrxTjdUeSTQesrng+SN0PaMOKNAkpur3bFZavz6WVyPpLB47YqvZQyMvb8vTlfxOqu
 9OBfIlqDAi3Nl7FiY/sHriBMyQZ4pxeBAO4p55HD38LE0GLPototJYdgjUApPu7UUxbPBSmWYXK
 FneDIfhOKeRS1XiY7UQ==
X-Proofpoint-GUID: RV7GhyJ8Iik8bO_lcKvralIDqwzW3EvL
X-Authority-Analysis: v=2.4 cv=L9gtheT8 c=1 sm=1 tr=0 ts=6a3236bb cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=r77TgQKjGQsHNAKrUKIA:9 a=VnNF1IyMAAAA:8
 a=aow-egSQAAAA:8 a=j2bEz6JK-_-10P5Y8ywA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PrhnCPEB6Ue097zCAmMA:9 a=_P4aAJQNgKZvbp30:21 a=_W_S_7VecoQA:10
 a=lqcHg5cX4UMA:10 a=gFNbaldVC-z-bsjSTzMo:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1011 adultscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170051
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=saif.abrar@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 17 Jun 2026 02:22:58 -0400
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
--------------jKccWE9fJ6LvFeqP9TmJXlzP
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 01-05-2026 19:29, Harsh Prateek Bora wrote:
> <Adding folks working in this area or who might be interested in it>
>
> On 05/03/26 11:39 am, Saif Abrar wrote:
>> New qtest testbench added for PHB[345].
>> Testbench reads PHB Version register and asserts that
>> bits[24:31] have value 0xA3, 0xA4 and 0xA5 respectively.
>>
>> Signed-off-by: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
>> Reviewed-by: Cédric Le Goater <clg@kaod.org>
>> ---
>> v3: Updates for coding guidelines.
>> v2: Added version check for PHB3 and PHB4 also.
>>
>>   tests/qtest/meson.build     |  1 +
>>   tests/qtest/pnv-phb4-test.c | 98 +++++++++++++++++++++++++++++++++++++
>>   2 files changed, 99 insertions(+)
>>   create mode 100644 tests/qtest/pnv-phb4-test.c
>>
>> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
>> index ba9f59d2f8..030f3f4fc6 100644
>> --- a/tests/qtest/meson.build
>> +++ b/tests/qtest/meson.build
>> @@ -182,6 +182,7 @@ qtests_ppc64 = \
>>     (config_all_devices.has_key('CONFIG_POWERNV') ? 
>> ['pnv-xive2-test'] : []) +                 \
>>     (config_all_devices.has_key('CONFIG_POWERNV') ? 
>> ['pnv-spi-seeprom-test'] : []) +           \
>>     (config_all_devices.has_key('CONFIG_POWERNV') ? 
>> ['pnv-host-i2c-test'] : []) +              \
>> +  (config_all_devices.has_key('CONFIG_POWERNV') ? ['pnv-phb4-test'] 
>> : []) +                  \
>
> Should we just call it pnv-phb-test as it takes care of all PHB 3/4/5.


Renamed to 'pnv-phb-test'.


>
> Also, need to audit all the patches whether to keep the naming as just 
> phb or phb{3,4,5} as applicable.
>
>
>> (config_all_devices.has_key('CONFIG_PSERIES') ? ['numa-test'] : []) 
>> +                      \
>>     (config_all_devices.has_key('CONFIG_PSERIES') ? ['rtas-test'] : 
>> []) +                      \
>>     (slirp.found() ? ['pxe-test'] : []) +              \
>> diff --git a/tests/qtest/pnv-phb4-test.c b/tests/qtest/pnv-phb4-test.c
>> new file mode 100644
>> index 0000000000..797f6b6c87
>> --- /dev/null
>> +++ b/tests/qtest/pnv-phb4-test.c
>> @@ -0,0 +1,98 @@
>> +/*
>> + * QTest testcase for PowerNV PHB4
>> + *
>> + * Copyright (c) 2025, IBM Corporation.
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + *
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "libqtest.h"
>> +#include "hw/pci-host/pnv_phb4_regs.h"
>> +#include "pnv-xscom.h"
>> +
>> +#define PPC_BIT(bit)            (0x8000000000000000ULL >> (bit))
>> +#define PPC_BITMASK(bs, be)     ((PPC_BIT(bs) - PPC_BIT(be)) | 
>> PPC_BIT(bs))
>
> Looks like we already have 2 files in tests/qtest folder which 
> contains these macros. Time to cleanup common code into a common header ?


Common code moved to a new common header file 
'tests/qtest/pnv-qtest-common.h'.


>> +
>> +#define PHB3_PBCQ_SPCI_ASB_ADDR      0x0
>> +#define PHB3_PBCQ_SPCI_ASB_DATA      0x2
>> +
>> +/* Index of PNV_CHIP_POWER10 in pnv_chips[] within "pnv-xscom.h" */
>> +#define PNV_P10_CHIP_INDEX      3
>
> Where is this being used and do we really need it?


Removed, not used in this patch.


>
>> +#define PHB4_XSCOM 0x40084800ull
>> +
>> +/*
>> + * Indirect XSCOM read::
>> + * - Write 'Indirect Address Register' with register-offset to read.
>> + * - Read 'Indirect Data Register' to get the value.
>> + */
>> +static uint64_t pnv_phb_xscom_read(QTestState *qts, const PnvChip 
>> *chip,
>> +        uint64_t scom, uint32_t indirect_addr, uint32_t indirect_data,
>> +        uint64_t reg)
>> +{
>> +    qtest_writeq(qts, pnv_xscom_addr(chip, (scom >> 3) + 
>> indirect_addr), reg);
>
> What does bit shift 3 signify here, can we have a self explanatory 
> macro for this?


Added a macro for SCOM to PCBA address conversion.

>
>> +    return qtest_readq(qts, pnv_xscom_addr(chip, (scom >> 3) + 
>> indirect_data));
>> +}
>> +
>> +/* Assert that 'PHB - Version Register' bits[24:31] are as expected */
>> +static void phb_version_test(const void *data)
>> +{
>> +    const PnvChip *chip = (PnvChip *)data;
>> +    QTestState *qts;
>> +    const char *machine = "powernv8";
>> +    uint64_t phb_xscom = 0x4809e000;
>> +    uint64_t reg_phb_version = PHB_VERSION;
>> +    uint32_t indirect_addr = PHB3_PBCQ_SPCI_ASB_ADDR;
>> +    uint32_t indirect_data = PHB3_PBCQ_SPCI_ASB_DATA;
>> +    uint32_t expected_ver = 0xA3;
>> +    uint64_t ver;
>> +
>> +    if (chip->chip_type == PNV_CHIP_POWER9) {
>> +        machine = "powernv9";
>> +        phb_xscom = 0x68084800;
>> +        indirect_addr = PHB_SCOM_HV_IND_ADDR;
>> +        indirect_data = PHB_SCOM_HV_IND_DATA;
>> +        reg_phb_version |= PPC_BIT(0);
>> +        expected_ver = 0xA4;
>> +    } else if (chip->chip_type == PNV_CHIP_POWER10) {
>
> What about POWER11? Also, could the check be based on PHB type supported
> (need new attribute?) so that we dont need to add checks for every next
> PnvChip->chip_type which supports the existing PHB type?


POWER11 used the same PHB5 as POWER10.

If it's decided then the new attribute can be added in future in a new 
patchset.


>
>> +        machine = "powernv10";
>> +        phb_xscom = PHB4_XSCOM;
>> +        indirect_addr = PHB_SCOM_HV_IND_ADDR;
>> +        indirect_data = PHB_SCOM_HV_IND_DATA;
>> +        reg_phb_version |= PPC_BIT(0);
>> +        expected_ver = 0xA5;
>> +    }
>> +
>> +    qts = qtest_initf("-M %s -accel tcg -cpu %s", machine, 
>> chip->cpu_model);
>> +
>> +    ver = pnv_phb_xscom_read(qts, chip, phb_xscom,
>> +                                indirect_addr, indirect_data, 
>> reg_phb_version);
>> +
>> +    /* PHB Version register bits [24:31] */
>> +    ver = ver >> (63 - 31);
>
> It is always preferable to mask the remaining bits before extracting.


Updated.


>
>> +    g_assert_cmpuint(ver, ==, expected_ver);
>> +
>> +    qtest_quit(qts);
>> +}
>> +
>> +/* Verify versions of all supported PHB's */
>> +static void add_phbX_version_test(void)
>> +{
>> +    for (int i = 0; i < ARRAY_SIZE(pnv_chips); i++) {
>> +        char *tname = g_strdup_printf("pnv-phb/%s",
>> +                                      pnv_chips[i].cpu_model);
>> +        qtest_add_data_func(tname, &pnv_chips[i], phb_version_test);
>> +        g_free(tname);
>> +    }
>> +}
>> +
>> +int main(int argc, char **argv)
>> +{
>> +    g_test_init(&argc, &argv, NULL);
>> +
>> +    /* PHB[345] tests */
>> +    add_phbX_version_test();
>> +
>> +    return g_test_run();
>> +}
>
--------------jKccWE9fJ6LvFeqP9TmJXlzP
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 01-05-2026 19:29, Harsh Prateek Bora
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:a772b506-e306-4fef-a357-3f25374b7354@linux.ibm.com">&lt;Adding
      folks working in this area or who might be interested in it&gt;
      <br>
      <br>
      On 05/03/26 11:39 am, Saif Abrar wrote:
      <br>
      <blockquote type="cite">New qtest testbench added for PHB[345].
        <br>
        Testbench reads PHB Version register and asserts that
        <br>
        bits[24:31] have value 0xA3, 0xA4 and 0xA5 respectively.
        <br>
        <br>
        Signed-off-by: Saif Abrar <a class="moz-txt-link-rfc2396E" href="mailto:saif.abrar@linux.vnet.ibm.com">&lt;saif.abrar@linux.vnet.ibm.com&gt;</a>
        <br>
        Reviewed-by: Cédric Le Goater <a class="moz-txt-link-rfc2396E" href="mailto:clg@kaod.org">&lt;clg@kaod.org&gt;</a>
        <br>
        ---
        <br>
        v3: Updates for coding guidelines.
        <br>
        v2: Added version check for PHB3 and PHB4 also.
        <br>
        <br>
          tests/qtest/meson.build     |  1 +
        <br>
          tests/qtest/pnv-phb4-test.c | 98
        +++++++++++++++++++++++++++++++++++++
        <br>
          2 files changed, 99 insertions(+)
        <br>
          create mode 100644 tests/qtest/pnv-phb4-test.c
        <br>
        <br>
        diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
        <br>
        index ba9f59d2f8..030f3f4fc6 100644
        <br>
        --- a/tests/qtest/meson.build
        <br>
        +++ b/tests/qtest/meson.build
        <br>
        @@ -182,6 +182,7 @@ qtests_ppc64 = \
        <br>
            (config_all_devices.has_key('CONFIG_POWERNV') ?
        ['pnv-xive2-test'] : []) +                 \
        <br>
            (config_all_devices.has_key('CONFIG_POWERNV') ?
        ['pnv-spi-seeprom-test'] : []) +           \
        <br>
            (config_all_devices.has_key('CONFIG_POWERNV') ?
        ['pnv-host-i2c-test'] : []) +              \
        <br>
        +  (config_all_devices.has_key('CONFIG_POWERNV') ?
        ['pnv-phb4-test'] : []) +                  \
        <br>
      </blockquote>
      <br>
      Should we just call it pnv-phb-test as it takes care of all PHB
      3/4/5.
      <br>
    </blockquote>
    <p><br>
    </p>
    <p>Renamed to 'pnv-phb-test'.</p>
    <p><br>
    </p>
    <blockquote type="cite"
      cite="mid:a772b506-e306-4fef-a357-3f25374b7354@linux.ibm.com"><br>
      Also, need to audit all the patches whether to keep the naming as
      just phb or phb{3,4,5} as applicable.
      <br>
      <br>
      <br>
      <blockquote type="cite">   
        (config_all_devices.has_key('CONFIG_PSERIES') ? ['numa-test'] :
        []) +                      \
        <br>
            (config_all_devices.has_key('CONFIG_PSERIES') ?
        ['rtas-test'] : []) +                      \
        <br>
            (slirp.found() ? ['pxe-test'] : []) +              \
        <br>
        diff --git a/tests/qtest/pnv-phb4-test.c
        b/tests/qtest/pnv-phb4-test.c
        <br>
        new file mode 100644
        <br>
        index 0000000000..797f6b6c87
        <br>
        --- /dev/null
        <br>
        +++ b/tests/qtest/pnv-phb4-test.c
        <br>
        @@ -0,0 +1,98 @@
        <br>
        +/*
        <br>
        + * QTest testcase for PowerNV PHB4
        <br>
        + *
        <br>
        + * Copyright (c) 2025, IBM Corporation.
        <br>
        + *
        <br>
        + * SPDX-License-Identifier: GPL-2.0-or-later
        <br>
        + *
        <br>
        + */
        <br>
        +
        <br>
        +#include "qemu/osdep.h"
        <br>
        +#include "libqtest.h"
        <br>
        +#include "hw/pci-host/pnv_phb4_regs.h"
        <br>
        +#include "pnv-xscom.h"
        <br>
        +
        <br>
        +#define PPC_BIT(bit)            (0x8000000000000000ULL &gt;&gt;
        (bit))
        <br>
        +#define PPC_BITMASK(bs, be)     ((PPC_BIT(bs) - PPC_BIT(be)) |
        PPC_BIT(bs))
        <br>
      </blockquote>
      <br>
      Looks like we already have 2 files in tests/qtest folder which
      contains these macros. Time to cleanup common code into a common
      header ?
      <br>
    </blockquote>
    <p><br>
    </p>
    <p>Common code moved to a new common header file '<span
      style="white-space: pre-wrap">tests/qtest/pnv-qtest-common.h'.</span></p>
    <p><br>
    </p>
    <blockquote type="cite"
      cite="mid:a772b506-e306-4fef-a357-3f25374b7354@linux.ibm.com">
      <blockquote type="cite">+
        <br>
        +#define PHB3_PBCQ_SPCI_ASB_ADDR      0x0
        <br>
        +#define PHB3_PBCQ_SPCI_ASB_DATA      0x2
        <br>
        +
        <br>
        +/* Index of PNV_CHIP_POWER10 in pnv_chips[] within
        "pnv-xscom.h" */
        <br>
        +#define PNV_P10_CHIP_INDEX      3
        <br>
      </blockquote>
      <br>
      Where is this being used and do we really need it?
      <br>
    </blockquote>
    <p><br>
    </p>
    <p>Removed, not used in this patch.</p>
    <p><br>
    </p>
    <blockquote type="cite"
      cite="mid:a772b506-e306-4fef-a357-3f25374b7354@linux.ibm.com"><br>
      <blockquote type="cite">+#define PHB4_XSCOM             
        0x40084800ull
        <br>
        +
        <br>
        +/*
        <br>
        + * Indirect XSCOM read::
        <br>
        + * - Write 'Indirect Address Register' with register-offset to
        read.
        <br>
        + * - Read 'Indirect Data Register' to get the value.
        <br>
        + */
        <br>
        +static uint64_t pnv_phb_xscom_read(QTestState *qts, const
        PnvChip *chip,
        <br>
        +        uint64_t scom, uint32_t indirect_addr, uint32_t
        indirect_data,
        <br>
        +        uint64_t reg)
        <br>
        +{
        <br>
        +    qtest_writeq(qts, pnv_xscom_addr(chip, (scom &gt;&gt; 3) +
        indirect_addr), reg);
        <br>
      </blockquote>
      <br>
      What does bit shift 3 signify here, can we have a self explanatory
      macro for this?
      <br>
    </blockquote>
    <p><br>
    </p>
    <p>Added a macro for <span style="white-space: pre-wrap">SCOM to PCBA address conversion.</span></p>
    <p><span style="white-space: pre-wrap">
</span></p>
    <blockquote type="cite"
      cite="mid:a772b506-e306-4fef-a357-3f25374b7354@linux.ibm.com"><br>
      <blockquote type="cite">+    return qtest_readq(qts,
        pnv_xscom_addr(chip, (scom &gt;&gt; 3) + indirect_data));
        <br>
        +}
        <br>
        +
        <br>
        +/* Assert that 'PHB - Version Register' bits[24:31] are as
        expected */
        <br>
        +static void phb_version_test(const void *data)
        <br>
        +{
        <br>
        +    const PnvChip *chip = (PnvChip *)data;
        <br>
        +    QTestState *qts;
        <br>
        +    const char *machine = "powernv8";
        <br>
        +    uint64_t phb_xscom = 0x4809e000;
        <br>
        +    uint64_t reg_phb_version = PHB_VERSION;
        <br>
        +    uint32_t indirect_addr = PHB3_PBCQ_SPCI_ASB_ADDR;
        <br>
        +    uint32_t indirect_data = PHB3_PBCQ_SPCI_ASB_DATA;
        <br>
        +    uint32_t expected_ver = 0xA3;
        <br>
        +    uint64_t ver;
        <br>
        +
        <br>
        +    if (chip-&gt;chip_type == PNV_CHIP_POWER9) {
        <br>
        +        machine = "powernv9";
        <br>
        +        phb_xscom = 0x68084800;
        <br>
        +        indirect_addr = PHB_SCOM_HV_IND_ADDR;
        <br>
        +        indirect_data = PHB_SCOM_HV_IND_DATA;
        <br>
        +        reg_phb_version |= PPC_BIT(0);
        <br>
        +        expected_ver = 0xA4;
        <br>
        +    } else if (chip-&gt;chip_type == PNV_CHIP_POWER10) {
        <br>
      </blockquote>
      <br>
      What about POWER11? Also, could the check be based on PHB type
      supported
      <br>
      (need new attribute?) so that we dont need to add checks for every
      next
      <br>
      PnvChip-&gt;chip_type which supports the existing PHB type?
      <br>
    </blockquote>
    <p><br>
    </p>
    <p>POWER11 used the same PHB5 as POWER10.</p>
    <p>If it's decided then the new attribute can be added in future in
      a new patchset.</p>
    <p><br>
    </p>
    <blockquote type="cite"
      cite="mid:a772b506-e306-4fef-a357-3f25374b7354@linux.ibm.com"><br>
      <blockquote type="cite">+        machine = "powernv10";
        <br>
        +        phb_xscom = PHB4_XSCOM;
        <br>
        +        indirect_addr = PHB_SCOM_HV_IND_ADDR;
        <br>
        +        indirect_data = PHB_SCOM_HV_IND_DATA;
        <br>
        +        reg_phb_version |= PPC_BIT(0);
        <br>
        +        expected_ver = 0xA5;
        <br>
        +    }
        <br>
        +
        <br>
        +    qts = qtest_initf("-M %s -accel tcg -cpu %s", machine,
        chip-&gt;cpu_model);
        <br>
        +
        <br>
        +    ver = pnv_phb_xscom_read(qts, chip, phb_xscom,
        <br>
        +                                indirect_addr, indirect_data,
        reg_phb_version);
        <br>
        +
        <br>
        +    /* PHB Version register bits [24:31] */
        <br>
        +    ver = ver &gt;&gt; (63 - 31);
        <br>
      </blockquote>
      <br>
      It is always preferable to mask the remaining bits before
      extracting.
      <br>
    </blockquote>
    <p><br>
    </p>
    <p>Updated.</p>
    <p><br>
    </p>
    <blockquote type="cite"
      cite="mid:a772b506-e306-4fef-a357-3f25374b7354@linux.ibm.com"><br>
      <blockquote type="cite">+    g_assert_cmpuint(ver, ==,
        expected_ver);
        <br>
        +
        <br>
        +    qtest_quit(qts);
        <br>
        +}
        <br>
        +
        <br>
        +/* Verify versions of all supported PHB's */
        <br>
        +static void add_phbX_version_test(void)
        <br>
        +{
        <br>
        +    for (int i = 0; i &lt; ARRAY_SIZE(pnv_chips); i++) {
        <br>
        +        char *tname = g_strdup_printf("pnv-phb/%s",
        <br>
        +                                      pnv_chips[i].cpu_model);
        <br>
        +        qtest_add_data_func(tname, &amp;pnv_chips[i],
        phb_version_test);
        <br>
        +        g_free(tname);
        <br>
        +    }
        <br>
        +}
        <br>
        +
        <br>
        +int main(int argc, char **argv)
        <br>
        +{
        <br>
        +    g_test_init(&amp;argc, &amp;argv, NULL);
        <br>
        +
        <br>
        +    /* PHB[345] tests */
        <br>
        +    add_phbX_version_test();
        <br>
        +
        <br>
        +    return g_test_run();
        <br>
        +}
        <br>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>

--------------jKccWE9fJ6LvFeqP9TmJXlzP--


