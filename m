Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57D94C25B78
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 06:14:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s8wH8-00016d-3e; Mon, 20 May 2024 02:13:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=3Db1=MX=kaod.org=clg@ozlabs.org>)
 id 1s8wH5-00015j-GA; Mon, 20 May 2024 02:13:31 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=3Db1=MX=kaod.org=clg@ozlabs.org>)
 id 1s8wH1-000250-M4; Mon, 20 May 2024 02:13:31 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4VjS1F3nVdz4wjF;
 Mon, 20 May 2024 16:13:21 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4VjS194Kw1z4wbp;
 Mon, 20 May 2024 16:13:17 +1000 (AEST)
Message-ID: <dfcf9e54-3fe5-4551-bfd3-814d9cd62724@kaod.org>
Date: Mon, 20 May 2024 08:13:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] tests/qtest: Add pnv-spi-seeprom qtest
To: Chalapathi V <chalapathi.v@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 calebs@us.ibm.com, chalapathi.v@ibm.com, saif.abrar@linux.vnet.ibm.com,
 dantan@us.ibm.com, milesg@linux.vnet.ibm.com
References: <20240515174149.17713-1-chalapathi.v@linux.ibm.com>
 <20240515174149.17713-6-chalapathi.v@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240515174149.17713-6-chalapathi.v@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=3Db1=MX=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 5/15/24 19:41, Chalapathi V wrote:
> In this commit Write a qtest pnv-spi-seeprom-test to check the
> SPI transactions between spi controller and seeprom device.
> 
> Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
> ---
>   tests/qtest/pnv-spi-seeprom-test.c | 129 +++++++++++++++++++++++++++++
>   tests/qtest/meson.build            |   1 +
>   2 files changed, 130 insertions(+)
>   create mode 100644 tests/qtest/pnv-spi-seeprom-test.c
> 
> diff --git a/tests/qtest/pnv-spi-seeprom-test.c b/tests/qtest/pnv-spi-seeprom-test.c
> new file mode 100644
> index 0000000000..bfa57f3234
> --- /dev/null
> +++ b/tests/qtest/pnv-spi-seeprom-test.c
> @@ -0,0 +1,129 @@
> +/*
> + * QTest testcase for PowerNV 10 Seeprom Communications
> + *
> + * Copyright (c) 2024, IBM Corporation.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#include <unistd.h>
> +#include "qemu/osdep.h"
> +#include "libqtest.h"
> +#include "qemu/bswap.h"
> +#include "hw/ssi/pnv_spi_regs.h"
> +
> +#define P10_XSCOM_BASE          0x000603fc00000000ull
> +#define SPIC2_XSCOM_BASE        0xc0040
> +
> +/* To transmit READ opcode and address */
> +#define READ_OP_TDR_DATA        0x0300010000000000
> +/*
> + * N1 shift - tx 4 bytes (transmit opcode and address)
> + * N2 shift - tx and rx 8 bytes.
> + */
> +#define READ_OP_COUNTER_CONFIG  0x2040000000002b00
> +/* SEQ_OP_SELECT_RESPONDER - N1 Shift - N2 Shift * 5 - SEQ_OP_STOP */
> +#define READ_OP_SEQUENCER       0x1130404040404010
> +
> +/* To transmit WREN(Set Write Enable Latch in status0 register) opcode */
> +#define WRITE_OP_WREN           0x0600000000000000
> +/* To transmit WRITE opcode, address and data */
> +#define WRITE_OP_TDR_DATA       0x0300010012345678
> +/* N1 shift - tx 8 bytes (transmit opcode, address and data) */
> +#define WRITE_OP_COUNTER_CONFIG 0x4000000000002000
> +/* SEQ_OP_SELECT_RESPONDER - N1 Shift - SEQ_OP_STOP */
> +#define WRITE_OP_SEQUENCER      0x1130100000000000
> +
> +static uint64_t pnv_xscom_addr(uint32_t pcba)
> +{
> +    return P10_XSCOM_BASE | ((uint64_t) pcba << 3);
> +}


I would prefer if the test used the pnv_xscom_addr() definition from
tests/qtest/pnv-xscom.h.

> +static uint64_t pnv_spi_seeprom_xscom_addr(uint32_t reg)
> +{
> +    return pnv_xscom_addr(SPIC2_XSCOM_BASE + reg);
> +}
> +
> +static void pnv_spi_controller_xscom_write(QTestState *qts, uint32_t reg,
> +                uint64_t val)
> +{
> +    qtest_writeq(qts, pnv_spi_seeprom_xscom_addr(reg), val);
> +}
> +
> +static uint64_t pnv_spi_controller_xscom_read(QTestState *qts, uint32_t reg)
> +{
> +    return qtest_readq(qts, pnv_spi_seeprom_xscom_addr(reg));
> +}
> +
> +static void spi_seeprom_transaction(QTestState *qts)
> +{
> +    /* SPI transactions to SEEPROM to read from SEEPROM image */
> +    pnv_spi_controller_xscom_write(qts, COUNTER_CONFIG_REG,
> +                                    READ_OP_COUNTER_CONFIG);
> +    pnv_spi_controller_xscom_write(qts, SEQUENCER_OPERATION_REG,
> +                                    READ_OP_SEQUENCER);
> +    pnv_spi_controller_xscom_write(qts, TRANSMIT_DATA_REG, READ_OP_TDR_DATA);
> +    pnv_spi_controller_xscom_write(qts, TRANSMIT_DATA_REG, 0);
> +    /* Read 5*8 bytes from SEEPROM at 0x100 */
> +    uint64_t rdr_val = pnv_spi_controller_xscom_read(qts, RECEIVE_DATA_REG);
> +    printf("RDR READ = 0x%lx\n", rdr_val);
> +    rdr_val = pnv_spi_controller_xscom_read(qts, RECEIVE_DATA_REG);
> +    rdr_val = pnv_spi_controller_xscom_read(qts, RECEIVE_DATA_REG);
> +    rdr_val = pnv_spi_controller_xscom_read(qts, RECEIVE_DATA_REG);
> +    rdr_val = pnv_spi_controller_xscom_read(qts, RECEIVE_DATA_REG);
> +    printf("RDR READ = 0x%lx\n", rdr_val);
> +
> +    /* SPI transactions to SEEPROM to write to SEEPROM image */
> +    pnv_spi_controller_xscom_write(qts, COUNTER_CONFIG_REG,
> +                                    WRITE_OP_COUNTER_CONFIG);
> +    /* Set Write Enable Latch bit of status0 register */
> +    pnv_spi_controller_xscom_write(qts, SEQUENCER_OPERATION_REG,
> +                                    WRITE_OP_SEQUENCER);
> +    pnv_spi_controller_xscom_write(qts, TRANSMIT_DATA_REG, WRITE_OP_WREN);
> +    /* write 8 bytes to SEEPROM at 0x100 */
> +    pnv_spi_controller_xscom_write(qts, SEQUENCER_OPERATION_REG,
> +                                    WRITE_OP_SEQUENCER);
> +    pnv_spi_controller_xscom_write(qts, TRANSMIT_DATA_REG, WRITE_OP_TDR_DATA);
> +}
> +
> +/* Find complete path of in_file in the current working directory */
> +static void find_file(const char *in_file, char *in_path)
> +{
> +    g_autofree char *cwd = g_get_current_dir();
> +    char *filepath = g_build_filename(cwd, in_file, NULL);
> +    if (!access(filepath, F_OK)) {
> +        strcpy(in_path, filepath);
> +    } else {
> +        strcpy(in_path, "");
> +        printf("File %s not found within %s\n", in_file, cwd);
> +    }
> +}
> +
> +static void test_spi_seeprom(void)
> +{
> +    QTestState *qts = NULL;
> +    char seepromfile[500];
> +    find_file("sbe_measurement_seeprom.bin.ecc", seepromfile);

hmm, could you generate the contents instead ?

> +    if (strcmp(seepromfile, "")) {
> +        printf("Starting QEMU with seeprom file.\n");
> +        qts = qtest_initf("-m 2G -machine powernv10 -smp 2,cores=2,"
> +                          "threads=1 -accel tcg,thread=single -nographic "
> +                          "-blockdev node-name=pib_spic2,driver=file,"
> +			  "filename=sbe_measurement_seeprom.bin.ecc "
> +			  "-device 25csm04,bus=pnv-spi-bus.2,cs=0,"
> +			  "drive=pib_spic2");
> +    } else {
> +        printf("Starting QEMU without seeprom file.\n");
> +        qts = qtest_initf("-m 2G -machine powernv10 -smp 2,cores=2,"
> +                          "threads=1 -accel tcg,thread=single -nographic"
> +			  " -device 25csm04,bus=pnv-spi-bus.2,cs=0");
> +    }
> +    spi_seeprom_transaction(qts);
> +    qtest_quit(qts);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    g_test_init(&argc, &argv, NULL);
> +    qtest_add_func("spi_seeprom", test_spi_seeprom);
> +    return g_test_run();
> +}
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 86293051dc..2fa98b2430 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -171,6 +171,7 @@ qtests_ppc64 = \
>     qtests_ppc + \
>     (config_all_devices.has_key('CONFIG_PSERIES') ? ['device-plug-test'] : []) +               \
>     (config_all_devices.has_key('CONFIG_POWERNV') ? ['pnv-xscom-test'] : []) +                 \
> +  (config_all_devices.has_key('CONFIG_POWERNV') ? ['pnv-spi-seeprom-test'] : []) +           \
>     (config_all_devices.has_key('CONFIG_POWERNV') ? ['pnv-host-i2c-test'] : []) +              \
>     (config_all_devices.has_key('CONFIG_PSERIES') ? ['rtas-test'] : []) +                      \
>     (slirp.found() ? ['pxe-test'] : []) +              \


