Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF36BC2BC81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 16:12:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJbRL-0005a6-Pv; Tue, 18 Jun 2024 12:12:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Of75=NU=kaod.org=clg@ozlabs.org>)
 id 1sJbRI-0005MY-VO; Tue, 18 Jun 2024 12:12:09 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Of75=NU=kaod.org=clg@ozlabs.org>)
 id 1sJbRG-0000WL-7C; Tue, 18 Jun 2024 12:12:08 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4W3Wwc6Jywz4wyl;
 Wed, 19 Jun 2024 02:12:00 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4W3WwY172vz4w2Q;
 Wed, 19 Jun 2024 02:11:56 +1000 (AEST)
Message-ID: <0b29566d-eb1e-4540-a7cd-efcab6cc6a32@kaod.org>
Date: Tue, 18 Jun 2024 18:11:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] tests/qtest: Add pnv-spi-seeprom qtest
To: Chalapathi V <chalapathi.v@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 calebs@us.ibm.com, chalapathi.v@ibm.com, saif.abrar@linux.ibm.com,
 dantan@us.ibm.com, milesg@linux.ibm.com
References: <20240617165419.8388-1-chalapathi.v@linux.ibm.com>
 <20240617165419.8388-6-chalapathi.v@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240617165419.8388-6-chalapathi.v@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=Of75=NU=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/17/24 6:54 PM, Chalapathi V wrote:
> In this commit Write a qtest pnv-spi-seeprom-test to check the
> SPI transactions between spi controller and seeprom device.
> 
> Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>


Acked-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   tests/qtest/pnv-spi-seeprom-test.c | 110 +++++++++++++++++++++++++++++
>   tests/qtest/meson.build            |   1 +
>   2 files changed, 111 insertions(+)
>   create mode 100644 tests/qtest/pnv-spi-seeprom-test.c
> 
> diff --git a/tests/qtest/pnv-spi-seeprom-test.c b/tests/qtest/pnv-spi-seeprom-test.c
> new file mode 100644
> index 0000000000..92bc8a11ae
> --- /dev/null
> +++ b/tests/qtest/pnv-spi-seeprom-test.c
> @@ -0,0 +1,110 @@
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
> +#include "pnv-xscom.h"
> +
> +#define FLASH_SIZE              (512 * 1024)
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
> +static void pnv_spi_xscom_write(QTestState *qts, const PnvChip *chip,
> +        uint32_t reg, uint64_t val)
> +{
> +    uint32_t pcba = SPIC2_XSCOM_BASE + reg;
> +    qtest_writeq(qts, pnv_xscom_addr(chip, pcba), val);
> +}
> +
> +static uint64_t pnv_spi_xscom_read(QTestState *qts, const PnvChip *chip,
> +        uint32_t reg)
> +{
> +    uint32_t pcba = SPIC2_XSCOM_BASE + reg;
> +    return qtest_readq(qts, pnv_xscom_addr(chip, pcba));
> +}
> +
> +static void spi_seeprom_transaction(QTestState *qts, const PnvChip *chip)
> +{
> +    /* SPI transactions to SEEPROM to read from SEEPROM image */
> +    pnv_spi_xscom_write(qts, chip, SPI_CTR_CFG_REG, READ_OP_COUNTER_CONFIG);
> +    pnv_spi_xscom_write(qts, chip, SPI_SEQ_OP_REG, READ_OP_SEQUENCER);
> +    pnv_spi_xscom_write(qts, chip, SPI_XMIT_DATA_REG, READ_OP_TDR_DATA);
> +    pnv_spi_xscom_write(qts, chip, SPI_XMIT_DATA_REG, 0);
> +    /* Read 5*8 bytes from SEEPROM at 0x100 */
> +    uint64_t rdr_val = pnv_spi_xscom_read(qts, chip, SPI_RCV_DATA_REG);
> +    g_test_message("RDR READ = 0x%lx", rdr_val);
> +    rdr_val = pnv_spi_xscom_read(qts, chip, SPI_RCV_DATA_REG);
> +    rdr_val = pnv_spi_xscom_read(qts, chip, SPI_RCV_DATA_REG);
> +    rdr_val = pnv_spi_xscom_read(qts, chip, SPI_RCV_DATA_REG);
> +    rdr_val = pnv_spi_xscom_read(qts, chip, SPI_RCV_DATA_REG);
> +    g_test_message("RDR READ = 0x%lx", rdr_val);
> +
> +    /* SPI transactions to SEEPROM to write to SEEPROM image */
> +    pnv_spi_xscom_write(qts, chip, SPI_CTR_CFG_REG, WRITE_OP_COUNTER_CONFIG);
> +    /* Set Write Enable Latch bit of status0 register */
> +    pnv_spi_xscom_write(qts, chip, SPI_SEQ_OP_REG, WRITE_OP_SEQUENCER);
> +    pnv_spi_xscom_write(qts, chip, SPI_XMIT_DATA_REG, WRITE_OP_WREN);
> +    /* write 8 bytes to SEEPROM at 0x100 */
> +    pnv_spi_xscom_write(qts, chip, SPI_SEQ_OP_REG, WRITE_OP_SEQUENCER);
> +    pnv_spi_xscom_write(qts, chip, SPI_XMIT_DATA_REG, WRITE_OP_TDR_DATA);
> +}
> +
> +static void test_spi_seeprom(const void *data)
> +{
> +    const PnvChip *chip = data;
> +    QTestState *qts = NULL;
> +    g_autofree char *tmp_path = NULL;
> +    int ret;
> +    int fd;
> +
> +    /* Create a temporary raw image */
> +    fd = g_file_open_tmp("qtest-seeprom-XXXXXX", &tmp_path, NULL);
> +    g_assert(fd >= 0);
> +    ret = ftruncate(fd, FLASH_SIZE);
> +    g_assert(ret == 0);
> +    close(fd);
> +
> +    qts = qtest_initf("-m 2G -machine powernv10 -smp 2,cores=2,"
> +                      "threads=1 -accel tcg,thread=single -nographic "
> +                      "-blockdev node-name=pib_spic2,driver=file,"
> +                      "filename=%s -device 25csm04,bus=pnv-spi-bus.2,cs=0,"
> +                      "drive=pib_spic2", tmp_path);
> +    spi_seeprom_transaction(qts, chip);
> +    qtest_quit(qts);
> +    unlink(tmp_path);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    g_test_init(&argc, &argv, NULL);
> +    char *tname = g_strdup_printf("pnv-xscom/spi-seeprom/%s",
> +            pnv_chips[3].cpu_model);
> +    qtest_add_data_func(tname, &pnv_chips[3], test_spi_seeprom);
> +    g_free(tname);
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


