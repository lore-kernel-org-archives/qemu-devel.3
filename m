Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A70F3E677F5
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2024 14:02:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7EhC-0003PU-9x; Sat, 02 Nov 2024 10:01:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1t7EhA-0003PB-D3; Sat, 02 Nov 2024 10:01:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1t7Eh6-0005KO-JE; Sat, 02 Nov 2024 10:01:40 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A2DrpaO004375;
 Sat, 2 Nov 2024 14:01:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=G8L+6r
 AzMRnmSWa26lZx36/kLEK9y1X3vVyDqADiDaY=; b=ANgCIAVwoqIstzoZZ6pRe+
 Tb2t21uhrC8ozllywBpj0XiAch2E8F3JbW5Rffpay6/tF10f4wcj+nO2fwETmbf+
 2ZYfZ1pVvE0U98mIAWG4ylBtkqWeYzW9dYNbFtIaiR7qexAg4ZfYtHf1hp59ft4d
 pgWUnthlkIGpRW2jsUy0FECOJ9vXrg8FIfV92NoiQbAtrSWvRfvs3s3JLCHwoLgj
 zBHqFGX/nLxYO/AVR8Z1ZOpFVDENJyMEJBWmQ+h/9pqCfDg48+7jsENFSHprhpk+
 3f6IGW2RL2AwxL6LM84ILHHYyIjQCxvoV6+txiDjGZ4UpFM3oIHlVrwmNrwRo/rA
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42nmce84mg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 02 Nov 2024 14:01:27 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A2B6BXq006365;
 Sat, 2 Nov 2024 14:01:25 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42njvb84xy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 02 Nov 2024 14:01:25 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4A2E1PqS30671288
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 2 Nov 2024 14:01:25 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 29D7058056;
 Sat,  2 Nov 2024 14:01:25 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7FB3F58052;
 Sat,  2 Nov 2024 14:01:24 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Sat,  2 Nov 2024 14:01:24 +0000 (GMT)
Message-ID: <823dbf7d-f33b-4c3f-80fa-e4e9230166ee@linux.ibm.com>
Date: Sat, 2 Nov 2024 10:01:24 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] tests/qtest/tpm: add unit test to tis-spi
To: dan tan <dantan@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, stefanb@linux.vnet.ibm.com, pbonzini@redhat.com,
 farosas@suse.de, lvivier@redhat.com, clg@kaod.org
References: <20241101202727.9023-1-dantan@linux.vnet.ibm.com>
 <20241101202727.9023-4-dantan@linux.vnet.ibm.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20241101202727.9023-4-dantan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -hDeiJkKepdZRQanEYz_DKgNQMcQ8MWC
X-Proofpoint-ORIG-GUID: -hDeiJkKepdZRQanEYz_DKgNQMcQ8MWC
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999
 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411020121
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 11/1/24 4:27 PM, dan tan wrote:
> Add qtest cases to exercise main TPM locality functionality

It's not just locality. -> main TPM functionality.

> The TPM device emulation is provided by swtpm, which is TCG
> TPM 2.0, and TCG TPM TIS compliant. See
> https://trustedcomputinggroup.org/wp-content/uploads/TCG_PC_Client_Platform_TPM_Profile_PTP_2.0_r1.03_v22.pdf
> https://trustedcomputinggroup.org/wp-content/uploads/TCG_PCClientTPMInterfaceSpecification_TIS__1-3_27_03212013.pdf
> The SPI registers are specific to the PowerNV platform
> architecture
> 
> tests/qtest/tpm: add unit test to tis-spi (rev 4)

This looks like the title of previous 5/5. Remove it.

> 
> - removed the function prototypes declaration
> - fixed code format to comply with convention
> - changed function names and variable names to be the same
>    as the tpm-tis-i2c test.
> - change hard coded numbers to #define's with meaningful
>    names that are identifiable with spec documentation
> 
> Signed-off-by: dan tan <dantan@linux.vnet.ibm.com>

Put the above here below three dashes:

---

v3:
  - removed the function prototypes declaration
  - fixed code format to comply with convention
  - changed function names and variable names to be the same
     as the tpm-tis-i2c test.
  - change hard coded numbers to #define's with meaningful
     names that are identifiable with spec documentation


> ---
>   tests/qtest/tpm-tis-spi-pnv-test.c | 710 +++++++++++++++++++++++++++++
>   tests/qtest/meson.build            |   2 +
>   2 files changed, 712 insertions(+)
>   create mode 100644 tests/qtest/tpm-tis-spi-pnv-test.c
> 
> diff --git a/tests/qtest/tpm-tis-spi-pnv-test.c b/tests/qtest/tpm-tis-spi-pnv-test.c
> new file mode 100644
> index 0000000000..2d6e1186cf
> --- /dev/null
> +++ b/tests/qtest/tpm-tis-spi-pnv-test.c
> @@ -0,0 +1,710 @@
> +/*
> + * QTest testcase for a Nuvoton NPCT75x TPM SPI device
> + *                      running on the PowerNV machine.
 > + *> + * Copyright (c) 2024, IBM Corporation.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#include "qemu/osdep.h"
> +#include <glib/gstdio.h>
> +#include "libqtest-single.h"
> +#include "hw/acpi/tpm.h"
> +#include "hw/pci/pci_ids.h"
> +#include "qtest_aspeed.h"
> +#include "tpm-emu.h"
> +#include "hw/ssi/pnv_spi_regs.h"
> +#include "pnv-xscom.h"
> +
> +#define SPI_TPM_BASE            0xc0080
> +#define SPI_SHIFT_COUNTER_N1    0x30000000
> +#define SPI_SHIFT_COUNTER_N2    0x40000000
> +#define SPI_RWX_OPCODE_SHIFT    56
> +#define SPI_RWX_ADDR_SHIFT      32
> +#define SPI_CMD_DATA_SHIFT      56
> +
> +#define CFG_COUNT_COMPARE_1     0x0000000200000000
> +#define MM_REG_RDR_MATCH        0x00000000ff01ff00
> +#define SEQ_OP_REG_BASIC        0x1134416200100000
> +
> +#define TPM_TIS_8BITS_MASK      0xff
> +#define SPI_TPM_TIS_ADDR        0xd40000
> +#define SPI_EXTEND              0x03
> +#define TPM_WRITE_OP            0x0
> +#define TPM_READ_OP             0x80
> +
> +#define SHORT_MAX_RETRIES       5
> +#define LONG_MAX_RETRIES        10
> +
> +static const uint8_t TPM_CMD[12] =
> +                     "\x80\x01\x00\x00\x00\x0c\x00\x00\x01\x44\x00\x00";
> +
> +#define DPRINTF(fmt, ...) do { \
> +    if (DEBUG_TIS_TEST) { \
> +        printf(fmt, ## __VA_ARGS__); \
> +    } \
> +} while (0)
> +
> +#define DEBUG_TIS_TEST 0
> +
> +#define DPRINTF_ACCESS \
> +    DPRINTF("%s: %d: locty=%d l=%d access=0x%02x pending_request_flag=0x%x\n", \
> +            __func__, __LINE__, locty, l, access, pending_request_flag)
> +
> +#define DPRINTF_STS \
> +    DPRINTF("%s: %d: sts = 0x%08x\n", __func__, __LINE__, sts)
> +
> +static uint64_t pnv_spi_tpm_read(const PnvChip *chip, uint32_t reg)
> +{
> +    uint32_t pcba = SPI_TPM_BASE + reg;
> +
> +    return qtest_readq(global_qtest, pnv_xscom_addr(chip, pcba));
> +}
> +
> +static void pnv_spi_tpm_write(const PnvChip *chip,
> +                              uint32_t reg,
> +                              uint64_t val)
> +{
> +    uint32_t pcba = SPI_TPM_BASE + reg;
> +
> +    qtest_writeq(global_qtest, pnv_xscom_addr(chip, pcba), val);
> +}
> +
> +static void spi_op_complete(const PnvChip *chip)
> +{
> +    uint64_t cfg_reg;
> +
> +    cfg_reg = pnv_spi_tpm_read(chip, SPI_CLK_CFG_REG);
> +    g_assert_cmpuint(CFG_COUNT_COMPARE_1, ==, cfg_reg);
> +    pnv_spi_tpm_write(chip, SPI_CLK_CFG_REG, 0);
> +}
> +
> +static void spi_write_reg(const PnvChip *chip, uint64_t val)
> +{
> +    int i;
> +    uint64_t spi_sts;
> +
> +    for (i = 0; i < LONG_MAX_RETRIES; i++) {
> +        spi_sts = pnv_spi_tpm_read(chip, SPI_STS_REG);
> +        if (GETFIELD(SPI_STS_TDR_FULL, spi_sts) == 1) {
> +            sleep(0.5);
> +        } else {
> +            break;
> +        }
> +    }
> +    /* cannot write if SPI_STS_TDR_FULL bit is still set */
> +    g_assert_cmpuint(0, ==, GETFIELD(SPI_STS_TDR_FULL, spi_sts));
> +    pnv_spi_tpm_write(chip, SPI_XMIT_DATA_REG, val);
> +
> +    for (i = 0; i < SHORT_MAX_RETRIES; i++) {
> +        spi_sts = pnv_spi_tpm_read(chip, SPI_STS_REG);
> +        if (GETFIELD(SPI_STS_SHIFTER_FSM, spi_sts) & FSM_DONE) {
> +            break;
> +        } else {
> +            sleep(0.1);
> +        }
> +    }
> +    /* it should be done given the amount of time */
> +    g_assert_cmpuint(0, ==, GETFIELD(SPI_STS_SHIFTER_FSM, spi_sts) & FSM_DONE);
> +    spi_op_complete(chip);
> +}
> +
> +static uint64_t spi_read_reg(const PnvChip *chip)
> +{
> +    int i;
> +    uint64_t spi_sts, val = 0;
> +
> +    for (i = 0; i < LONG_MAX_RETRIES; i++) {
> +        spi_sts = pnv_spi_tpm_read(chip, SPI_STS_REG);
> +        if (GETFIELD(SPI_STS_RDR_FULL, spi_sts) == 1) {
> +            val = pnv_spi_tpm_read(chip, SPI_RCV_DATA_REG);
> +            break;
> +        }
> +        sleep(0.5);
> +    }
> +    for (i = 0; i < SHORT_MAX_RETRIES; i++) {
> +        spi_sts = pnv_spi_tpm_read(chip, SPI_STS_REG);
> +        if (GETFIELD(SPI_STS_RDR_FULL, spi_sts) == 1) {
> +            sleep(0.1);
> +        } else {
> +            break;
> +        }
> +    }
> +    /* SPI_STS_RDR_FULL bit should be reset after read */
> +    g_assert_cmpuint(0, ==, GETFIELD(SPI_STS_RDR_FULL, spi_sts));
> +    spi_op_complete(chip);
> +    return val;
> +}
> +
> +static void spi_access_start(const PnvChip *chip,
> +                             bool n2,
> +                             uint8_t bytes,
> +                             uint8_t tpm_op,
> +                             uint32_t tpm_reg)
> +{
> +    uint64_t cfg_reg;
> +    uint64_t reg_op;
> +    uint64_t seq_op = SEQ_OP_REG_BASIC;
> +
> +    cfg_reg = pnv_spi_tpm_read(chip, SPI_CLK_CFG_REG);
> +    if (cfg_reg != CFG_COUNT_COMPARE_1) {
> +        pnv_spi_tpm_write(chip, SPI_CLK_CFG_REG, CFG_COUNT_COMPARE_1);
> +    }
> +    /* bytes - sequencer operation register bits 24:31 */
> +    if (n2) {
> +        seq_op |= SPI_SHIFT_COUNTER_N2 | (bytes << 0x18);
> +    } else {
> +        seq_op |= SPI_SHIFT_COUNTER_N1 | (bytes << 0x18);
> +    }
> +    pnv_spi_tpm_write(chip, SPI_SEQ_OP_REG, seq_op);
> +    pnv_spi_tpm_write(chip, SPI_MM_REG, MM_REG_RDR_MATCH);
> +    pnv_spi_tpm_write(chip, SPI_CTR_CFG_REG, (uint64_t)0);
> +    reg_op = ((uint64_t)tpm_op << SPI_RWX_OPCODE_SHIFT) |
> +             ((uint64_t)tpm_reg << SPI_RWX_ADDR_SHIFT);
> +    pnv_spi_tpm_write(chip, SPI_XMIT_DATA_REG, reg_op);
> +}
> +
> +static inline void tpm_reg_writeb(const PnvChip *c,
> +                                  uint8_t locty,
> +                                  uint8_t reg,
 > +                                  uint8_t val)> +{
> +    uint32_t tpm_reg_locty = SPI_TPM_TIS_ADDR |
> +                             (locty << TPM_TIS_LOCALITY_SHIFT);
> +
> +    spi_access_start(c, false, 1, TPM_WRITE_OP, tpm_reg_locty | reg);
> +    spi_write_reg(c, (uint64_t) val << SPI_CMD_DATA_SHIFT);
> +}
> +
> +static inline uint8_t tpm_reg_readb(const PnvChip *c,
> +                                    uint8_t locty,
> +                                    uint8_t reg)

uint16_t reg  - due to DID_VID register at 0xf00

> +{
> +    uint32_t tpm_reg_locty = SPI_TPM_TIS_ADDR |
> +                             (locty << TPM_TIS_LOCALITY_SHIFT);
> +
> +    spi_access_start(c, true, 1, TPM_READ_OP, tpm_reg_locty | reg);
> +    return spi_read_reg(c);
> +}
> +
> +static inline void tpm_reg_writel(const PnvChip *c,
> +                                  uint8_t locty,
> +                                  uint16_t reg,
> +                                  uint32_t val)
> +{
> +    int i;
> +
> +    for (i = 0; i < 4; i++) {
> +        tpm_reg_writeb(c, locty, reg + i, ((val >> (8 * i)) & 0xff));
> +    }
> +}
> +
> +static inline uint32_t tpm_reg_readl(const PnvChip *c,
> +                                     uint8_t locty,
> +                                     uint16_t reg)
> +{
> +    uint32_t val = 0;
> +    int i;
> +
> +    /* special case for SPI xmit data reg set RWX bits */

There should be no need for this special case. Just this should be enough:


          for (i = 0; i < 4; i++) {
              val |= tpm_reg_readb(c, locty, reg + i) << (8 * i);
          }

or better this here as more efficient 32bit access for all registers:

        spi_access_start(c, true, 4, TPM_READ_OP | SPI_EXTEND,
                          (locty << TPM_TIS_LOCALITY_SHIFT)| reg);
        val = bswap32(spi_read_reg(c));


> +    if (reg == TPM_TIS_REG_DID_VID) {
> +        spi_access_start(c, true, 4, TPM_READ_OP | SPI_EXTEND,
> +                         locty | TPM_TIS_REG_DID_VID);

this was wrong: (locty << TPM_TIS_LOCALITY_SHIFT)

> +        val = bswap32(spi_read_reg(c));
> +    } else {
> +        for (i = 0; i < 4; i++) {
> +            val |= tpm_reg_readb(c, locty, reg + i) << (8 * i);
> +        }
> +    }
> +    return val;
> +}
> +
 > +static void tpm_set_verify_loc(const PnvChip *chip, uint8_t loc)> +{
> +    uint8_t access;
> +    uint32_t tpm_sts;
> +
> +    g_test_message("TPM locality %d tests:", loc);
> +    access = tpm_reg_readb(chip, loc, TPM_TIS_REG_ACCESS);
> +    g_assert_cmpint(access, ==, TPM_TIS_ACCESS_TPM_REG_VALID_STS |
> +                                TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
> +

On I2C the capability flags were a little different than those of the 
'normal' TIS. I suppose on SPI it's the 'normal' TIS flags that are 
shown here.

     capability = tpm_reg_readl(chip, loc, TPM_TIS_REG_INTF_CAPABILITY);
     g_assert_cmpint(capability, ==, TPM_TIS_CAPABILITIES_SUPPORTED2_0);


> +    tpm_reg_writeb(chip, loc, TPM_TIS_REG_ACCESS, TPM_TIS_ACCESS_SEIZE);
> +    tpm_reg_writeb(chip, loc, TPM_TIS_REG_ACCESS, TPM_TIS_ACCESS_REQUEST_USE);
> +
> +    access = tpm_reg_readb(chip, loc, TPM_TIS_REG_ACCESS);
> +    g_assert_cmpint(access, ==, TPM_TIS_ACCESS_TPM_REG_VALID_STS |
> +                                TPM_TIS_ACCESS_ACTIVE_LOCALITY |
> +                                TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
> +    g_test_message("\tACCESS REG = 0x%x checked", access);
> +
> +    /* test tpm status register */
> +    tpm_sts = tpm_reg_readl(chip, loc, TPM_TIS_REG_STS);
> +    g_assert_cmpuint((tpm_sts & TPM_TIS_8BITS_MASK), ==, 0);
> +    g_test_message("\tTPM STATUS: 0x%x, verified", tpm_sts);
> +
> +    /* release access */
> +    tpm_reg_writeb(chip, loc, TPM_TIS_REG_ACCESS,
> +                   TPM_TIS_ACCESS_ACTIVE_LOCALITY);
> +    access = tpm_reg_readb(chip, loc, TPM_TIS_REG_ACCESS);
> +    g_assert_cmpint(access, ==, TPM_TIS_ACCESS_TPM_REG_VALID_STS |
> +                                TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
> +    g_test_message("\tRELEASED ACCESS: 0x%x, checked", access);
> +}
> +
> +static void test_spi_tpm_locality(const void *data)
> +{
> +    const PnvChip *chip = data;
> +    uint8_t locality;
> +
> +    /* Locality 4 has special security restrictions, testing 0-3 */
> +    for (locality = 0; locality < TPM_TIS_NUM_LOCALITIES - 1; locality++) {
> +        tpm_set_verify_loc(chip, locality);
> +    }
> +}
> +
> +static void test_spi_tpm_basic(const void *data)
> +{
> +    const PnvChip *chip = data;
> +    uint32_t didvid, tpm_sts, en_int;
> +    uint8_t access;
> +
> +    g_test_message("TPM TIS SPI interface basic tests:");
> +    /* vendor ID and device ID ... check against the known value*/
> +    didvid = tpm_reg_readl(chip, 0, TPM_TIS_REG_DID_VID);
> +    g_assert_cmpint(didvid, ==, (1 << 16) | PCI_VENDOR_ID_IBM);
> +    g_test_message("\tDID_VID = 0x%x, verified", didvid);
> +
> +    /* access register, default see TCG TIS Spec (v1.3) table-14 */
> +    access = tpm_reg_readb(chip, 0, TPM_TIS_REG_ACCESS);
> +    g_assert_cmpint(access, ==, TPM_TIS_ACCESS_TPM_REG_VALID_STS |
> +                                TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
> +    g_test_message("\tACCESS REG = 0x%x, checked", access);
> +
> +    /* interrupt enable register, default see TCG TIS Spec (v1.3) table-19 */
> +    en_int = tpm_reg_readl(chip, 0, TPM_TIS_REG_INT_ENABLE);
> +    g_assert_cmpuint(en_int, ==, TPM_TIS_INT_POLARITY_LOW_LEVEL);
> +    g_test_message("\tINT ENABLE REG: 0x%x, verified", en_int);
> +
> +    /* status register, default see TCG TIS Spec (v1.3) table-15 */
> +    tpm_sts = tpm_reg_readl(chip, 0, TPM_TIS_REG_STS);
> +    /* for no active locality */
> +    g_assert_cmpuint(tpm_sts, ==, 0xffffffff);
> +    g_test_message("\tTPM STATUS: 0x%x, verified", tpm_sts);
> +}
> +
> +/*
> + * Test case for seizing access by a higher number locality
> + */
> +static void test_spi_tpm_access_seize_test(const void *data)
> +{
> +    const PnvChip *chip = data;
> +    int locty, l;
> +    uint8_t access;
> +    uint8_t pending_request_flag;
> +
> +    g_test_message("TPM TIS SPI access seize tests:");
> +    /* do not test locality 4 (hw only) */
> +    for (locty = 0; locty < TPM_TIS_NUM_LOCALITIES - 1; locty++) {
> +        pending_request_flag = 0;
> +
> +        access = tpm_reg_readb(chip, locty, TPM_TIS_REG_ACCESS);
> +        g_assert_cmpint(access, ==, TPM_TIS_ACCESS_TPM_REG_VALID_STS |
> +                                    TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
> +
> +        /* request use of locality */
> +        tpm_reg_writeb(chip, locty, TPM_TIS_REG_ACCESS,
> +                                    TPM_TIS_ACCESS_REQUEST_USE);
> +
> +        access = tpm_reg_readb(chip, locty, TPM_TIS_REG_ACCESS);
> +        g_assert_cmpint(access, ==, TPM_TIS_ACCESS_TPM_REG_VALID_STS |
> +                                    TPM_TIS_ACCESS_ACTIVE_LOCALITY |
> +                                    TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
> +
> +        /* lower localities cannot seize access */
> +        for (l = 0; l < locty; l++) {
> +            /* lower locality is not active */
> +            access = tpm_reg_readb(chip, l, TPM_TIS_REG_ACCESS);
> +            DPRINTF_ACCESS;
> +            g_assert_cmpint(access, ==, TPM_TIS_ACCESS_TPM_REG_VALID_STS |
> +                                        pending_request_flag |
> +                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
> +
> +            /* try to request use from 'l' */
> +            tpm_reg_writeb(chip, l, TPM_TIS_REG_ACCESS,
> +                                    TPM_TIS_ACCESS_REQUEST_USE);
> +
> +            /*
> +             * requesting use from 'l' was not possible;
> +             * we must see REQUEST_USE and possibly PENDING_REQUEST
> +             */
> +            access = tpm_reg_readb(chip, l, TPM_TIS_REG_ACCESS);
> +            DPRINTF_ACCESS;
> +            g_assert_cmpint(access, ==, TPM_TIS_ACCESS_TPM_REG_VALID_STS |
> +                                        TPM_TIS_ACCESS_REQUEST_USE |
> +                                        pending_request_flag |
> +                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
> +
> +            /*
> +             * locality 'locty' must be unchanged;
> +             * we must see PENDING_REQUEST
> +             */
> +            access = tpm_reg_readb(chip, locty, TPM_TIS_REG_ACCESS);
> +            g_assert_cmpint(access, ==, TPM_TIS_ACCESS_TPM_REG_VALID_STS |
> +                                        TPM_TIS_ACCESS_ACTIVE_LOCALITY |
> +                                        TPM_TIS_ACCESS_PENDING_REQUEST |
> +                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
> +
> +            /* try to seize from 'l' */
> +            tpm_reg_writeb(chip, l, TPM_TIS_REG_ACCESS, TPM_TIS_ACCESS_SEIZE);
> +            /* seize from 'l' was not possible */
> +            access = tpm_reg_readb(chip, l, TPM_TIS_REG_ACCESS);
> +            DPRINTF_ACCESS;
> +            g_assert_cmpint(access, ==, TPM_TIS_ACCESS_TPM_REG_VALID_STS |
> +                                        TPM_TIS_ACCESS_REQUEST_USE |
> +                                        pending_request_flag |
> +                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
> +
> +            /* locality 'locty' must be unchanged */
> +            access = tpm_reg_readb(chip, locty, TPM_TIS_REG_ACCESS);
> +            g_assert_cmpint(access, ==, TPM_TIS_ACCESS_TPM_REG_VALID_STS |
> +                                        TPM_TIS_ACCESS_ACTIVE_LOCALITY |
> +                                        TPM_TIS_ACCESS_PENDING_REQUEST |
> +                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
> +
> +            /*
> +             * on the next loop we will have a PENDING_REQUEST flag
> +             * set for locality 'l'
> +             */
> +            pending_request_flag = TPM_TIS_ACCESS_PENDING_REQUEST;
> +        }
> +
> +        /*
> +         * higher localities can 'seize' access but not 'request use';
> +         * note: this will activate first l+1, then l+2 etc.
> +         */
> +        for (l = locty + 1; l < TPM_TIS_NUM_LOCALITIES - 1; l++) {
> +            /* try to 'request use' from 'l' */
> +            tpm_reg_writeb(chip, l, TPM_TIS_REG_ACCESS,
> +                                    TPM_TIS_ACCESS_REQUEST_USE);
> +
> +            /*
> +             * requesting use from 'l' was not possible; we should see
> +             * REQUEST_USE and may see PENDING_REQUEST
> +             */
> +            access = tpm_reg_readb(chip, l, TPM_TIS_REG_ACCESS);
> +            DPRINTF_ACCESS;
> +            g_assert_cmpint(access, ==, TPM_TIS_ACCESS_TPM_REG_VALID_STS |
> +                                        TPM_TIS_ACCESS_REQUEST_USE |
> +                                        pending_request_flag |
> +                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
> +
> +            /*
> +             * locality 'l-1' must be unchanged; we should always
> +             * see PENDING_REQUEST from 'l' requesting access
> +             */
> +            access = tpm_reg_readb(chip, l - 1, TPM_TIS_REG_ACCESS);
> +            DPRINTF_ACCESS;
> +            g_assert_cmpint(access, ==, TPM_TIS_ACCESS_TPM_REG_VALID_STS |
> +                                        TPM_TIS_ACCESS_ACTIVE_LOCALITY |
> +                                        TPM_TIS_ACCESS_PENDING_REQUEST |
> +                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
> +
> +            /* try to seize from 'l' */
> +            tpm_reg_writeb(chip, l, TPM_TIS_REG_ACCESS, TPM_TIS_ACCESS_SEIZE);
> +
> +            /* seize from 'l' was possible */
> +            access = tpm_reg_readb(chip, l, TPM_TIS_REG_ACCESS);
> +            DPRINTF_ACCESS;
> +            g_assert_cmpint(access, ==, TPM_TIS_ACCESS_TPM_REG_VALID_STS |
> +                                        TPM_TIS_ACCESS_ACTIVE_LOCALITY |
> +                                        pending_request_flag |
> +                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
> +
> +            /* l - 1 should show that it has BEEN_SEIZED */
> +            access = tpm_reg_readb(chip, l - 1, TPM_TIS_REG_ACCESS);
> +            DPRINTF_ACCESS;
> +            g_assert_cmpint(access, ==, TPM_TIS_ACCESS_TPM_REG_VALID_STS |
> +                                        TPM_TIS_ACCESS_BEEN_SEIZED |
> +                                        pending_request_flag |
> +                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
> +
> +            /* clear the BEEN_SEIZED flag and make sure it's gone */
> +            tpm_reg_writeb(chip, l - 1, TPM_TIS_REG_ACCESS,
> +                                        TPM_TIS_ACCESS_BEEN_SEIZED);
> +
> +            access = tpm_reg_readb(chip, l - 1, TPM_TIS_REG_ACCESS);
> +            g_assert_cmpint(access, ==, TPM_TIS_ACCESS_TPM_REG_VALID_STS |
> +                                        pending_request_flag |
> +                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
> +        }
> +
> +        /*
> +         * PENDING_REQUEST will not be set if locty = 0 since all localities
> +         * were active; in case of locty = 1, locality 0 will be active
> +         * but no PENDING_REQUEST anywhere
> +         */
> +        if (locty <= 1) {
> +            pending_request_flag = 0;
> +        }
> +
> +        /* release access from l - 1; this activates locty - 1 */
> +        l--;
> +
> +        access = tpm_reg_readb(chip, l, TPM_TIS_REG_ACCESS);
> +        DPRINTF_ACCESS;
> +
> +        DPRINTF("%s: %d: relinquishing control on l = %d\n",
> +                __func__, __LINE__, l);
> +        tpm_reg_writeb(chip, l, TPM_TIS_REG_ACCESS,
> +                                TPM_TIS_ACCESS_ACTIVE_LOCALITY);
> +
> +        access = tpm_reg_readb(chip, l, TPM_TIS_REG_ACCESS);
> +        DPRINTF_ACCESS;
> +        g_assert_cmpint(access, ==, TPM_TIS_ACCESS_TPM_REG_VALID_STS |
> +                                    pending_request_flag |
> +                                    TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
> +
> +        for (l = locty - 1; l >= 0; l--) {
> +            access = tpm_reg_readb(chip, l, TPM_TIS_REG_ACCESS);
> +            DPRINTF_ACCESS;
> +            g_assert_cmpint(access, ==, TPM_TIS_ACCESS_TPM_REG_VALID_STS |
> +                                        TPM_TIS_ACCESS_ACTIVE_LOCALITY |
> +                                        pending_request_flag |
> +                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
> +
> +            /* release this locality */
> +            tpm_reg_writeb(chip, l, TPM_TIS_REG_ACCESS,
> +                                    TPM_TIS_ACCESS_ACTIVE_LOCALITY);
> +
> +            if (l == 1) {
> +                pending_request_flag = 0;
> +            }
> +        }
> +
> +        /* no locality may be active now */
> +        for (l = 0; l < TPM_TIS_NUM_LOCALITIES - 1; l++) {
> +            access = tpm_reg_readb(chip, l, TPM_TIS_REG_ACCESS);
> +            DPRINTF_ACCESS;
> +            g_assert_cmpint(access, ==, TPM_TIS_ACCESS_TPM_REG_VALID_STS |
> +                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
> +        }
> +        g_test_message("\tTPM locality %d seize tests: passed", locty);
> +    }
> +}
> +
> +/*
> + * Test case for getting access when higher number locality relinquishes access
> + */
> +static void test_spi_tpm_access_release_test(const void *data)
> +{
> +    const PnvChip *chip = data;
> +    int locty, l;
> +    uint8_t access;
> +    uint8_t pending_request_flag;
> +
> +    g_test_message("TPM TIS SPI access release tests:");
> +    /* do not test locality 4 (hw only) */
> +    for (locty = TPM_TIS_NUM_LOCALITIES - 2; locty >= 0; locty--) {
> +        pending_request_flag = 0;
> +
> +        access = tpm_reg_readb(chip, locty, TPM_TIS_REG_ACCESS);
> +        g_assert_cmpint(access, ==, TPM_TIS_ACCESS_TPM_REG_VALID_STS |
> +                                    TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
> +
> +        /* request use of locality */
> +        tpm_reg_writeb(chip, locty, TPM_TIS_REG_ACCESS,
> +                                    TPM_TIS_ACCESS_REQUEST_USE);
> +        access = tpm_reg_readb(chip, locty, TPM_TIS_REG_ACCESS);
> +        g_assert_cmpint(access, ==, TPM_TIS_ACCESS_TPM_REG_VALID_STS |
> +                                    TPM_TIS_ACCESS_ACTIVE_LOCALITY |
> +                                    TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
> +
> +        /* request use of all other localities */
> +        for (l = 0; l < TPM_TIS_NUM_LOCALITIES - 1; l++) {
> +            if (l == locty) {
> +                continue;
> +            }
> +            /*
> +             * request use of locality 'l' -- we MUST see REQUEST USE and
> +             * may see PENDING_REQUEST
> +             */
> +            tpm_reg_writeb(chip, l, TPM_TIS_REG_ACCESS,
> +                                    TPM_TIS_ACCESS_REQUEST_USE);
> +            access = tpm_reg_readb(chip, l, TPM_TIS_REG_ACCESS);
> +            DPRINTF_ACCESS;
> +            g_assert_cmpint(access, ==, TPM_TIS_ACCESS_TPM_REG_VALID_STS |
> +                                        TPM_TIS_ACCESS_REQUEST_USE |
> +                                        pending_request_flag |
> +                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
> +            pending_request_flag = TPM_TIS_ACCESS_PENDING_REQUEST;
> +        }
> +        /* release locality 'locty' */
> +        tpm_reg_writeb(chip, locty, TPM_TIS_REG_ACCESS,
> +                                    TPM_TIS_ACCESS_ACTIVE_LOCALITY);
> +        /*
> +         * highest locality should now be active; release it and make sure the
> +         * next highest locality is active afterwards
> +         */
> +        for (l = TPM_TIS_NUM_LOCALITIES - 2; l >= 0; l--) {
> +            if (l == locty) {
> +                continue;
> +            }
> +            /* 'l' should be active now */
> +            access = tpm_reg_readb(chip, l, TPM_TIS_REG_ACCESS);
> +            DPRINTF_ACCESS;
> +            g_assert_cmpint(access, ==, TPM_TIS_ACCESS_TPM_REG_VALID_STS |
> +                                        TPM_TIS_ACCESS_ACTIVE_LOCALITY |
> +                                        pending_request_flag |
> +                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
> +            /* 'l' relinquishes access */
> +            tpm_reg_writeb(chip, l, TPM_TIS_REG_ACCESS,
> +                                    TPM_TIS_ACCESS_ACTIVE_LOCALITY);
> +            access = tpm_reg_readb(chip, l, TPM_TIS_REG_ACCESS);
> +            DPRINTF_ACCESS;
> +            if (l == 1 || (locty <= 1 && l == 2)) {
> +                pending_request_flag = 0;
> +            }
> +            g_assert_cmpint(access, ==, TPM_TIS_ACCESS_TPM_REG_VALID_STS |
> +                                        pending_request_flag |
> +                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
> +        }
> +        g_test_message("\tTPM locality %d seize tests: passed", locty);
> +    }
> +}
> +
> +/*
> + * Test case for transmitting packets
> + */
> +static void test_spi_tpm_transmit_test(const void *data)
> +{
 > +    const PnvChip *chip = data;

For comparing received TPM responses we need access to TPMTestState in 
this test case, this should be:

     const PnvChip *chip = &pnv_chips[3];   <--- may want to consider 
replacing this everywhere else as well.

     const struct TPMTestState *s = data;

> +    uint16_t bcount;
> +    uint8_t access;
> +    uint32_t sts;
> +    int i;
> +
> +    g_test_message("TPM TIS SPI transmit tests:");
> +    /* request use of locality 0 */
> +    tpm_reg_writeb(chip, 0, TPM_TIS_REG_ACCESS, TPM_TIS_ACCESS_REQUEST_USE);
> +    access = tpm_reg_readb(chip, 0, TPM_TIS_REG_ACCESS);
> +    g_assert_cmpint(access, ==, TPM_TIS_ACCESS_TPM_REG_VALID_STS |
> +                                TPM_TIS_ACCESS_ACTIVE_LOCALITY |
> +                                TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
> +
> +    sts = tpm_reg_readl(chip, 0, TPM_TIS_REG_STS);
> +    DPRINTF_STS;
> +
> +    g_assert_cmpint(sts & 0xff, ==, 0);

g_assert_cmpint(sts & TPM_TIS_STS_TPM_FAMILY_MASK, ==,
                 TPM_TIS_STS_TPM_FAMILY2_0);


> +
> +    bcount = (sts >> 8) & 0xffff;
> +    g_test_message("\t\tbcount: %x, sts: %x", bcount, sts);
> +    g_assert_cmpint(bcount, >=, 128);
> +
> +    tpm_reg_writel(chip, 0, TPM_TIS_REG_STS, TPM_TIS_STS_COMMAND_READY);
> +    sts = tpm_reg_readl(chip, 0, TPM_TIS_REG_STS);
> +    DPRINTF_STS;
> +    g_assert_cmpint(sts & 0xff, ==, TPM_TIS_STS_COMMAND_READY);
> +
> +    /* transmit command */
> +    for (i = 0; i < sizeof(TPM_CMD); i++) {
> +        tpm_reg_writeb(chip, 0, TPM_TIS_REG_DATA_FIFO, TPM_CMD[i]);
> +        sts = tpm_reg_readl(chip, 0, TPM_TIS_REG_STS);
> +        DPRINTF_STS;
> +        if (i < sizeof(TPM_CMD) - 1) {
> +            g_assert_cmpint(sts & 0xff, ==, TPM_TIS_STS_EXPECT |
> +                                            TPM_TIS_STS_VALID);
> +        } else {
> +            g_assert_cmpint(sts & 0xff, ==, TPM_TIS_STS_VALID);
> +        }

/* since STS is read byte-by-byte bcount will be constant 0xff */
g_assert_cmpint((sts >> 8) & 0xffff, ==, 0xff);

> +    }
> +    g_test_message("\ttransmit tests, check TPM_TIS_STS_EXPECT");
> +
> +    /* start processing */
> +    tpm_reg_writel(chip, 0, TPM_TIS_REG_STS, TPM_TIS_STS_TPM_GO);
> +
> +    uint64_t end_time = g_get_monotonic_time() + 50 * G_TIME_SPAN_SECOND;
> +    do {
> +        sts = tpm_reg_readl(chip, 0, TPM_TIS_REG_STS);
> +        if ((sts & TPM_TIS_STS_DATA_AVAILABLE) != 0) {
> +            break;
> +        }
> +    } while (g_get_monotonic_time() < end_time);
> +
> +    sts = tpm_reg_readl(chip, 0, TPM_TIS_REG_STS);
> +    DPRINTF_STS;
> +    g_assert_cmpint(sts & 0xff, == , TPM_TIS_STS_VALID |
> +                                     TPM_TIS_STS_DATA_AVAILABLE);
> +    /* TCG TIS Spec (v1.3) table-15 */
> +    g_test_message("\ttransmit tests, check tpmGo (w) & dataAvail (r)");
> +    bcount = (sts >> 8) & 0xffff;
> +
> +    /* read response */
> +    uint8_t tpm_msg[sizeof(struct tpm_hdr)];
> +    g_assert_cmpint(sizeof(tpm_msg), ==, bcount);
> +
> +    for (i = 0; i < sizeof(tpm_msg); i++) {
> +        tpm_msg[i] = tpm_reg_readb(chip, 0, TPM_TIS_REG_DATA_FIFO);
> +        sts = tpm_reg_readl(chip, 0, TPM_TIS_REG_STS);
> +        DPRINTF_STS;
> +        if (sts & TPM_TIS_STS_DATA_AVAILABLE) {
> +            g_assert_cmpint((sts >> 8) & 0xffff, ==, --bcount);
> +        }
> +    }

With 's' accessible now:
        g_assert_cmpmem(tpm_msg, sizeof(tpm_msg), s->tpm_msg, 
sizeof(*s->tpm_msg));

> +    g_test_message("\treceive tests, passed");
> +    /* relinquish use of locality 0 */
> +    tpm_reg_writeb(chip, 0, TPM_TIS_REG_ACCESS, TPM_TIS_ACCESS_ACTIVE_LOCALITY);
> +    access = tpm_reg_readb(chip, 0, TPM_TIS_REG_ACCESS);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    int ret;
> +    char *args;
> +    GThread *thread;
> +    TPMTestState test;
> +    g_autofree char *tmp_path = g_dir_make_tmp("qemu-tpm-tis-spi-test.XXXXXX",
> +                                                NULL);
> +
> +    module_call_init(MODULE_INIT_QOM);
> +    g_test_init(&argc, &argv, NULL);
> +
> +    test.addr = g_new0(SocketAddress, 1);
> +    test.addr->type = SOCKET_ADDRESS_TYPE_UNIX;
> +    test.addr->u.q_unix.path = g_build_filename(tmp_path, "sock", NULL);
> +    g_mutex_init(&test.data_mutex);
> +    g_cond_init(&test.data_cond);
> +    test.data_cond_signal = false;
> +    test.tpm_version = TPM_VERSION_2_0;
> +
> +    thread = g_thread_new(NULL, tpm_emu_ctrl_thread, &test);
> +    tpm_emu_test_wait_cond(&test);
> +
> +    args = g_strdup_printf("-m 2G -machine powernv10 -smp 2,cores=2,"
> +                      "threads=1 -accel tcg,thread=single -nographic "
> +                      "-chardev socket,id=chrtpm,path=%s "
> +                      "-tpmdev emulator,id=tpm0,chardev=chrtpm "
> +                      "-device tpm-tis-spi,tpmdev=tpm0,bus=pnv-spi-bus.4",
> +                      test.addr->u.q_unix.path);
> +    qtest_start(args);
> +    qtest_add_data_func("pnv-xscom/tpm-tis-spi/basic_test",
> +                        &pnv_chips[3], test_spi_tpm_basic);
> +    qtest_add_data_func("pnv-xscom/tpm-tis-spi/locality_test",
> +                        &pnv_chips[3], test_spi_tpm_locality);
> +    qtest_add_data_func("pnv-xscom/tpm-tis-spi/access_seize_test",
> +                        &pnv_chips[3], test_spi_tpm_access_seize_test);
> +    qtest_add_data_func("pnv-xscom/tpm-tis-spi/access_release_test",
> +                        &pnv_chips[3], test_spi_tpm_access_release_test);
> +    qtest_add_data_func("pnv-xscom/tpm-tis-spi/data_transmit_test",
 > +                        &pnv_chips[3], test_spi_tpm_transmit_test);

pass &test here instead of &pnv_chips[3].

> +    ret = g_test_run();
> +
> +    qtest_end();
> +    g_thread_join(thread);
> +    g_unlink(test.addr->u.q_unix.path);
> +    qapi_free_SocketAddress(test.addr);
> +    g_rmdir(tmp_path);
> +    g_free(args);
> +    return ret;
> +}
> +
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index e8be8b3942..74aa9f57e0 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -177,6 +177,7 @@ qtests_ppc64 = \
>     (config_all_devices.has_key('CONFIG_PSERIES') ? ['device-plug-test'] : []) +               \
>     (config_all_devices.has_key('CONFIG_POWERNV') ? ['pnv-xscom-test'] : []) +                 \
>     (config_all_devices.has_key('CONFIG_POWERNV') ? ['pnv-spi-seeprom-test'] : []) +           \
> +  (config_all_devices.has_key('CONFIG_POWERNV') ? ['tpm-tis-spi-pnv-test'] : []) +           \
>     (config_all_devices.has_key('CONFIG_POWERNV') ? ['pnv-host-i2c-test'] : []) +              \
>     (config_all_devices.has_key('CONFIG_PSERIES') ? ['numa-test'] : []) +                      \
>     (config_all_devices.has_key('CONFIG_PSERIES') ? ['rtas-test'] : []) +                      \
> @@ -348,6 +349,7 @@ qtests = {
>     'tpm-tis-i2c-test': [io, tpmemu_files, 'qtest_aspeed.c'],
>     'tpm-tis-device-swtpm-test': [io, tpmemu_files, 'tpm-tis-util.c'],
>     'tpm-tis-device-test': [io, tpmemu_files, 'tpm-tis-util.c'],
> +  'tpm-tis-spi-pnv-test': [io, tpmemu_files],
>     'virtio-net-failover': files('migration-helpers.c'),
>     'vmgenid-test': files('boot-sector.c', 'acpi-utils.c'),
>     'netdev-socket': files('netdev-socket.c', '../unit/socket-helpers.c'),


When running `ninja -C build test` I get this output that should have 
its lines prefixed with '#' 'somehow':

  42/424 qemu:qtest+qtest-ppc64 / qtest-ppc64/tpm-tis-spi-pnv-test 
              OK               0.31s   5 subtests passed

stdout: 34: UNKNOWN: [    0.024173382,5] OPAL v7.1 starting...
stdout: 35: UNKNOWN: [    0.024724739,7] initial console log level: 
memory 7, driver 5
stdout: 36: UNKNOWN: [    0.024778210,6] CPU: P10 generation processor 
(max 4 threads/core)
stdout: 37: UNKNOWN: [    0.024795001,7] CPU: Boot CPU PIR is 0x0000 PVR 
is 0x00801200
stdout: 38: UNKNOWN: [    0.024925108,7] OPAL table: 0x3018a960 .. 
0x3018af00, branch table: 0x30120000
stdout: 39: UNKNOWN: [    0.025103930,7] Assigning physical memory map 
table for p10
stdout: 40: UNKNOWN: [    0.025411575,7] FDT: Parsing fdt @0x1000000
stdout: 41: UNKNOWN: [    0.028505988,5] CHIP: Detected QEMU simulator
stdout: 42: UNKNOWN: [    0.028683295,6] CHIP: Initialised chip 0 from 
xscom@603fc00000000
stdout: 43: UNKNOWN: [    0.029247139,6] P10 DD2.00 detected
stdout: 44: UNKNOWN: [    0.029267261,5] CHIP: Chip ID 0000 type: P10 DD2.00
stdout: 45: UNKNOWN: [    0.029276249,7] XSCOM: Base address: 
0x603fc00000000
stdout: 46: UNKNOWN: [    0.029339220,7] XSTOP: ibm,sw-checkstop-fir 
prop not found
stdout: 47: UNKNOWN: [    0.029409300,6] MFSI 0:0: Initialized
stdout: 48: UNKNOWN: [    0.029419734,6] MFSI 0:2: Initialized
stdout: 49: UNKNOWN: [    0.029429173,6] MFSI 0:1: Initialized
stdout: 50: UNKNOWN: [    0.030012352,6] LPC: LPC[000]: Initialized
stdout: 51: UNKNOWN: [    0.030020186,7] LPC: access via MMIO 
@0x6030000000000
stdout: 52: UNKNOWN: [    0.030108378,7] LPC: Default bus on chip 0x0
stdout: 53: UNKNOWN: [    0.030193313,7] CPU: New max PIR set to 0x7
stdout: 54: UNKNOWN: [    0.030743076,7] MEM: parsing reserved memory 
from reserved-names/-ranges properties
stdout: 55: UNKNOWN: [    0.030828672,7] HOMER: Init chip 0
stdout: 56: UNKNOWN: [    0.030862569,7]   PBA BAR0 : 0x0000300ffd800000
stdout: 57: UNKNOWN: [    0.030870164,7]   PBA MASK0: 0x0000000000300000
stdout: 58: UNKNOWN: [    0.030899260,7]   HOMER Image at 0x300ffd800000 
size 4MB
stdout: 59: UNKNOWN: [    0.030943460,4] HOMER image is not reserved! 
Reserving
stdout: 60: UNKNOWN: [    0.031114747,7]   PBA BAR2 : 0x0000300fff800000
stdout: 61: UNKNOWN: [    0.031121980,7]   PBA MASK2: 0x0000000000700000
stdout: 62: UNKNOWN: [    0.031136886,7]   OCC Common Area at 
0x300fff800000 size 8MB
stdout: 63: UNKNOWN: [    0.031171139,4] OCC common area is not 
reserved! Reserving
stdout: 64: UNKNOWN: [    0.031231035,7] CPU: decrementer bits 56
stdout: 65: UNKNOWN: [    0.031321664,6] CPU: CPU from DT PIR=0x0000 
Server#=0x0 State=4
stdout: 66: UNKNOWN: [    0.031427205,6] CPU:  1 secondary threads
stdout: 67: UNKNOWN: [    0.031441159,6] CPU: CPU from DT PIR=0x0004 
Server#=0x4 State=4
stdout: 68: UNKNOWN: [    0.031459259,6] CPU:  1 secondary threads
stdout: 69: UNKNOWN: [    0.033492258,5] PLAT: Using SuperIO UART
stdout: 70: UNKNOWN: [    0.033826231,7] UART: Using LPC IRQ 4
stdout: 71: UNKNOWN: [    0.036351187,5] PLAT: Detected QEMU POWER10 
platform
stdout: 72: UNKNOWN: [    0.036415869,5] PLAT: Detected BMC platform 
ast2500:openbmc
stdout: 73: UNKNOWN: [    0.037499517,5] XIVE: [ IC 00  ] Initializing 
XIVE block ID 0...
ERROR: Unknown TAP output lines for a supported TAP version.
This is probably a bug in the test; if they are not TAP syntax, prefix 
them with a #



