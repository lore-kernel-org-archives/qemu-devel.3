Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C828FC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 14:46:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryuui-0002UW-Bo; Mon, 22 Apr 2024 10:45:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=jzPN=L3=kaod.org=clg@ozlabs.org>)
 id 1ryuug-0002UG-JO; Mon, 22 Apr 2024 10:44:58 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=jzPN=L3=kaod.org=clg@ozlabs.org>)
 id 1ryuub-00034r-FC; Mon, 22 Apr 2024 10:44:58 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4VNShG6lJNz4wyw;
 Tue, 23 Apr 2024 00:44:46 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4VNShB5HScz4wcC;
 Tue, 23 Apr 2024 00:44:42 +1000 (AEST)
Message-ID: <c23a36b3-3591-4578-8739-9e8036364da5@kaod.org>
Date: Mon, 22 Apr 2024 16:44:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] hw/misc: Microchip's 25CSM04 SEEPROM model
To: Chalapathi V <chalapathi.v@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 calebs@us.ibm.com, chalapathi.v@ibm.com, saif.abrar@linux.vnet.ibm.com,
 dantan@us.ibm.com
References: <20240409175700.27535-1-chalapathi.v@linux.ibm.com>
 <20240409175700.27535-5-chalapathi.v@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240409175700.27535-5-chalapathi.v@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=jzPN=L3=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.248, RCVD_IN_DNSWL_MED=-2.3,
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

Hello Chalapathi

On 4/9/24 19:56, Chalapathi V wrote:
> This commit implements a Serial EEPROM utilizing the Serial Peripheral
> Interface (SPI) compatible bus.
> Currently implemented SEEPROM is Microchip's 25CSM04 which provides 4 Mbits
> of Serial EEPROM utilizing the Serial Peripheral Interface (SPI) compatible
> bus. The device is organized as 524288 bytes of 8 bits each (512Kbyte) and
> is optimized for use in consumer and industrial applications where reliable
> and dependable nonvolatile memory storage is essential.
> 
> This seeprom device is created from a parent "ssi-peripheral".


Can the hw/block/m25p80c model be extented instead ?


Thanks,

C.




> 
> Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
> ---
>   include/hw/misc/seeprom_25csm04.h |  48 ++
>   hw/misc/seeprom_25csm04.c         | 780 ++++++++++++++++++++++++++++++
>   hw/misc/Kconfig                   |   3 +
>   hw/misc/meson.build               |   1 +
>   hw/ppc/Kconfig                    |   1 +
>   5 files changed, 833 insertions(+)
>   create mode 100644 include/hw/misc/seeprom_25csm04.h
>   create mode 100644 hw/misc/seeprom_25csm04.c
> 
> diff --git a/include/hw/misc/seeprom_25csm04.h b/include/hw/misc/seeprom_25csm04.h
> new file mode 100644
> index 0000000000..0343530354
> --- /dev/null
> +++ b/include/hw/misc/seeprom_25csm04.h
> @@ -0,0 +1,48 @@
> +/*
> + * 25CSM04 Serial EEPROM model
> + *
> + * Copyright (c) 2024, IBM Corporation.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * The Microchip Technology Inc. 25CSM04 provides 4 Mbits of Serial EEPROM
> + * utilizing the Serial Peripheral Interface (SPI) compatible bus. The device
> + * is organized as 524288 bytes of 8 bits each (512Kbyte) and is optimized
> + * for use in consumer and industrial applications where reliable and
> + * dependable nonvolatile memory storage is essential
> + */
> +
> +#ifndef SEEPROM_25CSM04_H
> +#define SEEPROM_25CSM04_H
> +
> +#include "hw/ssi/ssi.h"
> +#include "qom/object.h"
> +
> +#define TYPE_SEEPROM_25CSM04 "seeprom-25csm04"
> +
> +OBJECT_DECLARE_SIMPLE_TYPE(SeepromCsm04, SEEPROM_25CSM04)
> +
> +typedef struct SeepromCsm04 {
> +    SSIPeripheral parent_object;
> +
> +    char        *file;
> +    char        *file_name;
> +    uint8_t     opcode;
> +    uint32_t    addr;
> +    uint8_t     rd_state;
> +    bool        locked;
> +    bool        command_byte;
> +    /* device registers */
> +    uint8_t     status0;
> +    uint8_t     status1;
> +    uint8_t     dsn[16];
> +    uint8_t     uplid[256];
> +    uint8_t     mpr[8];
> +    uint8_t     idr[5];
> +} SeepromCsm04;
> +
> +uint32_t seeprom_transfer(SSIPeripheral *ss, uint32_t tx);
> +void seeprom_realize(SSIPeripheral *dev, Error **errp);
> +bool compute_addr(SeepromCsm04 *s, uint32_t tx);
> +bool validate_addr(SeepromCsm04 *s);
> +#endif /* PPC_PNV_SPI_SEEPROM_H */
> diff --git a/hw/misc/seeprom_25csm04.c b/hw/misc/seeprom_25csm04.c
> new file mode 100644
> index 0000000000..45df66e4b0
> --- /dev/null
> +++ b/hw/misc/seeprom_25csm04.c
> @@ -0,0 +1,780 @@
> +/*
> + * 25CSM04 Serial EEPROM model
> + *
> + * Copyright (c) 2024, IBM Corporation.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "hw/misc/seeprom_25csm04.h"
> +#include "hw/qdev-properties.h"
> +#include "qemu/datadir.h"
> +#include <math.h>
> +
> +#define SPI_DEBUG(x)
> +
> +/*
> + * 2-byte STATUS register which is a combination of six nonvolatile bits of
> + * EEPROM and five volatile latches.
> + *
> + * status 0:
> + * bit 7 WPEN: Write-Protect Enable bit
> + * 1 = Write-Protect pin is enabled, 0 = Write-Protect pin is ignored
> + *
> + * bit 3-2 BP<1:0>: Block Protection bits
> + * 00 = No array write protection
> + * 01 = Upper quarter memory array protection
> + * 10 = Upper half memory array protection
> + * 11 = Entire memory array protection
> + *
> + * bit 1 WEL: Write Enable Latch bit
> + * 1 = WREN has been executed and device is enabled for writing
> + * 0 = Device is not write-enabled
> + *
> + * bit 0 RDY/BSY: Ready/Busy Status Latch bit
> + * 1 = Device is busy with an internal write cycle
> + * 0 = Device is ready for a new sequence
> + */
> +#define STATUS0_WPEN        0x7
> +#define STATUS0_BP          0x2
> +#define STATUS0_WEL         0x1
> +#define STATUS0_BUSY        0x0
> +
> +/*
> + * status 1:
> + * bit 7 WPM: Write Protection Mode bit(1)
> + * 1 = Enhanced Write Protection mode selected (factory default)
> + * 0 = Legacy Write Protection mode selected
> + *
> + * bit 6 ECS: Error Correction State Latch bit
> + * 1 = The previously executed read sequence did require the ECC
> + * 0 = The previous executed read sequence did not require the ECC
> + *
> + * bit 5 FMPC: Freeze Memory Protection Configuration bit(2)
> + * 1 = Memory Partition registers and write protection mode are permanently
> + *     frozen and cannot be modified
> + * 0 = Memory Partition registers and write protection mode are not frozen
> + *     and are modifiable
> + *
> + * bit 4 PREL: Partition Register Write Enable Latch bit
> + * 1 = PRWE has been executed and WMPR, FRZR and PPAB instructions are enabled
> + * 0 = WMPR, FRZR and PPAB instructions are disabled
> + *
> + * bit 3 PABP: Partition Address Boundary Protection bit
> + * 1 = Partition Address Endpoints set in Memory Partition registers
> + *     cannot be modified
> + * 0 = Partition Address Endpoints set in Memory Partition registers
> + *     are modifiable
> + *
> + * bit 0 RDY/BSY: Ready/Busy Status Latch bit
> + * 1 = Device is busy with an internal write cycle
> + * 0 = Device is ready for a new sequence
> + */
> +#define STATUS1_WPM             0x7
> +#define STATUS1_ECS             0x6
> +#define STATUS1_FMPC            0x5
> +#define STATUS1_PREL            0x4
> +#define STATUS1_PABP            0x3
> +#define STATUS1_BUSY            0x0
> +
> +/*
> + * MEMORY PARTITION REGISTERS
> + * Note 1: The MPR cannot be written if the FMPC bit has been set.
> + *      2: The Partition Endpoint Address bits cannot be written if the PABP
> + *         bit has been set.
> + *
> + * bits 7-6 PB<1:0>: Partition Behavior bits(1)
> + * 00 = Partition is open and writing is permitted
> + *      factory default is unprotected.
> + * 01 = Partition is always write-protected but can be reversed at a later
> + *      time (software write-protected).
> + * 10 = Partition is write-protected only when WP pin is asserted
> + *      (hardware write-protected).
> + * 11 = Partition is software write-protected and MPR is permanently locked
> + *
> + * bit 5-0 A<18:13>: Partition Endpoint Address bits(1, 2)
> + * 000000 = Endpoint address of partition is set to 01FFFh.
> + * 000001 = Endpoint address of partition is set to 03FFFh.
> + * ----
> + * 111110 = Endpoint address of partition is set to 7DFFFh.
> + * 111111 = Endpoint address of partition is set to 7FFFFh.
> + */
> +#define MPR_PB                  0x6
> +#define MPR_PEA                 0x5
> +
> +/* INSTRUCTION SET FOR 25CSM04 */
> +#define RDSR        0x05
> +#define WRBP        0x08
> +#define WREN        0x06
> +#define WRDI        0x04
> +#define WRSR        0x01
> +#define READ        0x03
> +#define WRITE       0x02
> +#define RDEX_CHLK   0x83
> +#define WREX_LOCK   0x82
> +#define RMPR        0x31
> +#define PRWE        0x07
> +#define PRWD        0x0A
> +#define WMPR        0x32
> +#define PPAB        0x34
> +#define FRZR        0x37
> +#define SPID        0x9F
> +#define SRST        0x7C
> +
> +/* READ FSM state */
> +#define ST_IDLE     0
> +#define ST_READ     1
> +#define ST_SEC_READ 2
> +
> +#define DATA_LEN 4
> +
> +uint32_t seeprom_transfer(SSIPeripheral *ss, uint32_t tx)
> +{
> +    SeepromCsm04 *s = SEEPROM_25CSM04(ss);
> +    uint16_t idx;
> +    FILE *f;
> +    bool status0_busy;
> +    bool status1_busy;
> +    uint32_t rx = -1;
> +    uint32_t *buf = NULL;
> +    bool failed = false;
> +
> +    buf = g_malloc0(sizeof(uint32_t));
> +    SPI_DEBUG(qemu_log("Received SPI request, tx = 0x%x\n", tx));
> +    if (s->command_byte) {
> +        s->opcode = tx >> 24;
> +        SPI_DEBUG(qemu_log("Command Opcode (0x%x)\n", s->opcode));
> +        /*
> +         * Check if device is busy with internal write cycle, During this
> +         * time, only the Read STATUS Register (RDSR) and the Write Ready/Busy
> +         * Poll (WRBP) instructions will be executed by the device.
> +         */
> +        status0_busy = extract8(s->status0, STATUS0_BUSY, 1);
> +        status1_busy = extract8(s->status1, STATUS1_BUSY, 1);
> +        if (((status0_busy == 1) || (status1_busy == 1)) &&
> +            ((s->opcode != RDSR) || (s->opcode != WRBP))) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "Busy with internal write Cycle, "
> +                           "opcode(0x%x) not executed\n", s->opcode);
> +            return rx;
> +        }
> +        /* For a new command sequence compute Address */
> +        failed = compute_addr(s, tx);
> +        /*
> +         * Address computation failed, nothing to do further, just send
> +         * response and return from here.
> +         */
> +        if (failed) {
> +            return tx;
> +        }
> +    }
> +
> +    switch (s->opcode) {
> +    case READ:
> +        if (!s->command_byte) {
> +            SPI_DEBUG(qemu_log("READ(0x%x), addr(0x%x)\n",
> +                          s->opcode, s->addr));
> +            s->rd_state = ST_READ;
> +            if (s->file) {
> +                f = fopen(s->file, "rb+");
> +                if (f) {
> +                    if (!fseek(f, s->addr, SEEK_SET)) {
> +                        if (fread(buf, sizeof(uint32_t), 1, f) == 1) {
> +                            SPI_DEBUG(qemu_log("Read 4 bytes from seeprom\n"));
> +                            rx = *buf;
> +                        } else {
> +                            if (ferror(f)) {
> +                                SPI_DEBUG(qemu_log("Error reading seeprom\n"));
> +                            }
> +                        }
> +                    }
> +                }
> +                fclose(f);
> +            }
> +            s->addr = (s->addr & 0x7FFFF) + DATA_LEN;
> +        }
> +        break;
> +
> +    case RDSR:
> +        SPI_DEBUG(qemu_log("READ Status Register - RDSR(0x%x)\n",
> +                    s->opcode));
> +        rx = 0;
> +        rx = rx | (s->status0 << 24);
> +        rx = rx | (s->status1 << 16);
> +        break;
> +
> +    case WRBP:
> +        SPI_DEBUG(qemu_log("Write Ready/Busy Poll - WRBP(0x%x)\n",
> +                    s->opcode));
> +        status0_busy = extract8(s->status0, STATUS0_BUSY, 1);
> +        status1_busy = extract8(s->status1, STATUS1_BUSY, 1);
> +        rx = 0;
> +        if ((status0_busy == 1) || (status1_busy == 1)) {
> +            rx = rx | (0xFF << 24);
> +        }
> +        break;
> +
> +    case WREN:
> +        SPI_DEBUG(qemu_log("Set Write Enable Latch (WEL) WREN(0x%x)\n",
> +                    s->opcode));
> +        s->status0 = deposit32(s->status0, STATUS0_WEL, 1, 1);
> +        break;
> +
> +    case WRDI:
> +        SPI_DEBUG(qemu_log("Reset Write Enable Latch (WEL) WRDI(0x%x)\n",
> +                    s->opcode));
> +        s->status0 = deposit32(s->status0, STATUS0_WEL, 1, 0);
> +        break;
> +
> +    case WRSR:
> +        SPI_DEBUG(qemu_log("Write STATUS Register WRSR(0x%x)\n",
> +                    s->opcode));
> +        s->status0 = deposit32(s->status0, STATUS0_WEL, 1, 1);
> +        if (extract8(s->status0, STATUS0_WEL, 1) == 1) {
> +            /* Mask and update status0/1 bytes */
> +            s->status0 = (tx >> 16) & 0x8C;
> +            s->status1 = (tx >> 8) & 0x80;
> +        }
> +        break;
> +
> +    case SPID:
> +        SPI_DEBUG(qemu_log("READ IDENTIFICATION REGISTER, SPID(0x%x)\n",
> +                    s->opcode));
> +        rx = 0;
> +        for (idx = 0; idx < DATA_LEN; idx++) {
> +            rx = (rx << 8) | s->idr[idx];
> +        }
> +        break;
> +
> +    case SRST:
> +        SPI_DEBUG(qemu_log("Software Device Reset, SRST(0x%x)\n",
> +                    s->opcode));
> +        /*
> +         * Note: The SRST instruction cannot interrupt the device while it is
> +         * in a Busy state (Section 6.1.4 Ready/Busy Status Latch).
> +         * This is already taken care of when the command opcode is fetched
> +         *
> +         * 1.2 Device Default State
> +         * 1.2.1 POWER-UP DEFAULT STATE
> +         * The 25CSM04 default state upon power-up consists of:
> +         * - Standby Power mode (CS = HIGH)
> +         * - A high-to-low level transition on CS is required to enter the
> +         *   active state
> +         * - WEL bit in the STATUS register = 0
> +         * - ECS bit in the STATUS register = 0
> +         * - PREL bit in the STATUS register = 0
> +         * - Ready/Busy (RDY/BUSY) bit in the STATUS register = 0, indicating
> +         *   the device is ready to accept a new instruction.
> +         */
> +        s->status0 = deposit32(s->status0, STATUS0_WEL, 1, 0);
> +        s->status1 = deposit32(s->status1, STATUS1_ECS, 1, 0);
> +        s->status1 = deposit32(s->status1, STATUS1_PREL, 1, 0);
> +        s->status0 = deposit32(s->status0, STATUS0_BUSY, 1, 0);
> +        s->status1 = deposit32(s->status1, STATUS1_BUSY, 1, 0);
> +        break;
> +
> +    case WRITE:
> +        if (!s->command_byte) {
> +            SPI_DEBUG(qemu_log("WRITE(0x%x), addr(0x%x)\n",
> +                        s->opcode, s->addr));
> +            if (extract8(s->status0, STATUS0_WEL, 1) != 1) {
> +                qemu_log_mask(LOG_GUEST_ERROR, "Device is not Write Enabled, "
> +                                "ignoring WRITE instruction\n");
> +                break;
> +            }
> +            /* Write into SEEPROM Array */
> +            SPI_DEBUG(qemu_log("Write sequence\n"));
> +            buf = &tx;
> +            if (s->file) {
> +                f = fopen(s->file, "rb+");
> +                if (f) {
> +                    if (!fseek(f, s->addr, SEEK_SET)) {
> +                        if (fwrite(buf, sizeof(uint32_t), 1, f) == 1) {
> +                            SPI_DEBUG(qemu_log("Write 4 bytes to seeprom\n"));
> +                        } else {
> +                            SPI_DEBUG(qemu_log("Failed to write seeprom\n"));
> +                        }
> +                    }
> +                }
> +                fclose(f);
> +            }
> +            /* Increase offset in the page */
> +            s->addr += DATA_LEN;
> +        }
> +        break;
> +
> +    case RMPR:
> +        if (!s->command_byte) {
> +            /*
> +             * The address for each Memory Partition register is embedded into
> +             * the first address byte sent to the device,in bit positions A18
> +             * through A16.
> +             */
> +            SPI_DEBUG(qemu_log("RMPR(0x%x) for MPR[%d]\n", s->opcode,
> +                      extract8(s->addr, 16, 2)));
> +            rx = 0;
> +            rx = rx | (s->mpr[extract8(s->addr, 16, 2)] << 24);
> +        }
> +        break;
> +
> +    case PRWE:
> +        SPI_DEBUG(qemu_log("Set Memory Partition Write Enable Latch "
> +                    "PRWE(0x%x)\n", s->opcode));
> +        s->status1 = deposit32(s->status1, STATUS1_PREL, 1, 1);
> +        break;
> +
> +    case PRWD:
> +        SPI_DEBUG(qemu_log("Reset Memory Partition Write Enable Latch "
> +                    "PRWD(0x%x)\n", s->opcode));
> +        s->status1 = deposit32(s->status1, STATUS1_PREL, 1, 0);
> +        break;
> +
> +    case WMPR:
> +        if (!s->command_byte) {
> +            /*
> +             * The address for each Memory Partition register is embedded into
> +             * the first address byte sent to the device,in bit positions A18
> +             * through A16.
> +             */
> +            SPI_DEBUG(qemu_log("Write Memory Partition Register[%d] "
> +                               "WMPR(0x%x)\n",
> +                               extract8(s->addr, 16, 2), s->opcode));
> +            /*
> +             * Once the WEL and PREL bits in the STATUS register have been
> +             * set to 1, the Memory Partition registers can be programmed
> +             * provided that the FMPC bit in the STATUS register has not
> +             * already been set to a logic 1.
> +             */
> +            if ((extract8(s->status0, STATUS0_WEL, 1) != 1) ||
> +                (extract8(s->status1, STATUS1_PREL, 1) != 1) ||
> +                (extract8(s->status1, STATUS1_FMPC, 1) == 1)) {
> +                qemu_log_mask(LOG_GUEST_ERROR, "ignoring write to MPR\n");
> +                break;
> +            }
> +            if (extract8(s->status1, STATUS1_PABP, 1) == 1) {
> +                /* Partition Address Boundaries Protected */
> +                s->mpr[extract8(s->addr, 16, 2)] =
> +                    ((tx >> 30) & 0x3);
> +            } else {
> +                s->mpr[extract8(s->addr, 16, 2)] = (tx >> 24) & 0xFF;
> +            }
> +            s->status0 = deposit32(s->status0, STATUS0_WEL, 1, 0);
> +            s->status1 = deposit32(s->status1, STATUS1_PREL, 1, 0);
> +        }
> +        break;
> +
> +    case PPAB:
> +        if (!s->command_byte) {
> +            SPI_DEBUG(qemu_log("Protect Partition Address Boundaries"
> +                                "PPAB(0x%x)\n", s->opcode));
> +            if ((extract8(s->status0, STATUS0_WEL, 1) != 1) ||
> +                (extract8(s->status1, STATUS1_PREL, 1) != 1) ||
> +                (extract8(s->status1, STATUS1_FMPC, 1) == 1)) {
> +                qemu_log_mask(LOG_GUEST_ERROR, "Ignoring PPAB command\n");
> +                break;
> +            }
> +            tx = (tx >> 24) & 0xFF;
> +            if (tx == 0xFF) {
> +                s->status1 = deposit32(s->status1,
> +                                                STATUS1_PABP, 1, 1);
> +            } else if (tx == 0x0) {
> +                s->status1 = deposit32(s->status1,
> +                                                STATUS1_PABP, 1, 0);
> +            } else {
> +                qemu_log_mask(LOG_GUEST_ERROR, "Incorrect data byte(0x%x), "
> +                                "should be 0x0 or 0xFF\n", tx);
> +            }
> +            s->status0 = deposit32(s->status0, STATUS0_WEL, 1, 0);
> +            s->status1 = deposit32(s->status1, STATUS1_PREL, 1, 0);
> +        }
> +        break;
> +
> +    case FRZR:
> +        if (!s->command_byte) {
> +            SPI_DEBUG(qemu_log("Freeze Memory Protection Configuration "
> +                                    "FRZR(0x%x)\n", s->opcode));
> +            if ((extract8(s->status0, STATUS0_WEL, 1) != 1) ||
> +                (extract8(s->status1, STATUS1_PREL, 1) != 1) ||
> +                (extract8(s->status1, STATUS1_FMPC, 1) == 1)) {
> +                qemu_log_mask(LOG_GUEST_ERROR, "ignoring FRZR command\n");
> +                break;
> +            }
> +            tx = (tx >> 24) & 0xFF;
> +            if (tx == 0xD2) {
> +                s->status1 = deposit32(s->status1,
> +                                                STATUS1_FMPC, 1, 1);
> +            } else {
> +                qemu_log_mask(LOG_GUEST_ERROR, "Invalid confirmation data "
> +                                "byte(0x%x), expecting 0xD2", tx);
> +            }
> +            s->status0 = deposit32(s->status0, STATUS0_WEL, 1, 0);
> +            s->status1 = deposit32(s->status1, STATUS1_PREL, 1, 0);
> +        }
> +        break;
> +
> +    case RDEX_CHLK:
> +        if (!s->command_byte) {
> +            SPI_DEBUG(qemu_log("OPCODE = (0x%x)\n", s->opcode));
> +            rx = 0;
> +            /* Address bit 10 must be 0 to read security register */
> +            if (extract8(s->addr, 10, 1) == 0) {
> +                uint16_t sidx;
> +                /* RDEX */
> +                s->rd_state = ST_SEC_READ;
> +                for (idx = 0; idx < DATA_LEN; idx++) {
> +                    sidx = s->addr & 0x1FF;
> +                    if (sidx <= 0xFF) {
> +                        rx = (rx << 8) | s->dsn[sidx];
> +                    } else {
> +                        rx = (rx << 8) | s->uplid[sidx & 0xFF];
> +                    }
> +                    s->addr = (s->addr & ~0x1FF) | ((s->addr + 1) & 0x1FF);
> +                }
> +            } else {
> +                /* CHLK */
> +                if (s->locked) {
> +                    rx = rx | (0x01 << 24);
> +                }
> +            }
> +        }
> +        break;
> +
> +    case WREX_LOCK:
> +        if (!s->command_byte) {
> +            SPI_DEBUG(qemu_log("OPCODE = (0x%x)\n", s->opcode));
> +            if (s->locked == true) {
> +                qemu_log_mask(LOG_GUEST_ERROR, "Device is already Locked, "
> +                                "command is ignored\n");
> +                break;
> +            }
> +            if (extract8(s->status0, STATUS0_WEL, 1) != 1) {
> +                qemu_log_mask(LOG_GUEST_ERROR, "Device is not Write Enabled, "
> +                                "command is ignored\n");
> +                break;
> +            }
> +            /* Address bit 10 must be 0 to write to security register */
> +            if (extract8(s->addr, 10, 1) == 0) {
> +                /* WREX */
> +                for (idx = 0; idx < DATA_LEN; idx++) {
> +                    /*
> +                     * The Device Serial Number is factory programmed and
> +                     * read-only.
> +                     */
> +                    s->uplid[extract8(s->addr, 0, 8)] =
> +                                                (tx >> (24 - idx * 8)) & 0xFF;
> +                    /* Increase address with the page, and let it rollover*/
> +                    s->addr = (s->addr & ~0xFF) | ((s->addr + 1) & 0xFF);
> +                }
> +            } else {
> +                /*
> +                 * LOCK (82h) instruction is clocked in on the  SI line,
> +                 * followed by a fake address where  bits A[23:0] are don't
> +                 * care bits with the exception that bit A10 must be set to 1.
> +                 * Finally, a confirmation data byte of xxxx_xx1xb  is  sent
> +                 */
> +                if (((tx >> 24) & 0x02) == 0x2) {
> +                    s->locked = true;
> +                }
> +            }
> +        }
> +        break;
> +
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR, "Invalid instruction(0x%x)\n",
> +                        s->opcode);
> +    } /* end of switch */
> +    if (s->command_byte) {
> +        s->command_byte = false;
> +    }
> +    return rx;
> +}
> +
> +/*
> + * Method : compute_addr
> + * This method is used to compute address and data offset for supported
> + * opcodes and only invoked when a valid new command sequence starts aka
> + * first is 1.
> + */
> +bool compute_addr(SeepromCsm04 *s, uint32_t tx)
> +{
> +    bool addr_wr_protected = false;
> +    bool failed = false;
> +
> +    switch (s->opcode) {
> +    case READ:
> +    case WRITE:
> +        SPI_DEBUG(qemu_log("Compute address and payload buffer data offset "
> +                  "for %s\n", (s->opcode == READ) ? "READ" : "WRITE"));
> +        /*
> +         * Fetch address from size 24 bit from offset 1,2,3 of payload
> +         * and mask of higher 5 bits as valid memory array size is 512KB
> +         */
> +        s->addr = tx & 0x7FFFF;
> +        if (s->opcode == WRITE) {
> +            addr_wr_protected = validate_addr(s);
> +            if (addr_wr_protected) {
> +                qemu_log_mask(LOG_GUEST_ERROR, "SEEPROM Address(0x%x) is Write "
> +                              "protected\n", s->addr);
> +                failed = true;
> +            }
> +        }
> +        break;
> +    case RMPR:
> +    case WMPR:
> +        SPI_DEBUG(qemu_log("Compute MPR address for %s MPR\n",
> +                  (s->opcode == RMPR) ? "READ" : "WRITE"));
> +        /*
> +         * The address for each Memory Partition register is embedded into
> +         * the first address byte sent to the device,in bit positions A18
> +         * through A16.
> +         */
> +        s->addr = tx & 0x70000;
> +        break;
> +
> +    case PPAB:
> +    case FRZR:
> +        SPI_DEBUG(qemu_log("Validate if addr[15:0] is %s\n",
> +                  (s->opcode == PPAB) ? "0xCCFF for PPAB" :
> +                                               "0xAA40 for FRZR"));
> +        /* Address bits A23-A16 are ignored. */
> +        s->addr = tx & 0xFFFF;
> +        /* Address bits A15-A0 must be set to CC55h. */
> +        if ((s->opcode == PPAB) && s->addr != 0xCC55) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "Invalid addr[15:0] = 0x%x sent for "
> +                          "PPAB\n", s->addr);
> +            failed = true;
> +        }
> +        /* Address bits A15-A0 must be set to AA40h. */
> +        if ((s->opcode == FRZR) && s->addr != 0xAA40) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "Invalid addr[15:0] = 0x%x sent for "
> +                          "FRZR\n", s->addr);
> +            failed = true;
> +        }
> +        break;
> +
> +    case RDEX_CHLK:
> +    case WREX_LOCK:
> +        SPI_DEBUG(qemu_log("Compute Address for Security reg command\n"));
> +        /*
> +         * RDEX : A[23:9] are don't care bits, except A10 which must be a
> +         *        logic 0.
> +         * WREX : A[23:9] are don't care bits, except A10 which must be a
> +         *        logic 0 and A8 which must be a logic 1 to address the
> +         *        second Security register byte that is user programmable.
> +         * CHLK : A[23:0] are don't care bits, except A10 which must be a
> +         *        logic 1.
> +         * LOCK : A[23:0] are don't care bits, except A10 which must be a
> +         *        logic 1.
> +         */
> +        s->addr = tx & 0x5FF;
> +        SPI_DEBUG(qemu_log("Received Command %s\n",
> +                  (s->opcode == RDEX_CHLK)
> +                   ? (extract32(s->addr, 10, 1) ?
> +                      "CHLK : Check Lock Status of Security Register" :
> +                      "RDEX : Read from the Security Register")
> +                   : (extract32(s->addr, 10, 1) ?
> +                      "LOCK : Lock the Security Register (permanent)" :
> +                      "WREX : Write to the Security Register")));
> +        if ((s->opcode == WREX_LOCK) &&
> +            (extract32(s->addr, 10, 1) == 0)) {
> +            /*
> +             * WREX
> +             * In Legacy Write Protection mode, the Security register is
> +             * write-protected when the BP <1:0> bits (bits 3-2 byte0) of
> +             * the STATUS register = 11.
> +             */
> +            if (extract8(s->status1, STATUS1_WPM, 1) == 0) {
> +                addr_wr_protected = validate_addr(s);
> +            } else {
> +                if (extract32(s->addr, 0, 9) <= 0xFF) {
> +                    addr_wr_protected = true;
> +                }
> +            }
> +            if (addr_wr_protected) {
> +                qemu_log_mask(LOG_GUEST_ERROR, "SEEPROM Address(0x%x) is "
> +                              "Write protected\n", s->addr);
> +                failed = true;
> +            }
> +        }
> +        break;
> +    } /* end of switch */
> +    return failed;
> +} /* end of method compute_addr */
> +
> +/*
> + * Method : validate_addr
> + * This method validates whether SEEPROM address is write protected or not
> + */
> +
> +bool validate_addr(SeepromCsm04 *s)
> +{
> +    bool addr_wr_protected = false;
> +    uint8_t mpr_idx = 0;
> +
> +    if (extract8(s->status1, STATUS1_WPM, 1) == 1) {
> +        /*
> +         * enhanced write protection
> +         * Memory partition register Bit5  through  bit0 contain the Partition
> +         * Endpoint Address of A18:A13, where A12:A0 are a logic "1". For
> +         * example, if the first partition of the memory array is desired to
> +         * stop after 128-Kbit of memory, that end point address is 03FFFh. The
> +         * corresponding A18:A13 address bits to be loaded into MPR0 are
> +         * therefore 000001b. The eight MPRs are each decoded sequentially by
> +         * the device, starting with MPR0. Each MPR should be set to a
> +         * Partition Endpoint Address greater than the ending address of the
> +         * previous MPR. If a higher order MPR sets a Partition Endpoint Address
> +         * less than or equal to the ending address of a lower order MPR, that
> +         * higher order MPR is ignored and no protection is set by it's
> +         * contents.
> +         */
> +        for (mpr_idx = 0; mpr_idx < 8; mpr_idx++) {
> +            if ((extract32(s->addr, 13, 6)) <=
> +                (extract8(s->mpr[mpr_idx], MPR_PEA, 1))) {
> +                switch (extract8(s->mpr[mpr_idx], MPR_PB, 2)) {
> +                case 0:
> +                    /*
> +                     * 0b00 = Partition is open and writing is permitted
> +                     * (factory default is unprotected).
> +                     */
> +                    addr_wr_protected = false;
> +                    break;
> +                case 1:
> +                    /*
> +                     * 0b01 = Partition is always write-protected but can be
> +                     * reversed at a later time (software write-protected).
> +                     */
> +                    addr_wr_protected = true;
> +                    break;
> +                case 2:
> +                    /*
> +                     * 0b10 = Partition is write-protected only when WP pin is
> +                     * asserted (hardware write-protected).
> +                     */
> +                    addr_wr_protected = false;
> +                    break;
> +                case 3:
> +                    /*
> +                     * 0b11 = Partition is software write-protected and Memory
> +                     * Partition register is permanently locked.
> +                     */
> +                    addr_wr_protected = true;
> +                    break;
> +                } /* end of switch */
> +                break; /* break from for loop. */
> +            }
> +        } /* end of for loop */
> +    } else {
> +        /* Legacy write protection mode */
> +        switch (extract8(s->status0, STATUS0_BP, 2)) {
> +        case 0:
> +            /*
> +             * 0b00 = No array write protection
> +             * EEPROM None
> +             * Security Register 00000h - 000FFh
> +             */
> +            if ((s->opcode == WREX_LOCK) &&
> +                (extract32(s->addr, 0, 9)  <= 0xFF)) {
> +                addr_wr_protected = true;
> +            }
> +            break;
> +        case 1:
> +            /*
> +             * 0b01 = Upper quarter memory array protection
> +             * EEPROM 60000h - 7FFFFh
> +             * Security Register 00000h - 000FFh
> +             */
> +            if ((s->opcode == WREX_LOCK) &&
> +                (extract32(s->addr, 0, 9)  <= 0xFF)) {
> +                addr_wr_protected = true;
> +            } else if ((s->opcode == WRITE) &&
> +                       (extract32(s->addr, 0, 19)  <= 0x60000)) {
> +                addr_wr_protected = true;
> +            }
> +            break;
> +        case 2:
> +            /*
> +             * 0b10 = Upper half memory array protection
> +             * EEPROM 40000h - 7FFFFh
> +             * Security Register 00000h - 000FFh
> +             */
> +            if ((s->opcode == WREX_LOCK) &&
> +                (extract32(s->addr, 0, 9)  <= 0xFF)) {
> +                addr_wr_protected = true;
> +            } else if ((s->opcode == WRITE) &&
> +                       (extract32(s->addr, 0, 19)  <= 0x40000)) {
> +                addr_wr_protected = true;
> +            }
> +            break;
> +        case 3:
> +            /*
> +             * 0b11 = Entire memory array protection
> +             * EEPROM 00000h - 7FFFFh
> +             * Security Register 00000h - 001FFh
> +             */
> +            addr_wr_protected = true;
> +            break;
> +        } /* end of switch */
> +    }
> +    return addr_wr_protected;
> +} /* end of validate_addr */
> +
> +
> +static int seeprom_cs(SSIPeripheral *ss, bool select)
> +{
> +    SeepromCsm04 *s = SEEPROM_25CSM04(ss);
> +
> +    if (select) {
> +        s->command_byte = false;
> +        s->rd_state = ST_IDLE;
> +        s->status0 = deposit32(s->status0, STATUS0_WEL, 1, 0);
> +    } else {
> +        s->command_byte = true;
> +    }
> +    return 0;
> +}
> +
> +
> +void seeprom_realize(SSIPeripheral *dev, Error **errp)
> +{
> +    SeepromCsm04 *s = SEEPROM_25CSM04(dev);
> +
> +    s->command_byte = true;
> +    s->rd_state = ST_IDLE;
> +    if (s->file_name) {
> +        s->file = qemu_find_file(QEMU_FILE_TYPE_BIOS, s->file_name);
> +    }
> +}
> +
> +static Property seeprom_props[] = {
> +    DEFINE_PROP_STRING("filename", SeepromCsm04, file_name),
> +    DEFINE_PROP_END_OF_LIST()
> +};
> +
> +static void seeprom_25csm04_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +    SSIPeripheralClass *k = SSI_PERIPHERAL_CLASS(klass);
> +
> +    k->transfer = seeprom_transfer;
> +    k->realize = seeprom_realize;
> +    k->set_cs = seeprom_cs;
> +    k->cs_polarity = SSI_CS_LOW;
> +    device_class_set_props(dc, seeprom_props);
> +
> +    dc->desc = "PowerNV SPI SEEPROM";
> +}
> +
> +static const TypeInfo seeprom_25csm04_info = {
> +    .name          = TYPE_SEEPROM_25CSM04,
> +    .parent        = TYPE_SSI_PERIPHERAL,
> +    .instance_size = sizeof(SeepromCsm04),
> +    .class_init    = seeprom_25csm04_class_init,
> +};
> +
> +static void seeprom_25csm04_register_types(void)
> +{
> +    type_register_static(&seeprom_25csm04_info);
> +}
> +
> +type_init(seeprom_25csm04_register_types);
> diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
> index 1e08785b83..9442cc657d 100644
> --- a/hw/misc/Kconfig
> +++ b/hw/misc/Kconfig
> @@ -38,6 +38,9 @@ config PCA9554
>       bool
>       depends on I2C
>   
> +config SEEPROM_25CSM04
> +    bool
> +
>   config I2C_ECHO
>       bool
>       default y if TEST_DEVICES
> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> index 86596a3888..fd4d646f98 100644
> --- a/hw/misc/meson.build
> +++ b/hw/misc/meson.build
> @@ -3,6 +3,7 @@ system_ss.add(when: 'CONFIG_EDU', if_true: files('edu.c'))
>   system_ss.add(when: 'CONFIG_FW_CFG_DMA', if_true: files('vmcoreinfo.c'))
>   system_ss.add(when: 'CONFIG_ISA_DEBUG', if_true: files('debugexit.c'))
>   system_ss.add(when: 'CONFIG_ISA_TESTDEV', if_true: files('pc-testdev.c'))
> +system_ss.add(when: 'CONFIG_SEEPROM_25CSM04', if_true: files('seeprom_25csm04.c'))
>   system_ss.add(when: 'CONFIG_PCI_TESTDEV', if_true: files('pci-testdev.c'))
>   system_ss.add(when: 'CONFIG_UNIMP', if_true: files('unimp.c'))
>   system_ss.add(when: 'CONFIG_EMPTY_SLOT', if_true: files('empty_slot.c'))
> diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
> index ea1178bd73..6a4803d4ec 100644
> --- a/hw/ppc/Kconfig
> +++ b/hw/ppc/Kconfig
> @@ -36,6 +36,7 @@ config POWERNV
>       select PCA9552
>       select PCA9554
>       select SSI
> +    select SEEPROM_25CSM04
>   
>   config PPC405
>       bool


